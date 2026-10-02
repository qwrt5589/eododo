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
    base    = Color3.fromRGB(16, 17, 19),
    surface = Color3.fromRGB(22, 23, 26),
    raise   = Color3.fromRGB(28, 29, 33),
    line    = Color3.fromRGB(38, 40, 45),
    text    = Color3.fromRGB(232, 234, 238),
    sub     = Color3.fromRGB(150, 153, 162),
    mute    = Color3.fromRGB(96, 99, 108),
    accent  = Color3.fromRGB(210, 90, 90),
    accentD = Color3.fromRGB(172, 70, 70),
    ok      = Color3.fromRGB(126, 190, 148),
    adult   = Color3.fromRGB(190, 80, 140),
}

local SORT_OPTIONS = {
    { key = "followedCount", label = "热度" },
    { key = "latestUploadedChapter", label = "最近更新" },
    { key = "relevance", label = "相关度" },
    { key = "rating", label = "评分" },
    { key = "createdAt", label = "创建时间" },
}
local currentSort = 1

local TAG_OPTIONS = {
    { id = "", label = "不限" },
    { id = "391b0423-d847-456f-aff0-8b0cfc03066b", label = "动作" },
    { id = "423e2eae-a7a2-4a8b-ac03-a8351462d71d", label = "恋爱" },
    { id = "4d32cc48-9f00-4cca-9b5a-a839f0764984", label = "喜剧" },
    { id = "cdc58593-87dd-415e-bbc0-2ec27bf404cc", label = "奇幻" },
    { id = "e5301a23-ebd9-49dd-a0cb-2add944c7fe9", label = "剧情" },
    { id = "ee968100-4191-4968-93d3-f82d72be7e46", label = "悬疑" },
    { id = "07251805-a27e-4d59-b488-f0bfbec15168", label = "惊悚" },
    { id = "87cc81b4-e50c-4b21-8c61-0ff01ef635a3", label = "日常" },
}
local currentTag = 1

-- ★ 分类浏览标签（新增 18+）
local BROWSE_TAGS = {
    { id = "", label = "全部" },
    { id = "__18PLUS__", label = "18+" },   -- 特殊标记，只请求成人向
    { id = "391b0423-d847-456f-aff0-8b0cfc03066b", label = "动作" },
    { id = "423e2eae-a7a2-4a8b-ac03-a8351462d71d", label = "恋爱" },
    { id = "4d32cc48-9f00-4cca-9b5a-a839f0764984", label = "喜剧" },
    { id = "cdc58593-87dd-415e-bbc0-2ec27bf404cc", label = "奇幻" },
    { id = "e5301a23-ebd9-49dd-a0cb-2add944c7fe9", label = "剧情" },
    { id = "ee968100-4191-4968-93d3-f82d72be7e46", label = "悬疑" },
    { id = "07251805-a27e-4d59-b488-f0bfbec15168", label = "惊悚" },
    { id = "87cc81b4-e50c-4b21-8c61-0ff01ef635a3", label = "日常" },
    { id = "a1f53773-c69a-4ce5-8cab-fffcd90b1565", label = "科幻" },
    { id = "799c202e-7daa-44eb-9cf7-8a3c0441531e", label = "生活" },
    { id = "ace04997-f6bd-436e-b261-7793a65a754a", label = "治愈" },
}
local browseTagIndex = 1

local BROWSE_YEARS = {
    { value = nil, label = "全部年份" },
    { value = 2026, label = "2026" },
    { value = 2025, label = "2025" },
    { value = 2024, label = "2024" },
    { value = 2023, label = "2023" },
    { value = 2022, label = "2022" },
    { value = 2020, label = "2020" },
    { value = 2018, label = "2018" },
    { value = 2015, label = "2015" },
    { value = 2010, label = "2010 之前" },
}
local browseYearIndex = 1

-- ★ 主页区块（全部包含成人向）
local HOME_SECTIONS = {
    { title = "热门推荐", sort = "followedCount", tag = nil },
    { title = "最近更新", sort = "latestUploadedChapter", tag = nil },
    { title = "18+ 精选", sort = "followedCount", tag = "__18PLUS__" },
    { title = "动作",     sort = "followedCount", tag = "391b0423-d847-456f-aff0-8b0cfc03066b" },
    { title = "恋爱",     sort = "followedCount", tag = "423e2eae-a7a2-4a8b-ac03-a8351462d71d" },
    { title = "喜剧",     sort = "followedCount", tag = "4d32cc48-9f00-4cca-9b5a-a839f0764984" },
    { title = "奇幻",     sort = "followedCount", tag = "cdc58593-87dd-415e-bbc0-2ec27bf404cc" },
}

-- ★ 统一的分级参数：默认包含成人向
local CONTENT_RATING = "&contentRating[]=safe&contentRating[]=suggestive&contentRating[]=erotica&contentRating[]=pornographic"
-- ★ 仅成人向
local CONTENT_RATING_18 = "&contentRating[]=erotica&contentRating[]=pornographic"

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
gui.Name = "MiteaReader"
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
win.Size = UDim2.new(0, 800, 0, 540)
win.Position = UDim2.new(0.5, -400, 0.5, -270)
win.BackgroundColor3 = C.base
win.BorderSizePixel = 0
win.Active = true
win.ClipsDescendants = true
win.Parent = gui
corner(win, 14)

local bgImg = Instance.new("ImageLabel")
bgImg.Size = UDim2.new(1, 0, 1, 0)
bgImg.BackgroundTransparency = 1
bgImg.Image = BG_IMAGE
bgImg.ScaleType = Enum.ScaleType.Crop
bgImg.ImageTransparency = 0.6
bgImg.ZIndex = 0
bgImg.Parent = win

local bgMask = Instance.new("Frame")
bgMask.Size = UDim2.new(1, 0, 1, 0)
bgMask.BackgroundColor3 = C.base
bgMask.BackgroundTransparency = 0.25
bgMask.BorderSizePixel = 0
bgMask.ZIndex = 1
bgMask.Parent = win

local maskGrad = Instance.new("UIGradient")
maskGrad.Rotation = 90
maskGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 9, 11)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 19, 22)),
})
maskGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.3),
    NumberSequenceKeypoint.new(1, 0.7),
})
maskGrad.Parent = bgMask

local winStroke = Instance.new("UIStroke")
winStroke.Color = Color3.fromRGB(60, 62, 70)
winStroke.Thickness = 1
winStroke.Transparency = 0.4
winStroke.Parent = win

