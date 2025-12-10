-- ZG_XG UI 库 - 第一部分：基础框架
repeat task.wait() until game:IsLoaded()

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- 动画函数
local function Tween(obj, info, props)
    return TweenService:Create(obj, TweenInfo.new(unpack(info)), props)
end

-- 主UI库
local ZG_XG = {}
ZG_XG.flags = {}
ZG_XG.__index = ZG_XG

function ZG_XG.new(name)
    local self = setmetatable({}, ZG_XG)
    self.name = name
    self.tabs = {}
    self.currentTab = nil
    self.isVisible = false
    
    -- 清理旧UI
    for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "ZG_XG_UI" then
            v:Destroy()
        end
    end
    
    -- 创建主GUI
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "ZG_XG_UI"
    self.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    if syn and syn.protect_gui then
        syn.protect_gui(self.screenGui)
    end
    
    self.screenGui.Parent = game:GetService("CoreGui")
    
    -- 胶囊开关按钮（可拖动）
    self.toggleBtn = Instance.new("TextButton")
    self.toggleBtn.Name = "ToggleBtn"
    self.toggleBtn.Parent = self.screenGui
    self.toggleBtn.Size = UDim2.new(0, 100, 0, 40)
    self.toggleBtn.Position = UDim2.new(0, 20, 0.5, -20)
    self.toggleBtn.Text = "打开面板"
    self.toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.toggleBtn.Font = Enum.Font.GothamSemibold
    self.toggleBtn.TextSize = 14
    self.toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    self.toggleBtn.BackgroundTransparency = 0.2
    self.toggleBtn.AutoButtonColor = true
    self.toggleBtn.Active = true
    self.toggleBtn.Draggable = false
    
    -- 胶囊圆角
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = self.toggleBtn
    
    -- 胶囊霓虹边框
    local btnBorder = Instance.new("Frame")
    btnBorder.Name = "CapsuleBorder"
    btnBorder.Parent = self.toggleBtn
    btnBorder.Size = UDim2.new(1, 6, 1, 6)
    btnBorder.Position = UDim2.new(0, -3, 0, -3)
    btnBorder.BackgroundTransparency = 1
    
    local borderGradient = Instance.new("UIGradient")
    borderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 165, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    })
    borderGradient.Rotation = 0
    borderGradient.Parent = btnBorder
    
    local borderInner = Instance.new("Frame")
    borderInner.Parent = btnBorder
    borderInner.Size = UDim2.new(1, 0, 1, 0)
    borderInner.BackgroundColor3 = Color3.new(1, 1, 1)
    borderInner.BackgroundTransparency = 0.3
    
    local innerCorner = Instance.new("UICorner")
    innerCorner.CornerRadius = UDim.new(1, 0)
    innerCorner.Parent = borderInner
    
    -- 霓虹动画
    spawn(function()
        while true do
            local time = tick()
            borderGradient.Offset = Vector2.new((time * 0.3) % 1, 0)
            
            local pulse = math.sin(time * 2) * 0.2 + 0.8
            borderInner.BackgroundTransparency = 1 - pulse * 0.7
            
            task.wait()
        end
    end)
    
    -- 胶囊按钮悬停效果
    self.toggleBtn.MouseEnter:Connect(function()
        Tween(self.toggleBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0,
            Size = UDim2.new(0, 110, 0, 44)
        }):Play()
    end)
    
    self.toggleBtn.MouseLeave:Connect(function()
        Tween(self.toggleBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(0, 100, 0, 40)
        }):Play()
    end)
    
    -- 主窗口（可拖动）
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Name = "MainFrame"
    self.mainFrame.Parent = self.screenGui
    self.mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.mainFrame.Size = UDim2.new(0, 400, 0, 280)
    self.mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    self.mainFrame.BackgroundTransparency = 0.1
    self.mainFrame.BorderSizePixel = 0
    self.mainFrame.ClipsDescendants = true
    self.mainFrame.Visible = false
    self.mainFrame.Active = true
    self.mainFrame.Draggable = false
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = self.mainFrame
    
    -- 霓虹主边框
    local mainBorder = Instance.new("Frame")
    mainBorder.Name = "MainNeonBorder"
    mainBorder.Parent = self.mainFrame
    mainBorder.Size = UDim2.new(1, 6, 1, 6)
    mainBorder.Position = UDim2.new(0, -3, 0, -3)
    mainBorder.BackgroundTransparency = 1
    
    local mainGradient = Instance.new("UIGradient")
    mainGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 150, 50)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 255, 50)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(50, 150, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(150, 50, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 255))
    })
    mainGradient.Parent = mainBorder
    
    local mainBorderInner = Instance.new("Frame")
    mainBorderInner.Parent = mainBorder
    mainBorderInner.Size = UDim2.new(1, 0, 1, 0)
    mainBorderInner.BackgroundColor3 = Color3.new(1, 1, 1)
    mainBorderInner.BackgroundTransparency = 0.4
    
    local mainInnerCorner = Instance.new("UICorner")
    mainInnerCorner.CornerRadius = UDim.new(0, 15)
    mainInnerCorner.Parent = mainBorderInner
    
    -- 主边框霓虹动画
    spawn(function()
        while true do
            local time = tick()
            mainGradient.Offset = Vector2.new((time * 0.5) % 1, 0)
            
            local glow = math.sin(time * 1.5) * 0.15 + 0.85
            mainBorderInner.BackgroundTransparency = 1 - glow * 0.6
            
            task.wait()
        end
    end)
    
    -- 标题栏（用于拖动）
    self.titleBar = Instance.new("Frame")
    self.titleBar.Name = "TitleBar"
    self.titleBar.Parent = self.mainFrame
    self.titleBar.Size = UDim2.new(1, 0, 0, 35)
    self.titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    self.titleBar.BackgroundTransparency = 0.3
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12, 0, 0)
    titleCorner.Parent = self.titleBar
    
    -- 窗口标题
    self.titleLabel = Instance.new("TextLabel")
    self.titleLabel.Parent = self.titleBar
    self.titleLabel.Size = UDim2.new(1, -80, 1, 0)
    self.titleLabel.Position = UDim2.new(0, 15, 0, 0)
    self.titleLabel.Text = name
    self.titleLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
    self.titleLabel.Font = Enum.Font.GothamSemibold
    self.titleLabel.TextSize = 15
    self.titleLabel.BackgroundTransparency = 1
    self.titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 标题霓虹效果
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 255, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 255))
    })
    titleGradient.Parent = self.titleLabel
    
    spawn(function()
        while true do
            titleGradient.Offset = Vector2.new((tick() * 0.2) % 1, 0)
            task.wait()
        end
    end)
    
    -- 关闭按钮（胶囊型）
    self.closeBtn = Instance.new("TextButton")
    self.closeBtn.Name = "CloseBtn"
    self.closeBtn.Parent = self.titleBar
    self.closeBtn.Size = UDim2.new(0, 26, 0, 26)
    self.closeBtn.Position = UDim2.new(1, -35, 0.5, -13)
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
    
    -- 关闭按钮边框
    local closeBorder = Instance.new("Frame")
    closeBorder.Parent = self.closeBtn
    closeBorder.Size = UDim2.new(1, 4, 1, 4)
    closeBorder.Position = UDim2.new(0, -2, 0, -2)
    closeBorder.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    closeBorder.BackgroundTransparency = 0.5
    
    local closeBorderCorner = Instance.new("UICorner")
    closeBorderCorner.CornerRadius = UDim.new(1, 0)
    closeBorderCorner.Parent = closeBorder
    
    -- 侧边栏（胶囊型标签容器）
    self.sideBar = Instance.new("Frame")
    self.sideBar.Name = "SideBar"
    self.sideBar.Parent = self.mainFrame
    self.sideBar.Size = UDim2.new(0, 85, 1, -35)
    self.sideBar.Position = UDim2.new(0, 0, 0, 35)
    self.sideBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    self.sideBar.BackgroundTransparency = 0.3
    
    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 0, 0, 12)
    sideCorner.Parent = self.sideBar
    
    -- 标签滚动容器
    self.tabContainer = Instance.new("ScrollingFrame")
    self.tabContainer.Name = "TabContainer"
    self.tabContainer.Parent = self.sideBar
    self.tabContainer.Size = UDim2.new(1, -10, 1, -10)
    self.tabContainer.Position = UDim2.new(0, 5, 0, 5)
    self.tabContainer.BackgroundTransparency = 1
    self.tabContainer.ScrollBarThickness = 3
    self.tabContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
    self.tabContainer.ScrollBarImageTransparency = 0.6
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = self.tabContainer
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 8)
    
    -- 内容区域
    self.contentArea = Instance.new("Frame")
    self.contentArea.Name = "ContentArea"
    self.contentArea.Parent = self.mainFrame
    self.contentArea.Size = UDim2.new(1, -85, 1, -35)
    self.contentArea.Position = UDim2.new(0, 85, 0, 35)
    self.contentArea.BackgroundTransparency = 1
    self.contentArea.ClipsDescendants = true
    
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
    
    -- 布局监听
    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 10)
    end)
    
    -- 胶囊开关按钮点击事件
    self.toggleBtn.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    -- 关闭按钮事件
    self.closeBtn.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    self.closeBtn.MouseEnter:Connect(function()
        Tween(self.closeBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0,
            Size = UDim2.new(0, 28, 0, 28)
        }):Play()
        
        Tween(closeBorder, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.3
        }):Play()
    end)
    
    self.closeBtn.MouseLeave:Connect(function()
        Tween(self.closeBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.3,
            Size = UDim2.new(0, 26, 0, 26)
        }):Play()
        
        Tween(closeBorder, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.5
        }):Play()
    end)
    
    -- 胶囊按钮拖拽功能
    local dragging = false
    local dragStart, frameStart
    
    self.toggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = UserInputService:GetMouseLocation()
            frameStart = Vector2.new(self.toggleBtn.Position.X.Offset, self.toggleBtn.Position.Y.Offset)
            
            Tween(self.toggleBtn, {0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                Size = UDim2.new(0, 105, 0, 42)
            }):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = UserInputService:GetMouseLocation()
            local delta = mouse - dragStart
            
            local newX = math.clamp(frameStart.X + delta.X, 0, 
                workspace.CurrentCamera.ViewportSize.X - self.toggleBtn.AbsoluteSize.X)
            local newY = math.clamp(frameStart.Y + delta.Y, 0,
                workspace.CurrentCamera.ViewportSize.Y - self.toggleBtn.AbsoluteSize.Y)
            
            self.toggleBtn.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if dragging then
                dragging = false
                Tween(self.toggleBtn, {0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(0, 100, 0, 40)
                }):Play()
            end
        end
    end)
    
    -- 主面板拖拽功能
    local panelDragging = false
    local panelDragStart, panelFrameStart
    
    self.titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            panelDragging = true
            panelDragStart = UserInputService:GetMouseLocation()
            panelFrameStart = Vector2.new(self.mainFrame.Position.X.Offset, self.mainFrame.Position.Y.Offset)
            
            Tween(self.mainFrame, {0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                Size = UDim2.new(0, 405, 0, 285)
            }):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if panelDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouse = UserInputService:GetMouseLocation()
            local delta = mouse - panelDragStart
            
            local viewport = workspace.CurrentCamera.ViewportSize
            local containerSize = self.mainFrame.AbsoluteSize
            
            local newX = math.clamp(panelFrameStart.X + delta.X, containerSize.X/2, 
                viewport.X - containerSize.X/2)
            local newY = math.clamp(panelFrameStart.Y + delta.Y, containerSize.Y/2, 
                viewport.Y - containerSize.Y/2)
            
            self.mainFrame.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if panelDragging then
                panelDragging = false
                Tween(self.mainFrame, {0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(0, 400, 0, 280)
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
    
    return self
end
-- ZG_XG UI 库 - 第二部分：标签和功能
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
            Size = UDim2.new(0, 400, 0, 280),
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
        self.mainFrame.Size = UDim2.new(0, 400, 0, 280)
        self.mainFrame.Rotation = 0
    end
end

function ZG_XG:Tab(name)
    local tabData = {}
    
    -- 胶囊型标签按钮
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = "Tab_" .. name
    tabBtn.Parent = self.tabContainer
    tabBtn.Size = UDim2.new(1, 0, 0, 40)
    tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    tabBtn.BackgroundTransparency = 0.4
    tabBtn.AutoButtonColor = false
    tabBtn.Text = ""
    
    -- 胶囊圆角
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(1, 0)
    tabCorner.Parent = tabBtn
    
    -- 胶囊霓虹边框
    local tabBorder = Instance.new("Frame")
    tabBorder.Name = "TabBorder"
    tabBorder.Parent = tabBtn
    tabBorder.Size = UDim2.new(1, 4, 1, 4)
    tabBorder.Position = UDim2.new(0, -2, 0, -2)
    tabBorder.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
    tabBorder.BackgroundTransparency = 0.7
    
    local tabBorderCorner = Instance.new("UICorner")
    tabBorderCorner.CornerRadius = UDim.new(1, 0)
    tabBorderCorner.Parent = tabBorder
    
    -- 标签图标
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.Name = "TabIcon"
    tabIcon.Parent = tabBtn
    tabIcon.Size = UDim2.new(0, 22, 0, 22)
    tabIcon.Position = UDim2.new(0.5, -11, 0.5, -11)
    tabIcon.Image = "rbxassetid://10734982100"
    tabIcon.BackgroundTransparency = 1
    tabIcon.ImageColor3 = Color3.fromRGB(200, 220, 240)
    
    -- 标签文本
    local tabText = Instance.new("TextLabel")
    tabText.Name = "TabText"
    tabText.Parent = tabBtn
    tabText.Size = UDim2.new(1, 0, 0, 14)
    tabText.Position = UDim2.new(0, 0, 1, -12)
    tabText.Text = name
    tabText.TextColor3 = Color3.fromRGB(200, 220, 240)
    tabText.Font = Enum.Font.GothamMedium
    tabText.TextSize = 11
    tabText.BackgroundTransparency = 1
    
    -- 胶囊型内容页面
    local contentPage = Instance.new("ScrollingFrame")
    contentPage.Name = "Content_" .. name
    contentPage.Parent = self.contentArea
    contentPage.Size = UDim2.new(1, 0, 1, 0)
    contentPage.BackgroundTransparency = 1
    contentPage.ScrollBarThickness = 4
    contentPage.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
    contentPage.ScrollBarImageTransparency = 0.6
    contentPage.Visible = false
    
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
    
    SmoothScroll(contentPage)
    
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
    
    -- 胶囊标签悬停效果
    tabBtn.MouseEnter:Connect(function()
        if not tabData.isActive then
            Tween(tabBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                BackgroundTransparency = 0.2,
                Size = UDim2.new(1, 2, 0, 42)
            }):Play()
            
            Tween(tabBorder, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                BackgroundTransparency = 0.5
            }):Play()
            
            Tween(tabIcon, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                ImageColor3 = Color3.fromRGB(150, 220, 255),
                Size = UDim2.new(0, 24, 0, 24)
            }):Play()
        end
    end)
    
    tabBtn.MouseLeave:Connect(function()
        if not tabData.isActive then
            Tween(tabBtn, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                BackgroundTransparency = 0.4,
                Size = UDim2.new(1, 0, 0, 40)
            }):Play()
            
            Tween(tabBorder, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                BackgroundTransparency = 0.7
            }):Play()
            
            Tween(tabIcon, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                ImageColor3 = Color3.fromRGB(200, 220, 240),
                Size = UDim2.new(0, 22, 0, 22)
            }):Play()
        end
    end)
    
    -- 标签点击事件
    tabBtn.MouseButton1Click:Connect(function()
        self:SwitchTab(tabData, tabBtn, contentPage, tabBorder)
    end)
    
    tabData.button = tabBtn
    tabData.content = contentPage
    tabData.border = tabBorder
    tabData.isActive = false
    
    table.insert(self.tabs, tabData)
    
    -- 第一个标签默认激活
    if #self.tabs == 1 then
        self:SwitchTab(tabData, tabBtn, contentPage, tabBorder)
    end
    
    local tabFunctions = {}
    
    function tabFunctions:Section(sectionName)
        local sectionData = {}
        
        -- 胶囊型分区容器
        local sectionFrame = Instance.new("Frame")
        sectionFrame.Name = "Section_" .. sectionName
        sectionFrame.Parent = contentPage
        sectionFrame.Size = UDim2.new(1, 0, 0, 0)
        sectionFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        sectionFrame.BackgroundTransparency = 0.3
        
        -- 胶囊圆角
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(1, 0)
        sectionCorner.Parent = sectionFrame
        
        -- 分区霓虹边框
        local sectionBorder = Instance.new("Frame")
        sectionBorder.Name = "SectionBorder"
        sectionBorder.Parent = sectionFrame
        sectionBorder.Size = UDim2.new(1, 4, 1, 4)
        sectionBorder.Position = UDim2.new(0, -2, 0, -2)
        sectionBorder.BackgroundColor3 = Color3.fromRGB(150, 200, 255)
        sectionBorder.BackgroundTransparency = 0.6
        
        local sectionBorderCorner = Instance.new("UICorner")
        sectionBorderCorner.CornerRadius = UDim.new(1, 0)
        sectionBorderCorner.Parent = sectionBorder
        
        -- 分区标题
        local sectionHeader = Instance.new("TextButton")
        sectionHeader.Name = "SectionHeader"
        sectionHeader.Parent = sectionFrame
        sectionHeader.Size = UDim2.new(1, 0, 0, 36)
        sectionHeader.BackgroundTransparency = 1
        sectionHeader.Text = ""
        
        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Name = "SectionTitle"
        sectionTitle.Parent = sectionHeader
        sectionTitle.Size = UDim2.new(1, -40, 1, 0)
        sectionTitle.Position = UDim2.new(0, 15, 0, 0)
        sectionTitle.Text = sectionName
        sectionTitle.TextColor3 = Color3.fromRGB(200, 230, 255)
        sectionTitle.Font = Enum.Font.GothamSemibold
        sectionTitle.TextSize = 13
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.BackgroundTransparency = 1
        
        local expandIcon = Instance.new("ImageLabel")
        expandIcon.Name = "ExpandIcon"
        expandIcon.Parent = sectionHeader
        expandIcon.Size = UDim2.new(0, 16, 0, 16)
        expandIcon.Position = UDim2.new(1, -25, 0.5, -8)
        expandIcon.Image = "rbxassetid://10734980828"
        expandIcon.ImageColor3 = Color3.fromRGB(200, 220, 240)
        expandIcon.BackgroundTransparency = 1
        expandIcon.Rotation = 90
        
        -- 分区内容
        local sectionContent = Instance.new("Frame")
        sectionContent.Name = "SectionContent"
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
                    Size = UDim2.new(1, 0, 0, 36)
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
            end
        end)
        
        local sectionFunctions = {}
        
        function sectionFunctions:Button(text, callback)
            -- 胶囊型按钮
            local button = Instance.new("TextButton")
            button.Name = "Button_" .. text
            button.Parent = sectionContent
            button.Size = UDim2.new(1, 0, 0, 34)
            button.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
            button.BackgroundTransparency = 0.4
            button.AutoButtonColor = false
            button.Text = ""
            
            -- 胶囊圆角
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(1, 0)
            btnCorner.Parent = button
            
            -- 按钮霓虹边框
            local btnBorder = Instance.new("Frame")
            btnBorder.Name = "ButtonBorder"
            btnBorder.Parent = button
            btnBorder.Size = UDim2.new(1, 4, 1, 4)
            btnBorder.Position = UDim2.new(0, -2, 0, -2)
            btnBorder.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
            btnBorder.BackgroundTransparency = 0.7
            
            local btnBorderCorner = Instance.new("UICorner")
            btnBorderCorner.CornerRadius = UDim.new(1, 0)
            btnBorderCorner.Parent = btnBorder
            
            local btnLabel = Instance.new("TextLabel")
            btnLabel.Parent = button
            btnLabel.Size = UDim2.new(1, 0, 1, 0)
            btnLabel.Text = text
            btnLabel.TextColor3 = Color3.fromRGB(220, 230, 255)
            btnLabel.Font = Enum.Font.Gotham
            btnLabel.TextSize = 12
            btnLabel.BackgroundTransparency = 1
            
            -- 按钮悬停效果
            button.MouseEnter:Connect(function()
                Tween(button, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundTransparency = 0.2,
                    Size = UDim2.new(1, 2, 0, 36)
                }):Play()
                
                Tween(btnBorder, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundTransparency = 0.5
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                Tween(button, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundTransparency = 0.4,
                    Size = UDim2.new(1, 0, 0, 34)
                }):Play()
                
                Tween(btnBorder, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundTransparency = 0.7
                }):Play()
            end)
            
            -- 按钮点击效果
            button.MouseButton1Click:Connect(function()
                Tween(button, {0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(1, -4, 0, 32)
                }):Play()
                
                task.wait(0.1)
                
                Tween(button, {0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out}, {
                    Size = UDim2.new(1, 0, 0, 34)
                }):Play()
                
                if callback then
                    callback()
                end
            end)
            
            return button
        end
        
        return sectionFunctions
    end
    
    return tabFunctions
