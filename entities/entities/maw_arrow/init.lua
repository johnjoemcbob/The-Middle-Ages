AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/PopCan01a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	local phys = self.Entity:GetPhysicsObject()
	local trail = util.SpriteTrail(self.Entity, 0, Color(150,150,150,250), false, 2, 1, 1, 1/(15+1)*0.5, "trails/smoke.vmt")
	if phys and phys:IsValid() then 
		phys:Wake()
	end
	local ply = self.Entity:GetNWEntity("owning_ent")
	self.Time = CurTime()
	self.Fade = false
end

function ENT:Think()
	if self.Fade == true then
		self.Entity:SetColor(255,255,255,(255/3)*(self.Time - CurTime()))
		if CurTime() > self.Time then
			self.Entity:Remove()
		end
	end
end

function ENT:PhysicsCollide( data, physobj )  
	local ent = data.HitEntity
	if ent:IsNPC() then
		if data.HitEntity:Health() > 8 then
			data.HitEntity:SetHealth(data.HitEntity:Health() - 8)
		else
			data.HitEntity:Remove()
			if ent:GetClass() == "npc_zombie" then
				SetGlobalInt("zombiesdead", GetGlobalInt("zombiesdead") + 1)
			end
		end
	elseif not ent:IsPlayer() and self.Fade == false then
		local phys = self.Entity:GetPhysicsObject()
		phys:EnableMotion(false)
		self.Time = CurTime() + 3
		self.Entity:SetPos(self.Entity:GetPos() + self.Entity:GetForward() * 30)
		self.Fade = true
	else
		if data.HitEntity:Health() > 8 then
			data.HitEntity:SetHealth(data.HitEntity:Health() - 8)
		else
			data.HitEntity:Kill()
		end
	end
end 