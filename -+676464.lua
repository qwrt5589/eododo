local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

local OrionLib = {
    Elements = {},
    ThemeObjects = {},
    Connections = {},
    Flags = {},
    Themes = {
        Default = {
            Main = Color3.fromRGB(25, 25, 25),
            Second = Color3.fromRGB(32, 32, 32),
            Stroke = Color3.fromRGB(60, 60, 60),
            Divider = Color3.fromRGB(60, 60, 60),
            Text = Color3.fromRGB(240, 240, 240),
            TextDark = Color3.fromRGB(150, 150, 150)
        }
    },
    SelectedTheme = "Default",
    Folder = nil,
    SaveCfg = false
}

local OceanColors = {
    DeepBlue = Color3.fromRGB(0, 20, 40),
    OceanBlue = Color3.fromRGB(0, 70, 130),
    SkyBlue = Color3.fromRGB(0, 150, 226),
    LightBlue = Color3.fromRGB(100, 180, 255),
    Aqua = Color3.fromRGB(0, 255, 255),
    Turquoise = Color3.fromRGB(64, 224, 208),
    DarkGray = Color3.fromRGB(40, 40, 40),
    Gray = Color3.fromRGB(60, 60, 60),
    White = Color3.fromRGB(255, 255, 255)
}

local bai = {
    saymege = "",
    saymount = 1,
    sayfast = false,
    autosay = false
}

local function CreateOceanBackground(Parent)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 1, 0)
    Container.BackgroundTransparency = 1
    Container.Parent = Parent
    
    local MainBackground = Instance.new("Frame")
    MainBackground.Size = UDim2.new(1, 0, 1, 0)
    MainBackground.BackgroundColor3 = OceanColors.DeepBlue
    MainBackground.BackgroundTransparency = 0.05
    MainBackground.Parent = Container
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainBackground
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Rotation = -45
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, OceanColors.DeepBlue),
        ColorSequenceKeypoint.new(0.3, OceanColors.OceanBlue),
        ColorSequenceKeypoint.new(0.7, OceanColors.OceanBlue),
        ColorSequenceKeypoint.new(1, OceanColors.DeepBlue)
    })
    Gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 0.1)
    })
    Gradient.Parent = MainBackground
    
    local Pattern = Instance.new("Frame")
    Pattern.Size = UDim2.new(1, 0, 1, 0)
    Pattern.BackgroundColor3 = OceanColors.OceanBlue
    Pattern.BackgroundTransparency = 0.95
    Pattern.Parent = Container
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = OceanColors.SkyBlue
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.9
    UIStroke.Parent = Pattern
    
    local TopLine = Instance.new("Frame")
    TopLine.Size = UDim2.new(1, -40, 0, 2)
    TopLine.Position = UDim2.new(0.5, 0, 0.1, 0)
    TopLine.AnchorPoint = Vector2.new(0.5, 0)
    TopLine.BackgroundColor3 = OceanColors.LightBlue
    TopLine.BackgroundTransparency = 0.7
    TopLine.Parent = Container
    
    local BottomLine = Instance.new("Frame")
    BottomLine.Size = UDim2.new(1, -40, 0, 2)
    BottomLine.Position = UDim2.new(0.5, 0, 0.9, 0)
    BottomLine.AnchorPoint = Vector2.new(0.5, 0)
    BottomLine.BackgroundColor3 = OceanColors.LightBlue
    BottomLine.BackgroundTransparency = 0.7
    BottomLine.Parent = Container
    
    for i = 1, 8 do
        local Bubble = Instance.new("Frame")
        Bubble.Size = UDim2.new(0, math.random(15, 30), 0, math.random(15, 30))
        Bubble.Position = UDim2.new(math.random() * 0.85 + 0.05, 0, math.random() * 0.85 + 0.05, 0)
        Bubble.BackgroundColor3 = OceanColors.Aqua
        Bubble.BackgroundTransparency = 0.85
        Bubble.Parent = Container
        
        local BubbleCorner = Instance.new("UICorner")
        BubbleCorner.CornerRadius = UDim.new(1, 0)
        BubbleCorner.Parent = Bubble
        
        task.spawn(function()
            while Bubble.Parent do
                TweenService:Create(Bubble, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = 0.75,
                    Size = UDim2.new(0, Bubble.Size.X.Offset + 2, 0, Bubble.Size.Y.Offset + 2)
                }):Play()
                task.wait(1.5)
                TweenService:Create(Bubble, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = 0.85,
                    Size = UDim2.new(0, Bubble.Size.X.Offset - 2, 0, Bubble.Size.Y.Offset - 2)
                }):Play()
                task.wait(1.5)
            end
        end)
    end
    
    return Container
