local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local HAS_CUSTOMASSET = (type(getcustomasset) == "function")
local HAS_WRITEFILE   = (type(writefile) == "function")
local HAS_MAKEFOLDER  = (type(makefolder) == "function")

local TEMP_DIR = "Mitea"
local imgCounter = 0
local imageCache = {}

local WHITE     = Color3.fromRGB(255, 255, 255)
local PANEL     = Color3.fromRGB(238, 242, 252)
local TEXT      = Color3.fromRGB(42, 52, 78)
local TEXT_SOFT = Color3.fromRGB(120, 134, 168)
local ACCENT    = Color3.fromRGB(28, 110, 232)
local ACCENT_HI = Color3.fromRGB(120, 180, 255)
local WELL      = Color3.fromRGB(214, 226, 246)
local DANGER    = Color3.fromRGB(228, 76, 76)

local function httpGet(url)
    local ok, res = pcall(function()
        return request({ Url = url, Method = "GET" })
    end)
    if ok and res and res.Body then return res.Body end
    local ok2, body = pcall(function() return HttpService:GetAsync(url) end)
    if ok2 then return body end
    return nil
end

local function httpJson(url)
    local body = httpGet(url)
    if not body or body == "" then return nil end
    local ok, data = pcall(function() return HttpService:JSONDecode(body) end)
    return ok and data or nil
end

local function fetchBinary(url)
    local ok, res = pcall(function()
        return request({ Url = url, Method = "GET" })
    end)
    if ok and res and res.Body then return res.Body end
    return nil
end

local function loadImage(url)
    if not HAS_CUSTOMASSET or not HAS_WRITEFILE then return nil end
    if imageCache[url] then return imageCache[url] end

    local body = fetchBinary(url)
    if not body then return nil end

    imgCounter = imgCounter + 1
    local ext = "png"
    local low = string.lower(url)
    if low:find("%.jpg") or low:find("%.jpeg") then ext = "jpg"
    elseif low:find("%.gif") then ext = "gif"
    elseif low:find("%.webp") then ext = "webp" end

    local fname = TEMP_DIR .. "/img_" .. imgCounter .. "." .. ext
    if HAS_MAKEFOLDER then
        pcall(function() makefolder(TEMP_DIR) end)
    end

    local okW = pcall(function() writefile(fname, body) end)
    if not okW then return nil end

    local okA, asset = pcall(function() return getcustomasset(fname) end)
    if okA and asset then
        imageCache[url] = asset
        return asset
    end
    return nil
end

local function round(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = o
    return c
end

local function pill(o)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = o
    return c
end

local function edge(o, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or WHITE
    s.Thickness = thickness or 1.5
    s.Transparency = transparency or 0.15
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = o
    return s
end

local function vertGrad(o, top, bottom)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(top, bottom)
    g.Rotation = 90
    g.Parent = o
    return g
end

local function gloss(o, height)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, height or 12)
    f.Position = UDim2.new(0, 2, 0, 2)
    f.BackgroundColor3 = WHITE
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ZIndex = o.ZIndex + 1
    f.Parent = o

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = f

    local g = Instance.new("UIGradient")
    g.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.55),
        NumberSequenceKeypoint.new(1, 1),
    })
    g.Parent = f
    return f
end

local gui = Instance.new("ScreenGui")
gui.Name = "LiquidGlass"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then
    gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(226, 234, 248)
bg.BackgroundTransparency = 0
bg.BorderSizePixel = 0
bg.ZIndex = 0
bg.Parent = gui

vertGrad(bg, Color3.fromRGB(240, 245, 255), Color3.fromRGB(206, 220, 244))

for i = 1, 8 do
    local blob = Instance.new("ImageLabel")
    local sz = math.random(280, 520)
    blob.Size = UDim2.new(0, sz, 0, sz)
    blob.Position = UDim2.new(math.random() * 1.1 - 0.05, 0, math.random() * 1.1 - 0.05, 0)
    blob.BackgroundTransparency = 1
    blob.Image = "rbxassetid://9120659123"
    blob.ImageColor3 = (i % 3 == 0) and Color3.fromRGB(180, 210, 255) or Color3.fromRGB(255, 255, 255)
    blob.ImageTransparency = math.random(55, 78) / 100
    blob.Rotation = math.random(0, 360)
    blob.ZIndex = 1
    blob.Parent = bg
end

local WIN_W, WIN_H = 640, 440

