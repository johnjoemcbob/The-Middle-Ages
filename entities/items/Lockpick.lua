-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "lockpick"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/props_debris/wood_splinters01c.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Lockpick"

-- The description for this item, used in the inventory menu.
ITEM.Description = "A Lockpick"

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

-- The Drop item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply ) -- Drop the item
		local tr = ply:EyeTrace( 80 )
		local Lockpick = ents.Create( "quest_lockpick" )
		Lockpick:SetModel( "models/props_debris/wood_splinters01c.mdl" )
		Lockpick:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Lockpick:Spawn( )
		Lockpick:Activate( )
	end
end

-- Register the item so it exists in the main stuff.
InventoryAddon:RegisterItem( ITEM )