end
local function CreateOceanButton(Parent, Config)
    local Button = Instance.new("TextButton")
    Button.Name = Config.Name or "OceanButton"
    Button.Size = Config.Size or UDim2.new(1, 0, 0, 40)
    Button.Position = Config.Position or UDim2.new(0, 0, 0, 0)
    Button.BackgroundColor3 = OceanColors.OceanBlue
    Button.BackgroundTransparency = 0.2
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Parent
    Button.ZIndex = 5
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = OceanColors.LightBlue
    Stroke.Thickness = 2
    Stroke.Transparency = 0.1
    Stroke.Parent = Button
    
    if Config.Icon then
        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(1, 0, 1, 0)
        Icon.Position = UDim2.new(0, 0, 0, 0)
        Icon.AnchorPoint = Vector2.new(0, 0)
        Icon.Image = Config.Icon
        Icon.BackgroundTransparency = 1
        Icon.ImageColor3 = OceanColors.White
        Icon.ScaleType = Enum.ScaleType.Stretch
        Icon.ZIndex = 6
        Icon.Parent = Button
        
        local IconMask = Instance.new("UICorner")
        IconMask.CornerRadius = UDim.new(0, 8)
        IconMask.Parent = Icon
    end
    
    if Config.Text and Config.Text ~= "" then
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -20, 1, 0)
        Label.Position = UDim2.new(0.5, 0, 0.5, 0)
        Label.AnchorPoint = Vector2.new(0.5, 0.5)
        Label.Text = Config.Text or "按钮"
        Label.TextSize = Config.TextSize or 14
        Label.Font = Enum.Font.GothamBold
        Label.TextColor3 = OceanColors.White
        Label.BackgroundTransparency = 1
        Label.TextXAlignment = Enum.TextXAlignment.Center
        Label.TextYAlignment = Enum.TextYAlignment.Center
        Label.ZIndex = 7
        Label.Parent = Button
    end
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 90, 180),
            BackgroundTransparency = 0.1
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {
            Color = OceanColors.Aqua,
            Thickness = 2.5,
            Transparency = 0
        }):Play()
        
        local Icon = Button:FindFirstChildOfClass("ImageLabel")
        if Icon then
            TweenService:Create(Icon, TweenInfo.new(0.2), {
                ImageColor3 = OceanColors.LightBlue
            }):Play()
        end
        
        local Label = Button:FindFirstChildOfClass("TextLabel")
        if Label then
            TweenService:Create(Label, TweenInfo.new(0.2), {
                TextColor3 = OceanColors.LightBlue
            }):Play()
        end
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = OceanColors.OceanBlue,
            BackgroundTransparency = 0.2
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {
            Color = OceanColors.LightBlue,
            Thickness = 2,
            Transparency = 0.1
        }):Play()
        
        local Icon = Button:FindFirstChildOfClass("ImageLabel")
        if Icon then
            TweenService:Create(Icon, TweenInfo.new(0.2), {
                ImageColor3 = OceanColors.White
            }):Play()
        end
        
        local Label = Button:FindFirstChildOfClass("TextLabel")
        if Label then
            TweenService:Create(Label, TweenInfo.new(0.2), {
                TextColor3 = OceanColors.White
            }):Play()
        end
    end)
    
    Button.MouseButton1Down:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(0, 50, 100),
            BackgroundTransparency = 0.3
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.1), {
            Color = OceanColors.SkyBlue,
            Thickness = 1.8
        }):Play()
        
        local Icon = Button:FindFirstChildOfClass("ImageLabel")
        if Icon then
            TweenService:Create(Icon, TweenInfo.new(0.1), {
                ImageColor3 = OceanColors.SkyBlue
            }):Play()
        end
        
        local Label = Button:FindFirstChildOfClass("TextLabel")
        if Label then
            TweenService:Create(Label, TweenInfo.new(0.1), {
                TextColor3 = OceanColors.SkyBlue
            }):Play()
        end
    end)
    
    Button.MouseButton1Up:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(0, 90, 180),
            BackgroundTransparency = 0.1
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.1), {
            Color = OceanColors.Aqua,
            Thickness = 2.5,
            Transparency = 0
        }):Play()
        
        local Icon = Button:FindFirstChildOfClass("ImageLabel")
        if Icon then
            TweenService:Create(Icon, TweenInfo.new(0.1), {
                ImageColor3 = OceanColors.LightBlue
            }):Play()
        end
        
        local Label = Button:FindFirstChildOfClass("TextLabel")
        if Label then
            TweenService:Create(Label, TweenInfo.new(0.1), {
                TextColor3 = OceanColors.LightBlue
            }):Play()
        end
        
        task.wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = OceanColors.OceanBlue,
            BackgroundTransparency = 0.2
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {
            Color = OceanColors.LightBlue,
            Thickness = 2,
            Transparency = 0.1
        }):Play()
        
        if Icon then
            TweenService:Create(Icon, TweenInfo.new(0.2), {
                ImageColor3 = OceanColors.White
            }):Play()
        end
        
        if Label then
            TweenService:Create(Label, TweenInfo.new(0.2), {
                TextColor3 = OceanColors.White
            }):Play()
        end
        
        if Config.Callback then
            pcall(Config.Callback)
        end
    end)
    
    return Button
