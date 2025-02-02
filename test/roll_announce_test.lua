package.path = "./?.lua;" .. package.path .. ";../?.lua;../RollFor/?.lua;../RollFor/libs/?.lua"

local lu = require( "luaunit" )
local utils = require( "test/utils" )
local player = utils.player
local leader = utils.raid_leader
local is_in_raid = utils.is_in_raid
local c = utils.console_message
local r = utils.raid_message
local cr = utils.console_and_raid_message
local rw = utils.raid_warning
local rolling_finished = utils.rolling_finished
local roll_for = utils.roll_for
local roll = utils.roll
local roll_os = utils.roll_os
local assert_messages = utils.assert_messages
local tick = utils.repeating_tick
local item_note = utils.add_item_note
local soft_res = utils.soft_res
local sr = utils.soft_res_item
local hr = utils.hard_res_item

RollAnnounceSpec = {}

function RollAnnounceSpec:should_show_default_announcement_without_notes()
  -- Given
  player( "Psikutas" )
  is_in_raid( leader( "Psikutas" ), "Obszczymucha" )

  -- When
  roll_for( "Hearthstone" )

  -- Then
  assert_messages(
    rw( "Roll for [Hearthstone]: /roll (MS) or /roll 99 (OS) or /roll 98 (TMOG)" )
  )
end

function RollAnnounceSpec:should_show_notes_on_non_softres()
  -- Given
  player( "Psikutas" )
  is_in_raid( leader( "Psikutas" ), "Obszczymucha" )
  item_note(123, { note = "Note 1", normal = true })

  -- When
  roll_for( "Hearthstone", 1, 123 )

  -- Then
  assert_messages(
    rw( "Roll for [Hearthstone]: Note 1" )
  )
end

function RollAnnounceSpec:should_show_multiple_notes_on_non_softres()
  -- Given
  player( "Psikutas" )
  is_in_raid( leader( "Psikutas" ), "Obszczymucha" )
  item_note(123, { note = "Note 1", normal = true })
  item_note(123, { note = "Note 2", normal = true })

  -- When
  roll_for( "Hearthstone", 1, 123 )

  -- Then
  assert_messages(
    rw( "Roll for [Hearthstone]: Note 1, Note 2" )
  )
end

function RollAnnounceSpec:should_show_notes_on_single_softres()
  -- Given
  player( "Psikutas" )
  is_in_raid( leader( "Psikutas" ), "Obszczymucha" )
  item_note( 123, { note = "Normal Roll Note", normal = true } )
  item_note( 123, { note = "SR Roll Note", softres = true } )
  soft_res( sr( "Obszczymucha", 123 ) )

  -- When
  roll_for( "Hearthstone", 1, 123 )

  -- Then
  assert_messages(
    rw( "Obszczymucha soft-ressed [Hearthstone]." ),
    rw( "SR Roll Note" ),
    c( "RollFor[ Tip ]: Use /arf [Hearthstone] to roll the item and ignore the softres." )
  )
end

function RollAnnounceSpec:should_show_notes_on_multiple_softres()
  -- Given
  player( "Psikutas" )
  is_in_raid( leader( "Psikutas" ), "Obszczymucha" )
  item_note( 123, { note = "Normal Roll Note", normal = true } )
  item_note( 123, { note = "SR Roll Note", softres = true } )
  soft_res( sr( "Psikutas", 123 ), sr( "Obszczymucha", 123 ) )

  -- When
  roll_for( "Hearthstone", 1, 123 )

  -- Then
  assert_messages(
    rw( "Roll for [Hearthstone]: SR Roll Note (SR by Obszczymucha and Psikutas)" )
  )
end

function RollAnnounceSpec:should_show_notes_on_hardres()
  -- Given
  player( "Psikutas" )
  is_in_raid( leader( "Psikutas" ), "Obszczymucha" )
  item_note( 123, { note = "Reserved for the guild", hardres = true } )
  soft_res( hr( 123 ) )

  -- When
  roll_for( "Hearthstone", 1, 123 )

  -- Then
  assert_messages(
    rw( "[Hearthstone] is hard-ressed: Reserved for the guild." )
  )
end

function RollAnnounceSpec:should_show_complicated_note_combinations()
  -- Given
  player( "Psikutas" )
  is_in_raid( leader( "Psikutas" ), "Obszczymucha" )
  item_note( 123, { note = "Tank Prio", normal = true } )
  item_note( 123, { note = "Guild Rank Prio", softres = true } )
  item_note( 123, { note = "Very good item", normal = true, hardres = true, softres = true } )
  item_note( 123, { note = "3 in the guild" } )
  item_note( 123, { note = "Congratulations to the winner", hardres = true, softres = true } )
  soft_res( sr( "Psikutas", 123 ) )

  -- When
  roll_for( "Hearthstone", 1, 123 )

  -- Then
  assert_messages(
    rw( "Psikutas soft-ressed [Hearthstone]." ),
    rw( "Guild Rank Prio, Very good item, Congratulations to the winner" ),
    c( "RollFor[ Tip ]: Use /arf [Hearthstone] to roll the item and ignore the softres." )
  )
end

utils.mock_libraries()
utils.load_real_stuff()

os.exit( lu.LuaUnit.run() )
