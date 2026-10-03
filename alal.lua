local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")

local NKL = {
	Elements = {},
	Connections = {},
	Flags = {},
	Folder = nil,
	SaveCfg = false
}

local AccentColor   = Color3.fromRGB(198, 84, 84)
local WindowColor   = Color3.fromRGB(50, 50, 50)
local PanelColor    = Color3.fromRGB(45, 45, 45)
local PanelDark     = Color3.fromRGB(38, 38, 38)
local BorderColor   = Color3.fromRGB(30, 30, 30)
local HoverColor    = Color3.fromRGB(70, 70, 70)
local FieldColor    = Color3.fromRGB(35, 35, 35)
local SelectColor   = Color3.fromRGB(70, 90, 115)
local TextColor     = Color3.fromRGB(210, 210, 210)
local TextBright    = Color3.fromRGB(235, 235, 235)
local TextDim       = Color3.fromRGB(160, 160, 160)

local Icons = {}
local ok, res = pcall(function()
	Icons = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/evoincorp/lucideblox/master/src/modules/util/icons.json")).icons
end)
if not ok then
	warn("NKL - failed to load icons")
end

local function GetIcon(name)
	return Icons[name]
end

-- ============================================================
-- ScreenGui
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NKL"
ScreenGui.ResetOnSpawn = false
if syn and syn.protect_gui then
	syn.protect_gui(ScreenGui)
	ScreenGui.Parent = game.CoreGui
elseif gethui then
	ScreenGui.Parent = gethui()
else
	ScreenGui.Parent = game.CoreGui
end

function NKL:IsRunning()
	return ScreenGui.Parent ~= nil
end

local function AddConnection(sig, fn)
	if not NKL:IsRunning() then return end
	local c = sig:Connect(fn)
	table.insert(NKL.Connections, c)
	return c
end

task.spawn(function()
	while NKL:IsRunning() do wait() end
	for _, c in next, NKL.Connections do c:Disconnect() end
end)

-- ============================================================
-- 工具
-- ============================================================
local function Create(class, props, children)
	local o = Instance.new(class)
	for k, v in next, props or {} do o[k] = v end
	for _, c in next, children or {} do c.Parent = o end
	return o
end

local function SetProps(o, props)
	for k, v in next, props do o[k] = v end
	return o
end

local function SetChildren(o, children)
	for _, c in next, children do c.Parent = o end
	return o
end

local function MakeDraggable(drag, main)
	local dragging, dragInput, mousePos, framePos
	AddConnection(drag.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			mousePos = input.Position
			framePos = main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	AddConnection(drag.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
	end)
	AddConnection(UserInputService.InputChanged, function(input)
		if input == dragInput and dragging then
			local d = input.Position - mousePos
			main.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + d.X, framePos.Y.Scale, framePos.Y.Offset + d.Y)
		end
	end)
end

local function Round(n, f)
	local r = math.floor(n / f + (math.sign(n) * 0.5)) * f
	if r < 0 then r = r + f end
	return r
end

local function PackColor(c) return {R = c.R * 255, G = c.G * 255, B = c.B * 255} end
local function UnpackColor(c) return Color3.fromRGB(c.R, c.G, c.B) end

local function SaveCfg(name)
	if not writefile or not NKL.Folder then return end
	local data = {}
	for i, v in pairs(NKL.Flags) do
		if v.Save then
			data[i] = (v.Type == "Colorpicker") and PackColor(v.Value) or v.Value
		end
	end
	pcall(function()
		writefile(NKL.Folder .. "/" .. name .. ".txt", HttpService:JSONEncode(data))
	end)
end

local BlacklistedKeys = {Enum.KeyCode.Unknown, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Up, Enum.KeyCode.Left, Enum.KeyCode.Down, Enum.KeyCode.Right, Enum.KeyCode.Slash, Enum.KeyCode.Tab, Enum.KeyCode.Backspace, Enum.KeyCode.Escape}
local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3}

local function CheckKey(tbl, key)
	for _, v in next, tbl do
		if v == key then return true end
	end
end

-- ============================================================
-- 元素工厂
-- ============================================================
local function corner(o) return Create("UICorner", {CornerRadius = UDim.new(0, 0)}, {o}) end
local function stroke(o, col, thick)
	return Create("UIStroke", {
		Color = col or BorderColor,
		Thickness = thick or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	}, {o})
end

local function makeLabel(parent, x, y, w, h, text, size, color, align)
	local l = Create("TextLabel", {
		Size = UDim2.new(0, w, 0, h),
		Position = UDim2.new(0, x, 0, y),
		BackgroundTransparency = 1,
		Text = text or "",
		TextColor3 = color or TextColor,
		TextSize = size or 13,
		Font = Enum.Font.Code,
		TextXAlignment = align or Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		RichText = true
	}, {parent})
	return l
end

-- 漫画器那种方框面板
local function makePanel(parent, x, y, w, h)
	local f = Create("Frame", {
		Size = UDim2.new(0, w, 0, h),
		Position = UDim2.new(0, x, 0, y),
		BackgroundColor3 = PanelColor,
		BorderSizePixel = 0
	}, {parent})
	stroke(f)
	return f
end

