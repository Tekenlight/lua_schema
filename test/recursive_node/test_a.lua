mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<a>
    <value>ONE</value>
    <children>
        <node>
            <value>TWO</value>
            <children>
                <node>
                    <value>THREE</value>
                </node>
            </children>
        </node>
    </children>
</a>
]=]

mhf = require("schema_processor")
a = mhf:get_message_handler("a", "");


print("from XML");
local content, msg = a:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(a:to_xml(content))
if (nil ~= content) then
	local json_str = a:to_json(content);
	print(json_str);
	local lua_obj = a:from_json(json_str);
	require 'pl.pretty'.dump(lua_obj);
	local xml_str, msg = a:to_xml(lua_obj);
	print(xml_str);
	content = a:from_xml(xml_str);
	require 'pl.pretty'.dump(content);

end

if (content ~= nil) then os.exit(true); else os.exit(false); end

