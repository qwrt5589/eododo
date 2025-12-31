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

-- 优化性能：缓存常用服务
local UserInputService = services.UserInputService
local RunService = services.RunService

-- 优化Tween函数
function Tween(obj, t, data)
    local tween = TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data)
    tween:Play()
    return tween
end

-- 优化Ripple效果，减少垃圾回收
local rippleCache = {}
function createRipple()
    local ripple = Instance.new("ImageLabel")
    ripple.Name = "Ripple"
    ripple.BackgroundColor3 = Color3.fromRGB(255,255,255)
    ripple.BackgroundTransparency = 1.000
    ripple.ZIndex = 8
    ripple.Image = "rbxassetid://82255019023654"
    ripple.ImageTransparency = 0.800
    ripple.ScaleType = Enum.ScaleType.Fit
    ripple.ImageColor3 = Color3.fromRGB(255,255,255)
    return ripple
end

function Ripple(obj)
    if obj.ClipsDescendants ~= true then
        obj.ClipsDescendants = true
    end
    
    local Ripple
    if #rippleCache > 0 then
        Ripple = table.remove(rippleCache)
    else
        Ripple = createRipple()
    end
    
    Ripple.Parent = obj
    Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
    
    local tween1 = Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
    
    tween1.Completed:Connect(function()
        local tween2 = Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
        tween2.Completed:Connect(function()
            Ripple:Destroy()
            table.insert(rippleCache, Ripple)
        end)
    end)
end

-- 优化标签切换
local switchingTabs = false
function switchTab(new)
    if switchingTabs then return end
    local old = library.currentTab
    
    if old == nil then
        new[2].Visible = true
        new[2].Position = UDim2.new(0, 0, 0, 0)
        library.currentTab = new
        return
    end
    
    if old[1] == new[1] then return end
    switchingTabs = true
    library.currentTab = new

    -- 使用单个tween完成动画
    if old[2] then
        old[2].Visible = false
    end
    
    new[2].Position = UDim2.new(0, 0, 0, 0)
    new[2].Visible = true
    
    task.wait(0.05)
    switchingTabs = false
end

-- 优化拖拽功能
function drag(frame, hold)
    if not hold then
        hold = frame
    end
    local dragging = false
    local dragStart
    local startPos

    local connection1
    local connection2

    local function cleanUp()
        if connection1 then connection1:Disconnect() end
        if connection2 then connection2:Disconnect() end
        dragging = false
    end

    hold.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not dragging then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            connection1 = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    cleanUp()
                end
            end)
        end
    end)

    connection2 = UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    frame.Destroying:Connect(cleanUp)
end

-- 优化平滑滚动
local smoothScrollConnections = {}
function smoothScroll(frame, speed)
    if smoothScrollConnections[frame] then
        smoothScrollConnections[frame]:Disconnect()
    end
    
    local connection = frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        local currentPos = frame.CanvasPosition.Y
        Tween(frame, {0.2, 'Quad', 'Out'}, {
            CanvasPosition = Vector2.new(0, currentPos)
        })
    end)
    
    smoothScrollConnections[frame] = connection
end

-- 蓝紫色渐变颜色
local bluePurpleColors = {
    Color3.fromRGB(100, 100, 255),      -- 蓝色
    Color3.fromRGB(150, 100, 255),      -- 蓝紫色
    Color3.fromRGB(200, 100, 255),      -- 紫色
    Color3.fromRGB(150, 100, 255),      -- 蓝紫色
    Color3.fromRGB(100, 100, 255)       -- 蓝色
}

-- 优化文字效果函数
function applyColorTextEffect(textLabel)
    if textLabel:FindFirstChild("TextGradient") then
        textLabel.TextGradient:Destroy()
    end
    
    local gradient = Instance.new("UIGradient")
    gradient.Name = "TextGradient"
    gradient.Parent = textLabel
    gradient.Rotation = 90
    
    local colorSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, bluePurpleColors[1]),
        ColorSequenceKeypoint.new(0.4, bluePurpleColors[2]),
        ColorSequenceKeypoint.new(0.6, bluePurpleColors[3]),
        ColorSequenceKeypoint.new(0.8, bluePurpleColors[4]),
        ColorSequenceKeypoint.new(1, bluePurpleColors[5])
    })
    
    gradient.Color = colorSequence
    return gradient
