local Entity = {}

local Node = require("lua_schema.xmlua.node")

local methods = {}
local metatable = {}

function metatable.__index(element, key)
  return methods[key] or
    Node[key]
end

function Entity.new(document, node)
  local entity = {
    document = document,
    node = node,
  }
  setmetatable(entity, metatable)
  return entity
end

return Entity
