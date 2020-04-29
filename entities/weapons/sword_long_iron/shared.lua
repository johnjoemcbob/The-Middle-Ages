if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= true
if ( CLIENT ) then
	SWEP.PrintName		= "Iron Long Sword"	
	SWEP.Purpose        = "A Long Iron Sword."
	SWEP.Instructions   = "Primary to strike.\nHold Sprint and Secondary to drop the weapon."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_sword.mdl"
SWEP.WorldModel  		= "models/weapons/w_sword.mdl"
-------------------------------------------------------------------
function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local flevel = self.Owner:GetNWInt("fightinglevel")
	if flevel > 34 then
		damamgeflevel = 28
	elseif flevel > 49 then
		damamgeflevel = 33
	elseif flevel > 54 then
		damamgeflevel = 37
	end
	if flevel > 34 then
		self.Weapon:ShootBullets( damageflevel )
	else
		self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Fighting Level of 35 to use this weapon.")
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) then
		self.Owner:GiveItem( "sword_long_iron", 1 )
		InventoryAddon:SendMessage( "You put your Iron Long Sword in your backpack.", self.Owner, false )
		self.Owner:StripWeapon( "sword_long_iron" )
	end
end 