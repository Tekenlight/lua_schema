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

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns1:choice_struct xmlns:ns1="http://test_example.com">
  <one>1</one>
  <two>2</two>
  <three/>
  <four>4</four>
</ns1:choice_struct>]=]

mhf = require("message_handler_factory")
choice_struct = mhf:get_message_handler_using_xsd("./xsd_for_test/choice_struct.xsd", "choice_struct");
--choice_struct = mhf:get_message_handler_using_xsd("./xsd_for_test/mult_choice_struct.xsd", "mult_choice_struct");
--choice_struct = mhf:get_message_handler_using_xsd("./common/d.xsd", "choice_struct");
--require 'pl.pretty'.dump(choice_struct);
--dump(choice_struct, 1, false);

--choice_struct = mhf:get_message_handler("choice_struct", "http://test_example.com");

local content, msg = choice_struct:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--print(choice_struct:to_json(content))
print(choice_struct:to_xml(content))
