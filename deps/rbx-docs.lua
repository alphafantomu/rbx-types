
local table, string = table, string;
local insert, concat = table.insert, table.concat;
local format = string.format;

local json = require('json');
local extension = require('discordia-extensions');

local CLASS = '---@class %s';
local CLASS_INHERIT = '---@class %s:%s';
local TYPE = '---@type %s';
local ENUM = '---@enum %s';
local PARAM = '---@param %s %s';
local RETURN = '---@return %s';
local FIELD = '---@field %s %s';
local ALIAS = '---@alias %s %s';
local ENUM_ITEM = '---`%s`: %s';
local REPEATABLE = '%s...';
local OR = '%s|%s';
local ARRAY_OF = '<%s>[]';
local TABLE_OF = 'table<%s>';
local GLOBAL_TABLE = '%s={%s}';
local VAR_STRING_INTEGER = '%s=%d';
local VAR_STRING_STRING = '%s=%s';
local KEYWORD_SUB = 'k%s';
local LOG = '%s:%s:%s';
local FX = '%s=function(%s)end';
local DIAGNOSTIC_ENABLE = '---@diagnostic enable';
local DIAGNOSTIC_DISABLE = '---@diagnostic disable';
local FILE = '[%s](%s)';
local REFERENCE_TO_PAGE = 'https://create.roblox.com/docs/reference/engine/%s/%s';
local REFERENCE_TO_HEADER = REFERENCE_TO_PAGE..'#%s';
local TAB = string.char(9);

local typeToAnnotationType;
local logs = {};
local type_link = {};
local archive = {};
local enum_archive = {};
local class_cache = {};
local datatype_cache = {};
local enum_cache = {};
local types_cache = {};
local alias_cache = {};
local __typename_linkage = {
	ClassReference = 'annotateClass';
	DatatypeReference = 'annotateDatatype';
	GlobalReference = 'annotateGlobal';
	LibraryReference = 'annotateLibrary';
	EnumReference = 'annotateEnum';
};
local type_linkage = {
	Tuple = '...';
	Variant = 'any';
	Function = 'function';
	Array = 'table';
	Dictionary = 'table';
	Map = 'table';
	RbxLibrary = 'table';
	Objects = 'table';
	RotationCurveKey = 'table';
	QFont = 'string';
	QDir = 'string';
	Content = 'string';
	ProtectedString = 'string';
	BinaryString = 'string';
	Integer = 'integer';
	int64 = 'integer';
	int = 'integer';
	double = 'number';
	float = 'number';
	bool = 'boolean';
	void = 'nil';
};
local roblox_type_linkage = {
	CoordinateFrame = 'CFrame';
};
local sumneko_annotation_supported_types = {
	['...'] = true;
	['nil'] = true;
	['any'] = true;
	['boolean'] = true;
	['string'] = true;
	['number'] = true;
	['integer'] = true;
	['function'] = true;
	['table'] = true;
	['thread'] = true;
	['userdata'] = true;
	['lightuserdata'] = true;
};
local lua_keywords = {
	['and'] = true;
	['break'] = true;
	['do'] = true;
	['else'] = true;
	['elseif'] = true;
	['end'] = true;
	['false'] = true;
	['for'] = true;
	['function'] = true;
	['if'] = true;
	['in'] = true;
	['local'] = true;
	['nil'] = true;
	['not'] = true;
	['or'] = true;
	['repeat'] = true;
	['return'] = true;
	['then'] = true;
	['true'] = true;
	['until'] = true;
	['while'] = true;
};
local global_changed_values = {
	_VERSION = "'Luau'";
};

local log = function(name, id, process_name, tabs)
	insert(logs, string.rep(TAB, tabs)..format(LOG, name, id, process_name));
end;

local removeLastNewLine = function(s)
	local res = s:gsub('\n$', '');
	return res;
end;

