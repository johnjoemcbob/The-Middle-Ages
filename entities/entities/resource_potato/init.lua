AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_phx/misc/potato.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local ply = self.Entity:GetNWEntity("owning_ent")
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Use( activator, caller )
	if ( !activator:IsPlayer() ) then return false end

	if (activator:GetWeapon("backpack") == activator:GetActiveWeapon()) then
		activator:GiveItem( "potato", 1 )
		self:Remove()
		ShowTipPlayer(activator, 0, 4, "Picked up a Potato." )
	else
		EatFood(activator, 40)
		self.Entity:Remove()
	end
end 