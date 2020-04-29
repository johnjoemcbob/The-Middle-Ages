AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)
	local SpawnPos = tr.HitPos
	local ent = ents.Create( "ship_cannon_ball" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self.Entity:SetUseType( SIMPLE_USE )

	self.Entity:SetModel("models/props/de_inferno/crate_fruit_break_gib2.mdl")
	self.Entity:SetColor( 0, 0, 0, 255 )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(8)
	end
	self.Entity:StartMotionController()
end

function ENT:Use( activator, caller )
	if ( !activator:IsPlayer() ) then return false end

	if (activator:GetWeapon("backpack") == activator:GetActiveWeapon()) then
		activator:GiveItem( "ship_cannon_ball", 1 )
		self:Remove()
		ShowTipPlayer(activator, 0, 4, "Picked up a Cannon Ball." )
	end
end 