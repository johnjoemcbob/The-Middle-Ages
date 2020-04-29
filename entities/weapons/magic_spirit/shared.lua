if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Spirit Magic"
	SWEP.Author				= "NanoXax67"

	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.ViewModelFOV		= 70
	SWEP.IconLetter			= "x"

end

SWEP.Author   		= "Matthew"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions   = ""
SWEP.Spawnable      = false
SWEP.AdminSpawnable	= false

function SWEP:Think()
	local trace = self.Owner:GetEyeTrace()
	if (trace.HitNonWorld) then
		local iHealth = trace.Entity:Health()
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
			self.Owner:PrintMessage(4, tostring(iHealth))
		end
	end
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawWorldModel(false)
		self.Owner:DrawViewModel(false)
		self.NextPrimary = 0
		self.NextSecondary = 0
	end
end

function SWEP:PrimaryAttack()
	if CurTime() > self.NextPrimary then else return end
	if (SERVER) then
		local tr = self.Owner:EyeTrace( 80 )
		if tr.HitNonWorld and not tr.Entity:GetClass() == "prop_dynamic_override" then
			if self.Three == true then return end
			local entity = ents.Create("sent_spiritweapon")
			entity:SetNWString("Owner", self.Owner)
			entity.EntOwner = self.Owner
			entity:SetOwner(self.Owner)
			entity:SetModel(tr.Entity:GetModel())
			entity:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
			entity.nodupe = true
			entity:Spawn()

			if !self.Owner.Axes then
				self.Owner.Axes = {entity} 
			elseif self.Owner.Axes then
				table.insert(self.Owner.Axes,entity)
			end

			if self.Two == true then
				self.Three = true
				self.Third = entity
			elseif self.One == true then
				self.Two = true
				self.Second = entity
			else
				self.One = true
				self.First = entity
			end
		end
	end
	self.NextPrimary = CurTime() + 1
end

function SWEP:SecondaryAttack()
	if CurTime() > self.NextSecondary then else return end
	if self.Three == true then
		self.Third:Remove()
		self.Three = nil
		self.Third = nil
	elseif self.Two == true then
		self.Second:Remove()
		self.Two = nil
		self.Second = nil
	elseif self.One == true then
		self.First:Remove()
		self.One = nil
		self.First = nil
	end
	self.NextSecondary = CurTime() + 1
end

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.9 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 15	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= 10	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= 10	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "pistol"	--Ammo Type
-------------End Primary Fire Attributes------------------------------------
 
-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"
-------------End Secondary Fire Attributes--------------------------------