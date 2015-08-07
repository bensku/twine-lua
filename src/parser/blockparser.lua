-- Parses passages into smaller blocks

local function split(string,sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  string:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

--- Passage block parser.
-- @type #blockparsee
local parser = {}

--- Creates new passage block parser.
-- @param #string passage: Passage to process as string
-- @param #table formatParsers: List of format parsers
function parser:create(passage,formatParsers)
  
end
