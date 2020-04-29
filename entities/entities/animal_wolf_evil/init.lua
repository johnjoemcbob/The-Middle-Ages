-- Angry Wolf
-- By Teta_Bonita

AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )
include( 'shared.lua' )


---------------------------------
-- Adjustable Variables  --
---------------------------------

local MAX_HEALTH = 400
local BASE_DAMAGE = 40 -- How much damage to do on average per attack
local EXPLODE_DAMAGE = 30 -- Maximum damage to deal when exploding on death
local EXPLODE_RADIUS = 140
local JUMP_VERT_SPEED = 180
local JUMP_HORIZ_SPEED = 300
local WADDLE_SPEED = 600
local TARGET_RADIUS = 2000 -- The Wolf only attacks entities if they are at least this close to it
local ATTACK_DIST = 200 -- The Wolf must be at least this close to a target before attacking it
local ANGER_STARTATTACK = 15 -- Start attacking after anger level is greater than this
local ANGER_MAX = 100 -- Anger level at which the Wolf should explode
local ANGER_RATE = 1 -- Added to the anger level every 0.2 seconds

--------------------------------
-- Initialize (no shit?)  --
--------------------------------

function ENT:Initialize()	

	-- Bok bok!
	self:SetModel( "models/wolflink.mdl" )
	
	-- Initiate  physics
	local mins = Vector( -7, -6, 0 )
	local maxs = Vector( 7, 6, 25 )
	
	self:PhysicsInitBox( mins, maxs )
	self:SetCollisionBounds( mins, maxs )
	
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	
	self.Phys = self:GetPhysicsObject()
	if self.Phys:IsValid() then 
		self.Phys:SetMass( 500 ) -- Wolves are Heavy
		self.Phys:Wake()
	end
	
	-- How much health do we have right now?
	self.CurHealth = MAX_HEALTH
	
	-- Are we attacking anything right now?
	self.Attacking = self.Attacking or false
	
	-- Who owns the chicken?
	self.Attacker = self.Attacker or NULL
	
	-- Are we about to die?
	self.Dieing = self.Dieing or false
	
	-- Cheap way to identify chickens
	self.IsWolf = true
	
	-- How angry are we?
	self.Anger = self.Anger or 0
	
	-- Target stuff
	self.Target = self.Target or NULL -- Who are attacking right now?
	self.TargetHasPhysics = self.TargetHasPhysics or false
	self.TargetPhys = self.TargetPhys or NULL
	
	-- Waddling stuff
	self.Waddling = self.Waddling or false -- Are we waddling?
	self.InitialWaddlePhase = math.Rand( 0, 2 * math.pi )
	self.LastAngleChange = self.LastAngleChange or 0
	self.NextEmitIdle = self.NextEmitIdle or CurTime()
	
	-- When can we jump again?
	self.NextJump = self.NextJump or CurTime()
	
	-- In what manner are we moving right now?
	self.CurrentMoveFunction = self.CurrentMoveFunction or self.Waddle 
	
	-- We need to do this or else PhysicsSimulate won't be called
	self:StartMotionController()

end


function ENT:SpawnFunction( ply, tr )

	if not tr.Hit then return end
	
	local ent = ents.Create( self.Classname )
	ent:SetPos( tr.HitPos + tr.HitNormal * 8 )
	ent:Spawn()
	ent:Activate()
	
	return ent

end


------------------------------
-- Decision Functions --
------------------------------

