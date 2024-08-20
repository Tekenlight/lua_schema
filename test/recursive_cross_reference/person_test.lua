mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<person>
    <firstName>Sudheer</firstName>
    <lastName>H R</lastName>
    <address>
        <street>No.2, 3rd Cross, 1st Main, 1st Phase, Girinagar</street>
        <city>Bangalore</city>
        <zipcode>560085</zipcode>
    </address>
</person>
]=]

mhf = require("schema_processor")
person = mhf:get_message_handler("person", "");


print("from XML");
local content, msg = person:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(person:to_xml(content))
if (nil ~= content) then
	local json_str = person:to_json(content);
	print(json_str);
	local lua_obj = person:from_json(json_str);
	require 'pl.pretty'.dump(lua_obj);
	local xml_str, msg = person:to_xml(lua_obj);
	print(xml_str);
	content = person:from_xml(xml_str);
	require 'pl.pretty'.dump(content);

end

if (content ~= nil) then os.exit(true); else os.exit(false); end

