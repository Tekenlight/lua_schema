#!/opt/local/bin/lua
mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("basic_string", "http://example.com");

local content = 123.45
print(basic_string:to_xml(content))
print(basic_string:to_json(content))

