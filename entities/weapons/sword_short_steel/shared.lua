if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= true
if ( CLIENT ) then
	SWEP.PrintName		= "Steel Short Sword"	
	SWEP.Purpose        = "A Short Steel Sword."
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
	if flevel > 34 then
		damamgeflevel = 24
	elseif flevel > 39 then
		damamgeflevel = 29
	elseif flevel > 49 then
		damamgeflevel = 34
	end
	if flevel > 34 then
		self.Weapon:ShootBullets( damageflevel )
	else
		self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Fighting Level of 35 to use this weapon.")
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) then
		local flevel = self.Owner:GetNWInt("fightinglevel")
		if flevel > 34 and (self.Owner:Team() == 2 or self.Owner:Team() == 3) then else
			self.Owner:GiveItem( "sword_short_steel", 1 )
			InventoryAddon:SendMessage( "You put your Steel Short Sword in your backpack.", self.Owner, false )
			self.Owner:StripWeapon( "sword_short_steel" )
		end
	end
end 