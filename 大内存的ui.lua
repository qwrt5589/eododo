repeat
    task.wait()
until game:IsLoaded()

local TweenService = game:GetService("TweenService")
local LocalizationService = game:GetService("LocalizationService")
local player = game.Players.LocalPlayer

local result, code = pcall(function()
    return LocalizationService:GetCountryRegionForPlayerAsync(player)
end)

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

-- 增强的Tween函数
function Tween(obj, t, data)
    local tweenInfo = TweenInfo.new(
        t[1], 
        Enum.EasingStyle[t[2] or 'Quad'], 
        Enum.EasingDirection[t[3] or 'Out'],
        0, -- Count
        false, -- Reverses
        0 -- DelayTime
    )
    services.TweenService:Create(obj, tweenInfo, data):Play()
    return true
end

-- 增强的Ripple效果
function Ripple(obj)
    spawn(function()
        if obj.ClipsDescendants ~= true then
            obj.ClipsDescendants = true
        end
        local Ripple = Instance.new("ImageLabel")
        Ripple.Name = "Ripple"
        Ripple.Parent = obj
        Ripple.BackgroundColor3 = Color3.fromRGB(139,0,255)
        Ripple.BackgroundTransparency = 1.000
        Ripple.ZIndex = 8
        Ripple.Image = "rbxassetid://122395499720013"
        Ripple.ImageTransparency = 0.800
        Ripple.ScaleType = Enum.ScaleType.Fit
        Ripple.ImageColor3 = Color3.fromRGB(139,0,255)
        Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
        Tween(Ripple, {.3, 'Sine', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
        wait(0.15)
        Tween(Ripple, {.3, 'Sine', 'InOut'}, {ImageTransparency = 1})
        wait(.3)
        Ripple:Destroy()
    end)
end

local toggled = false

-- 增强的Tab切换动画
local switchingTabs = false
function switchTab(new)
  if switchingTabs then return end
  local old = library.currentTab
  if old == nil then
    new[2].Visible = true
    new[2].Position = UDim2.new(0, 0, 0, 0)
    library.currentTab = new
    Tween(new[1], {0.15, 'Quad', 'Out'}, {ImageTransparency = 0})
    Tween(new[1].TabText, {0.15, 'Quad', 'Out'}, {TextTransparency = 0})
    return
  end
  
  if old[1] == new[1] then return end
  switchingTabs = true
  library.currentTab = new

  -- 旧Tab滑出
  if old[2] then
    Tween(old[2], {0.25, 'Quart', 'Out'}, {
        Position = UDim2.new(1, 0, 0, 0),
        ImageTransparency = 0.5
    })
  end
  
  -- 新Tab滑入
  new[2].Position = UDim2.new(-1, 0, 0, 0)
  new[2].Visible = true
  new[2].ImageTransparency = 0.5
  
  Tween(new[2], {0.25, 'Quart', 'Out'}, {
      Position = UDim2.new(0, 0, 0, 0),
      ImageTransparency = 0
  })
  
  Tween(old[1], {0.15, 'Quad', 'Out'}, {ImageTransparency = 0.2})
  Tween(new[1], {0.15, 'Quad', 'Out'}, {ImageTransparency = 0})
  Tween(old[1].TabText, {0.15, 'Quad', 'Out'}, {TextTransparency = 0.2})
  Tween(new[1].TabText, {0.15, 'Quad', 'Out'}, {TextTransparency = 0})

  task.wait(0.15)
  old[2].Visible = false
  old[2].Position = UDim2.new(0, 0, 0, 0)
  old[2].ImageTransparency = 0
  
  task.wait(0.1)
  switchingTabs = false
end

-- 增强的拖拽功能
function drag(frame, hold)
    if not hold then
        hold = frame
    end
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
        Tween(frame, {0.1, 'Quad', 'Out'}, {Position = newPos})
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

-- 增强的滚动动画系统
function createEnhancedScroll(frame, config)
    config = config or {}
    local scrollSpeed = config.speed or 0.2
    local easingStyle = config.easing or Enum.EasingStyle.Quad
    local minScrollDelta = config.minDelta or 5
    local maxOverscroll = config.maxOverscroll or 50
    
    local lastScrollTime = tick()
    local lastScrollPosition = 0
    local scrollVelocity = 0
    local isScrolling = false
    local scrollDirection = 0
    local inertiaTimer = 0
    
    -- 惯性滚动函数
    local function applyInertia()
        if math.abs(scrollVelocity) > 0.1 then
            local currentPos = frame.CanvasPosition.Y
            local newPos = currentPos - (scrollVelocity * 30)
            
            -- 边界检查
            local maxScroll = frame.CanvasSize.Y.Offset - frame.AbsoluteWindowSize.Y
            if newPos < 0 then
                newPos = 0
                scrollVelocity = 0
            elseif newPos > maxScroll then
                newPos = maxScroll
                scrollVelocity = 0
            end
            
            -- 应用惯性滚动
            Tween(frame, {0.3, 'Quad', 'Out'}, {
                CanvasPosition = Vector2.new(0, newPos)
            })
            
            -- 逐渐减小速度
            scrollVelocity = scrollVelocity * 0.95
            
            -- 继续惯性滚动
            wait(0.016) -- 约60fps
            if math.abs(scrollVelocity) > 0.1 then
                applyInertia()
            end
        end
    end
    
    -- 弹性边界效果
    local function applyBounce(currentPos, targetPos)
        local delta = targetPos - currentPos
        Tween(frame, {0.5, 'Elastic', 'Out'}, {
            CanvasPosition = Vector2.new(0, targetPos)
        })
    end
    
    -- 滚动事件监听
    frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        local currentTime = tick()
        local currentPos = frame.CanvasPosition.Y
        local deltaTime = currentTime - lastScrollTime
        
        if deltaTime > 0 then
            local deltaPos = currentPos - lastScrollPosition
            local velocity = deltaPos / deltaTime
            
            -- 更新滚动速度（用于惯性）
            if math.abs(deltaPos) > minScrollDelta then
                scrollVelocity = velocity * 0.5
                isScrolling = true
                scrollDirection = deltaPos > 0 and 1 or -1
            end
            
            lastScrollTime = currentTime
            lastScrollPosition = currentPos
            
            -- 检查边界弹性
            local maxScroll = frame.CanvasSize.Y.Offset - frame.AbsoluteWindowSize.Y
            if currentPos < 0 then
                applyBounce(currentPos, 0)
            elseif currentPos > maxScroll then
                applyBounce(currentPos, maxScroll)
            else
                -- 正常平滑滚动
                local targetPos = math.floor(currentPos + 0.5)
                Tween(frame, {scrollSpeed, easingStyle, 'Out'}, {
                    CanvasPosition = Vector2.new(0, targetPos)
                })
            end
        end
    end)
    
    -- 鼠标滚轮滚动
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            local direction = input.Position.Z
            local currentPos = frame.CanvasPosition.Y
            local scrollAmount = 30 -- 每次滚动的像素数
            
            -- 加速滚动效果
            if services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or 
               services.UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                scrollAmount = 100
            end
            
            local newPos = currentPos - (direction * scrollAmount)
            
            -- 边界检查
            local maxScroll = frame.CanvasSize.Y.Offset - frame.AbsoluteWindowSize.Y
            newPos = math.clamp(newPos, 0, maxScroll)
            
            -- 应用带弹性的滚动
            Tween(frame, {0.3, 'Quad', 'Out'}, {
                CanvasPosition = Vector2.new(0, newPos)
            })
            
            -- 添加滚动指示器效果
            if frame:FindFirstChild("ScrollIndicator") then
                frame.ScrollIndicator.Visible = true
                Tween(frame.ScrollIndicator, {0.2, 'Quad', 'Out'}, {
                    ImageTransparency = 0.3
                })
                wait(0.5)
                Tween(frame.ScrollIndicator, {0.5, 'Quad', 'Out'}, {
                    ImageTransparency = 1
                })
                wait(0.5)
                frame.ScrollIndicator.Visible = false
            end
        end
    end)
    
    -- 触摸设备滚动支持
    local touchStartPos, touchStartScrollPos, touchDragging
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            touchStartPos = input.Position.Y
            touchStartScrollPos = frame.CanvasPosition.Y
            touchDragging = true
            
            -- 停止惯性滚动
            scrollVelocity = 0
        end
    end)
    
    services.UserInputService.InputChanged:Connect(function(input)
        if touchDragging and input.UserInputType == Enum.UserInputType.Touch then
            local deltaY = input.Position.Y - touchStartPos
            local newPos = touchStartScrollPos - deltaY
            
            local maxScroll = frame.CanvasSize.Y.Offset - frame.AbsoluteWindowSize.Y
            newPos = math.clamp(newPos, 0, maxScroll)
            
            -- 实时跟随触摸
            frame.CanvasPosition = Vector2.new(0, newPos)
        end
    end)
    
    services.UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            if touchDragging then
                touchDragging = false
                -- 触摸结束后应用惯性
                spawn(applyInertia)
            end
        end
    end)
    
    -- 添加滚动指示器
    local scrollIndicator = Instance.new("Frame")
    scrollIndicator.Name = "ScrollIndicator"
    scrollIndicator.Parent = frame
    scrollIndicator.BackgroundColor3 = Color3.fromRGB(139,0,255)
    scrollIndicator.BackgroundTransparency = 1
    scrollIndicator.Size = UDim2.new(0, 4, 0.3, 0)
    scrollIndicator.Position = UDim2.new(1, -6, 0, 10)
    scrollIndicator.Visible = false
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 2)
    indicatorCorner.Parent = scrollIndicator
    
    -- 滚动条美化
    frame.ScrollBarImageColor3 = Color3.fromRGB(139,0,255)
    frame.ScrollBarImageTransparency = 0.7
    
    -- 滚动条悬停效果
    frame.MouseEnter:Connect(function()
        Tween(frame, {0.2, 'Quad', 'Out'}, {
            ScrollBarImageTransparency = 0.3
        })
    end)
    
    frame.MouseLeave:Connect(function()
        Tween(frame, {0.5, 'Quad', 'Out'}, {
            ScrollBarImageTransparency = 0.7
        })
    end)
    
    return {
        StopInertia = function()
            scrollVelocity = 0
        end,
        ScrollTo = function(position, animated)
            if animated then
                Tween(frame, {0.3, 'Quad', 'Out'}, {
                    CanvasPosition = Vector2.new(0, position)
                })
            else
                frame.CanvasPosition = Vector2.new(0, position)
            end
        end,
        ScrollToTop = function(animated)
            local topPos = 0
            if animated then
                Tween(frame, {0.5, 'Back', 'Out'}, {
                    CanvasPosition = Vector2.new(0, topPos)
                })
            else
                frame.CanvasPosition = Vector2.new(0, topPos)
            end
        end,
        ScrollToBottom = function(animated)
            local bottomPos = frame.CanvasSize.Y.Offset - frame.AbsoluteWindowSize.Y
            if animated then
                Tween(frame, {0.5, 'Back', 'Out'}, {
                    CanvasPosition = Vector2.new(0, bottomPos)
                })
            else
                frame.CanvasPosition = Vector2.new(0, bottomPos)
            end
        end
    }
