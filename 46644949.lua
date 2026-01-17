local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local dragGoal = workspace.Areas.Area_001_Lobby.DragArea.DragGoal
local player = Players.LocalPlayer 

if not player then return end
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local connection
connection = RunService.Heartbeat:Connect(function()
    if humanoidRootPart and dragGoal then
        dragGoal.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 5, 0) 
    else
        connection:Disconnect() 
    end
end)

