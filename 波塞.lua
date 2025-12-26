local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/482c4a125a8b0e0c83228fa2eb958f1d702afb53/%E6%B3%A2%E5%A1%9E%E5%86%ACui.lua"))()

local Window = WindUI:CreateWindow({
    Title = "<font color='#00FFFF'>波塞冬中心</font><font color='#FF3366'>海神</font>",
    Icon = "rbxassetid://83943559238385",
    IconTransparency = 0.5,
    IconThemed = true,
    Author = "作者:波塞冬",
    Folder = "BSD Hub",
    Size = UDim2.fromOffset(600, 300),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("用户信息") end,
        Anonymous = false
    },
    Background = "rbxassetid://108996289991605"
})
Window:Tag({
    Title = "QQ;1693323219",
    Color = Color3.fromHex("#87CEEB")
})

Window:Tag({
    Title = "梦之泪伤",
    Color = Color3.fromHex("#315dff")
})

local TimeTag = Window:Tag({
    Title = "作者波塞冬 ",
    Color = Color3.fromHex("#87CEEB")
})

WindUI:Notify({
    Title = "<font color='#FF6B9D'>梦之泪伤帅气的脸庞</font>",
    Content = "<font color='#4ECDC4'>梦之泪伤峡谷里面称王</font>",
    Duration = 10,
    Icon = "bird",
})

local Tab = Window:Tab({
    Title = "公告",
    Icon = "layout-grid",
    Locked = false,
})

local Paragraph = Tab:Paragraph({
    Title = "欢迎使用",
    Desc = "QQ 1693323219",
    Image = "rbxassetid://83943559238385",
    ImageSize = 42,
    Thumbnail = "rbxassetid://72368339506794",
    ThumbnailSize = 120,
})

local Paragraph = Tab:Paragraph({
    Title = "欢迎使用",
    Desc = "QQ 1693323219",    
    Thumbnail = "rbxassetid://72368339506794",
    ThumbnailSize = 0,
})

local Tabs = {
    Main = Window:Section({ Title = "脚本", Opened = true }),
    Settings = Window:Section({ Title = "作者:波塞冬", Opened = true }),
    Utilities = Window:Section({ Title = "QQ1693323219", Opened = true })
}

local Tab1 = Tabs.Main:Tab({
    Title = "通用",
    Icon = "layout-grid",
    Locked = false,
})


local Toggle1 = Tab1:Toggle({
    Title = "快跑开关",
    Desc = "开关",
    Locked = false,
    Default = false,
    Callback = function(v)
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
    end
})

local Slider1 = Tab1:Slider({
    Title = "快速跑步『推荐调2』",
    Value = {
        Min = 1,
        Max = 10,
        Default = 1,
    },
    Increment = 0.1,
    Callback = function(king)
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
    end
})

local Slider2 = Tab1:Slider({
    Title = "范围",
    Value = {
        Min = 1,
        Max = 50,
        Default = 0.0001,
    },
    Increment = 1,
    Callback = function(v)
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
    end
})

local Slider3 = Tab:Slider({
    Title = "缩放距离!",
    Value = {
        Min = 128,
        Max = 200000,
        Default = 70,
    },
    Increment = 10,
    Callback = function(value)
        game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = value
    end
})

local Slider4 = Tab:Slider({
    Title = "缩放焦距(正常70)!",
    Value = {
        Min = 0.1,
        Max = 250,
        Default = 70,
    },
    Increment = 0.1,
    Callback = function(v)
        game.Workspace.CurrentCamera.FieldOfView = v
    end
})

local Slider5 = Tab:Slider({
    Title = "相机焦距上限",
    Value = {
        Min = 128,
        Max = 200000,
        Default = 2,
    },
    Increment = 10,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
    end
})

local Slider6 = Tab:Slider({
    Title = "相机焦距【正常为70】",
    Value = {
        Min = 0.1,
        Max = 250,
        Default = 70,
    },
    Increment = 0.1,
    Callback = function(v)
        game.Workspace.CurrentCamera.FieldOfView = v
    end
})

local Slider7 = Tab:Slider({
    Title = "设置重力",
    Value = {
        Min = 1,
        Max = 500,
        Default = 0,
    },
    Increment = 1,
    Callback = function(gravity)
        spawn(function()
            while task.wait() do
                local workspace = game.Workspace
                workspace.Gravity = tonumber(gravity) or workspace.Gravity
            end
        end)
    end
})
local Toggle = Tab:Toggle({
    Title = "靠近自动攻击(需要拿起武器)",
    Desc = "AutoAttack",
    Locked = false,
    Default = false,
    Callback = function(enabled)
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
    end
})

local Toggle = Tab:Toggle({
    Title = "自动互动",
    Desc = "AutoInteract",
    Locked = false,
    Default = false,
    Callback = function(enabled)
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
    end
})

local Button = Tab:Button({
    Title = "快速互动",
    Desc = "",
    Locked = false,
    Callback = function()
        game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            prompt.HoldDuration = 0
        end)
    end
})

local Toggle = Tab:Toggle({
    Title = "人物不可见状态(隐身)",
    Desc = "Invisible Character",
    Locked = false,
    Default = false,
    Callback = function(enabled)
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
    end
})

local Toggle = Tab:Toggle({
    Title = "防甩飞",
    Desc = "AntiFlingToggle",
    Locked = false,
    Default = false,
    Callback = function(Value)
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
    end
})

local Button = Tab:Button({
    Title = "防甩飞(外部)",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ChinaQY/Scripts/Main/AntiFling.lua"))()
    end
})

local Toggle = Tab1:Toggle({
    Title = "获取所有玩家背包",
    Desc = "GetBackPack",
    Locked = false,
    Default = false,
    Callback = function(enabled)
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
    end
})

local Button = Tab1:Button({
    Title = "吸人(无法关闭)",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/fF3DMBNF/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "人物螺旋上天",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/xV1T3PAi/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "无限R币",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/SxhPVOyM/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "聊天气泡美化",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/lCEPuiQO/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "获取当前道具",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/3FU05Dyt/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "给别人撞飞",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_5wpM7bBcOPspmX7lQ3m75SrYNWqxZ858ai3tJdEAId6jSI05IOUB224FQ0VSAswH.lua.txt'),true))()
    end
})

