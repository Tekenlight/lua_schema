#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?><basic_string_nons>hello hello</basic_string_nons>]=]

mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("basic_string_nons");

local content, msg = basic_string:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end


local i = 0;
if (nil ~= content) then
	local json_str = nil;
	local lua_obj = nil;
	local xml_str = nil;
	while (i < 10000) do
		--print("+++++++++++++++");
		json_str = basic_string:to_json(content);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, json_str);
		lua_obj = basic_string:from_json(json_str);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		xml_str = basic_string:to_xml(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		content = basic_string:from_xml(xml_str);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, xml_str);
		i = i + 1;
		print(i);
	end
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

