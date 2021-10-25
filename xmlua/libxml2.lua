local libxml2 = {}

require("xmlua.libxml2.memory")
require("xmlua.libxml2.global")
require("xmlua.libxml2.xmlstring")
require("xmlua.libxml2.xmlerror")
require("xmlua.libxml2.dict")
require("xmlua.libxml2.hash")
require("xmlua.libxml2.tree")
require("xmlua.libxml2.valid")
require("xmlua.libxml2.encoding")
require("xmlua.libxml2.parser")
require("xmlua.libxml2.html-parser")
require("xmlua.libxml2.html-tree")
require("xmlua.libxml2.xmlsave")
require("xmlua.libxml2.xpath")
require("xmlua.libxml2.entities")
require("xmlua.libxml2.schemas")
require("xmlua.libxml2.relaxng")
require("xmlua.libxml2.reader")
require("xmlua.libxml2.reader")
require("xmlua.libxml2.schemas")
require("xmlua.libxml2.xmlregexp")
require("xmlua.libxml2.schemas_structures")
require("xmlua.libxml2.xmlschemastypes")

local ffi = require("ffi")
local loaded, xml2 = pcall(ffi.load, "xml2")
if not loaded then
  --[[if _G.jit.os == "Windows" then
    xml2 = ffi.load("libxml2-2.dll")
  else
    xml2 = ffi.load("libxml2.so.2")
  end
  --]]
  xml2 = ffi.load("libxml2.so.2")
end
local function __xmlParserVersionIsAvailable()
  local success, err = pcall(function()
      local func = xml2.__xmlParserVersion
  end)
  return success
end

local xmlParserVersion
if __xmlParserVersionIsAvailable() then
  xmlParserVersion = xml2.__xmlParserVersion()[0]
else
  xmlParserVersion = xml2.xmlParserVersion
end

libxml2.VERSION = ffi.string(xmlParserVersion)
libxml2.XML_SAX2_MAGIC = 0xDEEDBEAF

local function __xmlMallocIsAvailable()
  local success, err = pcall(function()
      local func = xml2.__xmlMalloc
  end)
  return success
end

if __xmlMallocIsAvailable() then
  libxml2.xmlMalloc = xml2.__xmlMalloc()
else
  libxml2.xmlMalloc = xml2.xmlMalloc
end

local function __xmlFreeIsAvailable()
  local success, err = pcall(function()
      local func = xml2.__xmlFree
  end)
  return success
end

if __xmlFreeIsAvailable() then
  libxml2.xmlFree = xml2.__xmlFree()
else
  libxml2.xmlFree = xml2.xmlFree
end

libxml2.xmlInitParser = xml2.xmlInitParser
libxml2.xmlCleanupParser = xml2.xmlCleanupParser

function libxml2.htmlNewParserCtxt()
  local context = xml2.htmlNewParserCtxt()
  if context == ffi.NULL then
    return nil
  end
  return ffi.gc(context, xml2.htmlFreeParserCtxt)
end

function libxml2.htmlCreatePushParserCtxt(filename, encoding)
  local context = xml2.htmlCreatePushParserCtxt(nil, nil, nil, 0, filename, encoding)
  if context == ffi.NULL then
    return nil
  end
  return ffi.gc(context, xml2.htmlFreeParserCtxt)
end

