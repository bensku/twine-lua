-- Default passage parser

local function split(string,sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  string:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

local parser = {}

parser.iterator = {}

function parser:create(iterator)
  self.iterator = iterator
end

function parser:getPassageName(line,tagsStart)
  local name
  if tagsStart ~= nil then
    name = line:sub(3, tagsStart-1)
  else
    name = line:sub(3)
  end
  
  return name
end

function parser:getTags(line,tagsStart)
  if tagsStart == nil then return {} end
  
  local stringList = line:sub(tagsStart+1, line:len()-1) -- tag1,tag2,tag3,tag4
  local table = split(stringList, ",")
  
  return table
end

function parser:parseNewPassage(line)
  local tagsStart = line:find("[")
  
  local name = self:getPassageName(line,tagsStart)
  local tags = self:getTags(line,tagsStart)
  
  return name, tags
end

function parser:parse()
  local it = self.iterator -- Faster
  local passages = {}
  
  local lastPassage
  while it.hasNext() do
    local line = it.next()
    
    if line:find("::") == 1 then
      if passages ~= nil then
        passages[lastPassage.name] = lastPassage
        lastPassage = {}
      end
      
      local name,tags = self:parseNewPassage(line)
      lastPassage.name = name
      lastPassage.tags = tags
    else
      lastPassage.content = table.concat({lastPassage.content, "\n", line})
    end
  end
  
  return passages
end

return parser