include( 'shared.lua' )

function ENT:Initialize()

	self.Emitter = ParticleEmitter( self:GetPos(), true )
	self.NextEmit = CurTime()

end


function ENT:Draw()

	self:DrawModel()

end


function ENT:OnRemove()

end

