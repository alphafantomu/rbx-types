
local require, assert = require, assert;

local json = require('json');
local http = require('coro-http');

local jdecode = json.decode;
local hrequest = http.request;

local HTTP_OK = 200;
local MAIN_REFERENCE_PAGE = 'https://create.roblox.com/docs/reference/engine';
local NEXT_DATA_MATCH_PATTERN = '<script id="__NEXT_DATA__" type="application/json">(.*)</script>';

local cache = {};

local readPage = function(url)
	local res, body = hrequest('GET', url);
	assert(res.code == HTTP_OK, 'HTTP GET ('..url..'): '..res.reason);
	return body;
end;

local getNEXT_DATA = function(url)
	return assert(readPage(url):match(NEXT_DATA_MATCH_PATTERN), 'page is missing __NEXT__DATA__');
end;

local getPropData = function(url, store_in_cache)
	local propdata = cache[url];
	if (not propdata) then
		local __NEXT_DATA__ = getNEXT_DATA(url);
		local data = jdecode(__NEXT_DATA__);
		propdata = data.props.pageProps.data;
		if (store_in_cache) then
			cache[url] = propdata;
		end;
	end;
	return propdata;
end;

local getNavigation = function(heading)
	local data = getPropData(MAIN_REFERENCE_PAGE, true);
	local navigation = data.navigation;
	local n = #navigation;
	for i = 1, n do
		local header = navigation[i];
		if (header.heading == heading) then
			return header.navigation;
		end;
	end;
end;

return {
	MAIN_REFERENCE_PAGE = MAIN_REFERENCE_PAGE;
	readPage = readPage;
	getNEXT_DATA = getNEXT_DATA;
	getPropData = getPropData;
	getNavigation = getNavigation;
};