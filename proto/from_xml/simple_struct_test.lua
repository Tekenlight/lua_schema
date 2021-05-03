mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:simple_struct xmlns:ns1="http://example.prototype">
  <author>asdf</author>
  <title>adfas</title>
  <genre>as</genre>
</ns1:simple_struct>]=]

mhf = require("message_handler_factory")
simple_struct = mhf:get_message_handler("simple_struct", "http://example.prototype");


local content, msg = simple_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

