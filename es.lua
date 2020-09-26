mhf = require("message_handler_factory")

local content = {author = "asdf", title = "adfas", genre = "as"};
basic_struct = mhf:get_message_handler("example_struct", "http://example.com");
print(basic_struct:is_valid(content))
print(basic_struct:to_xml(content))
