-- ZG_XG UI Library v1.0 - Complete New Source Code
-- 全新的UI库，支持ZG_XG:格式调用

repeat task.wait() until game:IsLoaded()

-- 基础服务
local TweenService = game:GetService("TweenService")
local InputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- 全局ZG_XG对象
local ZG_XG = {}
ZG_XG.__index = ZG_XG
ZG_XG.elements = {}
ZG_XG.buttons = {}
ZG_XG.toggles = {}
ZG_XG.sliders = {}
ZG_XG.flags = {}
ZG_XG.currentUI = nil

-- 颜色配置
local Colors = {
    Main = Color3.fromRGB(25, 25, 35),
    Secondary = Color3.fromRGB(35, 35, 45),
    Accent = Color3.fromRGB(100, 180, 255),
    Text = Color3.fromRGB(220, 230, 255),
    Border = Color3.fromRGB(50, 50, 70),
    Red = Color3.fromRGB(255, 80, 80),
    Green = Color3.fromRGB(80, 255, 120),
    Yellow = Color3.fromRGB(255, 220, 80)
}

-- 霓虹渐变颜色
local NeonGradient = {
    Colors = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 150, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(150, 0, 255))
    })
}

-- 动画函数
local function CreateTween(obj, duration, easingStyle, easingDirection, properties)
    return TweenService:Create(obj, TweenInfo.new(duration, easingStyle, easingDirection), properties)
end