local Button = Tab1:Button({
    Title = "删除动画包『可永生』",
    Desc = "",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab1:Button({
    Title = "装备全部道具",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/uBqVR9JC/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "删除道具",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/r4LHK4p0/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "删除所有道具",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/8HB71Lbj/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "复活在原地『无法关闭』",
    Desc = "",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab1:Button({
    Title = "锁定视角",
    Desc = "",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab1:Button({
    Title = "踢人脚本(仅娱乐)",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet([[https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/c8320f69b6aa4f5d.txt_2024-08-08_214628.OTed.lua]]))()
    end
})

local Button = Tab1:Button({
    Title = "动画中心",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet([[https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui]], true))()
    end
})

local Button = Tab1:Button({
    Title = "身体瘫痪",
    Desc = "",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab1:Button({
    Title = "无头断腿r15",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Permanent-Headless-And-korblox-Script-4140"))()      
    end
})

local Button = Tab1:Button({
    Title = "无头断腿r6",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/FIXED-Brainrot-Jumping-korblox-R6-a-headless-54182"))()
    end
})

local Button = Tab1:Button({
    Title = "爬墙",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
    end
})

local Button = Tab1:Button({
    Title = "替身",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet([[https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain]]))()
    end
})

local Button = Tab1:Button({
    Title = "聊天气泡美化",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/lCEPuiQO/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "人物绘制",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/pmgp7mdm"))()
    end
})

local Toggle = Tab1:Toggle({
    Title = "人物显示",
    Desc = "RWXS",
    Locked = false,
    Default = false,
    Callback = function(enabled)
        getgenv().enabled = enabled
        getgenv().filluseteamcolor = true
        getgenv().outlineuseteamcolor = true
        getgenv().fillcolor = Color3.new(1, 0, 0)
        getgenv().outlinecolor = Color3.new(1, 1, 1)
        getgenv().filltrans = 0.5
        getgenv().outlinetrans = 0.5
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/Highlight-ESP.lua"))()
    end
})

local Button = Tab1:Button({
    Title = "无后坐快速射击",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/Vbnh3Ycg/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "无限子弹",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/bYg3smqm/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "弹人(实体)",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/4r9e4F3p/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "弹人(半实体)",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/UTWcDtzj"))()
    end
})

local Button = Tab1:Button({
    Title = "获得管理员权限",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
    end
})

local Button = Tab1:Button({
    Title = "重新加入游戏",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/XXabqNiv/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "显示FPS",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/g54KFcUU"))()
    end
})

local Button = Tab1:Button({
    Title = "显示时间",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/RycMWV3a"))()
    end
})

local Button = Tab1:Button({
    Title = "保存游戏",
    Desc = "",
    Locked = false,
    Callback = function()
        saveinstance()
    end
})

local Button = Tab1:Button({
    Title = "离开游戏",
    Desc = "",
    Locked = false,
    Callback = function()
        game:Shutdown()
    end
})

local Button = Tab1:Button({
    Title = "玩家加入与退出提示",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/KexNS25n/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "死亡笔记",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
    end
})

local Button = Tab1:Button({
    Title = "飞行",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/jm%E9%A3%9E..lua"))()
    end
})

local Button = Tab1:Button({
    Title = "进入弹窗",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
    end
})

local Button = Tab1:Button({
    Title = "子弹追踪",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/1AJ69eRG"))()          
    end
})

local Button = Tab1:Button({
    Title = "管理员面板",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ExploiterGuy/Aqua-Hub/refs/heads/main/Turn%20People%20Into%20Things.txt"))()           
    end
})

local Button = Tab1:Button({
    Title = "表情菜单",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://yarhm.goteamst.com/scr?channel=afem"))()         
    end
})

local Button = Tab1:Button({
    Title = "音乐播放器",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Maan04ka/CodingScripts/main/MusicUI.lua"))()
    end
})

local Button = Tab1:Button({
    Title = "蓝屏脚本（娱乐）",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-XIAOYE666.lua"))()         
    end
})

local Button = Tab1:Button({
    Title = "甩飞",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
    end
})

local Button = Tab1:Button({
    Title = "点击传送",
    Desc = "",
    Locked = false,
    Callback = function()
        mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "点击传送的位置" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack
    end
})

local Button = Tab1:Button({
    Title = "键盘脚本",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()   
    end
})

local Button = Tab1:Button({
    Title = "踏空行走",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
    end
})

local Button = Tab1:Button({
    Title = "动态模糊",
    Desc = "",
    Locked = false,
    Callback = function()
        local camera = workspace.CurrentCamera
        local blurAmount = 10
        local blurAmplifier = 5
        local lastVector = camera.CFrame.LookVector

        local motionBlur = Instance.new("BlurEffect", camera)

        local runService = game:GetService("RunService")

        workspace.Changed:Connect(function(property)
            if property == "CurrentCamera" then
                print("Changed")
                local camera = workspace.CurrentCamera
                if motionBlur and motionBlur.Parent then
                    motionBlur.Parent = camera
                else
                    motionBlur = Instance.new("BlurEffect", camera)
                end
            end
        end)

        runService.Heartbeat:Connect(function()
            if not motionBlur or motionBlur.Parent == nil then
                motionBlur = Instance.new("BlurEffect", camera)
            end
            
            local magnitude = (camera.CFrame.LookVector - lastVector).magnitude
            motionBlur.Size = math.abs(magnitude)*blurAmount*blurAmplifier/2
            lastVector = camera.CFrame.LookVector
        end)
    end
})

local Button = Tab1:Button({
    Title = "自杀脚本",
    Desc = "",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health=0
        HumanDied = true
    end
})

local Button = Tab1:Button({
    Title = "指令脚本",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
    end
})

local Button = Tab1:Button({
    Title = "高亮脚本",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/4LDKiJ5a"))()
    end
})

local Button = Tab1:Button({
    Title = "动作脚本",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Zj4NnKs6"))()
    end
})

local Button = Tab1:Button({
    Title = "防止挂机",
    Desc = "",
    Locked = false,
    Callback = function()
        wait(2)
        print("Anti Afk On")
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
        local CoreGui = game:GetService("StarterGui")
        CoreGui:SetCore("SendNotification", {
            Title = "辰提示10秒",
            Text = "防挂机已开启",
            Duration = 10,
        })
    end
})

local Button = Tab1:Button({
    Title = "凌晨12点",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/xFX51PIw/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "下午4点",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/sIrAGJxJ/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "中午11点",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/rccCMBch/raw"))()
    end
})

local Button = Tab1:Button({
    Title = "早上6点",
    Desc = "",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/h9VLRgYR/raw"))()
    end
})

Window:SelectTab(2)

local Tab2 = Tabs.Main:Tab({
    Title = "透视",
    Icon = "layout-grid",
    Locked = false,
})


local Button = Tab2:Button({
    Title = "关闭所有透视",
    Desc = "",
    Locked = false,
    Callback = function()
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
                    if child:IsA("BillboardGui") and (string.find(child.Name, "ESP") or string.find(child.Name, "HealthBar") or string.find(child.Name, "Distance")) then
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
                    if child:IsA("BillboardGui") and (string.find(child.Name, "NPCESP") or string.find(child.Name, "NPCHighlight") or string.find(child.Name, "ToolESP")) then
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
    end
})

local Toggle = Tab2:Toggle({
    Title = "方框透视",
    Desc = "BoxESP",
    Locked = false,
    Default = false,
    Callback = function(Value)
        ESPData.BoxESP = Value
        if not ESPConnection and (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
            StartESP()
        elseif ESPConnection and not (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
            StopESP()
        end
    end
})

local Toggle = Tab2:Toggle({
    Title = "骨骼透视",
    Desc = "SkeletonESP",
    Locked = false,
    Default = false,
    Callback = function(Value)
        ESPData.SkeletonESP = Value
        if not ESPConnection and (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
            StartESP()
        elseif ESPConnection and not (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
            StopESP()
        end
    end
})

local Toggle = Tab2:Toggle({
    Title = "名称透视",
    Desc = "NameESP",
    Locked = false,
    Default = false,
    Callback = function(Value)
        ESPData.NameESP = Value
        if not ESPConnection and (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
            StartESP()
        elseif ESPConnection and not (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
            StopESP()
        end
    end
})

local Toggle = Tab2:Toggle({
    Title = "透视线条",
    Desc = "TracerESP",
    Locked = false,
    Default = false,
    Callback = function(Value)
        ESPData.TracerESP = Value
        if not ESPConnection and (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
            StartESP()
        elseif ESPConnection and not (ESPData.BoxESP or ESPData.SkeletonESP or ESPData.NameESP or ESPData.TracerESP) then
            StopESP()
        end
    end
})

local Toggle = Tab2:Toggle({
    Title = "距离显示",
    Desc = "DistanceDisplay",
    Locked = false,
    Default = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local DistanceTab2le = {}

        local function CreateDistanceDisplay(player)
            if DistanceTable[player] then return end
            
            local character = player.Character
            if not character then return end
            
            local head = character:FindFirstChild("Head")
            if not head then return end
            
            local billboard = Instance.new("BillboardGui")
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
    end
})

local Toggle = Tab2:Toggle({
    Title = "透视手中物品",
    Desc = "ToolESP",
    Locked = false,
    Default = false,
    Callback = function(Value)
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
            
            local billboard = Instance.new("BillboardGui")
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
                        if child:IsA("BillboardGui") and string.find(child.Name, "ToolESP_") then
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
    end
})

local Toggle = Tab2:Toggle({
    Title = "透视所有玩家",
    Desc = "PlayerESP",
    Locked = false,
    Default = false,
    Callback = function(value)
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
    end
})

local Toggle = Tab2:Toggle({
    Title = "血量条显示",
    Desc = "HealthBarESP",
    Locked = false,
    Default = false,
    Callback = function(Value)
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
            
            local billboard = Instance.new("BillboardGui")
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
    end
})

local Tab3 = Tabs.Main:Tab({
    Title = "头部饰品美化",
    Icon = "layout-grid",
    Locked = false,
})

local Button = Tab3:Button({
    Title = "婆婆猫头部",
    Desc = "ppmt",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab3:Button({
    Title = "小黑子头部",
    Desc = "xhzt",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab3:Button({
    Title = "灰太狼头部",
    Desc = "htlt",
    Locked = false,
    Callback = function()
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
    end
})

local Tab4 = Tabs.Main:Tab({
    Title = "经典衬衫裤子美化",
    Icon = "layout-grid",
    Locked = false,
})

local Button = Tab4:Button({
    Title = "所有人变成婆婆猫显示身份",
    Desc = "sfdbckqs",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")

        local HEAD_MESH_ID = 'rbxassetid://6352154013'
        local HEAD_TEXTURE_ID = 'rbxassetid://6352158611'
        local SHIRT_ID = 'http://www.roblox.com/asset/?id=9549066694'
        local PANTS_ID = 'http://www.roblox.com/asset/?id=9549083449'
        local plr = game.Players.LocalPlayer

        local function createBillboardGui(player, character)
            if not character:FindFirstChild("Head") then return end
            
            local existingGui = character.Head:FindFirstChild("NameDisplay")
            if existingGui then existingGui:Destroy() end
            
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "NameDisplay"
            billboardGui.AlwaysOnTop = true
            billboardGui.Size = UDim2.new(0, 200, 0, 50)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.Adornee = character.Head
            billboardGui.Parent = character.Head
            
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
            
            textLabel.Parent = billboardGui
            
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
            
            createBillboardGui(player, character)
            
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
                            Table.insert(hats2,v:Clone())
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
                createBillboardGui(player, newCharacter)
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
    end
})

local Button = Tab4:Button({
    Title = "所有人变成婆婆猫",
    Desc = "sfdbck",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab4:Button({
    Title = "婆婆猫衬衫裤子",
    Desc = "ppmcskz",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab4:Button({
    Title = "灰太狼衬衫裤子",
    Desc = "htlcskz",
    Locked = false,
    Callback = function()
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
    end
})

local Button = Tab4:Button({
    Title = "巡查衣加小红裤",
    Desc = "xcyjxhxk",
    Locked = false,
    Callback = function()
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
    end
})

local Tab5 = Tabs.Main:Tab({
    Title = "恶魔学",
    Icon = "layout-grid",
    Locked = false,
})

local Button = Tab5:Button({
    Title = "获取鬼魂信息",
    Desc = "",
    Locked = false,
    Callback = function()
        local info = {}
        info.gender = workspace:WaitForChild("Ghost"):GetAttribute("Gender")
        info.age = workspace:WaitForChild("Ghost"):GetAttribute("Age")
        info.favroom = workspace:WaitForChild("Ghost"):GetAttribute("FavouriteRoom")
        
        if stuff.sayInchat then
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("AskSpiritBoxFromUI"):FireServer(
                "鬼魂是一个"..string.lower(info.gender)..", 年龄 "..info.age.." 它最喜欢的房间是 "..string.lower(info.favroom)
            )
        else
            WindUI:Notify({
                Title = "鬼魂信息",
                Content = info.gender.." | 年龄 "..info.age.."\n鬼魂房间 | "..info.favroom,
                Duration = 5
            })
        end
    end
})

local Button = Tab5:Button({
    Title = "获取鬼魂当前房间",
    Desc = "",
    Locked = false,
    Callback = function()
        local crntroom = workspace:WaitForChild("Ghost"):GetAttribute("CurrentRoom")
        
        if stuff.sayInchat then
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("AskSpiritBoxFromUI"):FireServer(
                "鬼魂在"..string.lower(crntroom)
            )
        else
            WindUI:Notify({
                Title = "鬼魂信息",
                Content = crntroom,
                Duration = 5
            })
        end
    end
})

local Toggle = Tab5:Toggle({
    Title = "在聊天中显示鬼魂信息",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        stuff.sayInchat = Value
    end
})

local Toggle = Tab5:Toggle({
    Title = "鬼魂接近通知(仅在狩猎时有效)",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        stuff.ghostSeePlayerEnabled = Value
        
        task.spawn(function()
            while stuff.ghostSeePlayerEnabled do
                task.wait(1)
                local distanceGhost = (workspace:WaitForChild("Ghost"):WaitForChild("HumanoidRootPart").Position - 
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

                if distanceGhost <= stuff.ghostSeePlayerDistance and distanceGhost >= 5 and 
                    workspace:WaitForChild("Ghost"):GetAttribute("Hunting") then
                    
                    WindUI:Notify({
                        Title = "鬼魂警告",
                        Content = "鬼魂距离你"..tostring(math.floor(distanceGhost)).."单位",
                        Duration = 3.5
                    })
                end
            end
        end)
    end
})

local Toggle = Tab5:Toggle({
    Title = "鬼魂狩猎事件通知",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        if Value then
            stuff.warningHunt = workspace:WaitForChild("Ghost"):GetAttributeChangedSignal("Hunting"):Connect(function()
                if workspace:WaitForChild("Ghost"):GetAttribute("Hunting") == true then
                    WindUI:Notify({
                        Title = "狩猎警告",
                        Content = "鬼魂开始狩猎!",
                        Duration = 5
                    })
                else
                    WindUI:Notify({
                        Title = "狩猎警告",
                        Content = "鬼魂结束狩猎!",
                        Duration = 5
                    })
                end
            end)
        elseif stuff.warningHunt then
            stuff.warningHunt:Disconnect()
            stuff.warningHunt = nil
        end
    end
})

local Button = Tab5:Button({
    Title = "触发所有盐堆",
    Desc = "",
    Locked = false,
    Callback = function()
        local SaltPiles = workspace.SaltPiles:GetChildren()
        local NormalPiles = {}
        
        for _, d in pairs(SaltPiles) do
            if d.Name == "SaltLine" then
                Table.insert(NormalPiles, d)
            end
        end

        if #NormalPiles > 0 then
            for _, d in pairs(NormalPiles) do
                task.spawn(function()
                    firetouchinterest(workspace.Ghost.Torso, d:WaitForChild("GhostTracker"), 0)
                    firetouchinterest(workspace.Ghost.Torso, d:WaitForChild("GhostTracker"), 1)
                end)
            end
        else
            WindUI:Notify({
                Title = "盐堆触发",
                Content = "没有盐堆!",
                Duration = 3.5
            })
        end
    end
})

local Button = Tab5:Button({
    Title = "检查是否为无头骑士",
    Desc = "",
    Locked = false,
    Callback = function()
        local isHeadless = workspace:WaitForChild("Ghost"):GetAttribute("Headless")
        
        WindUI:Notify({
            Title = "无头骑士检查",
            Content = isHeadless and "鬼魂是无头骑士!" or "鬼魂不是无头骑士",
            Duration = 3.5
        })
    end
})

local Button = Tab5:Button({
    Title = "检查鬼魂球体",
    Desc = "",
    Locked = false,
    Callback = function()
        WindUI:Notify({
            Title = "鬼魂球体检查",
            Content = workspace:FindFirstChild("GhostOrb") and "有鬼魂球体" or "没有鬼魂球体",
            Duration = 3.5
        })
    end
})

local Button = Tab5:Button({
    Title = "检查手印",
    Desc = "",
    Locked = false,
    Callback = function()
        WindUI:Notify({
            Title = "手印检查",
            Content = #workspace.Handprints:GetChildren() > 0 and "有手印" or "没有手印",
            Duration = 3.5
        })
    end
})

local Button = Tab5:Button({
    Title = "检查激光可见性",
    Desc = "",
    Locked = false,
    Callback = function()
        local ghostLaserVisible = workspace:WaitForChild("Ghost"):GetAttribute("LaserVisible") and 
            workspace:WaitForChild("Ghost"):GetAttribute("Transparency") < 1
        
        WindUI:Notify({
            Title = "激光可见性检查",
            Content = ghostLaserVisible and "鬼魂对激光可见!" or 
                "鬼魂对激光不可见\n这可能是错误，请确保将激光投影仪放在鬼魂喜欢的房间",
            Duration = ghostLaserVisible and 3.5 or 7.5
        })
    end
})

local Toggle = Tab5:Toggle({
    Title = "通知聊天消息",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        if Value then
            for _, d in pairs(game.Players:GetChildren()) do
                if d ~= game.Players.LocalPlayer then
                    stuff.playerChatted[d.Name] = d.Chatted:Connect(function(msg)
                        local topName = d.Name
                        
                        if workspace:WaitForChild("Ragdolls"):FindFirstChild(d.Name) then
                            topName = topName.. " (死亡)"
                        end
                        
                        WindUI:Notify({
                            Title = topName.." 说:",
                            Content = msg,
                            Duration = 10
                        })

                        if stuff.sayInchat2 then
                            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("AskSpiritBoxFromUI"):FireServer(
                                topName.." 说: ".. msg
                            )
                        end
                    end)
                end
            end
        else
            for _, d in pairs(stuff.playerChatted) do
                d:Disconnect()
            end
            stuff.playerChatted = {}
        end
    end
})

local Toggle = Tab5:Toggle({
    Title = "在聊天中通知消息",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        stuff.sayInchat2 = Value
    end
})

local Button = Tab5:Button({
    Title = "通知所有稀有物品",
    Desc = "",
    Locked = false,
    Callback = function()
        local found = false

        for _, d in pairs(workspace:WaitForChild("Items"):GetChildren()) do
            if d:GetAttribute("ItemName") then
                local NameItem = d:GetAttribute("ItemName")
                local er = true

                if d:GetAttribute("Uninteractable") == true or d:GetAttribute("Broken") == true then
                    er = false
                end

                if er and (NameItem == "Energy Drink" or NameItem == "Music Box" or 
                    NameItem == "Umbra Board" or NameItem == "Energy Watch" or tonumber(d.Name) >= 100) then
                    
                    found = true
                    WindUI:Notify({
                        Title = "稀有物品警告",
                        Content = "发现稀有物品 "..NameItem,
                        Duration = 3.5
                    })

                    local hightlight = Instance.new("Highlight")
                    hightlight.Parent = d
                    hightlight.FillColor = Color3.fromRGB(37, 161, 255)
                    game:GetService("Debris"):AddItem(hightlight,5)
                end
            end
        end

        if not found then
            WindUI:Notify({
                Title = "稀有物品警告",
                Content = "未找到稀有物品",
                Duration = 3.5
            })
        end
    end
})

local Button = Tab5:Button({
    Title = "切换保险丝盒",
    Desc = "",
    Locked = false,
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ToggleFuseBox"):FireServer()
    end
})

local Button = Tab5:Button({
    Title = "获取当前房间温度",
    Desc = "",
    Locked = false,
    Callback = function()
        local room = game.Players.LocalPlayer:GetAttribute("CurrentRoom")
        
        if workspace:WaitForChild("Map"):WaitForChild("Rooms"):FindFirstChild(room) and 
            workspace:WaitForChild("Map"):WaitForChild("Rooms"):WaitForChild(room):GetAttribute("Temperature") then
            
            WindUI:Notify({
                Title = "房间温度检查",
                Content = room.."的温度是 "..tostring(workspace:WaitForChild("Map"):WaitForChild("Rooms"):WaitForChild(room):GetAttribute("Temperature")),
                Duration = 3.5
            })
        end
    end
})

local Toggle = Tab5:Toggle({
    Title = "通知鬼魂房间温度低于0°C",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        if Value then
            local room = workspace:WaitForChild("Ghost"):GetAttribute("FavoriteRoom")
            
            if workspace:WaitForChild("Map"):WaitForChild("Rooms"):WaitForChild(room):GetAttribute("Temperature") <= 0 then
                WindUI:Notify({
                    Title = "房间温度检查(鬼魂)",
                    Content = room.."的温度低于0°C!",
                    Duration = 3.5
                })
            end

            workspace:WaitForChild("Map"):WaitForChild("Rooms"):WaitForChild(room):GetAttributeChangedSignal("Temperature"):Connect(function()
                if workspace:WaitForChild("Map"):WaitForChild("Rooms"):WaitForChild(room):GetAttribute("Temperature") <= 0 then
                    WindUI:Notify({
                        Title = "房间温度检查(鬼魂)",
                        Content = room.."的温度低于0°C!",
                        Duration = 3.5
                    })
                end
            end)
        end
    end
})

local Toggle = Tab5:Toggle({
    Title = "穿门无碰撞",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        for _, d in pairs(workspace.Doors:GetChildren()) do
            task.spawn(function()
                for _, d22 in pairs(d:WaitForChild("Door"):GetChildren()) do
                    if d22:IsA("BasePart") and d22.Name ~= "GhostTracker" then
                        d22.CanCollide = not Value
                    end
                end
            end)
        end
    end
})

local Toggle = Tab5:Toggle({
    Title = "最大亮度",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        if Value then
            game.Lighting.Brightness = 2
            game.Lighting.ClockTime = 14
            game.Lighting.GlobalShadows = false
            game.Lighting.OutdoorAmbient = Color3.fromRGB(209, 209, 209)
        else
            game.Lighting.Brightness = 0
            game.Lighting.ClockTime = 0
            game.Lighting.GlobalShadows = true
            game.Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
        end
    end
})

local Toggle = Tab5:Toggle({
    Title = "刷门(卡顿)",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        task.spawn(function()
            while Value do
                task.wait()
                for _, d in pairs(workspace.Doors:GetChildren()) do
                    if d:GetAttribute("Locked") ~= true then
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ClientChangeDoorState"):FireServer(d:WaitForChild("Door"))
                    end
                end
            end
        end)
    end
})

local Toggle = Tab5:Toggle({
    Title = "刷灯(卡顿)",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        task.spawn(function()
            while Value do
                task.wait()
                for _, d in pairs(workspace.Map.Rooms:GetChildren()) do
                    if d:FindFirstChild("LightSwitch") then
                        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UseLightSwitch"):FireServer(d)
                    end
                end
            end
        end)
    end
})

local Button = Tab5:Button({
    Title = "让所有物品消失",
    Desc = "",
    Locked = false,
    Callback = function()
        task.spawn(function()
            while task.wait() do
                for _, d in pairs(workspace.Items:GetChildren()) do
                    if d.PrimaryPart then
                        local newForce = Instance.new("BodyPosition",d.PrimaryPart)
                        newForce.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                        newForce.Position = Vector3.new(1000000,1000000,1000000)
                    end
                end

                for _, d in pairs(game.Players:GetChildren()) do
                    local Tools = d:WaitForChild("ToolsHolder")

                    for _, d in pairs(Tools:GetChildren()) do
                        if d.PrimaryPart then
                            local newForce = Instance.new("BodyPosition",d.PrimaryPart)
                            newForce.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                            newForce.Position = Vector3.new(1000000,1000000,1000000)
                        end
                    end
                end
            end
        end)
    end
})

local Tab6 = Tabs.Main:Tab({
    Title = "紧急汉堡",
    Icon = "layout-grid",
    Locked = false,
})

local Button = Tab6:Button({
    Title = "饶过检测",
    Desc = "",
    Locked = false,
    Callback = function()
        local function funcnil()
            local func = nil
            for i,v in pairs(getgc(true)) do
                if type(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.Code.controllers.antiCheatController and tostring(getinfo(v).name) ~= nil and tostring(getinfo(v).name) ~= "" then
                    func = v
                end
            end
            return func
        end
        
        repeat task.wait()
            for i,v in pairs(getgc(true)) do
                if type(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.Code.controllers.antiCheatController then
                    warn(getinfo(v).name)
                    hookfunction(v,function()
                        return 
                    end)
                end
            end
            wait(1)
            print(funcnil())
        until funcnil() == nil
        wait(2)
        warn("反检测已禁用")
    end
})

local Toggle = Tab6:Toggle({
    Title = "防挂机",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        if state then
            warn("防挂机运行中")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                warn("触发防挂机")
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton2(Vector2.new())
            end)
        end
    end
})

local Toggle = Tab6:Toggle({
    Title = "自动公交车司机",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        getfenv().busman = state
        if state then
            spawn(function()
                while getfenv().busman do
                    task.wait()
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        local car = workspace.Vehicles:FindFirstChild(plr.Name)
                        if workspace.Vehicles:FindFirstChild(plr.Name) and string.find(tostring(car:GetAttribute("Model")),"Bus Driver") and partfind() ~= nil and game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                            car.DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                        end
                    end)
                end
            end)
            
            spawn(function()
                while getfenv().busman do
                    task.wait()
                    pcall(function()
                        if game.Players.LocalPlayer.Character.Humanoid.Health < 60 and game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                            game.Players.LocalPlayer.Character:BreakJoints()
                            warn("角色血量过低，已重置")
                        end
                    end)
                end
            end)
            
            while getfenv().busman do
                wait()
                pcall(function()
                    workspace.Gravity = 196
                    local plr = game.Players.LocalPlayer
                    local car = workspace.Vehicles[plr.Name]
                    if workspace.Vehicles:FindFirstChild(plr.Name) and game.Players.LocalPlayer.Team ~= game:GetService("Teams").BusCompany then
                        repeat wait()
                            workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                        until game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil
                        wait()
                        workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(CFrame.new(-1683.09375, 15.630923271179199, -1286.167236328125))
                        wait(5)
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                        wait(2)
                        
                        if game.Players.LocalPlayer:DistanceFromCharacter(Vector3.new(-1683.09375, 5.630923271179199, -1286.167236328125)) < 50 then
                           
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(-1708.8741455078125, 5.616213321685791, -1281.946044921875))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(-1730.544677734375, 5.683385848999023, -1280.9140625))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            
                          
                            repeat wait()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                            until shiftfind() ~= nil
                            
                            wait(3)
                            local busdriver = getfenv().drivertype or "Rural Bus Driver"
                            for i,v in pairs(shiftfind():GetDescendants()) do
                                if v.ClassName == "ImageButton" and v.Name == busdriver then
                                    if v.Parent ~= nil then
                                        firesignal(v.MouseButton1Click)
                                    end
                                end
                            end
                            
                            wait(3)
                            for i,v in pairs(shiftfind():GetDescendants()) do
                                if v.ClassName == "ImageButton" and v.ImageColor3 == Color3.fromRGB(142, 68, 173) then
                                    if v.Parent ~= nil then
                                        firesignal(v.MouseButton1Click)
                                    end
                                end
                            end
                            
                            wait(2)
                          
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(-1722.3858642578125, 5.645286560058594, -1264.3126220703125))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            
                            repeat wait()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                            until dealership() ~= nil and dealership().Enabled == true or partfind() ~= nil
                            
                            wait(2)
                            for i,v in pairs(dealership():GetDescendants()) do
                                if v.ClassName == "TextLabel" and v.Text == "Stuttgart Omnibus" then
                                    local plr = game.Players.LocalPlayer
                                    repeat wait()
                                        if v.Parent ~= nil then
                                            firesignal(v.Parent.MouseButton1Click)
                                            for a,b in pairs(dealership():GetDescendants()) do
                                                if b.ClassName == "ImageButton" and b:FindFirstChildOfClass("TextLabel").Text == "Spawn Vehicle" or b.ClassName == "ImageButton" and b:FindFirstChildOfClass("TextLabel").Text == "Unlock Vehicle" then
                                                    firesignal(b.MouseButton1Click)
                                                end
                                            end
                                        end
                                    until workspace.Vehicles:FindFirstChild(plr.Name) and partfind() ~= nil or partfind() ~= nil
                                end
                            end
                        end
                    elseif partfind() ~= nil and game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                     
                        workspace.Gravity = 0
                        local plr = game.Players.LocalPlayer
                        local chr = plr.Character
                        local car = workspace.Vehicles[plr.Name]
                        car.PrimaryPart = car.Body.Mass
                        local pos = destination() or partfind()
                        
                      
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude > 100 then
                            local TweenService = game:GetService("TweenService")
                            local TweenInfoToUse = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
                            local TweenValue = Instance.new("CFrameValue")
                            TweenValue.Value = car.WorldPivot
                            TweenValue.Changed:Connect(function()
                                car:PivotTo(TweenValue.Value)
                            end)
                            getfenv().tween = TweenService:Create(TweenValue, TweenInfoToUse, {Value=car.WorldPivot+Vector3.new(0,1000,0)})
                            getfenv().tween:Play()
                            repeat task.wait()
                            until getfenv().tween.PlaybackState == Enum.PlaybackState.Cancelled or getfenv().tween.PlaybackState == Enum.PlaybackState.Completed or getfenv().tween.PlaybackState == Enum.PlaybackState.Paused
                        end
                        
                    
                        local plr = game.Players.LocalPlayer
                        local pos = destination() or partfind()
                        local car = workspace.Vehicles[plr.Name]
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude < 100 then
                            car:PivotTo(pos.CFrame)
                            workspace.Gravity = 196
                            for i,v in pairs(workspace.BusStops:GetDescendants()) do
                                if v.Name == "SelectionBox" and v.Visible == true then
                                    car:PivotTo(v.Parent.CFrame+Vector3.new(0,5,0))
                                end
                            end
                            local time = tick()
                            repeat task.wait()
                            until partfind() == nil or game.Players.LocalPlayer:DistanceFromCharacter(partfind().Position) > 70 or tick() - time >= 5
                        end
                    end
                end)
            end
        end
    end
})

local Toggle = Tab6:Toggle({
    Title = "自动卡车司机",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        getfenv().trucker = state
        if state then
            spawn(function()
                while getfenv().trucker do
                    task.wait()
                    pcall(function()
                        if workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name) and workspace.Vehicles[game.Players.LocalPlayer.Name].Body:FindFirstChild("Trailer") and game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                            local plr = game.Players.LocalPlayer
                            local car = workspace.Vehicles[plr.Name]
                            if getfenv().tween ~= nil then
                                getfenv().tween:Cancel()
                                print("Tween Cancelled")
                            end
                            car.DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                        end
                    end)
                end
            end)
            
            spawn(function()
                while getfenv().trucker do
                    task.wait()
                    pcall(function()
                        if game.Players.LocalPlayer.Character.Humanoid.Health < 60 and game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                            game.Players.LocalPlayer.Character:BreakJoints()
                            warn("角色血量过低，已重置")
                        end
                    end)
                end
            end)
            
            spawn(function()
                while getfenv().trucker do
                    task.wait()
                    pcall(function()
                        for i,v in pairs(workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):GetDescendants()) do
                            pcall(function()
                                v.Velocity = Vector3.new(0,0,0)
                            end)
                        end
                    end)
                end
            end)
            
            while getfenv().trucker do
                wait()
                pcall(function()
                    workspace.Gravity = 196
                    if workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name) and not workspace.Vehicles[game.Players.LocalPlayer.Name].Body:FindFirstChild("Trailer") then
                        repeat wait()
                            workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                        until game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil
                        wait()
                        workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(CFrame.new(717.53125, 15.626567840576172, 1462.559814453125))
                        wait(1)
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                        wait(2)
                        
                        if game.Players.LocalPlayer:DistanceFromCharacter(Vector3.new(717.53125, 15.626567840576172, 1462.559814453125)) < 50 then
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(712.7074584960938, 5.587162017822266, 1437.5025634765625))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(707.704345703125, 5.657994270324707, 1426.1021728515625))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            
                            repeat wait()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                            until shiftfind() ~= nil
                            
                            wait(3)
                            local timestried = 0 
                            repeat wait()
                                if game.Players.LocalPlayer.Team ~= game:GetService("Teams").TruckCompany then
                                    repeat wait()
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                                    until shiftfind() ~= nil
                                    task.wait(1)
                                    if game.Players.LocalPlayer.Team ~= game:GetService("Teams").TruckCompany and timestried > 10 then
                                        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
                                            if v.ClassName == "TextLabel" and v.Text == "Start Shift" then
                                                firesignal(v.Parent.MouseButton1Click)
                                            end
                                        end
                                        timestried = 0
                                    end
                                    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
                                        if v.ClassName == "ImageButton" and v.ImageColor3 == Color3.fromRGB(39, 174, 96) then
                                            if v.Parent ~= nil then
                                                pcall(function()
                                                    firesignal(v.MouseButton1Down)
                                                end)
                                            end
                                        end
                                    end
                                    timestried=timestried+1
                                    task.wait(1)
                                end
                            until findxpui() ~= nil
                            
                            repeat wait()
                            until findxpui() ~= nil and findxpui().Enabled == true
                            _G.rat = nil
                            local num = 0
                            for i,v in pairs(findxpui():GetDescendants()) do
                                if v.ClassName == "TextLabel" and string.find(v.Text,"XP") then
                                    local Val = tonumber(v.Text:split(" ")[1])
                                    if Val > num then
                                        num = Val
                                        print(Val)
                                        _G.rat = v.Parent
                                    end
                                end
                            end
                            if _G.rat ~= nil then
                                firesignal(_G.rat.MouseButton1Click)
                            end
                            
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(699.1327514648438, 5.645294189453125, 1407.9368896484375))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(700.1976318359375, 5.645294189453125, 1408.7381591796875))
                            game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:wait()
                            
                            repeat wait()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true,"E",false,game)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false,"E",false,game)
                            until dealership()~= nil and dealership().Enabled == true
                            
                          
                            for i,v in pairs(dealership():GetDescendants()) do
                                if v.ClassName == "TextLabel" and v.Text == "Stuttgart Lastkraft" then
                                    repeat wait()
                                        if v.Parent ~= nil then
                                            firesignal(v.Parent.MouseButton1Click)
                                            wait(1)
                                            for a,b in pairs(dealership():GetDescendants()) do
                                                if b.ClassName == "TextLabel" and b.Text == "Spawn Vehicle" or b.ClassName == "TextLabel" and b.Text == "Unlock Vehicle" then
                                                    firesignal(b.Parent.MouseButton1Click)
                                                end
                                            end
                                        end
                                    until workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name) and workspace.Vehicles[game.Players.LocalPlayer.Name].Body:FindFirstChild("Trailer")
                                end
                            end
                        end
                    elseif workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name) and workspace.Vehicles[game.Players.LocalPlayer.Name].Body:FindFirstChild("Trailer") and game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                        workspace.Gravity = 0
                        local plr = game.Players.LocalPlayer
                        local chr = plr.Character
                        local car = workspace.Vehicles[plr.Name]
                        local pos = destination() or partfind()
                        car.PrimaryPart = car.Body.Mass
                        
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude > 100 then
                            car:PivotTo(car.WorldPivot+Vector3.new(0,500,0))
                        end
                        
                        local plr = game.Players.LocalPlayer
                        local pos = destination() or partfind()
                        local car = workspace.Vehicles[plr.Name]
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude > 100 then
                            local TweenService = game:GetService("TweenService")
                            local TweenInfoToUse = TweenInfo.new(dist/80, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
                            local TweenValue = Instance.new("CFrameValue")
                            TweenValue.Value = car.WorldPivot
                            TweenValue.Changed:Connect(function()
                                car:PivotTo(TweenValue.Value)
                            end)
                            getfenv().tween = TweenService:Create(TweenValue, TweenInfoToUse, {Value=pos.CFrame+Vector3.new(0,500,0)})
                            getfenv().tween:Play()
                            repeat task.wait()
                            until getfenv().tween.PlaybackState == Enum.PlaybackState.Cancelled or getfenv().tween.PlaybackState == Enum.PlaybackState.Completed or getfenv().tween.PlaybackState == Enum.PlaybackState.Paused
                        end
                        
                        local plr = game.Players.LocalPlayer
                        local pos = destination() or partfind()
                        local car = workspace.Vehicles[plr.Name]
                        if (car.WorldPivot.Position-Vector3.new(pos.Position.X,car.PrimaryPart.Position.Y,pos.Position.Z)).magnitude < 100 then
                            car:PivotTo(pos.CFrame)
                            workspace.Gravity = 196
                            for i,v in pairs(workspace.DeliveryDestinations:GetDescendants()) do
                                if v.Name == "SelectionBox" and v.Visible == true then
                                    car:PivotTo(v.Parent.CFrame+Vector3.new(0,5,0))
                                end
                            end
                            local time = tick()
                            repeat task.wait()
                            until partfind() == nil or game.Players.LocalPlayer:DistanceFromCharacter(partfind().Position) > 70 or tick() - time > 40
                        end
                    end
                end)
            end
        end
    end
})
 
local function teams()
    local teams = {"选择敌方队伍"}
    for i,v in pairs(game:GetService("Teams"):GetChildren()) do
        table.insert(teams,v.Name)
    end
    return teams
end

local Dropdown = Tab6:Dropdown({
    Title = "选择敌方队伍",
    Values = teams(),
    Desc = "",
    Locked = false,
    Callback = function(state) 
        if state ~= "选择敌方队伍" then
            getfenv().enemy = state
        end
    end
})

local Toggle = Tab6:Toggle({
    Title = "自动瞄准",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        getfenv().aimbot = state
        local function canaim(ye)
            return game:GetService("Players").LocalPlayer:DistanceFromCharacter(ye) < 3
        end
        
        while getfenv().aimbot do
            task.wait()
            if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and canaim(workspace.Camera.CFrame.Position) then
                local plr = nil
                local distance = math.huge
                for a,b in pairs(game.Players:GetPlayers()) do
                    if b.Team.Name == getfenv().enemy then
                        pcall(function()
                            local Dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - b.Character.Head.Position).magnitude
                            if Dist < distance then
                                distance = Dist
                                plr = b
                            end
                        end)
                    end
                end
                if plr ~= nil then
                    workspace.Camera.CameraType = "Follow"
                    workspace.Camera.CFrame = CFrame.new(workspace.Camera.CFrame.Position,plr.Character.Head.Position)
                end
            end
        end
    end
})

local Toggle = Tab6:Toggle({
    Title = "高亮敌人",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        getfenv().highlight = state
        if getfenv().highlight == false then
            for i,v in pairs(game.Players:GetChildren()) do
                if v.ClassName == "Player" and v.Team.Name == getfenv().enemy and v.Character ~= nil and v.Character:FindFirstChild("Highlight") then
                    v.Character:FindFirstChild("Highlight"):Destroy()
                    task.wait()
                end
            end
        end
        while getfenv().highlight do
            task.wait()
            for i,v in pairs(game.Players:GetChildren()) do
                if v.ClassName == "Player" and v.Team.Name == getfenv().enemy and v.Character ~= nil and not v.Character:FindFirstChild("Highlight") then
                    Instance.new("Highlight",v.Character)
                    task.wait()
                end
            end
        end
    end
})

local Dropdown = Tab6:Dropdown({
    Title = "选择传送点",
    Desc = "",
    Locked = false,
    Values = {"传送点","警察局","银行","停车场","珠宝店","监狱","公交公司","卡车公司","医院"},
    Callback = function(state)
        print(state)
        workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).Body.Mass
        if state == "警察局" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1549.2081298828125, 5.615050315856934, 2935.314697265625)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2
        elseif state == "银行" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1174.68115234375, 5.874685287475586, 3209.03271484375)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2
        elseif state == "停车场" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-993.5323486328125, -11.622750282287598, 3705.0126953125)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2
        elseif state == "珠宝店" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-396.0776062011719, 5.6145405769348145, 3508.26318359375)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "监狱" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-548.9014282226562, 5.6149725914001465, 2832.7587890625)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "卡车公司" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(717.53125, 15.626567840576172, 1462.559814453125)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "公交公司" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1683.09375, 15.630923271179199, -1286.167236328125)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "医院" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-304.7102966308594, 5.623022079467773, 1018.22119140625)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        end
    end
})

