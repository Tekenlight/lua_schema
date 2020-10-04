#!/opt/local/bin/lua
mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("basic_string_nons");

local content = 123.5
print(basic_string:to_xml(content))
print(basic_string:to_json(content))

