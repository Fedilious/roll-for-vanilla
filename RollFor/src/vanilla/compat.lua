RollFor = RollFor or {}
local M = RollFor

M.vanilla = true

M.getn = table.getn ---@diagnostic disable-line: deprecated
M.mod = math.mod ---@diagnostic disable-line: undefined-field

---@param item_link string
function M.link_item_in_chat( item_link )
  if M.api.ChatEdit_InsertLink then
    M.api.ChatEdit_InsertLink( item_link )
  elseif M.api.ChatFrameEditBox:IsVisible() then
    M.api.ChatFrameEditBox:Insert( item_link )
  end
end

---@param slash_command RollSlashCommand
---@param item_link string
function M.slash_command_in_chat( slash_command, item_link )
  M.api.ChatFrameEditBox:Show()
  M.api.ChatFrameEditBox:SetText( string.format( "%s %s ", slash_command, item_link ) )
  M.api.ChatFrameEditBox:SetFocus()
end

---@param api table
---@param item_id ItemId
---@return ItemTexture
function M.get_item_texture( api, item_id )
  local _, _, _, _, _, _, _, _, texture = api.GetItemInfo( item_id )
  return texture
end

---@param api table
---@param item_id ItemId
---@return ItemQuality
---@return ItemTexture
function M.get_item_quality_and_texture( api, item_id )
  local _, _, quality, _, _, _, _, _, texture = api.GetItemInfo( item_id )
  return quality, texture
end

---@param api CreateFrameApi
---@param parent Frame
function M.create_loot_button( api, parent )
  return api.CreateFrame( "LootButton", nil, parent )
end

---@param api CreateFrameApi
---@param type string
---@param name string
---@param parent Frame
function M.create_backdrop_frame( api, type, name, parent )
  return api.CreateFrame( type, name, parent )
end

---@param api table
---@param unit_type string
---@return string
function M.UnitGUID( api, unit_type )
  return api.UnitName( unit_type )
end

---@param api table
---@param prefix string
---@param message string
---@param channel string
function M.SendAddonMessage( api, prefix, message, channel )
  api.SendAddonMessage( prefix, message, channel )
end

---@param api table
---@param chat Chat
---@param f function
function M.in_group_check( api, chat, f )
  ---@diagnostic disable-next-line: unused-vararg
  return function( ... )
    if not api.IsInGroup() then
      chat.info( "Not in a group." )
      return
    end

    f( unpack( arg ) )
  end
end
