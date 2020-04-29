// Variables that are used on both client and server

SWEP.Author				= "Worshipper"
SWEP.Contact			= "Josephcadieux@hotmail.com"
SWEP.Purpose        	= "A Two-Handed Copper Sword."
SWEP.Instructions   	= "Primary to strike.\nHold Sprint and Secondary to drop the weapon."
SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_sword_silver.mdl"
SWEP.WorldModel			= "models/weapons/w_sword_silver.mdl"
SWEP.AnimPrefix			= "python"

SWEP.Base 				= "medieval_weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 1.5

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= true				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.RunArmOffset 		= Vector (0.3671, 0.1571, 5.7856)
SWEP.RunArmAngle	 		= Vector (-37.4833, 2.7476, 0)

SWEP.Sequence			= 0

SWEP.IdleDelay			= 0
SWEP.IdleApply			= false
SWEP.AllowIdleAnimation		= true

SWEP.Movement = false
SWEP.Attack = false

/*---------------------------------------------------------
   Name: SWEP:Initialize()
   Desc: Called when the weapon is first loaded.
---------------------------------------------------------*/
function SWEP:Initialize()
	if (SERVER) then
		self:SetWeaponHoldType(self.HoldType)
	end

	self.Owner:SetNetworkedBool("Movement", false)
	self.Owner:SetNetworkedBool("Attack", false)
end

/*---------------------------------------------------------
   Name: SWEP:Deploy()
---------------------------------------------------------*/
function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	self.Weapon:EmitSound("weapons/knife/knife_deploy1.wav", 50, 100)

	self:IdleAnimation(1)

	self.Owner:SetNetworkedBool("Movement", false)
	self.Owner:SetNetworkedBool("Attack", false)

	return true
end

/*---------------------------------------------------------
   Name: SWEP:EntsInSphereBack
   Desc: Is the entity face back to the player?
---------------------------------------------------------*/
function SWEP:EntsInSphereBack(pos, range)
	local ents = ents.FindInSphere(pos, range)
	for k, v in pairs(ents) do
		if v ~= self and v ~= self.Owner and (v:IsNPC() or v:IsPlayer()) and ValidEntity(v) and self:EntityFaceBack(v) then
			return true
		end
	end
	return false
end

/*---------------------------------------------------------
   Name: SWEP:EntityFaceBack
   Desc: Is the entity face back to the player?
---------------------------------------------------------*/
function SWEP:EntityFaceBack(ent)
	local angle = self.Owner:GetAngles().y - ent:GetAngles().y
	if angle < -180 then angle = 360 + angle end
	if angle <= 90 and angle >= -90 then return true end
	return false
end

/*---------------------------------------------------------
   Name: SWEP:EntsInSphereFront
   Desc: Is the entity face front to the player?
---------------------------------------------------------*/
function SWEP:EntsInSphereFront(pos, range)
	local ents = ents.FindInSphere(pos, range)
	for k, v in pairs(ents) do
		if v ~= self and v ~= self.Owner and (v:IsNPC() or v:IsPlayer()) and ValidEntity(v) and self:EntityFaceFront(v) then
			return true
		end
	end
	return false
end

/*---------------------------------------------------------
   Name: SWEP:EntityFaceFront
   Desc: Is the entity face front to the player?
---------------------------------------------------------*/
function SWEP:EntityFaceFront(ent)
	local angle = self.Owner:GetAngles().y - ent:GetAngles().y
	if angle < -180 then angle = 360 + angle end
	if angle > 90 or angle < -90 then return true end
	return false
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	if self.Owner:IsPlayer() then
		if self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_RELOAD) then return end
	end

	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	local flevel = self.Owner:GetNWInt("fightinglevel")
	if flevel > 69 then
		self.Owner:SetNetworkedBool("Attack", true)
		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("slash2"))

		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
		timer.Simple(self.Owner:GetViewModel():SequenceDuration(), function() if not self.Owner or not IsFirstTimePredicted() then return end self.Owner:SetNetworkedBool("Attack", false) end)

		timer.Simple(0.75, function() if not self.Owner or not IsFirstTimePredicted() then return end
			self.Weapon:ShootBullets( 30 )
		self.Owner:ViewPunch(Vector(-10, 2, 0)) end)
	else
		self.Owner:PrintMessage(HUD_PRINTTALK, "You need a Fighting Level of 70 to use this weapon.")
	end
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	if self.Owner:IsPlayer() then
		if self.Owner:KeyDown(IN_SPEED) then
			self.Owner:GiveItem( "sword_twohanded_copper", 1 )
			InventoryAddon:SendMessage( "You put your Copper Two-Handed Sword in your backpack.", self.Owner, false )
			self.Owner:StripWeapon( "sword_twohanded_copper" )
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:IdleAnimation()
   Desc: Are you seriously too stupid to understand the function by yourself?
---------------------------------------------------------*/
function SWEP:IdleAnimation(time)

	if not self.AllowIdleAnimation then return false end

	self.IdleApply = true
	self.ActionDelay = CurTime() + time
	self.IdleDelay = CurTime() + time
end

/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()
	if self.IdleDelay < CurTime() and self.IdleApply and self.Weapon:Clip1() > 0 then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()
		if self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		end
		self.IdleApply = false
	end

	// If you're running or if your weapon is holsted, the third person animation is going to change
	if not self.Owner:GetNetworkedBool("Attack") and not self.Owner:GetNetworkedBool("Movement") and self.Owner:KeyDown(IN_SPEED) and self.Owner:GetVelocity():Length() > 100 and self.Owner:OnGround() then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("run"))

		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())

		self.Owner:SetNetworkedBool("Movement", true)

		if (SERVER) then
			self:SetWeaponHoldType("normal")
		end
	elseif not self.Owner:GetNetworkedBool("Attack") and self.Owner:GetNetworkedBool("Movement") and (not self.Owner:KeyDown(IN_SPEED) or self.Owner:GetVelocity():Length() < 100 or not self.Owner:OnGround()) and (not self.Owner:KeyDown(IN_RELOAD)) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("idle"))

		self.Owner:SetNetworkedBool("Movement", false)

		if (SERVER) then
			self:SetWeaponHoldType(self.HoldType)
		end
	end
	self:NextThink(CurTime())
end 