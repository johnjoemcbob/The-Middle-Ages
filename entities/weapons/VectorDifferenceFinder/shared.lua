if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName			= "Vector Difference Finder"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 3
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair 		= true
end

SWEP.Author					= "Matt"
SWEP.Instructions			= "Primary to choose the first entity\nSecondary to choose the second"
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
		if trace.HitNonWorld then
			if self.Pos1 then
				self.Pos1 = nil
				self.Angles1 = nil
			end

			self.Pos1 = trace.Entity:GetPos()
			self.Angles1 = trace.Entity:GetAngles()
		end
	end
	self.NextStrike = ( CurTime() + 0.5 )
end 

function SWEP:SecondaryAttack( ply )
	if( CurTime() < self.NextStrike ) then return; end
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)

	if SERVER then
		local trace = self.Owner:GetEyeTrace( 80 )
		if trace.HitNonWorld then
			if self.Pos1 then
				self.FinalPosx = trace.Entity:GetPos().x - self.Pos1.x
				self.FinalPosy = trace.Entity:GetPos().y - self.Pos1.y
				self.FinalPosz = trace.Entity:GetPos().z - self.Pos1.z
				self.FinalAnglep = trace.Entity:GetAngles().p - self.Angles1.p
				self.FinalAngley = trace.Entity:GetAngles().y - self.Angles1.y
				self.FinalAngler = trace.Entity:GetAngles().r - self.Angles1.r

				self.Owner:PrintMessage( HUD_PRINTTALK, "AddMapItemChild( "..
				" AttachEnt, "..
				self.FinalPosx..", "..
				self.FinalPosy..", "..
				self.FinalPosz..", "..
				tostring(self.FinalAnglep)..", "..
				tostring(self.FinalAngley)..", "..
				tostring(self.FinalAngler)..", "..
				string.char(34)..trace.Entity:GetModel()..string.char(34).." )" )
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 )
end 