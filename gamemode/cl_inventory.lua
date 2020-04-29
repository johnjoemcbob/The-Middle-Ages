InventoryTable = { }

--=====================================================
-- Networking functions.
--=====================================================
usermessage.Hook( "SendSavedInventoryItems", function( um )
	local ID =  um:ReadString()
	local Num = um:ReadLong()
	
	InventoryTable[ ID ] = 0
	
	if ( InventoryTable[ ID ] ) then
		InventoryTable[ ID ] = InventoryTable[ ID ] + Num
	end
end )

usermessage.Hook( "GiveItem", function( um )
	local ID = um:ReadString()
	local Num = um:ReadLong()

	if ( InventoryTable[ ID ] ) then
		InventoryTable[ ID ] = InventoryTable[ ID ] + Num
	else
		InventoryTable[ ID ] = 0
		InventoryTable[ ID ] = InventoryTable[ ID ] + Num
	end
end )

usermessage.Hook( "RemoveItem", function( um )
	local ID = um:ReadString()
	local Num = um:ReadLong()
	
	if ( InventoryTable[ ID ] ) then
		InventoryTable[ ID ] = InventoryTable[ ID ] - Num
	end
	
	if ( InventoryTable[ ID ] <= 0 ) then
		InventoryTable[ ID ] = nil
	end
end )

usermessage.Hook( "CleanInventory", function( um )
	table.Empty( InventoryTable )
end )

--=====================================================
-- Menu.
--=====================================================

