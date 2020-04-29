include("shared.lua")

function ENT:Draw()
	self.Entity:DrawModel()
	cam.Start3D2D(self.Entity:GetPos()+self.Entity:GetRight() * 2,self.Entity:GetAngles()+Angle(0,0,90), 0.2)
	cam.End3D2D()
end