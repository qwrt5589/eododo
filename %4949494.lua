local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(173, 216, 230)
local CloseBind = Enum.KeyCode.RightControl
local uiVisible = true

local ui = Instance.new("ScreenGui")
ui.Name = "ModernBlueUI"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ui.ResetOnSpawn = false

local ControlUI = Instance.new("ScreenGui")
ControlUI.Name = "ControlUI"
ControlUI.Parent = game.CoreGui
ControlUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ControlButton = Instance.new("ImageButton")
local ControlButtonCorner = Instance.new("UICorner")

ControlButton.Name = "ControlButton"
ControlButton.Parent = ControlUI
ControlButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ControlButton.BackgroundTransparency = 1.0
ControlButton.Position = UDim2.new(0.02, 0, 0.02, 0)
ControlButton.Size = UDim2.new(0, 50, 0, 50)
ControlButton.Image = "rbxassetid://133484150725261"
ControlButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
ControlButton.ScaleType = Enum.ScaleType.Fit
ControlButton.AutoButtonColor = false
ControlButton.Draggable = true

ControlButtonCorner.CornerRadius = UDim.new(0, 12)
ControlButtonCorner.Parent = ControlButton

ControlButton.MouseEnter:Connect(
    function()
        TweenService:Create(
            ControlButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageTransparency = 0.2}
        ):Play()
    end
)
ControlButton.MouseLeave:Connect(
    function()
        TweenService:Create(
            ControlButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageTransparency = 0.0}
        ):Play()
    end
)

coroutine.wrap(
    function()
        while wait() do
            lib.RainbowColorValue = lib.RainbowColorValue + 1 / 255
            lib.HueSelectionPosition = lib.HueSelectionPosition + 1
            if lib.RainbowColorValue >= 1 then
                lib.RainbowColorValue = 0
            end
            if lib.HueSelectionPosition == 80 then
                lib.HueSelectionPosition = 0
            end
        end
    end
)()

local function CreateShadow(frame)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = frame
    Shadow.BackgroundTransparency = 1
    Shadow.BorderSizePixel = 0
    Shadow.Size = UDim2.new(1, 12, 1, 12)
    Shadow.Position = UDim2.new(0, -6, 0, -6)
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.88
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.ZIndex = frame.ZIndex - 1
    return Shadow
end

local function ApplyCornerRadius(frame, radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, radius)
    Corner.Parent = frame
    return Corner
end

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil
    
    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        object.Position = pos
    end
    
    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position
                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )
    
    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
             then
                DragInput = input
            end
        end
    )
    
    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

