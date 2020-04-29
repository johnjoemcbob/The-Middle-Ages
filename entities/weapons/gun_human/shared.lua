if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "phys"
end

if ( CLIENT ) then
	SWEP.PrintName			= "Hand-held Cannon"			
	SWEP.Author				= "Matthew"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 3
	SWEP.ViewModelFOV		= 70
	SWEP.IconLetter			= "x"
end

-----------------------Main functions----------------------------
function SWEP:Initialize()
	if SERVER then self:SetWeaponHoldType("shotgun") end
end

function SWEP:Think() --Called every frame
	if ball == nil or not ball:IsValid() then return end 
	if ball:WaterLevel() > 0 then
		ball:Fire("break", "", 0)
		ball:Fire("kill","",0.01)
	end
end

function SWEP:PrimaryAttack()
	if (SERVER) then
		if self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_MOVELEFT) or self.Owner:KeyDown(IN_MOVERIGHT) then return end
		local vShootPos = self.Owner:GetShootPos()
        local vShootAng = self.Owner:GetAimVector()
		ball = ents.Create( "prop_physics" )
        util.PrecacheModel("models/props_junk/Rock001a.mdl")
        ball:SetPos( vShootPos + Vector(0, 0, 10) )
        ball:SetAngles( vShootAng )
		ball:SetKeyValue("model", "models/props_junk/Rock001a.mdl")
		ball:SetKeyValue("rendercolor", "0 0 0");
		ball:Fire("addoutput","exploderadius 280",0)
		ball:Fire("addoutput","explodedamage 100",0) --Change this line to do more damage. 15 is default
		ball:Fire("physdamagescale","100",0)
		ball:Fire("addoutput","onhealthchanged !self,break",0)
		ball:SetOwner(self.Owner)
		ball:SetKeyValue("PerformanceMode",1)
		ball:Spawn()
        ball:Activate()
        local vForce = vShootAng * 100000
        local phys = ball:GetPhysicsObject()
        phys:ApplyForceCenter( vForce )
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		ball:SetPhysicsAttacker(self.Owner)
		local delay = 1
		self.Weapon:SetNextPrimaryFire(CurTime() + delay)
		self:TakePrimaryAmmo( 1 )
		self.Owner:ViewPunch( Angle( -5, 0, 0 ) )
	end
end

------------General Swep Info---------------
SWEP.Author   = "Matthew"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = "Left click to fire a cannon ball"
SWEP.Spawnable      = false
SWEP.AdminSpawnable = false

------------Models---------------------------
SWEP.ViewModel		= "models/weapons/blunderbus.mdl"
SWEP.WorldModel  	= "models/weapons/w_annabelle.mdl"
-----------------------------------------------
 
-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 10.0	--In seconds
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0	--Bullet Spread
SWEP.Primary.ClipSize		= 1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic   	= true
SWEP.Primary.Ammo         	= "RPG_Round"
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