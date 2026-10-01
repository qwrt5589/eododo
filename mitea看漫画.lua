local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local API = "https://api.mangadex.org"
local UPLOADS = "https://uploads.mangadex.org"

local OUT_DIR = "Mitea_Downloads"
local TEMP_DIR = "Mitea_Temp"
local BG_IMAGE = "rbxassetid://97931717733537"

local AUTHOR_NAME = "士兵"
local AUTHOR_QQ = "1693323219"

local HAS_CUSTOMASSET = (type(getcustomasset) == "function")
local HAS_WRITEFILE = (type(writefile) == "function")
local HAS_MAKEFOLDER = (type(makefolder) == "function")

local C = {
    bg      = Color3.fromRGB(20, 21, 24),
    panel   = Color3.fromRGB(26, 27, 31),
    line    = Color3.fromRGB(44, 46, 52),
    line2   = Color3.fromRGB(58, 60, 68),
    text    = Color3.fromRGB(228, 230, 235),
    textDim = Color3.fromRGB(146, 149, 158),
    textMute= Color3.fromRGB(98, 101, 110),
    accent  = Color3.fromRGB(198, 84, 84),
    accentD = Color3.fromRGB(160, 64, 64),
    ok      = Color3.fromRGB(122, 188, 142),
}

local function apiGet(url)
    local ok, res = pcall(function()
        return request({ Url = url, Method = "GET" })
    end)
    if ok and res and res.Body then return res.Body end
    local ok2, body = pcall(function() return HttpService:GetAsync(url) end)
    if ok2 then return body end
    return nil
end

local function apiJson(url)
    local body = apiGet(url)
    if not body then return nil end
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

local imageCache = {}
local imgCounter = 0

local function loadImage(url)
    if not HAS_CUSTOMASSET or not HAS_WRITEFILE then return nil end
    if imageCache[url] then return imageCache[url] end

    local body = fetchBinary(url)
    if not body then return nil end

    imgCounter = imgCounter + 1
    local fname = TEMP_DIR .. "/img_" .. imgCounter .. ".png"

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

local gui = Instance.new("ScreenGui")
gui.Name = "MDReader"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then
    gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

local function corner(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = o
end

local function label(parent, x, y, w, h, text, size, color, font)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, w, 0, h)
    l.Position = UDim2.new(0, x, 0, y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.text
    l.TextSize = size or 14
    l.Font = font or Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.Parent = parent
    return l
end

local win = Instance.new("Frame")
win.Size = UDim2.new(0, 780, 0, 520)
win.Position = UDim2.new(0.5, -390, 0.5, -260)
win.BackgroundColor3 = C.bg
win.BorderSizePixel = 0
win.Active = true
win.ClipsDescendants = true
win.Parent = gui
corner(win, 12)

local bgImg = Instance.new("ImageLabel")
bgImg.Size = UDim2.new(1, 0, 1, 0)
bgImg.BackgroundTransparency = 1
bgImg.Image = BG_IMAGE
bgImg.ScaleType = Enum.ScaleType.Crop
bgImg.ImageTransparency = 0.35
bgImg.ZIndex = 0
bgImg.Parent = win

local bgMask = Instance.new("Frame")
bgMask.Size = UDim2.new(1, 0, 1, 0)
bgMask.BackgroundColor3 = C.bg
bgMask.BackgroundTransparency = 0.3
bgMask.BorderSizePixel = 0
bgMask.ZIndex = 1
bgMask.Parent = win

local maskGrad = Instance.new("UIGradient")
maskGrad.Rotation = 90
maskGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 11, 13)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 21, 24)),
})
maskGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.2),
    NumberSequenceKeypoint.new(1, 0.6),
})
maskGrad.Parent = bgMask

local winOutline = Instance.new("UIStroke")
winOutline.Color = C.line2
winOutline.Thickness = 1
winOutline.Transparency = 0.1
winOutline.Parent = win

local body = Instance.new("Frame")
body.Size = UDim2.new(1, 0, 1, -46)
body.Position = UDim2.new(0, 0, 0, 46)
body.BackgroundTransparency = 1
body.ZIndex = 3
body.Parent = win

local bar = Instance.new("Frame")
bar.Size = UDim2.new(1, 0, 0, 46)
bar.BackgroundColor3 = Color3.fromRGB(24, 25, 29)
bar.BackgroundTransparency = 0.15
bar.BorderSizePixel = 0
bar.ZIndex = 3
bar.Parent = win
corner(bar, 12)
local barMask = Instance.new("Frame")
barMask.Size = UDim2.new(1, 0, 0, 12)
barMask.Position = UDim2.new(0, 0, 1, -12)
barMask.BackgroundColor3 = bar.BackgroundColor3
barMask.BackgroundTransparency = bar.BackgroundTransparency
barMask.BorderSizePixel = 0
barMask.ZIndex = 3
barMask.Parent = bar

