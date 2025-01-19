RollFor = RollFor or {}
local m = RollFor

if m.TooltipReader then return end

local M = {}

local pretty_print = m.pretty_print
local hl = m.colors.hl
local RollSlashCommand = m.Types.RollSlashCommand

local function create_tooltip_frame()
  local frame = m.api.CreateFrame( "GameTooltip", "RollForTooltipFrame", nil, "GameTooltipTemplate" )
  frame:SetOwner( WorldFrame, "ANCHOR_NONE" );

  return frame
end

function M.new( )
  local m_frame

  local function create()
    if m_frame then return end
    m_frame = create_tooltip_frame()
  end

  local function is_bop( slot )
    create()

    m_frame:ClearLines()
    m_frame:SetLootItem( slot )

    if m_frame:NumLines() < 2 then
      return false
    end
    local line = getglobal("RollForTooltipFrameTextLeft2"):GetText()

    return line == ITEM_BIND_QUEST or line == ITEM_BIND_ON_PICKUP
  end

  return {
    is_bop = is_bop
  }
end

m.TooltipReader = M
return M
