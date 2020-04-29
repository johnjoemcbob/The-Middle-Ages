-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "fish_gold_cooked"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/props/de_inferno/GoldFish.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Cooked Gold Fish"

-- The description for this item, used in the inventory menu.
ITEM.Description = "A Cooked Gold Fish"

ITEM.Price = 34
local price = 34

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.Edible = true

ITEM.CookSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Fish = ents.Create( "food_fish_gold" )
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