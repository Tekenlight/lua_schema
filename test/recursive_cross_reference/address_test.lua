mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<address>
    <street>B3-704, L&amp;T South City, Arekere Mico Layout</street>
    <city>Bangalore</city>
    <zipcode>560076</zipcode>
    <resident>
        <firstName>Sudheer</firstName>
        <lastName>H R</lastName>
        <address>
            <street>No.2, 3rd Cross, 1st Main, 1st Phase, Girinagar</street>
            <city>Bangalore</city>
            <zipcode>560085</zipcode>
        </address>
    </resident>
</address>
]=]

mhf = require("schema_processor")
address = mhf:get_message_handler("address", "");


print("from XML");
local content, msg = address:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(address:to_xml(content))
if (nil ~= content) then
	local json_str = address:to_json(content);
	print(json_str);
	local lua_obj = address:from_json(json_str);
	require 'pl.pretty'.dump(lua_obj);
	local xml_str, msg = address:to_xml(lua_obj);
	print(xml_str);
	content = address:from_xml(xml_str);
	require 'pl.pretty'.dump(content);

end

if (content ~= nil) then os.exit(true); else os.exit(false); end

