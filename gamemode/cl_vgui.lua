function BlacksmithVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 350, 200 )
	DermaPanel:SetTitle( "Blacksmith's Equipment" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Buy Furnace (105 Gold)" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1:SetToolTip( "A Furnace\n" .. "Used to smelt Bars")
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_buyfurnace" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/nayrbarr/Smelter/smelter.mdl" )
	SpawnIcon:SetToolTip( "A Furnace\n" .. "Used to smelt Bars")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buyfurnace" )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Buy Anvil (50 Gold)" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 50 )
	DermaButton2:SetToolTip( "An Anvil\n" .. "Used to make Weaponary")
	DermaButton2.DoClick = function ()
		RunConsoleCommand( "mrp_buyanvil" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 100 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/nayrbarr/anvil/anvil.mdl" )
	SpawnIcon:SetToolTip( "An Anvil\n" .. "Used to make Weaponary")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buyanvil" )
	end
end
usermessage.Hook("BlacksmithMenu", BlacksmithVGUI)

function CraftsmanVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 400, 110 )
	DermaPanel:SetTitle( "Craftsman's Equipment" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Buy Workbench (85 Gold)" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1:SetToolTip( "A Workbench\n" .. "Used to Craft Items")
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_buyworkbench" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_c17/FurnitureTable002a.mdl" )
	SpawnIcon:SetToolTip( "A Workbench\n" .. "Used to Craft Items")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buyworkbench" )
	end
end
usermessage.Hook("CraftsmanMenu", CraftsmanVGUI)

function InnKeeperVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 400, 110 )
	DermaPanel:SetTitle( "Inn Keeper's Drinks" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Buy Mead (3 Gold)" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_buyworkbench" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_junk/glassjug01.mdl" )
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buymeadplayer" )
	end
end
usermessage.Hook("InnKeeperMenu", InnKeeperVGUI)

function CookVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 400, 110 )
	DermaPanel:SetTitle( "Cook's Equipment" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Buy Stove (65 Gold)" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1:SetToolTip( "A Stove\n" .. "Used to Bake Food")
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_buystove" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_c17/furnitureStove001a.mdl" )
	SpawnIcon:SetToolTip( "A Stove\n" .. "Used to Bake Food")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buystove" )
	end
end
usermessage.Hook("CookMenu", CookVGUI)

function FarmerVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 400, 175 )
	DermaPanel:SetTitle( "Farmer's Animals" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Buy Cow (50 Gold)" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1:SetToolTip( "A Cow\n" .. "Used to get Milk")
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_buycow" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/thespectator/cow.mdl" )
	SpawnIcon:SetToolTip( "A Cow\n" .. "Used to get Milk")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buycow" )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Buy Chicken (40 Gold)" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 50 )
	DermaButton2:SetToolTip( "A Chicken\n" .. "Used to get Eggs")
	DermaButton2.DoClick = function ()
		RunConsoleCommand( "mrp_buychicken" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 100 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/lduke/chicken/chicken3.mdl" )
	SpawnIcon:SetToolTip( "A Chicken\n" .. "Used to get Eggs")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buychicken" )
	end
end
usermessage.Hook("FarmerMenu", FarmerVGUI)

function PriestVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 100, 50 )
	DermaPanel:SetSize( 400, 170 )
	DermaPanel:SetTitle( "Alchemy Equipment" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Buy Alchemy Kit (35 Gold)" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 55 )
	DermaButton1:SetToolTip( "An Alchemy Kit\n" .. "Used to make potions")
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_buykit" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 40 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_c17/metalPot001a.mdl" )
	SpawnIcon:SetToolTip( "An Alchemy Kit\n" .. "Used to make potions")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buykit" )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Buy Fountain (20 Gold)" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 55 )
	DermaButton2:SetToolTip( "A Fountain\n" .. "Gather Aria from this")
	DermaButton2.DoClick = function ()
		RunConsoleCommand( "mrp_buyfountain" )
	end

	local SpawnIcon = vgui.Create( "SpawnIcon" )
	SpawnIcon:SetParent( DermaPanel )
	SpawnIcon:SetPos( 250, 100 )
	SpawnIcon:SetIconSize( 57 )
	SpawnIcon:SetModel( "models/props_c17/fountain_01.mdl" )
	SpawnIcon:SetToolTip( "A Fountain\n" .. "Gather Aria from this")
	SpawnIcon.DoClick = function()
		RunConsoleCommand( "mrp_buyfountain" )
	end
end
usermessage.Hook("PriestPotionMenu", PriestVGUI)

function MainMenuVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 240, 430 )
	DermaPanel:SetTitle( "Main Menu" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Options" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 190, 50 )
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_openoptionsmenu" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Levels" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 190, 50 )
	DermaButton2.DoClick = function ()
		RunConsoleCommand( "mrp_openlevelsmenu" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton3 = vgui.Create( "DButton" )
	DermaButton3:SetParent( DermaPanel )
	DermaButton3:SetText( "Experience" )
	DermaButton3:SetPos( 25, 160 )
	DermaButton3:SetSize( 190, 50 )
	DermaButton3.DoClick = function ()
		RunConsoleCommand( "mrp_openexpmenu" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton4 = vgui.Create( "DButton" )
	DermaButton4:SetParent( DermaPanel )
	DermaButton4:SetText( "HUD" )
	DermaButton4:SetPos( 25, 220 )
	DermaButton4:SetSize( 190, 50 )
	DermaButton4.DoClick = function ()
		RunConsoleCommand( "mrp_openhudmenu" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton5 = vgui.Create( "DButton" )
	DermaButton5:SetParent( DermaPanel )
	DermaButton5:SetText( "Help" )
	DermaButton5:SetPos( 25, 280 )
	DermaButton5:SetSize( 190, 50 )
	DermaButton5.DoClick = function ()
		RunConsoleCommand( "mrp_openhelpmenu" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton6 = vgui.Create( "DButton" )
	DermaButton6:SetParent( DermaPanel )
	DermaButton6:SetText( "Maps" )
	DermaButton6:SetPos( 25, 340 )
	DermaButton6:SetSize( 190, 50 )
	DermaButton6.DoClick = function ()
		RunConsoleCommand( "mrp_map_background" )
		DermaPanel:SetVisible( false )
	end
end
usermessage.Hook("MainMenu", MainMenuVGUI)

function HelpMenuVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200,200 )
	DermaPanel:SetSize( 400, 350 )
	DermaPanel:SetTitle( "Tell me, what do you need to know?" ) 
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true ) 
	DermaPanel:ShowCloseButton( true ) 
	DermaPanel:MakePopup()
	DermaPanel:GetDeleteOnClose( true )

	local DermaButton = vgui.Create( "DButton", DermaPanel )
	DermaButton:SetParent( DermaPanel ) 
	DermaButton:SetText( "Why are there so many jobs? And what are they for?" )
	DermaButton:SetPos( 50, 50 )
	DermaButton:SetSize( 300, 48 )
	DermaButton.DoClick = function ()
		local DermaPanel2 = vgui.Create( "DFrame" )
		DermaPanel2:SetPos( 50,50 )
		DermaPanel2:SetSize( 400,500 )
		DermaPanel2:SetTitle( "Why are there so many jobs? And what are they for?" )
		DermaPanel2:SetVisible ( true )
		DermaPanel2:SetDraggable( true )
		DermaPanel2:ShowCloseButton( true )
		DermaPanel2:MakePopup()

		local myLabel= vgui.Create("DLabel", DermaPanel2)
		myLabel:SetText("The jobs exsist to help the roleplay run smoothly,\ngather basic resources and to make items such as swords.\n\nWhat jobs can I collect basic resources with?\n\nFarmer, Labourer and Fisherman\nWhen using one of the above jobs you can open a spawn menu by pressing F2, allowing you to buy what you need\n\nWhat jobs do I need to use the basic resources for?\n\nCraftsman, Cook, Blacksmith, Priest and Mage\nWhen using one of the above jobs you can open a spawn menu by pressing f2 to buy what you need\nYou can also sell the items you made to other players.\n\nWhat do I do when I use a job other then one of the above?\n\nWell it's very simple, you roleplay.")
		myLabel:SizeToContents ()
		myLabel:SetPos ( 5,30 )
	end

	local DermaButton = vgui.Create( "DButton" )
	DermaButton:SetParent( DermaPanel ) 
	DermaButton:SetText( "How and where do I get resources?" )
	DermaButton:SetPos( 50, 100 )
	DermaButton:SetSize( 300, 48 )
	DermaButton.DoClick = function ()
		local DermaPanel3 = vgui.Create( "DFrame" )
		DermaPanel3:SetPos( 50,50 )
		DermaPanel3:SetSize( 400,500 )
		DermaPanel3:SetTitle( "How and where do I get resources?" )
		DermaPanel3:SetVisible ( true )
		DermaPanel3:SetDraggable( true )
		DermaPanel3:ShowCloseButton( true )
		DermaPanel3:MakePopup()

		local myLabel= vgui.Create("DLabel", DermaPanel3)
		myLabel:SetText ( "You get resources by using the F2 menu\nwhile you are one of the following jobs.\nFarmer, Labourer, Fisherman.\n\nWhile are one of these jobs open the F2 menu and spawn a resource source\n( A mine, for example ).\nPress Use on it If you spawned one of the farming resource sources\n( Cows and Chickens ).\nFor Labourer you need to use your pickaxe on the mine or your axe on the tree.\n\nIf you are Fisherman, you need to drag the rod over the bait.\nOnce you touch the bait with your hook it will get attached.\nThen you put the hook with the bait attached into the water\nand wait for a fish to appear." )
		myLabel:SizeToContents ()
		myLabel:SetPos ( 5,30 )
	end

	local DermaButton = vgui.Create( "DButton" )
	DermaButton:SetParent( DermaPanel ) 
	DermaButton:SetText( "What do I do with my resources?" )
	DermaButton:SetPos( 50, 150 )
	DermaButton:SetSize( 300, 48 )
	DermaButton.DoClick = function ()
		local DermaPanel4 = vgui.Create( "DFrame" )
		DermaPanel4:SetPos( 50,50 )
		DermaPanel4:SetSize( 400,500 )
		DermaPanel4:SetTitle( "What do I do with my resources?" )
		DermaPanel4:SetVisible ( true )
		DermaPanel4:SetDraggable( true )
		DermaPanel4:ShowCloseButton( true )
		DermaPanel4:MakePopup()

		local myLabel= vgui.Create("DLabel", DermaPanel4)
		myLabel:SetText ( "When you have the resources\nYou can either sell your resources to another player or, use one of the following\njobs; Craftsman, Blacksmith, Cook, Priest or Mage.\n\nAll jobs have the same method for making an item.\nWhile using a job open the F2 menu and spawn a recipe and it requirements\nto make the item of your choice\nPlace all the needed items and the recipe next to the *Anvil, Furnace, Stove,\nWorkbench or Alchemy Kit*\nThen, press use on it.\nThe created item will pop out and you will get experience,\nonce you get to 100 experience you gain a level." )
		myLabel:SizeToContents ()
		myLabel:SetPos ( 5,30 )
	end

	local DermaButton = vgui.Create( "DButton" )
	DermaButton:SetParent( DermaPanel ) 
	DermaButton:SetText( "What are the rules and are there forums?" )
	DermaButton:SetPos( 50, 200 )
	DermaButton:SetSize( 300, 48 )
	DermaButton.DoClick = function ()
		local DermaPanel5 = vgui.Create( "DFrame" )
		DermaPanel5:SetPos( 50,50 )
		DermaPanel5:SetSize( 400,500 )
		DermaPanel5:SetTitle( "What are the rules and are there forums?" )
		DermaPanel5:SetVisible ( true )
		DermaPanel5:SetDraggable( true )
		DermaPanel5:ShowCloseButton( true )
		DermaPanel5:MakePopup()

		local myLabel= vgui.Create("DLabel", DermaPanel5)
		myLabel:SetText ( "The forums are located here: http://forums.teaandbiscuit.com\n\nThese are the rules;\n\nNo prop surfing\nNo prop killing\nNo prop pushing\nNo prop blocking\nNo prop climbing\nNo prop abuse\nNo sandboxing (Building instead of roleplay)\nNo death matching\nFollow the new life rule, when you die; you are a new person, you CANNOT\ngo back and kill the one who killed you.\n(You don't remember anything)\nNo revenge killing.\nNo resource spamming, this can lag and crash the server\nDon't fight with the admins, you'll only make it worse for yourself.\nThese are all bannable offences.\nUnbans do not occur." )
		myLabel:SizeToContents ()
		myLabel:SetPos ( 5,30 )
	end

	local DermaButton = vgui.Create( "DButton" )
	DermaButton:SetParent( DermaPanel ) 
	DermaButton:SetText( "This didn't help me!" )
	DermaButton:SetPos( 50, 250 )
	DermaButton:SetSize( 300, 48 )
	DermaButton.DoClick = function ()
		local DermaPanel6 = vgui.Create( "DFrame" )
		DermaPanel6:SetPos( 50,50 )
		DermaPanel6:SetSize( 400,500 )
		DermaPanel6:SetTitle( "This didn't help me!" )
		DermaPanel6:SetVisible ( true )
		DermaPanel6:SetDraggable( true )
		DermaPanel6:ShowCloseButton( true )
		DermaPanel6:MakePopup()

		local myLabel= vgui.Create("DLabel", DermaPanel6)
		myLabel:SetText ( "\nIf this didn't help then you should try posting on our fourms;\nhttp://forums.teaandbiscuit.com\n\nOr on Stevo's Help Guide; http://mattsmedievalrp.webs.com/\nSomeone should come on and help you." )
		myLabel:SizeToContents ()
		myLabel:SetPos ( 5,30 )
	end
end
usermessage.Hook("HelpMenu", HelpMenuVGUI)

function LevelMenuVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 450, 50 )
	DermaPanel:SetSize( 260, 550 )
	DermaPanel:SetTitle( "Levels" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Smithing Level: " .. LocalPlayer():GetNWInt("smithinglevel") )
	DermaButton1:SetToolTip( "Your Smithing Level is " .. LocalPlayer():GetNWInt("smithinglevel"))
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 50 )

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Crafting Level: " .. LocalPlayer():GetNWInt("craftinglevel") )
	DermaButton2:SetToolTip( "Your Crafting Level is " .. LocalPlayer():GetNWInt("craftinglevel"))
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 50 )

	local DermaButton3 = vgui.Create( "DButton" )
	DermaButton3:SetParent( DermaPanel )
	DermaButton3:SetText( "Mining Level: " .. LocalPlayer():GetNWInt("mininglevel") )
	DermaButton3:SetToolTip( "Your Mining Level is " .. LocalPlayer():GetNWInt("mininglevel"))
	DermaButton3:SetPos( 25, 160 )
	DermaButton3:SetSize( 210, 50 )

	local DermaButton4 = vgui.Create( "DButton" )
	DermaButton4:SetParent( DermaPanel )
	DermaButton4:SetText( "Lumbering Level: " .. LocalPlayer():GetNWInt("lumberinglevel") )
	DermaButton4:SetToolTip( "Your Lumbering Level is " .. LocalPlayer():GetNWInt("lumberinglevel"))
	DermaButton4:SetPos( 25, 220 )
	DermaButton4:SetSize( 210, 50 )

	local DermaButton5 = vgui.Create( "DButton" )
	DermaButton5:SetParent( DermaPanel )
	DermaButton5:SetText( "Cooking Level: " .. LocalPlayer():GetNWInt("cookinglevel") )
	DermaButton5:SetToolTip( "Your Cooking Level is " .. LocalPlayer():GetNWInt("cookinglevel"))
	DermaButton5:SetPos( 25, 280 )
	DermaButton5:SetSize( 210, 50 )

	local DermaButton6 = vgui.Create( "DButton" )
	DermaButton6:SetParent( DermaPanel )
	DermaButton6:SetText( "Alchemy Level: " .. LocalPlayer():GetNWInt("alchemylevel") )
	DermaButton6:SetToolTip( "Your Alchemy Level is " .. LocalPlayer():GetNWInt("alchemylevel"))
	DermaButton6:SetPos( 25, 340 )
	DermaButton6:SetSize( 210, 50 )

	local DermaButton7 = vgui.Create( "DButton" )
	DermaButton7:SetParent( DermaPanel )
	DermaButton7:SetText( "Fighting Level: " .. LocalPlayer():GetNWInt("fightinglevel") )
	DermaButton7:SetToolTip( "Your Fighting Level is " .. LocalPlayer():GetNWInt("fightinglevel"))
	DermaButton7:SetPos( 25, 400 )
	DermaButton7:SetSize( 210, 50 )

	local DermaButton8 = vgui.Create( "DButton" )
	DermaButton8:SetParent( DermaPanel )
	DermaButton8:SetText( "Fishing Level: " .. LocalPlayer():GetNWInt("fishinglevel") )
	DermaButton8:SetToolTip( "Your Fishing Level is " .. LocalPlayer():GetNWInt("fishinglevel"))
	DermaButton8:SetPos( 25, 460 )
	DermaButton8:SetSize( 210, 50 )

	local DermaButton9 = vgui.Create( "DButton" )
	DermaButton9:SetParent( DermaPanel )
	DermaButton9:SetText( "Magic Level: " .. LocalPlayer():GetNWInt("magiclevel") )
	DermaButton9:SetToolTip( "Your Magic Level is " .. LocalPlayer():GetNWInt("magiclevel"))
	DermaButton9:SetPos( 25, 460 )
	DermaButton9:SetSize( 210, 50 )
