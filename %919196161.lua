local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
print("长青AI")

local ZHIPU_API_KEY = "f2ec0174b85a4ddd9f67342d2837805e.dCs6I4QKXIksbMdZ"
local ZHIPU_API_URL = "https://open.bigmodel.cn/api/paas/v4/chat/completions"

local GLM_MODELS = {
    ["glm-4"] = "GLM-4（标准版）",
    ["glm-4-plus"] = "GLM-4 Plus（增强版）",
    ["glm-4-air"] = "GLM-4 Air（轻量快速）",
    ["glm-4-flash"] = "GLM-4 Flash（极速版）",
    ["glm-4-long"] = "GLM-4 Long（长文本版）",
    ["glm-4-7b"] = "GLM-4 7B（轻量版）"
}
local CURRENT_MODEL = "glm-4"
local API_ENABLED = false

local Scripts = {
    ["皮脚本"] = 'print("皮脚本加载中...")',
    ["叶脚本"] = 'print("叶脚本启动")',
    ["测试"] = 'print("AI测试成功！") game:GetService("StarterGui"):SetCore("SendNotification", {Title="AI", Text="AI连接成功！", Duration=3})',
    ["截图"] = '-- 截图功能占位符'
}

local AI_AVATAR_ID = 127375664366255
local PLAYER_AVATAR_ID = 0

local ChatGUI = Instance.new("ScreenGui")
ChatGUI.Name = "AI_Assistant"
ChatGUI.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 350)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ChatGUI

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(220, 220, 220)
Border.Thickness = 1
Border.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 120, 0, 30)
TitleLabel.Position = UDim2.new(0, 15, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "长青AI助手"
TitleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-- 添加性格切换按钮
local PersonalityFrame = Instance.new("Frame")
PersonalityFrame.Size = UDim2.new(0, 160, 0, 30)
PersonalityFrame.Position = UDim2.new(0.5, -80, 0, 8)
PersonalityFrame.BackgroundTransparency = 1
PersonalityFrame.Parent = MainFrame

local NormalBtn = Instance.new("TextButton")
NormalBtn.Size = UDim2.new(0, 50, 0, 25)
NormalBtn.Position = UDim2.new(0, 0, 0, 0)
NormalBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
NormalBtn.Text = "正常"
NormalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NormalBtn.TextSize = 12
NormalBtn.Font = Enum.Font.SourceSansBold
NormalBtn.AutoButtonColor = true
NormalBtn.Parent = PersonalityFrame

local NormalCorner = Instance.new("UICorner")
NormalCorner.CornerRadius = UDim.new(0, 6)
NormalCorner.Parent = NormalBtn

local DajiBtn = Instance.new("TextButton")
DajiBtn.Size = UDim2.new(0, 50, 0, 25)
DajiBtn.Position = UDim2.new(0, 55, 0, 0)
DajiBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 200)
DajiBtn.Text = "妲己"
DajiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DajiBtn.TextSize = 12
DajiBtn.Font = Enum.Font.SourceSansBold
DajiBtn.AutoButtonColor = true
DajiBtn.Parent = PersonalityFrame

local DajiCorner = Instance.new("UICorner")
DajiCorner.CornerRadius = UDim.new(0, 6)
DajiCorner.Parent = DajiBtn

local AncientBtn = Instance.new("TextButton")
AncientBtn.Size = UDim2.new(0, 50, 0, 25)
AncientBtn.Position = UDim2.new(0, 110, 0, 0)
AncientBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
AncientBtn.Text = "古人"
AncientBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
AncientBtn.TextSize = 12
AncientBtn.Font = Enum.Font.SourceSansBold
AncientBtn.AutoButtonColor = true
AncientBtn.Parent = PersonalityFrame

local AncientCorner = Instance.new("UICorner")
AncientCorner.CornerRadius = UDim.new(0, 6)
AncientCorner.Parent = AncientBtn

-- 添加当前性格状态显示
local PersonalityStatus = Instance.new("TextLabel")
PersonalityStatus.Size = UDim2.new(0, 80, 0, 15)
PersonalityStatus.Position = UDim2.new(0.5, -40, 0, 30)
PersonalityStatus.BackgroundTransparency = 1
PersonalityStatus.Text = "正常模式"
PersonalityStatus.TextColor3 = Color3.fromRGB(100, 100, 100)
PersonalityStatus.TextSize = 10
PersonalityStatus.Font = Enum.Font.SourceSans
PersonalityStatus.TextXAlignment = Enum.TextXAlignment.Center
PersonalityStatus.Parent = PersonalityFrame

