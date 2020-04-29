AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_combine/breentp_rings.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self.Entity:SetNetworkedString("Owner", "Shared")
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Think()
	local foundents = ents.FindInSphere(self.Entity:GetPos(),70)
	for k, ent in pairs(foundents) do
		if ent:IsPlayer() and ent:GetNWInt("portal1x") and ent:GetNWInt("nextport") < CurTime() then
			local xx = ent:GetNWInt("portal1x")
			local yy = ent:GetNWInt("portal1y")
			local zz = ent:GetNWInt("portal1z")
			if xx == 0 and yy == 0 and zz == 0 then return end
			ent:SetPos(Vector(xx, yy, zz))
			ent:SetNWInt("nextport", CurTime() + 5)
		end
	end

	owner = nil
	for k, v in pairs(player.GetAll()) do
		if self.Entity:GetNWString("entowner") == v then
			owner = true
		end
	end
	if owner == true then else
		self.Entity:Remove()
	end
end 