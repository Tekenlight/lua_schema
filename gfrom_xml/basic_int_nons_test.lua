#!/opt/local/bin/lua
mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<basic_int_nons>123</basic_int_nons>]=]

basic_int = mhf:get_message_handler("basic_int_nons");

local content, msg = basic_int:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

