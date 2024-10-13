local cos, sin, pi =  math.cos, math.sin, math.pi
-- https://github.com/XenPare/gmod-xpgui/blob/master/lua/xpgui/surface.lua
function surface.PrecacheRoundedRect(x, y, w, h, r, seg)
  local min = (w > h and h or w) * 0.5
  r = r > min and min or r

  local poly = {}
  for i = 0, seg do
    local a = pi * 0.5 * i / seg
    local cosine, sine = r * cos(a), r * sin(a)
    poly[i+1] = {
      x = x + r - cosine,
      y = y + r - sine
    }
    poly[i + seg + 1] = {
      x = x + w - r + sine,
      y = y + r - cosine
    }
    poly[i + seg * 2 + 1] = {
      x = x + w - r + cosine,
      y = y + h - r + sine
    }
    poly[i + seg * 3 + 1] = {
      x = x + r - sine,
      y = y + h - r + cosine
    }
  end
  return poly
end

local avatarPanel = self:Add("Panel")
avatarPanel:SetPos(0, 0)
avatarPanel:SetSize(54, 54)
avatarPanel:SetVisible(false)

local avatar = avatarPanel:Add("AvatarImage")
avatar:SetSteamID(LocalPlayer():SteamID64())
avatar:SetPlayer(LocalPlayer(), 128)
avatar:Dock(FILL)
avatar:SetPaintedManually(true)
avatar.OnMousePressed = function(this, key) end

avatarPanel.Paint = function(this, w, h)
  render.ClearStencil()
  render.SetStencilEnable(true)
  render.SetStencilWriteMask(1)
  render.SetStencilTestMask(1)
  render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
  render.SetStencilPassOperation(STENCILOPERATION_ZERO)
  render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
  render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
  render.SetStencilReferenceValue(1)
    draw.NoTexture()
  render.UpdateScreenEffectTexture()
    surface.SetDrawColor(255, 255, 255, 255)
    this.poly = this.poly or surface.PrecacheRoundedRect(0, 0, w, h, h * 0.5, 6)
    surface.DrawPoly(this.poly)
  render.SetStencilFailOperation(STENCILOPERATION_ZERO)
  render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
  render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
  render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
  render.SetStencilReferenceValue(1)
    avatar:PaintManual()
  render.SetStencilEnable(false)
  render.ClearStencil()
end
