if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Portal Opener"
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Matthew"
SWEP.Instructions = "Left click to place Portal 1. Right click to place Portal 2."
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
	if self.Owner:KeyDown(IN_SPEED) then
		if port1 then
			port1:Remove()
			port1 = nil
			self.Owner:SetNWInt("portal1x", 0)
			self.Owner:SetNWInt("portal1y", 0)
			self.Owner:SetNWInt("portal1z", 0)
		end
		return
	end

	self.Owner:SetNWInt("portal1x", self.Owner:GetPos().x)
	self.Owner:SetNWInt("portal1y", self.Owner:GetPos().y)
	self.Owner:SetNWInt("portal1z", self.Owner:GetPos().z)

	if port1 then
		port1:Remove()
		port1 = nil
	end

	port1 = ents.Create("portal1")
	port1:SetPos(Vector(self.Owner:GetPos().x, self.Owner:GetPos().y, self.Owner:GetPos().z))
	port1:PhysicsInit( SOLID_VPHYSICS )
	port1:Spawn()
	port1:SetNWString("entowner", self.Owner)
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) then
		if port2 then
			port2:Remove()
			port2 = nil
			self.Owner:SetNWInt("portal2x", 0)
			self.Owner:SetNWInt("portal2y", 0)
			self.Owner:SetNWInt("portal2z", 0)
		end
		return
	end

	self.Owner:SetNWInt("portal2x", self.Owner:GetPos().x)
	self.Owner:SetNWInt("portal2y", self.Owner:GetPos().y)
	self.Owner:SetNWInt("portal2z", self.Owner:GetPos().z)

	if port2 then
		port2:Remove()
		port2 = nil
	end

	port2 = ents.Create("portal2")
	port2:SetPos(Vector(self.Owner:GetPos().x, self.Owner:GetPos().y, self.Owner:GetPos().z))
	port2:PhysicsInit( SOLID_VPHYSICS )
	port2:Spawn()
	port2:SetNWString("entowner", self.Owner)
end

function CleanPortals()
	if port1 then
		port1:Remove()
		port1 = nil
	end

	if port2 then
		port2:Remove()
		port2 = nil
	end
end
--hook.Add("PlayerDisconnected","PlayerCleanPortals",CleanPortals)