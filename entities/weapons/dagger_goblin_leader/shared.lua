if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= false
if ( CLIENT ) then
	SWEP.PrintName		= "Goblin Dagger"
	SWEP.Purpose        = "A Dagger made by the finest Goblin Smiths."
	SWEP.Instructions   = "Primary to strike."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_gobline.mdl"
SWEP.WorldModel  		= "models/weapons/w_gladius.mdl"
-------------------------------------------------------------------

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	self.Weapon:ShootBullets( 45 )
end 