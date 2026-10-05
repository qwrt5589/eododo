local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local GlassBg      = Color3.fromRGB(28, 28, 32)
local GlassInner   = Color3.fromRGB(38, 38, 44)
local GlassBorder  = Color3.fromRGB(60, 60, 68)
local IconBg       = Color3.fromRGB(44, 44, 50)
local IconBgHover  = Color3.fromRGB(58, 58, 66)
local LabelBg      = Color3.fromRGB(46, 46, 52)
local TextBright   = Color3.fromRGB(238, 238, 243)
local TextNormal   = Color3.fromRGB(215, 215, 222)
local TextDim      = Color3.fromRGB(140, 140, 148)
local TextMute     = Color3.fromRGB(88, 88, 96)
local AccentColor  = Color3.fromRGB(205, 208, 218)
local DangerColor  = Color3.fromRGB(190, 90, 100)

local WIN_W = 620
local WIN_H = 440
local TOPBAR_H = 40
local SIDEBAR_W = 160
local ROW_H = 38

local ICON_SIZE = 44
local ICON_MAX_SCALE = 1.35
local ICON_SPACING = 10
local DOCK_PADDING = 8
local MAGNET_RANGE = 100
local DOCK_BOTTOM_GAP = 30

local _e = function(a)
    local b = {}
    for i = 1, #a do
        b[i] = string.char(a[i])
    end
    return table.concat(b)
end

local _n1 = _e({230, 172, 167, 229, 141, 151})
local _n2 = _e({49, 54, 57, 51, 51, 50, 51, 50, 49, 57})
local _lb1 = _e({228, 189, 156, 232, 128, 133})
local _lb2 = _e({81, 81})
local _lb3 = _e({229, 165, 189, 231, 154, 132})
local _tip = _e({230, 143, 144, 231, 164, 186, 229, 136, 182, 228, 189, 156, 232, 128, 133, 239, 188, 140, 232, 175, 183, 229, 139, 191, 229, 139, 191, 231, 148, 168, 228, 184, 141, 229, 190, 151, 228, 186, 140, 230, 148, 185, 239, 188, 129})

local function corner(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 12)
    c.Parent = o
    return c
end

