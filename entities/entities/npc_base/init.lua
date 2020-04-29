AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

Vo = {}
Vo.Zombie_D = {"npc/zombie/zombie_die1.wav",
"npc/zombie/zombie_die2.wav",
"npc/zombie/zombie_die3.wav",
"npc/zombie/zombie_voice_idle6.wav",
"npc/zombie/zombie_voice_idle11.wav"}

Vo.Zombie_P = {"npc/zombie/zombie_pain1.wav",
"npc/zombie/zombie_pain2.wav",
"npc/zombie/zombie_pain3.wav",
"npc/zombie/zombie_pain4.wav",
"npc/zombie/zombie_pain5.wav",
"npc/zombie/zombie_pain6.wav"}

Vo.Zombie_T = {"npc/zombie/zombie_voice_idle1.wav",
"npc/zombie/zombie_voice_idle2.wav",
"npc/zombie/zombie_voice_idle3.wav",
"npc/zombie/zombie_voice_idle4.wav",
"npc/zombie/zombie_voice_idle5.wav",
"npc/zombie/zombie_voice_idle7.wav",
"npc/zombie/zombie_voice_idle8.wav",
"npc/zombie/zombie_voice_idle9.wav",
"npc/zombie/zombie_voice_idle10.wav",
"npc/zombie/zombie_voice_idle12.wav",
"npc/zombie/zombie_voice_idle13.wav",
"npc/zombie/zombie_voice_idle14.wav"}

Vo.Poison_D = {"npc/zombie_poison/pz_die1.wav",
"npc/zombie_poison/pz_die2.wav",
"npc/zombie_poison/pz_idle2.wav",
"npc/zombie_poison/pz_warn2.wav"}

Vo.Poison_P = {"npc/zombie_poison/pz_idle3.wav",
"npc/zombie_poison/pz_idle4.wav",
"npc/zombie_poison/pz_pain1.wav",
"npc/zombie_poison/pz_pain2.wav",
"npc/zombie_poison/pz_pain3.wav",
"npc/zombie_poison/pz_warn1.wav"}

Vo.Poison_T = {"npc/zombie_poison/pz_alert1.wav",
"npc/zombie_poison/pz_alert2.wav",
"npc/zombie_poison/pz_call1.wav",
"npc/zombie_poison/pz_throw2.wav",
"npc/zombie_poison/pz_throw3.wav"}

Vo.Fast_D = {"npc/fast_zombie/fz_alert_close1.wav",
"npc/fast_zombie/fz_alert_far1.wav"}

Vo.Fast_P = {"npc/fast_zombie/wake1.wav",
"npc/headcrab_poison/ph_poisonbite2.wav",
"npc/headcrab_poison/ph_hiss1.wav",
"npc/headcrab_poison/ph_idle1.wav"}

Vo.Fast_T = {"npc/fast_zombie/fz_frenzy1.wav",
"npc/fast_zombie/fz_frenzy1.wav",
"npc/barnacle/barnacle_bark1.wav",
"npc/barnacle/barnacle_pull1.wav"}

Vo.Claw = {"npc/zombie/claw_strike1.wav",
"npc/zombie/claw_strike2.wav",
"npc/zombie/claw_strike3.wav"}

for k,v in pairs(Vo) do
	for c,d in pairs(Vo[k]) do
		util.PrecacheSound(d)
	end
end

