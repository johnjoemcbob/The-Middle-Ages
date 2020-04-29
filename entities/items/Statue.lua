-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "statue"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/props_c17/gravestone_statue001a.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Statue"

-- The description for this item, used in the inventory menu.
ITEM.Description = "Statue"

ITEM.Price = 50
local price = 50

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.CraftsmanSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Statue = ents.Create( "craft_statue" )
		Statue:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Statue:Spawn( )
		Statue:Activate( )
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