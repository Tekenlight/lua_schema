ffi = require("ffi");
local xmlua = require("lua_schema.xmlua");


if (#arg < 2) then
	error("Usage: xsd <xsd_file_name> <element_name>");
	return nil;
end

local xsd_name = arg[1];
local ns_name = nil;
local element = nil;
if (#arg > 1) then
	element = arg[2];
else
	element = nil;
end

if (#arg > 2) then
	ns_name = arg[3];
else
	ns_name = nil;
end

if (#arg > 3) then
	error("Usage: xsd <xsd_file_name> <element_name>");
	return nil;
end

local xsd = xmlua.XSD.new();

--local schema = xsd:parse("UBL-BusinessCard-2.3.xsd");
print(xsd_name);
local schema = xsd:parse(xsd_name);
if (schema._ptr == ffi.NULL) then
	error("Unable to parse schema");
end

if (schema._ptr.targetNamespace ~= ffi.NULL) then
	print("TNS ", ffi.string(schema._ptr.targetNamespace));
end

--local element = schema:get_element_decl("BusinessCard", "urn:oasis:names:specification:ubl:schema:xsd:BusinessCard-2");
local element = schema:get_element_decl(element, ns_name);
print("ELEMENT: ", element);
if (element ~= nil and element ~= ffi.NULL) then
	print(ffi.string(element.name));
	print(element.subtypes);
	print("TYPE OF ELEMENT: ", element.subtypes.type);
	print("TYPE OF CONTENT: ", element.subtypes.contentType);
	print(element.type);
	print("Named type:",element.namedType);
	print("Named type ns:",element.namedTypeNs);
	if (element.namedTypeNs ~= ffi.NULL) then
		print("Named type ns:", ffi.string(element.namedTypeNs));
	end
	if (element.namedType ~= ffi.NULL) then
		print("THIS HAS A NAME TYPE:", ffi.string(element.namedType));
	end
end

require 'pl.pretty'.dump(schema);
print(xsd.content_type);
print(xsd.type_type.XML_SCHEMA_TYPE_BASIC);
print(xsd.type_type.XML_SCHEMA_TYPE_SIMPLE);

print("Hello world");
