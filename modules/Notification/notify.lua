local NotificationModule = {}

return function(Bridge)
    --- Sends a notification to the player.
    --- @param source number The player's source ID (nil on client).
    --- @param title string The title of the notification.
    --- @param type string The type of notification (e.g., 'info', 'success', 'error').
    --- @param duration number The duration of the notification in milliseconds.
    function NotificationModule:Notify(source, title, type, duration)
        type = type or 'primary'
        duration = duration or 5000

        -- Check if this is running on the server or client
        if IsDuplicityVersion() then
            if Bridge.framework == 'ESX' then
                TriggerClientEvent('esx:showNotification', source, title)
            elseif Bridge.framework == 'QBCore' then
                TriggerClientEvent('QBCore:Notify', source, title, type, duration)
            elseif Bridge.framework == 'Standalone' then
                TriggerClientEvent('chat:addMessage', source, {
                    color = {255, 255, 0},
                    multiline = true,
                    args = {'Notification', title}
                })
            end
        else
            -- Client-side notification
            if Bridge.framework == 'ESX' then
                Bridge.ESX.ShowNotification(title)
            elseif Bridge.framework == 'QBCore' then
                Bridge.QBCore.Functions.Notify(title, type, duration)
            elseif Bridge.framework == 'Standalone' then
                TriggerEvent('chat:addMessage', {
                    color = {255, 255, 0},
                    multiline = true,
                    args = {'Notification', title}
                })
            end
        end
    end

    return NotificationModule
end
