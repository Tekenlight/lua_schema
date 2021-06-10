mhf = require("schema_processor")
unistd = require("posix.unistd");
ffi = require("ffi");

--[[
local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:wvt xmlns:ns1="http://test_example.com">
<int>123</int>
<string>  This is a name:
	Thimmashetty	Dasiah  
</string>
<normalizedString>  This is a name:
	Thimmashetty	Dasiah  
</normalizedString>
<token>  This is a name:
	Thimmashetty	Dasiah  
</token>
<Name>ajs:lka.jf</Name>
<NCName>ajslka.jf</NCName>
<language>en-US</language>
<ID>A123</ID>
<IDREF>A123</IDREF>
<IDREFS>A123 A123</IDREFS>
<ENTITY>A123</ENTITY>
<ENTITIES>A123 A234 </ENTITIES>
<NMTOKEN>:_0123123</NMTOKEN>
<NMTOKENS>:_0123123 askfjaklfj asd_: :fskdjf </NMTOKENS>
<NOTATION>:_0123123 askfjaklfj asd_: :fskdjf </NOTATION>
<QName>A0123123askfjaklfjasd_:fskdjf </QName>
<boolean>true </boolean>
<hexBinary>48656C6C6F20576F726C642053726972616D20616E6420476F777269202121212048656C6C6F20576F726C642053726972616D20616E6420476F77726920212121202048656C6C6F20576F726C642053726972616D20616E6420476F7772692021212121 </hexBinary>
<base64Binary>SGVsbG8gV29ybGQgU3JpcmFtIGFuZCBHb3dyaSAhISEgSGVsbG8gV29ybGQgU3JpcmFtIGFuZCBH
b3dyaSAhISEgIEhlbGxvIFdvcmxkIFNyaXJhbSBhbmQgR293cmkgISEhIQ==</base64Binary>
<anyURI>urn:one:two</anyURI>
<float>3.3E+38 </float>
<double>100.15 </double>
<decimal>    +100.15    </decimal>
<integer>    +20    </integer>
<positiveInteger>    1024    </positiveInteger>
<long>    -9223372036854775807    </long>
<int>    54775807    </int>
</ns1:wvt>]=]
--]]
--[[
local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:wvt xmlns:ns1="http://test_example.com">
<boolean>true </boolean>
<hexBinary>48656C6C6F20576F726C642053726972616D20616E6420476F777269202121212048656C6C6F20576F726C642053726972616D20616E6420476F77726920212121202048656C6C6F20576F726C642053726972616D20616E6420476F7772692021212121 </hexBinary>
<base64Binary>SGVsbG8gV29ybGQgU3JpcmFtIGFuZCBHb3dyaSAhISEgSGVsbG8gV29ybGQgU3JpcmFtIGFuZCBH
b3dyaSAhISEgIEhlbGxvIFdvcmxkIFNyaXJhbSBhbmQgR293cmkgISEhIQ==</base64Binary>
<anyURI>urn:one:two</anyURI>
<float>3.3E+38 </float>
</ns1:wvt>]=]
--]]
--[[
local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:wvt xmlns:ns1="http://test_example.com">
</ns1:wvt>]=]
--]]
--
--[[
--]]
local xml_string = [=[<?xml version="1.0" encoding="UTF-8"?>                                      
<ns1:wvt xmlns:ns1="http://test_example.com">
<int>123</int>
<string>  This is a name:
	Thimmashetty	Dasiah  
</string>
<normalizedString>  This is a name:
	Thimmashetty	Dasiah  
</normalizedString>
<token>  This is a name:
	Thimmashetty	Dasiah  
</token>
<Name>ajs:lka.jf</Name>
<NCName>ajslka.jf</NCName>
<language>en-US</language>
<ID>A123</ID>
<IDREF>A123</IDREF>
<ENTITY>A123</ENTITY>
<NMTOKEN>:_0123123</NMTOKEN>
<NOTATION>:_0123123 askfjaklfj asd_: :fskdjf </NOTATION>
<QName>A0123123askfjaklfjasd_:fskdjf </QName>
<IDREFS>A123 A123</IDREFS>
<ENTITIES>A123 A234 </ENTITIES>
<NMTOKENS>:_0123123 askfjaklfj asd_: :fskdjf </NMTOKENS>
<boolean>true </boolean>
<float>3.3E+38 </float>
<double>100.15 </double>
<hexBinary>48656C6C6F20576F726C642053726972616D20616E6420476F777269202121212048656C6C6F20576F726C642053726972616D20616E6420476F77726920212121202048656C6C6F20576F726C642053726972616D20616E6420476F7772692021212121 </hexBinary>
<base64Binary>SGVsbG8gV29ybGQgU3JpcmFtIGFuZCBHb3dyaSAhISEgSGVsbG8gV29ybGQgU3JpcmFtIGFuZCBH
b3dyaSAhISEgIEhlbGxvIFdvcmxkIFNyaXJhbSBhbmQgR293cmkgISEhIQ==</base64Binary>
<anyURI>urn:one:two</anyURI>
<decimal>    +100.15    </decimal>
<integer>    +20    </integer>
<positiveInteger>    1024    </positiveInteger>
<long>    -9223372036854775807    </long>
<int>    54775807    </int>
</ns1:wvt>]=]

