local pScoreBoard = nil

function GM:CreateScoreboard()
	if ScoreBoard then
		ScoreBoard:Remove()
		ScoreBoard = nil
	end

	pScoreBoard = vgui.Create("ScoreBoard")
end

function GM:ScoreboardShow()
	GAMEMODE.ShowScoreboard = true
	gui.EnableScreenClicker(true)

	if not pScoreBoard then
		self:CreateScoreboard()
	end

	pScoreBoard:SetVisible(true)
	pScoreBoard:UpdateScoreboard(true)
end

function GM:ScoreboardHide()
	GAMEMODE.ShowScoreboard = false
	gui.EnableScreenClicker(false)
	pScoreBoard:SetVisible(false)
end

--_________________
-- Player_frame.lua
--_________________

local PANEL = {}

function PANEL:Init()
	self.pnlCanvas 	= vgui.Create("Panel", self)
	self.YOffset = 0
end

function PANEL:GetCanvas()
	return self.pnlCanvas
end

function PANEL:OnMouseWheeled(dlta)
	local MaxOffset = self.pnlCanvas:GetTall() - self:GetTall()

	if MaxOffset > 0 then
		self.YOffset = math.Clamp(self.YOffset + dlta * -100, 0, MaxOffset)
	else
		self.YOffset = 0
	end

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	self.pnlCanvas:SetPos(0, self.YOffset * -1)
	self.pnlCanvas:SetSize(self:GetWide(), self.pnlCanvas:GetTall())
end

vgui.Register("PlayerFrame", PANEL, "Panel")

--____________________
-- Player_infocard.lua
--____________________

local PANEL = {}

function PANEL:Init()
	self.InfoLabels = {}
	self.InfoLabels[ 1 ] = {}
	self.InfoLabels[ 2 ] = {}
end

function PANEL:SetInfo(column, k, v)
	if not v or v == "" then v = "N/A" end

	if not self.InfoLabels[ column ][ k ] then
		self.InfoLabels[ column ][ k ] = {}
		self.InfoLabels[ column ][ k ].Key 	= vgui.Create("DLabel", self)
		self.InfoLabels[ column ][ k ].Value 	= vgui.Create("DLabel", self)
		self.InfoLabels[ column ][ k ].Key:SetText(k)
		self:InvalidateLayout()
	end

	self.InfoLabels[ column ][ k ].Value:SetText(v)
	return true
end

function PANEL:SetPlayer(ply)
	self.Player = ply
	self:UpdatePlayerData()
end

function PANEL:UpdatePlayerData()
	if not self.Player then return end

	self:SetInfo(1, "Props:", self.Player:GetCount("props") + self.Player:GetCount("ragdolls") + self.Player:GetCount("effects"))

	self:SetInfo(2, "Money:", self.Player:GetNWInt("gold"))

	self:InvalidateLayout()
end

function PANEL:ApplySchemeSettings()
	for _k, column in pairs(self.InfoLabels) do
		for k, v in pairs(column) do
			v.Key:SetFGColor(0, 0, 0, 100)
			v.Value:SetFGColor(0, 70, 0, 200)
		end
	end
end

function PANEL:Think()
	if self.PlayerUpdate and self.PlayerUpdate > CurTime() then return end

	self.PlayerUpdate = CurTime() + 0.25
	self:UpdatePlayerData()
end

function PANEL:PerformLayout()
	local x = 5

	for colnum, column in pairs(self.InfoLabels) do
		local y = 0
		local RightMost = 0

		for k, v in pairs(column) do
			v.Key:SetPos(x, y)
			v.Key:SizeToContents()
			v.Value:SetPos(x + 70 , y)
			v.Value:SizeToContents()
			y = y + v.Key:GetTall() + 2
			RightMost = math.max(RightMost, v.Value.x + v.Value:GetWide())
		end
		x = x + 300
	end

end

function PANEL:Paint()
	return true
end

vgui.Register("ScorePlayerInfoCard", PANEL, "Panel")

--_______________
-- Player_row.lua
--_______________

