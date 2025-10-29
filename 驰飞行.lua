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


local backgroundColor = Color3.fromRGB(255, 255, 0)      
local buttonColor = Color3.fromRGB(255, 255, 0)         
local accentColor = Color3.fromRGB(255, 255, 0)         
local textColor = Color3.fromRGB(40, 40, 40)         

-- 设置主GUI
main.Name = "main" 
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") 
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
main.ResetOnSpawn = false 

-- 创建主框架
Frame.Parent = main 
Frame.BackgroundColor3 = backgroundColor
Frame.BorderColor3 = accentColor
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

-- 向上飞行按钮
up.Name = "up" 
up.Parent = Frame 
up.BackgroundColor3 = buttonColor
up.Size = UDim2.new(0, 44, 0, 28) 
up.Font = Enum.Font.SourceSans 
up.Text = "上升" 
up.TextColor3 = textColor
up.TextSize = 14.000 

-- 向下飞行按钮
down.Name = "down" 
down.Parent = Frame 
down.BackgroundColor3 = buttonColor
down.Position = UDim2.new(0, 0, 0.491228074, 0) 
down.Size = UDim2.new(0, 44, 0, 28) 
down.Font = Enum.Font.SourceSans 
down.Text = "下降" 
down.TextColor3 = textColor
down.TextSize = 14.000 

-- 飞行开关按钮
onof.Name = "onof" 
onof.Parent = Frame 
onof.BackgroundColor3 = accentColor
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0) 
onof.Size = UDim2.new(0, 56, 0, 28) 
onof.Font = Enum.Font.SourceSans 
onof.Text = "飞行" 
onof.TextColor3 = textColor
onof.TextSize = 14.000 

-- 标题标签
TextLabel.Parent = Frame 
TextLabel.BackgroundColor3 = accentColor
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0) 
TextLabel.Size = UDim2.new(0, 100, 0, 28) 
TextLabel.Font = Enum.Font.SourceSans 
TextLabel.Text = "驰飞行"  
TextLabel.TextColor3 = textColor
TextLabel.TextScaled = true 
TextLabel.TextSize = 14.000 
TextLabel.TextWrapped = true 

-- 加速按钮
plus.Name = "plus" 
plus.Parent = Frame 
plus.BackgroundColor3 = buttonColor
plus.Position = UDim2.new(0.231578946, 0, 0, 0) 
plus.Size = UDim2.new(0, 45, 0, 28) 
plus.Font = Enum.Font.SourceSans 
plus.Text = "+" 
plus.TextColor3 = textColor
plus.TextScaled = true 
plus.TextSize = 14.000 
plus.TextWrapped = true 

-- 速度显示标签
speed.Name = "speed" 
speed.Parent = Frame 
speed.BackgroundColor3 = accentColor
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0) 
speed.Size = UDim2.new(0, 44, 0, 28) 
speed.Font = Enum.Font.SourceSans 
speed.Text = "1" 
speed.TextColor3 = textColor
speed.TextScaled = true 
speed.TextSize = 14.000 
speed.TextWrapped = true 

-- 减速按钮
mine.Name = "mine" 
mine.Parent = Frame 
mine.BackgroundColor3 = buttonColor
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0) 
mine.Size = UDim2.new(0, 45, 0, 29) 
mine.Font = Enum.Font.SourceSans 
mine.Text = "-" 
mine.TextColor3 = textColor
mine.TextScaled = true 
mine.TextSize = 14.000 
mine.TextWrapped = true 

-- 关闭按钮
closebutton.Name = "Close" 
closebutton.Parent = main.Frame 
closebutton.BackgroundColor3 = Color3.fromRGB(255, 247, 0)  
closebutton.Font = "SourceSans" 
closebutton.Size = UDim2.new(0, 45, 0, 28) 
closebutton.Text = "关闭" 
closebutton.TextColor3 = textColor
closebutton.TextSize = 30 
closebutton.Position = UDim2.new(0, 0, -1, 27) 

-- 最小化按钮
mini.Name = "minimize" 
mini.Parent = main.Frame 
mini.BackgroundColor3 = buttonColor
mini.Font = "SourceSans" 
mini.Size = UDim2.new(0, 45, 0, 28) 
mini.Text = "缩小" 
mini.TextColor3 = textColor
mini.TextSize = 30 
mini.Position = UDim2.new(0, 44, -1, 27) 

-- 恢复按钮（最小化后显示）
mini2.Name = "minimize2" 
mini2.Parent = main.Frame 
mini2.BackgroundColor3 = buttonColor
mini2.Font = "SourceSans" 
mini2.Size = UDim2.new(0, 45, 0, 28) 
mini2.Text = "+" 
mini2.TextColor3 = textColor
mini2.TextSize = 40 
mini2.Position = UDim2.new(0, 44, -1, 57) 
mini2.Visible = false 

