-- 创建主界面
local ui = Instance.new("ScreenGui")
ui.Name = "XG_Premium"
ui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ui.ResetOnSpawn = false

-- 背景遮罩
local background = Instance.new("Frame")
background.Name = "BackgroundOverlay"
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.7
background.Parent = ui

-- 主容器（修改 Position 实现完全居中 + 调整缩放相关参数）
local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(0, 0, 0, 380 * 0.7) -- 初始高度缩放 0.7 倍
mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
mainContainer.BackgroundTransparency = 1
mainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
mainContainer.Parent = ui

-- 左侧文字面板
local leftPanel = Instance.new("Frame")
leftPanel.Name = "TextPanel"
leftPanel.Size = UDim2.new(0.5, 0, 1, 0)
leftPanel.Position = UDim2.new(0, 0, 0, 0)
leftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
leftPanel.Parent = mainContainer

local leftCorner = Instance.new("UICorner")
leftCorner.CornerRadius = UDim.new(0, 12 * 0.7) -- 圆角缩放 0.7 倍
leftCorner.Parent = leftPanel

local leftStroke = Instance.new("UIStroke")
leftStroke.Color = Color3.fromRGB(60, 60, 60)
leftStroke.Thickness = 2 * 0.7 -- 描边粗细缩放 0.7 倍
leftStroke.Parent = leftPanel

-- 右侧图片面板
local rightPanel = Instance.new("Frame")
rightPanel.Name = "ImagePanel"
rightPanel.Size = UDim2.new(0.5, 0, 1, 0)
rightPanel.Position = UDim2.new(0.5, 0, 0, 0)
rightPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
rightPanel.Parent = mainContainer

local rightCorner = Instance.new("UICorner")
rightCorner.CornerRadius = UDim.new(0, 12 * 0.7) -- 圆角缩放 0.7 倍
rightCorner.Parent = rightPanel

local rightStroke = Instance.new("UIStroke")
rightStroke.Color = Color3.fromRGB(80, 80, 80)
rightStroke.Thickness = 2 * 0.7 -- 描边粗细缩放 0.7 倍
rightStroke.Parent = rightPanel

-- 左侧内容容器
local leftContent = Instance.new("Frame")
leftContent.Size = UDim2.new(1, -40 * 0.7, 1, -40 * 0.7) -- 内边距缩放 0.7 倍
leftContent.Position = UDim2.new(0, 20 * 0.7, 0, 20 * 0.7) -- 内边距缩放 0.7 倍
leftContent.BackgroundTransparency = 1
leftContent.Parent = leftPanel

-- 装饰元素
local decorLine = Instance.new("Frame")
decorLine.Size = UDim2.new(0, 3 * 0.7, 0.7, 0) -- 装饰线宽度缩放 0.7 倍
decorLine.Position = UDim2.new(0, 15 * 0.7, 0.15, 0) -- 装饰线位置缩放 0.7 倍
decorLine.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
decorLine.BorderSizePixel = 0
decorLine.Parent = leftContent

local decorCorner = Instance.new("UICorner")
decorCorner.CornerRadius = UDim.new(0, 1 * 0.7) -- 装饰线圆角缩放 0.7 倍
decorCorner.Parent = decorLine

-- 标题
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30 * 0.7, 0, 70 * 0.7) -- 标题区域缩放 0.7 倍
title.Position = UDim2.new(0, 25 * 0.7, 0, 10 * 0.7) -- 标题位置缩放 0.7 倍
title.Text = "小光已退圈\n脚本能正常使用"
title.TextSize = 22 * 0.7 -- 文字大小缩放 0.7 倍
title.Font = Enum.Font.GothamSemibold
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.BackgroundTransparency = 1
title.TextWrapped = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = leftContent

-- 分隔线
local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, -50 * 0.7, 0, 1 * 0.7) -- 分隔线尺寸缩放 0.7 倍
separator.Position = UDim2.new(0, 25 * 0.7, 0, 85 * 0.7) -- 分隔线位置缩放 0.7 倍
separator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
separator.BorderSizePixel = 0
separator.Parent = leftContent

