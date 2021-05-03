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
<ns2:one xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">
Hello
</ns2:one>]=]
--[[
]]

mhf = require("message_handler_factory")
--one = mhf:get_message_handler_using_xsd("./temp/one.xsd", "one");
one = mhf:get_message_handler("one", "http://test_example.com");

local content, msg = one:from_xml(xml_string)
if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

print(one:to_xml(content))
