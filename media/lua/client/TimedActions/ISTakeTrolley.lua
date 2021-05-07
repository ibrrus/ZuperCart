--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeTrolley = ISBaseTimedAction:derive("ISTakeTrolley");

function ISTakeTrolley:isValid()
	-- Check that the item wasn't picked up by a preceding action
	if self.item == nil or self.item:getSquare() == nil then return false end
	local destContainer = self.character:getInventory()
	return destContainer:getItemCount("TMC.TrolleyContainer") == 0 and destContainer:getItemCount("TMC.TrolleyContainer2") == 0 and
			destContainer:getItemCount("TMC.CartContainer") == 0 and destContainer:getItemCount("TMC.CartContainer2") == 0
end

function ISTakeTrolley:update()
	self.item:getItem():setJobDelta(self:getJobDelta());
end

function ISTakeTrolley:start()
	self:setActionAnim("Loot");
	self:setAnimVariable("LootPosition", "Medium");
	self:setOverrideHandModels(nil, nil);
	self.item:getItem():setJobType(getText("ContextMenu_Grab"));
	self.item:getItem():setJobDelta(0.0);
end

function ISTakeTrolley:stop()
    ISBaseTimedAction.stop(self);
    self.item:getItem():setJobDelta(0.0);

end

function ISTakeTrolley:perform()
	forceDropHeavyItems(self.character)
	local queuedItem = table.remove(self.queueList, 1);
	for i,item in ipairs(queuedItem.items) do
		self.item = item
		-- Check destination container capacity and item-count limit.
		if not self:isValid() then
			self.queueList = {}
			break
		end
		self:transferItem(item);
	end
	if #self.queueList > 0 then
		queuedItem = self.queueList[1]
		self.maxTime = queuedItem.time;
		self.action:setTime(tonumber(queuedItem.time))
		self.item = queuedItem.items[1];
		self:resetJobDelta();
	else
		self.action:stopTimedActionAnim();
		self.action:setLoopedAction(false);
		self.character:setPrimaryHandItem(self.item:getItem());
		self.character:setSecondaryHandItem(self.item:getItem());
		-- needed to remove from queue / start next.
		ISBaseTimedAction.perform(self);
	end
end

function ISTakeTrolley:transferItem(item)
	local inventoryItem = self.item:getItem()
	self.item:getSquare():transmitRemoveItemFromSquare(self.item);
	self.item:removeFromWorld()
	self.item:removeFromSquare()
	self.item:setSquare(nil)
	inventoryItem:setWorldItem(nil)
	inventoryItem:setJobDelta(0.0);
	self.character:getInventory():setDrawDirty(true);
	self.character:getInventory():AddItem(inventoryItem);

	local pdata = getPlayerData(self.character:getPlayerNum());
	if pdata ~= nil then
		ISInventoryPage.renderDirty = true
--		pdata.playerInventory:refreshBackpacks();
--		pdata.lootInventory:refreshBackpacks();
	end
end

function ISTakeTrolley:checkQueueList()
	-- Get the last timed action in the character's queue.
	-- Reuse the action if it's an ISTakeTrolley.
	local actionQueue = ISTimedActionQueue.getTimedActionQueue(self.character)
	local lastAction = actionQueue.queue[#actionQueue.queue]
	local addTo = self
	if lastAction and (lastAction.Type == "ISTakeTrolley") then
		addTo = lastAction
	end
	local fullType = self.item:getItem():getFullType()
	-- first time we call this
	if addTo == self then
		self.queueList = {};
		local queuedItem = {items = {self.item}, time = self.maxTime, type = fullType};
		table.insert(self.queueList, queuedItem);
	else
		-- ISTimedActionQueue.add() won't add this action.
		self.ignoreAction = true;
		local typeAlreadyExist = false;
		-- we check if in our queue list an item with the same type exist, so we can transfer them in bulk
		-- limit this to 20 items (so transfer 20 per 20 nails)
		for i, v in ipairs(addTo.queueList) do
			if v.type == fullType and #v.items < 20 then
				table.insert(v.items, self.item);
				typeAlreadyExist = true;
				break;
			end
		end
		-- add the current item to our queue list
		if not typeAlreadyExist then
			table.insert(addTo.queueList, {items = {self.item}, time = self.maxTime, type = fullType});
		end
	end
end

function ISTakeTrolley:new (character, item, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	-- print("time?")		   
	o.maxTime = time;
	o.loopedAction = true;
	o:checkQueueList();
	return o
end
