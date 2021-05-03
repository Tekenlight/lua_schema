#!/opt/local/bin/lua
mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:basic_string_simple_content xmlns:ns1="http://example.prototype" attr1="123">hello hello</ns1:basic_string_simple_content>]=]

mhf = require("message_handler_factory")

basic_string_simple_conten = mhf:get_message_handler("basic_string_simple_content", "http://example.prototype");

local content, msg = basic_string_simple_conten:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

