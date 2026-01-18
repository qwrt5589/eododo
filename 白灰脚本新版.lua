local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/8a6c4301158d46f14ea1d41d254a60f796c11c5a/%E5%BD%92%E6%9D%A5%E7%9A%84%E8%84%9A%E6%AD%A5.lua"))()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SUHUB_GUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Notification = Instance.new("Frame")
local NotifCorner = Instance.new("UICorner")
local NotifStroke = Instance.new("UIStroke")
local NotifTitle = Instance.new("TextLabel")
local NotifText1 = Instance.new("TextLabel")
local NotifText2 = Instance.new("TextLabel")
local NotifText3 = Instance.new("TextLabel")
local ConfirmButton = Instance.new("TextButton")
local ButtonCorner = Instance.new("UICorner")

Notification.Parent = ScreenGui
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BackgroundTransparency = 0.2
Notification.Size = UDim2.new(0, 500, 0, 250)
Notification.Position = UDim2.new(0.5, 0, 0.5, 0)
Notification.AnchorPoint = Vector2.new(0.5, 0.5)

NotifCorner.CornerRadius = UDim.new(0, 12)
NotifCorner.Parent = Notification

NotifStroke.Color = Color3.fromRGB(255, 0, 0)
NotifStroke.Thickness = 3
NotifStroke.Parent = Notification

NotifTitle.Parent = Notification
NotifTitle.BackgroundTransparency = 1
NotifTitle.Size = UDim2.new(1, 0, 0, 40)
NotifTitle.Position = UDim2.new(0, 0, 0, 20)
NotifTitle.Font = Enum.Font.GothamBold
NotifTitle.Text = "白灰脚本已复活"
NotifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifTitle.TextSize = 28
NotifTitle.TextXAlignment = Enum.TextXAlignment.Center

NotifText1.Parent = Notification
NotifText1.BackgroundTransparency = 1
NotifText1.Size = UDim2.new(1, 0, 0, 30)
NotifText1.Position = UDim2.new(0, 0, 0, 70)
NotifText1.Font = Enum.Font.Gotham
NotifText1.Text = "作者：宇神"
NotifText1.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifText1.TextSize = 20
NotifText1.TextXAlignment = Enum.TextXAlignment.Center

NotifText2.Parent = Notification
NotifText2.BackgroundTransparency = 1
NotifText2.Size = UDim2.new(1, 0, 0, 30)
NotifText2.Position = UDim2.new(0, 0, 0, 100)
NotifText2.Font = Enum.Font.Gotham
NotifText2.Text = "宇神为第3任白灰脚本作者"
NotifText2.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifText2.TextSize = 18
NotifText2.TextXAlignment = Enum.TextXAlignment.Center

NotifText3.Parent = Notification
NotifText3.BackgroundTransparency = 1
NotifText3.Size = UDim2.new(1, 0, 0, 30)
NotifText3.Position = UDim2.new(0, 0, 0, 130)
NotifText3.Font = Enum.Font.Gotham
NotifText3.Text = "QQ1693323219"
NotifText3.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifText3.TextSize = 18
NotifText3.TextXAlignment = Enum.TextXAlignment.Center

ConfirmButton.Parent = Notification
ConfirmButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
ConfirmButton.Size = UDim2.new(0, 120, 0, 40)
ConfirmButton.Position = UDim2.new(0.5, -60, 0, 180)
ConfirmButton.Font = Enum.Font.GothamBold
ConfirmButton.Text = "确定"
ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmButton.TextSize = 18

ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = ConfirmButton

Notification.Size = UDim2.new(0, 250, 0, 125)
Notification.Position = UDim2.new(0.5, 0, 0.5, 0)

game:GetService("TweenService"):Create(
    Notification,
    TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 500, 0, 250)}
):Play()

local hue = 0
coroutine.wrap(function()
    while Notification.Parent do
        hue = (hue + 0.01) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        NotifStroke.Color = color
        wait(0.05)
    end
end)()

ConfirmButton.MouseButton1Click:Connect(function()
    game:GetService("TweenService"):Create(
        Notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 250, 0, 125)}
    ):Play()
    wait(0.3)
    Notification:Destroy()
end)


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SUHUB_GUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Notification = Instance.new("Frame")
local NotifCorner = Instance.new("UICorner")
local NotifStroke = Instance.new("UIStroke")
local NotifTitle = Instance.new("TextLabel")
local NotifText = Instance.new("TextLabel")
local NotifContact = Instance.new("TextLabel")

Notification.Parent = ScreenGui
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.Size = UDim2.new(0, 250, 0, 80)
Notification.Position = UDim2.new(1, -260, 1, -50)
Notification.AnchorPoint = Vector2.new(0, 1)

NotifCorner.CornerRadius = UDim.new(0, 8)
NotifCorner.Parent = Notification

NotifStroke.Color = Color3.fromRGB(255, 0, 0)
NotifStroke.Thickness = 2
NotifStroke.Parent = Notification

NotifTitle.Parent = Notification
NotifTitle.BackgroundTransparency = 1
NotifTitle.Size = UDim2.new(1, -10, 0, 18)
NotifTitle.Position = UDim2.new(0, 10, 0, 8)
NotifTitle.Font = Enum.Font.GothamBold
NotifTitle.Text = "欢迎使用白灰脚本"
NotifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifTitle.TextSize = 16
NotifTitle.TextXAlignment = Enum.TextXAlignment.Left

NotifText.Parent = Notification
NotifText.BackgroundTransparency = 1
NotifText.Size = UDim2.new(1, -10, 0, 18)
NotifText.Position = UDim2.new(0, 10, 0, 28)
NotifText.Font = Enum.Font.Gotham
NotifText.Text = "by 宇神"
NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifText.TextSize = 14
NotifText.TextXAlignment = Enum.TextXAlignment.Left
NotifText.TextYAlignment = Enum.TextYAlignment.Top

NotifContact.Parent = Notification
NotifContact.BackgroundTransparency = 1
NotifContact.Size = UDim2.new(1, -10, 0, 18)
NotifContact.Position = UDim2.new(0, 10, 0, 48)
NotifContact.Font = Enum.Font.Gotham
NotifContact.Text = "QQ1693323219"
NotifContact.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifContact.TextSize = 14
NotifContact.TextXAlignment = Enum.TextXAlignment.Left
NotifContact.TextYAlignment = Enum.TextYAlignment.Top

Notification.Position = UDim2.new(1, 260, 1, -50)
game:GetService("TweenService"):Create(
    Notification,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {Position = UDim2.new(1, -260, 1, -50)}
):Play()

local hue = 0
coroutine.wrap(function()
    while Notification.Parent do
        hue = (hue + 0.01) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        NotifStroke.Color = color
        wait(0.05)
    end
end)()

task.delay(6.5, function()
    game:GetService("TweenService"):Create(
        Notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, 260, 1, -50)}
    ):Play()
    wait(0.5)
    Notification:Destroy()
end)

