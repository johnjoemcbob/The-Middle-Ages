AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/nayrbarr/anvil/anvil.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity.nodupe = true
	anvilent = self.Entity
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	nextuse = 0
end

function CreateShortCopper()
	ACreateEntity("Copper Short Sword", "sword_short_copper", 0, 0, 2)
end
concommand.Add( "create_sword_short_copper", CreateShortCopper )

function CreateShortIron()
	if aactivatorx:GetNWInt("smithinglevel") > 12 then
		ACreateEntity("Iron Short Sword", "sword_short_iron", 0, 2, 0)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 13 to make this." )
	end
end
concommand.Add( "create_sword_short_iron", CreateShortIron )

function CreateShortSteel()
	if aactivatorx:GetNWInt("smithinglevel") > 19 then
		ACreateEntity("Steel Short Sword", "sword_short_steel", 2, 1, 0)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 20 to make this." )
	end
end
concommand.Add( "create_sword_short_steel", CreateShortSteel )

function CreateLongCopper()
	if aactivatorx:GetNWInt("smithinglevel") > 17 then
		ACreateEntity("Copper Long Sword", "sword_long_copper", 0, 1, 2)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 18 to make this." )
	end
end
concommand.Add( "create_sword_long_copper", CreateLongCopper )

function CreateLongIron()
	if aactivatorx:GetNWInt("smithinglevel") > 24 then
		ACreateEntity("Iron Long Sword", "sword_long_iron", 1, 3, 0)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 25 to make this." )
	end
end
concommand.Add( "create_sword_long_iron", CreateLongIron )

function CreateLongSteel()
	if aactivatorx:GetNWInt("smithinglevel") > 35 then
		ACreateEntity("Steel Long Sword", "sword_long_steel", 4, 2, 0)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 36 to make this." )
	end
end
concommand.Add( "create_sword_long_steel", CreateLongSteel )

function CreateTwoHandedCopper()
	if aactivatorx:GetNWInt("smithinglevel") > 29 then
		ACreateEntity("Copper Two-handed Sword", "sword_twohanded_copper", 0, 3, 5)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 30 to make this." )
	end
end
concommand.Add( "create_sword_twohanded_copper", CreateTwoHandedCopper )

function CreateTwoHandedIron()
	if aactivatorx:GetNWInt("smithinglevel") > 41 then
		ACreateEntity("Iron Two-handed Sword", "sword_twohanded_iron", 3, 5, 0)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 42 to make this." )
	end
end
concommand.Add( "create_sword_twohanded_iron", CreateTwoHandedIron )

function CreateTwoHandedSteel()
	if aactivatorx:GetNWInt("smithinglevel") > 53 then
		ACreateEntity("Steel Two-handed Sword", "sword_twohanded_steel", 6, 2, 0)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 54 to make this." )
	end
end
concommand.Add( "create_sword_twohanded_steel", CreateTwoHandedSteel )

function CreateWarAxe()
	if aactivatorx:GetNWInt("smithinglevel") > 31 then
		ACreateEntity("War Axe", "war_axe", 3, 0)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 32 to make this." )
	end
end
concommand.Add( "create_war_axe", CreateWarAxe )

function CreateWarHammer()
	if aactivatorx:GetNWInt("smithinglevel") > 52 then
		ACreateEntity("War Hammer", "war_hammer", 5, 2, 0)
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 53 to make this." )
	end
end
concommand.Add( "create_war_hammer", CreateWarHammer )

function CreateArmourTemplar()
	--if aactivatorx:GetNWInt("smithinglevel") > 39 then
		ACreateEntity("Templar Armour","templar", 4, 8, 0)
	--else
	--	aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 40 to make this." )
	--end
end
concommand.Add( "create_armour_templar", CreateArmourTemplar )

function CreateArmourShieldRoman()
	--if aactivatorx:GetNWInt("smithinglevel") > 39 then
		ACreateEntity("Roman Shield", "shield_roman", 0, 8, 4)
	--else
	--	aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 40 to make this." )
	--end
end
concommand.Add( "create_armour_shield_roman", CreateArmourShieldRoman )

function CreateArmourShieldBuckler()
	--if aactivatorx:GetNWInt("smithinglevel") > 39 then
		ACreateEntity("Buckler","shield_buckler", 0, 2, 3)
	--else
	--	aactivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 40 to make this." )
	--end
end
concommand.Add( "create_armour_shield_buckler", CreateArmourShieldBuckler )

function ACreateEntity(name,item,steelneeded,ironneeded,copperneeded)
	steel = 0
	iron = 0
	copper = 0

	local anvileents = ents.FindInSphere(anvilent:GetPos(),70)
	for k,v in pairs(anvileents) do
		if (steelneeded > steel) then
			if string.find(v:GetClass(),"bar_steel") then
				steel = steel + 1
				v:Remove()
			end
		end

		if (ironneeded > iron) then
			if string.find(v:GetClass(),"bar_iron") then
				iron = iron + 1
				v:Remove()
			end
		end

		if (copperneeded > copper) then
			if string.find(v:GetClass(),"bar_copper") then
				copper = copper + 1
				v:Remove()
			end
		end
	end

	if (steelneeded <= steel) and (ironneeded <= iron) and (copperneeded <= copper) then
		aactivatorx:GiveItem( item, 1 )
		ShowTipPlayer(aactivatorx, 0, 4, "Created a "..name.."." )
		aactivatorx:SetNWInt("canuse", 1)
		aactivatorx:ConCommand("AAddExp")
		aactivatorx:EmitSound("sound/ambient/Blacksmith.wav")
	else
		aactivatorx:PrintMessage( HUD_PRINTTALK, "You don't have enough resources to make." )
	end
end

function AAddExp(aactivatorx)
	if aactivatorx:GetNWInt("canuse") == 1 then
		local ply = aactivatorx
		ply:SetNWInt("smithingexp", ply:GetNWInt("smithingexp") + math.random(10, 20))
		DataStoreSmithingExp(ply, ply:GetNWInt("smithingexp"))
		if aactivatorx:GetNWInt("smithingexp") > 99 then
			ply:SetNWInt("smithinglevel", ply:GetNWInt("smithinglevel") + 1)
			DataStoreSmithingLevel(ply, ply:GetNWInt("smithinglevel"))

			ply:SetNWInt("smithingexp", ply:GetNWInt("smithingexp") - 100)
			DataStoreSmithingExp(ply, ply:GetNWInt("smithingexp"))

			newlevel = oldslevel + 1
			aactivatorx:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Smithing!" )
		end
		aactivatorx:SetNWInt("canuse", 0)
	end
end
concommand.Add( "AAddExp", AAddExp )

function ENT:Use(activator,caller)
	aactivatorx = nil
	aactivatorx = activator
	if nextuse < CurTime() then
		umsg.Start("SmithingMenu", activator)
		umsg.End()
		anvilent = nil
		anvilent = self.Entity
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