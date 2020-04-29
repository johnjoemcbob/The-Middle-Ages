include("shared.lua")

function CraftingVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 350, 600 )
	DermaPanel:SetTitle( "Crafting" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Plank" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1:SetModel( "models/props_debris/wood_board06a.mdl" )
	DermaButton1.DoClick = function ()
		RunConsoleCommand("create_plank")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_debris/wood_board06a.mdl" )
	SpawnIcon:SetToolTip( "A Plank\n".."1 Log Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_plank")
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Chair" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 50 )
	DermaButton2:SetToolTip( "A Chair\n".."2 Planks and 1 Iron Needed.")
	DermaButton2.DoClick = function ()
		RunConsoleCommand("create_chair")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 100 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_c17/FurnitureChair001a.mdl" )
	SpawnIcon:SetToolTip( "A Chair\n".."2 Planks and 1 Iron Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_chair")
	end

	local DermaButton3 = vgui.Create( "DButton" )
	DermaButton3:SetParent( DermaPanel )
	DermaButton3:SetText( "Table" )
	DermaButton3:SetPos( 25, 160 )
	DermaButton3:SetSize( 210, 50 )
	DermaButton3:SetToolTip( "A Table\n".."Level 12 Needed\n".."4 Planks and 2 Iron Needed.")
	DermaButton3.DoClick = function ()
		RunConsoleCommand("create_table")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 160 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_c17/FurnitureTable001a.mdl" )
	SpawnIcon:SetToolTip( "A Table\n".."Level 12 Needed\n".."4 Planks and 2 Iron Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_sword_short_steel")
	end

	local DermaButton4 = vgui.Create( "DButton" )
	DermaButton4:SetParent( DermaPanel )
	DermaButton4:SetText( "Fence" )
	DermaButton4:SetPos( 25, 220 )
	DermaButton4:SetSize( 210, 50 )
	DermaButton4:SetToolTip( "A Fence\n".."Level 20 Needed\n".."7 Planks and 3 Iron Needed.")
	DermaButton4.DoClick = function ()
		RunConsoleCommand("create_fence")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 220 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_wasteland/wood_fence01a.mdl" )
	SpawnIcon:SetToolTip( "A Fence\n".."Level 20 Needed\n".."7 Planks and 3 Iron Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_fence")
	end

	local DermaButton5 = vgui.Create( "DButton" )
	DermaButton5:SetParent( DermaPanel )
	DermaButton5:SetText( "Statue" )
	DermaButton5:SetPos( 25, 280 )
	DermaButton5:SetSize( 210, 50 )
	DermaButton5:SetToolTip( "A Statue\n".."Level 29 Needed\n".."12 Iron and 7 Copper Needed.")
	DermaButton5.DoClick = function ()
		RunConsoleCommand("create_sword_long_iron")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 280 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_c17/gravestone_statue001a.mdl" )
	SpawnIcon:SetToolTip( "A Statue\n".."Level 29 Needed\n".."12 Iron and 7 Copper Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_fence")
	end

	local DermaButton6 = vgui.Create( "DButton" )
	DermaButton6:SetParent( DermaPanel )
	DermaButton6:SetText( "Sapphire Ring" )
	DermaButton6:SetPos( 25, 340 )
	DermaButton6:SetSize( 210, 50 )
	DermaButton6:SetToolTip( "A Sapphire Ring\n".."Level 24 Needed\n".."2 Copper and 1 Sapphire Needed.")
	DermaButton6.DoClick = function ()
		RunConsoleCommand("create_ring_sapphire")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 340 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props/de_inferno/wall_lamp_ring.mdl" )
	SpawnIcon:SetToolTip( "A Sapphire Ring\n".."Level 24 Needed\n".."2 Copper and 1 Sapphire Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_ring_sapphire")
	end

	local DermaButton7 = vgui.Create( "DButton" )
	DermaButton7:SetParent( DermaPanel )
	DermaButton7:SetText( "Emerald Ring" )
	DermaButton7:SetPos( 25, 400 )
	DermaButton7:SetSize( 210, 50 )
	DermaButton7:SetToolTip( "A Emerald Ring\n".."Level 30 Needed\n".."2 Iron and 1 Emerald Needed.")
	DermaButton7.DoClick = function ()
		RunConsoleCommand("create_ring_emerald")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 400 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props/de_inferno/wall_lamp_ring.mdl" )
	SpawnIcon:SetToolTip( "A Emerald Ring\n".."Level 30 Needed\n".."2 Iron and 1 Emerald Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_ring_emerald")
	end

	local DermaButton8 = vgui.Create( "DButton" )
	DermaButton8:SetParent( DermaPanel )
	DermaButton8:SetText( "Bow" )
	DermaButton8:SetPos( 25, 460 )
	DermaButton8:SetSize( 210, 50 )
	DermaButton8:SetToolTip( "A Bow\n".."Level 23 Needed\n".."1 Iron and 3 Planks Needed.")
	DermaButton8.DoClick = function ()
		RunConsoleCommand("create_bow")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 460 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/aoc_weapon/w_longbow.mdl" )
	SpawnIcon:SetToolTip( "A Bow\n".."Level 23 Needed\n".."1 Iron and 3 Planks Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_bow")
	end

	local DermaButton9 = vgui.Create( "DButton" )
	DermaButton9:SetParent( DermaPanel )
	DermaButton9:SetText( "Fire Box" )
	DermaButton9:SetPos( 25, 520 )
	DermaButton9:SetSize( 210, 50 )
	DermaButton9:SetToolTip( "A Fire Bow\n".."Level 25 Needed\n".."2 Iron and 6 Planks Needed.")
	DermaButton9.DoClick = function ()
		RunConsoleCommand("create_bow_fire")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 520 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/aoc_weapon/w_longbow.mdl" )
	SpawnIcon:SetToolTip( "A Fire Bow\n".."Level 25 Needed\n".."2 Iron and 6 Planks Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_bow_fire")
	end
end
usermessage.Hook("CraftingMenu", CraftingVGUI) 