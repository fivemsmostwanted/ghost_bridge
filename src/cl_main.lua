local Bridge = require('init')

-- Command to test player notification
RegisterCommand('testnotification', function()
    Bridge.Notify:Notify(nil, 'This is a test notification from the client.', 'primary', 5000)
end, false)

