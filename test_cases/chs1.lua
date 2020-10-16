mhf = require("message_handler_factory")
unistd = require("posix.unistd");

--local content = { _attr = {}, author = "asdf", title = "adfas", genre = "as", element_struct2 = {author = "123", title = "234", genre = "345"} };
--local content = { one = "1", two = "2", three = "3" };
local content = { one = "1", two = "2", four = "4" };
choice_struct = mhf:get_message_handler("choice_struct", "http://example.com");

print(choice_struct:to_xml(content))
print(choice_struct:to_json(content))

--[[
unistd.sleep(1);
print("CHA");

print(choice_struct:to_xml(content))
print(choice_struct:to_json(content))
]]--
