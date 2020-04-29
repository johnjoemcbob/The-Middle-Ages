if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= false
if ( CLIENT ) then
	SWEP.PrintName		= "Alpha Claws"
	SWEP.Purpose        = "Hello Nicola! You get claws that are 100% more awesome-er :D\nPlus you get this message from me.... YAY."
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
	self.Weapon:ShootBullets( 45 )
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	self.Weapon:ShootBullets( 1 )
end 