end

-------------------------AL------------------------------
ALTransparency = 0.2  -- 增加透明度提高性能
-------------------------AL------------------------------

function library.new(library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
            v:Destroy()
        end
    end

    -- 设置颜色
    local mainColor = Color3.fromRGB(30, 30, 40)
    local backgroundColor = Color3.fromRGB(25, 25, 35)
    local functionColor = Color3.fromRGB(40, 40, 60)
    local textColor = Color3.fromRGB(200, 200, 255)

    -- 背景图片ID
    local backgroundImageId = "rbxassetid://97366304813412"

    local dogent = Instance.new("ScreenGui")
    dogent.Name = "frosty"
    dogent.Parent = services.CoreGui
    dogent.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    dogent.ResetOnSpawn = false

    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end

    function UiDestroy()
        dogent:Destroy()
    end

    function ToggleUILib()
        dogent.Enabled = not dogent.Enabled
        ToggleUI = not dogent.Enabled
    end

    -- 创建背景图片
    local BackgroundImage = Instance.new("ImageLabel")
    BackgroundImage.Name = "BackgroundImage"
    BackgroundImage.Parent = dogent
    BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
    BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
    BackgroundImage.BackgroundTransparency = 1
    BackgroundImage.Image = backgroundImageId
    BackgroundImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
    BackgroundImage.ImageTransparency = 0.1
    BackgroundImage.ScaleType = Enum.ScaleType.Crop
    BackgroundImage.TileSize = UDim2.new(0, 100, 0, 100)

    -- 主框架 - 扩大尺寸
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = dogent
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Main.BackgroundTransparency = 0.1
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ZIndex = 2
    Main.Active = true
    Main.Visible = false

    -- 圆角
    local UICornerMain = Instance.new("UICorner")
    UICornerMain.Parent = Main
    UICornerMain.CornerRadius = UDim.new(0, 15)

    -- 阴影
    local DropShadowHolder = Instance.new("Frame")
    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = Main
    DropShadowHolder.BackgroundTransparency = 1
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.ZIndex = 1

    local DropShadow = Instance.new("ImageLabel")
    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 10, 1, 10)
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.5
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- UI展开/收缩动画
    local uiVisible = false
    local uiAnimating = false

    function toggleUIVisibility()
        if uiAnimating then return end
        uiAnimating = true
        
        uiVisible = not uiVisible
        
        if uiVisible then
            Main.Visible = true
            Main.Position = UDim2.new(0.5, 0, 0.5, 0)
            Main.Size = UDim2.new(0, 0, 0, 0)
            Main.Transparency = 1.0
            
            -- 扩大UI尺寸
            Tween(Main, {0.3, 'Quart', 'Out'}, {
                Size = UDim2.new(0, 650, 0, 450),  -- 扩大尺寸
                Transparency = 0.1
            })
            
            Open.Image = "rbxassetid://130119786616496"
        else
            Tween(Main, {0.3, 'Quart', 'In'}, {
                Size = UDim2.new(0, 0, 0, 0),
                Transparency = 1.0
            })
            
            task.wait(0.3)
            Main.Visible = false
            Open.Image = "rbxassetid://79285958044576"
        end
        
        uiAnimating = false
    end

    -- 按键控制
    local ctrlDown = false
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
            ctrlDown = true
        end
        if ctrlDown and input.KeyCode == Enum.KeyCode.F then
            toggleUIVisibility()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
            ctrlDown = false
        end
    end)

    drag(Main)

    -- 侧边栏
    local Side = Instance.new("Frame")
    Side.Name = "Side"
    Side.Parent = Main
    Side.BackgroundColor3 = mainColor
    Side.BackgroundTransparency = 0.1
    Side.BorderSizePixel = 0
    Side.Position = UDim2.new(0, 0, 0, 0)
    Side.Size = UDim2.new(0, 140, 1, 0)  -- 扩大侧边栏宽度
    
    local SideCorner = Instance.new("UICorner")
    SideCorner.Parent = Side
    SideCorner.CornerRadius = UDim.new(0, 15)

    -- 侧边栏分隔线
    local SideDivider = Instance.new("Frame")
    SideDivider.Name = "SideDivider"
    SideDivider.Parent = Side
    SideDivider.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    SideDivider.BorderSizePixel = 0
    SideDivider.Position = UDim2.new(1, -1, 0, 0)
    SideDivider.Size = UDim2.new(0, 1, 1, 0)

    -- 脚本标题
    local ScriptTitle = Instance.new("TextLabel")
    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundTransparency = 1
    ScriptTitle.Position = UDim2.new(0, 10, 0, 10)
    ScriptTitle.Size = UDim2.new(1, -20, 0, 30)
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.Text = name
    ScriptTitle.TextSize = 18
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    applyColorTextEffect(ScriptTitle)

    -- 标签按钮容器
    local TabBtns = Instance.new("ScrollingFrame")
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundTransparency = 1
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 10, 0, 50)
    TabBtns.Size = UDim2.new(1, -20, 1, -120)
    TabBtns.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabBtns.ScrollBarThickness = 4
    TabBtns.ScrollBarImageColor3 = textColor
    TabBtns.ScrollBarImageTransparency = 0.5

    local TabBtnsL = Instance.new("UIListLayout")
    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 8)

    smoothScroll(TabBtns, 0.2)

    -- 主内容区域
    local TabMain = Instance.new("Frame")
    TabMain.Name = "TabMain"
    TabMain.Parent = Main
    TabMain.BackgroundColor3 = backgroundColor
    TabMain.BackgroundTransparency = 0.1
    TabMain.BorderSizePixel = 0
    TabMain.Position = UDim2.new(0, 150, 0, 10)
    TabMain.Size = UDim2.new(1, -160, 1, -20)  -- 扩大内容区域
    
    local TabMainCorner = Instance.new("UICorner")
    TabMainCorner.Parent = TabMain
    TabMainCorner.CornerRadius = UDim.new(0, 10)

    -- 打开按钮
    local Frame = Instance.new("Frame")
    Frame.Parent = dogent
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(0, 20, 0, 20)
    Frame.Size = UDim2.new(0, 50, 0, 50)

    local Open = Instance.new("ImageButton")
    Open.Parent = Frame
    Open.BackgroundColor3 = mainColor
    Open.BackgroundTransparency = 0.1
    Open.Size = UDim2.new(1, 0, 1, 0)
    Open.Image = "rbxassetid://79285958044576"
    Open.ImageColor3 = textColor
    
    local OpenCorner = Instance.new("UICorner")
    OpenCorner.Parent = Open
    OpenCorner.CornerRadius = UDim.new(0, 10)

    Open.MouseButton1Click:Connect(function()
        toggleUIVisibility()
    end)

    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 10)
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
        Tab.BackgroundTransparency = 1
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 4
        Tab.ScrollBarImageColor3 = textColor
        Tab.ScrollBarImageTransparency = 0.5
        Tab.Visible = false

        smoothScroll(Tab, 0.2)

        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1
        TabIco.Size = UDim2.new(1, 0, 0, 30)
        TabIco.Image = icon or "rbxassetid://117316662967569"
        TabIco.ImageColor3 = textColor
        TabIco.ImageTransparency = 0.3

        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundTransparency = 1
        TabText.Size = UDim2.new(1, -30, 1, 0)
        TabText.Position = UDim2.new(0, 30, 0, 0)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = name
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        applyColorTextEffect(TabText)
        TabText.TextTransparency = 0.3

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(1, 0, 1, 0)
        TabBtn.AutoButtonColor = false
        TabBtn.Text = ""

        -- 优化悬停效果
        local hoverTween
        TabBtn.MouseEnter:Connect(function()
            if hoverTween then hoverTween:Cancel() end
            hoverTween = Tween(TabIco, {0.2, 'Quad', 'Out'}, {
                ImageTransparency = 0
            })
            Tween(TabText, {0.2, 'Quad', 'Out'}, {
                TextTransparency = 0
            })
        end)

        TabBtn.MouseLeave:Connect(function()
            if hoverTween then hoverTween:Cancel() end
            if library.currentTab and library.currentTab[1] ~= TabIco then
                hoverTween = Tween(TabIco, {0.2, 'Quad', 'Out'}, {
                    ImageTransparency = 0.3
                })
                Tween(TabText, {0.2, 'Quad', 'Out'}, {
                    TextTransparency = 0.3
                })
            end
        end)

        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 6)

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
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 10)
        end)

        local tab = {}
        
        function tab.section(tab, name, TabVal)
            local Section = Instance.new("Frame")
            local SectionText = Instance.new("TextLabel")
            local SectionToggle = Instance.new("ImageButton")
            local Objs = Instance.new("Frame")
            local ObjsL = Instance.new("UIListLayout")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = functionColor
            Section.BackgroundTransparency = 0.2
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(1, -10, 0, 40)

            local SectionCorner = Instance.new("UICorner")
            SectionCorner.Parent = Section
            SectionCorner.CornerRadius = UDim.new(0, 8)

            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundTransparency = 1
            SectionText.Position = UDim2.new(0, 10, 0, 0)
            SectionText.Size = UDim2.new(1, -40, 1, 0)
            SectionText.Font = Enum.Font.GothamSemibold
            SectionText.Text = name
            SectionText.TextSize = 16
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            applyColorTextEffect(SectionText)

            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = Section
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.Position = UDim2.new(1, -30, 0.5, -10)
            SectionToggle.Size = UDim2.new(0, 20, 0, 20)
            SectionToggle.Image = "rbxassetid://122395499720013"
            SectionToggle.ImageColor3 = textColor

            Objs.Name = "Objs"
            Objs.Parent = Section
            Objs.BackgroundTransparency = 1
            Objs.Position = UDim2.new(0, 10, 0, 40)
            Objs.Size = UDim2.new(1, -20, 0, 0)

            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 6)

            local open = TabVal ~= false
            if TabVal ~= false then
                Section.Size = UDim2.new(1, -10, 0, open and 40 + ObjsL.AbsoluteContentSize.Y + 10 or 40)
            end

            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                Tween(Section, {0.3, 'Quart', 'Out'}, {
                    Size = UDim2.new(1, -10, 0, open and 40 + ObjsL.AbsoluteContentSize.Y + 10 or 40)
                })
            end)

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not open then return end
                Section.Size = UDim2.new(1, -10, 0, 40 + ObjsL.AbsoluteContentSize.Y + 10)
            end)

            local section = {}
            
            -- 优化控件创建函数，减少重复代码
            local function createBaseControl(parent, text, width)
                local Module = Instance.new("Frame")
                Module.Name = "Module"
                Module.Parent = parent
                Module.BackgroundTransparency = 1
                Module.Size = UDim2.new(1, 0, 0, 38)

                local Btn = Instance.new("TextButton")
                Btn.Name = "Btn"
                Btn.Parent = Module
                Btn.BackgroundColor3 = functionColor
                Btn.BackgroundTransparency = ALTransparency
                Btn.Size = UDim2.new(width or 1, 0, 0, 38)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamSemibold
                Btn.Text = "   " .. text
                Btn.TextSize = 16
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                applyColorTextEffect(Btn)

                local BtnCorner = Instance.new("UICorner")
                BtnCorner.Parent = Btn
                BtnCorner.CornerRadius = UDim.new(0, 8)

                -- 悬停效果
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
                    Ripple(Btn)
                end)

                return Module, Btn
            end

            function section.Button(section, text, callback)
                local callback = callback or function() end
                local Module, Btn = createBaseControl(Objs, text)
                
                Btn.MouseButton1Click:Connect(function()
                    spawn(callback)
                end)
                return Btn
            end

            function section:Label(text)
                local Module = Instance.new("Frame")
                Module.Name = "LabelModule"
                Module.Parent = Objs
                Module.BackgroundTransparency = 1
                Module.Size = UDim2.new(1, 0, 0, 28)

                local TextLabel = Instance.new("TextLabel")
                TextLabel.Parent = Module
                TextLabel.BackgroundColor3 = functionColor
                TextLabel.BackgroundTransparency = ALTransparency
                TextLabel.Size = UDim2.new(1, 0, 0, 28)
                TextLabel.Font = Enum.Font.GothamSemibold
                TextLabel.Text = text
                TextLabel.TextSize = 14
                applyColorTextEffect(TextLabel)

                local LabelCorner = Instance.new("UICorner")
                LabelCorner.Parent = TextLabel
                LabelCorner.CornerRadius = UDim.new(0, 8)

                return TextLabel
            end

            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = enabled

                local Module, Btn = createBaseControl(Objs, text, 0.8)
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = Btn
                ToggleFrame.BackgroundColor3 = backgroundColor
                ToggleFrame.BackgroundTransparency = 0.5
                ToggleFrame.Position = UDim2.new(0.85, 0, 0.2, 0)
                ToggleFrame.Size = UDim2.new(0, 40, 0, 20)

                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.Parent = ToggleFrame
                ToggleCorner.CornerRadius = UDim.new(1, 0)

                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Name = "ToggleCircle"
                ToggleCircle.Parent = ToggleFrame
                ToggleCircle.BackgroundColor3 = textColor
                ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                ToggleCircle.Position = UDim2.new(0, 2, 0.5, -8)

                local ToggleCircleCorner = Instance.new("UICorner")
                ToggleCircleCorner.Parent = ToggleCircle
                ToggleCircleCorner.CornerRadius = UDim.new(1, 0)

                local funcs = {
                    SetState = function(self, state)
                        if state == nil then state = not library.flags[flag] end
                        if library.flags[flag] == state then return end
                        
                        Tween(ToggleCircle, {0.2, 'Quad', 'Out'}, {
                            Position = UDim2.new(0, state and 22 or 2, 0.5, -8)
                        })
                        
                        library.flags[flag] = state
                        callback(state)
                    end
                }

                if enabled then
                    funcs:SetState(true)
                end

                Btn.MouseButton1Click:Connect(function()
                    funcs:SetState()
                end)

                return funcs
            end

            function section.Keybind(section, text, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(default, "No default key provided")

                local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
                local keyTxt = (default and default.Name or "None")

                local Module, Btn = createBaseControl(Objs, text, 0.7)
                
                local KeybindValue = Instance.new("TextButton")
                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = Btn
                KeybindValue.BackgroundColor3 = backgroundColor
                KeybindValue.BackgroundTransparency = 0.3
                KeybindValue.Position = UDim2.new(0.75, 0, 0.2, 0)
                KeybindValue.Size = UDim2.new(0, 80, 0, 24)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.Gotham
                KeybindValue.Text = keyTxt
                KeybindValue.TextSize = 12
                applyColorTextEffect(KeybindValue)

                local KeybindCorner = Instance.new("UICorner")
                KeybindCorner.Parent = KeybindValue
                KeybindCorner.CornerRadius = UDim.new(0, 6)

                local bindKey = default
                
                UserInputService.InputBegan:Connect(function(inp, gpe)
                    if gpe then return end
                    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    if inp.KeyCode ~= bindKey then return end
                    callback(bindKey.Name)
                end)

                local listening = false
                KeybindValue.MouseButton1Click:Connect(function()
                    if listening then return end
                    listening = true
                    KeybindValue.Text = "..."
                    
                    local connection
                    connection = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            local keyName = input.KeyCode.Name
                            if keyName ~= "Unknown" then
                                bindKey = input.KeyCode
                                KeybindValue.Text = keyName
                                if connection then connection:Disconnect() end
                                listening = false
                            end
                        end
                    end)
                end)

                KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    KeybindValue.Size = UDim2.new(0, math.max(60, KeybindValue.TextBounds.X + 20), 0, 24)
                end)
            end

            function section.Textbox(section, text, flag, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default text provided")

                library.flags[flag] = default

                local Module, Btn = createBaseControl(Objs, text, 0.7)
                
                local TextBoxBG = Instance.new("Frame")
                TextBoxBG.Name = "TextBoxBG"
                TextBoxBG.Parent = Btn
                TextBoxBG.BackgroundColor3 = backgroundColor
                TextBoxBG.BackgroundTransparency = 0.3
                TextBoxBG.Position = UDim2.new(0.75, 0, 0.2, 0)
                TextBoxBG.Size = UDim2.new(0, 100, 0, 24)

                local TextBoxBGCorner = Instance.new("UICorner")
                TextBoxBGCorner.Parent = TextBoxBG
                TextBoxBGCorner.CornerRadius = UDim.new(0, 6)

                local TextBox = Instance.new("TextBox")
                TextBox.Parent = TextBoxBG
                TextBox.BackgroundTransparency = 1
                TextBox.Size = UDim2.new(1, -10, 1, 0)
                TextBox.Position = UDim2.new(0, 5, 0, 0)
                TextBox.Font = Enum.Font.Gotham
                TextBox.Text = default
                TextBox.TextSize = 12
                applyColorTextEffect(TextBox)
                TextBox.PlaceholderText = "Type here..."
                TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 180)

                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == "" then
                        TextBox.Text = default
                    end
                    library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                end)

                TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    TextBoxBG.Size = UDim2.new(0, math.max(80, TextBox.TextBounds.X + 30), 0, 24)
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
                
                local Module, Btn = createBaseControl(Objs, text, 0.6)
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = Btn
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = backgroundColor
                SliderBar.BackgroundTransparency = 0.3
                SliderBar.Position = UDim2.new(0.65, 0, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 120, 0, 8)

                local SliderBarCorner = Instance.new("UICorner")
                SliderBarCorner.Parent = SliderBar
                SliderBarCorner.CornerRadius = UDim.new(1, 0)

                local SliderFill = Instance.new("Frame")
                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderBar
                SliderFill.BackgroundColor3 = textColor
                SliderFill.Size = UDim2.new(0, 0, 1, 0)

                local SliderFillCorner = Instance.new("UICorner")
                SliderFillCorner.Parent = SliderFill
                SliderFillCorner.CornerRadius = UDim.new(1, 0)

                local SliderValue = Instance.new("TextLabel")
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = Btn
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(0.9, 0, 0, 0)
                SliderValue.Size = UDim2.new(0, 40, 1, 0)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = tostring(default)
                SliderValue.TextSize = 12
                applyColorTextEffect(SliderValue)

                local funcs = {
                    SetValue = function(self, value)
                        if value then
                            value = math.clamp(value, min, max)
                            local percent = (value - min) / (max - min)
                            Tween(SliderFill, {0.2, 'Quad', 'Out'}, {
                                Size = UDim2.new(percent, 0, 1, 0)
                            })
                            SliderValue.Text = tostring(value)
                            library.flags[flag] = value
                            callback(value)
                        end
                    end
                }

                funcs:SetValue(default)

                local dragging = false
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                RunService.RenderStepped:Connect(function()
                    if dragging then
                        local percent = math.clamp((mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        local value
                        if precise then
                            value = min + (max - min) * percent
                        else
                            value = math.floor(min + (max - min) * percent)
                        end
                        funcs:SetValue(value)
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
                
                local Module, Btn = createBaseControl(Objs, text, 0.7)
                
                local DropdownValue = Instance.new("TextButton")
                DropdownValue.Name = "DropdownValue"
                DropdownValue.Parent = Btn
                DropdownValue.BackgroundColor3 = backgroundColor
                DropdownValue.BackgroundTransparency = 0.3
                DropdownValue.Position = UDim2.new(0.75, 0, 0.2, 0)
                DropdownValue.Size = UDim2.new(0, 80, 0, 24)
                DropdownValue.AutoButtonColor = false
                DropdownValue.Font = Enum.Font.Gotham
                DropdownValue.Text = "Select"
                DropdownValue.TextSize = 12
                applyColorTextEffect(DropdownValue)

                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.Parent = DropdownValue
                DropdownCorner.CornerRadius = UDim.new(0, 6)

                local DropdownArrow = Instance.new("ImageLabel")
                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = DropdownValue
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(1, -20, 0.5, -8)
                DropdownArrow.Size = UDim2.new(0, 16, 0, 16)
                DropdownArrow.Image = "rbxassetid://122395499720013"
                DropdownArrow.ImageColor3 = textColor

                local OptionsFrame = Instance.new("Frame")
                OptionsFrame.Name = "OptionsFrame"
                OptionsFrame.Parent = Module
                OptionsFrame.BackgroundColor3 = functionColor
                OptionsFrame.BackgroundTransparency = 0.2
                OptionsFrame.Position = UDim2.new(0, 0, 1, 5)
                OptionsFrame.Size = UDim2.new(1, 0, 0, 0)
                OptionsFrame.ClipsDescendants = true
                OptionsFrame.Visible = false

                local OptionsCorner = Instance.new("UICorner")
                OptionsCorner.Parent = OptionsFrame
                OptionsCorner.CornerRadius = UDim.new(0, 6)

                local OptionsList = Instance.new("UIListLayout")
                OptionsList.Name = "OptionsList"
                OptionsList.Parent = OptionsFrame
                OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
                OptionsList.Padding = UDim.new(0, 2)

                local open = false
                local function toggleDropdown()
                    open = not open
                    OptionsFrame.Visible = open
                    Tween(OptionsFrame, {0.3, 'Quart', 'Out'}, {
                        Size = UDim2.new(1, 0, 0, open and math.min(OptionsList.AbsoluteContentSize.Y, 200) or 0)
                    })
                    Tween(DropdownArrow, {0.3, 'Quart', 'Out'}, {
                        Rotation = open and 180 or 0
                    })
                end

                DropdownValue.MouseButton1Click:Connect(toggleDropdown)

                OptionsList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if open then
                        Tween(OptionsFrame, {0.3, 'Quart', 'Out'}, {
                            Size = UDim2.new(1, 0, 0, math.min(OptionsList.AbsoluteContentSize.Y, 200))
                        })
                    end
                end)

                local funcs = {}
                funcs.AddOption = function(self, option)
                    local OptionBtn = Instance.new("TextButton")
                    OptionBtn.Name = "Option_" .. option
                    OptionBtn.Parent = OptionsFrame
                    OptionBtn.BackgroundColor3 = backgroundColor
                    OptionBtn.BackgroundTransparency = 0.5
                    OptionBtn.Size = UDim2.new(1, -10, 0, 28)
                    OptionBtn.Position = UDim2.new(0, 5, 0, 0)
                    OptionBtn.AutoButtonColor = false
                    OptionBtn.Font = Enum.Font.Gotham
                    OptionBtn.Text = option
                    OptionBtn.TextSize = 12
                    applyColorTextEffect(OptionBtn)

                    local OptionCorner = Instance.new("UICorner")
                    OptionCorner.Parent = OptionBtn
                    OptionCorner.CornerRadius = UDim.new(0, 4)

                    OptionBtn.MouseEnter:Connect(function()
                        Tween(OptionBtn, {0.2, 'Quad', 'Out'}, {
                            BackgroundTransparency = 0.3
                        })
                    end)

                    OptionBtn.MouseLeave:Connect(function()
                        Tween(OptionBtn, {0.2, 'Quad', 'Out'}, {
                            BackgroundTransparency = 0.5
                        })
                    end)

                    OptionBtn.MouseButton1Click:Connect(function()
                        toggleDropdown()
                        DropdownValue.Text = option
                        library.flags[flag] = option
                        callback(option)
                    end)
                end

                funcs.RemoveOption = function(self, option)
                    local option = OptionsFrame:FindFirstChild("Option_" .. option)
                    if option then option:Destroy() end
                end

                funcs.SetOptions = function(self, options)
                    for _, v in next, OptionsFrame:GetChildren() do
                        if v:IsA("TextButton") then
                            v:Destroy()
                        end
                    end
                    for _, v in next, options do
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