end

-- 侧边栏滑动动画函数
function toggleSideBar(sideBar, tabBtns, scriptTitle, isExpanded)
    local sideBarWidth = 110
    local sideBarCollapsedWidth = 8
    
    if isExpanded then
        Tween(sideBar, {0.3, 'Back', 'Out'}, {
            Size = UDim2.new(0, sideBarWidth, 0, sideBar.Size.Y.Offset)
        })
        Tween(tabBtns, {0.3, 'Back', 'Out'}, {
            Size = UDim2.new(0, sideBarWidth, 0, tabBtns.Size.Y.Offset)
        })
        Tween(scriptTitle, {0.3, 'Back', 'Out'}, {
            Size = UDim2.new(0, 102, 0, scriptTitle.Size.Y.Offset)
        })
    else
        Tween(sideBar, {0.3, 'Back', 'Out'}, {
            Size = UDim2.new(0, sideBarCollapsedWidth, 0, sideBar.Size.Y.Offset)
        })
        Tween(tabBtns, {0.3, 'Back', 'Out'}, {
            Size = UDim2.new(0, sideBarCollapsedWidth, 0, tabBtns.Size.Y.Offset)
        })
        Tween(scriptTitle, {0.3, 'Back', 'Out'}, {
            Size = UDim2.new(0, 0, 0, scriptTitle.Size.Y.Offset)
        })
    end
end

-- 淡入淡出动画
function fadeIn(obj, duration)
    duration = duration or 0.3
    obj.Visible = true
    obj.BackgroundTransparency = 1
    Tween(obj, {duration, 'Quad', 'Out'}, {
        BackgroundTransparency = 0
    })
end

function fadeOut(obj, duration)
    duration = duration or 0.3
    Tween(obj, {duration, 'Quad', 'Out'}, {
        BackgroundTransparency = 1
    })
    wait(duration)
    obj.Visible = false
    obj.BackgroundTransparency = 0
