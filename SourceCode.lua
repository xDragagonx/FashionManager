local wtMainPanel = mainForm:GetChildChecked("MainPanel", false)
local wtScrollbar = wtMainPanel:GetChildChecked("Scrollbar", false)

local wtListEntry = mainForm:GetChildChecked("ListEntry", false)


local wtBtnAddSet = wtMainPanel:GetChildChecked("BtnAddSet", false)
wtBtnAddSet:SetVal("button_label", userMods.ToWString("Add preset"))

local wtCallButton = mainForm:GetChildChecked("BtnCall", false)
wtCallButton:SetVal("button_label", userMods.ToWString("FM"))

local wtMsgBox = wtMainPanel:GetChildChecked("MsgBox",false)
local wtWindowHeader = wtMainPanel:GetChildChecked("WindowHeader", false)
--CHILDREN OF WINDOWHEADER
local wtHeaderText = wtWindowHeader:GetChildChecked("HeaderText", false)
wtHeaderText:SetVal("window_header", "Fashion Manager")
--CHILDREN OF LISTENTRY
local wtListEntryContentFrame = wtListEntry:GetChildChecked("ListEntryContentFrame", false)
--CHILDREN OF LISTENTRYCONTENTFRAME
local wtListEntryTxt = wtListEntryContentFrame:GetChildChecked("ListEntryTxt", false)
--CHILDREN OF MSGBOX
local wtEditLineInputTxt = wtMsgBox:GetChildChecked("EditLineInputTxt", false)

--UNSCOPED VARIABLE
local FashionManagerIsOpen = false
wtMainPanel:Show(FashionManagerIsOpen)

function Main()
	wtListEntry:Show(false)
	--GetEquippedItemIds()
	--GetCategories()
	--GetCurrentTransmogSet()
	
	common.RegisterReactionHandler( BtnCallClick, "BtnCallClick" )
	DnD.Init(wtCallButton, nil, true)
end
function BtnCallClick()
	if DnD:IsDragging() then return	end
	if FashionManagerIsOpen == true then
		FashionManagerIsOpen = false
		wtMainPanel:Show(FashionManagerIsOpen)
		
		common.UnRegisterReactionHandler( BtnAddSetClick, "BtnAddSetClick" )
		common.UnRegisterReactionHandler( EditLineInputTxtReactionEnter, "EditLineInputTxtReactionEnter" )
	elseif FashionManagerIsOpen == false then
		FashionManagerIsOpen = true
		wtMainPanel:Show(FashionManagerIsOpen)
		
		common.RegisterReactionHandler( BtnAddSetClick, "BtnAddSetClick" )
		common.RegisterReactionHandler( EditLineInputTxtReactionEnter, "EditLineInputTxtReactionEnter" )
		
		
		
	end
end

function EditLineInputTxtReactionEnter()
	local inputTxt = wtEditLineInputTxt:GetText()
	if inputTxt:IsEmpty() then
		inputTxt = userMods.ToWString("No name given")
	end
	CreateNewEntry(inputTxt)
end
function BtnAddSetClick()
	local inputTxt = wtEditLineInputTxt:GetText()
	if inputTxt:IsEmpty() then
		inputTxt = userMods.ToWString("No name given")
	end
	CreateNewEntry(inputTxt)
end
function CreateNewEntry(inputTxt)
	chat(2, "Input text: "..inputTxt)
	wtListEntryTxt:SetVal("value", inputTxt)
	local wtListEntryDesc = wtListEntry:GetWidgetDesc()
	--STOPPED HERE
	local wtNewListEntry = mainForm:CreateWidgetByDesc(wtListEntryDesc) --https://alloder.pro/md/LuaApi/FunctionFormCreateWidgetByDesc.html
	local wtListEntryDescTxt = mainForm:GetChildChecked("wtNewListEntry", true)
	wtScrollbar:PushBack(wtNewListEntry)

	local maxOffset = wtScrollbar:GetMaxContainerOffset() --https://alloder.pro/md/LuaApi/FunctionScrollableContainerGetMaxContainerOffset.html
	chat(2, "Max offset:",maxOffset)

	local count = wtScrollbar:GetElementCount() --https://alloder.pro/md/LuaApi/FunctionScrollableContainerGetElementCount.html
	chat(2, "Elements in Scrollbar:", count)

	wtScrollbar:EnsureVisible( wtNewListEntry ) --https://alloder.pro/md/LuaApi/FunctionScrollableContainerEnsureVisible.html
