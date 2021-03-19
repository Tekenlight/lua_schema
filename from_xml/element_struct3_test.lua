mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:element_struct3 xmlns:ns1="http://example2.com" xmlns:ns3="http://example.com" xmlns:ns2="http://example1.com">
  <author>TA1</author>
  <title>TT1</title>
  <genre>TG1</genre>
  <ns3:example_struct>
    <ns2:element_struct2>
      <author>123</author>
      <title>234</title>
      <genre>345</genre>
    </ns2:element_struct2>
    <author>asdf</author>
    <title>adfas</title>
    <genre>as</genre>
    <s2>
      <author>A43</author>
      <title>A44</title>
      <genre>A45</genre>
    </s2>
    <s2>
      <author>B43</author>
      <title>B44</title>
      <genre>B45</genre>
    </s2>
    <ns3:basic_string_simple_content attr1="123" attr2="CHA">GOWRI</ns3:basic_string_simple_content>
  </ns3:example_struct>
  <ns3:basic_string>BASICSTRING</ns3:basic_string>
  <basic_string_nons>VERYBASICSTRING</basic_string_nons>
</ns1:element_struct3>]=]

mhf = require("message_handler_factory")
element_struct3 = mhf:get_message_handler("element_struct3", "http://example2.com");


local content, msg = element_struct3:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

