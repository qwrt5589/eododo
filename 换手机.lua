local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = ReplicatedStorage:FindFirstChild("19248c186af89987d4a04a1284335f22")

if remoteEvent then
    while true do
        remoteEvent:FireServer()
        task.wait(0.01)  
    end
else
    warn("未找到远程事件: 19248c186af89987d4a04a1284335f22")
end