end

local function CreateOceanToggle(Parent, Config)
    local Toggle = {Value = Config.Default or false}
    
    local Container = CreateOceanButton(Parent, {
        Text = Config.Name or "开关",
        Size = Config.Size or UDim2.new(1, 0, 0, 40),
        Callback = function()
            Toggle.Value = not Toggle.Value
            Toggle:UpdateVisual()
            if Config.Callback then
                pcall(Config.Callback, Toggle.Value)
            end
        end
    })
    
    local Label = Container:FindFirstChildOfClass("TextLabel")
    local Stroke = Container:FindFirstChildOfClass("UIStroke")
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 22, 0, 22)
    Indicator.Position = UDim2.new(1, -27, 0.5, 0)
    Indicator.AnchorPoint = Vector2.new(1, 0.5)
    Indicator.BackgroundColor3 = Toggle.Value and OceanColors.LightBlue or OceanColors.DeepBlue
    Indicator.BackgroundTransparency = 0.1
    Indicator.ZIndex = 8
    Indicator.Parent = Container
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(0, 6)
    IndicatorCorner.Parent = Indicator
    
    local IndicatorStroke = Instance.new("UIStroke")
    IndicatorStroke.Color = OceanColors.White
    IndicatorStroke.Thickness = 1.5
    IndicatorStroke.Transparency = 0.2
    IndicatorStroke.Parent = Indicator
    
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 10, 0, 10)
    Dot.Position = UDim2.new(0.5, 0, 0.5, 0)
    Dot.AnchorPoint = Vector2.new(0.5, 0.5)
    Dot.BackgroundColor3 = OceanColors.White
    Dot.BackgroundTransparency = 0
    Dot.ZIndex = 9
    Dot.Parent = Indicator
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot
    
    function Toggle:UpdateVisual()
        if Toggle.Value then
            TweenService:Create(Indicator, TweenInfo.new(0.2), {
                BackgroundColor3 = OceanColors.LightBlue,
                BackgroundTransparency = 0.1
            }):Play()
            TweenService:Create(Dot, TweenInfo.new(0.2), {
                Position = UDim2.new(0.8, 0, 0.5, 0)
            }):Play()
            if Stroke then
                TweenService:Create(Stroke, TweenInfo.new(0.2), {
                    Color = OceanColors.LightBlue
                }):Play()
            end
            if Label then
                TweenService:Create(Label, TweenInfo.new(0.2), {
                    TextColor3 = OceanColors.LightBlue
                }):Play()
            end
        else
            TweenService:Create(Indicator, TweenInfo.new(0.2), {
                BackgroundColor3 = OceanColors.DeepBlue,
                BackgroundTransparency = 0.3
            }):Play()
            TweenService:Create(Dot, TweenInfo.new(0.2), {
                Position = UDim2.new(0.2, 0, 0.5, 0)
            }):Play()
            if Stroke then
                TweenService:Create(Stroke, TweenInfo.new(0.2), {
                    Color = OceanColors.LightBlue
                }):Play()
            end
            if Label then
                TweenService:Create(Label, TweenInfo.new(0.2), {
                    TextColor3 = OceanColors.White
                }):Play()
            end
        end
    end
    
    Toggle:UpdateVisual()
    
    return Toggle
end

local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
Orion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Orion.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(Orion)
    Orion.Parent = game:GetService("CoreGui")
elseif gethui then
    Orion.Parent = gethui()
else
    Orion.Parent = game:GetService("CoreGui")
end

for _, Interface in ipairs(Orion.Parent:GetChildren()) do
    if Interface.Name == Orion.Name and Interface ~= Orion then
        Interface:Destroy()
    end
end

function OrionLib:IsRunning()
    return Orion.Parent ~= nil
end

local function AddConnection(Signal, Function)
    if not OrionLib:IsRunning() then return end
    local SignalConnect = Signal:Connect(Function)
    table.insert(OrionLib.Connections, SignalConnect)
    return SignalConnect
end

