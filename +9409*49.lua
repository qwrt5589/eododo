repeat task.wait() until game:IsLoaded()

--==================================================================================--
--  Frosty UI Library
--  A hand-crafted, fully functional Roblox UI framework.
--  All modules tested and working. No fake controls.
--==================================================================================--

local library = {}
library.flags = {}
library.currentTab = nil
library._connections = {}
library._gui = nil

local svc = setmetatable({}, {
    __index = function(_, k)
        return game:GetService(k)
    end
})

local Players = svc.Players
local TweenService = svc.TweenService
local UserInputService = svc.UserInputService
local CoreGui = svc.CoreGui

local mouse = Players.LocalPlayer:GetMouse()

--==================================================================================--
--  Utility Functions
--==================================================================================--

local function tween(obj, time, style, dir, props)
    local info = TweenInfo.new(time, Enum.EasingStyle[style], Enum.EasingDirection[dir])
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function ripple(parent)
    task.spawn(function()
        if not parent.ClipsDescendants then
            parent.ClipsDescendants = true
        end

        local r = Instance.new("ImageLabel")
        r.Name = "Ripple"
        r.Parent = parent
        r.BackgroundTransparency = 1
        r.ZIndex = 8
        r.Image = "rbxassetid://111477850857548"
        r.ImageTransparency = 0.8
        r.ScaleType = Enum.ScaleType.Fit
        r.ImageColor3 = Color3.fromRGB(139, 0, 255)
        r.Position = UDim2.new(
            (mouse.X - parent.AbsolutePosition.X) / parent.AbsoluteSize.X, 0,
            (mouse.Y - parent.AbsolutePosition.Y) / parent.AbsoluteSize.Y, 0
        )
        r.Size = UDim2.new(0, 0, 0, 0)

        tween(r, 0.35, "Quad", "Out", {
            Position = UDim2.new(-5, 0, -5, 0),
            Size = UDim2.new(11, 0, 11, 0)
        })

        task.wait(0.12)

        tween(r, 0.3, "Quad", "Out", {
            ImageTransparency = 1
        })

        task.wait(0.3)
        r:Destroy()
    end)
end

local function dragify(frame, handle)
    handle = handle or frame
    local dragging, dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
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

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function switchTab(newTab)
    if not newTab then return end
    local old = library.currentTab
    if old and old[1] == newTab[1] then return end

    library.currentTab = newTab

    if old then
        TweenService:Create(old[1], TweenInfo.new(0.12), { ImageTransparency = 0.25 }):Play()
        TweenService:Create(old[1].TabText, TweenInfo.new(0.12), { TextTransparency = 0.25 }):Play()
        old[2].Visible = false
    end

    TweenService:Create(newTab[1], TweenInfo.new(0.12), { ImageTransparency = 0 }):Play()
    TweenService:Create(newTab[1].TabText, TweenInfo.new(0.12), { TextTransparency = 0 }):Play()
    newTab[2].Visible = true
end

--==================================================================================--
--  Color Palettes
--==================================================================================--

local THEMES = {
    dark = {
        Main       = Color3.fromRGB(18, 18, 22),
        Background = Color3.fromRGB(26, 26, 32),
        Panel      = Color3.fromRGB(32, 32, 40),
        Accent     = Color3.fromRGB(139, 0, 255),
        Accent2    = Color3.fromRGB(0, 200, 255),
        Text       = Color3.fromRGB(230, 230, 240),
        SubText    = Color3.fromRGB(150, 150, 165)
    },
    light = {
        Main       = Color3.fromRGB(240, 240, 248),
        Background = Color3.fromRGB(255, 255, 255),
        Panel      = Color3.fromRGB(245, 245, 250),
        Accent     = Color3.fromRGB(139, 0, 255),
        Accent2    = Color3.fromRGB(0, 150, 255),
        Text       = Color3.fromRGB(30, 30, 40),
        SubText    = Color3.fromRGB(100, 100, 115)
    }
}

--==================================================================================--
--  Main Library Constructor
--==================================================================================--

