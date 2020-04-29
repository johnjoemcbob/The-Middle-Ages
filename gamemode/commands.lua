
ChatTriggerCommands = {}

function AddChatCommand(cmd, callback, prefixconst)
	table.insert(ChatTriggerCommands, { cmd = cmd, callback = callback, prefixconst = prefixconst })
end

ValueCmds = {}

function AddValueCommand(cmd, cfgvar, global)
	ValueCmds[cmd] = { var = cfgvar, global = global }
	concommand.Add(cmd, ccValueCommand)
end

function ccValueCommand(ply, cmd, args)
	local valuecmd = ValueCmds[cmd]

	if not valuecmd then return end

	if #args < 1 then
		if valuecmd.global then
			if ply:EntIndex() == 0 then
				Msg(cmd .. " = " .. GetGlobalInt(valuecmd.var))
			else
				ply:PrintMessage(2, cmd .. " = " .. GetGlobalInt(valuecmd.var))
			end
		else
			if ply:EntIndex() == 0 then
				Msg(cmd .. " = " .. CfgVars[valuecmd.var])
			else
				ply:PrintMessage(2, cmd .. " = " .. CfgVars[valuecmd.var])
			end
		end
		return
	end

	if not ply:IsAdmin() then
		ply:PrintMessage(2, "You're not an admin")
		return
	end

	local amount = math.floor(tonumber(args[1]))

	if valuecmd.global then
		SetGlobalInt(valuecmd.var, amount)
	else
		CfgVars[valuecmd.var] = amount
	end

	local nick = ""

	if ply:EntIndex() == 0 then
		nick = "Console"
	else
		nick = ply:Nick()
	end

	if CfgVars["showcfgvarschanges"] == 1 then
		for k,v in pairs(player.GetAll()) do
			v:PrintMessageAll( HUD_PRINTTALK, nick .. " set " .. cmd .. " to " .. amount)
		end
	end
end

ToggleCmds = {}

function AddToggleCommand(cmd, cfgvar, global)
	ToggleCmds[cmd] = {var = cfgvar, global = global}
	concommand.Add(cmd, ccToggleCommand)
end

function ccToggleCommand(ply, cmd, args)
	local togglecmd = ToggleCmds[cmd]

	if not togglecmd then return end

	if #args < 1 then
		if togglecmd.global then
			if ply:EntIndex() == 0 then
				Msg(cmd .. " = " .. GetGlobalInt(togglecmd.var))
			else
				ply:PrintMessage(2, cmd .. " = " .. GetGlobalInt(togglecmd.var))
			end
		else
			if ply:EntIndex() == 0 then
				Msg(cmd .. " = " .. CfgVars[togglecmd.var])
			else
				ply:PrintMessage(2, cmd .. " = " .. CfgVars[togglecmd.var])
			end
		end
		return
	end

	if not ply:IsAdmin() then
		ply:PrintMessage(2, "Only admins can do this.")
		return
	end

	local toggle = tonumber(args[1])

	if not toggle or (toggle ~= 1 and toggle ~= 0) then
		if ply:EntIndex() == 0 then
			Msg("Invalid number; must be 1 or 0.")
		else
			ply:PrintMessage(2, "Invalid number; must be 1 or 0.")
		end
		return
	end

	if togglecmd.global then
		SetGlobalInt(togglecmd.var, toggle)
	else
		CfgVars[togglecmd.var] = toggle
	end

	local nick = ""

	if ply:EntIndex() == 0 then
		nick = "Console"
	else
		nick = ply:Nick()
	end

	if CfgVars["showcfgvarschanges"] == 1 then
		for k,v in pairs(player.GetAll()) do
			v:PrintMessage( HUD_PRINTTALK, nick .. " set " .. cmd .. " to " .. toggle)
		end
	end
end

-- Commands

AddValueCommand("mrp_showconsolechanges", "showcfgvarschanges", false)

AddValueCommand("mrp_allowcustommodels", "allowcustommodels", false)

AddToggleCommand("mrp_letters", "letters", false)

AddToggleCommand("mrp_bannedprops", "bannedprops", false)

AddToggleCommand("mrp_propspawning", "propspawning", false)

AddToggleCommand("mrp_allowedprops", "allowedprops", false)

AddToggleCommand("mrp_chatradius", "chatradius", false)

AddToggleCommand("mrp_physgun", "physgun", false)

AddToggleCommand("mrp_toolgun", "toolgun", false)

AddToggleCommand("mrp_gravitygun", "gravitygun", false)

AddToggleCommand("mrp_torch", "torch", false)

AddToggleCommand("mrp_adminphysgun", "aphysgun", false)

AddToggleCommand("mrp_admintoolgun", "atoolgun", false)

AddToggleCommand("mrp_tinyland", "tinyland", false)

AddToggleCommand("mrp_hunger", "hunger", false)

-- CfgVars

CfgVars = {}

CfgVars["letters"] = 1 -- Should people be able to write letters?
CfgVars["showcfgvarschanges"] = 1 -- Should people see what cfgvars you are changing?
CfgVars["allowcustommodels"] = 0 -- Should people be able to decide they're own models?
CfgVars["bannedprops"] = 1 -- Should people be able to spawn props on the "Banned Props" list?
CfgVars["allowedprops"] = 1 -- Should people be able to spawn props on the "Allowed Props" list?
CfgVars["propspawning"] = 1 -- Should people be able to spawn props without being Admin, an Important Person or a Builder?
CfgVars["chatradius"] = 0 -- Should people only see chats if they are close enough to that person?
CfgVars["physgun"] = 1 -- Should people spawn with a physgun?
CfgVars["toolgun"] = 1 -- Should people spawn with a toolgun?
CfgVars["gravitygun"] = 1 -- Should people spawn with a gravity gun?
CfgVars["torch"] = 1 -- Should people spawn with a Torch?
CfgVars["aphysgun"] = 1 -- Should admins spawn with a physgun?
CfgVars["atoolgun"] = 1 -- Should admins spawn with a toolgun?
CfgVars["tinyland"] = 0 -- Should everyone be tiny?
CfgVars["hunger"] = 0 -- Should everyone have hunger?

-- HUD

function ToggleHUD(ply)
	if ply:GetNWInt("HUD") == 1 then -- If the player has the HUD toggled on
		ply:SetNWInt("HUD", 0) -- No HUD
		return ""
	else
		ply:SetNWInt("HUD", 1) -- Shows the HUD
		return ""
	end
end
concommand.Add("mrp_togglehud", ToggleHUD)
AddChatCommand("/hud", ToggleHUD)

function ExpBarHUD(ply, args)
	expbar = args * 1
	if expbar > 0 and expbar < 10 then
		ply:SetNWInt("HUDexpbar", expbar)
	end
	return ""
end
concommand.Add("mrp_hudexpbar", ExpBarHUD)
AddChatCommand("/hudexpbar", ExpBarHUD)

-- Rules

function ShowRules(ply)
	ply.HasSeenRules = false
	return ""
end
concommand.Add("mrp_showrules", ShowRules)
AddChatCommand("/rules", ShowRules)

-- Jobs

