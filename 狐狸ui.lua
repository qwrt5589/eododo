local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local C = {
    BgWhite     = Color3.fromRGB(252, 252, 254),
    BgPanel     = Color3.fromRGB(248, 248, 250),

    Primary     = Color3.fromRGB(140, 22, 32),
    PrimaryDeep = Color3.fromRGB(110, 14, 22),
    PrimarySoft = Color3.fromRGB(255, 232, 235),
    PrimarySoftHi = Color3.fromRGB(255, 220, 225),
    PrimaryGlow = Color3.fromRGB(200, 60, 72),

    Red         = Color3.fromRGB(214, 45, 58),
    RedHi       = Color3.fromRGB(238, 70, 82),

    Border      = Color3.fromRGB(232, 232, 236),
    BorderSoft  = Color3.fromRGB(244, 244, 247),
    BorderPink  = Color3.fromRGB(255, 200, 208),

    TextDark    = Color3.fromRGB(24, 24, 28),
    TextMid     = Color3.fromRGB(88, 88, 96),
    TextLight   = Color3.fromRGB(155, 155, 165),
    TextOnRed   = Color3.fromRGB(255, 255, 255),
    TextPink    = Color3.fromRGB(140, 22, 32),

    Success     = Color3.fromRGB(76, 186, 106),
    Danger      = Color3.fromRGB(214, 45, 58),
}

local WIN_W, WIN_H = 640, 480
local NAV_W = 156
local NAV_GAP = 26
local LABEL_H = 26
local CARD_H = 42
local ROW_GAP = 6
local MINI_SIZE = 48

local function corner(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 12)
    c.Parent = o
    return c
end