local YU = library:new("白灰脚本") 
local YU_Tab = YU:Tab("信息", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Label("白灰脚本永久免费")
YU_SHEN:Label("倒卖思全嘉")
YU_SHEN:Label("作者：宇神")
YU_SHEN:Label("QQ1693323219")
YU_SHEN:Button("复制宇神QQ号",function()
    setclipboard("1693323219")
end)

local YU_Tab = YU:Tab("通用", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("快跑开关","开关",false,function(v)
                if v == true then
                    sudu = game:GetService("RunService").Heartbeat:Connect(function()
                        if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                            if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                                game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                            end
                        end
                    end)
                elseif not v and sudu then
                    sudu:Disconnect()
                    sudu = nil
                end
            end)

YU_SHEN:Textbox("快跑", "tpwalking", "输入", function(king)
local tspeed = king
local hb = game:GetService("RunService").Heartbeat
local tpwalking = true
local player = game:GetService("Players")
local lplr = player.LocalPlayer
local chr = lplr.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
while tpwalking and hb:Wait() and chr and hum and hum.Parent do
  if hum.MoveDirection.Magnitude > 0 then
    if tspeed then
      chr:TranslateBy(hum.MoveDirection * tonumber(tspeed))
    else
      chr:TranslateBy(hum.MoveDirection)
    end
  end
end
end)

YU_SHEN:Slider('范围', '拉条',  1, 1, 50,false, function(v)
    _G.HeadSize = v
	_G.Disabled = true
		game:GetService('RunService').RenderStepped:connect(function()
			if _G.Disabled then
				for i,v in next, game:GetService('Players'):GetPlayers() do
				if v.Name ~= game:GetService('Players').LocalPlayer.Name then
					pcall(function()
					v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
					v.Character.HumanoidRootPart.Transparency = 0.9
					v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
					v.Character.HumanoidRootPart.Material = "Neon"
					v.Character.HumanoidRootPart.CanCollide = false
				end)
			end
		end
	end
end) 
end)

YU_SHEN:Slider('缩放距离', 'ZOOOOOM OUT!',  128, 128, 200000,false, function(value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = value
    end)

YU_SHEN:Slider('缩放焦距 正常70', 'Sliderflag', 70, 0.1, 250, false, function(v)
        game.Workspace.CurrentCamera.FieldOfView = v
end)
  
YU_SHEN:Slider('相机焦距上限', 'ZOOOOOM OUT!',  128, 128, 200000,false, function(Value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
end)

YU_SHEN:Slider('相机焦距 正常为70', 'Sliderflag', 70, 0.1, 250, false, function(v)
        game.Workspace.CurrentCamera.FieldOfView = v
end)

YU_SHEN:Textbox("设置重力", "Gravity", "输入", function(gravity)
    spawn(function()
        while task.wait() do
            local workspace = game.Workspace
            workspace.Gravity = tonumber(gravity) or workspace.Gravity
        end
    end)
end)


YU_SHEN:Toggle("靠近自动攻击", "AutoAttack", false, function(enabled)
    if enabled then
        if getgenv().configs and getgenv().configs.Disable then
            local configs = getgenv().configs
            local Disable = configs.Disable
            for _, connection in pairs(configs.connections) do
                connection:Disconnect()
            end
            Disable:Fire()
            Disable:Destroy()
            getgenv().configs = nil
        end
        
        local DisableEvent = Instance.new("BindableEvent")
        getgenv().configs = {
            connections = {},
            Disable = DisableEvent,
            Size = Vector3.new(10, 10, 10),
            DeathCheck = true,
        }
        
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        
        local isActive = true
        
        local function GetCharacter(player)
            return player and player.Character
        end
        
        local function GetHumanoid(model)
            if not model then return nil end
            return model:FindFirstChildWhichIsA("Humanoid")
        end
        
        local function IsAlive(humanoid)
            return humanoid and humanoid.Health > 0
        end
        
        local function FindToolTouchPart(tool)
            return tool and tool:FindFirstChildWhichIsA("TouchTransmitter", true)
        end
        
        local function GetOtherPlayerCharacters()
            local characters = {}
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local char = GetCharacter(player)
                    if char then
                        table.insert(characters, char)
                    end
                end
            end
            return characters
        end
        
        local function AttackWithTool(tool, handle, target)
            if tool:IsDescendantOf(workspace) then
                tool:Activate()
                firetouchinterest(handle, target, 1)
                firetouchinterest(handle, target, 0)
            end
        end
        
        table.insert(getgenv().configs.connections, DisableEvent.Event:Connect(function()
            isActive = false
        end))
        
        while isActive do
            local character = GetCharacter(LocalPlayer)
            local humanoid = GetHumanoid(character)
            
            if IsAlive(humanoid) then
                local tool = character and character:FindFirstChildWhichIsA("Tool")
                local touchPart = tool and FindToolTouchPart(tool)
                
                if touchPart then
                    local toolHandle = touchPart.Parent
                    local otherCharacters = GetOtherPlayerCharacters()
                    
                    local overlapParams = OverlapParams.new()
                    overlapParams.FilterType = Enum.RaycastFilterType.Include
                    overlapParams.FilterDescendantsInstances = otherCharacters
                    
                    local nearbyParts = workspace:GetPartBoundsInBox(
                        toolHandle.CFrame,
                        toolHandle.Size + getgenv().configs.Size,
                        overlapParams
                    )
                    
                    for _, part in pairs(nearbyParts) do
                        local targetModel = part:FindFirstAncestorWhichIsA("Model")
                        if table.find(otherCharacters, targetModel) then
                            local targetHumanoid = GetHumanoid(targetModel)
                            if getgenv().configs.DeathCheck and IsAlive(targetHumanoid) then
                                AttackWithTool(tool, toolHandle, part)
                            elseif not getgenv().configs.DeathCheck then
                                AttackWithTool(tool, toolHandle, part)
                            end
                        end
                    end
                end
            end
            
            RunService.Heartbeat:Wait()
        end
        
    else
        if getgenv().configs and getgenv().configs.Disable then
            getgenv().configs.Disable:Fire()
            getgenv().configs.Disable:Destroy()
            
            for _, connection in pairs(getgenv().configs.connections) do
                connection:Disconnect()
            end
            
            getgenv().configs.connections = {}
            getgenv().configs = nil
        end
    end
end)

YU_SHEN:Toggle("自动互动", "AutoInteract", false, function(enabled)
    if enabled then
        autoInteract = true
        while autoInteract do
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    fireproximityprompt(descendant)
                end
            end
            task.wait(0.25)
        end
    else
        autoInteract = false
    end
end)

YU_SHEN:Button("快速互动", function()
    game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
        prompt.HoldDuration = 0
    end)
end)

YU_SHEN:Toggle("人物不可见状态(隐身)", "Invisible Character", false, function(enabled)
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("BasePart") then
            child.Transparency = enabled and 1 or 0
            child.CanCollide = not enabled
        elseif child:IsA("Accessory") and child:FindFirstChild("Handle") then
            child.Handle.Transparency = enabled and 1 or 0
        end
    end
end)

YU_SHEN:Toggle("防甩飞", "AntiFlingToggle", false, function(Value)
    AntiFlingEnabled = Value
    
    if Value then
        local Services = setmetatable({}, {
            __index = function(Self, Index)
                local NewService = game.GetService(game, Index)
                if NewService then
                    Self[Index] = NewService
                end
                return NewService
            end
        })

        local LocalPlayer = Services.Players.LocalPlayer
        local AntiFlingConnections = {}

        local function PlayerAdded(Player)
            local Detected = false
            local Character
            local PrimaryPart

            local function CharacterAdded(NewCharacter)
                Character = NewCharacter
                repeat
                    wait()
                    PrimaryPart = NewCharacter:FindFirstChild("HumanoidRootPart")
                until PrimaryPart
                Detected = false
            end

            CharacterAdded(Player.Character or Player.CharacterAdded:Wait())
            local charAddedConn = Player.CharacterAdded:Connect(CharacterAdded)
            
            local heartbeatConn = Services.RunService.Heartbeat:Connect(function()
                if not AntiFlingEnabled then return end
                
                if Character and Character:IsDescendantOf(workspace) and PrimaryPart and PrimaryPart:IsDescendantOf(Character) then
                    if PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 or PrimaryPart.AssemblyLinearVelocity.Magnitude > 100 then
                        Detected = true
                        for _, v in ipairs(Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                                v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                            end
                        end
                        PrimaryPart.CanCollide = false
                        PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                    end
                end
            end)
            
            AntiFlingConnections[Player] = {
                CharacterAdded = charAddedConn,
                Heartbeat = heartbeatConn
            }
        end

        for _, v in ipairs(Services.Players:GetPlayers()) do
            if v ~= LocalPlayer then
                PlayerAdded(v)
            end
        end
        
        local playerAddedConn = Services.Players.PlayerAdded:Connect(PlayerAdded)
        AntiFlingConnections.Global = {PlayerAdded = playerAddedConn}
    else
        for player, connections in pairs(AntiFlingConnections or {}) do
            if player == "Global" then
                if connections.PlayerAdded then
                    connections.PlayerAdded:Disconnect()
                end
            else
                if connections.CharacterAdded then
                    connections.CharacterAdded:Disconnect()
                end
                if connections.Heartbeat then
                    connections.Heartbeat:Disconnect()
                end
            end
        end
        AntiFlingConnections = {}
    end
end)

YU_SHEN:Button("防甩飞(外部)", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ChinaQY/Scripts/Main/AntiFling.lua"))()
end)

YU_SHEN:Toggle("获取所有玩家背包", "GetBackPack", false, function(enabled)
    if enabled then
        while enabled do
            for _, player in pairs(game.Players:GetChildren()) do
                wait()
                for _, tool in pairs(player.Backpack:GetChildren()) do
                    tool.Parent = game.Players.LocalPlayer.Backpack
                    wait()
                end
            end
        end
    end
end)

YU_SHEN:Button("吸人(无法关闭)", function()
    loadstring(game:HttpGet("https://pastefy.app/fF3DMBNF/raw"))()
end)

YU_SHEN:Button("人物螺旋上天", function()
    loadstring(game:HttpGet("https://pastefy.app/xV1T3PAi/raw"))()
end)

YU_SHEN:Button("无限R币", function()
    loadstring(game:HttpGet("https://pastefy.app/SxhPVOyM/raw"))()
end)

YU_SHEN:Button("聊天气泡美化", function()
    loadstring(game:HttpGet("https://pastefy.app/lCEPuiQO/raw"))()
end)

YU_SHEN:Button("获取当前道具", function()
    loadstring(game:HttpGet("https://pastefy.app/3FU05Dyt/raw"))()
end)

YU_SHEN:Button("给别人撞飞", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_5wpM7bBcOPspmX7lQ3m75SrYNWqxZ858ai3tJdEAId6jSI05IOUB224FQ0VSAswH.lua.txt'),true))()
end)

YU_SHEN:Button("永生", function()
    local player = game.Players.LocalPlayer
    
    local function disableAnimations(character)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        while true do
            wait(0.1)
            
            local animator = humanoid:FindFirstChildOfClass("Animator")
            if animator then
                for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
            
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
            
            if humanoid:GetState() == Enum.HumanoidStateType.Running then
                humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
            elseif humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
    
    if player.Character then
        disableAnimations(player.Character)
    end
    
    player.CharacterAdded:Connect(disableAnimations)
end)

YU_SHEN:Button("装备全部道具", function()
    loadstring(game:HttpGet("https://pastefy.app/uBqVR9JC/raw"))()
end)

YU_SHEN:Button("删除道具", function()
    loadstring(game:HttpGet("https://pastefy.app/r4LHK4p0/raw"))()
end)

YU_SHEN:Button("删除所有道具", function()
    loadstring(game:HttpGet("https://pastefy.app/8HB71Lbj/raw"))()
end)

YU_SHEN:Button("复活在原地", function()
    local player = game.Players.LocalPlayer
    local lastPosition = nil
    local lastCFrame = nil
    
    local function onCharacterAdded(character)
        wait(0.1)
        
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.Died:Connect(function()
            lastPosition = character:GetPivot().Position
            lastCFrame = character:GetPivot()
            
            wait(0.5)
            
            if lastCFrame then
                character:PivotTo(lastCFrame)
                
                local newHumanoid = character:FindFirstChildOfClass("Humanoid")
                if newHumanoid then
                    newHumanoid.Health = newHumanoid.MaxHealth
                end
            end
        end)
        
        if lastCFrame then
            character:PivotTo(lastCFrame)
        end
    end
    
    if player.Character then
        onCharacterAdded(player.Character)
    end
    
    player.CharacterAdded:Connect(onCharacterAdded)
end)

YU_SHEN:Button("锁定视角", function()
local ShiftlockStarterGui = Instance.new("ScreenGui")
    local ImageButton = Instance.new("ImageButton")
    ShiftlockStarterGui.Name = "Shiftlock (StarterGui)"
    ShiftlockStarterGui.Parent = game.CoreGui
    ShiftlockStarterGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ShiftlockStarterGui.ResetOnSpawn = false

    ImageButton.Parent = ShiftlockStarterGui
    ImageButton.Active = true
    ImageButton.Draggable = true
    ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageButton.BackgroundTransparency = 1.000
    ImageButton.Position = UDim2.new(0.921914339, 0, 0.552375436, 0)
    ImageButton.Size = UDim2.new(0.0636147112, 0, 0.0661305636, 0)
    ImageButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
    ImageButton.Image = "http://www.roblox.com/asset/?id=182223762"

    local function TLQOYN_fake_script()
        local script = Instance.new("LocalScript", ImageButton)
        local MobileCameraFramework = {}
        local Players = game.Players
        local runservice = game:GetService("RunService")
        local CAS = game:GetService("ContextActionService")
        local Player = Players.LocalPlayer
        local character = Player.Character or Player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local humanoid = character.Humanoid
        local camera = workspace.CurrentCamera
        local button = script.Parent
        uis = game:GetService("UserInputService")
        ismobile = uis.TouchEnabled
        button.Visible = ismobile

        local states = {
            OFF = "rbxasset://textures/ui/mouseLock_off@2x.png",
            ON = "rbxasset://textures/ui/mouseLock_on@2x.png"
        }

        local MAX_LENGTH = 900000
        local active = false
        local ENABLED_OFFSET = CFrame.new(1.7, 0, 0)
        local DISABLED_OFFSET = CFrame.new(-1.7, 0, 0)
        local rootPos = Vector3.new(0,0,0)

        local function UpdatePos()
            if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" and Player.Character:FindFirstChildOfClass"Humanoid".RootPart then
                rootPos = Player.Character:FindFirstChildOfClass"Humanoid".RootPart.Position
            end
        end

        local function UpdateImage(STATE)
            button.Image = states[STATE]
        end

        local function UpdateAutoRotate(BOOL)
            if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" then
                Player.Character:FindFirstChildOfClass"Humanoid".AutoRotate = BOOL
            end
        end

        local function GetUpdatedCameraCFrame()
            if game:GetService"Workspace".CurrentCamera then
                return CFrame.new(rootPos, Vector3.new(game:GetService"Workspace".CurrentCamera.CFrame.LookVector.X * MAX_LENGTH, rootPos.Y, game:GetService"Workspace".CurrentCamera.CFrame.LookVector.Z * MAX_LENGTH))
            end
        end

        local function EnableShiftlock()
            UpdatePos()
            UpdateAutoRotate(false)
            UpdateImage("ON")
            if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" and Player.Character:FindFirstChildOfClass"Humanoid".RootPart then
                Player.Character:FindFirstChildOfClass"Humanoid".RootPart.CFrame = GetUpdatedCameraCFrame()
            end
            if game:GetService"Workspace".CurrentCamera then
                game:GetService"Workspace".CurrentCamera.CFrame = camera.CFrame * ENABLED_OFFSET
            end
        end

        local function DisableShiftlock()
            UpdatePos()
            UpdateAutoRotate(true)
            UpdateImage("OFF")
            if game:GetService"Workspace".CurrentCamera then
                game:GetService"Workspace".CurrentCamera.CFrame = camera.CFrame * DISABLED_OFFSET
            end
            pcall(function()
                active:Disconnect()
                active = nil
            end)
        end

        UpdateImage("OFF")
        active = false

        function ShiftLock()
            if not active then
                active = runservice.RenderStepped:Connect(function()
                    EnableShiftlock()
                end)
            else
                DisableShiftlock()
            end
        end

        local ShiftLockButton = CAS:BindAction("ShiftLOCK", ShiftLock, false, "On")
        CAS:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))

        button.MouseButton1Click:Connect(function()
            if not active then
                active = runservice.RenderStepped:Connect(function()
                    EnableShiftlock()
                end)
            else
                DisableShiftlock()
            end
        end)

        return MobileCameraFramework
    end

    coroutine.wrap(TLQOYN_fake_script)()

    local function OMQRQRC_fake_script()
        local script = Instance.new("LocalScript", ShiftlockStarterGui)
        local Players = game.Players
        local UserInputService = game:GetService("UserInputService")
        local Settings = UserSettings()
        local GameSettings = Settings.GameSettings
        local ShiftLockController = {}

        while not Players.LocalPlayer do
            wait()
        end

        local LocalPlayer = Players.LocalPlayer
        local Mouse = LocalPlayer:GetMouse()
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local ScreenGui, ShiftLockIcon, InputCn
        local IsShiftLockMode = true
        local IsShiftLocked = true
        local IsActionBound = false
        local IsInFirstPerson = false

        ShiftLockController.OnShiftLockToggled = Instance.new("BindableEvent")

        local function isShiftLockMode()
            return LocalPlayer.DevEnableMouseLock and GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
        end

        if not UserInputService.TouchEnabled then
            IsShiftLockMode = isShiftLockMode()
        end

        local function onShiftLockToggled()
            IsShiftLocked = not IsShiftLocked
            ShiftLockController.OnShiftLockToggled:Fire()
        end

        local initialize = function()
            print("enabled")
        end

        function ShiftLockController:IsShiftLocked()
            return IsShiftLockMode and IsShiftLocked
        end

        function ShiftLockController:SetIsInFirstPerson(isInFirstPerson)
            IsInFirstPerson = isInFirstPerson
        end

        local function mouseLockSwitchFunc(actionName, inputState, inputObject)
            if IsShiftLockMode then
                onShiftLockToggled()
            end
        end

        local function disableShiftLock()
            if ScreenGui then
                ScreenGui.Parent = nil
            end
            IsShiftLockMode = false
            Mouse.Icon = ""
            if InputCn then
                InputCn:disconnect()
                InputCn = nil
            end
            IsActionBound = false
            ShiftLockController.OnShiftLockToggled:Fire()
        end

        local onShiftInputBegan = function(inputObject, isProcessed)
            if isProcessed then
                return
            end
            if inputObject.UserInputType ~= Enum.UserInputType.Keyboard or inputObject.KeyCode == Enum.KeyCode.LeftShift or inputObject.KeyCode == Enum.KeyCode.RightShift then
            end
        end

        local function enableShiftLock()
            IsShiftLockMode = isShiftLockMode()
            if IsShiftLockMode then
                if ScreenGui then
                    ScreenGui.Parent = PlayerGui
                end
                if IsShiftLocked then
                    ShiftLockController.OnShiftLockToggled:Fire()
                end
                if not IsActionBound then
                    InputCn = UserInputService.InputBegan:connect(onShiftInputBegan)
                    IsActionBound = true
                end
            end
        end

        GameSettings.Changed:connect(function(property)
            if property == "ControlMode" then
                if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
                    enableShiftLock()
                else
                    disableShiftLock()
                end
            elseif property == "ComputerMovementMode" then
                if GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.Default then
                    enableShiftLock()
                else
                    disableShiftLock()
                end
            end
        end)

        LocalPlayer.Changed:connect(function(property)
            if property == "DevComputerMovementMode" then
                if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.KeyboardMouse then
                    enableShiftLock()
                else
                    disableShiftLock()
                end
            elseif property == "DevEnableMouseLock" then
                if LocalPlayer.DevEnableMouseLock then
                    enableShiftLock()
                else
                    disableShiftLock()
                end
            end
        end)

        if isShiftLockMode() then
            enableShiftLock()
        end
    end

    coroutine.wrap(OMQRQRC_fake_script)()
end)

YU_SHEN:Button("踢人脚本(仅娱乐)", function()
    loadstring(game:HttpGet([[https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/c8320f69b6aa4f5d.txt_2024-08-08_214628.OTed.lua]]))()
end)

YU_SHEN:Button("动画中心", function()
    loadstring(game:HttpGet([[https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui]], true))()
end)

YU_SHEN:Button("身体瘫痪", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    wait(0.1)
    
    local function swapLimbs()
        local leftArm = character:FindFirstChild("LeftArm") or character:FindFirstChild("LeftUpperArm")
        local rightArm = character:FindFirstChild("RightArm") or character:FindFirstChild("RightUpperArm")
        local leftLeg = character:FindFirstChild("LeftLeg") or character:FindFirstChild("LeftUpperLeg")
        local rightLeg = character:FindFirstChild("RightLeg") or character:FindFirstChild("RightUpperLeg")
        local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
        
        if leftArm and rightArm and leftLeg and rightLeg and torso then
            local leftArmPos = leftArm.Position
            local leftArmCFrame = leftArm.CFrame
            local leftArmSize = leftArm.Size
            
            local rightArmPos = rightArm.Position
            local rightArmCFrame = rightArm.CFrame
            local rightArmSize = rightArm.Size
            
            local leftLegPos = leftLeg.Position
            local leftLegCFrame = leftLeg.CFrame
            local leftLegSize = leftLeg.Size
            
            local rightLegPos = rightLeg.Position
            local rightLegCFrame = rightLeg.CFrame
            local rightLegSize = rightLeg.Size
            
            leftArm.Size = leftLegSize
            leftArm.CFrame = leftLegCFrame
            
            rightArm.Size = rightLegSize
            rightArm.CFrame = rightLegCFrame
            
            leftLeg.Size = leftArmSize
            leftLeg.CFrame = leftArmCFrame
            
            rightLeg.Size = rightArmSize
            rightLeg.CFrame = rightArmCFrame
            
            wait(0.1)
            
            local leftArmWeld = leftArm:FindFirstChildOfClass("WeldConstraint")
            local rightArmWeld = rightArm:FindFirstChildOfClass("WeldConstraint")
            local leftLegWeld = leftLeg:FindFirstChildOfClass("WeldConstraint")
            local rightLegWeld = rightLeg:FindFirstChildOfClass("WeldConstraint")
            
            if leftArmWeld then leftArmWeld:Destroy() end
            if rightArmWeld then rightArmWeld:Destroy() end
            if leftLegWeld then leftLegWeld:Destroy() end
            if rightLegWeld then rightLegWeld:Destroy() end
            
            local newLeftArmWeld = Instance.new("WeldConstraint")
            newLeftArmWeld.Part0 = torso
            newLeftArmWeld.Part1 = leftLeg
            newLeftArmWeld.Parent = leftLeg
            
            local newRightArmWeld = Instance.new("WeldConstraint")
            newRightArmWeld.Part0 = torso
            newRightArmWeld.Part1 = rightLeg
            newRightArmWeld.Parent = rightLeg
            
            local newLeftLegWeld = Instance.new("WeldConstraint")
            newLeftLegWeld.Part0 = torso
            newLeftLegWeld.Part1 = leftArm
            newLeftLegWeld.Parent = leftArm
            
            local newRightLegWeld = Instance.new("WeldConstraint")
            newRightLegWeld.Part0 = torso
            newRightLegWeld.Part1 = rightArm
            newRightLegWeld.Parent = rightArm
            
            leftArm.Name = "LeftLegTemp"
            rightArm.Name = "RightLegTemp"
            leftLeg.Name = "LeftArmTemp"
            rightLeg.Name = "RightArmTemp"
        end
    end
    
    swapLimbs()
    
    game:GetService("Debris"):AddItem(script, 1)
end)

YU_SHEN:Button("无头断腿r15",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Permanent-Headless-And-korblox-Script-4140"))()      
end)

YU_SHEN:Button("无头断腿r6",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/FIXED-Brainrot-Jumping-korblox-R6-a-headless-54182"))()
end)

YU_SHEN:Button("爬墙", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

YU_SHEN:Button("聊天气泡美化", function()
    loadstring(game:HttpGet("https://pastefy.app/lCEPuiQO/raw"))()
end)

YU_SHEN:Button("人物绘制", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/pmgp7mdm"))()
end)

YU_SHEN:Toggle("人物显示", "RWXS", false, function(enabled)
    getgenv().enabled = enabled
    getgenv().filluseteamcolor = true
    getgenv().outlineuseteamcolor = true
    getgenv().fillcolor = Color3.new(1, 0, 0)
    getgenv().outlinecolor = Color3.new(1, 1, 1)
    getgenv().filltrans = 0.5
    getgenv().outlinetrans = 0.5
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/Highlight-ESP.lua"))()
end)

YU_SHEN:Button("无后坐快速射击", function()
    loadstring(game:HttpGet("https://pastefy.app/Vbnh3Ycg/raw"))()
end)

YU_SHEN:Button("无限子弹", function()
    loadstring(game:HttpGet("https://pastefy.app/bYg3smqm/raw"))()
end)

YU_SHEN:Button("弹人(实体)", function()
    loadstring(game:HttpGet("https://pastefy.app/4r9e4F3p/raw"))()
end)

YU_SHEN:Button("弹人(半实体)", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/UTWcDtzj"))()
end)

YU_SHEN:Button("获得管理员权限", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
end)

YU_SHEN:Button("重新加入游戏", function()
    loadstring(game:HttpGet("https://pastefy.app/XXabqNiv/raw"))()
end)

YU_SHEN:Button("显示FPS", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/g54KFcUU"))()
end)

YU_SHEN:Button("显示时间", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/RycMWV3a"))()
end)

YU_SHEN:Button("F3X", function()
    loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)

YU_SHEN:Button("保存游戏", function()
    saveinstance()
end)

YU_SHEN:Button("离开游戏", function()
    game:Shutdown()
end)

YU_SHEN:Button("玩家加入与退出提示", function()
    loadstring(game:HttpGet("https://pastefy.app/KexNS25n/raw"))()
end)

YU_SHEN:Button("死亡笔记",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)

YU_SHEN:Button("飞行",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/jm%E9%A3%9E..lua"))()
end)

YU_SHEN:Button("透视",function()  
    _G.FriendColor = Color3.fromRGB(0, 0, 255)
        local function ApplyESP(v)
       if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
           v.Character.Humanoid.NameDisplayDistance = 9e9
           v.Character.Humanoid.NameOcclusion = "NoOcclusion"
           v.Character.Humanoid.HealthDisplayDistance = 9e9
           v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
           v.Character.Humanoid.Health = v.Character.Humanoid.Health -- triggers changed
       end
    end
    for i,v in pairs(game.Players:GetPlayers()) do
       ApplyESP(v)
       v.CharacterAdded:Connect(function()
           task.wait(0.33)
           ApplyESP(v)
       end)
    end
    
    game.Players.PlayerAdded:Connect(function(v)
       ApplyESP(v)
       v.CharacterAdded:Connect(function()
           task.wait(0.33)
           ApplyESP(v)
       end)
    end)
    
        local Players = game:GetService("Players"):GetChildren()
    local RunService = game:GetService("RunService")
    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    
    for i, v in pairs(Players) do
        repeat wait() until v.Character
        if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
            local highlightClone = highlight:Clone()
            highlightClone.Adornee = v.Character
            highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
            highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlightClone.Name = "Highlight"
        end
    end
    
    game.Players.PlayerAdded:Connect(function(player)
        repeat wait() until player.Character
        if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
            local highlightClone = highlight:Clone()
            highlightClone.Adornee = player.Character
            highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
            highlightClone.Name = "Highlight"
        end
    end)
    
    game.Players.PlayerRemoving:Connect(function(playerRemoved)
        playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
    end)
    
    RunService.Heartbeat:Connect(function()
        for i, v in pairs(Players) do
            repeat wait() until v.Character
            if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                local highlightClone = highlight:Clone()
                highlightClone.Adornee = v.Character
                highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
                highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlightClone.Name = "Highlight"
                task.wait()
            end
    end
    end)
    end)

YU_SHEN:Toggle("夜视脚本", "", false, function(state)
        if state then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end)

YU_SHEN:Toggle("无限跳", "IJ", false, function(enabled)
    getgenv().InfJ = enabled
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if InfJ == true then
            local character = game:GetService("Players").LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState("Jumping")
                end
            end
        end
    end)
end)

YU_SHEN:Button(
        "进入弹窗",
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
        end
    )
    
YU_SHEN:Button(
        "子弹追踪",
        function()
  loadstring(game:HttpGet("https://pastebin.com/raw/1AJ69eRG"))()          
end) 

YU_SHEN:Button(
        "管理员面板",
        function()
 loadstring(game:HttpGet("https://raw.githubusercontent.com/ExploiterGuy/Aqua-Hub/refs/heads/main/Turn%20People%20Into%20Things.txt"))()           
end) 

YU_SHEN:Button(
        "表情菜单",
        function()
   loadstring(game:HttpGet("https://yarhm.goteamst.com/scr?channel=afem"))()         
end) 

YU_SHEN:Button(
        "音乐播放器",
        function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Maan04ka/CodingScripts/main/MusicUI.lua"))()
end)

YU_SHEN:Button(
        "蓝屏脚本（娱乐）",
        function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-XIAOYE666.lua"))()         
end) 
    
YU_SHEN:Button(
        "甩飞",
        function()
            loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
        end
    )
    
    
YU_SHEN:Button(
        "点击传送",
        function()
            mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "点击传送的位置" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack
        end
    )
    
YU_SHEN:Button(
        "键盘脚本",
        function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()   
        end
    )
    
YU_SHEN:Button(
        "踏空行走",
        function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
        end
    )
    
local YU_Tab = YU:Tab("动画包", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("宇航员", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("泡状", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=910004836"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=910009958"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=910034870"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=910025107"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=910016857"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=910001910"
    Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=910030921"
    Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=910028158"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("卡通", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=742637544"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=742638445"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=742636889"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742637151"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("老人", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("骑士", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("悬浮", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("法师", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("忍者", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("海盗", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("机器人", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616089559"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616091570"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616090535"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616086039"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616087089"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("时尚", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616136790"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616146177"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616133594"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("超级英雄", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("玩具", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("吸血鬼", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("狼人", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("僵尸", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

-- 特别类别
YU_SHEN:Button("巡逻", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1149612882"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1151231493"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1150967949"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1148863382"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("自信", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1069977950"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1069987858"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1070017263"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1070001516"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1069984524"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1069946257"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1069973677"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("明星", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1212900985"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980338"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980348"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1212954642"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1213044953"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1212900995"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("牛仔", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1014390418"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1014398616"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1014421541"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1014401683"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1014394726"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1014380606"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1014384571"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("鬼", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
    Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=616012453"
    Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=616011509"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("小偷", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1132473842"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1132477671"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1132510133"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1132494274"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1132489853"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1132461372"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1132469004"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("公主", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=941003647"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=941013098"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=941028902"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=941015281"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=941008832"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=940996062"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=941000007"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

-- 其他类别
YU_SHEN:Button("没有", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=0"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=0"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
    Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=0"
    Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=0"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

YU_SHEN:Button("人类 (预设)", function()
    local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=2510196951"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=2510197257"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=2510202577"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=2510198475"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=2510197830"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=2510192778"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=2510195892"
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
end)

local YU_Tab = YU:Tab("头部饰品美化", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("婆婆猫头部", function()
    local plr = game:GetService('Players').LocalPlayer
    local hats = {}

    game:GetService('RunService').Stepped:connect(function()
        local chr = plr.Character
        if chr then
            for i,v in pairs(plr.Character:GetChildren()) do
                if v:IsA('Accessory') then
                    if v:FindFirstChildOfClass('Part') then
                        if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh') then
                            if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh').TextureId ~= "rbxassetid://6352158611" then
                                table.insert(hats,v:Clone())
                            end
                        end
                    end
                    v:Destroy()
                end
            end
            
            local ac = Instance.new('Accessory',plr.Character)
            local pa = Instance.new('Part',ac)
            pa.Size = Vector3.new(1,1,1)
            local me = Instance.new('SpecialMesh',pa)
            me.MeshType = Enum.MeshType.FileMesh
            me.MeshId = 'rbxassetid://6352154013'
            me.TextureId = 'rbxassetid://6352158611'
            me.Scale = Vector3.new(1.1,1.1,1.1)
            local weld = Instance.new('Weld',pa)
            weld.Part0 = pa
            weld.Part1 = plr.Character.Head
        end
    end)
end)

YU_SHEN:Button("小黑子头部", function()
    local plr = game:GetService('Players').LocalPlayer
    local hats = {}

    game:GetService('RunService').Stepped:connect(function()
        local chr = plr.Character
        if chr then
            for i,v in pairs(plr.Character:GetChildren()) do
                if v:IsA('Accessory') then
                    if v:FindFirstChildOfClass('Part') then
                        if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh') then
                            if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh').TextureId ~= "rbxassetid://18404453133" then
                                table.insert(hats,v:Clone())
                            end
                        end
                    end
                    v:Destroy()
                end
            end
            
            local ac = Instance.new('Accessory',plr.Character)
            local pa = Instance.new('Part',ac)
            pa.Size = Vector3.new(1,1,1)
            local me = Instance.new('SpecialMesh',pa)
            me.MeshType = Enum.MeshType.FileMesh
            me.MeshId = 'rbxassetid://18404452879'
            me.TextureId = 'rbxassetid://18404453133'
            me.Scale = Vector3.new(1.1,1.1,1.1)
            local weld = Instance.new('Weld',pa)
            weld.Part0 = pa
            weld.Part1 = plr.Character.Head
        end
    end)
end)

YU_SHEN:Button("灰太狼头部", function()
    local plr = game:GetService('Players').LocalPlayer
    local hats = {}

    game:GetService('RunService').Stepped:connect(function()
        local chr = plr.Character
        if chr then
            for i,v in pairs(plr.Character:GetChildren()) do
                if v:IsA('Accessory') then
                    if v:FindFirstChildOfClass('Part') then
                        if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh') then
                            if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh').TextureId ~= "rbxassetid://17766255315" then
                                table.insert(hats,v:Clone())
                            end
                        end
                    end
                    v:Destroy()
                end
            end
            
            local ac = Instance.new('Accessory',plr.Character)
            local pa = Instance.new('Part',ac)
            pa.Size = Vector3.new(1,1,1)
            local me = Instance.new('SpecialMesh',pa)
            me.MeshType = Enum.MeshType.FileMesh
            me.MeshId = 'rbxassetid://17766255501'
            me.TextureId = 'rbxassetid://17766255315'
            me.Scale = Vector3.new(0.8,0.8,0.8)
            local weld = Instance.new('Weld',pa)
            weld.Part0 = pa
            weld.Part1 = plr.Character.Head
        end
    end)
end)

local YU_Tab = YU:Tab("经典衬衫美化", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("所有人变成婆婆猫显示身份", function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local HEAD_MESH_ID = 'rbxassetid://6352154013'
    local HEAD_TEXTURE_ID = 'rbxassetid://6352158611'
    local SHIRT_ID = 'http://www.roblox.com/asset/?id=9549066694'
    local PANTS_ID = 'http://www.roblox.com/asset/?id=9549083449'
    local plr = game.Players.LocalPlayer

    local function createBillboarYUui(player, character)
        if not character:FindFirstChild("Head") then return end
        
        local existingGui = character.Head:FindFirstChild("NameDisplay")
        if existingGui then existingGui:Destroy() end
        
        local billboarYUui = Instance.new("BillboarYUui")
        billboarYUui.Name = "NameDisplay"
        billboarYUui.AlwaysOnTop = true
        billboarYUui.Size = UDim2.new(0, 200, 0, 50)
        billboarYUui.StudsOffset = Vector3.new(0, 3, 0)
        billboarYUui.Adornee = character.Head
        billboarYUui.Parent = character.Head
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 20
        
        if player == plr then
            textLabel.Text = "婆婆猫大军元首"
            textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        else
            textLabel.Text = "我是婆婆猫大军的成员"
            textLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        end
        
        textLabel.Parent = billboarYUui
        
        local connection
        connection = RunService.Heartbeat:Connect(function()
            local time = tick()
            local r = math.sin(time * 2) * 0.5 + 0.5
            local g = math.sin(time * 2 + 2) * 0.5 + 0.5
            local b = math.sin(time * 2 + 4) * 0.5 + 0.5
            
            if player == plr then
                textLabel.TextColor3 = Color3.fromRGB(r * 255, 0, 0)
            else
                textLabel.TextColor3 = Color3.fromRGB(0, g * 255, b * 255)
            end
        end)
        
        character:GetPropertyChangedSignal("Parent"):Connect(function()
            if not character.Parent then
                connection:Disconnect()
            end
        end)
    end

    local function modifyPlayer(player)
        if not player.Character then return end
        
        local character = player.Character
        
        createBillboarYUui(player, character)
        
        local hats1 = {}
        local connection1 = game:GetService('RunService').Stepped:connect(function()
            if not character or not character.Parent then 
                connection1:Disconnect()
                return 
            end
            
            for i,v in pairs(character:GetChildren()) do
                if v:IsA('Accessory') then
                    if v:FindFirstChildOfClass('Part') then
                        if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh') then
                            if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh').TextureId ~= HEAD_TEXTURE_ID then
                                table.insert(hats1,v:Clone())
                            end
                        end
                    end
                    v:Destroy()
                end
            end
            
            local ac = Instance.new('Accessory',character)
            local pa = Instance.new('Part',ac)
            pa.Size = Vector3.new(1,1,1)
            local me = Instance.new('SpecialMesh',pa)
            me.MeshType = Enum.MeshType.FileMesh
            me.MeshId = HEAD_MESH_ID
            me.TextureId = HEAD_TEXTURE_ID
            me.Scale = Vector3.new(1.1,1.1,1.1)
            local weld = Instance.new('Weld',pa)
            weld.Part0 = pa
            weld.Part1 = character.Head
        end)
        
        local hats2 = {}
        local connection2 = game:GetService('RunService').Stepped:connect(function()
            if not character or not character.Parent then 
                connection2:Disconnect()
                return 
            end
            
            for i,v in pairs(character:GetChildren()) do
                if v:IsA('Shirt') then
                    if v.ShirtTemplate ~= SHIRT_ID then
                        table.insert(hats2,v:Clone())
                    end
                    v:Destroy()
                elseif v:IsA('Pants') then
                    if v.PantsTemplate ~= PANTS_ID then
                        table.insert(hats2,v:Clone())
                    end
                    v:Destroy()
                end
            end
            
            local shirt = Instance.new('Shirt',character)
            shirt.ShirtTemplate = SHIRT_ID
            local pants = Instance.new('Pants',character)
            pants.PantsTemplate = PANTS_ID
        end)
        
        player.CharacterAdded:Connect(function(newCharacter)
            wait(1)
            createBillboarYUui(player, newCharacter)
        end)
    end

    for _, player in pairs(Players:GetPlayers()) do
        modifyPlayer(player)
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            wait(1)
            modifyPlayer(player)
        end)
    end)
end)

YU_SHEN:Button("所有人变成婆婆猫", function()
    local Players = game:GetService("Players")

    local HEAD_MESH_ID = 'rbxassetid://6352154013'
    local HEAD_TEXTURE_ID = 'rbxassetid://6352158611'
    local SHIRT_ID = 'http://www.roblox.com/asset/?id=9549066694'
    local PANTS_ID = 'http://www.roblox.com/asset/?id=9549083449'

    local function modifyPlayer(player)
        if not player.Character then return end
        
        local character = player.Character
        
        local hats1 = {}
        local connection1 = game:GetService('RunService').Stepped:connect(function()
            if not character or not character.Parent then 
                connection1:Disconnect()
                return 
            end
            
            for i,v in pairs(character:GetChildren()) do
                if v:IsA('Accessory') then
                    if v:FindFirstChildOfClass('Part') then
                        if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh') then
                            if v:FindFirstChildOfClass('Part'):FindFirstChildOfClass('SpecialMesh').TextureId ~= HEAD_TEXTURE_ID then
                                table.insert(hats1,v:Clone())
                            end
                        end
                    end
                    v:Destroy()
                end
            end
            
            local ac = Instance.new('Accessory',character)
            local pa = Instance.new('Part',ac)
            pa.Size = Vector3.new(1,1,1)
            local me = Instance.new('SpecialMesh',pa)
            me.MeshType = Enum.MeshType.FileMesh
            me.MeshId = HEAD_MESH_ID
            me.TextureId = HEAD_TEXTURE_ID
            me.Scale = Vector3.new(1.1,1.1,1.1)
            local weld = Instance.new('Weld',pa)
            weld.Part0 = pa
            weld.Part1 = character.Head
        end)
        
        local hats2 = {}
        local connection2 = game:GetService('RunService').Stepped:connect(function()
            if not character or not character.Parent then 
                connection2:Disconnect()
                return 
            end
            
            for i,v in pairs(character:GetChildren()) do
                if v:IsA('Shirt') then
                    if v.ShirtTemplate ~= SHIRT_ID then
                        table.insert(hats2,v:Clone())
                    end
                    v:Destroy()
                elseif v:IsA('Pants') then
                    if v.PantsTemplate ~= PANTS_ID then
                        table.insert(hats2,v:Clone())
                    end
                    v:Destroy()
                end
            end
            
            local shirt = Instance.new('Shirt',character)
            shirt.ShirtTemplate = SHIRT_ID
            local pants = Instance.new('Pants',character)
            pants.PantsTemplate = PANTS_ID
        end)
    end

    for _, player in pairs(Players:GetPlayers()) do
        modifyPlayer(player)
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            wait(1)
            modifyPlayer(player)
        end)
    end)
end)

YU_SHEN:Button("婆婆猫衬衫裤子", function()
    local plr = game:GetService('Players').LocalPlayer
    local hats = {}

    game:GetService('RunService').Stepped:connect(function()
        local chr = plr.Character
        if chr then
            for i,v in pairs(plr.Character:GetChildren()) do
                if v:IsA('Shirt') then
                    if v.ShirtTemplate ~= 'http://www.roblox.com/asset/?id=9549066694' then
                        table.insert(hats,v:Clone())
                    end
                    v:Destroy()
                elseif v:IsA('Pants') then
                    if v.PantsTemplate ~= 'http://www.roblox.com/asset/?id=9549083449' then
                        table.insert(hats,v:Clone())
                    end
                    v:Destroy()
                end
            end
            
            local shirt = Instance.new('Shirt',plr.Character)
            shirt.ShirtTemplate = 'http://www.roblox.com/asset/?id=9549066694'
            local pants = Instance.new('Pants',plr.Character)
            pants.PantsTemplate = 'http://www.roblox.com/asset/?id=9549083449'
        end
    end)
end)

YU_SHEN:Button("灰太狼衬衫裤子", function()
    local plr = game:GetService('Players').LocalPlayer
    local hats = {}

    game:GetService('RunService').Stepped:connect(function()
        local chr = plr.Character
        if chr then
            for i,v in pairs(plr.Character:GetChildren()) do
                if v:IsA('Shirt') then
                    if v.ShirtTemplate ~= 'http://www.roblox.com/asset/?id=17767101160' then
                        table.insert(hats,v:Clone())
                    end
                    v:Destroy()
                elseif v:IsA('Pants') then
                    if v.PantsTemplate ~= 'http://www.roblox.com/asset/?id=17767094672' then
                        table.insert(hats,v:Clone())
                    end
                    v:Destroy()
                end
            end
            
            local shirt = Instance.new('Shirt',plr.Character)
            shirt.ShirtTemplate = 'http://www.roblox.com/asset/?id=17767101160'
            local pants = Instance.new('Pants',plr.Character)
            pants.PantsTemplate = 'http://www.roblox.com/asset/?id=17767094672'
        end
    end)
end)

YU_SHEN:Button("巡查衣加小红裤", function()
    local plr = game:GetService('Players').LocalPlayer
    local hats = {}

    game:GetService('RunService').Stepped:connect(function()
        local chr = plr.Character
        if chr then
            for i,v in pairs(plr.Character:GetChildren()) do
                if v:IsA('Shirt') then
                    if v.ShirtTemplate ~= 'http://www.roblox.com/asset/?id=13543905752' then
                        table.insert(hats,v:Clone())
                    end
                    v:Destroy()
                elseif v:IsA('Pants') then
                    if v.PantsTemplate ~= 'http://www.roblox.com/asset/?id=13544830539' then
                        table.insert(hats,v:Clone())
                    end
                    v:Destroy()
                end
            end
            
            local shirt = Instance.new('Shirt',plr.Character)
            shirt.ShirtTemplate = 'http://www.roblox.com/asset/?id=13543905752'
            local pants = Instance.new('Pants',plr.Character)
            pants.PantsTemplate = 'http://www.roblox.com/asset/?id=13544830539'
        end
    end)
end)

local YU_Tab = YU:Tab("透视", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("关闭所有透视", function()
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local character = player.Character
            local head = character:FindFirstChild("Head")
            
            if head then
                local playerESP = head:FindFirstChild("PlayerESP_" .. player.Name)
                if playerESP then
                    playerESP:Destroy()
                end
                
                local healthBar = head:FindFirstChild("HealthBar_" .. player.Name)
                if healthBar then
                    healthBar:Destroy()
                end
                
                local enemyPlayerESP = head:FindFirstChild("EnemyPlayerESP_" .. player.Name)
                if enemyPlayerESP then
                    enemyPlayerESP:Destroy()
                end
                
                local distanceDisplay = head:FindFirstChild("DistanceDisplay_" .. player.Name)
                if distanceDisplay then
                    distanceDisplay:Destroy()
                end
            end
            
            local playerHighlight = character:FindFirstChild("PlayerHighlight")
            if playerHighlight then
                playerHighlight:Destroy()
            end
            
            local enemyPlayerHighlight = character:FindFirstChild("EnemyPlayerHighlight")
            if enemyPlayerHighlight then
                enemyPlayerHighlight:Destroy()
            end
            
            for _, child in ipairs(character:GetDescendants()) do
                if child:IsA("BillboarYUui") and (string.find(child.Name, "ESP") or string.find(child.Name, "HealthBar") or string.find(child.Name, "Distance")) then
                    child:Destroy()
                end
                if child:IsA("Highlight") and (string.find(child.Name, "Highlight") or child.Name == "PlayerESP") then
                    child:Destroy()
                end
            end
        end
    end
    
    for _, descendant in pairs(Workspace:GetDescendants()) do
        if descendant:IsA("Model") then
            for _, child in ipairs(descendant:GetDescendants()) do
                if child:IsA("BillboarYUui") and (string.find(child.Name, "NPCESP") or string.find(child.Name, "NPCHighlight") or string.find(child.Name, "ToolESP")) then
                    child:Destroy()
                end
                if child:IsA("Highlight") and (string.find(child.Name, "NPC") or string.find(child.Name, "Tool")) then
                    child:Destroy()
                end
            end
        end
    end
    
    if getgenv().HealthBarESP then
        getgenv().HealthBarESP = nil
    end
    if getgenv().PlayerHighlight then
        getgenv().PlayerHighlight = nil
    end
    if getgenv().NPCHighlight then
        getgenv().NPCHighlight = nil
    end
    if getgenv().NPCESP then
        getgenv().NPCESP = nil
    end
    if getgenv().EnemyPlayerESP then
        getgenv().EnemyPlayerESP = nil
    end
    if getgenv().EnemyNPCESP then
        getgenv().EnemyNPCESP = nil
    end
    if getgenv().DistanceESP then
        getgenv().DistanceESP = nil
    end
    if getgenv().ToolESP then
        getgenv().ToolESP = nil
    end
end)

YU_SHEN:Toggle("方框透视", "BoxESP", false, function(Value)
    ESPData.BoxESP = Value
    if not ESPConnection and (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
        StartESP()
    elseif ESPConnection and not (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
        StopESP()
    end
end)

YU_SHEN:Toggle("骨骼透视", "SkeletonESP", false, function(Value)
    ESPData.SkeletonESP = Value
    if not ESPConnection and (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
        StartESP()
    elseif ESPConnection and not (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
        StopESP()
    end
end)

YU_SHEN:Toggle("名称透视", "NameESP", false, function(Value)
    ESPData.NameESP = Value
    if not ESPConnection and (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
        StartESP()
    elseif ESPConnection and not (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
        StopESP()
    end
end)

YU_SHEN:Toggle("透视线条", "TracerESP", false, function(Value)
    ESPData.TracerESP = Value
    if not ESPConnection and (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
        StartESP()
    elseif ESPConnection and not (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
        StopESP()
    end
end)

YU_SHEN:Toggle("距离显示", "DistanceDisplay", false, function(Value)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    local DistanceTable = {}

    local function CreateDistanceDisplay(player)
        if DistanceTable[player] then return end
        
        local character = player.Character
        if not character then return end
        
        local head = character:FindFirstChild("Head")
        if not head then return end
        
        local billboard = Instance.new("BillboarYUui")
        billboard.Name = "DistanceDisplay_" .. player.Name
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 80, 0, 20)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "0m"
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = billboard
        
        DistanceTable[player] = {
            Billboard = billboard,
            TextLabel = textLabel
        }
    end

    local function UpdateDistance()
        for player, espData in pairs(DistanceTable) do
            if player.Character and player.Character:FindFirstChild("Head") and 
               LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
               
                local distance = (player.Character.Head.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                espData.TextLabel.Text = string.format("%.1fm", distance)
            end
        end
    end

    if Value then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character then
                    CreateDistanceDisplay(player)
                end
                player.CharacterAdded:Connect(function()
                    CreateDistanceDisplay(player)
                end)
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                CreateDistanceDisplay(player)
            end)
        end)
        
        local connection = RunService.Heartbeat:Connect(UpdateDistance)
        
        getgenv().DistanceESP = {
            Table = DistanceTable,
            Connection = connection
        }
        
    else
        if getgenv().DistanceESP then
            if getgenv().DistanceESP.Connection then
                getgenv().DistanceESP.Connection:Disconnect()
            end
            
            for player, espData in pairs(getgenv().DistanceESP.Table) do
                if espData and espData.Billboard then
                    espData.Billboard:Destroy()
                end
            end
            
            getgenv().DistanceESP = nil
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local distanceDisplay = player.Character:FindFirstChild("DistanceDisplay_" .. player.Name)
                if distanceDisplay then
                    distanceDisplay:Destroy()
                end
            end
        end
    end
end)

YU_SHEN:Toggle("透视手中物品", "ToolESP", false, function(Value)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    
    local function CreateToolESP(player)
        if ToolESPTable[player] then return end
        
        local character = player.Character
        if not character then return end
        
        local function findEquippedTool()
            local rightHand = character:FindFirstChild("RightHand")
            if rightHand then
                for _, tool in ipairs(character:GetChildren()) do
                    if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                        local handle = tool.Handle
                        
                        for _, weld in ipairs(handle:GetChildren()) do
                            if weld:IsA("Weld") and weld.Part1 == rightHand then
                                return tool
                            end
                        end
                    end
                end
            end
            
            for _, tool in ipairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    return tool
                end
            end
            
            return nil
        end
        
        local tool = findEquippedTool()
        if not tool then return end
        
        local handle = tool:FindFirstChild("Handle")
        if not handle then return end
        
        local billboard = Instance.new("BillboarYUui")
        billboard.Name = "ToolESP_" .. player.Name
        billboard.Adornee = handle
        billboard.Size = UDim2.new(0, 200, 0, 40)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = handle
        
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = Color3.new(1, 0.5, 0)
        frame.BackgroundTransparency = 0.2
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.Parent = billboard
        
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 5)
        uiCorner.Parent = frame
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = tool.Name
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = frame
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ToolHighlight_" .. player.Name
        highlight.FillColor = Color3.new(1, 0.5, 0)
        highlight.FillTransparency = 0.7
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 0
        highlight.Adornee = tool
        highlight.Parent = tool
        
        ToolESPTable[player] = {
            Billboard = billboard,
            Highlight = highlight,
            Tool = tool
        }
        
        local toolConnection
        toolConnection = character.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                task.wait(0.1)
                RemoveToolESP(player)
                CreateToolESP(player)
            end
        end)
        
        ToolESPTable[player].ToolConnection = toolConnection
    end
    
    local function RemoveToolESP(player)
        local espData = ToolESPTable[player]
        if espData then
            if espData.Billboard then
                espData.Billboard:Destroy()
            end
            if espData.Highlight then
                espData.Highlight:Destroy()
            end
            if espData.ToolConnection then
                espData.ToolConnection:Disconnect()
            end
            ToolESPTable[player] = nil
        end
    end

    if Value then
        local ToolESPTable = {}
        
        local checkConnection
        checkConnection = RunService.Heartbeat:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    if not ToolESPTable[player] then
                        CreateToolESP(player)
                    else
                        local espData = ToolESPTable[player]
                        if espData and espData.Tool and not player.Character:FindFirstChild(espData.Tool.Name) then
                            RemoveToolESP(player)
                            CreateToolESP(player)
                        end
                    end
                end
            end
        end)
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character then
                    CreateToolESP(player)
                end
                player.CharacterAdded:Connect(function()
                    task.wait(1)
                    CreateToolESP(player)
                end)
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                task.wait(1)
                CreateToolESP(player)
            end)
        end)
        
        getgenv().ToolESP = {
            Table = ToolESPTable,
            Connection = checkConnection
        }
        
    else
        if getgenv().ToolESP then
            if getgenv().ToolESP.Connection then
                getgenv().ToolESP.Connection:Disconnect()
            end
            
            for player, espData in pairs(getgenv().ToolESP.Table) do
                RemoveToolESP(player)
            end
            
            getgenv().ToolESP = nil
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                for _, child in ipairs(player.Character:GetDescendants()) do
                    if child:IsA("BillboarYUui") and string.find(child.Name, "ToolESP_") then
                        child:Destroy()
                    end
                end
                
                for _, child in ipairs(player.Character:GetDescendants()) do
                    if child:IsA("Highlight") and string.find(child.Name, "ToolHighlight_") then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("透视所有玩家", "PlayerESP", false, function(value)
    if value then
        local Players = game:GetService("Players")
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "PlayerESP_" .. player.Name
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)    
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 0) 
                    highlight.FillTransparency = 0.3  
                    highlight.OutlineTransparency = 0.3 
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = head
                end
            end
        end
    else
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local esp = head:FindFirstChild("PlayerESP_" .. player.Name)
                    if esp then
                        esp:Destroy()
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("血量条显示", "HealthBarESP", false, function(Value)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ESPTable = {}

    local function CreateHealthBar(player)
        if ESPTable[player] then return end
        
        local character = player.Character
        if not character then return end
        
        local humanoid = character:WaitForChild("Humanoid", 5)
        local head = character:WaitForChild("Head", 5)
        
        if not humanoid or not head then return end
        
        if head:FindFirstChild("HealthBar_" .. player.Name) then
            head:FindFirstChild("HealthBar_" .. player.Name):Destroy()
        end
        
        local billboard = Instance.new("BillboarYUui")
        billboard.Name = "HealthBar_" .. player.Name
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 80, 0, 15)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.AlwaysOnTop = true
        billboard.ResetOnSpawn = false
        billboard.Parent = head
        
        local background = Instance.new("Frame")
        background.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        background.BackgroundTransparency = 0.3
        background.Size = UDim2.new(1, 0, 1, 0)
        background.BorderSizePixel = 0
        background.Parent = billboard
        
        local healthBar = Instance.new("Frame")
        healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
        healthBar.BorderSizePixel = 0
        healthBar.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
        healthBar.Parent = background
        
        local healthText = Instance.new("TextLabel")
        healthText.Size = UDim2.new(1, 0, 1, 0)
        healthText.BackgroundTransparency = 1
        healthText.Text = tostring(math.floor(humanoid.Health))
        healthText.TextColor3 = Color3.new(1, 1, 1)
        healthText.TextStrokeTransparency = 0
        healthText.TextSize = 12
        healthText.Font = Enum.Font.GothamBold
        healthText.Parent = background
        
        ESPTable[player] = {
            Billboard = billboard,
            HealthBar = healthBar,
            HealthText = healthText,
            Humanoid = humanoid
        }
        
        local healthConnection
        healthConnection = humanoid.HealthChanged:Connect(function()
            UpdateHealthBar(player)
        end)
        
        local characterRemovingConnection
        characterRemovingConnection = player.CharacterRemoving:Connect(function()
            if ESPTable[player] then
                RemoveHealthBar(player)
            end
        end)
        
        ESPTable[player].Connections = {
            HealthChanged = healthConnection,
            CharacterRemoving = characterRemovingConnection
        }
    end

    local function UpdateHealthBar(player)
        local espData = ESPTable[player]
        if not espData then return end
        
        local humanoid = espData.Humanoid
        if not humanoid or humanoid.Health <= 0 then
            RemoveHealthBar(player)
            return
        end
        
        local healthPercent = humanoid.Health / humanoid.MaxHealth
        espData.HealthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
        espData.HealthText.Text = tostring(math.floor(humanoid.Health))
        
        if healthPercent > 0.7 then
            espData.HealthBar.BackgroundColor3 = Color3.new(0, 1, 0)
        elseif healthPercent > 0.3 then
            espData.HealthBar.BackgroundColor3 = Color3.new(1, 1, 0)
        else
            espData.HealthBar.BackgroundColor3 = Color3.new(1, 0, 0)
        end
    end

    local function RemoveHealthBar(player)
        local espData = ESPTable[player]
        if espData then
            if espData.Connections then
                for _, connection in pairs(espData.Connections) do
                    if connection then
                        connection:Disconnect()
                    end
                end
            end
            
            if espData.Billboard and espData.Billboard.Parent then
                espData.Billboard:Destroy()
            end
            
            ESPTable[player] = nil
        end
    end

    if Value then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character then
                    coroutine.wrap(CreateHealthBar)(player)
                end
                player.CharacterAdded:Connect(function(character)
                    task.wait(1)
                    CreateHealthBar(player)
                end)
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                task.wait(1)
                CreateHealthBar(player)
            end)
        end)
        
        Players.PlayerRemoving:Connect(function(player)
            if ESPTable[player] then
                RemoveHealthBar(player)
            end
        end)
        
        getgenv().HealthBarESP = ESPTable
        
    else
        for player, espData in pairs(ESPTable) do
            RemoveHealthBar(player)
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local head = player.Character.Head
                local healthBar = head:FindFirstChild("HealthBar_" .. player.Name)
                if healthBar then
                    healthBar:Destroy()
                end
            end
        end
        
        table.clear(ESPTable)
        if getgenv().HealthBarESP then
            getgenv().HealthBarESP = nil
        end
    end
end)

YU_SHEN:Toggle("高亮显示玩家", "PlayerHighlight", false, function(Value)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local HighlightTable = {}

    local function GetTeamColor(player)
        if player.Team then
            return player.Team.TeamColor.Color
        else
            return Color3.new(0.5, 0.5, 0.5)
        end
    end

    local function CreatePlayerHighlight(player)
        if HighlightTable[player] then return end
        
        local character = player.Character
        if not character then return end
        
        local teamColor = GetTeamColor(player)
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerHighlight"
        highlight.FillColor = teamColor
        highlight.FillTransparency = 0.7
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 0
        highlight.Adornee = character
        highlight.Parent = character
        
        HighlightTable[player] = {
            Highlight = highlight,
            TeamColor = teamColor
        }
    end

    local function UpdatePlayerHighlight(player)
        local highlightData = HighlightTable[player]
        if highlightData and highlightData.Highlight then
            local teamColor = GetTeamColor(player)
            highlightData.Highlight.FillColor = teamColor
            highlightData.TeamColor = teamColor
        end
    end

    local function RemovePlayerHighlight(player)
        local highlightData = HighlightTable[player]
        if highlightData and highlightData.Highlight then
            highlightData.Highlight:Destroy()
        end
        HighlightTable[player] = nil
    end

    if Value then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character then
                    CreatePlayerHighlight(player)
                end
                player.CharacterAdded:Connect(function()
                    CreatePlayerHighlight(player)
                end)
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                CreatePlayerHighlight(player)
            end)
        end)
        
        local teamChangedConnection
        teamChangedConnection = game:GetService("RunService").Heartbeat:Connect(function()
            for player, highlightData in pairs(HighlightTable) do
                if player and player.Team then
                    local currentTeamColor = GetTeamColor(player)
                    if highlightData.TeamColor ~= currentTeamColor then
                        UpdatePlayerHighlight(player)
                    end
                end
            end
        end)
        
        getgenv().PlayerHighlight = {
            Table = HighlightTable,
            TeamConnection = teamChangedConnection
        }
        
    else
        if getgenv().PlayerHighlight then
            if getgenv().PlayerHighlight.TeamConnection then
                getgenv().PlayerHighlight.TeamConnection:Disconnect()
            end
            
            for player, highlightData in pairs(getgenv().PlayerHighlight.Table) do
                RemovePlayerHighlight(player)
            end
            
            getgenv().PlayerHighlight = nil
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("PlayerHighlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

YU_SHEN:Toggle("高亮显示NPC", "NPCHighlight", false, function(Value)
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    
    if Value then
        local NPCHighlightTable = {}
        
        local function IsNPC(model)
            if not model:IsA("Model") then return false end
            
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            if not humanoid then return false end
            
            local isPlayer = false
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player.Character == model then
                    isPlayer = true
                    break
                end
            end
            
            return not isPlayer and humanoid.Health > 0
        end
        
        local function CreateNPCHighlight(npc)
            if NPCHighlightTable[npc] then return end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "NPCHighlight"
            highlight.FillColor = Color3.new(1, 0.5, 0)
            highlight.FillTransparency = 0.7
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.OutlineTransparency = 0
            highlight.Adornee = npc
            highlight.Parent = npc
            
            NPCHighlightTable[npc] = {
                Highlight = highlight
            }
        end
        
        local function RemoveNPCHighlight(npc)
            local highlightData = NPCHighlightTable[npc]
            if highlightData and highlightData.Highlight then
                highlightData.Highlight:Destroy()
            end
            NPCHighlightTable[npc] = nil
        end
        
        local function ScanForNPCs()
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if IsNPC(descendant) then
                    CreateNPCHighlight(descendant)
                end
            end
        end
        
        ScanForNPCs()
        
        local scanConnection
        scanConnection = RunService.Heartbeat:Connect(function()
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if IsNPC(descendant) and not NPCHighlightTable[descendant] then
                    CreateNPCHighlight(descendant)
                end
            end
            
            for npc, highlightData in pairs(NPCHighlightTable) do
                if not npc:IsDescendantOf(Workspace) then
                    RemoveNPCHighlight(npc)
                end
            end
        end)
        
        local descendantAddedConnection
        descendantAddedConnection = Workspace.DescendantAdded:Connect(function(descendant)
            if IsNPC(descendant) then
                CreateNPCHighlight(descendant)
            end
        end)
        
        getgenv().NPCHighlight = {
            Table = NPCHighlightTable,
            ScanConnection = scanConnection,
            DescendantConnection = descendantAddedConnection
        }
        
    else
        if getgenv().NPCHighlight then
            if getgenv().NPCHighlight.ScanConnection then
                getgenv().NPCHighlight.ScanConnection:Disconnect()
            end
            if getgenv().NPCHighlight.DescendantConnection then
                getgenv().NPCHighlight.DescendantConnection:Disconnect()
            end
            
            for npc, highlightData in pairs(getgenv().NPCHighlight.Table) do
                RemoveNPCHighlight(npc)
            end
            
            getgenv().NPCHighlight = nil
        end
        
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:IsA("Model") then
                for _, child in ipairs(descendant:GetChildren()) do
                    if child:IsA("Highlight") and child.Name == "NPCHighlight" then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("透视NPC", "NPCESP", false, function(Value)
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    
    if Value then
        local NPCESPTable = {}
        
        local function IsNPC(model)
            if not model:IsA("Model") then return false end
            
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            if not humanoid then return false end
            
            local isPlayer = false
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player.Character == model then
                    isPlayer = true
                    break
                end
            end
            
            return not isPlayer and humanoid.Health > 0
        end
        
        local function CreateNPCESP(npc)
            if NPCESPTable[npc] then return end
            
            local head = npc:FindFirstChild("Head") or npc:FindFirstChild("HumanoidRootPart")
            if not head then return end
            
            local billboard = Instance.new("BillboarYUui")
            billboard.Name = "NPCESP_" .. npc.Name
            billboard.Adornee = head
            billboard.Size = UDim2.new(0, 150, 0, 30)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = head
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = npc.Name
            textLabel.TextColor3 = Color3.new(1, 1, 1)
            textLabel.TextStrokeTransparency = 0
            textLabel.TextSize = 14
            textLabel.Font = Enum.Font.Gotham
            textLabel.Parent = billboard
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "NPCESP_Highlight"
            highlight.FillColor = Color3.new(0.5, 0, 0.5)
            highlight.FillTransparency = 0.7
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.OutlineTransparency = 0
            highlight.Adornee = npc
            highlight.Parent = npc
            
            NPCESPTable[npc] = {
                Billboard = billboard,
                Highlight = highlight
            }
        end
        
        local function RemoveNPCESP(npc)
            local espData = NPCESPTable[npc]
            if espData then
                if espData.Billboard then
                    espData.Billboard:Destroy()
                end
                if espData.Highlight then
                    espData.Highlight:Destroy()
                end
                NPCESPTable[npc] = nil
            end
        end
        
        local function ScanForNPCs()
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if IsNPC(descendant) then
                    CreateNPCESP(descendant)
                end
            end
        end
        
        ScanForNPCs()
        
        local scanConnection
        scanConnection = RunService.Heartbeat:Connect(function()
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if IsNPC(descendant) and not NPCESPTable[descendant] then
                    CreateNPCESP(descendant)
                end
            end
            
            for npc, espData in pairs(NPCESPTable) do
                if not npc:IsDescendantOf(Workspace) then
                    RemoveNPCESP(npc)
                end
            end
        end)
        
        local descendantAddedConnection
        descendantAddedConnection = Workspace.DescendantAdded:Connect(function(descendant)
            if IsNPC(descendant) then
                CreateNPCESP(descendant)
            end
        end)
        
        getgenv().NPCESP = {
            Table = NPCESPTable,
            ScanConnection = scanConnection,
            DescendantConnection = descendantAddedConnection
        }
        
    else
        if getgenv().NPCESP then
            if getgenv().NPCESP.ScanConnection then
                getgenv().NPCESP.ScanConnection:Disconnect()
            end
            if getgenv().NPCESP.DescendantConnection then
                getgenv().NPCESP.DescendantConnection:Disconnect()
            end
            
            for npc, espData in pairs(getgenv().NPCESP.Table) do
                RemoveNPCESP(npc)
            end
            
            getgenv().NPCESP = nil
        end
        
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:IsA("Model") then
                for _, child in ipairs(descendant:GetDescendants()) do
                    if child:IsA("BillboarYUui") and string.find(child.Name, "NPCESP_") then
                        child:Destroy()
                    end
                    if child:IsA("Highlight") and child.Name == "NPCESP_Highlight" then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("透视敌方玩家", "EnemyPlayerESP", false, function(Value)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ESPTable = {}

    local function IsEnemyPlayer(player)
        if player == LocalPlayer then return false end
        
        local localTeam = LocalPlayer.Team
        local playerTeam = player.Team
        
        if not localTeam or not playerTeam or localTeam ~= playerTeam then
            return true
        end
        
        return false
    end

    local function CreateEnemyPlayerESP(player)
        if ESPTable[player] or not IsEnemyPlayer(player) then return end
        
        local character = player.Character
        if not character then return end
        
        local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
        if not head then return end
        
        local billboard = Instance.new("BillboarYUui")
        billboard.Name = "EnemyPlayerESP_" .. player.Name
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 150, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = player.Name
        textLabel.TextColor3 = Color3.new(1, 0, 0)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = billboard
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "EnemyPlayerHighlight"
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.FillTransparency = 0.7
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 0
        highlight.Adornee = character
        highlight.Parent = character
        
        ESPTable[player] = {
            Billboard = billboard,
            Highlight = highlight
        }
    end

    local function RemoveEnemyPlayerESP(player)
        local espData = ESPTable[player]
        if espData then
            if espData.Billboard then
                espData.Billboard:Destroy()
            end
            if espData.Highlight then
                espData.Highlight:Destroy()
            end
            ESPTable[player] = nil
        end
    end

    local function UpdateEnemyPlayers()
        for _, player in pairs(Players:GetPlayers()) do
            if IsEnemyPlayer(player) then
                if not ESPTable[player] and player.Character then
                    CreateEnemyPlayerESP(player)
                end
            else
                if ESPTable[player] then
                    RemoveEnemyPlayerESP(player)
                end
            end
        end
    end

    if Value then
        for _, player in pairs(Players:GetPlayers()) do
            if IsEnemyPlayer(player) and player.Character then
                CreateEnemyPlayerESP(player)
            end
            player.CharacterAdded:Connect(function()
                if IsEnemyPlayer(player) then
                    CreateEnemyPlayerESP(player)
                end
            end)
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                if IsEnemyPlayer(player) then
                    CreateEnemyPlayerESP(player)
                end
            end)
        end)
        
        local teamCheckConnection
        teamCheckConnection = game:GetService("RunService").Heartbeat:Connect(function()
            UpdateEnemyPlayers()
        end)
        
        getgenv().EnemyPlayerESP = {
            Table = ESPTable,
            Connection = teamCheckConnection
        }
        
    else
        if getgenv().EnemyPlayerESP then
            if getgenv().EnemyPlayerESP.Connection then
                getgenv().EnemyPlayerESP.Connection:Disconnect()
            end
            
            for player, espData in pairs(getgenv().EnemyPlayerESP.Table) do
                RemoveEnemyPlayerESP(player)
            end
            
            getgenv().EnemyPlayerESP = nil
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
                if head then
                    local esp = head:FindFirstChild("EnemyPlayerESP_" .. player.Name)
                    if esp then
                        esp:Destroy()
                    end
                end
                local highlight = player.Character:FindFirstChild("EnemyPlayerHighlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

YU_SHEN:Toggle("透视敌方NPC", "EnemyNPCESP", false, function(Value)
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    
    local function IsEnemyNPC(model)
        if not model:IsA("Model") then return false end
        
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        
        local isPlayer = false
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player.Character == model then
                isPlayer = true
                break
            end
        end
        
        if isPlayer then return false end
        
        local localTeam = game.Players.LocalPlayer.Team
        local npcTeam = model:FindFirstChild("Team") or model:FindFirstChildOfClass("Team")
        
        if not localTeam or not npcTeam or localTeam ~= npcTeam then
            return true
        end
        
        return false
    end
    
    local function CreateEnemyNPCESP(npc)
        if EnemyNPCESPTable[npc] then return end
        
        local head = npc:FindFirstChild("Head") or npc:FindFirstChild("HumanoidRootPart")
        if not head then return end
        
        local billboard = Instance.new("BillboarYUui")
        billboard.Name = "EnemyNPCESP_" .. npc.Name
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 150, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = npc.Name
        textLabel.TextColor3 = Color3.new(1, 0, 0)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.Gotham
        textLabel.Parent = billboard
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "EnemyNPCHighlight"
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.FillTransparency = 0.7
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 0
        highlight.Adornee = npc
        highlight.Parent = npc
        
        EnemyNPCESPTable[npc] = {
            Billboard = billboard,
            Highlight = highlight
        }
    end
    
    local function RemoveEnemyNPCESP(npc)
        local espData = EnemyNPCESPTable[npc]
        if espData then
            if espData.Billboard then
                espData.Billboard:Destroy()
            end
            if espData.Highlight then
                espData.Highlight:Destroy()
            end
            EnemyNPCESPTable[npc] = nil
        end
    end
    
    local function ScanForEnemyNPCs()
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if IsEnemyNPC(descendant) then
                CreateEnemyNPCESP(descendant)
            end
        end
    end

    if Value then
        local EnemyNPCESPTable = {}
        
        ScanForEnemyNPCs()
        
        local scanConnection
        scanConnection = RunService.Heartbeat:Connect(function()
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if IsEnemyNPC(descendant) and not EnemyNPCESPTable[descendant] then
                    CreateEnemyNPCESP(descendant)
                end
            end
            
            for npc, espData in pairs(EnemyNPCESPTable) do
                if not npc:IsDescendantOf(Workspace) or not IsEnemyNPC(npc) then
                    RemoveEnemyNPCESP(npc)
                end
            end
        end)
        
        local descendantAddedConnection
        descendantAddedConnection = Workspace.DescendantAdded:Connect(function(descendant)
            if IsEnemyNPC(descendant) then
                CreateEnemyNPCESP(descendant)
            end
        end)
        
        getgenv().EnemyNPCESP = {
            Table = EnemyNPCESPTable,
            ScanConnection = scanConnection,
            DescendantConnection = descendantAddedConnection
        }
        
    else
        if getgenv().EnemyNPCESP then
            if getgenv().EnemyNPCESP.ScanConnection then
                getgenv().EnemyNPCESP.ScanConnection:Disconnect()
            end
            if getgenv().EnemyNPCESP.DescendantConnection then
                getgenv().EnemyNPCESP.DescendantConnection:Disconnect()
            end
            
            for npc, espData in pairs(getgenv().EnemyNPCESP.Table) do
                RemoveEnemyNPCESP(npc)
            end
            
            getgenv().EnemyNPCESP = nil
        end
        
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:IsA("Model") then
                for _, child in ipairs(descendant:GetDescendants()) do
                    if child:IsA("BillboarYUui") and string.find(child.Name, "EnemyNPCESP_") then
                        child:Destroy()
                    end
                    if child:IsA("Highlight") and string.find(child.Name, "EnemyNPCHighlight") then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("ESP", "SimpleESP", false, function(state)
    pcall(function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboarYUui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
                    circle.AnchorPoint = Vector2.new(0.5, 0.5)
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246"
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboarYUui") then
                        player.Character:FindFirstChildOfClass("BillboarYUui"):Destroy()
                    end
                end
            end
        end
    end)
end)

local YU_Tab = YU:Tab("超级无敌旋转", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("旋转清零", function()
    loadstring(game:HttpGet("https://pastefy.app/UOWFy58g/raw"))()
end)
YU_SHEN:Button("旋转10", function()
    loadstring(game:HttpGet("https://pastefy.app/pX8CKeHn/raw"))()
end)
YU_SHEN:Button("旋转30", function()
    loadstring(game:HttpGet("https://pastefy.app/1Ob0oE2h/raw"))()
end)
YU_SHEN:Button("旋转50", function()
    loadstring(game:HttpGet("https://pastefy.app/4UL7XrJU/raw"))()
end)
YU_SHEN:Button("旋转100", function()
    loadstring(game:HttpGet("https://pastefy.app/6agZDErY/raw"))()
end)
YU_SHEN:Button("旋转150", function()
    loadstring(game:HttpGet("https://pastefy.app/MqAalYjs/raw"))()
end)
YU_SHEN:Button("旋转200", function()
    loadstring(game:HttpGet("https://pastefy.app/00mtNBML/raw"))()
end)
YU_SHEN:Button("旋转250", function()
    loadstring(game:HttpGet("https://pastefy.app/CR2woYXY/raw"))()
end)
YU_SHEN:Button("旋转300", function()
    loadstring(game:HttpGet("https://pastefy.app/5SbEaumY/raw"))()
end)
YU_SHEN:Button("旋转400", function()
    loadstring(game:HttpGet("https://pastefy.app/pjkZd07i/raw"))()
end)
YU_SHEN:Button("旋转500", function()
    loadstring(game:HttpGet("https://pastefy.app/9emFsJ7N/raw"))()
end)

local YU_Tab = YU:Tab("范围", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("范围清空", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/RqrTrPF5"))()
end)
YU_SHEN:Button("范围10", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/DT94B37a"))()
end)
YU_SHEN:Button("范围20", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/Kyyt1e4g"))()
end)
YU_SHEN:Button("范围50", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/pMtKEgWd"))()
end)
YU_SHEN:Button("范围100", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/aLBSXPYE"))()
end)
YU_SHEN:Button("范围150", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/RWxsQuU9"))()
end)
YU_SHEN:Button("范围200", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/hbp3RV2p"))()
end)
YU_SHEN:Button("范围300", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/x8cZhegq"))()
end)
YU_SHEN:Button("范围400", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/LixK0gG3"))()
end)
YU_SHEN:Button("范围500", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/yXWMGLYJ"))()
end)

local YU_Tab = YU:Tab("传送和甩飞", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

local playerList = {}
local playernamedied = ""
local RunService = game:GetService("RunService")
local selectedPlayer = nil

local function createPlayerDropdown()
    playerList = {}
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        table.insert(playerList, player.Name)
    end
    
    YU_SHEN:Dropdown("<玩家", "SelectPlayer", playerList, function(selectedPlayerName)
        if selectedPlayerName and selectedPlayerName ~= "" then
            selectedPlayer = game:GetService("Players"):FindFirstChild(selectedPlayerName)
            playernamedied = selectedPlayerName
            print("已选择玩家: " .. selectedPlayerName)
        end
    end)
end

createPlayerDropdown()

YU_SHEN:Button("刷新玩家列表", function()
    createPlayerDropdown()
end)

YU_SHEN:Button("传送到玩家旁边", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Notify("宇神", "已经传送到玩家身边", "rbxassetid://", 5)
    else
        Notify("宇神", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

YU_SHEN:Button("把玩家传送过来", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        tp_player.Character.HumanoidRootPart.CFrame = HumRoot.CFrame + Vector3.new(0, 3, 0)
        Notify("宇神", "已传送过来", "rbxassetid://", 5)
    else
        Notify("宇神", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

YU_SHEN:Toggle("锁定传送", 'LockTPToggle', false, function(state)
    getgenv().LockTPEnabled = state
    local connection
    
    if state and playernamedied ~= "" then
        local selectedPlayer = game.Players:FindFirstChild(playernamedied)
        
        connection = RunService.Heartbeat:Connect(function()
            if not getgenv().LockTPEnabled or not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if connection then
                    connection:Disconnect()
                end
                return
            end
            
            local targetPos = selectedPlayer.Character.HumanoidRootPart.Position
            local localPlayer = game.Players.LocalPlayer
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(3, 0, 3))
            end
        end)
        
        Notify("宇神", "锁定传送已开启", "rbxassetid://", 5)
    else
        if connection then
            connection:Disconnect()
        end
        Notify("宇神", "锁定传送已关闭", "rbxassetid://", 5)
    end
end)

YU_SHEN:Toggle("循环把玩家传送过来", 'LoopTPToggle', false, function(state)
    getgenv().LoopTPEnabled = state
    local connection
    
    if state and playernamedied ~= "" then
        local selectedPlayer = game.Players:FindFirstChild(playernamedied)
        
        connection = RunService.Heartbeat:Connect(function()
            if not getgenv().LoopTPEnabled or not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                if connection then
                    connection:Disconnect()
                end
                return
            end
            
            local myChar = game.Players.LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local myPos = myChar.HumanoidRootPart.Position
                selectedPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(myPos + Vector3.new(3, 0, 3))
            end
        end)
        
        Notify("宇神", "循环传送已开启", "rbxassetid://", 5)
    else
        if connection then
            connection:Disconnect()
        end
        Notify("宇神", "循环传送已关闭", "rbxassetid://", 5)
    end
end)

YU_SHEN:Toggle("查看玩家", 'SpectateToggle', false, function(state)
    if state then
        local targetPlayer = game:GetService('Players'):FindFirstChild(playernamedied)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
            game:GetService('Workspace').CurrentCamera.CameraSubject = targetPlayer.Character.Humanoid
            Notify("宇神", "已开启查看玩家", "rbxassetid://", 5)
        else
            Notify("宇神", "无法查看玩家", "rbxassetid://", 5)
        end
    else
        local lp = game.Players.LocalPlayer
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            game:GetService('Workspace').CurrentCamera.CameraSubject = lp.Character.Humanoid
        end
        Notify("宇神", "已关闭查看玩家", "rbxassetid://", 5)
    end
end)

YU_SHEN:Button("甩飞一次选中的人", function()
    local Player = game:GetService("Players").LocalPlayer
    local TargetPlayer = game.Players:FindFirstChild(playernamedied)
    if not TargetPlayer or TargetPlayer == Player then
        Notify("宇神", "无玩家可甩飞", "rbxassetid://", 5)
        return
    end

    local Message = function(_Title, _Text, Time)
        Notify(_Title, _Text, "rbxassetid://", Time)
    end

    local pid = game.PlaceId
    if pid == 189707 then
        local rs = game:GetService("RunService")
        local hb = rs.Heartbeat
        local rsd = rs.RenderStepped
        local lp = game.Players.LocalPlayer
        local z = Vector3.zero
        local function f(c)
            local r = c:WaitForChild("HumanoidRootPart")
            if r then
                local con
                con = hb:Connect(function()
                    if not r.Parent then
                        con:Disconnect()
                    end
                    local v = r.AssemblyLinearVelocity
                    r.AssemblyLinearVelocity = z
                    rsd:Wait()
                    r.AssemblyLinearVelocity = v
                end)
            end
        end
        f(lp.Character)
        lp.CharacterAdded:Connect(f)
    end

    local SkidFling = function(Target)
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        local TCharacter = Target.Character
        local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = THumanoid and THumanoid.RootPart
        local THead = TCharacter and TCharacter:FindFirstChild("Head")
        local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
        local Handle = Accessory and Accessory:FindFirstChild("Handle")

        if not (Character and Humanoid and RootPart and TCharacter and THumanoid) then
            return Message("宇神", "玩家已趋势", 2)
        end
        if THumanoid.Sit then return Message("宇神", "目标处于坐姿", 2) end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then return Message("宇神", "玩家已趋势", 2) end

        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        else
            workspace.CurrentCamera.CameraSubject = THumanoid
        end

        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= Target.Character or Target.Parent ~= game:GetService("Players") or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0/0
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            SFBasePart((TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 and THead or TRootPart)
        elseif TRootPart then
            SFBasePart(TRootPart)
        elseif THead then
            SFBasePart(THead)
        elseif Handle then
            SFBasePart(Handle)
        else
            return Message("宇神", "玩家已趋势", 2)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        getgenv().FPDH = getgenv().FPDH or workspace.FallenPartsDestroyHeight

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new() end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
        Message("宇神", "已甩飞选中玩家", 2)
    end

    if TargetPlayer.UserId ~= 1414978355 then
        SkidFling(TargetPlayer)
    else
        Message("宇神", "该玩家存在甩飞名单", 2)
    end
end)

YU_SHEN:Toggle("循环甩飞", 'LoopFlingToggle', false, function(state)
    getgenv().LoopFlingEnabled = state
    local isRunning = false
 
    local function performFling()
        if not getgenv().LoopFlingEnabled or not playernamedied or playernamedied == "" or isRunning then
            return
        end
        
        local selectedPlayer = game.Players:FindFirstChild(playernamedied)
        if not selectedPlayer or selectedPlayer == game.Players.LocalPlayer then
            Notify("宇神", "无玩家可甩飞", "rbxassetid://", 2)
            isRunning = false
            return
        end

        isRunning = true
        local Player = game.Players.LocalPlayer
        local Target = selectedPlayer
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        local TCharacter = Target.Character
        local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = THumanoid and THumanoid.RootPart
        local THead = TCharacter and TCharacter:FindFirstChild("Head")
        local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
        local Handle = Accessory and Accessory:FindFirstChild("Handle")
 
        if not (Character and Humanoid and RootPart and TCharacter and THumanoid) then
            Notify("宇神", "无玩家可甩飞", "rbxassetid://", 2)
            isRunning = false
            return
        end
        if THumanoid.Sit then
            Notify("宇神", "目标处于坐姿", "rbxassetid://", 2)
            isRunning = false
            return
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            Notify("宇神", "玩家已趋势", "rbxassetid://", 2)
            isRunning = false
            return
        end
 
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        else
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
 
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
 
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
 
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0, 1.2, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
 
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= Target.Character or Target.Parent ~= game:GetService("Players") or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end
 
        workspace.FallenPartsDestroyHeight = 0/0
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
 
        if TRootPart and THead then
            SFBasePart((TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 and THead or TRootPart)
        elseif TRootPart then
            SFBasePart(TRootPart)
        elseif THead then
            SFBasePart(THead)
        elseif Handle then
            SFBasePart(Handle)
        end
 
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        getgenv().FPDH = getgenv().FPDH or workspace.FallenPartsDestroyHeight
 
        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new() end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
 
        isRunning = false
        task.wait(0.01)
        if getgenv().LoopFlingEnabled then
            performFling()
        end
    end
 
    if state and playernamedied ~= "" then
        performFling()
        Notify("宇神", "循环甩飞已开启", "rbxassetid://", 2)
    else
        Notify("宇神", "循环甩飞已关闭", "rbxassetid://", 2)
    end
end)

YU_SHEN:Button("甩飞所有人", function()
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local hasPlayers = false
    
    for _,x in next, Players:GetPlayers() do
        if x ~= Player then
            hasPlayers = true
            break
        end
    end
    
    if not hasPlayers then
        Notify("宇神", "无玩家可以甩飞", "rbxassetid://", 2)
        return
    end

    local SkidFling = function(TargetPlayer)
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        local TCharacter = TargetPlayer.Character
        local THumanoid
        local TRootPart
        local THead
        local Accessory
        local Handle
        
        if TCharacter and TCharacter:FindFirstChildOfClass("Humanoid") then
            THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
        end
        if THumanoid and THumanoid.RootPart then
            TRootPart = THumanoid.RootPart
        end
        if TCharacter and TCharacter:FindFirstChild("Head") then
            THead = TCharacter.Head
        end
        if TCharacter and TCharacter:FindFirstChildOfClass("Accessory") then
            Accessory = TCharacter:FindFirstChildOfClass("Accessory")
        end
        if Accessory and Accessory:FindFirstChild("Handle") then
            Handle = Accessory.Handle
        end
        
        if Character and Humanoid and RootPart then
            if RootPart.Velocity.Magnitude < 50 then
                getgenv().OldPos = RootPart.CFrame
            end
            
            if THead then
                workspace.CurrentCamera.CameraSubject = THead
            elseif not THead and Handle then
                workspace.CurrentCamera.CameraSubject = Handle
            elseif THumanoid and TRootPart then
                workspace.CurrentCamera.CameraSubject = THumanoid
            end
            
            if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                return
            end
            
            local FPos = function(BasePart, Pos, Ang)
                RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end
            
            local SFBasePart = function(BasePart)
                local TimeToWait = 2
                local Time = tick()
                local Angle = 0
                repeat
                    if RootPart and THumanoid then
                        if BasePart.Velocity.Magnitude < 50 then
                            Angle = Angle + 100
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle),0 ,0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 0.95, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                        else
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            
                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(0, 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 0.95), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                            task.wait()
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                        end
                    else
                        break
                    end
                until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or (THumanoid and THumanoid.Sit) or Humanoid.Health <= 0 or tick() > Time + TimeToWait
            end
            
            workspace.FallenPartsDestroyHeight = 0/0
            
            local BV = Instance.new("BodyVelocity")
            BV.Name = "EpixVel"
            BV.Parent = RootPart
            BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
            BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
            
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            
            if TRootPart and THead then
                if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                    SFBasePart(THead)
                else
                    SFBasePart(TRootPart)
                end
            elseif TRootPart and not THead then
                SFBasePart(TRootPart)
            elseif not TRootPart and THead then
                SFBasePart(THead)
            elseif not TRootPart and not THead and Accessory and Handle then
                SFBasePart(Handle)
            else
                return Notify("宇神", "玩家已趋势", "rbxassetid://", 2)
            end
            
            BV:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = Humanoid
            
            repeat
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                Humanoid:ChangeState("GettingUp")
                table.foreach(Character:GetChildren(), function(_, x)
                    if x:IsA("BasePart") then
                        x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end)
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
            workspace.FallenPartsDestroyHeight = getgenv().FPDH
        else
            return Notify("宇神", "随机错误", "rbxassetid://", 2)
        end
    end

    for _,x in next, Players:GetPlayers() do
        if x ~= Player then
            if x.UserId ~= 1414978355 then
                SkidFling(x)
            else
                Notify("宇神", "玩家 " .. x.Name .. " 存在甩飞名单", "rbxassetid://", 2)
            end
        end
    end
    
    Notify("宇神", "已开始甩飞所有人", "rbxassetid://", 2)
end)

local YU_Tab = YU:Tab("FE", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("FE C00lgui", function()
loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)
YU_SHEN:Button("FE 1x1x1x1", function()
loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()
end)
YU_SHEN:Button("FE大长腿", function()
    loadstring(game:HttpGet('https://gist.githubusercontent.com/1BlueCat/7291747e9f093555573e027621f08d6e/raw/23b48f2463942befe19d81aa8a06e3222996242c/FE%2520Da%2520Feets'))()
end)
YU_SHEN:Button("FE用头", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/BK4Q0DfU"))()
end)
YU_SHEN:Button("复仇者", function()
    loadstring(game:HttpGet(('https://pastefy.ga/iGyVaTvs/raw'),true))()
end)
YU_SHEN:Button("鼠标", function()
    loadstring(game:HttpGet(('https://pastefy.ga/V75mqzaz/raw'),true))()
end)
YU_SHEN:Button("变怪物", function()
    loadstring(game:HttpGetAsync("https://pastebin.com/raw/jfryBKds"))()
end)
YU_SHEN:Button("香蕉枪", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()
end)
YU_SHEN:Button("超长🐔巴", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ESWSFND7", true))()
end)
YU_SHEN:Button("操人", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/AHAJAJAKAK/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A.LUA", true))()
end)
YU_SHEN:Button("FE动画中心", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
end)
YU_SHEN:Button("FE变玩家", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()
end)
YU_SHEN:Button("FE猫娘R63", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua"))()
end)
YU_SHEN:Button("FE", function()
    loadstring(game:HttpGet('https://pastefy.ga/a7RTi4un/raw'))()
end)

local YU_Tab = YU:Tab("光影", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("光影", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

YU_SHEN:Button("光影滤镜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

YU_SHEN:Button("超高画质",function()
loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

YU_SHEN:Button("光影V4",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

YU_SHEN:Button("RTX高仿",function()
loadstring(game:HttpGet('https://pastebin.com/raw/Bkf0BJb3'))()
end)

YU_SHEN:Button("光影深", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
YU_SHEN:Button("光影浅", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

local YU_Tab = YU:Tab("Taxi boss", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

local AutoMoneyToggle = false
YU_SHEN:Toggle("自动金钱", function()
    AutoMoneyToggle = not AutoMoneyToggle
    if AutoMoneyToggle then
        print("自动金钱已启用")
    else
        print("自动金钱已禁用")
    end
end)

local AutoSnowToggle = false
YU_SHEN:Toggle("自动收集雪堆", function()
    AutoSnowToggle = not AutoSnowToggle
    if AutoSnowToggle then
        print("自动收集雪堆已启用")
    else
        print("自动收集雪堆已禁用")
    end
end)

local AutoPartsToggle = false
YU_SHEN:Toggle("自动收集零件", function()
    AutoPartsToggle = not AutoPartsToggle
    if AutoPartsToggle then
        print("自动收集零件已启用")
    else
        print("自动收集零件已禁用")
    end
end)

local AutoOfficeToggle = false
YU_SHEN:Toggle("自动升级办公室", function()
    AutoOfficeToggle = not AutoOfficeToggle
    if AutoOfficeToggle then
        print("自动升级办公室已启用")
    else
        print("自动升级办公室已禁用")
    end
end)

YU_SHEN:Button("购买车辆", function()
    local value = "车辆名称"
    if value and value ~= "" then
        pcall(function()
            local moduleList = ReplicatedStorage:FindFirstChild("ModuleLists")
            if moduleList then
                local carListModule = moduleList:FindFirstChild("CarList")
                if carListModule then
                    local carList = require(carListModule)
                    for i, v in pairs(carList) do
                        if v.name and string.find(string.lower(v.name), string.lower(value)) then
                            ReplicatedStorage.DataStore.PurchaseVehicle:InvokeServer(v.id)
                            print("已购买: " .. v.name)
                            break
                        end
                    end
                end
            end
        end)
    end
end)

local InfAccelerationToggle = false
YU_SHEN:Button("无限加速", function()
    InfAccelerationToggle = not InfAccelerationToggle
    if InfAccelerationToggle then
        print("无限加速已启用")
    else
        print("无限加速已禁用")
    end
end)

local DonutGodToggle = false
YU_SHEN:Button("甜甜圈模式", function()
    DonutGodToggle = not DonutGodToggle
    if DonutGodToggle then
        print("甜甜圈模式已启用")
    else
        print("甜甜圈模式已禁用")
    end
end)

local locations1 = {
    "无", "山毛榉林", "山毛榉林海滩", "老板机场", "桥景",
    "雪松边", "中央银行", "中央城市", "城市公园",
    "椰子公园", "乡村俱乐部", "达山", "道奇港"
}

local TeleportDropdown1 = "无"
local locations2 = {
    "无", "海洋观景点", "炼油厂", "旧城区", "繁华街",
    "小镇", "圣诺尔观景点", "阳光小学", "日落林",
    "出租车中心", "高中", "商场", "海滩", "赛车俱乐部"
}

local TeleportDropdown2 = "无"

YU_SHEN:Button("传送地点1", function()
    print("选择传送地点1: " .. TeleportDropdown1)
end)

YU_SHEN:Button("传送地点2", function()
    print("选择传送地点2: " .. TeleportDropdown2)
end)

local AutoTrophiesToggle = false
YU_SHEN:Button("自动奖杯", function()
    AutoTrophiesToggle = not AutoTrophiesToggle
    if AutoTrophiesToggle then
        print("自动奖杯已启用")
    else
        print("自动奖杯已禁用")
    end
end)

local AutoMedalsToggle = false
YU_SHEN:Button("自动计时赛奖牌", function()
    AutoMedalsToggle = not AutoMedalsToggle
    if AutoMedalsToggle then
        print("自动计时赛奖牌已启用")
    else
        print("自动计时赛奖牌已禁用")
    end
end)

local YU_Tab = YU:Tab("俄亥俄州", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("全部气球", function()
    local function getAllBalloons()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        pcall(function()
            local itemSystem = require(ReplicatedStorage.devv).load("v3item")
            local inventory = itemSystem.inventory
            
            local fistsItem = nil
            for guid, item in pairs(inventory.items) do
                if item.name == "Fists" then
                    fistsItem = item
                    break
                end
            end
            
            local hdir = ReplicatedStorage.devv.shared.Indicies.v3items.bin.Holdable
            if hdir then
                for _, hmd in pairs(hdir:GetChildren()) do
                    if hmd:IsA("ModuleScript") then
                        pcall(function()
                            local hdat = require(hmd)
                            if hdat and hdat.name and hdat.holdableType == "Balloon" then
                                local hnew = {
                                    name = hdat.name,
                                    guid = hdat.name:gsub("%s", "_"):lower() .. "_" .. tostring(tick()),
                                    modelName = hdat.modelName or hdat.name,
                                    holdableType = "Balloon",
                                    multiplier = hdat.multiplier or 0.5,
                                    movespeedAdd = hdat.movespeedAdd or 0,
                                    canDrop = false,
                                    cannotDiscard = true,
                                    permanent = true,
                                    unpurchasable = true,
                                    TPSOffsets = hdat.TPSOffsets or {},
                                    viewportOffsets = hdat.viewportOffsets or (fistsItem and fistsItem.viewportOffsets)
                                }
                                if inventory.add then
                                    inventory.add(hnew, false)
                                    if inventory.currentItemsData then
                                        table.insert(inventory.currentItemsData, hnew)
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            
            if fistsItem then
                local fistsCopy = {
                    name = "Fists",
                    guid = "fists_copy_" .. tostring(tick()),
                    permanent = true,
                    cannotDiscard = true,
                    doMakeModel = false,
                    debounce = 0.3,
                    damageTable = {
                        meleepunch = 15,
                        meleemegapunch = 200,
                        meleekick = 20,
                        meleejumpKick = 20
                    },
                    viewportOffsets = fistsItem.viewportOffsets,
                    TPSOffsets = fistsItem.TPSOffsets or {},
                    FPSOffsets = fistsItem.FPSOffsets or {}
                }
                if inventory.add then
                    inventory.add(fistsCopy, false)
                end
            end
            
            if inventory.rerender then
                inventory:rerender()
            end
        end)
    end
    
    getAllBalloons()
end)

YU_SHEN:Button("美金球", function()
    local function getDollarBalloon()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        pcall(function()
            local itemSystem = require(ReplicatedStorage.devv).load("v3item")
            local inventory = itemSystem.inventory
            
            local fistsItem = nil
            for guid, item in pairs(inventory.items) do
                if item.name == "Fists" then
                    fistsItem = item
                    break
                end
            end
            
            local dollarBalloonData = {
                name = "Dollar Balloon",
                guid = "dollar_balloon_" .. tostring(tick()),
                modelName = "Dollar Balloon",
                holdableType = "Balloon",
                multiplier = 0.8,
                movespeedAdd = 8,
                canDrop = false,
                cannotDiscard = true,
                permanent = true,
                unpurchasable = true,
                TPSOffsets = {
                    hold = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0)
                },
                viewportOffsets = {
                    hotbar = {
                        dist = 4,
                        offset = CFrame.new(0, 0, 0),
                        rotoffset = CFrame.Angles(0, 0, 0)
                    },
                    ammoHUD = {
                        dist = 5,
                        offset = CFrame.new(0, 0, 0),
                        rotoffset = CFrame.Angles(0, 0, 0)
                    }
                }
            }
            
            if inventory.add then
                inventory.add(dollarBalloonData, false)
                if inventory.currentItemsData then
                    table.insert(inventory.currentItemsData, dollarBalloonData)
                end
            end
            
            if fistsItem then
                local fistsCopy = {
                    name = "Fists",
                    guid = "fists_copy_" .. tostring(tick()),
                    permanent = true,
                    cannotDiscard = true,
                    doMakeModel = false,
                    debounce = 0.3,
                    damageTable = {
                        meleepunch = 15,
                        meleemegapunch = 200,
                        meleekick = 20,
                        meleejumpKick = 20
                    },
                    viewportOffsets = fistsItem.viewportOffsets,
                    TPSOffsets = fistsItem.TPSOffsets or {},
                    FPSOffsets = fistsItem.FPSOffsets or {}
                }
                if inventory.add then
                    inventory.add(fistsCopy, false)
                end
            end
            
            if inventory.rerender then
                inventory:rerender()
            end
        end)
    end
    
    getDollarBalloon()
end)

YU_SHEN:Button("自动拾取气球和打印器", function()
    local autob = true
    while autob and wait() do 
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        local rootPart = localPlayer.Character.HumanoidRootPart

        for _, l in pairs(game.Workspace.Game.Entities.ItemPickup:GetChildren()) do
            for _, v in pairs(l:GetChildren()) do
                if v:IsA("MeshPart") or v:IsA("Part") then
                    local e = v:FindFirstChildOfClass("ProximityPrompt")
                    if e and (e.ObjectText == "Bat Balloon" or e.ObjectText == "Gold Clover Balloon" or e.ObjectText == "Golden Rose" or e.ObjectText == "Black Rose" or e.ObjectText == "Heart Balloon" or e.ObjectText == "Skull Balloon" or e.ObjectText == "Money Printer") then
                        rootPart.CFrame = v.CFrame * CFrame.new(0, 2, 0)
                        e.RequiresLineOfSight = false
                        e.HoldDuration = 0
                        fireproximityprompt(e)
                    end
                end
            end
        end
    end
end)

YU_SHEN:Button("自动拾取宝石", function()
    local autobs = true
    while autobs and wait() do 
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        local rootPart = localPlayer.Character.HumanoidRootPart

        for _, l in pairs(game.Workspace.Game.Entities.ItemPickup:GetChildren()) do
            for _, v in pairs(l:GetChildren()) do
                if v:IsA("MeshPart") or v:IsA("Part") then
                    local e = v:FindFirstChildOfClass("ProximityPrompt")
                    if e and (e.ObjectText == "Amethyst" or e.ObjectText == "Sapphire" or e.ObjectText == "Emerald"  or e.ObjectText == "Topaz"  or e.ObjectText == "Ruby"  or e.ObjectText == "Diamond Ring"  or e.ObjectText == "Diamond" or e.ObjectText == "Void Gem" or e.ObjectText == "Dark Matter Gem" or e.ObjectText == "Rollie" or e.ObjectText == "Gold Bar") then
                        rootPart.CFrame = v.CFrame * CFrame.new(0, 2, 0)
                        e.RequiresLineOfSight = false
                        e.HoldDuration = 0
                        fireproximityprompt(e)
                    end
                end
            end
        end
    end
end)

YU_SHEN:Button("自动开启保险", function()
    local bxbx = true
    while bxbx and wait() do
        local epoh2 = game:GetService("Players")
        local epoh3 = epoh2.LocalPlayer.Character.HumanoidRootPart
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        if localPlayer.Character then
            local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                for _, obj in ipairs(workspace.Game.Entities.GoldJewelSafe:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and (obj.ActionText == "Crack Chest" or obj.ActionText == "Crack Safe") and obj.Enabled then
                        if bxbx then
                            obj.RequiresLineOfSight = false
                            obj.HoldDuration = 0
                            local target = obj.Parent and obj.Parent.Parent
                            if target and target:IsA("BasePart") then
                                local snow4 = target.CFrame * CFrame.new(0, 2, 2)
                                local snow5 = game:GetService("Players")
                                local snow6 = snow5.LocalPlayer.Character.HumanoidRootPart
                                snow6.CFrame = snow4
                                wait(0.5)
                                fireproximityprompt(obj)
                            end
                        end
                    end
                end
            end
        end
    end
end)

YU_SHEN:Button("自动购买撬锁", function()
    local lock = true
    while lock and wait() do
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer
        if localPlayer.Character then
            local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                Signal.InvokeServer("attemptPurchase", "Lockpick")
            end
        end
    end
end)

YU_SHEN:Button("绕过表情动作系统", function()
    for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Emotes.Frame.ScrollingFrame:GetDescendants()) do
        if v.Name == "Locked" then
            v.Visible = false
        end
    end
end)

YU_SHEN:Button("绕过移动经销商系统", function()
    game:GetService("Players").LocalPlayer:SetAttribute("mobileDealer",true)
    local ReplicatedStorage=game:GetService("ReplicatedStorage")
    local mobileDealer=require(ReplicatedStorage.devv.shared.Indicies.mobileDealer)
    for category,items in pairs(mobileDealer) do 
        for _,item in ipairs(items) do 
            item.stock=999999 
        end 
    end
    local ReplicatedStorage=game:GetService("ReplicatedStorage")
    local mobileDealer=require(ReplicatedStorage.devv.shared.Indicies.mobileDealer)
    table.insert(mobileDealer.Gun,{itemName="Acid Gun",stock=999999})
    table.insert(mobileDealer.Gun,{itemName="Candy Bucket",stock=999999})
end)

YU_SHEN:Button("绕过战斗状态系统", function()
    for _, func in pairs(getgc(true)) do
        if type(func) == "function" then
            local info = debug.getinfo(func)
            if info.name == "isInCombat" or (info.source and info.source:find("combatIndicator")) then
                hookfunction(func, function() 
                    return false 
                end)
            end
        end
    end
end)

YU_SHEN:Button("普通气球美化美金气球", function()
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
            v.name, v.cost, v.unpurchasable, v.multiplier, v.movespeedAdd, v.cannotDiscard = "Dollar Balloon", 200, true, 0.8, 8, true
            if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0) end
            if v.viewportOffsets and v.viewportOffsets.hotbar then v.viewportOffsets.hotbar.dist = 4 end
            v.canDrop, v.dropCooldown, v.craft = nil
            break
        end
    end

    for _, item in pairs(require(game.ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
        if item.name == "Dollar Balloon" then
            for _, btn in pairs({item.button, item.backpackButton}) do
                if btn and btn.resetModelSkin then btn:resetModelSkin() end
            end
        end
    end
end)

YU_SHEN:Button("普通气球美化黑玫瑰气球", function()
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "name") == "Balloon" and rawget(v, "holdableType") == "Balloon" then
            v.name, v.cost, v.unpurchasable, v.multiplier, v.movespeedAdd, v.cannotDiscard = "Black Rose", 200, true, 0.75, 12, true
            if v.TPSOffsets then v.TPSOffsets.hold = CFrame.new(0, 0.5, 0) end
            if v.viewportOffsets and v.viewportOffsets.hotbar then v.viewportOffsets.hotbar.dist = 3 end
            v.canDrop, v.dropCooldown, v.craft = nil
            break
        end
    end

    for _, item in pairs(require(game.ReplicatedStorage.devv.client.Objects.v3item.modules.inventory).items) do
        if item.name == "Black Rose" then
            for _, btn in pairs({item.button, item.backpackButton}) do
                if btn and btn.resetModelSkin then btn:resetModelSkin() end
            end
        end
    end
end)

YU_SHEN:Button("美化钱包", function()
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "name") == "Wallet" then
            v.name = "Duffel Bag"
            v.modelName = "Duffel Bag"
            v.subtype = "Wallet"
            if v.TPSOffsets then
                v.TPSOffsets.hold = CFrame.new(-0.1, -1, 0.1)
            end
            if v.viewportOffsets and v.viewportOffsets.hotbar then
                v.viewportOffsets.hotbar.offset = CFrame.new(0.1, 0.2, -2.5)
                v.viewportOffsets.hotbar.rotoffset = CFrame.Angles(0.7853981633974483, 2.6179938779914944, 0)
            end
            break
        end
    end

    local inventory = require(game.ReplicatedStorage.devv.client.Objects.v3item.modules.inventory)
    for _, item in pairs(inventory.items) do
        if item.name == "Duffel Bag" then
            if item.button and item.button.resetModelSkin then
                item.button:resetModelSkin()
            end
            if item.backpackButton and item.backpackButton.resetModelSkin then
                item.backpackButton:resetModelSkin()
            end
        end
    end
end)

YU_SHEN:Button("即时互动", function()
    workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("ProximityPrompt") then
            obj.HoldDuration = 0
        end
    end)

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            obj.HoldDuration = 0
        end
    end
end)

YU_SHEN:Button("防虚空", function()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local speaker = Players.LocalPlayer
    local antivoidloop

    local function getRoot(character)
        return character and character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart")
    end

    local state = true
    if state then
        local OrgDestroyHeight = workspace.FallenPartsDestroyHeight
        antivoidloop = RunService.Stepped:Connect(function()
            local character = speaker.Character
            if character then
                local root = getRoot(character)
                if root and root.Position.Y <= OrgDestroyHeight + 25 then
                    root.Velocity = root.Velocity + Vector3.new(0, 250, 0)
                end
            end
        end)
    else
        if antivoidloop then
            antivoidloop:Disconnect()
            antivoidloop = nil
        end
    end
end)

YU_SHEN:Button("飞行V3", function()
    local main = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local up = Instance.new("TextButton")
    local down = Instance.new("TextButton")
    local onof = Instance.new("TextButton")
    local TextLabel = Instance.new("TextLabel")
    local plus = Instance.new("TextButton")
    local speed = Instance.new("TextLabel")
    local mine = Instance.new("TextButton")
    local closebutton = Instance.new("TextButton")
    local mini = Instance.new("TextButton")
    local mini2 = Instance.new("TextButton")

    main.Name = "main"
    main.Parent = game:GetService"Players".LocalPlayer:WaitForChild("PlayerGui")
    main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    main.ResetOnSpawn = false

    Frame.Parent = main
    Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
    Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
    Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
    Frame.Size = UDim2.new(0, 190, 0, 57)

    up.Name = "up"
    up.Parent = Frame
    up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
    up.Size = UDim2.new(0, 44, 0, 28)
    up.Font = Enum.Font.SourceSans
    up.Text = "上"
    up.TextColor3 = Color3.fromRGB(0, 0, 0)
    up.TextSize = 14.000

    down.Name = "down"
    down.Parent = Frame
    down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
    down.Position = UDim2.new(0, 0, 0.491228074, 0)
    down.Size = UDim2.new(0, 44, 0, 28)
    down.Font = Enum.Font.SourceSans
    down.Text = "下"
    down.TextColor3 = Color3.fromRGB(0, 0, 0)
    down.TextSize = 14.000

    onof.Name = "onof"
    onof.Parent = Frame
    onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
    onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
    onof.Size = UDim2.new(0, 56, 0, 28)
    onof.Font = Enum.Font.SourceSans
    onof.Text = "飞行"
    onof.TextColor3 = Color3.fromRGB(0, 0, 0)
    onof.TextSize = 14.000

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
    TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 100, 0, 28)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = "飞行V3"
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true

    plus.Name = "plus"
    plus.Parent = Frame
    plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
    plus.Position = UDim2.new(0.231578946, 0, 0, 0)
    plus.Size = UDim2.new(0, 45, 0, 28)
    plus.Font = Enum.Font.SourceSans
    plus.Text = "+"
    plus.TextColor3 = Color3.fromRGB(0, 0, 0)
    plus.TextScaled = true
    plus.TextSize = 14.000
    plus.TextWrapped = true

    speed.Name = "speed"
    speed.Parent = Frame
    speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
    speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
    speed.Size = UDim2.new(0, 44, 0, 28)
    speed.Font = Enum.Font.SourceSans
    speed.Text = "1"
    speed.TextColor3 = Color3.fromRGB(0, 0, 0)
    speed.TextScaled = true
    speed.TextSize = 14.000
    speed.TextWrapped = true

    mine.Name = "mine"
    mine.Parent = Frame
    mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
    mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
    mine.Size = UDim2.new(0, 45, 0, 29)
    mine.Font = Enum.Font.SourceSans
    mine.Text = "-"
    mine.TextColor3 = Color3.fromRGB(0, 0, 0)
    mine.TextScaled = true
    mine.TextSize = 14.000
    mine.TextWrapped = true

    closebutton.Name = "Close"
    closebutton.Parent = main.Frame
    closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
    closebutton.Font = "SourceSans"
    closebutton.Size = UDim2.new(0, 45, 0, 28)
    closebutton.Text = "关闭"
    closebutton.TextSize = 30
    closebutton.Position =  UDim2.new(0, 0, -1, 27)

    mini.Name = "minimize"
    mini.Parent = main.Frame
    mini.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
    mini.Font = "SourceSans"
    mini.Size = UDim2.new(0, 45, 0, 28)
    mini.Text = "隐藏"
    mini.TextSize = 40
    mini.Position = UDim2.new(0, 44, -1, 27)

    mini2.Name = "minimize2"
    mini2.Parent = main.Frame
    mini2.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
    mini2.Font = "SourceSans"
    mini2.Size = UDim2.new(0, 45, 0, 28)
    mini2.Text = "+"
    mini2.TextSize = 40
    mini2.Position = UDim2.new(0, 44, -1, 57)
    mini2.Visible = false

    speeds = 1

    local speaker = game:GetService("Players").LocalPlayer

    local chr = game:GetService"Players".LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

    nowe = false
    Frame.Active = true
    Frame.Draggable = true

    onof.MouseButton1Down:connect(function()
        if nowe == true then
            nowe = false
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        else 
            nowe = true
            for i = 1, speeds do
                spawn(function()
                    local hb = game:GetService("RunService").Heartbeat
                    tpwalking = true
                    local chr = game:GetService"Players".LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
            game:GetService"Players".LocalPlayer.Character.Animate.Disabled = true
            local Char = game:GetService"Players".LocalPlayer.Character
            local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
            for i,v in next, Hum:GetPlayingAnimationTracks() do
                v:AdjustSpeed(0)
            end
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        end

        if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            local plr = game:GetService"Players".LocalPlayer
            local torso = plr.Character.Torso
            local flying = true
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0

            local bg = Instance.new("BodyGyro", torso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = torso.CFrame
            local bv = Instance.new("BodyVelocity", torso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            if nowe == true then
                plr.Character.Humanoid.PlatformStand = true
            end
            while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
                game:GetService("RunService").RenderStepped:Wait()
                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    speed = speed+.5+(speed/maxspeed)
                    if speed > maxspeed then
                        speed = maxspeed
                    end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                    speed = speed-1
                    if speed < 0 then
                        speed = 0
                    end
                end
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                else
                    bv.velocity = Vector3.new(0,0,0)
                end
                bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            end
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            game:GetService"Players".LocalPlayer.Character.Animate.Disabled = false
            tpwalking = false
        else
            local plr = game:GetService"Players".LocalPlayer
            local UpperTorso = plr.Character.UpperTorso
            local flying = true
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0

            local bg = Instance.new("BodyGyro", UpperTorso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = UpperTorso.CFrame
            local bv = Instance.new("BodyVelocity", UpperTorso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            if nowe == true then
                plr.Character.Humanoid.PlatformStand = true
            end
            while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
                wait()
                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    speed = speed+.5+(speed/maxspeed)
                    if speed > maxspeed then
                        speed = maxspeed
                    end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                    speed = speed-1
                    if speed < 0 then
                        speed = 0
                    end
                end
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                else
                    bv.velocity = Vector3.new(0,0,0)
                end
                bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            end
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            game:GetService"Players".LocalPlayer.Character.Animate.Disabled = false
            tpwalking = false
        end
    end)

    local tis
    up.MouseButton1Down:connect(function()
        tis = up.MouseEnter:connect(function()
            while tis do
                wait()
                game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
            end
        end)
    end)

    up.MouseLeave:connect(function()
        if tis then
            tis:Disconnect()
            tis = nil
        end
    end)

    local dis
    down.MouseButton1Down:connect(function()
        dis = down.MouseEnter:connect(function()
            while dis do
                wait()
                game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
            end
        end)
    end)

    down.MouseLeave:connect(function()
        if dis then
            dis:Disconnect()
            dis = nil
        end
    end)

    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
        wait(0.7)
        game:GetService"Players".LocalPlayer.Character.Humanoid.PlatformStand = false
        game:GetService"Players".LocalPlayer.Character.Animate.Disabled = false
    end)

    plus.MouseButton1Down:connect(function()
        speeds = speeds + 1
        speed.Text = speeds
        if nowe == true then
            tpwalking = false
            for i = 1, speeds do
                spawn(function()
                    local hb = game:GetService("RunService").Heartbeat
                    tpwalking = true
                    local chr = game:GetService"Players".LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
        end
    end)
    
    mine.MouseButton1Down:connect(function()
        if speeds == 1 then
            speed.Text = 'cannot be less than 1'
            wait(1)
            speed.Text = speeds
        else
            speeds = speeds - 1
            speed.Text = speeds
            if nowe == true then
                tpwalking = false
                for i = 1, speeds do
                    spawn(function()
                        local hb = game:GetService("RunService").Heartbeat
                        tpwalking = true
                        local chr = game:GetService"Players".LocalPlayer.Character
                        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                            if hum.MoveDirection.Magnitude > 0 then
                                chr:TranslateBy(hum.MoveDirection)
                            end
                        end
                    end)
                end
            end
        end
    end)

    closebutton.MouseButton1Click:Connect(function()
        main:Destroy()
    end)

    mini.MouseButton1Click:Connect(function()
        up.Visible = false
        down.Visible = false
        onof.Visible = false
        plus.Visible = false
        speed.Visible = false
        mine.Visible = false
        mini.Visible = false
        mini2.Visible = true
        main.Frame.BackgroundTransparency = 1
        closebutton.Position =  UDim2.new(0, 0, -1, 57)
    end)

    mini2.MouseButton1Click:Connect(function()
        up.Visible = true
        down.Visible = true
        onof.Visible = true
        plus.Visible = true
        speed.Visible = true
        mine.Visible = true
        mini.Visible = true
        mini2.Visible = false
        main.Frame.BackgroundTransparency = 0 
        closebutton.Position =  UDim2.new(0, 0, -1, 27)
    end)
end)

YU_SHEN:Button("设置辅助瞄准数值", function()
    local value = 1
    game:GetService("Players").LocalPlayer:SetAttribute("aimAssistSensitivity", value)
end)

YU_SHEN:Dropdown("选择皮肤并应用", function()
    local Value = "烟火"
    local skinsec = ""
    
    if Value == "烟火" then
        skinsec = "Sparkler"
    elseif Value == "虚空" then
        skinsec = "Void"
    elseif Value == "纯金" then
        skinsec = "Solid Gold"
    elseif Value == "暗物质" then
        skinsec = "Dark Matter"
    elseif Value == "反物质" then
        skinsec = "Anti Matter"
    elseif Value == "神秘" then
        skinsec = "Hystic"
    elseif Value == "虚空神秘" then
        skinsec = "Void Mystic"
    elseif Value == "战术" then
        skinsec = "Tactical"
    elseif Value == "纯金战术" then
        skinsec = "Solid Gold Tactical"
    elseif Value == "白未来" then
        skinsec = "Future White"
    elseif Value == "黑未来" then
        skinsec = "Future Black"
    elseif Value == "圣诞未来" then
        skinsec = "Christmas Future"
    elseif Value == "礼物包装" then
        skinsec = "Gift Wrapped"
    elseif Value == "猩红" then
        skinsec = "Crimson Blood"
    elseif Value == "收割者" then
        skinsec = "Reaper"
    elseif Value == "虚空收割者" then
        skinsec = "Void Reaper"
    elseif Value == "圣诞玩具" then
        skinsec = "Christmas Toy"
    elseif Value == "荒地" then
        skinsec = "Wasteland"
    elseif Value == "隐形" then
        skinsec = "Invisible"
    elseif Value == "像素" then
        skinsec = "Pixel"
    elseif Value == "钻石像素" then
        skinsec = "Diamond Pixel"
    elseif Value == "黄金零下" then
        skinsec = "Frozen-Gold"
    elseif Value == "绿水晶" then
        skinsec = "Atomic Nature"
    elseif Value == "生物" then
        skinsec = "Biohazard"
    elseif Value == "樱花" then
        skinsec = "Sakura"
    elseif Value == "精英" then
        skinsec = "Elite"
    elseif Value == "黑樱花" then
        skinsec = "Death Blossom-Gold"
    elseif Value == "彩虹激光" then
        skinsec = "Rainbowlaser"
    elseif Value == "蓝水晶" then
        skinsec = "Atomic Water"
    elseif Value == "紫水晶" then
        skinsec = "Atomic Amethyst"
    elseif Value == "红水晶" then
        skinsec = "Atomic Flame"
    elseif Value == "零下" then
        skinsec = "Sub-Zero"
    elseif Value == "虚空射线" then
        skinsec = "Void-Ray"
    elseif Value == "冰冻钻石" then
        skinsec = "Frozen Diamond"
    elseif Value == "虚空梦魇" then
        skinsec = "Void Nightmare"
    elseif Value == "金雪" then
        skinsec = "Golden Snow"
    elseif Value == "爱国者" then
        skinsec = "Patriot"
    elseif Value == "MM2" then
        skinsec = "MM2 Barrett"
    elseif Value == "声望" then
        skinsec = "Prestige Barnett"
    elseif Value == "酷化" then
        skinsec = "Skin Walter"
    elseif Value == "蒸汽" then
        skinsec = "Steampunk"
    elseif Value == "海盗" then
        skinsec = "Pirate"
    elseif Value == "玫瑰" then
        skinsec = "Rose"
    elseif Value == "黑玫瑰" then
        skinsec = "Black Rose"
    elseif Value == "激光" then
        skinsec = "Hyperlaser"
    elseif Value == "烟花" then
        skinsec = "Firework"
    elseif Value == "诅咒背瓜" then
        skinsec = "Cursed Pumpkin"
    elseif Value == "大炮" then
        skinsec = "Cannon"
    elseif Value == "财富" then
        skinsec = "Firework"
    elseif Value == "黄金大炮" then
        skinsec = "Gold Cannon"
    elseif Value == "四叶草" then
        skinsec = "Lucky Clover"
    elseif Value == "自由" then
        skinsec = "Freedom"
    elseif Value == "黑曜石" then
        skinsec = "Obsidian"
    elseif Value == "赛博朋克" then
        skinsec = "Cyberpunk"
    end
    
    local autoskin = true
    if autoskin then
        local it = require(game:GetService("ReplicatedStorage").devv).load("v3item").inventory
        local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
        for i, item in next, b1 do 
            if item.type == "Gun" then
                it.skinUpdate(item.name, skinsec)
            end
        end
    end
end)

YU_SHEN:Button("开启全枪虚空美化", function()
    local skinvoid = true
    if skinvoid then
        local it = require(game:GetService("ReplicatedStorage").devv).load("v3item").inventory
        local b1 = require(game:GetService('ReplicatedStorage').devv).load('v3item').inventory.items
        for i, item in next, b1 do 
            if item.type == "Gun" then
                table.insert(require(game:GetService("ReplicatedStorage").devv.shared.Indicies.skins.bin.Special.Void).compatabilities, item.name)
                it.skinUpdate(item.name, "Void")
            end
        end
    end
end)

YU_SHEN:Button("破解所有物品格", function()
    game:GetService("Players").LocalPlayer:SetAttribute("lockerSlots", 999)
    
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local devv = require(ReplicatedStorage.devv)
    local lockerModule = devv.load("locker")
    local purchases = devv.load("purchases")
    local globals = devv.load("globals")
    
    local originalGetNextTier = lockerModule.getNextTier
    local originalGetRobuxPrice = lockerModule.getRobuxPrice
    
    lockerModule.getNextTier = function()
        return 5  
    end
    
    lockerModule.getRobuxPrice = function(slots)
        return 0 
    end
    
    local GUILoader = devv.load("GUILoader")
    local backpackUI = GUILoader.Get("Backpack")
    
    for _, slot in pairs(backpackUI.Holder.Locker.Frame:GetChildren()) do
        if slot:IsA("GuiObject") then
            slot.Locked.Visible = false
            slot.Unlocked.Visible = true
        end
    end
    
    backpackUI.Holder.Locker.Buttons.UnlockAll.Visible = false
    backpackUI.Holder.Locker.Buttons.PageSelector.Visible = false
    
    if lockerModule.PromptPurchase then
        local originalPromptPurchase = lockerModule.PromptPurchase
        lockerModule.PromptPurchase = function(itemId, infoType)
            game:GetService("ReplicatedStorage").Signal:InvokeServer("completePurchase", itemId, infoType)
        end
    end
    
    lockerModule.update()
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "破解成功",
        Text = "",
        Duration = 5
    })
end)

YU_SHEN:Button("获取管理员核弹发射器", function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    pcall(function()
        local itemSystem = require(ReplicatedStorage.devv).load("v3item")
        local inventory = itemSystem.inventory
        
        local fistsItem = nil
        for guid, item in pairs(inventory.items) do
            if item.name == "Fists" then
                fistsItem = item
                break
            end
        end
        
        local nukeLauncherData = {
            name = "Admin Nuke Launcher",
            guid = "admin_nuke_launcher_"..tostring(tick()),
            modelName = "Nuke Launcher",
            subtype = "Nuke Launcher",
            adminOnly = true,
            canDrop = false,
            unpurchasable = true,
            ammo = 99999999,
            startAmmo = -1,
            maxAmmo = -1,
            overrideProjectileProperties = {disableNukeFlash = true},
            reloadTime = 0,
            reloadType = "mag",
            firemode = "auto",
            numProjectiles = 1,
            fireDebounce = 0.2,
            viewportOffsets = fistsItem and fistsItem.viewportOffsets or {
                hotbar = {dist = 2.75, offset = CFrame.new(0.25, 0, 0), rotoffset = CFrame.Angles(-0.7853981633974483, -0.7853981633974483, 0.7853981633974483)},
                ammoHUD = {dist = 2, offset = CFrame.new(0, 0, 0), rotoffset = CFrame.Angles(-1.3744467859455345, 0, 3.3379421944391554)}
            },
            TPSOffsets = fistsItem and fistsItem.TPSOffsets or {},
            FPSOffsets = fistsItem and fistsItem.FPSOffsets or {}
        }
        
        if inventory.add then
            inventory.add(nukeLauncherData, false)
            if inventory.currentItemsData then
                table.insert(inventory.currentItemsData, nukeLauncherData)
            end
        end
        
        if fistsItem then
            local fistsCopy = {
                name = "Fists",
                guid = "fists_copy_"..tostring(tick()),
                permanent = true,
                cannotDiscard = true,
                doMakeModel = false,
                debounce = 0.3,
                damageTable = {meleepunch = 15, meleemegapunch = 200, meleekick = 20, meleejumpKick = 20},
                viewportOffsets = fistsItem.viewportOffsets,
                TPSOffsets = fistsItem.TPSOffsets or {},
                FPSOffsets = fistsItem.FPSOffsets or {}
            }
            if inventory.add then
                inventory.add(fistsCopy, false)
            end
        end
        
        if inventory.rerender then
            inventory:rerender()
        end
    end)
end)

YU_SHEN:Button("获取管理员RPG", function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    pcall(function()
        local itemSystem = require(ReplicatedStorage.devv).load("v3item")
        local inventory = itemSystem.inventory
        
        local rpgData = {
            name = "Admin RPG",
            guid = "admin_rpg_"..tostring(tick()),
            modelName = "RPG",
            subtype = "RPG",
            adminOnly = true,
            canDrop = false,
            unpurchasable = true,
            ammo = 99999999,
            startAmmo = -1,
            maxAmmo = -1,
            reloadTime = 0,
            reloadType = "mag",
            firemode = "auto",
            numProjectiles = 1,
            fireDebounce = 0.02,
            recoilAdd = 0,
            maxRecoil = 0,
            recoilDiminishFactor = 0,
            recoilFastDiminishFactor = 0
        }
        
        if inventory.add then
            inventory.add(rpgData, false)
            if inventory.currentItemsData then
                table.insert(inventory.currentItemsData, rpgData)
            end
        end
        
        if inventory.rerender then
            inventory:rerender()
        end
    end)
end)

YU_SHEN:Button("获取管理员AK-47", function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    pcall(function()
        local itemSystem = require(ReplicatedStorage.devv).load("v3item")
        local inventory = itemSystem.inventory
        
        local ak47Data = {
            name = "Admin AK-47",
            guid = "admin_ak47_"..tostring(tick()),
            modelName = "Gold AK-47",
            subtype = "AK-47",
            adminOnly = true,
            canDrop = false,
            unpurchasable = true,
            damage = 10,
            ammo = 999999999,
            startAmmo = -1,
            maxAmmo = -1,
            firemode = "auto",
            numProjectiles = 8,
            fireDebounce = 0.01
        }
        
        if inventory.add then
            inventory.add(ak47Data, false)
            if inventory.currentItemsData then
                table.insert(inventory.currentItemsData, ak47Data)
            end
        end
        
        if inventory.rerender then
            inventory:rerender()
        end
    end)
end)

local YU_Tab = YU:Tab("幸运方块战争", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Textbox("生成数量", "GenerateCount", "1", function(value)
    generateCount = tonumber(value) or 1
end)

YU_SHEN:Button("攻击体积！", function()
    _G.HeadSize = 25
    _G.Disabled = true

    game:GetService('RunService').RenderStepped:Connect(function()
        if _G.Disabled then
            for _, v in next, game:GetService('Players'):GetPlayers() do
                if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                    pcall(function()
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                            v.Character.HumanoidRootPart.Transparency = 0.7
                            v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
                            v.Character.HumanoidRootPart.Material = "Neon"
                            v.Character.HumanoidRootPart.CanCollide = false
                        end
                    end)
                end
            end
        end
    end)
end)

YU_SHEN:Button("获得所有幸运方块", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local spawnGalaxyBlock = replicatedStorage:FindFirstChild("SpawnGalaxyBlock")
    
    if spawnGalaxyBlock then
        for i = 1, 100 do
            spawnGalaxyBlock:FireServer()
        end
    end
end)

YU_SHEN:Button("幸运块", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local spawnLuckyBlock = replicatedStorage:FindFirstChild("SpawnLuckyBlock")
    
    if spawnLuckyBlock then
        for i = 1, generateCount do
            spawnLuckyBlock:FireServer()
        end
    end
end)

YU_SHEN:Button("钻石块", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local spawnDiamondBlock = replicatedStorage:FindFirstChild("SpawnDiamondBlock")
    
    if spawnDiamondBlock then
        for i = 1, generateCount do
            spawnDiamondBlock:FireServer()
        end
    end
end)

YU_SHEN:Button("超级块", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local spawnSuperBlock = replicatedStorage:FindFirstChild("SpawnSuperBlock")
    
    if spawnSuperBlock then
        for i = 1, generateCount do
            spawnSuperBlock:FireServer()
        end
    end
end)

YU_SHEN:Button("彩虹块", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local spawnRainbowBlock = replicatedStorage:FindFirstChild("SpawnRainbowBlock")
    
    if spawnRainbowBlock then
        for i = 1, generateCount do
            spawnRainbowBlock:FireServer()
        end
    end
end)

YU_SHEN:Button("银河块", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local spawnGalaxyBlock = replicatedStorage:FindFirstChild("SpawnGalaxyBlock")
    
    if spawnGalaxyBlock then
        for i = 1, generateCount do
            spawnGalaxyBlock:FireServer()
        end
    end
end)

local YU_Tab = YU:Tab("Break-In", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("玩具剑小孩", function()
    game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer("LinkedSword", true, false)
end)

YU_SHEN:Button("警员", function()
    game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer("Gun", true)
end)

YU_SHEN:Button("特警", function()
    game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer("SwatGun", true)
end)

YU_SHEN:Button("猫的朋友", function()
    game.ReplicatedStorage.RemoteEvents.Cattery:FireServer()
end)

YU_SHEN:Button("解锁地下室", function()
    game.ReplicatedStorage.RemoteEvents.UnlockDoor:FireServer()
end)

YU_SHEN:Button("地下室灯辰", function()
    game.ReplicatedStorage.RemoteEvents.BasementMission:FireServer()
    game.ReplicatedStorage.RemoteFunctions.GetAmbient:InvokeServer()
end)

YU_SHEN:Button("地下室钥匙", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Key")
end)

YU_SHEN:Button("地下室", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(71, -15, -163)
end)

YU_SHEN:Button("房子", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-36, 3, -200)
end)

YU_SHEN:Button("顶楼", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-16, 35, -220)
end)

YU_SHEN:Button("超市", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-422, 3, -121)
end)

YU_SHEN:Button("下水道", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(129, 3, -125)
end)

YU_SHEN:Button("Boss房间", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, -287, -1480)
end)

YU_SHEN:Button("薯片", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
end)

YU_SHEN:Button("棒棒糖", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Lollipop")
end)

YU_SHEN:Button("可乐", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("BloxyCola")
end)

YU_SHEN:Button("苹果", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Apple")
end)

YU_SHEN:Button("披萨", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Pizza2")
end)

YU_SHEN:Button("饼干", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Cookie")
end)

YU_SHEN:Button("医疗包", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("MedKit")
end)

YU_SHEN:Button("药物", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Cure")
end)

YU_SHEN:Button("木板", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Plank")
end)

YU_SHEN:Button("泰迪熊", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("TeddyBloxpin")
end)

YU_SHEN:Button("锤子", function()
    game.ReplicatedStorage.RemoteEvents.BasementWeapon:FireServer(true, "Hammer")
end)

YU_SHEN:Button("球棒", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Bat")
end)

YU_SHEN:Button("剑", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("LinkedSword")
end)

local YU_Tab = YU:Tab("皮肤行者", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("幸存者透视", "ESPCivilians", false, function(state)
    if state then
        if civiliansconnection then civiliansconnection:Disconnect() end
        for _, v in next, workspace.Runners.Civilians:GetChildren() do
            ESPCivilians(v.Name, v, Color3.new(1, 0, 0))
        end
        civiliansconnection = workspace.Runners.Civilians.ChildAdded:Connect(function(v)
            ESPCivilians(v.Name, v, Color3.new(1, 0, 0))
        end)
    else
        if civiliansconnection then civiliansconnection:Disconnect() end
        if workspace:FindFirstChild("CiviliansESPFloder") then
            workspace.CiviliansESPFloder:ClearAllChildren()
        end
    end
end)

YU_SHEN:Toggle("怪物透视", "ESPSkinwalkers", false, function(state)
    if state then
        if skinwalkersconnection then skinwalkersconnection:Disconnect() end
        for _, v in next, workspace.Runners.Skinwalkers:GetChildren() do
            ESPSkinwalkers("怪物", v, Color3.new(0, 0, 1))
        end
        skinwalkersconnection = workspace.Runners.Skinwalkers.ChildAdded:Connect(function(v)
            ESPSkinwalkers("怪物", v, Color3.new(0, 0, 1))
        end)
    else
        if skinwalkersconnection then skinwalkersconnection:Disconnect() end
        if workspace:FindFirstChild("SkinwalkersESPFloder") then
            workspace.SkinwalkersESPFloder:ClearAllChildren()
        end
    end
end)

YU_SHEN:Toggle("杀死全部(皮肤行者)", "KillSkinwalkers", false, function(state)
    _G.Gunaura = state
    while _G.Gunaura do
        task.wait(0.3)
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        
        if character then
            local shotTargets = {}
            local runners = workspace.Runners
            if runners then
                local skinwalkers = runners:FindFirstChild("Skinwalkers")
                if skinwalkers then
                    for _, v in next, skinwalkers:GetChildren() do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") and v.Humanoid.Health > 0 and not shotTargets[v] then
                            for _,t in next, character:GetChildren() do
                                if t.Name == "Sniper" or t.Name == "Pistol" or t.Name == "Gatling" then
                                    local args = {
                                        [1] = Vector3.new(v.Head.Position.X, v.Head.Position.Y, v.Head.Position.Z),
                                        [2] = Vector3.new(v.Head.Position.X, v.Head.Position.Y, v.Head.Position.Z),
                                        [3] = v.Head
                                    }
                                    
                                    if t.Name == "Gatling" then
                                        args[4] = {
                                            ["BulletReduction"] = 0,
                                            ["Damage"] = math.huge
                                        }
                                    end
                                    
                                    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                                    if remotes then
                                        local sniperShot = remotes:FindFirstChild("SniperShot")
                                        if sniperShot then
                                            sniperShot:FireServer(unpack(args))
                                            shotTargets[v] = true
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("杀死全部(夜晚怪物)", "KillNightwalkers", false, function(state)
    _G.Gunaura = state
    while _G.Gunaura do
        task.wait(0.3)
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        
        if character then
            local shotTargets = {}
            local nightwalkers = workspace:FindFirstChild("Nightwalkers")
            if nightwalkers then
                for _, v in next, nightwalkers:GetChildren() do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") and v.Humanoid.Health > 0 and not shotTargets[v] then
                        for _,t in next, character:GetChildren() do
                            if t.Name == "Sniper" or t.Name == "Pistol" or t.Name == "Gatling" then
                                local args = {
                                    [1] = Vector3.new(v.Head.Position.X, v.Head.Position.Y, v.Head.Position.Z),
                                    [2] = Vector3.new(v.Head.Position.X, v.Head.Position.Y, v.Head.Position.Z),
                                    [3] = v.Head
                                }
                                
                                if t.Name == "Gatling" then
                                    args[4] = {
                                        ["BulletReduction"] = 0,
                                        ["Damage"] = math.huge
                                    }
                                end
                                
                                local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                                if remotes then
                                    local sniperShot = remotes:FindFirstChild("SniperShot")
                                    if sniperShot then
                                        sniperShot:FireServer(unpack(args))
                                        shotTargets[v] = true
                                    end
                                end
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集钱袋", "AutoCollectMoney", false, function(state)
    _G.CoMoneybag = state
    while _G.CoMoneybag do
        task.wait(0.3)
        local gameObjects = workspace:FindFirstChild("GameObjects")
        if gameObjects then
            for _,v in next, gameObjects:GetChildren() do
                if v.Name == "MoneyBag" and v:FindFirstChild("ProximityPrompt") then
                    fireproximityprompt(v.ProximityPrompt)
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动售卖", "AutoSell", false, function(state)
    _G.Autostore = state
    while _G.Autostore do
        task.wait(0.3)
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        
        if character then
            local runners = workspace.Runners
            if runners then
                local skinwalkers = runners:FindFirstChild("Skinwalkers")
                if skinwalkers then
                    for _, v in next, skinwalkers:GetChildren() do
                        if v:IsA("Model") and (v:GetPivot().Position - character:GetPivot().Position).Magnitude <= 15 then
                            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                            if remotes then
                                local storeRemote = remotes:FindFirstChild("Store")
                                if storeRemote then
                                    storeRemote:FireServer(v)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集尸体", "AutoCollectBodies", false, function(state)
    _G.Autostore = state
    while _G.Autostore do
        task.wait(0.3)
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        
        if character then
            local runners = workspace.Runners
            if runners then
                local skinwalkers = runners:FindFirstChild("Skinwalkers")
                if skinwalkers then
                    for _, v in next, skinwalkers:GetChildren() do
                        character:PivotTo(v:GetPivot().Position)
                        if v:IsA("Model") and (v:GetPivot().Position - character:GetPivot().Position).Magnitude <= 15 then
                            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                            if remotes then
                                local storeRemote = remotes:FindFirstChild("Store")
                                if storeRemote then
                                    storeRemote:FireServer(v)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动放夹子(无需夹子直接放)", "AutoTrap", false, function(state)
    _G.AutoTrap = state
    while _G.AutoTrap do
        task.wait(0.3)
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        
        if character and character:FindFirstChild("HumanoidRootPart") then
            local args = {
                [1] = Vector3.new(character.HumanoidRootPart.Position.X, character.HumanoidRootPart.Position.Y, character.HumanoidRootPart.Position.Z)
            }
            
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes then
                local placeTrap = remotes:FindFirstChild("PlaceTrap")
                if placeTrap then
                    placeTrap:FireServer(unpack(args))
                end
            end
        end
    end
end)

YU_SHEN:Button("获取加特林", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local assets = replicatedStorage:FindFirstChild("Assets")
    
    if assets then
        local tools = assets:FindFirstChild("Tools")
        if tools then
            local gatling = tools:FindFirstChild("Gatling")
            local localPlayer = game.Players.LocalPlayer
            local backpack = localPlayer.Backpack
            
            if gatling then
                gatling.Parent = backpack
            elseif backpack:FindFirstChild("Gatling") then
                backpack.Gatling.Parent = tools
            end
        end
    end
end)

YU_SHEN:Button("获取可乐", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local assets = replicatedStorage:FindFirstChild("Assets")
    
    if assets then
        local tools = assets:FindFirstChild("Tools")
        if tools then
            local cola = tools:FindFirstChild("Cola")
            local localPlayer = game.Players.LocalPlayer
            local backpack = localPlayer.Backpack
            
            if cola then
                local amount = cola:FindFirstChild("Amount")
                if amount then
                    amount.Value = 99
                end
                cola.Parent = backpack
            elseif backpack:FindFirstChild("Cola") then
                backpack.Cola.Parent = tools
            end
        end
    end
end)

YU_SHEN:Button("获取夹子", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local assets = replicatedStorage:FindFirstChild("Assets")
    
    if assets then
        local tools = assets:FindFirstChild("Tools")
        if tools then
            local snapper = tools:FindFirstChild("Snapper")
            local localPlayer = game.Players.LocalPlayer
            local backpack = localPlayer.Backpack
            
            if snapper then
                local amount = snapper:FindFirstChild("Amount")
                if amount then
                    amount.Value = 99
                end
                snapper.Parent = backpack
            elseif backpack:FindFirstChild("Snapper") then
                backpack.Snapper.Parent = tools
            end
        end
    end
end)

YU_SHEN:Button("获取炮塔", function()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local assets = replicatedStorage:FindFirstChild("Assets")
    
    if assets then
        local tools = assets:FindFirstChild("Tools")
        if tools then
            local turret = tools:FindFirstChild("Turret")
            local localPlayer = game.Players.LocalPlayer
            local backpack = localPlayer.Backpack
            
            if turret then
                local amount = turret:FindFirstChild("Amount")
                if amount then
                    amount.Value = 99
                end
                turret.Parent = backpack
            elseif backpack:FindFirstChild("Turret") then
                backpack.Turret.Parent = tools
            end
        end
    end
end)

local YU_Tab = YU:Tab("生存7天", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("动物透视", "ESPAnimal", false, function(state)
    if state then
        if animalConnection then animalConnection:Disconnect() end
        for _, v in next, workspace.animals:GetChildren() do
            ESPAnimal(v.Name, v, Color3.new(1, 0, 0))
        end
        animalConnection = workspace.animals.ChildAdded:Connect(function(v)
            ESPAnimal(v.Name, v, Color3.new(1, 0, 0))
        end)
    else
        if animalConnection then animalConnection:Disconnect() end
        if workspace:FindFirstChild("AnimalESPFloder") then
            workspace.AnimalESPFloder:ClearAllChildren()
        end
    end
end)

YU_SHEN:Toggle("怪物透视", "ESPMonster", false, function(state)
    if state then
        if scpConnection then scpConnection:Disconnect() end
        for _, v in next, workspace.scps:GetChildren() do
            ESPMonster("怪物", v, Color3.new(0, 0, 1))
        end
        scpConnection = workspace.scps.ChildAdded:Connect(function(v)
            ESPMonster("怪物", v, Color3.new(0, 0, 1))
        end)
    else
        if scpConnection then scpConnection:Disconnect() end
        if workspace:FindFirstChild("ScpESPFloder") then
            workspace.ScpESPFloder:ClearAllChildren()
        end
    end
end)

YU_SHEN:Toggle("秒砍树", "InstantCutTree", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("remotes")
    
    if remotes then
        local swingAxe = remotes:FindFirstChild("swing_axe")
        if swingAxe then
            localPlayer.instantlycutofftree = state
            spawn(function()
                while localPlayer.instantlycutofftree do
                    task.wait()
                    swingAxe:FireServer()
                    if workspace:FindFirstChild("logs") then
                        for _,v in next, workspace.logs:GetChildren() do
                            if v.Name == "log" and v:FindFirstChild("main") then
                                local proximityPrompt = v.main:FindFirstChild("ProximityPrompt")
                                if proximityPrompt then
                                    fireproximityprompt(proximityPrompt)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

YU_SHEN:Toggle("自动钓鱼", "AutoFishing", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("remotes")
    
    if remotes then
        local castRemote = remotes:FindFirstChild("cast")
        local hitFishRemote = remotes:FindFirstChild("hit_fish")
        
        if castRemote and hitFishRemote then
            localPlayer.AutoCast = state
            spawn(function()
                while localPlayer.AutoCast do
                    castRemote:FireServer()
                    task.wait(0.2)
                    for i = 1, 8 do
                        hitFishRemote:FireServer()
                    end
                    task.wait()
                end
            end)
        end
    end
end)

YU_SHEN:Button("秒吃食物", function()
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    
    if character then
        local backpack = localPlayer.Backpack
        local hungerValue = character:FindFirstChild("hunger")
        
        if backpack and hungerValue then
            for _,v in pairs(backpack:GetChildren()) do
                if v:FindFirstChild("eat") and hungerValue.Value < 30 then
                    v.Parent = character
                    for i = 1, 20 do
                        character[v.Name].eat:FireServer()
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集材料", "AutoCollectScraps", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    localPlayer.AutoCollectScraps = state
    
    spawn(function()
        while localPlayer.AutoCollectScraps do
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local oldcf = localPlayer.Character.HumanoidRootPart.CFrame
                
                if workspace:FindFirstChild("scraps") then
                    for _, v in pairs(workspace.scraps:GetChildren()) do
                        local material = v:FindFirstChild("defaultMaterial10")
                        if material and localPlayer.AutoCollectScraps then
                            local prompt = material:FindFirstChild("ProximityPrompt")
                            if prompt and localPlayer.AutoCollectScraps then
                                localPlayer.Character.HumanoidRootPart.CFrame = material.CFrame + Vector3.new(0, 3, 0)
                                task.wait(0.2)
                                fireproximityprompt(prompt)
                                task.wait(0.2)
                                localPlayer.Character.HumanoidRootPart.CFrame = oldcf
                            end
                        end
                    end
                end
            end
            task.wait()
        end
    end)
end)

YU_SHEN:Button("传送回出生点", function()
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(57, 42, 416)
    end
end)

YU_SHEN:Toggle("自动收集成熟品", "AutoCollectHarvest", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    localPlayer.AutoCollectHarvt = state
    
    if localPlayer.AutoCollectHarvt then
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local oldpos = localPlayer.Character.HumanoidRootPart.CFrame
            spawn(function()
                while localPlayer.AutoCollectHarvt do
                    if workspace:FindFirstChild("harvest") then
                        for _,v in next, workspace.harvest:GetChildren() do
                            if v:FindFirstChild("main") then
                                localPlayer.Character.HumanoidRootPart.CFrame = v.main.CFrame
                                local prompt = v.main:FindFirstChild("ProximityPrompt")
                                if prompt then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    else
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if oldpos then
                localPlayer.Character.HumanoidRootPart.CFrame = oldpos
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集生鹿肉", "AutoCollectDeer", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    localPlayer.AutoCollectHarvt = state
    
    if localPlayer.AutoCollectHarvt then
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local oldpos = localPlayer.Character.HumanoidRootPart.CFrame
            spawn(function()
                while localPlayer.AutoCollectHarvt do
                    if workspace:FindFirstChild("interact") then
                        for _,v in next, workspace.interact:GetChildren() do
                            if v.Name == "deer" and v:FindFirstChild("lungs,heart,intestines") then
                                local organ = v["lungs,heart,intestines"]
                                localPlayer.Character.HumanoidRootPart.CFrame = organ.CFrame
                                local prompt = organ:FindFirstChild("ProximityPrompt")
                                if prompt then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    else
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if oldpos then
                localPlayer.Character.HumanoidRootPart.CFrame = oldpos
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集包菜", "AutoCollectCabbage", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    localPlayer.AutoCollectDirt = state
    
    if localPlayer.AutoCollectDirt then
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local oldpos = localPlayer.Character.HumanoidRootPart.CFrame
            spawn(function()
                while localPlayer.AutoCollectDirt do
                    local builds = workspace:FindFirstChild("builds")
                    if builds then
                        local cabbageFarm = builds:FindFirstChild("Cabbage Farm")
                        if cabbageFarm and cabbageFarm:FindFirstChild("dirt") then
                            local dirt = cabbageFarm.dirt
                            localPlayer.Character.HumanoidRootPart.CFrame = dirt.CFrame
                            local prompt = dirt:FindFirstChild("ProximityPrompt")
                            if prompt then
                                fireproximityprompt(prompt)
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    else
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if oldpos then
                localPlayer.Character.HumanoidRootPart.CFrame = oldpos
            end
        end
    end
end)

YU_SHEN:Toggle("枪械辰环", "GunAura", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    localPlayer.KillAll = state
    
    spawn(function()
        while localPlayer.KillAll do
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("remotes")
            if remotes then
                local shootRemote = remotes:FindFirstChild("shoot")
                local reloadRemote = remotes:FindFirstChild("reload")
                
                if shootRemote and reloadRemote then
                    for _,v in next, workspace.scps:GetChildren() do
                        if v:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                [1] = CFrame.new(v.HumanoidRootPart.Position.X, v.HumanoidRootPart.Position.Y, v.HumanoidRootPart.Position.Z) * CFrame.Angles(0, 0, 0),
                                [2] = CFrame.new(v.HumanoidRootPart.Position.X, v.HumanoidRootPart.Position.Y, v.HumanoidRootPart.Position.Z) * CFrame.Angles(0, 0, 0),
                            }
                            shootRemote:FireServer(unpack(args))
                            reloadRemote:FireServer()
                        end
                    end
                    for _,v in next, workspace.animals:GetChildren() do
                        if v:FindFirstChild("HumanoidRootPart") then
                            local args = {
                                [1] = CFrame.new(v.HumanoidRootPart.Position.X, v.HumanoidRootPart.Position.Y, v.HumanoidRootPart.Position.Z) * CFrame.Angles(0, 0, 0),
                                [2] = CFrame.new(v.HumanoidRootPart.Position.X, v.HumanoidRootPart.Position.Y, v.HumanoidRootPart.Position.Z) * CFrame.Angles(0, 0, 0),
                            }
                            shootRemote:FireServer(unpack(args))
                            reloadRemote:FireServer()
                        end
                    end
                end
            end
            task.wait()
        end
    end)
end)

YU_SHEN:Toggle("子弹追踪(锁头)", "BulletTracking", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    localPlayer.KillAura = state
    
    spawn(function()
        while localPlayer.KillAura do
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("remotes")
                if remotes then
                    local shootRemote = remotes:FindFirstChild("shoot")
                    if shootRemote then
                        for _, scp in ipairs(workspace.scps:GetChildren()) do
                            local HitPart = scp:FindFirstChild("HumanoidRootPart") or scp:FindFirstChild("Head")
                            if HitPart and scp:FindFirstChildWhichIsA("Humanoid") and scp.Humanoid.Health > 0 then
                                shootRemote:FireServer(HitPart.CFrame + Vector3.new(0, 0.5, 0), HitPart.CFrame)
                            end
                        end
                        for _, animal in ipairs(workspace.animals:GetChildren()) do
                            local HitPart = animal:FindFirstChild("HumanoidRootPart") or animal:FindFirstChild("Head")
                            if HitPart and animal:FindFirstChildWhichIsA("Humanoid") and animal.Humanoid.Health > 0 then
                                shootRemote:FireServer(HitPart.CFrame + Vector3.new(0, 0.5, 0), HitPart.CFrame)
                            end
                        end
                    end
                end
            end
            task.wait()
        end
    end)
end)

YU_SHEN:Toggle("自动传送最近的木头", "AutoTpWood", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    localPlayer.AutoTpPine = state
    
    spawn(function()
        while localPlayer.AutoTpPine do
            local function findClosestPine()
                local closest = nil
                local closestDistance = math.huge
                if workspace:FindFirstChild("pines") then
                    for _, pine in pairs(workspace.pines:GetChildren()) do
                        if pine:FindFirstChild("PrimaryPart") then
                            local distance = (localPlayer.Character.HumanoidRootPart.Position - pine.PrimaryPart.Position).magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                closest = pine
                            end
                        end
                    end
                end
                return closest
            end
            
            local closestPine = findClosestPine()
            if closestPine and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetPosition = closestPine.PrimaryPart.Position
                localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(targetPosition.X, targetPosition.Y - 30, targetPosition.Z))
                localPlayer.Character.HumanoidRootPart.Anchored = localPlayer.AutoTpPine
            end
            task.wait()
        end
    end)
end)

YU_SHEN:Toggle("开启无限模式", "InfiniteMode", false, function(state)
    local infiniteValue = workspace:FindFirstChild("infinite")
    if infiniteValue then
        infiniteValue.Value = state
    end
end)

YU_SHEN:Toggle("开启雨天", "RainMode", false, function(state)
    local rainingValue = workspace:FindFirstChild("raining")
    if rainingValue then
        rainingValue.Value = state
    end
end)

YU_SHEN:Toggle("当前天数和手表时间", "TimeDisplay", false, function(state)
    if state then
        local currentDay = workspace:FindFirstChild("current_day")
        local waited = workspace:FindFirstChild("waited")
        
        if currentDay and waited then
            txtf("UpdateLine", "Left", "当前天数" .. currentDay.Value)
            txtf("UpdateLine", "Left", "当前时间" .. waited.Value)
        end
    else
        txtf("ClearText")
    end
end)

YU_SHEN:Toggle("自动拾取飞机残骸", "AutoCollectHeli", false, function(state)
    local localPlayer = game.Players.LocalPlayer
    localPlayer.AutoHeli = state
    
    spawn(function()
        while localPlayer.AutoHeli do
            if workspace:FindFirstChild("interact") then
                for _,v in next, workspace.interact:GetChildren() do
                    if v.Name == "heli" and v:FindFirstChild("Body") then
                        local prompt = v.Body:FindFirstChild("ProximityPrompt")
                        if prompt then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
            task.wait()
        end
    end)
end)

local YU_Tab = YU:Tab("自然灾害", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("自动农场胜出", "ToggleInfo", false, function(bool)
    _G.autowinfarm = bool;
    while wait(.1) do
        if _G.autowinfarm == true then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-236, 180, 360, 1, 0, 0, 0, 1, 0, 0, 0, 1)
        end
end
end)
YU_SHEN:Toggle("地图投票用户界面", "t", false, function(Value)
		plr.PlayerGui.MainGui.MapVotePage.Visible = Value
	end)

local nextdis
YU_SHEN:Toggle("预测灾害", "t", false, function(val)
		nextdis = val

		while wait(1) and nextdis do
			local SurvivalTag = plr.Character:FindFirstChild("SurvivalTag")
			if SurvivalTag then
				if SurvivalTag.Value == "Blizzard" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：暴风雪"
				elseif SurvivalTag.Value == "Sandstorm" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：沙尘暴"
				elseif SurvivalTag.Value == "Tornado" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：龙卷风"
				elseif SurvivalTag.Value == "Volcanic Eruption" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：火山"
				elseif SurvivalTag.Value == "Flash Flood" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：洪水"
				elseif SurvivalTag.Value == "Deadly Virus" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：病毒"
				elseif SurvivalTag.Value == "Tsunami" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：海啸"
				elseif SurvivalTag.Value == "Acid Rain" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：酸雨"
				elseif SurvivalTag.Value == "Fire" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：火焰"
				elseif SurvivalTag.Value == "Meteor Shower" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：流星雨"
				elseif SurvivalTag.Value == "Earthquake" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：地震"
				elseif SurvivalTag.Value == "Thunder Storm" and nextdis then
					Message.Visible = true
					Message.Text = "下一个灾难是：暴风雨"
				else
					Message.Visible = false
				end
			end
		end
	end)

YU_SHEN:Toggle("地图投票用户界面", "Map Voting UI", false, function(bool)
if bool == false then do game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = false
    end
end
if bool == true then do game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = true
    end
end
end)

YU_SHEN:Toggle("在水上行走", "ToggleInfo", false, function(bool)
 if bool == false then do game.Workspace.WaterLevel.CanCollide = false
                            game.Workspace.WaterLevel.Size = Vector3.new(10, 1, 10)
                        end
                    end
                    if bool == true then do game.Workspace.WaterLevel.CanCollide = true
                            game.Workspace.WaterLevel.Size = Vector3.new(5000, 1, 5000)
                        end
                    end
end)

YU_SHEN:Toggle("游戏岛悬崖碰撞", "Togglelnfo", false, function(bool)
for i, v in pairs (game.workspace:GetDescendants())do
                                if v.Name == 'LowerRocks' then
                                    v.CanCollide = bool
                                end
                            end
end)

YU_SHEN:Toggle("禁用坠落损坏",function()
local FallDamageScript = (game.Players.LocalPlayer.Character ~= nil) and game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") or nil
                                if FallDamageScript then
                                FallDamageScript:Destroy()
                                end
end)

YU_SHEN:Toggle("自动禁用坠落伤害", "Toggleelnfo", false, function(bool)
_G.NoFallDamage = bool;
                            while wait(0.5) do
                                    if _G.NoFallDamage == true then
                            local FallDamageScript = (game.Players.LocalPlayer.Character ~= nil) and game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") or nil
                            if FallDamageScript then
                            FallDamageScript:Destroy()
                            end end end
end)

YU_SHEN:Button("打印下一次灾难(/console)",function()
warn(game.Players.LocalPlayer.Character.SurvivalTag.Value)
end)

YU_SHEN:Button("移除灾难界面(暴风雪和沙尘暴)",function()
game.Players.LocalPlayer.PlayerGui.BlizzarYUui:destroy()
		game.Players.LocalPlayer.PlayerGui.SandStormGui:destroy()
end)

YU_SHEN:Button("传送到地图",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-115.828506, 65.4863434, 18.8461514, 0.00697017973, 0.0789371505, -0.996855199, -3.13589936e-07, 0.996879458, 0.0789390653, 0.999975681, -0.000549906865, 0.00694845384)
end)

YU_SHEN:Button("游戏岛",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-83.5, 38.5, -27.5, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

YU_SHEN:Button("产卵塔",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-280, 170, 341, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)
YU_SHEN:Button(
    "自然灾害-高级脚本",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/9NLK7/93qjoadnlaknwldk/main/main"))()
    end
)
YU_SHEN:Button(
    "黑洞脚本（按E）",
    function()
        local UserInputService = game:GetService("UserInputService")
        local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local Folder = Instance.new("Folder", game:GetService("Workspace"))
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1
        local Updated = Mouse.Hit + Vector3.new(0, 5, 0)
        local NetworkAccess =
            coroutine.create(
            function()
                settings().Physics.AllowSleep = false
                while game:GetService("RunService").RenderStepped:Wait() do
                    for _, Players in next, game:GetService("Players"):GetPlayers() do
                        if Players ~= game:GetService("Players").LocalPlayer then
                            Players.MaximumSimulationRadius = 0
                            sethiddenproperty(Players, "SimulationRadius", 0)
                        end
                    end
                    game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
                    setsimulationradius(math.huge)
                end
            end
        )
        coroutine.resume(NetworkAccess)

        local function EnhanceAndInvinciblePart(part)
            if
                part:IsA("Part") and part.Anchored == false and part.Parent:FindFirstChild("Humanoid") == nil and
                    part.Parent:FindFirstChild("Head") == nil and
                    part.Name ~= "Handle"
             then
                Mouse.TargetFilter = part
                for _, x in next, part:GetChildren() do
                    if
                        x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or
                            x:IsA("BodyThrust") or
                            x:IsA("BodyVelocity") or
                            x:IsA("RocketPropulsion")
                     then
                        x:Destroy()
                    end
                end
                if part:FindFirstChild("Attachment") then
                    part:FindFirstChild("Attachment"):Destroy()
                end
                if part:FindFirstChild("AlignPosition") then
                    part:FindFirstChild("AlignPosition"):Destroy()
                end
                if part:FindFirstChild("Torque") then
                    part:FindFirstChild("Torque"):Destroy()
                end
                part.CanCollide = false
                local Torque = Instance.new("Torque", part)
                Torque.Torque = Vector3.new(100000, 100000, 100000)
                local AlignPosition = Instance.new("AlignPosition", part)
                local Attachment2 = Instance.new("Attachment", part)
                Torque.Attachment0 = Attachment2
                AlignPosition.MaxForce = 9999999999999999
                AlignPosition.MaxVelocity = math.huge
                AlignPosition.Responsiveness = 200
                AlignPosition.Attachment0 = Attachment2
                AlignPosition.Attachment1 = Attachment1
            end
        end

        for _, part in next, game:GetService("Workspace"):GetDescendants() do
            EnhanceAndInvinciblePart(part)
        end

        game:GetService("Workspace").DescendantAdded:Connect(
            function(part)
                EnhanceAndInvinciblePart(part)
            end
        )
        -- 监听按键事件
        UserInputService.InputBegan:Connect(
            function(input, isProcessed)
                if input.KeyCode == Enum.KeyCode.E and not isProcessed then
                    Updated = Mouse.Hit + Vector3.new(0, 5, 0)
                end
            end
        )

        -- 使用物理引擎移动所有物体
        spawn(
            function()
                while game:GetService("RunService").RenderStepped:Wait() do
                    Attachment1.WorldCFrame = Updated
                end
            end
        )
    end
)
YU_SHEN:Button(
    "自然灾害-1脚本",
    function()
        loadstring(
            game:HttpGet(
                "https://gist.githubusercontent.com/TurkOyuncu99/7c75386107937fa006304efd24543ad4/raw/8d759dfcd95d39949c692735cfdf62baec0bf835/cafwetweg",
                true
            )
        )()
    end
)
YU_SHEN:Button(
    "自然灾害-2脚本",
    function()
        loadstring(
            game:HttpGet(
                "https://raw.githubusercontent.com/2YUeneralspam1/scripts-and-stuff/master/scripts/    loadstringUjHI6RQpz2o8",
                true
            )
        )()
    end
)
YU_SHEN:Button(
    "自然灾害-3脚本",
    function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/EYUeIY/infiniteyield/master/source"), true))()
    end
)

local YU_Tab = YU:Tab("造船寻宝", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle(
    "自动刷金币",
    "text",
    false,
    function(FARM)
        _G.FARMs = FARM
        while _G.FARMs do
            wait()
            pcall(
                function()
                    game.Workspace.Gravity = 0
                    wait(0.5)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -51.05019,
                                43.5682182,
                                702.193481,
                                -0.999886811,
                                -0.000135422233,
                                0.0150433034,
                                8.65181704e-09,
                                0.999959469,
                                0.00900237076,
                                -0.0150439134,
                                0.00900135189,
                                -0.999846339
                            )
                        }
                    ):Play()
                    wait(1)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(30, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -50.4467354,
                                34.108551,
                                8676.95117,
                                -0.999937415,
                                -0.000405743311,
                                0.0111814411,
                                -6.1212857e-09,
                                0.999342263,
                                0.0362627953,
                                -0.0111888004,
                                0.0362605266,
                                -0.999279737
                            )
                        }
                    ):Play()
                    wait(30)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -54.1517258,
                                -359.077667,
                                9497.03418,
                                -0.99982208,
                                0.00359633542,
                                -0.0185163822,
                                -7.16419102e-09,
                                0.981655717,
                                0.190661997,
                                0.0188623965,
                                0.190628082,
                                -0.981481075
                            )
                        }
                    ):Play()
                    wait(5)
                    game.Workspace.Gravity = 200
                    wait(20)
                end
            )
        end
    end
)
YU_SHEN:Toggle(
    "自动刷金币快速版",
    "text",
    false,
    function(FARM2)
        _G.FARM2s = FARM2
        while _G.FARM2s do
            wait()
            pcall(
                function()
                    game.Workspace.Gravity = 0
                    wait(0.5)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -51.05019,
                                43.5682182,
                                702.193481,
                                -0.999886811,
                                -0.000135422233,
                                0.0150433034,
                                8.65181704e-09,
                                0.999959469,
                                0.00900237076,
                                -0.0150439134,
                                0.00900135189,
                                -0.999846339
                            )
                        }
                    ):Play()
                    wait(1)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -50.4467354,
                                34.108551,
                                8676.95117,
                                -0.999937415,
                                -0.000405743311,
                                0.0111814411,
                                -6.1212857e-09,
                                0.999342263,
                                0.0362627953,
                                -0.0111888004,
                                0.0362605266,
                                -0.999279737
                            )
                        }
                    ):Play()
                    wait(5)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -51.05019,
                                43.5682182,
                                702.193481,
                                -0.999886811,
                                -0.000135422233,
                                0.0150433034,
                                8.65181704e-09,
                                0.999959469,
                                0.00900237076,
                                -0.0150439134,
                                0.00900135189,
                                -0.999846339
                            )
                        }
                    ):Play()
                    wait(5)
                    local Event = game:GetService("Workspace").ClaimRiverResultsGold
                    Event:FireServer()
                    wait(0.1)
                    game.Players.LocalPlayer.Character.Humanoid.Health = -1000
                    wait(0.1)
                    game.Workspace.Gravity = 200
                    wait(7)
                end
            )
        end
    end
)
YU_SHEN:Toggle(
    "自动索赔金币",
    "text",
    false,
    function(GlaimGold)
        _G.ClaimGolds = ClaimGold
        while _G.ClaimGolds do
            wait()
            pcall(
                function()
                    local Event = game:GetService("Workspace").ClaimRiverResultsGold
                    Event:FireServer()
                end
            )
        end

        MainSection:Button(
            "ClearAllBoatParts",
            function()
                local Event = game:GetService("Workspace").ClearAllPlayersBoatParts
                Event:FireServer()
            end
        )

        wait(0.5)
        local ba = Instance.new("ScreenGui")
        local ca = Instance.new("TextLabel")
        local da = Instance.new("Frame")
        local _b = Instance.new("TextLabel")
        local ab = Instance.new("TextLabel")
        ba.Parent = game.CoreGui
        ba.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ca.Parent = ba
        ca.Active = true
        ca.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
        ca.Draggable = true
        ca.Position = UDim2.new(0.698610067, 0, 0.098096624, 0)
        ca.Size = UDim2.new(0, 370, 0, 52)
        ca.Font = Enum.Font.SourceSansSemibold
        ca.Text = "Anti AFK Script"
        ca.TextColor3 = Color3.new(0, 1, 1)
        ca.TextSize = 22
        da.Parent = ca
        da.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
        da.Position = UDim2.new(0, 0, 1.0192306, 0)
        da.Size = UDim2.new(0, 370, 0, 107)
        _b.Parent = da
        _b.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
        _b.Position = UDim2.new(0, 0, 0.800455689, 0)
        _b.Size = UDim2.new(0, 370, 0, 21)
        _b.Font = Enum.Font.Arial
        _b.Text = "made by simon"
        _b.TextColor3 = Color3.new(0, 1, 1)
        _b.TextSize = 20
        ab.Parent = da
        ab.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
        ab.Position = UDim2.new(0, 0, 0.158377, 0)
        ab.Size = UDim2.new(0, 370, 0, 44)
        ab.Font = Enum.Font.ArialBold
        ab.Text = "Status: Active"
        ab.TextColor3 = Color3.new(0, 1, 1)
        ab.TextSize = 20

        local bb = game:service "VirtualUser"
        game:service "Players".LocalPlayer.Idled:connect(
            function()
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
                ab.Text = "机器人想踢你，但我踢了他"
                wait(2)
                ab.Text = "状态：Active"
            end
        )
    end
)

YU_SHEN:Button(
    "无限方块（假）",
    function()
        spawn(
            function()
                local guiinf =
                    game:GetService("Players").LocalPlayer.PlayerGui.BuilYUui.InventoryFrame.ScrollingFrame.BlocksFrame
                _G.Blocks = false
                while game:GetService("RunService").RenderStepped:wait() do
                    if _G.Blocks then
                        return
                    end
                    for i, v in pairs(guiinf:GetDescendants()) do
                        if v.Name == "AmountText" then
                            v.Text = math.huge
                        end
                    end
                end
            end
        )
    end
)

YU_SHEN:Button(
    "变蔡徐坤😎😎😎",
    function()
        local players = game:GetService("Players")
        local client = players.LocalPlayer
        local Chicken = workspace:WaitForChild("ChangeCharacter")
        Chicken:FireServer("ChickenCharacter")
    end
)
YU_SHEN:Button(
    "变成企鹅🤮🤮🤮",
    function()
        local players = game:GetService("Players")
        local client = players.LocalPlayer
        local penguin = workspace:WaitForChild("ChangeCharacter")
        penguin:FireServer("PenguinCharacter")
    end
)
YU_SHEN:Button(
    "变死狐狸🤮🤮🤮",
    function()
        local players = game:GetService("Players")
        local client = players.LocalPlayer
        local fox = workspace:WaitForChild("ChangeCharacter")
        fox:FireServer("FoxCharacter")
    end
)

local YU_Tab = YU:Tab("力量传奇", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("自动比赛开关", "AR", false, function(AR)
  while AR do wait() wait(2) game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl") end
end)
YU_SHEN:Toggle("自动举哑铃", "ATYL", false, function(ATYL)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATYL do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Weight" then v.Parent = game.Players.LocalPlayer.Character end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end
end)
YU_SHEN:Toggle("自动俯卧撑", "ATFWC", false, function(ATFWC)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATFWC do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Pushups" then v.Parent = game.Players.LocalPlayer.Character end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end
end)
YU_SHEN:Toggle("自动仰卧起坐", "ATYWQZ", false, function(ATYWQZ)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATYWQZ do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Situps" then v.Parent = game.Players.LocalPlayer.Character end end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end)
YU_SHEN:Toggle("自动倒立身体", "ATDL", false, function(ATDL)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATDL do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Handstands" then v.Parent = game.Players.LocalPlayer.Character end end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end)
YU_SHEN:Toggle("自动锻炼", "ATAAA", false, function(ATAAA)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true while ATAAA do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Handstands" or v.Name == "Situps" or v.Name == "Pushups" or v.Name == "Weight" then v:FindFirstChildOfClass("NumberValue").Value = 0 repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end end end
end)

YU_SHEN:Toggle("自动重生", "ATRE", false, function(ATRE)
  while ATRE do wait() game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest") end
end)
YU_SHEN:Button("收集宝石", function()
  jk = {} for _, v in pairs(game:GetService("ReplicatedStorage").chestRewards:GetDescendants()) do if v.Name ~= "Light Karma Chest" or v.Name ~= "Evil Karma Chest" then table.insert(jk, v.Name) end end for i = 1, #jk do wait(2) game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(jk[i]) end
end)

YU_SHEN:Toggle("沙滩跑步机10", "PPJ10", false, function(PPJ10)
    getgenv().PPJ10 = PPJ10 while getgenv().PPJ10 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end if not getgenv().PPJ10 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
YU_SHEN:Toggle("健身房跑步机2000", "PPJ2000", false, function(PPJ2000)
    if game.Players.LocalPlayer.Agility.Value >= 2000 then getgenv().PPJ2000 = PPJ2000 while getgenv().PPJ2000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-3005.37866, 14.3221855, -464.697876, -0.015773816, -1.38508964e-08, 0.999875605, -5.13225586e-08, 1, 1.30429667e-08, -0.999875605, -5.11104332e-08, -0.015773816) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().PPJ2000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
YU_SHEN:Toggle("神话健身房跑步机2000", "SHPPJ2000", false, function(SHPPJ2000)
    if game.Players.LocalPlayer.Agility.Value >= 2000 then getgenv().SHPPJ2000 = SHPPJ2000 while getgenv().SHPPJ2000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2571.23706, 15.6896839, 898.650391, 0.999968231, 2.23868635e-09, -0.00797206629, -1.73198844e-09, 1, 6.35660768e-08, 0.00797206629, -6.3550246e-08, 0.999968231) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().SHPPJ2000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
YU_SHEN:Toggle("永恒健身房跑步机3500", "YHPPJ3500", false, function(YHPPJ3500)
    if game.Players.LocalPlayer.Agility.Value >= 3500 then getgenv().YHPPJ3500 = YHPPJ3500 while getgenv().YHPPJ3500 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7077.79102, 29.6702118, -1457.59961, -0.0322036594, -3.31122768e-10, 0.99948132, -6.44344267e-09, 1, 1.23684493e-10, -0.99948132, -6.43611742e-09, -0.0322036594) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().YHPPJ3500 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
YU_SHEN:Toggle("传奇健身房跑步机3000", "CQPPJ3000", false, function(CQPPJ3000)
    if game.Players.LocalPlayer.Agility.Value >= 3000 then getgenv().CQPPJ3000 = CQPPJ3000 while getgenv().CQPPJ3000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4370.82812, 999.358704, -3621.42773, -0.960604727, -8.41949266e-09, -0.27791819, -6.12478646e-09, 1, -9.12496567e-09, 0.27791819, -7.06329528e-09, -0.960604727) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().CQPPJ3000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)

YU_SHEN:Toggle("石头0", "RK0", false, function(RK0)
    getgenv().RK0 = RK0 while getgenv().RK0 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(7.60643005, 4.02632904, 2104.54004, -0.23040159, -8.53662385e-08, -0.973095655, -4.68743764e-08, 1, -7.66279342e-08, 0.973095655, 2.79580536e-08, -0.23040159) end if not getgenv().RK0 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end
end)
YU_SHEN:Toggle("石头10", "RK10", false, function(RK10)
    if game.Players.LocalPlayer.Durability.Value >= 10 then getgenv().RK10 = RK10 while getgenv().RK10 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-157.680908, 3.72453046, 434.871185, 0.923298299, -1.81774684e-09, -0.384083599, 3.45247031e-09, 1, 3.56670582e-09, 0.384083599, -4.61917082e-09, 0.923298299) end if not getgenv().RK10 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
YU_SHEN:Toggle("石头100", "RK100", false, function(RK100)
    if game.Players.LocalPlayer.Durability.Value >= 100 then getgenv().RK100 = RK100 while getgenv().RK100 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(162.233673, 3.66615629, -164.686783, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928) end if not getgenv().RK100 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
YU_SHEN:Toggle("石头5000", "RK5000", false, function(RK5000)
    if game.Players.LocalPlayer.Durability.Value >= 5000 then getgenv().RK5000 = RK5000 while getgenv().RK5000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(329.831482, 3.66450214, -618.48407, -0.806075394, -8.67358096e-08, 0.591812849, -1.05715522e-07, 1, 2.57029176e-09, -0.591812849, -6.04919563e-08, -0.806075394) end if not getgenv().RK5000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
YU_SHEN:Toggle("石头150000", "RK150000", false, function(RK150000)
    if game.Players.LocalPlayer.Durability.Value >= 150000 then getgenv().RK150000 = RK150000 while getgenv().RK150000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2566.78076, 3.97019577, -277.503235, -0.923934579, -4.11600105e-08, -0.382550538, -3.38838042e-08, 1, -2.57576183e-08, 0.382550538, -1.08360858e-08, -0.923934579) end if not getgenv().RK150000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
YU_SHEN:Toggle("石头400000", "RK400000", false, function(RK400000)
    if game.Players.LocalPlayer.Durability.Value >= 400000 then getgenv().RK400000 = RK400000 while getgenv().RK400000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2155.61743, 3.79830337, 1227.06482, -0.551303148, -9.16796949e-09, -0.834304988, -5.61318245e-08, 1, 2.61027839e-08, 0.834304988, 6.12216127e-08, -0.551303148) end if not getgenv().RK400000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
YU_SHEN:Toggle("石头750000", "RK750000", false, function(RK750000)
    if game.Players.LocalPlayer.Durability.Value >= 750000 then getgenv().RK750000 = RK750000 while getgenv().RK750000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7285.6499, 3.66624784, -1228.27417, 0.857643783, -1.58175091e-08, -0.514244199, -1.22581563e-08, 1, -5.12025977e-08, 0.514244199, 5.02172774e-08, 0.857643783) end if not getgenv().RK750000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
YU_SHEN:Toggle("石头100万", "RK1M", false, function(RK1M)
    if game.Players.LocalPlayer.Durability.Value >= 1000000 then getgenv().RK1M = RK1M while getgenv().RK1M do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4160.87109, 987.829102, -4136.64502, -0.893115997, 1.25481356e-05, 0.44982639, 5.02490684e-06, 1, -1.79187136e-05, -0.44982639, -1.37431543e-05, -0.893115997) end if not getgenv().RK1M then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
YU_SHEN:Toggle("石头500万", "RK5M", false, function(RK5M)
    if game.Players.LocalPlayer.Durability.Value >= 5000000 then getgenv().RK5M = RK5M while getgenv().RK5M do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8957.54395, 5.53625107, -6126.90186, -0.803919137, 6.6065212e-08, 0.594738603, -8.93136143e-09, 1, -1.23155459e-07, -0.594738603, -1.04318865e-07, -0.803919137) end if not getgenv().RK5M then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)

YU_SHEN:Button("传送到出生点",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108)
end)

YU_SHEN:Button("传送到安全岛",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, 10, 1838)
end)

YU_SHEN:Button("传送到幸运抽奖区域😏😏😏",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2606, -2, 5753)
end)

YU_SHEN:Button("传送到肌肉之王健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642)
end)

YU_SHEN:Button("传送到传说健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915)
end)

YU_SHEN:Button("传送到永恒健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284)
end)

YU_SHEN:Button("传送到神话健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070)
end)

YU_SHEN:Button("传送到冰霜健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410)
end)

YU_SHEN:Button("力量传奇改力量",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/jynzl/main/main/Musclas%20Legenos.lua'))()
end)

local YU_Tab = YU:Tab("钓鱼模拟器", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("跳跃","text",false,function(s)
shared.toggle = State
     if shared.toggle then
    fuckMonster = RunService.Stepped:Connect(function()
     for i, v in pairs(game.Workspace:GetChildren()) do
     if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then


                    for i, getTools in pairs(player.Character:GetChildren()) do
                        if getTools:IsA("Tool") and  getTools:FindFirstChild("GripC1") then
                            plrTools = getTools.Name
                        end
                    end

                    teleport(v.HumanoidRootPart.CFrame + Vector3.new(0, 30, 0))
                    wait(1)
                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.MonsterHit:FireServer(workspace[v.Name], tostring(plrTools), true)
                    break
                elseif not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    EquipTool()
               break
            end
        end
     end
     end)
    else
         fuckMonster:Disconnect()
          teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))
        end
end)
YU_SHEN:Toggle("自动杀鲨鱼","text",false,function(State)
 shared.toggle = State
     if shared.toggle then
    fuckMonster = RunService.Stepped:Connect(function()
     for i, v in pairs(game.Workspace:GetChildren()) do
     if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then


                    for i, getTools in pairs(player.Character:GetChildren()) do
                        if getTools:IsA("Tool") and  getTools:FindFirstChild("GripC1") then
                            plrTools = getTools.Name
                        end
                    end

                    teleport(v.HumanoidRootPart.CFrame + Vector3.new(0, 30, 0))
                    wait(1)
                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.MonsterHit:FireServer(workspace[v.Name], tostring(plrTools), true)
                    break
                elseif not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    EquipTool()
               break
            end
        end
     end
     end)
    else
         fuckMonster:Disconnect()
          teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))
        end
end)
YU_SHEN:Toggle("自动钓鱼","text",false,function(bool)
 if bool then
            local rodName = false
            while not rodName do
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:FindFirstChild("FishingRodScript") then
                        rodName = v.Name
                        break
                    end
                end
                wait()
            end

            bBobber = game.Players.LocalPlayer.Character:WaitForChild(rodName).Bobbers.Bobber.Fish.Changed:Connect(
                function(fishVal)
                    if fishVal ~= nil then
                        --if not legendToggle then
                            game.Workspace:WaitForChild(tostring(fishVal))
                            wait()
                            game.ReplicatedStorage.CloudClientResources.Communication.Events.FishedDone:FireServer()
                            wait()
                            game.ReplicatedStorage.CloudClientResources.Communication.Events.ResetFishingRod:FireServer()
                            wait()
                        --[[else
                            if game.Workspace:WaitForChild(tostring(fishVal)).RarityLevel.Value >= 5 then
                                game.ReplicatedStorage.CloudClientResources.Communication.Events.FishedDone:FireServer()
                                wait()
                                game.ReplicatedStorage.CloudClientResources.Communication.Events.ResetFishingRod:FireServer()
                                wait()
                            end                                                                                                 
                        end                                                                                                        --]]
					end
					if game.Players.LocalPlayer.Character:WaitForChild(rodName).Bobbers.Bobber:FindFirstChild("FishWeld") then
						for p, q in pairs(game.Players.LocalPlayer.Character:WaitForChild(rodName).Bobbers.Bobber:GetChildren()) do
							if q.Name == "FishWeld" then
								q:Destroy()
							end
						end
					end
                end
            )
        else 
            bBobber:Disconnect()
        end
end)
YU_SHEN:Toggle("自动杀boss","text",false,function(State)
 shared.toggle = State
     if shared.toggle then
    fuckMobby = RunService.Stepped:Connect(function()
     for i, v in pairs(game.Workspace:GetChildren()) do
     if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") and v.Name == "MobbyWood" then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then


                    for i, getTools in pairs(player.Character:GetChildren()) do
                        if getTools:IsA("Tool") and  getTools:FindFirstChild("GripC1") then
                            plrTools = getTools.Name
                        end
                    end

                    teleport(v.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0))
                    wait(1)
                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.MonsterHit:FireServer(workspace[v.Name], tostring(plrTools), true)
                    break
                elseif not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    EquipTool()
               break
            end
        end
     end
     end)
    else
         fuckMobby:Disconnect()
          teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))
        end
end)
YU_SHEN:Toggle("减少延迟","text",false,function(State)
 toggle = State
     if toggle then
        while toggle do 
            wait(30)
            for i, v in pairs(game.Workspace.DroppedItems:GetChildren()) do
                if v:IsA("Model") then
                    v:Destroy()
                end
            end
        end
      end
end)
YU_SHEN:Toggle("自动锁定稀有物品","text",false,function(State)
 toggle = State
     if toggle then
        while toggle do 
            wait(.1)
for i, v in pairs(game.Players.LocalPlayer.PlayerGui.Interface.Inventory.Inventory.Frame.Backpack.List.Container:GetChildren()) do
        if string.match(v.Name, "key") then
            for i, model in pairs(v:GetDescendants()) do
                if model:IsA("Tool") then
                    if model.RarityLevel.Value >= 5 then

                        if v.DraggableComponent.Contents.LockIcon.Visible == false then
                            print(v.Name, model.Name, model.RarityLevel.Value)
                        local args = {
                            [1] = "Tools",
                            [2] = v.Name,
                            [3] = true
                        }
                        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.SetInventoryItemLock:InvokeServer(unpack(args))

                        end
                    end
                end
            end
        end
end

        end
      end
end)
YU_SHEN:Toggle("自动抓捕","text",false,function(State)
 toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.FishCaught:FireServer()
    end
end)
YU_SHEN:Toggle("自动售卖","text",false,function(State)
 toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.processGameItemSold:InvokeServer("SellEverything")
    end
end)
YU_SHEN:Toggle("每日宝箱","text",false,function(State)
 toggle = State
        while toggle do
                for i, v in pairs(game.Workspace.Islands:GetDescendants()) do
                    if v:IsA("Model") and string.match(v.Name, "Chest") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        wait(1)
                        fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
                    end
                end            
        end
end)
YU_SHEN:Toggle("随机宝箱","text",false,function(State)
 toggle = State
        while toggle do
                for i, v in pairs(game.Workspace.RandomChests:GetDescendants()) do
                    if v:IsA("Model") and string.match(v.Name, "Chest") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        wait(1)
                        fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
                    end
                end            
        end
end)
local wood_types = {"选择", "Earth Egg","Alien Egg","Dominus Egg","Ice Egg","Lava Egg","Heavens Egg","Toy Egg","Mine Egg"}
if not game.workspace:FindFirstChild("PFA") then 
    local part = Instance.new("Part") 
    part.Name = "PFA" 
    part.Parent = game.workspace 
    part.CFrame = CFrame.new(-1087, -40, 1670) 
    part.Size = Vector3.new(50, 0, 50) 
    part.Anchored = true 
    part.Reflectance = 1 
end

function C() 
    spawn(function () 
        while getgenv().C do
            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                TPCFrame(CFrame.new(-1087, -35, 1670))
                if v.ToolTip == "Weight" then 
                    v.Parent = game.Players.LocalPlayer.Character 
                end
                if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then 
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate() 
                end
            end 
            wait()
        end
    end)
end

function U() 
    spawn(function () 
        while getgenv().U do
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Damage_Multiplier"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Health_Multiplier"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Jump_Power"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Walk_Speed"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Pet_Space"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Pet_Inventory"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            wait()
        end
    end)
end

function R() 
    spawn(function () 
        while getgenv().R do
            local args = {[1] = "S_Controller_Rebirth_Rebirth",[2] = {}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            wait()
        end
    end)
end

function H(E) 
    spawn(function () 
        while getgenv().H do
            local args = {[1] = "S_Controller_Eggs_Buy",[2] = {[1] = E}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteFunction:InvokeServer(unpack(args))
            wait()
        end
    end)
end

local YU_Tab = YU:Tab("火箭发射模拟器", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("自动收集燃料", "ARL", false, function(ARL)
    isFuelScoopEnabled = ARL while true do wait() if isFuelScoopEnabled then for i, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "FuelScoop" then h:Activate() end end end end
end)
YU_SHEN:Button("登上火箭", function()
    game:GetService("ReplicatedStorage"):WaitForChild("BoardRocket"):FireServer()
end)
YU_SHEN:Button("将玩家从所有者座位移除", function()
    game:GetService("ReplicatedStorage"):WaitForChild("RemovePlayer"):FireServer()
end)

YU_SHEN:Button("发射台岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-123.15931701660156, 2.7371432781219482, 3.491959810256958)
end)
YU_SHEN:Button("白云岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-76.13252258300781, 170.55825805664062, -60.4516716003418)
end)
YU_SHEN:Button("浮漂岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-66.51714324951172, 720.4866333007812, -5.391753196716309)
end)
YU_SHEN:Button("卫星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-34.2462043762207, 1429.4990234375, 1.3739361763000488)
end)
YU_SHEN:Button("蜜蜂迷宫岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6.5361199378967285, 3131.249267578125, -29.759048461914062)
end)
YU_SHEN:Button("月球人救援", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7.212917804718018, 5016.341796875, -19.815933227539062)
end)
YU_SHEN:Button("暗物质岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.43186950683594, 6851.94091796875, 7.890637397766113)
end)
YU_SHEN:Button("太空岩石岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(49.92888641357422, 8942.955078125, 8.674375534057617)
end)
YU_SHEN:Button("零号火星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(54.44503402709961, 11270.0927734375, -1.273137092590332)
end)
YU_SHEN:Button("太空水晶小行星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11.579089164733887, 15295.6318359375, -27.54974365234375)
end)
YU_SHEN:Button("月球浆果岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-14.601255416870117, 18410.9609375, 0.9418511986732483)
end)
YU_SHEN:Button("铺路石岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3.272758960723877, 22539.494140625, 63.283935546875)
end)
YU_SHEN:Button("流星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-45.515689849853516, 27961.560546875, -7.358333110809326)
end)
YU_SHEN:Button("升级岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2.7595248222351074, 33959.98828125, 53.93095397949219)
end)

YU_SHEN:Button("火箭发射模拟器1",function()
loadstring(game:HttpGet("https://ayangwp.cn/api/v3/file/get/9245/%E7%8C%AB%E9%80%9A%E7%94%A8.txt?sign=hrWROZdVfK2mtJcIFa3Tvbl-TojP1C86_Zd3q03qttc%3D%3A0"))()
end)

YU_SHEN:Button("火箭发射模拟器2",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/dizyhvh/rbx_scripts/main/321_blast_off_simulator')))()
end)

YU_SHEN:Button("火箭发射模拟器3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/odhdshhe/jm-/refs/heads/main/jm%E7%81%AB%E7%AE%AD%E5%8F%91%E5%B0%84%E9%87%8D%E5%81%9A(1).lua"))()
end)

local YU_Tab = YU:Tab("巴掌模拟器", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("无CD","Toggle" ,false, function(Value)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local tool = character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
    
    bazhangmnq = Value
    
    while bazhangmnq do
    local localscript = tool:FindFirstChildOfClass("LocalScript")
    local localscriptclone = localscript:Clone()
    localscriptclone = localscript:Clone()
    localscriptclone:Clone()
    localscript:Destroy()
    localscriptclone.Parent = tool
    wait(0.1)
    end
    end)
    
    YU_SHEN:Button("获取计数器手套", function()
    fireclickdetector(game.Workspace.CounterLever.ClickDetector)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,100,0)
    wait(0.2)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    wait(121)
    for i,v in pairs(workspace.Maze:GetDescendants()) do
    if v:IsA("ClickDetector") then
    fireclickdetector(v)
    end
    end
    end)
    
    YU_SHEN:Toggle("地牢亮度","Toggle" ,false, function(Value)
     Light = Value
        if not Light then
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end)
    
    YU_SHEN:Dropdown("传送","Dropdown",{"安全区","竞技场","埃及岛","果实岛","盘子","锦标赛","默认竞技场"},function(Value)
    if Value == "安全区" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Spot.CFrame * CFrame.new(0,40,0)
    elseif Value == "竞技场" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,-5,0)
    elseif Value == "埃及岛" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(215, -15.5, 0.5)
    elseif Value == "果实岛" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Arena.island5.Union.CFrame * CFrame.new(0,3.25,0)
    elseif Value == "盘子" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Arena.Plate.CFrame * CFrame.new(0,2,0)
    elseif Value == "锦标赛" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Battlearena.Arena.CFrame * CFrame.new(0,10,0)
    elseif Value == "默认竞技场" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(120,360,-3)
    end
    end)
    
    YU_SHEN:Toggle("复古技能","Toggle" ,false, function(Value)
    RetroSpam = Value
    while RetroSpam do
    game:GetService("ReplicatedStorage").RetroAbility:FireServer(RetroAbility)
    task.wait()
    end
    end)
    
    YU_SHEN:Dropdown("复古技能选择","Dropdown",{"Rocket Launcher","Ban Hammer","Bomb"}, function(Value)
    RetroAbility = Value
    end)
    
    YU_SHEN:Toggle("自动捡糖果","Toggle",false, function(Value)
    CandyCornFarm = Value
    while CandyCornFarm do
    for i, v in pairs(workspace.CandyCorns:GetChildren()) do
                    if v:FindFirstChildWhichIsA("TouchTransmitter") then
    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("获取炼金术师材料","Toggle", false, function(Value)
    AlchemistIngredients = Value
    if game.Players.LocalPlayer.leaderstats.Glove.Value == "Alchemist" then
    while AlchemistIngredients do
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Mushroom")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Glowing Mushroom")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Fire Flower")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Winter Rose")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Dark Root")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Dire Flower")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Autumn Sprout")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Elder Wood")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Hazel Lily")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Wild Vine")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Jade Stone")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Lamp Grass")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Plane Flower")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Blood Rose")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Red Crystal")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Blue Crystal")
    task.wait()
    end
    end
    end)
    
    YU_SHEN:Toggle("自动加入竞技场","Toggle", false, function(Value)
    AutoEnterArena = Value
    while AutoEnterArena do
    if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
        end
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("自动辰波球","Toggle", false, function(Value)
    if Person == nil then
    Person = game.Players.LocalPlayer.Name
    end
    _G.RojoSpam = Value
    while _G.RojoSpam do
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players[Person].Character.HumanoidRootPart.CFrame})
    task.wait()
    end
    end)
    
    YU_SHEN:Button("Rojo技能", function(Value)
    _G.RojoSpam = Value
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Charge")
    wait(6)
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame})
    task.wait()
    end)
    
    YU_SHEN:Toggle("音符技能","Toggle", false, function(Value)
    _G.RhythmSpam = Value
    while _G.RhythmSpam do
    game:GetService("ReplicatedStorage").rhythmevent:FireServer("AoeExplosion",0)
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("Null技能","Toggle", false, function(Value)
    NullSpam = Value
    while NullSpam do
    game:GetService("ReplicatedStorage").NullAbility:FireServer()
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("自动拾取黄金果实","Toggle", false, function(Value)
    SlappleFarm = Value
    while SlappleFarm do
    for i, v in ipairs(workspace.Arena.island5.Slapples:GetDescendants()) do
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Name == "Glove" and v:FindFirstChildWhichIsA("TouchTransmitter") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                    end
                end
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("自动捡飞行宝珠","Toggle", false, function(Value)
    Jetfarm = Value
    while Jetfarm do
    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "JetOrb" and v:FindFirstChild("TouchInterest") then
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 0)
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 1)
                        end
                    end
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("自动捡相位球","Toggle", false, function(Value)
    Phasefarm = Value
    while Phasefarm do
    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "PhaseOrb" and v:FindFirstChild("TouchInterest") then
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 0)
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 1)
                        end
                    end
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("自动刷bob","Toggle", false, function(Value)
    ReplicaFarm = Value
    while ReplicaFarm do
    for i, v in pairs(workspace:GetChildren()) do
                    if v.Name:match(game.Players.LocalPlayer.Name) and v:FindFirstChild("HumanoidRootPart") then
    game.ReplicatedStorage.b:FireServer(v:WaitForChild("HumanoidRootPart"))
                    end
                end
    task.wait()
    game:GetService("ReplicatedStorage").Duplicate:FireServer()
    task.wait(7)
    end
    end)
    
    YU_SHEN:Toggle("无限反转","Toggle", false, function(Value)
    _G.InfReverse = Value
    while _G.InfReverse do
    game:GetService("ReplicatedStorage").ReverseAbility:FireServer()
    wait(6)
    end
    end)
    
    YU_SHEN:Toggle("彩虹角色(装备黄金手套)","Toggle", false, function(Value)
    _G.Rainbow = Value
    while _G.Rainbow do
    for i = 0,1,0.001*25 do
    game:GetService("ReplicatedStorage").Goldify:FireServer(false, BrickColor.new(Color3.fromHSV(i,1,1)))
    task.wait()
    end
    end
    end)
    
    YU_SHEN:Toggle("防击飞","Toggle", false, function(Value)
    AntiRagdoll = Value
    if AntiRagdoll then
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
    game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Changed:Connect(function()
    if game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == true and AntiRagdoll then
    repeat task.wait() game.Players.LocalPlayer.Character.Torso.Anchored = true
    until game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == false
    game.Players.LocalPlayer.Character.Torso.Anchored = false
    end
    end)
    end)
    end
    end)
    
    YU_SHEN:Toggle("反虚空(锦标赛也有效果)","Toggle", false, function(Value)
    game.Workspace.dedBarrier.CanCollide = Value
    game.Workspace.TAntiVoid.CanCollide = Value
    end)