-- 漫画器那种"方框 + 嵌在边框上的分组标题"
local function makeGroupBox(parent, x, y, w, h, title)
	local box = Create("Frame", {
		Size = UDim2.new(0, w, 0, h),
		Position = UDim2.new(0, x, 0, y),
		BackgroundColor3 = PanelColor,
		BorderSizePixel = 0
	}, {parent})
	stroke(box)
	if title then
		local t = Create("TextLabel", {
			Size = UDim2.new(0, #title * 8 + 14, 0, 14),
			Position = UDim2.new(0, 8, 0, -7),
			BackgroundColor3 = PanelColor,
			BorderSizePixel = 0,
			Text = " " .. title .. " ",
			TextColor3 = TextColor,
			TextSize = 11,
			Font = Enum.Font.Code,
			TextXAlignment = Enum.TextXAlignment.Left
		}, {box})
	end
	return box
end

-- ============================================================
-- 通知
-- ============================================================
local NotifyHolder = Create("Frame", {
	Position = UDim2.new(1, -25, 1, -25),
	Size = UDim2.new(0, 300, 1, -25),
	AnchorPoint = Vector2.new(1, 1),
	BackgroundTransparency = 1
}, {ScreenGui})
Create("UIListLayout", {
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Bottom,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 4)
}, {NotifyHolder})

function NKL:MakeNotification(cfg)
	cfg = cfg or {}
	local name = cfg.Name or "通知"
	local content = cfg.Content or ""
	local icon = cfg.Image or "rbxassetid://4384403532"
	local time = cfg.Time or 5

	spawn(function()
		local parent = Create("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1
		}, {NotifyHolder})

		local box = Create("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			Position = UDim2.new(1, -55, 0, 0),
			BackgroundColor3 = PanelColor,
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y
		}, {parent})
		stroke(box)
		Create("UIPadding", {
			PaddingTop = UDim.new(0, 10),
			PaddingBottom = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10)
		}, {box})

		local ico = Create("ImageLabel", {
			Size = UDim2.new(0, 18, 0, 18),
			BackgroundTransparency = 1,
			Image = icon,
			ImageColor3 = TextColor,
			Name = "Icon"
		}, {box})

		Create("TextLabel", {
			Size = UDim2.new(1, -28, 0, 18),
			Position = UDim2.new(0, 28, 0, 0),
			BackgroundTransparency = 1,
			Text = name,
			TextColor3 = TextBright,
			TextSize = 13,
			Font = Enum.Font.Code,
			TextXAlignment = Enum.TextXAlignment.Left,
			Name = "Title"
		}, {box})

		Create("TextLabel", {
			Size = UDim2.new(1, 0, 0, 0),
			Position = UDim2.new(0, 0, 0, 22),
			BackgroundTransparency = 1,
			Text = content,
			TextColor3 = TextDim,
			TextSize = 12,
			Font = Enum.Font.Code,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Name = "Content"
		}, {box})

		TweenService:Create(box, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		wait(time - 0.6)
		TweenService:Create(box, TweenInfo.new(0.5), {BackgroundTransparency = 0.6}):Play()
		TweenService:Create(box.Title, TweenInfo.new(0.5), {TextTransparency = 0.5}):Play()
		TweenService:Create(box.Content, TweenInfo.new(0.5), {TextTransparency = 0.5}):Play()
		wait(0.6)
		box:Destroy()
	end)
end

