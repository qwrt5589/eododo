local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "XC-Ultimate<font color='#FF6B6B'>xc</font>",
    Icon = "rbxassetid://4483362748",
    IconTransparency = 0.5,
    IconThemed = true,
    Author = "作者:星驰",
    Folder = "TangXianHub",
    Size = UDim2.fromOffset(600, 500),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("用户信息点击") end,
        Anonymous = false
    },
    Background = "rbxassetid://116632924535489"
})

-- 标签
Window:Tag({
    Title = "XC-Ultimate河北唐县",
    Color = Color3.fromHex("#FF6B6B")
})

Window:Tag({
    Title = "职业切换",
    Color = Color3.fromHex("#4ECDC4")
})

local TimeTag = Window:Tag({
    Title = "就绪",
    Color = Color3.fromHex("#45B7D1")
})

-- 通知
WindUI:Notify({
    Title = "河北唐县脚本已加载",
    Content = "XC-Ultimate",
    Duration = 6,
    Icon = "map-pin",
})

-- 创建功能栏
local Tabs = {
    AutoFarm = Window:Section({ Title = "自动功能", Opened = true }),
    Jobs = Window:Section({ Title = "职业切换", Opened = false }),
    Teleport = Window:Section({ Title = "地点传送", Opened = false }),
    Player = Window:Section({ Title = "玩家增强", Opened = false })
}

-- 自动功能标签页
local AutoFarmTab = Tabs.AutoFarm:Tab({
    Title = "自动刷钱",
    Icon = "dollar-sign",
    Locked = false,
})

-- 自动刷钱功能
AutoFarmTab:Toggle({
    Title = "自动刷钱",
    Description = "自动送货刷钱",
    Callback = function(value)
        _G.autoFarm = value
        
        if value then
            WindUI:Notify({
                Title = "自动刷钱开启",
                Content = "开始自动送货刷钱",
                Duration = 3,
                Icon = "refresh-cw",
            })
            
            -- 启动自动刷钱
            spawn(function()
                local virtualUser = game:GetService('VirtualUser')
                virtualUser:CaptureController()
                
                function teleportTo(CFrame)
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame
                    end
                end
                
                while _G.autoFarm do
                    pcall(function()
                        -- 点击包裹堆
                        if game:GetService("Workspace").DeliverySys.Misc["Package Pile"] and game:GetService("Workspace").DeliverySys.Misc["Package Pile"]:FindFirstChild("ClickDetector") then
                            fireclickdetector(game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector)
                        end
                        task.wait(2.2)
                        
                        -- 传送到送货点
                        for _, point in pairs(game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()) do
                            if point:FindFirstChild("Locate") and point.Locate:FindFirstChild("Locate") and point.Locate.Locate.Enabled then
                                teleportTo(point.CFrame)
                                break
                            end
                        end
                    end)
                    task.wait(0.5)
                end
            end)
        else
            WindUI:Notify({
                Title = "自动刷钱关闭",
                Content = "已停止自动刷钱",
                Duration = 3,
                Icon = "square",
            })
        end
    end
})

-- 职业切换标签页
local JobsTab = Tabs.Jobs:Tab({
    Title = "职业系统",
    Icon = "briefcase",
    Locked = false,
})

-- 职业切换按钮
JobsTab:Button({
    Title = "变成警察",
    Desc = "需要先购买警察通行证",
    Locked = false,
    Callback = function()
        local args = {[1] = "Police"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到警察职业",
            Duration = 3,
            Icon = "user-check",
        })
    end
})

JobsTab:Button({
    Title = "变成平民",
    Desc = "切换回平民身份",
    Locked = false,
    Callback = function()
        local args = {[1] = "Civilian"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到平民职业",
            Duration = 3,
            Icon = "user",
        })
    end
})

JobsTab:Button({
    Title = "变成混合冰淇淋",
    Desc = "蜜雪冰城员工",
    Locked = false,
    Callback = function()
        local args = {[1] = "Mixue Ice Cream"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到蜜雪冰城员工",
            Duration = 3,
            Icon = "ice-cream",
        })
    end
})

