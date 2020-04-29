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
		activator:GiveItem( "potion", 1 )
		self:Remove()
		InventoryAddon:SendMessage( "Picked up a Potion.", activator, false )
	else
		local hp = activator:Health()
		hp = hp + 75
		if (hp >= ply:GetNWInt("maxhealth")) then hp = ply:GetNWInt("maxhealth") end
		activator:SetHealth(hp)
		activator:PrintMessage(HUD_PRINTTALK, "You used a Health Potion")
		self.Entity:Remove()
	end
end 