local body = Instance.new("Frame")
body.Size = UDim2.new(1, 0, 1, -54)
body.Position = UDim2.new(0, 0, 0, 54)
body.BackgroundTransparency = 1
body.ZIndex = 3
body.Parent = win

local bar = Instance.new("Frame")
bar.Size = UDim2.new(1, 0, 0, 54)
bar.BackgroundColor3 = C.surface
bar.BackgroundTransparency = 0.5
bar.BorderSizePixel = 0
bar.ZIndex = 3
bar.Parent = win
corner(bar, 14)
local barFix = Instance.new("Frame")
barFix.Size = UDim2.new(1, 0, 0, 14)
barFix.Position = UDim2.new(0, 0, 1, -14)
barFix.BackgroundColor3 = C.surface
barFix.BackgroundTransparency = 0.5
barFix.BorderSizePixel = 0
barFix.ZIndex = 3
barFix.Parent = bar

local barLine = Instance.new("Frame")
barLine.Size = UDim2.new(1, 0, 0, 1)
barLine.Position = UDim2.new(0, 0, 1, -1)
barLine.BackgroundColor3 = C.line
barLine.BorderSizePixel = 0
barLine.ZIndex = 4
barLine.Parent = bar

local mark = Instance.new("Frame")
mark.Size = UDim2.new(0, 4, 0, 20)
mark.Position = UDim2.new(0, 22, 0, 17)
mark.BackgroundColor3 = C.accent
mark.BorderSizePixel = 0
mark.ZIndex = 5
mark.Parent = bar
corner(mark, 2)

local brandLbl = label(bar, 36, 0, 260, 54, "Mitea 阅读器", 16, C.text, Enum.Font.GothamMedium)
brandLbl.ZIndex = 5

local authorChip = Instance.new("Frame")
authorChip.Size = UDim2.new(0, 216, 0, 26)
authorChip.Position = UDim2.new(0, 220, 0, 14)
authorChip.BackgroundColor3 = C.raise
authorChip.BackgroundTransparency = 0.3
authorChip.BorderSizePixel = 0
authorChip.ZIndex = 5
authorChip.Parent = bar
corner(authorChip, 13)
local acStroke = Instance.new("UIStroke")
acStroke.Color = C.line
acStroke.Thickness = 1
acStroke.Transparency = 0.3
acStroke.Parent = authorChip
label(authorChip, 12, 0, 200, 26,
    "作者 " .. AUTHOR_NAME .. "   ·   QQ " .. AUTHOR_QQ,
    11, C.sub, Enum.Font.Gotham).ZIndex = 6

local function navChip(xOffset, w, txt)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w, 0, 28)
    b.Position = UDim2.new(1, xOffset, 0, 13)
    b.BackgroundColor3 = C.raise
    b.BackgroundTransparency = 0.3
    b.Text = txt
    b.TextColor3 = C.sub
    b.TextSize = 11
    b.Font = Enum.Font.Gotham
    b.AutoButtonColor = false
    b.ZIndex = 5
    b.Parent = bar
    corner(b, 8)
    b.MouseEnter:Connect(function()
        b.BackgroundTransparency = 0.15
        b.TextColor3 = C.text
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundTransparency = 0.3
        b.TextColor3 = C.sub
    end)
    return b
end

local browseNavBtn = navChip(-310, 58, "分类")
local homeNavBtn = navChip(-246, 58, "主页")

local function topBtn(xOffset, txt)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 30, 0, 30)
    b.Position = UDim2.new(1, xOffset, 0, 12)
    b.BackgroundColor3 = C.raise
    b.BackgroundTransparency = 0.3
    b.Text = txt
    b.TextColor3 = C.mute
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = false
    b.ZIndex = 5
    b.Parent = bar
    corner(b, 8)
    return b
end

local minBtn = topBtn(-82, "—")
local closeBtn = topBtn(-44, "✕")

minBtn.MouseEnter:Connect(function()
    TweenService:Create(minBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = C.accent, TextColor3 = C.text, BackgroundTransparency = 0
    }):Play()
end)
minBtn.MouseLeave:Connect(function()
    TweenService:Create(minBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = C.raise, TextColor3 = C.mute, BackgroundTransparency = 0.3
    }):Play()
end)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = C.accentD, TextColor3 = C.text, BackgroundTransparency = 0
    }):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = C.raise, TextColor3 = C.mute, BackgroundTransparency = 0.3
    }):Play()
end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local minimized = false
local restoreSize = UDim2.new(0, 800, 0, 540)
local miniSize = UDim2.new(0, 800, 0, 54)

minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        body.Visible = false
        TweenService:Create(win, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { Size = miniSize }):Play()
        minBtn.Text = "▢"
    else
        TweenService:Create(win, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { Size = restoreSize }):Play()
        task.delay(0.1, function() body.Visible = true end)
        minBtn.Text = "—"
    end
end)

local sideW = 224
local side = Instance.new("Frame")
side.Size = UDim2.new(0, sideW, 1, 0)
side.BackgroundColor3 = C.surface
side.BackgroundTransparency = 0.35
side.BorderSizePixel = 0
side.ZIndex = 3
side.Parent = body

local sideEdge = Instance.new("Frame")
sideEdge.Size = UDim2.new(0, 1, 1, 0)
sideEdge.Position = UDim2.new(0, sideW, 0, 0)
sideEdge.BackgroundColor3 = C.line
sideEdge.BackgroundTransparency = 0.3
sideEdge.BorderSizePixel = 0
sideEdge.ZIndex = 4
sideEdge.Parent = body

label(side, 24, 20, 180, 14, "搜索", 11, C.mute, Enum.Font.GothamBold).ZIndex = 5

