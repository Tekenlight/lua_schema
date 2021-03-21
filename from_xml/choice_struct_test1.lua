mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:choice_struct xmlns:ns1="http://example.com">
  <one>1</one>
  <two>2</two>
  <four>4</four>
</ns1:choice_struct>]=]

choice_struct = mhf:get_message_handler("choice_struct", "http://example.com");

local content, msg = choice_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

