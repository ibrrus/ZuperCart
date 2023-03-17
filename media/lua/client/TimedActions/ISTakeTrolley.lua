--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeTrolley = ISBaseTimedAction:derive("ISTakeTrolley");

function ISTakeTrolley:isValid()
    -- print("ISTakeTrolley:isValid")
    -- Prevent grabbing item if another player acts with it
    if not isItemTransactionConsistent(self.item:getItem(), self.item:getItem():getContainer(), self.destContainer) then
        return false
    end
    -- Prevent grabbing items through walls
    if self.item:getSquare() and self.character:getSquare() then
        if self.item:getSquare():isBlockedTo(self.character:getSquare()) then
            return false;
        end;
    end;
    -- Check that the item wasn't picked up by a preceding action
    if self.item == nil or self.item:getSquare() == nil then return false end
    
    -- Check that the item wasn't removed by another player's action
    if not self.item:getSquare():getWorldObjects():contains(self.item) then return false; end;
    return self.destContainer:getItemCount("TMC.TrolleyContainer") == 0 and self.destContainer:getItemCount("TMC.TrolleyContainer2") == 0 and
            self.destContainer:getItemCount("TMC.CartContainer") == 0 and self.destContainer:getItemCount("TMC.CartContainer2") == 0
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
    createItemTransaction(self.item:getItem(), self.item:getItem():getContainer(), self.destContainer)
end

function ISTakeTrolley:stop()
    ISBaseTimedAction.stop(self);
    self.item:getItem():setJobDelta(0.0);
end

function ISTakeTrolley:perform()
    forceDropHeavyItems(self.character)
    
    local inventoryItem = self.item:getItem()
    self.item:getSquare():transmitRemoveItemFromSquare(self.item);
    self.item:removeFromWorld()
    self.item:removeFromSquare()
    self.item:setSquare(nil)
    inventoryItem:setWorldItem(nil)
    inventoryItem:setJobDelta(0.0);
    self.destContainer:setDrawDirty(true);
    self.destContainer:AddItem(inventoryItem);
    
    local pdata = getPlayerData(self.character:getPlayerNum());
    if pdata ~= nil then
        ISInventoryPage.renderDirty = true
        -- pdata.playerInventory:refreshBackpacks();
        -- pdata.lootInventory:refreshBackpacks();
    end
    
    self.action:stopTimedActionAnim();
    self.action:setLoopedAction(false);
    self.character:setPrimaryHandItem(self.item:getItem());
    self.character:setSecondaryHandItem(self.item:getItem());
    if isItemTransactionConsistent(self.item:getItem(), self.item:getItem():getContainer(), self.destContainer) then
        removeItemTransaction(self.item:getItem(), self.item:getItem():getContainer(), self.destContainer)
    else
        return
    end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);

end

function ISTakeTrolley:new (character, item, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.item = item;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.destContainer = o.character:getInventory();
    o.maxTime = time;
    o.loopedAction = true;
    return o
end
