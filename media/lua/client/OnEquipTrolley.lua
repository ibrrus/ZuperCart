

TrolleyList = {
"TMC.TrolleyContainer", 
"TMC.CartContainer", 
"TMC.TrolleyContainer2",
"TMC.CartContainer2",
}


function onEquipTrolleyTick()
    local playersSum = getNumActivePlayers()
	for playerNum = 0, playersSum - 1 do
		local playerObj = getSpecificPlayer(playerNum)
		if playerObj then
			-- Выбрасывание лишней тележки
			local playerInv = playerObj:getInventory()
			if (playerInv:getItemCount(TrolleyList[1]) + 
					playerInv:getItemCount(TrolleyList[2]) + 
					playerInv:getItemCount(TrolleyList[3]) + 
					playerInv:getItemCount(TrolleyList[4])) > 1 then
				-- print("MORE Trolley")
				for i = 1, #TrolleyList do
					trolForDrop = nil
					itemsArray = playerInv:getItemsFromType(TrolleyList[i])
					-- itemsArray = playerInv:getItemsFromType("SAD")
					-- print(itemsArray:size())
					if itemsArray:size() > 0 then
						if not (playerObj:getPrimaryHandItem() == itemsArray:get(0)) then
							trolForDrop = itemsArray:get(0)
						elseif itemsArray:size() > 1 then
							trolForDrop = itemsArray:get(1)
						end
						if trolForDrop then
							-- print("trolForDrop")
							playerInv:Remove(trolForDrop)
							playerObj:removeFromHands(trolForDrop)
							local dropX,dropY,dropZ = ISInventoryTransferAction.GetDropItemOffset(playerObj, playerObj:getCurrentSquare(), trolForDrop)
							playerObj:getCurrentSquare():AddWorldInventoryItem(trolForDrop, dropX, dropY, dropZ)
							break
						end
					end
				end
			elseif (playerInv:getItemCount(TrolleyList[1]) == 1 or 
					playerInv:getItemCount(TrolleyList[2]) == 1 or 
					playerInv:getItemCount(TrolleyList[3]) == 1 or 
					playerInv:getItemCount(TrolleyList[4]) == 1) then
				for i = 1, #TrolleyList do
					trolForEquip = playerInv:getFirstType(TrolleyList[i])
					if trolForEquip then
						-- Замена на другой контейнер
						trolCont = trolForEquip:getItemContainer()
						if i <= (#TrolleyList / 2) and not trolCont:isEmpty() then
							playerInv:Remove(trolForEquip)
							trolForEquip = playerInv:AddItem(TrolleyList[i + #TrolleyList / 2])
							trolForEquip:setItemContainer(trolCont)
						elseif i > (#TrolleyList / 2) and trolCont:isEmpty() then
							playerInv:Remove(trolForEquip)
							trolForEquip = playerInv:AddItem(TrolleyList[i - #TrolleyList / 2])
							trolForEquip:setItemContainer(trolCont)
						end
						-- Тележка сразу берется в руки
						if playerObj:getPrimaryHandItem() ~= trolForEquip then
							playerObj:setPrimaryHandItem(trolForEquip)
							playerObj:setSecondaryHandItem(trolForEquip)
							getPlayerData(playerObj:getPlayerNum()).playerInventory:refreshBackpacks();
						end
						break
					end
				end
					
					
				-- local trolForEquip = playerInv:getFirstType("TMC.TrolleyContainer")
				-- local trolForEquip2 = playerInv:getFirstType("TMC.TrolleyContainer2")
				-- if trolForEquip then
					-- -- Замена на другой контейнер
					-- trolCont = trolForEquip:getItemContainer()
					-- if not trolCont:isEmpty() then
						-- playerInv:Remove(trolForEquip)
						-- trolForEquip = playerInv:AddItem("TMC.TrolleyContainer2")
						-- trolForEquip:setItemContainer(trolCont)
					-- end
					-- -- Тележка сразу берется в руки
					-- if playerObj:getPrimaryHandItem() ~= trolForEquip then
						-- playerObj:setPrimaryHandItem(trolForEquip)
						-- playerObj:setSecondaryHandItem(trolForEquip)
						-- getPlayerData(playerObj:getPlayerNum()).playerInventory:refreshBackpacks();
					-- end
					
				-- elseif trolForEquip2 then
					-- -- Замена на другой контейнер
					-- trolCont = trolForEquip2:getItemContainer()
					-- if trolCont:isEmpty() then
						-- playerInv:Remove(trolForEquip2)
						-- trolForEquip2 = playerInv:AddItem("TMC.TrolleyContainer")
						-- trolForEquip2:setItemContainer(trolCont)
					-- end
					-- if playerObj:getPrimaryHandItem() ~= trolForEquip2 then
						-- playerObj:setPrimaryHandItem(trolForEquip2)
						-- playerObj:setSecondaryHandItem(trolForEquip2)
						-- getPlayerData(playerObj:getPlayerNum()).playerInventory:refreshBackpacks();
					-- end
				-- end
			end

			
			-- Задание переменной для анимации
			if playerObj:getVariableString("Weapon") ~= "trolley" then -- print(getPlayer():getVariableString("Weapon"))
				local _item = playerObj:getPrimaryHandItem()
				-- local _item2 = playerObj:getSecondaryHandItem()
				if _item and (_item:getScriptItem():getName() == "TrolleyContainer" or 
							  _item:getScriptItem():getName() == "TrolleyContainer2" or 
							  _item:getScriptItem():getName() == "CartContainer" or 
							  _item:getScriptItem():getName() == "CartContainer2") then
					playerObj:setVariable("Weapon", "trolley")
				-- elseif _item2 and (_item2:getScriptItem():getName() == "TrolleyContainer" or 
						-- _item2:getScriptItem():getName() == "TrolleyContainer2") then
					-- playerObj:setVariable("Weapon", "trolley")
				end
			else
				-- Выбрасывание тележки при столкновениях и пр.
				if not (playerObj:getCurrentState() == IdleState.instance()) then
					sqr = playerObj:getSquare()
					trol = playerObj:getPrimaryHandItem()
					playerObj:getInventory():DoRemoveItem(trol)
					sqr:AddWorldInventoryItem(trol, 0, 0, 0);
					playerObj:setPrimaryHandItem(nil);
					playerObj:setSecondaryHandItem(nil);
				end
			end
		end
		-- print(playerObj:getCurrentState())
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
		local trolleyName = worldObject:getItem():getFullType()
		if (trolleyName == TrolleyList[1]) or (trolleyName == TrolleyList[2])
			or (trolleyName == TrolleyList[3]) or (trolleyName == TrolleyList[4]) then
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

function isForceDropHeavyItem(item)
    return (item ~= nil) and (item:getType() == "Generator" or item:getType() == "CorpseMale" or item:getType() == "CorpseFemale" or item:getFullType() == TrolleyList[1] or item:getFullType() == TrolleyList[2] or item:getFullType() == TrolleyList[3] or item:getFullType() == TrolleyList[4])
end

Events.OnFillWorldObjectContextMenu.Add(TrolleyOnFillWorldObjectContextMenu);
Events.OnTick.Add(onEquipTrolleyTick);
-- Events.OnRefreshInventoryWindowContainers.Add(addTrolleyButton);