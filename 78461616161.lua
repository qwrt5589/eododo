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

function smoothScroll(frame, speed)
    local lastScrollPosition = 0
    frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        local currentPos = frame.CanvasPosition.Y
        local delta = currentPos - lastScrollPosition
        
        Tween(frame, {0.2, 'Quad', 'Out'}, {
            CanvasPosition = Vector2.new(0, currentPos)
        })
        
        lastScrollPosition = currentPos
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

-- 装饰图片动画函数
function animateDecorations(leftDecoration, rightDecoration, hover)
    if hover then
        Tween(leftDecoration, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0.1,
            Rotation = 5,
            Size = UDim2.new(0, 42, 0, 47)
        })
        Tween(rightDecoration, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0.1,
            Rotation = -5,
            Size = UDim2.new(0, 37, 0, 34)
        })
    else
        Tween(leftDecoration, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0.3,
            Rotation = 0,
            Size = UDim2.new(0, 40, 0, 45)
        })
        Tween(rightDecoration, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0.3,
            Rotation = 0,
            Size = UDim2.new(0, 35, 0, 32)
        })
    end
end

-- 装饰图片点击动画
function clickDecorationAnimation(leftDecoration, rightDecoration)
    spawn(function()
        Tween(leftDecoration, {0.1, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 38, 0, 43),
            Rotation = 10
        })
        Tween(rightDecoration, {0.1, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 33, 0, 30),
            Rotation = -10
        })
        wait(0.1)
        Tween(leftDecoration, {0.1, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 40, 0, 45),
            Rotation = 0
        })
        Tween(rightDecoration, {0.1, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 35, 0, 32),
            Rotation = 0
        })
    end)
end

-- 创建装饰图片的函数
function createLeftDecoration(parent)
    local LeftDecoration = Instance.new("ImageLabel")
    LeftDecoration.Name = "LeftDecoration"
    LeftDecoration.Parent = parent
    LeftDecoration.AnchorPoint = Vector2.new(0, 0.5)
    LeftDecoration.BackgroundTransparency = 1
    LeftDecoration.Position = UDim2.new(0, -20, 0.5, 0)
    LeftDecoration.Size = UDim2.new(0, 40, 0, 45)
    LeftDecoration.Image = "rbxassetid://82255019023654"
    LeftDecoration.ImageTransparency = 0.3
    LeftDecoration.ScaleType = Enum.ScaleType.Fit
    LeftDecoration.ImageColor3 = Color3.fromRGB(255, 255, 255)
    return LeftDecoration
end

function createRightDecoration(parent)
    local RightDecoration = Instance.new("ImageLabel")
    RightDecoration.Name = "RightDecoration"
    RightDecoration.Parent = parent
    RightDecoration.AnchorPoint = Vector2.new(1, 0.5)
    RightDecoration.BackgroundTransparency = 1
    RightDecoration.Position = UDim2.new(1, 20, 0.5, 0)
    RightDecoration.Size = UDim2.new(0, 35, 0, 32)
    RightDecoration.Image = "rbxassetid://86985903461819"
    RightDecoration.ImageTransparency = 0.3
    RightDecoration.ScaleType = Enum.ScaleType.Fit
    RightDecoration.ImageColor3 = Color3.fromRGB(255, 255, 255)
    return RightDecoration
end

-- 装饰图片呼吸动画
function breatheAnimation(leftDecoration, rightDecoration)
    spawn(function()
        while leftDecoration and leftDecoration.Parent do
            Tween(leftDecoration, {1.5, 'Sine', 'InOut'}, {
                Size = UDim2.new(0, 41, 0, 46)
            })
            Tween(rightDecoration, {1.5, 'Sine', 'InOut'}, {
                Size = UDim2.new(0, 36, 0, 33)
            })
            wait(1.5)
            Tween(leftDecoration, {1.5, 'Sine', 'InOut'}, {
                Size = UDim2.new(0, 40, 0, 45)
            })
            Tween(rightDecoration, {1.5, 'Sine', 'InOut'}, {
                Size = UDim2.new(0, 35, 0, 32)
            })
            wait(1.5)
        end
    end)
end

-- 装饰图片颜色渐变动画
function colorAnimation(leftDecoration, rightDecoration)
    spawn(function()
        local leftTween = TweenService:Create(leftDecoration, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        })
        local rightTween = TweenService:Create(rightDecoration, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        })
        leftTween:Play()
        rightTween:Play()
    end)
end

-- 装饰图片闪烁动画
function blinkAnimation(leftDecoration, rightDecoration)
    spawn(function()
        while leftDecoration and leftDecoration.Parent do
            wait(math.random(5, 10))
            Tween(leftDecoration, {0.1, 'Linear', 'Out'}, {
                ImageTransparency = 0.1
            })
            Tween(rightDecoration, {0.1, 'Linear', 'Out'}, {
                ImageTransparency = 0.1
            })
            wait(0.1)
            Tween(leftDecoration, {0.1, 'Linear', 'Out'}, {
                ImageTransparency = 0.3
            })
            Tween(rightDecoration, {0.1, 'Linear', 'Out'}, {
                ImageTransparency = 0.3
            })
        end
    end)
end

-- 装饰图片旋转动画
function rotateAnimation(leftDecoration, rightDecoration)
    spawn(function()
        local leftRotate = TweenService:Create(leftDecoration, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {
            Rotation = 360
        })
        local rightRotate = TweenService:Create(rightDecoration, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {
            Rotation = -360
        })
        leftRotate:Play()
        rightRotate:Play()
    end)
end

-- 初始化装饰图片动画
function initDecorationAnimations(leftDecoration, rightDecoration)
    breatheAnimation(leftDecoration, rightDecoration)
    colorAnimation(leftDecoration, rightDecoration)
    blinkAnimation(leftDecoration, rightDecoration)
    rotateAnimation(leftDecoration, rightDecoration)
end

-- 装饰图片悬停特效
function decorationHoverEffect(leftDecoration, rightDecoration, isHovering)
    if isHovering then
        Tween(leftDecoration, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0.1,
            Size = UDim2.new(0, 42, 0, 47),
            ImageColor3 = Color3.fromRGB(255, 255, 200)
        })
        Tween(rightDecoration, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0.1,
            Size = UDim2.new(0, 37, 0, 34),
            ImageColor3 = Color3.fromRGB(200, 255, 255)
        })
    else
        Tween(leftDecoration, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0.3,
            Size = UDim2.new(0, 40, 0, 45),
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        })
        Tween(rightDecoration, {0.2, 'Quad', 'Out'}, {
            ImageTransparency = 0.3,
            Size = UDim2.new(0, 35, 0, 32),
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        })
    end
end

-- 装饰图片点击特效
function decorationClickEffect(leftDecoration, rightDecoration)
    spawn(function()
        -- 左侧装饰放大
        Tween(leftDecoration, {0.1, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 44, 0, 49),
            ImageTransparency = 0
        })
        -- 右侧装饰放大
        Tween(rightDecoration, {0.1, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 39, 0, 36),
            ImageTransparency = 0
        })
        wait(0.1)
        -- 恢复
        Tween(leftDecoration, {0.1, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 40, 0, 45),
            ImageTransparency = 0.3
        })
        Tween(rightDecoration, {0.1, 'Quad', 'Out'}, {
            Size = UDim2.new(0, 35, 0, 32),
            ImageTransparency = 0.3
        })
    end)
end

-- 装饰图片入场动画
function decorationEntranceAnimation(leftDecoration, rightDecoration)
    leftDecoration.Position = UDim2.new(0, -50, 0.5, 0)
    rightDecoration.Position = UDim2.new(1, 50, 0.5, 0)
    leftDecoration.ImageTransparency = 1
    rightDecoration.ImageTransparency = 1
    
    Tween(leftDecoration, {0.3, 'Quart', 'Out'}, {
        Position = UDim2.new(0, -20, 0.5, 0),
        ImageTransparency = 0.3
    })
    Tween(rightDecoration, {0.3, 'Quart', 'Out'}, {
        Position = UDim2.new(1, 20, 0.5, 0),
        ImageTransparency = 0.3
    })
end

-- 装饰图片退场动画
function decorationExitAnimation(leftDecoration, rightDecoration, callback)
    Tween(leftDecoration, {0.3, 'Quart', 'Out'}, {
        Position = UDim2.new(0, -50, 0.5, 0),
        ImageTransparency = 1
    })
    Tween(rightDecoration, {0.3, 'Quart', 'Out'}, {
        Position = UDim2.new(1, 50, 0.5, 0),
        ImageTransparency = 1
    })
    wait(0.3)
    if callback then callback() end
end

-- 装饰图片脉冲动画
function decorationPulseAnimation(leftDecoration, rightDecoration)
    spawn(function()
        Tween(leftDecoration, {0.5, 'Sine', 'InOut'}, {
            Size = UDim2.new(0, 42, 0, 47),
            ImageTransparency = 0.2
        })
        Tween(rightDecoration, {0.5, 'Sine', 'InOut'}, {
            Size = UDim2.new(0, 37, 0, 34),
            ImageTransparency = 0.2
        })
        wait(0.5)
        Tween(leftDecoration, {0.5, 'Sine', 'InOut'}, {
            Size = UDim2.new(0, 40, 0, 45),
            ImageTransparency = 0.3
        })
        Tween(rightDecoration, {0.5, 'Sine', 'InOut'}, {
            Size = UDim2.new(0, 35, 0, 32),
            ImageTransparency = 0.3
        })
    end)
end

-- 装饰图片颜色循环动画
function decorationColorCycle(leftDecoration, rightDecoration)
    spawn(function()
        local colors = {
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(255, 200, 200),
            Color3.fromRGB(200, 255, 200),
            Color3.fromRGB(200, 200, 255),
            Color3.fromRGB(255, 255, 200),
            Color3.fromRGB(200, 255, 255),
            Color3.fromRGB(255, 200, 255)
        }
        local index = 1
        
        while leftDecoration and leftDecoration.Parent do
            Tween(leftDecoration, {1, 'Linear', 'Out'}, {
                ImageColor3 = colors[index]
            })
            Tween(rightDecoration, {1, 'Linear', 'Out'}, {
                ImageColor3 = colors[index]
            })
            
            index = index + 1
            if index > #colors then index = 1 end
            
            wait(1)
        end
    end)
end

-- 装饰图片透明度波动动画
function decorationOpacityWave(leftDecoration, rightDecoration)
    spawn(function()
        while leftDecoration and leftDecoration.Parent do
            Tween(leftDecoration, {2, 'Sine', 'InOut'}, {
                ImageTransparency = 0.2
            })
            Tween(rightDecoration, {2, 'Sine', 'InOut'}, {
                ImageTransparency = 0.4
            })
            wait(2)
            Tween(leftDecoration, {2, 'Sine', 'InOut'}, {
                ImageTransparency = 0.4
            })
            Tween(rightDecoration, {2, 'Sine', 'InOut'}, {
                ImageTransparency = 0.2
            })
            wait(2)
        end
    end)
