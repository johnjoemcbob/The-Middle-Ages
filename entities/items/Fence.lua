-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "fence"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/props_wasteland/wood_fence01a.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Fence"

-- The description for this item, used in the inventory menu.
ITEM.Description = "Fence"

ITEM.Price = 10
local price = 10

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.CraftsmanSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Fence = ents.Create( "craft_fence" )
		Fence:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Fence:Spawn( )
		Fence:Activate( )
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