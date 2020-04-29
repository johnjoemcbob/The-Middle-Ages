if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "shotgun"
end

if ( CLIENT ) then
	SWEP.PrintName			= "Range Weapon Base"	
	SWEP.Author				= "Matthew"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 7
	SWEP.ViewModelFOV		= 62
	SWEP.IconLetter			= "x"
	SWEP.Category 			= "The Middle Ages"
end
---------------------------------------------------
function SWEP:ShootBullets( hitdamage )
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local trace = self.Owner:GetEyeTrace()
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 1
	bullet.Damage = hitdamage
	self.Owner:FireBullets(bullet)
end
-------------------------------------------------------------------
SWEP.Author   				= "Matt"
SWEP.Contact        		= "mcormack1994@hotmail.co.uk"
-------------------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 8
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"
SWEP.Secondary.EntitySound	= "weapons/stingwraith_sword/sword_hit.wav"
SWEP.Secondary.WorldSound	= "weapons/stingwraith_sword/sword_hit.wav"