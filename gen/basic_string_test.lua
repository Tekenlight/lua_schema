mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler_using_xsd("gen/xsd/basic_string.xsd", "basic_string")
--require 'pl.pretty'.dump(basic_string);
--require 'pl.pretty'.dump(basic_string.properties);

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_string xmlns:ns1="http://test_example.com">hello hello</ns1:basic_string>]=]

local content, msg = basic_string:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local json_str = basic_string:to_json(content);
local xml_str = basic_string:to_xml(content);
local lua_obj = basic_string:from_json(json_str);


print(json_str);
print(xml_str);
(require 'pl.pretty').dump(lua_obj);