local barLine = Instance.new("Frame")
barLine.Size = UDim2.new(1, 0, 0, 1)
barLine.Position = UDim2.new(0, 0, 1, -1)
barLine.BackgroundColor3 = C.line
barLine.BorderSizePixel = 0
barLine.ZIndex = 4
barLine.Parent = bar

local brandBar = Instance.new("Frame")
brandBar.Size = UDim2.new(0, 3, 0, 18)
brandBar.Position = UDim2.new(0, 18, 0, 14)
brandBar.BackgroundColor3 = C.accent
brandBar.BorderSizePixel = 0
brandBar.ZIndex = 5
brandBar.Parent = bar
corner(brandBar, 2)

label(bar, 30, 0, 260, 46, "Mitea 阅读器", 15, C.text, Enum.Font.GothamMedium).ZIndex = 5

local authorChip = Instance.new("Frame")
authorChip.Size = UDim2.new(0, 210, 0, 24)
authorChip.Position = UDim2.new(0, 230, 0, 11)
authorChip.BackgroundColor3 = Color3.fromRGB(34, 35, 40)
authorChip.BorderSizePixel = 0
authorChip.ZIndex = 5
authorChip.Parent = bar
corner(authorChip, 6)
label(authorChip, 10, 0, 200, 24,
    "作者：" .. AUTHOR_NAME .. "    QQ " .. AUTHOR_QQ,
    11, C.textDim, Enum.Font.Gotham).ZIndex = 6

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -78, 0, 8)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 41, 46)
minBtn.BackgroundTransparency = 0.2
minBtn.Text = "—"
minBtn.TextColor3 = C.textMute
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.AutoButtonColor = false
minBtn.ZIndex = 5
minBtn.Parent = bar
corner(minBtn, 6)

minBtn.MouseEnter:Connect(function()
    TweenService:Create(minBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = C.accent, TextColor3 = C.text, BackgroundTransparency = 0
    }):Play()
end)
minBtn.MouseLeave:Connect(function()
    TweenService:Create(minBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = Color3.fromRGB(40, 41, 46), TextColor3 = C.textMute, BackgroundTransparency = 0.2
    }):Play()
end)

local minimized = false
local restoreSize = UDim2.new(0, 780, 0, 520)
local miniSize = UDim2.new(0, 780, 0, 46)

minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        body.Visible = false
        TweenService:Create(win, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            Size = miniSize
        }):Play()
        minBtn.Text = "▢"
    else
        TweenService:Create(win, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            Size = restoreSize
        }):Play()
        task.delay(0.1, function()
            body.Visible = true
        end)
        minBtn.Text = "—"
    end
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -42, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 41, 46)
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "✕"
closeBtn.TextColor3 = C.textMute
closeBtn.TextSize = 13
closeBtn.Font = Enum.Font.GothamBold
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 5
closeBtn.Parent = bar
corner(closeBtn, 6)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = C.accentD, TextColor3 = C.text, BackgroundTransparency = 0
    }):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = Color3.fromRGB(40, 41, 46), TextColor3 = C.textMute, BackgroundTransparency = 0.2
    }):Play()
end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local sideW = 216
local side = Instance.new("Frame")
side.Size = UDim2.new(0, sideW, 1, 0)
side.Position = UDim2.new(0, 0, 0, 0)
side.BackgroundColor3 = Color3.fromRGB(23, 24, 28)
side.BackgroundTransparency = 0.25
side.BorderSizePixel = 0
side.ZIndex = 3
side.Parent = body

local sideDivider = Instance.new("Frame")
sideDivider.Size = UDim2.new(0, 1, 1, 0)
sideDivider.Position = UDim2.new(0, sideW, 0, 0)
sideDivider.BackgroundColor3 = C.line
sideDivider.BorderSizePixel = 0
sideDivider.ZIndex = 4
sideDivider.Parent = body

label(side, 20, 24, 180, 14, "搜索", 11, C.textMute, Enum.Font.GothamBold).ZIndex = 5

