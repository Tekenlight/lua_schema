local file = io.open("common/UBL-Invoice-2.1-Example.xml");

local xml_string = file:read("a");


mhf = require("message_handler_factory")

invoice = mhf:get_message_handler("Invoice", "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2");
local content, msg = invoice:from_xml(xml_string);
if (type(content) == 'table') then
	--require 'pl.pretty'.dump(content);
else
	--print(content, msg)
end


local json_str = nil;
local lua_obj = content;
local xml_str = xml_string
local i = 0;
if (nil ~= content) then
	print("+++++++++++++++");
	while (i < 3000) do
		json_str = invoice:to_json(content);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, json_str);
		lua_obj = invoice:from_json(json_str);
		--require 'pl.pretty'.dump(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		--xml_str = invoice:to_xml(content);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		--content = invoice:from_xml(xml_str);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, xml_str);
		i = i + 1;
		if (i%1000 == 1) then
			print(i);
		end
		--collectgarbage("collect");
		--collectgarbage("collect");
	end
end

print(i);

--print(json_str);
--print(xml_str);

if (content ~= nil) then os.exit(true); else os.exit(false); end
