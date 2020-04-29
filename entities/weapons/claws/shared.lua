if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= true
if ( CLIENT ) then
	SWEP.PrintName		= "Claws"
	SWEP.Purpose        = "You have claws, use 'em."
	SWEP.Instructions   = "Primary to slash, Secondary to do a warning slash."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
-------------------------------------------------------------------
function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	self.Weapon:ShootBullets( 9 )
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	self.Weapon:ShootBullets( 1 )
end 