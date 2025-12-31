repeat
    task.wait()
until game:IsLoaded()

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
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
        Ripple.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Ripple.BackgroundTransparency = 1.000
        Ripple.ZIndex = 8
        Ripple.Image = "rbxassetid://82255019023654"
        Ripple.ImageTransparency = 0.800
        Ripple.ScaleType = Enum.ScaleType.Fit
        Ripple.ImageColor3 = Color3.fromRGB(255,255,255)
        Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
        Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
        wait(0.15)
        Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
        wait(.3)
        Ripple:Destroy()
    end)
end

local toggled = false

-- 超炫酷滚动特效系统 --
local ScrollEffects = {
    ActiveEffects = {},
    ParticleEffects = {},
    Momentum = 0,
    LastScrollPos = 0,
    LastScrollTime = 0,
    IsScrolling = false
}

-- 创建视差图层效果
function ScrollEffects:CreateParallaxLayers(scrollFrame)
    local layers = {}
    
    -- 背景光晕层
    local glowLayer = Instance.new("Frame")
    glowLayer.Name = "GlowLayer"
    glowLayer.Parent = scrollFrame
    glowLayer.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    glowLayer.BackgroundTransparency = 0.9
    glowLayer.Size = UDim2.new(1, 0, 1, 0)
    glowLayer.ZIndex = -5
    glowLayer.Visible = false
    
    -- 动态网格层
    local gridLayer = Instance.new("Frame")
    gridLayer.Name = "GridLayer"
    gridLayer.Parent = scrollFrame
    gridLayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    gridLayer.BackgroundTransparency = 0.95
    gridLayer.Size = UDim2.new(1, 0, 1, 0)
    gridLayer.ZIndex = -4
    
    local gridPattern = Instance.new("UIGradient")
    gridPattern.Rotation = 45
    gridPattern.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.9),
        NumberSequenceKeypoint.new(0.1, 0.7),
        NumberSequenceKeypoint.new(0.9, 0.7),
        NumberSequenceKeypoint.new(1, 0.9)
    })
    gridPattern.Parent = gridLayer
    
    -- 边缘发光层
    local edgeGlow = Instance.new("Frame")
    edgeGlow.Name = "EdgeGlow"
    edgeGlow.Parent = scrollFrame
    edgeGlow.BackgroundColor3 = Color3.fromRGB(255, 150, 255)
    edgeGlow.BackgroundTransparency = 0.8
    edgeGlow.Size = UDim2.new(1, 0, 0.05, 0)
    edgeGlow.ZIndex = -3
    edgeGlow.Visible = false
    
    layers.glowLayer = glowLayer
    layers.gridLayer = gridLayer
    layers.edgeGlow = edgeGlow
    
    return layers
end

-- 创建滚动粒子系统
function ScrollEffects:CreateParticleSystem(scrollFrame)
    local particles = {}
    
    for i = 1, 20 do
        local particle = Instance.new("Frame")
        particle.Name = "ScrollParticle_" .. i
        particle.Parent = scrollFrame
        particle.BackgroundColor3 = Color3.fromHSV(i/20, 1, 1)
        particle.BorderSizePixel = 0
        particle.Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.AnchorPoint = Vector2.new(0.5, 0.5)
        particle.ZIndex = -2
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        particles[i] = {
            Object = particle,
            Speed = math.random(5, 15),
            Direction = Vector2.new(math.random() - 0.5, math.random() - 0.5),
            BasePosition = particle.Position
        }
    end
    
    return particles
end

