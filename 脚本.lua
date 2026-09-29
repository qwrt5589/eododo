repeat task.wait() until game:IsLoaded()

local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
    __index = function(t, k)
        return game.GetService(game, k)
    end
})

local mouse = services.Players.LocalPlayer:GetMouse()
local TS = services.TweenService
local UIS = services.UserInputService

--// 工具函数
local function Tween(obj, t, data)
    TS:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
    return true
end

local function Ripple(obj)
    task.spawn(function()
        if not obj.ClipsDescendants then
            obj.ClipsDescendants = true
        end
        
        local r = Instance.new("ImageLabel")
        r.Name = "Ripple"
        r.Parent = obj
        r.BackgroundTransparency = 1
        r.ZIndex = 8
        r.Image = "rbxassetid://111477850857548"
        r.ImageTransparency = 0.75
        r.ScaleType = Enum.ScaleType.Fit
        r.ImageColor3 = Color3.fromRGB(180, 120, 255)
        r.Position = UDim2.new(
            (mouse.X - r.AbsolutePosition.X) / obj.AbsoluteSize.X, 0,
            (mouse.Y - r.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0
        )
        
        Tween(r, {0.35, 'Quart', 'Out'}, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0)
        })
        task.wait(0.18)
        Tween(r, {0.35, 'Linear', 'In'}, {ImageTransparency = 1})
        task.wait(0.4)
        r:Destroy()
    end)
end

--// Tab 切换
local switchingTabs = false
function switchTab(new)
    if switchingTabs then return end
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        TS:Create(new[1], TweenInfo.new(0.15), {ImageTransparency = 0}):Play()
        TS:Create(new[1].TabText, TweenInfo.new(0.15), {TextTransparency = 0}):Play()
        return
    end
    if old[1] == new[1] then return end
    
    switchingTabs = true
    library.currentTab = new

    TS:Create(old[1], TweenInfo.new(0.15), {ImageTransparency = 0.35}):Play()
    TS:Create(new[1], TweenInfo.new(0.15), {ImageTransparency = 0}):Play()
    TS:Create(old[1].TabText, TweenInfo.new(0.15), {TextTransparency = 0.35}):Play()
    TS:Create(new[1].TabText, TweenInfo.new(0.15), {TextTransparency = 0}):Play()

    old[2].Visible = false
    new[2].Visible = true

    task.wait(0.15)
    switchingTabs = false
end

--// 拖拽
local function drag(frame, hold)
    if not hold then hold = frame end
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    hold.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    hold.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

