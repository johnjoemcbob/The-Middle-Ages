InventoryAddon.Config = { }

-- The "[InventoryAddon] This server is running InventoryAddon version: 1.0 by: Chewgum."
InventoryAddon.Config[ "NotifyInventoryAddon" ] = true -- false will turn it off.

-- The addons version.
InventoryAddon.Config[ "Version" ] = "1.0"

-- Author, you can add your name if you edit it.
InventoryAddon.Config[ "Author" ] = "Chewgum"

-- Send the client all items.
for k, v in pairs( file.Find( "items/*.lua", "LUA" ) ) do AddCSLuaFile( "items/" .. v ) end

--=====================================================
-- Inventory and player functions.
--=====================================================
InventoryData = { }

function InventoryAddon:SaveInventoryData( ply )
	local Data = util.TableToKeyValues( InventoryData[ ply:UniqueID() ] )
	if string.find(Data, "1") or string.find(Data, "2") or string.find(Data, "3") or string.find(Data, "4") or string.find(Data, "5") or string.find(Data, "6") or string.find(Data, "7") or string.find(Data, "8") or string.find(Data, "9") then
		file.Write( "InventoryAddon/Data/" .. ply:UniqueID() .. ".txt", Data )
	else
		-- InventoryAddon.LoadInventoryData( ply )
	end
end

function InventoryAddon.LoadInventoryData( ply )
	if ( file.Exists( "InventoryAddon/Data/" .. tostring( ply:UniqueID() ) .. ".txt", "DATA" ) ) then
		local Data = util.KeyValuesToTable( file.Read( "InventoryAddon/Data/" .. ply:UniqueID() .. ".txt" ) )

		InventoryData[ ply:UniqueID() ] = Data
		ply:SendSavedInventoryItems()
	else
		InventoryData[ ply:UniqueID() ] = { }
		InventoryAddon:SaveInventoryData( ply )
	end
end
hook.Add( "PlayerInitialSpawn", "LoadInventoryData", InventoryAddon.LoadInventoryData )

function InventoryAddon.ClearInventoryData( ply )
	InventoryData[ ply:UniqueID() ] = { }
	InventoryAddon:SaveInventoryData( ply )
end
concommand.Add("mrp_clearbackpack", InventoryAddon.ClearInventoryData)

function InventoryAddon.SaveInventoryOnDisconnect( ply )
	InventoryAddon:SaveInventoryData( ply )
end
hook.Add( "PlayerDisconnected", "InventoryAddon.SaveInventoryOnDisconnect", InventoryAddon.SaveInventoryOnDisconnect )

local PMeta = FindMetaTable( "Player" )

function PMeta:CleanInventory()
	umsg.Start( "CleanInventory", self )
	umsg.End()
end

function PMeta:GiveItem( item, amount )
	if ( amount != 0 ) then
		if ( InventoryData[ self:UniqueID() ][ item ] ) then
			InventoryData[ self:UniqueID() ][ item ] = InventoryData[ self:UniqueID() ][ item ] + amount
		else
			InventoryData[ self:UniqueID() ][ item ] = 0
			InventoryData[ self:UniqueID() ][ item ] = InventoryData[ self:UniqueID() ][ item ] + amount
		end
	end
	InventoryAddon:SaveInventoryData( self )

	umsg.Start( "GiveItem", self )
		umsg.String( tostring( item ) )
		if ( amount != 0 ) then
			umsg.Long( amount )
		end
	umsg.End()
end

function PMeta:RemoveItem( item, amount )
	if ( amount != 0 ) then
		InventoryData[ self:UniqueID() ][ item ] = InventoryData[ self:UniqueID() ][ item ] - amount
	end

	if ( InventoryData[ self:UniqueID() ][ item ] == 0 ) then
		InventoryData[ self:UniqueID() ][ item ] = nil
	end
	InventoryAddon:SaveInventoryData( self )

	umsg.Start( "RemoveItem", self )
		umsg.String( tostring( item ) )
		if ( amount != 0 ) then
			umsg.Long( amount )
		end
	umsg.End()
end

function PMeta:MakeDrunk( a )
	a = a / 10 * 2
	self:ConCommand( "pp_motionblur 1" )
	--self:ConCommand( "pp_motionblur_addalpha " .. 0.05 * a )
	self:ConCommand( "pp_motionblur_addalpha " .. 0.06 )
	self:ConCommand( "pp_motionblur_delay " .. 0.035 * a )
	self:ConCommand( "pp_motionblur_drawalpha 1.00" )
	self:ConCommand( "pp_dof 1" )
	self:ConCommand( "pp_dof_initlength 9" )
	self:ConCommand( "pp_dof_spacing 8" )
	timer.Simple( 40 * a, function() self:ConCommand( "pp_motionblur 0" ) self:ConCommand( "pp_dof 0" ) end )
