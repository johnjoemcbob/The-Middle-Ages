AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_c17/metalPot001a.mdl")
	self.Entity:SetColor(53,53,53,255)
	self.Entity:SetMaterial("models/debug/debugwhite")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity.nodupe = true
	kitent = self.Entity
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	nextuse = 0
end

function CreatePotion()
	KCreateEntity("Potion","potion", 1, 0, 2, 1)
end
concommand.Add( "create_potion", CreatePotion )

function CreatePoison()
	KCreateEntity("Poison","poison", 1, 2, 0, 1)
end
concommand.Add( "create_poison", CreatePoison )

function CreatePotionSpeed()
	if kactivatorx:GetNWInt("alchemylevel") > 11 then
		KCreateEntity("Potion_Speed","potion_speed", 1, 0, 2, 0)
	else
		kactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Alchemy Level of atleast 12 to make this." )
	end
end
concommand.Add( "create_potion_speed", CreatePotionSpeed )

function CreatePotionJump()
	if kactivatorx:GetNWInt("alchemylevel") > 16 then
		KCreateEntity("Potion_Jump","potion_jump", 0, 0, 2, 1)
	else
		kactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Alchemy Level of atleast 17 to make this." )
	end
end
concommand.Add( "create_potion_jump", CreatePotionJump )

function CreatePotionArmour()
	if kactivatorx:GetNWInt("alchemylevel") > 21 then
		KCreateEntity("Potion_Armour","potion_armour", 2, 0, 2, 2)
	else
		kactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Alchemy Level of atleast 22 to make this." )
	end
end
concommand.Add( "create_potion_armour", CreatePotionArmour )

function KCreateEntity(name,item,weedsneeded,nightshadeneeded,arianeeded,mushroomneeded)
	weeds = 0
	nightshade = 0
	aria = 0
	mushroom = 0

	local kiteents = ents.FindInSphere(kitent:GetPos(),70)
	for k,v in pairs(kiteents) do
		if (weedsneeded > weeds) then
			if string.find(v:GetClass(),"resource_weed") then
				weeds = weeds + 1
				v:Remove()
			end
		end

		if (nightshadeneeded > nightshade) then
			if string.find(v:GetClass(),"resource_nightshade") then
				nightshade = nightshade + 1
				v:Remove()
			end
		end

		if (arianeeded > aria) then
			if string.find(v:GetClass(),"resource_aria") then
				aria = aria + 1
				v:Remove()
			end
		end

		if (mushroomneeded > mushroom) then
			if string.find(v:GetClass(),"resource_mushroom") then
				mushroom = mushroom + 1
				v:Remove()
			end
		end
	end

	if (weedsneeded <= weeds) and (nightshadeneeded <= nightshade) and (arianeeded <= aria) and (mushroomneeded <= mushroom) then
		kactivatorx:GiveItem( item, 1 )
		ShowTipPlayer(kactivatorx, 0, 4, "Created a "..name.."." )
		kactivatorx:SetNWInt("canuse", 1)
		kactivatorx:ConCommand("KAddExp")
	else
		kactivatorx:PrintMessage( HUD_PRINTTALK, "You don't have enough resources to make." )
	end
end

function KAddExp(kactivatorx)
	if kactivatorx:GetNWInt("alchemylevel") > 4 then
		leveladd = 15
	else
		leveladd = 20
	end

	local oldcexp = kactivatorx:GetNWInt("alchemyexp")
	randomgain = math.random(leveladd + 5, leveladd + 10)
	AlchemyLevelData[ kactivatorx:UniqueID() ][ "alchemyexp" ] = oldcexp + randomgain
	kactivatorx:SetNWInt( "alchemyexp", oldcexp + randomgain)
	if kactivatorx:GetNWInt("alchemyexp") > 99 then
		local oldcexp = kactivatorx:GetNWInt("alchemyexp")
		local oldclevel = kactivatorx:GetNWInt("alchemylevel")
		AlchemyLevelData[ kactivatorx:UniqueID() ][ "alchemyexp" ] = 0
		kactivatorx:SetNWInt( "alchemyexp", 0)

		AlchemyLevelData[ kactivatorx:UniqueID() ][ "alchemylevel" ] = oldclevel + 1
		kactivatorx:SetNWInt( "alchemylevel", oldclevel + 1)
		if kactivatorx:GetNWInt("alchemylevel") == 12 then
			iflevel = ""
		else
			iflevel = ""
		end
		newlevel = oldclevel + 1
		kactivatorx:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " alchemy!" .. iflevel )
	end
end
concommand.Add( "KAddExp", KAddExp )

function ENT:Use(activator,caller)
	kactivatorx = nil
	kactivatorx = activator
	if nextuse < CurTime() then
		umsg.Start("AlchemyMenu", activator)
		umsg.End()
		kitent = nil
		kitent = self.Entity
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