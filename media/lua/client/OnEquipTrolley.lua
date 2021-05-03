
--TODO
-- Если человек падает выпадает две тележки
-- Если взять тележку и попробовать поднять труп - ошибка
-- При повторном нажатии "Взять в обе руки" тележка выбрасывается.

-- this.actionContext.reportEvent("EventClimbFence");


-- function onEquipTrolley( _player, _item)
		-- print(_item)
    -- if _player == getPlayer() and instanceof(_item, "HandWeapon") then
        -- print(_item:getScriptItem():getName())
		-- if _item:getScriptItem():getName() == "Trolley" then
			-- _player:setVariable("Weapon", "trolley")
			 -- print("OK")
		-- end
    -- end
-- end

function onEquipTrolleyTick()
    local playersSum = getNumActivePlayers()
	for playerNum = 0, playersSum - 1 do
		local playerObj = getSpecificPlayer(playerNum)
		if playerObj then
			if playerObj:getVariableString("Weapon") ~= "trolley" then
				local _item = playerObj:getPrimaryHandItem()
				local _item2 = playerObj:getSecondaryHandItem()
				if _item and _item:getScriptItem():getName() == "Trolley" then
					playerObj:setVariable("Weapon", "trolley")
					local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
					-- playerObj:setPrimaryHandItem(trolWeapon);
					-- playerObj:setSecondaryHandItem(trolWeapon);
					print("OK")
				elseif _item and _item:getScriptItem():getName() == "Trolley" then
					playerObj:setVariable("Weapon", "trolley")
				elseif _item2 and _item2:getScriptItem():getName() == "Trolley" then
					playerObj:setVariable("Weapon", "trolley")
					local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
					-- playerObj:setPrimaryHandItem(trolWeapon);
					-- playerObj:setSecondaryHandItem(trolWeapon);
					print("OK")
				elseif _item2 and _item2:getScriptItem():getName() == "TrolleyContainer" then
					local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
					playerObj:setPrimaryHandItem(trolWeapon);
					-- playerObj:setSecondaryHandItem(trolWeapon);
				end
			else
				if playerObj:getCurrentState() == ClimbOverFenceState.instance() then
					sqr = playerObj:getSquare()
					playerObj:setPrimaryHandItem(nil);
					trol = playerObj:getSecondaryHandItem()
					playerObj:setSecondaryHandItem(nil);
					playerObj:getInventory():DoRemoveItem(trol)
					sqr:AddWorldInventoryItem(trol, 0, 0, 0);
				end
			end
			
		end
		-- print(playerObj:getCurrentState())
		
		-- print(playerObj:getVariable("ClimbingFence"))
		-- -- print(getmetatable(playerObj:getVariable("ClimbingFence")))
		-- if playerObj:getVariable("ClimbingFence") then
			-- print(getmetatable(playerObj:getVariable("ClimbingFence")))
			-- playerObj:setVariable("ClimbingFence", nil)
		-- end
		-- print(type(playerObj:getVariable("ClimbingFence")))
		-- print(getmetatable(playerObj:getVariable("ClimbingFence")))
		-- for i, j in pairs(playerObj:getVariable("ClimbingFence")) do print(j) end
    end
end

function trolleyContext (player, context, items) 
	playerObj = getSpecificPlayer(player)
	local option = context:addOption(getText("ContextMenu_Equip"), items, onWearTrolley, playerObj);
	local items = ISInventoryPane.getActualItems(items)
	print(items)
	for i,item in pairs(items) do
		if item:getScriptItem():getName() == "Trolley" then
			context:removeOption(context:getOptionFromName(getText("ContextMenu_Equip_Two_Hands")))
			context:removeOption(context:getOptionFromName(getText("ContextMenu_Unequip")))
		end
	end
	-- 
end

trol = nil

function onWearTrolley (items, playerObj)
	-- items = ISInventoryPane.getActualItems(items)
	local items = ISInventoryPane.getActualItems(items)
	for i,item in pairs(items) do
		-- container = ItemContainer.new()
		-- container:setParent(item)
		trol = item
		print("Category: ", item:getCategory())
		print("Type: ", item:getType())
		print("ID: ", item:getID())
		print("Container: ", item:getContainer())
		print("Container2: ", item:getRightClickContainer())
		-- print(item:getContainer():getContainerY())
		print(getPlayer():getInventory())
		getPlayer():addSecondaryContainer(item:getRightClickContainer())
		print(getPlayer():getContainerCount())
		-- item
		-- print(items[1]:canBeEquipped())
		-- print(item:canBeEquipped())
		-- print(item:getType())
		-- if items[1]:canBeEquipped() == "Trolley" then
			-- playerObj:getBodyLocationGroup():getOrCreateLocation("Trolley");
			-- playerObj:setWornItem(item:canBeEquipped(), item);
			-- getPlayerInventory(playerObj:getPlayerNum()):refreshBackpacks();
			-- print("2123")
			-- -- 
			-- -- ISTimedActionQueue.add(ISWearClothing:new(playerObj, items[0], 50));
		-- end
	end
	