end
usermessage.Hook("LevelsMenu", LevelMenuVGUI)

function HUDMenuVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 450, 50 )
	DermaPanel:SetSize( 275, 270 )
	DermaPanel:SetTitle( "HUD" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Toggle your HUD" )
	DermaButton1:SetPos( 25, 30 )
	DermaButton1:SetSize( 225, 50 )
	DermaButton1.DoClick = function ()
		LocalPlayer():ConCommand( "say /hud" )
	end

	local info1 = vgui.Create("DLabel")
	info1:SetParent( DermaPanel )
	info1:SetText("Choose which Experience type to show on your HUD") 
	info1:SizeToContents()
	info1:SetPos( (DermaPanel:GetSize()/2) - (info1:GetSize()/2) , 90 )

	local DermaList1 = vgui.Create("DPanelList")
	DermaList1:SetParent( DermaPanel )
	DermaList1:SetSpacing( 5 )
	DermaList1:SetPos( 5, 110 )
	DermaList1:SetSize( 265, 150 )
	DermaList1:EnableHorizontal(false)
	DermaList1:EnableVerticalScrollbar(true)

	if LocalPlayer():GetNWInt("HUDexpbar") == 1 then
	else
		local Smithing = vgui.Create("DButton")
		Smithing:SetText("Smithing Experience")
		Smithing.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 1" ) end
		DermaList1:AddItem(Smithing)
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 2 then
	else
		local Mining = vgui.Create("DButton") 
		Mining:SetText("Mining Experience")
		Mining.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 2" ) end
		DermaList1:AddItem(Mining)
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 3 then
	else
		local Lumbering = vgui.Create("DButton") 
		Lumbering:SetText("Lumbering Experience")
		Lumbering.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 3" ) end
		DermaList1:AddItem(Lumbering)
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 4 then
	else
		local Crafting = vgui.Create("DButton") 
		Crafting:SetText("Crafting Experience")
		Crafting.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 4" ) end
		DermaList1:AddItem(Crafting)
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 5 then
	else
		local Cooking = vgui.Create("DButton") 
		Cooking:SetText("Cooking Experience")
		Cooking.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 5" ) end
		DermaList1:AddItem(Cooking)
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 6 then
	else
		local Alchemy = vgui.Create("DButton") 
		Alchemy:SetText("Alchemy Experience")
		Alchemy.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 6" ) end
		DermaList1:AddItem(Alchemy)
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 7 then
	else
		local Fighting = vgui.Create("DButton") 
		Fighting:SetText("Fighting Experience")
		Fighting.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 7" ) end
		DermaList1:AddItem(Fighting)
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 8 then
	else
		local Fishing = vgui.Create("DButton") 
		Fishing:SetText("Fishing Experience")
		Fishing.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 8" ) end
		DermaList1:AddItem(Fishing)
	end

	if LocalPlayer():GetNWInt("HUDexpbar") == 9 then
	else
		local Magic = vgui.Create("DButton") 
		Magic:SetText("Magic Experience")
		Magic.DoClick = function() LocalPlayer():ConCommand( "say /hudexpbar 9" ) end
		DermaList1:AddItem(Magic)
	end
end
usermessage.Hook("HUDMenu", HUDMenuVGUI)

function ExpMenuVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 450, 50 )
	DermaPanel:SetSize( 260, 550 )
	DermaPanel:SetTitle( "Experience" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Smithing Experience: " .. LocalPlayer():GetNWInt("smithingexp") )
	DermaButton1:SetToolTip( "Your Smithing Experience is " .. LocalPlayer():GetNWInt("smithingexp"))
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 210, 50 )

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "Crafting Experience: " .. LocalPlayer():GetNWInt("craftingexp") )
	DermaButton2:SetToolTip( "Your Crafting Experience is " .. LocalPlayer():GetNWInt("craftingexp"))
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 210, 50 )

	local DermaButton3 = vgui.Create( "DButton" )
	DermaButton3:SetParent( DermaPanel )
	DermaButton3:SetText( "Mining Experience: " .. LocalPlayer():GetNWInt("miningexp") )
	DermaButton3:SetToolTip( "Your Mining Experience is " .. LocalPlayer():GetNWInt("miningexp"))
	DermaButton3:SetPos( 25, 160 )
	DermaButton3:SetSize( 210, 50 )

	local DermaButton4 = vgui.Create( "DButton" )
	DermaButton4:SetParent( DermaPanel )
	DermaButton4:SetText( "Lumbering Experience: " .. LocalPlayer():GetNWInt("lumberingexp") )
	DermaButton4:SetToolTip( "Your Lumbering Experience is " .. LocalPlayer():GetNWInt("lumberingexp"))
	DermaButton4:SetPos( 25, 220 )
	DermaButton4:SetSize( 210, 50 )

	local DermaButton5 = vgui.Create( "DButton" )
	DermaButton5:SetParent( DermaPanel )
	DermaButton5:SetText( "Cooking Experience: " .. LocalPlayer():GetNWInt("cookingexp") )
	DermaButton5:SetToolTip( "Your Cooking Experience is " .. LocalPlayer():GetNWInt("cookingexp"))
	DermaButton5:SetPos( 25, 280 )
	DermaButton5:SetSize( 210, 50 )
	
	local DermaButton6 = vgui.Create( "DButton" )
	DermaButton6:SetParent( DermaPanel )
	DermaButton6:SetText( "Alchemy Experience: " .. LocalPlayer():GetNWInt("alchemyexp") )
	DermaButton6:SetToolTip( "Your Alchemy Experience is " .. LocalPlayer():GetNWInt("alchemyexp"))
	DermaButton6:SetPos( 25, 340 )
	DermaButton6:SetSize( 210, 50 )

	local DermaButton7 = vgui.Create( "DButton" )
	DermaButton7:SetParent( DermaPanel )
	DermaButton7:SetText( "Fighting Experience: " .. LocalPlayer():GetNWInt("fightingexp") )
	DermaButton7:SetToolTip( "Your Fighting Experience is " .. LocalPlayer():GetNWInt("fightingexp"))
	DermaButton7:SetPos( 25, 400 )
	DermaButton7:SetSize( 210, 50 )

	local DermaButton8 = vgui.Create( "DButton" )
	DermaButton8:SetParent( DermaPanel )
	DermaButton8:SetText( "Fishing Experience: " .. LocalPlayer():GetNWInt("fishingexp") )
	DermaButton8:SetToolTip( "Your Fishing Experience is " .. LocalPlayer():GetNWInt("fishingexp"))
	DermaButton8:SetPos( 25, 460 )
	DermaButton8:SetSize( 210, 50 )

	local DermaButton9 = vgui.Create( "DButton" )
	DermaButton9:SetParent( DermaPanel )
	DermaButton9:SetText( "Magic Experience: " .. LocalPlayer():GetNWInt("magicexp") )
	DermaButton9:SetToolTip( "Your Magic Experience is " .. LocalPlayer():GetNWInt("magicexp"))
	DermaButton9:SetPos( 25, 460 )
	DermaButton9:SetSize( 210, 50 )
