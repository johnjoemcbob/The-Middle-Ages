if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
	SWEP.PrintName = "Pickaxe";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = true;
	SWEP.DrawCrosshair = false;
end

SWEP.Author			= "Maw"
SWEP.Instructions	= "Primary to Mine\nSecondary to change Mining Mode"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Category = "Medieval Roleplay"

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;

SWEP.ViewModel      = "models/weapons/v_stone_pickaxe.mdl"
SWEP.WorldModel   = "models/weapons/w_stone_pickaxe.mdl"

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
	if( SERVER ) then
		self.Owner:SetNWInt("minetype", 0)
		self:SetWeaponHoldType("melee");
	end
end

function SWEP:PrimaryAttack( ply )
	if( CurTime() < self.NextStrike ) then return; end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)

	local mlevel = self.Owner:GetNWInt("mininglevel")
	if mlevel > 1 then
		minechance = 9
	elseif mlevel > 2 then
		minechance = 11
	elseif mlevel > 3 then
		minechance = 13
	elseif mlevel > 4 then
		minechance = 16
	elseif mlevel > 5 then
		minechance = 19
	else
		minechance = 7
	end

	if self.Owner:GetNWInt("mininglevel") > 1 then
		leveladd = 2
	else
		leveladd = 4
	end

	if SERVER then
		local trace = self.Owner:GetEyeTrace( 80 )
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
			if trace.HitNonWorld then
				local ent = trace.Entity
				if ent:GetClass() == "mine" then
					self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
					local ShouldSpawn = math.random(1,100)
					if ShouldSpawn < 2 then
						local mlevel = self.Owner:GetNWInt("mininglevel")
						self.Owner:GiveItem( "uncutsapphire", 1 )
						ShowTipPlayer(self.Owner, 0, 4, "Picked up an Uncut Sapphire." )

						local oldmexp = self.Owner:GetNWInt("miningexp")
						randomgain = math.random(leveladd + 4, leveladd + 8)
						MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
						self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

						if self.Owner:GetNWInt("miningexp") > 99 then
							local oldmexp = self.Owner:GetNWInt("miningexp")
							local oldmlevel = self.Owner:GetNWInt("mininglevel")
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
							self.Owner:SetNWInt( "miningexp", oldmexp - 100)

							MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
							self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
							if self.Owner:GetNWInt("mininglevel") == 9 then
								iflevelnine = "\nYou can now pick which rocks you want to mine!"
							else
								iflevelnine = ""
							end
							newlevel = oldmlevel + 1
							self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" .. iflevelnine )
						end
					end
				end
				if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
					self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
					local ShouldSpawn = math.random(1,100)
					if ShouldSpawn < 2 then
						self.Owner:GiveItem( "uncutemerald", 1 )
						ShowTipPlayer(self.Owner, 0, 4, "Picked up an Uncut Emerald." )
						if self.Owner:GetNWInt("mininglevel") > 1 then
							leveladd = 2
						else
							leveladd = 4
						end

						local oldmexp = self.Owner:GetNWInt("miningexp")
						randomgain = math.random(leveladd + 4, leveladd + 8)
						MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
						self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

						if self.Owner:GetNWInt("miningexp") > 99 then
							local oldmexp = self.Owner:GetNWInt("miningexp")
							local oldmlevel = self.Owner:GetNWInt("mininglevel")
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
							self.Owner:SetNWInt( "miningexp", oldmexp - 100)

							MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
							self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
							if self.Owner:GetNWInt("mininglevel") == 9 then
								iflevelnine = "\nYou can now pick which rocks you want to mine!"
							else
								iflevelnine = ""
							end
							newlevel = oldmlevel + 1
							self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" .. iflevelnine )
						end
					end
				end
			end
			if self.Owner:GetNWInt("minetype") == 0 then
				if trace.HitNonWorld then
					local ent = trace.Entity
					if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
						self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
						local ShouldSpawn = math.random(1,25)
						if ShouldSpawn < minechance then
							self.Owner:GiveItem( "iron", 1 )
							ShowTipPlayer(self.Owner, 0, 4, "Picked up some Iron." )
							if self.Owner:GetNWInt("mininglevel") > 1 then
								leveladd = 2
							else
								leveladd = 4
							end

							local oldmexp = self.Owner:GetNWInt("miningexp")
							randomgain = math.random(leveladd + 4, leveladd + 8)
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
							self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

							if self.Owner:GetNWInt("miningexp") > 99 then
								local oldmexp = self.Owner:GetNWInt("miningexp")
								local oldmlevel = self.Owner:GetNWInt("mininglevel")
								MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
								self.Owner:SetNWInt( "miningexp", oldmexp - 100)

								MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
								self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
								if self.Owner:GetNWInt("mininglevel") == 9 then
									iflevelnine = "\nYou can now pick which rocks you want to mine!"
								else
									iflevelnine = ""
								end
								newlevel = oldmlevel + 1
								self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" .. iflevelnine )
							end
						end
					end
				end
				if trace.HitNonWorld then
					local ent = trace.Entity
					if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
						self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
						local ShouldSpawn = math.random(1,25)
						if ShouldSpawn < minechance then
							self.Owner:GiveItem( "copper", 1 )
							ShowTipPlayer(self.Owner, 0, 4, "Picked up some Copper." )

							local oldmexp = self.Owner:GetNWInt("miningexp")
							randomgain = math.random(leveladd + 4, leveladd + 8)
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
							self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

							if self.Owner:GetNWInt("miningexp") > 99 then
								local oldmexp = self.Owner:GetNWInt("miningexp")
								local oldmlevel = self.Owner:GetNWInt("mininglevel")
								MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
								self.Owner:SetNWInt( "miningexp", oldmexp - 100)

								MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
								self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
								if self.Owner:GetNWInt("mininglevel") == 9 then
									iflevelnine = "\nYou can now pick which rocks you want to mine!"
								else
									iflevelnine = ""
								end
								newlevel = oldmlevel + 1
								self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" .. iflevelnine )
							end
						end
					end
				end
				if trace.HitNonWorld then
					local ent = trace.Entity
					if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
						self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
						local ShouldSpawn = math.random(1,25)
						if ShouldSpawn < minechance then
							self.Owner:GiveItem( "tin", 1 )
							ShowTipPlayer(self.Owner, 0, 4, "Picked up some Tin." )

							local oldmexp = self.Owner:GetNWInt("miningexp")
							randomgain = math.random(leveladd + 4, leveladd + 8)
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
							self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

							if self.Owner:GetNWInt("miningexp") > 99 then
								local oldmexp = self.Owner:GetNWInt("miningexp")
								local oldmlevel = self.Owner:GetNWInt("mininglevel")
								MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
								self.Owner:SetNWInt( "miningexp", oldmexp - 100)

								MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
								self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
								if self.Owner:GetNWInt("mininglevel") == 9 then
									iflevelnine = "\nYou can now pick which rocks you want to mine!"
								else
									iflevelnine = ""
								end
								newlevel = oldmlevel + 1
								self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" .. iflevelnine )
							end
						end
					end
				end
			elseif self.Owner:GetNWInt("minetype") == 1 then -- Iron
				if trace.HitNonWorld then
					local ent = trace.Entity
					if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
						self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
						local ShouldSpawn = math.random(1,25)
						if ShouldSpawn < minechance then
							self.Owner:GiveItem( "iron", 1 )
							ShowTipPlayer(self.Owner, 0, 4, "Picked up some Iron." )

							local oldmexp = self.Owner:GetNWInt("miningexp")
							randomgain = math.random(leveladd + 4, leveladd + 8)
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
							self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

							if self.Owner:GetNWInt("miningexp") > 99 then
								local oldmexp = self.Owner:GetNWInt("miningexp")
								local oldmlevel = self.Owner:GetNWInt("mininglevel")
								MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
								self.Owner:SetNWInt( "miningexp", oldmexp - 100)

								MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
								self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
								newlevel = oldmlevel + 1
								self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" )
							end
						end
					end
				end
			elseif self.Owner:GetNWInt("minetype") == 2 then -- Copper
				if trace.HitNonWorld then
					local ent = trace.Entity
					if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
						self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
						local ShouldSpawn = math.random(1,25)
						if ShouldSpawn < minechance then
							self.Owner:GiveItem( "copper", 1 )
							ShowTipPlayer(self.Owner, 0, 4, "Picked up some Copper." )

							local oldmexp = self.Owner:GetNWInt("miningexp")
							randomgain = math.random(leveladd + 4, leveladd + 8)
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
							self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

							if self.Owner:GetNWInt("miningexp") > 99 then
								local oldmexp = self.Owner:GetNWInt("miningexp")
								local oldmlevel = self.Owner:GetNWInt("mininglevel")
								MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
								self.Owner:SetNWInt( "miningexp", oldmexp - 100)

								MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
								self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
								newlevel = oldmlevel + 1
								self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" )
							end
						end
					end
				end

			elseif self.Owner:GetNWInt("minetype") == 3 then -- Tin
				if trace.HitNonWorld then
					local ent = trace.Entity
					if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
						self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
						local ShouldSpawn = math.random(1,25)
						if ShouldSpawn < minechance then
							self.Owner:GiveItem( "tin", 1 )
							ShowTipPlayer(self.Owner, 0, 4, "Picked up some Tin." )

							local oldmexp = self.Owner:GetNWInt("miningexp")
							randomgain = math.random(leveladd + 4, leveladd + 8)
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
							self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

							if self.Owner:GetNWInt("miningexp") > 99 then
								local oldmexp = self.Owner:GetNWInt("miningexp")
								local oldmlevel = self.Owner:GetNWInt("mininglevel")
								MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
								self.Owner:SetNWInt( "miningexp", oldmexp - 100)

								MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
								self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
								newlevel = oldmlevel + 1
								self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" )
							end
						end
					end
				end
			elseif self.Owner:GetNWInt("minetype") == 4 then -- Jewel
				if trace.HitNonWorld then
					local ent = trace.Entity
					if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
						self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
						local ShouldSpawn = math.random(1,100)
						if ShouldSpawn < 5 then
							self.Owner:GiveItem( "uncutsapphire", 1 )
							ShowTipPlayer(self.Owner, 0, 4, "Picked up an Uncut Sapphire." )

							local oldmexp = self.Owner:GetNWInt("miningexp")
							randomgain = math.random(leveladd + 4, leveladd + 8)
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
							self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

							if self.Owner:GetNWInt("miningexp") > 99 then
								local oldmexp = self.Owner:GetNWInt("miningexp")
								local oldmlevel = self.Owner:GetNWInt("mininglevel")
								MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
								self.Owner:SetNWInt( "miningexp", oldmexp - 100)

								MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
								self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
								newlevel = oldmlevel + 1
								self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" )
							end
						end
					end
				end

				if trace.HitNonWorld then
					local ent = trace.Entity
					if string.find(ent:GetModel(), "stone") or string.find(ent:GetModel(), "rock") then
						self.Owner:EmitSound("physics/wood/wood_box_impact_bullet"..math.random(1,4)..".wav")
						local ShouldSpawn = math.random(1,100)
						if ShouldSpawn < 4 then
							self.Owner:GiveItem( "uncutemerald", 1 )
							ShowTipPlayer(self.Owner, 0, 4, "Picked up an Uncut Emerald." )

							local oldmexp = self.Owner:GetNWInt("miningexp")
							randomgain = math.random(leveladd + 4, leveladd + 8)
							MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp + randomgain
							self.Owner:SetNWInt( "miningexp", oldmexp + randomgain)

							if self.Owner:GetNWInt("miningexp") > 99 then
								local oldmexp = self.Owner:GetNWInt("miningexp")
								local oldmlevel = self.Owner:GetNWInt("mininglevel")
								MiningLevelData[ self.Owner:UniqueID() ][ "miningexp" ] = oldmexp - 100
								self.Owner:SetNWInt( "miningexp", oldmexp - 100)

								MiningLevelData[ self.Owner:UniqueID() ][ "mininglevel" ] = oldmlevel + 1
								self.Owner:SetNWInt( "mininglevel", oldmlevel + 1)
								if self.Owner:GetNWInt("mininglevel") == 9 then
									iflevelnine = "\nYou can now pick which rocks you want to mine!"
								else
									iflevelnine = ""
								end
								newlevel = oldmlevel + 1
								self.Owner:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Mining!" .. iflevelnine )
							end
						end
					end
				end
			end
		end
	end
	self.NextStrike = ( CurTime() + 0.5 );
end

function SWEP:SecondaryAttack()
	if( CurTime() < self.NextStrike ) then return; end
	if self.Owner:GetNWInt("mininglevel") > 8 then
		if self.Owner:GetNWInt("minetype") == 0 then
			self.Owner:SetNWInt("minetype", 1)
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Mine Iron Mode" )
		elseif self.Owner:GetNWInt("minetype") == 1 then
			self.Owner:SetNWInt("minetype", 2)
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Mine Copper Mode" )
		elseif self.Owner:GetNWInt("minetype") == 2 then
			self.Owner:SetNWInt("minetype", 3)
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Mine Tin Mode" )
		elseif self.Owner:GetNWInt("minetype") == 3 then
			self.Owner:SetNWInt("minetype", 4)
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Mine Jewel Mode" )
		else
			self.Owner:SetNWInt("minetype", 0)
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Mine All Mode" )
		end
	else
		self.Owner:PrintMessage( HUD_PRINTCENTER, "You need atleast level 9 Mining to select a Mining Mode." )
	end
	self.NextStrike = ( CurTime() + 1 );
end
