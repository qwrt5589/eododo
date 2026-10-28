local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local lp = Players.LocalPlayer
if not lp then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    lp = Players.LocalPlayer
end

local LOADER_ASSETS = {
    Logo = "rbxassetid://137323332616254",
    BannerArt = "rbxassetid://115688095025841",
    ShadowSlice = "rbxassetid://6031094678",
}

local LOADER_PALETTE = {
    VoidBg = Color3.fromRGB(15, 12, 16),
    CardDark = Color3.fromRGB(24, 20, 26),
    CardTop = Color3.fromRGB(38, 30, 40),
    PanelGlass = Color3.fromRGB(30, 24, 32),
    NeonPrimary = Color3.fromRGB(255, 180, 200),
    NeonBright = Color3.fromRGB(255, 220, 235),
    PureWhite = Color3.fromRGB(255, 255, 255),
    TextSilver = Color3.fromRGB(220, 210, 215),
    TextMuted = Color3.fromRGB(150, 140, 150),
    TrackBg = Color3.fromRGB(40, 32, 45),
}

local BOOT_SEQUENCE = {
    { Status = "正在加载...",   Badge = "1 / 5", Percent = 20,  HoldTime = 0.8  },
    { Status = "正在加载...",  Badge = "2 / 5", Percent = 40,  HoldTime = 0.9  },
    { Status = "正在加载...",   Badge = "3 / 5", Percent = 70,  HoldTime = 1.1  },
    { Status = "正在加载...",   Badge = "4 / 5", Percent = 90,  HoldTime = 0.8  },
    { Status = "加载完成",   Badge = "5 / 5", Percent = 100, HoldTime = 1.0  },
}

local function getLoaderGuiContainer()
    local ok, target = pcall(function()
        if type(gethui) == "function" then return gethui() end
        return CoreGui
    end)
    if ok and target then return target end
    return lp:WaitForChild("PlayerGui")
end

local function setLoaderFont(label, weight)
    local ok = pcall(function()
        if weight == "Bold" then
            label.FontFace = Font.fromEnum(Enum.Font.BuilderSansBold)
        elseif weight == "ExtraBold" then
            label.FontFace = Font.fromEnum(Enum.Font.BuilderSansExtraBold)
        elseif weight == "Mono" then
            label.FontFace = Font.fromEnum(Enum.Font.RobotoMono)
        else
            label.FontFace = Font.fromEnum(Enum.Font.BuilderSans)
        end
    end)
    if not ok then
        if weight == "Bold" or weight == "ExtraBold" then
            label.Font = Enum.Font.GothamBold
        elseif weight == "Mono" then
            label.Font = Enum.Font.Code
        else
            label.Font = Enum.Font.GothamMedium
        end
    end
end

local function createVectorArc(parent, sizePx, thickness, color, zIndex)
    local ringFrame = Instance.new("Frame")
    ringFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ringFrame.Position = UDim2.fromScale(0.5, 0.5)
    ringFrame.Size = UDim2.fromOffset(sizePx, sizePx)
    ringFrame.BackgroundTransparency = 1
    ringFrame.ZIndex = zIndex
    ringFrame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ringFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = ringFrame

    local arcGradient = Instance.new("UIGradient")
    arcGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.28, 0.15),
        NumberSequenceKeypoint.new(0.55, 1),
        NumberSequenceKeypoint.new(1, 1),
    })
    arcGradient.Parent = stroke

    return ringFrame, stroke, arcGradient
end

