AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)
	local SpawnPos = tr.HitPos
	local ent = ents.Create( "ship_cannon" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
end

function ENT:Initialize()
	self.Entity:SetUseType( SIMPLE_USE )

	self.Loaded = true
	self.Entity:SetModel("models/cannon.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(1)
	end
	self.Entity:StartMotionController()
end

function ENT:Use(ply,caller)
	if ply:GetWeapon("backpack") == ply:GetActiveWeapon() and self.Entity:GetNWString("entowner") == ply then
		umsg.Start("ConfirmCannonPickUp", ply)
		umsg.End()
	elseif self.Loaded == true then
		local vShootPos = self.Entity:GetPos()
		local vShootAng = self.Entity:GetAngles()-Vector(10, 90, 0)
		local ball = ents.Create("ship_cannon_ball_fired")
		ball:SetPos(vShootPos)
		ball:Spawn()
		ball:SetAngles(vShootAng)
		ball:GetPhysicsObject():SetMass( 250 )
		ball:KickBall( 2, 1 )
		self.Loaded = false
	end
end

function ENT:Touch(hitEnt)
	if hitEnt:GetClass() == "ship_cannon_ball" and not self.Loaded == true then
		self.Loaded = true
		hitEnt:Remove()
	end
end 