task.spawn(function()
    while OrionLib:IsRunning() do 
        wait(1) 
    end
    for _, Connection in ipairs(OrionLib.Connections) do
        pcall(function() Connection:Disconnect() end)
    end
    OrionLib.Connections = {}
end)
local function MakeDraggable(DragPoint, Main, OnDragStart, OnDragEnd)
    local Dragging = false
    local DragInput, MousePos, FramePos
    
    local PressTime = 0
    local PressStart = 0
    local LongPressThreshold = 0.3
    
    DragPoint.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            PressStart = tick()
            PressTime = PressStart
            
            task.spawn(function()
                while PressTime == PressStart do
                    if tick() - PressStart >= LongPressThreshold then
                        Dragging = true
                        MousePos = Input.Position
                        FramePos = Main.Position
                        
                        if OnDragStart then
                            pcall(OnDragStart)
                        end
                        
                        TweenService:Create(Main, TweenInfo.new(0.1), {
                            BackgroundTransparency = 0.2
                        }):Play()
                        break
                    end
                    wait(0.05)
                end
            end)
            
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    PressTime = 0
                    if Dragging then
                        Dragging = false
                        if OnDragEnd then
                            pcall(OnDragEnd)
                        end
                        TweenService:Create(Main, TweenInfo.new(0.1), {
                            BackgroundTransparency = 0
                        }):Play()
                    end
                end
            end)
        end
    end)
    
    DragPoint.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            DragInput = Input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            local Delta = Input.Position - MousePos
            Main.Position = UDim2.new(
                FramePos.X.Scale, 
                FramePos.X.Offset + Delta.X,
                FramePos.Y.Scale, 
                FramePos.Y.Offset + Delta.Y
            )
        end
    end)
end

local function Create(Name, Properties, Children)
    local Object = Instance.new(Name)
    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end
    for _, Child in ipairs(Children or {}) do
        Child.Parent = Object
    end
    return Object
end

local function ApplyRoundCorners(Object, CornerRadius)
    local Corner = Instance.new("UICorner")
    if type(CornerRadius) == "table" then
        Corner.CornerRadius = UDim.new(0, CornerRadius.Default or 8)
        if CornerRadius.TopLeft then
            Corner.CornerRadius = UDim.new(0, 0)
        end
    else
        Corner.CornerRadius = UDim.new(0, CornerRadius or 8)
    end
    Corner.Parent = Object
    return Corner
end

local NotificationHolder = Create("Frame", {
    Name = "NotificationHolder",
    Parent = Orion,
    Size = UDim2.new(0, 350, 1, -40),
    Position = UDim2.new(1, -360, 0, 20),
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0)
})

local NotificationList = Create("UIListLayout", {
    Parent = NotificationHolder,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 10),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Bottom
})

function OrionLib:MakeNotification(NotificationConfig)
    spawn(function()
        NotificationConfig.Name = NotificationConfig.Name or "波塞冬通知"
        NotificationConfig.Content = NotificationConfig.Content or "最强波塞冬"
        NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://"
        NotificationConfig.Time = NotificationConfig.Time or 5
        
        local Notification = Create("Frame", {
            Parent = NotificationHolder,
            Size = UDim2.new(0, 320, 0, 0),
            BackgroundColor3 = OceanColors.OceanBlue,
            BackgroundTransparency = 0.1,
            ClipsDescendants = true,
            LayoutOrder = 999
        })
        
        ApplyRoundCorners(Notification, 10)
        
        local Stroke = Create("UIStroke", {
            Parent = Notification,
            Color = OceanColors.LightBlue,
            Thickness = 2
        })
        
        local Padding = Create("UIPadding", {
            Parent = Notification,
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12)
        })
        
        local Icon = Create("ImageLabel", {
            Parent = Notification,
            Size = UDim2.new(0, 28, 0, 28),
            Position = UDim2.new(0, 0, 0, 0),
            Image = NotificationConfig.Image,
            BackgroundTransparency = 1,
            ImageColor3 = OceanColors.LightBlue
        })
        
        local Title = Create("TextLabel", {
            Parent = Notification,
            Size = UDim2.new(1, -40, 0, 20),
            Position = UDim2.new(0, 35, 0, 0),
            Text = NotificationConfig.Name,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            TextColor3 = OceanColors.LightBlue,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        local Content = Create("TextLabel", {
            Parent = Notification,
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(0, 0, 0, 30),
            Text = NotificationConfig.Content,
            TextSize = 14,
            Font = Enum.Font.Gotham,
            TextColor3 = OceanColors.White,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y
        })
        
        Content:GetPropertyChangedSignal("TextBounds"):Connect(function()
            Notification.Size = UDim2.new(0, 320, 0, Content.TextBounds.Y + 50)
        end)
        
        Content.Text = NotificationConfig.Content
        
        TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 320, 0, Content.TextBounds.Y + 50)
        }):Play()
        
        wait(NotificationConfig.Time)
        
        TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 320, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        
        TweenService:Create(Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Transparency = 1
        }):Play()
        
        TweenService:Create(Icon, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            ImageTransparency = 1
        }):Play()
        
        TweenService:Create(Title, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            TextTransparency = 1
        }):Play()
        
        TweenService:Create(Content, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            TextTransparency = 1
        }):Play()
        
        wait(0.3)
        Notification:Destroy()
    end)
