mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns:basic_struct xmlns:ns="http://test_example.com">
	<author>a</author>
	<title>b</title>
	<genre>c</genre>
</ns:basic_struct>]=]

mhf = require("schema_processor")
basic_struct = mhf:get_message_handler("basic_struct", "http://test_example.com");


print("from XML");
local content, msg = basic_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--[[
local json = basic_struct:to_json(content);
local j_content = basic_struct:from_json(json);
require 'pl.pretty'.dump(j_content);
]]


if (content ~= nil) then os.exit(true); else os.exit(false); end

