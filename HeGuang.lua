-- 界面初始化
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XiaoGuangLoader"
screenGui.Parent = player.PlayerGui

-- 主容器
local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, 360, 0, 240)
mainContainer.Position = UDim2.new(0.5, -180, 0.5, -120)
mainContainer.BackgroundTransparency = 1
mainContainer.Parent = screenGui

-- 主面板
local mainPanel = Instance.new("Frame")
mainPanel.Size = UDim2.new(1, 0, 1, 0)
mainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainPanel.BackgroundTransparency = 1
mainPanel.Parent = mainContainer

-- 面板圆角
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0.04, 0)
panelCorner.Parent = mainPanel

-- 顶部装饰条
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0.06, 0)
topBar.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
topBar.BackgroundTransparency = 1
topBar.Parent = mainPanel

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0.04, 0)
barCorner.Parent = topBar

-- 标题
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.15, 0)
titleLabel.Position = UDim2.new(0, 0, 0.08, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XiaoGuang 光脚本"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamSemibold
titleLabel.TextTransparency = 1
titleLabel.Parent = mainPanel

-- 分割线
local divider = Instance.new("Frame")
divider.Size = UDim2.new(0.9, 0, 0.002, 0)
divider.Position = UDim2.new(0.05, 0, 0.25, 0)
divider.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
divider.BackgroundTransparency = 1
divider.Parent = mainPanel

-- 内容区域
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0.9, 0, 0.55, 0)
contentFrame.Position = UDim2.new(0.05, 0, 0.28, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainPanel

-- 信息文本
local infoTexts = {
    "⟢ 免费脚本 · 倒卖司马",
    "⟢ 作者: 小光",
    "⟢ 师傅: 退休不退休", 
    "⟢ QQ: 1693323219",
    "⟢ 群号: 1028199013"
}

local textLabels = {}
for i, text in ipairs(infoTexts) do
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.18, 0)
    label.Position = UDim2.new(0, 0, (i-1) * 0.18, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(180, 180, 200)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextTransparency = 1
    label.Parent = contentFrame
    table.insert(textLabels, label)
end

-- 确定按钮（胶囊型）
local confirmButton = Instance.new("TextButton")
confirmButton.Size = UDim2.new(0.7, 0, 0.12, 0)
confirmButton.Position = UDim2.new(0.15, 0, 0.85, 0)
confirmButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
confirmButton.Text = "确定"
confirmButton.TextColor3 = Color3.new(1, 1, 1)
confirmButton.TextScaled = true
confirmButton.Font = Enum.Font.GothamSemibold
confirmButton.AutoButtonColor = false
confirmButton.BackgroundTransparency = 1
confirmButton.TextTransparency = 1
confirmButton.Parent = mainPanel

-- 胶囊形状
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0)
buttonCorner.Parent = confirmButton

-- 按钮悬停效果
confirmButton.MouseEnter:Connect(function()
    if confirmButton.Enabled then
        TweenService:Create(confirmButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        }):Play()
    end
end)

confirmButton.MouseLeave:Connect(function()
    if confirmButton.Enabled then
        TweenService:Create(confirmButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        }):Play()
    end
end)

-- 显示动画
local function ShowUI()
    -- 主面板
    TweenService:Create(mainPanel, TweenInfo.new(0.5), {
        BackgroundTransparency = 0
    }):Play()
    
    -- 顶部装饰条
    TweenService:Create(topBar, TweenInfo.new(0.4), {
        BackgroundTransparency = 0
    }):Play()
    
    -- 标题
    TweenService:Create(titleLabel, TweenInfo.new(0.4), {
        TextTransparency = 0
    }):Play()
    
    -- 分割线
    TweenService:Create(divider, TweenInfo.new(0.4), {
        BackgroundTransparency = 0
    }):Play()
    
    -- 逐行显示文本
    for i, label in ipairs(textLabels) do
        task.delay(0.1 * i, function()
            TweenService:Create(label, TweenInfo.new(0.3), {
                TextTransparency = 0
            }):Play()
        end)
    end
    
    -- 按钮
    task.delay(0.6, function()
        TweenService:Create(confirmButton, TweenInfo.new(0.3), {
            BackgroundTransparency = 0,
            TextTransparency = 0
        }):Play()
    end)
end

-- 按钮点击事件 - 简化版本
confirmButton.MouseButton1Click:Connect(function()
    -- 立即销毁界面
    screenGui:Destroy()
    
    -- 立即启动脚本
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/XiaoGuang.lua"))()
end)

-- 启动界面
ShowUI()