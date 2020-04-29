GM.Name 	= "The Middle Ages"
GM.Author 	= "Matthew"
GM.Email 	= "mcormack1994@hotmail.co.uk"
GM.Website 	= "http://www.teaandbiscuit.com/home/"

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

team.SetUp( 1 , "Peasant", Color(20, 150, 20, 255))
team.SetUp( 2 , "Guard", Color(25, 25, 170, 255))
team.SetUp( 3 , "Knight", Color(20, 20, 255, 255))
team.SetUp( 4 , "King", Color(150, 20, 20, 255))
team.SetUp( 7 , "Merchant", Color(255, 103, 239, 255))
team.SetUp( 8 , "Mage", Color(13, 117, 209, 255))
team.SetUp( 10 , "Blacksmith", Color(255, 140, 0, 255))
team.SetUp( 11 , "Priest", Color(47, 79, 79, 255))
team.SetUp( 12 , "Cook", Color(238, 99, 99, 255))
team.SetUp( 13 , "Craftsman", Color(201, 201, 65, 255))
team.SetUp( 14 , "Labourer", Color(10, 100, 255, 255))
team.SetUp( 15 , "Inn Keeper", Color(255, 103, 239, 255))
team.SetUp( 16 , "Wolf", Color(53, 200, 255, 255))
team.SetUp( 17 , "Builder", Color(201, 201, 65, 255))
team.SetUp( 18 , "Fisherman", Color(100, 200, 255, 255))
team.SetUp( 19 , "Druid", Color(0, 255, 0, 255))

--_________
-- Backpack
--_________

-- Main addon table.
InventoryAddon = { }

-- Items table.
InventoryAddon.Items = { }

--======================================================
-- Shared utils.
--======================================================
local PMeta = FindMetaTable( "Player" )

function PMeta:EyeTrace( dis )
	local tr = {}
	tr.start = self:GetShootPos()
	tr.endpos = tr.start + ( self:GetAimVector() * dis )
	tr.filter = self
	tr = util.TraceLine( tr )
	return tr
end

PMeta = nil

function InventoryAddon:SendMessage( text, ply, console )
	if ( console ) then
		Msg( text .. "\n" )
	else
		ply:PrintMessage( 3, text )
	end
end

--======================================================
-- Shared item functions.
--=====================================================

-- Register a item.
function InventoryAddon:RegisterItem( ItemTable )
	InventoryAddon.Items[ ItemTable.UniqueID ] = ItemTable
	InventoryAddon:SendMessage( "Registered item -> " .. ItemTable.UniqueID , nil, true )
end

-- Include all items both serverside and clientside.
for k, v in pairs( file.Find( "items/*.lua", "LUA" ) ) do include( "items/" .. v ) end 