mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:repeated_sequence_struct xmlns:ns1="http://test_example.com">
  <author>asdf</author>
  <title>adfas</title>
  <genre>as</genre>
  <author>asdf</author>
  <title>adfas</title>
  <genre>as</genre>
</ns1:repeated_sequence_struct>]=]

mhf = require("schema_processor")
repeated_sequence_struct = mhf:get_message_handler("repeated_sequence_struct", "http://test_example.com");


local content, msg = repeated_sequence_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

print(repeated_sequence_struct:to_json(content));
print(repeated_sequence_struct:to_xml(content));


--print(repeated_sequence_struct:to_xml(content))
if (content ~= nil) then os.exit(true); else os.exit(false); end

