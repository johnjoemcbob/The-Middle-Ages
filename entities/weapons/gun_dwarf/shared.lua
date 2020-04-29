if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "shotgun"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= false
if ( CLIENT ) then
	SWEP.PrintName		= "Mini Projectile Launcher"
	SWEP.Purpose        = "Prototype Mini Projectile Launcher."
	SWEP.Instructions   = "Primary to fire a projectile."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_range_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel  		= "models/weapons/w_annabelle.mdl"
-----------------------------------------------
SWEP.Primary.Delay			= 0.4
SWEP.Primary.Recoil			= 0.4
SWEP.Primary.Damage			= math.random( 10, 15 )
SWEP.Primary.NumShots		= 1		
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic   	= false
SWEP.Primary.Ammo         	= "XBowBolt" 
-------------------------------------------------------------------
function SWEP:Initialize()
	if SERVER then self:SetWeaponHoldType("shotgun") end
end

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_RELOAD) then return end
	if self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_MOVELEFT) or self.Owner:KeyDown(IN_MOVERIGHT) then return end
	self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.4)
	self.Weapon:EmitSound("weapons/shotgun/shotgun_fire6.wav")
	self.Weapon:ShootBullets( math.random( 10, 15 ) )
	self:TakePrimaryAmmo( 1 )
	self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
end 