surface.CreateFont("ScoreboardPlayerName",
{
	font = "coolvetica", 
	size = 20, 
	weight = 500, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
})

local texGradient = surface.GetTextureID("gui/center_gradient")
local texRatings = {}

texRatings[ 'none' ] 		= surface.GetTextureID("gui/silkicons/user")
texRatings[ 'smile' ] 		= surface.GetTextureID("gui/silkicons/emoticon_smile")
texRatings[ 'bad' ] 		= surface.GetTextureID("gui/silkicons/exclamation")
texRatings[ 'love' ] 		= surface.GetTextureID("gui/silkicons/heart")
texRatings[ 'artistic' ] 	= surface.GetTextureID("gui/silkicons/palette")
texRatings[ 'star' ] 		= surface.GetTextureID("gui/silkicons/star")
texRatings[ 'builder' ] 	= surface.GetTextureID("gui/silkicons/wrench")

surface.GetTextureID("gui/silkicons/emoticon_smile")
local PANEL = {}

/*---------------------------------------------------------
Name: Paint
---------------------------------------------------------*/
function PANEL:Paint()
	if not self.Player then return end

	local color = team.GetColor(self.Player:Team())

	if self.Armed then
		color = team.GetColor(self.Player:Team())
	end

	if self.Selected then
		color = team.GetColor(self.Player:Team())
	end

	if self.Player:Team() == TEAM_CONNECTING then
		color = Color(200, 120, 50, 255)
	elseif self.Player:IsAdmin() then
		color = team.GetColor(self.Player:Team())
	end

	if self.Open or self.Size != self.TargetSize then
		draw.RoundedBox(4, 0, 16, self:GetWide(), self:GetTall() - 16, color)
		draw.RoundedBox(4, 2, 16, self:GetWide()-4, self:GetTall() - 16 - 2, Color(250, 250, 245, 255))

		surface.SetTexture(texGradient)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(2, 16, self:GetWide()-4, self:GetTall() - 16 - 2)
	end

	draw.RoundedBox(4, 0, 0, self:GetWide(), 24, color)

	surface.SetTexture(texGradient)
	surface.SetDrawColor(255, 255, 255, 50)
	surface.DrawTexturedRect(0, 0, self:GetWide(), 24)

	surface.SetTexture(self.texRating)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(4, 4, 16, 16)

	return true
end

/*---------------------------------------------------------
Name: UpdatePlayerData
---------------------------------------------------------*/
function PANEL:SetPlayer(ply)
	if not ply then return end
	self.Player = ply
	self.infoCard:SetPlayer(ply)
	self:UpdatePlayerData()
end

function PANEL:CheckRating(name, count)
	if not self.Player then return end

	if self.Player:GetNWInt("Rating."..name, 0) > count then
		count = self.Player:GetNWInt("Rating."..name, 0)
		self.texRating = texRatings[ name ]
	end

	return count
end

/*---------------------------------------------------------
Name: UpdatePlayerData
---------------------------------------------------------*/
function PANEL:UpdatePlayerData()
	if not self.Player then return end

	self.lblName:SetText(self.Player:GetNWString("name"))
	self.lblName:SizeToContents()
	self.lblJob:SetText(self.Player:GetNWString("job"))
	self.lblJob:SizeToContents()
	self.lblSex:SetText(self.Player:GetNWString("sex"))
	self.lblSex:SizeToContents()
	self.lblRace:SetText(self.Player:GetNWString("race"))
	self.lblRace:SizeToContents()
	self.lblFrags:SetText(self.Player:Frags())
	self.lblDeaths:SetText(self.Player:Deaths())
	self.lblPing:SetText(self.Player:Ping())

	-- Work out what icon to draw
	self.texRating = surface.GetTextureID("gui/silkicons/emoticon_smile")

	self.texRating = texRatings[ 'none' ]
	local count = 0

	count = self:CheckRating('smile', count)
	count = self:CheckRating('love', count)
	count = self:CheckRating('artistic', count)
	count = self:CheckRating('star', count)
	count = self:CheckRating('builder', count)
	count = self:CheckRating('bad', count)