local searchWrap = Instance.new("Frame")
searchWrap.Size = UDim2.new(1, -48, 0, 38)
searchWrap.Position = UDim2.new(0, 24, 0, 42)
searchWrap.BackgroundColor3 = C.base
searchWrap.BackgroundTransparency = 0.2
searchWrap.BorderSizePixel = 0
searchWrap.ZIndex = 5
searchWrap.Parent = side
corner(searchWrap, 9)
local swStroke = Instance.new("UIStroke")
swStroke.Color = C.line
swStroke.Thickness = 1
swStroke.Transparency = 0.2
swStroke.Parent = searchWrap

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -24, 1, 0)
searchBox.Position = UDim2.new(0, 12, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.Text = ""
searchBox.PlaceholderText = "漫画名称…"
searchBox.PlaceholderColor3 = C.mute
searchBox.TextColor3 = C.text
searchBox.TextSize = 13
searchBox.Font = Enum.Font.Gotham
searchBox.ClearTextOnFocus = false
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ZIndex = 6
searchBox.Parent = searchWrap

searchBox.Focused:Connect(function()
    TweenService:Create(swStroke, TweenInfo.new(0.15), { Color = C.accent, Transparency = 0 }):Play()
end)
searchBox.FocusLost:Connect(function()
    TweenService:Create(swStroke, TweenInfo.new(0.15), { Color = C.line, Transparency = 0.2 }):Play()
end)

local function optBtn(yOffset, text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -48, 0, 32)
    b.Position = UDim2.new(0, 24, 0, yOffset)
    b.BackgroundColor3 = C.raise
    b.BackgroundTransparency = 0.4
    b.Text = text
    b.TextColor3 = C.sub
    b.TextSize = 11
    b.Font = Enum.Font.Gotham
    b.AutoButtonColor = false
    b.ZIndex = 5
    b.Parent = side
    corner(b, 8)
    local st = Instance.new("UIStroke")
    st.Color = C.line
    st.Thickness = 1
    st.Transparency = 0.5
    st.Parent = b
    b.MouseEnter:Connect(function()
        b.BackgroundTransparency = 0.15
        b.TextColor3 = C.text
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundTransparency = 0.4
        b.TextColor3 = C.sub
    end)
    return b
end

local sortBtn = optBtn(86, "排序  ·  热度")
local tagBtn = optBtn(122, "标签  ·  不限")

local searchBtn = Instance.new("TextButton")
searchBtn.Size = UDim2.new(1, -48, 0, 38)
searchBtn.Position = UDim2.new(0, 24, 0, 162)
searchBtn.BackgroundColor3 = C.accent
searchBtn.Text = "搜 索"
searchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBtn.TextSize = 13
searchBtn.Font = Enum.Font.GothamBold
searchBtn.AutoButtonColor = false
searchBtn.ZIndex = 5
searchBtn.Parent = side
corner(searchBtn, 9)

searchBtn.MouseEnter:Connect(function()
    TweenService:Create(searchBtn, TweenInfo.new(0.15), { BackgroundColor3 = C.accentD }):Play()
end)
searchBtn.MouseLeave:Connect(function()
    TweenService:Create(searchBtn, TweenInfo.new(0.15), { BackgroundColor3 = C.accent }):Play()
end)

local homeBtn = Instance.new("TextButton")
homeBtn.Size = UDim2.new(1, -48, 0, 32)
homeBtn.Position = UDim2.new(0, 24, 0, 208)
homeBtn.BackgroundColor3 = C.raise
homeBtn.BackgroundTransparency = 0.4
homeBtn.Text = "主页"
homeBtn.TextColor3 = C.sub
homeBtn.TextSize = 11
homeBtn.Font = Enum.Font.Gotham
homeBtn.AutoButtonColor = false
homeBtn.ZIndex = 5
homeBtn.Parent = side
corner(homeBtn, 8)
local hbStroke = Instance.new("UIStroke")
hbStroke.Color = C.line
hbStroke.Thickness = 1
hbStroke.Transparency = 0.5
hbStroke.Parent = homeBtn
homeBtn.MouseEnter:Connect(function()
    homeBtn.BackgroundTransparency = 0.15
    homeBtn.TextColor3 = C.text
end)
homeBtn.MouseLeave:Connect(function()
    homeBtn.BackgroundTransparency = 0.4
    homeBtn.TextColor3 = C.sub
end)

local browseBtn = Instance.new("TextButton")
browseBtn.Size = UDim2.new(1, -48, 0, 32)
browseBtn.Position = UDim2.new(0, 24, 0, 246)
browseBtn.BackgroundColor3 = C.raise
browseBtn.BackgroundTransparency = 0.4
browseBtn.Text = "分类浏览"
browseBtn.TextColor3 = C.sub
browseBtn.TextSize = 11
browseBtn.Font = Enum.Font.Gotham
browseBtn.AutoButtonColor = false
browseBtn.ZIndex = 5
browseBtn.Parent = side
corner(browseBtn, 8)
local bbStroke = Instance.new("UIStroke")
bbStroke.Color = C.line
bbStroke.Thickness = 1
bbStroke.Transparency = 0.5
bbStroke.Parent = browseBtn
browseBtn.MouseEnter:Connect(function()
    browseBtn.BackgroundTransparency = 0.15
    browseBtn.TextColor3 = C.text
end)
browseBtn.MouseLeave:Connect(function()
    browseBtn.BackgroundTransparency = 0.4
    browseBtn.TextColor3 = C.sub
end)

sortBtn.MouseButton1Click:Connect(function()
    currentSort = currentSort + 1
    if currentSort > #SORT_OPTIONS then currentSort = 1 end
    sortBtn.Text = "排序  ·  " .. SORT_OPTIONS[currentSort].label
end)

tagBtn.MouseButton1Click:Connect(function()
    currentTag = currentTag + 1
    if currentTag > #TAG_OPTIONS then currentTag = 1 end
    tagBtn.Text = "标签  ·  " .. TAG_OPTIONS[currentTag].label
end)

local div1 = Instance.new("Frame")
div1.Size = UDim2.new(1, -48, 0, 1)
div1.Position = UDim2.new(0, 24, 0, 292)
div1.BackgroundColor3 = C.line
div1.BackgroundTransparency = 0.4
div1.BorderSizePixel = 0
div1.ZIndex = 5
div1.Parent = side

local clearCacheBtn = Instance.new("TextButton")
clearCacheBtn.Size = UDim2.new(1, -48, 0, 28)
clearCacheBtn.Position = UDim2.new(0, 24, 0, 306)
clearCacheBtn.BackgroundColor3 = C.raise
clearCacheBtn.BackgroundTransparency = 0.4
clearCacheBtn.Text = "清空缓存"
clearCacheBtn.TextColor3 = C.sub
clearCacheBtn.TextSize = 11
clearCacheBtn.Font = Enum.Font.Gotham
clearCacheBtn.AutoButtonColor = false
clearCacheBtn.ZIndex = 5
clearCacheBtn.Parent = side
corner(clearCacheBtn, 8)

clearCacheBtn.MouseEnter:Connect(function()
    clearCacheBtn.BackgroundTransparency = 0.15
    clearCacheBtn.TextColor3 = C.accent
end)
clearCacheBtn.MouseLeave:Connect(function()
    clearCacheBtn.BackgroundTransparency = 0.4
    clearCacheBtn.TextColor3 = C.sub
end)

clearCacheBtn.MouseButton1Click:Connect(function()
    imageCache = {}
    if delfolder then
        pcall(function() delfolder(TEMP_DIR) end)
    end
    setStatus("缓存已清空", C.ok)
end)

local credit = Instance.new("Frame")
credit.Size = UDim2.new(1, -48, 0, 1)
credit.Position = UDim2.new(0, 24, 1, -96)
credit.BackgroundColor3 = C.line
credit.BackgroundTransparency = 0.5
credit.BorderSizePixel = 0
credit.ZIndex = 5
credit.Parent = side

local creditLine1 = label(side, 24, 0, sideW - 48, 14, "本工具作者", 10, C.mute, Enum.Font.Gotham)
creditLine1.Position = UDim2.new(0, 24, 1, -76)
creditLine1.ZIndex = 5

local creditLine2 = label(side, 24, 0, sideW - 48, 22, AUTHOR_NAME, 15, C.text, Enum.Font.GothamBold)
creditLine2.Position = UDim2.new(0, 24, 1, -60)
creditLine2.ZIndex = 5

local creditLine3 = label(side, 24, 0, sideW - 48, 16, "QQ " .. AUTHOR_QQ, 11, C.accent, Enum.Font.Code)
creditLine3.Position = UDim2.new(0, 24, 1, -36)
creditLine3.ZIndex = 5

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -sideW - 1, 1, 0)
content.Position = UDim2.new(0, sideW + 1, 0, 0)
content.BackgroundTransparency = 1
content.ZIndex = 3
content.Parent = body

