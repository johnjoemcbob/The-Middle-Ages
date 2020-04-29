AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_c17/furnitureStove001a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity.nodupe = true
	stoveent = self.Entity
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	nextuse = 0
end

function CreateBread()
	SCreateEntity("Bread", "bread", 0, 0, 0, 2, 0, 0, 0, 0)
end
concommand.Add( "create_bread", CreateBread )

function CreateRoastedMushroom()
	SCreateEntity("Roasted Mushroom", "mushroom_roasted", 0, 0, 0, 0, 0, 1, 0, 0)
end
concommand.Add( "create_mushroom_roasted", CreateRoastedMushroom )

function CreateGoldFish()
	if sactivatorx:GetNWInt("cookinglevel") > 11 then
		SCreateEntity("Gold Fish", "fish_gold_cooked", 1, 0, 0, 0, 0, 0, 0, 0)
	else
		sactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Cooking Level of atleast 12 to make this." )
	end
end
concommand.Add( "create_goldfish", CreateGoldFish )

function CreateTunaFish()
	if sactivatorx:GetNWInt("cookinglevel") > 22 then
		SCreateEntity("Tuna Fish", "fish_tuna_cooked", 0, 0, 1, 0, 0, 0, 0, 0)
	else
		sactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Cooking Level of atleast 23 to make this." )
	end
end
concommand.Add( "create_tunafish", CreateTunaFish )

function CreateDamselFish()
	if sactivatorx:GetNWInt("cookinglevel") > 31 then
		SCreateEntity("Damsel Fish", "fish_damsel_cooked", 0, 0, 0, 0, 1, 0, 0, 0)
	else
		sactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Cooking Level of atleast 32 to make this." )
	end
end
concommand.Add( "create_damselfish", CreateDamselFish )

function CreateGrammabassletFish()
	if sactivatorx:GetNWInt("cookinglevel") > 34 then
		SCreateEntity("Grammabasslet Fish", "fish_basslet_cooked", 0, 0, 0, 0, 0, 0, 1, 0)
	else
		sactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Cooking Level of atleast 35 to make this." )
	end
end
concommand.Add( "create_bassletfish", CreateGrammabassletFish )

function CreateMoorishidolFish()
	if sactivatorx:GetNWInt("cookinglevel") > 39 then
		SCreateEntity("Moorish Idol Fish", "fish_moorishidol_cooked", 0, 0, 0, 0, 0, 0, 0, 1)
	else
		sactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Cooking Level of atleast 40 to make this." )
	end
end
concommand.Add( "create_moorishidolfish", CreateMoorishidolFish )

function SCreateEntity(name, item, goldfishneeded, potatoesneeded, tunafishneeded, doughneeded, damselfishneeded, mushroomneeded, bassletfishneeded, moorishidolfishneeded)
	goldfish = 0
	potatoes = 0
	tunafish = 0
	dough = 0
	damselfish = 0
	mushroom = 0
	bassletfish = 0
	moorishidolfish = 0

	local stoveents = ents.FindInSphere(stoveent:GetPos(),70)
	for k,v in pairs(stoveents) do
		if (goldfishneeded > goldfish) then
			if string.find(v:GetClass(),"fish_gold") then
				goldfish = goldfish + 1
				v:Remove()
			end
		end

		if (potatoesneeded > potatoes) then
			if string.find(v:GetClass(),"resource_potato") then
				potatoes = potatoes + 1
				v:Remove()
			end
		end

		if (tunafishneeded > tunafish) then
			if string.find(v:GetClass(),"fish_tuna") then
				tunafish = tunafish + 1
				v:Remove()
			end
		end

		if (doughneeded > dough) then
			if string.find(v:GetClass(),"resource_dough") then
				dough = dough + 1
				v:Remove()
			end
		end

		if (damselfishneeded > damselfish) then
			if string.find(v:GetClass(),"fish_damsel") then
				damselfish = damselfish + 1
				v:Remove()
			end
		end

		if (mushroomneeded > mushroom) then
			if string.find(v:GetClass(),"resource_mushroom") then
				mushroom = mushroom + 1
				v:Remove()
			end
		end

		if (bassletfishneeded > bassletfish) then
			if string.find(v:GetClass(),"fish_basslet") then
				bassletfish = bassletfish + 1
				v:Remove()
			end
		end

		if (moorishidolfishneeded > moorishidolfish) then
			if string.find(v:GetClass(),"fish_moorishidol") then
				moorishidolfish = moorishidolfish + 1
				v:Remove()
			end
		end
	end

	if (goldfishneeded <= goldfish) and (potatoesneeded <= potatoes) and (tunafishneeded <= tunafish) and (doughneeded <= dough) and (damselfishneeded <= damselfish) and (mushroomneeded <= mushroom) and (bassletfishneeded <= bassletfish) and (moorishidolfishneeded <= moorishidolfish) then
		sactivatorx:GiveItem( item, 1 )
		ShowTipPlayer(sactivatorx, 0, 4, "Cooked a "..name.."." )
		sactivatorx:SetNWInt("canuse", 1)
		sactivatorx:ConCommand("SAddExp")
	else
		sactivatorx:PrintMessage( HUD_PRINTTALK, "You don't have enough resources to make." )
	end
end

function SAddExp(sactivatorx)
	if sactivatorx:GetNWInt("cookinglevel") > 4 then
		leveladd = 15
	else
		leveladd = 20
	end

	local oldcexp = sactivatorx:GetNWInt("cookingexp")
	randomgain = math.random(leveladd + 5, leveladd + 10)
	CookingLevelData[ sactivatorx:UniqueID() ][ "cookingexp" ] = oldcexp + randomgain
	sactivatorx:SetNWInt( "cookingexp", oldcexp + randomgain)
	if sactivatorx:GetNWInt("cookingexp") > 99 then
		local oldcexp = sactivatorx:GetNWInt("cookingexp")
		local oldclevel = sactivatorx:GetNWInt("cookinglevel")
		CookingLevelData[ sactivatorx:UniqueID() ][ "cookingexp" ] = 0
		sactivatorx:SetNWInt( "cookingexp", 0)

		CookingLevelData[ sactivatorx:UniqueID() ][ "cookinglevel" ] = oldclevel + 1
		sactivatorx:SetNWInt( "cookinglevel", oldclevel + 1)
		if sactivatorx:GetNWInt("cookinglevel") == 12 then
			iflevel = ""
		else
			iflevel = ""
		end
		newlevel = oldclevel + 1
		sactivatorx:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " cooking!" .. iflevel )
	end
end
concommand.Add( "SAddExp", SAddExp )

function ENT:Use(activator,caller)
	sactivatorx = nil
	sactivatorx = activator
	if nextuse < CurTime() then
		umsg.Start("CookingMenu", activator)
		umsg.End()
		stoveent = nil
		stoveent = self.Entity
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