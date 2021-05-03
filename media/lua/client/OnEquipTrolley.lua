
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
				elseif _item and _item:getScriptItem():getName() == "TrolleyContainer" then
					playerObj:setVariable("Weapon", "trolley")
				elseif _item2 and _item2:getScriptItem():getName() == "Trolley" then
					playerObj:setVariable("Weapon", "trolley")
				elseif _item2 and _item2:getScriptItem():getName() == "TrolleyContainer" then
					playerObj:setVariable("Weapon", "trolley")
					local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
					-- trolWeapon:setContainer(_item2:getContainer())
					-- playerObj:setPrimaryHandItem(trolWeapon);
					-- playerObj:setSecondaryHandItem(trolWeapon);
				end
			else
				if not (playerObj:getCurrentState() == IdleState.instance()) then
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
		local trolWeapon = InventoryItemFactory.CreateItem("Base.Trolley")
		playerObj:setPrimaryHandItem(trolWeapon)
		playerObj:setSecondaryHandItem(trolWeapon)
		playerObj:getModData()["handTrolley"] = true
	end
	print("END: ", playerObj:getModData()["handTrolley"])
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

function ISWorldObjectContextMenu.getWorldObjectsOnSquares(squares, worldObjects)
	for _,square in ipairs(squares) do
		local squareObjects = square:getWorldObjects()
		for i=1,squareObjects:size() do
			local worldObject = squareObjects:get(i-1)
			table.insert(worldObjects, worldObject)
		end
	end
end

function TrolleyOnFillWorldObjectContextMenu(player, context, worldobjects, test)
	-- print(test)
	-- print(context)
	local playerObj = getSpecificPlayer(player)
	local squares = {}
	local doneSquare = {}
	for i,v in ipairs(worldobjects) do
		if v:getSquare() and not doneSquare[v:getSquare()] then
			doneSquare[v:getSquare()] = true
			table.insert(squares, v:getSquare())
		end
	end
	if #squares == 0 then return false end
	
	local worldObjects = {}
	if JoypadState.players[player+1] then
		for _,square in ipairs(squares) do
			for i=1,square:getWorldObjects():size() do
				local worldObject = square:getWorldObjects():get(i-1)
				table.insert(worldObjects, worldObject)
			end
		end
	else
		local squares2 = {}
		for k,v in pairs(squares) do
			squares2[k] = v
		end
		local radius = 1
		for _,square in ipairs(squares2) do
			ISWorldObjectContextMenu.getSquaresInRadius(square:getX(), square:getY(), square:getZ(), radius, doneSquare, squares)
		end
		ISWorldObjectContextMenu.getWorldObjectsOnSquares(squares, worldObjects)
	end
	if #worldObjects == 0 then return false end
	for _,worldObject in ipairs(worldObjects) do
		if worldObject:getItem():getType() == "TrolleyContainer" then
			-- context:removeOption(context:getOptionFromName(getText("ContextMenu_Grab")))
			-- worldObject:getItem():setContainer(nil)
			-- print(worldObject:getItem():getContainer())
			local old_option_update = context:getOptionFromName(getText("ContextMenu_Grab"))
			if old_option_update then
				context:updateOption(old_option_update.id, getText("ContextMenu_GrabTrolley"), playerObj, ISWorldObjectContextMenu.equipTrolley, worldObject)
				return
			end				
		end
	end
end

ISWorldObjectContextMenu.equipTrolley = function(playerObj, WItem)
    if WItem:getSquare() and luautils.walkAdj(playerObj, WItem:getSquare()) then
		if playerObj:getPrimaryHandItem() then
			ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
		end
		if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
			ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
		end
		local time = ISWorldObjectContextMenu.grabItemTime(playerObj, WItem)
		ISTimedActionQueue.add(ISTakeTrolley:new(playerObj, WItem, time))
	end
end


-- ISWorldObjectContextMenu.onTakeTrolley = function(worldobjects, generator, player)
	-- local playerObj = getSpecificPlayer(player)
	-- if luautils.walkAdj(playerObj, generator:getSquare()) then
		-- if playerObj:getPrimaryHandItem() then
			-- ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
		-- end
		-- if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
			-- ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
		-- end
		-- ISTimedActionQueue.add(ISTakeGenerator:new(player, generator, 100));
	-- end
-- end




function isForceDropHeavyItem(item)
    return (item ~= nil) and (item:getType() == "Generator" or item:getType() == "CorpseMale" or item:getType() == "CorpseFemale" or item:getType() == "TrolleyContainer")
end

-- Events.OnEquipPrimary.Add(TrolleyOnEquipPrimary);
-- Events.OnEquipSecondary.Add(TrolleyOnEquipSecondary);
-- Events.OnFillWorldObjectContextMenu.Add(TrolleyOnFillWorldObjectContextMenu);
Events.OnFillInventoryObjectContextMenu.Add(trolleyContext);
Events.OnTick.Add(onEquipTrolleyTick);
Events.OnRefreshInventoryWindowContainers.Add(addTrolleyButton);