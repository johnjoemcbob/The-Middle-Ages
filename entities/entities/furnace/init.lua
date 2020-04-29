AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/nayrbarr/Smelter/smelter.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity.nodupe = true
	furnaceent = self.Entity
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	nextuse = 0
end

function CreateCopperBar()
	FCreateEntity("Copper Bar", "bar_copper", 0, 0, 2)
end
concommand.Add( "create_bar_copper", CreateCopperBar )

function CreateIronBar()
	if factivatorx:GetNWInt("smithinglevel") > 9 then
		FCreateEntity("Iron Bar", "bar_iron", 0, 2, 0)
	else
		factivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 10 to make this." )
	end
end
concommand.Add( "create_bar_iron", CreateIronBar )

function CreateSteelBar()
	if factivatorx:GetNWInt("smithinglevel") > 16 then
		FCreateEntity("Steel Bar", "bar_steel", 2, 3, 0)
	else
		factivatorx:PrintMessage( HUD_PRINTTALK, "You need a Smithing Level of atleast 17 to make this." )
	end
end
concommand.Add( "create_bar_steel", CreateSteelBar )

function FCreateEntity(name,item,tinneeded,ironneeded,copperneeded)
	tin = 0
	iron = 0
	copper = 0

	local furnaceents = ents.FindInSphere(furnaceent:GetPos(),70)
	for k,v in pairs(furnaceents) do
		if (tinneeded > tin) then
			if string.find(v:GetClass(),"resource_tin") then
				tin = tin + 1
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
	end

	if (tinneeded <= tin) and (ironneeded <= iron) and (copperneeded <= copper) then
		factivatorx:GiveItem( item, 1 )
		ShowTipPlayer(factivatorx, 0, 4, "Created a "..name.."." )
		factivatorx:SetNWInt("canuse", 1)
		factivatorx:ConCommand("FAddExp")
	else
		factivatorx:PrintMessage( HUD_PRINTTALK, "You don't have enough resources to make." )
	end
end

function FAddExp(factivatorx)
	local ply = factivatorx
	ply:SetNWInt("smithingexp", ply:GetNWInt("smithingexp") + math.random(10, 20))
	DataStoreSmithingExp(ply, ply:GetNWInt("smithingexp"))
	if factivatorx:GetNWInt("smithingexp") > 99 then
		ply:SetNWInt("smithinglevel", ply:GetNWInt("smithinglevel") + 1)
		DataStoreSmithingLevel(ply, ply:GetNWInt("smithinglevel"))

		ply:SetNWInt("smithingexp", ply:GetNWInt("smithingexp") - 100)
		DataStoreSmithingExp(ply, ply:GetNWInt("smithingexp"))

		newlevel = oldslevel + 1
		factivatorx:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Smithing!" )
	end
end
concommand.Add( "FAddExp", FAddExp )

function ENT:Use(activator,caller)
	factivatorx = nil
	factivatorx = activator
	if nextuse < CurTime() then
		umsg.Start("FurnaceMenu", activator)
		umsg.End()
		furnaceent = nil
		furnaceent = self.Entity
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