local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(0, WIN_W + 60, 0, WIN_H + 60)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6014261993"
shadow.ImageColor3 = Color3.fromRGB(150, 175, 220)
shadow.ImageTransparency = 0.72
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)
shadow.ZIndex = 8
shadow.Parent = gui

local win = Instance.new("Frame")
win.Name = "LiquidWindow"
win.Size = UDim2.new(0, WIN_W, 0, WIN_H)
win.Position = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
win.BackgroundColor3 = PANEL
win.BackgroundTransparency = 0.14
win.BorderSizePixel = 0
win.Active = true
win.ClipsDescendants = true
win.ZIndex = 10
win.Parent = gui
round(win, 18)

local winEdge = Instance.new("UIStroke")
winEdge.Color = WHITE
winEdge.Thickness = 1.5
winEdge.Transparency = 0.1
winEdge.Parent = win

vertGrad(win, Color3.fromRGB(252, 254, 255), Color3.fromRGB(222, 232, 248))

local winGloss = Instance.new("Frame")
winGloss.Size = UDim2.new(1, -8, 0, 56)
winGloss.Position = UDim2.new(0, 4, 0, 4)
winGloss.BackgroundColor3 = WHITE
winGloss.BackgroundTransparency = 1
winGloss.BorderSizePixel = 0
winGloss.ZIndex = 11
winGloss.Parent = win

round(winGloss, 15)

local wgGrad = Instance.new("UIGradient")
wgGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.45),
    NumberSequenceKeypoint.new(1, 1),
})
wgGrad.Parent = winGloss

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 42)
topBar.BackgroundColor3 = WHITE
topBar.BackgroundTransparency = 0.55
topBar.BorderSizePixel = 0
topBar.ZIndex = 13
topBar.Parent = win

local barMask = Instance.new("Frame")
barMask.Size = UDim2.new(1, 0, 0, 21)
barMask.Position = UDim2.new(0, 0, 1, -21)
barMask.BackgroundColor3 = WHITE
barMask.BackgroundTransparency = 0.55
barMask.BorderSizePixel = 0
barMask.ZIndex = 13
barMask.Parent = topBar

local barRule = Instance.new("Frame")
barRule.Size = UDim2.new(1, 0, 0, 1)
barRule.Position = UDim2.new(0, 0, 1, -1)
barRule.BackgroundColor3 = WHITE
barRule.BackgroundTransparency = 0.35
barRule.BorderSizePixel = 0
barRule.ZIndex = 14
barRule.Parent = topBar

local traffic = Instance.new("Frame")
traffic.Size = UDim2.new(0, 44, 0, 10)
traffic.Position = UDim2.new(0, 14, 0, 15)
traffic.BackgroundTransparency = 1
traffic.ZIndex = 15
traffic.Parent = topBar

local function dot(x, color, hi, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 10, 0, 10)
    b.Position = UDim2.new(0, x, 0, 0)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.ZIndex = 15
    b.Parent = traffic
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = b
    edge(b, WHITE, 1, 0.3)
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = hi }):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = color }):Play()
    end)
    if cb then b.MouseButton1Click:Connect(cb) end
    return b
end

dot(0, Color3.fromRGB(255, 108, 100), Color3.fromRGB(255, 150, 142))
dot(15, Color3.fromRGB(255, 196, 78), Color3.fromRGB(255, 220, 120))
dot(30, Color3.fromRGB(86, 208, 108), Color3.fromRGB(120, 232, 140), function()
    gui:Destroy()
end)

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(1, -180, 1, 0)
titleLbl.Position = UDim2.new(0, 90, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "Mitea"
titleLbl.TextColor3 = TEXT
titleLbl.TextSize = 12
titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextXAlignment = Enum.TextXAlignment.Center
titleLbl.ZIndex = 15
titleLbl.Parent = topBar

local body = Instance.new("Frame")
body.Size = UDim2.new(1, 0, 1, -42)
body.Position = UDim2.new(0, 0, 0, 42)
body.BackgroundTransparency = 1
body.ZIndex = 12
body.Parent = win

local function glassPanel(parent, size, pos, radius)
    local p = Instance.new("Frame")
    p.Size = size
    p.Position = pos
    p.BackgroundColor3 = WHITE
    p.BackgroundTransparency = 0.4
    p.BorderSizePixel = 0
    p.ZIndex = 14
    p.Parent = parent
    round(p, radius or 14)
    edge(p, WHITE, 1.5, 0.1)

    vertGrad(p, Color3.fromRGB(255, 255, 255), Color3.fromRGB(228, 236, 250))

    local g = Instance.new("Frame")
    g.Size = UDim2.new(1, -6, 0, 28)
    g.Position = UDim2.new(0, 3, 0, 3)
    g.BackgroundColor3 = WHITE
    g.BackgroundTransparency = 1
    g.BorderSizePixel = 0
    g.ZIndex = 15
    g.Parent = p
    local gc = Instance.new("UICorner")
    gc.CornerRadius = UDim.new(0, (radius or 14) - 3)
    gc.Parent = g
    local gg = Instance.new("UIGradient")
    gg.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.5),
        NumberSequenceKeypoint.new(1, 1),
    })
    gg.Parent = g

    return p