JobsTab:Button({
    Title = "变成咖啡师",
    Desc = "Teawen咖啡师",
    Locked = false,
    Callback = function()
        local args = {[1] = "Teawen Barista"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到咖啡师",
            Duration = 3,
            Icon = "coffee",
        })
    end
})

JobsTab:Button({
    Title = "变成送货司机",
    Desc = "送货司机职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Delivery Driver"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到送货司机",
            Duration = 3,
            Icon = "truck",
        })
    end
})

JobsTab:Button({
    Title = "变成出租车司机",
    Desc = "出租车司机职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Taxi Driver"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到出租车司机",
            Duration = 3,
            Icon = "car",
        })
    end
})

JobsTab:Button({
    Title = "变成线上计程车",
    Desc = "Ole在线出租车",
    Locked = false,
    Callback = function()
        local args = {[1] = "Ole Online Taxi Sharing"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到线上计程车",
            Duration = 3,
            Icon = "navigation",
        })
    end
})

JobsTab:Button({
    Title = "变成卡车司机",
    Desc = "卡车司机职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Trucker"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到卡车司机",
            Duration = 3,
            Icon = "truck",
        })
    end
})

JobsTab:Button({
    Title = "变成超市收银员",
    Desc = "超市收银员职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Grocery Cashier"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到超市收银员",
            Duration = 3,
            Icon = "shopping-cart",
        })
    end
})

JobsTab:Button({
    Title = "变成罪犯",
    Desc = "罪犯职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Criminal"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到罪犯",
            Duration = 3,
            Icon = "alert-triangle",
        })
    end
})

JobsTab:Button({
    Title = "变成学生",
    Desc = "学生职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Student"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到学生",
            Duration = 3,
            Icon = "book",
        })
    end
})

JobsTab:Button({
    Title = "变成老师",
    Desc = "教师职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Teacher"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到老师",
            Duration = 3,
            Icon = "graduation-cap",
        })
    end
})

JobsTab:Button({
    Title = "变成商店员工",
    Desc = "商店员工职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Store Worker"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到商店员工",
            Duration = 3,
            Icon = "shopping-bag",
        })
    end
})

JobsTab:Button({
    Title = "变成变pao商店工人",
    Desc = "变pao商店工人",
    Locked = false,
    Callback = function()
        local args = {[1] = "Pao Store Worker"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到变pao商店工人",
            Duration = 3,
            Icon = "package",
        })
    end
})

JobsTab:Button({
    Title = "变成救援人员",
    Desc = "医护人员职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Paramedic"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到救援人员",
            Duration = 3,
            Icon = "heart",
        })
    end
})

JobsTab:Button({
    Title = "变成巴车司机",
    Desc = "公交车司机职业",
    Locked = false,
    Callback = function()
        local args = {[1] = "Bus Driver"}
        game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))
        WindUI:Notify({
            Title = "职业切换",
            Content = "已切换到巴车司机",
            Duration = 3,
            Icon = "bus",
        })
    end
})

-- 地点传送标签页
local TeleportTab = Tabs.Teleport:Tab({
    Title = "地点传送",
    Icon = "map",
    Locked = false,
})

TeleportTab:Button({
    Title = "警察局",
    Desc = "传送到警察局",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5513.97412109375, 8.656171798706055, 4964.291015625)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到警察局",
            Duration = 2,
            Icon = "map-pin",
        })
    end
})

TeleportTab:Button({
    Title = "出生点",
    Desc = "传送到出生点",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3338.31982421875, 10.048742294311523, 3741.84033203125)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到出生点",
            Duration = 2,
            Icon = "home",
        })
    end
})

TeleportTab:Button({
    Title = "医院",
    Desc = "传送到医院",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5471.482421875, 14.149418830871582, 4259.75341796875)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到医院",
            Duration = 2,
            Icon = "heart",
        })
    end
})