end

function PMeta:SendSavedInventoryItems()
	self:CleanInventory()
	
	for k, v in pairs( InventoryData[ self:UniqueID() ] ) do
		umsg.Start( "SendSavedInventoryItems", self )
			umsg.String( k )
			umsg.Long( v )
		umsg.End()
	end
end

function PMeta:SendSavedGold()
	for k, v in pairs( GoldData[ self:UniqueID() ] ) do
		if k == "gold" then
			self:SetNWInt("gold", v)
			GoldData[ self:UniqueID() ][ "gold" ] = v
		else
			GoldData[ self:UniqueID() ][ "gold" ] = 500
			self:SetNWInt("gold", 500)
		end
	end
end

function PMeta:SendSavedSmithingLevel()
	for k, v in pairs( SmithingLevelData[ self:UniqueID() ] ) do
		if k == "smithinglevel" then
			self:SetNWInt("smithinglevel", v)

		elseif k == "smithingexp" then
			self:SetNWInt("smithingexp", v)

		else
			self:SetNWInt("smithinglevel", 1)

			self:SetNWInt("smithingexp", 0)
		end
	end
end

function PMeta:SendSavedCraftingLevel()
	for k, v in pairs( CraftingLevelData[ self:UniqueID() ] ) do
		if k == "craftinglevel" then
			self:SetNWInt("craftinglevel", v)

		elseif k == "craftingexp" then
			self:SetNWInt("craftingexp", v)

		else
			self:SetNWInt("craftinglevel", 1)

			self:SetNWInt("craftingexp", 0)
		end
	end
end

function PMeta:SendSavedLumberingLevel()
	for k, v in pairs( LumberingLevelData[ self:UniqueID() ] ) do
		if k == "lumberinglevel" then
			self:SetNWInt("lumberinglevel", v)

		elseif k == "lumberingexp" then
			self:SetNWInt("lumberingexp", v)

		else
			self:SetNWInt("lumberinglevel", 1)

			self:SetNWInt("lumberingexp", 0)
		end
	end
end

function PMeta:SendSavedMiningLevel()
	for k, v in pairs( MiningLevelData[ self:UniqueID() ] ) do
		if k == "mininglevel" then
			self:SetNWInt("mininglevel", v)

		elseif k == "miningexp" then
			self:SetNWInt("miningexp", v)

		else
			self:SetNWInt("mininglevel", 1)

			self:SetNWInt("miningexp", 0)
		end
	end
end

function PMeta:SendSavedCookingLevel()
	for k, v in pairs( CookingLevelData[ self:UniqueID() ] ) do
		if k == "cookinglevel" then
			self:SetNWInt("cookinglevel", v)

		elseif k == "cookingexp" then
			self:SetNWInt("cookingexp", v)

		else
			self:SetNWInt("cookinglevel", 1)

			self:SetNWInt("cookingexp", 0)
		end
	end
end

function PMeta:SendSavedAlchemyLevel()
	for k, v in pairs( AlchemyLevelData[ self:UniqueID() ] ) do
		if k == "alchemylevel" then
			self:SetNWInt("alchemylevel", v)

		elseif k == "alchemyexp" then
			self:SetNWInt("alchemyexp", v)

		else
			self:SetNWInt("alchemylevel", 1)

			self:SetNWInt("alchemyexp", 0)
		end
	end
end

function PMeta:SendSavedFishingLevel()
	for k, v in pairs( FishingLevelData[ self:UniqueID() ] ) do
		if k == "fishinglevel" then
			self:SetNWInt("fishinglevel", v)

		elseif k == "fishingexp" then
			self:SetNWInt("fishingexp", v)

		else
			self:SetNWInt("fishinglevel", 1)

			self:SetNWInt("fishingexp", 0)
		end
	end
end

function PMeta:SendSavedFightingLevel()
	for k, v in pairs( FightingLevelData[ self:UniqueID() ] ) do
		if k == "fightinglevel" then
			self:SetNWInt("fightinglevel", v)

		elseif k == "fightingexp" then
			self:SetNWInt("fightingexp", v)

		else
			self:SetNWInt("fightinglevel", 1)

			self:SetNWInt("fightingexp", 0)
		end
	end
end

