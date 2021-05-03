#!/opt/local/bin/lua
mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("basic_string_simple_content", "http://example.prototype");

local content = {_attr = { ["attr1"] = "123", ["attr2"] = "456" }, _contained_value = "hello" }
print(basic_string:to_xml(content))
print(basic_string:to_json(content))