YU_SHEN:Toggle("防死亡屏障","Toggle", false, function(Value)
    if Value == true then
    for i,v in pairs(game.Workspace.DEATHBARRIER:GetChildren()) do
                        if v.ClassName == "Part" and v.Name == "BLOCK" then
                            v.CanTouch = false
                        end
                    end
    workspace.DEATHBARRIER.CanTouch = false
    workspace.DEATHBARRIER2.CanTouch = false
    workspace.dedBarrier.CanTouch = false
    workspace.ArenaBarrier.CanTouch = false
    workspace.AntiDefaultArena.CanTouch = false
    else
    for i,v in pairs(game.Workspace.DEATHBARRIER:GetChildren()) do
                        if v.ClassName == "Part" and v.Name == "BLOCK" then
                            v.CanTouch = true
                        end
                    end
    workspace.DEATHBARRIER.CanTouch = true
    workspace.DEATHBARRIER2.CanTouch = true
    workspace.dedBarrier.CanTouch = true
    workspace.ArenaBarrier.CanTouch = true
    workspace.AntiDefaultArena.CanTouch = true
    end
    end)
    
    YU_SHEN:Toggle("反巴西","Toggle", false, function(Value)
    if Value == true then
    for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
                            v.CanTouch = false
                    end
    else
    for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
                            v.CanTouch = true
                    end
    end
    end)
    
    YU_SHEN:Toggle("反死亡方块","Toggle", false, function(Value)
    if Value == true then
            workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = false
            else
                    workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = true
            end
    end)
    
    YU_SHEN:Toggle("反上帝技能","Toggle", false, function(Value)
    AntiTimestop = Value
    while AntiTimestop do
                    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v.ClassName == "Part" then
                            v.Anchored = false
                        end
                    end
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("反鱿鱼","Toggle", false, function(Value)
    AntiSquid = Value
    if AntiSquid == false then
            game.Players.LocalPlayer.PlayerGui.SquidInk.Enabled = true
            end
    while AntiSquid do
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("SquidInk") then
            game.Players.LocalPlayer.PlayerGui.SquidInk.Enabled = false
    end
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("反神圣杰克","Toggle", false, function(Value)
    game.Players.LocalPlayer.PlayerScripts.HallowJackAbilities.Disabled = Value
    end)
    
    YU_SHEN:Toggle("反传送带","Toggle", false, function(Value)
    game.Players.LocalPlayer.PlayerScripts.ConveyorVictimized.Disabled = Value
    end)
    
    YU_SHEN:Toggle("反板砖","Toggle", false, function(Value)
    AntiBrick = Value
    while AntiBrick do
    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "Union" then
                            v.CanTouch = false
                        end
                    end
    task.wait()
    end
    end)
    
    YU_SHEN:Toggle("反Null","Toggle", false, function(Value)
    AntiNull = Value
    while AntiNull do
    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "Imp" and v:FindFirstChild("Body") then
    shared.gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(v.Body,true)
    end
    end
    task.wait()
    end
    end)
    
YU_SHEN:Button("自动刷巴掌",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Slap%20Farm'))()
end)

YU_SHEN:Button("巴掌模拟器1",function()
loadstring(game:HttpGet("https://lkhub.net/s/loader.lua"))()
end)

YU_SHEN:Button("巴掌模拟器2",function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Slap%20Battles")))()
end)

YU_SHEN:Button("巴掌模拟器3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dizyhvh/slap_battles_gui/main/0.lua"))()
end)

