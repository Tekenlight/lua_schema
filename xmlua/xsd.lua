local ffi = require("ffi");
local XSD = {}

local methods = {};
local metatable = {}

local libxml2 = require("lua_schema.xmlua.libxml2")
local ffi = require("ffi")

methods.XML_SCHEMAS_TYPE_VARIETY_LIST = 1 << 6
methods.XML_SCHEMAS_TYPE_VARIETY_UNION = 1 << 7
methods.XML_SCHEMAS_TYPE_VARIETY_ATOMIC = 1 << 8

methods.value_type = {
    XML_SCHEMAS_UNKNOWN = ffi.C.XML_SCHEMAS_UNKNOWN,
    XML_SCHEMAS_STRING = ffi.C.XML_SCHEMAS_STRING,
    XML_SCHEMAS_NORMSTRING = ffi.C.XML_SCHEMAS_NORMSTRING,
    XML_SCHEMAS_DECIMAL = ffi.C.XML_SCHEMAS_DECIMAL,
    XML_SCHEMAS_TIME = ffi.C.XML_SCHEMAS_TIME,
    XML_SCHEMAS_GDAY = ffi.C.XML_SCHEMAS_GDAY,
    XML_SCHEMAS_GMONTH = ffi.C.XML_SCHEMAS_GMONTH,
    XML_SCHEMAS_GMONTHDAY = ffi.C.XML_SCHEMAS_GMONTHDAY,
    XML_SCHEMAS_GYEAR = ffi.C.XML_SCHEMAS_GYEAR,
    XML_SCHEMAS_GYEARMONTH = ffi.C.XML_SCHEMAS_GYEARMONTH,
    XML_SCHEMAS_DATE = ffi.C.XML_SCHEMAS_DATE,
    XML_SCHEMAS_DATETIME = ffi.C.XML_SCHEMAS_DATETIME,
    XML_SCHEMAS_DURATION = ffi.C.XML_SCHEMAS_DURATION,
    XML_SCHEMAS_FLOAT = ffi.C.XML_SCHEMAS_FLOAT,
    XML_SCHEMAS_DOUBLE = ffi.C.XML_SCHEMAS_DOUBLE,
    XML_SCHEMAS_BOOLEAN = ffi.C.XML_SCHEMAS_BOOLEAN,
    XML_SCHEMAS_TOKEN = ffi.C.XML_SCHEMAS_TOKEN,
    XML_SCHEMAS_LANGUAGE = ffi.C.XML_SCHEMAS_LANGUAGE,
    XML_SCHEMAS_NMTOKEN = ffi.C.XML_SCHEMAS_NMTOKEN,
    XML_SCHEMAS_NMTOKENS = ffi.C.XML_SCHEMAS_NMTOKENS,
    XML_SCHEMAS_NAME = ffi.C.XML_SCHEMAS_NAME,
    XML_SCHEMAS_QNAME = ffi.C.XML_SCHEMAS_QNAME,
    XML_SCHEMAS_NCNAME = ffi.C.XML_SCHEMAS_NCNAME,
    XML_SCHEMAS_ID = ffi.C.XML_SCHEMAS_ID,
    XML_SCHEMAS_IDREF = ffi.C.XML_SCHEMAS_IDREF,
    XML_SCHEMAS_IDREFS = ffi.C.XML_SCHEMAS_IDREFS,
    XML_SCHEMAS_ENTITY = ffi.C.XML_SCHEMAS_ENTITY,
    XML_SCHEMAS_ENTITIES = ffi.C.XML_SCHEMAS_ENTITIES,
    XML_SCHEMAS_NOTATION = ffi.C.XML_SCHEMAS_NOTATION,
    XML_SCHEMAS_ANYURI = ffi.C.XML_SCHEMAS_ANYURI,
    XML_SCHEMAS_INTEGER = ffi.C.XML_SCHEMAS_INTEGER,
    XML_SCHEMAS_NPINTEGER = ffi.C.XML_SCHEMAS_NPINTEGER,
    XML_SCHEMAS_NINTEGER = ffi.C.XML_SCHEMAS_NINTEGER,
    XML_SCHEMAS_NNINTEGER = ffi.C.XML_SCHEMAS_NNINTEGER,
    XML_SCHEMAS_PINTEGER = ffi.C.XML_SCHEMAS_PINTEGER,
    XML_SCHEMAS_INT = ffi.C.XML_SCHEMAS_INT,
    XML_SCHEMAS_UINT = ffi.C.XML_SCHEMAS_UINT,
    XML_SCHEMAS_LONG = ffi.C.XML_SCHEMAS_LONG,
    XML_SCHEMAS_ULONG = ffi.C.XML_SCHEMAS_ULONG,
    XML_SCHEMAS_SHORT = ffi.C.XML_SCHEMAS_SHORT,
    XML_SCHEMAS_USHORT = ffi.C.XML_SCHEMAS_USHORT,
    XML_SCHEMAS_BYTE = ffi.C.XML_SCHEMAS_BYTE,
    XML_SCHEMAS_UBYTE = ffi.C.XML_SCHEMAS_UBYTE,
    XML_SCHEMAS_HEXBINARY = ffi.C.XML_SCHEMAS_HEXBINARY,
    XML_SCHEMAS_BASE64BINARY = ffi.C.XML_SCHEMAS_BASE64BINARY,
    XML_SCHEMAS_ANYTYPE = ffi.C.XML_SCHEMAS_ANYTYPE,
    XML_SCHEMAS_ANYSIMPLETYPE = ffi.C.XML_SCHEMAS_ANYSIMPLETYPE
};

