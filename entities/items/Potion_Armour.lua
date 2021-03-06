-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "potion_armour"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/items/provisions/potions/life_potion.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Armour Potion"

-- The description for this item, used in the inventory menu.
ITEM.Description = "Boosts your armour"

ITEM.Price = 23
local price = 23

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.Drink = true

ITEM.PriestSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Potion = ents.Create( "Armour Potion" )
		Potion:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Potion:Spawn( )
		Potion:Activate( )
	end

	function ITEM:DRINK( ply )
		if ply:GetNWInt("wearingarmour") == 1 then
			ply:SetNWInt("armour", ply:GetNWInt("maxarmour"))
		else
			if ply:GetNWInt("armour") == 0 then
				local armouradd = math.random(50, 70)
				ply:SetNWInt("armour", armouradd)
				ply:SetNWInt("maxarmour", armouradd)
			else
				return
			end
		end
		ply:PrintMessage(HUD_PRINTTALK, "You drank an Armour Potion.")
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