local YU_Tab = YU:Tab("超级大力士模拟器", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("传送到开始区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(85.86943817138672, 11.751949310302734, -198.07127380371094)
    end)
    
YU_SHEN:Button("传送到健身区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(93.60747528076172, 11.751947402954102, -10.266206741333008)
    end)
    
YU_SHEN:Button("传送到食物区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(78.86384582519531, 11.751947402954102, 228.9690399169922)
    end)
    
YU_SHEN:Button("传送到街机区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(88.99887084960938, 11.751949310302734, 502.90997314453125)
    end)
    
YU_SHEN:Button("传送到农场区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(85.6707763671875, 11.751947402954102, 788.5997314453125)
    end)
    
YU_SHEN:Button("传送到城堡区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(84.87281036376953, 11.84177017211914, 1139.7509765625)
    end)
    
YU_SHEN:Button("传送到蒸汽朋克区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(92.63227081298828, 11.841767311096191, 1692.7890625)
    end)
    
YU_SHEN:Button("传送到迪斯科区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(98.69613647460938, 16.015085220336914, 2505.213134765625)
    end)
    
YU_SHEN:Button("传送到太空区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(88.42948150634766, 11.841769218444824, 3425.941650390625)
    end)
    
YU_SHEN:Button("传送到糖果区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(63.55805969238281, 11.841663360595703, 4340.69921875)
    end)
    
YU_SHEN:Button("送到实验室区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(78.00920867919922, 11.841663360595703, 5226.60205078125)
    end)
    
YU_SHEN:Button("传送到热带区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80.26090240478516, 12.0902681350708, 6016.16552734375)
    end)
    
YU_SHEN:Button("传送到恐龙区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(38.4753303527832, 25.801530838012695, 6937.779296875)
    end)
    
YU_SHEN:Button("传送到复古区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99.81867218017578, 12.89099407196045, 7901.74755859375)
    end)
    
YU_SHEN:Button("传送到冬季区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(63.47243881225586, 11.841662406921387, 8983.810546875)
    end)
    
YU_SHEN:Button("传送到深海区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(105.36250305175781, 26.44820213317871, 9970.0849609375)
    end)
    
YU_SHEN:Button("传送到狂野西部区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.69414520263672, 15.108586311340332, 10938.654296875)
    end)
    
YU_SHEN:Button("传送到豪华公寓区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.75145721435547, 11.313281059265137, 12130.349609375)
    end)
    
YU_SHEN:Button("传送到宝剑战斗区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(111.25597381591797, 11.408829689025879, 12945.57421875)
    end)
    
YU_SHEN:Button("传送到童话区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(121.14932250976562, 11.313281059265137, 14034.50390625)
    end)
    
YU_SHEN:Button("传送到桃花区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108.2142333984375, 11.813281059265137, 15131.861328125)
    end)
    
YU_SHEN:Button("传送到厨房区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.78338623046875, 21.76291847229004, 16204.9755859375)
    end)
    
YU_SHEN:Button("传送到下水道区域", function()
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(47.36086654663086, 12.25178050994873, 17656.04296875)
    end)
    
YU_SHEN:Button("超级大力士模拟器1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraIsMe2/ToraIsMe2/main/0strongman", true))()
end)

