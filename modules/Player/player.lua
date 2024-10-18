local PlayerModule = {}

return function(Bridge)
    --- Retrieves the player object for the given source.
    --- @param source number The player's source ID.
    --- @return any The player object, or nil if not found.
    function PlayerModule:GetPlayer(source)
        if Bridge.framework == 'ESX' then
            return Bridge.ESX.GetPlayerFromId(source)
        elseif Bridge.framework == 'QBCore' then
            return Bridge.QBCore.Functions.GetPlayer(source)
        elseif Bridge.framework == 'Standalone' then
            return { source = source }
        else
            return nil
        end
    end

    return PlayerModule
end
