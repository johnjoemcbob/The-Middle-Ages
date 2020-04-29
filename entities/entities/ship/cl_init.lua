include('shared.lua')

local EnterMessageAlpha = 0
LocalPlayerIsDrivingShuttle = false

function ShuttleLocalDrivingChanged(entity, name, oldval, newval)
	if newval == true and LocalPlayerIsDrivingShuttle == false then
		EnterMessageAlpha = 4
	end
	LocalPlayerIsDrivingShuttle = newval
end
hook.Add("InitPostEntity", "ShuttleInitAddProxy", function()
	LocalPlayer():SetNetworkedVarProxy( "isDriveShuttle", ShuttleLocalDrivingChanged )
end)

local Instructions = {
	"To move forward, click your forward key.",
	"To move backward, click your backward key.",
	"To steer, use your mouse.",
	"To zoom in, click your duck key.",
	"To zoom out, click your jump key."
}

function ShuttleDrawInfoOverlay()
	if EnterMessageAlpha > 0 then
		EnterMessageAlpha = EnterMessageAlpha - 0.01
		local tmsgA = math.Clamp(EnterMessageAlpha, 0, 1)
		for k,v in pairs(Instructions) do
			local individualsize = 25
			local totalsize = #Instructions*individualsize
			draw.WordBox(5, 50, (ScrH()/2) - (totalsize/2) + (individualsize*k), v, "Default", Color(200,150,0,128*tmsgA), Color(0,0,0,255*tmsgA) )
		end
	end
end
hook.Add("HUDPaint","ShuttleDrawInfoOverlay",ShuttleDrawInfoOverlay)

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:Think()	
	if LocalPlayerIsDrivingShuttle then
		if LocalPlayer():KeyDown(IN_JUMP) then
			LocalPlayer().sDistz = LocalPlayer().sDistz + 5
		end
		if LocalPlayer():KeyDown(IN_DUCK) then
			LocalPlayer().sDistz = LocalPlayer().sDistz - 5
		end
	end
end 