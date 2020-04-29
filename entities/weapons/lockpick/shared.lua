if (SERVER) then 
	AddCSLuaFile("shared.lua") 
end 

if (CLIENT) then 
	SWEP.PrintName = "Pickpocket" 
	SWEP.Slot = 5 
	SWEP.SlotPos = 1 
	SWEP.DrawAmmo = false 
	SWEP.DrawCrosshair = false 
end 

local meta = FindMetaTable( "Entity" ); 

local DoorTypes =
{
	"func_door", 
	"func_door_rotating", 
	"prop_door_rotating" 
}
  
function meta:IsDoor() 
	local class = self:GetClass(); 
	for k, v in pairs( DoorTypes ) do 
		if( v == class ) then return true end 
	end
	return false
end
-- Variables that are used on both client and server 

SWEP.Author					= "Capsup" 
SWEP.Instructions			= "Left click to pickpocket, rightclick to lockpick doors." 
SWEP.Contact				= "" 
SWEP.Purpose				= "" 

SWEP.ViewModelFOV			= 62 
SWEP.ViewModelFlip			= false 
SWEP.ViewModel				= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel				= "models/weapons/w_crowbar.mdl"

SWEP.Spawnable				= false 
SWEP.AdminSpawnable			= true 

SWEP.Sound					= Sound("weapons/iceaxe/iceaxe_swing1.wav") 

SWEP.Primary.ClipSize		= -1	-- Size of a clip 
SWEP.Primary.DefaultClip	= 0		-- Default number of bullets in a clip 
SWEP.Primary.Automatic		= false	-- Automatic/Semi Auto 
SWEP.Primary.Ammo			= "" 

SWEP.Secondary.ClipSize		= -1	-- Size of a clip 
SWEP.Secondary.DefaultClip	= -1	-- Default number of bullets in a clip 
SWEP.Secondary.Automatic	= false	-- Automatic/Semi Auto 
SWEP.Secondary.Ammo			= "" 

function SWEP:Initialize() 
	if (SERVER) then 
		self:SetWeaponHoldType("crowbar") 
	end 
	util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
	takelevel = 2
end 

function SWEP:PrimaryAttack() 
	self.BaseClass.ShootEffects( self ) 
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 ); 
	local trace = { } 
	trace.start = self.Owner:EyePos(); 
	trace.endpos = trace.start + self.Owner:GetAimVector() * 60; 
	trace.filter = self.Owner; 

	local tr = util.TraceLine( trace ); 
	if( tr.Entity:IsValid() && tr.Entity:IsPlayer() ) then 
		local CanI = math.random(1, 10)
		if CanI < takelevel then 
			takelevel = takelevel + 1
			if takelevel == 10 then
				takelevel = 9
			end
			local take = math.random(100, 350) 
			TakeGold( tr.Entity, "gold", take )
			GiveGold( self.Owner, "gold", take )
			self.Owner:PrintMessage( HUD_PRINTTALK, "Succeded.")
			self.Weapon:SetNextPrimaryFire( CurTime() + 8 )
		else
			self.Owner:PrintMessage( HUD_PRINTTALK, "Failed." )
			local caughtchance = math.random(1, 5)
			if caughtchance > 4 then
				PrintMessage( HUD_PRINTTALK, self.Owner:Nick() .. " is a pickpocket, Guards, Guards!")
			end
			self.Weapon:SetNextPrimaryFire( CurTime() + 4 )
		end 
	end  
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + .4)

	local trace = self.Owner:GetEyeTrace()
	local bullet = {}
	bullet.Num	= 1
	bullet.Src	= self.Owner:GetShootPos()
	bullet.Dir	= self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 1
	bullet.Damage = 0

	local e = trace.Entity
	if e ~= nil then
		if (trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 and not e:IsDoor() and not e:IsVehicle()) then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			self.Owner:FireBullets(bullet)
			self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(3, 5) .. ".wav")
		elseif (ValidEntity(e) and (trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 and (e:IsDoor() or e:IsVehicle()))) then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			self.Owner:FireBullets(bullet)
			self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(3, 5) .. ".wav")
			if (math.random(1, 100) < 6) then
				if trace.Entity.Fire then
					trace.Entity:Fire("unlock", "", .5)
					trace.Entity:Fire("open", "", .6)
				end
			end
		else
			self.Weapon:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
			self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
		end
	end
end 