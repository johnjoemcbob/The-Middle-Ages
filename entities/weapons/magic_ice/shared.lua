if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Ice Mage"			
	SWEP.Author				= "NanoXax67"

	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.ViewModelFOV		= 70
	SWEP.IconLetter			= "x"
	SWEP.Category = "Medieval Roleplay"

end
-----------------------Main functions----------------------------
function SWEP:Initialize()
	util.PrecacheSound("ambient/wind/wind_hit2.wav")
end

function SWEP:Think()
	local trace = self.Owner:GetEyeTrace()
	if (trace.HitNonWorld) then
		local iHealth = trace.Entity:Health()
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Owner:PrintMessage(4, tostring(iHealth))
		end
	end
end

function smoke(ent, speed, rate, size1, size2, length)
	if SERVER then
		local smoke = ents.Create("env_steam")
		if ent:IsPlayer() then
			smoke:SetPos(ent:GetShootPos())
			smoke:SetKeyValue("Angles", tostring(ent:EyeAngles()))
		else
			smoke:SetPos(ent:GetPos())
			smoke:SetKeyValue("Angles", tostring(Angle(0,0,0)))
		end

		smoke:SetKeyValue("InitialState", "1")
		smoke:SetKeyValue("Speed", speed)
		smoke:SetKeyValue("Rate", rate)
		smoke:SetKeyValue("StartSize", size1)
		smoke:SetKeyValue("EndSize", size2)
		smoke:SetKeyValue("JetLength", length)
		smoke:SetKeyValue("SpreadSpeed", "2")
		smoke:SetKeyValue("SpawnFlags", "1")
		smoke:Spawn()
		smoke:Activate()
		smoke:Fire("TurnOn", "", 0)
		smoke:Fire("TurnOff","", .25)
		smoke:Fire("kill", "", 1)
	end
end
 
function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace()

	smoke(self.Owner, "3000", "50", "1", "100", "4000")

	local b = ents.Create( "point_hurt" )
	b:SetKeyValue("targetname", "fier" ) --Yes, I spelt it like that on purpose.
	b:SetKeyValue("DamageRadius", "10" )
	b:SetKeyValue("Damage", "5" )
	b:SetKeyValue("DamageDelay", "1" )
	b:SetKeyValue("DamageType", "16" )
	b:SetPos( trace.HitPos )
	b:Spawn()
	b:Fire("turnon", "", 0)
	b:Fire("kill", "", 5)

	self.Weapon:EmitSound("ambient/wind/wind_hit2.wav")
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )

	if (trace.HitNonWorld) then
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Weapon:AddExp( 1 )
		end
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

function SWEP:SecondaryAttack()
	if SERVER then
		local barrier = ents.Create("prop_physics")
		barrier:SetPos(self.Owner:GetShootPos())
		local rotate = self.Owner:EyeAngles()
		rotate = rotate + Angle(90,0,0)
		barrier:SetAngles(rotate)
		barrier:SetModel("models/props_junk/wood_pallet001a.mdl")
		barrier:Spawn()
		barrier:SetOwner(self.Owner)
		barrier:SetKeyValue("Rendercolor", "0 0 255")
		barrier:SetKeyValue("renderamt", "150")
		barrier:SetHealth(50)
		local phys = barrier:GetPhysicsObject()
		phys:EnableMotion(false)
	end
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
	self.Weapon:SetNextSecondaryFire( CurTime() + 5 )
end

------------General Swep Info---------------
SWEP.Author   = "Feihc"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = "Follow the holy rites of Ice Magic"
SWEP.Spawnable      = false
SWEP.AdminSpawnable  = true
-----------------------------------------------

------------Models---------------------------
function SWEP:Initialize()
	if SERVER then self:SetWeaponHoldType("normal") end
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end
-----------------------------------------------

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.9 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 15	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 10	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= 10	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "pistol"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------