--[[
--not needed
local removeLastComment = function(s)
	local res = s:gsub('---$', '');
	return res;
end;
--not needed
local removeLastSuperclassExtender = function(s)
	local res = s:gsub(':[%s]*$', '');
	return res;
end;
--removed due to summary and description problems
local annotateDescription = function(s)
	return s ~= '' and removeLastComment(removeLastNewLine(s):gsub('\n', '\n---')) or s;
end;
]]

local removeTableReference = function(s)
	local res = s:gsub('^(.+)%.', ''):gsub('^(.+)%:', '');
	return res;
end;

local removeLastCommaExtender = function(s)
	local res = s:gsub(',[%s]*$', '');
	return res;
end;

local isDescriber = function(s)
	local described_types = s:match('<(.+)>');
	if (described_types) then
		local base_type = s:gsub('<'..described_types..'>', '');
		local arr = extension.string.split(described_types, ',');
		local n = #arr;
		for i = 1, n do
			arr[i] = extension.string.trim(arr[i]);
		end;
		return base_type, arr;
	end;
	return s;
end;

local isOr = function(s)
	return s:match('(.-)[%s]*|[%s]*(.+)');
end;

local isOptional = function(s)
	return s:match('(.-)?$');
end;

local kiloBytesToBytes = function(n)
	return n * 1000;
end;

local add = function(data, callback)
	local __typename = data.__typename;
	local parser = type_link[__typename_linkage[__typename]];
	if (not parser) then
		callback(''..(__typename or 'NOT FOUND')..' is not a supported __typename');
	end;
	local res, err = pcall(function()
		local selected_archive, annotation = parser(data);
		insert(selected_archive, annotation);
	end);
	local arg = (not res) and err;
	if (arg) then
		log('add', 'ERROR', arg, 4);
	end;
	callback(arg);
end;

local compress = function(PRELOAD_FILE_SIZE, callback);
	PRELOAD_FILE_SIZE = kiloBytesToBytes(PRELOAD_FILE_SIZE);
	local page, size = {}, 0;
	local n_archive, n_enum_archive = #archive, #enum_archive;
	local linsert = function(body)
		local body_size = body:len();
		local new_size = size + body_size;
		if (new_size >= PRELOAD_FILE_SIZE) then
			callback(concat(page, '\n'), size);
			page, size = {}, 0;
			new_size = body_size;
		end;
		insert(page, body);
		size = new_size;
	end;
	linsert(DIAGNOSTIC_DISABLE);
	-- Generate Enum Alias --
	for enum in next, enum_cache do
		linsert(format(ALIAS, 'Enum.'..enum, enum));
	end;
	-- Generate Enum Archive --
	linsert(format(TYPE, 'Enum'));
	linsert(format(VAR_STRING_STRING, 'Enum', '{'));
	for i = 1, n_enum_archive do
		local body = removeLastNewLine(enum_archive[i]);
		if (i >= n_enum_archive) then
			body = removeLastCommaExtender(body)..'}';
		end;
		linsert(body);
	end;
	if (n_enum_archive < 1) then
		linsert('}');
	end;
	-- Generate General Archive --
	for i = 1, n_archive do
		linsert(removeLastNewLine(archive[i]));
	end;
	linsert(DIAGNOSTIC_ENABLE);
	-- Generate the rest --
	if (size ~= 0) then
		callback(concat(page, '\n'), size);
	end;
end;

local dumpLogs = function()
	return concat(logs, '\n');
end;

local dumpUnknownTypes = function(callback)
	for t in next, types_cache do
		if (not class_cache[t] and not datatype_cache[t] and not enum_cache[t] and not alias_cache[t]) then
			callback(t);
		end;
	end;