end

-- 装饰图片缩放动画
function decorationScaleAnimation(leftDecoration, rightDecoration)
    spawn(function()
        while leftDecoration and leftDecoration.Parent do
            wait(math.random(3, 7))
            Tween(leftDecoration, {0.3, 'Quad', 'Out'}, {
                Size = UDim2.new(0, 38, 0, 43)
            })
            Tween(rightDecoration, {0.3, 'Quad', 'Out'}, {
                Size = UDim2.new(0, 33, 0, 30)
            })
            wait(0.3)
            Tween(leftDecoration, {0.3, 'Quad', 'Out'}, {
                Size = UDim2.new(0, 40, 0, 45)
            })
            Tween(rightDecoration, {0.3, 'Quad', 'Out'}, {
                Size = UDim2.new(0, 35, 0, 32)
            })
        end
    end)
end

-- 装饰图片位置波动动画
function decorationPositionWave(leftDecoration, rightDecoration)
    spawn(function()
        while leftDecoration and leftDecoration.Parent do
            Tween(leftDecoration, {1.5, 'Sine', 'InOut'}, {
                Position = UDim2.new(0, -18, 0.5, 0)
            })
            Tween(rightDecoration, {1.5, 'Sine', 'InOut'}, {
                Position = UDim2.new(1, 18, 0.5, 0)
            })
            wait(1.5)
            Tween(leftDecoration, {1.5, 'Sine', 'InOut'}, {
                Position = UDim2.new(0, -22, 0.5, 0)
            })
            Tween(rightDecoration, {1.5, 'Sine', 'InOut'}, {
                Position = UDim2.new(1, 22, 0.5, 0)
            })
            wait(1.5)
        end
    end)
end

-- 装饰图片综合动画初始化
function initAllDecorationAnimations(leftDecoration, rightDecoration)
    breatheAnimation(leftDecoration, rightDecoration)
    colorAnimation(leftDecoration, rightDecoration)
    blinkAnimation(leftDecoration, rightDecoration)
    rotateAnimation(leftDecoration, rightDecoration)
    decorationColorCycle(leftDecoration, rightDecoration)
    decorationOpacityWave(leftDecoration, rightDecoration)
    decorationScaleAnimation(leftDecoration, rightDecoration)
    decorationPositionWave(leftDecoration, rightDecoration)
    
    -- 入场动画
    decorationEntranceAnimation(leftDecoration, rightDecoration)
    
    -- 初始脉冲
    decorationPulseAnimation(leftDecoration, rightDecoration)
end

-- 装饰图片特效管理
local DecorationEffects = {}
DecorationEffects.__index = DecorationEffects

function DecorationEffects.new(leftDecoration, rightDecoration)
    local self = setmetatable({}, DecorationEffects)
    self.left = leftDecoration
    self.right = rightDecoration
    self.animations = {}
    return self
end

function DecorationEffects:startBreathing()
    self.animations.breathing = breatheAnimation(self.left, self.right)
end

function DecorationEffects:startColorCycle()
    self.animations.colorCycle = decorationColorCycle(self.left, self.right)
end

function DecorationEffects:startBlinking()
    self.animations.blinking = blinkAnimation(self.left, self.right)
end

function DecorationEffects:startRotating()
    self.animations.rotating = rotateAnimation(self.left, self.right)
end

function DecorationEffects:startAll()
    self:startBreathing()
    self:startColorCycle()
    self:startBlinking()
    self:startRotating()
    decorationOpacityWave(self.left, self.right)
    decorationScaleAnimation(self.left, self.right)
    decorationPositionWave(self.left, self.right)
end

function DecorationEffects:stopAll()
    for _, anim in pairs(self.animations) do
        if anim then
            -- 停止动画逻辑
        end
    end
end

function DecorationEffects:hoverEffect(enable)
    decorationHoverEffect(self.left, self.right, enable)
end

function DecorationEffects:clickEffect()
    decorationClickEffect(self.left, self.right)
end

function DecorationEffects:pulseEffect()
    decorationPulseAnimation(self.left, self.right)
end

function DecorationEffects:entranceEffect()
    decorationEntranceAnimation(self.left, self.right)
end

function DecorationEffects:exitEffect(callback)
    decorationExitAnimation(self.left, self.right, callback)
end
function library.new(library, name,theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
          v:Destroy()
        end
      end
-------------------------AL------------------------------
-- 标签页面（侧边栏）字体颜色 - 使用不同的颜色
TabFontColor = Color3.fromRGB(139, 0,255)
FunctionFontColor = Color3.fromRGB(0,0,0)  

ALTransparency = 0
-------------------------AL------------------------------
if theme == 'dark' then
    MainColor = Color3.fromRGB(204,255,0)
    Background = Color3.fromRGB(204,255,0)
    zyColor= Color3.fromRGB(204,255,0)
    beijingColor = Color3.fromRGB(204,255,0)
else
    MainColor = Color3.fromRGB(204,255,0)
    Background = Color3.fromRGB(20, 20, 20)
    zyColor= Color3.fromRGB(204,255,0)
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
      local UIG=Instance.new("UIGradient")
      local DropShadowHolder = Instance.new("Frame")
      local DropShadow = Instance.new("ImageLabel")
      local UICornerMain = Instance.new("UICorner")
      local UIGradient=Instance.new("UIGradient")
      local UIGradientTitle=Instance.new("UIGradient")
      local Frame = Instance.new("Frame")
      local UICorner = Instance.new("UICorner")
      local UICorner_2 = Instance.new("UICorner")
      
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
      Main.Transparency = 1.0
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

      UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255,255,255))}

      local TweenService = game:GetService("TweenService")
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
      sideBarToggleBtn.TextColor3 = TabFontColor  -- 使用标签页字体颜色
      sideBarToggleBtn.TextSize = 12
      sideBarToggleBtn.Font = Enum.Font.GothamSemibold
      sideBarToggleBtn.MouseButton1Click:Connect(function()
          sideBarExpanded = not sideBarExpanded
          toggleSideBar(Side, TabBtns, ScriptTitle, sideBarExpanded)
          sideBarToggleBtn.Text = sideBarExpanded and "◀" or "▶"
      end)
      
      -- 为侧边栏按钮添加装饰
      local sideBarLeftDecoration = createLeftDecoration(sideBarToggleBtn)
      local sideBarRightDecoration = createRightDecoration(sideBarToggleBtn)
      sideBarLeftDecoration.Position = UDim2.new(0, -15, 0.5, 0)
      sideBarRightDecoration.Position = UDim2.new(1, 15, 0.5, 0)
      sideBarLeftDecoration.Size = UDim2.new(0, 20, 0, 22)
      sideBarRightDecoration.Size = UDim2.new(0, 18, 0, 20)
      initAllDecorationAnimations(sideBarLeftDecoration, sideBarRightDecoration)
      
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
      TabBtns.ScrollBarImageColor3 = TabFontColor  -- 使用标签页字体颜色
      TabBtns.ScrollBarImageTransparency = 0.7
      
      -- 为滚动条添加装饰
      local scrollBarDecorations = {}
      scrollBarDecorations.left = createLeftDecoration(TabBtns)
      scrollBarDecorations.right = createRightDecoration(TabBtns)
      scrollBarDecorations.left.Position = UDim2.new(0, -10, 0, 0)
      scrollBarDecorations.right.Position = UDim2.new(1, 10, 0, 0)
      scrollBarDecorations.left.Size = UDim2.new(0, 15, 1, 0)
      scrollBarDecorations.right.Size = UDim2.new(0, 15, 1, 0)
      scrollBarDecorations.left.ImageTransparency = 0.5
      scrollBarDecorations.right.ImageTransparency = 0.5
      
      -- 应用平滑滚动动画
      smoothScroll(TabBtns, 0.2)
      
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
      ScriptTitle.TextColor3 = TabFontColor  -- 使用标签页字体颜色
      ScriptTitle.TextSize = 14.000
      ScriptTitle.TextScaled = true
      ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
      
      -- 为脚本标题添加装饰
      local titleLeftDecoration = createLeftDecoration(ScriptTitle)
      local titleRightDecoration = createRightDecoration(ScriptTitle)
      titleLeftDecoration.Position = UDim2.new(0, -25, 0.5, 0)
      titleRightDecoration.Position = UDim2.new(1, 25, 0.5, 0)
      titleLeftDecoration.Size = UDim2.new(0, 30, 0, 34)
      titleRightDecoration.Size = UDim2.new(0, 28, 0, 30)
      initAllDecorationAnimations(titleLeftDecoration, titleRightDecoration)
      
      UIGradientTitle.Parent = ScriptTitle
     
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
      
      SBG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SBG.Rotation = 90
      SBG.Name = "SBG"
      SBG.Parent = SB
      
      -- 为SB添加装饰
      local sbLeftDecoration = createLeftDecoration(SB)
      local sbRightDecoration = createRightDecoration(SB)
      sbLeftDecoration.Position = UDim2.new(0.5, -25, 0, 10)
      sbRightDecoration.Position = UDim2.new(0.5, 25, 0, 10)
      sbLeftDecoration.Size = UDim2.new(0, 20, 0, 40)
      sbRightDecoration.Size = UDim2.new(0, 20, 0, 40)
      sbLeftDecoration.ImageTransparency = 0.4
      sbRightDecoration.ImageTransparency = 0.4
      initAllDecorationAnimations(sbLeftDecoration, sbRightDecoration)
    
      TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
      end)
      
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
Open.MouseButton1Click:Connect(function()
  Main.Visible = not Main.Visible
  Open.Image = Main.Visible and "rbxassetid://137748573642696" or "rbxassetid://127834329692871"
  
  -- 按钮点击动画
  Tween(Open, {0.1, 'Quad', 'Out'}, {
      Size = UDim2.new(0, 45, 0, 45)
  })
  wait(0.1)
  Tween(Open, {0.1, 'Quad', 'Out'}, {
      Size = UDim2.new(0, 50, 0, 50)
  })
  
  -- 装饰点击特效
  if Open.LeftDecoration and Open.RightDecoration then
    decorationClickEffect(Open.LeftDecoration, Open.RightDecoration)
  end
end)

-- 为Open按钮添加装饰
local openLeftDecoration = createLeftDecoration(Open)
local openRightDecoration = createRightDecoration(Open)
openLeftDecoration.Position = UDim2.new(0, -15, 0.5, 0)
openRightDecoration.Position = UDim2.new(1, 15, 0.5, 0)
openLeftDecoration.Size = UDim2.new(0, 30, 0, 40)
openRightDecoration.Size = UDim2.new(0, 28, 0, 35)
Open.LeftDecoration = openLeftDecoration
Open.RightDecoration = openRightDecoration
initAllDecorationAnimations(openLeftDecoration, openRightDecoration)

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Name = "OpenCorner"
OpenCorner.Parent = Open

