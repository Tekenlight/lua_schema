#!/opt/local/bin/lua

function dump(t, indent, done)
    done = done or {}
    indent = indent or 0

    done[t] = true

    for key, value in pairs(t) do
		--print("--------", key, "---------");
        local cha = string.rep("\t", indent);

        if (type(value) == "table" and not done[value]) then
            done[value] = true;
            print(cha..key, ":");

            dump(value, indent + 2, done);
            done[value] = nil;
        else
            print(cha..key, "\t=\t", value);
        end
    end
end

mhf = require("message_handler_factory")

--[[
local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:example_struct xmlns:ns1="http://test_example.com" xmlns:ns2="http://test_example1.com">
  <author/>
  <title/>
  <genre/>
</ns1:example_struct>]=]
local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:example_struct xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">
</ns2:example_struct>]=]
]]
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
--[[
]]

mhf = require("message_handler_factory")
example_struct = mhf:get_message_handler_using_xsd("./xsd_for_test/example_struct.xsd", "example_struct");
--example_struct = mhf:get_message_handler_using_xsd("./xsd_for_test/mult_choice_struct.xsd", "mult_choice_struct");
--example_struct = mhf:get_message_handler_using_xsd("./common/d.xsd", "example_struct");
--require 'pl.pretty'.dump(example_struct);
--dump(example_struct, 1, false);

--example_struct = mhf:get_message_handler("example_struct", "http://test_example.com");

local content, msg = example_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(example_struct:to_json(content))
print(example_struct:to_xml(content))
