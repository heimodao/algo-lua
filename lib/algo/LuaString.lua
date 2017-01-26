--- `algo.LuaString` class.
-- An string object which thinnly wraps native Lua string, using an array to
-- store characters internally.
-- @classmod LuaString
local Array = require "algo.Array"
local LuaString = {}
package.loaded['LuaString'] = LuaString

--- Index string object.
-- Since using internal indexing is sometimes tricky; use OOP method call
-- `get` is preferred.
LuaString.__index = function (t, k)
  if type(k) == "number" then
    return t.string:get(k)
  else
    return rawget(LuaString, k)
  end
end

--- Assign data by indexing the string object.
-- Since using internal indexing is sometimes tricky; use OOP method call
-- `set` is preferred.
LuaString.__newindex = function (t, k, v)
  if type(k) == "number" then
    t.string:set(k, v)
  else
    rawset(LuaString, k, v)
  end
end

--- LuaString presentation of the string object.
LuaString.__tostring = function (o)
  return o.raw_string
end

--- Get the length of the string object.  Use OOP method call `len` is preferred.
LuaString.__len = function (o)
  return o:len()
end

--- Check whether two string object are equal.
LuaString.__eq = function (a, b)
  if type(a) ~= type(b) then
    return false
  end

  if a:len() ~= b:len() then
    return false
  end

  for i = 1, a:len() do
    if a:get(i) ~= b:get(i) then
      return false
    end
  end

  return true
end

--- Concatnate two string objects.
-- @return A new string object.
LuaString.__concat = function (a, b)
  return LuaString:new(a:raw() .. b:raw())
end

--- Create a string object.
-- @param s a string or number
-- @return A string object.
function LuaString:new(s)
  if type(s) ~= "number" and type(s) ~= "string" then
    error("Unsupported type: " .. type(s) .. " " .. string.format("%s", s) .. "\n")
  end

  local len = string.len(s)
  self = {}
  self.string = Array:new(len)
  self.raw_string = s
  self._index = 0
  setmetatable(self, LuaString)

  for i = 1, len do
    self.string:set(i, string.sub(s, i, i))
  end

  return self
end

--- Get a raw Lua string from a string object.
function LuaString:raw()
  return self.raw_string
end

--- Iterate over the string object.
-- @return An iterator of string objects; each object presents an Lua string.
function LuaString:iter()
  return function ()
    self._index = self._index + 1
    local s = self.string:get(self._index)
    if s then
      return LuaString:new(s)
    else
      return nil
    end
  end
end

--- Reset the internal iterator.
function LuaString:reset()
  self._index = 0
end

--- Get the character at the index number.
-- @param i The index number.
-- @return The character at the index number.
function LuaString:get(i)
  return self.string:get(i)
end

--- Get the length of the string object, using UTF8 character as the unit.
-- @return The lenght of the string.
function LuaString:len()
  return self.string:len()
end

--- Insert a substring at the index number.
-- @param idx the index, optional.
-- @param s a substring
-- @return A new string object.
function LuaString:insert(idx, s)
  local _idx = nil
  local _s = nil

  -- Check the type of parameters
  if type(idx) == "number" then
    _idx = idx
    _s = s
  elseif type(idx) == "string" then
    _s = idx
  else
    error("Invalid parameter type " .. type(idx) .. " " .. idx)
  end

  local raw = self.raw_string
  local len = string.len(raw)

  if _idx then
    raw = string.sub(raw, 1, _idx - 1) .. s .. string.sub(raw, _idx, len)
  else
    raw = raw .. _s
  end

  return LuaString:new(raw)
end

function LuaString:remove(start, stop)
  local raw = self.raw_string
  local len = string.len(raw)

  raw = string.sub(raw, 1, start - 1) .. string.sub(raw, stop + 1, len)

  return LuaString:new(raw)
end

function LuaString:reverse()
  local raw = string.reverse(self.raw_string)
  return LuaString:new(raw)
end

return LuaString