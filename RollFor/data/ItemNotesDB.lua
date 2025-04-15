RollFor = RollFor or {}
local m = RollFor

if m.ItemNotesDB then return end

local M = {}

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
    [ 55555 ] = { -- Ivonor, Maiden's Mallet
      [ 1 ] = {
        [ "note" ] = "Requires gearcheck ticket",
        [ "hardres" ] = true
      }
    },
    [ 21839 ] = { -- Scepter of the False Prophet
      [ 1 ] = {
        [ "note" ] = "Requires gearcheck ticket",
        [ "hardres" ] = true
      },
      [ 2 ] = {
        [ "note" ] = "Healer (1) > Healer with other AQ40 main hand (2) > Everyone else (3)"
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
        [ "note" ] = "Prioritised to GUILDIES!",
        [ "normal" ] = true,
        [ "softres" ] = true
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
    [ 19395 ] = { -- Rejuvenating Gem
      [ 1 ] = {
        [ "note" ] = "Reserved for raiders with 3+ weeks of attendance",
        [ "normal" ] = true,
        [ "softres" ] = true
      }
    },
    [ 19406 ] = { -- Drake Fang Talisman
      [ 1 ] = {
        [ "note" ] = "Reserved for raiders with 3+ weeks of attendance",
        [ "normal" ] = true,
        [ "softres" ] = true
      }
    },
    [ 19379 ] = { -- Neltharion's Tear
      [ 1 ] = {
        [ "note" ] = "Reserved for raiders with 7+ weeks of attendance",
        [ "normal" ] = true,
        [ "softres" ] = true
      }
    },
    [ 55557 ] = { -- Black Drake
      [ 1 ] = {
        [ "note" ] = "Prioritised to members of <Murder Mittens>",
        [ "normal" ] = true,
        [ "softres" ] = true
      }
    },
    [ 19002 ] = { -- Rejuvenating Gem
      [ 1 ] = {
        [ "note" ] = "Horde Head",
      }
    },
    [ 19003 ] = { -- Rejuvenating Gem
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
    [ 19377 ] = { -- Prestor's Talisman of Connivery
      [ 1 ] = {
        [ "note" ] = "Rogues = Hunters = Feral DPS > Melee DPS",
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

M[ "Ahn'Qiraj" ] = ahn_qiraj()
M[ "Blackwing Lair" ] = blackwing_lair()
M[ "Molten Core" ] = molten_core()

m.ItemNotesDB = M
return M;