-- 初始化变量
speeds = 1  -- 飞行速度
local speaker = game:GetService("Players").LocalPlayer 
local chr = game.Players.LocalPlayer.Character 
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid") 
nowe = false  -- 飞行状态标志

-- 显示通知
game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "驰飞行系统",  -- 修改通知标题
    Text = "星驰专属飞行", 
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
}) 
Duration = 5

-- 使框架可拖动
Frame.Active = true 
Frame.Draggable = true 

-- 飞行开关功能
onof.MouseButton1Down:connect(function() 
    if nowe == true then 
        -- 关闭飞行模式
        nowe = false 
        onof.Text = "飞行"  -- 更新按钮文本
        onof.BackgroundColor3 = accentColor
        
        -- 重新启用所有人物状态
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
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true) 
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics) 
        
        -- 显示通知
        game:GetService("StarterGui"):SetCore("SendNotification", { 
            Title = "驰飞行", 
            Text = "飞行模式已关闭", 
            Duration = 2
        })
    else 
        -- 开启飞行模式
        nowe = true 
        onof.Text = "停止"  -- 更新按钮文本
        onof.BackgroundColor3 = Color3.fromRGB(25, 25, 122)  
        
        -- 创建多个飞行协程以实现平滑移动
        for i = 1, speeds do 
            spawn(function() 
                local hb = game:GetService("RunService").Heartbeat     
                tpwalking = true 
                local chr = game.Players.LocalPlayer.Character 
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid") 
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do 
                    if hum.MoveDirection.Magnitude > 0 then 
                        chr:TranslateBy(hum.MoveDirection)
                    end 
                end 
            end) 
        end 
        
        -- 禁用动画
        game.Players.LocalPlayer.Character.Animate.Disabled = true 
        local Char = game.Players.LocalPlayer.Character 
        local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController") 
        
        -- 停止所有动画
        for i,v in next, Hum:GetPlayingAnimationTracks() do 
            v:AdjustSpeed(0) 
        end 
        
        -- 禁用所有人物状态
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
        
        -- 显示通知
        game:GetService("StarterGui"):SetCore("SendNotification", { 
            Title = "驰飞行", 
            Text = "飞行模式已开启 - 速度: " .. speeds, 
            Duration = 3
        })
    end 
    
    -- R6角色模型飞行系统
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then 
        -- R6飞行实现代码（与原始脚本相同）
        local plr = game.Players.LocalPlayer 
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
        game.Players.LocalPlayer.Character.Animate.Disabled = false 
        tpwalking = false 
    else 
        -- R15角色模型飞行系统
        local plr = game.Players.LocalPlayer 
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
        game.Players.LocalPlayer.Character.Animate.Disabled = false 
        tpwalking = false 
    end 
end) 

-- 向上移动功能
local tis 
up.MouseButton1Down:connect(function() 
    tis = up.MouseEnter:connect(function() 
        while tis do 
            wait() 
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0) 
        end 
    end) 
end) 

up.MouseLeave:connect(function() 
    if tis then 
        tis:Disconnect() 
        tis = nil 
    end 
end) 

-- 向下移动功能
local dis 
down.MouseButton1Down:connect(function() 
    dis = down.MouseEnter:connect(function() 
        while dis do 
            wait() 
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0) 
        end 
    end) 
end) 

down.MouseLeave:connect(function() 
    if dis then 
        dis:Disconnect() 
        dis = nil 
    end 
end) 

-- 角色重生时重置状态
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char) 
    wait(0.7) 
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false 
    game.Players.LocalPlayer.Character.Animate.Disabled = false 
    nowe = false
    onof.Text = "飞行"
    onof.BackgroundColor3 = accentColor
end) 

-- 加速功能
plus.MouseButton1Down:connect(function() 
    speeds = speeds + 1 
    speed.Text = speeds 
    if nowe == true then 
        tpwalking = false 
        for i = 1, speeds do 
            spawn(function() 
                local hb = game:GetService("RunService").Heartbeat     
                tpwalking = true 
                local chr = game.Players.LocalPlayer.Character 
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

-- 减速功能
mine.MouseButton1Down:connect(function() 
    if speeds == 1 then 
        speed.Text = '速度不能小于1' 
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
                    local chr = game.Players.LocalPlayer.Character 
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

-- 关闭按钮功能
closebutton.MouseButton1Click:Connect(function() 
    main:Destroy() 
end) 

-- 最小化功能
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
    closebutton.Position = UDim2.new(0, 0, -1, 57) 
end) 

-- 恢复功能
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
    closebutton.Position = UDim2.new(0, 0, -1, 27) 
end)

print("驰飞行系统加载完成！")