local function createLoaderUI()
    local parentGui = getLoaderGuiContainer()
    local old = parentGui:FindFirstChild("139club_LoaderGui")
    if old then pcall(old.Destroy, old) end
    local oldBlur = Lighting:FindFirstChild("139club_DepthBlur")
    if oldBlur then pcall(oldBlur.Destroy, oldBlur) end

    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Name = "139club_DepthBlur"
    blurEffect.Size = 0
    blurEffect.Parent = Lighting

    local camera = Workspace.CurrentCamera
    local initialFov = camera and camera.FieldOfView or 70

    pcall(function()
        TweenService:Create(blurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = 24 }):Play()
        if camera then
            TweenService:Create(camera, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                { FieldOfView = math.clamp(initialFov - 5, 45, 110) }):Play()
        end
    end)

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "139club_LoaderGui"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999999
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.Parent = parentGui

    local backdrop = Instance.new("Frame")
    backdrop.Size = UDim2.fromScale(1, 1)
    backdrop.BackgroundColor3 = LOADER_PALETTE.VoidBg
    backdrop.BackgroundTransparency = 0.12
    backdrop.BorderSizePixel = 0
    backdrop.ClipsDescendants = true
    backdrop.ZIndex = 1
    backdrop.Parent = screenGui

    local particleContainer = Instance.new("Frame")
    particleContainer.Size = UDim2.fromScale(1, 1)
    particleContainer.BackgroundTransparency = 1
    particleContainer.ZIndex = 2
    particleContainer.Parent = backdrop

    local particles = {}
    for i = 1, 18 do
        local mote = Instance.new("Frame")
        local diameter = math.random(4, 8)
        mote.AnchorPoint = Vector2.new(0.5, 0.5)
        mote.Size = UDim2.fromOffset(diameter, diameter)
        mote.Position = UDim2.fromScale(math.random(8, 92) / 100, math.random(10, 95) / 100)
        mote.BackgroundColor3 = (i % 2 == 0) and LOADER_PALETTE.NeonBright or LOADER_PALETTE.NeonPrimary
        mote.BackgroundTransparency = math.random(15, 45) / 100
        mote.BorderSizePixel = 0
        mote.ZIndex = 2
        mote.Parent = particleContainer
        local mc = Instance.new("UICorner", mote); mc.CornerRadius = UDim.new(1, 0)
        local ms = Instance.new("UIStroke", mote)
        ms.Color = LOADER_PALETTE.NeonPrimary; ms.Thickness = 2; ms.Transparency = 0.45
        table.insert(particles, {
            Instance = mote, Stroke = ms,
            BaseX = mote.Position.X.Scale, PosY = mote.Position.Y.Scale,
            SpeedY = math.random(22, 48) / 1000,
            AmpX = math.random(10, 24) / 1000,
            Freq = math.random(12, 26) / 10,
            Phase = math.random() * math.pi * 2,
        })
    end

    local rigHolder = Instance.new("Frame")
    rigHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    rigHolder.Position = UDim2.fromScale(0.5, 0.5)
    rigHolder.Size = UDim2.fromOffset(560, 330)
    rigHolder.BackgroundTransparency = 1
    rigHolder.ZIndex = 4
    rigHolder.Parent = backdrop

    local rigScale = Instance.new("UIScale", rigHolder)
    rigScale.Scale = 0.9
    pcall(function()
        TweenService:Create(rigScale, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
    end)

    local mainCard = Instance.new("Frame")
    mainCard.AnchorPoint = Vector2.new(0.5, 0.5)
    mainCard.Position = UDim2.fromScale(0.5, 0.5)
    mainCard.Size = UDim2.fromOffset(560, 330)
    mainCard.BackgroundColor3 = LOADER_PALETTE.CardDark
    mainCard.BackgroundTransparency = 0.04
    mainCard.BorderSizePixel = 0
    mainCard.ClipsDescendants = true
    mainCard.ZIndex = 5
    mainCard.Parent = rigHolder
    local cCard = Instance.new("UICorner", mainCard); cCard.CornerRadius = UDim.new(0, 12)

    local cardStroke = Instance.new("UIStroke", mainCard)
    cardStroke.Color = LOADER_PALETTE.NeonPrimary
    cardStroke.Thickness = 1.5
    cardStroke.Transparency = 0.1
    cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local strokeGradient = Instance.new("UIGradient", cardStroke)
    strokeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(200, 120, 150)),
        ColorSequenceKeypoint.new(0.18, Color3.fromRGB(200, 120, 150)),
        ColorSequenceKeypoint.new(0.34, LOADER_PALETTE.NeonPrimary),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.66, LOADER_PALETTE.NeonPrimary),
        ColorSequenceKeypoint.new(0.82, Color3.fromRGB(200, 120, 150)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(200, 120, 150)),
    })

    local surfaceBg = Instance.new("Frame")
    surfaceBg.Size = UDim2.fromScale(1, 1)
    surfaceBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    surfaceBg.BorderSizePixel = 0
    surfaceBg.ZIndex = 5
    surfaceBg.Parent = mainCard
    local sbc = Instance.new("UICorner", surfaceBg); sbc.CornerRadius = UDim.new(0, 12)
    local surfaceGrad = Instance.new("UIGradient", surfaceBg)
    surfaceGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, LOADER_PALETTE.CardTop),
        ColorSequenceKeypoint.new(0.5, LOADER_PALETTE.CardDark),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 15)),
    })
    surfaceGrad.Rotation = 125

    local bannerClip = Instance.new("Frame")
    bannerClip.Size = UDim2.new(1, 0, 0, 190)
    bannerClip.BackgroundTransparency = 1
    bannerClip.ClipsDescendants = true
    bannerClip.ZIndex = 6
    bannerClip.Parent = mainCard
    local clipCorner = Instance.new("UICorner", bannerClip); clipCorner.CornerRadius = UDim.new(0, 12)

    local bannerArt = Instance.new("ImageLabel")
    bannerArt.Size = UDim2.new(1, 0, 1, 0)
    bannerArt.BackgroundTransparency = 1
    bannerArt.Image = LOADER_ASSETS.BannerArt
    bannerArt.ImageColor3 = Color3.fromRGB(255, 230, 240)
    bannerArt.ImageTransparency = 0.28
    bannerArt.ScaleType = Enum.ScaleType.Crop
    bannerArt.ZIndex = 6
    bannerArt.Parent = bannerClip
    local imgCorner = Instance.new("UICorner", bannerArt); imgCorner.CornerRadius = UDim.new(0, 12)

    local bannerMask = Instance.new("UIGradient", bannerArt)
    bannerMask.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.05),
        NumberSequenceKeypoint.new(0.55, 0.35),
        NumberSequenceKeypoint.new(1, 1),
    })
    bannerMask.Rotation = 90

    local shimmerBeam = Instance.new("Frame")
    shimmerBeam.AnchorPoint = Vector2.new(0.5, 0.5)
    shimmerBeam.Position = UDim2.fromScale(-0.3, 0.5)
    shimmerBeam.Size = UDim2.new(0, 120, 2, 0)
    shimmerBeam.Rotation = 25
    shimmerBeam.BackgroundColor3 = LOADER_PALETTE.NeonBright
    shimmerBeam.BackgroundTransparency = 0.9
    shimmerBeam.BorderSizePixel = 0
    shimmerBeam.ZIndex = 7
    shimmerBeam.Parent = bannerClip
    local shimGrad = Instance.new("UIGradient", shimmerBeam)
    shimGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1),
    })

    local headerBar = Instance.new("Frame")
    headerBar.Size = UDim2.new(1, -56, 0, 26)
    headerBar.Position = UDim2.fromOffset(28, 20)
    headerBar.BackgroundTransparency = 1
    headerBar.ZIndex = 8
    headerBar.Parent = mainCard

    local stageBadge = Instance.new("Frame")
    stageBadge.Size = UDim2.fromOffset(70, 24)
    stageBadge.BackgroundColor3 = Color3.fromRGB(40, 28, 32)
    stageBadge.BackgroundTransparency = 0.2
    stageBadge.BorderSizePixel = 0
    stageBadge.ZIndex = 8
    stageBadge.Parent = headerBar
    local bc = Instance.new("UICorner", stageBadge); bc.CornerRadius = UDim.new(0, 6)
    local bs = Instance.new("UIStroke", stageBadge)
    bs.Color = LOADER_PALETTE.NeonPrimary; bs.Thickness = 1; bs.Transparency = 0.35

    local badgeText = Instance.new("TextLabel")
    badgeText.Size = UDim2.fromScale(1, 1)
    badgeText.BackgroundTransparency = 1
    badgeText.Text = "1 / 5"
    badgeText.TextColor3 = LOADER_PALETTE.NeonBright
    badgeText.TextSize = 11
    badgeText.ZIndex = 9
    setLoaderFont(badgeText, "Bold")
    badgeText.Parent = stageBadge

    local fpsReadout = Instance.new("TextLabel")
    fpsReadout.AnchorPoint = Vector2.new(1, 0.5)
    fpsReadout.Position = UDim2.fromScale(1, 0.5)
    fpsReadout.Size = UDim2.fromOffset(100, 20)
    fpsReadout.BackgroundTransparency = 1
    fpsReadout.Text = "60 FPS"
    fpsReadout.TextColor3 = LOADER_PALETTE.TextSilver
    fpsReadout.TextSize = 11
    fpsReadout.TextXAlignment = Enum.TextXAlignment.Right
    fpsReadout.ZIndex = 9
    setLoaderFont(fpsReadout, "Mono")
    fpsReadout.Parent = headerBar

    local heroSection = Instance.new("Frame")
    heroSection.Size = UDim2.new(1, -56, 0, 96)
    heroSection.Position = UDim2.fromOffset(28, 60)
    heroSection.BackgroundTransparency = 1
    heroSection.ZIndex = 8
    heroSection.Parent = mainCard

    local reactorPod = Instance.new("Frame")
    reactorPod.AnchorPoint = Vector2.new(0, 0.5)
    reactorPod.Position = UDim2.new(0, 6, 0.5, 0)
    reactorPod.Size = UDim2.fromOffset(80, 80)
    reactorPod.BackgroundColor3 = Color3.fromRGB(25, 18, 22)
    reactorPod.BackgroundTransparency = 0.1
    reactorPod.BorderSizePixel = 0
    reactorPod.ZIndex = 8
    reactorPod.Parent = heroSection
    local pc = Instance.new("UICorner", reactorPod); pc.CornerRadius = UDim.new(1, 0)
    local pbs = Instance.new("UIStroke", reactorPod)
    pbs.Color = Color3.fromRGB(100, 60, 75); pbs.Thickness = 1; pbs.Transparency = 0.4

    local sonarRing = Instance.new("Frame")
    sonarRing.AnchorPoint = Vector2.new(0.5, 0.5)
    sonarRing.Position = UDim2.fromScale(0.5, 0.5)
    sonarRing.Size = UDim2.fromScale(1, 1)
    sonarRing.BackgroundTransparency = 1
    sonarRing.ZIndex = 7
    sonarRing.Parent = reactorPod
    local src = Instance.new("UICorner", sonarRing); src.CornerRadius = UDim.new(1, 0)
    local sonarStroke = Instance.new("UIStroke", sonarRing)
    sonarStroke.Color = LOADER_PALETTE.NeonBright
    sonarStroke.Thickness = 1.5
    sonarStroke.Transparency = 0.2

    local outerArc, _, _ = createVectorArc(reactorPod, 88, 2, LOADER_PALETTE.NeonPrimary, 9)
    local innerArc, _, _ = createVectorArc(reactorPod, 72, 1.5, LOADER_PALETTE.NeonBright, 9)

    local logoImg = Instance.new("ImageLabel")
    logoImg.AnchorPoint = Vector2.new(0.5, 0.5)
    logoImg.Position = UDim2.fromScale(0.5, 0.5)
    logoImg.Size = UDim2.fromOffset(54, 54)
    logoImg.BackgroundTransparency = 1
    logoImg.Image = LOADER_ASSETS.Logo
    logoImg.ImageColor3 = Color3.fromRGB(255, 255, 255)
    logoImg.ScaleType = Enum.ScaleType.Fit
    logoImg.ZIndex = 10
    logoImg.Parent = reactorPod
    local lc = Instance.new("UICorner", logoImg); lc.CornerRadius = UDim.new(1, 0)

    local mainTitle = Instance.new("TextLabel")
    mainTitle.Position = UDim2.fromOffset(105, 16)
    mainTitle.Size = UDim2.fromOffset(380, 36)
    mainTitle.BackgroundTransparency = 1
    mainTitle.Text = "139club hub"
    mainTitle.TextColor3 = LOADER_PALETTE.PureWhite
    mainTitle.TextSize = 32
    mainTitle.TextXAlignment = Enum.TextXAlignment.Left
    mainTitle.ZIndex = 9
    setLoaderFont(mainTitle, "ExtraBold")
    mainTitle.Parent = heroSection
    local titleGradient = Instance.new("UIGradient", mainTitle)
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255, 220, 235)),
        ColorSequenceKeypoint.new(1, LOADER_PALETTE.NeonPrimary),
    })

    local subHeadline = Instance.new("TextLabel")
    subHeadline.Position = UDim2.fromOffset(107, 52)
    subHeadline.Size = UDim2.fromOffset(380, 18)
    subHeadline.BackgroundTransparency = 1
    subHeadline.Text = "加载中……"
    subHeadline.TextColor3 = LOADER_PALETTE.NeonBright
    subHeadline.TextSize = 13
    subHeadline.TextXAlignment = Enum.TextXAlignment.Left
    subHeadline.ZIndex = 9
    setLoaderFont(subHeadline, "Bold")
    subHeadline.Parent = heroSection

    local bottomDeck = Instance.new("Frame")
    bottomDeck.AnchorPoint = Vector2.new(0.5, 1)
    bottomDeck.Position = UDim2.new(0.5, 0, 1, -18)
    bottomDeck.Size = UDim2.fromOffset(504, 130)
    bottomDeck.BackgroundColor3 = LOADER_PALETTE.PanelGlass
    bottomDeck.BackgroundTransparency = 0.25
    bottomDeck.BorderSizePixel = 0
    bottomDeck.ZIndex = 8
    bottomDeck.Parent = mainCard
    local dc = Instance.new("UICorner", bottomDeck); dc.CornerRadius = UDim.new(0, 10)
    local ds = Instance.new("UIStroke", bottomDeck)
    ds.Color = Color3.fromRGB(140, 80, 100); ds.Thickness = 1; ds.Transparency = 0.45

    local nodesRow = Instance.new("Frame")
    nodesRow.Position = UDim2.fromOffset(20, 16)
    nodesRow.Size = UDim2.new(1, -40, 0, 5)
    nodesRow.BackgroundTransparency = 1
    nodesRow.ZIndex = 9
    nodesRow.Parent = bottomDeck

    local stageSegments = {}
    for i = 1, #BOOT_SEQUENCE do
        local seg = Instance.new("Frame")
        seg.Size = UDim2.new(1 / #BOOT_SEQUENCE, -6, 1, 0)
        seg.Position = UDim2.new((i - 1) / #BOOT_SEQUENCE, (i > 1) and 3 or 0, 0, 0)
        seg.BackgroundColor3 = LOADER_PALETTE.TrackBg
        seg.BorderSizePixel = 0
        seg.ZIndex = 9
        seg.Parent = nodesRow
        local segC = Instance.new("UICorner", seg); segC.CornerRadius = UDim.new(1, 0)
        local segS = Instance.new("UIStroke", seg)
        segS.Color = LOADER_PALETTE.NeonBright; segS.Thickness = 1; segS.Transparency = 1
        table.insert(stageSegments, { Frame = seg, Stroke = segS })
    end

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Position = UDim2.fromOffset(20, 36)
    statusLabel.Size = UDim2.fromOffset(340, 24)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "正在等待游戏加载..."
    statusLabel.TextColor3 = LOADER_PALETTE.PureWhite
    statusLabel.TextSize = 15
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.ZIndex = 9
    setLoaderFont(statusLabel, "Bold")
    statusLabel.Parent = bottomDeck

    local percentLabel = Instance.new("TextLabel")
    percentLabel.AnchorPoint = Vector2.new(1, 0)
    percentLabel.Position = UDim2.new(1, -20, 0, 30)
    percentLabel.Size = UDim2.fromOffset(100, 30)
    percentLabel.BackgroundTransparency = 1
    percentLabel.Text = "0%"
    percentLabel.TextColor3 = LOADER_PALETTE.NeonBright
    percentLabel.TextSize = 24
    percentLabel.TextXAlignment = Enum.TextXAlignment.Right
    percentLabel.ZIndex = 9
    setLoaderFont(percentLabel, "ExtraBold")
    percentLabel.Parent = bottomDeck

    local progressTrack = Instance.new("Frame")
    progressTrack.Position = UDim2.fromOffset(20, 72)
    progressTrack.Size = UDim2.new(1, -40, 0, 8)
    progressTrack.BackgroundColor3 = LOADER_PALETTE.TrackBg
    progressTrack.BorderSizePixel = 0
    progressTrack.ZIndex = 9
    progressTrack.Parent = bottomDeck
    local tc = Instance.new("UICorner", progressTrack); tc.CornerRadius = UDim.new(1, 0)
    local ts = Instance.new("UIStroke", progressTrack)
    ts.Color = Color3.fromRGB(100, 60, 75); ts.Thickness = 1; ts.Transparency = 0.35

    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.fromScale(0, 1)
    progressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressFill.BorderSizePixel = 0
    progressFill.ZIndex = 10
    progressFill.Parent = progressTrack
    local fc = Instance.new("UICorner", progressFill); fc.CornerRadius = UDim.new(1, 0)
    local fg = Instance.new("UIGradient", progressFill)
    fg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 120, 150)),
        ColorSequenceKeypoint.new(0.6, LOADER_PALETTE.NeonPrimary),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 240, 245)),
    })
    local fgs = Instance.new("UIStroke", progressFill)
    fgs.Color = LOADER_PALETTE.NeonPrimary; fgs.Thickness = 2; fgs.Transparency = 0.25

    local vectorSpark = Instance.new("Frame")
    vectorSpark.AnchorPoint = Vector2.new(0.5, 0.5)
    vectorSpark.Position = UDim2.fromScale(1, 0.5)
    vectorSpark.Size = UDim2.fromOffset(12, 12)
    vectorSpark.BackgroundColor3 = LOADER_PALETTE.PureWhite
    vectorSpark.BorderSizePixel = 0
    vectorSpark.ZIndex = 11
    vectorSpark.Parent = progressFill
    local vsc = Instance.new("UICorner", vectorSpark); vsc.CornerRadius = UDim.new(1, 0)
    local sparkHalo = Instance.new("UIStroke", vectorSpark)
    sparkHalo.Color = LOADER_PALETTE.NeonBright; sparkHalo.Thickness = 3; sparkHalo.Transparency = 0.25

    local footerText = Instance.new("TextLabel")
    footerText.Position = UDim2.fromOffset(20, 96)
    footerText.Size = UDim2.new(1, -40, 0, 18)
    footerText.BackgroundTransparency = 1
    footerText.Text = "139club Client"
    footerText.TextColor3 = LOADER_PALETTE.TextSilver
    footerText.TextTransparency = 0.35
    footerText.TextSize = 10
    footerText.TextXAlignment = Enum.TextXAlignment.Center
    footerText.ZIndex = 9
    setLoaderFont(footerText, "Bold")
    footerText.Parent = bottomDeck

    local clockTime = 0
    local renderConn = RunService.RenderStepped:Connect(function(dt)
        clockTime = clockTime + dt
        outerArc.Rotation = (clockTime * 250) % 360
        innerArc.Rotation = -(clockTime * 175) % 360
        strokeGradient.Rotation = (clockTime * 40) % 360
        logoImg.Position = UDim2.new(0.5, 0, 0.5, math.sin(clockTime * 3.5) * 2.5)
        local wavePhase = (clockTime % 1.5) / 1.5
        sonarRing.Size = UDim2.fromScale(1 + (wavePhase * 0.45), 1 + (wavePhase * 0.45))
        sonarStroke.Transparency = 0.2 + (wavePhase * 0.8)
        local sweep = (clockTime % 2.6) / 2.6
        shimmerBeam.Position = UDim2.fromScale(-0.35 + (sweep * 1.7), 0.5)
        sparkHalo.Thickness = 3 + math.sin(clockTime * 10) * 1.2
        local fps = math.clamp(math.floor(1 / math.max(dt, 0.001)), 1, 999)
        fpsReadout.Text = string.format("%d FPS", fps)
        for _, p in ipairs(particles) do
            p.PosY = p.PosY - (p.SpeedY * dt)
            if p.PosY < -0.05 then p.PosY = 1.05 end
            local xPos = p.BaseX + math.sin(clockTime * p.Freq + p.Phase) * p.AmpX
            p.Instance.Position = UDim2.fromScale(xPos, p.PosY)
        end
        local vp = camera and camera.ViewportSize or Vector2.new(1920, 1080)
        local mPos = UserInputService:GetMouseLocation()
        local nx = math.clamp((mPos.X / math.max(vp.X, 1)) - 0.5, -0.5, 0.5)
        local ny = math.clamp((mPos.Y / math.max(vp.Y, 1)) - 0.5, -0.5, 0.5)
        local goalPos = UDim2.new(0.5, -nx * 18, 0.5, -ny * 12)
        rigHolder.Position = rigHolder.Position:Lerp(goalPos, math.clamp(dt * 9, 0, 1))
    end)

    return {
        ScreenGui = screenGui,
        RigScale = rigScale,
        BlurEffect = blurEffect,
        Camera = camera,
        InitialFov = initialFov,
        BadgeText = badgeText,
        StatusLabel = statusLabel,
        PercentLabel = percentLabel,
        ProgressFill = progressFill,
        StageSegments = stageSegments,
        RenderConn = renderConn,
    }
