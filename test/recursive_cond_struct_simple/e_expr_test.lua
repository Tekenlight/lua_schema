mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns:e_expr xmlns:ns="http://cond.biop.com">
    <neg_expr>
        <neg_expr>
            <one>XYZ</one>
        </neg_expr>
        <one>PQR</one>
    </neg_expr>
    <one>ABC</one>
</ns:e_expr>
]=]

mhf = require("schema_processor")
e_expr = mhf:get_message_handler("e_expr", "http://cond.biop.com");


print("from XML");
local content, msg = e_expr:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(e_expr:to_xml(content))
if (nil ~= content) then
	local json_str = e_expr:to_json(content);
	print(json_str);
	local lua_obj = e_expr:from_json(json_str);
	require 'pl.pretty'.dump(lua_obj);
	local xml_str, msg = e_expr:to_xml(lua_obj);
	print(xml_str);
	content = e_expr:from_xml(xml_str);
	require 'pl.pretty'.dump(content);

end

if (content ~= nil) then os.exit(true); else os.exit(false); end

