AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local Ent = ents.Create( "portal" )
	Ent:SetPos( SpawnPos )
	Ent:Spawn()
	Ent:Activate()
	return Ent
end

function ENT:Initialize() 
	self.Entity:SetModel( "models/Effects/combineball.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )

	local phys = self.Entity:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
end

function ENT:Think()
	local foundents = ents.FindInSphere(self.Entity:GetPos(),30)
	for k, ent in pairs(foundents) do
		if ent:IsPlayer() and ent:GetNWInt("nextport") < CurTime() and self.AppearPos then
			if ent:SteamID() == "STEAM_0:1:18098051" or ent:SteamID() == "STEAM_0:1:18460035" or ent.TowerClearance == 1 then
				ent:SetPos(self.AppearPos)
				ent:SetNWInt("nexttravel", CurTime() + 1)
			end
		end
	end
end 