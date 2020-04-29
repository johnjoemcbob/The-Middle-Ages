-- This particular items table, must have it.
local ITEM = { }

-- The UniqueID for this item, this is used to spawn the item and it's the ID for the item. Text always has to be lowered.
ITEM.UniqueID = "shield_buckler"

-- The model that will be shown in the inventory and on the map.
ITEM.Model = "models/nayrbarr/iron/iron.mdl"

-- The name for this item, used in the inventory menu.
ITEM.Name = "Buckler"

ITEM.Price = 110
local price = 110

-- The description for this item, used in the inventory menu.
ITEM.Description = "A small shield."

-- Remove this item from the inventory when you press use on it? 
-- True will make it remove, false will make it stay.
ITEM.RemoveOnUse = true

ITEM.Armour = true

ITEM.SmithSellable = true

-- The Drop item function.
if ( SERVER ) then -- Only used on server so use this check.
	function ITEM:USE( ply )
		local tr = ply:EyeTrace( 80 )
		local Armour = ents.Create( "armour_shield_buckler" )
		Armour:SetPos( Vector( tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 ) )
		Armour:Spawn( )
		Armour:Activate( )

		if ply:GetNWInt("bucklershield") == 1 then
			ply:ConCommand("pac_removeparts")
			ply:SetNWInt("wearingarmour", 0)
			ply:SetNWInt("bucklershield", 0)
			ply:SetNWInt("shield", 0)
			if ply:GetNWInt("armour") > 19 then
				ply:SetNWInt("armour", ply:GetNWInt("armour") - 20)
			else
				ply:SetNWInt("armour", 0)
			end
			ply:SetNWInt("maxarmour", ply:GetNWInt("maxarmour") - 20)
			if ply:GetNWInt("templararmour") == 1 then
				if ply:GetNWString("race") == "Gnome" then
					ply:ConCommand("pac_wearclient templargnome1 models/gibs/metal_gib4.mdl -0.00 3.70 0.60 0.60 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 1")
					ply:ConCommand("pac_wearclient templargnome2 models/gibs/antlion_gib_large_2.mdl 6.29 -0.75 9.44 0.70 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 2")
					ply:ConCommand("pac_wearclient templargnome3 models/gibs/metal_gib4.mdl -0.00 3.70 0.01 0.60 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 3")
					ply:ConCommand("pac_wearclient templargnome4 models/gibs/antlion_gib_large_2.mdl -6.29 -0.75 9.44 0.65 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 4")
					ply:ConCommand("pac_wearclient templargnome5 models/gibs/shield_scanner_gib2.mdl -0.00 -6.09 -7.88 0.60 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearclient templargnome6 models/props_junk/metalbucket01a.mdl -0.00 -0.75 0.30 0.60 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearclient templargnome7 models/gibs/shield_scanner_gib2.mdl -0.00 0.00 -7.88 0.60 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 7")
					ply:ConCommand("pac_wearserver templargnome1 models/gibs/metal_gib4.mdl -0.00 3.70 0.60 0.60 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 1")
					ply:ConCommand("pac_wearserver templargnome2 models/gibs/antlion_gib_large_2.mdl 6.29 -0.75 9.44 0.70 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 2")
					ply:ConCommand("pac_wearserver templargnome3 models/gibs/metal_gib4.mdl -0.00 3.70 0.01 0.60 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 3")
					ply:ConCommand("pac_wearserver templargnome4 models/gibs/antlion_gib_large_2.mdl -6.29 -0.75 9.44 0.65 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 4")
					ply:ConCommand("pac_wearserver templargnome5 models/gibs/shield_scanner_gib2.mdl -0.00 -6.09 -7.88 0.60 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearserver templargnome6 models/props_junk/metalbucket01a.mdl -0.00 -0.75 0.30 0.60 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearserver templargnome7 models/gibs/shield_scanner_gib2.mdl -0.00 0.00 -7.88 0.60 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 7")
				elseif ply:GetNWString("race") == "Dwarf" then
					ply:ConCommand("pac_wearclient templardwarf1 models/gibs/metal_gib4.mdl -0.00 5.30 0.21 0.80 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 1")
					ply:ConCommand("pac_wearclient templardwarf2 models/gibs/metal_gib4.mdl -0.00 5.30 0.80 0.80 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 2")
					ply:ConCommand("pac_wearclient templardwarf3 models/gibs/antlion_gib_large_2.mdl 10.29 -0.75 13.44 0.90 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 3")
					ply:ConCommand("pac_wearclient templardwarf4 models/gibs/shield_scanner_gib2.mdl -0.00 -8.09 -7.88 0.80 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 4")
					ply:ConCommand("pac_wearclient templardwarf5 models/props_junk/metalbucket01a.mdl -0.00 -0.75 0.50 0.70 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearclient templardwarf6 models/gibs/shield_scanner_gib2.mdl -0.00 2.00 -7.88 0.80 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearclient templardwarf7 models/gibs/antlion_gib_large_2.mdl -10.29 -0.75 13.44 0.85 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 7")
					ply:ConCommand("pac_wearserver templardwarf1 models/gibs/metal_gib4.mdl -0.00 5.30 0.21 0.80 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 1")
					ply:ConCommand("pac_wearserver templardwarf2 models/gibs/metal_gib4.mdl -0.00 5.30 0.80 0.80 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 2")
					ply:ConCommand("pac_wearserver templardwarf3 models/gibs/antlion_gib_large_2.mdl 10.29 -0.75 13.44 0.90 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 3")
					ply:ConCommand("pac_wearserver templardwarf4 models/gibs/shield_scanner_gib2.mdl -0.00 -8.09 -7.88 0.80 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 4")
					ply:ConCommand("pac_wearserver templardwarf5 models/props_junk/metalbucket01a.mdl -0.00 -0.75 0.50 0.70 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearserver templardwarf6 models/gibs/shield_scanner_gib2.mdl -0.00 2.00 -7.88 0.80 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearserver templardwarf7 models/gibs/antlion_gib_large_2.mdl -10.29 -0.75 13.44 0.85 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 7")
				else
					ply:ConCommand("pac_wearclient templarfull1 models/gibs/antlion_gib_large_2.mdl 10.29 -0.75 15.44 1.10 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 1")
					ply:ConCommand("pac_wearclient templarfull2 models/gibs/metal_gib4.mdl -0.00 5.30 2.21 1.00 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 2")
					ply:ConCommand("pac_wearclient templarfull3 models/props_junk/metalbucket01a.mdl -0.00 -0.75 2.50 0.80 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 3")
					ply:ConCommand("pac_wearclient templarfull4 models/gibs/antlion_gib_large_2.mdl -10.29 -0.75 15.44 1.05 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 4")
					ply:ConCommand("pac_wearclient templarfull5 models/gibs/metal_gib4.mdl -0.00 5.30 2.80 1.00 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearclient templarfull6 models/gibs/shield_scanner_gib2.mdl -0.00 -8.09 -5.88 1.00 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearclient templarfull7 models/gibs/shield_scanner_gib2.mdl -0.00 2.00 -5.88 1.00 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 7")
					ply:ConCommand("pac_wearserver templarfull1 models/gibs/antlion_gib_large_2.mdl 10.29 -0.75 15.44 1.10 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 1")
					ply:ConCommand("pac_wearserver templarfull2 models/gibs/metal_gib4.mdl -0.00 5.30 2.21 1.00 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 2")
					ply:ConCommand("pac_wearserver templarfull3 models/props_junk/metalbucket01a.mdl -0.00 -0.75 2.50 0.80 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 3")
					ply:ConCommand("pac_wearserver templarfull4 models/gibs/antlion_gib_large_2.mdl -10.29 -0.75 15.44 1.05 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 4")
					ply:ConCommand("pac_wearserver templarfull5 models/gibs/metal_gib4.mdl -0.00 5.30 2.80 1.00 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearserver templarfull6 models/gibs/shield_scanner_gib2.mdl -0.00 -8.09 -5.88 1.00 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearserver templarfull7 models/gibs/shield_scanner_gib2.mdl -0.00 2.00 -5.88 1.00 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 7")
				end
			end
		end
	end

	function ITEM:EQUIPARMOUR( ply ) -- Equip the item
		if ply:GetNWInt("bucklershield") == 1 then
			ply:ConCommand("pac_removeparts")
			ply:SetNWInt("wearingarmour", 0)
			ply:SetNWInt("bucklershield", 0)
			ply:SetNWInt("shield", 0)
			if ply:GetNWInt("armour") > 19 then
				ply:SetNWInt("armour", ply:GetNWInt("armour") - 20)
			else
				ply:SetNWInt("armour", 0)
			end
			ply:SetNWInt("maxarmour", ply:GetNWInt("maxarmour") - 20)
			if ply:GetNWInt("templararmour") == 1 then
				if ply:GetNWString("race") == "Gnome" then
					ply:ConCommand("pac_wearclient templargnome1 models/gibs/metal_gib4.mdl -0.00 3.70 0.60 0.60 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 1")
					ply:ConCommand("pac_wearclient templargnome2 models/gibs/antlion_gib_large_2.mdl 6.29 -0.75 9.44 0.70 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 2")
					ply:ConCommand("pac_wearclient templargnome3 models/gibs/metal_gib4.mdl -0.00 3.70 0.01 0.60 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 3")
					ply:ConCommand("pac_wearclient templargnome4 models/gibs/antlion_gib_large_2.mdl -6.29 -0.75 9.44 0.65 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 4")
					ply:ConCommand("pac_wearclient templargnome5 models/gibs/shield_scanner_gib2.mdl -0.00 -6.09 -7.88 0.60 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearclient templargnome6 models/props_junk/metalbucket01a.mdl -0.00 -0.75 0.30 0.60 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearclient templargnome7 models/gibs/shield_scanner_gib2.mdl -0.00 0.00 -7.88 0.60 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 7")
					ply:ConCommand("pac_wearserver templargnome1 models/gibs/metal_gib4.mdl -0.00 3.70 0.60 0.60 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 1")
					ply:ConCommand("pac_wearserver templargnome2 models/gibs/antlion_gib_large_2.mdl 6.29 -0.75 9.44 0.70 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 2")
					ply:ConCommand("pac_wearserver templargnome3 models/gibs/metal_gib4.mdl -0.00 3.70 0.01 0.60 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 3")
					ply:ConCommand("pac_wearserver templargnome4 models/gibs/antlion_gib_large_2.mdl -6.29 -0.75 9.44 0.65 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 4")
					ply:ConCommand("pac_wearserver templargnome5 models/gibs/shield_scanner_gib2.mdl -0.00 -6.09 -7.88 0.60 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearserver templargnome6 models/props_junk/metalbucket01a.mdl -0.00 -0.75 0.30 0.60 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearserver templargnome7 models/gibs/shield_scanner_gib2.mdl -0.00 0.00 -7.88 0.60 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 7")
				elseif ply:GetNWString("race") == "Dwarf" then
					ply:ConCommand("pac_wearclient templardwarf1 models/gibs/metal_gib4.mdl -0.00 5.30 0.21 0.80 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 1")
					ply:ConCommand("pac_wearclient templardwarf2 models/gibs/metal_gib4.mdl -0.00 5.30 0.80 0.80 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 2")
					ply:ConCommand("pac_wearclient templardwarf3 models/gibs/antlion_gib_large_2.mdl 10.29 -0.75 13.44 0.90 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 3")
					ply:ConCommand("pac_wearclient templardwarf4 models/gibs/shield_scanner_gib2.mdl -0.00 -8.09 -7.88 0.80 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 4")
					ply:ConCommand("pac_wearclient templardwarf5 models/props_junk/metalbucket01a.mdl -0.00 -0.75 0.50 0.70 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearclient templardwarf6 models/gibs/shield_scanner_gib2.mdl -0.00 2.00 -7.88 0.80 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearclient templardwarf7 models/gibs/antlion_gib_large_2.mdl -10.29 -0.75 13.44 0.85 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 7")
					ply:ConCommand("pac_wearserver templardwarf1 models/gibs/metal_gib4.mdl -0.00 5.30 0.21 0.80 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 1")
					ply:ConCommand("pac_wearserver templardwarf2 models/gibs/metal_gib4.mdl -0.00 5.30 0.80 0.80 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 2")
					ply:ConCommand("pac_wearserver templardwarf3 models/gibs/antlion_gib_large_2.mdl 10.29 -0.75 13.44 0.90 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 3")
					ply:ConCommand("pac_wearserver templardwarf4 models/gibs/shield_scanner_gib2.mdl -0.00 -8.09 -7.88 0.80 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 4")
					ply:ConCommand("pac_wearserver templardwarf5 models/props_junk/metalbucket01a.mdl -0.00 -0.75 0.50 0.70 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearserver templardwarf6 models/gibs/shield_scanner_gib2.mdl -0.00 2.00 -7.88 0.80 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearserver templardwarf7 models/gibs/antlion_gib_large_2.mdl -10.29 -0.75 13.44 0.85 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 7")
				else
					ply:ConCommand("pac_wearclient templarfull1 models/gibs/antlion_gib_large_2.mdl 10.29 -0.75 15.44 1.10 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 1")
					ply:ConCommand("pac_wearclient templarfull2 models/gibs/metal_gib4.mdl -0.00 5.30 2.21 1.00 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 2")
					ply:ConCommand("pac_wearclient templarfull3 models/props_junk/metalbucket01a.mdl -0.00 -0.75 2.50 0.80 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 3")
					ply:ConCommand("pac_wearclient templarfull4 models/gibs/antlion_gib_large_2.mdl -10.29 -0.75 15.44 1.05 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 4")
					ply:ConCommand("pac_wearclient templarfull5 models/gibs/metal_gib4.mdl -0.00 5.30 2.80 1.00 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearclient templarfull6 models/gibs/shield_scanner_gib2.mdl -0.00 -8.09 -5.88 1.00 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearclient templarfull7 models/gibs/shield_scanner_gib2.mdl -0.00 2.00 -5.88 1.00 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 7")
					ply:ConCommand("pac_wearserver templarfull1 models/gibs/antlion_gib_large_2.mdl 10.29 -0.75 15.44 1.10 -0.00 -40.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 1")
					ply:ConCommand("pac_wearserver templarfull2 models/gibs/metal_gib4.mdl -0.00 5.30 2.21 1.00 -90.00 5.29 90.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 2")
					ply:ConCommand("pac_wearserver templarfull3 models/props_junk/metalbucket01a.mdl -0.00 -0.75 2.50 0.80 -0.00 90.00 0.00 1.00 1.00 1.00 68.00 68.00 68.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 3")
					ply:ConCommand("pac_wearserver templarfull4 models/gibs/antlion_gib_large_2.mdl -10.29 -0.75 15.44 1.05 -180.00 -40.00 0.00 1.00 1.00 1.00 70.00 70.00 70.00 255.00 ValveBiped.Bip01_Spine models/debug/debugwhite 4")
					ply:ConCommand("pac_wearserver templarfull5 models/gibs/metal_gib4.mdl -0.00 5.30 2.80 1.00 -90.00 5.29 0.00 1.00 1.00 1.00 0.00 0.00 0.00 255.00 ValveBiped.Bip01_Head1 models/debug/debugwhite 5")
					ply:ConCommand("pac_wearserver templarfull6 models/gibs/shield_scanner_gib2.mdl -0.00 -8.09 -5.88 1.00 90.00 0.00 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 6")
					ply:ConCommand("pac_wearserver templarfull7 models/gibs/shield_scanner_gib2.mdl -0.00 2.00 -5.88 1.00 -96.00 -31.76 0.00 1.00 1.00 1.00 72.00 72.00 72.00 255.00 ValveBiped.Bip01_Spine4 models/debug/debugwhite 7")
				end
			end
		elseif ply:GetNWInt("shield") == 1 then
			return
		else
			if ply:GetNWString("race") == "Dwarf" then
				ply:ConCommand("pac_wearclient shieldbucklerdwarf1 models/props_trainstation/trainstation_clock001.mdl -3.50 -2.50 6.50 0.25 -1.00 9.00 87.00 1.00 1.00 1.00 29.00 20.00 11.00 255.00 ValveBiped.Bip01_L_Forearm models/debug/debugwhite 5")
				ply:ConCommand("pac_wearclient shieldbucklerdwarf2 models/props_c17/clock01.mdl -3.50 -3.20 6.50 0.35 -90.00 -4.00 0.00 1.00 1.00 1.00 65.00 65.00 65.00 255.00 ValveBiped.Bip01_L_Forearm models/debug/debugwhite 6")
			elseif ply:GetNWString("race") == "Gnome" then
				ply:ConCommand("pac_wearclient shieldbucklergnome1 models/props_trainstation/trainstation_clock001.mdl -3.50 -2.50 6.50 0.20 -1.00 9.00 87.00 1.00 1.00 1.00 29.00 20.00 11.00 255.00 ValveBiped.Bip01_L_Forearm models/debug/debugwhite 7")
				ply:ConCommand("pac_wearclient shieldbucklergnome2 models/props_c17/clock01.mdl -3.50 -2.80 6.50 0.30 -90.00 -4.00 0.00 1.00 1.00 1.00 65.00 65.00 65.00 255.00 ValveBiped.Bip01_L_Forearm models/debug/debugwhite 8")
			else
				ply:ConCommand("pac_wearclient shieldbucklerhuman1 models/props_trainstation/trainstation_clock001.mdl -1.50 -2.50 4.50 0.30 -1.00 9.00 87.00 1.00 1.00 1.00 29.00 20.00 11.00 255.00 ValveBiped.Bip01_L_Forearm models/debug/debugwhite 3")
				ply:ConCommand("pac_wearclient shieldbucklerhuman2 models/props_c17/clock01.mdl -1.50 -3.20 3.50 0.40 -90.00 -4.00 0.00 1.00 1.00 1.00 65.00 65.00 65.00 255.00 ValveBiped.Bip01_L_Forearm models/debug/debugwhite 4")
			end
			ply:SetNWInt("wearingarmour", 1)
			ply:SetNWInt("bucklershield", 1)
			ply:SetNWInt("shield", 1)
			ply:SetNWInt("armour", ply:GetNWInt("armour") + 20)
			ply:SetNWInt("maxarmour", ply:GetNWInt("maxarmour") + 20)
		end
	end

	function ITEM:SELL( ply )
		GiveGold( ply, "gold", price )
	end

	function ITEM:BUY( ply )
		TakeGold( ply, "gold", price )
	end
end

-- Register the item so it exists in the main stuff.
InventoryAddon:RegisterItem( ITEM ) 