methods.type_type = {
    XML_SCHEMA_TYPE_BASIC = ffi.C.XML_SCHEMA_TYPE_BASIC, -- = 1
    XML_SCHEMA_TYPE_ANY = ffi.C.XML_SCHEMA_TYPE_ANY,
    XML_SCHEMA_TYPE_FACET = ffi.C.XML_SCHEMA_TYPE_FACET,
    XML_SCHEMA_TYPE_SIMPLE = ffi.C.XML_SCHEMA_TYPE_SIMPLE, -- = 4
    XML_SCHEMA_TYPE_COMPLEX = ffi.C.XML_SCHEMA_TYPE_COMPLEX, -- = 5
    XML_SCHEMA_TYPE_SEQUENCE = ffi.C.XML_SCHEMA_TYPE_SEQUENCE,
    XML_SCHEMA_TYPE_CHOICE = ffi.C.XML_SCHEMA_TYPE_CHOICE,
    XML_SCHEMA_TYPE_ALL = ffi.C.XML_SCHEMA_TYPE_ALL,
    XML_SCHEMA_TYPE_SIMPLE_CONTENT = ffi.C.XML_SCHEMA_TYPE_SIMPLE_CONTENT,
    XML_SCHEMA_TYPE_COMPLEX_CONTENT = ffi.C.XML_SCHEMA_TYPE_COMPLEX_CONTENT,
    XML_SCHEMA_TYPE_UR = ffi.C.XML_SCHEMA_TYPE_UR,
    XML_SCHEMA_TYPE_RESTRICTION = ffi.C.XML_SCHEMA_TYPE_RESTRICTION,
    XML_SCHEMA_TYPE_EXTENSION = ffi.C.XML_SCHEMA_TYPE_EXTENSION,
    XML_SCHEMA_TYPE_ELEMENT = ffi.C.XML_SCHEMA_TYPE_ELEMENT,
    XML_SCHEMA_TYPE_ATTRIBUTE = ffi.C.XML_SCHEMA_TYPE_ATTRIBUTE,
    XML_SCHEMA_TYPE_ATTRIBUTEGROUP = ffi.C.XML_SCHEMA_TYPE_ATTRIBUTEGROUP,
    XML_SCHEMA_TYPE_GROUP = ffi.C.XML_SCHEMA_TYPE_GROUP,
    XML_SCHEMA_TYPE_NOTATION = ffi.C.XML_SCHEMA_TYPE_NOTATION,
    XML_SCHEMA_TYPE_LIST = ffi.C.XML_SCHEMA_TYPE_LIST,
    XML_SCHEMA_TYPE_UNION = ffi.C.XML_SCHEMA_TYPE_UNION,
    XML_SCHEMA_TYPE_ANY_ATTRIBUTE = ffi.C.XML_SCHEMA_TYPE_ANY_ATTRIBUTE,
    XML_SCHEMA_TYPE_IDC_UNIQUE = ffi.C.XML_SCHEMA_TYPE_IDC_UNIQUE,
    XML_SCHEMA_TYPE_IDC_KEY = ffi.C.XML_SCHEMA_TYPE_IDC_KEY,
    XML_SCHEMA_TYPE_IDC_KEYREF = ffi.C.XML_SCHEMA_TYPE_IDC_KEYREF,
    XML_SCHEMA_TYPE_PARTICLE = ffi.C.XML_SCHEMA_TYPE_PARTICLE, -- = 25
    XML_SCHEMA_TYPE_ATTRIBUTE_USE = ffi.C.XML_SCHEMA_TYPE_ATTRIBUTE_USE,
    XML_SCHEMA_FACET_MININCLUSIVE = ffi.C.XML_SCHEMA_FACET_MININCLUSIVE, -- = 1000
    XML_SCHEMA_FACET_MINEXCLUSIVE = ffi.C.XML_SCHEMA_FACET_MINEXCLUSIVE,
    XML_SCHEMA_FACET_MAXINCLUSIVE = ffi.C.XML_SCHEMA_FACET_MAXINCLUSIVE,
    XML_SCHEMA_FACET_MAXEXCLUSIVE = ffi.C.XML_SCHEMA_FACET_MAXEXCLUSIVE,
    XML_SCHEMA_FACET_TOTALDIGITS = ffi.C.XML_SCHEMA_FACET_TOTALDIGITS,
    XML_SCHEMA_FACET_FRACTIONDIGITS = ffi.C.XML_SCHEMA_FACET_FRACTIONDIGITS,
    XML_SCHEMA_FACET_PATTERN = ffi.C.XML_SCHEMA_FACET_PATTERN,
    XML_SCHEMA_FACET_ENUMERATION = ffi.C.XML_SCHEMA_FACET_ENUMERATION,
    XML_SCHEMA_FACET_WHITESPACE = ffi.C.XML_SCHEMA_FACET_WHITESPACE,
    XML_SCHEMA_FACET_LENGTH = ffi.C.XML_SCHEMA_FACET_LENGTH,
    XML_SCHEMA_FACET_MAXLENGTH = ffi.C.XML_SCHEMA_FACET_MAXLENGTH,
    XML_SCHEMA_FACET_MINLENGTH = ffi.C.XML_SCHEMA_FACET_MINLENGTH,
    XML_SCHEMA_EXTRA_QNAMEREF = ffi.C.XML_SCHEMA_EXTRA_QNAMEREF,
    XML_SCHEMA_EXTRA_ATTR_USE_PROHIB = ffi.C.XML_SCHEMA_EXTRA_ATTR_USE_PROHIB
};

methods.content_type = {
    XML_SCHEMA_CONTENT_UNKNOWN = ffi.C.XML_SCHEMA_CONTENT_UNKNOWN, -- = 0
    XML_SCHEMA_CONTENT_EMPTY = ffi.C.XML_SCHEMA_CONTENT_EMPTY,
    XML_SCHEMA_CONTENT_ELEMENTS = ffi.C.XML_SCHEMA_CONTENT_ELEMENTS, -- = 2
    XML_SCHEMA_CONTENT_MIXED = ffi.C.XML_SCHEMA_CONTENT_MIXED,
    XML_SCHEMA_CONTENT_SIMPLE = ffi.C.XML_SCHEMA_CONTENT_SIMPLE, -- = 4
    XML_SCHEMA_CONTENT_MIXED_OR_ELEMENTS = ffi.C.XML_SCHEMA_CONTENT_MIXED_OR_ELEMENTS,
    XML_SCHEMA_CONTENT_BASIC = ffi.C.XML_SCHEMA_CONTENT_BASIC, -- = 6
    XML_SCHEMA_CONTENT_ANY = ffi.C.XML_SCHEMA_CONTENT_ANY
};

