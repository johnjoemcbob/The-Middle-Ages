include("shared.lua")

function FSmithingVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 350, 400 )
	DermaPanel:SetTitle( "Smithing" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Copper Bar" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1.DoClick = function ()
		RunConsoleCommand("create_bar_copper")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/nayrbarr/iron/iron.mdl" )
	SpawnIcon:SetToolTip( "A Copper Bar\n".."2 Copper Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_bar_copper")
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Iron Bar" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 50 )
	DermaButton2.DoClick = function ()
		RunConsoleCommand("create_bar_iron")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 100 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/nayrbarr/iron/iron.mdl" )
	SpawnIcon:SetToolTip( "An Iron Bar\n".."Level 10 Needed\n".."2 Iron Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_bar_iron")
	end

	local DermaButton3 = vgui.Create( "DButton" )
	DermaButton3:SetParent( DermaPanel )
	DermaButton3:SetText( "Steel Bar" )
	DermaButton3:SetPos( 25, 160 )
	DermaButton3:SetSize( 210, 50 )
	DermaButton3.DoClick = function ()
		RunConsoleCommand("create_bar_steel")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 160 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/nayrbarr/iron/iron.mdl" )
	SpawnIcon:SetToolTip( "A Steel Bar\n".."Level 17 Needed\n".."2 Tin and 3 Iron Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_bar_steel")
	end

--	local DermaButton4 = vgui.Create( "DButton" )
--	DermaButton4:SetParent( DermaPanel )
--	DermaButton4:SetText( "Copper Long Sword" )
--	DermaButton4:SetPos( 25, 220 )
--	DermaButton4:SetSize( 210, 50 )
--	DermaButton4.DoClick = function ()
--		RunConsoleCommand("create_sword_long_copper")
--	end

--	local SpawnIcon = vgui.Create( "SpawnIcon" )
--	SpawnIcon:SetParent( DermaPanel )
--	SpawnIcon:SetPos( 250, 220 )
--	SpawnIcon:SetIconSize( 57 )
--	SpawnIcon:SetModel( "models/weapons/w_sword.mdl" )
--	SpawnIcon:SetToolTip( "A Copper Long Sword\n".."Level 18 Needed\n".."2 Copper Bars and 1 Iron Bar Needed.")
--	SpawnIcon.DoClick = function()
--		RunConsoleCommand("create_sword_long_copper")
--	end

--	local DermaButton5 = vgui.Create( "DButton" )
--	DermaButton5:SetParent( DermaPanel )
--	DermaButton5:SetText( "Iron Long Sword" )
--	DermaButton5:SetPos( 25, 280 )
--	DermaButton5:SetSize( 210, 50 )
--	DermaButton5.DoClick = function ()
--		RunConsoleCommand("create_sword_long_iron")
--	end

--	local SpawnIcon = vgui.Create( "SpawnIcon" )
--	SpawnIcon:SetParent( DermaPanel )
--	SpawnIcon:SetPos( 250, 280 )
--	SpawnIcon:SetIconSize( 57 )
--	SpawnIcon:SetModel( "models/weapons/w_sword.mdl" )
--	SpawnIcon:SetToolTip( "An Iron Long Sword\n".."Level 25 Needed\n".."3 Iron Bars and 1 Steel Bar Needed.")
--	SpawnIcon.DoClick = function()
--		RunConsoleCommand("create_sword_long_iron")
--	end

--	local DermaButton6 = vgui.Create( "DButton" )
--	DermaButton6:SetParent( DermaPanel )
--	DermaButton6:SetText( "Steel Long Sword" )
--	DermaButton6:SetPos( 25, 340 )
--	DermaButton6:SetSize( 210, 50 )
--	DermaButton6.DoClick = function ()
--		RunConsoleCommand("create_sword_long_steel")
--	end

--	local SpawnIcon = vgui.Create( "SpawnIcon" )
--	SpawnIcon:SetParent( DermaPanel )
--	SpawnIcon:SetPos( 250, 340 )
--	SpawnIcon:SetIconSize( 57 )
--	SpawnIcon:SetModel( "models/weapons/w_sword.mdl" )
--	SpawnIcon:SetToolTip( "A Steel Long Sword\n".."Level 36 Needed\n".."4 Steel Bars and 2 Iron Bars Needed.")
--	SpawnIcon.DoClick = function()
--		RunConsoleCommand("create_sword_long_steel")
--	end
end
usermessage.Hook("FurnaceMenu", FSmithingVGUI) 