function libxml2.htmlParseChunk(context, chunk, is_terminated)
  if chunk then
    return xml2.htmlParseChunk(context, chunk, #chunk, is_terminated)
  else
    return xml2.htmlParseChunk(context, nil, 0, is_terminated)
  end
end
--jit.off(libxml2.htmlParseChunk)

function libxml2.htmlCtxtReadMemory(context, html, options)
  local url = nil
  local encoding = nil
  if options then
    url = options.url
    encoding = options.encoding
  end
  local parse_options = ffi.C.HTML_PARSE_RECOVER| ffi.C.HTML_PARSE_NOERROR| ffi.C.HTML_PARSE_NOWARNING| ffi.C.HTML_PARSE_NONET
  local document = xml2.htmlCtxtReadMemory(context,
                                           html,
                                           #html,
                                           url,
                                           encoding,
                                           parse_options)
  if document == ffi.NULL then
    return nil
  end
  return ffi.gc(document, libxml2.xmlFreeDoc)
end
--jit.off(libxml2.htmlCtxtReadMemory)

function libxml2.htmlNewDoc(uri, externa_dtd)
  local document = xml2.htmlNewDoc(uri, externa_dtd)
  if document == ffi.NULL then
    return nil
  end
  return ffi.gc(document, libxml2.xmlFreeDoc)
end

function libxml2.xmlNewParserCtxt()
  local context = xml2.xmlNewParserCtxt()
  if context == ffi.NULL then
    return nil
  end
  return ffi.gc(context, xml2.xmlFreeParserCtxt)
end

function libxml2.xmlCreatePushParserCtxt(filename)
  local context = xml2.xmlCreatePushParserCtxt(nil, nil, nil, 0, filename)
  if context == ffi.NULL then
    return nil
  end
  return ffi.gc(context, xml2.xmlFreeParserCtxt)
end

local function parse_xml_parse_options(value, default)
  if value == nil then
    return default
  end
  local value_type = type(value)
  if value_type == "table" then
    local options = 0
    for _, v in pairs(value) do
      options = (options| parse_xml_parse_options(v, default))
    end
    return options
  elseif value_type == "number" then
    return value
  elseif value_type == "string" then
    if value == "default" then
      return default
    end
    value = value:upper()
    if value:sub(1, #"XML_PARSE_") ~= "XML_PARSE_" then
      value = "XML_PARSE_" .. value
    end
    return ffi.C[value]
  else
    error("Unsupported XML parse options: " .. value_type .. ": " .. value)
  end
end

function libxml2.xmlCtxtReadMemory(context, xml, options)
  local url = nil
  local encoding = nil
  local default_parse_options = (ffi.C.XML_PARSE_RECOVER| ffi.C.XML_PARSE_NOERROR| ffi.C.XML_PARSE_NOWARNING| ffi.C.XML_PARSE_NONET)
  local parse_options = nil
  if options then
    url = options.url
    encoding = options.encoding
    parse_options = parse_xml_parse_options(options.parse_options,
                                            default_parse_options)
  end
  if parse_options == nil then
    parse_options = default_parse_options
  end
  local document = xml2.xmlCtxtReadMemory(context,
                                          xml,
                                          #xml,
                                          url,
                                          encoding,
                                          parse_options)
  if document == ffi.NULL then
    return nil
  end
  return ffi.gc(document, libxml2.xmlFreeDoc)
end
--jit.off(libxml2.xmlCtxtReadMemory)

function libxml2.xmlParseChunk(context, chunk, is_terminated)
  if chunk then
    return xml2.xmlParseChunk(context, chunk, #chunk, is_terminated)
  else
    return xml2.xmlParseChunk(context, nil, 0, is_terminated)
  end
end

libxml2.xmlFreeDoc = xml2.xmlFreeDoc

function libxml2.xmlDocGetRootElement(document)
  local root = xml2.xmlDocGetRootElement(document)
  if root == ffi.NULL then
    return nil
  end
  return root
end


local function xmlPreviousElementSiblingIsBuggy()
  local xml = "<root><child1/>text<child2/></root>"
  local context = libxml2.xmlNewParserCtxt()
  local document = libxml2.xmlCtxtReadMemory(context, xml)
  local root = xml2.xmlDocGetRootElement(document)
  local child2 = xml2.xmlLastElementChild(root)
  return xml2.xmlPreviousElementSibling(child2) == child2
end

if xmlPreviousElementSiblingIsBuggy() then
  -- For libxml2 < 2.7.7. CentOS 6 ships libxml2 2.7.6.
  function libxml2.xmlPreviousElementSibling(node)
    local node = node.prev
    while node ~= ffi.NULL do
      if tonumber(node.type) == ffi.C.XML_ELEMENT_NODE then
        return node
      end
      node = node.prev
    end
    return nil
  end
else
  function libxml2.xmlPreviousElementSibling(node)
    local element = xml2.xmlPreviousElementSibling(node)
    if element == ffi.NULL then
      return nil
    end
    return element
  end
end

function libxml2.xmlNextElementSibling(node)
  local element = xml2.xmlNextElementSibling(node)
  if element == ffi.NULL then
    return nil
  end
  return element
end

function libxml2.xmlFirstElementChild(node)
  local element = xml2.xmlFirstElementChild(node)
  if element == ffi.NULL then
    return nil
  end
  return element
end

libxml2.xmlFreeNs = xml2.xmlFreeNs;
function libxml2.xmlNewNs(node, uri, prefix)
  local new_namespace = xml2.xmlNewNs(node, uri, prefix)
  if new_namespace == ffi.NULL then
    return nil
  end
  --return ffi.gc(new_namespace, libxml2.xmlFreeNs)
  --Bug fix, to avoid double garbage collection.
  if (node == ffi.NULL) then
	  -- If node is nil, the namespace that will get created
	  -- will be a dangling pointer
	  -- It should have an independent gc action
	  return ffi.gc(new_namespace, libxml2.xmlFreeNs)
  else
	  return new_namespace
  end
end


function libxml2.xmlSetNs(node, namespace)
  xml2.xmlSetNs(node, namespace);
  ffi.gc(namespace, nil);
  return
end

function libxml2.xmlNewDoc(xml_version)
  local document = xml2.xmlNewDoc(xml_version)
  if document == ffi.NULL then
    return nil
  end
  return ffi.gc(document, libxml2.xmlFreeDoc)
end

function libxml2.xmlDocSetRootElement(document, root)
  return xml2.xmlDocSetRootElement(document, root)
end

function libxml2.xmlCopyNode(node, extended)
  return xml2.xmlCopyNode(node, extended);
end

function libxml2.xmlNewNode(namespace, name)
  local new_element = xml2.xmlNewNode(namespace, name)
  return new_element
end

function libxml2.xmlNewText(content)
  return xml2.xmlNewText(content)
end

function libxml2.xmlTextConcat(node,
                               content,
                               content_length)
  local status = xml2.xmlTextConcat(node,
                                    content,
                                    content_length)
  return status == 0
end

function libxml2.xmlTextMerge(merged_node, merge_node)
  local was_freed = (merged_node.type == ffi.C.XML_TEXT_NODE
                     and merge_node.type == ffi.C.XML_TEXT_NODE
                     and merged_node.name == merge_node.name)
  xml2.xmlTextMerge(merged_node, merge_node)
  if was_freed then
    ffi.gc(merge_node, nil)
  end
  return was_freed
end

libxml2.xmlFreeNode = xml2.xmlFreeNode;

function libxml2.xmlNewCDataBlock(document,
                                  content,
                                  content_length)
  local new_cdata_block =
    xml2.xmlNewCDataBlock(document,
                          content,
                          content_length)
  if new_cdata_block == ffi.NULL then
    return nil
  end
  return ffi.gc(new_cdata_block, libxml2.xmlFreeNode)
end

function libxml2.xmlNewComment(content)
  local new_comment =
    xml2.xmlNewComment(content)
  if new_comment == ffi.NULL then
    return nil
  end
  return ffi.gc(new_comment, libxml2.xmlFreeNode)
end

libxml2.xmlFreeDtd = xml2.xmlFreeDtd;
function libxml2.xmlCreateIntSubset(document,
                                    name,
                                    external_id,
                                    system_id)
  local new_dtd =
    xml2.xmlCreateIntSubset(document,
                            name,
                            external_id,
                            system_id)
  if new_dtd == ffi.NULL then
    return nil
  end
  return ffi.gc(new_dtd, libxml2.xmlFreeDtd)
end

function libxml2.xmlGetIntSubset(document)
  local raw_internal_subset = xml2.xmlGetIntSubset(document)
  if raw_internal_subset == ffi.NULL then
    return nil
  end
  return raw_internal_subset
end

function libxml2.xmlNewDocFragment(document)
  local new_document_fragment =
    xml2.xmlNewDocFragment(document)
  if new_document_fragment == ffi.NULL then
    return nil
  end
  return ffi.gc(new_document_fragment,
                libxml2.xmlFreeNode)
end

function libxml2.xmlNewReference(document, name)
  local new_reference =
    xml2.xmlNewReference(document, name)
  if new_reference == ffi.NULL then
    return nil
  end
  return ffi.gc(new_reference,
                libxml2.xmlFreeNode)
end

function libxml2.xmlNewPI(name, content)
  local new_pi = xml2.xmlNewPI(name, content)
  if new_pi == ffi.NULL then
    return nil
  end
  return ffi.gc(new_pi, libxml2.xmlFreeNode)
end

function libxml2.xmlAddPrevSibling(sibling, new_sibling)
  local was_freed = (sibling.type == ffi.C.XML_TEXT_NODE
                     and new_sibling.type == ffi.C.XML_TEXT_NODE)
                     or
                     (sibling.type == ffi.C.XML_TEXT_NODE
                      and sibling.prev ~= ffi.NULL
                      and sibling.prev.type == ffi.C.XML_TEXT_NODE
                      and sibling.name == sibling.prev.name)
  local new_node = xml2.xmlAddPrevSibling(sibling, new_sibling)
  if new_node == ffi.NULL then
    new_node = nil
  else
    if was_freed then
      ffi.gc(new_sibling, nil)
    end
  end
  return new_node, was_freed
end

function libxml2.xmlAddSibling(sibling, new_sibling)
  local was_freed = (sibling.type == ffi.C.XML_TEXT_NODE
                     and new_sibling.type == ffi.C.XML_TEXT_NODE
                     and sibling.name == new_sibling.name)
  local new_node = xml2.xmlAddSibling(sibling, new_sibling)
  if new_node ~= ffi.NULL and was_freed then
    ffi.gc(new_sibling, nil)
  end
  return was_freed
end

function libxml2.xmlAddNextSibling(sibling, new_sibling)
  local was_freed = (sibling.type == ffi.C.XML_TEXT_NODE
                     and new_sibling.type == ffi.C.XML_TEXT_NODE)
                     or
                     (sibling.type == ffi.C.XML_TEXT_NODE
                      and sibling.next ~= ffi.NULL
                      and sibling.next.type == ffi.C.XML_TEXT_NODE
                      and sibling.name == sibling.next.name)
  local new_node = xml2.xmlAddNextSibling(sibling, new_sibling)
  if new_node ~= ffi.NULL and was_freed then
    ffi.gc(new_sibling, nil)
  end
  return was_freed
end

function libxml2.xmlAddChild(parent, child)
  local child_node = xml2.xmlAddChild(parent, child)
  if child_node == ffi.NULL then
    child_node = nil
  end
  return child_node
end

function libxml2.xmlSearchNs(document, node, namespace_prefix)
  local namespace = xml2.xmlSearchNs(document, node, namespace_prefix)
  if namespace == ffi.NULL then
    return nil
  end
  return namespace
end

function libxml2.xmlSearchNsByHref(document, node, href)
  local namespace = xml2.xmlSearchNsByHref(document, node, href)
  if namespace == ffi.NULL then
    return nil
  end
  return namespace
end

function libxml2.xmlGetNoNsProp(node, name)
  local value = xml2.xmlGetNoNsProp(node, name)
  if value == ffi.NULL then
    return nil
  end
  local lua_string = ffi.string(value)
  libxml2.xmlFree(value)
  return lua_string
end

function libxml2.xmlGetNsProp(node, name, namespace_uri)
  local value = xml2.xmlGetNsProp(node, name, namespace_uri)
  if value == ffi.NULL then
    return nil
  end
  local lua_string = ffi.string(value)
  libxml2.xmlFree(value)
  return lua_string
end

function libxml2.xmlGetProp(node, name)
  local value = xml2.xmlGetProp(node, name)
  if value == ffi.NULL then
    return nil
  end
  local lua_string = ffi.string(value)
  libxml2.xmlFree(value)
  return lua_string
end

function libxml2.xmlNewNsProp(node, namespace, name, value)
  xml2.xmlNewNsProp(node, namespace, name, value)
end

function libxml2.xmlNewProp(node, name, value)
  return xml2.xmlNewProp(node, name, value)
end

function libxml2.xmlUnsetNsProp(node, namespace, name)
  xml2.xmlUnsetNsProp(node, namespace, name)
end

function libxml2.xmlUnsetProp(node, name)
  xml2.xmlUnsetProp(node, name)
end

function libxml2.xmlNodeSetContent(node, content)
  if (content ~= nul and content ~= ffi.NULL) then
    xml2.xmlNodeSetContentLen(node, content, #content)
  else
    xml2.xmlNodeSetContentLen(node, nil, 0)
  end
end

function libxml2.xmlNodeGetContent(node)
  local content = xml2.xmlNodeGetContent(node)
  if content == ffi.NULL then
    return nil
  end
  local lua_string = ffi.string(content)
  libxml2.xmlFree(content)
  return lua_string
end

function libxml2.xmlIsLeafNode(doc, node)
	local i = xml2.xmlIsLeafNode(doc, node);
	if (i == 1) then
		return true;
	else
		return false;
	end
end

function libxml2.xmlNodeListGetString(doc, node)
  local content = xml2.xmlNodeListGetString(doc, node.children, 1)
  if content == ffi.NULL then
    return nil
  end
  local lua_string = ffi.string(content)
  libxml2.xmlFree(content)
  return lua_string
end

function libxml2.xmlReplaceNode(old_node, new_node)
  local was_freed = false
  local was_unlinked = (old_node ~= new_node
                       or
                       (old_node.type == ffi.C.XML_ATTRIBUTE_NODE
                        and new_node.type ~= ffi.C.XML_ATTRIBUTE_NODE)
                       or
                       (old_node.type ~= ffi.C.XML_ATTRIBUTE_NODE
                        and new_node.type == ffi.C.XML_ATTRIBUTE_NODE))
  local old = xml2.xmlReplaceNode(old_node, new_node)
  if old ~= ffi.NULL and was_unlinked then
	ffi.gc(old_node, nil);
    xml2.xmlFreeNode(old_node)
    was_freed = true
  end
  return was_freed
end

function libxml2.xmlGetNodePath(node)
  local path = xml2.xmlGetNodePath(node)
  if path == ffi.NULL then
    return nil
  end
  local lua_string = ffi.string(path)
  libxml2.xmlFree(path)
  return lua_string
end

function libxml2.xmlUnlinkNode(node)
  xml2.xmlUnlinkNode(node)
  xml2.xmlSetTreeDoc(node, ffi.NULL)
  return ffi.gc(node, xml2.xmlFreeNode)
end


function libxml2.xmlBufferCreate()
  return ffi.gc(xml2.xmlBufferCreate(), xml2.xmlBufferFree)
end

function libxml2.xmlBufferGetContent(buffer)
  return ffi.string(buffer.content, buffer.use)
end

libxml2.xmlSaveToBuffer = xml2.xmlSaveToBuffer
libxml2.xmlSaveClose = xml2.xmlSaveClose
libxml2.xmlSaveSetEscape = xml2.xmlSaveSetEscape

function libxml2.xmlSaveDoc(context, document)
  local written = xml2.xmlSaveDoc(context, document)
  return written ~= -1
end
--jit.off(libxml2.xmlSaveDoc)

function libxml2.xmlSaveTree(context, node)
  local written = xml2.xmlSaveTree(context, node)
  return written ~= -1
end
--jit.off(libxml2.xmlSaveTree)

local function error_ignore(user_data, err)
end
local c_error_ignore = ffi.cast("xmlStructuredErrorFunc", error_ignore)
ffi.gc(c_error_ignore, function(callback) callback:free() end)

function libxml2.xmlXPathNewContext(document)
  local context = xml2.xmlXPathNewContext(document)
  if context == ffi.NULL then
    return nil
  end
  context.error = c_error_ignore
  return ffi.gc(context, xml2.xmlXPathFreeContext)
end

local function xmlXPathSetContextNodeIsAvailable()
  local success, err = pcall(function()
      local func = xml2.xmlXPathSetContextNode
  end)
  return success
end

if xmlXPathSetContextNodeIsAvailable() then
  function libxml2.xmlXPathSetContextNode(node, context)
    local status = xml2.xmlXPathSetContextNode(node, context)
    return status == 0
  end
else
  function libxml2.xmlXPathSetContextNode(node, context)
    if not node then
      return false
    end
    context.node = node
    return true
  end
end
--jit.off(libxml2.xmlXPathSetContextNode)

function libxml2.xmlXPathEvalExpression(expression, context)
  local object = xml2.xmlXPathEvalExpression(expression, context)
  if object == ffi.NULL then
    return nil
  end
  return ffi.gc(object, xml2.xmlXPathFreeObject)
end
--jit.off(libxml2.xmlXPathEvalExpression)

function libxml2.xmlStrdup(string)
  return xml2.xmlStrdup(string)
end

function libxml2.xmlAddDocEntity(document,
                                 name,
                                 entity_type,
                                 external_id,
                                 system_id,
                                 content)
  return xml2.xmlAddDocEntity(document,
                              name,
                              entity_type,
                              external_id,
                              system_id,
                              content)
end

function libxml2.xmlAddDtdEntity(document,
                                 name,
                                 entity_type,
                                 external_id,
                                 system_id,
                                 content)
  return xml2.xmlAddDtdEntity(document,
                              name,
                              entity_type,
                              external_id,
                              system_id,
                              content)
end

function libxml2.xmlGetDocEntity(document, name)
  return xml2.xmlGetDocEntity(document, name)
end

function libxml2.xmlGetDtdEntity(document, name)
 return xml2.xmlGetDtdEntity(document, name)
end

libxml2.xmlFreeTextReader = xml2.xmlFreeTextReader;

function libxml2.xmlReaderForMemory(xml)
  local url = nil;
  local encoding = nil;
  local options = 0;

  local reader = xml2.xmlReaderForMemory(xml, #xml, url, encoding, options)
  if reader == ffi.NULL then
    return nil
  end
  return ffi.gc(reader, function(reader)
	  libxml2.xmlFreeTextReader(reader);
	  --libxml2.xmlCleanupParser();
  end);
end

function libxml2.xmlTextReaderRead(reader)
	return xml2.xmlTextReaderRead(reader);
end

function libxml2.xmlTextReaderConstName(reader)
	return xml2.xmlTextReaderConstName(reader);
end

function libxml2.xmlTextReaderConstLocalName(reader)
	return xml2.xmlTextReaderConstLocalName(reader);
end

function libxml2.xmlTextReaderConstNamespaceUri(reader)
	return xml2.xmlTextReaderConstNamespaceUri(reader);
end

function libxml2.xmlTextReaderConstValue(reader)
	return xml2.xmlTextReaderConstValue(reader);
end

function libxml2.xmlTextReaderIsEmptyElement(reader)
	return xml2.xmlTextReaderIsEmptyElement(reader);
end

function libxml2.xmlTextReaderHasValue(reader)
	return xml2.xmlTextReaderHasValue(reader);
end

function libxml2.xmlTextReaderDepth(reader)
	return xml2.xmlTextReaderDepth(reader);
end

function libxml2.xmlTextReaderNodeType(reader)
	return xml2.xmlTextReaderNodeType(reader);
end

function libxml2.xmlTextReaderAttributeCount(reader)
	return xml2.xmlTextReaderAttributeCount(reader);
end

function libxml2.xmlTextReaderGetAttributeNo(reader, n)
	local c_str_attr = xml2.xmlTextReaderGetAttributeNo(reader, n);
	local attr_string = ffi.string(c_str_attr);
	libxml2.xmlFree(c_str_attr);
	return attr_string;
end

function libxml2.xmlTextReaderMoveToAttributeNo(reader, n)
	return xml2.xmlTextReaderMoveToAttributeNo(reader, n);
end

function libxml2.xmlTextReaderIsNamespaceDecl(reader)
	local i_ret = xml2.xmlTextReaderIsNamespaceDecl(reader);
	return (i_ret == 1);
end

function libxml2.xmlLineNumbersDefault(n)
	return xml2.xmlLineNumbersDefault(n);
end

function libxml2.xmlSchemaNewParserCtxt(filename)
	if (filename == nil or type(filename) ~= 'string') then
		error('file name must be a non nil string');
		return nil;
	end
	local ctxt = xml2.xmlSchemaNewParserCtxt(filename);
	xml2.xmlSchemaSetParserErrors(ctxt, ffi.NULL, ffi.NULL, ffi.stderr);
	if (ctxt == ffi.NULL) then return nil; end
	return ffi.gc(ctxt, xml2.xmlSchemaFreeParserCtxt)
end

function libxml2.xmlSchemaParse(ctxt)
	local schema = xml2.xmlSchemaParse(ctxt);
	if (schema == ffi.NULL) then return nil; end
	return ffi.gc(schema, xml2.xmlSchemaFree)
end

function libxml2.xmlGetTargetNs(schema)
	local ns = nil;
	if (schema.targetNamespace ~= ffi.NULL) then
		ns = ffi.string(schema.targetNamespace);
	end
	return ns;
end

function libxml2.xmlSchemaGetType(schema, name, nsName);
	if (name == nil or type(name) ~= 'string') then
		error('name must be a non nil string');
		return nil;
	end
	if (nsName == nil or nsName == "") then
		nsName =  ffi.NULL;
	end
	if (schema == ffi.NULL) then
		error('schema  must not be NULL');
		return nil;
	end
	local schema_type = xml2.xmlSchemaGetType(schema, name, nsName);
	if (schema_type == ffi.NULL) then return nil; end
	return schema_type;
end

function libxml2.xmlSchemaGetElem(schema, name, nsName);
	if (name == nil or type(name) ~= 'string') then
		error('name must be a non nil string');
		return nil;
	end
	if (nsName == nil or nsName == "") then
		nsName =  ffi.NULL;
	end
	if (schema == ffi.NULL) then
		error('schema  must not be NULL');
		return nil;
	end
	local elem_decl = xml2.xmlSchemaGetElem(schema, name, nsName);
	if (elem_decl == ffi.NULL) then return nil; end
	return elem_decl;
end

function libxml2.xmlSchemaGetModelGroupDef(schema, name, nsName);
	if (name == nil or type(name) ~= 'string') then
		error('name must be a non nil string');
		return nil;
	end
	if (nsName == nil or nsName == "") then
		nsName =  ffi.NULL;
	end
	if (schema == ffi.NULL) then
		error('schema  must not be NULL');
		return nil;
	end
	local mgr_def = xml2.xmlSchemaGetModelGroupDef(schema, name, nsName);
	if (mgr_def == ffi.NULL) then return nil; end
	return mgr_def;
end

ffi.cdef[[
void free(void *ptr);
]]

function libxml2.xmlSchemaGetGlobalElements(schema);
	if (schema == ffi.NULL) then
		error('schema  must not be NULL');
		return nil;
	end
	local elem_decls = xml2.xmlSchemaGetGlobalElements(schema);
	if (elem_decls == ffi.NULL) then return nil; end
	return ffi.gc(elem_decls, ffi.C.free)
end

function libxml2.xmlSchemaGetGlobalTypeDefs(schema);
	if (schema == ffi.NULL) then
		error('schema  must not be NULL');
		return nil;
	end
	local type_defs = xml2.xmlSchemaGetGlobalTypeDefs(schema);
	if (type_defs == ffi.NULL) then return nil; end
	return ffi.gc(type_defs, ffi.C.free)
end

function libxml2.xmlSchemaGetGlobalModelGroupDefs(schema);
	if (schema == ffi.NULL) then
		error('schema  must not be NULL');
		return nil;
	end
	local mgr_defs = xml2.xmlSchemaGetGlobalModelGroupDefs(schema);
	if (mgr_defs == ffi.NULL) then return nil; end
	return ffi.gc(mgr_defs, ffi.C.free)
end

function libxml2.xmlGetAttributeList(typedef)
	if (typedef == nil or typedef == ffi.NULL) then
		error("Input element should not be NULL");
		return nil;
	end
	return ffi.cast("xmlSchemaItemListPtr",typedef.attrUses);
end

function libxml2.xmlSchemaGetQNameOfProp(ctxt, schema, node, propName)
	if (ctxt == nil or schema == nil or node == nil or propName == nil) then
		error("Any of the inputs cannot be nil");
	end
	if (ctxt == ffi.NULL or schema == ffi.NULL or node == ffi.NULL or propName == ffi.NULL) then
		error("Any of the inputs cannot be NULL");
	end
	local qname = xml2.xmlSchemaGetQNameOfProp(ctxt, schema, node, propName);
	if (qname == nil or qname == ffi.NULL) then
		return nil;
	end
	return ffi.gc(qname, xml2.xmlFreeSchemaQnamePtr);
end

function libxml2.xmlRegexpCompile(s_exp)
	local regexp = xml2.xmlRegexpCompile(s_exp);
	return ffi.gc(regexp, xml2.xmlRegFreeRegexp);
end

function libxml2.xmlRegexpPrintToStdOut(regexp)
	xml2.xmlRegexpPrintToStdOut(regexp);
	return;
end

function libxml2.xmlRegexpExec(comp, value)
	local ret =  xml2.xmlRegexpExec(comp, value);
	if (ret < 0) then
		error("Checking of value against expression failed for ["..value.."]");
	end
	return ret;
end

function libxml2.isDateValid(built_in_type_id, datetime)
	if (built_in_type_id == nil or datetime == nil or type(datetime) ~= 'string') then
		error("Invalid inputs to xmlSchemaValidateDates");
	end
	local valid = xml2.xmlSchemaValidateDates(built_in_type_id, datetime, ffi.NULL, 1);
	if (valid == 0) then return true;
	else return false;
	end
end

libxml2.xmlSchemaFreeValue = xml2.xmlSchemaFreeValue;

function libxml2.strToDate(built_in_type_id, datetime)
	local date_val_ptr_arr = ffi.new("xmlSchemaValPtr[?]", 1);
	if (built_in_type_id == nil or datetime == nil or type(datetime) ~= 'string') then
		error("Invalid inputs to xmlSchemaValidateDates");
	end
	local valid = xml2.xmlSchemaValidateDates(built_in_type_id, datetime, date_val_ptr_arr, 1);
	if (valid == 0) then
		local date_val_ptr = ffi.gc(date_val_ptr_arr[0], libxml2.xmlSchemaFreeValue);
		return true, date_val_ptr.value.date;
	else
		return false, nil;
	end
end

libxml2.xmlSchemaCompareDates = xml2.xmlSchemaCompareDates;

libxml2.xmlSchemaValidateDuration = function(duration)
	if (duration == nil) then
		error("Invalid inputs to xmlSchemaValidateDates");
	end
	local val = ffi.new("xmlSchemaValPtr[?]", 1);
	local ret = xml2.xmlSchemaValidateDuration(ffi.NULL, duration, val, 1);
	if (ret == 0) then
		local dur_val_ptr = ffi.gc(val[0], libxml2.xmlSchemaFreeValue);
		return true, dur_val_ptr.value.dur;
	else
		return false, nil;
	end
end

libxml2.xmlXPathRegisterNs = function(ctxt, prefix, ns_uri)
	local ret = xml2.xmlXPathRegisterNs(ctxt, prefix, ns_uri);
	if (0 ~= tonumber(ret)) then
		error("xmlXPathRegisterNs failed");
	end
	return;
end

return libxml2
