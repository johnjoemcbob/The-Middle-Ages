AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent = ents.Create("fishing_rod")
	ent:SetPos(tr.HitPos + Vector(0,0,8))
	ent:Spawn()
	ent:Activate()
	ent:SetName("Fishing Rod")
	return ent
end

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/harpoon002a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(100)
	end
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:StartTouch( ent )
	if ( ent:GetClass() == "fishing_hook" and self.HasHook == nil and ent.IsAttached == nil) then		
		self.constraint, self.rope = constraint.Rope( self.Entity, ent, 0, 0, Vector(36,4,0), Vector(0,4,21), 0, 160, 0, 0.1, "cable/rope", nil )
 		ent.IsAttached = true
		ent.Rod = self
 		self.HasHook = true
 		self.Hook = ent
	end
end

function ENT:Think()
	self.Entity:NextThink(CurTime() + 1) -- Think only once a second instead of once per tick.
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