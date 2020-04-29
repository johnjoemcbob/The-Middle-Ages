AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/Rock001a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetColor(242,203,146,255)
	self.Entity:SetMaterial("models/debug/debugwhite")
	local ply = self.Entity:GetNWEntity("owning_ent")
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end

end

function ENT:Use( activator, caller )
	if ( !activator:IsPlayer() ) then return false end

	if (activator:GetWeapon("backpack") == activator:GetActiveWeapon()) then
		activator:GiveItem( "dough", 1 )
		self:Remove()
		ShowTipPlayer(activator, 0, 4, "Picked up some Dough." )
	end
end 