UIG.Parent = Open

-- 为UIG添加装饰
local uigLeftDecoration = createLeftDecoration(UIG)
local uigRightDecoration = createRightDecoration(UIG)
uigLeftDecoration.Position = UDim2.new(0, -5, 0.5, 0)
uigRightDecoration.Position = UDim2.new(1, 5, 0.5, 0)
uigLeftDecoration.Size = UDim2.new(0, 25, 0, 35)
uigRightDecoration.Size = UDim2.new(0, 23, 0, 30)
uigLeftDecoration.ImageTransparency = 0.6
uigRightDecoration.ImageTransparency = 0.6

-- 装饰管理器
local decorationManager = {
    activeDecorations = {},
    addDecoration = function(self, parent, leftId, rightId, leftSize, rightSize, leftPos, rightPos)
        local left = createLeftDecoration(parent)
        local right = createRightDecoration(parent)
        
        if leftId then left.Image = leftId end
        if rightId then right.Image = rightId end
        if leftSize then left.Size = leftSize end
        if rightSize then right.Size = rightSize end
        if leftPos then left.Position = leftPos end
        if rightPos then right.Position = rightPos end
        
        initAllDecorationAnimations(left, right)
        
        local decorationSet = {
            left = left,
            right = right,
            parent = parent
        }
        
        table.insert(self.activeDecorations, decorationSet)
        return decorationSet
    end,
    
    removeDecorations = function(self, parent)
        for i = #self.activeDecorations, 1, -1 do
            local decorationSet = self.activeDecorations[i]
            if decorationSet.parent == parent then
                decorationSet.left:Destroy()
                decorationSet.right:Destroy()
                table.remove(self.activeDecorations, i)
            end
        end
    end,
    
    updateAllDecorations = function(self)
        for _, decorationSet in ipairs(self.activeDecorations) do
            if decorationSet.left and decorationSet.right then
                decorationPulseAnimation(decorationSet.left, decorationSet.right)
            end
        end
    end,
    
    highlightDecorations = function(self, parent, highlight)
        for _, decorationSet in ipairs(self.activeDecorations) do
            if decorationSet.parent == parent then
                decorationHoverEffect(decorationSet.left, decorationSet.right, highlight)
            end
        end
    end
}

-- 全局装饰更新循环
spawn(function()
    while wait(10) do
        decorationManager:updateAllDecorations()
    end
end)

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
        Tab.ScrollBarImageColor3 = TabFontColor  -- 使用标签页字体颜色
        Tab.ScrollBarImageTransparency = 0.7
        Tab.Visible = false
        
        -- 为Tab添加装饰
        local tabLeftDecoration = createLeftDecoration(Tab)
        local tabRightDecoration = createRightDecoration(Tab)
        tabLeftDecoration.Position = UDim2.new(0, -30, 0, 50)
        tabRightDecoration.Position = UDim2.new(1, 30, 0, 50)
        tabLeftDecoration.Size = UDim2.new(0, 35, 0, 200)
        tabRightDecoration.Size = UDim2.new(0, 32, 0, 200)
        tabLeftDecoration.ImageTransparency = 0.4
        tabRightDecoration.ImageTransparency = 0.4
        decorationManager:addDecoration(Tab, nil, nil, 
            UDim2.new(0, 35, 0, 200), 
            UDim2.new(0, 32, 0, 200),
            UDim2.new(0, -30, 0, 50),
            UDim2.new(1, 30, 0, 50))
        
        -- 应用Tab内容平滑滚动动画
        smoothScroll(Tab, 0.2)
        
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
        TabText.TextColor3 = TabFontColor  -- 使用标签页字体颜色（浅蓝色）
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
        
        -- 为Tab按钮添加装饰
        local tabBtnLeftDecoration = createLeftDecoration(TabBtn)
        local tabBtnRightDecoration = createRightDecoration(TabBtn)
        tabBtnLeftDecoration.Position = UDim2.new(0, -12, 0.5, 0)
        tabBtnRightDecoration.Position = UDim2.new(1, 12, 0.5, 0)
        tabBtnLeftDecoration.Size = UDim2.new(0, 20, 0, 28)
        tabBtnRightDecoration.Size = UDim2.new(0, 18, 0, 25)
        tabBtnLeftDecoration.ImageTransparency = 0.4
        tabBtnRightDecoration.ImageTransparency = 0.4
        decorationManager:addDecoration(TabBtn, nil, nil,
            UDim2.new(0, 20, 0, 28),
            UDim2.new(0, 18, 0, 25),
            UDim2.new(0, -12, 0.5, 0),
            UDim2.new(1, 12, 0.5, 0))
        
        -- Tab按钮悬停动画
        TabBtn.MouseEnter:Connect(function()
            Tween(TabIco, {0.2, 'Quad', 'Out'}, {
                ImageTransparency = 0
            })
            Tween(TabText, {0.2, 'Quad', 'Out'}, {
                TextTransparency = 0
            })
            decorationManager:highlightDecorations(TabBtn, true)
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
            decorationManager:highlightDecorations(TabBtn, false)
        end)
        
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 4)
    
        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
            decorationManager:highlightDecorations(TabBtn, true)
            wait(0.1)
            decorationManager:highlightDecorations(TabBtn, false)
            switchTab({TabIco, Tab})
        end)
    
        if library.currentTab == nil then switchTab({TabIco, Tab}) end
    
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)
        
        -- 装饰图片更新
        spawn(function()
            while TabBtn and TabBtn.Parent do
                wait(math.random(2, 5))
                decorationPulseAnimation(tabBtnLeftDecoration, tabBtnRightDecoration)
            end
        end)
        
        -- 装饰图片交互
        tabBtnLeftDecoration.MouseEnter:Connect(function()
            decorationHoverEffect(tabBtnLeftDecoration, tabBtnRightDecoration, true)
        end)
        
        tabBtnLeftDecoration.MouseLeave:Connect(function()
            decorationHoverEffect(tabBtnLeftDecoration, tabBtnRightDecoration, false)
        end)
        
        tabBtnRightDecoration.MouseEnter:Connect(function()
            decorationHoverEffect(tabBtnLeftDecoration, tabBtnRightDecoration, true)
        end)
        
        tabBtnRightDecoration.MouseLeave:Connect(function()
            decorationHoverEffect(tabBtnLeftDecoration, tabBtnRightDecoration, false)
        end)
        
        -- 装饰图片点击
        tabBtnLeftDecoration.MouseButton1Click:Connect(function()
            TabBtn.MouseButton1Click:Fire()
            decorationClickEffect(tabBtnLeftDecoration, tabBtnRightDecoration)
        end)
        
        tabBtnRightDecoration.MouseButton1Click:Connect(function()
            TabBtn.MouseButton1Click:Fire()
            decorationClickEffect(tabBtnLeftDecoration, tabBtnRightDecoration)
        end)
        ------------------------------------------------------AL.King音乐-------------------------------------------------------
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6797864253"
    sound.Parent = game.Workspace
    sound:Play()
    
    -- 为音乐播放器添加装饰
    local soundLeftDecoration = createLeftDecoration(sound)
    local soundRightDecoration = createRightDecoration(sound)
    soundLeftDecoration.Position = UDim2.new(0, -5, 0.5, 0)
    soundRightDecoration.Position = UDim2.new(1, 5, 0.5, 0)
    soundLeftDecoration.Size = UDim2.new(0, 30, 0, 30)
    soundRightDecoration.Size = UDim2.new(0, 28, 0, 28)
    soundLeftDecoration.ImageTransparency = 0.5
    soundRightDecoration.ImageTransparency = 0.5
    initAllDecorationAnimations(soundLeftDecoration, soundRightDecoration)
    
    -- 音乐可视化装饰
    spawn(function()
        while sound and sound.Parent do
            local volume = sound.PlaybackLoudness / 1000
            Tween(soundLeftDecoration, {0.1, 'Linear', 'Out'}, {
                Size = UDim2.new(0, 30 + volume * 10, 0, 30 + volume * 10)
            })
            Tween(soundRightDecoration, {0.1, 'Linear', 'Out'}, {
                Size = UDim2.new(0, 28 + volume * 10, 0, 28 + volume * 10)
            })
            wait(0.1)
        end
    end)
    
