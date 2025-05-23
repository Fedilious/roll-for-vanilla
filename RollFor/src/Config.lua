RollFor = RollFor or {}
local m = RollFor

if m.Config then return end

local info = m.pretty_print
local print_header = m.print_header
local hl = m.colors.hl
local blue = m.colors.blue
local grey = m.colors.grey
local RollType = m.Types.RollType

local M = {}

---@alias Expansion
---| "Vanilla"
---| "BCC"

---@alias Config table

---@param db table
---@param event_bus EventBus
function M.new( db, event_bus )
  local callbacks = {}
  local toggles = {
    [ "auto_loot" ] = { cmd = "auto-loot", display = "Auto-loot", help = "toggle auto-loot" },
    [ "superwow_auto_loot_coins" ] = { cmd = "superwow-auto-loot-coins", display = "Auto-loot coins with SuperWoW", help = "toggle auto-loot coins with SuperWoW" },
    [ "auto_loot_messages" ] = { cmd = "auto-loot-messages", display = "Auto-loot messages", help = "toggle auto-loot messages" },
    [ "auto_loot_announce" ] = { cmd = "auto-loot-announce", display = "Announce auto-looted items", help = "toggle announcements of auto-loot items" },
    [ "auto_class_announce" ] = { cmd = "auto-class-announce", display = "Announce class restriction on items", help = "toggle announcing of class restriction on items" },
    [ "show_ml_warning" ] = { cmd = "ml", display = "Master loot warning", help = "toggle master loot warning" },
    [ "auto_raid_roll" ] = { cmd = "auto-rr", display = "Auto raid-roll", help = "toggle auto raid-roll" },
    [ "auto_group_loot" ] = { cmd = "auto-group-loot", display = "Auto group loot", help = "toggle auto group loot" },
    [ "auto_master_loot" ] = { cmd = "auto-master-loot", display = "Auto master loot", help = "toggle auto master loot" },
    [ "rolling_popup_lock" ] = { cmd = "rolling-popup-lock", display = "Rolling popup lock", help = "toggle rolling popup lock" },
    [ "raid_roll_again" ] = { cmd = "raid-roll-again", display = string.format( "%s button", hl( "Raid roll again" ) ), help = string.format( "toggle %s button", hl( "Raid roll again" ) ) },
    [ "loot_frame_cursor" ] = { cmd = "loot-frame-cursor", display = "Display loot frame at cursor position", help = "toggle displaying loot frame at cursor position"},
    [ "classic_look" ] = { cmd = "classic-look", display = "Classic look", help = "toggle classic look", requires_reload = true },
  }

  local function notify_subscribers( event, value )
    if not callbacks[ event ] then return end

    for _, callback in ipairs( callbacks[ event ] ) do
      callback( value )
    end
  end

  local function init()
    if not db.ms_roll_threshold then db.ms_roll_threshold = 100 end
    if not db.os_roll_threshold then db.os_roll_threshold = 99 end
    if not db.tmog_roll_threshold then db.tmog_roll_threshold = 50 end
    if not db.superwow_auto_loot_coins then db.superwow_auto_loot_coins = true end
    if db.tmog_rolling_enabled == nil then db.tmog_rolling_enabled = true end
    if db.show_ml_warning == nil then db.show_ml_warning = false end
    if db.default_rolling_time_seconds == nil then db.default_rolling_time_seconds = 10 end
    if db.master_loot_frame_rows == nil then db.master_loot_frame_rows = 5 end
    if db.auto_master_loot == nil then db.auto_master_loot = true end
    if db.auto_loot == nil then db.auto_loot = true end
    if db.auto_loot_announce == nil then db.auto_loot_announce = false end
    if db.auto_class_announce == nil then db.auto_class_announce = true end
    if db.sr_plus_strategy == nil then db.sr_plus_strategy = m.Types.SrPlusStrategy.PlayerAddsRoll end
    if db.sr_plus_multiplier == nil then db.sr_plus_multiplier = 10 end
    if db.item_notes_source == nil then db.item_notes_source = "MurderMittens" end
    if db.loot_frame_cursor == nil then db.loot_frame_cursor = true end
  end

  local function print( toggle_key )
    local toggle = toggles[ toggle_key ]
    if not toggle then return end

    local value = toggle.negate and not db[ toggle_key ] or db[ toggle_key ]
    info( string.format( "%s is %s.", toggles[ toggle_key ].display, value and m.msg.enabled or m.msg.disabled ) )
    notify_subscribers( toggle_key, value )
  end

  local function toggle( toggle_key )
    return function()
      if db[ toggle_key ] then
        db[ toggle_key ] = false
      else
        db[ toggle_key ] = true
      end

      print( toggle_key )

      if toggles[ toggle_key ].requires_reload then
        event_bus.notify( "config_change_requires_ui_reload", { key = toggle_key } )
      end
    end
  end

  local function get_possible_item_notes_sources()
    local sources = { "none" }
    for key, _ in pairs( m.ItemNotesDB ) do
      table.insert( sources, key )
    end

    return sources
  end

  local function get_possible_sr_plus_strategies()
    local strategies = { }
    for _, value in pairs( m.Types.SrPlusStrategy ) do
      table.insert( strategies, value )
    end

    return strategies
  end

  local function reset_rolling_popup()
    info( "Rolling popup position has been reset." )
    notify_subscribers( "reset_rolling_popup" )
  end

  local function reset_loot_frame()
    info( "Loot frame position has been reset." )
    notify_subscribers( "reset_loot_frame" )
  end

  local function print_roll_thresholds()
    local ms_threshold = db.ms_roll_threshold
    local os_threshold = db.os_roll_threshold
    local tmog_threshold = db.tmog_roll_threshold
    local tmog_info = string.format( ", %s %s", hl( "TMOG" ), tmog_threshold ) or ""

    info( string.format( "Roll thresholds: %s %s, %s %s%s", hl( "MS" ), ms_threshold, hl( "OS" ), os_threshold, tmog_info ) )
  end

  local function print_transmog_rolling_setting( show_threshold )
    if m.bcc then return end
    local tmog_rolling_enabled = db.tmog_rolling_enabled
    local threshold = show_threshold and tmog_rolling_enabled and string.format( " (%s)", hl( db.tmog_roll_threshold ) ) or ""
    info( string.format( "Transmog rolling is %s%s.", tmog_rolling_enabled and m.msg.enabled or m.msg.disabled, threshold ) )
  end

  local function print_default_rolling_time()
    info( string.format( "Default rolling time: %s seconds", hl( db.default_rolling_time_seconds ) ) )
  end

  local function print_sr_plus_strategy()
    info( string.format( "SR+ Strategy: %s", hl( db.sr_plus_strategy ) ) )
  end

  local function print_sr_plus_multiplier()
    info( string.format( "SR+ Multiplier: x%s", hl( db.sr_plus_multiplier ) ) )
  end

  local function print_master_loot_frame_rows()
    info( string.format( "Master loot frame rows: %s", hl( db.master_loot_frame_rows ) ) )
  end

  local function print_item_notes_source()
    local notes_len = 0

    if m.ItemNotesDB[ db.item_notes_source ] then
      notes_len = m.count_elements( m.ItemNotesDB[ db.item_notes_source ] )
    end

    info( string.format( "Item Notes Source: %s (with %s zones)", hl( db.item_notes_source ), grey( notes_len ) ) )
  end

  local function print_threshold_override()
    local quality = db.loot_threshold_override
    local str = m.msg.disabled

    if quality ~= nil then
      str = m.quality_str( quality )
    end

    info( string.format( "Loot threshold override: %s", str ))
  end

  local function print_settings()
    print_header( "RollFor Configuration" )
    print_default_rolling_time()
    print_sr_plus_strategy()
    print_sr_plus_multiplier()
    print_master_loot_frame_rows()
    print_roll_thresholds()
    print_transmog_rolling_setting()
    print_item_notes_source()
    print_threshold_override()

    for toggle_key, setting in pairs( toggles ) do
      if not setting.hidden then
        print( toggle_key )
      end
    end

    m.print( string.format( "For more info, type: %s", hl( "/rf config help" ) ) )
  end

  local function configure_default_rolling_time( args )
    if args == "config default-rolling-time" then
      print_default_rolling_time()
      return
    end

    for value in string.gmatch( args, "config default%-rolling%-time (%d+)" ) do
      local v = tonumber( value )

      if v < 4 then
        info( string.format( "Default rolling time must be at least %s seconds.", hl( "4" ) ) )
        return
      end

      if v > 60 then
        info( string.format( "Default rolling time must be at most %s seconds.", hl( "60" ) ) )
        return
      end

      db.default_rolling_time_seconds = v
      print_default_rolling_time()
      return
    end

    info( string.format( "Usage: %s <seconds>", hl( "/rf config default-rolling-time" ) ) )
  end

  local function configure_sr_plus_strategy( args )
    if args == "config sr-plus-strategy" then
      print_sr_plus_strategy()
      return
    end

    for value in string.gmatch( args, "config sr%-plus%-strategy (.*)" ) do
      local strategies = get_possible_sr_plus_strategies()
      if not m.table_contains_value( strategies, value ) then
        info( string.format( "Invalid SR+ strategy. Possible values: %s", hl( table.concat( strategies, ", " ) ) ) )
        return
      end

      db.sr_plus_strategy = value
      print_sr_plus_strategy()
      return
    end

    info( string.format( "Usage: %s <strategy>", hl( "/rf config sr-plus-strategy" ) ) )
  end

  local function configure_sr_plus_multiplier( args )
    if args == "config sr-plus-multiplier" then
      print_sr_plus_multiplier()
      return
    end

    for value in string.gmatch( args, "config sr%-plus%-multiplier (%d+)" ) do
      local v = tonumber( value )

      db.sr_plus_multiplier = v
      print_sr_plus_multiplier()
      return
    end

    info( string.format( "Usage: %s <multiplier>", hl( "/rf config sr-plus-multiplier" ) ) )
  end

  local function configure_master_loot_frame_rows( args )
    if args == "config master-loot-frame-rows" then
      print_master_loot_frame_rows()
      return
    end

    for value in string.gmatch( args, "config master%-loot%-frame%-rows (%d+)" ) do
      local v = tonumber( value )

      if v < 5 then
        info( string.format( "Master loot frame rows must be at least %s.", hl( "5" ) ) )
        return
      end

      db.master_loot_frame_rows = v
      print_master_loot_frame_rows()
      notify_subscribers( "master_loot_frame_rows" )
      return
    end

    info( string.format( "Usage: %s <rows>", hl( "/rf config master-loot-frame-rows" ) ) )
  end

  local function configure_ms_threshold( args )
    for value in string.gmatch( args, "config ms (%d+)" ) do
      db.ms_roll_threshold = tonumber( value )
      print_roll_thresholds()
      return
    end

    info( string.format( "Usage: %s <threshold>", hl( "/rf config ms" ) ) )
  end

  local function configure_os_threshold( args )
    for value in string.gmatch( args, "config os (%d+)" ) do
      db.os_roll_threshold = tonumber( value )
      print_roll_thresholds()
      return
    end

    info( string.format( "Usage: %s <threshold>", hl( "/rf config os" ) ) )
  end

  local function configure_tmog_threshold( args )
    if args == "config tmog" then
      db.tmog_rolling_enabled = not db.tmog_rolling_enabled
      print_transmog_rolling_setting( true )
      return
    end

    for value in string.gmatch( args, "config tmog (%d+)" ) do
      db.tmog_roll_threshold = tonumber( value )
      print_roll_thresholds()
      return
    end

    info( string.format( "Usage: %s <threshold>", hl( "/rf config tmog" ) ) )
  end

  local function configure_item_notes_source( args )
    if args == "config notes-source" then
      print_item_notes_source()
      return
    end

    for value in string.gmatch( args, "config notes%-source (.+)" ) do
      db.item_notes_source = value
      print_item_notes_source()
      return
    end

    info( string.format( "Usage: %s <%s>", hl( "/rf config notes-source" ), hl( table.concat( get_possible_item_notes_sources(), "|" ) ) ) )
  end

  local function loot_threshold()
    if db.loot_threshold_override ~= nil then
      return db.loot_threshold_override
    else
      return m.api.GetLootThreshold()
    end
  end

  local function print_loot_threshold()
    local reason = grey("N/A")

    if db.loot_threshold_override ~= nil then
      reason = hl("config override")
    elseif m.api.IsInGroup() then
      reason = hl("group")
    elseif m.api.IsInRaid() then
      reason = hl("raid")
    end

    local quality = m.quality_str( loot_threshold() )

    info ( string.format( "Loot threshold: %s from %s", quality, reason ) )
  end

  local function disable_loot_threshold_override()
    db.loot_threshold_override = nil
  end

  local function configure_loot_threshold_override( args )
    local quality = string.lower(string.match(args, "^config threshold (.+)") or "")
    
    if quality == "" then
      disable_loot_threshold_override()
      print_threshold_override()
    elseif quality == "0" or quality == "poor" or quality == "grey" or quality == "gray" then
      db.loot_threshold_override = 0
      print_threshold_override()
    elseif quality == "1" or quality == "common" or quality == "white" then
      db.loot_threshold_override = 1
      print_threshold_override()
    elseif quality == "2" or quality == "uncommon" or quality == "green" then
      db.loot_threshold_override = 2
      print_threshold_override()
    elseif quality == "3" or quality == "rare" or quality == "blue" then
      db.loot_threshold_override = 3
      print_threshold_override()
    elseif quality == "4" or quality == "epic" or quality == "purple" then
      db.loot_threshold_override = 4
      print_threshold_override()
    elseif quality == "5" or quality == "legendary" or quality == "orange" then
      db.loot_threshold_override = 5
      print_threshold_override()
    elseif quality == "6" or quality == "artifact" or quality == "yellow" then
      db.loot_threshold_override = 6
      print_threshold_override()
    else
      info( string.format( "Usage: %s <quality>", hl( "/rf config threshold" ) ) )
    end

    print_loot_threshold()
  end

  local function print_help()
    local v = function( name ) return string.format( "%s%s%s", hl( "<" ), grey( name ), hl( ">" ) ) end
    local function rfc( cmd ) return string.format( "%s%s", blue( "/rf config" ), cmd and string.format( " %s", hl( cmd ) ) or "" ) end

    print_header( "RollFor Configuration Help" )
    m.print( string.format( "%s - show configuration", rfc() ) )
    m.print( string.format( "%s - toggle minimap icon", rfc( "minimap" ) ) )
    m.print( string.format( "%s - lock/unlock minimap icon", rfc( "minimap lock" ) ) )
    m.print( string.format( "%s - show default rolling time", rfc( "default-rolling-time" ) ) )
    m.print( string.format( "%s %s - set default rolling time", rfc( "default-rolling-time" ), v( "seconds" ) ) )
    m.print( string.format( "%s - show master loot frame rows", rfc( "master-loot-frame-rows" ) ) )
    m.print( string.format( "%s - show MS rolling threshold ", rfc( "ms" ) ) )
    m.print( string.format( "%s %s - set MS rolling threshold ", rfc( "ms" ), v( "threshold" ) ) )
    m.print( string.format( "%s - show OS rolling threshold ", rfc( "os" ) ) )
    m.print( string.format( "%s %s - set OS rolling threshold ", rfc( "os" ), v( "threshold" ) ) )

    if m.vanilla then
      m.print( string.format( "%s - toggle TMOG rolling", rfc( "tmog" ) ) )
      m.print( string.format( "%s %s - set TMOG rolling threshold", rfc( "tmog" ), v( "threshold" ) ) )
    end

    m.print( string.format( "%s - disable loot threshold override", rfc( "threshold" )))
    m.print( string.format( "%s %s - set loot threshold override", rfc( "threshold" ), v( "quality" )))


    m.print( string.format( "%s - show SR+ strategy", rfc( "sr-plus-strategy" )))
    m.print( string.format( "%s %s - set SR+ strategy", rfc( "sr-plus-strategy" ), grey( table.concat( get_possible_sr_plus_strategies(), "|" ) )))

    m.print( string.format( "%s - show SR+ multiplier", rfc( "sr-plus-multiplier" )))
    m.print( string.format( "%s %s - set SR+ multiplier", rfc( "sr-plus-multiplier" ), v( "multiplier" )))

    m.print( string.format( "%s - show item notes source", rfc( "notes-source" )))
    m.print( string.format( "%s %s - set item notes source", rfc( "notes-source" ), grey( table.concat( get_possible_item_notes_sources(), "|" ) )))

    for _, setting in pairs( toggles ) do
      if not setting.hidden then
        m.print( string.format( "%s - %s", rfc( setting.cmd ), setting.help ) )
      end
    end

    m.print( string.format( "%s - reset rolling popup position", rfc( "reset-rolling-popup" ) ) )
    m.print( string.format( "%s - reset loot frame position", rfc( "reset-loot-frame" ) ) )
  end

  local function lock_minimap_button()
    db.minimap_button_locked = true
    info( string.format( "Minimap button is %s.", m.msg.locked ) )
    notify_subscribers( "minimap_button_locked", true )
  end

  local function unlock_minimap_button()
    db.minimap_button_locked = false
    info( string.format( "Minimap button is %s.", m.msg.unlocked ) )
    notify_subscribers( "minimap_button_locked", false )
  end

  local function hide_minimap_button()
    db.minimap_button_hidden = true
    notify_subscribers( "minimap_button_hidden", true )
  end

  local function show_minimap_button()
    db.minimap_button_hidden = false
    notify_subscribers( "minimap_button_hidden", false )
  end

  local function on_command( args )
    if args == "config" then
      print_settings()
      return
    end

    if args == "config help" then
      print_help()
      return
    end

    for toggle_key, setting in pairs( toggles ) do
      if args == string.format( "config %s", setting.cmd ) then
        toggle( toggle_key )()
        return
      end
    end

    if args == "config reset-rolling-popup" then
      reset_rolling_popup()
      return
    end

    if args == "config reset-loot-frame" then
      reset_loot_frame()
      return
    end

    if args == "config minimap" then
      if db.minimap_button_hidden then
        show_minimap_button()
      else
        hide_minimap_button()
      end

      return
    end

    if args == "config minimap lock" then
      if db.minimap_button_locked then
        unlock_minimap_button()
      else
        lock_minimap_button()
      end

      return
    end

    if string.find( args, "^config ms" ) then
      configure_ms_threshold( args )
      return
    end

    if string.find( args, "^config os" ) then
      configure_os_threshold( args )
      return
    end

    if string.find( args, "^config tmog" ) then
      configure_tmog_threshold( args )
      return
    end

    if string.find( args, "^config default%-rolling%-time" ) then
      configure_default_rolling_time( args )
      return
    end

    if string.find( args, "^config master%-loot%-frame%-rows" ) then
      configure_master_loot_frame_rows( args )
      return
    end

    if string.find( args, "^config sr%-plus%-strategy" ) then
      configure_sr_plus_strategy( args )
      return
    end

    if string.find( args, "^config sr%-plus%-multiplier" ) then
      configure_sr_plus_multiplier( args )
      return
    end

    if string.find( args, "^config notes%-source" ) then
      configure_item_notes_source( args )
      return
    end

    if string.find( args, "^config threshold") then
      configure_loot_threshold_override( args )
      return
    end

    print_help()
  end

  local function subscribe( event, callback )
    callbacks[ event ] = callbacks[ event ] or {}
    table.insert( callbacks[ event ], callback )
  end

  local function roll_threshold( roll_type )
    local threshold = (roll_type == RollType.MainSpec or roll_type == RollType.SoftRes) and db.ms_roll_threshold or
        roll_type == RollType.OffSpec and db.os_roll_threshold or
        db.tmog_roll_threshold
    local threshold_str = string.format( "/roll%s", threshold == 100 and "" or string.format( " %s", threshold ) )

    return {
      value = threshold,
      str = threshold_str
    }
  end

  init()

  ---@param setting_key string
  ---@param expansion Expansion?
  ---@param not_available_value any?
  local function get( setting_key, expansion, not_available_value )
    if expansion and (expansion == "Vanilla" and m.bcc or expansion == "BCC" and m.vanilla) then
      return function()
        return not_available_value
      end
    end

    return function()
      return db[ setting_key ]
    end
  end

  local function printfn( setting_key ) return function() print( setting_key ) end end

  local config = {
    configure_ms_threshold = configure_ms_threshold,
    configure_os_threshold = configure_os_threshold,
    configure_tmog_threshold = configure_tmog_threshold,
    hide_minimap_button = hide_minimap_button,
    lock_minimap_button = lock_minimap_button,
    minimap_button_hidden = get( "minimap_button_hidden" ),
    minimap_button_locked = get( "minimap_button_locked" ),
    ms_roll_threshold = get( "ms_roll_threshold" ),
    on_command = on_command,
    os_roll_threshold = get( "os_roll_threshold" ),
    print = print,
    print_help = print_help,
    print_raid_roll_settings = printfn( "auto_raid_roll" ),
    print_loot_threshold = print_loot_threshold,
    reset_rolling_popup = reset_rolling_popup,
    reset_loot_frame = reset_loot_frame,
    roll_threshold = roll_threshold,
    show_minimap_button = show_minimap_button,
    subscribe = subscribe,
    tmog_roll_threshold = get( "tmog_roll_threshold" ),
    tmog_rolling_enabled = get( "tmog_rolling_enabled", "Vanilla", false ),
    unlock_minimap_button = unlock_minimap_button,
    default_rolling_time_seconds = get( "default_rolling_time_seconds" ),
    master_loot_frame_rows = get( "master_loot_frame_rows" ),
    configure_master_loot_frame_rows = configure_master_loot_frame_rows,
    loot_threshold = loot_threshold,
    auto_class_announce = get( "auto_class_announce" ),
    loot_frame_cursor = get( "loot_frame_cursor" ),
    sr_plus_strategy = get( "sr_plus_strategy" ),
    sr_plus_multiplier = get( "sr_plus_multiplier" ),
    item_notes_source = get( "item_notes_source" ),
  }

  for toggle_key, _ in pairs( toggles ) do
    config[ toggle_key ] = get( toggle_key )
    config[ "toggle_" .. toggle_key ] = toggle( toggle_key )
  end

  return config
end

m.Config = M
return M