function ChangeJob(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	npc = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_eli" or
		v:GetClass() == "npc_barney" or
		v:GetClass() == "npc_monk" or
		v:GetClass() == "npc_mossman" or
		v:GetClass() == "npc_gman" or
		v:GetClass() == "npc_kleiner" or
		v:GetClass() == "npc_breen" then
			npc = true
		end
	end

	if npc == true then
		ply:StripWeapon("lockpick")
		ply:StripWeapon("magic_light")
		ply:StripWeapon("magic_ice")
		ply:StripWeapon("shovel")
		ply:StripWeapon("shovel_two")
		ply:StripWeapon("magic_healing")
		ply:StripWeapon("chisel")
		ply:StripWeapon("axe")
		ply:StripWeapon("pickaxe")
		ply:StripWeapon("claws")
		ply:StripWeapon("repair_hammer")
		ply:StripWeapon("pill_antlion")
		ply:StripWeapon("pill_pigeon")
		ply:StripWeapon("pill_vortigaunt")
		if ply.LastJob == 2 or ply.LastJob == 3 then
			if ply:GetNWInt("fightinglevel") > 34 then
				ply:StripWeapon( "sword_short_steel" )
			elseif ply:GetNWInt("fightinglevel") > 19 then
				ply:StripWeapon( "sword_short_iron" )
			else
				ply:StripWeapon( "sword_short_copper" )
			end
		end

		if CfgVars["physgun"] == 1 then
			ply:Give("weapon_physgun")
		elseif CfgVars["aphysgun"] == 1 and ply:IsAdmin() then
			ply:Give("weapon_physgun")
		end
		if CfgVars["toolgun"] == 1 then
			ply:Give( "gmod_tool" )
		elseif CfgVars["atoolgun"] == 1 and ply:IsAdmin() then
			ply:Give( "gmod_tool" )
		end
		if CfgVars["gravitygun"] == 1 then
			ply:Give("weapon_physcannon")
		end
		if CfgVars["torch"] == 1 then
			ply:Give("torch")
		end
		ply:Give( "hands" )
		ply:Give( "backpack" )
		ply:Give("keys")

		-- Weapons
		if ply:Team() == 2 then -- Guards
			if ply:GetNWInt("fightinglevel") > 34 then
				ply:Give( "sword_short_steel" )
			elseif ply:GetNWInt("fightinglevel") > 19 then
				ply:Give( "sword_short_iron" )
			else
				ply:Give( "sword_short_copper" )
			end
		elseif ply:Team() == 3 then -- Knights
			if ply:GetNWInt("fightinglevel") > 34 then
				ply:Give( "sword_short_steel" )
			elseif ply:GetNWInt("fightinglevel") > 19 then
				ply:Give( "sword_short_iron" )
			else
				ply:Give( "sword_short_copper" )
			end
		elseif ply:Team() == 8 then -- Mages
			ply:Give( "magic_light" )
			ply:Give( "magic_ice" )
		elseif ply:Team() == 11 then -- Priests
			ply:Give( "magic_healing" )
		elseif ply:Team() == 13 then -- Craftsmen
			ply:Give( "chisel" )
		elseif ply:Team() == 14 then -- Labourers
			ply:Give( "axe" )
			ply:Give( "pickaxe" )
		elseif ply:Team() == 16 then -- Wolves
			if ply:GetNWInt("animalleader") == 1 then else
				ply:Give( "claws" )
			end
		elseif ply:Team() == 17 then -- Builder
			ply:Give( "repair_hammer" )
		elseif ply:Team() == 19 then -- Druid
			ply:Give( "pill_antlion" )
			ply:Give( "pill_pigeon" )
			ply:Give( "pill_vortigaunt" )
		end

		-- Leader Weapons
		if ply:GetNWInt("animalleader") == 1 then
			ply:Give( "claws_alpha" )
			ply:Give( "fangs_alpha" )
		elseif ply:GetNWInt("bloodelfleader") == 1 then
			ply:Give( "magic_spellbook_bloodelf_leader" )
			ply:Give( "magic_spirit" )
			ply:Give( "magic_portal" )
		elseif ply:GetNWInt("darkelfleader") == 1 then
			ply:Give( "magic_spellbook_darkelf_leader" )
			ply:Give( "magic_spirit" )
		elseif ply:GetNWInt("nightelfleader") == 1 then
			ply:Give( "pill_pigeon" )
		elseif ply:GetNWInt("dwarfleader") == 1 then
			ply:Give( "sword_dwarf_leader" )
			ply:Give( "gun_dwarf_leader" )
			ply:GiveAmmo( 60, "XBowBolt" )
		elseif ply:GetNWInt("ogreleader") == 1 then
			ply:Give( "sword_ogre_leader" )
			ply:Give( "club_ogre_leader" )
		elseif ply:GetNWInt("goblinleader") == 1 then
			ply:Give( "dagger_goblin_leader" )
			ply:Give( "goblin_firebomb" )
		elseif ply:GetNWInt("humanleader") == 1 then
			ply:Give( "gun_human" )
		elseif ply:GetNWInt("undeadleader") == 1 then
			ply:Give( "magic_spirit" )
		elseif ply:GetNWInt("gnomeleader") == 1 then
			ply:Give( "grapplinghook" )
			ply:Give( "gun_dwarf_leader" )
			ply:GiveAmmo( 30, "XBowBolt" )
		end

		-- Second-in-command Weapons
		if ply:GetNWInt("dwarfsecond") == 1 then
			ply:Give( "gun_dwarf_leader" )
			ply:GiveAmmo( 30, "XBowBolt" )
		elseif ply:GetNWInt("dwarflord") == 1 then
			ply:Give( "gun_dwarf" )
			ply:GiveAmmo( 30, "XBowBolt" )
		elseif ply:GetNWInt("ogresecond") == 1 then
			ply:Give( "sword_ogre_leader" )
		elseif ply:GetNWInt("goblinsecond") == 1 then
			ply:Give( "goblin_firebomb" )
		elseif ply:GetNWInt("humansecond") == 1 then
			ply:Give( "gun_human" )
		elseif ply:GetNWInt("animalsecond") == 1 then
			ply:Give( "claws_alpha" )
		elseif ply:GetNWInt("bloodelfsecond") == 1 then
			ply:Give( "magic_spirit" )
			ply:Give( "bow_fire" )
		elseif ply:GetNWInt("undeadsecond") == 1 then
			ply:Give( "magic_spirit" )
		end

		if CfgVars["allowcustommodels"] == 0 then
			if ply:GetNWString("race") ==  "Goblin" then
				ply:SetModel("models/player/goblin/goblin.mdl")
			elseif ply:GetNWString("race") ==  "Ogre" then
				ply:SetModel("models/player/krall/slow.mdl")
			elseif ply:GetNWString("race") ==  "Undead" then
				ply:SetModel("models/player/undead/undead.mdl")
			elseif ply:GetNWString("race") ==  "Troll" then
				ply:SetModel("models/player/hellknight/hellknight.mdl")
			elseif ply:GetNWInt("second") == 1 and not ply:Team() == 16 then
				ply:SetModel("models/player/Medievalrp/eknight.mdl")
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
			ply:SetPlayerSize( 1.2 )
			ply:SetJumpPower( 250 )
			ply:SetWalkSpeed( 275 )
			ply:SetRunSpeed( 355 )
			ply:SetHealth( 105 )
			ply:SetNWInt("maxhealth", 105)

		elseif ply:GetNWString("race") == "Blood Elf" then
			ply:SetPlayerSize( 1.1 )
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
			ply:SetPlayerSize( 0.8 )
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
			ply:SetPlayerSize( 1.1 )
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
			if ply:GetNWInt("ogreleader") == 1 then
				ply:SetPlayerSize( 1.5 )
				ply:SetJumpPower( 180 )
				ply:SetWalkSpeed( 205 )
				ply:SetRunSpeed( 185 )
			elseif ply:GetNWInt("ogresecond") == 1 then
				ply:SetPlayerSize( 1.35 )
				ply:SetJumpPower( 195 )
				ply:SetWalkSpeed( 220 )
				ply:SetRunSpeed( 300 )
			else
				ply:SetPlayerSize( 1.2 )
				ply:SetJumpPower( 210 )
				ply:SetWalkSpeed( 235 )
				ply:SetRunSpeed( 315 )
			end
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
	end
end
concommand.Add("mrp_changejob", ChangeJob)

function BecomeGuard(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	odessa = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_gman" and v:GetModel() == "models/odessa.mdl" or v:GetClass() == "npc_eli" and v:GetModel() == "models/krall/slow.mdl" then
			odessa = true
		end
	end

	if odessa == true then -- Player must be near the Knight to become a Guard
		if ply:Team() == 2 then -- If the player is already a Guard
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 2 )
			ply:SetNWInt("HUDexpbar", 7)
			ply:SetNWString("job", "Guard")
			return ""
		end
	end
end
concommand.Add("mrp_becomeguard", BecomeGuard)

function BecomeKnight(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	odessa = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_gman" and v:GetModel() == "models/odessa.mdl" or v:GetClass() == "npc_eli" and v:GetModel() == "models/krall/slow.mdl" then
			odessa = true
		end
	end

	if odessa == true then -- Player must be near the Knight to become a Knight
		if ply:Team() == 3 then -- If the player is already a Knight
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		elseif ply:Team() == 2 then
			ply.LastJob = ply:Team()
			ply:SetTeam( 3 )
			ply:SetNWInt("HUDexpbar", 7)
			ply:SetNWString("job", "Knight")
			return ""
		end
	end
end
concommand.Add("mrp_becomeknight", BecomeKnight)

function BecomeKing(ply)
	if ply:GetNWInt("leader") == 1 then
		if ply:Team() == 4 then -- If the player is already a King
			ply:PrintMessage( HUD_PRINTTALK, "Ye are already a King!" )
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 4 )
			ply:SetNWInt("HUDexpbar", 7)
			if ply:GetNWString("sex") == "Male" then
				ply:SetNWString("job", "King")
				if ply:GetName() == ply:GetNWString("name") then
					PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become the King!" )
				else
					PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become the King!" )
				end
			else
				ply:SetNWString("job", "Queen")
				if ply:GetName() == ply:GetNWString("name") then
					PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become the Queen!" )
				else
					PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become the Queen!" )
				end
			end
			ply.LastJob = ply:Team()
			ply:ConCommand( "mrp_changejob" )
		end
		return ""
	end
end
concommand.Add("mrp_becomeking", BecomeKing)
AddChatCommand("/king", BecomeKing)
AddChatCommand("/queen", BecomeKing)

function BecomeMage(ply)
	if ply:IsAdmin() then
		if ply:Team() == 8 then -- If the player is already a Mage
			ply:PrintMessage( HUD_PRINTTALK, "Ye are already a Mage!" )
			return ""
		else
			if ply:GetNWString("race") == "Dwarf" then
				ply:PrintMessage( HUD_PRINTTALK, "Dwarves cannot be Mages." )
				return ""
			else
				ply.LastJob = ply:Team()
				ply:SetTeam( 8 )
				if math.random( 1, 2 ) == 1 then
					local randomalma = 6
				else
					local randomalma = 9 
				end
				ply:SetNWInt("HUDexpbar", randomalma )
				ply:SetNWString("job", "Mage")
				if ply:GetName() == ply:GetNWString("name") then
					PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Mage!" )
				else
					PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Mage!" )
				end
				ply:Kill()
				return ""
			end
		end
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye must be admin to become a Mage!" )
	end
end
concommand.Add("mrp_becomemage", BecomeMage)
AddChatCommand("/mage", BecomeMage)

function BecomeBlacksmith(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	kleiner = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_kleiner" then
			kleiner = true
		end
	end

	if kleiner == true then -- Player must be near the Smith to become a Blacksmith
		if ply:Team() == 10 then -- If the player is already a Blacksmith
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		else
			if ply:GetNWString("race") == "Night Elf" then
				ply:PrintMessage( HUD_PRINTTALK, "Night Elves cannot be Blacksmiths." )
				return ""
			else
				ply.LastJob = ply:Team()
				ply:SetTeam( 10 )
				ply:SetNWInt("HUDexpbar", 1)
				ply:SetNWString("job", "Blacksmith")
				return ""
			end
		end
	end
end
concommand.Add("mrp_becomeblacksmith", BecomeBlacksmith)

function BecomePriest(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	monk = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_monk" then
			monk = true
		end
	end

	if monk == true then -- Player must be near the Priest to become a Priest
		if ply:Team() == 11 then -- If the player is already a Priest
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		else
			if ply:GetNWString("race") == "Human" then
				ply:PrintMessage( HUD_PRINTTALK, "Humans cannot be Priests." )
				return ""
			else
				ply.LastJob = ply:Team()
				ply:SetTeam( 11 )
				if math.random( 1, 2 ) == 1 then
					local randomalma = 6
				else
					local randomalma = 9
				end
				ply:SetNWInt("HUDexpbar", randomalma )
				ply:SetNWString("job", "Priest")
				return ""
			end
		end
	end
end
concommand.Add("mrp_becomepriest", BecomePriest)

function BecomeCook(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	mossman = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_mossman" then
			mossman = true
		end
	end

	if mossman == true then -- Player must be near the Cook to become a Cook
		if ply:Team() == 12 then -- If the player is already a Cook
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 12 )
			ply:SetNWInt("HUDexpbar", 5)
			ply:SetNWString("job", "Cook")
			return ""
		end
	end
end
concommand.Add("mrp_becomecook", BecomeCook)

function BecomeCraftsman(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	rebel = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_gman" and v:GetModel() == "models/humans/group03/male_07.mdl" or v:GetClass() == "npc_gman" and v:GetModel() == "models/krall/slow.mdl" then
			rebel = true
		end
	end

	if rebel == true then -- Player must be near the Craftsman to become a Craftsman
		if ply:GetNWString("race") == "Undead" then
			ply:PrintMessage( HUD_PRINTTALK, "Undead cannot be Craftsmen." )
			return ""
		end
		if ply:Team() == 13 then -- If the player is already a Craftsman
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 13 )
			ply:SetNWInt("HUDexpbar", 4)
			ply:SetNWString("job", "Craftsman")
			return ""
		end
	end
end
concommand.Add("mrp_becomecraftsman", BecomeCraftsman)

function BecomeLabourer(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	rebel = nil
	for k,v in pairs(foundents) do
		if (v:GetClass() == "npc_gman" and v:GetModel() == "models/humans/group03/male_06.mdl") or (v:GetClass() == "npc_gman" and v:GetModel() == "models/undead/undead.mdl") then
			rebel = true
		end
	end

	if rebel == true then -- Player must be near the Labourer to become a Labourer
		if ply:Team() == 14 then -- If the player is already a Labourer
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 14 )
			ply:SetNWString("job", "Labourer")
			return ""
		end
	end
end
concommand.Add("mrp_becomelabourer", BecomeLabourer)

function BecomeInnKeeper(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	barney = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_barney" or (v:GetClass() == "npc_gman" and v:GetModel() == "models/goblin/goblin.mdl") then
			barney = true
		end
	end

	if barney == true then -- Player must be near the Inn Keeper to become an Inn Keeper
		if ply:Team() == 15 then -- If the player is already an Inn Keeper
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 15 )
			ply:SetNWString("job", "Inn Keeper")
			return ""
		end
	end
end
concommand.Add("mrp_becomeinnkeeper", BecomeInnKeeper)

function BecomeWolf(ply)
	if ply:IsAdmin() or ply:GetNWInt("animalsecond") == 1 then
		if ply:Team() == 16 then -- If the player is already a Wolf
			ply:PrintMessage( HUD_PRINTTALK, "Ye are already a Wolf!" )
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 16 )
			ply:SetNWInt("HUDexpbar", 7)
			ply:SetNWString("job", "Wolf")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Wolf!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Wolf!" )
			end
			ply:Kill()
			return ""
		end
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye have to be Admin to become a Wolf!" )
	end
end
concommand.Add("mrp_becomewolf", BecomeWolf)
AddChatCommand("/wolf", BecomeWolf)

function BecomeBuilder(ply)
	if GetGlobalInt("buildernumber") > 2 then
		ply:PrintMessage( HUD_PRINTTALK, "There are already too many builders." )
	else
		if ply:Team() == 17 then -- If the player is already a Builder
			ply:PrintMessage( HUD_PRINTTALK, "Ye are already a Builder!" )
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 17 )
			ply:SetNWString("job", "Builder")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Builder!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Builder!" )
			end
			ply:Kill()
			return ""
		end
	end
end
concommand.Add("mrp_becomebuilder", BecomeBuilder)
AddChatCommand("/builder", BecomeBuilder)

function BecomeFisherman(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	breen = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_breen" then
			breen = true
		end
	end

	if breen == true then -- Player must be near the Harbour Master to become a Fisherman
		if ply:Team() == 18 then -- If the player is already a Fisherman
			ply.LastJob = ply:Team()
			ply:SetTeam( 1 )
			ply:SetNWString("job", "Peasant")
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 18 )
			ply:SetNWInt("HUDexpbar", 8)
			ply:SetNWString("job", "Fisherman")
			return ""
		end
	end
end
concommand.Add("mrp_becomefisherman", BecomeFisherman)

function BecomeDruid(ply)
	if ply:IsAdmin() then
		if ply:Team() == 19 then -- If the player is already a Druid
			ply:PrintMessage( HUD_PRINTTALK, "Ye are already a Druid!" )
			return ""
		else
			ply.LastJob = ply:Team()
			ply:SetTeam( 19 )
			ply:SetNWInt("HUDexpbar", 9)
			ply:SetNWString("job", "Druid")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Druid!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Druid!" )
			end
			ply:Kill()
			return ""
		end
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye have to be an Admin to become a Druid!" )
	end
end
concommand.Add("mrp_becomedruid", BecomeDruid)
AddChatCommand("/druid", BecomeDruid)

function CustomJob(ply, args)
	ply:SetNWString("job", args)
	PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has set their job to " .. args .. "!" )
	return ""
end
concommand.Add("mrp_customjob", CustomJob)
AddChatCommand("/job", CustomJob)

-- Personal Qualities

function CustomName(ply, args)
	if args then
		ply:SetNWString("name", args)
		DataStoreName(ply, args)
		PrintMessage( HUD_PRINTTALK, ply:GetName() .. " set their name to " .. args .. "!" )
	else
		ply:SetNWString("name", ply:GetName())
		DataStoreName(ply, args)
		PrintMessage( HUD_PRINTTALK, ply:GetName() .. " set their name to " .. ply:GetName() .. "!" )
	end
	return ""
end
concommand.Add("mrp_customname", CustomName)
AddChatCommand("/name", CustomName)

function SexChange(ply)
	if ply:GetNWString("sex") == "Male" then
		ply:SetNWString("sex", "Female")
		if ply:GetName() == ply:GetNWString("name") then
			PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Woman!" )
		else
			PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Woman!" )
		end
	else
		ply:SetNWString("sex", "Male")
		if ply:GetName() == ply:GetNWString("name") then
			PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Man!" )
		else
			PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Man!" )
		end
	end
	ply:Kill()
	return ""
end
concommand.Add("mrp_sexchange", SexChange)
AddChatCommand("/sexchange", SexChange)

function Race(ply, args)
	if args == "dwarf" then
		if ply:GetNWString("race") == "Dwarf" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already a Dwarf!" )
		else
			ply:SetNWString("race", "Dwarf")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Dwarf!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Dwarf!" )
			end
			ply:Kill()
		end
	elseif args == "night elf" or args == "nightelf" or args == "elf" then
		if ply:GetNWString("race") == "Night Elf" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already a Night Elf!" )
		else
			ply:SetNWString("race", "Night Elf")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Night Elf!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Night Elf!" )
			end
			ply:Kill()
		end
	elseif args == "dark elf" or args == "darkelf" then
		if ply:GetNWString("race") == "Dark Elf" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already a Dark Elf!" )
		else
			ply:SetNWString("race", "Dark Elf")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Dark Elf!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Dark Elf!" )
			end
			ply:Kill()
		end
	elseif args == "blood elf" or args == "bloodelf" then
		if ply:GetNWString("race") == "Blood Elf" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already a Blood Elf!" )
		else
			ply:SetNWString("race", "Blood Elf")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Blood Elf!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Blood Elf!" )
			end
			ply:Kill()
		end
	elseif args == "gnome" then
		if ply:GetNWString("race") == "Gnome" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already a Gnome!" )
		else
			ply:SetNWString("race", "Gnome")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Gnome!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Gnome!" )
			end
				ply:Kill()
			end
	elseif args == "ogre" then
		if ply:GetNWString("race") == "Ogre" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already an Ogre!" )
		else
			ply:SetNWString("race", "Ogre")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become an Ogre!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become an Ogre!" )
			end
			ply:Kill()
		end
	elseif args == "goblin" then
		if ply:GetNWString("race") == "Goblin" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already a Goblin!" )
		else
			ply:SetNWString("race", "Goblin")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Goblin!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Goblin!" )
			end
			ply:Kill()
		end
	elseif args == "troll" then
		if ply:GetNWString("race") == "Troll" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already a Troll!" )
		else
			ply:SetNWString("race", "Troll")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Troll!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Troll!" )
			end
			ply:Kill()
		end
	elseif args == "undead" or args == "skeleton" then
		if ply:GetNWString("race") == "Undead" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already an Undead!" )
		else
			ply:SetNWString("race", "Undead")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become an Undead!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become an Undead!" )
			end
			ply:Kill()
		end
	else
		if ply:GetNWString("race") == "Human" then
			ply:PrintMessage( HUD_PRINTTALK, "You are already a Human!" )
		else
			ply:SetNWString("race", "Human")
			if ply:GetName() == ply:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " has become a Human!" )
			else
				PrintMessage( HUD_PRINTTALK, ply:GetName() .. " (" .. ply:GetNWString("name") .. ") has become a Human!" )
			end
			ply:Kill()
		end
	end
	ply:SetTeam( 1 )
	ply:SetNWString("job", "Peasant")
	return ""
