AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/door.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
	self.Entity:SetNetworkedString("Owner", "Shared")
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Touch(ent)
	if ent:IsPlayer() and ent:GetNWInt("nexttravel") < CurTime() then
		if self.AppearPos then
			ent:SetPos(self.AppearPos)
			ent:SetNWInt("nexttravel", CurTime() + 1)
		end
	end
end 