end

local rail = glassPanel(body, UDim2.new(0, 158, 1, -26), UDim2.new(0, 14, 0, 13), 14)

local railHead = Instance.new("TextLabel")
railHead.Size = UDim2.new(1, -24, 0, 12)
railHead.Position = UDim2.new(0, 12, 0, 12)
railHead.BackgroundTransparency = 1
railHead.Text = "分类"
railHead.TextColor3 = TEXT_SOFT
railHead.TextSize = 9
railHead.Font = Enum.Font.GothamBold
railHead.TextXAlignment = Enum.TextXAlignment.Left
railHead.ZIndex = 16
railHead.Parent = rail

local NAV_ITEMS = {
    { key = "原神",     label = "原神" },
    { key = "崩坏3",    label = "崩坏3" },
    { key = "碧蓝航线", label = "碧蓝航线" },
    { key = "蔚蓝档案", label = "蔚蓝档案" },
    { key = "随机",     label = "随机" },
}

local currentNav = 1
local navButtons = {}
local currentUrl = ""
local loading = false
local loadRandom

for i, item in ipairs(NAV_ITEMS) do
    local active = (i == currentNav)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -16, 0, 28)
    b.Position = UDim2.new(0, 8, 0, 32 + (i - 1) * 32)
    b.BackgroundColor3 = active and ACCENT or WHITE
    b.BackgroundTransparency = active and 0 or 0.55
    b.BorderSizePixel = 0
    b.Text = item.label
    b.TextColor3 = active and WHITE or TEXT
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.AutoButtonColor = false
    b.ZIndex = 16
    b.Parent = rail
    round(b, 9)

    if active then
        edge(b, WHITE, 1.5, 0.25)
        vertGrad(b, ACCENT_HI, ACCENT)
    else
        edge(b, WHITE, 1, 0.2)
    end

    local pad = Instance.new("Frame")
    pad.Size = UDim2.new(0, 10, 1, 0)
    pad.BackgroundTransparency = 1
    pad.ZIndex = 16
    pad.Parent = b

    b.MouseEnter:Connect(function()
        if currentNav ~= i then
            TweenService:Create(b, TweenInfo.new(0.15), {
                BackgroundTransparency = 0.3,
            }):Play()
        end
    end)
    b.MouseLeave:Connect(function()
        if currentNav ~= i then
            TweenService:Create(b, TweenInfo.new(0.15), {
                BackgroundTransparency = 0.55,
            }):Play()
        end
    end)
    b.MouseButton1Click:Connect(function()
        currentNav = i
        for j, d in ipairs(navButtons) do
            local isA = (j == i)
            d.btn.BackgroundColor3 = isA and ACCENT or WHITE
            d.btn.BackgroundTransparency = isA and 0 or 0.55
            d.btn.TextColor3 = isA and WHITE or TEXT
            d.btn:FindFirstChildOfClass("UIStroke").Transparency = isA and 0.25 or 0.2
            local existing = d.btn:FindFirstChildOfClass("UIGradient")
            if existing then existing:Destroy() end
            if isA then
                local ng = Instance.new("UIGradient")
                ng.Color = ColorSequence.new(ACCENT_HI, ACCENT)
                ng.Rotation = 90
                ng.Parent = d.btn
            end
        end
        loadRandom()
    end)

    navButtons[i] = { btn = b }
end

local panel = glassPanel(body, UDim2.new(1, -190, 1, -26), UDim2.new(0, 176, 0, 13), 14)

local imgWrap = Instance.new("Frame")
imgWrap.Size = UDim2.new(1, -22, 1, -102)
imgWrap.Position = UDim2.new(0, 11, 0, 11)
imgWrap.BackgroundColor3 = WELL
imgWrap.BackgroundTransparency = 0.25
imgWrap.BorderSizePixel = 0
imgWrap.ClipsDescendants = true
imgWrap.ZIndex = 16
imgWrap.Parent = panel
round(imgWrap, 10)
edge(imgWrap, WHITE, 1.5, 0.15)

