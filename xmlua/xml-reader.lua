local XMLReader = {}

local ffi = require("ffi")
local libxml2 = require("xmlua.libxml2")
local converter = require("xmlua.converter")
local to_string = converter.to_string

local methods = {}

local metatable = {}

methods.node_types = {
	XML_READER_TYPE_NONE = ffi.C.XML_READER_TYPE_NONE,
    XML_READER_TYPE_ELEMENT = ffi.C.XML_READER_TYPE_ELEMENT,
    XML_READER_TYPE_ATTRIBUTE = ffi.C.XML_READER_TYPE_ATTRIBUTE,
    XML_READER_TYPE_TEXT = ffi.C.XML_READER_TYPE_TEXT,
    XML_READER_TYPE_CDATA = ffi.C.XML_READER_TYPE_CDATA,
    XML_READER_TYPE_ENTITY_REFERENCE = ffi.C.XML_READER_TYPE_ENTITY_REFERENCE,
    XML_READER_TYPE_ENTITY = ffi.C.XML_READER_TYPE_ENTITY,
    XML_READER_TYPE_PROCESSING_INSTRUCTION = ffi.C.XML_READER_TYPE_PROCESSING_INSTRUCTION,
    XML_READER_TYPE_COMMENT = ffi.C.XML_READER_TYPE_COMMENT,
    XML_READER_TYPE_DOCUMENT = ffi.C.XML_READER_TYPE_DOCUMENT,
    XML_READER_TYPE_DOCUMENT_TYPE = ffi.C.XML_READER_TYPE_DOCUMENT_TYPE,
    XML_READER_TYPE_DOCUMENT_FRAGMENT = ffi.C.XML_READER_TYPE_DOCUMENT_FRAGMENT,
    XML_READER_TYPE_NOTATION = ffi.C.XML_READER_TYPE_NOTATION,
    XML_READER_TYPE_WHITESPACE = ffi.C.XML_READER_TYPE_WHITESPACE,
    XML_READER_TYPE_SIGNIFICANT_WHITESPACE = ffi.C.XML_READER_TYPE_SIGNIFICANT_WHITESPACE,
    XML_READER_TYPE_END_ELEMENT = ffi.C.XML_READER_TYPE_END_ELEMENT,
    XML_READER_TYPE_END_ENTITY = ffi.C.XML_READER_TYPE_END_ENTITY,
    XML_READER_TYPE_XML_DECLARATION = ffi.C.XML_READER_TYPE_XML_DECLARATION
};

function metatable.__index(element, key)
  return methods[key];
end

function methods:read()
	local ret = libxml2.xmlTextReaderRead(self._cReader);
	if (ret ~= 1 and ret ~= 0) then
		error('failed to parse');
	end
	return ret;
end

function methods:const_name()
	local c_name = libxml2.xmlTextReaderConstName(self._cReader);
	local name = nil;
	if (c_name ~= ffi.NULL) then
		name = to_string(c_name);
	end
	return name;
end

function methods:const_local_name()
	local local_name = libxml2.xmlTextReaderConstLocalName(self._cReader);
	local name = nil;
	if (local_name ~= ffi.NULL) then
		name = to_string(local_name);
	end
	return name;
end

function methods:const_namespace_uri()
	local namespace_uri = libxml2.xmlTextReaderConstNamespaceUri(self._cReader);
	local uri = nil;
	if (namespace_uri ~= ffi.NULL) then
		uri = to_string(namespace_uri);
	end
	return uri;
end

function methods:const_value()
	local c_value = libxml2.xmlTextReaderConstValue(self._cReader);
	local value = nil;
	if (c_value ~= ffi.NULL) then
		value = to_string(c_value);
	end
	return value;
end

function methods:node_type()
	local node_type = libxml2.xmlTextReaderNodeType(self._cReader);
	return node_type;
end

function methods:node_depth()
	local depth = libxml2.xmlTextReaderDepth(self._cReader);
	return depth;
end

function methods:node_is_empty_element()
	local is_empty = libxml2.xmlTextReaderIsEmptyElement(self._cReader);
	return (is_empty ~= 0);
end

function methods:node_reader_has_value()
	local reader_has_value = libxml2.xmlTextReaderHasValue(self._cReader);
	return (reader_has_value ~= 0);
end

function methods:get_attr_count()
	return libxml2.xmlTextReaderAttributeCount(self._cReader);
end

function methods:get_attr_no(n)
	return libxml2.xmlTextReaderGetAttributeNo(self._cReader, n);
end

function methods:is_namespace_decl()
	return libxml2.xmlTextReaderIsNamespaceDecl(self._cReader)
end

function methods:move_to_attr_no(n)
	local ret = libxml2.xmlTextReaderMoveToAttributeNo(self._cReader, n);
	if (ret ~= 1) then
		local msg = 'Attribute no. '..n..' not there';
		error(msg);
	end
	return ret;
end

function XMLReader.new(xml)
	local cXmlReader = libxml2.xmlReaderForMemory(xml);
	if not cXmlReader then
		error("Failed to create reader to parse XML")
	end
	local reader = {
		_cReader = cXmlReader;
	}
	setmetatable(reader, metatable);
	return reader;
end

return XMLReader;

