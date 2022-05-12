
local require, assert, print, tonumber, tostring = require, assert, print, tonumber, tostring;
local os, string, table 	= os, string, table;
local time 					= os.time;
local format 				= string.format;
local insert, concat 		= table.insert, table.concat;

---@diagnostic disable-next-line
local process 				= process;
local uv 					= require('uv');
local gumbo 				= require('gumbo');
local json 					= require('json');
local docs 					= require('docs');
local http 					= require('coro-http');

local OK 					= 200;
local PARSER_LOCAL_LIMIT 	= 200;
local PRELOAD_FILE_SIZE 	= 500000; --PRELOAD_FILE_SIZE in Sumneko's LLS in bytes
local VERSION 				= 'v0.0.1';
local FOLDER_NAME 			= 'rbxannotations';
local FILE_FORMAT 			= './'..FOLDER_NAME..'/annotation%d.lua';

local build_id				= nil;
local disable_lua_globals 	= true;

local domain 				= {
	main 					= 'https://create.roblox.com';
	reference 				= '/docs/reference/engine';
};

local extra_annotation_urls = {'enums/SelectionBehavior', 'enums/PropertyStatus'};
local supported_categories 	= {classes = 0;datatypes = 0;enums = 0;globals = 0;libraries = 0;};
local includes_variable 	= {classes = 0;datatypes = 0;enums = 0;};
local parser_linker 		= {
	ClassReference 			= docs.generateClass;
	DatatypeReference 		= docs.generateDatatype;
	EnumReference 			= docs.generateEnum;
	GlobalReference 		= docs.generateGlobal;
	LibraryReference 		= docs.generateLibrary;
};

---@param url string
---@return string
---Grabs the body of the page at `url`, assertion of failure of getting the body
local getBodyAt = function(url)
	local res, body = http.request('GET', url);
	assert(res.code == OK, res.reason);
	return body;
end;

---@param path string
---@param body string
---Writes the following `body` to the file at `path`
local writeFile = function(path, body)
	uv.fs_open(path, 'w', tonumber('777', 8), function(err, fd)
		assert(not err, err);
		uv.fs_write(fd, body, 0, function(err_a, bytes)
			assert(not err_a, err_a);
			uv.fs_close(fd, function(err_b)
				assert(not err_b, err_b);
				uv.fs_chown(path, process.env.SUDO_UID, process.env.SUDO_GID, function(err_d, success)
					assert(not err_d, err_d);
					assert(success, 'writeFile failed to set file permissions');
				end);
			end);
		end);
	end);
end;

---@param stream table<number, string>
---@return number StreamSizeBytes
---Returns the size of the stream in bytes
local getStreamSize = function(stream)
	local size = 0;
	local n = #stream;
	for i = 1, n do
		size = size + stream[i]:len();
	end;
	return size;
end;

---@param url string
---@return string
---Returns the class json at the page `url`
local getClassJSON = function(url)
	return getBodyAt(url):match('<script id="__NEXT_DATA__" type="application/json">(.*)</script>');
end;

---@param api table<string, any>
---@return string AnnotationDocumentation
---Generates the documentation for an API reference object, which is received and decoded from the api page
---
---Note: If `disable_lua_globals` is true, documentation for `LuaGlobals` will be nil
local generateDocumentation = function(api)
	local __typename = api.__typename;
	if (__typename) then
		local parser = parser_linker[__typename];
		if (parser) then
			return disable_lua_globals == false or (disable_lua_globals == true and (__typename ~= 'GlobalReference' or __typename == 'GlobalReference' and api.id ~= 'LuaGlobals')) and parser(api) or nil;
		else print('rbx-types: new api reference type detected: '..__typename);
		end;
	else print('rbx-types: api reference has no __typename');
	end;
end;

---@param category string
---@param name string
---@return string GeneratedDocumentation
---Gets the documentation for the specific category and class name while checking for unsupported categories and current build id
local getDocumentation = function(category, name)
	if (supported_categories[category] == nil) then
		print('debug-rbx-types: unsupported category was found: '..category);
	end;
	local url = domain.main..domain.reference..'/'..category..'/'..name;
	local json_string = assert(getClassJSON(url), 'rbx-types: gumbo failed to get class json');
	local data = json.decode(json_string);
	if (build_id == nil) then
		print('debug-rbx-types: detected build id ('..(data.buildId or 'unknown')..')');
	end;
	build_id = build_id or data.buildId;
	assert(build_id == data.buildId, 'rbx-types: build version was changed midway during generation, please restart the process');
	return generateDocumentation(data.props.pageProps.data.apiReference);
