void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
    bool player_was_null = false;
    Player *player = g_game.getPlayerByName(recipient);
    if (!player)
    {
        bool player_was_null = true;
        player = new Player(nullptr); // This allocates memory
        if (!IOLoginData::loadPlayerByName(player, recipient))
        {
            delete player; // removing that memory
            player = nullptr;
            return;
        }
    }

    Item *item = Item::CreateItem(itemId); // This allocates memory
    if (!item)
    {
        if (player_was_null) // using this to check if the first if statement passed and new memory was allocated in the player pointer
        // Won't delete otherwise. That data might be used elsewhere.
        {
            delete player;
        }
        delete item; // removing this memory
        item = nullptr;
        player = nullptr; // still need to clear the local pointers
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline())
    {
        IOLoginData::savePlayer(player);
    }
    if (player_was_null)
    {
        delete player;
    }
    delete item; // item is stored in database so it should be deleted from memory
    item = nullptr;
    player = nullptr;
}