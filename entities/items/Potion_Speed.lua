-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "potion_speed"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/items/provisions/potions/life_potion.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Speed Potion"

-- The description for this item, used in the inventory menu.
ITEM.Description = "Some Speed Potion"

ITEM.Price = 21
local price = 21

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.Drink = true

ITEM.PriestSellable = true

-- The USE item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local SpeedPotion = ents.Create( "Potion_Speed" )
		SpeedPotion:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		SpeedPotion:Spawn( )
		SpeedPotion:Activate( )
	end

	function ITEM:DRINK( ply )
		ws = 350
		rs = 450
		ply:SetWalkSpeed(ws)
		ply:SetRunSpeed(rs)
		ply:PrintMessage(HUD_PRINTTALK, "You used a Speed Potion")	
		self.Entity:Remove()
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