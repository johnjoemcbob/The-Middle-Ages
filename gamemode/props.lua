BannedProps = { }
function AddBannedProp(mdl) table.insert(BannedProps, mdl) end

AllowedProps = { }
function AddAllowedProp(mdl) table.insert(AllowedProps, mdl) end

AllowedPropSpawningZero = { }
function AllowedPropSpawningZero(mdl) table.insert(AllowedPropSpawningZero, mdl) end

AddBannedProp("models/props_combine/CombineTrain02b.mdl")
AddBannedProp("models/props_combine/CombineTrain02a.mdl")
AddBannedProp("models/props_combine/CombineTrain01.mdl")
AddBannedProp("models/Cranes/crane_frame.mdl")
AddBannedProp("models/props_wasteland/cargo_container01.mdl")
AddBannedProp("models/props_junk/TrashDumpster02.mdl")
AddBannedProp("models/props_c17/oildrum001_explosive.mdl")
AddBannedProp("models/props_canal/canal_bridge02.mdl")
AddBannedProp("models/props_canal/canal_bridge01.mdl")
AddBannedProp("models/props_canal/canal_bridge03a.mdl")
AddBannedProp("models/props_canal/canal_bridge03b.mdl")
AddBannedProp("models/props_wasteland/cargo_container01.mdl")
AddBannedProp("models/props_wasteland/cargo_container01c.mdl")
AddBannedProp("models/props_wasteland/cargo_container01b.mdl")
AddBannedProp("models/props_junk/sawblade001a.mdl")
AddBannedProp("models/props_junk/gascan001a.mdl")
AddBannedProp("models/props_buildings/building_002a.mdl")
AddBannedProp("models/props_phx/oildrum001_explosive.mdl")
AddBannedProp("models/props_junk/propane_tank001a.mdl")
AddBannedProp("models/props_phx/amraam.mdl")
AddBannedProp("models/props_phx/mk-82.mdl")
AddBannedProp("models/props_phx/ww2bomb.mdl")
AddBannedProp("models/props_phx/torpedo.mdl")
AddBannedProp("models/props_phx/misc/flakshell_big.mdl")
AddBannedProp("models/noobuss/bacon.mdl")
AddBannedProp("models/Bread/bread.mdl")
AddBannedProp("models/Random_Stuff/Cake1-2.mdl")
AddBannedProp("models/mushroom/karpassieni01.mdl")
AddBannedProp("models/plants/mushrooms.mdl")
AddBannedProp("models/Items/provisions/pie/pie.mdl")
AddBannedProp("models/Items/provisions/potions/life_potion.mdl")
AddBannedProp("models/lduke/chicken/chicken3.mdl")
AddBannedProp("models/thespectator/cow.mdl")
AddBannedProp("models/props_junk/Rock001a.mdl")
AddBannedProp("models/props_explosive/explosive_butane_can.mdl")
AddBannedProp("models/props_explosive/explosive_butane_can02.mdl")
AddBannedProp("models/props_combine/Combine_Citadel001.mdl")
AddBannedProp("models/props_c17/fence01a.mdl")
AddBannedProp("models/props_c17/fence01b.mdl")
AddBannedProp("models/props_c17/fence02a.mdl")
AddBannedProp("models/props_c17/fence02b.mdl")
AddBannedProp("models/props_c17/fence03a.mdl")
AddBannedProp("models/props_c17/fence04a.mdl")
AddBannedProp("models/nayrbarr/anvil/anvil.mdl")
AddBannedProp("models/nayrbarr/coin/coin.mdl")
AddBannedProp("models/nayrbarr/iron/iron.mdl")
AddBannedProp("models/nayrbarr/Smelter/smelter.mdl")
AddBannedProp("models/props/CS_militia/silo_01.mdl")
AddBannedProp("models/props_wasteland/interior_fence002d.mdl")
AddBannedProp("models/props_wasteland/interior_fence001g.mdl")
AddBannedProp("models/door.mdl")
AddBannedProp("models/castledoor.mdl")
AddBannedProp("models/castlegate.mdl")
AddBannedProp("models/castlewall1.mdl")
AddBannedProp("models/inn.mdl")
AddBannedProp("models/house1.mdl")
AddBannedProp("models/house2.mdl")
AddBannedProp("models/house3.mdl")
AddBannedProp("models/smithy.mdl")
AddBannedProp("models/church.mdl")
AddBannedProp("models/fountain.mdl")
AddBannedProp("models/ship.mdl")
AddBannedProp("models/sword.mdl")
AddBannedProp("models/ruins1.mdl")
AddBannedProp("models/ruins2.mdl")
AddBannedProp("models/centre.mdl")

function GM:PlayerSpawnProp(ply, model)
	if not self.BaseClass:PlayerSpawnProp(ply, model) then return false end

	local allowed = false
	model = string.gsub(model, "\\", "/")
	-- Banned props take precedence over allowed props
	if CfgVars["bannedprops"] == 1 then
		for k, v in pairs(BannedProps) do
			if string.lower(v) == string.lower(model) then 
				ply:PrintMessage( HUD_PRINTTALK, "The model found at; "..model.." ;is banned.")
				return false 
			end
		end
	end

	if CfgVars["propspawning"] == 1 or ply:IsAdmin() or (ply:Team() == 17 and CfgVars["builderprops"] == 1) then
		-- If we are specifically allowing certain props, if it's not in the list, allowed will remain false
		if CfgVars["allowedprops"] == 1 then
			for k, v in pairs(AllowedProps) do
				if v == model then allowed = true end
			end
		else
			-- allowedprops is not enabled, so assume that if it wasn't banned above, it's allowed
			allowed = true
		end
		return true
	elseif CfgVars["propspawning"] == 0 and not ply:Team() == 17 and CfgVars["builderprops"] == 1 then
		ply:PrintMessage( HUD_PRINTTALK, "Only Builders can spawn props at the moment." )
		return false
	else
		return false
	end
end 