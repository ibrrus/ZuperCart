function Recipe.OnCreate.JagdkommandoRemove(items, result, player, sourceItem, firstHand, secondHand)
    result:setCondition(sourceItem:getCondition());
	local case = player:getInventory():AddItem("Base.JagdkommandoCase");
	case:setCondition(sourceItem:getCondition());
	player:setPrimaryHandItem(result);
end

function Recipe.OnCreate.JagdkommandoSheath(items, result, player, sourceItem, firstHand, secondHand)
    result:setCondition(sourceItem:getCondition());
	player:setPrimaryHandItem(result);
end