if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= true
if ( CLIENT ) then
	SWEP.PrintName		= "Copper Short Sword"	
	SWEP.Purpose        = "A Short Copper Sword."
	SWEP.Instructions   = "Primary to strike.\nHold Sprint and Secondary to drop the weapon."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_gladius.mdl"
SWEP.WorldModel  		= "models/weapons/w_gladius.mdl"
-------------------------------------------------------------------
function SWEP:PrimaryAttack()
	if self.Owner:IsPlayer() then
		if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	end
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local flevel = self.Owner:GetNWInt("fightinglevel")
	if flevel > 9 then
		damamgeflevel = 15
	elseif flevel > 19 then
		damamgeflevel = 20
	elseif flevel > 29 then
		damamgeflevel = 25
	else
		damamgeflevel = 3
	end
	self.Weapon:ShootBullets( damageflevel )
end

function SWEP:SecondaryAttack()
	if self.Owner:IsPlayer() then
		if self.Owner:KeyDown(IN_SPEED) then
			local flevel = self.Owner:GetNWInt("fightinglevel")
			if flevel < 20 and (self.Owner:Team() == 2 or self.Owner:Team() == 3) then else
				self.Owner:GiveItem( "sword_short_copper", 1 )
				InventoryAddon:SendMessage( "You put your Copper Short Sword in your backpack.", self.Owner, false )
				self.Owner:StripWeapon( "sword_short_copper" )
			end
		end
	end
end 