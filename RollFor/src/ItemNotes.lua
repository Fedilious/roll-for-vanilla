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

function M.new( api, db )
  db.items = db.items or { }

  local function get_notes( item )
    local zone_name = api.GetRealZoneText()
    local item_ids = db.items[ zone_name ] or {}

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

      str = str .. note.note
    end

    if str == "" then
      return nil
    end

    return str
  end

  local function on_command( args )
    local zone_name = api.GetRealZoneText()
    local item_ids = db.items[ zone_name ] or {}

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
