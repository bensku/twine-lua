-- Parses passages into smaller blocks

local function split(string,sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  string:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

--- Passage block parser.
-- @type #blockparser
local parser = {}

--- Creates new passage block parser.
-- @param #string passage: Passage to process as string
-- @param #table formatParsers: List of format parsers
function parser:create(passage,formatParsers)
  for line,parser in pairs(formatParsers) do
    if parser:getType() == "simple" then
      local find1,find2 = parser:betweenOfChars()
      local find1len = find1:len()
      local find2len = find2:len()
      
      local start = passage:find(find1)
      repeat
        local stop = passage:find(find2,start+find1len)
        
        local str = passage:rep(start+find1len,stop-find2len)
        local result = parser:parseBlock(str)
        
        start = passage:find(find1,stop+find2len)
      until start == nil
    end
  end
end
