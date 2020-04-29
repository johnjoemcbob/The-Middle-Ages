
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "phys"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Fire Mage"			
	SWEP.Author				= "Feihc"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 3
	SWEP.ViewModelFOV		= 70
	SWEP.IconLetter			= "x"
	
	killicon.AddFont( "weapon_deagle", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )

end

-----------------------Main functions----------------------------

function SWEP:Think()
	local trace = self.Owner:GetEyeTrace()
	if (trace.HitNonWorld) then
		local iHealth = trace.Entity:Health()
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Owner:PrintMessage(4, tostring(iHealth))
		end
	end

	if ball == nil or not ball:IsValid() then return end 
	if ball:WaterLevel() > 0 then
		ball:Fire("break", "", 0)
		smoke:Fire("kill","",0)
		ball:Fire("kill","",0.01)
		fire:Fire("kill","",0)
    end
end

function SWEP:PrimaryAttack()
	if (SERVER) then
		local vShootPos = self.Owner:GetShootPos()
        local vShootAng = self.Owner:GetAimVector()
		ball = ents.Create( "prop_physics" )
		smoke = ents.Create("env_smoketrail")
		fire = ents.Create("env_fire_trail")
        util.PrecacheModel("models/props_junk/Rock001a.mdl")
        ball:SetPos( vShootPos + Vector(0, 0, 10) )
        ball:SetAngles( vShootAng )
		smoke:SetPos( vShootPos + Vector(0, 0, 10) )
		smoke:SetAngles( vShootAng )
		fire:SetPos( vShootPos + Vector(0, 0, 10) )
		fire:SetAngles( vShootAng )
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
		ball:Fire("addoutput","explodedamage 100",0) --Change this line to do more damage. 15 is default
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
        local vForce = vShootAng * 100000
        local phys = ball:GetPhysicsObject()
        phys:ApplyForceCenter( vForce )
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		ball:SetPhysicsAttacker(self.Owner)
		local delay = 1
		self.Weapon:SetNextPrimaryFire(CurTime() + delay)
		
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
------------General Swep Info---------------
SWEP.Author   = "Feihc"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = "Left click to conjure a fireball"
SWEP.Spawnable      = false
SWEP.AdminSpawnable = true

------------Models---------------------------
function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end
-----------------------------------------------
 
-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 10.0	--In seconds
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0	--Bullet Spread
SWEP.Primary.ClipSize		= -1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic   	= true
SWEP.Primary.Ammo         	= "none"
-------------------------------------------------------------------------------------

-------------Secondary Fire Attributes---------------------------------------
SWEP.Secondary.Delay		= 10.0
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 0
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"
-------------------------------------------------------------------------------------