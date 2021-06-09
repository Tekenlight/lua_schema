#!/opt/local/bin/lua
mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:la_basic_string_simple_content xmlns:ns1="http://test_example.com" attr2="456" attr1="99 100">hello hello</ns1:la_basic_string_simple_content>]=]

mhf = require("message_handler_factory")

la_basic_string_simple_content = mhf:get_message_handler("la_basic_string_simple_content", "http://test_example.com");

local content, msg = la_basic_string_simple_content:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end


local t = require("posix.time");
--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(t.nanosleep);
--print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local json_str = nil;
local lua_obj = nil;
local xml_str = nil;
local i = 0;
if (nil ~= content) then
	print("+++++++++++++++");
	while (i < 1) do
		json_str = la_basic_string_simple_content:to_json(content);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, json_str);
		lua_obj = la_basic_string_simple_content:from_json(json_str);
		--require 'pl.pretty'.dump(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		xml_str = la_basic_string_simple_content:to_xml(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		content = la_basic_string_simple_content:from_xml(xml_str);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, xml_str);
		i = i + 1;
		print(i);
		local ts = { tv_sec = 0, tv_nsec = 1000000 } ;
		t.nanosleep(ts);
	end
end

print(json_str);
print(xml_str);

if (content ~= nil) then os.exit(true); else os.exit(false); end