methods.hash_defines = {
    XML_SCHEMAS_ATTR_FIXED = 512,
    XML_SCHEMAS_ATTR_USE_PROHIBITED = 0,
    XML_SCHEMAS_ATTR_USE_REQUIRED = 1,
    XML_SCHEMAS_ATTR_USE_OPTIONAL = 2,
    XML_SCHEMAS_ATTR_GLOBAL = 1,
    XML_SCHEMAS_ATTR_NSDEFAULT = 128,
    XML_SCHEMAS_ATTR_INTERNAL_RESOLVED = 256,
    XML_SCHEMAS_ATTRGROUP_GLOBAL = 2,
    XML_SCHEMAS_ATTRGROUP_MARKED = 4,
    XML_SCHEMAS_ATTRGROUP_REDEFINED = 8,
    XML_SCHEMAS_ATTRGROUP_HAS_REFS = 16,
    UNBOUNDED = (1 << 30)
};

function metatable.__index(item, key)
  return methods[key];
end

local Schema = {};
Schema.new = function(schema_ptr, context_ptr)
    local _schema= {
        _ptr = schema_ptr,
        _context_ptr = context_ptr
    };
    setmetatable(_schema, metatable);
    return _schema;
end

local Element = {};
Element.new = function(element_ptr, schema_ptr, context_ptr)
    local tns = '';
    if (ffi.NULL ~= element_ptr.targetNamespace) then tns = ffi.string(element_ptr.targetNamespace); end
    local _elem= {
        _ptr = element_ptr,
        _schema_ptr = schema_ptr,
        _context_ptr = context_ptr,
        name = ffi.string(element_ptr.name),
        ns = tns,
        class = 'E',
        annot = element_ptr.annot
    };
    _elem.q_name = '{'.._elem.ns..'}'.._elem.name;
    local typedef_ptr = element_ptr.subtypes;
    if (typedef_ptr.attributeWildcard ~= ffi.NULL) then
        _elem.attr_wildcard = {
             process_contents = typedef_ptr.attributeWildcard.processContents
            ,any = typedef_ptr.attributeWildcard.any;
        };
        _elem.attr_wildcard.ns_set = {};
        local i = 0;
        local ptr = typedef_ptr.attributeWildcard.nsSet;
        while (ptr ~= ffi.NULL) do
            i = i + 1;
            _elem.attr_wildcard.ns_set[i] = ffi.string(ptr.value);
            ptr = ptr.next;
        end
        i = 0;
        ptr = ffi.NULL;
        ptr = typedef_ptr.attributeWildcard.negNsSet;
        _elem.attr_wildcard.neg_ns_set = {};
        while (ptr ~= ffi.NULL) do
            i = i + 1;
            _elem.attr_wildcard.neg_ns_set[i] = ffi.string(ptr.value);
            ptr = ptr.next;
        end
    end
    if (element_ptr.namedType ~= ffi.NULL) then
        _elem.type_q_name = {};
        _elem.type_q_name.local_name = ffi.string(element_ptr.namedType);
        _elem.named_type = ffi.string(element_ptr.namedType);
        _elem.type_q_name.ns = '';
        if (element_ptr.namedTypeNs ~= ffi.NULL) then
            _elem.named_type_ns = ffi.string(element_ptr.namedTypeNs);
            local t_ns = '';
            if (_elem.named_type_ns ~= nil) then t_ns = _elem.named_type_ns; end
            _elem.type_q_name.ns = t_ns;
        end
    end
    setmetatable(_elem, metatable);
    return _elem;
end

local MgrDef = {};

MgrDef.new = function(mgredef_ptr, schema_ptr, context_ptr)
    local tns = '';
    local name = ''
    if (ffi.NULL ~= mgredef_ptr.name) then name = ffi.string(mgredef_ptr.name); end
    if (ffi.NULL ~= mgredef_ptr.targetNamespace) then tns = ffi.string(mgredef_ptr.targetNamespace); end
    local _mgrdef= {
        _ptr = mgredef_ptr,
        _schema_ptr = schema_ptr,
        _context_ptr = context_ptr,
        name = name,
        ns = tns,
        class = 'M',
        annot = mgredef_ptr.annot
    };
    return _mgrdef;
end

local TypeDef = {};
TypeDef.new = function(typedef_ptr, schema_ptr, context_ptr)
    local tns = '';
    local name = ''
    if (ffi.NULL ~= typedef_ptr.name) then name = ffi.string(typedef_ptr.name); end
    if (ffi.NULL ~= typedef_ptr.targetNamespace) then tns = ffi.string(typedef_ptr.targetNamespace); end
    local _typedef= {
        _ptr = typedef_ptr,
        _schema_ptr = schema_ptr,
        _context_ptr = context_ptr,
        annot = typedef_ptr.annot,
        name = name,
        ns = tns,
        class = 'T'
    };
    _typedef.q_name = '{'.._typedef.ns..'}'.._typedef.name;
    if (typedef_ptr.attributeWildcard ~= ffi.NULL) then
        _typedef.attr_wildcard = {
             process_contents = typedef_ptr.attributeWildcard.processContents
            ,any = typedef_ptr.attributeWildcard.any;
        };
        _typedef.attr_wildcard.ns_set = {};
        local i = 0;
        local ptr = typedef_ptr.attributeWildcard.nsSet;
        while (ptr ~= ffi.NULL) do
            i = i + 1;
            _typedef.attr_wildcard.ns_set[i] = ffi.string(ptr.value);
            ptr = ptr.next;
        end
        i = 0;
        ptr = ffi.NULL;
        ptr = typedef_ptr.attributeWildcard.negNsSet;
        _typedef.attr_wildcard.neg_ns_set = {};
        while (ptr ~= ffi.NULL) do
            i = i + 1;
            _typedef.attr_wildcard.neg_ns_set[i] = ffi.string(ptr.value);
            ptr = ptr.next;
        end
    end
    setmetatable(_typedef, metatable);
    return _typedef;
end

