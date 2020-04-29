if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= false
if ( CLIENT ) then
	SWEP.PrintName		= "Alpha Fangs"
	SWEP.Purpose        = "Hello Nicola! You get fangs, 'cause you wanted them ^^\nPlus you get a SECOND message from me.... YAY... You must feel so cool."
	SWEP.Instructions   = "Primary to bite.\nSecondary to howl."
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
	self.Weapon:ShootBullets( 30 )
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + 6.218935)
	self.Weapon:EmitSound("wolf/howl.wav")
end 