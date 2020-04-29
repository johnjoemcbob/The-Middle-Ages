AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake()
end

function ENT:Use( activator, caller )
	if ( !activator:IsPlayer() ) then return false end

	activator:GiveItem( self.InfoTable.UniqueID, 1 )
	self:Remove()
	InventoryAddon:SendMessage( "Picked up " .. self.InfoTable.Name .. ".", activator, false )
end 