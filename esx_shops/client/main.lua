ESX = nil
local hasAlreadyEnteredMarker, lastZone
local currentAction, currentActionMsg, currentActionData = nil, nil, {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	
	Citizen.Wait(5000)
end)

-- Enter/Exit Marker Actual Events
AddEventHandler('esx_shops:hasEnteredShopMarker', function(zone)
	currentAction     = 'shop_menu'
	currentActionMsg  = _U('press_menu')
	currentActionData = {zone = zone}
end)

AddEventHandler('esx_shops:hasEnteredCraftingMarker', function(zone)
	currentAction     = 'craft_menu'
	currentActionMsg  = _U('craft_menu')
	currentActionData = {zone = zone}
end)

AddEventHandler('esx_shops:hasExitedMarker', function(zone)
	currentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		for i = 1, #v.Pos, 1 do
			if v.ShowBlip then
			local blip = AddBlipForCoord(v.Pos[i])

			SetBlipSprite (blip, v.Type)
			SetBlipScale  (blip, v.Size)
			SetBlipColour (blip, v.Color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(v.Label)
			EndTextCommandSetBlipName(blip)
		end
	end
	end
end)

-- Enter / Exit marker checks
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, false
		local ShopType, ReqJob, HasJob

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				local distance = #(playerCoords - v.Pos[i])

				if distance < Config.DrawDistance then
					if v.ShopType == 'shop' then
						if v.ShowMarker then
							DrawMarker(Config.SMarkerType, v.Pos[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.SMarkerSize.x, Config.SMarkerSize.y, Config.SMarkerSize.z, Config.SMarkerColor.r, Config.SMarkerColor.g, Config.SMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
				  		end
					elseif v.ShopType == 'crafting' then
						if v.ShowMarker then
							DrawMarker(Config.MarkerType, v.Pos[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.CMarkerSize.x, Config.CMarkerSize.y, Config.CMarkerSize.z, Config.CMarkerColor.r, Config.CMarkerColor.g, Config.CMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
				  		end
					end
					letSleep = false

					if distance < 2.0 then
						isInMarker  = true
						currentZone = k
						lastZone    = k
						ShopType 	= v.ShopType
						ReqJob		= v.ReqJob
					end
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			if ShopType == 'shop' then
				if ReqJob ~= nil then
					for _,y in pairs(ReqJob) do
						if y == ESX.GetPlayerData().job.name then
							HasJob = true
						end
					end
						if HasJob then						
							TriggerEvent('esx_shops:hasEnteredShopMarker', currentZone)
						else
							exports['ns_notify']:sendNotify("Wrong Job", "You do not have the required job to use this shop!", 5000, 'error')
						end
					else
						TriggerEvent('esx_shops:hasEnteredShopMarker', currentZone)	
				end
			elseif ShopType == 'crafting' then
				if ReqJob ~= nil then
					for _,y in pairs(ReqJob) do
						if y == ESX.GetPlayerData().job.name then
							HasJob = true
						end
					end
						if HasJob then						
							TriggerEvent('esx_shops:hasEnteredCraftingMarker', currentZone)
						else
							exports['ns_notify']:sendNotify("Wrong Job", "You do not have the required job to use this crafting table!", 5000, 'error')
						end
					else
						TriggerEvent('esx_shops:hasEnteredCraftingMarker', currentZone)
				end
			end
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_shops:hasExitedMarker', lastZone)
			HasJob = false
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if currentAction then
			ESX.ShowHelpNotification(currentActionMsg)

			if IsControlJustReleased(0, 38) then
				if currentAction == 'shop_menu' then
                    exports["mf-inventory"]:openOtherInventory(currentActionData.zone)
				elseif currentAction == 'craft_menu' then
					exports["mf-inventory"]:openCrafting(currentActionData.zone)
				end

				currentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