end
function library.new(library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
            v:Destroy()
        end
    end
    
    -------------------------AL------------------------------
    ALTransparency = 0.6
    ALcolor = Color3.fromRGB(0,255,127)
    -------------------------AL------------------------------
    
    if theme == 'dark' then
        MainColor = Color3.fromRGB(25, 25, 25)
        Background = Color3.fromRGB(25, 25, 25)
        zyColor= Color3.fromRGB(25, 25, 25)
        beijingColor = Color3.fromRGB(25, 25, 25)
    else
        MainColor = Color3.fromRGB(25, 25, 25)
        Background = Color3.fromRGB(20, 20, 20)
        zyColor= Color3.fromRGB(25, 25, 25)
        beijingColor = Color3.fromRGB(20, 20, 20)
    end
    
    local dogent = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local TabMain = Instance.new("Frame")
    local MainC = Instance.new("UICorner")
    local SB = Instance.new("Frame")
    local SBC = Instance.new("UICorner")
    local Side = Instance.new("Frame")
    local SideG = Instance.new("UIGradient")
    local TabBtns = Instance.new("ScrollingFrame")
    local TabBtnsL = Instance.new("UIListLayout")
    local ScriptTitle = Instance.new("TextLabel")
    local SBG = Instance.new("UIGradient") 
    local Open = Instance.new("ImageButton")
    local UIG = Instance.new("UIGradient")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UICornerMain = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local UIGradientTitle = Instance.new("UIGradient")
    local Frame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UICorner_2 = Instance.new("UICorner")
    
    if syn and syn.protect_gui then 
        syn.protect_gui(dogent) 
    end
    
    dogent.Name = "frosty"
    dogent.Parent = services.CoreGui
    
    function UiDestroy()
        Tween(Main, {0.3, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        wait(0.3)
        dogent:Destroy()
    end
    
    function ToggleUILib()
        if not ToggleUI then
            dogent.Enabled = false
            ToggleUI = true
        else
            dogent.Enabled = true
            ToggleUI = false
        end
    end
    
    Main.Name = "Main"
    Main.Parent = dogent
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Background
    Main.BorderColor3 = MainColor
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 572, 0, 353)
    Main.ZIndex = 1
    Main.Active = true
    Main.Draggable = true
    Main.Transparency = 1.0
    Main.BackgroundTransparency = 1
    
    -- 淡入动画
    spawn(function()
        wait(0.1)
        fadeIn(Main, 0.5)
    end)
    
    services.UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            if Main.Visible == true then
                Tween(Main, {0.3, 'Quad', 'Out'}, {
                    BackgroundTransparency = 1
                })
                wait(0.3)
                Main.Visible = false
                Main.BackgroundTransparency = 0
            else
                Main.Visible = true
                fadeIn(Main, 0.3)
            end
        end
    end)
    
    drag(Main)
    
    UICornerMain.Parent = Main
    UICornerMain.CornerRadius = UDim.new(0,3)
    
    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = Main
    DropShadowHolder.BackgroundTransparency = 1.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.BorderColor3 = Color3.fromRGB(255,255,255)
    DropShadowHolder.ZIndex = 0

    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 10, 1, 10)
    DropShadow.Image = "rbxassetid://99733962181667"
    DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(139,0,255)), 
        ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), 
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), 
        ColorSequenceKeypoint.new(0.30, Color3.fromRGB(139,0,255)), 
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), 
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)), 
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139,0,255)), 
        ColorSequenceKeypoint.new(0.70, Color3.fromRGB(139,0,255)), 
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), 
        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), 
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(139,0,255))
    }

    local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
    tween:Play()

    -- 侧边栏状态
    local sideBarExpanded = true
    
    -- 添加侧边栏展开/收起按钮
    local sideBarToggleBtn = Instance.new("TextButton")
    sideBarToggleBtn.Name = "SideBarToggle"
    sideBarToggleBtn.Parent = Side
    sideBarToggleBtn.BackgroundTransparency = 1
    sideBarToggleBtn.Size = UDim2.new(0, 110, 0, 20)
    sideBarToggleBtn.Position = UDim2.new(0, 0, 0.9, 0)
    sideBarToggleBtn.Text = "◀"
    sideBarToggleBtn.TextColor3 = ALcolor
    sideBarToggleBtn.TextSize = 12
    sideBarToggleBtn.Font = Enum.Font.GothamSemibold
    sideBarToggleBtn.MouseButton1Click:Connect(function()
        sideBarExpanded = not sideBarExpanded
        toggleSideBar(Side, TabBtns, ScriptTitle, sideBarExpanded)
        sideBarToggleBtn.Text = sideBarExpanded and "◀" or "▶"
    end)
    
    function toggleui()
        toggled = not toggled
        spawn(function()
            if toggled then 
                wait(0.3) 
            end
        end)
        Tween(Main, {0.3, 'Sine', 'InOut'}, {
            Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
        })
    end
    
    TabMain.Name = "TabMain"
    TabMain.Parent = Main
    TabMain.BackgroundColor3 = Color3.fromRGB(139,0,255)
    TabMain.BackgroundTransparency = 1.000
    TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
    TabMain.Size = UDim2.new(0, 448, 0, 353)
    TabMain.Transparency = 1.0
    
    MainC.CornerRadius = UDim.new(0, 5.5)
    MainC.Name = "MainC"
    MainC.Parent = Frame
    
    SB.Name = "SB"
    SB.Parent = Main
    SB.BackgroundColor3 = Color3.fromRGB(139,0,255)
    SB.BorderColor3 = MainColor
    SB.Size = UDim2.new(0, 8, 0, 353)
    SB.Transparency = 1.0
    
    SBC.CornerRadius = UDim.new(0, 6)
    SBC.Name = "SBC"
    SBC.Parent = SB
    
    Side.Name = "Side"
    Side.Parent = SB
    Side.BackgroundColor3 = Color3.fromRGB(139,0,255)
    Side.BorderColor3 = Color3.fromRGB(139,0,255)
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Position = UDim2.new(1, 0, 0, 0)
    Side.Size = UDim2.new(0, 110, 0, 353)
    Side.Transparency = 1.0
    
    SideG.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, zyColor), 
        ColorSequenceKeypoint.new(1.00, zyColor)
    }
    SideG.Rotation = 90
    SideG.Name = "SideG"
    SideG.Parent = Side
    
    -- 创建增强的Tab按钮滚动区域
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(139,0,255)
    TabBtns.BackgroundTransparency = 1.000
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
    TabBtns.Size = UDim2.new(0, 110, 0, 318)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 3
    TabBtns.ScrollBarImageColor3 = Color3.fromRGB(139,0,255)
    TabBtns.ScrollBarImageTransparency = 0.7
    TabBtns.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    -- 应用增强的滚动动画
    local tabBtnsScroll = createEnhancedScroll(TabBtns, {
        speed = 0.15,
        easing = Enum.EasingStyle.Quad,
        minDelta = 3
    })
    
    -- 添加滑动提示动画
    local scrollHint = Instance.new("Frame")
    scrollHint.Name = "ScrollHint"
    scrollHint.Parent = TabBtns
    scrollHint.BackgroundColor3 = Color3.fromRGB(139,0,255)
    scrollHint.BackgroundTransparency = 0.8
    scrollHint.Size = UDim2.new(1, 0, 0, 2)
    scrollHint.Position = UDim2.new(0, 0, 0, 0)
    scrollHint.ZIndex = 10
    
    local hintCorner = Instance.new("UICorner")
    hintCorner.CornerRadius = UDim.new(0, 1)
    hintCorner.Parent = scrollHint
    
    -- 滚动时显示提示
    local hintVisible = false
    TabBtns:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        if not hintVisible then
            hintVisible = true
            Tween(scrollHint, {0.2, 'Quad', 'Out'}, {
                BackgroundTransparency = 0.5
            })
            wait(1)
            Tween(scrollHint, {0.5, 'Quad', 'Out'}, {
                BackgroundTransparency = 0.8
            })
            wait(0.5)
            hintVisible = false
        end
    end)
    
    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 8)
    
    -- 自动调整CanvasSize
    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = TabBtnsL.AbsoluteContentSize.Y
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, contentSize + 20)
        
        -- 添加内容变化动画
        if contentSize > TabBtns.AbsoluteWindowSize.Y then
            Tween(TabBtns, {0.3, 'Quad', 'Out'}, {
                ScrollBarImageTransparency = 0.3
            })
        end
    end)
    
    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(139,0,255)
    ScriptTitle.BackgroundTransparency = 1.000
    ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
    ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
    ScriptTitle.Font = Enum.Font.GothamSemibold
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = Color3.fromRGB(139,0,255)
    ScriptTitle.TextSize = 14.000
    ScriptTitle.TextScaled = true
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    UIGradientTitle.Parent = ScriptTitle
    
    -- 标题动画脚本
    local function NPLHKB_fake_script() 
        local script = Instance.new('LocalScript', ScriptTitle)
        local button = script.Parent
        local gradient = button.UIGradient
        local ts = game:GetService("TweenService")
        local ti = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local offset = {Offset = Vector2.new(1, 0)}
        local create = ts:Create(gradient, ti, offset)
        local startingPos = Vector2.new(-1, 0)
        local list = {} 
        local s, kpt = ColorSequence.new, ColorSequenceKeypoint.new
        local counter = 0
        local status = "down" 
        gradient.Offset = startingPos
        
        local function rainbowColors()
            local sat, val = 255, 255 
            for i = 1, 10 do 
                local hue = i * 17 
                table.insert(list, Color3.fromHSV(hue / 255, sat / 255, val / 255))
            end
        end
        
        rainbowColors()
        gradient.Color = s({
            kpt(0, list[#list]),
            kpt(0.5, list[#list - 1]),
            kpt(1, list[#list - 2])
        })
        counter = #list
        
        local function animate()
            create:Play()
            create.Completed:Wait() 
            gradient.Offset = startingPos 
            gradient.Rotation = 180
            
            if counter == #list - 1 and status == "down" then
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[#list]), 
                    kpt(1, list[1]) 
                })
                counter = 1
                status = "up" 
            elseif counter == #list and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[1]),
                    kpt(1, list[2])
                })
                counter = 2
                status = "up"
            elseif counter <= #list - 2 and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[counter + 1]), 
                    kpt(1, list[counter + 2])
                })
                counter = counter + 2
                status = "up"
            end
            
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 0 
            
            if counter == #list - 1 and status == "up" then
                gradient.Color = s({ 
                    kpt(0, list[1]), 
                    kpt(0.5, list[#list]), 
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 1
                status = "down"
            elseif counter == #list and status == "up" then
                gradient.Color = s({
                    kpt(0, list[2]),
                    kpt(0.5, list[1]), 
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 2
                status = "down"
            elseif counter <= #list - 2 and status == "up" then
                gradient.Color = s({
                    kpt(0, list[counter + 2]), 
                    kpt(0.5, list[counter + 1]), 
                    kpt(1, gradient.Color.Keypoints[3].Value) 	
                })
                counter = counter + 2
                status = "down"
            end
            animate()
        end
        animate()
    end
    
    coroutine.wrap(NPLHKB_fake_script)()
    
    SBG.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, zyColor), 
        ColorSequenceKeypoint.new(1.00, zyColor)
    }
    SBG.Rotation = 90
    SBG.Name = "SBG"
    SBG.Parent = SB
    Frame.Parent = dogent
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
Frame.Size = UDim2.new(0, 50, 0, 50)
Frame.BackgroundTransparency = 1.000

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 8)
FrameCorner.Name = "FrameCorner"
FrameCorner.Parent = Frame

Open.Parent = Frame
Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Open.BorderColor3 = Color3.fromRGB(0, 0, 0)
Open.BorderSizePixel = 0
Open.Size = UDim2.new(0, 50, 0, 50)
Open.Active = true
Open.Draggable = true
Open.Image = "rbxassetid://122395499720013"

-- 增强的按钮点击动画
Open.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    Open.Image = Main.Visible and "rbxassetid://115818177511542" or "rbxassetid://137748573642696"
    
    -- 按钮脉冲动画
    Tween(Open, {0.1, 'Quad', 'Out'}, {
        Size = UDim2.new(0, 45, 0, 45),
        Rotation = -10
    })
    wait(0.1)
    Tween(Open, {0.2, 'Elastic', 'Out'}, {
        Size = UDim2.new(0, 50, 0, 50),
        Rotation = 0
    })
end)

-- 按钮悬停动画
Open.MouseEnter:Connect(function()
    Tween(Open, {0.2, 'Quad', 'Out'}, {
        Size = UDim2.new(0, 52, 0, 52),
        ImageColor3 = Color3.fromRGB(160, 0, 255)
    })
end)

Open.MouseLeave:Connect(function()
    Tween(Open, {0.2, 'Quad', 'Out'}, {
        Size = UDim2.new(0, 50, 0, 50),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    })
end)

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Name = "OpenCorner"
OpenCorner.Parent = Open

UIG.Parent = Open
  
local window = {}

function window.Tab(window, name, icon)
    local Tab = Instance.new("ScrollingFrame")
    local TabIco = Instance.new("ImageLabel")
    local TabText = Instance.new("TextLabel")
    local TabBtn = Instance.new("TextButton")
    local TabL = Instance.new("UIListLayout")
    local TabPadding = Instance.new("UIPadding")

    Tab.Name = "Tab"
    Tab.Parent = TabMain
    Tab.Active = true
    Tab.BackgroundColor3 = Color3.fromRGB(139,0,255)
    Tab.BackgroundTransparency = 1.000
    Tab.Size = UDim2.new(1, 0, 1, 0)
    Tab.ScrollBarThickness = 3
    Tab.ScrollBarImageColor3 = Color3.fromRGB(139,0,255)
    Tab.ScrollBarImageTransparency = 0.7
    Tab.Visible = false
    Tab.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    -- 应用增强的滚动动画到Tab内容
    local tabContentScroll = createEnhancedScroll(Tab, {
        speed = 0.12,
        easing = Enum.EasingStyle.Cubic,
        minDelta = 2
    })
    
    -- 添加Tab内容淡入动画
    Tab.ChildAdded:Connect(function(child)
        if child:IsA("Frame") then
            child.BackgroundTransparency = 1
            wait(0.05)
            Tween(child, {0.3, 'Quad', 'Out'}, {
                BackgroundTransparency = 0
            })
        end
    end)
    
    TabIco.Name = "TabIco"
    TabIco.Parent = TabBtns
    TabIco.BackgroundTransparency = 1.000
    TabIco.BorderSizePixel = 0
    TabIco.Size = UDim2.new(0, 24, 0, 24)
    TabIco.Image = "rbxassetid://117316662967569" or icon and "rbxassetid://"..icon
    TabIco.ImageTransparency = 0.2
    
    TabText.Name = "TabText"
    TabText.Parent = TabIco
    TabText.BackgroundColor3 = Color3.fromRGB(139,0,255)
    TabText.BackgroundTransparency = 1.000
    TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
    TabText.Size = UDim2.new(0, 76, 0, 24)
    TabText.Font = Enum.Font.GothamSemibold
    TabText.Text = name
    TabText.TextColor3 = ALcolor
    TabText.TextSize = 14.000
    TabText.TextXAlignment = Enum.TextXAlignment.Left
    TabText.TextTransparency = 0.2
    
    TabBtn.Name = "TabBtn"
    TabBtn.Parent = TabIco
    TabBtn.BackgroundColor3 = Color3.fromRGB(139,0,255)
    TabBtn.BackgroundTransparency = 1.000
    TabBtn.BorderSizePixel = 0
    TabBtn.Size = UDim2.new(0, 110, 0, 24)
    TabBtn.AutoButtonColor = false
    TabBtn.Font = Enum.Font.SourceSans
    TabBtn.Text = ""
    TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabBtn.TextSize = 14.000
    
    -- 增强的Tab按钮悬停动画
    TabBtn.MouseEnter:Connect(function()
        Tween(TabIco, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0,
            Size = UDim2.new(0, 26, 0, 26)
        })
        Tween(TabText, {0.2, 'Quad', 'Out'}, {
            TextTransparency = 0,
            TextColor3 = Color3.fromRGB(139,0,255)
        })
    end)
    
    TabBtn.MouseLeave:Connect(function()
        if library.currentTab and library.currentTab[1] ~= TabIco then
            Tween(TabIco, {0.2, 'Quad', 'Out'}, {
                ImageTransparency = 0.2,
                Size = UDim2.new(0, 24, 0, 24)
            })
            Tween(TabText, {0.2, 'Quad', 'Out'}, {
                TextTransparency = 0.2,
                TextColor3 = ALcolor
            })
        end
    end)
    
    TabL.Name = "TabL"
    TabL.Parent = Tab
    TabL.SortOrder = Enum.SortOrder.LayoutOrder
    TabL.Padding = UDim.new(0, 4)
    
    TabPadding.Name = "TabPadding"
    TabPadding.Parent = Tab
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)

    TabBtn.MouseButton1Click:Connect(function()
        spawn(function()
            Ripple(TabBtn)
        end)
        switchTab({TabIco, Tab})
    end)

    if library.currentTab == nil then 
        switchTab({TabIco, Tab}) 
    end

    TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local contentSize = TabL.AbsoluteContentSize.Y
        Tab.CanvasSize = UDim2.new(0, 0, 0, contentSize + 20)
        
        -- 当内容超过可视区域时，显示滚动提示
        if contentSize > Tab.AbsoluteWindowSize.Y then
            Tween(Tab, {0.3, 'Quad', 'Out'}, {
                ScrollBarImageTransparency = 0.3
            })
        end
    end)
    
    ------------------------------------------------------AL.King音乐-------------------------------------------------------
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6797864253"
    sound.Parent = game.Workspace
    sound:Play()
    
    ---------------分割线-------------------------------分割线-------------------------------分割线----------------
    
    local tab = {}
    
    function tab.section(tab, name, TabVal)
        local Section = Instance.new("Frame")
        local SectionC = Instance.new("UICorner")
        local SectionText = Instance.new("TextLabel")
        local SectionOpen = Instance.new("ImageLabel")
        local SectionOpened = Instance.new("ImageLabel")
        local SectionToggle = Instance.new("ImageButton")
        local Objs = Instance.new("ScrollingFrame")
        local ObjsL = Instance.new("UIListLayout")
        local ObjsPadding = Instance.new("UIPadding")

        Section.Name = "Section"
        Section.Parent = Tab
        Section.BackgroundColor3 = zyColor
        Section.BackgroundTransparency = 1.000
        Section.BorderSizePixel = 0
        Section.ClipsDescendants = true
        Section.Size = UDim2.new(1, -20, 0, 36)
        Section.Position = UDim2.new(0, 10, 0, 0)
        
        -- 增强的Section悬停效果
        Section.MouseEnter:Connect(function()
            Tween(Section, {0.2, 'Quad', 'Out'}, {
                BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            })
        end)
        
        Section.MouseLeave:Connect(function()
            Tween(Section, {0.2, 'Quad', 'Out'}, {
                BackgroundColor3 = zyColor
            })
        end)
        
        SectionC.CornerRadius = UDim.new(0, 6)
        SectionC.Name = "SectionC"
        SectionC.Parent = Section
        
        SectionText.Name = "SectionText"
        SectionText.Parent = Section
        SectionText.BackgroundColor3 = Color3.fromRGB(139,0,255)
        SectionText.BackgroundTransparency = 1.000
        SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
        SectionText.Size = UDim2.new(0, 401, 0, 36)
        SectionText.Font = Enum.Font.GothamSemibold
        SectionText.Text = name
        SectionText.TextColor3 = ALcolor
        SectionText.TextSize = 16.000
        SectionText.TextXAlignment = Enum.TextXAlignment.Left
        
        SectionOpen.Name = "SectionOpen"
        SectionOpen.Parent = SectionText
        SectionOpen.BackgroundTransparency = 1
        SectionOpen.BorderSizePixel = 0
        SectionOpen.Position = UDim2.new(0, -33, 0, 5)
        SectionOpen.Size = UDim2.new(0, 26, 0, 26)
        SectionOpen.Image = "rbxassetid://117316662967569"
        
        SectionOpened.Name = "SectionOpened"
        SectionOpened.Parent = SectionOpen
        SectionOpened.BackgroundTransparency = 1.000
        SectionOpened.BorderSizePixel = 0
        SectionOpened.Size = UDim2.new(0, 26, 0, 26)
        SectionOpened.Image = "rbxassetid://122395499720013"
        SectionOpened.ImageTransparency = 1.000

        SectionToggle.Name = "SectionToggle"
        SectionToggle.Parent = SectionOpen
        SectionToggle.BackgroundTransparency = 1
        SectionToggle.BorderSizePixel = 0
        SectionToggle.Size = UDim2.new(0, 26, 0, 26)
        
        -- 增强的Section内容滚动区域
        Objs.Name = "Objs"
        Objs.Parent = Section
        Objs.BackgroundColor3 = Color3.fromRGB(139,0,255)
        Objs.BackgroundTransparency = 1
        Objs.BorderSizePixel = 0
        Objs.Position = UDim2.new(0, 6, 0, 36)
        Objs.Size = UDim2.new(1, -12, 0, 0)
        Objs.ScrollBarThickness = 2
        Objs.ScrollBarImageColor3 = Color3.fromRGB(139,0,255)
        Objs.ScrollBarImageTransparency = 0.8
        Objs.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        -- 应用增强的滚动到Section内容
        local sectionScroll = createEnhancedScroll(Objs, {
            speed = 0.1,
            easing = Enum.EasingStyle.Quad,
            minDelta = 1
        })

        ObjsL.Name = "ObjsL"
        ObjsL.Parent = Objs
        ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
        ObjsL.Padding = UDim.new(0, 6)
        
        ObjsPadding.Name = "ObjsPadding"
        ObjsPadding.Parent = Objs
        ObjsPadding.PaddingTop = UDim.new(0, 4)
        ObjsPadding.PaddingBottom = UDim.new(0, 4)
        
        local open = TabVal
        if TabVal ~= false then
            Section.Size = UDim2.new(1, -20, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
            SectionOpened.ImageTransparency = (open and 0 or 1)
            SectionOpen.ImageTransparency = (open and 1 or 0)
            Objs.Visible = open
        end
        
        -- 增强的Section展开/收起动画
        SectionToggle.MouseButton1Click:Connect(function()
            open = not open
            
            if open then
                Objs.Visible = true
                Objs.Size = UDim2.new(1, -12, 0, 0)
            end
            
            local targetHeight = open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36
            
            Tween(Section, {0.3, 'Quart', 'Out'}, {
                Size = UDim2.new(1, -20, 0, targetHeight)
            })
            
            if open then
                wait(0.15)
                Tween(Objs, {0.2, 'Quad', 'Out'}, {
                    Size = UDim2.new(1, -12, 0, ObjsL.AbsoluteContentSize.Y + 8)
                })
            else
                Tween(Objs, {0.2, 'Quad', 'Out'}, {
                    Size = UDim2.new(1, -12, 0, 0)
                })
                wait(0.2)
                Objs.Visible = false
            end
            
            Tween(SectionOpened, {0.2, 'Quad', 'Out'}, {
                ImageTransparency = (open and 0 or 1)
            })
            Tween(SectionOpen, {0.2, 'Quad', 'Out'}, {
                ImageTransparency = (open and 1 or 0)
            })
        end)

        ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if not open then return end
            local contentHeight = ObjsL.AbsoluteContentSize.Y + 8
            Section.Size = UDim2.new(1, -20, 0, 36 + contentHeight)
            Tween(Objs, {0.2, 'Quad', 'Out'}, {
                Size = UDim2.new(1, -12, 0, contentHeight)
            })
        end)

        local section = {}
        
        function section.Button(section, text, callback)
            local callback = callback or function() end

            local BtnModule = Instance.new("Frame")
            local Btn = Instance.new("TextButton")
            local BtnC = Instance.new("UICorner")    
            
            BtnModule.Name = "BtnModule"
            BtnModule.Parent = Objs
            BtnModule.BackgroundColor3 = Color3.fromRGB(139,0,255)
            BtnModule.BackgroundTransparency = 1.000
            BtnModule.BorderSizePixel = 0
            BtnModule.Position = UDim2.new(0, 0, 0, 0)
            BtnModule.Size = UDim2.new(1, 0, 0, 38)
            BtnModule.Transparency = 0.75
            
            Btn.Name = "Btn"
            Btn.Parent = BtnModule
            Btn.BackgroundColor3 = zyColor
            Btn.BorderSizePixel = 0
            Btn.Size = UDim2.new(1, 0, 0, 38)
            Btn.AutoButtonColor = false
            Btn.Font = Enum.Font.GothamSemibold
            Btn.Text = "   " .. text
            Btn.TextColor3 = ALcolor
            Btn.TextSize = 16.000
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.BackgroundTransparency = ALTransparency
            
            BtnC.CornerRadius = UDim.new(0, 18)
            BtnC.Name = "BtnC"
            BtnC.Parent = Btn

            -- 增强的按钮悬停动画
            Btn.MouseEnter:Connect(function()
                Tween(Btn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency - 0.1,
                    Size = UDim2.new(1, 2, 0, 40)
                })
            end)
            
            Btn.MouseLeave:Connect(function()
                Tween(Btn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency,
                    Size = UDim2.new(1, 0, 0, 38)
                })
            end)

            Btn.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(Btn)
                end)
                spawn(callback)
            end)
            return Btn
        end
        function section:Label(text)
    local LabelModule = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local LabelC = Instance.new("UICorner")
    
    LabelModule.Name = "LabelModule"
    LabelModule.Parent = Objs
    LabelModule.BackgroundColor3 = Color3.fromRGB(139,0,255)
    LabelModule.BackgroundTransparency = 1.000
    LabelModule.BorderSizePixel = 0
    LabelModule.Position = UDim2.new(0, 0, NAN, 0)
    LabelModule.Size = UDim2.new(1, 0, 0, 22)
    
    TextLabel.Parent = LabelModule
    TextLabel.BackgroundColor3 = zyColor
    TextLabel.Size = UDim2.new(1, 0, 0, 22)
    TextLabel.Font = Enum.Font.GothamSemibold
    TextLabel.Text = text
    TextLabel.TextColor3 = ALcolor
    TextLabel.BackgroundTransparency = ALTransparency
    TextLabel.TextSize = 14.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    -- Label淡入动画
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextTransparency = 1
    spawn(function()
        wait(0.1)
        Tween(TextLabel, {0.3, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency,
            TextTransparency = 0
        })
    end)
    
    -- Label悬停效果
    TextLabel.MouseEnter:Connect(function()
        Tween(TextLabel, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            TextColor3 = Color3.fromRGB(139,0,255)
        })
    end)
    
    TextLabel.MouseLeave:Connect(function()
        Tween(TextLabel, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = zyColor,
            TextColor3 = ALcolor
        })
    end)
    
    LabelC.CornerRadius = UDim.new(0, 18)
    LabelC.Name = "LabelC"
    LabelC.Parent = TextLabel
    return TextLabel
