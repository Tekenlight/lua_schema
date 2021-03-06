mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:mult_choice_struct xmlns:ns1="http://test_example.com">
  <one>1</one>
  <two>2</two>
  <three>3</three>
  <four>4</four>
</ns1:mult_choice_struct>]=]

mult_choice_struct = mhf:get_message_handler("mult_choice_struct", "http://test_example.com");
--mult_choice_struct = mhf:get_message_handler_using_xsd("./xsd_for_test/mult_choice_struct.xsd", "mult_choice_struct");

local content, msg = mult_choice_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (content ~= nil) then os.exit(true); else os.exit(false); end

