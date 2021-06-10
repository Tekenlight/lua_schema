local xmlua = {}

xmlua.VERSION = "1.2.0"

xmlua.libxml2 = require("xmlua.libxml2")
xmlua.XML = require("xmlua.xml")
xmlua.XSD = require("xmlua.xsd")
xmlua.HTML = require("xmlua.html")
xmlua.HTMLSAXParser = require("xmlua.html-sax-parser")
xmlua.XMLSAXParser = require("xmlua.xml-sax-parser")
xmlua.XMLStreamSAXParser = require("xmlua.xml-stream-sax-parser")
xmlua.XMLReader = require("xmlua.xml-reader")
xmlua.XMLRegexp = require("xmlua.regexp")
xmlua.XMLDateUtils = require("xmlua.xml_date_utils")

local Document = require("xmlua.document")
Document.lazy_load()
Document.lazy_load = nil

local Searchable = require("xmlua.searchable")
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