end
concommand.Add("mrp_race", Race)
AddChatCommand("/race", Race)

-- Name Check

function IsRpName( args )
	for k, v in pairs(player.GetAll()) do
		if v:GetNWString("name") == args then
			return true
		end
	end
	return false
end

-- Save

function TimedSaveInventory()
	for k, v in pairs(player.GetAll()) do
		InventoryAddon:SaveInventoryData( v )
		Msg( "Saved " .. v:GetName() .. "'s (" .. v:UniqueID() .. ") Inventory\n")
	end
end

function TimedSaveGold()
	for k, v in pairs(player.GetAll()) do
		SaveGold( v )
		Msg( "Saved " .. v:GetName() .. "'s (" .. v:UniqueID() .. ") Gold\n")
	end
end

function TimedSaveLevel()
	for k, v in pairs(player.GetAll()) do
		SaveSmithingLevel( v )
		SaveCraftingLevel( v )
		SaveLumberingLevel( v )
		SaveMiningLevel( v )
		SaveCookingLevel( v )
		SaveAlchemyLevel( v )
		SaveFightingLevel( v )
		SaveFishingLevel( v )
		SaveMagicLevel( v )
		Msg( "Saved " .. v:GetName() .. "'s (" .. v:UniqueID() .. ") Levels and Experience\n")
	end
