AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	self:SetAngles( Angle(60,0,0) )

	self.Attacking = 0
	--self.EntOwner = nil
	self.AngleOffset = math.random(0,360)
	self.LastThink = CurTime()
	self.DesiredPosition = self:GetPos()
	self.FlySpeed = 600
	self.UseKeyDown = false

	self.tracedata = {}
	self.tracedata.filter = {self}
	self.dmginfo = DamageInfo()

	self.HitSound = {
		"physics/body/body_medium_impact_hard"..math.random(1,6)..".wav",
		"physics/body/body_medium_break"..math.random(2,4)..".wav",
		"physics/flesh/flesh_bloody_break.wav",
	}
	self.LastSound = CurTime()
	self.LastHit = CurTime()
end

function ENT:SpawnFunction(ply, tr)
	if (!tr.HitWorld) then return end

	local ent = ents.Create("sent_spiritweapon")
	ent:SetPos(tr.HitPos + Vector(0, 0, 30))
	ent:Spawn()
	return ent
end

function ENT:Think()
	self:NextThink(CurTime()+0.02)

	if !self.EntOwner then return end
	if !self.EntOwner:Alive() then self:Remove() end

	local entowner = self.EntOwner

	if self:IsValid() && (self.Attacking == 0) then
		self.DesiredPosition.x = entowner:GetPos().x+math.cos(CurTime()+self.AngleOffset)*100
		self.DesiredPosition.y = entowner:GetPos().y+math.sin(CurTime()+self.AngleOffset)*100
		self.DesiredPosition.z = entowner:GetPos().z+60+math.sin(CurTime()*1.9+self.AngleOffset)*16
		if (self:GetPos():Distance(entowner:GetPos()) > 800) then self.FlySpeed = 800 else self.FlySpeed = 600 end
		self:SetAngles(self:GetAngles()+Angle(0,0,8))
	end

	if (self.UseKeyDown != entowner:KeyDown(IN_USE)) then 
		if (entowner:KeyDown(IN_USE) == true) then 
			self:OnUsePressed() 
			else self:OnUseReleased() 
		end 
	end	

	if (entowner:KeyDown(IN_USE) == true) then
		self.FlySpeed = 1500

		if (#self.EntOwner.Axes == 1) then
			self.EntOwner.Axes[1]:SetAngles( self.EntOwner:GetAimVector():Angle()+Angle(180,0,0) )
		elseif (#self.EntOwner.Axes == 2) then 
			self.EntOwner.Axes[1]:SetAngles( self.EntOwner:GetAimVector():Angle()+Angle(180,30,0) )
			self.EntOwner.Axes[2]:SetAngles( self.EntOwner:GetAimVector():Angle()+Angle(180,-30,0) )
		elseif (#self.EntOwner.Axes == 3) then
			self.EntOwner.Axes[1]:SetAngles( self.EntOwner:GetAimVector():Angle()+Angle(180,45,0) )
			self.EntOwner.Axes[2]:SetAngles( self.EntOwner:GetAimVector():Angle()+Angle(180,-45,0) )
			self.EntOwner.Axes[3]:SetAngles( self.EntOwner:GetAimVector():Angle()+Angle(180,0,0) )
		end

		if (entowner:Crouching() == false) then
			self.DesiredPosition = self.EntOwner:GetShootPos()+self.EntOwner:GetAimVector()*60-Vector(0,0,10)
		elseif (entowner:Crouching() == true) then
			self.DesiredPosition = self.EntOwner:GetShootPos()+self.EntOwner:GetAimVector()*60
		end
	end

	self.tracedata.start = self:GetPos()

	local dir = self.DesiredPosition-self:GetPos()
	local dirnorm = dir:Normalize()
	local len = self:GetPos():Distance(self.DesiredPosition)
	len = math.min(len,self.FlySpeed*(CurTime()-self.LastThink))
	self:SetPos(self:GetPos()+dir*len)

	self.tracedata.endpos = self:GetPos()
	self.tracedata.mins = self:OBBMins()
	self.tracedata.maxs = self:OBBMaxs()
	local trace = util.TraceHull( self.tracedata )

	if (entowner:KeyDown(IN_USE) == true) && trace.Entity:IsValid() then
		local vel = (self.tracedata.start-self:GetPos())/(CurTime()-self.LastThink)
		self.dmginfo:SetAttacker(self.EntOwner)
		self.dmginfo:SetInflictor(self)
		self.dmginfo:SetDamageType(DMG_SLASH)
		if (vel:Length() >= 300) then
			if trace.Entity == self.EntOwner then
				self.dmginfo:SetDamage(0)
			else
				self.dmginfo:SetDamage( math.Round(math.pow(vel:Length()/675,2)*2) )
			end
		else
			self.dmginfo:SetDamage(0)
		end
		self.dmginfo:SetDamageForce(vel/2)

		if self.LastHit + 0.30 < CurTime() then
			trace.Entity:TakeDamageInfo(self.dmginfo)
			self.LastHit = CurTime()
		end

		if self.LastSound + 0.30 < CurTime() then 	
			if (vel:Length() >= 100) && (vel:Length() < 300) then
				self:EmitSound("physics/body/body_medium_impact_soft"..math.random(1,7)..".wav")
			elseif (vel:Length() >= 300) then
				self:EmitSound( self.HitSound[math.random(1,3)] )
			end
			self.LastSound = CurTime()
		end
	end

	self.UseKeyDown = entowner:KeyDown(IN_USE)
	self.LastThink = CurTime()

	if (trace.HitNonWorld) then
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Entity:AddExp( 1 )
		end
	end

	return true
end

function ENT:AddExp( amount )
	local oldmexp = self.EntOwner:GetNWInt("magicexp")
	MagicLevelData[ self.EntOwner:UniqueID() ][ "Magicexp" ] = oldmexp + amount
	self.EntOwner:SetNWInt( "Magicexp", oldmexp + amount)

	if self.EntOwner:GetNWInt("Magicexp") > 99 then
		local oldmexp = self.EntOwner:GetNWInt("Magicexp")
		local oldmlevel = self.EntOwner:GetNWInt("Magiclevel")
		MagicLevelData[ self.EntOwner:UniqueID() ][ "Magicexp" ] = oldmexp - 100
		self.EntOwner:SetNWInt( "Magicexp", oldmexp - 100)

		MagicLevelData[ self.EntOwner:UniqueID() ][ "Magiclevel" ] = oldmlevel + 1
		self.EntOwner:SetNWInt( "Magiclevel", oldmlevel + 1)
		newlevel = oldmlevel + 1
		self.EntOwner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Magic!")
	end
end

function ENT:OnUsePressed()
	if (self.Attacking == 0) then
		self.Attacking = 1
	end
end

function ENT:OnUseReleased()
	if (self.Attacking == 1) then
		self.Attacking = 0
	end

	self:SetAngles( Angle(60,0,0) )
end

function ENT:OnRemove()
	self.Attacking = 0
	self:SetOwner("")

	for k,v in ipairs(self.EntOwner.Axes) do 
		if (v == self) then 
			table.remove(self.EntOwner.Axes,k)
			break 
		end 
	end
end

local function CanPhysgun( userid, Ent )
	if Ent:GetClass() == "sent_spiritweapon" then return false end
end
hook.Add( "PhysgunPickup", "CanPhysgun", CanPhysgun );

local function SpawnAxes(ply,ent)
	if ent.EntOwner == nil && ent:GetClass() == "sent_spiritweapon" then
		ent.EntOwner = ply
		ent:SetOwner(ply)
		table.insert(ent.tracedata.filter,ply)
	end

	if ent:GetClass() == "sent_spiritweapon" && !ent.EntOwner.Axes then
		ent.EntOwner.Axes = {ent} 
	elseif ent:GetClass() == "sent_spiritweapon" && ent.EntOwner.Axes then
		table.insert(ent.EntOwner.Axes,ent)
	end
end
hook.Add( "PlayerSpawnedSENT", "SpawnAxes", SpawnAxes )

local function RemoveDCAxes( ply )
	if ply.Axes then for k,v in ipairs(ply.Axes) do v:Remove() end end
end
hook.Add( "PlayerDisconnected", "playerdisconnected", RemoveDCAxes ) 