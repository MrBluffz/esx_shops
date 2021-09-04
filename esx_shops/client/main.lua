local ESX
local playerData
local BlipList = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob',function(j)
  playerData.job = j
  deleteBlips()
	setupShops()
end)

function showHelpNotification(msg)
	AddTextEntry('shopsHelpNotif', msg)
	DisplayHelpTextThisFrame('shopsHelpNotif', false)
end

function setupEsx()
	while not ESX do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
	Wait(100)
	end
  
	while not ESX.IsPlayerLoaded() do
	  Wait(500)
	end
  
	playerData = ESX.GetPlayerData()
end

function getClosestShop(pos)
  local closest,dist,posi

  for k,v in pairs(Config.Zones) do
    for i = 1, #v.Pos, 1 do
      local d = #(v.Pos[i] - pos)
      if not dist or d < dist then
        posi = v.Pos[i]
        closest = k
        dist = d
      end
    end
  end

  return closest,dist,posi
end

function setupShops()
	if playerData.job ~= nil then
    for k,v in pairs(Config.Zones) do
      if not v.ReqJob or v.ReqJob[playerData.job.name] then
        for i = 1, #v.Pos, 1 do
          if v.ShowBlip then
          local blip = AddBlipForCoord(v.Pos[i])

          SetBlipSprite (blip, v.BlipType)
          SetBlipScale  (blip, v.BlipSize)
          SetBlipColour (blip, v.BlipColor)
          SetBlipAsShortRange(blip, true)
          SetBlipDisplay(blip, v.BlipDisplay or 2)
          BeginTextCommandSetBlipName('STRING')
          AddTextComponentSubstringPlayerName(v.Label)
          EndTextCommandSetBlipName(blip)
          table.insert(BlipList, blip)
          end
        end
      end
    end
  end
end

function deleteBlips()
  for i=1, #BlipList, 1 do
    RemoveBlip(BlipList[i])
    BlipList[i] = nil
  end
end

function notify(title, msg, duration, type)
    if Config.Notify == 'ns' then
      exports['ns_notify']:sendNotify(title, msg, duration, type)
    elseif Config.Notify == 'mythic_old' then
      exports['mythic_notify']:DoCustomHudText(type, msg, duration)
    elseif Config.Notify == 'mythic_new' then
      exports['mythic_notify']:SendAlert(type, msg, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
    elseif Config.Notify == 'esx' then
      ESX.ShowNotification(msg)
    elseif Config.Notify == 'chat' then
      TriggerEvent('chatMessage', msg)
    elseif Config.Notify == 'custom' then
      -- Insert Custom Notification here
    end
end


Citizen.CreateThread(function()
	local lastShop
	local helpShopLabel = _U('press_menu')
  local helpCraftLabel = _U('craft_menu')
	local IsInMarker, AlreadyInMarker = false, false
  local drawcheck = Config.DrawDistance
	setupEsx()
	setupShops()
  
	while true do
	  local ped = PlayerPedId()
	  local pos = GetEntityCoords(ped)
  
	  local closestShop,ShopDist,MarkerPos = getClosestShop(pos)
	  local shop = Config.Zones[closestShop]

    if ShopDist < Config.DrawDistance then
        if shop.ShowMarker and Config.MarkerSetting == 'marker' and not shop.ReqJob or shop.ReqJob[playerData.job.name] then
          DrawMarker(shop.MarkerType, MarkerPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, shop.MarkerSize.x, shop.MarkerSize.y, shop.MarkerSize.z, shop.MarkerColor.r, shop.MarkerColor.g, shop.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
        elseif shop.ShowMarker and Config.MarkerSetting == 'fivem-target' and not shop.ReqJob or shop.ReqJob[playerData.job.name] then
          exports["fivem-target"]:AddTargetPoint({
            name = "openShop",
            label = "Shop",
            icon = "fas fa-cash-register",
            point = MarkerPos,
            interactDist = 2.5,
            onInteract = onInteract,
            options = {
              {
                name = "open_shop",
                label = "Open"
              }     
            }
          })
        elseif not shop.ReqJob or shop.ReqJob[playerData.job.name] then
          notify('Marker Error!', 'There was an error with creating markers! Make sure you have Config.MarkerSetting set correctly.', 5000, 'error')
        end
    end

		if not lastShop or lastShop ~= closestShop then
		  if lastShop then
		    AlreadyInMarker = false
		  end
	  end
		
	  if ShopDist <= Config.InteractDist then
		  lastShop = closestShop
		  IsInMarker = true

      if not AlreadyInMarker and IsInMarker then
        if shop.ReqJob and not shop.ReqJob[playerData.job.name] then
          notify("Wrong Job", "You do not have the correct job to access this Shop!", 5000, 'error')
        end
      end

      AlreadyInMarker = true

      if not shop.ReqJob or shop.ReqJob[playerData.job.name] then
        showHelpNotification(helpShopLabel)
        if IsControlJustPressed(0,38) then
          if shop.ShopType == 'shop' then
            exports["mf-inventory"]:openOtherInventory(closestShop)
          elseif shop.ShopType == 'crafting' then
            exports["mf-inventory"]:openCrafting(closestShop)
          end
        end
      end

    end
  Wait(ShopDist < drawcheck and 0 or 750)
	end
end)