repeat
    task.wait()
until game:IsLoaded()

local Library = {}
local UIHidden = false
Library.currentTab = nil
Library.flags = {}

local Services = setmetatable({}, {
    __index = function(_, serviceName)
        return game:GetService(serviceName)
    end
})

local PlayerMouse = Services.Players.LocalPlayer:GetMouse()

function Tween(instance, tweenInfo, properties)
    Services.TweenService:Create(instance, TweenInfo.new(tweenInfo[1], Enum.EasingStyle[tweenInfo[2]], Enum.EasingDirection[tweenInfo[3]]), properties):Play()
    return true
end

function Ripple(button)
    spawn(function()
        if button.ClipsDescendants ~= true then
            button.ClipsDescendants = true
        end
        
        local ripple = Instance.new("ImageLabel")
        ripple.Name = "Ripple"
        ripple.Parent = button
        ripple.BackgroundColor3 = Color3.fromRGB(135, 206, 235)
        ripple.BackgroundTransparency = 1
        ripple.ZIndex = 8
        ripple.Image = "rbxassetid://123097590035361"
        ripple.ImageTransparency = 0.8
        ripple.ScaleType = Enum.ScaleType.Fit
        ripple.ImageColor3 = Color3.fromRGB(135, 206, 235)
        ripple.Position = UDim2.new(
            (PlayerMouse.X - ripple.AbsolutePosition.X) / button.AbsoluteSize.X, 0,
            (PlayerMouse.Y - ripple.AbsolutePosition.Y) / button.AbsoluteSize.Y, 0
        )
        
        Tween(ripple, {0.3, "Linear", "InOut"}, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0)
        })
        
        wait(0.15)
        Tween(ripple, {0.3, "Linear", "InOut"}, {
            ImageTransparency = 1
        })
        
        wait(0.3)
        ripple:Destroy()
    end)
end

local UIExpanded = false
local SwitchingTab = false

function switchTab(tab)
    if SwitchingTab then
        return
    else
        local current = Library.currentTab
        if current == nil then
            tab[2].Visible = true
            Library.currentTab = tab
            Services.TweenService:Create(tab[1], TweenInfo.new(0.1), {
                ImageTransparency = 0
            }):Play()
            Services.TweenService:Create(tab[1].TabText, TweenInfo.new(0.1), {
                TextTransparency = 0
            }):Play()
            return
        elseif current[1] ~= tab[1] then
            SwitchingTab = true
            Library.currentTab = tab
            
            Services.TweenService:Create(current[1], TweenInfo.new(0.1), {
                ImageTransparency = 0.2
            }):Play()
            Services.TweenService:Create(tab[1], TweenInfo.new(0.1), {
                ImageTransparency = 0
            }):Play()
            Services.TweenService:Create(current[1].TabText, TweenInfo.new(0.1), {
                TextTransparency = 0.2
            }):Play()
            Services.TweenService:Create(tab[1].TabText, TweenInfo.new(0.1), {
                TextTransparency = 0
            }):Play()
            
            current[2].Visible = false
            tab[2].Visible = true
            task.wait(0.1)
            SwitchingTab = false
        end
    end
end

