include("shared.lua")

function SmithingVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 350, 910 )
	DermaPanel:SetTitle( "Smithing" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Copper Short Sword" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1:SetToolTip( "A Copper Short Sword\n".."2 Copper Bars Needed.")
	DermaButton1.DoClick = function ()
		RunConsoleCommand("create_sword_short_copper")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_gladius.mdl" )
	SpawnIcon:SetToolTip( "A Copper Short Sword\n".."2 Copper Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_short_copper")
		DermaPanel:SetVisible( false )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Iron Short Sword" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 50 )
	DermaButton2:SetToolTip( "An Iron Short Sword\n".."Level 13 Needed\n".."2 Iron Bars Needed.")
	DermaButton2.DoClick = function ()
		RunConsoleCommand("create_sword_short_iron")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 100 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_gladius.mdl" )
	SpawnIcon:SetToolTip( "An Iron Short Sword\n".."Level 13 Needed\n".."2 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_short_iron")
		DermaPanel:SetVisible( false )
	end

	local DermaButton3 = vgui.Create( "DButton" )
	DermaButton3:SetParent( DermaPanel )
	DermaButton3:SetText( "Steel Short Sword" )
	DermaButton3:SetPos( 25, 160 )
	DermaButton3:SetSize( 210, 50 )
	DermaButton3:SetToolTip( "A Steel Short Sword\n".."Level 20 Needed\n".."2 Steel Bars and 1 Iron Bar Needed.")
	DermaButton3.DoClick = function ()
		RunConsoleCommand("create_sword_short_steel")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 160 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_gladius.mdl" )
	SpawnIcon:SetToolTip( "A Steel Short Sword\n".."Level 20 Needed\n".."2 Steel Bars and 1 Iron Bar Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_short_steel")
		DermaPanel:SetVisible( false )
	end

	local DermaButton4 = vgui.Create( "DButton" )
	DermaButton4:SetParent( DermaPanel )
	DermaButton4:SetText( "Copper Long Sword" )
	DermaButton4:SetPos( 25, 220 )
	DermaButton4:SetSize( 210, 50 )
	DermaButton4:SetToolTip( "A Copper Long Sword\n".."Level 18 Needed\n".."2 Copper Bars and 1 Iron Bar Needed.")
	DermaButton4.DoClick = function ()
		RunConsoleCommand("create_sword_long_copper")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 220 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_sword.mdl" )
	SpawnIcon:SetToolTip( "A Copper Long Sword\n".."Level 18 Needed\n".."2 Copper Bars and 1 Iron Bar Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_long_copper")
		DermaPanel:SetVisible( false )
	end

	local DermaButton5 = vgui.Create( "DButton" )
	DermaButton5:SetParent( DermaPanel )
	DermaButton5:SetText( "Iron Long Sword" )
	DermaButton5:SetPos( 25, 280 )
	DermaButton5:SetSize( 210, 50 )
	DermaButton5:SetToolTip( "An Iron Long Sword\n".."Level 25 Needed\n".."3 Iron Bars and 1 Steel Bar Needed.")
	DermaButton5.DoClick = function ()
		RunConsoleCommand("create_sword_long_iron")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 280 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_sword.mdl" )
	SpawnIcon:SetToolTip( "An Iron Long Sword\n".."Level 25 Needed\n".."3 Iron Bars and 1 Steel Bar Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_long_iron")
		DermaPanel:SetVisible( false )
	end

	local DermaButton6 = vgui.Create( "DButton" )
	DermaButton6:SetParent( DermaPanel )
	DermaButton6:SetText( "Steel Long Sword" )
	DermaButton6:SetPos( 25, 340 )
	DermaButton6:SetSize( 210, 50 )
	DermaButton6:SetToolTip( "A Steel Long Sword\n".."Level 36 Needed\n".."4 Steel Bars and 2 Iron Bars Needed.")
	DermaButton6.DoClick = function ()
		RunConsoleCommand("create_sword_long_steel")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 340 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_sword.mdl" )
	SpawnIcon:SetToolTip( "A Steel Long Sword\n".."Level 36 Needed\n".."4 Steel Bars and 2 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_long_steel")
		DermaPanel:SetVisible( false )
	end

	local DermaButton7 = vgui.Create( "DButton" )
	DermaButton7:SetParent( DermaPanel )
	DermaButton7:SetText( "Copper Two-Handed Sword" )
	DermaButton7:SetPos( 25, 400 )
	DermaButton7:SetSize( 210, 50 )
	DermaButton7:SetToolTip( "A Copper Two-Handed Sword\n".."Level 30 Needed\n".."5 Copper Bars and 3 Iron Bars Needed.")
	DermaButton7.DoClick = function ()
		RunConsoleCommand("create_sword_twohanded_copper")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 400 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_sword_silver.mdl" )
	SpawnIcon:SetToolTip( "A Copper Two-Handed Sword\n".."Level 30 Needed\n".."5 Copper Bars and 3 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_twohanded_copper")
		DermaPanel:SetVisible( false )
	end

	local DermaButton8 = vgui.Create( "DButton" )
	DermaButton8:SetParent( DermaPanel )
	DermaButton8:SetText( "Iron Two-Handed Sword" )
	DermaButton8:SetPos( 25, 460 )
	DermaButton8:SetSize( 210, 50 )
	DermaButton8:SetToolTip( "An Iron Two-Handed Sword\n".."Level 42 Needed\n".."5 Iron Bars and 3 Steel Bars Needed.")
	DermaButton8.DoClick = function ()
		RunConsoleCommand("create_sword_twohanded_iron")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 460 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_sword_silver.mdl" )
	SpawnIcon:SetToolTip( "An Iron Two-Handed Sword\n".."Level 42 Needed\n".."5 Iron Bars and 3 Steel Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_twohanded_iron")
		DermaPanel:SetVisible( false )
	end

	local DermaButton9 = vgui.Create( "DButton" )
	DermaButton9:SetParent( DermaPanel )
	DermaButton9:SetText( "Steel Two-Handed Sword" )
	DermaButton9:SetPos( 25, 520 )
	DermaButton9:SetSize( 210, 50 )
	DermaButton9:SetToolTip( "A Steel Two-Handed Sword\n".."Level 54 Needed\n".."6 Steel Bars and 2 Iron Bars Needed.")
	DermaButton9.DoClick = function ()
		RunConsoleCommand("create_sword_twohanded_steel")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 520 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_sword_silver.mdl" )
	SpawnIcon:SetToolTip( "A Steel Two-Handed Sword\n".."Level 54 Needed\n".."6 Steel Bars and 2 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_twohanded_steel")
		DermaPanel:SetVisible( false )
	end

	local DermaButton10 = vgui.Create( "DButton" )
	DermaButton10:SetParent( DermaPanel )
	DermaButton10:SetText( "War Axe" )
	DermaButton10:SetPos( 25, 580 )
	DermaButton10:SetSize( 210, 50 )
	DermaButton10:SetToolTip( "A War Axe\n".."Level 32 Needed\n".."2 Steel Bars and 3 Iron Bars Needed.")
	DermaButton10.DoClick = function ()
		RunConsoleCommand("create_war_axe")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 580 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_axe.mdl" )
	SpawnIcon:SetToolTip( "A War Axe\n".."Level 32 Needed\n".."2 Steel Bars and 3 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_war_axe")
		DermaPanel:SetVisible( false )
	end

	local DermaButton11 = vgui.Create( "DButton" )
	DermaButton11:SetParent( DermaPanel )
	DermaButton11:SetText( "War Hammer" )
	DermaButton11:SetPos( 25, 640 )
	DermaButton11:SetSize( 210, 50 )
	DermaButton11:SetToolTip( "A War Hammer\n".."Level 53 Needed\n".."5 Steel Bars and 2 Iron Bars Needed.")
	DermaButton11.DoClick = function ()
		RunConsoleCommand("create_war_hammer")
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 640 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/weapons/w_sledgehammer.mdl" )
	SpawnIcon:SetToolTip( "A War Hammer\n".."Level 53 Needed\n".."5 Steel Bars and 2 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_war_hammer")
		DermaPanel:SetVisible( false )
	end

	local DermaButton12 = vgui.Create( "DButton" )
	DermaButton12:SetParent( DermaPanel )
	DermaButton12:SetText( "Armour Templar" )
	DermaButton12:SetPos( 25, 700 )
	DermaButton12:SetSize( 210, 50 )
	DermaButton12:SetToolTip( "A suit of Templar Armour\n"..
							--"Level 53 Needed\n"..
							"4 Steel Bars and 8 Iron Bars Needed.")
	DermaButton12.DoClick = function ()
		RunConsoleCommand( "create_armour_templar" )
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 700 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/nayrbarr/iron/iron.mdl" )
	SpawnIcon:SetToolTip( "A suit of Templar Armour\n"..
							--"Level 53 Needed\n"..
							"4 Steel Bars and 8 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "create_armour_templar" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton13 = vgui.Create( "DButton" )
	DermaButton13:SetParent( DermaPanel )
	DermaButton13:SetText( "Roman Shield" )
	DermaButton13:SetPos( 25, 760 )
	DermaButton13:SetSize( 210, 50 )
	DermaButton13:SetToolTip( "A Roman Shield\n"..
							--"Level 53 Needed\n"..
							"4 Copper Bars and 8 Iron Bars Needed.")
	DermaButton13.DoClick = function ()
		RunConsoleCommand( "create_armour_shield_roman" )
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 760 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/nayrbarr/iron/iron.mdl" )
	SpawnIcon:SetToolTip( "A Roman Shield\n"..
							--"Level 53 Needed\n"..
							"4 Copper Bars and 8 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "create_armour_shield_roman" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton13 = vgui.Create( "DButton" )
	DermaButton13:SetParent( DermaPanel )
	DermaButton13:SetText( "Buckler (Shield)" )
	DermaButton13:SetPos( 25, 820 )
	DermaButton13:SetSize( 210, 50 )
	DermaButton13:SetToolTip( "A Buckler (Shield)\n"..
							--"Level 53 Needed\n"..
							"3 Copper Bars and 2 Iron Bars Needed.")
	DermaButton13.DoClick = function ()
		RunConsoleCommand( "create_armour_shield_buckler" )
		DermaPanel:SetVisible( false )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 820 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/nayrbarr/iron/iron.mdl" )
	SpawnIcon:SetToolTip( "A Buckler (Shield)\n"..
							--"Level 53 Needed\n"..
							"3 Copper Bars and 2 Iron Bars Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "create_armour_shield_buckler" )
		DermaPanel:SetVisible( false )
	end
end
usermessage.Hook("SmithingMenu", SmithingVGUI) 