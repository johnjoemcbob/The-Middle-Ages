-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "uncutemerald"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/props_junk/Rock001a.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Uncut Emerald"

-- The description for this item, used in the inventory menu.
ITEM.Description = "Uncut Emerald"

ITEM.Price = 7
local price = 7

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.LabourerSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local UncutEmerald = ents.Create( "resource_emerald_uncut" )
		UncutEmerald:SetModel( "models/props_junk/Rock001a.mdl" )
		UncutEmerald:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		UncutEmerald:Spawn( )
		UncutEmerald:Activate( )
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