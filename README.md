# esx_shops
## ESX_Shops Modified to work with MF_Inventory

# UPDATE v2

Replaced basically the entire client file with all the new code. Added new config options. Markers are now specific to a shop, instead of general markers. Added the notification system in config, making it easier for people.


# UPDATE
I have added job checks, and Shop Type so you can do crafting tables, and shops, both with job checks if you want. See photos below for more details.

![ShopsNewConfig](https://i.imgur.com/9HIZjk4.png)

**ShopType has to be either 'shop' or 'crafting'**

**If you want your new shop/crafting table to require a job

Make sure you have you have your jobs surrounded with {}, even if it's only 1 job. ex. {'police'}, or {'police', 'ambulance', 'lawyer'}.

You can have as many jobs as you want within the ReqJobs { }. If you do **NOT** want a job requirement, then delete the entire ReqJob line from the config.

See below additional photo on making sure your crafting table comes up.


### Instructions
1) Drag and drop ESX_Shops into your resource folder.
2) Add `ensure esx_shops` to your server.cfg


### Photo guide for those who don't understand the config notes.
Make sure **THIS**

![ShopsConfig](https://i.imgur.com/sXwQJYW.png)


Matches **THIS**

![MFShops](https://i.imgur.com/IfyHbOS.png)

OR **THIS**

![MFCrafting](https://i.imgur.com/ETszo2S.png)

## Notes

**This is not a working standalone shop. This is merely a base to trigger MF_Inventory built-in shop system. Check out https://modit.store/products/mf-inventory for more information**


There is no limit to how many shops you have in esx_shops as long as you have a matching counterpart in MF_Inventory. If you add a shop location in esx_shops and forget to add it in MF_Inventory, you will have a marker that does nothing. If you add a shop within MF_Inventory, but forget to add it to esx_shops, there will be no marker for you to activate.