-- 第一段文字
local thanks1 = Instance.new("TextLabel")
thanks1.Size = UDim2.new(1, -30 * 0.7, 0, 80 * 0.7) -- 文本区域缩放 0.7 倍
thanks1.Position = UDim2.new(0, 25 * 0.7, 0, 95 * 0.7) -- 文本位置缩放 0.7 倍
thanks1.Text = "感谢一路以来支持我的人。\n特别感谢：XTTT、情绪、synb、465、月亮猫\n你们的支持陪伴我度过这一年。"
thanks1.TextSize = 16 * 0.7 -- 文字大小缩放 0.7 倍
thanks1.Font = Enum.Font.Gotham
thanks1.TextColor3 = Color3.fromRGB(180, 180, 180)
thanks1.BackgroundTransparency = 1
thanks1.TextWrapped = true
thanks1.TextXAlignment = Enum.TextXAlignment.Left
thanks1.Parent = leftContent

-- 第二段文字
local thanks2 = Instance.new("TextLabel")
thanks2.Size = UDim2.new(1, -30 * 0.7, 0, 50 * 0.7) -- 文本区域缩放 0.7 倍
thanks2.Position = UDim2.new(0, 25 * 0.7, 0, 185 * 0.7) -- 文本位置缩放 0.7 倍
thanks2.Text = "感谢我的师傅：退休不退休、孙笑川"
thanks2.TextSize = 17 * 0.7 -- 文字大小缩放 0.7 倍
thanks2.Font = Enum.Font.GothamMedium
thanks2.TextColor3 = Color3.fromRGB(200, 200, 200)
thanks2.BackgroundTransparency = 1
thanks2.TextXAlignment = Enum.TextXAlignment.Left
thanks2.Parent = leftContent

-- 右侧图片显示
local imageContainer = Instance.new("Frame")
imageContainer.Size = UDim2.new(1, -20 * 0.7, 1, -20 * 0.7) -- 图片容器内边距缩放 0.7 倍
imageContainer.Position = UDim2.new(0, 10 * 0.7, 0, 10 * 0.7) -- 图片容器位置缩放 0.7 倍
imageContainer.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
imageContainer.Parent = rightPanel

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 8 * 0.7) -- 图片容器圆角缩放 0.7 倍
imageCorner.Parent = imageContainer

-- 图片（已替换为你指定的ID：79285958044576）
local displayImage = Instance.new("ImageLabel")
displayImage.Size = UDim2.new(1, -20 * 0.7, 1, -20 * 0.7) -- 图片尺寸缩放 0.7 倍
displayImage.Position = UDim2.new(0, 10 * 0.7, 0, 10 * 0.7) -- 图片位置缩放 0.7 倍
displayImage.BackgroundTransparency = 1
displayImage.Image = "rbxassetid://79285958044576" -- 你提供的猫咪图片ID
displayImage.ScaleType = Enum.ScaleType.Fit -- 适配显示，避免裁剪异常
displayImage.Parent = imageContainer

local imageStroke = Instance.new("UIStroke")
imageStroke.Color = Color3.fromRGB(40, 40, 40)
imageStroke.Thickness = 1 * 0.7 -- 图片描边粗细缩放 0.7 倍
imageStroke.Parent = displayImage

-- 图片装饰边框
local imageBorder = Instance.new("Frame")
imageBorder.Size = UDim2.new(1, 10 * 0.7, 1, 10 * 0.7) -- 装饰边框尺寸缩放 0.7 倍
imageBorder.Position = UDim2.new(0, -5 * 0.7, 0, -5 * 0.7) -- 装饰边框位置缩放 0.7 倍
imageBorder.BackgroundTransparency = 1
imageBorder.Parent = displayImage

local borderStroke = Instance.new("UIStroke")
borderStroke.Color = Color3.fromRGB(100, 100, 100)
borderStroke.Thickness = 2 * 0.7 -- 装饰边框描边缩放 0.7 倍
borderStroke.Parent = imageBorder

