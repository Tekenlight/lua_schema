mhf = require("message_handler_factory")
unistd = require("posix.unistd");

--local content = { _attr = {}, author = "asdf", title = "adfas", genre = "as", element_struct2 = {author = "123", title = "234", genre = "345"} };
local content = {element_struct2 = {author = "123", title = "234", genre =   "345"},  _attr = {}, author = {"asdf", "asdf"}, author_1=12, title = "adfas", genre="asdf", basic_string_simple_content = {_attr = {attr1 = 123, attr2 = "CHA"}, _contained_value = "GOWRI" } };
example_struct = mhf:get_message_handler("example_nil_struct", "http://test_example.com");

print(example_struct:to_xml(content))
print(example_struct:to_json(content))

require 'pl.pretty'.dump(example_struct:from_xml(example_struct:to_xml(content)))
--[[
unistd.sleep(1);
print("CHA");

print(example_struct:to_xml(content))
print(example_struct:to_json(content))
]]--
