mhf = require("schema_processor")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:array_struct xmlns:ns1="http://test_example.com">
  <author>123</author>
  <author>456</author>
  <author>789</author>
  <author>012</author>
  <author>234</author>
  <title>1</title>
  <title>2</title>
  <title>3</title>
  <genre>as</genre>
  <genre>bs</genre>
  <ns1:basic_string_simple_content attr2="CHA" attr1="123">SRIRAM</ns1:basic_string_simple_content>
  <ns1:basic_string_simple_content attr2="CHA" attr1="123">GOWRI</ns1:basic_string_simple_content>
</ns1:array_struct>]=]

mhf = require("schema_processor")
array_struct = mhf:get_message_handler("array_struct", "http://test_example.com");


local content, msg = array_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (nil ~= content) then print(array_struct:to_json(content)); end
if (nil ~= content) then print(array_struct:to_xml(content)); end

if (content ~= nil) then os.exit(true); else os.exit(false); end

