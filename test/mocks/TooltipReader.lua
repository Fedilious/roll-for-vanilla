RollFor = RollFor or {}
local m = RollFor

if m.TooltipReader then return end

local M = {}

function M.new()
  local function is_bop( slot )
    return false
  end

  return {
    is_bop = is_bop,
  }
end

m.TooltipReader = M
return M