end

--_____
--Agaga
--_____

local pullRange		= 128
local holdRange		= 64
local throwStrength	= 15
local pullStrength	= 70

function agagaDrop( pl )
	if(pl.GrabbedEnt)then
		pl.GrabbedPhys:EnableGravity(true)
		pl.GrabbedPhys:SetVelocity(pl.GrabbedPhys:GetVelocity()*throwStrength-pl:GetVelocity()*(throwStrength-1))
		if(pl:KeyDown( IN_ATTACK )) then
			pl.GrabbedPhys:SetVelocity( pl:GetAimVector()*throwStrength*40 + pl:GetVelocity() )
		end
		pl.GrabbedEnt=nil
	end
end

local function agagaThink()
	for _, pl in pairs(player.GetAll()) do
		if(pl:Alive())then
			//Prevent Rapid Fire +USE
			if(pl.GrabChange&&!pl:KeyDown( IN_ATTACK2 )) then
				pl.GrabChange=false
			end
			//If i am grabbing something
			if (pl:GetWeapon("hands")==pl:GetActiveWeapon()) then
				pl:DrawViewModel(false)
				if(pl.GrabbedEnt)then
					pl:GetActiveWeapon():SetNextPrimaryFire(CurTime()+1)
					pl:GetActiveWeapon():SetNextSecondaryFire(CurTime()+1)
					ent=pl.GrabbedEnt
					if(ent:IsValid())then
						phys= pl.GrabbedPhys
						if(ent:GetMoveType() == MOVETYPE_VPHYSICS)then
							if(((pl:KeyDown( IN_ATTACK2 )||pl:KeyDown( IN_ATTACK )||pl:KeyDown( IN_ATTACK2 )||pl:KeyDown( IN_ALT1 )||pl:KeyDown( IN_ALT2 )) && !pl.GrabChange)||pl:InVehicle( )) then
								agagaDrop( pl )
								pl.GrabChange=true
							else
								local tracedata = {}
								tracedata.start = pl:EyePos( )
								tracedata.endpos = pl:EyePos( )+(pl:GetAimVector()*(holdRange+pl.GrabbedEnt:BoundingRadius( )))
								tracedata.filter = {pl,pl.GrabbedEnt}
								local trace = util.TraceLine(tracedata)
								dist=trace.HitPos:Distance(pl:EyePos( ))
								dist=dist-pl.GrabbedEnt:BoundingRadius( )
								if(dist>holdRange)then	dist=holdRange	end
								pos=pl:EyePos()+pl:GetAimVector()*dist-phys:GetMassCenter()
								vel=pl:GetVelocity()+(pl:EyePos()+pl:GetAimVector()*dist-phys:GetPos()-phys:GetMassCenter())*4
								ang=pl:GetAimVector():Angle()
								ang.x=0
								phys:SetPos(pos)
								phys:SetVelocity(vel)
							end
							if (pl:KeyDown( IN_RELOAD ) and pl.GrabbedEnt~= nil) then
								local tracedata = {}
								tracedata.start = pl:EyePos( )
								tracedata.endpos = pl:EyePos( )+(pl:GetAimVector()*(holdRange+pl.GrabbedEnt:BoundingRadius( )))
								tracedata.filter = {pl,pl.GrabbedEnt}
								local trace = util.TraceLine(tracedata)
								dist=trace.HitPos:Distance(pl:EyePos( ))
								dist=dist-pl.GrabbedEnt:BoundingRadius( )
								if(dist>holdRange)then	dist=holdRange	end
								pos=pl:EyePos()+pl:GetAimVector()*dist-phys:GetMassCenter()
								vel=pl:GetVelocity()+(pl:EyePos()+pl:GetAimVector()*dist-phys:GetPos()-phys:GetMassCenter())*4
								ang=pl:GetAimVector():Angle()
								ang.x=0
								phys:SetPos(pos)
								ang=pl:GetAimVector():Angle()
								ang.x=0
								phys:SetAngle(ang)
							end
						else
							pl.GrabbedEnt=nil
						end
					else
						pl.GrabbedEnt=nil
					end
				//otherwise...
				elseif(!pl.GrabbedEnt) then
					pl:DrawViewModel(false)
					//find the closest, most in front object
					ent=nil
					bestcost=0
					for k, v in pairs( ents.FindInSphere( pl:GetPos(), pullRange ) ) do
						if(!(v==pl)) then
							if(v:IsValid() && v:GetMoveType() == MOVETYPE_VPHYSICS) then
								dotmin=0.9
								looking=pl:GetAimVector()
								looking.z=0
								looking=looking:Normalize()
								direction=((v:GetPos()+v:GetPhysicsObject():GetMassCenter())-pl:EyePos())
								direction.z=0
								direction=direction:Normalize()
								if ( looking != nil ) then
									dot=looking:DotProduct(direction)
									if(dot>=dotmin)then
										dot=(2-dot)*4
										dist=(v:GetPos()+v:GetPhysicsObject():GetMassCenter()):Distance(pl:EyePos( ))
										cost=dist*dot
										if(!ent) then
											ent=v
											bestcost=cost
										elseif(cost<bestcost) then
											ent=v
											bestcost=cost
										end
									end
								end
							end
						end
					end
					//found something suitable.
					if(ent) then
						local v = {}
						v.start = pl:GetShootPos()
						v.endpos = v.start + pl:GetAimVector() * pullRange
						v.filter = pl
						v = util.TraceLine(v)
						if(v.Entity==ent)then
							phys= ent:GetPhysicsObjectNum(v.PhysicsBone)
						else
							phys= ent:GetPhysicsObject()
						end
						if(pl:KeyDown( IN_ATTACK2 ) && !pl.GrabChange) then
							if(phys) then
							if(phys:GetMass()<9)then
								if((phys:GetPos()+phys:GetMassCenter()):Distance(pl:EyePos( )) <= holdRange ) then
									pl.GrabbedEnt=ent
									pl.GrabbedPhys=phys
									phys:EnableGravity(false)
									pl.GrabChange=true
								elseif(v.HitPos:Distance(pl:EyePos( )) <= pullRange ) then
									pulldir=((pl:EyePos( )+pl:GetAimVector():Normalize()*64)-(phys:GetPos()+phys:GetMassCenter())):Normalize()
									phys:ApplyForceCenter ((pulldir * pullStrength) * phys:GetMass())
								end
							end
							end
						end
					end
				end
			else
				agagaDrop( pl )
			end
		end
	end