end;

do
	local body = getBodyAt(domain.main..domain.reference);
	local document = assert(gumbo.parse(body), 'rbx-types: gumbo failed to parse reference html body');
	local links = document.links;
	local n_links = #links;
	local reference_extend = domain.reference..'/';
	local stream = docs.generateDocsStream();
	local size = getStreamSize(stream);
	local annotation_size = size;
	local files = 0;
	local variable_count = 0;
	local loaded = {};
	local now = time();
	print('rbx-types: running version '..VERSION);
	assert(process.env.SUDO_UID, 'debug-rbx-types: sudo uid not found, are you running in sudo?');
	assert(process.env.SUDO_GID, 'debug-rbx-types: sudo gid not found, are you running in sudo?');
	print('debug-rbx-types: creating annotations folder...');
	local success = uv.fs_mkdir('./'..FOLDER_NAME, tonumber('777', 8));
	if (success) then
		assert(uv.fs_chown('./'..FOLDER_NAME, process.env.SUDO_UID, process.env.SUDO_GID), 'rbx-types: failed to set permissions for folder');
	else
		local data = assert(uv.fs_stat('./'..FOLDER_NAME));
		assert(data.type == 'folder' and data.size <= 0, 'rbx-types: annotations folder already exists, please delete or rename the folder to something other than ('..FOLDER_NAME..')');
	end;
	print('debug-rbx-types: generating documentation annotations...');
	for i = 1, n_links do
		local element = links[i];
		local href = element:getAttribute('href');
		local latter_half = href:gsub(reference_extend, '');
		if (href ~= latter_half) then
			local category, name = latter_half:match('([%w%s]+)/([%w%s]+)');
			if (category and name) then
				local class_docs = getDocumentation(category, name);
				if (class_docs) then
					local doc_size = class_docs:len();
					local res = size + doc_size;
					annotation_size = annotation_size + doc_size;
					if (res >= PRELOAD_FILE_SIZE) then
						variable_count, size, files, res = 0, 0, files + 1, doc_size;
						writeFile(format(FILE_FORMAT, files), concat(stream));
						stream = {};
					end;
					if (includes_variable[category]) then
						local resc = variable_count + 1;
						if (resc < PARSER_LOCAL_LIMIT) then
							variable_count = resc;
						elseif (resc >= PARSER_LOCAL_LIMIT) then
							variable_count, size, files, res = 0, 0, files + 1, doc_size;
							writeFile(format(FILE_FORMAT, files), concat(stream));
							stream = {};
						end;
					end;
					size = res;
					loaded[name] = 0;
					insert(stream, class_docs);
				end;
			end;
		end;
	end;
	local n_extras = #extra_annotation_urls;
	for i = 1, n_extras do
		local extender = extra_annotation_urls[i];
		local category, name = extender:match('([%w%s]+)/([%w%s]+)');
		if (category and name and loaded[name] == nil) then
			local class_docs = getDocumentation(category, name);
			if (class_docs) then
				local doc_size = class_docs:len();
				local res = size + doc_size;
				annotation_size = annotation_size + doc_size;
				if (res >= PRELOAD_FILE_SIZE) then
					variable_count, size, files, res = 0, 0, files + 1, doc_size;
					writeFile(format(FILE_FORMAT, files), concat(stream));
					stream = {};
				end;
				if (includes_variable[category]) then
					local resc = variable_count + 1;
					if (resc < PARSER_LOCAL_LIMIT) then
						variable_count = resc;
					elseif (resc >= PARSER_LOCAL_LIMIT) then
						variable_count, size, files, res = 0, 0, files + 1, doc_size;
						writeFile(format(FILE_FORMAT, files), concat(stream));
						stream = {};
					end;
				end;
				size = res;
				loaded[name] = 0;
				insert(stream, class_docs);
			end;
		end;
	end;
	print('debug-rbx-types: generation took '..(time() - now)..'s');
	print('debug-rbx-types: checking for unsupported types...');
	docs.printUnsupportedTypes();
	writeFile(format(FILE_FORMAT, files + 1), concat(stream));
	print('debug-rbx-types: processing complete...');
	print('debug-rbx-types: documentation annotations can be found at "./'..FOLDER_NAME..'"');
	print('debug-rbx-types: stream has a size of '..tostring(annotation_size)..' bytes');
end;