end
function GetCurrentTransmogSet()
	local equippedSet = {}
	local avatarId = avatar.GetId()
	local EquippedItemIds = unit.GetEquipmentItemIds( avatarId, ITEM_CONT_EQUIPMENT )
	local itemIdHead = EquippedItemIds[ DRESS_SLOT_LIFESTYLEHEAD ]
	local itemIdCape = EquippedItemIds[ DRESS_SLOT_LIFESTYLEBACK ]
	local itemIdChest = EquippedItemIds[ DRESS_SLOT_LIFESTYLESUIT ]
	local itemIdUnderwear = EquippedItemIds[ DRESS_SLOT_LIFESTYLEUNDERWEAR ]
	local itemIdShoulder = EquippedItemIds[ DRESS_SLOT_LIFESTYLESHOULDER ]
	local itemIdPet = EquippedItemIds[ DRESS_SLOT_LIFESTYLEPET ]
	local itemIdWeaponskin = EquippedItemIds[ DRESS_SLOT_POWEREDLSWEAPON ]
	
	table.insert(equippedSet, {name = itemLib.GetName(itemIdHead), id = itemIdHead})
	table.insert(equippedSet, {name = itemLib.GetName(itemIdCape), id = itemIdCape})
	table.insert(equippedSet, {name = itemLib.GetName(itemIdChest), id = itemIdChest})
	table.insert(equippedSet, {name = itemLib.GetName(itemIdUnderwear), id = itemIdUnderwear})
	table.insert(equippedSet, {name = itemLib.GetName(itemIdShoulder), id = itemIdShoulder})
	table.insert(equippedSet, {name = itemLib.GetName(itemIdPet), id = itemIdPet})
	table.insert(equippedSet, {name = itemLib.GetName(itemIdWeaponskin), id = itemIdWeaponskin})
	chat(2, equippedSet)

	userMods.SetAvatarConfigSection( "equippedTransmogSet", equippedSet ) --Saves the set to the config. https://alloder.pro/md/LuaApi/FunctionUserModsSetAvatarConfigSection.html
	--get avatar config https://alloder.pro/md/LuaApi/FunctionUserModsGetAvatarConfigSection.html

end
function GetEquippedItemIds()
	-- DRESS_SLOT_LIFESTYLEHEAD
	-- DRESS_SLOT_LIFESTYLEBACK
	-- DRESS_SLOT_LIFESTYLESUIT
	-- DRESS_SLOT_LIFESTYLEUNDERWEAR
	-- DRESS_SLOT_LIFESTYLESHOULDER
	-- DRESS_SLOT_LIFESTYLEPET
	-- DRESS_SLOT_POWEREDLSWEAPON

	local EquippedItemIds = unit.GetEquipmentItemIds( avatar.GetId(), ITEM_CONT_EQUIPMENT )
	chat(2, EquippedItemIds)
	local itemId = EquippedItemIds[ DRESS_SLOT_LIFESTYLEHEAD ]
	--chat(2, itemId)
	chat(2, itemLib.GetName(itemId))
end
function GetItemIdName(itemId) -- https://alloder.pro/md/LuaApi/FunctionItemLibGetName.html
	local itemName = itemLib.GetName(itemId)
	chat(2, itemLib.GetName(itemId))
end
function WardRobe_Close() --Closes the Wardrobe. https://alloder.pro/md/LuaApi/FunctionCheckroomLibClose.html
	checkroomLib.Close()
end
function WardRobe_Open() --Closes the Wardrobe. https://alloder.pro/md/LuaApi/FunctionCheckroomLibOpen.html
	checkroomLib.Open()
end
function IsTheWardrobeOpen() --Checks if the Wardrobe is opened. returns true/false https://alloder.pro/md/LuaApi/FunctionCheckroomLibIsOpened.html
	checkroomLib.IsOpened()
	chat(2, checkroomLib.IsOpened())
end
function EquipItem(itemId) --Equips the item. https://alloder.pro/md/LuaApi/FunctionCheckroomLibEquipItem.html
	checkroomLib.EquipItem( itemId )
end
function EquipItems(headItemId, shoulderItemId) --Equips the items, up to 6 at a time. https://alloder.pro/md/LuaApi/FunctionCheckroomLibEquipItems.html
	checkroomLib.EquipItems( {headItemId, shoulderItemId} )
