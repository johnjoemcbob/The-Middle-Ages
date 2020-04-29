AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel( "models/props/de_inferno/GoldFish.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Use( activator, caller )
	if (activator:GetWeapon("backpack") == activator:GetActiveWeapon()) then
		activator:GiveItem( "fish_gold", 1 )
		self:Remove()
		ShowTipPlayer(activator, 0, 4, "Picked up a Gold Fish." )
	else
		EatFood(activator, 40)
		self.Entity:Remove()
	end
end 