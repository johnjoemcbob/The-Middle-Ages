include('shared.lua')

function SWEP:Think()
	local dlight = DynamicLight(self:EntIndex())
	local r, g, b, a = self:GetColor()
	dlight.Pos = self:GetPos()+(self:GetForward()*4)
	dlight.r = 205
	dlight.g = 102
	dlight.b = 0
	dlight.Brightness = 4
	dlight.Decay = 500 * 5
	dlight.Size = 500
	dlight.DieTime = CurTime() + 1
end 