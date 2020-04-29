AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "cl_inventory.lua" )
AddCSLuaFile( "cl_vgui.lua" )
AddCSLuaFile( "cl_npcchat.lua" )
AddCSLuaFile( "init.lua" )
AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )
include( 'map.lua' )
include( 'positions.lua' )
include( 'props.lua' )
include( 'inventory.lua' )
include( 'data.lua' )
include( 'commands.lua' )

DeriveGamemode("sandbox")

DB = {}

function GM:PlayerLoadout( pl )
	if CfgVars["physgun"] == 1 then
		pl:Give("weapon_physgun")
	elseif CfgVars["aphysgun"] == 1 and pl:IsAdmin() then
		pl:Give("weapon_physgun")
	end
	if CfgVars["toolgun"] == 1 then
		pl:Give( "gmod_tool" )
	elseif CfgVars["atoolgun"] == 1 and pl:IsAdmin() then
		pl:Give( "gmod_tool" )
	end
	if CfgVars["gravitygun"] == 1 then
		pl:Give("weapon_physcannon")
	end
	if CfgVars["torch"] == 1 then
		pl:Give("torch")
	end
	pl:Give( "hands" )
	pl:Give( "backpack" )
	pl:Give("keys")

	-- Weapons
	if pl:Team() == 2 then -- Guards
		if pl:GetNWInt("fightinglevel") > 34 then
			pl:Give( "sword_short_steel" )
		elseif pl:GetNWInt("fightinglevel") > 19 then
			pl:Give( "sword_short_iron" )
		else
			pl:Give( "sword_short_copper" )
		end
	elseif pl:Team() == 3 then -- Knights
		if pl:GetNWInt("fightinglevel") > 34 then
			pl:Give( "sword_short_steel" )
		elseif pl:GetNWInt("fightinglevel") > 19 then
			pl:Give( "sword_short_iron" )
		else
			pl:Give( "sword_short_copper" )
		end
	elseif pl:Team() == 8 then -- Mages
		pl:Give( "magic_light" )
		pl:Give( "magic_ice" )
	elseif pl:Team() == 11 then -- Priests
		pl:Give( "magic_healing" )
	elseif pl:Team() == 13 then -- Craftsmen
		pl:Give( "chisel" )
	elseif pl:Team() == 14 then -- Labourers
		pl:Give( "axe" )
		pl:Give( "pickaxe" )
	elseif pl:Team() == 16 then -- Wolves
		if pl:GetNWInt("animalleader") == 1 then else
			pl:Give( "claws" )
		end
	elseif pl:Team() == 17 then -- Builder
		pl:Give( "repair_hammer" )
	elseif pl:Team() == 19 then -- Druid
		pl:Give( "pill_antlion" )
		pl:Give( "pill_pigeon" )
		pl:Give( "pill_vortigaunt" )
	end

	-- Leader Weapons
	if pl:GetNWInt("animalleader") == 1 then
		pl:Give( "claws_alpha" )
		pl:Give( "fangs_alpha" )
	elseif pl:GetNWInt("bloodelfleader") == 1 then
		pl:Give( "magic_spellbook_bloodelf_leader" )
		pl:Give( "magic_spirit" )
		pl:Give( "magic_portal" )
	elseif pl:GetNWInt("darkelfleader") == 1 then
		pl:Give( "magic_spellbook_darkelf_leader" )
		pl:Give( "magic_spirit" )
	elseif pl:GetNWInt("nightelfleader") == 1 then
		pl:Give( "pill_pigeon" )
	elseif pl:GetNWInt("dwarfleader") == 1 then
		pl:Give( "sword_dwarf_leader" )
		pl:Give( "gun_dwarf_leader" )
		pl:GiveAmmo( 60, "XBowBolt" )
	elseif pl:GetNWInt("ogreleader") == 1 then
		pl:Give( "sword_ogre_leader" )
		pl:Give( "club_ogre_leader" )
	elseif pl:GetNWInt("goblinleader") == 1 then
		pl:Give( "dagger_goblin_leader" )
		pl:Give( "goblin_firebomb" )
	elseif pl:GetNWInt("humanleader") == 1 then
		pl:Give( "gun_human" )
	elseif pl:GetNWInt("undeadleader") == 1 then
		pl:Give( "magic_spirit" )
	elseif pl:GetNWInt("gnomeleader") == 1 then
		pl:Give( "grapplinghook" )
		pl:Give( "gun_dwarf_leader" )
		pl:GiveAmmo( 30, "XBowBolt" )
	end

	-- Second-in-command Weapons
	if pl:GetNWInt("dwarfsecond") == 1 then
		pl:Give( "gun_dwarf_leader" )
		pl:GiveAmmo( 30, "XBowBolt" )
	elseif pl:GetNWInt("dwarflord") == 1 then
		pl:Give( "gun_dwarf" )
		pl:GiveAmmo( 30, "XBowBolt" )
	elseif pl:GetNWInt("ogresecond") == 1 then
		pl:Give( "sword_ogre_leader" )
	elseif pl:GetNWInt("goblinsecond") == 1 then
		pl:Give( "goblin_firebomb" )
	elseif pl:GetNWInt("humansecond") == 1 then
		pl:Give( "gun_human" )
	elseif pl:GetNWInt("animalsecond") == 1 then
		pl:Give( "claws_alpha" )
	elseif pl:GetNWInt("bloodelfsecond") == 1 then
		pl:Give( "magic_spirit" )
		pl:Give( "bow_fire" )
	elseif pl:GetNWInt("undeadsecond") == 1 then
		pl:Give( "magic_spirit" )
	end
end

function OpenOptionsMenu(ply)
	umsg.Start("OptionsMenu", ply)
	umsg.End()
end
concommand.Add("mrp_openoptionsmenu", OpenOptionsMenu)

function OpenJobsMenu(ply)
	umsg.Start("JobMenu", ply)
	umsg.End()
end
concommand.Add("mrp_openjobsmenu", OpenJobsMenu)

function OpenLevelsMenu(ply)
	umsg.Start("LevelsMenu", ply)
	umsg.End()
end
concommand.Add("mrp_openlevelsmenu", OpenLevelsMenu)

function OpenExpMenu(ply)
	umsg.Start("ExpMenu", ply)
	umsg.End()
end
concommand.Add("mrp_openexpmenu", OpenExpMenu)

function OpenHUDMenu(ply)
	umsg.Start("HUDMenu", ply)
	umsg.End()
end
concommand.Add("mrp_openhudmenu", OpenHUDMenu)

function OpenHelpMenu(ply)
	umsg.Start("HelpMenu", ply)
	umsg.End()
end
concommand.Add("mrp_openhelpmenu", OpenHelpMenu)

function OpenDwarfConfirmation(ply)
	umsg.Start("DwarfConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_dwarf", OpenDwarfConfirmation)

function OpenGnomeConfirmation(ply)
	umsg.Start("GnomeConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_gnome", OpenGnomeConfirmation)

function OpenUndeadConfirmation(ply)
	umsg.Start("UndeadConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_undead", OpenUndeadConfirmation)

function OpenHumanConfirmation(ply)
	umsg.Start("HumanConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_human", OpenHumanConfirmation)

function OpenGoblinConfirmation(ply)
	umsg.Start("GoblinConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_goblin", OpenGoblinConfirmation)

function OpenTrollConfirmation(ply)
	umsg.Start("TrollConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_troll", OpenTrollConfirmation)

function OpenOgreConfirmation(ply)
	umsg.Start("OgreConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_ogre", OpenOgreConfirmation)

function OpenElfConfirmation(ply) -- (Night Elves)
	umsg.Start("ElfConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_elf", OpenElfConfirmation)

function OpenDarkElfConfirmation(ply)
	umsg.Start("DarkElfConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_darkelf", OpenDarkElfConfirmation)

function OpenBloodElfConfirmation(ply)
	umsg.Start("BloodElfConfirmationMenu", ply)
	umsg.End()
end
concommand.Add("mrp_confirmation_bloodelf", OpenBloodElfConfirmation)

function OpenMapBackground(ply)
	umsg.Start("MapBackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background", OpenMapBackground)

function OpenMap2Background(ply)
	umsg.Start("Map2BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background2", OpenMap2Background)

function OpenMap3Background(ply)
	umsg.Start("Map3BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background3", OpenMap3Background)

function OpenMap4Background(ply)
	umsg.Start("Map4BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background4", OpenMap4Background)

function OpenMap5Background(ply)
	umsg.Start("Map5BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background5", OpenMap5Background)

function OpenMap6Background(ply)
	umsg.Start("Map6BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background6", OpenMap6Background)

function OpenMap7Background(ply)
	umsg.Start("Map7BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background7", OpenMap7Background)

function OpenMap8Background(ply)
	umsg.Start("Map8BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background8", OpenMap8Background)

function OpenMap9Background(ply)
	umsg.Start("Map9BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background9", OpenMap9Background)

function OpenMap10Background(ply)
	umsg.Start("Map10BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background10", OpenMap10Background)

function OpenMap11Background(ply)
	umsg.Start("Map11BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background11", OpenMap11Background)

function OpenMap12Background(ply)
	umsg.Start("Map12BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background12", OpenMap12Background)

function OpenMap13Background(ply)
	umsg.Start("Map13BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background13", OpenMap13Background)

function OpenMap14Background(ply)
	umsg.Start("Map14BackgroundMenu", ply)
	umsg.End()
end
concommand.Add("mrp_map_background14", OpenMap14Background)

function OpenCharactersMenu(ply)
	umsg.Start("CharactersMenu", ply)
	umsg.End()
end
concommand.Add("mrp_opencharactersmenu", OpenCharactersMenu)

function OpenLoadCharactersMenu(ply)
	umsg.Start("LoadCharactersMenu", ply)
	umsg.End()
end
concommand.Add("mrp_openloadcharactermenu", OpenLoadCharactersMenu)

function OpenCreateCharactersMenu(ply)
	umsg.Start("CreateCharactersMenu", ply)
	umsg.End()
end
concommand.Add("mrp_opencreatecharactermenu", OpenCreateCharactersMenu)

function SpawnZombies(ply)
	if game.GetMap() == "gm_flatgrass2008" then else return end
	spawnzombies = 1
end
concommand.Add("mrp_strangenoises", SpawnZombies)

function CannonQuest(ply)
	if game.GetMap() == "gm_flatgrass2008" then else return end
	spawncannonquest = true
	SetGlobalInt("cannonquestdone", 0)
	SetGlobalString("cannonquestplayer", ply)
end
concommand.Add("mrp_cannonquest", CannonQuest)

function GM:ShowTeam(ply)
	if ply:Team() == 8 then
		umsg.Start("PriestPotionMenu", ply)
		umsg.End()

	elseif ply:Team() == 10 then
		umsg.Start("BlacksmithMenu", ply)
		umsg.End()

	elseif ply:Team() == 11 then
		umsg.Start("PriestPotionMenu", ply)
		umsg.End()

	elseif ply:Team() == 12 then
		umsg.Start("CookMenu", ply)
		umsg.End()

	elseif ply:Team() == 13 then
		umsg.Start("CraftsmanMenu", ply)
		umsg.End()

	elseif ply:Team() == 15 then
		umsg.Start("InnKeeperMenu", ply)
		umsg.End()
	end
end

function GM:ShowHelp(ply)
	umsg.Start("MainMenu", ply)
	umsg.End()
end

function GM:OnNPCKilled(victim, ent, weapon)
	if victim:GetClass() == "npc_kleiner" then
		if ent:IsPlayer() then ent:PrintMessage( HUD_PRINTTALK, "You don't get any experience from killing this npc." ) end
		return
	elseif victim:GetClass() == "npc_barney" then
		if ent:IsPlayer() then ent:PrintMessage( HUD_PRINTTALK, "You don't get any experience from killing this npc." ) end
		return
	elseif victim:GetClass() == "npc_gman" then
		if ent:IsPlayer() then ent:PrintMessage( HUD_PRINTTALK, "You don't get any experience from killing this npc." ) end
		return
	elseif victim:GetClass() == "npc_breen" then
		if ent:IsPlayer() then ent:PrintMessage( HUD_PRINTTALK, "You don't get any experience from killing this npc." ) end
		return
	elseif victim:GetClass() == "npc_eli" then
		if ent:IsPlayer() then ent:PrintMessage( HUD_PRINTTALK, "You don't get any experience from killing this npc." ) end
		return
	elseif victim:GetClass() == "npc_monk" then
		if ent:IsPlayer() then ent:PrintMessage( HUD_PRINTTALK, "You don't get any experience from killing this npc." ) end
		return
	elseif victim:GetClass() == "npc_mossman" then
		if ent:IsPlayer() then ent:PrintMessage( HUD_PRINTTALK, "You don't get any experience from killing this npc." ) end
		return
	end

	if ent then
		if ent:IsVehicle() and ent:GetDriver():IsPlayer() then ent = ent:GetDriver() end

		-- if it wasn't a player directly, find out who owns the prop that did the killing
		if not ent:IsPlayer() then
			ent = FindPlayerBySID(ent.SID)
		end

		if ent:GetNWInt("fightinglevel") > 1 then
			leveladd = 30
		elseif ent:GetNWInt("fightinglevel") > 2 then
			leveladd = 29
		elseif ent:GetNWInt("fightinglevel") > 3 then
			leveladd = 27
		elseif ent:GetNWInt("fightinglevel") > 3 then
			leveladd = 25
		elseif ent:GetNWInt("fightinglevel") > 4 then
			leveladd = 25
		elseif ent:GetNWInt("fightinglevel") > 5 then
			leveladd = 23
		elseif ent:GetNWInt("fightinglevel") > 6 then
			leveladd = 22
		elseif ent:GetNWInt("fightinglevel") > 7 then
			leveladd = 20
		elseif ent:GetNWInt("fightinglevel") > 8 then
			leveladd = 0
		else
			leveladd = 35
		end

		local npcclass = victim:GetClass()
		if (ent and npcclass == "npc_antlionguard") then
			local loot = math.random(1, 5)
			if loot == 1 then
				loot = ents.Create("prop_physics")
				loot:SetModel("models/nayrbarr/coin/coin.mdl")
				loot:GetTable().MoneyBag = true
				loot:GetTable().Amount = math.random(100,250)
			elseif loot == 2 then
				loot = ents.Create("bar_steel")
			elseif loot == 3 then
				loot = ents.Create("bar_iron")
			elseif loot == 4 then
				loot = ents.Create("ent_sword_long_steel")
			else
				loot = ents.Create("ent_bow")
			end
			loot:SetPos(victim:GetPos())
			loot:Spawn()
		else
			local loot = math.random(1, 5)
			if loot == 1 then
				loot = ents.Create("resource_copper")
			elseif loot == 2 then
				loot = ents.Create("resource_tin")
			elseif loot == 3 then
				loot = ents.Create("resource_iron")
			elseif loot == 4 then
				loot = ents.Create("bar_copper")
			else
				loot = ents.Create("prop_physics")
				loot:SetModel("models/nayrbarr/coin/coin.mdl")
				loot:GetTable().MoneyBag = true
				loot:GetTable().Amount = math.random(10,25)
			end
			loot:SetPos(victim:GetPos())
			loot:Spawn()
		end

		local oldfexp = ent:GetNWInt("fightingexp")
		randomgain = math.random( leveladd + 3, leveladd + 9 )
		FightingLevelData[ ent:UniqueID() ][ "fightingexp" ] = oldfexp + randomgain
		ent:SetNWInt( "fightingexp", oldfexp + randomgain)

		if ent:GetNWInt("fightingexp") > 99 then
			local oldfexp = ent:GetNWInt("fightingexp")
			local oldflevel = ent:GetNWInt("fightinglevel")
			FightingLevelData[ ent:UniqueID() ][ "fightingexp" ] = 0
			ent:SetNWInt( "fightingexp", 0)

			FightingLevelData[ ent:UniqueID() ][ "fightinglevel" ] = oldflevel + 1
			ent:SetNWInt( "fightinglevel", oldflevel + 1)
			newlevel = oldflevel + 1
			ent:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Fighting!" )
		end
	end
