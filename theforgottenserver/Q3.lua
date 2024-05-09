--[[ Adding descriptive variable names
    The TFS documentation doesn't seem to contain any of these methods for managing player parties in
    detail and i can't find definitions for any of them in the files. Also can't find a search method for
    players based on userdata in the documentation. I'm taking them at face value that both
    Player(userdata) and Party.removeMember(userdata) exist and work properly]] --
function removePlayerFromParty(playerId)
    local player = Player(playerId)
    local party = player:getParty()
    party:removeMember(player)
    --[[The way this method is used in the original implementation implies
    that removeMember already searches for the player in the party so the loop is not needed in this
    method. Furthermore Player(playerId) would be the key for the player list and should necessarily
    output the same as Player(membername) except in case of user error so the multiple calls for
    Player(membername) were redundant
    
    In addition, the search in this method is even more redundant because player.getParty already returned a party
    which we know contains a player with that id
    
    If it is possible for the player to be in multiple parties it might be more appropriate to search for
    the party independently of the player, then search for the player in that party and remove them if
    they're found. This implementation is based on the assumption that the player can only be in one party,
    as seemingly implied by the player.getParty() method]] --
end
