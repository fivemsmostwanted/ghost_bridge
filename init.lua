local Init = {}
Init.__index = Init

--- Detect the framework and load the corresponding modules.
function Init:detectFramework()
    if GetResourceState('es_extended') == 'started' then
        self.framework = 'ESX'
        self.ESX = exports['es_extended']:getSharedObject()
        print('[Bridge] ESX framework detected.')
    elseif GetResourceState('qb-core') == 'started' then
        self.framework = 'QBCore'
        self.QBCore = exports['qb-core']:GetCoreObject()
        print('[Bridge] QBCore framework detected.')
    else
        self.framework = 'Standalone'
        print('[Bridge] No supported framework detected. Running in standalone mode.')
    end
end

--- Initialize the Init object and load the necessary modules.
function Init:new()
    local self = setmetatable({}, Init)
    self:detectFramework()  -- Detect framework when initializing

    -- Load individual modules and pass the self (the framework instance)
    self.Player = require('modules.Player.player')(self)
    self.Money = require('modules.Money.money')(self)
    self.Notify = require('modules.Notification.notify')(self)

    return self
end

-- Singleton instance to use the Init object across files
local frameworkInstance = Init:new()

return frameworkInstance
