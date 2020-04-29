if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName			= "Vector Position Finder"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 3
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair 		= true
end

SWEP.Author					= "Matt"
SWEP.Instructions			= "Primary to get the position, the angle, and the model name of an entity"
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
			if trace.Entity:GetMaterial() == "models/props/de_inferno/woodfloor008a" then
				material = "models/props/de_inferno/woodfloor008a"
			elseif trace.Entity:GetMaterial() == "models/props/de_inferno/tileroof01" then
				material = "models/props/de_inferno/tileroof01"
			elseif trace.Entity:GetMaterial() == "models/props/de_inferno/infflrd" then
				material = "models/props/de_inferno/infflrd"
			elseif trace.Entity:GetMaterial() == "models/props/de_inferno/infflra" then
				material = "models/props/de_inferno/infflra"
			elseif trace.Entity:GetMaterial() == "models/props_lab/cornerunit_cloud" then
				material = "models/props_lab/cornerunit_cloud"
			else
				material = 0
			end

			local r,g,b,a = trace.Entity:GetColor()
			if r == 181 and g == 181 and b == 181 then
				colour = 1
			elseif r == 96 and g == 96 and b == 96 then
				colour = 2
			else
				colour = 0
			end

			self.Owner:PrintMessage( HUD_PRINTTALK, "AddMapItem( "..string.char(34)..trace.Entity:GetModel()..string.char(34)..", "..
			trace.Entity:GetPos().x..", "..
			trace.Entity:GetPos().y..", "..
			trace.Entity:GetPos().z..", "..
			tostring(trace.Entity:GetAngles().p)..", "..
			tostring(trace.Entity:GetAngles().y)..", "..
			tostring(trace.Entity:GetAngles().r)..", "..
			string.char(34)..material..string.char(34)..", "..
			colour.." )" )
			trace.Entity:SetColor(0,0,150,255)
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
			if self.Owner:KeyDown(IN_SPEED) then
				self.Owner:PrintMessage( HUD_PRINTTALK, self.Owner:GetPos().x..", "..
				self.Owner:GetPos().y..", "..
				self.Owner:GetPos().z.." )" )
			else
				local r,g,b,a = trace.Entity:GetColor()
				if a == 0 then
					alpha = 0
				else
					alpha = 255
				end

				self.Owner:PrintMessage( HUD_PRINTTALK, "AddMapDoor( "..
				trace.Entity:GetPos().x..", "..
				trace.Entity:GetPos().y..", "..
				trace.Entity:GetPos().z..", "..
				tostring(trace.Entity:GetAngles().p)..", "..
				tostring(trace.Entity:GetAngles().y)..", "..
				tostring(trace.Entity:GetAngles().r)..", "..
				alpha..", " )
				trace.Entity:SetColor(0,0,150,255)
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 )
end 