---------------分割线-------------------------------分割线-------------------------------分割线----------------
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
          Section.BackgroundTransparency = 1.000
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
          SectionText.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
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
          
          -- 为Section添加装饰
          local sectionLeftDecoration = createLeftDecoration(Section)
          local sectionRightDecoration = createRightDecoration(Section)
          sectionLeftDecoration.Position = UDim2.new(0, -25, 0.5, 0)
          sectionRightDecoration.Position = UDim2.new(1, 25, 0.5, 0)
          sectionLeftDecoration.Size = UDim2.new(0, 35, 0, 40)
          sectionRightDecoration.Size = UDim2.new(0, 32, 0, 36)
          sectionLeftDecoration.ImageTransparency = 0.4
          sectionRightDecoration.ImageTransparency = 0.4
          
          -- 为SectionText添加装饰
          local sectionTextLeftDecoration = createLeftDecoration(SectionText)
          local sectionTextRightDecoration = createRightDecoration(SectionText)
          sectionTextLeftDecoration.Position = UDim2.new(0, -20, 0.5, 0)
          sectionTextRightDecoration.Position = UDim2.new(1, 20, 0.5, 0)
          sectionTextLeftDecoration.Size = UDim2.new(0, 30, 0, 38)
          sectionTextRightDecoration.Size = UDim2.new(0, 28, 0, 34)
          sectionTextLeftDecoration.ImageTransparency = 0.3
          sectionTextRightDecoration.ImageTransparency = 0.3
          
          -- 为SectionToggle添加装饰
          local toggleLeftDecoration = createLeftDecoration(SectionToggle)
          local toggleRightDecoration = createRightDecoration(SectionToggle)
          toggleLeftDecoration.Position = UDim2.new(0, -8, 0.5, 0)
          toggleRightDecoration.Position = UDim2.new(1, 8, 0.5, 0)
          toggleLeftDecoration.Size = UDim2.new(0, 18, 0, 22)
          toggleRightDecoration.Size = UDim2.new(0, 16, 0, 20)
          toggleLeftDecoration.ImageTransparency = 0.5
          toggleRightDecoration.ImageTransparency = 0.5
          
          initAllDecorationAnimations(sectionLeftDecoration, sectionRightDecoration)
          initAllDecorationAnimations(sectionTextLeftDecoration, sectionTextRightDecoration)
          initAllDecorationAnimations(toggleLeftDecoration, toggleRightDecoration)
          
          -- 装饰动画控制
          local decorationEffects = DecorationEffects.new(sectionLeftDecoration, sectionRightDecoration)
          decorationEffects:startAll()
          
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
            
            -- 装饰动画
            decorationEffects:clickEffect()
            decorationPulseAnimation(sectionTextLeftDecoration, sectionTextRightDecoration)
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
            Btn.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
            Btn.TextSize = 16.000
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.BackgroundTransparency = ALTransparency
            
            BtnC.CornerRadius = UDim.new(0, 18)
            BtnC.Name = "BtnC"
            BtnC.Parent = Btn
            
            -- 添加左侧装饰图片（高度较高）
            local BtnLeftDecoration = createLeftDecoration(Btn)
            -- 添加右侧装饰图片（高度较矮）
            local BtnRightDecoration = createRightDecoration(Btn)
            
            BtnLeftDecoration.Name = "BtnLeftDecoration"
            BtnLeftDecoration.Parent = Btn
            BtnLeftDecoration.AnchorPoint = Vector2.new(0, 0.5)
            BtnLeftDecoration.BackgroundTransparency = 1
            BtnLeftDecoration.Position = UDim2.new(0, -20, 0.5, 0)
            BtnLeftDecoration.Size = UDim2.new(0, 40, 0, 45)  -- 高度较高
            BtnLeftDecoration.Image = "rbxassetid://82255019023654"
            BtnLeftDecoration.ImageTransparency = 0.3
            BtnLeftDecoration.ScaleType = Enum.ScaleType.Fit
            BtnLeftDecoration.ImageColor3 = Color3.fromRGB(255, 255, 255)
            
            BtnRightDecoration.Name = "BtnRightDecoration"
            BtnRightDecoration.Parent = Btn
            BtnRightDecoration.AnchorPoint = Vector2.new(1, 0.5)
            BtnRightDecoration.BackgroundTransparency = 1
            BtnRightDecoration.Position = UDim2.new(1, 20, 0.5, 0)
            BtnRightDecoration.Size = UDim2.new(0, 35, 0, 32)  -- 高度较矮
            BtnRightDecoration.Image = "rbxassetid://86985903461819"
            BtnRightDecoration.ImageTransparency = 0.3
            BtnRightDecoration.ScaleType = Enum.ScaleType.Fit
            BtnRightDecoration.ImageColor3 = Color3.fromRGB(255, 255, 255)
            
            -- 初始化装饰动画
            local btnDecorationEffects = DecorationEffects.new(BtnLeftDecoration, BtnRightDecoration)
            btnDecorationEffects:startAll()
            
            -- 为BtnModule添加装饰
            local moduleLeftDecoration = createLeftDecoration(BtnModule)
            local moduleRightDecoration = createRightDecoration(BtnModule)
            moduleLeftDecoration.Position = UDim2.new(0, -15, 0.5, 0)
            moduleRightDecoration.Position = UDim2.new(1, 15, 0.5, 0)
            moduleLeftDecoration.Size = UDim2.new(0, 30, 0, 42)
            moduleRightDecoration.Size = UDim2.new(0, 28, 0, 38)
            moduleLeftDecoration.ImageTransparency = 0.5
            moduleRightDecoration.ImageTransparency = 0.5
            initAllDecorationAnimations(moduleLeftDecoration, moduleRightDecoration)
    
            -- 按钮悬停动画
            Btn.MouseEnter:Connect(function()
                Tween(Btn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency - 0.1
                })
                btnDecorationEffects:hoverEffect(true)
                decorationHoverEffect(moduleLeftDecoration, moduleRightDecoration, true)
            end)
            
            Btn.MouseLeave:Connect(function()
                Tween(Btn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency
                })
                btnDecorationEffects:hoverEffect(false)
                decorationHoverEffect(moduleLeftDecoration, moduleRightDecoration, false)
            end)
            
            -- 装饰图片悬停效果
            BtnLeftDecoration.MouseEnter:Connect(function()
                btnDecorationEffects:hoverEffect(true)
                decorationHoverEffect(moduleLeftDecoration, moduleRightDecoration, true)
            end)
            
            BtnLeftDecoration.MouseLeave:Connect(function()
                btnDecorationEffects:hoverEffect(false)
                decorationHoverEffect(moduleLeftDecoration, moduleRightDecoration, false)
            end)
            
            BtnRightDecoration.MouseEnter:Connect(function()
                btnDecorationEffects:hoverEffect(true)
                decorationHoverEffect(moduleLeftDecoration, moduleRightDecoration, true)
            end)
            
            BtnRightDecoration.MouseLeave:Connect(function()
                btnDecorationEffects:hoverEffect(false)
                decorationHoverEffect(moduleLeftDecoration, moduleRightDecoration, false)
            end)
            
            -- 装饰图片点击
            BtnLeftDecoration.MouseButton1Click:Connect(function()
                Btn.MouseButton1Click:Fire()
                btnDecorationEffects:clickEffect()
                decorationClickEffect(moduleLeftDecoration, moduleRightDecoration)
            end)
            
            BtnRightDecoration.MouseButton1Click:Connect(function()
                Btn.MouseButton1Click:Fire()
                btnDecorationEffects:clickEffect()
                decorationClickEffect(moduleLeftDecoration, moduleRightDecoration)
            end)

            Btn.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(Btn)
                end)
                spawn(callback)
                btnDecorationEffects:clickEffect()
                decorationClickEffect(moduleLeftDecoration, moduleRightDecoration)
            end)
            
            -- 装饰图片呼吸动画
            spawn(function()
                while Btn and Btn.Parent do
                    wait(math.random(3, 7))
                    decorationPulseAnimation(BtnLeftDecoration, BtnRightDecoration)
                    decorationPulseAnimation(moduleLeftDecoration, moduleRightDecoration)
                end
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
          TextLabel.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
          TextLabel.BackgroundTransparency = ALTransparency
          TextLabel.TextSize = 14.000
    
          LabelC.CornerRadius = UDim.new(0, 18)
          LabelC.Name = "LabelC"
          LabelC.Parent = TextLabel
          
          -- 添加左侧装饰图片
          local LabelLeftDecoration = createLeftDecoration(TextLabel)
          -- 添加右侧装饰图片
          local LabelRightDecoration = createRightDecoration(TextLabel)
          
          LabelLeftDecoration.Name = "LabelLeftDecoration"
          LabelLeftDecoration.Parent = TextLabel
          LabelLeftDecoration.AnchorPoint = Vector2.new(0, 0.5)
          LabelLeftDecoration.BackgroundTransparency = 1
          LabelLeftDecoration.Position = UDim2.new(0, -18, 0.5, 0)
          LabelLeftDecoration.Size = UDim2.new(0, 36, 0, 40)  -- 高度较高
          LabelLeftDecoration.Image = "rbxassetid://82255019023654"
          LabelLeftDecoration.ImageTransparency = 0.3
          LabelLeftDecoration.ScaleType = Enum.ScaleType.Fit
          LabelLeftDecoration.ImageColor3 = Color3.fromRGB(255, 255, 255)
          
          LabelRightDecoration.Name = "LabelRightDecoration"
          LabelRightDecoration.Parent = TextLabel
          LabelRightDecoration.AnchorPoint = Vector2.new(1, 0.5)
          LabelRightDecoration.BackgroundTransparency = 1
          LabelRightDecoration.Position = UDim2.new(1, 18, 0.5, 0)
          LabelRightDecoration.Size = UDim2.new(0, 32, 0, 28)  -- 高度较矮
          LabelRightDecoration.Image = "rbxassetid://86985903461819"
          LabelRightDecoration.ImageTransparency = 0.3
          LabelRightDecoration.ScaleType = Enum.ScaleType.Fit
          LabelRightDecoration.ImageColor3 = Color3.fromRGB(255, 255, 255)
          
          -- 为LabelModule添加装饰
          local labelModuleLeftDecoration = createLeftDecoration(LabelModule)
          local labelModuleRightDecoration = createRightDecoration(LabelModule)
          labelModuleLeftDecoration.Position = UDim2.new(0, -12, 0.5, 0)
          labelModuleRightDecoration.Position = UDim2.new(1, 12, 0.5, 0)
          labelModuleLeftDecoration.Size = UDim2.new(0, 28, 0, 35)
          labelModuleRightDecoration.Size = UDim2.new(0, 26, 0, 32)
          labelModuleLeftDecoration.ImageTransparency = 0.5
          labelModuleRightDecoration.ImageTransparency = 0.5
          
          initAllDecorationAnimations(LabelLeftDecoration, LabelRightDecoration)
          initAllDecorationAnimations(labelModuleLeftDecoration, labelModuleRightDecoration)
          
          -- 标签装饰动画
          local labelDecorationEffects = DecorationEffects.new(LabelLeftDecoration, LabelRightDecoration)
          labelDecorationEffects:startAll()
          
          -- 标签悬停效果
          TextLabel.MouseEnter:Connect(function()
            labelDecorationEffects:hoverEffect(true)
            decorationHoverEffect(labelModuleLeftDecoration, labelModuleRightDecoration, true)
          end)
          
          TextLabel.MouseLeave:Connect(function()
            labelDecorationEffects:hoverEffect(false)
            decorationHoverEffect(labelModuleLeftDecoration, labelModuleRightDecoration, false)
          end)
          
          -- 装饰图片悬停
          LabelLeftDecoration.MouseEnter:Connect(function()
            labelDecorationEffects:hoverEffect(true)
            decorationHoverEffect(labelModuleLeftDecoration, labelModuleRightDecoration, true)
          end)
          
          LabelLeftDecoration.MouseLeave:Connect(function()
            labelDecorationEffects:hoverEffect(false)
            decorationHoverEffect(labelModuleLeftDecoration, labelModuleRightDecoration, false)
          end)
          
          LabelRightDecoration.MouseEnter:Connect(function()
            labelDecorationEffects:hoverEffect(true)
            decorationHoverEffect(labelModuleLeftDecoration, labelModuleRightDecoration, true)
          end)
          
          LabelRightDecoration.MouseLeave:Connect(function()
            labelDecorationEffects:hoverEffect(false)
            decorationHoverEffect(labelModuleLeftDecoration, labelModuleRightDecoration, false)
          end)
          
          -- 装饰图片点击
          LabelLeftDecoration.MouseButton1Click:Connect(function()
            labelDecorationEffects:clickEffect()
            decorationClickEffect(labelModuleLeftDecoration, labelModuleRightDecoration)
          end)
          
          LabelRightDecoration.MouseButton1Click:Connect(function()
            labelDecorationEffects:clickEffect()
            decorationClickEffect(labelModuleLeftDecoration, labelModuleRightDecoration)
          end)
          
          -- 装饰图片呼吸动画
          spawn(function()
            while TextLabel and TextLabel.Parent do
                wait(math.random(4, 8))
                decorationPulseAnimation(LabelLeftDecoration, LabelRightDecoration)
                decorationPulseAnimation(labelModuleLeftDecoration, labelModuleRightDecoration)
            end
          end)
          
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
            ToggleBtn.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
            ToggleBtn.TextSize = 16.000
            ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleBtnC.CornerRadius = UDim.new(0, 18)
            ToggleBtnC.Name = "ToggleBtnC"
            ToggleBtnC.Parent = ToggleBtn
            
            -- 添加左侧装饰图片（高度较高）
            local ToggleLeftDecoration = createLeftDecoration(ToggleBtn)
            -- 添加右侧装饰图片（高度较矮）
            local ToggleRightDecoration = createRightDecoration(ToggleBtn)
            
            ToggleLeftDecoration.Name = "ToggleLeftDecoration"
            ToggleLeftDecoration.Parent = ToggleBtn
            ToggleLeftDecoration.AnchorPoint = Vector2.new(0, 0.5)
            ToggleLeftDecoration.BackgroundTransparency = 1
            ToggleLeftDecoration.Position = UDim2.new(0, -20, 0.5, 0)
            ToggleLeftDecoration.Size = UDim2.new(0, 40, 0, 45)  -- 高度较高
            ToggleLeftDecoration.Image = "rbxassetid://82255019023654"
            ToggleLeftDecoration.ImageTransparency = 0.3
            ToggleLeftDecoration.ScaleType = Enum.ScaleType.Fit
            ToggleLeftDecoration.ImageColor3 = Color3.fromRGB(255, 255, 255)
            
            ToggleRightDecoration.Name = "ToggleRightDecoration"
            ToggleRightDecoration.Parent = ToggleBtn
            ToggleRightDecoration.AnchorPoint = Vector2.new(1, 0.5)
            ToggleRightDecoration.BackgroundTransparency = 1
            ToggleRightDecoration.Position = UDim2.new(1, 20, 0.5, 0)
            ToggleRightDecoration.Size = UDim2.new(0, 35, 0, 32)  -- 高度较矮
            ToggleRightDecoration.Image = "rbxassetid://86985903461819"
            ToggleRightDecoration.ImageTransparency = 0.3
            ToggleRightDecoration.ScaleType = Enum.ScaleType.Fit
            ToggleRightDecoration.ImageColor3 = Color3.fromRGB(255, 255, 255)
            
            -- 为ToggleDisable添加装饰
            local toggleDisableLeftDecoration = createLeftDecoration(ToggleDisable)
            local toggleDisableRightDecoration = createRightDecoration(ToggleDisable)
            toggleDisableLeftDecoration.Position = UDim2.new(0, -5, 0.5, 0)
            toggleDisableRightDecoration.Position = UDim2.new(1, 5, 0.5, 0)
            toggleDisableLeftDecoration.Size = UDim2.new(0, 15, 0, 18)
            toggleDisableRightDecoration.Size = UDim2.new(0, 14, 0, 16)
            toggleDisableLeftDecoration.ImageTransparency = 0.6
            toggleDisableRightDecoration.ImageTransparency = 0.6
            
            -- 为ToggleSwitch添加装饰
            local toggleSwitchLeftDecoration = createLeftDecoration(ToggleSwitch)
            local toggleSwitchRightDecoration = createRightDecoration(ToggleSwitch)
            toggleSwitchLeftDecoration.Position = UDim2.new(0, -3, 0.5, 0)
            toggleSwitchRightDecoration.Position = UDim2.new(1, 3, 0.5, 0)
            toggleSwitchLeftDecoration.Size = UDim2.new(0, 12, 0, 20)
            toggleSwitchRightDecoration.Size = UDim2.new(0, 11, 0, 18)
            toggleSwitchLeftDecoration.ImageTransparency = 0.7
            toggleSwitchRightDecoration.ImageTransparency = 0.7
            
            -- 为ToggleModule添加装饰
            local toggleModuleLeftDecoration = createLeftDecoration(ToggleModule)
            local toggleModuleRightDecoration = createRightDecoration(ToggleModule)
            toggleModuleLeftDecoration.Position = UDim2.new(0, -15, 0.5, 0)
            toggleModuleRightDecoration.Position = UDim2.new(1, 15, 0.5, 0)
            toggleModuleLeftDecoration.Size = UDim2.new(0, 30, 0, 42)
            toggleModuleRightDecoration.Size = UDim2.new(0, 28, 0, 38)
            toggleModuleLeftDecoration.ImageTransparency = 0.5
            toggleModuleRightDecoration.ImageTransparency = 0.5
            
            -- 初始化所有装饰动画
            local toggleDecorationEffects = DecorationEffects.new(ToggleLeftDecoration, ToggleRightDecoration)
            toggleDecorationEffects:startAll()
            initAllDecorationAnimations(toggleDisableLeftDecoration, toggleDisableRightDecoration)
            initAllDecorationAnimations(toggleSwitchLeftDecoration, toggleSwitchRightDecoration)
            initAllDecorationAnimations(toggleModuleLeftDecoration, toggleModuleRightDecoration)
            
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
                toggleDecorationEffects:hoverEffect(true)
                decorationHoverEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration, true)
                decorationHoverEffect(toggleDisableLeftDecoration, toggleDisableRightDecoration, true)
                decorationHoverEffect(toggleSwitchLeftDecoration, toggleSwitchRightDecoration, true)
            end)
            
            ToggleBtn.MouseLeave:Connect(function()
                Tween(ToggleBtn, {0.2, 'Quad', 'Out'}, {
                    BackgroundTransparency = ALTransparency
                })
                toggleDecorationEffects:hoverEffect(false)
                decorationHoverEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration, false)
                decorationHoverEffect(toggleDisableLeftDecoration, toggleDisableRightDecoration, false)
                decorationHoverEffect(toggleSwitchLeftDecoration, toggleSwitchRightDecoration, false)
            end)
            
            -- 装饰图片悬停
            ToggleLeftDecoration.MouseEnter:Connect(function()
                toggleDecorationEffects:hoverEffect(true)
                decorationHoverEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration, true)
            end)
            
            ToggleLeftDecoration.MouseLeave:Connect(function()
                toggleDecorationEffects:hoverEffect(false)
                decorationHoverEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration, false)
            end)
            
            ToggleRightDecoration.MouseEnter:Connect(function()
                toggleDecorationEffects:hoverEffect(true)
                decorationHoverEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration, true)
            end)
            
            ToggleRightDecoration.MouseLeave:Connect(function()
                toggleDecorationEffects:hoverEffect(false)
                decorationHoverEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration, false)
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
        
        -- 状态切换装饰特效
        toggleDecorationEffects:clickEffect()
        decorationClickEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration)
        decorationClickEffect(toggleDisableLeftDecoration, toggleDisableRightDecoration)
        decorationClickEffect(toggleSwitchLeftDecoration, toggleSwitchRightDecoration)
        
        -- 状态特定特效
        if state then
            Tween(ToggleLeftDecoration, {0.3, 'Quad', 'Out'}, {
                ImageColor3 = Color3.fromRGB(255, 255, 150)
            })
            Tween(ToggleRightDecoration, {0.3, 'Quad', 'Out'}, {
                ImageColor3 = Color3.fromRGB(150, 255, 150)
            })
        else
            Tween(ToggleLeftDecoration, {0.3, 'Quad', 'Out'}, {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            })
            Tween(ToggleRightDecoration, {0.3, 'Quad', 'Out'}, {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            })
        end
      end,
      Module = ToggleModule
    }
    
    if enabled ~= false then
        funcs:SetState(flag,true)
    end

    ToggleBtn.MouseButton1Click:Connect(function()
      funcs:SetState()
    end)
    
    -- 装饰图片点击
    ToggleLeftDecoration.MouseButton1Click:Connect(function()
        funcs:SetState()
        toggleDecorationEffects:clickEffect()
        decorationClickEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration)
    end)
    
    ToggleRightDecoration.MouseButton1Click:Connect(function()
        funcs:SetState()
        toggleDecorationEffects:clickEffect()
        decorationClickEffect(toggleModuleLeftDecoration, toggleModuleRightDecoration)
    end)
    
    -- 装饰呼吸动画
    spawn(function()
        while ToggleBtn and ToggleBtn.Parent do
            wait(math.random(3, 6))
            decorationPulseAnimation(ToggleLeftDecoration, ToggleRightDecoration)
            decorationPulseAnimation(toggleModuleLeftDecoration, toggleModuleRightDecoration)
            wait(math.random(2, 4))
            decorationPulseAnimation(toggleDisableLeftDecoration, toggleDisableRightDecoration)
            wait(math.random(1, 3))
            decorationPulseAnimation(toggleSwitchLeftDecoration, toggleSwitchRightDecoration)
        end
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
    KeybindModule.BackgroundColor3 = Color3.fromRGB(255,255,255)
    KeybindModule.BackgroundTransparency = 1.000
    KeybindModule.BorderSizePixel = 0
    KeybindModule.Position = UDim2.new(0, 0, 0, 0)
    KeybindModule.Size = UDim2.new(0, 428, 0, 38)
    
    KeybindBtn.Name = "KeybindBtn"
    KeybindBtn.Parent = KeybindModule
    KeybindBtn.BackgroundColor3 = zyColor
    KeybindBtn.BorderSizePixel = 0
    KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
    KeybindBtn.AutoButtonColor = false
    KeybindBtn.Font = Enum.Font.GothamSemibold
    KeybindBtn.Text = "   " .. text
    KeybindBtn.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
    KeybindBtn.TextSize = 16.000
    KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
    KeybindBtn.BackgroundTransparency = ALTransparency
    
    KeybindBtnC.CornerRadius = UDim.new(0, 18)
    KeybindBtnC.Name = "KeybindBtnC"
    KeybindBtnC.Parent = KeybindBtn
    
    -- 为KeybindBtn添加装饰
    local keybindLeftDecoration = createLeftDecoration(KeybindBtn)
    local keybindRightDecoration = createRightDecoration(KeybindBtn)
    keybindLeftDecoration.Position = UDim2.new(0, -20, 0.5, 0)
    keybindRightDecoration.Position = UDim2.new(1, 20, 0.5, 0)
    keybindLeftDecoration.Size = UDim2.new(0, 40, 0, 45)
    keybindRightDecoration.Size = UDim2.new(0, 35, 0, 32)
    keybindLeftDecoration.ImageTransparency = 0.3
    keybindRightDecoration.ImageTransparency = 0.3
    
    -- 为KeybindValue添加装饰
    local keybindValueLeftDecoration = createLeftDecoration(KeybindValue)
    local keybindValueRightDecoration = createRightDecoration(KeybindValue)
    keybindValueLeftDecoration.Position = UDim2.new(0, -8, 0.5, 0)
    keybindValueRightDecoration.Position = UDim2.new(1, 8, 0.5, 0)
    keybindValueLeftDecoration.Size = UDim2.new(0, 20, 0, 25)
    keybindValueRightDecoration.Size = UDim2.new(0, 18, 0, 22)
    keybindValueLeftDecoration.ImageTransparency = 0.5
    keybindValueRightDecoration.ImageTransparency = 0.5
    
    -- 为KeybindModule添加装饰
    local keybindModuleLeftDecoration = createLeftDecoration(KeybindModule)
    local keybindModuleRightDecoration = createRightDecoration(KeybindModule)
    keybindModuleLeftDecoration.Position = UDim2.new(0, -15, 0.5, 0)
    keybindModuleRightDecoration.Position = UDim2.new(1, 15, 0.5, 0)
    keybindModuleLeftDecoration.Size = UDim2.new(0, 30, 0, 42)
    keybindModuleRightDecoration.Size = UDim2.new(0, 28, 0, 38)
    keybindModuleLeftDecoration.ImageTransparency = 0.5
    keybindModuleRightDecoration.ImageTransparency = 0.5
    
    -- 初始化装饰动画
    local keybindDecorationEffects = DecorationEffects.new(keybindLeftDecoration, keybindRightDecoration)
    keybindDecorationEffects:startAll()
    initAllDecorationAnimations(keybindValueLeftDecoration, keybindValueRightDecoration)
    initAllDecorationAnimations(keybindModuleLeftDecoration, keybindModuleRightDecoration)
    
    KeybindValue.Name = "KeybindValue"
    KeybindValue.Parent = KeybindBtn
    KeybindValue.BackgroundColor3 = Background
    KeybindValue.BorderSizePixel = 0
    KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
    KeybindValue.Size = UDim2.new(0, 100, 0, 28)
    KeybindValue.AutoButtonColor = false
    KeybindValue.Font = Enum.Font.Gotham
    KeybindValue.Text = keyTxt
    KeybindValue.TextColor3 = Color3.fromRGB(255,255,255)
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
    
    -- Keybind悬停动画
    KeybindBtn.MouseEnter:Connect(function()
        Tween(KeybindBtn, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency - 0.1
        })
        keybindDecorationEffects:hoverEffect(true)
        decorationHoverEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration, true)
        decorationHoverEffect(keybindValueLeftDecoration, keybindValueRightDecoration, true)
    end)
    
    KeybindBtn.MouseLeave:Connect(function()
        Tween(KeybindBtn, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency
        })
        keybindDecorationEffects:hoverEffect(false)
        decorationHoverEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration, false)
        decorationHoverEffect(keybindValueLeftDecoration, keybindValueRightDecoration, false)
    end)
    
    -- KeybindValue悬停动画
    KeybindValue.MouseEnter:Connect(function()
        Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(204,255,0)
        })
        decorationHoverEffect(keybindValueLeftDecoration, keybindValueRightDecoration, true)
    end)
    
    KeybindValue.MouseLeave:Connect(function()
        Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background
        })
        decorationHoverEffect(keybindValueLeftDecoration, keybindValueRightDecoration, false)
    end)
    
    -- 装饰图片悬停
    keybindLeftDecoration.MouseEnter:Connect(function()
        keybindDecorationEffects:hoverEffect(true)
        decorationHoverEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration, true)
    end)
    
    keybindLeftDecoration.MouseLeave:Connect(function()
        keybindDecorationEffects:hoverEffect(false)
        decorationHoverEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration, false)
    end)
    
    keybindRightDecoration.MouseEnter:Connect(function()
        keybindDecorationEffects:hoverEffect(true)
        decorationHoverEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration, true)
    end)
    
    keybindRightDecoration.MouseLeave:Connect(function()
        keybindDecorationEffects:hoverEffect(false)
        decorationHoverEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration, false)
    end)
    
    -- 装饰图片点击
    keybindLeftDecoration.MouseButton1Click:Connect(function()
        KeybindValue.MouseButton1Click:Fire()
        keybindDecorationEffects:clickEffect()
        decorationClickEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration)
    end)
    
    keybindRightDecoration.MouseButton1Click:Connect(function()
        KeybindValue.MouseButton1Click:Fire()
        keybindDecorationEffects:clickEffect()
        decorationClickEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration)
    end)
    
    services.UserInputService.InputBegan:Connect(function(inp, gpe)
        if gpe then return end
        if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
        if inp.KeyCode ~= bindKey then return end
        callback(bindKey.Name)
        
        -- 按键触发装饰特效
        keybindDecorationEffects:clickEffect()
        decorationClickEffect(keybindModuleLeftDecoration, keybindModuleRightDecoration)
        decorationClickEffect(keybindValueLeftDecoration, keybindValueRightDecoration)
    end)
    
    KeybindValue.MouseButton1Click:Connect(function()
        KeybindValue.Text = "..."
        Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        })
        keybindDecorationEffects:clickEffect()
        wait()
        local key, uwu = services.UserInputService.InputEnded:Wait()
        local keyName = tostring(key.KeyCode.Name)
        if key.UserInputType ~= Enum.UserInputType.Keyboard then
            KeybindValue.Text = keyTxt
            Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
                BackgroundColor3 = Background
            })
            return
        end
        if banned[keyName] then
            KeybindValue.Text = keyTxt
            Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
                BackgroundColor3 = Background
            })
            return
        end
        wait()
        bindKey = Enum.KeyCode[keyName]
        KeybindValue.Text = shortNames[keyName] or keyName
        Tween(KeybindValue, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background
        })
        
        -- 按键设置成功装饰特效
        keybindDecorationEffects:clickEffect()
        decorationPulseAnimation(keybindValueLeftDecoration, keybindValueRightDecoration)
    end)

    KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
        KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
    end)
    KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
    
    -- 装饰呼吸动画
    spawn(function()
        while KeybindBtn and KeybindBtn.Parent do
            wait(math.random(3, 7))
            decorationPulseAnimation(keybindLeftDecoration, keybindRightDecoration)
            wait(math.random(2, 5))
            decorationPulseAnimation(keybindValueLeftDecoration, keybindValueRightDecoration)
            wait(math.random(1, 4))
            decorationPulseAnimation(keybindModuleLeftDecoration, keybindModuleRightDecoration)
        end
    end)
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
    TextboxModule.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TextboxModule.BackgroundTransparency = 1.000
    TextboxModule.BorderSizePixel = 0
    TextboxModule.Position = UDim2.new(0, 0, 0, 0)
    TextboxModule.Size = UDim2.new(0, 428, 0, 38)
    
    TextboxBack.Name = "TextboxBack"
    TextboxBack.Parent = TextboxModule
    TextboxBack.BackgroundColor3 = zyColor
    TextboxBack.BackgroundTransparency = ALTransparency
    TextboxBack.BorderSizePixel = 0
    TextboxBack.Size = UDim2.new(0, 428, 0, 38)
    TextboxBack.AutoButtonColor = false
    TextboxBack.Font = Enum.Font.GothamSemibold
    TextboxBack.Text = "   " .. text
    TextboxBack.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
    TextboxBack.TextSize = 16.000
    TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
    
    TextboxBackC.CornerRadius = UDim.new(0, 18)
    TextboxBackC.Name = "TextboxBackC"
    TextboxBackC.Parent = TextboxBack
    
    -- 为TextboxBack添加装饰
    local textboxLeftDecoration = createLeftDecoration(TextboxBack)
    local textboxRightDecoration = createRightDecoration(TextboxBack)
    textboxLeftDecoration.Position = UDim2.new(0, -20, 0.5, 0)
    textboxRightDecoration.Position = UDim2.new(1, 20, 0.5, 0)
    textboxLeftDecoration.Size = UDim2.new(0, 40, 0, 45)
    textboxRightDecoration.Size = UDim2.new(0, 35, 0, 32)
    textboxLeftDecoration.ImageTransparency = 0.3
    textboxRightDecoration.ImageTransparency = 0.3
    
    -- 为BoxBG添加装饰
    local boxbgLeftDecoration = createLeftDecoration(BoxBG)
    local boxbgRightDecoration = createRightDecoration(BoxBG)
    boxbgLeftDecoration.Position = UDim2.new(0, -5, 0.5, 0)
    boxbgRightDecoration.Position = UDim2.new(1, 5, 0.5, 0)
    boxbgLeftDecoration.Size = UDim2.new(0, 18, 0, 25)
    boxbgRightDecoration.Size = UDim2.new(0, 16, 0, 22)
    boxbgLeftDecoration.ImageTransparency = 0.5
    boxbgRightDecoration.ImageTransparency = 0.5
    
    -- 为TextboxModule添加装饰
    local textboxModuleLeftDecoration = createLeftDecoration(TextboxModule)
    local textboxModuleRightDecoration = createRightDecoration(TextboxModule)
    textboxModuleLeftDecoration.Position = UDim2.new(0, -15, 0.5, 0)
    textboxModuleRightDecoration.Position = UDim2.new(1, 15, 0.5, 0)
    textboxModuleLeftDecoration.Size = UDim2.new(0, 30, 0, 42)
    textboxModuleRightDecoration.Size = UDim2.new(0, 28, 0, 38)
    textboxModuleLeftDecoration.ImageTransparency = 0.5
    textboxModuleRightDecoration.ImageTransparency = 0.5
    
    -- 初始化装饰动画
    local textboxDecorationEffects = DecorationEffects.new(textboxLeftDecoration, textboxRightDecoration)
    textboxDecorationEffects:startAll()
    initAllDecorationAnimations(boxbgLeftDecoration, boxbgRightDecoration)
    initAllDecorationAnimations(textboxModuleLeftDecoration, textboxModuleRightDecoration)
    
    BoxBG.Name = "BoxBG"
    BoxBG.Parent = TextboxBack
    BoxBG.BackgroundColor3 = Background
    BoxBG.BorderSizePixel = 0
    BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
    BoxBG.Size = UDim2.new(0, 100, 0, 28)
    BoxBG.AutoButtonColor = false
    BoxBG.Font = Enum.Font.Gotham
    BoxBG.Text = ""
    BoxBG.TextColor3 = Color3.fromRGB(255,255,255)
    BoxBG.TextSize = 14.000
    
    BoxBGC.CornerRadius = UDim.new(0, 18)
    BoxBGC.Name = "BoxBGC"
    BoxBGC.Parent = BoxBG
    
    TextBox.Parent = BoxBG
    TextBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
    TextBox.BackgroundTransparency = 1.000
    TextBox.BorderSizePixel = 0
    TextBox.Size = UDim2.new(1, 0, 1, 0)
    TextBox.Font = Enum.Font.Gotham
    TextBox.Text = default
    TextBox.TextColor3 = Color3.fromRGB(255,255,255)
    TextBox.TextSize = 14.000
    
    TextboxBackL.Name = "TextboxBackL"
    TextboxBackL.Parent = TextboxBack
    TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
    TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
    TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center
    
    TextboxBackP.Name = "TextboxBackP"
    TextboxBackP.Parent = TextboxBack
    TextboxBackP.PaddingRight = UDim.new(0, 6)

    -- Textbox悬停动画
    TextboxBack.MouseEnter:Connect(function()
        Tween(TextboxBack, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency - 0.1
        })
        textboxDecorationEffects:hoverEffect(true)
        decorationHoverEffect(textboxModuleLeftDecoration, textboxModuleRightDecoration, true)
        decorationHoverEffect(boxbgLeftDecoration, boxbgRightDecoration, true)
    end)
    
    TextboxBack.MouseLeave:Connect(function()
        Tween(TextboxBack, {0.2, 'Quad', 'Out'}, {
            BackgroundTransparency = ALTransparency
        })
        textboxDecorationEffects:hoverEffect(false)
        decorationHoverEffect(textboxModuleLeftDecoration, textboxModuleRightDecoration, false)
        decorationHoverEffect(boxbgLeftDecoration, boxbgRightDecoration, false)
    end)
    
    -- BoxBG悬停动画
    BoxBG.MouseEnter:Connect(function()
        Tween(BoxBG, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Color3.fromRGB(204,255,0)
        })
        decorationHoverEffect(boxbgLeftDecoration, boxbgRightDecoration, true)
    end)
    
    BoxBG.MouseLeave:Connect(function()
        Tween(BoxBG, {0.2, 'Quad', 'Out'}, {
            BackgroundColor3 = Background
        })
        decorationHoverEffect(boxbgLeftDecoration, boxbgRightDecoration, false)
    end)
    
    -- 装饰图片悬停
    textboxLeftDecoration.MouseEnter:Connect(function()
        textboxDecorationEffects:hoverEffect(true)
        decorationHoverEffect(textboxModuleLeftDecoration, textboxModuleRightDecoration, true)
    end)
    
    textboxLeftDecoration.MouseLeave:Connect(function()
        textboxDecorationEffects:hoverEffect(false)
        decorationHoverEffect(textboxModuleLeftDecoration, textboxModuleRightDecoration, false)
    end)
                textboxRightDecoration.MouseEnter:Connect(function()
                textboxDecorationEffects:hoverEffect(true)
                decorationHoverEffect(textboxModuleLeftDecoration, textboxModuleRightDecoration, true)
            end)
            
            textboxRightDecoration.MouseLeave:Connect(function()
                textboxDecorationEffects:hoverEffect(false)
                decorationHoverEffect(textboxModuleLeftDecoration, textboxModuleRightDecoration, false)
            end)
            
            -- 装饰图片点击
            textboxLeftDecoration.MouseButton1Click:Connect(function()
                TextBox:CaptureFocus()
                textboxDecorationEffects:clickEffect()
                decorationClickEffect(textboxModuleLeftDecoration, textboxModuleRightDecoration)
            end)
            
            textboxRightDecoration.MouseButton1Click:Connect(function()
                TextBox:CaptureFocus()
                textboxDecorationEffects:clickEffect()
                decorationClickEffect(textboxModuleLeftDecoration, textboxModuleRightDecoration)
            end)

            TextBox.FocusLost:Connect(function()
                if TextBox.Text == "" then
                    TextBox.Text = default
                end
                library.flags[flag] = TextBox.Text
                callback(TextBox.Text)
                
                -- 文本输入完成装饰特效
                textboxDecorationEffects:clickEffect()
                decorationPulseAnimation(boxbgLeftDecoration, boxbgRightDecoration)
            end)

            TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
                BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
            end)
            BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
            
            -- 装饰呼吸动画
            spawn(function()
                while TextboxBack and TextboxBack.Parent do
                    wait(math.random(3, 6))
                    decorationPulseAnimation(textboxLeftDecoration, textboxRightDecoration)
                    wait(math.random(2, 5))
                    decorationPulseAnimation(boxbgLeftDecoration, boxbgRightDecoration)
                    wait(math.random(1, 4))
                    decorationPulseAnimation(textboxModuleLeftDecoration, textboxModuleRightDecoration)
                end
            end)
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
            SliderModule.BackgroundColor3 = Color3.fromRGB(255,255,255)
            SliderModule.BackgroundTransparency = 1.000
            SliderModule.BorderSizePixel = 0
            SliderModule.Position = UDim2.new(0, 0, 0, 0)
            SliderModule.Size = UDim2.new(0, 428, 0, 38)
            
            SliderBack.Name = "SliderBack"
            SliderBack.Parent = SliderModule
            SliderBack.BackgroundColor3 = zyColor
            SliderBack.BackgroundTransparency = ALTransparency
            SliderBack.BorderSizePixel = 0
            SliderBack.Size = UDim2.new(0, 428, 0, 38)
            SliderBack.AutoButtonColor = false
            SliderBack.Font = Enum.Font.GothamSemibold
            SliderBack.Text = "   " .. text
            SliderBack.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
            SliderBack.TextSize = 16.000
            SliderBack.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderBackC.CornerRadius = UDim.new(0, 18)
            SliderBackC.Name = "SliderBackC"
            SliderBackC.Parent = SliderBack
            
            -- 为SliderBack添加装饰
            local sliderLeftDecoration = createLeftDecoration(SliderBack)
            local sliderRightDecoration = createRightDecoration(SliderBack)
            sliderLeftDecoration.Position = UDim2.new(0, -20, 0.5, 0)
            sliderRightDecoration.Position = UDim2.new(1, 20, 0.5, 0)
            sliderLeftDecoration.Size = UDim2.new(0, 40, 0, 45)
            sliderRightDecoration.Size = UDim2.new(0, 35, 0, 32)
            sliderLeftDecoration.ImageTransparency = 0.3
            sliderRightDecoration.ImageTransparency = 0.3
            
            -- 为SliderBar添加装饰
            local sliderBarLeftDecoration = createLeftDecoration(SliderBar)
            local sliderBarRightDecoration = createRightDecoration(SliderBar)
            sliderBarLeftDecoration.Position = UDim2.new(0, -3, 0.5, 0)
            sliderBarRightDecoration.Position = UDim2.new(1, 3, 0.5, 0)
            sliderBarLeftDecoration.Size = UDim2.new(0, 10, 0, 15)
            sliderBarRightDecoration.Size = UDim2.new(0, 9, 0, 13)
            sliderBarLeftDecoration.ImageTransparency = 0.6
            sliderBarRightDecoration.ImageTransparency = 0.6
            
            -- 为SliderPart添加装饰
            local sliderPartLeftDecoration = createLeftDecoration(SliderPart)
            local sliderPartRightDecoration = createRightDecoration(SliderPart)
            sliderPartLeftDecoration.Position = UDim2.new(0, -2, 0.5, 0)
            sliderPartRightDecoration.Position = UDim2.new(1, 2, 0.5, 0)
            sliderPartLeftDecoration.Size = UDim2.new(0, 8, 0, 16)
            sliderPartRightDecoration.Size = UDim2.new(0, 7, 0, 14)
            sliderPartLeftDecoration.ImageTransparency = 0.7
            sliderPartRightDecoration.ImageTransparency = 0.7
            
            -- 为SliderValBG添加装饰
            local sliderValLeftDecoration = createLeftDecoration(SliderValBG)
            local sliderValRightDecoration = createRightDecoration(SliderValBG)
            sliderValLeftDecoration.Position = UDim2.new(0, -4, 0.5, 0)
            sliderValRightDecoration.Position = UDim2.new(1, 4, 0.5, 0)
            sliderValLeftDecoration.Size = UDim2.new(0, 12, 0, 32)
            sliderValRightDecoration.Size = UDim2.new(0, 11, 0, 30)
            sliderValLeftDecoration.ImageTransparency = 0.5
            sliderValRightDecoration.ImageTransparency = 0.5
            
            -- 为MinSlider和AddSlider添加装饰
            local minSliderLeftDecoration = createLeftDecoration(MinSlider)
            local minSliderRightDecoration = createRightDecoration(MinSlider)
            minSliderLeftDecoration.Position = UDim2.new(0, -5, 0.5, 0)
            minSliderRightDecoration.Position = UDim2.new(1, 5, 0.5, 0)
            minSliderLeftDecoration.Size = UDim2.new(0, 10, 0, 22)
            minSliderRightDecoration.Size = UDim2.new(0, 9, 0, 20)
            minSliderLeftDecoration.ImageTransparency = 0.6
            minSliderRightDecoration.ImageTransparency = 0.6
            
            local addSliderLeftDecoration = createLeftDecoration(AddSlider)
            local addSliderRightDecoration = createRightDecoration(AddSlider)
            addSliderLeftDecoration.Position = UDim2.new(0, -5, 0.5, 0)
            addSliderRightDecoration.Position = UDim2.new(1, 5, 0.5, 0)
            addSliderLeftDecoration.Size = UDim2.new(0, 10, 0, 22)
            addSliderRightDecoration.Size = UDim2.new(0, 9, 0, 20)
            addSliderLeftDecoration.ImageTransparency = 0.6
            addSliderRightDecoration.ImageTransparency = 0.6
            
            -- 为SliderModule添加装饰
            local sliderModuleLeftDecoration = createLeftDecoration(SliderModule)
            local sliderModuleRightDecoration = createRightDecoration(SliderModule)
            sliderModuleLeftDecoration.Position = UDim2.new(0, -15, 0.5, 0)
            sliderModuleRightDecoration.Position = UDim2.new(1, 15, 0.5, 0)
            sliderModuleLeftDecoration.Size = UDim2.new(0, 30, 0, 42)
            sliderModuleRightDecoration.Size = UDim2.new(0, 28, 0, 38)
            sliderModuleLeftDecoration.ImageTransparency = 0.5
            sliderModuleRightDecoration.ImageTransparency = 0.5
            
            -- 初始化装饰动画
            local sliderDecorationEffects = DecorationEffects.new(sliderLeftDecoration, sliderRightDecoration)
            sliderDecorationEffects:startAll()
            initAllDecorationAnimations(sliderBarLeftDecoration, sliderBarRightDecoration)
            initAllDecorationAnimations(sliderPartLeftDecoration, sliderPartRightDecoration)
            initAllDecorationAnimations(sliderValLeftDecoration, sliderValRightDecoration)
            initAllDecorationAnimations(minSliderLeftDecoration, minSliderRightDecoration)
            initAllDecorationAnimations(addSliderLeftDecoration, addSliderRightDecoration)
            initAllDecorationAnimations(sliderModuleLeftDecoration, sliderModuleRightDecoration)
            
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
            SliderPart.BackgroundColor3 = Color3.fromRGB(255,255,255)
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
            SliderValBG.TextColor3 = Color3.fromRGB(255,255,255)
            SliderValBG.TextSize = 14.000
            
            SliderValBGC.CornerRadius = UDim.new(0, 18)
            SliderValBGC.Name = "SliderValBGC"
            SliderValBGC.Parent = SliderValBG
            
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderValBG
            SliderValue.BackgroundColor3 = Color3.fromRGB(255,255,255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.BorderSizePixel = 0
            SliderValue.Size = UDim2.new(1, 0, 1, 0)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = "1000"
            SliderValue.TextColor3 = Color3.fromRGB(255,255,255)
            SliderValue.TextSize = 14.000
            
            MinSlider.Name = "MinSlider"
            MinSlider.Parent = SliderModule
            MinSlider.BackgroundColor3 = Color3.fromRGB(255,255,255)
            MinSlider.BackgroundTransparency = 1.000
            MinSlider.BorderSizePixel = 0
            MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
            MinSlider.Size = UDim2.new(0, 20, 0, 20)
            MinSlider.Font = Enum.Font.Gotham
            MinSlider.Text = "-"
            MinSlider.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
            MinSlider.TextSize = 24.000
            MinSlider.TextWrapped = true
            
            AddSlider.Name = "AddSlider"
            AddSlider.Parent = SliderModule
            AddSlider.AnchorPoint = Vector2.new(0, 0.5)
            AddSlider.BackgroundColor3 = Color3.fromRGB(255,255,255)
            AddSlider.BackgroundTransparency = 1.000
            AddSlider.BorderSizePixel = 0
            AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
            AddSlider.Size = UDim2.new(0, 20, 0, 20)
            AddSlider.Font = Enum.Font.Gotham
            AddSlider.Text = "+"
            AddSlider.TextColor3 = FunctionFontColor  -- 使用功能页面字体颜色（粉红色）
            AddSlider.TextSize = 24.000
            AddSlider.TextWrapped = true
            
            -- 为SliderValue添加装饰
            local sliderValueLeftDecoration = createLeftDecoration(SliderValue)
            local sliderValueRightDecoration = createRightDecoration(SliderValue)
            sliderValueLeftDecoration.Position = UDim2.new(0, -3, 0.5, 0)
            sliderValueRightDecoration.Position = UDim2.new(1, 3, 0.5, 0)
            sliderValueLeftDecoration.Size = UDim2.new(0, 8, 0, 24)
            sliderValueRightDecoration.Size = UDim2.new(0, 7, 0, 22)
            sliderValueLeftDecoration.ImageTransparency = 0.7
            sliderValueRightDecoration.ImageTransparency = 0.7
            initAllDecorationAnimations(sliderValueLeftDecoration, sliderValueRightDecoration)
            
            -- 装饰交互
            sliderLeftDecoration.MouseEnter:Connect(function()
                sliderDecorationEffects:hoverEffect(true)
                decorationHoverEffect(sliderModuleLeftDecoration, sliderModuleRightDecoration, true)
            end)
            
            sliderLeftDecoration.MouseLeave:Connect(function()
                sliderDecorationEffects:hoverEffect(false)
                decorationHoverEffect(sliderModuleLeftDecoration, sliderModuleRightDecoration, false)
            end)
            
            sliderRightDecoration.MouseEnter:Connect(function()
                sliderDecorationEffects:hoverEffect(true)
                decorationHoverEffect(sliderModuleLeftDecoration, sliderModuleRightDecoration, true)
            end)
            
            sliderRightDecoration.MouseLeave:Connect(function()
                sliderDecorationEffects:hoverEffect(false)
                decorationHoverEffect(sliderModuleLeftDecoration, sliderModuleRightDecoration, false)
            end)
            
            -- 装饰点击
            sliderLeftDecoration.MouseButton1Click:Connect(function()
                sliderDecorationEffects:clickEffect()
                decorationClickEffect(sliderModuleLeftDecoration, sliderModuleRightDecoration)
            end)
            
            sliderRightDecoration.MouseButton1Click:Connect(function()
                sliderDecorationEffects:clickEffect()
                decorationClickEffect(sliderModuleLeftDecoration, sliderModuleRightDecoration)
            end)
            
            -- 装饰呼吸动画
            spawn(function()
                while SliderBack and SliderBack.Parent do
                    wait(math.random(2, 5))
                    decorationPulseAnimation(sliderLeftDecoration, sliderRightDecoration)
                    wait(math.random(1, 3))
                    decorationPulseAnimation(sliderBarLeftDecoration, sliderBarRightDecoration)
                    wait(math.random(1, 3))
                    decorationPulseAnimation(sliderPartLeftDecoration, sliderPartRightDecoration)
                    wait(math.random(1, 3))
                    decorationPulseAnimation(sliderValLeftDecoration, sliderValRightDecoration)
                    wait(math.random(1, 3))
                    decorationPulseAnimation(sliderValueLeftDecoration, sliderValueRightDecoration)
                    wait(math.random(1, 3))
                    decorationPulseAnimation(minSliderLeftDecoration, minSliderRightDecoration)
                    wait(math.random(1, 3))
                    decorationPulseAnimation(addSliderLeftDecoration, addSliderRightDecoration)
                end
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
                Tween(SliderPart, {0.2, 'Quad', 'Out'}, {
                    Size = UDim2.new(percent, 0, 1, 0)
                })
                callback(tonumber(value))
                
                -- 滑块值变化装饰特效
                local intensity = percent * 0.5
                Tween(sliderPartLeftDecoration, {0.2, 'Quad', 'Out'}, {
                    ImageTransparency = 0.7 - intensity
                })
                Tween(sliderPartRightDecoration, {0.2, 'Quad', 'Out'}, {
                    ImageTransparency = 0.7 - intensity
                })
                
                -- 颜色变化
                local hue = percent * 120
                Tween(sliderPartLeftDecoration, {0.3, 'Quad', 'Out'}, {
                    ImageColor3 = Color3.fromHSV(hue/360, 0.8, 1)
                })
                Tween(sliderPartRightDecoration, {0.3, 'Quad', 'Out'}, {
                    ImageColor3 = Color3.fromHSV(hue/360, 0.8, 1)
                })
              end
            }

            MinSlider.MouseButton1Click:Connect(function()
              local currentValue = library.flags[flag]
              currentValue = math.clamp(currentValue - 1, min, max)
              funcs:SetValue(currentValue)
              decorationClickEffect(minSliderLeftDecoration, minSliderRightDecoration)
              sliderDecorationEffects:clickEffect()
            end)

            AddSlider.MouseButton1Click:Connect(function()
              local currentValue = library.flags[flag]
              currentValue = math.clamp(currentValue + 1, min, max)
              funcs:SetValue(currentValue)
              decorationClickEffect(addSliderLeftDecoration, addSliderRightDecoration)
              sliderDecorationEffects:clickEffect()
            end)
            
            funcs:SetValue(default)

            local dragging, boxFocused, allowed = false, false, {
              [""] = true,
              ["-"] = true
            }

            SliderBar.InputBegan:Connect(function(input)
              if input.UserInputType == Enum.UserInputType.MouseButton1 then
                funcs:SetValue()
                dragging = true
                decorationClickEffect(sliderBarLeftDecoration, sliderBarRightDecoration)
              end
            end)

            services.UserInputService.InputEnded:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
              end
            end)

            services.UserInputService.InputChanged:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                funcs:SetValue()
              end
            end)

            SliderBar.InputBegan:Connect(function(input)
              if input.UserInputType == Enum.UserInputType.Touch then
                funcs:SetValue()
                dragging = true
              end
            end)

            services.UserInputService.InputEnded:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
              end
            end)

            services.UserInputService.InputChanged:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.Touch then
                funcs:SetValue()
              end
            end)

            SliderValue.Focused:Connect(function()
              boxFocused = true
              decorationClickEffect(sliderValueLeftDecoration, sliderValueRightDecoration)
            end)

            SliderValue.FocusLost:Connect(function()
              boxFocused = false
              if SliderValue.Text == "" then
                funcs:SetValue(default)
              end
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
          
          return section
        end
        return tab
      end
      return window
    end
    
-- 全局装饰系统初始化
local GlobalDecorationSystem = {}
GlobalDecorationSystem.__index = GlobalDecorationSystem

function GlobalDecorationSystem.new()
    local self = setmetatable({}, GlobalDecorationSystem)
    self.allDecorations = {}
    self.updateInterval = 5
    self.isActive = true
    return self
end

function GlobalDecorationSystem:registerDecoration(left, right, parent)
    local decoration = {
        left = left,
        right = right,
        parent = parent,
        effects = DecorationEffects.new(left, right)
    }
    table.insert(self.allDecorations, decoration)
    decoration.effects:startAll()
    return decoration
end

function GlobalDecorationSystem:unregisterDecoration(parent)
    for i = #self.allDecorations, 1, -1 do
        local decoration = self.allDecorations[i]
        if decoration.parent == parent then
            decoration.effects:stopAll()
            table.remove(self.allDecorations, i)
        end
    end
end

function GlobalDecorationSystem:updateAll()
    for _, decoration in ipairs(self.allDecorations) do
        if decoration and decoration.effects then
            decoration.effects:pulseEffect()
        end
    end
end

function GlobalDecorationSystem:startGlobalUpdate()
    spawn(function()
        while self.isActive do
            wait(self.updateInterval)
            self:updateAll()
        end
    end)
end

function GlobalDecorationSystem:stop()
    self.isActive = false
    for _, decoration in ipairs(self.allDecorations) do
        decoration.effects:stopAll()
    end
end

-- 创建全局装饰系统
local globalDecorations = GlobalDecorationSystem.new()
globalDecorations:startGlobalUpdate()

-- 装饰系统UI
local decorationUI = Instance.new("ScreenGui", services.CoreGui)
decorationUI.Name = "DecorationSystemUI"
decorationUI.DisplayOrder = 999

local decorationStats = Instance.new("TextLabel", decorationUI)
decorationStats.Name = "DecorationStats"
decorationStats.Size = UDim2.new(0, 200, 0, 50)
decorationStats.Position = UDim2.new(1, -210, 0, 10)
decorationStats.BackgroundTransparency = 0.7
decorationStats.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
decorationStats.TextColor3 = Color3.fromRGB(255, 255, 255)
decorationStats.Text = "装饰系统: 运行中"
decorationStats.Visible = false

-- 装饰系统统计更新
spawn(function()
    while decorationStats and decorationStats.Parent do
        wait(2)
        decorationStats.Text = string.format("装饰系统: %d个装饰", #globalDecorations.allDecorations)
    end
end)

-- 装饰系统控制
services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F9 then
        decorationStats.Visible = not decorationStats.Visible
    elseif input.KeyCode == Enum.KeyCode.F10 then
        globalDecorations:updateAll()
    end
end)

-- 装饰系统性能优化
spawn(function()
    while true do
        wait(30)
        local currentTime = tick()
        for i = #globalDecorations.allDecorations, 1, -1 do
            local decoration = globalDecorations.allDecorations[i]
            if not decoration.parent or not decoration.parent.Parent then
                table.remove(globalDecorations.allDecorations, i)
            end
        end
    end
end)

return library