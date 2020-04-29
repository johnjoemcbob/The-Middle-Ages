-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "maw_axe"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/weapons/w_axe.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Axe"

-- The description for this item, used in the inventory menu.
ITEM.Description = "An Axe"

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.Equipable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Axe = ents.Create( "ent_axe" )
		Axe:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Axe:Spawn( )
		Axe:Activate( )
	end

	function ITEM:EQUIP( ply )
		ply:Give("axe")
	end
end

-- Register the item so it exists in the main stuff.
InventoryAddon:RegisterItem( ITEM )