local Dropdown = Tab6:Dropdown({
    Title = "选择传送点",
    Desc = "",
    Locked = false,
    Values = {"传送点","工具店","汽车经销商","农场商店","Ares加油站","Osso加油站","Gas-N-Go加油站"},
    Callback = function(state)
        print(state)
        workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart = workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).Body.Mass
        if state == "工具店" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-733.7286376953125, 5.614245414733887, 677.4180908203125)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "汽车经销商" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1422.2327880859375, 5.624246120452881, 939.8997802734375)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "农场商店" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-840.9263305664062, 5.378037929534912, -1179.6783447265625)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "Ares加油站" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-873.4227294921875, 5.614551067352295, 1500.887451171875)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "Osso加油站" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-26.49447250366211, 5.615009307861328, -766.71630859375)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        elseif state == "Gas-N-Go加油站" then
            local time = tick()
            repeat task.wait()
                if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name).DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    time = tick()
                    wait(1)
                    time = tick()
                elseif game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= nil then
                    location = CFrame.new(-1544.445556640625, 5.628605842590332, 3811.127685546875)
                    workspace.Vehicles:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(location)
                end
            until tick()-time > 2  
        end
    end
})

local destination = function()
    local dest = nil
    for i,v in pairs(workspace.DeliveryDestinations:GetDescendants()) do
        if v.Name == "SelectionBox" and v.Visible == true and v.Transparency ~= 1 then
            dest = v.Parent
        end
    end
    return dest
