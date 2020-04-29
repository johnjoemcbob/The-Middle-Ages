AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_c17/FurnitureTable002a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity.nodupe = true
	workbenchent = self.Entity
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	nextuse = 0
end

function CreatePlank()
	WCreateEntity("Plank", "plank", 0, 0, 0, 0, 0, 1)
end
concommand.Add( "create_plank", CreatePlank )

function CreateChair()
	WCreateEntity("Chair", "chair", 2, 1, 0, 0, 0, 0)
end
concommand.Add( "create_chair", CreateChair )

function CreateTable()
	if wactivatorx:GetNWInt("craftinglevel") > 11 then
		WCreateEntity("Table", "table", 4, 2, 0, 0, 0, 0)
	else
		wactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Crafting Level of atleast 12 to make this." )
	end
end
concommand.Add( "create_table", CreateTable )

function CreateFence()
	if wactivatorx:GetNWInt("craftinglevel") > 19 then
		WCreateEntity("Fence", "fence", 7, 3, 0, 0, 0, 0)
	else
		wactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Crafting Level of atleast 20 to make this." )
	end
end
concommand.Add( "create_fence", CreateFence )

function CreateStatue()
	if wactivatorx:GetNWInt("craftinglevel") > 28 then
		WCreateEntity("Statue", "statue", 0, 12, 7, 0, 0, 0)
	else
		wactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Crafting Level of atleast 29 to make this." )
	end
end
concommand.Add( "create_statue", CreateStatue )

function CreateSapphireRing()
	if wactivatorx:GetNWInt("craftinglevel") > 23 then
		WCreateEntity("Sapphire Ring", "ring_sapphire", 0, 0, 2, 1, 0, 0)
	else
		wactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Crafting Level of atleast 24 to make this." )
	end
end
concommand.Add( "create_ring_sapphire", CreateSapphireRing )

function CreateEmeraldRing()
	if wactivatorx:GetNWInt("craftinglevel") > 29 then
		WCreateEntity("Emerald Ring", "ring_emerald", 0, 2, 0, 0, 1, 0)
	else
		wactivatorx:PrintMessage( HUD_PRINTTALK, "You need a \ of atleast 30 to make this." )
	end
end
concommand.Add( "create_ring_emerald", CreateEmeraldRing )

function CreateBow()
	if wactivatorx:GetNWInt("craftinglevel") > 22 then
		WCreateEntity("Bow", "maw_bow", 3, 1, 0, 0, 0, 0)
	else
		wactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Crafting Level of atleast 23 to make this." )
	end
end
concommand.Add( "create_bow", CreateBow )

function CreateFireBow()
	if wactivatorx:GetNWInt("craftinglevel") > 24 then
		WCreateEntity("Fire Bow", "maw_bow_fire", 6, 2, 0, 0, 0, 0)
	else
		wactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Crafting Level of atleast 25 to make this." )
	end
end
concommand.Add( "create_bow_fire", CreateFireBow )

