if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= true
if ( CLIENT ) then
	SWEP.PrintName		= "War Hammer"
	SWEP.Purpose        = "A War Hammer."
	SWEP.Instructions   = "Primary to slam.\nHold Sprint and Secondary to drop the weapon."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel			= "models/weapons/v_sledgehammer/v_sledgehammer.mdl"
SWEP.WorldModel  		= "models/weapons/w_sledgehammer.mdl"
-------------------------------------------------------------------
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local flevel = self.Owner:GetNWInt("fightinglevel")
	if flevel > 69 then
		damageflevel = 34
	elseif flevel > 79 then
		damageflevel = 41
	elseif flevel > 89 then
		damageflevel = 50
	elseif flevel < 99 then
		damageflevel = 64
	end
	if flevel > 69 then
		self.Weapon:ShootBullets( damageflevel )
	else
		self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Fighting Level of 70 to use this weapon.")
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) then
		self.Owner:GiveItem( "war_hammer", 1 )
		InventoryAddon:SendMessage( "You put your War Hammer in your backpack.", self.Owner, false )
		self.Owner:StripWeapon( "hammer_war" )
	end
end 