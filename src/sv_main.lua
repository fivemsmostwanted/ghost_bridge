local Bridge = require('init')

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
    print('[Bridge] Framework detected: ' .. (Bridge.framework or 'Unknown'))
end)

-- Command to check money
RegisterCommand('checkmoney', function(source, args, rawCommand)
    local money = Bridge.Money:GetMoney(source)
    Bridge.Notify:Notify(source, 'You have $' .. money, 'primary', 5000)
end, false)

-- Command to give money
RegisterCommand('testgivemoney', function(source, args, rawCommand)
    local amount = tonumber(args[1])
    if amount then
        Bridge.Money:AddMoney(source, amount)
        -- Pass the notification type for ESX/QBCore, it will be ignored for Standalone
        Bridge.Notify:Notify(source, 'You received $' .. amount, 'success', 5000)
    else
        Bridge.Notify:Notify(source, 'Invalid amount.', 'error', 5000)
    end
end, false)