end

function GM:PlayerDeath(ply, weapon, killer)
	if killer then
		if killer:IsVehicle() and killer:GetDriver():IsPlayer() then killer = killer:GetDriver() end
		if killer:GetNWInt("fightinglevel") > 1 then
			leveladd = 30
		elseif killer:GetNWInt("fightinglevel") > 2 then
			leveladd = 29
		elseif killer:GetNWInt("fightinglevel") > 3 then
			leveladd = 27
		elseif killer:GetNWInt("fightinglevel") > 3 then
			leveladd = 25
		elseif killer:GetNWInt("fightinglevel") > 4 then
			leveladd = 25
		elseif killer:GetNWInt("fightinglevel") > 5 then
			leveladd = 23
		elseif killer:GetNWInt("fightinglevel") > 6 then
			leveladd = 22
		elseif killer:GetNWInt("fightinglevel") > 7 then
			leveladd = 20
		elseif killer:GetNWInt("fightinglevel") > 8 then
			leveladd = 0
		else
			leveladd = 35
		end

		if ply == killer then
			return false
		end

		if killer:IsPlayer() then
			local oldfexp = killer:GetNWInt("fightingexp")
			randomgain = math.random( leveladd + 10, leveladd + 12 )
			FightingLevelData[ killer:UniqueID() ][ "fightingexp" ] = oldfexp + randomgain
			killer:SetNWInt( "fightingexp", oldfexp + randomgain)

			if killer:GetNWInt("fightingexp") > 99 then
				local oldfexp = killer:GetNWInt("fightingexp")
				local oldflevel = killer:GetNWInt("fightinglevel")
				FightingLevelData[ killer:UniqueID() ][ "fightingexp" ] = 0
				killer:SetNWInt( "fightingexp", 0)

				FightingLevelData[ killer:UniqueID() ][ "fightinglevel" ] = oldflevel + 1
				killer:SetNWInt( "fightinglevel", oldflevel + 1)
				if killer:GetNWInt("fightinglevel") == 2 then
					iflevel = "\nYou can now use Iron Short Swords!"
				elseif killer:GetNWInt("fightinglevel") == 3 then
					iflevel = "\nYou can now use Iron Long Swords!"
				elseif killer:GetNWInt("fightinglevel") == 4 then
					iflevel = "\nYou can now use Steel Short Swords and War Axes!"
				elseif killer:GetNWInt("fightinglevel") == 5 then
					iflevel = "\nYou can now use Steel Long Swords!"
				elseif killer:GetNWInt("fightinglevel") == 7 then
					iflevel = "\nYou can now use War Hammers!\nYou are now a Master Fighter, you can use all weapons!"
				else
					iflevel = ""
				end
				newlevel = oldflevel + 1
				killer:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Fighting!" .. iflevel )
			end
		end
	end

	if ply:GetNWInt("wearingarmour") == 1 then else
		ply:SetNWInt("armour", 0 )
	end
end

