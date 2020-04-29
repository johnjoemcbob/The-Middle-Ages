function DataInit()
	sql.Begin()
		sql.Query("CREATE TABLE IF NOT EXISTS gold('steam' TEXT NOT NULL, 'amount' INTEGER NOT NULL, PRIMARY KEY('steam'));")
		sql.Query("CREATE TABLE IF NOT EXISTS smithinglevel('steam' TEXT NOT NULL, 'amount' INTEGER NOT NULL, PRIMARY KEY('steam'));")
		sql.Query("CREATE TABLE IF NOT EXISTS smithingexp('steam' TEXT NOT NULL, 'amount' INTEGER NOT NULL, PRIMARY KEY('steam'));")
		sql.Query("CREATE TABLE IF NOT EXISTS names('steam' TEXT NOT NULL, 'name' TEXT NOT NULL, PRIMARY KEY('steam'));")
	sql.Commit()
end

function DataStoreName(ply, name)
	if not name or string.len(name) < 2 then return end
	local r = sql.QueryValue("SELECT name FROM names WHERE steam = " .. sql.SQLStr(ply:SteamID()) .. ";")
	if r then
		sql.Query("UPDATE names SET name = " .. sql.SQLStr(name) .. " WHERE steam = " .. sql.SQLStr(ply:SteamID()) .. ";")
	else
		sql.Query("INSERT INTO names VALUES(" .. sql.SQLStr(ply:SteamID()) .. ", " .. sql.SQLStr(name) .. ");")
	end

	ply:SetNWString("name", name)
end

function DataRetrieveName(ply)
	return sql.QueryValue("SELECT name FROM names WHERE steam = " .. sql.SQLStr(ply:SteamID()) .. ";")
end

function DataStoreGold(ply, amount)
	if not ply then return end
	local gold = amount * 1

	local steamID = ply:SteamID()
	local r = sql.QueryValue("SELECT amount FROM gold WHERE steam = " .. sql.SQLStr(steamID) .. ";")
	if r then
		sql.Query("UPDATE gold SET amount = " .. math.floor(gold) .. " WHERE steam = " .. sql.SQLStr(steamID) .. ";")
	else
		sql.Query("INSERT INTO gold VALUES(" .. sql.SQLStr(steamID) .. ", " .. math.floor(gold) .. ");")
	end

	ply:SetNWInt("gold", math.floor(gold))
end

function DataRetrieveGold(ply)
	if not ply then return 0 end

	local r = sql.QueryValue("SELECT amount FROM gold WHERE steam = " .. sql.SQLStr(ply:SteamID()) .. ";")
	if r then
		ply:SetNWInt("gold", math.floor(r))
		return r
	else
		DataStoreGold(ply, 500)
		return startingAmount
	end
end

function DataStoreSmithingLevel(ply, amount)
	if not ply then return end
	local amo = amount * 1

	local steamID = ply:SteamID()
	local r = sql.QueryValue("SELECT amount FROM smithinglevel WHERE steam = " .. sql.SQLStr(steamID) .. ";")
	if r then
		sql.Query("UPDATE smithinglevel SET amount = " .. math.floor(amo) .. " WHERE steam = " .. sql.SQLStr(steamID) .. ";")
	else
		sql.Query("INSERT INTO smithinglevel VALUES(" .. sql.SQLStr(steamID) .. ", " .. math.floor(amo) .. ");")
	end

	ply:SetNWInt("smithinglevel", math.floor(amo))
end

function DataRetrieveSmithingLevel(ply)
	if not ply then return 0 end

	local r = sql.QueryValue("SELECT amount FROM smithinglevel WHERE steam = " .. sql.SQLStr(ply:SteamID()) .. ";")
	if r then
		ply:SetNWInt("smithinglevel", math.floor(r))
		return r
	else
		DataStoreSmithingLevel(ply, 1)
		return 1
	end
end

function DataStoreSmithingExp(ply, amount)
	if not ply then return end
	local amo = amount * 1

	local steamID = ply:SteamID()
	local r = sql.QueryValue("SELECT amount FROM smithingexp WHERE steam = " .. sql.SQLStr(steamID) .. ";")
	if r then
		sql.Query("UPDATE smithingexp SET amount = " .. math.floor(amo) .. " WHERE steam = " .. sql.SQLStr(steamID) .. ";")
	else
		sql.Query("INSERT INTO smithingexp VALUES(" .. sql.SQLStr(steamID) .. ", " .. math.floor(amo) .. ");")
	end

	ply:SetNWInt("smithingexp", math.floor(amo))
end

function DataRetrieveSmithingExp(ply)
	if not ply then return 0 end

	local r = sql.QueryValue("SELECT amount FROM smithingexp WHERE steam = " .. sql.SQLStr(ply:SteamID()) .. ";")
	if r then
		ply:SetNWInt("smithingexp", math.floor(r))
		return r
	else
		DataStoreSmithingExp(ply, 0)
		return 0
	end
end 