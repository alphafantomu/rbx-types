
local process = process;
local argv = process.argv;

local uv = require('uv');
local json = require('json');
local http = require('coro-http');
local style = require('rbx-style');
local docs = require('rbx-docs');
local path_join = require('pathjoin').pathJoin;

local VERSION = 1.03;
local TAB = string.char(9);
local MAX_PERMS = tonumber(777, 8);
local FOLDER_ANNOTATION_NAME = 'dist';
local FILE_ANNOTATION_NAME = 'annotation';
local PRELOAD_FILE_SIZE = 1000;
local ANNOTATE_LUA_GLOBALS = false;
local DEBUG_MODE = false;

local readContinue;

local getHeader = function(header, callback)
	local list = style.getNavigation(header);
	local n = #list;
	for i = 1, n do
		local linker = list[i];
		local page = style.MAIN_REFERENCE_PAGE..'/'..linker.path;
		local apiReference = style.getPropData(page).apiReference;
		callback(linker, apiReference);
	end;
end;

local fs_write = function(path, body)
	local fd = assert(uv.fs_open(path, 'w+', MAX_PERMS));
	assert(uv.fs_write(fd, body, 0));
	assert(uv.fs_close(fd));
	return body;
end;

local fs_read = function(path)
	local fd = assert(uv.fs_open(path, 'r+', MAX_PERMS));
	local data = assert(uv.fs_fstat(fd));
	local body = assert(uv.fs_read(fd, data.size, 0));
	assert(uv.fs_close(fd));
	return body;
end;

