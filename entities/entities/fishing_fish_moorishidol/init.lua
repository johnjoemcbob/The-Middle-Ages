AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel( "models/props/prop_moorishidol.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	timer.Simple(340,function() self.Entity:TimedRemove() end)

	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:Use( activator, caller )
	if ( !activator:IsPlayer() ) then return false end
	activator:PrintMessage( HUD_PRINTTALK, "Ye Caught a Moorish Idol Fish!" )
	local oldfexp = activator:GetNWInt("fishingexp")
	randomgain = math.random(leveladd + 5, leveladd + 10)
	FishingLevelData[ activator:UniqueID() ][ "fishingexp" ] = oldfexp + randomgain
	activator:SetNWInt( "fishingexp", oldfexp + randomgain)

	if activator:GetNWInt("fishingexp") > 99 then
		local oldfexp = activator:GetNWInt("fishingexp")
		local oldflevel = activator:GetNWInt("fishinglevel")
		FishingLevelData[ activator:UniqueID() ][ "fishingexp" ] = 0
		activator:SetNWInt( "fishingexp", 0)
		FishingLevelData[ activator:UniqueID() ][ "fishinglevel" ] = oldflevel + 1
		activator:SetNWInt( "fishinglevel", oldflevel + 1)
		newlevel = oldflevel + 1
		activator:PrintMessage( HUD_PRINTTALK, "Well Done! You are now Level " .. newlevel .. " Fishing!" )
	end

	activator:GiveItem( "fish_moorishidol", 1 )
	self:Remove()
	ShowTipPlayer(activator, 0, 4, "Picked up a Moorish Idol Fish." )

	self.TheHook.HasCatch = nil
end 