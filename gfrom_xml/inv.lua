print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local file = io.open("common/UBL-Invoice-2.1-Example.xml");
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local xml_string = file:read("a");


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
mhf = require("message_handler_factory")

print(debug.getinfo(1).source, debug.getinfo(1).currentline);
invoice = mhf:get_message_handler("Invoice", "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2");
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local content, msg = invoice:from_xml(xml_string);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
invoice = mhf:get_message_handler("Invoice", "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2");
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
if (type(content) == 'table') then
	print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	--require 'pl.pretty'.dump(content);
else
	--print(content, msg)
end
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

--require 'pl.pretty'.dump(invoice:from_xml(invoice:to_xml(content)));

--print(invoice:to_json(content));
local xml = invoice:to_xml(content);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
--print(xml);
local json = invoice:to_json(content);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
--print(json);
local cont = invoice:from_xml(xml_string);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
local xml = invoice:to_xml(content);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
--print(xml);
local json = invoice:to_json(content);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
--print(json);
--urn:oasis:names:specification:ubl:schema:xsd:BusinessCard-2
