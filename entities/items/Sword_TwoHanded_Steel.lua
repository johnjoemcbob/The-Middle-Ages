-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "sword_twohanded_steel"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/weapons/w_sword_silver.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Steel Two-Handed Sword"

ITEM.Price = 180
local price = 180

-- The description for this item, used in the inventory menu.
ITEM.Description = "A Two-Handed Steel Sword"

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.Equipable = true

ITEM.SmithSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Aria = ents.Create( "ent_sword_twohanded_steel" )
		Aria:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Aria:Spawn( )
		Aria:Activate( )
	end

	function ITEM:SELL( ply )
		GiveGold( ply, "gold", price )
	end

	function ITEM:BUY( ply )
		TakeGold( ply, "gold", price )
	end

	function ITEM:EQUIP( ply )
		ply:Give("sword_twohanded_steel")
	end
end

-- Register the item so it exists in the main stuff.
InventoryAddon:RegisterItem( ITEM )