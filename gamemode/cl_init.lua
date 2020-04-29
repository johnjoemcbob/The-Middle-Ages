DeriveGamemode("sandbox")
include( 'shared.lua' )
include( 'cl_scoreboard.lua' )
include( 'cl_inventory.lua' )
include( 'cl_vgui.lua' )
include( 'cl_npcchat.lua' )

local pmeta = FindMetaTable("Player")

pmeta.Name = function(self)
	return self:GetNWString("rpname")
end

pmeta.GetName = pmeta.Name
pmeta.Nick = pmeta.Name

local meta = FindMetaTable("Entity")

function meta:IsOwnable()
	local class = self:GetClass()

	if (class == "func_door" or class == "func_door_rotating" or class == "prop_door_rotating") or
		class == "prop_vehicle_jeep" or class == "prop_vehicle_airboat" then
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

function GM:HUDPaint()
	self.BaseClass:HUDPaint()
	if LocalPlayer():Alive() == true then else return end

	local tr = LocalPlayer():GetEyeTrace()

	local hx = 9
	local hy = ScrH() - 25
	local hw = 190
	local hh = 10

	if LocalPlayer():GetNWInt("frozen") == 1 then
		local Texture = surface.GetTextureID( "medievalrp/icicles" );
		local BoxSizeH = ScrH();
		local BoxSizeW = ScrW();
		surface.SetDrawColor( 255, 255, 255, 255 );
		surface.SetTexture( Texture );
		surface.DrawTexturedRect( 0, BoxSizeH, BoxSizeW, BoxSizeH )
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 1 then
		exphudtype = "smithingexp"
		exphudtypea = "Smithing Experience: "
		levelhudtype = "smithinglevel"
		levelhudtypea = "Smithing Level: "
	elseif LocalPlayer():GetNWInt("HUDexpbar") == 2 then
		exphudtype = "miningexp"
		exphudtypea = "Mining Experience: "
		levelhudtype = "mininglevel"
		levelhudtypea = "Mining Level: "
	elseif LocalPlayer():GetNWInt("HUDexpbar") == 3 then
		exphudtype = "lumberingexp"
		exphudtypea = "Lumbering Experience: "
		levelhudtype = "lumberinglevel"
		levelhudtypea = "Lumbering Level: "
	elseif LocalPlayer():GetNWInt("HUDexpbar") == 4 then
		exphudtype = "craftingexp"
		exphudtypea = "Crafting Experience: "
		levelhudtype = "craftinglevel"
		levelhudtypea = "Crafting Level: "
	elseif LocalPlayer():GetNWInt("HUDexpbar") == 5 then
		exphudtype = "cookingexp"
		exphudtypea = "Cooking Experience: "
		levelhudtype = "cookinglevel"
		levelhudtypea = "Cooking Level: "
	elseif LocalPlayer():GetNWInt("HUDexpbar") == 6 then
		exphudtype = "alchemyexp"
		exphudtypea = "Alchemy Experience: "
		levelhudtype = "alchemylevel"
		levelhudtypea = "Alchemy Level: "
	elseif LocalPlayer():GetNWInt("HUDexpbar") == 7 then
		exphudtype = "fightingexp"
		exphudtypea = "Fighting Experience: "
		levelhudtype = "fightinglevel"
		levelhudtypea = "Fighting Level: "
	elseif LocalPlayer():GetNWInt("HUDexpbar") == 8 then
		exphudtype = "fishingexp"
		exphudtypea = "Fishing Experience: "
		levelhudtype = "fishinglevel"
		levelhudtypea = "Fishing Level: "
	elseif LocalPlayer():GetNWInt("HUDexpbar") == 9 then
		exphudtype = "magicexp"
		exphudtypea = "Magic Experience: "
		levelhudtype = "magiclevel"
		levelhudtypea = "Magic Level: "
	else
		exphudtype = "smithingexp"
		exphudtypea = "Smithing Experience: "
		levelhudtype = "smithinglevel"
		levelhudtypea = "Smithing Level: "
	end

	if LocalPlayer():GetNWInt("HUD") == 1 then
		if LocalPlayer():GetNWString("race") == "Dwarf" then
			local Texture = surface.GetTextureID( "medievalrp/HUD/hud_dwarf" );
			local BoxSizeH = ScrH()/2;
			local BoxSizeW = ScrW();
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( Texture );
			surface.DrawTexturedRect( 0, BoxSizeH, BoxSizeW, BoxSizeH )
		elseif LocalPlayer():GetNWString("race") == "Undead" then
			local Texture = surface.GetTextureID( "medievalrp/HUD/hud_undead" );
			local BoxSizeH = ScrH()/2;
			local BoxSizeW = ScrW();
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( Texture );
			surface.DrawTexturedRect( 0, BoxSizeH, BoxSizeW, BoxSizeH )
		elseif LocalPlayer():GetNWString("race") == "Blood Elf" then
			local Texture = surface.GetTextureID( "medievalrp/HUD/hud_bloodelf" );
			local BoxSizeH = ScrH()/2;
			local BoxSizeW = ScrW();
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( Texture );
			surface.DrawTexturedRect( 0, BoxSizeH, BoxSizeW, BoxSizeH )
		elseif LocalPlayer():GetNWString("race") == "Night Elf" then
			local Texture = surface.GetTextureID( "medievalrp/HUD/hud_nightelf" );
			local BoxSizeH = ScrH()/2;
			local BoxSizeW = ScrW();
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( Texture );
			surface.DrawTexturedRect( 0, BoxSizeH, BoxSizeW, BoxSizeH )
		elseif LocalPlayer():GetNWString("race") == "Ogre" then
			local Texture = surface.GetTextureID( "medievalrp/HUD/hud_ogre" );
			local BoxSizeH = ScrH()/2;
			local BoxSizeW = ScrW();
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( Texture );
			surface.DrawTexturedRect( 0, BoxSizeH, BoxSizeW, BoxSizeH )
		else
			local Texture = surface.GetTextureID( "medievalrp/HUD/hud_human" );
			local BoxSizeH = ScrH()/2;
			local BoxSizeW = ScrW();
			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( Texture );
			surface.DrawTexturedRect( 0, BoxSizeH, BoxSizeW, BoxSizeH )
		end

		draw.RoundedBox(6, ScrW()/9, ((ScrH()/21)*18), hw + 8, hh + 8, Color(0, 0, 0, 200)) -- Heath HUD Box
		draw.RoundedBox(6, (ScrW()/2)-90, hy - 78, hw + 8, hh + 8, Color(0, 0, 0, 200)) -- Exp HUD Box
		if LocalPlayer():GetNWInt("armour") > 0 then
			draw.RoundedBox(6, hx + 46, hy - 38, hw + 8, hh + 8, Color(0, 0, 0, 200)) -- Armour HUD Box
		end
		if GetGlobalInt("hunger") == 1 then
			draw.RoundedBox(6, ScrW()-(hx + hw / 2 + 46)-109, hy - 78, hw + 8, hh + 8, Color(0, 0, 0, 200)) -- Hunger HUD Box
		end

		if LocalPlayer():Health() > 0 then
			draw.RoundedBox(4, (ScrW()/9)+4, ((ScrH()/21)*18)+4, math.Clamp(hw * (LocalPlayer():Health() / 100), 0, 190), hh, Color(140, 0, 0, 180)) -- Health HUD Bar
		end
		if LocalPlayer():GetNWInt( exphudtype ) > 0 then
			draw.RoundedBox(4, (ScrW()/2)-90+4, hy - 74, math.Clamp(hw * (LocalPlayer():GetNWInt( exphudtype ) / 100), 0, 190), hh, Color(226, 215, 61, 180)) -- Exp HUD Bar
		end
		if LocalPlayer():GetNWInt("armour") > 0 then
			draw.RoundedBox(4, hx + 50, hy - 34, math.Clamp(hw * (LocalPlayer():GetNWInt("armour") / LocalPlayer():GetNWInt("maxarmour")), 0, 190), hh, Color(181, 181, 181, 180)) -- Armour HUD Bar
		end
		if GetGlobalInt("hunger") == 1 then
			draw.RoundedBox(4, ScrW()-(hx + hw / 2 + 50)-100, hy - 74, math.Clamp(hw * (LocalPlayer():GetNWInt("hunger") / 100), 0, 190), hh, Color(216, 0, 255, 180)) -- Hunger HUD Bar
		end

		draw.DrawText("Health: " .. LocalPlayer():Health(), "TargetID", (ScrW()/9)+100, (ScrH()/21)*18, Color(255, 255, 255, 200), 1)
		draw.DrawText(exphudtypea .. LocalPlayer():GetNWInt( exphudtype ), "TargetID", (ScrW()/2)+4, hy - 80, Color(255, 255, 255, 200), 1)
		if LocalPlayer():GetNWInt("armour") > 0 then
			draw.DrawText("Armour: " .. LocalPlayer():GetNWInt("armour"), "TargetID", hx + hw / 2 + 50, hy - 40, Color(255, 255, 255, 200), 1)
		end
		if GetGlobalInt("hunger") == 1 then
			draw.DrawText("Hunger: " .. LocalPlayer():GetNWInt("hunger"), "TargetID", ScrW()-(hx + hw / 2 + 50), hy - 80, Color(255, 255, 255, 200), 1)
		end
		draw.DrawText("Name: " .. LocalPlayer():GetNWInt("name"), "TargetID", hx + hw / 2 + 71, hy - 20, Color(255, 255, 255, 200), 0)
		--draw.DrawText("Name: " .. LocalPlayer():GetNWInt("name"), "TargetID", hx + hw / 2 + 70, hy - 21, Color(0, 0, 0, 255), 0)
		draw.DrawText("Job: " .. LocalPlayer():GetNWString("job"), "TargetID", ScrH()-(hx + hw / 2 + 71), hy - 20, Color(255, 255, 255, 200), 0)
		--draw.DrawText("Job: " .. LocalPlayer():GetNWString("job"), "TargetID", ScrH()-(hx + hw / 2 + 70), hy - 21, Color(0, 0, 0, 255), 0)
		draw.DrawText("Pocket: " .. LocalPlayer():GetNWInt("gold") .. " Gold", "TargetID", ScrW()-(hx + hw / 2 + 151), hy - 40, Color(255, 255, 255, 200), 0)
		--draw.DrawText("Pocket: " .. LocalPlayer():GetNWInt("gold") .. " Gold", "TargetID", ScrW()-(hx + hw / 2 + 150), hy - 41, Color(0, 0, 0, 255), 0)
		draw.DrawText(levelhudtypea .. LocalPlayer():GetNWInt( levelhudtype ), "TargetID", (ScrW()/2)-50+1, hy - 40, Color(0, 0, 0, 255), 0)
		draw.DrawText(levelhudtypea .. LocalPlayer():GetNWInt( levelhudtype ), "TargetID", (ScrW()/2)-50, hy - 41, Color(255, 255, 255, 200), 0)
	end

	local function DrawDisplay()
		if tr.Entity and tr.Entity:GetPos():Distance(LocalPlayer():GetPos()) < 400 then
			local pos = LocalPlayer():GetEyeTrace().HitPos:ToScreen()
			if tr.Entity:IsOwnable() then
				local ownerstr = ""
				local ent = ents.GetByIndex(tr.Entity:EntIndex())

				if ent:GetNWInt("Ownerz") > 0 then
					if player.GetByID(ent:GetNWInt("Ownerz")) then
						ownerstr = player.GetByID(ent:GetNWInt("Ownerz")):GetNWString("name") .. "\n"
					end
				end

				local num = ent:GetNWInt("OwnerCount")

				for n = 1, num do
					if (ent:GetNWInt("Ownersz" .. n) or -1) > -1 then
						if player.GetByID(ent:GetNWInt("Ownersz" .. n)) then
							ownerstr = ownerstr .. player.GetByID(ent:GetNWInt("Ownersz" .. n)):GetNWString("name") .. "\n"
						end
					end
				end

				num = ent:GetNWInt("AllowedNum")

				for n = 1, num do
					if ent:GetNWInt("Allowed" .. n) == LocalPlayer():EntIndex() then
						ownerstr = ownerstr .. "You are allowed to co-own this door\nF4 to Co-Own"
					elseif ent:GetNWInt("Allowed" .. n) > -1 then
						if player.GetByID(ent:GetNWInt("Allowed" .. n)) then
							ownerstr = ownerstr .. player.GetByID(ent:GetNWInt("Allowed" .. n)):GetNWString("name") .. " is allowed to co-own this door\n"
						end
					end
				end

				if not LocalPlayer():InVehicle() then
					local blocked = ent:GetNWBool("nonOwnable")
					local st = nil
					local whiteText = false -- false for red, true for white text

					if ent:IsOwned() then
						whiteText = true

						if superAdmin then
							if blocked then
								st = ent:GetNWString("dTitle") .. ""
							else
								if ownerstr == "" then
									st = ent:GetNWString("title") .. ""
								else
									st = ent:GetNWString("title") .. "\nOwned by:\n" .. ownerstr .. ""
								end
							end
						else
							if blocked then
								st = ent:GetNWString("dTitle")
							else
								if ownerstr == "" then
									st = ent:GetNWString("title")
								else
									st = ent:GetNWString("title") .. "\nOwned by:\n" .. ownerstr
								end
							end
						end
					else
						if superAdmin then
							if blocked then
								whiteText = true
								st = ent:GetNWString("dTitle") .. ""
							else
								st = "Unowned\nF4 to Own"
							end
						else
							if blocked then
								whiteText = true
								st = ent:GetNWString("dTitle")
							else
								st = "Unowned\nF4 to Own"
							end
						end
					end

					if whiteText then
						draw.DrawText(st, "TargetID", pos.x + 1, pos.y + 1, Color(0, 0, 0, 200), 1)
						draw.DrawText(st, "TargetID", pos.x, pos.y, Color(255, 255, 255, 200), 1)
					else
						draw.DrawText(st, "TargetID", pos.x + 1, pos.y + 1, Color(0, 0, 0, 255), 1)
						draw.DrawText(st, "TargetID", pos.x, pos.y, Color(128, 30, 30, 255), 1)
					end
				end
			elseif tr.Entity:GetClass() == "npc_breen" and tr.Entity:GetModel() == "models/humans/group03/male_07.mdl" then
				draw.DrawText("Aaron Landels\nThe Angry Engineer", "TargetID", pos.x + 1, pos.y + 1, Color(0, 0, 0, 200), 1)
				draw.DrawText("Aaron Landels\nThe Angry Engineer", "TargetID", pos.x, pos.y, Color(0, 0, 255, 200), 1)
			elseif tr.Entity:GetClass() == "Ship" and tr.Entity:GetNWString("entowner") == LocalPlayer() then
				if LocalPlayer():GetNetworkedBool("isDriveShuttle") == true then else
					draw.DrawText("Your Ship!", "TargetID", pos.x + 1, pos.y + 1, Color(0, 0, 0, 200), 1)
					draw.DrawText("Your Ship!", "TargetID", pos.x, pos.y, Color(255, 255, 255, 200), 1)
				end
			end
		end
	end
	DrawDisplay()
