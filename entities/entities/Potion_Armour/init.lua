AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/items/provisions/potions/life_potion.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Use(activator,caller)
	if (activator:GetWeapon("backpack") == activator:GetActiveWeapon()) then
		activator:GiveItem( "potion_armour", 1 )
		self:Remove()
		InventoryAddon:SendMessage( "Picked up an Armour Potion.", activator, false )
	else
		if activator:GetNWInt("wearingarmour") == 1 then
			activator:SetNWInt("armour", activator:GetNWInt("maxarmour"))
		else
			if activator:GetNWInt("armour") == 0 then
				local armouradd = math.random(50, 70)
				activator:SetNWInt("armour", armouradd)
				activator:SetNWInt("maxarmour", armouradd)
			else
				return
			end
		end

		activator:PrintMessage(HUD_PRINTTALK, "You used an Armour Potion")	
		self.Entity:Remove()
	end
end 