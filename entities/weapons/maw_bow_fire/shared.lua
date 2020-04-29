if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
	SWEP.PrintName = "Fire Bow";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = true;
	SWEP.DrawCrosshair = false;
end

SWEP.Author			= "Maw"
SWEP.Instructions	= "Primary to fire a fire arrow.\nHold Sprint and Secondary to drop the weapon."
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Category 		= "The Middle Ages"

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;
  
SWEP.ViewModel	= "models/aoc_weapon/v_longbow.mdl"
SWEP.WorldModel	= "models/aoc_weapon/w_longbow.mdl"	
  
-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.4 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 0	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 2	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type

SWEP.Secondary.Delay			= 0.4 	--In seconds
SWEP.Secondary.Recoil			= 0		--Gun Kick
SWEP.Secondary.Damage			= 0	--Damage per Bullet
SWEP.Secondary.NumShots		= 1		--Number of shots per one fire
SWEP.Secondary.Cone			= 0 	--Bullet Spread
SWEP.Secondary.ClipSize		= 2	--Use "-1 if there are no clips"
SWEP.Secondary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Secondary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Secondary.Ammo         	= "none"	--Ammo Type

function SWEP:Initialize()
end

function SWEP:Precache()
end

function SWEP:Deploy()
end

function SWEP:PrimaryAttack( ply )
	if( CurTime() < self.NextStrike ) then return end
	self.NextStrike = ( CurTime() + 1 );
	self.Weapon:EmitSound("bowshoot.wav")
	if SERVER then
		if self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_MOVELEFT) or self.Owner:KeyDown(IN_MOVERIGHT) then else
			local tr = self.Owner:GetEyeTrace() 
			local arrow = ents.Create("maw_arrow_fire")
			arrow:Spawn()
			arrow:Activate()
			arrow:SetPos(self.Owner:GetPos() + Vector(0,0,60) + self.Owner:GetAimVector() * 30) 
			arrow:SetOwner(player)
			arrow:SetAngles(self.Owner:GetAimVector():Angle())
			arrow:GetPhysicsObject():ApplyForceCenter(self.Owner:GetAimVector() *7000 + Vector(0,0,50) )
		end
	end
end

function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_SPEED) then
		local trace = {}
		trace.start = self.Owner:EyePos()
		trace.endpos = trace.start + self.Owner:GetAimVector() * 85
		trace.filter = self.Owner
		local tr = util.TraceLine(trace)
		local weapon = ents.Create("maw_bowfireent")
		weapon:SetPos(tr.HitPos)
		weapon:SetNWString("Owner", "Shared")
		weapon.nodupe = true
		weapon:Spawn()
		self.Owner:StripWeapon( "maw_bow_fire" )
	end
end 