end

function section.Toggle(section, text, flag, enabled, callback)
    local callback = callback or function() end
    local enabled = enabled or false
    assert(text, "No text provided")
    assert(flag, "No flag provided")

    library.flags[flag] = enabled

    local ToggleModule = Instance.new("Frame")
    local ToggleBtn = Instance.new("TextButton")
    local ToggleBtnC = Instance.new("UICorner")
    local ToggleDisable = Instance.new("Frame")
    local ToggleSwitch = Instance.new("Frame")
    local ToggleSwitchC = Instance.new("UICorner")
    local ToggleDisableC = Instance.new("UICorner")
    
    ToggleModule.Name = "ToggleModule"
    ToggleModule.Parent = Objs
    ToggleModule.BackgroundColor3 = Color3.fromRGB(139,0,255)
    ToggleModule.BackgroundTransparency = 1.000
    ToggleModule.BorderSizePixel = 0
    ToggleModule.Position = UDim2.new(0, 0, 0, 0)
    ToggleModule.Size = UDim2.new(1, 0, 0, 38)
    
    ToggleBtn.Name = "ToggleBtn"
    ToggleBtn.Parent = ToggleModule
    ToggleBtn.BackgroundColor3 = zyColor
    ToggleBtn.BackgroundTransparency = ALTransparency
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Size = UDim2.new(1, 0, 0, 38)
    ToggleBtn.AutoButtonColor = false
    ToggleBtn.Font = Enum.Font.GothamSemibold
    ToggleBtn.Text = "   " .. text
    ToggleBtn.TextColor3 = ALcolor
    ToggleBtn.TextSize = 16.000
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    
    ToggleBtnC.CornerRadius = UDim.new(0, 18)
    ToggleBtnC.Name = "ToggleBtnC"
    ToggleBtnC.Parent = ToggleBtn
    
    ToggleDisable.Name = "ToggleDisable"
    ToggleDisable.Parent = ToggleBtn
    ToggleDisable.BackgroundColor3 = Background
    ToggleDisable.BackgroundTransparency = 0.5
    ToggleDisable.BorderSizePixel = 0
    ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
    ToggleDisable.Size = UDim2.new(0, 36, 0, 22)
    
    ToggleSwitch.Name = "ToggleSwitch"
    ToggleSwitch.Parent = ToggleDisable
    ToggleSwitch.BackgroundColor3 = beijingColor
    ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)
    
    ToggleSwitchC.CornerRadius = UDim.new(0, 18)
    ToggleSwitchC.Name = "ToggleSwitchC"
    ToggleSwitchC.Parent = ToggleSwitch
    
    ToggleDisableC.CornerRadius = UDim.new(0, 18)
    ToggleDisableC.Name = "ToggleDisableC"
    ToggleDisableC.Parent = ToggleDisable

    -- Toggle按钮增强悬停动画
    ToggleBtn.MouseEnter:Connect(function()
        Tween(ToggleBtn, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency - 0.1,
            Size = UDim2.new(1, 2, 0, 40)
        })
        Tween(ToggleDisable, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        })
    end)
    
    ToggleBtn.MouseLeave:Connect(function()
        Tween(ToggleBtn, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency,
            Size = UDim2.new(1, 0, 0, 38)
        })
        Tween(ToggleDisable, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background
        })
    end)

    local funcs = {
        SetState = function(self, state)
            if state == nil then 
                state = not library.flags[flag] 
            end
            if library.flags[flag] == state then 
                return 
            end
            
            -- 增强的Toggle切换动画
            if state then
                Tween(ToggleSwitch, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0, ToggleSwitch.Size.X.Offset / 2, 0, 0), 
                    BackgroundColor3 = Color3.fromRGB(139,0,255)
                })
            else
                Tween(ToggleSwitch, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0, 0, 0, 0), 
                    BackgroundColor3 = beijingColor
                })
            end
            
            -- 添加脉冲效果
            Tween(ToggleDisable, {0.1, 'Quad', 'Out'}, {
                Size = UDim2.new(0, 38, 0, 24)
            })
            wait(0.1)
            Tween(ToggleDisable, {0.1, 'Quad', 'Out'}, {
                Size = UDim2.new(0, 36, 0, 22)
            })
            
            library.flags[flag] = state
            callback(state)
        end,
        Module = ToggleModule
    }
    
    if enabled ~= false then
        funcs:SetState(flag,true)
    end

    ToggleBtn.MouseButton1Click:Connect(function()
        funcs:SetState()
    end)
    return funcs
