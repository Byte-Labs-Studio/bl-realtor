local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Server:UpdateObject', function()
	if source ~= '' then return false end
	QBCore = exports['qb-core']:GetCoreObject()
end)

local Shells = {}
local Properties = {}

local uiopen = false
local function toggleUI(bool)
	uiopen = bool
	SetNuiFocus(bool, bool)

	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end

local function updateMenuData()
	Shells = exports["ps-housing"]:GetShells()
	Properties = exports["ps-housing"]:GetProperties()
	SendNUIMessage({
		action = "setShells",
		data = Shells
	})
	SendNUIMessage({
		action = "setProperties",
		data = Properties
	})
end

local function setRealtor(jobInfo)
	print("setRealtor")
	if jobInfo.name == "realtor" then
		print("setRealtorGrade", jobInfo.grade.level)
		SendNUIMessage({
			action = "setRealtorGrade",
			data = jobInfo.grade.level
		})
	else 
		SendNUIMessage({
			action = "setRealtorGrade",
			data = nil
		})
	end
end

AddEventHandler("onResourceStart", function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		Wait(2000)
		updateMenuData()
		SendNUIMessage({
			action = "setConfig",
			data = Config.RealtorPerms
		})
		local PlayerData = QBCore.Functions.GetPlayerData()
		setRealtor(PlayerData.job)
	end
	if (resourceName == "ps-housing") then
		updateMenuData()
	end
end)


RegisterNetEvent("QBCore:Client:OnJobUpdate", setRealtor)
AddEventHandler('QBCore:Client:OnPlayerLoaded', function() -- Don't use this with the native method
	updateMenuData()
    local PlayerData = QBCore.Functions.GetPlayerData()
	setRealtor(PlayerData.job)
end)

AddEventHandler("bl-realtor:client:updateProperties", function(data)
	Properties = data
	if not uiopen then return end
	SendNUIMessage({
		action = "setProperties",
		data = Properties
	})
end)

RegisterCommand("real", function()
	toggleUI(not uiopen)
end, false)

RegisterNUICallback("hideUI", function()
    toggleUI(false)
end)

RegisterNUICallback("setWaypoint", function (data, cb)
	SetNewWaypoint(data.x, data.y)
	cb("ok")
end)

RegisterNUICallback("updatePropertyData", function(data, cb)
	local property_id = data.property_id
	local newData = data.data
	local changeType = data.type
	TriggerServerEvent("bl-realtor:server:updateProperty", changeType, property_id, newData)
	cb("ok")
end)

RegisterNUICallback("startZonePlacement", function (data, cb)
	cb("ok")
	local type = data.type
	local property_id = data.property_id
	SetNuiFocus(false, false)
	local newDataPromise = promise.new()
	ZoneThread(type, newDataPromise)
	local newData = Citizen.Await(newDataPromise)
	if not newData then return end
	if type == "door" then
		type = "UpdateDoor"
	elseif type == "garage" then
		type = "UpdateGarage"
		SendNUIMessage({
			action = "garageMade",
			data = {
				x = newData.x,
				y = newData.y,
				z = newData.z,
				h = newData.heading,
			}
		})
	end
	TriggerServerEvent("bl-realtor:server:updateProperty", type, property_id, newData)
end)


local function setHide(bool)
	SendNUIMessage({
		action = "setTempHide",
		data = bool
	})
	SetNuiFocus(not bool, not bool)
end


function ZoneThread(type, promise)
	local findingZone = true
	-- default for door
	local length = 2.0
    local width = 1.0
    local zoff = 2.0
    local height = 2.5

	if type == "garage" then
		QBCore.Functions.Notify("Best to get in a vehicle to see how the zone would look.", "error")
		lib.notify({text="Best to get in a vehicle to see how the zone would look.", type="error"})

		length = 3.0
		width = 5.0
	end

	CreateThread(function()
		while findingZone do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local x = coords.x
			local y = coords.y
			local z = coords.z
			local heading = GetEntityHeading(ped)
			DrawMarker(43, x, y, z + zoff, 0.0, 0.0, 0.0, 0.0, 180.0, -heading, length, width, height, 255, 0, 0, 50, false, false, 2, nil, nil, false)	
			if IsDisabledControlJustPressed(0, 38) then -- E
				findingZone = false
				setHide(false)
				local newData = {
					x = x,
					y = y,
					z = z,
					h = heading,
				}
				promise:resolve(newData)
			end
			if IsDisabledControlJustPressed(0, 104) then -- H
				findingZone = false
				setHide(false)
				promise:resolve(false)
			end
			Wait(0)
			DisableControlAction(0, 199, true) -- P
			DisableControlAction(0, 200, true) -- ESC
			DisableControlAction(0, 104, true) -- H 
		end
	end)

end