end

local getplayer = function(plr)
    local player = nil
    for i,v in pairs(game.Players:GetPlayers()) do
        if string.find(v.Name,plr) or string.find(v.DisplayName,plr) then
            player = v.Name
            break
        end
    end
    return player
end

local shiftfind = function()
    local shift = nil
    local uifind = nil
    local busdriver = getfenv().drivertype or "Rural Bus Driver"
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v.ClassName == "TextLabel" and v.Text == "Start Shift" or v.ClassName == "ImageButton" and v.Name == busdriver then
            shift = v.Parent
        end
    end
    if shift ~= nil then
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
            if shift:IsDescendantOf(v) then
                uifind = v
            end
        end
    end
    return uifind
end

local dealership = function()
    local deal = nil
    local uifind = nil
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v.ClassName == "TextLabel" and v.Text == "Stuttgart Lastkraft" or v.ClassName == "TextLabel" and v.Text == "Stuttgart Omnibus" then
            deal = v
        end
    end
    if deal ~= nil then
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
            if deal:IsDescendantOf(v) then
                uifind = v
            end
        end
    end
    return uifind
end

local partfind = function()
    local part = nil
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v.ClassName == "BillboardGui" and v.Adornee ~= nil then
            part = v.Adornee
        end
    end
    return part
end