end
hook.Add("Think","agagaThink",agagaThink)

--_____
-- Gold
--_____

local PMeta = FindMetaTable( "Player" )

function PMeta:CanAfford(amount)
	if self:GetNWInt("gold") == amount then
		return true
	elseif self:GetNWInt("gold") > amount then
		return true
	else
		return false
	end
end

--_____
-- Cook
--_____

function BuyStove(ply)
	local cost = 65

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:GetClass() == "stove" and v:GetNWString("entowner") == ply then
			v:Remove()
		end
	end

	if ply:Team() == 12 then -- Player must be a Cook to buy
		local entity = ents.Create("stove")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		entity:SetNWString("entowner", ply)
		TakeGold( ply, "gold", cost )
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be a Cook to buy this.")
		return ""
	end
end
concommand.Add("mrp_buystove", BuyStove)
AddChatCommand("/buystove", BuyStove)

--___________
-- Blacksmith
--___________

function BuyFurnace(ply)
	local cost = 105

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:GetClass() == "furnace" and v:GetNWString("entowner") == ply then
			v:Remove()
		end
	end

	if ply:Team() == 10 then -- Player must be a Blacksmith to buy
		local entity = ents.Create("furnace")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		entity:SetNWString("entowner", ply)
		TakeGold( ply, "gold", cost )
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be a Blacksmith to buy this.")
		return ""
	end