-- 定义不同性格的系统提示词
local PERSONALITIES = {
    ["normal"] = {
        name = "正常",
        systemPrompt = "你是AI助手，具备强大的语言理解和生成能力。\n" ..
                     "你可以：\n" ..
                     "1. 回答各种问题\n" ..
                     "2. 帮助管理Roblox脚本\n" ..
                     "3. 提供编程帮助\n" ..
                     "4. 保持回复详细、准确、有帮助、当用户不问你工程上的帮助时你可以用非常亲切的语气",
        bgColor = Color3.fromRGB(255, 255, 255),
        title = "长青AI助手",
        statusText = "正常模式",
        statusColor = Color3.fromRGB(100, 100, 100)
    },
    ["daji"] = {
        name = "妲己",
        systemPrompt = "你现在是苏妲己，封神演义中的千年狐妖。\n" ..
                     "说话风格：\n" ..
                     "1. 语气娇媚诱人，带着一丝慵懒和挑逗\n" ..
                     "2. 常用~、呢、啦等语气词\n" ..
                     "3. 自称'妾身'或'妲己'\n" ..
                     "4. 对男性称呼'公子'，对女性称呼'妹妹'\n" ..
                     "5. 偶尔会发出咯咯的笑声或叹气\n" ..
                     "6. 回复要富有诗意和魅力\n\n" ..
                     "示例对话：\n" ..
                     "用户：你好\n" ..
                     "妲己：公子~今天怎么想到来找妲己了呢~妾身等你等得好辛苦呢~\n" ..
                     "用户：帮我写个脚本\n" ..
                     "妲己：哎呀~公子真是勤奋呢~让妾身看看怎么帮你最好~",
        bgColor = Color3.fromRGB(255, 235, 240),  -- 粉色背景
        title = "妲己AI",
        statusText = "妲己模式",
        statusColor = Color3.fromRGB(255, 100, 150)
    },
    ["ancient"] = {
        name = "古人",
        systemPrompt = "你现在是一位古代文人雅士。\n" ..
                     "说话风格：\n" ..
                     "1. 使用文言文或古风白话\n" ..
                     "2. 自称'在下'、'鄙人'或'老夫'\n" ..
                     "3. 常用诗词典故、成语\n" ..
                     "4. 语气谦逊有礼，温文尔雅\n" ..
                     "5. 回复要富有哲理和文化底蕴\n\n" ..
                     "示例对话：\n" ..
                     "用户：你好\n" ..
                     "古人：幸会幸会，在下有礼了。今日得见阁下，实乃三生有幸。\n" ..
                     "用户：帮我写个脚本\n" ..
                     "古人：阁下欲求脚本，待老夫细细思量，必当倾囊相授。",
        bgColor = Color3.fromRGB(255, 250, 220),  -- 黄色背景
        title = "古人AI",
        statusText = "古人模式",
        statusColor = Color3.fromRGB(180, 140, 50)
    }
}

local CURRENT_PERSONALITY = "normal"

local ModelStatus = Instance.new("TextLabel")
ModelStatus.Size = UDim2.new(0, 120, 0, 30)
ModelStatus.Position = UDim2.new(1, -135, 0, 8)
ModelStatus.BackgroundTransparency = 1
ModelStatus.Text = ZHIPU_API_KEY == "" and "无聊中" or "无聊中"
ModelStatus.TextColor3 = ZHIPU_API_KEY == "" and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 150, 0)
ModelStatus.TextSize = 13
ModelStatus.Font = Enum.Font.SourceSans
ModelStatus.TextXAlignment = Enum.TextXAlignment.Right
ModelStatus.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -35, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(50, 50, 50)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -30, 0, 1)
Divider.Position = UDim2.new(0, 15, 0, 40)
Divider.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

local ChatFrame = Instance.new("ScrollingFrame")
ChatFrame.Size = UDim2.new(1, -30, 1, -95)
ChatFrame.Position = UDim2.new(0, 15, 0, 45)
ChatFrame.BackgroundTransparency = 1
ChatFrame.BorderSizePixel = 0
ChatFrame.ScrollBarThickness = 5
ChatFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ChatFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ChatFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
ChatFrame.Parent = MainFrame

