RollFor = RollFor or {}
local m = RollFor

if not m.ItemNotesDB then
  m.ItemNotesDB = {}
end

local NOTES_NAME = "MurderMittens";

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
    [ 21321 ] = { -- Red Mount
      [ 1 ] = {
        [ "note" ] = "69 > 100. Open roll",
        [ "normal" ] = true
      }
    },
    [ 41077 ] = { -- Yshgo'lar, Cowl of Fanatical Devotion
      [ 1 ] = {
        [ "note" ] = "Requires gearcheck ticket",
        [ "hardres" ] = true
      },
      [ 2 ] = {
        [ "note" ] = "Reward item/LC: Item is rewarded based on role contribution during raid. Best tank, Best DPS, Best Healer etc. "
      }
    },
    [ 55554 ] = { -- Carapace Handguards
      [ 1 ] = {
        [ "note" ] = "Requires gearcheck ticket",
        [ "hardres" ] = true
      }
    },
    [ 21839 ] = { -- Scepter of the False Prophet
      [ 1 ] = {
        [ "note" ] = "Healer (1) > Healer with other AQ40 main hand (2) > Everyone else (3)"
      },
      [ 2 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      }
    },
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
    },
    [ 21608 ] = { -- Amulet of Vek'nilash
      [ 1 ] = {
        [ "note" ] = "Caster/Holy Pali (1) > Shadow Priest (2) > Spelladin (3)"
      },
      [ 2 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 21650 ] = { -- Ancient Qiraji Ripper
      [ 1 ] = {
        [ "note" ] = "Sword Rogue (1) > Dps Warrior/Dagger Rogue (2) > Everyone else (3)"
      }
    },
    [ 21837 ] = { -- Anubisath Warhammer
      [ 1 ] = {
        [ "note" ] = "Human/Goblin Warr (1) > Everyone Else (2)"
      }
    },
    [ 21670 ] = { -- Badge of the Swarmguard
      [ 1 ] = {
        [ "note" ] = "Physical DPS (1) > Everyone else (2)"
      }
    },
    [ 21586 ] = { -- Belt of Never-ending Agony
      [ 1 ] = {
        [ "note" ] = "Rogue/Feral Druid/Ench Shaman (1) > Melee DPS/ Hunters (2) > Everyone else (3)"
      },
      [ 2 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 20929 ] = { -- Carapace of the Old God
      [ 1 ] = {
        [ "note" ] = "Tank Warrior/Tank Pali/Resto Shaman (1) > Rogue/Hunter/Ele Shaman/Spellian(2) > DPS Warrior/Ret Pali/Enhance Shaman  (3)"
      }
    },
    [ 21583 ] = { -- Cloak of Clarity
      [ 1 ] = {
        [ "note" ] = "Healer (1) > Everyone else (2)"
      }
    },
    [ 22731 ] = { -- Cloak of the Devoured
      [ 1 ] = {
        [ "note" ] = "Shadow Priest (1) > Caster (2)"
      }
    },
    [ 21126 ] = { -- Death's Sting
      [ 1 ] = {
        [ "note" ] = "Dagger Rogue/Goblin Warr (1) > Dagger Melee/Tank Shaman (2) > Everyone else (3)"
      }
    },
    [ 21221 ] = { -- Eye of C'Thun
      [ 1 ] = {
        [ "note" ] = "Caster/Fury Prot Tank (1) > Healer (2) > Everyone else (3)"
      }
    },
    [ 22730 ] = { -- Eyestalk Waist Cord
      [ 1 ] = {
        [ "note" ] = "Caster (1) > Shadow Priest (2)"
      },
      [ 2 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 21647 ] = { -- Fetish of the Sand Reaver
      [ 1 ] = {
        [ "note" ] = "Big DPS Casters (1) > Big DPS Melee (2) > Everyone else (3)",
        [ "normal" ] = true
      }
    },
    [ 21581 ] = { -- Gauntlets of Annihilation
      [ 1 ] = {
        [ "note" ] = "DPS Warrior/Fury Prot (1) >  AP ret Pali(2) > Everyone Else (3)"
      }
    },
    [ 21605 ] = { -- Gloves of the Hidden Temple
      [ 1 ] = {
        [ "note" ] = "Tank Druid (1) > Melee DPS/ Hunters (2) > Everyone else (3)"
      }
    },
    [ 21618 ] = { -- Hive Defiler Wristguards
      [ 1 ] = {
        [ "note" ] = "Fury Prot (1) > Everyone Else (2)"
      }
    },
    [ 21616 ] = { -- Huhuran's Stinger
      [ 1 ] = {
        [ "note" ] = "Tank Warrior (fury prot) (1) > Physical DPS (2) > Everyone else (3)"
      }
    },
    [ 20933 ] = { -- Husk of the Old God
      [ 1 ] = {
        [ "note" ] = "Caster (1) > Shadow Priest (2)"
      }
    },
    [ 21237 ] = { -- Imperial Qiraji Regalia
      [ 1 ] = {
        [ "note" ] = "Druid Tanks/Resto Druid/Resto Shaman (1) > Everyone else (2)"
      }
    },
    [ 21232 ] = { -- Imperial Qiraji Armaments
      [ 1 ] = {
        [ "note" ] = "Tank [Shield only] (1) > everyone else (2)"
      }
    },
    [ 23570 ] = { -- Jom Gabbar
      [ 1 ] = {
        [ "note" ] = "Hunters/Rogues (1) > Warriors/Other Melee (2) > Everyone else (3)"
      }
    },
    [ 23557 ] = { -- Larvae of the Great Worm
      [ 1 ] = {
        [ "note" ] = "Hunters (1) > Melee DPS (2) > Everyone else (3)"
      }
    },
    [ 22732 ] = { -- Mark of C'Thun
      [ 1 ] = {
        [ "note" ] = "Tank Mit (1) > Other tanks (2) > Everyone else (3)"
      }
    },
    [ 20927 ] = { -- Ouro's Intact Hide
      [ 1 ] = {
        [ "note" ] = "Tank Warrior (1) > DPS Warrior/Rogue/Mage/DPS Priest(2) > Everyone (3)"
      }
    },
    [ 20928 ] = { -- Qiraji Bindings of Command
      [ 1 ] = {
        [ "note" ] = "Tank Warrior (1) > DPS Warrior/Rogue/Hunter/DPS Priest(2) > Everyone else (3)"
      },
      [ 2 ] = {
        [ "note" ] = "T2.5 boots & shoulders"
      }
    },
    [ 20932 ] = {
      -- Qiraji Bindings of Dominance
      [ 1 ] = {
        [ "note" ] = "Warlock/Resto Shaman (1) > Spellian Pali/Ele Shaman/Mage/Boomkin (2) > Ret Pali/Enhanc Shaman (3)"
      },
      [ 2 ] = {
        [ "note" ] = "T2.5 boots & shoulders"
      }
    },
    [ 60003 ] = { -- Remnants of an Old God
      [ 1 ] = {
        [ "note" ] = "Off-race Warr/Combat Rogue (1) > Shaman tank (2)"
      },
      [ 2 ] = {
        [ "note" ] = "Prioritised to Ashkin + CFW wielders by guild rank ",
        [ "normal" ] = true
      }
    },
    [ 21601 ] = { -- Ring of Emperor Vek'lor
      [ 1 ] = {
        [ "note" ] = "Tank Druid (1) >  Other Tanks (2) >  Everyone else (3)"
      }
    },
    [ 21625 ] = { -- Scarab Brooch
      [ 1 ] = {
        [ "note" ] = "Resto Shaman/HT druid (1) > Healers (2) > Everyone else (3)"
      }
    },
    [ 21891 ] = { -- Shard of the Fallen Star
      [ 1 ] = {
        [ "note" ] = "Caster/Tank Pali (1) > everyone else (2)"
      },
      [ 2 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 20931 ] = { -- Skin of the Great Sandworm
      [ 1 ] = {
        [ "note" ] = "Tank Pali/Resto Shaman (1) > Spellian Pali/Warlock/Ele Shaman/Hunter/Boomkin Druid (2) > Ret Pali/Enhanc Shaman (3)"
      }
    },
    [ 20930 ] = { -- Vek'lor's Diadem
      [ 1 ] = {
        [ "note" ] = "Resto Shaman (1) > Ele Shaman/Hunter/Rogue/Boomkin Druid (2) > Ret Pali/Enhanc Shaman (3)"
      }
    },
    [ 20926 ] = { -- Vek'nilash's Circlet
      [ 1 ] = {
        [ "note" ] = "Off-race Warr/Combat Rogue (1) > Shaman tank (2)"
      }
    },
    [ 21579 ] = { -- Vanquished Tentacle of C'Thun
      [ 1 ] = {
        [ "note" ] = "Open /roll",
        [ "normal" ] = true
      }
    },
    [ 21134 ] = { -- Dark Edge of Insanity
      [ 1 ] = {
        [ "note" ] = "/roll 100 for MS, /roll 99 for PVP",
        [ "normal" ] = true
      },
      [ 2 ] = {
        [ "note" ] = "Mainly a PVP item due to disorient effect"
      }
    },
    [ 55556 ] = { -- Spotted Qiraji Battle Tank 
      [ 1 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true,
        [ "hardres" ] = true
      }
    },
    -- Nature Resistance Pieces
    [ 21708 ] = {
      [ 1 ] = {
        [ "note" ] = "NR Roll if interested (/roll 50 for TMOG)",
        [ "normal" ] = true
      }
    },
    [ 21702 ] = {
      [ 1 ] = {
        [ "note" ] = "NR Roll if interested (/roll 50 for TMOG)",
        [ "normal" ] = true
      }
    },
    [ 21696 ] = {
      [ 1 ] = {
        [ "note" ] = "NR Roll if interested (/roll 50 for TMOG)",
        [ "normal" ] = true
      }
    },
    [ 21691 ] = {
      [ 1 ] = {
        [ "note" ] = "NR Roll if interested (/roll 50 for TMOG)",
        [ "normal" ] = true
      }
    },
    [ 21678 ] = {
      [ 1 ] = {
        [ "note" ] = "NR Roll if interested (/roll 50 for TMOG)",
        [ "normal" ] = true
      }
    },
    [ 21652 ] = {
      [ 1 ] = {
        [ "note" ] = "NR Roll if interested (/roll 50 for TMOG)",
        [ "normal" ] = true
      }
    },
    [ 21648 ] = {
      [ 1 ] = {
        [ "note" ] = "NR Roll if interested (/roll 50 for TMOG)",
        [ "normal" ] = true
      }
    },
    -- Shadow Resistance Pieces
    [ 21687 ] = {
      [ 1 ] = {
        [ "note" ] = "Shadow Resistance Tank (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 21627 ] = {
      [ 1 ] = {
        [ "note" ] = "Shadow Resistance Tank (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 21838 ] = {
      [ 1 ] = {
        [ "note" ] = "Shadow Resistance Tank (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    -- Recipes
    [ 20734 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 20735 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 20736 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 20726 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 20727 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 20728 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 20729 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 20730 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 20731 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members/Consistent Pugs (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    }
  }
end

local function molten_core()
  return {
    [ 18815 ] = { -- Essence of the Pure Flame
      [ 1 ] = {
        [ "note" ] = "/roll if you will use it",
        [ "normal" ] = true
      }
    },
    [ 55559 ] = { -- Molten Corehound
      [ 1 ] = {
        [ "note" ] = "Guild Rank Priority",
        [ "normal" ] = true,
        [ "hardres" ] = true
      }
    },
    [ 17063 ] = { -- Band of Accuria
      [ 1 ] = {
        [ "note" ] = "Can only be SRed by Melee MS",
        [ "softres" ] = true
      },
      [ 2 ] = {
        [ "note" ] = "Guild Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 17782 ] = { -- Talisman of Binding Shard
      [ 1 ] = {
        [ "note" ] = "Used to be rolled off between the tanks in the raid (NA)"
      },
      [ 2 ] = {
        [ "note" ] = "Guild Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 17204 ] = { -- Eye of Sulfuras
      [ 1 ] = {
        [ "note" ] = "Guild Rank Priority",
        [ "normal" ] = true
      }
    },
    -- Profession items
    [ 18259 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 18260 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 21371 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 18265 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 18264 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 18252 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 18257 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 18292 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    },
    [ 18291 ] = {
      [ 1 ] = {
        [ "note" ] = "Guild Members (1) > Everyone else (2)",
        [ "normal" ] = true
      }
    }
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
    [ 55557 ] = { -- Black Drake
      [ 1 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true,
        [ "hardres" ] = true,
      }
    },
    [ 19387 ] = { -- Chromatic Boots
      [ 1 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 19431 ] = { -- Styleen's Impending Scarab
      [ 1 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 19382 ] = { -- Pure Elementium Band
      [ 1 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      }
    },
    [ 19377 ] = { -- Prestor's Talisman of Connivery
      [ 1 ] = {
        [ "note" ] = "<Murder Mittens> Rank Priority",
        [ "normal" ] = true
      },
      [ 2 ] = {
        [ "note" ] = "Rogues = Hunters = Feral DPS > Melee DPS",
      }
    },
    [ 19002 ] = { -- Horde Head
      [ 1 ] = {
        [ "note" ] = "Horde Head",
      }
    },
    [ 19003 ] = { -- Alliance Head
      [ 1 ] = {
        [ "note" ] = "Alliance Head",
      }
    },
    -- Internal priorities stolen from Puglords
    [ 19438 ] = { -- Ringo's Blizzard Boots
      [ 1 ] = {
        [ "note" ] = "Frost Mage > Caster DPS",
      }
    },
    [ 19370 ] = { -- Mantle of the Blakcwing Cabal
      [ 1 ] = {
        [ "note" ] = "SPriest > Caster DPS",
      }
    },
    [ 19334 ] = { -- The Untamed Blade
      [ 1 ] = {
        [ "note" ] = "Ret Paladin > 2H Fury Warrior > Rest"
      }
    },
    [ 19340 ] = { -- Rune of Metamorphosis
      [ 1 ] = {
        [ "note" ] = "Feral Druid > Resto Druid"
      }
    },
    [ 19350 ] = { -- Heartstriker
      [ 1 ] = {
        [ "note" ] = "Melee DPS = Hunter"
      }
    },
    [ 19351 ] = { -- Maladath
      [ 1 ] = {
        [ "note" ] = "Melee DPS = Tanks",
      }
    },
    [ 19343 ] = { -- Scrolls of Blinding Light
      [ 1 ] = {
        [ "note" ] = "Ret Paladin > Holy Paladin"
      }
    },
    [ 19360 ] = { -- Lok'Amir
      [ 1 ] = {
        [ "note" ] = "SPriest = RDruid = Boom = HPally = Prot Pally = Ele = RShaman",
      }
    },
    [ 19364 ] = { -- Ashkandi
      [ 1 ] = {
        [ "note" ] = "2H Ret Paladin = 2H Human Warrior = Hunters",
      }
    },
    [ 19378 ] = { -- Cloak of the Brood Lord
      [ 1 ] = {
        [ "note" ] = "Caster DPS = Ret?/prot Paladin",
      }
    },
    [ 19380 ] = { -- Therazane's Link
      [ 1 ] = {
        [ "note" ] = "Ret Paladin = Enh Shaman > Melee DPS",
      }
    },
    [ 19381 ] = { -- Boots of the Shadow Flame
      [ 1 ] = {
        [ "note" ] = "Bear Druid > Enh Shaman > Melee DPS",
      }
    },
    [ 19376 ] = { -- Archimtiros' Ring of Reckoning
      [ 1 ] = {
        [ "note" ] = "Feral Druid > Prot War = Shaman = Protadin",
      }
    },
  };
end

local function add_mm_rank_prio(loot, id)
  if loot[id] == nil then loot[id] = {} end
  table.insert(loot[id], { [ "note" ] = "Guild Rank Priority", [ "normal" ] = true })
end

local function naxxramas()
  local loot = {
    [ 22954 ] = { -- Kiss of the spider
      [ 1 ] = {
        [ "note" ] = "Loot Counciled",
        [ "hardres" ] = true
      }
    }
  }

  -- Rime Covered Mantle
  add_mm_rank_prio(loot, 22983)
  -- Plated Abomination Ribcage
  add_mm_rank_prio(loot, 23000)
  -- Leggings of Polarity
  add_mm_rank_prio(loot, 23070)
  -- Legplates of Carnage
  add_mm_rank_prio(loot, 23068)
  -- Wraith Blade
  add_mm_rank_prio(loot, 22807)

  return loot
end

local function upper_necropolis()
  local loot = {}

  -- Sapphiron Loot
  add_mm_rank_prio(loot, 23040)
  add_mm_rank_prio(loot, 23041)
  add_mm_rank_prio(loot, 23043)
  add_mm_rank_prio(loot, 23045)
  add_mm_rank_prio(loot, 23046)
  add_mm_rank_prio(loot, 23047)
  add_mm_rank_prio(loot, 23048)
  add_mm_rank_prio(loot, 23049)
  add_mm_rank_prio(loot, 23050)
  add_mm_rank_prio(loot, 23242)
  -- Kel'Thuzad Loot
  add_mm_rank_prio(loot, 22798)
  add_mm_rank_prio(loot, 22799)
  add_mm_rank_prio(loot, 22802)
  add_mm_rank_prio(loot, 22812)
  add_mm_rank_prio(loot, 22819)
  add_mm_rank_prio(loot, 22821)
  add_mm_rank_prio(loot, 23053)
  add_mm_rank_prio(loot, 23054)
  add_mm_rank_prio(loot, 23056)
  add_mm_rank_prio(loot, 23057)
  add_mm_rank_prio(loot, 23577)

  return loot
end

M[ "Ahn'Qiraj" ] = ahn_qiraj()
M[ "Blackwing Lair" ] = blackwing_lair()
M[ "Molten Core" ] = molten_core()
M[ "Naxxramas" ] = naxxramas()
M[ "The Upper Necropolis" ] = upper_necropolis()

m.ItemNotesDB[ NOTES_NAME ] = M
return M;
