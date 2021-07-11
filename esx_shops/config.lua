Config = {}
Config.DrawDistance = 100
Config.MarkerSize = {x = 1.1, y = 1.1, z = 0.9}
Config.MarkerType =  29
Config.MarkerColor = {r = 102, g = 102, b = 204, a = 255}
Config.Locale = 'en'

Config.Zones = {

	market = {											-- This name must match the shop identifier or crafting recipe name in MF_Inventory EXACTLY. It is cap sensitive.
		Pos = {											-- List of all shop/crafting table locations locations that you want to use the identifier above.
			vector3(-47.29,-1756.7,29.42),
			vector3(25.81,-1345.25,29.5),
			vector3(-707.32,-912.9,19.22),
			vector3(1163.39,-322.21,69.21),
			vector3(373.59,325.52,103.57),
			vector3(-1821.45,793.84,138.11),
			vector3(-3038.78,585.85,7.91),
			vector3(-3241.54,1001.14,12.83),
			vector3(547.77,2671.75,42.16),
			vector3(2679.15,3280.13,55.24),
			vector3(1961.42,3740.09,32.34),
			vector3(1699.27,4923.54,42.06),
			vector3(1728.69,6414.18,35.04)
		},
		Size  = 1.0,
		Type  = 59,
		Color = 25,
		ShowBlip = true,
 		ShowMarker = true,
		Label = '24/7',
		ShopType = 'shop',									-- This needs to be 'shop' or 'crafting'
		ReqJob = {'police'}									-- Delete entire line if you don't want a job check, otherwise make sure your job/jobs are in { } like this example {'insertjob', 'insertjob2'}
	},

	liqour = {
		Pos = {
			vector3(1135.8, -982.2, 46.4),
			vector3(-1222.9, -906.9, 12.5),
			vector3(-1487.5, -379.1, 40.2),
			vector3(-2968.2, 390.9, 15.1),
			vector3(1166.0, 2708.9, 38.2),
			vector3(1392.5, 3604.6,  35.01),
			vector3(127.9,  -1285.25, 29.5), --StripClub
			vector3(-1394.24, -606.97, 30.5), --Tequila la
			vector3(-559.9, 287.0, 82.1) --Bahamamas
		},
		Size  = 1.0,
		Type  = 93,
		Color = 27,
		ShowBlip = true,
		ShowMarker = true,
		Label = 'Liquor Store',
		ShopType = 'shop',
		ReqJob = {'police', 'ambulance'}
	},

	weapon = {
		Pos = {
			vector3(22.35,-1106.8,29.8),
			vector3(-662.0,-934.88,21.83),
			vector3(809.84,-2157.76,29.62),
			vector3(252.48,-50.46,69.94),
			vector3(2567.53,293.86,108.73),
			vector3(-1117.8,2699.0,18.55),
			vector3(1693.37,3760.3,34.71),
			vector3(-330.33,6084.49,31.45),
			vector3(842.18,-1034.01,28.19)
		},
		Size  = 1.0,
		Type  = 110,
		Color = 46,
		ShowBlip = true,
	  	ShowMarker = true,
		Label = 'Weapon Shop',
		ShopType = 'shop',
		ReqJob = {'police', 'ambulance'}
	},

	pawn = {
		Pos = {
			vector3(53.27,-1479.13,29.28)
		},
		Size  = 1.0,
		Type  = 59,
		Color = 28,
		ShowBlip = true,
		ShowMarker = true,
		Label = 'Pawn Shop',
		ShopType = 'shop',
		ReqJob = {'police', 'ambulance'}
	},
	police = {
		Pos = {
			vector3(417.09, -1012.57, 29.24)
		},
		Size  = 1.0,
		Type  = 93,
		Color = 27,
		ShowBlip = true,
		ShowMarker = true,
		Label = 'Police Crafting',
		ShopType = 'crafting',
		ReqJob = {'police', 'ambulance'}
	},
}
