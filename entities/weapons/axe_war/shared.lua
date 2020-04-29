if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType		= "melee"
end
SWEP.Spawnable      	= false
SWEP.AdminSpawnable 	= true
if ( CLIENT ) then
	SWEP.PrintName		= "War Axe"
	SWEP.Purpose        = "A War Axe."
	SWEP.Instructions   = "Primary to chop.\nHold Sprint and Secondary to drop the weapon."
end
-------------------------------------------------------------------
SWEP.Base 				= "medieval_weapon_base"
----------------------------------------------------
SWEP.ViewModel     		= "models/weapons/v_waraxee.mdl"
SWEP.WorldModel   		= "models/weapons/w_axe.mdl"
-------------------------------------------------------------------
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local flevel = self.Owner:GetNWInt("fightinglevel")
	if flevel > 29 then
		damageflevel = 18
	elseif flevel > 39 then
		damageflevel = 23
	elseif flevel > 49 then
		damageflevel = 27
	end
	if flevel > 29 then
		self.Weapon:ShootBullets( damageflevel )
	else
		self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Fighting Level of 30 to use this weapon.")
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) then
		self.Owner:GiveItem( "war_axe", 1 )
		InventoryAddon:SendMessage( "You put your War Axe in your backpack.", self.Owner, false )
		self.Owner:StripWeapon( "axe_war" )
	end
end 