end

function ZG_XG:SwitchTab(tabData, tabBtn, contentPage, tabBorder)
    if self.currentTab == tabData then return end
    
    -- 关闭当前标签
    if self.currentTab then
        local oldTab = self.currentTab
        
        Tween(oldTab.button, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.4,
            Size = UDim2.new(1, 0, 0, 40)
        }):Play()
        
        Tween(oldTab.border, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            BackgroundTransparency = 0.7
        }):Play()
        
        Tween(oldTab.button.TabIcon, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
            ImageColor3 = Color3.fromRGB(200, 220, 240),
            Size = UDim2.new(0, 22, 0, 22)
        }):Play()
        
        if oldTab.content.Visible then
            Tween(oldTab.content, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
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
    
    Tween(tabBtn, {0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
        BackgroundTransparency = 0.1,
        Size = UDim2.new(1, 2, 0, 44)
    }):Play()
    
    Tween(tabBorder, {0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
        BackgroundTransparency = 0.4
    }):Play()
    
    Tween(tabBtn.TabIcon, {0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {
        ImageColor3 = Color3.fromRGB(100, 200, 255),
        Size = UDim2.new(0, 26, 0, 26)
    }):Play()
    
    -- 内容页面滑入动画
    contentPage.Visible = true
    contentPage.Position = UDim2.new(-1, 0, 0, 0)
    contentPage.Size = UDim2.new(0, 0, 1, 0)
    
    Tween(contentPage, {0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.2}, {
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()
end

function ZG_XG:Destroy()
    if self.screenGui then
        self.screenGui:Destroy()
    end
end

return ZG_XG