end
usermessage.Hook("ExpMenu", ExpMenuVGUI)

function OptionsMenuVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 450, 50 )
	DermaPanel:SetSize( 275, 335 )
	DermaPanel:SetTitle( "Options" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local label = vgui.Create("DLabel")
	label:SetParent( DermaPanel )
	label:SetText("Name")
	label:SizeToContents()
	label:SetPos( (DermaPanel:GetSize()/2) - (label:GetSize()/2) , 25 )

	local DermaText = vgui.Create( "DTextEntry", DermaPanel )
	DermaText:SetParent( DermaPanel )
	DermaText:SetTall( 20 )
	DermaText:SetWide( 120 )
	DermaText:SetPos( (DermaPanel:GetSize()/2) - (DermaText:GetSize()/2) , 45 )
	DermaText:SetEnterAllowed( true )
	DermaText.OnEnter = function()
		LocalPlayer():ConCommand( "say /name "..DermaText:GetValue())
		DermaPanel:SetVisible( false )
	end

	local label = vgui.Create("DLabel")
	label:SetParent( DermaPanel )
	label:SetText("Job")
	label:SizeToContents()
	label:SetPos( (DermaPanel:GetSize()/2) - (label:GetSize()/2) , 70 )

	local DermaText = vgui.Create( "DTextEntry", DermaPanel )
	DermaText:SetParent( DermaPanel )
	DermaText:SetTall( 20 )
	DermaText:SetWide( 120 )
	DermaText:SetPos( (DermaPanel:GetSize()/2) - (DermaText:GetSize()/2) , 90 )
	DermaText:SetEnterAllowed( true )
	DermaText.OnEnter = function()
		LocalPlayer():ConCommand( "say /job "..DermaText:GetValue())
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Sex Change")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 20, 120 )
	DermaButton:SetSize( 235, 25 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "mrp_sexchange" )
	end

	local label = vgui.Create("DLabel")
	label:SetParent( DermaPanel )
	label:SetText("Race") 
	label:SizeToContents()
	label:SetPos( (DermaPanel:GetSize()/2) - (label:GetSize()/2) , 155 )

	local List = vgui.Create("DPanelList")
	List:SetParent( DermaPanel )
	List:SetSpacing(5)
	List:SetPos( 5, 175 )
	List:SetSize( 265, 150 )
	List:EnableHorizontal(false)
	List:EnableVerticalScrollbar(true)

	if LocalPlayer():GetNWString("race") == "Human" then
	else
		local Human = vgui.Create("DButton")
		Human:SetText("Human")
		Human.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_human") end
		List:AddItem(Human)
	end

	if LocalPlayer():GetNWString("race") == "Dwarf" then
	else
		local Dwarf = vgui.Create("DButton") 
		Dwarf:SetText("Dwarf")
		Dwarf.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_dwarf") end
		List:AddItem(Dwarf)
	end

	if LocalPlayer():GetNWString("race") == "Gnome" then
	else
		local Gnome = vgui.Create("DButton") 
		Gnome:SetText("Gnome")
		Gnome.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_gnome") end
		List:AddItem(Gnome)
	end

	if LocalPlayer():GetNWString("race") == "Ogre" then
	else
		local Ogre = vgui.Create("DButton") 
		Ogre:SetText("Ogre")
		Ogre.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_ogre") end
		List:AddItem(Ogre)
	end

	if LocalPlayer():GetNWString("race") == "Goblin" then
	else
		local Goblin = vgui.Create("DButton") 
		Goblin:SetText("Goblin")
		Goblin.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_goblin") end
		List:AddItem(Goblin)
	end

	if LocalPlayer():GetNWString("race") == "Troll" then
	else
		local Troll = vgui.Create("DButton") 
		Troll:SetText("Troll")
		Troll.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_troll") end
		List:AddItem(Troll)
	end

	if LocalPlayer():GetNWString("race") == "Night Elf" then
	else
		local NightElf = vgui.Create("DButton") 
		NightElf:SetText("Night Elf")
		NightElf.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_elf") end
		List:AddItem(NightElf)
	end

	if LocalPlayer():GetNWString("race") == "Dark Elf" then
	else
		local DarkElf = vgui.Create("DButton") 
		DarkElf:SetText("Dark Elf")
		DarkElf.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_darkelf") end
		List:AddItem(DarkElf)
	end

	if LocalPlayer():GetNWString("race") == "Blood Elf" then
	else
		local BloodElf = vgui.Create("DButton") 
		BloodElf:SetText("Blood Elf")
		BloodElf.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_bloodelf") end
		List:AddItem(BloodElf)
	end

	if LocalPlayer():GetNWString("race") == "Undead" then
	else
		local Undead = vgui.Create("DButton") 
		Undead:SetText("Undead")
		Undead.DoClick = function() LocalPlayer():ConCommand("mrp_confirmation_undead") end
		List:AddItem(Undead)
	end
end
usermessage.Hook("OptionsMenu", OptionsMenuVGUI)

function DwarfConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Dwarven Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me a Dwarf!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race dwarf" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nFriendly with the Blood Elves, they became close\nafter the Dwarves saved them from a fierce Ogre Clan".."\n"..
					"Unfriendly with the Ogres, as they are rivals in\nStrength and brute force, and the Ogres seek to\ndestroy the Blood Elves.".."\n"..
					"History;\nFor centuries they lived in their city of Orizimmar,\nhowever they have recently left the comfort of\ntheir city to expand their empire. They have always\nbeen good allies with the gnomes as their cities\nwere close together and both underground. The Blood\nElf refugees recently came to the dwarves pleading\nfor their help, and since then the Dwarves and Blood\nElves now share cities together. They are loyal and\nfierce.\nAs a dwarf it is your responsibility to help expand\nyour empire and to protect your allies.".."\n"..
					"Leader; William Thorian (Matthew).".."\n"..
					"Second in Command; Sir Villelm Ironfist (Spring).")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("DwarfConfirmationMenu", DwarfConfirmation)

function GnomeConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Gnomish Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me a Gnome!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race gnome" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nFriendly with the Humans, due to their common enemy;\nThe Undead, also friendly with the Dwarves due to\nthe closeness of their kingdoms.".."\n"..
					"Unfriendly with the Undead, due to their hatred of\nall things living, and the Goblins, as they are\nrivals in Engineering.".."\n"..
					"History;\nThe gnomes create many weapons which the dwarves wield\ninto battle, as the gnomes are not great fighters.\nThey always support their Dwarven kin even if they\ndo not agree with them. Once the undead appear on the\nearth the gnomes quickly became enemies with them\nand, due to this war, became strong allies\nwith the humans. Gnomes are intelligent and\nresourceful. As Gnome it is your job to create new\ntechnologies and to assist the Gnomish and Dwarven\nempires in any way possible.".."\n"..
					"Leader; Numroth.".."\n"..
					"Second in Command; Nomz.")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("GnomeConfirmationMenu", GnomeConfirmation)

function UndeadConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Undead Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me Undead!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race undead" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nThey have an understanding with the Blood Elves, as\ntheir leader was once a Blood Elf. They enslaved\nOgre Clans.".."\n"..
					"Unfriendly with most races.".."\n"..
					"History;\nJealous of the living, the Undead quickly set\nup a town in the Southeast called Unizab and\nlaunched an attack on the living. However, they\nquickly found that Night Elves were seeking to\ndestroy them and that the Humans and Gnomes had\nallied. Fortunatly, to the Northwest of their new\nbase they found the Ogres. Seeing great strength in\nthem the captured some of them and now use\nthem in their armies. However, they are often\nmisunderstood and hunted down by other races.\nAs an Undead it is your job to destroy the living\nand to spread your infection.".."\n"..
					"Leader; Rutheus DeathBringer(Custard).".."\n"..
					"Second in Command; N/A.")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("UndeadConfirmationMenu", UndeadConfirmation)

function HumanConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Human Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me a Human!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nFriendly with Gnomes, due to their common enemy in the Undead".."\n"..
					"Unfriendly with the Undead, due to their hatred of all things living.".."\n"..
					"History;\nJealous of the living, the Undead quickly set\nup a town in the Southeast called Unizab and\nlaunched an attack on the living. However, they\nquickly found that Night Elves were seeking to\ndestroy them and that the Humans and Gnomes had\nallied. Fortunatly, to the Northwest of their new\nbase they found the Ogres. Seeing great strength in\nthem the captured some of them and now use\nthem in their armies. However, they are often\nmisunderstood and hunted down by other races.\nAs an Undead it is your job to destroy the living\nand to spread your infection.".."\n"..
					"Leader; BlackMack.".."\n"..
					"Second in Command; Quartermaster May.")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("HumanConfirmationMenu", HumanConfirmation)

function GoblinConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Goblin Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me a Goblin!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race goblin" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nFriendly with Ogres, because the Goblins supply Ogres with weaponary".."\n"..
					"Unfriendly with the Gnomes, due to their rivalry in Engineering".."\n"..
					"History;\nAt first the Goblins, along with the Ogres, were\njust tribes. However, the Goblins found some Gnomish\ndevices and quickly learned how to create new\ntechnologies. They supplied many powerful weapons to\ntheir Ogre allies. However, when the Undead took\ntheir allies as hostages they urged what was left of\nthe Ogres to travel north with them and\nhead for The New World. Goblins are intelligent and\ndetermined. As a goblin it is your job to create new\ntechnologies and to help the Ogres however\npossible.".."\n"..
					"Leader; Dehno.".."\n"..
					"Second in Command; Atomic.")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("GoblinConfirmationMenu", GoblinConfirmation)

function TrollConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Troll Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me a Troll!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race troll" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nFriendly with Ogres, because they were going\nto be defeated by the Dwarves and Elves and\nwith Undead, because they sensed a chance to\ntake back their servants, and took it.".."\n"..
					"Unfriendly with the Dark Elves, because they\nfought over land in their home land.".."\n"..
					"History;\nFor centuries they lived on the isle of Tribana\nto the north of the Dark Elves' island. They\nhave been locked in battle for as long as\nanyone can remember, battling over territory\nand resources. They moved to the New World to\nget away from their enemies, only to find that\nthe Dark Elves had moved with them. They allied\nwith the Ogres due to similar lifestyles and\nin a hope to defeat the Dark Elves. As a Troll\nyou are powerful and headstrong.".."\n"..
					"Leader; Zul'Jin(Sprinklez).".."\n"..
					"Second in Command; N/A.")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("TrollConfirmationMenu", TrollConfirmation)

function OgreConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Ogre Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me an Ogre!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race ogre" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nFriendly with Goblins, because they supply the Ogres\nwith weaponary. Enslaved by the Undead.".."\n"..
					"Unfriendly with the Dwarves due to their rivalry in\nstrength, Blood Elves because they seek to destroy\nthem.".."\n"..
					"History;\nThe ogres lived in the Southwestern corner of the\nland. Living close to the Blood Elves they quickly\nbecame jealous of their connection to magic. They\nformed armies and raided the Blood Elven towns\nstealing magical artifacts. They then colinised the\nruins. However, the undead inslaved all of the ogres\nliving in the old Blood Elf town and forced them to\njoin their army. Sensing they were in danger the\nOgres and Goblins travelled North and then left for\nthe new world. Ogres are strong and fierce. As an\nOgre it is your job to either help the undead or to\ndefend against the Undead and destroy the Blood\nElves once and for all.".."\n"..
					"Leader; Jim.".."\n"..
					"Second in Command; Dale.")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("OgreConfirmationMenu", OgreConfirmation)

function ElfConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Night Elf Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me a Night Elf!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race elf" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nThey are not friendly with anyone as they are\nuntrusting towards these newer races, but are\nfriendly with animals.".."\n"..
					"Unfriendly with the most races.".."\n"..
					"History;\nFor millenia the Night Elves lived in The World\nTree seperated from the other races. However, they\nleft their tranquil lifestyle after feeling the\nliving dead walking on the earth. Along with their\nanimal friends they seek to banish the undead from\nthe world. Shortly after leaving the safety of the\nworld tree the blood elves waged war on them,\nseeking to steal their ancient powers. They are now\nuntrusting of all other races. They are resourceful\nand dedicated. As a Night Elf it is your\nresponsibility to protect nature and banish the\nscourge.".."\n"..
					"Leader; Exodar Greenleaf (Someone).".."\n"..
					"Second in Command; No second in command.")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("ElfConfirmationMenu", ElfConfirmation)

function DarkElfConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Dark Elf Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me a Dark Elf!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race darkelf" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nThey are friendly with the Blood Elves, due to\ntheir similar nature".."\n"..
					"Unfriendly with the Trolls, because they fought\nover land in their home land.".."\n"..
					"History;\nFor centuries they lived on the isle of Darthen\nto the south of the Troll's island. They\nhave been locked in battle for as long as\nanyone can remember, battling over territory and\nresources. They moved to the New World to get\naway from their enemies, only to find the\nTrolls had moved with them. They allied with the\nBlood Elves due to their similarities in a hope\nto defeat the trolls. With their new allies\nthey hope to defeat the trolls once and for\nall. As a dark elf you are resourceful and\ndependable.".."\n"..
					"Leader; Avariss Belmont(Apple).".."\n"..
					"Second in Command; Gallievo Bloodrose(Unit 511).")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("DarkElfConfirmationMenu", DarkElfConfirmation)