end
function section.Keybind(section, text, default, callback)
    local callback = callback or function() end
    assert(text, "No text provided")
    assert(default, "No default key provided")

    local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
    local banned = {
        Return = true;
        Space = true;
        Tab = true;
        Backquote = true;
        CapsLock = true;
        Escape = true;
        Unknown = true;
    }
    local shortNames = {
        RightControl = 'Right Ctrl',
        LeftControl = 'Left Ctrl',
        LeftShift = 'Left Shift',
        RightShift = 'Right Shift',
        Semicolon = ";",
        Quote = '"',
        LeftBracket = '[',
        RightBracket = ']',
        Equals = '=',
        Minus = '-',
        RightAlt = 'Right Alt',
        LeftAlt = 'Left Alt'
    }

    local bindKey = default
    local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

    local KeybindModule = Instance.new("Frame")
    local KeybindBtn = Instance.new("TextButton")
    local KeybindBtnC = Instance.new("UICorner")
    local KeybindValue = Instance.new("TextButton")
    local KeybindValueC = Instance.new("UICorner")
    local KeybindL = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")

    KeybindModule.Name = "KeybindModule"
    KeybindModule.Parent = Objs
    KeybindModule.BackgroundColor3 = Color3.fromRGB(139,0,255)
    KeybindModule.BackgroundTransparency = 1.000
    KeybindModule.BorderSizePixel = 0
    KeybindModule.Position = UDim2.new(0, 0, 0, 0)
    KeybindModule.Size = UDim2.new(1, 0, 0, 38)
    
    KeybindBtn.Name = "KeybindBtn"
    KeybindBtn.Parent = KeybindModule
    KeybindBtn.BackgroundColor3 = zyColor
    KeybindBtn.BorderSizePixel = 0
    KeybindBtn.Size = UDim2.new(1, 0, 0, 38)
    KeybindBtn.AutoButtonColor = false
    KeybindBtn.Font = Enum.Font.GothamSemibold
    KeybindBtn.Text = "   " .. text
    KeybindBtn.TextColor3 = ALcolor
    KeybindBtn.TextSize = 16.000
    KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
    KeybindBtn.BackgroundTransparency = ALTransparency
    
    KeybindBtnC.CornerRadius = UDim.new(0, 18)
    KeybindBtnC.Name = "KeybindBtnC"
    KeybindBtnC.Parent = KeybindBtn
    
    KeybindValue.Name = "KeybindValue"
    KeybindValue.Parent = KeybindBtn
    KeybindValue.BackgroundColor3 = Background
    KeybindValue.BorderSizePixel = 0
    KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
    KeybindValue.Size = UDim2.new(0, 100, 0, 28)
    KeybindValue.AutoButtonColor = false
    KeybindValue.Font = Enum.Font.Gotham
    KeybindValue.Text = keyTxt
    KeybindValue.TextColor3 = Color3.fromRGB(139,0,255)
    KeybindValue.TextSize = 14.000
    
    KeybindValueC.CornerRadius = UDim.new(0, 18)
    KeybindValueC.Name = "KeybindValueC"
    KeybindValueC.Parent = KeybindValue
    
    KeybindL.Name = "KeybindL"
    KeybindL.Parent = KeybindBtn
    KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
    KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
    KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center
    
    UIPadding.Parent = KeybindBtn
    UIPadding.PaddingRight = UDim.new(0, 6)
    
    -- Keybind增强悬停动画
    KeybindBtn.MouseEnter:Connect(function()
        Tween(KeybindBtn, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency - 0.1,
            Size = UDim2.new(1, 2, 0, 40)
        })
        Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0, 102, 0, 30)
        })
    end)
    
    KeybindBtn.MouseLeave:Connect(function()
        Tween(KeybindBtn, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency,
            Size = UDim2.new(1, 0, 0, 38)
        })
        Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background,
            Size = UDim2.new(0, 100, 0, 28)
        })
    end)
    
    -- KeybindValue悬停动画
    KeybindValue.MouseEnter:Connect(function()
        Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            TextColor3 = Color3.fromRGB(160, 0, 255)
        })
    end)
    
    KeybindValue.MouseLeave:Connect(function()
        Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background,
            TextColor3 = Color3.fromRGB(139,0,255)
        })
    end)
    
    services.UserInputService.InputBegan:Connect(function(inp, gpe)
        if gpe then return end
        if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
        if inp.KeyCode ~= bindKey then return end
        callback(bindKey.Name)
    end)
    
    -- 增强的键位绑定动画
    KeybindValue.MouseButton1Click:Connect(function()
        KeybindValue.Text = "..."
        
        -- 绑定时的脉冲动画
        Tween(KeybindValue, {0.1, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            Size = UDim2.new(0, 110, 0, 32)
        })
        wait(0.1)
        Tween(KeybindValue, {0.1, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Size = UDim2.new(0, 102, 0, 30)
        })
        
        wait()
        local key, uwu = services.UserInputService.InputEnded:Wait()
        local keyName = tostring(key.KeyCode.Name)
        
        if key.UserInputType ~= Enum.UserInputType.Keyboard then
            KeybindValue.Text = keyTxt
            Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
                BackgroundColor3 = Background,
                Size = UDim2.new(0, 100, 0, 28)
            })
            return
        end
        
        if banned[keyName] then
            KeybindValue.Text = keyTxt
            Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
                BackgroundColor3 = Background,
                Size = UDim2.new(0, 100, 0, 28)
            })
            return
        end
        
        wait()
        bindKey = Enum.KeyCode[keyName]
        KeybindValue.Text = shortNames[keyName] or keyName
        
        -- 绑定成功动画
        Tween(KeybindValue, {0.1, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Size = UDim2.new(0, 110, 0, 32)
        })
        wait(0.1)
        Tween(KeybindValue, {0.3, 'Quad', 'Out'}, {
            BackgroundColor3 = Background,
            Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
        })
    end)

    KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
        KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
    end)
    KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
