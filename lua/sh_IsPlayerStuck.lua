--- 100.000.000 iterations
-- TraceEntity:
	-- sum = 0.083000000000084
-- IsOBBIntersectingOBB:
	-- sum = 0.014999999999873

-- local trace = {}
-- local traceData = { output = trace, start = Vector(), endpos = Vector(), filter = NULL, ignoreworld = true }
-- local function IsPlayerStuck(ply)
	-- traceData.start = plyPos
	-- traceData.endpos = traceData.start
	-- traceData.filter = ply
	-- util.TraceEntity(traceData, ply)
	-- if trace.StartSolid then return true end
	-- return false
-- end

local function IsPlayerStuck( pObj, ent )
	local len, players = player.All()
	local ply, plyPos
	local pos, ang, mins, maxs = ent:GetPos(), ent:GetAngles(), ent:GetCollisionBounds()

	for i = 1, len do
		ply = players[i]
		plyPos = ply:GetPos()

		if ply:Alive() and pos:DistToSqr(plyPos) <= 40000 and util.IsOBBIntersectingOBB(pos, ang, mins, maxs, plyPos, ply:GetAngles(), ply:GetCollisionBounds()) then
			return true
		end
	end

	if not pObj:IsPenetrating() then
		return false
	end

	return true
end

hook.Add('OnPhysgunFreeze', 'test.OnPhysgunFreeze', function( _, physobj, ent, ply )
	if IsPlayerStuck(physobj, ent) then
		print("Кто-то застрял в пропе!")
	end
end)