#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?><basic_string_nons>hello hello</basic_string_nons>]=]

mhf = require("message_handler_factory")

basic_string = mhf:get_message_handler("basic_string_nons");

local content, msg = basic_string:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local json_str = basic_string:to_json(content);

local lua_obj = basic_string:from_json(json_str);


(require 'pl.pretty').dump(lua_obj);