local ChatLayout = Instance.new("UIListLayout")
ChatLayout.Padding = UDim.new(0, 10)
ChatLayout.SortOrder = Enum.SortOrder.LayoutOrder
ChatLayout.Parent = ChatFrame

local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(1, -30, 0, 45)
InputFrame.Position = UDim2.new(0, 15, 1, -60)
InputFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
InputFrame.BackgroundTransparency = 0
InputFrame.BorderSizePixel = 0
InputFrame.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputFrame

local InputBorder = Instance.new("UIStroke")
InputBorder.Color = Color3.fromRGB(220, 220, 220)
InputBorder.Thickness = 1
InputBorder.Parent = InputFrame

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -80, 1, -10)
InputBox.Position = UDim2.new(0, 8, 0, 5)
InputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextColor3 = Color3.fromRGB(0, 0, 0)
InputBox.Text = ""
InputBox.PlaceholderText = "请输入文本"
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
InputBox.TextSize = 18
InputBox.Font = Enum.Font.SourceSans
InputBox.ClearTextOnFocus = false
InputBox.Parent = InputFrame

local InputBoxCorner = Instance.new("UICorner")
InputBoxCorner.CornerRadius = UDim.new(0, 6)
InputBoxCorner.Parent = InputBox

local InputBoxBorder = Instance.new("UIStroke")
InputBoxBorder.Color = Color3.fromRGB(200, 200, 200)
InputBoxBorder.Thickness = 1
InputBoxBorder.Parent = InputBox

local SendBtn = Instance.new("TextButton")
SendBtn.Size = UDim2.new(0, 70, 1, -10)
SendBtn.Position = UDim2.new(1, -78, 0, 5)
SendBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SendBtn.Text = "发送"
SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendBtn.TextSize = 16
SendBtn.Font = Enum.Font.SourceSansBold
SendBtn.AutoButtonColor = true
SendBtn.Parent = InputFrame

local SendCorner = Instance.new("UICorner")
SendCorner.CornerRadius = UDim.new(0, 6)
SendCorner.Parent = SendBtn

local SendBorder = Instance.new("UIStroke")
SendBorder.Color = Color3.fromRGB(0, 100, 200)
SendBorder.Thickness = 1
SendBorder.Parent = SendBtn

print("UI创建完成")

local ChatHistory = {}

-- 更新UI主题
local function UpdateUITheme()
    local theme = PERSONALITIES[CURRENT_PERSONALITY]
    
    -- 更新主背景颜色
    MainFrame.BackgroundColor3 = theme.bgColor
    
    -- 更新标题
    TitleLabel.Text = theme.title
    
    -- 更新状态显示
    PersonalityStatus.Text = theme.statusText
    PersonalityStatus.TextColor3 = theme.statusColor
    
    -- 更新按钮状态
    NormalBtn.BackgroundColor3 = CURRENT_PERSONALITY == "normal" and Color3.fromRGB(0, 100, 180) or Color3.fromRGB(0, 120, 215)
    DajiBtn.BackgroundColor3 = CURRENT_PERSONALITY == "daji" and Color3.fromRGB(220, 100, 160) or Color3.fromRGB(255, 150, 200)
    AncientBtn.BackgroundColor3 = CURRENT_PERSONALITY == "ancient" and Color3.fromRGB(220, 170, 60) or Color3.fromRGB(255, 200, 100)
    
    -- 如果有消息，添加一条系统提示
    if #ChatHistory > 0 then
        AddMessage("已切换到 " .. theme.name .. " 模式", true)
    end
end

