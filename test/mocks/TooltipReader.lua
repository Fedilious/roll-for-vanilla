RollFor = RollFor or {}
local m = RollFor

local M = {}

function M.new()
  ---@type TooltipReader
  return {
    get_slot_bind_type = function() return nil end
  }
end

m.TooltipReader = M
return M
