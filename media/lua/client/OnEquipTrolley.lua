
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

-- Events.OnEquipPrimary.Add(onEquipTrolley);
Events.OnTick.Add(onEquipTrolleyTick);