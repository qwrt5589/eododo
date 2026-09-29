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

-- ============================================================
-- 小本本配色
-- ============================================================
local Paper = {
    bg        = Color3.fromRGB(255, 250, 238),   -- 纸底
    bgDark    = Color3.fromRGB(255, 242, 218),   -- 侧栏纸
    card      = Color3.fromRGB(255, 253, 246),   -- 卡片
    cardHover = Color3.fromRGB(255, 246, 225),
    ink       = Color3.fromRGB(45, 40, 55),      -- 墨黑
    inkSoft   = Color3.fromRGB(125, 115, 135),
    line      = Color3.fromRGB(230, 220, 205),
    accent    = Color3.fromRGB(255, 195, 110),   -- 主题橘
    accent2   = Color3.fromRGB(255, 165, 90),
    mint      = Color3.fromRGB(160, 235, 175),   -- 开
    pink      = Color3.fromRGB(255, 175, 200),
    blue      = Color3.fromRGB(165, 220, 255),
    purple    = Color3.fromRGB(205, 185, 250),
    track     = Color3.fromRGB(235, 226, 210),
    text      = Color3.fromRGB(45, 40, 55),
    textDim   = Color3.fromRGB(150, 140, 160)
}

local FontBold = Enum.Font.GothamBlack
local FontMed  = Enum.Font.GothamBold
local FontNorm = Enum.Font.Gotham

function Tween(obj, t, data)
    services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
    return true
end

function Ripple(obj)
    spawn(function()
        if obj.ClipsDescendants ~= true then
            obj.ClipsDescendants = true
        end
        local Ripple = Instance.new("ImageLabel")
        Ripple.Name = "Ripple"
        Ripple.Parent = obj
        Ripple.BackgroundColor3 = Paper.accent
        Ripple.BackgroundTransparency = 1.000
        Ripple.ZIndex = 8
        Ripple.Image = "rbxassetid://111477850857548"
        Ripple.ImageTransparency = 0.800
        Ripple.ScaleType = Enum.ScaleType.Fit
        Ripple.ImageColor3 = Paper.accent
        Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
        Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
        wait(0.15)
        Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
        wait(.3)
        Ripple:Destroy()
    end)
end

local toggled = false
local switchingTabs = false

-- 工具：加圆角 + 粗描边
local function round(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = r or UDim.new(0, 10)
    c.Parent = obj
    return c
end

local function ink(obj, thickness)
    local s = Instance.new("UIStroke")
    s.Color = Paper.ink
    s.Thickness = thickness or 2
    s.Transparency = 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
    return s
end

-- ============================================================
-- Tab 切换
-- ============================================================
function switchTab(new)
    if switchingTabs then return end
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
        services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
        return
    end
    if old[1] == new[1] then return end
    switchingTabs = true
    library.currentTab = new

    services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.4}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.4}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

    old[2].Visible = false
    new[2].Visible = true

    task.wait(0.1)
    switchingTabs = false
end

