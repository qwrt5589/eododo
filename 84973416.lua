-- ZG_XG UI Library - Part 1: Core Framework
-- 可以直接放在GitHub上通过loadstring调用

repeat task.wait() until game:IsLoaded()

-- 服务引用
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- 全局对象
local ZG_XG = {}
ZG_XG.__index = ZG_XG
ZG_XG.flags = {}
ZG_XG.activeUI = nil

-- 动画函数
local function Tween(obj, info, props)
    return TweenService:Create(obj, TweenInfo.new(unpack(info)), props)
end

-- 创建UI主函数
function ZG_XG:Create(name)
    if ZG_XG.activeUI then
        ZG_XG.activeUI:Destroy()
    end
    
    local self = setmetatable({}, ZG_XG)
    self.name = name
    self.tabs = {}
    self.currentTab = nil
    self.isVisible = false
    
    -- 清理旧UI
    for _, v in pairs(CoreGui:GetChildren()) do
        if v.Name == "ZG_XG_UI" then
            v:Destroy()
        end
    end
    
    -- 创建屏幕GUI
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "ZG_XG_UI"
    self.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.screenGui.Parent = CoreGui
    
    -- 胶囊开关按钮
    self.toggleBtn = Instance.new("TextButton")
    self.toggleBtn.Name = "ToggleBtn"
    self.toggleBtn.Parent = self.screenGui
    self.toggleBtn.Size = UDim2.new(0, 100, 0, 40)
    self.toggleBtn.Position = UDim2.new(0, 20, 0, 20)
    self.toggleBtn.Text = "打开面板"
    self.toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.toggleBtn.Font = Enum.Font.GothamSemibold
    self.toggleBtn.TextSize = 14
    self.toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 50)
    self.toggleBtn.BackgroundTransparency = 0.2
    self.toggleBtn.AutoButtonColor = true
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = self.toggleBtn
    
    -- 霓虹边框
    local btnBorder = Instance.new("Frame")
    btnBorder.Parent = self.toggleBtn
    btnBorder.Size = UDim2.new(1, 4, 1, 4)
    btnBorder.Position = UDim2.new(0, -2, 0, -2)
    btnBorder.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    btnBorder.BackgroundTransparency = 0.6
    btnBorder.ZIndex = -1
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(1, 0)
    borderCorner.Parent = btnBorder
    
    -- 按钮悬停效果
    self.toggleBtn.MouseEnter:Connect(function()
        Tween(self.toggleBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0,
            Size = UDim2.new(0, 105, 0, 42)
        }):Play()
    end)
    
    self.toggleBtn.MouseLeave:Connect(function()
        Tween(self.toggleBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(0, 100, 0, 40)
        }):Play()
    end)
    
    -- 主窗口
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Name = "MainFrame"
    self.mainFrame.Parent = self.screenGui
    self.mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.mainFrame.Size = UDim2.new(0, 450, 0, 350)
    self.mainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
    self.mainFrame.BackgroundTransparency = 0.1
    self.mainFrame.BorderSizePixel = 0
    self.mainFrame.ClipsDescendants = true
    self.mainFrame.Visible = false
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = self.mainFrame
    
    -- 霓虹主边框
    local mainBorder = Instance.new("Frame")
    mainBorder.Parent = self.mainFrame
    mainBorder.Size = UDim2.new(1, 4, 1, 4)
    mainBorder.Position = UDim2.new(0, -2, 0, -2)
    mainBorder.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    mainBorder.BackgroundTransparency = 0.7
    mainBorder.ZIndex = -1
    
    local mainBorderCorner = Instance.new("UICorner")
    mainBorderCorner.CornerRadius = UDim.new(0, 14)
    mainBorderCorner.Parent = mainBorder
    
    -- 霓虹动画
    spawn(function()
        while self.screenGui and self.screenGui.Parent do
            local time = tick()
            local pulse = math.sin(time * 2) * 0.1 + 0.8
            mainBorder.BackgroundTransparency = 1 - pulse * 0.7
            btnBorder.BackgroundTransparency = 1 - pulse * 0.6
            task.wait()
        end
    end)
    
    -- 标题栏
    self.titleBar = Instance.new("Frame")
    self.titleBar.Parent = self.mainFrame
    self.titleBar.Size = UDim2.new(1, 0, 0, 35)
    self.titleBar.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    self.titleBar.BackgroundTransparency = 0.2
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12, 0, 0)
    titleCorner.Parent = self.titleBar
    
    -- 窗口标题
    self.titleLabel = Instance.new("TextLabel")
    self.titleLabel.Parent = self.titleBar
    self.titleLabel.Size = UDim2.new(1, -80, 1, 0)
    self.titleLabel.Position = UDim2.new(0, 15, 0, 0)
    self.titleLabel.Text = name
    self.titleLabel.TextColor3 = Color3.fromRGB(180, 220, 255)
    self.titleLabel.Font = Enum.Font.GothamSemibold
    self.titleLabel.TextSize = 15
    self.titleLabel.BackgroundTransparency = 1
    self.titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 标题霓虹渐变
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 255, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 255))
    })
    titleGradient.Parent = self.titleLabel
    
    spawn(function()
        while self.titleLabel and self.titleLabel.Parent do
            titleGradient.Offset = Vector2.new((tick() * 0.2) % 1, 0)
            task.wait()
        end
    end)
    
    -- 关闭按钮
    self.closeBtn = Instance.new("TextButton")
    self.closeBtn.Parent = self.titleBar
    self.closeBtn.Size = UDim2.new(0, 25, 0, 25)
    self.closeBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
    self.closeBtn.Text = "×"
    self.closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.closeBtn.Font = Enum.Font.GothamBold
    self.closeBtn.TextSize = 18
    self.closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    self.closeBtn.BackgroundTransparency = 0.3
    self.closeBtn.AutoButtonColor = false
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = self.closeBtn
    
    -- 侧边栏
    self.sideBar = Instance.new("Frame")
    self.sideBar.Parent = self.mainFrame
    self.sideBar.Size = UDim2.new(0, 90, 1, -35)
    self.sideBar.Position = UDim2.new(0, 0, 0, 35)
    self.sideBar.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    self.sideBar.BackgroundTransparency = 0.2
    
    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 0, 0, 12)
    sideCorner.Parent = self.sideBar
    
    -- 标签容器
    self.tabContainer = Instance.new("ScrollingFrame")
    self.tabContainer.Parent = self.sideBar
    self.tabContainer.Size = UDim2.new(1, -5, 1, -10)
    self.tabContainer.Position = UDim2.new(0, 5, 0, 5)
    self.tabContainer.BackgroundTransparency = 1
    self.tabContainer.ScrollBarThickness = 2
    self.tabContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 180, 255)
    self.tabContainer.ScrollBarImageTransparency = 0.6
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = self.tabContainer
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 8)
    
    -- 内容区域
    self.contentArea = Instance.new("Frame")
    self.contentArea.Parent = self.mainFrame
    self.contentArea.Size = UDim2.new(1, -90, 1, -35)
    self.contentArea.Position = UDim2.new(0, 90, 0, 35)
    self.contentArea.BackgroundTransparency = 1
    self.contentArea.ClipsDescendants = true
    
    -- 布局监听
    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 10)
    end)
    
    -- 平滑滚动
    local function SmoothScroll(frame)
        local scrolling = false
        frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if not scrolling then
                scrolling = true
                Tween(frame, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    CanvasPosition = Vector2.new(0, frame.CanvasPosition.Y)
                }):Play()
                task.wait(0.2)
                scrolling = false
            end
        end)
    end
    
    SmoothScroll(self.tabContainer)
    
    -- 按钮事件
    self.toggleBtn.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    self.closeBtn.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    self.closeBtn.MouseEnter:Connect(function()
        Tween(self.closeBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0,
            Size = UDim2.new(0, 27, 0, 27)
        }):Play()
    end)
    
    self.closeBtn.MouseLeave:Connect(function()
        Tween(self.closeBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.3,
            Size = UDim2.new(0, 25, 0, 25)
        }):Play()
    end)
    
    -- 拖拽系统
    local dragging = false
    local dragStart, frameStart
    
    self.titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = UserInputService:GetMouseLocation()
            frameStart = Vector2.new(self.mainFrame.Position.X.Offset, self.mainFrame.Position.Y.Offset)
            
            Tween(self.mainFrame, {0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                Size = UDim2.new(0, 455, 0, 355)
            }):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = UserInputService:GetMouseLocation()
            local delta = mouse - dragStart
            
            local newX = frameStart.X + delta.X
            local newY = frameStart.Y + delta.Y
            
            self.mainFrame.Position = UDim2.new(0, math.clamp(newX, 0, 
                workspace.CurrentCamera.ViewportSize.X - self.mainFrame.AbsoluteSize.X),
                0, math.clamp(newY, 0, 
                workspace.CurrentCamera.ViewportSize.Y - self.mainFrame.AbsoluteSize.Y))
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if dragging then
                dragging = false
                Tween(self.mainFrame, {0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(0, 450, 0, 350)
                }):Play()
            end
        end
    end)
    
    -- 快捷键
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightControl then
            self:Toggle()
        end
    end)
    
    -- 胶囊按钮拖拽
    local btnDragging = false
    local btnDragStart, btnFrameStart
    
    self.toggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            btnDragging = true
            btnDragStart = UserInputService:GetMouseLocation()
            btnFrameStart = Vector2.new(self.toggleBtn.Position.X.Offset, self.toggleBtn.Position.Y.Offset)
            
            Tween(self.toggleBtn, {0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                Size = UDim2.new(0, 105, 0, 42)
            }):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if btnDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = UserInputService:GetMouseLocation()
            local delta = mouse - btnDragStart
            
            local newX = btnFrameStart.X + delta.X
            local newY = btnFrameStart.Y + delta.Y
            
            self.toggleBtn.Position = UDim2.new(0, math.clamp(newX, 0, 
                workspace.CurrentCamera.ViewportSize.X - self.toggleBtn.AbsoluteSize.X),
                0, math.clamp(newY, 0, 
                workspace.CurrentCamera.ViewportSize.Y - self.toggleBtn.AbsoluteSize.Y))
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if btnDragging then
                btnDragging = false
                Tween(self.toggleBtn, {0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(0, 100, 0, 40)
                }):Play()
            end
        end
    end)
    
    ZG_XG.activeUI = self
    return self
