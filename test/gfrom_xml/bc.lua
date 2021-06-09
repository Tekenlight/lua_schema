local file = io.open("common/UBL-BusinessCard-2.2-Example.xml");

local xml_string = file:read("a");


mhf = require("message_handler_factory")

business_card = mhf:get_message_handler("BusinessCard", "urn:oasis:names:specification:ubl:schema:xsd:BusinessCard-2");

local content, msg = business_card:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--require 'pl.pretty'.dump(business_card:from_xml(business_card:to_xml(content)));

print(business_card:to_xml(content));
--print(business_card:to_json(content));
print(business_card:to_xml(content));

--urn:oasis:names:specification:ubl:schema:xsd:BusinessCard-2