local function get_element_type(element_ptr)
    if (element_ptr.subtypes.type == methods.type_type.XML_SCHEMA_TYPE_BASIC) then
        return 'S';
    elseif (element_ptr.subtypes.type == methods.type_type.XML_SCHEMA_TYPE_SIMPLE) then
        return 'S';
    elseif (element_ptr.subtypes.type == methods.type_type.XML_SCHEMA_TYPE_COMPLEX) then
        return 'C';
    else
        error('Unsupported Element type '..element_ptr.subtypes.type);
    end
    return nil;
end

local function get_element_content_type(element_ptr)
    if (element_ptr.subtypes.contentType == methods.content_type.XML_SCHEMA_CONTENT_BASIC) then
        return 'S';
    elseif (element_ptr.subtypes.contentType == methods.content_type.XML_SCHEMA_CONTENT_EMPTY) then
        return 'E';
    elseif (element_ptr.subtypes.contentType == methods.content_type.XML_SCHEMA_CONTENT_SIMPLE) then
        return 'S';
    elseif (element_ptr.subtypes.contentType == methods.content_type.XML_SCHEMA_CONTENT_ELEMENTS) then
        return 'C';
    elseif (element_ptr.subtypes.contentType == methods.content_type.XML_SCHEMA_CONTENT_MIXED) then
        return 'M';
    elseif (element_ptr.subtypes.builtInType == methods.value_type.XML_SCHEMAS_ANYTYPE) then
        return 'C';
    else
        error('Unsupported Element type '..element_ptr.subtypes.contentType);
    end
    return nil;
end

local function get_typedef_type(typedef_ptr)
    if (typedef_ptr.type == methods.type_type.XML_SCHEMA_TYPE_BASIC) then
        return 'S';
    elseif (typedef_ptr.type == methods.type_type.XML_SCHEMA_TYPE_SIMPLE) then
        return 'S';
    elseif (typedef_ptr.type == methods.type_type.XML_SCHEMA_TYPE_COMPLEX) then
        return 'C';
    else
        error('Unsupported type '..typedef_ptr.subtypes.type);
    end
    return nil;
end

local function get_typedef_content_type(typedef_ptr)
    if (typedef_ptr.contentType == methods.content_type.XML_SCHEMA_CONTENT_BASIC) then
        return 'S';
    elseif (typedef_ptr.contentType == methods.content_type.XML_SCHEMA_CONTENT_EMPTY) then
        return 'E';
    elseif (typedef_ptr.contentType == methods.content_type.XML_SCHEMA_CONTENT_SIMPLE) then
        return 'S';
    elseif (typedef_ptr.contentType == methods.content_type.XML_SCHEMA_CONTENT_ELEMENTS) then
        return 'C';
    elseif (typedef_ptr.contentType == methods.content_type.XML_SCHEMA_CONTENT_MIXED) then
        return 'M';
    elseif (typedef_ptr.builtInType == methods.value_type.XML_SCHEMAS_ANYTYPE) then
        return 'C';
    else
        error('Unsupported content type '..typedef_ptr.contentType);
    end
    return nil;
end