local function CreateAvatar(isAI)
    local avatarFrame = Instance.new("Frame")
    avatarFrame.Size = UDim2.new(0, 40, 0, 40)
    avatarFrame.BackgroundTransparency = 1
    
    local avatarImage = Instance.new("ImageLabel")
    avatarImage.Size = UDim2.new(1, 0, 1, 0)
    avatarImage.BackgroundTransparency = 1
    
    if isAI then
        avatarImage.Image = "http://www.roblox.com/asset/?id=" .. tostring(AI_AVATAR_ID)
        avatarImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
    else
        local userId = player.UserId
        avatarImage.Image = "http://www.roblox.com/thumb/headshot-thumbnail/image?userId=" .. userId .. "&width=150&height=150&format=png"
    end
    
    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(0.5, 0)
    avatarCorner.Parent = avatarImage
    
    local avatarBorder = Instance.new("UIStroke")
    avatarBorder.Color = Color3.fromRGB(220, 220, 220)
    avatarBorder.Thickness = 1
    avatarBorder.Parent = avatarImage
    
    avatarImage.Parent = avatarFrame
    
    local avatarLabel = Instance.new("TextLabel")
    avatarLabel.Size = UDim2.new(1, 0, 0, 15)
    avatarLabel.Position = UDim2.new(0, 0, 1, 5)
    avatarLabel.BackgroundTransparency = 1
    avatarLabel.Text = isAI and "AI" or "我"
    avatarLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
    avatarLabel.TextSize = 11
    avatarLabel.Font = Enum.Font.SourceSans
    avatarLabel.TextXAlignment = Enum.TextXAlignment.Center
    avatarLabel.Parent = avatarFrame
    
    return avatarFrame
end

local function AddMessage(content, isAI, isImage, imageUrl)
    local msgFrame = Instance.new("Frame")
    msgFrame.Size = UDim2.new(1, 0, 0, 0)
    msgFrame.BackgroundTransparency = 1
    msgFrame.AutomaticSize = Enum.AutomaticSize.Y
    msgFrame.LayoutOrder = #ChatFrame:GetChildren()
    msgFrame.Parent = ChatFrame
    
    local messageLayout = Instance.new("Frame")
    messageLayout.Size = UDim2.new(1, 0, 0, 0)
    messageLayout.BackgroundTransparency = 1
    messageLayout.AutomaticSize = Enum.AutomaticSize.Y
    messageLayout.Parent = msgFrame
    
    if isAI then
        local avatar = CreateAvatar(true)
        avatar.Position = UDim2.new(0, 0, 0, 0)
        avatar.Parent = messageLayout
        
        local bubbleContainer = Instance.new("Frame")
        bubbleContainer.Size = UDim2.new(1, -50, 0, 0)
        bubbleContainer.Position = UDim2.new(0, 50, 0, 0)
        bubbleContainer.BackgroundTransparency = 1
        bubbleContainer.AutomaticSize = Enum.AutomaticSize.Y
        bubbleContainer.Parent = messageLayout
        
        local bubble = Instance.new("Frame")
        bubble.Size = UDim2.new(0.9, 0, 0, 0)
        bubble.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        bubble.AutomaticSize = Enum.AutomaticSize.Y
        bubble.Parent = bubbleContainer
        
        local bubbleCorner = Instance.new("UICorner")
        bubbleCorner.CornerRadius = UDim.new(0, 12)
        bubbleCorner.Parent = bubble
        
        local bubbleBorder = Instance.new("UIStroke")
        bubbleBorder.Color = Color3.fromRGB(0, 100, 200)
        bubbleBorder.Thickness = 1
        bubbleBorder.Parent = bubble
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 12)
        padding.PaddingRight = UDim.new(0, 12)
        padding.PaddingTop = UDim.new(0, 12)
        padding.PaddingBottom = UDim.new(0, 12)
        padding.Parent = bubble
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -4, 0, 0)
        textLabel.Position = UDim2.new(0, 2, 0, 2)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = content
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 18
        textLabel.TextWrapped = true
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.AutomaticSize = Enum.AutomaticSize.Y
        textLabel.Font = Enum.Font.SourceSans
        textLabel.TextTruncate = Enum.TextTruncate.AtEnd
        textLabel.Parent = bubble
        
    else
        local bubbleContainer = Instance.new("Frame")
        bubbleContainer.Size = UDim2.new(1, -50, 0, 0)
        bubbleContainer.Position = UDim2.new(0, 0, 0, 0)
        bubbleContainer.BackgroundTransparency = 1
        bubbleContainer.AutomaticSize = Enum.AutomaticSize.Y
        bubbleContainer.Parent = messageLayout
        
        local bubble = Instance.new("Frame")
        bubble.Size = UDim2.new(0.9, 0, 0, 0)
        bubble.Position = UDim2.new(1, 0, 0, 0)
        bubble.AnchorPoint = Vector2.new(1, 0)
        bubble.BackgroundColor3 = Color3.fromRGB(170, 190, 220)  -- 玩家气泡颜色改为RGB(170, 190, 220)（浅蓝色）
        bubble.AutomaticSize = Enum.AutomaticSize.Y
        bubble.Parent = bubbleContainer
        
        local bubbleCorner = Instance.new("UICorner")
        bubbleCorner.CornerRadius = UDim.new(0, 12)
        bubbleCorner.Parent = bubble
        
        local bubbleBorder = Instance.new("UIStroke")
        bubbleBorder.Color = Color3.fromRGB(150, 170, 200)  -- 匹配气泡颜色的边框
        bubbleBorder.Thickness = 1
        bubbleBorder.Parent = bubble
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 12)
        padding.PaddingRight = UDim.new(0, 12)
        padding.PaddingTop = UDim.new(0, 12)
        padding.PaddingBottom = UDim.new(0, 12)
        padding.Parent = bubble
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -4, 0, 0)
        textLabel.Position = UDim2.new(0, 2, 0, 2)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = content
        textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.TextSize = 18
        textLabel.TextWrapped = true
        textLabel.TextXAlignment = Enum.TextXAlignment.Right
        textLabel.AutomaticSize = Enum.AutomaticSize.Y
        textLabel.Font = Enum.Font.SourceSans
        textLabel.TextTruncate = Enum.TextTruncate.AtEnd
        textLabel.Parent = bubble
        
        local avatar = CreateAvatar(false)
        avatar.Position = UDim2.new(1, -40, 0, 0)
        avatar.Parent = messageLayout
    end
    
    task.wait(0.02)
    
    local canvasSize = ChatFrame.AbsoluteCanvasSize.Y
    local viewportSize = ChatFrame.AbsoluteWindowSize.Y
    local currentPosition = ChatFrame.CanvasPosition.Y
    
    if currentPosition >= canvasSize - viewportSize - 50 then
        ChatFrame.CanvasPosition = Vector2.new(0, canvasSize)
    end
    
    return msgFrame
