RollFor = RollFor or {}
local m = RollFor

if m.TooltipReader then return end

local item_utils = m.ItemUtils
local green = m.colors.green
local red = m.colors.red

local M = {}
local _G = getfenv( 0 )

local function create_tooltip_frame()
  local frame = m.api.CreateFrame( "GameTooltip", "RollForTooltipFrame", nil, "GameTooltipTemplate" )
  frame:SetOwner( WorldFrame, "ANCHOR_NONE" );

  return frame
end

---@class TooltipReader
---@field m_frame Frame
---@field get_slot_bind_type fun( number? ): ItemUtils.BindType
function M.new( )
    local m_frame

    local function ensure_frame()
        if m_frame then return end
        m_frame = create_tooltip_frame()
    end

    ---@param slot number?
    local function set_loot_slot( slot )
        ensure_frame()

        m_frame:ClearLines()
        m_frame:SetLootItem( slot )
    end

    local function get_item_type_from_tooltip()
        if m_frame:NumLines() < 1 then
            -- Probably the slot is invalid
            return
        elseif m_frame:NumLines() < 2 then
            -- Items without a specification are assumed to be BoE
            return item_utils.BindType.BindOnEquip
        end

        local line = _G["RollForTooltipFrameTextLeft2"]:GetText()

        if line == ITEM_BIND_ON_PICKUP or line == ITEM_SOULBOUND then
            return item_utils.BindType.BindOnPickup
        elseif line == ITEM_BIND_QUEST then
            return item_utils.BindType.Quest
        else
            return item_utils.BindType.BindOnEquip
        end
    end

    local function get_slot_bind_type( slot )
        set_loot_slot( slot )

        return get_item_type_from_tooltip()
    end

    return {
        get_slot_bind_type = get_slot_bind_type
    }
end

m.TooltipReader = M
return M