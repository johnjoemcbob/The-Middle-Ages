AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/fountain.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity.nodupe = true
	local phys = self.Entity:GetPhysicsObject()
	nextuse = 0
	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Use(activator)
	if( CurTime() < nextuse ) then return; end
	nextuse = ( CurTime() + 2 );
	self.Entity:SetNWEntity("user", activator)
	local owner = self.Entity:GetNWEntity("owning_ent")
	local bowl = ents.Create("resource_aria")
	local bowlPos = self.Entity:GetPos()
	bowl:SetPos(Vector(bowlPos.x + 20, bowlPos.y, bowlPos.z + 50))
	bowl:SetNetworkedString("Owner", "Shared")
	bowl.nodupe = true
	bowl:Spawn()
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