end

function GM:HUDDrawTargetID()
	local tr = util.GetPlayerTrace( LocalPlayer(), LocalPlayer():GetAimVector() )
	local trace = util.TraceLine( tr )
	if (!trace.Hit) then return end
	if (!trace.HitNonWorld) then return end

	local textname = "ERROR"
	local font = "TargetID"

	if (trace.Entity:IsPlayer()) then
		textname = trace.Entity:GetNWString("name")
	else
		return
	end

	surface.SetFont( font )
	local w, h = surface.GetTextSize( textname )

	local MouseX, MouseY = gui.MousePos()

	if ( MouseX == 0 && MouseY == 0 ) then
		MouseX = ScrW() / 2
		MouseY = ScrH() / 2
	end

	local x = MouseX
	local y = MouseY

	x = x - w / 2
	y = y + 30

	draw.SimpleText( textname, font, x+1, y+1, Color(0,0,0,120) )
	draw.SimpleText( textname, font, x+2, y+2, Color(0,0,0,50) )
	draw.SimpleText( textname, font, x, y, self:GetTeamColor( trace.Entity ) )

	y = y + h + 5

	local textjob = trace.Entity:GetNWString("job")
	local font = "TargetIDSmall"

	surface.SetFont( font )
	local w, h = surface.GetTextSize( textjob )
	local x =  MouseX  - w / 2

	draw.SimpleText( textjob, font, x+1, y+1, Color(0,0,0,120) )
	draw.SimpleText( textjob, font, x+2, y+2, Color(0,0,0,50) )
	draw.SimpleText( textjob, font, x, y, self:GetTeamColor( trace.Entity ) )

	y = y + h

	local texthealth = trace.Entity:Health() .. "%"
	local font = "TargetIDSmall"

	surface.SetFont( font )
	local w, h = surface.GetTextSize( texthealth )
	local x =  MouseX  - w / 2

	draw.SimpleText( texthealth, font, x+1, y+1, Color(0,0,0,120) )
	draw.SimpleText( texthealth, font, x+2, y+2, Color(0,0,0,50) )
	draw.SimpleText( texthealth, font, x, y, self:GetTeamColor( trace.Entity ) )
end

function GM:HUDShouldDraw(name)
	if name == "CHudHealth" or name == "CHudBattery" or name == "CHudSuitPower" or (HelpToggled and name == "CHudChat") then
		return false
	else
		return true
	end
end 