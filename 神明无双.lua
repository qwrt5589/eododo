local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/1bd282e6775310ac34d3446566640715c8cee181/%E6%97%A0%E6%95%8C%E7%9A%84%E5%AE%98%E6%96%B9.lua"))()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Revenant", true))()
Library.DefaultColor = Color3.fromRGB(255,105,180)

Library:Notification({
    Text = "光脚本作者：小光",
    Duration = 5, 
    Image = "rbxassetid://130010938932104"
})

wait(2)

Library:Notification({
    Text = "欢迎使用光脚本", 
    Duration = 3, 
    Image = "rbxassetid://130010938932104"
})

local window = library:new("光脚本V2")
local creds = window:Tab("信息",'6035145364')
local bin = creds:section("信息",true)

bin:Toggle("开/关光脚本用户名称显示", "Toggle", false, function(enabled)
  
  if enabled then
    XM = true
    while XM do
      local screenGui = Instance.new("ScreenGui", game.CoreGui)
      local textLabel = Instance.new("TextLabel", screenGui)
      local gradient = Instance.new("UIGradient")
      screenGui.Name = "UserGui"
      screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      screenGui.Enabled = true
      textLabel.Name = "UserLabel"
      textLabel.BackgroundColor3 = Color3.new(1, 1, 1)
      textLabel.BackgroundTransparency = 1
      textLabel.BorderColor3 = Color3.new(0, 0, 0)
      textLabel.Position = UDim2.new(0.8, 0.8, 0.0009, 0)
      textLabel.Size = UDim2.new(0, 135, 0, 50)
      textLabel.Font = Enum.Font.GothamSemibold
      textLabel.Text = "尊贵的光脚本V2用户: " .. game.Players.LocalPlayer.DisplayName
      textLabel.TextColor3 = Color3.new(1, 1, 1)
      textLabel.TextScaled = true
      textLabel.TextSize = 14
      textLabel.TextWrapped = true
      textLabel.Visible = true
      gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.1, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
      })
      gradient.Rotation = 10
      gradient.Parent = textLabel
      game:GetService("TweenService"):Create(gradient, TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {
        Rotation = 360,
      }):Play()
      wait(0.1)
    end
  else
    XM = false
  end
end)

bin:Label("你的注入器:"..identifyexecutor())
bin:Label("光脚本")
bin:Label("作者：小光")
bin:Label("QQ群1028199013")
bin:Label("QQ1693323219")
bin:Label("该脚本为免费缝合脚本")
bin:Label("缝合了一些皮脚本功能")
bin:Label("傻逼空云脚本还整个白名单")
bin:Label("花有重开日，人无再少年")
bin:Label("时间是个庸医")
bin:Label("用户名: "..game.Players.LocalPlayer.Name)

bin:Label("用户ID: "..game.Players.LocalPlayer.UserId)

local accountAge = game.Players.LocalPlayer.AccountAge
local years = math.floor(accountAge / 365)
local months = math.floor((accountAge % 365) / 30)
local days = accountAge % 30
bin:Label("注册天数: "..accountAge.."天 ("..years.."年"..months.."月"..days.."天)")

local visitedServers = #game:GetService("Players"):GetPlayers()
bin:Label("当前服务器玩家数: "..visitedServers)

bin:Button("复制作者QQ", function()
    if setclipboard then
        setclipboard("1693323219")
    end
end)

bin:Button("复制QQ群", function()
    if setclipboard then
        setclipboard("1028199013")
    end
end)

local creds = window:Tab("日期",'6035145364')
local bin = creds:section("日期",true)

local function getDayCountdown(targetMonth, targetDay)
    local now = os.date("*t")
    local currentYear = now.year
    local targetDate = os.time({year = currentYear, month = targetMonth, day = targetDay, hour = 0, min = 0, sec = 0})
    local currentTime = os.time(now)
    
    if targetDate < currentTime then
        targetDate = os.time({year = currentYear + 1, month = targetMonth, day = targetDay, hour = 0, min = 0, sec = 0})
    end
    
    local diffSeconds = targetDate - currentTime
    local daysLeft = math.ceil(diffSeconds / 86400) 
    return daysLeft
end

bin:Label("=== 『节日倒计时』（剩余天数） ===")
bin:Label("离元旦还有: "..getDayCountdown(1, 1).."天")
bin:Label("离春节还有: "..getDayCountdown(2, 10).."天") 
bin:Label("离情人节还有: "..getDayCountdown(2, 14).."天")
bin:Label("离清明节还有: "..getDayCountdown(4, 4).."天")
bin:Label("离劳动节还有: "..getDayCountdown(5, 1).."天")
bin:Label("离端午节还有: "..getDayCountdown(5, 31).."天") 
bin:Label("离中秋节还有: "..getDayCountdown(9, 17).."天") 
bin:Label("离国庆节还有: "..getDayCountdown(10, 1).."天")
bin:Label("离圣诞节还有: "..getDayCountdown(12, 25).."天")

local creds = window:Tab("通用",'6035145364')

local tool = creds:section("通用",true)

tool:Button("祝福语",function()
    local message = "这边小光祝您：生活愉快，笑口常开 事业顺利，步步高升 游戏开心，把把胜利 财源滚滚，好运相伴 身体健康，幸福美满 梦想成真，万事如意"
    
    
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
        if sayMessage then
            sayMessage:FireServer(message, "All")
        end
    end
    
   
    local TextChatService = game:GetService("TextChatService")
    if TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel:SendAsync(message)
            end
        end
    end
    
    print("已发送消息: " .. message)
end)

local tool = creds:section("本地玩家",true)

tool:Slider("步行速度!", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 16, 400, false, function(Speed)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed end end)
end)

tool:Slider("跳跃高度!", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(Jump)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump end end)
end)

tool:Slider("跳跃高度!", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(Jump)
    spawn(function() 
        while task.wait() do 
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump 
        end 
    end)
end)

tool:Slider('设置重力', 'Sliderflag', 196.2, 196.2, 1000, false, function(Value)
    game.Workspace.Gravity = Value
end)

tool:Slider('血量上限', 'Sliderflag',  120, 120, 999999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = Value
end)

tool:Slider('玩家血量', 'Sliderflag',  120, 120, 999999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.Health = Value
end)

tool:Slider("广角", 'Sliderflag', 70, 0.1, 250, false, function(v)
    game.Workspace.CurrentCamera.FieldOfView = v
end)

tool:Slider("视角缩放距离", "CameraZoom", 100, 0.5, 1000000, false, function(Distance)
    local player = game.Players.LocalPlayer
    if player then
        player.CameraMaxZoomDistance = Distance
        player.CameraMinZoomDistance = 0.5
    end
end)

tool:Toggle("夜视","Toggle",false,function(Value)
if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end
end)

Speed = 1
tool:Textbox("设置快速跑步", "run", "输入", function(speedValue)
  spawn(function() while task.wait() do
    Speed = speedValue
  end end)
end)

tool:Toggle("开启快速跑步(开/关)", "switch", false, function(enabled)
    local sudu = nil
    local running = false
    
    spawn(function()
        while task.wait() do
            if enabled and not running then
                running = true
                sudu = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
                    local character = game:GetService("Players").LocalPlayer.Character
                    if character and character:FindFirstChild("Humanoid") then
                        local humanoid = character.Humanoid
                        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
                            -- 使用deltaTime来确保平滑移动
                            character:TranslateBy(humanoid.MoveDirection * Speed * deltaTime * 60)
                        end
                    end
                end)
            elseif not enabled and running then
                running = false
                if sudu then
                    sudu:Disconnect()
                    sudu = nil
                end
            end
        end
    end)
end)

tool:Toggle("无限跳","Toggle",false,function(Value)
        Jump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if Jump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end)
    
tool:Toggle("自动面向敌人","Toggle",false,function(Value)
    if Value then
        _G.AutoFaceEnemy = true
        
        local localPlayer = game:GetService("Players").LocalPlayer
        
        local function isEnemy(player)
            if not localPlayer.Team then
                return true
            end
            
            if not player.Team then
                return true
            end
            
            return localPlayer.Team ~= player.Team
        end
        
        _G.FaceEnemyConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not _G.AutoFaceEnemy or not localPlayer.Character then
                return
            end
            
            local character = localPlayer.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if not humanoidRootPart then
                return
            end
            
            local closestEnemy = nil
            local closestDistance = math.huge
            
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= localPlayer and player.Character and isEnemy(player) then
                    local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    if enemyRoot then
                        local distance = (enemyRoot.Position - humanoidRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestEnemy = player
                        end
                    end
                end
            end
            
            if closestEnemy and closestEnemy.Character then
                local enemyRoot = closestEnemy.Character:FindFirstChild("HumanoidRootPart")
                if enemyRoot then
                
                    local direction = (enemyRoot.Position - humanoidRootPart.Position).Unit
                    humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + Vector3.new(direction.X, 0, direction.Z))
                end
            end
        end)
        
    else

        _G.AutoFaceEnemy = false
        if _G.FaceEnemyConnection then
            _G.FaceEnemyConnection:Disconnect()
            _G.FaceEnemyConnection = nil
        end
    end
end)

tool:Toggle("穿墙", "NoClip", false, function(NC)
  local Workspace = game:GetService("Workspace") local Players = game:GetService("Players") if NC then Clipon = true else Clipon = false end Stepped = game:GetService("RunService").Stepped:Connect(function() if not Clipon == false then for a, b in pairs(Workspace:GetChildren()) do if b.Name == Players.LocalPlayer.Name then for i, v in pairs(Workspace[Players.LocalPlayer.Name]:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end end else Stepped:Disconnect() end end)
end)

local tool = creds:section("通用",true)

tool:Button("聊天绕过",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/BingusWR/Fechatbypassroblox/refs/heads/main/Fe%20Roblox%20ChatBypass"))()
end)

tool:Button("铁拳",function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)

tool:Toggle("通用防摔伤", "Toggle", false, function(Value)
end)

tool:Toggle("悬空锁高度", "Toggle", false, function(Value)
end)

tool:Button("第一人称", function()
    game.Players.LocalPlayer.CameraMaxZoomDistance = 0.5
    game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    
    local function setFirstPerson()
        game.Players.LocalPlayer.CameraMaxZoomDistance = 0.5
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    end
    
    setFirstPerson()
    
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        wait(1)
        setFirstPerson()
    end)
end)

tool:Button("第三人称", function()
    game.Players.LocalPlayer.CameraMaxZoomDistance = 50
    game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
    
    local function setThirdPerson()
        game.Players.LocalPlayer.CameraMaxZoomDistance = 50
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
    end
    
    setThirdPerson()
    
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        wait(1)
        setThirdPerson()
    end)
end)

tool:Button("显示时间", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/RycMWV3a"))()
end)

tool:Button("道具隐形", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/%E5%B7%A5%E4%BD%9C%E5%AE%A4.LUA", true))()
end)

tool:Button("锁定视角", function()
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

tool:Button("修改数据",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)

tool:Button("玩家加入游戏提示", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
end)

tool:Button("查看游戏中的所有玩家（包括血量条）", function()
   loadstring(game:HttpGet("https://pastebin.com/raw/G2zb992X", true))()
end)

tool:Button("弹人(实体)", function()
    loadstring(game:HttpGet("https://pastefy.app/4r9e4F3p/raw"))()
end)

tool:Button("弹人(半实体)", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/UTWcDtzj"))()
end)

local Lighting = game:GetService("Lighting")

tool:Toggle("时间控制", 'TimeControl', false, function(state)
    if state then
        local currentTime = 12
        
        tool:Slider("时间 (小时)", "", 0, 24, 12, false, function(value)
            currentTime = value
            Lighting.ClockTime = value
        end)
        
        coroutine.wrap(function()
            while wait(1) do
                if not state then break end
                currentTime = currentTime + 0.1
                if currentTime >= 24 then
                    currentTime = 0
                end
                Lighting.ClockTime = currentTime
            end
        end)()
        
    else
        Lighting.ClockTime = 12
    end
end)

tool:Button("装备全部道具", function()
   loadstring(game:HttpGet("https://pastefy.app/uBqVR9JC/raw"))()
end)

tool:Button("删除所有道具", function()
   loadstring(game:HttpGet("https://pastefy.app/8HB71Lbj/raw"))()
end)

tool:Button("获取当前道具", function()
   loadstring(game:HttpGet("https://pastefy.app/3FU05Dyt/raw"))()
end)

tool:Button("删除道具", function()
   loadstring(game:HttpGet("https://pastefy.app/r4LHK4p0/raw"))()
end)

tool:Toggle("无法移动", "Fake flag", false, function(enabled)
  local localPlayer = game.Players.LocalPlayer
  local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  if enabled then
    for _, child in pairs(character:GetChildren()) do
      if child:IsA("BasePart") then
        child.Anchored = true
      end
    end
  else
    for _, child in pairs(character:GetChildren()) do
      if child:IsA("BasePart") then
        child.Anchored = false
      end
    end
  end
end)

tool:Button("点击传送工具",function()
mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "小光点击传送" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack
end)

tool:Button("坐下",function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not humanoidRootPart then return end
    
    if humanoid.Sit then
        humanoid.Sit = false
        humanoid.Jump = true
        return
    end
    
    local invisibleSeat = Instance.new("Seat")
    invisibleSeat.Name = "InvisibleSeat"
    invisibleSeat.Anchored = true
    invisibleSeat.CanCollide = false
    invisibleSeat.Transparency = 1 
    invisibleSeat.Size = Vector3.new(1, 1, 1)
    
    invisibleSeat.CFrame = humanoidRootPart.CFrame * CFrame.new(0, -2.5, 0)
    invisibleSeat.Parent = workspace
    
    humanoid.Sit = true
    
    wait(0.05)
    humanoidRootPart.CFrame = invisibleSeat.CFrame * CFrame.new(0, 1, 0)
    
    local function standUp()
        humanoid.Sit = false
        if invisibleSeat and invisibleSeat.Parent then
            invisibleSeat:Destroy()
        end
    end
    
    local jumpConnection = humanoid.Jumping:Connect(standUp)
    
    local unequipConnection = tool.Unequipped:Connect(function()
        standUp()
        jumpConnection:Disconnect()
        unequipConnection:Disconnect()
    end)
end)

tool:Button("无头断腿r15",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Permanent-Headless-And-korblox-Script-4140"))()      
end)

tool:Button("无头断腿r6",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/FIXED-Brainrot-Jumping-korblox-R6-a-headless-54182"))()
end)

tool:Button("玩家加入游戏提示",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
end)

tool:Toggle("七彩建筑", "BasePart", false, function(enabled)
  local baseParts = nil	
  if enabled then
    Break = false
    r1_665 = {}
    local r2_665 = Enum.Material:GetEnumItems()
    for r6_665, r7_665 in pairs(game.Workspace:GetDescendants()) do
      if r7_665:IsA("BasePart") then
        table.insert(r1_665, r7_665)
      end
    end
    game.Workspace.DescendantAdded:Connect(function(r0_666)
      if r0_666:IsA("BasePart") then
        table.insert(r1_665, r0_666)
      end
    end)
    while task.wait(0.025) do
      local r3_665 = pairs
      local r4_665 = r1_665
      for r6_665, r7_665 in r3_665(r4_665) do
        r7_665.Material = r2_665[math.random(1, #r2_665)]
        r7_665.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
        if Break then
        end
      end
    end
  else
    r1_665 = true
    Break = r1_665
  end
end)

tool:Button("吸人(无法关闭)", function()
  loadstring(game:HttpGet("https://pastefy.app/fF3DMBNF/raw"))()
end)

tool:Button("聊天气泡美化", function()
  loadstring(game:HttpGet("https://pastefy.app/lCEPuiQO/raw"))()
end)

tool:Button("人物绘制", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/pmgp7mdm"))()
end)

tool:Button("吸取全部玩家",function()
    loadstring(game:HttpGet('https://pastebin.com/raw/hQSBGsw2'))()
end)

tool:Button("VR手",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty45.lua"))()
end)

tool:Button("控制玩家",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/wanjiakongzhi"))()
end)

tool:Button("自动弹钢琴",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Tac's-Piano-Stuff-Talentless-script-made-by-hellohellohell012321-44088"))()
end)

tool:Button("吃我一击吧",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/R15%E8%B5%A4%E5%A3%81%E6%88%96%E9%9B%86.txt"))()
end)

tool:Button("秒互动",function()
    game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(v)
        v.HoldDuration = 0
    end)
end)

tool:Button("键盘脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

tool:Button("跟踪玩家",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/F9PNLcXk"))()
end)

tool:Button("换皮肤（需要别人id还需要加入群组Hell_$treet）",function()
  loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\73\110\118\111\111\107\101\114\49\49\47\79\117\116\102\105\116\47\109\97\105\110\47\79\117\116\102\105\116\67\111\112\105\101\114\46\108\117\97\34\44\32\116\114\117\101\41\41\40\41\10")()
end)

tool:Button("无限收益（copyid 输入别人名字获得id可搭配换皮肤使用）",function()
  loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

tool:Button("伪名说话",function()
    loadstring(game:HttpGet(('https://pastefy.ga/zCFEwaYq/raw'),true))()
end)

tool:Button("重新加入游戏", function()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    
    local player = Players.LocalPlayer
    local placeId = game.PlaceId
    local jobId = game.JobId
    
    print("正在重新加入游戏...")
    
    local success, errorMsg = pcall(function()
        TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
    end)
    
    if not success then
        print("重新加入失败:", errorMsg)
        local success2, errorMsg2 = pcall(function()
            TeleportService:Teleport(placeId, player)
        end)
        
        if not success2 then
            print("完全重新加入失败:", errorMsg2)
        end
    end
end)

tool:Button("隐身道具",function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/skid123skidlol/cd0d2dce51b3f20ad1aac941da06a1a1/raw/f58b98cce7d51e53ade94e7bb460e4f24fb7e0ff/%257BFE%257D%2520Invisible%2520Tool%2520(can%2520hold%2520tools)",true))()
end)

tool:Button("回满血",function()
      game.Players.LocalPlayer.Character.Humanoid.Health=10000
end)

tool:Button("无后坐力",function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    
    local player = Players.LocalPlayer
    
    local lastCheck = 0
    local checkInterval = 1 
    local cachedObjects = {}
    local isRunning = true
    
    local function ForceNoRecoil()
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            
            if method == "FireServer" then
                local weaponNames = {"Gun", "Weapon", "Rifle", "Pistol", "Shoot", "Fire", "Bullet"}
                local selfName = tostring(self):lower()
                for _, name in pairs(weaponNames) do
                    if selfName:find(name:lower()) then

                        local args = {...}
                        for i = 1, math.min(#args, 5) do 
                            if type(args[i]) == "number" and math.abs(args[i]) > 0.01 then
                                args[i] = 0
                            end
                        end
                        return oldNamecall(self, unpack(args))
                    end
                end
            end
            
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        
        local recoilConnection
        local frameCount = 0
        recoilConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not isRunning then return end
            
            frameCount = frameCount + 1

            if frameCount % 10 ~= 0 then return end
            
            if workspace.CurrentCamera then
                local cameraCF = workspace.CurrentCamera.CFrame

                local _, _, _, x, y, z = cameraCF:ToEulerAnglesXYZ()
                if math.abs(x) > 0.01 or math.abs(y) > 0.01 or math.abs(z) > 0.01 then
                    workspace.CurrentCamera.CFrame = CFrame.new(cameraCF.Position)
                end
            end
            
            lastCheck = lastCheck + deltaTime
            if lastCheck >= checkInterval then
                lastCheck = 0

                for _, obj in pairs(game:GetDescendants()) do
                    if not cachedObjects[obj] and (obj:IsA("NumberValue") or obj:IsA("Vector3Value")) then
                        local name = obj.Name:lower()
                        if name:find("recoil") or name:find("kick") or name:find("shake") then
                            if obj:IsA("NumberValue") then
                                obj.Value = 0
                            elseif obj:IsA("Vector3Value") then
                                obj.Value = Vector3.new(0, 0, 0)
                            end
                            cachedObjects[obj] = true
                        end
                    end
                end
                

                for obj in pairs(cachedObjects) do
                    if not obj.Parent then
                        cachedObjects[obj] = nil
                    end
                end
            end
        end)
        

        local inputConnection
        inputConnection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then

                spawn(function()

                    wait(0.01)
                    if player.Character then
                        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.CameraOffset = Vector3.new(0, 0, 0)
                        end
                    end
                end)
            end
        end)
        
        local function setupWeapon(tool)
            if tool and tool:IsA("Tool") then
                
                for _, descendant in pairs(tool:GetDescendants()) do
                    if descendant:IsA("NumberValue") then
                        local name = descendant.Name:lower()
                        if name:find("recoil") or name:find("spread") then
                            descendant.Value = 0
                        end
                    end
                end
            end
        end
        
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    setupWeapon(tool)
                    tool.Equipped:Connect(function()
                        setupWeapon(tool)
                    end)
                end
            end
            
            backpack.ChildAdded:Connect(function(tool)
                if tool:IsA("Tool") then
                    wait(0.1) 
                    setupWeapon(tool)
                end
            end)
        end
        
        print("0后坐力模式已激活 - 优化性能，无卡顿")
        
        return function()
            isRunning = false
            if recoilConnection then
                recoilConnection:Disconnect()
            end
            if inputConnection then
                inputConnection:Disconnect()
            end
            setreadonly(mt, false)
            mt.__namecall = oldNamecall
            setreadonly(mt, true)
            cachedObjects = {}
            print("无后坐力功能已关闭")
        end
    end
    
    local disconnectFunction = ForceNoRecoil()
    
    spawn(function()
        while task.wait(5) do
            if isRunning then
                print("无后坐力功能运行中 - 性能稳定")
            end
        end
    end)
end)

tool:Button("无限子弹",function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    local player = Players.LocalPlayer
    local isRunning = true
    
    -- 性能优化变量
    local lastCacheClean = 0
    local cacheCleanInterval = 5
    local cachedAmmoObjects = {}
    local frameCounter = 0
    local processedModules = {}
    
    -- 优化后的无限子弹功能
    local function OptimizedInfiniteAmmo()
        -- 方法1: 轻量级拦截弹药消耗（减少重复调用）
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            
            -- 只拦截明确的弹药消耗调用
            if method == "InvokeServer" or method == "FireServer" then
                local eventName = tostring(self):lower()
                local criticalAmmoKeywords = {"ammo", "bullet", "magazine", "clip", "reload"}
                
                for _, keyword in pairs(criticalAmmoKeywords) do
                    if eventName:find(keyword) then
                        -- 直接返回成功，不执行实际消耗
                        return true
                    end
                end
            end
            
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        
        -- 方法2: 智能弹药监控（大幅减少循环频率）
        local ammoConnection
        ammoConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not isRunning then return end
            
            frameCounter += 1
            -- 每60帧执行一次，大幅减少性能消耗
            if frameCounter % 60 ~= 0 then return end
            
            lastCacheClean += deltaTime
            
            -- 只处理新发现的弹药对象
            for _, obj in pairs(game:GetDescendants()) do
                if not cachedAmmoObjects[obj] then
                    local objName = tostring(obj):lower()
                    local parentName = obj.Parent and tostring(obj.Parent):lower() or ""
                    
                    -- 精确检测弹药相关对象
                    local isAmmoRelated = (objName:find("ammo") and not objName:find("camera")) or 
                                         (objName:find("bullet") and not objName:find("hole")) or
                                         objName:find("magazine") or 
                                         objName:find("clip") or
                                         (objName:find("capacity") and (parentName:find("gun") or parentName:find("weapon")))
                    
                    if isAmmoRelated then
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            if obj.Value < 10 then -- 只在弹药不足时设置
                                obj.Value = 999
                            end
                            cachedAmmoObjects[obj] = true
                        elseif obj:IsA("StringValue") and obj.Value:lower():find("empty") then
                            obj.Value = "Full"
                            cachedAmmoObjects[obj] = true
                        elseif obj:IsA("BoolValue") and obj.Name:find("Empty") then
                            obj.Value = false
                            cachedAmmoObjects[obj] = true
                        end
                    end
                end
            end
            
            -- 定期清理无效缓存（减少内存占用）
            if lastCacheClean >= cacheCleanInterval then
                lastCacheClean = 0
                for obj in pairs(cachedAmmoObjects) do
                    if not obj.Parent then
                        cachedAmmoObjects[obj] = nil
                    end
                end
            end
        end)
        
        -- 方法3: 事件驱动的武器设置（减少持续监控）
        local function setupWeapon(tool)
            if tool and tool:IsA("Tool") then
                spawn(function()
                    task.wait(0.1) -- 延迟处理避免卡顿
                    
                    -- 一次性设置武器所有弹药参数
                    for _, descendant in pairs(tool:GetDescendants()) do
                        if descendant:IsA("IntValue") or descendant:IsA("NumberValue") then
                            local name = descendant.Name:lower()
                            if name:find("ammo") or name:find("bullet") or name:find("capacity") then
                                descendant.Value = 999
                                cachedAmmoObjects[descendant] = true
                            end
                        elseif descendant:IsA("RemoteEvent") then
                            local eventName = descendant.Name:lower()
                            if eventName:find("reload") then
                                -- 轻量级重新装弹拦截
                                local oldFire = descendant.FireServer
                                descendant.FireServer = function(self, ...)
                                    return true
                                end
                            end
                        end
                    end
                end)
            end
        end
        
        -- 方法4: 分批处理现有武器（避免一次性卡顿）
        local function setupExistingWeapons()
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                local weapons = {}
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        table.insert(weapons, tool)
                    end
                end
                
                -- 分批处理武器，每批间隔0.1秒
                for i, weapon in ipairs(weapons) do
                    spawn(function()
                        task.wait(i * 0.1)
                        setupWeapon(weapon)
                    end)
                end
            end
        end
        
        -- 初始设置现有武器
        setupExistingWeapons()
        
        -- 监听新武器（延迟处理）
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            backpack.ChildAdded:Connect(function(tool)
                if tool:IsA("Tool") then
                    wait(0.3) -- 等待武器完全加载
                    setupWeapon(tool)
                end
            end)
        end
        
        -- 监听角色武器
        player.CharacterAdded:Connect(function(character)
            wait(1.5) -- 等待角色完全加载
            for _, tool in pairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    setupWeapon(tool)
                end
            end
        end)
        
        -- 方法5: 延迟模块处理（减少即时计算）
        spawn(function()
            task.wait(3) -- 延迟3秒后处理模块
            for _, module in pairs(game:GetDescendants()) do
                if module:IsA("ModuleScript") and not processedModules[module] then
                    processedModules[module] = true
                    pcall(function()
                        local mod = require(module)
                        if type(mod) == "table" then
                            for key, value in pairs(mod) do
                                if type(key) == "string" and type(value) == "number" then
                                    local keyLower = key:lower()
                                    if keyLower:find("ammo") or keyLower:find("capacity") then
                                        if value < 100 then
                                            mod[key] = 999
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(0.05) -- 模块间延迟
                end
            end
        end)
        
        print("优化无限子弹已激活 - 高性能无卡顿")
        
        -- 返回断开连接的函数
        return function()
            isRunning = false
            
            if ammoConnection then
                ammoConnection:Disconnect()
            end
            
            -- 恢复原metatable
            setreadonly(mt, false)
            mt.__namecall = oldNamecall
            setreadonly(mt, true)
            
            cachedAmmoObjects = {}
            processedModules = {}
            print("无限子弹功能已关闭")
        end
    end
    
    local disconnectFunction = OptimizedInfiniteAmmo()
    
    spawn(function()
        while task.wait(15) and isRunning do
            print("无限子弹运行中 - 性能稳定")
        end
    end)
end)

tool:Button("快速射击",function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    
    local player = Players.LocalPlayer
    local isRunning = true
    local fireRateMultiplier = 50 
    
    local lastWeaponCheck = 0
    local weaponCheckInterval = 2
    local cachedWeapons = {}
    local frameCounter = 0
    
    local function OptimizedFastFire()
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        local activeWeapons = {}
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "FireServer" or method == "InvokeServer" then
                local selfName = tostring(self):lower()
                local weaponKeywords = {"fire", "shoot", "bullet", "gun", "weapon"}
                
                for _, keyword in pairs(weaponKeywords) do
                    if selfName:find(keyword) then
                        if not activeWeapons[self] then
                            activeWeapons[self] = true
                            
                            -- 使用更温和的快速射击循环
                            spawn(function()
                                local shotCount = 0
                                while isRunning and activeWeapons[self] and shotCount < fireRateMultiplier do
                                    pcall(function()
                                        oldNamecall(self, unpack(args))
                                    end)
                                    shotCount += 1
                                    -- 增加延迟减少卡顿
                                    if shotCount % 10 == 0 then
                                        task.wait(0.01) -- 增加延迟时间
                                    end
                                end
                                activeWeapons[self] = nil
                            end)
                        end
                        return true
                    end
                end
            end
            
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        
        -- 方法2: 优化武器参数修改（减少循环频率）
        local weaponConnection
        weaponConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not isRunning then return end
            
            frameCounter += 1
            -- 每30帧执行一次，大幅减少CPU使用
            if frameCounter % 30 ~= 0 then return end
            
            lastWeaponCheck += deltaTime
            if lastWeaponCheck >= weaponCheckInterval then
                lastWeaponCheck = 0
                
                -- 只处理新发现的武器对象
                for _, obj in pairs(game:GetDescendants()) do
                    if not cachedWeapons[obj] and obj:IsA("NumberValue") then
                        local name = obj.Name:lower()
                        local timeKeywords = {"firerate", "firedelay", "cooldown"}
                        
                        for _, keyword in pairs(timeKeywords) do
                            if name:find(keyword) then
                                if obj.Value > 0.05 then -- 只修改较大的延迟值
                                    obj.Value = 0.05 -- 设置为合理的最小值
                                end
                                cachedWeapons[obj] = true
                                break
                            end
                        end
                    end
                end
                
                -- 清理无效缓存
                for obj in pairs(cachedWeapons) do
                    if not obj.Parent then
                        cachedWeapons[obj] = nil
                    end
                end
            end
        end)
        
        -- 方法3: 事件驱动的自动射击（减少持续计算）
        local autoFireConnection
        local isMouseDown = false
        local lastShotTime = 0
        local minShotInterval = 0.033 -- 约30FPS，避免过度射击
        
        autoFireConnection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isMouseDown = true
                
                -- 使用更温和的自动射击
                spawn(function()
                    while isMouseDown and isRunning do
                        local currentTime = tick()
                        if currentTime - lastShotTime >= minShotInterval then
                            pcall(function()
                                -- 只触发主要的射击事件，减少重复调用
                                for _, obj in pairs(game:GetDescendants()) do
                                    if obj:IsA("RemoteEvent") then
                                        local name = obj.Name:lower()
                                        if (name:find("fire") or name:find("shoot")) and not name:find("reload") then
                                            obj:FireServer()
                                            break -- 只触发一个主要事件
                                        end
                                    end
                                end
                            end)
                            lastShotTime = currentTime
                        end
                        task.wait(0.016) -- 约60FPS的延迟
                    end
                end)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isMouseDown = false
            end
        end)
        
        -- 方法4: 延迟加载模块修改（减少即时计算）
        local moduleConnection
        local modulesProcessed = {}
        
        moduleConnection = RunService.Heartbeat:Connect(function()
            if not isRunning then return end
            
            -- 每5秒检查一次新模块
            if tick() % 5 > 0.1 then return end
            
            for _, module in pairs(game:GetDescendants()) do
                if module:IsA("ModuleScript") and not modulesProcessed[module] then
                    modulesProcessed[module] = true
                    
                    -- 使用延迟处理避免卡顿
                    spawn(function()
                        task.wait(0.1) -- 延迟处理
                        pcall(function()
                            local mod = require(module)
                            if type(mod) == "table" then
                                for key, value in pairs(mod) do
                                    if type(key) == "string" and type(value) == "number" then
                                        local keyLower = key:lower()
                                        if (keyLower:find("firerate") or keyLower:find("cooldown")) and value > 0.1 then
                                            mod[key] = 0.05 -- 合理的最小值
                                        end
                                    end
                                end
                            end
                        end)
                    end)
                end
            end
        end)
        
        -- 方法5: 武器装备时批量优化（减少实时计算）
        local function optimizeWeapon(tool)
            if tool and tool:IsA("Tool") then
                spawn(function()
                    task.wait(0.05) -- 延迟处理
                    for _, descendant in pairs(tool:GetDescendants()) do
                        if descendant:IsA("NumberValue") then
                            local name = descendant.Name:lower()
                            if name:find("delay") or name:find("rate") or name:find("cooldown") then
                                if descendant.Value > 0.05 then
                                    descendant.Value = 0.05
                                end
                            end
                        end
                    end
                end)
            end
        end
        
        -- 设置现有武器（分批处理）
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            -- 分批处理现有武器
            for i, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    spawn(function()
                        task.wait(i * 0.1) -- 分批延迟处理
                        optimizeWeapon(tool)
                    end)
                end
            end
            
            
            backpack.ChildAdded:Connect(function(tool)
                if tool:IsA("Tool") then
                    wait(0.2)
                    optimizeWeapon(tool)
                end
            end)
        end
        
        print("小光yyds")
        
       
        return function()
            isRunning = false
            isMouseDown = false
            activeWeapons = {}
            
            if weaponConnection then
                weaponConnection:Disconnect()
            end
            if autoFireConnection then
                autoFireConnection:Disconnect()
            end
            if moduleConnection then
                moduleConnection:Disconnect()
            end
            
            setreadonly(mt, false)
            mt.__namecall = oldNamecall
            setreadonly(mt, true)
            
            print("🤫🤫🤫🤫")
        end
    end
    
 
    local disconnectFunction = OptimizedFastFire()
    
    
    spawn(function()
        while task.wait(10) and isRunning do
            print("小光快速射击")
        end
    end)
end)

tool:Button("驰甩飞",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/冬甩飞.lua"))()
end)

tool:Button("操b脚本", function()
  local SimpleSexGUI = Instance.new("ScreenGui") local FGUI = Instance.new("Frame") local btnNaked = Instance.new("TextButton") local btnSex = Instance.new("TextButton") local tbxVictim = Instance.new("TextBox") local lblFUCKEMALL = Instance.new("TextLabel") local ImageLabel = Instance.new("ImageLabel") local lbltitle = Instance.new("TextLabel") local TextLabel = Instance.new("TextLabel") SimpleSexGUI.Name = "SimpleSexGUI" SimpleSexGUI.Parent = game.CoreGui FGUI.Name = "FGUI" FGUI.Parent = SimpleSexGUI FGUI.BackgroundColor3 = Color3.new(255,255,255) FGUI.BorderSizePixel = 1 FGUI.Position = UDim2.new(0,0, 0.667, 0) FGUI.Size = UDim2.new(0,317, 0,271) FGUI.Draggable = true lbltitle.Name = "Title" lbltitle.Parent = FGUI lbltitle.BackgroundColor3 = Color3.new(255,255,255) lbltitle.BorderSizePixel = 1 lbltitle.Position = UDim2.new (0, 0,-0.122, 0) lbltitle.Size = UDim2.new (0, 317,0, 33) lbltitle.Visible = true lbltitle.Active = true lbltitle.Draggable = false lbltitle.Selectable = true lbltitle.Font = Enum.Font.SourceSansBold lbltitle.Text = "操到流液体" lbltitle.TextColor3 = Color3.new(0, 0, 0) lbltitle.TextSize = 20 btnSex.Name = "Sex" btnSex.Parent = FGUI btnSex.BackgroundColor3 = Color3.new(255,255,255) btnSex.BorderSizePixel = 1 btnSex.Position = UDim2.new (0.044, 0,0.229, 0) btnSex.Size = UDim2.new (0, 99,0, 31) btnSex.Visible = true btnSex.Active = true btnSex.Draggable = false btnSex.Selectable = true btnSex.Font = Enum.Font.SourceSansBold btnSex.Text = "小光银河射线" btnSex.TextColor3 = Color3.new(0, 0, 0) btnSex.TextSize = 20 tbxVictim.Name = "VictimTEXT" tbxVictim.Parent = FGUI tbxVictim.BackgroundColor3 = Color3.new(255,255,255) tbxVictim.BorderSizePixel = 1 tbxVictim.Position = UDim2.new (0.533, 0,0.229, 0) tbxVictim.Size = UDim2.new (0, 133,0, 27) tbxVictim.Visible = true tbxVictim.Active = true tbxVictim.Draggable = false tbxVictim.Selectable = true tbxVictim.Font = Enum.Font.SourceSansBold tbxVictim.Text = "女主" tbxVictim.TextColor3 = Color3.new(0, 0, 0) tbxVictim.TextSize = 20 lblFUCKEMALL.Name = "FUCKEMALL" lblFUCKEMALL.Parent = FGUI lblFUCKEMALL.BackgroundColor3 = Color3.new(255,255,255) lblFUCKEMALL.BorderSizePixel = 1 lblFUCKEMALL.Position = UDim2.new (0.025, 0,0.856, 0) lblFUCKEMALL.Size = UDim2.new (0, 301,0, 27) lblFUCKEMALL.Visible = true lblFUCKEMALL.Font = Enum.Font.SourceSansBold lblFUCKEMALL.Text = "操逼" lblFUCKEMALL.TextColor3 = Color3.new(0, 0, 0) lblFUCKEMALL.TextSize = 20 ImageLabel.Name = "ImageLabel" ImageLabel.Parent = FGUI ImageLabel.Image = "http://www.roblox.com/asset/?id=42837..." ImageLabel.BorderSizePixel = 1 ImageLabel.Position = UDim2.new (0.274, 0,0.358, 0) ImageLabel.Size = UDim2.new (0, 106,0, 121) btnSex.MouseButton1Click:Connect(function() local player = tbxVictim.Text local stupid = Instance.new('Animation') stupid.AnimationId = 'rbxassetid://148840371' hummy = game:GetService("Players").LocalPlayer.Character.Humanoid pcall(function() hummy.Parent.Pants:Destroy() end) pcall(function() hummy.Parent.Shirt:Destroy() end) local notfunny = hummy:LoadAnimation(stupid) notfunny:Play() notfunny:AdjustSpeed(10) while hummy.Parent.Parent ~= nil do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tbxVictim.Text].Character.HumanoidRootPart.CFrame end end)
end)

tool:Button("子弹追踪",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/1AJ69eRG"))()
end)

tool:Button("获取所有玩家道具",function()
  for i,v in pairs(game.Players:GetChildren()) do
    wait()
    for i,b in pairs(v.Backpack:GetChildren()) do
      b.Parent = game.Players.LocalPlayer.Backpack
    end
  end
end)

tool:Button("驰飞行",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E9%A9%B0%E9%A3%9E%E8%A1%8C.lua"))()
end)

tool:Button("FPS[变流畅]",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gclich/FPS-X-GUI/main/FPS_X.lua"))()
end)

tool:Button("解帧",function()
loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-FpsBoost-9260"))()
end)

tool:Button("fps显示",function()
loadstring(game:HttpGet("https://pastefy.app/d9j82YJr/raw",true))()
end)

tool:Button("情云同款自瞄可调", function()
  local fov = 100 local smoothness = 10 local crosshairDistance = 5 local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local Players = game:GetService("Players") local Cam = game.Workspace.CurrentCamera local FOVring = Drawing.new("Circle") FOVring.Visible = true FOVring.Thickness = 2 FOVring.Color = Color3.fromRGB(0, 255, 0) FOVring.Filled = false FOVring.Radius = fov FOVring.Position = Cam.ViewportSize / 2 local Player = Players.LocalPlayer local PlayerGui = Player:WaitForChild("PlayerGui") local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "FovAdjustGui" ScreenGui.Parent = PlayerGui local Frame = Instance.new("Frame") Frame.Name = "MainFrame" Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) Frame.BorderColor3 = Color3.fromRGB(128, 0, 128) Frame.BorderSizePixel = 2 Frame.Position = UDim2.new(0.3, 0, 0.3, 0) Frame.Size = UDim2.new(0.4, 0, 0.4, 0) Frame.Active = true Frame.Draggable = true Frame.Parent = ScreenGui local MinimizeButton = Instance.new("TextButton") MinimizeButton.Name = "MinimizeButton" MinimizeButton.Text = "-" MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255) MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) MinimizeButton.Position = UDim2.new(0.9, 0, 0, 0) MinimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0) MinimizeButton.Parent = Frame local isMinimized = false MinimizeButton.MouseButton1Click:Connect(function() isMinimized = not isMinimized if isMinimized then Frame:TweenSize(UDim2.new(0.1, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true) MinimizeButton.Text = "+" else Frame:TweenSize(UDim2.new(0.4, 0, 0.4, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true) MinimizeButton.Text = "-" end end) local FovLabel = Instance.new("TextLabel") FovLabel.Name = "FovLabel" FovLabel.Text = "自瞄范围" FovLabel.TextColor3 = Color3.fromRGB(255, 255, 255) FovLabel.BackgroundTransparency = 1 FovLabel.Position = UDim2.new(0.1, 0, 0.1, 0) FovLabel.Size = UDim2.new(0.8, 0, 0.2, 0) FovLabel.Parent = Frame local FovSlider = Instance.new("TextBox") FovSlider.Name = "FovSlider" FovSlider.Text = tostring(fov) FovSlider.TextColor3 = Color3.fromRGB(255, 255, 255) FovSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) FovSlider.Position = UDim2.new(0.1, 0, 0.3, 0) FovSlider.Size = UDim2.new(0.8, 0, 0.2, 0) FovSlider.Parent = Frame local SmoothnessLabel = Instance.new("TextLabel") SmoothnessLabel.Name = "SmoothnessLabel" SmoothnessLabel.Text = "自瞄平滑度" SmoothnessLabel.TextColor3 = Color3.fromRGB(255, 255, 255) SmoothnessLabel.BackgroundTransparency = 1 SmoothnessLabel.Position = UDim2.new(0.1, 0, 0.5, 0) SmoothnessLabel.Size = UDim2.new(0.8, 0, 0.2, 0) SmoothnessLabel.Parent = Frame local SmoothnessSlider = Instance.new("TextBox") SmoothnessSlider.Name = "SmoothnessSlider" SmoothnessSlider.Text = tostring(smoothness) SmoothnessSlider.TextColor3 = Color3.fromRGB(255, 255, 255) SmoothnessSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) SmoothnessSlider.Position = UDim2.new(0.1, 0, 0.7, 0) SmoothnessSlider.Size = UDim2.new(0.8, 0, 0.2, 0) SmoothnessSlider.Parent = Frame local CrosshairDistanceLabel = Instance.new("TextLabel") CrosshairDistanceLabel.Name = "CrosshairDistanceLabel" CrosshairDistanceLabel.Text = "自瞄预判距离" CrosshairDistanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255) CrosshairDistanceLabel.BackgroundTransparency = 1 CrosshairDistanceLabel.Position = UDim2.new(0.1, 0, 0.9, 0) CrosshairDistanceLabel.Size = UDim2.new(0.8, 0, 0.2, 0) CrosshairDistanceLabel.Parent = Frame local CrosshairDistanceSlider = Instance.new("TextBox") CrosshairDistanceSlider.Name = "CrosshairDistanceSlider" CrosshairDistanceSlider.Text = tostring(crosshairDistance) CrosshairDistanceSlider.TextColor3 = Color3.fromRGB(255, 255, 255) CrosshairDistanceSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) CrosshairDistanceSlider.Position = UDim2.new(0.1, 0, 1.1, 0) CrosshairDistanceSlider.Size = UDim2.new(0.8, 0, 0.2, 0) CrosshairDistanceSlider.Parent = Frame local targetCFrame = Cam.CFrame local function updateDrawings() local camViewportSize = Cam.ViewportSize FOVring.Position = camViewportSize / 2 FOVring.Radius = fov end local function onKeyDown(input) if input.KeyCode == Enum.KeyCode.Delete then RunService:UnbindFromRenderStep("FOVUpdate") FOVring:Remove() end end UserInputService.InputBegan:Connect(onKeyDown) local function getClosestPlayerInFOV(trg_part) local nearest = nil local last = math.huge local playerMousePos = Cam.ViewportSize / 2 for _, player in ipairs(Players:GetPlayers()) do if player ~= Players.LocalPlayer then local part = player.Character and player.Character:FindFirstChild(trg_part) if part then local ePos, isVisible = Cam:WorldToViewportPoint(part.Position) local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude if distance < last and isVisible and distance < fov then last = distance nearest = player end end end end return nearest end RunService.RenderStepped:Connect(function() updateDrawings() local closest = getClosestPlayerInFOV("Head") if closest and closest.Character:FindFirstChild("Head") then local targetCharacter = closest.Character local targetHead = targetCharacter.Head local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart") local isMoving = targetRootPart.Velocity.Magnitude > 0.1 local targetPosition if isMoving then targetPosition = targetHead.Position + (targetHead.CFrame.LookVector * crosshairDistance) else targetPosition = targetHead.Position end targetCFrame = CFrame.new(Cam.CFrame.Position, targetPosition) else targetCFrame = Cam.CFrame end Cam.CFrame = Cam.CFrame:Lerp(targetCFrame, 1 / smoothness) end) FovSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newFov = tonumber(FovSlider.Text) if newFov then fov = newFov else FovSlider.Text = tostring(fov) end end end) SmoothnessSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newSmoothness = tonumber(SmoothnessSlider.Text) if newSmoothness then smoothness = newSmoothness else SmoothnessSlider.Text = tostring(smoothness) end end end) CrosshairDistanceSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newCrosshairDistance = tonumber(CrosshairDistanceSlider.Text) if newCrosshairDistance then crosshairDistance = newCrosshairDistance else CrosshairDistanceSlider.Text = tostring(crosshairDistance) end end end)
end)

tool:Button("控制npc",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau"))()
end)

tool:Button("自杀",function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

tool:Button("驰飞车",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E9%A9%B0%E9%A3%9E%E8%BD%A6.lua"))()
end)

tool:Button("获得管理员权限",function()
loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
end)

tool:Button("爬墙",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

tool:Toggle("自动互动", "Auto Interact", false, function(state)
    if state then
        autoInteract = true
        while autoInteract do
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    fireproximityprompt(descendant)
                end
            end
            task.wait(0.25) -- Adjust the wait time as needed
        end
    else
        autoInteract = false
    end
end)

tool:Label("修改时间")

tool:Button("凌晨12点", function()
  loadstring(game:HttpGet("https://pastefy.app/xFX51PIw/raw"))()
end)

tool:Button("下午4点", function()
  loadstring(game:HttpGet("https://pastefy.app/sIrAGJxJ/raw"))()
end)

tool:Button("中午11点", function()
  loadstring(game:HttpGet("https://pastefy.app/rccCMBch/raw"))()
end)

tool:Button("早上6点", function()
  loadstring(game:HttpGet("https://pastefy.app/h9VLRgYR/raw"))()
end)

local creds = window:Tab("神秘修改",'6035145364')

local tool = creds:section("功能",true)

tool:Textbox("修改头部大小", "headSize", "请输入文本", function(size)
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            size = tonumber(size) or 1
            size = math.clamp(size, 0.5, 50)
            
            local head = char:FindFirstChild("Head")
            if head then
                -- 保存头部缩放比例
                if not head:FindFirstChild("OriginalHeadScale") then
                    local tag = Instance.new("NumberValue")
                    tag.Name = "OriginalHeadScale"
                    tag.Value = 1
                    tag.Parent = head
                end
                
                -- 设置头部碰撞盒
                head.CanCollide = false
                head.Size = Vector3.new(2 * size, 1 * size, 1 * size)
                
                -- 调整头部位置
                local headOffset = (head.Size.Y - 1) * 0.5
                local neck = char:FindFirstChild("Neck") or char:FindFirstChild("Torso"):FindFirstChild("Neck")
                if neck then
                    neck.C0 = CFrame.new(0, headOffset, 0) * CFrame.Angles(0, 0, 0)
                end
            end
        end
    end
end)

tool:Textbox("修改躯干大小", "torsoSize", "请输入文本", function(size)
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            size = tonumber(size) or 1
            size = math.clamp(size, 0.5, 50)
            
            local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
            if torso then
                -- 保存原始大小
                if not torso:FindFirstChild("OriginalTorsoScale") then
                    local tag = Instance.new("NumberValue")
                    tag.Name = "OriginalTorsoScale"
                    tag.Value = 1
                    tag.Parent = torso
                end
                
                local originalSize = Vector3.new(2, 2, 1)
                torso.Size = Vector3.new(originalSize.X * size, originalSize.Y * size, originalSize.Z * size)
                
                -- 调整其他部位的连接点
                humanoid.BodyDepthScale.Value = size
                humanoid.BodyHeightScale.Value = size
                humanoid.BodyWidthScale.Value = size
                
                -- 调整角色碰撞
                humanoid.HipHeight = 0.5 * size
            end
        end
    end
end)

tool:Textbox("修改手臂大小", "armSize", "请输入文本", function(size)
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            size = tonumber(size) or 1
            size = math.clamp(size, 0.5, 50)
            
            -- R15 和 R6 兼容
            local leftUpperArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
            local rightUpperArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
            
            if leftUpperArm then
                local originalSize = Vector3.new(1, 2, 1)
                leftUpperArm.Size = Vector3.new(originalSize.X * size, originalSize.Y * size, originalSize.Z * size)
                leftUpperArm.CanCollide = false
            end
            
            if rightUpperArm then
                local originalSize = Vector3.new(1, 2, 1)
                rightUpperArm.Size = Vector3.new(originalSize.X * size, originalSize.Y * size, originalSize.Z * size)
                rightUpperArm.CanCollide = false
            end
            
            -- R15 需要同时调整前臂
            local leftLowerArm = char:FindFirstChild("LeftLowerArm")
            local rightLowerArm = char:FindFirstChild("RightLowerArm")
            local leftHand = char:FindFirstChild("LeftHand")
            local rightHand = char:FindFirstChild("RightHand")
            
            if leftLowerArm then
                leftLowerArm.Size = Vector3.new(1 * size, 1.5 * size, 1 * size)
                leftLowerArm.CanCollide = false
            end
            if rightLowerArm then
                rightLowerArm.Size = Vector3.new(1 * size, 1.5 * size, 1 * size)
                rightLowerArm.CanCollide = false
            end
            if leftHand then
                leftHand.Size = Vector3.new(1 * size, 0.5 * size, 1 * size)
                leftHand.CanCollide = false
            end
            if rightHand then
                rightHand.Size = Vector3.new(1 * size, 0.5 * size, 1 * size)
                rightHand.CanCollide = false
            end
            
            -- 设置Humanoid缩放
            humanoid.LeftArmScale.Value = size
            humanoid.RightArmScale.Value = size
        end
    end
end)

tool:Textbox("修改腿部大小", "legSize", "请输入文本", function(size)
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            size = tonumber(size) or 1
            size = math.clamp(size, 0.5, 50)
            
            -- R15 和 R6 兼容
            local leftUpperLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
            local rightUpperLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
            
            if leftUpperLeg then
                local originalSize = Vector3.new(1, 2, 1)
                leftUpperLeg.Size = Vector3.new(originalSize.X * size, originalSize.Y * size, originalSize.Z * size)
            end
            
            if rightUpperLeg then
                local originalSize = Vector3.new(1, 2, 1)
                rightUpperLeg.Size = Vector3.new(originalSize.X * size, originalSize.Y * size, originalSize.Z * size)
            end
            
            -- R15 需要同时调整小腿
            local leftLowerLeg = char:FindFirstChild("LeftLowerLeg")
            local rightLowerLeg = char:FindFirstChild("RightLowerLeg")
            local leftFoot = char:FindFirstChild("LeftFoot")
            local rightFoot = char:FindFirstChild("RightFoot")
            
            if leftLowerLeg then
                leftLowerLeg.Size = Vector3.new(1 * size, 1.5 * size, 1 * size)
            end
            if rightLowerLeg then
                rightLowerLeg.Size = Vector3.new(1 * size, 1.5 * size, 1 * size)
            end
            if leftFoot then
                leftFoot.Size = Vector3.new(1 * size, 0.5 * size, 1.5 * size)
            end
            if rightFoot then
                rightFoot.Size = Vector3.new(1 * size, 0.5 * size, 1.5 * size)
            end
            
            -- 设置Humanoid缩放，确保行走正常
            humanoid.LeftLegScale.Value = size
            humanoid.RightLegScale.Value = size
            
            -- 调整hip高度避免腿部卡地面
            humanoid.HipHeight = 0.5 * size
            
            -- 调整步行速度以匹配腿部大小
            humanoid.WalkSpeed = 16 * math.sqrt(size) -- 根据腿部大小调整速度
            
            -- 确保腿部碰撞合适
            if leftUpperLeg then
                leftUpperLeg.CanCollide = true
            end
            if rightUpperLeg then
                rightUpperLeg.CanCollide = true
            end
        end
    end
end)

tool:Textbox("重置身体大小", "resetSize", "输入1重置", function(value)
    if value == "1" then
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                -- 重置Humanoid缩放
                humanoid.BodyDepthScale.Value = 1
                humanoid.BodyHeightScale.Value = 1
                humanoid.BodyWidthScale.Value = 1
                humanoid.HeadScale.Value = 1
                humanoid.LeftArmScale.Value = 1
                humanoid.RightArmScale.Value = 1
                humanoid.LeftLegScale.Value = 1
                humanoid.RightLegScale.Value = 1
                
                -- 重置部件大小
                local parts = {
                    "Head",
                    "Torso", "UpperTorso", "LowerTorso",
                    "Left Arm", "Right Arm", 
                    "LeftUpperArm", "RightUpperArm",
                    "LeftLowerArm", "RightLowerArm",
                    "LeftHand", "RightHand",
                    "Left Leg", "Right Leg",
                    "LeftUpperLeg", "RightUpperLeg",
                    "LeftLowerLeg", "RightLowerLeg",
                    "LeftFoot", "RightFoot"
                }
                
                for _, partName in ipairs(parts) do
                    local part = char:FindFirstChild(partName)
                    if part then
                        -- 设置默认大小
                        if partName == "Head" then
                            part.Size = Vector3.new(2, 1, 1)
                        elseif partName == "Torso" or partName == "UpperTorso" then
                            part.Size = Vector3.new(2, 2, 1)
                        elseif partName:find("Arm") or partName:find("Hand") then
                            part.Size = Vector3.new(1, 2, 1)
                        elseif partName:find("Leg") or partName:find("Foot") then
                            part.Size = Vector3.new(1, 2, 1)
                        end
                        part.CanCollide = false
                    end
                end
                
                -- 重置其他设置
                humanoid.HipHeight = 0
                humanoid.WalkSpeed = 16
                
                print("身体大小已重置")
            end
        end
    end
end)

local tool = creds:section("其他玩家",true)

-- 玩家列表管理
local playerList = {}
local selectedPlayer = nil
local RunService = game:GetService("RunService")

-- 创建玩家下拉框函数
local function createPlayerDropdown()
    playerList = {}
    for i, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            table.insert(playerList, v.Name)
        end
    end
    
    -- 如果没有其他玩家，添加提示
    if #playerList == 0 then
        table.insert(playerList, "暂无其他玩家")
    end
    
    tool:Dropdown("选择其他玩家", "otherPlayerSelect", playerList, function(selectedPlayerName)
        if selectedPlayerName and selectedPlayerName ~= "" and selectedPlayerName ~= "暂无其他玩家" then
            selectedPlayer = game:GetService("Players"):FindFirstChild(selectedPlayerName)
            if selectedPlayer then
                print("✅ 已选择玩家: " .. selectedPlayer.Name)
            end
        else
            selectedPlayer = nil
            print("未选择玩家")
        end
    end)
end

createPlayerDropdown()

-- 玩家加入/离开事件
game:GetService("Players").PlayerAdded:Connect(function(player)
    wait(1)
    createPlayerDropdown()
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    createPlayerDropdown()
end)

tool:Button("刷新玩家列表", function()
    createPlayerDropdown()
    print("🔄 玩家列表已刷新")
end)

-- 显示当前选中的玩家
tool:Button("显示选中玩家", function()
    if selectedPlayer then
        print("🎯 当前选中的玩家: " .. selectedPlayer.Name)
        if selectedPlayer.Character then
            print("📦 玩家有角色")
        else
            print("❌ 玩家没有角色")
        end
    else
        print("⚠️ 未选中任何玩家")
    end
end)

-- ========== 修改其他玩家头部大小 ==========
tool:Textbox("修改他人头部大小", "otherHeadSize", "请输入文本", function(size)
    if selectedPlayer then
        local char = selectedPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                size = tonumber(size) or 1
                size = math.clamp(size, 0.5, 50)
                
                -- 使用Humanoid的Scale属性
                humanoid.HeadScale.Value = size
                
                -- 同时调整头部部件大小（视觉上更明显）
                local head = char:FindFirstChild("Head")
                if head then
                    head.Size = Vector3.new(2 * size, 1 * size, 1 * size)
                    head.CanCollide = false
                end
                
                print("✅ 已修改 " .. selectedPlayer.Name .. " 的头部大小为: " .. size)
            else
                print("❌ 找不到Humanoid")
            end
        else
            print("❌ 玩家 " .. selectedPlayer.Name .. " 没有角色")
        end
    else
        print("⚠️ 请先选择玩家！")
    end
end)

-- ========== 修改其他玩家躯干大小 ==========
tool:Textbox("修改他人躯干大小", "otherTorsoSize", "请输入文本", function(size)
    if selectedPlayer then
        local char = selectedPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                size = tonumber(size) or 1
                size = math.clamp(size, 0.5, 50)
                
                -- 使用Humanoid的Scale属性
                humanoid.BodyDepthScale.Value = size
                humanoid.BodyHeightScale.Value = size
                humanoid.BodyWidthScale.Value = size
                
                -- 调整hip高度避免角色下沉
                humanoid.HipHeight = 0.5 * size
                
                -- 同时调整躯干部件大小
                local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
                if torso then
                    torso.Size = Vector3.new(2 * size, 2 * size, 1 * size)
                end
                
                print("✅ 已修改 " .. selectedPlayer.Name .. " 的躯干大小为: " .. size)
            else
                print("❌ 找不到Humanoid")
            end
        else
            print("❌ 玩家 " .. selectedPlayer.Name .. " 没有角色")
        end
    else
        print("⚠️ 请先选择玩家！")
    end
end)

-- ========== 修改其他玩家手臂大小 ==========
tool:Textbox("修改他人手臂大小", "otherArmSize", "请输入文本", function(size)
    if selectedPlayer then
        local char = selectedPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                size = tonumber(size) or 1
                size = math.clamp(size, 0.5, 50)
                
                -- 使用Humanoid的Scale属性
                humanoid.LeftArmScale.Value = size
                humanoid.RightArmScale.Value = size
                
                -- 调整手臂连接点位置，让手臂"弹出来"
                local leftShoulder = char:FindFirstChild("Left Shoulder") or char:FindFirstChild("UpperTorso"):FindFirstChild("LeftShoulder")
                local rightShoulder = char:FindFirstChild("Right Shoulder") or char:FindFirstChild("UpperTorso"):FindFirstChild("RightShoulder")
                
                if leftShoulder then
                    -- 将左臂向外推，避免与身体挤压
                    leftShoulder.C0 = CFrame.new(-1.5 * size, 0.5 * size, 0) * CFrame.Angles(0, -math.rad(90), 0)
                end
                
                if rightShoulder then
                    -- 将右臂向外推，避免与身体挤压
                    rightShoulder.C0 = CFrame.new(1.5 * size, 0.5 * size, 0) * CFrame.Angles(0, math.rad(90), 0)
                end
                
                -- 同时调整手臂部件大小
                local leftUpperArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
                local rightUpperArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
                
                if leftUpperArm then
                    leftUpperArm.Size = Vector3.new(1 * size, 2 * size, 1 * size)
                    leftUpperArm.CanCollide = false
                end
                
                if rightUpperArm then
                    rightUpperArm.Size = Vector3.new(1 * size, 2 * size, 1 * size)
                    rightUpperArm.CanCollide = false
                end
                
                print("✅ 已修改 " .. selectedPlayer.Name .. " 的手臂大小为: " .. size)
            else
                print("❌ 找不到Humanoid")
            end
        else
            print("❌ 玩家 " .. selectedPlayer.Name .. " 没有角色")
        end
    else
        print("⚠️ 请先选择玩家！")
    end
end)

-- ========== 修改其他玩家腿部大小 ==========
tool:Textbox("修改他人腿部大小", "otherLegSize", "请输入文本", function(size)
    if selectedPlayer then
        local char = selectedPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                size = tonumber(size) or 1
                size = math.clamp(size, 0.5, 50)
                
                -- 使用Humanoid的Scale属性
                humanoid.LeftLegScale.Value = size
                humanoid.RightLegScale.Value = size
                
                -- 调整hip高度避免腿部卡地面
                humanoid.HipHeight = 0.5 * size
                
                -- 调整步行速度以匹配腿部大小
                humanoid.WalkSpeed = 16 * math.sqrt(size)
                
                -- 调整腿部连接点位置，让腿部"弹出来"
                local leftHip = char:FindFirstChild("Left Hip") or char:FindFirstChild("UpperTorso"):FindFirstChild("LeftHip")
                local rightHip = char:FindFirstChild("Right Hip") or char:FindFirstChild("UpperTorso"):FindFirstChild("RightHip")
                
                if leftHip then
                    -- 将左腿向外推，避免与身体挤压
                    leftHip.C0 = CFrame.new(-0.5 * size, -1 * size, 0) * CFrame.Angles(0, -math.rad(90), 0)
                end
                
                if rightHip then
                    -- 将右腿向外推，避免与身体挤压
                    rightHip.C0 = CFrame.new(0.5 * size, -1 * size, 0) * CFrame.Angles(0, math.rad(90), 0)
                end
                
                -- 同时调整腿部部件大小
                local leftUpperLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
                local rightUpperLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
                
                if leftUpperLeg then
                    leftUpperLeg.Size = Vector3.new(1 * size, 2 * size, 1 * size)
                    leftUpperLeg.CanCollide = true
                end
                
                if rightUpperLeg then
                    rightUpperLeg.Size = Vector3.new(1 * size, 2 * size, 1 * size)
                    rightUpperLeg.CanCollide = true
                end
                
                print("✅ 已修改 " .. selectedPlayer.Name .. " 的腿部大小为: " .. size)
                print("📊 步行速度调整为: " .. humanoid.WalkSpeed)
            else
                print("❌ 找不到Humanoid")
            end
        else
            print("❌ 玩家 " .. selectedPlayer.Name .. " 没有角色")
        end
    else
        print("⚠️ 请先选择玩家！")
    end
end)

-- ========== 重置其他玩家身体大小 ==========
tool:Textbox("重置他人身体大小", "resetOtherSize", "输入1重置", function(value)
    if value == "1" then
        if selectedPlayer then
            local char = selectedPlayer.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    -- 重置Humanoid缩放
                    humanoid.BodyDepthScale.Value = 1
                    humanoid.BodyHeightScale.Value = 1
                    humanoid.BodyWidthScale.Value = 1
                    humanoid.HeadScale.Value = 1
                    humanoid.LeftArmScale.Value = 1
                    humanoid.RightArmScale.Value = 1
                    humanoid.LeftLegScale.Value = 1
                    humanoid.RightLegScale.Value = 1
                    
                    -- 重置物理参数
                    humanoid.HipHeight = 0
                    humanoid.WalkSpeed = 16
                    humanoid.JumpPower = 50
                    
                    -- 重置连接点位置
                    local leftShoulder = char:FindFirstChild("Left Shoulder") or char:FindFirstChild("UpperTorso"):FindFirstChild("LeftShoulder")
                    local rightShoulder = char:FindFirstChild("Right Shoulder") or char:FindFirstChild("UpperTorso"):FindFirstChild("RightShoulder")
                    local leftHip = char:FindFirstChild("Left Hip") or char:FindFirstChild("UpperTorso"):FindFirstChild("LeftHip")
                    local rightHip = char:FindFirstChild("Right Hip") or char:FindFirstChild("UpperTorso"):FindFirstChild("RightHip")
                    
                    if leftShoulder then
                        leftShoulder.C0 = CFrame.new(-0.5, 0.5, 0) * CFrame.Angles(0, -math.rad(90), 0)
                    end
                    if rightShoulder then
                        rightShoulder.C0 = CFrame.new(0.5, 0.5, 0) * CFrame.Angles(0, math.rad(90), 0)
                    end
                    if leftHip then
                        leftHip.C0 = CFrame.new(-0.5, -1, 0) * CFrame.Angles(0, -math.rad(90), 0)
                    end
                    if rightHip then
                        rightHip.C0 = CFrame.new(0.5, -1, 0) * CFrame.Angles(0, math.rad(90), 0)
                    end
                    
                    -- 重置部件大小
                    local parts = {
                        "Head",
                        "Torso", "UpperTorso", "LowerTorso",
                        "Left Arm", "Right Arm", 
                        "LeftUpperArm", "RightUpperArm",
                        "Left Leg", "Right Leg",
                        "LeftUpperLeg", "RightUpperLeg"
                    }
                    
                    for _, partName in ipairs(parts) do
                        local part = char:FindFirstChild(partName)
                        if part then
                            if partName == "Head" then
                                part.Size = Vector3.new(2, 1, 1)
                            elseif partName == "Torso" or partName == "UpperTorso" then
                                part.Size = Vector3.new(2, 2, 1)
                            elseif partName:find("Arm") then
                                part.Size = Vector3.new(1, 2, 1)
                            elseif partName:find("Leg") then
                                part.Size = Vector3.new(1, 2, 1)
                            end
                            part.CanCollide = false
                        end
                    end
                    
                    print("✅ 已重置 " .. selectedPlayer.Name .. " 的身体大小")
                else
                    print("❌ 找不到Humanoid")
                end
            else
                print("❌ 玩家 " .. selectedPlayer.Name .. " 没有角色")
            end
        else
            print("⚠️ 请先选择玩家！")
        end
    end
end)

print("======================================")
print("🎮 其他玩家身体修改器已加载！")
print("📋 使用说明：")
print("  1. 从下拉菜单选择要修改的玩家")
print("  2. 点击'刷新玩家列表'更新在线玩家")
print("  3. 使用对应功能修改玩家身体部位")
print("  4. 输入'1'重置选中玩家的身体")
print("======================================")

local creds = window:Tab("传送和甩飞",'6035145364')

local tool = creds:section("传送甩飞",true)

-- 玩家列表管理
local playerList = {}
local playernamedied = ""
local RunService = game:GetService("RunService")

-- 创建玩家下拉框函数
local function createPlayerDropdown()
    playerList = {}
    for i, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            table.insert(playerList, v.Name)
        end
    end
    
    tool:Dropdown("选择玩家", "", playerList, function(selectedPlayer)
        if selectedPlayer and selectedPlayer ~= "" then
            playernamedied = selectedPlayer
            print("已选择玩家: " .. selectedPlayer)
        end
    end)
end

createPlayerDropdown()

-- 玩家加入/离开事件
game:GetService("Players").PlayerAdded:Connect(function(player)
    wait(1)
    createPlayerDropdown()
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    createPlayerDropdown()
end)

tool:Button("刷新玩家列表", function()
    createPlayerDropdown()
end)

-- 传送功能
tool:Button("传送到玩家旁边", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Notify("光脚本", "已经传送到玩家身边", "rbxassetid://", 5)
    else
        Notify("光脚本", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

tool:Button("把玩家传送过来", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        tp_player.Character.HumanoidRootPart.CFrame = HumRoot.CFrame + Vector3.new(0, 3, 0)
        Notify("光脚本", "已传送过来", "rbxassetid://", 5)
    else
        Notify("光脚本", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

-- 锁定传送功能
tool:Toggle("锁定传送", 'LockTPToggle', false, function(state)
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
        
        Notify("光脚本", "锁定传送已开启", "rbxassetid://", 5)
    else
        if connection then
            connection:Disconnect()
        end
        Notify("光脚本", "锁定传送已关闭", "rbxassetid://", 5)
    end
end)

-- 循环传送功能
tool:Toggle("循环把玩家传送过来", 'LoopTPToggle', false, function(state)
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
        
        Notify("光脚本", "循环传送已开启", "rbxassetid://", 5)
    else
        if connection then
            connection:Disconnect()
        end
        Notify("光脚本", "循环传送已关闭", "rbxassetid://", 5)
    end
end)

-- 查看玩家功能
tool:Toggle("查看玩家", 'SpectateToggle', false, function(state)
    if state then
        local targetPlayer = game:GetService('Players'):FindFirstChild(playernamedied)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
            game:GetService('Workspace').CurrentCamera.CameraSubject = targetPlayer.Character.Humanoid
            Notify("光脚本", "已开启查看玩家", "rbxassetid://", 5)
        else
            Notify("光脚本", "无法查看玩家", "rbxassetid://", 5)
        end
    else
        local lp = game.Players.LocalPlayer
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            game:GetService('Workspace').CurrentCamera.CameraSubject = lp.Character.Humanoid
        end
        Notify("光脚本", "已关闭查看玩家", "rbxassetid://", 5)
    end
end)

-- 甩飞玩家功能
tool:Button("甩飞一次选中的人", function()
    local Player = game:GetService("Players").LocalPlayer
    local TargetPlayer = game.Players:FindFirstChild(playernamedied)
    if not TargetPlayer or TargetPlayer == Player then
        Notify("光脚本", "无玩家可甩飞", "rbxassetid://", 5)
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
            return Message("光脚本", "玩家已趋势", 2)
        end
        if THumanoid.Sit then return Message("光脚本", "目标处于坐姿", 2) end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then return Message("光脚本", "玩家已趋势", 2) end

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
            return Message("光脚本", "玩家已趋势", 2)
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
        Message("光脚本", "已甩飞选中玩家", 2)
    end

    if TargetPlayer.UserId ~= 1414978355 then
        SkidFling(TargetPlayer)
    else
        Message("光脚本", "该玩家存在甩飞名单", 2)
    end
end)

-- 循环甩飞功能
tool:Toggle("循环甩飞", 'LoopFlingToggle', false, function(state)
    getgenv().LoopFlingEnabled = state
    local isRunning = false
 
    local function performFling()
        if not getgenv().LoopFlingEnabled or not playernamedied or playernamedied == "" or isRunning then
            return
        end
        
        local selectedPlayer = game.Players:FindFirstChild(playernamedied)
        if not selectedPlayer or selectedPlayer == game.Players.LocalPlayer then
            Notify("光脚本", "无玩家可甩飞", "rbxassetid://", 2)
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
            Notify("光脚本", "无玩家可甩飞", "rbxassetid://", 2)
            isRunning = false
            return
        end
        if THumanoid.Sit then
            Notify("光脚本", "目标处于坐姿", "rbxassetid://", 2)
            isRunning = false
            return
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            Notify("光脚本", "玩家已趋势", "rbxassetid://", 2)
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
        Notify("光脚本", "循环甩飞已开启", "rbxassetid://", 2)
    else
        Notify("光脚本", "循环甩飞已关闭", "rbxassetid://", 2)
    end
end)

-- 甩飞所有人功能
tool:Button("甩飞所有人", function()
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local hasPlayers = false
    
    -- 检查是否有其他玩家
    for _,x in next, Players:GetPlayers() do
        if x ~= Player then
            hasPlayers = true
            break
        end
    end
    
    if not hasPlayers then
        Notify("光脚本", "无玩家可以甩飞", "rbxassetid://", 2)
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
                return Notify("光脚本", "玩家已趋势", "rbxassetid://", 2)
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
            return Notify("光脚本", "随机错误", "rbxassetid://", 2)
        end
    end

    -- 甩飞所有玩家
    for _,x in next, Players:GetPlayers() do
        if x ~= Player then
            if x.UserId ~= 1414978355 then
                SkidFling(x)
            else
                Notify("光脚本", "玩家 " .. x.Name .. " 存在甩飞名单", "rbxassetid://", 2)
            end
        end
    end
    
    Notify("光脚本", "已开始甩飞所有人", "rbxassetid://", 2)
end)

local creds = window:Tab("指令挂",'6035145364')

local tool = creds:section("指令",true)

tool:Button("指令脚本", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))()
end)

tool:Label("bang能够掀人")
tool:Label("noface没有脸")
tool:Label("headsit坐在玩家头上加玩家名字")
tool:Label("float悬浮")
tool:Label("re重置人物但位置不变")
tool:Label("dance跳舞")
tool:Label("nolegs没有腿")
tool:Label("walltp碰到墙壁传送到墙壁顶部")
tool:Label("bring+玩家名字可以让玩家吸到你手上但是只能用于一些服务器")
tool:Label("carpet趴着走")
tool:Label("infjump无限跳跃")
tool:Label("xray透视地图所有物体变透明")
tool:Label("bang玩家开头两个英文吸在玩家身后")
tool:Label("noanim没有动作")
tool:Label("spin人物旋转")
tool:Label("sitwalk坐着走")
tool:Label("trip让你的人物摔倒")
tool:Label("antikick防踢")
tool:Label("lay躺下")
tool:Label("sit坐")
tool:Label("god加血")
tool:Label("invisfling配合加血可以旋转")
tool:Label("goto+玩家名字传送")
tool:Label("unxray关闭透视")
tool:Label("noclip穿墙")
tool:Label("有的可能不能用")
tool:Label("念力")

tool:Button("获取念力工具", function()
  loadstring(game:HttpGet([[https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Mindpower.lua]]))()
end)

tool:Label("Q - 靠近")
tool:Label("E - 离远")
tool:Label("Y - 投掷")
tool:Label("J - 超级投掷")
tool:Label("U - 使物体自转")
tool:Label("P - 使物体悬浮在空中")
tool:Label("X - 走得更远一点")
tool:Label("L - 使方块变直并锁定在前部")

tool:Button("让手上的道具飘起来", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/WmD8MuSx"))()
end)

tool:Label("J-飞起来")
tool:Label("K-回到手中")

local creds = window:Tab("FE",'6035145364')

local tool = creds:section("FE",true)

tool:Button("FE C00lgui", function()
    loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)

tool:Button("FE 1x1x1x1", function()
    loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()
end)

tool:Button("FE 蜘蛛侠", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E5%A4%B1%E8%B4%A5%E7%9A%84%E6%85%A2.txt"))()
end)

tool:Button("FE大长腿", function()
    loadstring(game:HttpGet('https://gist.githubusercontent.com/1BlueCat/7291747e9f093555573e027621f08d6e/raw/23b48f2463942befe19d81aa8a06e3222996242c/FE%2520Da%2520Feets'))()
end)

tool:Button("FE用头", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/BK4Q0DfU"))()
end)

tool:Button("复仇者", function()
    loadstring(game:HttpGet(('https://pastefy.ga/iGyVaTvs/raw'),true))()
end)

tool:Button("鼠标", function()
    loadstring(game:HttpGet(('https://pastefy.ga/V75mqzaz/raw'),true))()
end)

tool:Button("变怪物", function()
    loadstring(game:HttpGetAsync("https://pastebin.com/raw/jfryBKds"))()
end)

tool:Button("香蕉枪", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()
end)

tool:Button("超长鸡巴", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ESWSFND7", true))()
end)

tool:Button("操人", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/AHAJAJAKAK/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A.LUA", true))()
end)

tool:Button("FE动画中心", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
end)

tool:Button("FE变玩家", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()
end)

tool:Button("FE猫娘R63", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua"))()
end)

tool:Button("FE", function()
    loadstring(game:HttpGet('https://pastefy.ga/a7RTi4un/raw'))()
end)

local creds = window:Tab("音乐",'6035145364')

local tool = creds:section("😏😏",true)

tool:Button("关闭音乐", function()
    for _, sound in pairs(game.Workspace:GetChildren()) do
        if sound:IsA("Sound") then
            sound:Stop()
            sound:Destroy()
        end
    end
end)

tool:Button("🇨🇳义勇军进行曲🇨🇳", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1845918434"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("roblox国歌", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://142376088"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("奥比，但你是跑酷大师😏", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1837879082"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("轻松的场景", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1848354536"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("牢大", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://99519218846428"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("挺燃的音乐", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://99409598156364"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("恐怖音乐", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://755443523226610"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("男娘专听", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6797864253"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("刀马", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://98337901681441"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("雨中女郎", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://168311083931"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("生活小妙招", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://121336636707861"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("阳光彩虹小白马", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://94625860335523"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("植物大战僵尸",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://158260415" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("早安越南",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8295016126" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("愤怒芒西 Evade?",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://5029269312" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("梅西",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://7354576319" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("永春拳",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1845973140" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("带劲的音乐",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://18841891575" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("韩国国歌",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1837478300" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("哥哥你女朋友不会吃醋吧?",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8715811379" 
     sound.Parent = game.Workspace 
     sound:Play()  
     end) 
      tool:Button("蜘蛛侠出场声音",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://9108472930" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
      tool:Button("消防车",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://317455930" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
      tool:Button("万圣节1🎃",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1837467198" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end)
     
   tool:Button("好听的",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1844125168" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
 tool:Button("国外音乐脚本",function()          
 loadstring(game:HttpGet(('https://pastebin.com/raw/g97RafnE'),true))()                   
end) 
   tool:Button("国歌[Krx版]",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1845918434" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("妈妈生的",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6689498326" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("Music Ball-CTT",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://9045415830" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("电音",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6911766512" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("梗合集",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8161248815" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("Its been so long",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6913550990" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("Baller",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://13530439660" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end)

local creds = window:Tab("俄亥俄",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("查找放下来印钞机","", false, function(v)
czycj = v
if czycj then
while czycj and wait() do
local Players=game:GetService("Players")local localPlayer=Players.LocalPlayer local droppables=workspace.Game.Local.droppables if droppables and droppables:FindFirstChild("Money Printer")then local unusualMoneyPrinter=droppables:FindFirstChild("Money Printer")for _,child in pairs(unusualMoneyPrinter:GetChildren())do if child:IsA("MeshPart")then local humanoidRootPart=localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")if humanoidRootPart then humanoidRootPart.CFrame=CFrame.new(child.Position)end end end end
end
end
end)
tool:Toggle("自动拾取材料", "auto", false, function(v)
autocl = v
end)
tool:Toggle("自动拾取宝石", "auto", false, function(v)
autobs = v
if autobs then
while autobs and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Amethyst" or e.ObjectText == "Sapphire" or e.ObjectText == "Emerald"  or e.ObjectText == "Topaz"  or e.ObjectText == "Ruby"  or e.ObjectText == "Diamond Ring"  or e.ObjectText == "Diamond" or e.ObjectText == "Void Gem" or e.ObjectText == "Dark Matter Gem" or e.ObjectText == "Rollie" then
                                for _, obj in ipairs(workspace.BankRobbery.VaultDoor:GetDescendants()) do
                                if obj:IsA("ProximityPrompt") then
                                if (obj.Parent.Position - rootPart.Position).Magnitude > 35 then
                                obj.RequiresLineOfSight = false
                                obj.HoldDuration = 0
                                fireproximityprompt(obj)
                                end
                                end
                                end
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)

tool:Toggle("自动拾取气球", "auto", false, function(v)
autoqq = v
if autoqq then
while autoqq and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Bunny Balloon" or e.ObjectText == "Ghost Balloon" or e.ObjectText == "Clover Balloon" or e.ObjectText == "Bat Balloon" or e.ObjectText == "Gold Clover Balloon" or e.ObjectText == "Golden Rose" or e.ObjectText == "Black Rose" or e.ObjectText == "Heart Balloon" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)
tool:Toggle("自动拾取蓝色糖果棒", "auto", false, function(v)
autoblue = v
if autoblue then
while autoblue and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Blue Candy Cane" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)

tool:Toggle("自动拾取顶级物品", "auto", false, function(v)
autodj = v
if autodj then
while autodj and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Suitcase Nuke" or e.ObjectText == "Nuke Launcher" or e.ObjectText == "Easter Basket" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)
tool:Toggle("自动拾取金条", "auto", false, function(v)
autojt = v
if autojt then
while autojt and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" and e.ObjectText == "Gold Bar" then
                                for _, obj in ipairs(workspace.BankRobbery.VaultDoor:GetDescendants()) do
                                if obj:IsA("ProximityPrompt") then
                                if (obj.Parent.Position - rootPart.Position).Magnitude > 35 then
                                obj.RequiresLineOfSight = false
                                obj.HoldDuration = 0
                                fireproximityprompt(obj)
                                end
                                end
                                end
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)

tool:Toggle("自动拾取红卡", "auto", false, function(v)
autohk = v
if autohk then
while autohk and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Military Armory Keycard" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)
tool:Toggle("自动拾取印钞机", "auto", false, function(v)
automn = v
if automn then
while automn and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Money Printer" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)

tool:Button("俄亥俄州1英",function()
loadstring(game:HttpGet("https://pastebin.com/raw/0MqfXpvY", true))()
end)

tool:Button("俄亥俄州",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
end)

tool:Button("俄亥俄州2英",function()
loadstring(game:HttpGet('https://pastebin.com/raw/MyfCUnGK'))()
end)

tool:Button("俄亥俄州3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rxn-xyz/Ohio./main/Ohio.lua",true))()
end)

tool:Button("俄亥俄州4",function()
loadstring(game:HttpGet("https://pastefy.app/QbXPfsgC/raw"))()
end)

tool:Button("俄亥俄州5",function()
loadstring(game:HttpGet("https://pastebin.com/raw/hkvHeHed",true))()
end)

tool:Button("指令",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/longshulol/long/main/longshu/Ohio"))()
end)



tool:Label("在聊天框输入")
tool:Label("透开—透关")
tool:Label("追踪开—追踪关")
tool:Label("收钱开—收钱关")
tool:Label("收物开—收物关")
tool:Label("抢取款机开—抢取款机关")
tool:Label("抢银行开—抢银行关")
tool:Label("穿墙开—穿墙关")

local creds = window:Tab("特效",'6035145364')

local tool = creds:section("特效",true)

tool:Button("金色吐息",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    -- 检查是否已经存在该道具
    local existingTool = backpack:FindFirstChild("吐息")
    if existingTool then
        existingTool:Destroy()
    end
    
    -- 创建工具
    local tool = Instance.new("Tool")
    tool.Name = "特效"
    tool.ToolTip = "点击右侧按钮释放特效"
    tool.CanBeDropped = false
    tool.Parent = backpack
    
    -- 创建手柄
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.Material = Enum.Material.Plastic
    handle.BrickColor = BrickColor.new("Bright blue")
    handle.Transparency = 0
    handle.CanCollide = false
    handle.Parent = tool
    
    -- 使用模型ID 1865599543
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshId = "rbxassetid://1865599543"
    mesh.TextureId = "rbxassetid://1865599544"
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = handle
    
    -- 存储所有攻击特效的表格
    local activeProjectiles = {}
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AttackButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "ReleaseButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.7, 0) -- 屏幕右侧
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- 蓝色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "释放"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local releaseButton = Instance.new("TextButton")
    releaseButton.Name = "ReleaseButton"
    releaseButton.Size = UDim2.new(1, 0, 1, 0)
    releaseButton.BackgroundTransparency = 1
    releaseButton.Text = ""
    releaseButton.Parent = buttonFrame
    
    -- 发射攻击特效的函数
    local function shootAttack()
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local camera = workspace.CurrentCamera
        
        -- 计算发射方向（使用相机朝向）
        local startPosition = humanoidRootPart.Position + Vector3.new(0, 1.5, 0) -- 从角色头部高度发射
        local direction = camera.CFrame.LookVector -- 使用相机朝向
        
        -- 创建黄色长方形攻击特效
        local attackProjectile = Instance.new("Part")
        attackProjectile.Name = "YellowAttack"
        attackProjectile.Size = Vector3.new(0.3, 0.3, 2) -- 长方形尺寸
        attackProjectile.BrickColor = BrickColor.new("Bright yellow")
        attackProjectile.Material = Enum.Material.Neon
        attackProjectile.Shape = Enum.PartType.Block
        attackProjectile.Anchored = false -- 不锚定，使用物理
        attackProjectile.CanCollide = true
        attackProjectile.CFrame = CFrame.lookAt(startPosition, startPosition + direction * 10)
        attackProjectile.Parent = workspace
        
        -- 添加发光效果
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 8
        pointLight.Range = 12
        pointLight.Color = Color3.new(1, 1, 0) -- 黄色
        pointLight.Parent = attackProjectile
        
        -- 添加粒子效果
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.5, 1)
        particleEmitter.Rate = 30
        particleEmitter.SpreadAngle = Vector2.new(10, 10)
        particleEmitter.Speed = NumberRange.new(2, 5)
        particleEmitter.Color = ColorSequence.new(Color3.new(1, 1, 0)) -- 黄色
        particleEmitter.Parent = attackProjectile
        
        -- 添加物理速度
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = direction * 80 -- 发射速度
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = attackProjectile
        
        -- 存储到活跃特效表
        table.insert(activeProjectiles, attackProjectile)
        
        -- 永不消失，但可以手动清理
        attackProjectile.Touched:Connect(function(hit)
            -- 碰到物体时产生特效但不消失
            createHitEffect(attackProjectile.Position)
        end)
        
        return attackProjectile
    end
    
    -- 创建击中效果函数
    local function createHitEffect(position)
        local explosion = Instance.new("Part")
        explosion.Size = Vector3.new(2, 2, 2)
        explosion.BrickColor = BrickColor.new("Bright yellow")
        explosion.Material = Enum.Material.Neon
        explosion.Anchored = true
        explosion.CanCollide = false
        explosion.Position = position
        explosion.Shape = Enum.PartType.Ball
        explosion.Parent = workspace
        
        local explosionLight = Instance.new("PointLight")
        explosionLight.Brightness = 15
        explosionLight.Range = 8
        explosionLight.Color = Color3.new(1, 1, 0)
        explosionLight.Parent = explosion
        
        -- 1秒后消失
        game:GetService("Debris"):AddItem(explosion, 1)
    end
    
    -- 持续发射控制
    local isShooting = false
    local shootConnection
    
    -- 开始持续发射
    local function startContinuousShooting()
        if isShooting then return end
        
        isShooting = true
        print("开始持续发射攻击特效")
        
        -- 按钮变为绿色表示激活
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        shootConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isShooting then return end
            
            -- 每次心跳发射一个特效
            shootAttack()
        end)
    end
    
    -- 停止持续发射
    local function stopContinuousShooting()
        isShooting = false
        if shootConnection then
            shootConnection:Disconnect()
            shootConnection = nil
        end
        -- 按钮恢复蓝色
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        print("停止发射攻击特效")
    end
    
    -- 清理所有特效
    local function clearAllProjectiles()
        for i, projectile in ipairs(activeProjectiles) do
            if projectile and projectile.Parent then
                projectile:Destroy()
            end
        end
        activeProjectiles = {}
        print("已清理所有攻击特效")
    end
    
    -- 圆形按钮点击事件
    releaseButton.MouseButton1Down:Connect(function()
        if backpack:FindFirstChild("道具") then
            startContinuousShooting()
        end
    end)
    
    -- 圆形按钮松开事件
    releaseButton.MouseButton1Up:Connect(function()
        stopContinuousShooting()
    end)
    
    -- 工具激活事件（手持时点击）
    tool.Activated:Connect(function()
        if tool.Parent == player.Character then
            startContinuousShooting()
        end
    end)
    
    -- 工具取消激活事件
    tool.Deactivated:Connect(function()
        stopContinuousShooting()
    end)
    
    -- 工具装备事件
    tool.Equipped:Connect(function()
        print("道具已装备在手上")
    end)
    
    -- 工具卸载事件
    tool.Unequipped:Connect(function()
        stopContinuousShooting()
        print("道具已放下")
    end)
    
    -- 添加清理按钮
    tool:Button("清理特效", function()
        clearAllProjectiles()
    end)
    
    -- 自动清理远离的特效（防止过多积累）
    game:GetService("RunService").Heartbeat:Connect(function()
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        for i = #activeProjectiles, 1, -1 do
            local projectile = activeProjectiles[i]
            if projectile and projectile.Parent then
                -- 如果特效距离玩家超过200米，自动清理
                local distance = (projectile.Position - humanoidRootPart.Position).Magnitude
                if distance > 200 then
                    projectile:Destroy()
                    table.remove(activeProjectiles, i)
                end
            else
                table.remove(activeProjectiles, i)
            end
        end
    end)
    
    print("攻击道具已添加！点击右侧圆形'释放'按钮即可发射特效")
    print("按住按钮持续发射，松开停止")
end)

tool:Button("火焰翅膀",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    -- 检查是否已经存在翅膀
    if _G.FireWings then
        _G.FireWings:Destroy()
        _G.FireWings = nil
    end
    
    -- 在屏幕右侧创建圆形开关按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WingsButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "WingsToggle"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.5, 0) -- 屏幕右侧中间
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- 蓝色（关闭状态）
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = ""
    toggleButton.Parent = buttonFrame
    
    -- 翅膀状态
    local wingsEnabled = false
    local fireWings = nil
    
    -- 创建火焰翅膀函数
    local function createFireWings()
        local character = player.Character
        if not character then return nil end
        
        -- 创建翅膀模型
        local wings = Instance.new("Model")
        wings.Name = "FireWings"
        
        -- 左翅膀（完全透明）
        local leftWing = Instance.new("Part")
        leftWing.Name = "LeftWing"
        leftWing.Size = Vector3.new(0.2, 3, 1.5)
        leftWing.BrickColor = BrickColor.new("Bright red")
        leftWing.Material = Enum.Material.Neon
        leftWing.Transparency = 1  -- 完全透明
        leftWing.Anchored = false
        leftWing.CanCollide = false
        leftWing.Parent = wings
        
        -- 右翅膀（完全透明）
        local rightWing = Instance.new("Part")
        rightWing.Name = "RightWing"
        rightWing.Size = Vector3.new(0.2, 3, 1.5)
        rightWing.BrickColor = BrickColor.new("Bright red")
        rightWing.Material = Enum.Material.Neon
        rightWing.Transparency = 1  -- 完全透明
        rightWing.Anchored = false
        rightWing.CanCollide = false
        rightWing.Parent = wings
        
        -- 连接到角色背部
        local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
        if torso then
            -- 左翅膀连接
            local leftWeld = Instance.new("Weld")
            leftWeld.Part0 = torso
            leftWeld.Part1 = leftWing
            leftWeld.C0 = CFrame.new(-1.5, 0.5, -0.5) * CFrame.Angles(0, math.rad(45), 0)
            leftWeld.Parent = leftWing
            
            -- 右翅膀连接
            local rightWeld = Instance.new("Weld")
            rightWeld.Part0 = torso
            rightWeld.Part1 = rightWing
            rightWeld.C0 = CFrame.new(1.5, 0.5, -0.5) * CFrame.Angles(0, math.rad(-45), 0)
            rightWeld.Parent = rightWing
        end
        
        -- 添加火焰特效到左翅膀
        local leftFire = Instance.new("Fire")
        leftFire.Size = 12  -- 增大火焰尺寸
        leftFire.Heat = 8   -- 增加热量
        leftFire.Color = Color3.new(1, 0.2, 0) -- 更深的橙色
        leftFire.SecondaryColor = Color3.new(1, 0.8, 0) -- 亮黄色
        leftFire.Parent = leftWing
        
        local leftPointLight = Instance.new("PointLight")
        leftPointLight.Brightness = 15  -- 增加亮度
        leftPointLight.Range = 12       -- 增加范围
        leftPointLight.Color = Color3.new(1, 0.4, 0)
        leftPointLight.Parent = leftWing
        
        -- 添加火焰特效到右翅膀
        local rightFire = Instance.new("Fire")
        rightFire.Size = 12  -- 增大火焰尺寸
        rightFire.Heat = 8   -- 增加热量
        rightFire.Color = Color3.new(1, 0.2, 0) -- 更深的橙色
        rightFire.SecondaryColor = Color3.new(1, 0.8, 0) -- 亮黄色
        rightFire.Parent = rightWing
        
        local rightPointLight = Instance.new("PointLight")
        rightPointLight.Brightness = 15  -- 增加亮度
        rightPointLight.Range = 12       -- 增加范围
        rightPointLight.Color = Color3.new(1, 0.4, 0)
        rightPointLight.Parent = rightWing
        
        -- 添加粒子效果
        local leftSmoke = Instance.new("Smoke")
        leftSmoke.Size = 0.8  -- 增大烟雾
        leftSmoke.Opacity = 0.4
        leftSmoke.RiseVelocity = 8
        leftSmoke.Color = Color3.new(0.4, 0.1, 0)
        leftSmoke.Parent = leftWing
        
        local rightSmoke = Instance.new("Smoke")
        rightSmoke.Size = 0.8  -- 增大烟雾
        rightSmoke.Opacity = 0.4
        rightSmoke.RiseVelocity = 8
        rightSmoke.Color = Color3.new(0.4, 0.1, 0)
        rightSmoke.Parent = rightWing
        
        -- 添加火花粒子
        local leftSparkles = Instance.new("Sparkles")
        leftSparkles.SparkleColor = Color3.new(1, 0.6, 0)
        leftSparkles.Parent = leftWing
        
        local rightSparkles = Instance.new("Sparkles")
        rightSparkles.SparkleColor = Color3.new(1, 0.6, 0)
        rightSparkles.Parent = rightWing
        
        -- 添加额外的火焰粒子发射器
        local leftParticleEmitter = Instance.new("ParticleEmitter")
        leftParticleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        leftParticleEmitter.Lifetime = NumberRange.new(0.5, 1.5)
        leftParticleEmitter.Rate = 50
        leftParticleEmitter.SpreadAngle = Vector2.new(30, 30)
        leftParticleEmitter.Speed = NumberRange.new(2, 8)
        leftParticleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 0.3, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.8, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(1, 0.2, 0))
        })
        leftParticleEmitter.Parent = leftWing
        
        local rightParticleEmitter = Instance.new("ParticleEmitter")
        rightParticleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        rightParticleEmitter.Lifetime = NumberRange.new(0.5, 1.5)
        rightParticleEmitter.Rate = 50
        rightParticleEmitter.SpreadAngle = Vector2.new(30, 30)
        rightParticleEmitter.Speed = NumberRange.new(2, 8)
        rightParticleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 0.3, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.8, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(1, 0.2, 0))
        })
        rightParticleEmitter.Parent = rightWing
        
        wings.Parent = character
        return wings
    end
    
    -- 翅膀动画效果
    local function animateWings()
        if not wingsEnabled or not fireWings then return end
        
        coroutine.wrap(function()
            while wingsEnabled and fireWings and fireWings.Parent do
                local leftWing = fireWings:FindFirstChild("LeftWing")
                local rightWing = fireWings:FindFirstChild("RightWing")
                
                if leftWing and rightWing then
                    -- 轻微的翅膀扇动动画
                    local leftWeld = leftWing:FindFirstChildOfClass("Weld")
                    local rightWeld = rightWing:FindFirstChildOfClass("Weld")
                    
                    if leftWeld and rightWeld then
                        -- 翅膀扇动
                        for i = 1, 10 do
                            if not wingsEnabled then break end
                            leftWeld.C0 = leftWeld.C0 * CFrame.Angles(0, math.rad(1), 0)
                            rightWeld.C0 = rightWeld.C0 * CFrame.Angles(0, math.rad(-1), 0)
                            wait(0.05)
                        end
                        
                        for i = 1, 10 do
                            if not wingsEnabled then break end
                            leftWeld.C0 = leftWeld.C0 * CFrame.Angles(0, math.rad(-1), 0)
                            rightWeld.C0 = rightWeld.C0 * CFrame.Angles(0, math.rad(1), 0)
                            wait(0.05)
                        end
                    end
                end
                wait(0.5)
            end
        end)()
    end
    
    -- 切换翅膀状态
    local function toggleWings()
        if wingsEnabled then
            -- 关闭翅膀
            wingsEnabled = false
            buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- 蓝色
            buttonText.Text = "开启"
            
            if fireWings then
                fireWings:Destroy()
                fireWings = nil
            end
            
            print("火焰翅膀已关闭")
        else
            -- 开启翅膀
            wingsEnabled = true
            buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- 绿色
            buttonText.Text = "关闭"
            
            fireWings = createFireWings()
            _G.FireWings = fireWings
            
            -- 开始翅膀动画
            animateWings()
            
            print("火焰翅膀已开启")
        end
    end
    
    -- 按钮点击事件
    toggleButton.MouseButton1Click:Connect(function()
        toggleWings()
    end)
    
    -- 角色重生时重新创建翅膀
    player.CharacterAdded:Connect(function(character)
        wait(2) -- 等待角色完全加载
        if wingsEnabled then
            fireWings = createFireWings()
            _G.FireWings = fireWings
            animateWings()
        end
    end)
    
    -- 添加删除翅膀的按钮
    tool:Button("移除翅膀", function()
        if _G.FireWings then
            _G.FireWings:Destroy()
            _G.FireWings = nil
        end
        wingsEnabled = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        buttonText.Text = "开启"
        screenGui:Destroy()
        print("火焰翅膀已移除")
    end)
    
    print("火焰翅膀已添加！点击右侧圆形按钮开启/关闭")
    print("翅膀底板已透明，只显示火焰特效")
end)

tool:Button("原子吐息",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlueFireButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "BlueFireButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.3, 0) -- 屏幕右侧上方
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- 蓝色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "按住"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local fireButton = Instance.new("TextButton")
    fireButton.Name = "FireButton"
    fireButton.Size = UDim2.new(1, 0, 1, 0)
    fireButton.BackgroundTransparency = 1
    fireButton.Text = ""
    fireButton.Parent = buttonFrame
    
    -- 火焰发射状态
    local isFiring = false
    local fireConnection = nil
    
    -- 创建蓝色火焰特效函数
    local function createBlueFire()
        local character = player.Character
        if not character then return nil end
        
        local head = character:FindFirstChild("Head")
        if not head then return nil end
        
        -- 创建火焰发射器
        local fireEmitter = Instance.new("Part")
        fireEmitter.Name = "BlueFireEmitter"
        fireEmitter.Size = Vector3.new(0.1, 0.1, 0.1)
        fireEmitter.Transparency = 1  -- 完全透明
        fireEmitter.Anchored = false
        fireEmitter.CanCollide = false
        fireEmitter.Parent = character
        
        -- 连接到头部前方
        local weld = Instance.new("Weld")
        weld.Part0 = head
        weld.Part1 = fireEmitter
        weld.C0 = CFrame.new(0, 0, -1.5)  -- 头部前方
        weld.Parent = fireEmitter
        
        -- 添加蓝色火焰特效
        local blueFire = Instance.new("Fire")
        blueFire.Size = 15  -- 大尺寸火焰
        blueFire.Heat = 10  -- 高热量
        blueFire.Color = Color3.new(0.2, 0.4, 1)  -- 深蓝色
        blueFire.SecondaryColor = Color3.new(0.6, 0.8, 1)  -- 浅蓝色
        blueFire.Parent = fireEmitter
        
        -- 添加蓝色发光
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 20
        pointLight.Range = 15
        pointLight.Color = Color3.new(0.3, 0.5, 1)
        pointLight.Parent = fireEmitter
        
        -- 添加蓝色烟雾
        local blueSmoke = Instance.new("Smoke")
        blueSmoke.Size = 1.0
        blueSmoke.Opacity = 0.3
        blueSmoke.RiseVelocity = 10
        blueSmoke.Color = Color3.new(0.1, 0.2, 0.5)
        blueSmoke.Parent = fireEmitter
        
        -- 添加蓝色火花
        local blueSparkles = Instance.new("Sparkles")
        blueSparkles.SparkleColor = Color3.new(0.4, 0.6, 1)
        blueSparkles.Parent = fireEmitter
        
        -- 添加蓝色粒子发射器
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.3, 1.0)
        particleEmitter.Rate = 100  -- 高频率
        particleEmitter.SpreadAngle = Vector2.new(25, 25)
        particleEmitter.Speed = NumberRange.new(10, 20)  -- 高速发射
        particleEmitter.Rotation = NumberRange.new(0, 360)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.1, 0.3, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.4, 0.6, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.2, 0.8))
        })
        particleEmitter.Parent = fireEmitter
        
        return fireEmitter
    end
    
    -- 开始发射蓝色火焰
    local function startFiring()
        if isFiring then return end
        
        isFiring = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 255) -- 亮蓝色表示激活
        
        print("开始发射蓝色火焰")
        
        -- 创建火焰发射器
        local fireEmitter = createBlueFire()
        
        -- 持续发射效果
        fireConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isFiring or not fireEmitter or not fireEmitter.Parent then
                return
            end
            
            local character = player.Character
            if not character then return end
            
            local head = character:FindFirstChild("Head")
            if not head then return end
            
            -- 创建向前发射的蓝色火焰弹
            local fireProjectile = Instance.new("Part")
            fireProjectile.Name = "BlueFireProjectile"
            fireProjectile.Size = Vector3.new(0.5, 0.5, 2)
            fireProjectile.BrickColor = BrickColor.new("Bright blue")
            fireProjectile.Material = Enum.Material.Neon
            fireProjectile.Transparency = 0.3
            fireProjectile.Shape = Enum.PartType.Block
            fireProjectile.Anchored = false
            fireProjectile.CanCollide = false
            fireProjectile.CFrame = head.CFrame + head.CFrame.LookVector * 2
            fireProjectile.Parent = workspace
            
            -- 添加蓝色发光
            local projectileLight = Instance.new("PointLight")
            projectileLight.Brightness = 8
            projectileLight.Range = 10
            projectileLight.Color = Color3.new(0.3, 0.5, 1)
            projectileLight.Parent = fireProjectile
            
            -- 添加蓝色火焰效果
            local projectileFire = Instance.new("Fire")
            projectileFire.Size = 5
            projectileFire.Heat = 3
            projectileFire.Color = Color3.new(0.2, 0.4, 1)
            projectileFire.SecondaryColor = Color3.new(0.6, 0.8, 1)
            projectileFire.Parent = fireProjectile
            
            -- 添加蓝色粒子尾迹
            local trail = Instance.new("Trail")
            trail.Color = ColorSequence.new(Color3.new(0.2, 0.4, 1))
            trail.LightEmission = 0.8
            trail.Lifetime = 0.5
            trail.Transparency = NumberSequence.new(0.3, 0.8)
            trail.Parent = fireProjectile
            
            -- 设置发射速度（向前方）
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = head.CFrame.LookVector * 80  -- 高速向前
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Parent = fireProjectile
            
            -- 碰撞检测
            fireProjectile.Touched:Connect(function(hit)
                if hit and hit.Parent ~= character then
                    createBlueExplosion(fireProjectile.Position)
                    fireProjectile:Destroy()
                end
            end)
            
            -- 5秒后自动消失
            game:GetService("Debris"):AddItem(fireProjectile, 5)
        end)
    end
    
    -- 停止发射蓝色火焰
    local function stopFiring()
        isFiring = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- 恢复原色
        
        if fireConnection then
            fireConnection:Disconnect()
            fireConnection = nil
        end
        
        -- 移除火焰发射器
        local character = player.Character
        if character then
            local fireEmitter = character:FindFirstChild("BlueFireEmitter")
            if fireEmitter then
                fireEmitter:Destroy()
            end
        end
        
        print("停止发射蓝色火焰")
    end
    
    -- 创建蓝色爆炸效果
    local function createBlueExplosion(position)
        local explosion = Instance.new("Part")
        explosion.Size = Vector3.new(4, 4, 4)
        explosion.BrickColor = BrickColor.new("Bright blue")
        explosion.Material = Enum.Material.Neon
        explosion.Anchored = true
        explosion.CanCollide = false
        explosion.Position = position
        explosion.Shape = Enum.PartType.Ball
        explosion.Parent = workspace
        
        local explosionLight = Instance.new("PointLight")
        explosionLight.Brightness = 25
        explosionLight.Range = 12
        explosionLight.Color = Color3.new(0.3, 0.5, 1)
        explosionLight.Parent = explosion
        
        -- 爆炸粒子效果
        local explosionParticles = Instance.new("ParticleEmitter")
        explosionParticles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        explosionParticles.Lifetime = NumberRange.new(0.5, 1.5)
        explosionParticles.Rate = 200
        explosionParticles.SpreadAngle = Vector2.new(45, 45)
        explosionParticles.Speed = NumberRange.new(5, 15)
        explosionParticles.Color = ColorSequence.new(Color3.new(0.2, 0.4, 1))
        explosionParticles.Parent = explosion
        
        -- 2秒后消失
        game:GetService("Debris"):AddItem(explosion, 2)
    end
    
    -- 按钮按下事件
    fireButton.MouseButton1Down:Connect(function()
        startFiring()
    end)
    
    -- 按钮松开事件
    fireButton.MouseButton1Up:Connect(function()
        stopFiring()
    end)
    
    -- 角色重生时重置
    player.CharacterAdded:Connect(function(character)
        wait(1)
        stopFiring()
    end)
    
    -- 添加清理按钮
    tool:Button("移除火焰系统", function()
        stopFiring()
        screenGui:Destroy()
        print("蓝色火焰系统已移除")
    end)
    
    print("蓝色火焰发射器已添加！长按右侧'按住'按钮发射蓝色火焰")
end)

tool:Button("开启双色火焰",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DualFireButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "DualFireButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.3, 0) -- 屏幕右侧上方
    buttonFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 200) -- 混合色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local fireButton = Instance.new("TextButton")
    fireButton.Name = "FireButton"
    fireButton.Size = UDim2.new(1, 0, 1, 0)
    fireButton.BackgroundTransparency = 1
    fireButton.Text = ""
    fireButton.Parent = buttonFrame
    
    -- 火焰状态
    local isFireActive = false
    local leftFireEmitter = nil
    local rightFireEmitter = nil
    
    -- 创建左手蓝色火焰特效
    local function createLeftBlueFire()
        local character = player.Character
        if not character then return nil end
        
        local leftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
        if not leftHand then return nil end
        
        -- 创建蓝色火焰发射器
        local fireEmitter = Instance.new("Part")
        fireEmitter.Name = "LeftBlueFireEmitter"
        fireEmitter.Size = Vector3.new(0.1, 0.1, 0.1)
        fireEmitter.Transparency = 1
        fireEmitter.Anchored = false
        fireEmitter.CanCollide = false
        fireEmitter.Parent = character
        
        -- 连接到左手
        local weld = Instance.new("Weld")
        weld.Part0 = leftHand
        weld.Part1 = fireEmitter
        weld.C0 = CFrame.new(0, 0, 0)
        weld.Parent = fireEmitter
        
        -- 蓝色火焰特效
        local blueFire = Instance.new("Fire")
        blueFire.Size = 8
        blueFire.Heat = 8
        blueFire.Color = Color3.new(0.1, 0.3, 1)  -- 深蓝色
        blueFire.SecondaryColor = Color3.new(0.4, 0.6, 1)  -- 浅蓝色
        blueFire.Parent = fireEmitter
        
        -- 蓝色发光
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 15
        pointLight.Range = 12
        pointLight.Color = Color3.new(0.2, 0.4, 1)
        pointLight.Parent = fireEmitter
        
        -- 蓝色粒子效果
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.5, 1.2)
        particleEmitter.Rate = 50
        particleEmitter.SpreadAngle = Vector2.new(30, 30)
        particleEmitter.Speed = NumberRange.new(2, 5)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.1, 0.3, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.3, 0.5, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.2, 0.8))
        })
        particleEmitter.Parent = fireEmitter
        
        return fireEmitter
    end
    
    -- 创建右手红色火焰特效
    local function createRightRedFire()
        local character = player.Character
        if not character then return nil end
        
        local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
        if not rightHand then return nil end
        
        -- 创建红色火焰发射器
        local fireEmitter = Instance.new("Part")
        fireEmitter.Name = "RightRedFireEmitter"
        fireEmitter.Size = Vector3.new(0.1, 0.1, 0.1)
        fireEmitter.Transparency = 1
        fireEmitter.Anchored = false
        fireEmitter.CanCollide = false
        fireEmitter.Parent = character
        
        -- 连接到右手
        local weld = Instance.new("Weld")
        weld.Part0 = rightHand
        weld.Part1 = fireEmitter
        weld.C0 = CFrame.new(0, 0, 0)
        weld.Parent = fireEmitter
        
        -- 红色火焰特效
        local redFire = Instance.new("Fire")
        redFire.Size = 8
        redFire.Heat = 8
        redFire.Color = Color3.new(1, 0.2, 0.1)  -- 深红色
        redFire.SecondaryColor = Color3.new(1, 0.6, 0.3)  -- 浅红色
        redFire.Parent = fireEmitter
        
        -- 红色发光
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 15
        pointLight.Range = 12
        pointLight.Color = Color3.new(1, 0.3, 0.1)
        pointLight.Parent = fireEmitter
        
        -- 红色粒子效果
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.5, 1.2)
        particleEmitter.Rate = 50
        particleEmitter.SpreadAngle = Vector2.new(30, 30)
        particleEmitter.Speed = NumberRange.new(2, 5)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 0.2, 0.1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.4, 0.2)),
            ColorSequenceKeypoint.new(1, Color3.new(0.8, 0.1, 0.1))
        })
        particleEmitter.Parent = fireEmitter
        
        return fireEmitter
    end
    
    -- 开启双色火焰
    local function startDualFire()
        if isFireActive then return end
        
        isFireActive = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(150, 50, 150) -- 激活状态颜色
        buttonText.Text = "开启中"
        
        print("开启双色火焰特效")
        
        -- 创建双手火焰
        leftFireEmitter = createLeftBlueFire()
        rightFireEmitter = createRightRedFire()
        
        -- 持续特效更新
        local fireConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isFireActive then
                fireConnection:Disconnect()
                return
            end
            
            -- 可以在这里添加持续的特效更新逻辑
            -- 比如根据角色移动调整火焰效果等
        end)
    end
    
    -- 关闭双色火焰
    local function stopDualFire()
        if not isFireActive then return end
        
        isFireActive = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 200) -- 恢复原色
        buttonText.Text = "开启"
        
        -- 移除左手蓝色火焰
        if leftFireEmitter then
            leftFireEmitter:Destroy()
            leftFireEmitter = nil
        end
        
        -- 移除右手红色火焰
        if rightFireEmitter then
            rightFireEmitter:Destroy()
            rightFireEmitter = nil
        end
        
        print("关闭双色火焰特效")
    end
    
    -- 按钮点击事件 - 切换开启/关闭
    fireButton.MouseButton1Click:Connect(function()
        if isFireActive then
            stopDualFire()
        else
            startDualFire()
        end
    end)
    
    -- 角色重生时自动关闭火焰
    player.CharacterAdded:Connect(function(character)
        wait(1)
        stopDualFire()
    end)
    
    -- 添加清理按钮
    tool:Button("移除火焰系统", function()
        stopDualFire()
        screenGui:Destroy()
        print("双色火焰系统已移除")
    end)
    
    print("双色火焰特效已添加！点击右侧'开启'按钮切换火焰特效")
end)

tool:Button("开启头部火焰",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HeadFireButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "HeadFireButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.3, 0) -- 屏幕右侧上方
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- 蓝色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local fireButton = Instance.new("TextButton")
    fireButton.Name = "FireButton"
    fireButton.Size = UDim2.new(1, 0, 1, 0)
    fireButton.BackgroundTransparency = 1
    fireButton.Text = ""
    fireButton.Parent = buttonFrame
    
    -- 火焰状态
    local isFireActive = false
    local headFireEmitter = nil
    
    -- 创建头部蓝色火焰特效
    local function createHeadBlueFire()
        local character = player.Character
        if not character then return nil end
        
        local head = character:FindFirstChild("Head")
        if not head then return nil end
        
        -- 创建头部火焰发射器
        local fireEmitter = Instance.new("Part")
        fireEmitter.Name = "HeadBlueFireEmitter"
        fireEmitter.Size = Vector3.new(0.1, 0.1, 0.1)
        fireEmitter.Transparency = 1
        fireEmitter.Anchored = false
        fireEmitter.CanCollide = false
        fireEmitter.Parent = character
        
        -- 连接到头部上方
        local weld = Instance.new("Weld")
        weld.Part0 = head
        weld.Part1 = fireEmitter
        weld.C0 = CFrame.new(0, 0.8, 0) -- 头部上方
        weld.Parent = fireEmitter
        
        -- 小型蓝色火焰特效
        local blueFire = Instance.new("Fire")
        blueFire.Size = 4  -- 较小的尺寸
        blueFire.Heat = 5  -- 适中的热量
        blueFire.Color = Color3.new(0.1, 0.3, 1)  -- 深蓝色
        blueFire.SecondaryColor = Color3.new(0.4, 0.6, 1)  -- 浅蓝色
        blueFire.Parent = fireEmitter
        
        -- 蓝色发光（较小范围）
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 8  -- 较低的亮度
        pointLight.Range = 8       -- 较小的范围
        pointLight.Color = Color3.new(0.2, 0.4, 1)
        pointLight.Parent = fireEmitter
        
        -- 小型蓝色粒子效果
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.3, 0.8)  -- 较短的生命周期
        particleEmitter.Rate = 30  -- 较少的粒子数量
        particleEmitter.SpreadAngle = Vector2.new(15, 15)  -- 较小的扩散角度
        particleEmitter.Speed = NumberRange.new(1, 3)  -- 较慢的速度
        particleEmitter.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.5),
            NumberSequenceKeypoint.new(1, 0.1)
        })
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.1, 0.3, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.3, 0.5, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.2, 0.8))
        })
        particleEmitter.Parent = fireEmitter
        
        -- 添加小型蓝色火花效果
        local blueSparkles = Instance.new("Sparkles")
        blueSparkles.SparkleColor = Color3.new(0.3, 0.5, 1)
        blueSparkles.Parent = fireEmitter
        
        return fireEmitter
    end
    
    -- 开启头部火焰
    local function startHeadFire()
        if isFireActive then return end
        
        isFireActive = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 255) -- 激活状态亮蓝色
        buttonText.Text = "开启中"
        
        print("开启头部蓝色火焰特效")
        
        -- 创建头部火焰
        headFireEmitter = createHeadBlueFire()
        
        -- 持续特效更新
        local fireConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isFireActive then
                fireConnection:Disconnect()
                return
            end
            
            -- 可以在这里添加轻微的火焰波动效果
            if headFireEmitter and headFireEmitter.Parent then
                local fire = headFireEmitter:FindFirstChildOfClass("Fire")
                if fire then
                    -- 轻微的大小波动，让火焰更自然
                    fire.Size = 4 + math.sin(tick() * 5) * 0.5
                end
            end
        end)
    end
    
    -- 关闭头部火焰
    local function stopHeadFire()
        if not isFireActive then return end
        
        isFireActive = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- 恢复原色
        buttonText.Text = "开启"
        
        -- 移除头部火焰
        if headFireEmitter then
            headFireEmitter:Destroy()
            headFireEmitter = nil
        end
        
        print("关闭头部蓝色火焰特效")
    end
    
    -- 按钮点击事件 - 切换开启/关闭
    fireButton.MouseButton1Click:Connect(function()
        if isFireActive then
            stopHeadFire()
        else
            startHeadFire()
        end
    end)
    
    -- 角色重生时自动关闭火焰
    player.CharacterAdded:Connect(function(character)
        wait(1)
        stopHeadFire()
    end)
    
    -- 添加清理按钮
    tool:Button("移除火焰系统", function()
        stopHeadFire()
        screenGui:Destroy()
        print("头部火焰系统已移除")
    end)
    
    print("头部蓝色火焰特效已添加！点击右侧'开启'按钮切换火焰特效")
end)

tool:Button("开启雷电光环",function()
    -- 获取服务
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    
    local player = Players.LocalPlayer
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ThunderAuraButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "ThunderAuraButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80)
    buttonFrame.Position = UDim2.new(1, -100, 0.5, 0)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(106, 27, 154) -- 紫色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local auraButton = Instance.new("TextButton")
    auraButton.Name = "AuraButton"
    auraButton.Size = UDim2.new(1, 0, 1, 0)
    auraButton.BackgroundTransparency = 1
    auraButton.Text = ""
    auraButton.Parent = buttonFrame
    
    -- 雷电光环状态
    local isAuraActive = false
    local thunderConnection = nil
    local thunderParts = {}
    
    -- 创建紫色雷电特效（其他玩家可见）
    local function createThunderEffect(position, targetPosition)
        local thunder = Instance.new("Part")
        thunder.Name = "PurpleThunder"
        thunder.Size = Vector3.new(0.2, (position - targetPosition).Magnitude, 0.2)
        thunder.Position = (position + targetPosition) / 2
        thunder.Anchored = true
        thunder.CanCollide = false
        thunder.Material = EnumMaterial.Neon
        thunder.BrickColor = BrickColor.new("Royal purple")
        thunder.Parent = workspace
        
        -- 设置雷电方向
        thunder.CFrame = CFrame.lookAt(thunder.Position, targetPosition) * CFrame.Angles(math.pi/2, 0, 0)
        
        -- 紫色发光效果
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(17245,245,245)
        pointLight.Brightness = 10
        pointLight.Range = 8
        pointLight.Parent = thunder
        
        -- 闪电光束效果
        local beam = Instance.new("Beam")
        beam.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(17245,245,245)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 50, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 200))
        })
        beam.Width0 = 0.3
        beam.Width1 = 0.3
        beam.Brightness = 5
        beam.Parent = thunder
        
        -- 创建附着点
        local attachment0 = Instance.new("Attachment")
        attachment0.Parent = thunder
        attachment0.Position = Vector3.new(0, thunder.Size.Y/2, 0)
        
        local attachment1 = Instance.new("Attachment")
        attachment1.Parent = thunder
        attachment1.Position = Vector3.new(0, -thunder.Size.Y/2, 0)
        
        beam.Attachment0 = attachment0
        beam.Attachment1 = attachment1
        
        table.insert(thunderParts, thunder)
        
        -- 自动清理
        game:GetService("Debris"):AddItem(thunder, 0.3)
        
        return thunder
    end
    
    -- 在玩家周围创建雷电光环
    local function createThunderAura()
        local character = player.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        local auraRadius = 8  -- 光环半径
        local thunderCount = 6  -- 同时存在的雷电数量
        
        for i = 1, thunderCount do
            local angle = (i / thunderCount) * math.pi * 2 + tick()
            local x = math.cos(angle) * auraRadius
            local z = math.sin(angle) * auraRadius
            
            local startPos = rootPart.Position + Vector3.new(x, 5, z)
            local endPos = rootPart.Position + Vector3.new(x, 0, z)
            
            createThunderEffect(startPos, endPos)
        end
        
        -- 随机地面雷电
        if math.random(1, 3) == 1 then
            local randomAngle = math.random() * math.pi * 2
            local randomDist = math.random(3, auraRadius)
            local groundX = math.cos(randomAngle) * randomDist
            local groundZ = math.sin(randomAngle) * randomDist
            
            local groundStart = rootPart.Position + Vector3.new(groundX, 3, groundZ)
            local groundEnd = rootPart.Position + Vector3.new(groundX, 0, groundZ)
            
            createThunderEffect(groundStart, groundEnd)
        end
    end
    
    -- 创建环绕玩家的雷电粒子
    local function createAuraParticles()
        local character = player.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        -- 创建雷电粒子发射器
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Name = "ThunderAuraParticles"
        particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.5, 1.2)
        particleEmitter.Rate = 20
        particleEmitter.SpreadAngle = Vector2.new(45, 45)
        particleEmitter.Speed = NumberRange.new(2, 5)
        particleEmitter.Rotation = NumberRange.new(0, 360)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(17245,245,245)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 50, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 200))
        })
        particleEmitter.LightEmission = 0.8
        particleEmitter.Parent = rootPart
        
        -- 创建环绕光效
        local auraLight = Instance.new("PointLight")
        auraLight.Name = "AuraLight"
        auraLight.Color = Color3.fromRGB(17245,245,245)
        auraLight.Brightness = 3
        auraLight.Range = 12
        auraLight.Parent = rootPart
        
        return {particleEmitter, auraLight}
    end
    
    -- 开启雷电光环
    local function startThunderAura()
        if isAuraActive then return end
        
        isAuraActive = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(142, 36, 170)
        buttonText.Text = "开启中"
        
        print("开启紫色雷电光环特效")
        
        -- 创建持续粒子效果
        local auraEffects = createAuraParticles()
        
        -- 持续生成雷电效果
        thunderConnection = RunService.Heartbeat:Connect(function()
            if not isAuraActive then return end
            
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                return
            end
            
            -- 生成雷电
            createThunderAura()
            
            -- 随机音效（可选）
            if math.random(1, 10) == 1 then
                -- 可以在这里添加雷电音效
            end
        end)
        
        -- 存储特效引用以便清理
        auraEffects.connection = thunderConnection
        return auraEffects
    end
    
    -- 关闭雷电光环
    local function stopThunderAura()
        if not isAuraActive then return end
        
        isAuraActive = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(106, 27, 154)
        buttonText.Text = "开启"
        
        -- 断开连接
        if thunderConnection then
            thunderConnection:Disconnect()
            thunderConnection = nil
        end
        
        -- 清理所有雷电部件
        for _, part in ipairs(thunderParts) do
            if part and part.Parent then
                part:Destroy()
            end
        end
        thunderParts = {}
        
        -- 清理角色身上的特效
        local character = player.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local particles = rootPart:FindFirstChild("ThunderAuraParticles")
                local light = rootPart:FindFirstChild("AuraLight")
                
                if particles then particles:Destroy() end
                if light then light:Destroy() end
            end
        end
        
        print("关闭紫色雷电光环特效")
    end
    
    -- 按钮点击事件
    auraButton.MouseButton1Click:Connect(function()
        if isAuraActive then
            stopThunderAura()
        else
            startThunderAura()
        end
    end)
    
    -- 角色重生时自动关闭特效
    player.CharacterAdded:Connect(function(character)
        wait(1)
        stopThunderAura()
    end)
    
    -- 添加清理按钮
    tool:Button("移除雷电系统", function()
        stopThunderAura()
        screenGui:Destroy()
        print("雷电光环系统已移除")
    end)
    
    print("紫色雷电光环特效已添加！点击右侧'开启'按钮切换特效")
end)

tool:Button("开启雷电光环",function()
    -- 获取服务
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    
    local player = Players.LocalPlayer
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ThunderAuraButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "ThunderAuraButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80)
    buttonFrame.Position = UDim2.new(1, -100, 0.5, 0)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 255) -- 蓝色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local auraButton = Instance.new("TextButton")
    auraButton.Name = "AuraButton"
    auraButton.Size = UDim2.new(1, 0, 1, 0)
    auraButton.BackgroundTransparency = 1
    auraButton.Text = ""
    auraButton.Parent = buttonFrame
    
    -- 雷电光环状态
    local isAuraActive = false
    local auraConnection = nil
    local fireballParts = {}
    
    -- 创建蓝色火焰球特效（其他玩家可见）
    local function createBlueFireball(character)
        if not character then return nil end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return nil end
        
        -- 创建巨大的火焰球
        local fireball = Instance.new("Part")
        fireball.Name = "BlueFireballAura"
        fireball.Size = Vector3.new(15, 15, 15) -- 巨大的球体
        fireball.Position = rootPart.Position
        fireball.Anchored = false
        fireball.CanCollide = false
        fireball.Material = EnumMaterial.Neon
        fireball.BrickColor = BrickColor.new("Bright blue")
        fireball.Transparency = 0.3
        fireball.Parent = workspace
        
        -- 球形碰撞体
        local sphere = Instance.new("SphereHandleAdornment")
        sphere.Name = "FireballSphere"
        sphere.Adornee = fireball
        sphere.AlwaysOnTop = true
        sphere.ZIndex = 1
        sphere.Radius = 7.5
        sphere.Color3 = Color3.fromRGB(0, 150, 255)
        sphere.Parent = fireball
        
        -- 蓝色火焰特效
        local fire = Instance.new("Fire")
        fire.Name = "BlueFire"
        fire.Color = Color3.new(0, 0.5, 1) -- 蓝色
        fire.SecondaryColor = Color3.new(0, 1, 1) -- 青色
        fire.Size = 25 -- 巨大的火焰
        fire.Heat = 5
        fire.Parent = fireball
        
        -- 蓝色点光源
        local pointLight = Instance.new("PointLight")
        pointLight.Name = "BlueLight"
        pointLight.Color = Color3.fromRGB(0, 150, 255)
        pointLight.Brightness = 15
        pointLight.Range = 25
        pointLight.Parent = fireball
        
        -- 烟雾特效（蓝色调）
        local smoke = Instance.new("Smoke")
        smoke.Name = "BlueSmoke"
        smoke.Color = Color3.new(0, 0.3, 0.6)
        smoke.Size = 10
        smoke.Opacity = 0.4
        smoke.RiseVelocity = 5
        smoke.Parent = fireball
        
        -- 粒子发射器
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Name = "BlueParticles"
        particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particleEmitter.Lifetime = NumberRange.new(1, 3)
        particleEmitter.Rate = 50
        particleEmitter.SpreadAngle = Vector2.new(45, 45)
        particleEmitter.Speed = NumberRange.new(2, 8)
        particleEmitter.VelocitySpread = 50
        particleEmitter.Rotation = NumberRange.new(0, 360)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
        })
        particleEmitter.LightEmission = 0.9
        particleEmitter.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.5),
            NumberSequenceKeypoint.new(0.5, 1),
            NumberSequenceKeypoint.new(1, 0)
        })
        particleEmitter.Parent = fireball
        
        -- 将火焰球连接到角色
        local weld = Instance.new("Weld")
        weld.Part0 = rootPart
        weld.Part1 = fireball
        weld.C0 = CFrame.new(0, 0, 0) -- 在角色中心
        weld.Parent = fireball
        
        table.insert(fireballParts, fireball)
        
        return fireball
    end
    
    -- 创建环绕火焰球的额外特效
    local function createOrbitingEffects(character)
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        -- 创建环绕的闪电效果
        for i = 1, 4 do
            local angle = (i / 4) * math.pi * 2
            local orbitPart = Instance.new("Part")
            orbitPart.Name = "OrbitLightning"
            orbitPart.Size = Vector3.new(1, 1, 8)
            orbitPart.Anchored = false
            orbitPart.CanCollide = false
            orbitPart.Material = EnumMaterial.Neon
            orbitPart.BrickColor = BrickColor.new("Bright blue")
            orbitPart.Transparency = 0.2
            orbitPart.Parent = workspace
            
            -- 光束效果
            local beam = Instance.new("Beam")
            beam.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
            })
            beam.Width0 = 0.5
            beam.Width1 = 0.5
            beam.Brightness = 3
            beam.Parent = orbitPart
            
            local attachment0 = Instance.new("Attachment")
            attachment0.Parent = orbitPart
            local attachment1 = Instance.new("Attachment")
            attachment1.Parent = orbitPart
            
            beam.Attachment0 = attachment0
            beam.Attachment1 = attachment1
            
            -- 连接到角色并设置环绕
            local weld = Instance.new("Weld")
            weld.Part0 = rootPart
            weld.Part1 = orbitPart
            weld.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(0, angle, 0) * CFrame.new(10, 0, 0)
            weld.Parent = orbitPart
            
            table.insert(fireballParts, orbitPart)
        end
    end
    
    -- 开启蓝色火焰球光环
    local function startBlueFireballAura()
        if isAuraActive then return end
        
        isAuraActive = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        buttonText.Text = "开启中"
        
        print("开启巨大蓝色火焰球特效")
        
        local character = player.Character
        if not character then return end
        
        -- 创建主火焰球
        local mainFireball = createBlueFireball(character)
        
        -- 创建环绕特效
        createOrbitingEffects(character)
        
        -- 更新特效位置
        auraConnection = RunService.Heartbeat:Connect(function()
            if not isAuraActive then return end
            
            local currentCharacter = player.Character
            if not currentCharacter then
                stopBlueFireballAura()
                return
            end
        end)
    end
    
    -- 关闭蓝色火焰球光环
    local function stopBlueFireballAura()
        if not isAuraActive then return end
        
        isAuraActive = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        buttonText.Text = "开启"
        
        -- 断开连接
        if auraConnection then
            auraConnection:Disconnect()
            auraConnection = nil
        end
        
        -- 清理所有火焰球部件
        for _, part in ipairs(fireballParts) do
            if part and part.Parent then
                part:Destroy()
            end
        end
        fireballParts = {}
        
        print("关闭蓝色火焰球特效")
    end
    
    -- 按钮点击事件
    auraButton.MouseButton1Click:Connect(function()
        if isAuraActive then
            stopBlueFireballAura()
        else
            startBlueFireballAura()
        end
    end)
    
    -- 角色重生时自动关闭特效
    player.CharacterAdded:Connect(function(character)
        wait(1) -- 等待角色完全加载
        if isAuraActive then
            stopBlueFireballAura()
            wait(0.5)
            startBlueFireballAura()
        end
    end)
    
    -- 添加清理按钮
    tool:Button("移除火焰球系统", function()
        stopBlueFireballAura()
        screenGui:Destroy()
        print("蓝色火焰球系统已移除")
    end)
    
    print("巨大蓝色火焰球特效已添加！点击右侧'开启'按钮切换特效")
end)

local creds = window:Tab("免费robux",'6035145364')

local tool = creds:section("全是免费",true)

tool:Button("获得30robux", function()
    -- 第一个通知：正在获取
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Robux获取中",
        Text = "正在获取30 Robux...",
        Duration = 5,
        Icon = "rbxassetid://112945417541386"
    })
    
    -- 等待8-9秒
    wait(math.random(8, 9))
    
    -- 第二个通知：已获取
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "获取成功！",
        Text = "已成功获取30 Robux！",
        Duration = 5,
        Icon = "rbxassetid://112945417541386"
    })
    
    print("恶搞完成：显示虚假Robux获取通知")
end)

-- 恶搞脚本：虚假奖励
local function CreatePrankGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- 创建全屏图片（更大尺寸）
    local image = Instance.new("ImageLabel")
    image.Size = UDim2.new(1.2, 0, 1.2, 0) -- 放大图片
    image.Position = UDim2.new(-0.1, 0, -0.1, 0) -- 调整位置使其居中显示
    image.Image = "http://www.roblox.com/asset/?id=101930816916083"
    image.BackgroundColor3 = Color3.new(0, 0, 0)
    image.Parent = screenGui

    -- 播放两个大声音频
    local sound1 = Instance.new("Sound")
    sound1.SoundId = "rbxassetid://313948389"
    sound1.Volume = 10
    sound1.Parent = game.Workspace
    sound1:Play()

    local sound2 = Instance.new("Sound")
    sound2.SoundId = "rbxassetid://8315677038"
    sound2.Volume = 10
    sound2.Parent = game.Workspace
    sound2:Play()

    -- 创建胶囊型道歉按钮
    local apologyButton = Instance.new("TextButton")
    apologyButton.Size = UDim2.new(0, 200, 0, 60)
    apologyButton.Position = UDim2.new(0.5, -100, 0.8, 0)
    apologyButton.Text = "爸爸我错了"
    apologyButton.BackgroundColor3 = Color3.fromRGB(173, 216, 230) -- 淡蓝色
    apologyButton.TextColor3 = Color3.new(0, 0, 0)
    apologyButton.Font = Enum.Font.SourceSansBold
    apologyButton.TextSize = 20
    
    -- 设置胶囊形状（圆角）
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 设置为胶囊形状
    corner.Parent = apologyButton
    
    apologyButton.Parent = screenGui

    apologyButton.MouseButton1Click:Connect(function()
        -- 立即消失图片和按钮
        image:Destroy()
        apologyButton:Destroy()
        
        local message = "爸爸我错了"
        
        -- 在聊天框显示消息
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        -- 尝试通过默认聊天系统发送消息
        local success, err = pcall(function()
            Players:Chat(message)
        end)
        
        -- 如果默认方法失败，尝试其他方法
        if not success then
            -- 尝试使用SayMessageRequest
            pcall(function()
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message)
            end)
        end

        -- 修改天空盒
        local lighting = game:GetService("Lighting")
        local sky = lighting:FindFirstChildOfClass("Sky")
        if sky then
            sky:Destroy()
        end
        
        local newSky = Instance.new("Sky")
        newSky.Parent = lighting
        
        -- 设置天空盒所有面为同一图片
        local textureId = "http://www.roblox.com/asset/?id=101930816916083"
        newSky.SkyboxBk = textureId
        newSky.SkyboxDn = textureId
        newSky.SkyboxFt = textureId
        newSky.SkyboxLf = textureId
        newSky.SkyboxRt = textureId
        newSky.SkyboxUp = textureId

        -- 修改所有模型的贴图
        local function changeTextures(obj)
            if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                -- 创建新的贴图
                local texture = Instance.new("Texture")
                texture.Texture = textureId
                texture.Face = "Top"
                texture.Parent = obj
                
                local texture2 = Instance.new("Texture")
                texture2.Texture = textureId
                texture2.Face = "Bottom"
                texture2.Parent = obj
                
                local texture3 = Instance.new("Texture")
                texture3.Texture = textureId
                texture3.Face = "Left"
                texture3.Parent = obj
                
                local texture4 = Instance.new("Texture")
                texture4.Texture = textureId
                texture4.Face = "Right"
                texture4.Parent = obj
                
                local texture5 = Instance.new("Texture")
                texture5.Texture = textureId
                texture5.Face = "Front"
                texture5.Parent = obj
                
                local texture6 = Instance.new("Texture")
                texture6.Texture = textureId
                texture6.Face = "Back"
                texture6.Parent = obj
            end
            
            -- 递归处理所有子对象
            for _, child in ipairs(obj:GetChildren()) do
                changeTextures(child)
            end
        end

        -- 从Workspace开始修改所有模型
        changeTextures(game.Workspace)

        -- 给所有玩家添加长条拖尾特效
        local function addTrailToPlayer(player)
            if player.Character then
                local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    -- 创建拖尾特效
                    local trail = Instance.new("Trail")
                    trail.Attachment0 = Instance.new("Attachment")
                    trail.Attachment0.Parent = humanoidRootPart
                    trail.Attachment0.Position = Vector3.new(-1, 0, 0)
                    
                    trail.Attachment1 = Instance.new("Attachment")
                    trail.Attachment1.Parent = humanoidRootPart
                    trail.Attachment1.Position = Vector3.new(1, 0, 0)
                    
                    trail.Texture = "http://www.roblox.com/asset/?id=101930816916083"
                    trail.TextureMode = Enum.TextureMode.Wrap
                    trail.Lifetime = 2
                    trail.MaxLength = 100
                    trail.Color = ColorSequence.new(Color3.new(1, 1, 1))
                    trail.Parent = humanoidRootPart
                end
            end
        end

        -- 给现有玩家添加拖尾
        for _, player in ipairs(Players:GetPlayers()) do
            addTrailToPlayer(player)
        end

        -- 给新加入的玩家也添加拖尾
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                wait(1) -- 等待角色加载完成
                addTrailToPlayer(player)
            end)
        end)

        local apologySound = Instance.new("Sound")
        apologySound.SoundId = "rbxassetid://128326043560149"
        apologySound.Volume = 10
        apologySound.Parent = game.Workspace
        apologySound:Play()

        apologySound.Ended:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

-- 创建多个单独的奖励按钮
local rewardAmounts = {80, 160, 240, 320, 400, 480, 560, 640, 720, 800}

for i, amount in ipairs(rewardAmounts) do
    tool:Button("免费获得" .. amount .. "r", function()
        CreatePrankGUI()
    end)
end

tool:Button("获得5600robux", function()
    -- 第一个通知：正在获取
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Robux获取中",
        Text = "正在获取5600 Robux...",
        Duration = 6,
        Icon = "rbxassetid://112945417541386"
    })
    
    -- 等待10-12秒，让用户更期待
    wait(math.random(10, 12))
    
    -- 第二个通知：已获取
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "获取成功！",
        Text = "已成功获取5600 Robux！",
        Duration = 8,
        Icon = "rbxassetid://112945417541386"
    })
    
    print(" Robux获取通知")
end)

local creds = window:Tab("黄色功能",'6035145364')

local tool = creds:section("功能",true)

tool:Button("点击约炮",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/79632dbbd97f3c4359fa068566c282ca13db30c0/%E7%82%B9%E5%87%BB%E5%B2%B3%E7%96%B1"))()
end)

tool:Button("爸爸快点拿大黑吊操我",function()
    local message = "爸爸快点拿大黒眺懆我"
    
    
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
        if sayMessage then
            sayMessage:FireServer(message, "All")
        end
    end
    
   
    local TextChatService = game:GetService("TextChatService")
    if TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel:SendAsync(message)
            end
        end
    end
    
    print("已发送消息: " .. message)
end)

tool:Button("好想吃大黑屌",function()
     local message = "好向迟大嘿调"
    
    
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
        if sayMessage then
            sayMessage:FireServer(message, "All")
        end
    end
    
   
    local TextChatService = game:GetService("TextChatService")
    if TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel:SendAsync(message)
            end
        end
    end
    
    print("已发送消息: " .. message)
end)

tool:Button("我是个骚逼",function()
    local message = "我是个嫂避"
    
    
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
        if sayMessage then
            sayMessage:FireServer(message, "All")
        end
    end
    
   
    local TextChatService = game:GetService("TextChatService")
    if TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel:SendAsync(message)
            end
        end
    end
    
    print("已发送消息: " .. message)
end)

local creds = window:Tab("doors",'6035145364')

local tool = creds:section("功能",true)

tool:Button("可以清除东西的枪",function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Laser%20Gun"))()
end)
      
             
tool:Button("十字架",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/FCSyG6Th"))();
end)  
      
tool:Button("夜视仪",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/4Vsv1Xwn"))()
end)  
      
tool:Button("神圣炸弹",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/u5B1UjGv"))()
end)  
      
tool:Button("吸铁石",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/xHxGDp51"))()
end)    
      
tool:Button("剪刀",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/v2yEJYmu"))()
end)  

tool:Button("开启不可能模式",function()
      	loadstring(game:HttpGet('https://raw.githubusercontent.com/Ukazix/impossible-mode/main/Protected_79.lua.txt'))() 
end)

tool:Button("每15秒一只screech",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        while true do -- Will run the script forever
          coroutine.wrap(function() require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech)(Data) end)() -- Coroutines prevent the script from yielding.
        task.wait(15) -- Waits somewhere around a millisecond before executing again. This is necessary so that the script won't crash your game. You can also add a time as such: task.wait(1) or task.wait(0.5)
        end
end)

tool:Button("每15秒一只halt",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        while true do -- Will run the script forever
          coroutine.wrap(function() require(game.ReplicatedStorage.ClientModules.EntityModules.Glitch).stuff(Data, workspace.CurrentRooms[tostring(game.ReplicatedStorage.GameData.LatestRoom.Value)])          end)() -- Coroutines prevent the script from yielding.
        task.wait(15) -- Waits somewhere around a millisecond before executing again. This is necessary so that the script won't crash your game. You can also add a time as such: task.wait(1) or task.wait(0.5)
        end
end)

tool:Button("每15秒一只glitch",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        while true do -- Will run the script forever
          coroutine.wrap(function() require(game.ReplicatedStorage.ClientModules.EntityModules.Glitch).stuff(Data, workspace.CurrentRooms[tostring(game.ReplicatedStorage.GameData.LatestRoom.Value)]) end)() -- Coroutines prevent the script from yielding.
        task.wait(15) -- Waits somewhere around a millisecond before executing again. This is necessary so that the script won't crash your game. You can also add a time as such: task.wait(1) or task.wait(0.5)
        end
end)

tool:Button("每15秒一次心跳小游戏",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        while true do -- Will run the script forever
          coroutine.wrap(function() firesignal(game.ReplicatedStorage.Bricks.ClutchHeartbeat.OnClientEvent)  end)() -- Coroutines prevent the script from yielding.
        task.wait(15) -- Waits somewhere around a millisecond before executing again. This is necessary so that the script won't crash your game. You can also add a time as such: task.wait(1) or task.wait(0.5)
        end
end)

tool:Toggle("刷新时通知", "TZ", false, function(TZ)
     _G.IE = (TZ and true or false) LatestRoom.Changed:Connect(function() if _G.IE == true then local n = ChaseStart.Value - LatestRoom.Value if 0 < n and n < 4 then Notification:Notify("请注意", "事件可能刷新于" .. tostring(n) .. " 房间","rbxassetid://17360377302",3) end end end) workspace.ChildAdded:Connect(function(inst) if inst.Name == "RushMoving" and _G.IE == true then Notify("请注意", "Rush 已刷新","rbxassetid://17360377302",3) elseif inst.Name == "AmbushMoving" and _G.IE == true then Notify("请注意", "Ambush 已刷新","rbxassetid://17360377302",3) end end)
end)
tool:Toggle("自动躲避Rush/Ambush", "ADB", false, function(ADB)
    _G.Avoid = (ADB and true or false) workspace.ChildAdded:Connect(function(inst) if inst.Name == "RushMoving" and _G.Avoid == true then Notify("请注意!", "正在躲避 Rush.","rbxassetid://17360377302",3) local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position local con = game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0)) end) inst.Destroying:Wait() con:Disconnect() game.Players.LocalPlayer.Character:MoveTo(OldPos) elseif inst.Name == "AmbushMoving" and _G.Avoid == true then Notify("注意!", "正在躲避 Ambush.","rbxassetid://17360377302",3) local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position local con = game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0)) end) inst.Destroying:Wait() con:Disconnect() game.Players.LocalPlayer.Character:MoveTo(OldPos) end end)
end)
tool:Toggle("无 Screech", "NCH", false, function(NCH)
    _G.NS = (NCH and true or false) workspace.CurrentCamera.ChildAdded:Connect(function(child) if child.Name == "Screech" and _G.NS == true then child:Destroy() end end)
end)

local creds = window:Tab("范围和旋转",'6035145364')

local tool = creds:section("功能",true)

tool:Textbox("自定义范围", "HitBox", "请输入文本", function(Value)
   _G.HeadSize = Value
    _G.Disabled = true 
   game:GetService('RunService').RenderStepped:connect(function()
    if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
    pcall(function()
    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) 
   v.Character.HumanoidRootPart.Transparency = 0.7 
   v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
    v.Character.HumanoidRootPart.Material = "Neon"
    v.Character.HumanoidRootPart.CanCollide = false
    end)
    end 
   end 
   end
    end)
end)

tool:Button("范围100", function()
    _G.HeadSize = 100 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Button("范围150", function()
    _G.HeadSize = 150 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Button("范围200", function()
    _G.HeadSize = 200 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Button("范围250", function()
    _G.HeadSize = 250 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Button("范围300", function()
    _G.HeadSize = 300 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Label("旋转")
tool:Button("旋转清零", function()
  loadstring(game:HttpGet("https://pastefy.app/UOWFy58g/raw"))()
end)
tool:Button("旋转10", function()
  loadstring(game:HttpGet("https://pastefy.app/pX8CKeHn/raw"))()
end)
tool:Button("旋转30", function()
  loadstring(game:HttpGet("https://pastefy.app/1Ob0oE2h/raw"))()
end)
tool:Button("旋转50", function()
  loadstring(game:HttpGet("https://pastefy.app/4UL7XrJU/raw"))()
end)
tool:Button("旋转100", function()
  loadstring(game:HttpGet("https://pastefy.app/6agZDErY/raw"))()
end)
tool:Button("旋转150", function()
  loadstring(game:HttpGet("https://pastefy.app/MqAalYjs/raw"))()
end)
tool:Button("旋转200", function()
  loadstring(game:HttpGet("https://pastefy.app/00mtNBML/raw"))()
end)
tool:Button("旋转250", function()
  loadstring(game:HttpGet("https://pastefy.app/CR2woYXY/raw"))()
end)
tool:Button("旋转300", function()
  loadstring(game:HttpGet("https://pastefy.app/5SbEaumY/raw"))()
end)
tool:Button("旋转400", function()
  loadstring(game:HttpGet("https://pastefy.app/pjkZd07i/raw"))()
end)
tool:Button("旋转500", function()
  loadstring(game:HttpGet("https://pastefy.app/9emFsJ7N/raw"))()
end)

local creds = window:Tab("一路向西",'6035145364')

local tool = creds:section("武器功能",true)

tool:Button("一秒换弹", function()
    local mods = {
        FanFire = true, 
        prepTime = 0, 
        equipTime = 0, 
        camShakeResist = 0, 
        ReloadAnimationSpeed = 10, 
        ReloadSpeed = 0, 
        Spread = 0, 
        InstantFireAnimation = true
    }

    for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
        for prop, value in pairs(mods) do
            if gun[prop] then
                gun[prop] = value
            end
        end
    end
end)

tool:Button("无限备弹 死亡后会卡无限子弹 需手动打几发子弹然后切换一下枪", function()
    local mods = {
        FanFire = true, 
        prepTime = 0, 
        equipTime = 0, 
        MaxShots = math.huge, 
        camShakeResist = 0, 
        ReloadAnimationSpeed = 10, 
        ReloadSpeed = 0, 
        Spread = 0, 
        InstantFireAnimation = true
    }

    for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
        for prop, value in pairs(mods) do
            if gun[prop] then
                gun[prop] = value
            end
        end
    end
end)

tool:Button("子弹汇聚", function()
    local mods = {
        FanFire = true, 
        prepTime = 0, 
        equipTime = 0, 
        camShakeResist = 0, 
        ReloadAnimationSpeed = 10, 
        ReloadSpeed = 0, 
        Spread = 0, 
        HipFireAccuracy = 0, 
        ZoomAccuracy = 0, 
        InstantFireAnimation = true
    }

    for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
        for prop, value in pairs(mods) do
            if gun[prop] then
                gun[prop] = value
            end
        end
    end
end)

tool:Button("无后座力", function()
    local mods = {
        FanFire = true, 
        camShakeResist = 0, 
        prepTime = 0, 
        equipTime = 0, 
        Spread = 0, 
        InstantFireAnimation = true
    }

    for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
        for prop, value in pairs(mods) do
            if gun[prop] then
                gun[prop] = value
            end
        end
    end
end)

tool:Button("范围伤害", function()
    local Camera = game:GetService("Workspace").CurrentCamera
    local Players = game:GetService("Players")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    
    local function GetClosestPlayer()
        local ClosestPlayer = nil
        local FarthestDistance = math.huge
    
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local DistanceFromPlayer = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
    
                if DistanceFromPlayer < FarthestDistance then
                    FarthestDistance = DistanceFromPlayer
                    ClosestPlayer = v
                end
            end
        end
    
        if ClosestPlayer then
            return ClosestPlayer
        end
    end
    
    local GameMetaTable = getrawmetatable(game)
    local OldGameMetaTableNamecall = GameMetaTable.__namecall
    setreadonly(GameMetaTable, false)
    
    GameMetaTable.__namecall = newcclosure(function(object, ...)
        local NamecallMethod = getnamecallmethod()
        local Arguments = {...}
    
        if tostring(NamecallMethod) == "FindPartOnRayWithIgnoreList" then
            local ClosestPlayer = GetClosestPlayer()
            
            if ClosestPlayer and ClosestPlayer.Character then
                Arguments[1] = Ray.new(Camera.CFrame.Position, (ClosestPlayer.Character.Head.Position - Camera.CFrame.Position).Unit * (Camera.CFrame.Position - ClosestPlayer.Character.Head.Position).Magnitude)
            end
        end
    
        return OldGameMetaTableNamecall(object, unpack(Arguments))
    end)
    
    setreadonly(GameMetaTable, true)
end)

tool:Label("全图击杀需要手持近战武器")

tool:Button("全图击杀", function()
    loadstring(game:HttpGet('https://raw.github.com/520-Ghost/-/main/link/killQWQ.lua'))()
end)

local tool = creds:section("购买区",true)

tool:Toggle("自动出售", "Toggleflag", false, function(v)
    getgenv().sell = v
    sell()
end)

tool:Toggle("手枪子弹", "Toggleflag", false, function(v)
    getgenv().buyammo1 = v
    buyammo1()
end)

tool:Toggle("步枪子弹", "Toggleflag", false, function(v)
    getgenv().buyammo2 = v
    buyammo2()
end)

tool:Toggle("购买箭矢", "Toggleflag", false, function(v)
    getgenv().buyammo3 = v
    buyammo3()
end)

tool:Toggle("霰弹子弹", "Toggleflag", false, function(v)
    getgenv().buyammo4 = v
    buyammo4()
end)

tool:Toggle("狙击子弹", "Toggleflag", false, function(v)
    getgenv().buyammo5 = v
    buyammo5()
end)

tool:Toggle("小型炸药", "Toggleflag", false, function(v)
    getgenv().buyammo6 = v
    buyammo6()
end)

tool:Toggle("大型炸药", "Toggleflag", false, function(v)
    getgenv().buyammo7 = v
    buyammo7()
end)

local tool = creds:section("传送",true)

tool:Label("牛仔传送点")

tool:Button("滚筒", function()
    local args = {
        [1] = "StoneCreek",
        [2] = false
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end)

tool:Button("岩石溪", function()
    local args = {
        [1] = "StoneCreek",
        [2] = false
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end)

tool:Button("灰色山脊", function()
    local args = {
        [1] = "Grayridge",
        [2] = false
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end)

tool:Button("大矿洞", function()
    local args = {
        [1] = "Quarry",
        [2] = false
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end)

tool:Label("不法之徒传送")

tool:Button("堡垒", function()
    local args = {
        [1] = "FortCassidy",
        [2] = true
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end)

tool:Button("阿瑟堡", function()
    local args = {
        [1] = "FortArthur",
        [2] = true
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end)

tool:Button("红色岩石营地", function()
    local args = {
        [1] = "RedRocks",
        [2] = true
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GeneralEvents"):WaitForChild("Spawn"):FireServer(unpack(args))
end)

local tool = creds:section("透视",true)

-- 动物透视功能
tool:Toggle("动物透视", "Toggleflag", false, function(v)
    getgenv().esp = v
    esp()
end)

-- 开启透视功能
tool:Button("开启透视", function()
    _G.FriendColor = Color3.fromRGB(0, 0, 255)
    _G.EnemyColor = Color3.fromRGB(255, 0, 0)
    _G.UseTeamColor = true
    
    --------------------------------------------------------------------
    local Holder = Instance.new("Folder", game.CoreGui)
    Holder.Name = "ESP"
    
    local Box = Instance.new("BoxHandleAdornment")
    Box.Name = "nilBox"
    Box.Size = Vector3.new(1, 2, 1)
    Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
    Box.Transparency = 0.7
    Box.ZIndex = 0
    Box.AlwaysOnTop = false
    Box.Visible = false
    
    local NameTag = Instance.new("BillboardGui")
    NameTag.Name = "nilNameTag"
    NameTag.Enabled = false
    NameTag.Size = UDim2.new(0, 200, 0, 50)
    NameTag.AlwaysOnTop = true
    NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
    local Tag = Instance.new("TextLabel", NameTag)
    Tag.Name = "Tag"
    Tag.BackgroundTransparency = 1
    Tag.Position = UDim2.new(0, -50, 0, 0)
    Tag.Size = UDim2.new(0, 300, 0, 20)
    Tag.TextSize = 15
    Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
    Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
    Tag.TextStrokeTransparency = 0.4
    Tag.Text = "nil"
    Tag.Font = Enum.Font.SourceSansBold
    Tag.TextScaled = false
    
    local LoadCharacter = function(v)
        repeat wait() until v.Character ~= nil
        v.Character:WaitForChild("Humanoid")
        local vHolder = Holder:FindFirstChild(v.Name)
        vHolder:ClearAllChildren()
        local b = Box:Clone()
        b.Name = v.Name .. "Box"
        b.Adornee = v.Character
        b.Parent = vHolder
        local t = NameTag:Clone()
        t.Name = v.Name .. "NameTag"
        t.Enabled = true
        t.Parent = vHolder
        t.Adornee = v.Character:WaitForChild("Head", 5)
        if not t.Adornee then
            return UnloadCharacter(v)
        end
        t.Tag.Text = v.Name
        b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
        t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
        local Update
        local UpdateNameTag = function()
            if not pcall(function()
                    v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                    local maxh = math.floor(v.Character.Humanoid.MaxHealth)
                    local h = math.floor(v.Character.Humanoid.Health)
                end) then
                Update:Disconnect()
            end
        end
        UpdateNameTag()
        Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
    end
    
    local UnloadCharacter = function(v)
        local vHolder = Holder:FindFirstChild(v.Name)
        if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then
            vHolder:ClearAllChildren()
        end
    end
    
    local LoadPlayer = function(v)
        local vHolder = Instance.new("Folder", Holder)
        vHolder.Name = v.Name
        v.CharacterAdded:Connect(function()
            pcall(LoadCharacter, v)
        end)
        v.CharacterRemoving:Connect(function()
            pcall(UnloadCharacter, v)
        end)
        v.Changed:Connect(function(prop)
            if prop == "TeamColor" then
                UnloadCharacter(v)
                wait()
                LoadCharacter(v)
            end
        end)
        LoadCharacter(v)
    end
    
    local UnloadPlayer = function(v)
        UnloadCharacter(v)
        local vHolder = Holder:FindFirstChild(v.Name)
        if vHolder then
            vHolder:Destroy()
        end
    end
    
    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        spawn(function() pcall(LoadPlayer, v) end)
    end
    
    game:GetService("Players").PlayerAdded:Connect(function(v)
        pcall(LoadPlayer, v)
    end)
    
    game:GetService("Players").PlayerRemoving:Connect(function(v)
        pcall(UnloadPlayer, v)
    end)
    
    game:GetService("Players").LocalPlayer.NameDisplayDistance = 0
    
    if _G.Reantheajfdfjdgs then
        return
    end
    
    _G.Reantheajfdfjdgs = ":suifayhgvsdghfsfkajewfrhk321rk213kjrgkhj432rj34f67df"
    
    local players = game:GetService("Players")
    local plr = players.LocalPlayer
    
    function esp(target, color)
        if target.Character then
            if not target.Character:FindFirstChild("GetReal") then
                local highlight = Instance.new("Highlight")
                highlight.RobloxLocked = true
                highlight.Name = "GetReal"
                highlight.Adornee = target.Character
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.FillColor = color
                highlight.Parent = target.Character
            else
                target.Character.GetReal.FillColor = color
            end
        end
    end
    
    while task.wait() do
        for i, v in pairs(players:GetPlayers()) do
            if v ~= plr then
                esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
            end
        end
    end
end)

local creds = window:Tab("力量传奇",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("自动比赛开关", "AR", false, function(AR)
  while AR do wait() wait(2) game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl") end
end)
tool:Toggle("自动举哑铃", "ATYL", false, function(ATYL)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATYL do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Weight" then v.Parent = game.Players.LocalPlayer.Character end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end
end)
tool:Toggle("自动俯卧撑", "ATFWC", false, function(ATFWC)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATFWC do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Pushups" then v.Parent = game.Players.LocalPlayer.Character end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end
end)
tool:Toggle("自动仰卧起坐", "ATYWQZ", false, function(ATYWQZ)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATYWQZ do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Situps" then v.Parent = game.Players.LocalPlayer.Character end end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end)
tool:Toggle("自动倒立身体", "ATDL", false, function(ATDL)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATDL do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Handstands" then v.Parent = game.Players.LocalPlayer.Character end end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end)
tool:Toggle("自动锻炼", "ATAAA", false, function(ATAAA)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true while ATAAA do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Handstands" or v.Name == "Situps" or v.Name == "Pushups" or v.Name == "Weight" then v:FindFirstChildOfClass("NumberValue").Value = 0 repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end end end
end)

tool:Toggle("自动重生", "ATRE", false, function(ATRE)
  while ATRE do wait() game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest") end
end)
tool:Button("收集宝石", function()
  jk = {} for _, v in pairs(game:GetService("ReplicatedStorage").chestRewards:GetDescendants()) do if v.Name ~= "Light Karma Chest" or v.Name ~= "Evil Karma Chest" then table.insert(jk, v.Name) end end for i = 1, #jk do wait(2) game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(jk[i]) end
end)

tool:Toggle("沙滩跑步机10", "PPJ10", false, function(PPJ10)
    getgenv().PPJ10 = PPJ10 while getgenv().PPJ10 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end if not getgenv().PPJ10 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
tool:Toggle("健身房跑步机2000", "PPJ2000", false, function(PPJ2000)
    if game.Players.LocalPlayer.Agility.Value >= 2000 then getgenv().PPJ2000 = PPJ2000 while getgenv().PPJ2000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-3005.37866, 14.3221855, -464.697876, -0.015773816, -1.38508964e-08, 0.999875605, -5.13225586e-08, 1, 1.30429667e-08, -0.999875605, -5.11104332e-08, -0.015773816) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().PPJ2000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
tool:Toggle("神话健身房跑步机2000", "SHPPJ2000", false, function(SHPPJ2000)
    if game.Players.LocalPlayer.Agility.Value >= 2000 then getgenv().SHPPJ2000 = SHPPJ2000 while getgenv().SHPPJ2000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2571.23706, 15.6896839, 898.650391, 0.999968231, 2.23868635e-09, -0.00797206629, -1.73198844e-09, 1, 6.35660768e-08, 0.00797206629, -6.3550246e-08, 0.999968231) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().SHPPJ2000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
tool:Toggle("永恒健身房跑步机3500", "YHPPJ3500", false, function(YHPPJ3500)
    if game.Players.LocalPlayer.Agility.Value >= 3500 then getgenv().YHPPJ3500 = YHPPJ3500 while getgenv().YHPPJ3500 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7077.79102, 29.6702118, -1457.59961, -0.0322036594, -3.31122768e-10, 0.99948132, -6.44344267e-09, 1, 1.23684493e-10, -0.99948132, -6.43611742e-09, -0.0322036594) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().YHPPJ3500 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
tool:Toggle("传奇健身房跑步机3000", "CQPPJ3000", false, function(CQPPJ3000)
    if game.Players.LocalPlayer.Agility.Value >= 3000 then getgenv().CQPPJ3000 = CQPPJ3000 while getgenv().CQPPJ3000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4370.82812, 999.358704, -3621.42773, -0.960604727, -8.41949266e-09, -0.27791819, -6.12478646e-09, 1, -9.12496567e-09, 0.27791819, -7.06329528e-09, -0.960604727) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().CQPPJ3000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)

tool:Toggle("石头0", "RK0", false, function(RK0)
    getgenv().RK0 = RK0 while getgenv().RK0 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(7.60643005, 4.02632904, 2104.54004, -0.23040159, -8.53662385e-08, -0.973095655, -4.68743764e-08, 1, -7.66279342e-08, 0.973095655, 2.79580536e-08, -0.23040159) end if not getgenv().RK0 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end
end)
tool:Toggle("石头10", "RK10", false, function(RK10)
    if game.Players.LocalPlayer.Durability.Value >= 10 then getgenv().RK10 = RK10 while getgenv().RK10 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-157.680908, 3.72453046, 434.871185, 0.923298299, -1.81774684e-09, -0.384083599, 3.45247031e-09, 1, 3.56670582e-09, 0.384083599, -4.61917082e-09, 0.923298299) end if not getgenv().RK10 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头100", "RK100", false, function(RK100)
    if game.Players.LocalPlayer.Durability.Value >= 100 then getgenv().RK100 = RK100 while getgenv().RK100 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(162.233673, 3.66615629, -164.686783, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928) end if not getgenv().RK100 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头5000", "RK5000", false, function(RK5000)
    if game.Players.LocalPlayer.Durability.Value >= 5000 then getgenv().RK5000 = RK5000 while getgenv().RK5000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(329.831482, 3.66450214, -618.48407, -0.806075394, -8.67358096e-08, 0.591812849, -1.05715522e-07, 1, 2.57029176e-09, -0.591812849, -6.04919563e-08, -0.806075394) end if not getgenv().RK5000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头150000", "RK150000", false, function(RK150000)
    if game.Players.LocalPlayer.Durability.Value >= 150000 then getgenv().RK150000 = RK150000 while getgenv().RK150000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2566.78076, 3.97019577, -277.503235, -0.923934579, -4.11600105e-08, -0.382550538, -3.38838042e-08, 1, -2.57576183e-08, 0.382550538, -1.08360858e-08, -0.923934579) end if not getgenv().RK150000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头400000", "RK400000", false, function(RK400000)
    if game.Players.LocalPlayer.Durability.Value >= 400000 then getgenv().RK400000 = RK400000 while getgenv().RK400000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2155.61743, 3.79830337, 1227.06482, -0.551303148, -9.16796949e-09, -0.834304988, -5.61318245e-08, 1, 2.61027839e-08, 0.834304988, 6.12216127e-08, -0.551303148) end if not getgenv().RK400000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头750000", "RK750000", false, function(RK750000)
    if game.Players.LocalPlayer.Durability.Value >= 750000 then getgenv().RK750000 = RK750000 while getgenv().RK750000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7285.6499, 3.66624784, -1228.27417, 0.857643783, -1.58175091e-08, -0.514244199, -1.22581563e-08, 1, -5.12025977e-08, 0.514244199, 5.02172774e-08, 0.857643783) end if not getgenv().RK750000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头100万", "RK1M", false, function(RK1M)
    if game.Players.LocalPlayer.Durability.Value >= 1000000 then getgenv().RK1M = RK1M while getgenv().RK1M do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4160.87109, 987.829102, -4136.64502, -0.893115997, 1.25481356e-05, 0.44982639, 5.02490684e-06, 1, -1.79187136e-05, -0.44982639, -1.37431543e-05, -0.893115997) end if not getgenv().RK1M then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头500万", "RK5M", false, function(RK5M)
    if game.Players.LocalPlayer.Durability.Value >= 5000000 then getgenv().RK5M = RK5M while getgenv().RK5M do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8957.54395, 5.53625107, -6126.90186, -0.803919137, 6.6065212e-08, 0.594738603, -8.93136143e-09, 1, -1.23155459e-07, -0.594738603, -1.04318865e-07, -0.803919137) end if not getgenv().RK5M then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)

tool:Button("传送到出生点",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108)
end)

tool:Button("传送到安全岛",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, 10, 1838)
end)

tool:Button("传送到幸运抽奖区域",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2606, -2, 5753)
end)

tool:Button("传送到肌肉之王健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642)
end)

tool:Button("传送到传说健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915)
end)

tool:Button("传送到永恒健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284)
end)

tool:Button("传送到神话健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070)
end)

tool:Button("传送到冰霜健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410)
end)

tool:Button("力量传奇改力量",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/jynzl/main/main/Musclas%20Legenos.lua'))()
end)

local creds = window:Tab("一次普通的露营故事",'6035145364')

local tool = creds:section("功能",true)   

tool:Button("透视怪物",function()
     loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()
end)

tool:Button("透视其他玩家",function()
     loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()
end)

local creds = window:Tab("汽车经销大亨",'6035145364')

local tool = creds:section("功能",true)

-- 自动刷钱功能
tool:Toggle("自动刷钱", 'Toggleflag', false, function(dsd)
    getgenv().Auto = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().Auto then
                break
            end
            
            -- 创建三个平台用于传送
            local part = Instance.new("Part")
            part.Position = Vector3.new(0,60,0)
            part.Size = Vector3.new(1000,5,1000)
            part.Anchored = true
            part.Name = "Keaths Platform"
            part.CollisionGroupId = 5
            part.Parent = workspace

            local part2 = Instance.new("Part")
            part2.Position = Vector3.new(0,10,0)
            part2.Size = Vector3.new(1000,5,1000)
            part2.Anchored = true
            part2.Name = "Keaths Platform"
            part2.CollisionGroupId = 5
            part2.Parent = workspace

            local part3 = Instance.new("Part")
            part3.Position = Vector3.new(0,99,0)
            part3.Size = Vector3.new(1000,5,1000)
            part3.Anchored = true
            part3.Name = "Keaths Platform"
            part3.CollisionGroupId = 5
            part3.Parent = workspace

            -- 循环传送车辆
            while getgenv().Auto do
                wait(0.1)
                local chr = game.Players.LocalPlayer.Character
                local car = chr.Humanoid.SeatPart.Parent.Parent
                car:PivotTo(CFrame.new(0,0,0))
                wait(0.81)
                car:PivotTo(part.CFrame)
                wait(1)
                car:PivotTo(part2.CFrame)
                wait(1)
                car:PivotTo(part3.CFrame)
            end
        end
    end)
end)

-- 自动建造功能
tool:Toggle("自动建造", 'Toggleflag', false, function(state)
    getgenv().buyer = (state and true or false)
    while getgenv().buyer do
        task.wait()
        local function plot()
            for i,v in pairs(workspace.Tycoons:GetDescendants()) do
                if v.Name == "Owner" and v.ClassName == "StringValue" and v.Value == game.Players.LocalPlayer.Name then
                    local tycoon = v.Parent
                    return tycoon
                end
            end
        end
        
        pcall(function()
            for i,v in pairs(plot().Dealership.Purchases:GetChildren()) do 
                if getgenv().buyer == true and v.TycoonButton.Button.Transparency == 0 then
                    game:GetService("ReplicatedStorage").Remotes.Build:FireServer("BuyItem", v.Name)
                    wait(0.3)
                end 
            end   
        end)
    end
end)

-- 自动完成赛季11比赛功能
tool:Toggle("自动完成赛季11比赛", 'Toggleflag', false, function(dsd)
    getgenv().season = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().season then
                break
            end
            for i, v in pairs(game:GetService("Workspace").Races.Season.Checkpoints:GetDescendants()) do
                if v.Name == "IsActive" and v.Value == true and v.Parent.Name ~= "20" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                elseif v.Name == "IsActive" and v.Value == true and v.Parent.Name == "20" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                    car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                end
                task.wait(0.2)
            end
        end
    end)
end)

-- 自动完成圆形赛功能
tool:Toggle("自动完成圆形赛", 'Toggleflag', false, function(dsd)
    getgenv().oval = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().oval then
                break
            end
            for i, v in pairs(game:GetService("Workspace").Races.Race.Oval.Checkpoints:GetDescendants()) do
                if v.Name == "IsActive" and v.Value == true and v.Parent.Name ~= "4" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                elseif v.Name == "IsActive" and v.Value == true and v.Parent.Name == "4" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                    car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                end
                task.wait(0.2)
            end
        end
    end)
end)

-- 自动完成卡丁车赛功能
tool:Toggle("自动完成卡丁车赛", 'Toggleflag', false, function(dsd)
    getgenv().gokart = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().gokart then
                break
            end
            for i, v in pairs(game:GetService("Workspace").Races.Race.Gokart.Checkpoints:GetDescendants()) do
                if v.Name == "IsActive" and v.Value == true and v.Parent.Name ~= "9" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                elseif v.Name == "IsActive" and v.Value == true and v.Parent.Name == "9" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                    car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                end
                task.wait(0.2)
            end
        end
    end)
end)

-- 自动完成转圈赛功能
tool:Toggle("自动完成转圈赛", 'Toggleflag', false, function(dsd)
    getgenv().circuit = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().circuit then
                break
            end
            for i, v in pairs(game:GetService("Workspace").Races.Race.Circuit.Checkpoints:GetDescendants()) do
                if v.Name == "IsActive" and v.Value == true and v.Parent.Name ~= "13" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                elseif v.Name == "IsActive" and v.Value == true and v.Parent.Name == "13" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                    car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                end
                task.wait(0.2)
            end
        end
    end)
end)

-- 自动完成漂移赛功能
tool:Toggle("自动完成漂移赛", 'Toggleflag', false, function(state)
    _G.racetest3 = (state and true or false)
    
    if _G.racetest3 == false then
        local distance = math.huge
        for a, b in pairs(workspace.DriftTrack:GetDescendants()) do
            if b.Name == "DriftAsphalt" and b.Parent.Name == "Model" then
                local Dist = (Vector3.new(-2567.529296875, 601.9335327148438, 2018.6964111328125) - b.Position).magnitude
                if Dist < distance then
                    distance = Dist
                    partvelo = b
                end
            end
        end
        partvelo.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 0
    end
    
    while _G.racetest3 do
        wait()
        if game:GetService("Players").LocalPlayer.PlayerGui.Menu.Race.Visible == false then
            local chr = game.Players.LocalPlayer.Character
            local car = chr.Humanoid.SeatPart.Parent.Parent
            car:PivotTo(CFrame.new(-2502.25146484375, 601.9251708984375, 2013.3966064453125))
            car.Engine.Velocity = Vector3.new(0,0,0)
            chr.Head.Anchored = true
            car.Engine.Velocity = Vector3.new(0,0,0)
            wait(1)
            car.Engine.Velocity = Vector3.new(0,0,0)
            chr.Head.Anchored = false
            car.Engine.Velocity = Vector3.new(0,0,0)
            wait(1)
            workspace.Races.RaceHandler.StartLobby:FireServer("Drift")
            partvelo = nil
            repeat 
                wait()
                if game.Players.LocalPlayer:DistanceFromCharacter(Vector3.new(-2502.25146484375, 601.9251708984375, 2013.3966064453125)) > 10 then
                    car:PivotTo(CFrame.new(-2502.25146484375, 601.9251708984375, 2013.3966064453125))
                    car.Engine.Velocity = Vector3.new(0,0,0)
                    wait(0.1)
                    workspace.Races.RaceHandler.StartLobby:FireServer("Drift")
                end
            until game:GetService("Players").LocalPlayer.PlayerGui.Menu.Race.Visible == true or _G.racetest3 == false
            
        elseif game:GetService("Players").LocalPlayer.PlayerGui.Menu.Race.Visible == true then
            if partvelo == nil then
                local distance = math.huge
                for a, b in pairs(workspace.DriftTrack:GetDescendants()) do
                    if b.Name == "DriftAsphalt" and b.Parent.Name == "Model" then
                        local Dist = (Vector3.new(-2567.529296875, 601.9335327148438, 2018.6964111328125) - b.Position).magnitude
                        if Dist < distance then
                            distance = Dist
                            partvelo = b
                        end
                    end
                end
                partvelo.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * 1000
            end
            
            if game.Players.LocalPlayer:DistanceFromCharacter(partvelo.Position) > 10 then
                local chr = game.Players.LocalPlayer.Character
                local car = chr.Humanoid.SeatPart.Parent.Parent
                car:PivotTo(partvelo.CFrame)
            end
            task.wait()
        end
    end
end)

-- 自动完成警察抓小偷赛功能
tool:Toggle("自动完成警察抓小偷赛", 'Toggleflag', false, function(dsd)
    getgenv().police = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().police then
                break
            end
            for i, v in pairs(game:GetService("Workspace").Races.Police.Checkpoints:GetDescendants()) do
                if v.Name == "IsActive" and v.Value == true and v.Parent.Name ~= "18" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                elseif v.Name == "IsActive" and v.Value == true and v.Parent.Name == "18" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                    car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                end
                task.wait(0.2)
            end
        end
    end)
end)

-- 自动完成城市赛功能
tool:Toggle("自动完成城市赛", 'Toggleflag', false, function(dsd)
    getgenv().city = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().city then
                break
            end
            for i, v in pairs(game:GetService("Workspace").Races.City.City.Checkpoints:GetDescendants()) do
                if v.Name == "IsActive" and v.Value == true and v.Parent.Name ~= "17" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                elseif v.Name == "IsActive" and v.Value == true and v.Parent.Name == "17" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                    car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                end
                task.wait(0.2)
            end
        end
    end)
end)

-- 自动完成公路赛功能
tool:Toggle("自动完成公路赛", 'Toggleflag', false, function(dsd)
    getgenv().highway = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().highway then
                break
            end
            for i, v in pairs(game:GetService("Workspace").Races.City.Highway.Checkpoints:GetDescendants()) do
                if v.Name == "IsActive" and v.Value == true and v.Parent.Name ~= "23" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                elseif v.Name == "IsActive" and v.Value == true and v.Parent.Name == "23" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                    car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                end
                task.wait(0.2)
            end
        end
    end)
end)

-- 自动完成山脉赛功能
tool:Toggle("自动完成山脉赛", 'Toggleflag', false, function(dsd)
    getgenv().mountain = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().mountain then
                break
            end
            for i, v in pairs(game:GetService("Workspace").Races.Mountain.Checkpoints:GetDescendants()) do
                if v.Name == "IsActive" and v.Value == true and v.Parent.Name ~= "26" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                elseif v.Name == "IsActive" and v.Value == true and v.Parent.Name == "26" then
                    local chr = game:GetService("Players").LocalPlayer.Character
                    local car = chr.Humanoid.SeatPart.Parent.Parent
                    car:PivotTo(CFrame.new(v.Parent.Checkpoint.Position))
                    task.wait(0.2)
                    car:PivotTo(CFrame.new(v.Parent.Parent.Parent.GoalPart.Position))
                end
                task.wait(0.2)
            end
        end
    end)
end)

tool:Toggle("自动完成海绵赛", 'Toggleflag', false, function(dsd)
    getgenv().Sponge = dsd
    task.spawn(function()
        while task.wait() do
            if not getgenv().Sponge then
                break
            end
            
            local chr = game.Players.LocalPlayer.Character
            local car = chr.Humanoid.SeatPart.Parent.Parent
            
            -- 按顺序传送到各个检查点
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["1"].Checkpoint.CFrame)
            wait(1)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["2"].Checkpoint.CFrame)
            wait(0.1)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["3"].Checkpoint.CFrame)
            wait(1)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["4"].Checkpoint.CFrame)
            wait(0.1)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["5"].Checkpoint.CFrame)
            wait(1)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["6"].Checkpoint.CFrame)
            wait(0.1)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["7"].Checkpoint.CFrame)
            wait(1)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["8"].Checkpoint.CFrame)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["9"].Checkpoint.CFrame)
            wait(1)
            car:PivotTo(workspace.Races.SpongeBobRace.Checkpoints["10"].Checkpoint.CFrame)
            wait(0.2)
            car:PivotTo(part.CFrame)
        end
    end)
end)

local creds = window:Tab("超级大力士",'6035145364')

local tool = creds:section("功能",true)

tool:Button("传送到开始区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(85.86943817138672, 11.751949310302734, -198.07127380371094)
end)

tool:Button("传送到健身区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(93.60747528076172, 11.751947402954102, -10.266206741333008)
end)

tool:Button("传送到食物区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(78.86384582519531, 11.751947402954102, 228.9690399169922)
end)

tool:Button("传送到街机区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(88.99887084960938, 11.751949310302734, 502.90997314453125)
end)

tool:Button("传送到农场区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(85.6707763671875, 11.751947402954102, 788.5997314453125)
end)

tool:Button("传送到城堡区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(84.87281036376953, 11.84177017211914, 1139.7509765625)
end)

tool:Button("传送到蒸汽朋克区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(92.63227081298828, 11.841767311096191, 1692.7890625)
end)

tool:Button("传送到迪斯科区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(98.69613647460938, 16.015085220336914, 2505.213134765625)
end)

tool:Button("传送到太空区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(88.42948150634766, 11.841769218444824, 3425.941650390625)
end)

tool:Button("传送到糖果区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(63.55805969238281, 11.841663360595703, 4340.69921875)
end)

tool:Button("送到实验室区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(78.00920867919922, 11.841663360595703, 5226.60205078125)
end)

tool:Button("传送到热带区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80.26090240478516, 12.0902681350708, 6016.16552734375)
end)

tool:Button("传送到恐龙区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(38.4753303527832, 25.801530838012695, 6937.779296875)
end)

tool:Button("传送到复古区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99.81867218017578, 12.89099407196045, 7901.74755859375)
end)

tool:Button("传送到冬季区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(63.47243881225586, 11.841662406921387, 8983.810546875)
end)

tool:Button("传送到深海区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(105.36250305175781, 26.44820213317871, 9970.0849609375)
end)

tool:Button("传送到狂野西部区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.69414520263672, 15.108586311340332, 10938.654296875)
end)

tool:Button("传送到豪华公寓区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.75145721435547, 11.313281059265137, 12130.349609375)
end)

tool:Button("传送到宝剑战斗区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(111.25597381591797, 11.408829689025879, 12945.57421875)
end)

tool:Button("传送到童话区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(121.14932250976562, 11.313281059265137, 14034.50390625)
end)

tool:Button("传送到桃花区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108.2142333984375, 11.813281059265137, 15131.861328125)
end)

tool:Button("传送到厨房区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.78338623046875, 21.76291847229004, 16204.9755859375)
end)

tool:Button("传送到下水道区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(47.36086654663086, 12.25178050994873, 17656.04296875)
end)

local creds = window:Tab("刀刃球",'6035145364')

local tool = creds:section("功能",true)

tool:Button("刀刃1",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/daorenqiu"))()
end)

tool:Button("刀刃2",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/main/RedCircleBlock"))()
end)

tool:Button("刀刃自动格挡",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3ABlade%20Ball%20Parry%20V4.0.0",true))()
end)

local creds = window:Tab("格林维尔",'6035145364')

local tool = creds:section("功能",true)

tool:Button("格林维尔",function()
loadstring(game:HttpGet("https://github.com/root-jiege/new/raw/refs/heads/main/KO"))()
end)

tool:Button("格林维尔2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8643/test/main/green"))()
end)

local creds = window:Tab("超级足球联赛",'6035145364')

local tool = creds:section("功能",true)

tool:Button("超级足球联赛1",function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/xtrey10x/xtrey10x-hub/main/neo")()
end)

tool:Button("超级足球联赛2",function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8fdf7c482d3b3d108ccdb282a7fc35e2.lua"))()
end)

local creds = window:Tab("河北唐县",'6035145364')

local tool = creds:section("功能",true)
tool:Label("需要先成为送货司机，才能自动刷钱")
local function autoFarm()
    while _G.autoFarm do
        local clickDetector = game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector
        if clickDetector then
            local success, errorMsg = pcall(function()
                fireclickdetector(clickDetector)
            end)
            if not success then
                warn("Failed to fire ClickDetector: " .. errorMsg)
            end
        else
            warn("ClickDetector not found!")
        end
        
        task.wait(2.2)

        local deliveryPoints = game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()
        local delivered = false
        for _, point in ipairs(deliveryPoints) do
            if point:FindFirstChild("Locate") and point.Locate.Locate.Enabled then
                local hrp = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = point.CFrame
                    delivered = true
                    break
                end
            end
        end
        
        if not delivered then
            warn("No delivery point found!")
        end

        task.wait(0)
    end
end

tool:Toggle("自动刷钱", "AL", false, function(AM)
    _G.autoFarm = AM
    
    if AM then
        if not _G.autoFarmThread or not _G.autoFarmThread.Running then
            _G.autoFarmThread = coroutine.create(autoFarm)
            coroutine.resume(_G.autoFarmThread)
        end
    else
        if _G.autoFarmThread and _G.autoFarmThread.Running then
            coroutine.close(_G.autoFarmThread)
        end
    end
end)

tool:Toggle("自动刷钱", "AM", false, function(AM)
    local virtualUser = game:GetService('VirtualUser') virtualUser:CaptureController() function teleportTo(CFrame) game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame end _G.autoFarm = false function autoFarm() while _G.autoFarm do fireclickdetector(game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector) task.wait(2.2) for _,point in pairs(game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()) do if point.Locate.Locate.Enabled then teleportTo(point.CFrame) end end task.wait(0) end end
end)
tool:Label("变身功能")
local function autoFarm()
    while _G.autoFarm do
        local clickDetector = game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector
        if clickDetector then
            local success, errorMsg = pcall(function()
                fireclickdetector(clickDetector)
            end)
            if not success then
                warn("Failed to fire ClickDetector: " .. errorMsg)
            end
        else
            warn("ClickDetector not found!")
        end
        
        task.wait(2.2)

        local deliveryPoints = game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()
        local delivered = false
        for _, point in ipairs(deliveryPoints) do
            if point:FindFirstChild("Locate") and point.Locate.Locate.Enabled then
                local hrp = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = point.CFrame
                    delivered = true
                    break
                end
            end
        end
        
        if not delivered then
            warn("No delivery point found!")
        end

        task.wait(0)
    end
end

tool:Button("变成警察(需要先购买警察通行证)", function()
    local args = {
    [1] = "Police"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成平民", function()
    local args = {
    [1] = "Civilian"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成混合冰淇淋", function()
    local args = {
    [1] = "Mixue Ice Cream"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成咖啡师", function()
    local args = {
    [1] = "Teawen Barista"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成送货司机", function()
    local args = {
    [1] = "Delivery Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)


tool:Button("变成出租车司机", function()
    local args = {
    [1] = "Taxi Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)


tool:Button("变成线上计程车", function()
    local args = {
    [1] = "Ole Online Taxi Sharing"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成卡车司机", function()
    local args = {
    [1] = "Trucker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成超市收银员", function()
    local args = {
    [1] = "Grocery Cashier"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成罪犯", function()
    local args = {
    [1] = "Criminal"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成学生", function()
    local args = {
    [1] = "Student"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成老师", function()
    local args = {
    [1] = "Teacher"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成商店员工", function()
    local args = {
    [1] = "Store Worker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成变pao商店工人", function()
    local args = {
    [1] = "Pao Store Worker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成救援人员", function()
    local args = {
    [1] = "Paramedic"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成巴车司机", function()
    local args = {
    [1] = "Bus Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Label("传送")
local function autoFarm()
    while _G.autoFarm do
        local clickDetector = game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector
        if clickDetector then
            local success, errorMsg = pcall(function()
                fireclickdetector(clickDetector)
            end)
            if not success then
                warn("Failed to fire ClickDetector: " .. errorMsg)
            end
        else
            warn("ClickDetector not found!")
        end
        
        task.wait(2.2)

        local deliveryPoints = game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()
        local delivered = false
        for _, point in ipairs(deliveryPoints) do
            if point:FindFirstChild("Locate") and point.Locate.Locate.Enabled then
                local hrp = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = point.CFrame
                    delivered = true
                    break
                end
            end
        end
        
        if not delivered then
            warn("No delivery point found!")
        end

        task.wait(0)
    end
end

tool:Button("警察局", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5513.97412109375, 8.656171798706055, 4964.291015625)
end)
tool:Button("出生点", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3338.31982421875, 10.048742294311523, 3741.84033203125)
end)
tool:Button("医院", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5471.482421875, 14.149418830871582, 4259.75341796875)
end)
tool:Button("手机店", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6789.2041015625, 11.197686195373535, 1762.687255859375)
end)
tool:Button("火锅店", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5912.84765625, 12.217276573181152, 1058.29443359375)
end)

tool:Button("蜜雪冰城",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6984.87158203125, 9.332854270935059, 1734.770751953125)
end)

tool:Button("小区",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2187.541259765625, 22.092992782592773, -636.7048950195312)
end)

tool:Button("洗车店",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2578.51025390625, 23.332923889160156, -588.5584716796875)
end)

tool:Button("卡车召唤地",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10559.13671875, 39.31748580932617, 3236.519287109375)
end)

tool:Button("庆都山山顶",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15042.9033203125, 325.29852294921875, 22355.177734375)
end)

tool:Button("庆都山山底",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15580.1357421875, 8.09992790222168, 21171.939453125)
end)

tool:Button("小学",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13888.138671875, 10.943490982055664, 11059.0458984375)
end)

tool:Button("签挂美食",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10332.763671875, 10.43997859954834, 7114.16064453125)
end)

tool:Button("驾校",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8912.12109375, 9.963741302490234, 7302.568359375)
end)

local creds = window:Tab("造船寻宝",'6035145364')

local tool = creds:section("功能",true)

    tool:Toggle(
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
tool:Toggle(
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
tool:Toggle(
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

tool:Button(
    "无限方块（假）",
    function()
        spawn(
            function()
                local guiinf =
                    game:GetService("Players").LocalPlayer.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame
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

local creds = window:Tab("杀手vs警长",'6035145364')

local tool = creds:section("透视功能",true)

tool:Button("透视", function()
    while wait(1) do
        local function ApplyESP(v)
            if v.Character and v.Character:FindFirstChildOfClass('Humanoid') then
                v.Character.Humanoid.NameDisplayDistance = 9e9
                v.Character.Humanoid.NameOcclusion = "NoOcclusion"
                v.Character.Humanoid.HealthDisplayDistance = 9e9
                v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
                v.Character.Humanoid.Health = v.Character.Humanoid.Health 
            end
        end
        
        for i, v in pairs(game.Players:GetPlayers()) do
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
    end
end)

local tool = creds:section("范围功能",true)

tool:Slider('范围', '拉条', 1, 1, 50, false, function(v)
    _G.HeadSize = v
    _G.Disabled = true
    
    game:GetService('RunService').RenderStepped:connect(function()
        if _G.Disabled then
            for i, v in next, game:GetService('Players'):GetPlayers() do
                if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                    pcall(function()
                        v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
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

local tool = creds:section("子追功能",true)

tool:Button("子弹追踪", function()
    local plrs = game:GetService("Players")
    local rs = game:GetService("ReplicatedStorage")
    local shootRemote = rs.Remotes.Shoot
    
    local function isTeammate(model)
        local highlight = model:FindFirstChild("Highlight")
        return highlight and highlight.FillColor == Color3.fromRGB(30, 214, 134)
    end
    
    local function isRagdoll(model)
        return not model:FindFirstChild("Animate")
    end
    
    local plr = plrs.LocalPlayer
    local mouse = plr:GetMouse()
    local camera = workspace.CurrentCamera
    
    local r15BodyParts = {
        "Head",
        "UpperTorso",
        "LowerTorso",
        "LeftUpperArm",
        "LeftLowerArm",
        "LeftHand",
        "RightUpperArm",
        "RightLowerArm",
        "RightHand",
        "LeftUpperLeg",
        "LeftLowerLeg",
        "LeftFoot",
        "RightUpperLeg",
        "RightLowerLeg",
        "RightFoot"
    }
    
    local function isCharacterOnScreen(playerCharacter)
        local playerHead = playerCharacter:WaitForChild("Head")
        local screenPos, isOnScreen = camera:WorldToViewportPoint(playerHead.Position)
        return isOnScreen
    end
    
    local function getClosestPlayerToMouse()
        local closestPlayer = nil
        local shortestDistance = math.huge
        for _, otherPlayer in plrs:GetPlayers() do
            local char = otherPlayer.Character
            if (not char) or otherPlayer == plr or isTeammate(char) or isRagdoll(char) or (not workspace:FindFirstChild(otherPlayer.Name)) or (not isCharacterOnScreen(char)) then
                continue
            end
            if char:FindFirstChild("HumanoidRootPart") then
                local playerPosition = char.HumanoidRootPart.Position
                local mousePosition = mouse.Hit.Position
                local distance = (mousePosition - playerPosition).magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
        return closestPlayer
    end
    
    mouse.Button1Down:Connect(function()
        if plr.Character:FindFirstChildOfClass("Tool") then
            local closestPlayer = getClosestPlayerToMouse()
            if closestPlayer then
                shootRemote:FireServer(Vector3.new(1,1,1), Vector3.new(1,1,1), closestPlayer.Character[r15BodyParts[math.random(1,#r15BodyParts)]], Vector3.new(1,1,1))
            end
        end
    end)
end)

local creds = window:Tab("拳击模拟器",'6035145364')

local tool = creds:section("功能",true)

-- 自动拳击功能
tool:Toggle("自动拳击", "", false, function(Value)
    getgenv().autoPunch = Value
    while wait() do
        if not getgenv().autoPunch then break end
        game:GetService("ReplicatedStorage")["Events"]["DamageIncreaseOnClickEvent"]:FireServer()
    end
end)

-- 自动领取礼物功能
tool:Toggle("自动领取礼物", "", false, function(Value)
    getgenv().autoGift = Value
    while wait() do
        if not getgenv().autoGift then break end
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(1)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(2)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(3)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(4)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(5)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(6)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(7)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(8)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(9)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(10)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(11)
        game:GetService("ReplicatedStorage")["Events"]["PlaytimeRewardUpdateEvent"]:FireServer(12)
    end
end)

-- 自动领取任务功能
tool:Toggle("自动领取任务", "", false, function(Value)
    getgenv().autoTask = Value
    while wait() do
        if not getgenv().autoTask then break end
        game:GetService("ReplicatedStorage")["Events"]["QuestEvent"]:InvokeServer("Claim")
    end
end)

-- 自动上升功能
tool:Toggle("自动上升", "", false, function(Value)
    getgenv().autoAscend = Value
    while wait() do
        if not getgenv().autoAscend then break end
        game:GetService("ReplicatedStorage")["Events"]["AscendEvent"]:FireServer(true)
    end
end)

-- 自动抽奖功能
tool:Toggle("自动抽奖", "", false, function(Value)
    getgenv().autoSpin = Value
    while wait() do
        if not getgenv().autoSpin then break end
        game:GetService("ReplicatedStorage")["Events"]["SpinWheelEvent"]:FireServer("Spin")
        game:GetService("ReplicatedStorage")["Events"]["SpinWheelEvent"]:FireServer("SpinComplete")
    end
end)

-- 自动领取免费获胜功能
tool:Toggle("自动领取免费获胜", "", false, function(Value)
    getgenv().autoFreeWins = Value
    while wait() do
        if not getgenv().autoFreeWins then break end
        game:GetService("ReplicatedStorage")["Events"]["FreeRobloxShop"]:FireServer()
    end
end)

local creds = window:Tab("逃出建筑",'6035145364')

local tool = creds:section("功能",true)

-- 透视玩家功能
tool:Toggle("透视玩家", "", false, function(state)
    if state == true then
        for i, v in pairs(game.Players:GetChildren()) do
            if v:IsA("Player") and v.Name ~= game.Players.LocalPlayer.Name then
                pcall(function()
                    local transparency = 0.5
                    local Folder = Instance.new("Folder", v.Character)
                    Folder.Name = v.Name .. "'s ESP"
                    
                    -- Head
                    local Head = Instance.new("BoxHandleAdornment", Folder)
                    Head.AlwaysOnTop = true
                    Head.Adornee = v.Character.Head
                    Head.ZIndex = 1
                    Head.Name = "Head"
                    Head.Transparency = transparency
                    Head.Size = v.Character.Head.Size
                    
                    -- Torso
                    local Torso = Instance.new("BoxHandleAdornment", Folder)
                    Torso.AlwaysOnTop = true
                    Torso.Adornee = v.Character.Torso
                    Torso.ZIndex = 1
                    Torso.Name = "Torso"
                    Torso.Transparency = transparency
                    Torso.Size = v.Character.Torso.Size
                    
                    -- Left Arm
                    local LeftArm = Instance.new("BoxHandleAdornment", Folder)
                    LeftArm.AlwaysOnTop = true
                    LeftArm.Adornee = v.Character["Left Arm"]
                    LeftArm.ZIndex = 1
                    LeftArm.Name = "LeftArm"
                    LeftArm.Transparency = transparency
                    LeftArm.Size = v.Character["Left Arm"].Size
                    
                    -- Right Arm
                    local RightArm = Instance.new("BoxHandleAdornment", Folder)
                    RightArm.AlwaysOnTop = true
                    RightArm.Adornee = v.Character["Right Arm"]
                    RightArm.ZIndex = 1
                    RightArm.Name = "RightArm"
                    RightArm.Transparency = transparency
                    RightArm.Size = v.Character["Right Arm"].Size
                    
                    -- Right Leg
                    local RightLeg = Instance.new("BoxHandleAdornment", Folder)
                    RightLeg.AlwaysOnTop = true
                    RightLeg.Adornee = v.Character["Right Leg"]
                    RightLeg.ZIndex = 1
                    RightLeg.Name = "RightLeg"
                    RightLeg.Transparency = transparency
                    RightLeg.Size = v.Character["Right Leg"].Size
                    
                    -- Left Leg
                    local LeftLeg = Instance.new("BoxHandleAdornment", Folder)
                    LeftLeg.AlwaysOnTop = true
                    LeftLeg.Name = "LeftLeg"
                    LeftLeg.Adornee = v.Character["Left Leg"]
                    LeftLeg.ZIndex = 1
                    LeftLeg.Transparency = transparency
                    LeftLeg.Size = v.Character["Left Leg"].Size
                    
                    -- Colors based on beast status
                    getgenv().LoopBeastColor = game.RunService.Stepped:Connect(function()
                        if v.TempPlayerStatsModule.IsBeast.Value == true then
                            Head.Color3 = Color3.fromRGB(205, 98, 152)
                            Torso.Color3 = Color3.fromRGB(205, 98, 152)
                            LeftArm.Color3 = Color3.fromRGB(205, 98, 152)
                            RightArm.Color3 = Color3.fromRGB(205, 98, 152)
                            RightLeg.Color3 = Color3.fromRGB(205, 98, 152)
                            LeftLeg.Color3 = Color3.fromRGB(205, 98, 152)
                        elseif v.TempPlayerStatsModule.IsBeast.Value == false then
                            Head.Color3 = Color3.new(225, 1, 1)
                            Torso.Color3 = Color3.new(1, 1, 1)
                            LeftArm.Color3 = Color3.new(1, 1, 1)
                            RightArm.Color3 = Color3.new(1, 1, 1)
                            RightLeg.Color3 = Color3.new(1, 1, 1)
                            LeftLeg.Color3 = Color3.new(1, 1, 1)
                        end
                    end)
                end)
            end
        end
    else
        if getgenv().LoopBeastColor then
            getgenv().LoopBeastColor:Disconnect()
        end
        
        for i, v in pairs(game.Players:GetChildren()) do
            if v:IsA("Player") then
                for i, e in pairs(v.Character:GetChildren()) do
                    if e:IsA("Folder") then
                        pcall(function()
                            e:Destroy()
                        end)
                    end
                end
            end
        end
    end
end)

-- 透视门功能
tool:Toggle("透视门", "", false, function(state)
    if state == true then
        getgenv().DoorESP = false
        
        -- Single doors
        spawn(function()
            for i, v in pairs(workspace:GetDescendants()) do
                if v.Name == "SingleDoor" then
                    pcall(function()
                        local ESP = Instance.new("Highlight")
                        ESP.Parent = v.Door
                    end)
                end
            end
            
            wait(1)
            
            for i, v in pairs(workspace:GetDescendants()) do
                if v.Name == "SingleDoor" then
                    spawn(function()
                        while true do
                            pcall(function()
                                if v.DoorTrigger.ActionSign.Value == 11 then
                                    v.Door.Highlight.FillColor = Color3.new(0, 1, 0)  -- Green
                                elseif v.DoorTrigger.ActionSign.Value == 10 then
                                    v.Door.Highlight.FillColor = Color3.new(1, 0, 0)  -- Red
                                end
                            end)
                            if getgenv().DoorESP == true then
                                break
                            end
                            wait(0.1)
                        end
                    end)
                end
            end
        end)
        
        -- Double doors
        spawn(function()
            for i, v in pairs(workspace:GetDescendants()) do
                if v.Name == "DoubleDoor" then
                    pcall(function()
                        local ESP = Instance.new("Highlight")
                        ESP.Parent = v
                    end)
                end
            end
            
            wait(1)
            
            for i, v in pairs(workspace:GetDescendants()) do
                if v.Name == "DoubleDoor" then
                    spawn(function()
                        while true do
                            pcall(function()
                                if v.DoorTrigger.ActionSign.Value == 11 then
                                    v.Highlight.FillColor = Color3.new(0, 1, 0)  -- Green
                                elseif v.DoorTrigger.ActionSign.Value == 10 then
                                    v.Highlight.FillColor = Color3.new(1, 0, 0)  -- Red
                                end
                            end)
                            if getgenv().DoorESP == true then
                                break
                            end
                            wait(0.1)
                        end
                    end)
                end
            end
        end)
    else
        getgenv().DoorESP = true
        
        -- Single door cleanup
        for i, v in pairs(workspace:GetDescendants()) do
            if v.Name == "SingleDoor" then
                pcall(function()
                    v.Door.Highlight:Destroy()
                end)
            end
        end
        
        -- Double doors cleanup
        for i, v in pairs(workspace:GetDescendants()) do
            if v.Name == "DoubleDoor" then
                pcall(function()
                    v.Highlight:Destroy()
                end)
            end
        end
    end
end)

-- 电脑透视功能
tool:Toggle("电脑透视", "", false, function(state)
    if state == true then
        getgenv().StopComputerESP = false
        
        for i, v in pairs(workspace:GetDescendants()) do 
            if v.Name == "ComputerTable" then
                pcall(function()
                    local ESP = Instance.new("Highlight", v)
                end)
            end
        end
        
        spawn(function()
            while true do
                for i, v in pairs(workspace:GetDescendants()) do
                    if v.Name == "ComputerTable" then
                        if v.Screen.BrickColor == BrickColor.new("Bright blue") then
                            pcall(function()
                                v.Highlight.FillColor = Color3.new(0, 0, 1)  -- Blue
                            end)
                        elseif v.Screen.BrickColor == BrickColor.new("Dark green") then
                            pcall(function()
                                v.Highlight.FillColor = Color3.new(0, 1, 0)  -- Green
                            end)
                        end
                        
                        if getgenv().StopComputerESP == true then
                            break
                        end
                    end
                end
                wait(1)
            end
        end)
    else
        getgenv().StopComputerESP = true
        
        for i, v in pairs(workspace:GetDescendants()) do 
            if v.Name == "ComputerTable" then
                pcall(function()
                    v.Highlight:Destroy()
                end)
            end
        end
    end
end)

-- 冷冻舱透视功能
tool:Toggle("冷冻舱透视", "", false, function(state)
    if state == true then
        for i, v in pairs(workspace:GetDescendants()) do 
            if v.Name == "FreezePod" then
                pcall(function()
                    local ESP = Instance.new("Highlight", v)
                end)
            end
        end
    else
        for i, v in pairs(workspace:GetDescendants()) do 
            if v.Name == "FreezePod" then
                pcall(function()
                    v.Highlight:Destroy()
                end)
            end
        end
    end
end)

-- 加速功能
tool:Toggle("加速", "", false, function(Value)
    getgenv().speedEnabled = Value
    
    local function isNumber(str)
        if tonumber(str) ~= nil or str == 'inf' then
            return true
        end
        return false
    end
    
    local tspeed = 1
    local hb = game:GetService("RunService").Heartbeat
    local tpwalking = Value
    local player = game:GetService("Players")
    local lplr = player.LocalPlayer
    
    while getgenv().speedEnabled and hb:Wait() do
        local chr = lplr.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        
        if chr and hum and hum.Parent then
            if hum.MoveDirection.Magnitude > 0 then
                if tspeed and isNumber(tostring(tspeed)) then
                    chr:TranslateBy(hum.MoveDirection * tonumber(tspeed))
                else
                    chr:TranslateBy(hum.MoveDirection)
                end
            end
        end
    end
end)

-- 黑客永不失败功能
tool:Toggle("黑客永不失败", "", false, function(Value)
    getgenv().hackerNoFail = Value
    
    spawn(function()
        while wait() do
            if not getgenv().hackerNoFail then break end
            game.ReplicatedStorage.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
        end
    end)
end)

-- 抓捕范围功能
tool:Toggle("抓捕范围", "", false, function(Value)
    getgenv().captureRange = Value
    
    if Value and game.Players.LocalPlayer.TempPlayerStatsModule.IsBeast.Value == true then
        game:GetService("Players").LocalPlayer.TempPlayerStatsModule.DisableCrawl.Value = false
    end
end)

-- 删除声音和发光功能
tool:Toggle("删除声音和发光", "", false, function(Value)
    getgenv().removeSoundAndLight = Value
    
    if Value and game.Players.LocalPlayer.TempPlayerStatsModule.IsBeast.Value == true then
        local character = game.Players.LocalPlayer.Character
        if character then
            -- 删除锤子声音
            local hammer = character:FindFirstChild("Hammer")
            if hammer and hammer:FindFirstChild("Handle") then
                for i, v in pairs(hammer.Handle:GetChildren()) do
                    if v:IsA("Sound") then
                        pcall(function()
                            v:Destroy()
                        end)
                    end
                end
            end
            
            -- 删除宝石发光
            local gemstone = character:FindFirstChild("Gemstone")
            if gemstone and gemstone:FindFirstChild("Handle") then
                local pointLight = gemstone.Handle:FindFirstChild("PointLight")
                if pointLight then
                    pcall(function()
                        pointLight:Destroy()
                    end)
                end
            end
        end
    end
end)

local creds = window:Tab("战争大亨",'6035145364')

local tool = creds:section("功能",true)

tool:Button("一枪秒人",function()
    loadstring(game:HttpGet('https://pastebin.com/raw/6b4XEjQF'))()
end)

tool:Button("战争大亨1",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaguya11/KaguHubRework/refs/heads/main/Scripts/Loader.lua", true))("t.me/rbxscript_robot")
end)

tool:Button("战争大亨2",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/megamoeus/UI-Engine-V2/main/OWTPublic"))()
end)

tool:Label("执行一枪秒人和枪改散弹和无限子弹和爆炸狙前请先开一枪")
tool:Button("一枪秒人", function()
  loadstring(game:HttpGet("https://pastebin.com/raw/6b4XEjQF"))()
end)
tool:Button("全图杀人(需要火箭筒才能用)", function()
  loadstring(game:HttpGet("https://pastefy.app/hhiDoFSB/raw"))()
end)
tool:Button("可开关全图杀人①(需要拿着RPG点击)", function()
  loadstring(game:HttpGet("https://pastefy.app/jSgKeb2k/raw"))()
end)
tool:Button("RPG随机针对杀人(需要拿着RPG点击)", function()
  loadstring(game:HttpGet("https://pastefy.app/ed3h9kTB/raw"))()
end)
tool:Button("可开关全图杀人②(需要拿着RPG点击)", function()
  loadstring(game:HttpGet("https://pastefy.app/f9dg3svj/raw"))()
end)
tool:Button("枪改散弹", function()
  loadstring(game:HttpGet("https://pastefy.app/F180SugC/raw"))()
end)
tool:Button("M17手枪针对打人(需要拿着M17点击)", function()
  loadstring(game:HttpGet("https://pastefy.app/l4vfknE7/raw"))()
end)
tool:Button("RPG指定锁人杀人(需要拿着RPG点击)", function()
  loadstring(game:HttpGet("https://pastefy.app/utItxDIM/raw"))()
end)
tool:Button("无限子弹", function()
  loadstring(game:HttpGet("https://pastefy.app/NDzBmK9g/raw"))()
end)
tool:Button("爆炸狙", function()
  loadstring(game:HttpGet("https://pastefy.app/n8FcGgRh/raw"))()
end)
tool:Button("车辆货箱", function()
  for r3_503, r4_503 in pairs(Workspace.Beams:GetChildren()) do
    if r4_503.Name:find("Airdrop_") then
      r137_0.Character.HumanoidRootPart.CFrame = r4_503.CFrame
    end
  end
end)
tool:Button("隔空投送", function()
  for r3_697, r4_697 in pairs(Workspace.Beams:GetChildren()) do
    if r4_697.Name:find("Warehouse") then
      r137_0.Character.HumanoidRootPart.CFrame = Workspace.Beams[r4_697.Name].CFrame
      break
    end
  end
end)
tool:Button("油桶", function()
  for r3_450, r4_450 in pairs(Workspace.Beams:GetChildren()) do
    if r4_450.Name:find("Warehouse") then
      r137_0.Character.HumanoidRootPart.CFrame = Workspace.Beams[r4_450.Name].CFrame
      break
    end
  end
end)
tool:Button("直接占领旗帜", function()
  loadstring(game:HttpGet("https://pastefy.app/TlqEOJU7/raw"))()
end)
tool:Label("传送功能")
tool:Button("传送到空投", function()
  local r1_492 = game.Players.LocalPlayer.Character.HumanoidRootPart
  for r5_492, r6_492 in ipairs(workspace["Game Systems"]:GetDescendants()) do
    if r6_492.Name:match("Airdrop_") then
      r1_492.CFrame = r6_492.MainPart.CFrame
    end
  end
end)
tool:Button("传送自己的基地", function()
  game:GetService("Players").LocalPlayer.Character:MoveTo(workspace.Tycoon.Tycoons[game:GetService("Players").LocalPlayer.leaderstats.Team.Value].Essentials.Spawn.Position)
end)
tool:Button("酒店基地", function()
  local r0_63 = game.Players.LocalPlayer.Character.HumanoidRootPart
  local r1_63 = CFrame.new(2853, 48, -1282)
  game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
  wait(0.2)
  r0_63.CFrame = r1_63
end)
tool:Button("传送旗帜", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(73.22032928466797, 47.9999885559082, 191.06993103027344)
end)
tool:Button("传送油桶1", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9.748652458190918, 48.662540435791016, 700.2245483398438)
end)
tool:Button("传送油桶2", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(76.48243713378906, 105.25657653808594, -2062.3896484375)
end)
tool:Button("传送油桶3", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28.840208053588867, 49.34040069580078, -416.9921569824219)
end)
tool:Button("传送油桶4", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(69.48390197753906, 105.25657653808594, 3434.9033203125)
end)

local creds = window:Tab("画质",'6035145364')

local tool = creds:section("功能",true)

tool:Button("光影", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

tool:Button("光影滤镜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

tool:Button("超高画质",function()
loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

tool:Button("光影V4",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

tool:Button("RTX高仿",function()
loadstring(game:HttpGet('https://pastebin.com/raw/Bkf0BJb3'))()
end)

tool:Toggle("画质增强","GraphicsToggle",false,function(Value)
    -- 画质增强脚本（提升饱和度和画质，优化性能）
    local Lighting = game:GetService("Lighting")
    local RunService = game:GetService("RunService")
    
    local isRunning = Value
    local originalSettings = {}
    
    -- 保存原始设置
    local function saveOriginalSettings()
        originalSettings = {
            Brightness = Lighting.Brightness,
            GlobalShadows = Lighting.GlobalShadows,
            Ambient = Lighting.Ambient,
            OutdoorAmbient = Lighting.OutdoorAmbient,
            ColorShift_Bottom = Lighting.ColorShift_Bottom,
            ColorShift_Top = Lighting.ColorShift_Top,
            EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
            EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
            FogColor = Lighting.FogColor,
            FogEnd = Lighting.FogEnd,
            FogStart = Lighting.FogStart,
            ExposureCompensation = Lighting.ExposureCompensation,
            ShadowSoftness = Lighting.ShadowSoftness,
            Technology = Lighting.Technology,
            ClockTime = Lighting.ClockTime
        }
    end

    -- 应用画质增强设置
    local function applyEnhancedGraphics()
        -- 光照设置
        Lighting.Brightness = 2.5  -- 提高亮度
        Lighting.GlobalShadows = true  -- 启用全局阴影
        Lighting.Ambient = Color3.fromRGB(80, 80, 80)  -- 环境光
        Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)  -- 室外环境光
        
        -- 颜色增强（提高饱和度）
        Lighting.ColorShift_Bottom = Color3.fromRGB(10, 5, 0)  -- 暖色调
        Lighting.ColorShift_Top = Color3.fromRGB(5, 10, 15)  -- 冷色调
        
        -- 环境反射
        Lighting.EnvironmentDiffuseScale = 1.2  -- 提高漫反射
        Lighting.EnvironmentSpecularScale = 1.3  -- 提高镜面反射
        
        -- 雾效设置（增强深度感）
        Lighting.FogColor = Color3.fromRGB(150, 180, 210)
        Lighting.FogEnd = 1500
        Lighting.FogStart = 100
        
        -- 曝光补偿
        Lighting.ExposureCompensation = 0.3  -- 稍微提高曝光
        
        -- 阴影质量
        Lighting.ShadowSoftness = 0.8  -- 柔和阴影
        
        -- 使用最高质量渲染技术
        if Lighting.Technology == Enum.Technology.Voxel or Lighting.Technology == Enum.Technology.ShadowMap then
            Lighting.Technology = Enum.Technology.Future  -- 未来技术
        end
        
        -- 设置最佳时间（正午，光线最好）
        Lighting.ClockTime = 14  -- 下午2点
    end
    
    -- 应用后期处理效果
    local function applyPostProcessing()
        -- 创建颜色校正效果
        local colorCorrection = Instance.new("ColorCorrectionEffect")
        colorCorrection.Name = "EnhancedColorCorrection"
        colorCorrection.Brightness = 0.05
        colorCorrection.Contrast = 0.1
        colorCorrection.Saturation = 0.3  -- 提高饱和度
        colorCorrection.TintColor = Color3.fromRGB(255, 250, 245)  -- 暖色调
        colorCorrection.Parent = Lighting
        
        -- 创建Bloom效果（光晕）
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "EnhancedBloom"
        bloom.Intensity = 0.4
        bloom.Size = 24
        bloom.Threshold = 0.9
        bloom.Parent = Lighting
        
        -- 创建景深效果（可选）
        local depthOfField = Instance.new("DepthOfFieldEffect")
        depthOfField.Name = "EnhancedDepthOfField"
        depthOfField.FarIntensity = 0.1
        depthOfField.NearIntensity = 0.3
        depthOfField.FocusDistance = 0.05
        depthOfField.InFocusRadius = 10
        depthOfField.Parent = Lighting
        
        -- 太阳光线效果
        local sunRays = Instance.new("SunRaysEffect")
        sunRays.Name = "EnhancedSunRays"
        sunRays.Intensity = 0.3
        sunRays.Spread = 1
        sunRays.Parent = Lighting
    end
    
    -- 优化天空盒
    local function enhanceSkybox()
        -- 设置高质量天空盒
        Lighting.Sky.MoonAngularSize = 11
        Lighting.Sky.SunAngularSize = 21
        
        -- 提高星星亮度
        if Lighting:FindFirstChild("StarCount") then
            Lighting.StarCount = 5000  -- 更多星星
        end
    end
    
    -- 性能优化监控
    local function setupPerformanceMonitor()
        local frameCount = 0
        local lastCheck = tick()
        
        local monitorConnection
        monitorConnection = RunService.Heartbeat:Connect(function()
            if not isRunning then
                monitorConnection:Disconnect()
                return
            end
            
            frameCount = frameCount + 1
            
            -- 每5秒检查一次性能
            if tick() - lastCheck >= 5 then
                lastCheck = tick()
                
                -- 如果帧率过低，自动降低一些效果
                local fps = frameCount / 5
                frameCount = 0
                
                if fps < 30 then
                    -- 自动调整效果保持性能
                    local bloom = Lighting:FindFirstChild("EnhancedBloom")
                    if bloom then
                        bloom.Intensity = math.min(bloom.Intensity, 0.2)
                    end
                end
            end
        end)
        
        return monitorConnection
    end
    
    -- 恢复原始设置
    local function restoreOriginalSettings()
        for setting, value in pairs(originalSettings) do
            pcall(function()
                Lighting[setting] = value
            end)
        end
        
        -- 移除后期处理效果
        local effects = {
            "EnhancedColorCorrection",
            "EnhancedBloom", 
            "EnhancedDepthOfField",
            "EnhancedSunRays"
        }
        
        for _, effectName in ipairs(effects) do
            local effect = Lighting:FindFirstChild(effectName)
            if effect then
                effect:Destroy()
            end
        end
    end
    
    -- 主执行函数
    if Value then
        -- 开启画质增强
        saveOriginalSettings()
        applyEnhancedGraphics()
        applyPostProcessing()
        enhanceSkybox()
        local monitorConnection = setupPerformanceMonitor()
        
        print("画质增强已激活 - 饱和度和视觉效果提升")
        
        -- 返回关闭函数
        return function()
            isRunning = false
            if monitorConnection then
                monitorConnection:Disconnect()
            end
            restoreOriginalSettings()
            print("画质增强已关闭")
        end
        
    else
        -- 关闭画质增强
        restoreOriginalSettings()
        print("画质增强已关闭")
    end
end)

tool:Button("光影深", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

tool:Button("光影浅", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

local creds = window:Tab("透视",'6035145364')

local tool = creds:section("功能",true)

tool:Button("查看游戏中的所有玩家（包括血量条）", function()
    assert(Drawing, "missing dependency: 'Drawing'") local Players = game:GetService("Players") local RunService = game:GetService("RunService") local localPlayer = Players.LocalPlayer local camera = workspace.CurrentCamera local cache = {} local BOX_OUTLINE_COLOR = Color3.new(0, 0, 0) local BOX_COLOR = Color3.new(1, 0, 0) local NAME_COLOR = Color3.new(1, 1, 1) local HEALTH_OUTLINE_COLOR = Color3.new(0, 0, 0) local HEALTH_HIGH_COLOR = Color3.new(0, 1, 0) local HEALTH_LOW_COLOR = Color3.new(1, 0, 0) local CHAR_SIZE = Vector2.new(4, 6) local function create(class, properties) local drawing = Drawing.new(class) for property, value in pairs(properties) do drawing[property] = value end return drawing end local function floor2(v) return Vector2.new(math.floor(v.X), math.floor(v.Y)) end local function createEsp(player) local esp = {} esp.boxOutline = create("Square", {Color = BOX_OUTLINE_COLOR, Thickness = 3, Filled = false}) esp.box = create("Square", {Color = BOX_COLOR, Thickness = 1, Filled = false}) esp.name = create("Text", {Color = NAME_COLOR, Font = (syn and not RectDynamic) and 2 or 1, Outline = true, Center = true, Size = 13}) esp.healthOutline = create("Line", {Thickness = 3, Color = HEALTH_OUTLINE_COLOR}) esp.health = create("Line", {Thickness = 1}) cache[player] = esp end local function removeEsp(player) local esp = cache[player] if not esp then return end for _, drawing in pairs(esp) do drawing:Remove() end cache[player] = nil end local function updateEsp() for player, esp in pairs(cache) do local character, team = player.Character, player.Team if character and (not team or team ~= localPlayer.Team) then local cframe = character:GetPivot() local screen, onScreen = camera:WorldToViewportPoint(cframe.Position) if onScreen then local frustumHeight = math.tan(math.rad(camera.FieldOfView * 0.5)) * 2 * screen.Z local size = camera.ViewportSize.Y / frustumHeight * CHAR_SIZE local position = Vector2.new(screen.X, screen.Y) esp.boxOutline.Size = floor2(size) esp.boxOutline.Position = floor2(position - size * 0.5) esp.box.Size = esp.boxOutline.Size esp.box.Position = esp.boxOutline.Position esp.name.Text = string.lower(player.Name) esp.name.Position = floor2(position - Vector2.yAxis * (size.Y * 0.5 + esp.name.TextBounds.Y + 2)) local humanoid = character:FindFirstChildOfClass("Humanoid") local health = (humanoid and humanoid.Health or 100) / 100 esp.healthOutline.From = floor2(position - size * 0.5) - Vector2.xAxis * 5 esp.healthOutline.To = floor2(position - size * Vector2.new(0.5, -0.5)) - Vector2.xAxis * 5 esp.health.From = esp.healthOutline.To esp.health.To = floor2(esp.healthOutline.To:Lerp(esp.healthOutline.From, health)) esp.health.Color = HEALTH_LOW_COLOR:Lerp(HEALTH_HIGH_COLOR, health) esp.healthOutline.From = Vector2.yAxis esp.healthOutline.To = Vector2.yAxis end for _, drawing in pairs(esp) do drawing.Visible = onScreen end else for _, drawing in pairs(esp) do drawing.Visible = false end end end end Players.PlayerAdded:Connect(createEsp) Players.PlayerRemoving:Connect(removeEsp) RunService.RenderStepped:Connect(updateEsp) for idx, player in ipairs(Players:GetPlayers()) do if idx ~= 1 then createEsp(player) end end
end)

tool:Toggle("Circle ESP", "ESP", false, function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
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
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end)

tool:Button("透视1",function()
loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()
end)

tool:Button("透视2",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
end)

local creds = window:Tab("飞行功能",'6035145364')

local tool = creds:section("功能",true)

tool:Button("飞行",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/gqv7PXAa"))()
end)

tool:Button("驰飞行",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E9%A9%B0%E9%A3%9E%E8%A1%8C.lua"))()
end)

tool:Button("飞行v1",function()
       loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\90\66\122\99\84\109\49\102\34\41\41\40\41\10")()
end)

tool:Button("飞行V3",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/nkhg0q5K"))()
end)

local creds = window:Tab("一次尘土飞扬的旅行",'6035145364')

local tool = creds:section("功能",true)

-- 自动到达20000按钮
tool:Button("自动到达20000", function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local character = LocalPlayer.Character
    
    if not character then
        character = LocalPlayer.CharacterAdded:Wait()
    end
    
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    local teleportLocations = {
        CFrame.new(-20.408166885375977, -11.34829044342041, 1809.8782958984375),
        CFrame.new(257.45782470703125, 58.954708099365234, -4186.28955078125),
        CFrame.new(515.4042358398438, 72.82687377929688, -10186.2861328125),
        CFrame.new(123.37289428710938, -66.69212341308594, -16188.0537109375),
        CFrame.new(232.33438110351562, 147.98423767089844, -22189.32421875),
        CFrame.new(713.6531982421875, 102.16617584228516, -28190.58984375),
        CFrame.new(910.4205322265625, -137.20584106445312, -34189.23046875),
        CFrame.new(1141.0308837890625, 148.53587341308594, -40185.35546875),
        CFrame.new(1357.2171630859375, 87.61758422851562, -46190.3125),
        CFrame.new(1606.8338623046875, -174.83712768554688, -52188.765625),
        CFrame.new(1503.0009765625, 210.8280792236328, -82185.9140625),
        CFrame.new(734.9932861328125, -117.6973876953125, -112190.21875),
    }
    
    local teleportDelay = 0.5
    
    local function teleportToLocations()
        print("开始自动传送，共有 " .. #teleportLocations .. " 个传送点")
        
        for index, location in ipairs(teleportLocations) do
            humanoidRootPart.CFrame = location
            print("传送点 " .. index .. ": " .. tostring(location))
            wait(teleportDelay)
        end
        
        print("已完成所有传送点，共传送到 " .. #teleportLocations .. " 个位置")
    end
    
    teleportToLocations()
end)

-- 距离1000按钮
tool:Button("距离1000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(-20.408166885375977, -11.34829044342041, 1809.8782958984375)
        print("已传送到距离1000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离2000按钮
tool:Button("距离2000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(257.45782470703125, 58.954708099365234, -4186.28955078125)
        print("已传送到距离2000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离3000按钮
tool:Button("距离3000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(515.4042358398438, 72.82687377929688, -10186.2861328125)
        print("已传送到距离3000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离4000按钮
tool:Button("距离4000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(123.37289428710938, -66.69212341308594, -16188.0537109375)
        print("已传送到距离4000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离5000按钮
tool:Button("距离5000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(232.33438110351562, 147.98423767089844, -22189.32421875)
        print("已传送到距离5000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离6000按钮
tool:Button("距离6000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(713.6531982421875, 102.16617584228516, -28190.58984375)
        print("已传送到距离6000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离7000按钮
tool:Button("距离7000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(910.4205322265625, -137.20584106445312, -34189.23046875)
        print("已传送到距离7000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离8000按钮
tool:Button("距离8000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(1141.0308837890625, 148.53587341308594, -40185.35546875)
        print("已传送到距离8000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离9000按钮
tool:Button("距离9000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(1357.2171630859375, 87.61758422851562, -46190.3125)
        print("已传送到距离9000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离10000按钮
tool:Button("距离10000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(1606.8338623046875, -174.83712768554688, -52188.765625)
        print("已传送到距离10000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离15000按钮
tool:Button("距离15000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(1503.0009765625, 210.8280792236328, -82185.9140625)
        print("已传送到距离15000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 距离20000按钮
tool:Button("距离20000", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(734.9932861328125, -117.6973876953125, -112190.21875)
        print("已传送到距离20000")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

local creds = window:Tab("合并滴管",'6035145364')

local tool = creds:section("功能",true)

-- 自动收集
tool:Toggle("自动收集", "", false, function(bool)
    getgenv().collect = bool 
    
    spawn(function()
        local plr = game.Players.LocalPlayer
        
        while getgenv().collect do
            local teamName = plr.Team and plr.Team.Name
            if teamName then
                local plot = workspace.Tycoon.Plot:FindFirstChild(teamName)
                if plot then
                    local dropParts = plot:FindFirstChild("DropParts")
                    if dropParts then
                        for _, part in pairs(dropParts:GetDescendants()) do
                            if part.Name == "Wool" then
                                local character = plr.Character
                                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                                if hrp then
                                    part.CFrame = hrp.CFrame
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.25)
        end
    end)
end)

-- 自动存款
tool:Toggle("自动存款", "", false, function(bool)
    getgenv().deposit = bool 
    
    spawn(function()
        local plr = game.Players.LocalPlayer
        
        while getgenv().deposit do
            local teamName = plr.Team and plr.Team.Name
            if teamName then
                local plot = workspace.Tycoon.Plot:FindFirstChild(teamName)
                if plot then
                    local buttons = plot:FindFirstChild("Buttons_E")
                    if buttons then
                        local putButton = buttons:FindFirstChild("Put")
                        if putButton then
                            local head = putButton:FindFirstChild("Head")
                            if head then
                                local character = plr.Character
                                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                                if hrp then
                                    firetouchinterest(head, hrp, 0)
                                    firetouchinterest(head, hrp, 1)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.25)
        end
    end)
end)

-- 自动升级
tool:Toggle("自动升级", "", false, function(bool)
    getgenv().upgrade = bool 
    
    spawn(function()
        local plr = game.Players.LocalPlayer
        
        while getgenv().upgrade do
            local teamName = plr.Team and plr.Team.Name
            if teamName then
                local plot = workspace.Tycoon.Plot:FindFirstChild(teamName)
                if plot then
                    local buttons = plot:FindFirstChild("Buttons_E")
                    if buttons then
                        local upgradeButton = buttons:FindFirstChild("Upgrade")
                        if upgradeButton then
                            local head = upgradeButton:FindFirstChild("Head")
                            if head then
                                local character = plr.Character
                                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                                if hrp then
                                    firetouchinterest(head, hrp, 0)
                                    firetouchinterest(head, hrp, 1)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.25)
        end
    end)
end)

-- 自动滴管（合并）
tool:Toggle("自动滴管", "", false, function(bool)
    getgenv().merge = bool 
    
    spawn(function()
        local plr = game.Players.LocalPlayer
        
        while getgenv().merge do
            local teamName = plr.Team and plr.Team.Name
            if teamName then
                local plot = workspace.Tycoon.Plot:FindFirstChild(teamName)
                if plot then
                    local buttons = plot:FindFirstChild("Buttons_E")
                    if buttons then
                        local mergeButton = buttons:FindFirstChild("Merge")
                        if mergeButton then
                            local head = mergeButton:FindFirstChild("Head")
                            if head then
                                local character = plr.Character
                                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                                if hrp then
                                    firetouchinterest(head, hrp, 0)
                                    firetouchinterest(head, hrp, 1)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.25)
        end
    end)
end)

local creds = window:Tab("内脏与黑火药",'6035145364')

local tool = creds:section("功能",true)

tool:Button("内脏与黑火药1",function()
        loadstring(game:HttpGet(("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\110\66\56\109\114\54\107\117"),true))()
end)

tool:Button("内脏与黑火药2",function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\102\121\46\97\112\112\47\65\51\78\113\122\52\78\112\47\114\97\119"))()
end)

local creds = window:Tab("在超市生活一周",'6035145364')

local tool = creds:section("功能",true)

-- 自动收集食物
tool:Toggle("自动收集食物", "", false, function(state)
    getgenv().autoCollectFood = state
    while getgenv().autoCollectFood and task.wait() do
        for _, v in next, workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Food" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

-- 自动收集手电筒
tool:Toggle("自动收集手电筒", "", false, function(state)
    getgenv().autoCollectFlashlight = state
    while getgenv().autoCollectFlashlight and task.wait() do
        for _, v in next, workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Flashlight" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

-- 自动收集近战武器
tool:Toggle("自动收集近战武器", "", false, function(state)
    getgenv().autoCollectMelee = state
    while getgenv().autoCollectMelee and task.wait() do
        for _, v in next, workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Melee" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

-- 自动收集枪
tool:Toggle("自动收集枪", "", false, function(state)
    getgenv().autoCollectGun = state
    while getgenv().autoCollectGun and task.wait() do
        for _, v in next, workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Gun" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

-- 自动收集药品
tool:Toggle("自动收集药品", "", false, function(state)
    getgenv().autoCollectHealth = state
    while getgenv().autoCollectHealth and task.wait() do
        for _, v in next, workspace.Map.Util.Items:GetChildren() do
            if v.ToolStats.ItemType.Value == "Health" then
                game:GetService("ReplicatedStorage").Remotes.RequestPickupItem:FireServer(v)
            end
        end
    end
end)

-- 自动装弹
tool:Toggle("自动装弹", "", false, function(state)
    getgenv().autoReload = state
    while getgenv().autoReload and task.wait() do
        game:GetService("ReplicatedStorage").Remotes.Weapon.GunReloaded:FireServer(v, 1)
    end
end)

-- 自动开枪
tool:Toggle("自动开枪", "", false, function(state)
    getgenv().autoShoot = state
    while getgenv().autoShoot and task.wait() do
        for _, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
            if v:FindFirstChild("ToolStats") and v.ToolStats:FindFirstChild("Ammo") then
                for _, e in next, workspace.Enemies:GetChildren() do
                    if e.Humanoid.Health > 0 then
                        local BulletsPerShot = v.ToolStats.BulletsPerShot.Value
                        local DirectionTbl = {}
                        for i = 1, BulletsPerShot do
                            table.insert(DirectionTbl, Vector3.new(e.Head.Position.X, e.Head.Position.Y, e.Head.Position.Z).Unit)
                        end
                        local args = {
                            [1] = {
                                ["FiringPlayer"] = game:GetService("Players").LocalPlayer,
                                ["FiredTime"] = os.time(),
                                ["FiringPlayerUserId"] = game.Players.LocalPlayer.UserId,
                                ["Origin"] = Vector3.new(game.Players.LocalPlayer.Character:GetPivot().Position),
                                ["UID"] = game.Players.LocalPlayer.UserId .. "_1",
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
end)

-- 修改超级枪
tool:Toggle("修改超级枪", "", false, function(state)
    getgenv().superGunMod = state
    while getgenv().superGunMod and task.wait() do
        for _, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
            if v.ToolStats:FindFirstChild("Ammo") then
                v.ToolStats.ReloadTime.Value = 0
                v.ToolStats.FireDelay.Value = 0
                v.ToolStats.Ammo.Value = math.huge
                v.ToolStats.Damage.Value = math.huge
            end
        end
    end
end)

-- 无限体力和饥饿度
tool:Toggle("无限体力和饥饿度", "", false, function(state)
    getgenv().infiniteStaminaHunger = state
    while getgenv().infiniteStaminaHunger and task.wait() do
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("CharacterData") then
            character.CharacterData.MaxStamina.Value = math.huge
            character.CharacterData.MaxEnergy.Value = math.huge
            character.CharacterData.Energy.Value = character.CharacterData.MaxEnergy.Value
            character.CharacterData.Stamina.Value = character.CharacterData.MaxStamina.Value
        end
    end
end)

-- 夜晚自动躲避
tool:Toggle("夜晚自动躲避", "", false, function(state)
    getgenv().nightAutoHide = state
    while getgenv().nightAutoHide and task.wait() do
        if game:GetService("ReplicatedStorage").GameInfo.TimeOfDay.Value == "Night" then
            local character = game.Players.LocalPlayer.Character
            if character then
                local oldpos = character:GetPivot().Position
                repeat 
                    task.wait()
                    character:PivotTo(CFrame.new(306.18927001953125, 36.67450714111328, -519.2435913085938))
                    if character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.Anchored = true
                    end
                until game:GetService("ReplicatedStorage").GameInfo.TimeOfDay.Value ~= "Night" or not getgenv().nightAutoHide
                
                if character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.Anchored = false
                    character.HumanoidRootPart.CFrame = CFrame.new(oldpos)
                end
            end
        else
            task.wait()
        end
    end
end)

local creds = window:Tab("自然灾害",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("地图投票用户界面", "Map Voting UI", false, function(bool)
if bool == false then do game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = false
    end
end
if bool == true then do game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = true
    end
end
end)

tool:Toggle("在水上行走", "ToggleInfo", false, function(bool)
 if bool == false then do game.Workspace.WaterLevel.CanCollide = false
                            game.Workspace.WaterLevel.Size = Vector3.new(10, 1, 10)
                        end
                    end
                    if bool == true then do game.Workspace.WaterLevel.CanCollide = true
                            game.Workspace.WaterLevel.Size = Vector3.new(5000, 1, 5000)
                        end
                    end
end)

tool:Toggle("游戏岛悬崖碰撞", "Togglelnfo", false, function(bool)
for i, v in pairs (game.workspace:GetDescendants())do
                                if v.Name == 'LowerRocks' then
                                    v.CanCollide = bool
                                end
                            end
end)

tool:Toggle("禁用坠落损坏",function()
local FallDamageScript = (game.Players.LocalPlayer.Character ~= nil) and game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") or nil
                                if FallDamageScript then
                                FallDamageScript:Destroy()
                                end
end)

tool:Toggle("自动禁用坠落伤害", "Toggleelnfo", false, function(bool)
_G.NoFallDamage = bool;
                            while wait(0.5) do
                                    if _G.NoFallDamage == true then
                            local FallDamageScript = (game.Players.LocalPlayer.Character ~= nil) and game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") or nil
                            if FallDamageScript then
                            FallDamageScript:Destroy()
                            end end end
end)

tool:Button("打印下一次灾难(/console)",function()
warn(game.Players.LocalPlayer.Character.SurvivalTag.Value)
end)

tool:Button("移除灾难界面(暴风雪和沙尘暴)",function()
game.Players.LocalPlayer.PlayerGui.BlizzardGui:destroy()
                game.Players.LocalPlayer.PlayerGui.SandStormGui:destroy()
end)

tool:Button("传送到地图",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-115.828506, 65.4863434, 18.8461514, 0.00697017973, 0.0789371505, -0.996855199, -3.13589936e-07, 0.996879458, 0.0789390653, 0.999975681, -0.000549906865, 0.00694845384)
end)

tool:Button("游戏岛",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-83.5, 38.5, -27.5, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

tool:Button("产卵塔",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-280, 170, 341, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)

local creds = window:Tab("监狱人生",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("删除门","text",false,function(state)
if state then
        print("Toggle On")
        for i,v in pairs(workspace.Doors:GetChildren()) do
             v.Parent = game:service"ReplicatedStorage".nikodoors

        end
    else
        print("Toggle Off")
        for i,v in pairs(game:service"ReplicatedStorage".nikodoors:GetChildren()) do
            v.Parent = workspace.Doors
        end
    end
end)
tool:Toggle("逮捕所有罪犯", function()
    wait(0.1)
        Player = game.Players.LocalPlayer
        Pcf = Player.Character.HumanoidRootPart.CFrame
        for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
                if v.Name ~= Player.Name then
                        local i = 10
                        repeat
                                wait()
                                i = i-1
                                game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
                                Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                        until i == 0
                end
        end
end)

tool:Button("变成警察", function()
workspace.Remote.TeamEvent:FireServer("Bright blue");
end)

tool:Button("变成囚犯", function()
workspace.Remote.TeamEvent:FireServer("Bright orange");
end)

local MT = getrawmetatable(game)
local __namecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FindPartOnRay" and not checkcaller() and tostring(getfenv(0).script) == "GunInterface" then
        local Character = ClosestChar()
        if Character then
            return Character.Torso, Character.Torso.Position
        end
    end

    return __namecall(self, ...)
end)
setreadonly(MT, true)
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
tool:Button("无敌模式",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/LdTVujTA"))()
end)
tool:Button(
    "杀死所有人",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/kXjfpFPh"))()
    end
)
tool:Button(
    "无敌神器（拿上范围秒杀）",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/mSLiAZHk"))()
    end
)
tool:Button(
    "变钢铁侠",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/7prijqYH"))()
    end
)
tool:Button(
    "变死神",
    function()
        loadstring(game:HttpGet("https://pastebin.com/ewv9bbRp"))()
    end
)
tool:Button(
    "变车模型",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zLe3e4BS"))()
    end
)


tool:Button(
    "PRISONWARE V1.3",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/PRISONWARE_v1.3.txt"))()
    end
)

tool:Button(
    "警卫室",
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)
    end
)
tool:Button(
    "监狱室内",
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)
    end
)
tool:Button(
    "罪犯复活点",
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)
    end
)
tool:Button(
    "监狱室外",
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
    end
)

local creds = window:Tab("感染性微笑",'6035145364')

local tool = creds:section("功能",true)

tool:Button("防止微笑感染",function()
    for _,v in pairs(game.workspace:GetDescendants()) do
        if string.find(v.Name,"Infector") then
            v:Destroy()
        end
    end
end)

tool:Button("取消门",function()
    for _,v in pairs(game.workspace:GetDescendants()) do
        if string.find(v.Name,"AntiSmiler") then
            v:Destroy()
        end
    end
end)

tool:Button("开启反外挂",function()
    workspace.Map.AntiHack:Destroy() 
    game.Players.LocalPlayer.Character.AntiFly:Destroy()
end)

tool:Toggle("速度-微笑感染","text",false,function(s)
    getgenv().SlowDownSpeed = getgenv().SlowDownSpeed or 16
    getgenv().NoSlowDown = s
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

tool:Toggle("打击微笑感染","text",false,function(s)
    getgenv().InfectAura = s
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

tool:Toggle("Bat打击","text",false,function(s)
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
                    local packedice = character:FindFirstChild("Packed Ice")
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

tool:Toggle("瓶子打击","text",false,function(s)
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
                    local packedice = character:FindFirstChild("Packed Ice")
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

local creds = window:Tab("Break In2",'6035145364')

local tool = creds:section("功能",true)

tool:Label("这个是第2版的")
tool:Label("请勿在第1版使用")

-- 训练力量按钮
tool:Button("训练力量", function()
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    local rainbowStat = events and events:FindFirstChild("RainbowWhatStat")
    
    if rainbowStat then
        rainbowStat:FireServer("Strength")
        print("已训练力量")
    else
        print("未找到 RainbowWhatStat 远程事件")
    end
end)

-- 训练速度按钮
tool:Button("训练速度", function()
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    local rainbowStat = events and events:FindFirstChild("RainbowWhatStat")
    
    if rainbowStat then
        rainbowStat:FireServer("Speed")
        print("已训练速度")
    else
        print("未找到 RainbowWhatStat 远程事件")
    end
end)

-- 杀死所有敌人按钮
tool:Button("杀死所有敌人", function()
    local killFunction = getgenv().KillEnemies
    if killFunction then
        killFunction()
        print("已执行杀死所有敌人")
    else
        print("未找到 KillEnemies 函数")
        -- 尝试查找并杀死敌人
        pcall(function()
            local enemies = workspace:FindFirstChild("Enemies")
            if enemies then
                for _, enemy in pairs(enemies:GetChildren()) do
                    local humanoid = enemy:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                    end
                end
                print("已尝试杀死所有敌人")
            else
                print("未找到 Enemies 文件夹")
            end
        end)
    end
end)

-- 循环杀死所有敌人Toggle
tool:Toggle("循环杀死所有敌人", "", false, function(Value)
    getgenv().KillAllLoop = Value
    
    spawn(function()
        while getgenv().KillAllLoop do
            local killFunction = getgenv().KillEnemies
            if killFunction then
                for i = 1, 3 do
                    killFunction()
                end
            else
                -- 尝试查找并杀死敌人
                pcall(function()
                    local enemies = workspace:FindFirstChild("Enemies")
                    if enemies then
                        for _, enemy in pairs(enemies:GetChildren()) do
                            local humanoid = enemy:FindFirstChild("Humanoid")
                            if humanoid then
                                humanoid.Health = 0
                            end
                        end
                    end
                end)
            end
            task.wait(0.1)
        end
    end)
end)

local tool = creds:section("物品区",true)

-- 盔甲按钮
tool:Button("盔甲", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Armor")
        print("已获取盔甲")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Armor")
    end
end)

-- 医药箱按钮
tool:Button("医药箱", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Med Kit")
        print("已获取医药箱")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Med Kit")
    end
end)

-- 钥匙按钮
tool:Button("钥匙", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Key")
        print("已获取钥匙")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Key")
    end
end)

-- 黄金钥匙按钮
tool:Button("黄金钥匙", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Gold Key")
        print("已获取黄金钥匙")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Gold Key")
    end
end)

-- 老鼠按钮
tool:Button("老鼠", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Louise")
        print("已获取老鼠")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Louise")
    end
end)

-- 棒棒糖按钮
tool:Button("棒棒糖", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Lollipop")
        print("已获取棒棒糖")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Lollipop")
    end
end)

-- 薯片按钮
tool:Button("薯片", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Chips")
        print("已获取薯片")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Chips")
    end
end)

-- 苹果按钮
tool:Button("苹果", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Apple")
        print("已获取苹果")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Apple")
    end
end)

-- 黄金苹果按钮
tool:Button("黄金苹果", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Golden Apple")
        print("已获取黄金苹果")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Golden Apple")
    end
end)

-- 披萨按钮
tool:Button("披萨", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Pizza")
        print("已获取披萨")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Pizza")
    end
end)

-- 黄金披萨按钮
tool:Button("黄金披萨", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Gold Pizza")
        print("已获取黄金披萨")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Gold Pizza")
    end
end)

-- 彩虹披萨按钮
tool:Button("彩虹披萨", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Rainbow Pizza")
        print("已获取彩虹披萨")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Rainbow Pizza")
    end
end)

-- 曲奇按钮
tool:Button("曲奇", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Cookie")
        print("已获取曲奇")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Cookie")
    end
end)

-- 可乐按钮
tool:Button("可乐", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Bloxy Cola")
        print("已获取可乐")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Bloxy Cola")
    end
end)

-- 瓶子按钮
tool:Button("瓶子", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Bottle")
        print("已获取瓶子")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Bottle")
    end
end)

-- 梯子按钮
tool:Button("梯子", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Ladder")
        print("已获取梯子")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Ladder")
    end
end)

-- 电池按钮
tool:Button("电池", function()
    local giveFunction = getgenv().GiveItem
    if giveFunction then
        giveFunction("Battery")
        print("已获取电池")
    else
        print("未找到 GiveItem 函数，尝试直接获取")
        TryGetItem("Battery")
    end
end)

-- 尝试直接获取物品的函数
local function TryGetItem(itemName)
    pcall(function()
        -- 方法1: 尝试从ReplicatedStorage获取
        local replicatedStorage = game:GetService("ReplicatedStorage")
        local itemTemplate = replicatedStorage:FindFirstChild(itemName)
        
        if itemTemplate then
            local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                local copy = itemTemplate:Clone()
                copy.Parent = backpack
                print("已通过克隆获取: " .. itemName)
                return
            end
        end
        
        -- 方法2: 尝试调用远程事件
        local remoteEvents = replicatedStorage:FindFirstChild("RemoteEvents")
        if remoteEvents then
            local giveItemEvent = remoteEvents:FindFirstChild("GiveItem")
            if giveItemEvent then
                giveItemEvent:FireServer(itemName)
                print("已通过远程事件获取: " .. itemName)
                return
            end
        end
        
        -- 方法3: 尝试其他常见远程事件
        local commonEvents = {
            "GetItem",
            "AddItem", 
            "GiveTool",
            "SpawnItem"
        }
        
        for _, eventName in pairs(commonEvents) do
            local event = replicatedStorage:FindFirstChild(eventName)
            if event then
                event:FireServer(itemName)
                print("已通过 " .. eventName .. " 事件尝试获取: " .. itemName)
                return
            end
        end
        
        print("无法获取物品: " .. itemName .. "，请检查游戏机制")
    end)
end

-- 将辅助函数存储在全局环境
getgenv().TryGetItem = TryGetItem

tool:Button("获取所有物品", function()
    local allItems = {
        "Armor", "Med Kit", "Key", "Gold Key", "Louise",
        "Lollipop", "Chips", "Apple", "Golden Apple", "Pizza",
        "Gold Pizza", "Rainbow Pizza", "Cookie", "Bloxy Cola",
        "Bottle", "Ladder", "Battery"
    }
    
    for _, item in ipairs(allItems) do
        if getgenv().GiveItem then
            getgenv().GiveItem(item)
        else
            TryGetItem(item)
        end
        wait(0.1) -- 避免过快发送请求
    end
    
    print("已尝试获取所有物品")
end)

local tool = creds:section("免费通行证人物",true)

-- 书呆子小孩按钮
tool:Button("书呆子小孩", function()
    local remoteEvents = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    local outsideRole = remoteEvents and remoteEvents:FindFirstChild("OutsideRole")
    
    if outsideRole then
        outsideRole:FireServer("Book", true, false)
        print("已变更为书呆子小孩角色")
    else
        print("未找到 OutsideRole 远程事件")
    end
end)

-- 黑客按钮
tool:Button("黑客", function()
    local remoteEvents = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
    local outsideRole = remoteEvents and remoteEvents:FindFirstChild("OutsideRole")
    
    if outsideRole then
        outsideRole:FireServer("Phone", true, false)
        print("已变更为黑客角色")
    else
        print("未找到 OutsideRole 远程事件")
    end
end)

local tool = creds:section("传送区",true)

-- Boss传送
tool:Button("Boss", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(-1565.78772, -368.711945, -1040.66626, 0.0929690823, -1.97564436e-08, 0.995669007, -1.53269308e-08, 1, 2.1273511e-08, -0.995669007, -1.72383299e-08, 0.0929690823)
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到Boss区域")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到Boss区域")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 商店传送
tool:Button("商店", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(-246.653229, 30.4500484, -847.319275, 0.999987781, -9.18427645e-08, -0.00494772941, 9.19905787e-08, 1, 2.96483353e-08, 0.00494772941, -3.01031164e-08, 0.999987781)
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到商店")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到商店")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 厨房传送
tool:Button("厨房", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(-249.753555, 30.4500484, -732.703125, -0.999205947, -1.97705017e-08, 0.0398429185, -2.00601384e-08, 1, -6.86967372e-09, -0.0398429185, -7.66347341e-09, -0.999205947)
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到厨房")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到厨房")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 打斗区域传送
tool:Button("打斗区域", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(-255.521988, 62.7139359, -723.436035, -0.0542500541, 4.28905356e-09, -0.998527408, 1.07862625e-08, 1, 3.70936082e-09, 0.998527408, -1.05691456e-08, -0.0542500541)
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到打斗区域")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到打斗区域")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 健身房传送
tool:Button("健身房", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(-256.477448, 63.4500465, -840.825562, 0.999789953, 2.17116263e-08, 0.020495005, -2.15169358e-08, 1, -9.7199333e-09, -0.020495005, 9.27690191e-09, 0.999789953)
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到健身房")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到健身房")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 黄金苹果传送
tool:Button("黄金苹果", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(61.8781624, 29.4499969, -534.381165, -0.584439218, -1.05103076e-07, 0.811437488, -3.12853778e-08, 1, 1.06993674e-07, -0.811437488, 3.71451705e-08, -0.584439218)
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到黄金苹果位置")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到黄金苹果位置")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 喂食说明传送
tool:Button("喂食说明", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(-207.885056, 60.4500465, -830.583557, 0.118373089, 3.89876789e-08, -0.992969215, 3.47791551e-09, 1, 3.96783406e-08, 0.992969215, -8.15031065e-09, 0.118373089)
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到喂食说明位置")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到喂食说明位置")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 中间房间传送
tool:Button("中间房间", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(-209.951859, 30.4590473, -789.723877, -0.0485812724, 6.74905039e-08, 0.998819232, 1.19352916e-09, 1, -6.75122394e-08, -0.998819232, -2.08771045e-09, -0.0485812724)
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到中间房间")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到中间房间")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 外面的食物传送
tool:Button("外面的食物", function()
    local outsideParts = game:GetService("Workspace"):FindFirstChild("OutsideParts")
    if outsideParts then
        local part = outsideParts:FindFirstChildWhichIsA("Part", true)
        if part then
            local character = game.Players.LocalPlayer.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = part.CFrame + Vector3.new(10, 0, 0)
                print("已传送到外面的食物位置")
            else
                print("无法传送：角色或HumanoidRootPart不存在")
            end
        else
            print("未找到OutsideParts中的Part")
        end
    else
        print("未找到OutsideParts文件夹")
    end
end)

-- 实验室传送
tool:Button("实验室", function()
    local final = game:GetService("Workspace"):FindFirstChild("Final")
    local factory = final and final:FindFirstChild("Factory")
    local redDesk = factory and factory:FindFirstChild("RedDesk")
    local drawer = redDesk and redDesk:FindFirstChild("Drawer")
    
    if drawer and #drawer:GetChildren() >= 2 then
        local targetPart = drawer:GetChildren()[2]
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = targetPart.CFrame + Vector3.new(20, 0, 0)
            print("已传送到实验室")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    else
        print("未找到实验室目标位置")
    end
end)

-- 自助餐厅传送
tool:Button("自助餐厅", function()
    local final = game:GetService("Workspace"):FindFirstChild("Final")
    local factory = final and final:FindFirstChild("Factory")
    
    if factory then
        local legs = factory:FindFirstChild("Legs", true)
        if legs then
            local character = game.Players.LocalPlayer.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = legs.CFrame
                print("已传送到自助餐厅")
            else
                print("无法传送：角色或HumanoidRootPart不存在")
            end
        else
            print("未找到Legs部件")
        end
    else
        print("未找到Factory")
    end
end)

-- 彩虹披萨盒子传送
tool:Button("彩虹披萨盒子", function()
    local rainbowPizzaBox = game:GetService("Workspace"):FindFirstChild("RainbowPizzaBox")
    if rainbowPizzaBox then
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = rainbowPizzaBox.CFrame
            print("已传送到彩虹披萨盒子")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    else
        print("未找到RainbowPizzaBox")
    end
end)

local tool = creds:section("神秘结局",true)

-- 金色撬棍传送
tool:Button("金色撬棍", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(
        -147.337204, 29.4477005, -929.365295,
        0.756779075, 4.53537341e-09, -0.653670728,
        5.82708326e-09, 1, 1.36845468e-08,
        0.653670728, -1.4165173e-08, 0.756779075
    )
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到金色撬棍位置")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到金色撬棍位置")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 紫色口罩传送
tool:Button("紫色口罩", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(
        102.560722, 29.2477055, -976.389954,
        -0.951403797, 3.76210636e-08, -0.307946175,
        1.89752569e-08, 1, 6.35433466e-08,
        0.307946175, 5.46120233e-08, -0.951403797
    )
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到紫色口罩位置")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到紫色口罩位置")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

-- 流浪孩童传送
tool:Button("流浪孩童", function()
    local teleportFunction = getgenv().TeleportTo
    local cframe = CFrame.new(
        -79.4871826, 29.4477024, -932.782715,
        -0.215949073, 3.18771427e-08, 0.976404607,
        -7.60385461e-08, 1, -4.94647345e-08,
        -0.976404607, -8.49262562e-08, -0.215949073
    )
    
    if teleportFunction then
        teleportFunction(cframe)
        print("已传送到流浪孩童位置")
    else
        local character = game.Players.LocalPlayer.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = cframe
            print("已传送到流浪孩童位置")
        else
            print("无法传送：角色或HumanoidRootPart不存在")
        end
    end
end)

local creds = window:Tab("奇怪严格的爸爸",'6035145364')

local tool = creds:section("功能",true)

tool:Button("奇怪严格的爸爸",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/yBloodz/Free-scripts/main/Weird%20Strict%20Dad"))()
end)

local creds = window:Tab("战斗勇士",'6035145364')

local tool = creds:section("功能",true)

-- 自动行走
tool:Toggle("自动行走", "", false, function(Y)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.followclosest = Y
    if getgenv().saveSettings then
        getgenv().saveSettings()
    end
end)

-- 自动重生
tool:Toggle("自动重生", "", false, function(Y)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.autospawn = Y
    if getgenv().saveSettings then
        getgenv().saveSettings()
    end
end)

-- 自动装备
tool:Toggle("自动装备", "", false, function(Y)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.autoequip = Y
    if getgenv().saveSettings then
        getgenv().saveSettings()
    end
end)

-- 自动攻击
tool:Toggle("自动攻击", "", false, function(Y)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.autohit = Y
    if getgenv().saveSettings then
        getgenv().saveSettings()
    end
    
    task.spawn(function()
        while task.wait(1) do
            if not getgenv().Settings.autohit then
                break
            end
            if getgenv().mouse1click then
                getgenv().mouse1click()
            end
        end
    end)
end)

-- 反招架
tool:Toggle("反招架", "", false, function(Y)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.antiparry = Y
    if getgenv().saveSettings then
        getgenv().saveSettings()
    end
end)

-- 反辐射
tool:Toggle("反辐射", "", false, function(Y)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.antiradgoll = Y
    if getgenv().saveSettings then
        getgenv().saveSettings()
    end
    
    task.spawn(function()
        while task.wait() do
            if not getgenv().Settings.antiradgoll then
                break
            end
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.RagdollRemoteEvent:FireServer(false)
            end
        end
    end)
end)

-- 玩家透视
tool:Toggle("玩家透视", "", false, function(Y)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.esp = Y
    if getgenv().saveSettings then
        getgenv().saveSettings()
    end
end)

-- 反盾按钮
tool:Button("反盾", function()
    local lp = game.Players.LocalPlayer
    local animationInfo = {}
    
    function getInfo(id)
        local success, info = pcall(function()
            return game:GetService("MarketplaceService"):GetProductInfo(id)
        end)
        if success then
            return info
        end
        return {Name = ''}
    end
    
    function block(player)
        keypress(0x46)  -- F键
        wait()
        keyrelease(0x46)
    end
    
    local AnimNames = {
        'Slash',
        'Swing',
        'Sword'
    }
    
    function playerAdded(v)
        local function charadded(char)
            local humanoid = char:WaitForChild("Humanoid", 5)
            if humanoid then
                humanoid.AnimationPlayed:Connect(function(track)
                    local info = animationInfo[track.Animation.AnimationId]
                    if not info then
                        info = getInfo(tonumber(track.Animation.AnimationId:match("%d+")))
                        animationInfo[track.Animation.AnimationId] = info
                    end
                    
                    if (lp.Character and lp.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Head")) then
                        local mag = (v.Character.Head.Position - lp.Character.Head.Position).Magnitude
                        if mag < 15 then
                            for _, animName in pairs(AnimNames) do
                                if info.Name:match(animName) then
                                    pcall(block, v)
                                end
                            end
                        end
                    end
                end)
            end
        end
        
        if v.Character then
            charadded(v.Character)
        end
        v.CharacterAdded:Connect(charadded)
    end
    
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= lp then
            playerAdded(v)
        end
    end
    
    game.Players.PlayerAdded:Connect(playerAdded)
end)

-- 敌人打不死按钮
tool:Button("敌人打不死", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local HRP = character.HumanoidRootPart
        local spawnbox = workspace.SpawnBox
        
        if spawnbox and spawnbox:FindFirstChild("SpawnPart") then
            HRP.CFrame = spawnbox.SpawnPart.CFrame
        end
    end
end)

local creds = window:Tab("隐藏或死亡",'6035145364')

local tool = creds:section("功能",true)

-- 自瞄躲藏者
tool:Toggle("自瞄躲藏者", "", false, function(state)
    getgenv().AimTog = state
    if getgenv().AimTog then
        pcall(function()
            spawn(function()
                while task.wait(0.1) and getgenv().AimTog do
                    local O_O = game.Players.LocalPlayer
                    local OAO = O_O.Character
                    local camera = workspace.CurrentCamera
                    
                    local closestPlayer = nil
                    local closestDistance = math.huge
                    for _, v in next, game.Players:GetPlayers() do
                        if v ~= O_O and v.Team and v.Team.Name == "Hider" and v.Character and v.Character.Humanoid.Health > 0 then
                            if v.Character:FindFirstChild("HumanoidRootPart") then
                                local distance = (OAO.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                                if distance < closestDistance then
                                    closestDistance = distance
                                    closestPlayer = v.Character
                                end
                            end
                        end
                    end
                    if closestPlayer then
                        camera.CFrame = CFrame.lookAt(camera.CFrame.p, closestPlayer.HumanoidRootPart.Position)
                    end
                end
            end)
        end)
    else
        local O_O = game.Players.LocalPlayer
        local OAO = O_O.Character
        local camera = workspace.CurrentCamera
        if OAO and OAO:FindFirstChild("HumanoidRootPart") then
            camera.CFrame = CFrame.new(OAO.HumanoidRootPart.Position, OAO.HumanoidRootPart.Position + Vector3.new(0, 0, 1))
        end
    end
end)

-- 透视躲藏者
tool:Toggle("透视躲藏者", "", false, function(state)
    if state then
        local O_O = game.Players.LocalPlayer
        for _, v in next, game.Players:GetPlayers() do
            if v ~= O_O and v.Team and v.Team.Name == "Hider" and v.Character then
                -- ESP函数需要定义
                if getgenv().ESPHider then
                    getgenv().ESPHider("躲藏者" .. v.Name, v.Character, Color3.new(0, 0, 1))
                end
            end
        end
    else
        if workspace:FindFirstChild("HiderESPFloder") then
            workspace.HiderESPFloder:ClearAllChildren()
        end
    end
end)

-- 透视搜查者
tool:Toggle("透视搜查者", "", false, function(state)
    if state then
        local O_O = game.Players.LocalPlayer
        for _, v in next, game.Players:GetPlayers() do
            if v ~= O_O and v.Team and v.Team.Name == "Seeker" and v.Character then
                -- ESP函数需要定义
                if getgenv().ESPSeeker then
                    getgenv().ESPSeeker("搜查者" .. v.Name, v.Character, Color3.new(1, 0, 0))
                end
            end
        end
    else
        if workspace:FindFirstChild("SeekerESPFloder") then
            workspace.SeekerESPFloder:ClearAllChildren()
        end
    end
end)

-- 自动获取金币
tool:Toggle("自动获取金币", "", false, function(state)
    getgenv().AutoCollectCoins = state
    pcall(function()
        spawn(function()
            while task.wait(0.1) and getgenv().AutoCollectCoins do
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local trash = workspace:FindFirstChild("Trash")
                    if trash and trash:FindFirstChild("Coins") then
                        for _, v in next, trash.Coins:GetChildren() do
                            if v:FindFirstChild("Coin") then
                                firetouchinterest(v.Coin, character.HumanoidRootPart, 0)
                                firetouchinterest(v.Coin, character.HumanoidRootPart, 1)
                            end
                        end
                    end
                end
            end
        end)
    end)
end)

-- 完成岛屿挑战
tool:Toggle("完成岛屿挑战(每回合可以挑战一次)", "", false, function(state)
    if state then
        local character = game.Players.LocalPlayer.Character
        local obby = workspace:FindFirstChild("Obby")
        if character and character:FindFirstChild("HumanoidRootPart") and obby then
            local pad = obby:FindFirstChild("Pad")
            if pad and pad:FindFirstChild("Pad") then
                firetouchinterest(pad.Pad, character.HumanoidRootPart, 0)
                firetouchinterest(pad.Pad, character.HumanoidRootPart, 1)
            end
        end
    end
end)

-- 穿墙
tool:Toggle("穿墙", "", false, function(state)
    getgenv().Noclip = state
    spawn(function()
        while getgenv().Noclip do 
            wait(0.1)
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = not state
                        end
                    end
                end
            end)
        end
    end)
end)

-- 永远成为搜查者
tool:Toggle("永远成为搜查者", "", false, function(state)
    getgenv().AlwaysSeeker = state
    spawn(function()
        while getgenv().AlwaysSeeker do 
            wait(0.1)
            pcall(function()
                local O_O = game.Players.LocalPlayer
                local playerGui = O_O:FindFirstChild("PlayerGui")
                
                if playerGui then
                    local frames = playerGui:FindFirstChild("Frames")
                    if frames then
                        local role_reveal = frames:FindFirstChild("role_reveal")
                        if role_reveal then
                            local seeker_chance = role_reveal:FindFirstChild("seeker_chance")
                            if seeker_chance and seeker_chance.TextTransparency ~= 1 then
                                local role = role_reveal:FindFirstChild("role")
                                if role then
                                    if role:FindFirstChild("Seeker") then
                                        role.Seeker.Visible = true
                                    end
                                    if role:FindFirstChild("Hider") then
                                        role.Hider.Visible = false
                                    end
                                end
                            end
                            if seeker_chance then
                                seeker_chance.Text = "Chance to be seeker: 100%"
                            end
                        end
                    end
                end
                
                if not O_O.Team or O_O.Team.Name == "Hider" then
                    local network = game:GetService("ReplicatedStorage"):FindFirstChild("Network")
                    if network then
                        local match = network:FindFirstChild("match")
                        if match then
                            local WantsToJoinMatch = match:FindFirstChild("WantsToJoinMatch")
                            if WantsToJoinMatch then
                                WantsToJoinMatch:FireServer()
                            end
                        end
                    end
                    local seekerTeam = game:GetService("Teams"):FindFirstChild("Seeker")
                    if seekerTeam then
                        O_O.Team = seekerTeam
                    end
                end
            end)
        end
    end)
end)

-- 自动攻击所有玩家
tool:Button("自动攻击所有玩家", function()
    local O_O = game.Players.LocalPlayer
    local secondary = O_O.Character:FindFirstChild("Secondary") or O_O.Backpack:FindFirstChild("Secondary")
    
    if secondary then
        local network = game:GetService("ReplicatedStorage"):FindFirstChild("Network")
        if network then
            local knife = network:FindFirstChild("knife")
            if knife then
                local slash = knife:FindFirstChild("slash")
                if slash then
                    for _, player in next, game.Players:GetPlayers() do
                        if player ~= O_O and player.Character and player.Character:FindFirstChild("Humanoid") then
                            for i = 1, 4 do
                                slash:FireServer(
                                    workspace:GetServerTimeNow(),
                                    secondary,
                                    player.Character:GetPivot(),
                                    player.Character.Humanoid
                                )
                            end
                        end
                    end
                end
            end
        end
    end
end)

local creds = window:Tab("幸运方块战争",'6035145364')

local tool = creds:section("功能",true)

-- 生成数量文本框
local generateCount = 1
tool:Textbox("生成数量", "", "1", function(value)
    generateCount = tonumber(value) or 1
    print("生成数量设置为: " .. generateCount)
end)

-- 攻击体积按钮
tool:Button("攻击体积！", function()
    getgenv().HeadSize = 25
    getgenv().Disabled = true

    game:GetService('RunService').RenderStepped:Connect(function()
        if not getgenv().Disabled then return end
        
        for i, v in next, game:GetService('Players'):GetPlayers() do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                pcall(function()
                    local character = v.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.Size = Vector3.new(getgenv().HeadSize, getgenv().HeadSize, getgenv().HeadSize)
                        character.HumanoidRootPart.Transparency = 0.7
                        character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
                        character.HumanoidRootPart.Material = "Neon"
                        character.HumanoidRootPart.CanCollide = false
                    end
                end)
            end
        end
    end)
end)

-- 获得所有幸运方块（优化版本）
tool:Button("获得所有幸运方块", function()
    local spawnGalaxy = game:GetService("ReplicatedStorage"):FindFirstChild("SpawnGalaxyBlock")
    if spawnGalaxy then
        -- 只执行一次，而不是重复执行100次
        for i = 1, 5 do  -- 减少次数以避免服务器过载
            spawnGalaxy:FireServer()
            wait(0.01)  -- 添加微小延迟
        end
        print("已尝试生成5次银河方块")
    else
        print("未找到 SpawnGalaxyBlock 远程事件")
    end
end)

-- 幸运块
tool:Button("幸运块", function()
    local spawnLucky = game.ReplicatedStorage:FindFirstChild("SpawnLuckyBlock")
    if spawnLucky then
        for i = 1, generateCount do
            spawnLucky:FireServer()
            if i % 10 == 0 then  -- 每10次添加微小延迟
                wait(0.01)
            end
        end
        print("已生成 " .. generateCount .. " 个幸运块")
    else
        print("未找到 SpawnLuckyBlock 远程事件")
    end
end)

-- 钻石块
tool:Button("钻石块", function()
    local spawnDiamond = game.ReplicatedStorage:FindFirstChild("SpawnDiamondBlock")
    if spawnDiamond then
        for i = 1, generateCount do
            spawnDiamond:FireServer()
            if i % 10 == 0 then
                wait(0.01)
            end
        end
        print("已生成 " .. generateCount .. " 个钻石块")
    else
        print("未找到 SpawnDiamondBlock 远程事件")
    end
end)

-- 超级块
tool:Button("超级块", function()
    local spawnSuper = game.ReplicatedStorage:FindFirstChild("SpawnSuperBlock")
    if spawnSuper then
        for i = 1, generateCount do
            spawnSuper:FireServer()
            if i % 10 == 0 then
                wait(0.01)
            end
        end
        print("已生成 " .. generateCount .. " 个超级块")
    else
        print("未找到 SpawnSuperBlock 远程事件")
    end
end)

-- 彩虹块
tool:Button("彩虹块", function()
    local spawnRainbow = game.ReplicatedStorage:FindFirstChild("SpawnRainbowBlock")
    if spawnRainbow then
        for i = 1, generateCount do
            spawnRainbow:FireServer()
            if i % 10 == 0 then
                wait(0.01)
            end
        end
        print("已生成 " .. generateCount .. " 个彩虹块")
    else
        print("未找到 SpawnRainbowBlock 远程事件")
    end
end)

-- 银河块
tool:Button("银河块", function()
    local spawnGalaxy = game.ReplicatedStorage:FindFirstChild("SpawnGalaxyBlock")
    if spawnGalaxy then
        for i = 1, generateCount do
            spawnGalaxy:FireServer()
            if i % 10 == 0 then
                wait(0.01)
            end
        end
        print("已生成 " .. generateCount .. " 个银河块")
    else
        print("未找到 SpawnGalaxyBlock 远程事件")
    end
end)

local creds = window:Tab("究极进化",'6035145364')

local tool = creds:section("功能",true)

-- 自动耐力
tool:Toggle("自动耐力", "", false, function(value)
    getgenv().AutoEndurance = value
    if value then
        spawn(function()
            while getgenv().AutoEndurance do
                -- 这里需要添加耐力训练的具体代码
                -- 例如: game:GetService("ReplicatedStorage").Training.Remote:FireServer("Endurance")
                print("自动耐力训练已开启")
                wait(1)
            end
        end)
    else
        print("自动耐力训练已关闭")
    end
end)

-- 自动力量
tool:Toggle("自动力量", "", false, function(value)
    getgenv().AutoStrenght = value
    if value then
        spawn(function()
            while getgenv().AutoStrenght do
                -- 这里需要添加力量训练的具体代码
                -- 例如: game:GetService("ReplicatedStorage").Training.Remote:FireServer("Strength")
                print("自动力量训练已开启")
                wait(1)
            end
        end)
    else
        print("自动力量训练已关闭")
    end
end)

-- 自动敏捷性
tool:Toggle("自动敏捷性", "", false, function(value)
    getgenv().AutoAgility = value
    if value then
        spawn(function()
            while getgenv().AutoAgility do
                -- 这里需要添加敏捷性训练的具体代码
                -- 例如: game:GetService("ReplicatedStorage").Training.Remote:FireServer("Agility")
                print("自动敏捷性训练已开启")
                wait(1)
            end
        end)
    else
        print("自动敏捷性训练已关闭")
    end
end)

-- 自动杀暴徒
tool:Toggle("自动杀暴徒", "", false, function(value)
    getgenv().AutoKillNPC = value
    if value then
        spawn(function()
            while getgenv().AutoKillNPC do
                -- 这里需要添加杀NPC暴徒的具体代码
                pcall(function()
                    -- 示例代码: 自动攻击附近的NPC
                    for _, npc in pairs(workspace.NPCs:GetChildren()) do
                        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                            -- 移动到NPC附近并攻击
                            local character = game.Players.LocalPlayer.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                -- 攻击逻辑
                                -- game:GetService("ReplicatedStorage").Combat.Remote:FireServer("Attack", npc)
                            end
                        end
                    end
                end)
                wait(0.5)
            end
        end)
    else
        print("自动杀暴徒已关闭")
    end
end)

-- 自动收集硬币
tool:Toggle("自动收集硬币", "", false, function(value)
    getgenv().CollectCoin = value
    if value then
        spawn(function()
            while getgenv().CollectCoin do
                -- 这里需要添加收集硬币的具体代码
                pcall(function()
                    for _, coin in pairs(workspace.Coins:GetChildren()) do
                        if coin:IsA("BasePart") then
                            local character = game.Players.LocalPlayer.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                -- 收集硬币逻辑
                                firetouchinterest(character.HumanoidRootPart, coin, 0)
                                firetouchinterest(character.HumanoidRootPart, coin, 1)
                            end
                        end
                    end
                end)
                wait(0.3)
            end
        end)
    else
        print("自动收集硬币已关闭")
    end
end)

local creds = window:Tab("*Break-In",'6035145364')

local tool = creds:section("武器区",true)

-- 锤子按钮
tool:Button("锤子", function()
    local basementWeapon = game.ReplicatedStorage.RemoteEvents:FindFirstChild("BasementWeapon")
    if basementWeapon then
        basementWeapon:FireServer(true, "Hammer")
        print("已获取锤子")
    else
        print("未找到 BasementWeapon 远程事件")
    end
end)

-- 球棒按钮
tool:Button("球棒", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Bat")
        print("已获取球棒")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 剑按钮
tool:Button("剑", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("LinkedSword")
        print("已获取剑")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

local tool = creds:section("物品区",true)

-- 薯片按钮
tool:Button("薯片", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Chips")
        print("已获取薯片")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 棒棒糖按钮
tool:Button("棒棒糖", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Lollipop")
        print("已获取棒棒糖")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 可乐按钮
tool:Button("可乐", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("BloxyCola")
        print("已获取可乐")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 苹果按钮
tool:Button("苹果", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Apple")
        print("已获取苹果")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 披萨按钮
tool:Button("披萨", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Pizza2")
        print("已获取披萨")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 饼干按钮
tool:Button("饼干", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Cookie")
        print("已获取饼干")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 医疗包按钮
tool:Button("医疗包", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("MedKit")
        print("已获取医疗包")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 药物按钮
tool:Button("药物", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Cure")
        print("已获取药物")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 木板按钮
tool:Button("木板", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Plank")
        print("已获取木板")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

-- 泰迪熊按钮
tool:Button("泰迪熊", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("TeddyBloxpin")
        print("已获取泰迪熊")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

local tool = creds:section("免费通行证角色",true)

-- 玩具剑小孩按钮
tool:Button("玩具剑小孩", function()
    local makeRole = game:GetService("ReplicatedStorage").RemoteEvents:FindFirstChild("MakeRole")
    if makeRole then
        makeRole:FireServer("LinkedSword", true, false)
        print("已变更为玩具剑小孩角色")
    else
        print("未找到 MakeRole 远程事件")
    end
end)

-- 警员按钮
tool:Button("警员", function()
    local outsideRole = game:GetService("ReplicatedStorage").RemoteEvents:FindFirstChild("OutsideRole")
    if outsideRole then
        outsideRole:FireServer("Gun", true)
        print("已变更为警员角色")
    else
        print("未找到 OutsideRole 远程事件")
    end
end)

-- 特警按钮
tool:Button("特警", function()
    local outsideRole = game:GetService("ReplicatedStorage").RemoteEvents:FindFirstChild("OutsideRole")
    if outsideRole then
        outsideRole:FireServer("SwatGun", true)
        print("已变更为特警角色")
    else
        print("未找到 OutsideRole 远程事件")
    end
end)

local tool = creds:section("传送功能",true)

-- 地下室传送
tool:Button("地下室", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(71, -15, -163)
        print("已传送到地下室")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 房子传送
tool:Button("房子", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(-36, 3, -200)
        print("已传送到房子")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 顶楼传送
tool:Button("顶楼", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(-16, 35, -220)
        print("已传送到顶楼")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 超市传送
tool:Button("超市", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(-422, 3, -121)
        print("已传送到超市")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 下水道传送
tool:Button("下水道", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(129, 3, -125)
        print("已传送到下水道")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- Boss房间传送
tool:Button("Boss房间", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(-39, -287, -1480)
        print("已传送到Boss房间")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

local tool = creds:section("其他",true)

-- 猫的朋友按钮
tool:Button("猫的朋友", function()
    local cattery = game.ReplicatedStorage.RemoteEvents:FindFirstChild("Cattery")
    if cattery then
        cattery:FireServer()
        print("已触发猫的朋友功能")
    else
        print("未找到 Cattery 远程事件")
    end
end)

-- 解锁地下室按钮
tool:Button("解锁地下室", function()
    local unlockDoor = game.ReplicatedStorage.RemoteEvents:FindFirstChild("UnlockDoor")
    if unlockDoor then
        unlockDoor:FireServer()
        print("已尝试解锁地下室")
    else
        print("未找到 UnlockDoor 远程事件")
    end
end)

-- 地下室灯光按钮
tool:Button("地下室灯光", function()
    local basementMission = game.ReplicatedStorage.RemoteEvents:FindFirstChild("BasementMission")
    local getAmbient = game.ReplicatedStorage.RemoteFunctions:FindFirstChild("GetAmbient")
    
    if basementMission then
        basementMission:FireServer()
        print("已触发地下室任务")
    else
        print("未找到 BasementMission 远程事件")
    end
    
    if getAmbient then
        getAmbient:InvokeServer()
        print("已获取环境设置")
    else
        print("未找到 GetAmbient 远程函数")
    end
end)

-- 地下室钥匙按钮
tool:Button("地下室钥匙", function()
    local giveTool = game.ReplicatedStorage.RemoteEvents:FindFirstChild("GiveTool")
    if giveTool then
        giveTool:FireServer("Key")
        print("已获取地下室钥匙")
    else
        print("未找到 GiveTool 远程事件")
    end
end)

local creds = window:Tab("破坏模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Button("破坏模拟器",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/AquaModz/DestructionSIMModded/main/DestructionSimAqua.lua'))()
end)

tool:Button("无限射击",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/AquaModz/DestructionSIMModded/main/DestructionSimAqua.lua'))()
end)

local creds = window:Tab("奎尔湖",'6035145364')

local tool = creds:section("功能",true)

tool:Button("奎尔湖",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Solx69/Shit-Boy-Hub-Main/main/Master.lua'))()
end)

tool:Toggle("无敌模式","", false, function(Value)
        game.ReplicatedStorage.DamageHumanoid:FireServer(-2e9)
    end)
    
    tool:Button("无限金钱", function()
    local money = {
       [1] = -9999,
       [2] = "Buy"
    }
    
    game:GetService("ReplicatedStorage").Pay:FireServer(unpack(money))
    end)
    
    tool:Button("无限金币", function()
    local gold = {
       [1] = game:GetService("Players").LocalPlayer.GoldCoins,
       [2] = 99999
    }
    
    game:GetService("ReplicatedStorage").ChangeValue:FireServer(unpack(gold))
    end)
    
    tool:Button("给所有物品", function()
    game.ReplicatedStorage.GiveTool:FireServer("SeaScooter")
    game.ReplicatedStorage.GiveTool:FireServer("Lantern")
    game.ReplicatedStorage.GiveTool:FireServer("Compass")
    game.ReplicatedStorage.GiveTool:FireServer("ItemFinder")
    game.ReplicatedStorage.GiveTool:FireServer("Aquabreather")
    end)
    
    tool:Button("红色套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("FireSuit")
    end)
    
    tool:Button("黄色套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("HazmatSuit")
    end)
    
    tool:Button("海盗套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("PirateCostume")
    end)
    
    tool:Button("动力套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("SuperScuba")
    end)

local creds = window:Tab("钓鱼模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("跳跃","text",false,function(s)
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
tool:Toggle("自动杀鲨鱼","text",false,function(State)
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
tool:Toggle("自动钓鱼","text",false,function(bool)
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
tool:Toggle("自动杀boss","text",false,function(State)
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
tool:Toggle("减少延迟","text",false,function(State)
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
tool:Toggle("自动锁定稀有物品","text",false,function(State)
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
tool:Toggle("自动抓捕","text",false,function(State)
 toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.FishCaught:FireServer()
    end
end)
tool:Toggle("自动售卖","text",false,function(State)
 toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.processGameItemSold:InvokeServer("SellEverything")
    end
end)
tool:Toggle("每日宝箱","text",false,function(State)
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
tool:Toggle("随机宝箱","text",false,function(State)
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

local creds = window:Tab("极限捉迷藏",'6035145364')

local tool = creds:section("功能",true)

-- 自动收集硬币
tool:Toggle("自动收集硬币", "", false, function(Value)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.AutoCollect = Value
    
    spawn(function()
        local Player = game.Players.LocalPlayer
        while getgenv().Settings and getgenv().Settings.AutoCollect do
            local character = Player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name == 'Credit' and v:IsA("BasePart") then
                        v.CFrame = character.HumanoidRootPart.CFrame
                    end
                end
            end
            wait(0.1)
        end
    end)
end)

-- 透视玩家
tool:Toggle("透视玩家", "", false, function(Bool)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.Names = Bool
    
    if Bool then
        InitializeESP()
    else
        CleanupESP()
    end
end)

-- 自动杀死(寻找者)
tool:Toggle("自动杀死(寻找者)", "", false, function(Value)
    getgenv().Settings = getgenv().Settings or {}
    getgenv().Settings.AutoKill = Value
end)

-- ESP系统初始化
local function InitializeESP()
    if getgenv().ESPInitialized then return end
    
    getgenv().ESPInitialized = true
    getgenv().espObjects = getgenv().espObjects or {}
    
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    
    -- Drawing函数定义
    local function DrawText()
        local success, result = pcall(function()
            return Drawing.new("Text")
        end)
        if success then
            result.Color = Color3.fromRGB(190, 190, 0)
            result.Size = 20
            result.Outline = true
            result.Center = true
            return result
        end
        return nil
    end
    
    local function DrawSquare()
        local success, result = pcall(function()
            return Drawing.new("Square")
        end)
        if success then
            result.Color = Color3.fromRGB(190, 190, 0)
            result.Thickness = 0.5
            result.Filled = false
            result.Transparency = 1
            return result
        end
        return nil
    end
    
    local function IsPlayerAlive(player)
        return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    end
    
    local function GetOffset(part, pos)
        local FarPosition = Camera:WorldToViewportPoint(Vector3.new(part.Position.X, part.Position.Y + (part.Size.Y / 2), part.Position.Z))
        return FarPosition.Y - pos.Y
    end
    
    local function GetCorners(player)
        local TopY = math.huge
        local BottomY = -math.huge
        local RightX = -math.huge
        local LeftX = math.huge
        local Offsets = 0
        local Positions = {}
        
        local character = player.Character
        if not character then return nil end
        
        for _, v in pairs(character:GetChildren()) do
            if (v:IsA("MeshPart") or v.Name == "Head") and v:IsA("BasePart") then
                local Position, OnScreen = Camera:WorldToViewportPoint(v.Position)
                if OnScreen then
                    Positions[v.Name] = Position
                    local offset = GetOffset(v, Position)
                    if offset then
                        Offsets = offset
                    end
                    
                    if Position.Y < TopY then
                        TopY = Position.Y
                    end
                    if Position.Y > BottomY then
                        BottomY = Position.Y
                    end
                    if Position.X < LeftX then
                        LeftX = Position.X
                    end
                    if Position.X > RightX then
                        RightX = Position.X
                    end
                end
            end
        end
        
        return {
            TopLeft = Vector2.new(LeftX + Offsets, TopY + Offsets),
            TopRight = Vector2.new(RightX - Offsets, TopY + Offsets),
            BottomLeft = Vector2.new(LeftX + Offsets, BottomY - Offsets),
            BottomRight = Vector2.new(RightX - Offsets, BottomY - Offsets),
            Positions = Positions
        }
    end
    
    local function AddEsp(player)
        if getgenv().espObjects[player] or player == Player then return end
        
        local Box = DrawSquare()
        local Name = DrawText()
        if not Box or not Name then return end
        
        getgenv().espObjects[player] = {Box = Box, Name = Name}
        
        local connection
        connection = RunService.Stepped:Connect(function()
            if not IsPlayerAlive(player) or not (getgenv().Settings and getgenv().Settings.Names) then
                Box.Visible = false
                Name.Visible = false
                return
            end
            
            local Corners = GetCorners(player)
            if not Corners then return end
            
            local Positions = Corners.Positions
            local xDist = Corners.BottomRight.X - Corners.TopLeft.X
            local yDist = Corners.BottomRight.Y - Corners.TopLeft.Y
            local RootPosition, OnScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            
            if getgenv().Settings.Names and OnScreen then
                Box.Visible = true
                Name.Visible = true
                Box.Size = Vector2.new(xDist, yDist)
                Box.Position = Corners.TopLeft
                Name.Position = Vector2.new(Corners.BottomRight.X - (xDist / 2), Corners.TopLeft.Y - 45)
                Name.Text = player.Name
            else
                Box.Visible = false
                Name.Visible = false
            end
        end)
        
        player.CharacterRemoving:Connect(function()
            if connection then
                connection:Disconnect()
            end
            if Box then Box:Remove() end
            if Name then Name:Remove() end
            getgenv().espObjects[player] = nil
        end)
    end
    
    local function RemoveEsp(player)
        if getgenv().espObjects[player] then
            if getgenv().espObjects[player].Box then
                getgenv().espObjects[player].Box:Remove()
            end
            if getgenv().espObjects[player].Name then
                getgenv().espObjects[player].Name:Remove()
            end
            getgenv().espObjects[player] = nil
        end
    end
    
    -- 为现有玩家添加ESP
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player then
            AddEsp(player)
        end
    end
    
    -- 玩家加入事件
    Players.PlayerAdded:Connect(function(player)
        if player ~= Player then
            AddEsp(player)
        end
    end)
    
    -- 玩家离开事件
    Players.PlayerRemoving:Connect(function(player)
        RemoveEsp(player)
    end)
end

-- 清理ESP
local function CleanupESP()
    if getgenv().espObjects then
        for player, objects in pairs(getgenv().espObjects) do
            if objects.Box then objects.Box:Remove() end
            if objects.Name then objects.Name:Remove() end
        end
        getgenv().espObjects = {}
    end
end

-- 自动杀死循环
spawn(function()
    while true do
        if getgenv().Settings and getgenv().Settings.AutoKill then
            local Player = game.Players.LocalPlayer
            local character = Player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                
                for _, v in pairs(game.Players:GetPlayers()) do 
                    if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local playerBody = v.Character.HumanoidRootPart
                        
                        if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then 
                            hrp.CFrame = playerBody.CFrame
                        end
                    end
                end
            end
        end
        wait(0.2)
    end
end)

local creds = window:Tab("极速奔驰",'6035145364')

local tool = creds:section("功能",true)

-- 自动跳过（快速版）
tool:Toggle("自动跳过", "", false, function(bool)
    getgenv().AutoFarmMainFast = bool
    
    spawn(function()
        while getgenv().AutoFarmMainFast do
            local beatLevel = game:GetService("ReplicatedStorage"):FindFirstChild("BeatLevel")
            local setLevel = game:GetService("ReplicatedStorage"):FindFirstChild("SetLevel")
            
            if beatLevel then
                for _ = 1, 30 do
                    beatLevel:FireServer(0.1, "Level 1", "Normal", false)
                    wait(0.07)
                end
            else
                print("未找到 BeatLevel 远程事件")
                break
            end
            
            if setLevel then
                for _ = 1, 3 do
                    setLevel:FireServer(0)
                    wait(0.1)
                end
            else
                print("未找到 SetLevel 远程事件")
            end
            
            wait(0.4)
        end
    end)
end)

-- 自动跳过（慢速版）
tool:Toggle("自动跳过2", "", false, function(bool)
    getgenv().AutoFarmMainSlow = bool
    
    spawn(function()
        while getgenv().AutoFarmMainSlow do
            local beatLevel = game:GetService("ReplicatedStorage"):FindFirstChild("BeatLevel")
            local setLevel = game:GetService("ReplicatedStorage"):FindFirstChild("SetLevel")
            
            if beatLevel then
                for _ = 1, 33 do
                    beatLevel:FireServer(0.1, "Level 1", "Normal", false)
                    wait(0.25)
                end
            else
                print("未找到 BeatLevel 远程事件")
                break
            end
            
            if setLevel then
                for _ = 1, 3 do
                    setLevel:FireServer(0)
                    wait(0.3)
                end
            else
                print("未找到 SetLevel 远程事件")
            end
            
            wait(0.5)
        end
    end)
end)

-- 获取速度线圈按钮
tool:Button("获取速度线圈", function()
    local speedCoil = game:GetService("ReplicatedStorage"):FindFirstChild("Speed Coil")
    local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
    
    if speedCoil and backpack then
        local copy = speedCoil:Clone()
        copy.Parent = backpack
        print("已获取速度线圈")
    else
        if not speedCoil then
            print("未找到 Speed Coil 物品")
        end
        if not backpack then
            print("未找到背包")
        end
    end
end)

local creds = window:Tab("奶酪逃生",'6035145364')

local tool = creds:section("功能",true)

-- 获取所有奶酪按钮
tool:Button("获取所有奶酪", function()
    local findCheese = game.Workspace:FindFirstChild("FindCheese")
    if findCheese then
        local cheeseCount = 0
        for _, v in pairs(findCheese:GetDescendants()) do
            if v.Name == 'Cheese' then
                local clickDetector = v:FindFirstChild("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                    cheeseCount = cheeseCount + 1
                end
            end
        end
        print("已尝试获取 " .. cheeseCount .. " 个奶酪")
    else
        print("未找到 FindCheese 文件夹")
    end
end)

-- 打开所有门按钮
local toggleDoor = false
tool:Button("打开所有门", function()
    toggleDoor = not toggleDoor
    
    if toggleDoor then
        print("开始自动打开所有门")
        spawn(function()
            local doors = game.Workspace:FindFirstChild("Doors")
            if doors then
                while toggleDoor do
                    wait(0.5)
                    for _, door in ipairs(doors:GetChildren()) do
                        local clickDetector = door:FindFirstChild("ClickDetector")
                        if clickDetector then
                            fireclickdetector(clickDetector)
                        end
                    end
                end
            else
                print("未找到 Doors 文件夹")
                toggleDoor = false
            end
        end)
    else
        print("停止自动打开门")
    end
end)

-- 标签：锁门密码
tool:Label("锁门密码: 3842")

-- 出生点按钮
tool:Button("出生点", function()
    local character = game.Players.LocalPlayer.Character
    local spawnLocation = game.Workspace:FindFirstChild("SpawnLocation")
    
    if character and spawnLocation then
        character:MoveTo(spawnLocation.Position)
        print("已传送到出生点")
    else
        if not character then
            print("无法传送：角色不存在")
        end
        if not spawnLocation then
            print("未找到 SpawnLocation")
        end
    end
end)

-- 传送位置按钮
local teleports = {
    {"安全区", Vector3.new(-73.6963, 4.2, -109.536)},
    {"奶酪1", Vector3.new(-264.393, 4.19329, -56.25)},
    {"奶酪2", Vector3.new(-275.163, 4.19329, -149.3)},
    {"奶酪3", Vector3.new(-271.628, 4.19329, -33.53)},
    {"安全区2", Vector3.new(-272.487, 48.5, -150.641)},
    {"奶酪4", Vector3.new(-205.069, 4.19329, -180.7)},
    {"跑酷", Vector3.new(-25.2942, 100.5, -1037.5)},
    {"离开", Vector3.new(-24.3932, 5, 24.3302)},
    {"锁定区域", Vector3.new(-220.522, 4, -452.123)},
    {"地下室", Vector3.new(-88.9135, 4, -451.278)},
    {"终点", Vector3.new(1758.41, 57, -137.61)}
}

for _, data in ipairs(teleports) do
    tool:Button(data[1], function()
        local character = game.Players.LocalPlayer.Character
        if character then
            character:MoveTo(data[2])
            print("已传送到: " .. data[1])
        else
            print("无法传送：角色不存在")
        end
    end)
end

local creds = window:Tab("水下公司",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("自动拾取物品", "", false, function(state)
    getgenv().autoPickupRunning = state
    
    if state and not getgenv().autoPickupThread then
        spawn(function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            
            if not character then
                character = player.CharacterAdded:Wait()
            end
            
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local startPosition = Vector3.new(-503.2907409667969, -43.40001678466797, -1464.4521484375)
            local dropPosition = Vector3.new(-503.2907409667969, -43.40001678466797, -1464.4521484375)  
            local distanceThreshold = 200
            
            while getgenv().autoPickupRunning do
                local itemsFolder = workspace:FindFirstChild("Items")
                if itemsFolder then
                    for _, item in ipairs(itemsFolder:GetChildren()) do
                        if not getgenv().autoPickupRunning then break end
                        
                        local primaryPart = item.PrimaryPart or item:FindFirstChild("PrimaryPart")
                        if primaryPart then
                            local position = primaryPart.Position
                            local distance = (position - startPosition).magnitude
                            
                            if distance > distanceThreshold then
                                -- 传送到物品位置
                                humanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 1, 0))
                                wait(0.5)
                                
                                -- 寻找并触发ProximityPrompt
                                local foundPrompt = false
                                for _, prompt in ipairs(item:GetDescendants()) do
                                    if prompt:IsA("ProximityPrompt") then
                                        fireproximityprompt(prompt)
                                        foundPrompt = true
                                        break
                                    end
                                end
                                
                                if foundPrompt then
                                    wait(0.5)
                                    -- 传送到丢弃位置
                                    humanoidRootPart.CFrame = CFrame.new(dropPosition)
                                    wait(0.5)
                                    
                                    -- 丢弃物品
                                    local dropRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Drop")
                                    if dropRemote then
                                        dropRemote:FireServer()
                                        print("已拾取并丢弃物品: " .. item.Name)
                                    else
                                        print("未找到 Drop 远程事件")
                                    end
                                    wait(0.5)
                                end
                            end
                        end
                    end
                else
                    print("未找到 Items 文件夹")
                    wait(2)
                end
                wait(1)
            end
            
            getgenv().autoPickupThread = nil
            print("自动拾取已停止")
        end)
        
        getgenv().autoPickupThread = true  -- 标记线程已启动
        print("自动拾取已开始")
    else
        print("自动拾取已停止")
    end
end)

local creds = window:Tab("皮肤行者",'6035145364')

local tool = creds:section("功能",true)

-- 幸存者透视
tool:Toggle("幸存者透视", "", false, function(state)
    if state then
        if getgenv().civiliansconnection then 
            getgenv().civiliansconnection:Disconnect() 
        end
        
        local civilians = workspace.Runners:FindFirstChild("Civilians")
        if civilians then
            for _, v in next, civilians:GetChildren() do
                if getgenv().ESPCivilians then
                    getgenv().ESPCivilians(v.Name, v, Color3.new(1, 0, 0))
                end
            end
            
            getgenv().civiliansconnection = civilians.ChildAdded:Connect(function(v)
                if getgenv().ESPCivilians then
                    getgenv().ESPCivilians(v.Name, v, Color3.new(1, 0, 0))
                end
            end)
        end
        print("幸存者透视已开启")
    else
        if getgenv().civiliansconnection then 
            getgenv().civiliansconnection:Disconnect() 
            getgenv().civiliansconnection = nil
        end
        
        local espFolder = workspace:FindFirstChild("CiviliansESPFloder")
        if espFolder then
            espFolder:ClearAllChildren()
        end
        print("幸存者透视已关闭")
    end
end)

-- 怪物透视
tool:Toggle("怪物透视", "", false, function(state)
    if state then
        if getgenv().skinwalkersconnection then 
            getgenv().skinwalkersconnection:Disconnect() 
        end
        
        local skinwalkers = workspace.Runners:FindFirstChild("Skinwalkers")
        if skinwalkers then
            for _, v in next, skinwalkers:GetChildren() do
                if getgenv().ESPSkinwalkers then
                    getgenv().ESPSkinwalkers("怪物", v, Color3.new(0, 0, 1))
                end
            end
            
            getgenv().skinwalkersconnection = skinwalkers.ChildAdded:Connect(function(v)
                if getgenv().ESPSkinwalkers then
                    getgenv().ESPSkinwalkers("怪物", v, Color3.new(0, 0, 1))
                end
            end)
        end
        print("怪物透视已开启")
    else
        if getgenv().skinwalkersconnection then 
            getgenv().skinwalkersconnection:Disconnect() 
            getgenv().skinwalkersconnection = nil
        end
        
        local espFolder = workspace:FindFirstChild("SkinwalkersESPFloder")
        if espFolder then
            espFolder:ClearAllChildren()
        end
        print("怪物透视已关闭")
    end
end)

-- 杀死全部(皮肤行者)
tool:Toggle("杀死全部(皮肤行者)", "", false, function(state)
    getgenv().GunauraSkinwalkers = state
    
    spawn(function()
        while getgenv().GunauraSkinwalkers do 
            task.wait(0.3)
            
            local skinwalkers = workspace.Runners:FindFirstChild("Skinwalkers")
            local character = game.Players.LocalPlayer.Character
            local sniperRemote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("SniperShot")
            
            if not skinwalkers or not character or not sniperRemote then
                wait(1)
                continue
            end
            
            local shotTargets = {}
            for _, v in next, skinwalkers:GetChildren() do
                if not getgenv().GunauraSkinwalkers then break end
                
                local humanoid = v:FindFirstChild("Humanoid")
                local head = v:FindFirstChild("Head")
                
                if humanoid and humanoid.Health > 0 and head then
                    for _, t in next, character:GetChildren() do
                        if t.Name == "Sniper" or t.Name == "Pistol" then
                            if not shotTargets[v] then
                                local args = {
                                    [1] = Vector3.new(head.Position.X, head.Position.Y, head.Position.Z),
                                    [2] = Vector3.new(head.Position.X, head.Position.Y, head.Position.Z),
                                    [3] = head
                                }
                                sniperRemote:FireServer(unpack(args))
                                shotTargets[v] = true
                                break
                            end
                        elseif t.Name == "Gatling" then
                            local args = {
                                [1] = Vector3.new(head.Position.X, head.Position.Y, head.Position.Z),
                                [2] = Vector3.new(head.Position.X, head.Position.Y, head.Position.Z),
                                [3] = head,
                                [4] = {
                                    ["BulletReduction"] = 0,
                                    ["Damage"] = math.huge
                                }
                            }
                            sniperRemote:FireServer(unpack(args))
                            shotTargets[v] = true
                            break
                        end
                    end
                end
            end
        end
    end)
end)

-- 杀死全部(夜晚怪物)
tool:Toggle("杀死全部(夜晚怪物)", "", false, function(state)
    getgenv().GunauraNightwalkers = state
    
    spawn(function()
        while getgenv().GunauraNightwalkers do 
            task.wait(0.3)
            
            local nightwalkers = workspace:FindFirstChild("Nightwalkers")
            local character = game.Players.LocalPlayer.Character
            local sniperRemote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("SniperShot")
            
            if not nightwalkers or not character or not sniperRemote then
                wait(1)
                continue
            end
            
            local shotTargets = {}
            for _, v in next, nightwalkers:GetChildren() do
                if not getgenv().GunauraNightwalkers then break end
                
                local humanoid = v:FindFirstChild("Humanoid")
                local head = v:FindFirstChild("Head")
                
                if humanoid and humanoid.Health > 0 and head then
                    for _, t in next, character:GetChildren() do
                        if t.Name == "Sniper" or t.Name == "Pistol" then
                            if not shotTargets[v] then
                                local args = {
                                    [1] = Vector3.new(head.Position.X, head.Position.Y, head.Position.Z),
                                    [2] = Vector3.new(head.Position.X, head.Position.Y, head.Position.Z),
                                    [3] = head
                                }
                                sniperRemote:FireServer(unpack(args))
                                shotTargets[v] = true
                                break
                            end
                        elseif t.Name == "Gatling" then
                            local args = {
                                [1] = Vector3.new(head.Position.X, head.Position.Y, head.Position.Z),
                                [2] = Vector3.new(head.Position.X, head.Position.Y, head.Position.Z),
                                [3] = head,
                                [4] = {
                                    ["BulletReduction"] = 0,
                                    ["Damage"] = math.huge
                                }
                            }
                            sniperRemote:FireServer(unpack(args))
                            shotTargets[v] = true
                            break
                        end
                    end
                end
            end
        end
    end)
end)

-- 自动收集钱袋
tool:Toggle("自动收集钱袋", "", false, function(state)
    getgenv().CoMoneybag = state
    
    spawn(function()
        while getgenv().CoMoneybag do 
            task.wait(0.3)
            
            local gameObjects = workspace:FindFirstChild("GameObjects")
            if gameObjects then
                for _, v in next, gameObjects:GetChildren() do
                    if not getgenv().CoMoneybag then break end
                    
                    if v.Name == "MoneyBag" then
                        local prompt = v:FindFirstChild("ProximityPrompt")
                        if prompt then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end
    end)
end)

-- 自动售卖
tool:Toggle("自动售卖", "", false, function(state)
    getgenv().AutostoreSell = state
    
    spawn(function()
        while getgenv().AutostoreSell do 
            task.wait(0.3)
            
            local skinwalkers = workspace.Runners:FindFirstChild("Skinwalkers")
            local character = game.Players.LocalPlayer.Character
            local storeRemote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Store")
            
            if not skinwalkers or not character or not storeRemote then
                wait(1)
                continue
            end
            
            for _, v in next, skinwalkers:GetChildren() do
                if not getgenv().AutostoreSell then break end
                
                if v:IsA("Model") then
                    local distance = (v:GetPivot().Position - character:GetPivot().Position).Magnitude
                    if distance <= 15 then
                        storeRemote:FireServer(v)
                    end
                end
            end
        end
    end)
end)

-- 自动收集尸体
tool:Toggle("自动收集尸体", "", false, function(state)
    getgenv().AutostoreCollect = state
    
    spawn(function()
        while getgenv().AutostoreCollect do 
            task.wait(0.3)
            
            local skinwalkers = workspace.Runners:FindFirstChild("Skinwalkers")
            local character = game.Players.LocalPlayer.Character
            local storeRemote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Store")
            
            if not skinwalkers or not character or not storeRemote then
                wait(1)
                continue
            end
            
            for _, v in next, skinwalkers:GetChildren() do
                if not getgenv().AutostoreCollect then break end
                
                if v:IsA("Model") then
                    -- 传送到尸体位置
                    character:PivotTo(v:GetPivot().Position)
                    
                    local distance = (v:GetPivot().Position - character:GetPivot().Position).Magnitude
                    if distance <= 15 then
                        storeRemote:FireServer(v)
                    end
                end
            end
        end
    end)
end)

-- 自动放夹子(无需夹子直接放)
tool:Toggle("自动放夹子(无需夹子直接放)", "", false, function(state)
    getgenv().AutoTrap = state
    
    spawn(function()
        while getgenv().AutoTrap do 
            task.wait(0.3)
            
            local character = game.Players.LocalPlayer.Character
            local placeTrapRemote = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("PlaceTrap")
            
            if not character or not placeTrapRemote then
                wait(1)
                continue
            end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local args = {
                    [1] = Vector3.new(hrp.Position.X, hrp.Position.Y, hrp.Position.Z)
                }
                placeTrapRemote:FireServer(unpack(args))
            end
        end
    end)
end)

-- 获取加特林
tool:Button("获取加特林", function()
    local assets = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
    local tools = assets and assets:FindFirstChild("Tools")
    local gatling = tools and tools:FindFirstChild("Gatling")
    local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
    
    if not gatling then
        local playerGatling = backpack and backpack:FindFirstChild("Gatling")
        if playerGatling and tools then
            playerGatling.Parent = tools
            print("已将加特林存入仓库")
        end
    else
        if backpack then
            gatling.Parent = backpack
            print("已获取加特林")
        end
    end
end)

-- 获取可乐（修复：原代码有多个同名按钮）
tool:Button("获取可乐", function()
    local assets = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
    local tools = assets and assets:FindFirstChild("Tools")
    local cola = tools and tools:FindFirstChild("Cola")
    local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
    
    if not cola then
        local playerCola = backpack and backpack:FindFirstChild("Cola")
        if playerCola and tools then
            playerCola.Parent = tools
            print("已将可乐存入仓库")
        end
    else
        local amount = cola:FindFirstChild("Amount")
        if amount then
            amount.Value = 99
        end
        if backpack then
            cola.Parent = backpack
            print("已获取可乐（数量：99）")
        end
    end
end)

-- 获取Snapper（修复：原代码错误地命名为"获取可乐"）
tool:Button("获取Snapper", function()
    local assets = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
    local tools = assets and assets:FindFirstChild("Tools")
    local snapper = tools and tools:FindFirstChild("Snapper")
    local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
    
    if not snapper then
        local playerSnapper = backpack and backpack:FindFirstChild("Snapper")
        if playerSnapper and tools then
            playerSnapper.Parent = tools
            print("已将Snapper存入仓库")
        end
    else
        local amount = snapper:FindFirstChild("Amount")
        if amount then
            amount.Value = 99
        end
        if backpack then
            snapper.Parent = backpack
            print("已获取Snapper（数量：99）")
        end
    end
end)

-- 获取Turret（修复：原代码错误地命名为"获取可乐"）
tool:Button("获取Turret", function()
    local assets = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
    local tools = assets and assets:FindFirstChild("Tools")
    local turret = tools and tools:FindFirstChild("Turret")
    local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
    
    if not turret then
        local playerTurret = backpack and backpack:FindFirstChild("Turret")
        if playerTurret and tools then
            playerTurret.Parent = tools
            print("已将Turret存入仓库")
        end
    else
        local amount = turret:FindFirstChild("Amount")
        if amount then
            amount.Value = 99
        end
        if backpack then
            turret.Parent = backpack
            print("已获取Turret（数量：99）")
        end
    end
end)

local creds = window:Tab("火箭发射模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("自动收集燃料", "ARL", false, function(ARL)
    isFuelScoopEnabled = ARL while true do wait() if isFuelScoopEnabled then for i, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "FuelScoop" then h:Activate() end end end end
end)
tool:Button("登上火箭", function()
    game:GetService("ReplicatedStorage"):WaitForChild("BoardRocket"):FireServer()
end)
tool:Button("将玩家从所有者座位移除", function()
    game:GetService("ReplicatedStorage"):WaitForChild("RemovePlayer"):FireServer()
end)

tool:Button("发射台岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-123.15931701660156, 2.7371432781219482, 3.491959810256958)
end)
tool:Button("白云岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-76.13252258300781, 170.55825805664062, -60.4516716003418)
end)
tool:Button("浮漂岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-66.51714324951172, 720.4866333007812, -5.391753196716309)
end)
tool:Button("卫星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-34.2462043762207, 1429.4990234375, 1.3739361763000488)
end)
tool:Button("蜜蜂迷宫岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6.5361199378967285, 3131.249267578125, -29.759048461914062)
end)
tool:Button("月球人救援", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7.212917804718018, 5016.341796875, -19.815933227539062)
end)
tool:Button("暗物质岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.43186950683594, 6851.94091796875, 7.890637397766113)
end)
tool:Button("太空岩石岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(49.92888641357422, 8942.955078125, 8.674375534057617)
end)
tool:Button("零号火星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(54.44503402709961, 11270.0927734375, -1.273137092590332)
end)
tool:Button("太空水晶小行星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11.579089164733887, 15295.6318359375, -27.54974365234375)
end)
tool:Button("月球浆果岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-14.601255416870117, 18410.9609375, 0.9418511986732483)
end)
tool:Button("铺路石岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3.272758960723877, 22539.494140625, 63.283935546875)
end)
tool:Button("流星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-45.515689849853516, 27961.560546875, -7.358333110809326)
end)
tool:Button("升级岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2.7595248222351074, 33959.98828125, 53.93095397949219)
end)

tool:Button("火箭发射模拟器1",function()
loadstring(game:HttpGet("https://ayangwp.cn/api/v3/file/get/9245/%E7%8C%AB%E9%80%9A%E7%94%A8.txt?sign=hrWROZdVfK2mtJcIFa3Tvbl-TojP1C86_Zd3q03qttc%3D%3A0"))()
end)

tool:Button("火箭发射模拟器2",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/dizyhvh/rbx_scripts/main/321_blast_off_simulator')))()
end)

tool:Button("火箭发射模拟器3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/odhdshhe/jm-/refs/heads/main/jm%E7%81%AB%E7%AE%AD%E5%8F%91%E5%B0%84%E9%87%8D%E5%81%9A(1).lua"))()
end)

local creds = window:Tab("巴掌大作战",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("无CD","Toggle" ,false, function(Value)
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
    
    tool:Button("获取计数器手套", function()
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
    
    tool:Toggle("地牢亮度","Toggle" ,false, function(Value)
     Light = Value
        if not Light then
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end)
    
    tool:Dropdown("传送","Dropdown",{"安全区","竞技场","埃及岛","果实岛","盘子","锦标赛","默认竞技场"},function(Value)
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
    
    tool:Toggle("复古技能","Toggle" ,false, function(Value)
    RetroSpam = Value
    while RetroSpam do
    game:GetService("ReplicatedStorage").RetroAbility:FireServer(RetroAbility)
    task.wait()
    end
    end)
    
    tool:Dropdown("复古技能选择","Dropdown",{"Rocket Launcher","Ban Hammer","Bomb"}, function(Value)
    RetroAbility = Value
    end)
    
    tool:Toggle("自动捡糖果","Toggle",false, function(Value)
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
    
    tool:Toggle("获取炼金术师材料","Toggle", false, function(Value)
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
    
    tool:Toggle("自动加入竞技场","Toggle", false, function(Value)
    AutoEnterArena = Value
    while AutoEnterArena do
    if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
        end
    task.wait()
    end
    end)
    
    tool:Toggle("自动光波球","Toggle", false, function(Value)
    if Person == nil then
    Person = game.Players.LocalPlayer.Name
    end
    _G.RojoSpam = Value
    while _G.RojoSpam do
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players[Person].Character.HumanoidRootPart.CFrame})
    task.wait()
    end
    end)
    
    tool:Button("Rojo技能", function(Value)
    _G.RojoSpam = Value
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Charge")
    wait(6)
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame})
    task.wait()
    end)
    
    tool:Toggle("音符技能","Toggle", false, function(Value)
    _G.RhythmSpam = Value
    while _G.RhythmSpam do
    game:GetService("ReplicatedStorage").rhythmevent:FireServer("AoeExplosion",0)
    task.wait()
    end
    end)
    
    tool:Toggle("Null技能","Toggle", false, function(Value)
    NullSpam = Value
    while NullSpam do
    game:GetService("ReplicatedStorage").NullAbility:FireServer()
    task.wait()
    end
    end)
    
    tool:Toggle("自动拾取黄金果实","Toggle", false, function(Value)
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
    
    tool:Toggle("自动捡飞行宝珠","Toggle", false, function(Value)
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
    
    tool:Toggle("自动捡相位球","Toggle", false, function(Value)
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
    
    tool:Toggle("自动刷bob","Toggle", false, function(Value)
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
    
    tool:Toggle("无限反转","Toggle", false, function(Value)
    _G.InfReverse = Value
    while _G.InfReverse do
    game:GetService("ReplicatedStorage").ReverseAbility:FireServer()
    wait(6)
    end
    end)
    
    tool:Toggle("彩虹角色(装备黄金手套)","Toggle", false, function(Value)
    _G.Rainbow = Value
    while _G.Rainbow do
    for i = 0,1,0.001*25 do
    game:GetService("ReplicatedStorage").Goldify:FireServer(false, BrickColor.new(Color3.fromHSV(i,1,1)))
    task.wait()
    end
    end
    end)
    
    tool:Toggle("防击飞","Toggle", false, function(Value)
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
    
    tool:Toggle("反虚空(锦标赛也有效果)","Toggle", false, function(Value)
    game.Workspace.dedBarrier.CanCollide = Value
    game.Workspace.TAntiVoid.CanCollide = Value
    end)

tool:Toggle("防死亡屏障","Toggle", false, function(Value)
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
    
    tool:Toggle("反巴西","Toggle", false, function(Value)
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
    
    tool:Toggle("反死亡方块","Toggle", false, function(Value)
    if Value == true then
            workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = false
            else
                    workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = true
            end
    end)
    
    tool:Toggle("反上帝技能","Toggle", false, function(Value)
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
    
    tool:Toggle("反鱿鱼","Toggle", false, function(Value)
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
    
    tool:Toggle("反神圣杰克","Toggle", false, function(Value)
    game.Players.LocalPlayer.PlayerScripts.HallowJackAbilities.Disabled = Value
    end)
    
    tool:Toggle("反传送带","Toggle", false, function(Value)
    game.Players.LocalPlayer.PlayerScripts.ConveyorVictimized.Disabled = Value
    end)
    
    tool:Toggle("反板砖","Toggle", false, function(Value)
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
    
    tool:Toggle("反Null","Toggle", false, function(Value)
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
    
tool:Button("自动刷巴掌",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Slap%20Farm'))()
end)

tool:Button("巴掌模拟器1",function()
loadstring(game:HttpGet("https://lkhub.net/s/loader.lua"))()
end)

tool:Button("巴掌模拟器2",function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Slap%20Battles")))()
end)

tool:Button("巴掌模拟器3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dizyhvh/slap_battles_gui/main/0.lua"))()
end)

local creds = window:Tab("越狱",'6035145364')

local tool = creds:section("功能",true)

tool:Button("越狱破解版",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Introvert1337/Releases/master/JailbreakGrabber.lua"))()
end)

tool:Button("自动抢劫",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/wawsdasdacx/ohascriptnrrewading/main/jbsaxcriptidk1"))();
end)

local creds = window:Tab("国王遗产",'6035145364')

local tool = creds:section("功能",true)

tool:Button("国王遗产1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/sannin9000/scripts/main/kinglegacy.lua"))()
end)

tool:Button("国王遗产2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/master/legacy"))()
end)

tool:Button("国王遗产3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/hajibeza/RIPPER-HUB/main/King%20Leagacy"))()
end)

tool:Button("国王遗产4",function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/xDepressionx/Free-Script/main/KingLegacy.lua")()
end)

tool:Button("国王遗产5",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/xOne2/King-Legacy/main/README.md"))()
end)

local creds = window:Tab("餐厅大亨",'6035145364')

local tool = creds:section("功能",true)

tool:Button("餐厅大亨1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/toosiwhip/snake-hub/main/restaurant-tycoon-2.lua"))()
end)

tool:Button("餐厅大亨2",function()
loadstring(game:HttpGet("https://pastefy.app/Ppqt0Gib/raw"))()
end)

local creds = window:Tab("旗帜战争",'6035145364')

local tool = creds:section("功能",true)

tool:Button("旗帜战争1",function()
loadstring(game:HttpGet("https://pastefy.app/otEg6PJV/raw"))()
end)

tool:Button("旗帜战争2",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Infinity2346/Tect-Menu/main/Flag%20Wars.txt'))()
end)

local creds = window:Tab("驾驶帝国",'6035145364')

local tool = creds:section("功能",true)

tool:Button("驾驶帝国1",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/zeuise0002/SSSWWW222/main/README.md'),true))()
end)

tool:Button("驾驶帝国2",function()
loadstring(game:HttpGet("https://soggyhubv2.vercel.app"))()
end)

tool:Button("驾驶帝国3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/main/drivingempire", true))()
end)

tool:Button("驾驶帝国NEO",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/cool83birdcarfly02six/Lightux/main/README.md'),true))()
end)

local creds = window:Tab("战斗勇士",'6035145364')

local tool = creds:section("功能",true)

tool:Button("战斗勇士1",function()
loadstring(game:HttpGet("https://paste.gg/p/anonymous/697fc3cad5f743508318cb7399e89432/files/b5923e52edab4e5c91e46b74563d0ae8/raw"))()
end)

tool:Button("战斗勇士2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/frkfx/Combat-Warriors/main/Script"))()
end)

local creds = window:Tab("刀刃球",'6035145364')

local tool = creds:section("功能",true)

tool:Button("飞行",function()
loadstring(game:HttpGet("https://pastefy.app/J9x7RnEZ/raw"))()
end)

tool:Button("刀刃球自动格挡",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3ABlade%20Ball%20Parry%20V4.0.0",true))()
end)

tool:Button("刀刃球1",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Unknownkellymc1/Unknownscripts/main/slap-battles')))()
end)

tool:Button("刀刃球2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BladeBall/main/redz9999"))()
end)

tool:Button("刀刃球3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Neoncat765/Neon.C-Hub-X/main/UnknownVersion"))()
end)

local creds = window:Tab("短信模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Button("短信模拟器1",function()
loadstring(game:HttpGet(('https://pastebin.com/raw/9hxkxUZ5'),true))()
end)

local creds = window:Tab("彩虹朋友",'6035145364')

local tool = creds:section("功能",true)

-- 自动收集按钮
tool:Button("自动收集", function()
    local attempts = 0
    local character = game:GetService("Players").LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if not hrp then
        print("无法收集：角色或HumanoidRootPart不存在")
        return
    end
    
    for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
        if attempts >= 10 then break end
        
        if v:FindFirstChild("TouchTrigger") then
            attempts = attempts + 1
            firetouchinterest(hrp, v.TouchTrigger, 0)
            firetouchinterest(hrp, v.TouchTrigger, 1)
            wait(0.05) -- 添加微小延迟防止过快
        end
    end
    
    print("已尝试收集 " .. attempts .. " 个物品")
end)

-- 自动放置按钮
tool:Button("自动放置", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if not hrp then
        print("无法放置：角色或HumanoidRootPart不存在")
        return
    end
    
    local groupBuild = game:GetService("Workspace"):FindFirstChild("GroupBuildStructures")
    if not groupBuild then
        print("未找到 GroupBuildStructures")
        return
    end
    
    local trigger = groupBuild:FindFirstChild("Trigger", true)
    if not trigger then
        print("未找到 Trigger")
        return
    end
    
    firetouchinterest(trigger, hrp, 0)
    task.wait()
    firetouchinterest(trigger, hrp, 1)
    
    print("已尝试自动放置")
end)

-- 怪物透视
tool:Toggle("怪物透视", "", false, function(bool)
    getgenv().monsterESP = bool
    
    if bool then
        local monstersFolder = game:GetService("Workspace"):FindFirstChild("Monsters")
        if not monstersFolder then
            print("未找到 Monsters 文件夹")
            return
        end
        
        getgenv().monsterEvent = game:GetService("RunService").RenderStepped:Connect(function()
            for _, v in pairs(monstersFolder:GetChildren()) do
                if not v:FindFirstChild("Lol") then
                    local esp = Instance.new("Highlight", v)
                    esp.Name = "Lol"
                    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    esp.FillColor = Color3.new(0, 0, 255)  -- 蓝色
                    esp.OutlineColor = Color3.new(0, 0, 200)
                end
            end
        end)
        print("怪物透视已开启")
    else
        if getgenv().monsterEvent then
            getgenv().monsterEvent:Disconnect()
            getgenv().monsterEvent = nil
        end
        
        local monstersFolder = game:GetService("Workspace"):FindFirstChild("Monsters")
        if monstersFolder then
            for _, v in pairs(monstersFolder:GetChildren()) do
                local highlight = v:FindFirstChild("Lol")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
        print("怪物透视已关闭")
    end
end)

-- 物品透视
tool:Toggle("物品透视", "", false, function(bool)
    getgenv().itemESP = bool
    
    if bool then
        getgenv().itemEvent = game:GetService("RunService").RenderStepped:Connect(function()
            for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v:FindFirstChild("TouchTrigger") and not v:FindFirstChild("Lol") then
                    local esp = Instance.new("Highlight", v)
                    esp.Name = "Lol"
                    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    esp.FillColor = Color3.new(0, 255, 0)  -- 绿色
                    esp.OutlineColor = Color3.new(0, 200, 0)
                end
            end
        end)
        print("物品透视已开启")
    else
        if getgenv().itemEvent then
            getgenv().itemEvent:Disconnect()
            getgenv().itemEvent = nil
        end
        
        for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:FindFirstChild("TouchTrigger") then
                local highlight = v:FindFirstChild("Lol")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
        print("物品透视已关闭")
    end
end)

tool:Button("彩虹朋友1",function()
loadstring(game:HttpGet("https://pastefy.app/XoNv04vR/raw"))()
end)

tool:Button("彩虹朋友2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Rainbow-Friends/main/Rainbow%20Friends"))()
end)

local creds = window:Tab("开战宇宙",'6035145364')

local tool = creds:section("功能",true)

tool:Label("自动使用技能")

-- 技能名称文本框
tool:Textbox("技能名称", "", "请输入", function(text)
    if text and text ~= "" then
        getgenv().skillname = tostring(text)
        print("技能名称设置为: " .. getgenv().skillname)
        
        -- 尝试从GC中查找完整技能ID
        for i, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "ID") ~= nil then
                if type(v.ID) ~= "number" then
                    local test = string.split(v.ID, "#")
                    if test[1] == getgenv().skillname then
                        print("找到技能ID: " .. v.ID)
                        getgenv().skillname = v.ID
                        break
                    end
                end
            end
        end
    end
end)

-- 标签：攻击范围
tool:Label("攻击范围")

-- 范围数值文本框
tool:Textbox("范围数值", "", "请输入", function(text)
    if text and text ~= "" then
        getgenv().distance = tonumber(text) or 100
        print("攻击范围设置为: " .. getgenv().distance)
    end
end)

-- 自动使用所有能力
tool:Toggle("自动使用所有能力", "", false, function(state)
    getgenv().abilitiestouse = state
    
    spawn(function()
        while getgenv().abilitiestouse do
            wait(0.5)
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                local clientRunner = character and character:FindFirstChild("ClientRunner")
                if not clientRunner then return end
                
                local kaijuControl = clientRunner:FindFirstChild("KaijuControlEvent")
                if not kaijuControl then return end
                
                for i, v in pairs(getgc(true)) do
                    if type(v) == "table" and rawget(v, "globalCooldown") ~= nil then
                        task.wait(0.1)
                        for a, b in pairs(v) do
                            if a == "ID" then
                                kaijuControl:FireServer(b)
                                break
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

-- 自动使用所有攻击能力
tool:Toggle("自动使用所有攻击能力", "", false, function(state)
    getgenv().abilitiestouse2 = state
    
    spawn(function()
        while getgenv().abilitiestouse2 do
            wait(0.5)
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                local clientRunner = character and character:FindFirstChild("ClientRunner")
                if not clientRunner then return end
                
                local kaijuControl = clientRunner:FindFirstChild("KaijuControlEvent")
                if not kaijuControl then return end
                
                for i, v in pairs(getgc(true)) do
                    if type(v) == "table" and rawget(v, "globalCooldown") ~= nil and v.Cooldown and v.Cooldown < 6.1 then
                        wait(0.5)
                        kaijuControl:FireServer(v.ID)
                    end
                end
            end)
        end
    end)
end)

-- 自动传送
tool:Toggle("自动传送", "", false, function(state)
    getgenv().test = state
    
    spawn(function()
        while getgenv().test do
            wait()
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                local distance = math.huge
                local target = nil
                
                for i, v in pairs(game:GetService("Workspace").Map:GetDescendants()) do
                    if v.Name == "BoundingBox" and v.Parent:FindFirstChild("bValues") then
                        local bValues = v.Parent.bValues
                        if bValues:FindFirstChild("Health") and bValues:FindFirstChild("MaxHealth") then
                            if bValues.Health.Value > bValues.MaxHealth.Value / 2 then
                                local Dist = (hrp.Position - v.Position).magnitude
                                if Dist < (getgenv().distance or 100) and Dist < distance then
                                    distance = Dist
                                    target = v
                                end
                            end
                        end
                    end
                end
                
                if target then
                    repeat 
                        wait()
                        local location = target.Position
                        local LocalPlayer = game:GetService("Players").LocalPlayer
                        local PlayerModule = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
                        local ClickToMoveController = PlayerModule:GetClickToMoveController()
                        ClickToMoveController:SetShowPath(false)
                        ClickToMoveController:SetUserJumpEnabled(false)
                        ClickToMoveController:MoveTo(location, true)
                    until game.Players.LocalPlayer:DistanceFromCharacter(target.Position) < 60 or not getgenv().test
                    
                    local character = game.Players.LocalPlayer.Character
                    local clientRunner = character and character:FindFirstChild("ClientRunner")
                    if clientRunner and clientRunner:FindFirstChild("KaijuControlEvent") then
                        clientRunner.KaijuControlEvent:FireServer(getgenv().skillname or "")
                    end
                end
            end)
        end
    end)
end)

-- 自动重生
tool:Toggle("自动重生", "", false, function(state)
    getgenv().autospawn = state
    
    spawn(function()
        while getgenv().autospawn do
            wait()
            pcall(function()
                local playerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
                if not playerGui then return end
                
                local playingUI = playerGui:FindFirstChild("newUI")
                playingUI = playingUI and playingUI:FindFirstChild("PlayingUI")
                
                if playingUI and playingUI.Visible == false then
                    if getgenv().crack then
                        local kaijuService = game:GetService("ReplicatedStorage").Packages.Knit.Services:FindFirstChild("KaijuService")
                        if kaijuService and kaijuService:FindFirstChild("RF") then
                            local morph = kaijuService.RF:FindFirstChild("Morph")
                            if morph then
                                morph:InvokeServer(getgenv().crack, getgenv().crack1, nil, getgenv().crack3)
                                wait(5)
                                
                                -- 更新技能ID
                                for i, v in pairs(getgc(true)) do
                                    if type(v) == "table" and rawget(v, "ID") ~= nil and type(v.ID) ~= "number" then
                                        local test = string.split(v.ID, "#")
                                        local skillTest = string.split(getgenv().skillname or "", "#")
                                        if test[1] == skillTest[1] then
                                            getgenv().skillname = v.ID
                                            break
                                        end
                                    end
                                end
                                wait(10)
                            end
                        end
                    elseif getgenv().crack2 then
                        local test = math.random(1, 4)
                        local spawnLocations = game:GetService("ReplicatedStorage").ReplicatedAssets:FindFirstChild("SpawnLocations")
                        if spawnLocations then
                            for i, v in pairs(spawnLocations:GetChildren()) do
                                if i == test and game.Players.LocalPlayer.Character == nil then
                                    local kaijuService = game:GetService("ReplicatedStorage").Packages.Knit.Services:FindFirstChild("KaijuService")
                                    if kaijuService and kaijuService:FindFirstChild("RF") then
                                        local morph = kaijuService.RF:FindFirstChild("Morph")
                                        if morph then
                                            morph:InvokeServer(getgenv().crack2, v, nil, getgenv().crack3)
                                            wait(5)
                                            
                                            -- 更新技能ID
                                            for i, v in pairs(getgc(true)) do
                                                if type(v) == "table" and rawget(v, "ID") ~= nil and type(v.ID) ~= "number" then
                                                    local test = string.split(v.ID, "#")
                                                    local skillTest = string.split(getgenv().skillname or "", "#")
                                                    if test[1] == skillTest[1] then
                                                        getgenv().skillname = v.ID
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        wait(1)
                    end
                end
            end)
        end
    end)
end)

-- 自动隐藏用户
tool:Toggle("自动隐藏用户", "", false, function(state)
    getgenv().nametag = state
    
    spawn(function()
        while getgenv().nametag do
            wait()
            pcall(function()
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("Head") then
                    local nametag = character.Head:FindFirstChild("Nametag")
                    if nametag then
                        nametag:Destroy()
                    end
                end
            end)
        end
    end)
end)

-- Kill Yourself 按钮
tool:Button("Kill Yourself", function()
    local character = game.Players.LocalPlayer.Character
    if character then
        character:BreakJoints()
        print("已执行自杀")
    end
end)

-- 后台循环：获取角色名称
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().crack2 == nil then
                local character = game.Players.LocalPlayer.Character
                if character then
                    getgenv().crack2 = character.Name
                end
            end
        end)
    end
end)

local creds = window:Tab("柔术",'6035145364')

local tool = creds:section("功能",true)

-- 无限:红色逆转
tool:Button("无限:红色逆转", function()
    local skillRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("Skill")
    if skillRemote then
        local args = {[1] = "Infinity: Reversal Red"}
        skillRemote:FireServer(unpack(args))
        print("已触发无限:红色逆转")
    else
        print("未找到 Skill 远程事件")
    end
end)

-- 自动腿击
tool:Button("自动腿击", function()
    local m1Remote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("M1")
    if m1Remote then
        local mobs = workspace.Objects:FindFirstChild("Mobs")
        local king = mobs and mobs:FindFirstChild("King Of Curses")
        local humanoid = king and king:FindFirstChild("Humanoid")
        
        if humanoid then
            local args = {
                [1] = 1,
                [2] = {[1] = humanoid},
                [3] = 16
            }
            m1Remote:FireServer(unpack(args))
            print("已触发自动腿击")
        else
            print("未找到 King Of Curses 或 Humanoid")
        end
    else
        print("未找到 M1 远程事件")
    end
end)

-- 无限:蓝色失效
tool:Button("无限:蓝色失效", function()
    local skillRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("Skill")
    if skillRemote then
        local args = {[1] = "Infinity: Lapse Blue"}
        skillRemote:FireServer(unpack(args))
        print("已触发无限:蓝色失效")
    else
        print("未找到 Skill 远程事件")
    end
end)

-- 无限:空间打击
tool:Button("无限:空间打击", function()
    local skillRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("Skill")
    if skillRemote then
        local args = {[1] = "Infinity: Spatial Pummel"}
        skillRemote:FireServer(unpack(args))
        print("已触发无限:空间打击")
    else
        print("未找到 Skill 远程事件")
    end
end)

-- 无限:穆根
tool:Button("无限:穆根", function()
    local skillRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("Skill")
    if skillRemote then
        local args = {[1] = "Infinity: Mugen"}
        skillRemote:FireServer(unpack(args))
        print("已触发无限:穆根")
    else
        print("未找到 Skill 远程事件")
    end
end)

-- 无限:红色传说
tool:Button("无限:红色传说", function()
    local skillRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("Skill")
    if skillRemote then
        local args = {[1] = "Infinity: Red Transmission"}
        skillRemote:FireServer(unpack(args))
        print("已触发无限:红色传说")
    else
        print("未找到 Skill 远程事件")
    end
end)

-- 无限:空间紫色
tool:Button("无限:空间紫色", function()
    local skillRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("Skill")
    if skillRemote then
        local args = {[1] = "Infinity: Hollow Purple"}
        skillRemote:FireServer(unpack(args))
        print("已触发无限:空间紫色")
    else
        print("未找到 Skill 远程事件")
    end
end)

-- 空间:域扩展
tool:Button("空间:域扩展", function()
    local skillRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("Skill")
    if skillRemote then
        local args = {[1] = "Domain Expansion: Unlimited Void"}
        skillRemote:FireServer(unpack(args))
        print("已触发空间:域扩展")
    else
        print("未找到 Skill 远程事件")
    end
end)

-- 无限:重拳
tool:Button("无限:重拳", function()
    local m2Remote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("M2")
    if m2Remote then
        m2Remote:FireServer()
        print("已触发无限:重拳")
    else
        print("未找到 M2 远程事件")
    end
end)

-- 烛光甘蓝
tool:Button("烛光甘蓝", function()
    local replicateRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("ReplicateClientInfo")
    if replicateRemote then
        local args = {
            [1] = "CanDomain",
            [2] = true
        }
        replicateRemote:FireServer(unpack(args))
        print("已触发烛光甘蓝")
    else
        print("未找到 ReplicateClientInfo 远程事件")
    end
end)

-- 最大:六只眼睛
tool:Button("最大:六只眼睛", function()
    local skillRemote = game:GetService("ReplicatedStorage").Remotes.Server.Combat:FindFirstChild("Skill")
    if skillRemote then
        local args = {[1] = "Maximum: Six Eyes"}
        skillRemote:FireServer(unpack(args))
        print("已触发最大:六只眼睛")
    else
        print("未找到 Skill 远程事件")
    end
end)

-- 柔术遗产功能

-- 点我远程接受任务
tool:Button("点我远程接受任务", function()
    local questGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    local questFrame = questGui and questGui:FindFirstChild("QuestGui")
    questFrame = questFrame and questFrame:FindFirstChild("Frame")
    local kRemote = questFrame and questFrame:FindFirstChild("K")
    
    if kRemote then
        kRemote:FireServer()
        print("已远程接受任务")
    else
        print("未找到任务远程事件")
    end
end)

-- 自动开大
tool:Button("自动开大", function()
    local informationRemote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
    informationRemote = informationRemote and informationRemote:FindFirstChild("information")
    
    if informationRemote then
        local args = {
            [1] = "Combat",
            [2] = "UseZ"
        }
        informationRemote:FireServer(unpack(args))
        print("已触发自动开大")
    else
        print("未找到 information 远程事件")
    end
end)

-- 自动攻击
tool:Button("自动攻击", function()
    local character = game:GetService("Players").LocalPlayer.Character
    local combat = character and character:FindFirstChild("Combat")
    local remoteEvent = combat and combat:FindFirstChild("RemoteEvent")
    
    if remoteEvent then
        local args = {
            [1] = "Combat",
            [2] = "Combo"
        }
        remoteEvent:FireServer(unpack(args))
        print("已触发自动攻击")
    else
        print("未找到角色 Combat RemoteEvent")
    end
end)

-- 标签
tool:Label("以上功能都有bug，希望轻喷")

-- 传送到接收任务的地方
tool:Button("传送到接收任务的地方", function()
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        hrp.CFrame = CFrame.new(-4046.29931640625, 1190.1025390625, -4340.392578125)
        print("已传送到任务接收点")
    else
        print("无法传送：角色或HumanoidRootPart不存在")
    end
end)

-- 柔术神器功能

-- 无限快速冲刺
tool:Button("无限快速冲刺", function()
    local knit = game:GetService("ReplicatedStorage"):FindFirstChild("Knit")
    local services = knit and knit:FindFirstChild("Knit")
    services = services and services:FindFirstChild("Services")
    local gojoService = services and services:FindFirstChild("GojoService")
    local re = gojoService and gojoService:FindFirstChild("RE")
    local chase = re and re:FindFirstChild("Chase")
    
    if chase then
        chase:FireServer()
        print("已触发无限快速冲刺")
    else
        print("未找到 Chase 远程事件")
    end
end)

-- 无限逆转红色
tool:Button("无限逆转红色", function()
    local knit = game:GetService("ReplicatedStorage"):FindFirstChild("Knit")
    local services = knit and knit:FindFirstChild("Knit")
    services = services and services:FindFirstChild("Services")
    local reversalService = services and services:FindFirstChild("ReversalRedService")
    local re = reversalService and reversalService:FindFirstChild("RE")
    local activated = re and re:FindFirstChild("Activated")
    
    if activated then
        local args = {[1] = false}
        activated:FireServer(unpack(args))
        print("已触发无限逆转红色")
    else
        print("未找到 Activated 远程事件")
    end
end)

-- 无限双倍踢球
tool:Button("无限双倍踢球", function()
    local knit = game:GetService("ReplicatedStorage"):FindFirstChild("Knit")
    local services = knit and knit:FindFirstChild("Knit")
    services = services and services:FindFirstChild("Services")
    local kickService = services and services:FindFirstChild("TwofoldKickService")
    local re = kickService and kickService:FindFirstChild("RE")
    local activated = re and re:FindFirstChild("Activated")
    
    if activated then
        local args = {[1] = false}
        activated:FireServer(unpack(args))
        print("已触发无限双倍踢球")
    else
        print("未找到 Activated 远程事件")
    end
end)

-- 无限自动攻击
tool:Button("无限自动攻击", function()
    local knit = game:GetService("ReplicatedStorage"):FindFirstChild("Knit")
    local services = knit and knit:FindFirstChild("Knit")
    services = services and services:FindFirstChild("Services")
    local gojoService = services and services:FindFirstChild("GojoService")
    local re = gojoService and gojoService:FindFirstChild("RE")
    local activated = re and re:FindFirstChild("Activated")
    
    if activated then
        local args = {[1] = false}
        activated:FireServer(unpack(args))
        print("已触发无限自动攻击")
    else
        print("未找到 Activated 远程事件")
    end
end)

-- 自动防御
tool:Button("自动防御", function()
    local knit = game:GetService("ReplicatedStorage"):FindFirstChild("Knit")
    local services = knit and knit:FindFirstChild("Knit")
    services = services and services:FindFirstChild("Services")
    local blockService = services and services:FindFirstChild("BlockService")
    local re = blockService and blockService:FindFirstChild("RE")
    local deactivated = re and re:FindFirstChild("Deactivated")
    
    if deactivated then
        deactivated:FireServer()
        print("已触发自动防御")
    else
        print("未找到 Deactivated 远程事件")
    end
end)

-- 无限拉普斯蓝色
tool:Button("无限拉普斯蓝色", function()
    local knit = game:GetService("ReplicatedStorage"):FindFirstChild("Knit")
    local services = knit and knit:FindFirstChild("Knit")
    services = services and services:FindFirstChild("Services")
    local lapseService = services and services:FindFirstChild("LapseBlueService")
    local re = lapseService and lapseService:FindFirstChild("RE")
    local activated = re and re:FindFirstChild("Activated")
    
    if activated then
        activated:FireServer()
        print("已触发无限拉普斯蓝色")
    else
        print("未找到 Activated 远程事件")
    end
end)

local creds = window:Tab("BF",'6035145364')

local tool = creds:section("功能",true)

tool:Button("BF 汉化",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/Xiao-Yun-UWU/main/%E6%B5%B7%E8%B4%BC%E7%8E%8Bbf.lua", true))()
end)

tool:Button("最强",function()
_G.HohoVersion = "v4"
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
end)

tool:Button("最强",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AkiraNus/UniquehubKak/main/FreeCr.Xenonhub"))()
end)

tool:Button("刷怪",function()
loadstring(game:HttpGet('https://rawscripts.net/raw/UPDATE-16-Blox-Fruits-Nub-V1-Hub-4583'))()
end)

tool:Button("自动升级",function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/xDepressionx/Free-Script/main/AllScript.lua")()
end)

tool:Button("自动箱子",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"))()
end)

tool:Button("找的",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/RobloxScriptsExploit/Blox-Fruits/main/Ripper%20M"))()
end)

tool:Button("超强",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Augustzyzx/UraniumMobile/main/UraniumKak.lua"))()
end)

tool:Button("HOHO脚本1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/Free/BloxFruitFreeV3.lua"))()
end)

tool:Button("HOHO脚本2",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()
end)

local creds = window:Tab("克隆大亨",'6035145364')

local tool = creds:section("功能",true)

tool:Button("克隆大亨1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/HELLLO1073/RobloxStuff/main/CT-Destroyer"))()
end)

local creds = window:Tab("铲雪",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("自动收集雪","", false, function(Value)
        toggle = Value
    while toggle do wait()
    local args = {
        [1] = workspace:WaitForChild("HitParts"):WaitForChild("Snow1"),
        [2] = "Snow1",
        [3] = "MagicWand"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("e8eGb8RgRXFcug8q"):FireServer(unpack(args))
        end
    end)

    tool:Toggle("自动出售雪（要传送到指定地方）",   "",false, function(Value)
    toggle = Value
    while toggle do wait()
    local args = {
        [1] = "SellSnow",
        [2] = "Frosty"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        end
    end)

tool:Button("传送出售雪的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(481.4659423828125, 15.846257209777832, -66.55204010009766)
    end)

tool:Button("传送买车的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(90.10160064697266, 16.051794052124023, -141.703125)
    end)

tool:Button("传送买工具的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(131.7429962158203, 16.39700698852539, -12.935890197753906)
    end)

tool:Button("传送买背包的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(348.6633605957031, 17.03822898864746, -16.793842315673828)
    end)

tool:Button("传送买假日礼物的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(154.57424926757812, 16.215335845947266, 147.10423278808594)
    end)

tool:Button("传送买宠物的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(138.49563598632812, 17.887277603149414, 278.3686218261719)
    end)

tool:Button("传送超大铲雪的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-391.4309997558594, 15.84949016571045, 150.15187072753906)
    end)

local creds = window:Tab("其他脚本",'6035145364')

local tool = creds:section("功能",true)

tool:Button("皮脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

tool:Button("叶脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))()
end)

tool:Button("混脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Twbtx/tiamxiabuwu/main/txbw666"))()
end)

tool:Button("XK脚本中心",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BINjiaobzx6/BINjiao/main/XK.TXT"))()
end)

tool:Button("傻逼空云脚本（傻逼脚本还要白名单）",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoSB33/M416/refs/heads/main/Wind/sb/空云脚本V3.LUA",true))()
end)

tool:Button("沙脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/114514lzkill/ShaHUB/refs/heads/main/ShaHUB.lua"))()
end)

tool:Button("江脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoSB33/M416/refs/heads/main/%E6%B1%9FtdNB%2FV3.LUA"))()
end)

tool:Button("复制江卡密",function()
    setclipboard("江ScriptNB")
    print("卡密已复制到剪贴板: 江ScriptNB")
end)

tool:Button("BS脚本",function()
    loadstring(game:HttpGet("https://gitlab.com/ajduoxcz/bs-center-of-the-black-hole/-/raw/main/BS%20Center%20of%20the%20black%20hole"))()
end)

tool:Button("剑客v7",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zer0neK/Hello/refs/heads/main/SG-V7"))()
end)

tool:Button("殺脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/FengYu/refs/heads/Feng/QQ1926190957"))()
end)

tool:Button("傻逼暗红脚本V3",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wdwvwfw/wos/refs/heads/main/%E6%B5%8B%E8%AF%95%E5%8D%B7.lua"))()
end)

local fps = fps:section("fps ping",true)

fps:Button("ping",function()
            repeat wait() until game:IsLoaded() wait(2)
local ScreenGui = Instance.new("ScreenGui")
local Ping = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Ping.Name = "Ping"
Ping.Parent = ScreenGui
Ping.BackgroundColor3 = Color3.fromRGB(245,245,245)
Ping.BackgroundTransparency = 1.000
Ping.BorderColor3 = Color3.fromRGB(0, 0, 128)
Ping.Position = UDim2.new(0.700000048, 0, 0, 0)
Ping.Size = UDim2.new(0, 125, 0, 25)
Ping.Font = Enum.Font.SourceSans
Ping.TextColor3 = Color3.fromRGB(245,245,245)
Ping.TextScaled = true
Ping.TextSize = 14.000
Ping.TextWrapped = true

local script = Instance.new('LocalScript', Ping)
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function(ping) 
script.Parent.Text = ("Ping: " ..game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(math.round(2/ping))) -- your ping
end)
end)

bin:Button("fps",function()
        repeat wait() until game:IsLoaded() wait(2)
local ScreenGui = Instance.new("ScreenGui")
local Fps = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Fps.Name = "Fps"
Fps.Parent = ScreenGui
Fps.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
Fps.BackgroundTransparency = 1.000
Fps.Position = UDim2.new(0.786138654, 0, 0, 0)
Fps.Size = UDim2.new(0, 125, 0, 25)
Fps.Font = Enum.Font.SourceSans
Fps.TextColor3 = Color3.fromRGB(245,245,245)
Fps.TextScaled = true
Fps.TextSize = 14.000
Fps.TextWrapped = true

local script = Instance.new('LocalScript', Fps)
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function(frame)
script.Parent.Text = ("FPS: "..math.round(1/frame)) 
end)
end)

local creds = window:Tab("afk",'6035145364')

local tool = creds:section("afk",true)

credits:Toggle("afk", "", false, function(state)
        print("Anti Afk On")
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
end)