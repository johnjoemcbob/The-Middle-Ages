if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= true
if ( CLIENT ) then
	SWEP.PrintName		= "Iron Short Sword"	
	SWEP.Purpose        = "A Short Iron Sword."
	SWEP.Instructions   = "Primary to strike.\nHold Sprint and Secondary to drop the weapon."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_gladius.mdl"
SWEP.WorldModel  		= "models/weapons/w_gladius.mdl"
-------------------------------------------------------------------
function SWEP:PrimaryAttack()
	if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local flevel = self.Owner:GetNWInt("fightinglevel")
	if flevel > 19 then
		damamgeflevel = 19
	elseif flevel > 29 then
		damamgeflevel = 23
	elseif flevel > 39 then
		damamgeflevel = 26
	end
	if flevel > 19 then
		self.Weapon:ShootBullets( damageflevel )
	else
		self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Fighting Level of 20 to use this weapon.")
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) then
		local flevel = self.Owner:GetNWInt("fightinglevel")
		if flevel > 19 and not flevel > 34 and (self.Owner:Team() == 2 or self.Owner:Team() == 3) then else
			self.Owner:GiveItem( "sword_short_iron", 1 )
			InventoryAddon:SendMessage( "You put your Iron Short Sword in your backpack.", self.Owner, false )
			self.Owner:StripWeapon( "sword_short_iron" )
		end
	end
end 