local searchWrap = Instance.new("Frame")
searchWrap.Size = UDim2.new(1, -40, 0, 38)
searchWrap.Position = UDim2.new(0, 20, 0, 46)
searchWrap.BackgroundColor3 = Color3.fromRGB(18, 19, 22)
searchWrap.BackgroundTransparency = 0.1
searchWrap.BorderSizePixel = 0
searchWrap.ZIndex = 5
searchWrap.Parent = side
corner(searchWrap, 7)
local swStroke = Instance.new("UIStroke")
swStroke.Color = C.line2
swStroke.Thickness = 1
swStroke.Transparency = 0.2
swStroke.Parent = searchWrap

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -22, 1, 0)
searchBox.Position = UDim2.new(0, 12, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.Text = ""
searchBox.PlaceholderText = "漫画名称"
searchBox.PlaceholderColor3 = C.textMute
searchBox.TextColor3 = C.text
searchBox.TextSize = 13
searchBox.Font = Enum.Font.Gotham
searchBox.ClearTextOnFocus = false
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ZIndex = 6
searchBox.Parent = searchWrap

searchBox.Focused:Connect(function()
    TweenService:Create(swStroke, TweenInfo.new(0.12), { Color = C.accent, Transparency = 0 }):Play()
end)
searchBox.FocusLost:Connect(function()
    TweenService:Create(swStroke, TweenInfo.new(0.12), { Color = C.line2, Transparency = 0.2 }):Play()
end)

local searchBtn = Instance.new("TextButton")
searchBtn.Size = UDim2.new(1, -40, 0, 34)
searchBtn.Position = UDim2.new(0, 20, 0, 94)
searchBtn.BackgroundColor3 = C.accent
searchBtn.Text = "搜索"
searchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBtn.TextSize = 13
searchBtn.Font = Enum.Font.GothamMedium
searchBtn.AutoButtonColor = false
searchBtn.ZIndex = 5
searchBtn.Parent = side
corner(searchBtn, 7)

searchBtn.MouseEnter:Connect(function()
    TweenService:Create(searchBtn, TweenInfo.new(0.12), { BackgroundColor3 = C.accentD }):Play()
end)
searchBtn.MouseLeave:Connect(function()
    TweenService:Create(searchBtn, TweenInfo.new(0.12), { BackgroundColor3 = C.accent }):Play()
end)

local sep = Instance.new("Frame")
sep.Size = UDim2.new(1, -40, 0, 1)
sep.Position = UDim2.new(0, 20, 0, 152)
sep.BackgroundColor3 = C.line
sep.BorderSizePixel = 0
sep.ZIndex = 5
sep.Parent = side

label(side, 20, 168, 180, 14, "缓存", 11, C.textMute, Enum.Font.GothamBold).ZIndex = 5

local cacheLbl = label(side, 20, 188, sideW - 40, 40,
    "已缓存 0 张", 11, C.textDim, Enum.Font.Gotham)
cacheLbl.TextWrapped = true
cacheLbl.TextYAlignment = Enum.TextYAlignment.Top
cacheLbl.ZIndex = 5

local clearCacheBtn = Instance.new("TextButton")
clearCacheBtn.Size = UDim2.new(1, -40, 0, 28)
clearCacheBtn.Position = UDim2.new(0, 20, 0, 232)
clearCacheBtn.BackgroundColor3 = Color3.fromRGB(40, 41, 46)
clearCacheBtn.BackgroundTransparency = 0.2
clearCacheBtn.Text = "清空缓存"
clearCacheBtn.TextColor3 = C.textDim
clearCacheBtn.TextSize = 11
clearCacheBtn.Font = Enum.Font.Gotham
clearCacheBtn.AutoButtonColor = false
clearCacheBtn.ZIndex = 5
clearCacheBtn.Parent = side
corner(clearCacheBtn, 6)

clearCacheBtn.MouseEnter:Connect(function()
    clearCacheBtn.BackgroundColor3 = C.accentD
    clearCacheBtn.TextColor3 = C.text
end)
clearCacheBtn.MouseLeave:Connect(function()
    clearCacheBtn.BackgroundColor3 = Color3.fromRGB(40, 41, 46)
    clearCacheBtn.TextColor3 = C.textDim
end)

clearCacheBtn.MouseButton1Click:Connect(function()
    imageCache = {}
    if delfolder then
        pcall(function() delfolder(TEMP_DIR) end)
    end
    cacheLbl.Text = "已缓存 0 张"
end)

local creditBox = Instance.new("Frame")
creditBox.Size = UDim2.new(1, -40, 0, 84)
creditBox.Position = UDim2.new(0, 20, 0, 274)
creditBox.BackgroundColor3 = Color3.fromRGB(18, 19, 22)
creditBox.BackgroundTransparency = 0.1
creditBox.BorderSizePixel = 0
creditBox.ZIndex = 5
creditBox.Parent = side
corner(creditBox, 8)

label(creditBox, 12, 8, 160, 14, "本工具作者", 10, C.textMute, Enum.Font.GothamBold).ZIndex = 6
label(creditBox, 12, 26, 160, 22, AUTHOR_NAME, 15, C.text, Enum.Font.GothamBold).ZIndex = 6
label(creditBox, 12, 54, 160, 16, "QQ  " .. AUTHOR_QQ, 11, C.accent, Enum.Font.Code).ZIndex = 6

local sideInfo = label(side, 20, 0, sideW - 40, 40,
    "搜索漫画 → 点进漫画 → 点章节阅读",
    10, C.textMute, Enum.Font.Gotham)
sideInfo.Position = UDim2.new(0, 20, 1, -50)
sideInfo.TextWrapped = true
sideInfo.TextYAlignment = Enum.TextYAlignment.Bottom
sideInfo.ZIndex = 5

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -sideW - 1, 1, 0)
content.Position = UDim2.new(0, sideW + 1, 0, 0)
content.BackgroundTransparency = 1
content.ZIndex = 3
content.Parent = body