function PMeta:SendSavedMagicLevel()
	for k, v in pairs( MagicLevelData[ self:UniqueID() ] ) do
		if k == "magiclevel" then
			self:SetNWInt("magiclevel", v)

		elseif k == "magicexp" then
			self:SetNWInt("magicexp", v)

		else
			self:SetNWInt("magiclevel", 1)

			self:SetNWInt("magicexp", 0)
		end
	end
end

PMeta = nil

--=====================================================
-- Item functions.
--=====================================================
function InventoryAddon:SpawnItem( ply, ID )
	if ( InventoryAddon.Items[ ID ] == nil ) then ShowTipPlayer(self.Owner, 0, 4, "Item class does not exist.", ply, false ) return end
	
	local tr = ply:EyeTrace( 80 )
	local Item = ents.Create( "inventoryaddon_item" )
	Item:SetModel( InventoryAddon.Items[ ID ].Model )
	Item:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
	Item.InfoTable = InventoryAddon.Items[ ID ]
	Item:Spawn( )
	Item:SetNWString( "Name", InventoryAddon.Items[ ID ].Name )
	Item:Activate( )
end

function InventoryAddon.AdminSpawnItem( ply, cmd, args )
	if ( ply:IsAdmin() ) then
		InventoryAddon:SpawnItem( ply, args[ 1 ] )
	else
		ShowTipPlayer(self.Owner, 0, 4, "Stop haxxor", ply, false ) -- D:<
		return
	end
end
concommand.Add( "InventoryAddon.AdminSpawnItem", InventoryAddon.AdminSpawnItem )