end

function section.Textbox(section, text, flag, default, callback)
    local callback = callback or function() end
    assert(text, "No text provided")
    assert(flag, "No flag provided")
    assert(default, "No default text provided")

    library.flags[flag] = default

    local TextboxModule = Instance.new("Frame")
    local TextboxBack = Instance.new("TextButton")
    local TextboxBackC = Instance.new("UICorner")
    local BoxBG = Instance.new("TextButton")
    local BoxBGC = Instance.new("UICorner")
    local TextBox = Instance.new("TextBox")
    local TextboxBackL = Instance.new("UIListLayout")
    local TextboxBackP = Instance.new("UIPadding")  

    TextboxModule.Name = "TextboxModule"
    TextboxModule.Parent = Objs
    TextboxModule.BackgroundColor3 = Color3.fromRGB(139,0,255)
    TextboxModule.BackgroundTransparency = 1.000
    TextboxModule.BorderSizePixel = 0
    TextboxModule.Position = UDim2.new(0, 0, 0, 0)
    TextboxModule.Size = UDim2.new(1, 0, 0, 38)
    
    TextboxBack.Name = "TextboxBack"
    TextboxBack.Parent = TextboxModule
    TextboxBack.BackgroundColor3 = zyColor
    TextboxBack.BackgroundTransparency = ALTransparency
    TextboxBack.BorderSizePixel = 0
    TextboxBack.Size = UDim2.new(1, 0, 0, 38)
    TextboxBack.AutoButtonColor = false
    TextboxBack.Font = Enum.Font.GothamSemibold
    TextboxBack.Text = "   " .. text
    TextboxBack.TextColor3 = ALcolor
    TextboxBack.TextSize = 16.000
    TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
    
    TextboxBackC.CornerRadius = UDim.new(0, 18)
    TextboxBackC.Name = "TextboxBackC"
    TextboxBackC.Parent = TextboxBack
    
    BoxBG.Name = "BoxBG"
    BoxBG.Parent = TextboxBack
    BoxBG.BackgroundColor3 = Background
    BoxBG.BorderSizePixel = 0
    BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
    BoxBG.Size = UDim2.new(0, 100, 0, 28)
    BoxBG.AutoButtonColor = false
    BoxBG.Font = Enum.Font.Gotham
    BoxBG.Text = ""
    BoxBG.TextColor3 = Color3.fromRGB(139,0,255)
    BoxBG.TextSize = 14.000
    
    BoxBGC.CornerRadius = UDim.new(0, 18)
    BoxBGC.Name = "BoxBGC"
    BoxBGC.Parent = BoxBG
    
    TextBox.Parent = BoxBG
    TextBox.BackgroundColor3 = Color3.fromRGB(139,0,255)
    TextBox.BackgroundTransparency = 1.000
    TextBox.BorderSizePixel = 0
    TextBox.Size = UDim2.new(1, 0, 1, 0)
    TextBox.Font = Enum.Font.Gotham
    TextBox.Text = default
    TextBox.TextColor3 = Color3.fromRGB(139,0,255)
    TextBox.TextSize = 14.000
    TextBox.ClearTextOnFocus = false
    
    TextboxBackL.Name = "TextboxBackL"
    TextboxBackL.Parent = TextboxBack
    TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
    TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
    TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center
    
    TextboxBackP.Name = "TextboxBackP"
    TextboxBackP.Parent = TextboxBack
    TextboxBackP.PaddingRight = UDim.new(0, 6)

    -- Textbox增强悬停动画
    TextboxBack.MouseEnter:Connect(function()
        Tween(TextboxBack, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency - 0.1,
            Size = UDim2.new(1, 2, 0, 40)
        })
        Tween(BoxBG, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            Size = UDim2.new(0, 102, 0, 30)
        })
    end)
    
    TextboxBack.MouseLeave:Connect(function()
        Tween(TextboxBack, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency,
            Size = UDim2.new(1, 0, 0, 38)
        })
        Tween(BoxBG, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background,
            Size = UDim2.new(0, 100, 0, 28)
        })
    end)
    
    -- BoxBG增强悬停动画
    BoxBG.MouseEnter:Connect(function()
        Tween(BoxBG, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Size = UDim2.new(0, 102, 0, 30)
        })
        Tween(TextBox, {0.2, 'Quad', 'Out'}, {
            TextColor3 = Color3.fromRGB(160, 0, 255)
        })
    end)
    
    BoxBG.MouseLeave:Connect(function()
        Tween(BoxBG, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background,
            Size = UDim2.new(0, 100, 0, 28)
        })
        Tween(TextBox, {0.2, 'Quad', 'Out'}, {
            TextColor3 = Color3.fromRGB(139,0,255)
        })
    end)
    
    -- 文本框聚焦动画
    TextBox.Focused:Connect(function()
        Tween(BoxBG, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            Size = UDim2.new(0, 110, 0, 32)
        })
        Tween(TextBox, {0.2, 'Quad', 'Out'}, {
            TextColor3 = Color3.fromRGB(180, 0, 255)
        })
    end)
    
    TextBox.FocusLost:Connect(function()
        if TextBox.Text == "" then
            TextBox.Text = default
        end
        library.flags[flag] = TextBox.Text
        callback(TextBox.Text)
        
        Tween(BoxBG, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background,
            Size = UDim2.new(0, 100, 0, 28)
        })
        Tween(TextBox, {0.2, 'Quad', 'Out'}, {
            TextColor3 = Color3.fromRGB(139,0,255)
        })
    end)

    TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
        BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
    end)
    BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