YU_SHEN:Button("超级大力士模拟器2",function()
loadstring(game:HttpGet("https://pastefy.app/aO18ZEB9/raw"))()
end)

YU_SHEN:Button("超级大力士模拟器3",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/hngamingroblox/scripts/main/strongman%20simulator'))()
end)

YU_SHEN:Button("超级大力士模拟器4",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraIsMe2/ToraIsMe2/main/0strongman", true))()
end)

local YU_Tab = YU:Tab("doors", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("能用ms",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/mspaint/main/main.lua"))()
end)

YU_SHEN:Toggle("刷新时通知", "TZ", false, function(TZ)
     _G.IE = (TZ and true or false) LatestRoom.Changed:Connect(function() if _G.IE == true then local n = ChaseStart.Value - LatestRoom.Value if 0 < n and n < 4 then Notification:Notify("请注意", "事件可能刷新于" .. tostring(n) .. " 房间","rbxassetid://17360377302",3) end end end) workspace.ChildAdded:Connect(function(inst) if inst.Name == "RushMoving" and _G.IE == true then Notify("请注意", "Rush 已刷新","rbxassetid://17360377302",3) elseif inst.Name == "AmbushMoving" and _G.IE == true then Notify("请注意", "Ambush 已刷新","rbxassetid://17360377302",3) end end)
end)

YU_SHEN:Toggle("自动躲避Rush/Ambush", "ADB", false, function(ADB)
    _G.Avoid = (ADB and true or false) workspace.ChildAdded:Connect(function(inst) if inst.Name == "RushMoving" and _G.Avoid == true then Notify("请注意!", "正在躲避 Rush.","rbxassetid://17360377302",3) local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position local con = game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0)) end) inst.Destroying:Wait() con:Disconnect() game.Players.LocalPlayer.Character:MoveTo(OldPos) elseif inst.Name == "AmbushMoving" and _G.Avoid == true then Notify("注意!", "正在躲避 Ambush.","rbxassetid://17360377302",3) local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position local con = game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0)) end) inst.Destroying:Wait() con:Disconnect() game.Players.LocalPlayer.Character:MoveTo(OldPos) end end)
