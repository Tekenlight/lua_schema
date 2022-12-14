local ffi = require("ffi");
ffi.cdef[[
/*
 * Summary: implementation of XML Schema Datatypes
 * Description: module providing the XML Schema Datatypes implementation
 *              both definition and validity checking
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */


typedef enum {
    XML_SCHEMA_WHITESPACE_UNKNOWN = 0,
    XML_SCHEMA_WHITESPACE_PRESERVE = 1,
    XML_SCHEMA_WHITESPACE_REPLACE = 2,
    XML_SCHEMA_WHITESPACE_COLLAPSE = 3
} xmlSchemaWhitespaceValueType;

void xmlSchemaInitTypes(void);

void xmlSchemaCleanupTypes(void);

xmlSchemaTypePtr xmlSchemaGetPredefinedType(const xmlChar *name,
						 const xmlChar *ns);

int xmlSchemaValidatePredefinedType(xmlSchemaTypePtr type,
						 const xmlChar *value,
						 xmlSchemaValPtr *val);

int xmlSchemaValPredefTypeNode(xmlSchemaTypePtr type,
						 const xmlChar *value,
						 xmlSchemaValPtr *val,
						 xmlNodePtr node);

int xmlSchemaValidateFacet(xmlSchemaTypePtr base,
						 xmlSchemaFacetPtr facet,
						 const xmlChar *value,
						 xmlSchemaValPtr val);

int xmlSchemaValidateFacetWhtsp(xmlSchemaFacetPtr facet,
						 xmlSchemaWhitespaceValueType fws,
						 xmlSchemaValType valType,
						 const xmlChar *value,
						 xmlSchemaValPtr val,
						 xmlSchemaWhitespaceValueType ws);

void xmlSchemaFreeValue(xmlSchemaValPtr val);

xmlSchemaFacetPtr xmlSchemaNewFacet(void);

int xmlSchemaCheckFacet(xmlSchemaFacetPtr facet,
						 xmlSchemaTypePtr typeDecl,
						 xmlSchemaParserCtxtPtr ctxt,
						 const xmlChar *name);

void xmlSchemaFreeFacet(xmlSchemaFacetPtr facet);

int xmlSchemaCompareValues(xmlSchemaValPtr x,
						 xmlSchemaValPtr y);

xmlSchemaTypePtr xmlSchemaGetBuiltInListSimpleTypeItemType(xmlSchemaTypePtr type);

int xmlSchemaValidateListSimpleTypeFacet(xmlSchemaFacetPtr facet,
						 const xmlChar *value,
						 unsigned long actualLen,
						 unsigned long *expectedLen);

xmlSchemaTypePtr xmlSchemaGetBuiltInType(xmlSchemaValType type);

int xmlSchemaIsBuiltInTypeFacet(xmlSchemaTypePtr type,
						 int facetType);

xmlChar * xmlSchemaCollapseString(const xmlChar *value);

xmlChar * xmlSchemaWhiteSpaceReplace(const xmlChar *value);

unsigned long xmlSchemaGetFacetValueAsULong(xmlSchemaFacetPtr facet);

int xmlSchemaValidateLengthFacet(xmlSchemaTypePtr type,
						 xmlSchemaFacetPtr facet,
						 const xmlChar *value,
						 xmlSchemaValPtr val,
						 unsigned long *length);

int xmlSchemaValidateLengthFacetWhtsp(xmlSchemaFacetPtr facet,
						  xmlSchemaValType valType,
						  const xmlChar *value,
						  xmlSchemaValPtr val,
						  unsigned long *length,
						  xmlSchemaWhitespaceValueType ws);

int xmlSchemaValPredefTypeNodeNoNorm(xmlSchemaTypePtr type,
						 const xmlChar *value,
						 xmlSchemaValPtr *val,
						 xmlNodePtr node);

int xmlSchemaGetCanonValue(xmlSchemaValPtr val,
						 const xmlChar **retValue);

int xmlSchemaGetCanonValueWhtsp(xmlSchemaValPtr val,
						 const xmlChar **retValue,
						 xmlSchemaWhitespaceValueType ws);

int xmlSchemaValueAppend(xmlSchemaValPtr prev, xmlSchemaValPtr cur);

xmlSchemaValPtr xmlSchemaValueGetNext(xmlSchemaValPtr cur);

const xmlChar * xmlSchemaValueGetAsString(xmlSchemaValPtr val);

int xmlSchemaValueGetAsBoolean(xmlSchemaValPtr val);

xmlSchemaValPtr xmlSchemaNewStringValue(xmlSchemaValType type,
						 const xmlChar *value);

xmlSchemaValPtr xmlSchemaNewNOTATIONValue(const xmlChar *name,
						 const xmlChar *ns);

xmlSchemaValPtr xmlSchemaNewQNameValue(const xmlChar *namespaceName,
						 const xmlChar *localName);

int xmlSchemaCompareValuesWhtsp(xmlSchemaValPtr x,
						 xmlSchemaWhitespaceValueType xws,
						 xmlSchemaValPtr y,
						 xmlSchemaWhitespaceValueType yws);

xmlSchemaValPtr xmlSchemaCopyValue(xmlSchemaValPtr val);

xmlSchemaValType xmlSchemaGetValType(xmlSchemaValPtr val);



int xmlSchemaValidateDates(xmlSchemaValType datetype,
						const xmlChar *dateTime, xmlSchemaValPtr *val, int collapse);

int xmlSchemaCompareDates(xmlSchemaValPtr x, xmlSchemaValPtr y);

int xmlSchemaValidateDuration(xmlSchemaTypePtr type, const xmlChar *duration,
													xmlSchemaValPtr *val, int collapse);

]]