end;
--CatalogSearchParams, NumberSequence
typeToAnnotationType = function(t)
	local known = types_cache[t];
	local rbx_conversion = roblox_type_linkage[t] or t;
	local supported = sumneko_annotation_supported_types[t];
	local conversion = type_linkage[rbx_conversion];
	log('typeToAnnotationType', t, 'CALL', 3);
	-- Syntax Check --
	local optional_type = isOptional(t);
	local first_type, second_type = isOr(t);
	local base_type, describer_types = isDescriber(t);
	local n_describers = describer_types and #describer_types or 0;
	log('typeToAnnotationType', t, 'CHECK_OPTIONAL', 3);
	if (optional_type) then
		return typeToAnnotationType(optional_type);
	end;
	log('typeToAnnotationType', t, 'CHECK_OR', 3);
	if (first_type or second_type) then
		if (first_type and second_type) then
			local refined_first_type, refined_second_type = typeToAnnotationType(first_type), typeToAnnotationType(second_type);
			if (refined_first_type and refined_second_type) then
				log('typeToAnnotationType', t, 'FOUND_OR:'..refined_first_type..':'..refined_second_type, 3);
				return format(OR, refined_first_type, refined_second_type);
			else log('typeToAnnotationType', t, 'BAD_REFINE:'..first_type..':'..second_type, 3);
			end;
		else
			log('typeToAnnotationType', t, 'ADD_TO_CACHE', 3);
			types_cache[t] = true;
		end;
	end;
	log('typeToAnnotationType', t, 'CHECK_VARIED', 3);
	if (base_type ~= t and describer_types and n_describers > 0) then
		local refined_base_type = typeToAnnotationType(base_type);
		log('typeToAnnotationType', t, 'CONVERT_DESCRIBER_TYPE', 3);
		for i = 1, n_describers do
			describer_types[i] = typeToAnnotationType(describer_types[i]);
		end;
		log('typeToAnnotationType', t, 'CHECK_VARIED_TYPE', 3);
		if (refined_base_type == '...') then
			log('typeToAnnotationType', t, 'VARIED_TUPLE:'..describer_types[1], 3);
			--return format(REPEATABLE, typeToAnnotationType(describer_types[1]));
			return format(REPEATABLE, '...');
		elseif (refined_base_type == 'table') then
			--[[if (base_type == 'Array') then
				return format(ARRAY_OF, typeToAnnotationType(describer_types[1]));
			end;]]
			log('typeToAnnotationType', t, 'VARIED_TABLE:'..json.encode(describer_types)..':'..tostring(removeLastCommaExtender(concat(describer_types,','))), 3);
			return format(TABLE_OF, removeLastCommaExtender(concat(describer_types,',')));
		elseif (refined_base_type == 'any') then
			log('typeToAnnotationType', t, 'VARIED_VARIANT', 3);
			if (n_describers < 2) then
				log('typeToAnnotationType', t, 'VARIANT_SINGLE:'..describer_types[1], 3);
				return typeToAnnotationType(describer_types[1]);
			end;
			log('typeToAnnotationType', t, 'VARIANT_DOUBLE:'..json.encode(describer_types), 3);
			return format(OR, typeToAnnotationType(describer_types[1]), typeToAnnotationType(describer_types[2]));
		else
			log('typeToAnnotationType', t, 'ADD_TO_CACHE', 3);
			types_cache[t] = true;
		end;
	end;
	log('typeToAnnotationType', t, 'CHECK_KNOWN', 3);
	--If the type hasnt been seen before, it cannot be converted, and it isnt supported then add it to cache
	if (not known and not conversion and not supported and rbx_conversion == t) then
		log('typeToAnnotationType', t, 'ADD_TO_CACHE', 3);
		types_cache[t] = true;
	end;
	log('typeToAnnotationType', t, 'END', 3);
	return conversion or rbx_conversion;
end;

local annotationTypeToLua = function(t)
	assert(t ~= 'thread' and t ~= 'userdata' and t ~= 'lightuserdata', 'cannot convert annotation type to lua');
	if (t == 'boolean') then
		return 'true';
	elseif (t == 'string') then
		return "''";
	elseif (t == 'number') then
		return 0;
	elseif (t == 'integer') then
		return 0;
	elseif (t == 'function') then
		return 'function()end'
	elseif (t == 'table') then
		return '{}';
	elseif (t == 'nil') then
		return 'nil';
	end;
	return t;
end;

local hasTupleRepresentation = function(s)
	return s:match('%.%.%.') ~= nil;
end;

