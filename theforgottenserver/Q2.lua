function printSmallGuildNames(max_members) -- Thought max_members was more descriptive than memberCount

    -- This method is supposed to print names of all guilds that have less than memberCount max members
    -- The original form of this implementation did not reflect the schema used in the TFS database

    local guildIDs = db.storeQuery("SELECT id FROM guilds")
    -- added a for loop to query the database for each guild in order to search guild_membership table membership data.
    for _, selectedID in guildIDs do
        -- This should return a total count of each guild's total members
        local memberCount = db.storeQuery(
                                         "SELECT COUNT() FROM guild_membership WHERE guild_id = " +
                                             selectedID ";")
        if memberCount <= max_members then
            local guildName = db.storeQuery(
                                  "SELECT name FROM guilds WHERE id = " +
                                      selectedID)
            print(guildName)
        end
    end
end