local crumb = Instance.new("Frame")
crumb.Size = UDim2.new(1, 0, 0, 44)
crumb.BackgroundTransparency = 1
crumb.ZIndex = 4
crumb.Parent = content

local crumbLine = Instance.new("Frame")
crumbLine.Size = UDim2.new(1, 0, 0, 1)
crumbLine.Position = UDim2.new(0, 0, 1, -1)
crumbLine.BackgroundColor3 = C.line
crumbLine.BackgroundTransparency = 0.4
crumbLine.BorderSizePixel = 0
crumbLine.ZIndex = 4
crumbLine.Parent = crumb

local crumbLbl = label(crumb, 28, 0, 460, 44, "主页", 13, C.sub, Enum.Font.Gotham)
crumbLbl.TextTruncate = Enum.TextTruncate.AtEnd
crumbLbl.ZIndex = 5

local backBtn = Instance.new("TextButton")
backBtn.Size = UDim2.new(0, 64, 0, 26)
backBtn.Position = UDim2.new(1, -190, 0, 9)
backBtn.BackgroundColor3 = C.raise
backBtn.BackgroundTransparency = 0.4
backBtn.Text = "← 返回"
backBtn.TextColor3 = C.sub
backBtn.TextSize = 11
backBtn.Font = Enum.Font.Gotham
backBtn.AutoButtonColor = false
backBtn.Visible = false
backBtn.ZIndex = 5
backBtn.Parent = crumb
corner(backBtn, 8)

backBtn.MouseEnter:Connect(function()
    backBtn.BackgroundTransparency = 0.15
    backBtn.TextColor3 = C.text
end)
backBtn.MouseLeave:Connect(function()
    backBtn.BackgroundTransparency = 0.4
    backBtn.TextColor3 = C.sub
end)

local countLbl = label(crumb, 0, 0, 110, 44, "", 11, C.mute, Enum.Font.Gotham)
countLbl.Position = UDim2.new(1, -120, 0, 0)
countLbl.TextXAlignment = Enum.TextXAlignment.Right
countLbl.ZIndex = 5

local footer = Instance.new("Frame")
footer.Size = UDim2.new(1, 0, 0, 48)
footer.Position = UDim2.new(0, 0, 1, -48)
footer.BackgroundColor3 = C.surface
footer.BackgroundTransparency = 0.5
footer.BorderSizePixel = 0
footer.ZIndex = 4
footer.Parent = content

local footerLine = Instance.new("Frame")
footerLine.Size = UDim2.new(1, 0, 0, 1)
footerLine.BackgroundColor3 = C.line
footerLine.BackgroundTransparency = 0.4
footerLine.BorderSizePixel = 0
footerLine.ZIndex = 5
footerLine.Parent = footer

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 6, 0, 6)
statusDot.Position = UDim2.new(0, 26, 0, 21)
statusDot.BackgroundColor3 = C.mute
statusDot.BorderSizePixel = 0
statusDot.ZIndex = 5
statusDot.Parent = footer
corner(statusDot, 3)

local statusLbl = label(footer, 40, 0, 560, 48, "就绪", 11, C.sub, Enum.Font.Gotham)
statusLbl.TextTruncate = Enum.TextTruncate.AtEnd
statusLbl.ZIndex = 5

local footerCredit = label(footer, 0, 0, 180, 48,
    AUTHOR_NAME .. "  ·  " .. AUTHOR_QQ,
    10, C.mute, Enum.Font.Gotham)
footerCredit.Position = UDim2.new(1, -192, 0, 0)
footerCredit.TextXAlignment = Enum.TextXAlignment.Right
footerCredit.ZIndex = 5

local function setStatus(t, color)
    statusLbl.Text = t
    statusDot.BackgroundColor3 = color or C.mute
end

local homeView = Instance.new("ScrollingFrame")
homeView.Size = UDim2.new(1, -52, 1, -104)
homeView.Position = UDim2.new(0, 26, 0, 56)
homeView.BackgroundTransparency = 1
homeView.BorderSizePixel = 0
homeView.ScrollBarThickness = 2
homeView.ScrollBarImageColor3 = C.line
homeView.CanvasSize = UDim2.new(0, 0, 0, 0)
homeView.AutomaticCanvasSize = Enum.AutomaticSize.Y
homeView.ZIndex = 4
homeView.Parent = content

local homeLayout = Instance.new("UIListLayout")
homeLayout.Padding = UDim.new(0, 26)
homeLayout.Parent = homeView

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -52, 1, -104)
list.Position = UDim2.new(0, 26, 0, 56)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 2
list.ScrollBarImageColor3 = C.line
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.Visible = false
list.ZIndex = 4
list.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = list

local browseView = Instance.new("Frame")
browseView.Size = UDim2.new(1, 0, 1, -48)
browseView.Position = UDim2.new(0, 0, 0, 44)
browseView.BackgroundTransparency = 1
browseView.Visible = false
browseView.ZIndex = 4
browseView.Parent = content