function GM:Initialize()
	DataInit()

	SetGlobalInt("cannonquestdone", 1)

	-- Inventory Save
	timer.Create( "saveinventorytimer", 60, 0, function()
		TimedSaveInventory()
	end )

	-- Gold Save
	timer.Create( "SaveGoldtimer", 60, 0, function()
		TimedSaveGold()
	end )

	-- Level Save
	timer.Create( "saveleveltimer", 60, 0, function()
		TimedSaveLevel()
	end )

	-- Auto Download Files
	resource.AddFile("materials/gmod/models/wolflink.vtf")
	resource.AddFile("materials/gmod/models/wolflink.vmt")
	resource.AddFile("materials/models/wolflink/eyeball_l.vmt")
	resource.AddFile("materials/models/wolflink/eyeball_r.vmt")
	resource.AddFile("materials/models/wolflink/WolfSS00.vmt")
	resource.AddFile("materials/models/wolflink/WolfSS01.vmt")
	resource.AddFile("materials/models/wolflink/WolfSS02.vmt")
	resource.AddFile("materials/models/wolflink/WolfSS08.vmt")
	resource.AddFile("materials/models/wolflink/WolfSS00.vtf")
	resource.AddFile("materials/models/wolflink/WolfSS01.vtf")
	resource.AddFile("materials/models/wolflink/WolfSS02.vtf")
	resource.AddFile("materials/models/wolflink/WolfSS07.vtf")
	resource.AddFile("materials/models/wolflink/WolfSS08.vtf")

	resource.AddFile("materials/Bread/Bread.vmt")
	resource.AddFile("materials/Bread/Bread.vtf")
	resource.AddFile("materials/Bread/Bread_Normal.vtf")

	resource.AddFile("materials/models/weapons/axe.vmt")
	resource.AddFile("materials/models/weapons/axe.vtf")

	resource.AddFile("materials/models/torch/Torch_UVW3.vmt")
	resource.AddFile("materials/models/torch/Torch_UVW3.vtf")
	resource.AddFile("materials/models/torch/Torch_UVW3_Bump.vtf")

	resource.AddFile("materials/models/weapons/shovel/shovel1.vtf")
	resource.AddFile("materials/models/weapons/shovel/shovel1.vmt")
	resource.AddFile("materials/models/weapons/shovel/shovel1_n.vtf")
	resource.AddFile("materials/models/weapons/shovel/shovel2.vmt")
	resource.AddFile("materials/models/weapons/shovel/shovel2.vtf")
	resource.AddFile("materials/models/weapons/shovel/shovel2_n.vtf")
	resource.AddFile("materials/models/weapons/shovel/shovel3.vmt")
	resource.AddFile("materials/models/weapons/shovel/shovel3.vtf")
	resource.AddFile("materials/models/weapons/shovel/shovel3_n.vtf")

	resource.AddFile("materials/models/potion_life/glass_life_potion.vmt")
	resource.AddFile("materials/models/potion_life/glass_life_potion_trans.vmt")
	resource.AddFile("materials/models/potion_life/glass_life_potion.vtf")
	resource.AddFile("materials/models/potion_life/glass_life_potion_normal.vtf")

	resource.AddFile("materials/models/weapons/v_sword/sword.vmt")
	resource.AddFile("materials/models/weapons/v_sword/sword.vtf")

	resource.AddFile("materials/models/weapons/V_crowbar/GladiusBladeSkin.vmt")
	resource.AddFile("materials/models/weapons/V_crowbar/GladiusHiltSkin.vmt")
	resource.AddFile("materials/models/weapons/V_crowbar/GladiusBladeSkin.vtf")
	resource.AddFile("materials/models/weapons/V_crowbar/GladiusHiltSkin.vtf")

	resource.AddFile("materials/models/weapons/sledge.vmt")
	resource.AddFile("materials/models/weapons/sledge.vtf")

	resource.AddFile("materials/models/aoc_weapon/arrow.vmt")
	resource.AddFile("materials/models/aoc_weapon/bolt.vmt")
	resource.AddFile("materials/models/aoc_weapon/bolt_nm.vmt")
	resource.AddFile("materials/models/aoc_weapon/bow.vmt")
	resource.AddFile("materials/models/aoc_weapon/crossbow_metal.vmt")
	resource.AddFile("materials/models/aoc_weapon/crossbow_metal_nm.vmt")
	resource.AddFile("materials/models/aoc_weapon/crossbow_wood.vmt")
	resource.AddFile("materials/models/aoc_weapon/crossbow_wood_nm.vmt")
	resource.AddFile("materials/models/aoc_weapon/handle.vmt")
	resource.AddFile("materials/models/aoc_weapon/handle_nm.vmt")
	resource.AddFile("materials/models/aoc_weapon/handview.vmt")
	resource.AddFile("materials/models/aoc_weapon/handview1.vmt")
	resource.AddFile("materials/models/aoc_weapon/handview_nm.vmt")

	resource.AddFile("materials/models/aoc_weapon/arrow.vtf")
	resource.AddFile("materials/models/aoc_weapon/arrow_nm.vtf")
	resource.AddFile("materials/models/aoc_weapon/bolt.vtf")
	resource.AddFile("materials/models/aoc_weapon/bolt_nm.vtf")
	resource.AddFile("materials/models/aoc_weapon/bow.vtf")
	resource.AddFile("materials/models/aoc_weapon/bow_nm.vtf")
	resource.AddFile("materials/models/aoc_weapon/crossbow_metal.vtf")
	resource.AddFile("materials/models/aoc_weapon/crossbow_metal_nm.vtf")
	resource.AddFile("materials/models/aoc_weapon/crossbow_wood.vtf")
	resource.AddFile("materials/models/aoc_weapon/crossbow_wood_nm.vtf")
	resource.AddFile("materials/models/aoc_weapon/handle.vtf")
	resource.AddFile("materials/models/aoc_weapon/handle_nm.vtf")
	resource.AddFile("materials/models/aoc_weapon/handview.vtf")
	resource.AddFile("materials/models/aoc_weapon/handview1.vtf")
	resource.AddFile("materials/models/aoc_weapon/handview_nm.vtf")
	resource.AddFile("materials/models/aoc_weapon/handview_nm1.vtf")
	resource.AddFile("materials/models/aoc_weapon/handview_nm_old.vtf")
	resource.AddFile("materials/models/aoc_weapon/handview_old.vtf")

	resource.AddFile("materials/models/de_corse/statue01.vmt")
	resource.AddFile("materials/models/de_corse/statue01.vtf")

	resource.AddFile("materials/mushroom/karpassieni.vmt")
	resource.AddFile("materials/mushroom/karpassieni.vtf")
	resource.AddFile("materials/mushroom/karpassieni_normal.vtf")

	resource.AddFile("materials/models/Random_Stuff/Cake1_2.vmt")
	resource.AddFile("materials/models/Random_Stuff/Cake1_2.vtf")
	resource.AddFile("materials/models/Random_Stuff/Cake1_2_normal.vtf")

	resource.AddFile("materials/models/de_corse/fountain01.vmt")
	resource.AddFile("materials/models/de_corse/fountain01.vtf")

	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_fabric.vmt")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_face.vmt")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_metal.vmt")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_fabric.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_fabric_brown.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_fabric_nm.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_fabric_nm_brown.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_fabric_nm_org.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_fabric_org.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_face.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_face_nm.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_metal.vtf")
	resource.AddFile("materials/models/aoc_player/gfootman/good_footman_metal_nm.vtf")

	resource.AddFile("materials/models/aoc_player/gknight/ai_desperate_vip1_head.vmt")
	resource.AddFile("materials/models/aoc_player/gknight/ai_desperate_vip2_head.vmt")
	resource.AddFile("materials/models/aoc_player/gknight/ai_desperate_vip3_head.vmt")
	resource.AddFile("materials/models/aoc_player/gknight/head.vmt")
	resource.AddFile("materials/models/aoc_player/gknight/knight.vmt")
	resource.AddFile("materials/models/aoc_player/gknight/knightmetal.vmt")
	resource.AddFile("materials/models/aoc_player/gknight/head.vtf")
	resource.AddFile("materials/models/aoc_player/gknight/head_nm.vtf")
	resource.AddFile("materials/models/aoc_player/gknight/knightmetal.vtf")
	resource.AddFile("materials/models/aoc_player/gknight/knightmetal_nm.vtf")

	resource.AddFile("materials/models/aoc_player/peasant/peasant_body.vmt")
	resource.AddFile("materials/models/aoc_player/peasant/peasant_head.vmt")
	resource.AddFile("materials/models/aoc_player/peasant/peasant_body.vtf")
	resource.AddFile("materials/models/aoc_player/peasant/peasant_head.vtf")

	resource.AddFile("materials/models/v_crowbar/axeskin3.vmt")
	resource.AddFile("materials/models/v_crowbar/v_hand_sheet.vmt")
	resource.AddFile("materials/models/v_crowbar/axeskin3.vtf")
	resource.AddFile("materials/models/v_crowbar/v_hand_sheet.vtf")

	resource.AddFile("materials/props/fishtank/damselfish_color.vmt")
	resource.AddFile("materials/props/fishtank/grammabasslet_color.vmt")
	resource.AddFile("materials/props/fishtank/moorishidol_color.vmt")
	resource.AddFile("materials/props/fishtank/damselfish_color.vtf")
	resource.AddFile("materials/props/fishtank/grammabasslet_color.vtf")
	resource.AddFile("materials/props/fishtank/moorishidol_color.vtf")

	resource.AddFile("materials/models/gmstranded/props/lumber.vmt")
	resource.AddFile("materials/models/gmstranded/props/lumber_side.vmt")
	resource.AddFile("materials/models/gmstranded/props/lumber.vtf")
	resource.AddFile("materials/models/gmstranded/props/lumber_side.vtf")

	resource.AddFile("models/wolflink.dx80.vtx")
	resource.AddFile("models/wolflink.dx90.vtx")
	resource.AddFile("models/wolflink.mdl")
	resource.AddFile("models/wolflink.phy")
	resource.AddFile("models/wolflink.sw.vtx")
	resource.AddFile("models/wolflink.vvd")

	resource.AddFile("models/Bread/bread.dx80.vtx")
	resource.AddFile("models/Bread/bread.dx90.vtx")
	resource.AddFile("models/Bread/bread.mdl")
	resource.AddFile("models/Bread/bread.phy")
	resource.AddFile("models/Bread/bread.sw.vtx")
	resource.AddFile("models/Bread/bread.vvd")

	resource.AddFile("models/items/provisions/potions/life_potion.dx80.vtx")
	resource.AddFile("models/items/provisions/potions/life_potion.dx90.vtx")
	resource.AddFile("models/items/provisions/potions/life_potion.mdl")
	resource.AddFile("models/items/provisions/potions/life_potion.phy")
	resource.AddFile("models/items/provisions/potions/life_potion.sw.vtx")
	resource.AddFile("models/items/provisions/potions/life_potion.vvd")

	resource.AddFile("models/weapons/v_sword.dx80.vtx")
	resource.AddFile("models/weapons/v_sword.dx90.vtx")
	resource.AddFile("models/weapons/v_sword.mdl")
	resource.AddFile("models/weapons/v_sword.sw.vtx")
	resource.AddFile("models/weapons/v_sword.vvd")

	resource.AddFile("models/weapons/w_sword.dx80.vtx")
	resource.AddFile("models/weapons/w_sword.dx90.vtx")
	resource.AddFile("models/weapons/w_sword.mdl")
	resource.AddFile("models/weapons/w_sword.sw.vtx")
	resource.AddFile("models/weapons/w_sword.vvd")

	resource.AddFile("models/weapons/v_gladius.dx80.vtx")
	resource.AddFile("models/weapons/v_gladius.dx90.vtx")
	resource.AddFile("models/weapons/v_gladius.mdl")
	resource.AddFile("models/weapons/v_gladius.sw.vtx")
	resource.AddFile("models/weapons/v_gladius.vvd")

	resource.AddFile("models/weapons/w_gladius.dx80.vtx")
	resource.AddFile("models/weapons/w_gladius.dx90.vtx")
	resource.AddFile("models/weapons/w_gladius.mdl")
	resource.AddFile("models/weapons/w_gladius.phy")
	resource.AddFile("models/weapons/w_gladius.sw.vtx")
	resource.AddFile("models/weapons/w_gladius.vvd")

	resource.AddFile("models/weapons/v_sledgehammer/v_sledgehammer.dx80.vtx")
	resource.AddFile("models/weapons/v_sledgehammer/v_sledgehammer.dx90.vtx")
	resource.AddFile("models/weapons/v_sledgehammer/v_sledgehammer.mdl")
	resource.AddFile("models/weapons/v_sledgehammer/v_sledgehammer.sw.vtx")
	resource.AddFile("models/weapons/v_sledgehammer/v_sledgehammer.vvd")

	resource.AddFile("models/weapons/w_sledgehammer.dx80.vtx")
	resource.AddFile("models/weapons/w_sledgehammer.dx90.vtx")
	resource.AddFile("models/weapons/w_sledgehammer.mdl")
	resource.AddFile("models/weapons/w_sledgehammer.sw.vtx")
	resource.AddFile("models/weapons/w_sledgehammer.vvd")

	resource.AddFile("models/weapons/v_axe/v_axe.dx80.vtx")
	resource.AddFile("models/weapons/v_axe/v_axe.dx90.vtx")
	resource.AddFile("models/weapons/v_axe/v_axe.mdl")
	resource.AddFile("models/weapons/v_axe/v_axe.sw.vtx")
	resource.AddFile("models/weapons/v_axe/v_axe.vvd")

	resource.AddFile("models/weapons/w_axe.dx80.vtx")
	resource.AddFile("models/weapons/w_axe.dx90.vtx")
	resource.AddFile("models/weapons/w_axe.mdl")
	resource.AddFile("models/weapons/w_axe.sw.vtx")
	resource.AddFile("models/weapons/w_axe.vvd")

	resource.AddFile("models/weapons/v_stone_pickaxe.dx80.vtx")
	resource.AddFile("models/weapons/v_stone_pickaxe.dx90.vtx")
	resource.AddFile("models/weapons/v_stone_pickaxe.mdl")
	resource.AddFile("models/weapons/v_stone_pickaxe.sw.vtx")
	resource.AddFile("models/weapons/v_stone_pickaxe.vvd")

	resource.AddFile("models/weapons/w_stone_pickaxe.dx80.vtx")
	resource.AddFile("models/weapons/w_stone_pickaxe.dx90.vtx")
	resource.AddFile("models/weapons/w_stone_pickaxe.mdl")
	resource.AddFile("models/weapons/w_stone_pickaxe.sw.vtx")
	resource.AddFile("models/weapons/w_stone_pickaxe.vvd")	

	resource.AddFile("models/weapons/w_torch.dx80.vtx")
	resource.AddFile("models/weapons/w_torch.dx90.vtx")
	resource.AddFile("models/weapons/w_torch.mdl")
	resource.AddFile("models/weapons/w_torch.sw.vtx")
	resource.AddFile("models/weapons/w_torch.vvd")	

	resource.AddFile("models/weapons/v_shovel.dx80.vtx")
	resource.AddFile("models/weapons/v_shovel.dx90.vtx")
	resource.AddFile("models/weapons/v_shovel.mdl")
	resource.AddFile("models/weapons/v_shovel.sw.vtx")
	resource.AddFile("models/weapons/v_shovel.vvd")

	resource.AddFile("models/weapons/w_shovel.dx80.vtx")
	resource.AddFile("models/weapons/w_shovel.dx90.vtx")
	resource.AddFile("models/weapons/w_shovel.mdl")
	resource.AddFile("models/weapons/w_shovel.sw.vtx")
	resource.AddFile("models/weapons/w_shovel.vvd")

	resource.AddFile("models/aoc_weapon/v_longbow.dx80.vtx")
	resource.AddFile("models/aoc_weapon/v_longbow.dx90.vtx")
	resource.AddFile("models/aoc_weapon/v_longbow.mdl")
	resource.AddFile("models/aoc_weapon/v_longbow.phy")
	resource.AddFile("models/aoc_weapon/v_longbow.sw.vtx")
	resource.AddFile("models/aoc_weapon/v_longbow.vvd")
	resource.AddFile("models/aoc_weapon/v_longbow.xbox.vtx")

	resource.AddFile("models/aoc_weapon/w_longbow.dx80.vtx")
	resource.AddFile("models/aoc_weapon/w_longbow.dx90.vtx")
	resource.AddFile("models/aoc_weapon/w_longbow.mdl")
	resource.AddFile("models/aoc_weapon/w_longbow.phy")
	resource.AddFile("models/aoc_weapon/w_longbow.sw.vtx")
	resource.AddFile("models/aoc_weapon/w_longbow.vvd")
	resource.AddFile("models/aoc_weapon/w_longbow.xbox.vtx")

	resource.AddFile("models/de_corse/statue.dx80.vtx")
	resource.AddFile("models/de_corse/statue.dx90.vtx")
	resource.AddFile("models/de_corse/statue.mdl")
	resource.AddFile("models/de_corse/statue.sw.vtx")
	resource.AddFile("models/de_corse/statue.vvd")

	resource.AddFile("models/mushroom/karpassieni01.dx80.vtx")
	resource.AddFile("models/mushroom/karpassieni01.dx90.vtx")
	resource.AddFile("models/mushroom/karpassieni01.mdl")
	resource.AddFile("models/mushroom/karpassieni01.sw.vtx")
	resource.AddFile("models/mushroom/karpassieni01.vvd")
	resource.AddFile("models/mushroom/karpassieni01.xbox.vtx")

	resource.AddFile("models/Random_Stuff/Cake1-2.dx80.vtx")
	resource.AddFile("models/Random_Stuff/Cake1-2.dx90.vtx")
	resource.AddFile("models/Random_Stuff/Cake1-2.mdl")
	resource.AddFile("models/Random_Stuff/Cake1-2.sw.vtx")
	resource.AddFile("models/Random_Stuff/Cake1-2.vvd")
	resource.AddFile("models/Random_Stuff/Cake1-2.xbox.vtx")

	resource.AddFile("models/de_corse/fountain01_water.dx80.vtx")
	resource.AddFile("models/de_corse/fountain01_water.dx90.vtx")
	resource.AddFile("models/de_corse/fountain01_water.mdl")
	resource.AddFile("models/de_corse/fountain01_water.sw.vtx")
	resource.AddFile("models/de_corse/fountain01_water.vvd")

	resource.AddFile("models/medieval/lumbers/lumber.dx80.vtx")
	resource.AddFile("models/medieval/lumbers/lumber.dx90.vtx")
	resource.AddFile("models/medieval/lumbers/lumber.mdl")
	resource.AddFile("models/medieval/lumbers/lumber.sw.vtx")
	resource.AddFile("models/medieval/lumbers/lumber.vvd")

	resource.AddFile("models/player/Medievalrp/gfootman.dx80.vtx")
	resource.AddFile("models/player/Medievalrp/gfootman.dx90.vtx")
	resource.AddFile("models/player/Medievalrp/gfootman.mdl")
	resource.AddFile("models/player/Medievalrp/gfootman.sw.vtx")
	resource.AddFile("models/player/Medievalrp/gfootman.vvd")

	resource.AddFile("models/player/Medievalrp/gknight.dx80.vtx")
	resource.AddFile("models/player/Medievalrp/gknight.dx90.vtx")
	resource.AddFile("models/player/Medievalrp/gknight.mdl")
	resource.AddFile("models/player/Medievalrp/gknight.sw.vtx")
	resource.AddFile("models/player/Medievalrp/gknight.vvd")

	resource.AddFile("models/player/Medievalrp/peasant1.dx80.vtx")
	resource.AddFile("models/player/Medievalrp/peasant1.dx90.vtx")
	resource.AddFile("models/player/Medievalrp/peasant1.mdl")
	resource.AddFile("models/player/Medievalrp/peasant1.sw.vtx")
	resource.AddFile("models/player/Medievalrp/peasant1.vvd")

	resource.AddFile("models/weapons/v_waraxee.dx80.vtx")
	resource.AddFile("models/weapons/v_waraxee.dx90.vtx")
	resource.AddFile("models/weapons/v_waraxee.mdl")
	resource.AddFile("models/weapons/v_waraxee.phy")
	resource.AddFile("models/weapons/v_waraxee.sw.vtx")
	resource.AddFile("models/weapons/v_waraxee.vvd")

	resource.AddFile("models/props/prop_damselfish.dx80.vtx")
	resource.AddFile("models/props/prop_damselfish.dx90.vtx")
	resource.AddFile("models/props/prop_damselfish.mdl")
	resource.AddFile("models/props/prop_damselfish.phy")
	resource.AddFile("models/props/prop_damselfish.sw.vtx")
	resource.AddFile("models/props/prop_damselfish.vvd")

	resource.AddFile("models/props/prop_grammabasslet.dx80.vtx")
	resource.AddFile("models/props/prop_grammabasslet.dx90.vtx")
	resource.AddFile("models/props/prop_grammabasslet.mdl")
	resource.AddFile("models/props/prop_grammabasslet.phy")
	resource.AddFile("models/props/prop_grammabasslet.sw.vtx")
	resource.AddFile("models/props/prop_grammabasslet.vvd")

	resource.AddFile("models/props/prop_moorishidol.dx80.vtx")
	resource.AddFile("models/props/prop_moorishidol.dx90.vtx")
	resource.AddFile("models/props/prop_moorishidol.mdl")
	resource.AddFile("models/props/prop_moorishidol.phy")
	resource.AddFile("models/props/prop_moorishidol.sw.vtx")
	resource.AddFile("models/props/prop_moorishidol.vvd")

	resource.AddFile("sound/weapons/stingwraith_sword/sword_hit.wav")
	resource.AddFile("sound/weapons/stingwraith_sword/sword_flesh.wav")
	resource.AddFile("sound/weapons/stingwraith_sword/sword_swing_4.wav")
	resource.AddFile("sound/weapons/stingwraith_sword/sword_swing_3.wav")
	resource.AddFile("sound/weapons/stingwraith_sword/sword_swing_2.wav")
	resource.AddFile("sound/weapons/stingwraith_sword/sword_swing_1.wav")
	resource.AddFile("sound/weapons/stingwraith_sword/longbladOUT.wav")

	resource.AddFile("sound/wolf/howl.wav")

	resource.AddFile("sound/box1.wav")
	resource.AddFile("sound/box2.wav")

	resource.AddFile("sound/runner/alert1.wav")
	resource.AddFile("sound/runner/alert2.wav")
	resource.AddFile("sound/runner/angry1.wav")
	resource.AddFile("sound/runner/angry2.wav")
	resource.AddFile("sound/runner/angry3.wav")
	resource.AddFile("sound/runner/attack.wav")
	resource.AddFile("sound/runner/attack2.wav")
	resource.AddFile("sound/runner/attack3.wav")
	resource.AddFile("sound/runner/death1.wav")
	resource.AddFile("sound/runner/death2.wav")
	resource.AddFile("sound/runner/hiss.wav")
	resource.AddFile("sound/runner/roar_old.wav")
	resource.AddFile("sound/runner/stalk.wav")
	resource.AddFile("sound/runner/stalk2.wav")
	resource.AddFile("sound/runner/stalk3.wav")

	resource.AddFile("sound/ambient/Blacksmith.wav")
	resource.AddFile("sound/ambient/Tavern.wav")
	resource.AddFile("sound/ambient/Tavern2.wav")
	resource.AddFile("sound/ambient/Mine.wav")
	resource.AddFile("sound/ambient/Eerie.wav")

	resource.AddFile("sound/NPCs/Good/Greeting1.wav")
	resource.AddFile("sound/NPCs/Good/Greeting2.wav")
	resource.AddFile("sound/NPCs/Good/Greeting3.wav")
	resource.AddFile("sound/NPCs/Good/Greeting4.wav")
	resource.AddFile("sound/NPCs/Good/Greeting5.wav")
	resource.AddFile("sound/NPCs/Good/Greeting6.wav")

	resource.AddFile("sound/NPCs/Evil/Greeting1.wav")
	resource.AddFile("sound/NPCs/Evil/Greeting2.wav")
	resource.AddFile("sound/NPCs/Evil/Greeting3.wav")
	resource.AddFile("sound/NPCs/Evil/Greeting4.wav")
	resource.AddFile("sound/NPCs/Evil/Greeting5.wav")

	-- Nayrbarr's

	resource.AddFile("materials/nayrbarr/anvil/STEELPLT.vmt")
	resource.AddFile("materials/nayrbarr/anvil/STEELPLT.vtf")

	resource.AddFile("materials/nayrbarr/Coin/Coin.vmt")
	resource.AddFile("materials/nayrbarr/Coin/Coin.vtf")

	resource.AddFile("materials/nayrbarr/Iron/scuffed metal.vmt")
	resource.AddFile("materials/nayrbarr/Iron/scuffed metal.vtf")

	resource.AddFile("materials/nayrbarr/smelter/dark scuffed metal.vmt")
	resource.AddFile("materials/nayrbarr/smelter/dark scuffed metal.vtf")
	resource.AddFile("materials/nayrbarr/smelter/Smelter.vmt")
	resource.AddFile("materials/nayrbarr/smelter/Smelter.vtf")

	resource.AddFile("models/nayrbarr/anvil/anvil.dx80.vtx")
	resource.AddFile("models/nayrbarr/anvil/anvil.dx90.vtx")
	resource.AddFile("models/nayrbarr/anvil/anvil.mdl")
	resource.AddFile("models/nayrbarr/anvil/anvil.phy")
	resource.AddFile("models/nayrbarr/anvil/anvil.sw.vtx")
	resource.AddFile("models/nayrbarr/anvil/anvil.vvd")
	resource.AddFile("models/nayrbarr/anvil/anvil.xbox.vtx")

	resource.AddFile("models/nayrbarr/coin/coin.dx80.vtx")
	resource.AddFile("models/nayrbarr/coin/coin.dx90.vtx")
	resource.AddFile("models/nayrbarr/coin/coin.mdl")
	resource.AddFile("models/nayrbarr/coin/coin.phy")
	resource.AddFile("models/nayrbarr/coin/coin.sw.vtx")
	resource.AddFile("models/nayrbarr/coin/coin.vvd")
	resource.AddFile("models/nayrbarr/coin/coin.xbox.vtx")

	resource.AddFile("models/nayrbarr/iron/iron.dx80.vtx")
	resource.AddFile("models/nayrbarr/iron/iron.dx90.vtx")
	resource.AddFile("models/nayrbarr/iron/iron.mdl")
	resource.AddFile("models/nayrbarr/iron/iron.phy")
	resource.AddFile("models/nayrbarr/iron/iron.sw.vtx")
	resource.AddFile("models/nayrbarr/iron/iron.vvd")
	resource.AddFile("models/nayrbarr/iron/iron.xbox.vtx")

	resource.AddFile("models/nayrbarr/Smelter/smelter.dx80.vtx")
	resource.AddFile("models/nayrbarr/Smelter/smelter.dx90.vtx")
	resource.AddFile("models/nayrbarr/Smelter/smelter.mdl")
	resource.AddFile("models/nayrbarr/Smelter/smelter.phy")
	resource.AddFile("models/nayrbarr/Smelter/smelter.sw.vtx")
	resource.AddFile("models/nayrbarr/Smelter/smelter.vvd")
	resource.AddFile("models/nayrbarr/Smelter/smelter.xbox.vtx")

	-- Silver Sword

	resource.AddFile("materials/models/npc_player/player_armor_1.vmt")
	resource.AddFile("materials/models/npc_player/player_armor_1.vtf")
	resource.AddFile("materials/models/npc_player/player_armor_1_normal.vtf")
	resource.AddFile("materials/models/npc_player/player_armor_2.vmt")
	resource.AddFile("materials/models/npc_player/player_armor_2.vtf")
	resource.AddFile("materials/models/npc_player/player_armor_2_normal.vtf")
	resource.AddFile("materials/models/npc_player/player_chain_1.vmt")
	resource.AddFile("materials/models/npc_player/player_chain_1.vtf")
	resource.AddFile("materials/models/npc_player/player_chain_1_normal.vtf")
	resource.AddFile("materials/models/npc_player/player_gloves_2.vmt")
	resource.AddFile("materials/models/npc_player/player_gloves_2.vtf")
	resource.AddFile("materials/models/npc_player/player_gloves_2_left.vmt")
	resource.AddFile("materials/models/npc_player/player_gloves_2_normal.vtf")
	resource.AddFile("materials/models/npc_player/wp_sword_silver.vtf")
	resource.AddFile("materials/models/npc_player/wp_sword_silver_normal.vtf")

	resource.AddFile("materials/models/weapons/v_hand/player_armor_1.vmt")
	resource.AddFile("materials/models/weapons/v_hand/player_armor_2.vmt")
	resource.AddFile("materials/models/weapons/v_hand/player_chain_1.vmt")
	resource.AddFile("materials/models/weapons/v_hand/player_gloves_2.vmt")
	resource.AddFile("materials/models/weapons/v_hand/player_gloves_2_left.vmt")
	resource.AddFile("materials/models/weapons/v_hand/wp_sword_silver.vmt")

	resource.AddFile("materials/models/wp_sword_silver/wp_sword_silver.vtf")
	resource.AddFile("materials/models/wp_sword_silver/wp_sword_silver_normal.vtf")

	resource.AddFile("materials/weapons/weapon_sword_silver.vmt")
	resource.AddFile("materials/weapons/weapon_sword_silver.vtf")

	resource.AddFile("models/weapons/v_sword_silver.dx80.vtx")
	resource.AddFile("models/weapons/v_sword_silver.dx90.vtx")
	resource.AddFile("models/weapons/v_sword_silver.mdl")
	resource.AddFile("models/weapons/v_sword_silver.sw.vtx")
	resource.AddFile("models/weapons/v_sword_silver.vvd")
	resource.AddFile("models/weapons/v_sword_silver.xbox.vtx")

	resource.AddFile("models/weapons/w_sword_silver.dx80.vtx")
	resource.AddFile("models/weapons/w_sword_silver.dx90.vtx")
	resource.AddFile("models/weapons/w_sword_silver.mdl")
	resource.AddFile("models/weapons/w_sword_silver.phy")
	resource.AddFile("models/weapons/w_sword_silver.sw.vtx")
	resource.AddFile("models/weapons/w_sword_silver.vvd")
	resource.AddFile("models/weapons/w_sword_silver.xbox.vtx")

	-- Goblin

	resource.AddFile("materials/models/player/elis/gb/eyeball_l.vmt")
	resource.AddFile("materials/models/player/elis/gb/eyeball_r.vmt")
	resource.AddFile("materials/models/player/elis/gb/goblin_basic.vmt")
	resource.AddFile("materials/models/player/elis/gb/eyeball_l.vtf")
	resource.AddFile("materials/models/player/elis/gb/eyeball_r.vtf")
	resource.AddFile("materials/models/player/elis/gb/goblin_basic.vtf")
	resource.AddFile("materials/models/player/elis/gb/goblin_normal.vtf")

	resource.AddFile("models/player/goblin/goblin.dx80.vtx")
	resource.AddFile("models/player/goblin/goblin.dx90.vtx")
	resource.AddFile("models/player/goblin/goblin.mdl")
	resource.AddFile("models/player/goblin/goblin.phy")
	resource.AddFile("models/player/goblin/goblin.sw.vtx")
	resource.AddFile("models/player/goblin/goblin.vvd")
	resource.AddFile("models/player/goblin/goblin.xbox.vtx")

	resource.AddFile("models/goblin/goblin.dx80.vtx")
	resource.AddFile("models/goblin/goblin.dx90.vtx")
	resource.AddFile("models/goblin/goblin.mdl")
	resource.AddFile("models/goblin/goblin.phy")
	resource.AddFile("models/goblin/goblin.sw.vtx")
	resource.AddFile("models/goblin/goblin.vvd")
	resource.AddFile("models/goblin/goblin.xbox.vtx")

	-- Ogre

	resource.AddFile("materials/models/player/slow/krall/slow_armor.vmt")
	resource.AddFile("materials/models/player/slow/krall/slow_body.vmt")
	resource.AddFile("materials/models/player/slow/krall/slow_head.vmt")
	resource.AddFile("materials/models/player/slow/krall/slow_head.vmt")
	resource.AddFile("materials/models/player/slow/krall/slow_legs.vmt")
	resource.AddFile("materials/models/player/slow/krall/slow_body.vtf")
	resource.AddFile("materials/models/player/slow/krall/slow_body_bump.vtf")
	resource.AddFile("materials/models/player/slow/krall/slow_head.vtf")
	resource.AddFile("materials/models/player/slow/krall/slow_head_bump.vtf")

	resource.AddFile("models/player/krall/slow.dx80.vtx")
	resource.AddFile("models/player/krall/slow.dx90.vtx")
	resource.AddFile("models/player/krall/slow.mdl")
	resource.AddFile("models/player/krall/slow.phy")
	resource.AddFile("models/player/krall/slow.sw.vtx")
	resource.AddFile("models/player/krall/slow.vvd")
	resource.AddFile("models/player/krall/slow.xbox.vtx")

	resource.AddFile("models/krall/slow.dx80.vtx")
	resource.AddFile("models/krall/slow.dx90.vtx")
	resource.AddFile("models/krall/slow.mdl")
	resource.AddFile("models/krall/slow.phy")
	resource.AddFile("models/krall/slow.sw.vtx")
	resource.AddFile("models/krall/slow.vvd")
	resource.AddFile("models/krall/slow.xbox.vtx")

	-- Undead/Skeleton

	resource.AddFile("materials/models/player/elis/ud/zombie01.vmt")
	resource.AddFile("materials/models/player/elis/ud/zombie01.vtf")
	resource.AddFile("materials/models/player/elis/ud/zombie01_normal.vtf")

	resource.AddFile("models/player/undead/undead.dx80.vtx")
	resource.AddFile("models/player/undead/undead.dx90.vtx")
	resource.AddFile("models/player/undead/undead.mdl")
	resource.AddFile("models/player/undead/undead.phy")
	resource.AddFile("models/player/undead/undead.sw.vtx")
	resource.AddFile("models/player/undead/undead.xbox.vtx")
	resource.AddFile("models/player/undead/undead.vvd")

	resource.AddFile("models/undead/undead.dx80.vtx")
	resource.AddFile("models/undead/undead.dx90.vtx")
	resource.AddFile("models/undead/undead.mdl")
	resource.AddFile("models/undead/undead.phy")
	resource.AddFile("models/undead/undead.sw.vtx")
	resource.AddFile("models/undead/undead.xbox.vtx")
	resource.AddFile("models/undead/undead.vvd")

	-- Troll

	resource.AddFile("materials/models/player/elis/hk/Estuche.vmt")
	resource.AddFile("materials/models/player/elis/hk/hellknight.vmt")
	resource.AddFile("materials/models/player/elis/hk/Estuche.vtf")
	resource.AddFile("materials/models/player/elis/hk/hellknight.vtf")
	resource.AddFile("materials/models/player/elis/hk/hellknight_normal.vtf")

	resource.AddFile("models/player/hellknight/hellknight.dx80.vtx")
	resource.AddFile("models/player/hellknight/hellknight.dx90.vtx")
	resource.AddFile("models/player/hellknight/hellknight.mdl")
	resource.AddFile("models/player/hellknight/hellknight.phy")
	resource.AddFile("models/player/hellknight/hellknight.sw.vtx")
	resource.AddFile("models/player/hellknight/hellknight.xbox.vtx")
	resource.AddFile("models/player/hellknight/hellknight.vvd")

	resource.AddFile("models/hellknight/hellknight.dx80.vtx")
	resource.AddFile("models/hellknight/hellknight.dx90.vtx")
	resource.AddFile("models/hellknight/hellknight.mdl")
	resource.AddFile("models/hellknight/hellknight.phy")
	resource.AddFile("models/hellknight/hellknight.sw.vtx")
	resource.AddFile("models/hellknight/hellknight.xbox.vtx")
	resource.AddFile("models/hellknight/hellknight.vvd")

	-- Map
		-- Background
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map1.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map2.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map3.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map4.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map5.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map6.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map7.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map8.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map9.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map10.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map11.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map12.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map13.vmt")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map14.vmt")

	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map1.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map2.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map3.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map4.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map5.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map6.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map7.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map8.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map9.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map10.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map11.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map12.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map13.vtf")
	resource.AddFile("materials/medievalrp/Maps/backgrounds/Map14.vtf")

	-- HUD

	resource.AddFile("materials/medievalrp/HUD/hud_undead.vmt")
	resource.AddFile("materials/medievalrp/HUD/hud_dwarf.vmt")
	resource.AddFile("materials/medievalrp/HUD/hud_human.vmt")
	resource.AddFile("materials/medievalrp/HUD/hud_bloodelf.vmt")
	resource.AddFile("materials/medievalrp/HUD/hud_nightelf.vmt")
	resource.AddFile("materials/medievalrp/HUD/hud_ogre.vmt")

	resource.AddFile("materials/medievalrp/HUD/hud_undead.vtf")
	resource.AddFile("materials/medievalrp/HUD/hud_dwarf.vtf")
	resource.AddFile("materials/medievalrp/HUD/hud_human.vtf")
	resource.AddFile("materials/medievalrp/HUD/hud_bloodelf.vtf")
	resource.AddFile("materials/medievalrp/HUD/hud_nightelf.vtf")
	resource.AddFile("materials/medievalrp/HUD/hud_ogre.vtf")

	-- Propper

	resource.AddFile("materials/models/props/generated_prop/stonefloor006a.vmt")
	resource.AddFile("materials/models/props/generated_prop/stonewall029a.vmt")
	resource.AddFile("materials/models/props/generated_prop/stonewall050a.vmt")
	resource.AddFile("materials/models/props/generated_prop/woodfloor006a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/centre/infflra.vmt")

	resource.AddFile("materials/models/the_middle_ages/map/felrendor/brickwall021a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/brickwall034a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/brickwall034e.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/coin.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/concreteceiling004a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/concretefloor009a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/concretefloor012a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/concretefloor032a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/concretewall074c.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/copper.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/dark scuffed metal.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/dev_blendmeasure.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/dev_measurecrate01.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/dev_measuregeneric01b.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/dev_measurewall01a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/dev_measurewall01d.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/door011.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/glass2.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/glasswindow015a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/glasswindow070c.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/inffla.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/marblefloor001b.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/marblefloor001c.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/metal02.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/metalarch004b.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/metalgrate014a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/metalwall006b.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/metalwall029a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/milflr002.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/miwoodm.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/pi_wood1.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/plasterceiling006a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/plasterwall043e.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/prodwndwa.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/pwood1.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/red_grass.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/steelplt.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonewall006a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonewall013a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonewall036a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonewall044a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonewall044c.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonewall051b.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonewall051c.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonework01a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonework01g.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonework01mossa.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonework01mossc.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/stonework05.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/tides_floor_wood.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/tides_roof_1.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/toolsblack.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/train_metalceiling_02.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/wood_plank_7.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodbeam01.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodceiling01.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/wooddoor003a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodfloor001a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodfloor005a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodfloor006b.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodfloor007a_c17.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodfloor008a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodi.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodm.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodstair002a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodstair002b.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodstair002c.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodwall009a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodwall028a.vmt")
	resource.AddFile("materials/models/the_middle_ages/map/felrendor/woodwall043a.vmt")

	resource.AddFile("materials/nayrbarr/Chest/copper.vtf")
	resource.AddFile("materials/nayrbarr/Chest/dark scuffed metal.vtf")

	resource.AddFile("models/castledoor.dx80.vtx")
	resource.AddFile("models/castledoor.dx90.vtx")
	resource.AddFile("models/castledoor.mdl")
	resource.AddFile("models/castledoor.phy")
	resource.AddFile("models/castledoor.sw.vtx")
	resource.AddFile("models/castledoor.vvd")
	resource.AddFile("models/castlegate.dx80.vtx")
	resource.AddFile("models/castlegate.dx90.vtx")
	resource.AddFile("models/castlegate.mdl")
	resource.AddFile("models/castlegate.phy")
	resource.AddFile("models/castlegate.sw.vtx")
	resource.AddFile("models/castlegate.vvd")
	resource.AddFile("models/castlewall1.dx80.vtx")
	resource.AddFile("models/castlewall1.dx90.vtx")
	resource.AddFile("models/castlewall1.mdl")
	resource.AddFile("models/castlewall1.phy")
	resource.AddFile("models/castlewall1.sw.vtx")
	resource.AddFile("models/castlewall1.vvd")
	resource.AddFile("models/inn.dx80.vtx")
	resource.AddFile("models/inn.dx90.vtx")
	resource.AddFile("models/inn.mdl")
	resource.AddFile("models/inn.phy")
	resource.AddFile("models/inn.sw.vtx")
	resource.AddFile("models/inn.vvd")
	resource.AddFile("models/inn.xbox.vtx")
	resource.AddFile("models/house1.dx80.vtx")
	resource.AddFile("models/house1.dx90.vtx")
	resource.AddFile("models/house1.mdl")
	resource.AddFile("models/house1.phy")
	resource.AddFile("models/house1.sw.vtx")
	resource.AddFile("models/house1.vvd")
	resource.AddFile("models/house1.xbox.vtx")
	resource.AddFile("models/house2.dx80.vtx")
	resource.AddFile("models/house2.dx90.vtx")
	resource.AddFile("models/house2.mdl")
	resource.AddFile("models/house2.phy")
	resource.AddFile("models/house2.sw.vtx")
	resource.AddFile("models/house2.vvd")
	resource.AddFile("models/house2.xbox.vtx")
	resource.AddFile("models/house3.dx80.vtx")
	resource.AddFile("models/house3.dx90.vtx")
	resource.AddFile("models/house3.mdl")
	resource.AddFile("models/house3.phy")
	resource.AddFile("models/house3.sw.vtx")
	resource.AddFile("models/house3.vvd")
	resource.AddFile("models/house3.xbox.vtx")
	resource.AddFile("models/smithy.dx80.vtx")
	resource.AddFile("models/smithy.dx90.vtx")
	resource.AddFile("models/smithy.mdl")
	resource.AddFile("models/smithy.phy")
	resource.AddFile("models/smithy.sw.vtx")
	resource.AddFile("models/smithy.vvd")
	resource.AddFile("models/smithy.xbox.vtx")
	resource.AddFile("models/door.dx80.vtx")
	resource.AddFile("models/door.dx90.vtx")
	resource.AddFile("models/door.mdl")
	resource.AddFile("models/door.phy")
	resource.AddFile("models/door.sw.vtx")
	resource.AddFile("models/door.vvd")
	resource.AddFile("models/door.xbox.vtx")
	resource.AddFile("models/church.dx80.vtx")
	resource.AddFile("models/church.dx90.vtx")
	resource.AddFile("models/church.mdl")
	resource.AddFile("models/church.phy")
	resource.AddFile("models/church.sw.vtx")
	resource.AddFile("models/church.vvd")
	resource.AddFile("models/church.xbox.vtx")
	resource.AddFile("models/fountain.dx80.vtx")
	resource.AddFile("models/fountain.dx90.vtx")
	resource.AddFile("models/fountain.mdl")
	resource.AddFile("models/fountain.phy")
	resource.AddFile("models/fountain.sw.vtx")
	resource.AddFile("models/fountain.vvd")
	resource.AddFile("models/fountain.xbox.vtx")
	resource.AddFile("models/ship.dx80.vtx")
	resource.AddFile("models/ship.dx90.vtx")
	resource.AddFile("models/ship.mdl")
	resource.AddFile("models/ship.phy")
	resource.AddFile("models/ship.sw.vtx")
	resource.AddFile("models/ship.vvd")
	resource.AddFile("models/ship.xbox.vtx")

		resource.AddFile("models/sword.dx80.vtx")
		resource.AddFile("models/sword.dx90.vtx")
		resource.AddFile("models/sword.mdl")
		resource.AddFile("models/sword.phy")
		resource.AddFile("models/sword.sw.vtx")
		resource.AddFile("models/sword.vvd")
		resource.AddFile("models/sword.xbox.vtx")
		resource.AddFile("models/ruins1.dx80.vtx")
		resource.AddFile("models/ruins1.dx90.vtx")
		resource.AddFile("models/ruins1.mdl")
		resource.AddFile("models/ruins1.phy")
		resource.AddFile("models/ruins1.sw.vtx")
		resource.AddFile("models/ruins1.vvd")
		resource.AddFile("models/ruins1.xbox.vtx")
		resource.AddFile("models/ruins2.dx80.vtx")
		resource.AddFile("models/ruins2.dx90.vtx")
		resource.AddFile("models/ruins2.mdl")
		resource.AddFile("models/ruins2.phy")
		resource.AddFile("models/ruins2.sw.vtx")
		resource.AddFile("models/ruins2.vvd")
		resource.AddFile("models/ruins2.xbox.vtx")
		resource.AddFile("models/centre.dx80.vtx")
		resource.AddFile("models/centre.dx90.vtx")
		resource.AddFile("models/centre.mdl")
		resource.AddFile("models/centre.phy")
		resource.AddFile("models/centre.sw.vtx")
		resource.AddFile("models/centre.vvd")
		resource.AddFile("models/centre.xbox.vtx")
		resource.AddFile("models/cannon.dx80.vtx")
		resource.AddFile("models/cannon.dx90.vtx")
		resource.AddFile("models/cannon.mdl")
		resource.AddFile("models/cannon.phy")
		resource.AddFile("models/cannon.sw.vtx")
		resource.AddFile("models/cannon.vvd")
		resource.AddFile("models/cannon.xbox.vtx")

		resource.AddFile("models/tower1.dx80.vtx")
		resource.AddFile("models/tower1.dx90.vtx")
		resource.AddFile("models/tower1.mdl")
		resource.AddFile("models/tower1.phy")
		resource.AddFile("models/tower1.sw.vtx")
		resource.AddFile("models/tower1.vvd")
		resource.AddFile("models/tower1.xbox.vtx")
		resource.AddFile("models/tower2.dx80.vtx")
		resource.AddFile("models/tower2.dx90.vtx")
		resource.AddFile("models/tower2.mdl")
		resource.AddFile("models/tower2.phy")
		resource.AddFile("models/tower2.sw.vtx")
		resource.AddFile("models/tower2.vvd")
		resource.AddFile("models/tower2.xbox.vtx")
		resource.AddFile("models/tower3.dx80.vtx")
		resource.AddFile("models/tower3.dx90.vtx")
		resource.AddFile("models/tower3.mdl")
		resource.AddFile("models/tower3.phy")
		resource.AddFile("models/tower3.sw.vtx")
		resource.AddFile("models/tower3.vvd")
		resource.AddFile("models/tower3.xbox.vtx")
		resource.AddFile("models/tower4.dx80.vtx")
		resource.AddFile("models/tower4.dx90.vtx")
		resource.AddFile("models/tower4.mdl")
		resource.AddFile("models/tower4.phy")
		resource.AddFile("models/tower4.sw.vtx")
		resource.AddFile("models/tower4.vvd")
		resource.AddFile("models/tower4.xbox.vtx")
		resource.AddFile("models/tower5.dx80.vtx")
		resource.AddFile("models/tower5.dx90.vtx")
		resource.AddFile("models/tower5.mdl")
		resource.AddFile("models/tower5.phy")
		resource.AddFile("models/tower5.sw.vtx")
		resource.AddFile("models/tower5.vvd")
		resource.AddFile("models/tower5.xbox.vtx")
		resource.AddFile("models/tower6.dx80.vtx")
		resource.AddFile("models/tower6.dx90.vtx")
		resource.AddFile("models/tower6.mdl")
		resource.AddFile("models/tower6.phy")
		resource.AddFile("models/tower6.sw.vtx")
		resource.AddFile("models/tower6.vvd")
		resource.AddFile("models/tower6.xbox.vtx")