function WCreateEntity(name,planksneeded,ironneeded,copperneeded,sapphiresneeded,emeraldsneeded,logsneeded)
	planks = 0
	iron = 0
	copper = 0
	sapphires = 0
	emeralds = 0
	logs = 0

	local workbenchents = ents.FindInSphere(workbenchent:GetPos(),70)
	for k,v in pairs(workbenchents) do
		if (planksneeded > planks) then
			if string.find(v:GetClass(),"resource_plank") then
				planks = planks + 1
				v:Remove()
			end
		end

		if (ironneeded > iron) then
			if string.find(v:GetClass(),"resource_iron") then
				iron = iron + 1
				v:Remove()
			end
		end

		if (copperneeded > copper) then
			if string.find(v:GetClass(),"resource_copper") then
				copper = copper + 1
				v:Remove()
			end
		end

		if (sapphiresneeded > sapphires) then
			if string.find(v:GetClass(),"resource_sapphire") then
				sapphires = sapphires + 1
				v:Remove()
			end
		end

		if (emeraldsneeded > emeralds) then
			if string.find(v:GetClass(),"resource_emerald") then
				emeralds = emeralds + 1
				v:Remove()
			end
		end

		if (logsneeded > logs) then
			if string.find(v:GetClass(),"resource_log") then
				logs = logs + 1
				v:Remove()
			end
		end
	end

	if (planksneeded <= planks) and (ironneeded <= iron) and (copperneeded <= copper) and (sapphiresneeded <= sapphires) and (emeraldsneeded <= emeralds) and (logsneeded <= logs) then
		wactivatorx:GiveItem( item, 1 )
		ShowTipPlayer(wactivatorx, 0, 4, "Created a "..name.."." )
		wactivatorx:SetNWInt("canuse", 1)
		wactivatorx:ConCommand("WAddExp")
	else
		wactivatorx:PrintMessage( HUD_PRINTTALK, "Either you don't have enough resources to make that or your Workbench is broken." )
	end
end

function WAddExp(wactivatorx)
		if wactivatorx:GetNWInt("craftinglevel") > 4 then
			leveladd = 15
		else
			leveladd = 20
		end

		local oldcexp = wactivatorx:GetNWInt("craftingexp")
		randomgain = math.random(leveladd + 5, leveladd + 10)
		CraftingLevelData[ wactivatorx:UniqueID() ][ "craftingexp" ] = oldcexp + randomgain
		wactivatorx:SetNWInt( "craftingexp", oldcexp + randomgain)
		if wactivatorx:GetNWInt("craftingexp") > 99 then
			local oldcexp = wactivatorx:GetNWInt("craftingexp")
			local oldclevel = wactivatorx:GetNWInt("craftinglevel")
			CraftingLevelData[ wactivatorx:UniqueID() ][ "craftingexp" ] = 0
			wactivatorx:SetNWInt( "craftingexp", 0)

			CraftingLevelData[ wactivatorx:UniqueID() ][ "craftinglevel" ] = oldclevel + 1
			wactivatorx:SetNWInt( "craftinglevel", oldclevel + 1)
			if wactivatorx:GetNWInt("craftinglevel") == 12 then
				iflevel = "\nYou can now make Tables!"
			elseif wactivatorx:GetNWInt("craftinglevel") == 20 then
				iflevel = "\nYou can now make Fences!"
			elseif wactivatorx:GetNWInt("craftinglevel") == 23 then
				iflevel = "\nYou can now make Sapphire Rings!"
			elseif wactivatorx:GetNWInt("craftinglevel") == 27 then
				iflevel = "\nYou can now cut Sapphires!"
			elseif wactivatorx:GetNWInt("craftinglevel") == 29 then
				iflevel = "\nYou can now make Statues!"
			elseif wactivatorx:GetNWInt("craftinglevel") == 30 then
				iflevel = "\nYou can now make Emerald Rings!"
			elseif wactivatorx:GetNWInt("craftinglevel") == 35 then
				iflevel = "\nYou can now cut Emeralds!"
			else
				iflevel = ""
			end
			newlevel = oldclevel + 1
			wactivatorx:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " crafting!" .. iflevel )
		end
end
concommand.Add( "WAddExp", WAddExp )

function ENT:Use(activator,caller)
	wactivatorx = nil
	wactivatorx = activator
	if nextuse < CurTime() then
		umsg.Start("CraftingMenu", activator)
		umsg.End()
		workbenchent = nil
		workbenchent = self.Entity
		nextuse = CurTime() + 1
	end
end

function ENT:Think()
	self.Entity:NextThink(CurTime() + 1) -- Think only once a second instead of once per tick.
	owner = nil
	for k, v in pairs(player.GetAll()) do
		if self.Entity:GetNWString("entowner") == v then
			owner = true
		end
	end
	if owner == true then else
		self.Entity:Remove()
	end
end 