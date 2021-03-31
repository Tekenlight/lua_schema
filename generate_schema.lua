local xmlua = require("xmlua")
local mhf = require("message_handler_factory")
local xsd = xmlua.XSD.new();


local function generate_schema_for_element(element)
	require 'pl.pretty'.dump(element);
	mhf:generate_lua_schema_from_element(element);
end

-- Main()
--
if (#arg ~= 1) then
	error("Usage geneate_schema <xsd_file>");
	os.exit(-1);
end
local xsd_name = arg[1];

local schema = xsd:parse(xsd_name);
local elems = schema:get_element_decls();

--require 'pl.pretty'.dump(elems);
for _, v in ipairs(elems) do
	generate_schema_for_element(v)
end