local cleanStringForSyntax = function(s)
	s = s:gsub('[%s%(%)%/%-"]', '');
	if (hasTupleRepresentation(s)) then
		s = s:gsub('%.', '');
	end;
	if (lua_keywords[s]) then
		return format(KEYWORD_SUB, s);
	end;
	return s;
end;

local annotateParameters = function(data)
	assert(data.__typename == 'Parameter', 'unsupported __typename: '..data.__typename);
	local name, t = cleanStringForSyntax(data.name), data.type;
	local refined_type = typeToAnnotationType(t);
	if (refined_type == '...') then
		log('annotateParameters', name, 'REMOVE_PARAMETER_TUPLE_TYPE:'..t, 2);
		return nil, name, t;
	end;
	if (name == '...') then
		log('annotateParameters', name, 'REMOVE_PARAMETER_TUPLE_NAME:'..t, 2);
		return nil, name, t;
	end;
	if (name == '') then
		log('annotateParameters', name, 'REMOVE_PARAMETER_EMPTY_NAME:'..t, 2);
		return nil, name, t;
	end;
	log('annotateParameters', name, 'GENERATE_PROPERTY_TYPE:'..t, 2);
	return format(PARAM, name, refined_type), name, t;
end;

local annotateReturns = function(data)
	assert(data.__typename == 'Return', 'unsupported __typename: '..data.__typename);
	log('annotateReturns', 'NO_RETURN_NAME', 'GENERATE_PROPERTY_TYPE:'..data.type, 2);
	return format(RETURN, typeToAnnotationType(data.type));
end;

