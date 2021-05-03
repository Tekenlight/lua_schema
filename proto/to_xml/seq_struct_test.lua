mhf = require("message_handler_factory")
unistd = require("posix.unistd");

--local content = { _attr = {}, author = "asdf", title = "adfas", genre = "as", element_struct2 = {author = "123", title = "234", genre = "345"} };
--local content = { one = "1", two = "2", three = "3" };
local content = { one_and_two = { { one = "1", two = "2", three_and_four = {{three = "3", four = "4"}, {three = "3", four = "4"}, {three = "3", four = "4"}} }, { one = "11", two = "22", three_and_four = {{three = "33", four = "44"}, {three = "33", four = "44"}, {three = "33", four = "44"}} } } };
seq_struct = mhf:get_message_handler("seq_struct", "http://example.prototype");

print(seq_struct:to_xml(content))
print(seq_struct:to_json(content))

--[[
unistd.sleep(1);
print("CHA");

print(choice_struct:to_xml(content))
print(choice_struct:to_json(content))
]]--
