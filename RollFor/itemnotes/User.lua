RollFor = RollFor or {}
local m = RollFor

if not m.ItemNotesDB then
  m.ItemNotesDB = {}
end

local NOTES_NAME = "User";

if m.ItemNotesDB[ NOTES_NAME ] then return end

local M = {}

-- General instructions:
--
-- Each item is referred to by its ID. Notes are ALWAYS shown to the masterlooter and, based on the circumstance, on the roll text.
-- Items with the "softres" flag true will be shown on items that are soft-reserved.
-- Items with the "hardres" flag true will be shown on items that are hard-reserved.
-- Items with the "normal" flag true will be shown on items that are neither soft nor hard-reserved, i.e. are being rolled for MS/OS/TMOG.
-- You can combine flags to show a note on multiple cases, e.g. on normal and SR but not HR rolls.
-- If none of the flags is set, the note is considered "internal" and will ONLY be shown to the masterlooter. This is useful for information
-- about the item or general guidance on what is considered MS for it.
-- An item can have more than one notes, potentially with different flags, so that you show different things based on the situation.
-- Remember: In Lua we start counting at 1!
--
-- To make sure your notes are stored correctly, type /rfnotes.
-- Notes are only shown in the corresponding zone.

local function ahn_qiraj()
  return {
    [ 21323 ] = { -- Green Qiraji Resonating Crystal
      [ 1 ] = {
        [ "note" ] = "/roll if interested",
        [ "normal" ] = true
      }
    },
    [ 21324 ] = { -- Yellow Qiraji Resonating Crystal
      [ 1 ] = {
        [ "note" ] = "/roll if interested",
        [ "normal" ] = true
      }
    },
    [ 21218 ] = { -- Blue Qiraji Resonating Crystal
      [ 1 ] = {
        [ "note" ] = "/roll if interested",
        [ "normal" ] = true
      }
    }
  }
end

local function molten_core()
  return {
  };
end

local function blackwing_lair()
  return {
    [ 20383 ] = { -- Head of the Broodlord Lashlayer
      [ 1 ] = {
        [ "note" ] = "/roll if you have the quest and want the item. DO NOT RIGHT CLICK BOSS UNTIL HEAD HAS BEEN LOOTED.",
        [ "normal" ] = true
      }
    },
  };
end

local function naxxramas()
  return { };
end

M[ "Ahn'Qiraj" ] = ahn_qiraj()
M[ "Blackwing Lair" ] = blackwing_lair()
M[ "Molten Core" ] = molten_core()
M[ "Naxxramas" ] = naxxramas()

m.ItemNotesDB[ NOTES_NAME ] = M
return M;
