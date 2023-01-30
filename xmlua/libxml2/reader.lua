
local ffi = require("ffi")

ffi.cdef[[
/**
 * xmlParserSeverities:
 *
 * How severe an error callback is when the per-reader error callback API
 * is used.
 */
typedef enum {
    XML_PARSER_SEVERITY_VALIDITY_WARNING = 1,
    XML_PARSER_SEVERITY_VALIDITY_ERROR = 2,
    XML_PARSER_SEVERITY_WARNING = 3,
    XML_PARSER_SEVERITY_ERROR = 4
} xmlParserSeverities;

// #ifdef LIBXML_READER_ENABLED

/**
 * xmlTextReaderMode:
 *
 * Internal state values for the reader.
 */
typedef enum {
    XML_TEXTREADER_MODE_INITIAL = 0,
    XML_TEXTREADER_MODE_INTERACTIVE = 1,
    XML_TEXTREADER_MODE_ERROR = 2,
    XML_TEXTREADER_MODE_EOF =3,
    XML_TEXTREADER_MODE_CLOSED = 4,
    XML_TEXTREADER_MODE_READING = 5
} xmlTextReaderMode;

/**
 * xmlParserProperties:
 *
 * Some common options to use with xmlTextReaderSetParserProp, but it
 * is better to use xmlParserOption and the xmlReaderNewxxx and
 * xmlReaderForxxx APIs now.
 */
typedef enum {
    XML_PARSER_LOADDTD = 1,
    XML_PARSER_DEFAULTATTRS = 2,
    XML_PARSER_VALIDATE = 3,
    XML_PARSER_SUBST_ENTITIES = 4
} xmlParserProperties;

/**
 * xmlReaderTypes:
 *
 * Predefined constants for the different types of nodes.
 */
typedef enum {
    XML_READER_TYPE_NONE = 0,
    XML_READER_TYPE_ELEMENT = 1,
    XML_READER_TYPE_ATTRIBUTE = 2,
    XML_READER_TYPE_TEXT = 3,
    XML_READER_TYPE_CDATA = 4,
    XML_READER_TYPE_ENTITY_REFERENCE = 5,
    XML_READER_TYPE_ENTITY = 6,
    XML_READER_TYPE_PROCESSING_INSTRUCTION = 7,
    XML_READER_TYPE_COMMENT = 8,
    XML_READER_TYPE_DOCUMENT = 9,
    XML_READER_TYPE_DOCUMENT_TYPE = 10,
    XML_READER_TYPE_DOCUMENT_FRAGMENT = 11,
    XML_READER_TYPE_NOTATION = 12,
    XML_READER_TYPE_WHITESPACE = 13,
    XML_READER_TYPE_SIGNIFICANT_WHITESPACE = 14,
    XML_READER_TYPE_END_ELEMENT = 15,
    XML_READER_TYPE_END_ENTITY = 16,
    XML_READER_TYPE_XML_DECLARATION = 17
} xmlReaderTypes;

/**
 * xmlTextReader:
 *
 * Structure for an xmlReader context.
 */
typedef struct _xmlTextReader xmlTextReader;

/**
 * xmlTextReaderPtr:
 *
 * Pointer to an xmlReader context.
 */
typedef xmlTextReader *xmlTextReaderPtr;

/*
 * Constructors & Destructor
 */
xmlTextReaderPtr xmlNewTextReader	(xmlParserInputBufferPtr input,
	                                         const char *URI);
xmlTextReaderPtr xmlNewTextReaderFilename(const char *URI);

void xmlFreeTextReader	(xmlTextReaderPtr reader);

int xmlTextReaderSetup(xmlTextReaderPtr reader,
                   xmlParserInputBufferPtr input, const char *URL,
                   const char *encoding, int options);

/*
 * Iterators
 */
int xmlTextReaderRead	(xmlTextReaderPtr reader);

// #ifdef LIBXML_WRITER_ENABLED
xmlChar * xmlTextReaderReadInnerXml(xmlTextReaderPtr reader);

xmlChar * xmlTextReaderReadOuterXml(xmlTextReaderPtr reader);
// #endif

xmlChar * xmlTextReaderReadString	(xmlTextReaderPtr reader);
int xmlTextReaderReadAttributeValue(xmlTextReaderPtr reader);

/*
 * Attributes of the node
 */
int xmlTextReaderAttributeCount(xmlTextReaderPtr reader);
int xmlTextReaderDepth	(xmlTextReaderPtr reader);
int xmlTextReaderHasAttributes(xmlTextReaderPtr reader);
int xmlTextReaderHasValue(xmlTextReaderPtr reader);
int xmlTextReaderIsDefault	(xmlTextReaderPtr reader);
int xmlTextReaderIsEmptyElement(xmlTextReaderPtr reader);
int xmlTextReaderNodeType	(xmlTextReaderPtr reader);
int xmlTextReaderQuoteChar	(xmlTextReaderPtr reader);
int xmlTextReaderReadState	(xmlTextReaderPtr reader);
int xmlTextReaderIsNamespaceDecl(xmlTextReaderPtr reader);

const xmlChar * xmlTextReaderConstBaseUri	(xmlTextReaderPtr reader);
const xmlChar * xmlTextReaderConstLocalName	(xmlTextReaderPtr reader);
const xmlChar * xmlTextReaderConstName	(xmlTextReaderPtr reader);
const xmlChar * xmlTextReaderConstNamespaceUri(xmlTextReaderPtr reader);
const xmlChar * xmlTextReaderConstPrefix	(xmlTextReaderPtr reader);
const xmlChar * xmlTextReaderConstXmlLang	(xmlTextReaderPtr reader);
const xmlChar * xmlTextReaderConstString	(xmlTextReaderPtr reader, const xmlChar *str);
const xmlChar * xmlTextReaderConstValue	(xmlTextReaderPtr reader);

/*
 * use the Const version of the routine for
 * better performance and simpler code
 */
xmlChar * xmlTextReaderBaseUri	(xmlTextReaderPtr reader);
xmlChar * xmlTextReaderLocalName	(xmlTextReaderPtr reader);
xmlChar * xmlTextReaderName	(xmlTextReaderPtr reader);
xmlChar * xmlTextReaderNamespaceUri(xmlTextReaderPtr reader);
xmlChar * xmlTextReaderPrefix	(xmlTextReaderPtr reader);
xmlChar * xmlTextReaderXmlLang	(xmlTextReaderPtr reader);
xmlChar * xmlTextReaderValue	(xmlTextReaderPtr reader);

/*
 * Methods of the XmlTextReader
 */
int xmlTextReaderClose		(xmlTextReaderPtr reader);
xmlChar * xmlTextReaderGetAttributeNo	(xmlTextReaderPtr reader, int no);
xmlChar * xmlTextReaderGetAttribute	(xmlTextReaderPtr reader, const xmlChar *name);
xmlChar * xmlTextReaderGetAttributeNs	(xmlTextReaderPtr reader,
						 const xmlChar *localName,
						 const xmlChar *namespaceURI);
xmlParserInputBufferPtr xmlTextReaderGetRemainder	(xmlTextReaderPtr reader);
xmlChar * xmlTextReaderLookupNamespace(xmlTextReaderPtr reader, const xmlChar *prefix);
int xmlTextReaderMoveToAttributeNo(xmlTextReaderPtr reader, int no);
int xmlTextReaderMoveToAttribute(xmlTextReaderPtr reader, const xmlChar *name);
int xmlTextReaderMoveToAttributeNs(xmlTextReaderPtr reader,
						 const xmlChar *localName,
						 const xmlChar *namespaceURI);
int xmlTextReaderMoveToFirstAttribute(xmlTextReaderPtr reader);
int xmlTextReaderMoveToNextAttribute(xmlTextReaderPtr reader);
int xmlTextReaderMoveToElement	(xmlTextReaderPtr reader);
int xmlTextReaderNormalization	(xmlTextReaderPtr reader);
const xmlChar * xmlTextReaderConstEncoding  (xmlTextReaderPtr reader);

/*
 * Extensions
 */
int xmlTextReaderSetParserProp	(xmlTextReaderPtr reader,
						 int prop,
						 int value);
int xmlTextReaderGetParserProp	(xmlTextReaderPtr reader,
						 int prop);
xmlNodePtr xmlTextReaderCurrentNode	(xmlTextReaderPtr reader);

int xmlTextReaderGetParserLineNumber(xmlTextReaderPtr reader);

int xmlTextReaderGetParserColumnNumber(xmlTextReaderPtr reader);

xmlNodePtr xmlTextReaderPreserve	(xmlTextReaderPtr reader);
// #ifdef LIBXML_PATTERN_ENABLED
int 
		    xmlTextReaderPreservePattern(xmlTextReaderPtr reader,
						 const xmlChar *pattern,
						 const xmlChar **namespaces);
// #endif /* LIBXML_PATTERN_ENABLED */
xmlDocPtr xmlTextReaderCurrentDoc	(xmlTextReaderPtr reader);
xmlNodePtr xmlTextReaderExpand		(xmlTextReaderPtr reader);
int xmlTextReaderNext		(xmlTextReaderPtr reader);
int xmlTextReaderNextSibling	(xmlTextReaderPtr reader);
int xmlTextReaderIsValid	(xmlTextReaderPtr reader);
// #ifdef LIBXML_SCHEMAS_ENABLED
int xmlTextReaderRelaxNGValidate(xmlTextReaderPtr reader,
						 const char *rng);
int xmlTextReaderRelaxNGValidateCtxt(xmlTextReaderPtr reader,
						 xmlRelaxNGValidCtxtPtr ctxt,
						 int options);

int xmlTextReaderRelaxNGSetSchema(xmlTextReaderPtr reader,
						 xmlRelaxNGPtr schema);
int xmlTextReaderSchemaValidate	(xmlTextReaderPtr reader,
						 const char *xsd);
int xmlTextReaderSchemaValidateCtxt(xmlTextReaderPtr reader,
						 xmlSchemaValidCtxtPtr ctxt,
						 int options);
int xmlTextReaderSetSchema	(xmlTextReaderPtr reader,
						 xmlSchemaPtr schema);
// #endif
const xmlChar * xmlTextReaderConstXmlVersion(xmlTextReaderPtr reader);
int xmlTextReaderStandalone     (xmlTextReaderPtr reader);


/*
 * Index lookup
 */
long xmlTextReaderByteConsumed	(xmlTextReaderPtr reader);

/*
 * New more complete APIs for simpler creation and reuse of readers
 */
xmlTextReaderPtr xmlReaderWalker		(xmlDocPtr doc);
xmlTextReaderPtr xmlReaderForDoc		(const xmlChar * cur,
					 const char *URL,
					 const char *encoding,
					 int options);
xmlTextReaderPtr xmlReaderForFile	(const char *filename,
					 const char *encoding,
					 int options);
xmlTextReaderPtr xmlReaderForMemory	(const char *buffer,
					 int size,
					 const char *URL,
					 const char *encoding,
					 int options);
xmlTextReaderPtr xmlReaderForFd		(int fd,
					 const char *URL,
					 const char *encoding,
					 int options);
xmlTextReaderPtr xmlReaderForIO		(xmlInputReadCallback ioread,
					 xmlInputCloseCallback ioclose,
					 void *ioctx,
					 const char *URL,
					 const char *encoding,
					 int options);

int xmlReaderNewWalker	(xmlTextReaderPtr reader,
					 xmlDocPtr doc);
int xmlReaderNewDoc		(xmlTextReaderPtr reader,
					 const xmlChar * cur,
					 const char *URL,
					 const char *encoding,
					 int options);
int xmlReaderNewFile	(xmlTextReaderPtr reader,
					 const char *filename,
					 const char *encoding,
					 int options);
int xmlReaderNewMemory	(xmlTextReaderPtr reader,
					 const char *buffer,
					 int size,
					 const char *URL,
					 const char *encoding,
					 int options);
int xmlReaderNewFd		(xmlTextReaderPtr reader,
					 int fd,
					 const char *URL,
					 const char *encoding,
					 int options);
int xmlReaderNewIO		(xmlTextReaderPtr reader,
					 xmlInputReadCallback ioread,
					 xmlInputCloseCallback ioclose,
					 void *ioctx,
					 const char *URL,
					 const char *encoding,
					 int options);
/*
 * Error handling extensions
 */
typedef void *  xmlTextReaderLocatorPtr;

/**
 * xmlTextReaderErrorFunc:
 * @arg: the user argument
 * @msg: the message
 * @severity: the severity of the error
 * @locator: a locator indicating where the error occurred
 *
 * Signature of an error callback from a reader parser
 */
typedef void ( *xmlTextReaderErrorFunc)(void *arg,
					       const char *msg,
					       xmlParserSeverities severity,
					       xmlTextReaderLocatorPtr locator);
int xmlTextReaderLocatorLineNumber(xmlTextReaderLocatorPtr locator);
xmlChar * xmlTextReaderLocatorBaseURI (xmlTextReaderLocatorPtr locator);
void xmlTextReaderSetErrorHandler(xmlTextReaderPtr reader,
					 xmlTextReaderErrorFunc f,
					 void *arg);
void xmlTextReaderSetStructuredErrorHandler(xmlTextReaderPtr reader,
						   xmlStructuredErrorFunc f,
						   void *arg);
void xmlTextReaderGetErrorHandler(xmlTextReaderPtr reader,
					 xmlTextReaderErrorFunc *f,
					 void **arg);

]]