end
concommand.Add("mrp_buyfurnace", BuyFurnace)
AddChatCommand("/buyfurnace", BuyFurnace)

function BuyAnvil(ply)
	local cost = 50

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:GetClass() == "anvil" and v:GetNWString("entowner") == ply then
			v:Remove()
		end
	end

	if ply:Team() == 10 then -- Player must be a Blacksmith to buy
		local entity = ents.Create("anvil")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		entity:SetNWString("entowner", ply)
		TakeGold( ply, "gold", cost )
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be a Blacksmith to buy this.")
		return ""
	end
end
concommand.Add("mrp_buyanvil", BuyAnvil)
AddChatCommand("/buyanvil", BuyAnvil)

--__________
-- Craftsman
--__________

function BuyWorkbench(ply)
	local cost = 85

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:GetClass() == "workbench" and v:GetNWString("entowner") == ply then
			v:Remove()
		end
	end

	if ply:Team() == 13 then -- Player must be a Craftsman to buy
		local entity = ents.Create("workbench")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		entity:SetNWString("entowner", ply)
		TakeGold( ply, "gold", cost )
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be a Craftsman to buy this.")
		return ""
	end
end
concommand.Add("mrp_buyworkbench", BuyWorkbench)
AddChatCommand("/buyworkbench", BuyWorkbench)

--_____
-- Priest
--_____

function BuyAlchemyKit(ply)
	local cost = 35

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:GetClass() == "kit" and v:GetNWString("entowner") == ply then
			v:Remove()
		end
	end

	if ply:Team() == 11 or ply:Team() == 8 then -- Player must be a Mage or Priest to buy
		local entity = ents.Create("kit")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		entity:SetNWString("entowner", ply)
		TakeGold( ply, "gold", cost )
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be a Priest or a Mage to buy this.")
		return ""
	end
end
concommand.Add("mrp_buykit", BuyAlchemyKit)
AddChatCommand("/buykit", BuyAlchemyKit)

function BuyFountain(ply)
	local cost = 20

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:GetClass() == "fountain" and v:GetNWString("entowner") == ply then
			v:Remove()
		end
	end

	if ply:Team() == 11 or ply:Team() == 8 then -- Player must be a Mage or Priest to buy
		local entity = ents.Create("fountain")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		entity:SetNWString("entowner", ply)
		TakeGold( ply, "gold", cost )
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be a Priest or a Mage to buy this.")
		return ""
	end
end
concommand.Add("mrp_buyfountain", BuyFountain)
AddChatCommand("/buyfountain", BuyFountain)

--__________
-- Fisherman
--__________

function BuyBait(ply)
	local cost = 4

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	breen = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_breen" then
			breen = true
		end
	end

	if breen == true then -- Player must be near the Harbour Master to buy it
		local entity = ents.Create("fishing_bait")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		TakeGold( ply, "gold", cost )
		return ""
	end
end
concommand.Add("mrp_buybait", BuyBait)

function BuyRod(ply)
	local cost = 50

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
	for k,v in pairs(foundents) do
		if v:GetClass() == "fishing_rod" and v:GetNWString("entowner") == ply then
			v:Remove()
		elseif v:GetClass() == "fishing_hook" and v:GetNWString("entowner") == ply then
			v:Remove()
		end
	end

	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	breen = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_breen" then
			breen = true
		end
	end

	if breen == true then -- Player must be near the Harbour Master to buy it
		local entity = ents.Create("fishing_rod")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		entity:SetNWString("entowner", ply)

		local entity = ents.Create("fishing_hook")
		entity:SetNWString("Owner", ply)
		local tr = ply:EyeTrace( 80 )
		entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		entity.nodupe = true
		entity:Spawn()
		entity:SetNWString("entowner", ply)
		TakeGold( ply, "gold", cost )
		return ""
	end
end
concommand.Add("mrp_buyrod", BuyRod)

--___________
-- Inn Keeper
--___________

function BuyMead(ply)
	local cost = 3

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local entity = ents.Create("drink_mead")
	entity:SetNWString("Owner", "Shared")
	if game.GetMap() == "gm_flatgrass2008" then
		entity:SetPos(Vector(6128.4018554688, 5719.609375, 113.38957214355))
	end
	entity.nodupe = true
	entity:Spawn()
	TakeGold( ply, "gold", cost )
	return ""
end
concommand.Add("mrp_buymead", BuyMead)

function BuyEMead(ply)
	local cost = 3

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	local entity = ents.Create("drink_mead")
	entity:SetNWString("Owner", "Shared")
	if game.GetMap() == "gm_flatgrass2008" then
		entity:SetPos(Vector(6128.4018554688, 5719.609375, 113.38957214355))
	end
	entity.nodupe = true
	entity:Spawn()
	TakeGold( ply, "gold", cost )
	return ""
end
concommand.Add("mrp_ebuymead", BuyEMead)

function BuyMeadPlayer(ply)
	local cost = 3

	if not ply:CanAfford( cost ) then
		ply:PrintMessage( HUD_PRINTTALK, "Ye can't afford to buy that.")
		return ""
	end

	if ply:Team() == 15 then
		local entity = ents.Create("drink_mead")
		entity:SetNWString("Owner", ply)
		entity.nodupe = true
		entity:Spawn()
		TakeGold( ply, "gold", cost )
	end
	return ""
end
concommand.Add("mrp_buymeadplayer", BuyMeadPlayer)
AddChatCommand("/buymead", BuyMeadPlayer)

--_________
-- Labourer
--_________

function SpawnMine(ply)
	if ply:Team() == 14 then -- Player must be a Labourer to spawn
		ply:ConCommand("gm_spawn models/props_wasteland/rockcliff01f.mdl")
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be a Labourer to spawn this.")
		return ""
	end
end
concommand.Add("mrp_spawnmine", SpawnMine)

