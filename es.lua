mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local content = { _attr = {}, author = "asdf", title = "adfas", genre = "as"};
example_struct = mhf:get_message_handler("example_struct", "http://example.com");

print(example_struct:to_xml(content))
print(example_struct:to_json(content))

--[[
unistd.sleep(1);
print("CHA");

print(example_struct:to_xml(content))
print(example_struct:to_json(content))
]]--
