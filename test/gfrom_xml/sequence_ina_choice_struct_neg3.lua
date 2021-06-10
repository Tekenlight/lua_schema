mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:sequence_ina_choice_struct xmlns:ns1="http://test_example.com">
  <one>one</one>
  <title>adfas</title>
  <genre>adfas</genre>
</ns1:sequence_ina_choice_struct>]=]

mhf = require("schema_processor")
sequence_ina_choice_struct = mhf:get_message_handler("sequence_ina_choice_struct", "http://test_example.com");


local content, msg = sequence_ina_choice_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

