-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "ship_cannon"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/cannon.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Ship Cannon"

-- The description for this item, used in the inventory menu.
ITEM.Description = "A cannon, place on your ship."

ITEM.Price = 2000
local price = 2000

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.SmithSellable = true

-- The Drop item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply ) -- Drop the item
		local tr = ply:EyeTrace( 80 )
		local Ship_Cannon = ents.Create( "ship_cannon" )
		Ship_Cannon:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Ship_Cannon:Spawn()
		Ship_Cannon:Activate()
		Ship_Cannon:SetNWString("entowner", ply)
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