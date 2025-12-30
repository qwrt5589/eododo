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
local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
if syn then
    syn.protect_gui(Orion)
    Orion.Parent = game.CoreGui
else
    Orion.Parent = gethui() or game.CoreGui
end
if gethui then
    for _, Interface in ipairs(gethui():GetChildren()) do
        if Interface.Name == Orion.Name and Interface ~= Orion then
            Interface:Destroy()
        end
    end
else
    for _, Interface in ipairs(game.CoreGui:GetChildren()) do
        if Interface.Name == Orion.Name and Interface ~= Orion then
            Interface:Destroy()
        end
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
local function MakeDraggable(DragPoint, Main)
    local Dragging = false
    local DragInput, MousePos, FramePos
    
    DragPoint.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            MousePos = Input.Position
            FramePos = Main.Position
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
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
local function CreateElement(ElementName, ElementFunction)
    OrionLib.Elements[ElementName] = ElementFunction
end
local function MakeElement(ElementName, ...)
    if OrionLib.Elements[ElementName] then
        return OrionLib.Elements[ElementName](...)
    end
    return nil
end
local function SetProps(Element, Props)
    for Property, Value in pairs(Props) do
        Element[Property] = Value
    end
    return Element
end
local function SetChildren(Element, Children)
    for _, Child in ipairs(Children) do
        Child.Parent = Element
    end
    return Element
end
local function ApplyRoundCorners(Object, CornerRadius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, CornerRadius or 8)
    Corner.Parent = Object
    return Corner
end
local function ApplyCapsuleCorners(Object)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = Object
    return Corner
end
CreateElement("Corner", function(CornerRadius)
    return Create("UICorner", {CornerRadius = UDim.new(0, CornerRadius or 8)})
end)
CreateElement("CapsuleCorner", function()
    return Create("UICorner", {CornerRadius = UDim.new(1, 0)})
end)
CreateElement("Stroke", function(Color, Thickness)
    return Create("UIStroke", {
        Color = Color or Color3.fromRGB(255, 255, 255),
        Thickness = Thickness or 1.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
end)
CreateElement("List", function(Padding)
    return Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, Padding or 6)
    })