end

local function createProgressController(ui)
    local currentPct = 0
    local targetPct = 0

    local pctConn = RunService.RenderStepped:Connect(function(dt)
        currentPct = currentPct + (targetPct - currentPct) * math.clamp(dt * 5, 0, 1)
        if math.abs(targetPct - currentPct) < 0.1 then currentPct = targetPct end
        ui.PercentLabel.Text = string.format("%d%%", math.floor(currentPct + 0.5))
    end)

    local function setStage(index, overridePct)
        local info = BOOT_SEQUENCE[index]
        if not info then return end
        targetPct = overridePct or info.Percent
        ui.BadgeText.Text = info.Badge
        ui.StatusLabel.Text = info.Status
        for i, seg in ipairs(ui.StageSegments) do
            if i <= index then
                pcall(function()
                    TweenService:Create(seg.Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundColor3 = LOADER_PALETTE.NeonPrimary }):Play()
                    TweenService:Create(seg.Stroke, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Transparency = 0.15 }):Play()
                end)
            end
        end
        pcall(function()
            TweenService:Create(ui.ProgressFill, TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                { Size = UDim2.fromScale(math.clamp(targetPct / 100, 0, 1), 1) }):Play()
        end)
    end

    local function disconnect()
        if pctConn.Connected then pctConn:Disconnect() end
    end

    return { SetStage = setStage, Disconnect = disconnect }