-- 创建主UI函数
function ZG_XG:CreateWindow(title)
    -- 清理旧UI
    for _, v in pairs(CoreGui:GetChildren()) do
        if v.Name == "ZG_XG_Window" then
            v:Destroy()
        end
    end
    
    local self = setmetatable({}, ZG_XG)
    self.title = title
    self.tabs = {}
    self.currentTab = nil
    self.isVisible = false
    self.dragging = false
    self.dragStart = Vector2.new(0, 0)
    self.windowStart = Vector2.new(0, 0)
    
    -- 创建主屏幕GUI
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "ZG_XG_Window"
    self.screenGui.DisplayOrder = 999
    self.screenGui.Parent = CoreGui
    
    -- 胶囊开关按钮
    self.toggleButton = Instance.new("TextButton")
    self.toggleButton.Name = "ToggleButton"
    self.toggleButton.Parent = self.screenGui
    self.toggleButton.Size = UDim2.new(0, 120, 0, 45)
    self.toggleButton.Position = UDim2.new(0, 30, 0.5, -22)
    self.toggleButton.Text = "🔓 打开面板"
    self.toggleButton.TextColor3 = Colors.Text
    self.toggleButton.Font = Enum.Font.GothamSemibold
    self.toggleButton.TextSize = 14
    self.toggleButton.BackgroundColor3 = Colors.Secondary
    self.toggleButton.BackgroundTransparency = 0.2
    self.toggleButton.AutoButtonColor = true
    
    -- 胶囊按钮圆角
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = self.toggleButton
    
    -- 胶囊按钮边框
    local toggleBorder = Instance.new("Frame")
    toggleBorder.Name = "ToggleBorder"
    toggleBorder.Parent = self.toggleButton
    toggleBorder.Size = UDim2.new(1, 4, 1, 4)
    toggleBorder.Position = UDim2.new(0, -2, 0, -2)
    toggleBorder.BackgroundColor3 = Colors.Accent
    toggleBorder.BackgroundTransparency = 0.5
    toggleBorder.ZIndex = -1
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(1, 0)
    borderCorner.Parent = toggleBorder
    
    -- 按钮悬停动画
    self.toggleButton.MouseEnter:Connect(function()
        CreateTween(self.toggleButton, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
            BackgroundTransparency = 0.1,
            Size = UDim2.new(0, 125, 0, 48)
        }):Play()
    end)
    
    self.toggleButton.MouseLeave:Connect(function()
        CreateTween(self.toggleButton, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(0, 120, 0, 45)
        }):Play()
    end)
    
    -- 主窗口容器
    self.mainContainer = Instance.new("Frame")
    self.mainContainer.Name = "MainContainer"
    self.mainContainer.Parent = self.screenGui
    self.mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.mainContainer.Size = UDim2.new(0, 500, 0, 380)
    self.mainContainer.BackgroundColor3 = Colors.Main
    self.mainContainer.BackgroundTransparency = 0.05
    self.mainContainer.BorderSizePixel = 0
    self.mainContainer.ClipsDescendants = true
    self.mainContainer.Visible = false
    
    -- 主窗口圆角
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 15)
    mainCorner.Parent = self.mainContainer
    
    -- 霓虹主边框
    self.neonBorder = Instance.new("Frame")
    self.neonBorder.Name = "NeonBorder"
    self.neonBorder.Parent = self.mainContainer
    self.neonBorder.Size = UDim2.new(1, 8, 1, 8)
    self.neonBorder.Position = UDim2.new(0, -4, 0, -4)
    self.neonBorder.BackgroundTransparency = 1
    
    -- 创建霓虹边框的四个边
    local borderParts = {}
    local borderPositions = {
        {name = "Top", size = UDim2.new(1, 0, 0, 4), pos = UDim2.new(0, 0, 0, 0)},
        {name = "Bottom", size = UDim2.new(1, 0, 0, 4), pos = UDim2.new(0, 0, 1, -4)},
        {name = "Left", size = UDim2.new(0, 4, 1, -8), pos = UDim2.new(0, 0, 0, 4)},
        {name = "Right", size = UDim2.new(0, 4, 1, -8), pos = UDim2.new(1, -4, 0, 4)}
    }
    
    for _, border in ipairs(borderPositions) do
        local part = Instance.new("Frame")
        part.Name = border.name
        part.Parent = self.neonBorder
        part.Size = border.size
        part.Position = border.pos
        part.BackgroundColor3 = Color3.new(1, 1, 1)
        part.BackgroundTransparency = 0.3
        
        local gradient = Instance.new("UIGradient")
        gradient.Color = NeonGradient.Colors
        gradient.Rotation = (border.name == "Left" and 90) or (border.name == "Right" and 270) or 0
        gradient.Parent = part
        
        borderParts[border.name] = {frame = part, gradient = gradient}
    end
    
    -- 霓虹动画循环
    spawn(function()
        while self.screenGui and self.screenGui.Parent do
            local time = tick()
            local offset = (time * 0.3) % 1
            
            for name, part in pairs(borderParts) do
                part.gradient.Offset = Vector2.new(offset, 0)
                
                -- 添加脉冲效果
                local pulse = math.sin(time * 2 + name:byte(1) * 0.1) * 0.15 + 0.85
                part.frame.BackgroundTransparency = 1 - pulse * 0.7
            end
            
            task.wait()
        end
    end)
    
    -- 标题栏
    self.titleBar = Instance.new("Frame")
    self.titleBar.Name = "TitleBar"
    self.titleBar.Parent = self.mainContainer
    self.titleBar.Size = UDim2.new(1, 0, 0, 45)
    self.titleBar.BackgroundColor3 = Colors.Secondary
    self.titleBar.BackgroundTransparency = 0.1
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 15, 0, 0)
    titleCorner.Parent = self.titleBar
    
    -- 窗口标题
    self.titleLabel = Instance.new("TextLabel")
    self.titleLabel.Name = "TitleLabel"
    self.titleLabel.Parent = self.titleBar
    self.titleLabel.Size = UDim2.new(1, -100, 1, 0)
    self.titleLabel.Position = UDim2.new(0, 20, 0, 0)
    self.titleLabel.Text = title
    self.titleLabel.TextColor3 = Colors.Text
    self.titleLabel.Font = Enum.Font.GothamBold
    self.titleLabel.TextSize = 18
    self.titleLabel.BackgroundTransparency = 1
    self.titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 标题霓虹渐变
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = NeonGradient.Colors
    titleGradient.Parent = self.titleLabel
    
    -- 标题动画
    spawn(function()
        while self.titleLabel and self.titleLabel.Parent do
            titleGradient.Offset = Vector2.new((tick() * 0.2) % 1, 0)
            task.wait()
        end
    end)
    
    -- 关闭按钮
    self.closeButton = Instance.new("TextButton")
    self.closeButton.Name = "CloseButton"
    self.closeButton.Parent = self.titleBar
    self.closeButton.Size = UDim2.new(0, 30, 0, 30)
    self.closeButton.Position = UDim2.new(1, -40, 0.5, -15)
    self.closeButton.Text = "✕"
    self.closeButton.TextColor3 = Color3.new(1, 1, 1)
    self.closeButton.Font = Enum.Font.GothamBold
    self.closeButton.TextSize = 20
    self.closeButton.BackgroundColor3 = Colors.Red
    self.closeButton.BackgroundTransparency = 0.2
    self.closeButton.AutoButtonColor = false
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = self.closeButton
    
    -- 侧边栏（标签栏）
    self.sideBar = Instance.new("Frame")
    self.sideBar.Name = "SideBar"
    self.sideBar.Parent = self.mainContainer
    self.sideBar.Size = UDim2.new(0, 100, 1, -45)
    self.sideBar.Position = UDim2.new(0, 0, 0, 45)
    self.sideBar.BackgroundColor3 = Colors.Secondary
    self.sideBar.BackgroundTransparency = 0.15
    
    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 0, 0, 15)
    sideCorner.Parent = self.sideBar
    
    -- 标签容器
    self.tabContainer = Instance.new("ScrollingFrame")
    self.tabContainer.Name = "TabContainer"
    self.tabContainer.Parent = self.sideBar
    self.tabContainer.Size = UDim2.new(1, -10, 1, -10)
    self.tabContainer.Position = UDim2.new(0, 5, 0, 5)
    self.tabContainer.BackgroundTransparency = 1
    self.tabContainer.ScrollBarThickness = 3
    self.tabContainer.ScrollBarImageColor3 = Colors.Accent
    self.tabContainer.ScrollBarImageTransparency = 0.5
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = self.tabContainer
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 10)
    
    -- 内容区域
    self.contentArea = Instance.new("Frame")
    self.contentArea.Name = "ContentArea"
    self.contentArea.Parent = self.mainContainer
    self.contentArea.Size = UDim2.new(1, -100, 1, -45)
    self.contentArea.Position = UDim2.new(0, 100, 0, 45)
    self.contentArea.BackgroundTransparency = 1
    self.contentArea.ClipsDescendants = true
    
    -- 平滑滚动系统
    local function SetupSmoothScroll(frame)
        local scrolling = false
        frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if not scrolling then
                scrolling = true
                CreateTween(frame, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    CanvasPosition = Vector2.new(0, frame.CanvasPosition.Y)
                }):Play()
                task.wait(0.2)
                scrolling = false
            end
        end)
    end
    
    SetupSmoothScroll(self.tabContainer)
    
    -- 布局监听
    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- 按钮点击事件
    self.toggleButton.MouseButton1Click:Connect(function()
        self:ToggleWindow()
    end)
    
    self.closeButton.MouseButton1Click:Connect(function()
        self:ToggleWindow()
    end)
    
    self.closeButton.MouseEnter:Connect(function()
        CreateTween(self.closeButton, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
            BackgroundTransparency = 0,
            Size = UDim2.new(0, 32, 0, 32)
        }):Play()
    end)
    
    self.closeButton.MouseLeave:Connect(function()
        CreateTween(self.closeButton, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(0, 30, 0, 30)
        }):Play()
    end)
    
    -- 窗口拖拽系统
    self.titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.dragging = true
            self.dragStart = InputService:GetMouseLocation()
            self.windowStart = Vector2.new(self.mainContainer.Position.X.Offset, self.mainContainer.Position.Y.Offset)
            
            CreateTween(self.mainContainer, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                Size = UDim2.new(0, 505, 0, 385)
            }):Play()
        end
    end)
    
    InputService.InputChanged:Connect(function(input)
        if self.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = InputService:GetMouseLocation()
            local delta = mousePos - self.dragStart
            
            local screenSize = workspace.CurrentCamera.ViewportSize
            local containerSize = self.mainContainer.AbsoluteSize
            
            local newX = math.clamp(self.windowStart.X + delta.X, containerSize.X/2, screenSize.X - containerSize.X/2)
            local newY = math.clamp(self.windowStart.Y + delta.Y, containerSize.Y/2, screenSize.Y - containerSize.Y/2)
            
            self.mainContainer.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
    
    InputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if self.dragging then
                self.dragging = false
                CreateTween(self.mainContainer, 0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {
                    Size = UDim2.new(0, 500, 0, 380)
                }):Play()
            end
        end
    end)
    
    -- 胶囊按钮拖拽
    local btnDragging = false
    local btnDragStart = Vector2.new(0, 0)
    local btnFrameStart = Vector2.new(0, 0)
    
    self.toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            btnDragging = true
            btnDragStart = InputService:GetMouseLocation()
            btnFrameStart = Vector2.new(self.toggleButton.Position.X.Offset, self.toggleButton.Position.Y.Offset)
            
            CreateTween(self.toggleButton, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                Size = UDim2.new(0, 125, 0, 48)
            }):Play()
        end
    end)
    
    InputService.InputChanged:Connect(function(input)
        if btnDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = InputService:GetMouseLocation()
            local delta = mousePos - btnDragStart
            
            local screenSize = workspace.CurrentCamera.ViewportSize
            local btnSize = self.toggleButton.AbsoluteSize
            
            local newX = math.clamp(btnFrameStart.X + delta.X, 0, screenSize.X - btnSize.X)
            local newY = math.clamp(btnFrameStart.Y + delta.Y, 0, screenSize.Y - btnSize.Y)
            
            self.toggleButton.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
    
    InputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if btnDragging then
                btnDragging = false
                CreateTween(self.toggleButton, 0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {
                    Size = UDim2.new(0, 120, 0, 45)
                }):Play()
            end
        end
    end)
    
    -- 快捷键
    InputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightControl then
            self:ToggleWindow()
        end
    end)
    
    ZG_XG.currentUI = self
    return self
