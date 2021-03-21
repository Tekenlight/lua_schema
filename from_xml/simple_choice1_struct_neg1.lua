mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:simple_choice1_struct xmlns:ns1="http://example.com">
  <title>adfas</title>
  <title>adfas</title>
</ns1:simple_choice1_struct>]=]

mhf = require("message_handler_factory")
simple_choice1_struct = mhf:get_message_handler("simple_choice1_struct", "http://example.com");


local content, msg = simple_choice1_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

