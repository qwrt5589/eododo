repeat
	task.wait()
until game:IsLoaded()
local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}
library.favorites = {}
library.favoriteCallbacks = {}
library.favoriteUpdateSignal = Instance.new("BindableEvent")

-- DataStore保存收藏
local success, dataStore = pcall(function()
    return game:GetService("DataStoreService"):GetDataStore("UI_Favorites_v3")
end)

local function LoadFavorites()
    if success then
        local playerId = tostring(game.Players.LocalPlayer.UserId)
        local success2, saved = pcall(function()
            return dataStore:GetAsync(playerId)
        end)
        if success2 and saved then
            library.favorites = saved
        end
    end
end

local function SaveFavorites()
    if success then
        local playerId = tostring(game.Players.LocalPlayer.UserId)
        pcall(function()
            dataStore:SetAsync(playerId, library.favorites)
        end)
    end
end

LoadFavorites()

-- 收藏管理函数
function library:AddFavorite(buttonName, callback, sectionName, tabName)
    if not library.favorites[buttonName] then
        library.favorites[buttonName] = {
            timestamp = os.time(),
            sectionName = sectionName,
            tabName = tabName
        }
        library.favoriteCallbacks[buttonName] = callback
        library.favoriteUpdateSignal:Fire()
        SaveFavorites()
        return true
    end
    return false
end

function library:RemoveFavorite(buttonName)
    if library.favorites[buttonName] then
        library.favorites[buttonName] = nil
        library.favoriteCallbacks[buttonName] = nil
        library.favoriteUpdateSignal:Fire()
        SaveFavorites()
        return true
    end
    return false
end

function library:ToggleFavorite(buttonName, callback, sectionName, tabName)
    if library.favorites[buttonName] then
        return library:RemoveFavorite(buttonName)
    else
        return library:AddFavorite(buttonName, callback, sectionName, tabName)
    end
end

function library:IsFavorite(buttonName)
    return library.favorites[buttonName] ~= nil
end

function library:GetFavoriteCallback(buttonName)
    return library.favoriteCallbacks[buttonName]
end

function GetSortedFavorites()
    local sorted = {}
    for name, data in pairs(library.favorites) do
        table.insert(sorted, {
            name = name,
            timestamp = data.timestamp,
            sectionName = data.sectionName,
            tabName = data.tabName
        })
    end
    table.sort(sorted, function(a, b)
        return a.timestamp > b.timestamp
    end)
    return sorted
end

local services = setmetatable({}, {
	__index = function(t, k)
		return game.GetService(game, k)
	end,
})
local mouse = services.Players.LocalPlayer:GetMouse()

local RainbowColors = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 128, 0),
    Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 128, 255),
    Color3.fromRGB(0, 0, 255), Color3.fromRGB(128, 0, 255),
    Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 0, 128)
}
local currentColorIndex = 1
local colorTransitionSpeed = 0.5
local isAnimating = true
local PlaceholderColor = Color3.fromRGB(180, 180, 180)
local DisabledTextColor = Color3.fromRGB(150, 150, 150)

-- 霓虹灯动画
spawn(function()
    while isAnimating do
        currentColorIndex = currentColorIndex % #RainbowColors + 1
        task.wait(colorTransitionSpeed)
    end
end)

function GetRainbowColor()
    return RainbowColors[currentColorIndex]
end

function AnimateTextColor(textLabel)
    spawn(function()
        while textLabel and textLabel.Parent do
            local nextIndex = currentColorIndex % #RainbowColors + 1
            local nextColor = RainbowColors[nextIndex]
            
            services.TweenService:Create(textLabel, TweenInfo.new(colorTransitionSpeed), {
                TextColor3 = nextColor
            }):Play()
            task.wait(colorTransitionSpeed)
            
            if not textLabel or not textLabel.Parent then break end
        end
    end)
end

function Tween(obj, t, data)
	services.TweenService
		:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data)
		:Play()
	return true
end