TeleportTab:Button({
    Title = "手机店",
    Desc = "传送到手机店",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6789.2041015625, 11.197686195373535, 1762.687255859375)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到手机店",
            Duration = 2,
            Icon = "smartphone",
        })
    end
})

TeleportTab:Button({
    Title = "火锅店",
    Desc = "传送到火锅店",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5912.84765625, 12.217276573181152, 1058.29443359375)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到火锅店",
            Duration = 2,
            Icon = "utensils",
        })
    end
})

TeleportTab:Button({
    Title = "蜜雪冰城",
    Desc = "传送到蜜雪冰城",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6984.87158203125, 9.332854270935059, 1734.770751953125)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到蜜雪冰城",
            Duration = 2,
            Icon = "ice-cream",
        })
    end
})

TeleportTab:Button({
    Title = "小区",
    Desc = "传送到小区",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2187.541259765625, 22.092992782592773, -636.7048950195312)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到小区",
            Duration = 2,
            Icon = "building",
        })
    end
})

TeleportTab:Button({
    Title = "洗车店",
    Desc = "传送到洗车店",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2578.51025390625, 23.332923889160156, -588.5584716796875)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到洗车店",
            Duration = 2,
            Icon = "car",
        })
    end
})

TeleportTab:Button({
    Title = "卡车召唤地",
    Desc = "传送到卡车召唤地",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10559.13671875, 39.31748580932617, 3236.519287109375)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到卡车召唤地",
            Duration = 2,
            Icon = "truck",
        })
    end
})

TeleportTab:Button({
    Title = "庆都山山顶",
    Desc = "传送到庆都山山顶",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15042.9033203125, 325.29852294921875, 22355.177734375)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到庆都山山顶",
            Duration = 2,
            Icon = "mountain",
        })
    end
})

TeleportTab:Button({
    Title = "庆都山山底",
    Desc = "传送到庆都山山底",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15580.1357421875, 8.09992790222168, 21171.939453125)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到庆都山山底",
            Duration = 2,
            Icon = "mountain",
        })
    end
})

TeleportTab:Button({
    Title = "小学",
    Desc = "传送到小学",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13888.138671875, 10.943490982055664, 11059.0458984375)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到小学",
            Duration = 2,
            Icon = "school",
        })
    end
})

TeleportTab:Button({
    Title = "签挂美食",
    Desc = "传送到签挂美食",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10332.763671875, 10.43997859954834, 7114.16064453125)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到签挂美食",
            Duration = 2,
            Icon = "utensils",
        })
    end
})

TeleportTab:Button({
    Title = "驾校",
    Desc = "传送到驾校",
    Locked = false,
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8912.12109375, 9.963741302490234, 7302.568359375)
        WindUI:Notify({
            Title = "传送成功",
            Content = "已传送到驾校",
            Duration = 2,
            Icon = "car",
        })
    end
})

-- 玩家增强标签页
local PlayerTab = Tabs.Player:Tab({
    Title = "玩家设置",
    Icon = "user",
    Locked = false,
})

PlayerTab:Slider({
    Title = "移动速度",
    Value = { Min = 16, Max = 200, Default = 16 },
    Increment = 1,
    Callback = function(value)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
        end
    end
})

PlayerTab:Slider({
    Title = "跳跃高度",
    Value = { Min = 50, Max = 200, Default = 50 },
    Increment = 1,
    Callback = function(value)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
        end
    end
})

PlayerTab:Toggle({
    Title = "无限跳跃",
    Description = "在空中也能跳跃",
    Callback = function(value)
        _G.InfiniteJump = value
        if value then
            game:GetService("UserInputService").JumpRequest:connect(function()
                if _G.InfiniteJump then
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end)
        end
    end
})

-- 默认选择第一个标签页
Window:SelectTab(1)

WindUI:Notify({
    Title = "河北唐县脚本加载完成",
    Content = "XC-Ultimate",
    Duration = 4,
    Icon = "check-circle",
})