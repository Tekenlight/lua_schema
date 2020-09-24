#!/opt/local/bin/lua
mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("example.basic_string");

local content = "hello"
print(basic_string:to_xml(content))
print(basic_string:to_json(content))