-- 图片标题
local imageTitle = Instance.new("TextLabel")
imageTitle.Size = UDim2.new(1, 0, 0, 30 * 0.7) -- 图片标题区域缩放 0.7 倍
imageTitle.Position = UDim2.new(0, 0, 1, -40 * 0.7) -- 图片标题位置缩放 0.7 倍
imageTitle.Text = "神秘的猫"
imageTitle.TextSize = 14 * 0.7 -- 图片标题文字大小缩放 0.7 倍
imageTitle.Font = Enum.Font.Gotham
imageTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
imageTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
imageTitle.BackgroundTransparency = 0.7
imageTitle.TextXAlignment = Enum.TextXAlignment.Center
imageTitle.Parent = imageContainer

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 6 * 0.7) -- 图片标题圆角缩放 0.7 倍
titleCorner.Parent = imageTitle

-- 确认按钮
local confirmBtn = Instance.new("TextButton")
confirmBtn.Name = "ConfirmButton"
confirmBtn.Size = UDim2.new(0.7, 0, 0, 45 * 0.7) -- 按钮高度缩放 0.7 倍
confirmBtn.Position = UDim2.new(0.15, 0, 0, 290 * 0.7) -- 按钮位置缩放 0.7 倍
confirmBtn.Text = "确认启动脚本"
confirmBtn.TextSize = 18 * 0.7 -- 按钮文字大小缩放 0.7 倍
confirmBtn.Font = Enum.Font.GothamSemibold
confirmBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
confirmBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
confirmBtn.AutoButtonColor = false
confirmBtn.Parent = leftContent

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8 * 0.7) -- 按钮圆角缩放 0.7 倍
btnCorner.Parent = confirmBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(70, 70, 70)
btnStroke.Thickness = 1 * 0.7 -- 按钮描边缩放 0.7 倍
btnStroke.Parent = confirmBtn

-- 按钮图标
local btnIcon = Instance.new("ImageLabel")
btnIcon.Size = UDim2.new(0, 20 * 0.7, 0, 20 * 0.7) -- 图标尺寸缩放 0.7 倍
btnIcon.Position = UDim2.new(0, 15 * 0.7, 0.5, -10 * 0.7) -- 图标位置缩放 0.7 倍
btnIcon.BackgroundTransparency = 1
btnIcon.Image = "rbxassetid://6031091005" -- 播放图标
btnIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
btnIcon.Parent = confirmBtn

-- 按钮文字
local btnText = Instance.new("TextLabel")
btnText.Size = UDim2.new(1, -40 * 0.7, 1, 0) -- 按钮文字区域缩放 0.7 倍
btnText.Position = UDim2.new(0, 40 * 0.7, 0, 0) -- 按钮文字位置缩放 0.7 倍
btnText.Text = "确认启动"
btnText.TextSize = 18 * 0.7 -- 按钮文字大小缩放 0.7 倍
btnText.Font = Enum.Font.GothamSemibold
btnText.TextColor3 = Color3.fromRGB(230, 230, 230)
btnText.BackgroundTransparency = 1
btnText.TextXAlignment = Enum.TextXAlignment.Left
btnText.Parent = confirmBtn

-- 渐变系统
local colorOffset = 0
local activeGradient = true
local function updateGradients()
    while activeGradient do
        colorOffset = (colorOffset + 0.005) % 1
        
        -- 装饰线条渐变
        local hue = colorOffset
        decorLine.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 1)
        
        -- 按钮边框渐变
        local btnHue = (colorOffset + 0.5) % 1
        btnStroke.Color = Color3.fromHSV(btnHue, 0.6, 0.8)
        
        -- 右侧面板边框
        rightStroke.Color = Color3.fromHSV((colorOffset + 0.3) % 1, 0.4, 0.7)
        
        task.wait(0.05)
    end
end

-- 按钮交互效果
confirmBtn.MouseEnter:Connect(function()
    game.TweenService:Create(confirmBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Size = UDim2.new(0.72, 0, 0, 48 * 0.7) -- 按钮 hover 尺寸缩放 0.7 倍
    }):Play()
    
    game.TweenService:Create(btnIcon, TweenInfo.new(0.2), {
        ImageColor3 = Color3.fromRGB(0, 200, 255)
    }):Play()
    
    confirmBtn.Text = ""
    btnText.Text = "准备启动..."