function Ripple(obj)
	spawn(function()
		if obj.ClipsDescendants ~= true then
			obj.ClipsDescendants = true
		end
		local Ripple = Instance.new("ImageLabel")
		Ripple.Name = "Ripple"
		Ripple.Parent = obj
		Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://2708891598"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Ripple.Position = UDim2.new(
			(mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,
			0,
			(mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,
			0
		)
		Tween(
			Ripple,
			{ 0.3, "Linear", "InOut" },
			{ Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0) }
		)
		wait(0.15)
		Tween(Ripple, { 0.3, "Linear", "InOut" }, { ImageTransparency = 1 })
		wait(0.3)
		Ripple:Destroy()
	end)
end

local toggled = false
local switchingTabs = false

function switchTab(new)
	if switchingTabs then
		return
	end
	local old = library.currentTab
	if old == nil then
		new[2].Visible = true
		library.currentTab = new
		services.TweenService:Create(new[1], TweenInfo.new(0.1), { ImageTransparency = 0 }):Play()
		services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
		return
	end
	if old[1] == new[1] then
		return
	end
	switchingTabs = true
	library.currentTab = new
	services.TweenService:Create(old[1], TweenInfo.new(0.1), { ImageTransparency = 0.2 }):Play()
	services.TweenService:Create(new[1], TweenInfo.new(0.1), { ImageTransparency = 0 }):Play()
	services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0.2 }):Play()
	services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
	old[2].Visible = false
	new[2].Visible = true
	task.wait(0.1)
	switchingTabs = false
end

function drag(frame, hold)
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position =
			UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
function library.new(library, name, theme)
	for _, v in next, services.CoreGui:GetChildren() do
		if v.Name == "REN" then
			v:Destroy()
		end
	end
	
	MainColor = Color3.fromRGB(0, 0, 0)
	Background = Color3.fromRGB(0, 0, 0)
	BackgroundTransparency = 0.5
	zyColor = Color3.fromRGB(30, 30, 30)
	zyColorTransparency = 0.3
	beijingColor = Color3.fromRGB(255, 255, 255)

	local dogent = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local TabMain = Instance.new("Frame")
	local MainC = Instance.new("UICorner")
	local SB = Instance.new("Frame")
	local SBC = Instance.new("UICorner")
	local Side = Instance.new("Frame")
	local SideG = Instance.new("UIGradient")
	local TabBtns = Instance.new("ScrollingFrame")
	local TabBtnsL = Instance.new("UIListLayout")
	local ScriptTitle = Instance.new("TextLabel")
	local SBG = Instance.new("UIGradient")
	local Open = Instance.new("TextButton")
	local UIG = Instance.new("UIGradient")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local UICornerMain = Instance.new("UICorner")
	local UIGradient = Instance.new("UIGradient")
	local UIGradientTitle = Instance.new("UIGradient")
	
	if syn and syn.protect_gui then
		syn.protect_gui(dogent)
	end
	
	dogent.Name = "REN"
	dogent.Parent = services.CoreGui
	
	function UiDestroy()
		dogent:Destroy()
	end

function ToggleUILib()
    Main.Visible = not Main.Visible
