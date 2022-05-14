
package.path 				= package.path..';./?.lua;./deps/?.lua;./deps/?/init.lua';
local require, assert, print, tonumber, tostring, xpcall = require, assert, print, tonumber, tostring, xpcall;
local string, table 		= string, table;
local format 				= string.format;
local insert, concat 		= table.insert, table.concat;

local process 				= process; ---@diagnostic disable-line
local uv 					= require('uv');
local ffi					= require('ffi');
local json 					= require('json');
local docs 					= require('docs');
local http 					= require('coro-http');

local NANOS_IN_ONE			= 1 * 10^9;
local OK 					= 200;
local PARSER_LOCAL_LIMIT 	= 200;
local PRELOAD_FILE_SIZE 	= 500000; --PRELOAD_FILE_SIZE in Sumneko's LLS in bytes
local VERSION 				= 'v0.0.2';
local FOLDER_NAME 			= 'rbxannotations';
local FILE_FORMAT 			= './'..FOLDER_NAME..'/annotation%d.lua';
local NOTICE_FORMAT			= 'rbx-types: %s';
local ERROR_FORMAT			= 'rbx-types-error: %s';
local WARN_FORMAT			= 'rbx-types-warn: %s';

local build_id				= nil;
local operating_system		= ffi.os;
local disable_lua_globals 	= true;

local domain 				= {
	main 					= 'https://create.roblox.com';
	reference 				= '/docs/reference/engine';
	reference_slash 		= '/docs/reference/engine/';
};

local extra_annotation_urls = {'enums/SelectionBehavior', 'enums/PropertyStatus', 'enums/WrapLayerAutoSkin'};
local supported_categories 	= {classes = 0;datatypes = 0;enums = 0;globals = 0;libraries = 0;};
local includes_variable 	= {classes = 0;enums = 0;};
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
	assert(res.code == OK, 'HTTP GET ('..url..'): '..res.reason);
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
				if (operating_system == 'Linux') then
					uv.fs_chown(path, uv.getuid(), uv.getgid(), function(err_d, success)
						assert(not err_d, err_d);
						assert(success, 'writeFile failed to set file permissions');
					end);
				end;
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
---@return string AnnotationBody
---Generates the annotation body for an API reference object, which is received and decoded from the api page
---
---Note: If `disable_lua_globals` is true, annotation for `LuaGlobals` will be nil
local generateAnnotation = function(api)
	local __typename = assert(api.__typename, 'api reference is missing "__typename"');
	local parser = parser_linker[__typename];
	if (parser) then
		return disable_lua_globals == false or (disable_lua_globals == true and (__typename ~= 'GlobalReference' or __typename == 'GlobalReference' and api.id ~= 'LuaGlobals')) and parser(api) or nil;
	else print(format(NOTICE_FORMAT, 'new api reference type detected: '..__typename));
	end;
end;

---@param category string
---@param name string
---@return string AnnotationBody
---Gets the EmmyLua annotation style body for the specific category and class name while checking for unsupported categories and current build id
local getAnnotationByReference = function(category, name)
	if (supported_categories[category] == nil) then
		print(format(WARN_FORMAT, 'unsupported category ('..category..')'));
	end;
	local url = domain.main..domain.reference_slash..category..'/'..name;
	local json_string = assert(getClassJSON(url), 'class json could not be found');
	local data = json.decode(json_string);
	if (build_id == nil) then
		print(format(NOTICE_FORMAT, 'detected build id ('..(data.buildId or 'unknown')..')'));
	end;
	build_id = build_id or data.buildId;
	assert(build_id == data.buildId, 'build version was changed midway during generation, please restart the process');
	return generateAnnotation(data.props.pageProps.data.apiReference);
end;

local exceedsPreloadFileSize = function(size)
	return size >= PRELOAD_FILE_SIZE;
end;

local exceedsParserLocalLimit = function(vars)
	return vars >= PARSER_LOCAL_LIMIT;
end;

local onError = function(s)
	print(format(ERROR_FORMAT, s));
end;

