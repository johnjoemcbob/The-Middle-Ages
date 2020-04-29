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

	if not self.SoundLength then
		self.SoundLength = 13.65440
	end

	if phys and phys:IsValid() then phys:Wake() end
	timer.Create( "Soundbox "..math.random(1,100000), self.SoundLength, 0, function()
		if self.Sound then
			self:EmitSound(self.Sound)
		else
			self:EmitSound("ambient/Tavern.wav")
		end
	end )
end 