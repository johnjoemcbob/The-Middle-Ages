function SetPositions( ply )
	ply:SetNWString("name", ply:GetName())
	ply:SetNWString("sex", "Male")

	if ply:SteamID() == "STEAM_0:1:18098051" then -- Matthew.
		ply:SetNWInt("dwarfleader", 1) -- Registers them as Dwarven Leader.
		ply:SetNWInt("leader", 1) -- Registers them as a Leader.
		ply:SetNWString("race", "Dwarf") -- Sets their race to "Dwarf".
		ply:SetTeam( 4 ) -- Sets the player's team to "King".
		ply:SetNWString("job", "King of the Dwarves") -- Sets their Job to "King of the Dwarves".
		ply:SetNWString("name", "William Thorian") -- Sets their Name to "William Thorian".

	elseif ply:SteamID() == "STEAM_0:1:16643003" then -- Spring
		ply:SetNWInt("dwarfsecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Dwarf")
		ply:SetTeam( 3 ) -- Sets the player's team to "Knight"
		ply:SetNWString("job", "Commander of the Dwarven Army")
		ply:SetNWString("name", "Sir Villelm Ironfist")

	elseif ply:SteamID() == "STEAM_0:1:20417219" then -- Numroth
		ply:SetNWInt("gnomeleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Gnome")
		ply:SetTeam( 4 ) -- Sets the player's team to "King"
		ply:SetNWString("job", "High Tinkerer of the Gnomes")
		ply:SetNWString("name", "John Drogan")

	elseif ply:SteamID() == "STEAM_0:0:22051244" then -- Nomz
		ply:SetNWInt("gnomesecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Gnome")
		ply:SetTeam( 3 ) -- Sets the player's team to "Knight"
		ply:SetNWString("job", "Commander of the Gnomish Army")

	elseif ply:SteamID() == "STEAM_0:1:19840900" then -- Winter
		ply:SetNWInt("animalleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Animal")
		ply:SetNWString("sex", "Female")
		ply:SetTeam( 16 ) -- Sets the player's team to "Wolf"
		ply:SetNWString("job", "Female Wolf Alpha")

	elseif ply:SteamID() == "STEAM_0:1:13855197" then -- Poodlz
		ply:SetNWInt("animalsecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Animal")
		ply:SetTeam( 16 ) -- Sets the player's team to "Wolf"
		ply:SetNWString("job", "Male Wolf Alpha")

	elseif ply:SteamID() == "" then
		ply:SetNWInt("ogreleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Ogre")
		ply:SetTeam( 4 ) -- Sets the player's team to "King"
		ply:SetNWString("job", "Chieftain of the Ogres")

	elseif ply:SteamID() == "STEAM_0:1:16775071" then -- Dale
		ply:SetNWInt("ogresecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Ogre")
		ply:SetTeam( 3 ) -- Sets the player's team to "Knight"
		ply:SetNWString("job", "Commander of the Ogre Army")

	elseif ply:SteamID() == "STEAM_0:1:22008277" then -- Dehno
		ply:SetNWInt("goblinleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Goblin")
		ply:SetTeam( 4 ) -- Sets the player's team to "King"
		ply:SetNWString("job", "Shaman of the Goblins")

	elseif ply:SteamID() == "STEAM_0:0:14626014" then -- Atomic
		ply:SetNWInt("goblinsecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Goblin")
		ply:SetTeam( 3 ) -- Sets the player's team to "Knight"
		ply:SetNWString("job", "Commander of the Goblin Army")

	elseif ply:SteamID() == "STEAM_0:0:9842813" then -- Blackmack
		ply:SetNWInt("humanleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Human")
		ply:SetTeam( 4 ) -- Sets the player's team to "King"
		ply:SetNWString("job", "King of the Human Empire")
		ply:SetNWString("name", "Emperor Kailroth II")

	elseif ply:SteamID() == "STEAM_0:0:19688240" then -- Marcus
		ply:SetNWInt("humansecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Human")
		ply:SetTeam( 3 ) -- Sets the player's team to "Knight"
		ply:SetNWString("job", "Quartermaster of the Human Empire")
		ply:SetNWString("name", "Quartermaster May")

	--elseif ply:SteamID() == "STEAM_0:0:19666226" then -- Someone
	--	ply:SetNWInt("nightelfleader", 1)
	--	ply:SetNWInt("leader", 1)
	--	ply:SetNWString("race", "Night Elf")
	--	ply:SetTeam( 4 ) -- Sets the player's team to "King"
	--	ply:SetNWString("job", "High Priest of the Night Elves")
	--	ply:SetNWString("name", "Exodar Greenleaf")

	elseif ply:SteamID() == "STEAM_0:0:4468082" then -- Barlow
		ply:SetNWInt("nightelfleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Night Elf")
		ply:SetTeam( 4 ) -- Sets the player's team to "King"
		ply:SetNWString("job", "High Priest of the Night Elves")
		ply:SetNWString("name", "Arthios Nightstalker")

	elseif ply:SteamID() == "STEAM_0:0:20687901" then -- Custard
		ply:SetNWInt("nightelfsecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Night Elf")
		ply:SetTeam( 3 ) -- Sets the player's team to "Knight"
		ply:SetNWString("job", "Commander of the Night Elven Armies")
		ply:SetNWString("name", "Silvanoshei Starbreeze")

	elseif ply:SteamID() == "STEAM_0:1:18460035" then -- Stevo
		ply:SetNWInt("bloodelfleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Blood Elf")
		ply:SetTeam( 4 ) -- Sets the player's team to "Queen"
		ply:SetNWString("job", "Archmage of the Blood Elves")
		ply:SetNWString("name", "Naminé")
		ply:SetNWString("sex", "Female")

	elseif ply:SteamID() == "STEAM_0:1:26716086" then -- Argas
		ply:SetNWInt("bloodelfsecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Blood Elf")
		ply:SetTeam( 3 ) -- Sets the player's team to "Knight"
		ply:SetNWString("job", "Ranger General of the Blood Elf Army")
		ply:SetNWString("name", "Argas Bloodmoon")

	--elseif ply:SteamID() == "STEAM_0:0:20687901" then -- Custard
	--	ply:SetNWInt("undeadleader", 1)
	--	ply:SetNWInt("leader", 1)
	--	ply:SetNWString("race", "Undead")
	--	ply:SetTeam( 3 ) -- Sets the player's team to "Knight"
	--	ply:SetNWString("name", "Rutheus DeathBringer")
	--	ply:SetNWString("job", "Leader of the Undead Rebellion")

	elseif ply:SteamID() == "STEAM_0:1:17805813" then -- Apple
		ply:SetNWInt("darkelfleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Dark Elf")
		ply:SetTeam( 13 ) -- Sets the player's team to "Craftsman"
		ply:SetNWString("job", "Leader of the Dark Elves")
		ply:SetNWString("name", "Avariss Belmont")

	elseif ply:SteamID() == "STEAM_0:1:17460563" then -- Unit 511
		ply:SetNWInt("darkelfsecond", 1)
		ply:SetNWInt("second", 1)
		ply:SetNWString("race", "Dark Elf")
		ply:SetNWString("sex", "Female")
		ply:SetTeam( 13 ) -- Sets the player's team to "Craftsman"
		ply:SetNWString("job", "Commander of the Dark Elven Armies")
		ply:SetNWString("name", "Gallievo Bloodrose")

	elseif ply:SteamID() == "STEAM_0:1:11030585" then -- Sprinklez
		ply:SetNWInt("trollleader", 1)
		ply:SetNWInt("leader", 1)
		ply:SetNWString("race", "Troll")
		ply:SetTeam( 4 ) -- Sets the player's team to "King"
		ply:SetNWString("job", "Leader of the Trolls")
		ply:SetNWString("name", "Zul'Jin")

	else
		ply:SetNWString("race", "Human")
		ply:SetTeam( 1 ) -- Sets the player's team to "Peasant"
		ply:SetNWString("job", "Peasant")
		if DataRetrieveName( ply ) and not DataRetrieveName( ply ) == "" then
			ply:SetNWString("name", DataRetrieveName( ply ))
		end
	end
end
hook.Add( "PlayerInitialSpawn", "Positions", SetPositions ) 