end

/*---------------------------------------------------------
Name: PerformLayout
---------------------------------------------------------*/
function PANEL:Init()
	self.Size = 24
	self:OpenInfo(false)
	self.infoCard = vgui.Create("ScorePlayerInfoCard", self)
	self.lblName = vgui.Create("DLabel", self)
	self.lblJob = vgui.Create("DLabel", self)
	self.lblSex = vgui.Create("DLabel", self)
	self.lblRace = vgui.Create("DLabel", self)
	self.lblFrags = vgui.Create("DLabel", self)
	self.lblDeaths = vgui.Create("DLabel", self)
	self.lblPing = vgui.Create("DLabel", self)

	-- If you don't do this it'll block your clicks
	self.lblName:SetMouseInputEnabled(false)
	self.lblJob:SetMouseInputEnabled(false)
	self.lblSex:SetMouseInputEnabled(false)
	self.lblRace:SetMouseInputEnabled(false)
	self.lblFrags:SetMouseInputEnabled(false)
	self.lblDeaths:SetMouseInputEnabled(false)
	self.lblPing:SetMouseInputEnabled(false)
end

/*---------------------------------------------------------
Name: PerformLayout
---------------------------------------------------------*/
function PANEL:ApplySchemeSettings()
	self.lblName:SetFont("ScoreboardPlayerName")
	self.lblJob:SetFont("ScoreboardPlayerName")
	self.lblSex:SetFont("ScoreboardPlayerName")
	self.lblRace:SetFont("ScoreboardPlayerName")
	self.lblFrags:SetFont("ScoreboardPlayerName")
	self.lblDeaths:SetFont("ScoreboardPlayerName")
	self.lblPing:SetFont("ScoreboardPlayerName")

	self.lblName:SetFGColor(color_white)
	self.lblJob:SetFGColor(color_white)
	self.lblSex:SetFGColor(color_white)
	self.lblRace:SetFGColor(color_white)
	self.lblFrags:SetFGColor(color_white)
	self.lblDeaths:SetFGColor(color_white)
	self.lblPing:SetFGColor(color_white)
end

/*---------------------------------------------------------
Name: PerformLayout
---------------------------------------------------------*/
function PANEL:DoClick()
	if self.Open then
		surface.PlaySound("ui/buttonclickrelease.wav")
	else
		surface.PlaySound("ui/buttonclick.wav")
	end

	self:OpenInfo(not self.Open)
end

/*---------------------------------------------------------
Name: PerformLayout
---------------------------------------------------------*/
function PANEL:OpenInfo(bool)
	if bool then
		self.TargetSize = 150
	else
		self.TargetSize = 24
	end

	self.Open = bool
end

/*---------------------------------------------------------
Name: PerformLayout
---------------------------------------------------------*/
function PANEL:Think()
	if self.Size != self.TargetSize then
		self.Size = math.Approach(self.Size, self.TargetSize, (math.abs(self.Size - self.TargetSize) + 1) * 10 * FrameTime())
		self:PerformLayout()
		SCOREBOARD:InvalidateLayout()
		-- self:GetParent():InvalidateLayout()
	end

	if not self.PlayerUpdate or self.PlayerUpdate < CurTime() then
		self.PlayerUpdate = CurTime() + 0.5
		self:UpdatePlayerData()
	end
end

/*---------------------------------------------------------
Name: PerformLayout
---------------------------------------------------------*/
function PANEL:PerformLayout()
	self:SetSize(self:GetWide(), self.Size)
	self.lblName:SizeToContents()
	self.lblName:SetPos(24, 2)

	local COLUMN_SIZE = 50

	self.lblPing:SetPos(self:GetWide() - COLUMN_SIZE * 1, 0)
	self.lblDeaths:SetPos(self:GetWide() - COLUMN_SIZE * 2, 0)
	self.lblFrags:SetPos(self:GetWide() - COLUMN_SIZE * 3, 0)
	self.lblJob:SetPos(self:GetWide() - COLUMN_SIZE * 7, 1)
	self.lblSex:SetPos(self:GetWide() - COLUMN_SIZE * 9, 1)
	self.lblRace:SetPos(self:GetWide() - COLUMN_SIZE * 11, 1)

	if self.Open or self.Size != self.TargetSize then
		self.infoCard:SetVisible(true)
		self.infoCard:SetPos(4, self.lblName:GetTall() + 10)
		self.infoCard:SetSize(self:GetWide() - 8, self:GetTall() - self.lblName:GetTall() - 10)
	else
		self.infoCard:SetVisible(false)
	end
