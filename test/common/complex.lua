ffi = require("ffi");
local xmlua = require("xmlua")

local xsd = xmlua.XSD.new();
if (#arg < 1) then
	error("Usage: xsd <xsd_file_name>");
	return nil;
end
local xsd_name = arg[1];

if (#arg > 1) then
	error("Usage: xsd <xsd_file_name> <element_name>");
	return nil;
end
local schema = xsd:parse(xsd_name);
--require 'pl.pretty'.dump(schema) 
if (schema._ptr == ffi.NULL) then
	error("Unable to parse schema");
end

if (schema._ptr.targetNamespace ~= ffi.NULL) then
	--print("TNS ", ffi.string(schema._ptr.targetNamespace));
end
local elems_ptr = schema:get_element_decls();
local i=0;
if (elems_ptr == ffi.NULL or elems_ptr == nil) then
	print("NO ELEMENTS");
	return;
end

local function xml_schmea_content_model_dump(particle, indent)
	if (particle == ffi.NULL) then
		return;
	end
	local term = particle.children;
	if (term == ffi.NULL) then
		error("Missing particle term");
	end
	--print(indent..term.type);

	if (term.type == xsd.type_type.XML_SCHEMA_TYPE_SEQUENCE) then
		print(indent.."SEQUENCE");
	elseif (term.type == xsd.type_type.XML_SCHEMA_TYPE_CHOICE) then
		print(indent.."CHOICE");
	elseif (term.type == xsd.type_type.XML_SCHEMA_TYPE_ALL) then
		print(indent.."ALL");
	elseif (term.type == xsd.type_type.XML_SCHEMA_TYPE_ELEMENT) then
		local element_ptr = ffi.cast("xmlSchemaElementPtr", term);
		local tns = ''
		if (element_ptr.targetNamespace ~= ffi.NULL) then
			tns = ffi.string(element_ptr.targetNamespace);
		end
		local e = { _ptr = element_ptr};
		print(indent.."ELEMENT:", '{'..tns..'}'..ffi.string(element_ptr.name));
		local ref = schema:schema_get_prop_ptr(particle.node, "ref");
		if (ref ~= '' and ref ~= nil) then
			local qname = schema:get_qname_of_node_prop(particle.node, "ref");
			print(indent.."Ref: ", ref);
			print(indent.."Refnamespace: ", '{'..qname.ns..'}');
			print(indent.."Refname: ", qname.name);
			print(indent.."Namespace: ", '{'..tns..'}');
			print(indent.."Refname: ", ffi.string(element_ptr.name));
		end
	else
		error("UNSUPPORTED");
	end

	print(indent.."MIN OCCURS:",particle.minOccurs);
	if (particle.maxOccurs > xsd.hash_defines.UNBOUNDED) then
		print(indent.."MAX: UNBOUNDED");
	else
		print(indent.."MAX OCCURS:",particle.maxOccurs);
	end
	print();
	if ((term.children ~= ffi.NULL) and 
		( (term.type == xsd.type_type.XML_SCHEMA_TYPE_SEQUENCE) or
		(term.type == xsd.type_type.XML_SCHEMA_TYPE_CHOICE) or
		(term.type == xsd.type_type.XML_SCHEMA_TYPE_ALL) )) then
		--print(term.children);
		xml_schmea_content_model_dump(ffi.cast("xmlSchemaParticlePtr", term.children), indent..'    ');
	end
	if (particle.next ~= ffi.NULL) then
		xml_schmea_content_model_dump(ffi.cast("xmlSchemaParticlePtr", particle.next), indent);
	end

	return;
end

--local v = schema:get_element_decl("s2", "http://test_example.com");
--local v = schema:get_element_decl("example_struct");
local v = schema:get_element_decl("example_struct", "http://test_example.com");
--local v = schema:get_element_decl("s3", "http://test_example.com");
--local v = schema:get_element_decl("BusinessCard", "urn:oasis:names:specification:ubl:schema:xsd:BusinessCard-2");

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
local attrs = v:get_attr_decls();
if (attrs ~= nil) then
	print("ATTRIBUTES PRESENT");
else
	print("ATTRIBUTES NOT PRESENT");
end

local elem_type = elem.subtypes; -- This is <complexType name= etc... 
--print(elem_type.name); -- Can be null;

--print(elem_type.targetNamespace) -- This can also be null.
if (elem_type.type == v.type_type.XML_SCHEMA_TYPE_COMPLEX) then
	print("COMPLEX TYPE");
else
	error("NOT COMPLEX");
end

--print(elem_type.contentType);
if (elem_type.contentType == v.content_type.XML_SCHEMA_CONTENT_ELEMENTS) then
	print("ELEMENTS");
elseif (elem_type.contentType == v.content_type.XML_SCHEMA_CONTENT_SIMPLE or
			elem_type.contentType == v.content_type.XML_SCHEMA_CONTENT_BASIC) then
	print("COMPLEX TYPE SIMPLE CONTENT");
else
	error("UNSUPPORTED");
end

local particle = ffi.cast("xmlSchemaParticlePtr", elem_type.subtypes); -- This way
 -- Content model is at par with elem_type, it is the type of elem_type
--print(particle);
xml_schmea_content_model_dump(particle, '');

print("-----------------------");

