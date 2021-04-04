ffi = require("ffi");
local xmlua = require("xmlua")


if (#arg < 1) then
	error("Usage: xsd <xsd_file_name>");
	return nil;
end

local xsd_name = arg[1];

if (#arg > 1) then
	error("Usage: xsd <xsd_file_name> <element_name>");
	return nil;
end

local xsd = xmlua.XSD.new();

--local schema = xsd:parse("UBL-BusinessCard-2.3.xsd");
--print(xsd_name);
local schema = xsd:parse(xsd_name);
if (schema._ptr == ffi.NULL) then
	error("Unable to parse schema");
end

if (schema._ptr.targetNamespace ~= ffi.NULL) then
	--print("TNS ", ffi.string(schema._ptr.targetNamespace));
end

local elems_ptr = schema:get_element_decls();
--print(elems_ptr);

local i=0;
if (elems_ptr == ffi.NULL or elems_ptr == nil) then
	print("NO ELEMENTS");
	return;
end
--local v = schema:get_element_decl("example_struct", "http://test_example.com");
--local v = schema:get_element_decl("basic_string_simple_content", "http://test_example.com");
local v = schema:get_element_decl("s3", "http://test_example.com");
for _, v in ipairs(elems_ptr) do
	elem = v._ptr;
	local tns = nil;
	if (elem.targetNamespace ~= ffi.NULL) then
		tns = ffi.string(elem.targetNamespace);
	end
	print("ELEMENT NAMESPACE: ", tns);
	print("ELEMENT NAME: ", ffi.string(elem.name));
	print("ELEMENT TYPE: ", elem.subtypes);
	print("TYPE OF ELEMENT: ", elem.subtypes.type);
	--print("BUILTIN TYPE: ", ffi.string(elem.subtypes.base));
	print("BUILTIN TYPE: ", (elem.subtypes.builtInType));
	print("TYPE OF CONTENT: ", elem.subtypes.contentType);
	if (elem.namedTypeNs ~= ffi.NULL) then
		print("NAMED TYPE NS: ", ffi.string(elem.namedTypeNs));
	end
	if (elem.namedType ~= ffi.NULL) then
		print("NAMED TYPE: ", ffi.string(elem.namedType));
	end
	local attrs = v:get_attr_list();
	print(attrs);
	if (elem.attributes ~= ffi.NULL) then
		print("ATTRIBUTES PRESENT");
	end
	print("-----------------------");
	i = i + 1;
	elem = elems_ptr[i];
end

print("Hello world");