end

function GM:PlayerInitialSpawn( ply )
	ply:SetNWInt("HUD", 1) -- Shows the HUD ( 0 = No HUD )
	PrintMessage( HUD_PRINTTALK, ply:GetName() .. "( " .. ply:SteamID() .. ") is now playing!" )
	ply:SetNWInt("HUDexpbar", math.random( 1, 8 ))
	ply:SetNWInt("wearingarmour", 0)
	ply:SetNWInt("nexttravel", 0)
	ply:SetNWInt("armour", 0)
	ply:SetNWInt("hunger", 100)
	ply:SetNWInt("fightingexp", 0)
	ply:SetNWInt("fightinglevel", 0)

	timer.Create( "Hunger "..ply:UniqueID(), 10, 0, function()
		if CfgVars["hunger"] == 1 then
			if ply:GetNWInt("hunger") > 0 then
				ply:SetNWInt("hunger", ply:GetNWInt("hunger") - 1)
			end
		end
	end )

	ply:GetTable().Ownedz = { }
	ply:GetTable().OwnedNumz = 0
end

function GM:PlayerSpawn(ply)
	self.BaseClass:PlayerSpawn(ply)
	ply:CrosshairEnable()
	ply:SetColor(255, 255, 255, 255)

	--Kill any colormod anyway
	ply:ConCommand("pp_colormod_brightness 0")

	if CfgVars["allowcustommodels"] == 0 then
		if ply:GetNWString("race") ==  "Goblin" then
			ply:SetModel("models/player/goblin/goblin.mdl")
		elseif ply:GetNWString("race") ==  "Ogre" then
			ply:SetModel("models/player/krall/slow.mdl")
		elseif ply:GetNWString("race") ==  "Undead" then
			ply:SetModel("models/player/undead/undead.mdl")
		elseif ply:GetNWString("race") ==  "Troll" then
			ply:SetModel("models/player/hellknight/hellknight.mdl")
		else
			if ply:Team() == 1 then -- Peasant
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/Medievalrp/peasant1.mdl")
				else
					ply:SetModel("models/player/Group01/Female_01.mdl")
				end
			elseif ply:Team() == 2 then -- Guard
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/Medievalrp/gfootman.mdl")
				else
					ply:SetModel("models/player/Group01/Female_02.mdl")
				end
			elseif ply:Team() == 3 then -- Knight
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/Medievalrp/gknight.mdl")
				else
					ply:SetModel("models/player/Group01/Female_03.mdl")
				end
			elseif ply:Team() == 4 then -- King
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/breen.mdl")
				else
					ply:SetModel("models/player/alyx.mdl")
				end
			elseif ply:Team() == 8 then -- Mage
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/monk.mdl")
				else
					ply:SetModel("models/player/alyx.mdl")
				end
			elseif ply:Team() == 10 then -- Blacksmith
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/kleiner.mdl")
				else
					ply:SetModel("models/player/mossman.mdl")
				end
			elseif ply:Team() == 11 then -- Priest
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/monk.mdl")
				else
					ply:SetModel("models/player/alyx.mdl")
				end
			elseif ply:Team() == 12 then -- Cook
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/monk.mdl")
				else
					ply:SetModel("models/player/mossman.mdl")
				end
			elseif ply:Team() == 15 then -- Inn Keeper
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/barney.mdl")
				else
					ply:SetModel("models/player/mossman.mdl")
				end
			elseif ply:Team() == 16 then -- Wolf
				ply:SetModel("models/wolflink.mdl")
			else
				if ply:GetNWString("sex") == "Male" then
					ply:SetModel("models/player/group03/male_06.mdl")
				else
					ply:SetModel("models/player/group03/female_06.mdl")
				end
				ply:SetColor(240, 240, 255, 255)
			end
		end
	end

	if ply:GetNWString("race") == "Night Elf" then
		ply:SetPlayerSize( 1 )
		ply:SetJumpPower( 250 )
		ply:SetWalkSpeed( 275 )
		ply:SetRunSpeed( 355 )
		ply:SetHealth( 105 )
		ply:SetNWInt("maxhealth", 105)

	elseif ply:GetNWString("race") == "Blood Elf" then
		ply:SetPlayerSize( 1 )
		ply:SetJumpPower( 240 )
		ply:SetWalkSpeed( 265 )
		ply:SetRunSpeed( 345 )
		ply:SetHealth( 100 )
		ply:SetNWInt("maxhealth", 100)

	elseif ply:GetNWString("race") == "Dark Elf" then
		ply:SetPlayerSize( 0.9 )
		ply:SetJumpPower( 230 )
		ply:SetWalkSpeed( 255 )
		ply:SetRunSpeed( 355 )
		ply:SetHealth( 100 )
		ply:SetNWInt("maxhealth", 100)

	elseif ply:GetNWString("race") == "Undead" then
		ply:SetPlayerSize( 1 )
		ply:SetJumpPower( 200 )
		ply:SetWalkSpeed( 300 )
		ply:SetRunSpeed( 310 )
		ply:SetHealth( 100 )
		ply:SetNWInt("maxhealth", 100)

	elseif ply:GetNWString("race") == "Dwarf" then
		-- ply:SetPlayerSize( 0.8 )
		ply:SetJumpPower( 210 )
		ply:SetWalkSpeed( 235 )
		ply:SetRunSpeed( 315 )
		ply:SetHealth( 120 )
		ply:SetNWInt("maxhealth", 120)

	elseif ply:GetNWString("race") == "Gnome" then
		ply:SetPlayerSize( 0.6 )
		ply:SetJumpPower( 190 )
		ply:SetWalkSpeed( 215 )
		ply:SetRunSpeed( 295 )
		ply:SetHealth( 100 )
		ply:SetNWInt("maxhealth", 100)

	elseif ply:GetNWString("race") == "Human" then
		ply:SetPlayerSize( 1 )
		ply:SetJumpPower( 230 )
		ply:SetWalkSpeed( 255 )
		ply:SetRunSpeed( 335 )
		ply:SetHealth( 100 )
		ply:SetNWInt("maxhealth", 100)

	elseif ply:GetNWString("race") == "Troll" then
		ply:SetPlayerSize( 1 )
		ply:SetJumpPower( 225 )
		ply:SetWalkSpeed( 250 )
		ply:SetRunSpeed( 330 )
		ply:SetHealth( 110 )
		ply:SetNWInt("maxhealth", 110)

	elseif ply:GetNWString("race") == "Goblin" then
		ply:SetPlayerSize( 0.95 )
		ply:SetJumpPower( 225 )
		ply:SetWalkSpeed( 250 )
		ply:SetRunSpeed( 330 )
		ply:SetHealth( 90 )
		ply:SetNWInt("maxhealth", 90)

	elseif ply:GetNWString("race") == "Ogre" then
		ply:SetPlayerSize( 1 )
		ply:SetJumpPower( 210 )
		ply:SetWalkSpeed( 235 )
		ply:SetRunSpeed( 315 )
		ply:SetHealth( 150 )
		ply:SetNWInt("maxhealth", 150)

	elseif ply:GetNWString("race") == "Animal" then
		ply:SetPlayerSize( 1 )
		local min = Vector(-16*0.6,-16*0.6,0)
		local max = Vector(16*0.6,16*0.6,72*0.6)
		ply:SetCollisionBounds(min,max)
		ply:SetJumpPower( 230 )
		ply:SetWalkSpeed( 325 )
		ply:SetRunSpeed( 405 )
		ply:SetHealth( 100 )
		ply:SetNWInt("maxhealth", 100)
	end

	ply:Extinguish()
	if (ply:GetNWInt("playerscale") and not ply:GetNWInt("playerscale") == 1) and not ply:GetNWString("race") == "Human" then else
		if (ply:GetNWInt("wearingsapphirering") == 1 and ply:GetNWInt("wearingemeraldring") == 1) then
			ply:SetJumpPower( 230 )
			ply:SetWalkSpeed( 280 )
			ply:SetRunSpeed( 360 )
		elseif (ply:GetNWInt("wearingsapphirering") == 1) then
			ply:SetJumpPower( 190 )
			ply:SetWalkSpeed( 270 )
			ply:SetRunSpeed( 310 )
		elseif (ply:GetNWInt("wearingemeraldring") == 1) then
			ply:SetJumpPower( 260 )
			ply:SetWalkSpeed( 230 )
			ply:SetRunSpeed( 350 )
		else
			ply:SetJumpPower( 230 )
			ply:SetWalkSpeed( 255 )
			ply:SetRunSpeed( 335 )
		end
	end

	if game.GetMap() == "gm_flatgrass2008" then
		if ply:GetNWString("race") == "Human" or 
		ply:GetNWString("race") == "Dwarf" or 
		ply:GetNWString("race") == "Gnome" or 
		ply:GetNWString("race") == "Blood Elf" or 
		ply:GetNWString("race") == "Night Elf" or 
		ply:GetNWString("race") == "Dark Elf" then
			ply.Spawned = false
			-- Spawn 1
				local foundents = ents.FindInSphere(Vector(4454.9350585938, 3616.6123046875, 547.43914794922), 40)
				for k,v in pairs(foundents) do
					if v:IsPlayer() then
						taken = true
					end
				end

				if not taken and not ply.Spawned == true then
					ply:SetPos(Vector( 4454.9350585938, 3616.6123046875, 547.43914794922 ))
					ply.Spawned = true
				end

			-- Spawn 2
				local foundents = ents.FindInSphere(Vector(4358.5649414063, 3702.8208007813, 547.43914794922), 40)
				for k,v in pairs(foundents) do
					if v:IsPlayer() then
						taken = true
					end
				end

				if not taken and not ply.Spawned == true then
					ply:SetPos(Vector( 4358.5649414063, 3702.8208007813, 547.43914794922 ))
					ply.Spawned = true
				end

			-- Spawn 3
				local foundents = ents.FindInSphere(Vector(4296.4555664063, 3763.7138671875, 547.44348144531), 40)
				for k,v in pairs(foundents) do
					if v:IsPlayer() then
						taken = true
					end
				end

				if not taken and not ply.Spawned == true then
					ply:SetPos(Vector( 4296.4555664063, 3763.7138671875, 547.44348144531 ))
					ply.Spawned = true
				end

			-- Spawn 4
				local foundents = ents.FindInSphere(Vector(4488.166015625, 3551.5515136719, 547.44348144531), 40)
				for k,v in pairs(foundents) do
					if v:IsPlayer() then
						taken = true
					end
				end

				if not taken and not ply.Spawned == true then
					ply:SetPos(Vector( 4488.166015625, 3551.5515136719, 547.44348144531 ))
					ply.Spawned = true
				end

			-- Spawn 5
				local foundents = ents.FindInSphere(Vector(4582.0283203125, 3459.4143066406, 547.44348144531), 40)
				for k,v in pairs(foundents) do
					if v:IsPlayer() then
						taken = true
					end
				end

				if not taken and not ply.Spawned == true then
					ply:SetPos(Vector( 4582.0283203125, 3459.4143066406, 547.44348144531 ))
					ply.Spawned = true
				end

			-- Spawn 6
				local foundents = ents.FindInSphere(Vector(4649.5249023438, 3388.9123535156, 547.44348144531), 40)
				for k,v in pairs(foundents) do
					if v:IsPlayer() then
						taken = true
					end
				end

				if not taken and not ply.Spawned == true then
					ply:SetPos(Vector( 4649.5249023438, 3388.9123535156, 547.44348144531 ))
					ply.Spawned = true
				end
		else
			if ply:GetNWString("race") == "Animal" then else
				ply:SetPos(Vector( -5223.4418945313, -782.10223388672, 547.58386230469 ))
			end
		end
	elseif game.GetMap() == "rp_ye_old_islands_alpha" then
		if ply:GetNWString("race") == "Human" or 
		ply:GetNWString("race") == "Dwarf" or 
		ply:GetNWString("race") == "Gnome" or 
		ply:GetNWString("race") == "Blood Elf" or 
		ply:GetNWString("race") == "Night Elf" or 
		ply:GetNWString("race") == "Dark Elf" then
			ply:SetPos(Vector( -7496.6904296875, -5660.453125, 5.40624165534973 ))
		else
			ply:SetPos(Vector( 7180.3544921875, 8732.96875, 404.75836181641 ))
		end
	end