local findxpui = function() 
    local xpui = nil
    local test = nil
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v.ClassName == "TextLabel" and string.find(v.Text,"XP") and v.Parent.ClassName == "ImageButton" and tonumber(v.Text:split(" ")[1]) then
            test = v
            break
        end
    end
    if test ~= nil then
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
            if test:IsDescendantOf(v) then
                xpui = v
            end
        end
    end
    return xpui
end

local Tab7 = Tabs.Main:Tab({
    Title = "成为乞丐",
    Icon = "layout-grid",
    Locked = false,
})

local Toggle = Tab7:Toggle({
    Title = "自动乞讨",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        _G.AutoFastMoney = Value
        if Value then
            local plrs = game:GetService("Players")
            local rs = game:GetService("ReplicatedStorage")
            local me = plrs.LocalPlayer
            local char = me.Character or me.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            local bases = workspace:WaitForChild("Bases")
            local ev = rs.Remotes:WaitForChild("MinigameEvent")
            local run = game:GetService("RunService")

            local function findBase()
                for _,b in pairs(bases:GetChildren()) do
                    local o = b:FindFirstChild("Owner")
                    if o then
                        local v = o.Value
                        if v == me or tostring(v) == me.Name or tonumber(v) == me.UserId then
                            return b
                        end
                    end
                end
            end

            local b = findBase()
            if b then
                local beg = b:WaitForChild("BegPrompt")
                local prompt = beg:WaitForChild("ProximityPrompt")
                
                hrp.CFrame = beg.CFrame + Vector3.new(0,3,0)
                fireproximityprompt(prompt)
                
                while _G.AutoFastMoney do
                    run.RenderStepped:Wait()
                    ev:FireServer(true)
                end
            end
        end
    end
})

