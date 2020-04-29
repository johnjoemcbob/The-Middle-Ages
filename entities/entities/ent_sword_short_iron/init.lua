AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_gladius.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetNetworkedString("Owner", "Shared")
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end
end 

function ENT:Use(activator,caller)
	if ( !activator:IsPlayer() ) then return false end

	if (activator:GetWeapon("backpack") == activator:GetActiveWeapon()) then
		activator:GiveItem( "sword_short_iron", 1 )
		self:Remove()
		ShowTipPlayer(activator, 0, 4, "Picked up an Iron Short Sword." )
	else
		if activator:IsValid() then
			activator:Give("sword_short_iron")
			self.Entity:Remove()
		end
	end
end 