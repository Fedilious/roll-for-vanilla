RollFor = RollFor or {}
local m = RollFor

if m.TooltipReader then return end

local green = m.colors.green
local red = m.colors.red

local M = {}

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

  local function short_description( slot )
    create()

    m_frame:ClearLines()
    m_frame:SetLootItem( slot )

    if m_frame:NumLines() < 2 then
      return green( "BoE" )
    end

    -- Color BOP as red and BoE as green
    local line = getglobal("RollForTooltipFrameTextLeft2"):GetText()

    if line == ITEM_BIND_ON_PICKUP or line == ITEM_SOULBOUND or line == ITEM_BIND_ON_USE then
      return red( "Bind on Pickup" )
    elseif line == ITEM_BIND_QUEST then
      return red( "Quest Item" )
    else
      return green( "BoE" )
    end
  end

  return {
    is_bop = is_bop,
    short_description = short_description
  }
end

m.TooltipReader = M
return M
