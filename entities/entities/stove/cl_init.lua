include("shared.lua")

function CookingVGUI()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 200, 50 )
	DermaPanel:SetSize( 350, 350 )
	DermaPanel:SetTitle( "Cooking" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()

	local DermaList1 = vgui.Create("DPanelList")
	DermaList1:SetParent( DermaPanel )
	DermaList1:SetSpacing( 5 )
	DermaList1:SetPos( 5, 30 )
	DermaList1:SetSize( 340, 325 )
	DermaList1:EnableHorizontal(false)
	DermaList1:EnableVerticalScrollbar(true)

	local Recipe = vgui.Create("DButton")
	Recipe:SetText("Bread")
	Recipe:SetToolTip( "Some Bread\n".."2 Dough Required.\n".."(Place on/next to the stove)")
	Recipe.DoClick = function()
		RunConsoleCommand("create_bread")
	end
	DermaList1:AddItem(Recipe)

	local Recipe = vgui.Create("DButton")
	Recipe:SetText("Roasted Mushroom")
	Recipe:SetToolTip( "A Roasted Mushroom\n".."1 Mushroom Required.\n".."(Place on/next to the stove)")
	Recipe.DoClick = function()
		RunConsoleCommand("create_mushroom_roasted")
	end
	DermaList1:AddItem(Recipe)

	local Recipe = vgui.Create("DButton")
	Recipe:SetText("Gold Fish")
	Recipe:SetToolTip( "A Cooked Gold Fish\n".."1 Gold Fish Required.\n".."(Place on/next to the stove)")
	Recipe.DoClick = function()
		RunConsoleCommand("create_goldfish")
	end
	DermaList1:AddItem(Recipe)

	local Recipe = vgui.Create("DButton")
	Recipe:SetText("Tuna Fish")
	Recipe:SetToolTip( "A Cooked Tuna Fish\n".."1 Tuna Fish Required.\n".."(Place on/next to the stove)")
	Recipe.DoClick = function()
		RunConsoleCommand("create_tunafish")
	end
	DermaList1:AddItem(Recipe)

	local Recipe = vgui.Create("DButton")
	Recipe:SetText("Damsel Fish")
	Recipe:SetToolTip( "A Cooked Damsel Fish\n".."1 Damsel Fish Required.\n".."(Place on/next to the stove)")
	Recipe.DoClick = function()
		RunConsoleCommand("create_damselfish")
	end
	DermaList1:AddItem(Recipe)

	local Recipe = vgui.Create("DButton")
	Recipe:SetText("Grammabasslet Fish")
	Recipe:SetToolTip( "A Cooked Grammabasslet Fish\n".."1 Grammabasslet Fish Required.\n".."(Place on/next to the stove)")
	Recipe.DoClick = function()
		RunConsoleCommand("create_bassletfish")
	end
	DermaList1:AddItem(Recipe)

	local Recipe = vgui.Create("DButton")
	Recipe:SetText("Moorish Idol Fish")
	Recipe:SetToolTip( "A Cooked Moorish Idol Fish\n".."1 Moorish Idol Fish Required.\n".."(Place on/next to the stove)")
	Recipe.DoClick = function()
		RunConsoleCommand("create_moorishidolfish")
	end
	DermaList1:AddItem(Recipe)
end
usermessage.Hook("CookingMenu", CookingVGUI) 