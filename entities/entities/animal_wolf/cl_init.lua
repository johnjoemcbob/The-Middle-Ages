include( 'shared.lua' )

function ENT:Initialize()
	self.Entity:SetModelScale(Vector(0.8, 0.8, 0.8))
	timer.Simple(600,function() self.Entity:SetModelScale(Vector(1, 1, 1)) end)
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnRemove()

end
