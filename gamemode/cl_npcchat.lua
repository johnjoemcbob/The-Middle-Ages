local NpcTalk = {}
surface.CreateFont("NPCTextFont",
{
	font = "akbar", 
	size = 18, 
	weight = 1000, 
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

function NpcTalk:Init()
	local W,H = ScrW()-20, 200
	self:SetSize(W, H)
	self:SetPos(10, 10)
	self:SetAlpha(255)

	self.TalkArea = vgui.Create("DPanelList", self)
	self.TalkArea:EnableHorizontal(false)
	self.TalkArea:EnableVerticalScrollbar(true)
	self.TalkArea:SetPadding(5)

	self.TalkBubble = vgui.Create("DPanelList", self)
	self.TalkBubble:EnableHorizontal(false)
	self.TalkBubble:EnableVerticalScrollbar(true)

	self.Responses = vgui.Create("DPanelList", self)
	self.Responses:EnableHorizontal(false)
	self.Responses:EnableVerticalScrollbar(true)
	self.Responses:SetPadding(10)

	self.PlayerText = {}
	self.PlayerResponses = {}
end

function NpcTalk:PerformLayout()
	self.TalkArea:SetPos(5,5)
	self.TalkArea:SetSize(self:GetWide()+2,((self:GetTall()-15)*.5)-5)
	--self.TalkArea:Center()
	self.TalkBubble:SetPos(5,(self:GetTall()-15*.5+10))
	self.TalkBubble:SetSize((self:GetTall()-15)*.5,(self:GetTall()-15)*.5)
	self.Responses:SetPos(((self:GetTall()-15)*.5)+10,(self:GetTall()-15)*.5+7)
	--self.Responses:SetPos(ScrH()/2
	self.Responses:SetSize((self:GetWide()-((self:GetTall()-15)*.5))-20,(self:GetTall()-15)*.5)
end

function NpcTalk:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(0,0,0,155))
	local x, y = self.TalkArea:GetPos()

	function self.TalkArea:Paint()
		return true
	end

	draw.RoundedBox(10,x-1,y-1.5,self.TalkArea:GetWide()-10,self.TalkArea:GetTall()-1,Color(100,100,100,155))

	function self.Responses:Paint()
		return true
	end

	x, y = self.Responses:GetPos()
	draw.RoundedBox(10,x+1,y-7,self.Responses:GetWide()+6,self.Responses:GetTall()+12,Color(100,100,100,155))
end

function NpcTalk:AddText(txt)
	local nLbl = vgui.Create("DLabel")
	nLbl:SetText(txt)
	--nLbl:SetFont("NPCTextFont")
	nLbl:SizeToContents()
	self.TalkArea:AddItem(nLbl)
	table.insert(self.PlayerText,nLbl)
end

function NpcTalk:ClearText()
	for k,v in pairs(self.PlayerText) do
		v:Remove()
	end
end

function NpcTalk:AddPlayerOption(txt, func)
	local nLbl = vgui.Create("DButton")
	nLbl:SetText(txt)
	nLbl.DoClick = func
	self.Responses:AddItem(nLbl)
	table.insert(self.PlayerResponses, nLbl)
end

function NpcTalk:ClearOptions()
	for k,v in pairs(self.PlayerResponses)do
		v:Remove()
	end
end

function NpcTalk:ClearAll()
	self:ClearText()
	self:ClearOptions()
	self.Responses:Clear()
	self.TalkArea:Clear()
end
vgui.Register("NpcChat", NpcTalk)

function BarneyChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function Dead()
		talk:ClearAll()
		talk:AddText("Really?\nNo! I don't believe you! I'm going to wait here for a while longer!")
		talk:AddPlayerOption("Suit yourself", CloseChat)
	end

	local function BecomeInnKeeper()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomeinnkeeper" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function InnKeeper()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeInnKeeper)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function BuyMead()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_buymead" )
	end

	local function Mead()
		talk:ClearAll()
		talk:AddText("That'll be 3 Gold.")
		talk:AddPlayerOption("Here you are.", BuyMead)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function DeclineStrangeNoises()
		talk:ClearAll()
		talk:AddText("Oh well, maybe next time?")
		talk:AddPlayerOption("Yes, maybe.", CloseChat)
	end

	local function AcceptStrangeNoises()
		LocalPlayer():ConCommand( "mrp_strangenoises" )
		CloseChat()
	end

	local function DeclineDefendFelrendor()
		talk:ClearAll()
		talk:AddText("Hurry back!")
		talk:AddPlayerOption("Will do.", CloseChat)
	end

	local function AcceptDefendFelrendor()
		LocalPlayer():ConCommand( "mrp_spawnundead" )
		chat.AddText(
		Color(255, 103, 239), "Inn Keeper", Color(255,255,255), ": I've managed to close the gates, but I don't know how long they'll hold - be ready!")
		CloseChat()
	end

	local function StrangeNoises()
		talk:ClearAll()
		talk:AddText("Yeah, last night I kept hearing strange noises coming from the graveyard, could you check it out for me?")
		talk:AddPlayerOption("Sure.", AcceptStrangeNoises)
		talk:AddPlayerOption("Sorry, I don't have time right now.", CloseChat)
	end

	local function UndeadArmy()
		talk:ClearAll()
		talk:AddText("Yes, I recently recieved warning of an Undead army approaching, can you help us?\n(Your screen will go black and you will be unable to move for 3 seconds, allowing Barney time to go hide.)")
		talk:AddPlayerOption("I am ready.", AcceptDefendFelrendor)
		talk:AddPlayerOption("I need more time.", DeclineDefendFelrendor)
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("Hello there, care for a bottle of mead after a long day's work?\nSay, I don't suppose you could check out these strange noises I keep hearing from the graveyard?\nOr help defend the town from the Undead?")
	if LocalPlayer():Team() == 15 then
		talk:AddPlayerOption("I no longer wish to be a Inn Keeper.", InnKeeper)
	else
		talk:AddPlayerOption("Can you teach me to be a Inn Keeper?", InnKeeper)
	end
	talk:AddPlayerOption("Strange noises?", StrangeNoises)
	talk:AddPlayerOption("Mead, please.", Mead)
	talk:AddPlayerOption("An army?", UndeadArmy)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("InnKeeperChatMenu", BarneyChat)

function KleinerChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomeSmith()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomeblacksmith" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Smith()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("I am.", BecomeSmith)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function Buy()
		CloseChat()
		LocalPlayer():ConCommand( "+buysmithmenu" )
	end

	local function Sell()
		CloseChat()
		LocalPlayer():ConCommand( "+sellsmithmenu" )
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("Hello there. Do you want to buy or sell smithing and mining equipment?")
	if LocalPlayer():Team() == 10 then
		talk:AddPlayerOption("I no longer wish to be a Blacksmith.", Smith)
	else
		talk:AddPlayerOption("Can you teach me to be a Blacksmith?", Smith)
	end
	talk:AddPlayerOption("What do you sell?", Buy)
	talk:AddPlayerOption("Can I sell you my items?", Sell)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("SmithChatMenu", KleinerChat)

function BreenChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function GiveFish()
		CloseChat()
		chat.AddText(Color(100, 200, 255), "Harbour Master", Color(255,255,255), ": Thank you.")
		LocalPlayer():ConCommand( "mrp_givefish" )
	end

	local function GiveLetter()
		CloseChat()
		chat.AddText(Color(100, 200, 255), "Harbour Master", Color(255,255,255), ": Here you are.")
		LocalPlayer():ConCommand( "mrp_hasletter" )
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomeFisherman()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomefisherman" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Fisherman()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeFisherman)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function Buy()
		CloseChat()
		LocalPlayer():ConCommand( "+buyfishermenu" )
	end

	local function Sell()
		CloseChat()
		LocalPlayer():ConCommand( "+sellfishermenu" )
	end

	local function Ship()
		CloseChat()
		LocalPlayer():ConCommand( "InventoryAddon.DropItem ship" )
	end

	local function BuyRod()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_buyrod" )
	end

	local function BuyBait()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_buybait" )
	end

	local function BuyRodTalk()
		talk:ClearAll()
		talk:AddText("That'll be 50 Gold, mate.")
		talk:AddPlayerOption("Here you are.", BuyRod)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function BuyBaitTalk()
		talk:ClearAll()
		talk:AddText("That'll be 4 Gold, mate.")
		talk:AddPlayerOption("Here you are.", BuyBait)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	if LocalPlayer():GetNWInt("hasletter") == 1 then
		talk:AddText("'Ello, I'm the Harbour Master o' this 'ere port\nCare to trade?")
	else
		talk:AddText("'Ello, I'm the Harbour Master o' this 'ere port\nCare to trade?\nOr perhaps you could deliver a letter for me?")
	end

	if LocalPlayer():Team() == 18 then
		talk:AddPlayerOption("I no longer wish to be a Fisherman.", Fisherman)
	else
		talk:AddPlayerOption("Can you teach me to be a Fisherman?", Fisherman)
	end
	if LocalPlayer():GetNWInt("hasfish") == 1 then
		talk:AddPlayerOption("The fisherman asked me to give you these.", GiveFish)
	end
	if LocalPlayer():GetNWInt("hasletter") == 1 or LocalPlayer():GetNWInt("hasfish") == 1 then else
		talk:AddPlayerOption("I'll deliver the letter.", GiveLetter)
	end
	talk:AddPlayerOption("I'll have a rod please.", BuyRodTalk)
	talk:AddPlayerOption("I'll have some bait please.", BuyBaitTalk)
	talk:AddPlayerOption("What do you sell?", Buy)
	talk:AddPlayerOption("Can I sell you my items?", Sell)
	talk:AddPlayerOption("Can you put my ship in the dock?", Ship)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("HarbourMasterChatMenu", BreenChat)

function MonkChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomePriest()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomepriest" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Priest()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomePriest)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function Buy()
		CloseChat()
		LocalPlayer():ConCommand( "+buypriestmenu" )
	end

	local function Sell()
		CloseChat()
		LocalPlayer():ConCommand( "+sellpriestmenu" )
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("Blessings be upon you.\nIs there something you need?")
	if LocalPlayer():Team() == 11 then
		talk:AddPlayerOption("I no longer wish to be a Priest.", Priest)
	else
		talk:AddPlayerOption("Can you teach me to be a Priest?", Priest)
	end
	talk:AddPlayerOption("What do you sell?", Buy)
	talk:AddPlayerOption("Can I sell you my items?", Sell)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("PriestChatMenu", MonkChat)

function MossmanChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomeCook()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomecook" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Cook()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeCook)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function Buy()
		CloseChat()
		LocalPlayer():ConCommand( "+buycookmenu" )
	end

	local function Sell()
		CloseChat()
		LocalPlayer():ConCommand( "+sellcookmenu" )
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("Welcome, can I interest you in some fine food?")
	if LocalPlayer():Team() == 12 then
		talk:AddPlayerOption("I no longer wish to be a Cook.", Cook)
	else
		talk:AddPlayerOption("Can you teach me to be a Cook?", Cook)
	end
	talk:AddPlayerOption("What do you sell?", Buy)
	talk:AddPlayerOption("Can I sell you my items?", Sell)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("CookChatMenu", MossmanChat)

function RebelChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomeCraftsman()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomecraftsman" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Craftsman()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeCraftsman)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function Buy()
		CloseChat()
		LocalPlayer():ConCommand( "+buycraftsmanmenu" )
	end

	local function Sell()
		CloseChat()
		LocalPlayer():ConCommand( "+sellcraftsmanmenu" )
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("'Ello mate. I'm the local craftsman.\nWhat can I do for you?")
	if LocalPlayer():Team() == 13 then
		talk:AddPlayerOption("I no longer wish to be a Craftsman.", Craftsman)
	else
		talk:AddPlayerOption("Can you teach me to be a Craftsman?", Craftsman)
	end
	talk:AddPlayerOption("What do you sell?", Buy)
	talk:AddPlayerOption("Can I sell you my items?", Sell)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("CraftsmanChatMenu", RebelChat)

function Rebel2Chat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomeLabourer()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomelabourer" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Labourer()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeLabourer)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function Sell()
		CloseChat()
		LocalPlayer():ConCommand( "+selllabourermenu" )
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("'Ello mate. I'm the local labourer.\nWhat can I do for you?")
	if LocalPlayer():Team() == 14 then
		talk:AddPlayerOption("I no longer wish to be a Labourer.", Labourer)
	else
		talk:AddPlayerOption("Can you teach me to be a Labourer?", Labourer)
	end
	talk:AddPlayerOption("Can I sell you my items?", Sell)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("LabourerChatMenu", Rebel2Chat)

function OdessaChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomeKnight()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomeknight" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Knight()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeKnight)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function BecomeGuard()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomeguard" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Guard()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeGuard)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	if LocalPlayer():Team() == 3 then
		talk:AddText("Hello, Sir Knight.\nCan I be of service?")
	elseif LocalPlayer():Team() == 2 then
		talk:AddText("Hello.\nCan I be of service?")
	else
		talk:AddText("Hello citizen.\nCan I be of service?")
	end

	if LocalPlayer():Team() == 3 then
		talk:AddPlayerOption("I no longer wish to be a Knight.", Knight)
	elseif LocalPlayer():Team() == 2 then
		talk:AddPlayerOption("Can you teach me to be a Knight?", Knight)
		talk:AddPlayerOption("I no longer wish to be a Guard.", Guard)
	else
		talk:AddPlayerOption("Can you teach me to be a Guard?", Guard)
	end
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("KnightChatMenu", OdessaChat)

