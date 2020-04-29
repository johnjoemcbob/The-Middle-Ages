if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= false
if ( CLIENT ) then
	SWEP.PrintName		= "Ogre Club"
	SWEP.Purpose        = "It's just a big bit of wood, but in the hands of an Ogre... I wouldn't want to be at on the wrong side of one of those."
	SWEP.Instructions   = "Primary to whack."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_clubevi.mdl"
SWEP.WorldModel  		= "models/weapons/w_sword_silver.mdl"
-------------------------------------------------------------------

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	self.Weapon:ShootBullets( 45 )
end 