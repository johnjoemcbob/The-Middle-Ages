include("shared.lua")

function AlchemyVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 350, 380 )
	DermaPanel:SetTitle( "Alchemy" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Potion" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1:SetToolTip( "A Health Potion\n".."1 Weed, 2 Aria and 1 Mushroom Needed.")
	DermaButton1.DoClick = function ()
		RunConsoleCommand("create_potion")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/items/provisions/potions/life_potion.mdl" )
	SpawnIcon:SetToolTip( "A Health Potion\n".."1 Weed, 2 Aria and 1 Mushroom Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_potion")
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Jump Potion" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 50 )
	DermaButton2:SetToolTip( "A Jump Potion\n".."Level 17 Needed\n".."2 Aria and 1 Mushroom Needed.")
	DermaButton2.DoClick = function ()
		RunConsoleCommand("create_potion_jump")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 100 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/items/provisions/potions/life_potion.mdl" )
	SpawnIcon:SetToolTip( "A Jump Potion\n".."Level 17 Needed\n".."2 Aria and 1 Mushroom Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_potion_jump")
	end

	local DermaButton3 = vgui.Create( "DButton" )
	DermaButton3:SetParent( DermaPanel )
	DermaButton3:SetText( "Speed Potion" )
	DermaButton3:SetPos( 25, 160 )
	DermaButton3:SetSize( 210, 50 )
	DermaButton3:SetToolTip( "A Speed Potion\n".."Level 12 Needed\n".."2 Aria and 1 Weed Needed.")
	DermaButton3.DoClick = function ()
		RunConsoleCommand("create_potion_speed")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 160 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/items/provisions/potions/life_potion.mdl" )
	SpawnIcon:SetToolTip( "A Speed Potion\n".."Level 12 Needed\n".."2 Aria and 1 Weed Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_potion_speed")
	end

	local DermaButton4 = vgui.Create( "DButton" )
	DermaButton4:SetParent( DermaPanel )
	DermaButton4:SetText( "Poison" )
	DermaButton4:SetPos( 25, 220 )
	DermaButton4:SetSize( 210, 50 )
	DermaButton4:SetToolTip( "A Health Poison\n".."2 Nightshade, 1 Mushroom and 1 Weed Needed.")
	DermaButton4.DoClick = function ()
		RunConsoleCommand("create_poison")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 220 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/items/provisions/potions/life_potion.mdl" )
	SpawnIcon:SetToolTip( "A Health Poison\n".."2 Nightshade, 1 Mushroom and 1 Weed Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_poison")
	end

	local DermaButton5 = vgui.Create( "DButton" )
	DermaButton5:SetParent( DermaPanel )
	DermaButton5:SetText( "Armour Potion" )
	DermaButton5:SetPos( 25, 280 )
	DermaButton5:SetSize( 210, 50 )
	DermaButton5:SetToolTip( "An Armour Potion\n".."Level 22 Needed\n".."2 Mushrooms, 2 Weeds and 2 Aria Needed.")
	DermaButton5.DoClick = function ()
		RunConsoleCommand("create_potion_armour")
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 280 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/items/provisions/potions/life_potion.mdl" )
	SpawnIcon:SetToolTip( "An Armour Potion\n".."Level 22 Needed\n".."2 Mushrooms, 2 Weeds and 2 Aria Needed.")
	SpawnIcon.DoClick = function()
		RunConsoleCommand("create_potion_armour")
	end

	--local DermaButton6 = vgui.Create( "DButton" )
	--DermaButton6:SetParent( DermaPanel )
	--DermaButton6:SetText( "Temporary Potion" )
	--DermaButton6:SetPos( 25, 340 )
	--DermaButton6:SetSize( 210, 50 )
	--DermaButton6:SetToolTip( "A Temporary Potion\n".."1 Mushroom, 1 Weed and 1 Aria Needed.")
	--DermaButton6.DoClick = function ()
	--	RunConsoleCommand("create_potion_temp")
	--end

	--local SpawnIcon = vgui.Create( "SpawnIcon" )
	--SpawnIcon:SetParent( DermaPanel )
	--SpawnIcon:SetPos( 250, 340 )
	--SpawnIcon:SetIconSize( 57 )
	--SpawnIcon:SetModel( "models/items/provisions/potions/life_potion.mdl" )
	--SpawnIcon:SetToolTip( "A Temporary Potion\n".."1 Mushroom, 1 Weed and 1 Aria Needed.")
	--SpawnIcon.DoClick = function ()
	--	RunConsoleCommand("create_potion_temp")
	--end
end
usermessage.Hook("AlchemyMenu", AlchemyVGUI) 