local crumb = Instance.new("Frame")
crumb.Size = UDim2.new(1, 0, 0, 38)
crumb.BackgroundTransparency = 1
crumb.ZIndex = 4
crumb.Parent = content

local crumbLine = Instance.new("Frame")
crumbLine.Size = UDim2.new(1, 0, 0, 1)
crumbLine.Position = UDim2.new(0, 0, 1, -1)
crumbLine.BackgroundColor3 = C.line
crumbLine.BorderSizePixel = 0
crumbLine.ZIndex = 4
crumbLine.Parent = crumb

local crumbLbl = label(crumb, 22, 0, 400, 38, "搜索结果", 12, C.textDim, Enum.Font.Gotham)
crumbLbl.TextTruncate = Enum.TextTruncate.AtEnd
crumbLbl.ZIndex = 5

local backBtn = Instance.new("TextButton")
backBtn.Size = UDim2.new(0, 60, 0, 24)
backBtn.Position = UDim2.new(1, -180, 0, 7)
backBtn.BackgroundColor3 = Color3.fromRGB(40, 41, 46)
backBtn.BackgroundTransparency = 0.2
backBtn.Text = "← 返回"
backBtn.TextColor3 = C.textDim
backBtn.TextSize = 11
backBtn.Font = Enum.Font.Gotham
backBtn.AutoButtonColor = false
backBtn.Visible = false
backBtn.ZIndex = 5
backBtn.Parent = crumb
corner(backBtn, 6)

local countLbl = label(crumb, 0, 0, 100, 38, "", 11, C.textMute, Enum.Font.Gotham)
countLbl.Position = UDim2.new(1, -110, 0, 0)
countLbl.TextXAlignment = Enum.TextXAlignment.Right
countLbl.ZIndex = 5

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -44, 1, -118)
list.Position = UDim2.new(0, 22, 0, 56)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 3
list.ScrollBarImageColor3 = C.line2
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.ZIndex = 4
list.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 0)
layout.Parent = list

local footer = Instance.new("Frame")
footer.Size = UDim2.new(1, 0, 0, 44)
footer.Position = UDim2.new(0, 0, 1, -44)
footer.BackgroundColor3 = Color3.fromRGB(23, 24, 28)
footer.BackgroundTransparency = 0.25
footer.BorderSizePixel = 0
footer.ZIndex = 4
footer.Parent = content

local footerLine = Instance.new("Frame")
footerLine.Size = UDim2.new(1, 0, 0, 1)
footerLine.BackgroundColor3 = C.line
footerLine.BorderSizePixel = 0
footerLine.ZIndex = 5
footerLine.Parent = footer

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 5, 0, 5)
statusDot.Position = UDim2.new(0, 22, 0, 19)
statusDot.BackgroundColor3 = C.textMute
statusDot.BorderSizePixel = 0
statusDot.ZIndex = 5
statusDot.Parent = footer
corner(statusDot, 3)

local statusLbl = label(footer, 34, 0, 520, 44, "就绪", 11, C.textDim, Enum.Font.Gotham)
statusLbl.TextTruncate = Enum.TextTruncate.AtEnd
statusLbl.ZIndex = 5

local footerCredit = label(footer, 0, 0, 160, 44,
    AUTHOR_NAME .. " · " .. AUTHOR_QQ,
    10, C.textMute, Enum.Font.Gotham)
footerCredit.Position = UDim2.new(1, -170, 0, 0)
footerCredit.TextXAlignment = Enum.TextXAlignment.Right
footerCredit.ZIndex = 5

local function setStatus(t, color)
    statusLbl.Text = t
    statusDot.BackgroundColor3 = color or C.textMute
end

