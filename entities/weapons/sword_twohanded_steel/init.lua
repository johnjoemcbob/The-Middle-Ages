AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

SWEP.Weight					= 5		// Decides whether we should switch from/to this
SWEP.AutoSwitchTo				= true	// Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true	// Auto switch from if you pick up a better weapon

SWEP.HoldType				= "sword"

local ActIndex = {}
	ActIndex["pistol"] 		= ACT_HL2MP_IDLE_PISTOL
	ActIndex["smg"] 			= ACT_HL2MP_IDLE_SMG1
	ActIndex["grenade"] 		= ACT_HL2MP_IDLE_GRENADE
	ActIndex["ar2"] 			= ACT_HL2MP_IDLE_AR2
	ActIndex["shotgun"] 		= ACT_HL2MP_IDLE_SHOTGUN
	ActIndex["rpg"]	 		= ACT_HL2MP_IDLE_RPG
	ActIndex["physgun"] 		= ACT_HL2MP_IDLE_PHYSGUN
	ActIndex["crossbow"] 		= ACT_HL2MP_IDLE_CROSSBOW
	ActIndex["melee"] 		= ACT_HL2MP_IDLE_MELEE
	ActIndex["slam"] 			= ACT_HL2MP_IDLE_SLAM
	ActIndex["normal"]		= ACT_HL2MP_IDLE
	ActIndex["knife"]			= ACT_HL2MP_IDLE_KNIFE
	ActIndex["sword"]			= ACT_HL2MP_IDLE_MELEE2
	ActIndex["passive"]		= ACT_HL2MP_IDLE_PASSIVE
	ActIndex["fist"]			= ACT_HL2MP_IDLE_FIST

/*---------------------------------------------------------
   Name: SWEP:SetWeaponHoldType()
   Desc: Sets up the translation table, to translate from normal 
	   standing idle pose, to holding weapon pose.
---------------------------------------------------------*/
function SWEP:SetWeaponHoldType(t)

	local index = ActIndex[t]
	
	if (index == nil) then
		Msg("SWEP:SetWeaponHoldType - ActIndex[ \""..t.."\" ] isn't set!\n")
		return
	end

	self.ActivityTranslate = {}
	self.ActivityTranslate [ACT_HL2MP_IDLE] 					= index
	self.ActivityTranslate [ACT_HL2MP_WALK] 					= index + 1
	self.ActivityTranslate [ACT_HL2MP_RUN] 					= index + 2
	self.ActivityTranslate [ACT_HL2MP_IDLE_CROUCH] 				= index + 3
	self.ActivityTranslate [ACT_HL2MP_WALK_CROUCH] 				= index + 4
	self.ActivityTranslate [ACT_HL2MP_GESTURE_RANGE_ATTACK] 		= index + 5
	self.ActivityTranslate [ACT_HL2MP_GESTURE_RELOAD] 			= index + 6
	self.ActivityTranslate [ACT_HL2MP_JUMP] 					= index + 7
	self.ActivityTranslate [ACT_RANGE_ATTACK1] 				= index + 8
	
	self:SetupWeaponHoldTypeForAI(t)
end

/*---------------------------------------------------------
   Name: SWEP:TranslateActivity()
   Desc: Translate a player's activity into a weapon's activity.
	   So for example, ACT_HL2MP_RUN becomes ACT_HL2MP_RUN_PISTOL
	   depending on how you want the player to be holding the weapon.
---------------------------------------------------------*/
function SWEP:TranslateActivity(act)

	if (self.Owner:IsNPC()) then
		if (self.ActivityTranslateAI[act]) then
			return self.ActivityTranslateAI[act]
		end

		return -1
	end

	if (self.ActivityTranslate[act] != nil) then
		return self.ActivityTranslate[act]
	end
	
	return -1
end