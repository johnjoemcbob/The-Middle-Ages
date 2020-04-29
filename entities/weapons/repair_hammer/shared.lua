if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
	SWEP.PrintName = "Repair Hammer";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = true;
	SWEP.DrawCrosshair = false;
end

SWEP.Author			= "Matthew"
SWEP.Instructions	= "Primary to repair"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Category = "Medieval Roleplay"

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;

SWEP.ViewModel			= "models/weapons/v_sledgehammer/v_sledgehammer.mdl"
SWEP.WorldModel  		= "models/weapons/w_sledgehammer.mdl"

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.4 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 0	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 2	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= false	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type

SWEP.Secondary.Delay		= 0.4 	--In seconds
SWEP.Secondary.Recoil		= 0		--Gun Kick
SWEP.Secondary.Damage		= 0	--Damage per Bullet
SWEP.Secondary.NumShots		= 1		--Number of shots per one fire
SWEP.Secondary.Cone			= 0 	--Bullet Spread
SWEP.Secondary.ClipSize		= 2	--Use "-1 if there are no clips"
SWEP.Secondary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Secondary.Automatic   	= false	--Pistol fire (false) or SMG fire (true)
SWEP.Secondary.Ammo         = "none"	--Ammo Type

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType("melee");
	end
end

function SWEP:PrimaryAttack( ply )
	if( CurTime() < self.NextStrike ) then return; end
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)

	if SERVER then
		local trace = self.Owner:GetEyeTrace( 80 )
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
			if trace.HitNonWorld then
				if trace.Entity:GetClass() == "prop_physics" then return end
				if trace.Entity:GetClass() == "player" then return end
				trace.Entity:Remove()
				local enti = ents.Create( trace.Entity:GetClass() )
				enti:Spawn()
				enti:SetModel( trace.Entity:GetModel() )
				enti:SetMaterial( trace.Entity:GetMaterial() )
				enti:SetColor( trace.Entity:GetColor() )
				enti:Activate()
				enti:SetPos( trace.Entity:GetPos() )
				enti:SetAngles( trace.Entity:GetAngles() )
				enti.nodupe = true
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 );
end 