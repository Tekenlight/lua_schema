mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns:node xmlns:ns="http://cond.biop.com">
    <condition>
        <variable>a</variable>
        <assoc_const><string>'1234'</string></assoc_const>
        <comparator>==</comparator>
    </condition>
</ns:node>
]=]

mhf = require("schema_processor")
node = mhf:get_message_handler("node", "http://cond.biop.com");


print("from XML");
local content, msg = node:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(node:to_xml(content))
if (nil ~= content) then
	local json_str = node:to_json(content);
	print(json_str);
	local lua_obj = node:from_json(json_str);
	require 'pl.pretty'.dump(lua_obj);
	local xml_str, msg = node:to_xml(lua_obj);
	print(xml_str);
	content = node:from_xml(xml_str);
	require 'pl.pretty'.dump(content);

end

if (content ~= nil) then os.exit(true); else os.exit(false); end