end
-- 显示/隐藏窗口
function ZG_XG:ToggleWindow()
    self.isVisible = not self.isVisible
    
    if self.isVisible then
        self.toggleButton.Text = "🔒 隐藏面板"
        self.mainContainer.Visible = true
        
        -- 显示动画
        self.mainContainer.Position = UDim2.new(0.5, 0, 0.5, -60)
        self.mainContainer.Size = UDim2.new(0, 20, 0, 20)
        self.mainContainer.Rotation = -45
        
        CreateTween(self.mainContainer, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {
            Size = UDim2.new(0, 500, 0, 380),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Rotation = 0
        }):Play()
    else
        self.toggleButton.Text = "🔓 打开面板"
        
        -- 隐藏动画
        CreateTween(self.mainContainer, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In, {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0.5, 0, 0.5, 60),
            Rotation = 45
        }):Play()
        
        task.wait(0.4)
        self.mainContainer.Visible = false
        self.mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
        self.mainContainer.Size = UDim2.new(0, 500, 0, 380)
        self.mainContainer.Rotation = 0
    end
end

-- 创建标签
function ZG_XG:Tab(name)
    local tabData = {}
    
    -- 胶囊型标签按钮
    local tabButton = Instance.new("TextButton")
    tabButton.Name = "TabButton_" .. name
    tabButton.Parent = self.tabContainer
    tabButton.Size = UDim2.new(1, -10, 0, 45)
    tabButton.BackgroundColor3 = Colors.Secondary
    tabButton.BackgroundTransparency = 0.3
    tabButton.AutoButtonColor = false
    tabButton.Text = ""
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = tabButton
    
    -- 标签霓虹边框
    local tabBorder = Instance.new("Frame")
    tabBorder.Name = "TabBorder"
    tabBorder.Parent = tabButton
    tabBorder.Size = UDim2.new(1, 4, 1, 4)
    tabBorder.Position = UDim2.new(0, -2, 0, -2)
    tabBorder.BackgroundColor3 = Colors.Accent
    tabBorder.BackgroundTransparency = 0.6
    tabBorder.ZIndex = -1
    
    local tabBorderCorner = Instance.new("UICorner")
    tabBorderCorner.CornerRadius = UDim.new(0, 12)
    tabBorderCorner.Parent = tabBorder
    
    -- 标签图标
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.Name = "TabIcon"
    tabIcon.Parent = tabButton
    tabIcon.Size = UDim2.new(0, 26, 0, 26)
    tabIcon.Position = UDim2.new(0.5, -13, 0.5, -13)
    tabIcon.Image = "rbxassetid://10734982100"
    tabIcon.BackgroundTransparency = 1
    tabIcon.ImageColor3 = Colors.Text
    
    -- 标签文本
    local tabText = Instance.new("TextLabel")
    tabText.Name = "TabText"
    tabText.Parent = tabButton
    tabText.Size = UDim2.new(1, 0, 0, 16)
    tabText.Position = UDim2.new(0, 0, 1, -14)
    tabText.Text = name
    tabText.TextColor3 = Colors.Text
    tabText.Font = Enum.Font.GothamMedium
    tabText.TextSize = 12
    tabText.BackgroundTransparency = 1
    
    -- 内容页面
    local contentPage = Instance.new("ScrollingFrame")
    contentPage.Name = "ContentPage_" .. name
    contentPage.Parent = self.contentArea
    contentPage.Size = UDim2.new(1, 0, 1, 0)
    contentPage.BackgroundTransparency = 1
    contentPage.ScrollBarThickness = 4
    contentPage.ScrollBarImageColor3 = Colors.Accent
    contentPage.ScrollBarImageTransparency = 0.6
    contentPage.Visible = false
    
    -- 平滑滚动
    local function SetupSmoothScroll(frame)
        local scrolling = false
        frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if not scrolling then
                scrolling = true
                CreateTween(frame, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    CanvasPosition = Vector2.new(0, frame.CanvasPosition.Y)
                }):Play()
                task.wait(0.2)
                scrolling = false
            end
        end)
    end
    
    SetupSmoothScroll(contentPage)
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Parent = contentPage
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 12)
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.Parent = contentPage
    contentPadding.PaddingTop = UDim.new(0, 12)
    contentPadding.PaddingBottom = UDim.new(0, 12)
    contentPadding.PaddingLeft = UDim.new(0, 12)
    contentPadding.PaddingRight = UDim.new(0, 12)
    
    -- 标签悬停效果
    tabButton.MouseEnter:Connect(function()
        if not tabData.isActive then
            CreateTween(tabButton, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                BackgroundTransparency = 0.2,
                Size = UDim2.new(1, -8, 0, 48)
            }):Play()
            
            CreateTween(tabBorder, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                BackgroundTransparency = 0.4
            }):Play()
            
            CreateTween(tabIcon, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                ImageColor3 = Colors.Accent,
                Size = UDim2.new(0, 28, 0, 28)
            }):Play()
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if not tabData.isActive then
            CreateTween(tabButton, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                BackgroundTransparency = 0.3,
                Size = UDim2.new(1, -10, 0, 45)
            }):Play()
            
            CreateTween(tabBorder, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                BackgroundTransparency = 0.6
            }):Play()
            
            CreateTween(tabIcon, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                ImageColor3 = Colors.Text,
                Size = UDim2.new(0, 26, 0, 26)
            }):Play()
        end
    end)
    
    -- 标签点击事件
    tabButton.MouseButton1Click:Connect(function()
        self:SwitchTab(tabData, tabButton, contentPage, tabBorder)
    end)
    
    tabData.button = tabButton
    tabData.content = contentPage
    tabData.border = tabBorder
    tabData.isActive = false
    
    table.insert(self.tabs, tabData)
    
    -- 如果是第一个标签，默认激活
    if #self.tabs == 1 then
        self:SwitchTab(tabData, tabButton, contentPage, tabBorder)
    end
    
    local tabFunctions = {}
    
    -- 创建分区
    function tabFunctions:Section(sectionName)
        local sectionFrame = Instance.new("Frame")
        sectionFrame.Name = "Section_" .. sectionName
        sectionFrame.Parent = contentPage
        sectionFrame.Size = UDim2.new(1, 0, 0, 0)
        sectionFrame.BackgroundColor3 = Colors.Secondary
        sectionFrame.BackgroundTransparency = 0.2
        
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 12)
        sectionCorner.Parent = sectionFrame
        
        -- 分区霓虹边框
        local sectionBorder = Instance.new("Frame")
        sectionBorder.Name = "SectionBorder"
        sectionBorder.Parent = sectionFrame
        sectionBorder.Size = UDim2.new(1, 4, 1, 4)
        sectionBorder.Position = UDim2.new(0, -2, 0, -2)
        sectionBorder.BackgroundColor3 = Colors.Accent
        sectionBorder.BackgroundTransparency = 0.5
        
        local sectionBorderCorner = Instance.new("UICorner")
        sectionBorderCorner.CornerRadius = UDim.new(0, 14)
        sectionBorderCorner.Parent = sectionBorder
        
        -- 分区标题
        local sectionHeader = Instance.new("TextButton")
        sectionHeader.Name = "SectionHeader"
        sectionHeader.Parent = sectionFrame
        sectionHeader.Size = UDim2.new(1, 0, 0, 38)
        sectionHeader.BackgroundTransparency = 1
        sectionHeader.Text = ""
        
        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Name = "SectionTitle"
        sectionTitle.Parent = sectionHeader
        sectionTitle.Size = UDim2.new(1, -40, 1, 0)
        sectionTitle.Position = UDim2.new(0, 15, 0, 0)
        sectionTitle.Text = sectionName
        sectionTitle.TextColor3 = Colors.Text
        sectionTitle.Font = Enum.Font.GothamSemibold
        sectionTitle.TextSize = 15
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.BackgroundTransparency = 1
        
        local expandIcon = Instance.new("ImageLabel")
        expandIcon.Name = "ExpandIcon"
        expandIcon.Parent = sectionHeader
        expandIcon.Size = UDim2.new(0, 18, 0, 18)
        expandIcon.Position = UDim2.new(1, -25, 0.5, -9)
        expandIcon.Image = "rbxassetid://10734980828"
        expandIcon.ImageColor3 = Colors.Text
        expandIcon.BackgroundTransparency = 1
        expandIcon.Rotation = 90
        
        -- 分区内容
        local sectionContent = Instance.new("Frame")
        sectionContent.Name = "SectionContent"
        sectionContent.Parent = sectionFrame
        sectionContent.Size = UDim2.new(1, -20, 0, 0)
        sectionContent.Position = UDim2.new(0, 10, 0, 43)
        sectionContent.BackgroundTransparency = 1
        
        local contentList = Instance.new("UIListLayout")
        contentList.Parent = sectionContent
        contentList.SortOrder = Enum.SortOrder.LayoutOrder
        contentList.Padding = UDim.new(0, 8)
        
        local isExpanded = true
        
        local function toggleSection()
            isExpanded = not isExpanded
            
            if isExpanded then
                CreateTween(expandIcon, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    Rotation = 90
                }):Play()
                
                CreateTween(sectionFrame, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    Size = UDim2.new(1, 0, 0, 43 + contentList.AbsoluteContentSize.Y + 10)
                }):Play()
                
                CreateTween(sectionContent, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    Size = UDim2.new(1, -20, 0, contentList.AbsoluteContentSize.Y)
                }):Play()
            else
                CreateTween(expandIcon, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    Rotation = 0
                }):Play()
                
                CreateTween(sectionFrame, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    Size = UDim2.new(1, 0, 0, 38)
                }):Play()
                
                CreateTween(sectionContent, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    Size = UDim2.new(1, -20, 0, 0)
                }):Play()
            end
        end
        
        sectionHeader.MouseButton1Click:Connect(toggleSection)
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if isExpanded then
                sectionFrame.Size = UDim2.new(1, 0, 0, 43 + contentList.AbsoluteContentSize.Y + 10)
                sectionContent.Size = UDim2.new(1, -20, 0, contentList.AbsoluteContentSize.Y)
                contentPage.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
            end
        end)
        
        local sectionFunctions = {}
        
        -- 创建按钮（支持ZG_XG:Button格式）
        function sectionFunctions:Button(buttonText, callback)
            -- 胶囊型按钮
            local button = Instance.new("TextButton")
            button.Name = "Button_" .. buttonText
            button.Parent = sectionContent
            button.Size = UDim2.new(1, 0, 0, 36)
            button.BackgroundColor3 = Colors.Secondary
            button.BackgroundTransparency = 0.3
            button.AutoButtonColor = false
            button.Text = ""
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 10)
            buttonCorner.Parent = button
            
            -- 按钮霓虹边框
            local buttonBorder = Instance.new("Frame")
            buttonBorder.Name = "ButtonBorder"
            buttonBorder.Parent = button
            buttonBorder.Size = UDim2.new(1, 4, 1, 4)
            buttonBorder.Position = UDim2.new(0, -2, 0, -2)
            buttonBorder.BackgroundColor3 = Colors.Accent
            buttonBorder.BackgroundTransparency = 0.6
            buttonBorder.ZIndex = -1
            
            local buttonBorderCorner = Instance.new("UICorner")
            buttonBorderCorner.CornerRadius = UDim.new(0, 12)
            buttonBorderCorner.Parent = buttonBorder
            
            local buttonLabel = Instance.new("TextLabel")
            buttonLabel.Parent = button
            buttonLabel.Size = UDim2.new(1, 0, 1, 0)
            buttonLabel.Text = buttonText
            buttonLabel.TextColor3 = Colors.Text
            buttonLabel.Font = Enum.Font.Gotham
            buttonLabel.TextSize = 14
            buttonLabel.BackgroundTransparency = 1
            
            -- 按钮悬停效果
            button.MouseEnter:Connect(function()
                CreateTween(button, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    BackgroundTransparency = 0.2,
                    Size = UDim2.new(1, -2, 0, 38)
                }):Play()
                
                CreateTween(buttonBorder, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    BackgroundTransparency = 0.4
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                CreateTween(button, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    BackgroundTransparency = 0.3,
                    Size = UDim2.new(1, 0, 0, 36)
                }):Play()
                
                CreateTween(buttonBorder, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    BackgroundTransparency = 0.6
                }):Play()
            end)
            
            -- 按钮点击效果
            button.MouseButton1Click:Connect(function()
                CreateTween(button, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    Size = UDim2.new(1, -6, 0, 34)
                }):Play()
                
                task.wait(0.1)
                
                CreateTween(button, 0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {
                    Size = UDim2.new(1, 0, 0, 36)
                }):Play()
                
                if callback then
                    callback()
                end
            end)
            
            -- 添加到全局ZG_XG对象，支持ZG_XG:Button格式
            ZG_XG[buttonText] = button
            
            return button
        end
        
        -- 创建开关（支持ZG_XG:Toggle格式）
        function sectionFunctions:Toggle(toggleText, flag, defaultValue, callback)
            local state = defaultValue or false
            ZG_XG.flags[flag] = state
            
            local toggle = Instance.new("TextButton")
            toggle.Name = "Toggle_" .. toggleText
            toggle.Parent = sectionContent
            toggle.Size = UDim2.new(1, 0, 0, 36)
            toggle.BackgroundColor3 = Colors.Secondary
            toggle.BackgroundTransparency = 0.3
            toggle.AutoButtonColor = false
            toggle.Text = ""
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 10)
            toggleCorner.Parent = toggle
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Parent = toggle
            toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            toggleLabel.Position = UDim2.new(0, 12, 0, 0)
            toggleLabel.Text = toggleText
            toggleLabel.TextColor3 = Colors.Text
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.TextSize = 14
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.BackgroundTransparency = 1
            
            local toggleSwitch = Instance.new("Frame")
            toggleSwitch.Parent = toggle
            toggleSwitch.Size = UDim2.new(0, 50, 0, 26)
            toggleSwitch.Position = UDim2.new(1, -60, 0.5, -13)
            toggleSwitch.BackgroundColor3 = Colors.Border
            
            local switchCorner = Instance.new("UICorner")
            switchCorner.CornerRadius = UDim.new(1, 0)
            switchCorner.Parent = toggleSwitch
            
            local toggleKnob = Instance.new("Frame")
            toggleKnob.Parent = toggleSwitch
            toggleKnob.Size = UDim2.new(0, 22, 0, 22)
            toggleKnob.Position = UDim2.new(0, 2, 0.5, -11)
            toggleKnob.BackgroundColor3 = Colors.Text
            
            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(1, 0)
            knobCorner.Parent = toggleKnob
            
            local function updateToggle()
                if state then
                    CreateTween(toggleKnob, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {
                        Position = UDim2.new(1, -24, 0.5, -11),
                        BackgroundColor3 = Colors.Green
                    }):Play()
                    
                    CreateTween(toggleSwitch, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                        BackgroundColor3 = Color3.fromRGB(30, 80, 30)
                    }):Play()
                else
                    CreateTween(toggleKnob, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {
                        Position = UDim2.new(0, 2, 0.5, -11),
                        BackgroundColor3 = Colors.Text
                    }):Play()
                    
                    CreateTween(toggleSwitch, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                        BackgroundColor3 = Colors.Border
                    }):Play()
                end
                
                ZG_XG.flags[flag] = state
                if callback then
                    callback(state)
                end
            end
            
            toggle.MouseButton1Click:Connect(function()
                state = not state
                updateToggle()
            end)
            
            toggle.MouseEnter:Connect(function()
                CreateTween(toggle, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    BackgroundTransparency = 0.2
                }):Play()
            end)
            
            toggle.MouseLeave:Connect(function()
                CreateTween(toggle, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    BackgroundTransparency = 0.3
                }):Play()
            end)
            
            updateToggle()
            
            -- 添加到全局ZG_XG对象
            ZG_XG[flag] = {
                Set = function(s)
                    state = s
                    updateToggle()
                end,
                Get = function()
                    return state
                end
            }
            
            return ZG_XG[flag]
        end
        
        return sectionFunctions
    end
    
    -- 快捷方法：直接创建按钮
    function tabFunctions:Button(text, callback)
        local section = self:Section("功能")
        return section:Button(text, callback)
    end
    
    -- 快捷方法：直接创建开关
    function tabFunctions:Toggle(text, flag, defaultValue, callback)
        local section = self:Section("设置")
        return section:Toggle(text, flag, defaultValue, callback)
    end
    
    return tabFunctions
