local function DrawExtendedDiagonalFold(x, y, w, h, extensionSize)
	draw.NoTexture()
    surface.DrawPoly({
        {x = x, y = y},
        {x = x + w, y = y},
        {x = x + w + math.max(0, extensionSize), y = y + h},
        {x = x, y = y + h}
    })
end

hook.Add("HUDPaint", "drawExample", function()
    surface.SetDrawColor(50, 50, 50, 255)
    DrawExtendedDiagonalFold(100, 100, 100, 25, 25)
end)

-- Example: https://i.imgur.com/2njprRc.png
