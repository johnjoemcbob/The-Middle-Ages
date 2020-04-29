if (SERVER) then
	AddCSLuaFile("shared.lua")
end

SWEP.PrintName = "Healing Magic"
SWEP.Author = "Jake Johnson"
SWEP.Slot = 4
SWEP.SlotPos = 3
SWEP.Description = "Heals the wounded."
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Left Click to heal player infront of user."

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

function SWEP:Initialize()
	if SERVER then self:SetWeaponHoldType("normal") end
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end

SWEP.Primary.Recoil = 0
SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic  = true
SWEP.Primary.Delay = 0.1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Recoil = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Delay = 0.3
SWEP.Secondary.Ammo = "none"

function SWEP:Think()
	local trace = self.Owner:GetEyeTrace()
	if (trace.HitNonWorld) then
		local iHealth = trace.Entity:Health()
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Owner:PrintMessage(4, tostring(iHealth))
		end
	end
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = trace.start + (self.Owner:GetAimVector() * 85)
	trace.filter = { self.Owner, self.Weapon }
	tr = util.TraceLine(trace)

	if (tr.HitNonWorld) and SERVER then
		local enthit = tr.Entity
		if enthit:IsPlayer() and enthit:Health() < enthit:GetNWInt("maxhealth") then
			enthit:SetHealth(enthit:Health() + 1)
			enthit:SetNWInt("beinghealed", 1)
			enthit:SetNWString("healer", self.Owner:GetNWString("name").." ( "..self.Owner:Nick().." )")
			self.Weapon:AddExp( 1 )
		end
	end
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	if self.Owner:Health() < self.Owner:GetNWInt("maxhealth") and SERVER then
		self.Owner:SetHealth(self.Owner:Health() + 1)
		self.Weapon:AddExp( 0.25 )
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