function InventoryAddon.DropItem( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			InventoryAddon.Items[ args[ 1 ] ]:USE( ply )

			if ( InventoryAddon.Items[ args[ 1 ] ].RemoveOnUse ) then
				ply:RemoveItem( args[ 1 ], 1 )
			end
			InventoryAddon:SaveInventoryData( ply )

			return
		end
	end
end 
concommand.Add( "InventoryAddon.DropItem", InventoryAddon.DropItem )

function InventoryAddon.Drop5Item( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			if v > 4 then else return end
			for i=1,5 do
				InventoryAddon.Items[ args[ 1 ] ]:USE( ply )
			end

			if ( InventoryAddon.Items[ args[ 1 ] ].RemoveOnUse ) then
				ply:RemoveItem( args[ 1 ], 5 )
			end
			InventoryAddon:SaveInventoryData( ply )

			return
		end
	end
end 
concommand.Add( "InventoryAddon.Drop5Item", InventoryAddon.Drop5Item )

function InventoryAddon.Drop10Item( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?

	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			if v > 9 then else return end
			for i=1,10 do
				InventoryAddon.Items[ args[ 1 ] ]:USE( ply )
			end

			if ( InventoryAddon.Items[ args[ 1 ] ].RemoveOnUse ) then
				ply:RemoveItem( args[ 1 ], 10 )
			end
			InventoryAddon:SaveInventoryData( ply )

			return
		end
	end
end 
concommand.Add( "InventoryAddon.Drop10Item", InventoryAddon.Drop10Item )

function InventoryAddon.EatItem( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			ply:RemoveItem( args[ 1 ], 1 )
			EatFood(ply, math.random( 40, 80 ))
			InventoryAddon:SaveInventoryData( ply )
			return
		end
	end
end 
concommand.Add( "InventoryAddon.EatItem", InventoryAddon.EatItem )

function InventoryAddon.EquipItem( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			InventoryAddon.Items[ args[ 1 ] ]:EQUIP( ply )
			ply:RemoveItem( args[ 1 ], 1 )
			InventoryAddon:SaveInventoryData( ply )
			return
		end
	end
end 
concommand.Add( "InventoryAddon.EquipItem", InventoryAddon.EquipItem )

function InventoryAddon.EquipArmour( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			InventoryAddon.Items[ args[ 1 ] ]:EQUIPARMOUR( ply )
			InventoryAddon:SaveInventoryData( ply )
			return
		end
	end
end 
concommand.Add( "InventoryAddon.EquipArmourItem", InventoryAddon.EquipArmour )

function InventoryAddon.DrinkItem( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			ply:RemoveItem( args[ 1 ], 1 )
			InventoryAddon.Items[ args[ 1 ] ]:DRINK( ply )
			InventoryAddon:SaveInventoryData( ply )
			return
		end
	end
end 
concommand.Add( "InventoryAddon.DrinkItem", InventoryAddon.DrinkItem )

function InventoryAddon.SellItem( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			InventoryAddon.Items[ args[ 1 ] ]:SELL( ply )
			ply:RemoveItem( args[ 1 ], 1 )
			ShowTipPlayer(ply, 0, 4, "Sold "..InventoryAddon.Items[ args[ 1 ] ].Name.."." )
			InventoryAddon:SaveInventoryData( ply )
			return
		end
	end
end 
concommand.Add( "InventoryAddon.SellItem", InventoryAddon.SellItem )

function InventoryAddon.Sell5Item( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			if v > 4 then else return end
			for i=1,5 do
				InventoryAddon.Items[ args[ 1 ] ]:SELL( ply )
			end
			ply:RemoveItem( args[ 1 ], 5 )
			ShowTipPlayer(ply, 0, 4, "Sold 5 "..InventoryAddon.Items[ args[ 1 ] ].Name.."." )
			InventoryAddon:SaveInventoryData( ply )
			return
		end
	end
end 
concommand.Add( "InventoryAddon.Sell5Item", InventoryAddon.Sell5Item )

function InventoryAddon.Sell10Item( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			if v > 9 then else return end
			for i=1,10 do
				InventoryAddon.Items[ args[ 1 ] ]:SELL( ply )
			end
			ply:RemoveItem( args[ 1 ], 10 )
			ShowTipPlayer(ply, 0, 4, "Sold 10 "..InventoryAddon.Items[ args[ 1 ] ].Name.."." )
			InventoryAddon:SaveInventoryData( ply )
			return
		end
	end
end 
concommand.Add( "InventoryAddon.Sell10Item", InventoryAddon.Sell10Item )

function InventoryAddon.SellAllItem( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?
	
	for k, v in pairs( InventoryData[ ply:UniqueID() ] ) do
		if ( k == args[ 1 ] ) then
			for i=1,v do
				InventoryAddon.Items[ args[ 1 ] ]:SELL( ply )
			end
			ply:RemoveItem( args[ 1 ], v )
			ShowTipPlayer(ply, 0, 4, "Sold "..v.." "..InventoryAddon.Items[ args[ 1 ] ].Name.."." )
			InventoryAddon:SaveInventoryData( ply )
			return
		end
	end
end 
concommand.Add( "InventoryAddon.SellAllItem", InventoryAddon.SellAllItem )

function InventoryAddon.BuyItem( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?

	local cost = args[ 2 ]*1
	if ply:GetNWInt("gold") >= cost then
		InventoryAddon.Items[ args[ 1 ] ]:BUY( ply )
		ply:GiveItem( args[ 1 ], 1 )
		ShowTipPlayer(ply, 0, 4, "Bought "..InventoryAddon.Items[ args[ 1 ] ].Name.."." )
		InventoryAddon:SaveInventoryData( ply )
		return
	end
end
concommand.Add( "InventoryAddon.BuyItem", InventoryAddon.BuyItem )

function InventoryAddon.Buy5Item( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?

	local cost = args[ 2 ]*5
	if ply:GetNWInt("gold") >= cost then
		for i=1,5 do
			InventoryAddon.Items[ args[ 1 ] ]:BUY( ply )
			ply:GiveItem( args[ 1 ], 1 )
			ShowTipPlayer(ply, 0, 4, "Bought "..InventoryAddon.Items[ args[ 1 ] ].Name.."." )
		end
		InventoryAddon:SaveInventoryData( ply )
		return
	end
end
concommand.Add( "InventoryAddon.Buy5Item", InventoryAddon.Buy5Item )

function InventoryAddon.Buy10Item( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?

	local cost = args[ 2 ]*10
	if ply:GetNWInt("gold") >= cost then
		for i=1,10 do
			InventoryAddon.Items[ args[ 1 ] ]:BUY( ply )
			ply:GiveItem( args[ 1 ], 1 )
			ShowTipPlayer(ply, 0, 4, "Bought "..InventoryAddon.Items[ args[ 1 ] ].Name.."." )
		end
		InventoryAddon:SaveInventoryData( ply )
		return
	end
end
concommand.Add( "InventoryAddon.Buy10Item", InventoryAddon.Buy10Item )

function InventoryAddon.Buy50Item( ply, cmd, args )
	if ( !ply:Alive() ) then return end -- Dead?

	local cost = args[ 2 ]*50
	if ply:GetNWInt("gold") >= cost then
		for i=1,50 do
			InventoryAddon.Items[ args[ 1 ] ]:BUY( ply )
			ply:GiveItem( args[ 1 ], 1 )
			ShowTipPlayer(ply, 0, 4, "Bought "..InventoryAddon.Items[ args[ 1 ] ].Name.."." )
		end
		InventoryAddon:SaveInventoryData( ply )
		return
	end
end
concommand.Add( "InventoryAddon.Buy50Item", InventoryAddon.Buy50Item ) 