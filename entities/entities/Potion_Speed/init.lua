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
		activator:GiveItem( "potion_speed", 1 )
		self:Remove()
		InventoryAddon:SendMessage( "Picked up a Speed Potion.", activator, false )
	else
		local ply = activator
		ws = 350
		rs = 450
		ply:SetWalkSpeed(ws)
		ply:SetRunSpeed(rs)
		ply:PrintMessage(HUD_PRINTTALK, "You used a Speed Potion")	
		self.Entity:Remove()
	end
end 