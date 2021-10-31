#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:t_basic_string_element xmlns:ns1="http://test_example.com">AANPR8928D</ns1:t_basic_string_element>]=]

mhf = require("schema_processor")

basic_string = mhf:get_message_handler("t_basic_string_element", "http://test_example.com");

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