function InventoryAddon.InventoryMenu()
	InventoryMenuFrame = vgui.Create( "DFrame" )
	InventoryMenuFrame:SetSize( 500, 400 )
	InventoryMenuFrame:Center()
	InventoryMenuFrame:SetTitle( "Backpack" )
	InventoryMenuFrame:SetDraggable( true )
	InventoryMenuFrame:ShowCloseButton( true )
	InventoryMenuFrame:MakePopup()

	local InventoryList = vgui.Create("DPanelList", InventoryMenuFrame)
	InventoryList:SetPos(3, 25)
	InventoryList:SetSize(InventoryMenuFrame:GetWide() - 6, InventoryMenuFrame:GetTall() - 28)
	InventoryList:SetSpacing(2)
	InventoryList:SetPadding(4)
	InventoryList:EnableVerticalScrollbar(true)
	InventoryList:EnableHorizontal(true)

	for k, v in pairs( InventoryTable ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable == nil or itemTable.Name == "Ship" then else
			local Icon = vgui.Create( "SpawnIcon" )
			Icon:SetSize( 64, 64 )
			Icon:SetModel( itemTable.Model )
			Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nCount: " .. v)
			Icon.DoClick = function()
				local OptionsMenu = DermaMenu()
				if itemTable.Edible then
					OptionsMenu:AddOption("Eat", function() LocalPlayer():ConCommand( "InventoryAddon.EatItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if itemTable.Equipable then
					OptionsMenu:AddOption("Equip", function() LocalPlayer():ConCommand( "InventoryAddon.EquipItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if itemTable.Armour then
					OptionsMenu:AddOption("Equip", function() LocalPlayer():ConCommand( "InventoryAddon.EquipArmourItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if itemTable.Drink then
					OptionsMenu:AddOption("Drink", function() LocalPlayer():ConCommand( "InventoryAddon.DrinkItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				OptionsMenu:AddOption("Drop", function() LocalPlayer():ConCommand( "InventoryAddon.DropItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				if v > 4 then
					OptionsMenu:AddOption("Drop 5", function() LocalPlayer():ConCommand( "InventoryAddon.Drop5Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if v > 9 then
					OptionsMenu:AddOption("Drop 10", function() LocalPlayer():ConCommand( "InventoryAddon.Drop10Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				OptionsMenu:Open()
			end
			InventoryList:AddItem(Icon)
		end
	end
end

local function ToggleOpenInventoryMenu()
	InventoryAddon.InventoryMenu()
	InventoryMenuFrame:SetVisible( true )
end
concommand.Add( "+inventoryaddonmenu", ToggleOpenInventoryMenu )

local function ToggleCloseInventoryMenu()
	if ( InventoryMenuFrame ) then
		InventoryMenuFrame:Remove()
		InventoryMenuFrame = nil
	end
end
concommand.Add( "-inventoryaddonmenu", ToggleCloseInventoryMenu )

local function AdminItemMenu()
	local AdminMenuFrame = vgui.Create( "DFrame" )
	AdminMenuFrame:SetSize( ScrW(), ScrH() )
	AdminMenuFrame:Center()
	AdminMenuFrame:SetTitle( "Inventory Addon -> Admin Menu" )
	AdminMenuFrame:SetDraggable( true )
	AdminMenuFrame:ShowCloseButton( true )
	AdminMenuFrame:MakePopup()

	local AdminItemList = vgui.Create( "DPanelList", AdminMenuFrame )
	AdminItemList:SetPos( 5, 30 )
	AdminItemList:SetSize( AdminMenuFrame:GetWide() - 10, AdminMenuFrame:GetTall() - 35 )
	AdminItemList:SetSpacing( 5 )
	AdminItemList:SetPadding( 5 )
	AdminItemList:EnableHorizontal( true )

	for k, v in pairs( InventoryAddon.Items ) do
		local SpawnIcon = vgui.Create( "SpawnIcon" )
		SpawnIcon:SetIconSize( 64 )
		SpawnIcon:SetModel( v.Model )
		SpawnIcon:SetToolTip( "Name: " .. InventoryAddon.Items[ k ].Name .. "\n" .. "Description: " .. InventoryAddon.Items[ k ].Description )
		SpawnIcon.DoClick = function()
			local OptionMenu = DermaMenu()
				OptionMenu:AddOption( "Spawn Item", function() LocalPlayer():ConCommand( "InventoryAddon.AdminSpawnItem " .. k ) end )
			OptionMenu:Open()
		end
		AdminItemList:AddItem( SpawnIcon )
	end
end
concommand.Add( "adminitemmenu", function() if ( LocalPlayer():IsAdmin() ) then AdminItemMenu() end end )

function SmithSellItemMenu()
	SmithSellMenuFrame = vgui.Create( "DFrame" )
	SmithSellMenuFrame:SetSize( 500, 400 )
	SmithSellMenuFrame:Center()
	SmithSellMenuFrame:SetTitle( "Backpack" )
	SmithSellMenuFrame:SetDraggable( true )
	SmithSellMenuFrame:ShowCloseButton( true )
	SmithSellMenuFrame:MakePopup()

	local SmithSellList = vgui.Create("DPanelList", SmithSellMenuFrame)
	SmithSellList:SetPos(3, 25)
	SmithSellList:SetSize(SmithSellMenuFrame:GetWide() - 6, SmithSellMenuFrame:GetTall() - 28)
	SmithSellList:SetSpacing(2)
	SmithSellList:SetPadding(4)
	SmithSellList:EnableVerticalScrollbar(true)
	SmithSellList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	kleiner = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_kleiner" then
			kleiner = true
		end
	end

	for k, v in pairs( InventoryTable ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable == nil then else
			if itemTable.SmithSellable and kleiner == true then
				local ItemPanel = vgui.Create("DPanel")
				ItemPanel:SetSize(55, 55)
				ItemPanel.Paint = function()
					draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
					draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
				end

				local Icon = vgui.Create("DModelPanel", ItemPanel)
				Icon:SetSize(55, 55)
				Icon:SetModel(itemTable.Model)
				Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nCount: " .. v .. "\nPrice: " .. itemTable.Price)

				Icon.DoClick = function()
					local OptionsMenu = DermaMenu()
					OptionsMenu:AddOption("Sell", function() LocalPlayer():ConCommand( "InventoryAddon.SellItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					if v > 4 then
						OptionsMenu:AddOption("Sell 5", function() LocalPlayer():ConCommand( "InventoryAddon.Sell5Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 9 then
						OptionsMenu:AddOption("Sell 10", function() LocalPlayer():ConCommand( "InventoryAddon.Sell10Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 1 then
						OptionsMenu:AddOption("Sell All", function() LocalPlayer():ConCommand( "InventoryAddon.SellAllItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					OptionsMenu:Open()
				end
				SmithSellList:AddItem(ItemPanel)
			end
		end
	end
end
concommand.Add( "+sellsmithmenu", SmithSellItemMenu )

function SmithBuyItemMenu()
	SmithBuyMenuFrame = vgui.Create( "DFrame" )
	SmithBuyMenuFrame:SetSize( 500, 400 )
	SmithBuyMenuFrame:Center()
	SmithBuyMenuFrame:SetTitle( "Blacksmith Trade" )
	SmithBuyMenuFrame:SetDraggable( true )
	SmithBuyMenuFrame:ShowCloseButton( true )
	SmithBuyMenuFrame:MakePopup()

	local SmithBuyList = vgui.Create("DPanelList", SmithBuyMenuFrame)
	SmithBuyList:SetPos(3, 25)
	SmithBuyList:SetSize(SmithBuyMenuFrame:GetWide() - 6, SmithBuyMenuFrame:GetTall() - 28)
	SmithBuyList:SetSpacing(2)
	SmithBuyList:SetPadding(4)
	SmithBuyList:EnableVerticalScrollbar(true)
	SmithBuyList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	kleiner = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_kleiner" then
			kleiner = true
		end
	end

	for k, v in pairs( InventoryAddon.Items ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable.SmithSellable and kleiner == true then
			local ItemPanel = vgui.Create("DPanel")
			ItemPanel:SetSize(55, 55)
			ItemPanel.Paint = function()
				draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
				draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
			end

			local Icon = vgui.Create("DModelPanel", ItemPanel)
			Icon:SetSize(55, 55)
			Icon:SetModel(itemTable.Model)
			Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nPrice: "..itemTable.Price)

			Icon.DoClick = function()
				local OptionsMenu = DermaMenu()
				if LocalPlayer():GetNWInt("gold") >= itemTable.Price then
					OptionsMenu:AddOption("Buy", function() LocalPlayer():ConCommand( "InventoryAddon.BuyItem " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*5) then
					OptionsMenu:AddOption("Buy 5", function() LocalPlayer():ConCommand( "InventoryAddon.Buy5Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*10) then
					OptionsMenu:AddOption("Buy 10", function() LocalPlayer():ConCommand( "InventoryAddon.Buy10Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*50) then
					OptionsMenu:AddOption("Buy 50", function() LocalPlayer():ConCommand( "InventoryAddon.Buy50Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				OptionsMenu:Open()
			end
			SmithBuyList:AddItem(ItemPanel)
		end
	end
end
concommand.Add( "+buysmithmenu", SmithBuyItemMenu )

function FisherSellItemMenu()
	FisherSellMenuFrame = vgui.Create( "DFrame" )
	FisherSellMenuFrame:SetSize( 500, 400 )
	FisherSellMenuFrame:Center()
	FisherSellMenuFrame:SetTitle( "Backpack" )
	FisherSellMenuFrame:SetDraggable( true )
	FisherSellMenuFrame:ShowCloseButton( true )
	FisherSellMenuFrame:MakePopup()

	local FisherSellList = vgui.Create("DPanelList", FisherSellMenuFrame)
	FisherSellList:SetPos(3, 25)
	FisherSellList:SetSize(FisherSellMenuFrame:GetWide() - 6, FisherSellMenuFrame:GetTall() - 28)
	FisherSellList:SetSpacing(2)
	FisherSellList:SetPadding(4)
	FisherSellList:EnableVerticalScrollbar(true)
	FisherSellList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	breen = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_breen" then
			breen = true
		end
	end

	for k, v in pairs( InventoryTable ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable == nil then else
			if itemTable.FisherSellable and breen == true then
				local ItemPanel = vgui.Create("DPanel")
				ItemPanel:SetSize(55, 55)
				ItemPanel.Paint = function()
					draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
					draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
				end

				local Icon = vgui.Create("DModelPanel", ItemPanel)
				Icon:SetSize(55, 55)
				Icon:SetModel(itemTable.Model)
				Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nCount: " .. v .. "\nPrice: " .. itemTable.Price)

				Icon.DoClick = function()
					local OptionsMenu = DermaMenu()
					OptionsMenu:AddOption("Sell", function() LocalPlayer():ConCommand( "InventoryAddon.SellItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					if v > 4 then
						OptionsMenu:AddOption("Sell 5", function() LocalPlayer():ConCommand( "InventoryAddon.Sell5Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 9 then
						OptionsMenu:AddOption("Sell 10", function() LocalPlayer():ConCommand( "InventoryAddon.Sell10Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 1 then
						OptionsMenu:AddOption("Sell All", function() LocalPlayer():ConCommand( "InventoryAddon.SellAllItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					OptionsMenu:Open()
				end
				FisherSellList:AddItem(ItemPanel)
			end
		end
	end
end
concommand.Add( "+sellfishermenu", FisherSellItemMenu )

function FisherBuyItemMenu()
	FisherBuyMenuFrame = vgui.Create( "DFrame" )
	FisherBuyMenuFrame:SetSize( 500, 400 )
	FisherBuyMenuFrame:Center()
	FisherBuyMenuFrame:SetTitle( "Fisherman Trade" )
	FisherBuyMenuFrame:SetDraggable( true )
	FisherBuyMenuFrame:ShowCloseButton( true )
	FisherBuyMenuFrame:MakePopup()

	local FisherBuyList = vgui.Create("DPanelList", FisherBuyMenuFrame)
	FisherBuyList:SetPos(3, 25)
	FisherBuyList:SetSize(FisherBuyMenuFrame:GetWide() - 6, FisherBuyMenuFrame:GetTall() - 28)
	FisherBuyList:SetSpacing(2)
	FisherBuyList:SetPadding(4)
	FisherBuyList:EnableVerticalScrollbar(true)
	FisherBuyList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	breen = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_breen" then
			breen = true
		end
	end

	for k, v in pairs( InventoryAddon.Items ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable.FisherSellable and breen == true then
			local ItemPanel = vgui.Create("DPanel")
			ItemPanel:SetSize(55, 55)
			ItemPanel.Paint = function()
				draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
				draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
			end

			local Icon = vgui.Create("DModelPanel", ItemPanel)
			Icon:SetSize(55, 55)
			Icon:SetModel(itemTable.Model)
			Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nPrice: "..itemTable.Price)

			Icon.DoClick = function()
				local OptionsMenu = DermaMenu()
				if LocalPlayer():GetNWInt("gold") >= itemTable.Price then
					OptionsMenu:AddOption("Buy", function() LocalPlayer():ConCommand( "InventoryAddon.BuyItem " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*5) then
					OptionsMenu:AddOption("Buy 5", function() LocalPlayer():ConCommand( "InventoryAddon.Buy5Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*10) then
					OptionsMenu:AddOption("Buy 10", function() LocalPlayer():ConCommand( "InventoryAddon.Buy10Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*50) then
					OptionsMenu:AddOption("Buy 50", function() LocalPlayer():ConCommand( "InventoryAddon.Buy50Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				OptionsMenu:Open()
			end
			FisherBuyList:AddItem(ItemPanel)
		end
	end
end
concommand.Add( "+buyfishermenu", FisherBuyItemMenu )

function PriestSellItemMenu()
	PriestSellMenuFrame = vgui.Create( "DFrame" )
	PriestSellMenuFrame:SetSize( 500, 400 )
	PriestSellMenuFrame:Center()
	PriestSellMenuFrame:SetTitle( "Backpack" )
	PriestSellMenuFrame:SetDraggable( true )
	PriestSellMenuFrame:ShowCloseButton( true )
	PriestSellMenuFrame:MakePopup()

	local PriestSellList = vgui.Create("DPanelList", PriestSellMenuFrame)
	PriestSellList:SetPos(3, 25)
	PriestSellList:SetSize(PriestSellMenuFrame:GetWide() - 6, PriestSellMenuFrame:GetTall() - 28)
	PriestSellList:SetSpacing(2)
	PriestSellList:SetPadding(4)
	PriestSellList:EnableVerticalScrollbar(true)
	PriestSellList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	monk = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_monk" then
			monk = true
		end
	end

	for k, v in pairs( InventoryTable ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable == nil then else
			if itemTable.PriestSellable and monk == true then
				local ItemPanel = vgui.Create("DPanel")
				ItemPanel:SetSize(55, 55)
				ItemPanel.Paint = function()
					draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
					draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
				end

				local Icon = vgui.Create("DModelPanel", ItemPanel)
				Icon:SetSize(55, 55)
				Icon:SetModel(itemTable.Model)
				Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nCount: " .. v .. "\nPrice: " .. itemTable.Price)

				Icon.DoClick = function()
					local OptionsMenu = DermaMenu()
					OptionsMenu:AddOption("Sell", function() LocalPlayer():ConCommand( "InventoryAddon.SellItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					if v > 4 then
						OptionsMenu:AddOption("Sell 5", function() LocalPlayer():ConCommand( "InventoryAddon.Sell5Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 9 then
						OptionsMenu:AddOption("Sell 10", function() LocalPlayer():ConCommand( "InventoryAddon.Sell10Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 1 then
						OptionsMenu:AddOption("Sell All", function() LocalPlayer():ConCommand( "InventoryAddon.SellAllItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					OptionsMenu:Open()
				end
				PriestSellList:AddItem(ItemPanel)
			end
		end
	end
end
concommand.Add( "+sellpriestmenu", PriestSellItemMenu )

function PriestBuyItemMenu()
	PriestBuyMenuFrame = vgui.Create( "DFrame" )
	PriestBuyMenuFrame:SetSize( 500, 400 )
	PriestBuyMenuFrame:Center()
	PriestBuyMenuFrame:SetTitle( "Priest Trade" )
	PriestBuyMenuFrame:SetDraggable( true )
	PriestBuyMenuFrame:ShowCloseButton( true )
	PriestBuyMenuFrame:MakePopup()

	local PriestBuyList = vgui.Create("DPanelList", PriestBuyMenuFrame)
	PriestBuyList:SetPos(3, 25)
	PriestBuyList:SetSize(PriestBuyMenuFrame:GetWide() - 6, PriestBuyMenuFrame:GetTall() - 28)
	PriestBuyList:SetSpacing(2)
	PriestBuyList:SetPadding(4)
	PriestBuyList:EnableVerticalScrollbar(true)
	PriestBuyList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	monk = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_monk" then
			monk = true
		end
	end

	for k, v in pairs( InventoryAddon.Items ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable.PriestSellable and monk == true then
			local ItemPanel = vgui.Create("DPanel")
			ItemPanel:SetSize(55, 55)
			ItemPanel.Paint = function()
				draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
				draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
			end

			local Icon = vgui.Create("DModelPanel", ItemPanel)
			Icon:SetSize(55, 55)
			Icon:SetModel(itemTable.Model)
			Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nPrice: "..itemTable.Price)

			Icon.DoClick = function()
				local OptionsMenu = DermaMenu()
				if LocalPlayer():GetNWInt("gold") >= itemTable.Price then
					OptionsMenu:AddOption("Buy", function() LocalPlayer():ConCommand( "InventoryAddon.BuyItem " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*5) then
					OptionsMenu:AddOption("Buy 5", function() LocalPlayer():ConCommand( "InventoryAddon.Buy5Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*10) then
					OptionsMenu:AddOption("Buy 10", function() LocalPlayer():ConCommand( "InventoryAddon.Buy10Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*50) then
					OptionsMenu:AddOption("Buy 50", function() LocalPlayer():ConCommand( "InventoryAddon.Buy50Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				OptionsMenu:Open()
			end
			PriestBuyList:AddItem(ItemPanel)
		end
	end
end
concommand.Add( "+buypriestmenu", PriestBuyItemMenu )

function CookSellItemMenu()
	CookSellMenuFrame = vgui.Create( "DFrame" )
	CookSellMenuFrame:SetSize( 500, 400 )
	CookSellMenuFrame:Center()
	CookSellMenuFrame:SetTitle( "Backpack" )
	CookSellMenuFrame:SetDraggable( true )
	CookSellMenuFrame:ShowCloseButton( true )
	CookSellMenuFrame:MakePopup()

	local CookSellList = vgui.Create("DPanelList", CookSellMenuFrame)
	CookSellList:SetPos(3, 25)
	CookSellList:SetSize(CookSellMenuFrame:GetWide() - 6, CookSellMenuFrame:GetTall() - 28)
	CookSellList:SetSpacing(2)
	CookSellList:SetPadding(4)
	CookSellList:EnableVerticalScrollbar(true)
	CookSellList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	mossman = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_mossman" then
			mossman = true
		end
	end

	for k, v in pairs( InventoryTable ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable == nil then else
			if itemTable.CookSellable and mossman == true then
				local ItemPanel = vgui.Create("DPanel")
				ItemPanel:SetSize(55, 55)
				ItemPanel.Paint = function()
					draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
					draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
				end

				local Icon = vgui.Create("DModelPanel", ItemPanel)
				Icon:SetSize(55, 55)
				Icon:SetModel(itemTable.Model)
				Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nCount: " .. v .. "\nPrice: " .. itemTable.Price)

				Icon.DoClick = function()
					local OptionsMenu = DermaMenu()
					OptionsMenu:AddOption("Sell", function() LocalPlayer():ConCommand( "InventoryAddon.SellItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					if v > 4 then
						OptionsMenu:AddOption("Sell 5", function() LocalPlayer():ConCommand( "InventoryAddon.Sell5Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 9 then
						OptionsMenu:AddOption("Sell 10", function() LocalPlayer():ConCommand( "InventoryAddon.Sell10Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 1 then
						OptionsMenu:AddOption("Sell All", function() LocalPlayer():ConCommand( "InventoryAddon.SellAllItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					OptionsMenu:Open()
				end
				CookSellList:AddItem(ItemPanel)
			end
		end
	end
end
concommand.Add( "+sellcookmenu", CookSellItemMenu )

function CookBuyItemMenu()
	CookBuyMenuFrame = vgui.Create( "DFrame" )
	CookBuyMenuFrame:SetSize( 500, 400 )
	CookBuyMenuFrame:Center()
	CookBuyMenuFrame:SetTitle( "Cook Trade" )
	CookBuyMenuFrame:SetDraggable( true )
	CookBuyMenuFrame:ShowCloseButton( true )
	CookBuyMenuFrame:MakePopup()

	local CookBuyList = vgui.Create("DPanelList", CookBuyMenuFrame)
	CookBuyList:SetPos(3, 25)
	CookBuyList:SetSize(CookBuyMenuFrame:GetWide() - 6, CookBuyMenuFrame:GetTall() - 28)
	CookBuyList:SetSpacing(2)
	CookBuyList:SetPadding(4)
	CookBuyList:EnableVerticalScrollbar(true)
	CookBuyList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	mossman = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_mossman" then
			mossman = true
		end
	end

	for k, v in pairs( InventoryAddon.Items ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable.CookSellable and mossman == true then
			local ItemPanel = vgui.Create("DPanel")
			ItemPanel:SetSize(55, 55)
			ItemPanel.Paint = function()
				draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
				draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
			end

			local Icon = vgui.Create("DModelPanel", ItemPanel)
			Icon:SetSize(55, 55)
			Icon:SetModel(itemTable.Model)
			Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nPrice: "..itemTable.Price)

			Icon.DoClick = function()
				local OptionsMenu = DermaMenu()
				if LocalPlayer():GetNWInt("gold") >= itemTable.Price then
					OptionsMenu:AddOption("Buy", function() LocalPlayer():ConCommand( "InventoryAddon.BuyItem " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*5) then
					OptionsMenu:AddOption("Buy 5", function() LocalPlayer():ConCommand( "InventoryAddon.Buy5Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*10) then
					OptionsMenu:AddOption("Buy 10", function() LocalPlayer():ConCommand( "InventoryAddon.Buy10Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*50) then
					OptionsMenu:AddOption("Buy 50", function() LocalPlayer():ConCommand( "InventoryAddon.Buy50Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				OptionsMenu:Open()
			end
			CookBuyList:AddItem(ItemPanel)
		end
	end
end
concommand.Add( "+buycookmenu", CookBuyItemMenu )

function CraftsmanSellItemMenu()
	CraftsmanSellMenuFrame = vgui.Create( "DFrame" )
	CraftsmanSellMenuFrame:SetSize( 500, 400 )
	CraftsmanSellMenuFrame:Center()
	CraftsmanSellMenuFrame:SetTitle( "Backpack" )
	CraftsmanSellMenuFrame:SetDraggable( true )
	CraftsmanSellMenuFrame:ShowCloseButton( true )
	CraftsmanSellMenuFrame:MakePopup()

	local CraftsmanSellList = vgui.Create("DPanelList", CraftsmanSellMenuFrame)
	CraftsmanSellList:SetPos(3, 25)
	CraftsmanSellList:SetSize(CraftsmanSellMenuFrame:GetWide() - 6, CraftsmanSellMenuFrame:GetTall() - 28)
	CraftsmanSellList:SetSpacing(2)
	CraftsmanSellList:SetPadding(4)
	CraftsmanSellList:EnableVerticalScrollbar(true)
	CraftsmanSellList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	rebel = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_gman" and v:GetModel() == "models/humans/group03/male_07.mdl" then
			rebel = true
		end
	end

	for k, v in pairs( InventoryTable ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable == nil then else
			if itemTable.CraftsmanSellable and rebel == true then
				local ItemPanel = vgui.Create("DPanel")
				ItemPanel:SetSize(55, 55)
				ItemPanel.Paint = function()
					draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
					draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
				end

				local Icon = vgui.Create("DModelPanel", ItemPanel)
				Icon:SetSize(55, 55)
				Icon:SetModel(itemTable.Model)
				Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nCount: " .. v .. "\nPrice: " .. itemTable.Price)

				Icon.DoClick = function()
					local OptionsMenu = DermaMenu()
					OptionsMenu:AddOption("Sell", function() LocalPlayer():ConCommand( "InventoryAddon.SellItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					if v > 4 then
						OptionsMenu:AddOption("Sell 5", function() LocalPlayer():ConCommand( "InventoryAddon.Sell5Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 9 then
						OptionsMenu:AddOption("Sell 10", function() LocalPlayer():ConCommand( "InventoryAddon.Sell10Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 1 then
						OptionsMenu:AddOption("Sell All", function() LocalPlayer():ConCommand( "InventoryAddon.SellAllItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					OptionsMenu:Open()
				end
				CraftsmanSellList:AddItem(ItemPanel)
			end
		end
	end
end
concommand.Add( "+sellcraftsmanmenu", CraftsmanSellItemMenu )

function CraftsmanBuyItemMenu()
	CraftsmanBuyMenuFrame = vgui.Create( "DFrame" )
	CraftsmanBuyMenuFrame:SetSize( 500, 400 )
	CraftsmanBuyMenuFrame:Center()
	CraftsmanBuyMenuFrame:SetTitle( "Craftsman Trade" )
	CraftsmanBuyMenuFrame:SetDraggable( true )
	CraftsmanBuyMenuFrame:ShowCloseButton( true )
	CraftsmanBuyMenuFrame:MakePopup()

	local CraftsmanBuyList = vgui.Create("DPanelList", CraftsmanBuyMenuFrame)
	CraftsmanBuyList:SetPos(3, 25)
	CraftsmanBuyList:SetSize(CraftsmanBuyMenuFrame:GetWide() - 6, CraftsmanBuyMenuFrame:GetTall() - 28)
	CraftsmanBuyList:SetSpacing(2)
	CraftsmanBuyList:SetPadding(4)
	CraftsmanBuyList:EnableVerticalScrollbar(true)
	CraftsmanBuyList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	rebel = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_gman" and v:GetModel() == "models/humans/group03/male_07.mdl" then
			rebel = true
		end
	end

	for k, v in pairs( InventoryAddon.Items ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable.CraftsmanSellable and rebel == true then
			local ItemPanel = vgui.Create("DPanel")
			ItemPanel:SetSize(55, 55)
			ItemPanel.Paint = function()
				draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
				draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
			end

			local Icon = vgui.Create("DModelPanel", ItemPanel)
			Icon:SetSize(55, 55)
			Icon:SetModel(itemTable.Model)
			Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nPrice: "..itemTable.Price)

			Icon.DoClick = function()
				local OptionsMenu = DermaMenu()
				if LocalPlayer():GetNWInt("gold") >= itemTable.Price then
					OptionsMenu:AddOption("Buy", function() LocalPlayer():ConCommand( "InventoryAddon.BuyItem " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*5) then
					OptionsMenu:AddOption("Buy 5", function() LocalPlayer():ConCommand( "InventoryAddon.Buy5Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*10) then
					OptionsMenu:AddOption("Buy 10", function() LocalPlayer():ConCommand( "InventoryAddon.Buy10Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*50) then
					OptionsMenu:AddOption("Buy 50", function() LocalPlayer():ConCommand( "InventoryAddon.Buy50Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				OptionsMenu:Open()
			end
			CraftsmanBuyList:AddItem(ItemPanel)
		end
	end
end
concommand.Add( "+buycraftsmanmenu", CraftsmanBuyItemMenu )

function LabourerSellItemMenu()
	LabourerSellMenuFrame = vgui.Create( "DFrame" )
	LabourerSellMenuFrame:SetSize( 500, 400 )
	LabourerSellMenuFrame:Center()
	LabourerSellMenuFrame:SetTitle( "Backpack" )
	LabourerSellMenuFrame:SetDraggable( true )
	LabourerSellMenuFrame:ShowCloseButton( true )
	LabourerSellMenuFrame:MakePopup()

	local LabourerSellList = vgui.Create("DPanelList", LabourerSellMenuFrame)
	LabourerSellList:SetPos(3, 25)
	LabourerSellList:SetSize(LabourerSellMenuFrame:GetWide() - 6, LabourerSellMenuFrame:GetTall() - 28)
	LabourerSellList:SetSpacing(2)
	LabourerSellList:SetPadding(4)
	LabourerSellList:EnableVerticalScrollbar(true)
	LabourerSellList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	rebel = nil
	for k,v in pairs(foundents) do
		if v:GetClass() == "npc_gman" and v:GetModel() == "models/humans/group03/male_06.mdl" or (v:GetClass() == "npc_gman" and v:GetModel() == "models/undead/undead.mdl") then
			rebel = true
		end
	end

	for k, v in pairs( InventoryTable ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable == nil then else
			if itemTable.LabourerSellable and rebel == true then
				local ItemPanel = vgui.Create("DPanel")
				ItemPanel:SetSize(55, 55)
				ItemPanel.Paint = function()
					draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
					draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
				end

				local Icon = vgui.Create("DModelPanel", ItemPanel)
				Icon:SetSize(55, 55)
				Icon:SetModel(itemTable.Model)
				Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nCount: " .. v .. "\nPrice: " .. itemTable.Price)

				Icon.DoClick = function()
					local OptionsMenu = DermaMenu()
					OptionsMenu:AddOption("Sell", function() LocalPlayer():ConCommand( "InventoryAddon.SellItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					if v > 4 then
						OptionsMenu:AddOption("Sell 5", function() LocalPlayer():ConCommand( "InventoryAddon.Sell5Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 9 then
						OptionsMenu:AddOption("Sell 10", function() LocalPlayer():ConCommand( "InventoryAddon.Sell10Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 1 then
						OptionsMenu:AddOption("Sell All", function() LocalPlayer():ConCommand( "InventoryAddon.SellAllItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					OptionsMenu:Open()
				end
				LabourerSellList:AddItem(ItemPanel)
			end
		end
	end
end
concommand.Add( "+selllabourermenu", LabourerSellItemMenu )

function FarmerSellItemMenu()
	FarmerSellMenuFrame = vgui.Create( "DFrame" )
	FarmerSellMenuFrame:SetSize( 500, 400 )
	FarmerSellMenuFrame:Center()
	FarmerSellMenuFrame:SetTitle( "Backpack" )
	FarmerSellMenuFrame:SetDraggable( true )
	FarmerSellMenuFrame:ShowCloseButton( true )
	FarmerSellMenuFrame:MakePopup()

	local FarmerSellList = vgui.Create("DPanelList", FarmerSellMenuFrame)
	FarmerSellList:SetPos(3, 25)
	FarmerSellList:SetSize(FarmerSellMenuFrame:GetWide() - 6, FarmerSellMenuFrame:GetTall() - 28)
	FarmerSellList:SetSpacing(2)
	FarmerSellList:SetPadding(4)
	FarmerSellList:EnableVerticalScrollbar(true)
	FarmerSellList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	npc = nil
	for k,v in pairs(foundents) do
		if (v:GetClass() == "npc_mossman" and v:GetModel() == "models/undead/undead.mdl") or (v:GetClass() == "npc_mossman" and v:GetModel() == "models/humans/group03/male_07.mdl") then
			npc = true
		end
	end

	for k, v in pairs( InventoryTable ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable == nil then else
			if itemTable.FarmerSellable and npc == true then
				local ItemPanel = vgui.Create("DPanel")
				ItemPanel:SetSize(55, 55)
				ItemPanel.Paint = function()
					draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
					draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
				end

				local Icon = vgui.Create("DModelPanel", ItemPanel)
				Icon:SetSize(55, 55)
				Icon:SetModel(itemTable.Model)
				Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nCount: " .. v .. "\nPrice: " .. itemTable.Price)

				Icon.DoClick = function()
					local OptionsMenu = DermaMenu()
					OptionsMenu:AddOption("Sell", function() LocalPlayer():ConCommand( "InventoryAddon.SellItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					if v > 4 then
						OptionsMenu:AddOption("Sell 5", function() LocalPlayer():ConCommand( "InventoryAddon.Sell5Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 9 then
						OptionsMenu:AddOption("Sell 10", function() LocalPlayer():ConCommand( "InventoryAddon.Sell10Item " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					if v > 1 then
						OptionsMenu:AddOption("Sell All", function() LocalPlayer():ConCommand( "InventoryAddon.SellAllItem " .. k ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
					end
					OptionsMenu:Open()
				end
				FarmerSellList:AddItem(ItemPanel)
			end
		end
	end
end
concommand.Add( "+sellfarmermenu", FarmerSellItemMenu )

function FarmerBuyItemMenu()
	FarmerBuyMenuFrame = vgui.Create( "DFrame" )
	FarmerBuyMenuFrame:SetSize( 500, 400 )
	FarmerBuyMenuFrame:Center()
	FarmerBuyMenuFrame:SetTitle( "Farmer Trade" )
	FarmerBuyMenuFrame:SetDraggable( true )
	FarmerBuyMenuFrame:ShowCloseButton( true )
	FarmerBuyMenuFrame:MakePopup()

	local FarmerBuyList = vgui.Create("DPanelList", FarmerBuyMenuFrame)
	FarmerBuyList:SetPos(3, 25)
	FarmerBuyList:SetSize(FarmerBuyMenuFrame:GetWide() - 6, FarmerBuyMenuFrame:GetTall() - 28)
	FarmerBuyList:SetSpacing(2)
	FarmerBuyList:SetPadding(4)
	FarmerBuyList:EnableVerticalScrollbar(true)
	FarmerBuyList:EnableHorizontal(true)

	local foundents = ents.FindInSphere(Vector(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, LocalPlayer():GetPos().z), 100)
	npc = nil
	for k,v in pairs(foundents) do
		if (v:GetClass() == "npc_mossman" and v:GetModel() == "models/undead/undead.mdl") or (v:GetClass() == "npc_mossman" and v:GetModel() == "models/humans/group03/male_07.mdl") then
			npc = true
		end
	end

	for k, v in pairs( InventoryAddon.Items ) do
		local itemTable = InventoryAddon.Items[ k ]
		if itemTable.FarmerSellable and npc == true then
			local ItemPanel = vgui.Create("DPanel")
			ItemPanel:SetSize(55, 55)
			ItemPanel.Paint = function()
				draw.RoundedBox(6, 0, 0, ItemPanel:GetWide(), ItemPanel:GetTall(), Color(10, 10, 10, 255))
				draw.RoundedBox(6, 1, 1, ItemPanel:GetWide() - 2, ItemPanel:GetTall() - 2, Color(100, 100, 100, 200))
			end

			local Icon = vgui.Create("DModelPanel", ItemPanel)
			Icon:SetSize(55, 55)
			Icon:SetModel(itemTable.Model)
			Icon:SetToolTip("Name: " .. itemTable.Name .. "\nDescription: " .. itemTable.Description .. "\nPrice: "..itemTable.Price)

			Icon.DoClick = function()
				local OptionsMenu = DermaMenu()
				if LocalPlayer():GetNWInt("gold") >= itemTable.Price then
					OptionsMenu:AddOption("Buy", function() LocalPlayer():ConCommand( "InventoryAddon.BuyItem " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*5) then
					OptionsMenu:AddOption("Buy 5", function() LocalPlayer():ConCommand( "InventoryAddon.Buy5Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*10) then
					OptionsMenu:AddOption("Buy 10", function() LocalPlayer():ConCommand( "InventoryAddon.Buy10Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				if LocalPlayer():GetNWInt("gold") >= (itemTable.Price*50) then
					OptionsMenu:AddOption("Buy 50", function() LocalPlayer():ConCommand( "InventoryAddon.Buy50Item " .. k .. " " .. itemTable.Price ) LocalPlayer():ConCommand( "-inventoryaddonmenu" ) end )
				end
				OptionsMenu:Open()
			end
			FarmerBuyList:AddItem(ItemPanel)
		end
	end
end
concommand.Add( "+buyfarmermenu", FarmerBuyItemMenu ) 