function drag(draggable, handle)
    local dragging = nil
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    local function update(input)
        local delta = input.Position - dragStart
        draggable.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    (handle or draggable).InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = draggable.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    draggable.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function Library.new(theme, title, style)
    for _, child in pairs(Services.CoreGui:GetChildren()) do
        if child.Name == "frosty" then
            child:Destroy()
        end
    end
    
    -- 青蓝色主题配置
    local ALTransparency = 0.6
    local ALcolor = Color3.fromRGB(255, 255, 255) -- 白色文本，在青蓝背景下更清晰
    local MainColor, Background, zyColor, beijingColor
    
    -- 青蓝色主题
    local SkyBlue = Color3.fromRGB(135, 206, 235)
    local DarkSkyBlue = Color3.fromRGB(70, 130, 180)
    local LightSkyBlue = Color3.fromRGB(173, 216, 230)
    local VeryDarkSkyBlue = Color3.fromRGB(30, 80, 120)
    
    if style == "dark" then
        MainColor = VeryDarkSkyBlue
        Background = VeryDarkSkyBlue
        zyColor = DarkSkyBlue
        beijingColor = SkyBlue
    else
        MainColor = SkyBlue
        Background = LightSkyBlue
        zyColor = SkyBlue
        beijingColor = DarkSkyBlue
    end
    
    local MainGUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local SideBar = Instance.new("Frame")
    local SideBarCorner = Instance.new("UICorner")
    local SidePanel = Instance.new("Frame")
    local SideGradient = Instance.new("UIGradient")
    local TabButtonsScroll = Instance.new("ScrollingFrame")
    local TabButtonsLayout = Instance.new("UIListLayout")
    local TitleLabel = Instance.new("TextLabel")
    local TitleGradient = Instance.new("UIGradient")
    local ToggleButton = Instance.new("ImageButton")
    local ToggleGradient = Instance.new("UIGradient")
    local ShadowHolder = Instance.new("Frame")
    local Shadow = Instance.new("ImageLabel")
    local ShadowCorner = Instance.new("UICorner")
    local ShadowGradient1 = Instance.new("UIGradient")
    local ShadowGradient2 = Instance.new("UIGradient")
    local RippleContainer = Instance.new("Frame")
    local RippleCorner1 = Instance.new("UICorner")
    local RippleCorner2 = Instance.new("UICorner")
    
    if syn and syn.protect_gui then
        syn.protect_gui(MainGUI)
    end
    
    MainGUI.Name = "frosty"
    MainGUI.Parent = Services.CoreGui
    
    function UiDestroy()
        MainGUI:Destroy()
    end
    
    function ToggleUILib()
        if UIHidden then
            UIHidden = false
            MainGUI.Enabled = true
        else
            MainGUI.Enabled = false
            UIHidden = true
        end
    end
    
    MainFrame.Name = "Main"
    MainFrame.Parent = MainGUI
    MainFrame.Name = "Main"
    MainFrame.ClipsDescendants = true
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Background
    MainFrame.BorderColor3 = MainColor
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 572, 0, 353)
    MainFrame.ZIndex = 1
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Transparency = 0
    
    Services.UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
    
    drag(MainFrame)
    
    ShadowCorner.Parent = MainFrame
    ShadowCorner.CornerRadius = UDim.new(0, 10)
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(220, 20, 60) -- 深红色关闭按钮
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.ZIndex = 5
    CloseButton.TextTransparency = 0
    CloseButton.MouseButton1Click:Connect(function()
        MainGUI:Destroy()
    end)
    
    ShadowHolder.Name = "DropShadowHolder"
    ShadowHolder.Parent = MainFrame
    ShadowHolder.BackgroundTransparency = 1
    ShadowHolder.BorderSizePixel = 0
    ShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    ShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
    ShadowHolder.ZIndex = 0
    
    Shadow.Name = "DropShadow"
    Shadow.Parent = ShadowHolder
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, -10, 1, -10)
    Shadow.ZIndex = -1
    Shadow.Image = "rbxassetid://118534129318519"
    Shadow.ImageColor3 = SkyBlue -- 青蓝色阴影
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    local BackgroundImage = Instance.new("ImageLabel")
    BackgroundImage.Name = "BackgroundImage"
    BackgroundImage.Image = "rbxassetid://你的图片ID"
    BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
    BackgroundImage.BackgroundTransparency = 1
    BackgroundImage.ZIndex = -1
    BackgroundImage.Parent = MainFrame
    
    local BackgroundCorner = Instance.new("UICorner")
    BackgroundCorner.CornerRadius = UDim.new(0, 10)
    BackgroundCorner.Parent = BackgroundImage
    
    -- 青蓝色渐变阴影
    ShadowGradient1.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 206, 235)),
        ColorSequenceKeypoint.new(0.1, Color3.fromRGB(173, 216, 230)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(176, 224, 230)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(135, 206, 235)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(70, 130, 180)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 149, 237)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(30, 144, 255)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(135, 206, 235)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(173, 216, 230)),
        ColorSequenceKeypoint.new(0.9, Color3.fromRGB(176, 224, 230)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 206, 235))
    })
    
    game:GetService("TweenService"):Create(ShadowGradient1, TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {
        Rotation = 360
    }):Play()
    
    function toggleui()
        UIExpanded = not UIExpanded
        spawn(function()
            if UIExpanded then
                wait(0.3)
            end
        end)
        Tween(MainFrame, {0.3, "Sine", "InOut"}, {
            Size = UDim2.new(0, 609, 0, UIExpanded and 505 or 353)
        })
    end
    
    TabContainer.Name = "TabMain"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = SkyBlue
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0.217000037, 0, 0, 3)
    TabContainer.Size = UDim2.new(0, 448, 0, 353)
    TabContainer.Transparency = 1
    
    MainCorner.CornerRadius = UDim.new(0, 5.5)
    MainCorner.Name = "MainC"
    MainCorner.Parent = RippleContainer
    
    SideBar.Name = "SB"
    SideBar.Parent = MainFrame
    SideBar.BackgroundColor3 = SkyBlue
    SideBar.BorderColor3 = MainColor
    SideBar.Size = UDim2.new(0, 8, 0, 353)
    SideBar.Transparency = 0
    
    SideBarCorner.CornerRadius = UDim.new(0, 6)
    SideBarCorner.Name = "SBC"
    SideBarCorner.Parent = SideBar
    
    SidePanel.Name = "Side"
    SidePanel.Parent = SideBar
    SidePanel.BackgroundColor3 = SkyBlue
    SidePanel.BorderColor3 = SkyBlue
    SidePanel.BorderSizePixel = 0
    SidePanel.ClipsDescendants = true
    SidePanel.Position = UDim2.new(1, 0, 0, 0)
    SidePanel.Size = UDim2.new(0, 110, 0, 353)
    SidePanel.Transparency = 0
    
    SideGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, DarkSkyBlue),
        ColorSequenceKeypoint.new(1, SkyBlue)
    })
    SideGradient.Rotation = 90
    SideGradient.Name = "SideG"
    SideGradient.Parent = SidePanel
    
    TabButtonsScroll.Name = "TabBtns"
    TabButtonsScroll.Parent = SidePanel
    TabButtonsScroll.Active = true
    TabButtonsScroll.BackgroundColor3 = SkyBlue
    TabButtonsScroll.BackgroundTransparency = 1
    TabButtonsScroll.BorderSizePixel = 0
    TabButtonsScroll.Position = UDim2.new(0, 0, 0.0973535776, 0)
    TabButtonsScroll.Size = UDim2.new(0, 110, 0, 318)
    TabButtonsScroll.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabButtonsScroll.ScrollBarThickness = 0
    
    TabButtonsLayout.Name = "TabBtnsL"
    TabButtonsLayout.Parent = TabButtonsScroll
    TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabButtonsLayout.Padding = UDim.new(0, 12)
    
    TitleLabel.Name = "ScriptTitle"
    TitleLabel.Parent = SidePanel
    TitleLabel.BackgroundColor3 = SkyBlue
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 0, 0.00953488424, 0)
    TitleLabel.Size = UDim2.new(0, 102, 0, 20)
    TitleLabel.Font = Enum.Font.GothamSemibold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色标题
    TitleLabel.TextSize = 14
    TitleLabel.TextScaled = true
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    ShadowGradient2.Parent = TitleLabel
    
    coroutine.wrap(function()
        local titleGradient = TitleLabel.UIGradient
        local titleTween = game:GetService("TweenService"):Create(titleGradient, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(1, 0)
        })
        local startOffset = Vector2.new(-1, 0)
        local colorPalette = {}
        local createColorSequence = ColorSequence.new
        local createKeypoint = ColorSequenceKeypoint.new
        local direction = "down"
        
        -- 青蓝色系渐变
        table.insert(colorPalette, Color3.fromRGB(173, 216, 230)) -- 淡青色
        table.insert(colorPalette, Color3.fromRGB(135, 206, 235)) -- 天蓝色
        table.insert(colorPalette, Color3.fromRGB(176, 224, 230)) -- 淡蓝
        table.insert(colorPalette, Color3.fromRGB(70, 130, 180))  -- 钢青色
        table.insert(colorPalette, Color3.fromRGB(100, 149, 237)) -- 矢车菊蓝
        table.insert(colorPalette, Color3.fromRGB(30, 144, 255))  -- 道奇蓝
        table.insert(colorPalette, Color3.fromRGB(0, 191, 255))   -- 深天蓝
        
        titleGradient.Offset = startOffset
        
        titleGradient.Color = createColorSequence({
            createKeypoint(0, colorPalette[#colorPalette]),
            createKeypoint(0.5, colorPalette[#colorPalette - 1]),
            createKeypoint(1, colorPalette[#colorPalette - 2])
        })
        
        local currentIndex = #colorPalette
        
        local function animateGradient()
            titleTween:Play()
            titleTween.Completed:Wait()
            titleGradient.Offset = startOffset
            titleGradient.Rotation = 180
            
            if currentIndex ~= #colorPalette - 1 or direction ~= "down" then
                if currentIndex ~= #colorPalette or direction ~= "down" then
                    if currentIndex <= #colorPalette - 2 and direction == "down" then
                        titleGradient.Color = createColorSequence({
                            createKeypoint(0, titleGradient.Color.Keypoints[1].Value),
                            createKeypoint(0.5, colorPalette[currentIndex + 1]),
                            createKeypoint(1, colorPalette[currentIndex + 2])
                        })
                        currentIndex = currentIndex + 2
                        direction = "up"
                    end
                else
                    titleGradient.Color = createColorSequence({
                        createKeypoint(0, titleGradient.Color.Keypoints[1].Value),
                        createKeypoint(0.5, colorPalette[1]),
                        createKeypoint(1, colorPalette[2])
                    })
                    currentIndex = 2
                    direction = "up"
                end
            else
                titleGradient.Color = createColorSequence({
                    createKeypoint(0, titleGradient.Color.Keypoints[1].Value),
                    createKeypoint(0.5, colorPalette[#colorPalette]),
                    createKeypoint(1, colorPalette[1])
                })
                currentIndex = 1
                direction = "up"
            end
            
            titleTween:Play()
            titleTween.Completed:Wait()
            titleGradient.Offset = startOffset
            titleGradient.Rotation = 0
            
            if currentIndex ~= #colorPalette - 1 or direction ~= "up" then
                if currentIndex ~= #colorPalette or direction ~= "up" then
                    if currentIndex <= #colorPalette - 2 and direction == "up" then
                        titleGradient.Color = createColorSequence({
                            createKeypoint(0, colorPalette[currentIndex + 2]),
                            createKeypoint(0.5, colorPalette[currentIndex + 1]),
                            createKeypoint(1, titleGradient.Color.Keypoints[3].Value)
                        })
                        currentIndex = currentIndex + 2
                        direction = "down"
                    end
                else
                    titleGradient.Color = createColorSequence({
                        createKeypoint(0, colorPalette[2]),
                        createKeypoint(0.5, colorPalette[1]),
                        createKeypoint(1, titleGradient.Color.Keypoints[3].Value)
                    })
                    currentIndex = 2
                    direction = "down"
                end
            else
                titleGradient.Color = createColorSequence({
                    createKeypoint(0, colorPalette[1]),
                    createKeypoint(0.5, colorPalette[#colorPalette]),
                    createKeypoint(1, titleGradient.Color.Keypoints[3].Value)
                })
                currentIndex = 1
                direction = "down"
            end
            
            animateGradient()
        end
        
        animateGradient()
    end)()
    
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, SkyBlue),
        ColorSequenceKeypoint.new(1, DarkSkyBlue)
    })
    TitleGradient.Rotation = 90
    TitleGradient.Name = "SBG"
    TitleGradient.Parent = SideBar
    
    TabButtonsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabButtonsScroll.CanvasSize = UDim2.new(0, 0, 0, TabButtonsLayout.AbsoluteContentSize.Y + 18)
    end)
    
    RippleContainer.Parent = MainGUI
    RippleContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RippleContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    RippleContainer.BorderSizePixel = 0
    RippleContainer.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
    RippleContainer.Size = UDim2.new(0, 50, 0, 50)
    RippleContainer.BackgroundTransparency = 1
    
    RippleCorner1.CornerRadius = UDim.new(0, 90)
    RippleCorner1.Parent = RippleContainer
    
    ToggleButton.Parent = RippleContainer
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BorderColor3 = SkyBlue
    ToggleButton.BorderSizePixel = 2
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Active = true
    ToggleButton.Draggable = true
    ToggleButton.Image = "rbxassetid://123097590035361"
    ToggleButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        ToggleButton.Image = MainFrame.Visible and "rbxassetid://125169554049330" or "rbxassetid://78614661389908"
    end)
    
    RippleCorner2.CornerRadius = UDim.new(0, 90)
    RippleCorner2.Parent = ToggleButton
    
    ToggleGradient.Parent = ToggleButton
    
    return {
        Tab = function(_, tabName, tabIcon)
            local TabFrame = Instance.new("ScrollingFrame")
            local TabIconLabel = Instance.new("ImageLabel")
            local TabTextLabel = Instance.new("TextLabel")
            local TabButton = Instance.new("TextButton")
            local TabLayout = Instance.new("UIListLayout")
            
            TabFrame.Name = "Tab"
            TabFrame.Parent = TabContainer
            TabFrame.Active = true
            TabFrame.BackgroundColor3 = SkyBlue
            TabFrame.BackgroundTransparency = 1
            TabFrame.Size = UDim2.new(1, 0, 1, 0)
            TabFrame.ScrollBarThickness = 2
            TabFrame.Visible = false
            
            TabIconLabel.Name = "TabIco"
            TabIconLabel.Parent = TabButtonsScroll
            TabIconLabel.BackgroundTransparency = 1
            TabIconLabel.BorderSizePixel = 0
            TabIconLabel.Size = UDim2.new(0, 24, 0, 24)
            
            local defaultIcon = "rbxassetid://123097590035361"
            if defaultIcon then
                tabIcon = defaultIcon
            elseif tabIcon then
                tabIcon = "rbxassetid://" .. tabIcon
            end
            
            TabIconLabel.Image = tabIcon
            TabIconLabel.ImageTransparency = 0.2
            
            TabTextLabel.Name = "TabText"
            TabTextLabel.Parent = TabIconLabel
            TabTextLabel.BackgroundColor3 = SkyBlue
            TabTextLabel.BackgroundTransparency = 1
            TabTextLabel.Position = UDim2.new(1.41666663, 0, 0, 0)
            TabTextLabel.Size = UDim2.new(0, 76, 0, 24)
            TabTextLabel.Font = Enum.Font.GothamSemibold
            TabTextLabel.Text = tabName
            TabTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
            TabTextLabel.TextSize = 14
            TabTextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TabTextLabel.TextTransparency = 0.2
            
            TabButton.Name = "TabBtn"
            TabButton.Parent = TabIconLabel
            TabButton.BackgroundColor3 = SkyBlue
            TabButton.BackgroundTransparency = 1
            TabButton.BorderSizePixel = 0
            TabButton.Size = UDim2.new(0, 110, 0, 24)
            TabButton.AutoButtonColor = false
            TabButton.Font = Enum.Font.SourceSans
            TabButton.Text = ""
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.TextSize = 14
            
            TabLayout.Name = "TabL"
            TabLayout.Parent = TabFrame
            TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
            TabLayout.Padding = UDim.new(0, 4)
            
            TabButton.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(TabButton)
                end)
                local tabData = {TabIconLabel, TabFrame}
                switchTab(tabData)
            end)
            
            if Library.currentTab == nil then
                switchTab({TabIconLabel, TabFrame})
            end
            
            TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 8)
            end)
            
            local clickSound = Instance.new("Sound")
            clickSound.SoundId = "rbxassetid://679786425"
            clickSound.Parent = game.Workspace
            clickSound:Play()

            return {
                section = function(_, sectionName, isOpen)
                    local SectionFrame = Instance.new("Frame")
                    local SectionCorner = Instance.new("UICorner")
                    local SectionText = Instance.new("TextLabel")
                    local SectionOpenIcon = Instance.new("ImageLabel")
                    local SectionOpenedIcon = Instance.new("ImageLabel")
                    local SectionToggle = Instance.new("ImageButton")
                    local ObjectsFrame = Instance.new("Frame")
                    local ObjectsLayout = Instance.new("UIListLayout")
                    
                    SectionFrame.Name = "Section"
                    SectionFrame.Parent = TabFrame
                    SectionFrame.BackgroundColor3 = SkyBlue
                    SectionFrame.BackgroundTransparency = 0.2
                    SectionFrame.BorderSizePixel = 0
                    SectionFrame.ClipsDescendants = true
                    SectionFrame.Size = UDim2.new(0.981000006, 0, 0, 36)
                    
                    SectionCorner.CornerRadius = UDim.new(0, 6)
                    SectionCorner.Name = "SectionC"
                    SectionCorner.Parent = SectionFrame
                    
                    SectionText.Name = "SectionText"
                    SectionText.Parent = SectionFrame
                    SectionText.BackgroundColor3 = SkyBlue
                    SectionText.BackgroundTransparency = 1
                    SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
                    SectionText.Size = UDim2.new(0, 401, 0, 36)
                    SectionText.Font = Enum.Font.GothamSemibold
                    SectionText.Text = sectionName
                    SectionText.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                    SectionText.TextSize = 16
                    SectionText.TextXAlignment = Enum.TextXAlignment.Left
                    
                    SectionOpenIcon.Name = "SectionOpen"
                    SectionOpenIcon.Parent = SectionText
                    SectionOpenIcon.BackgroundTransparency = 1
                    SectionOpenIcon.BorderSizePixel = 0
                    SectionOpenIcon.Position = UDim2.new(0, -33, 0, 5)
                    SectionOpenIcon.Size = UDim2.new(0, 26, 0, 26)
                    SectionOpenIcon.Image = "rbxassetid://123097590035361"
                    SectionOpenIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    
                    SectionOpenedIcon.Name = "SectionOpened"
                    SectionOpenedIcon.Parent = SectionOpenIcon
                    SectionOpenedIcon.BackgroundTransparency = 1
                    SectionOpenedIcon.BorderSizePixel = 0
                    SectionOpenedIcon.Size = UDim2.new(0, 26, 0, 26)
                    SectionOpenedIcon.Image = "rbxassetid://123097590035361"
                    SectionOpenedIcon.ImageTransparency = 1
                    SectionOpenedIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    
                    SectionToggle.Name = "SectionToggle"
                    SectionToggle.Parent = SectionOpenIcon
                    SectionToggle.BackgroundTransparency = 1
                    SectionToggle.BorderSizePixel = 0
                    SectionToggle.Size = UDim2.new(0, 26, 0, 26)
                    
                    ObjectsFrame.Name = "Objs"
                    ObjectsFrame.Parent = SectionFrame
                    ObjectsFrame.BackgroundColor3 = SkyBlue
                    ObjectsFrame.BackgroundTransparency = 1
                    ObjectsFrame.BorderSizePixel = 0
                    ObjectsFrame.Position = UDim2.new(0, 6, 0, 36)
                    ObjectsFrame.Size = UDim2.new(0.986347735, 0, 0, 0)
                    
                    ObjectsLayout.Name = "ObjsL"
                    ObjectsLayout.Parent = ObjectsFrame
                    ObjectsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    ObjectsLayout.Padding = UDim.new(0, 8)
                    
                    local sectionOpen = isOpen
                    if isOpen ~= false then
                        SectionFrame.Size = UDim2.new(0.981000006, 0, 0, sectionOpen and (36 + ObjectsLayout.AbsoluteContentSize.Y + 8 or 36) or 36)
                        SectionOpenedIcon.ImageTransparency = sectionOpen and 0 or 1
                        SectionOpenIcon.ImageTransparency = sectionOpen and 1 or 0
                    end
                    
                    SectionToggle.MouseButton1Click:Connect(function()
                        sectionOpen = not sectionOpen
                        SectionFrame.Size = UDim2.new(0.981000006, 0, 0, sectionOpen and 36 + ObjectsLayout.AbsoluteContentSize.Y + 8 or 36)
                        SectionOpenedIcon.ImageTransparency = sectionOpen and 0 or 1
                        SectionOpenIcon.ImageTransparency = sectionOpen and 1 or 0
                    end)
                    
                    ObjectsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                        if sectionOpen then
                            SectionFrame.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjectsLayout.AbsoluteContentSize.Y + 8)
                        end
                    end)
                    
                    return {
                        Button = function(_, buttonText, callback)
                            local callbackFunc = callback or function() end
                            local ButtonModule = Instance.new("Frame")
                            local Button = Instance.new("TextButton")
                            local ButtonCorner = Instance.new("UICorner")
                            
                            ButtonModule.Name = "BtnModule"
                            ButtonModule.Parent = ObjectsFrame
                            ButtonModule.BackgroundColor3 = SkyBlue
                            ButtonModule.BackgroundTransparency = 1
                            ButtonModule.BorderSizePixel = 0
                            ButtonModule.Position = UDim2.new(0, 0, 0, 0)
                            ButtonModule.Size = UDim2.new(0, 428, 0, 38)
                            ButtonModule.Transparency = 0.75
                            
                            Button.Name = "Btn"
                            Button.Parent = ButtonModule
                            Button.BackgroundColor3 = DarkSkyBlue
                            Button.BorderSizePixel = 0
                            Button.Size = UDim2.new(0, 428, 0, 38)
                            Button.AutoButtonColor = false
                            Button.Font = Enum.Font.GothamSemibold
                            Button.Text = "   " .. buttonText
                            Button.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            Button.TextSize = 16
                            Button.TextXAlignment = Enum.TextXAlignment.Left
                            Button.BackgroundTransparency = 0.2
                            
                            ButtonCorner.CornerRadius = UDim.new(0, 12)
                            ButtonCorner.Name = "BtnC"
                            ButtonCorner.Parent = Button
                            
                            Button.MouseButton1Click:Connect(function()
                                spawn(function()
                                    Ripple(Button)
                                end)
                                spawn(callbackFunc)
                            end)
                        end,
                        
                        Label = function(_, labelText)
                            local LabelModule = Instance.new("Frame")
                            local Label = Instance.new("TextLabel")
                            local LabelCorner = Instance.new("UICorner")
                            
                            LabelModule.Name = "LabelModule"
                            LabelModule.Parent = ObjectsFrame
                            LabelModule.BackgroundColor3 = SkyBlue
                            LabelModule.BackgroundTransparency = 1
                            LabelModule.BorderSizePixel = 0
                            LabelModule.Position = UDim2.new(0, 0, 0, 0)
                            LabelModule.Size = UDim2.new(0, 428, 0, 19)
                            
                            Label.Parent = LabelModule
                            Label.BackgroundColor3 = DarkSkyBlue
                            Label.Size = UDim2.new(0, 428, 0, 22)
                            Label.Font = Enum.Font.GothamSemibold
                            Label.Text = labelText
                            Label.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            Label.BackgroundTransparency = 0.2
                            Label.TextSize = 14
                            
                            LabelCorner.CornerRadius = UDim.new(0, 18)
                            LabelCorner.Name = "LabelC"
                            LabelCorner.Parent = Label
                            
                            return Label
                        end,
                        
                        Toggle = function(_, toggleText, flag, defaultValue, callback)
                            local callbackFunc = callback or function() end
                            local currentValue = defaultValue or false
                            assert(toggleText, "No text provided")
                            assert(flag, "No flag provided")
                            Library.flags[flag] = currentValue
                            
                            local ToggleModule = Instance.new("Frame")
                            local ToggleButton = Instance.new("TextButton")
                            local ToggleCorner = Instance.new("UICorner")
                            local ToggleDisable = Instance.new("Frame")
                            local ToggleSwitch = Instance.new("Frame")
                            local SwitchCorner = Instance.new("UICorner")
                            local DisableCorner = Instance.new("UICorner")
                            
                            ToggleModule.Name = "ToggleModule"
                            ToggleModule.Parent = ObjectsFrame
                            ToggleModule.BackgroundColor3 = SkyBlue
                            ToggleModule.BackgroundTransparency = 1
                            ToggleModule.BorderSizePixel = 0
                            ToggleModule.Position = UDim2.new(0, 0, 0, 0)
                            ToggleModule.Size = UDim2.new(0, 428, 0, 38)
                            
                            ToggleButton.Name = "ToggleBtn"
                            ToggleButton.Parent = ToggleModule
                            ToggleButton.BackgroundColor3 = DarkSkyBlue
                            ToggleButton.BackgroundTransparency = 0.2
                            ToggleButton.BorderSizePixel = 0
                            ToggleButton.Size = UDim2.new(0, 428, 0, 38)
                            ToggleButton.AutoButtonColor = false
                            ToggleButton.Font = Enum.Font.GothamSemibold
                            ToggleButton.Text = "   " .. toggleText
                            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            ToggleButton.TextSize = 16
                            ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
                            
                            ToggleCorner.CornerRadius = UDim.new(0, 18)
                            ToggleCorner.Name = "ToggleBtnC"
                            ToggleCorner.Parent = ToggleButton
                            
                            ToggleDisable.Name = "ToggleDisable"
                            ToggleDisable.Parent = ToggleButton
                            ToggleDisable.BackgroundColor3 = LightSkyBlue
                            ToggleDisable.BackgroundTransparency = 0.2
                            ToggleDisable.BorderSizePixel = 0
                            ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
                            ToggleDisable.Size = UDim2.new(0, 36, 0, 22)
                            
                            ToggleSwitch.Name = "ToggleSwitch"
                            ToggleSwitch.Parent = ToggleDisable
                            ToggleSwitch.BackgroundColor3 = VeryDarkSkyBlue
                            ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)
                            
                            SwitchCorner.CornerRadius = UDim.new(0, 18)
                            SwitchCorner.Name = "ToggleSwitchC"
                            SwitchCorner.Parent = ToggleSwitch
                            
                            DisableCorner.CornerRadius = UDim.new(0, 9)
                            DisableCorner.Name = "ToggleDisableC"
                            DisableCorner.Parent = ToggleDisable
                            
                            local toggleObject = {
                                SetState = function(_, newState)
                                    if newState == nil then
                                        newState = not Library.flags[flag]
                                    end
                                    if Library.flags[flag] ~= newState then
                                        Services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                                            Position = UDim2.new(0, newState and ToggleSwitch.Size.X.Offset / 2 or 0, 0, 0),
                                            BackgroundColor3 = newState and SkyBlue or VeryDarkSkyBlue
                                        }):Play()
                                        Library.flags[flag] = newState
                                        callbackFunc(newState)
                                    end
                                end,
                                Module = ToggleModule
                            }
                            
                            if currentValue ~= false then
                                toggleObject:SetState(true)
                            end
                            
                            ToggleButton.MouseButton1Click:Connect(function()
                                toggleObject:SetState()
                            end)
                            
                            return toggleObject
                        end,
                        
                        Keybind = function(_, keybindText, defaultKey, callback)
                            local callbackFunc = callback or function() end
                            assert(keybindText, "No text provided")
                            assert(defaultKey, "No default key provided")
                            
                            if typeof(defaultKey) == "string" then
                                defaultKey = Enum.KeyCode[defaultKey] or defaultKey
                            end
                            
                            local invalidKeys = {
                                Return = true,
                                Space = true,
                                Tab = true,
                                Backquote = true,
                                CapsLock = true,
                                Escape = true,
                                Unknown = true
                            }
                            
                            local keyDisplayNames = {
                                RightControl = "Right Ctrl",
                                LeftControl = "Left Ctrl",
                                LeftShift = "Left Shift",
                                RightShift = "Right Shift",
                                Semicolon = ";",
                                Quote = "\"",
                                LeftBracket = "[",
                                RightBracket = "]",
                                Equals = "=",
                                Minus = "-",
                                RightAlt = "Right Alt",
                                LeftAlt = "Left Alt"
                            }
                            
                            local currentKey = defaultKey
                            local displayText = not defaultKey or keyDisplayNames[defaultKey.Name] or (defaultKey.Name or "None")
                            
                            local KeybindModule = Instance.new("Frame")
                            local KeybindButton = Instance.new("TextButton")
                            local KeybindCorner = Instance.new("UICorner")
                            local KeybindValue = Instance.new("TextButton")
                            local ValueCorner = Instance.new("UICorner")
                            local KeybindLayout = Instance.new("UIListLayout")
                            local KeybindPadding = Instance.new("UIPadding")
                            
                            KeybindModule.Name = "KeybindModule"
                            KeybindModule.Parent = ObjectsFrame
                            KeybindModule.BackgroundColor3 = SkyBlue
                            KeybindModule.BackgroundTransparency = 1
                            KeybindModule.BorderSizePixel = 0
                            KeybindModule.Position = UDim2.new(0, 0, 0, 0)
                            KeybindModule.Size = UDim2.new(0, 428, 0, 38)
                            
                            KeybindButton.Name = "KeybindBtn"
                            KeybindButton.Parent = KeybindModule
                            KeybindButton.BackgroundColor3 = DarkSkyBlue
                            KeybindButton.BorderSizePixel = 0
                            KeybindButton.Size = UDim2.new(0, 428, 0, 38)
                            KeybindButton.AutoButtonColor = false
                            KeybindButton.Font = Enum.Font.GothamSemibold
                            KeybindButton.Text = "   " .. keybindText
                            KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            KeybindButton.TextSize = 16
                            KeybindButton.TextXAlignment = Enum.TextXAlignment.Left
                            
                            KeybindCorner.CornerRadius = UDim.new(0, 6)
                            KeybindCorner.Name = "KeybindBtnC"
                            KeybindCorner.Parent = KeybindButton
                            
                            KeybindValue.Name = "KeybindValue"
                            KeybindValue.Parent = KeybindButton
                            KeybindValue.BackgroundColor3 = LightSkyBlue
                            KeybindValue.BorderSizePixel = 0
                            KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                            KeybindValue.Size = UDim2.new(0, 100, 0, 28)
                            KeybindValue.AutoButtonColor = false
                            KeybindValue.Font = Enum.Font.Gotham
                            KeybindValue.Text = displayText
                            KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            KeybindValue.TextSize = 14
                            
                            ValueCorner.CornerRadius = UDim.new(0, 6)
                            ValueCorner.Name = "KeybindValueC"
                            ValueCorner.Parent = KeybindValue
                            
                            KeybindLayout.Name = "KeybindL"
                            KeybindLayout.Parent = KeybindButton
                            KeybindLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                            KeybindLayout.SortOrder = Enum.SortOrder.LayoutOrder
                            KeybindLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                            
                            KeybindPadding.Parent = KeybindButton
                            KeybindPadding.PaddingRight = UDim.new(0, 6)
                            
                            Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
                                if gameProcessed then
                                    return
                                elseif input.UserInputType == Enum.UserInputType.Keyboard then
                                    if input.KeyCode == currentKey then
                                        callbackFunc(currentKey.Name)
                                    end
                                else
                                    return
                                end
                            end)
                            
                            KeybindValue.MouseButton1Click:Connect(function()
                                KeybindValue.Text = "..."
                                wait()
                                local newInput = Services.UserInputService.InputEnded:Wait()
                                local keyName = tostring(newInput.KeyCode.Name)
                                
                                if newInput.UserInputType == Enum.UserInputType.Keyboard then
                                    if invalidKeys[keyName] then
                                        KeybindValue.Text = displayText
                                    else
                                        wait()
                                        currentKey = Enum.KeyCode[keyName]
                                        KeybindValue.Text = keyDisplayNames[keyName] or keyName
                                        displayText = KeybindValue.Text
                                    end
                                else
                                    KeybindValue.Text = displayText
                                    return
                                end
                            end)
                            
                            KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
                                KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
                            end)
                            
                            KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
                        end,
                        
                        Textbox = function(_, textboxText, flag, defaultText, callback)
                            local callbackFunc = callback or function() end
                            assert(textboxText, "No text provided")
                            assert(flag, "No flag provided")
                            assert(defaultText, "No default text provided")
                            Library.flags[flag] = defaultText
                            
                            local TextboxModule = Instance.new("Frame")
                            local TextboxBack = Instance.new("TextButton")
                            local TextboxCorner = Instance.new("UICorner")
                            local BoxBackground = Instance.new("TextButton")
                            local BoxCorner = Instance.new("UICorner")
                            local TextboxInput = Instance.new("TextBox")
                            local TextboxLayout = Instance.new("UIListLayout")
                            local TextboxPadding = Instance.new("UIPadding")
                            
                            TextboxModule.Name = "TextboxModule"
                            TextboxModule.Parent = ObjectsFrame
                            TextboxModule.BackgroundColor3 = SkyBlue
                            TextboxModule.BackgroundTransparency = 1
                            TextboxModule.BorderSizePixel = 0
                            TextboxModule.Position = UDim2.new(0, 0, 0, 0)
                            TextboxModule.Size = UDim2.new(0, 428, 0, 38)
                            
                            TextboxBack.Name = "TextboxBack"
                            TextboxBack.Parent = TextboxModule
                            TextboxBack.BackgroundColor3 = DarkSkyBlue
                            TextboxBack.BackgroundTransparency = 0.2
                            TextboxBack.BorderSizePixel = 0
                            TextboxBack.Size = UDim2.new(0, 428, 0, 38)
                            TextboxBack.AutoButtonColor = false
                            TextboxBack.Font = Enum.Font.GothamSemibold
                            TextboxBack.Text = "   " .. textboxText
                            TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            TextboxBack.TextSize = 16
                            TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
                            
                            TextboxCorner.CornerRadius = UDim.new(0, 12)
                            TextboxCorner.Name = "TextboxBackC"
                            TextboxCorner.Parent = TextboxBack
                            
                            BoxBackground.Name = "BoxBG"
                            BoxBackground.Parent = TextboxBack
                            BoxBackground.BackgroundColor3 = LightSkyBlue
                            BoxBackground.BorderSizePixel = 0
                            BoxBackground.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                            BoxBackground.Size = UDim2.new(0, 100, 0, 28)
                            BoxBackground.AutoButtonColor = false
                            BoxBackground.Font = Enum.Font.Gotham
                            BoxBackground.Text = ""
                            BoxBackground.TextColor3 = Color3.fromRGB(255, 255, 255)
                            BoxBackground.TextSize = 14
                            
                            BoxCorner.CornerRadius = UDim.new(0, 12)
                            BoxCorner.Name = "BoxBGC"
                            BoxCorner.Parent = BoxBackground
                            
                            TextboxInput.Parent = BoxBackground
                            TextboxInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextboxInput.BackgroundTransparency = 1
                            TextboxInput.BorderSizePixel = 0
                            TextboxInput.Size = UDim2.new(1, 0, 1, 0)
                            TextboxInput.Font = Enum.Font.Gotham
                            TextboxInput.Text = defaultText
                            TextboxInput.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            TextboxInput.TextSize = 14
                            
                            TextboxLayout.Name = "TextboxBackL"
                            TextboxLayout.Parent = TextboxBack
                            TextboxLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                            TextboxLayout.SortOrder = Enum.SortOrder.LayoutOrder
                            TextboxLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                            
                            TextboxPadding.Name = "TextboxBackP"
                            TextboxPadding.Parent = TextboxBack
                            TextboxPadding.PaddingRight = UDim.new(0, 12)
                            
                            TextboxInput.FocusLost:Connect(function()
                                if TextboxInput.Text == "" then
                                    TextboxInput.Text = defaultText
                                end
                                Library.flags[flag] = TextboxInput.Text
                                callbackFunc(TextboxInput.Text)
                            end)
                            
                            TextboxInput:GetPropertyChangedSignal("TextBounds"):Connect(function()
                                BoxBackground.Size = UDim2.new(0, TextboxInput.TextBounds.X + 30, 0, 28)
                            end)
                            
                            BoxBackground.Size = UDim2.new(0, TextboxInput.TextBounds.X + 30, 0, 28)
                        end,
                        
                        Slider = function(_, sliderText, flag, defaultValue, minValue, maxValue, increment, callback)
                            local callbackFunc = callback or function() end
                            local min = minValue or 1
                            local max = maxValue or 10
                            local currentValue = defaultValue or min
                            local useDecimals = increment or false
                            Library.flags[flag] = currentValue
                            
                            assert(sliderText, "No text provided")
                            assert(flag, "No flag provided")
                            assert(currentValue, "No default value provided")
                            
                            local SliderModule = Instance.new("Frame")
                            local SliderBack = Instance.new("TextButton")
                            local SliderCorner = Instance.new("UICorner")
                            local SliderBar = Instance.new("Frame")
                            local BarCorner = Instance.new("UICorner")
                            local SliderPart = Instance.new("Frame")
                            local PartCorner = Instance.new("UICorner")
                            local SliderValueBG = Instance.new("TextButton")
                            local ValueCorner = Instance.new("UICorner")
                            local SliderValue = Instance.new("TextBox")
                            local MinButton = Instance.new("TextButton")
                            local AddButton = Instance.new("TextButton")
                            
                            SliderModule.Name = "SliderModule"
                            SliderModule.Parent = ObjectsFrame
                            SliderModule.BackgroundColor3 = SkyBlue
                            SliderModule.BackgroundTransparency = 1
                            SliderModule.BorderSizePixel = 0
                            SliderModule.Position = UDim2.new(0, 0, 0, 0)
                            SliderModule.Size = UDim2.new(0, 428, 0, 38)
                            
                            SliderBack.Name = "SliderBack"
                            SliderBack.Parent = SliderModule
                            SliderBack.BackgroundColor3 = DarkSkyBlue
                            SliderBack.BackgroundTransparency = 0.2
                            SliderBack.BorderSizePixel = 0
                            SliderBack.Size = UDim2.new(0, 428, 0, 38)
                            SliderBack.AutoButtonColor = false
                            SliderBack.Font = Enum.Font.GothamSemibold
                            SliderBack.Text = "   " .. sliderText
                            SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            SliderBack.TextSize = 16
                            SliderBack.TextXAlignment = Enum.TextXAlignment.Left
                            
                            SliderCorner.CornerRadius = UDim.new(0, 12)
                            SliderCorner.Name = "SliderBackC"
                            SliderCorner.Parent = SliderBack
                            
                            SliderBar.Name = "SliderBar"
                            SliderBar.Parent = SliderBack
                            SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                            SliderBar.BackgroundColor3 = LightSkyBlue
                            SliderBar.BackgroundTransparency = 0.2
                            SliderBar.BorderSizePixel = 0
                            SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
                            SliderBar.Size = UDim2.new(0, 140, 0, 12)
                            
                            BarCorner.CornerRadius = UDim.new(0, 12)
                            BarCorner.Name = "SliderBarC"
                            BarCorner.Parent = SliderBar
                            
                            SliderPart.Name = "SliderPart"
                            SliderPart.Parent = SliderBar
                            SliderPart.BackgroundColor3 = SkyBlue
                            SliderPart.BorderSizePixel = 0
                            SliderPart.Size = UDim2.new(0, 54, 0, 13)
                            
                            PartCorner.CornerRadius = UDim.new(0, 4)
                            PartCorner.Name = "SliderPartC"
                            PartCorner.Parent = SliderPart
                            
                            SliderValueBG.Name = "SliderValBG"
                            SliderValueBG.Parent = SliderBack
                            SliderValueBG.BackgroundColor3 = LightSkyBlue
                            SliderValueBG.BackgroundTransparency = 0.2
                            SliderValueBG.BorderSizePixel = 0
                            SliderValueBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
                            SliderValueBG.Size = UDim2.new(0, 44, 0, 28)
                            SliderValueBG.AutoButtonColor = false
                            SliderValueBG.Font = Enum.Font.Gotham
                            SliderValueBG.Text = ""
                            SliderValueBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                            SliderValueBG.TextSize = 14
                            
                            ValueCorner.CornerRadius = UDim.new(0, 6)
                            ValueCorner.Name = "SliderValBGC"
                            ValueCorner.Parent = SliderValueBG
                            
                            SliderValue.Name = "SliderValue"
                            SliderValue.Parent = SliderValueBG
                            SliderValue.BackgroundColor3 = SkyBlue
                            SliderValue.BackgroundTransparency = 1
                            SliderValue.BorderSizePixel = 0
                            SliderValue.Size = UDim2.new(1, 0, 1, 0)
                            SliderValue.Font = Enum.Font.Gotham
                            SliderValue.Text = "1000"
                            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            SliderValue.TextSize = 14
                            
                            MinButton.Name = "MinSlider"
                            MinButton.Parent = SliderModule
                            MinButton.BackgroundColor3 = SkyBlue
                            MinButton.BackgroundTransparency = 1
                            MinButton.BorderSizePixel = 0
                            MinButton.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
                            MinButton.Size = UDim2.new(0, 20, 0, 20)
                            MinButton.Font = Enum.Font.Gotham
                            MinButton.Text = "-"
                            MinButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            MinButton.TextSize = 24
                            MinButton.TextWrapped = true
                            
                            AddButton.Name = "AddSlider"
                            AddButton.Parent = SliderModule
                            AddButton.AnchorPoint = Vector2.new(0, 0.5)
                            AddButton.BackgroundColor3 = SkyBlue
                            AddButton.BackgroundTransparency = 1
                            AddButton.BorderSizePixel = 0
                            AddButton.Position = UDim2.new(0.810906529, 0, 0.5, 0)
                            AddButton.Size = UDim2.new(0, 20, 0, 20)
                            AddButton.Font = Enum.Font.Gotham
                            AddButton.Text = "+"
                            AddButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            AddButton.TextSize = 24
                            AddButton.TextWrapped = true
                            
                            local sliderObject = {
                                SetValue = function(_, newValue)
                                    local progress = (PlayerMouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                                    if newValue then
                                        progress = (newValue - min) / (max - min)
                                    end
                                    local clampedProgress = math.clamp(progress, 0, 1)
                                    local finalValue
                                    if useDecimals then
                                        finalValue = newValue or tonumber(string.format("%.1f", tostring(min + (max - min) * clampedProgress)))
                                    else
                                        finalValue = newValue or math.floor(min + (max - min) * clampedProgress)
                                    end
                                    Library.flags[flag] = tonumber(finalValue)
                                    SliderValue.Text = tostring(finalValue)
                                    SliderPart.Size = UDim2.new(clampedProgress, 0, 1, 0)
                                    callbackFunc(tonumber(finalValue))
                                end
                            }
                            
                            MinButton.MouseButton1Click:Connect(function()
                                local current = Library.flags[flag]
                                sliderObject:SetValue(math.clamp(current - 1, min, max))
                            end)
                            
                            AddButton.MouseButton1Click:Connect(function()
                                local current = Library.flags[flag]
                                sliderObject:SetValue(math.clamp(current + 1, min, max))
                            end)
                            
                            sliderObject:SetValue(currentValue)
                            
                            local dragging = false
                            local textFocused = false
                            local allowedChars = {
                                [""] = true,
                                ["-"] = true
                            }
                            
                            SliderBar.InputBegan:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    sliderObject:SetValue()
                                    dragging = true
                                end
                            end)
                            
                            Services.UserInputService.InputEnded:Connect(function(input)
                                if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    dragging = false
                                end
                            end)
                            
                            Services.UserInputService.InputChanged:Connect(function(input)
                                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                                    sliderObject:SetValue()
                                end
                            end)
                            
                            SliderBar.InputBegan:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.Touch then
                                    sliderObject:SetValue()
                                    dragging = true
                                end
                            end)
                            
                            Services.UserInputService.InputEnded:Connect(function(input)
                                if dragging and input.UserInputType == Enum.UserInputType.Touch then
                                    dragging = false
                                end
                            end)
                            
                            Services.UserInputService.InputChanged:Connect(function(input)
                                if dragging and input.UserInputType == Enum.UserInputType.Touch then
                                    sliderObject:SetValue()
                                end
                            end)
                            
                            SliderValue.Focused:Connect(function()
                                textFocused = true
                            end)
                            
                            SliderValue.FocusLost:Connect(function()
                                textFocused = false
                                if SliderValue.Text == "" then
                                    sliderObject:SetValue(currentValue)
                                end
                            end)
                            
                            SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
                                if textFocused then
                                    SliderValue.Text = SliderValue.Text:gsub("%D+", "")
                                    local text = SliderValue.Text
                                    if tonumber(text) then
                                        if not allowedChars[text] then
                                            if max < tonumber(text) then
                                                text = max
                                                SliderValue.Text = tostring(max)
                                            end
                                            sliderObject:SetValue(tonumber(text))
                                        end
                                    else
                                        SliderValue.Text = SliderValue.Text:gsub("%D+", "")
                                    end
                                end
                            end)
                            
                            return sliderObject
                        end,
                        
                        Dropdown = function(_, dropdownText, flag, options, callback)
                            local callbackFunc = callback or function() end
                            assert(dropdownText, "No text provided")
                            assert(flag, "No flag provided")
                            Library.flags[flag] = nil

                            local DropdownModule = Instance.new("Frame")
                            local DropdownTop = Instance.new("TextButton")
                            local DropdownCorner = Instance.new("UICorner")
                            local DropdownOpen = Instance.new("TextButton")
                            local DropdownTextInput = Instance.new("TextBox")
                            local DropdownLayout = Instance.new("UIListLayout")
                            local DropdownButton = Instance.new("TextButton")
                            local ButtonCorner = Instance.new("UICorner")

                            DropdownModule.Name = "DropdownModule"
                            DropdownModule.Parent = ObjectsFrame
                            DropdownModule.BackgroundColor3 = SkyBlue
                            DropdownModule.BackgroundTransparency = 1
                            DropdownModule.BorderSizePixel = 0
                            DropdownModule.ClipsDescendants = true
                            DropdownModule.Position = UDim2.new(0, 0, 0, 0)
                            DropdownModule.Size = UDim2.new(0, 428, 0, 38)

                            DropdownTop.Name = "DropdownTop"
                            DropdownTop.Parent = DropdownModule
                            DropdownTop.BackgroundColor3 = DarkSkyBlue
                            DropdownTop.BackgroundTransparency = 0.2
                            DropdownTop.BorderSizePixel = 0
                            DropdownTop.Size = UDim2.new(0, 428, 0, 38)
                            DropdownTop.AutoButtonColor = false
                            DropdownTop.Font = Enum.Font.GothamSemibold
                            DropdownTop.Text = ""
                            DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            DropdownTop.TextSize = 16
                            DropdownTop.TextXAlignment = Enum.TextXAlignment.Left

                            DropdownCorner.CornerRadius = UDim.new(0, 12)
                            DropdownCorner.Name = "DropdownTopC"
                            DropdownCorner.Parent = DropdownTop

                            DropdownOpen.Name = "DropdownOpen"
                            DropdownOpen.Parent = DropdownTop
                            DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                            DropdownOpen.BackgroundColor3 = SkyBlue
                            DropdownOpen.BackgroundTransparency = 1
                            DropdownOpen.BorderSizePixel = 0
                            DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
                            DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
                            DropdownOpen.Font = Enum.Font.Gotham
                            DropdownOpen.Text = "+"
                            DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            DropdownOpen.TextSize = 24
                            DropdownOpen.TextWrapped = true

                            DropdownTextInput.Name = "DropdownText"
                            DropdownTextInput.Parent = DropdownTop
                            DropdownTextInput.BackgroundColor3 = SkyBlue
                            DropdownTextInput.BackgroundTransparency = 1
                            DropdownTextInput.BorderSizePixel = 0
                            DropdownTextInput.Position = UDim2.new(0.0373831764, 0, 0, 0)
                            DropdownTextInput.Size = UDim2.new(0, 184, 0, 38)
                            DropdownTextInput.Font = Enum.Font.GothamSemibold
                            DropdownTextInput.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
                            DropdownTextInput.PlaceholderText = dropdownText
                            DropdownTextInput.Text = ""
                            DropdownTextInput.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                            DropdownTextInput.TextSize = 16
                            DropdownTextInput.TextXAlignment = Enum.TextXAlignment.Left

                            DropdownLayout.Name = "DropdownModuleL"
                            DropdownLayout.Parent = DropdownModule
                            DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder
                            DropdownLayout.Padding = UDim.new(0, 8)

                            local function showAllOptions()
                                for _, child in pairs(DropdownModule:GetChildren()) do
                                    if child:IsA("TextButton") and child.Name:match("Option_") then
                                        child.Visible = true
                                    end
                                end
                            end

                            local function filterOptions(searchText)
                                for _, child in pairs(DropdownModule:GetChildren()) do
                                    if searchText == "" then
                                        showAllOptions()
                                    elseif child:IsA("TextButton") and child.Name:match("Option_") then
                                        if child.Text:lower():match(searchText:lower()) then
                                            child.Visible = true
                                        else
                                            child.Visible = false
                                        end
                                    end
                                end
                            end

                            local dropdownOpen = false

                            local function toggleDropdown()
                                dropdownOpen = not dropdownOpen
                                if dropdownOpen then
                                    showAllOptions()
                                end
                                DropdownOpen.Text = dropdownOpen and "-" or "+"
                                DropdownModule.Size = UDim2.new(0, 428, 0, dropdownOpen and DropdownLayout.AbsoluteContentSize.Y + 4 or 38)
                            end

                            DropdownOpen.MouseButton1Click:Connect(toggleDropdown)

                            DropdownTextInput.Focused:Connect(function()
                                if not dropdownOpen then
                                    toggleDropdown()
                                end
                            end)

                            DropdownTextInput:GetPropertyChangedSignal("Text"):Connect(function()
                                if dropdownOpen then
                                    filterOptions(DropdownTextInput.Text)
                                end
                            end)

                            DropdownLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                                if dropdownOpen then
                                    DropdownModule.Size = UDim2.new(0, 428, 0, DropdownLayout.AbsoluteContentSize.Y + 4)
                                end
                            end)

                            local dropdownObject = {
                                AddOption = function(_, optionName)
                                    local optionButton = Instance.new("TextButton")
                                    local optionCorner = Instance.new("UICorner")
                                    
                                    optionButton.Name = "Option_" .. optionName
                                    optionButton.Parent = DropdownModule
                                    optionButton.BackgroundColor3 = DarkSkyBlue
                                    optionButton.BorderSizePixel = 0
                                    optionButton.Position = UDim2.new(0, 0, 0.328125, 0)
                                    optionButton.Size = UDim2.new(0, 428, 0, 26)
                                    optionButton.AutoButtonColor = false
                                    optionButton.Font = Enum.Font.Gotham
                                    optionButton.Text = optionName
                                    optionButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色文本
                                    optionButton.TextSize = 14
                                    
                                    optionCorner.CornerRadius = UDim.new(0, 6)
                                    optionCorner.Name = "OptionC"
                                    optionCorner.Parent = optionButton
                                    
                                    optionButton.MouseButton1Click:Connect(function()
                                        toggleDropdown()
                                        callbackFunc(optionButton.Text)
                                        DropdownTextInput.Text = optionButton.Text
                                        Library.flags[flag] = optionButton.Text
                                    end)
                                end,
                                
                                RemoveOption = function(_, optionName)
                                    local option = DropdownModule:FindFirstChild("Option_" .. optionName)
                                    if option then
                                        option:Destroy()
                                    end
                                end,
                                
                                SetOptions = function(_, newOptions)
                                    for _, child in pairs(DropdownModule:GetChildren()) do
                                        if child.Name:match("Option_") then
                                            child:Destroy()
                                        end
                                    end
                                    
                                    for _, option in pairs(newOptions) do
                                        dropdownObject:AddOption(option)
                                    end
                                end
                            }

                            dropdownObject:SetOptions(options or {})

                            return dropdownObject
                        end
                    }
                end
            }
        end
    }
end

return Library