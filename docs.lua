
local assert, print, next, tostring			= assert, print, next, tostring;
local os, string, table 					= os, string, table;
local date 									= os.date;
local format 								= string.format;
local insert, concat 						= table.insert, table.concat;

local CLASS_PATTERN							= '---@class %s';
local OVERLOAD_PATTERN 						= '---@overload fun(%s)';
local CLASS_GENERIC_PATTERN 				= '---@generic %s : string';
local TYPE_PATTERN 							= '---@type %s';
local VARARG_PATTERN 						= '---@vararg %s';
local FIELD_PATTERN 						= '---@field %s %s %s';
local PARAMETER_PATTERN 					= '---@param %s %s';
local RETURN_PATTERN 						= '---@return %s';
local CLASS_DEFINITION_PATTERN 				= 'local %s;';
local GLOBAL_REFERENCE_PATTERN 				= '%s = nil;';
local GLOBAL_DEFINITION_PATTERN 			= '%s.%s = nil;';
local FUNCTION_DEFINITION_PATTERN 			= '%s.%s = function(%s) end;';
local GLOBAL_FUNCTION_DEFINITION_PATTERN 	= '%s = function(%s) end;';
local CLASS_GENERIC 						= 'CLASSNAMEGENERIC';

local keywords 								= {['and'] = 0;['break'] = 0;['do'] = 0;['else'] = 0;['elseif'] = 0;['end'] = 0;['false'] = 0;['for'] = 0;['function'] = 0;['if'] = 0;['in'] = 0;['local'] = 0;['nil'] = 0;['not'] = 0;['or'] = 0;['repeat'] = 0;['return'] = 0;['then'] = 0;['true'] = 0;['until'] = 0;['while'] = 0;};
local defined_types 						= {['nil'] = 0;any = 0;boolean = 0;string = 0;number = 0;integer = 0;['function'] = 0;table = 0;thread = 0;userdata = 0;lightuserdata = 0;};
local requires_generic 						= {Instance = {TO_REPLACE = 'className';new = 0;FindFirstAncestorOfClass = 0;FindFirstAncestorWhichIsA = 0;FindFirstChildOfClass = 0;FindFirstChildWhichIsA = 0;}; ServiceProvider = {TO_REPLACE = 'className';FindService = 0;getService = 0;service = 0;GetService = 0;};};
local requires_optional						= {Instance = {new = {parent = 0;}};task = {wait = {duration = 0;}}};
local undefined_types 						= {};
local type_searched_cache 					= {};

local docs 									= {};

