AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/meathook001a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)

	local phys = self.Entity:GetPhysicsObject()
	self.Timer = false
	self.NextTimer = CurTime()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(1)
	end
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent = ents.Create("fishing_hook")
	ent:SetPos(tr.HitPos + Vector(0,0,24))
	ent:Spawn()
	ent:Activate()
	ent:SetName("Fishing Hook")
	return ent
end

function ENT:StartTouch( ent )
	if ( ent:GetClass() == "fishing_bait" and ent.IsAttached == nil and self.HasCatch == nil and self.HasBait == nil ) then
		ent:SetPos(self.Entity:LocalToWorld( Vector(0,-4,-18) )) -- Put it ON the hook.
		ent:SetMoveType(MOVETYPE_NONE)
		ent:SetSolid(SOLID_NONE)
		ent:SetParent(self.Entity)
		ent.IsAttached = true
		ent.Hook = self
		self.Bait = ent
		self.HasBait = true
	end
end 

function ENT:OnRemove()
	if self.Rod == nil then return end
	self.Rod.HasHook = nil
	self.Rod.Hook = nil
end

function ENT:Catch()
	self.Timer = false
	fishtype = math.random( 1, 5 )
	if fishtype == 1 then -- Tuna
		local fish = ents.Create("fishing_fish_tuna")
		fish:SetPos( self.Entity:LocalToWorld( Vector(0,-5,-18) ) )
		fish:SetAngles( self.Entity:GetAngles() )
		fish:SetParent(self.Entity)
		fish:Spawn()
		fish:Activate()
		fish.TheHook = self
		self.HasCatch = true
		self.HasBait = nil
		if (self.Bait) then
			self.Bait:Remove()
		end

	elseif fishtype == 2 then -- Damselfish
		local fish = ents.Create("fishing_fish_damsel")
		fish:SetPos( self.Entity:LocalToWorld( Vector(0,-5,-18) ) )
		fish:SetAngles( self.Entity:GetAngles() )
		fish:SetParent(self.Entity)
		fish:Spawn()
		fish:Activate()
		fish.TheHook = self
		self.HasCatch = true
		self.HasBait = nil
		if (self.Bait) then
			self.Bait:Remove()
		end

	elseif fishtype == 3 then -- Gold Fish
		local fish = ents.Create("fishing_fish_gold")
		fish:SetPos( self.Entity:LocalToWorld( Vector(0,-5,-18) ) )
		fish:SetAngles( self.Entity:GetAngles() )
		fish:SetParent(self.Entity)
		fish:Spawn()
		fish:Activate()
		fish.TheHook = self
		self.HasCatch = true
		self.HasBait = nil
		if (self.Bait) then
			self.Bait:Remove()
		end

	elseif fishtype == 4 then -- Moorish Idol
		local fish = ents.Create("fishing_fish_moorishidol")
		fish:SetPos( self.Entity:LocalToWorld( Vector(0,-5,-18) ) )
		fish:SetAngles( self.Entity:GetAngles() )
		fish:SetParent(self.Entity)
		fish:Spawn()
		fish:Activate()
		fish.TheHook = self
		self.HasCatch = true
		self.HasBait = nil
		if (self.Bait) then
			self.Bait:Remove()
		end

	elseif fishtype == 5 then -- Gramma Basslet
		local fish = ents.Create("fishing_fish_basslet")
		fish:SetPos( self.Entity:LocalToWorld( Vector(0,-5,-18) ) )
		fish:SetAngles( self.Entity:GetAngles() )
		fish:SetParent(self.Entity)
		fish:Spawn()
		fish:Activate()
		fish.TheHook = self
		self.HasCatch = true
		self.HasBait = nil
		if (self.Bait) then
			self.Bait:Remove()
		end
	end
end

function ENT:Think()
	self.Entity:NextThink(CurTime() + 1) -- Think only once a second instead of once per tick.
	
	if CurTime() >= self.NextTimer and self.Timer == true and self.Entity:WaterLevel() >= 3 then
		self.Timer = false
		if self.IsAttached == true then
			self:Catch()
		else
			if (self.Bait) then
				self.Bait:Remove()
			end
		end
		return true
	end	
	if ( self.Entity:WaterLevel() >= 3 and self.HasBait == true ) then
		if self.Timer == false  then
			self.Timer = true
			self.NextTimer = CurTime() + math.Rand(5,60)
		end
	end
	owner = nil
	for k, v in pairs(player.GetAll()) do
		if self.Entity:GetNWString("entowner") == v then
			owner = true
		end
	end
	if owner == true then else
		self.Entity:Remove()
	end
	return true
end 