function ChooseRandom(tablename)
return tablename[math.random(1,table.Count(tablename))] end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	
	local ent = ents.Create( "npc_base" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self:SetModel( "models/zombie/classic.mdl" )
	util.PrecacheSound("npc/zombie/zo_attack2.wav")
	
	self:SetHullType( HULL_HUMAN );
	self:SetHullSizeNormal();
	
	self:SetSolid( SOLID_BBOX ) 
	self:SetMoveType( MOVETYPE_STEP )
	
	self:CapabilitiesAdd( CAP_MOVE_GROUND )
	
	self:SetMaxYawSpeed( 5000 )
	
	self:SetHealth(math.random(90,110))
end

function ENT:VoiceSound(sound,vol)
	vol = vol or 100
	local rnum = math.random(90,100)
	if self.SoundDelay then
		if self.SoundDelay < CurTime() then
			self.SoundDelay = CurTime() + 1.5
			self:EmitSound(sound,vol,rnum)
			WorldSound( sound, self:GetPos(), 75, rnum )
		end
	else
		self.SoundDelay = CurTime() + 1.5
		WorldSound( sound, self:GetPos(), 75, rnum )
	end
end

local function ScaleBone( ent, realboneid, Size )

	local matBone = ent:GetBoneMatrix( realboneid )
	//matBone:Scale( Vector( -10, -10, -10 ) )
	matBone:Scale( Vector( Size, Size, Size ) )

	ent:SetBoneMatrix( realboneid, matBone )

end

function ENT:DoDeath(dmginfo)
	if self.IsDead then self:Remove() return end
	self.IsDead = true

	local killer = dmginfo:GetAttacker()

	if killer:GetNWInt("fightinglevel") > 1 then
		leveladd = 30
	elseif killer:GetNWInt("fightinglevel") > 2 then
		leveladd = 29
	elseif killer:GetNWInt("fightinglevel") > 3 then
		leveladd = 27
	elseif killer:GetNWInt("fightinglevel") > 3 then
		leveladd = 25
	elseif killer:GetNWInt("fightinglevel") > 4 then
		leveladd = 25
	elseif killer:GetNWInt("fightinglevel") > 5 then
		leveladd = 23
	elseif killer:GetNWInt("fightinglevel") > 6 then
		leveladd = 22
	elseif killer:GetNWInt("fightinglevel") > 7 then
		leveladd = 20
	elseif killer:GetNWInt("fightinglevel") > 8 then
		leveladd = 0
	else
		leveladd = 35
	end

	if killer:IsPlayer() then
		local oldfexp = killer:GetNWInt("fightingexp")
		randomgain = math.random( leveladd + 1, leveladd + 5 )
		FightingLevelData[ killer:UniqueID() ][ "fightingexp" ] = oldfexp + randomgain
		killer:SetNWInt( "fightingexp", oldfexp + randomgain)

		if killer:GetNWInt("fightingexp") > 99 then
			local oldfexp = killer:GetNWInt("fightingexp")
			local oldflevel = killer:GetNWInt("fightinglevel")
			FightingLevelData[ killer:UniqueID() ][ "fightingexp" ] = 0
			killer:SetNWInt( "fightingexp", 0)
			FightingLevelData[ killer:UniqueID() ][ "fightinglevel" ] = oldflevel + 1
			killer:SetNWInt( "fightinglevel", oldflevel + 1)
			newlevel = oldflevel + 1
			killer:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Fighting!" )
		end
	end

	local loot = math.random(1, 5)
	if loot == 1 then
		local loot = ents.Create("resource_copper")
		loot:SetPos(self.Entity:GetPos())
		loot:Spawn()
	elseif loot == 2 then
		local loot = ents.Create("resource_tin")
		loot:SetPos(self.Entity:GetPos())
		loot:Spawn()
	elseif loot == 3 then
		local loot = ents.Create("resource_iron")
		loot:SetPos(self.Entity:GetPos())
		loot:Spawn()
	elseif loot == 4 then
		local loot = ents.Create("bar_copper")
		loot:SetPos(self.Entity:GetPos())
		loot:Spawn()
	elseif loot == 5 then
		local amount = math.random(10,25)
		local loot = ents.Create("prop_physics")
		loot:SetModel("models/nayrbarr/coin/coin.mdl")
		loot:SetNWString("Owner", "Shared")
		loot:SetPos(self.Entity:GetPos())
		loot:Spawn()
		loot:GetTable().MoneyBag = true
		loot:GetTable().Amount = amount
	end

	self:VoiceSound(ChooseRandom(self.Death),100)

	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetKeyValue("angles", self:GetAngles().p + math.random(-3,3).." "..self:GetAngles().y +  math.random(-3,3).." "..self:GetAngles().r + math.random(-3,3))
	ragdoll:SetPos(self:GetPos())
	ragdoll:SetModel(self:GetModel())
	ragdoll:Spawn()
	ragdoll:Activate()
	ragdoll:Fire("kill",1,10)
	ragdoll:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	for i=1,128 do
		local bone = ragdoll:GetPhysicsObjectNum( i )
		if ValidEntity( bone ) then
			local bonepos, boneang = ragdoll:GetBonePosition( ragdoll:TranslatePhysBoneToBone( i ) )
			bone:SetPos( bonepos )
			bone:SetAngle( boneang )
		end
	end
			
	local phys = ragdoll:GetPhysicsObject()
	if phys:IsValid() then
		phys:SetMass(50)
		local fnum = 900
		if dmginfo:IsExplosionDamage() then 
			fnum = phys:GetMass()^3.2
		else
			fnum = phys:GetMass()^2.1
		end
		phys:AddAngleVelocity(Angle(math.Rand(-1*(fnum/5),fnum/5),math.Rand(-1*(fnum/3),fnum/3),math.Rand(-1*(fnum/5),fnum/5)))
		phys:ApplyForceCenter((ragdoll:GetPos()-killer:GetPos())*math.random(50,200))
	end
			
	self:SetSchedule( SCHED_FALL_TO_GROUND )
	self:Remove()
end

function ENT:OnTakeDamage(dmg)
	self:SetHealth(math.Clamp(self:Health() - dmg:GetDamage(),0,100))
	if self:Health() <= 0 then
		if self:IsValid() then
			self:DoDeath(dmg)
		end
	else
		if math.random(1,3) == 1 then
			self:VoiceSound(ChooseRandom(self.Pain),100)
		end
	end
end

function ENT:Think()
	if not self.IdleTalk then
		self.IdleTalk = CurTime() + math.random(15,25)
	elseif self.IdleTalk < CurTime() then
		self:VoiceSound(ChooseRandom(self.Taunt),100)
		self.IdleTalk = nil
	end
	if not self.Locator then
		self.Locator = CurTime() + 2
	elseif self.Locator < CurTime() then
		self.Locator = nil
		if self.CurEnemy and self.CurEnemy != NULL and self.CurEnemy:IsValid() then
			if self.CurEnemy:Alive() then
				self:SetEnemy( self.CurEnemy, true ) 
				self:UpdateEnemyMemory( self.CurEnemy, self.CurEnemy:GetPos() ) 
			else
				if table.Count(player.GetAll()) < 1 then
					self:SetEnemy( NULL )
					self.CurEnemy = nil
				else
					local enemy = ChooseRandom(player.GetAll())
					self:SetEnemy( enemy, true ) 
					self:UpdateEnemyMemory( enemy, enemy:GetPos() ) 
					self.CurEnemy = enemy
				end
			end
		end
	end
end

ENT.OldPos = Vector(0,0,0)
function ENT:TaskStart_FindEnemy( data )
	if self.OldPos:Distance(self:GetPos()) < 5 then
		if table.Count(player.GetAll()) >= 1 then
			self.CurEnemy = ChooseRandom(player.GetAll())
		else
			self.CurEnemy = NULL
			self:SetEnemy( self.CurEnemy, true ) 
			self:TaskComplete() 
			return
		end
		self.OldPos = self:GetPos()
		self:SetEnemy( self.CurEnemy, true )
		self:UpdateEnemyMemory( self.CurEnemy, self.CurEnemy:GetPos() ) 
		self:TaskComplete() 
		return
	end	
 	local enemies = player.GetAll()
	if table.Count(enemies) >= 1 then
		if self.CurEnemy then
			if self.CurEnemy:Alive() then
				local dist = self.CurEnemy:GetPos():Distance(self:GetPos())
				local enemy = self.CurEnemy
				for k,v in pairs(enemies) do
					if v:GetPos():Distance(self:GetPos()) < dist then
						dist = v:GetPos():Distance(self:GetPos())
						enemy = v
					end
				end
				self.OldPos = self:GetPos()
				self.CurEnemy = enemy
				self:SetEnemy( enemy, true ) 
				self:UpdateEnemyMemory( enemy, enemy:GetPos() ) 
				self:TaskComplete()
			else
				local enemy = ChooseRandom(enemies)
				self:SetEnemy( enemy, true ) 
				self:UpdateEnemyMemory( enemy, enemy:GetPos() ) 
				self.CurEnemy = enemy
				self:TaskComplete()
			end
		else
			local enemy = NULL
			local dist = 999999
			for k,v in pairs(enemies) do
				if v:GetPos():Distance(self:GetPos()) < dist then
					dist = v:GetPos():Distance(self:GetPos())
					enemy = v
				end
			end
			self.OldPos = self:GetPos()
			self.CurEnemy = enemy
			self:SetEnemy( enemy, true ) 
			self:UpdateEnemyMemory( enemy, enemy:GetPos() ) 
			self:TaskComplete()
		end
	else
		self:SetEnemy( NULL )	 
	end
end 

function ENT:TaskStart_PlaySequence( data )
	local SequenceID = data.ID

	if ( data.Name ) then SequenceID = self:LookupSequence( data.Name )	end

	self:ResetSequence( SequenceID )
	self:SetNPCState( NPC_STATE_SCRIPT )

	local Duration = self:SequenceDuration()

	if ( data.Speed && data.Speed > 0 ) then 

		SequenceID = self:SetPlaybackRate( data.Speed )
		Duration = Duration / data.Speed

	end

	self.TaskSequenceEnd = CurTime() + Duration
	self.HitTime = CurTime() + (Duration / self.AnimScale)
	self:EmitSound(ChooseRandom(self.Attack),100,math.random(85,100))
end

function ENT:Task_PlaySequence( data )
	if ( CurTime() > self.HitTime ) and not self.DidHit then
		self.DidHit = true

		local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
		for k,v in pairs(foundents) do
			if v:GetPos():Distance(self:GetPos()) < 50 then
				if v:GetClass() == "npc_guard" or v:GetNWString("race") == "Undead" or not v:GetClass() == "npc_zombie3" or v:GetActiveWeapon() == v:GetWeapon("torch") then else
					v:TakeDamage(self.Damage,self)
					v.DeathType = "normal"
					self:EmitSound(ChooseRandom(Vo.Claw),100,math.random(90,110))
				end
			end
		end

		local trace = {}
		trace.start = (self:GetPos() + Vector(0,0,60)) + (self:GetAngles():Forward() * -10)
		trace.endpos = trace.start + self:GetAngles():Forward() * 110
		trace.filter = self
		local tr = util.TraceLine(trace) 
		if tr.HitWorld or not tr.Entity:IsValid() then 
			return
		end
		if string.find(tr.Entity:GetClass(),"prop_") and tr.Entity:GetModel() == "models/castledoor.mdl" then
			self:EmitSound(ChooseRandom(Vo.Claw),100,math.random(90,110))
			local phys = tr.Entity:GetPhysicsObject()
			if phys:IsValid() then
				phys:ApplyForceCenter(self:GetForward() * 2000)
			end
		end
	end

	if CurTime() < self.TaskSequenceEnd then return end

	self:TaskComplete()
	self.DidHit = false
	self:SetNPCState( NPC_STATE_NONE )

	-- Clean Up
	self.TaskSequenceEnd = nil
end 