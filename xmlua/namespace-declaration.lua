local NameSpaceDeclaration = {}

local Node = require("lua_schema.xmlua.node")

local methods = {}
local metatable = {}

function metatable.__index(element, key)
  return methods[key] or
    Node[key]
end

function NameSpaceDeclaration.new(document, node)
  local namespace_declaration = {
    document = document,
    node = node,
  }
  setmetatable(namespace_declaration, metatable)
  return namespace_declaration
end

return NameSpaceDeclaration