local Toggle = Tab7:Toggle({
    Title = "自动购买员工",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        _G.AutoBuyEmployees = Value
        if Value then
            local Replicate = game:GetService("ReplicatedStorage")
            local BuyEmployee = Replicate.Remotes.BuyEmployee
            task.spawn(function()
                while _G.AutoBuyEmployees do 
                    for i = 1, 75 do 
                        if i ~= 13 and i ~= 14 then 
                            BuyEmployee:FireServer(i)
                            task.wait(0.3)
                        end 
                    end 
                end 
            end)
        end
    end
})

local Toggle = Tab7:Toggle({
    Title = "自动升级",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        _G.AutoBuyUpgrades = Value
        if Value then
            local Replicate = game:GetService("ReplicatedStorage")
            local Upgrade = Replicate.Remotes.Upgrade
            task.spawn(function()
                while _G.AutoBuyUpgrades do 
                    task.wait(0.1)
                    Upgrade:FireServer("Beg Power")
                    Upgrade:FireServer("Income")
                    Upgrade:FireServer("Box Tier")
                    Upgrade:FireServer("Alley Tier")
                end 
            end)
        end
    end
})

local Toggle = Tab7:Toggle({
    Title = "金钱光环",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        _G.MoneyAura = Value
        if Value then
            local Money = workspace:WaitForChild("Money")
            local HRP = player.Character:WaitForChild("HumanoidRootPart")
            task.spawn(function()
                while _G.MoneyAura do
                    local OldCFrame = HRP.CFrame
                    for _,v in pairs(Money:GetDescendants()) do
                        if v:IsA("ProximityPrompt") and v.Parent:IsA("BasePart") then
                            HRP.CFrame = v.Parent.CFrame + Vector3.new(0,3,0)
                            fireproximityprompt(v,0,true)
                        end
                    end
                    HRP.CFrame = OldCFrame
                    task.wait(0.5)
                end 
            end)
        end
    end
})

local Tab8 = Tabs.Main:Tab({
    Title = "建造你的基地",
    Icon = "layout-grid",
    Locked = false,
})
local Toggle = Tab8:Toggle({
    Title = "自动挥舞拳头",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(value)
        rangeAttackEnabled = value
        if rangeAttackEnabled then
            while rangeAttackEnabled do
                local args = {
                    [1] = true,
                    [2] = Vector3.new(0, 0, 0),  
                    [3] = 50,                  
                    [4] = Enum.Material.Water,    
                    [5] = "RangeAttack"        
                }
                
                game:GetService("ReplicatedStorage").Remotes.Events.ToolState:FireServer(unpack(args))
                wait()
            end
        end
    end
})

local rangeAttackEnabled = false

local Toggle = Tab8:Toggle({
    Title = "范围攻击",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(value)
        rangeAttackEnabled = value
        if value then
            spawn(function()
                while rangeAttackEnabled do
                    for _, enemy in next, workspace.Characters:GetChildren() do
                        if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") then
                            if enemy ~= game.Players.LocalPlayer.Character and enemy.Humanoid.Health > 0 then
                                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                                if distance <= 999 then 
                                    local args = {
                                        [1] = true,
                                        [2] = enemy.HumanoidRootPart.Position,  
                                        [3] = 50,                    
                                        [4] = Enum.Material.Water,   
                                        [5] = "RangeAttack"          
                                    }
                                    
                                    pcall(function()
                                        game:GetService("ReplicatedStorage").Remotes.Events.ToolState:FireServer(unpack(args))
                                    end)
                                end
                            end
                        end
                    end
                    
                    wait()
                end
            end)
        end
    end
})

local Tab9 = Tabs.Main:Tab({
    Title = "矿井",
    Icon = "layout-grid",
    Locked = false,
})

local Toggle = Tab9:Toggle({
    Title = "自动收集矿物",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in pairs(workspace.Items:GetChildren()) do
                if v then
                    local args = {
                        v.Name
                    }
                    game:GetService("ReplicatedStorage"):FindFirstChild("shared/network/MiningNetwork@GlobalMiningEvents").CollectItem:FireServer(unpack(args))
                end
            end
        end
    end
})

local Toggle = Tab9:Toggle({
    Title = "自动出售矿物",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        while state and task.wait() do
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and v:GetAttribute("Name") == "Trader Tom" then
                    game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v:FindFirstChild("HumanoidRootPart").CFrame
                    game:GetService("ReplicatedStorage").Ml.SellInventory:FireServer()
                    break
                end
            end
        end
    end
})

local Tab10 = Tabs.Main:Tab({
    Title = "doors",
    Icon = "layout-grid",
    Locked = false,
})

local Button = Tab10:Button({
    Title = "禁用反作弊",
    Desc = "",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")

        if currentRoom == 0 then
            if replicatesignal then
                replicatesignal(LocalPlayer.Kill)
                WindUI:Notify("反作弊", "反作弊已禁用，你可以飞行穿过一切", 10)
            else
                WindUI:Notify("错误", "您的执行器不支持replicatesignal功能", 5)
            end
        else
            WindUI:Notify("提示", "你需要在电梯中使用此功能", 5)
        end
    end
})

local Toggle = Tab10:Toggle({
    Title = "反作弊绕过",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RemoteFolder = game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder")

        if not Value then
            if RemoteFolder and RemoteFolder:FindFirstChild("ClimbLadder") then
                RemoteFolder.ClimbLadder:FireServer()
            end
        else
            WindUI:Notify("反作弊", "请上梯子以激活绕过", 9)
        end
    end
})

local LocalPlayer = game:GetService("Players").LocalPlayer
LocalPlayer.Character:GetAttributeChangedSignal("Climbing"):Connect(function()
    if LocalPlayer.Character:GetAttribute("Climbing") == true then
        task.spawn(function()
            task.wait(0.1)
            LocalPlayer.Character:SetAttribute("Climbing", false)
            WindUI:Notify("反作弊", "已绕过反作弊，攀爬重置", 7)
        end)
    end
end)

local Toggle = Tab10:Toggle({
    Title = "反作弊操纵",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local UserInputService = game:GetService("UserInputService")
        local savedCamCFrame
        local camLocked = false
        local acmButton
        local acmButtonActive = false

        local BUTTON_SIZE = UDim2.new(0, 70, 0, 35)
        local BUTTON_POSITION = UDim2.new(1, -80, 0.5, -17)
        local BUTTON_COLOR = Color3.fromRGB(45, 45, 45)
        local BUTTON_ACTIVE_COLOR = Color3.fromRGB(90, 90, 90)
        local BUTTON_TEXT_COLOR = Color3.fromRGB(255, 255, 255)

        local function createACMButton()
            if not UserInputService.TouchEnabled or acmButton then
                return
            end

            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "ACMGui"
            screenGui.ResetOnSpawn = false
            screenGui.Parent = PlayerGui

            local button = Instance.new("TextButton")
            button.Name = "ACMButton"
            button.Size = BUTTON_SIZE
            button.Position = BUTTON_POSITION
            button.BackgroundColor3 = BUTTON_COLOR
            button.Text = "ACM"
            button.TextColor3 = BUTTON_TEXT_COLOR
            button.Font = Enum.Font.GothamBold
            button.TextSize = 16
            button.BorderSizePixel = 0
            button.Parent = screenGui

            button.MouseButton1Down:Connect(function()
                acmButtonActive = true
                button.BackgroundColor3 = BUTTON_ACTIVE_COLOR
            end)

            button.MouseButton1Up:Connect(function()
                acmButtonActive = false
                button.BackgroundColor3 = BUTTON_COLOR
            end)

            acmButton = screenGui
        end

        local function removeACMButton()
            if acmButton then
                acmButton:Destroy()
                acmButton = nil
                acmButtonActive = false
            end
        end

        if Value then
            createACMButton()
            
            RunService.RenderStepped:Connect(function()
                local cam = workspace.CurrentCamera
                if not cam then return end

                local active = Value and acmButtonActive
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if active and hrp then
                    if not camLocked then
                        savedCamCFrame = cam.CFrame
                        cam.CameraType = Enum.CameraType.Scriptable
                        camLocked = true
                        hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 10000)
                    end

                    cam.CFrame = savedCamCFrame
                elseif camLocked then
                    cam.CameraType = Enum.CameraType.Custom
                    camLocked = false
                    savedCamCFrame = nil
                end
            end)
        else
            removeACMButton()
        end
    end
})

local SpeedValue = 21
local SpeedEnabled = false
local SpeedConnection = nil

local Toggle = Tab10:Toggle({
    Title = "开启速度",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        SpeedEnabled = Value
        local LocalPlayer = game:GetService("Players").LocalPlayer
        
        if Value then
            SpeedConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = SpeedValue
                end
            end)
            WindUI:Notify("移速", "自定义移速已启用: " .. SpeedValue, 3)
        else
            if SpeedConnection then
                SpeedConnection:Disconnect()
                SpeedConnection = nil
            end
            WindUI:Notify("移速", "自定义移速已禁用", 3)
        end
    end
})

local Slider = Tab10:Slider({
    Title = "速度数值",
    Value = {
        Min = 0,
        Max = 100,
        Default = 21,
    },
    Increment = 1,
    Callback = function(Value)
        SpeedValue = Value
        if SpeedEnabled then
            WindUI:Notify("移速", "移速已更新: " .. Value, 2)
        end
    end
})

