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
<ns2:two xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">
Hello
</ns2:two>]=]
--[[
]]

mhf = require("message_handler_factory")
--two = mhf:get_message_handler_using_xsd("./temp/two.xsd", "two");
two = mhf:get_message_handler("two", "http://test_example.com");

local content, msg = two:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

if (msg == nil) then print(two:to_xml(content)); end
