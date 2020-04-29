if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
	SWEP.PrintName = "Chisel";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = true;
	SWEP.DrawCrosshair = true;
end

SWEP.Author			= "Maw"
SWEP.Instructions	= "Primary to cut"
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
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)

	if SERVER then
		local trace = self.Owner:GetEyeTrace( 80 )
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 200 then
			if trace.HitNonWorld then
				local ent = trace.Entity
				if ent:GetClass() == "resource_sapphire_uncut" then
					if self.Owner:GetNWInt("craftinglevel") > 26 then
						local enti = ents.Create("resource_sapphire")
						enti:Spawn()
						enti:Activate()
						enti:SetPos(self.Owner:GetPos() + Vector(0,0,60) + self.Owner:GetAimVector() * 30)
						enti.nodupe = true
						ent:Remove()
						if self.Owner:GetNWInt("craftinglevel") > 1 then
							leveladd = 30
						else
							leveladd = 45
						end

						local oldcexp = self.Owner:GetNWInt("craftingexp")
						randomgain = math.random(leveladd + 4, leveladd + 8)
						LevelData[ self.Owner:UniqueID() ][ "craftingexp" ] = oldcexp + randomgain
						self.Owner:SetNWInt( "craftingexp", oldcexp + randomgain)

						if activatorx:GetNWInt("craftingexp") > 99 then
							local oldcexp = activatorx:GetNWInt("craftingexp")
							local oldclevel = activatorx:GetNWInt("craftinglevel")
							craftingLevelData[ activatorx:UniqueID() ][ "craftingexp" ] = 0
							activatorx:SetNWInt( "craftingexp", 0)

							craftingLevelData[ activatorx:UniqueID() ][ "craftinglevel" ] = oldclevel + 1
							activatorx:SetNWInt( "craftinglevel", oldclevel + 1)
							if activatorx:GetNWInt("craftinglevel") == 12 then
								iflevel = "\nYou can now make Tables!"
							elseif activatorx:GetNWInt("craftinglevel") == 20 then
								iflevel = "\nYou can now make Fences!"
							elseif activatorx:GetNWInt("craftinglevel") == 23 then
								iflevel = "\nYou can now make Sapphire Rings!"
							elseif activatorx:GetNWInt("craftinglevel") == 27 then
								iflevel = "\nYou can now cut Sapphires!"
							elseif activatorx:GetNWInt("craftinglevel") == 29 then
								iflevel = "\nYou can now make Statues!"
							elseif activatorx:GetNWInt("craftinglevel") == 30 then
								iflevel = "\nYou can now make Emerald Rings!"
							elseif activatorx:GetNWInt("craftinglevel") == 35 then
								iflevel = "\nYou can now cut Emeralds!"
							else
								iflevel = ""
							end
							newlevel = oldclevel + 1
							activatorx:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " crafting!" .. iflevel )
						end
					else
						self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Crafting Level of 27 to cut this.")
					end

				elseif ent:GetClass() == "resource_emerald_uncut" then
					if self.Owner:GetNWInt("craftinglevel") > 35 then
						local enti = ents.Create("resource_emerald")
						enti:Spawn()
						enti:Activate()
						enti:SetPos(self.Owner:GetPos() + Vector(0,0,60) + self.Owner:GetAimVector() * 30)
						enti.nodupe = true
						ent:Remove()
						if self.Owner:GetNWInt("craftinglevel") > 1 then
							leveladd = 30
						else
							leveladd = 45
						end

						local oldcexp = self.Owner:GetNWInt("craftingexp")
						randomgain = math.random(leveladd + 4, leveladd + 8)
						CraftingLevelData[ self.Owner:UniqueID() ][ "craftingexp" ] = oldcexp + randomgain
						self.Owner:SetNWInt( "craftingexp", oldcexp + randomgain)

						if activatorx:GetNWInt("craftingexp") > 99 then
							local oldcexp = activatorx:GetNWInt("craftingexp")
							local oldclevel = activatorx:GetNWInt("craftinglevel")
							craftingLevelData[ activatorx:UniqueID() ][ "craftingexp" ] = 0
							activatorx:SetNWInt( "craftingexp", 0)

							craftingLevelData[ activatorx:UniqueID() ][ "craftinglevel" ] = oldclevel + 1
							activatorx:SetNWInt( "craftinglevel", oldclevel + 1)
							if activatorx:GetNWInt("craftinglevel") == 12 then
								iflevel = "\nYou can now make Tables!"
							elseif activatorx:GetNWInt("craftinglevel") == 20 then
								iflevel = "\nYou can now make Fences!"
							elseif activatorx:GetNWInt("craftinglevel") == 23 then
								iflevel = "\nYou can now make Sapphire Rings!"
							elseif activatorx:GetNWInt("craftinglevel") == 27 then
								iflevel = "\nYou can now cut Sapphires!"
							elseif activatorx:GetNWInt("craftinglevel") == 29 then
								iflevel = "\nYou can now make Statues!"
							elseif activatorx:GetNWInt("craftinglevel") == 30 then
								iflevel = "\nYou can now make Emerald Rings!"
							elseif activatorx:GetNWInt("craftinglevel") == 35 then
								iflevel = "\nYou can now cut Emeralds!"
							else
								iflevel = ""
							end
							newlevel = oldclevel + 1
							activatorx:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " crafting!" .. iflevel )
						end
					else
						self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Crafting Level of 36 to cut this.")
					end
				end
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 );
end

function SWEP:SecondaryAttack()
end