end

/*---------------------------------------------------------
Name: PerformLayout
---------------------------------------------------------*/
function PANEL:HigherOrLower(row)
	if not row.Player or not self.Player then return false end

	if self.Player:Team() == TEAM_CONNECTING then return false end
	if row.Player:Team() == TEAM_CONNECTING then return true end

	if self.Player:Frags() == row.Player:Frags() then
		return self.Player:Deaths() < row.Player:Deaths()
	end

	return self.Player:Frags() > row.Player:Frags()
end

vgui.Register("ScorePlayerRow", PANEL, "Button")

--_______________
-- Scoreboard.lua
--_______________

SetGlobalString("servertype", "Listen")
surface.CreateFont("ScoreboardHeader",
{
	font = "coolvetica", 
	size = 32, 
	weight = 500, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
})
surface.CreateFont("ScoreboardSubtitle",
{
	font = "coolvetica", 
	size = 20, 
	weight = 500, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
})

local texGradient = surface.GetTextureID("gui/center_gradient")

local PANEL = {}

function PANEL:Init()
	SCOREBOARD = self

	self.Hostname = vgui.Create("DLabel", self)
	self.Hostname:SetText(GetGlobalString("ServerName"))

	self.Description = vgui.Create("DLabel", self)
	self.Description:SetText("Made by Matt with help from The Maw, J!m, MoordacT, Stevo, DJ Zybez and Aaron")

	self.PlayerFrame = vgui.Create("PlayerFrame", self)

	self.PlayerRows = {}

	self:UpdateScoreboard()

	-- Update the scoreboard every 1 second
	timer.Create("ScoreboardUpdater", 1, 0, self.UpdateScoreboard, self)

	self.lblJob = vgui.Create("DLabel", self)
	self.lblJob:SetText("Job")

	self.lblSex = vgui.Create("DLabel", self)
	self.lblSex:SetText("Sex")

	self.lblRace = vgui.Create("DLabel", self)
	self.lblRace:SetText("Race")

	self.lblPing = vgui.Create("DLabel", self)
	self.lblPing:SetText("Ping")

	self.lblKills = vgui.Create("DLabel", self)
	self.lblKills:SetText("Kills")

	self.lblDeaths = vgui.Create("DLabel", self)
	self.lblDeaths:SetText("Deaths")
end

function PANEL:AddPlayerRow(ply)
	local button = vgui.Create("ScorePlayerRow", self.PlayerFrame:GetCanvas())
	button:SetPlayer(ply)
	self.PlayerRows[ ply ] = button
end

function PANEL:GetPlayerRow(ply)
	return self.PlayerRows[ ply ]
end

function PANEL:Paint()
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(255, 255, 255, 98))
	surface.SetTexture(texGradient)
	surface.SetDrawColor(50, 50, 50, 50)
	surface.DrawTexturedRect(0, 0, self:GetWide(), self:GetTall())

	-- White Inner Box
	draw.RoundedBox(4, 4, self.Description.y - 4, self:GetWide() - 8, self:GetTall() - self.Description.y - 4, Color(0, 0, 0, 98))
	surface.SetTexture(texGradient)
	surface.SetDrawColor(255, 255, 255, 50)
	surface.DrawTexturedRect(4, self.Description.y - 4, self:GetWide() - 8, self:GetTall() - self.Description.y - 4)

	-- Sub Header
	draw.RoundedBox(4, 5, self.Description.y - 3, self:GetWide() - 10, self.Description:GetTall() + 5, Color(0, 0, 0, 200))
	surface.SetTexture(texGradient)
	surface.SetDrawColor(0, 0, 0, 50)
	surface.DrawTexturedRect(4, self.Description.y - 4, self:GetWide() - 8, self.Description:GetTall() + 8)