local function assimilate_model_recursively(context_ptr, schema_ptr, particle, model)
    if (particle == ffi.NULL) then return model; end
    local term = particle.children;
    if (term == ffi.NULL) then error("Missing term"); end
    --[[
    print(debug.getinfo(1).source, debug.getinfo(1).currentline, particle);
    print(debug.getinfo(1).source, debug.getinfo(1).currentline, particle.annot);
    print(debug.getinfo(1).source, debug.getinfo(1).currentline, particle.children);
    print(debug.getinfo(1).source, debug.getinfo(1).currentline, particle.children.annot);
    --]]


    local min_occurs = particle.minOccurs;
    local max_occurs = 0;
    if (particle.maxOccurs >= 1073741824) then
        max_occurs = -1;
    else
        max_occurs = particle.maxOccurs;
    end

    local symbol_type = '';
    local symbol_name = '';
    local group_type = '';


    if (term.type == methods.type_type.XML_SCHEMA_TYPE_SEQUENCE) then
        symbol_type = 'cm_begin';
        symbol_name = '_sequence_group';
        group_type = 'S';
    elseif (term.type == methods.type_type.XML_SCHEMA_TYPE_CHOICE) then
        symbol_type = 'cm_begin';
        symbol_name = '_choice_group';
        group_type = 'C';
    elseif (term.type == methods.type_type.XML_SCHEMA_TYPE_ALL) then
        symbol_type = 'cm_begin';
        symbol_name = '_all_group';
        group_type = 'A';
    elseif (term.type == methods.type_type.XML_SCHEMA_TYPE_ELEMENT) then
        local element_ptr = ffi.cast("xmlSchemaElementPtr", term);
        symbol_type = 'element';
        group_type = nil;
    elseif (term.type == methods.type_type.XML_SCHEMA_TYPE_ANY) then
        symbol_type = 'any';
        symbol_name = 'any';
        group_type = nil;
    else
        print(debug.getinfo(1).source, debug.getinfo(1).currentline, term.type);
        error("Unsupported");
    end

    if (term.type == methods.type_type.XML_SCHEMA_TYPE_ANY) then
        model[#model+1] = {};
        local index = #model;
        model[index].symbol_type = symbol_type;
        model[index].symbol_name = symbol_name;
        model[index].ns = '';
        model[index].name = 'any';
        model[index].q_name = '{'..model[index].ns..'}'..model[index].name;
        model[index].min_occurs = min_occurs;
        model[index].max_occurs = max_occurs;
        model[index].ref = false;
        model[index].root_element = false;
        model[index].element_type = 'C'
        model[index].content_type = 'C'
        model[index].named_type = nil;
        model[index].explicit_type = true;
        model[index].named_type = 'anyType'
        model[index].named_type_ns = 'http://www.w3.org/2001/XMLSchema'
        model[index].explicit_type = true;
    elseif (term.type == methods.type_type.XML_SCHEMA_TYPE_ELEMENT) then

        local element_ptr = ffi.cast("xmlSchemaElementPtr", term);

        model[#model+1] = {};
        local index = #model;
        model[index].symbol_type = symbol_type;
        model[index].symbol_name = ffi.string(element_ptr.name);
        model[index].ns = '';
        if (element_ptr.targetNamespace ~= ffi.NULL) then
            model[index].ns = ffi.string(element_ptr.targetNamespace);
        end
        model[index].name = ffi.string(element_ptr.name);
        model[index].q_name = '{'..model[index].ns..'}'..model[index].name;
        model[index].min_occurs = min_occurs;
        model[index].max_occurs = max_occurs;
        model[index].ref = false;
        local ref = libxml2.xmlGetProp(particle.node, "ref");
        if (ref ~= nil and ref ~= '') then
            model[index].ref = true;
            model[index].ref_ns = model[index].ns;
            model[index].ref_name = model[index].name;
        end
        model[index].root_element = false;
        model[index].element_type = get_element_type(element_ptr);
        model[index].content_type = get_element_content_type(element_ptr);
        model[index].element = Element.new(element_ptr, schema_ptr, context_ptr)
        model[index].named_type = nil;
        if (element_ptr.namedType ~= ffi.NULL) then
            model[index].named_type = ffi.string(element_ptr.namedType);
            if (element_ptr.namedTypeNs ~= ffi.NULL) then
                model[index].named_type_ns = ffi.string(element_ptr.namedTypeNs);
            end
            model[index].explicit_type = true;
            local item = model[index];
            local type_name = item.named_type;
            local type_name_ns = item.named_type_ns;
            if (type_name_ns == nil) then type_name_ns = ''; end
            if (type_name ~= nil) then
                model[index].type_q_name = {};
                model[index].type_q_name.ns = type_name_ns;
                model[index].type_q_name.local_name = type_name;
            end
        else
            model[index].explicit_type = false;
        end
    elseif ((term.children ~= ffi.NULL) and
        ( (term.type == methods.type_type.XML_SCHEMA_TYPE_SEQUENCE) or
        (term.type == methods.type_type.XML_SCHEMA_TYPE_CHOICE) or
        (term.type == methods.type_type.XML_SCHEMA_TYPE_ALL) ) ) then

        model[#model+1] = {};
        local begin_index = #model;
        model[begin_index].symbol_type = symbol_type;
        model[begin_index].symbol_name = symbol_name;
        model[begin_index].min_occurs = min_occurs;
        model[begin_index].max_occurs = max_occurs;
        model[begin_index].group_type = group_type;
        model[begin_index].annot = particle.children.annot;

        assimilate_model_recursively(context_ptr, schema_ptr, ffi.cast("xmlSchemaParticlePtr", term.children), model)

        model[#model+1] = {};
        model[#model].symbol_type = 'cm_end';
        model[#model].symbol_name = model[begin_index].symbol_name;
        model[#model].cm_begin_index= begin_index;
    end

    if (particle.next ~= ffi.NULL) then
        assimilate_model_recursively(context_ptr, schema_ptr, ffi.cast("xmlSchemaParticlePtr", particle.next), model)
    end

end

function methods:get_element_content_model()
    local element_ptr = self._ptr;
    local element_type = element_ptr.subtypes; -- The type definition
    if (element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_ELEMENTS and
        element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_MIXED and
        element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_EMPTY and
        element_type.builtInType ~= methods.value_type.XML_SCHEMAS_ANYTYPE) then
        --element_type.contentType  == self.content_type.XML_SCHEMA_CONTENT_MIXED)) then
        error("Element is not of complex type");
    end
    local particle = ffi.cast("xmlSchemaParticlePtr", element_type.subtypes);
    local model = {};
    assimilate_model_recursively(self._context_ptr, self._schema_ptr, particle, model);
    return model;
end

function methods:get_typedef_content_model()
    local element_type = self._ptr; -- The type definition
    if (element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_ELEMENTS and
        element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_MIXED and
        element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_EMPTY and
        element_type.builtInType ~= methods.value_type.XML_SCHEMAS_ANYTYPE) then
        error("Element is not of complex type");
    end
    local particle = ffi.cast("xmlSchemaParticlePtr", element_type.subtypes);
    local model = {};
    assimilate_model_recursively(self._context_ptr, self._schema_ptr, particle, model);
    return model;
end

local function copy_facet(to, facet)
    local facet_type = facet.type;
    local facet_value = nil;
    facet_value = nil;
    if (facet.type == methods.type_type.XML_SCHEMA_FACET_MINLENGTH) then
        if (facet.value == ffi.NULL) then
            facet_value = tostring(facet.val.value.decimal.lo);
        else
            facet_value = ffi.string(facet.value);
        end
    else
        facet_value = ffi.string(facet.value);
    end

    if (facet_type == methods.type_type.XML_SCHEMA_FACET_MININCLUSIVE) then
        to.min_inclusive = facet_value;
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_MINEXCLUSIVE) then
        to.min_exclusive =  facet_value;
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_MAXINCLUSIVE) then
        to.max_inclusive =  facet_value;
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_MAXEXCLUSIVE) then
        to.max_exclusive =  facet_value;
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_TOTALDIGITS) then
        to.total_digits = tonumber(facet_value);
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_FRACTIONDIGITS) then
        to.fractional_digits = tonumber(facet_value);
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_PATTERN) then
        if (to.pattern == nil) then
            to.pattern = {};
        end
        local i = #to.pattern + 1;
        to.pattern[i] = {};
        to.pattern[i].str_p= facet_value;
        to.pattern[i].com_p = nil;
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_ENUMERATION) then
        if (to.enumeration == nil) then
            to.enumeration = {};
        end
        to.enumeration[#to.enumeration+1] = facet_value;
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_WHITESPACE) then
        to.white_space = facet_value;
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_LENGTH) then
        to.length = tonumber(facet_value);
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_MAXLENGTH) then
        to.max_length = tonumber(facet_value);
    elseif (facet_type == methods.type_type.XML_SCHEMA_FACET_MINLENGTH) then
        to.min_length = tonumber(facet_value);
    else
        error("Invalid facet_type "..facet_type);
    end
end

