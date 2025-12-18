local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomMessageGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 0, 0, 350)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, -30)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BackgroundTransparency = 0.1
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
})
uiGradient.Rotation = 90
uiGradient.Parent = mainFrame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

local shadowFrame = Instance.new("Frame")
shadowFrame.Name = "ShadowFrame"
shadowFrame.Size = UDim2.new(1, 10, 1, 10)
shadowFrame.Position = UDim2.new(0, -5, 0, -5)
shadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadowFrame.BackgroundTransparency = 0.7
shadowFrame.ZIndex = 0
shadowFrame.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 20)
shadowCorner.Parent = shadowFrame

local separator = Instance.new("Frame")
separator.Name = "Separator"
separator.Size = UDim2.new(0, 2, 0.7, 0)
separator.Position = UDim2.new(0.5, -1, 0.1, 0)
separator.AnchorPoint = Vector2.new(0.5, 0)
separator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
separator.BackgroundTransparency = 0.3
separator.BorderSizePixel = 0
separator.ZIndex = 2
separator.Parent = mainFrame

local leftFrame = Instance.new("Frame")
leftFrame.Name = "LeftFrame"
leftFrame.Size = UDim2.new(0.5, -5, 0.7, 0)
leftFrame.Position = UDim2.new(0, 10, 0.1, 0)
leftFrame.BackgroundTransparency = 1
leftFrame.ZIndex = 2
leftFrame.Parent = mainFrame

local textContainer = Instance.new("Frame")
textContainer.Name = "TextContainer"
textContainer.Size = UDim2.new(1, 0, 1, 0)
textContainer.BackgroundTransparency = 1
textContainer.Parent = leftFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
uiListLayout.Padding = UDim.new(0, 15)
uiListLayout.Parent = textContainer

local function createTextLabel(text, color, parent)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextSize = 24
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 2

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = label

    label.Parent = parent
    return label
end

local function createRainbowText(text, parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 2
    frame.Parent = parent
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 24
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.ZIndex = 2
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = textLabel
    
    textLabel.Parent = frame
    
    local colors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 127, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(75, 0, 130),
        Color3.fromRGB(148, 0, 211)
    }
    
    local currentColorIndex = 1
    local colorSpeed = 3.0
    
    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function(delta)
        if not textLabel or not textLabel.Parent then
            connection:Disconnect()
            return
        end
        
        local time = os.clock()
        local progress = (time % colorSpeed) / colorSpeed
        local colorIndex = math.floor(progress * #colors) + 1
        
        local nextIndex = colorIndex % #colors + 1
        local colorProgress = (progress * #colors) % 1
        
        local smoothProgress = colorProgress * colorProgress * (3 - 2 * colorProgress)
        textLabel.TextColor3 = colors[colorIndex]:Lerp(colors[nextIndex], smoothProgress)
    end)
    
    return frame
end

createRainbowText("脚本作者已退圈", textContainer)
createRainbowText("傻逼大司马", textContainer)
createRainbowText("大司马你个乐子", textContainer)
createRainbowText("无言以对了", textContainer)

local startButton = Instance.new("TextButton")
startButton.Name = "StartScriptButton"
startButton.Size = UDim2.new(0.7, 0, 0, 40)
startButton.Position = UDim2.new(0.05, 0, 0.85, 0)
startButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
startButton.Text = "启动脚本"
startButton.TextColor3 = Color3.fromRGB(0, 0, 0)
startButton.TextSize = 18
startButton.Font = Enum.Font.GothamBold
startButton.ZIndex = 3
startButton.Parent = leftFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0)
buttonCorner.Parent = startButton

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(180, 180, 180)
buttonStroke.Thickness = 2
buttonStroke.Transparency = 0.2
buttonStroke.Parent = startButton

local originalText = "启动脚本"
local originalBgColor = Color3.fromRGB(255, 255, 255)
local originalTextColor = Color3.fromRGB(0, 0, 0)

startButton.MouseEnter:Connect(function()
    startButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    startButton.Text = "▶ " .. originalText
    startButton.TextColor3 = Color3.fromRGB(0, 0, 0)
end)

startButton.MouseLeave:Connect(function()
    startButton.BackgroundColor3 = originalBgColor
    startButton.Text = originalText
    startButton.TextColor3 = originalTextColor
end)

startButton.MouseButton1Click:Connect(function()
    startButton.AutoButtonColor = false
    startButton.Text = "执行中..."
    startButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    
    startButton:TweenSize(UDim2.new(0.65, 0, 0, 36), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
    task.wait(0.1)
    startButton:TweenSize(UDim2.new(0.7, 0, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
    
    local success, errorMessage = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/XG_SYNB.txt"))()
    end)
    
    if success then
        startButton.Text = "启动成功"
        startButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        startButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        task.wait(0.3)
        
        if screenGui and screenGui.Parent then
            mainFrame:TweenSize(UDim2.new(0, 0, 0, 350), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.3, true)
            task.wait(0.3)
            screenGui:Destroy()
        end
    else
        startButton.Text = "启动失败"
        startButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        startButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        warn("脚本执行失败:", errorMessage)
        
        task.wait(3)
        if startButton and startButton.Parent then
            startButton.AutoButtonColor = true
            startButton.Text = originalText
            startButton.BackgroundColor3 = originalBgColor
            startButton.TextColor3 = originalTextColor
        end
    end
end)

local rightFrame = Instance.new("Frame")
rightFrame.Name = "RightFrame"
rightFrame.Size = UDim2.new(0.5, -15, 0.7, 0)
rightFrame.Position = UDim2.new(0.5, 5, 0.1, 0)
rightFrame.BackgroundTransparency = 1
rightFrame.ZIndex = 2
rightFrame.Parent = mainFrame

local imageContainer = Instance.new("Frame")
imageContainer.Name = "ImageContainer"
imageContainer.Size = UDim2.new(1, 0, 1, 0)
imageContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
imageContainer.BackgroundTransparency = 0.2
imageContainer.ZIndex = 2
imageContainer.Parent = rightFrame

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 10)
imageCorner.Parent = imageContainer

local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "ContentImage"
imageLabel.Size = UDim2.new(0.9, 0, 0.9, 0)
imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://79285958044576"
imageLabel.ScaleType = Enum.ScaleType.Fit
imageLabel.ZIndex = 2
imageLabel.Parent = imageContainer

local loadingText = Instance.new("TextLabel")
loadingText.Name = "LoadingText"
loadingText.Size = UDim2.new(1, 0, 0, 20)
loadingText.Position = UDim2.new(0, 0, 1, 5)
loadingText.BackgroundTransparency = 1
loadingText.Text = "神秘的猫"
loadingText.TextColor3 = Color3.fromRGB(150, 150, 150)
loadingText.TextSize = 14
loadingText.Font = Enum.Font.Gotham
loadingText.ZIndex = 2
loadingText.Parent = rightFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, -40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "公告面板"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 28
titleLabel.Font = Enum.Font.GothamBold
titleLabel.ZIndex = 2
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(0, 0, 0)
titleStroke.Thickness = 1.5
titleStroke.Transparency = 0.6
titleStroke.Parent = titleLabel
titleLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.ZIndex = 3
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeButton

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
end)

closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)

closeButton.MouseButton1Click:Connect(function()
    closeButton:TweenSize(UDim2.new(0, 25, 0, 25), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
    task.wait(0.1)
    screenGui:Destroy()
end)

mainFrame:TweenSize(UDim2.new(0, 400, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)

task.wait(30)
if screenGui and screenGui.Parent then
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 350), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.3, true)
    task.wait(0.3)
    screenGui:Destroy()
end