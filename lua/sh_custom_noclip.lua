local FLY_SPEED = 250

hook.Add("SetupMove", "CustomNoclipWithCollision", function(ply, mv, cmd)
    if ply:GetNWBool("CustomNoclip") then
        mv:SetMaxSpeed(1000)
        mv:SetMaxClientSpeed(1000)

        local vel = mv:GetVelocity()
        vel:SetUnpacked(0,0,0)

        local ang = mv:GetAngles()
        local mul = mv:KeyDown(IN_SPEED) and 2 or 1

        if mv:KeyDown(IN_FORWARD) then vel = vel + ang:Forward() * FLY_SPEED * mul end
        if mv:KeyDown(IN_BACK) then vel = vel - ang:Forward() * FLY_SPEED * mul end
        if mv:KeyDown(IN_MOVELEFT) then vel = vel - ang:Right() * FLY_SPEED * mul end
        if mv:KeyDown(IN_MOVERIGHT) then vel = vel + ang:Right() * FLY_SPEED * mul end

        if mv:KeyDown(IN_JUMP) then vel.z = FLY_SPEED * mul
        elseif mv:KeyDown(IN_DUCK) then vel.z = -FLY_SPEED * mul end

        mv:SetVelocity(vel)
    end
end)

if CLIENT then return end
concommand.Add("toggle_custom_noclip", function(ply)
    ply:SetNWBool("CustomNoclip", not ply:GetNWBool("CustomNoclip", false))
end)
