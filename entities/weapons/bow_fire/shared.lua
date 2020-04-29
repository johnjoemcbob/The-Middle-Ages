SWEP.Contact			= "Omen"
SWEP.Purpose			= ""
SWEP.Instructions		= "Primary to fire a fire arrow.\nHold Sprint and Secondary to drop the weapon."
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true
SWEP.Category 			= "The Middle Ages"

SWEP.ViewModel				= "models/aoc_weapon/v_longbow.mdl"
SWEP.WorldModel				= "models/aoc_weapon/w_longbow.mdl"	

SWEP.Primary.Automatic		= false
SWEP.Primary.ClipSize		= 100000000
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Ammo			= "XBowBolt"
SWEP.Primary.Delay			= 1.8
SWEP.Primary.Damage			= 200
SWEP.Primary.ReloadTime		= 2.1

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 			= Vector( -5.2, -3, 3 )
SWEP.IronSightsAng 			= Vector( 2.8, -2.5, 3 )

if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "pistol"
	SWEP.Weight				= 15
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.PrintName			= "Fire Bow"			
	SWEP.Author				= "Omen, Matthew"
	SWEP.Slot				= 4
	SWEP.SlotPos			= 5
	SWEP.IconLetter			= "r"
	SWEP.DrawCrosshair 		= false
	SWEP.DrawAmmo			= false
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	surface.CreateFont( "csd", ScreenScale( 30 ), 500, true, true, "CSKillIcons" )
	killicon.AddFont( "maw_bow", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

function SWEP:Initialize()
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
	self.Weapon:SetNetworkedBool( "Ironsights", false )
end

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
	self:SetIronsights( false )
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	if ( !self:CanPrimaryAttack() ) then return end
	if self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_MOVELEFT) or self.Owner:KeyDown(IN_MOVERIGHT) then else
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Weapon:EmitSound( "Weapon_Crossbow.Single" )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:ViewPunch(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(-9,-4))) -- Soft viewpunch

		if (!CLIENT) then
			local Ang = self.Owner:EyeAngles()
			Ang.pitch = Ang.pitch - 5
			self.Owner:SetEyeAngles( Ang ) -- Rough viewpunch
		end

		if (SERVER) then
			local Arrow = ents.Create("maw_arrow_fire")
			Arrow:SetPos(self.Owner:GetShootPos() + self.Owner:GetForward()*34)
			Arrow:SetAngles(self.Owner:EyeAngles() + Angle( 0, 0, 90 ))
			Arrow:SetPhysicsAttacker(self.Owner)
			Arrow:SetOwner(self.Owner)
			Arrow:Spawn()
			Arrow:GetPhysicsObject():ApplyForceCenter(self.Owner:GetAimVector()*9800)
		end

		self:TakePrimaryAmmo( 1 )
	end
end

local IRONSIGHT_TIME = 0.25
function SWEP:GetViewModelPosition( pos, ang )
	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )
	if ( bIron != self.bLastIron ) then
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	end

	local fIronTime = self.fIronTime or 0
	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end

	local Mul = 1.0
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		if (!bIron) then Mul = 1 - Mul end
	end

	local Offset	= self.IronSightsPos
	if ( self.IronSightsAng ) then
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	end

	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul
	return pos, ang
end

function SWEP:SetIronsights( b )
	self.Weapon:SetNetworkedBool( "Ironsights", b )
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) then
		self.Owner:GiveItem( "maw_bow_fire", 1 )
		InventoryAddon:SendMessage( "You put your Fire Bow in your backpack.", self.Owner, false )
		self.Owner:StripWeapon( "bow_fire" )
	end
end

function SWEP:OnRestore()
	self:SetIronsights( false )
end 