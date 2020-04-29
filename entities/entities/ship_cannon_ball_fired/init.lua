AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

function ENT:SpawnFunction(ply, tr)
	if not tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal*16
	local ent = ents.Create("ship_cannon_ball_fired")
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self.Damage = 100 -- How much damage the cannon ball does

	self.Entity:SetModel("models/props/de_inferno/crate_fruit_break_gib2.mdl")
	self.Entity:SetColor( 0, 0, 0, 255 )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)	
	self.Entity:SetSolid(SOLID_VPHYSICS)

	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:PhysicsCollide(data, physobj)
	self.NearCannon = false
	for k,v in pairs(ents.FindInSphere(self.Entity:GetPos(),512)) do
		if v:GetClass() == "ship_cannon" then
			self.NearCannon = true
		end
	end

	if self.NearCannon == true then else
		for k,v in pairs(ents.FindInSphere(self.Entity:GetPos(),512)) do
			v:TakeDamage( self.Damage )
		end

		local explosion = ents.Create("env_explosion")
		explosion:SetKeyValue("spawnflags",128)
		explosion:SetPos(self.Entity:GetPos())
		explosion:Spawn()
		explosion:Fire("explode","",0)

		local explosion = ents.Create("env_physexplosion")
		explosion:SetKeyValue("magnitude",250)
		explosion:SetPos(self.Entity:GetPos())
		explosion:Spawn()
		explosion:Fire("explode","",0)
	end
	self.Entity:Remove()
end

function ENT:KickBall(fmul)
	self:GetPhysicsObject():SetVelocity( (self:GetForward() * 800) * fmul)
end 