end

-- Chat

function GM:PlayerSay(ply, text)
	self.BaseClass:PlayerSay(ply, text)

	for k, v in pairs(ChatTriggerCommands) do
		if v.cmd == string.Explode(" ", string.lower(text))[1] then
			return v.callback(ply, "" .. string.sub(text, string.len(v.cmd) + 2, string.len(text)))
		end
	end

	if CfgVars["chatradius"] == 1 then
		ChatRadius(ply:Nick() .. "( " .. ply:GetNWInt("name") .. "): " .. text, ply:GetPos(), 250)
		return ""
	end

	if ply:IsAdmin() and ply:GetName() == ply:GetNWString("name") then
		return "(Admin) " .. text
	elseif ply:IsAdmin() and ply:GetName() ~= ply:GetNWString("name") then
		return "(" .. ply:GetNWString("name") .. ") (Admin) " ..  text
	elseif not ply:IsAdmin() and ply:GetName() ~= ply:GetNWString("name") then
		return "(" .. ply:GetNWString("name") .. ") " ..  text
	else
		return text
	end
end

-- Gold

function DropGold(ply, args)
	if args == "" then return "" end

	local amount = math.floor(tonumber(args))

	if amount <= 0 then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't drop " .. amount .. " Gold.")
		return ""
	elseif amount > 20 then
		local amount = 20
	end

	if ply:GetNWInt("gold") == amount then
		local gold = ents.Create("prop_physics")
		gold:SetModel("models/nayrbarr/coin/coin.mdl")
		gold:SetNWString("Owner", "Shared")
		local tr = ply:EyeTrace( 80 )
		gold:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		gold.nodupe = true
		gold:Spawn()
		gold:GetTable().MoneyBag = true
		gold:GetTable().Amount = amount
		TakeGold( ply, "gold", amount )
		return ""

	elseif ply:GetNWInt("gold") > amount then
		local gold = ents.Create("prop_physics")
		gold:SetModel("models/nayrbarr/coin/coin.mdl")
		gold:SetNWString("Owner", "Shared")
		local tr = ply:EyeTrace( 80 )
		gold:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		gold.nodupe = true
		gold:Spawn()
		gold:GetTable().MoneyBag = true
		gold:GetTable().Amount = amount
		TakeGold( ply, "gold", amount )
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye don't have enough gold to drop that much!" )
		return ""
	end
