local ffi = require("ffi")

ffi.cdef[[
/*
 * Summary: regular expressions handling
 * Description: basic API for libxml regular expressions handling used
 *              for XML Schemas and validation.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

/**
 * xmlRegexpPtr:
 *
 * A libxml regular expression, they can actually be far more complex
 * thank the POSIX regex expressions.
 */
typedef struct _xmlRegexp xmlRegexp;
typedef xmlRegexp *xmlRegexpPtr;

/**
 * xmlRegExecCtxtPtr:
 *
 * A libxml progressive regular expression evaluation context
 */
typedef struct _xmlRegExecCtxt xmlRegExecCtxt;
typedef xmlRegExecCtxt *xmlRegExecCtxtPtr;

/*
 * The POSIX like API
 */
xmlRegexpPtr xmlRegexpCompile	(const xmlChar *regexp);
void xmlRegFreeRegexp(xmlRegexpPtr regexp);
int xmlRegexpExec(xmlRegexpPtr comp, const xmlChar *value);
/*void xmlRegexpPrint(FILE *output, xmlRegexpPtr regexp);*/
void xmlRegexpPrintToStdOut(xmlRegexpPtr regexp);
int xmlRegexpIsDeterminist(xmlRegexpPtr comp);

/**
 * xmlRegExecCallbacks:
 * @exec: the regular expression context
 * @token: the current token string
 * @transdata: transition data
 * @inputdata: input data
 *
 * Callback function when doing a transition in the automata
 */
typedef void (*xmlRegExecCallbacks) (xmlRegExecCtxtPtr exec,
	                             const xmlChar *token,
				     void *transdata,
				     void *inputdata);

/*
 * The progressive API
 */
xmlRegExecCtxtPtr xmlRegNewExecCtxt	(xmlRegexpPtr comp,
					 xmlRegExecCallbacks callback,
					 void *data);
void xmlRegFreeExecCtxt	(xmlRegExecCtxtPtr exec);
int xmlRegExecPushString(xmlRegExecCtxtPtr exec,
					 const xmlChar *value,
					 void *data);
int xmlRegExecPushString2(xmlRegExecCtxtPtr exec,
					 const xmlChar *value,
					 const xmlChar *value2,
					 void *data);

int xmlRegExecNextValues(xmlRegExecCtxtPtr exec,
					 int *nbval,
					 int *nbneg,
					 xmlChar **values,
					 int *terminal);
int xmlRegExecErrInfo	(xmlRegExecCtxtPtr exec,
					 const xmlChar **string,
					 int *nbval,
					 int *nbneg,
					 xmlChar **values,
					 int *terminal);
/*
 * Formal regular expression handling
 * Its goal is to do some formal work on content models
 */

/* expressions are used within a context */
typedef struct _xmlExpCtxt xmlExpCtxt;
typedef xmlExpCtxt *xmlExpCtxtPtr;

void xmlExpFreeCtxt	(xmlExpCtxtPtr ctxt);
xmlExpCtxtPtr xmlExpNewCtxt	(int maxNodes,
					 xmlDictPtr dict);

int xmlExpCtxtNbNodes(xmlExpCtxtPtr ctxt);
int xmlExpCtxtNbCons(xmlExpCtxtPtr ctxt);

/* Expressions are trees but the tree is opaque */
typedef struct _xmlExpNode xmlExpNode;
typedef xmlExpNode *xmlExpNodePtr;

typedef enum {
    XML_EXP_EMPTY = 0,
    XML_EXP_FORBID = 1,
    XML_EXP_ATOM = 2,
    XML_EXP_SEQ = 3,
    XML_EXP_OR = 4,
    XML_EXP_COUNT = 5
} xmlExpNodeType;

/*
 * 2 core expressions shared by all for the empty language set
 * and for the set with just the empty token
 */
xmlExpNodePtr forbiddenExp;
xmlExpNodePtr emptyExp;

/*
 * Expressions are reference counted internally
 */
void xmlExpFree	(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr expr);
void xmlExpRef	(xmlExpNodePtr expr);

/*
 * constructors can be either manual or from a string
 */
xmlExpNodePtr xmlExpParse	(xmlExpCtxtPtr ctxt,
					 const char *expr);
xmlExpNodePtr xmlExpNewAtom	(xmlExpCtxtPtr ctxt,
					 const xmlChar *name,
					 int len);
xmlExpNodePtr xmlExpNewOr	(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr left,
					 xmlExpNodePtr right);
xmlExpNodePtr xmlExpNewSeq	(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr left,
					 xmlExpNodePtr right);
xmlExpNodePtr xmlExpNewRange	(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr subset,
					 int min,
					 int max);
/*
 * The really interesting APIs
 */
int xmlExpIsNillable(xmlExpNodePtr expr);
int xmlExpMaxToken	(xmlExpNodePtr expr);
int xmlExpGetLanguage(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr expr,
					 const xmlChar**langList,
					 int len);
int xmlExpGetStart	(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr expr,
					 const xmlChar**tokList,
					 int len);
xmlExpNodePtr xmlExpStringDerive(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr expr,
					 const xmlChar *str,
					 int len);
xmlExpNodePtr xmlExpExpDerive	(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr expr,
					 xmlExpNodePtr sub);
int xmlExpSubsume	(xmlExpCtxtPtr ctxt,
					 xmlExpNodePtr expr,
					 xmlExpNodePtr sub);
typedef void* xmlBufferPtr;
void xmlExpDump	(xmlBufferPtr buf,
					 xmlExpNodePtr expr);

]]
