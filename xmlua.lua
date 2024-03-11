local xmlua = {}

xmlua.VERSION = "1.2.0"

xmlua.libxml2 = require("lua_schema.xmlua.libxml2")
xmlua.XML = require("lua_schema.xmlua.xml")
xmlua.XSD = require("lua_schema.xmlua.xsd")
xmlua.HTML = require("lua_schema.xmlua.html")
xmlua.HTMLSAXParser = require("lua_schema.xmlua.html-sax-parser")
xmlua.XMLSAXParser = require("lua_schema.xmlua.xml-sax-parser")
xmlua.XMLStreamSAXParser = require("lua_schema.xmlua.xml-stream-sax-parser")
xmlua.XMLReader = require("lua_schema.xmlua.xml-reader")
xmlua.XMLRegexp = require("lua_schema.xmlua.regexp")
xmlua.XMLDateUtils = require("lua_schema.xmlua.xml_date_utils")

local Document = require("lua_schema.xmlua.document")
Document.lazy_load()
Document.lazy_load = nil

local Searchable = require("lua_schema.xmlua.searchable")
Searchable.lazy_load()
Searchable.lazy_load = nil

function xmlua.init()
  xmlua.libxml2.xmlInitParser()
end

function xmlua.cleanup()
  collectgarbage()
  xmlua.libxml2.xmlCleanupParser()
end

return xmlua
