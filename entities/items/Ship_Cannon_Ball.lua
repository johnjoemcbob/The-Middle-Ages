-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "ship_cannon_ball"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/props/de_inferno/crate_fruit_break_gib2.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Ship Cannon Ball"

-- The description for this item, used in the inventory menu.
ITEM.Description = "A cannon ball, for your cannons."

ITEM.Price = 3
local price = 3

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.SmithSellable = true

-- The Drop item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply ) -- Drop the item
		local tr = ply:EyeTrace( 80 )
		local Ship_Cannon = ents.Create( "ship_cannon_ball" )
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