end
-- ZG_XG UI Library - Part 2: Tabs and Functions

-- 显示/隐藏UI
function ZG_XG:Toggle()
    self.isVisible = not self.isVisible
    
    if self.isVisible then
        self.toggleBtn.Text = "隐藏面板"
        self.mainFrame.Visible = true
        
        -- 显示动画
        self.mainFrame.Position = UDim2.new(0.5, 0, 0.5, -50)
        self.mainFrame.Size = UDim2.new(0, 20, 0, 20)
        self.mainFrame.Rotation = -30
        
        Tween(self.mainFrame, {0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
            Size = UDim2.new(0, 450, 0, 350),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Rotation = 0
        }):Play()
    else
        self.toggleBtn.Text = "打开面板"
        
        -- 隐藏动画
        Tween(self.mainFrame, {0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In}, {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0.5, 0, 0.5, 50),
            Rotation = 30
        }):Play()
        
        task.wait(0.4)
        self.mainFrame.Visible = false
        self.mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        self.mainFrame.Size = UDim2.new(0, 450, 0, 350)
        self.mainFrame.Rotation = 0
    end
end

-- 创建标签
function ZG_XG:Tab(name, icon)
    local tabData = {}
    
    -- 胶囊型标签按钮
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = "Tab_" .. name
    tabBtn.Parent = self.tabContainer
    tabBtn.Size = UDim2.new(1, -10, 0, 40)
    tabBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
    tabBtn.BackgroundTransparency = 0.4
    tabBtn.AutoButtonColor = false
    tabBtn.Text = ""
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = tabBtn
    
    -- 标签图标
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.Parent = tabBtn
    tabIcon.Size = UDim2.new(0, 24, 0, 24)
    tabIcon.Position = UDim2.new(0.5, -12, 0.5, -12)
    tabIcon.Image = icon or "rbxassetid://10734982100"
    tabIcon.BackgroundTransparency = 1
    tabIcon.ImageColor3 = Color3.fromRGB(200, 220, 240)
    
    -- 标签文本
    local tabText = Instance.new("TextLabel")
    tabText.Parent = tabBtn
    tabText.Size = UDim2.new(1, 0, 0, 14)
    tabText.Position = UDim2.new(0, 0, 1, -12)
    tabText.Text = name
    tabText.TextColor3 = Color3.fromRGB(200, 220, 240)
    tabText.Font = Enum.Font.GothamMedium
    tabText.TextSize = 11
    tabText.BackgroundTransparency = 1
    
    -- 内容页面
    local contentPage = Instance.new("ScrollingFrame")
    contentPage.Name = "Content_" .. name
    contentPage.Parent = self.contentArea
    contentPage.Size = UDim2.new(1, 0, 1, 0)
    contentPage.BackgroundTransparency = 1
    contentPage.ScrollBarThickness = 4
    contentPage.ScrollBarImageColor3 = Color3.fromRGB(100, 180, 255)
    contentPage.ScrollBarImageTransparency = 0.6
    contentPage.Visible = false
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Parent = contentPage
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.Parent = contentPage
    contentPadding.PaddingTop = UDim.new(0, 10)
    contentPadding.PaddingBottom = UDim.new(0, 10)
    contentPadding.PaddingLeft = UDim.new(0, 10)
    contentPadding.PaddingRight = UDim.new(0, 10)
    
    -- 标签悬停效果
    tabBtn.MouseEnter:Connect(function()
        if not tabData.isActive then
            Tween(tabBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                BackgroundTransparency = 0.2,
                Size = UDim2.new(1, -8, 0, 42)
            }):Play()
            
            Tween(tabIcon, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                ImageColor3 = Color3.fromRGB(150, 200, 255),
                Size = UDim2.new(0, 26, 0, 26)
            }):Play()
        end
    end)
    
    tabBtn.MouseLeave:Connect(function()
        if not tabData.isActive then
            Tween(tabBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                BackgroundTransparency = 0.4,
                Size = UDim2.new(1, -10, 0, 40)
            }):Play()
            
            Tween(tabIcon, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                ImageColor3 = Color3.fromRGB(200, 220, 240),
                Size = UDim2.new(0, 24, 0, 24)
            }):Play()
        end
    end)
    
    -- 标签点击事件
    tabBtn.MouseButton1Click:Connect(function()
        self:SwitchTab(tabData, tabBtn, contentPage)
    end)
    
    tabData.button = tabBtn
    tabData.content = contentPage
    tabData.isActive = false
    
    table.insert(self.tabs, tabData)
    
    -- 第一个标签默认激活
    if #self.tabs == 1 then
        self:SwitchTab(tabData, tabBtn, contentPage)
    end
    
    local tabFunctions = {}
    
    -- 创建分区
    function tabFunctions:Section(name)
        local sectionFrame = Instance.new("Frame")
        sectionFrame.Name = "Section_" .. name
        sectionFrame.Parent = contentPage
        sectionFrame.Size = UDim2.new(1, 0, 0, 0)
        sectionFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
        sectionFrame.BackgroundTransparency = 0.3
        
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 8)
        sectionCorner.Parent = sectionFrame
        
        -- 分区标题
        local sectionHeader = Instance.new("TextButton")
        sectionHeader.Parent = sectionFrame
        sectionHeader.Size = UDim2.new(1, 0, 0, 35)
        sectionHeader.BackgroundTransparency = 1
        sectionHeader.Text = ""
        
        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Parent = sectionHeader
        sectionTitle.Size = UDim2.new(1, -40, 1, 0)
        sectionTitle.Position = UDim2.new(0, 10, 0, 0)
        sectionTitle.Text = name
        sectionTitle.TextColor3 = Color3.fromRGB(180, 220, 255)
        sectionTitle.Font = Enum.Font.GothamSemibold
        sectionTitle.TextSize = 14
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.BackgroundTransparency = 1
        
        local expandIcon = Instance.new("ImageLabel")
        expandIcon.Parent = sectionHeader
        expandIcon.Size = UDim2.new(0, 16, 0, 16)
        expandIcon.Position = UDim2.new(1, -25, 0.5, -8)
        expandIcon.Image = "rbxassetid://10734980828"
        expandIcon.ImageColor3 = Color3.fromRGB(200, 220, 240)
        expandIcon.BackgroundTransparency = 1
        expandIcon.Rotation = 90
        
        -- 分区内容
        local sectionContent = Instance.new("Frame")
        sectionContent.Parent = sectionFrame
        sectionContent.Size = UDim2.new(1, -20, 0, 0)
        sectionContent.Position = UDim2.new(0, 10, 0, 40)
        sectionContent.BackgroundTransparency = 1
        
        local contentList = Instance.new("UIListLayout")
        contentList.Parent = sectionContent
        contentList.SortOrder = Enum.SortOrder.LayoutOrder
        contentList.Padding = UDim.new(0, 6)
        
        local isExpanded = true
        
        local function toggleSection()
            isExpanded = not isExpanded
            
            if isExpanded then
                Tween(expandIcon, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    Rotation = 90
                }):Play()
                
                Tween(sectionFrame, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(1, 0, 0, 40 + contentList.AbsoluteContentSize.Y + 10)
                }):Play()
                
                Tween(sectionContent, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(1, -20, 0, contentList.AbsoluteContentSize.Y)
                }):Play()
            else
                Tween(expandIcon, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    Rotation = 0
                }):Play()
                
                Tween(sectionFrame, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(1, 0, 0, 35)
                }):Play()
                
                Tween(sectionContent, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(1, -20, 0, 0)
                }):Play()
            end
        end
        
        sectionHeader.MouseButton1Click:Connect(toggleSection)
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if isExpanded then
                sectionFrame.Size = UDim2.new(1, 0, 0, 40 + contentList.AbsoluteContentSize.Y + 10)
                sectionContent.Size = UDim2.new(1, -20, 0, contentList.AbsoluteContentSize.Y)
                contentPage.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
            end
        end)
        
        local sectionFunctions = {}
        
        -- 按钮功能
        function sectionFunctions:Button(text, callback)
            local button = Instance.new("TextButton")
            button.Parent = sectionContent
            button.Size = UDim2.new(1, 0, 0, 32)
            button.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
            button.BackgroundTransparency = 0.4
            button.AutoButtonColor = false
            button.Text = ""
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = button
            
            local buttonLabel = Instance.new("TextLabel")
            buttonLabel.Parent = button
            buttonLabel.Size = UDim2.new(1, 0, 1, 0)
            buttonLabel.Text = text
            buttonLabel.TextColor3 = Color3.fromRGB(220, 230, 255)
            buttonLabel.Font = Enum.Font.Gotham
            buttonLabel.TextSize = 13
            buttonLabel.BackgroundTransparency = 1
            
            button.MouseEnter:Connect(function()
                Tween(button, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundTransparency = 0.2,
                    Size = UDim2.new(1, -2, 0, 34)
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                Tween(button, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundTransparency = 0.4,
                    Size = UDim2.new(1, 0, 0, 32)
                }):Play()
            end)
            
            button.MouseButton1Click:Connect(function()
                Tween(button, {0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(1, -4, 0, 30)
                }):Play()
                
                task.wait(0.1)
                
                Tween(button, {0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(1, 0, 0, 32)
                }):Play()
                
                if callback then
                    callback()
                end
            end)
            
            -- 将按钮添加到ZG_XG对象
            ZG_XG[text] = button
            
            return button
        end
        
        -- 开关功能
        function sectionFunctions:Toggle(text, flag, defaultValue, callback)
            local state = defaultValue or false
            ZG_XG.flags[flag] = state
            
            local toggle = Instance.new("TextButton")
            toggle.Parent = sectionContent
            toggle.Size = UDim2.new(1, 0, 0, 32)
            toggle.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
            toggle.BackgroundTransparency = 0.4
            toggle.AutoButtonColor = false
            toggle.Text = ""
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggle
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Parent = toggle
            toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            toggleLabel.Position = UDim2.new(0, 10, 0, 0)
            toggleLabel.Text = text
            toggleLabel.TextColor3 = Color3.fromRGB(220, 230, 255)
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.TextSize = 13
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.BackgroundTransparency = 1
            
            local toggleSwitch = Instance.new("Frame")
            toggleSwitch.Parent = toggle
            toggleSwitch.Size = UDim2.new(0, 45, 0, 22)
            toggleSwitch.Position = UDim2.new(1, -55, 0.5, -11)
            toggleSwitch.BackgroundColor3 = Color3.fromRGB(60, 65, 75)
            
            local switchCorner = Instance.new("UICorner")
            switchCorner.CornerRadius = UDim.new(1, 0)
            switchCorner.Parent = toggleSwitch
            
            local toggleKnob = Instance.new("Frame")
            toggleKnob.Parent = toggleSwitch
            toggleKnob.Size = UDim2.new(0, 18, 0, 18)
            toggleKnob.Position = UDim2.new(0, 2, 0.5, -9)
            toggleKnob.BackgroundColor3 = Color3.fromRGB(220, 230, 255)
            
            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(1, 0)
            knobCorner.Parent = toggleKnob
            
            local function updateToggle()
                if state then
                    Tween(toggleKnob, {0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
                        Position = UDim2.new(1, -20, 0.5, -9),
                        BackgroundColor3 = Color3.fromRGB(100, 220, 100)
                    }):Play()
                    
                    Tween(toggleSwitch, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                        BackgroundColor3 = Color3.fromRGB(30, 100, 30)
                    }):Play()
                else
                    Tween(toggleKnob, {0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
                        Position = UDim2.new(0, 2, 0.5, -9),
                        BackgroundColor3 = Color3.fromRGB(220, 230, 255)
                    }):Play()
                    
                    Tween(toggleSwitch, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                        BackgroundColor3 = Color3.fromRGB(60, 65, 75)
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
                Tween(toggle, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundTransparency = 0.2
                }):Play()
            end)
            
            toggle.MouseLeave:Connect(function()
                Tween(toggle, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundTransparency = 0.4
                }):Play()
            end)
            
            updateToggle()
            
            -- 将开关添加到ZG_XG对象
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
    
    -- 创建按钮的快捷方法（支持ZG_XG:Button格式）
    function tabFunctions:Button(text, callback)
        local section = self:Section("功能")
        return section:Button(text, callback)
    end
    
    -- 创建开关的快捷方法
    function tabFunctions:Toggle(text, flag, defaultValue, callback)
        local section = self:Section("设置")
        return section:Toggle(text, flag, defaultValue, callback)
    end
    
    return tabFunctions
