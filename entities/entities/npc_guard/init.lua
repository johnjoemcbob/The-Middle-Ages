AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Alerted	  = false
ENT.bleeds		= 1
ENT.AnimScale = 3
ENT.StartHealth = 2000
ENT.PlayerFriendly = 1
ENT.AttackingMelee = false
ENT.FindingLOS  = false
ENT.CanSeeEnemy = false
ENT.GotACloseOne = false
ENT.dead = false

function ENT:Initialize()
	--self:Give("sword_long_copper")

	self:SetModel( "models/barney.mdl" )

	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal();
	self:SetSolid( SOLID_BBOX )
	self:SetMoveType( MOVETYPE_STEP )
	self:CapabilitiesAdd( CAP_MOVE_GROUND | CAP_OPEN_DOORS | CAP_ANIMATEDFACE | CAP_SQUAD | CAP_USE_WEAPONS | CAP_DUCK | CAP_MOVE_SHOOT | CAP_TURN_HEAD | CAP_USE_SHOT_REGULATOR | CAP_AIM_GUN )
	self:SetMaxYawSpeed( 5000 )

	self.Friends = {""}
	self.Monsters = {"npc_antlion", "npc_antlion_worker", "npc_antlionguard", "npc_stalker", "monster_alien_controller", "monster_alien_grunt", "monster_alien_slave", "npc_headcrab", "npc_headcrab_black", "npc_headcrab_poison", "npc_headcrab_fast", "monster_babycrab", "monster_headcrab", "monster_bigmomma", "npc_hunter", "npc_rollermine", "npc_clawscanner", "npc_cscanner", "npc_manhack", "npc_fastzombie_torso", "npc_fastzombie",  "npc_poisonzombie", "npc_zombie", "npc_zombie_torso", "npc_zombine", "monster_zombie", "npc_vortigaunt", "monster_bullchicken", "monster_gargantua", "monster_houndeye", "monster_ichthyosaur", "monster_archer", "monster_panthereye", "monster_snark", "monster_parasite","npc_xenomorph","npc_facehugger", "npc_st_insect", "npc_dan_zombie", "npc_raptor", "npc_zombie3"}
	self.Scary_Things = { "npc_combinedropship", "npc_combinegunship", "npc_helicopter", "npc_strider", "npc_sniper" }

	self:SetHealth(self.StartHealth)
	self:SetEnemy(NULL)
end
	
function ENT:OnTakeDamage(dmg)
	self:SetSchedule(SCHED_SMALL_FLINCH)
	self:SpawnBlood(dmg)
	self:SetHealth(self:Health() - dmg:GetDamage())

	if dmg:GetAttacker():GetClass() != self:GetClass() && math.random(1,25) == 1 then
		self:ResetEnemy()
		self:AddEntityRelationship( dmg:GetAttacker(), 1, 10 )
		self:SetEnemy(dmg:GetAttacker())
		self:CallForHelp()
	end
	self.Alerted = true
	if self:Health() <= 0 && self.dead == false then -- Run on death
		self.dead = true
		self:KilledDan()
	end
end

function ENT:Think()
	local function setmeleefalse()
		self.MeleeAttacking = false
	end

	local function Attack_Melee()
		local entstoattack = ents.FindInSphere(self:GetPos() + self:GetForward()*75,74)
		if entstoattack != nil then
			for _,v in pairs(entstoattack) do
				if ( ((v:IsNPC() && not v:GetClass() == "npc_citizen" && not v:GetClass() == "npc_rebel" && not v:GetClass() == "npc_barney") || ( v:IsPlayer() && v:Alive() && v:GetNWString("race") == "Undead")) && (v != self) || (v:GetClass() == "prop_physics") || v:GetClass() == "npc_zombie3") then
					self:EmitSound("weapons/stingwraith_sword/sword_hit.wav")
					v:TakeDamage( 10, self )
				end
			end
		else
			self:EmitSound("weapons/stingwraith_sword/swing_" .. math.random( 1, 4 ) .. ".wav")
		end
		timer.Create( "melee_done_timer" .. self.Entity:EntIndex( ), 0.25, 1, setmeleefalse )
	end

	if self:Health() > 0 then
		-- Get all the npc's and other entities.
		local enttable = ents.FindByClass("npc_*")
		local monstertable = ents.FindByClass("monster_*")
		table.Add(monstertable,enttable)-- Merge

		-- Sort through each ent.
		for _, x in pairs(monstertable) do
			if (!ents) then return end
			if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_citizen" && x:GetClass() != "npc_rebel" && x:GetClass() != "npc_barney" && x:IsNPC())  then
				x:AddEntityRelationship( self, 1, 10 )
			end
		end

		if(math.random(1,20) == 1) then
			self:FindCloseEnemies()
		end

		-- Hit them.
		if self:GetEnemy() != nil then
			if (self:GetEnemy():GetPos():Distance(self:GetPos()) < 70) then
				if self.MeleeAttacking == false then
					timer.Create( "melee_attack_timer" .. self.Entity:EntIndex( ), 0.25, 1, Attack_Melee )
					self.MeleeAttacking = true;
				end
			else
				self.MeleeAttacking = false
			end
		end
	end

	local friends = ents.FindByClass("npc_citizen")
	for _, x in pairs(friends) do
		x:AddEntityRelationship( self, 3, 10 )
	end

	local friends = ents.FindByClass("npc_rebel")
	for _, x in pairs(friends) do
		x:AddEntityRelationship( self, 3, 10 )
	end

	local friends = ents.FindByClass("npc_barney")
	for _, x in pairs(friends) do
		x:AddEntityRelationship( self, 3, 10 )
	end