end
            function section.Slider(section, text, flag, default, min, max, precise, callback)
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
                local SliderBack = Instance.new("TextButton")
                local SliderBackC = Instance.new("UICorner")
                local SliderBar = Instance.new("Frame")
                local SliderBarC = Instance.new("UICorner")
                local SliderPart = Instance.new("Frame")
                local SliderPartC = Instance.new("UICorner")
                local SliderValBG = Instance.new("TextButton")
                local SliderValBGC = Instance.new("UICorner")
                local SliderValue = Instance.new("TextBox")
                local MinSlider = Instance.new("TextButton")
                local AddSlider = Instance.new("TextButton")   
                
                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(139,0,255)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Position = UDim2.new(0, 0, 0, 0)
                SliderModule.Size = UDim2.new(1, 0, 0, 38)
                
                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = zyColor
                SliderBack.BackgroundTransparency = ALTransparency
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(1, 0, 0, 38)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamSemibold
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = ALcolor
                SliderBack.TextSize = 16.000
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderBackC.CornerRadius = UDim.new(0, 18)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack
                
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Background
                SliderBar.BackgroundTransparency = ALTransparency
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 140, 0, 12)
                
                SliderBarC.CornerRadius = UDim.new(0, 6)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar
                
                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = Color3.fromRGB(139,0,255)
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0, 54, 0, 13)
                
                SliderPartC.CornerRadius = UDim.new(0, 6)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart
                
                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Background
                SliderValBG.BackgroundTransparency = ALTransparency
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
                SliderValBG.Size = UDim2.new(0, 44, 0, 28)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Font = Enum.Font.Gotham
                SliderValBG.Text = ""
                SliderValBG.TextColor3 = Color3.fromRGB(139,0,255)
                SliderValBG.TextSize = 14.000
                
                SliderValBGC.CornerRadius = UDim.new(0, 18)
                SliderValBGC.Name = "SliderValBGC"
                SliderValBGC.Parent = SliderValBG
                
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundColor3 = Color3.fromRGB(139,0,255)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.BorderSizePixel = 0
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = "1000"
                SliderValue.TextColor3 = Color3.fromRGB(139,0,255)
                SliderValue.TextSize = 14.000
                
                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundColor3 = Color3.fromRGB(139,0,255)
                MinSlider.BackgroundTransparency = 1.000
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
                MinSlider.Font = Enum.Font.Gotham
                MinSlider.Text = "-"
                MinSlider.TextColor3 = ALcolor
                MinSlider.TextSize = 24.000
                MinSlider.TextWrapped = true
                
                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderModule
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundColor3 = Color3.fromRGB(139,0,255)
                AddSlider.BackgroundTransparency = 1.000
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.Gotham
                AddSlider.Text = "+"
                AddSlider.TextColor3 = ALcolor
                AddSlider.TextSize = 24.000
                AddSlider.TextWrapped = true
                
                -- 增强的Slider按钮动画
                MinSlider.MouseButton1Click:Connect(function()
                    local currentValue = library.flags[flag]
                    currentValue = math.clamp(currentValue - 1, min, max)
                    funcs:SetValue(currentValue)
                    
                    -- 按钮点击动画
                    Tween(MinSlider, {0.1, 'Quad', 'Out'}, {
                        Size = UDim2.new(0, 18, 0, 18)
                    })
                    wait(0.1)
                    Tween(MinSlider, {0.1, 'Quad', 'Out'}, {
                        Size = UDim2.new(0, 20, 0, 20)
                    })
                end)
    
                AddSlider.MouseButton1Click:Connect(function()
                    local currentValue = library.flags[flag]
                    currentValue = math.clamp(currentValue + 1, min, max)
                    funcs:SetValue(currentValue)
                    
                    -- 按钮点击动画
                    Tween(AddSlider, {0.1, 'Quad', 'Out'}, {
                        Size = UDim2.new(0, 18, 0, 18)
                    })
                    wait(0.1)
                    Tween(AddSlider, {0.1, 'Quad', 'Out'}, {
                        Size = UDim2.new(0, 20, 0, 20)
                    })
                end)
                
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
                        
                        -- 增强的滑块动画
                        Tween(SliderPart, {0.2, 'Quad', 'Out'}, {
                            Size = UDim2.new(percent, 0, 1, 0)
                        })
                        
                        -- 值显示脉冲动画
                        Tween(SliderValBG, {0.1, 'Quad', 'Out'}, {
                            Size = UDim2.new(0, 48, 0, 32)
                        })
                        wait(0.1)
                        Tween(SliderValBG, {0.1, 'Quad', 'Out'}, {
                            Size = UDim2.new(0, 44, 0, 28)
                        })
                        
                        callback(tonumber(value))
                    end
                }
                
                funcs:SetValue(default)
        
                local dragging, boxFocused, allowed = false, false, {
                    [""] = true,
                    ["-"] = true
                }
    
                -- 增强的滑块拖拽动画
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        Tween(SliderBar, {0.2, 'Quad', 'Out'}, {
                            Size = UDim2.new(0, 142, 0, 14)
                        })
                        funcs:SetValue()
                    end
                end)
    
                services.UserInputService.InputEnded:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                        Tween(SliderBar, {0.2, 'Quad', 'Out'}, {
                            Size = UDim2.new(0, 140, 0, 12)
                        })
                    end
                end)
    
                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        funcs:SetValue()
                    end
                end)

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        Tween(SliderBar, {0.2, 'Quad', 'Out'}, {
                            Size = UDim2.new(0, 142, 0, 14)
                        })
                        funcs:SetValue()
                    end
                end)
    
                services.UserInputService.InputEnded:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                        Tween(SliderBar, {0.2, 'Quad', 'Out'}, {
                            Size = UDim2.new(0, 140, 0, 12)
                        })
                    end
                end)
    
                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.Touch then
                        funcs:SetValue()
                    end
                end)
    
                SliderValue.Focused:Connect(function()
                    boxFocused = true
                    Tween(SliderValBG, {0.2, 'Quad', 'Out'}, {
                        BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    })
                end)
    
                SliderValue.FocusLost:Connect(function()
                    boxFocused = false
                    if SliderValue.Text == "" then
                        funcs:SetValue(default)
                    end
                    Tween(SliderValBG, {0.2, 'Quad', 'Out'}, {
                        BackgroundColor3 = Background
                    })
                end)
    
                SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
                    if not boxFocused then return end
                    SliderValue.Text = SliderValue.Text:gsub("%D+", "")
                    
                    local text = SliderValue.Text
                    
                    if not tonumber(text) then
                        SliderValue.Text = SliderValue.Text:gsub('%D+', '')
                    elseif not allowed[text] then
                        if tonumber(text) > max then
                            text = max
                            SliderValue.Text = tostring(max)
                        end
                        funcs:SetValue(tonumber(text))
                    end
                end)
    
                return funcs
            end

            function section.Dropdown(section, text, flag, options, callback)
                local callback = callback or function() end
                local options = options or {}
                assert(text, "No text provided")
                assert(flag, "No flag provided")
        
                library.flags[flag] = nil
                
                local DropdownModule = Instance.new("Frame")
                local DropdownTop = Instance.new("TextButton")
                local DropdownTopC = Instance.new("UICorner")
                local DropdownOpen = Instance.new("TextButton")
                local DropdownText = Instance.new("TextBox")
                local DropdownModuleL = Instance.new("UIListLayout")
                local DropdownPadding = Instance.new("UIPadding")
                local Option = Instance.new("TextButton")
                local OptionC = Instance.new("UICorner")        
                
                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(139,0,255)
                DropdownModule.BackgroundTransparency = 1.000
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Position = UDim2.new(0, 0, 0, 0)
                DropdownModule.Size = UDim2.new(1, 0, 0, 38)
                
                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = zyColor
                DropdownTop.BackgroundTransparency = ALTransparency
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(1, 0, 0, 38)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamSemibold
                DropdownTop.Text = ""
                DropdownTop.TextColor3 = ALcolor
                DropdownTop.TextSize = 16.000
                DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownTopC.CornerRadius = UDim.new(0, 18)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop
                
                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                DropdownOpen.BackgroundColor3 = Color3.fromRGB(139,0,255)
                DropdownOpen.BackgroundTransparency = 1.000
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
                DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
                DropdownOpen.Font = Enum.Font.Gotham
                DropdownOpen.Text = "+"
                DropdownOpen.TextColor3 = ALcolor
                DropdownOpen.TextSize = 24.000
                DropdownOpen.TextWrapped = true
                
                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundColor3 = Color3.fromRGB(139,0,255)
                DropdownText.BackgroundTransparency = 1.000
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
                DropdownText.Size = UDim2.new(0, 184, 0, 38)
                DropdownText.Font = Enum.Font.GothamSemibold
                DropdownText.PlaceholderColor3 = Color3.fromRGB(139,0,255)
                DropdownText.PlaceholderText = text
                DropdownText.Text = ""
                DropdownText.TextColor3 = Color3.fromRGB(139,0,255)
                DropdownText.TextSize = 16.000
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownModuleL.Name = "DropdownModuleL"
                DropdownModuleL.Parent = DropdownModule
                DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownModuleL.Padding = UDim.new(0, 4)
                
                DropdownPadding.Name = "DropdownPadding"
                DropdownPadding.Parent = DropdownModule
                DropdownPadding.PaddingTop = UDim.new(0, 38)
                
                -- 增强的Dropdown悬停动画
                DropdownTop.MouseEnter:Connect(function()
                    Tween(DropdownTop, {0.2, 'Quad', 'Out'}, {
                        BackgroundTransparency = ALTransparency - 0.1,
                        Size = UDim2.new(1, 2, 0, 40)
                    })
                    Tween(DropdownOpen, {0.2, 'Quad', 'Out'}, {
                        TextColor3 = Color3.fromRGB(160, 0, 255),
                        Size = UDim2.new(0, 22, 0, 22)
                    })
                end)
                
                DropdownTop.MouseLeave:Connect(function()
                    Tween(DropdownTop, {0.2, 'Quad', 'Out'}, {
                        BackgroundTransparency = ALTransparency,
                        Size = UDim2.new(1, 0, 0, 38)
                    })
                    Tween(DropdownOpen, {0.2, 'Quad', 'Out'}, {
                        TextColor3 = ALcolor,
                        Size = UDim2.new(0, 20, 0, 20)
                    })
                end)
    
                local setAllVisible = function()
                    local options = DropdownModule:GetChildren() 
                    for i=1, #options do
                        local option = options[i]
                        if option:IsA("TextButton") and option.Name:match("Option_") then
                            option.Visible = true
                        end
                    end
                end
    
                local searchDropdown = function(text)
                    local options = DropdownModule:GetChildren()
                    for i=1, #options do
                        local option = options[i]
                        if text == "" then
                            setAllVisible()
                        else
                            if option:IsA("TextButton") and option.Name:match("Option_") then
                                if option.Text:lower():match(text:lower()) then
                                    option.Visible = true
                                else
                                    option.Visible = false
                                end
                            end
                        end
                    end
                end
    
                local open = false
                local ToggleDropVis = function()
                    open = not open
                    if open then 
                        setAllVisible() 
                    end
                    DropdownOpen.Text = (open and "-" or "+")
                    
                    -- 增强的Dropdown展开动画
                    if open then
                        local targetHeight = DropdownModuleL.AbsoluteContentSize.Y + 42
                        Tween(DropdownModule, {0.3, 'Back', 'Out'}, {
                            Size = UDim2.new(1, 0, 0, targetHeight)
                        })
                    else
                        Tween(DropdownModule, {0.3, 'Back', 'Out'}, {
                            Size = UDim2.new(1, 0, 0, 38)
                        })
                    end
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
                    DropdownModule.Size = UDim2.new(1, 0, 0, (DropdownModuleL.AbsoluteContentSize.Y + 42))
                end)
                
                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")     
    
                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = zyColor
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0, 0, 0.328125, 0)
                    Option.Size = UDim2.new(1, 0, 0, 26)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.Gotham
                    Option.Text = option
                    Option.TextColor3 = ALcolor
                    Option.TextSize = 14.000
                    Option.BackgroundTransparency = ALTransparency
                    Option.Visible = false
                    
                    OptionC.CornerRadius = UDim.new(0, 18)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option
                    
                    -- 选项增强悬停动画
                    Option.MouseEnter:Connect(function()
                        Tween(Option, {0.2, 'Quad', 'Out'}, {
                            BackgroundTransparency = ALTransparency - 0.1,
                            Size = UDim2.new(1, 2, 0, 28),
                            TextColor3 = Color3.fromRGB(160, 0, 255)
                        })
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        Tween(Option, {0.2, 'Quad', 'Out'}, {
                            BackgroundTransparency = ALTransparency,
                            Size = UDim2.new(1, 0, 0, 26),
                            TextColor3 = ALcolor
                        })
                    end)

                    Option.MouseButton1Click:Connect(function()
                        -- 选项选择动画
                        Tween(Option, {0.1, 'Quad', 'Out'}, {
                            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                            Size = UDim2.new(1, 4, 0, 30)
                        })
                        wait(0.1)
                        Tween(Option, {0.2, 'Quad', 'Out'}, {
                            BackgroundColor3 = zyColor,
                            Size = UDim2.new(1, 0, 0, 26)
                        })
                        
                        ToggleDropVis()
                        callback(Option.Text)
                        DropdownText.Text = Option.Text
                        library.flags[flag] = Option.Text
                    end)
                    
                    -- 淡入动画
                    if open then
                        Option.Visible = true
                        Option.BackgroundTransparency = 1
                        Option.TextTransparency = 1
                        spawn(function()
                            wait(0.1)
                            Tween(Option, {0.3, 'Quad', 'Out'}, {
                                BackgroundTransparency = ALTransparency,
                                TextTransparency = 0
                            })
                        end)
                    end
                end
    
                funcs.RemoveOption = function(self, option)
                    local option = DropdownModule:FindFirstChild("Option_" .. option)
                    if option then 
                        Tween(option, {0.3, 'Quad', 'Out'}, {
                            BackgroundTransparency = 1,
                            TextTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 0)
                        })
                        wait(0.3)
                        option:Destroy() 
                    end
                end
    
                funcs.SetOptions = function(self, options)
                    for _, v in next, DropdownModule:GetChildren() do
                        if v.Name:match("Option_") then
                            v:Destroy()
                        end
                    end
                    for _,v in next, options do
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