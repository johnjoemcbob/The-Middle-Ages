if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "shotgun"
end

if ( CLIENT ) then
	SWEP.PrintName			= "Spellbook"			
	SWEP.Author				= "NanoXax67"

	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.ViewModelFOV		= 70
	SWEP.IconLetter			= "x"
	SWEP.Category = "Medieval Roleplay"
end
-----------------------Main functions----------------------------

function SWEP:Think()
	local trace = self.Owner:GetEyeTrace()
	if (trace.HitNonWorld) then
		local iHealth = trace.Entity:Health()
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Owner:PrintMessage(4, tostring(iHealth))
		end
	end
end

function SWEP:Initialize()
	util.PrecacheSound("beams/beamstart5.wav")
end
 
function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace()
	local length = (self.Owner:GetShootPos() - trace.HitPos):Length()

	local effectdata = EffectData()
		effectdata:SetOrigin( trace.HitPos )
		effectdata:SetStart( self.Owner:GetShootPos() )
		effectdata:SetAttachment( 1 )
		effectdata:SetEntity( self.Weapon )
		effectdata:SetScale( length * 2 )
	util.Effect( "GaussTracer", effectdata )

	util.BlastDamage( self.Owner, self.Owner, trace.HitPos, 5, 15 )
	self.Weapon:EmitSound("beams/beamstart5.wav")
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
	self.Weapon:SetNextPrimaryFire( CurTime() + .5 )

	if (trace.HitNonWorld) then
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Weapon:AddExp( 1 )
		end
	end
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	if self.Owner:Health() < self.Owner:GetNWInt("maxhealth") and SERVER then
		self.Owner:SetHealth(self.Owner:Health() + 1)
		self.Weapon:AddExp( 0.1 )
	end
end

function SWEP:AddExp( amount )
	local oldmexp = self.Owner:GetNWInt("magicexp")
	MagicLevelData[ self.Owner:UniqueID() ][ "Magicexp" ] = oldmexp + amount
	self.Owner:SetNWInt( "Magicexp", oldmexp + amount)

	if self.Owner:GetNWInt("Magicexp") > 99 then
		local oldmexp = self.Owner:GetNWInt("Magicexp")
		local oldmlevel = self.Owner:GetNWInt("Magiclevel")
		MagicLevelData[ self.Owner:UniqueID() ][ "Magicexp" ] = oldmexp - 100
		self.Owner:SetNWInt( "Magicexp", oldmexp - 100)

		MagicLevelData[ self.Owner:UniqueID() ][ "Magiclevel" ] = oldmlevel + 1
		self.Owner:SetNWInt( "Magiclevel", oldmlevel + 1)
		newlevel = oldmlevel + 1
		self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Magic!")
	end
end
-------------------------------------------------------------------

------------General Swep Info---------------
SWEP.Author 		= "Feihc"
SWEP.Contact        = ""
SWEP.Purpose        = "The Following of Ancient Dark Magic"
SWEP.Instructions   = ""
SWEP.Spawnable      = false
SWEP.AdminSpawnable = false
-----------------------------------------------

------------Models---------------------------
function SWEP:Initialize()
	if SERVER then self:SetWeaponHoldType("normal") end
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end
-----------------------------------------------

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.9 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 15	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 10	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= 10	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "pistol"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.2
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 10
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------