readContinue = function(t, i, callback)
	local skip = callback(t, i);
	local next_index = i + 1 + (skip or 0);
	if (next_index <= #t) then
		readContinue(t, next_index, callback);
	end;
end;

do
	local n_classes, n_types, n_globals, n_libs, n_enums, n_errors, n_files = 0, 0, 0, 0, 0, 0, 0;
	local failed_messages = {};

	-- Detect Arguments --
	if (#argv > 1) then
		readContinue(argv, 2, function(t, i)
			local arg = t[i];
			if (arg == '--preloadFileSize' or arg == '-pfs') then
				local val = assert(t[i + 1], 'missing integer parameter');
				PRELOAD_FILE_SIZE = tonumber(val); ---@diagnostic disable-line
				return 1;
			elseif (arg == '--debug' or arg == '-d') then
				DEBUG_MODE = true;
			elseif (arg == '--annotateLuaGlobals' or arg == '-alg') then
				ANNOTATE_LUA_GLOBALS = true;
			elseif (arg == '--output' or arg == '-o') then
				local name = assert(t[i + 1], 'missing string parameter');
				FILE_ANNOTATION_NAME = name;
				return 1;
			elseif (arg == '--help' or arg == '-h') then
				print(fs_read('help.txt'));
				error('Requested help page');
			else error('Bad parameter, please try --help for supported flags');
			end;
		end);
	end;

	-- Startup --
	print('----- Rbx-Types Version '..tostring(VERSION)..' -----');
	print('Selected engine reference page as: '..style.MAIN_REFERENCE_PAGE);
	print('Annotations will be in the '..FOLDER_ANNOTATION_NAME..' folder');
	print('Annotation files will be named: '..FILE_ANNOTATION_NAME);
	print('Debug Mode is '..(DEBUG_MODE and 'enabled' or 'disabled'));
	print('Lua Globals will'..(ANNOTATE_LUA_GLOBALS and ' ' or ' not')..' be annotated');

	-- Generate Classes --
	print('--- Generating Classes ---');
	getHeader('CLASS', function(linker, data)
		local path = linker.path;
		n_classes = n_classes + 1;
		print('Class #'..tostring(n_classes)..' ('..linker.title..'): '..path);
		docs.add(data, function(err)
			local res = not err;
			if (not res) then
				failed_messages[path] = err;
			end;
			print(TAB..(res and 'Added to archive' or err));
		end);
	end);
	print('Generated '..tostring(n_classes)..' classes');

	-- Generate Datatypes --
	print('--- Generating Datatypes ---');
	getHeader('DATATYPE', function(linker, data)
		local path = linker.path;
		n_types = n_types + 1;
		print('Datatype #'..tostring(n_types)..' ('..linker.title..'): '..path);
		docs.add(data, function(err)
			local res = not err;
			if (not res) then
				failed_messages[path] = err;
			end;
			print(TAB..(res and 'Added to archive' or err));
		end);
	end);
	print('Generated '..tostring(n_types)..' datatypes');

	-- Generate Enumerations --
	print('--- Generating Enumerations ---');
	getHeader('ENUM', function(linker, data)
		local path = linker.path;
		n_enums = n_enums + 1;
		print('Enum #'..tostring(n_enums)..' ('..linker.title..'): '..path);
		docs.add(data, function(err)
			local res = not err;
			if (not res) then
				failed_messages[path] = err;
			end;
			print(TAB..(res and 'Added to archive' or err));
		end);
	end);
	print('Generated '..tostring(n_enums)..' enumerations');

	-- Generate Globals --
	print('--- Generating Globals ---');
	getHeader('GLOBAL', function(linker, data)
		local path, title = linker.path, linker.title;
		n_globals = n_globals + 1;
		if (not ANNOTATE_LUA_GLOBALS or (ANNOTATE_LUA_GLOBALS and title == 'Lua Globals')) then
			print('Global #'..tostring(n_globals)..' ('..title..'): '..path);
			docs.add(data, function(err)
				local res = not err;
				if (not res) then
					failed_messages[path] = err;
				end;
				print(TAB..(res and 'Added to archive' or err));
			end);
		end;
	end);
	print('Generated '..tostring(n_globals)..' global libraries');

	-- Generate Libraries --
	print('--- Generating Libraries ---');
	getHeader('LIBRARY', function(linker, data)
		local path = linker.path;
		n_libs = n_libs + 1;
		print('Library #'..tostring(n_libs)..' ('..linker.title..'): '..path);
		docs.add(data, function(err)
			local res = not err;
			if (not res) then
				failed_messages[path] = err;
			end;
			print(TAB..(res and 'Added to archive' or err));
		end);
	end);
	print('Generated '..tostring(n_libs)..' libraries');

	if (DEBUG_MODE) then
		-- Error Checking --
		print('--- Checking for generation errors... ---');
		for path, err in next, failed_messages do
			n_errors = n_errors + 1;
			print('Path ('..path..'): '..err);
		end;

		-- Unknown Checking --
		print('--- Checking for unknown types... ---');
		docs.dumpUnknownTypes(function(t)
			print('Type ('..t..'): not referenced as a class, datatype or enum and cannot be converted');
			print('Checking for syntax...');
			local optional_type = docs.isOptional(t);
			local first_type, second_type = docs.isOr(t);
			local base_type, describer_types = docs.isDescriber(t);
			if (optional_type) then
				print('Detected optional type '..t..' '..optional_type);
			end;
			if (first_type or second_type) then
				print('Detected OR type '..t..' '..(first_type or '???')..' '..(second_type or '???'));
				if not (first_type and second_type) then
					print('OR type found but function failed to find both types', first_type, second_type);
				end;
			end;
			if (base_type ~= t and #describer_types > 0) then
				print('Detected Describer type '..t);
				p(describer_types);
			else
				print('Syntax not found');
			end;
			print('\n');
		end);

		-- Dump Logs --
		print('--- Dumping logs... ---');
		local logs = docs.dumpLogs();
		fs_write('log.txt', logs);
	end;

	-- Compress and Write --
	print('--- Compressing data and writing ---');
	docs.compress(PRELOAD_FILE_SIZE, function(data, size)
		fs_write(path_join(FOLDER_ANNOTATION_NAME, FILE_ANNOTATION_NAME..(n_files > 0 and tostring(n_files) or '')..'.lua'), data);
		n_files = n_files + 1;
	end);
end;

uv.run();