-- ============================================================
-- 拖动
-- ============================================================
function drag(frame, hold)
    if not hold then hold = frame end
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    hold.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- ============================================================
-- 主入口
-- ============================================================
function library.new(lib, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
            v:Destroy()
        end
    end

    local dogent = Instance.new("ScreenGui")
    if syn and syn.protect_gui then syn.protect_gui(dogent) end
    dogent.Name = "frosty"
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

    -- 主窗口
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = dogent
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Paper.bg
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 620, 0, 400)
    Main.ZIndex = 1
    Main.Active = true
    Main.Draggable = true
    round(Main, UDim.new(0, 20))
    ink(Main, 4)

    services.UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            Main.Visible = not Main.Visible
        end
    end)

    drag(Main)

    -- 纸张横线
    local paperLines = Instance.new("Frame")
    paperLines.Size = UDim2.new(1, 0, 1, 0)
    paperLines.BackgroundTransparency = 1
    paperLines.ZIndex = 1
    paperLines.Parent = Main
    for y = 70, 400, 30 do
        local ln = Instance.new("Frame")
        ln.Size = UDim2.new(1, -30, 0, 1)
        ln.Position = UDim2.new(0, 15, 0, y)
        ln.BackgroundColor3 = Paper.line
        ln.BackgroundTransparency = 0.5
        ln.BorderSizePixel = 0
        ln.ZIndex = 1
        ln.Parent = paperLines
    end
    round(paperLines, UDim.new(0, 20))

    -- 标题栏（贴纸）
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, -24, 0, 56)
    TitleBar.Position = UDim2.new(0, 12, 0, 12)
    TitleBar.BackgroundColor3 = Paper.bgDark
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 5
    TitleBar.Parent = Main
    round(TitleBar, UDim.new(0, 16))
    ink(TitleBar, 3)

    local ScriptTitle = Instance.new("TextLabel")
    ScriptTitle.Size = UDim2.new(0, 400, 1, 0)
    ScriptTitle.Position = UDim2.new(0, 20, 0, 0)
    ScriptTitle.BackgroundTransparency = 1
    ScriptTitle.Text = name or "小本本"
    ScriptTitle.TextColor3 = Paper.ink
    ScriptTitle.TextSize = 22
    ScriptTitle.Font = FontBold
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    ScriptTitle.ZIndex = 6
    ScriptTitle.Parent = TitleBar

    -- 侧边栏
    local Side = Instance.new("Frame")
    Side.Name = "Side"
    Side.Parent = Main
    Side.BackgroundColor3 = Paper.bgDark
    Side.BorderSizePixel = 0
    Side.Position = UDim2.new(0, 12, 0, 80)
    Side.Size = UDim2.new(0, 140, 1, -100)
    Side.ZIndex = 4
    round(Side, UDim.new(0, 16))
    ink(Side, 3)

    local TabBtns = Instance.new("ScrollingFrame")
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundTransparency = 1
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 8, 0, 12)
    TabBtns.Size = UDim2.new(0, 124, 1, -24)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 0
    TabBtns.ZIndex = 5

    local TabBtnsL = Instance.new("UIListLayout")
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 10)

    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
    end)

    -- 内容区
    local TabMain = Instance.new("Frame")
    TabMain.Name = "TabMain"
    TabMain.Parent = Main
    TabMain.BackgroundColor3 = Paper.card
    TabMain.BorderSizePixel = 0
    TabMain.Position = UDim2.new(0, 164, 0, 80)
    TabMain.Size = UDim2.new(1, -182, 1, -100)
    TabMain.ZIndex = 4
    round(TabMain, UDim.new(0, 16))
    ink(TabMain, 3)

    -- 悬浮开关按钮
    local Frame = Instance.new("Frame")
    Frame.Parent = dogent
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(0.008, 0, 0.311, 0)
    Frame.Size = UDim2.new(0, 54, 0, 54)

    local Open = Instance.new("ImageButton")
    Open.Parent = Frame
    Open.BackgroundColor3 = Paper.accent
    Open.BorderSizePixel = 0
    Open.Size = UDim2.new(0, 54, 0, 54)
    Open.Active = true
    Open.Draggable = true
    Open.Image = "rbxassetid://111477850857548"
    Open.ZIndex = 10
    round(Open, UDim.new(1, 0))
    ink(Open, 3)

    Open.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
        Open.Image = Main.Visible
            and "rbxassetid://127847250671785"
            or "rbxassetid://91545768718105"
    end)

    -- ============================================================
    -- window.Tab
    -- ============================================================
    local window = {}
    function window.Tab(win, tabName, icon)
        local Tab = Instance.new("ScrollingFrame")
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0, 14, 0, 12)
        Tab.Size = UDim2.new(1, -28, 1, -24)
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = Paper.accent
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.Visible = false
        Tab.ZIndex = 5

        local TabL = Instance.new("UIListLayout")
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 6)

        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)

        -- 侧栏按钮
        local TabIco = Instance.new("TextButton")
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundColor3 = Paper.card
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(1, 0, 0, 40)
        TabIco.AutoButtonColor = false
        TabIco.Text = ""
        TabIco.ZIndex = 6
        round(TabIco, UDim.new(0, 12))
        ink(TabIco, 2)

        local TabText = Instance.new("TextLabel")
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundTransparency = 1
        TabText.Position = UDim2.new(0, 10, 0, 0)
        TabText.Size = UDim2.new(1, -14, 1, 0)
        TabText.Font = FontMed
        TabText.Text = (icon and (icon .. " ") or "") .. (tabName or "Tab")
        TabText.TextColor3 = Paper.ink
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.ZIndex = 7
        TabText.TextTransparency = 0.4

        TabIco.MouseButton1Click:Connect(function()
            spawn(function() Ripple(TabIco) end)
            switchTab({TabIco, Tab})
        end)

        if library.currentTab == nil then switchTab({TabIco, Tab}) end

        -- ============================================================
        -- section
        -- ============================================================
        local tab = {}

        function tab.section(t, sectionName, openDefault)
            local Section = Instance.new("Frame")
            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Paper.card
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(1, -8, 0, 42)
            Section.ZIndex = 6
            round(Section, UDim.new(0, 14))
            ink(Section, 3)

            local SectionText = Instance.new("TextLabel")
            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundTransparency = 1
            SectionText.Position = UDim2.new(0, 40, 0, 0)
            SectionText.Size = UDim2.new(1, -50, 0, 42)
            SectionText.Font = FontBold
            SectionText.Text = sectionName or "Section"
            SectionText.TextColor3 = Paper.ink
            SectionText.TextSize = 16
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            SectionText.ZIndex = 7

            -- 小圆点装饰
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 14, 0, 14)
            dot.Position = UDim2.new(0, 16, 0.5, -7)
            dot.BackgroundColor3 = Paper.accent
            dot.BorderSizePixel = 0
            dot.ZIndex = 7
            dot.Parent = Section
            round(dot, UDim.new(1, 0))
            ink(dot, 2)

            -- 展开按钮
            local SectionToggle = Instance.new("TextButton")
            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = Section
            SectionToggle.BackgroundColor3 = Paper.bgDark
            SectionToggle.BorderSizePixel = 0
            SectionToggle.AnchorPoint = Vector2.new(1, 0.5)
            SectionToggle.Position = UDim2.new(1, -12, 0.5, 0)
            SectionToggle.Size = UDim2.new(0, 28, 0, 28)
            SectionToggle.Text = "-"
            SectionToggle.TextColor3 = Paper.ink
            SectionToggle.TextSize = 20
            SectionToggle.Font = FontBold
            SectionToggle.AutoButtonColor = false
            SectionToggle.ZIndex = 8
            round(SectionToggle, UDim.new(0, 9))
            ink(SectionToggle, 2)

            local Objs = Instance.new("Frame")
            Objs.Name = "Objs"
            Objs.Parent = Section
            Objs.BackgroundTransparency = 1
            Objs.Position = UDim2.new(0, 12, 0, 46)
            Objs.Size = UDim2.new(1, -24, 0, 0)
            Objs.ZIndex = 7

            local ObjsL = Instance.new("UIListLayout")
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 8)

            local open = openDefault
            if openDefault == nil then open = true end

            local function refresh()
                if open then
                    Section.Size = UDim2.new(1, -8, 0, 46 + ObjsL.AbsoluteContentSize.Y + 12)
                else
                    Section.Size = UDim2.new(1, -8, 0, 42)
                end
                SectionToggle.Text = open and "-" or "+"
            end

            refresh()

            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                refresh()
            end)

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refresh)

            -- ============================================================
            -- section 内部控件
            -- ============================================================
            local section = {}

            -- Button
            function section.Button(s, text, callback)
                callback = callback or function() end

                local Btn = Instance.new("TextButton")
                Btn.Name = "Btn"
                Btn.Parent = Objs
                Btn.BackgroundColor3 = Paper.card
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(1, 0, 0, 40)
                Btn.AutoButtonColor = false
                Btn.Font = FontMed
                Btn.Text = "   " .. (text or "Button")
                Btn.TextColor3 = Paper.ink
                Btn.TextSize = 15
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                Btn.ZIndex = 7
                round(Btn, UDim.new(0, 12))
                ink(Btn, 2)

                Btn.MouseEnter:Connect(function()
                    Tween(Btn, {0.15, "Sine", "Out"}, {BackgroundColor3 = Paper.cardHover})
                end)
                Btn.MouseLeave:Connect(function()
                    Tween(Btn, {0.15, "Sine", "Out"}, {BackgroundColor3 = Paper.card})
                end)

                Btn.MouseButton1Click:Connect(function()
                    spawn(function() Ripple(Btn) end)
                    spawn(callback)
                end)

                return Btn
            end

            -- Label
            function section.Label(s, text)
                local TextLabel = Instance.new("TextLabel")
                TextLabel.Parent = Objs
                TextLabel.BackgroundColor3 = Paper.bgDark
                TextLabel.Size = UDim2.new(1, 0, 0, 26)
                TextLabel.Font = FontMed
                TextLabel.Text = "   " .. (text or "")
                TextLabel.TextColor3 = Paper.inkSoft
                TextLabel.TextSize = 13
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel.ZIndex = 7
                round(TextLabel, UDim.new(0, 9))
                ink(TextLabel, 1.5)
                return TextLabel
            end

            -- Toggle
            function section.Toggle(s, text, flag, enabled, callback)
                callback = callback or function() end
                enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = enabled

                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = Objs
                ToggleBtn.BackgroundColor3 = Paper.card
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(1, 0, 0, 40)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = FontMed
                ToggleBtn.Text = "   " .. text
                ToggleBtn.TextColor3 = Paper.ink
                ToggleBtn.TextSize = 15
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                ToggleBtn.ZIndex = 7
                round(ToggleBtn, UDim.new(0, 12))
                ink(ToggleBtn, 2)

                local ToggleDisable = Instance.new("Frame")
                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Paper.track
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.AnchorPoint = Vector2.new(1, 0.5)
                ToggleDisable.Position = UDim2.new(1, -12, 0.5, 0)
                ToggleDisable.Size = UDim2.new(0, 44, 0, 24)
                ToggleDisable.ZIndex = 8
                round(ToggleDisable, UDim.new(0, 12))
                ink(ToggleDisable, 2)

                local ToggleSwitch = Instance.new("Frame")
                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleSwitch.BorderSizePixel = 0
                ToggleSwitch.Position = UDim2.new(0, 2, 0, 2)
                ToggleSwitch.Size = UDim2.new(0, 20, 0, 20)
                ToggleSwitch.ZIndex = 9
                round(ToggleSwitch, UDim.new(1, 0))
                ink(ToggleSwitch, 1.5)

                local funcs = {
                    SetState = function(self, state)
                        if state == nil then state = not library.flags[flag] end
                        if library.flags[flag] == state then return end
                        services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                            Position = UDim2.new(0, (state and 22 or 2), 0, 2)
                        }):Play()
                        services.TweenService:Create(ToggleDisable, TweenInfo.new(0.2), {
                            BackgroundColor3 = (state and Paper.mint or Paper.track)
                        }):Play()
                        library.flags[flag] = state
                        callback(state)
                    end,
                    Module = ToggleBtn
                }

                if enabled ~= false then
                    funcs:SetState(true)
                end

                ToggleBtn.MouseButton1Click:Connect(function()
                    funcs:SetState()
                end)
                return funcs
            end

            -- Textbox
            function section.Textbox(s, text, flag, default, callback)
                callback = callback or function() end
                default = default or ""
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = default

                local TextboxBack = Instance.new("TextButton")
                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = Objs
                TextboxBack.BackgroundColor3 = Paper.card
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(1, 0, 0, 40)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = FontMed
                TextboxBack.Text = "   " .. text
                TextboxBack.TextColor3 = Paper.ink
                TextboxBack.TextSize = 15
                TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
                TextboxBack.ZIndex = 7
                round(TextboxBack, UDim.new(0, 12))
                ink(TextboxBack, 2)

                local BoxBG = Instance.new("Frame")
                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Paper.bgDark
                BoxBG.BorderSizePixel = 0
                BoxBG.AnchorPoint = Vector2.new(1, 0.5)
                BoxBG.Position = UDim2.new(1, -12, 0.5, 0)
                BoxBG.Size = UDim2.new(0, 120, 0, 26)
                BoxBG.ZIndex = 8
                round(BoxBG, UDim.new(0, 8))
                ink(BoxBG, 1.5)

                local TextBox = Instance.new("TextBox")
                TextBox.Parent = BoxBG
                TextBox.BackgroundTransparency = 1
                TextBox.Size = UDim2.new(1, -8, 1, 0)
                TextBox.Position = UDim2.new(0, 4, 0, 0)
                TextBox.Font = FontNorm
                TextBox.Text = default
                TextBox.TextColor3 = Paper.ink
                TextBox.TextSize = 13
                TextBox.ClearTextOnFocus = false
                TextBox.ZIndex = 9

                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == "" then TextBox.Text = default end
                    library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                end)
            end

            -- Slider
            function section.Slider(s, text, flag, default, min, max, precise, callback)
                callback = callback or function() end
                min = min or 1
                max = max or 10
                default = default or min
                precise = precise or false

                library.flags[flag] = default
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                local SliderBack = Instance.new("TextButton")
                SliderBack.Name = "SliderBack"
                SliderBack.Parent = Objs
                SliderBack.BackgroundColor3 = Paper.card
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(1, 0, 0, 46)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = FontMed
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = Paper.ink
                SliderBack.TextSize = 15
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left
                SliderBack.ZIndex = 7
                round(SliderBack, UDim.new(0, 12))
                ink(SliderBack, 2)

                local SliderBar = Instance.new("Frame")
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.BackgroundColor3 = Paper.track
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0, 14, 1, -14)
                SliderBar.Size = UDim2.new(1, -130, 0, 10)
                SliderBar.ZIndex = 8
                round(SliderBar, UDim.new(1, 0))
                ink(SliderBar, 1.5)

                local SliderPart = Instance.new("Frame")
                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = Paper.accent
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0, 0, 1, 0)
                SliderPart.ZIndex = 9
                round(SliderPart, UDim.new(1, 0))

                local SliderValBG = Instance.new("Frame")
                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Paper.bgDark
                SliderValBG.BorderSizePixel = 0
                SliderValBG.AnchorPoint = Vector2.new(1, 0.5)
                SliderValBG.Position = UDim2.new(1, -12, 0.5, 0)
                SliderValBG.Size = UDim2.new(0, 56, 0, 26)
                SliderValBG.ZIndex = 8
                round(SliderValBG, UDim.new(0, 8))
                ink(SliderValBG, 1.5)

                local SliderValue = Instance.new("TextBox")
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundTransparency = 1
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = FontMed
                SliderValue.Text = tostring(default)
                SliderValue.TextColor3 = Paper.ink
                SliderValue.TextSize = 13
                SliderValue.ZIndex = 9

                local funcs = {
                    SetValue = function(self, value)
                        local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                        if value then percent = (value - min) / (max - min) end
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

                funcs:SetValue(default)

                local dragging = false
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        funcs:SetValue()
                        dragging = true
                    end
                end)
                services.UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        funcs:SetValue()
                    end
                end)

                SliderValue.FocusLost:Connect(function()
                    local v = tonumber(SliderValue.Text) or default
                    v = math.clamp(v, min, max)
                    funcs:SetValue(v)
                end)

                return funcs
            end

            -- Dropdown
            function section.Dropdown(s, text, flag, options, callback)
                callback = callback or function() end
                options = options or {}
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = nil

                local DropdownModule = Instance.new("Frame")
                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundTransparency = 1
                DropdownModule.ClipsDescendants = true
                DropdownModule.Size = UDim2.new(1, 0, 0, 40)
                DropdownModule.ZIndex = 7

                local DropdownTop = Instance.new("TextButton")
                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = Paper.card
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(1, 0, 0, 40)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Text = ""
                DropdownTop.ZIndex = 7
                round(DropdownTop, UDim.new(0, 12))
                ink(DropdownTop, 2)

                local DropdownText = Instance.new("TextLabel")
                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundTransparency = 1
                DropdownText.Position = UDim2.new(0, 14, 0, 0)
                DropdownText.Size = UDim2.new(1, -60, 1, 0)
                DropdownText.Font = FontMed
                DropdownText.Text = text
                DropdownText.TextColor3 = Paper.ink
                DropdownText.TextSize = 15
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                DropdownText.ZIndex = 8

                local DropdownOpen = Instance.new("TextButton")
                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.BackgroundColor3 = Paper.bgDark
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.AnchorPoint = Vector2.new(1, 0.5)
                DropdownOpen.Position = UDim2.new(1, -10, 0.5, 0)
                DropdownOpen.Size = UDim2.new(0, 28, 0, 28)
                DropdownOpen.Text = "+"
                DropdownOpen.TextColor3 = Paper.ink
                DropdownOpen.TextSize = 20
                DropdownOpen.Font = FontBold
                DropdownOpen.AutoButtonColor = false
                DropdownOpen.ZIndex = 8
                round(DropdownOpen, UDim.new(0, 9))
                ink(DropdownOpen, 2)

                local DropdownModuleL = Instance.new("UIListLayout")
                DropdownModuleL.Parent = DropdownModule
                DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownModuleL.Padding = UDim.new(0, 6)

                local open = false
                local ToggleDropVis = function()
                    open = not open
                    DropdownOpen.Text = (open and "-" or "+")
                    if open then
                        DropdownModule.Size = UDim2.new(1, 0, 0, DropdownModuleL.AbsoluteContentSize.Y + 46)
                    else
                        DropdownModule.Size = UDim2.new(1, 0, 0, 40)
                    end
                end

                DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)

                DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if not open then return end
                    DropdownModule.Size = UDim2.new(1, 0, 0, DropdownModuleL.AbsoluteContentSize.Y + 46)
                end)

                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = Paper.bgDark
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(1, 0, 0, 32)
                    Option.AutoButtonColor = false
                    Option.Font = FontMed
                    Option.Text = option
                    Option.TextColor3 = Paper.ink
                    Option.TextSize = 13
                    Option.ZIndex = 8
                    round(Option, UDim.new(0, 9))
                    ink(Option, 1.5)

                    Option.MouseButton1Click:Connect(function()
                        if open then ToggleDropVis() end
                        callback(Option.Text)
                        DropdownText.Text = text .. ": " .. Option.Text
                        library.flags[flag] = Option.Text
                    end)
                end

                funcs.RemoveOption = function(self, option)
                    local opt = DropdownModule:FindFirstChild("Option_" .. option)
                    if opt then opt:Destroy() end
                end

                funcs.SetOptions = function(self, opts)
                    for _, v in next, DropdownModule:GetChildren() do
                        if v.Name:match("Option_") then v:Destroy() end
                    end
                    for _, v in next, opts do
                        funcs:AddOption(v)
                    end
                end

                funcs:SetOptions(options)
                return funcs
            end

            -- Keybind
            function section.Keybind(s, text, default, callback)
                callback = callback or function() end
                assert(text, "No text provided")
                assert(default, "No default key provided")

                default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
                local banned = {Return=true, Space=true, Tab=true, Backquote=true, CapsLock=true, Escape=true, Unknown=true}
                local shortNames = {
                    RightControl='Right Ctrl', LeftControl='Left Ctrl',
                    LeftShift='Left Shift', RightShift='Right Shift',
                    Semicolon=";", Quote='"', LeftBracket='[', RightBracket=']',
                    Equals='=', Minus='-', RightAlt='Right Alt', LeftAlt='Left Alt'
                }

                local bindKey = default
                local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

                local KeybindBtn = Instance.new("TextButton")
                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = Objs
                KeybindBtn.BackgroundColor3 = Paper.card
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(1, 0, 0, 40)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = FontMed
                KeybindBtn.Text = "   " .. text
                KeybindBtn.TextColor3 = Paper.ink
                KeybindBtn.TextSize = 15
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
                KeybindBtn.ZIndex = 7
                round(KeybindBtn, UDim.new(0, 12))
                ink(KeybindBtn, 2)

                local KeybindValue = Instance.new("TextButton")
                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Paper.bgDark
                KeybindValue.BorderSizePixel = 0
                KeybindValue.AnchorPoint = Vector2.new(1, 0.5)
                KeybindValue.Position = UDim2.new(1, -12, 0.5, 0)
                KeybindValue.Size = UDim2.new(0, 90, 0, 26)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = FontMed
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Paper.ink
                KeybindValue.TextSize = 13
                KeybindValue.ZIndex = 8
                round(KeybindValue, UDim.new(0, 8))
                ink(KeybindValue, 1.5)

                services.UserInputService.InputBegan:Connect(function(inp, gpe)
                    if gpe then return end
                    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    if inp.KeyCode ~= bindKey then return end
                    callback(bindKey.Name)
                end)

                KeybindValue.MouseButton1Click:Connect(function()
                    KeybindValue.Text = "..."
                    wait()
                    local key = services.UserInputService.InputEnded:Wait()
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
                    keyTxt = shortNames[keyName] or keyName
                    KeybindValue.Text = keyTxt
                end)
            end

            return section
        end
        return tab
    end
    return window
end

return library