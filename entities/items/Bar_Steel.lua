-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "bar_steel"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/nayrbarr/iron/iron.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Steel Bar"

ITEM.Price = 28
local price = 28

-- The description for this item, used in the inventory menu.
ITEM.Description = "Steel Bar"

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.SmithSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local SteelBar = ents.Create( "bar_steel" )
		SteelBar:SetModel( "models/nayrbarr/iron/iron.mdl" )
		SteelBar:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		SteelBar:Spawn( )
		SteelBar:Activate( )
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