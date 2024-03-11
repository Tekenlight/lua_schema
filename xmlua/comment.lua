local Comment = {}

local Node = require("lua_schema.xmlua.node")

local methods = {}
local metatable = {}

function metatable.__index(element, key)
  return methods[key] or
    Node[key]
end

function Comment.new(document, node)
  local comment = {
    document = document,
    node = node,
  }
  setmetatable(comment, metatable)
  return comment
end

return Comment
