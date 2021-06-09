mhf = require("message_handler_factory")
unistd = require("posix.unistd");

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:element_struct3 xmlns:ns1="http://test_example2.com" xmlns:ns3="http://test_example.com" xmlns:ns2="http://test_example1.com">
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
    <author>asdf</author>
    <author>100</author>
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
  <ns3:basic_string>BASIC_S</ns3:basic_string>
  <basic_string_nons>VERYBASICSTRING</basic_string_nons>
</ns1:element_struct3>]=]

mhf = require("message_handler_factory")
element_struct3 = mhf:get_message_handler("element_struct3", "http://test_example2.com");


local content, msg = element_struct3:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

local t = require("posix.time");
--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(t.nanosleep);
--print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local json_str = nil;
local lua_obj = content;
local xml_str = xml_string;
local i = 0;
if (nil ~= content) then
	print("+++++++++++++++");
	while (i < 10000) do
		json_str = element_struct3:to_json(content);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, json_str);
		lua_obj = element_struct3:from_json(json_str);
		--require 'pl.pretty'.dump(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		--xml_str = element_struct3:to_xml(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		--content = element_struct3:from_xml(xml_str);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, xml_str);
		i = i + 1;
		if ( i % 1000 == 1) then
			print(i);
		end
		local ts = { tv_sec = 0, tv_nsec = 100 } ;
		--t.nanosleep(ts);
	end
end

print(json_str);
print(xml_str);

if (content ~= nil) then os.exit(true); else os.exit(false); end