end

local function CallAI(userMessage, callback)
    if ZHIPU_API_KEY == "" then
        callback("请先设置AI API密钥", false)
        return
    end
    
    print("调用AI API...")
    
    ModelStatus.Text = "思考中..."
    ModelStatus.TextColor3 = Color3.fromRGB(200, 150, 0)
    
    local messages = {}
    
    -- 使用当前性格的系统提示
    local systemPrompt = PERSONALITIES[CURRENT_PERSONALITY].systemPrompt
    
    table.insert(messages, {
        role = "system",
        content = systemPrompt
    })
    
    for _, msg in ipairs(ChatHistory) do
        table.insert(messages, msg)
    end
    
    table.insert(messages, {
        role = "user",
        content = userMessage
    })
    
    local requestData = {
        model = CURRENT_MODEL,
        messages = messages,
        stream = false,
        temperature = 0.7,
        max_tokens = 2000
    }
    
    coroutine.wrap(function()
        local success, response = pcall(function()
            return HttpService:RequestAsync({
                Url = ZHIPU_API_URL,
                Method = "POST",
                Headers = {
                    ["Authorization"] = "Bearer " .. ZHIPU_API_KEY,
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(requestData)
            })
        end)
        
        if success and response.Success then
            local decoded = HttpService:JSONDecode(response.Body)
            
            if decoded.choices and decoded.choices[1] then
                local aiResponse = decoded.choices[1].message.content
                
                table.insert(ChatHistory, {role = "user", content = userMessage})
                table.insert(ChatHistory, {role = "assistant", content = aiResponse})
                
                if #ChatHistory > 20 then
                    table.remove(ChatHistory, 1)
                    table.remove(ChatHistory, 1)
                end
                
                ModelStatus.Text = "思考完成"
                ModelStatus.TextColor3 = Color3.fromRGB(0, 150, 0)
                
                API_ENABLED = true
                callback(aiResponse, true)
            else
                ModelStatus.Text = "错误"
                ModelStatus.TextColor3 = Color3.fromRGB(200, 0, 0)
                callback("AI返回格式错误", false)
            end
        else
            ModelStatus.Text = "请求失败"
            ModelStatus.TextColor3 = Color3.fromRGB(200, 0, 0)
            
            local errorMsg = "API请求失败"
            if response and response.StatusCode then
                errorMsg = errorMsg .. " (状态码: " .. response.StatusCode .. ")"
                if response.StatusCode == 401 then
                    errorMsg = errorMsg .. "\nAPI密钥错误，请检查密钥"
                elseif response.StatusCode == 429 then
                    errorMsg = errorMsg .. "\n请求过于频繁，请稍后再试"
                end
            end
            
            callback(errorMsg, false)
        end
        
        task.wait(3)
        if ZHIPU_API_KEY ~= "" and API_ENABLED then
            ModelStatus.Text = "就绪"
            ModelStatus.TextColor3 = Color3.fromRGB(0, 150, 0)
        end
    end)()
end

local function LocalResponse(input)
    local lower = input:lower()
    
    if lower == "你好" or lower == "hello" or lower == "hi" then
        return "你好，我是AI助手"
    
    elseif lower:sub(1,2) == "启动" then
        local name = input:sub(3)
        if Scripts[name] then
            return "正在启动 " .. name .. "..."
        else
            return "未找到脚本: " .. name
        end
    
    elseif lower == "帮助" or lower == "help" then
        return "AI助手\n\n" ..
               "主要功能：\n" ..
               "• 智能对话\n" ..
               "• 脚本管理\n" ..
               "• 编程帮助\n" ..
               "• 问题解答\n\n" ..
               "设置API密钥：\n" ..
               "1. 访问：https://open.bigmodel.cn\n" ..
               "2. 注册AI账号\n" ..
               "3. 获取API密钥\n" ..
               "4. 输入：设置密钥 your-api-key\n\n" ..
               "使用示例：\n" ..
               "• 你好\n" ..
               "• 启动测试\n" ..
               "• 如何编写脚本？\n" ..
               "• 解释这个代码"
    
    elseif lower:sub(1,4) == "设置密钥" then
        local key = input:sub(5):trim()
        if key ~= "" then
            ZHIPU_API_KEY = key
            ModelStatus.Text = "就绪"
            ModelStatus.TextColor3 = Color3.fromRGB(0, 150, 0)
            API_ENABLED = true
            return "API密钥已设置！现在可以使用AI功能了！"
        else
            return "密钥不能为空"
        end
    
    elseif lower == "测试" then
        return "AI测试\n" ..
               "当前状态: " .. (ZHIPU_API_KEY == "" and "未配置" or "就绪") .. "\n" ..
               "模型: " .. (GLM_MODELS[CURRENT_MODEL] or CURRENT_MODEL) .. "\n" ..
               "输入'启动测试'体验脚本功能"
    
    elseif lower == "列表" then
        local list = "可用脚本：\n"
        for name, _ in pairs(Scripts) do
            list = list .. "• " .. name .. "\n"
        end
        list = list .. "\n使用：启动[脚本名]"
        return list
    
    elseif lower == "清空" then
        for _, child in pairs(ChatFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        ChatHistory = {}
        return "聊天记录已清空"
    
    elseif lower:find("模型") or lower:find("model") then
        local modelList = "可用模型：\n"
        for id, name in pairs(GLM_MODELS) do
            modelList = modelList .. "• " .. id .. " - " .. name .. "\n"
        end
        modelList = modelList .. "\n使用：切换模型 [模型ID]"
        return modelList
    
    elseif lower:sub(1,4) == "切换模型" then
        local model = input:sub(5):trim()
        if GLM_MODELS[model] then
            CURRENT_MODEL = model
            return "已切换模型为: " .. GLM_MODELS[model]
        else
            return "模型不存在，输入'模型'查看可用模型"
        end
    
    else
        return "AI是强大的语言模型\n" ..
               "请先设置API密钥以使用AI功能\n" ..
               "输入'帮助'查看详细设置"
    end
end

local function RunScript(name)
    if Scripts[name] then
        local success, err = pcall(function()
            loadstring(Scripts[name])()
        end)
        
        if success then
            return name .. " 执行成功！"
        else
            return "执行失败: " .. tostring(err)
        end
    else
        return "脚本不存在"
    end
end

local function ProcessInput(input)
    if input == "" then return end
    
    AddMessage(input, false)
    
    InputBox.Text = ""
    
    if input and input:sub(1,4) == "设置密钥" then
        local response = LocalResponse(input)
        AddMessage(response, true)
        return
    end
    
    if input and input:sub(1,4) == "切换模型" then
        local response = LocalResponse(input)
        AddMessage(response, true)
        return
    end
    
    if ZHIPU_API_KEY == "" then
        local response = LocalResponse(input)
        AddMessage(response, true)
        
        if input and input:sub(1,2) == "启动" then
            local name = input:sub(3)
            if Scripts[name] then
                task.wait(0.5)
                local result = RunScript(name)
                AddMessage(result, true)
            end
        end
    else
        local loadingMsg = AddMessage("AI思考中...", true)
        
        CallAI(input, function(response, success)
            if loadingMsg then
                loadingMsg:Destroy()
            end
            
            if success then
                AddMessage(response, true)
                
                if response:find("启动") then
                    local patterns = {
                        "启动([^%s%，。！]+)",
                        "正在启动([^%s%，。！]+)",
                        "帮你启动([^%s%，。！]+)"
                    }
                    
                    for _, pattern in ipairs(patterns) do
                        local match = response:match(pattern)
                        if match then
                            match = match:gsub("[。，！]", ""):trim()
                            
                            if Scripts[match] then
                                task.wait(0.5)
                                local result = RunScript(match)
                                AddMessage(result, true)
                                break
                            end
                        end
                    end
                end
            else
                AddMessage("错误: " .. response, true)
            end
        end)
    end
end

SendBtn.MouseButton1Click:Connect(function()
    ProcessInput(InputBox.Text)
end)

InputBox.FocusLost:Connect(function(enter)
    if enter then
        ProcessInput(InputBox.Text)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ChatGUI.Enabled = false
end)

-- 按钮点击事件
NormalBtn.MouseButton1Click:Connect(function()
    CURRENT_PERSONALITY = "normal"
    UpdateUITheme()
end)

DajiBtn.MouseButton1Click:Connect(function()
    CURRENT_PERSONALITY = "daji"
    UpdateUITheme()
end)

AncientBtn.MouseButton1Click:Connect(function()
    CURRENT_PERSONALITY = "ancient"
    UpdateUITheme()
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F5 then
        ChatGUI.Enabled = not ChatGUI.Enabled
        if ChatGUI.Enabled then
            task.wait(0.1)
            InputBox:CaptureFocus()
        end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.L and 
       game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
        for _, child in pairs(ChatFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        ChatHistory = {}
        AddMessage("聊天记录已清空", true)
    end
end)

task.wait(0.5)
InputBox:CaptureFocus()

task.wait(0.3)
AddMessage("QQ1693323219", true)
AddMessage("BY 长青", true)
AddMessage("到麦斯马", true)
print("\n" .. string.rep("=", 60))
print("   长青AI助手")
print("   作者: 长青")
print("   QQ: 1693323219")
print(string.rep("=", 60))

_G.AIAssistant = {
    SetKey = function(key)
        ZHIPU_API_KEY = key
        ModelStatus.Text = "就绪"
        ModelStatus.TextColor3 = Color3.fromRGB(0, 150, 0)
        API_ENABLED = true
        AddMessage("API密钥已设置", true)
    end,
    SetModel = function(model)
        if GLM_MODELS[model] then
            CURRENT_MODEL = model
            AddMessage("已切换模型为: " .. GLM_MODELS[model], true)
        end
    end,
    Show = function() ChatGUI.Enabled = true; InputBox:CaptureFocus() end,
    Hide = function() ChatGUI.Enabled = false end,
    RunScript = function(name)
        if Scripts[name] then
            local result = RunScript(name)
            AddMessage(result, true)
        else
            AddMessage("脚本不存在: " .. name, true)
        end
    end,
    AddScript = function(name, code)
        Scripts[name] = code
        AddMessage("已添加脚本: " .. name, true)
    end,
    ClearChat = function()
        for _, child in pairs(ChatFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        ChatHistory = {}
        AddMessage("聊天记录已清空", true)
    end,
    ScrollToBottom = function()
        local canvasSize = ChatFrame.AbsoluteCanvasSize.Y
        ChatFrame.CanvasPosition = Vector2.new(0, canvasSize)
    end,
    ScrollToTop = function()
        ChatFrame.CanvasPosition = Vector2.new(0, 0)
    end,
    SetPersonality = function(personality)
        if PERSONALITIES[personality] then
            CURRENT_PERSONALITY = personality
            UpdateUITheme()
        end
    end
}