end)
YU_SHEN:Toggle("无 Screech", "NCH", false, function(NCH)
    _G.NS = (NCH and true or false) workspace.CurrentCamera.ChildAdded:Connect(function(child) if child.Name == "Screech" and _G.NS == true then child:Destroy() end end)
end)

YU_SHEN:Button("最强汉化",function()
loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)

YU_SHEN:Button("最新",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/KINGHUB01/BlackKing-obf/main/Doors%20Blackking%20And%20BobHub"))()
end)

YU_SHEN:Button("DX",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/DXuwu/replicator-lol/main/dor.lua"))()
end)

YU_SHEN:Button("RP变怪",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAccelerator/Public-Scripts/main/Morphing/MorphScript.lua"))()
end)

YU_SHEN:Button("剪刀",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/shears_done.lua"))()
end)

YU_SHEN:Button("十字架",function()
loadstring(game:HttpGet("https://pastebin.com/raw/FCSyG6Th"))()
end)

YU_SHEN:Button("神圣炸弹",function()
loadstring(game:HttpGet("https://pastebin.com/raw/u5B1UjGv"))()
end)

YU_SHEN:Button("吸铁石",function()
loadstring(game:HttpGet("https://pastebin.com/raw/xHxGDp51"))()
end)

YU_SHEN:Button("刷怪变怪",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/cbhlyy/lyycbh/main/shuaguai"))()
end)