local function collect_type_dtls(def_ref, element_type, t)
    local type_defn = {};

    local et;
    if (element_type.contentTypeDef == ffi.NULL) then
        et = element_type;
    else
        et = element_type.contentTypeDef
    end

    type_defn.built_in_type_id = et.builtInType;
    --print(debug.getinfo(1).source, debug.getinfo(1).currentline, (et.builtInType == methods.value_type.XML_SCHEMAS_ANYSIMPLETYPE) );

    if ((methods.XML_SCHEMAS_TYPE_VARIETY_LIST & et.flags) ~= 0) then
        type_defn.type_of_simple = 'L';
    elseif ((methods.XML_SCHEMAS_TYPE_VARIETY_UNION & et.flags) ~= 0) then
        type_defn.type_of_simple = 'U';
    elseif ((methods.XML_SCHEMAS_TYPE_VARIETY_ATOMIC & et.flags) ~= 0) then
        type_defn.type_of_simple = 'A';
    elseif (et.builtInType == methods.value_type.XML_SCHEMAS_ANYSIMPLETYPE) then
        type_defn.type_of_simple = 'A';
    else
        error("Invalid simple type "..et.flags);
    end

    if (type_defn.type_of_simple == 'A') then
        type_defn.base = {};
        if (t == 't') then
            type_defn.base.ns = ffi.string(element_type.baseNs);
            type_defn.base.name = ffi.string(element_type.base);
        else
            if (element_type.base ~= nil and element_type.base ~= ffi.NULL) then
                type_defn.base.ns = ffi.string(element_type.baseNs);
                type_defn.base.name = ffi.string(element_type.base);
            else
                type_defn.base.ns = ffi.string(element_type.targetNamespace);
                type_defn.base.name = ffi.string(element_type.name);
            end
        end

    elseif (type_defn.type_of_simple == 'L') then
        type_defn.base = {};
        type_defn.list_item_type = {};

        local bt = nil;
        local bt = nil;
        if (element_type.contentTypeDef == ffi.NULL) then
            bt = element_type;
        else
            bt = element_type.contentTypeDef
        end

        local base_name = nil;
        local base_ns = nil;
        local local_facets = nil;
        local facet_link = nil;
        local built_in_type_id = nil;
        if (bt.subtypes.name == ffi.NULL) then
            base_name = ffi.string(bt.subtypes.base);
            base_ns = ffi.string(bt.subtypes.baseNs);
            local_facets = bt.subtypes.facets;
            facet_link = bt.subtypes.facetSet;
            built_in_type_id = bt.subtypes.builtInType;
        else
            base_name = ffi.string(bt.subtypes.name);
            base_ns = ffi.string(bt.subtypes.targetNamespace);
            local_facets = ffi.NULL
            facet_link = bt.subtypes.facetSet;
            built_in_type_id = bt.subtypes.builtInType;
        end

        type_defn.list_item_type.base = {};
        type_defn.list_item_type.base.name = base_name;
        type_defn.list_item_type.base.ns = base_ns;
        if (type_defn.list_item_type.base.ns == 'http://www.w3.org/2001/XMLSchema') then
            type_defn.list_item_type.is_primitive = true;
        else
            type_defn.list_item_type.is_primitive = false;
        end

        type_defn.list_item_type.typedef = TypeDef.new(bt.subtypes, def_ref._schema_ptr, def_ref._context_ptr);
        type_defn.list_item_type.built_in_type_id = built_in_type_id;
        type_defn.list_item_type.local_facets = {};
        local facet = local_facets;
        while (facet ~= ffi.NULL) do
            copy_facet(type_defn.list_item_type.local_facets, facet);
            facet = facet.next;
        end

        type_defn.list_item_type.facets = {};
        local facet_link = facet_link;
        while (facet_link ~= nil and facet_link ~= ffi.NULL) do
            facet = facet_link.facet;
            copy_facet(type_defn.list_item_type.facets, facet);
            facet_link = facet_link.next;
        end

    else
        type_defn.member_types = {};
        type_defn.base = {};
        local member_link = nil;;
        local bt = nil;
        if (element_type.contentTypeDef == ffi.NULL) then
            bt = element_type;
        else
            bt = element_type.contentTypeDef
        end
        local base = {};
        while ((bt ~= ffi.NULL) and (bt.type == methods.type_type.XML_SCHEMA_TYPE_SIMPLE)) do
            if (bt.memberTypes ~= ffi.NULL) then
                member_link = (bt.memberTypes);
                break;
            else
                bt = bt.baseType;
            end
        end
        if (member_link == nil) then
            error("Could not establish memeber types");
        end

        local i = #type_defn.member_types;
        while (member_link ~= ffi.NULL) do
            local mt = member_link.type;
            i = i + 1;
            type_defn.member_types[i] = {};
            do
                type_defn.member_types[i].base = {};
                if (mt.name ~= nil and mt.name ~= ffi.NULL) then
                    -- Case where itemType is specified.
                    type_defn.member_types[i].base.ns = ffi.string(mt.targetNamespace);
                    type_defn.member_types[i].base.name = ffi.string(mt.name);
                else
                    type_defn.member_types[i].base.ns = ffi.string(mt.baseNs);
                    type_defn.member_types[i].base.name = ffi.string(mt.base);
                end
                type_defn.member_types[i].typedef = TypeDef.new(mt, def_ref.schema_ptr, def_ref.context_ptr);
                type_defn.member_types[i].built_in_type_id = mt.builtInType;

                type_defn.member_types[i].local_facets = {};
                local facet = mt.facets;
                while (facet ~= ffi.NULL) do
                    copy_facet(type_defn.member_types[i].local_facets, facet);
                    facet = facet.next;
                end

                type_defn.member_types[i].facets = {};
                local facet_link = mt.facetSet;
                while (facet_link ~= nil and facet_link ~= ffi.NULL) do
                    facet = facet_link.facet;
                    copy_facet(type_defn.member_types[i].facets, facet);
                    facet_link = facet_link.next;
                end

            end
            member_link = member_link.next;
        end
    end

    type_defn.local_facets = {};
    local facet = element_type.facets;
    while (facet ~= ffi.NULL) do
        copy_facet(type_defn.local_facets, facet);
        facet = facet.next;
    end

    type_defn.facets = {};
    local facet_link = element_type.facetSet;
    while (facet_link ~= nil and facet_link ~= ffi.NULL) do
        facet = facet_link.facet;
        copy_facet(type_defn.facets, facet);
        facet_link = facet_link.next;
    end

    return type_defn;