-- 超炫酷滚动效果
function ScrollEffects:ApplySuperScrollEffect(scrollFrame)
    -- 创建特效层
    local layers = self:CreateParallaxLayers(scrollFrame)
    local particles = self:CreateParticleSystem(scrollFrame)
    
    -- 初始化变量
    local lastScrollY = scrollFrame.CanvasPosition.Y
    local velocity = 0
    local acceleration = 0
    local glowIntensity = 0
    local rotationAngle = 0
    local wobbleEffect = 0
    local colorShift = 0
    
    -- 连接滚动监听
    local connection
    connection = RunService.RenderStepped:Connect(function(delta)
        if not scrollFrame or not scrollFrame.Parent then
            connection:Disconnect()
            return
        end
        
        local currentY = scrollFrame.CanvasPosition.Y
        local deltaY = currentY - lastScrollY
        
        -- 计算速度和加速度
        velocity = deltaY / delta
        acceleration = math.abs(velocity) * 0.1
        
        -- 更新动量
        self.Momentum = self.Momentum * 0.95 + math.abs(velocity) * 0.05
        
        -- 光晕效果
        glowIntensity = math.min(0.3, math.abs(velocity) * 0.0005)
        layers.glowLayer.BackgroundTransparency = 1 - glowIntensity
        layers.glowLayer.Visible = glowIntensity > 0.01
        
        -- 边缘发光
        local edgeGlowPos = math.clamp(math.abs(velocity) * 0.0002, 0, 0.1)
        layers.edgeGlow.Size = UDim2.new(1, 0, edgeGlowPos, 0)
        layers.edgeGlow.Visible = edgeGlowPos > 0.01
        layers.edgeGlow.Position = UDim2.new(0, 0, (velocity > 0 and 0 or 1 - edgeGlowPos), 0)
        
        -- 颜色动态变化
        colorShift = (colorShift + delta * 0.5) % 1
        local hue = math.abs(math.sin(colorShift * math.pi))
        layers.glowLayer.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 1)
        layers.edgeGlow.BackgroundColor3 = Color3.fromHSV((hue + 0.3) % 1, 0.9, 1)
        
        -- 网格动态效果
        rotationAngle = rotationAngle + velocity * 0.0001
        layers.gridLayer.UIGradient.Rotation = rotationAngle * 10
        
        -- 弹性变形效果（上下滑动时）
        if math.abs(velocity) > 100 then
            wobbleEffect = math.sin(tick() * 10) * math.min(0.02, math.abs(velocity) * 0.0001)
            
            -- 应用给所有子元素
            for _, child in ipairs(scrollFrame:GetChildren()) do
                if child:IsA("Frame") and child.Name == "Section" then
                    local scale = 1 + wobbleEffect
                    child.Size = UDim2.new(
                        child.Size.X.Scale * scale,
                        child.Size.X.Offset * scale,
                        child.Size.Y.Scale * scale,
                        child.Size.Y.Offset
                    )
                    
                    -- 颜色脉冲
                    local pulse = math.abs(math.sin(tick() * 8))
                    if child:FindFirstChild("SectionText") then
                        child.SectionText.TextColor3 = Color3.fromRGB(
                            255,
                            200 + math.floor(pulse * 55),
                            220
                        )
                    end
                end
            end
        end
        
        -- 粒子系统效果
        for _, particle in ipairs(particles) do
            local speedMultiplier = math.min(2, 1 + math.abs(velocity) * 0.001)
            
            -- 计算视差位移
            local parallaxX = particle.Direction.X * velocity * 0.0001 * particle.Speed
            local parallaxY = particle.Direction.Y * velocity * 0.0001 * particle.Speed
            
            -- 应用摆动效果
            local wobbleX = math.sin(tick() * particle.Speed * 0.1) * 2
            local wobbleY = math.cos(tick() * particle.Speed * 0.1) * 2
            
            -- 组合运动
            particle.Object.Position = UDim2.new(
                particle.BasePosition.X.Scale,
                particle.BasePosition.X.Offset + parallaxX * speedMultiplier + wobbleX,
                particle.BasePosition.Y.Scale,
                particle.BasePosition.Y.Offset + parallaxY * speedMultiplier + wobbleY
            )
            
            -- 粒子大小变化
            local sizeMultiplier = 1 + math.sin(tick() * particle.Speed * 0.2) * 0.3
            particle.Object.Size = UDim2.new(
                0,
                particle.Object.Size.X.Offset * sizeMultiplier,
                0,
                particle.Object.Size.Y.Offset * sizeMultiplier
            )
            
            -- 粒子透明度
            local alpha = 0.3 + math.abs(math.sin(tick() * 0.5)) * 0.3
            particle.Object.BackgroundTransparency = 1 - alpha
        end
        
        -- 滚动惯性效果（继续滚动）
        if math.abs(deltaY) < 1 and math.abs(velocity) > 10 then
            local inertia = velocity * 0.95
            scrollFrame.CanvasPosition = Vector2.new(
                0,
                math.clamp(currentY + inertia * delta, 0, scrollFrame.CanvasSize.Y.Offset)
            )
        end
        
        lastScrollY = currentY
    end)
    
    -- 添加滚轮放大效果
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Parent = scrollFrame
    uiStroke.Color = Color3.fromRGB(255, 100, 255)
    uiStroke.Thickness = 0
    uiStroke.Transparency = 0.8
    
    -- 保存引用以便清理
    table.insert(self.ActiveEffects, {
        Frame = scrollFrame,
        Connection = connection,
        Layers = layers,
        Particles = particles,
        UIStroke = uiStroke
    })
    
    return true
