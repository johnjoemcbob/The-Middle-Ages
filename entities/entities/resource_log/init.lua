AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/medieval/lumbers/lumber.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
	self.Entity:SetNetworkedString("Owner", "Shared")
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Use( activator, caller )
	if ( !activator:IsPlayer() ) then return false end

	activator:GiveItem( "wood", 1 )
	self:Remove()
	ShowTipPlayer(activator, 0, 4, "Picked up a Log." )
end 