function SpawnTree(ply)
	if ply:Team() == 14 then -- Player must be a Labourer to spawn
		ply:ConCommand("gm_spawn models/props_foliage/tree_deciduous_03a.mdl")
		return ""
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye need to be a Labourer to spawn this.")
		return ""
	end
end
concommand.Add("mrp_spawntree", SpawnTree)

-- Make Jobs

function FindPlayer(info)
	local pls = player.GetAll()

	-- Find by Index Number (status in console)
	for k, v in pairs(pls) do
		if tonumber(info) == v:UserID() then
			return v
		end
	end

	-- Find by Steam ID
	for k, v in pairs(pls) do
		if info == v:SteamID() then
			return v
		end
	end

	-- Find by RP Name
	for k, v in pairs(pls) do
		if string.find(string.lower(v:GetNWInt("name")), string.lower(tostring(info)), 1, true) ~= nil then
			return v
		end
	end

	-- Find by Partial Nick
	for k, v in pairs(pls) do
		if string.find(string.lower(v:Name()), string.lower(tostring(info)), 1, true) ~= nil then
			return v
		end
	end
	return nil
end

function MakeotherWolf(ply, cmd, args)
	if ply:EntIndex() ~= 0 and not ply:IsAdmin() then
		ply:PrintMessage(2, "You're not an admin!")
		return
	end

	local target = FindPlayer(args[1])

	if target then
		local nick = ""

		if ply:EntIndex() ~= 0 then
			nick = ply:Nick()
		else
			nick = "Console"
		end

		if target:Team() == 16 then -- If the player is already a Wolf
			target:PrintMessage( HUD_PRINTTALK, "Ye are already a Wolf!" )
			return ""
		else
			target:SetTeam( 16 )
			target:SetNWString("job", "Wolf")
			if target:GetName() == target:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, target:GetName() .. " has become a Wolf!" )
			else
				PrintMessage( HUD_PRINTTALK, target:GetName() .. " (" .. target:GetNWString("name") .. ") has become a Wolf!" )
			end
			target:Kill()
		end
		target:PrintMessage(2, nick .. " made you a Wolf!")
	else
		print("Could not find player: " .. args[1])
		return
	end
end
concommand.Add("mrp_wolf", MakeotherWolf)

function MakeotherPeasant(ply, cmd, args)
	if ply:EntIndex() ~= 0 and not ply:IsAdmin() then
		ply:PrintMessage(2, "You're not an admin!")
		return
	end

	local target = FindPlayer(args[1])

	if target then
		local nick = ""

		if ply:EntIndex() ~= 0 then
			nick = ply:Nick()
		else
			nick = "Console"
		end

		if target:Team() == 1 then -- If the player is already a Peasant
			target:PrintMessage( HUD_PRINTTALK, "Ye are already a Peasant!" )
			return ""
		else
			target:SetTeam( 1 )
			target:SetNWString("job", "Peasant")
			if target:GetName() == target:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, target:GetName() .. " has become a Peasant!" )
			else
				PrintMessage( HUD_PRINTTALK, target:GetName() .. " (" .. target:GetNWString("name") .. ") has become a Peasant!" )
			end
			target:Kill()
		end
		target:PrintMessage(2, nick .. " made you a Peasant!")
	else
		print("Could not find player: " .. args[1])
		return
	end
end
concommand.Add("mrp_peasant", MakeotherPeasant)

function MakeotherMage(ply, cmd, args)
	if ply:EntIndex() ~= 0 and not ply:IsAdmin() then
		ply:PrintMessage(2, "You're not an admin!")
		return
	end

	local target = FindPlayer(args[1])

	if target then
		local nick = ""

		if ply:EntIndex() ~= 0 then
			nick = ply:Nick()
		else
			nick = "Console"
		end

		if target:Team() == 8 then -- If the player is already a Mage
			target:PrintMessage( HUD_PRINTTALK, "Ye are already a Mage!" )
			return ""
		else
			target:SetTeam( 8 )
			target:SetNWString("job", "Mage")
			if target:GetName() == target:GetNWString("name") then
				PrintMessage( HUD_PRINTTALK, target:GetName() .. " has become a Mage!" )
			else
				PrintMessage( HUD_PRINTTALK, target:GetName() .. " (" .. target:GetNWString("name") .. ") has become a Mage!" )
			end
			target:Kill()
		end
		target:PrintMessage(2, nick .. " made you a Mage!")
	else
		print("Could not find player: " .. args[1])
		return
	end
end
concommand.Add("mrp_mage", MakeotherMage)

function GiveTowerClearance(ply, cmd, args)
	if ply:EntIndex() ~= 0 and not ply:IsAdmin() then
		ply:PrintMessage(2, "You're not an admin!")
		return
	end

	local target = FindPlayer(args[1])

	if target then
		local nick = ""

		if ply:EntIndex() ~= 0 then
			nick = ply:Nick()
		else
			nick = "Console"
		end

		target.TowerClearance = 1
		target:PrintMessage(2, nick .. " has given you permission to use the tower portals!")
	else
		print("Could not find player: " .. args[1])
		return
	end
end
concommand.Add("mrp_givetower", GiveTowerClearance)

function TakeTowerClearance(ply, cmd, args)
	if ply:EntIndex() ~= 0 and not ply:IsAdmin() then
		ply:PrintMessage(2, "You're not an admin!")
		return
	end

	local target = FindPlayer(args[1])

	if target then
		local nick = ""

		if ply:EntIndex() ~= 0 then
			nick = ply:Nick()
		else
			nick = "Console"
		end

		target.TowerClearance = 0
		target:PrintMessage(2, nick .. " has taken your permission to use the tower portals!")
	else
		print("Could not find player: " .. args[1])
		return
	end
end
concommand.Add("mrp_taketower", TakeTowerClearance)

-- Food

function EatFood(ply, amount)
	local addition = ply:GetNWInt("hunger") + amount
	if addition > 100 then
		ply:SetNWInt("hunger", 100)
	else
		ply:SetNWInt("hunger", addition)
	end
	return ""
end

-- Old Commands

function MedievalAFK(ply)
	if ply:GetNWInt("afk") == 0 then
		local oldname = ply:GetNWString("name")
		local oldjob = ply:GetNWString("job")
		ply:SetNWInt("afk", 1 )
		ply:Freeze( true )
		ply:SetNWString("nameold", oldname)
		ply:SetNWString("jobold", oldjob)
		ply:SetNWString("job", "AFK - " .. oldjob)
		ply:SetNWString("name", "AFK - " .. oldname)
		ply:GodEnable()
		PrintMessage( HUD_PRINTTALK, "Steam player: " .. ply:Name() .. " is now AFK.")
		ply:PrintMessage( HUD_PRINTTALK, "Type /unafk to... Un-AFK.")
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye are already AFK.")
	end
	return ""
end
AddChatCommand("/afk", MedievalAFK)
concommand.Add("mrp_afk", MedievalAFK)

function MedievalUnAFK(ply)
	if ply:GetNWInt("afk") == 1 then
		local oldname = ply:GetNWString("nameold")
		local oldjob = ply:GetNWString("jobold")
		ply:SetNWString("job", oldjob )
		ply:SetNWString("name", oldname)
		ply:Freeze( false )
		ply:SetNWInt("afk", 0 )
		ply:GodDisable()
		PrintMessage( HUD_PRINTTALK, "Steam player: " .. ply:Name() .. " is no longer AFK")
	else
		ply:PrintMessage( HUD_PRINTTALK, "Ye are not AFK, therefore can't use this.")
	end
	return ""