---@param str? string
---@param delim? string
---@return table<number, string>
---Splits `str` by the `delim`, returning an array of the string parts that were split
---
---This function was taken from [`extensions.lua`](https://github.com/SinisterRectus/Discordia/blob/master/libs/extensions.lua) from [Discordia](https://github.com/SinisterRectus/Discordia)'s string library with some minor adjustments
local split = function(str, delim)
	local ret = {};
	if (str == nil) then
		return ret;
	end;
	if (delim == nil or delim == '') then
		for c in str:gmatch('.') do
			insert(ret, c);
		end;
		return ret;
	end;
	local n = 1;
	while (true) do
		local i, j = str:find(delim, n);
		if (i) then
			insert(ret, str:sub(n, i - 1));
			n = j + 1;
		else break;
		end;
	end;
	insert(ret, str:sub(n));
	return ret;
end;

---@param str string
---@return string
---Removes whitespaces at the beginning and the end of the `str`
---
---This function was taken from [`extensions.lua`](https://github.com/SinisterRectus/Discordia/blob/master/libs/extensions.lua) from [Discordia](https://github.com/SinisterRectus/Discordia)'s string library with some minor adjustments
local trim = function(str)
	return str:match('^%s*(.-)%s*$');
end;

---@param stream table<number, string>
---@vararg any
---Writes data if it exists to the stream, tostring is not applied here
local refWrite = function(stream, ...)
	local sets = {...};
	local n = #sets;
	for i = 1, n do
		local data = sets[i];
		if (data) then
			insert(stream, data);
		end;
	end;
end;

---@param md string
---@return string
---Adjusts the `md` string for annotations by replacing `\n` with `\n---`
local fixForAnnotations = function(md)
	return md:gsub('\n', '\n---');
end;

---@param s string
---@param name string
---@return string
---Removes `name` from `s` and any `.` or `:`
local omitClassName = function(s, name)
	return s:gsub(name..'[%.%:]', '');
end;

---@param s string
---@return string
---Omits all other characters except for the tuple representation
local tupleRepresentationOnly = function(s)
	return s:match('%.%.%.');
end;

---@param s string
---@return boolean IsTuple
---Determines if `s` has a tuple representation in it, `...` and `others...`  are considered tuple representations
local hasTupleRepresentation = function(s)
	return s:match('%.%.%.') ~= nil;
end;

---@param s string
---@return string
---Adjusts `s` for the syntax check with variable names, if the name has a space, parenthesis, slash, or a dash then it will be removved, any periods will be removed as long as it is not a tuple
---then a [uuid](https://en.wikipedia.org/wiki/Universally_unique_identifier) is generated to replace `s` with removed digits and `-`, otherwise returns the fixed `s`.
local fixForSyntax = function(s)
	s = s:gsub('[%s%(%)%/%-"]', '');
	if (hasTupleRepresentation(s) == false) then
		s = s:gsub('%.', '');
	end;
	return s;
end;

---@param s string
---@return string
---If `s` has any lua keywords (which are specified by a table internally), then they will be replaced with `kw_`..`s`.
local replaceKeywords = function(s)
	return keywords[s] and 'kw_'..s or s;
end;

---@param t string
---Records the type `t` and checks for any new types that aren't defined and adds them into an array internally
local recordType; recordType = function(t)
	t = trim(t:gsub('%?', ''));--:gsub('Enum%.', '')
	local record = t:match('<([%w%s%p]-)>');
	if (record) then
		local types = split(record, ',');
		if (types[1] ~= record) then
			local n_types = #types;
			for i = 1, n_types do
				recordType(types[i]);
			end;
			record = trim(t:gsub(record, ''):gsub('[<>]', ''));
		end;
	else record = t;
	end;
	local OR = split(record, '|');
	if (OR[1] ~= record) then
		local n_OR = #OR;
		if (n_OR > 1) then
			for i = 2, n_OR do
				recordType(OR[i]);
			end;
			record = trim(OR[1]);
		end;
	end;
	local real = record or t;
	if (type_searched_cache[real] == nil) then
		if (defined_types[real] == nil) then
			insert(undefined_types, real);
		end;
		type_searched_cache[real] = 0;
	end;
end;

---@param stream table
---@param s string
---Sends a EmmyLua style comment to `stream`
local pipeAsComment = function(stream, s)
	s = fixForAnnotations(s);
	if (s ~= '') then
		refWrite(stream, '---', s, '\n');
	end;
end;

---@param stream table
---@param inherits table<number, string>
---Sends a EmmyLua style class definition to `stream` with inheritance
local pipeClassHeader = function(stream, inherits)
	refWrite(stream, format(CLASS_PATTERN, stream.name..(#inherits > 0 and ' : '..concat(inherits, ', ') or '')), '\n')
end;

---@param returns table
---@return table<number, string>
---Converts the returns table into EmmyLua style returns
local getReturnFormat = function(returns)
	local n = #returns;
	local return_names = {};
	for e = 1, n do
		local closure = returns[e];
		local closure__typename = closure.__typename;
		if (closure__typename == 'Return') then
			local closure_datatype = closure.type;
			recordType(closure_datatype);
			insert(return_names, closure_datatype);
		else print('docs: found unknown return typename:', closure__typename);
		end;
	end;
	return return_names;
end;

---@param stream? table
---@param parameters table
---@param parameter_names? table
---@param parameter_extension? table
---@param qualified_generic? table<string, number|string>
---@param qualified_optional? table<string, number>
---@return boolean ParameterReplacedWithGeneric
---Gets the parameter name if `parameter_names` is specified, and parameter format for EmmyLua fun() if `parameter_extension` is specified
---
---If `stream` is specified, EmmyLua style parameters will be piped into the stream
---If `qualified` is specified, then parameters will be checked to swap with generics
local pipeParameters = function(stream, parameters, parameter_names, parameter_extension, qualified_generic, qualified_optional)
	local replaced_with_generic, no_generic_header = false, true;
	local n = #parameters;
	for i = 1, n do
		local parameter = parameters[i];
		local parameter__typename = parameter.__typename;
		if (parameter__typename == 'Parameter') then
			local parameter_name = replaceKeywords(fixForSyntax(parameter.name)); --omitTupleRepresentation(replaceKeywords(fixForSyntax(parameter.name)));
			local parameter_datatype = parameter.type;
			recordType(parameter_datatype);
			if (stream) then
				local replace_with_generic = qualified_generic and parameter_name == qualified_generic.TO_REPLACE; ---@diagnostic disable-line
				if (no_generic_header and qualified_generic) then
					refWrite(stream, format(CLASS_GENERIC_PATTERN, CLASS_GENERIC), '\n');
					no_generic_header = false;
				end;
				replaced_with_generic = replaced_with_generic or replace_with_generic;
				if (hasTupleRepresentation(parameter_name)) then
					refWrite(stream, format(VARARG_PATTERN, parameter_datatype), '\n');
				else refWrite(stream, format(PARAMETER_PATTERN, qualified_optional and qualified_optional[parameter_name] and parameter_name..'?' or parameter_name, replace_with_generic and '`'..CLASS_GENERIC..'`' or parameter_datatype), '\n'); ---@diagnostic disable-line
				end;
			end;
			if (parameter_names) then
				insert(parameter_names, hasTupleRepresentation(parameter_name) and tupleRepresentationOnly(parameter_name) or parameter_name);
			end; if (parameter_extension) then
				insert(parameter_extension, parameter_name..': '..parameter_datatype);
			end;
		else print('docs: found unknown parameter typename:', parameter__typename);
		end;
	end;
	return replaced_with_generic;
end;

---@param stream table
---@param properties table
---Gets `properties` and pipes them into `stream` as global references with explicit types
local pipeGlobalProperties = function(stream, properties)
	local n = #properties;
	for i = 1, n do
		local field = properties[i];
		local __typename = field.__typename;
		if (__typename == 'Property') then
			local datatype = field.type;
			recordType(datatype);
			refWrite(stream, format(TYPE_PATTERN, datatype), '\n');
			refWrite(stream, format(GLOBAL_REFERENCE_PATTERN, field.name), '\n');
		else print('docs: found unknown global property typename:', __typename);
		end;
	end;
end;

---@param stream table
---@param properties table
---@return table AnnotationStream
---Gets `properties` and pipes them into `stream` as EmmyLua style public fields, returns an array of strings to write to the stream
local pipeClassProperties = function(stream, properties)
	local name = stream.name;
	local n = #properties;
	local field_binds = {};
	for i = 1, n do
		local field = properties[i];
		local __typename = field.__typename;
		if (__typename == 'ClassProperty' or __typename == 'DatatypeProperty' or __typename == 'Property') then
			local index = fixForSyntax(omitClassName(field.name, name));
			local datatype = field.type;
			recordType(datatype);
			refWrite(stream, format(FIELD_PATTERN, 'public', index, datatype), '\n');
			insert(field_binds, '---'..fixForAnnotations(field.description));
			insert(field_binds, format(GLOBAL_DEFINITION_PATTERN, name, index));
		else print('docs: found unknown class property typename:', __typename);
		end;
	end;
	return field_binds;
end;

---@param stream table
---@param events table
---@return table AnnotationStream
---Gets `events` and pipes them into `stream` as EmmyLua style public fields with an a new class to account for `RBXScriptSignal.Connect`, returns an array of strings to write to the stream
local pipeEvents = function(stream, events)
	local name = stream.name;
	local event_binds = {};
	local n = #events;
	for i = 1, n do
		local event = events[i];
		local __typename = event.__typename;
		if (__typename == 'Event') then
			local index = omitClassName(event.name, name);
			local parameter_extension = {};
			pipeParameters(nil, event.parameters, nil, parameter_extension);
			refWrite(stream, format(FIELD_PATTERN, 'public', index, 'RBXScriptSignal.'..index), '\n');
			insert(event_binds, format(CLASS_PATTERN, 'RBXScriptSignal.'..index..' : RBXScriptSignal'));
			insert(event_binds, format(FIELD_PATTERN, 'public', 'Connect', 'fun(self: RBXScriptSignal.'..index..', callback: fun('..concat(parameter_extension, ', ')..')): RBXScriptConnection'));
			insert(event_binds, '---'..fixForAnnotations(event.description));
			insert(event_binds, format(GLOBAL_DEFINITION_PATTERN, name, index));
		else print('docs: found unknown event typename:', __typename);
		end;
	end;
	return event_binds;
end;

---@param stream table
---@param methods table
---Gets `methods` and pipes them into `stream` as EmmyLua style functions, function overload and parameter generics are accounted for here.
local pipeMethods = function(stream, methods)
	local name = stream.name;
	local n = #methods;
	local generic_detected = false;
	local load_block = {};
	for i = 1, n do
		local method = methods[i];
		local __typename = method.__typename;
		if (__typename == 'Method' or __typename == 'DatatypeMethod') then
			local index = omitClassName(method.name, name);
			local return_names = getReturnFormat(method.returns);
			local linkage = name..'->'..index;
			local constructor_block = load_block[linkage];
			local substream = constructor_block == nil and {} or nil;
			local parameter_names, parameter_extension = {'self'}, {'self'};
			local qualified_generic = requires_generic[name];
			qualified_generic = qualified_generic and qualified_generic[index] and qualified_generic or nil;
			local qualified_optional = requires_optional[name];
			qualified_optional = qualified_optional and qualified_optional[index] or nil;
			generic_detected = generic_detected or (qualified_generic ~= nil);
			local generic_applied = pipeParameters(substream, method.parameters, parameter_names, parameter_extension, qualified_generic, qualified_optional);
			if (constructor_block) then
				insert(constructor_block, format(OVERLOAD_PATTERN, concat(parameter_extension, ', '))..(#return_names > 0 and ': '..concat(return_names, ', ') or ''));
			else
				constructor_block = {};
				load_block[linkage] = constructor_block;
				constructor_block.description = method.description;
				constructor_block.main = format(FUNCTION_DEFINITION_PATTERN, name, index, concat(parameter_names, ', '));
				constructor_block.returns = generic_applied and format(RETURN_PATTERN, CLASS_GENERIC) or format(RETURN_PATTERN, concat(return_names, ', '));
				constructor_block.fields = concat(substream);
			end;
		else print('docs: found unknown method typename:', __typename);
		end;
	end;
	for _, overload_block in next, load_block do
		local n_overloads = #overload_block;
		for i = 1, n_overloads do
			refWrite(stream, overload_block[i], '\n');
		end;
		refWrite(stream, overload_block.fields);
		refWrite(stream, overload_block.returns, '\n');
		pipeAsComment(stream, overload_block.description);
		refWrite(stream, overload_block.main, '\n');
	end;
end;

---@param stream table
---@param functions table
---Gets `functions` and pipes them into `stream` as EmmyLua style functions, overload is accounted for here
local pipeFunctions = function(stream, functions)
	local name = stream.name;
	local n = #functions;
	local load_block = {};
	for i = 1, n do
		local fx = functions[i];
		local __typename = fx.__typename;
		if (__typename == 'DatatypeFunction' or __typename == 'Function') then
			local index = omitClassName(fx.name, name);
			local return_names = getReturnFormat(fx.returns);
			local linkage = name..'->'..index;
			local constructor_block = load_block[linkage];
			local substream = constructor_block == nil and {} or nil;
			local parameter_names, parameter_extension = {}, {};
			local qualified_optional = requires_optional[name];
			qualified_optional = qualified_optional and qualified_optional[index] or nil;
			pipeParameters(substream, fx.parameters, parameter_names, parameter_extension, nil, qualified_optional);
			if (constructor_block) then
				insert(constructor_block, format(OVERLOAD_PATTERN, concat(parameter_extension, ', '))..(#return_names > 0 and ': '..concat(return_names, ', ') or ''));
			else
				constructor_block = {};
				load_block[linkage] = constructor_block;
				constructor_block.description = fx.description;
				constructor_block.main = format(FUNCTION_DEFINITION_PATTERN, name, index, concat(parameter_names, ', '));
				constructor_block.returns = format(RETURN_PATTERN, concat(return_names, ', '));
				constructor_block.fields = concat(substream);
			end;
		else print('docs: found unknown function typename:', __typename);
		end;
	end;
	for _, overload_block in next, load_block do
		local n_overloads = #overload_block;
		for i = 1, n_overloads do
			refWrite(stream, overload_block[i], '\n');
		end;
		refWrite(stream, overload_block.fields);
		refWrite(stream, overload_block.returns, '\n');
		pipeAsComment(stream, overload_block.description);
		refWrite(stream, overload_block.main, '\n');
	end;
end;


---@param stream table
---@param functions table
---Gets `functions` and pipes them into `stream` as EmmyLua style global functions, overload is accounted for here
local pipeGlobalFunctions = function(stream, functions)
	local n = #functions;
	local load_block = {};
	for i = 1, n do
		local fx = functions[i];
		local __typename = fx.__typename;
		if (__typename == 'Function') then
			local index = fx.name;
			local return_names = getReturnFormat(fx.returns);
			local constructor_block = load_block[index];
			local substream = constructor_block == nil and {} or nil;
			local parameter_names, parameter_extension = {}, {};
			pipeParameters(substream, fx.parameters, parameter_names, parameter_extension);
			if (constructor_block) then
				insert(constructor_block, format(OVERLOAD_PATTERN, concat(parameter_extension, ', '))..(#return_names > 0 and ': '..format(RETURN_PATTERN, concat(return_names, ', ')) or ''));
			else
				constructor_block = {};
				load_block[index] = constructor_block;
				constructor_block.description = fx.description;
				constructor_block.main = format(GLOBAL_FUNCTION_DEFINITION_PATTERN, index, concat(parameter_names, ', '));
				constructor_block.returns = format(RETURN_PATTERN, concat(return_names, ', '));
				constructor_block.fields = concat(substream);
			end;
		else print('docs: found unknown global function typename:', __typename);
		end;
	end;
	for _, overload_block in next, load_block do
		local n_overloads = #overload_block;
		for i = 1, n_overloads do
			refWrite(stream, overload_block[i], '\n');
		end;
		refWrite(stream, overload_block.fields);
		refWrite(stream, overload_block.returns, '\n');
		pipeAsComment(stream, overload_block.description);
		refWrite(stream, overload_block.main, '\n');
	end;
end;

---@param stream table
---@param constructors table
---Gets `constructors` and pipes them into `stream` as EmmyLua style functions, function overloads and parameter generics are accounted for here.
local pipeConstructors = function(stream, constructors)
	local name = stream.name;
	local n = #constructors;
	local generic_applied, generic_detected = false, false;
	local load_block = {};
	for i = 1, n do
		local constructor = constructors[i];
		local __typename = constructor.__typename;
		if (__typename == 'Constructor') then
			local index = omitClassName(constructor.name, name);
			local linkage = name..'->'..index;
			local constructor_block = load_block[linkage];
			local parameter_names, parameter_extension = {}, {};
			local substream = constructor_block == nil and {name = name} or nil;
			local qualified_generic = requires_generic[name];
			qualified_generic = qualified_generic and qualified_generic[index] and qualified_generic or nil;
			generic_detected = generic_detected or (qualified_generic ~= nil);
			local qualified_optional = requires_optional[name];
			qualified_optional = qualified_optional and qualified_optional[index] or nil;
			generic_applied = pipeParameters(substream, constructor.parameters, parameter_names, parameter_extension, qualified_generic, qualified_optional);
			if (constructor_block) then
				insert(constructor_block, format(OVERLOAD_PATTERN, concat(parameter_extension, ', ')));
			else
				constructor_block = {};
				load_block[linkage] = constructor_block;
				constructor_block.description = constructor.description;
				constructor_block.main = format(FUNCTION_DEFINITION_PATTERN, name, index, concat(parameter_names, ', '));
				constructor_block.fields = concat(substream);
			end;
		else print('docs: found unknown constructor typename:', __typename);
		end;
	end;
	for _, constructor_block in next, load_block do
		local n_overloads = #constructor_block;
		for i = 1, n_overloads do
			refWrite(stream, constructor_block[i], '\n');
		end;
		refWrite(stream, constructor_block.fields);
		pipeAsComment(stream, constructor_block.description);
		if (generic_applied) then
			refWrite(stream, format(RETURN_PATTERN, CLASS_GENERIC), '\n');
		else refWrite(stream, format(RETURN_PATTERN, name), '\n');
		end;
		refWrite(stream, constructor_block.main, '\n');
	end;
end;

---@param stream table
---@param items table
---Gets `items` and pipes them into `stream` as EmmyLua style fields
local pipeItems = function(stream, items)
	local name = stream.name;
	local n = #items;
	local item_binds = {};
	for i = 1, n do
		local item = items[i];
		local __typename = item.__typename;
		if (__typename == 'EnumItem') then
			local index = omitClassName(item.name, name);
			local value = item.value;
			refWrite(stream, format(FIELD_PATTERN, 'public', index, 'number | \''..tostring(value)..'\''), '\n');
			insert(item_binds, '---'..fixForAnnotations(item.summary));
			insert(item_binds, format(GLOBAL_DEFINITION_PATTERN, name, index));
		else print('docs: found unknown item typename:', __typename);
		end;
	end;
	return item_binds;
end;

---@param api table
---@return string|nil Documentation
---Generates documentation based off the api reference `api`
docs.generateClass = function(api)
	assert(api.__typename == 'ClassReference', 'docs: found invalid api type name');
	local name = api.id;
	local stream = {name = name;};

	-- Class Header --
	pipeClassHeader(stream, api.inherits);

	-- Property Fields --
	local fields = pipeClassProperties(stream, api.properties);

	-- Event Fields --
	local event_classes = pipeEvents(stream, api.events);

	-- Class Description --
	pipeAsComment(stream, api.description);

	-- Class Definition Binding --
	refWrite(stream, format(CLASS_DEFINITION_PATTERN, name), '\n');

	-- Property Field Annotations --
	local n_fields = #fields;
	for i = 1, n_fields do
		refWrite(stream, fields[i], '\n');
	end;

	-- Method Fields --
	pipeMethods(stream, api.methods);

	-- Event Field Annotations --
	local n_event_classes = #event_classes;
	for i = 1, n_event_classes do
		refWrite(stream, event_classes[i], '\n');
	end;

	defined_types[name] = 0;
	if (#stream < 1) then
		return nil;
	end;
	return concat(stream);
end;

---@param api table
---@return string|nil Documentation
---Generates documentation based off the api reference `api`
docs.generateDatatype = function(api)
	assert(api.__typename == 'DatatypeReference', 'docs: found invalid api type name');
	local name = api.id;
	local stream = {name = name;};

	-- Type Header --
	refWrite(stream, '---@class '..name, '\n');

	-- Property Fields --
	local fields = pipeClassProperties(stream, api.properties);

	-- Type Description --
	pipeAsComment(stream, api.description);

	-- Type Definition Binding --
	refWrite(stream, format(GLOBAL_REFERENCE_PATTERN, name), '\n');

	-- Property Field Annotations --
	local n_fields = #fields;
	for i = 1, n_fields do
		refWrite(stream, fields[i], '\n');
	end;

	-- Constructor Fields --
	pipeConstructors(stream, api.constructors);

	-- Function Fields --
	pipeFunctions(stream, api.functions);

	-- Method Fields --
	pipeMethods(stream, api.methods);

	defined_types[name] = 0;
	if (#stream < 1) then
		return nil;
	end;
	return concat(stream);
end;

---@param api table
---@return string|nil Documentation
---Generates documentation based off the api reference `api`
docs.generateEnum = function(api)
	assert(api.__typename == 'EnumReference', 'docs: found invalid api type name');
	local name = api.id;
	local stream = {name = name;};

	-- Enum Header --
	refWrite(stream, '---@class Enum.'..name, '\n');

	-- Item Fields --
	local items = pipeItems(stream, api.items);

	-- Enum Description --
	pipeAsComment(stream, api.description);

	refWrite(stream, format(CLASS_DEFINITION_PATTERN, name), '\n');

	-- Item Field Annotations --
	local n_items = #items;
	for i = 1, n_items do
		refWrite(stream, items[i], '\n');
	end;

	refWrite(stream, 'Enum.'..name..' = '..name..';', '\n');
	refWrite(stream, '---@diagnostic disable-next-line', '\n');
	refWrite(stream, '---@alias '..name..' Enum.'..name, '\n');

	defined_types['Enum.'..name], defined_types[name] = 0, 0;
	if (#stream < 1) then
		return nil;
	end;
	return concat(stream);
end;

---@param api table
---@return string|nil Documentation
---Generates documentation based off the api reference `api`
docs.generateGlobal = function(api)
	assert(api.__typename == 'GlobalReference', 'docs: found invalid api type name');
	local name = api.id;
	local stream = {name = name;};

	refWrite(stream, '---@diagnostic disable', '\n');
	-- Global Functions --
	pipeGlobalFunctions(stream, api.functions);

	-- Global Fields --
	pipeGlobalProperties(stream, api.properties);

	refWrite(stream, '---@diagnostic enable', '\n');

	if (#stream < 1) then
		return nil;
	end;
	return concat(stream);
end;

---@param api table
---@return string|nil Documentation
---Generates documentation based off the api reference `api`
docs.generateLibrary = function(api)
	assert(api.__typename == 'LibraryReference', 'docs: found invalid api type name');
	local name = api.id;
	local stream = {name = name;};

	--refWrite(stream, '---@diagnostic disable', '\n');
	-- Library Header --
	refWrite(stream, '---@class '..name, '\n');

	-- Property Fields --
	local fields = pipeClassProperties(stream, api.properties);

	-- Library Description --
	pipeAsComment(stream, api.description);

	-- Library Definition Binding --
	refWrite(stream, format(GLOBAL_REFERENCE_PATTERN, name), '\n');

	-- Property Field Annotations --
	local n_fields = #fields;
	for i = 1, n_fields do
		refWrite(stream, fields[i], '\n');
	end;

	-- Library Functions --
	pipeFunctions(stream, api.functions);

	--refWrite(stream, '---@diagnostic enable', '\n');

	if (#stream < 1) then
		return nil;
	end;
	return concat(stream);
end;

---Checks and prints any unsupported types found while generating documents
docs.printUnsupportedTypes = function()
	local n_types = #undefined_types;
	local filtered_unsupported_types = {};
	for i = 1, n_types do
		local annotation_type = undefined_types[i];
		if (defined_types[annotation_type] == nil) then
			print('docs: unsupported type detected ('..annotation_type..')');
			insert(filtered_unsupported_types, annotation_type);
		end;
	end;
	undefined_types = filtered_unsupported_types;
	return filtered_unsupported_types;
end;

---@return table
---Creates the basis and definitions as a stream for annotations, additionally defining the types themselves to a cache for unknown type checks
---
---This is really important, as Roblox's [Engine Reference](https://create.roblox.com/docs/reference/engine) has a lot of specific types that are not naturally 
---supported by EmmyLua style annotations, this is also to fix documentation inconsistencies such as:
--- - `CoordinateFrame` (`CFrame`)
--- - `Integer` (`int`/`integer`)
--- - `integer` (`int`/`Integer`)
---
---It should be noted that this function also covers some types that are not included in the [Engine Reference](https://create.roblox.com/docs/reference/engine), such as `RotationCurveKey`.
---`RotationCurveKey` is implied as a `table`
docs.generateDocsStream = function()
	local stream = {};
	refWrite(stream, '-- rbx-types annotations document --', '\n');
	refWrite(stream, '-- This is an automatically generated annotations document designed for EmmyLua or similar variations', '\n');
	refWrite(stream, '-- This document was generated on ', date(), '\n');
	refWrite(stream, '-- You can find rbx-types here: https://github.com/alphafantomu/rbx-types', '\n');
	refWrite(stream, '---@alias void nil', '\n');
	refWrite(stream, '---@alias int64 number', '\n');
	refWrite(stream, '---@alias int number', '\n');
	refWrite(stream, '---@alias float number', '\n');
	refWrite(stream, '---@alias double number', '\n');
	refWrite(stream, '---@diagnostic disable-next-line', '\n');
	refWrite(stream, '---@alias integer int', '\n');
	refWrite(stream, '---@diagnostic disable-next-line', '\n');
	refWrite(stream, '---@alias Integer int', '\n');
	refWrite(stream, '---@alias bool boolean', '\n');
	refWrite(stream, '---@alias Variant any', '\n');
	refWrite(stream, '---@alias Tuple any', '\n');
	refWrite(stream, '---@alias Content string', '\n');
	refWrite(stream, '---@alias BinaryString string', '\n');
	refWrite(stream, '---@alias ProtectedString string', '\n');
	refWrite(stream, '---@alias QDir string', '\n');
	refWrite(stream, '---@alias QFont string', '\n');
	refWrite(stream, '---@alias Function function', '\n');
	refWrite(stream, '---@alias Dictionary table<string, any>', '\n');
	refWrite(stream, '---@alias Array table<number, any>', '\n');
	refWrite(stream, '---@alias Map Dictionary', '\n');
	refWrite(stream, '---@alias Objects table<number, Instance>', '\n');
	refWrite(stream, '---@alias RbxLibrary table', '\n');
	refWrite(stream, '---@alias RotationCurveKey table', '\n');
	refWrite(stream, '---@alias CoordinateFrame CFrame', '\n');
	defined_types.void 					= 0;
	defined_types.int64 				= 0;
	defined_types.int 					= 0;
	defined_types.float 				= 0;
	defined_types.double 				= 0;
	defined_types.integer 				= 0;
	defined_types.Integer 				= 0;
	defined_types.bool 					= 0;
	defined_types.Variant 				= 0;
	defined_types.Tuple 				= 0;
	defined_types.Content 				= 0;
	defined_types.BinaryString 			= 0;
	defined_types.ProtectedString 		= 0;
	defined_types.QDir 					= 0;
	defined_types.QFont 				= 0;
	defined_types.Function 				= 0;
	defined_types.Dictionary 			= 0;
	defined_types.Array 				= 0;
	defined_types.Map 					= 0;
	defined_types.Objects 				= 0;
	defined_types.RbxLibrary 			= 0;
	defined_types.RotationCurveKey 		= 0;
	defined_types.CoordinateFrame 		= 0;
	return stream;
end;

return docs;