end

-- # Switch Tabs with Slide Animation # --
local switchingTabs = false
function switchTab(new)
  if switchingTabs then return end
  local old = library.currentTab
  if old == nil then
    new[2].Visible = true
    new[2].Position = UDim2.new(0, 0, 0, 0)
    library.currentTab = new
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    return
  end
  
  if old[1] == new[1] then return end
  switchingTabs = true
  library.currentTab = new

  -- Slide out old tab
  if old[2] then
    Tween(old[2], {0.25, 'Quart', 'Out'}, {Position = UDim2.new(1, 0, 0, 0)})
  end
  
  -- Position and slide in new tab
  new[2].Position = UDim2.new(-1, 0, 0, 0)
  new[2].Visible = true
  
  Tween(new[2], {0.25, 'Quart', 'Out'}, {Position = UDim2.new(0, 0, 0, 0)})
  
  services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
  services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
  services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
  services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

  task.wait(0.15)
  old[2].Visible = false
  old[2].Position = UDim2.new(0, 0, 0, 0)
  
  task.wait(0.1)
  switchingTabs = false
end

-- # Drag, Stolen from Kiriot or Wally # --
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

-- 侧边栏滑动动画函数
function toggleSideBar(sideBar, tabBtns, scriptTitle, isExpanded)
    local sideBarWidth = 110
    local sideBarCollapsedWidth = 8
    
    if isExpanded then
        Tween(sideBar, {0.3, 'Quart', 'Out'}, {
            Size = UDim2.new(0, sideBarWidth, 0, sideBar.Size.Y.Offset)
        })
        Tween(tabBtns, {0.3, 'Quart', 'Out'}, {
            Size = UDim2.new(0, sideBarWidth, 0, tabBtns.Size.Y.Offset)
        })
        Tween(scriptTitle, {0.3, 'Quart', 'Out'}, {
            Size = UDim2.new(0, 102, 0, scriptTitle.Size.Y.Offset)
        })
    else
        Tween(sideBar, {0.3, 'Quart', 'Out'}, {
            Size = UDim2.new(0, sideBarCollapsedWidth, 0, sideBar.Size.Y.Offset)
        })
        Tween(tabBtns, {0.3, 'Quart', 'Out'}, {
            Size = UDim2.new(0, sideBarCollapsedWidth, 0, tabBtns.Size.Y.Offset)
        })
        Tween(scriptTitle, {0.3, 'Quart', 'Out'}, {
            Size = UDim2.new(0, 0, 0, scriptTitle.Size.Y.Offset)
        })
    end
end

