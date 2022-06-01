local xmlua = require("xmlua")
local mhf = require("schema_processor")
local xsd = xmlua.XSD.new();
local basic_stuff = require("lua_schema.basic_stuff");
local stringx = require("pl.stringx");
local c = '';

_G.handler_cache = {};

local function generate_mappings(v)
	local formatted_path = basic_stuff.package_name_from_uri(v.ns).."."..v.name;
	local local_path_parts = stringx.split(formatted_path,"."); 
	local i = 1;
	local local_path = '';
	while(i <= #local_path_parts) do
		if(local_path == '') then
			local_path = local_path_parts[i];
		else
			local_path = local_path.."/"..local_path_parts[i];
		end
		i = i + 1;
	end
	local_path = local_path..".lua";
	local local_pth = local_path:gsub("build/","");
	if(c ~= '') then             
		c = c..",\n"..'\t["'..formatted_path..'"]'..' = '..'"'..local_pth..'"';
    else
        c = '\t["'..formatted_path..'"]'..' = '..'"'..local_pth..'"';
    end
end

local function generate_schema_for_typedef(typedef)
	print(debug.getinfo(1).source, debug.getinfo(1).currentline, typedef.name);
	require 'pl.pretty'.dump(typedef);
	mhf:generate_lua_schema_from_typedef(typedef);
end

local function generate_schema_for_element(element)
	print(debug.getinfo(1).source, debug.getinfo(1).currentline);
	require 'pl.pretty'.dump(element);
	mhf:generate_lua_schema_from_element(element);
end

-- Main()
--
--if (#arg ~= 1) then
--	error("Usage geneate_schema <xsd_file>");
--	os.exit(-1);
--end
--
local xsd_name = arg[1];
local schema = xsd:parse(xsd_name);

local elems = schema:get_element_decls();
if (elems ~= nil) then
	for _, v in ipairs(elems) do
		generate_schema_for_element(v);
		generate_mappings(v);
	end
end

local types = schema:get_type_defs();
if (types ~= nil) then
	for _, v in ipairs(types) do
		generate_schema_for_typedef(v);
		generate_mappings(v);
	end
end

header = "local build_mappings = {\n"
footer = '\n}'.."\n\nreturn build_mappings;"
c = header..c..footer;
xsd_file = xsd_name:gsub("xsd/","");
xsd_file = xsd_file:gsub("%.%.","");
local module = xsd_file:gsub("_data_structures.xsd","");
local target_file_path = "com/biop/"..module.."/"..xsd_file:gsub(".xsd$","").."_xsd.lua";
local file = io.open(target_file_path,"w+");
file:write(c)
_G.handler_cache = nil;

