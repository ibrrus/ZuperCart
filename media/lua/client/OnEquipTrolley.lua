
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

function onWearTrolley (items, playerObj)
	-- items = ISInventoryPane.getActualItems(items)
	for i,item in pairs(items) do
		print(i)
		print(item)
		-- print(items[1]:canBeEquipped())
		print(item:canBeEquipped())
		if items[1]:canBeEquipped() == "Trolley" then
			playerObj:getBodyLocationGroup():getOrCreateLocation("Trolley");
			playerObj:setWornItem(item:canBeEquipped(), item);
			getPlayerInventory(playerObj:getPlayerNum()):refreshBackpacks();
			print("2123")
			-- 
			-- ISTimedActionQueue.add(ISWearClothing:new(playerObj, items[0], 50));
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

Events.OnFillInventoryObjectContextMenu.Add(trolleyContext);
Events.OnTick.Add(onEquipTrolleyTick);