local function updateCacheLbl()
    local n = 0
    for _ in pairs(imageCache) do n = n + 1 end
    cacheLbl.Text = "已缓存 " .. n .. " 张"
end

local function clearList()
    for _, c in ipairs(list:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end
    end
end

local readerView = Instance.new("Frame")
readerView.Size = UDim2.new(1, -44, 1, -118)
readerView.Position = UDim2.new(0, 22, 0, 56)
readerView.BackgroundTransparency = 1
readerView.Visible = false
readerView.ZIndex = 4
readerView.Parent = content

local readerImg = Instance.new("ImageLabel")
readerImg.Size = UDim2.new(1, 0, 1, -60)
readerImg.BackgroundColor3 = Color3.fromRGB(14, 15, 18)
readerImg.BackgroundTransparency = 0.2
readerImg.BorderSizePixel = 0
readerImg.Image = ""
readerImg.ScaleType = Enum.ScaleType.Fit
readerImg.ZIndex = 5
readerImg.Parent = readerView
corner(readerImg, 8)

local readerInfo = label(readerView, 6, 0, 400, 22, "", 11, C.textDim, Enum.Font.Gotham)
readerInfo.Position = UDim2.new(0, 6, 1, -52)
readerInfo.ZIndex = 5

local prevChapBtn = Instance.new("TextButton")
prevChapBtn.Size = UDim2.new(0, 80, 0, 34)
prevChapBtn.Position = UDim2.new(0, 6, 1, -34)
prevChapBtn.BackgroundColor3 = Color3.fromRGB(52, 46, 40)
prevChapBtn.BackgroundTransparency = 0.1
prevChapBtn.Text = "⇤ 上一话"
prevChapBtn.TextColor3 = Color3.fromRGB(226, 196, 140)
prevChapBtn.TextSize = 12
prevChapBtn.Font = Enum.Font.GothamMedium
prevChapBtn.AutoButtonColor = false
prevChapBtn.ZIndex = 5
prevChapBtn.Parent = readerView
corner(prevChapBtn, 7)

local prevBtn = Instance.new("TextButton")
prevBtn.Size = UDim2.new(0, 80, 0, 34)
prevBtn.Position = UDim2.new(0, 92, 1, -34)
prevBtn.BackgroundColor3 = Color3.fromRGB(40, 41, 46)
prevBtn.BackgroundTransparency = 0.15
prevBtn.Text = "← 上一页"
prevBtn.TextColor3 = C.text
prevBtn.TextSize = 12
prevBtn.Font = Enum.Font.GothamMedium
prevBtn.AutoButtonColor = false
prevBtn.ZIndex = 5
prevBtn.Parent = readerView
corner(prevBtn, 7)

local nextBtn = Instance.new("TextButton")
nextBtn.Size = UDim2.new(0, 80, 0, 34)
nextBtn.Position = UDim2.new(0, 178, 1, -34)
nextBtn.BackgroundColor3 = Color3.fromRGB(40, 41, 46)
nextBtn.BackgroundTransparency = 0.15
nextBtn.Text = "下一页 →"
nextBtn.TextColor3 = C.text
nextBtn.TextSize = 12
nextBtn.Font = Enum.Font.GothamMedium
nextBtn.AutoButtonColor = false
nextBtn.ZIndex = 5
nextBtn.Parent = readerView
corner(nextBtn, 7)

local nextChapBtn = Instance.new("TextButton")
nextChapBtn.Size = UDim2.new(0, 80, 0, 34)
nextChapBtn.Position = UDim2.new(0, 264, 1, -34)
nextChapBtn.BackgroundColor3 = Color3.fromRGB(52, 46, 40)
nextChapBtn.BackgroundTransparency = 0.1
nextChapBtn.Text = "下一话 ⇥"
nextChapBtn.TextColor3 = Color3.fromRGB(226, 196, 140)
nextChapBtn.TextSize = 12
nextChapBtn.Font = Enum.Font.GothamMedium
nextChapBtn.AutoButtonColor = false
nextChapBtn.ZIndex = 5
nextChapBtn.Parent = readerView
corner(nextChapBtn, 7)

local exportBtn = Instance.new("TextButton")
exportBtn.Size = UDim2.new(0, 110, 0, 34)
exportBtn.Position = UDim2.new(1, -116, 1, -34)
exportBtn.BackgroundColor3 = C.accent
exportBtn.Text = "导出本话"
exportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exportBtn.TextSize = 12
exportBtn.Font = Enum.Font.GothamMedium
exportBtn.AutoButtonColor = false
exportBtn.ZIndex = 5
exportBtn.Parent = readerView
corner(exportBtn, 7)

local reader = {
    pages = {},
    index = 1,
    title = "",
    chapterLabel = "",
    chapterId = "",
    chapters = {},
    chapPos = 1,
}

local function preloadPage(idx)
    if idx < 1 or idx > #reader.pages then return end
    if not HAS_CUSTOMASSET then return end
    local url = reader.pages[idx]
    if imageCache[url] then return end
    task.spawn(function()
        loadImage(url)
        updateCacheLbl()
    end)
end

local function renderPage()
    if #reader.pages == 0 then
        readerImg.Image = ""
        readerInfo.Text = "没有图片"
        return
    end

    local idx = reader.index
    local url = reader.pages[idx]
    readerInfo.Text = string.format("%s  ·  %d / %d", reader.chapterLabel, idx, #reader.pages)

    if HAS_CUSTOMASSET and HAS_WRITEFILE then
        if imageCache[url] then
            readerImg.Image = imageCache[url]
            setStatus("第 " .. idx .. " 页", C.ok)
        else
            setStatus("加载第 " .. idx .. " 页…")
            task.spawn(function()
                local asset = loadImage(url)
                updateCacheLbl()
                if asset and reader.index == idx then
                    readerImg.Image = asset
                    setStatus("第 " .. idx .. " 页", C.ok)
                end
                preloadPage(idx + 1)
                preloadPage(idx + 2)
            end)
        end
    else
        readerImg.Image = ""
        readerInfo.Text = string.format("%s  ·  %d / %d  （不支持预览）",
            reader.chapterLabel, idx, #reader.pages)
    end
end

local function loadChapter(chapterId, chapterLabel, chapPos)
    reader.pages = {}
    reader.index = 1
    reader.chapterId = chapterId
    reader.chapterLabel = chapterLabel
    if chapPos then reader.chapPos = chapPos end

    local crumbText = tostring(reader.title) .. "  ·  " .. chapterLabel
    if #reader.chapters > 0 then
        crumbText = crumbText .. string.format("  (%d/%d)", reader.chapPos, #reader.chapters)
    end
    crumbLbl.Text = crumbText

    setStatus("获取章节…")

    local serverData = apiJson(API .. "/at-home/server/" .. chapterId)
    if not serverData then
        setStatus("获取章节失败", C.accent)
        return
    end

    local baseUrl = serverData.baseUrl
    local hash = serverData.chapter and serverData.chapter.hash
    local dataFiles = serverData.chapter and serverData.chapter.data
    if not baseUrl or not hash or not dataFiles then
        setStatus("章节数据异常", C.accent)
        return
    end

    for _, fname in ipairs(dataFiles) do
        table.insert(reader.pages, baseUrl .. "/data/" .. hash .. "/" .. fname)
    end

    setStatus("共 " .. #reader.pages .. " 页")
    renderPage()
end

local function openReader(chapterId, chapterLabel, mangaTitle, chapPos, chapters)
    list.Visible = false
    readerView.Visible = true
    backBtn.Visible = true

    reader.title = mangaTitle
    if chapters then
        reader.chapters = chapters
    end
    if chapPos then
        reader.chapPos = chapPos
    end

    loadChapter(chapterId, chapterLabel, reader.chapPos)
end

local function gotoChapter(delta)
    if #reader.chapters == 0 then
        setStatus("没有章节列表", C.accent)
        return
    end
    local newPos = reader.chapPos + delta
    if newPos < 1 then
        setStatus("已经是第一话", C.accent)
        return
    end
    if newPos > #reader.chapters then
        setStatus("已经是最后一话", C.accent)
        return
    end
    local ch = reader.chapters[newPos]
    reader.chapPos = newPos
    setStatus("切换到 " .. ch.label .. "…")
    loadChapter(ch.id, ch.label, newPos)
end

prevChapBtn.MouseButton1Click:Connect(function() gotoChapter(-1) end)
nextChapBtn.MouseButton1Click:Connect(function() gotoChapter(1) end)

prevBtn.MouseButton1Click:Connect(function()
    if reader.index > 1 then
        reader.index = reader.index - 1
        renderPage()
    end
end)

nextBtn.MouseButton1Click:Connect(function()
    if reader.index < #reader.pages then
        reader.index = reader.index + 1
        renderPage()
    end
end)

exportBtn.MouseButton1Click:Connect(function()
    if #reader.pages == 0 then
        setStatus("没有可导出内容", C.accent)
        return
    end
    if not HAS_WRITEFILE then
        setStatus("执行器不支持 writefile", C.accent)
        return
    end

    local safeTitle = tostring(reader.title or "未知漫画")
        :gsub("[\\/:*?\"<>|]", "_"):sub(1, 40)
    local safeChap = tostring(reader.chapterLabel or "未知章节")
        :gsub("[\\/:*?\"<>|]", "_"):sub(1, 20)
    local folder = OUT_DIR .. "/" .. safeTitle .. "_" .. safeChap

    if HAS_MAKEFOLDER then
        pcall(function() makefolder(OUT_DIR) end)
        pcall(function() makefolder(folder) end)
    end

    task.spawn(function()
        local total = #reader.pages
        local done = 0
        for i, url in ipairs(reader.pages) do
            setStatus(string.format("导出 %d / %d", i, total))
            local body = fetchBinary(url)
            if body then
                local ext = url:match("%.([%a%d]+)$") or "png"
                local path = folder .. "/" .. string.format("%03d.%s", i, ext)
                local ok = pcall(function() writefile(path, body) end)
                if ok then done = done + 1 end
            end
            task.wait(0.03)
        end
        setStatus(string.format("导出完成 %d / %d  →  %s", done, total, folder), C.ok)
    end)
end)

local function addRow(coverUrl, mainText, subText, onClick)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, 64)
    row.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    row.BackgroundTransparency = 1
    row.Text = ""
    row.AutoButtonColor = false
    row.BorderSizePixel = 0
    row.ZIndex = 5
    row.Parent = list

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 2, 0, 0)
    ind.Position = UDim2.new(0, 0, 0.5, 0)
    ind.AnchorPoint = Vector2.new(0, 0.5)
    ind.BackgroundColor3 = C.accent
    ind.BorderSizePixel = 0
    ind.ZIndex = 7
    ind.Parent = row

    local ln = Instance.new("Frame")
    ln.Size = UDim2.new(1, 0, 0, 1)
    ln.Position = UDim2.new(0, 0, 1, -1)
    ln.BackgroundColor3 = C.line
    ln.BorderSizePixel = 0
    ln.ZIndex = 6
    ln.Parent = row

    local hasThumb = coverUrl and HAS_CUSTOMASSET and HAS_WRITEFILE
    if hasThumb then
        local thumb = Instance.new("ImageLabel")
        thumb.Size = UDim2.new(0, 40, 0, 52)
        thumb.Position = UDim2.new(0, 12, 0, 6)
        thumb.BackgroundColor3 = Color3.fromRGB(20, 21, 24)
        thumb.BorderSizePixel = 0
        thumb.Image = ""
        thumb.ScaleType = Enum.ScaleType.Crop
        thumb.ZIndex = 7
        thumb.Parent = row
        corner(thumb, 4)

        task.spawn(function()
            local asset = loadImage(coverUrl)
            updateCacheLbl()
            if asset and thumb.Parent then
                thumb.Image = asset
            end
        end)
    end

    local textX = hasThumb and 62 or 14

    local t1 = Instance.new("TextLabel")
    t1.Size = UDim2.new(1, -(textX + 40), 0, 20)
    t1.Position = UDim2.new(0, textX, 0, 12)
    t1.BackgroundTransparency = 1
    t1.Text = mainText
    t1.TextColor3 = C.text
    t1.TextSize = 13
    t1.Font = Enum.Font.GothamMedium
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.TextTruncate = Enum.TextTruncate.AtEnd
    t1.ZIndex = 7
    t1.Parent = row

    if subText and subText ~= "" then
        local t2 = Instance.new("TextLabel")
        t2.Size = UDim2.new(1, -(textX + 40), 0, 16)
        t2.Position = UDim2.new(0, textX, 0, 34)
        t2.BackgroundTransparency = 1
        t2.Text = subText
        t2.TextColor3 = C.textMute
        t2.TextSize = 11
        t2.Font = Enum.Font.Gotham
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextTruncate = Enum.TextTruncate.AtEnd
        t2.ZIndex = 7
        t2.Parent = row
    end

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 24, 1, 0)
    arrow.Position = UDim2.new(1, -30, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "›"
    arrow.TextColor3 = C.textMute
    arrow.TextSize = 18
    arrow.Font = Enum.Font.GothamBold
    arrow.ZIndex = 7
    arrow.Parent = row

    row.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = 0.86 }):Play()
        TweenService:Create(ind, TweenInfo.new(0.15), { Size = UDim2.new(0, 2, 0, 38) }):Play()
        arrow.TextColor3 = C.accent
    end)
    row.MouseLeave:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = 1 }):Play()
        TweenService:Create(ind, TweenInfo.new(0.15), { Size = UDim2.new(0, 2, 0, 0) }):Play()
        arrow.TextColor3 = C.textMute
    end)

    if onClick then
        row.MouseButton1Click:Connect(onClick)
    end

    return row