end

function methods:get_element_simpletype_dtls()
    local element_type = self._ptr.subtypes; -- The type definition

    if (element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_BASIC and
        element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_SIMPLE and
        element_type.type ~= self.type_type.XML_SCHEMA_TYPE_SIMPLE) then
        error("Typedef is not of simple type");
    end

    local type_dtls = collect_type_dtls(self, element_type, 'e');

    return type_dtls;
end

function methods:get_typedef_simpletype_dtls()
    local element_type = self._ptr; -- The type definition
    if (element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_BASIC and
        element_type.contentType ~= self.content_type.XML_SCHEMA_CONTENT_SIMPLE and
        element_type.type ~= self.type_type.XML_SCHEMA_TYPE_SIMPLE) then
        error("Typedef is not of simple type");
    end

    local type_dtls = collect_type_dtls(self, element_type, 't');

    return type_dtls;
end

local function get_element_primary_bi_type(item_ptr)
    local ptype = item_ptr.subtypes;
    while ((ptype ~= ffi.NULL) and (ptype.type ~= methods.type_type.XML_SCHEMA_TYPE_BASIC)) do
        ptype = ptype.baseType;
        if (ptype == ffi.NULL) then
            error("Could not get builtin type");
        end
    end
    return { name = ffi.string(ptype.name), ns = ffi.string(ptype.targetNamespace) } ;
end

local function get_typedef_primary_bi_type(item_ptr)
    local ptype = item_ptr;
    while ((ptype ~= ffi.NULL) and (ptype.type ~= methods.type_type.XML_SCHEMA_TYPE_BASIC)) do
        ptype = ptype.baseType;
        if (ptype == ffi.NULL) then
            error("Could not get builtin type");
        end
    end
    return { name = ffi.string(ptype.name), ns = ffi.string(ptype.targetNamespace) } ;
end

local Attr = {};
Attr.new = function(attr_ptr, def_ref)
    if (attr_ptr.type == methods.type_type.XML_SCHEMA_EXTRA_ATTR_USE_PROHIB) then
        error("Facility to prohibit usage of attribute not yet supported");
        return nil;
    end
    local _attr= {
        _ptr = attr_ptr
        ,_decl = attr_ptr.attrDecl

    };
    local decl = attr_ptr.attrDecl;
    local bi_type = get_element_primary_bi_type(decl)
    _attr.bi_type = bi_type;
    _attr.name = ffi.string(decl.name);
    _attr.type = get_element_primary_bi_type(decl);
    if (decl.targetNamespace ~= ffi.NULL) then
        _attr.ns = decl.targetNamespace;
        _attr.form = 'Q';
    else
        _attr.ns = '';
        _attr.form = 'U';
    end
    if (decl.defValue ~= ffi.NULL) then
        _attr.def_value = decl.defValue;
    else
        _attr.def_value = '';
    end
    local i_fixed = decl.flags & methods.hash_defines.XML_SCHEMAS_ATTR_FIXED;
    if (i_fixed ~= 0) then
        _attr.fixed = true;
    else
        _attr.fixed = false;
    end
    if (attr_ptr.occurs == methods.hash_defines.XML_SCHEMAS_ATTR_USE_PROHIBITED) then
        _attr.use = 'P';
    elseif (attr_ptr.occurs == methods.hash_defines.XML_SCHEMAS_ATTR_USE_REQUIRED) then
        _attr.use = 'R';
    else
        _attr.use = 'O';
    end

    local td = collect_type_dtls(def_ref, decl.subtypes, 'e');
    _attr.local_facets = td.local_facets;
    _attr.facets = td.facets;
    _attr.type_of_simple = td.type_of_simple;
    if (td.type_of_simple == 'U') then
        _attr.member_types = td.member_types;
    elseif (td.type_of_simple == 'L') then
        _attr.list_item_type = td.list_item_type;
    end
    _attr.base = td.base;
    _attr.built_in_type_id = td.built_in_type_id;

    setmetatable(_attr, metatable);
    return _attr;
end

function methods:parse(xsd_file)
    libxml2.xmlLineNumbersDefault(1);
    local context_ptr = libxml2.xmlSchemaNewParserCtxt(xsd_file)
    if not context_ptr then
        error("Failed to create context to parse XML")
    end
    local schema_ptr = libxml2.xmlSchemaParse(context_ptr)
    if (schema_ptr == nil) then
        error('Unable to parse XSD');
    end
    local s = Schema.new(schema_ptr, context_ptr)
    return s;
end

function methods:get_target_ns()
    local schema_ptr = self._ptr;
    return libxml2.xmlGetTargetNs(schema_ptr);
end

