-- Importer for Twine's "twee" format.

local twinelua = {}

local passageparser = require "twinelua.passageparser"
local blockparser =  require "twinelua.blockparser"

--- Import data from string.
-- @param #string text: Twee data as string
-- @return #object: Imported data structure in Lua, or nil in case of fail
-- @return #string: If import failed, error message
function twinelua:importData(text)
  
end

return twinelua