local tagBar = Instance.new("Frame")
tagBar.Size = UDim2.new(1, -52, 0, 36)
tagBar.Position = UDim2.new(0, 26, 0, 6)
tagBar.BackgroundTransparency = 1
tagBar.ZIndex = 5
tagBar.Parent = browseView

local tagBarScroll = Instance.new("ScrollingFrame")
tagBarScroll.Size = UDim2.new(1, 0, 1, 0)
tagBarScroll.BackgroundTransparency = 1
tagBarScroll.BorderSizePixel = 0
tagBarScroll.ScrollBarThickness = 0
tagBarScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
tagBarScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
tagBarScroll.ScrollingDirection = Enum.ScrollingDirection.X
tagBarScroll.ZIndex = 5
tagBarScroll.Parent = tagBar

local tagBarLayout = Instance.new("UIListLayout")
tagBarLayout.FillDirection = Enum.FillDirection.Horizontal
tagBarLayout.Padding = UDim.new(0, 8)
tagBarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tagBarLayout.Parent = tagBarScroll

local yearBar = Instance.new("Frame")
yearBar.Size = UDim2.new(1, -52, 0, 32)
yearBar.Position = UDim2.new(0, 26, 0, 48)
yearBar.BackgroundTransparency = 1
yearBar.ZIndex = 5
yearBar.Parent = browseView

local yearBarScroll = Instance.new("ScrollingFrame")
yearBarScroll.Size = UDim2.new(1, 0, 1, 0)
yearBarScroll.BackgroundTransparency = 1
yearBarScroll.BorderSizePixel = 0
yearBarScroll.ScrollBarThickness = 0
yearBarScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
yearBarScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
yearBarScroll.ScrollingDirection = Enum.ScrollingDirection.X
yearBarScroll.ZIndex = 5
yearBarScroll.Parent = yearBar

local yearBarLayout = Instance.new("UIListLayout")
yearBarLayout.FillDirection = Enum.FillDirection.Horizontal
yearBarLayout.Padding = UDim.new(0, 8)
yearBarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
yearBarLayout.Parent = yearBarScroll

local browseGrid = Instance.new("ScrollingFrame")
browseGrid.Size = UDim2.new(1, -52, 1, -140)
browseGrid.Position = UDim2.new(0, 26, 0, 88)
browseGrid.BackgroundTransparency = 1
browseGrid.BorderSizePixel = 0
browseGrid.ScrollBarThickness = 2
browseGrid.ScrollBarImageColor3 = C.line
browseGrid.CanvasSize = UDim2.new(0, 0, 0, 0)
browseGrid.AutomaticCanvasSize = Enum.AutomaticSize.Y
browseGrid.ZIndex = 5
browseGrid.Parent = browseView

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 112, 0, 190)
gridLayout.CellPadding = UDim2.new(0, 12, 0, 16)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.Parent = browseGrid

local readerView = Instance.new("Frame")
readerView.Size = UDim2.new(1, -52, 1, -104)
readerView.Position = UDim2.new(0, 26, 0, 56)
readerView.BackgroundTransparency = 1
readerView.Visible = false
readerView.ZIndex = 4
readerView.Parent = content

local readerImg = Instance.new("ImageLabel")
readerImg.Size = UDim2.new(1, 0, 1, -64)
readerImg.BackgroundColor3 = Color3.fromRGB(10, 11, 13)
readerImg.BackgroundTransparency = 0.15
readerImg.BorderSizePixel = 0
readerImg.Image = ""
readerImg.ScaleType = Enum.ScaleType.Fit
readerImg.ZIndex = 5
readerImg.Parent = readerView
corner(readerImg, 10)

local readerInfo = label(readerView, 4, 0, 420, 20, "", 11, C.mute, Enum.Font.Gotham)
readerInfo.Position = UDim2.new(0, 4, 1, -56)
readerInfo.ZIndex = 5

local function navBtn(x, w, text, warm)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, w, 0, 36)
    b.Position = UDim2.new(0, x, 1, -38)
    b.BackgroundColor3 = warm and Color3.fromRGB(50, 44, 40) or C.raise
    b.BackgroundTransparency = 0.2
    b.Text = text
    b.TextColor3 = warm and Color3.fromRGB(226, 196, 140) or C.text
    b.TextSize = 11
    b.Font = Enum.Font.GothamMedium
    b.AutoButtonColor = false
    b.ZIndex = 5
    b.Parent = readerView
    corner(b, 9)
    local st = Instance.new("UIStroke")
    st.Color = warm and Color3.fromRGB(90, 74, 58) or C.line
    st.Thickness = 1
    st.Transparency = 0.4
    st.Parent = b
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.12), { BackgroundTransparency = 0 }):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.12), { BackgroundTransparency = 0.2 }):Play()
    end)
    return b
end

local prevChapBtn = navBtn(4, 80, "⇤ 上一话", true)
local prevBtn = navBtn(92, 80, "← 上一页", false)
local nextBtn = navBtn(180, 80, "下一页 →", false)
local nextChapBtn = navBtn(268, 80, "下一话 ⇥", true)

local exportBtn = Instance.new("TextButton")
exportBtn.Size = UDim2.new(0, 108, 0, 36)
exportBtn.Position = UDim2.new(1, -112, 1, -38)
exportBtn.BackgroundColor3 = C.accent
exportBtn.Text = "导出本话"
exportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exportBtn.TextSize = 11
exportBtn.Font = Enum.Font.GothamBold
exportBtn.AutoButtonColor = false
exportBtn.ZIndex = 5
exportBtn.Parent = readerView
corner(exportBtn, 9)