end
function OrionLib:MakeWindow(WindowConfig)
    WindowConfig = WindowConfig or {}
    WindowConfig.Name = WindowConfig.Name or "波塞冬脚本"
    WindowConfig.HidePremium = WindowConfig.HidePremium or false
    WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
    WindowConfig.IntroText = WindowConfig.IntroText or "神秘波塞冬"
    WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or "波塞冬"
    WindowConfig.IntroEnabled = WindowConfig.IntroEnabled or false
    
    OrionLib.Folder = WindowConfig.ConfigFolder
    OrionLib.SaveCfg = WindowConfig.SaveConfig
    
    local FirstTab = true
    local UIHidden = false
    
    local MainWindow = Create("Frame", {
        Name = "MainWindow",
        Parent = Orion,
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.5, -250, 0.5, -200),
        BackgroundColor3 = OceanColors.OceanBlue,
        BackgroundTransparency = 0.05,
        ClipsDescendants = true,
        Active = true,
        ZIndex = 1
    })
    
    ApplyRoundCorners(MainWindow, 15)
    
    local OceanBackground = CreateOceanBackground(MainWindow)
    
    local WindowStroke = Create("UIStroke", {
        Parent = MainWindow,
        Color = OceanColors.LightBlue,
        Thickness = 3,
        Transparency = 0.1
    })
    
    local TopBar = Create("Frame", {
        Parent = MainWindow,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(0, 80, 160),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    
    ApplyRoundCorners(TopBar, {TopLeft = 15, TopRight = 15, BottomLeft = 0, BottomRight = 0})
    
    local Title = Create("TextLabel", {
        Parent = TopBar,
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        Text = WindowConfig.Name,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextColor3 = OceanColors.LightBlue,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3
    })
    
    local DragArea = Create("TextButton", {
        Parent = TopBar,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 3
    })
    
    MakeDraggable(DragArea, MainWindow)
    
    local SideBar = Create("Frame", {
        Parent = MainWindow,
        Size = UDim2.new(0, 150, 1, -45),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(0, 50, 120),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    
    local TabContainer = Create("ScrollingFrame", {
        Parent = SideBar,
        Size = UDim2.new(1, 0, 1, -50),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = OceanColors.SkyBlue,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 3
    })
    
    local TabList = Create("UIListLayout", {
        Parent = TabContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8)
    })
    
    TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y)
    end)
    
    local ContentContainer = Create("Frame", {
        Parent = MainWindow,
        Size = UDim2.new(1, -150, 1, -45),
        Position = UDim2.new(0, 150, 0, 45),
        BackgroundColor3 = Color3.fromRGB(0, 40, 100),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 2
    })
    
    local function CreateDraggableToggle()
        local UIVisible = true
        local isDragging = false
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Name = "ToggleButton"
        ToggleButton.Size = UDim2.new(0, 60, 0, 60)
        ToggleButton.Position = UDim2.new(1, -70, 0, 20)
        ToggleButton.BackgroundColor3 = OceanColors.OceanBlue
        ToggleButton.BackgroundTransparency = 0.1
        ToggleButton.Text = ""
        ToggleButton.AutoButtonColor = false
        ToggleButton.Parent = Orion
        ToggleButton.ZIndex = 50
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 15)
        Corner.Parent = ToggleButton
        
        local Stroke = Instance.new("UIStroke")
        Stroke.Color = OceanColors.LightBlue
        Stroke.Thickness = 2
        Stroke.Transparency = 0.1
        Stroke.Parent = ToggleButton
        
        local Icon = Instance.new("ImageLabel")
        Icon.Name = "Icon"
        Icon.Size = UDim2.new(1, 0, 1, 0)
        Icon.Position = UDim2.new(0, 0, 0, 0)
        Icon.Image = "rbxassetid://79285958044576"
        Icon.BackgroundTransparency = 1
        Icon.ImageColor3 = OceanColors.White
        Icon.ScaleType = Enum.ScaleType.Stretch
        Icon.ZIndex = 51
        Icon.Parent = ToggleButton
        
        local IconMask = Instance.new("UICorner")
        IconMask.CornerRadius = UDim.new(0, 15)
        IconMask.Parent = Icon
        
        local DragHint = Instance.new("TextLabel")
        DragHint.Name = "DragHint"
        DragHint.Size = UDim2.new(1.5, 0, 0, 20)
        DragHint.Position = UDim2.new(0.5, 0, -0.5, -5)
        DragHint.AnchorPoint = Vector2.new(0.5, 0.5)
        DragHint.Text = "长按拖动"
        DragHint.TextSize = 10
        DragHint.Font = Enum.Font.Gotham
        DragHint.TextColor3 = OceanColors.LightBlue
        DragHint.BackgroundTransparency = 1
        DragHint.TextXAlignment = Enum.TextXAlignment.Center
        DragHint.Visible = false
        DragHint.ZIndex = 52
        DragHint.Parent = ToggleButton
        
        ToggleButton.MouseEnter:Connect(function()
            if not isDragging then
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 65, 0, 65),
                    BackgroundTransparency = 0.05
                }):Play()
                TweenService:Create(Stroke, TweenInfo.new(0.2), {
                    Color = OceanColors.Aqua,
                    Thickness = 2.5,
                    Transparency = 0
                }):Play()
                TweenService:Create(Icon, TweenInfo.new(0.2), {
                    ImageColor3 = OceanColors.LightBlue
                }):Play()
            end
        end)
        
        ToggleButton.MouseLeave:Connect(function()
            if not isDragging then
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 60, 0, 60),
                    BackgroundTransparency = 0.1
                }):Play()
                TweenService:Create(Stroke, TweenInfo.new(0.2), {
                    Color = OceanColors.LightBlue,
                    Thickness = 2,
                    Transparency = 0.1
                }):Play()
                TweenService:Create(Icon, TweenInfo.new(0.2), {
                    ImageColor3 = OceanColors.White
                }):Play()
            end
        end)
        
        ToggleButton.MouseButton1Click:Connect(function()
            if not isDragging then
                UIVisible = not UIVisible
                
                if not UIVisible then
                    TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 0, 0, 0),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }):Play()
                    wait(0.3)
                    MainWindow.Visible = false
                    TweenService:Create(Icon, TweenInfo.new(0.2), {
                        ImageTransparency = 0.3
                    }):Play()
                else
                    MainWindow.Visible = true
                    TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 500, 0, 400),
                        Position = UDim2.new(0.5, -250, 0.5, -200)
                    }):Play()
                    TweenService:Create(Icon, TweenInfo.new(0.2), {
                        ImageTransparency = 0
                    }):Play()
                end
            end
        end)
        
        MakeDraggable(ToggleButton, ToggleButton, 
            function()
                isDragging = true
                DragHint.Visible = true
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.2,
                    Size = UDim2.new(0, 70, 0, 70)
                }):Play()
                TweenService:Create(Icon, TweenInfo.new(0.2), {
                    ImageColor3 = OceanColors.Aqua
                }):Play()
            end,
            function()
                isDragging = false
                DragHint.Visible = false
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0.1,
                    Size = UDim2.new(0, 60, 0, 60)
                }):Play()
                TweenService:Create(Icon, TweenInfo.new(0.2), {
                    ImageColor3 = OceanColors.White
                }):Play()
            end
        )
        
        return ToggleButton
    end
    
    local ToggleButton = CreateDraggableToggle()
    
    AddConnection(UserInputService.InputBegan, function(Input)
        if Input.KeyCode == Enum.KeyCode.RightShift and UIHidden then
            MainWindow.Visible = true
            TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 500, 0, 400),
                Position = UDim2.new(0.5, -250, 0.5, -200)
            }):Play()
            UIHidden = false
        end
    end)
    
    local TabFunctions = {}
    
    function TabFunctions:MakeTab(TabConfig)
        TabConfig = TabConfig or {}
        TabConfig.Name = TabConfig.Name or "海洋功能"
        TabConfig.Icon = TabConfig.Icon or ""
        TabConfig.PremiumOnly = TabConfig.PremiumOnly or false
        
        local TabButton = CreateOceanButton(TabContainer, {
            Text = TabConfig.Name,
            Size = UDim2.new(1, -10, 0, 42),
            LayoutOrder = #TabContainer:GetChildren(),
            Icon = TabConfig.Icon
        })
        
        local TabContent = Create("ScrollingFrame", {
            Parent = ContentContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = OceanColors.SkyBlue,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            BorderSizePixel = 0,
            ZIndex = 3
        })
        
        local ContentList = Create("UIListLayout", {
            Parent = TabContent,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        })
        
        local ContentPadding = Create("UIPadding", {
            Parent = TabContent,
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingTop = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15)
        })
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 30)
        end)
        
        if FirstTab then
            FirstTab = false
            local Stroke = TabButton:FindFirstChildOfClass("UIStroke")
            local Label = TabButton:FindFirstChildOfClass("TextLabel")
            
            if Stroke then
                Stroke.Color = OceanColors.Aqua
                Stroke.Thickness = 2.5
                Stroke.Transparency = 0
            end
            
            if Label then
                Label.TextColor3 = OceanColors.Aqua
                Label.Font = Enum.Font.GothamBold
            end
            
            TabContent.Visible = true
        end
        
        TabButton.MouseButton1Click:Connect(function()
            for _, Child in ipairs(TabContainer:GetChildren()) do
                if Child:IsA("TextButton") then
                    local Stroke = Child:FindFirstChildOfClass("UIStroke")
                    local Label = Child:FindFirstChildOfClass("TextLabel")
                    
                    if Stroke then
                        TweenService:Create(Stroke, TweenInfo.new(0.2), {
                            Color = OceanColors.LightBlue,
                            Thickness = 2,
                            Transparency = 0.1
                        }):Play()
                    end
                    
                    if Label then
                        TweenService:Create(Label, TweenInfo.new(0.2), {
                            TextColor3 = OceanColors.White
                        }):Play()
                        Label.Font = Enum.Font.Gotham
                    end
                end
            end
            
            for _, Child in ipairs(ContentContainer:GetChildren()) do
                if Child:IsA("ScrollingFrame") then
                    Child.Visible = false
                end
            end
            
            local Stroke = TabButton:FindFirstChildOfClass("UIStroke")
            local Label = TabButton:FindFirstChildOfClass("TextLabel")
            
            if Stroke then
                TweenService:Create(Stroke, TweenInfo.new(0.2), {
                    Color = OceanColors.Aqua,
                    Thickness = 2.5,
                    Transparency = 0
                }):Play()
            end
            
            if Label then
                TweenService:Create(Label, TweenInfo.new(0.2), {
                    TextColor3 = OceanColors.Aqua
                }):Play()
                Label.Font = Enum.Font.GothamBold
            end
            
            TabContent.Visible = true
        end)
        
        local function CreateElementContainer()
            local Elements = {}
            
            function Elements:AddParagraph(Title, Content)
                local ParagraphContainer = Create("Frame", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 65),
                    BackgroundColor3 = Color3.fromRGB(0, 80, 160),
                    BackgroundTransparency = 0.1,
                    LayoutOrder = #TabContent:GetChildren(),
                    ZIndex = 4
                })
                
                ApplyRoundCorners(ParagraphContainer, 8)
                
                Create("UIStroke", {
                    Parent = ParagraphContainer,
                    Color = OceanColors.LightBlue,
                    Thickness = 2,
                    Transparency = 0.2
                })
                
                local TitleLabel = Create("TextLabel", {
                    Parent = ParagraphContainer,
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 10),
                    Text = Title or "海洋指引",
                    TextSize = 16,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = OceanColors.LightBlue,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 5
                })
                
                local ContentLabel = Create("TextLabel", {
                    Parent = ParagraphContainer,
                    Size = UDim2.new(1, -20, 0, 30),
                    Position = UDim2.new(0, 10, 0, 35),
                    Text = Content or "海神波塞冬🤓🤓",
                    TextSize = 13,
                    Font = Enum.Font.Gotham,
                    TextColor3 = OceanColors.White,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ZIndex = 5
                })
                
                ContentLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    ParagraphContainer.Size = UDim2.new(1, 0, 0, ContentLabel.TextBounds.Y + 45)
                end)
                
                local ParagraphFunction = {}
                function ParagraphFunction:Set(NewContent)
                    ContentLabel.Text = NewContent
                end
                
                return ParagraphFunction
            end
            
            function Elements:AddLabel(Text)
                local LabelContainer = Create("Frame", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(0, 80, 160),
                    BackgroundTransparency = 0.1,
                    LayoutOrder = #TabContent:GetChildren(),
                    ZIndex = 4
                })
                
                ApplyRoundCorners(LabelContainer, 8)
                
                Create("UIStroke", {
                    Parent = LabelContainer,
                    Color = OceanColors.LightBlue,
                    Thickness = 2,
                    Transparency = 0.2
                })
                
                local Label = Create("TextLabel", {
                    Parent = LabelContainer,
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Text = Text or "海洋标签",
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    TextColor3 = OceanColors.White,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 5
                })
                
                local LabelFunction = {}
                function LabelFunction:Set(NewText)
                    Label.Text = NewText
                end
                
                return LabelFunction
            end
            
            function Elements:AddButton(ButtonConfig)
                ButtonConfig = ButtonConfig or {}
                ButtonConfig.Name = ButtonConfig.Name or "海洋按钮"
                ButtonConfig.Callback = ButtonConfig.Callback or function() end
                
                local ButtonContainer = Create("Frame", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 45),
                    BackgroundTransparency = 1,
                    LayoutOrder = #TabContent:GetChildren(),
                    ZIndex = 4
                })
                
                local Button = CreateOceanButton(ButtonContainer, {
                    Text = ButtonConfig.Name,
                    Size = UDim2.new(1, 0, 1, 0),
                    Callback = ButtonConfig.Callback
                })
                
                local ButtonFunction = {}
                function ButtonFunction:Set(NewText)
                    local Label = Button:FindFirstChildOfClass("TextLabel")
                    if Label then
                        Label.Text = NewText
                    end
                end
                
                return ButtonFunction
            end
            
            function Elements:AddToggle(ToggleConfig)
                ToggleConfig = ToggleConfig or {}
                ToggleConfig.Name = ToggleConfig.Name or "海洋开关"
                ToggleConfig.Default = ToggleConfig.Default or false
                ToggleConfig.Callback = ToggleConfig.Callback or function() end
                ToggleConfig.Flag = ToggleConfig.Flag or nil
                ToggleConfig.Save = ToggleConfig.Save or false
                
                return CreateOceanToggle(TabContent, ToggleConfig)
            end
            
            function Elements:AddSlider(SliderConfig)
                SliderConfig = SliderConfig or {}
                SliderConfig.Name = SliderConfig.Name or "海洋滑块"
                SliderConfig.Min = SliderConfig.Min or 0
                SliderConfig.Max = SliderConfig.Max or 100
                SliderConfig.Increment = SliderConfig.Increment or 1
                SliderConfig.Default = SliderConfig.Default or 50
                SliderConfig.Callback = SliderConfig.Callback or function() end
                SliderConfig.ValueName = SliderConfig.ValueName or ""
                SliderConfig.Flag = SliderConfig.Flag or nil
                SliderConfig.Save = SliderConfig.Save or false
                
                local Slider = {Value = SliderConfig.Default, Save = SliderConfig.Save}
                local Dragging = false
                
                local SliderContainer = Create("Frame", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 70),
                    BackgroundColor3 = Color3.fromRGB(0, 80, 160),
                    BackgroundTransparency = 0.1,
                    LayoutOrder = #TabContent:GetChildren(),
                    ZIndex = 4
                })
                
                ApplyRoundCorners(SliderContainer, 8)
                
                Create("UIStroke", {
                    Parent = SliderContainer,
                    Color = OceanColors.LightBlue,
                    Thickness = 2,
                    Transparency = 0.2
                })
                
                local SliderLabel = Create("TextLabel", {
                    Parent = SliderContainer,
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 5),
                    Text = SliderConfig.Name,
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = OceanColors.LightBlue,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 5
                })
                
                local SliderValue = Create("TextLabel", {
                    Parent = SliderContainer,
                    Size = UDim2.new(0, 50, 0, 20),
                    Position = UDim2.new(1, -60, 0, 5),
                    Text = tostring(Slider.Value) .. SliderConfig.ValueName,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = OceanColors.White,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    ZIndex = 5
                })
                
                local SliderBar = Create("Frame", {
                    Parent = SliderContainer,
                    Size = UDim2.new(1, -20, 0, 10),
                    Position = UDim2.new(0, 10, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(0, 50, 120),
                    BackgroundTransparency = 0,
                    ZIndex = 5
                })
                
                ApplyRoundCorners(SliderBar, 5)
                
                local SliderFill = Create("Frame", {
                    Parent = SliderBar,
                    Size = UDim2.new((Slider.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 0, 1, 0),
                    BackgroundColor3 = OceanColors.SkyBlue,
                    BackgroundTransparency = 0,
                    ZIndex = 6
                })
                
                ApplyRoundCorners(SliderFill, 5)
                
                local SliderHandle = Create("Frame", {
                    Parent = SliderBar,
                    Size = UDim2.new(0, 18, 0, 18),
                    Position = UDim2.new((Slider.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = OceanColors.LightBlue,
                    BackgroundTransparency = 0,
                    ZIndex = 7
                })
                
                ApplyRoundCorners(SliderHandle, 9)
                
                function Slider:Set(Value)
                    self.Value = math.clamp(math.floor(Value / SliderConfig.Increment + 0.5) * SliderConfig.Increment, SliderConfig.Min, SliderConfig.Max)
                    local Percent = (self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min)
                    TweenService:Create(SliderFill, TweenInfo.new(0.1), {
                        Size = UDim2.new(Percent, 0, 1, 0)
                    }):Play()
                    TweenService:Create(SliderHandle, TweenInfo.new(0.1), {
                        Position = UDim2.new(Percent, 0, 0.5, 0)
                    }):Play()
                    SliderValue.Text = tostring(self.Value) .. SliderConfig.ValueName
                    SliderConfig.Callback(self.Value)
                end
                
                SliderBar.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = true
                    end
                end)
                
                SliderBar.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(Input)
                    if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
                        local MousePos = Input.Position.X
                        local BarPos = SliderBar.AbsolutePosition.X
                        local BarSize = SliderBar.AbsoluteSize.X
                        local Percent = math.clamp((MousePos - BarPos) / BarSize, 0, 1)
                        local Value = SliderConfig.Min + (SliderConfig.Max - SliderConfig.Min) * Percent
                        Slider:Set(Value)
                    end
                end)
                
                if SliderConfig.Flag then
                    OrionLib.Flags[SliderConfig.Flag] = Slider
                end
                
                return Slider
            end
            
            return Elements
        end
        
        return CreateElementContainer()
    end
    
    return TabFunctions
end

function OrionLib:Init()
    if OrionLib.SaveCfg then
        pcall(function()
            if makefolder and not isfolder(OrionLib.Folder) then
                makefolder(OrionLib.Folder)
            end
        end)
    end
end

function OrionLib:Destroy()
    if Orion then
        Orion:Destroy()
    end
end

OrionLib:Init()

return OrionLib