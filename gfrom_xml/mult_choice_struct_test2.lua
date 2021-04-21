mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:mult_choice_struct xmlns:ns1="http://test_example.com">
  <one>1</one>
  <two>2</two>
  <four>4</four>
  <three>3</three>
  <four>44</four>
  <three>33</three>
</ns1:mult_choice_struct>]=]

mult_choice_struct = mhf:get_message_handler("mult_choice_struct", "http://test_example.com");

local content, msg = mult_choice_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (nil ~= content) then
	print(mult_choice_struct:to_xml(content))
end