YU_SHEN:Button("变身",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ChronoAccelerator/Public-Scripts/main/Morphing/MorphScript.lua"))()
end)
YU_SHEN:Button("最强英文",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/notpoiu/mspaint/main/main.lua"))()
end)

YU_SHEN:Button("最强英文汉化",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/nnzhonhxin/114514/refs/heads/main/DOORS.txt"))()
end)

YU_SHEN:Button("room",function()
loadstring(game:HttpGet(('https://pastebin.com/raw/R8QMbhzv')))()
end)

local YU_Tab = YU:Tab("感染性微笑", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("防止微笑感染",function()
for _,v in pairs(game.workspace:GetDescendants()) do

if string.find(v.Name,"Infector") then
v:Destroy()
end
end
end)
YU_SHEN:Button("取消门",function()
for _,v in pairs(game.workspace:GetDescendants()) do

if string.find(v.Name,"AntiSmiler") then
v:Destroy()
end
end
end)
YU_SHEN:Button("开启反外挂",function()
workspace.Map.AntiHack:Destroy() game.Players.LocalPlayer.Character.AntiFly:Destroy()
end)
YU_SHEN:Toggle("速度-微笑感染","text",false,function(s)
getgenv().SlowDownSpeed = getgenv().SlowDownSpeed or 16
        getgenv().NoSlowDown = Value
        if getgenv().NoSlowDown then
            SteppedConnection = game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().SlowDownSpeed
                end)
            end)
        else
            if SteppedConnection then
                SteppedConnection:Disconnect()
                SteppedConnection = nil
            end
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
end)
YU_SHEN:Toggle("打击微笑感染","text",false,function(s)
getgenv().InfectAura = Value
        if getgenv().InfectAura then
            getgenv().InfectAuraConnection = game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    game:GetService("Players").LocalPlayer.Character.Infected.InfectEvent:FireServer()
                end)
            end)
        else
            if getgenv().InfectAuraConnection then
                getgenv().InfectAuraConnection:Disconnect()
                getgenv().InfectAuraConnection = nil
            end
        end
end)
YU_SHEN:Toggle("Bat打击","text",false,function(s)
getgenv().HitAura = s
        if getgenv().HitAura then
            getgenv().HitAuraConnection = game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    local character = game:GetService("Players").LocalPlayer.Character
                    if character then
                        local bat = character:FindFirstChildOfClass("Tool")
                        if bat and bat.Name == "Bat" and bat:FindFirstChild("SwingEvent") then
                            bat.SwingEvent:FireServer()
                        end
                           if packedice and packedice.Name == "Packed Ice" and packedice:FindFirstChild("SwingEvent") then
                           packedice.SwingEvent:FireServer()
                        end
                    end
                end)
            end)
        else
            if getgenv().HitAuraConnection then
                getgenv().HitAuraConnection:Disconnect()
                getgenv().HitAuraConnection = nil
            end
        end
end)
YU_SHEN:Toggle("瓶子打击","text",false,function(s)
getgenv().HitAura = s
        if getgenv().HitAura then
            getgenv().HitAuraConnection = game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    local character = game:GetService("Players").LocalPlayer.Character
                    if character then
                        local bottle = character:FindFirstChildOfClass("Tool")
                        if bottle and bottle.Name == "Bottle" and bottle:FindFirstChild("SwingEvent") then
                            bottle.SwingEvent:FireServer()
                        end
                           if packedice and packedice.Name == "Packed Ice" and packedice:FindFirstChild("SwingEvent") then
                           packedice.SwingEvent:FireServer()
                        end
                    end
                end)
            end)
        else
            if getgenv().HitAuraConnection then
                getgenv().HitAuraConnection:Disconnect()
                getgenv().HitAuraConnection = nil
            end
        end
end)   

local YU_Tab = YU:Tab("鲨口求生", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Dropdown("船只提取器", "FreeBoat", { "摩托艇", "摩托艇", "独角兽挺", "摩托艇", "红马林鱼", "单栀帆船", "拖船", "小船摩托艇", "摩托艇甜甜圈", "马林鱼", "管船", "渔船", "维京船", "小树林帆船", "红冠摩托艇", "双体船", "战斗船", "游船", "鸭海军陆战队", "派对船", "军事潜艇", "姜饼蒸汽船", "雪橇2022", "雪地摩托", "游轮"}, function(CS)
  game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat:FireServer(CS)
end)

YU_SHEN:Button("自动杀鲨鱼", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Misc%20Scripts/sharkbite2.lua",true))()
end)

YU_SHEN:Button("鲨口求生1",function()
loadstring(game:HttpGet("https://pastebin.com/raw/YYVLbzVg", true))()
end)

YU_SHEN:Button("鲨口求生2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LOOF-sys/Roblox-Shit/main/SharkBite.lua",true))()
end)

YU_SHEN:Button("鲨口求生3",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Lolboxo/SharkBiteV3/main/SharkBiteV3.1'))()
end)

YU_SHEN:Button("鲨口求生刷船",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/ghostapustaja/legionhub/main/sharkbite2'),true))()
end)

local YU_Tab = YU:Tab("奎尔湖", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("奎尔湖1",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Solx69/Shit-Boy-Hub-Main/main/Master.lua'))()
end)

YU_SHEN:Toggle("无敌模式","", false, function(Value)
        game.ReplicatedStorage.DamageHumanoid:FireServer(-2e9)
    end)
    
    YU_SHEN:Button("无限金钱", function()
    local money = {
       [1] = -9999,
       [2] = "Buy"
    }
    
    game:GetService("ReplicatedStorage").Pay:FireServer(unpack(money))
    end)
    
    YU_SHEN:Button("无限金币", function()
    local gold = {
       [1] = game:GetService("Players").LocalPlayer.GoldCoins,
       [2] = 99999
    }
    
    game:GetService("ReplicatedStorage").ChangeValue:FireServer(unpack(gold))
    end)
    
    YU_SHEN:Button("给所有物品", function()
    game.ReplicatedStorage.GiveTool:FireServer("SeaScooter")
    game.ReplicatedStorage.GiveTool:FireServer("Lantern")
    game.ReplicatedStorage.GiveTool:FireServer("Compass")
    game.ReplicatedStorage.GiveTool:FireServer("ItemFinder")
    game.ReplicatedStorage.GiveTool:FireServer("Aquabreather")
    end)
    
    YU_SHEN:Button("红色套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("FireSuit")
    end)
    
    YU_SHEN:Button("黄色套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("HazmatSuit")
    end)
    
    YU_SHEN:Button("海盗套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("PirateCostume")
    end)
    
    YU_SHEN:Button("动力套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("SuperScuba")
    end)
    
local YU_Tab = YU:Tab("怪兽宇宙", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Textbox("技能名称", "SkillName", "", function(text)
    _G.skillname = tostring(text)
    for i,v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v,"ID") ~= nil then
            if type(v.ID) ~= "number" then
                local test = v.ID:split("#")
                if test[1] == _G.skillname then
                    _G.skillname = v.ID
                end
            end
        end
    end
end)

YU_SHEN:Textbox("范围数值", "DistanceValue", "", function(text)
    _G.distance = tonumber(text)
end)

YU_SHEN:Toggle("自动使用所有能力", "UseAllAbilities", false, function(state)
    _G.abilitiestouse = state
    while _G.abilitiestouse do
        wait(0.5)
        pcall(function()
            for i,v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v,"globalCooldown") ~= nil then
                    task.wait()
                    for a,b in pairs(v) do
                        if a == "ID" then
                            task.wait(0.1)
                            game.Players.LocalPlayer.Character.ClientRunner.KaijuControlEvent:FireServer(b)
                        end
                    end
                end
            end
        end)
    end
end)

YU_SHEN:Toggle("自动使用所有攻击能力", "UseAttackAbilities", false, function(state)
    _G.abilitiestouse2 = state
    while _G.abilitiestouse2 do
        wait(0.5)
        pcall(function()
            for i,v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v,"globalCooldown") ~= nil then
                    task.wait()
                    if v.Cooldown < 6.1 then
                        wait(0.5)
                        game.Players.LocalPlayer.Character.ClientRunner.KaijuControlEvent:FireServer(v.ID)
                    end
                end
            end
        end)
    end
end)

YU_SHEN:Toggle("自动传送", "AutoTeleport", false, function(state)
    _G.test = state
    while _G.test do
        wait()
        pcall(function()
            _G.rat = nil
            local distance = math.huge
            for i,v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
                if v.Name == "BoundingBox" and _G.test == true and v.Parent:FindFirstChild("bValues") and v.Parent.bValues:FindFirstChild("Health") and v.Parent.bValues:FindFirstChild("Health").Value > v.Parent.bValues:FindFirstChild("MaxHealth").Value/2 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-v.Position).Magnitude < _G.distance then
                    local Dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude
                    if Dist < distance then
                        distance = Dist
                        _G.rat = v
                    end
                    task.wait()
                end
            end
            repeat 
                wait()
                local location = _G.rat.Position
                local LocalPlayer = game:GetService("Players").LocalPlayer
                local PlayerModule = require(LocalPlayer.PlayerScripts.PlayerModule)
                local ClickToMoveController = PlayerModule:GetClickToMoveController()
                ClickToMoveController:SetShowPath(false)
                ClickToMoveController:SetUserJumpEnabled(false)
                ClickToMoveController:MoveTo(location,true)
            until game.Players.LocalPlayer:DistanceFromCharacter(_G.rat.Position) < 60 or _G.test == false
            game.Players.LocalPlayer.Character.ClientRunner.KaijuControlEvent:FireServer(_G.skillname)
        end)
    end
end)

YU_SHEN:Toggle("自动重生", "AutoRespawn", false, function(state)
    _G.autospawn = state
    while _G.autospawn do
        wait()
        pcall(function()
            if _G.crack ~= nil and game:GetService("Players").LocalPlayer.PlayerGui.newUI.PlayingUI.Visible == false then
                game:GetService("ReplicatedStorage").Packages.Knit.Services.KaijuService.RF.Morph:InvokeServer(_G.crack, _G.crack1,nil,_G.crack3)
                wait(5)
                for i,v in pairs(getgc(true)) do
                    if type(v) == "table" and rawget(v,"ID") ~= nil then
                        if type(v.ID) ~= "number" then
                            local test = v.ID:split("#")
                            local test2 = _G.skillname:split("#")
                            if test[1] == test2[1] then
                                _G.skillname = v.ID
                            end
                        end
                    end
                end
                wait(10)
            elseif _G.crack2 ~= nil and game:GetService("Players").LocalPlayer.PlayerGui.newUI.PlayingUI.Visible == false then
                local test = math.random(1,4)
                for i,v in pairs(game:GetService("ReplicatedStorage").ReplicatedAssets.SpawnLocations:GetChildren()) do
                    if i == test and game.Players.LocalPlayer.Character.Parent == nil then
                        game:GetService("ReplicatedStorage").Packages.Knit.Services.KaijuService.RF.Morph:InvokeServer(_G.crack2,v,nil,_G.crack3)
                        wait(5)
                        for i,v in pairs(getgc(true)) do
                            if type(v) == "table" and rawget(v,"ID") ~= nil then
                                if type(v.ID) ~= "number" then
                                    local test = v.ID:split("#")
                                    local test2 = _G.skillname:split("#")
                                    if test[1] == test2[1] then
                                        _G.skillname = v.ID
                                    end
                                end
                            end
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

YU_SHEN:Toggle("自动隐藏用户", "HideNametag", false, function(state)
    _G.nametag = state
    while _G.nametag do
        wait()
        pcall(function()
            if game.Players.LocalPlayer.Character.Head:FindFirstChild("Nametag") then
                game.Players.LocalPlayer.Character.Head.Nametag:Destroy()
                wait()
            end
        end)
    end
end)

YU_SHEN:Button("Kill Yourself", function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)

spawn(function()
    while wait() do
        pcall(function()
            if _G.crack2 == nil and game.Players.LocalPlayer.Character ~= nil then
                _G.crack2 = game.Players.LocalPlayer.Character.Parent.Name
                wait()
            end
        end)
    end
end)

local YU_Tab = YU:Tab("奶酪逃亡", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("获取所有奶酪", function()
    for _, v in pairs(game.Workspace.FindCheese:GetDescendants()) do
        if v.Name == 'Cheese' then
            fireclickdetector(v.ClickDetector)
        end
    end
end)

YU_SHEN:Button("打开所有门", function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("ClickDetector") and v.Parent.Name:find("Door") then
            fireclickdetector(v)
        end
    end
end)

YU_SHEN:Button("出生点", function()
    game.Players.LocalPlayer.Character:MoveTo(game.Workspace.SpawnLocation.Position)
end)

YU_SHEN:Button("安全区1", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-73.6963, 4.2, -109.536))
end)

YU_SHEN:Button("奶酪1", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-264.393, 4.19329, -56.25))
end)

YU_SHEN:Button("奶酪2", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-275.163, 4.19329, -149.3))
end)

YU_SHEN:Button("奶酪3", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-271.628, 4.19329, -33.53))
end)

YU_SHEN:Button("安全区2", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-272.487, 48.5, -150.641))
end)

YU_SHEN:Button("奶酪4", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-205.069, 4.19329, -180.7))
end)

YU_SHEN:Button("跑酷", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-25.2942, 100.5, -1037.5))
end)

YU_SHEN:Button("离开", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-24.3932, 5, 24.3302))
end)

YU_SHEN:Button("锁定区域", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-220.522, 4, -452.123))
end)

YU_SHEN:Button("地下室", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-88.9135, 4, -451.278))
end)

YU_SHEN:Button("终点", function()
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(1758.41, 57, -137.61))
end)

local YU_Tab = YU:Tab("柔术", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)


