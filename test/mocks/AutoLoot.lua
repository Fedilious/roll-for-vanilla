local M = {}

local u = require( "test/utils" )

function M.new()
  ---@type AutoLoot
  return {
    is_auto_looted = function() return false end,
    on_loot_opened = u.noop,
    add = u.noop,
    remove = u.noop,
    clear = u.noop,
    loot_item = u.noop
  }
end

return M