-- Decide what we should be doing right now
function ENT:Think()

	self:NextThink( CurTime() + 0.2 )

	-- Make sure the attacker is valid
	if not self.Attacker:IsValid() then
		self:SetAttacker( self )
	end

	-- Do waddling stuff
	if self.Waddling then
	
		-- Look for a target
		local target = self:FindTarget()
		if target:IsValid() then -- We found a target!
		
			self.Anger = self.Anger + ANGER_RATE -- become angry
			
			if self.Anger >= ANGER_STARTATTACK then -- attack!

				self:StopWaddling()
				self:SetTarget( target )
				
				return true
				
			end
		
		else
		
			-- Calm down
			if self.Anger > 0 then 
				self.Anger = self.Anger - ANGER_RATE
				if self.Anger < 0 then self.Anger = 0 end
			end
			
		end
		
		-- Hop if we're stuck upside-down
		if self:GetAngles():Up():Dot( Vector( 0, 0, -1) ) >= 0 and self:OnSomething() then
	
			self.Phys:AddVelocity( Vector( 0, 0, 200 ) )
			self.Phys:AddAngleVelocity( VectorRand() * 350 )
	
		end

		return true

	end
	
	-- Do non-waddling stuff (ie, attacking stuff)
	
	-- Make sure we can see our target
	if not self:CanSeeTarget() then
	
		self.Anger = math.Clamp( self.Anger, 0, ANGER_STARTATTACK )
		self:StartWaddling()
		return true

	end
	
	-- Become more angry
	self.Anger = self.Anger + ANGER_RATE

	-- Jump
	if CurTime() > self.NextJump then
		
		self.Attacking = false
		
		if not self:OnSomething() then
			self.NextJump = CurTime() + 0.3
			return true
		end
		
		self:JumpAtTarget()
		self.NextJump = CurTime() + 1
		
	end
	
	return true

end


-- Decide if we should do attack damage or take fall damage
function ENT:PhysicsCollide( data, phys )

	if data.Speed < 30 then return end
	
	-- Take fall damage
	if data.Speed > 900 then
	
		self:TakeDamage( 0.2 * ( data.Speed - 900 ), data.HitEntity, data.HitEntity )
	
	end

	-- Damage the badguys
	if self.Attacking and not ( data.HitEntity:IsWorld() or data.HitEntity.IsWolf ) then
	
		data.HitEntity:TakeDamage( BASE_DAMAGE * math.Rand( 0.7, 1.3 ), self.Attacker, self )
		self.Attacking = false
		
	end

end


-- Decide what our new health should be and if we should die
function ENT:OnTakeDamage( dmginfo )

	self:TakePhysicsDamage( dmginfo )
	
	if self.Dieing then return end
	
	self.CurHealth = self.CurHealth - dmginfo:GetDamage()
	if self.CurHealth <= 0 then

		self.Dieing = true
		if dmginfo:GetAttacker():IsWorld() then
			self:DoDeath()
		else
			timer.Simple( math.Rand( 0.05, 0.1 ), self.DoDeath, self )
		end
		
		return
		
	end

end


---------------------------
-- Helper Functions --
---------------------------

-- Look for viable targets and return the closest one
function ENT:FindTarget()

	local target = NULL
	local shortest = TARGET_RADIUS
	local mypos = self:GetPos()

	-- Find the closest target
	for _,ent in pairs( ents.FindInSphere( mypos , TARGET_RADIUS ) ) do
	
		if ( ent:IsNPC() or ( ent:IsPlayer() and ent:Alive() ) ) and ent:Health() > 0 and self:Visible( ent ) and ent ~= self.Attacker then
		
			local dist = ent:GetPos():Distance( mypos )
		
			if dist < shortest then
			
				shortest = dist
				target = ent
			
			end
	
		end
	
	end

	return target

end


-- Makes the Wolf start tracking the input entity
function ENT:SetTarget( ent )

	self.Target = ent
	self.TargetIsPlayer = self.Target:IsPlayer()
	
	local phys = self.Target:GetPhysicsObject()
	if phys:IsValid() then
		self.TargetHasPhysics = true
		self.TargetPhys = phys
	end
	
	self.CurrentMoveFunction = self.TrackTarget
	
	-- Make the feeling mutual
	if ent:IsNPC() then
		ent:AddEntityRelationship( self, D_HT, 99 ) -- This doesn't work : (
	end

end


-- Returns true if the target is alive and visible to the Wolf
function ENT:CanSeeTarget()

	if not self.Target:IsValid() then return false end
	if self.TargetIsPlayer and not self.Target:Alive() then return false end
	if self.Target:Health() <= 0 then return false end
	
	if self:GetPos():Distance( self.Target:GetPos() ) > TARGET_RADIUS then return false end
	if not self:Visible( self.Target ) then return false end
	
	return true
	
end


-- Returns true if the Wolf is on top of something
function ENT:OnSomething()

	local start = self:GetPos() + Vector( 0, 0, 20 )
	local endpos = Vector( start.x, start.y, start.z - 30 )

	local tr = util.TraceLine( 
	{
		start = start,
		endpos = endpos,
		filter = self,
		mask = MASK_SOLID | MASK_WATER
	})
	
	return tr.Hit

end