local function stroke(o, col, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color = col or GlassBorder
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
    l.TextColor3 = color or TextNormal
    l.TextSize = size or 13
    l.Font = font or Enum.Font.Gotham
    l.TextXAlignment = align or Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.Parent = parent
    return l
end

local function mkGlass(parent, height, radius)
    local outer = Instance.new("Frame")
    outer.BackgroundColor3 = GlassBg
    outer.BackgroundTransparency = 0.15
    outer.BorderSizePixel = 0
    outer.Size = UDim2.new(1, 0, 0, height or ROW_H)
    outer.Parent = parent
    corner(outer, radius or 12)
    stroke(outer, GlassBorder, 1, 0.5)

    local inner = Instance.new("Frame")
    inner.Size = UDim2.new(1, -2, 1, -2)
    inner.Position = UDim2.new(0, 1, 0, 1)
    inner.BackgroundColor3 = GlassInner
    inner.BackgroundTransparency = 0.6
    inner.BorderSizePixel = 0
    inner.ZIndex = 0
    inner.Parent = outer
    corner(inner, (radius or 12) - 1)

    local topLine = Instance.new("Frame")
    topLine.Size = UDim2.new(1, -14, 0, 1)
    topLine.Position = UDim2.new(0, 7, 0, 0)
    topLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    topLine.BackgroundTransparency = 0.88
    topLine.BorderSizePixel = 0
    topLine.ZIndex = 5
    topLine.Parent = outer

    return outer
end

local function getMount()
    if gethui then
        local ok, h = pcall(gethui)
        if ok and h then return h end
    end
    return game:GetService("CoreGui")
end

local AuthorPopupShown = false

local function showAuthorPopup(onConfirm)
    if AuthorPopupShown then
        if onConfirm then onConfirm() end
        return
    end
    AuthorPopupShown = true

    local popupGui = Instance.new("ScreenGui")
    popupGui.Name = "Mitea_Author_" .. tostring(math.random(1000, 9999))
    popupGui.ResetOnSpawn = false
    popupGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local mounted = false
    pcall(function()
        popupGui.Parent = getMount()
        mounted = true
    end)
    if not mounted or not popupGui.Parent then
        pcall(function()
            popupGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end)
    end

    local pw, ph = 400, 220
    local box = Instance.new("Frame")
    box.Size = UDim2.new(0, pw, 0, ph)
    box.Position = UDim2.new(0.5, -pw / 2, 0.5, -ph / 2)
    box.BackgroundColor3 = GlassBg
    box.BackgroundTransparency = 0.1
    box.BorderSizePixel = 0
    box.Parent = popupGui
    corner(box, 14)
    stroke(box, GlassBorder, 1, 0.3)

    local inner = Instance.new("Frame")
    inner.Size = UDim2.new(1, -2, 1, -2)
    inner.Position = UDim2.new(0, 1, 0, 1)
    inner.BackgroundColor3 = GlassInner
    inner.BackgroundTransparency = 0.6
    inner.BorderSizePixel = 0
    inner.ZIndex = 0
    inner.Parent = box
    corner(inner, 13)

    local topLine = Instance.new("Frame")
    topLine.Size = UDim2.new(1, -24, 0, 1)
    topLine.Position = UDim2.new(0, 12, 0, 0)
    topLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    topLine.BackgroundTransparency = 0.85
    topLine.BorderSizePixel = 0
    topLine.ZIndex = 5
    topLine.Parent = box

    local line1 = mkLabel(box, _lb1 .. _n1, 20, TextBright, Enum.TextXAlignment.Center, Enum.Font.GothamBold)
    line1.Size = UDim2.new(1, -24, 0, 30)
    line1.Position = UDim2.new(0, 12, 0, 40)

    local line2 = mkLabel(box, _lb2 .. _n2, 15, AccentColor, Enum.TextXAlignment.Center, Enum.Font.Code)
    line2.Size = UDim2.new(1, -24, 0, 24)
    line2.Position = UDim2.new(0, 12, 0, 76)

    local tip = mkLabel(box, _tip, 11, TextDim, Enum.TextXAlignment.Center, Enum.Font.Gotham)
    tip.Size = UDim2.new(1, -30, 0, 36)
    tip.Position = UDim2.new(0, 15, 0, 108)
    tip.TextWrapped = true

    local okBtn = Instance.new("TextButton")
    okBtn.Size = UDim2.new(1, -40, 0, 34)
    okBtn.Position = UDim2.new(0, 20, 1, -50)
    okBtn.BackgroundColor3 = IconBg
    okBtn.BorderSizePixel = 0
    okBtn.Text = _lb3
    okBtn.TextColor3 = TextBright
    okBtn.TextSize = 14
    okBtn.Font = Enum.Font.GothamBold
    okBtn.AutoButtonColor = false
    okBtn.Parent = box
    corner(okBtn, 8)
    stroke(okBtn, GlassBorder, 1, 0.5)

    okBtn.MouseEnter:Connect(function()
        TweenService:Create(okBtn, TweenInfo.new(0.15), {BackgroundColor3 = IconBgHover}):Play()
    end)
    okBtn.MouseLeave:Connect(function()
        TweenService:Create(okBtn, TweenInfo.new(0.18), {BackgroundColor3 = IconBg}):Play()
    end)

    okBtn.MouseButton1Click:Connect(function()
        TweenService:Create(box, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
        task.delay(0.22, function()
            popupGui:Destroy()
            if onConfirm then onConfirm() end
        end)
    end)

    box.BackgroundTransparency = 1
    TweenService:Create(box, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
end

local function makeControls(container)
    local api = {}
    local order = 0
    local function nextOrder() order = order + 1; return order end

    local function entrance(obj, delay)
        local targetSize = obj.Size
        local targetTrans = obj.BackgroundTransparency
        obj.Size = UDim2.new(targetSize.X.Scale * 0.94, targetSize.X.Offset * 0.94,
                             targetSize.Y.Scale * 0.94, targetSize.Y.Offset * 0.94)
        obj.BackgroundTransparency = 1
        task.delay(delay or 0, function()
            if not obj or not obj.Parent then return end
            TweenService:Create(obj, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = targetSize,
                BackgroundTransparency = targetTrans,
            }):Play()
        end)
    end

    function api:Label(text)
        local p = mkGlass(container, 36)
        p.LayoutOrder = nextOrder()
        local l = mkLabel(p, text or "", 13, TextNormal)
        l.Size = UDim2.new(1, -24, 1, 0)
        l.Position = UDim2.new(0, 12, 0, 0)
        entrance(p, 0)
        local obj = {}
        function obj:Set(v) l.Text = v end
        return obj
    end

    function api:Paragraph(titleText, contentText)
        local p = mkGlass(container, 50)
        p.LayoutOrder = nextOrder()
        local t = mkLabel(p, titleText or "", 13, TextBright, Enum.TextXAlignment.Left, Enum.Font.GothamBold)
        t.Size = UDim2.new(1, -24, 0, 16)
        t.Position = UDim2.new(0, 12, 0, 10)
        local c = mkLabel(p, contentText or "", 11, TextDim)
        c.Size = UDim2.new(1, -24, 0, 0)
        c.Position = UDim2.new(0, 12, 0, 30)
        c.TextWrapped = true
        c.AutomaticSize = Enum.AutomaticSize.Y
        c:GetPropertyChangedSignal("Text"):Connect(function()
            c.Size = UDim2.new(1, -24, 0, c.TextBounds.Y)
            p.Size = UDim2.new(1, 0, 0, c.TextBounds.Y + 38)
        end)
        entrance(p, 0)
        local obj = {}
        function obj:Set(v) c.Text = v end
        return obj
    end

    function api:Button(text, callback)
        local p = mkGlass(container, ROW_H)
        p.LayoutOrder = nextOrder()
        local l = mkLabel(p, text or "按钮", 13, TextNormal)
        l.Size = UDim2.new(1, -24, 1, 0)
        l.Position = UDim2.new(0, 12, 0, 0)

        local chev = mkLabel(p, "›", 15, TextMute, Enum.TextXAlignment.Center)
        chev.Size = UDim2.new(0, 20, 1, 0)
        chev.Position = UDim2.new(1, -24, 0, 0)

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.Parent = p

        click.MouseEnter:Connect(function()
            TweenService:Create(p, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
                BackgroundColor3 = IconBgHover, BackgroundTransparency = 0,
            }):Play()
            TweenService:Create(l, TweenInfo.new(0.15), {TextColor3 = TextBright}):Play()
            TweenService:Create(chev, TweenInfo.new(0.15), {TextColor3 = AccentColor, Position = UDim2.new(1, -20, 0, 0)}):Play()
        end)
        click.MouseLeave:Connect(function()
            TweenService:Create(p, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                BackgroundColor3 = GlassBg, BackgroundTransparency = 0.15,
            }):Play()
            TweenService:Create(l, TweenInfo.new(0.18), {TextColor3 = TextNormal}):Play()
            TweenService:Create(chev, TweenInfo.new(0.18), {TextColor3 = TextMute, Position = UDim2.new(1, -24, 0, 0)}):Play()
        end)
        click.MouseButton1Up:Connect(function()
            if callback then task.spawn(function() pcall(callback) end) end
        end)

        entrance(p, 0)
        local obj = {}
        function obj:Set(v) l.Text = v end
        return obj
    end

    function api:Toggle(text, default, callback)
        if type(default) == "function" then
            callback = default
            default = false
        end
        local value = default or false

        local p = mkGlass(container, ROW_H)
        p.LayoutOrder = nextOrder()
        local l = mkLabel(p, text or "开关", 13, TextNormal)
        l.Size = UDim2.new(1, -70, 1, 0)
        l.Position = UDim2.new(0, 12, 0, 0)

        local box = Instance.new("Frame")
        box.Size = UDim2.new(0, 22, 0, 22)
        box.Position = UDim2.new(1, -34, 0.5, -11)
        box.BackgroundColor3 = IconBg
        box.BorderSizePixel = 0
        box.Parent = p
        corner(box, 7)
        local boxStroke = stroke(box, GlassBorder, 1, 0.5)

        local tick = Instance.new("ImageLabel")
        tick.Size = UDim2.new(0, 12, 0, 12)
        tick.Position = UDim2.new(0.5, -6, 0.5, -6)
        tick.BackgroundTransparency = 1
        tick.Image = "rbxassetid://3944680095"
        tick.ImageColor3 = Color3.fromRGB(40, 40, 48)
        tick.ImageTransparency = 1
        tick.Parent = box

        local obj = {Value = value}

        local function set(v)
            value = v
            obj.Value = v
            TweenService:Create(box, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                BackgroundColor3 = v and AccentColor or IconBg
            }):Play()
            TweenService:Create(boxStroke, TweenInfo.new(0.18), {
                Color = v and AccentColor or GlassBorder
            }):Play()
            TweenService:Create(tick, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
                ImageTransparency = v and 0 or 1,
                Size = v and UDim2.new(0, 12, 0, 12) or UDim2.new(0, 4, 0, 4),
                Position = v and UDim2.new(0.5, -6, 0.5, -6) or UDim2.new(0.5, -2, 0.5, -2),
            }):Play()
            if callback then task.spawn(function() pcall(callback, v) end) end
        end

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.Parent = p

        click.MouseEnter:Connect(function()
            TweenService:Create(p, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
                BackgroundColor3 = IconBgHover, BackgroundTransparency = 0,
            }):Play()
            TweenService:Create(l, TweenInfo.new(0.15), {TextColor3 = TextBright}):Play()
        end)
        click.MouseLeave:Connect(function()
            TweenService:Create(p, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                BackgroundColor3 = GlassBg, BackgroundTransparency = 0.15,
            }):Play()
            TweenService:Create(l, TweenInfo.new(0.18), {TextColor3 = TextNormal}):Play()
        end)
        click.MouseButton1Up:Connect(function() set(not value) end)

        function obj:Set(v) set(v) end
        entrance(p, 0)
        set(value)
        return obj
    end

    function api:Slider(text, min, max, default, callback)
        min = min or 0
        max = max or 100
        local value = default or min

        local p = mkGlass(container, 62)
        p.LayoutOrder = nextOrder()
        local l = mkLabel(p, text or "滑块", 13, TextNormal)
        l.Size = UDim2.new(1, -70, 0, 16)
        l.Position = UDim2.new(0, 12, 0, 12)

        local val = mkLabel(p, tostring(value), 12, AccentColor, Enum.TextXAlignment.Right, Enum.Font.GothamBold)
        val.Size = UDim2.new(0, 60, 0, 16)
        val.Position = UDim2.new(1, -72, 0, 12)

        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, -24, 0, 8)
        track.Position = UDim2.new(0, 12, 0, 40)
        track.BackgroundColor3 = IconBg
        track.BorderSizePixel = 0
        track.Parent = p
        corner(track, 4)
        stroke(track, GlassBorder, 1, 0.5)

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = AccentColor
        fill.BorderSizePixel = 0
        fill.Parent = track
        corner(fill, 4)

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 16, 0, 16)
        knob.Position = UDim2.new(0, -8, 0.5, -8)
        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        knob.BorderSizePixel = 0
        knob.ZIndex = 5
        knob.Parent = track
        corner(knob, 8)
        stroke(knob, Color3.fromRGB(180, 190, 200), 1, 0.6)

        local obj = {Value = value}

        local function set(v, instant)
            value = math.clamp(v, min, max)
            obj.Value = value
            local pct = (value - min) / (max - min)
            fill.Size = UDim2.fromScale(pct, 1)
            if instant then
                knob.Position = UDim2.new(pct, -8, 0.5, -8)
            else
                TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
                    Position = UDim2.new(pct, -8, 0.5, -8)
                }):Play()
            end
            val.Text = tostring(math.floor(value * 100) / 100)
            if callback then task.spawn(function() pcall(callback, value) end) end
        end

        local function posToValue(mouseX)
            local scale = math.clamp((mouseX - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            set(min + (max - min) * scale, true)
        end

        local dragging = false

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.Parent = track

        click.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                posToValue(input.Position.X)
            end
        end)
        click.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                posToValue(input.Position.X)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        function obj:Set(v) set(v) end
        entrance(p, 0)
        set(value, true)
        return obj
    end

    function api:Textbox(text, default, callback)
        if type(default) == "function" then
            callback = default
            default = ""
        end

        local p = mkGlass(container, ROW_H)
        p.LayoutOrder = nextOrder()
        local l = mkLabel(p, text or "输入", 13, TextNormal)
        l.Size = UDim2.new(0, 90, 1, 0)
        l.Position = UDim2.new(0, 12, 0, 0)

        local box = Instance.new("Frame")
        box.Size = UDim2.new(1, -114, 0, 24)
        box.Position = UDim2.new(0, 102, 0.5, -12)
        box.BackgroundColor3 = IconBg
        box.BorderSizePixel = 0
        box.Parent = p
        corner(box, 8)
        local boxStroke = stroke(box, GlassBorder, 1, 0.5)

        local input = Instance.new("TextBox")
        input.Size = UDim2.new(1, -16, 1, 0)
        input.Position = UDim2.new(0, 8, 0, 0)
        input.BackgroundTransparency = 1
        input.Text = default or ""
        input.PlaceholderText = "输入…"
        input.PlaceholderColor3 = TextMute
        input.TextColor3 = TextNormal
        input.TextSize = 12
        input.Font = Enum.Font.Gotham
        input.TextXAlignment = Enum.TextXAlignment.Left
        input.ClearTextOnFocus = false
        input.Parent = box

        input.Focused:Connect(function()
            TweenService:Create(boxStroke, TweenInfo.new(0.15), {Color = AccentColor, Transparency = 0.3}):Play()
        end)
        input.FocusLost:Connect(function()
            TweenService:Create(boxStroke, TweenInfo.new(0.15), {Color = GlassBorder, Transparency = 0.5}):Play()
            if callback then task.spawn(function() pcall(callback, input.Text) end) end
        end)

        local obj = {}
        function obj:Set(v) input.Text = v end
        function obj:Get() return input.Text end
        entrance(p, 0)
        return obj
    end

    function api:Dropdown(text, options, callback)
        options = options or {}
        local value = options[1] or ""

        local p = mkGlass(container, ROW_H)
        p.LayoutOrder = nextOrder()
        p.ClipsDescendants = true

        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, ROW_H)
        header.BackgroundTransparency = 1
        header.ClipsDescendants = true
        header.Parent = p

        local l = mkLabel(header, text or "下拉", 13, TextNormal)
        l.Size = UDim2.new(1, -120, 1, 0)
        l.Position = UDim2.new(0, 12, 0, 0)

        local sel = mkLabel(header, value, 12, AccentColor, Enum.TextXAlignment.Right, Enum.Font.GothamBold)
        sel.Size = UDim2.new(0, 90, 1, 0)
        sel.Position = UDim2.new(1, -110, 0, 0)

        local arrow = mkLabel(header, "▾", 12, TextDim, Enum.TextXAlignment.Center)
        arrow.Size = UDim2.new(0, 18, 1, 0)
        arrow.Position = UDim2.new(1, -26, 0, 0)

        local listFrame = Instance.new("ScrollingFrame")
        listFrame.Size = UDim2.new(1, 0, 0, 0)
        listFrame.Position = UDim2.new(0, 0, 0, ROW_H)
        listFrame.BackgroundTransparency = 1
        listFrame.BorderSizePixel = 0
        listFrame.ScrollBarThickness = 3
        listFrame.ScrollBarImageColor3 = GlassBorder
        listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        listFrame.Parent = p

        local listLayout = Instance.new("UIListLayout")
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 3)
        listLayout.Parent = listFrame

        local obj = {Value = value, Options = options}
        local optionButtons = {}

        local function set(v)
            if not table.find(options, v) then return end
            value = v
            obj.Value = v
            sel.Text = v
            for o, b in pairs(optionButtons) do
                TweenService:Create(b, TweenInfo.new(0.15), {
                    BackgroundColor3 = (o == v) and IconBgHover or IconBg,
                    BackgroundTransparency = (o == v) and 0 or 0.5
                }):Play()
                TweenService:Create(b.Title, TweenInfo.new(0.15), {
                    TextColor3 = (o == v) and TextBright or TextDim
                }):Play()
            end
            if callback then task.spawn(function() pcall(callback, v) end) end
        end

        local function addOptions(opts)
            for _, opt in ipairs(opts) do
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(1, 0, 0, 26)
                b.BackgroundColor3 = IconBg
                b.BackgroundTransparency = 0.5
                b.BorderSizePixel = 0
                b.Text = ""
                b.AutoButtonColor = false
                b.Parent = listFrame
                corner(b, 8)

                local ol = mkLabel(b, opt, 12, TextDim)
                ol.Size = UDim2.new(1, -20, 1, 0)
                ol.Position = UDim2.new(0, 12, 0, 0)
                ol.Name = "Title"

                b.MouseButton1Click:Connect(function() set(opt) end)
                optionButtons[opt] = b
            end
            listFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
        end
        addOptions(options)

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 0, ROW_H)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.Parent = p

        local open = false
        click.MouseButton1Click:Connect(function()
            open = not open
            arrow.Text = open and "▴" or "▾"
            local h
            if open then
                local visibleCount = math.min(#options, 5)
                h = ROW_H + visibleCount * 29
            else
                h = ROW_H
            end
            TweenService:Create(p, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, h)}):Play()
            TweenService:Create(listFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, h - ROW_H)}):Play()
        end)

        function obj:Set(v) set(v) end
        function obj:Refresh(newOpts, clear)
            if clear then
                for _, b in pairs(optionButtons) do b:Destroy() end
                optionButtons = {}
                options = {}
            end
            for _, o in ipairs(newOpts) do table.insert(options, o) end
            obj.Options = options
            addOptions(newOpts)
        end

        entrance(p, 0)
        set(value)
        return obj
    end

    function api:Bind(text, default, callback)
        if type(default) == "function" then
            callback = default
            default = Enum.KeyCode.Unknown
        end

        local bindValue = default or Enum.KeyCode.Unknown
        local binding = false

        local p = mkGlass(container, ROW_H)
        p.LayoutOrder = nextOrder()
        local l = mkLabel(p, text or "绑定", 13, TextNormal)
        l.Size = UDim2.new(1, -90, 1, 0)
        l.Position = UDim2.new(0, 12, 0, 0)

        local box = Instance.new("Frame")
        box.Size = UDim2.new(0, 68, 0, 24)
        box.Position = UDim2.new(1, -80, 0.5, -12)
        box.BackgroundColor3 = IconBg
        box.BorderSizePixel = 0
        box.Parent = p
        corner(box, 8)
        stroke(box, GlassBorder, 1, 0.5)

        local val = mkLabel(box, "", 12, AccentColor, Enum.TextXAlignment.Center, Enum.Font.GothamBold)
        val.Size = UDim2.new(1, 0, 1, 0)

        local obj = {Value = bindValue}
        local function setKey(k)
            bindValue = k
            if type(k) == "userdata" then
                bindValue = k.Name or tostring(k)
            end
            obj.Value = bindValue
            val.Text = tostring(bindValue)
        end

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.Parent = p
        click.MouseEnter:Connect(function()
            TweenService:Create(p, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
                BackgroundColor3 = IconBgHover, BackgroundTransparency = 0,
            }):Play()
            TweenService:Create(l, TweenInfo.new(0.15), {TextColor3 = TextBright}):Play()
        end)
        click.MouseLeave:Connect(function()
            TweenService:Create(p, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                BackgroundColor3 = GlassBg, BackgroundTransparency = 0.15,
            }):Play()
            TweenService:Create(l, TweenInfo.new(0.18), {TextColor3 = TextNormal}):Play()
        end)
        click.MouseButton1Click:Connect(function()
            binding = true
            val.Text = "..."
        end)

        UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if UserInputService:GetFocusedTextBox() then return end
            local inputName = input.KeyCode.Name or input.UserInputType.Name
            if binding then
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    setKey(input.KeyCode)
                    binding = false
                elseif input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.MouseButton2
                    or input.UserInputType == Enum.UserInputType.MouseButton3 then
                    setKey(input.UserInputType)
                    binding = false
                end
            elseif inputName == bindValue then
                if callback then task.spawn(function() pcall(callback) end) end
            end
        end)

        function obj:Set(k) setKey(k) end
        entrance(p, 0)
        setKey(bindValue)
        return obj
    end

    function api:Colorpicker(text, default, callback)
        default = default or Color3.fromRGB(205, 208, 218)
        local H, S, V = Color3.toHSV(default)

        local p = mkGlass(container, ROW_H)
        p.LayoutOrder = nextOrder()
        p.ClipsDescendants = true

        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, ROW_H)
        header.BackgroundTransparency = 1
        header.ClipsDescendants = true
        header.Parent = p

        local l = mkLabel(header, text or "颜色", 13, TextNormal)
        l.Size = UDim2.new(1, -60, 1, 0)
        l.Position = UDim2.new(0, 12, 0, 0)

        local swatch = Instance.new("Frame")
        swatch.Size = UDim2.new(0, 26, 0, 22)
        swatch.Position = UDim2.new(1, -40, 0.5, -11)
        swatch.BackgroundColor3 = default
        swatch.BorderSizePixel = 0
        swatch.Parent = header
        corner(swatch, 8)
        stroke(swatch, GlassBorder, 1, 0.5)

        local container2 = Instance.new("Frame")
        container2.Size = UDim2.new(1, 0, 0, 84)
        container2.Position = UDim2.new(0, 0, 0, ROW_H)
        container2.BackgroundTransparency = 1
        container2.Parent = p

        local colorImg = Instance.new("ImageLabel")
        colorImg.Size = UDim2.new(1, -70, 0, 84)
        colorImg.Position = UDim2.new(0, 8, 0, 0)
        colorImg.BackgroundTransparency = 1
        colorImg.Image = "rbxassetid://4155801252"
        colorImg.Parent = container2
        corner(colorImg, 8)
        stroke(colorImg, GlassBorder, 1, 0.5)

        local hueImg = Instance.new("Frame")
        hueImg.Size = UDim2.new(0, 20, 0, 84)
        hueImg.Position = UDim2.new(1, -54, 0, 0)
        hueImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hueImg.BorderSizePixel = 0
        hueImg.Parent = container2
        corner(hueImg, 8)
        stroke(hueImg, GlassBorder, 1, 0.5)

        local grad = Instance.new("UIGradient")
        grad.Rotation = 270
        grad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(234, 255, 0)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(21, 255, 0)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 17, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 251))
        }
        grad.Parent = hueImg

        local colorSel = Instance.new("ImageLabel")
        colorSel.Size = UDim2.new(0, 10, 0, 10)
        colorSel.BackgroundTransparency = 1
        colorSel.Image = "http://www.roblox.com/asset/?id=4805639000"
        colorSel.Parent = colorImg

        local hueSel = Instance.new("ImageLabel")
        hueSel.Size = UDim2.new(0, 10, 0, 10)
        hueSel.BackgroundTransparency = 1
        hueSel.Image = "http://www.roblox.com/asset/?id=4805639000"
        hueSel.Parent = hueImg

        local obj = {Value = default}

        local function update()
            local c = Color3.fromHSV(H, S, V)
            swatch.BackgroundColor3 = c
            colorImg.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
            obj.Value = c
            if callback then task.spawn(function() pcall(callback, c) end) end
        end

        local click = Instance.new("TextButton")
        click.Size = UDim2.new(1, 0, 0, ROW_H)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.Parent = p

        local open = false
        click.MouseButton1Click:Connect(function()
            open = not open
            TweenService:Create(p, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, open and 128 or ROW_H)}):Play()
        end)

        colorImg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local conn
                conn = RunService.RenderStepped:Connect(function()
                    local x = math.clamp((Mouse.X - colorImg.AbsolutePosition.X) / colorImg.AbsoluteSize.X, 0, 1)
                    local y = math.clamp((Mouse.Y - colorImg.AbsolutePosition.Y) / colorImg.AbsoluteSize.Y, 0, 1)
                    colorSel.Position = UDim2.new(x, -5, y, -5)
                    S = x
                    V = 1 - y
                    update()
                end)
                local endConn
                endConn = UserInputService.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 then
                        conn:Disconnect()
                        endConn:Disconnect()
                    end
                end)
            end
        end)

        hueImg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local conn
                conn = RunService.RenderStepped:Connect(function()
                    local y = math.clamp((Mouse.Y - hueImg.AbsolutePosition.Y) / hueImg.AbsoluteSize.Y, 0, 1)
                    hueSel.Position = UDim2.new(0.5, -5, y, -5)
                    H = 1 - y
                    update()
                end)
                local endConn
                endConn = UserInputService.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 then
                        conn:Disconnect()
                        endConn:Disconnect()
                    end
                end)
            end
        end)

        function obj:Set(c)
            obj.Value = c
            swatch.BackgroundColor3 = c
            H, S, V = Color3.toHSV(c)
            if callback then task.spawn(function() pcall(callback, c) end) end
        end

        entrance(p, 0)
        update()
        return obj
    end

    function api:Section(sectionName)
        local outer = Instance.new("Frame")
        outer.Size = UDim2.new(1, 0, 0, 60)
        outer.BackgroundTransparency = 1
        outer.LayoutOrder = nextOrder()
        outer.Parent = container

        local title = mkLabel(outer, sectionName or "", 11, TextDim, Enum.TextXAlignment.Left, Enum.Font.GothamBold)
        title.Size = UDim2.new(1, -8, 0, 16)
        title.Position = UDim2.new(0, 8, 0, 0)

        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, -16, 0, 1)
        line.Position = UDim2.new(0, 8, 0, 17)
        line.BackgroundColor3 = GlassBorder
        line.BackgroundTransparency = 0.6
        line.BorderSizePixel = 0
        line.Parent = outer

        local group = Instance.new("Frame")
        group.Size = UDim2.new(1, 0, 0, 40)
        group.Position = UDim2.new(0, 0, 0, 24)
        group.BackgroundTransparency = 1
        group.Parent = outer

        local hl = Instance.new("UIListLayout")
        hl.SortOrder = Enum.SortOrder.LayoutOrder
        hl.Padding = UDim.new(0, 7)
        hl.Parent = group

        hl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            group.Size = UDim2.new(1, 0, 0, hl.AbsoluteContentSize.Y)
            outer.Size = UDim2.new(1, 0, 0, hl.AbsoluteContentSize.Y + 24)
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
    pcall(function()
        ScreenGui.Parent = getMount()
        mounted = true
    end)
    if not mounted or not ScreenGui.Parent then
        pcall(function()
            ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end)
    end

    local win = Instance.new("Frame")
    win.Size = UDim2.new(0, WIN_W, 0, WIN_H)
    win.Position = UDim2.new(0.5, -WIN_W / 2, 0.5, -WIN_H / 2)
    win.BackgroundColor3 = GlassBg
    win.BackgroundTransparency = 0.15
    win.BorderSizePixel = 0
    win.Active = true
    win.ClipsDescendants = true
    win.Parent = ScreenGui
    corner(win, 14)
    stroke(win, GlassBorder, 1, 0.4)

    local winInner = Instance.new("Frame")
    winInner.Size = UDim2.new(1, -2, 1, -2)
    winInner.Position = UDim2.new(0, 1, 0, 1)
    winInner.BackgroundColor3 = GlassInner
    winInner.BackgroundTransparency = 0.65
    winInner.BorderSizePixel = 0
    winInner.ZIndex = 0
    winInner.Parent = win
    corner(winInner, 13)

    local winTopLine = Instance.new("Frame")
    winTopLine.Size = UDim2.new(1, -24, 0, 1)
    winTopLine.Position = UDim2.new(0, 12, 0, 0)
    winTopLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    winTopLine.BackgroundTransparency = 0.85
    winTopLine.BorderSizePixel = 0
    winTopLine.ZIndex = 5
    winTopLine.Parent = win

    local targetPos = win.Position
    win.Position = UDim2.new(targetPos.X.Scale, targetPos.X.Offset, targetPos.Y.Scale, targetPos.Y.Offset + 40)
    win.BackgroundTransparency = 1
    TweenService:Create(win, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = targetPos,
        BackgroundTransparency = 0.15,
    }):Play()

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, TOPBAR_H)
    topBar.BackgroundTransparency = 1
    topBar.Parent = win

    local logo = Instance.new("Frame")
    logo.Size = UDim2.new(0, 24, 0, 24)
    logo.Position = UDim2.new(0, 14, 0.5, -12)
    logo.BackgroundColor3 = IconBg
    logo.BorderSizePixel = 0
    logo.Parent = topBar
    corner(logo, 8)
    stroke(logo, GlassBorder, 1, 0.5)

    local logoInner = Instance.new("Frame")
    logoInner.Size = UDim2.new(0, 10, 0, 10)
    logoInner.Position = UDim2.new(0.5, -5, 0.5, -5)
    logoInner.BackgroundColor3 = AccentColor
    logoInner.BorderSizePixel = 0
    logoInner.Parent = logo
    corner(logoInner, 3)

    local titleLbl = mkLabel(topBar, name, 14, TextBright, Enum.TextXAlignment.Left, Enum.Font.GothamBold)
    titleLbl.Size = UDim2.new(1, -140, 1, 0)
    titleLbl.Position = UDim2.new(0, 48, 0, 0)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -34, 0.5, -13)
    closeBtn.BackgroundColor3 = IconBg
    closeBtn.BackgroundTransparency = 0.5
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = TextDim
    closeBtn.TextSize = 12
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = topBar
    corner(closeBtn, 8)
    stroke(closeBtn, GlassBorder, 1, 0.5)

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 26, 0, 26)
    minBtn.Position = UDim2.new(1, -64, 0.5, -13)
    minBtn.BackgroundColor3 = IconBg
    minBtn.BackgroundTransparency = 0.5
    minBtn.BorderSizePixel = 0
    minBtn.Text = "—"
    minBtn.TextColor3 = TextDim
    minBtn.TextSize = 12
    minBtn.Font = Enum.Font.GothamBold
    minBtn.AutoButtonColor = false
    minBtn.Parent = topBar
    corner(minBtn, 8)
    stroke(minBtn, GlassBorder, 1, 0.5)

    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
            BackgroundColor3 = DangerColor, BackgroundTransparency = 0,
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
            BackgroundColor3 = IconBg, BackgroundTransparency = 0.5,
            TextColor3 = TextDim,
        }):Play()
    end)
    minBtn.MouseEnter:Connect(function()
        TweenService:Create(minBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
            BackgroundColor3 = IconBgHover, BackgroundTransparency = 0,
            TextColor3 = TextBright,
        }):Play()
    end)
    minBtn.MouseLeave:Connect(function()
        TweenService:Create(minBtn, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
            BackgroundColor3 = IconBg, BackgroundTransparency = 0.5,
            TextColor3 = TextDim,
        }):Play()
    end)

    local dragging = false
    local dragStart, startPos

    local function isInTopBar(x, y)
        local abs = topBar.AbsolutePosition
        local size = topBar.AbsoluteSize
        return x >= abs.X and x <= abs.X + size.X and y >= abs.Y and y <= abs.Y + size.Y
    end

    local function isOnBtn(x, y)
        for _, btn in ipairs({minBtn, closeBtn}) do
            local abs = btn.AbsolutePosition
            local size = btn.AbsoluteSize
            if x >= abs.X and x <= abs.X + size.X and y >= abs.Y and y <= abs.Y + size.Y then
                return true
            end
        end
        return false
    end

    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local x, y = input.Position.X, input.Position.Y
        if isInTopBar(x, y) and not isOnBtn(x, y) then
            dragging = true
            dragStart = Vector2.new(x, y)
            startPos = win.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local x, y = input.Position.X, input.Position.Y
        local d = Vector2.new(x, y) - dragStart
        win.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local body = Instance.new("Frame")
    body.Size = UDim2.new(1, 0, 1, -TOPBAR_H)
    body.Position = UDim2.new(0, 0, 0, TOPBAR_H)
    body.BackgroundTransparency = 1
    body.ZIndex = 3
    body.Parent = win

    local side = Instance.new("Frame")
    side.Size = UDim2.new(0, SIDEBAR_W, 1, -20)
    side.Position = UDim2.new(0, 10, 0, 10)
    side.BackgroundColor3 = GlassBg
    side.BackgroundTransparency = 0.25
    side.BorderSizePixel = 0
    side.ZIndex = 4
    side.Parent = body
    corner(side, 12)
    stroke(side, GlassBorder, 1, 0.5)

    local sideInner = Instance.new("Frame")
    sideInner.Size = UDim2.new(1, -2, 1, -2)
    sideInner.Position = UDim2.new(0, 1, 0, 1)
    sideInner.BackgroundColor3 = GlassInner
    sideInner.BackgroundTransparency = 0.7
    sideInner.BorderSizePixel = 0
    sideInner.ZIndex = 0
    sideInner.Parent = side
    corner(sideInner, 11)

    local sideHeader = mkLabel(side, "导航", 10, TextMute, Enum.TextXAlignment.Left, Enum.Font.GothamBold)
    sideHeader.Size = UDim2.new(1, -24, 0, 14)
    sideHeader.Position = UDim2.new(0, 14, 0, 14)

    local tabHolder = Instance.new("ScrollingFrame")
    tabHolder.Size = UDim2.new(1, 0, 1, -34)
    tabHolder.Position = UDim2.new(0, 0, 0, 34)
    tabHolder.BackgroundTransparency = 1
    tabHolder.BorderSizePixel = 0
    tabHolder.ScrollBarThickness = 3
    tabHolder.ScrollBarImageColor3 = GlassBorder
    tabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabHolder.ZIndex = 4
    tabHolder.Parent = side

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabHolder

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -(SIDEBAR_W + 20), 1, -20)
    content.Position = UDim2.new(0, SIDEBAR_W + 20, 0, 10)
    content.BackgroundTransparency = 1
    content.ZIndex = 4
    content.Parent = body

    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(win, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
        task.delay(0.2, function()
            ScreenGui.Enabled = false
            showAuthorPopup(function()
                if config.CloseCallback then
                    pcall(config.CloseCallback)
                end
            end)
        end)
    end)

    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            body.Visible = false
            local curAbs = win.AbsolutePosition
            TweenService:Create(win, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                Size = UDim2.new(0, 240, 0, TOPBAR_H),
                Position = UDim2.new(0, curAbs.X, 0, curAbs.Y)
            }):Play()
            titleLbl.Size = UDim2.new(1, -100, 1, 0)
        else
            local curAbs = win.AbsolutePosition
            TweenService:Create(win, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                Size = UDim2.new(0, WIN_W, 0, WIN_H),
                Position = UDim2.new(0, curAbs.X, 0, curAbs.Y)
            }):Play()
            task.delay(0.15, function() body.Visible = true end)
            titleLbl.Size = UDim2.new(1, -140, 1, 0)
        end
    end)

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)

    local WinAPI = {}
    local tabCount = 0

    function WinAPI:Tab(tabName)
        tabName = tabName or "标签"
        tabCount = tabCount + 1

        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, -20, 0, 40)
        tabBtn.Position = UDim2.new(0, 10, 0, 0)
        tabBtn.BackgroundColor3 = IconBg
        tabBtn.BackgroundTransparency = 1
        tabBtn.BorderSizePixel = 0
        tabBtn.Text = ""
        tabBtn.AutoButtonColor = false
        tabBtn.LayoutOrder = tabCount
        tabBtn.ZIndex = 5
        tabBtn.Parent = tabHolder
        corner(tabBtn, 9)

        local tabIcon = Instance.new("Frame")
        tabIcon.Size = UDim2.new(0, 24, 0, 24)
        tabIcon.Position = UDim2.new(0, 8, 0.5, -12)
        tabIcon.BackgroundColor3 = IconBg
        tabIcon.BorderSizePixel = 0
        tabIcon.ZIndex = 5
        tabIcon.Parent = tabBtn
        corner(tabIcon, 7)

        local tabIconText = mkLabel(tabIcon, string.sub(tabName, 1, 1), 12, TextDim, Enum.TextXAlignment.Center, Enum.Font.GothamBold)
        tabIconText.Size = UDim2.new(1, 0, 1, 0)
        tabIconText.BackgroundTransparency = 1
        tabIconText.ZIndex = 6

        local tabLbl = mkLabel(tabBtn, tabName, 13, TextDim, Enum.TextXAlignment.Left, Enum.Font.Gotham)
        tabLbl.Size = UDim2.new(1, -50, 1, 0)
        tabLbl.Position = UDim2.new(0, 40, 0, 0)
        tabLbl.ZIndex = 5
        tabLbl.Name = "Title"

        local container = Instance.new("ScrollingFrame")
        container.Size = UDim2.new(1, 0, 1, 0)
        container.BackgroundTransparency = 1
        container.BorderSizePixel = 0
        container.ScrollBarThickness = 3
        container.ScrollBarImageColor3 = GlassBorder
        container.CanvasSize = UDim2.new(0, 0, 0, 0)
        container.AutomaticCanvasSize = Enum.AutomaticSize.Y
        container.Visible = false
        container.Name = "Container"
        container.ZIndex = 4
        container.Parent = content

        local cl = Instance.new("UIListLayout")
        cl.SortOrder = Enum.SortOrder.LayoutOrder
        cl.Padding = UDim.new(0, 7)
        cl.Parent = container

        if tabCount == 1 then
            container.Visible = true
            tabBtn.BackgroundColor3 = IconBg
            tabBtn.BackgroundTransparency = 0
            tabLbl.TextColor3 = TextBright
            tabIcon.BackgroundColor3 = AccentColor
            tabIconText.TextColor3 = Color3.fromRGB(40, 40, 48)
        end

        tabBtn.MouseEnter:Connect(function()
            if container.Visible then return end
            TweenService:Create(tabBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {
                BackgroundTransparency = 0.5, BackgroundColor3 = IconBg
            }):Play()
            TweenService:Create(tabLbl, TweenInfo.new(0.15), {TextColor3 = TextNormal}):Play()
        end)
        tabBtn.MouseLeave:Connect(function()
            if container.Visible then return end
            TweenService:Create(tabBtn, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                BackgroundTransparency = 1
            }):Play()
            TweenService:Create(tabLbl, TweenInfo.new(0.18), {TextColor3 = TextDim}):Play()
        end)

        tabBtn.MouseButton1Click:Connect(function()
            for _, t in ipairs(tabHolder:GetChildren()) do
                if t:IsA("TextButton") then
                    TweenService:Create(t, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(t.Title, TweenInfo.new(0.2), {TextColor3 = TextDim}):Play()
                    local icon = t:FindFirstChildOfClass("Frame")
                    if icon then
                        TweenService:Create(icon, TweenInfo.new(0.2), {BackgroundColor3 = IconBg}):Play()
                        local iconText = icon:FindFirstChildOfClass("TextLabel")
                        if iconText then TweenService:Create(iconText, TweenInfo.new(0.2), {TextColor3 = TextDim}):Play() end
                    end
                end
            end
            for _, c in ipairs(content:GetChildren()) do
                if c.Name == "Container" then
                    c.Visible = false
                end
            end
            tabBtn.BackgroundColor3 = IconBg
            tabBtn.BackgroundTransparency = 0
            tabLbl.TextColor3 = TextBright
            tabIcon.BackgroundColor3 = AccentColor
            tabIconText.TextColor3 = Color3.fromRGB(40, 40, 48)
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

function Mitea:Dock(config)
    config = config or {}
    local items = config.Items or {}
    local position = config.Position or "Bottom"

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Mitea_Dock_" .. tostring(math.random(1000, 9999))
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mounted = false
    pcall(function()
        ScreenGui.Parent = getMount()
        mounted = true
    end)
    if not mounted or not ScreenGui.Parent then
        pcall(function()
            ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end)
    end

    local dockW = #items * (ICON_SIZE + ICON_SPACING) - ICON_SPACING + DOCK_PADDING * 2
    local dockH = ICON_SIZE + DOCK_PADDING * 2

    local dock = Instance.new("Frame")
    dock.Name = "Dock"
    dock.Size = UDim2.new(0, dockW, 0, dockH)
    dock.BackgroundColor3 = GlassBg
    dock.BackgroundTransparency = 0.15
    dock.BorderSizePixel = 0
    dock.Parent = ScreenGui
    corner(dock, 18)
    stroke(dock, GlassBorder, 1, 0.4)

    local dockInner = Instance.new("Frame")
    dockInner.Size = UDim2.new(1, -2, 1, -2)
    dockInner.Position = UDim2.new(0, 1, 0, 1)
    dockInner.BackgroundColor3 = GlassInner
    dockInner.BackgroundTransparency = 0.6
    dockInner.BorderSizePixel = 0
    dockInner.ZIndex = 0
    dockInner.Parent = dock
    corner(dockInner, 17)

    local topLine = Instance.new("Frame")
    topLine.Size = UDim2.new(1, -16, 0, 1)
    topLine.Position = UDim2.new(0, 8, 0, 0)
    topLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    topLine.BackgroundTransparency = 0.85
    topLine.BorderSizePixel = 0
    topLine.ZIndex = 5
    topLine.Parent = dock

    local function updatePosition()
        if position == "Top" then
            dock.Position = UDim2.new(0.5, -dockW / 2, 0, DOCK_BOTTOM_GAP)
        else
            dock.Position = UDim2.new(0.5, -dockW / 2, 1, -(dockH + DOCK_BOTTOM_GAP))
        end
    end
    updatePosition()

    local originalPos = dock.Position
    local startY
    if position == "Top" then
        startY = originalPos.Y.Offset - 40
    else
        startY = originalPos.Y.Offset + 40
    end
    dock.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, originalPos.Y.Scale, startY)
    dock.BackgroundTransparency = 1
    dockInner.BackgroundTransparency = 1

    TweenService:Create(dock, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = originalPos,
        BackgroundTransparency = 0.15,
    }):Play()
    TweenService:Create(dockInner, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.6,
    }):Play()

    local icons = {}
    local hoveredIndex = nil

    for i, item in ipairs(items) do
        local holder = Instance.new("Frame")
        holder.Name = "Holder_" .. i
        holder.Size = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
        holder.BackgroundTransparency = 1
        holder.ZIndex = 3
        holder.Parent = dock
        holder.AnchorPoint = Vector2.new(0.5, 1)
        holder.Position = UDim2.new(0,
            DOCK_PADDING + (i - 1) * (ICON_SIZE + ICON_SPACING) + ICON_SIZE / 2,
            1, -DOCK_PADDING)

        local iconBg = Instance.new("Frame")
        iconBg.Name = "IconBg"
        iconBg.Size = UDim2.new(1, 0, 1, 0)
        iconBg.BackgroundColor3 = IconBg
        iconBg.BorderSizePixel = 0
        iconBg.ZIndex = 3
        iconBg.Parent = holder
        corner(iconBg, 12)
        stroke(iconBg, Color3.fromRGB(255, 255, 255), 1, 0.9)

        local iconImg = Instance.new("ImageLabel")
        iconImg.Size = UDim2.new(0.55, 0, 0.55, 0)
        iconImg.Position = UDim2.new(0.5, 0, 0.5, 0)
        iconImg.AnchorPoint = Vector2.new(0.5, 0.5)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = item.Icon or ""
        iconImg.ImageColor3 = Color3.fromRGB(230, 230, 240)
        iconImg.ZIndex = 4
        iconImg.Parent = iconBg

        local dot = Instance.new("Frame")
        dot.Name = "Dot"
        dot.Size = UDim2.new(0, 4, 0, 4)
        dot.Position = UDim2.new(0.5, -2, 1, 4)
        dot.BackgroundColor3 = Color3.fromRGB(220, 220, 228)
        dot.BackgroundTransparency = 1
        dot.BorderSizePixel = 0
        dot.ZIndex = 4
        dot.Parent = holder
        corner(dot, 2)

        local label = Instance.new("Frame")
        label.Name = "Label"
        label.Size = UDim2.new(0, 0, 0, 22)
        label.Position = UDim2.new(0.5, 0, 0, -8)
        label.AnchorPoint = Vector2.new(0.5, 1)
        label.BackgroundColor3 = LabelBg
        label.BackgroundTransparency = 1
        label.BorderSizePixel = 0
        label.ZIndex = 10
        label.ClipsDescendants = true
        label.Parent = dock
        corner(label, 6)

        local labelText = mkLabel(label, item.Name or "", 12, Color3.fromRGB(235, 235, 240), Enum.TextXAlignment.Center, Enum.Font.GothamBold)
        labelText.Size = UDim2.new(1, 0, 1, 0)
        labelText.BackgroundTransparency = 1
        labelText.ZIndex = 11

        local click = Instance.new("TextButton")
        click.Name = "Click"
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        click.ZIndex = 5
        click.Parent = iconBg

        icons[i] = {
            holder = holder,
            iconBg = iconBg,
            iconImg = iconImg,
            dot = dot,
            label = label,
            labelText = labelText,
            click = click,
            item = item,
            baseX = DOCK_PADDING + (i - 1) * (ICON_SIZE + ICON_SPACING) + ICON_SIZE / 2,
            scale = 1,
        }

        click.MouseButton1Click:Connect(function()
            local s = icons[i]
            TweenService:Create(s.iconBg, TweenInfo.new(0.08, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0.9, 0, 0.9, 0),
                Position = UDim2.new(0.05, 0, 0.05, 0),
            }):Play()
            task.delay(0.08, function()
                TweenService:Create(s.iconBg, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                }):Play()
            end)
            if s.item.Callback then
                task.spawn(function()
                    pcall(s.item.Callback)
                end)
            end
        end)
    end

    local magnetConn = RunService.RenderStepped:Connect(function(dt)
        local pos = UserInputService:GetMouseLocation()
        local mouseX = pos.X
        local mouseY = pos.Y

        local dockAbsX = dock.AbsolutePosition.X
        local dockAbsY = dock.AbsolutePosition.Y
        local dockAbsW = dock.AbsoluteSize.X
        local dockAbsH = dock.AbsoluteSize.Y

        local inDockZone = mouseY >= dockAbsY - 40 and mouseY <= dockAbsY + dockAbsH + 10
            and mouseX >= dockAbsX - 40 and mouseX <= dockAbsX + dockAbsW + 40

        for i, s in ipairs(icons) do
            local iconCenterX = dockAbsX + s.baseX * (dockAbsW / dockW)
            local dx = math.abs(mouseX - iconCenterX)

            local targetScale = 1
            if inDockZone and dx < MAGNET_RANGE then
                local t = 1 - (dx / MAGNET_RANGE)
                t = t * t * (3 - 2 * t)
                targetScale = 1 + (ICON_MAX_SCALE - 1) * t
            end

            s.scale = s.scale + (targetScale - s.scale) * math.min(dt * 18, 1)

            local size = ICON_SIZE * s.scale
            s.holder.Size = UDim2.new(0, size, 0, size)
            s.holder.Position = UDim2.new(0,
                DOCK_PADDING + (i - 1) * (ICON_SIZE + ICON_SPACING) + ICON_SIZE / 2
                    - (size - ICON_SIZE) / 2,
                1, -DOCK_PADDING)
        end

        local bestIdx = nil
        local bestDx = math.huge
        for i, s in ipairs(icons) do
            local iconCenterX = dockAbsX + s.baseX * (dockAbsW / dockW)
            local dx = math.abs(mouseX - iconCenterX)
            if inDockZone and dx < bestDx and dx < MAGNET_RANGE then
                bestDx = dx
                bestIdx = i
            end
        end

        if bestIdx ~= hoveredIndex then
            hoveredIndex = bestIdx
            for i, s in ipairs(icons) do
                if i == hoveredIndex then
                    s.labelText.Text = s.item.Name or ""
                    local textW = #(s.item.Name or "标签") * 8 + 20
                    s.label.Position = UDim2.new(0,
                        DOCK_PADDING + (i - 1) * (ICON_SIZE + ICON_SPACING) + ICON_SIZE / 2,
                        0, -8)
                    TweenService:Create(s.label, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, textW, 0, 22),
                        BackgroundTransparency = 0.05,
                        Position = UDim2.new(0.5, 0, 0, -8),
                    }):Play()
                    TweenService:Create(s.labelText, TweenInfo.new(0.15), {TextTransparency = 0}):Play()
                else
                    TweenService:Create(s.label, TweenInfo.new(0.15), {
                        Size = UDim2.new(0, 0, 0, 22),
                        BackgroundTransparency = 1,
                    }):Play()
                    TweenService:Create(s.labelText, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
                end
            end
        end

        for i, s in ipairs(icons) do
            local iconCenterX = dockAbsX + s.baseX * (dockAbsW / dockW)
            local dx = math.abs(mouseX - iconCenterX)
            local showDot = inDockZone and dx < MAGNET_RANGE * 1.2
            local targetTrans = showDot and 0.35 or 1
            s.dot.BackgroundTransparency = s.dot.BackgroundTransparency
                + (targetTrans - s.dot.BackgroundTransparency) * math.min(dt * 12, 1)

            local t = inDockZone and math.clamp(1 - dx / MAGNET_RANGE, 0, 1) or 0
            local targetColor = IconBg:Lerp(IconBgHover, t)
            s.iconBg.BackgroundColor3 = s.iconBg.BackgroundColor3:Lerp(targetColor, math.min(dt * 14, 1))
        end
    end)

    ScreenGui.Destroying:Connect(function()
        if magnetConn then magnetConn:Disconnect() end
    end)

    local API = {}
    function API:Show() ScreenGui.Enabled = true end
    function API:Hide() ScreenGui.Enabled = false end
    function API:Toggle() ScreenGui.Enabled = not ScreenGui.Enabled end
    function API:SetItemDot(index, visible)
        local s = icons[index]
        if s then
            TweenService:Create(s.dot, TweenInfo.new(0.2), {
                BackgroundTransparency = visible and 0 or 1
            }):Play()
        end
    end
    function API:Destroy()
        if magnetConn then magnetConn:Disconnect() end
        ScreenGui:Destroy()
    end
    return API
end

local genv = getgenv and getgenv() or _G
if genv.__MiteaInstance then
    return genv.__MiteaInstance
end
genv.__MiteaInstance = Mitea

return Mitea