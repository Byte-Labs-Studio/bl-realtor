local QBCore = exports['qb-core']:GetCoreObject()







RegisterNetEvent("bl-realtor:server:updateProperty", function(type, property_id, data)
    local src = source
    -- Job check

    -- Update property
    print(json.encode(data))
    TriggerEvent("ps-housing:server:updateProperty", type, property_id, data)
end)

RegisterNetEvent("bl-realtor:server:registerProperty", function(data)
    local src = source
    -- Job check

    -- Register property

    TriggerEvent("ps-housing:server:registerProperty", data)
end)