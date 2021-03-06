-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "ring_emerald"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/props/de_inferno/wall_lamp_ring.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Emerald Ring"

-- The description for this item, used in the inventory menu.
ITEM.Description = "An Emerald Ring is Enchanted to make you jump high, but it also makes you slower."

ITEM.Price = 70
local price = 70

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.CraftsmanSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Ring = ents.Create( "craft_ring_emerald" )
		Ring:SetModel( "models/props/de_inferno/wall_lamp_ring.mdl" )
		Ring:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Ring:Spawn( )
		Ring:Activate( )
		ply:SetNWInt("wearingemeraldring", 0)
		InventoryAddon:SendMessage( "You took your Emerald Ring off.", ply, false )
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