end)
CreateElement("Padding", function(Left, Right, Top, Bottom)
    return Create("UIPadding", {
        PaddingLeft = UDim.new(0, Left or 12),
        PaddingRight = UDim.new(0, Right or 12),
        PaddingTop = UDim.new(0, Top or 12),
        PaddingBottom = UDim.new(0, Bottom or 12)
    })
end)
CreateElement("TFrame", function()
    return Create("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
end)
CreateElement("RoundFrame", function(Color, CornerRadius, Transparency)
    local Frame = Create("Frame", {
        BackgroundColor3 = Color or Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = Transparency or 0.1,
        BorderSizePixel = 0
    })
    ApplyRoundCorners(Frame, CornerRadius)
    return Frame
end)
CreateElement("Button", function()
    return Create("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
end)
CreateElement("ScrollFrame", function()
    local Scroll = Create("ScrollingFrame", {
        BackgroundTransparency = 1,
        ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
        ScrollBarThickness = 4,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y
    })
    return Scroll
end)
CreateElement("Image", function(ImageId)
    return Create("ImageLabel", {
        Image = ImageId,
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Fit
    })
end)
CreateElement("Label", function(Text, TextSize, Font, Color)
    return Create("TextLabel", {
        Text = Text or "",
        TextSize = TextSize or 14,
        Font = Font or Enum.Font.Gotham,
        TextColor3 = Color or Color3.fromRGB(240, 240, 240),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
end)
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
        NotificationConfig.Name = NotificationConfig.Name or "通知"
        NotificationConfig.Content = NotificationConfig.Content or "内容"
        NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://4384403532"
        NotificationConfig.Time = NotificationConfig.Time or 5
        
        local Notification = Create("Frame", {
            Parent = NotificationHolder,
            Size = UDim2.new(0, 320, 0, 0),
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            BackgroundTransparency = 0.1,
            ClipsDescendants = true,
            LayoutOrder = 999
        })
        
        ApplyRoundCorners(Notification, 10)
        
        local Stroke = Create("UIStroke", {
            Parent = Notification,
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1.5
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
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        })
        
        local Title = Create("TextLabel", {
            Parent = Notification,
            Size = UDim2.new(1, -40, 0, 20),
            Position = UDim2.new(0, 35, 0, 0),
            Text = NotificationConfig.Name,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            TextColor3 = Color3.fromRGB(255, 255, 255),
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
            TextColor3 = Color3.fromRGB(200, 200, 200),
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
    WindowConfig.Name = WindowConfig.Name or "脚本界面"
    WindowConfig.HidePremium = WindowConfig.HidePremium or false
    WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
    WindowConfig.IntroText = WindowConfig.IntroText or "欢迎使用"
    WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or "ScriptConfigs"
    WindowConfig.IntroEnabled = WindowConfig.IntroEnabled or false
    
    OrionLib.Folder = WindowConfig.ConfigFolder
    OrionLib.SaveCfg = WindowConfig.SaveConfig
    
    local FirstTab = true
    local UIHidden = false
    
    local MainWindow = Create("Frame", {
        Name = "MainWindow",
        Parent = Orion,
        Size = UDim2.new(0, 560, 0, 300),
        Position = UDim2.new(0.5, -280, 0.5, -160),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BackgroundTransparency = 0.1,
        ClipsDescendants = true,
        Active = true
    })
    
    ApplyRoundCorners(MainWindow, 15)
    
    local WindowStroke = Create("UIStroke", {
        Parent = MainWindow,
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 2.5,
        Transparency = 0.2
    })
    
    local TopBar = Create("Frame", {
        Parent = MainWindow,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(255, 80, 160),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0
    })
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 15)
    TopBarCorner.Parent = TopBar
    
    local TitleIcon = Create("ImageLabel", {
        Parent = TopBar,
        Size = UDim2.new(0, 85, 0, 85),
        Position = UDim2.new(0, 10, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Image = "rbxassetid://100576379445068",
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Fit
    })
    
    local DragArea = Create("TextButton", {
        Parent = TopBar,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false
    })
    
    MakeDraggable(DragArea, MainWindow)
    
    local SideBar = Create("Frame", {
        Parent = MainWindow,
        Size = UDim2.new(0, 160, 1, -45),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(255, 80, 160),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0
    })
    
    local TabContainer = Create("ScrollingFrame", {
        Parent = SideBar,
        Size = UDim2.new(1, 0, 1, -50),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        BorderSizePixel = 0
    })
    
    local TabList = Create("UIListLayout", {
        Parent = TabContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })
    
    TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y)
    end)
    
    local ContentContainer = Create("Frame", {
        Parent = MainWindow,
        Size = UDim2.new(1, -160, 1, -45),
        Position = UDim2.new(0, 160, 0, 45),
        BackgroundColor3 = Color3.fromRGB(255, 244, 242),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    
    local function CreateDraggableToggle()
        local UIVisible = true
        local ToggleButton = Create("ImageButton", {
            Name = "UIToggle",
            Parent = Orion,
            Size = UDim2.new(0, 34, 0, 34),
            Position = UDim2.new(1, -44, 0, 20),
            AnchorPoint = Vector2.new(1, 0),
            BackgroundColor3 = Color3.fromRGB(255, 80, 160),
            BackgroundTransparency = 0,
            AutoButtonColor = false,
            Image = "rbxassetid://138901519642245",
            ScaleType = Enum.ScaleType.Fit
        })
        
        ApplyRoundCorners(ToggleButton, 8)
        
        Create("UIStroke", {
            Parent = ToggleButton,
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 2
        })
        
        MakeDraggable(ToggleButton, ToggleButton)
        
        ToggleButton.MouseEnter:Connect(function()
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(255, 120, 180)
            }):Play()
        end)
        
        ToggleButton.MouseLeave:Connect(function()
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(255, 80, 160)
            }):Play()
        end)
        
        ToggleButton.MouseButton1Click:Connect(function()
            UIVisible = not UIVisible
            
            if not UIVisible then
                TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }):Play()
                wait(0.3)
                MainWindow.Visible = false
            else
                MainWindow.Visible = true
                TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(0, 560, 0, 320),
                    Position = UDim2.new(0.5, -280, 0.5, -160)
                }):Play()
            end
        end)
        
        return ToggleButton
    end
    
    CreateDraggableToggle()
    
    AddConnection(UserInputService.InputBegan, function(Input)
        if Input.KeyCode == Enum.KeyCode.RightShift and UIHidden then
            MainWindow.Visible = true
            TweenService:Create(MainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 560, 0, 320),
                Position = UDim2.new(0.5, -280, 0.5, -160)
            }):Play()
            UIHidden = false
        end
    end)
    
    local TabFunctions = {}
    
    function TabFunctions:MakeTab(TabConfig)
        TabConfig = TabConfig or {}
        TabConfig.Name = TabConfig.Name or "标签"
        TabConfig.Icon = TabConfig.Icon or ""
        TabConfig.PremiumOnly = TabConfig.PremiumOnly or false
        
        local TabButton = Create("TextButton", {
            Parent = TabContainer,
            Size = UDim2.new(1, -10, 0, 32),
            BackgroundColor3 = Color3.fromRGB(255, 80, 160),
            BackgroundTransparency = 0.2,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = #TabContainer:GetChildren()
        })
        
        ApplyRoundCorners(TabButton, 8)
        
        local TabIcon = TabConfig.Icon ~= "" and Create("ImageLabel", {
            Parent = TabButton,
            Size = UDim2.new(0, 18, 0, 18),
            Position = UDim2.new(0, 8, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Image = TabConfig.Icon,
            BackgroundTransparency = 1,
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        })
        
        local IconOffset = TabConfig.Icon ~= "" and 30 or 12
        local TabName = Create("TextLabel", {
            Parent = TabButton,
            Size = UDim2.new(1, -IconOffset, 1, 0),
            Position = UDim2.new(0, IconOffset - 3, 0, 0),
            Text = TabConfig.Name,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        local TabContent = Create("ScrollingFrame", {
            Parent = ContentContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            BorderSizePixel = 0
        })
        
        local ContentList = Create("UIListLayout", {
            Parent = TabContent,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 7)
        })
        
        local ContentPadding = Create("UIPadding", {
            Parent = TabContent,
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        })
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 20)
        end)
        
        if FirstTab then
            FirstTab = false
            TabButton.BackgroundColor3 = Color3.fromRGB(255, 120, 180)
            if TabIcon then
                TabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
            TabName.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabName.Font = Enum.Font.GothamBold
            TabContent.Visible = true
        end
        
        TabButton.MouseButton1Click:Connect(function()
            for _, Child in ipairs(TabContainer:GetChildren()) do
                if Child:IsA("TextButton") then
                    Child.BackgroundColor3 = Color3.fromRGB(255, 80, 160)
                    local Icon = Child:FindFirstChildOfClass("ImageLabel")
                    if Icon then
                        Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    local NameLabel = Child:FindFirstChildOfClass("TextLabel")
                    if NameLabel then
                        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        NameLabel.Font = Enum.Font.Gotham
                    end
                end
            end
            
            for _, Child in ipairs(ContentContainer:GetChildren()) do
                if Child:IsA("ScrollingFrame") then
                    Child.Visible = false
                end
            end
            
            TabButton.BackgroundColor3 = Color3.fromRGB(255, 120, 180)
            if TabIcon then
                TabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
            TabName.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabName.Font = Enum.Font.GothamBold
            TabContent.Visible = true
        end)
        
        local function CreateElementContainer()
            local Elements = {}
            
            function Elements:AddParagraph(Title, Content)
                local ParagraphContainer = Create("Frame", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 50),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    LayoutOrder = #TabContent:GetChildren()
                })
                
                ApplyRoundCorners(ParagraphContainer, 8)
                
                Create("UIStroke", {
                    Parent = ParagraphContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1,
                    Transparency = 0.3
                })
                
                local TitleLabel = Create("TextLabel", {
                    Parent = ParagraphContainer,
                    Size = UDim2.new(1, -20, 0, 16),
                    Position = UDim2.new(0, 10, 0, 6),
                    Text = Title or "标题",
                    TextSize = 14,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local ContentLabel = Create("TextLabel", {
                    Parent = ParagraphContainer,
                    Size = UDim2.new(1, -20, 0, 24),
                    Position = UDim2.new(0, 10, 0, 26),
                    Text = Content or "内容",
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextColor3 = Color3.fromRGB(120, 120, 120),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true
                })
                
                ContentLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    ParagraphContainer.Size = UDim2.new(1, 0, 0, ContentLabel.TextBounds.Y + 35)
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
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    LayoutOrder = #TabContent:GetChildren()
                })
                
                ApplyRoundCorners(LabelContainer, 8)
                
                Create("UIStroke", {
                    Parent = LabelContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1,
                    Transparency = 0.3
                })
                
                local Label = Create("TextLabel", {
                    Parent = LabelContainer,
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Text = Text or "标签",
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local LabelFunction = {}
                function LabelFunction:Set(NewText)
                    Label.Text = NewText
                end
                
                return LabelFunction
            end
            
            function Elements:AddButton(ButtonConfig)
                ButtonConfig = ButtonConfig or {}
                ButtonConfig.Name = ButtonConfig.Name or "按钮"
                ButtonConfig.Callback = ButtonConfig.Callback or function() end
                
                local ButtonContainer = Create("TextButton", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = #TabContent:GetChildren()
                })
                
                ApplyCapsuleCorners(ButtonContainer)
                
                local ButtonStroke = Create("UIStroke", {
                    Parent = ButtonContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1.5,
                    Transparency = 0.3
                })
                
                local ButtonLabel = Create("TextLabel", {
                    Parent = ButtonContainer,
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Text = ButtonConfig.Name,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local ButtonIcon = Create("ImageLabel", {
                    Parent = ButtonContainer,
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(1, -26, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://3944703587",
                    BackgroundTransparency = 1,
                    ImageColor3 = Color3.fromRGB(255, 80, 160)
                })
                
                ButtonContainer.MouseEnter:Connect(function()
                    TweenService:Create(ButtonContainer, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(255, 180, 200)
                    }):Play()
                    TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {
                        Transparency = 0.1
                    }):Play()
                end)
                
                ButtonContainer.MouseLeave:Connect(function()
                    TweenService:Create(ButtonContainer, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(255, 200, 220)
                    }):Play()
                    TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {
                        Transparency = 0.3
                    }):Play()
                end)
                
                ButtonContainer.MouseButton1Down:Connect(function()
                    TweenService:Create(ButtonContainer, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(255, 160, 190)
                    }):Play()
                end)
                
                ButtonContainer.MouseButton1Up:Connect(function()
                    TweenService:Create(ButtonContainer, TweenInfo.new(0.1), {
                        BackgroundColor3 = Color3.fromRGB(255, 180, 200)
                    }):Play()
                    wait(0.1)
                    TweenService:Create(ButtonContainer, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(255, 200, 220)
                    }):Play()
                    pcall(ButtonConfig.Callback)
                end)
                
                local ButtonFunction = {}
                function ButtonFunction:Set(NewText)
                    ButtonLabel.Text = NewText
                end
                
                return ButtonFunction
            end
            function Elements:AddToggle(ToggleConfig)
                ToggleConfig = ToggleConfig or {}
                ToggleConfig.Name = ToggleConfig.Name or "开关"
                ToggleConfig.Default = ToggleConfig.Default or false
                ToggleConfig.Callback = ToggleConfig.Callback or function() end
                ToggleConfig.Flag = ToggleConfig.Flag or nil
                ToggleConfig.Save = ToggleConfig.Save or false
                
                local Toggle = {Value = ToggleConfig.Default, Save = ToggleConfig.Save}
                
                local ToggleContainer = Create("TextButton", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = #TabContent:GetChildren()
                })
                
                ApplyCapsuleCorners(ToggleContainer)
                
                local ToggleStroke = Create("UIStroke", {
                    Parent = ToggleContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1.5,
                    Transparency = 0.3
                })
                
                local ToggleLabel = Create("TextLabel", {
                    Parent = ToggleContainer,
                    Size = UDim2.new(1, -70, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Text = ToggleConfig.Name,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local ToggleBox = Create("Frame", {
                    Parent = ToggleContainer,
                    Size = UDim2.new(0, 21, 0, 21),
                    Position = UDim2.new(1, -31, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = Toggle.Value and Color3.fromRGB(255, 80, 160) or Color3.fromRGB(220, 180, 200),
                    BackgroundTransparency = 0
                })
                
                ApplyCapsuleCorners(ToggleBox)
                
                local ToggleIcon = Create("ImageLabel", {
                    Parent = ToggleBox,
                    Size = UDim2.new(0, 12, 0, 12),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Image = "rbxassetid://3944680095",
                    BackgroundTransparency = 1,
                    ImageColor3 = Color3.fromRGB(255, 255, 255),
                    ImageTransparency = Toggle.Value and 0 or 1
                })
                
                function Toggle:Set(Value)
                    self.Value = Value
                    TweenService:Create(ToggleBox, TweenInfo.new(0.2), {
                        BackgroundColor3 = self.Value and Color3.fromRGB(255, 80, 160) or Color3.fromRGB(220, 180, 200)
                    }):Play()
                    TweenService:Create(ToggleIcon, TweenInfo.new(0.2), {
                        ImageTransparency = self.Value and 0 or 1
                    }):Play()
                    ToggleConfig.Callback(self.Value)
                end
                
                Toggle:Set(Toggle.Value)
                
                ToggleContainer.MouseButton1Click:Connect(function()
                    Toggle:Set(not Toggle.Value)
                end)
                
                if ToggleConfig.Flag then
                    OrionLib.Flags[ToggleConfig.Flag] = Toggle
                end
                
                return Toggle
            end
            
            function Elements:AddSlider(SliderConfig)
                SliderConfig = SliderConfig or {}
                SliderConfig.Name = SliderConfig.Name or "滑块"
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
                    Size = UDim2.new(1, 0, 0, 58),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    LayoutOrder = #TabContent:GetChildren()
                })
                
                ApplyRoundCorners(SliderContainer, 8)
                
                Create("UIStroke", {
                    Parent = SliderContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1.5,
                    Transparency = 0.3
                })
                
                local SliderLabel = Create("TextLabel", {
                    Parent = SliderContainer,
                    Size = UDim2.new(1, -20, 0, 16),
                    Position = UDim2.new(0, 10, 0, 5),
                    Text = SliderConfig.Name,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local SliderValue = Create("TextLabel", {
                    Parent = SliderContainer,
                    Size = UDim2.new(0, 40, 0, 16),
                    Position = UDim2.new(1, -50, 0, 5),
                    Text = tostring(Slider.Value) .. SliderConfig.ValueName,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Right
                })
                
                local SliderBar = Create("Frame", {
                    Parent = SliderContainer,
                    Size = UDim2.new(1, -20, 0, 7),
                    Position = UDim2.new(0, 10, 0, 33),
                    BackgroundColor3 = Color3.fromRGB(220, 180, 200),
                    BackgroundTransparency = 0
                })
                
                ApplyCapsuleCorners(SliderBar)
                
                local SliderFill = Create("Frame", {
                    Parent = SliderBar,
                    Size = UDim2.new((Slider.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 80, 160),
                    BackgroundTransparency = 0
                })
                
                ApplyCapsuleCorners(SliderFill)
                
                local SliderHandle = Create("Frame", {
                    Parent = SliderBar,
                    Size = UDim2.new(0, 12, 0, 12),
                    Position = UDim2.new((Slider.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 80, 160),
                    BackgroundTransparency = 0
                })
                
                ApplyCapsuleCorners(SliderHandle)
                
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
            
            function Elements:AddDropdown(DropdownConfig)
                DropdownConfig = DropdownConfig or {}
                DropdownConfig.Name = DropdownConfig.Name or "下拉菜单"
                DropdownConfig.Options = DropdownConfig.Options or {"选项1", "选项2", "选项3"}
                DropdownConfig.Default = DropdownConfig.Default or DropdownConfig.Options[1]
                DropdownConfig.Callback = DropdownConfig.Callback or function() end
                DropdownConfig.Flag = DropdownConfig.Flag or nil
                DropdownConfig.Save = DropdownConfig.Save or false
                
                local Dropdown = {
                    Value = DropdownConfig.Default,
                    Options = DropdownConfig.Options,
                    Toggled = false,
                    Save = DropdownConfig.Save
                }
                
                local DropdownContainer = Create("TextButton", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = #TabContent:GetChildren(),
                    ClipsDescendants = true
                })
                
                ApplyCapsuleCorners(DropdownContainer)
                
                local DropdownStroke = Create("UIStroke", {
                    Parent = DropdownContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1.5,
                    Transparency = 0.3
                })
                
                local DropdownLabel = Create("TextLabel", {
                    Parent = DropdownContainer,
                    Size = UDim2.new(1, -50, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Text = DropdownConfig.Name,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local DropdownValue = Create("TextLabel", {
                    Parent = DropdownContainer,
                    Size = UDim2.new(0, 30, 0, 16),
                    Position = UDim2.new(1, -40, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Text = Dropdown.Value,
                    TextSize = 10,
                    Font = Enum.Font.Gotham,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Right
                })
                
                local DropdownIcon = Create("ImageLabel", {
                    Parent = DropdownContainer,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(1, -15, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://7072706796",
                    BackgroundTransparency = 1,
                    ImageColor3 = Color3.fromRGB(255, 80, 160),
                    Rotation = 0
                })
                
                local OptionsContainer = Create("Frame", {
                    Parent = DropdownContainer,
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 1, 5),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    Visible = false,
                    ClipsDescendants = true
                })
                
                ApplyCapsuleCorners(OptionsContainer)
                
                local OptionsList = Create("UIListLayout", {
                    Parent = OptionsContainer,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 2)
                })
                
                function Dropdown:Refresh(Options)
                    self.Options = Options or self.Options
                    for _, Child in ipairs(OptionsContainer:GetChildren()) do
                        if Child:IsA("TextButton") then
                            Child:Destroy()
                        end
                    end
                    
                    for i, Option in ipairs(self.Options) do
                        local OptionButton = Create("TextButton", {
                            Parent = OptionsContainer,
                            Size = UDim2.new(1, 0, 0, 30),
                            BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                            BackgroundTransparency = 0.1,
                            Text = "",
                            AutoButtonColor = false,
                            LayoutOrder = i
                        })
                        
                        ApplyCapsuleCorners(OptionButton)
                        
                        local OptionLabel = Create("TextLabel", {
                            Parent = OptionButton,
                            Size = UDim2.new(1, -20, 1, 0),
                            Position = UDim2.new(0, 10, 0, 0),
                            Text = Option,
                            TextSize = 11,
                            Font = Enum.Font.Gotham,
                            TextColor3 = Color3.fromRGB(80, 80, 80),
                            BackgroundTransparency = 1,
                            TextXAlignment = Enum.TextXAlignment.Left
                        })
                        
                        OptionButton.MouseEnter:Connect(function()
                            TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                                BackgroundColor3 = Color3.fromRGB(255, 180, 200)
                            }):Play()
                        end)
                        
                        OptionButton.MouseLeave:Connect(function()
                            TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                                BackgroundColor3 = Color3.fromRGB(255, 200, 220)
                            }):Play()
                        end)
                        
                        OptionButton.MouseButton1Click:Connect(function()
                            self.Value = Option
                            DropdownValue.Text = Option
                            self.Toggled = false
                            OptionsContainer.Visible = false
                            TweenService:Create(DropdownIcon, TweenInfo.new(0.2), {
                                Rotation = 0
                            }):Play()
                            DropdownConfig.Callback(Option)
                        end)
                    end
                    
                    OptionsList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                        OptionsContainer.Size = UDim2.new(1, 0, 0, OptionsList.AbsoluteContentSize.Y)
                    end)
                end
                
                function Dropdown:Set(Value)
                    self.Value = Value
                    DropdownValue.Text = Value
                    DropdownConfig.Callback(Value)
                end
                
                Dropdown:Refresh()
                
                DropdownContainer.MouseButton1Click:Connect(function()
                    Dropdown.Toggled = not Dropdown.Toggled
                    OptionsContainer.Visible = Dropdown.Toggled
                    TweenService:Create(DropdownIcon, TweenInfo.new(0.2), {
                        Rotation = Dropdown.Toggled and 180 or 0
                    }):Play()
                end)
                
                if DropdownConfig.Flag then
                    OrionLib.Flags[DropdownConfig.Flag] = Dropdown
                end
                
                return Dropdown
            end
            
            function Elements:AddTextbox(TextboxConfig)
                TextboxConfig = TextboxConfig or {}
                TextboxConfig.Name = TextboxConfig.Name or "文本框"
                TextboxConfig.Default = TextboxConfig.Default or ""
                TextboxConfig.Placeholder = TextboxConfig.Placeholder or "输入文本..."
                TextboxConfig.ClearTextOnFocus = TextboxConfig.ClearTextOnFocus or false
                TextboxConfig.Callback = TextboxConfig.Callback or function() end
                
                local TextboxContainer = Create("Frame", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    LayoutOrder = #TabContent:GetChildren()
                })
                
                ApplyRoundCorners(TextboxContainer, 8)
                
                Create("UIStroke", {
                    Parent = TextboxContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1.5,
                    Transparency = 0.3
                })
                
                local TextboxLabel = Create("TextLabel", {
                    Parent = TextboxContainer,
                    Size = UDim2.new(1, -140, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Text = TextboxConfig.Name,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local TextboxInput = Create("TextBox", {
                    Parent = TextboxContainer,
                    Size = UDim2.new(0, 110, 0, 26),
                    Position = UDim2.new(1, -120, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Text = TextboxConfig.Default,
                    PlaceholderText = TextboxConfig.Placeholder,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
                    BackgroundColor3 = Color3.fromRGB(255, 220, 230),
                    BackgroundTransparency = 0,
                    ClearTextOnFocus = TextboxConfig.ClearTextOnFocus,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                ApplyCapsuleCorners(TextboxInput)
                
                Create("UIStroke", {
                    Parent = TextboxInput,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1
                })
                
                TextboxInput.Focused:Connect(function()
                    TweenService:Create(TextboxInput, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(255, 230, 240)
                    }):Play()
                end)
                
                TextboxInput.FocusLost:Connect(function()
                    TweenService:Create(TextboxInput, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(255, 220, 230)
                    }):Play()
                    TextboxConfig.Callback(TextboxInput.Text)
                end)
                
                local TextboxFunction = {}
                function TextboxFunction:Set(Value)
                    TextboxInput.Text = Value
                    TextboxConfig.Callback(Value)
                end
                
                function TextboxFunction:Get()
                    return TextboxInput.Text
                end
                
                return TextboxFunction
            end
            
            function Elements:AddColorpicker(ColorpickerConfig)
                ColorpickerConfig = ColorpickerConfig or {}
                ColorpickerConfig.Name = ColorpickerConfig.Name or "颜色选择"
                ColorpickerConfig.Default = ColorpickerConfig.Default or Color3.fromRGB(255, 0, 0)
                ColorpickerConfig.Callback = ColorpickerConfig.Callback or function() end
                
                local Colorpicker = {Value = ColorpickerConfig.Default}
                
                local ColorpickerContainer = Create("TextButton", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = #TabContent:GetChildren(),
                    ClipsDescendants = true
                })
                
                ApplyRoundCorners(ColorpickerContainer, 8)
                
                Create("UIStroke", {
                    Parent = ColorpickerContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1.5,
                    Transparency = 0.3
                })
                
                local ColorpickerLabel = Create("TextLabel", {
                    Parent = ColorpickerContainer,
                    Size = UDim2.new(1, -70, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Text = ColorpickerConfig.Name,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local ColorBox = Create("Frame", {
                    Parent = ColorpickerContainer,
                    Size = UDim2.new(0, 26, 0, 26),
                    Position = UDim2.new(1, -33, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = Colorpicker.Value,
                    BackgroundTransparency = 0
                })
                
                ApplyCapsuleCorners(ColorBox)
                
                Create("UIStroke", {
                    Parent = ColorBox,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 2
                })
                
                function Colorpicker:Set(Color)
                    self.Value = Color
                    ColorBox.BackgroundColor3 = Color
                    ColorpickerConfig.Callback(Color)
                end
                
                ColorpickerContainer.MouseButton1Click:Connect(function()
                    Colorpicker:Set(Color3.fromRGB(
                        math.random(0, 255),
                        math.random(0, 255),
                        math.random(0, 255)
                    ))
                end)
                
                return Colorpicker
            end
            
            function Elements:AddBind(BindConfig)
                BindConfig = BindConfig or {}
                BindConfig.Name = BindConfig.Name or "按键绑定"
                BindConfig.Default = BindConfig.Default or Enum.KeyCode.E
                BindConfig.Hold = BindConfig.Hold or false
                BindConfig.Callback = BindConfig.Callback or function() end
                
                local Bind = {Value = BindConfig.Default, Binding = false}
                
                local BindContainer = Create("TextButton", {
                    Parent = TabContent,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Color3.fromRGB(255, 200, 220),
                    BackgroundTransparency = 0.1,
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = #TabContent:GetChildren()
                })
                
                ApplyRoundCorners(BindContainer, 8)
                
                Create("UIStroke", {
                    Parent = BindContainer,
                    Color = Color3.fromRGB(255, 80, 160),
                    Thickness = 1.5,
                    Transparency = 0.3
                })
                
                local BindLabel = Create("TextLabel", {
                    Parent = BindContainer,
                    Size = UDim2.new(1, -120, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    Text = BindConfig.Name,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local BindKey = Create("TextLabel", {
                    Parent = BindContainer,
                    Size = UDim2.new(0, 65, 0, 21),
                    Position = UDim2.new(1, -75, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Text = tostring(Bind.Value):gsub("Enum.KeyCode.", ""),
                    TextSize = 10,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(80, 80, 80),
                    BackgroundColor3 = Color3.fromRGB(255, 220, 230),
                    BackgroundTransparency = 0,
                    TextXAlignment = Enum.TextXAlignment.Center
                })
                
                ApplyCapsuleCorners(BindKey)
                
                function Bind:Set(Key)
                    self.Value = Key
                    BindKey.Text = tostring(Key):gsub("Enum.KeyCode.", "")
                end
                
                BindContainer.MouseButton1Click:Connect(function()
                    Bind.Binding = true
                    BindKey.Text = "..."
                    BindKey.BackgroundColor3 = Color3.fromRGB(255, 180, 200)
                end)
                
                AddConnection(UserInputService.InputBegan, function(Input)
                    if Bind.Binding then
                        if Input.UserInputType == Enum.UserInputType.Keyboard then
                            Bind:Set(Input.KeyCode)
                            Bind.Binding = false
                            BindKey.BackgroundColor3 = Color3.fromRGB(255, 220, 230)
                        end
                    elseif Input.KeyCode == Bind.Value then
                        BindConfig.Callback()
                    end
                end)
                
                return Bind
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
return OrionLib
