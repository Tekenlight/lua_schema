mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:example_struct xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">
  <ns1:element_struct2>
    <author>123</author>
    <title>234</title>
    <genre>345</genre>
  </ns1:element_struct2>
  <author>asdf</author>
  <author>asdf</author>
  <author>1</author>
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
  <ns2:basic_string_simple_content attr1="123" attr2="CHA">GOWRI</ns2:basic_string_simple_content>
</ns2:example_struct>]=]

mhf = require("message_handler_factory")
example_struct = mhf:get_message_handler("example_struct", "http://test_example.com");


print("from XML");
local content, msg = example_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(example_struct:to_xml(content))
if (nil ~= content) then
	local json_str = example_struct:to_json(content);
	print(json_str);
	local lua_obj = example_struct:from_json(json_str);
	require 'pl.pretty'.dump(lua_obj);
	local xml_str, msg = example_struct:to_xml(lua_obj);
	print(xml_str);
	content = example_struct:from_xml(xml_str);
	require 'pl.pretty'.dump(content);

end

if (content ~= nil) then os.exit(true); else os.exit(false); end