function library.new(library, name,theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
          v:Destroy()
        end
      end

-------------------------COLOR SETTINGS------------------------------
ButtonColor = Color3.fromRGB(255, 200, 220)
TabFontColor = Color3.fromRGB(255, 255, 255)
FunctionFontColor = Color3.fromRGB(255, 255, 255)
ALTransparency = 0.2
-------------------------COLOR SETTINGS------------------------------

if theme == 'dark' then
    MainColor = Color3.fromRGB(30, 30, 30)
    Background = Color3.fromRGB(20, 20, 20)
    zyColor = ButtonColor
    beijingColor = Color3.fromRGB(40, 40, 40)
else
    MainColor = Color3.fromRGB(30, 30, 30)
    Background = Color3.fromRGB(20, 20, 20)
    zyColor = ButtonColor
    beijingColor = Color3.fromRGB(40, 40, 40)
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
      local DropShadowHolder = Instance.new("Frame")
      local DropShadow = Instance.new("ImageLabel")
      local UICornerMain = Instance.new("UICorner")
      local Frame = Instance.new("Frame")
      
      if syn and syn.protect_gui then syn.protect_gui(dogent) end
    
      dogent.Name = "frosty"
      dogent.Parent = services.CoreGui
      
      function UiDestroy()
          dogent:Destroy()
      end
      
      function ToggleUILib()
            if not ToggleUI then
                dogent.Enabled = false
                ToggleUI = true
            else
                ToggleUI = false
                dogent.Enabled = true
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
      Main.Transparency = 0
      services.UserInputService.InputEnded:Connect(function(input)
      if input.KeyCode == Enum.KeyCode.LeftControl then
      if Main.Visible == true then
      Main.Visible = false else
      Main.Visible = true
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
      DropShadow.Image = "rbxassetid://92213972586988"
      DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
      DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

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
      sideBarToggleBtn.TextColor3 = TabFontColor
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
                if toggled then wait(0.3) end
            end)
            Tween(Main, {0.3, 'Sine', 'InOut'}, {
                Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
            })
        end
      
      TabMain.Name = "TabMain"
      TabMain.Parent = Main
      TabMain.BackgroundColor3 = Color3.fromRGB(255,255,255)
      TabMain.BackgroundTransparency = 1.000
      TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
      TabMain.Size = UDim2.new(0, 448, 0, 353)
      TabMain.Transparency = 1.0
      
      MainC.CornerRadius = UDim.new(0, 5.5)
      MainC.Name = "MainC"
      MainC.Parent = Frame
      
      SB.Name = "SB"
      SB.Parent = Main
      SB.BackgroundColor3 = Color3.fromRGB(255,255,255)
      SB.BorderColor3 = MainColor
      SB.Size = UDim2.new(0, 8, 0, 353)
      SB.Transparency = 1.0
      
      SBC.CornerRadius = UDim.new(0, 6)
      SBC.Name = "SBC"
      SBC.Parent = SB
      
      Side.Name = "Side"
      Side.Parent = SB
      Side.BackgroundColor3 = Color3.fromRGB(255,255,255)
      Side.BorderColor3 = Color3.fromRGB(255,255,255)
      Side.BorderSizePixel = 0
      Side.ClipsDescendants = true
      Side.Position = UDim2.new(1, 0, 0, 0)
      Side.Size = UDim2.new(0, 110, 0, 353)
      Side.Transparency = 1.0
      
      SideG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SideG.Rotation = 90
      SideG.Name = "SideG"
      SideG.Parent = Side
      
      TabBtns.Name = "TabBtns"
      TabBtns.Parent = Side
      TabBtns.Active = true
      TabBtns.BackgroundColor3 = Color3.fromRGB(255,255,255)
      TabBtns.BackgroundTransparency = 1.000
      TabBtns.BorderSizePixel = 0
      TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
      TabBtns.Size = UDim2.new(0, 110, 0, 318)
      TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
      TabBtns.ScrollBarThickness = 2
      TabBtns.ScrollBarImageColor3 = TabFontColor
      TabBtns.ScrollBarImageTransparency = 0.7
      
      -- 应用超炫酷滚动特效到侧边栏
      ScrollEffects:ApplySuperScrollEffect(TabBtns)
      
      TabBtnsL.Name = "TabBtnsL"
      TabBtnsL.Parent = TabBtns
      TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
      TabBtnsL.Padding = UDim.new(0, 12)
      
      ScriptTitle.Name = "ScriptTitle"
      ScriptTitle.Parent = Side
      ScriptTitle.BackgroundColor3 = Color3.fromRGB(255,255,255)
      ScriptTitle.BackgroundTransparency = 1.000
      ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
      ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
      ScriptTitle.Font = Enum.Font.GothamSemibold
      ScriptTitle.Text = name
      ScriptTitle.TextColor3 = TabFontColor
      ScriptTitle.TextSize = 14.000
      ScriptTitle.TextScaled = true
      ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
      
      SBG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SBG.Rotation = 90
      SBG.Name = "SBG"
      SBG.Parent = SB
    
      TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
      end)
      
Frame.Parent = dogent
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
Frame.Size = UDim2.new(0, 40, 0, 40)
Frame.BackgroundTransparency = 1.000

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 8)
FrameCorner.Name = "FrameCorner"
FrameCorner.Parent = Frame