function Rebel3Chat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Until next we meet.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function GiveFish()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_hasfish" )
		chat.AddText(Color(100, 200, 255), "Fisherman", Color(255,255,255), ": Be seeing you.")
	end

	local function GiveLetter()
		LocalPlayer():ConCommand( "mrp_giveletter" )
		chat.AddText(Color(100, 200, 255), "Fisherman", Color(255,255,255), ": Thank you.")
		talk:ClearAll()
		talk:AddText("Hey, I don't suppose you could take this shipment of fish to the Harbour Master for me?")
		talk:AddPlayerOption("Sure.", GiveFish)
		talk:AddPlayerOption("I can't, sorry.", CloseChat)
	end

	local function Letter()
		talk:ClearAll()
		talk:AddText("Oh?")
		talk:AddPlayerOption("It's from the Harbour Master of Felrendor.", GiveLetter)
		talk:AddPlayerOption("Nevermind.", Leave)
	end

	local function Fisherman()
		talk:ClearAll()
		talk:AddText("I don't have time right now I'm afraid.")
		talk:AddPlayerOption("Alright, bye.", CloseChat)
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("'Ello mate, what can I do for you?")
	talk:AddPlayerOption("Can you teach me to be a Fisherman?", Fisherman)
	if LocalPlayer():GetNWInt("hasletter") == 1 then
		talk:AddPlayerOption("I have a letter for you.", Letter)
	end
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("FishermanChatMenu", Rebel3Chat)