YU_SHEN:Button("无限:红色逆转", function()
    local args = {
        [1] = "Infinity: Reversal Red"
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.Skill:FireServer(unpack(args))
end)

YU_SHEN:Button("自动腿击", function()
    local mobs = workspace.Objects.Mobs
    local kingOfCurses = mobs and mobs:FindFirstChild("King Of Curses")
    
    if kingOfCurses and kingOfCurses:FindFirstChild("Humanoid") then
        local args = {
            [1] = 1,
            [2] = {[1] = kingOfCurses.Humanoid},
            [3] = 16
        }
        game:GetService("ReplicatedStorage").Remotes.Server.Combat.M1:FireServer(unpack(args))
    end
end)

YU_SHEN:Button("无限:蓝色失效", function()
    local args = {
        [1] = "Infinity: Lapse Blue"
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.Skill:FireServer(unpack(args))
end)

YU_SHEN:Button("无限:空间打击", function()
    local args = {
        [1] = "Infinity: Spatial Pummel"
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.Skill:FireServer(unpack(args))
end)

YU_SHEN:Button("无限:穆根", function()
    local args = {
        [1] = "Infinity: Mugen"
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.Skill:FireServer(unpack(args))
end)

YU_SHEN:Button("无限:红色传说", function()
    local args = {
        [1] = "Infinity: Red Transmission"
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.Skill:FireServer(unpack(args))
end)

YU_SHEN:Button("无限:空间紫色", function()
    local args = {
        [1] = "Infinity: Hollow Purple"
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.Skill:FireServer(unpack(args))
end)

YU_SHEN:Button("空间:域扩展", function()
    local args = {
        [1] = "Domain Expansion: Unlimited Void"
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.Skill:FireServer(unpack(args))
end)

YU_SHEN:Button("无限:重拳", function()
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.M2:FireServer()
end)

YU_SHEN:Button("烛辰甘蓝", function()
    local args = {
        [1] = "CanDomain",
        [2] = true
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.ReplicateClientInfo:FireServer(unpack(args))
end)

YU_SHEN:Button("最大:六只眼睛", function()
    local args = {
        [1] = "Maximum: Six Eyes"
    }
    game:GetService("ReplicatedStorage").Remotes.Server.Combat.Skill:FireServer(unpack(args))
end)

YU_SHEN:Label("柔术遗产功能")

YU_SHEN:Button("点我远程接受任务", function()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    if playerGui:FindFirstChild("QuestGui") and playerGui.QuestGui.Frame:FindFirstChild("K") then
        playerGui.QuestGui.Frame.K:FireServer()
    end
end)

YU_SHEN:Button("自动开大", function()
    local args = {
        [1] = "Combat",
        [2] = "UseZ"
    }
    game:GetService("ReplicatedStorage").RemoteEvent.information:FireServer(unpack(args))
end)

YU_SHEN:Button("自动攻击", function()
    local localPlayer = game:GetService("Players").LocalPlayer
    local character = localPlayer.Character
    
    if character and character:FindFirstChild("Combat") then
        local combat = character.Combat
        if combat:FindFirstChild("RemoteEvent") then
            local args = {
                [1] = "Combat",
                [2] = "Combo"
            }
            combat.RemoteEvent:FireServer(unpack(args))
        end
    end
end)

YU_SHEN:Label("以上功能都有bug，希望轻喷")

YU_SHEN:Button("传送到接收任务的地方", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(-4046.29931640625, 1190.1025390625, -4340.392578125)
    end
end)

YU_SHEN:Label("柔术神器功能")

YU_SHEN:Button("无限快速冲刺", function()
    local knitServices = game:GetService("ReplicatedStorage").Knit.Knit.Services
    if knitServices.GojoService and knitServices.GojoService.RE and knitServices.GojoService.RE:FindFirstChild("Chase") then
        knitServices.GojoService.RE.Chase:FireServer()
    end
end)

YU_SHEN:Button("无限逆转红色", function()
    local knitServices = game:GetService("ReplicatedStorage").Knit.Knit.Services
    if knitServices.ReversalRedService and knitServices.ReversalRedService.RE and knitServices.ReversalRedService.RE:FindFirstChild("Activated") then
        local args = {[1] = false}
        knitServices.ReversalRedService.RE.Activated:FireServer(unpack(args))
    end
end)

YU_SHEN:Button("无限双倍踢球", function()
    local knitServices = game:GetService("ReplicatedStorage").Knit.Knit.Services
    if knitServices.TwofoldKickService and knitServices.TwofoldKickService.RE and knitServices.TwofoldKickService.RE:FindFirstChild("Activated") then
        local args = {[1] = false}
        knitServices.TwofoldKickService.RE.Activated:FireServer(unpack(args))
    end
end)

YU_SHEN:Button("无限自动攻击", function()
    local knitServices = game:GetService("ReplicatedStorage").Knit.Knit.Services
    if knitServices.GojoService and knitServices.GojoService.RE and knitServices.GojoService.RE:FindFirstChild("Activated") then
        local args = {[1] = false}
        knitServices.GojoService.RE.Activated:FireServer(unpack(args))
    end
end)

YU_SHEN:Button("自动防御", function()
    local knitServices = game:GetService("ReplicatedStorage").Knit.Knit.Services
    if knitServices.BlockService and knitServices.BlockService.RE and knitServices.BlockService.RE:FindFirstChild("Deactivated") then
        knitServices.BlockService.RE.Deactivated:FireServer()
    end
end)

YU_SHEN:Button("无限拉普斯蓝色", function()
    local knitServices = game:GetService("ReplicatedStorage").Knit.Knit.Services
    if knitServices.LapseBlueService and knitServices.LapseBlueService.RE and knitServices.LapseBlueService.RE:FindFirstChild("Activated") then
        knitServices.LapseBlueService.RE.Activated:FireServer()
    end
end)

local YU_Tab = YU:Tab("水下公司", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("自动拾取物品", "AutoPickup", false, function(state)
    autoPickupRunning = state
    if state and not autoPickupThread then
        autoPickupThread = coroutine.create(function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local startPosition = Vector3.new(-503.2907409667969, -43.40001678466797, -1464.4521484375)
            local dropPosition = Vector3.new(-503.2907409667969, -43.40001678466797, -1464.4521484375)  
            local distanceThreshold = 200
            
            while autoPickupRunning do
                local itemsFolder = workspace:FindFirstChild("Items")
                if itemsFolder then
                    for _, item in ipairs(itemsFolder:GetChildren()) do
                        if not autoPickupRunning then break end
                        
                        local primaryPart = item.PrimaryPart or item:FindFirstChild("PrimaryPart")
                        if primaryPart then
                            local position = primaryPart.Position
                            if (position - startPosition).magnitude > distanceThreshold then
                                humanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 1, 0))
                                task.wait(0.5)
                                
                                for _, prompt in ipairs(item:GetDescendants()) do
                                    if prompt:IsA("ProximityPrompt") then
                                        fireproximityprompt(prompt)
                                        break
                                    end
                                end
                                
                                task.wait(0.5)
                                humanoidRootPart.CFrame = CFrame.new(dropPosition)
                                task.wait(0.5)
                                
                                local replicatedStorage = game:GetService("ReplicatedStorage")
                                local dropRemote = replicatedStorage:FindFirstChild("Drop")
                                if dropRemote then
                                    dropRemote:FireServer()
                                end
                                
                                task.wait(0.5)
                            end
                        end
                    end
                end
                task.wait(1)
            end
            autoPickupThread = nil
        end)
        coroutine.resume(autoPickupThread)
    elseif not state and autoPickupThread then
        autoPickupRunning = false
        autoPickupThread = nil
    end
end)

local YU_Tab = YU:Tab("在超市生活一周", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("自动收集食物", "AutoCollectFood", false, function(state)
    while state do
        task.wait()
        local mapUtil = workspace.Map.Util
        if mapUtil and mapUtil:FindFirstChild("Items") then
            for _,v in next, mapUtil.Items:GetChildren() do
                if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("ItemType") and v.ToolStats.ItemType.Value == "Food" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集手电筒", "AutoCollectFlashlight", false, function(state)
    while state do
        task.wait()
        local mapUtil = workspace.Map.Util
        if mapUtil and mapUtil:FindFirstChild("Items") then
            for _,v in next, mapUtil.Items:GetChildren() do
                if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("ItemType") and v.ToolStats.ItemType.Value == "Flashlight" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集近战武器", "AutoCollectMelee", false, function(state)
    while state do
        task.wait()
        local mapUtil = workspace.Map.Util
        if mapUtil and mapUtil:FindFirstChild("Items") then
            for _,v in next, mapUtil.Items:GetChildren() do
                if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("ItemType") and v.ToolStats.ItemType.Value == "Melee" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集枪", "AutoCollectGun", false, function(state)
    while state do
        task.wait()
        local mapUtil = workspace.Map.Util
        if mapUtil and mapUtil:FindFirstChild("Items") then
            for _,v in next, mapUtil.Items:GetChildren() do
                if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("ItemType") and v.ToolStats.ItemType.Value == "Gun" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动收集药品", "AutoCollectHealth", false, function(state)
    while state do
        task.wait()
        local mapUtil = workspace.Map.Util
        if mapUtil and mapUtil:FindFirstChild("Items") then
            for _,v in next, mapUtil.Items:GetChildren() do
                if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("ItemType") and v.ToolStats.ItemType.Value == "Health" then
                    game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动装弹", "AutoReload", false, function(state)
    while state do
        task.wait()
        game:GetService("ReplicatedStorage").Remotes.Weapon.GunReloaded:FireServer()
    end
end)

YU_SHEN:Toggle("自动开枪", "AutoShoot", false, function(state)
    while state do
        task.wait()
        local localPlayer = game.Players.LocalPlayer
        local backpack = localPlayer.Backpack
        local character = localPlayer.Character
        
        if character and workspace:FindFirstChild("Enemies") then
            for _, v in next, backpack:GetChildren() do
                if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("Ammo") then
                    for _,e in next, workspace.Enemies:GetChildren() do
                        if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 and e:FindFirstChild("Head") then
                            local BulletsPerShot = v.ToolStats.BulletsPerShot.Value
                            local DirectionTbl = {}
                            
                            for i = 1, BulletsPerShot do
                                table.insert(DirectionTbl, Vector3.new(e.Head.Position.X, e.Head.Position.Y, e.Head.Position.Z).Unit)
                            end
                            
                            local args = {
                                [1] = {
                                    ["FiringPlayer"] = localPlayer,
                                    ["FiredTime"] = os.time(),
                                    ["FiringPlayerUserId"] = localPlayer.UserId,
                                    ["Origin"] = Vector3.new(character:GetPivot().Position),
                                    ["UID"] = localPlayer.UserId .. "_1",
                                    ["WeaponInstance"] = v,
                                    ["ThisBulletProperties"] = {
                                        ["BulletSpread"] = v.ToolStats.BulletSpread.Value,
                                        ["BulletsPerShot"] = v.ToolStats.BulletsPerShot.Value,
                                        ["BulletPenetration"] = v.ToolStats.BulletPenetration.Value,
                                        ["BulletSpeed"] = v.ToolStats.BulletSpeed.Value,
                                        ["FireSound"] = v.ToolStats.FireSound.Value,
                                        ["BulletSize"] = v.ToolStats.BulletSize.Value
                                    },
                                    ["DirectionTbl"] = DirectionTbl
                                }
                            }
                            game:GetService("ReplicatedStorage").Remotes.Weapon.GunFired:FireServer(unpack(args))
                        end
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("修改超级枪", "SuperGun", false, function(state)
    while state do
        task.wait()
        local localPlayer = game.Players.LocalPlayer
        local backpack = localPlayer.Backpack
        
        for _,v in next, backpack:GetChildren() do
            if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("Ammo") then
                v.ToolStats.ReloadTime.Value = 0
                v.ToolStats.FireDelay.Value = 0
                v.ToolStats.Ammo.Value = math.huge
                v.ToolStats.Damage.Value = math.huge
            end
        end
    end
end)

YU_SHEN:Toggle("无限体力和饥饿度", "InfiniteStats", false, function(state)
    while state do
        task.wait()
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        
        if character and character:FindFirstChild("CharacterData") then
            local characterData = character.CharacterData
            
            if characterData:FindFirstChild("MaxStamina") and characterData:FindFirstChild("MaxEnergy") then
                characterData.MaxStamina.Value = math.huge
                characterData.MaxEnergy.Value = math.huge
                
                if characterData:FindFirstChild("Energy") then
                    characterData.Energy.Value = characterData.MaxEnergy.Value
                end
                
                if characterData:FindFirstChild("Stamina") then
                    characterData.Stamina.Value = characterData.MaxStamina.Value
                end
            end
        end
    end
end)

YU_SHEN:Toggle("夜晚自动躲避", "NightAutoHide", false, function(state)
    while state do
        task.wait()
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        
        if character then
            local gameInfo = game:GetService("ReplicatedStorage").GameInfo
            if gameInfo and gameInfo:FindFirstChild("TimeOfDay") then
                if gameInfo.TimeOfDay.Value == "Night" then
                    local oldpos = character:GetPivot().Position
                    
                    repeat 
                        task.wait()
                        character:PivotTo(CFrame.new(306.18927001953125, 36.67450714111328, -519.2435913085938))
                        if character:FindFirstChild("HumanoidRootPart") then
                            character.HumanoidRootPart.Anchored = true
                        end
                    until gameInfo.TimeOfDay.Value ~= "Night"
                    
                    if character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = CFrame.new(oldpos)
                        character.HumanoidRootPart.Anchored = false
                    end
                end
            end
        end
    end
end)

local YU_Tab = YU:Tab("寻宝模拟器", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

local ToolName = ""
local PlayerTool = {}

local ToolDropdown = YU_SHEN:Dropdown("选择工具", "SelectTool", PlayerTool, function(Value)
    ToolName = Value
end)

YU_SHEN:Button("刷新工具名称", function()
    PlayerTool = {}
    local localPlayer = game.Players.LocalPlayer
    local backpack = localPlayer.Backpack
    
    for i, v in pairs(backpack:GetChildren()) do
        if v:IsA("Tool") then
            table.insert(PlayerTool, v.Name)
        end
    end
    ToolDropdown:SetOptions(PlayerTool)
end)

YU_SHEN:Toggle("自动农场", "AutoFarm", false, function(state)
    while state do
        task.wait()
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        
        if character then
            local tool = character:FindFirstChild(ToolName) or localPlayer.Backpack:FindFirstChild(ToolName)
            local humanoid = character:FindFirstChild("Humanoid")
            
            if not character:FindFirstChild(ToolName) and tool and humanoid then
                humanoid:EquipTool(tool)
            elseif not tool then
                warn("工具未找到: " .. ToolName)
                break
            end
            
            if workspace:FindFirstChild("SandBlocks") then
                local playerHead = character:FindFirstChild("Head")
                if playerHead then
                    for i, v in pairs(workspace.SandBlocks:GetChildren()) do
                        if v and v:IsA("BasePart") then
                            local distance = (playerHead.Position - v.Position).magnitude
                            if distance <= 30 and character:FindFirstChild("Bucket") then
                                local bucket = character.Bucket
                                if bucket:FindFirstChild("RemoteClick") then
                                    bucket.RemoteClick:FireServer(v)
                                    task.wait()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动传送至宝箱", "AutoTeleportChest", false, function(state)
    chest = state
    while chest do
        task.wait(3)
        local character = game.Players.LocalPlayer.Character
        
        if character and character:FindFirstChild("HumanoidRootPart") and workspace:FindFirstChild("SandBlocks") then
            for _, sandBlock in ipairs(workspace.SandBlocks:GetChildren()) do
                if sandBlock:FindFirstChild("Chest") then
                    local chestPosition = sandBlock.CFrame
                    character.HumanoidRootPart.CFrame = chestPosition
                    task.wait(0.5)
                    break
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动重生", "AutoRebirth", false, function(state)
    Rebirth = state
    spawn(function()
        while true do
            task.wait(1)
            if Rebirth then
                local localPlayer = game.Players.LocalPlayer
                local playerGui = localPlayer.PlayerGui
                
                if playerGui:FindFirstChild("Gui") then
                    local gui = playerGui.Gui
                    local coinsText = gui.Buttons.Coins.Amount.Text:gsub(',', '')
                    local neededText = gui.Rebirth.Needed.Coins.Amount.Text:gsub(',', '')
                    
                    local currentCoins = tonumber(coinsText)
                    local neededCoins = tonumber(neededText)
                    
                    if currentCoins and neededCoins and currentCoins > neededCoins then
                        game.ReplicatedStorage.Events.Rebirth:FireServer()
                        task.wait(0.1)
                        
                        if gui.Popups:FindFirstChild("GiveReward") then
                            gui.Popups.GiveReward.Visible = false
                        end
                    end
                end
            end
        end
    end)
end)

YU_SHEN:Toggle("自动购买收集工具", "AutoBuyTools", false, function(state)
    while state do
        task.wait()
        local localPlayer = game.Players.LocalPlayer
        local leaderstats = localPlayer:FindFirstChild("leaderstats")
        
        if leaderstats then
            local coinsStat = leaderstats:FindFirstChild("Coins")
            if coinsStat then
                local coins = coinsStat.Value
                
                if coins >= 0 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Bucket")
                end
                
                if coins >= 100 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Spade")
                end
                
                if coins >= 250 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Toy Shovel")
                end
                
                if coins >= 600 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Small Shovel")
                end
                
                if coins >= 2100 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Medium Shovel")
                end
                
                if coins >= 8800 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Large Shovel")
                end
                
                if coins >= 24000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Big Scooper")
                end
                
                if coins >= 65000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Vacuum")
                end
                
                if coins >= 250000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Giant Shovel")
                end
                
                if coins >= 500000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Metal Detector")
                end
                
                if coins >= 3000000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Jack Hammer")
                end
                
                if coins >= 10000000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Golden Spoon")
                end
            end
        end
    end
end)

YU_SHEN:Toggle("自动购买填充背包", "AutoBuyBags", false, function(state)
    while state do
        task.wait()
        local localPlayer = game.Players.LocalPlayer
        local leaderstats = localPlayer:FindFirstChild("leaderstats")
        
        if leaderstats then
            local coinsStat = leaderstats:FindFirstChild("Coins")
            if coinsStat then
                local coins = coinsStat.Value
                
                if coins >= 0 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Starterpack")
                end
                
                if coins >= 150 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Small Bag")
                end
                
                if coins >= 375 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Medium Bag")
                end
                
                if coins >= 900 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Large Bag")
                end
                
                if coins >= 3150 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("XL Bag")
                end
                
                if coins >= 13200 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("XXL Bag")
                end
                
                if coins >= 36000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("SuperStorage™")
                end
                
                if coins >= 75000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("SuperStorage™ 2")
                end
                
                if coins >= 150000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Sand Safe")
                end
                
                if coins >= 350000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Sand Vault")
                end
                
                if coins >= 700000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("SuperStorage™ 3")
                end
                
                if coins >= 1500000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Small Canister")
                end
                
                if coins >= 4000000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Medium Canister")
                end
                
                if coins >= 8000000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Large Canister")
                end
                
                if coins >= 9000000000 then
                    game:GetService("ReplicatedStorage").Events.Checkout:FireServer("Infinite")
                end
            end
        end
    end
end)

local CratesName = ""
local CratesDropdown = {}

local CratesDropdown = YU_SHEN:Dropdown("选择箱子", "SelectCrate", CratesDropdown, function(Value)
    CratesName = Value
end)

YU_SHEN:Toggle("自动购买", "AutoBuyCrate", false, function(state)
    while state do
        game:GetService("ReplicatedStorage").Events.BuyCrate:FireServer(CratesName, game.Players.LocalPlayer.Name, 1)
        task.wait()
    end
end)

local YU_Tab = YU:Tab("汽车破坏模拟器", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("自动刷钱", "AutoFarm", false, function(bool)
    if bool == true then
        AutofarmEnabled = true
        
        while AutofarmEnabled do
            task.wait(0.5)
            if canSpawn() then
                doBreak = true
                task.delay(10, function()
                    doBreak = false
                end)
                pcall(function()
                    spawnBestCar()
                    destroyCar()
                end)
            end
        end
    else
        AutofarmEnabled = false
    end
end)

YU_SHEN:Toggle("自动逃脱", "AutoEscape", false, function(state)
    heleicopterspawn = state
end)

YU_SHEN:Toggle("反挂机", "AntiAFK", false, function(bool)
    local localPlayer = game.Players.LocalPlayer
    
    if bool == true then
        for i,v in pairs(getconnections(localPlayer.Idled)) do
            v:Disable()
        end
    else
        for i,v in pairs(getconnections(localPlayer.Idled)) do
            v:Enable()
        end
    end
end)

YU_SHEN:Button("生成车辆", function()
    spawnBestCar()
end)

YU_SHEN:Button("摧毁车辆", function()
    doBreak = true
    task.delay(10, function() 
        doBreak = false 
    end)
    pcall(function()
        destroyCar()
    end)
end)

workspace.ChildAdded:Connect(function(newpart)
    task.wait(1)
    if newpart.Name == "Helicopter" then
        task.wait(0.5)
        if heleicopterspawn then
            local localPlayer = game.Players.LocalPlayer
            local character = localPlayer.Character
            
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                
                if humanoid and humanoidRootPart then
                    humanoid:ChangeState("GettingUp")
                    task.wait(0.1)
                    humanoid:ChangeState("Jumping")
                    task.wait(0.5)
                    
                    if workspace:FindFirstChild("Helicopter") and workspace.Helicopter:FindFirstChild("Start") then
                        humanoidRootPart.CFrame = workspace.Helicopter.Start.CFrame
                    end
                end
            end
        end
    end
end)

local YU_Tab = YU:Tab("河北唐县", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Toggle("卡车刷钱", "TruckMoney", false, function(state)
    if state then
        getfenv().auto = true
        while getfenv().auto do
            wait(0.3)
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                if not character then return end
                local humanoid = character:FindFirstChild("Humanoid")
                if not humanoid then return end
                local inVehicle = humanoid.SeatPart ~= nil

                if player.PlayerGui.PackagesUI:FindFirstChildOfClass("BillboarYUui") then
                    local seatPart = humanoid.SeatPart
                    if seatPart then
                        local vehicle = seatPart.Parent
                        vehicle.PrimaryPart = vehicle.Body["#Weight"]
                        vehicle:PivotTo(player.PlayerGui.PackagesUI:FindFirstChildOfClass("BillboarYUui").Adornee.CFrame * CFrame.new(0, 10, -20))
                        wait(0.18)
                        local interactionUI = player.PlayerGui.TruckingJobUI.interaction
                        if interactionUI.Visible then
                            local title = interactionUI.title.Text
                            if string.find(title, "Load") and not string.find(title, "Unload") then
                                game:GetService("ReplicatedStorage").Packages.Shared.Network.RemoteFunctions.ClientCoalRequester:InvokeServer("LoadCoal")
                            elseif string.find(title, "Unload") then
                                game:GetService("ReplicatedStorage").Packages.Shared.Network.RemoteFunctions.ClientCoalRequester:InvokeServer("UnloadCoal")
                            end
                        end
                    end
                elseif not inVehicle or tick() % 1 < 0.3 then
                    game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Civilian")
                    wait(0.39)
                    game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Trucker")
                    game:GetService("ReplicatedStorage").Packages.Shared.Network.RemoteFunctions.ClientRequestCoalTrucks:InvokeServer()
                    wait(0.18)
                    game:GetService("ReplicatedStorage").Packages.Shared.Network.RemoteFunctions.ClientRequestCoalJob:InvokeServer(workspace.TruckingJob.Coal.routeA, "2012 Shacman M3000 4X2")
                    wait(0.18)
                    local vehicleName = player.Name .. "'s Car"
                    local spawnedCars = workspace:FindFirstChild("SpawnedCars")
                    local vehicle = spawnedCars and spawnedCars:FindFirstChild(vehicleName)
                    if vehicle then
                        local seatTypes = {"DriveSeat", "DriverSeat", "Seat"}
                        local seat = nil
                        for _, seatType in ipairs(seatTypes) do
                            seat = vehicle:FindFirstChild(seatType)
                            if seat then break end
                        end
                        if seat then
                            local root = character:FindFirstChild("HumanoidRootPart")
                            if root then
                                root.CFrame = seat.CFrame + Vector3.new(0, 0.5, 0)
                                wait(0.1)
                                seat:Sit(humanoid)
                            end
                        end
                    end
                end
            end)
        end
    else
        getfenv().auto = false
    end
end)

YU_SHEN:Toggle("卖冰淇淋刷钱", "IceCreamMoney", false, function(state)
    _G.TD = state
    if state then
        game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Civilian")
        wait(0.1)
        game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Mixue Ice Cream")
        wait(0.1)
        game:GetService("Workspace").MixueJob.Scripted.Prompts.PromptFill.ProximityPrompt.MaxActivationDistance = 99999
        game:GetService("Workspace").MixueJob.Scripted.Prompts.Prompt.ProximityPrompt.MaxActivationDistance = 99999
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6970.93212890625, 11.840015411376953, 1757.1531982421875)
        wait(1)
        while _G.TD do
            for _, prompt in pairs(workspace.MixueJob:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    fireproximityprompt(prompt)
                end
            end
            for i = 1, 6 do
                local customer = game:GetService("Workspace"):FindFirstChild("Customer" .. i)
                if customer then
                    for _, prompt in pairs(customer:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
            task.wait(0.25)
        end
    else
        _G.TD = false
    end
end)

YU_SHEN:Toggle("卖茶刷钱", "TeaMoney", false, function(state)
    _G.TD = state
    if state then
        game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Civilian")
        wait(0.1)
        game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Teawen Barista")
        wait(0.1)
        game:GetService("Workspace").BaristaJob.Scripted.Prompts.PromptFill.ProximityPrompt.MaxActivationDistance = 9999
        game:GetService("Workspace").BaristaJob.Scripted.Prompts.Prompt.ProximityPrompt.MaxActivationDistance = 9999
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5855.5146484375, 12.23734188079834, 3666.1201171875)
        wait(1)
        while _G.TD do
            for _, prompt in pairs(workspace.BaristaJob:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    fireproximityprompt(prompt)
                end
            end
            for i = 1, 6 do
                local customer = game:GetService("Workspace"):FindFirstChild("Customer" .. i)
                if customer then
                    for _, prompt in pairs(customer:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
            task.wait(0.25)
        end
    else
        _G.TD = false
    end
end)

YU_SHEN:Toggle("送货员赚钱（踢出风险降低）", "DeliveryMoney", false, function(state)
    local player = game:GetService("Players").LocalPlayer
    local runService = game:GetService("RunService")
    _G.autoFarm = state

    local function noCollide(enabled)
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not enabled
                end
            end
        end
    end

    local function deliverPackage(targetCFrame)
        noCollide(true)
        local root = player.Character.HumanoidRootPart
        local bodyPosition = Instance.new("BodyPosition")
        bodyPosition.Position = targetCFrame.Position
        bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyPosition.Parent = root
        
        local delivered = false
        local connection = runService.Heartbeat:Connect(function()
            if (root.Position - targetCFrame.Position).Magnitude < 3 then
                delivered = true
                connection:Disconnect()
            end
        end)
        
        task.wait(8)
        bodyPosition:Destroy()
        noCollide(false)
        return delivered
    end

    local function autoFarmLoop()
        while _G.autoFarm do
            fireclickdetector(game.Workspace.DeliverySys.Misc["Package Pile"].ClickDetector)
            local startTime = os.clock()
            while os.clock() - startTime < 10 do
                if not _G.autoFarm then break end
                task.wait(0.5)
            end
            for _, deliveryPoint in pairs(game.Workspace.DeliverySys.DeliveryPoints:GetChildren()) do
                if deliveryPoint:IsA("BasePart") and math.abs(deliveryPoint.Transparency - 0.8) < 0.001 then
                    deliverPackage(deliveryPoint.CFrame)
                    task.wait(1)
                end
            end
        end
    end

    if state then
        game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Delivery Driver")
        task.wait(1)
        autoFarmLoop()
    elseif player.Character then
        noCollide(false)
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _, child in ipairs(root:GetChildren()) do
                if child:IsA("BodyPosition") then
                    child:Destroy()
                end
            end
        end
    end
end)

YU_SHEN:Toggle("穿墙", "NoClip", false, function(state)
    local Clipon = state
    local Stepped
    
    Stepped = game:GetService("RunService").Stepped:Connect(function()
        if Clipon then
            for _, model in pairs(workspace:GetChildren()) do
                if model.Name == game.Players.LocalPlayer.Name then
                    for _, part in pairs(model:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        else
            Stepped:Disconnect()
        end
    end)
end)

YU_SHEN:Toggle("出租车刷钱", "TaxiMoney", false, function(state)
    _G.TD = state
    if state then
        game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Civilian")
        wait(0.1)
        game:GetService("ReplicatedStorage").Feature_RemoteEvent.TeamSwitch:FireServer("Taxi Driver")
        wait(0.1)
        
        local function createMarker(position, color)
            local marker = Instance.new("Part")
            marker.Size = Vector3.new(3, 3, 3)
            marker.Shape = Enum.PartType.Ball
            marker.Material = Enum.Material.Neon
            marker.Color = color
            marker.Anchored = true
            marker.CanCollide = false
            marker.Position = position
            marker.Parent = workspace
            game:GetService("Debris"):AddItem(marker, 5)
            return marker
        end

        local function teleportVehicle(targetCFrame)
            local player = game.Players.LocalPlayer
            if not player then return false end
            local character = player.Character
            if not character then return false end
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return false end
            local seatPart = humanoid.SeatPart
            if not seatPart then
                createMarker(character.HumanoidRootPart.Position, Color3.new(1, 0, 0))
                return false
            end
            local vehicle = seatPart:FindFirstAncestorOfClass("Model")
            if not vehicle then return false end
            local vehicleRoot = vehicle.PrimaryPart or vehicle:FindFirstChild("HumanoidRootPart") or vehicle:FindFirstChildWhichIsA("BasePart")
            local charRoot = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart")
            if not vehicleRoot or not charRoot then return false end
            
            local yaw = 0
            pcall(function()
                yaw = select(2, targetCFrame:ToEulerAnglesXYZ())
            end)
            
            local targetCFrameWithOffset = CFrame.new(targetCFrame.X, targetCFrame.Y + 5, targetCFrame.Z) * CFrame.Angles(0, yaw, 0)
            createMarker(targetCFrameWithOffset.Position, Color3.new(0, 1, 0))
            createMarker(targetCFrame.Position, Color3.new(1, 1, 0))
            
            local offset = vehicleRoot.Position - charRoot.Position
            for _, part in ipairs(vehicle:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
            vehicle:PivotTo(targetCFrameWithOffset)
            charRoot.CFrame = targetCFrameWithOffset + offset
            task.delay(0.5, function()
                for _, part in ipairs(vehicle:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Anchored = false
                    end
                end
            end)
            return true
        end

        while _G.TD do
            local taxiSys = workspace:FindFirstChild("TaxiSys")
            if taxiSys then
                local pickupPoints = taxiSys:FindFirstChild("PickupPoints")
                if pickupPoints then
                    for _, point in ipairs(pickupPoints:GetChildren()) do
                        if point:IsA("BasePart") and math.abs(point.Transparency - 0.8) < 0.01 then
                            if teleportVehicle(point.CFrame) then
                                task.wait(4)
                            else
                                task.wait(1)
                            end
                        end
                    end
                end
                local dropOffPoints = taxiSys:FindFirstChild("DropOffPoints")
                if dropOffPoints then
                    for _, point in ipairs(dropOffPoints:GetChildren()) do
                        if point:IsA("BasePart") and math.abs(point.Transparency - 0.8) < 0.01 then
                            if teleportVehicle(point.CFrame) then
                                task.wait(6)
                            else
                                task.wait(1)
                            end
                        end
                    end
                end
            end
            task.wait()
        end
    else
        _G.TD = false
    end
end)

YU_SHEN:Label("变身功能")

YU_SHEN:Button("变成警察(需要先购买警察通行证)", function()
    local args = {[1] = "Police"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成平民", function()
    local args = {[1] = "Civilian"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成混合冰淇淋", function()
    local args = {[1] = "Mixue Ice Cream"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成咖啡师", function()
    local args = {[1] = "Teawen Barista"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成送货司机", function()
    local args = {[1] = "Delivery Driver"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成出租车司机", function()
    local args = {[1] = "Taxi Driver"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成线上计程车", function()
    local args = {[1] = "Ole Online Taxi Sharing"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成卡车司机", function()
    local args = {[1] = "Trucker"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成超市收银员", function()
    local args = {[1] = "Grocery Cashier"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成罪犯", function()
    local args = {[1] = "Criminal"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成学生", function()
    local args = {[1] = "Student"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成老师", function()
    local args = {[1] = "Teacher"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成商店员工", function()
    local args = {[1] = "Store Worker"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成变pao商店工人", function()
    local args = {[1] = "Pao Store Worker"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成救援人员", function()
    local args = {[1] = "Paramedic"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Button("变成巴车司机", function()
    local args = {[1] = "Bus Driver"}
    game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
end)

YU_SHEN:Label("传送")

YU_SHEN:Button("警察局", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5513.97412109375, 8.656171798706055, 4964.291015625)
end)

YU_SHEN:Button("出生点", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3338.31982421875, 10.048742294311523, 3741.84033203125)
end)

YU_SHEN:Button("医院", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5471.482421875, 14.149418830871582, 4259.75341796875)
end)

YU_SHEN:Button("手机店", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6789.2041015625, 11.197686195373535, 1762.687255859375)
end)

YU_SHEN:Button("火锅店", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5912.84765625, 12.217276573181152, 1058.29443359375)
end)

YU_SHEN:Button("蜜雪冰城",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6984.87158203125, 9.332854270935059, 1734.770751953125)
end)

YU_SHEN:Button("小区",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2187.541259765625, 22.092992782592773, -636.7048950195312)
end)

YU_SHEN:Button("洗车店",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2578.51025390625, 23.332923889160156, -588.5584716796875)
end)

YU_SHEN:Button("卡车召唤地",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10559.13671875, 39.31748580932617, 3236.519287109375)
end)

YU_SHEN:Button("庆都山山顶",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15042.9033203125, 325.29852294921875, 22355.177734375)
end)

YU_SHEN:Button("庆都山山底",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15580.1357421875, 8.09992790222168, 21171.939453125)
end)

YU_SHEN:Button("小学",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13888.138671875, 10.943490982055664, 11059.0458984375)
end)

YU_SHEN:Button("签挂美食",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10332.763671875, 10.43997859954834, 7114.16064453125)
end)

YU_SHEN:Button("驾校",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8912.12109375, 9.963741302490234, 7302.568359375)
end)

local YU_Tab = YU:Tab("各大脚本", "128586210657724")
local YU_SHEN = YU_Tab:section("内容",true)

YU_SHEN:Button("皮脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

YU_SHEN:Button("BS黑洞中心脚本", function()
    loadstring(game:HttpGet("https://api.junkie-development.de/api/v1/luascripts/public/d6dffe74a774f7983c29a61dbfaef705a7c1bbd193c1bb68d778cb4bb4c302ae/download"))()
end)

YU_SHEN:Button("叶脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/main/ROBLOX-CNVIP-XIAOYE.lua"))()
end)

YU_SHEN:Button("混脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Twbtx/tiamxiabuwu/main/txbw666"))()
end)

YU_SHEN:Button("DOLL脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/lool8/-/main/DOLL.lua"))()
end)

YU_SHEN:Button("驰脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/驰脚本.txt"))()
end)

YU_SHEN:Button("殺脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/FengYu/Feng/QQ1926190957"))()
end)

YU_SHEN:Button("XA脚本", function()
    loadstring(game:HttpGet("https://raw.gitcode.com/Xingtaiduan/Scripts/raw/main/Loader.lua"))()
end)

YU_SHEN:Button("天空脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjYUrhj/script-hub/main/skyhub"))()
end)

YU_SHEN:Button("秋脚本", function()
    _G[".秋·自制脚本 遗存抢救"]="2024dncxddtsnchzxtb0112"
    loadstring(game:HttpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,87,83,98,117,113,47,45,47,109,97,105,110,47,37,69,55,37,65,55,37,56,66,37,67,50,37,66,55,37,69,56,37,56,55,37,65,65,37,69,53,37,56,56,37,66,54,37,69,56,37,56,52,37,57,65,37,69,54,37,57,67,37,65,67})end)())))()
end)

YU_SHEN:Button("FIN脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/finendss/FIN/main/FIN-Loading"))()
end)

YU_SHEN:Button("安脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wucan114514/gegeyxjb/main/安脚本.lua"))()
end)

YU_SHEN:Button("逆光脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/lool8/-/main/逆光.lua"))()
end)

YU_SHEN:Button("DE HUB脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/DE/main/DE%20HUB.lua"))()
end)

YU_SHEN:Button("KG脚本", function()
    loadstring(game:HttpGet("https://github.com/ZS-NB/KG/raw/main/Zhang-Shuo.lua"))()
end)

YU_SHEN:Button("本熊脚本", function()
    loadstring(game:HttpGet("https://pastefy.app/s9PijnvT/raw"))()
end)

YU_SHEN:Button("APEX HUB脚本", function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/b2004278b4735e1ca615931116373d48.lua"))()
end)

YU_SHEN:Button("走马观花脚本", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/XPTiVKWx"))()
end)

YU_SHEN:Button("导管脚本中心", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/useranewrff/roblox-/main/条例名称可能不同"))()
end)

YU_SHEN:Button("黄脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CNHM/Chinese/main/移动自动换缅"))()
end)

YU_SHEN:Button("大司马脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheer/dasimav6/main/dasimaV6.txt"))()
end)

YU_SHEN:Button("南宁脚本", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/6XCWRWnL"))()
end)

YU_SHEN:Button("禁漫中心脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/ng/main/jmlllllllIIIIlllllII.lua"))()
end)

YU_SHEN:Button("Rb脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/main/Rb-Hub"))()
end)

YU_SHEN:Button("沙脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/114514lzkill/ShaHUB/refs/heads/main/ShaHUB"))()
end)

YU_SHEN:Button("TX脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/TX-Free-YYDS/main/FREE-TX-TEAM"))()
end)

YU_SHEN:Button("FXM脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/HB-ksdb/-HB-FXM/main/HB%20FXM%20加载器.lua"))()
end)

YU_SHEN:Button("Frost脚本", function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/1139e311eaabc1aced70509c7caf1982.lua"))()
end)

YU_SHEN:Button("挽脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XxwanhexxX/UN/main/lua"))()
end)

YU_SHEN:Button("W超级脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wbw1470619303-ctrl/w-/main/udjejdj"))()
end)

YU_SHEN:Button("UnicoX脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoXuCynic/UnicoX-Script/main/UnicoXV1-混淆.lua"))()
end)

YU_SHEN:Button("无脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoXuCynic/Free-Script/main/无脚本V1混淆.lua.txt"))()
end)

YU_SHEN:Button("空云脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoSB33/M416/main/Wind%2Fsb%2F空云脚本V2.LUA"))()
end)

YU_SHEN:Button("X脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/maowang1/xx/main/Protected_8858329470146381.txt"))()
end)

YU_SHEN:Button("名脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wuming124578/wuming/main/名脚本源💩码.lua"))()
end)

YU_SHEN:Button("WTB脚本", function()
    getgenv().ADittoKey = WTB_FREEKEY
    pcall(function()    
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Potato5466794/GC-WTB/refs/heads/main/Loader/Loader.luau", true))()
    end)
end)

YU_SHEN:Button("WU SCRIPT", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/WUSCRIPT/WU-Script/main/WUSCRIPT.lua"))()
end)

YU_SHEN:Button("ZAY脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ZAYHUB-DEV/ZAYHUB/main/ZAYHUB"))()
end)

YU_SHEN:Button("Yezx脚本", function()
    loadstring(game:HttpGet("https://raw.github.com/wszzx2013/yezx/main/Main%20script/Loader"))()
end)

YU_SHEN:Button("WX HUB脚本", function()
    loadstring(game:HttpGet("https://pastefy.app/o6W0mEy9/raw"))()
end)

YU_SHEN:Button("Love-Lingdu脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/114514lxhlzh-lgtm/Love-Lingdu/main/Love%20Lingdu%20hunxiao"))()
end)

YU_SHEN:Button("XION脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/smalldesikon/wocaonima/main/qq984820669.txt"))()
end)

YU_SHEN:Button("SX HUB脚本", function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/87a8a4f4c2d2ef535ccd1bdb949218fe.lua"))()
end)

YU_SHEN:Button("T脚本", function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/qwrt5589/d370955bedc8d3822f8bd1203443f045/raw"))()
end)

YU_SHEN:Button("XC脚本", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/gemxHwA1"))()
end)

YU_SHEN:Button("光脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/9f45c52b3506e14329c44584d118a546835482a0/光脚本.txt"))()
end)

YU_SHEN:Button("BP脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oisaaa6/BLUE/main/PAINT"))()
end)

YU_SHEN:Button("黑白脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tfcygvunbind/Apple/main/黑白脚本加载器"))()
end)

YU_SHEN:Button("德与中山免费版", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dream77239/Deyu-Zhongshan/main/德与中山.txt"))()
end)

YU_SHEN:Button("spain脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/5twh2hsf9j-byte/spain/main/spain"))()
end)

YU_SHEN:Button("旧冬脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/QiuShan-UX/UnicoX/main/旧冬Script--Forsaken.lua.txt"))()
end)

YU_SHEN:Button("ZARA脚本", function()
    loadstring(game:HttpGet("https://pastefy.app/zCQhGR8d/raw"))()
end)

YU_SHEN:Button("XK脚本", function()
    loadstring(game:HttpGet("https://github.com/devslopo/DVES/raw/main/XK%20Hub"))()
end)

YU_SHEN:Button("寒脚本", function()
    loadstring(game:HttpGet("https://github.com/135246508623/Han-NB/raw/main/1.lua.txt"))()
end)

YU_SHEN:Button("神秘脚本", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/Up3P2KBp"))()
end)

YU_SHEN:Button("芋风脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/0lihaorui0/dvdvhd/main/芋风脚本%20测试版(1).lua"))()
end)

YU_SHEN:Button("蛊脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sdxs221/-/main/我后悔了"))()
end)

YU_SHEN:Button("kenny脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Essai/a363e402cfc9408efd3fe4a1386ed27456b69910/kenny%F0%9F%98%AD"))()
end)

YU_SHEN:Button("迪脚本2.0", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ddjlb7598/-8.0/refs/heads/main/%E5%8D%A1%E5%AF%86%E7%B3%BB%E7%BB%9F7.lua"))()
end)

YU_SHEN:Button("迪脚本1.0", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ddjlb7598/-2.0/refs/heads/main/%E8%BF%AA%E8%84%9A%E6%9C%AC2.0.lua"))()
end)

YU_SHEN:Button("黎明中心", function()
    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\113\119\114\116\53\53\56\57\47\101\111\100\111\100\111\47\57\99\50\101\100\55\99\98\99\97\51\53\50\99\50\49\97\48\98\54\55\102\52\100\55\57\53\53\56\98\100\53\54\50\57\57\102\50\53\50\47\51\52\53\54\55\56\57\49\48\46\116\120\116\34\41\41\40\41")()
end)

YU_SHEN:Button("霖溺脚本", function()
    LnScript = "霖溺-免费版加载器"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ShenJiaoBen/ScriptLoader/refs/heads/main/Linni_FreeLoader.lua"))()
end)

YU_SHEN:Button("蓝标脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/THDZEP/Blue-blue-blue/refs/heads/main/%E5%8F%91%E7%A5%A8%E8%93%9D%E6%A0%87"))()
end)

YU_SHEN:Button("冷脚本", function()
    loadstring(game:HttpGet(" https://raw.githubusercontent.com/odhdshhe/lenglenglenglenglenglenlenglenglenglenglenglenglengleng-LBT-H-cold-script/refs/heads/main/LENG%20LBT-H%20cold%20script.txt"))()
end)

YU_SHEN:Button("乌云脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Essai/a363e402cfc9408efd3fe4a1386ed27456b69910/%E4%B9%8C%E4%BA%91%E8%84%9A%E6%9C%AC"))()
end)

YU_SHEN:Button("鲨新ui脚本", function()
    loadstring(game:HttpGet(" https://raw.githubusercontent.com/fvvhhh/sturdy-octo-engine/main/Protected_1221338743706560.lua.txt"))()
end)

YU_SHEN:Button("初脚本", function()
    loadstring(game:HttpGet(" https://raw.githubusercontent.com/odhdshhe/nianchuchuchuchuchu/refs/heads/main/Protected_2427816874224132.txt"))()
end)

YU_SHEN:Button("小达脚本", function()
    loadstring(game:HttpGet(" https://raw.githubusercontent.com/133ufudhdu/HLDHQVQRPB/main/QWQ"))()
end)

YU_SHEN:Button("云脚本", function()
    loadstring(game:HttpGet("https://github.com/IlIlIlIlIlIlIlIlIlIlIlIlIlIlIlIl/Mian/raw/main/云脚本.luau", true))()
end)

YU_SHEN:Button("Chinese脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fiyutfd/Chinese.-/main/po"))()
end)

YU_SHEN:Button("xhk缝合脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/jsjnsj/MyScripts/main/xhk%E7%BC%9D%E5%90%88%E8%84%9A%E6%9C%AC"))()
end)