function lib:Window(text, preset, closebind)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(173, 216, 230)
    local firstTab = true

    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainStroke = Instance.new("UIStroke")
    local TabHold = Instance.new("Frame")
    local TabHoldCorner = Instance.new("UICorner")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TitleCorner = Instance.new("UICorner")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")

    CreateShadow(Main)
    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(240, 248, 255)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true
    Main.ZIndex = 2

    MainCorner = ApplyCornerRadius(Main, 12)
    MainStroke.Thickness = 2
    MainStroke.Color = Color3.fromRGB(173, 216, 230)
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = Main

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(225, 245, 254)
    TabHold.BackgroundTransparency = 0.2
    TabHold.Position = UDim2.new(0.0339285731, 0, 0.147335425, 0)
    TabHold.Size = UDim2.new(0, 107, 0, 254)
    TabHoldCorner = ApplyCornerRadius(TabHold, 8)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 8)

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundColor3 = Color3.fromRGB(187, 222, 251)
    Title.BackgroundTransparency = 0.1
    Title.Position = UDim2.new(0.0339285731, 0, 0.0564263314, 0)
    Title.Size = UDim2.new(0, 200, 0, 28)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = "  " .. text
    Title.TextColor3 = Color3.fromRGB(30, 80, 120)
    Title.TextSize = 14.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    TitleCorner = ApplyCornerRadius(Title, 8)

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(0, 580, 0, 45)
    MakeDraggable(DragFrame, Main)

    ControlButton.MouseButton1Click:Connect(
        function()
            if uiVisible then
                uiVisible = false
                Main:TweenSize(
                    UDim2.new(0, 0, 0, 0), 
                    Enum.EasingDirection.Out, 
                    Enum.EasingStyle.Quart, 
                    0.5, 
                    true
                )
                TweenService:Create(
                    ControlButton,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Rotation = 180}
                ):Play()
            else
                uiVisible = true
                Main:TweenSize(
                    UDim2.new(0, 580, 0, 350),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.5,
                    true
                )
                TweenService:Create(
                    ControlButton,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Rotation = 0}
                ):Play()
            end
        end
    )

    Main:TweenSize(UDim2.new(0, 580, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.6, true)

    local uitoggled = false
    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                if uitoggled == false then
                    uitoggled = true
                    uiVisible = false
                    Main:TweenSize(
                        UDim2.new(0, 0, 0, 0), 
                        Enum.EasingDirection.Out, 
                        Enum.EasingStyle.Quart, 
                        0.5, 
                        true, 
                        function()
                            ui.Enabled = false
                        end
                    )
                    TweenService:Create(
                        ControlButton,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 180}
                    ):Play()
                else
                    uitoggled = false
                    uiVisible = true
                    ui.Enabled = true
                    Main:TweenSize(
                        UDim2.new(0, 580, 0, 350),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        0.5,
                        true
                    )
                    TweenService:Create(
                        ControlButton,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 0}
                    ):Play()
                end
            end
        end
    )

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    function lib:ChangePresetColor(toch)
        PresetColor = toch
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local NotificationCorner = Instance.new("UICorner")
        local NotificationShadow = Instance.new("ImageLabel")
        local OkayBtn = Instance.new("TextButton")
        local OkayBtnCorner = Instance.new("UICorner")
        local OkayBtnTitle = Instance.new("TextLabel")
        local NotificationTitle = Instance.new("TextLabel")
        local NotificationDesc = Instance.new("TextLabel")

        NotificationShadow = CreateShadow(NotificationFrame)

        NotificationHold.Name = "NotificationHold"
        NotificationHold.Parent = Main
        NotificationHold.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.BackgroundTransparency = 1.000
        NotificationHold.BorderSizePixel = 0
        NotificationHold.Size = UDim2.new(0, 580, 0, 350)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000
        NotificationHold.ZIndex = 10

        TweenService:Create(
            NotificationHold,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.5}
        ):Play()
        wait(0.4)

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(240, 248, 255)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.498432577, 0)
        NotificationFrame.ZIndex = 11
        NotificationCorner = ApplyCornerRadius(NotificationFrame, 12)
        NotificationFrame:TweenSize(
            UDim2.new(0, 200, 0, 220),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0, 160, 0, 40)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtn.TextSize = 14.000
        OkayBtn.ZIndex = 12

        OkayBtnCorner.CornerRadius = UDim.new(0, 8)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.GothamSemibold
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14.000
        OkayBtnTitle.ZIndex = 13

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.05, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0.9, 0, 0.2, 0)
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(30, 80, 120)
        NotificationTitle.TextSize = 16.000
        NotificationTitle.ZIndex = 12

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.05, 0, 0.3, 0)
        NotificationDesc.Size = UDim2.new(0.9, 0, 0.4, 0)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(60, 100, 140)
        NotificationDesc.TextSize = 13.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top
        NotificationDesc.ZIndex = 12

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(120, 200, 255)}
                ):Play()
            end
        )
        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(100, 180, 255)}
                ):Play()
            end
        )

        OkayBtn.MouseButton1Click:Connect(
            function()
                NotificationFrame:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.4,
                    true
                )
                wait(0.4)
                TweenService:Create(
                    NotificationHold,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                wait(0.2)
                NotificationHold:Destroy()
            end
        )
    end

    local tabhold = {}
    function tabhold:Tab(text)
        local TabBtn = Instance.new("TextButton")
        local TabBtnCorner = Instance.new("UICorner")
        local TabBtnStroke = Instance.new("UIStroke")
        local TabTitle = Instance.new("TextLabel")
        local TabBtnIndicator = Instance.new("Frame")
        local TabBtnIndicatorCorner = Instance.new("UICorner")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHold
        TabBtn.BackgroundColor3 = Color3.fromRGB(225, 245, 254)
        TabBtn.BackgroundTransparency = 0.5
        TabBtn.Size = UDim2.new(0, 107, 0, 32)
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        TabBtn.AutoButtonColor = false

        TabBtnCorner = ApplyCornerRadius(TabBtn, 6)
        TabBtnStroke.Thickness = 1
        TabBtnStroke.Color = Color3.fromRGB(187, 222, 251)
        TabBtnStroke.Parent = TabBtn

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(1, 0, 1, 0)
        TabTitle.Font = Enum.Font.GothamMedium
        TabTitle.Text = "  " .. text
        TabTitle.TextColor3 = Color3.fromRGB(60, 100, 140)
        TabTitle.TextSize = 13.000
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 1, 0)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 3)

        TabBtnIndicatorCorner.CornerRadius = UDim.new(0, 2)
        TabBtnIndicatorCorner.Name = "TabBtnIndicatorCorner"
        TabBtnIndicatorCorner.Parent = TabBtnIndicator

        TabBtn.MouseEnter:Connect(
            function()
                if TabBtnIndicator.Size ~= UDim2.new(0, 107, 0, 3) then
                    TweenService:Create(
                        TabBtn,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.3}
                    ):Play()
                    TweenService:Create(
                        TabBtnStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(100, 180, 255)}
                    ):Play()
                    TweenService:Create(
                        TabTitle,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(30, 80, 120)}
                    ):Play()
                end
            end
        )
        TabBtn.MouseLeave:Connect(
            function()
                if TabBtnIndicator.Size ~= UDim2.new(0, 107, 0, 3) then
                    TweenService:Create(
                        TabBtn,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.5}
                    ):Play()
                    TweenService:Create(
                        TabBtnStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(187, 222, 251)}
                    ):Play()
                    TweenService:Create(
                        TabTitle,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(60, 100, 140)}
                    ):Play()
                end
            end
        )

        local Tab = Instance.new("ScrollingFrame")
        local TabCorner = Instance.new("UICorner")
        local TabLayout = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")
        local TabStroke = Instance.new("UIStroke")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(225, 245, 254)
        Tab.BackgroundTransparency = 0.2
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.31400001, 0, 0.147, 0)
        Tab.Size = UDim2.new(0, 400, 0, 254)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = Color3.fromRGB(173, 216, 230)
        Tab.Visible = false

        TabCorner = ApplyCornerRadius(Tab, 8)
        TabStroke.Thickness = 1
        TabStroke.Color = Color3.fromRGB(187, 222, 251)
        TabStroke.Parent = Tab

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)
        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingLeft = UDim.new(0, 8)
        TabPadding.PaddingTop = UDim.new(0, 8)

        if firstTab then
            firstTab = false
            TabBtnIndicator.Size = UDim2.new(0, 107, 0, 3)
            TabTitle.TextColor3 = Color3.fromRGB(30, 80, 120)
            TabBtn.BackgroundTransparency = 0.2
            TabBtnStroke.Color = Color3.fromRGB(100, 180, 255)
            Tab.Visible = true
        end

        TabBtn.MouseButton1Click:Connect(
            function()
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "Tab" then
                        v.Visible = false
                    end
                end
                Tab.Visible = true

                for i, v in next, TabHold:GetChildren() do
                    if v.Name == "TabBtn" then
                        v.TabBtnIndicator:TweenSize(
                            UDim2.new(0, 0, 0, 3),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            v,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0.5}
                        ):Play()
                        TweenService:Create(
                            v.TabBtnStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = Color3.fromRGB(187, 222, 251)}
                        ):Play()
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(60, 100, 140)}
                        ):Play()
                    end
                end

                TabBtnIndicator:TweenSize(
                    UDim2.new(0, 107, 0, 3),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.2,
                    true
                )
                TweenService:Create(
                    TabBtn,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0.2}
                ):Play()
                TweenService:Create(
                    TabBtnStroke,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Color = Color3.fromRGB(100, 180, 255)}
                ):Play()
                TweenService:Create(
                    TabTitle,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {TextColor3 = Color3.fromRGB(30, 80, 120)}
                ):Play()
            end
        )

        local tabcontent = {}

        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonStroke = Instance.new("UIStroke")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
            Button.Size = UDim2.new(0, 384, 0, 42)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button
            ButtonStroke.Thickness = 1
            ButtonStroke.Color = Color3.fromRGB(187, 222, 251)
            ButtonStroke.Parent = Button

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Size = UDim2.new(1, 0, 1, 0)
            ButtonTitle.Font = Enum.Font.GothamMedium
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(30, 80, 120)
            ButtonTitle.TextSize = 13.000

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(100, 180, 255)}
                    ):Play()
                    TweenService:Create(
                        ButtonStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(120, 200, 255)}
                    ):Play()
                    TweenService:Create(
                        ButtonTitle,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                end
            )
            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(173, 216, 230)}
                    ):Play()
                    TweenService:Create(
                        ButtonStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(187, 222, 251)}
                    ):Play()
                    TweenService:Create(
                        ButtonTitle,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(30, 80, 120)}
                    ):Play()
                end
            )

            Button.MouseButton1Click:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(120, 200, 255)}
                    ):Play()
                    wait(0.1)
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(173, 216, 230)}
                    ):Play()
                    pcall(callback)
                end
            )

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
            return Button
        end

        function tabcontent:Toggle(text, default, callback)
            local toggled = default or false

            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleStroke = Instance.new("UIStroke")
            local ToggleSwitch = Instance.new("Frame")
            local ToggleSwitchCorner = Instance.new("UICorner")
            local ToggleCircle = Instance.new("Frame")
            local ToggleCircleCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
            Toggle.Size = UDim2.new(0, 384, 0, 42)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle
            ToggleStroke.Thickness = 1
            ToggleStroke.Color = Color3.fromRGB(187, 222, 251)
            ToggleStroke.Parent = Toggle

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleTitle.Font = Enum.Font.GothamMedium
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(30, 80, 120)
            ToggleTitle.TextSize = 13.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleSwitch.Name = "ToggleSwitch"
            ToggleSwitch.Parent = Toggle
            ToggleSwitch.BackgroundColor3 = Color3.fromRGB(187, 222, 251)
            ToggleSwitch.Position = UDim2.new(0.85, 0, 0.3, 0)
            ToggleSwitch.Size = UDim2.new(0, 40, 0, 20)
            ToggleSwitchCorner.CornerRadius = UDim.new(1, 0)
            ToggleSwitchCorner.Parent = ToggleSwitch

            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleSwitch
            ToggleCircle.BackgroundColor3 = toggled and Color3.fromRGB(100, 180, 255) or Color3.fromRGB(150, 200, 230)
            ToggleCircle.Position = toggled and UDim2.new(0.5, 0, 0.1, 0) or UDim2.new(0.1, 0, 0.1, 0)
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Parent = ToggleCircle

            Toggle.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(187, 222, 251)}
                    ):Play()
                    TweenService:Create(
                        ToggleStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(100, 180, 255)}
                    ):Play()
                end
            )
            Toggle.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(173, 216, 230)}
                    ):Play()
                    TweenService:Create(
                        ToggleStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(187, 222, 251)}
                    ):Play()
                end
            )

            Toggle.MouseButton1Click:Connect(
                function()
                    toggled = not toggled
                    if toggled then
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(100, 180, 255)}
                        ):Play()
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.5, 0, 0.1, 0)}
                        ):Play()
                        TweenService:Create(
                            ToggleSwitch,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(120, 200, 255)}
                        ):Play()
                    else
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(150, 200, 230)}
                        ):Play()
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.1, 0, 0.1, 0)}
                        ):Play()
                        TweenService:Create(
                            ToggleSwitch,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(187, 222, 251)}
                        ):Play()
                    end
                    pcall(callback, toggled)
                end
            )

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
            return Toggle
        end

        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local Slider = Instance.new("Frame")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SliderStroke = Instance.new("UIStroke")
            local SlideFrame = Instance.new("Frame")
            local SlideFrameCorner = Instance.new("UICorner")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
            Slider.Size = UDim2.new(0, 384, 0, 70)

            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider
            SliderStroke.Thickness = 1
            SliderStroke.Color = Color3.fromRGB(187, 222, 251)
            SliderStroke.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.03, 0, 0.1, 0)
            SliderTitle.Size = UDim2.new(0.7, 0, 0.3, 0)
            SliderTitle.Font = Enum.Font.GothamMedium
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(30, 80, 120)
            SliderTitle.TextSize = 13.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.7, 0, 0.1, 0)
            SliderValue.Size = UDim2.new(0.27, 0, 0.3, 0)
            SliderValue.Font = Enum.Font.GothamMedium
            SliderValue.Text = tostring(start and math.floor(start) or min)
            SliderValue.TextColor3 = Color3.fromRGB(60, 100, 140)
            SliderValue.TextSize = 13.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(187, 222, 251)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.03, 0, 0.65, 0)
            SlideFrame.Size = UDim2.new(0.94, 0, 0, 4)
            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or min) / max, 0, 1, 0)
            CurrentValueCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or min) / max, -8, -1.5, 0)
            SlideCircle.Size = UDim2.new(0, 16, 0, 16)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = Color3.fromRGB(100, 180, 255)
            SlideCircle.ScaleType = Enum.ScaleType.Fit

            local function move(input)
                local scale = math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1)
                local pos = UDim2.new(scale, -8, -1.5, 0)
                local pos1 = UDim2.new(scale, 0, 0, 4)
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(scale * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end

            SlideCircle.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end
            )
            SlideCircle.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end
            )
            UserInputService.InputChanged:Connect(
                function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        move(input)
                    end
                end
            )

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
            return Slider
        end

        function tabcontent:Label(text)
            local Label = Instance.new("Frame")
            local LabelCorner = Instance.new("UICorner")
            local LabelStroke = Instance.new("UIStroke")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(225, 245, 254)
            Label.Size = UDim2.new(0, 384, 0, 32)

            LabelCorner.CornerRadius = UDim.new(0, 8)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label
            LabelStroke.Thickness = 1
            LabelStroke.Color = Color3.fromRGB(187, 222, 251)
            LabelStroke.Parent = Label

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(1, 0, 1, 0)
            LabelTitle.Font = Enum.Font.GothamMedium
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(60, 100, 140)
            LabelTitle.TextSize = 13.000

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
            return Label
        end

        return tabcontent
    end

    return tabhold
end

return lib