end

function PANEL:PerformLayout()
	self:SetSize(800, ScrH() * 0.95)
	self:SetPos((ScrW() - self:GetWide()) / 2, (ScrH() - self:GetTall()) / 2)

	self.Hostname:SizeToContents()
	self.Hostname:SetPos(16, 16)

	self.Description:SizeToContents()
	self.Description:SetPos(16, 64)

	self.PlayerFrame:SetPos(5, self.Description.y + self.Description:GetTall() + 20)
	self.PlayerFrame:SetSize(self:GetWide() - 10, self:GetTall() - self.PlayerFrame.y - 10)

	local y = 0

	local PlayerSorted = {}

	for k, v in pairs(self.PlayerRows) do
		table.insert(PlayerSorted, v)
	end

	table.sort(PlayerSorted, function (a , b) return a:HigherOrLower(b) end)

	for k, v in ipairs(PlayerSorted) do
		v:SetPos(0, y)
		v:SetSize(self.PlayerFrame:GetWide(), v:GetTall())

		self.PlayerFrame:GetCanvas():SetSize(self.PlayerFrame:GetCanvas():GetWide(), y + v:GetTall())
		y = y + v:GetTall() + 1
	end

	self.Hostname:SetText(GetGlobalString("ServerName"))

	self.lblPing:SizeToContents()
	self.lblKills:SizeToContents()
	self.lblDeaths:SizeToContents()
	self.lblJob:SizeToContents()
	self.lblSex:SizeToContents()
	self.lblRace:SizeToContents()

	self.lblPing:SetPos(self:GetWide() - 50 - self.lblPing:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
	self.lblDeaths:SetPos(self:GetWide() - 50*2 - self.lblDeaths:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
	self.lblKills:SetPos(self:GetWide() - 50*3 - self.lblKills:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
	self.lblJob:SetPos(self:GetWide() - 50*7 - self.lblJob:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
	self.lblSex:SetPos(self:GetWide() - 50*9 - self.lblSex:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
	self.lblRace:SetPos(self:GetWide() - 50*11 - self.lblRace:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3)
end

function PANEL:ApplySchemeSettings()
	self.Hostname:SetFont("ScoreboardHeader")
	self.Description:SetFont("ScoreboardSubtitle")

	self.Hostname:SetFGColor(Color(0, 0, 0, 200))
	self.Description:SetFGColor(color_white)

	self.lblPing:SetFont("DefaultSmall")
	self.lblKills:SetFont("DefaultSmall")
	self.lblDeaths:SetFont("DefaultSmall")
	self.lblJob:SetFont("DefaultSmall")
	self.lblSex:SetFont("DefaultSmall")
	self.lblRace:SetFont("DefaultSmall")

	self.lblPing:SetFGColor(Color(0, 0, 0, 255))
	self.lblKills:SetFGColor(Color(0, 0, 0, 255))
	self.lblDeaths:SetFGColor(Color(0, 0, 0, 255))
	self.lblJob:SetFGColor(Color(0, 0, 0, 255))
	self.lblSex:SetFGColor(Color(0, 0, 0, 255))
	self.lblRace:SetFGColor(Color(0, 0, 0, 255))
end

function PANEL:UpdateScoreboard(force)
	if not force then return end

	for k, v in pairs(self.PlayerRows) do
		if not k then
			v:Remove()
			self.PlayerRows[ k ] = nil
		end
	end

	local PlayerList = player.GetAll()
	for id, pl in pairs(PlayerList) do
		if not self:GetPlayerRow(pl) then
			self:AddPlayerRow(pl)
		end
	end

	-- Always invalidate the layout so the order gets updated
	self:InvalidateLayout()
end
vgui.Register("ScoreBoard", PANEL, "Panel") 