-- Link parser

local parser = {}

function parser:getType()
  return "simple"
end

function parser:betweenOfChars()
  return "[[", "]]"
end

function parser:parseBlock(text)
  local separators = {} -- TODO make it extensible
  separators["|"] = nil
  separators["->"] = nil
  separators["<-"] = true
  
  local name
  local display
  
  for sep,reverse in pairs(separators) do
    local pos = text:find(sep)
    
    if pos ~= nil then
      if reverse then
        name = text:gsub(1,pos-1)
        display = text:gsub(pos+sep:len())
      end
    end
  end
  
  local link = {}
  link.name = name
  link.display = display
end