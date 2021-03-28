mhf = require("message_handler_factory")

basic_string_sc = mhf:get_message_handler_using_xsd("gen/xsd/basic_string_simple_content.xsd", "basic_string_simple_content")
--require 'pl.pretty'.dump(basic_string_sc);
--require 'pl.pretty'.dump(basic_string_sc.properties);

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:basic_string_simple_content xmlns:ns1="http://example.com" attr2="456" attr1="123">hello hello</ns1:basic_string_simple_content>]=]

local content, msg = basic_string_sc:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local json_str = basic_string_sc:to_json(content);
local xml_str = basic_string_sc:to_xml(content);
local lua_obj = basic_string_sc:from_json(json_str);


print(json_str);
print(xml_str);
(require 'pl.pretty').dump(lua_obj);
