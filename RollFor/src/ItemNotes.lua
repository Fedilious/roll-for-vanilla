RollFor = RollFor or {}
local m = RollFor

if m.ItemNotes then return end

local M = {}

local item_utils = m.ItemUtils
local info = m.pretty_print
local hl = m.colors.hl
local grey = m.colors.grey
---@diagnostic disable-next-line: deprecated
local getn = table.getn

function M.new( api, db )
  db.items = db.items or { }

  local function get_notes( item )
    local zone_name = api().GetRealZoneText()
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
    return get_notes_and_filter( item, "\n", function( note )
      return true
    end )
  end

  return {
    get_note_non_softres = get_note_non_softres,
    get_note_softres = get_note_softres,
    get_note_hardres = get_note_hardres,
    get_note_internal = get_note_internal
  }
end

m.ItemNotes = M
return M
