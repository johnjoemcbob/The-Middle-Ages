AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/items/provisions/potions/life_potion.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end

end

function ENT:Use(activator,caller)
	if (activator:GetWeapon("backpack") == activator:GetActiveWeapon()) then
		activator:GiveItem( "poison", 1 )
		self:Remove()
		InventoryAddon:SendMessage( "Picked up some Poison.", activator, false )
	else
		local hp = activator:Health()
		hp = hp - 99
		if (hp <= 0) then hp = 1 end
		activator:SetHealth(hp)
		activator:PrintMessage(HUD_PRINTTALK, "You were Poisoned!  You should think about who to trust next time...")
		self.Entity:Remove()
	end
end 