end
AddChatCommand("/dropgold", DropGold)
AddChatCommand("/dropmoney", DropGold)

function PlayerGiveGold(ply, args)
	if args == "" then return "" end

	local amount = math.floor(tonumber(args))
	if amount <= 0 then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't give " .. amount .. " Gold.")
	end

	local tr = ply:EyeTrace( 80 )
	if tr.Entity:IsPlayer() then
		if ply:GetNWInt("gold") == amount then
			TakeGold( ply, "gold", amount )
			ply:PrintMessage( HUD_PRINTTALK, "Ye gave " .. amount .. " Gold to " .. tr.Entity:GetNWInt("name") .. " !" )
			GiveGold( tr.Entity, "gold", amount )
			tr.Entity:PrintMessage( HUD_PRINTTALK, "Ye received " .. amount .. " Gold from " .. ply:GetNWInt("name") .. " !" )
		elseif ply:GetNWInt("gold") > amount then
			TakeGold( ply, "gold", amount )
			ply:PrintMessage( HUD_PRINTTALK, "Ye gave " .. amount .. " Gold to " .. tr.Entity:GetNWInt("name") .. " !" )
			GiveGold( tr.Entity, "gold", amount )
			tr.Entity:PrintMessage( HUD_PRINTTALK, "Ye received " .. amount .. " Gold from " .. ply:GetNWInt("name") .. " !" )
		else
			ply:PrintMessage( HUD_PRINTTALK, "Ye don't have enough gold to give that much away!" )
		end
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be close to and looking at someone to use this command!" )
	end
	return ""
end
AddChatCommand("/give", PlayerGiveGold)

function GM:KeyPress(ply, code)
	self.BaseClass:KeyPress(ply, code)

	if ply.HasSeenRules == true then else
		umsg.Start("ShowRules", ply)
		umsg.End()
		ply.HasSeenRules = true
	end

	if code == IN_USE then
		local trace = { }
		trace.start = ply:EyePos()
		trace.endpos = trace.start + ply:GetAimVector() * 95
		trace.filter = ply
		local tr = util.TraceLine(trace)

		if IsValid( tr.Entity ) and not ply:KeyDown(IN_ATTACK) then
			if tr.Entity:GetTable().MoneyBag then
				ply:SetNWInt("gold", ply:GetNWInt("gold") + tr.Entity:GetTable().Amount)
				DataStoreGold(ply, ply:GetNWInt("gold"))
				ShowTipPlayer(ply, 0, 4, "Picked up "..tr.Entity:GetTable().Amount.." Gold." )
				tr.Entity:Remove()
			end
			if ply:GetNWString("race") == "Human" or 
			ply:GetNWString("race") == "Dwarf" or 
			ply:GetNWString("race") == "Gnome" or 
			ply:GetNWString("race") == "Blood Elf" or 
			ply:GetNWString("race") == "Night Elf" or 
			ply:GetNWString("race") == "Dark Elf" then
				if tr.Entity:GetClass() == "npc_barney" then
					umsg.Start("InnKeeperChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting3")
				end
				if tr.Entity:GetClass() == "npc_breen" and tr.Entity:GetModel() == "models/humans/group03/male_07.mdl" then
					umsg.Start("AaronChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting1")
				elseif tr.Entity:GetClass() == "npc_breen" then
					umsg.Start("HarbourMasterChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting1")
				end
				if tr.Entity:GetClass() == "npc_monk" then
					umsg.Start("PriestChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting5")
				end
				if tr.Entity:GetClass() == "npc_mossman" and tr.Entity:GetModel() == "models/humans/group03/male_07.mdl" then
					umsg.Start("FarmerChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting1")
				elseif tr.Entity:GetClass() == "npc_mossman" then
					if tr.Entity:GetModel() == "models/undead/undead.mdl" or tr.Entity:GetModel() == "models/goblin/goblin.mdl" then else
						umsg.Start("CookChatMenu", ply)
						umsg.End()
					end
				end
				if tr.Entity:GetClass() == "npc_gman" and tr.Entity:GetModel() == "models/humans/group03/male_07.mdl" then
					umsg.Start("CraftsmanChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting2")
				end
				if tr.Entity:GetClass() == "npc_gman" and tr.Entity:GetModel() == "models/humans/group03/male_06.mdl" then
					umsg.Start("LabourerChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting2")
				end
				if tr.Entity:GetClass() == "npc_gman" and tr.Entity:GetModel() == "models/humans/group03/male_09.mdl" then
					umsg.Start("FishermanChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting2")
				end
				if tr.Entity:GetClass() == "npc_gman" and tr.Entity:GetModel() == "models/odessa.mdl" then
					umsg.Start("KnightChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting2")
				end
				if tr.Entity:GetClass() == "npc_kleiner" then
					umsg.Start("SmithChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Good/Greeting2")
				end
			else
				if tr.Entity:GetClass() == "npc_gman" and tr.Entity:GetModel() == "models/undead/undead.mdl" then
					umsg.Start("ELabourerChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting5")
				end
				if tr.Entity:GetClass() == "npc_breen" and tr.Entity:GetModel() == "models/hellknight/hellknight.mdl" then
					umsg.Start("HarbourMasterChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting3")
				end
				if tr.Entity:GetClass() == "npc_monk" and tr.Entity:GetModel() == "models/goblin/goblin.mdl" then
					umsg.Start("PriestChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting2")
				end
				if tr.Entity:GetClass() == "npc_mossman" and tr.Entity:GetModel() == "models/undead/undead.mdl" then
					umsg.Start("FarmerChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting4")
				elseif tr.Entity:GetClass() == "npc_mossman" and tr.Entity:GetModel() == "models/goblin/goblin.mdl" then
					umsg.Start("CookChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting2")
				end
				if tr.Entity:GetClass() == "npc_gman" and tr.Entity:GetModel() == "models/krall/slow.mdl" then
					umsg.Start("CraftsmanChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting1")
				end
				if tr.Entity:GetClass() == "npc_gman" and tr.Entity:GetModel() == "models/goblin/goblin.mdl" then
					umsg.Start("EInnKeeperChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting3")
				end
				if tr.Entity:GetClass() == "npc_eli" and tr.Entity:GetModel() == "models/krall/slow.mdl" then
					umsg.Start("KnightChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting1")
				end
				if tr.Entity:GetClass() == "npc_kleiner" and tr.Entity:GetModel() == "models/krall/slow.mdl" then
					umsg.Start("SmithChatMenu", ply)
					umsg.End()
					ply:ConCommand("play NPCs/Evil/Greeting1")
				end
			end
		end
	end
end

function GM:CanTool(ply, trace, mode)
	if not self.BaseClass:CanTool(ply, trace, mode) then return false end

	if trace.Entity then
		if trace.Entity.onlyremover then
			if mode == "remover" then
				return (ply:IsAdmin() or ply:IsSuperAdmin())
			else
				return false
			end
		end

		if trace.Entity:IsPlayer() then
			if ply:IsAdmin() then
			else
				return false
			end
		end

		if trace.Entity.nodupe and (mode == "weld" or
					mode == "weld_ez" or
					mode == "nail" or
					mode == "rope" or
					mode == "nocollide" or
					mode == "hydralics" or
					mode == "winch" or
					mode == "constraint" or
					mode == "spawner" or
					mode == "slider" or
					mode == "duplicator" or
					mode == "adv_duplicator") then
			return false
		end
	end

	if mode == "adv_duplicator" then
		if ply:GetNWInt("allowedtodupe") == 1 then
			return true
		else
			return false
		end
	end

	return true
end

function GM:GravGunPunt(ply, ent)
	if ent:IsVehicle() then return false end

	local entphys = ent:GetPhysicsObject()

	if ply:KeyDown(IN_ATTACK) then
		entphys:EnableMotion(false)
		local curpos = ent:GetPos()
		timer.Simple(.01, entphys.EnableMotion, entphys, true)
		timer.Simple(.01, entphys.Wake, entphys)
		timer.Simple(.01, ent.SetPos, ent, curpos)
	else
		return true
	end
end

function GM:GravGunOnDropped(ply, ent)
	local entphys = ent:GetPhysicsObject()
	if ply:KeyDown(IN_ATTACK) then
		entphys:EnableMotion(false)
		local curpos = ent:GetPos()
		timer.Simple(.01, entphys.EnableMotion, entphys, true)
		timer.Simple(.01, entphys.Wake, entphys)
		timer.Simple(.01, ent.SetPos, ent, curpos)
	else
		return true
	end
end