exportBtn.MouseEnter:Connect(function()
    TweenService:Create(exportBtn, TweenInfo.new(0.12), { BackgroundColor3 = C.accentD }):Play()
end)
exportBtn.MouseLeave:Connect(function()
    TweenService:Create(exportBtn, TweenInfo.new(0.12), { BackgroundColor3 = C.accent }):Play()
end)

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
    readerInfo.Text = string.format("%s   %d / %d", reader.chapterLabel, idx, #reader.pages)

    if HAS_CUSTOMASSET and HAS_WRITEFILE then
        if imageCache[url] then
            readerImg.Image = imageCache[url]
            setStatus("第 " .. idx .. " 页", C.ok)
        else
            setStatus("加载第 " .. idx .. " 页…")
            task.spawn(function()
                local asset = loadImage(url)
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
        readerInfo.Text = string.format("%s   %d / %d  （不支持预览）",
            reader.chapterLabel, idx, #reader.pages)
    end
end

local function loadChapter(chapterId, chapterLabel, chapPos)
    reader.pages = {}
    reader.index = 1
    reader.chapterId = chapterId
    reader.chapterLabel = chapterLabel
    if chapPos then reader.chapPos = chapPos end

    local crumbText = tostring(reader.title) .. "   ·   " .. chapterLabel
    if #reader.chapters > 0 then
        crumbText = crumbText .. string.format("   %d / %d", reader.chapPos, #reader.chapters)
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

local openManga

local function openReader(chapterId, chapterLabel, mangaTitle, chapPos, chapters)
    homeView.Visible = false
    list.Visible = false
    browseView.Visible = false
    readerView.Visible = true
    backBtn.Visible = true

    reader.title = mangaTitle
    if chapters then reader.chapters = chapters end
    if chapPos then reader.chapPos = chapPos end

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

    local safeTitle = tostring(reader.title or "未知漫画"):gsub("[\\/:*?\"<>|]", "_"):sub(1, 40)
    local safeChap = tostring(reader.chapterLabel or "未知章节"):gsub("[\\/:*?\"<>|]", "_"):sub(1, 20)
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

local function clearList()
    for _, c in ipairs(list:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end
    end
end

local function clearHome()
    for _, c in ipairs(homeView:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
end

local function clearGrid()
    for _, c in ipairs(browseGrid:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
end

local function showHome()
    homeView.Visible = true
    list.Visible = false
    browseView.Visible = false
    readerView.Visible = false
    backBtn.Visible = false
    crumbLbl.Text = "主页"
    countLbl.Text = ""
end

local function showList(titleText)
    homeView.Visible = false
    list.Visible = true
    browseView.Visible = false
    readerView.Visible = false
    crumbLbl.Text = titleText
end

local function showBrowse()
    homeView.Visible = false
    list.Visible = false
    browseView.Visible = true
    readerView.Visible = false
    backBtn.Visible = false
    crumbLbl.Text = "分类浏览"
end

local function addListRow(coverUrl, mainText, subText, onClick)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, -4, 0, 62)
    row.BackgroundColor3 = C.raise
    row.BackgroundTransparency = 0.5
    row.Text = ""
    row.AutoButtonColor = false
    row.BorderSizePixel = 0
    row.ZIndex = 5
    row.Parent = list
    corner(row, 10)

    local rowStroke = Instance.new("UIStroke")
    rowStroke.Color = C.line
    rowStroke.Thickness = 1
    rowStroke.Transparency = 0.5
    rowStroke.Parent = row

    local hasThumb = coverUrl and HAS_CUSTOMASSET and HAS_WRITEFILE
    if hasThumb then
        local thumb = Instance.new("ImageLabel")
        thumb.Size = UDim2.new(0, 36, 0, 46)
        thumb.Position = UDim2.new(0, 12, 0, 8)
        thumb.BackgroundColor3 = C.base
        thumb.BorderSizePixel = 0
        thumb.Image = ""
        thumb.ScaleType = Enum.ScaleType.Crop
        thumb.ZIndex = 8
        thumb.Parent = row
        corner(thumb, 6)

        task.spawn(function()
            local asset = loadImage(coverUrl)
            if asset and thumb.Parent then
                thumb.Image = asset
            end
        end)
    end

    local textX = hasThumb and 58 or 16

    local t1 = Instance.new("TextLabel")
    t1.Size = UDim2.new(1, -(textX + 44), 0, 20)
    t1.Position = UDim2.new(0, textX, 0, 11)
    t1.BackgroundTransparency = 1
    t1.Text = mainText
    t1.TextColor3 = C.text
    t1.TextSize = 13
    t1.Font = Enum.Font.GothamMedium
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.TextTruncate = Enum.TextTruncate.AtEnd
    t1.ZIndex = 8
    t1.Parent = row

    if subText and subText ~= "" then
        local t2 = Instance.new("TextLabel")
        t2.Size = UDim2.new(1, -(textX + 44), 0, 16)
        t2.Position = UDim2.new(0, textX, 0, 33)
        t2.BackgroundTransparency = 1
        t2.Text = subText
        t2.TextColor3 = C.mute
        t2.TextSize = 10
        t2.Font = Enum.Font.Gotham
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextTruncate = Enum.TextTruncate.AtEnd
        t2.ZIndex = 8
        t2.Parent = row
    end

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 24, 1, 0)
    arrow.Position = UDim2.new(1, -32, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "›"
    arrow.TextColor3 = C.mute
    arrow.TextSize = 18
    arrow.Font = Enum.Font.GothamBold
    arrow.ZIndex = 8
    arrow.Parent = row

    row.MouseEnter:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), { BackgroundTransparency = 0.25 }):Play()
        TweenService:Create(rowStroke, TweenInfo.new(0.15), { Transparency = 0.2, Color = C.accent }):Play()
        TweenService:Create(arrow, TweenInfo.new(0.15), { TextColor3 = C.accent, Position = UDim2.new(1, -26, 0, 0) }):Play()
    end)
    row.MouseLeave:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.15), { BackgroundTransparency = 0.5 }):Play()
        TweenService:Create(rowStroke, TweenInfo.new(0.15), { Transparency = 0.5, Color = C.line }):Play()
        TweenService:Create(arrow, TweenInfo.new(0.15), { TextColor3 = C.mute, Position = UDim2.new(1, -32, 0, 0) }):Play()
    end)

    if onClick then
        row.MouseButton1Click:Connect(onClick)
    end

    return row
end

