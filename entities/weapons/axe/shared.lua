if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
	SWEP.PrintName = "Axe";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = true;
	SWEP.DrawCrosshair = false;
end

SWEP.Author			= "Maw"
SWEP.Instructions	= "Primary to chop"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Category = "Medieval Roleplay"

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;

SWEP.ViewModel      = "models/weapons/v_axe/v_axe.mdl"
SWEP.WorldModel   = "models/weapons/w_axe.mdl"

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.4 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 0	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 2	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "logs"	--Ammo Type

SWEP.Secondary.Delay			= 0.4 	--In seconds
SWEP.Secondary.Recoil			= 0		--Gun Kick
SWEP.Secondary.Damage			= 0	--Damage per Bullet
SWEP.Secondary.NumShots		= 1		--Number of shots per one fire
SWEP.Secondary.Cone			= 0 	--Bullet Spread
SWEP.Secondary.ClipSize		= 2	--Use "-1 if there are no clips"
SWEP.Secondary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Secondary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Secondary.Ammo         = "logs"	--Ammo Type

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType("melee");
	end
end

function SWEP:PrimaryAttack( ply )
	if( CurTime() < self.NextStrike ) then return; end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)

	local llevel = self.Owner:GetNWInt("lumberinglevel")
	if llevel > 1 then
		cutchance = 9
	elseif llevel > 2 then
		cutchance = 11
	elseif llevel > 3 then
		cutchance = 13
	elseif llevel > 4 then
		cutchance = 16
	elseif llevel > 5 then
		cutchance = 19
	elseif llevel > 6 then
		cutchance = 22
	elseif llevel > 7 then
		cutchance = 24
	elseif llevel > 8 then
		cutchance = 25
	else
		cutchance = 7
	end

	if SERVER then
		local trace = self.Owner:GetEyeTrace( 80 )
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
			if trace.HitNonWorld then
				local ent = trace.Entity
				if ent:GetClass() == "tree" then
					self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
					local ShouldSpawn = math.random(1,25)
					if ShouldSpawn < cutchance then
						self.Owner:GiveItem( "wood", 1 )
						ShowTipPlayer(self.Owner, 0, 4, "Picked up a Log." )
						if self.Owner:GetNWInt("lumberinglevel") > 1 then
							leveladd = 10
						else
							leveladd = 15
						end

						local oldlexp = self.Owner:GetNWInt("lumberingexp")
						randomgain = math.random(leveladd + 4, leveladd + 8)
						LumberingLevelData[ self.Owner:UniqueID() ][ "lumberingexp" ] = oldlexp + randomgain
						self.Owner:SetNWInt( "lumberingexp", oldlexp + randomgain)

						if self.Owner:GetNWInt("lumberingexp") > 99 then
							local oldlexp = self.Owner:GetNWInt("lumberingexp")
							local oldllevel = self.Owner:GetNWInt("lumberinglevel")
							LumberingLevelData[ self.Owner:UniqueID() ][ "lumberingexp" ] = oldlexp - 100
							self.Owner:SetNWInt( "lumberingexp", oldlexp - 100)

							LumberingLevelData[ self.Owner:UniqueID() ][ "lumberinglevel" ] = oldllevel + 1
							self.Owner:SetNWInt( "lumberinglevel", oldllevel + 1)
							newlevel = oldllevel + 1
							self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Lumbering!")
						end
					end
				end
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 );
end 