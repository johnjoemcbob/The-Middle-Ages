AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)
	local SpawnPos = tr.HitPos
	local ent = ents.Create( "ship" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self.Entity:SetUseType( SIMPLE_USE )

	self.Inflight = false
	self.Pilot = nil
	self.Entity:SetModel("models/ship.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(10000)
	end
	self.Entity:StartMotionController()
	self.Accel = 0

	self.Entity:GetPhysicsObject():EnableMotion(false)
end

function ENT:DoKill()
	if self.Pilot then
		self.Pilot:UnSpectate()
		self.Pilot:DrawViewModel(true)
		self.Pilot:DrawWorldModel(true)
		self.Pilot:Spawn()
		self.Pilot:SetNetworkedBool("isDriveShuttle", false)
	end
end

function ENT:OnTakeDamage(dmg)
	if self.Inflight then
		if self.Pilot != nil then
			self.Pilot:TakeDamage(dmginfo:GetDamage()/3, dmginfo:GetAttacker())
		end
	end
end

function ENT:OnRemove()
	self.Entity:DoKill()
end

function ENT:Think()
	if not ValidEntity(self.Pilot) then self.Pilot = nil self.Inflight = false end

	if self.Pilot then
		self.Pilot:SetPos( self:GetPos() - self.PilotOffset )
	end

	if game.GetMap() == "gm_flatgrass2008" then
		self.Entity:SetPos(Vector(self.Entity:GetPos().x, self.Entity:GetPos().y, 102.24243164063))
	elseif game.GetMap() == "gm_buildgrass" then
		self.Entity:SetPos(Vector(self.Entity:GetPos().x, self.Entity:GetPos().y, 870.29022216797))
	elseif game.GetMap() == "rp_ye_old_islands_alpha" then
		self.Entity:SetPos(Vector(self.Entity:GetPos().x, self.Entity:GetPos().y, -151.52140808105))
	end

	self.Entity:SetAngles(Vector(0, self.Entity:GetAngles().y, 0))

	if self.Inflight and self.Pilot and self.Pilot:IsValid() then
		self.Pilot:SetPos(self.Entity:GetPos())
		if self.Pilot:KeyDown(IN_USE) then
			self.Pilot:SetNetworkedBool("isDriveShuttle",false)
			self.Pilot:SetMoveType( MOVETYPE_WALK )
			self.Entity:GetPhysicsObject():EnableMotion(false)

			self.Accel = 0
			self.Inflight = false
			self.Entity:SetLocalVelocity(Vector(0, 0, 0))

			self.Pilot:UnSpectate()
			self.Pilot:DrawViewModel(true)
			self.Pilot:DrawWorldModel(true)
			self.Pilot:Spawn()
			self.Pilot:SetPos( self:GetPos() - self.PilotOffset )
			self.Pilot = nil
			self.PilotOffset = nil
		end	
		self.Entity:NextThink(CurTime())
	else
		self.Entity:NextThink(CurTime() + 1)
	end
	return true
end

function ENT:Use(ply,caller)
	if not self.Pilot and ply:GetWeapon("backpack") == ply:GetActiveWeapon() and self.Entity:GetNWString("entowner") == ply then
		umsg.Start("ConfirmShipPickUp", ply)
		umsg.End()
	elseif not self.Inflight and self.Entity:GetNWString("entowner") == ply then
		umsg.Start("ConfirmShipEnter", ply)
		umsg.End()
	elseif not self.Entity:GetNWString("entowner") == ply then
		self.Entity:GetNWString("entowner"):SetNWString("comeaboard", ply)
		self.Entity:GetNWString("entowner"):SetNWString("comeaboardname", ply:Nick())
		umsg.Start("ConfirmShipComeaboard", self.Entity:GetNWString("entowner"))
		umsg.End()
	end
end

function ENT:PhysicsSimulate( phys, deltatime )
	if self.Inflight then
		local num = 0
		if self.Pilot:KeyDown(IN_FORWARD) then
			num = -350
		elseif self.Pilot:KeyDown(IN_BACK) then
			num = 350
		end
		if self.Pilot:KeyDown(IN_SPEED) then else
			self.Entity:SetAngles(Vector( 0, self.Pilot:GetAimVector():Angle().y - 90, 0 ))
		end
		phys:Wake()
		self.Accel = math.Approach(self.Accel, num, 10)

		local pr = {}
			pr.secondstoarrive	= 1
			pr.pos				= self.Entity:GetPos() + self.Entity:GetRight() * self.Accel
			pr.maxangular		= 5000
			pr.maxangulardamp	= 10000
			pr.maxspeed			= 100000
			pr.maxspeeddamp		= 10000
			pr.dampfactor		= 0.8
			pr.teleportdistance	= 5000
			pr.angle			= self.Entity:GetAngles()
			pr.deltatime		= deltatime
		phys:ComputeShadowControl(pr)
	else
		self.Entity:SetAngles(Vector( 0, self.Entity:GetAngles().y, 0 ))
	end
end 