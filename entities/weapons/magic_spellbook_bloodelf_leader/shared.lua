if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Sin'dorei Spellbook"
	SWEP.Author				= "NanoXax67"

	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.ViewModelFOV		= 70
	SWEP.IconLetter			= "x"

end

SWEP.Author   = "Feihc"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""
SWEP.Spawnable      = false
SWEP.AdminSpawnable  = false
SWEP.ViewModel      = "models/weapons/v_whomp_dictionary.mdl"

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawWorldModel(false)
	end
end

function SWEP:Think()
	local trace = self.Owner:GetEyeTrace()
	if (trace.HitNonWorld) then
		local iHealth = trace.Entity:Health()
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Owner:PrintMessage(4, tostring(iHealth))
		end
	end
end

function Nova( caller, radius, damage, step, pos )
	--Usage
	--Caller: The owner of the weapon
	--Radius: The endwidth of the nova
	--Damage: The damage the nova should do
	--Step: The current width of the nova

	--IE: Nova( self.Owner, 5000, 400, 1000, self.Owner:GetShootPos() )
	--That would create a nova that starts at 1000 and ends at 5000, doing 400 damage

	local a, b, c , d, e, f
	
	a = math.pi * 2  	--endpoint
	b = 0			--startpoint
	f = pos
	
	local stepspeed = a / 30
	
	for c = b, a, stepspeed do
		d = math.cos( c ) * step
		e = math.sin( c ) * step
		
		--test function
		
		-- local test = ents.Create( "env_explosion" )
		
		effectdata = EffectData()
			local pos2 = Vector( f.x + d, f.y + e, f.z )
			effectdata:SetStart( f )
			effectdata:SetOrigin( pos2 )
			effectdata:SetScale( 800 )
			util.Effect( "GaussTracer", effectdata )
			util.BlastDamage( caller, caller, pos2, step / 2, 20 ) 
			
	end
	
	if step + 150 < radius then  --that # controls the number of loops, checks for ><
		step = step + 150 --this too, adds it
		timer.Simple( .05, Nova, caller, radius, damage, step, pos )
	end
end

function SWEP:PrimaryAttack()
	if (SERVER) then
		local vShootPos = self.Owner:GetShootPos()
        local vShootAng = self.Owner:GetAimVector()
		local spr = math.Rand(-25,50)
		local up = (Vector(0, 0, 90 ) + Vector(spr, spr, spr))
        ball = ents.Create( "prop_physics" )
		smoke = ents.Create("env_smoketrail")
		fire = ents.Create("env_fire_trail")
        util.PrecacheModel("models/props_junk/Rock001a.mdl")
        ball:SetPos( vShootPos + Vector(0, 0, 25) )
        ball:SetAngles( up * 2)
		smoke:SetPos( vShootPos + Vector(0, 0, 25) )
		smoke:SetAngles( up * 2)
		fire:SetPos( vShootPos + Vector(0, 0, 25) )
		fire:SetAngles( up * 2)
		ball:SetKeyValue("model", "models/props_junk/Rock001a.mdl")
		ball:SetKeyValue("rendercolor", "255 255 0");
		smoke:SetKeyValue("smokesprite","sprites/whitepuff.spr" )
		smoke:SetKeyValue("spawnrate","9")
		smoke:SetKeyValue("spawnradius","20" )
		smoke:SetKeyValue("opacity","0.5" )
		smoke:SetKeyValue("endsize","24" )
		smoke:SetKeyValue("startcolor","100 100 100" )
		smoke:SetKeyValue("endcolor","255 255 255" )
		smoke:SetKeyValue("lifetime","7.0" )
		smoke:SetKeyValue("firesprite","sprites/firetrail.spr" )
		fire:SetKeyValue("firesprite","sprites/whitepuff.spr" )
		fire:SetKeyValue("spawnrate","9")
		fire:SetKeyValue("spawnradius","20" )
		fire:SetKeyValue("opacity","0.5" )
		fire:SetKeyValue("endsize","24" )
		fire:SetKeyValue("startcolor","100 100 100" )
		fire:SetKeyValue("endcolor","255 255 255" )
		fire:SetKeyValue("lifetime","7.0" )
		fire:SetKeyValue("firesprite","sprites/firetrail.spr" )
		ball:Fire("addoutput","exploderadius 280",0)
		ball:Fire("addoutput","explodedamage 200",0) --Change this line to do more damage. 15 is default
		ball:Fire("physdamagescale","100",0)
		ball:Fire("addoutput","onhealthchanged !self,break",0)
		ball:SetOwner(self.Owner)
		ball:SetKeyValue("PerformanceMode",1)
		smoke:SetParent(ball)
		fire:SetParent(ball)
		fire:Spawn()
		fire:Activate()
		ball:Spawn()
        ball:Activate()
		smoke:Spawn()
		smoke:Activate()
        local vForce = up * 25
        local phys = ball:GetPhysicsObject()
        phys:ApplyForceCenter( vForce )
		ball:SetPhysicsAttacker(self.Owner)
		local delay = 1
		self.Weapon:SetNextSecondaryFire(CurTime() + delay)
		self.Weapon:SetNextPrimaryFire(CurTime() + delay)
		self.Owner:SetAngles(vShootAng)
	end

	if math.random( 1, 5 ) == 1 then
		self.Weapon:AddExp( 1 )
	end
end

function SWEP:AddExp( amount )
	local oldmexp = self.Owner:GetNWInt("magicexp")
	MagicLevelData[ self.Owner:UniqueID() ][ "Magicexp" ] = oldmexp + amount
	self.Owner:SetNWInt( "Magicexp", oldmexp + amount)

	if self.Owner:GetNWInt("Magicexp") > 99 then
		local oldmexp = self.Owner:GetNWInt("Magicexp")
		local oldmlevel = self.Owner:GetNWInt("Magiclevel")
		MagicLevelData[ self.Owner:UniqueID() ][ "Magicexp" ] = oldmexp - 100
		self.Owner:SetNWInt( "Magicexp", oldmexp - 100)

		MagicLevelData[ self.Owner:UniqueID() ][ "Magiclevel" ] = oldmlevel + 1
		self.Owner:SetNWInt( "Magiclevel", oldmlevel + 1)
		newlevel = oldmlevel + 1
		self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Magic!")
	end
end

function SWEP:SecondaryAttack()
	self.Owner:GodEnable(true)
	self.Owner:GodDisable(false)
	Nova( self.Owner, 1800, 5, 50, (self.Owner:GetShootPos() - Vector(0,0,25)))
	self.Owner:GodEnable(false)
	self.Owner:GodDisable(true)
	self.Weapon:EmitSound("ambient/energy/whiteflash.wav")
	self.Weapon:SetNextSecondaryFire( CurTime() + 8 )
	for i = 1, 8 do
		timer.Simple(i, MagePrint, self.Owner, "Secondary Cooldown: " .. tostring(i))
	end

	if math.random( 1, 5 ) == 1 then
		self.Weapon:AddExp( 1 )
	end
end

function MagePrint(player, text)
	player:PrintMessage(4, text)
end

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.9 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 15	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 10	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= 10	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "pistol"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------