mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:element_struct2 xmlns:ns1="http://test_example1.com">
  <author>asdf</author>
  <title>adfas</title>
  <genre>as</genre>
</ns1:element_struct2>]=]

mhf = require("schema_processor")
element_struct2 = mhf:get_message_handler("element_struct2", "http://test_example1.com");


local content, msg = element_struct2:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

