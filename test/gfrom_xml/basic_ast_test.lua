#!/opt/local/bin/lua

local xml_ast = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:basic_ast xmlns:ns1="http://test_example.com">hello world</ns1:basic_ast>]=]

mhf = require("message_handler_factory")

basic_ast = mhf:get_message_handler("basic_ast", "http://test_example.com");

local content, msg = basic_ast:from_xml(xml_ast)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

