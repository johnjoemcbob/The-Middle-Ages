AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/nayrbarr/iron/iron.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
	self.Entity:SetNetworkedString("Owner", "Shared")
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end
	timer.Create( "scarebox"..math.random(1,100000), 30, 0, function()
		self.Entity:Playsound()
	end )
end

function ENT:Playsound()
	if math.random(1, 2) == 1 then
		self:EmitSound("box1.wav")
	else
		self:EmitSound("box2.wav")
	end
end 