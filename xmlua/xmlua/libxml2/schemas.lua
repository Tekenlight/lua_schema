local ffi = require("ffi")

ffi.cdef[[
/**
 * This error codes are obsolete; not used any more.
 */
typedef enum {
    XML_SCHEMAS_ERR_OK		= 0,
    XML_SCHEMAS_ERR_NOROOT	= 1,
    XML_SCHEMAS_ERR_UNDECLAREDELEM,
    XML_SCHEMAS_ERR_NOTTOPLEVEL,
    XML_SCHEMAS_ERR_MISSING,
    XML_SCHEMAS_ERR_WRONGELEM,
    XML_SCHEMAS_ERR_NOTYPE,
    XML_SCHEMAS_ERR_NOROLLBACK,
    XML_SCHEMAS_ERR_ISABSTRACT,
    XML_SCHEMAS_ERR_NOTEMPTY,
    XML_SCHEMAS_ERR_ELEMCONT,
    XML_SCHEMAS_ERR_HAVEDEFAULT,
    XML_SCHEMAS_ERR_NOTNILLABLE,
    XML_SCHEMAS_ERR_EXTRACONTENT,
    XML_SCHEMAS_ERR_INVALIDATTR,
    XML_SCHEMAS_ERR_INVALIDELEM,
    XML_SCHEMAS_ERR_NOTDETERMINIST,
    XML_SCHEMAS_ERR_CONSTRUCT,
    XML_SCHEMAS_ERR_INTERNAL,
    XML_SCHEMAS_ERR_NOTSIMPLE,
    XML_SCHEMAS_ERR_ATTRUNKNOWN,
    XML_SCHEMAS_ERR_ATTRINVALID,
    XML_SCHEMAS_ERR_VALUE,
    XML_SCHEMAS_ERR_FACET,
    XML_SCHEMAS_ERR_,
    XML_SCHEMAS_ERR_XXX
} xmlSchemaValidError;

/*
* ATTENTION: Change xmlSchemaSetValidOptions's check
* for invalid values, if adding to the validation
* options below.
*/
/**
 * xmlSchemaValidOption:
 *
 * This is the set of XML Schema validation options.
 */
typedef enum {
    XML_SCHEMA_VAL_VC_I_CREATE			= 1<<0
	/* Default/fixed: create an attribute node
	* or an element's text node on the instance.
	*/
} xmlSchemaValidOption;

/*
    XML_SCHEMA_VAL_XSI_ASSEMBLE			= 1<<1,
	* assemble schemata using
	* xsi:schemaLocation and
	* xsi:noNamespaceSchemaLocation
*/

/**
 * The schemas related types are kept internal
 */
typedef struct _xmlSchema xmlSchema;
typedef xmlSchema *xmlSchemaPtr;

/**
 * xmlSchemaValidityErrorFunc:
 * @ctx: the validation context
 * @msg: the message
 * @...: extra arguments
 *
 * Signature of an error callback from an XSD validation
 */
typedef void (*xmlSchemaValidityErrorFunc)
                 (void *ctx, const char *msg, ...);

/**
 * xmlSchemaValidityWarningFunc:
 * @ctx: the validation context
 * @msg: the message
 * @...: extra arguments
 *
 * Signature of a warning callback from an XSD validation
 */
typedef void (*xmlSchemaValidityWarningFunc)
                 (void *ctx, const char *msg, ...);

/**
 * A schemas validation context
 */
typedef struct _xmlSchemaParserCtxt xmlSchemaParserCtxt;
typedef xmlSchemaParserCtxt *xmlSchemaParserCtxtPtr;

typedef struct _xmlSchemaValidCtxt xmlSchemaValidCtxt;
typedef xmlSchemaValidCtxt *xmlSchemaValidCtxtPtr;

/**
 * xmlSchemaValidityLocatorFunc:
 * @ctx: user provided context
 * @file: returned file information
 * @line: returned line information
 *
 * A schemas validation locator, a callback called by the validator.
 * This is used when file or node informations are not available
 * to find out what file and line number are affected
 *
 * Returns: 0 in case of success and -1 in case of error
 */

typedef int (*xmlSchemaValidityLocatorFunc) (void *ctx,
                           const char **file, unsigned long *line);

/*
 * Interfaces for parsing.
 */
xmlSchemaParserCtxtPtr xmlSchemaNewParserCtxt	(const char *URL);
xmlSchemaParserCtxtPtr xmlSchemaNewMemParserCtxt	(const char *buffer,
					 int size);
xmlSchemaParserCtxtPtr xmlSchemaNewDocParserCtxt	(xmlDocPtr doc);
void xmlSchemaFreeParserCtxt	(xmlSchemaParserCtxtPtr ctxt);
void xmlSchemaSetParserErrors	(xmlSchemaParserCtxtPtr ctxt,
					 xmlSchemaValidityErrorFunc err,
					 xmlSchemaValidityWarningFunc warn,
					 void *ctx);
void xmlSchemaSetParserStructuredErrors(xmlSchemaParserCtxtPtr ctxt,
					 xmlStructuredErrorFunc serror,
					 void *ctx);
int xmlSchemaGetParserErrors(xmlSchemaParserCtxtPtr ctxt,
					xmlSchemaValidityErrorFunc * err,
					xmlSchemaValidityWarningFunc * warn,
					void **ctx);
int xmlSchemaIsValid	(xmlSchemaValidCtxtPtr ctxt);

xmlSchemaPtr xmlSchemaParse		(xmlSchemaParserCtxtPtr ctxt);
void xmlSchemaFree		(xmlSchemaPtr schema);
//#ifdef LIBXML_OUTPUT_ENABLED
/*
void xmlSchemaDump		(FILE *output,
					 xmlSchemaPtr schema);
*/
//#endif /* LIBXML_OUTPUT_ENABLED */
/*
 * Interfaces for validating
 */
void xmlSchemaSetValidErrors	(xmlSchemaValidCtxtPtr ctxt,
					 xmlSchemaValidityErrorFunc err,
					 xmlSchemaValidityWarningFunc warn,
					 void *ctx);
void xmlSchemaSetValidStructuredErrors(xmlSchemaValidCtxtPtr ctxt,
					 xmlStructuredErrorFunc serror,
					 void *ctx);
int xmlSchemaGetValidErrors	(xmlSchemaValidCtxtPtr ctxt,
					 xmlSchemaValidityErrorFunc *err,
					 xmlSchemaValidityWarningFunc *warn,
					 void **ctx);
int xmlSchemaSetValidOptions	(xmlSchemaValidCtxtPtr ctxt,
					 int options);
void xmlSchemaValidateSetFilename(xmlSchemaValidCtxtPtr vctxt,
	                                 const char *filename);
int xmlSchemaValidCtxtGetOptions(xmlSchemaValidCtxtPtr ctxt);

xmlSchemaValidCtxtPtr xmlSchemaNewValidCtxt	(xmlSchemaPtr schema);
void xmlSchemaFreeValidCtxt	(xmlSchemaValidCtxtPtr ctxt);
int xmlSchemaValidateDoc	(xmlSchemaValidCtxtPtr ctxt,
					 xmlDocPtr instance);
int xmlSchemaValidateOneElement (xmlSchemaValidCtxtPtr ctxt,
			                 xmlNodePtr elem);
int xmlSchemaValidateStream	(xmlSchemaValidCtxtPtr ctxt,
					 xmlParserInputBufferPtr input,
					 xmlCharEncoding enc,
					 xmlSAXHandlerPtr sax,
					 void *user_data);
int xmlSchemaValidateFile	(xmlSchemaValidCtxtPtr ctxt,
					 const char * filename,
					 int options);

xmlParserCtxtPtr xmlSchemaValidCtxtGetParserCtxt(xmlSchemaValidCtxtPtr ctxt);

/*
 * Interface to insert Schemas SAX validation in a SAX stream
 */
typedef struct _xmlSchemaSAXPlug xmlSchemaSAXPlugStruct;
typedef xmlSchemaSAXPlugStruct *xmlSchemaSAXPlugPtr;

xmlSchemaSAXPlugPtr xmlSchemaSAXPlug		(xmlSchemaValidCtxtPtr ctxt,
					 xmlSAXHandlerPtr *sax,
					 void **user_data);
int xmlSchemaSAXUnplug		(xmlSchemaSAXPlugPtr plug);


void xmlSchemaValidateSetLocator	(xmlSchemaValidCtxtPtr vctxt,
					 xmlSchemaValidityLocatorFunc f,
					 void *ctxt);

/*
 * Interface for accessing components of pased schema
 */
typedef struct _xmlSchemaType xmlSchemaType;
typedef xmlSchemaType *xmlSchemaTypePtr;

xmlSchemaTypePtr xmlSchemaGetType(xmlSchemaPtr schema, const xmlChar * name, const xmlChar * nsName);
xmlSchemaTypePtr* xmlSchemaGetGlobalTypeDefs(xmlSchemaPtr schema);

typedef struct _xmlSchemaElement xmlSchemaElement;
typedef xmlSchemaElement *xmlSchemaElementPtr;

xmlSchemaElementPtr xmlSchemaGetElem(xmlSchemaPtr schema, const xmlChar * name, const xmlChar * nsName);
xmlSchemaElementPtr* xmlSchemaGetGlobalElements(xmlSchemaPtr schema);

typedef struct _xmlSchemaModelGroupDef xmlSchemaModelGroupDef;
typedef xmlSchemaModelGroupDef *xmlSchemaModelGroupDefPtr;

xmlSchemaModelGroupDefPtr xmlSchemaGetModelGroupDef(xmlSchemaPtr schema, const xmlChar * name, const xmlChar * nsName);
xmlSchemaModelGroupDefPtr* xmlSchemaGetGlobalModelGroupDefs(xmlSchemaPtr schema);

/*
 * For getting names of definitions/declarations in xsd
 */

typedef struct _xmlSchemaQName xmlSchemaQName;
typedef xmlSchemaQName *xmlSchemaQnamePtr;

xmlSchemaQnamePtr
xmlSchemaGetQNameOfProp(xmlSchemaParserCtxtPtr ctxt,
						xmlSchemaPtr schema,
						xmlNodePtr node,
						const xmlChar * propName);

void
xmlFreeSchemaQnamePtr(xmlSchemaQnamePtr ptr);


]]
