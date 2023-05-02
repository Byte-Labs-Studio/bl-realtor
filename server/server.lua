local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Server:UpdateObject', function()
	if source ~= '' then return false end
	QBCore = exports['qb-core']:GetCoreObject()
end)
QBCore.Functions.AddJob('realtor', Config.Job)

RegisterNetEvent("bl-realtor:server:updateProperty", function(type, property_id, data)
    -- Job check
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData
    if not PlayerData.job.name == "realtor" then return false end
    data.realtorSrc = src
    -- Update property
    TriggerEvent("ps-housing:server:updateProperty", type, property_id, data)
end)

RegisterNetEvent("bl-realtor:server:registerProperty", function(data)
    -- Job check
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerData = Player.PlayerData
    if not PlayerData.job.name == "realtor" then return false end
    data.realtorSrc = src
    -- Register property
    TriggerEvent("ps-housing:server:registerProperty", data)
end)