end

local function preloadVisualAssets(onStep)
    local uris = { LOADER_ASSETS.Logo, LOADER_ASSETS.BannerArt, LOADER_ASSETS.ShadowSlice }
    local decals = {}
    for i, id in ipairs(uris) do
        local d = Instance.new("Decal")
        d.Name = "AssetStream_" .. tostring(i)
        d.Texture = id
        table.insert(decals, d)
    end
    local loaded = 0
    local total = #decals
    pcall(function()
        ContentProvider:PreloadAsync(decals, function()
            loaded = loaded + 1
            if onStep then onStep(math.clamp(loaded / math.max(total, 1), 0, 1)) end
            task.wait(0.25)
        end)
    end)
    for _, d in ipairs(decals) do pcall(d.Destroy, d) end
end

local function dissolveLoader(ui)
    task.wait(0.5)
    local fadeInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    pcall(function()
        TweenService:Create(ui.RigScale, fadeInfo, { Scale = 1.07 }):Play()
        TweenService:Create(ui.BlurEffect, fadeInfo, { Size = 0 }):Play()
        if ui.Camera then
            TweenService:Create(ui.Camera, fadeInfo, { FieldOfView = ui.InitialFov }):Play()
        end
    end)
    for _, inst in ipairs(ui.ScreenGui:GetDescendants()) do
        local goals = {}
        if inst:IsA("Frame") then goals.BackgroundTransparency = 1
        elseif inst:IsA("TextLabel") or inst:IsA("TextButton") then
            goals.BackgroundTransparency = 1; goals.TextTransparency = 1
        elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
            goals.BackgroundTransparency = 1; goals.ImageTransparency = 1
        elseif inst:IsA("UIStroke") then goals.Transparency = 1 end
        if next(goals) ~= nil then
            pcall(function() TweenService:Create(inst, fadeInfo, goals):Play() end)
        end
    end
    task.wait(0.85)
    if ui.RenderConn and ui.RenderConn.Connected then ui.RenderConn:Disconnect() end
    pcall(function() ui.BlurEffect:Destroy() end)
    pcall(function() ui.ScreenGui:Destroy() end)
