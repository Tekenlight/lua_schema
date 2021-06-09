local file = io.open("common/UBL-Invoice-2.1-Example.xml");

local xml_string = file:read("a");


mhf = require("message_handler_factory")

invoice = mhf:get_message_handler("Invoice", "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2");
local content, msg = invoice:from_xml(xml_string);
if (type(content) == 'table') then
	require 'pl.pretty'.dump(content);
else
	print(content, msg)
end

--require 'pl.pretty'.dump(invoice:from_xml(invoice:to_xml(content)));

--print(invoice:to_json(content));
local xml = invoice:to_xml(content);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(xml);
local json = invoice:to_json(content);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(json);
local cont = invoice:from_xml(xml_string);
local xml = invoice:to_xml(content);
local json = invoice:to_json(content);
