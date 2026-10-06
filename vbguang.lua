local Mitea = loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/狐狸ui.lua"))()

local win = Mitea:Window("Mitea骑宠物")
local tab = win:Tab("关于")
tab:Button("作者欧南", function()
    setclipboard("QQ1693323219")
end)
tab:Button("点我复制作者QQ", function()
    setclipboard("1693323219")
end)

local tab2 = win:Tab("抓蛋")

tab2:Label("注意先骑上宠物不然可能蛋会在中途掉落")

local function isInPlots(obj)
    local parent = obj.Parent
    while parent do
        if parent.Name == "Plots" then
            return true
        end
        parent = parent.Parent
    end
    return false
end

local function getCollectPos()
    local plots = workspace:FindFirstChild("Plots")
    local plot = plots and plots:FindFirstChild("Plot")
    local baseplate = plot and plot:FindFirstChild("Baseplate")
    if baseplate and baseplate:IsA("BasePart") then
        return baseplate.Position + Vector3.new(0, 5, 0)
    end
    return nil
end

local function getHatchPos()
    local plots = workspace:FindFirstChild("Plots")
    local plot = plots and plots:FindFirstChild("Plot")
    local hatch = plot and plot:FindFirstChild("HatchUpgrade")
    local screen = hatch and hatch:FindFirstChild("Screen")
    if screen then
        if screen:IsA("BasePart") then
            return screen.Position
        elseif screen:IsA("Model") then
            local primary = screen.PrimaryPart or screen:FindFirstChildWhichIsA("BasePart")
            if primary then
                return primary.Position
            end
        end
    end
    return nil
end

tab2:Button("一键抓取全部蛋", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local eggNames = {
            "Bloom Egg",
            "Galaxy Egg",
            "Sinister Egg",
            "Blackhole Egg",
            "Cherub Egg",
            "Solaris Egg",
            "Soul Egg",
            "Tidal Egg"
        }
        
        local function processEgg(eggName)
            local target
            for _, egg in pairs(workspace:GetDescendants()) do
                if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == eggName and not isInPlots(egg) then
                    target = egg
                    break
                end
            end
            
            if not target then return false end
            
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
            
            task.wait(0.5)
            
            return true
        end
        
        for _, eggName in ipairs(eggNames) do
            processEgg(eggName)
        end
    end)
end)

tab2:Button("绽放蛋 抓取", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local target
        for _, egg in pairs(workspace:GetDescendants()) do
            if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == "Bloom Egg" and not isInPlots(egg) then
                target = egg
                break
            end
        end
        
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
        end
    end)
end)

tab2:Button("银河蛋 抓取", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local target
        for _, egg in pairs(workspace:GetDescendants()) do
            if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == "Galaxy Egg" and not isInPlots(egg) then
                target = egg
                break
            end
        end
        
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
        end
    end)
end)

tab2:Button("邪恶蛋 抓取", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local target
        for _, egg in pairs(workspace:GetDescendants()) do
            if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == "Sinister Egg" and not isInPlots(egg) then
                target = egg
                break
            end
        end
        
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
        end
    end)
end)

tab2:Button("黑洞蛋 抓取", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local target
        for _, egg in pairs(workspace:GetDescendants()) do
            if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == "Blackhole Egg" and not isInPlots(egg) then
                target = egg
                break
            end
        end
        
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
        end
    end)
end)

tab2:Button("智天使蛋 抓取", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local target
        for _, egg in pairs(workspace:GetDescendants()) do
            if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == "Cherub Egg" and not isInPlots(egg) then
                target = egg
                break
            end
        end
        
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
        end
    end)
end)

tab2:Button("太阳蛋 抓取", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local target
        for _, egg in pairs(workspace:GetDescendants()) do
            if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == "Solaris Egg" and not isInPlots(egg) then
                target = egg
                break
            end
        end
        
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
        end
    end)
end)

tab2:Button("灵魂蛋 抓取", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local target
        for _, egg in pairs(workspace:GetDescendants()) do
            if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == "Soul Egg" and not isInPlots(egg) then
                target = egg
                break
            end
        end
        
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
        end
    end)
end)

tab2:Button("潮汐蛋 抓取", function()
    task.spawn(function()
        local LocalPlayer = game.Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        local target
        for _, egg in pairs(workspace:GetDescendants()) do
            if (egg:IsA("BasePart") or egg:IsA("Model")) and egg.Name == "Tidal Egg" and not isInPlots(egg) then
                target = egg
                break
            end
        end
        
        if target then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local eggPart = target:IsA("Model") and (target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")) or target
                if eggPart then
                    character.HumanoidRootPart.CFrame = eggPart.CFrame + Vector3.new(0, 3, 0)
                end
            end
            
            task.wait(0.3)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.5)
            
            local hatchPos = getHatchPos()
            if hatchPos then
                local character2 = LocalPlayer.Character
                if character2 and character2:FindFirstChild("HumanoidRootPart") then
                    character2.HumanoidRootPart.CFrame = CFrame.new(hatchPos + Vector3.new(0, 3, 0))
                end
            end
            
            task.wait(0.3)
            
            if ReplicatedStorage:FindFirstChild("Remotes") then
                local Game = ReplicatedStorage.Remotes:FindFirstChild("Game")
                if Game and Game:FindFirstChild("BasketDrop") then
                    pcall(function()
                        Game.BasketDrop:FireServer()
                    end)
                end
            end
            
            task.wait(0.65)
            
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    pcall(function()
                        fireproximityprompt(descendant)
                    end)
                end
            end
            
            task.wait(0.3)
            
            local collectPos = getCollectPos()
            if collectPos then
                local character3 = LocalPlayer.Character
                if character3 and character3:FindFirstChild("HumanoidRootPart") then
                    character3.HumanoidRootPart.CFrame = CFrame.new(collectPos)
                end
            end
        end
    end)
end)

local tab3 = win:Tab("其他工具")

tab3:Button("随机色图", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/王者se.lua"))()
end)
