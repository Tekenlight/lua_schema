#!/opt/local/bin/lua

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?><basic_token_nons>          hello hello          </basic_token_nons>]=]
local json_string = [=[{"basic_token_nons":"                  hello hello                  "}]=]

mhf = require("schema_processor")

basic_token_nons = mhf:get_message_handler("basic_token_nons");

local content, msg = basic_token_nons:from_json(json_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (nil ~= content) then
	local xml_str = basic_token_nons:to_xml(content);

	print(json_str);
	local lua_obj = basic_token_nons:from_xml(xml_str);


	if (type(lua_obj) == 'table') then (require 'pl.pretty').dump(lua_obj);
	else print(lua_obj);
	end
	local xml_str = basic_token_nons:to_xml(lua_obj);
	print(xml_str);
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

