ENT.Base = "npc_base" 
ENT.Type = "ai"

ENT.PrintName		= "An Undead."
ENT.Author			= "Melombine, Rambo_6"
ENT.Information		= "A Infected zombie ripped from Redead."

ENT.Spawnable			= false
ENT.AdminSpawnable		= true
ENT.AutomaticFrameAdvance = true


/*---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
---------------------------------------------------------*/
function ENT:OnRemove()
end


/*---------------------------------------------------------
   Name: PhysicsCollide
   Desc: Called when physics collides. The table contains 
			data on the collision
---------------------------------------------------------*/
function ENT:PhysicsCollide( data, physobj )
end


/*---------------------------------------------------------
   Name: PhysicsUpdate
   Desc: Called to update the physics .. or something.
---------------------------------------------------------*/
function ENT:PhysicsUpdate( physobj )
end

/*---------------------------------------------------------
   Name: SetAutomaticFrameAdvance
   Desc: If you're not using animation you should turn this 
	off - it will save lots of bandwidth.
---------------------------------------------------------*/
function ENT:SetAutomaticFrameAdvance( bUsingAnim )

	self.AutomaticFrameAdvance = bUsingAnim

end 