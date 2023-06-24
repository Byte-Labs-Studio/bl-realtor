local QBCore = exports['qb-core']:GetCoreObject()

local Shells = {}
local Properties = {}
local Apartments = {}

local showBlipsForSale = false
local showBlipsOwned = false

local blipsForSale = {}
local blipsOwned = {}

local UIOpen = false

RegisterNetEvent('QBCore:Server:UpdateObject', function()
	if source ~= '' then return false end
	QBCore = exports['qb-core']:GetCoreObject()
end)

local function toggleUI(bool)
	UIOpen = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end

RegisterNUICallback("hideUI", function()
	toggleUI(false)
end)

local function updateMenuData()
	Shells = exports["ps-housing"]:GetShells()

	local data = exports["ps-housing"]:GetData()
	Properties = data.properties
	Apartments = data.apartments
	
	-- All seperated so we can update them individually later on
	SendNUIMessage({
		action = "setShells",
		data = Shells
	})

	SendNUIMessage({
		action = "setProperties",
		data = Properties
	})

	SendNUIMessage({
		action = "setApartments",
		data = Apartments
	})
end

local function setRealtor(jobInfo)
	if jobInfo.name == "realtor" then
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

RegisterNetEvent("QBCore:Client:OnJobUpdate", setRealtor)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function() -- Don't use this with the native method
	updateMenuData()
    local PlayerData = QBCore.Functions.GetPlayerData()
	setRealtor(PlayerData.job)
end)

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

-- I was going to make it only going to run the 2 handler if they were in the menu or realtor but I think its good to update anyway
AddEventHandler("bl-realtor:client:updateProperties", function(data)
	Properties = data
	if showBlipsForSale then
		CreateBlipsOnMap("forSale")
	end

	if showBlipsOwned then
		CreateBlipsOnMap("owned")
	end

	SendNUIMessage({
		action = "setProperties",
		data = Properties
	})
end)

AddEventHandler("bl-realtor:client:updateApartments", function(data)
	Apartments = data
	SendNUIMessage({
		action = "setApartments",
		data = Apartments
	})
end)

RegisterCommand("housing", function()
	toggleUI(not UIOpen)
end, false)

-- Callbacks
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

RegisterNUICallback("addTenantToApartment", function(data, cb)
	TriggerServerEvent("bl-realtor:server:addTenantToApartment", data)
	cb("ok")

end)

RegisterNUICallback("getNames", function(data, cb)
	if not data then return end
	local names = lib.callback.await("bl-realtor:server:getNames",source, data)
	cb(names)
end)

RegisterNUICallback("startZonePlacement", function (data, cb)
	cb("ok") -- too long for promise
	SetNuiFocus(false, false)

	local type = data.type
	local property_id = data.property_id

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
				length = 3.0,
				width = 5.0,
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

-- For the zone placement. At some point I will make a proper system but its not a big deal, it works.
function ZoneThread(type, promise)
	local findingZone = true

	-- default for door
	local length = 2.0
    local width = 1.0
    local zoff = 2.0
    local height = 2.5

	if type == "garage" then
		lib.notify({text="Best to get in a vehicle to see how the zone would look.", type="error"})
		
		length = 3.0
		width = 5.0
	end

	CreateThread(function()
		while findingZone do
			local coords = GetEntityCoords(cache.ped)
			local x = coords.x
			local y = coords.y
			local z = coords.z
			local heading = GetEntityHeading(cache.ped)
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

RegisterNUICallback("getBlipBooleans", function (_, cb)
	cb({
		showBlipsForSale = showBlipsForSale,
		showBlipsOwned = showBlipsOwned,
	})
end)

RegisterNUICallback("showBlipsForSale", function (bool, cb)
	if bool then
		showBlipsForSale = true
		CreateBlipsOnMap("forSale")
	else
		showBlipsForSale = false
		RemoveBlipsOnMap("forSale")
	end
	cb(1)
end)

RegisterNUICallback("showBlipsOwned", function (bool, cb)
	if bool then
		showBlipsOwned = true
		CreateBlipsOnMap("owned")
	else
		showBlipsOwned = false
		RemoveBlipsOnMap("owned")
	end
	cb(1)
end)

function CreateBlipsOnMap(type)
	if type ~= "forSale" and type ~= "owned" then return end
	local blipsTable = type == "forSale" and blipsForSale or blipsOwned
	local blipName = type == "forSale" and "Property For Sale" or "Owned Property"

	RemoveBlipsOnMap(type)

	for k, v in pairs(Properties) do
		if (v.for_sale and not v.apartment) or 
		   (v.owner and not v.for_sale) then
			local coords = v.door_data
			local blip = CreateBlip(coords, blipName)
			blipsTable[#blipsTable + 1] = blip
		end
	end
end

function CreateBlip(coords, blipName)
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipSprite(blip, 375)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(blipName)
	EndTextCommandSetBlipName(blip)
	return blip
end

function RemoveBlipsOnMap(type)
	if type == "forSale" then
		for k, v in pairs(blipsForSale) do
			RemoveBlip(v)
		end
	elseif type == "owned" then
		for k, v in pairs(blipsOwned) do
			RemoveBlip(v)
		end
	end
end