end

-- 切换标签
function ZG_XG:SwitchTab(tabData, tabButton, contentPage, tabBorder)
    if self.currentTab == tabData then return end
    
    -- 关闭当前标签
    if self.currentTab then
        local oldTab = self.currentTab
        
        CreateTween(oldTab.button, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
            BackgroundTransparency = 0.3,
            Size = UDim2.new(1, -10, 0, 45)
        }):Play()
        
        CreateTween(oldTab.border, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
            BackgroundTransparency = 0.6
        }):Play()
        
        CreateTween(oldTab.button.TabIcon, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
            ImageColor3 = Colors.Text,
            Size = UDim2.new(0, 26, 0, 26)
        }):Play()
        
        if oldTab.content.Visible then
            CreateTween(oldTab.content, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.new(0, 0, 1, 0)
            }):Play()
            
            task.wait(0.2)
            oldTab.content.Visible = false
            oldTab.content.Position = UDim2.new(0, 0, 0, 0)
            oldTab.content.Size = UDim2.new(1, 0, 1, 0)
        end
        
        oldTab.isActive = false
    end
    
    -- 激活新标签
    self.currentTab = tabData
    tabData.isActive = true
    
    CreateTween(tabButton, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {
        BackgroundTransparency = 0.1,
        Size = UDim2.new(1, -5, 0, 50)
    }):Play()
    
    CreateTween(tabBorder, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {
        BackgroundTransparency = 0.3
    }):Play()
    
    CreateTween(tabButton.TabIcon, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {
        ImageColor3 = Colors.Accent,
        Size = UDim2.new(0, 30, 0, 30)
    }):Play()
    
    -- 内容页面滑入动画
    contentPage.Visible = true
    contentPage.Position = UDim2.new(-1, 0, 0, 0)
    contentPage.Size = UDim2.new(0, 0, 1, 0)
    
    CreateTween(contentPage, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.2, {
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()
end

-- 销毁UI
function ZG_XG:Destroy()
    if self.screenGui then
        self.screenGui:Destroy()
    end
    ZG_XG.currentUI = nil
end

-- 全局创建函数
function ZG_XG.Create(name)
    local ui = ZG_XG:CreateWindow(name)
    return ui
end

-- 返回ZG_XG对象
return ZG_XG