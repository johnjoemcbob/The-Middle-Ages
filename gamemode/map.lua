function SpawnItems()
	if firstplayer == 1 then else
		-- Removal
		local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
		for k,v in pairs(foundents) do
			if v:GetClass() == "weapon_crossbow" or v:GetClass() == "weapon_crowbar" or v:GetClass() == "item_ammo_crossbow" or v:GetClass() == "item_item_crate" then
				v:Remove()
			elseif v:GetClass() == "prop_physics" and v:GetModel() == "models/props_junk/rock001a.mdl" then
				local rocktype = math.random(1,8)
				if rocktype == 1 or rocktype == 2 or rocktype == 3 then
					local ent = ents.Create("resource_tin")
					ent:SetPos(v:GetPos())
					ent:Spawn()
				elseif rocktype == 4 or rocktype == 5 or rocktype == 6 then
					local ent = ents.Create("resource_copper")
					ent:SetPos(v:GetPos())
					ent:Spawn()
				elseif rocktype == 7 or rocktype == 8 or rocktype == 9 then
					local ent = ents.Create("resource_iron")
					ent:SetPos(v:GetPos())
					ent:Spawn()
				elseif rocktype == 10 then
					local ent = ents.Create("resource_sapphire_uncut")
					ent:SetPos(v:GetPos())
					ent:Spawn()
				elseif rocktype == 11 then
					local ent = ents.Create("resource_emerald_uncut")
					ent:SetPos(v:GetPos())
					ent:Spawn()
				end
				v:Remove()
			end
		end
		firstplayer = 1
	end

	if firstplayerx == 1 then
		SpawnNpcs()
	end
end
hook.Add("Think","SpawnItemsOnMap",SpawnItems)

function SpawnNpcs()
	if game.GetMap() == "gm_flatgrass2008_fix" then
		if not NextNPCRespawn or (NextNPCRespawn and NextNPCRespawn < CurTime()) then
			local foundents = ents.FindInSphere(Vector(0, 0, 0), 1000000000000)
			for k,v in pairs(foundents) do
				if v:GetClass() == "npc_breen" then
					v:Remove()
				elseif v:GetClass() == "npc_eli" then
					v:Remove()
				elseif v:GetClass() == "npc_barney" then
					v:Remove()
				elseif v:GetClass() == "npc_kleiner" then
					v:Remove()
				elseif v:GetClass() == "npc_monk" then
					v:Remove()
				elseif v:GetClass() == "npc_mossman" then
					v:Remove()
				elseif v:GetClass() == "npc_gman" then
					v:Remove()
				end
			end

			local ent = ents.Create("npc_breen")
			ent:SetPos(Vector(6298.517578125, 5471.6254882813, 82.648468017578))
			ent:SetAngles(Angle(0, 45, 0))
			ent:Spawn()
			ent:SetHealth( 999999999 )

			if not hiding == true then
				barney = ents.Create("npc_barney")
				barney:SetPos(Vector(6065, 5726, 73))
				barney:SetAngles(Angle(0, 0, 0))
				barney:Spawn()
				barney:SetHealth( 999999999 )
			end

			local ent = ents.Create("npc_kleiner")
			ent:SetPos(Vector(4942.3251953125, 5252.5263671875, 72.363540649414))
			ent:SetAngles(Angle(0, 332.68005371094, 0))
			ent:Spawn()
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_monk")
			ent:SetPos(Vector(5341.6518554688, 6968.0014648438, 82.484954833984))
			ent:SetAngles(Angle(0, 152.94998168945, 0))
			ent:Spawn()
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_mossman")
			ent:SetPos(Vector(7910.11328125, 2954.052734375, 70.249389648438))
			ent:SetAngles(Angle(0, 135, 0))
			ent:Spawn()
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_gman")
			ent:SetPos(Vector(7101.8901367188, 2720.2492675781, 72.688453674316))
			ent:SetAngles(Angle(0, 88.994750976563, 0))
			ent:Spawn()
			ent:SetModel("models/Humans/Group03/male_07.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_gman")
			ent:SetPos(Vector(5657.6640625, -278.62414550781, 69.969131469727))
			ent:SetAngles(Angle(0, 88.994750976563, 0))
			ent:Spawn()
			ent:SetModel("models/humans/group03/male_06.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_gman")
			ent:SetPos(Vector(4407.8359375, 3873.8376464844, 553.35369873047))
			ent:SetAngles(Angle(0, -90, 0))
			ent:Spawn()
			ent:SetModel("models/odessa.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_gman")
			ent:SetPos(Vector(8560.5419921875, 10904.985351563, 98.062873840332))
			ent:SetAngles(Angle(0, 248.65969848633, 0))
			ent:Spawn()
			ent:SetModel("models/Humans/Group03/male_09.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_mossman")
			ent:SetPos(Vector(4513.9921875, 4401.9423828125, 67.729156494141))
			ent:SetAngles(Angle(0, 359, 0))
			ent:Spawn()
			ent:SetModel("models/Humans/Group03/male_07.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_breen")
			ent:SetPos(Vector(-4344.0864257813, 6330.3623046875, 173.4015045166))
			ent:SetAngles(Angle(0, 272, 0))
			ent:Spawn()
			ent:SetModel("models/Humans/Group03/male_07.mdl")
			ent:SetHealth( 999999999 )

	-- Evil NPCs

			local ent = ents.Create("npc_gman")
			ent:SetPos(Vector(-1423.8109130859, -3884.8576660156, 70.643127441406))
			ent:SetAngles(Angle(0, 135, 0))
			ent:Spawn()
			ent:SetModel("models/undead/undead.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_mossman")
			ent:SetPos(Vector(-6299.7861328125, -2166.8334960938, 77.13451385498))
			ent:SetAngles(Angle(0, 24, 0))
			ent:Spawn()
			ent:SetModel("models/undead/undead.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_gman")
			ent:SetPos(Vector(-6364.9912109375, -2338.3959960938, 77.073554992676))
			ent:SetAngles(Angle(0, 262, 0))
			ent:Spawn()
			ent:SetModel("models/goblin/goblin.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_breen")
			ent:SetPos(Vector(-7345.1713867188, -2538.3996582031, 76.03475189209))
			ent:SetAngles(Angle(0, -90, 0))
			ent:Spawn()
			ent:SetModel("models/hellknight/hellknight.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_monk")
			ent:SetPos(Vector(-7385.0834960938, -4965.6064453125, 80.482681274414))
			ent:SetAngles(Angle(0, 304, 0))
			ent:Spawn()
			ent:SetModel("models/goblin/goblin.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_mossman")
			ent:SetPos(Vector(-7039.7587890625, -2358.8820800781, 75.992500305176))
			ent:SetAngles(Angle(0, 84, 0))
			ent:Spawn()
			ent:SetModel("models/goblin/goblin.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_gman")
			ent:SetPos(Vector(-4759.2329101563, -3374.310546875, 80.796546936035))
			ent:SetAngles(Angle(0, 112, 0))
			ent:Spawn()
			ent:SetModel("models/krall/slow.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_eli")
			ent:SetPos(Vector(-6972.0883789063, -5057.5708007813, 83.558349609375))
			ent:SetAngles(Angle(0, 127, 0))
			ent:Spawn()
			ent:SetModel("models/krall/slow.mdl")
			ent:SetHealth( 999999999 )

			local ent = ents.Create("npc_kleiner")
			ent:SetPos(Vector(-6083.3891601563, -274.54202270508, 83.440254211426))
			ent:SetAngles(Angle(0, 190, 0))
			ent:Spawn()
			ent:SetModel("models/krall/slow.mdl")
			ent:SetHealth( 999999999 )

			NextNPCRespawn = CurTime() + 30
		end

		if spawnzombies == 1 then
			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(5653.6289, 6619.0698, 64.0312))
			ent:SetAngles(Angle(0.000, 229.779, 0.000))
			ent:Spawn()
			ent:SetHealth( 40 )

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(5589.4096, 6670.1381, 64.0312))
			ent:SetAngles(Angle(0.000, 344.185, 0.000))
			ent:Spawn()
			ent:SetHealth( 40 )

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(5520.3735, 6456.9624, 64.0312))
			ent:SetAngles(Angle(0.000, 56.118, 0.000))
			ent:Spawn()
			ent:SetHealth( 40 )

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(5443.2016, 6506.3984, 64.0312))
			ent:SetAngles(Angle(0.000, 52.377, 0.000))
			ent:Spawn()
			ent:SetHealth( 40 )
			spawnzombies = 0
		end

		zombies = nil
		local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
		for k,v in pairs(foundents) do
			if v:GetClass() == "npc_zombie" and v.MapZombie == true then
				zombies = true
			end
		end

		if zombies == true then else
			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(-5317.35546875, 5342.76171875, 64.09375))
			ent:Spawn()
			ent.MapZombie = true

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(-5258.3598632813, 5259.2485351563, 64.09375))
			ent:Spawn()
			ent.MapZombie = true

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(-5073.4584960938, 5295.6982421875, 64.09375))
			ent:Spawn()
			ent.MapZombie = true

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(-5177.626953125, 6209.2514648438, 64.09375))
			ent:Spawn()
			ent.MapZombie = true

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(-4338.8193359375, 6626.5297851563, 64.09375))
			ent:Spawn()
			ent.MapZombie = true

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(-4499.34765625, 5772.7465820313, 64.09375))
			ent:Spawn()
			ent.MapZombie = true

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(-5485.6845703125, 6220.8315429688, 64.09375))
			ent:Spawn()
			ent.MapZombie = true

			local ent = ents.Create("npc_zombie")
			ent:SetPos(Vector(-5382.6240234375, 5265.2080078125, 64.09375))
			ent:Spawn()
			ent.MapZombie = true
		end

		cannonzombiesremaining = false
		local foundents = ents.FindInSphere(Vector(0, 0, 0),1000000000)
		for k,v in pairs(foundents) do
			if v:GetClass() == "npc_zombie4" then
				cannonzombiesremaining = true
			end
		end

		if cannonzombiesremaining == false and cannon then
			SetGlobalInt("cannonquestdone", 1)
			GetGlobalString("cannonquestplayer"):SetNWInt("completedcannonquest", 1)
			cannon:Remove()
			cannon = nil
		end

		if spawncannonquest == true then
			cannon = ents.Create("ship_cannon")
			cannon:SetPos(Vector(-3632.1975097656, 6477.3466796875, 64.579460144043))
			cannon:SetAngles(Angle(-0.016301352530718, -141.25434875488, -1.4195251464844))
			cannon:Spawn()
			
			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4155.44140625, 7140.3388671875, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4213.03125, 7162.103515625, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4230.380859375, 7222.2924804688, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4168.208984375, 7198.5341796875, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4170.0288085938, 7261.791015625, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4236.2661132813, 7297.5620117188, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4277.59765625, 7193.3500976563, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4291.603515625, 7253.689453125, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4345.2338867188, 7208.5141601563, 64.03125))
			ent:Spawn()

			local ent = ents.Create("npc_zombie4")
			ent:SetPos(Vector(-4184.6313476563, 7338.5131835938, 64.03125))
			ent:Spawn()
			spawncannonquest = false
		end

		if spawnundeadarmy == true then
			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4400.9965820313, 3282.7595214844, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4433.1469726563, 3311.1486816406, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4370.904296875, 3305.6889648438, 64.031372070313))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4408.3623046875, 3341.6704101563, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4336.0014648438, 3342.7805175781, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4370.150390625, 3373.6166992188, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4297.9135742188, 3383.080078125, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4328.2177734375, 3415.2446289063, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4286.28515625, 3456.8725585938, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4253.1333007813, 3423.8051757813, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4215.9130859375, 3461.8125, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4249.908203125, 3493.6618652344, 66.854248046875))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4217.1684570313, 3528.2573242188, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()

			local ent = ents.Create("npc_zombie3")
			ent:SetPos(Vector(4179.5927734375, 3496.2927246094, 64.03125))
			ent:SetAngles(Angle(-0, 45, 0))
			ent:Spawn()
			spawnundeadarmy = false
		end
	end
