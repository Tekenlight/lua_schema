#!/opt/local/bin/lua
mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_string xmlns:ns1="http://example.prototype">123.45</ns1:basic_string>]=]

basic_string = mhf:get_message_handler("basic_string", "http://example.prototype");

local content, msg = basic_string:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