local img = Instance.new("ImageLabel")
img.Size = UDim2.new(1, 0, 1, 0)
img.BackgroundTransparency = 1
img.Image = ""
img.ScaleType = Enum.ScaleType.Crop
img.ZIndex = 17
img.Parent = imgWrap

local placeholder = Instance.new("TextLabel")
placeholder.Size = UDim2.new(1, 0, 1, 0)
placeholder.BackgroundTransparency = 1
placeholder.Text = "点击载入图片"
placeholder.TextColor3 = TEXT_SOFT
placeholder.TextSize = 11
placeholder.Font = Enum.Font.Gotham
placeholder.TextXAlignment = Enum.TextXAlignment.Center
placeholder.ZIndex = 18
placeholder.Parent = imgWrap

local infoCard = Instance.new("Frame")
infoCard.Size = UDim2.new(1, -22, 0, 36)
infoCard.Position = UDim2.new(0, 11, 1, -82)
infoCard.BackgroundColor3 = WHITE
infoCard.BackgroundTransparency = 0.5
infoCard.BorderSizePixel = 0
infoCard.ZIndex = 16
infoCard.Parent = panel
round(infoCard, 9)
edge(infoCard, WHITE, 1, 0.15)

local mvArtist = Instance.new("TextLabel")
mvArtist.Size = UDim2.new(0.5, -16, 0, 14)
mvArtist.Position = UDim2.new(0, 11, 0, 6)
mvArtist.BackgroundTransparency = 1
mvArtist.Text = "画师 —"
mvArtist.TextColor3 = TEXT
mvArtist.TextSize = 10
mvArtist.Font = Enum.Font.GothamBold
mvArtist.TextXAlignment = Enum.TextXAlignment.Left
mvArtist.TextTruncate = Enum.TextTruncate.AtEnd
mvArtist.ZIndex = 17
mvArtist.Parent = infoCard

local mvTitle = Instance.new("TextLabel")
mvTitle.Size = UDim2.new(0.5, -16, 0, 14)
mvTitle.Position = UDim2.new(0.5, 5, 0, 6)
mvTitle.BackgroundTransparency = 1
mvTitle.Text = "作品 —"
mvTitle.TextColor3 = TEXT
mvTitle.TextSize = 10
mvTitle.Font = Enum.Font.GothamBold
mvTitle.TextXAlignment = Enum.TextXAlignment.Left
mvTitle.TextTruncate = Enum.TextTruncate.AtEnd
mvTitle.ZIndex = 17
mvTitle.Parent = infoCard

local mvPid = Instance.new("TextLabel")
mvPid.Size = UDim2.new(1, -22, 0, 11)
mvPid.Position = UDim2.new(0, 11, 0, 21)
mvPid.BackgroundTransparency = 1
mvPid.Text = "PID —"
mvPid.TextColor3 = TEXT_SOFT
mvPid.TextSize = 9
mvPid.Font = Enum.Font.Gotham
mvPid.TextXAlignment = Enum.TextXAlignment.Left
mvPid.ZIndex = 17
mvPid.Parent = infoCard

local btnRow = Instance.new("Frame")
btnRow.Size = UDim2.new(1, -22, 0, 32)
btnRow.Position = UDim2.new(0, 11, 1, -40)
btnRow.BackgroundTransparency = 1
btnRow.ZIndex = 16
btnRow.Parent = panel

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.5, -5, 1, 0)
refreshBtn.Position = UDim2.new(0, 0, 0, 0)
refreshBtn.BackgroundColor3 = ACCENT
refreshBtn.BorderSizePixel = 0
refreshBtn.Text = "换一张"
refreshBtn.TextColor3 = WHITE
refreshBtn.TextSize = 11
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.AutoButtonColor = false
refreshBtn.ZIndex = 17
refreshBtn.Parent = btnRow
pill(refreshBtn)
edge(refreshBtn, WHITE, 1.5, 0.25)
vertGrad(refreshBtn, ACCENT_HI, ACCENT)
gloss(refreshBtn, 9)

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.5, -5, 1, 0)
copyBtn.Position = UDim2.new(0.5, 5, 0, 0)
copyBtn.BackgroundColor3 = WHITE
copyBtn.BackgroundTransparency = 0.4
copyBtn.BorderSizePixel = 0
copyBtn.Text = "复制链接"
copyBtn.TextColor3 = TEXT
copyBtn.TextSize = 11
copyBtn.Font = Enum.Font.GothamBold
copyBtn.AutoButtonColor = false
copyBtn.ZIndex = 17
copyBtn.Parent = btnRow
pill(copyBtn)
edge(copyBtn, WHITE, 1.5, 0.12)
vertGrad(copyBtn, WHITE, Color3.fromRGB(230, 238, 252))
gloss(copyBtn, 9)