end

-- function TrolleyOnEquipPrimary(playerObj)
	-- print("1. TrolleyOnEquipPrimary")
	-- print(playerObj)
	-- local item = playerObj:getSecondaryHandItem()
	-- if item:getScriptItem():getName() == "TrolleyContainer" then
		-- local trolContainer = item:getInventory()
		-- playerObj:getInventory():DoRemoveItem(item)
		-- local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
		-- trolWeapon:setRightClickContainer(trolContainer)
		-- playerObj:setPrimaryHandItem(trolWeapon)
		-- playerObj:setSecondaryHandItem(trolWeapon)
		-- playerObj:removeFromHands(item)
		-- character:removeWornItem(item)
	-- end
-- end

-- function TrolleyOnClothingUpdated(playerObj)
-- print("93. TrolleyOnClothingUpdated")
-- end

function TrolleyOnEquipPrimary(playerObj, item)
	print("2. TrolleyOnEquipPrimary: ", item)
	if item and item:getScriptItem():getName() == "TrolleyContainer" then
		-- local trolContainer = item:getItemContainer()
		-- playerObj:removeFromHands(item)
		-- playerObj:removeWornItem(item)
		-- playerObj:getInventory():DoRemoveItem(item)
		local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
		-- trolWeapon:setRightClickContainer(trolContainer)
		-- trolWeapon:setContainer(trolContainer)
		-- trolWeapon = playerObj:getInventory():DoAddItem(trolWeapon)
		-- playerObj:setPrimaryHandItem(nil);
		-- playerObj:setSecondaryHandItem(nil);
		playerObj:setPrimaryHandItem(trolWeapon)
		playerObj:setSecondaryHandItem(trolWeapon)
		-- print("getMod ID1: ", trolWeapon:getID())
		playerObj:getModData()["handTrolley"] = true
	-- elseif (not item or not item:getScriptItem():getName() == "TrolleyContainer") and playerObj:getModData()["handTrolley"] then
			-- playerObj:setPrimaryHandItem(nil);
			-- playerObj:setSecondaryHandItem(nil);
			-- playerObj:getModData()["handTrolley"] = nil 
	end
	print("END: ", playerObj:getModData()["handTrolley"])
	--print(getPlayer():getModData()["handTrolley"])
	
	-- if playerObj:getModData()["handTrolley"] and not (item1 and item1:getScriptItem():getName() == "TrolleyContainer") and not (item2 and item2:getScriptItem():getName() == "TrolleyContainer") then
	-- and not (item1:getScriptItem():getName() == "Trolley" or item2:getScriptItem():getName() == "Trolley") then
		-- local trolWeapon = playerObj:getInventory():getItemById(playerObj:getModData()["handTrolley"])
		-- print ("TROLWEAPON: ", trolWeapon)
		-- if trolWeapon then
			-- local trolContainer = trolWeapon:getRightClickContainer()
			-- playerObj:removeFromHands(trolWeapon)
			-- playerObj:removeWornItem(trolWeapon)
			-- playerObj:getInventory():DoRemoveItem(trolWeapon)
			-- playerObj:setPrimaryHandItem(nil);
			-- playerObj:setSecondaryHandItem(nil);
			-- local trol = InventoryItemFactory.CreateItem("Base.TrolleyContainer")
			-- trol:setItemContainer(trolContainer)
			-- playerObj:getInventory():DoAddItem(trol)
			-- playerObj:getModData()["handTrolley"] = nil --print(getPlayer():getModData()["handTrolley"])
		-- end
	-- elseif item1 and item1:getScriptItem():getName() == "TrolleyContainer" then
		-- local trolContainer = item1:getItemContainer()
		-- playerObj:removeFromHands(item1)
		-- playerObj:removeWornItem(item1)
		-- playerObj:getInventory():DoRemoveItem(item1)
		-- local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
		-- trolWeapon:setRightClickContainer(trolContainer)
		-- trolWeapon = playerObj:getInventory():DoAddItem(trolWeapon)
		-- playerObj:setPrimaryHandItem(nil);
		-- playerObj:setSecondaryHandItem(nil);
		-- playerObj:setPrimaryHandItem(trolWeapon)
		-- playerObj:setSecondaryHandItem(trolWeapon)
		-- print("getMod ID1: ", trolWeapon:getID())
		-- playerObj:getModData()["handTrolley"] = trolWeapon:getID()
		
	-- elseif item2 and item2:getScriptItem():getName() == "TrolleyContainer" then
		-- local trolContainer = item2:getItemContainer()
		-- playerObj:removeFromHands(item2)
		-- playerObj:removeWornItem(item2)
		-- playerObj:getInventory():DoRemoveItem(item2)
		-- local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
		-- trolWeapon:setRightClickContainer(trolContainer)
		-- playerObj:getInventory():DoAddItem(trolWeapon)
		-- playerObj:setPrimaryHandItem(nil);
		-- playerObj:setSecondaryHandItem(nil);
		-- playerObj:setPrimaryHandItem(trolWeapon)
		-- playerObj:setSecondaryHandItem(trolWeapon)
		-- print("getMod ID2: ", trolWeapon:getID())
		-- playerObj:getModData()["handTrolley"] = trolWeapon:getID()
	-- end

