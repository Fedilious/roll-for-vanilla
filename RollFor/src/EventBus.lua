RollFor = RollFor or {}
local m = RollFor

if m.EventBus then return end

local M = {}

function M.new()
  local subscribers = {}

  ---@param event_name string
  ---@param callback fun()
  local function subscribe( event_name, callback )
    subscribers[ event_name ] = subscribers[ event_name ] or {}
    table.insert( subscribers[ event_name ], callback )
  end

  ---@param event_name string
  ---@param data any
  local function notify( event_name, data )
    for _, callback in ipairs( subscribers[ event_name ] or {} ) do
      callback( data )
    end
  end

  return {
    subscribe = subscribe,
    notify = notify
  }
end

m.EventBus = M
return M