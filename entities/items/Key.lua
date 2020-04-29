-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "key"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/nayrbarr/Key/key.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Key"

-- The description for this item, used in the inventory menu.
ITEM.Description = "A Key"

-- The description for this item, used in the inventory menu.
ITEM.SellPrice = sellprice

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

-- The Drop item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply ) -- Drop the item
		local tr = ply:EyeTrace( 80 )
		local Key = ents.Create( "quest_key2" )
		Key:SetModel( "models/nayrbarr/Key/key.mdl" )
		Key:SetNWInt("keynumber", ply:GetNWInt("keycode"))
		Key:SetNWInt("keyname", ply:GetNWInt("keyname"))
		ply:SetNWInt("keycode", 0)
		Key:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Key:Spawn( )
		Key:Activate( )
	end
end

-- Register the item so it exists in the main stuff.
InventoryAddon:RegisterItem( ITEM )