end

function TrolleyOnEquipSecondary(playerObj, item)
	print("3. TrolleyOnEquipSecondary: ", item)
	if not item then
		if playerObj:getPrimaryHandItem() and playerObj:getPrimaryHandItem():getScriptItem():getName() == "Trolley" then
			playerObj:setPrimaryHandItem(nil)
		end
	elseif item and not item:getScriptItem():getName() == "Trolley" then
		if playerObj:getPrimaryHandItem() and playerObj:getPrimaryHandItem():getScriptItem():getName() == "Trolley" then
			playerObj:setPrimaryHandItem(nil)
		end
	end
end


function addTrolleyButton(invPage, state)
	if state == "buttonsAdded" then
		local playerObj = getSpecificPlayer(invPage.player)
		if invPage.onCharacter then
			local it = playerObj:getInventory():getItems()
			for i = 0, it:size()-1 do
				local item = it:get(i)
				if item:getType() == "Trolley" and playerObj:isEquipped(item) then
					if item:getContainer() then
						containerButton = invPage:addContainerButton(item:getContainer(), item:getTex(), item:getName(), item:getName())
					end
					if item:getRightClickContainer() then
						containerButton = invPage:addContainerButton(item:getRightClickContainer(), item:getTex(), item:getName(), item:getName())
					end
				end
			end	
		end
	end
end

function TrolleyOnSave()
	local playersSum = getNumActivePlayers()
	for playerNum = 0, playersSum - 1 do
		local playerObj = getSpecificPlayer(playerNum)
		if playerObj and playerObj:getModData()["handTrolley"] then
			local trolWeapon = playerObj:getInventory():getItemById(playerObj:getModData()["handTrolley"])
			if trolWeapon then
				local trolContainer = trolWeapon:getRightClickContainer()
				playerObj:removeFromHands(trolWeapon)
				playerObj:removeWornItem(trolWeapon)
				playerObj:getInventory():DoRemoveItem(trolWeapon)
				playerObj:setPrimaryHandItem(nil);
				playerObj:setSecondaryHandItem(nil);
				local trol = InventoryItemFactory.CreateItem("Base.TrolleyContainer")
				trol:setItemContainer(trolContainer)
				playerObj:getInventory():DoAddItem(trol)
				playerObj:getModData()["handTrolley"] = nil
			end
		end
	end
end

function TrolleyOnFillWorldObjectContextMenu(player, context, worldobjects, test)
	-- print(test)
	print(context)
	-- print(getText("ContextMenu_Grab"))
	local numSubOption = context:getOptionFromName(getText("ContextMenu_Grab")).subOption
	local subContext = context.instanceMap[numSubOption] -- context
	-- print(getText("DisplayName_Trolley"))
	local subMenu = subContext:getOptionFromName(getText("DisplayName_Trolley"))
	print("subMenu ", subMenu)
	
	-- print(context:getOptionFromName().subOption)
	-- print(context.instanceMap[1].options)
	-- context.instanceMap
	
	
	-- for i,v in ipairs(context.instanceMap[1].options) do
		-- print(v.name)
	-- end
	
end

function isForceDropHeavyItem(item)
    return (item ~= nil) and (item:getType() == "Generator" or item:getType() == "CorpseMale" or item:getType() == "CorpseFemale" or item:getType() == "TrolleyContainer")
end

-- 

-- Console code:
-- print(getPlayer():getVariableString("Ext"))
-- getPlayer():initWornItems("Trolley")

-- blg = getPlayer():getBodyLocationGroup()
-- blg:getOrCreateLocation("Trolley")

-- Events.OnEquipPrimary.Add(onEquipTrolley);
Events.OnEquipPrimary.Add(TrolleyOnEquipPrimary);
Events.OnEquipSecondary.Add(TrolleyOnEquipSecondary);

Events.OnFillWorldObjectContextMenu.Add(TrolleyOnFillWorldObjectContextMenu);


-- Events.OnClothingUpdated.Add(TrolleyOnClothingUpdated);
Events.OnFillInventoryObjectContextMenu.Add(trolleyContext);
Events.OnTick.Add(onEquipTrolleyTick);
-- Events.OnSave.Add(TrolleyOnSave);
-- Events.OnObjectAdded.Add(TrolleyOnObjectAdded);

Events.OnRefreshInventoryWindowContainers.Add(addTrolleyButton);