end
	
	Main.Name = "Main"
	Main.Parent = dogent
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Background
	Main.BackgroundTransparency = BackgroundTransparency
	Main.BorderColor3 = MainColor
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 572, 0, 353)
	Main.ZIndex = 1
	Main.Active = true
	Main.Draggable = true
	
	services.UserInputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftControl then
			if Main.Visible == true then
				Main.Visible = false
			else
				Main.Visible = true
			end
		end
	end)
	
	drag(Main)
	UICornerMain.Parent = Main
	UICornerMain.CornerRadius = UDim.new(0, 3)
	
	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = Main
	DropShadowHolder.BackgroundTransparency = 1.000
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
	DropShadowHolder.ZIndex = 0
	
	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 43, 1, 43)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
	
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(52, 152, 219)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(41, 128, 185)),
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(31, 97, 141)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(21, 67, 96)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(52, 152, 219))
	})
	UIGradient.Parent = DropShadow
	
	local TweenService = game:GetService("TweenService")
	local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
	local tween = TweenService:Create(UIGradient, tweeninfo, { Rotation = 360 })
	tween:Play()
	
	function toggleui()
		toggled = not toggled
		spawn(function()
			if toggled then
				wait(0.3)
			end
		end)
		Tween(Main, { 0.3, "Sine", "InOut" }, { Size = UDim2.new(0, 609, 0, (toggled and 505 or 0)) })
	end
	
	TabMain.Name = "TabMain"
	TabMain.Parent = Main
	TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabMain.BackgroundTransparency = 1.000
	TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
	TabMain.Size = UDim2.new(0, 448, 0, 353)
	
	MainC.CornerRadius = UDim.new(0, 5.5)
	MainC.Name = "MainC"
	MainC.Parent = Main
	
	SB.Name = "SB"
	SB.Parent = Main
	SB.BackgroundColor3 = Background
	SB.BackgroundTransparency = BackgroundTransparency
	SB.BorderColor3 = MainColor
	SB.Size = UDim2.new(0, 8, 0, 353)
	
	SBC.CornerRadius = UDim.new(0, 6)
	SBC.Name = "SBC"
	SBC.Parent = SB
	
	Side.Name = "Side"
	Side.Parent = SB
	Side.BackgroundColor3 = Background
	Side.BackgroundTransparency = BackgroundTransparency
	Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
	Side.BorderSizePixel = 0
	Side.ClipsDescendants = true
	Side.Position = UDim2.new(1, 0, 0, 0)
	Side.Size = UDim2.new(0, 110, 0, 353)
	
	SideG.Color =
		ColorSequence.new({ ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor) })
	SideG.Rotation = 90
	SideG.Name = "SideG"
	SideG.Parent = Side
	
	TabBtns.Name = "TabBtns"
	TabBtns.Parent = Side
	TabBtns.Active = true
	TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabBtns.BackgroundTransparency = 1.000
	TabBtns.BorderSizePixel = 0
	TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
	TabBtns.Size = UDim2.new(0, 110, 0, 318)
	TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
	TabBtns.ScrollBarThickness = 0
	
	TabBtnsL.Name = "TabBtnsL"
	TabBtnsL.Parent = TabBtns
	TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
	TabBtnsL.Padding = UDim.new(0, 12)
	
	ScriptTitle.Name = "ScriptTitle"
	ScriptTitle.Parent = Side
	ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScriptTitle.BackgroundTransparency = 1.000
	ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
	ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
	ScriptTitle.Font = Enum.Font.GothamBlack
	ScriptTitle.Text = name
	ScriptTitle.TextColor3 = GetRainbowColor()
	ScriptTitle.TextSize = 16.000
	ScriptTitle.TextTransparency = 0
	ScriptTitle.TextScaled = true
	ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
	
	AnimateTextColor(ScriptTitle)
	
	UIGradientTitle.Parent = ScriptTitle
	
	local function NPLHKB_fake_script()
		local script = Instance.new("LocalScript", ScriptTitle)
		local button = script.Parent
		local gradient = button.UIGradient
		local ts = game:GetService("TweenService")
		local ti = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		local offset = { Offset = Vector2.new(1, 0) }
		local create = ts:Create(gradient, ti, offset)
		local startingPos = Vector2.new(-1, 0)
		local list = {}
		local s, kpt = ColorSequence.new, ColorSequenceKeypoint.new
		local counter = 0
		local status = "down"
		gradient.Offset = startingPos
		local function rainbowColors()
			local sat, val = 255, 255
			for i = 1, 10 do
				local hue = i * 17
				table.insert(list, Color3.fromHSV(hue / 255, sat / 255, val / 255))
			end
		end
		rainbowColors()
		gradient.Color = s({ kpt(0, list[#list]), kpt(0.5, list[#list - 1]), kpt(1, list[#list - 2]) })
		counter = #list
		local function animate()
			create:Play()
			create.Completed:Wait()
			gradient.Offset = startingPos
			gradient.Rotation = 180
			if counter == #list - 1 and status == "down" then
				gradient.Color =
					s({ kpt(0, gradient.Color.Keypoints[1].Value), kpt(0.5, list[#list]), kpt(1, list[1]) })
				counter = 1
				status = "up"
			elseif counter == #list and status == "down" then
				gradient.Color = s({ kpt(0, gradient.Color.Keypoints[1].Value), kpt(0.5, list[1]), kpt(1, list[2]) })
				counter = 2
				status = "up"
			elseif counter <= #list - 2 and status == "down" then
				gradient.Color = s({
					kpt(0, gradient.Color.Keypoints[1].Value),
					kpt(0.5, list[counter + 1]),
					kpt(1, list[counter + 2]),
				})
				counter = counter + 2
				status = "up"
			end
			create:Play()
			create.Completed:Wait()
			gradient.Offset = startingPos
			gradient.Rotation = 0
			if counter == #list - 1 and status == "up" then
				gradient.Color =
					s({ kpt(0, list[1]), kpt(0.5, list[#list]), kpt(1, gradient.Color.Keypoints[3].Value) })
				counter = 1
				status = "down"
			elseif counter == #list and status == "up" then
				gradient.Color = s({ kpt(0, list[2]), kpt(0.5, list[1]), kpt(1, gradient.Color.Keypoints[3].Value) })
				counter = 2
				status = "down"
			elseif counter <= #list - 2 and status == "up" then
				gradient.Color = s({
					kpt(0, list[counter + 2]),
					kpt(0.5, list[counter + 1]),
					kpt(1, gradient.Color.Keypoints[3].Value),
				})
				counter = counter + 2
				status = "down"
			end
			animate()
		end
		animate()
	end
	coroutine.wrap(NPLHKB_fake_script)()
	
	SBG.Color =
		ColorSequence.new({ ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor) })
	SBG.Rotation = 90
	SBG.Name = "SBG"
	SBG.Parent = SB
	
	TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
	end)
	
Open.Name = "Open"
Open.Parent = dogent
Open.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Open.BackgroundTransparency = BackgroundTransparency
Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
Open.Size = UDim2.new(0, 61, 0, 32)
Open.Font = Enum.Font.GothamBold
Open.Text = "辰脚本"
Open.TextColor3 = GetRainbowColor()
Open.TextTransparency = 0
Open.TextSize = 14.000
Open.Active = true
Open.Draggable = true
Open.ZIndex = 100

AnimateTextColor(Open)

UIG.Parent = Open

Open.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)
	
	local window = {}
	function window.Tab(window, name, icon)
	local Tab = Instance.new("ScrollingFrame")
	local TabIco = Instance.new("ImageLabel")
	local TabText = Instance.new("TextLabel")
	local TabBtn = Instance.new("TextButton")
	local TabL = Instance.new("UIListLayout")
	
	Tab.Name = name
	Tab.Parent = TabMain
	Tab.Active = true
	Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tab.BackgroundTransparency = 1.000
	Tab.Size = UDim2.new(1, 0, 1, 0)
	Tab.ScrollBarThickness = 2
	Tab.Visible = false
	
	TabIco.Name = "TabIco"
	TabIco.Parent = TabBtns
	TabIco.BackgroundTransparency = 1.000
	TabIco.BorderSizePixel = 0
	TabIco.Size = UDim2.new(0, 24, 0, 24)
	TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
	TabIco.ImageTransparency = 0.2
	
	TabText.Name = "TabText"
	TabText.Parent = TabIco
	TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabText.BackgroundTransparency = 1.000
	TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
	TabText.Size = UDim2.new(0, 76, 0, 24)
	TabText.Font = Enum.Font.GothamSemibold
	TabText.Text = name
	TabText.TextColor3 = GetRainbowColor()
	TabText.TextSize = 14.000
	TabText.TextTransparency = 0.2
	TabText.TextXAlignment = Enum.TextXAlignment.Left
	
	AnimateTextColor(TabText)
	
	TabBtn.Name = "TabBtn"
	TabBtn.Parent = TabIco
	TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabBtn.BackgroundTransparency = 1.000
	TabBtn.BorderSizePixel = 0
	TabBtn.Size = UDim2.new(0, 110, 0, 24)
	TabBtn.AutoButtonColor = false
	TabBtn.Font = Enum.Font.SourceSans
	TabBtn.Text = ""
	TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	TabBtn.TextSize = 14.000
	
	TabL.Name = "TabL"
	TabL.Parent = Tab
	TabL.SortOrder = Enum.SortOrder.LayoutOrder
	TabL.Padding = UDim.new(0, 4)
	
	TabBtn.MouseButton1Click:Connect(function()
		spawn(function()
			Ripple(TabBtn)
		end)
		switchTab({ TabIco, Tab })
	end)
	
	if library.currentTab == nil then
		switchTab({ TabIco, Tab })
	end
	
	TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
	end)
	
	local tab = {}
	
	function tab.section(tab, sectionName, TabVal)
		local Section = Instance.new("Frame")
		local SectionC = Instance.new("UICorner")
		local SectionText = Instance.new("TextLabel")
		local SectionOpen = Instance.new("ImageLabel")
		local SectionOpened = Instance.new("ImageLabel")
		local SectionToggle = Instance.new("ImageButton")
		local Objs = Instance.new("Frame")
		local ObjsL = Instance.new("UIListLayout")
		
		Section.Name = "Section_" .. sectionName
		Section.Parent = Tab
		Section.BackgroundColor3 = zyColor
		Section.BackgroundTransparency = zyColorTransparency
		Section.BorderSizePixel = 0
		Section.ClipsDescendants = true
		Section.Size = UDim2.new(0.981000006, 0, 0, 36)
		
		SectionC.CornerRadius = UDim.new(0, 10)
		SectionC.Name = "SectionC"
		SectionC.Parent = Section
		
		SectionText.Name = "SectionText"
		SectionText.Parent = Section
		SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SectionText.BackgroundTransparency = 1.000
		SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
		SectionText.Size = UDim2.new(0, 401, 0, 36)
		SectionText.Font = Enum.Font.GothamBold
		SectionText.Text = sectionName
		SectionText.TextColor3 = GetRainbowColor()
		SectionText.TextSize = 16.000
		SectionText.TextTransparency = 0
		SectionText.TextXAlignment = Enum.TextXAlignment.Left
		
		AnimateTextColor(SectionText)
		
		SectionOpen.Name = "SectionOpen"
		SectionOpen.Parent = SectionText
		SectionOpen.BackgroundTransparency = 1
		SectionOpen.BorderSizePixel = 0
		SectionOpen.Position = UDim2.new(0, -33, 0, 5)
		SectionOpen.Size = UDim2.new(0, 26, 0, 26)
		SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"
		SectionOpen.ImageColor3 = Color3.fromRGB(255, 255, 255)
		
		SectionOpened.Name = "SectionOpened"
		SectionOpened.Parent = SectionOpen
		SectionOpened.BackgroundTransparency = 1.000
		SectionOpened.BorderSizePixel = 0
		SectionOpened.Size = UDim2.new(0, 26, 0, 26)
		SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
		SectionOpened.ImageTransparency = 1.000
		SectionOpened.ImageColor3 = Color3.fromRGB(255, 255, 255)
		
		SectionToggle.Name = "SectionToggle"
		SectionToggle.Parent = SectionOpen
		SectionToggle.BackgroundTransparency = 1
		SectionToggle.BorderSizePixel = 0
		SectionToggle.Size = UDim2.new(0, 26, 0, 26)
		
		Objs.Name = "Objs"
		Objs.Parent = Section
		Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Objs.BackgroundTransparency = 1
		Objs.BorderSizePixel = 0
		Objs.Position = UDim2.new(0, 6, 0, 36)
		Objs.Size = UDim2.new(0.986347735, 0, 0, 0)
		
		ObjsL.Name = "ObjsL"
		ObjsL.Parent = Objs
		ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
		ObjsL.Padding = UDim.new(0, 8)
		
		local open = TabVal
		if TabVal ~= false then
			Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
			SectionOpened.ImageTransparency = (open and 0 or 1)
			SectionOpen.ImageTransparency = (open and 1 or 0)
		end
		
		SectionToggle.MouseButton1Click:Connect(function()
			open = not open
			Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
			SectionOpened.ImageTransparency = (open and 0 or 1)
			SectionOpen.ImageTransparency = (open and 1 or 0)
		end)
		
		ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if not open then
				return
			end
			Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
		end)
		
		-- 收藏置顶功能
		local function RefreshFavorites()
			-- 移除旧的收藏按钮
			for _, child in pairs(Objs:GetChildren()) do
				if child.Name == "FavoriteButton" then
					child:Destroy()
				end
			end
			
			-- 获取当前Tab中的收藏
			local sortedFavorites = GetSortedFavorites()
			
			-- 创建收藏置顶按钮
			for i, fav in ipairs(sortedFavorites) do
				if fav.tabName == name and fav.sectionName == "Section_" .. sectionName then
					local favoriteBtnModule = Instance.new("Frame")
					local favoriteBtn = Instance.new("TextButton")
					local favoriteBtnC = Instance.new("UICorner")
					local favoriteStar = Instance.new("ImageButton")
					
					favoriteBtnModule.Name = "FavoriteButton"
					favoriteBtnModule.Parent = Objs
					favoriteBtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					favoriteBtnModule.BackgroundTransparency = 1.000
					favoriteBtnModule.LayoutOrder = -1000 + i  -- 置顶
					favoriteBtnModule.Size = UDim2.new(0, 428, 0, 38)
					
					favoriteBtn.Name = "FavoriteBtn"
					favoriteBtn.Parent = favoriteBtnModule
					favoriteBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
					favoriteBtn.BackgroundTransparency = 0.2
					favoriteBtn.Size = UDim2.new(0, 428, 0, 38)
					favoriteBtn.AutoButtonColor = false
					favoriteBtn.Font = Enum.Font.GothamBold
					favoriteBtn.Text = "   ⭐ " .. fav.name
					favoriteBtn.TextColor3 = GetRainbowColor()
					favoriteBtn.TextSize = 16.000
					favoriteBtn.TextTransparency = 0
					favoriteBtn.TextXAlignment = Enum.TextXAlignment.Left
					
					favoriteBtnC.CornerRadius = UDim.new(0, 19)
					favoriteBtnC.Name = "BtnC"
					favoriteBtnC.Parent = favoriteBtn
					
					AnimateTextColor(favoriteBtn)
					
					-- 收藏星星
					favoriteStar.Name = "FavoriteStar"
					favoriteStar.Parent = favoriteBtn
					favoriteStar.BackgroundTransparency = 1
					favoriteStar.Position = UDim2.new(0.93, 0, 0.21, 0)
					favoriteStar.Size = UDim2.new(0, 24, 0, 24)
					favoriteStar.Image = "rbxassetid://6031302932"
					favoriteStar.ImageColor3 = GetRainbowColor()
					favoriteStar.ImageTransparency = 0
					
					-- 星星颜色动画
					spawn(function()
						while favoriteStar and favoriteStar.Parent do
							local nextIndex = currentColorIndex % #RainbowColors + 1
							local nextColor = RainbowColors[nextIndex]
							
							services.TweenService:Create(favoriteStar, TweenInfo.new(colorTransitionSpeed), {
								ImageColor3 = nextColor
							}):Play()
							task.wait(colorTransitionSpeed)
							
							if not favoriteStar or not favoriteStar.Parent then break end
						end
					end)
					
					-- 点击取消收藏
					favoriteStar.MouseButton1Click:Connect(function()
						library:RemoveFavorite(fav.name)
					end)
					
					-- 点击执行功能
					favoriteBtn.MouseButton1Click:Connect(function()
						Ripple(favoriteBtn)
						local callback = library:GetFavoriteCallback(fav.name)
						if callback then
							callback()
						end
					end)
				end
			end
		end
		
		-- 监听收藏更新
		library.favoriteUpdateSignal.Event:Connect(RefreshFavorites)
		
		-- 初始刷新
		spawn(RefreshFavorites)
		
		local section = {}
					function section.Button(section, text, callback)
				local callback = callback or function() end
				local btnText = text:gsub("^%s+", ""):gsub("%s+$", "")
				
				local BtnModule = Instance.new("Frame")
				local Btn = Instance.new("TextButton")
				local BtnC = Instance.new("UICorner")
				local FavoriteStar = Instance.new("ImageButton")
				
				BtnModule.Name = "BtnModule"
				BtnModule.Parent = Objs
				BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BtnModule.BackgroundTransparency = 1.000
				BtnModule.Position = UDim2.new(0, 0, 0, 0)
				BtnModule.Size = UDim2.new(0, 428, 0, 38)
				
				Btn.Name = "Btn"
				Btn.Parent = BtnModule
				Btn.BackgroundColor3 = zyColor
				Btn.BackgroundTransparency = zyColorTransparency
				Btn.Size = UDim2.new(0, 428, 0, 38)
				Btn.AutoButtonColor = false
				Btn.Font = Enum.Font.GothamBold
				Btn.Text = "   " .. text
				Btn.TextColor3 = GetRainbowColor()
				Btn.TextSize = 16.000
				Btn.TextTransparency = 0
				Btn.TextXAlignment = Enum.TextXAlignment.Left
				
				BtnC.CornerRadius = UDim.new(0, 19)
				BtnC.Name = "BtnC"
				BtnC.Parent = Btn
				
				AnimateTextColor(Btn)
				
				-- 收藏星星
				FavoriteStar.Name = "FavoriteStar"
				FavoriteStar.Parent = Btn
				FavoriteStar.BackgroundTransparency = 1
				FavoriteStar.Position = UDim2.new(0.93, 0, 0.21, 0)
				FavoriteStar.Size = UDim2.new(0, 24, 0, 24)
				FavoriteStar.Image = "rbxassetid://6031302932"
				
				-- 更新星星状态
				local function UpdateStar()
					if library:IsFavorite(btnText) then
						FavoriteStar.ImageColor3 = GetRainbowColor()
						FavoriteStar.ImageTransparency = 0
						-- 星星颜色动画
						spawn(function()
							while FavoriteStar and FavoriteStar.Parent and library:IsFavorite(btnText) do
								local nextIndex = currentColorIndex % #RainbowColors + 1
								local nextColor = RainbowColors[nextIndex]
								
								services.TweenService:Create(FavoriteStar, TweenInfo.new(colorTransitionSpeed), {
									ImageColor3 = nextColor
								}):Play()
								task.wait(colorTransitionSpeed)
								
								if not FavoriteStar or not FavoriteStar.Parent then break end
							end
						end)
					else
						FavoriteStar.ImageColor3 = Color3.fromRGB(255, 255, 255)
						FavoriteStar.ImageTransparency = 0.5
					end
				end
				
				-- 点击收藏/取消收藏
				FavoriteStar.MouseButton1Click:Connect(function()
					library:ToggleFavorite(btnText, callback, section.Name, name)
					UpdateStar()
				end)
				
				-- 初始更新
				UpdateStar()
				
				-- 监听收藏更新
				library.favoriteUpdateSignal.Event:Connect(UpdateStar)
				
				-- 点击按钮执行功能
				Btn.MouseButton1Click:Connect(function()
					spawn(function()
						Ripple(Btn)
					end)
					spawn(callback)
				end)
				
				return Btn
			end
			
			-- 功能搜索框
			function section.SearchBox(section, placeholder)
				local TextboxModule = Instance.new("Frame")
				local TextboxBack = Instance.new("TextButton")
				local TextboxBackC = Instance.new("UICorner")
				local BoxBG = Instance.new("TextButton")
				local BoxBGC = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")
				local SearchButton = Instance.new("TextButton")
				local SearchButtonC = Instance.new("UICorner")
				
				TextboxModule.Name = "SearchBoxModule"
				TextboxModule.Parent = Objs
				TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextboxModule.BackgroundTransparency = 1.000
				TextboxModule.Size = UDim2.new(0, 428, 0, 38)
				
				TextboxBack.Name = "SearchBack"
				TextboxBack.Parent = TextboxModule
				TextboxBack.BackgroundColor3 = zyColor
				TextboxBack.BackgroundTransparency = zyColorTransparency
				TextboxBack.Size = UDim2.new(0, 428, 0, 38)
				TextboxBack.AutoButtonColor = false
				TextboxBack.Font = Enum.Font.GothamBold
				TextboxBack.Text = "   脚本搜索"
				TextboxBack.TextColor3 = GetRainbowColor()
				TextboxBack.TextSize = 16.000
				TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
				
				TextboxBackC.CornerRadius = UDim.new(0, 19)
				TextboxBackC.Name = "SearchBackC"
				TextboxBackC.Parent = TextboxBack
				
				SearchButton.Name = "SearchBtn"
				SearchButton.Parent = TextboxBack
				SearchButton.BackgroundColor3 = GetRainbowColor()
				SearchButton.BackgroundTransparency = 0.3
				SearchButton.Position = UDim2.new(0.85, 0, 0.29, 0)
				SearchButton.Size = UDim2.new(0, 50, 0, 22)
				SearchButton.Font = Enum.Font.GothamBold
				SearchButton.Text = "搜索"
				SearchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				SearchButton.TextSize = 12
				
				SearchButtonC.CornerRadius = UDim.new(0, 11)
				SearchButtonC.Name = "SearchBtnC"
				SearchButtonC.Parent = SearchButton
				
				BoxBG.Name = "SearchBoxBG"
				BoxBG.Parent = TextboxBack
				BoxBG.BackgroundColor3 = Background
				BoxBG.BackgroundTransparency = BackgroundTransparency
				BoxBG.Position = UDim2.new(0.63, 0, 0.29, 0)
				BoxBG.Size = UDim2.new(0, 100, 0, 22)
				BoxBG.Font = Enum.Font.Gotham
				BoxBG.Text = ""
				BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
				BoxBG.TextSize = 14.000
				
				BoxBGC.CornerRadius = UDim.new(0, 11)
				BoxBGC.Name = "SearchBoxBGC"
				BoxBGC.Parent = BoxBG
				
				TextBox.Parent = BoxBG
				TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.BackgroundTransparency = 1.000
				TextBox.Size = UDim2.new(1, 0, 1, 0)
				TextBox.Font = Enum.Font.GothamBold
				TextBox.PlaceholderText = placeholder or "输入功能名"
				TextBox.PlaceholderColor3 = PlaceholderColor
				TextBox.Text = ""
				TextBox.TextColor3 = GetRainbowColor()
				TextBox.TextSize = 14.000
				
				AnimateTextColor(TextboxBack)
				AnimateTextColor(TextBox)
				
				-- 搜索功能
				local function SearchAndPin(searchText)
					if searchText == "" then return end
					
					local found = false
					local searchLower = searchText:lower()
					
					-- 遍历当前section的所有按钮
					for _, module in pairs(Objs:GetChildren()) do
						if module:IsA("Frame") and module.Name == "BtnModule" then
							local btn = module:FindFirstChild("Btn")
							if btn then
								local btnText = btn.Text:gsub("^%s+", ""):gsub("%s+$", "")
								-- 排除搜索框本身
								if btnText:lower():find(searchLower, 1, true) and module ~= TextboxModule then
									-- 置顶
									module.LayoutOrder = -500
									found = true
									
									-- 高亮
									local originalColor = btn.BackgroundColor3
									local originalTransparency = btn.BackgroundTransparency
									
									services.TweenService:Create(btn, TweenInfo.new(0.3), {
										BackgroundColor3 = GetRainbowColor(),
										BackgroundTransparency = 0.1
									}):Play()
									
									task.wait(3)
									
									services.TweenService:Create(btn, TweenInfo.new(0.3), {
										BackgroundColor3 = originalColor,
										BackgroundTransparency = originalTransparency
									}):Play()
									
									-- 展开section
									Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
									Section.SectionOpened.ImageTransparency = 0
									Section.SectionOpen.ImageTransparency = 1
								end
							end
						end
					end
					
					if not found then
						TextBox.Text = "未找到"
						TextBox.TextColor3 = Color3.fromRGB(255, 100, 100)
						task.wait(1)
						TextBox.Text = ""
						TextBox.TextColor3 = GetRainbowColor()
					end
				end
				
				SearchButton.MouseButton1Click:Connect(function()
					SearchAndPin(TextBox.Text)
				end)
				
				TextBox.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						SearchAndPin(TextBox.Text)
					end
				end)
				
				return TextBox
			end
			
			-- 其他控件函数（Label、Toggle等）保持不变...
			function section:Label(text)
				-- ... [原有Label代码]
			end
			
			function section.Toggle(section, text, flag, enabled, callback)
				-- ... [原有Toggle代码]
			end
			
			function section.Keybind(section, text, default, callback)
				-- ... [原有Keybind代码]
			end
			
			function section.Textbox(section, text, flag, default, callback)
				-- ... [原有Textbox代码]
			end
			
			function section.Slider(section, text, flag, default, min, max, precise, callback)
				-- ... [原有Slider代码]
			end
			
			function section.Dropdown(section, text, flag, options, callback)
				-- ... [原有Dropdown代码]
			end
			
			return section
		end
		return tab
	end
	
	return window
end
return library