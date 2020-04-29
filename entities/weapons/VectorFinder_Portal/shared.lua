if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName			= "Portal Vector Position Finder"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 3
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair 		= true
end

SWEP.Author					= "Matt"
SWEP.Instructions			= "Primary for in portal\nSecondary for out portal"
SWEP.Contact				= ""
SWEP.Purpose				= ""

SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip			= false

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true

SWEP.NextStrike = 0

SWEP.ViewModel     			= "models/weapons/v_pistol.mdl"
SWEP.WorldModel  			= "models/weapons/w_pistol.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.Delay		= 0.1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType("melee");
	end
end

function SWEP:PrimaryAttack( ply )
	if( CurTime() < self.NextStrike ) then return; end
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)

	if SERVER then
		local trace = self.Owner:GetEyeTrace( 80 )
		if self.Owner:KeyDown(IN_SPEED) then
			self.Owner:PrintMessage( HUD_PRINTTALK, self.Owner:GetPos().x..", "..
			self.Owner:GetPos().y..", "..
			self.Owner:GetPos().z.." )" )
		else
			if trace.HitNonWorld then
				self.Owner:PrintMessage( HUD_PRINTTALK, "AddMapPortal( "..
				trace.Entity:GetPos().x..", "..
				trace.Entity:GetPos().y..", "..
				trace.Entity:GetPos().z..", "..
				tostring(trace.Entity:GetAngles().p)..", "..
				tostring(trace.Entity:GetAngles().y)..", "..
				tostring(trace.Entity:GetAngles().r)..", "..
				"0, "..
				"255, "..
				"0, "..
				"200, " )
				trace.Entity:SetColor(0,0,150,255)
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 )
end

function SWEP:SecondaryAttack( ply )
	if( CurTime() < self.NextStrike ) then return; end
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)

	if SERVER then
		local trace = self.Owner:GetEyeTrace( 80 )
		if self.Owner:KeyDown(IN_SPEED) then
			self.Owner:PrintMessage( HUD_PRINTTALK, self.Owner:GetPos().x..", "..
			self.Owner:GetPos().y..", "..
			self.Owner:GetPos().z.." )" )
		else
			if trace.HitNonWorld then
				self.Owner:PrintMessage( HUD_PRINTTALK, "AddMapPortal( "..
				trace.Entity:GetPos().x..", "..
				trace.Entity:GetPos().y..", "..
				trace.Entity:GetPos().z..", "..
				tostring(trace.Entity:GetAngles().p)..", "..
				tostring(trace.Entity:GetAngles().y)..", "..
				tostring(trace.Entity:GetAngles().r)..", "..
				"255, "..
				"0, "..
				"0, "..
				"200, " )
				trace.Entity:SetColor(0,0,150,255)
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 )
end 