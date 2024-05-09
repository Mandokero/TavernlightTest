--[[
Need to make guesses here about what this function might be used for.
My guess is that it is used to track a player character's log in status for other functions to
make use of.

Probably adds a delay (through addEvent) to differentiate logging out from temporary loss of connection?

For this to be useful there needs to be an onLogin() event that swaps the storage when the player logs back in.
Also since the value being stored is binary I'd just use a boolean.
And instead of an arbitrary number as the key in globalStorageTable I'd use a descriptive string.
]]--

-- changed implementation so it can be used by both onLogin() and onLogout().
local function swapStorage(player)
	-- Changed method name to reflect the above.
	if player:getStorageValue("logged in") then
		player:setStorageValue("logged in", false)
	else
		player:setStorageValue("logged in", true)
	end
end

-- Added onLogin to show how both methods would have to interact.
function onLogin(player)
	local second = 1000
	addEvent(swapStorage, second, player)
	-- Note that the conditional statements initially included in onLogout() are ommitted
	return true
end

function onLogout(player)
	local second = 1000
	-- if player:getStorageValue("logged in") then << (Commented this out because the condition is checked in swapStorage() now)
	addEvent(swapStorage, second, player)
	-- end << (Yes these comments are a bit unreadable, I'd just delete but I want my changes to be clear and want to explain them carefully)

	return true
end