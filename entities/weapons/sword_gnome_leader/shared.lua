if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= false
if ( CLIENT ) then
	SWEP.PrintName		= "Fine Gnomish Sword"
	SWEP.Purpose        = "A Gnomish Sword made specialy for the Ruler of the Gnomish Empire."
	SWEP.Instructions   = "Primary to strike."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/worldofwarcraft/2h_swords/blackwing_sword_2h_01.mdl"
SWEP.WorldModel  		= "models/weapons/w_sword_silver.mdl"
--SWEP.IronSightsPos = Vector (8.0235, 14.1106, -31.7829)
--SWEP.IronSightsAng = Vector (-0.2434, -92.2174, 67.5185)

SWEP.IronSightsPos = Vector (3.7355, 12.1204, -32.8321)
SWEP.IronSightsAng = Vector (-0.2434, -92.2174, 67.5185)
-------------------------------------------------------------------

function SWEP:Initialize()
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
	self.Weapon:SetNetworkedBool( "Ironsights", true )
end

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
	self:SetIronsights( true )
end

function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local flevel = self.Owner:GetNWInt("fightinglevel")
	self.Weapon:ShootBullets( 45 )
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


/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )
	self.Weapon:SetNetworkedBool( "Ironsights", b )
end 