mhf = require("schema_processor")
wvt = mhf:get_message_handler("wvt", "http://test_example.com");

--[[
--]]
local content, msg = wvt:from_xml(xml_string)

if (type(content) == 'table') then require 'pl.pretty'.dump(content);
else print(content, msg)
end

--[=[
local cu = require("core_utils");
local content = {
  ENTITIES = "A123 A234",
  ENTITY = "A123",
  ID = "A123",
  IDREF = "A123",
  IDREFS = "A123 A123",
  NCName = "ajslka.jf",
  NMTOKEN = ":_0123123",
  NMTOKENS = ":_0123123 askfjaklfj asd_: :fskdjf",
  NOTATION = ":_0123123 askfjaklfj asd_: :fskdjf",
  Name = "ajs:lka.jf",
  QName = "A0123123askfjaklfjasd_:fskdjf",
  anyURI = "urn:one:two",
  base64Binary = cu.base64_decode([[SGVsbG8gV29ybGQgU3JpcmFtIGFuZCBHb3dyaSAhISEgSGVsbG8gV29ybGQgU3JpcmFtIGFuZCBHb3dyaSAhISEgIEhlbGxvIFdvcmxkIFNyaXJhbSBhbmQgR293cmkgISEhIQ==]]),
  boolean = true,
  decimal = 100.15,
  double = 100.15,
  float = 3.3e+38,
  hexBinary = cu.hex_decode("48656C6C6F20576F726C642053726972616D20616E6420476F777269202121212048656C6C6F20576F726C642053726972616D20616E6420476F77726920212121202048656C6C6F20576F726C642053726972616D20616E6420476F7772692021212121"),
  int = ffi.new("long", 123),
  int_1 = ffi.new("long", 54775807),
  integer = ffi.new("long", 20),
  language = "en-US",
  long = ffi.new("long", -9223372036854775807),
  normalizedString = "  This is a name:  Thimmashetty Dasiah   ",
  positiveInteger = ffi.new("long", 1024),
  string = [[  This is a name:
	Thimmashetty	Dasiah  
]],
  token = "This is a name: Thimmashetty Dasiah"
}
--]=]

local t = require("posix.time");
--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
print(t.nanosleep);
--print(debug.getinfo(1).source, debug.getinfo(1).currentline);

local json_str = nil;
local lua_obj = nil;
local xml_str = nil;
local i = 0;
if (nil ~= content) then
	print("+++++++++++++++");
	--xml_str = wvt:to_xml(content);
	while (i < 1) do
		--json_str = wvt:to_json(content);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, json_str);
		--print(json_str);
		--lua_obj = wvt:from_json(json_str);
		--require 'pl.pretty'.dump(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		lua_obj = content;
		--require 'pl.pretty'.dump(lua_obj);
		xml_str = wvt:to_xml(lua_obj);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline);
		--content = wvt:from_xml(xml_str);
		--print(debug.getinfo(1).source, debug.getinfo(1).currentline, xml_str);
		--print(xml_str);
		i = i + 1;
		if (i%1000 == 1) then
			print(i);
		end
		local ts = { tv_sec = 0, tv_nsec = 1000000 } ;
		t.nanosleep(ts);
	end
end

--print(json_str);
print(xml_str);

if (content ~= nil) then os.exit(true); else os.exit(false); end
--[[
--]]

