#!/opt/local/bin/lua
mhf = require("message_handler_factory")

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:xml_struct xmlns:ns2="http://test_example1.com" xmlns:ns1="http://test_example.com">
  <ns2:element_struct2>
    <author>123</author>
    <title>234</title>
    <genre>345</genre>
  </ns2:element_struct2>
  <author>asdf</author>
  <author>asdf</author>
  <author>1</author>
  <author>Thimmashetty Dasiah</author>
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
  <ns1:basic_string_simple_content attr2="CHA" attr1="123">GOWRI</ns1:basic_string_simple_content>
  <included_struct>
    <one>ONE</one>
    <two>TWO</two>
    <three>THREE</three>
  </included_struct>
</ns1:xml_struct>]=]

mhf = require("message_handler_factory")

xml_struct = mhf:get_message_handler("xml_struct", "http://test_example.com");

local content, msg = xml_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

print(xml_struct:to_json(content))
print(xml_struct:to_xml(content))