-- ============================================================
-- 主窗口
-- ============================================================
function NKL:MakeWindow(cfg)
	cfg = cfg or {}
	cfg.Name = cfg.Name or "NKL"
	cfg.ConfigFolder = cfg.ConfigFolder or cfg.Name
	cfg.SaveConfig = cfg.SaveConfig or false
	cfg.CloseCallback = cfg.CloseCallback or function() end
	if cfg.IntroEnabled == nil then cfg.IntroEnabled = true end
	cfg.IntroText = cfg.IntroText or cfg.Name
	cfg.IntroIcon = cfg.IntroIcon or "rbxassetid://8834748103"
	NKL.Folder = cfg.ConfigFolder
	NKL.SaveCfg = cfg.SaveConfig

	if cfg.SaveConfig and isfolder and makefolder then
		if not isfolder(cfg.ConfigFolder) then makefolder(cfg.ConfigFolder) end
	end

	local FirstTab = true
	local Minimized = false
	local UIHidden = false

	-- 窗口
	local win = Create("Frame", {
		Size = UDim2.new(0, 660, 0, 460),
		Position = UDim2.new(0.5, -330, 0.5, -230),
		BackgroundColor3 = WindowColor,
		BorderSizePixel = 0,
		Active = true,
		ClipsDescendants = true
	}, {ScreenGui})
	stroke(win, BorderColor, 1)

	-- 顶栏
	local topBar = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = PanelDark,
		BorderSizePixel = 0
	}, {win})
	stroke(topBar)
	Create("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1),
		BackgroundColor3 = BorderColor,
		BorderSizePixel = 0
	}, {topBar})

	Create("Frame", {
		Size = UDim2.new(0, 3, 0, 14),
		Position = UDim2.new(0, 10, 0, 10),
		BackgroundColor3 = AccentColor,
		BorderSizePixel = 0
	}, {topBar})

	local winTitle = Create("TextLabel", {
		Size = UDim2.new(1, -120, 1, 0),
		Position = UDim2.new(0, 22, 0, 0),
		BackgroundTransparency = 1,
		Text = cfg.Name,
		TextColor3 = TextBright,
		TextSize = 14,
		Font = Enum.Font.Code,
		TextXAlignment = Enum.TextXAlignment.Left
	}, {topBar})

	-- 最小化 / 关闭按钮
	local minBtn = Create("TextButton", {
		Size = UDim2.new(0, 22, 0, 20),
		Position = UDim2.new(1, -50, 0, 7),
		BackgroundColor3 = PanelColor,
		BorderSizePixel = 0,
		Text = "_",
		TextColor3 = TextColor,
		TextSize = 12,
		Font = Enum.Font.Code,
		AutoButtonColor = false
	}, {topBar})
	stroke(minBtn)

	local closeBtn = Create("TextButton", {
		Size = UDim2.new(0, 22, 0, 20),
		Position = UDim2.new(1, -26, 0, 7),
		BackgroundColor3 = PanelColor,
		BorderSizePixel = 0,
		Text = "x",
		TextColor3 = TextColor,
		TextSize = 12,
		Font = Enum.Font.Code,
		AutoButtonColor = false
	}, {topBar})
	stroke(closeBtn)

	minBtn.MouseEnter:Connect(function() minBtn.BackgroundColor3 = HoverColor end)
	minBtn.MouseLeave:Connect(function() minBtn.BackgroundColor3 = PanelColor end)
	closeBtn.MouseEnter:Connect(function() closeBtn.BackgroundColor3 = AccentColor end)
	closeBtn.MouseLeave:Connect(function() closeBtn.BackgroundColor3 = PanelColor end)

	-- 拖动区
	local dragArea = Create("Frame", {
		Size = UDim2.new(1, -80, 1, 0),
		BackgroundTransparency = 1
	}, {topBar})
	MakeDraggable(dragArea, win)

	closeBtn.MouseButton1Click:Connect(function()
		win.Visible = false
		UIHidden = true
		NKL:MakeNotification({Name = "已关闭", Content = "按右Shift重新打开", Time = 3})
		cfg.CloseCallback()
	end)

	AddConnection(UserInputService.InputBegan, function(input)
		if input.KeyCode == Enum.KeyCode.RightShift and UIHidden then
			win.Visible = true
			UIHidden = false
		end
	end)

	minBtn.MouseButton1Click:Connect(function()
		Minimized = not Minimized
		if Minimized then
			body.Visible = false
			TweenService:Create(win, TweenInfo.new(0.25), {Size = UDim2.new(0, 660, 0, 34)}):Play()
			minBtn.Text = "□"
		else
			TweenService:Create(win, TweenInfo.new(0.25), {Size = UDim2.new(0, 660, 0, 460)}):Play()
			task.delay(0.1, function() body.Visible = true end)
			minBtn.Text = "_"
		end
	end)

	-- 主体
	local body = Create("Frame", {
		Size = UDim2.new(1, 0, 1, -34),
		Position = UDim2.new(0, 0, 0, 34),
		BackgroundTransparency = 1
	}, {win})

	-- 左栏
	local sideW = 160
	local side = Create("Frame", {
		Size = UDim2.new(0, sideW, 1, 0),
		BackgroundColor3 = PanelColor,
		BorderSizePixel = 0
	}, {body})
	stroke(side)

	-- 左栏右边界线
	Create("Frame", {
		Size = UDim2.new(0, 1, 1, 0),
		Position = UDim2.new(1, -1, 0, 0),
		BackgroundColor3 = BorderColor,
		BorderSizePixel = 0
	}, {side})

	local tabHolder = Create("ScrollingFrame", {
		Size = UDim2.new(1, 0, 1, -40),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = HoverColor,
		CanvasSize = UDim2.new(0, 0, 0, 0)
	}, {side})
	Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim2.new(0, 0)
	}, {tabHolder})

	AddConnection(tabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		tabHolder.CanvasSize = UDim2.new(0, 0, 0, tabHolder.UIListLayout.AbsoluteContentSize.Y)
	end)

	-- 侧栏底部：头像
	local profile = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 40),
		Position = UDim2.new(0, 0, 1, -40),
		BackgroundColor3 = PanelDark,
		BorderSizePixel = 0
	}, {side})
	Create("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = BorderColor,
		BorderSizePixel = 0
	}, {profile})

	local avatar = Create("ImageLabel", {
		Size = UDim2.new(0, 24, 0, 24),
		Position = UDim2.new(0, 8, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = FieldColor,
		BorderSizePixel = 0,
		Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=420&height=420&format=png"
	}, {profile})
	stroke(avatar)

	Create("TextLabel", {
		Size = UDim2.new(1, -44, 1, 0),
		Position = UDim2.new(0, 40, 0, 0),
		BackgroundTransparency = 1,
		Text = LocalPlayer.DisplayName,
		TextColor3 = TextColor,
		TextSize = 12,
		Font = Enum.Font.Code,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd
	}, {profile})

	-- 内容区
	local contentX = sideW + 1
	local content = Create("Frame", {
		Size = UDim2.new(1, -contentX, 1, 0),
		Position = UDim2.new(0, contentX, 0, 0),
		BackgroundColor3 = WindowColor,
		BorderSizePixel = 0
	}, {body})

	local TabFunction = {}

	function TabFunction:MakeTab(tabCfg)
		tabCfg = tabCfg or {}
		tabCfg.Name = tabCfg.Name or "标签"
		tabCfg.Icon = tabCfg.Icon or ""

		-- 左栏标签项
		local tabBtn = Create("TextButton", {
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = PanelColor,
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			Parent = tabHolder
		})
		local tabStroke = stroke(tabBtn)

		local tabIcon = Create("ImageLabel", {
			Size = UDim2.new(0, 14, 0, 14),
			Position = UDim2.new(0, 10, 0.5, -7),
			BackgroundTransparency = 1,
			Image = GetIcon(tabCfg.Icon) or "",
			ImageColor3 = TextColor,
			ImageTransparency = 0.4,
			Name = "Ico"
		}, {tabBtn})

		local tabText = Create("TextLabel", {
			Size = UDim2.new(1, -32, 1, 0),
			Position = UDim2.new(0, 30, 0, 0),
			BackgroundTransparency = 1,
			Text = tabCfg.Name,
			TextColor3 = TextColor,
			TextTransparency = 0.4,
			TextSize = 12,
			Font = Enum.Font.Code,
			TextXAlignment = Enum.TextXAlignment.Left,
			Name = "Title"
		}, {tabBtn})

		-- 内容滚动框
		local container = Create("ScrollingFrame", {
			Size = UDim2.new(1, -20, 1, -20),
			Position = UDim2.new(0, 10, 0, 10),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = HoverColor,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			Visible = false,
			Name = "ItemContainer",
			Parent = content
		})
		Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim2.new(0, 6)
		}, {container})

		AddConnection(container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			container.CanvasSize = UDim2.new(0, 0, 0, container.UIListLayout.AbsoluteContentSize.Y + 10)
		end)

		if FirstTab then
			FirstTab = false
			tabIcon.ImageTransparency = 0
			tabText.TextTransparency = 0
			tabBtn.BackgroundColor3 = SelectColor
			container.Visible = true
		end

		tabBtn.MouseEnter:Connect(function()
			if container.Visible then return end
			tabBtn.BackgroundColor3 = HoverColor
		end)
		tabBtn.MouseLeave:Connect(function()
			if container.Visible then return end
			tabBtn.BackgroundColor3 = PanelColor
		end)

		tabBtn.MouseButton1Click:Connect(function()
			for _, t in next, tabHolder:GetChildren() do
				if t:IsA("TextButton") then
					t.BackgroundColor3 = PanelColor
					t.Ico.ImageTransparency = 0.4
					t.Title.TextTransparency = 0.4
				end
			end
			for _, ic in next, content:GetChildren() do
				if ic.Name == "ItemContainer" then ic.Visible = false end
			end
			tabBtn.BackgroundColor3 = SelectColor
			tabIcon.ImageTransparency = 0
			tabText.TextTransparency = 0
			container.Visible = true
		end)

		local function GetElements(parent)
			local F = {}

			-- 文本标签
			function F:AddLabel(text)
				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 28)
				panel.Position = UDim2.new(0, 0, 0, 0)
				local l = makeLabel(panel, 8, 0, 0, 28, text or "", 12, TextColor)
				l.Size = UDim2.new(1, -16, 1, 0)

				local api = {}
				function api:Set(t) l.Text = t end
				return api
			end

			-- 段落
			function F:AddParagraph(title, content)
				title = title or "标题"
				content = content or "内容"
				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 30)
				local t = makeLabel(panel, 8, 6, 0, 14, title, 12, TextColor)
				t.Size = UDim2.new(1, -16, 0, 14)
				local b = makeLabel(panel, 8, 22, 0, 0, content, 11, TextDim)
				b.Size = UDim2.new(1, -16, 0, 0)
				b.TextWrapped = true
				b.AutomaticSize = Enum.AutomaticSize.Y

				AddConnection(b:GetPropertyChangedSignal("Text"), function()
					b.Size = UDim2.new(1, -16, 0, b.TextBounds.Y)
					panel.Size = UDim2.new(1, 0, 0, b.TextBounds.Y + 30)
				end)

				local api = {}
				function api:Set(c) b.Text = c end
				return api
			end

			-- 按钮
			function F:AddButton(btnCfg)
				btnCfg = btnCfg or {}
				btnCfg.Name = btnCfg.Name or "按钮"
				btnCfg.Callback = btnCfg.Callback or function() end
				btnCfg.Icon = btnCfg.Icon or "rbxassetid://3944703587"

				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 30)

				local t = makeLabel(panel, 8, 0, 0, 30, btnCfg.Name, 12, TextColor)
				t.Size = UDim2.new(1, -40, 1, 0)

				local ico = Create("ImageLabel", {
					Size = UDim2.new(0, 14, 0, 14),
					Position = UDim2.new(1, -22, 0.5, -7),
					BackgroundTransparency = 1,
					Image = GetIcon(btnCfg.Icon) or btnCfg.Icon,
					ImageColor3 = TextDim
				}, {panel})

				local click = Create("TextButton", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = ""
				}, {panel})

				click.MouseEnter:Connect(function() panel.BackgroundColor3 = HoverColor end)
				click.MouseLeave:Connect(function() panel.BackgroundColor3 = PanelColor end)
				click.MouseButton1Up:Connect(function()
					spawn(function() btnCfg.Callback() end)
				end)

				local api = {}
				function api:Set(v) t.Text = v end
				return api
			end

			-- 开关
			function F:AddToggle(tgCfg)
				tgCfg = tgCfg or {}
				tgCfg.Name = tgCfg.Name or "开关"
				tgCfg.Default = tgCfg.Default or false
				tgCfg.Callback = tgCfg.Callback or function() end
				tgCfg.Color = tgCfg.Color or SelectColor
				tgCfg.Flag = tgCfg.Flag
				tgCfg.Save = tgCfg.Save or false

				local Toggle = {Value = tgCfg.Default, Save = tgCfg.Save}

				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 30)

				makeLabel(panel, 8, 0, 0, 30, tgCfg.Name, 12, TextColor).Size = UDim2.new(1, -50, 1, 0)

				local box = Create("Frame", {
					Size = UDim2.new(0, 16, 0, 16),
					Position = UDim2.new(1, -24, 0.5, -8),
					BackgroundColor3 = FieldColor,
					BorderSizePixel = 0
				}, {panel})
				stroke(box)

				local tick = Create("ImageLabel", {
					Size = UDim2.new(0, 10, 0, 10),
					Position = UDim2.new(0.5, -5, 0.5, -5),
					BackgroundTransparency = 1,
					Image = "rbxassetid://3944680095",
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ImageTransparency = 1
				}, {box})

				local click = Create("TextButton", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = ""
				}, {panel})

				click.MouseEnter:Connect(function() panel.BackgroundColor3 = HoverColor end)
				click.MouseLeave:Connect(function() panel.BackgroundColor3 = PanelColor end)
				click.MouseButton1Up:Connect(function()
					SaveCfg(game.GameId)
					Toggle:Set(not Toggle.Value)
				end)

				function Toggle:Set(v)
					Toggle.Value = v
					box.BackgroundColor3 = v and tgCfg.Color or FieldColor
					tick.ImageTransparency = v and 0 or 1
					tgCfg.Callback(v)
				end
				Toggle:Set(Toggle.Value)

				if tgCfg.Flag then NKL.Flags[tgCfg.Flag] = Toggle end
				return Toggle
			end

			-- 滑块
			function F:AddSlider(sCfg)
				sCfg = sCfg or {}
				sCfg.Name = sCfg.Name or "滑块"
				sCfg.Min = sCfg.Min or 0
				sCfg.Max = sCfg.Max or 100
				sCfg.Increment = sCfg.Increment or 1
				sCfg.Default = sCfg.Default or 50
				sCfg.Callback = sCfg.Callback or function() end
				sCfg.ValueName = sCfg.ValueName or ""
				sCfg.Color = sCfg.Color or SelectColor
				sCfg.Flag = sCfg.Flag
				sCfg.Save = sCfg.Save or false

				local Slider = {Value = sCfg.Default, Save = sCfg.Save}
				local dragging = false

				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 56)

				makeLabel(panel, 8, 6, 0, 14, sCfg.Name, 12, TextColor).Size = UDim2.new(1, -16, 0, 14)

				local track = Create("Frame", {
					Size = UDim2.new(1, -20, 0, 20),
					Position = UDim2.new(0, 10, 0, 26),
					BackgroundColor3 = FieldColor,
					BorderSizePixel = 0
				}, {panel})
				stroke(track)

				local fill = Create("Frame", {
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundColor3 = sCfg.Color,
					BackgroundTransparency = 0.3,
					BorderSizePixel = 0
				}, {track})

				local val = makeLabel(track, 8, 0, 0, 20, "", 11, TextColor)
				val.Size = UDim2.new(1, -16, 1, 0)

				track.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
				end)
				track.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
				end)
				AddConnection(UserInputService.InputChanged, function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						local scale = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
						Slider:Set(sCfg.Min + ((sCfg.Max - sCfg.Min) * scale))
						SaveCfg(game.GameId)
					end
				end)

				function Slider:Set(v)
					self.Value = math.clamp(Round(v, sCfg.Increment), sCfg.Min, sCfg.Max)
					local pct = (self.Value - sCfg.Min) / (sCfg.Max - sCfg.Min)
					fill.Size = UDim2.fromScale(pct, 1)
					val.Text = tostring(self.Value) .. " " .. sCfg.ValueName
					sCfg.Callback(self.Value)
				end
				Slider:Set(Slider.Value)

				if sCfg.Flag then NKL.Flags[sCfg.Flag] = Slider end
				return Slider
			end

			-- 下拉
			function F:AddDropdown(dCfg)
				dCfg = dCfg or {}
				dCfg.Name = dCfg.Name or "下拉"
				dCfg.Options = dCfg.Options or {}
				dCfg.Default = dCfg.Default or ""
				dCfg.Callback = dCfg.Callback or function() end
				dCfg.Flag = dCfg.Flag
				dCfg.Save = dCfg.Save or false

				local Dropdown = {Value = dCfg.Default, Options = dCfg.Options, Buttons = {}, Toggled = false, Type = "Dropdown", Save = dCfg.Save}
				local MaxEl = 5

				if not table.find(Dropdown.Options, Dropdown.Value) then Dropdown.Value = "..." end

				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 30)
				panel.ClipsDescendants = true

				local header = Create("Frame", {
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 1,
					ClipsDescendants = true
				}, {panel})

				local title = makeLabel(header, 8, 0, 0, 30, dCfg.Name, 12, TextColor)
				title.Size = UDim2.new(1, -120, 1, 0)

				local sel = makeLabel(header, 0, 0, 80, 30, Dropdown.Value, 11, TextDim, Enum.TextXAlignment.Right)
				sel.Position = UDim2.new(1, -104, 0, 0)
				sel.Name = "Selected"

				local arrow = makeLabel(header, 0, 0, 14, 14, "v", 11, TextDim, Enum.TextXAlignment.Center)
				arrow.Position = UDim2.new(1, -20, 0, 8)
				arrow.Name = "Ico"

				local list = Create("ScrollingFrame", {
					Size = UDim2.new(1, 0, 1, -30),
					Position = UDim2.new(0, 0, 0, 30),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ScrollBarThickness = 3,
					ScrollBarImageColor3 = HoverColor,
					CanvasSize = UDim2.new(0, 0, 0, 0)
				}, {panel})
				Create("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim2.new(0, 0)
				}, {list})
				AddConnection(list.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					list.CanvasSize = UDim2.new(0, 0, 0, list.UIListLayout.AbsoluteContentSize.Y)
				end)

				local function AddOptions(options)
					for _, opt in pairs(options) do
						local b = Create("TextButton", {
							Size = UDim2.new(1, 0, 0, 22),
							BackgroundColor3 = PanelColor,
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Text = "",
							AutoButtonColor = false
						}, {list})
						local l = makeLabel(b, 8, 0, 0, 22, opt, 11, TextDim)
						l.Size = UDim2.new(1, -8, 1, 0)
						l.TextTransparency = 0.4
						l.Name = "Title"

						b.MouseButton1Click:Connect(function()
							Dropdown:Set(opt)
							SaveCfg(game.GameId)
						end)
						Dropdown.Buttons[opt] = b
					end
				end

				function Dropdown:Refresh(options, delete)
					if delete then
						for _, v in pairs(Dropdown.Buttons) do v:Destroy() end
						table.clear(Dropdown.Options)
						table.clear(Dropdown.Buttons)
					end
					Dropdown.Options = options
					AddOptions(Dropdown.Options)
				end

				function Dropdown:Set(v)
					if not table.find(Dropdown.Options, v) then
						Dropdown.Value = "..."
						sel.Text = "..."
						return
					end
					Dropdown.Value = v
					sel.Text = v
					for _, b in pairs(Dropdown.Buttons) do
						b.BackgroundTransparency = 1
						b.Title.TextTransparency = 0.4
					end
					if Dropdown.Buttons[v] then
						Dropdown.Buttons[v].BackgroundTransparency = 0
						Dropdown.Buttons[v].Title.TextTransparency = 0
					end
					return dCfg.Callback(Dropdown.Value)
				end

				local click = Create("TextButton", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = ""
				}, {header})
				click.MouseButton1Click:Connect(function()
					Dropdown.Toggled = not Dropdown.Toggled
					arrow.Text = Dropdown.Toggled and "^" or "v"
					local target
					if #Dropdown.Options > MaxEl then
						target = Dropdown.Toggled and (30 + MaxEl * 22) or 30
					else
						target = Dropdown.Toggled and (list.UIListLayout.AbsoluteContentSize.Y + 30) or 30
					end
					TweenService:Create(panel, TweenInfo.new(0.15), {Size = UDim2.new(1, 0, 0, target)}):Play()
				end)

				Dropdown:Refresh(Dropdown.Options, false)
				Dropdown:Set(Dropdown.Value)

				if dCfg.Flag then NKL.Flags[dCfg.Flag] = Dropdown end
				return Dropdown
			end

			-- 绑定
			function F:AddBind(bCfg)
				bCfg = bCfg or {}
				bCfg.Name = bCfg.Name or "绑定"
				bCfg.Default = bCfg.Default or Enum.KeyCode.Unknown
				bCfg.Hold = bCfg.Hold or false
				bCfg.Callback = bCfg.Callback or function() end
				bCfg.Flag = bCfg.Flag
				bCfg.Save = bCfg.Save or false

				local Bind = {Value = nil, Binding = false, Type = "Bind", Save = bCfg.Save}
				local holding = false

				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 30)

				makeLabel(panel, 8, 0, 0, 30, bCfg.Name, 12, TextColor).Size = UDim2.new(1, -80, 1, 0)

				local box = Create("Frame", {
					Size = UDim2.new(0, 40, 0, 20),
					Position = UDim2.new(1, -48, 0.5, -10),
					BackgroundColor3 = FieldColor,
					BorderSizePixel = 0
				}, {panel})
				stroke(box)

				local val = makeLabel(box, 0, 0, 40, 20, "", 11, TextColor, Enum.TextXAlignment.Center)
				val.Name = "Value"

				local click = Create("TextButton", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = ""
				}, {panel})
				click.MouseEnter:Connect(function() panel.BackgroundColor3 = HoverColor end)
				click.MouseLeave:Connect(function() panel.BackgroundColor3 = PanelColor end)

				click.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Bind.Binding then return end
						Bind.Binding = true
						val.Text = ""
					end
				end)

				AddConnection(UserInputService.InputBegan, function(input)
					if UserInputService:GetFocusedTextBox() then return end
					if (input.KeyCode.Name == Bind.Value or input.UserInputType.Name == Bind.Value) and not Bind.Binding then
						if bCfg.Hold then
							holding = true
							bCfg.Callback(holding)
						else
							bCfg.Callback()
						end
					elseif Bind.Binding then
						local Key
						pcall(function()
							if not CheckKey(BlacklistedKeys, input.KeyCode) then Key = input.KeyCode end
						end)
						pcall(function()
							if CheckKey(WhitelistedMouse, input.UserInputType) and not Key then Key = input.UserInputType end
						end)
						Key = Key or Bind.Value
						Bind:Set(Key)
						SaveCfg(game.GameId)
					end
				end)

				AddConnection(UserInputService.InputEnded, function(input)
					if input.KeyCode.Name == Bind.Value or input.UserInputType.Name == Bind.Value then
						if bCfg.Hold and holding then
							holding = false
							bCfg.Callback(holding)
						end
					end
				end)

				function Bind:Set(k)
					Bind.Binding = false
					Bind.Value = k or Bind.Value
					Bind.Value = Bind.Value.Name or Bind.Value
					val.Text = Bind.Value
				end
				Bind:Set(bCfg.Default)

				if bCfg.Flag then NKL.Flags[bCfg.Flag] = Bind end
				return Bind
			end

			-- 文本框
			function F:AddTextbox(tCfg)
				tCfg = tCfg or {}
				tCfg.Name = tCfg.Name or "文本框"
				tCfg.Default = tCfg.Default or ""
				tCfg.TextDisappear = tCfg.TextDisappear or false
				tCfg.Callback = tCfg.Callback or function() end

				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 30)

				makeLabel(panel, 8, 0, 0, 30, tCfg.Name, 12, TextColor).Size = UDim2.new(1, -160, 1, 0)

				local box = Create("Frame", {
					Size = UDim2.new(0, 140, 0, 20),
					Position = UDim2.new(1, -148, 0.5, -10),
					BackgroundColor3 = FieldColor,
					BorderSizePixel = 0
				}, {panel})
				stroke(box)

				local input = Create("TextBox", {
					Size = UDim2.new(1, -12, 1, 0),
					Position = UDim2.new(0, 6, 0, 0),
					BackgroundTransparency = 1,
					Text = tCfg.Default,
					PlaceholderText = "输入",
					PlaceholderColor3 = TextDim,
					TextColor3 = TextColor,
					TextSize = 11,
					Font = Enum.Font.Code,
					TextXAlignment = Enum.TextXAlignment.Left,
					ClearTextOnFocus = false
				}, {box})

				input.FocusLost:Connect(function()
					tCfg.Callback(input.Text)
					if tCfg.TextDisappear then input.Text = "" end
				end)
			end

			-- 取色器
			function F:AddColorpicker(cCfg)
				cCfg = cCfg or {}
				cCfg.Name = cCfg.Name or "颜色"
				cCfg.Default = cCfg.Default or Color3.fromRGB(255, 255, 255)
				cCfg.Callback = cCfg.Callback or function() end
				cCfg.Flag = cCfg.Flag
				cCfg.Save = cCfg.Save or false

				local H, S, V = 1, 1, 1
				local Picker = {Value = cCfg.Default, Toggled = false, Type = "Colorpicker", Save = cCfg.Save}

				local panel = makePanel(parent, 0, 0, 0, 0)
				panel.Size = UDim2.new(1, 0, 0, 30)
				panel.ClipsDescendants = true

				local header = Create("Frame", {
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 1,
					ClipsDescendants = true
				}, {panel})

				makeLabel(header, 8, 0, 0, 30, cCfg.Name, 12, TextColor).Size = UDim2.new(1, -50, 1, 0)

				local swatch = Create("Frame", {
					Size = UDim2.new(0, 20, 0, 16),
					Position = UDim2.new(1, -28, 0.5, -8),
					BackgroundColor3 = cCfg.Default,
					BorderSizePixel = 0
				}, {header})
				stroke(swatch)

				local click = Create("TextButton", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text = ""
				}, {header})

				local container = Create("Frame", {
					Size = UDim2.new(1, 0, 0, 80),
					Position = UDim2.new(0, 0, 0, 30),
					BackgroundTransparency = 1
				}, {panel})

				local color = Create("ImageLabel", {
					Size = UDim2.new(1, -60, 0, 80),
					Position = UDim2.new(0, 5, 0, 0),
					BackgroundTransparency = 1,
					Image = "rbxassetid://4155801252"
				}, {container})
				stroke(color)

				local hue = Create("Frame", {
					Size = UDim2.new(0, 20, 0, 80),
					Position = UDim2.new(1, -50, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0
				}, {container})
				Create("UIGradient", {
					Rotation = 270,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),
						ColorSequenceKeypoint.new(0.2, Color3.fromRGB(234, 255, 0)),
						ColorSequenceKeypoint.new(0.4, Color3.fromRGB(21, 255, 0)),
						ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 17, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 251))
					}
				}, {hue})
				stroke(hue)

				local colorSel = Create("ImageLabel", {
					Size = UDim2.new(0, 12, 0, 12),
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4805639000"
				}, {color})
				local hueSel = Create("ImageLabel", {
					Size = UDim2.new(0, 12, 0, 12),
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4805639000"
				}, {hue})

				local function update()
					swatch.BackgroundColor3 = Color3.fromHSV(H, S, V)
					color.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
					cCfg.Callback(swatch.BackgroundColor3)
				end

				click.MouseButton1Click:Connect(function()
					Picker.Toggled = not Picker.Toggled
					TweenService:Create(panel, TweenInfo.new(0.15), {Size = Picker.Toggled and UDim2.new(1, 0, 0, 110) or UDim2.new(1, 0, 0, 30)}):Play()
				end)

				color.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local c = RunService.RenderStepped:Connect(function()
							local x = math.clamp((Mouse.X - color.AbsolutePosition.X) / color.AbsoluteSize.X, 0, 1)
							local y = math.clamp((Mouse.Y - color.AbsolutePosition.Y) / color.AbsoluteSize.Y, 0, 1)
							colorSel.Position = UDim2.new(x, -6, y, -6)
							S = x
							V = 1 - y
							update()
						end)
						UserInputService.InputEnded:Connect(function(i)
							if i.UserInputType == Enum.UserInputType.MouseButton1 then c:Disconnect() end
						end)
					end
				end)

				hue.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local c = RunService.RenderStepped:Connect(function()
							local y = math.clamp((Mouse.Y - hue.AbsolutePosition.Y) / hue.AbsoluteSize.Y, 0, 1)
							hueSel.Position = UDim2.new(0.5, -6, y, -6)
							H = 1 - y
							update()
						end)
						UserInputService.InputEnded:Connect(function(i)
							if i.UserInputType == Enum.UserInputType.MouseButton1 then c:Disconnect() end
						end)
					end
				end)

				function Picker:Set(v)
					Picker.Value = v
					swatch.BackgroundColor3 = v
					cCfg.Callback(v)
				end
				Picker:Set(cCfg.Default)

				if cCfg.Flag then NKL.Flags[cCfg.Flag] = Picker end
				return Picker
			end

			return F
		end

		-- 选项卡 API
		local TabAPI = {}
		local baseElements = GetElements(container)
		for k, v in next, baseElements do
			TabAPI[k] = v
		end

		-- 分组（漫画器 GroupBox 风）
		function TabAPI:AddSection(secCfg)
			secCfg = secCfg or {}
			secCfg.Name = secCfg.Name or "分组"

			local wrapper = Create("Frame", {
				Size = UDim2.new(1, 0, 0, 30),
				BackgroundTransparency = 1,
				Parent = container
			})
			Create("UIPadding", {
				PaddingTop = UDim2.new(0, 8),
				PaddingBottom = UDim2.new(0, 4),
				PaddingLeft = UDim2.new(0, 0),
				PaddingRight = UDim2.new(0, 0)
			}, {wrapper})

			local group = makeGroupBox(wrapper, 0, 8, 0, 0, secCfg.Name)
			group.Size = UDim2.new(1, 0, 0, 20)
			group.Position = UDim2.new(0, 0, 0, 8)

			local holder = Create("Frame", {
				Size = UDim2.new(1, -16, 0, 0),
				Position = UDim2.new(0, 8, 0, 16),
				BackgroundTransparency = 1,
				Name = "Holder"
			}, {group})
			Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim2.new(0, 6)
			}, {holder})

			AddConnection(holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				holder.Size = UDim2.new(1, -16, 0, holder.UIListLayout.AbsoluteContentSize.Y)
				group.Size = UDim2.new(1, 0, 0, holder.UIListLayout.AbsoluteContentSize.Y + 26)
				wrapper.Size = UDim2.new(1, 0, 0, group.AbsoluteSize.Y + 12)
			end)

			local SecAPI = {}
			local el = GetElements(holder)
			for k, v in next, el do
				SecAPI[k] = v
			end
			return SecAPI
		end

		return TabAPI
	end

	-- 开场动画
	if cfg.IntroEnabled then
		win.Visible = false
		local logo = Create("ImageLabel", {
			Size = UDim2.new(0, 28, 0, 28),
			Position = UDim2.new(0.5, -14, 0.45, 0),
			BackgroundTransparency = 1,
			Image = cfg.IntroIcon,
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			ImageTransparency = 1
		}, {ScreenGui})
		local text = Create("TextLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
			Text = cfg.IntroText,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			Font = Enum.Font.Code,
			TextTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Center
		}, {ScreenGui})

		TweenService:Create(logo, TweenInfo.new(0.4), {ImageTransparency = 0}):Play()
		wait(0.8)
		TweenService:Create(logo, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
		TweenService:Create(text, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
		wait(0.6)
		TweenService:Create(text, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
		wait(0.4)
		logo:Destroy()
		text:Destroy()
		win.Visible = true
	end

	return TabFunction
end

function NKL:Destroy()
	ScreenGui:Destroy()
end

return NKL