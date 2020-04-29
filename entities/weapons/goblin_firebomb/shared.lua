AddCSLuaFile( "shared.lua" )

SWEP.PrintName				= "Goblin Fire Bomb"		
SWEP.Author					= "Matthew"
SWEP.Instructions			= "Left click to throw"
SWEP.Contact				= ""

SWEP.Slot					= 4
SWEP.SlotPos				= 2
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.ViewModel				= "models/weapons/v_Grenade.mdl"
SWEP.WorldModel				= "models/weapons/w_grenade.mdl"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= false

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "RPG_Round"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Draw()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:PrimaryAttack()
	if (SERVER) then
		if self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_MOVELEFT) or self.Owner:KeyDown(IN_MOVERIGHT) then return end
		local vShootPos = self.Owner:GetShootPos()
        local vShootAng = self.Owner:GetAimVector()
		ball = ents.Create( "prop_physics" )
        util.PrecacheModel("models/props_junk/Rock001a.mdl")
        ball:SetPos( vShootPos + Vector(0, 0, 10) )
        ball:SetAngles( vShootAng )
		ball:SetKeyValue("model", "models/props_junk/Rock001a.mdl")
		ball:SetKeyValue("rendercolor", "255 255 0");
		ball:Fire("addoutput","exploderadius 280",0)
		ball:Fire("addoutput","explodedamage 100",0) --Change this line to do more damage. 15 is default
		ball:Fire("physdamagescale","100",0)
		ball:Fire("addoutput","onhealthchanged !self,break",0)
		ball:SetOwner(self.Owner)
		ball:SetKeyValue("PerformanceMode",1)
		ball:Spawn()
        ball:Activate()
        local vForce = vShootAng * 100000
        local phys = ball:GetPhysicsObject()
        phys:ApplyForceCenter( vForce )
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		ball:SetPhysicsAttacker(self.Owner)
		local delay = 1
		self.Weapon:SetNextPrimaryFire(CurTime() + delay)
		self:TakePrimaryAmmo( 1 )
	end
end

function SWEP:IdleAnimation()
	self.Weapon:SendWeaponAnim(ACT_VM_IDLE) 
end

function SWEP:Initialize()
	if (CLIENT) then return end
	self:SetWeaponHoldType("grenade")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
end 