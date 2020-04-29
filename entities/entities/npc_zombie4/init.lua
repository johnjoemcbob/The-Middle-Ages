AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

ENT.SpawnRagdollOnDeath = true
ENT.BloodType = "red"
ENT.AnimScale = 3
ENT.Damage = 5
ENT.Death = {"runner/death1.wav", "runner/death2.wav"}
ENT.Taunt = {"runner/alert1.wav","runner/alert2.wav"}
ENT.Attack = {"runner/attack.wav","npc/attack2.wav"}
ENT.MeleeAnims = {"swing"}

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 20

	local ent = ents.Create( "npc_zombie3" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Initialize()
	self:SetModel( "models/undead/undead.mdl" )
	util.PrecacheSound("runner/stalk2.wav")
	util.PrecacheSound("runner/stalk.wav")

	self:SetHullType( HULL_HUMAN );
	self:SetHullSizeNormal();

	self:SetSolid( SOLID_BBOX ) 
	self:SetMoveType( MOVETYPE_STEP )

	self:CapabilitiesAdd( CAP_MOVE_GROUND | CAP_ANIMATEDFACE | CAP_TURN_HEAD | CAP_AIM_GUN | CAP_OPEN_DOORS )

	self:SetMaxYawSpeed( 5000 )

	self:SetHealth ( 500 )
end

function ENT:SelectSchedule()
	local schdChase = ai_schedule.New( "AIFighter Chase" ) //creates the schedule used for this npc

	schdChase:AddTask( "FindEnemy", { Radius = 10000000 } )
	schdChase:EngTask( "TASK_GET_PATH_TO_ENEMY", 0 )
    schdChase:EngTask( "TASK_RUN_PATH_TIMED", 0.1 )
    schdChase:EngTask( "TASK_WAIT", 0.1 )

	local close = false
	local tbl = player.GetAll()
	for k,v in pairs(tbl) do
		if v:GetPos():Distance(self:GetPos()) < 75 then
			close = true
		end
	end

	if close then
		schdChase:EngTask( "TASK_STOP_MOVING", 			0 )
		schdChase:EngTask( "TASK_FACE_ENEMY", 			0 )
		schdChase:AddTask( "PlaySequence", 				{ Name = "swing", Speed = 3 } )
	end

	self:StartSchedule( schdChase ) 
end 