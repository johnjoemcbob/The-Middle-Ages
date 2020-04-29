-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "ship"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/ship.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Ship"

-- The description for this item, used in the inventory menu.
ITEM.Description = "Your very own ship!"

ITEM.Price = 10000
local price = 10000

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.FisherSellable = true

-- The Drop item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply ) -- Drop the item
		local tr = ply:EyeTrace( 80 )
		local Ship = ents.Create( "ship" )
		Ship:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Ship:Spawn()
		Ship:Activate()
		Ship:SetNWString("entowner", ply)

		if game.GetMap() == "gm_flatgrass2008" then
			indock = false
			qtaken = false
			wtaken = false
			etaken = false
			rtaken = false
			eqtaken = false
			ewtaken = false
			eetaken = false

			local race = ply:GetNWString("race")
			if race == "Human" or race == "Dwarf" or race == "Gnome" or race == "Blood Elf" or race == "Night Elf" or race == "Dark Elf" then
				local foundents = ents.FindInSphere(Vector(6850.2397460938, 6771.4204101563, 101.05168914795), 100)
				for k,v in pairs(foundents) do
					if v then
						qtaken = true
					end
				end
				if not qtaken == true then
					Ship:SetPos(Vector(6850.2397460938, 6771.4204101563, 101.05168914795))
					Ship:SetAngles(Vector(1.9272771169199e-005, 134.99992370605, 4.4250955397729e-005))
					indock = true
				end

				local foundents = ents.FindInSphere(Vector(8174.9790039063, 4556.720703125, 101.0517578125), 100)
				for k,v in pairs(foundents) do
					if v then
						wtaken = true
					end
				end
				if not wtaken == true then
					Ship:SetPos(Vector(8174.9790039063, 4556.720703125, 101.0517578125))
					Ship:SetAngles(Vector(1.9272771169199e-005, -151.96000671387, 4.2149851651629e-005))
					indock = true
				end

				local foundents = ents.FindInSphere(Vector(7480.6069335938, 5630.5708007813, 101.05151367188), 100)
				for k,v in pairs(foundents) do
					if v then
						etaken = true
					end
				end
				if not etaken == true then
					Ship:SetPos(Vector(7480.6069335938, 5630.5708007813, 101.05151367188))
					Ship:SetAngles(Vector(1.9272772988188e-005, -144.25997924805, 4.2149851651629e-005))
					indock = true
				end

				local foundents = ents.FindInSphere(Vector(7480.6069335938, 5630.5708007813, 101.05151367188), 100)
				for k,v in pairs(foundents) do
					if v then
						rtaken = true
					end
				end
				if not rtaken == true then
					Ship:SetPos(Vector(6015.44921875, 7192.16015625, 101.05163574219))
					Ship:SetAngles(Vector(1.9272772988188e-005, -130.17997741699, 4.2149851651629e-005))
					indock = true
				end
			else
				local foundents = ents.FindInSphere(Vector(-8205.396484375, -4552.5556640625, 101.0517578125), 100)
				for k,v in pairs(foundents) do
					if v then
						eqtaken = true
					end
				end
				if not eqtaken == true then
					Ship:SetPos(Vector(-8205.396484375, -4552.5556640625, 101.0517578125))
					Ship:SetAngles(Vector(1.9272771169199e-005, -151.29971313477, 4.2149851651629e-005))
					indock = true
				end

				local foundents = ents.FindInSphere(Vector(-9377.6611328125, -613.44091796875, 101.05200195313), 100)
				for k,v in pairs(foundents) do
					if v then
						ewtaken = true
					end
				end
				if not ewtaken == true then
					Ship:SetPos(Vector(-9377.6611328125, -613.44091796875, 101.05200195313))
					Ship:SetAngles(Vector(1.9272771169199e-005, -176.59982299805, 4.2149851651629e-005))
					indock = true
				end

				local foundents = ents.FindInSphere(Vector(-9061.71875, -2412.7858886719, 101.05200195313), 100)
				for k,v in pairs(foundents) do
					if v then
						eetaken = true
					end
				end
				if not eetaken == true then
					Ship:SetPos(Vector(-9061.71875, -2412.7858886719, 101.05200195313))
					Ship:SetAngles(Vector(1.9272772988188e-005, -164.7198638916, 4.2149851651629e-005))
					indock = true
				end
			end

			if not indock == true then
				ply:GiveItem( "Ship", 1 )
				Ship:Remove()
				ply:PrintMessage( HUD_PRINTTALK, "There is no room in the docks at the moment." )
			end
		end
	end

	function ITEM:SELL( ply )
		GiveGold( ply, "gold", price )
	end

	function ITEM:BUY( ply )
		TakeGold( ply, "gold", price )
	end
end

-- Register the item so it exists in the main stuff.
InventoryAddon:RegisterItem( ITEM )