local function makeCard(parentFrame, coverUrl, mainText, subText, onClick)
    local card = Instance.new("TextButton")
    card.Size = UDim2.new(0, 112, 0, 190)
    card.BackgroundColor3 = C.raise
    card.BackgroundTransparency = 0.5
    card.Text = ""
    card.AutoButtonColor = false
    card.BorderSizePixel = 0
    card.ZIndex = 6
    card.Parent = parentFrame
    corner(card, 10)

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = C.line
    cardStroke.Thickness = 1
    cardStroke.Transparency = 0.5
    cardStroke.Parent = card

    local thumb = Instance.new("ImageLabel")
    thumb.Size = UDim2.new(1, -12, 0, 148)
    thumb.Position = UDim2.new(0, 6, 0, 6)
    thumb.BackgroundColor3 = C.base
    thumb.BorderSizePixel = 0
    thumb.Image = ""
    thumb.ScaleType = Enum.ScaleType.Crop
    thumb.ZIndex = 7
    thumb.Parent = card
    corner(thumb, 7)

    if coverUrl and HAS_CUSTOMASSET and HAS_WRITEFILE then
        task.spawn(function()
            local asset = loadImage(coverUrl)
            if asset and thumb.Parent then
                thumb.Image = asset
            end
        end)
    end

    local t1 = Instance.new("TextLabel")
    t1.Size = UDim2.new(1, -12, 0, 16)
    t1.Position = UDim2.new(0, 6, 0, 158)
    t1.BackgroundTransparency = 1
    t1.Text = mainText
    t1.TextColor3 = C.text
    t1.TextSize = 11
    t1.Font = Enum.Font.GothamMedium
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.TextTruncate = Enum.TextTruncate.AtEnd
    t1.ZIndex = 7
    t1.Parent = card

    local t2 = Instance.new("TextLabel")
    t2.Size = UDim2.new(1, -12, 0, 14)
    t2.Position = UDim2.new(0, 6, 0, 173)
    t2.BackgroundTransparency = 1
    t2.Text = subText or ""
    t2.TextColor3 = C.mute
    t2.TextSize = 9
    t2.Font = Enum.Font.Gotham
    t2.TextXAlignment = Enum.TextXAlignment.Left
    t2.TextTruncate = Enum.TextTruncate.AtEnd
    t2.ZIndex = 7
    t2.Parent = card

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), { BackgroundTransparency = 0.2 }):Play()
        TweenService:Create(cardStroke, TweenInfo.new(0.15), { Transparency = 0.2, Color = C.accent }):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), { BackgroundTransparency = 0.5 }):Play()
        TweenService:Create(cardStroke, TweenInfo.new(0.15), { Transparency = 0.5, Color = C.line }):Play()
    end)

    if onClick then
        card.MouseButton1Click:Connect(onClick)
    end

    return card
end

local function getCoverFromRelationships(relationships, mId)
    if not relationships then return nil end
    for _, r in ipairs(relationships) do
        if r.type == "cover_art" and r.attributes then
            local fname = r.attributes.fileName
            if fname then
                return UPLOADS .. "/covers/" .. mId .. "/" .. fname .. ".256.jpg"
            end
        end
    end
    return nil
end

local function getMangaTitle(attrs)
    if not attrs.title then return "?" end
    return attrs.title.en or attrs.title.ja or attrs.title["zh"]
        or (next(attrs.title) and attrs.title[next(attrs.title)]) or "?"
end