--// 创建窗口
function library.new(_, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then v:Destroy() end
    end

    local ALTransparency = 0.55
    local ALcolor = Color3.fromRGB(0, 255, 127)

    local MainColor     = Color3.fromRGB(20, 22, 28)
    local Background    = Color3.fromRGB(20, 22, 28)
    local zyColor       = Color3.fromRGB(28, 30, 38)
    local beijingColor  = Color3.fromRGB(18, 20, 26)

    if theme == 'light' then
        MainColor    = Color3.fromRGB(235, 235, 240)
        Background   = Color3.fromRGB(245, 245, 250)
        zyColor      = Color3.fromRGB(228, 230, 238)
        beijingColor = Color3.fromRGB(215, 218, 228)
        ALcolor      = Color3.fromRGB(60, 80, 160)
    end

    -- ============ 屏幕 GUI ============
    local dogent = Instance.new("ScreenGui")
    dogent.Name = "frosty"
    dogent.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    dogent.ResetOnSpawn = false
    dogent.IgnoreGuiInset = true
    if syn and syn.protect_gui then syn.protect_gui(dogent) end
    dogent.Parent = services.CoreGui

    function UiDestroy() dogent:Destroy() end
    function ToggleUILib()
        if not ToggleUI then
            dogent.Enabled = false
            ToggleUI = true
        else
            ToggleUI = false
            dogent.Enabled = true
        end
    end

    -- ============ 主窗口 ============
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = dogent
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Background
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 572, 0, 353)
    Main.ZIndex = 1
    Main.Active = true
    Main.Draggable = true
    Main.ClipsDescendants = false

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    -- 外层发光描边（分层叠出高级感）
    local outerGlow = Instance.new("UIStroke")
    outerGlow.Thickness = 1.5
    outerGlow.Color = Color3.fromRGB(180, 120, 255)
    outerGlow.Transparency = 0.35
    outerGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    outerGlow.Parent = Main

    local outerGlow2 = Instance.new("UIStroke")
    outerGlow2.Thickness = 4
    outerGlow2.Color = Color3.fromRGB(180, 120, 255)
    outerGlow2.Transparency = 0.88
    outerGlow2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    outerGlow2.Parent = Main

    -- 背景渐变（暗紫→深蓝，带极缓旋转）
    local bgGrad = Instance.new("UIGradient")
    bgGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(32, 26, 48)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 22, 32)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(24, 20, 40))
    }
    bgGrad.Rotation = 45
    bgGrad.Parent = Main

    task.spawn(function()
        while Main.Parent do
            local info = TweenInfo.new(14, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
            TS:Create(bgGrad, info, {Rotation = 225}):Play()
            task.wait(14)
        end
    end)

    -- 阴影
    local DropShadowHolder = Instance.new("Frame")
    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = Main
    DropShadowHolder.BackgroundTransparency = 1
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.ZIndex = 0

    local DropShadow = Instance.new("ImageLabel")
    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 30, 1, 30)
    DropShadow.Image = "rbxassetid://88218863287921"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.5
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- ============ 彩虹渐变（用户保留） ============
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))
    }

    local rainbowTween = TS:Create(
        UIGradient,
        TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1),
        {Rotation = 360}
    )
    rainbowTween:Play()

    function toggleui()
        TS:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 572, 0, 0)
        }):Play()
    end

    -- ============ 侧边栏区域 ============
    local TabMain = Instance.new("Frame")
    TabMain.Name = "TabMain"
    TabMain.Parent = Main
    TabMain.BackgroundTransparency = 1
    TabMain.Position = UDim2.new(0.217, 0, 0, 3)
    TabMain.Size = UDim2.new(0, 448, 0, 347)

    local SB = Instance.new("Frame")
    SB.Name = "SB"
    SB.Parent = Main
    SB.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
    SB.BorderSizePixel = 0
    SB.Size = UDim2.new(0, 118, 0, 353)
    SB.ZIndex = 2

    local SBC = Instance.new("UICorner")
    SBC.CornerRadius = UDim.new(0, 10)
    SBC.Parent = SB

    local Side = Instance.new("Frame")
    Side.Name = "Side"
    Side.Parent = SB
    Side.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Position = UDim2.new(0, 0, 0, 0)
    Side.Size = UDim2.new(1, 0, 1, 0)

    local SideG = Instance.new("UIGradient")
    SideG.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 26, 44)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(18, 20, 28))
    }
    SideG.Rotation = 90
    SideG.Parent = Side

    -- 侧栏右侧细亮线（高端感）
    local SideDivider = Instance.new("Frame")
    SideDivider.Name = "SideDivider"
    SideDivider.Parent = SB
    SideDivider.AnchorPoint = Vector2.new(1, 0)
    SideDivider.Position = UDim2.new(1, 0, 0, 0)
    SideDivider.Size = UDim2.new(0, 1, 1, 0)
    SideDivider.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
    SideDivider.BackgroundTransparency = 0.75
    SideDivider.BorderSizePixel = 0
    SideDivider.ZIndex = 3

    -- 侧栏滚动容器
    local TabBtns = Instance.new("ScrollingFrame")
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundTransparency = 1
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.096, 0)
    TabBtns.Size = UDim2.new(1, 0, 0.87, 0)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 0

    local TabBtnsL = Instance.new("UIListLayout")
    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 4)

    local TabBtnsP = Instance.new("UIPadding")
    TabBtnsP.Parent = TabBtns
    TabBtnsP.PaddingTop = UDim.new(0, 12)
    TabBtnsP.PaddingLeft = UDim.new(0, 8)
    TabBtnsP.PaddingRight = UDim.new(0, 8)

    -- 标题
    local ScriptTitle = Instance.new("TextLabel")
    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundTransparency = 1
    ScriptTitle.Position = UDim2.new(0, 12, 0, 12)
    ScriptTitle.Size = UDim2.new(1, -24, 0, 20)
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.Text = name or "Frosty"
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 15
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    ScriptTitle.ZIndex = 3

    local ScriptTitleGrad = Instance.new("UIGradient")
    ScriptTitleGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(200, 160, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(150, 200, 255))
    }
    ScriptTitleGrad.Rotation = 0
    ScriptTitleGrad.Parent = ScriptTitle

    task.spawn(function()
        while ScriptTitle.Parent do
            local info = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
            TS:Create(ScriptTitleGrad, info, {Offset = Vector2.new(1, 0)}):Play()
            task.wait(3)
        end
    end)

    -- 标题下的小装饰线
    local TitleUnderline = Instance.new("Frame")
    TitleUnderline.Name = "TitleUnderline"
    TitleUnderline.Parent = Side
    TitleUnderline.Position = UDim2.new(0, 12, 0, 34)
    TitleUnderline.Size = UDim2.new(0, 30, 0, 2)
    TitleUnderline.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
    TitleUnderline.BorderSizePixel = 0
    TitleUnderline.ZIndex = 3

    local UnderlineGrad = Instance.new("UIGradient")
    UnderlineGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(180, 120, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 160, 255))
    }
    UnderlineGrad.Parent = TitleUnderline

    -- 发光
    task.spawn(function()
        while TitleUnderline.Parent do
            local info = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
            local t = TS:Create(TitleUnderline, info, {Size = UDim2.new(0, 60, 0, 2)})
            t:Play()
            task.wait(2)
            TS:Create(TitleUnderline, info, {Size = UDim2.new(0, 30, 0, 2)}):Play()
            task.wait(2)
        end
    end)

    -- ============ 开关按钮 ============
    local Frame = Instance.new("Frame")
    Frame.Name = "OpenFrame"
    Frame.Parent = dogent
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(0.008, 0, 0.311, 0)
    Frame.Size = UDim2.new(0, 50, 0, 50)

    local Open = Instance.new("ImageButton")
    Open.Name = "Open"
    Open.Parent = Frame
    Open.BackgroundColor3 = Color3.fromRGB(28, 30, 38)
    Open.BackgroundTransparency = 0.15
    Open.BorderSizePixel = 0
    Open.Size = UDim2.new(1, 0, 1, 0)
    Open.Active = true
    Open.Draggable = true
    Open.Image = "rbxassetid://111477850857548"
    Open.ImageColor3 = Color3.fromRGB(200, 160, 255)

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = Open

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Thickness = 1.5
    OpenStroke.Color = Color3.fromRGB(180, 120, 255)
    OpenStroke.Transparency = 0.4
    OpenStroke.Parent = Open

    -- 外发光
    local OpenGlow = Instance.new("UIStroke")
    OpenGlow.Thickness = 5
    OpenGlow.Color = Color3.fromRGB(180, 120, 255)
    OpenGlow.Transparency = 0.85
    OpenGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    OpenGlow.Parent = Open

    task.spawn(function()
        while Open.Parent do
            local info = TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
            TS:Create(OpenGlow, info, {Transparency = 0.6, Thickness = 8}):Play()
            task.wait(1.6)
            TS:Create(OpenGlow, info, {Transparency = 0.85, Thickness = 5}):Play()
            task.wait(1.6)
        end
    end)

    Open.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
        Open.Image = Main.Visible and "rbxassetid://111477850857548" or "rbxassetid://91545768718105"
        Open.ImageColor3 = Main.Visible and Color3.fromRGB(200, 160, 255) or Color3.fromRGB(255, 160, 160)
    end)

    -- ============ Window 构造 ============
    local window = {}

    function window.Tab(_, name, icon)
        -- Tab 按钮（背景）
        local TabItem = Instance.new("Frame")
        TabItem.Name = "TabItem"
        TabItem.Parent = TabBtns
        TabItem.BackgroundColor3 = Color3.fromRGB(35, 32, 50)
        TabItem.BackgroundTransparency = 1
        TabItem.BorderSizePixel = 0
        TabItem.Size = UDim2.new(1, 0, 0, 30)

        local TabItemCorner = Instance.new("UICorner")
        TabItemCorner.CornerRadius = UDim.new(0, 6)
        TabItemCorner.Parent = TabItem

        local TabIco = Instance.new("ImageLabel")
        TabIco.Name = "TabIco"
        TabIco.Parent = TabItem
        TabIco.BackgroundTransparency = 1
        TabIco.BorderSizePixel = 0
        TabIco.Position = UDim2.new(0, 8, 0, 3)
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = icon and ("rbxassetid://" .. icon) or "rbxassetid://128437395815901"
        TabIco.ImageTransparency = 0.35
        TabIco.ImageColor3 = ALcolor

        local TabText = Instance.new("TextLabel")
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundTransparency = 1
        TabText.Position = UDim2.new(1.4, 0, 0, 0)
        TabText.Size = UDim2.new(0, 80, 0, 24)
        TabText.Font = Enum.Font.GothamMedium
        TabText.Text = name
        TabText.TextColor3 = ALcolor
        TabText.TextSize = 13
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.35

        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabItem
        TabBtn.BackgroundTransparency = 1
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(1, 0, 1, 0)
        TabBtn.AutoButtonColor = false
        TabBtn.Text = ""

        -- 高亮底
        local TabHighlight = Instance.new("Frame")
        TabHighlight.Name = "TabHighlight"
        TabHighlight.Parent = TabItem
        TabHighlight.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
        TabHighlight.BackgroundTransparency = 1
        TabHighlight.BorderSizePixel = 0
        TabHighlight.Size = UDim2.new(0, 2, 0.6, 0)
        TabHighlight.Position = UDim2.new(0, 0, 0.2, 0)
        TabHighlight.ZIndex = 3

        local TabHighlightCorner = Instance.new("UICorner")
        TabHighlightCorner.CornerRadius = UDim.new(1, 0)
        TabHighlightCorner.Parent = TabHighlight

        TabItem.MouseEnter:Connect(function()
            if library.currentTab and library.currentTab[1] == TabIco then return end
            TS:Create(TabItem, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
        end)
        TabItem.MouseLeave:Connect(function()
            if library.currentTab and library.currentTab[1] == TabIco then return end
            TS:Create(TabItem, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        end)

        -- 页面滚动容器
        local Tab = Instance.new("ScrollingFrame")
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0, 8, 0, 8)
        Tab.Size = UDim2.new(1, -16, 1, -16)
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = Color3.fromRGB(180, 120, 255)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.Visible = false

        local TabL = Instance.new("UIListLayout")
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 6)

        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            task.spawn(function()
                Ripple(TabBtn)
            end)
            -- 更新高亮条
            for _, item in ipairs(TabBtns:GetChildren()) do
                if item:IsA("Frame") and item:FindFirstChild("TabHighlight") then
                    local isThis = (item == TabItem)
                    TS:Create(item.TabHighlight, TweenInfo.new(0.2), {
                        BackgroundTransparency = isThis and 0.2 or 1
                    }):Play()
                    TS:Create(item, TweenInfo.new(0.2), {
                        BackgroundTransparency = isThis and 0.75 or 1
                    }):Play()
                end
            end
            switchTab({TabIco, Tab})
        end)

        if library.currentTab == nil then
            TabHighlight.BackgroundTransparency = 0.2
            TabItem.BackgroundTransparency = 0.75
            switchTab({TabIco, Tab})
        end

        -- ============ Tab 内容构造 ============
        local tab = {}

        function tab.section(_, name, TabVal)
            local Section = Instance.new("Frame")
            local SectionText = Instance.new("TextLabel")
            local SectionOpen = Instance.new("ImageLabel")
            local SectionOpened = Instance.new("ImageLabel")
            local SectionToggle = Instance.new("ImageButton")
            local Objs = Instance.new("Frame")
            local ObjsL = Instance.new("UIListLayout")
            local SectionStroke = Instance.new("UIStroke")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = zyColor
            Section.BackgroundTransparency = 0.15
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(1, -8, 0, 36)
            Section.AutomaticSize = Enum.AutomaticSize.None

            local SectionC = Instance.new("UICorner")
            SectionC.CornerRadius = UDim.new(0, 8)
            SectionC.Parent = Section

            SectionStroke.Thickness = 1
            SectionStroke.Color = Color3.fromRGB(80, 70, 120)
            SectionStroke.Transparency = 0.7
            SectionStroke.Parent = Section

            -- 背景渐变
            local SectionGrad = Instance.new("UIGradient")
            SectionGrad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(45, 38, 68)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 40))
            }
            SectionGrad.Rotation = 90
            SectionGrad.Parent = Section

            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundTransparency = 1
            SectionText.Position = UDim2.new(0, 42, 0, 0)
            SectionText.Size = UDim2.new(1, -50, 0, 36)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(220, 220, 240)
            SectionText.TextSize = 14
            SectionText.TextXAlignment = Enum.TextXAlignment.Left

            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = Section
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, 12, 0, 5)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = "rbxassetid://128437395815901"
            SectionOpen.ImageColor3 = Color3.fromRGB(180, 120, 255)

            SectionOpened.Name = "SectionOpened"
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(1, 0, 1, 0)
            SectionOpened.Image = "rbxassetid://111477850857548"
            SectionOpened.ImageColor3 = Color3.fromRGB(180, 120, 255)
            SectionOpened.ImageTransparency = 1

            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = SectionOpen
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.BorderSizePixel = 0
            SectionToggle.Size = UDim2.new(1, 0, 1, 0)

            Objs.Name = "Objs"
            Objs.Parent = Section
            Objs.BackgroundTransparency = 1
            Objs.BorderSizePixel = 0
            Objs.Position = UDim2.new(0, 10, 0, 36)
            Objs.Size = UDim2.new(1, -20, 0, 0)

            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 6)

            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(1, -8, 0, open and (36 + ObjsL.AbsoluteContentSize.Y + 10) or 36)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end

            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                TS:Create(Section, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, -8, 0, open and (36 + ObjsL.AbsoluteContentSize.Y + 10) or 36)
                }):Play()
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
                task.wait(0.25)
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
            end)

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not open then return end
                Section.Size = UDim2.new(1, -8, 0, 36 + ObjsL.AbsoluteContentSize.Y + 10)
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
            end)

            -- ============ Section 内容 ============
            local section = {}

            function section.Button(_, text, callback)
                local callback = callback or function() end

                local BtnModule = Instance.new("Frame")
                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundTransparency = 1
                BtnModule.BorderSizePixel = 0
                BtnModule.Size = UDim2.new(1, 0, 0, 34)

                local Btn = Instance.new("TextButton")
                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = Color3.fromRGB(45, 42, 62)
                Btn.BackgroundTransparency = 0.15
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(1, 0, 1, 0)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamMedium
                Btn.Text = "   " .. text
                Btn.TextColor3 = Color3.fromRGB(225, 225, 240)
                Btn.TextSize = 14
                Btn.TextXAlignment = Enum.TextXAlignment.Left

                local BtnC = Instance.new("UICorner")
                BtnC.CornerRadius = UDim.new(0, 6)
                BtnC.Parent = Btn

                local BtnStroke = Instance.new("UIStroke")
                BtnStroke.Thickness = 1
                BtnStroke.Color = Color3.fromRGB(90, 80, 130)
                BtnStroke.Transparency = 0.7
                BtnStroke.Parent = Btn

                local BtnGrad = Instance.new("UIGradient")
                BtnGrad.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(52, 48, 72)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(38, 36, 54))
                }
                BtnGrad.Rotation = 90
                BtnGrad.Parent = Btn

                Btn.MouseEnter:Connect(function()
                    TS:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
                    TS:Create(BtnStroke, TweenInfo.new(0.15), {
                        Color = Color3.fromRGB(180, 120, 255),
                        Transparency = 0.3
                    }):Play()
                end)
                Btn.MouseLeave:Connect(function()
                    TS:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
                    TS:Create(BtnStroke, TweenInfo.new(0.15), {
                        Color = Color3.fromRGB(90, 80, 130),
                        Transparency = 0.7
                    }):Play()
                end)

                Btn.MouseButton1Click:Connect(function()
                    task.spawn(function() Ripple(Btn) end)
                    task.spawn(callback)
                end)
            end

            function section.Label(_, text)
                local LabelModule = Instance.new("Frame")
                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundTransparency = 1
                LabelModule.BorderSizePixel = 0
                LabelModule.Size = UDim2.new(1, 0, 0, 22)

                local TextLabel = Instance.new("TextLabel")
                TextLabel.Name = "TextLabel"
                TextLabel.Parent = LabelModule
                TextLabel.BackgroundTransparency = 1
                TextLabel.Size = UDim2.new(1, 0, 1, 0)
                TextLabel.Font = Enum.Font.Gotham
                TextLabel.Text = text
                TextLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
                TextLabel.TextSize = 13
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left

                return TextLabel
            end

            function section.Toggle(_, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = enabled

                local ToggleModule = Instance.new("Frame")
                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundTransparency = 1
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Size = UDim2.new(1, 0, 0, 34)

                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 42, 62)
                ToggleBtn.BackgroundTransparency = 0.15
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamMedium
                ToggleBtn.Text = "   " .. text
                ToggleBtn.TextColor3 = Color3.fromRGB(225, 225, 240)
                ToggleBtn.TextSize = 14
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

                local ToggleBtnC = Instance.new("UICorner")
                ToggleBtnC.CornerRadius = UDim.new(0, 6)
                ToggleBtnC.Parent = ToggleBtn

                local ToggleBtnStroke = Instance.new("UIStroke")
                ToggleBtnStroke.Thickness = 1
                ToggleBtnStroke.Color = Color3.fromRGB(90, 80, 130)
                ToggleBtnStroke.Transparency = 0.7
                ToggleBtnStroke.Parent = ToggleBtn

                -- 开关背景
                local ToggleDisable = Instance.new("Frame")
                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(1, -50, 0.5, -11)
                ToggleDisable.Size = UDim2.new(0, 38, 0, 22)

                local ToggleDisableC = Instance.new("UICorner")
                ToggleDisableC.CornerRadius = UDim.new(1, 0)
                ToggleDisableC.Parent = ToggleDisable

                local ToggleDisableStroke = Instance.new("UIStroke")
                ToggleDisableStroke.Thickness = 1
                ToggleDisableStroke.Color = Color3.fromRGB(80, 80, 110)
                ToggleDisableStroke.Transparency = 0.6
                ToggleDisableStroke.Parent = ToggleDisable

                -- 滑块
                local ToggleSwitch = Instance.new("Frame")
                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
                ToggleSwitch.Position = UDim2.new(0, 2, 0.5, -8)
                ToggleSwitch.Size = UDim2.new(0, 16, 0, 16)

                local ToggleSwitchC = Instance.new("UICorner")
                ToggleSwitchC.CornerRadius = UDim.new(1, 0)
                ToggleSwitchC.Parent = ToggleSwitch

                local funcs = {
                    SetState = function(self, state)
                        if state == nil then state = not library.flags[flag] end
                        if library.flags[flag] == state then return end
                        TS:Create(ToggleSwitch, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Position = UDim2.new(state and 1 or 0, state and -18 or 2, 0.5, -8),
                            BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 220)
                        }):Play()
                        TS:Create(ToggleDisable, TweenInfo.new(0.2), {
                            BackgroundColor3 = state and Color3.fromRGB(180, 120, 255) or Color3.fromRGB(30, 30, 42),
                            BackgroundTransparency = 0
                        }):Play()
                        TS:Create(ToggleDisableStroke, TweenInfo.new(0.2), {
                            Color = state and Color3.fromRGB(220, 180, 255) or Color3.fromRGB(80, 80, 110),
                            Transparency = state and 0 or 0.6
                        }):Play()
                        library.flags[flag] = state
                        callback(state)
                    end,
                    Module = ToggleModule
                }

                if enabled ~= false then
                    funcs:SetState(true)
                end

                ToggleBtn.MouseButton1Click:Connect(function()
                    funcs:SetState()
                end)

                return funcs
            end

            function section.Keybind(_, text, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(default, "No default key provided")

                local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
                local banned = {
                    Return = true, Space = true, Tab = true, Backquote = true,
                    CapsLock = true, Escape = true, Unknown = true
                }
                local shortNames = {
                    RightControl = 'Right Ctrl', LeftControl = 'Left Ctrl',
                    LeftShift = 'Left Shift', RightShift = 'Right Shift',
                    Semicolon = ";", Quote = '"',
                    LeftBracket = '[', RightBracket = ']',
                    Equals = '=', Minus = '-',
                    RightAlt = 'Right Alt', LeftAlt = 'Left Alt'
                }

                local bindKey = default
                local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

                local KeybindModule = Instance.new("Frame")
                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundTransparency = 1
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Size = UDim2.new(1, 0, 0, 34)

                local KeybindBtn = Instance.new("TextButton")
                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = Color3.fromRGB(45, 42, 62)
                KeybindBtn.BackgroundTransparency = 0.15
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(1, 0, 1, 0)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.GothamMedium
                KeybindBtn.Text = "   " .. text
                KeybindBtn.TextColor3 = Color3.fromRGB(225, 225, 240)
                KeybindBtn.TextSize = 14
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left

                local KeybindBtnC = Instance.new("UICorner")
                KeybindBtnC.CornerRadius = UDim.new(0, 6)
                KeybindBtnC.Parent = KeybindBtn

                local KeybindBtnStroke = Instance.new("UIStroke")
                KeybindBtnStroke.Thickness = 1
                KeybindBtnStroke.Color = Color3.fromRGB(90, 80, 130)
                KeybindBtnStroke.Transparency = 0.7
                KeybindBtnStroke.Parent = KeybindBtn

                local KeybindValue = Instance.new("TextButton")
                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(1, -110, 0.5, -13)
                KeybindValue.Size = UDim2.new(0, 100, 0, 26)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.Gotham
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(220, 220, 240)
                KeybindValue.TextSize = 13

                local KeybindValueC = Instance.new("UICorner")
                KeybindValueC.CornerRadius = UDim.new(0, 5)
                KeybindValueC.Parent = KeybindValue

                local KeybindValueStroke = Instance.new("UIStroke")
                KeybindValueStroke.Thickness = 1
                KeybindValueStroke.Color = Color3.fromRGB(90, 80, 130)
                KeybindValueStroke.Transparency = 0.7
                KeybindValueStroke.Parent = KeybindValue

                UIS.InputBegan:Connect(function(inp, gpe)
                    if gpe then return end
                    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    if inp.KeyCode ~= bindKey then return end
                    callback(bindKey.Name)
                end)

                KeybindValue.MouseButton1Click:Connect(function()
                    KeybindValue.Text = "..."
                    wait()
                    local key = UIS.InputEnded:Wait()
                    local keyName = tostring(key.KeyCode.Name)
                    if key.UserInputType ~= Enum.UserInputType.Keyboard then
                        KeybindValue.Text = keyTxt
                        return
                    end
                    if banned[keyName] then
                        KeybindValue.Text = keyTxt
                        return
                    end
                    wait()
                    bindKey = Enum.KeyCode[keyName]
                    KeybindValue.Text = shortNames[keyName] or keyName
                end)

                KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 26)
                    KeybindValue.Position = UDim2.new(1, -(KeybindValue.TextBounds.X + 40), 0.5, -13)
                end)
            end

            function section.Textbox(_, text, flag, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default text provided")

                library.flags[flag] = default

                local TextboxModule = Instance.new("Frame")
                TextboxModule.Name = "TextboxModule"
                TextboxModule.Parent = Objs
                TextboxModule.BackgroundTransparency = 1
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Size = UDim2.new(1, 0, 0, 34)

                local TextboxBack = Instance.new("TextButton")
                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = Color3.fromRGB(45, 42, 62)
                TextboxBack.BackgroundTransparency = 0.15
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(1, 0, 1, 0)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = Enum.Font.GothamMedium
                TextboxBack.Text = "   " .. text
                TextboxBack.TextColor3 = Color3.fromRGB(225, 225, 240)
                TextboxBack.TextSize = 14
                TextboxBack.TextXAlignment = Enum.TextXAlignment.Left

                local TextboxBackC = Instance.new("UICorner")
                TextboxBackC.CornerRadius = UDim.new(0, 6)
                TextboxBackC.Parent = TextboxBack

                local TextboxBackStroke = Instance.new("UIStroke")
                TextboxBackStroke.Thickness = 1
                TextboxBackStroke.Color = Color3.fromRGB(90, 80, 130)
                TextboxBackStroke.Transparency = 0.7
                TextboxBackStroke.Parent = TextboxBack

                local BoxBG = Instance.new("TextButton")
                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(1, -110, 0.5, -13)
                BoxBG.Size = UDim2.new(0, 100, 0, 26)
                BoxBG.AutoButtonColor = false
                BoxBG.Text = ""

                local BoxBGC = Instance.new("UICorner")
                BoxBGC.CornerRadius = UDim.new(0, 5)
                BoxBGC.Parent = BoxBG

                local BoxBGStroke = Instance.new("UIStroke")
                BoxBGStroke.Thickness = 1
                BoxBGStroke.Color = Color3.fromRGB(90, 80, 130)
                BoxBGStroke.Transparency = 0.7
                BoxBGStroke.Parent = BoxBG

                local TextBox = Instance.new("TextBox")
                TextBox.Parent = BoxBG
                TextBox.BackgroundTransparency = 1
                TextBox.BorderSizePixel = 0
                TextBox.Size = UDim2.new(1, 0, 1, 0)
                TextBox.Font = Enum.Font.Gotham
                TextBox.Text = default
                TextBox.TextColor3 = Color3.fromRGB(220, 220, 240)
                TextBox.TextSize = 13
                TextBox.ClearTextOnFocus = false

                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == "" then
                        TextBox.Text = default
                    end
                    library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                end)

                BoxBG:GetPropertyChangedSignal("Size"):Connect(function() end)
            end

            function section.Slider(_, text, flag, default, min, max, precise, callback)
                local callback = callback or function() end
                local min = min or 1
                local max = max or 10
                local default = default or min
                local precise = precise or false

                library.flags[flag] = default

                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default value provided")

                local SliderModule = Instance.new("Frame")
                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundTransparency = 1
                SliderModule.BorderSizePixel = 0
                SliderModule.Size = UDim2.new(1, 0, 0, 34)

                local SliderBack = Instance.new("TextButton")
                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = Color3.fromRGB(45, 42, 62)
                SliderBack.BackgroundTransparency = 0.15
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(1, 0, 1, 0)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamMedium
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = Color3.fromRGB(225, 225, 240)
                SliderBack.TextSize = 14
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left

                local SliderBackC = Instance.new("UICorner")
                SliderBackC.CornerRadius = UDim.new(0, 6)
                SliderBackC.Parent = SliderBack

                local SliderBackStroke = Instance.new("UIStroke")
                SliderBackStroke.Thickness = 1
                SliderBackStroke.Color = Color3.fromRGB(90, 80, 130)
                SliderBackStroke.Transparency = 0.7
                SliderBackStroke.Parent = SliderBack

                -- 滑块底
                local SliderBar = Instance.new("Frame")
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.36, 0, 0.5, 0)
                SliderBar.Size = UDim2.new(0.35, 0, 6, 0)

                local SliderBarC = Instance.new("UICorner")
                SliderBarC.CornerRadius = UDim.new(1, 0)
                SliderBarC.Parent = SliderBar

                local SliderBarStroke = Instance.new("UIStroke")
                SliderBarStroke.Thickness = 1
                SliderBarStroke.Color = Color3.fromRGB(80, 80, 110)
                SliderBarStroke.Transparency = 0.5
                SliderBarStroke.Parent = SliderBar

                -- 填充
                local SliderPart = Instance.new("Frame")
                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = Color3.fromRGB(180, 120, 255)
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0.4, 0, 1, 0)

                local SliderPartC = Instance.new("UICorner")
                SliderPartC.CornerRadius = UDim.new(1, 0)
                SliderPartC.Parent = SliderPart

                local SliderPartGrad = Instance.new("UIGradient")
                SliderPartGrad.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(180, 120, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(120, 160, 255))
                }
                SliderPartGrad.Parent = SliderPart

                -- 值显示
                local SliderValBG = Instance.new("TextButton")
                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(1, -50, 0.5, -13)
                SliderValBG.Size = UDim2.new(0, 44, 0, 26)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Text = ""

                local SliderValBGC = Instance.new("UICorner")
                SliderValBGC.CornerRadius = UDim.new(0, 5)
                SliderValBGC.Parent = SliderValBG

                local SliderValue = Instance.new("TextBox")
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundTransparency = 1
                SliderValue.BorderSizePixel = 0
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = tostring(default)
                SliderValue.TextColor3 = Color3.fromRGB(220, 220, 240)
                SliderValue.TextSize = 13
                SliderValue.ClearTextOnFocus = false

                -- 加减按钮
                local MinSlider = Instance.new("TextButton")
                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundTransparency = 1
                MinSlider.BorderSizePixel = 0
                MinSlider.AnchorPoint = Vector2.new(1, 0.5)
                MinSlider.Position = UDim2.new(0.36, -4, 0.5, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
                MinSlider.Font = Enum.Font.Gotham
                MinSlider.Text = "-"
                MinSlider.TextColor3 = Color3.fromRGB(200, 200, 220)
                MinSlider.TextSize = 18

                local AddSlider = Instance.new("TextButton")
                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderModule
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundTransparency = 1
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.71, 4, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.Gotham
                AddSlider.Text = "+"
                AddSlider.TextColor3 = Color3.fromRGB(200, 200, 220)
                AddSlider.TextSize = 18

                local funcs = {
                    SetValue = function(self, value)
                        local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                        if value then
                            percent = (value - min) / (max - min)
                        end
                        percent = math.clamp(percent, 0, 1)
                        if precise then
                            value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
                        else
                            value = value or math.floor(min + (max - min) * percent)
                        end
                        library.flags[flag] = tonumber(value)
                        SliderValue.Text = tostring(value)
                        SliderPart.Size = UDim2.new(percent, 0, 1, 0)
                        callback(tonumber(value))
                    end
                }

                MinSlider.MouseButton1Click:Connect(function()
                    local cv = library.flags[flag]
                    cv = math.clamp(cv - 1, min, max)
                    funcs:SetValue(cv)
                end)

                AddSlider.MouseButton1Click:Connect(function()
                    local cv = library.flags[flag]
                    cv = math.clamp(cv + 1, min, max)
                    funcs:SetValue(cv)
                end)

                funcs:SetValue(default)

                local dragging, boxFocused, allowed = false, false, { [""] = true, ["-"] = true }

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                        funcs:SetValue()
                        dragging = true
                    end
                end)

                UIS.InputEnded:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch) then
                        dragging = false
                    end
                end)

                UIS.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch) then
                        funcs:SetValue()
                    end
                end)

                SliderValue.Focused:Connect(function() boxFocused = true end)
                SliderValue.FocusLost:Connect(function()
                    boxFocused = false
                    if SliderValue.Text == "" then
                        funcs:SetValue(default)
                    end
                end)

                SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
                    if not boxFocused then return end
                    SliderValue.Text = SliderValue.Text:gsub("%D+", "")
                    local txt = SliderValue.Text
                    if not tonumber(txt) then
                        SliderValue.Text = SliderValue.Text:gsub('%D+', '')
                    elseif not allowed[txt] then
                        if tonumber(txt) > max then
                            txt = max
                            SliderValue.Text = tostring(max)
                        end
                        funcs:SetValue(tonumber(txt))
                    end
                end)

                return funcs
            end

            function section.Dropdown(_, text, flag, options, callback)
                local callback = callback or function() end
                local options = options or {}
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = nil

                local DropdownModule = Instance.new("Frame")
                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(45, 42, 62)
                DropdownModule.BackgroundTransparency = 0.15
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Size = UDim2.new(1, 0, 0, 34)

                local DropdownModuleCorner = Instance.new("UICorner")
                DropdownModuleCorner.CornerRadius = UDim.new(0, 6)
                DropdownModuleCorner.Parent = DropdownModule

                local DropdownModuleStroke = Instance.new("UIStroke")
                DropdownModuleStroke.Thickness = 1
                DropdownModuleStroke.Color = Color3.fromRGB(90, 80, 130)
                DropdownModuleStroke.Transparency = 0.7
                DropdownModuleStroke.Parent = DropdownModule

                local DropdownOpen = Instance.new("TextButton")
                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownModule
                DropdownOpen.AnchorPoint = Vector2.new(1, 0.5)
                DropdownOpen.BackgroundTransparency = 1
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(1, -14, 0, 17)
                DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
                DropdownOpen.Font = Enum.Font.Gotham
                DropdownOpen.Text = "+"
                DropdownOpen.TextColor3 = Color3.fromRGB(200, 200, 220)
                DropdownOpen.TextSize = 20

                local DropdownText = Instance.new("TextBox")
                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownModule
                DropdownText.BackgroundTransparency = 1
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0, 12, 0, 0)
                DropdownText.Size = UDim2.new(1, -50, 0, 34)
                DropdownText.Font = Enum.Font.GothamMedium
                DropdownText.PlaceholderColor3 = Color3.fromRGB(180, 180, 200)
                DropdownText.PlaceholderText = text
                DropdownText.Text = ""
                DropdownText.TextColor3 = Color3.fromRGB(220, 220, 240)
                DropdownText.TextSize = 14
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                DropdownText.ClearTextOnFocus = false

                local DropdownModuleL = Instance.new("UIListLayout")
                DropdownModuleL.Name = "DropdownModuleL"
                DropdownModuleL.Parent = DropdownModule
                DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownModuleL.Padding = UDim.new(0, 3)

                -- 保证顶部两个控件不参与布局
                DropdownOpen.LayoutOrder = -999
                DropdownText.LayoutOrder = -999

                local setAllVisible = function()
                    for _, opt in ipairs(DropdownModule:GetChildren()) do
                        if opt:IsA("TextButton") and opt.Name:match("Option_") then
                            opt.Visible = true
                        end
                    end
                end

                local searchDropdown = function(text)
                    for _, opt in ipairs(DropdownModule:GetChildren()) do
                        if opt:IsA("TextButton") and opt.Name:match("Option_") then
                            if text == "" then
                                opt.Visible = true
                            else
                                opt.Visible = opt.Text:lower():match(text:lower()) ~= nil
                            end
                        end
                    end
                end

                local open = false
                local ToggleDropVis = function()
                    open = not open
                    if open then setAllVisible() end
                    DropdownOpen.Text = (open and "-" or "+")
                    DropdownModule.Size = UDim2.new(1, 0, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 44 or 34))
                end

                DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
                DropdownText.Focused:Connect(function()
                    if open then return end
                    ToggleDropVis()
                end)

                DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
                    if not open then return end
                    searchDropdown(DropdownText.Text)
                end)

                DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if not open then return end
                    DropdownModule.Size = UDim2.new(1, 0, 0, (DropdownModuleL.AbsoluteContentSize.Y + 44))
                end)

                local funcs = {}

                funcs.AddOption = function(self, option)
                    local Opt = Instance.new("TextButton")
                    Opt.Name = "Option_" .. option
                    Opt.Parent = DropdownModule
                    Opt.BackgroundColor3 = Color3.fromRGB(38, 36, 54)
                    Opt.BackgroundTransparency = 0.2
                    Opt.BorderSizePixel = 0
                    Opt.Size = UDim2.new(1, -12, 0, 26)
                    Opt.Position = UDim2.new(0, 6, 0, 0)
                    Opt.AutoButtonColor = false
                    Opt.Font = Enum.Font.Gotham
                    Opt.Text = option
                    Opt.TextColor3 = Color3.fromRGB(210, 210, 230)
                    Opt.TextSize = 13
                    Opt.LayoutOrder = 1

                    local OptC = Instance.new("UICorner")
                    OptC.CornerRadius = UDim.new(0, 5)
                    OptC.Parent = Opt

                    Opt.MouseEnter:Connect(function()
                        TS:Create(Opt, TweenInfo.new(0.15), {
                            BackgroundColor3 = Color3.fromRGB(60, 55, 90),
                            BackgroundTransparency = 0
                        }):Play()
                    end)
                    Opt.MouseLeave:Connect(function()
                        TS:Create(Opt, TweenInfo.new(0.15), {
                            BackgroundColor3 = Color3.fromRGB(38, 36, 54),
                            BackgroundTransparency = 0.2
                        }):Play()
                    end)

                    Opt.MouseButton1Click:Connect(function()
                        ToggleDropVis()
                        callback(Opt.Text)
                        DropdownText.Text = Opt.Text
                        library.flags[flag] = Opt.Text
                    end)
                end

                funcs.RemoveOption = function(self, option)
                    local opt = DropdownModule:FindFirstChild("Option_" .. option)
                    if opt then opt:Destroy() end
                end

                funcs.SetOptions = function(self, options)
                    for _, v in next, DropdownModule:GetChildren() do
                        if v.Name:match("Option_") then
                            v:Destroy()
                        end
                    end
                    for _, v in next, options do
                        funcs:AddOption(v)
                    end
                end

                funcs:SetOptions(options)

                return funcs
            end

            return section
        end

        return tab
    end

    return window
end

return library