end

local function start139clubLoader()
    local ui = createLoaderUI()
    local ctrl = createProgressController(ui)

    ctrl.SetStage(1)
    if not game:IsLoaded() then game.Loaded:Wait() end
    task.wait(BOOT_SEQUENCE[1].HoldTime)

    ctrl.SetStage(2)
    local char = lp.Character or lp.CharacterAdded:Wait()
    pcall(function() char:WaitForChild("HumanoidRootPart", 8) end)
    task.wait(BOOT_SEQUENCE[2].HoldTime)

    ctrl.SetStage(3, 50)
    preloadVisualAssets(function(ratio) ctrl.SetStage(3, math.floor(50 + ratio * 20)) end)
    task.wait(BOOT_SEQUENCE[3].HoldTime)

    ctrl.SetStage(4)
    task.wait(BOOT_SEQUENCE[4].HoldTime)

    ctrl.SetStage(5)
    task.wait(BOOT_SEQUENCE[5].HoldTime)

    ctrl.Disconnect()
    dissolveLoader(ui)

    local fn = loadstring or load
    local src = game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E8%9D%97%E8%99%AB%E8%B0%8B%E6%9D%80%E4%B9%8B%E8%B0%9C.lua")
    local chunk = fn(src)
    if chunk then
        task.spawn(chunk)
    end
end

task.spawn(start139clubLoader)