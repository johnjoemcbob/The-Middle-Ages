-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "fish_basslet"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/props/prop_grammabasslet.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Gramma Basslet"

-- The description for this item, used in the inventory menu.
ITEM.Description = "A Fresh Gramma Basslet Fish"

ITEM.Price = 23
local price = 23

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.Edible = true

ITEM.FisherSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Fish = ents.Create( "fish_basslet" )
		Fish:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Fish:Spawn( )
		Fish:Activate( )
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