function ENT:StartWaddling()

	self.Waddling = true
	self.CurrentMoveFunction = self.Waddle

end


function ENT:StopWaddling()

	self.Waddling = false

end


function ENT:SetAttacker( plr )

	self.Attacker = plr

end


-- Do explosion damage, emit sounds, play death effects, and remove the Wolf
function ENT:DoDeath()

	if not self:IsValid() then return end -- Just in case
	
	local mypos = self:GetPos()

	-- Explode
	local dmgmul = -EXPLODE_DAMAGE / EXPLODE_RADIUS
	for _,ent in pairs( ents.FindInSphere( self:GetPos(), EXPLODE_RADIUS ) ) do

		local dmg = dmgmul * mypos:Distance( ent:GetPos() ) + EXPLODE_DAMAGE
		if ent.Chicken then dmg = 0.5 * dmg end
		
		ent:TakeDamage( dmg, self, self )
	
	end

	-- Die
	self:Remove()

end


--------------------------------
-- Movement Functions --
--------------------------------

-- This just returns a call to our current move function
function ENT:PhysicsSimulate( phys, dt )

	phys:Wake()

	return self:CurrentMoveFunction( phys, dt )

end

-- Jumps toward the target, and attacks if we're close enough
function ENT:JumpAtTarget()

	-- Get the velocity of our target
	local vel
	if self.TargetHasPhysics then
		vel = self.TargetPhys:GetVelocity()
	else
		vel = self.Target:GetVelocity()
	end
	
	local mypos = self:GetPos()
	local targpos = self.Target:EyePos()
	local disp = targpos - mypos
	
	-- Get the vector orthogonal to the projection of vel onto disp
	local proj = vel - ( disp:Dot( vel ) / disp:Dot( disp ) ) * disp
	
	-- Try to predict where the target is going to be and jump there
	local dest = targpos + proj * 0.6
	local dist = mypos:Distance( dest )
	
	-- Vel is now the velocity the Wolf is going to have (saves memory! :D)
	vel = ( dest - mypos ) * ( JUMP_HORIZ_SPEED / dist )
	vel.z = vel.z + JUMP_VERT_SPEED
	if vel.z < 20 then vel.z = 20 end
	
	self.Phys:AddVelocity( vel )
	self.Phys:AddAngleVelocity( Angle( ( math.random( 0, 1 ) * 2 - 1 ) * math.Rand( 300, 600 ), math.Rand( -600, 200 ), ( math.random( 0, 1 ) * 2 - 1 ) * math.Rand( 300, 600 ) ) )
	
end


-- The main waddling move function
function ENT:Waddle( phys, dt )

	if not self:OnSomething() then return SIM_NOTHING end

	local TargetAng = self:GetAngles()
	local DeltaAng = math.Rand( -50, 50 ) * dt + self.LastAngleChange
	self.LastAngleChange = DeltaAng
	
	TargetAng.p = 0
	TargetAng.y = TargetAng.y + 30 * math.sin( 0.6 * CurTime() ) + DeltaAng -- turn randomly

	-- Increment the angle
	phys:ComputeShadowControl(
	{
		secondstoarrive		= 1,
		angle				= TargetAng,
		maxangular			= 400,
		maxangulardamp		= 60,
		dampfactor			= 0.8,
		deltatime			= dt
	})

	local linear = self:GetAngles():Forward() * WADDLE_SPEED - phys:GetVelocity()
	linear.z = linear.z + 250 -- Compensate for gravity/friction
	
	return Vector( 0, 0, 0 ), linear, SIM_GLOBAL_ACCELERATION

end


-- The main target tracking move function.  
-- This just makes the Wolf face the target... jumping is handled on Think
function ENT:TrackTarget( phys, dt )

	local TargetAng

	if self.Target:IsValid() then
	
		local targpos = self.Target:GetPos()
		local mypos = phys:GetPos()
	
		TargetAng = ( targpos - mypos ):Angle()
		
	else
		
		TargetAng = phys:GetAngles()
		TargetAng.p = 0
		TargetAng.r = 0
		
	end
	
	-- Increment the angle
	phys:ComputeShadowControl(
	{
		secondstoarrive		= 1,
		angle				= TargetAng,
		maxangular			= 150,
		maxangulardamp		= 80,
		dampfactor			= 0.8,
		deltatime			= dt
	})

	return SIM_NOTHING

end