local Toggle = Tab10:Toggle({
    Title = "即时加速度",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local OldAccel = PhysicalProperties.new(0.01, 0.7, 0, 1, 1)
        
        local function updateAcceleration()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CustomPhysicalProperties = Value and PhysicalProperties.new(100, 0, 0, 0, 0) or OldAccel
            end
        end

        if Value then
            updateAcceleration()
            WindUI:Notify("加速度", "即时加速度已启用", 3)
        else
            updateAcceleration()
            WindUI:Notify("加速度", "即时加速度已禁用", 3)
        end
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1.5)
            updateAcceleration()
        end)
    end
})

local isFlying = false
local flyConnections = {}
local flyKeys = {
    W = false,
    A = false,
    S = false,
    D = false,
    Space = false,
    Shift = false,
}
local FlySpeed = 50

local function startFly()
    local player = game.Players.LocalPlayer
    local character = player.Character

    if not character then
        return
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return
    end
    local bv = Instance.new("BodyVelocity")
    bv.Name = "FlyVelocity"
    bv.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = hrp

    local bg = Instance.new("BodyGyro")
    bg.Name = "FlyGyro"
    bg.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000)
    bg.P = 20000
    bg.D = 1000
    bg.Parent = hrp

    humanoid.AutoRotate = false
    humanoid.PlatformStand = true
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    local inputBegan = game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
        if gpe then return end
        
        if input.KeyCode == Enum.KeyCode.W then
            flyKeys.W = true
        elseif input.KeyCode == Enum.KeyCode.A then
            flyKeys.A = true
        elseif input.KeyCode == Enum.KeyCode.S then
            flyKeys.S = true
        elseif input.KeyCode == Enum.KeyCode.D then
            flyKeys.D = true
        elseif input.KeyCode == Enum.KeyCode.Space then
            flyKeys.Space = true
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            flyKeys.Shift = true
        end
    end)

    table.insert(flyConnections, inputBegan)

    local inputEnded = game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then
            flyKeys.W = false
        elseif input.KeyCode == Enum.KeyCode.A then
            flyKeys.A = false
        elseif input.KeyCode == Enum.KeyCode.S then
            flyKeys.S = false
        elseif input.KeyCode == Enum.KeyCode.D then
            flyKeys.D = false
        elseif input.KeyCode == Enum.KeyCode.Space then
            flyKeys.Space = false
        elseif input.KeyCode == Enum.KeyCode.LeftShift then
            flyKeys.Shift = false
        end
    end)

    table.insert(flyConnections, inputEnded)
    local renderConnection = game:GetService("RunService").RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera

        if not cam or not hrp or not hrp:FindFirstChild("FlyVelocity") or not humanoid or humanoid.Health <= 0 then
            stopFly()
            return
        end

        local move = Vector3.new(0, 0, 0)

        if flyKeys.W then
            move = move + cam.CFrame.LookVector
        end
        if flyKeys.S then
            move = move - cam.CFrame.LookVector
        end
        if flyKeys.A then
            move = move - cam.CFrame.RightVector
        end
        if flyKeys.D then
            move = move + cam.CFrame.RightVector
        end
        if flyKeys.Space then
            move = move + Vector3.new(0, 1, 0)
        end
        if flyKeys.Shift then
            move = move - Vector3.new(0, 1, 0)
        end

        local direction = (move.Magnitude > 0) and (move.Unit * FlySpeed) or Vector3.new(0, 0, 0)
        bv.Velocity = direction
        bg.CFrame = cam.CFrame
    end)

    table.insert(flyConnections, renderConnection)
end

local function stopFly()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local hrp = character and character:FindFirstChild("HumanoidRootPart")

    if hrp then
        local flyVelocity = hrp:FindFirstChild("FlyVelocity")
        if flyVelocity then
            flyVelocity:Destroy()
        end

        local flyGyro = hrp:FindFirstChild("FlyGyro")
        if flyGyro then
            flyGyro:Destroy()
        end
    end

    if humanoid then
        humanoid.AutoRotate = true
        humanoid.PlatformStand = false
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end

    for _, conn in ipairs(flyConnections) do
        conn:Disconnect()
    end

    flyConnections = {}
    flyKeys = {
        W = false,
        A = false,
        S = false,
        D = false,
        Space = false,
        Shift = false,
    }
end

local Toggle = Tab10:Toggle({
    Title = "开启飞行",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        isFlying = Value

        if Value then
            startFly()
            WindUI:Notify("飞行", "飞行模式已启用", 3)
        else
            stopFly()
            WindUI:Notify("飞行", "飞行模式已禁用", 3)
        end
    end
})

local Slider = Tab10:Slider({
    Title = "飞行速度",
    Value = {
        Min = 0,
        Max = 150,
        Default = 50,
    },
    Increment = 1,
    Callback = function(Value)
        FlySpeed = Value
        if isFlying then
            WindUI:Notify("飞行", "飞行速度已更新: " .. Value, 2)
        end
    end
})

local noclipConnection = nil
local originalGroups = {}