local annotateProperty = function(data)
	local __typename, name = data.__typename, data.name;
	assert(__typename == 'ClassProperty' or __typename == 'DatatypeProperty' or __typename == 'Property', 'unsupported __typename: '..__typename);
	log('annotateProperty', name, 'GENERATE_PROPERTY_TYPE:'..data.type, 2);
	return '---@field '..cleanStringForSyntax(removeTableReference(name))..' '..typeToAnnotationType(data.type);
	--return format(FIELD, , ;
end;

local annotateFunctionCallbackMethod = function(data, prefix, header, id)
	local __typename = data.__typename;
	assert(__typename == 'Function' or __typename == 'Callback' or __typename == 'Method' or __typename == 'DatatypeFunction' or __typename == 'DatatypeMethod', 'unsupported __typename: '..data.__typename);
	local name, parameters, returns = data.name, data.parameters, data.returns;
	log('annotateFunctionCallbackMethod', name, 'CALL', 1);
	local section = {};
	local anno_params = {};
	local n_params, n_returns = #parameters, #returns;
	-- Special Method Parameter --
	log('annotateFunctionCallbackMethod', name, 'GENERATE_METHOD_PARAMETER', 1);
	if (__typename == 'Method') then
		insert(anno_params, 'self');
		insert(section, format(PARAM, 'self', id));
	end;
	-- Generate Parameters --
	log('annotateFunctionCallbackMethod', name, 'GENERATE_PARAMETER', 1);
	for i = 1, n_params do
		local anno, str = annotateParameters(parameters[i]);
		insert(anno_params, str);
		if (anno) then
			insert(section, anno);
		end;
	end;
	--Generate Returns --
	log('annotateFunctionCallbackMethod', name, 'GENERATE_RETURN', 1);
	for i = 1, n_returns do
		insert(section, annotateReturns(returns[i]));
	end;
	-- Generate Link to Documentation --
	log('annotateFunctionCallbackMethod', name, 'GENERATE_QUICK_LINK', 1);
	insert(section, '---'..format(FILE, header..'/'..name, format(REFERENCE_TO_HEADER, header, id, removeTableReference(name))));
	--Generate Function --
	log('annotateFunctionCallbackMethod', name, 'GENERATE_DEFINITION', 1);
	insert(section, format(FX, prefix and name:gsub(':', '.') or removeTableReference(name), removeLastCommaExtender(concat(anno_params, ','))))
	log('annotateFunctionCallbackMethod', name, 'END', 1);
	return concat(section, '\n');
end;

local annotateEvent = function(data)
	assert(data.__typename == 'Event', 'unsupported __typename: '..data.__typename);
	local name, parameters = data.name, data.parameters;
	log('annotateEvent', name, 'CALL', 1);
	local section = {};
	local anno_params = {};
	local n_params = #parameters;
	-- Generate Signal Class --
	log('annotateEvent', name, 'GENERATE_CLASS_ANNOTATION', 1);
	insert(section, format(CLASS_INHERIT, 'RBXScriptSignal.'..removeTableReference(name), 'RBXScriptSignal'));
	-- Read Parameters --
	log('annotateEvent', name, 'READ_PARAMETER', 1);
	for i = 1, n_params do
		local _, str, t = annotateParameters(parameters[i]);
		insert(anno_params, str..':'..typeToAnnotationType(t));
	end;
	-- Generate Parameters --
	log('annotateEvent', name, 'GENERATE_PARAMETER', 1);
	insert(section, format(FIELD, 'Connect', 'fun(self:RBXScriptSignal.'..removeTableReference(name)..', callback:fun('..concat(anno_params, ',')..')):RBXScriptConnection'));
	-- Generate Signal --
	log('annotateEvent', name, 'GENERATE_DEFINITION', 1);
	insert(section, format(VAR_STRING_STRING, removeTableReference(name), 'nil'));
	log('annotateEvent', name, 'END', 1);
	return format(FIELD, name, 'RBXScriptSignal.'..removeTableReference(name)), concat(section, '\n');
end;

local annotateConstructor = function(data, header, id)
	local __typename = data.__typename;
	assert(__typename == 'Constructor', 'unsupported __typename: '..data.__typename);
	local name, parameters = data.name, data.parameters;
	log('annotateConstructor', name, 'CALL', 1);
	local section = {};
	local anno_params = {};
	local n_params = #parameters;
	-- Generate Parameters --
	log('annotateConstructor', name, 'GENERATE_PARAMETER', 1);
	for i = 1, n_params do
		local anno, str = annotateParameters(parameters[i]);
		insert(anno_params, str);
		if (anno) then
			insert(section, anno);
		end;
	end;
	-- Generate Link to Documentation --
	log('annotateConstructor', name, 'GENERATE_QUICK_LINK', 1);
	insert(section, '---'..format(FILE, header..'/'..name, format(REFERENCE_TO_HEADER, header, id, removeTableReference(name))));
	--Generate Function --
	log('annotateConstructor', name, 'GENERATE_FUNCTION', 1);
	insert(section, format(FX, id..'.'..removeTableReference(name), removeLastCommaExtender(concat(anno_params, ','))))
	log('annotateConstructor', name, 'END', 1);
	return concat(section, '\n');
end;

type_link.annotateClass = function(data)
	local id, inherits, properties, methods, callbacks, events = data.id, data.inherits, data.properties, data.methods, data.callbacks, data.events;
	log('annotateClass', id, 'CALL', 0);
	local section = {};
	local anno_events = {};
	local n_inherits, n_prop, n_methods, n_callbacks, n_events = #inherits, #properties, #methods, #callbacks, #events;
	local has_inherit = n_inherits > 0;
	-- Generate Class Annotation --
	log('annotateClass', id, 'GENERATE_CLASS_ANNOTATION', 0);
	insert(section, format(has_inherit and CLASS_INHERIT or CLASS, id, has_inherit and removeLastCommaExtender(concat(inherits, ',') or nil)));
	-- Generate Properties --
	log('annotateClass', id, 'GENERATE_PROPERTY', 0);
	for i = 1, n_prop do
		insert(section, annotateProperty(properties[i]));
	end;
	-- Generate Event Annotations --
	log('annotateClass', id, 'GENERATE_EVENT_ANNOTATION', 0);
	for i = 1, n_events do
		local class_link, class_body = annotateEvent(events[i]);
		insert(section, class_link);
		insert(anno_events, removeLastNewLine(class_body));
	end;
	-- Generate Quick Link --
	log('annotateClass', id, 'GENERATE_QUICK_LINK', 0);
	insert(section, '---'..format(FILE, 'classes/'..id, format(REFERENCE_TO_PAGE, 'classes', id)));
	-- Generate Class --
	log('annotateClass', id, 'GENERATE_DEFINITION', 0);
	insert(section, format(VAR_STRING_STRING, id, 'nil'));
	-- Generate Methods --
	log('annotateClass', id, 'GENERATE_METHOD', 0);
	for i = 1, n_methods do
		insert(section, removeLastNewLine(annotateFunctionCallbackMethod(methods[i], true, 'classes', id)));
	end;
	-- Generate Callbacks --
	log('annotateClass', id, 'GENERATE_CALLBACK', 0);
	for i = 1, n_callbacks do
		insert(section, removeLastNewLine(annotateFunctionCallbackMethod(callbacks[i], true, 'classes', id)));
	end;
	-- Generate Events --
	log('annotateClass', id, 'GENERATE_EVENT', 0);
	insert(section, removeLastNewLine(concat(anno_events, '\n')));
	-- Add to Cache --
	log('annotateClass', id, 'ADD_TO_CACHE', 0);
	class_cache[id] = true;
	log('annotateClass', id, 'END', 0);
	return archive, concat(section, '\n');
end;

type_link.annotateDatatype = function(data)
	local id, properties, methods, functions, constructors = data.id, data.properties, data.methods, data.functions, data.constructors;
	log('annotateDatatype', id, 'CALL', 0);
	local section = {};
	local n_prop, n_methods, n_fx, n_constructs = #properties, #methods, #functions, #constructors;
	-- Generate Class Annotation --
	log('annotateDatatype', id, 'GENERATE_CLASS_ANNOTATION', 0);
	insert(section, format(CLASS, id));
	-- Generate Properties --
	log('annotateDatatype', id, 'GENERATE_PROPERTY', 0);
	for i = 1, n_prop do
		insert(section, annotateProperty(properties[i]));
	end;
	-- Generate Quick Link --
	log('annotateDatatype', id, 'GENERATE_QUICK_LINK', 0);
	insert(section, '---'..format(FILE, 'datatypes/'..id, format(REFERENCE_TO_PAGE, 'datatypes', id)));
	-- Generate Class --
	log('annotateDatatype', id, 'GENERATE_DEFINITION', 0);
	insert(section, format(VAR_STRING_STRING, id, 'nil'));
	-- Generate Constructors --
	log('annotateDatatype', id, 'GENERATE_CONSTRUCTOR', 0);
	for i = 1, n_constructs do
		insert(section, removeLastNewLine(annotateConstructor(constructors[i], 'datatypes', id)))
	end;
	-- Generate Functions --
	log('annotateDatatype', id, 'GENERATE_FUNCTION', 0);
	for i = 1, n_fx do
		insert(section, removeLastNewLine(annotateFunctionCallbackMethod(functions[i], true, 'datatypes', id)));
	end;
	-- Generate Methods --
	log('annotateDatatype', id, 'GENERATE_METHOD', 0);
	for i = 1, n_methods do
		insert(section, removeLastNewLine(annotateFunctionCallbackMethod(methods[i], true, 'datatypes', id)));
	end;
	-- Add to Cache --
	log('annotateDatatype', id, 'ADD_TO_CACHE', 0);
	datatype_cache[id] = true;
	log('annotateDatatype', id, 'END', 0);
	return archive, concat(section, '\n');
end;

type_link.annotateEnum = function(data)
	local id, items = data.id, data.items;
	log('annotateEnum', id, 'CALL', 0);
	local section = {};
	local n = #items;
	local content = '';
	-- Generate Enum Annotation --
	log('annotateEnum', id, 'GENERATE_ENUM_ANNOTATION', 0);
	insert(section, format(ENUM, id));
	-- Generate Enum Items --
	log('annotateEnum', id, 'GENERATE_ENUM_ITEM', 0);
	for i = 1, n do
		local item = items[i];
		local name, summary = item.name, item.summary;
		local is_not_end = i < n;
		if (summary ~= '') then
			--handle multi line paragraphs by removing the last new line and replacing new lines with new line breaks,
			local item_comment = removeLastNewLine(format(ENUM_ITEM, name, summary)):gsub('\n', '\n---');
			insert(section, item_comment);
			if (is_not_end) then
				insert(section, '---');
			end;
		end;
		content = content..format(VAR_STRING_INTEGER, name, item.value);
		if (is_not_end) then
			content = content..',';
		end;
	end;
	-- Generate Quick Link --
	log('annotateEnum', id, 'GENERATE_QUICK_LINK', 0);
	insert(section, '---'..format(FILE, 'enums/'..id, format(REFERENCE_TO_PAGE, 'enums', id)));
	-- Generate Enum --
	--'Enums.'..
	log('annotateEnum', id, 'GENERATE_DEFINITION', 0);
	insert(section, format(GLOBAL_TABLE, id, content)..',');
	-- Add to Cache --
	log('annotateEnum', id, 'ADD_TO_CACHE', 0);
	enum_cache[id] = true;
	-- Add Alias to Cache --
	log('annotateEnum', id, 'ADD_TO_CACHE', 0);
	alias_cache['Enum.'..id] = true;
	log('annotateEnum', id, 'END', 0);
	return enum_archive, concat(section, '\n');
end;

type_link.annotateGlobal = function(data)
	local id, properties, functions = data.id, data.properties, data.functions;
	log('annotateGlobal', id, 'CALL', 0);
	local section = {};
	local n_prop, n_fx = #properties, #functions;
	-- Generate Global Variables --
	log('annotateGlobal', id, 'GENERATE_PROPERTY', 0);
	for i = 1, n_prop do
		local property = properties[i];
		local name = property.name;
		local value = global_changed_values[name] or annotationTypeToLua(typeToAnnotationType(property.type));
		insert(section, format(VAR_STRING_STRING, name, value));
	end;
	-- Generate Global Functions --
	log('annotateGlobal', id, 'GENEATE_FUNCTION', 0);
	for i = 1, n_fx do
		insert(section, removeLastNewLine(annotateFunctionCallbackMethod(functions[i], false, 'globals', id)));
	end;
	log('annotateGlobal', id, 'END', 0);
	return archive, concat(section, '\n');
end;

type_link.annotateLibrary = function(data)
	local id, properties, functions = data.id, data.properties, data.functions;
	log('annotateLibrary', id, 'CALL', 0);
	local section = {};
	local n_prop, n_fx = #properties, #functions;
	-- Generate Library Annotation --
	log('annotateLibrary', id, 'GENERATE_CLASS_ANNOTATION', 0);
	insert(section, format(CLASS, id));
	-- Generate Properties --
	log('annotateLibrary', id, 'GENERATE_PROPERTY', 0);
	for i = 1, n_prop do
		insert(section, annotateProperty(properties[i]));
	end;
	-- Generate Quick Link --
	log('annotateLibrary', id, 'GENERATE_QUICK_LINK', 0);
	insert(section, '---'..format(FILE, 'libraries/'..id, format(REFERENCE_TO_PAGE, 'libraries', id)));
	-- Generate Library -
	log('annotateLibrary', id, 'GENERATE_DEFINITION', 0);
	insert(section, format(VAR_STRING_STRING, id, 'nil'));
	-- Generate Functions --
	log('annotateLibrary', id, 'GENERATE_FUNCTION', 0);
	for i = 1, n_fx do
		insert(section, removeLastNewLine(annotateFunctionCallbackMethod(functions[i], true, 'libraries', id)));
	end;
	log('annotateLibrary', id, 'END', 0);
	return archive, concat(section, '\n');
end;

return {
	add = add;
	compress = compress;
	dumpUnknownTypes = dumpUnknownTypes;
	dumpLogs = dumpLogs;
	typeToAnnotationType = typeToAnnotationType;
	isDescriber = isDescriber;
	isOr = isOr;
	isOptional = isOptional;
};