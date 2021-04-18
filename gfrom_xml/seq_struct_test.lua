mhf = require("message_handler_factory")
unistd = require("posix.unistd");


local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:seq_struct xmlns:ns1="http://test_example.com">
  <one>1</one>
  <two>2</two>
  <three>3</three>
  <four>4</four>
  <three>3</three>
  <four>4</four>
  <three>3</three>
  <four>4</four>
  <one>11</one>
  <two>22</two>
  <three>33</three>
  <four>44</four>
  <three>33</three>
  <four>44</four>
  <three>33</three>
  <four>44</four>
</ns1:seq_struct>]=]


mhf = require("message_handler_factory")
seq_struct = mhf:get_message_handler("seq_struct", "http://test_example.com");


local content, msg = seq_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

print(seq_struct:to_xml(content))

