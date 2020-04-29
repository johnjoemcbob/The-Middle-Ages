if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "melee"
end

if ( CLIENT ) then
	SWEP.PrintName			= "Weapon Base"	
	SWEP.Author				= "Matthew"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 7
	SWEP.ViewModelFOV		= 62
	SWEP.IconLetter			= "x"
	SWEP.Category 			= "The Middle Ages"
end
---------------------------------------------------
function SWEP:Initialize()
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
	util.PrecacheSound("weapons/stingwraith_sword/sword_flesh.wav")
	util.PrecacheSound("weapons/stingwraith_sword/sword_hit.wav")
	util.PrecacheSound("weapons/stingwraith_sword/swing_1.wav")
	util.PrecacheSound("weapons/stingwraith_sword/swing_2.wav")
	util.PrecacheSound("weapons/stingwraith_sword/swing_3.wav")
	util.PrecacheSound("weapons/stingwraith_sword/swing_4.wav")
	util.PrecacheSound("weapons/stingwraith_sword/longbladOUT.wav")
	util.PrecacheSound("weapons/stingwraith_sword/longbladAWAY.wav")
end

function SWEP:ShootBullets( hitdamage )
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local trace = self.Owner:GetEyeTrace()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
		bullet = {}
		bullet.Num    = 1
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 1
		bullet.Damage = hitdamage
		self.Owner:FireBullets(bullet) 
		self.Weapon:EmitSound("weapons/stingwraith_sword/sword_hit.wav")
	else
		self.Weapon:EmitSound("weapons/stingwraith_sword/swing_" .. math.random( 1, 4 ) .. ".wav")
	end
end
-------------------------------------------------------------------
SWEP.Author   				= "Matt"
SWEP.Contact        		= "mcormack1994@hotmail.co.uk"
-----------------------------------------------
SWEP.Primary.Delay			= 0.9
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 4
SWEP.Primary.NumShots		= 1		
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic   	= false
SWEP.Primary.Ammo         	= "none" 
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