end

local function getCoverUrl(mangaId)
    local data = apiJson(API .. "/cover?manga[]=" .. mangaId .. "&limit=1")
    if not data or not data.data or not data.data[1] then return nil end
    local cover = data.data[1]
    local rel = cover.relationships
    if not rel then return nil end
    for _, r in ipairs(rel) do
        if r.type == "cover_art" then
            local fname = r.attributes and r.attributes.fileName
            if fname then
                return UPLOADS .. "/covers/" .. mangaId .. "/" .. fname .. ".256.jpg"
            end
        end
    end
    return nil
end

local function searchManga(keyword)
    clearList()
    list.Visible = true
    readerView.Visible = false
    crumbLbl.Text = "搜索结果"
    countLbl.Text = ""
    backBtn.Visible = false
    setStatus("搜索中…")

    local url = API .. "/manga?title=" .. HttpService:UrlEncode(keyword)
        .. "&limit=20&contentRating[]=safe&contentRating[]=suggestive"

    local data = apiJson(url)
    if not data or not data.data then
        setStatus("搜索失败", C.accent)
        return
    end

    countLbl.Text = #data.data .. " 部"
    setStatus("找到 " .. #data.data .. " 部漫画")

    for _, m in ipairs(data.data) do
        local attrs = m.attributes or {}
        local titleText = "?"
        if attrs.title then
            titleText = attrs.title.en or attrs.title.ja or attrs.title["zh"]
                or (next(attrs.title) and attrs.title[next(attrs.title)]) or "?"
        end
        local mId = m.id

        local sub = ""
        if attrs.year then sub = tostring(attrs.year) end
        if attrs.status then
            sub = sub .. (sub ~= "" and "  ·  " or "") .. tostring(attrs.status)
        end

        addRow(nil, tostring(titleText), sub, function()
            clearList()
            crumbLbl.Text = tostring(titleText)
            countLbl.Text = ""
            backBtn.Visible = true
            setStatus("获取章节…")

            local chUrl = API .. "/manga/" .. mId
                .. "/feed?limit=100&translatedLanguage[]=en&translatedLanguage[]=zh&order[chapter]=asc"
            local chData = apiJson(chUrl)
            if not chData or not chData.data then
                setStatus("获取章节失败", C.accent)
                return
            end

            local chapters = {}
            for _, ch in ipairs(chData.data) do
                local ca = ch.attributes or {}
                local chapNum = tostring(ca.chapter or "?")
                table.insert(chapters, {
                    id = ch.id,
                    label = "第" .. chapNum .. "话",
                    chapNum = chapNum,
                })
            end

            countLbl.Text = #chapters .. " 章"
            setStatus("共 " .. #chapters .. " 章，点击阅读")

            for pos, chInfo in ipairs(chapters) do
                local ca = chData.data[pos].attributes or {}
                local subCh = ca.title and tostring(ca.title) or ""
                if ca.translatedLanguage then
                    subCh = (subCh ~= "" and (subCh .. "  ·  ") or "")
                        .. tostring(ca.translatedLanguage)
                end

                addRow(nil, chInfo.label, subCh, function()
                    openReader(chInfo.id, chInfo.label, titleText, pos, chapters)
                end)
            end
        end)
    end
end

backBtn.MouseButton1Click:Connect(function()
    if readerView.Visible then
        readerView.Visible = false
        list.Visible = true
        clearList()
        local kw = searchBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
        if kw ~= "" then
            searchManga(kw)
        end
    else
        clearList()
        crumbLbl.Text = "搜索结果"
        backBtn.Visible = false
    end
end)

searchBtn.MouseButton1Click:Connect(function()
    local kw = searchBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
    if kw == "" then
        setStatus("请输入关键词", C.accent)
        return
    end
    searchManga(kw)
end)

searchBox.FocusLost:Connect(function(enter)
    if enter then
        local kw = searchBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
        if kw ~= "" then searchManga(kw) end
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if not readerView.Visible then return end

    if input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.A then
        if reader.index > 1 then
            reader.index = reader.index - 1
            renderPage()
        end
    elseif input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.D then
        if reader.index < #reader.pages then
            reader.index = reader.index + 1
            renderPage()
        end
    elseif input.KeyCode == Enum.KeyCode.Up or input.KeyCode == Enum.KeyCode.W then
        gotoChapter(-1)
    elseif input.KeyCode == Enum.KeyCode.Down or input.KeyCode == Enum.KeyCode.S then
        gotoChapter(1)
    end
end)

do
    local dragging, dragInput, dragStart, startPos
    bar.InputBegan:Connect(function(input)
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
    bar.InputChanged:Connect(function(input)
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