ENT.Base = "base_ai" 
ENT.Type = "ai"

ENT.PrintName		= "Zombie Base"
ENT.Author			= "Rambo_6"
ENT.Information		= "sdasfawfafegas"
ENT.Category		= "A Zombie."

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

ENT.AutomaticFrameAdvance = true

function ENT:OnRemove()
end

function ENT:PhysicsCollide( data, physobj )
end

function ENT:PhysicsUpdate( physobj )
end

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end