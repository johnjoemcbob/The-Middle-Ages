if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= true
if ( CLIENT ) then
	SWEP.PrintName		= "Copper Long Sword"
	SWEP.Purpose        = "A Long Copper Sword."
	SWEP.Instructions   = "Primary to strike.\nHold Sprint and Secondary to drop the weapon."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_sword.mdl"
SWEP.WorldModel  		= "models/weapons/w_sword.mdl"
-------------------------------------------------------------------
function SWEP:PrimaryAttack()
	if self.Owner:IsPlayer() then
		if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	end
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local flevel = self.Owner:GetNWInt("fightinglevel")
	if flevel > 0 then
		damamgeflevel = 19
	elseif flevel > 2 then
		damamgeflevel = 22
	elseif flevel > 10 then
		damamgeflevel = 25
	else
		damamgeflevel = 19
	end
	if flevel > 9 then
		self.Weapon:ShootBullets( damageflevel )
	else
		self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Fighting Level of 10 to use this weapon.")
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:IsPlayer() then
		if self.Owner:KeyDown(IN_SPEED) then
			self.Owner:GiveItem( "sword_long_copper", 1 )
			InventoryAddon:SendMessage( "You put your Copper Long Sword in your backpack.", self.Owner, false )
			self.Owner:StripWeapon( "sword_long_copper" )
		end
	end
end 