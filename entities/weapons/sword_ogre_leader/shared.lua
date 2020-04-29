if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= false
if ( CLIENT ) then
	SWEP.PrintName		= "Ogre Sword of Death"
	SWEP.Purpose        = "A Sword which was probably stolen by this Ogre during battle."
	SWEP.Instructions   = "Primary to strike."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_swordev.mdl"
SWEP.WorldModel  		= "models/weapons/w_sword_silver.mdl"
-------------------------------------------------------------------

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	self.Weapon:ShootBullets( 45 )
end 