function methods:get_type_defs()
    local type_defs = libxml2.xmlSchemaGetGlobalTypeDefs(self._ptr);
    if ((type_defs == ffi.NULL) or (type_defs == nil)) then
        --error("Could not get typedefs ");
        return nil;
    end
    local typedef_array = {};
    local i = 0;
    local typedef_ptr = type_defs[i];
    while (typedef_ptr ~= ffi.NULL) do
        typedef_array[#typedef_array+1] = TypeDef.new(typedef_ptr, self._ptr, self._context_ptr);
        i = i+1;
        typedef_ptr = type_defs[i];
    end
    return typedef_array;
end

function methods:get_type_defn(name, nsName);
    local type_def = libxml2.xmlSchemaGetType(self._ptr, name, nsName);
    if (type_def == ffi.NULL or type_def == nil) then
        error("Could not locate typedef {"..nsName.."}"..name);
        return nil;
    end
    local e = TypeDef.new(type_def, self._ptr, self._context_ptr)
    return e;
end

function methods:get_element_decls()
    local elem_decls = libxml2.xmlSchemaGetGlobalElements(self._ptr);
    if ((elem_decls == ffi.NULL) or (elem_decls == nil)) then
        --error("Coule not local elements ");
        return nil;
    end
    local elem_array = {};
    local i = 0;
    local elem_ptr = ffi.cast("xmlSchemaElementPtr", elem_decls[i]);
    while (elem_ptr ~= ffi.NULL) do
        elem_array[#elem_array+1] = Element.new(elem_ptr, self._ptr, self._context_ptr);
        i = i+1;
        elem_ptr = ffi.cast("xmlSchemaElementPtr", elem_decls[i]);
    end
    return elem_array;
end

function methods:get_element_decl(name, nsName);
    local elem_decl = libxml2.xmlSchemaGetElem(self._ptr, name, nsName);
    if (elem_decl == ffi.NULL or elem_decl == nil) then
        error("Could not locate element {"..nsName.."}"..name);
        return nil;
    end
    local e = Element.new(elem_decl, self._ptr, self._context_ptr)
    return e;
end

function methods:get_model_group_defs()
    local mgr_defs = libxml2.xmlSchemaGetGlobalModelGroupDefs(self._ptr);
    if ((mgr_defs == ffi.NULL) or (mgr_defs == nil)) then
        --error("Could not get modelgroupdefs ");
        return nil;
    end
    local mgrdef_array = {};
    local i = 0;
    local mgrdef_ptr = mgr_defs[i];
    while (mgrdef_ptr ~= ffi.NULL) do
        mgrdef_array[#mgrdef_array+1] = MgrDef.new(mgrdef_ptr, self._ptr, self._context_ptr);
        i = i+1;
        mgrdef_ptr = mgr_defs[i];
    end
    return mgrdef_array;
end

function methods:get_model_group_def(name, nsName);
    local mgr_def = libxml2.xmlSchemaGetModelGroupDef(self._ptr, name, nsName);
    if (mgr_def == ffi.NULL or mgr_def == nil) then
        error("Could not locate model group def {"..nsName.."}"..name);
        return nil;
    end
    local e = MgrDef.new(mgr_def, self._ptr, self._context_ptr)
    return e;
end

function methods:get_attr_list()
    return libxml2.xmlGetAttributeList(self._ptr.subtypes);
end

--[[
--This is one of such rare methods which will work irrespective of
--typedef ptr or elementPtr
--]]
function methods:get_name()
    return ffi.string(self._ptr.name);
end

--[[
--This is one of such rare methods which will work irrespective of
--typedef ptr or elementPtr
--]]
function methods:get_target_name_space()
    local tns = '';
    if (self._ptr.targetNamespace ~= ffi.NULL) then
        tns = ffi.string(self._ptr.targetNamespace);
    end
    return tns;
end

function methods:get_element_named_type()
    if (self._ptr.namedType ~= ffi.NULL) then
        return ffi.string(self._ptr.namedType);
    end
    return nil;
end

function methods:get_element_named_type_ns()
    if (self._ptr.namedTypeNs ~= ffi.NULL) then
        return ffi.string(self._ptr.namedTypeNs);
    else
        return '';
    end
end

function methods:get_element_attr_decls()
    local attr_list = libxml2.xmlGetAttributeList(self._ptr.subtypes);
    if (attr_list == nil or attr_list == ffi.NULL) then
        return nil;
    elseif (attr_list.nbItems == 0) then
        return nil;
    end
    local attrs = {};
    local items = ffi.cast("xmlSchemaAttributeUsePtr*", attr_list.items);
    local nbr = attr_list.nbItems;
    local i = 0;
    local attr_ptr = items[i];
    while (i < nbr) do
        attrs[#attrs+1] = Attr.new(attr_ptr, self)
        i = i + 1;
        attr_ptr = items[i];
    end
    return attrs;
end

function methods:get_typedef_attr_decls()
    local attr_list = libxml2.xmlGetAttributeList(self._ptr);
    if (attr_list == nil or attr_list == ffi.NULL) then
        return nil;
    elseif (attr_list.nbItems == 0) then
        return nil;
    end
    local attrs = {};
    local items = ffi.cast("xmlSchemaAttributeUsePtr*", attr_list.items);
    local nbr = attr_list.nbItems;
    local i = 0;
    local attr_ptr = items[i];
    while (i < nbr) do
        attrs[#attrs+1] = Attr.new(attr_ptr, self);
        i = i + 1;
        attr_ptr = items[i];
    end
    return attrs;
end

function methods:get_element_type()
    return get_element_type(self._ptr);
end

function methods:get_typedef_type()
    return get_typedef_type(self._ptr);
end

function methods:get_element_content_type()
    return get_element_content_type(self._ptr);
end

function methods:get_typedef_content_type()
    return get_typedef_content_type(self._ptr);
end

function methods:get_element_primary_bi_type()
    local elem = self._ptr;
    if (self:get_element_content_type() ~= 'S') then
        return self.type_type.XML_SCHEMAS_UNKNOWN;
    end
    return get_element_primary_bi_type(elem);
end

function methods:get_typedef_primary_bi_type()
    local elem = self._ptr;
    if (self:get_typedef_content_type() ~= 'S') then
        return self.type_type.XML_SCHEMAS_UNKNOWN;
    end
    return get_typedef_primary_bi_type(elem);
end

function methods:schema_get_prop_ptr(node, name)
    return libxml2.xmlGetProp(node, name)
end

local function get_qname_pf_prop(context_ptr, schema_ptr, node, propName)
    local output = { ns = '', name = '' };
    local qname = libxml2.xmlSchemaGetQNameOfProp(context_ptr, schema_ptr, node, propName)
    if (qname == nil) then
        return output;
    end
    if (qname.ns ~= ffi.NULL) then output.ns = ffi.string(qname.ns); end
    if (qname.name ~= ffi.NULL) then output.name = ffi.string(qname.name); end

    return output;
end

function methods:get_qname_of_node_prop(node, propName)
    if (propName ~= 'name' and propName ~= 'ref' and propName ~= 'type') then
        error("Property name being queried should ne one of name, ref or type");
    end
    return get_qname_pf_prop(self._context_ptr, self._ptr, node, propName);
end

function XSD.new()
    local _xsd= {
    };
    setmetatable(_xsd, metatable);
    return _xsd;
end

return XSD;