copyBtn.MouseEnter:Connect(function()
    TweenService:Create(copyBtn, TweenInfo.new(0.15), {
        BackgroundTransparency = 0.2,
    }):Play()
end)
copyBtn.MouseLeave:Connect(function()
    TweenService:Create(copyBtn, TweenInfo.new(0.15), {
        BackgroundTransparency = 0.4,
    }):Play()
end)

local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1, -32, 0, 12)
statusLbl.Position = UDim2.new(0, 14, 1, -16)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = "就绪"
statusLbl.TextColor3 = TEXT_SOFT
statusLbl.TextSize = 9
statusLbl.Font = Enum.Font.Gotham
statusLbl.TextXAlignment = Enum.TextXAlignment.Left
statusLbl.ZIndex = 14
statusLbl.Parent = win

local creditLbl = Instance.new("TextLabel")
creditLbl.Size = UDim2.new(0, 200, 0, 12)
creditLbl.Position = UDim2.new(1, -214, 1, -16)
creditLbl.BackgroundTransparency = 1
creditLbl.Text = "士兵 · QQ 1693323219"
creditLbl.TextColor3 = TEXT_SOFT
creditLbl.TextSize = 8
creditLbl.Font = Enum.Font.Gotham
creditLbl.TextXAlignment = Enum.TextXAlignment.Right
creditLbl.ZIndex = 14
creditLbl.Parent = win

local function setStatus(t, color)
    statusLbl.Text = t
    statusLbl.TextColor3 = color or TEXT_SOFT
end

local function getCurrentTag()
    local cat = NAV_ITEMS[currentNav]
    return cat and cat.key or "随机"
end

loadRandom = function()
    if loading then return end
    loading = true

    local tag = getCurrentTag()
    setStatus("正在加载 " .. tag .. " …")
    placeholder.Visible = true
    placeholder.Text = "载入中…"

    task.spawn(function()
        local url = "https://api.lolicon.app/setu/v2?r18=1&size=regular&num=1"
        if tag ~= "随机" then
            url = url .. "&tag=" .. HttpService:UrlEncode(tag)
        end

        local data = httpJson(url)

        if not data or not data.data or not data.data[1] then
            setStatus("加载失败", DANGER)
            placeholder.Text = "加载失败，请重试"
            placeholder.Visible = true
            loading = false
            return
        end

        local first = data.data[1]
        local imgUrl = first.urls and first.urls.regular
        local title = first.title or "未知"
        local author = first.author or "未知"
        local pid = first.pid or 0

        currentUrl = imgUrl or ""

        if not imgUrl then
            setStatus("图片链接为空", DANGER)
            loading = false
            return
        end

        setStatus("下载中…")
        local asset = loadImage(imgUrl)

        if asset then
            img.Image = asset
            placeholder.Visible = false
            mvArtist.Text = "画师  " .. tostring(author)
            mvTitle.Text = "作品  " .. tostring(title)
            mvPid.Text = "PID  " .. tostring(pid)
            setStatus("完成")
        else
            if not HAS_CUSTOMASSET then
                setStatus("此环境不支持图片加载", DANGER)
                placeholder.Text = "此环境不支持图片加载"
            else
                setStatus("图片下载失败", DANGER)
                placeholder.Text = "图片下载失败"
            end
            placeholder.Visible = true
        end

        loading = false
    end)
end

refreshBtn.MouseButton1Down:Connect(function()
    TweenService:Create(refreshBtn, TweenInfo.new(0.1), {
        BackgroundTransparency = 0.15,
    }):Play()
end)
refreshBtn.MouseButton1Up:Connect(function()
    TweenService:Create(refreshBtn, TweenInfo.new(0.1), {
        BackgroundTransparency = 0,
    }):Play()
end)
refreshBtn.MouseButton1Click:Connect(loadRandom)

