RollFor = RollFor or {}
local m = RollFor

if m.ItemNotes then return end

local M = {}
local _G = getfenv( 0 )

local item_utils = m.ItemUtils
local info = m.pretty_print
local hl = m.colors.hl
local grey = m.colors.grey
---@diagnostic disable-next-line: deprecated
local getn = table.getn

function M.new( api, db, config )
  local function get_notes( item )
    local note_db_name = config.item_notes_source()
    local zone_name = api.GetRealZoneText()
    local note_db = m.ItemNotesDB[ note_db_name ] or {}
    local item_ids = note_db[ zone_name ] or {}

    return item_ids[ item.id ] or {}
  end

  local function get_notes_and_filter( item, separator, filter )
    local notes = get_notes( item )
    local str = ""
    local first = true

    for _, note in ipairs( notes ) do
      if filter( note ) then
        if not first then
          str = str .. separator
        else
          first = false
        end

        str = str .. note.note
      end
    end

    if str == "" then
      return nil
    end

    return str
  end

  local function get_note_non_softres( item )
    return get_notes_and_filter( item, ", ", function( note )
      return note.normal
    end )
  end

  local function get_note_softres( item )
    return get_notes_and_filter( item, ", ", function( note )
      return note.softres
    end )
  end

  local function get_note_hardres( item )
    return get_notes_and_filter( item, ", ", function( note )
      return note.hardres
    end )
  end

  local function get_note_internal( item )
    local notes = get_notes( item )
    local str = ""
    local first = true
    local separator = "\n"

    for _, note in ipairs( notes ) do
      if not first then
        str = str .. separator
      else
        first = false
      end

      if note.hardres then
        str = str .. hl( "(HR) " )
      end

      if note.softres then
        str = str .. hl( "(SR) " )
      end

      if note.normal then
        str = str .. hl( "(MS/OS) " )
      end

      if not note.hardres and not note.softres and not note.normal then
        str = str .. hl( "Internal Note: " )
      end

      str = str .. note.note
    end

    if str == "" then
      return nil
    end

    return str
  end

  local function on_command( args )
    if args == "" then
      args = nil
    end

    local note_db_name = config.item_notes_source()
    local zone_name = args or api.GetRealZoneText()

    info( string.format( "Using item note database: %s", hl( note_db_name ) ) )

    local note_db = m.ItemNotesDB[ note_db_name ] or {}
    local item_ids = note_db[ zone_name ] or {}

    if getn( item_ids ) == 0 then
      info( string.format( "No notes found for zone %s", hl( zone_name ) ) )
      info( string.format( "Use /rfnotes %s to select a zone. The following zones have items: ", hl("zone") ) )
      for zone_name, _ in pairs( note_db ) do
        info( grey( zone_name ) )
      end
    end

    for item_id, notes in pairs( item_ids ) do
      local item_link = m.fetch_item_link_and_quality( item_id ) or grey( string.format( "Unknown item %s", item_id ) )

      for _, note in ipairs( notes ) do
        local descriptor_hr = note.hardres and hl(" (HR)") or ""
        local descriptor_sr = note.softres and hl(" (SR)") or ""
        local descriptor_normal = note.normal and hl(" (MS/OS)") or ""

        info( string.format( "%s:%s%s%s %s", item_link, descriptor_hr, descriptor_sr, descriptor_normal, note.note ) )
      end
    end
  end

  _G[ "SLASH_RFNOTES1" ] = "/rfnotes"
  _G[ "SlashCmdList" ][ "RFNOTES" ] = on_command

  return {
    get_note_non_softres = get_note_non_softres,
    get_note_softres = get_note_softres,
    get_note_hardres = get_note_hardres,
    get_note_internal = get_note_internal
  }
end

m.ItemNotes = M
return M