local function stroke(o, col, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color = col or C.Border
    s.Thickness = thick or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = o
    return s
end

local function mkLabel(parent, text, size, color, align, font)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Text = text or ""
    l.TextColor3 = color or C.TextDark
    l.TextSize = size or 13
    l.Font = font or Enum.Font.Gotham
    l.TextXAlignment = align or Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.Parent = parent
    return l
end

local function mkCard(parent, h, r, fillColor, noStroke)
    local card = Instance.new("Frame")
    card.Name = "Card"
    card.BackgroundColor3 = fillColor or C.BgWhite
    card.BackgroundTransparency = 0
    card.BorderSizePixel = 0
    card.Size = UDim2.new(1, 0, 0, h or CARD_H)
    card.ZIndex = (parent.ZIndex or 1) + 1
    card.Parent = parent
    corner(card, r or 12)
    if not noStroke then
        stroke(card, fillColor and C.BorderPink or C.Border, 1, 0)
    end
    return card
end

local function mkFloatingLabel(parent, text)
    local lbl = Instance.new("Frame")
    lbl.Name = "FloatLabel"
    lbl.BackgroundColor3 = C.Primary
    lbl.BackgroundTransparency = 0
    lbl.BorderSizePixel = 0
    lbl.Size = UDim2.new(0, 0, 0, LABEL_H)
    lbl.AutomaticSize = Enum.AutomaticSize.X
    lbl.ZIndex = (parent.ZIndex or 1) + 1
    lbl.Parent = parent
    corner(lbl, 8)

    local t = mkLabel(lbl, text or "", 12, C.TextOnRed,
        Enum.TextXAlignment.Center, Enum.Font.GothamBold)
    t.Size = UDim2.new(1, -24, 1, 0)
    t.Position = UDim2.new(0, 12, 0, 0)
    t.ZIndex = (parent.ZIndex or 1) + 2

    return lbl
end

local function getMount()
    if gethui then
        local ok, h = pcall(gethui)
        if ok and h then return h end
    end
    return game:GetService("CoreGui")
end

local function makeControls(container)
    local api = {}
    local order = 0
    local function nextOrder() order = order + 1; return order end

    local function entrance(obj, delay)
        local tSize = obj.Size
        obj.Size = UDim2.new(tSize.X.Scale * 0.97, tSize.X.Offset * 0.97,
                             tSize.Y.Scale * 0.97, tSize.Y.Offset * 0.97)
        obj.BackgroundTransparency = 1
        task.delay(delay or 0, function()
            if not obj or not obj.Parent then return end
            TweenService:Create(obj, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = tSize,
                BackgroundTransparency = 0,
            }):Play()
        end)
    end

    local function mkRow(parent, labelText)
        local holder = Instance.new("Frame")
        holder.Size = UDim2.new(1, 0, 0, LABEL_H + ROW_GAP + CARD_H)
        holder.BackgroundTransparency = 1
        holder.LayoutOrder = nextOrder()
        holder.Parent = parent

        local labelBar
        if labelText and labelText ~= "" then
            labelBar = mkFloatingLabel(holder, labelText)
            labelBar.Position = UDim2.new(0, 0, 0, 0)
        end

        local cardHolder = Instance.new("Frame")
        cardHolder.Size = UDim2.new(1, 0, 0, CARD_H)
        cardHolder.Position = UDim2.new(0, 0, 0, LABEL_H + ROW_GAP)
        cardHolder.BackgroundTransparency = 1
        cardHolder.ZIndex = (holder.ZIndex or 1) + 1
        cardHolder.Parent = holder

        return holder, cardHolder, labelBar
    end

    function api:Header(title, subtitle)
        local wrap = Instance.new("Frame")
        wrap.Size = UDim2.new(1, 0, 0, subtitle and 50 or 30)
        wrap.BackgroundTransparency = 1
        wrap.LayoutOrder = nextOrder()
        wrap.Parent = container

        local t = mkLabel(wrap, title or "", 17, C.TextDark,
            Enum.TextXAlignment.Left, Enum.Font.GothamBold)
        t.Size = UDim2.new(1, 0, 0, 26)
        t.Position = UDim2.new(0, 4, 0, 0)

        if subtitle then
            local s = mkLabel(wrap, subtitle, 12, C.TextLight)
            s.Size = UDim2.new(1, 0, 0, 20)
            s.Position = UDim2.new(0, 4, 0, 26)
        end
        return wrap
    end

    function api:Label(text)
        local holder, cardHolder, labelBar = mkRow(container, "说明")
        local g = mkCard(cardHolder, CARD_H, 12)
        g.Size = UDim2.new(1, 0, 1, 0)

        local l = mkLabel(g, text or "", 13, C.TextDark)
        l.Size = UDim2.new(1, -32, 1, 0)
        l.Position = UDim2.new(0, 16, 0, 0)
        l.ZIndex = 10

        entrance(g, 0)
        local obj = {}
        function obj:Set(v) l.Text = v end
        return obj
    end

    function api:Button(text, callback, style)
        style = style or "soft"

        local holder, cardHolder, labelBar = mkRow(container, text or "按钮")

        local fillColor, textColor, hoverFill
        if style == "primary" then
            fillColor = C.Primary
            textColor = C.TextOnRed
            hoverFill = C.PrimaryDeep
        elseif style == "danger" then
            fillColor = C.Red
            textColor = C.TextOnRed
            hoverFill = C.RedHi
        else
            fillColor = C.PrimarySoft
            textColor = C.TextPink
            hoverFill = C.PrimarySoftHi
        end

        local g = mkCard(cardHolder, CARD_H, 12, fillColor, true)
        g.Size = UDim2.new(1, 0, 1, 0)

        local innerText = mkLabel(g, "点击执行", 13, textColor,
            Enum.TextXAlignment.Center, Enum.Font.GothamBold)
        innerText.Size = UDim2.new(1, -32, 1, 0)
        innerText.Position = UDim2.new(0, 16, 0, 0)
        innerText.ZIndex = 10

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.ZIndex = 11
        click.Parent = g

        click.MouseEnter:Connect(function()
            TweenService:Create(g, TweenInfo.new(0.15), {
                BackgroundColor3 = hoverFill
            }):Play()
        end)
        click.MouseLeave:Connect(function()
            TweenService:Create(g, TweenInfo.new(0.2), {
                BackgroundColor3 = fillColor
            }):Play()
        end)
        click.MouseButton1Up:Connect(function()
            if callback then task.spawn(function() pcall(callback) end) end
        end)

        entrance(g, 0)
        local obj = {}
        function obj:Set(v) innerText.Text = v end
        return obj
    end

    function api:Toggle(text, default, callback)
        if type(default) == "function" then
            callback = default
            default = false
        end
        local value = default or false

        local holder, cardHolder, labelBar = mkRow(container, text or "开关")
        local g = mkCard(cardHolder, CARD_H, 12)
        g.Size = UDim2.new(1, 0, 1, 0)

        local track = Instance.new("Frame")
        track.Size = UDim2.new(0, 46, 0, 24)
        track.Position = UDim2.new(1, -60, 0.5, -12)
        track.BackgroundColor3 = value and C.Red or Color3.fromRGB(216, 216, 222)
        track.BorderSizePixel = 0
        track.ZIndex = 10
        track.Parent = g
        corner(track, 12)

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 20, 0, 20)
        knob.Position = value and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        knob.BackgroundColor3 = C.BgWhite
        knob.BorderSizePixel = 0
        knob.ZIndex = 11
        knob.Parent = track
        corner(knob, 10)

        local stateLbl = mkLabel(g, value and "开启" or "关闭", 13,
            value and C.Red or C.TextLight)
        stateLbl.Size = UDim2.new(1, -100, 1, 0)
        stateLbl.Position = UDim2.new(0, 16, 0, 0)
        stateLbl.ZIndex = 10

        local obj = {Value = value}
        local function set(v, anim)
            value = v
            obj.Value = v
            local ti = TweenInfo.new(anim and 0.22 or 0, Enum.EasingStyle.Quart)
            TweenService:Create(track, ti, {
                BackgroundColor3 = v and C.Red or Color3.fromRGB(216, 216, 222)
            }):Play()
            TweenService:Create(knob, ti, {
                Position = v and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
            }):Play()
            stateLbl.Text = v and "开启" or "关闭"
            stateLbl.TextColor3 = v and C.Red or C.TextLight
            if callback then task.spawn(function() pcall(callback, v) end) end
        end

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.ZIndex = 12
        click.Parent = g
        click.MouseButton1Up:Connect(function() set(not value, true) end)

        entrance(g, 0)
        set(value, false)
        return obj
    end

    function api:Slider(text, min, max, default, callback)
        min = min or 0
        max = max or 100
        local value = default or min

        local holder = Instance.new("Frame")
        holder.Size = UDim2.new(1, 0, 0, LABEL_H + ROW_GAP + 54)
        holder.BackgroundTransparency = 1
        holder.LayoutOrder = nextOrder()
        holder.Parent = container

        local labelBar = mkFloatingLabel(holder, text or "滑块")
        labelBar.Position = UDim2.new(0, 0, 0, 0)

        local cardHolder = Instance.new("Frame")
        cardHolder.Size = UDim2.new(1, 0, 0, 54)
        cardHolder.Position = UDim2.new(0, 0, 0, LABEL_H + ROW_GAP)
        cardHolder.BackgroundTransparency = 1
        cardHolder.ZIndex = (holder.ZIndex or 1) + 1
        cardHolder.Parent = holder

        local g = mkCard(cardHolder, 54, 12)
        g.Size = UDim2.new(1, 0, 1, 0)

        local val = mkLabel(g, tostring(value), 13, C.Primary,
            Enum.TextXAlignment.Right, Enum.Font.GothamBold)
        val.Size = UDim2.new(0, 80, 0, 20)
        val.Position = UDim2.new(1, -98, 0, 8)
        val.ZIndex = 10

        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, -36, 0, 5)
        track.Position = UDim2.new(0, 18, 0, 34)
        track.BackgroundColor3 = Color3.fromRGB(232, 232, 238)
        track.BorderSizePixel = 0
        track.ZIndex = 10
        track.Parent = g
        corner(track, 3)

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = C.Red
        fill.BorderSizePixel = 0
        fill.ZIndex = 11
        fill.Parent = track
        corner(fill, 3)

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 16, 0, 16)
        knob.Position = UDim2.new(0, -8, 0.5, -8)
        knob.BackgroundColor3 = C.BgWhite
        knob.BorderSizePixel = 0
        knob.ZIndex = 12
        knob.Parent = track
        corner(knob, 8)
        stroke(knob, C.Red, 2, 0)

        local obj = {Value = value}
        local function set(v, instant)
            value = math.clamp(v, min, max)
            obj.Value = value
            local pct = (value - min) / (max - min)
            fill.Size = UDim2.fromScale(pct, 1)
            if instant then
                knob.Position = UDim2.new(pct, -8, 0.5, -8)
            else
                TweenService:Create(knob, TweenInfo.new(0.1), {
                    Position = UDim2.new(pct, -8, 0.5, -8)
                }):Play()
            end
            val.Text = tostring(math.floor(value * 100) / 100)
            if callback then task.spawn(function() pcall(callback, value) end) end
        end

        local dragging = false
        local hit = Instance.new("TextButton")
        hit.Size = UDim2.new(1, 0, 0, 30)
        hit.Position = UDim2.new(0, 0, 0, 22)
        hit.BackgroundTransparency = 1
        hit.Text = ""
        hit.ZIndex = 15
        hit.Parent = g

        local function posToVal(x)
            local sc = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            set(min + (max - min) * sc, true)
        end

        hit.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                posToVal(input.Position.X)
            end
        end)
        hit.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch) then
                posToVal(input.Position.X)
            end
        end)

        function obj:Set(v) set(v, true) end
        entrance(g, 0)
        set(value, true)
        return obj
    end

    function api:Textbox(text, default, callback)
        if type(default) == "function" then
            callback = default
            default = ""
        end

        local holder, cardHolder, labelBar = mkRow(container, text or "输入")

        local g = mkCard(cardHolder, CARD_H, 12)
        g.Size = UDim2.new(1, 0, 1, 0)
        local cardStroke = g:FindFirstChildOfClass("UIStroke")

        local input = Instance.new("TextBox")
        input.Size = UDim2.new(1, -32, 1, 0)
        input.Position = UDim2.new(0, 16, 0, 0)
        input.BackgroundTransparency = 1
        input.Text = default or ""
        input.PlaceholderText = "输入..."
        input.PlaceholderColor3 = C.TextLight
        input.TextColor3 = C.TextDark
        input.TextSize = 13
        input.Font = Enum.Font.Gotham
        input.TextXAlignment = Enum.TextXAlignment.Left
        input.ClearTextOnFocus = false
        input.ZIndex = 11
        input.Parent = g

        input.Focused:Connect(function()
            if cardStroke then
                TweenService:Create(cardStroke, TweenInfo.new(0.15), {
                    Color = C.Red, Transparency = 0
                }):Play()
            end
        end)
        input.FocusLost:Connect(function()
            if cardStroke then
                TweenService:Create(cardStroke, TweenInfo.new(0.15), {
                    Color = C.Border, Transparency = 0
                }):Play()
            end
            if callback then task.spawn(function() pcall(callback, input.Text) end) end
        end)

        entrance(g, 0)
        return {
            Get = function() return input.Text end,
            Set = function(v) input.Text = v end
        }
    end

    function api:Dropdown(text, options, callback)
        options = options or {}
        local value = options[1] or ""

        local holder = Instance.new("Frame")
        holder.Size = UDim2.new(1, 0, 0, LABEL_H + ROW_GAP + CARD_H)
        holder.BackgroundTransparency = 1
        holder.LayoutOrder = nextOrder()
        holder.Parent = container

        local labelBar = mkFloatingLabel(holder, text or "下拉")
        labelBar.Position = UDim2.new(0, 0, 0, 0)

        local cardHolder = Instance.new("Frame")
        cardHolder.Size = UDim2.new(1, 0, 0, CARD_H)
        cardHolder.Position = UDim2.new(0, 0, 0, LABEL_H + ROW_GAP)
        cardHolder.BackgroundTransparency = 1
        cardHolder.ZIndex = (holder.ZIndex or 1) + 1
        cardHolder.Parent = holder

        local g = mkCard(cardHolder, CARD_H, 12)
        g.Size = UDim2.new(1, 0, 1, 0)
        g.ClipsDescendants = true

        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, CARD_H)
        header.BackgroundTransparency = 1
        header.ZIndex = 10
        header.Parent = g

        local sel = mkLabel(header, value, 13, C.Primary,
            Enum.TextXAlignment.Left, Enum.Font.GothamBold)
        sel.Size = UDim2.new(1, -60, 1, 0)
        sel.Position = UDim2.new(0, 16, 0, 0)
        sel.ZIndex = 12

        local arrow = mkLabel(header, "v", 13, C.TextLight,
            Enum.TextXAlignment.Center, Enum.Font.GothamBold)
        arrow.Size = UDim2.new(0, 20, 1, 0)
        arrow.Position = UDim2.new(1, -30, 0, 0)
        arrow.ZIndex = 12

        local listFrame = Instance.new("ScrollingFrame")
        listFrame.Size = UDim2.new(1, -20, 0, 0)
        listFrame.Position = UDim2.new(0, 10, 0, CARD_H)
        listFrame.BackgroundTransparency = 1
        listFrame.BorderSizePixel = 0
        listFrame.ScrollBarThickness = 3
        listFrame.ScrollBarImageColor3 = C.Border
        listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        listFrame.ZIndex = 11
        listFrame.Parent = g

        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 5)
        listLayout.Parent = listFrame

        local open = false
        local optionButtons = {}

        local function set(v)
            if not table.find(options, v) then return end
            value = v
            sel.Text = v
            for o, b in pairs(optionButtons) do
                if o == v then
                    TweenService:Create(b, TweenInfo.new(0.15), {
                        BackgroundColor3 = C.PrimarySoft
                    }):Play()
                    TweenService:Create(b.Title, TweenInfo.new(0.15), {
                        TextColor3 = C.TextPink
                    }):Play()
                else
                    TweenService:Create(b, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(248, 248, 250)
                    }):Play()
                    TweenService:Create(b.Title, TweenInfo.new(0.15), {
                        TextColor3 = C.TextDark
                    }):Play()
                end
            end
            if callback then task.spawn(function() pcall(callback, v) end) end
        end

        for _, opt in ipairs(options) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 32)
            b.BackgroundColor3 = Color3.fromRGB(248, 248, 250)
            b.BorderSizePixel = 0
            b.Text = ""
            b.AutoButtonColor = false
            b.ZIndex = 12
            b.Parent = listFrame
            corner(b, 8)

            local ol = mkLabel(b, opt, 12, C.TextDark)
            ol.Size = UDim2.new(1, -28, 1, 0)
            ol.Position = UDim2.new(0, 16, 0, 0)
            ol.Name = "Title"
            ol.ZIndex = 13

            b.MouseButton1Click:Connect(function()
                set(opt)
                open = false
                arrow.Text = "v"
                TweenService:Create(g, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                    Size = UDim2.new(1, 0, 0, CARD_H)
                }):Play()
                TweenService:Create(listFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                    Size = UDim2.new(1, -20, 0, 0)
                }):Play()
            end)
            optionButtons[opt] = b
        end

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 0, CARD_H)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.ZIndex = 15
        click.Parent = g

        click.MouseButton1Click:Connect(function()
            open = not open
            arrow.Text = open and "^" or "v"
            local visibleCount = math.min(#options, 5)
            local h = open and (CARD_H + visibleCount * 37 + 10) or CARD_H
            TweenService:Create(g, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                Size = UDim2.new(1, 0, 0, h)
            }):Play()
            TweenService:Create(listFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                Size = UDim2.new(1, -20, 0, open and (visibleCount * 37) or 0)
            }):Play()
        end)

        entrance(g, 0)
        set(value)
        return { Set = set, Value = value }
    end

    function api:Section(sectionName)
        local outer = Instance.new("Frame")
        outer.Size = UDim2.new(1, 0, 0, 56)
        outer.BackgroundTransparency = 1
        outer.LayoutOrder = nextOrder()
        outer.Parent = container

        local title = mkLabel(outer, sectionName or "", 12, C.TextMid,
            Enum.TextXAlignment.Left, Enum.Font.GothamBold)
        title.Size = UDim2.new(1, -8, 0, 20)
        title.Position = UDim2.new(0, 6, 0, 0)

        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, -12, 0, 1)
        line.Position = UDim2.new(0, 6, 0, 22)
        line.BackgroundColor3 = C.Border
        line.BorderSizePixel = 0
        line.Parent = outer

        local group = Instance.new("Frame")
        group.Size = UDim2.new(1, 0, 0, 40)
        group.Position = UDim2.new(0, 0, 0, 30)
        group.BackgroundTransparency = 1
        group.Parent = outer

        local hl = Instance.new("UIListLayout")
        hl.SortOrder = Enum.SortOrder.LayoutOrder
        hl.Padding = UDim.new(0, 10)
        hl.Parent = group

        hl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            group.Size = UDim2.new(1, 0, 0, hl.AbsoluteContentSize.Y)
            outer.Size = UDim2.new(1, 0, 0, hl.AbsoluteContentSize.Y + 32)
        end)

        return makeControls(group)
    end

    return api