copyBtn.MouseButton1Click:Connect(function()
    if currentUrl == "" then
        setStatus("还没有加载图片", DANGER)
        return
    end
    if setclipboard then
        pcall(function() setclipboard(currentUrl) end)
        setStatus("链接已复制")
    else
        setStatus("此环境无剪贴板权限", DANGER)
    end
end)

imgWrap.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        loadRandom()
    end
end)

local hidden = false
local showBtn
local transparencyStore = {}

local function collectAndStore()
    transparencyStore = {}

    local function rec(obj)
        if obj:IsA("TextLabel") or obj:IsA("TextButton")
            or obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
            transparencyStore[obj] = {
                bg = obj.BackgroundTransparency,
                text = (obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.TextTransparency or nil,
                image = (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) and obj.ImageTransparency or nil,
            }
        elseif obj:IsA("Frame") then
            transparencyStore[obj] = { bg = obj.BackgroundTransparency }
        elseif obj:IsA("UIStroke") then
            transparencyStore[obj] = { stroke = obj.Transparency }
        end
        for _, child in ipairs(obj:GetChildren()) do
            rec(child)
        end
    end

    rec(gui)
end

local function applyHidden(state)
    hidden = state

    if state then
        collectAndStore()

        for obj, data in pairs(transparencyStore) do
            if obj.Parent and obj ~= showBtn and not obj:IsDescendantOf(showBtn) then
                if data.bg ~= nil then
                    TweenService:Create(obj, TweenInfo.new(0.25), {
                        BackgroundTransparency = 1,
                    }):Play()
                end
                if data.text ~= nil then
                    TweenService:Create(obj, TweenInfo.new(0.25), {
                        TextTransparency = 1,
                    }):Play()
                end
                if data.image ~= nil then
                    TweenService:Create(obj, TweenInfo.new(0.25), {
                        ImageTransparency = 1,
                    }):Play()
                end
                if data.stroke ~= nil then
                    TweenService:Create(obj, TweenInfo.new(0.25), {
                        Transparency = 1,
                    }):Play()
                end
            end
        end
    else
        for obj, data in pairs(transparencyStore) do
            if obj.Parent and obj ~= showBtn and not obj:IsDescendantOf(showBtn) then
                if data.bg ~= nil then
                    TweenService:Create(obj, TweenInfo.new(0.25), {
                        BackgroundTransparency = data.bg,
                    }):Play()
                end
                if data.text ~= nil then
                    TweenService:Create(obj, TweenInfo.new(0.25), {
                        TextTransparency = data.text,
                    }):Play()
                end
                if data.image ~= nil then
                    TweenService:Create(obj, TweenInfo.new(0.25), {
                        ImageTransparency = data.image,
                    }):Play()
                end
                if data.stroke ~= nil then
                    TweenService:Create(obj, TweenInfo.new(0.25), {
                        Transparency = data.stroke,
                    }):Play()
                end
            end
        end
    end

    showBtn.Text = state and "◉" or "◌"
end

showBtn = Instance.new("TextButton")
showBtn.Name = "ToggleBtn"
showBtn.Size = UDim2.new(0, 34, 0, 34)
showBtn.Position = UDim2.new(0, 14, 0.5, -17)
showBtn.BackgroundColor3 = WHITE
showBtn.BackgroundTransparency = 0.35
showBtn.BorderSizePixel = 0
showBtn.Text = "◌"
showBtn.TextColor3 = ACCENT
showBtn.TextSize = 16
showBtn.Font = Enum.Font.GothamBold
showBtn.AutoButtonColor = false
showBtn.ZIndex = 200
showBtn.Parent = gui
pill(showBtn)
edge(showBtn, WHITE, 1.5, 0.15)

showBtn.MouseEnter:Connect(function()
    TweenService:Create(showBtn, TweenInfo.new(0.15), {
        BackgroundTransparency = 0.15,
    }):Play()
end)
showBtn.MouseLeave:Connect(function()
    TweenService:Create(showBtn, TweenInfo.new(0.15), {
        BackgroundTransparency = 0.35,
    }):Play()
end)

local clickGuard = false
local function toggle()
    if clickGuard then return end
    clickGuard = true
    applyHidden(not hidden)
    task.delay(0.3, function()
        clickGuard = false
    end)
end

showBtn.MouseButton1Click:Connect(toggle)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggle()
    end
end)

do
    local dragging, dragInput, dragStart, startPos
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = win.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local d = input.Position - dragStart
            win.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
end

setStatus("就绪")
loadRandom()