end)

confirmBtn.MouseLeave:Connect(function()
    game.TweenService:Create(confirmBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Size = UDim2.new(0.7, 0, 0, 45 * 0.7) -- 按钮默认尺寸缩放 0.7 倍
    }):Play()
    
    game.TweenService:Create(btnIcon, TweenInfo.new(0.2), {
        ImageColor3 = Color3.fromRGB(200, 200, 200)
    }):Play()
    
    confirmBtn.Text = ""
    btnText.Text = "确认启动"
end)

-- 展开动画
local openingSequence = game.TweenService:Create(mainContainer, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 900 * 0.7, 0, 380 * 0.7) -- 最终展开尺寸缩放 0.7 倍
})

local leftFadeIn = game.TweenService:Create(leftPanel, TweenInfo.new(0.5), {
    BackgroundTransparency = 0
})

local rightFadeIn = game.TweenService:Create(rightPanel, TweenInfo.new(0.5), {
    BackgroundTransparency = 0
})

-- 图片加载效果
task.spawn(function()
    displayImage.ImageTransparency = 1
    openingSequence:Play()
    openingSequence.Completed:Wait()
    
    leftFadeIn:Play()
    rightFadeIn:Play()
    
    -- 左侧文字淡入
    for _, element in pairs({title, separator, thanks1, thanks2, confirmBtn}) do
        if element:IsA("TextLabel") or element:IsA("TextButton") then
            element.TextTransparency = 1
            element.Visible = true
            
            game.TweenService:Create(element, TweenInfo.new(0.4), {
                TextTransparency = 0
            }):Play()
        else
            element.BackgroundTransparency = 1
            element.Visible = true
            
            game.TweenService:Create(element, TweenInfo.new(0.4), {
                BackgroundTransparency = 0
            }):Play()
        end
    end
    
    -- 装饰线条
    decorLine.Size = UDim2.new(0, 0, 0.7, 0)
    game.TweenService:Create(decorLine, TweenInfo.new(0.6), {
        Size = UDim2.new(0, 3 * 0.7, 0.7, 0) -- 装饰线最终尺寸缩放 0.7 倍
    }):Play()
    
    -- 图片淡入
    task.wait(0.3)
    game.TweenService:Create(displayImage, TweenInfo.new(0.8), {
        ImageTransparency = 0
    }):Play()
    
    -- 启动渐变系统
    activeGradient = true
    updateGradients()
end)

-- 确认功能（点击后立即关闭UI并执行远程脚本）
confirmBtn.MouseButton1Click:Connect(function()
    activeGradient = false
    
    -- 立即关闭UI（无动画）
    ui:Destroy()
    
    -- 执行远程脚本
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/XG_SYNB.txt"))()
end)

-- 关闭功能
local userInput = game:GetService("UserInputService")

local function closeInterface()
    activeGradient = false
    
    local fadeOut = game.TweenService:Create(mainContainer, TweenInfo.new(0.4), {
        BackgroundTransparency = 1
    })
    
    local bgFade = game.TweenService:Create(background, TweenInfo.new(0.4), {
        BackgroundTransparency = 1
    })
    
    for _, element in pairs(leftContent:GetChildren()) do
        if element:IsA("TextLabel") or element:IsA("TextButton") then
            game.TweenService:Create(element, TweenInfo.new(0.2), {
                TextTransparency = 1
            }):Play()
        end
    end
    
    fadeOut:Play()
    bgFade:Play()
    task.wait(0.4)
    ui:Destroy()
end

-- ESC键关闭
userInput.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Escape then
        closeInterface()
    end
end)

-- 点击背景关闭
background.MouseButton1Click:Connect(function()
    closeInterface()
end)

-- 防卡死保护
task.spawn(function()
    task.wait(10)
    if ui.Parent then
        -- 自动关闭保护
        closeInterface()
    end
end)