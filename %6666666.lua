local player = game.Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")

local character = player.Character or player.CharacterAdded:Wait()
local head = character:WaitForChild("Head")

TextChatService:DisplayBubble(head, "欢迎使用波塞冬盲射")

local OrionLib =loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/8edafd08cdee67bf67767c61543bbf253e78f644/-%2B676464.lua"))()
local Window = OrionLib:MakeWindow({
Name = "波塞冬盲射", 
HidePremium = false, 
SaveConfig = true,
IntroText = "波塞冬盲射", 
ConfigFolder = "波塞冬脚本"
})

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "欢迎使用波塞冬盲射"; Text ="波塞冬脚本"; Duration = 4; })

local about = Window:MakeTab({
    Name = "信息",
    PremiumOnly = false

})

about:AddParagraph("作者: 波塞冬")
about:AddParagraph("作者qq: 1693323219")

about:AddButton({
	Name = "复制作者QQ",
	Callback = function()
     setclipboard("1693323219")
  	end
})

about:AddParagraph("您的用户名:"," "..game.Players.LocalPlayer.Name.."")
about:AddParagraph("您的注入器:"," "..identifyexecutor().."")
about:AddParagraph("您当前服务器的ID"," "..game.GameId.."")

local Tab = Window:MakeTab({
    Name = "盲射",
    PremiumOnly = false
})

OrionLib:MakeNotification({
	Name = "新月脚本",
	Content = "欢迎使用新月脚本中心",
	Time = 2

})

Tab:AddToggle({
    Name = "透视",
    Default = false,
    Callback = function(enabled)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        
        local BEAM_NAME = "ForcedBlueBeam"
        local BEAM_COLOR = Color3.fromRGB(0, 0, 255)
        local BEAM_LENGTH = 50
        
        local function ensureBlueBeam(ponto: BasePart)
            local attachment0 = ponto:FindFirstChild("BeamAttachment0")
            if not attachment0 then
                attachment0 = Instance.new("Attachment")
                attachment0.Name = "BeamAttachment0"
                attachment0.Position = Vector3.zero
                attachment0.Parent = ponto
            end

            local attachment1 = ponto:FindFirstChild("BeamAttachment1")
            if not attachment1 then
                attachment1 = Instance.new("Attachment")
                attachment1.Name = "BeamAttachment1"
                attachment1.Parent = ponto
            end

            attachment1.Position = Vector3.new(0, 0, BEAM_LENGTH)

            local beam = ponto:FindFirstChild(BEAM_NAME)
            if not beam then
                beam = Instance.new("Beam")
                beam.Name = BEAM_NAME
                beam.Attachment0 = attachment0
                beam.Attachment1 = attachment1
                beam.Width0 = 0.2
                beam.Width1 = 0.2
                beam.FaceCamera = true
                beam.Parent = ponto
            end

            beam.Enabled = enabled
            beam.Color = ColorSequence.new(BEAM_COLOR)
            beam.Transparency = NumberSequence.new(0)
            beam.LightEmission = 1
            beam.LightInfluence = 0
        end

        local function enforceVisibility(character: Model)
            for _, descendant in character:GetDescendants() do
                if descendant:IsA("BasePart") then
                    if descendant.Name ~= "HumanoidRootPart" and descendant.Name ~= "hitbox" then
                        descendant.Transparency = enabled and 0 or descendant.OriginalTransparency
                    end

                    if descendant.Name == "ponto" and enabled then
                        ensureBlueBeam(descendant)
                    end
                end
            end
        end
        
        if enabled then
            for _, player in Players:GetPlayers() do
                local character = player.Character
                if character then
                    for _, descendant in character:GetDescendants() do
                        if descendant:IsA("BasePart") then
                            if not descendant:GetAttribute("OriginalTransparency") then
                                descendant:SetAttribute("OriginalTransparency", descendant.Transparency)
                            end
                        end
                    end
                end
            end
            
            local connection = RunService.Heartbeat:Connect(function()
                for _, player in Players:GetPlayers() do
                    local character = player.Character
                    if character then
                        enforceVisibility(character)
                    end
                end
            end)
            
            getgenv().BlindShotConnection = connection
            
        else
            if getgenv().BlindShotConnection then
                getgenv().BlindShotConnection:Disconnect()
                getgenv().BlindShotConnection = nil
            end
            
            for _, player in Players:GetPlayers() do
                local character = player.Character
                if character then
                    for _, descendant in character:GetDescendants() do
                        if descendant:IsA("BasePart") then
                            local originalTransparency = descendant:GetAttribute("OriginalTransparency")
                            if originalTransparency then
                                descendant.Transparency = originalTransparency
                            end
                            descendant:SetAttribute("OriginalTransparency", nil)
                        end
                    end
                    
                    for _, descendant in character:GetDescendants() do
                        if descendant.Name == BEAM_NAME then
                            descendant:Destroy()
                        end
                        if descendant.Name == "BeamAttachment0" or descendant.Name == "BeamAttachment1" then
                            descendant:Destroy()
                        end
                    end
                end
            end
        end
    end
})

Tab:AddToggle({
    Name = "穿墙",
    Default = false,
    Callback = function(Value)
        NoclipEnabled = Value
    end
})

Tab:AddToggle({
	Name = "无限跳",
	Default = false,
	Callback = function(enabled)
		getgenv().InfJ = enabled
		game:GetService("UserInputService").JumpRequest:Connect(function()
			if getgenv().InfJ == true then
				local character = game:GetService("Players").LocalPlayer.Character
				if character then
					local humanoid = character:FindFirstChildOfClass("Humanoid")
					if humanoid then
						humanoid:ChangeState("Jumping")
					end
				end
			end
		end)
	end
})