end

function SpawnMapItems()
	if game.GetMap() == "gm_flatgrass2008_fix" then
		if firstplayerx == 1 then else
			-- Docks
				AddMapItem( "models/props_docks/dock_broken01a_256.mdl", 6901.747, 6469.851, -54.057, 0.000, 45.000, 0.000, "0", 1 )
			-- Inn
				AddMapItem( "models/inn.mdl", 6378.1376953125, 5593.6669921875, 31.866607666016, 6.1323288027409e-014, 45, 5.9514448366826e-005, "0", 0 )
				AddMapItem( "models/props/CS_militia/bar01.mdl", 6080.9926757813, 5722.53125, 69.025184631348, -0.01668032258749, -45.005493164063, -0.022918701171875, "0", 0 )

				-- Soundbox
					local ent = ents.Create("soundbox")
					ent:SetPos(Vector(6343.23828125, 5604.75, 64.476791381836))
					ent:Spawn()
					ent:GetPhysicsObject():EnableMotion(false)
			-- Restuarant
				AddMapItem( "models/props/cs_militia/bar01.mdl", 7906.6845703125, 2945.1630859375, 67.287101745605, 0.0050075156614184, 65.057373046875, -0.01397705078125, "0", 0 )
			-- Church
				AddMapItem( "models/church.mdl", 5102.6713867188, 7100.7353515625, 52.4534034729, -2.3184209112515e-006, -26.758201599121, 0.011087798513472, "0", 0 )
				-- Ladder
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4813.61328125, 7072.3862304688, 75.682991027832, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4813.1665039063, 7071.4916992188, 91.120071411133, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4812.7192382813, 7070.5966796875, 106.55726623535, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4812.2724609375, 7069.7026367188, 121.99436950684, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4811.8251953125, 7068.8081054688, 137.43157958984, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4811.3784179688, 7067.9135742188, 152.86866760254, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4810.931640625, 7067.0190429688, 168.30577087402, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4810.484375, 7066.1245117188, 183.74327087402, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4810.037109375, 7065.2294921875, 199.18026733398, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4809.1435546875, 7063.4409179688, 230.0542755127, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4809.5908203125, 7064.3354492188, 214.61726379395, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4808.6962890625, 7062.5463867188, 245.49127197266, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4808.2495117188, 7061.6518554688, 260.92825317383, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", 4807.8022460938, 7060.7568359375, 276.36526489258, 0.0048298314213753, -116.56083679199, 179.96200561523, "0", 0 )
				-- Doors
					AddMapDoor( 5017.478515625, 6730.9770507813, 274.97024536133, 0.16048736870289, -26.645645141602, 29.889699935913, 255, 5189.7641601563, 6843.7197265625, 500.45202636719 )
					AddMapDoor( 5129.2348632813, 6768.96484375, 490.45935058594, -1.9183098629583e-006, 61.060985565186, 7.9168075899361e-006, 255, 5060.6333007813, 6745.7309570313, 284.42971801758 )
				-- Scare
					AddMapItem( "models/props_c17/gravestone_coffinpiece001a.mdl", 5761.4838867188, 6673.77734375, 74.105751037598, 0.000, -131.431, 0.000, "0", 1 )

				local ent = ents.Create("scarebox")
				ent:SetPos(Vector(5748.912109375, 6669.7177734375, 64.440719604492))
				ent:Spawn()
				ent:GetPhysicsObject():EnableMotion(false)
			-- Smithy
					AddMapItem( "models/smithy.mdl", 5076.8608398438, 5055.9658203125, 78.333267211914, -0.00046876288251951, 9.3316528364085e-005, 1.3100659089105e-005, "0", 0 )
				-- Soundbox
					local ent = ents.Create("soundbox")
					ent:SetPos(Vector(5079.3540039063, 5051.2412109375, 64.499801635742))
					ent:Spawn()
					ent:GetPhysicsObject():EnableMotion(false)
					ent.Sound = "ambient/Blacksmith.wav"
					ent.SoundLength = 4.277980
			-- Houses
					AddMapItem( "models/inn.mdl", 7914.9306640625, 3271.5283203125, 25.782768249512, -5.7825218391372e-008, 155.23992919922, 0.00012176154268673, "0", 0 )
					AddMapItem( "models/house1.mdl", 7755.1791992188, 4058.1284179688, 197.96325683594, -0.0049460893496871, -169.46801757813, 0.00049766490701586, "0", 0 )
					AddMapItem( "models/house1.mdl", 4408.0024414063, 7534.1655273438, 195.96325683594, -0.0049460888840258, 169.6316986084, 0.00049556384328753, "0", 0 )
					AddMapItem( "models/house2.mdl", 3623.8598632813, 5385.3549804688, 28.401412963867, -0.0022339087445289, 111.57985687256, 0.00069561856798828, "0", 0 )
					AddMapItem( "models/house2.mdl", 3474.0856933594, 5905.8784179688, 28.401412963867, -0.0022339087445289, 97.279838562012, 0.00069561856798828, "0", 0 )
					AddMapItem( "models/house2.mdl", 3494.3708496094, 6490.3515625, 28.401412963867, -0.0022339087445289, 82.319747924805, 0.00069561850978062, "0", 0 )
					AddMapItem( "models/house2.mdl", 3581.7255859375, 6926.296875, 28.401412963867, -0.0022339085116982, 75.059707641602, 0.00069561856798828, "0", 0 )
					AddMapItem( "models/house2.mdl", 4408.7543945313, 7038.337890625, 28.401412963867, -0.0022339087445289, -86.640434265137, 0.00069561845157295, "0", 0 )
					AddMapItem( "models/house2.mdl", 4290.8935546875, 6133.6206054688, 28.401412963867, -0.0022339087445289, -135.04022216797, 0.00069561845157295, "0", 0 )
					AddMapItem( "models/house2.mdl", 4829.3120117188, 5696.1909179688, 28.401412963867, -0.0022339087445289, 45.219623565674, 0.00069561850978062, "0", 0 )
					AddMapItem( "models/house2.mdl", 4345.27734375, 5646.556640625, 28.401412963867, -0.0022339087445289, -44.180202484131, 0.00069561850978062, "0", 0 )
					AddMapItem( "models/house2.mdl", 4783.56640625, 6184.5190429688, 28.401412963867, -0.0022339087445289, 134.75970458984, 0.00069561850978062, "0", 0 )
					AddMapItem( "models/house2.mdl", 5373.173828125, 3422.9846191406, 28.401412963867, -0.0022339087445289, -166.58020019531, 0.00069771957350895, "0", 0 )
					AddMapItem( "models/house2.mdl", 7608.7827148438, 4575.552734375, 28.401412963867, -0.0022339087445289, -56.800289154053, 0.00069771963171661, "0", 0 )
					AddMapItem( "models/house2.mdl", 7141.2553710938, 2892.2353515625, 28.401412963867, -0.0022339087445289, -161.52035522461, 0.00069771963171661, "0", 0 )
					AddMapItem( "models/house2.mdl", 5799.7426757813, 3385.6506347656, 28.401412963867, -0.0022339087445289, 150.95976257324, 0.00069771957350895, "0", 0 )
					AddMapItem( "models/house2.mdl", 5373.173828125, 3422.9846191406, 28.401412963867, -0.0022339087445289, -166.58020019531, 0.00069771957350895, "0", 0 )
					AddMapItem( "models/house3.mdl", 4214.8002929688, 4408.9624023438, 34.318313598633, -3.02340640701e-006, -51.900421142578, 0, "0", 0 )
					AddMapItem( "models/house3.mdl", 6529.0366210938, 3000.1696777344, 34.318313598633, -3.02340640701e-006, -15.490403175354, 0, "0", 0 )
				-- Doors
					AddMapDoor( 6372.595703125, 3051.4636230469, 176.32934570313, 8.8679561471849e-009, -105.01435852051, 7.9168075899361e-006, 255, 6295.359375, 3139.0534667969, 178.34954833984 )
					AddMapDoor( 6404.1401367188, 3175.5947265625, 170.45945739746, 0.62024468183517, 73.543975830078, -0.089996337890625, 255, 6443.0200195313, 3089.5134277344, 178.34954833984 )
					AddMapDoor( 4207.8466796875, 4615.5151367188, 173.12985229492, 0.0040669199079275, 37.767730712891, -0.00030517578125, 255, 4214.1708984375, 4487.8544921875, 178.34954833984 )
					AddMapDoor( 4215.3676757813, 4606.236328125, 175.50065612793, -0.0031372085213661, 38.787979125977, 0.28108936548233, 255, 4118.4028320313, 4608.4916992188, 178.34954833984 )
					AddMapDoor( 4637.4296875, 5751.9794921875, 55.887664794922, -0.0022548516280949, -135.48040771484, 0.00020343151118141, 255, 4644.126953125, 5829.9165039063, 64.03125 )
					AddMapDoor( 4628.4677734375, 5759.4951171875, 55.887664794922, -2.4870757897588e-007, -134.67063903809, -2.0447696442716e-006, 255, 4710.3583984375, 5764.517578125, 69.433624267578 )
				-- Decorations
					AddMapItem( "models/props/de_inferno/fountain_bowl.mdl", 4562.1201171875, 5765.98046875, 8.9999914169312, -0.00018029408238363, 82.080017089844, -0.000244140625, "0", 0 )
					AddMapItem( "models/props/de_inferno/fountain_bowl.mdl", 4711.6005859375, 5916.0185546875, 11.700234413147, -3.9764255777008e-010, 179.99934387207, -3.0517578125e-005, "0", 0 )
					AddMapItem( "models/props/de_inferno/fountain.mdl", 4562.7387695313, 5919.720703125, 65.074447631836, 0.0025299331173301, 133.75776672363, -0.002532958984375, "0", 0 )
					AddMapItem( "models/props_foliage/tree_poplar_01.mdl", 4579.474609375, 5912.3959960938, 65.909469604492, -0.52293181419373, -41.527824401855, -0.64422607421875, "0", 0 )
					AddMapItem( "models/props/de_inferno/fountain_bowl.mdl", 4405.7880859375, 5915.1064453125, 11.688893318176, -0.00017991736240219, 3.9871964454651, -0.000244140625, "0", 0 )
					AddMapItem( "models/props/de_inferno/fountain_bowl.mdl", 4562.53515625, 6061.9594726563, 18.69771194458, -6.3749253058631e-006, -89.850944519043, 1.3870201655664e-005, "0", 0 )
			-- Centre
					AddMapItem( "models/centre.mdl", 5978.1318359375, 4713.2119140625, 11.94180393219, 2.2971277657824e-011, 135, -9.5065888672252e-007, "0", 0 )
					AddMapItem( "models/props_c17/statue_horse.mdl", 6318.6826171875, 4584.4711914063, 123.32504272461, 0.016359196975827, 91.49299621582, -0.055999755859375, "0", 1 )
					AddMapItem( "models/props_c17/statue_horse.mdl", 6171.0068359375, 4705.33203125, 123.32504272461, 0.016362903639674, -1.127002120018, -0.055999755859375, "0", 1 )
					AddMapItem( "models/props_c17/fountain_01.mdl", 6300.7680664063, 4718.0590820313, 123.32504272461, 4.4683198211715e-005, -88.302001953125, 3.9197795558721e-005, "0", 1 )
					AddMapItem( "models/props_c17/statue_horse.mdl", 6430.4184570313, 4731.4243164063, 123.32504272461, 0.016447404399514, -178.30700683594, -0.055999755859375, "0", 1 )
					AddMapItem( "models/props_c17/statue_horse.mdl", 6279.8657226563, 4844.0668945313, 123.32504272461, 0.016446102410555, -84.946899414063, -0.055999755859375, "0", 1 )
			-- Walls
					AddMapItem( "models/castlegate.mdl", 4541.9233398438, 3599.9982910156, 64.396408081055, 0.0098533798009157, 45.001300811768, 0.00039401679532602, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 5383.8720703125, 2947.7900390625, 64.347801208496, 0.004287039861083, 58.545303344727, -0.00799560546875, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 6357.919921875, 2531.4799804688, 64.347801208496, 0.004287039861083, 74.275199890137, -0.00799560546875, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 7407.3901367188, 2407, 64.347801208496, 0.004287039861083, 91.215202331543, -0.00799560546875, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 8375.67578125, 2425.1931152344, 64.28125, 0.0042870393954217, 90.99520111084, -0.00799560546875, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 3830.4291992188, 4407.7290039063, 64.318267822266, 0.0015106300124899, 37.317699432373, 5.8157052080787e-006, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 3312.3002929688, 5328.8999023438, 64.347801208496, 0.004287039861083, 20.375200271606, -0.00799560546875, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 3178.8801269531, 6345.9501953125, 64.347801208496, 0.004287039861083, -7.1248002052307, -0.00799560546875, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 3435.658203125, 7377.8603515625, 64.347801208496, 0.004287039861083, -21.64469909668, -0.00799560546875, "0", 0 )
					AddMapItem( "models/castlewall1.mdl", 3627.3830566406, 7859.1298828125, 64.347801208496, 0.004287039861083, -21.754697799683, -0.00799560546875, "0", 0 )
					OpenGates()
				-- Doors
					AddMapDoor( 4925.9741210938, 3296.30078125, 64.385559082031, -2.8915700944765e-009, -45, 1.2591385711858e-008, 255, 4661.7778320313, 3548.4836425781, 547.42791748047 )
					AddMapDoor( 4660.6826171875, 3656.0798339844, 546.26129150391, 6.603587676679e-010, 135.00119018555, 0, 255, 4922.2055664063, 3373.5905761719, 64.03125 )
				-- Fountains
					AddMapItem( "models/fountain.mdl", 4160.189453125, 3676.1135253906, 64.384437561035, 0.0013501466019079, 22.3346118927, -0.008636474609375, "0", 0 )
					AddMapItem( "models/fountain.mdl", 4570.8930664063, 3271.9826660156, 64.476081848145, -0.017237134277821, -152.99311828613, 0.0056858141906559, "0", 0 )
				-- Swords
					AddMapItem( "models/sword.mdl", 4539.9521484375, 3923.5197753906, -5.720645904541, -16.809209823608, -178.3643951416, 5.8359861373901, "0", 0 )
					AddMapItem( "models/sword.mdl", 4812.9223632813, 3667.904296875, -6.5595135688782, -15.112943649292, -89.332221984863, -3.5070495605469, "0", 0 )

				-- Mine
					AddMapTree( "models/props_foliage/tree_pine04.mdl", 5106.6958007813, 442.47821044922, 65.318359375, -2.181628588005e-005, 135.00001525879, -3.0517578125e-005, "0", 0 )
					AddMapTree( "models/props_foliage/tree_pine06.mdl", 4898.6650390625, -129.98954772949, 65.487976074219, 0.25792130827904, 117.14400482178, -0.17794799804688, "0", 0 )
					AddMapTree( "models/props_foliage/tree_pine_large.mdl", 5525.4111328125, 60.329345703125, 65.709396362305, 1.3169386875234e-005, 90.000007629395, 3.9487014873885e-005, "0", 0 )
					AddMapTree( "models/props_foliage/tree_pine05.mdl", 5902.7827148438, -100.28729248047, 65.593902587891, 0.060749795287848, -177.45942687988, 0.074984937906265, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster02c.mdl", 5383.2133789063, 100.2834777832, 168.50756835938, -3.94669008255, -167.83337402344, 22.540538787842, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster02a.mdl", 5049.6650390625, -471.96231079102, 324.89636230469, 0.018536284565926, 120.75226593018, -0.01727294921875, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster01a.mdl", 4706.0092773438, -907.12487792969, 314.03146362305, 0.20816434919834, 75.74324798584, 0.47012346982956, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster01b.mdl", 4684.9125976563, -1529.3435058594, 316.38461303711, 0.62976455688477, 119.44417572021, 0.14297512173653, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster02b.mdl", 5002.0561523438, -1879.1196289063, 323.23739624023, -0.0029795833397657, -106.94386291504, -0.042022705078125, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster01b.mdl", 5504.23828125, -1787.7073974609, 289.41314697266, -0.40478852391243, -140.61846923828, 4.3730282783508, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff05a.mdl", 5837.0258789063, -1579.2867431641, 307.63491821289, 3.0747270584106, -42.925689697266, -1.6593017578125, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff05f.mdl", 5993.5673828125, -1293.400390625, 288.64361572266, -0.85793483257294, -10.226769447327, 0.33051052689552, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff05e.mdl", 5888.3217773438, -1396.0675048828, 302.47448730469, 1.4937748908997, 146.3304901123, -1.712890625, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster01a.mdl", 5991.4619140625, -743.46868896484, 325.50289916992, -6.6697180045594e-006, -78.943893432617, 5.815702934342e-006, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster02b.mdl", 5770.439453125, -421.35260009766, 304.50054931641, -0.011912093497813, -69.600929260254, -0.05029296875, "0", 0 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", 5506.427734375, -612.86383056641, 639.16784667969, 9.3189058303833, -7.5929341316223, 158.22103881836, "0", 0 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", 5675.826171875, -903.68817138672, 634.73443603516, -6.5538330078125, -168.94766235352, -174.05534362793, "0", 0 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", 5626.3647460938, -1379.6632080078, 459.88986206055, 15.953939437866, -36.871505737305, 4.5452494621277, "0", 0 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", 5113.447265625, -1629.6137695313, 536.15203857422, -17.534961700439, 108.09633636475, 167.29183959961, "0", 0 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", 5037.7290039063, -751.40014648438, 605.10162353516, -22.358224868774, -28.854753494263, 169.75639343262, "0", 0 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", 4867.5405273438, -1468.5137939453, 599.85980224609, 11.696996688843, -66.754440307617, -141.93193054199, "0", 0 )
					AddMapRock( "models/props_mining/stalactite_static04.mdl", 5269.2163085938, -1128.6719970703, 56.38452911377, -0.0075231683440506, 0.65113651752472, 179.99949645996, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff01b.mdl", 5352.658203125, -1189.5201416016, 144.21855163574, 12.584844589233, 143.67939758301, -4.8089294433594, "0", 0 )
					AddMapRock( "models/props_wasteland/rockgranite02c.mdl", 5322.1103515625, -1102.3472900391, 110.81842803955, 55.331031799316, -8.6821403503418, -14.009765625, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff01k.mdl", 5216.966796875, -1104.8433837891, 101.11958312988, 14.872002601624, -118.13822937012, 37.393280029297, "0", 0 )
					AddMapRock( "models/props_wasteland/rockgranite03b.mdl", 5256.7490234375, -1262.6474609375, 107.01443481445, 23.804840087891, -56.151145935059, 0.52039688825607, "0", 0 )
					AddMapRock( "models/props_mining/stalactite_static03.mdl", 5383.4956054688, -377.09857177734, 420.43325805664, -4.0888750163504e-007, 90.765937805176, 0.0001141850661952, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff01k.mdl", 5502.1762695313, -94.815277099609, 120.99537658691, -1.1733679771423, 76.410926818848, -0.4075927734375, "0", 0 )
					-- Soundbox
						local ent = ents.Create("soundbox")
						ent:SetPos(Vector(5285.0185546875, -1158.7786865234, 64.488700866699))
						ent:Spawn()
						ent:GetPhysicsObject():EnableMotion(false)
						ent.Sound = "ambient/Mine.wav"
						ent.SoundLength = 1.96840

				-- Ships
					AddMapItem( "models/ship.mdl", 7194.0014648438, 6425.6225585938, 96.939834594727, 0.31534308195114, 134.98135375977, -0.13937377929688, "0", 0 )
					AddMapItem( "models/ship.mdl", 8565.9150390625, 10695.833984375, 96.939819335938, 0.31534308195114, -151.09866333008, -0.13937377929688, "0", 0 )
				-- Tower
					AddMapItem( "models/tower1.mdl", 2405.0778808594, 6954.474609375, 130.36285400391, 6.6097018134315e-005, 144.22276306152, -0.000152587890625, "0", 0 )
					AddMapItem( "models/tower2.mdl", 1637.2253417969, 7191.8803710938, 959.12689208984, 9.3195056251716e-005, 144.22012329102, 4.5789897740178e-006, "0", 0 )
					AddMapItem( "models/tower3.mdl", 1638.5609130859, 7192.0034179688, 1736.7297363281, -1.0021444722952e-005, 144.20056152344, 4.9716795729182e-006, "0", 0 )
					AddMapItem( "models/tower4.mdl", 2406.3376464844, 6954.0546875, -278.39645385742, 1.1788773950083e-011, 144.29975891113, 7.9168075899361e-006, "0", 0 )
					AddMapItem( "models/tower5.mdl", 2406.8674316406, 6954.9033203125, 113.41617584229, 1.0713089304559e-009, 144.30139160156, 4.9704508455761e-006, "0", 0 )
					AddMapItem( "models/tower6.mdl", 1633.9967041016, 7194.3383789063, 3185.39453125, -4.1112837578794e-008, -80.161186218262, -5.5646955843258e-007, "0", 0 )
					-- Portals
						AddMapPortal( 2015.7994384766, 7648.1264648438, 210.44535827637, -2.2554564793609e-007, -133.78787231445, 3.7230083762552e-006, 0, 255, 0, 200, 1674.8598632813, 7159.02734375, 674.158203125 )
						AddMapPortal( 1849.6896972656, 6984.0478515625, 722.25067138672, 0.026983680203557, 135.0227355957, -0.003570556640625, 0, 255, 0, 200, 1690.29296875, 7093.8447265625, 1270.3747558594 )
						AddMapPortal( 1841.8365478516, 6988.1391601563, 1315.7077636719, 5.0110471327969e-009, 135.00898742676, -1.7029933587764e-006, 0, 255, 0, 200, 1736.6004638672, 7061.0673828125, 1797.1209716797 )
						AddMapPortal( 2005.4593505859, 7011.787109375, 1849.3795166016, -1.3305449328982e-006, 173.83955383301, 0, 0, 255, 0, 200, 1745.5893554688, 7273.4116210938, 2449.4475097656 )
						AddMapPortal( 1836.0994873047, 7419.3017578125, 2494.6530761719, -4.2689226376069e-008, -134.66215515137, 7.9175815699273e-006, 0, 255, 0, 200, 1744.5529785156, 7271.5556640625, 3154.4782714844 )
						AddMapPortal( 1761.0836181641, 7490.5703125, 2492.0485839844, 4.0838936676835e-009, -134.98205566406, -1.7009184603012e-006, 255, 0, 0, 200, 1897.2431640625, 7140.6533203125, 1795.634765625 )
						AddMapPortal( 2037.2888183594, 7058.3276367188, 1848.9672851563, -1.5600936098537e-009, 134.96890258789, -2.0326017420302e-006, 255, 0, 0, 200, 1737.2707519531, 7158.685546875, 1269.6009521484 )
						AddMapPortal( 1899.2557373047, 7071.1342773438, 1315.3406982422, -1.4638052903138e-007, 135.46846008301, 0, 255, 0, 0, 200, 1747.4295654297, 7140.044921875, 674.15832519531 )
						AddMapPortal( 1896.7591552734, 7065.7485351563, 722.59167480469, 1.1128488131007e-009, 135.00341796875, -1.9490066733852e-006, 255, 0, 0, 200, 1830.8620605469, 7482.6831054688, 130.39360046387 )
						AddMapPortal( 1621.3389892578, 7000.7841796875, 3213.1376953125, -9.5048420689636e-007, 84.959114074707, 0, 255, 0, 0, 200, 1648.7629394531, 7335.2534179688, 2449.4475097656 )
						AddMapPortal( 1586.9847412109, 7037.9858398438, 3214.4680175781, -5.0809848772815e-008, 45.691619873047, 0, 0, 255, 0, 200, 1502.0708007813, 7078.2041015625, 3377.42578125 )
						AddMapPortal( 1628.7694091797, 7190.0395507813, 3438.919921875, -3.6449333151722e-007, -126.67694854736, 5.815702934342e-006, 255, 0, 0, 200, 1628.0482177734, 7284.1245117188, 3153.42578125 )
					-- Doors
						-- First Floor
							AddMapDoor( 1577.8035888672, 6851.3745117188, 674.51678466797, 0.016466544941068, -13.628054618835, -0.007843017578125, 0, 1515.8671875, 6768.5288085938, 674.44842529297 )
							AddMapDoor( 1437.4017333984, 6842.8208007813, 674.54760742188, -0.01967334933579, 166.22180175781, 0.31852212548256, 0, 1533.8707275391, 6958.0151367188, 674.57916259766 )
							AddMapDoor( 1272.7541503906, 7183.7778320313, 675.10241699219, 0.010311715304852, -103.62175750732, 5.0802365876734e-005, 0, 1167.166015625, 7251.88671875, 674.677734375 )
							AddMapDoor( 1261.0980224609, 7309.83984375, 675.14099121094, -0.060293011367321, 76.387435913086, -0.009368896484375, 0, 1367.1760253906, 7203.890625, 674.70434570313 )
							AddMapDoor( 1693.6614990234, 7528.5297851563, 675.70037841797, -0.039355766028166, -14.127568244934, -0.22747802734375, 0, 1673.9508056641, 7674.4658203125, 675.13629150391 )
							AddMapDoor( 1716.3188476563, 7573.689453125, 675.53283691406, -0.0075842961668968, -14.170864105225, 0.033619020134211, 0, 1606.4202880859, 7491.201171875, 674.98492431641 )
							AddMapDoor( 1928.8492431641, 7375.5029296875, 675.37976074219, -0.023693790659308, 122.41326904297, -0.05706787109375, 0, 2056.1838378906, 7392.5131835938, 675.05926513672 )
							AddMapDoor( 2033.8833007813, 7286.4755859375, 675.38653564453, 0.034558720886707, -57.604682922363, 0.026744328439236, 0, 1897.2489013672, 7287.0629882813, 674.92669677734 )
						-- Second Floor
							AddMapDoor( 1932.2221679688, 7372.1186523438, 1269.9926757813, 0.035751543939114, 122.28739929199, -0.022186279296875, 0, 2112.783203125, 7362.1079101563, 1269.6009521484 )
							AddMapDoor( 1977.6024169922, 7391.5805664063, 1269.9191894531, -0.0085606630891562, 122.42880249023, -0.007598876953125, 0, 1919.6159667969, 7278.7729492188, 1269.6009521484 )
							AddMapDoor( 1581.2543945313, 7566.1430664063, 1269.9056396484, 0.073378451168537, 165.65325927734, 0.095446519553661, 0, 1702.4007568359, 7655.5795898438, 1269.6009521484 )
							AddMapDoor( 1710.8156738281, 7575.6752929688, 1270.0291748047, -0.0015574223361909, -14.165120124817, 0.0045494246296585, 0, 1628.3323974609, 7483.05078125, 1269.6009521484 )
							AddMapDoor( 1271.0749511719, 7173.7231445313, 1270.0411376953, 0.0046239397488534, -103.64334869385, 0.0032335422001779, 0, 1186.8531494141, 7280.2084960938, 1269.6010742188 )
							AddMapDoor( 1263.6040039063, 7316.7788085938, 1270.0023193359, 0.0032619026023895, 76.333862304688, -0.001800537109375, 0, 1365.1099853516, 7247.9243164063, 1269.6010742188 )
							AddMapDoor( 1465.4187011719, 6887.6362304688, 1270, -0.0020723175257444, 166.33088684082, -0.01995849609375, 0, 1482.7341308594, 6753.91015625, 1269.7817382813 )
							AddMapDoor( 1569.3214111328, 6803.7836914063, 1270.0843505859, -0.064320586621761, -13.630466461182, 0.022950222715735, 0, 1537.8198242188, 6960.2641601563, 1269.6009521484 )

			-- Evil Fort
					AddMapItem( "models/castlegate.mdl", -5226.111328125, -937.40057373047, 64.501434326172, 0.026613200083375, -151.20599365234, 5.8159707805316e-006, "0", 2 )
					AddMapItem( "models/castlegate.mdl", -5306.1362304688, -1054.4134521484, 64.425231933594, -0.028680702671409, 28.79400062561, 0.0001539858058095, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4713.2202148438, -1895.7719726563, 64.452651977539, -0.0087810000404716, -152.5590057373, 0.0010264789452776, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4796.8881835938, -2011.0799560547, 64.379905700684, -0.0047561503015459, 27.497297286987, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4445.615234375, -2983.8198242188, 64.379783630371, -0.0047561503015459, 13.397800445557, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4336.37890625, -2892.3701171875, 64.452529907227, -0.0087810000404716, -166.65899658203, 0.001026479061693, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4190.5517578125, -3952.6298828125, 64.452651977539, -0.0087810009717941, -178.29899597168, 0.0010264789452776, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4315.994140625, -4020.1599121094, 64.379905700684, -0.0047561503015459, 1.7573000192642, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4283.916015625, -5014, 64.452529907227, -0.0087810000404716, 167.6009979248, 0.0010264789452776, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4422.0288085938, -5048.9399414063, 64.379783630371, -0.0047561498358846, -12.342300415039, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4658.7958984375, -5999.7797851563, 64.452651977539, -0.0087810000404716, 149.58099365234, 0.0010285788448527, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -4800.9418945313, -5990.2797851563, 64.379905700684, -0.0047561498358846, -30.362800598145, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -5302.1948242188, -6849.0498046875, 64.452529907227, -0.0087810000404716, 135.48100280762, 0.0010285789612681, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -5437.744140625, -6805.2099609375, 64.379783630371, -0.0047561498358846, -44.462398529053, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -5915.3071289063, -234.34399414063, 64.379783630371, -0.0047561503015459, 45.298000335693, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -5870.8950195313, -98.97900390625, 64.452529907227, -0.0087810000404716, -134.75900268555, 0.0010264789452776, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -6717.4599609375, 547.96997070313, 64.452651977539, -0.0087810000404716, -120.65899658203, 0.001026479061693, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -6727.5600585938, 405.85998535156, 64.379905700684, -0.0047561498358846, 59.397499084473, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -7671.0498046875, 910.7900390625, 64.379783630371, -0.0047561498358846, 64.658302307129, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -7674.0200195313, 1053.2199707031, 64.452529907227, -0.0087810000404716, -115.39800262451, 0.0010264789452776, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -8687.189453125, 1382.9399414063, 64.452651977539, -0.0087810000404716, -101.29900360107, 0.0010264788288623, "0", 2 )
					AddMapItem( "models/castlewall1.mdl", -8649.6201171875, 1245.5200195313, 64.379905700684, -0.0047561503015459, 78.75789642334, -0.006988525390625, "0", 2 )
					AddMapItem( "models/castledoor.mdl", -5142.2758789063, -1007.6596679688, 62.281242370605, -0.3523542881012, -23.469530105591, 0.001349170692265, "0", 2 )
					AddMapItem( "models/castledoor.mdl", -5212.6000976563, -870.2568359375, 62.290500640869, -6.7609775555866e-009, -90, 0.00041312168468721, "0", 2 )
				-- Doors
					AddMapDoor( -5082.755859375, -1224.3673095703, 577.10736083984, 7.1883091079734e-016, 29.040050506592, 0, 255, -5144.0888671875, -1165.4331054688, 547.52410888672 )
					AddMapDoor( -5072.60546875, -1216.3399658203, 545.20855712891, 1.6625360643729e-008, 28.031339645386, 5.1318707846804e-005, 255, -5104.1284179688, -1309.0999755859, 576.50659179688 )
					AddMapDoor( -5260.28515625, -1142.1685791016, 545.22491455078, -1.2329419707413e-009, -61.050819396973, 0.00012519095616881, 255, -5251.4536132813, -1066.1182861328, 547.50646972656 )
					AddMapDoor( -5256.5087890625, -1138.6594238281, 545.98553466797, -1.7640186200651e-008, -60.523876190186, 3.2488369470229e-006, 255, -5336.6640625, -1113.7684326172, 547.44561767578 )
					AddMapDoor( -5206.744140625, -972.46350097656, 541.80084228516, 0.00048592311213724, 118.49688720703, 1.217706449097e-005, 255, -5128.1298828125, -978.5908203125, 547.57507324219 )
					AddMapDoor( -5147.4609375, -1085.943359375, 544.7451171875, 6.427964410749e-011, -61.191242218018, 0.00040350071503781, 255, -5224.1284179688, -1059.9123535156, 547.51623535156 )
					AddMapDoor( -5344.005859375, -720.66687011719, 574.76629638672, 0.00048097327817231, 28.719083786011, -0.015106201171875, 255, -5354.5161132813, -824.83288574219, 547.51208496094 )
					AddMapDoor( -5460.4770507813, -782.78497314453, 547.24609375, -3.9288053699238e-008, -151.21141052246, 0, -5442.8579101563, 255, -665.22924804688, 576.51318359375 )
					AddMapDoor( -5449.0180664063, -785.47790527344, 547.22113037109, -2.6457926960433e-009, 29.909704208374, 1.6134931684064e-006, 255, -5810.7890625, -629.82281494141, 64.03125 )
					AddMapDoor( -5680.8852539063, -557.74487304688, 64.405967712402, 0.0063399719074368, -43.991744995117, -0.22866821289063, 255, -5458.7724609375, -873.67755126953, 547.44293212891 )
					AddMapDoor( -5463.9892578125, -775.15606689453, 574.87152099609, 0.031909286975861, -151.46362304688, -0.007415771484375, 255, -5348.1391601563, -827.31390380859, 547.51721191406 )
				-- Houses
					AddMapItem( "models/house2.mdl", -6441.7602539063, -6039.396484375, 25.35570526123, 2.2418071239372e-006, 49.45703125, 0.00059094419702888, "0", 2 )
					AddMapItem( "models/house2.mdl", -5960.0483398438, -6587.3452148438, 25.355827331543, 2.241810761916e-006, -146.64295959473, 0.00059094425523654, "0", 2 )
					AddMapItem( "models/house2.mdl", -5584.0483398438, -6233.5859375, 25.355827331543, 2.2417984837375e-006, -127.50295257568, 0.00059094425523654, "0", 2 )
					AddMapItem( "models/house2.mdl", -6162.7001953125, -5544.9252929688, 25.35570526123, 2.241803031211e-006, 73.437141418457, 0.00059094419702888, "0", 2 )
					AddMapItem( "models/house2.mdl", -5456.572265625, -4275.1948242188, 31.882038116455, 9.3742579338141e-005, 52.554504394531, 0.00066450447775424, "0", 2 )
					AddMapItem( "models/house1.mdl", -5740.0678710938, -4005.4426269531, 199.75260925293, 0.0086283087730408, 52.874855041504, -0.004058837890625, "0", 2 )
					AddMapItem( "models/house2.mdl", -5458.6879882813, -3396.3889160156, 28.940120697021, -0.017629057168961, 55.317646026611, -0.00274658203125, "0", 2 )
					AddMapItem( "models/house3.mdl", -4817.9497070313, -3185.7687988281, 40.000797271729, 0.0011606639018282, 54.669326782227, -0.00079345703125, "0", 2 )
					AddMapItem( "models/house2.mdl", -4707.1547851563, -3719.4465332031, 26.509077072144, -0.45427846908569, -125.45352935791, -0.469482421875, "0", 2 )
					AddMapItem( "models/house1.mdl", -4645.7651367188, -4316.4423828125, 198.34043884277, -0.003313526045531, -90.73836517334, 0.012439941987395, "0", 2 )
					AddMapItem( "models/house1.mdl", -4875.7490234375, -4827.9936523438, 198.34043884277, -0.0033135258127004, -126.84027862549, 0.01243784185499, "0", 2 )
					AddMapItem( "models/house2.mdl", -7216.9916992188, -2622.9736328125, 24.401412963867, -0.0022339096758515, -65.009338378906, 0.00069771986454725, "0", 2 )
					AddMapItem( "models/house3.mdl", -5112.0551757813, -5497.923828125, 37.950397491455, 0.0010714634554461, 69.789810180664, -0.001556396484375, "0", 2 )
					AddMapItem( "models/house3.mdl", -5987.3784179688, -5042.537109375, 37.950397491455, 0.0010714635718614, -116.33020019531, -0.001556396484375, "0", 2 )
					AddMapDoor( -5169.7216796875, -5663.2485351563, 177.41368103027, -0.034385748207569, -20.258558273315, 0.42606675624847, 255, -5208.4208984375, -5575.2856445313, 181.98239135742 )
					AddMapDoor( -5283.6508789063, -5600.876953125, 180.40505981445, 0.00062663620337844, 159.59060668945, -0.0130615234375, 255, -5250.6499023438, -5681.1513671875, 183.81857299805 )
					AddMapDoor( -5912.4155273438, -4884.3022460938, 177.41368103027, -0.034385733306408, 153.62142944336, 0.42606884241104, 255, -5911.3647460938, -4982.7993164063, 181.98530578613 )
					AddMapDoor( -5917.22265625, -4893.7763671875, 177.41368103027, -0.034385722130537, 153.62141418457, 0.42607095837593, 255, -5836.5815429688, -4880.5083007813, 181.9841003418 )
				-- Church
					AddMapItem( "models/church.mdl", -7239.142578125, -5196.1318359375, 50.453350067139, -2.3186012185761e-006, 126.58209228516, 0.011085697449744, "0", 2 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6969.8520507813, -5301.8862304688, 71.435913085938, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6969.0346679688, -5301.310546875, 85.854209899902, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6968.216796875, -5300.7353515625, 100.27250671387, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6967.3989257813, -5300.1596679688, 114.69080352783, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6966.5810546875, -5299.583984375, 129.1091003418, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6965.763671875, -5299.0083007813, 143.52740478516, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6964.9458007813, -5298.4326171875, 157.94570922852, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6964.1279296875, -5297.857421875, 172.36401367188, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6963.3100585938, -5297.2817382813, 186.78231811523, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6962.4926757813, -5296.7060546875, 201.20062255859, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6961.6748046875, -5296.1303710938, 215.61892700195, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6960.8569335938, -5295.5551757813, 230.03723144531, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6960.0390625, -5294.9794921875, 244.45553588867, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6959.2216796875, -5294.4038085938, 258.87384033203, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
					AddMapItem( "models/props_junk/plasticcrate01a.mdl", -6958.4038085938, -5293.828125, 273.29214477539, 1.2568601541474e-011, -144.85990905762, 179.99978637695, "0", 0 )
				-- Dock
					AddMapItem( "models/props_docks/dock_broken01a.mdl", -8764.7119140625, -3594.7072753906, -181.54730224609, -0.0094659691676497, -159.00717163086, -0.002044677734375, "0", 0 )
					AddMapItem( "models/ship.mdl", -8788.9580078125, -3853.6115722656, 100.01145172119, 0.00012569771206472, 111.01943206787, 3.1544284865959e-005, "0", 0 )
					AddMapItem( "models/ship.mdl", -8989.7783203125, -3411.3493652344, 100.01147460938, 0.00012569772661664, 111.45943450928, 2.9443181119859e-005, "0", 0 )
				-- Shops
					AddMapItem( "models/smithy.mdl", -6262.3974609375, -229.21726989746, 78.398231506348, 0.00245406688191, -134.7020111084, -0.007904052734375, "0", 2 )
					AddMapItem( "models/smithy.mdl", -6671.4750976563, 90.291717529297, 78.398170471191, 0.00245406688191, -120.62197875977, -0.007904052734375, "0", 2 )
					AddMapItem( "models/smithy.mdl", -7112.05078125, 329.52493286133, 78.49974822998, 1.2104105735489e-006, -116.1868057251, 9.8651344160317e-007, "0", 2 )
				-- Inn
					AddMapItem( "models/inn.mdl", -6827.49609375, -2122.3283691406, 27.575218200684, 0, 115, 0, "0", 2 )
					AddMapItem( "models/inn.mdl", -6589.5620117188, -2585.8786621094, 27.575218200684, 0, -66, 0, "0", 2 )
					AddMapItem( "models/props/cs_militia/bar01.mdl", -7052.9106445313, -2347.62890625, 67.38671875, 0.028349051252007, 24.438138961792, 0.88707357645035, "0", 0 )
					AddMapItem( "models/props/cs_militia/bar01.mdl", -6359.0556640625, -2365.6701660156, 67.501739501953, 0.042021252214909, -157.46095275879, 0.88972193002701, "0", 0 )
					-- Soundbox
						local ent = ents.Create("soundbox")
						ent:SetPos(Vector(-6642.9819335938, -2610.9645996094, 64.488830566406))
						ent:Spawn()
						ent:GetPhysicsObject():EnableMotion(false)
						ent.Sound = "ambient/Tavern2.wav"
						ent.SoundLength = 4.21875

				-- Mine
					AddMapTree( "models/props_foliage/fallentree_dry02.mdl", -1802.7045898438, -3547.8879394531, 73.173271179199, 0.22083027660847, 88.996383666992, -1.6453857421875, "0", 0 )
					AddMapTree( "models/props_foliage/tree_dry02.mdl", -1859.7418212891, -3808.6447753906, 64.649612426758, -1.307995080424e-005, 134.99971008301, -3.1663796562498e-007, "0", 0 )
					AddMapTree( "models/props_foliage/tree_dead04.mdl", -1491.7962646484, -3735.396484375, 65.257949829102, -0.11878114938736, 135.27420043945, 0.11214896291494, "0", 0 )
					AddMapTree( "models/props_foliage/tree_dead02.mdl", -2184.310546875, -4489.0639648438, 65.518447875977, 0.039791844785213, 128.19784545898, 0.25844544172287, "0", 0 )
					AddMapTree( "models/props_foliage/tree_dry01.mdl", -2380.0209960938, -3896.0092773438, 64.533645629883, 0.074003763496876, 135.97993469238, -0.073486328125, "0", 0 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster02c.mdl", -1961.2191162109, -3973.0981445313, 168.50756835938, -3.94669008255, -123.83319091797, 22.540533065796, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster02b.mdl", -1320.3128662109, -4079.33984375, 304.50054931641, -0.011912093497813, -25.600742340088, -0.05029296875, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster01a.mdl", -937.56170654297, -4157.5146484375, 325.50289916992, -6.669717549812e-006, -34.943714141846, 1.6134927136591e-006, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff05f.mdl", -554.03125, -4551.6381835938, 288.64361572266, -0.85793489217758, 33.773414611816, 0.33050629496574, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff05e.mdl", -558.41955566406, -4698.6005859375, 302.47448730469, 1.4937747716904, -169.66932678223, -1.712890625, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff05a.mdl", -468.04339599609, -4866.0302734375, 307.63491821289, 3.0747272968292, 1.0744957923889, -1.6593017578125, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster01b.mdl", -562.6484375, -5247.1298828125, 289.41314697266, -0.40478876233101, -96.618293762207, 4.3730239868164, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster02b.mdl", -860.38641357422, -5661.7319335938, 323.23739624023, -0.002979583106935, -62.943675994873, -0.042022705078125, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster01b.mdl", -1331.4953613281, -5630.4321289063, 316.38461303711, 0.62976455688477, 163.44436645508, 0.14297090470791, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster01a.mdl", -1748.5505371094, -5168.1918945313, 314.03146362305, 0.20816434919834, 119.7434387207, 0.47011929750443, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff_cluster02a.mdl", -1803.6363525391, -4616.4389648438, 324.89636230469, 0.018536286428571, 164.75245666504, -0.01727294921875, "0", 2 )
					AddMapRock( "models/props_mining/stalactite_static03.mdl", -1629.3975830078, -4316.30078125, 420.43325805664, -4.0888951957641e-007, 134.76612854004, 0.00010998284415109, "0", 2 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", -1377.1910400391, -4400.4995117188, 639.16784667969, 9.3189058303833, 36.407249450684, 158.22103881836, "0", 2 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", -1048.7856445313, -4553.5078125, 634.73443603516, -6.5538330078125, -139.68743896484, -174.05534362793, "0", 2 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", -758.25048828125, -4868.7719726563, 459.88986206055, 15.953939437866, 7.1286754608154, 4.5452456474304, "0", 2 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", -953.58050537109, -5404.8740234375, 536.15203857422, -17.534963607788, 152.09652709961, 167.29183959961, "0", 2 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", -1242.3802490234, -5459.810546875, 599.85980224609, 11.696998596191, -22.7542552948, -141.93193054199, "0", 2 )
					AddMapRock( "models/props_wasteland/rockgranite04c.mdl", -1618.1079101563, -4825.7407226563, 605.10162353516, -22.358224868774, 15.145428657532, 169.75639343262, "0", 2 )
					AddMapRock( "models/props_mining/stalactite_static04.mdl", -1189.5145263672, -4936.3212890625, 56.38452911377, -0.0075231683440506, 44.651321411133, 179.99949645996, "0", 2 )
					AddMapRock( "models/props_wasteland/rockgranite02c.mdl", -1169.7525634766, -4880.6416015625, 110.81842803955, 55.331024169922, 35.318046569824, -14.009765625, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff01b.mdl", -1087.2227783203, -4922.1279296875, 144.21855163574, 12.584844589233, -172.32041931152, -4.8089294433594, "0", 2 )
					AddMapRock( "models/props_wasteland/rockcliff01k.mdl", -1243.65234375, -4955.4760742188, 101.11958312988, 14.872003555298, -74.138046264648, 37.393280029297, "0", 2 )
					-- Soundbox
						local ent = ents.Create("soundbox")
						ent:SetPos(Vector(-1151.4458007813, -4921.9897460938, 64.357818603516))
						ent:Spawn()
						ent:GetPhysicsObject():EnableMotion(false)
						ent.Sound = "ambient/Mine.wav"
						ent.SoundLength = 1.96840

			-- Ruins
					AddMapItem( "models/ruins1.mdl", -5696.5112304688, 5307.8500976563, 44.977783203125, -9.5243768427622e-010, 27.460107803345, 7.9168075899361e-006, "0", 0 )
					AddMapItem( "models/ruins1.mdl", -5003.6538085938, 4990.5830078125, 44.977783203125, -9.5259999888242e-010, 109.30004882813, 7.9168075899361e-006, "0", 0 )
					AddMapItem( "models/ruins1.mdl", -4439.0327148438, 5647.4765625, 44.977783203125, -9.5257812748883e-010, 159.02003479004, 7.9168075899361e-006, "0", 0 )
					AddMapItem( "models/ruins1.mdl", -5593.21484375, 6243.740234375, 44.977783203125, -9.5241670106105e-010, -21.679679870605, 7.9168075899361e-006, "0", 0 )
					AddMapItem( "models/ruins2.mdl", -4326.68359375, 6231.08203125, 31.372459411621, 0.00096356903668493, 95.090377807617, -0.00299072265625, "0", 0 )
					AddMapItem( "models/ruins1.mdl", -5023.8295898438, 6831.0649414063, 44.977783203125, -9.5254126808442e-010, -85.259918212891, 7.9168075899361e-006, "0", 0 )
					-- Soundbox
						local ent = ents.Create("soundbox")
						ent:SetPos(Vector(-4626.5043945313, 5632.2993164063, 67.859535217285))
						ent:SetAngles(Angle(-0.88547366857529, 63.312637329102, -1.0350341796875))
						ent:Spawn()
						ent:GetPhysicsObject():EnableMotion(false)
						ent.Sound = "ambient/Eerie.wav"
						ent.SoundLength = 6

			firstplayerx = 1
		end
	end
end
hook.Add("PlayerInitialSpawn","SpawnItemsOnMap",SpawnMapItems)

function AddMapItem(model, x, y, z, ap, ay, ar, m, c)
	local ent = ents.Create("prop_dynamic_override")
	ent:SetPos(Vector(x, y, z))
	ent:SetAngles(Angle(ap, ay, ar))
	ent:SetModel(model)
	ent:PhysicsInit( SOLID_VPHYSICS )
	ent:Spawn()
	ent:GetPhysicsObject():EnableMotion(false)
	if model == "models/props_junk/plasticcrate01a.mdl" then
		ent:SetColor(0, 0, 0, 0)
	elseif c == 0 then
	elseif c == 1 then
		ent:SetColor(181, 181, 181, 255)
	elseif c == 2 then
		ent:SetColor(96, 96, 96, 255)
	end
	if m == 0 then
		ent:SetMaterial( "None" )
		ent:SetMaterial( "" )
	else
		ent:SetMaterial( "None" )
		ent:SetMaterial(m)
	end
end

function AddMapRock(model, x, y, z, ap, ay, ar, m, c)
	local ent = ents.Create("mine")
	ent:SetPos(Vector(x, y, z))
	ent:SetAngles(Angle(ap, ay, ar))
	ent:SetModel(model)
	ent:PhysicsInit( SOLID_VPHYSICS )
	ent:Spawn()
	ent:GetPhysicsObject():EnableMotion(false)
	if model == "models/props_junk/plasticcrate01a.mdl" then
		ent:SetColor(0, 0, 0, 0)
	elseif c == 0 then
	elseif c == 1 then
		ent:SetColor(181, 181, 181, 255)
	elseif c == 2 then
		ent:SetColor(96, 96, 96, 255)
	end
	if m == 0 then
		ent:SetMaterial( "None" )
		ent:SetMaterial( "" )
	else
		ent:SetMaterial( "None" )
		ent:SetMaterial(m)
	end
end

function AddMapTree(model, x, y, z, ap, ay, ar, m, c)
	local ent = ents.Create("tree")
	ent:SetPos(Vector(x, y, z))
	ent:SetAngles(Angle(ap, ay, ar))
	ent:SetModel(model)
	ent:PhysicsInit( SOLID_VPHYSICS )
	ent:Spawn()
	ent:GetPhysicsObject():EnableMotion(false)
	if model == "models/props_junk/plasticcrate01a.mdl" then
		ent:SetColor(0, 0, 0, 0)
	elseif c == 0 then
	elseif c == 1 then
		ent:SetColor(181, 181, 181, 255)
	elseif c == 2 then
		ent:SetColor(96, 96, 96, 255)
	end
	if m == 0 then
		ent:SetMaterial( "None" )
		ent:SetMaterial( "" )
	else
		ent:SetMaterial( "None" )
		ent:SetMaterial(m)
	end
end

function AddMapDoor(x, y, z, ap, ay, ar, a, telex, teley, telez)
	local ent = ents.Create("door")
	ent:SetPos(Vector(x, y, z))
	ent:SetAngles(Angle(ap, ay, ar))
	ent:PhysicsInit( SOLID_VPHYSICS )
	ent:Spawn()
	ent.AppearPos = Vector( telex, teley, telez )
	ent:GetPhysicsObject():EnableMotion(false)
	ent:SetMaterial( "None" )
	ent:SetMaterial( "" )
	ent:SetColor( 255, 255, 255, a )
end

function AddMapPortal(x, y, z, ap, ay, ar, r, g, b, a, telex, teley, telez)
	local ent = ents.Create("portal")
	ent:SetPos(Vector(x, y, z))
	ent:SetAngles(Angle(ap, ay, ar))
	ent:PhysicsInit( SOLID_VPHYSICS )
	ent:Spawn()
	ent.AppearPos = Vector( telex, teley, telez )
	ent:SetMaterial( "None" )
	ent:SetMaterial( "" )
	ent:SetColor( r, g, b, a )
end

function OpenGates()
	if gate1 then
		gate1:Remove()
		gate2:Remove()
		gate1 = nil
		gate2 = nil
	end

	gate1 = ents.Create("prop_dynamic_override")
	gate1:SetPos(Vector(4472.46484375, 3515.4255371094, 62.501003265381))
	gate1:SetAngles(Angle(-0.029629901051521, 87.241401672363, -0.006988525390625))
	gate1:SetModel("models/castledoor.mdl")
	gate1:PhysicsInit( SOLID_VPHYSICS )
	gate1:Spawn()

	gate2 = ents.Create("prop_dynamic_override")
	gate2:SetPos(Vector(4415.1713867188, 3572.8264160156, 62.655513763428))
	gate2:SetAngles(Angle(-0.040297225117683, -176.24299621582, 0.047541774809361))
	gate2:SetModel("models/castledoor.mdl")
	gate2:PhysicsInit( SOLID_VPHYSICS )
	gate2:Spawn()
end
--concommand.Add("!OPENGATES!", OpenGates)

function CloseGates()
	if gate1 then
		gate1:Remove()
		gate2:Remove()
		gate1 = nil
		gate2 = nil
	end

	gate1 = ents.Create("prop_dynamic_override")
	gate1:SetPos(Vector(4499.8803710938, 3601.6662597656, 64.243041992188))
	gate1:SetAngles(Angle(0, -135, 0))
	gate1:SetModel("models/castledoor.mdl")
	gate1:PhysicsInit( SOLID_VPHYSICS )
	gate1:Spawn()

	gate2 = ents.Create("prop_dynamic_override")
	gate2:SetPos(Vector(4498.35546875, 3604.162109375, 64.020904541016))
	gate2:SetAngles(Angle(0, 45, 0))
	gate2:SetModel("models/castledoor.mdl")
	gate2:PhysicsInit( SOLID_VPHYSICS )
	gate2:Spawn()
end
--concommand.Add("!CLOSEGATES!", CloseGates)

function SpawnUndead(ply)
	if game.GetMap() == "gm_flatgrass2008" then else return end

	spawnundeadarmy = true

	for k, v in pairs(player.GetAll()) do
		if v:GetNWString("race") == "Human" or 
		v:GetNWString("race") == "Dwarf" or 
		v:GetNWString("race") == "Gnome" or 
		v:GetNWString("race") == "Blood Elf" or 
		v:GetNWString("race") == "Night Elf" or 
		v:GetNWString("race") == "Dark Elf" then
			v:ConCommand("pp_colormod 1")
			v:ConCommand("pp_colormod_brightness -1.0")
			v:Freeze( true )
		end
	end

	timer.Create( "Un-blackout", 3, 1, function()
		for k, v in pairs(player.GetAll()) do
			if v:GetNWString("race") == "Human" or 
			v:GetNWString("race") == "Dwarf" or 
			v:GetNWString("race") == "Gnome" or 
			v:GetNWString("race") == "Blood Elf" or 
			v:GetNWString("race") == "Night Elf" or 
			v:GetNWString("race") == "Dark Elf" then
				v:ConCommand("pp_colormod 0")
				v:Freeze( false )
			end
		end
	end )

	-- Move Barney
		if barney then
			barney:Remove()
			barney = nil
		end

		hiding = true
	-- Move Barney

	-- Close the gates
		if gate1 then
			gate1:Remove()
			gate2:Remove()
			gate1 = nil
			gate2 = nil
		end

		gate1 = ents.Create("prop_dynamic_override")
		gate1:SetPos(Vector(4499.8803710938, 3601.6662597656, 64.243041992188))
		gate1:SetAngles(Angle(0, -135, 0))
		gate1:SetModel("models/castledoor.mdl")
		gate1:PhysicsInit( SOLID_VPHYSICS )
		gate1:Spawn()

		gate2 = ents.Create("prop_dynamic_override")
		gate2:SetPos(Vector(4498.35546875, 3604.162109375, 64.020904541016))
		gate2:SetAngles(Angle(0, 45, 0))
		gate2:SetModel("models/castledoor.mdl")
		gate2:PhysicsInit( SOLID_VPHYSICS )
		gate2:Spawn()
	-- Close the gates

	-- Destroy the gates
		timer.Create( "DestroyGates", 10, 1, function()
			if gate1 then
				gate1:Remove()
				gate2:Remove()
				gate1 = nil
				gate2 = nil
			end

			gate1 = ents.Create("prop_physics")
			gate1:SetPos(Vector(4499.8803710938, 3601.6662597656, 64.243041992188))
			gate1:SetAngles(Angle(3.6429510116577, 44.889457702637, 0.00075883435783908))
			gate1:SetModel("models/castledoor.mdl")
			gate1:PhysicsInit( SOLID_VPHYSICS )
			gate1:Spawn()
			gate1:SetCollisionGroup(COLLISION_GROUP_WORLD)
			gate1.CollisionGroup = COLLISION_GROUP_WORLD

			gate2 = ents.Create("prop_physics")
			gate2:SetPos(Vector(4498.35546875, 3604.162109375, 64.020904541016))
			gate2:SetAngles(Angle(-5.4343729019165, -136.45887756348, -0.07391357421875))
			gate2:SetModel("models/castledoor.mdl")
			gate2:PhysicsInit( SOLID_VPHYSICS )
			gate2:Spawn()
			gate2:SetCollisionGroup(COLLISION_GROUP_WORLD)
			gate2.CollisionGroup = COLLISION_GROUP_WORLD

			timer.Create( "RemoveGates", 10, 1, function()
				if gate1 then
					gate1:Remove()
					gate2:Remove()
					gate1 = nil
					gate2 = nil
				end
			end )
		end )
	-- Destroy the gates

	-- Open the gates
		timer.Create( "OpenGates", 180, 1, function()
			if gate1 then
				gate1:Remove()
				gate2:Remove()
				gate1 = nil
				gate2 = nil
			end

			gate1 = ents.Create("prop_dynamic_override")
			gate1:SetPos(Vector(4472.46484375, 3515.4255371094, 62.501003265381))
			gate1:SetAngles(Angle(-0.029629901051521, 87.241401672363, -0.006988525390625))
			gate1:SetModel("models/castledoor.mdl")
			gate1:PhysicsInit( SOLID_VPHYSICS )
			gate1:Spawn()

			gate2 = ents.Create("prop_dynamic_override")
			gate2:SetPos(Vector(4415.1713867188, 3572.8264160156, 62.655513763428))
			gate2:SetAngles(Angle(-0.040297225117683, -176.24299621582, 0.047541774809361))
			gate2:SetModel("models/castledoor.mdl")
			gate2:PhysicsInit( SOLID_VPHYSICS )
			gate2:Spawn()

			if barney2 then
				barney2:Remove()
				barney2 = nil
			end

			hiding = false
		end )
	-- Open the gates
end
concommand.Add("mrp_spawnundead", SpawnUndead)

function DestroyGates()
	if gate1 then
		gate1:Remove()
		gate2:Remove()
		gate1 = nil
		gate2 = nil
	end

	gate1 = ents.Create("prop_physics")
	gate1:SetPos(Vector(4499.8803710938, 3601.6662597656, 64.243041992188))
	gate1:SetAngles(Angle(0, -135, 0))
	gate1:SetModel("models/castledoor.mdl")
	gate1:PhysicsInit( SOLID_VPHYSICS )
	gate1:Spawn()
	gate1:SetCollisionGroup(COLLISION_GROUP_WORLD)
	gate1.CollisionGroup = COLLISION_GROUP_WORLD

	gate2 = ents.Create("prop_physics")
	gate2:SetPos(Vector(4498.35546875, 3604.162109375, 64.020904541016))
	gate2:SetAngles(Angle(0, 45, 0))
	gate2:SetModel("models/castledoor.mdl")
	gate2:PhysicsInit( SOLID_VPHYSICS )
	gate2:Spawn()
	gate2:SetCollisionGroup(COLLISION_GROUP_WORLD)
	gate2.CollisionGroup = COLLISION_GROUP_WORLD

	timer.Create( "RemoveGates", 10, 1, function()
		if gate1 then
			gate1:Remove()
			gate2:Remove()
			gate1 = nil
			gate2 = nil
		end
	end )
end
--concommand.Add("!DESTROYGATES!", DestroyGates) 