function GM:Think()
	for k, v in pairs(player.GetAll()) do
		if v:Team() == 16 then 
			v:SetNWString("race", "Animal")
		else
			if v:GetNWString("race") == "Animal" then
				if v:GetNWInt("dwarfleader") == 1 then
					v:SetNWString("race", "Dwarf")
				elseif v:GetNWInt("gnomeleader") == 1 then
					v:SetNWString("race", "Gnome")
				elseif v:GetNWInt("nightelfleader") == 1 then
					v:SetNWString("race", "Night Elf")
				elseif v:GetNWInt("bloodelfleader") == 1 then
					v:SetNWString("race", "Blood Elf")
				elseif v:GetNWInt("darkelfleader") == 1 then
					v:SetNWString("race", "Dark Elf")
				elseif v:GetNWInt("undeadleader") == 1 then
					v:SetNWString("race", "Undead")
				elseif v:GetNWInt("ogreleader") == 1 then
					v:SetNWString("race", "Ogre")
				elseif v:GetNWInt("goblinleader") == 1 then
					v:SetNWString("race", "Goblin")
				elseif v:GetNWInt("trollleader") == 1 then
					v:SetNWString("race", "Troll")
				else
					v:SetNWString("race", "Human")
				end
			end
		end
		if v:GetNWInt("beinghealed") == 1 then
			v:PrintMessage(4, tostring( "\n\n"..v:Health().."\n".."Being healed by "..v:GetNWString("healer").."."))
			v:SetNWInt("beinghealed", 0)
		end
		if CfgVars["hunger"] == 1 then
			if v:GetNWInt("hunger") > 0 then else
				if v:Health() > 10 then
					v:SetHealth(v:Health() - 10)
				else
					if v:Alive() == true then
						v:Kill()
					end
				end
			end
			SetGlobalInt("hunger", 1)
		else
			SetGlobalInt("hunger", 0)
		end
	end

	for k,v in pairs(ents.FindByClass("maw*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("animal*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("resource*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("bar*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("craft*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("plant*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("anvil*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("furnace*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("workbench*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("stove*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("kit*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("ent_*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("potion*")) do
		v.nodupe = true
	end
	for k,v in pairs(ents.FindByClass("poison*")) do
		v.nodupe = true
	end
end

function SaveGold( ply )
	DataStoreGold(ply, ply:GetNWInt("gold"))
end

function LoadGold( ply )
	DataRetrieveGold(ply)
end
hook.Add( "PlayerInitialSpawn", "LoadGold", LoadGold )

function SaveGoldOnDisconnect( ply )
	SaveGold( ply )
end
hook.Add( "PlayerDisconnected", "SaveGoldOnDisconnect", SaveGoldOnDisconnect )

function GiveGold( ply, item, amount )
	if ( amount != 0 ) then
		ply:SetNWInt("gold", ply:GetNWInt("gold") + amount)
		DataStoreGold(ply, ply:GetNWInt("gold"))
	end
end

function TakeGold( ply, item, amount )
	if ( amount != 0 ) then
		ply:SetNWInt("gold", ply:GetNWInt("gold") - amount)
		DataStoreGold(ply, ply:GetNWInt("gold"))
	end
end

-- Levels and Experience

function SetAllLevels(ply, args)
	ply:SetLevel("smithinglevel", args )
	ply:SetLevel("craftinglevel", args )
	ply:SetLevel("mininglevel", args )
	ply:SetLevel("lumberinglevel", args )
	ply:SetLevel("cookinglevel", args )
	ply:SetLevel("alchemylevel", args )
	ply:SetLevel("fishinglevel", args )
	ply:SetLevel("magiclevel", args )
end

function SetAllExperiences(ply, args)
	ply:SetLevel("smithingexp", args )
	ply:SetLevel("craftingexp", args )
	ply:SetLevel("miningexp", args )
	ply:SetLevel("lumberingexp", args )
	ply:SetLevel("cookingexp", args )
	ply:SetLevel("alchemyexp", args )
	ply:SetLevel("fishingexp", args )
	ply:SetLevel("magicexp", args )
end

function SaveSmithingLevel( ply )
	--local Data = util.TableToKeyValues( SmithingLevelData[ ply:UniqueID() ] )
	--file.Write( "MedievalRoleplay/Data/SmithingLevels/" .. ply:UniqueID() .. ".txt", Data )
	DataStoreSmithingLevel(ply, ply:GetNWInt("smithinglevel"))
	DataStoreSmithingExp(ply, ply:GetNWInt("smithingexp"))
end

function LoadSmithingLevel( ply )
	--if ( file.Exists( "MedievalRoleplay/Data/SmithingLevels/" .. ply:UniqueID() .. ".txt", "DATA" ) ) then
	--	local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/SmithingLevels/" .. ply:UniqueID() .. ".txt" ) )
	--	SmithingLevelData[ ply:UniqueID() ] = Data
	--	ply:SendSavedSmithingLevel()
	--else
	--	SmithingLevelData[ ply:UniqueID() ] = { }
	--	SaveSmithingLevel( ply )
	--end
	DataRetrieveSmithingLevel(ply)
	DataRetrieveSmithingExp(ply)
end
hook.Add( "PlayerInitialSpawn", "LoadSmithingLevel", LoadSmithingLevel )

function SaveSmithingLevelOnDisconnect( ply )
	SaveSmithingLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveSmithingLevelOnDisconnect", SaveSmithingLevelOnDisconnect )

function GiveSmithingLevel( ply, item, amount )
	if ( amount != 0 ) then
		ply:SetNWInt(item, ply:GetNWInt(item) + amount)
		DataStoreSmithingLevel(ply, ply:GetNWInt("smithinglevel"))
		DataStoreSmithingExp(ply, ply:GetNWInt("smithingexp"))
	end
end

function SetSmithingLevel( ply, item, amount )
	if ( amount > 0 ) then
		ply:SetNWInt(item, amount)
		DataStoreSmithingLevel(ply, ply:GetNWInt("smithinglevel"))
		DataStoreSmithingExp(ply, ply:GetNWInt("smithingexp"))
	end
end

CraftingLevelData = { }

function SaveCraftingLevel( ply )
	local Data = util.TableToKeyValues( CraftingLevelData[ ply:UniqueID() ] )
	file.Write( "MedievalRoleplay/Data/CraftingLevels/" .. ply:UniqueID() .. ".txt", Data )
end

function LoadCraftingLevel( ply )
	if ( file.Exists( "MedievalRoleplay/Data/CraftingLevels/" .. ply:UniqueID() .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/CraftingLevels/" .. ply:UniqueID() .. ".txt" ) )
		CraftingLevelData[ ply:UniqueID() ] = Data
		ply:SendSavedCraftingLevel()
	else
		CraftingLevelData[ ply:UniqueID() ] = { }
		SaveCraftingLevel( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadCraftingLevel", LoadCraftingLevel )

function SaveCraftingLevelOnDisconnect( ply )
	SaveCraftingLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveCraftingLevelOnDisconnect", SaveCraftingLevelOnDisconnect )

function GiveCraftingLevel( ply, item, amount )
	if ( amount != 0 ) then
		if ( CraftingLevelData[ ply:UniqueID() ][ item ] ) then
			CraftingLevelData[ ply:UniqueID() ][ item ] = CraftingLevelData[ ply:UniqueID() ][ item ] + amount
			ply:SetNWInt( item, ply:GetNWInt( item ) + amount)
		else
			CraftingLevelData[ ply:UniqueID() ][ item ] = 0
			CraftingLevelData[ ply:UniqueID() ][ item ] = CraftingLevelData[ ply:UniqueID() ][ item ] + amount
			ply:SetNWInt( item, ply:GetNWInt( item ) + amount)
		end
	end
end

function SetCraftingLevel( ply, item, amount )
	CraftingLevelData[ ply:UniqueID() ][ item ] = amount
	ply:SetNWInt( item, amount)
end

LumberingLevelData = { }

function SaveLumberingLevel( ply )
	local Data = util.TableToKeyValues( LumberingLevelData[ ply:UniqueID() ] )
	file.Write( "MedievalRoleplay/Data/LumberingLevels/" .. ply:UniqueID() .. ".txt", Data )
end

function LoadLumberingLevel( ply )
	if ( file.Exists( "MedievalRoleplay/Data/LumberingLevels/" .. ply:UniqueID() .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/LumberingLevels/" .. ply:UniqueID() .. ".txt" ) )
		LumberingLevelData[ ply:UniqueID() ] = Data
		ply:SendSavedLumberingLevel()
	else
		LumberingLevelData[ ply:UniqueID() ] = { }
		SaveLumberingLevel( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadLumberingLevel", LoadLumberingLevel )

function SaveLumberingLevelOnDisconnect( ply )
	SaveLumberingLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveLumberingLevelOnDisconnect", SaveLumberingLevelOnDisconnect )

function GiveLumberingLevel( ply, item, amount )
	if ( amount != 0 ) then
		if ( LumberingLevelData[ ply:UniqueID() ][ item ] ) then
			LumberingLevelData[ ply:UniqueID() ][ item ] = LumberingLevelData[ ply:UniqueID() ][ item ] + amount
			ply:SetNWInt( item, ply:GetNWInt( item ) + amount)
		else
			LumberingLevelData[ ply:UniqueID() ][ item ] = 0
			LumberingLevelData[ ply:UniqueID() ][ item ] = LumberingLevelData[ ply:UniqueID() ][ item ] + amount
			ply:SetNWInt( item, ply:GetNWInt( item ) + amount)
		end
	end
end

function SetLumberingLevel( ply, item, amount )
	LumberingLevelData[ ply:UniqueID() ][ item ] = amount
	ply:SetNWInt( item, amount)
end

MiningLevelData = { }

function SaveMiningLevel( ply )
	local Data = util.TableToKeyValues( MiningLevelData[ ply:UniqueID() ] )
	file.Write( "MedievalRoleplay/Data/MiningLevels/" .. ply:UniqueID() .. ".txt", Data )
end

function LoadMiningLevel( ply )
	if ( file.Exists( "MedievalRoleplay/Data/MiningLevels/" .. ply:UniqueID() .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/MiningLevels/" .. ply:UniqueID() .. ".txt" ) )
		MiningLevelData[ ply:UniqueID() ] = Data
		ply:SendSavedMiningLevel()
	else
		MiningLevelData[ ply:UniqueID() ] = { }
		SaveMiningLevel( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadMiningLevel", LoadMiningLevel )

function SaveMiningLevelOnDisconnect( ply )
	SaveMiningLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveMiningLevelOnDisconnect", SaveMiningLevelOnDisconnect )

function GiveMiningLevel( ply, item, amount )
	if ( amount != 0 ) then
		if ( MiningLevelData[ ply:UniqueID() ][ item ] ) then
			MiningLevelData[ ply:UniqueID() ][ item ] = MiningLevelData[ ply:UniqueID() ][ item ] + amount
			ply:SetNWInt( item, ply:GetNWInt( item ) + amount)
		else
			MiningLevelData[ ply:UniqueID() ][ item ] = 0
			MiningLevelData[ ply:UniqueID() ][ item ] = MiningLevelData[ ply:UniqueID() ][ item ] + amount
			ply:SetNWInt( item, ply:GetNWInt( item ) + amount)
		end
	end
end

function SetMiningLevel( ply, item, amount )
	MiningLevelData[ ply:UniqueID() ][ item ] = amount
	ply:SetNWInt( item, amount)
end

CookingLevelData = { }

function SaveCookingLevel( ply )
	local Data = util.TableToKeyValues( CookingLevelData[ ply:UniqueID() ] )
	file.Write( "MedievalRoleplay/Data/CookingLevels/" .. ply:UniqueID() .. ".txt", Data )
end

function LoadCookingLevel( ply )
	if ( file.Exists( "MedievalRoleplay/Data/CookingLevels/" .. ply:UniqueID() .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/CookingLevels/" .. ply:UniqueID() .. ".txt" ) )
		CookingLevelData[ ply:UniqueID() ] = Data
		ply:SendSavedCookingLevel()
	else
		CookingLevelData[ ply:UniqueID() ] = { }
		SaveCookingLevel( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadCookingLevel", LoadCookingLevel )

function SaveCookingLevelOnDisconnect( ply )
	SaveCookingLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveCookingLevelOnDisconnect", SaveCookingLevelOnDisconnect )

AlchemyLevelData = { }

function SaveAlchemyLevel( ply )
	local Data = util.TableToKeyValues( AlchemyLevelData[ ply:UniqueID() ] )
	file.Write( "MedievalRoleplay/Data/AlchemyLevels/" .. tostring( ply:UniqueID() ) .. ".txt", Data )
end

function LoadAlchemyLevel( ply )
	if ( file.Exists( "MedievalRoleplay/Data/AlchemyLevels/" .. tostring( ply:UniqueID() ) .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/AlchemyLevels/" .. ply:UniqueID() .. ".txt" ) )
		AlchemyLevelData[ ply:UniqueID() ] = Data
		ply:SendSavedAlchemyLevel()
	else
		AlchemyLevelData[ ply:UniqueID() ] = { }
		SaveAlchemyLevel( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadAlchemyLevel", LoadAlchemyLevel )

function SaveAlchemyLevelOnDisconnect( ply )
	SaveAlchemyLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveAlchemyLevelOnDisconnect", SaveAlchemyLevelOnDisconnect )

FishingLevelData = { }

function SaveFishingLevel( ply )
	local Data = util.TableToKeyValues( FishingLevelData[ ply:UniqueID() ] )
	file.Write( "MedievalRoleplay/Data/FishingLevels/" .. ply:UniqueID() .. ".txt", Data )
end

function LoadFishingLevel( ply )
	if ( file.Exists( "MedievalRoleplay/Data/FishingLevels/" .. ply:UniqueID() .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/FishingLevels/" .. ply:UniqueID() .. ".txt" ) )
		FishingLevelData[ ply:UniqueID() ] = Data
		ply:SendSavedFishingLevel()
	else
		FishingLevelData[ ply:UniqueID() ] = { }
		SaveFishingLevel( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadFishingLevel", LoadFishingLevel )

function SaveFishingLevelOnDisconnect( ply )
	SaveFishingLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveFishingLevelOnDisconnect", SaveFishingLevelOnDisconnect )

FightingLevelData = { }

function SaveFightingLevel( ply )
	local Data = util.TableToKeyValues( FightingLevelData[ ply:UniqueID() ] )
	file.Write( "MedievalRoleplay/Data/FightingLevels/" .. ply:UniqueID() .. ".txt", Data )
end

function LoadFightingLevel( ply )
	if ( file.Exists( "MedievalRoleplay/Data/FightingLevels/" .. ply:UniqueID() .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/FightingLevels/" .. ply:UniqueID() .. ".txt" ) )
		FightingLevelData[ ply:UniqueID() ] = Data
		ply:SendSavedFightingLevel()
	else
		FightingLevelData[ ply:UniqueID() ] = { }
		SaveFightingLevel( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadFightingLevel", LoadFightingLevel )

function SaveFightingLevelOnDisconnect( ply )
	SaveFightingLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveFightingLevelOnDisconnect", SaveFightingLevelOnDisconnect )

MagicLevelData = { }

function SaveMagicLevel( ply )
	local Data = util.TableToKeyValues( MagicLevelData[ ply:UniqueID() ] )
	file.Write( "MedievalRoleplay/Data/MagicLevels/" .. ply:UniqueID() .. ".txt", Data )
end

function LoadMagicLevel( ply )
	if ( file.Exists( "MedievalRoleplay/Data/MagicLevels/" .. ply:UniqueID() .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "MedievalRoleplay/Data/MagicLevels/" .. ply:UniqueID() .. ".txt" ) )
		MagicLevelData[ ply:UniqueID() ] = Data
		ply:SendSavedMagicLevel()
	else
		MagicLevelData[ ply:UniqueID() ] = { }
		SaveMagicLevel( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadMagicLevel", LoadMagicLevel )

function SaveMagicLevelOnDisconnect( ply )
	SaveMagicLevel( ply )
end
hook.Add( "PlayerDisconnected", "SaveMagicLevelOnDisconnect", SaveMagicLevelOnDisconnect )

GM.Name = "The Middle Ages"
GM.Author = "Matthew"

-- Doors

local meta = FindMetaTable("Entity")

function meta:IsOwnable()
	local class = self:GetClass()

	if (class == "func_door" or class == "func_door_rotating" or class == "prop_door_rotating") or
		class == "prop_vehicle_jeep" or class == "prop_vehicle_airboat" then
			return true
		end
	return false
end

function meta:IsDoor()
	local class = self:GetClass()

	if class == "func_door" or
		class == "func_door_rotating" or
		class == "prop_door_rotating" then

		return true
		end
	return false
end

function meta:IsOwned()
	local num = 0
	for n = 1, self:GetNWInt("OwnerCount") do
		if self:GetNWInt("Ownersz" .. n) > -1 then
			num = num + 1
		end
	end

	if self:GetNWInt("Ownerz") ~= 0 or num > 0 then return true end

	return false
end

function meta:GetDoorOwner()
	return player.GetByID(self:GetNWInt("Ownerz")) or NULL
end

function meta:IsMasterOwner(ply)
	if ply:EntIndex() == self:GetNWInt("Ownerz") then
		return true
	end

	return false
end

function meta:OwnedBy(ply)
	if self:GetNWInt("Ownerz") == ply:EntIndex() then return true end

	local num = self:GetNWInt("OwnerCount")

	for n = 1, num do
		if ply:EntIndex() == self:GetNWInt("Ownersz" .. n) then
			return true
		end
	end

	return false
end

function meta:UnOwn(ply)
	if CLIENT then return end

	if not ply then
		ply = self:GetDoorOwner()

		if not ply then return end
	end

	if self:IsMasterOwner(ply) then
		self:SetNWInt("Ownerz", 0)
	else
		self:RemoveOwner(ply)
	end

	local num = 0

	for n = 1, self:GetNWInt("OwnerCount") do
		if self:GetNWInt("Ownersz" .. n) > -1 then
			num = num + 1
		end
	end

	if self:GetNWInt("Ownerz") == 0 and num == 0 then
		num = self:GetNWInt("AllowedNum")
		for n = 1, num do
			self:SetNWInt("Allowed" .. n, -1)
		end
	end
end

function meta:AllowedToOwn(ply)
	local num = self:GetNWInt("AllowedNum")

	for n = 1, num do
		if self:GetNWInt("Allowed" .. n) == ply:EntIndex() then
			return true
		end
	end

	return false
end

function meta:AddAllowed(ply)
	local num = self:GetNWInt("AllowedNum")
	num = num + 1

	self:SetNWInt("AllowedNum", num)
	self:SetNWInt("Allowed" .. num, ply:EntIndex())
end

function meta:RemoveAllowed(ply)
	local num = self:GetNWInt("AllowedNum")

	for n = 1, num do
		if self:GetNWInt("Allowed" .. n) == ply:EntIndex() then
			self:SetNWInt("Allowed" .. n, -1)
			break
		end
	end
end

function meta:AddOwner(ply)
	local num = self:GetNWInt("OwnerCount")
	num = num + 1

	self:SetNWInt("OwnerCount", num)
	self:SetNWInt("Ownersz" .. num, ply:EntIndex())
	self:RemoveAllowed(ply)
end

function meta:RemoveOwner(ply)

	local num = self:GetNWInt("OwnerCount")

	for n = 1, num do
		if ply:EntIndex() == self:GetNWInt("Ownersz" .. n) then
			self:SetNWInt("Ownersz" .. n, -1)
			break
		end
	end
end

function meta:Own(ply)
	if CLIENT then return end

	if self:AllowedToOwn(ply) then
		self:AddOwner(ply)
		return
	end

	if not self:IsOwned() and not self:OwnedBy(ply) then
		self:SetNWInt("Ownerz", ply:EntIndex())
		self:SetNWInt("OwnerCount", 0)
		self:SetNWString("title", "")
		local trace = ply:GetEyeTrace()
	end
end

function GM:ShowSpare2(ply)
	local trace = ply:GetEyeTrace()

	if trace.Entity and trace.Entity:IsOwnable() and ply:GetPos():Distance(trace.Entity:GetPos()) < 115 then
		if trace.Entity:OwnedBy(ply) then
			ply:PrintMessage( HUD_PRINTTALK, "Ye sold this for 28 Gold.")
			trace.Entity:Fire("unlock", "", 0)
			trace.Entity:UnOwn(ply)
			ply:GetTable().Ownedz[trace.Entity:EntIndex()] = nil
			ply:GetTable().OwnedNumz = ply:GetTable().OwnedNumz - 1
			GiveGold(ply, "gold", 28)
		else
			if trace.Entity:IsOwned() and not trace.Entity:AllowedToOwn(ply) then
				ply:PrintMessage( HUD_PRINTTALK, "Already owned!")
				return
			end
			if not ply:CanAfford(30) then
				ply:PrintMessage( HUD_PRINTTALK, "Ye cannot afford this!")
				return
			end

			TakeGold(ply, "gold", 30)
			ply:PrintMessage( HUD_PRINTTALK, "Ye bought this for 30 Gold.")
			trace.Entity:Own(ply)

			if trace.Entity:GetNWInt("OwnerCount") == 0 then
				trace.Entity:SetNWInt("Ownersz1", ply)
			else
				nextowner = trace.Entity:GetNWInt("OwnerCount") + 1
				trace.Entity:SetNWInt("Ownersz"..nextowner, ply)
			end
			ply:GetTable().OwnedNumz = ply:GetTable().OwnedNumz + 1
			ply:GetTable().Ownedz[trace.Entity:EntIndex()] = trace.Entity
		end
	end
end

function SetDoorTitle(ply, args)
	local trace = ply:GetEyeTrace()
	if trace.Entity and trace.Entity:IsOwnable() and ply:GetPos():Distance(trace.Entity:GetPos()) < 110 then
		if trace.Entity:OwnedBy(ply) then
			trace.Entity:SetNWString("title", args)
		else
			ply:PrintMessage( HUD_PRINTTALK, "Ye don't own this.")
		end
	end
	return ""
end
AddChatCommand("/title", SetDoorTitle)

function RemoveDoorOwner(ply, args)
	local trace = ply:GetEyeTrace()
	if trace.Entity and trace.Entity:IsOwnable() and ply:GetPos():Distance(trace.Entity:GetPos()) < 110 then
		target = FindPlayer(args)
		if target then
			if trace.Entity:OwnedBy(ply) then
				if trace.Entity:AllowedToOwn(target) then
					trace.Entity:RemoveAllowed(target)
				end

				if trace.Entity:OwnedBy(target) then
					trace.Entity:RemoveOwner(target)
				end
			else
				ply:PrintMessage( HUD_PRINTTALK, "Ye don't own this!")
			end
		else
			ply:PrintMessage( HUD_PRINTTALK, "Could not find player: " .. args)
		end
	end
	return ""
end
AddChatCommand("/removeowner", RemoveDoorOwner)
AddChatCommand("/ro", RemoveDoorOwner)

function AddDoorOwner(ply, args)
	local trace = ply:GetEyeTrace()

	if trace.Entity and trace.Entity:IsOwnable() and ply:GetPos():Distance(trace.Entity:GetPos()) < 110 then
		target = FindPlayer(args)
		if target then
			if trace.Entity:OwnedBy(ply) then
				if not trace.Entity:OwnedBy(target) and not trace.Entity:AllowedToOwn(target) then
					trace.Entity:AddAllowed(target)
				else
					ply:PrintMessage( HUD_PRINTTALK, "Player already owns (or is allowed to own) this door!")
				end
			else
				ply:PrintMessage( HUD_PRINTTALK, "Ye don't own this!")
			end
		else
			ply:PrintMessage( HUD_PRINTTALK, "Could not find player: " .. args)
		end
	end
	return ""
end
AddChatCommand("/addowner", AddDoorOwner)
AddChatCommand("/ao", AddDoorOwner)

function FindPlayer(info)
	local pls = player.GetAll()
	for k, v in pairs(pls) do
		if tonumber(info) == v:UserID() then
			return v
		end
	end
	for k, v in pairs(pls) do
		if info == v:SteamID() then
			return v
		end
	end
	for k, v in pairs(pls) do
		if string.find(string.lower(v:GetNWString("name")), string.lower(tostring(info))) ~= nil then
			return v
		end
	end
	for k, v in pairs(pls) do
		if string.find(string.lower(v:Name()), string.lower(tostring(info))) ~= nil then
			return v
		end
	end
	return nil
end

-- Commands

function ccDoorOwn(ply, cmd, args)
	if ply:EntIndex() == 0 then
		return
	end

	if not ply:IsAdmin() then
		ply:PrintMessage( HUD_PRINTTALK, "You're not an admin")
		return
	end

	local trace = ply:GetEyeTrace()

	if not trace.Entity or not trace.Entity:IsOwnable() or ply:EyePos():Distance(trace.Entity:GetPos()) > 200 then
		return
	end

	trace.Entity:Fire("unlock", "", 0)
	trace.Entity:UnOwn()
	trace.Entity:Own(ply)
	ply:GetTable().OwnedNumz = 1
	ply:GetTable().Ownedz[trace.Entity:EntIndex()] = trace.Entity
	trace.Entity:SetNWInt("Ownersz1", ply)
end
concommand.Add("mrp_own", ccDoorOwn)

function ccDoorUnOwn(ply, cmd, args)
	if ply:EntIndex() == 0 then
		return
	end

	if not ply:IsAdmin() then
		ply:PrintMessage( HUD_PRINTTALK, "You're not an admin!")
		return
	end

	local trace = ply:GetEyeTrace()

	if not trace.Entity or not trace.Entity:IsOwnable() or ply:EyePos():Distance(trace.Entity:GetPos()) > 200 then
		return
	end

	trace.Entity:Fire("unlock", "", 0)
	trace.Entity:UnOwn()
end
concommand.Add("mrp_unown", ccDoorUnOwn)

function ccAddOwner(ply, cmd, args)
	if ply:EntIndex() == 0 then
		return
	end

	if not ply:IsAdmin() then
		ply:PrintMessage( HUD_PRINTTALK, "You're not an admin!")
		return
	end

	local trace = ply:GetEyeTrace()

	if not trace.Entity or not trace.Entity:IsOwnable() or ply:EyePos():Distance(trace.Entity:GetPos()) > 200 then
		return
	end

	target = FindPlayer(args[1])

	if target then
		if trace.Entity:IsOwned() then
			if not trace.Entity:OwnedBy(target) and not trace.Entity:AllowedToOwn(target) then
				trace.Entity:AddAllowed(target)
			else
				ply:PrintMessage( HUD_PRINTTALK, "Player already owns (or is already allowed to own) this door!")
			end
		else
			trace.Entity:Own(target)
		end
	else
		ply:PrintMessage( HUD_PRINTTALK, "Could not find player: " .. args)
	end
end
concommand.Add("mrp_addowner", ccAddOwner)

function ccRemoveOwner(ply, cmd, args)
	if ply:EntIndex() == 0 then
		return
	end

	if not ply:IsAdmin() then
		ply:PrintMessage( HUD_PRINTTALK, "You're not an admin!")
		return
	end

	local trace = ply:GetEyeTrace()

	if not trace.Entity or not trace.Entity:IsOwnable() or ply:EyePos():Distance(trace.Entity:GetPos()) > 200 then
		return
	end

	target = FindPlayer(args[1])

	if target then
		if trace.Entity:AllowedToOwn(target) then
			trace.Entity:RemoveAllowed(target)
		end

		if trace.Entity:OwnedBy(target) then
			trace.Entity:RemoveOwner(target)
		end
	else
		ply:PrintMessage( HUD_PRINTTALK, "Could not find player: " .. args)
	end
end
concommand.Add("mrp_removeowner", ccRemoveOwner)

function ccLock(ply, cmd, args)
	if ply:EntIndex() == 0 then
		return
	end

	if not ply:IsAdmin() then
		ply:PrintMessage( HUD_PRINTTALK, "You're not an admin!")
		return
	end

	local trace = ply:GetEyeTrace()

	if not trace.Entity or not trace.Entity:IsOwnable() or ply:EyePos():Distance(trace.Entity:GetPos()) > 200 then
		return
	end

	ply:PrintMessage( HUD_PRINTTALK, "Locked.")

	trace.Entity:Fire("lock", "", 0)
end
concommand.Add("mrp_lock", ccLock)

function ccUnLock(ply, cmd, args)
	if ply:EntIndex() == 0 then
		return
	end

	if not ply:IsAdmin() then
		ply:PrintMessage( HUD_PRINTTALK, "You're not an admin!")
		return
	end

	local trace = ply:GetEyeTrace()
	if not trace.Entity or not trace.Entity:IsOwnable() or ply:EyePos():Distance(trace.Entity:GetPos()) > 200 then
		return
	end

	ply:PrintMessage( HUD_PRINTTALK, "Unlocked.")
	trace.Entity:Fire("unlock", "", 0)
end
concommand.Add("mrp_unlock", ccUnLock)

function UnOwnAll(ply)
	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:IsOwnable() and v:IsMasterOwner(ply) then
			v:Fire("unlock", "", 0)
			v:UnOwn()
		end
	end
end
AddChatCommand("/unownall", UnownAll)
concommand.Add("mrp_unownall", UnownAll)

function UnOwnEvery()
	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:IsOwnable() then
			v:Fire("unlock", "", 0)
			v:UnOwn()
		end
	end
end
concommand.Add("mrp_unowneverydoor", UnOwnEvery)

function GM:PlayerShouldTakeDamage( ply, attacker )
	if ply:GetNWInt("armour") > 0 and not ply:GetNWInt("afk") == 1 then
		if ply:GetNWInt("wearingarmour") == 1 then
			ply:SetNWInt("armour", ply:GetNWInt("armour") - math.random( 10, 20 ) )
		else
			ply:SetNWInt("armour", ply:GetNWInt("armour") - math.random( 10, 20 ) )
			ply:SetNWInt("maxarmour", ply:GetNWInt("armour") )
		end
	else
		return true
	end
end

function GM:PlayerDisconnected(ply)
	ply:ConCommand("mrp_unownall")
	local foundents = ents.FindInSphere(Vector(0, 0, 0), 1000000000000)
	for k,v in pairs(foundents) do
		if v:GetNWInt("entowner") and v:GetNWInt("entowner") == ply then
			if v:GetClass() == "Ship" then
				ply:GiveItem( "Ship", 1 )
				ShowTipPlayer(ply, 0, 4, "Your Ship was saved before you left the server." )
			end
			v:Remove()
		end
	end
	self.BaseClass:PlayerDisconnected(ply)
end

---- Credits

--- Lua
--Matt - Main scripting
--The Maw - General help, entity help
--MoordacT - Help menu
--DJ Zybez - NPC chat system
--Todrak - Lua help

--- Dialog
--Matt
--Aaron

--- HUD textures
--Jim

--- Backstory (Maps, etc)
--Stevo

--- Ideas
--Matt
--Stevo
--Chris
--Aaron
--Atomic
--Etc (People of my server mostly)

--- House1, House2, House3, Inn, Fountain, Church, Smithy, Ruins1, Ruins2 Models
--Darth Zew -- Original vmf
--Matt -- Editting and conversion

--- Ship
--Sakarias, Matt - Script
--Mikko "OEM" Uusitalo (Fpsbanana) - Original vmf
--Matt - Editting and conversion

--- Castle walls, gates, etc Models
--Penvag

--- Centre, Door, Door Frame Models (I know that they are ugly, but I haven't got much experience in Hammer.)
-- Matt - Original vmfs and conversions

--- House4 Model
--Jim - Original vmf
--Matt - Editting and conversion

--- Sword Model (Giant Statue one)
--Scorpieo - Original vmf
--Matt - Editting and conversion

--- Wolf
--Miqle - Model (As far as I can tell.)
--TetaBonita, Matt - Scripting

--- Picket Sign Model
--sHiBaN

--- Axe
--VALVe - Model
--The Maw, Matt - Script

--- Sledge Hammer
--Zombie Panic: Source - Model
--Matt - Script

--- Gladius (Short Sword)
--RAPTOR65 - Model
--Matt - Script

--- Shovel
--SMOD - Model
--The Maw, Matt  - Scripting

--- Pickaxe
--VALVe - Model
--The Maw, Matt - Scripting

--- Sword (Long Sword)
--PLing and MagNet - Model
--Matt - Scripting

--- Silver Sword (Two-Handed Sword)
--Dark Messiah - Model
-- Workshipper, Matt - Scripting

--- War Axe
--Akina - Model
--Matt - Script

--- Krall (Ogre) (NPC and Player Models)
--SLoW

--- Cannon
--Jonny Higgins (Fpsbanana) - Original vmf
--Matt - Editting and conversion
--Elijah, Matt - Scripting

--- Cake
--TheBestFlash - Model
--Matt - Scripting

--- Fishing stuff
--VALVe - Models
--G3X, ReaperSWE, Matt - Scripting
--Original scripts were in GoFish.

--- Goblin, Hellknight (Troll) and Undead (NPC and Player Models)
--Elis

--- Peasant, Guard and Knight Player Models
--Age of Chivalry - Original Models
--Shotgunguy - Conversion to Player Models

--- Mushroom
-- - Model (Unknown for now D:)
--Matt - Scripting

--- Furnace, Coin, Bar and Anvil
--Nayrbarr - Models
--The Maw, Matt - Scripting

--- Logs
--NightReaper - Model
--The Maw, Matt - Scripting

--- Potions
--Dark Messiah - Models
--Matt - Scripting

--- Bread
--FritoMaster - Model
--Matt - Scripting

--- Bow
--Age of Chivalry - Model
-- The Maw, Matt - Scripting

--- Undead (zombie3/4) and Guard NPC
--Dan, Matt - Scripting

--- Scarebox
-- - Sounds (Unknown for now D:)
--Matt - Scripting

--- Inventory Addon
--Chewgum, Matt - Scripting

--- Torch
--Trigz - Model
--Matt - Scripting

--- Armour
--Hat Maker Creators, Matt - Scripting

--- Resizing Mod
-- The Maw, Matt - Scripting

--- Spirit Magic
--Worshipper, Matt - Scripting

--- Light, Fire and Ice Magic
--Feihc, Matt - Scripting

--- Medieval_Weapon_Base
--Stingwraith - Original Sword SWEP

--- Hands
--

--- Prop protection
--Falco