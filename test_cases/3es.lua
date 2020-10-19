mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local content = { _attr = {}, author = "TA1", title = "TT1", genre = "TG1", example_struct = { _attr = {}, author = "asdf", title = "adfas", genre = "as", element_struct2 = {author = "123", title = "234", genre = "345"}, s2 = {{author = "A43", title = "A44", genre = "A45"}, {author = "B43", title = "B44", genre = "B45"}}, basic_string_simple_content = {_attr = {attr1 = 123, attr2 = "CHA"}, _contained_value = "GOWRI" }  }, basic_string = 'BASICSTRING', basic_string_nons = 'VERYBASICSTRING' };
example_struct = mhf:get_message_handler("element_struct3", "http://example2.com");

print(example_struct:to_xml(content))
print(example_struct:to_json(content))

--[[
unistd.sleep(1);
print("CHA");

print(example_struct:to_xml(content))
print(example_struct:to_json(content))
]]--