end

local Mitea = {}

function Mitea:Window(name, config)
    name = name or "Mitea"
    config = config or {}

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Mitea_" .. tostring(math.random(1000, 9999))
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local mounted = false
    pcall(function() ScreenGui.Parent = getMount(); mounted = true end)
    if not mounted or not ScreenGui.Parent then
        pcall(function() ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end)
    end

    local mini = Instance.new("Frame")
    mini.Name = "MiniBlock"
    mini.Size = UDim2.new(0, MINI_SIZE, 0, MINI_SIZE)
    mini.Position = UDim2.new(0.5, -WIN_W/2 - NAV_W - NAV_GAP + NAV_W/2 - MINI_SIZE/2, 0.5, -MINI_SIZE/2)
    mini.BackgroundColor3 = C.Primary
    mini.BackgroundTransparency = 0
    mini.BorderSizePixel = 0
    mini.ZIndex = 15
    mini.Visible = false
    mini.Parent = ScreenGui
    corner(mini, 12)

    local miniIcon = mkLabel(mini, "展开", 13, C.TextOnRed,
        Enum.TextXAlignment.Center, Enum.Font.GothamBold)
    miniIcon.Size = UDim2.new(1, 0, 1, 0)
    miniIcon.ZIndex = 16
    miniIcon.Name = "Icon"

    local miniBtn = Instance.new("TextButton")
    miniBtn.Size = UDim2.new(1, 0, 1, 0)
    miniBtn.BackgroundTransparency = 1
    miniBtn.Text = ""
    miniBtn.ZIndex = 17
    miniBtn.Parent = mini

    local nav = Instance.new("Frame")
    nav.Name = "NavBar"
    nav.Size = UDim2.new(0, NAV_W, 0, WIN_H - 40)
    nav.Position = UDim2.new(0.5, -WIN_W/2 - NAV_W - NAV_GAP, 0.5, -(WIN_H-40)/2 + 20)
    nav.BackgroundColor3 = C.Primary
    nav.BackgroundTransparency = 0
    nav.BorderSizePixel = 0
    nav.ZIndex = 10
    nav.Parent = ScreenGui
    corner(nav, 16)
    nav.ClipsDescendants = true

    local navHeader = Instance.new("Frame")
    navHeader.Size = UDim2.new(1, -24, 0, 56)
    navHeader.Position = UDim2.new(0, 12, 0, 14)
    navHeader.BackgroundTransparency = 1
    navHeader.ZIndex = 11
    navHeader.Parent = nav

    local navTitle1 = mkLabel(navHeader, "Mitea", 19, C.TextOnRed,
        Enum.TextXAlignment.Left, Enum.Font.GothamBlack)
    navTitle1.Size = UDim2.new(1, 0, 0, 24)
    navTitle1.Position = UDim2.new(0, 4, 0, 0)
    navTitle1.ZIndex = 12

    local navTitle2 = mkLabel(navHeader, "Hub", 17, C.TextOnRed,
        Enum.TextXAlignment.Left, Enum.Font.GothamBold)
    navTitle2.Size = UDim2.new(1, 0, 0, 22)
    navTitle2.Position = UDim2.new(0, 4, 0, 24)
    navTitle2.TextTransparency = 0.25
    navTitle2.ZIndex = 12

    local badge = Instance.new("Frame")
    badge.Size = UDim2.new(0, 0, 0, 22)
    badge.AutomaticSize = Enum.AutomaticSize.X
    badge.Position = UDim2.new(0, 4, 0, 52)
    badge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    badge.BackgroundTransparency = 0.85
    badge.BorderSizePixel = 0
    badge.ZIndex = 12
    badge.Parent = navHeader
    corner(badge, 11)

    local badgeDot = Instance.new("Frame")
    badgeDot.Size = UDim2.new(0, 7, 0, 7)
    badgeDot.Position = UDim2.new(0, 9, 0.5, -3.5)
    badgeDot.BackgroundColor3 = C.Red
    badgeDot.BorderSizePixel = 0
    badgeDot.ZIndex = 13
    badgeDot.Parent = badge
    corner(badgeDot, 4)

    local badgeText = mkLabel(badge, "v1.0", 11, C.TextOnRed,
        Enum.TextXAlignment.Left, Enum.Font.GothamBold)
    badgeText.Size = UDim2.new(0, 44, 1, 0)
    badgeText.Position = UDim2.new(0, 22, 0, 0)
    badgeText.ZIndex = 13

    local navHolder = Instance.new("ScrollingFrame")
    navHolder.Size = UDim2.new(1, -16, 1, -172)
    navHolder.Position = UDim2.new(0, 8, 0, 86)
    navHolder.BackgroundTransparency = 1
    navHolder.BorderSizePixel = 0
    navHolder.ScrollBarThickness = 0
    navHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    navHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
    navHolder.ZIndex = 11
    navHolder.Parent = nav

    local navLayout = Instance.new("UIListLayout")
    navLayout.SortOrder = Enum.SortOrder.LayoutOrder
    navLayout.Padding = UDim.new(0, 6)
    navLayout.Parent = navHolder

    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, -32, 0, 1)
    divider.Position = UDim2.new(0, 16, 1, -96)
    divider.BackgroundColor3 = C.TextOnRed
    divider.BackgroundTransparency = 0.75
    divider.BorderSizePixel = 0
    divider.ZIndex = 11
    divider.Parent = nav

    local bottomBar = Instance.new("Frame")
    bottomBar.Size = UDim2.new(1, -16, 0, 80)
    bottomBar.Position = UDim2.new(0, 8, 1, -88)
    bottomBar.BackgroundTransparency = 1
    bottomBar.ZIndex = 11
    bottomBar.Parent = nav

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(1, 0, 0, 34)
    minBtn.Position = UDim2.new(0, 0, 0, 0)
    minBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.BackgroundTransparency = 1
    minBtn.BorderSizePixel = 0
    minBtn.Text = ""
    minBtn.AutoButtonColor = false
    minBtn.ZIndex = 12
    minBtn.Parent = bottomBar
    corner(minBtn, 10)

    local minIcon = mkLabel(minBtn, "—", 14, C.TextOnRed,
        Enum.TextXAlignment.Center, Enum.Font.GothamBold)
    minIcon.Size = UDim2.new(0, 30, 1, 0)
    minIcon.Position = UDim2.new(0, 6, 0, 0)
    minIcon.TextTransparency = 0.35
    minIcon.ZIndex = 13
    minIcon.Name = "Icon"

    local minLbl = mkLabel(minBtn, "缩小", 13, C.TextOnRed)
    minLbl.Size = UDim2.new(1, -46, 1, 0)
    minLbl.Position = UDim2.new(0, 38, 0, 0)
    minLbl.TextTransparency = 0.35
    minLbl.ZIndex = 13
    minLbl.Name = "Title"

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(1, 0, 0, 34)
    closeBtn.Position = UDim2.new(0, 0, 0, 38)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.BackgroundTransparency = 1
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = ""
    closeBtn.AutoButtonColor = false
    closeBtn.ZIndex = 12
    closeBtn.Parent = bottomBar
    corner(closeBtn, 10)

    local closeIcon = mkLabel(closeBtn, "X", 13, C.TextOnRed,
        Enum.TextXAlignment.Center, Enum.Font.GothamBold)
    closeIcon.Size = UDim2.new(0, 30, 1, 0)
    closeIcon.Position = UDim2.new(0, 6, 0, 0)
    closeIcon.TextTransparency = 0.35
    closeIcon.ZIndex = 13
    closeIcon.Name = "Icon"

    local closeLbl = mkLabel(closeBtn, "关闭", 13, C.TextOnRed)
    closeLbl.Size = UDim2.new(1, -46, 1, 0)
    closeLbl.Position = UDim2.new(0, 38, 0, 0)
    closeLbl.TextTransparency = 0.35
    closeLbl.ZIndex = 13
    closeLbl.Name = "Title"

    local function bindBottomBtn(btn, lbl, icon)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {
                BackgroundTransparency = 0.85
            }):Play()
            TweenService:Create(lbl, TweenInfo.new(0.15), {
                TextTransparency = 0
            }):Play()
            TweenService:Create(icon, TweenInfo.new(0.15), {
                TextTransparency = 0
            }):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(lbl, TweenInfo.new(0.2), {
                TextTransparency = 0.35
            }):Play()
            TweenService:Create(icon, TweenInfo.new(0.2), {
                TextTransparency = 0.35
            }):Play()
        end)
    end
    bindBottomBtn(minBtn, minLbl, minIcon)
    bindBottomBtn(closeBtn, closeLbl, closeIcon)

    local win = Instance.new("Frame")
    win.Size = UDim2.new(0, WIN_W, 0, WIN_H)
    win.Position = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
    win.BackgroundColor3 = C.BgWhite
    win.BackgroundTransparency = 0
    win.BorderSizePixel = 0
    win.Active = true
    win.ClipsDescendants = true
    win.ZIndex = 5
    win.Parent = ScreenGui
    corner(win, 16)
    stroke(win, C.Border, 1, 0)

    local targetPos = win.Position
    win.Position = UDim2.new(targetPos.X.Scale, targetPos.X.Offset, targetPos.Y.Scale, targetPos.Y.Offset + 30)
    win.BackgroundTransparency = 1
    TweenService:Create(win, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = targetPos,
        BackgroundTransparency = 0,
    }):Play()

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 46)
    topBar.BackgroundTransparency = 1
    topBar.ZIndex = 10
    topBar.Parent = win

    local titleLbl = mkLabel(topBar, name, 17, C.TextDark,
        Enum.TextXAlignment.Left, Enum.Font.GothamBold)
    titleLbl.Size = UDim2.new(1, -80, 1, 0)
    titleLbl.Position = UDim2.new(0, 24, 0, 0)
    titleLbl.ZIndex = 11

    local dragging, dragStart, startPosWin, startPosNav
    local function isIn(x, y, o)
        local a, s = o.AbsolutePosition, o.AbsoluteSize
        return x >= a.X and x <= a.X + s.X and y >= a.Y and y <= a.Y + s.Y
    end

    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local x, y = input.Position.X, input.Position.Y
        if isIn(x, y, topBar) then
            dragging = true
            dragStart = Vector2.new(x, y)
            startPosWin = win.Position
            startPosNav = nav.Position
        end
        if isIn(x, y, nav) and y < nav.AbsolutePosition.Y + 80 then
            dragging = true
            dragStart = Vector2.new(x, y)
            startPosWin = win.Position
            startPosNav = nav.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement
            and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local d = Vector2.new(input.Position.X, input.Position.Y) - dragStart
        win.Position = UDim2.new(startPosWin.X.Scale, startPosWin.X.Offset + d.X,
            startPosWin.Y.Scale, startPosWin.Y.Offset + d.Y)
        nav.Position = UDim2.new(startPosNav.X.Scale, startPosNav.X.Offset + d.X,
            startPosNav.Y.Scale, startPosNav.Y.Offset + d.Y)
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(win, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(nav, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(mini, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.delay(0.2, function() ScreenGui.Enabled = false end)
    end)

    local stage = 0
    local savedWinPos = nil
    local savedNavPos = nil

    local function collapsePanel()
        savedWinPos = win.Position
        savedNavPos = nav.Position

        local navAbs = nav.AbsolutePosition
        local navAbsSize = nav.AbsoluteSize

        TweenService:Create(win, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, navAbs.X + navAbsSize.X/2, 0, navAbs.Y + navAbsSize.Y/2),
            BackgroundTransparency = 1,
        }):Play()

        minIcon.Text = "▢"
        minLbl.Text = "收起导航"
    end

    local function expandPanel()
        local navAbs = nav.AbsolutePosition
        local navAbsSize = nav.AbsoluteSize

        win.Size = UDim2.new(0, 0, 0, 0)
        win.Position = UDim2.new(0, navAbs.X + navAbsSize.X/2, 0, navAbs.Y + navAbsSize.Y/2)
        win.BackgroundTransparency = 1

        local target = savedWinPos or UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)

        TweenService:Create(win, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, WIN_W, 0, WIN_H),
            Position = target,
            BackgroundTransparency = 0,
        }):Play()

        minIcon.Text = "—"
        minLbl.Text = "缩小"
    end

    local function collapseNav()
        savedNavPos = nav.Position
        local navAbs = nav.AbsolutePosition
        local navAbsSize = nav.AbsoluteSize
        local centerX = navAbs.X + navAbsSize.X/2
        local centerY = navAbs.Y + navAbsSize.Y/2

        TweenService:Create(nav, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, MINI_SIZE, 0, MINI_SIZE),
            Position = UDim2.new(0, centerX - MINI_SIZE/2, 0, centerY - MINI_SIZE/2),
        }):Play()

        task.delay(0.3, function()
            nav.Visible = false
        end)

        mini.Position = UDim2.new(0, centerX - MINI_SIZE/2, 0, centerY - MINI_SIZE/2)
        mini.Size = UDim2.new(0, MINI_SIZE, 0, MINI_SIZE)
        mini.BackgroundTransparency = 1
        mini.Visible = true
        TweenService:Create(mini, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0
        }):Play()
    end

    local function expandNav(callback)
        local miniAbs = mini.AbsolutePosition
        local miniAbsSize = mini.AbsoluteSize
        local centerX = miniAbs.X + miniAbsSize.X/2
        local centerY = miniAbs.Y + miniAbsSize.Y/2

        TweenService:Create(mini, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            BackgroundTransparency = 1
        }):Play()

        nav.Visible = true
        nav.Size = UDim2.new(0, MINI_SIZE, 0, MINI_SIZE)
        nav.Position = UDim2.new(0, centerX - MINI_SIZE/2, 0, centerY - MINI_SIZE/2)

        TweenService:Create(nav, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, NAV_W, 0, WIN_H - 40),
            Position = savedNavPos or UDim2.new(0.5, -WIN_W/2 - NAV_W - NAV_GAP, 0.5, -(WIN_H-40)/2 + 20),
        }):Play()

        task.delay(0.28, function()
            mini.Visible = false
            if callback then callback() end
        end)
    end

    minBtn.MouseButton1Click:Connect(function()
        if stage == 0 then
            stage = 1
            collapsePanel()
        elseif stage == 1 then
            stage = 2
            collapseNav()
        end
    end)

    -- 小方块：拖动 + 点击展开（统一坐标系）
    local miniDragging = false
    local miniDragStart = nil
    local miniStartPos = nil
    local miniPressTime = 0
    local miniMoved = false

    miniBtn.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch then return end
        miniDragging = true
        miniMoved = false
        miniPressTime = tick()
        local pos = UserInputService:GetMouseLocation()
        miniDragStart = Vector2.new(pos.X, pos.Y)
        miniStartPos = mini.Position
    end)

    miniBtn.InputChanged:Connect(function(input)
        if not miniDragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement
            and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local pos = UserInputService:GetMouseLocation()
        local cur = Vector2.new(pos.X, pos.Y)
        local d = cur - miniDragStart

        if math.abs(d.X) > 4 or math.abs(d.Y) > 4 then
            miniMoved = true
        end

        if miniMoved then
            mini.Position = UDim2.new(
                miniStartPos.X.Scale, miniStartPos.X.Offset + d.X,
                miniStartPos.Y.Scale, miniStartPos.Y.Offset + d.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch then return end
        if not miniDragging then return end

        local held = tick() - miniPressTime
        miniDragging = false

        if not miniMoved and held < 0.5 and stage == 2 then
            expandNav(function()
                task.wait(0.05)
                stage = 0
                expandPanel()
            end)
        end
    end)

    miniBtn.MouseEnter:Connect(function()
        TweenService:Create(mini, TweenInfo.new(0.15), {
            BackgroundColor3 = C.PrimaryDeep
        }):Play()
    end)
    miniBtn.MouseLeave:Connect(function()
        TweenService:Create(mini, TweenInfo.new(0.2), {
            BackgroundColor3 = C.Primary
        }):Play()
    end)

    UserInputService.InputBegan:Connect(function(input, g)
        if g then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)

    local body = Instance.new("Frame")
    body.Size = UDim2.new(1, 0, 1, -46)
    body.Position = UDim2.new(0, 0, 0, 46)
    body.BackgroundTransparency = 1
    body.ZIndex = 10
    body.Parent = win

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -40, 1, -30)
    content.Position = UDim2.new(0, 20, 0, 10)
    content.BackgroundTransparency = 1
    content.ZIndex = 11
    content.Parent = body

    local WinAPI = {}
    local tabCount = 0

    function WinAPI:Tab(tabName)
        tabName = tabName or "标签"
        tabCount = tabCount + 1

        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 40)
        tabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.BackgroundTransparency = 1
        tabBtn.BorderSizePixel = 0
        tabBtn.Text = ""
        tabBtn.AutoButtonColor = false
        tabBtn.LayoutOrder = tabCount
        tabBtn.ZIndex = 13
        tabBtn.Parent = navHolder
        corner(tabBtn, 10)

        local tabDot = Instance.new("Frame")
        tabDot.Size = UDim2.new(0, 6, 0, 6)
        tabDot.Position = UDim2.new(0, 14, 0.5, -3)
        tabDot.BackgroundColor3 = C.TextOnRed
        tabDot.BackgroundTransparency = 0.4
        tabDot.BorderSizePixel = 0
        tabDot.ZIndex = 14
        tabDot.Parent = tabBtn
        corner(tabDot, 3)
        tabDot.Name = "Dot"

        local tabLbl = mkLabel(tabBtn, tabName, 13,
            C.TextOnRed, Enum.TextXAlignment.Left, Enum.Font.Gotham)
        tabLbl.Size = UDim2.new(1, -44, 1, 0)
        tabLbl.Position = UDim2.new(0, 32, 0, 0)
        tabLbl.TextTransparency = 0.4
        tabLbl.ZIndex = 14
        tabLbl.Name = "Title"

        local container = Instance.new("ScrollingFrame")
        container.Size = UDim2.new(1, 0, 1, 0)
        container.BackgroundTransparency = 1
        container.BorderSizePixel = 0
        container.ScrollBarThickness = 3
        container.ScrollBarImageColor3 = C.Border
        container.CanvasSize = UDim2.new(0, 0, 0, 0)
        container.AutomaticCanvasSize = Enum.AutomaticSize.Y
        container.Visible = false
        container.ZIndex = 11
        container.Parent = content

        local cl = Instance.new("UIListLayout")
        cl.SortOrder = Enum.SortOrder.LayoutOrder
        cl.Padding = UDim.new(0, 14)
        cl.Parent = container

        if tabCount == 1 then
            container.Visible = true
            tabBtn.BackgroundTransparency = 0.15
            tabBtn.BackgroundColor3 = C.TextOnRed
            tabLbl.TextColor3 = C.Primary
            tabLbl.TextTransparency = 0
            tabDot.BackgroundColor3 = C.Primary
            tabDot.BackgroundTransparency = 0
        end

        tabBtn.MouseEnter:Connect(function()
            if container.Visible then return end
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {
                BackgroundTransparency = 0.82
            }):Play()
            TweenService:Create(tabLbl, TweenInfo.new(0.15), {
                TextTransparency = 0.1
            }):Play()
        end)
        tabBtn.MouseLeave:Connect(function()
            if container.Visible then return end
            TweenService:Create(tabBtn, TweenInfo.new(0.2), {
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(tabLbl, TweenInfo.new(0.2), {
                TextTransparency = 0.4
            }):Play()
        end)

        tabBtn.MouseButton1Click:Connect(function()
            for _, t in ipairs(navHolder:GetChildren()) do
                if t:IsA("TextButton") then
                    TweenService:Create(t, TweenInfo.new(0.2), {
                        BackgroundTransparency = 1
                    }):Play()
                    TweenService:Create(t.Title, TweenInfo.new(0.2), {
                        TextColor3 = C.TextOnRed, TextTransparency = 0.4
                    }):Play()
                    TweenService:Create(t.Dot, TweenInfo.new(0.2), {
                        BackgroundColor3 = C.TextOnRed, BackgroundTransparency = 0.4
                    }):Play()
                end
            end
            for _, c in ipairs(content:GetChildren()) do
                if c:IsA("ScrollingFrame") then c.Visible = false end
            end
            tabBtn.BackgroundColor3 = C.TextOnRed
            tabBtn.BackgroundTransparency = 0.15
            tabLbl.TextColor3 = C.Primary
            tabLbl.TextTransparency = 0
            tabDot.BackgroundColor3 = C.Primary
            tabDot.BackgroundTransparency = 0
            container.Visible = true
        end)

        return makeControls(container)
    end

    function WinAPI:Destroy()
        ScreenGui:Destroy()
    end
    function WinAPI:Toggle()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
    return WinAPI
end

return Mitea