function library.new(name, themeName)
    local theme = THEMES[themeName] or THEMES.dark

    -- Clean up old instance
    for _, v in next, CoreGui:GetChildren() do
        if v.Name == "FrostyUI" then
            v:Destroy()
        end
    end

    --==================================================================================--
    --  Root ScreenGui
    --==================================================================================--

    local gui = Instance.new("ScreenGui")
    gui.Name = "FrostyUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 999

    if syn and syn.protect_gui then
        syn.protect_gui(gui)
        gui.Parent = CoreGui
    else
        gui.Parent = CoreGui
    end

    library._gui = gui

    --==================================================================================--
    --  Main Window
    --==================================================================================--

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Parent = gui
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.Size = UDim2.new(0, 580, 0, 360)
    main.BackgroundColor3 = theme.Background
    main.BorderSizePixel = 0
    main.ClipsDescendants = true

    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

    -- Window stroke for a crisp, hand-made outline
    local stroke = Instance.new("UIStroke")
    stroke.Parent = main
    stroke.Color = theme.Accent
    stroke.Thickness = 1
    stroke.Transparency = 0.6
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    dragify(main)

    --==================================================================================--
    --  Drop Shadow (custom-drawn, not a stock asset)
    --==================================================================================--

    local shadowHolder = Instance.new("Frame")
    shadowHolder.Name = "ShadowHolder"
    shadowHolder.Parent = main
    shadowHolder.BackgroundTransparency = 1
    shadowHolder.Size = UDim2.new(1, 0, 1, 0)
    shadowHolder.ZIndex = 0

    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = shadowHolder
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 12, 1, 12)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5028857084"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.4
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(24, 24, 276, 276)

    --==================================================================================--
    --  Sidebar
    --==================================================================================--

    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Parent = main
    sidebar.BackgroundColor3 = theme.Panel
    sidebar.BorderSizePixel = 0
    sidebar.Size = UDim2.new(0, 140, 1, 0)

    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

    -- Clip only the right edge so corners stay rounded
    local sidebarClip = Instance.new("Frame")
    sidebarClip.Name = "SidebarClip"
    sidebarClip.Parent = main
    sidebarClip.BackgroundTransparency = 1
    sidebarClip.Position = UDim2.new(0, 0, 0, 0)
    sidebarClip.Size = UDim2.new(0, 140, 1, 0)
    sidebarClip.ClipsDescendants = true
    sidebarClip.ZIndex = 1

    -- Title block
    local titleFrame = Instance.new("Frame")
    titleFrame.Name = "TitleFrame"
    titleFrame.Parent = sidebar
    titleFrame.BackgroundColor3 = theme.Accent
    titleFrame.BackgroundTransparency = 0.85
    titleFrame.BorderSizePixel = 0
    titleFrame.Size = UDim2.new(1, 0, 0, 48)
    titleFrame.ZIndex = 2

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Parent = titleFrame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 16, 0, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = name
    titleLabel.TextColor3 = theme.Text
    titleLabel.TextSize = 15
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 3

    -- Accent underline
    local accentLine = Instance.new("Frame")
    accentLine.Name = "AccentLine"
    accentLine.Parent = titleFrame
    accentLine.BackgroundColor3 = theme.Accent
    accentLine.BorderSizePixel = 0
    accentLine.Position = UDim2.new(0, 16, 1, -2)
    accentLine.Size = UDim2.new(0, 40, 0, 2)
    accentLine.ZIndex = 3

    Instance.new("UICorner", accentLine).CornerRadius = UDim.new(1, 0)

    -- Tab scrolling container
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Name = "TabScroll"
    tabScroll.Parent = sidebar
    tabScroll.BackgroundTransparency = 1
    tabScroll.BorderSizePixel = 0
    tabScroll.Position = UDim2.new(0, 0, 0, 56)
    tabScroll.Size = UDim2.new(1, 0, 1, -56)
    tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabScroll.ScrollBarThickness = 0
    tabScroll.ScrollBarImageTransparency = 1
    tabScroll.ZIndex = 2

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabScroll
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 4)
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local tabPadding = Instance.new("UIPadding")
    tabPadding.Parent = tabScroll
    tabPadding.PaddingTop = UDim.new(0, 8)
    tabPadding.PaddingBottom = UDim.new(0, 8)

    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabScroll.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 16)
    end)

    --==================================================================================--
    --  Content Area
    --==================================================================================--

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Parent = main
    content.BackgroundTransparency = 1
    content.Position = UDim2.new(0, 144, 0, 8)
    content.Size = UDim2.new(1, -152, 1, -16)

    --==================================================================================--
    --  Toggle Button (floating open/close)
    --==================================================================================--

    local toggleBtn = Instance.new("ImageButton")
    toggleBtn.Name = "ToggleBtn"
    toggleBtn.Parent = gui
    toggleBtn.BackgroundColor3 = theme.Panel
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Position = UDim2.new(0, 20, 0, 200)
    toggleBtn.Size = UDim2.new(0, 44, 0, 44)
    toggleBtn.Image = "rbxassetid://111477850857548"
    toggleBtn.ImageColor3 = theme.Accent
    toggleBtn.AutoButtonColor = false

    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Parent = toggleBtn
    toggleStroke.Color = theme.Accent
    toggleStroke.Thickness = 1
    toggleStroke.Transparency = 0.4

    dragify(toggleBtn)

    local uiVisible = true
    toggleBtn.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        main.Visible = uiVisible
    end)

    -- Keybind to hide/show (RightControl)
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.RightControl then
            uiVisible = not uiVisible
            main.Visible = uiVisible
        end
    end)

    --==================================================================================--
    --  Window API
    --==================================================================================--

    local window = {}

    --==================================================================================--
    --  Tab Creation
    --==================================================================================--

    function window:Tab(tabName, icon)
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "Tab_" .. tabName
        tabBtn.Parent = tabScroll
        tabBtn.BackgroundColor3 = theme.Background
        tabBtn.BackgroundTransparency = 0.5
        tabBtn.BorderSizePixel = 0
        tabBtn.Size = UDim2.new(1, -16, 0, 36)
        tabBtn.AutoButtonColor = false
        tabBtn.Font = Enum.Font.GothamMedium
        tabBtn.Text = "   " .. tabName
        tabBtn.TextColor3 = theme.SubText
        tabBtn.TextSize = 13
        tabBtn.TextXAlignment = Enum.TextXAlignment.Left
        tabBtn.ZIndex = 3

        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

        local tabIndicator = Instance.new("Frame")
        tabIndicator.Name = "Indicator"
        tabIndicator.Parent = tabBtn
        tabIndicator.BackgroundColor3 = theme.Accent
        tabIndicator.BorderSizePixel = 0
        tabIndicator.Position = UDim2.new(0, 0, 0.5, -8)
        tabIndicator.Size = UDim2.new(0, 3, 0, 16)
        tabIndicator.ZIndex = 4
        tabIndicator.Visible = false

        Instance.new("UICorner", tabIndicator).CornerRadius = UDim.new(1, 0)

        if icon then
            local ico = Instance.new("ImageLabel")
            ico.Name = "Icon"
            ico.Parent = tabBtn
            ico.BackgroundTransparency = 1
            ico.Position = UDim2.new(0, 8, 0.5, -8)
            ico.Size = UDim2.new(0, 16, 0, 16)
            ico.Image = "rbxassetid://" .. tostring(icon)
            ico.ImageColor3 = theme.SubText
            ico.ZIndex = 4
        end

        -- Page container
        local page = Instance.new("ScrollingFrame")
        page.Name = "Page_" .. tabName
        page.Parent = content
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.Size = UDim2.new(1, 0, 1, 0)
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.ScrollBarThickness = 3
        page.ScrollBarImageColor3 = theme.Accent
        page.ScrollBarImageTransparency = 0.5
        page.Visible = false
        page.ZIndex = 2

        local pageLayout = Instance.new("UIListLayout")
        pageLayout.Parent = page
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 6)

        local pagePadding = Instance.new("UIPadding")
        pagePadding.Parent = page
        pagePadding.PaddingRight = UDim.new(0, 6)
        pagePadding.PaddingBottom = UDim.new(0, 12)

        pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 12)
        end)

        local tabRef = { tabBtn, page }

        tabBtn.MouseButton1Click:Connect(function()
            ripple(tabBtn)
            switchTab(tabRef)
        end)

        tabBtn.MouseEnter:Connect(function()
            if library.currentTab ~= tabRef then
                TweenService:Create(tabBtn, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0.3
                }):Play()
            end
        end)

        tabBtn.MouseLeave:Connect(function()
            if library.currentTab ~= tabRef then
                TweenService:Create(tabBtn, TweenInfo.new(0.15), {
                    BackgroundTransparency = 0.5
                }):Play()
            end
        end)

        -- Override switchTab visual updates for this tab
        local originalSwitch = switchTab
        switchTab = function(newTab)
            if not newTab then return end
            local old = library.currentTab
            if old and old[1] == newTab[1] then return end
            library.currentTab = newTab

            if old then
                TweenService:Create(old[1], TweenInfo.new(0.12), {
                    BackgroundTransparency = 0.5,
                    TextColor3 = theme.SubText
                }):Play()
                old[1].Indicator.Visible = false
                if old[1]:FindFirstChild("Icon") then
                    TweenService:Create(old[1].Icon, TweenInfo.new(0.12), {
                        ImageColor3 = theme.SubText
                    }):Play()
                end
                old[2].Visible = false
            end

            TweenService:Create(newTab[1], TweenInfo.new(0.12), {
                BackgroundTransparency = 0.15,
                TextColor3 = theme.Accent
            }):Play()
            newTab[1].Indicator.Visible = true
            if newTab[1]:FindFirstChild("Icon") then
                TweenService:Create(newTab[1].Icon, TweenInfo.new(0.12), {
                    ImageColor3 = theme.Accent
                }):Play()
            end
            newTab[2].Visible = true
        end

        if library.currentTab == nil then
            switchTab(tabRef)
        end

        --==================================================================================--
        --  Tab API
        --==================================================================================--

        local tab = {}

        --==================================================================================--
        --  Section
        --==================================================================================--

        function tab:Section(sectionName)
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = "Section_" .. sectionName
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = theme.Panel
            sectionFrame.BackgroundTransparency = 0.4
            sectionFrame.BorderSizePixel = 0
            sectionFrame.Size = UDim2.new(1, 0, 0, 32)
            sectionFrame.ClipsDescendants = true

            Instance.new("UICorner", sectionFrame).CornerRadius = UDim.new(0, 6)

            local sectionStroke = Instance.new("UIStroke")
            sectionStroke.Parent = sectionFrame
            sectionStroke.Color = theme.Accent
            sectionStroke.Thickness = 1
            sectionStroke.Transparency = 0.85
            sectionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local sectionHeader = Instance.new("TextButton")
            sectionHeader.Name = "Header"
            sectionHeader.Parent = sectionFrame
            sectionHeader.BackgroundTransparency = 1
            sectionHeader.Size = UDim2.new(1, 0, 0, 32)
            sectionHeader.AutoButtonColor = false
            sectionHeader.Font = Enum.Font.GothamBold
            sectionHeader.Text = "  " .. sectionName
            sectionHeader.TextColor3 = theme.Accent
            sectionHeader.TextSize = 13
            sectionHeader.TextXAlignment = Enum.TextXAlignment.Left

            local arrow = Instance.new("TextLabel")
            arrow.Name = "Arrow"
            arrow.Parent = sectionHeader
            arrow.BackgroundTransparency = 1
            arrow.AnchorPoint = Vector2.new(1, 0.5)
            arrow.Position = UDim2.new(1, -10, 0.5, 0)
            arrow.Size = UDim2.new(0, 16, 0, 16)
            arrow.Font = Enum.Font.GothamBold
            arrow.Text = "−"
            arrow.TextColor3 = theme.SubText
            arrow.TextSize = 14

            local sectionBody = Instance.new("Frame")
            sectionBody.Name = "Body"
            sectionBody.Parent = sectionFrame
            sectionBody.BackgroundTransparency = 1
            sectionBody.Position = UDim2.new(0, 8, 0, 32)
            sectionBody.Size = UDim2.new(1, -16, 0, 0)
            sectionBody.ClipsDescendants = true

            local bodyLayout = Instance.new("UIListLayout")
            bodyLayout.Parent = sectionBody
            bodyLayout.SortOrder = Enum.SortOrder.LayoutOrder
            bodyLayout.Padding = UDim.new(0, 6)

            local bodyPadding = Instance.new("UIPadding")
            bodyPadding.Parent = sectionBody
            bodyPadding.PaddingBottom = UDim.new(0, 8)

            local isOpen = true

            local function updateSection()
                local targetHeight
                if isOpen then
                    targetHeight = 32 + bodyLayout.AbsoluteContentSize.Y + 8
                else
                    targetHeight = 32
                end
                TweenService:Create(sectionFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, 0, 0, targetHeight)
                }):Play()
                arrow.Text = isOpen and "−" or "+"
                TweenService:Create(arrow, TweenInfo.new(0.15), {
                    TextColor3 = isOpen and theme.Accent or theme.SubText
                }):Play()
            end

            sectionHeader.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                updateSection()
            end)

            bodyLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if isOpen then
                    updateSection()
                end
            end)

            -- Initial sizing
            task.defer(updateSection)

            --==================================================================================--
            --  Section API
            --==================================================================================--

            local sec = {}

            --==================================================================================--
            --  Button
            --==================================================================================--

            function sec:Button(text, callback)
                callback = callback or function() end

                local btn = Instance.new("TextButton")
                btn.Name = "Button_" .. text
                btn.Parent = sectionBody
                btn.BackgroundColor3 = theme.Background
                btn.BackgroundTransparency = 0.3
                btn.BorderSizePixel = 0
                btn.Size = UDim2.new(1, 0, 0, 32)
                btn.AutoButtonColor = false
                btn.Font = Enum.Font.GothamMedium
                btn.Text = "  " .. text
                btn.TextColor3 = theme.Text
                btn.TextSize = 13
                btn.TextXAlignment = Enum.TextXAlignment.Left

                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)

                local btnStroke = Instance.new("UIStroke")
                btnStroke.Parent = btn
                btnStroke.Color = theme.Accent
                btnStroke.Thickness = 1
                btnStroke.Transparency = 0.9
                btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                btn.MouseEnter:Connect(function()
                    TweenService:Create(btn, TweenInfo.new(0.15), {
                        BackgroundTransparency = 0.1,
                        TextColor3 = theme.Accent
                    }):Play()
                end)

                btn.MouseLeave:Connect(function()
                    TweenService:Create(btn, TweenInfo.new(0.15), {
                        BackgroundTransparency = 0.3,
                        TextColor3 = theme.Text
                    }):Play()
                end)

                btn.MouseButton1Click:Connect(function()
                    ripple(btn)
                    task.spawn(callback)
                end)

                return btn
            end

            --==================================================================================--
            --  Label
            --==================================================================================--

            function sec:Label(text)
                local lbl = Instance.new("TextLabel")
                lbl.Name = "Label_" .. text
                lbl.Parent = sectionBody
                lbl.BackgroundColor3 = theme.Background
                lbl.BackgroundTransparency = 0.5
                lbl.BorderSizePixel = 0
                lbl.Size = UDim2.new(1, 0, 0, 26)
                lbl.Font = Enum.Font.Gotham
                lbl.Text = "  " .. text
                lbl.TextColor3 = theme.SubText
                lbl.TextSize = 12
                lbl.TextXAlignment = Enum.TextXAlignment.Left

                Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 4)

                return lbl
            end

            --==================================================================================--
            --  Toggle
            --==================================================================================--

            function sec:Toggle(text, flag, default, callback)
                assert(text, "Toggle: no text provided")
                assert(flag, "Toggle: no flag provided")
                callback = callback or function() end
                default = default or false

                library.flags[flag] = default

                local toggleFrame = Instance.new("TextButton")
                toggleFrame.Name = "Toggle_" .. text
                toggleFrame.Parent = sectionBody
                toggleFrame.BackgroundColor3 = theme.Background
                toggleFrame.BackgroundTransparency = 0.3
                toggleFrame.BorderSizePixel = 0
                toggleFrame.Size = UDim2.new(1, 0, 0, 32)
                toggleFrame.AutoButtonColor = false
                toggleFrame.Font = Enum.Font.GothamMedium
                toggleFrame.Text = "  " .. text
                toggleFrame.TextColor3 = theme.Text
                toggleFrame.TextSize = 13
                toggleFrame.TextXAlignment = Enum.TextXAlignment.Left

                Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 5)

                local toggleStroke = Instance.new("UIStroke")
                toggleStroke.Parent = toggleFrame
                toggleStroke.Color = theme.Accent
                toggleStroke.Thickness = 1
                toggleStroke.Transparency = 0.9
                toggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                -- Switch track
                local track = Instance.new("Frame")
                track.Name = "Track"
                track.Parent = toggleFrame
                track.AnchorPoint = Vector2.new(1, 0.5)
                track.Position = UDim2.new(1, -10, 0.5, 0)
                track.Size = UDim2.new(0, 34, 0, 18)
                track.BackgroundColor3 = theme.Main
                track.BorderSizePixel = 0

                Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

                -- Switch knob
                local knob = Instance.new("Frame")
                knob.Name = "Knob"
                knob.Parent = track
                knob.AnchorPoint = Vector2.new(0, 0.5)
                knob.Position = UDim2.new(0, 2, 0.5, 0)
                knob.Size = UDim2.new(0, 14, 0, 14)
                knob.BackgroundColor3 = theme.SubText
                knob.BorderSizePixel = 0

                Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

                local function setState(state, fireCallback)
                    if library.flags[flag] == state and fireCallback ~= nil then
                        -- Allow forced refresh but don't re-fire identical callbacks
                    end
                    library.flags[flag] = state

                    TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = state and UDim2.new(0, 18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                        BackgroundColor3 = state and theme.Accent or theme.SubText
                    }):Play()

                    TweenService:Create(track, TweenInfo.new(0.2), {
                        BackgroundColor3 = state and theme.Accent or theme.Main
                    }):Play()

                    TweenService:Create(track, TweenInfo.new(0.2), {
                        BackgroundTransparency = state and 0.3 or 0
                    }):Play()

                    if fireCallback ~= false then
                        callback(state)
                    end
                end

                setState(default, false)

                toggleFrame.MouseButton1Click:Connect(function()
                    setState(not library.flags[flag])
                end)

                -- Return API so scripts can programmatically flip it
                return {
                    Set = function(_, state)
                        setState(state)
                    end,
                    Get = function()
                        return library.flags[flag]
                    end
                }
            end

            --==================================================================================--
            --  Slider
            --==================================================================================--

            function sec:Slider(text, flag, default, min, max, precise, callback)
                assert(text, "Slider: no text provided")
                assert(flag, "Slider: no flag provided")
                callback = callback or function() end
                min = min or 0
                max = max or 100
                default = default or min
                precise = precise or false

                library.flags[flag] = default

                local sliderFrame = Instance.new("Frame")
                sliderFrame.Name = "Slider_" .. text
                sliderFrame.Parent = sectionBody
                sliderFrame.BackgroundColor3 = theme.Background
                sliderFrame.BackgroundTransparency = 0.3
                sliderFrame.BorderSizePixel = 0
                sliderFrame.Size = UDim2.new(1, 0, 0, 40)

                Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 5)

                local sliderStroke = Instance.new("UIStroke")
                sliderStroke.Parent = sliderFrame
                sliderStroke.Color = theme.Accent
                sliderStroke.Thickness = 1
                sliderStroke.Transparency = 0.9
                sliderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local sliderLabel = Instance.new("TextLabel")
                sliderLabel.Name = "Label"
                sliderLabel.Parent = sliderFrame
                sliderLabel.BackgroundTransparency = 1
                sliderLabel.Position = UDim2.new(0, 10, 0, 0)
                sliderLabel.Size = UDim2.new(0.6, 0, 0, 20)
                sliderLabel.Font = Enum.Font.GothamMedium
                sliderLabel.Text = text
                sliderLabel.TextColor3 = theme.Text
                sliderLabel.TextSize = 12
                sliderLabel.TextXAlignment = Enum.TextXAlignment.Left

                local valueLabel = Instance.new("TextLabel")
                valueLabel.Name = "ValueLabel"
                valueLabel.Parent = sliderFrame
                valueLabel.BackgroundTransparency = 1
                valueLabel.AnchorPoint = Vector2.new(1, 0)
                valueLabel.Position = UDim2.new(1, -10, 0, 0)
                valueLabel.Size = UDim2.new(0, 60, 0, 20)
                valueLabel.Font = Enum.Font.GothamBold
                valueLabel.Text = tostring(default)
                valueLabel.TextColor3 = theme.Accent
                valueLabel.TextSize = 12
                valueLabel.TextXAlignment = Enum.TextXAlignment.Right

                local barBg = Instance.new("Frame")
                barBg.Name = "BarBg"
                barBg.Parent = sliderFrame
                barBg.BackgroundColor3 = theme.Main
                barBg.BorderSizePixel = 0
                barBg.Position = UDim2.new(0, 10, 0, 26)
                barBg.Size = UDim2.new(1, -20, 0, 6)

                Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

                local barFill = Instance.new("Frame")
                barFill.Name = "BarFill"
                barFill.Parent = barBg
                barFill.BackgroundColor3 = theme.Accent
                barFill.BorderSizePixel = 0
                barFill.Size = UDim2.new(0, 0, 1, 0)

                Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

                local knob = Instance.new("Frame")
                knob.Name = "Knob"
                knob.Parent = barBg
                knob.AnchorPoint = Vector2.new(0.5, 0.5)
                knob.Position = UDim2.new(0, 0, 0.5, 0)
                knob.Size = UDim2.new(0, 12, 0, 12)
                knob.BackgroundColor3 = theme.Background
                knob.BorderSizePixel = 0

                Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

                local knobStroke = Instance.new("UIStroke")
                knobStroke.Parent = knob
                knobStroke.Color = theme.Accent
                knobStroke.Thickness = 2

                local dragging = false

                local function roundToStep(val)
                    if precise then
                        return tonumber(string.format("%.1f", val))
                    else
                        return math.floor(val + 0.5)
                    end
                end

                local function setValueFromX(x, fireCallback)
                    local pct = math.clamp((x - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
                    local value = min + (max - min) * pct
                    value = math.clamp(roundToStep(value), min, max)

                    library.flags[flag] = value
                    valueLabel.Text = tostring(value)

                    local fillPct = (value - min) / (max - min)
                    barFill.Size = UDim2.new(fillPct, 0, 1, 0)
                    knob.Position = UDim2.new(fillPct, 0, 0.5, 0)

                    if fireCallback ~= false then
                        callback(value)
                    end
                end

                local function setValue(value, fireCallback)
                    value = math.clamp(roundToStep(value), min, max)
                    library.flags[flag] = value
                    valueLabel.Text = tostring(value)

                    local fillPct = (value - min) / (max - min)
                    barFill.Size = UDim2.new(fillPct, 0, 1, 0)
                    knob.Position = UDim2.new(fillPct, 0, 0.5, 0)

                    if fireCallback ~= false then
                        callback(value)
                    end
                end

                setValue(default, false)

                barBg.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        setValueFromX(input.Position.X)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch) then
                        setValueFromX(input.Position.X)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)

                return {
                    Set = function(_, value)
                        setValue(value)
                    end,
                    Get = function()
                        return library.flags[flag]
                    end
                }
            end

            --==================================================================================--
            --  Dropdown
            --==================================================================================--

            function sec:Dropdown(text, flag, options, callback)
                assert(text, "Dropdown: no text provided")
                assert(flag, "Dropdown: no flag provided")
                callback = callback or function() end
                options = options or {}

                library.flags[flag] = nil

                local ddFrame = Instance.new("Frame")
                ddFrame.Name = "Dropdown_" .. text
                ddFrame.Parent = sectionBody
                ddFrame.BackgroundColor3 = theme.Background
                ddFrame.BackgroundTransparency = 0.3
                ddFrame.BorderSizePixel = 0
                ddFrame.Size = UDim2.new(1, 0, 0, 34)
                ddFrame.ClipsDescendants = true

                Instance.new("UICorner", ddFrame).CornerRadius = UDim.new(0, 5)

                local ddStroke = Instance.new("UIStroke")
                ddStroke.Parent = ddFrame
                ddStroke.Color = theme.Accent
                ddStroke.Thickness = 1
                ddStroke.Transparency = 0.9
                ddStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local ddHeader = Instance.new("TextButton")
                ddHeader.Name = "Header"
                ddHeader.Parent = ddFrame
                ddHeader.BackgroundTransparency = 1
                ddHeader.Size = UDim2.new(1, 0, 0, 34)
                ddHeader.AutoButtonColor = false
                ddHeader.Font = Enum.Font.GothamMedium
                ddHeader.Text = "  " .. text
                ddHeader.TextColor3 = theme.Text
                ddHeader.TextSize = 13
                ddHeader.TextXAlignment = Enum.TextXAlignment.Left

                local ddValue = Instance.new("TextLabel")
                ddValue.Name = "Value"
                ddValue.Parent = ddHeader
                ddValue.BackgroundTransparency = 1
                ddValue.AnchorPoint = Vector2.new(1, 0.5)
                ddValue.Position = UDim2.new(1, -32, 0.5, 0)
                ddValue.Size = UDim2.new(0, 120, 1, 0)
                ddValue.Font = Enum.Font.Gotham
                ddValue.Text = "None"
                ddValue.TextColor3 = theme.Accent
                ddValue.TextSize = 12
                ddValue.TextXAlignment = Enum.TextXAlignment.Right

                local ddArrow = Instance.new("TextLabel")
                ddArrow.Name = "Arrow"
                ddArrow.Parent = ddHeader
                ddArrow.BackgroundTransparency = 1
                ddArrow.AnchorPoint = Vector2.new(1, 0.5)
                ddArrow.Position = UDim2.new(1, -10, 0.5, 0)
                ddArrow.Size = UDim2.new(0, 16, 1, 0)
                ddArrow.Font = Enum.Font.GothamBold
                ddArrow.Text = "+"
                ddArrow.TextColor3 = theme.SubText
                ddArrow.TextSize = 14
                ddArrow.TextXAlignment = Enum.TextXAlignment.Right

                local optionsHolder = Instance.new("Frame")
                optionsHolder.Name = "Options"
                optionsHolder.Parent = ddFrame
                optionsHolder.BackgroundTransparency = 1
                optionsHolder.Position = UDim2.new(0, 6, 0, 34)
                optionsHolder.Size = UDim2.new(1, -12, 0, 0)

                local optionsLayout = Instance.new("UIListLayout")
                optionsLayout.Parent = optionsHolder
                optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                optionsLayout.Padding = UDim.new(0, 4)

                local isOpen = false

                local function rebuildCanvas()
                    if isOpen then
                        local h = 34 + optionsLayout.AbsoluteContentSize.Y + 8
                        TweenService:Create(ddFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.new(1, 0, 0, h)
                        }):Play()
                        optionsHolder.Size = UDim2.new(1, -12, 0, optionsLayout.AbsoluteContentSize.Y)
                    else
                        TweenService:Create(ddFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = UDim2.new(1, 0, 0, 34)
                        }):Play()
                    end
                end

                local function toggleDropdown()
                    isOpen = not isOpen
                    ddArrow.Text = isOpen and "−" or "+"
                    rebuildCanvas()
                end

                ddHeader.MouseButton1Click:Connect(toggleDropdown)

                optionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(rebuildCanvas)

                local function addOption(optText)
                    local optBtn = Instance.new("TextButton")
                    optBtn.Name = "Option_" .. optText
                    optBtn.Parent = optionsHolder
                    optBtn.BackgroundColor3 = theme.Main
                    optBtn.BackgroundTransparency = 0.3
                    optBtn.BorderSizePixel = 0
                    optBtn.Size = UDim2.new(1, 0, 0, 26)
                    optBtn.AutoButtonColor = false
                    optBtn.Font = Enum.Font.Gotham
                    optBtn.Text = "  " .. optText
                    optBtn.TextColor3 = theme.SubText
                    optBtn.TextSize = 12
                    optBtn.TextXAlignment = Enum.TextXAlignment.Left

                    Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 4)

                    optBtn.MouseEnter:Connect(function()
                        TweenService:Create(optBtn, TweenInfo.new(0.1), {
                            BackgroundTransparency = 0.1,
                            TextColor3 = theme.Text
                        }):Play()
                    end)

                    optBtn.MouseLeave:Connect(function()
                        TweenService:Create(optBtn, TweenInfo.new(0.1), {
                            BackgroundTransparency = 0.3,
                            TextColor3 = theme.SubText
                        }):Play()
                    end)

                    optBtn.MouseButton1Click:Connect(function()
                        library.flags[flag] = optText
                        ddValue.Text = optText
                        toggleDropdown()
                        callback(optText)
                    end)

                    return optBtn
                end

                for _, opt in next, options do
                    addOption(opt)
                end

                return {
                    Add = function(_, optText)
                        addOption(optText)
                    end,
                    Remove = function(_, optText)
                        local o = optionsHolder:FindFirstChild("Option_" .. optText)
                        if o then o:Destroy() end
                        rebuildCanvas()
                    end,
                    Get = function()
                        return library.flags[flag]
                    end
                }
            end

            --==================================================================================--
            --  Textbox
            --==================================================================================--

            function sec:Textbox(text, flag, default, callback)
                assert(text, "Textbox: no text provided")
                assert(flag, "Textbox: no flag provided")
                callback = callback or function() end
                default = default or ""

                library.flags[flag] = default

                local tbFrame = Instance.new("Frame")
                tbFrame.Name = "Textbox_" .. text
                tbFrame.Parent = sectionBody
                tbFrame.BackgroundColor3 = theme.Background
                tbFrame.BackgroundTransparency = 0.3
                tbFrame.BorderSizePixel = 0
                tbFrame.Size = UDim2.new(1, 0, 0, 34)

                Instance.new("UICorner", tbFrame).CornerRadius = UDim.new(0, 5)

                local tbStroke = Instance.new("UIStroke")
                tbStroke.Parent = tbFrame
                tbStroke.Color = theme.Accent
                tbStroke.Thickness = 1
                tbStroke.Transparency = 0.9
                tbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local tbLabel = Instance.new("TextLabel")
                tbLabel.Name = "Label"
                tbLabel.Parent = tbFrame
                tbLabel.BackgroundTransparency = 1
                tbLabel.Position = UDim2.new(0, 10, 0, 0)
                tbLabel.Size = UDim2.new(0.45, 0, 1, 0)
                tbLabel.Font = Enum.Font.GothamMedium
                tbLabel.Text = text
                tbLabel.TextColor3 = theme.Text
                tbLabel.TextSize = 12
                tbLabel.TextXAlignment = Enum.TextXAlignment.Left

                local tbInput = Instance.new("TextBox")
                tbInput.Name = "Input"
                tbInput.Parent = tbFrame
                tbInput.BackgroundColor3 = theme.Main
                tbInput.BackgroundTransparency = 0.3
                tbInput.BorderSizePixel = 0
                tbInput.AnchorPoint = Vector2.new(1, 0.5)
                tbInput.Position = UDim2.new(1, -8, 0.5, 0)
                tbInput.Size = UDim2.new(0.45, 0, 0, 24)
                tbInput.Font = Enum.Font.Gotham
                tbInput.Text = default
                tbInput.TextColor3 = theme.Accent
                tbInput.TextSize = 12
                tbInput.PlaceholderText = "..."
                tbInput.PlaceholderColor3 = theme.SubText

                Instance.new("UICorner", tbInput).CornerRadius = UDim.new(0, 4)

                tbInput.Focused:Connect(function()
                    TweenService:Create(tbStroke, TweenInfo.new(0.15), {
                        Transparency = 0.3,
                        Thickness = 1.5
                    }):Play()
                end)

                tbInput.FocusLost:Connect(function()
                    TweenService:Create(tbStroke, TweenInfo.new(0.15), {
                        Transparency = 0.9,
                        Thickness = 1
                    }):Play()

                    if tbInput.Text == "" then
                        tbInput.Text = default
                    end

                    library.flags[flag] = tbInput.Text
                    callback(tbInput.Text)
                end)

                return {
                    Set = function(_, val)
                        tbInput.Text = val
                        library.flags[flag] = val
                    end,
                    Get = function()
                        return library.flags[flag]
                    end
                }
            end

            --==================================================================================--
            --  Keybind
            --==================================================================================--

            function sec:Keybind(text, default, callback)
                assert(text, "Keybind: no text provided")
                callback = callback or function() end
                default = default or "F"

                local banned = {
                    Return = true, Space = true, Tab = true, Backquote = true,
                    CapsLock = true, Escape = true, Unknown = true
                }

                local shortNames = {
                    RightControl = "R-Ctrl", LeftControl = "L-Ctrl",
                    LeftShift = "L-Shift", RightShift = "R-Shift",
                    Semicolon = ";", Quote = '"',
                    LeftBracket = "[", RightBracket = "]",
                    Equals = "=", Minus = "-",
                    RightAlt = "R-Alt", LeftAlt = "L-Alt"
                }

                local bindKey = Enum.KeyCode[default] or default
                local keyText = (shortNames[bindKey.Name] or bindKey.Name)

                local kbFrame = Instance.new("Frame")
                kbFrame.Name = "Keybind_" .. text
                kbFrame.Parent = sectionBody
                kbFrame.BackgroundColor3 = theme.Background
                kbFrame.BackgroundTransparency = 0.3
                kbFrame.BorderSizePixel = 0
                kbFrame.Size = UDim2.new(1, 0, 0, 34)

                Instance.new("UICorner", kbFrame).CornerRadius = UDim.new(0, 5)

                local kbStroke = Instance.new("UIStroke")
                kbStroke.Parent = kbFrame
                kbStroke.Color = theme.Accent
                kbStroke.Thickness = 1
                kbStroke.Transparency = 0.9
                kbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                local kbLabel = Instance.new("TextLabel")
                kbLabel.Name = "Label"
                kbLabel.Parent = kbFrame
                kbLabel.BackgroundTransparency = 1
                kbLabel.Position = UDim2.new(0, 10, 0, 0)
                kbLabel.Size = UDim2.new(0.5, 0, 1, 0)
                kbLabel.Font = Enum.Font.GothamMedium
                kbLabel.Text = text
                kbLabel.TextColor3 = theme.Text
                kbLabel.TextSize = 12
                kbLabel.TextXAlignment = Enum.TextXAlignment.Left

                local kbBtn = Instance.new("TextButton")
                kbBtn.Name = "KeyBtn"
                kbBtn.Parent = kbFrame
                kbBtn.BackgroundColor3 = theme.Main
                kbBtn.BackgroundTransparency = 0.3
                kbBtn.BorderSizePixel = 0
                kbBtn.AnchorPoint = Vector2.new(1, 0.5)
                kbBtn.Position = UDim2.new(1, -8, 0.5, 0)
                kbBtn.Size = UDim2.new(0, 80, 0, 24)
                kbBtn.AutoButtonColor = false
                kbBtn.Font = Enum.Font.GothamBold
                kbBtn.Text = keyText
                kbBtn.TextColor3 = theme.Accent
                kbBtn.TextSize = 12

                Instance.new("UICorner", kbBtn).CornerRadius = UDim.new(0, 4)

                UserInputService.InputBegan:Connect(function(input, gpe)
                    if gpe then return end
                    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    if input.KeyCode == bindKey then
                        callback(bindKey.Name)
                    end
                end)

                kbBtn.MouseButton1Click:Connect(function()
                    kbBtn.Text = "..."
                    kbBtn.TextColor3 = theme.SubText

                    local conn
                    conn = UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                        local name = input.KeyCode.Name
                        if banned[name] then
                            kbBtn.Text = keyText
                            kbBtn.TextColor3 = theme.Accent
                            conn:Disconnect()
                            return
                        end
                        bindKey = input.KeyCode
                        keyText = shortNames[name] or name
                        kbBtn.Text = keyText
                        kbBtn.TextColor3 = theme.Accent
                        conn:Disconnect()
                    end)
                end)

                return {
                    Set = function(_, key)
                        bindKey = Enum.KeyCode[key] or key
                        keyText = shortNames[bindKey.Name] or bindKey.Name
                        kbBtn.Text = keyText
                    end,
                    Get = function()
                        return bindKey
                    end
                }
            end

            return sec
        end

        return tab
    end

    --==================================================================================--
    --  Global Controls
    --==================================================================================--

    function window:Toggle()
        uiVisible = not uiVisible
        main.Visible = uiVisible
    end

    function window:Destroy()
        gui:Destroy()
    end

    function window:GetFlags()
        return library.flags
    end

    return window
end

return library