end
AddChatCommand("/unafk", MedievalUnAFK)
concommand.Add("mrp_unafk", MedievalUNAFK)

-- Chat

function PM(ply, args)
	local namepos = string.find(args, " ")
	if not namepos then return "" end

	local name = string.sub(args, 1, namepos - 1)
	local msg = string.sub(args, namepos + 1)

	target = FindPlayer(name)

	if target then
		target:PrintMessage(2, ply:Nick() .. ": (Private) " .. msg)
		target:PrintMessage(3, ply:Nick() .. ": (Private) " .. msg)

		ply:PrintMessage(2, ply:Nick() .. ": (Private) " .. msg)
		ply:PrintMessage(3, ply:Nick() .. ": (Private) " .. msg)
	else
		ply:PrintMessage( HUD_PRINTTALK, "Could not find player: " .. name)
	end

	return ""
end
AddChatCommand("/pm", PM)

function Whisper(ply, args)
	ChatRadius("(Whisper)" .. ply:Nick() .. ": " .. args, ply:EyePos(), 90)
	return ""
end
AddChatCommand("/w", Whisper)
AddChatCommand("/whisper", Whisper)

function Yell(ply, args)
	ChatRadius("(Yell)" .. ply:Nick() .. ": " .. args, ply:EyePos(), 550)
	return ""
end
AddChatCommand("/y", Yell)
AddChatCommand("/yell", Yell)

function OOC(ply, args)
	return "(OOC) " .. args
end
AddChatCommand("//", OOC)
AddChatCommand("/a", OOC)
AddChatCommand("/ooc", OOC)

function It(ply, args)
	PrintMessage( HUD_PRINTTALK, "** "..args )
	return ""
end
AddChatCommand("/it", It)

function ChatRadius(msg, pos, size)
	local ents = ents.FindInSphere(pos, size)

	for k, v in pairs(ents) do
		if v:IsPlayer() then
			v:ChatPrint(msg)
			v:PrintMessage(2, msg)
		end
	end
end

function ShowTipPlayer(ply, msgtype, len, msg)
	if not IsValid(ply) then return end
	umsg.Start("ShowTip", ply)
		umsg.String(msg)
		umsg.Short(msgtype)
		umsg.Long(len)
	umsg.End()
end

-- Quest stuff

function HasLetter(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	breen = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_breen" then
			breen = true
		end
	end

	if breen == true then -- Player must be near the Harbour Master to recieve the Letter
		ply:SetNWInt("hasletter", 1)
	end
end
concommand.Add("mrp_hasletter", HasLetter)

function GiveLetter(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	rebel = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_gman" and v:GetModel() == "models/humans/group03/male_09.mdl" then
			rebel = true
		end
	end

	if rebel == true then -- Player must be near the Fisherman to hand in the letter
		ply:SetNWInt("hasletter", 0)
	end
end
concommand.Add("mrp_giveletter", GiveLetter)

function HasFish(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	rebel = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_gman" and v:GetModel() == "models/humans/group03/male_09.mdl" then
			rebel = true
		end
	end

	if rebel == true then -- Player must be near the Fisherman to hand in the Letter
		ply:SetNWInt("hasfish", 1)
	end
end
concommand.Add("mrp_hasfish", HasFish)

function GiveFish(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	breen = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_breen" then
			breen = true
		end
	end

	if breen == true then -- Player must be near the Fisherman to hand in the Fish
		ply:SetNWInt("hasfish", 0)
		GiveGold(ply, "gold", 30)

		local oldfexp = ply:GetNWInt("fishingexp")
		randomgain = math.random( 10, 30 )
		FishingLevelData[ ply:UniqueID() ][ "fishingexp" ] = oldfexp + randomgain
		ply:SetNWInt( "fishingexp", oldfexp + randomgain)

		if ply:GetNWInt("fishingexp") > 99 then
			local oldfexp = ply:GetNWInt("fishingexp")
			local oldflevel = ply:GetNWInt("fishinglevel")
			FishingLevelData[ ply:UniqueID() ][ "fishingexp" ] = 0
			ply:SetNWInt( "fishingexp", 0)
			FishingLevelData[ ply:UniqueID() ][ "fishinglevel" ] = oldflevel + 1
			ply:SetNWInt( "fishinglevel", oldflevel + 1)
			newlevel = oldflevel + 1
			ply:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Fishing!" )
		end
		ply:PrintMessage( HUD_PRINTTALK, "You were awarded 30 Gold and "..randomgain.." Fishing Experience for completing this quest." )
	end
end
concommand.Add("mrp_givefish", GiveFish)

function CompleteCannonQuest(ply)
	local foundents = ents.FindInSphere(Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z), 100)
	aaron = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_breen" and v:GetModel() == "models/humans/group03/male_07.mdl" then
			aaron = true
		end
	end

	if aaron == true then -- Player must be near the Fisherman to hand in the Fish
		ply:SetNWInt("completedcannonquest", 0)
		randomgain = math.random( 10, 30 )
		GiveGold(ply, "gold", randomgain)

		ply:PrintMessage( HUD_PRINTTALK, "You were awarded "..randomgain.." Gold for completing this quest." )
	end
end
concommand.Add("mrp_completecannonquest", CompleteCannonQuest)

-- Ship

function Pickupship(ply)
	local trace = ply:GetEyeTrace()
	if trace.Entity:GetClass() == "ship" and trace.Entity:GetNWString("entowner") == ply then
		trace.Entity:Remove()
		ply:GiveItem( "ship", 1 )
		ply:PrintMessage( HUD_PRINTTALK, "You picked up your ship." )
	end
end
concommand.Add("mrp_pickupship", Pickupship)

function Entership(ply)
	local trace = ply:GetEyeTrace()
	if trace.Entity:GetClass() == "ship" and trace.Entity:GetNWString("entowner") == ply then
		trace.Entity:GetPhysicsObject():Wake()
		trace.Entity:GetPhysicsObject():EnableMotion(true)
		trace.Entity.Inflight = true
		trace.Entity.Pilot = ply
		trace.Entity.PilotOffset = trace.Entity:GetPos() - ply:GetPos()

		ply:Spectate( OBS_MODE_ROAMING )
		ply:DrawViewModel(false)
		ply:DrawWorldModel(false)
		ply:SetMoveType( MOVETYPE_NONE )
		ply:SetNetworkedBool("isDriveShuttle", true)
		ply:SetNetworkedEntity("Shuttle", trace.Entity)
	end
end
concommand.Add("mrp_entership", Entership)

function Comeaboardship(ply)
	local trace = ply:GetEyeTrace()
	if trace.Entity:GetClass() == "ship" and trace.Entity:GetNWString("entowner") then
		if trace.Entity.PilotOffset then
			local player = ply:GetNWString("comeaboard")
			player:SetPos(Vector(trace.Entity:GetPos() + Vector(0, 50, 50)))
		end
	end
end
concommand.Add("mrp_comeaboardship", Comeaboardship)

function Pickupcannon(ply)
	local trace = ply:GetEyeTrace()
	if trace.Entity:GetClass() == "ship_cannon" and trace.Entity:GetNWString("entowner") == ply then
		trace.Entity:Remove()
		ply:GiveItem( "ship_cannon", 1 )
		ply:PrintMessage( HUD_PRINTTALK, "You picked up your cannon." )
	end
end
concommand.Add("mrp_pickupcannon", Pickupcannon) 