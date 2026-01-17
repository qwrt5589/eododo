local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SUHUB_GUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Notification = Instance.new("Frame")
local NotifCorner = Instance.new("UICorner")
local NotifStroke = Instance.new("UIStroke")
local NotifTitle = Instance.new("TextLabel")
local NotifText = Instance.new("TextLabel")

Notification.Parent = ScreenGui
Notification.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Notification.Size = UDim2.new(0, 250, 0, 80)
Notification.Position = UDim2.new(1, -260, 1, -90)
Notification.AnchorPoint = Vector2.new(0, 1)

NotifCorner.CornerRadius = UDim.new(0, 8)
NotifCorner.Parent = Notification

NotifStroke.Color = Color3.fromRGB(80, 80, 100)
NotifStroke.Thickness = 2
NotifStroke.Parent = Notification

NotifTitle.Parent = Notification
NotifTitle.BackgroundTransparency = 1
NotifTitle.Size = UDim2.new(1, -10, 0, 20)
NotifTitle.Position = UDim2.new(0, 10, 0, 10)
NotifTitle.Font = Enum.Font.GothamBold
NotifTitle.Text = "欢迎使用白灰脚本"
NotifTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
NotifTitle.TextSize = 14
NotifTitle.TextXAlignment = Enum.TextXAlignment.Left

NotifText.Parent = Notification
NotifText.BackgroundTransparency = 1
NotifText.Size = UDim2.new(1, -10, 0, 40)
NotifText.Position = UDim2.new(0, 10, 0, 30)
NotifText.Font = Enum.Font.Gotham
NotifText.Text = "by 宇神"
NotifText.TextColor3 = Color3.fromRGB(180, 180, 200)
NotifText.TextSize = 12
NotifText.TextXAlignment = Enum.TextXAlignment.Left
NotifText.TextYAlignment = Enum.TextYAlignment.Top

Notification.Position = UDim2.new(1, 260, 1, -90)
game:GetService("TweenService"):Create(
    Notification,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {Position = UDim2.new(1, -260, 1, -90)}
):Play()

task.delay(6.5, function()
    game:GetService("TweenService"):Create(
        Notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, 260, 1, -90)}
    ):Play()
    wait(0.5)
    Notification:Destroy()
end)

local UserInputService = game:GetService("UserInputService")