Open.Parent = Frame
Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Open.BorderColor3 = Color3.fromRGB(0, 0, 0)
Open.BorderSizePixel = 0
Open.Size = UDim2.new(0, 40, 0, 40)
Open.Active = true
Open.Draggable = true
Open.Image = "rbxassetid://138901519642245"
Open.MouseButton1Click:Connect(function()
  Main.Visible = not Main.Visible
  Tween(Open, {0.1, 'Quad', 'Out'}, {
      Size = UDim2.new(0, 35, 0, 35)
  })
  wait(0.1)
  Tween(Open, {0.1, 'Quad', 'Out'}, {
      Size = UDim2.new(0, 40, 0, 40)
  })
end)

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Name = "OpenCorner"
OpenCorner.Parent = Open

      local window = {}
      function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")
    
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255,255,255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.ScrollBarImageColor3 = TabFontColor
        Tab.ScrollBarImageTransparency = 0.7
        Tab.Visible = false
        
        -- 应用超炫酷滚动特效到主标签页
        ScrollEffects:ApplySuperScrollEffect(Tab)
        
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = "rbxassetid://117316662967569" or icon and "rbxassetid://"..icon
        TabIco.ImageTransparency = 0.2
        
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255,255,255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 24)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = name
        TabText.TextColor3 = TabFontColor
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 110, 0, 24)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        
        -- Tab按钮悬停动画
        TabBtn.MouseEnter:Connect(function()
            Tween(TabIco, {0.2, 'Quad', 'Out'}, {
                ImageTransparency = 0
            })
            Tween(TabText, {0.2, 'Quad', 'Out'}, {
                TextTransparency = 0
            })
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if library.currentTab and library.currentTab[1] ~= TabIco then
                Tween(TabIco, {0.2, 'Quad', 'Out'}, {
                    ImageTransparency = 0.2
                })
                Tween(TabText, {0.2, 'Quad', 'Out'}, {
                    TextTransparency = 0.2
                })
            end
        end)
        
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 4)
    
        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
          switchTab({TabIco, Tab})
        end)
    
        if library.currentTab == nil then switchTab({TabIco, Tab}) end
    
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)
        
        local tab = {}
        function tab.section(tab, name, TabVal)
          local Section = Instance.new("Frame")
          local SectionC = Instance.new("UICorner")
          local SectionText = Instance.new("TextLabel")
          local SectionOpen = Instance.new("ImageLabel")
          local SectionOpened = Instance.new("ImageLabel")
          local SectionToggle = Instance.new("ImageButton")
          local Objs = Instance.new("Frame")
          local ObjsL = Instance.new("UIListLayout")
    
          Section.Name = "Section"
          Section.Parent = Tab
          Section.BackgroundColor3 = zyColor
          Section.BackgroundTransparency = ALTransparency
          Section.BorderSizePixel = 0
          Section.ClipsDescendants = true
          Section.Size = UDim2.new(0.981000006, 0, 0, 36)
          
          SectionC.CornerRadius = UDim.new(0, 6)
          SectionC.Name = "SectionC"
          SectionC.Parent = Section
          
          SectionText.Name = "SectionText"
          SectionText.Parent = Section
          SectionText.BackgroundColor3 = Color3.fromRGB(255,255,255)
          SectionText.BackgroundTransparency = 1.000
          SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
          SectionText.Size = UDim2.new(0, 401, 0, 36)
          SectionText.Font = Enum.Font.GothamSemibold
          SectionText.Text = name
          SectionText.TextColor3 = FunctionFontColor
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
          
          Objs.Name = "Objs"
          Objs.Parent = Section
          Objs.BackgroundColor3 = Color3.fromRGB(255,255,255)
          Objs.BackgroundTransparency = 1
          Objs.BorderSizePixel = 0
          Objs.Position = UDim2.new(0, 6, 0, 36)
          Objs.Size = UDim2.new(0.986347735, 0, 0, 0)
    
          ObjsL.Name = "ObjsL"
          ObjsL.Parent = Objs
          ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
          ObjsL.Padding = UDim.new(0, 8)
          
          local open = TabVal
          if TabVal ~= false then
            Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
            SectionOpened.ImageTransparency = (open and 0 or 1)
            SectionOpen.ImageTransparency = (open and 1 or 0)
          end
          
          SectionToggle.MouseButton1Click:Connect(function()
            open = not open
            -- Section展开/收起动画
            Tween(Section, {0.3, 'Quart', 'Out'}, {
                Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
            })
            Tween(SectionOpened, {0.2, 'Quad', 'Out'}, {
                ImageTransparency = (open and 0 or 1)
            })
            Tween(SectionOpen, {0.2, 'Quad', 'Out'}, {
                ImageTransparency = (open and 1 or 0)
            })
          end)
    
          ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            if not open then return end
            Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
          end)
    
          local section = {}
          function section.Button(section, text, callback)
            local callback = callback or function() end

            local BtnModule = Instance.new("Frame")
            local Btn = Instance.new("TextButton")
            local BtnC = Instance.new("UICorner")    
            
            BtnModule.Name = "BtnModule"
            BtnModule.Parent = Objs
            BtnModule.BackgroundColor3 = Color3.fromRGB(255,255,255)
            BtnModule.BackgroundTransparency = 1.000
            BtnModule.BorderSizePixel = 0
            BtnModule.Position = UDim2.new(0, 0, 0, 0)
            BtnModule.Size = UDim2.new(0, 428, 0, 38)
            BtnModule.Transparency = 0.75
            
            Btn.Name = "Btn"
            Btn.Parent = BtnModule
            Btn.BackgroundColor3 = zyColor
            Btn.BorderSizePixel = 0
            Btn.Size = UDim2.new(0, 428, 0, 38)
            Btn.AutoButtonColor = false
            Btn.Font = Enum.Font.GothamSemibold
            Btn.Text = "   " .. text
            Btn.TextColor3 = FunctionFontColor
            Btn.TextSize = 16.000
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.BackgroundTransparency = ALTransparency
            
            BtnC.CornerRadius = UDim.new(0, 18)
            BtnC.Name = "BtnC"
            BtnC.Parent = Btn
    
            -- 按钮悬停动画
            Btn.MouseEnter:Connect(function()
                Tween(Btn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency - 0.1
                })
            end)
            
            Btn.MouseLeave:Connect(function()
                Tween(Btn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency
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
          LabelModule.BackgroundColor3 = Color3.fromRGB(255,255,255)
          LabelModule.BackgroundTransparency = 1.000
          LabelModule.BorderSizePixel = 0
          LabelModule.Position = UDim2.new(0, 0, 0, 0)
          LabelModule.Size = UDim2.new(0, 428, 0, 22)
          TextLabel.Parent = LabelModule
          TextLabel.BackgroundColor3 = zyColor
          TextLabel.Size = UDim2.new(0, 428, 0, 22)
          TextLabel.Font = Enum.Font.GothamSemibold
          TextLabel.Text = text
          TextLabel.TextColor3 = FunctionFontColor
          TextLabel.BackgroundTransparency = ALTransparency
          TextLabel.TextSize = 14.000
    
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
            ToggleModule.BackgroundColor3 = Color3.fromRGB(255,255,255)
            ToggleModule.BackgroundTransparency = 1.000
            ToggleModule.BorderSizePixel = 0
            ToggleModule.Position = UDim2.new(0, 0, 0, 0)
            ToggleModule.Size = UDim2.new(0, 428, 0, 38)
            
            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Parent = ToggleModule
            ToggleBtn.BackgroundColor3 = zyColor
            ToggleBtn.BackgroundTransparency = ALTransparency
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
            ToggleBtn.AutoButtonColor = false
            ToggleBtn.Font = Enum.Font.GothamSemibold
            ToggleBtn.Text = "   " .. text
            ToggleBtn.TextColor3 = FunctionFontColor
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

            -- Toggle悬停动画
            ToggleBtn.MouseEnter:Connect(function()
                Tween(ToggleBtn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency - 0.1
                })
            end)
            
            ToggleBtn.MouseLeave:Connect(function()
                Tween(ToggleBtn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency
                })
            end)
    
            local funcs = {
              SetState = function(self, state)
                if state == nil then state = not library.flags[flag] end
                if library.flags[flag] == state then return end
                services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0), 
                    BackgroundColor3 = (state and Color3.fromRGB(255,255,255) or beijingColor)
                }):Play()
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
          
          return section
        end
        return tab
      end
      return window
    end
return library