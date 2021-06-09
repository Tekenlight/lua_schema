#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_string xmlns:ns1="http://test_example.com">hello</ns1:basic_string>]=]

mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("basic_string", "http://test_example.com");

local content, msg = basic_string:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(basic_string:to_xml(content))
if (nil ~= content) then
	local json_str = basic_string:to_json(content);
	print(json_str);
	local lua_obj = basic_string:from_json(json_str);
	local xml_str, msg = basic_string:to_xml(lua_obj);
	print(xml_str);
	content = basic_string:from_xml(xml_str);
	require 'pl.pretty'.dump(content);

end

if (content ~= nil) then os.exit(true); else os.exit(false); end