function Undead1Chat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		if LocalPlayer():GetNWString("race") == "Undead" then
			talk:AddText("Goodbye, brother.")
		else
			talk:AddText("At last, I can barely stand to be around you LIVING.")
		end
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomeLabourer()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomelabourer" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function Labourer()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeLabourer)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function Sell()
		CloseChat()
		LocalPlayer():ConCommand( "+selllabourermenu" )
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("Hrmm? What is it, I want to get back to the crypt.")
	if LocalPlayer():Team() == 13 then
		talk:AddPlayerOption("I no longer wish to be a Labourer.", Labourer)
	else
		talk:AddPlayerOption("Can you teach me to be a Labourer?", Labourer)
	end
	talk:AddPlayerOption("Can I sell you my items?", Sell)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("ELabourerChatMenu", Undead1Chat)

function GoblinChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("We will destroy them!")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function BecomeInnKeeper()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_becomeinnkeeper" )
		LocalPlayer():ConCommand( "mrp_changejob" )
	end

	local function InnKeeper()
		talk:ClearAll()
		talk:AddText("Are you sure?")
		talk:AddPlayerOption("Yes.", BecomeInnKeeper)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	local function BuyMead()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_ebuymead" )
	end

	local function Mead()
		talk:ClearAll()
		talk:AddText("That'll be 3 Gold.")
		talk:AddPlayerOption("Here you are.", BuyMead)
		talk:AddPlayerOption("On second thoughts...", CloseChat)
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("A'ight mate? Here for some booze?")
	if LocalPlayer():Team() == 15 then
		talk:AddPlayerOption("I no longer wish to be a Inn Keeper.", InnKeeper)
	else
		talk:AddPlayerOption("Can you teach me to be a Inn Keeper?", InnKeeper)
	end
	talk:AddPlayerOption("Mead.", Mead)
	talk:AddPlayerOption("I'll be on my way.", Leave)