local Toggle = Tab10:Toggle({
    Title = "穿墙模式",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local lp = Players.LocalPlayer

        local function enableNoclip()
            if noclipConnection then
                return
            end

            noclipConnection = RunService.Stepped:Connect(function()
                if lp.Character then
                    for _, part in pairs(lp.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                            if not originalGroups[part] then
                                originalGroups[part] = part.CollisionGroup
                            end
                            part.CollisionGroup = "Default"
                        end
                    end
                end
            end)
        end

        local function disableNoclip()
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end

            local char = lp.Character
            if not char then
                return
            end

            local collision = char:FindFirstChild("Collision")
            local crouch = collision and collision:FindFirstChild("CollisionCrouch")

            if collision and crouch then
                local crouching = collision.CollisionGroup == "PlayerCrouching"
                collision.CanCollide = not crouching
                crouch.CanCollide = crouching
            end
        end

        if Value then
            enableNoclip()
            WindUI:Notify("穿墙", "穿墙模式已启用", 3)
        else
            disableNoclip()
            WindUI:Notify("穿墙", "穿墙模式已禁用", 3)
        end
    end
})
local Toggle = Tab10:Toggle({
    Title = "自动隐藏[防怪物]",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        local EntityDistances = {
            RushMoving = 50,
            BackdoorRush = 50,
            AmbushMoving = 100,
            A60 = 100,
            A120 = 35,
        }
        local Rooms = workspace.CurrentRooms
        local LocalPlayer = game.Players.LocalPlayer
        local Connections = {}

        local function GetHiding()
            local Closest, Prompt
            local currRoom = Rooms and Rooms[LocalPlayer:GetAttribute("CurrentRoom")]
            if not currRoom then return nil end

            local char = LocalPlayer.Character
            if not char then return nil end

            local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Collision") or char.PrimaryPart
            if not hrp then return nil end

            local function distFromPlayer(model)
                if not model then return math.huge end
                local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
                if not part then return math.huge end
                return (part.Position - hrp.Position).Magnitude
            end

            local assets = currRoom:FindFirstChild("Assets")
            if assets then
                for _, v in pairs(assets:GetChildren()) do
                    if v:IsA("Model") then
                        if ((v.Name == "Locker_Large") or (v.Name == "Wardrobe") or (v.Name == "Toolshed") or (v.Name == "Bed") or (v.Name == "Rooms_Locker") or (v.Name == "Rooms_Locker_Fridge") or (v.Name == "Backdoor_Wardrobe")) and v:FindFirstChild("HidePrompt") and v:FindFirstChild("HiddenPlayer") then
                            if not v.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                                if Closest then
                                    if distFromPlayer(v) < distFromPlayer(Closest) then
                                        Closest = v
                                        Prompt = v.HidePrompt
                                    end
                                else
                                    Closest = v
                                    Prompt = v.HidePrompt
                                end
                            end
                        elseif v.Name == "Double_Bed" then
                            for _, x in pairs(v:GetChildren()) do
                                if x.Name == "DoubleBed" and x:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                    if not x.HiddenPlayer.Value and not x:FindFirstChild("HideEntityOnSpot", true) then
                                        if Closest then
                                            if distFromPlayer(x) < distFromPlayer(Closest) then
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        else
                                            Closest = x
                                            Prompt = x.HidePrompt
                                        end
                                    end
                                end
                            end
                        elseif v.Name == "Dumpster" then
                            for _, x in pairs(v:GetChildren()) do
                                if x:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                    local dumpsterBaseHasSpot = v:FindFirstChild("DumpsterBase") and v.DumpsterBase:FindFirstChild("HideEntityOnSpot")
                                    if not x.HiddenPlayer.Value and not dumpsterBaseHasSpot then
                                        if Closest then
                                            if distFromPlayer(x) < distFromPlayer(Closest) then
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        else
                                            Closest = x
                                            Prompt = x.HidePrompt
                                        end
                                    end
                                end
                            end
                        end
                    elseif v:IsA("Folder") then
                        if v.Name == "Blockage" then
                            for _, x in pairs(v:GetChildren()) do
                                if x:IsA("Model") and x.Name == "Wardrobe" and x:FindFirstChild("HiddenPlayer") and x:FindFirstChild("HidePrompt") then
                                    if not x.HiddenPlayer.Value then
                                        if Closest then
                                            if distFromPlayer(x) < distFromPlayer(Closest) then
                                                Closest = x
                                                Prompt = x.HidePrompt
                                            end
                                        else
                                            Closest = x
                                            Prompt = x.HidePrompt
                                        end
                                    end
                                end
                            end
                        elseif v.Name == "Vents" then
                            for _, x in pairs(v:GetChildren()) do
                                if x.Name == "CircularVent" and x:FindFirstChild("Grate") and x.Grate:FindFirstChild("HidePrompt") and x:FindFirstChild("HiddenPlayer") then
                                    if not x.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                                        if Closest then
                                            if distFromPlayer(x) < distFromPlayer(Closest) then
                                                Closest = x
                                                Prompt = x.Grate.HidePrompt
                                            end
                                        else
                                            Closest = x
                                            Prompt = x.Grate.HidePrompt
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            for _, v in pairs(currRoom:GetChildren()) do
                if v:IsA("Model") then
                    if v.Name == "CircularVent" and v:FindFirstChild("Grate") and v.Grate:FindFirstChild("HidePrompt") and v:FindFirstChild("HiddenPlayer") then
                        if not v.HiddenPlayer.Value and not v:FindFirstChild("HideEntityOnSpot", true) then
                            if Closest then
                                if distFromPlayer(v) < distFromPlayer(Closest) then
                                    Closest = v
                                    Prompt = v.Grate.HidePrompt
                                end
                            else
                                Closest = v
                                Prompt = v.Grate.HidePrompt
                            end
                        end
                    end
                end
            end

            return Prompt
        end

        if Value then
            table.insert(Connections, workspace.ChildAdded:Connect(function(v)
                if v:IsA("Model") and EntityDistances[v.Name] then
                    task.wait(1)
                    local Part = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart", true)
                    if not Part then return end

                    v:SetAttribute("_Prediction", Part.Position)

                    while task.wait() and v.Parent do
                        task.spawn(function()
                            local LastPosition = Part.Position
                            task.wait(0.3333333333333333)
                            if Part and Part.Parent then
                                v:SetAttribute("_Prediction", Part.Position - LastPosition)
                            end
                        end)

                        if Value then
                            local IncludeList = {}
                            for _, Room in pairs(Rooms:GetChildren()) do
                                if Room:FindFirstChild("Assets") then
                                    table.insert(IncludeList, Room.Assets)
                                end
                                if Room:FindFirstChild("Parts") then
                                    table.insert(IncludeList, Room.Parts)
                                end
                            end

                            local RaycastParams = RaycastParams.new()
                            RaycastParams.FilterDescendantsInstances = IncludeList
                            RaycastParams.FilterType = Enum.RaycastFilterType.Include

                            local Count = {0.2, 0.4, 0.6, 0.8, 1}
                            local entityInRange = false

                            for i = 1, #Count do
                                local Number = 1.5 * Count[i]
                                local predAttr = v:GetAttribute("_Prediction")
                                local Prediction = (predAttr and (predAttr * 3)) or Vector3.new(0, 0, 0)
                                Prediction = Prediction * Number

                                local char = LocalPlayer.Character
                                if not char then break end

                                local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Collision") or char.PrimaryPart
                                if not hrp then break end

                                if Vector3.new(Prediction.X, 0, Prediction.Z).Magnitude > 1 then
                                    local PredictionPosition = Part.Position + Prediction
                                    local Raycast
                                    if true then
                                        Raycast = workspace:Raycast(hrp.Position, PredictionPosition - hrp.Position, RaycastParams)
                                    end

                                    local distMultiplier = 1
                                    local mode = "Safety"
                                    local adjust = 0

                                    if mode == "Safety" then
                                        adjust = 20
                                    elseif mode == "Close Call" then
                                        adjust = -20
                                    end

                                    local adjustedDistance = EntityDistances[v.Name] + adjust
                                    local distanceToEntity = (PredictionPosition - hrp.Position).Magnitude

                                    if not Raycast and distanceToEntity <= (adjustedDistance * distMultiplier) then
                                        entityInRange = true
                                        local Prompt = GetHiding()
                                        if Prompt then
                                            pcall(function()
                                                fireproximityprompt(Prompt)
                                            end)
                                        end
                                        break
                                    end
                                end
                            end

                            local char = LocalPlayer.Character
                            if char and not entityInRange and char:GetAttribute("Hiding") then
                                char:SetAttribute("Hiding", false)
                            end
                        end
                    end
                end
            end))
        else
            for _, conn in ipairs(Connections) do
                conn:Disconnect()
            end
            Connections = {}
        end
    end
})

local Dropdown = Tab10:Dropdown({
    Title = "自动隐藏模式",
    Desc = "",
    Locked = false,
    Values = {"Safety", "Close Call"},
    Default = "Safety",
    Callback = function(Value) end
})

local Slider = Tab10:Slider({
    Title = "预测时间",
    Value = {
        Min = 0.1,
        Max = 1.5,
        Default = 1.5,
    },
    Increment = 0.1,
    Callback = function(Value) end
})

local Slider = Tab10:Slider({
    Title = "距离倍数",
    Value = {
        Min = 1,
        Max = 1.5,
        Default = 1,
    },
    Increment = 0.1,
    Callback = function(Value) end
})

local Tab11 = Tabs.Main:Tab({
    Title = "请捐赠",
    Icon = "layout-grid",
    Locked = false,
})
local autoThanks = false
local thanksMessages = {
    "谢谢爸爸捐赠!",
    "感谢爸爸支持!",
    "谢谢爸爸捐赠!"
}
local Toggle = Tab11:Toggle({
    Title = "捐赠自动感谢",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        autoThanks = Value
        if Value then
            game.Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
                if autoThanks then
                    local randomMsg = thanksMessages[math.random(1, #thanksMessages)]
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(randomMsg, "All")
                end
            end)
        end
    end
})

local antiAFK = false
local Toggle = Tab11:Toggle({
    Title = "防止AFK",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        antiAFK = Value
        if Value then
            local VirtualInputManager = game:GetService("VirtualInputManager")
            task.spawn(function()
                while antiAFK do
                    task.wait(30)
                    VirtualInputManager:SendKeyEvent(true, "W", false, game)
                    task.wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, "W", false, game)
                end
            end)
        end
    end
})

local autoTalk = false
local talkInterval = 60 
local talkMessages = {
    "欢迎来到我的摊位!",
    "请支持我",
    "请多多捐赠支持!",
    "我是最好的!",
    "谢谢大家的支持!"
}

local Toggle = Tab11:Toggle({
    Title = "自动说话",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        autoTalk = Value
        if Value then
            task.spawn(function()
                while autoTalk do
                    for i = 1, 5 do 
                        if not autoTalk then break end
                        local randomMsg = talkMessages[math.random(1, #talkMessages)]
                        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(randomMsg, "All")
                        task.wait(1) 
                    end
                    task.wait(talkInterval - 5) 
                end
            end)
        end
    end
})

local Slider = Tab11:Slider({
    Title = "说话间隔(秒)",
    Desc = "",
    Locked = false,
    Value = {
        Min = 10,
        Max = 300,
        Default = 60,
    },
    Increment = 1,
    Callback = function(Value)
        talkInterval = Value
    end
})

local Tab12 = Tabs.Main:Tab({
    Title = "元素力量大亨",
    Icon = "layout-grid",
    Locked = false,
})

local setting = setting or {
    autobuild = false,
    autocollect = false,
    autocollectcrate = false,
    autocollectdollar = false,
    autocollectchest = false
}

local Toggle = Tab12:Toggle({
    Title = "自动建造",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        setting.autobuild = state
        task.spawn(function()
            while setting.autobuild and task.wait() do
                for _,v in next,workspace.Tycoons:GetChildren() do
                    if v.Name == game.Players.LocalPlayer.Name then
                        for _,a in next,v.Buttons:GetChildren() do
                            if a.Button.Color == Color3.fromRGB(0,127,0) then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a.Button.CFrame
                            end
                        end
                    end
                end
            end
        end)
    end
})

local Toggle = Tab12:Toggle({
    Title = "自动收集钱",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        setting.autocollect = state
        task.spawn(function()
            while setting.autocollect and task.wait(5) do
                for _,v in next,workspace.Tycoons:GetChildren() do
                    if v.Name == game.Players.LocalPlayer.Name then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Auxiliary.Collector.Collect.CFrame
                    end
                end
            end
        end)
    end
})

local Toggle = Tab12:Toggle({
    Title = "自动收集钱箱",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        setting.autocollectcrate = state
        task.spawn(function()
            while setting.autocollectcrate and task.wait() do
                for _,v in next,workspace:GetChildren() do
                    if v.Name == "BalloonCrate" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Crate.CFrame
                        fireproximityprompt(v.Crate.ProximityPrompt)
                    end
                end
            end
        end)
    end
})

local Toggle = Tab12:Toggle({
    Title = "自动收集boss掉的钱",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        setting.autocollectdollar = state
        task.spawn(function()
            while setting.autocollectdollar and task.wait() do
                for _,v in next,workspace:GetChildren() do
                    if v.Name == "Dollar" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    end
                end
            end
        end)
    end
})

local Toggle = Tab12:Toggle({
    Title = "自动收集宝箱",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(state)
        setting.autocollectchest = state
        task.spawn(function()
            while setting.autocollectchest and task.wait() do
                for _, v in pairs(workspace.Treasure.Chests:GetChildren()) do
                    if v.Name == "Chest" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        fireproximityprompt(v.ProximityPrompt)
                    end
                end
            end
        end)
    end
})

local Button = Tab12:Button({
    Title = "传送一次中心",
    Desc = "",
    Locked = false,
    Callback = function()
        local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Center.CFrame
        wait(0.3)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
    end
})

local Tab13 = Tabs.Main:Tab({
    Title = "元素大战脑红",
    Icon = "layout-grid",
    Locked = false,
})

local _G = _G or getgenv()
local DistanceForKillAura = 20
local DefaultKillAuraDistance = 20

local Toggle = Tab13:Toggle({
    Title = "杀戮光环",
    Desc = "",
    Locked = false,
    Default = false,
    Callback = function(Value)
        _G.AutoAttack = Value
        if Value then
            local RS = game:GetService("ReplicatedStorage")
            local Event = RS.Remotes.AttacksServer.WeaponAttack
            local Players = game:GetService("Players")
            local Player = Players.LocalPlayer
            local Char = Player.Character or Player.CharacterAdded:Wait()
            local HRP = Char:WaitForChild("HumanoidRootPart")

            Player.CharacterAdded:Connect(function(c)
                Char = c
                HRP = c:WaitForChild("HumanoidRootPart")
            end)

            task.spawn(function()
                while _G.AutoAttack do
                    local targets = {}
                    for _, mob in ipairs(workspace.ScriptedMap.Brainrots:GetChildren()) do
                        local pp = mob.PrimaryPart or mob:FindFirstChild("HumanoidRootPart")
                        if pp and (pp.Position - HRP.Position).Magnitude <= DistanceForKillAura then
                            table.insert(targets, mob.Name)
                        end
                    end
                    if #targets > 0 then
                        Event:FireServer(targets)
                    end
                    task.wait()
                end
            end)
        end
    end
})

local Slider = Tab13:Slider({
    Title = "攻击范围[20默认]",
    Desc = "",
    Locked = false,
    Value = {
        Min = 1,
        Max = 100,
        Default = 20,
    },
    Increment = 1,
    Callback = function(Value)
        DistanceForKillAura = Value
    end
})
