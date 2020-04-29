if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Hands"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Matt"
SWEP.Instructions = "Secondary to pick up or drop objects\nPrimary to throw the object you're holding\nReload to straighten the object you're holding"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.Sound = "doors/door_latch3.wav"
SWEP.AnimPrefix	 = "rpg"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
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
	self.NextStrike = 0
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end

function SWEP:PrimaryAttack()
	if( CurTime() < self.NextStrike ) then return; end
	local pos = self.Owner:GetPos()
	local ang = self.Owner:GetAimVector()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(ang*500)
	tracedata.filter = self.Owner
	local trace = util.TraceLine(tracedata)
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
		if trace.HitNonWorld then
			local ent = trace.Entity
			if ent:GetClass() == "func_door" or ent:GetClass() == "func_door_rotating" or ent:GetClass() == "prop_door_rotating" then
				if ent:GetNWEntity("TheOwner") == self.Owner then
					ent:Fire("lock", "", 0)
				else
					self.Owner:PrintMessage( HUD_PRINTTALK, "You don't own this door!" )
				end
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 );
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
	if ( class != "prop_door_rotating" and class != "func_door" and class != "func_door_rotating" ) then return end
	if CurTime() > knockagain then
		self.Weapon:EmitSound("physics/wood/wood_crate_impact_hard2.wav")
		knockagain = CurTime() + 1
	end
end

function SWEP:SecondaryAttack()
	local pos = self.Owner:GetPos()
	local ang = self.Owner:GetAimVector()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(ang*500)
	tracedata.filter = self.Owner
	local trace = util.TraceLine(tracedata)
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
		if trace.HitNonWorld then
			local ent = trace.Entity
			if ent:GetClass() == "func_door" or ent:GetClass() == "func_door_rotating" or ent:GetClass() == "prop_door_rotating" then
				if ent:GetNWEntity("TheOwner") == self.Owner then
					ent:Fire("unlock", "", 0)
				else
					self.Owner:PrintMessage( HUD_PRINTTALK, "You don't own this door!" )
				end
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 );
end 