local function CreateGUI(title)
    local gui = Instance.new("ScreenGui")
    gui.Name = "MyGUI"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 10
    gui.Parent = game.Players.LocalPlayer.PlayerGui
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.BackgroundTransparency = 0
    frame.BackgroundColor3 = Color3.fromRGB(240, 248, 255)
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new(0, 110, 0, -20) 
    frame.Size = UDim2.new(0, 500, 0, 280)
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local dragging = false
    local startPos, startOffset

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startOffset = frame.Position
            gui.Active = true 
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            startPos = nil
            startOffset = nil
            gui.Active = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startPos
            frame.Position = UDim2.new(startOffset.X.Scale, startOffset.X.Offset + delta.X, startOffset.Y.Scale,  
                startOffset.Y.Offset + delta.Y)
        end
    end)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0.05, 0.15 * frame.Size.Y.Offset)
    titleLabel.Position = UDim2.new(0, 0, 0.01, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(0, 0, 0)
    titleLabel.TextSize = math.floor(frame.Size.Y.Offset * 0.1)
    titleLabel.Parent = frame
    local disagreeButton = Instance.new("TextButton")
    disagreeButton.Name = "DisagreeButton"
    disagreeButton.Size = UDim2.new(0, 0.4 * frame.Size.X.Offset, 0, 0.15 * frame.Size.Y.Offset)
    disagreeButton.Position = UDim2.new(0, 0.1 * frame.Size.X.Offset, 0,
        frame.Size.Y.Offset - 0.25 * frame.Size.Y.Offset)
    disagreeButton.BackgroundTransparency = 0
    disagreeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    disagreeButton.Text = "白灰脚本旧版2023"
    disagreeButton.TextColor3 = Color3.new(255, 0, 0)
    disagreeButton.TextSize = math.floor(frame.Size.Y.Offset * 0.08)
    disagreeButton.Font = Enum.Font.SourceSans
    disagreeButton.Parent = frame
    local disagreeCorner = Instance.new("UICorner")
    disagreeCorner.CornerRadius = UDim.new(0, 10)
    disagreeCorner.Parent = disagreeButton

    local agreeButton = Instance.new("TextButton")
    agreeButton.Name = "AgreeButton"
    agreeButton.Size = UDim2.new(0, 0.4 * frame.Size.X.Offset, 0, 0.15 * frame.Size.Y.Offset)
    agreeButton.Position = UDim2.new(0, frame.Size.X.Offset - 0.5 * frame.Size.X.Offset, 0,
        frame.Size.Y.Offset - 0.25 * frame.Size.Y.Offset)
    agreeButton.BackgroundTransparency = 0
    agreeButton.BackgroundColor3 = Color3.fromRGB(106, 159, 255)
    agreeButton.Text = "白灰脚本新版2025"
    agreeButton.TextColor3 = Color3.new(255, 255, 255)
    agreeButton.TextSize = math.floor(frame.Size.Y.Offset * 0.08)
    agreeButton.Font = Enum.Font.SourceSans 
    agreeButton.Parent = frame

    
    local agreeFrame = Instance.new("TextLabel")
    agreeFrame.Size = UDim2.new(0.8, 0, 0.5, 0)
    agreeFrame.Position = UDim2.new(0.1, 0, 0.22, 0)
    agreeFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    agreeFrame.Text = "by 宇神\n QQ1693323219.\n 宇神大王nb666.\n 禁止倒卖 倒卖私马"
    agreeFrame.TextWrapped = true

    
    agreeFrame.TextSize = 16  


    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = agreeFrame

    agreeFrame.Parent = frame

    local agreeCorner = Instance.new("UICorner")
    agreeCorner.CornerRadius = UDim.new(0, 10)
    agreeCorner.Parent = agreeButton
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 40, 0, 40)
    minimizeButton.Position = UDim2.new(1, -65, 0, 10)
    minimizeButton.BackgroundTransparency = 0
    minimizeButton.BackgroundColor3 = Color3.fromRGB(199, 199, 199)
    minimizeButton.Text = "-"
    minimizeButton.TextSize = 28  
    minimizeButton.TextColor3 = Color3.new(0, 0, 0)
    minimizeButton.Font = Enum.Font.SourceSans
    minimizeButton.Parent = frame

    local isMinimized = false

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 5)
    minimizeCorner.Parent = minimizeButton

    minimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            frame.Size = UDim2.new(0, 500, 0, 280)
            titleLabel.Position = UDim2.new(0, 0, 0.01, 0)
            minimizeButton.Text = "-"
            minimizeButton.TextSize = 28
            isMinimized = false
            disagreeButton.Visible = true
            agreeButton.Visible = true
            agreeFrame.Visible = true
        else
            frame.Size = UDim2.new(0, 500, 0, 60)
            titleLabel.Position = UDim2.new(0, 0, 0, 0)
            minimizeButton.Text = "+"
            minimizeButton.TextSize = 28 
            isMinimized = true
            disagreeButton.Visible = false
            agreeButton.Visible = false
            agreeFrame.Visible = false
        end
    end)

    local function AnimateExit()
        local duration = 1
        local startTime = tick()
        local initialSize = frame.Size
        while (tick() - startTime) < duration do
            local elapsedTime = tick() - startTime
            local scale = 1 - elapsedTime / duration
            frame.Size = UDim2.new(initialSize.X.Scale * scale, initialSize.X.Offset * scale,
                initialSize.Y.Scale * scale, initialSize.Y.Offset * scale)
            frame.Position = frame.Position + UDim2.new((1 - scale) / 2, 0, (1 - scale) / 2, 0)
            wait()
        end
        gui:Destroy()
    end
    
    disagreeButton.MouseButton1Click:Connect(function()
        AnimateExit()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/useranewrff/roblox/refs/heads/main/%E8%AF%B7%E9%80%89%E6%8B%A9%E4%BD%A0%E4%BD%BF%E7%94%A8%E7%9A%84%E7%89%88%E6%9C%AC.lua"))()
    end)
    
    agreeButton.MouseButton1Click:Connect(function()
        AnimateExit()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DYDSyyds/DGZXyyds666/main/导管中心.txt"))()
    end)
end

local myTitle = "白灰脚本" 
CreateGUI(myTitle)