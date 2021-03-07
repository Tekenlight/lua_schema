#!/opt/local/bin/lua
mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("basic_string_simple_content", "http://example.com");

local content = "hello"
print(basic_string:to_xml(content))
print(basic_string:to_json(content))

