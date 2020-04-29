if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Keys"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Rick Darkaliono, philxyz"
SWEP.Instructions = "Left click to lock. Right click to unlock"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Sound = "doors/door_latch3.wav"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	if SERVER then self:SetWeaponHoldType("normal") end
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	local trace = self.Owner:GetEyeTrace()
	if not ValidEntity(trace.Entity) or not trace.Entity:IsOwnable() then
		return
	end
	if trace.Entity:IsDoor() and self.Owner:EyePos():Distance(trace.Entity:GetPos()) > 65 then
		return
	end
	if trace.Entity:IsVehicle() and self.Owner:EyePos():Distance(trace.Entity:GetPos()) > 100 then
		return
	end

	if trace.Entity:OwnedBy(self.Owner) then
		trace.Entity:Fire("lock", "", 0)
		self.Owner:EmitSound(self.Sound)
		self.Weapon:SetNextPrimaryFire(CurTime() + 1.0)
	else
		self.Owner:PrintMessage( HUD_PRINTTALK, "You don't own this door!")
		self.Weapon:SetNextPrimaryFire(CurTime() + .5)
	end
end

function SWEP:Reload()
	local pos = self.Owner:GetShootPos()
	local dir = self.Owner:GetAimVector()
	local t = {}
	t.start = pos
	t.endpos = pos + (dir * 70)
	t.filter = self.Owner

	local trace = util.TraceLine( t )
	if ( !trace.Entity:IsValid() ) then return end
	local class = trace.Entity:GetClass()
	if ( class != "prop_door_rotating" && class != "func_door" && class != "func_door_rotating" ) then return end
	self.Weapon:EmitSound("physics/wood/wood_crate_impact_hard2.wav")
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	local trace = self.Owner:GetEyeTrace()
	if not ValidEntity(trace.Entity) or not trace.Entity:IsOwnable() then
		return
	end
	if trace.Entity:IsDoor() and self.Owner:EyePos():Distance(trace.Entity:GetPos()) > 65 then
		return
	end
	if trace.Entity:IsVehicle() and self.Owner:EyePos():Distance(trace.Entity:GetPos()) > 100 then
		return
	end

	if trace.Entity:OwnedBy(self.Owner) then
		trace.Entity:Fire("unlock", "", 0)
		self.Owner:EmitSound(self.Sound)
		self.Weapon:SetNextPrimaryFire(CurTime() + 1.0)
	else
		self.Owner:PrintMessage( HUD_PRINTTALK, "You don't own this!")
		self.Weapon:SetNextPrimaryFire(CurTime() + .5)
	end
end
