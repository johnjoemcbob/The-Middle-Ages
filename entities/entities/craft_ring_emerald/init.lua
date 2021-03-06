AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props/de_inferno/wall_lamp_ring.mdl")
	self.Entity:SetColor( 12, 255, 0, 255)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetNetworkedString("Owner", "Shared")
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Use( activator, caller )
	if ( !activator:IsPlayer() ) then return false end

	if (activator:GetWeapon("backpack") == activator:GetActiveWeapon()) then
		if activator:GetNWInt("wearingemeraldring") == 0 then
			activator:GiveItem( "ring_emerald", 1 )
			self:Remove()
			ShowTipPlayer(activator, 0, 4, "You put an Emerald Ring on." )
			activator:SetNWInt("wearingemeraldring", 1)
		else
			ShowTipPlayer(activator, 0, 4, "You can only wear one Emerald Ring at once." )
		end
	end
end 