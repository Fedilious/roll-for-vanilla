RollFor = RollFor or {}
local m = RollFor

if m.TooltipReader then return end

local green = m.colors.green

local M = {}

function M.new()
  local function is_bop( slot )
    return false
  end

  local function short_description( slot )
    return green( "BoE" )
  end

  return {
    is_bop = is_bop,
    short_description = short_description
  }
end

m.TooltipReader = M
return M