openManga = function(mId, titleText)
    clearList()
    showList(tostring(titleText))
    countLbl.Text = ""
    backBtn.Visible = true
    setStatus("获取章节…")

    -- ★ 章节请求也包含成人向分级
    local chUrl = API .. "/manga/" .. mId
        .. "/feed?limit=200"
        .. CONTENT_RATING
        .. "&order[chapter]=asc"

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
    if #chapters == 0 then
        setStatus("这部漫画没有可读章节", C.accent)
        return
    end

    setStatus("共 " .. #chapters .. " 章，点击阅读")

    for pos, chInfo in ipairs(chapters) do
        local ca = chData.data[pos].attributes or {}
        local subCh = ca.title and tostring(ca.title) or ""
        if ca.translatedLanguage then
            subCh = (subCh ~= "" and (subCh .. "   ·   ") or "")
                .. tostring(ca.translatedLanguage)
        end

        addListRow(nil, chInfo.label, subCh, function()
            openReader(chInfo.id, chInfo.label, titleText, pos, chapters)
        end)
    end
end

local function searchManga(keyword)
    clearList()
    showList("搜索结果")
    countLbl.Text = ""
    backBtn.Visible = true
    setStatus("搜索中…")

    local sortKey = SORT_OPTIONS[currentSort].key
    local tagId = TAG_OPTIONS[currentTag].id

    -- ★ 搜索默认包含成人向
    local url = API .. "/manga?title=" .. HttpService:UrlEncode(keyword)
        .. "&limit=20"
        .. CONTENT_RATING
        .. "&order[" .. sortKey .. "]=desc"
        .. "&includes[]=cover_art"

    if tagId ~= "" then
        url = url .. "&includedTags[]=" .. tagId
    end

    local data = apiJson(url)
    if not data or not data.data then
        setStatus("搜索失败", C.accent)
        return
    end

    countLbl.Text = #data.data .. " 部"
    setStatus("找到 " .. #data.data .. " 部漫画")

    for _, m in ipairs(data.data) do
        local attrs = m.attributes or {}
        local titleText = getMangaTitle(attrs)
        local mId = m.id

        local sub = ""
        if attrs.year then sub = tostring(attrs.year) end
        if attrs.status then
            sub = sub .. (sub ~= "" and "   ·   " or "") .. tostring(attrs.status)
        end

        local coverUrl = getCoverFromRelationships(m.relationships, mId)

        addListRow(coverUrl, tostring(titleText), sub, function()
            openManga(mId, titleText)
        end)
    end
end

local function loadHomeSection(section, rowFrame)
    -- ★ 根据区块是否 18+ 决定分级
    local ratingParam = (section.tag == "__18PLUS__") and CONTENT_RATING_18 or CONTENT_RATING

    local url = API .. "/manga?limit=12"
        .. ratingParam
        .. "&order[" .. section.sort .. "]=desc"
        .. "&includes[]=cover_art"

    if section.tag and section.tag ~= "__18PLUS__" then
        url = url .. "&includedTags[]=" .. section.tag
    end

    local data = apiJson(url)
    if not data or not data.data then return end

    for _, m in ipairs(data.data) do
        local attrs = m.attributes or {}
        local titleText = getMangaTitle(attrs)
        local mId = m.id

        local sub = ""
        if attrs.year then sub = tostring(attrs.year) end
        if attrs.status then
            sub = sub ~= "" and (sub .. " · " .. tostring(attrs.status)) or tostring(attrs.status)
        end

        local coverUrl = getCoverFromRelationships(m.relationships, mId)

        makeCard(rowFrame, coverUrl, tostring(titleText), sub, function()
            openManga(mId, titleText)
        end)
    end
end

local function buildHome()
    clearHome()
    setStatus("加载主页…")

    for _, section in ipairs(HOME_SECTIONS) do
        local block = Instance.new("Frame")
        block.Size = UDim2.new(1, 0, 0, 250)
        block.BackgroundTransparency = 1
        block.ZIndex = 5
        block.Parent = homeView

        local secTitle = Instance.new("TextLabel")
        secTitle.Size = UDim2.new(1, 0, 0, 24)
        secTitle.BackgroundTransparency = 1
        secTitle.Text = section.title
        secTitle.TextColor3 = (section.tag == "__18PLUS__") and C.adult or C.text
        secTitle.TextSize = 14
        secTitle.Font = Enum.Font.GothamBold
        secTitle.TextXAlignment = Enum.TextXAlignment.Left
        secTitle.ZIndex = 6
        secTitle.Parent = block

        local markLine = Instance.new("Frame")
        markLine.Size = UDim2.new(0, 3, 0, 14)
        markLine.Position = UDim2.new(0, -10, 0, 5)
        markLine.BackgroundColor3 = (section.tag == "__18PLUS__") and C.adult or C.accent
        markLine.BorderSizePixel = 0
        markLine.ZIndex = 6
        markLine.Parent = secTitle
        corner(markLine, 2)

        local rowScroll = Instance.new("ScrollingFrame")
        rowScroll.Size = UDim2.new(1, 0, 0, 200)
        rowScroll.Position = UDim2.new(0, 0, 0, 34)
        rowScroll.BackgroundTransparency = 1
        rowScroll.BorderSizePixel = 0
        rowScroll.ScrollBarThickness = 2
        rowScroll.ScrollBarImageColor3 = C.line
        rowScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        rowScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
        rowScroll.ScrollingDirection = Enum.ScrollingDirection.X
        rowScroll.ZIndex = 6
        rowScroll.Parent = block

        local rowLayout = Instance.new("UIListLayout")
        rowLayout.FillDirection = Enum.FillDirection.Horizontal
        rowLayout.Padding = UDim.new(0, 10)
        rowLayout.Parent = rowScroll

        task.spawn(function()
            loadHomeSection(section, rowScroll)
        end)
    end

    setStatus("主页已加载", C.ok)
end

local function refreshBrowse()
    clearGrid()
    setStatus("加载分类…")

    local tagInfo = BROWSE_TAGS[browseTagIndex]
    local yearInfo = BROWSE_YEARS[browseYearIndex]

    -- ★ 18+ 分类只请求成人向，其他分类默认包含成人向
    local ratingParam = CONTENT_RATING
    if tagInfo.id == "__18PLUS__" then
        ratingParam = CONTENT_RATING_18
    end

    local url = API .. "/manga?limit=40"
        .. ratingParam
        .. "&order[followedCount]=desc"
        .. "&includes[]=cover_art"

    if tagInfo.id ~= "" and tagInfo.id ~= "__18PLUS__" then
        url = url .. "&includedTags[]=" .. tagInfo.id
    end

    if yearInfo.value then
        url = url .. "&year=" .. tostring(yearInfo.value)
    end

    local data = apiJson(url)
    if not data or not data.data then
        setStatus("加载失败", C.accent)
        return
    end

    countLbl.Text = #data.data .. " 部"

    for _, m in ipairs(data.data) do
        local attrs = m.attributes or {}
        local titleText = getMangaTitle(attrs)
        local mId = m.id

        local sub = ""
        if attrs.year then sub = tostring(attrs.year) end
        if attrs.status then
            sub = sub ~= "" and (sub .. " · " .. tostring(attrs.status)) or tostring(attrs.status)
        end

        local coverUrl = getCoverFromRelationships(m.relationships, mId)

        makeCard(browseGrid, coverUrl, tostring(titleText), sub, function()
            openManga(mId, titleText)
        end)
    end

    setStatus("共 " .. #data.data .. " 部", C.ok)
end

local function buildTagBar()
    for _, c in ipairs(tagBarScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end

    for i, t in ipairs(BROWSE_TAGS) do
        local isAdult = (t.id == "__18PLUS__")
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 64, 0, 28)
        b.BackgroundColor3 = (i == browseTagIndex) and (isAdult and C.adult or C.accent) or C.raise
        b.BackgroundTransparency = (i == browseTagIndex) and 0 or 0.4
        b.Text = t.label
        b.TextColor3 = (i == browseTagIndex) and Color3.fromRGB(255, 255, 255) or C.sub
        b.TextSize = 11
        b.Font = Enum.Font.GothamMedium
        b.AutoButtonColor = false
        b.ZIndex = 6
        b.Parent = tagBarScroll
        corner(b, 8)

        b.MouseButton1Click:Connect(function()
            browseTagIndex = i
            buildTagBar()
            refreshBrowse()
        end)

        b.MouseEnter:Connect(function()
            if i ~= browseTagIndex then
                b.BackgroundTransparency = 0.15
                b.TextColor3 = C.text
            end
        end)
        b.MouseLeave:Connect(function()
            if i ~= browseTagIndex then
                b.BackgroundTransparency = 0.4
                b.TextColor3 = C.sub
            end
        end)
    end
end

local function buildYearBar()
    for _, c in ipairs(yearBarScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end

    for i, y in ipairs(BROWSE_YEARS) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 70, 0, 24)
        b.BackgroundColor3 = (i == browseYearIndex) and C.raise or C.surface
        b.BackgroundTransparency = (i == browseYearIndex) and 0.1 or 0.6
        b.Text = y.label
        b.TextColor3 = (i == browseYearIndex) and C.text or C.mute
        b.TextSize = 10
        b.Font = Enum.Font.Gotham
        b.AutoButtonColor = false
        b.ZIndex = 6
        b.Parent = yearBarScroll
        corner(b, 6)

        b.MouseButton1Click:Connect(function()
            browseYearIndex = i
            buildYearBar()
            refreshBrowse()
        end)

        b.MouseEnter:Connect(function()
            if i ~= browseYearIndex then
                b.BackgroundTransparency = 0.4
                b.TextColor3 = C.sub
            end
        end)
        b.MouseLeave:Connect(function()
            if i ~= browseYearIndex then
                b.BackgroundTransparency = 0.6
                b.TextColor3 = C.mute
            end
        end)
    end
end

local function enterBrowse()
    showBrowse()
    buildTagBar()
    buildYearBar()
    refreshBrowse()
end

backBtn.MouseButton1Click:Connect(function()
    if readerView.Visible then
        showHome()
        buildHome()
    elseif list.Visible then
        showHome()
        buildHome()
    elseif browseView.Visible then
        showHome()
        buildHome()
    end
end)

homeBtn.MouseButton1Click:Connect(function()
    showHome()
    buildHome()
end)

homeNavBtn.MouseButton1Click:Connect(function()
    showHome()
    buildHome()
end)

browseNavBtn.MouseButton1Click:Connect(function()
    enterBrowse()
end)

browseBtn.MouseButton1Click:Connect(function()
    enterBrowse()
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

showHome()
buildHome()
setStatus("就绪")