local init = function()
	local stream = docs.generateDocsStream();
	local size = getStreamSize(stream);
	local n_defined = #extra_annotation_urls;
	local annotation_size, files, variable_count, annotations = size, 0, 0, 0;
	local loaded = {};
	local renewStream = function()
		variable_count, size, files = 0, 0, files + 1;
		writeFile(format(FILE_FORMAT, files), concat(stream));
		stream = {};
	end;
	local start_time = uv.hrtime();
	print(format(NOTICE_FORMAT, 'running version ('..VERSION..')'));
	print(format(NOTICE_FORMAT, 'retrieving roblox reference list...'));
	local reference_body = getBodyAt(domain.main..domain.reference);
	print(format(NOTICE_FORMAT, 'creating annotations folder...'));
	if (assert(uv.fs_mkdir('./'..FOLDER_NAME, tonumber('777', 8))) and operating_system == 'Linux') then
		assert(uv.fs_chown('./'..FOLDER_NAME, uv.getuid(), uv.getgid()), format(ERROR_FORMAT, 'failed to set permissions for annotations folder'));
	end;
	print(format(NOTICE_FORMAT, 'generating annotations from reference...'));
	for category, name in reference_body:gmatch('href[%s]*=[%s]*["\']'..domain.reference_slash..'(.-)/(.-)["\']') do
		local res, body = xpcall(getAnnotationByReference, onError, category, name);
		if (res and body) then
			local body_size = body:len();
			if (exceedsPreloadFileSize(size + body_size)) then
				renewStream();
				size = body_size;
			else size = size + body_size;
			end; if (includes_variable[category] and exceedsParserLocalLimit(variable_count + 1)) then
				renewStream();
				size = body_size;
			else variable_count = variable_count + 1;
			end;
			annotation_size = annotation_size + body_size;
			annotations = annotations + 1;
			loaded[name] = 0;
			insert(stream, body);
		end;
	end;
	print(format(NOTICE_FORMAT, 'finished generating '..tostring(annotations)..' annotations'));
	if (n_defined > 0) then
		print(format(NOTICE_FORMAT, tostring(n_defined)..' explicitly defined annotation urls found'));
		print(format(NOTICE_FORMAT, 'generating explicitly defined annotations...'));
		local created_annotations = 0;
		for i = 1, n_defined do
			local path = extra_annotation_urls[i];
			local category, name = path:match('(.+)/(.+)');
			if (category and name and loaded[name] == nil) then
				local res, body = xpcall(getAnnotationByReference, onError, category, name);
				if (res and body) then
					local body_size = body:len();
					if (exceedsPreloadFileSize(size + body_size)) then
						renewStream();
						size = body_size;
					else size = size + body_size;
					end; if (includes_variable[category] and exceedsParserLocalLimit(variable_count + 1)) then
						renewStream();
						size = body_size;
					else variable_count = variable_count + 1;
					end;
					annotation_size = annotation_size + body_size;
					annotations = annotations + 1;
					created_annotations = created_annotations + 1;
					loaded[name] = 0;
					insert(stream, body);
				end;
			end;
		end;
		print(format(NOTICE_FORMAT, 'finished generating '..tostring(created_annotations)..' explicitly defined annotations'));
		if (created_annotations < n_defined) then
			print(format(WARN_FORMAT, 'Only '..tostring(created_annotations)..' out of '..tostring(n_defined)..' annotations were created, perhaps the reference list is more up to date?'));
		end;
	else print(format(NOTICE_FORMAT, 'no explicitly defined annotations detected'));
	end;
	print(format(NOTICE_FORMAT, 'checking for new unsupported reference types...'));
	local unsupported_types = docs.printUnsupportedTypes();
	local n_unsupported_types = #unsupported_types;
	if (n_unsupported_types > 0) then
		print(format(NOTICE_FORMAT, tostring(n_unsupported_types)..' unsupported types were found'));
		print(format(NOTICE_FORMAT, 'attempting to identify unsupported references by category...'));
		local created_annotations = 0;
		for i = 1, n_unsupported_types do
			local name = unsupported_types[i];
			print(format(NOTICE_FORMAT, 'attempting to find external reference for ('..name..')'));
			for category, _ in next, supported_categories do
				if (category and name and loaded[name] == nil) then
					local res, body = xpcall(getAnnotationByReference, onError, category, name);
					if (res and body) then
						local body_size = body:len();
						print(format(NOTICE_FORMAT, 'rbx-types: found external reference ('..category..'/'..name..')'));
						if (exceedsPreloadFileSize(size + body_size)) then
							renewStream();
							size = body_size;
						else size = size + body_size;
						end; if (includes_variable[category] and exceedsParserLocalLimit(variable_count + 1)) then
							renewStream();
							size = body_size;
						else variable_count = variable_count + 1;
						end;
						annotation_size = annotation_size + body_size;
						annotations = annotations + 1;
						created_annotations = created_annotations + 1;
						loaded[name] = 0;
						insert(stream, body);
						break;
					end;
				end;
			end;
		end;
		print(format(NOTICE_FORMAT, 'finished generating '..tostring(created_annotations)..' external reference annotations'));
		if (created_annotations < n_unsupported_types) then
			print(format(WARN_FORMAT, 'Only '..tostring(created_annotations)..' out of '..tostring(n_unsupported_types)..' external reference annotations were created, maybe the reference does not have a page?'));
		end;
	else print(format(NOTICE_FORMAT, 'no unsupported reference types found'));
	end;
	print(format(NOTICE_FORMAT, 'writing leftover annotations to file...'));
	writeFile(format(FILE_FORMAT, files + 1), concat(stream));
	print(format(NOTICE_FORMAT, 'annotation generation complete'));
	print(format(NOTICE_FORMAT, 'annotations can be found at ./'..FOLDER_NAME));
	print(format(NOTICE_FORMAT, 'annotation has a size of '..tostring(annotation_size)..' bytes total accross all files'));
	print(format(NOTICE_FORMAT, 'generation took '..tostring((uv.hrtime() - start_time)/NANOS_IN_ONE)..' seconds'));
end;

do
	local res = xpcall(init, onError);
	if (res) then
		print(format(NOTICE_FORMAT, 'annotations successfully generated'));
	else print(format(ERROR_FORMAT, 'failed to create annotations'));
	end;
end;
