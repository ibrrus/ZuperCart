
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
				if _item and instanceof(_item, "HandWeapon") then
					if _item:getScriptItem():getName() == "Trolley" then
						playerObj:setVariable("Weapon", "trolley")
						print("OK")
					end
				end
				_item = playerObj:getSecondaryHandItem()
				if _item and instanceof(_item, "HandWeapon") then
					if _item:getScriptItem():getName() == "Trolley" then
						playerObj:setVariable("Weapon", "trolley")
						print("OK")
					end
				end
			end
		end
    end
end

function trolleyContext (player, context, items) 
	playerObj = getSpecificPlayer(player)
	local option = context:addOption(getText("ContextMenu_Equip"), items, onWearTrolley, playerObj);
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

function TrolleyOnClothingUpdated(playerObj)
print("93. TrolleyOnClothingUpdated")
end

function TrolleyOnEquipPrimary(playerObj, item)
	print("2. TrolleyOnEquipPrimary: ", item)
	-- local item1 = playerObj:getPrimaryHandItem()
	-- local item2 = playerObj:getSecondaryHandItem()
	-- print(item1)
	-- print(item)
	if item and item:getScriptItem():getName() == "TrolleyContainer" then
		local trolContainer = item:getItemContainer()
		playerObj:removeFromHands(item)
		playerObj:removeWornItem(item)
		playerObj:getInventory():DoRemoveItem(item)
		local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
		trolWeapon:setRightClickContainer(trolContainer)
		trolWeapon = playerObj:getInventory():DoAddItem(trolWeapon)
		playerObj:setPrimaryHandItem(nil);
		playerObj:setSecondaryHandItem(nil);
		playerObj:setPrimaryHandItem(trolWeapon)
		playerObj:setSecondaryHandItem(trolWeapon)
		print("getMod ID1: ", trolWeapon:getID())
		playerObj:getModData()["handTrolley"] = trolWeapon:getID()
	elseif not item and playerObj:getModData()["handTrolley"] then
		local trolWeapon = playerObj:getInventory():getItemById(playerObj:getModData()["handTrolley"])
		print ("TROLWEAPON: ", trolWeapon)
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
			playerObj:getModData()["handTrolley"] = nil --print(getPlayer():getModData()["handTrolley"])
		end
	end
	print("END: ", playerObj:getModData()["handTrolley"])
	
	
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

function addTrolleyButton(invPage, state)
	if state == "buttonsAdded" then
		local playerObj = getSpecificPlayer(invPage.player)
		if invPage.onCharacter then
			-- local name = getText("IGUI_InventoryName", playerObj:getDescriptor():getForename(), playerObj:getDescriptor():getSurname())
			-- containerButton = invPage:addContainerButton(playerObj:getInventory(), invPage.invbasic, name, nil)
			-- containerButton.capacity = invPage.inventory:getMaxWeight()
			-- if not invPage.capacity then
				-- invPage.capacity = containerButton.capacity
			-- end
			local it = playerObj:getInventory():getItems()
			for i = 0, it:size()-1 do
				local item = it:get(i)
				if item:getType() == "Trolley" and playerObj:isEquipped(item) then
					if item:getRightClickContainer() then
						containerButton = invPage:addContainerButton(item:getRightClickContainer(), item:getTex(), item:getName(), item:getName())
					end
				end
			end	
		end
	end
end
-- 

-- Console code:
-- print(getPlayer():getVariableString("Ext"))
-- getPlayer():initWornItems("Trolley")

-- blg = getPlayer():getBodyLocationGroup()
-- blg:getOrCreateLocation("Trolley")

-- Events.OnEquipPrimary.Add(onEquipTrolley);
Events.OnEquipPrimary.Add(TrolleyOnEquipPrimary);
Events.OnClothingUpdated.Add(TrolleyOnClothingUpdated);
Events.OnFillInventoryObjectContextMenu.Add(trolleyContext);
Events.OnTick.Add(onEquipTrolleyTick);
-- Events.OnObjectAdded.Add(TrolleyOnObjectAdded);

Events.OnRefreshInventoryWindowContainers.Add(addTrolleyButton);