function BloodElfConfirmation()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 360, 370 )
	DermaPanel:SetTitle( "Blood Elf Background" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("Make me a Blood Elf!")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 30, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		LocalPlayer():ConCommand( "say /race bloodelf" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create("DButton")
	DermaButton:SetText("On second thoughts...\n(Exit)")
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetPos( 200, 310 )
	DermaButton:SetSize( 150, 40 )
	DermaButton.DoClick = function()
		DermaPanel:SetVisible( false )
	end

	local joblabel = vgui.Create("DLabel")
	joblabel:SetText("Permanent Relations;\nFriendly with Dwarves because the Dwarves saved\nthem. They have an understanding with the Undead,\nbecause their leader was once a Blood Elf.".."\n"..
					"Unfriendly with the Night Elves, as the Blood Elves\nlook to take their powers, Ogres because the Ogres\nwant to destroy them.".."\n"..
					"History;\nThe blood elves once lived a peaceful life in the\neastern forests of Falindor. However, one day an\narmy of Ogres rampaged through all of their towns\nand cities seeking to steal the Blood Eleven magic.\nThe refugees who survived travelled north and met\nthe Dwarves who shared a common hatred with the\nOgres. The Blood Elves pleaded for their help. They\nturned into great allies and now share many towns\ntogether. Blood Elves are vengful and cunning. As a\nBlood Elf it is your job to protect what is left of\nyour empire and to get revenge on the Ogres.".."\n"..
					"Leader; Naminé (Stevo).".."\n"..
					"Second in Command; Argas Bloodmoon (Argas).")
	joblabel:SetParent( DermaPanel )
	joblabel:SetPos( 25, 15 )
	joblabel:SetSize( 370, 300 )
end
usermessage.Hook("BloodElfConfirmationMenu", BloodElfConfirmation)

function MapBackground()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map1.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background2" )
	end
end
usermessage.Hook("MapBackgroundMenu", MapBackground)

function Map2Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map2.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background3" )
	end
end
usermessage.Hook("Map2BackgroundMenu", Map2Background)

function Map3Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map3.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background4" )
	end
end
usermessage.Hook("Map3BackgroundMenu", Map3Background)

function Map4Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map4.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background5" )
	end
end
usermessage.Hook("Map4BackgroundMenu", Map4Background)

function Map5Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map5.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background6" )
	end
end
usermessage.Hook("Map5BackgroundMenu", Map5Background)

function Map6Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map6.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background7" )
	end
end
usermessage.Hook("Map6BackgroundMenu", Map6Background)

function Map7Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map7.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background8" )
	end
end
usermessage.Hook("Map7BackgroundMenu", Map7Background)

function Map8Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map8.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background9" )
	end
end
usermessage.Hook("Map8BackgroundMenu", Map8Background)

function Map9Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map9.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background10" )
	end
end
usermessage.Hook("Map9BackgroundMenu", Map9Background)

function Map10Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map10.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background11" )
	end
end
usermessage.Hook("Map10BackgroundMenu", Map10Background)

function Map11Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map11.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background12" )
	end
end
usermessage.Hook("Map11BackgroundMenu", Map11Background)

function Map12Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map12.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background13" )
	end
end
usermessage.Hook("Map12BackgroundMenu", Map12Background)

function Map13Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map13.vtf"
	MapImage = vgui.Create( "DImageButton", DermaPanel ) 
	MapImage:SetPos( 10, 30 )
	MapImage:SetImage( image )
	MapImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	MapImage.DoClick = function()
		DermaPanel:SetVisible( false )
		LocalPlayer():ConCommand( "mrp_map_background14" )
	end
end
usermessage.Hook("Map13BackgroundMenu", Map13Background)

function Map14Background()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 1, 1 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "Background Maps" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local image = "medievalrp/Maps/backgrounds/Map14.vtf"
	local DermaImage = vgui.Create( "DImageButton", DermaPanel ) 
	DermaImage:SetPos( 10, 30 )
	DermaImage:SetImage( image )
	DermaImage:SetSize( (ScrW()/1.02) - 10, (ScrH()/1.05) - 10 )
	DermaImage.DoClick = function()
		DermaPanel:SetVisible( false )
	end
end
usermessage.Hook("Map14BackgroundMenu", Map14Background)

function ConfirmShipPickUpVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 275, 160 )
	DermaPanel:SetTitle( "Are you sure you want to pick your ship up?" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Yes" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 190, 50 )
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_pickupship" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "No" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 190, 50 )
	DermaButton2.DoClick = function ()
		DermaPanel:SetVisible( false )
	end
end
usermessage.Hook("ConfirmShipPickUp", ConfirmShipPickUpVGUI)

function ConfirmCannonPickUpVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 275, 160 )
	DermaPanel:SetTitle( "Are you sure you want to pick your cannon up?" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Yes" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 190, 50 )
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_pickupcannon" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "No" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 190, 50 )
	DermaButton2.DoClick = function ()
		DermaPanel:SetVisible( false )
	end
end
usermessage.Hook("ConfirmCannonPickUp", ConfirmCannonPickUpVGUI)

function ConfirmShipEnterVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 275, 160 )
	DermaPanel:SetTitle( "Are you sure you want to enter your ship?" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Yes" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 190, 50 )
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_entership" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "No" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 190, 50 )
	DermaButton2.DoClick = function ()
		DermaPanel:SetVisible( false )
	end
end
usermessage.Hook("ConfirmShipEnter", ConfirmShipEnterVGUI)

function ConfirmShipComeaboardVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 275, 160 )
	DermaPanel:SetTitle( LocalPlayer():GetNWString("comeaboardname").." wants to come aboard, shall we let them?" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaButton1 = vgui.Create( "DButton" )
	DermaButton1:SetParent( DermaPanel )
	DermaButton1:SetText( "Yes" )
	DermaButton1:SetPos( 25, 40 )
	DermaButton1:SetSize( 190, 50 )
	DermaButton1.DoClick = function ()
		RunConsoleCommand( "mrp_comeaboardship" )
		DermaPanel:SetVisible( false )
	end

	local DermaButton2 = vgui.Create( "DButton" )
	DermaButton2:SetParent( DermaPanel )
	DermaButton2:SetText( "No" )
	DermaButton2:SetPos( 25, 100 )
	DermaButton2:SetSize( 190, 50 )
	DermaButton2.DoClick = function ()
		DermaPanel:SetVisible( false )
	end
end
usermessage.Hook("ConfirmShipComeaboard", ConfirmShipComeaboardVGUI)

function RulesVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetTitle( "Rules" )
	DermaPanel:SetSize( ScrW() - 100, ScrH() - 100 )
	DermaPanel:Center()
	DermaPanel:ShowCloseButton( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:SetVisible( true )
	DermaPanel:MakePopup()
	 
	local HTMLFrame = vgui.Create( "HTML", DermaPanel )
	HTMLFrame:SetPos( 25, 50 )
	HTMLFrame:SetSize( DermaPanel:GetWide() - 50, DermaPanel:GetTall() - 150 )
	HTMLFrame:SetHTML( "www.johnjoemcbob.com" )

	local DermaButton = vgui.Create( "DButton" )
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetText( "Accept" )
	DermaButton:SetSize( 180, 50 )
	DermaButton:SetPos( (HTMLFrame:GetWide()/2)+(DermaButton:GetWide()/2), DermaPanel:GetTall() - 55 )
	DermaButton.DoClick = function ()
		DermaPanel:SetVisible( false )
	end

	local DermaButton = vgui.Create( "DButton" )
	DermaButton:SetParent( DermaPanel )
	DermaButton:SetText( "Leave server" )
	DermaButton:SetSize( 180, 50 )
	DermaButton:SetPos( (HTMLFrame:GetWide()/2)-(DermaButton:GetWide()/2), DermaPanel:GetTall() - 55 )
	DermaButton.DoClick = function ()
		LocalPlayer():ConCommand( "disconnect" )
	end
end
usermessage.Hook("ShowRules", RulesVGUI)

function ShowTip(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	print(txt)
end
usermessage.Hook("ShowTip", ShowTip) 