end
function RemoveItem(itemId)
	checkroomLib.UnequipItem( itemId )
end
function GetCategories() --Gets category information. https://alloder.pro/md/LuaApi/FunctionCheckroomLibGetCategories.html
	local categories = checkroomLib.GetCategories()
	for i=1, GetTableSize(categories) do 
		chat(2, i, "Category:", categories[ i ]:GetInfo().name )
		GetSubCategories(categories, i)
	end
end
function GetSubCategories(categories, i) --Gets the sub-category information. https://alloder.pro/md/LuaApi/FunctionCheckroomLibGetCollections.html
	local subCategories = checkroomLib.GetSubCategories( categories[ i ] )
	chat(2, subCategories)
	for i=1, GetTableSize(subCategories) do
		chat(2, i, "Collections:", subCategories[i]:GetInfo().name)
	end
end
function GetItemCategoryLocation(itemId) --Gets an items location in the wardrobe. https://alloder.pro/md/LuaApi/FunctionCheckroomLibGetItemCategories.html
	local itemCategories = checkroomLib.GetItemCategories( itemId )
	if itemCategories then
	  chat(2, itemCategories.categoryId:GetInfo().name )
	end
end
function GetItemIds() --Gets the Id of an item in the wardrobe https://alloder.pro/md/LuaApi/FunctionCheckroomLibGetItems.html
	local categories = checkroomLib.GetCategories()
	local collections = checkroomLib.GetCollections( categories[ 1 ] )
	local items = checkroomLib.GetItems( collections[ 1 ] )
	local itemInfo = itemLib.GetItemInfo( items[ 1 ] )
	chat(2, itemInfo)
end
function GetSortedItemsInfo()--Gets the information of an item in the wardrobe https://alloder.pro/md/LuaApi/FunctionCheckroomLibGetSortedItemsInfo.html
	local categories = checkroomLib.GetCategories()
	local collections = checkroomLib.GetCollections( categories[ 1 ] )
	local items = checkroomLib.GetSortedItemsInfo( collections[ 1 ] )
	chat(2, items)
	--local name = items[ 1 ].name
end
function GetSpellsInfo() --UNTESTED https://alloder.pro/md/LuaApi/FunctionCheckroomLibGetSpells.html, https://alloder.pro/md/LuaApi/FunctionCheckroomLibIsHideSpellWhileNotLearned.html
	local categories = checkroomLib.GetCategories()
	local collections = checkroomLib.GetCollections( categories[ 1 ] )
	local spells = checkroomLib.GetSpells( collections[ 2 ] )
	chat(2, spells)
	--local spellState = spellLib.GetState( spells[ 1 ] )
	--local isSpellLearned = avatar.HasSpell( spells[ 1 ] )
	--local isHideSpellInCollection = not isSpellLearned and checkroomLib.IsHideSpellWhileNotLearned( spells[ 1 ] )
end
function IsItAWardrobeItem(itemId) --https://alloder.pro/md/LuaApi/FunctionCheckroomLibIsCheckRoomItem.html
	local isCheckRoomItem = checkroomLib.IsCheckRoomItem( itemId )
end
function IsItemAlreadyEquipped(itemId) --Checks if an item is equipped, returns true/false https://alloder.pro/md/LuaApi/FunctionCheckroomLibIsItemEquipped.html
	local isItemEquipped = checkroomLib.IsItemEquipped( itemId )
end
function AreItemsAlreadyEquipped(itemIds) --Checks if items are equipped, returns true/false https://alloder.pro/md/LuaApi/FunctionCheckroomLibIsItemsInCheckroom.html
	local isItemsEquipped = checkroomLib.IsItemsEquipped( itemIds ) --Checks if items are equipped, returns true/false https://alloder.pro/md/LuaApi/FunctionCheckroomLibIsItemsEquipped.html
end
function IsItemInWardrobe(itemId) --Checks if item is in wardrobe, returns true/false https://alloder.pro/md/LuaApi/FunctionCheckroomLibIsItemInCheckRoom.html
	local isItemInCheckroom = checkroomLib.IsItemInCheckroom( itemId )
end
function AreItemsInWardrobe(itemIds)
	local isItemsInCheckroom = checkroomLib.IsItemsInCheckroom( itemIds )
end


if (avatar.IsExist()) then
	chat(2,"Loaded.")
	Main()
else
	chat(2,"Loaded.")
	common.RegisterEventHandler(Main, "EVENT_AVATAR_CREATED")
end
