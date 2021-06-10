mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:simple_choice2_struct xmlns:ns1="http://test_example.com">
  <author>adfas</author>
  <author>adfas</author>
  <one>one</one>
</ns1:simple_choice2_struct>]=]

mhf = require("schema_processor")
simple_choice2_struct = mhf:get_message_handler("simple_choice2_struct", "http://test_example.com");


local content, msg = simple_choice2_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