end

-- 切换标签
function ZG_XG:SwitchTab(tabData, tabBtn, contentPage)
    if self.currentTab == tabData then return end
    
    -- 关闭当前标签
    if self.currentTab then
        local oldTab = self.currentTab
        
        Tween(oldTab.button, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.4,
            Size = UDim2.new(1, -10, 0, 40)
        }):Play()
        
        Tween(oldTab.button.TabIcon, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            ImageColor3 = Color3.fromRGB(200, 220, 240),
            Size = UDim2.new(0, 24, 0, 24)
        }):Play()
        
        if oldTab.content.Visible then
            Tween(oldTab.content, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                Position = UDim2.new(1, 0, 0, 0)
            }):Play()
            
            task.wait(0.2)
            oldTab.content.Visible = false
            oldTab.content.Position = UDim2.new(0, 0, 0, 0)
        end
        
        oldTab.isActive = false
    end
    
    -- 激活新标签
    self.currentTab = tabData
    tabData.isActive = true
    
    Tween(tabBtn, {0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
        BackgroundTransparency = 0.2,
        Size = UDim2.new(1, -5, 0, 44)
    }):Play()
    
    Tween(tabBtn.TabIcon, {0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
        ImageColor3 = Color3.fromRGB(100, 200, 255),
        Size = UDim2.new(0, 28, 0, 28)
    }):Play()
    
    -- 内容页面动画
    contentPage.Visible = true
    contentPage.Position = UDim2.new(-1, 0, 0, 0)
    
    Tween(contentPage, {0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.2}, {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
end

-- 销毁UI
function ZG_XG:Destroy()
    if self.screenGui then
        self.screenGui:Destroy()
    end
    ZG_XG.activeUI = nil
end

-- 创建全局函数以便直接调用
function ZG_XG.Create(name)
    local ui = ZG_XG.new(name)
    return ui
end

-- 返回ZG_XG对象
return ZG_XG