end
usermessage.Hook("EInnKeeperChatMenu", GoblinChat)

function AaronChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("The Undead Legion will fall!")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function CompleteCannonQuest()
		CloseChat()
		chat.AddText(Color(0, 0, 255), "Aaron Landels", Color(255,255,255), ": Thank you.")
		chat.AddText(Color(0, 0, 255), "Aaron Landels", Color(255,255,255), ": Ah thanks alot mate! Now I have a chance to escape!\nHere, take whatever I've left lying around up here, I'm off!")
		LocalPlayer():ConCommand( "mrp_completecannonquest" )
	end

	local function CannonQuest()
		CloseChat()
		LocalPlayer():ConCommand( "mrp_cannonquest" )
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	if not GetGlobalInt("cannonquestdone") == 0 or GetGlobalInt("cannonquestdone") == 1 then
		talk:AddText("Oi! Give us some help will you?\nI was building a cannon for one of the ships out in the docks, when the town was over-run by undead!\nNow I'm trapped in this bloody attic without anything to defend myself!\nHow about you go out there and... he... take CARE of the undead will you?\nCheers mate!")
	else
		talk:AddText("Ah You've returned? Killed those undead yet?")
	end

	if LocalPlayer():GetNWInt("completedcannonquest") == 1 then
		talk:AddPlayerOption("I killed those Undead for ya.", CompleteCannonQuest)
		talk:AddPlayerOption("Time to go.", Leave)
	elseif not GetGlobalInt("cannonquestdone") == 0 or GetGlobalInt("cannonquestdone") == 1 then
		talk:AddPlayerOption("Aye.", CannonQuest)
		talk:AddPlayerOption("I can't right now.", Leave)
	else
		talk:AddPlayerOption("Time to go.", Leave)
	end
end
usermessage.Hook("AaronChatMenu", AaronChat)

function FarmerChat(msg)
	local talk = vgui.Create("NpcChat")

	local function CloseChat()
		talk:ClearAll()
		talk:SetAlpha(0)
		gui.EnableScreenClicker(false)
		talk:Remove()
		talk:GetTable().isOpen = 0
	end

	local function Leave()
		talk:ClearAll()
		talk:AddText("Happy farming.")
		talk:AddPlayerOption("Bye.", CloseChat)
	end

	local function Buy()
		CloseChat()
		LocalPlayer():ConCommand( "+buyfarmermenu" )
	end

	local function Sell()
		CloseChat()
		LocalPlayer():ConCommand( "+sellfarmermenu" )
	end

	talk:ClearAll()
	talk:SetAlpha(255)
	talk:MakePopup()
	gui.EnableScreenClicker(true)
	talk:GetTable().isOpen = 1

	talk:AddText("'Ello mate.")
	talk:AddPlayerOption("What do you sell?", Buy)
	talk:AddPlayerOption("Can I sell you some items?", Sell)
end
usermessage.Hook("FarmerChatMenu", FarmerChat) 