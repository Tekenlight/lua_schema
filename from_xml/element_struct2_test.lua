mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:element_struct2 xmlns:ns1="http://example1.prototype">
  <author>asdf</author>
  <title>adfas</title>
  <genre>as</genre>
</ns1:element_struct2>]=]

mhf = require("message_handler_factory")
element_struct2 = mhf:get_message_handler("element_struct2", "http://example1.prototype");


local content, msg = element_struct2:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

