local MoneyModule = {}

return function(Bridge)
    --- Retrieves the player's money.
    --- @param source number The player's source ID.
    --- @return number The amount of money the player has.
    function MoneyModule:GetMoney(source)
        local Player = Bridge.Player:GetPlayer(source)
        if Player then
            if Bridge.framework == 'ESX' then
                return Player.getMoney()
            elseif Bridge.framework == 'QBCore' then
                return Player.PlayerData.money['cash']
            elseif Bridge.framework == 'Standalone' then
                return 0
            end
        else
            print('[Bridge] Player not found.')
            return 0
        end
    end

    --- Adds money to the player's balance.
    --- @param source number The player's source ID.
    --- @param amount number The amount of money to add.
    function MoneyModule:AddMoney(source, amount)
        local Player = Bridge.Player:GetPlayer(source)
        if Player then
            if Bridge.framework == 'ESX' then
                Player.addMoney(amount)
            elseif Bridge.framework == 'QBCore' then
                Player.Functions.AddMoney('cash', amount)
            elseif Bridge.framework == 'Standalone' then
                --print("Added $" .. amount .. " to player " .. tostring(source))
            end
        else
            print('[Bridge] Player not found.')
        end
    end

    return MoneyModule
end