end
	
function ENT:SelectSchedule()
	local schdChase = ai_schedule.New( "AIFighter Chase" ) //creates the schedule used for this npc

	schdChase:AddTask( "FindEnemy", { Radius = 10000000 } )
	schdChase:EngTask( "TASK_GET_PATH_TO_ENEMY", 0 )
    schdChase:EngTask( "TASK_RUN_PATH_TIMED", 0.1 )
    schdChase:EngTask( "TASK_WAIT", 0.1 )

	local close = false
	local tbl = player.GetAll()
	for k,v in pairs(tbl) do
		if v:GetPos():Distance(self:GetPos()) < 75 then
			close = true
		end
	end

	if close then
		schdChase:EngTask( "TASK_STOP_MOVING", 			0 )
		schdChase:EngTask( "TASK_FACE_ENEMY", 			0 )
		schdChase:AddTask( "PlaySequence", 				{ Name = "swing", Speed = 3 } )
	end

	self:StartSchedule( schdChase )
end

function ENT:FindEnemyDan()
	local MyNearbyTargets = ents.FindInCone(self:GetPos(),self:GetForward(),4000,45)
	if (!MyNearbyTargets) then return end
	for k,v in pairs(MyNearbyTargets) do
		if v:Disposition(self) == 1 || v:IsPlayer() then
			if (v:GetClass() == "npc_*" || v:GetClass() == "monster_*") && v:GetClass() != self:GetClass() then
				self:ResetEnemy()
				self:AddEntityRelationship( v, 1, 10 )
				self:SetEnemy(v)
				local distance = self:GetPos():Distance(v:GetPos())
				self.Alerted = true
				return
			end
		end
	end
	self:SetEnemy(NULL)
end

function ENT:SpawnBlood(dmg)
	if (self.bleeds > 0) then
		local bloodeffect = ents.Create( "info_particle_system" )
		bloodeffect:SetKeyValue( "effect_name", "blood_impact_red_01" )
		bloodeffect:SetPos( dmg:GetDamagePosition() ) 
		bloodeffect:Spawn()
		bloodeffect:Activate() 
		bloodeffect:Fire( "Start", "", 0 )
		bloodeffect:Fire( "Kill", "", 0.1 )
	end
end

function ENT:KilledDan()
	local ragdoll = ents.Create( "prop_ragdoll" )
	ragdoll:SetModel( self:GetModel() )
	ragdoll:SetPos( self:GetPos() )
	ragdoll:SetAngles( self:GetAngles() )
	ragdoll:Spawn()
	ragdoll:SetSkin( self:GetSkin() )
	ragdoll:SetColor( self:GetColor() )
	ragdoll:SetMaterial( self:GetMaterial() )

	-- My code
	undo.ReplaceEntity(self,ragdoll)
	cleanup.ReplaceEntity(self,ragdoll)

	-- Ignight ragdoll if on fire.
	if self:IsOnFire() then ragdoll:Ignite( math.Rand( 8, 10 ), 0 ) end

	-- Position bones the same way.
	for i=1,128 do
		local bone = ragdoll:GetPhysicsObjectNum( i )
		if ValidEntity( bone ) then
			local bonepos, boneang = self:GetBonePosition( ragdoll:TranslatePhysBoneToBone( i ) )
			bone:SetPos( bonepos )
			bone:SetAngle( boneang )
		end
	end

	if( GetConVarNumber("ai_keepragdolls") == 0 ) then
		ragdoll:SetCollisionGroup( 1 )
		ragdoll:Fire( "FadeAndRemove", "", 7 )
	end
	self:Remove()
end

function ENT:CallForHelp()
	local AllOfMyFriends = ents.FindByClass(self:GetClass())
	for _,x in pairs(AllOfMyFriends) do
		if self:GetPos():Distance(x:GetPos()) < 4000 then
			if x.Alerted == false then
				x:ResetEnemy()
				x:AddEntityRelationship( self:GetEnemy(), 1, 10 )
			x:SetEnemy(self:GetEnemy())
			x:SetSchedule(SCHED_CHASE_ENEMY)
			end
		end
	end
end

function ENT:ResetEnemy()
end

function ENT:FindCloseEnemies()
	local MyNearbyTargets = ents.FindInCone(self:GetPos(),self:GetForward(),300,45)
	if (!MyNearbyTargets) then return end

	for k,v in pairs(MyNearbyTargets) do
		if v:Disposition(self) == 1 || v:IsNPC() || v:IsPlayer() then
			self:ResetEnemy()
			self:AddEntityRelationship( v, 1, 10 )
			self:SetEnemy(v)

			self.Alerted = true
			return
		end
	end
end

function ENT:OnRemove()
	timer.Remove("melee_attack_timer" .. self.Entity:EntIndex( ))
	timer.Remove("melee_done_timer" .. self.Entity:EntIndex( ))
end

function ENT:HasLOS()
	if self:GetEnemy() != nil then
		local tracedata = {}

		tracedata.start = self:GetPos()
		tracedata.endpos = self:GetEnemy():GetPos()
		tracedata.filter = self

		local trace = util.TraceLine(tracedata)
		if trace.HitWorld == false then
			return true
		else 
			return false
		end
	end
	return false
end 