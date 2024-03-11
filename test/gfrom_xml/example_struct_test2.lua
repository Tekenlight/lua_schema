local mhf = require("schema_processor")
local unistd = require("posix.unistd");

local rsa_key_pair = require('service_utils.crypto.crypto_utils').form_rsa_key_pair(2048);

local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>
<ns2:example_struct xmlns:ns2="http://test_example.com" xmlns:ns1="http://test_example1.com">
</ns2:example_struct>]=]

mhf = require("schema_processor")
local example_struct = mhf:get_message_handler("example_struct", "http://test_example.com");


print("from XML");
local content, msg = example_struct:from_xml(xml_string)
--if (type(content) == 'table') then require 'pl.pretty'.dump(content);
--else print(content, msg)
--end


print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(content);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

print("==================");

print(example_struct:to_json(content));
print("==================");
local cont2 = example_struct:from_json(example_struct:to_json(content));
print(debug.getinfo(1).source, debug.getinfo(1).currentline);
require 'pl.pretty'.dump(cont2);
print(debug.getinfo(1).source, debug.getinfo(1).currentline);

--[[
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
--]]

--if (content ~= nil) then os.exit(true); else os.exit(false); end

