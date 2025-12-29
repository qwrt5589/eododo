local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local OrionLib = {
	Elements = {},
	ThemeObjects = {},
	Connections = {},
	Flags = {},
	Themes = {
		Default = {
			Main = Color3.fromRGB(255, 244, 242),
			Second = Color3.fromRGB(255, 80, 160),
			Stroke = Color3.fromRGB(255, 80, 160),
			Divider = Color3.fromRGB(255, 150, 180),
			Text = Color3.fromRGB(0, 0, 0),
			TextDark = Color3.fromRGB(60, 60, 60),
			Button = Color3.fromRGB(255, 200, 220),
			Accent = Color3.fromRGB(255, 80, 160),
			Glow = Color3.fromRGB(255, 150, 200),
			TabText = Color3.fromRGB(255, 255, 255),
			TabSelected = Color3.fromRGB(255, 244, 242)
		}
	},
	SelectedTheme = "Default",
	Folder = nil,
	SaveCfg = false,
	UIVisible = true
}
local Icons = {}
local Success, Response = pcall(function()
	Icons = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/evoincorp/lucideblox/master/src/modules/util/icons.json")).icons
end)
if not Success then
	warn("\nOrion Library - Failed to load Feather Icons. Error code: " .. Response .. "\n")
end	
local function GetIcon(IconName)
	if Icons[IconName] ~= nil then
		return Icons[IconName]
	else
		return nil
	end
end   
local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
if syn then
	syn.protect_gui(Orion)
	Orion.Parent = game.CoreGui
else
	Orion.Parent = gethui() or game.CoreGui
end
if gethui then
	for _, Interface in ipairs(gethui():GetChildren()) do
		if Interface.Name == Orion.Name and Interface ~= Orion then
			Interface:Destroy()
		end
	end
else
	for _, Interface in ipairs(game.CoreGui:GetChildren()) do
		if Interface.Name == Orion.Name and Interface ~= Orion then
			Interface:Destroy()
		end
	end
end
function OrionLib:IsRunning()
	if gethui then
		return Orion.Parent == gethui()
	else
		return Orion.Parent == game:GetService("CoreGui")
	end
end
local function AddConnection(Signal, Function)
	if (not OrionLib:IsRunning()) then
		return
	end
	local SignalConnect = Signal:Connect(Function)
	table.insert(OrionLib.Connections, SignalConnect)
	return SignalConnect
end
task.spawn(function()
	while (OrionLib:IsRunning()) do
		wait()
	end
	for _, Connection in next, OrionLib.Connections do
		Connection:Disconnect()
	end
end)
local function MakeDraggable(DragPoint, Main)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false
		AddConnection(DragPoint.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position
				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		AddConnection(DragPoint.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement then
				DragInput = Input
			end
		end)
		AddConnection(UserInputService.InputChanged, function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				Main.Position  = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
			end
		end)
	end)
end    
local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in next, Properties or {} do
		Object[i] = v
	end
	for i, v in next, Children or {} do
		v.Parent = Object
	end
	return Object
end
local function CreateElement(ElementName, ElementFunction)
	OrionLib.Elements[ElementName] = function(...)
		return ElementFunction(...)
	end
end
local function MakeElement(ElementName, ...)
	local NewElement = OrionLib.Elements[ElementName](...)
	return NewElement
end
local function SetProps(Element, Props)
	table.foreach(Props, function(Property, Value)
		Element[Property] = Value
	end)
	return Element
end
local function SetChildren(Element, Children)
	table.foreach(Children, function(_, Child)
		Child.Parent = Element
	end)
	return Element
end
local function Round(Number, Factor)
	local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
	if Result < 0 then Result = Result + Factor end
	return Result
end
local function ReturnProperty(Object)
	if Object:IsA("Frame") or Object:IsA("TextButton") then
		return "BackgroundColor3"
	end 
	if Object:IsA("ScrollingFrame") then
		return "ScrollBarImageColor3"
	end 
	if Object:IsA("UIStroke") then
		return "Color"
	end 
	if Object:IsA("TextLabel") or Object:IsA("TextBox") then
		return "TextColor3"
	end   
	if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
		return "ImageColor3"
	end   
end
local function AddThemeObject(Object, Type)
	if not OrionLib.ThemeObjects[Type] then
		OrionLib.ThemeObjects[Type] = {}
	end    
	table.insert(OrionLib.ThemeObjects[Type], Object)
	Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Type]
	return Object
end    
local function SetTheme()
	for Name, Type in pairs(OrionLib.ThemeObjects) do
		for _, Object in pairs(Type) do
			Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Name]
		end    
	end    
end
local function PackColor(Color)
	return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end    
local function UnpackColor(Color)
	return Color3.fromRGB(Color.R, Color.G, Color.B)
end
local function LoadCfg(Config)
	local Data = HttpService:JSONDecode(Config)
	table.foreach(Data, function(a,b)
		if OrionLib.Flags[a] then
			spawn(function() 
				if OrionLib.Flags[a].Type == "Colorpicker" then
					OrionLib.Flags[a]:Set(UnpackColor(b))
				else
					OrionLib.Flags[a]:Set(b)
				end    
			end)
		else
			warn("Orion Library Config Loader - Could not find ", a ,b)
		end
	end)
end
local function SaveCfg(Name)
	local Data = {}
	for i,v in pairs(OrionLib.Flags) do
		if v.Save then
			if v.Type == "Colorpicker" then
				Data[i] = PackColor(v.Value)
			else
				Data[i] = v.Value
			end
		end	
	end
	writefile(OrionLib.Folder .. "/" .. Name .. ".txt", tostring(HttpService:JSONEncode(Data)))
end
local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3}
local BlacklistedKeys = {Enum.KeyCode.Unknown, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Up, Enum.KeyCode.Left, Enum.KeyCode.Down, Enum.KeyCode.Right, Enum.KeyCode.Slash, Enum.KeyCode.Tab, Enum.KeyCode.Backspace, Enum.KeyCode.Escape}
local function CheckKey(Table, Key)
	for _, v in next, Table do
		if v == Key then
			return true
		end
	end
end
local function CapsuleCorner(Height)
	return Create("UICorner", {
		CornerRadius = UDim.new(0.5, Height/2)
	})
end
CreateElement("Corner", function(Scale, Offset)
	local Corner = Create("UICorner", {
		CornerRadius = UDim.new(Scale or 0, Offset or 8)
	})
	return Corner
end)
CreateElement("CapsuleCorner", function(Height)
	return CapsuleCorner(Height)
end)
CreateElement("Stroke", function(Color, Thickness)
	local Stroke = Create("UIStroke", {
		Color = Color or OrionLib.Themes[OrionLib.SelectedTheme].Stroke,
		Thickness = Thickness or 1,
		Transparency = 0
	})
	return Stroke
end)
CreateElement("List", function(Scale, Offset)
	local List = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(Scale or 0, Offset or 0)
	})
	return List
end)
CreateElement("Padding", function(Bottom, Left, Right, Top)
	local Padding = Create("UIPadding", {
		PaddingBottom = UDim.new(0, Bottom or 6),
		PaddingLeft = UDim.new(0, Left or 6),
		PaddingRight = UDim.new(0, Right or 6),
		PaddingTop = UDim.new(0, Top or 6)
	})
	return Padding
end)
CreateElement("TFrame", function()
	local TFrame = Create("Frame", {
		BackgroundTransparency = 1
	})
	return TFrame
end)
CreateElement("Frame", function(Color, Transparency)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or OrionLib.Themes[OrionLib.SelectedTheme].Main,
		BackgroundTransparency = Transparency or 0,
		BorderSizePixel = 0
	})
	return Frame
end)
CreateElement("RoundFrame", function(Color, Scale, Offset, Transparency)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or OrionLib.Themes[OrionLib.SelectedTheme].Main,
		BackgroundTransparency = Transparency or 0,
		BorderSizePixel = 0
	}, {
		Create("UICorner", {
			CornerRadius = UDim.new(Scale, Offset)
		})
	})
	return Frame
end)
CreateElement("CapsuleFrame", function(Color, Height, Transparency)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or OrionLib.Themes[OrionLib.SelectedTheme].Main,
		BackgroundTransparency = Transparency or 0,
		BorderSizePixel = 0
	})
	Height = Height or 35
	CapsuleCorner(Height).Parent = Frame
	return Frame
end)
CreateElement("Button", function()
	local Button = Create("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0
	})
	return Button
end)
CreateElement("ScrollFrame", function(Color, Width)
	local ScrollFrame = Create("ScrollingFrame", {
		BackgroundTransparency = 1,
		MidImage = "rbxassetid://7445543667",
		BottomImage = "rbxassetid://7445543667",
		TopImage = "rbxassetid://7445543667",
		ScrollBarImageColor3 = Color or OrionLib.Themes[OrionLib.SelectedTheme].Stroke,
		BorderSizePixel = 0,
		ScrollBarThickness = Width or 4,
		CanvasSize = UDim2.new(0, 0, 0, 0)
	})
	return ScrollFrame
end)
CreateElement("Image", function(ImageID)
	local ImageNew = Create("ImageLabel", {
		Image = ImageID,
		BackgroundTransparency = 1
	})
	if GetIcon(ImageID) ~= nil then
		ImageNew.Image = GetIcon(ImageID)
	end	
	return ImageNew
end)
CreateElement("ImageButton", function(ImageID)
	local Image = Create("ImageButton", {
		Image = ImageID,
		BackgroundTransparency = 1
	})
	return Image
end)
CreateElement("Label", function(Text, TextSize, Transparency, Color)
	local Label = Create("TextLabel", {
		Text = Text or "",
		TextColor3 = Color or OrionLib.Themes[OrionLib.SelectedTheme].Text,
		TextTransparency = Transparency or 0,
		TextSize = TextSize or 15,
		Font = Enum.Font.Gotham,
		RichText = true,
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	return Label
end)
local toggleUIButton = Create("ImageButton", {
	Name = "ToggleUI",
	Size = UDim2.new(0, 40, 0, 40),
	Position = UDim2.new(1, -50, 0, 10),
	AnchorPoint = Vector2.new(1, 0),
	BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second,
	BackgroundTransparency = 0,
	Image = "rbxassetid://138901519642245",
	ImageColor3 = Color3.fromRGB(255, 255, 255),
	Parent = Orion,
	ZIndex = 1000,
	Draggable = true
})
CapsuleCorner(40).Parent = toggleUIButton
Create("UIStroke", {
	Color = Color3.fromRGB(255, 255, 255),
	Thickness = 1,
	Parent = toggleUIButton
})
AddConnection(toggleUIButton.MouseEnter, function()
	TweenService:Create(toggleUIButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
		BackgroundColor3 = Color3.fromRGB(255, 100, 170)
	}):Play()
end)
AddConnection(toggleUIButton.MouseLeave, function()
	TweenService:Create(toggleUIButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
		BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second
	}):Play()
end)
local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), {
	SetProps(MakeElement("List"), {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		Padding = UDim.new(0, 5)
	})
}), {
	Position = UDim2.new(1, -25, 1, -25),
	Size = UDim2.new(0, 300, 1, -25),
	AnchorPoint = Vector2.new(1, 1),
	Parent = Orion
})
function OrionLib:MakeNotification(NotificationConfig)
	spawn(function()
		NotificationConfig.Name = NotificationConfig.Name or "Notification"
		NotificationConfig.Content = NotificationConfig.Content or "Test"
		NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://4384403532"
		NotificationConfig.Time = NotificationConfig.Time or 15
		local NotificationParent = SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = NotificationHolder
		})
		local NotificationFrame = SetChildren(SetProps(MakeElement("CapsuleFrame", OrionLib.Themes[OrionLib.SelectedTheme].Main, 35), {
			Parent = NotificationParent, 
			Size = UDim2.new(1, 0, 0, 0),
			Position = UDim2.new(1, -55, 0, 0),
			BackgroundTransparency = 0,
			AutomaticSize = Enum.AutomaticSize.Y
		}), {
			MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1),
			MakeElement("Padding", 12, 12, 12, 12),
			SetProps(MakeElement("Image", NotificationConfig.Image), {
				Size = UDim2.new(0, 20, 0, 20),
				ImageColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Stroke,
				Name = "Icon"
			}),
			SetProps(MakeElement("Label", NotificationConfig.Name, 15, 0, OrionLib.Themes[OrionLib.SelectedTheme].Stroke), {
				Size = UDim2.new(1, -30, 0, 20),
				Position = UDim2.new(0, 30, 0, 0),
				Font = Enum.Font.GothamBold,
				Name = "Title"
			}),
			SetProps(MakeElement("Label", NotificationConfig.Content, 14, 0, OrionLib.Themes[OrionLib.SelectedTheme].Text), {
				Size = UDim2.new(1, 0, 0, 0),
				Position = UDim2.new(0, 0, 0, 25),
				Font = Enum.Font.GothamSemibold,
				Name = "Content",
				AutomaticSize = Enum.AutomaticSize.Y,
				TextWrapped = true
			})
		})
		TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		wait(NotificationConfig.Time - 0.88)
		TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
		TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.6}):Play()
		wait(0.3)
		TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0.9}):Play()
		TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
		TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
		wait(0.05)
		NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0),'In','Quint',0.8,true)
		wait(1.35)
		NotificationFrame:Destroy()
	end)
end    
function OrionLib:Init()
	if OrionLib.SaveCfg then	
		pcall(function()
			if isfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt") then
				LoadCfg(readfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt"))
				OrionLib:MakeNotification({
					Name = "Configuration",
					Content = "Auto-loaded configuration for the game " .. game.GameId .. ".",
					Time = 5
				})
			end
		end)		
	end	
end	
function OrionLib:MakeWindow(WindowConfig)
	local FirstTab = true
	local Minimized = false
	local Loaded = false
	local UIHidden = false
	local MainWindowInstance = nil
	WindowConfig = WindowConfig or {}
	WindowConfig.Name = WindowConfig.Name or "Orion Library"
	WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
	WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
	WindowConfig.HidePremium = WindowConfig.HidePremium or false
	if WindowConfig.IntroEnabled == nil then
		WindowConfig.IntroEnabled = true
	end
	WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library"
	WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
	WindowConfig.ShowIcon = WindowConfig.ShowIcon or false
	WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://8834748103"
	WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://8834748103"
	OrionLib.Folder = WindowConfig.ConfigFolder
	OrionLib.SaveCfg = WindowConfig.SaveConfig
	if WindowConfig.SaveConfig then
		if not isfolder(WindowConfig.ConfigFolder) then
			makefolder(WindowConfig.ConfigFolder)
		end	
	end
	local TabHolder = SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {
		Size = UDim2.new(1, 0, 1, 0),
		ScrollBarThickness = 2,
		BackgroundTransparency = 1
	}), {
		MakeElement("List"),
		MakeElement("Padding", 8, 0, 0, 8)
	})
	AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16)
	end)
	local DragPoint = SetProps(MakeElement("TFrame"), {
		Size = UDim2.new(1, 0, 0, 50)
	})
	local WindowStuff = SetChildren(SetProps(MakeElement("RoundFrame", OrionLib.Themes[OrionLib.SelectedTheme].Second, 0, 8), {
		Size = UDim2.new(0, 120, 1, -50),
		Position = UDim2.new(0, 0, 0, 50),
		BackgroundTransparency = 0,
		ClipsDescendants = true
	}), {
		Create("Frame", {
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(1, -1, 0, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.7
		}),
		
		TabHolder,
	})
	local WindowLogo = SetProps(MakeElement("Image", "rbxassetid://100576379445068"), {
		Size = UDim2.new(0, 120, 0, 30),
		Position = UDim2.new(0, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Name = "WindowLogo"
	})
	local WindowTopBarLine = Create("Frame", {
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, -2),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	})
	local MainWindow = SetChildren(SetProps(MakeElement("RoundFrame", OrionLib.Themes[OrionLib.SelectedTheme].Main, 0, 10), {
		Parent = Orion,
		Position = UDim2.new(0.5, -260, 0.5, -155),
		Size = UDim2.new(0, 520, 0, 310),
		ClipsDescendants = true,
		Draggable = true,
		BackgroundTransparency = 0,
		Active = true
	}), {
		SetChildren(SetProps(MakeElement("RoundFrame", OrionLib.Themes[OrionLib.SelectedTheme].Second, 0, 10), {
			Size = UDim2.new(1, 0, 0, 50),
			Name = "TopBar"
		}), {
			WindowLogo,
			WindowTopBarLine
		}),
		
		DragPoint,
		WindowStuff,
		
		MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1)
	})

	MainWindowInstance = MainWindow
	MakeDraggable(DragPoint, MainWindow)
	local UserInfoFrame = SetChildren(SetProps(MakeElement("TFrame"), {
		Size = UDim2.new(0, 150, 0, 40),
		Position = UDim2.new(1, -160, 0, 5),
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		Parent = MainWindow.TopBar
	}), {
		SetChildren(SetProps(MakeElement("Frame", Color3.fromRGB(255, 255, 255)), {
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.new(0, 32, 0, 32),
			Position = UDim2.new(1, 0, 0.5, 0),
			BackgroundTransparency = 0
		}), {
			MakeElement("Corner", 1, 0),
			SetProps(MakeElement("Image", "https://www.roblox.com/headshot-thumbnail/image?userId=".. LocalPlayer.UserId .."&width=420&height=420&format=png"), {
				Size = UDim2.new(1, -2, 1, -2),
				Position = UDim2.new(0, 1, 0, 1)
			}),
			MakeElement("Stroke", Color3.fromRGB(255, 255, 255), 1)
		}),
		
		Create("TextLabel", {
			Size = UDim2.new(1, -40, 0, 16),
			Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Font = Enum.Font.GothamBold,
			Text = LocalPlayer.DisplayName,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClipsDescendants = true
		})
	})
	AddConnection(toggleUIButton.MouseButton1Click, function()
		OrionLib.UIVisible = not OrionLib.UIVisible
		MainWindow.Visible = OrionLib.UIVisible
		
		if MainWindow.Visible then
			TweenService:Create(toggleUIButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second,
				ImageColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()
		else
			TweenService:Create(toggleUIButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				BackgroundColor3 = Color3.fromRGB(220, 70, 150),
				ImageColor3 = Color3.fromRGB(240, 240, 240)
			}):Play()
		end
	end)
	AddConnection(UserInputService.InputBegan, function(Input)
		if Input.KeyCode == Enum.KeyCode.RightShift and UIHidden then
			MainWindow.Visible = true
		end
	end)
	local function LoadSequence()
		MainWindow.Visible = false
		local LoadSequenceLogo = SetProps(MakeElement("Image", WindowConfig.IntroIcon), {
			Parent = Orion,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.4, 0),
			Size = UDim2.new(0, 28, 0, 28),
			ImageColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Stroke,
			ImageTransparency = 1
		})
		local LoadSequenceText = SetProps(MakeElement("Label", WindowConfig.IntroText, 14, 1, OrionLib.Themes[OrionLib.SelectedTheme].Stroke), {
			Parent = Orion,
			Size = UDim2.new(1, 0, 1, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 19, 0.5, 0),
			TextXAlignment = Enum.TextXAlignment.Center,
			Font = Enum.Font.GothamBold,
			TextTransparency = 1
		})
		TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
		wait(0.8)
		TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -(LoadSequenceText.TextBounds.X/2), 0.5, 0)}):Play()
		wait(0.3)
		TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
		wait(2)
		TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
		MainWindow.Visible = true
		LoadSequenceLogo:Destroy()
		LoadSequenceText:Destroy()
	end 
	if WindowConfig.IntroEnabled then
		LoadSequence()
	end	
	local TabFunction = {}
	function TabFunction:MakeTab(TabConfig)
		TabConfig = TabConfig or {}
		TabConfig.Name = TabConfig.Name or "Tab"
		TabConfig.Icon = TabConfig.Icon or ""
		TabConfig.PremiumOnly = TabConfig.PremiumOnly or false
		local TabButtonContainer = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255, 0), 0, 6), {
			Size = UDim2.new(1, -8, 0, 30),
			Position = UDim2.new(0, 4, 0, 0),
			BackgroundTransparency = 1,
			BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].TabSelected,
			Name = "TabBackground"
		}), {
			MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1)
		})
		TabButtonContainer.Parent = TabHolder
		
		local TabFrame = SetChildren(SetProps(MakeElement("Button"), {
			Size = UDim2.new(1, 0, 1, 0),
			Parent = TabButtonContainer,
			BackgroundTransparency = 1
		}), {
			SetProps(MakeElement("Image", TabConfig.Icon), {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 16, 0, 16),
				Position = UDim2.new(0, 8, 0.5, 0),
				ImageTransparency = 0.4,
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Name = "Ico"
			}),
			Create("TextLabel", {
				Size = UDim2.new(1, -30, 1, 0),
				Position = UDim2.new(0, 30, 0, 0),
				Font = Enum.Font.GothamSemibold,
				Text = TabConfig.Name,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextTransparency = 0.4,
				TextSize = 13,
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Name = "Title"
			})
		})

		if GetIcon(TabConfig.Icon) ~= nil then
			TabFrame.Ico.Image = GetIcon(TabConfig.Icon)
		end	
		
		local Container = SetChildren(SetProps(MakeElement("ScrollFrame", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 5), {
			Size = UDim2.new(1, -120, 1, -50),
			Position = UDim2.new(0, 120, 0, 50),
			Parent = MainWindow,
			Visible = false,
			Name = "ItemContainer",
			BackgroundTransparency = 1,
			BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Main
		}), {
			MakeElement("List", 0, 6),
			MakeElement("Padding", 12, 10, 10, 12)
		})
		AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + 30)
		end)
		if FirstTab then
			FirstTab = false
			TabFrame.Ico.ImageTransparency = 0
			TabFrame.Title.TextTransparency = 0
			TabFrame.Title.Font = Enum.Font.GothamBlack
			Container.Visible = true
			TabButtonContainer.BackgroundTransparency = 0
		else
			TabButtonContainer.BackgroundTransparency = 1
			TabButtonContainer.UIStroke.Transparency = 0.8
		end    
		AddConnection(TabFrame.MouseButton1Click, function()
			for _, TabBG in next, TabHolder:GetChildren() do
				if TabBG:IsA("Frame") and TabBG.Name == "TabBackground" then
					local tabButton = TabBG:FindFirstChildWhichIsA("TextButton")
					if tabButton then
						local title = tabButton:FindFirstChild("Title")
						local icon = tabButton:FindFirstChild("Ico")
						if title then
							title.Font = Enum.Font.GothamSemibold
							TweenService:Create(title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.4}):Play()
						end
						if icon then
							TweenService:Create(icon, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.4}):Play()
						end
					end
					TweenService:Create(TabBG, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
						BackgroundTransparency = 1
					}):Play()
					TweenService:Create(TabBG.UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
						Transparency = 0.8
					}):Play()
				end
			end
			for _, ItemContainer in next, MainWindow:GetChildren() do
				if ItemContainer.Name == "ItemContainer" then
					ItemContainer.Visible = false
				end    
			end  
			TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			TabFrame.Title.Font = Enum.Font.GothamBlack
			
			TweenService:Create(TabButtonContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				BackgroundTransparency = 0
			}):Play()
			TweenService:Create(TabButtonContainer.UIStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Transparency = 0
			}):Play()
			
			Container.Visible = true   
		end)
		local function GetElements(ItemParent)
			local ElementFunction = {}
			function ElementFunction:AddLabel(Text)
				local LabelFrame = SetChildren(SetProps(MakeElement("CapsuleFrame", Color3.fromRGB(250, 240, 238), 32), {
					Size = UDim2.new(1, 0, 0, 32),
					Parent = ItemParent,
					BackgroundTransparency = 0
				}), {
					Create("TextLabel", {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Text = Text,
						TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text,
						TextSize = 15,
						BackgroundTransparency = 1,
						Name = "Content"
					}),
					MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1)
				})
				local LabelFunction = {}
				function LabelFunction:Set(ToChange)
					LabelFrame.Content.Text = ToChange
				end
				return LabelFunction
			end
			function ElementFunction:AddParagraph(Text, Content)
				Text = Text or "Text"
				Content = Content or "Content"
				local ParagraphFrame = SetChildren(SetProps(MakeElement("CapsuleFrame", Color3.fromRGB(250, 240, 238), 30), {
					Size = UDim2.new(1, 0, 0, 0),
					Parent = ItemParent,
					BackgroundTransparency = 0,
					AutomaticSize = Enum.AutomaticSize.Y
				}), {
					MakeElement("Padding", 12, 12, 12, 12),
					Create("TextLabel", {
						Size = UDim2.new(1, 0, 0, 14),
						Position = UDim2.new(0, 0, 0, 0),
						Font = Enum.Font.GothamBold,
						Text = Text,
						TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text,
						TextSize = 15,
						BackgroundTransparency = 1,
						Name = "Title"
					}),
					Create("TextLabel", {
						Size = UDim2.new(1, 0, 0, 0),
						Position = UDim2.new(0, 0, 0, 20),
						Font = Enum.Font.GothamSemibold,
						Text = "",
						TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text,
						TextSize = 13,
						BackgroundTransparency = 1,
						Name = "Content",
						TextWrapped = true,
						AutomaticSize = Enum.AutomaticSize.Y
					}),
					MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1)
				})
				AddConnection(ParagraphFrame.Content:GetPropertyChangedSignal("Text"), function()
					ParagraphFrame.Content.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y)
					ParagraphFrame.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y + 35)
				end)
				ParagraphFrame.Content.Text = Content
				local ParagraphFunction = {}
				function ParagraphFunction:Set(ToChange)
					ParagraphFrame.Content.Text = ToChange
				end
				return ParagraphFunction
			end    
			function ElementFunction:AddButton(ButtonConfig)
				ButtonConfig = ButtonConfig or {}
				ButtonConfig.Name = ButtonConfig.Name or "Button"
				ButtonConfig.Callback = ButtonConfig.Callback or function() end
				ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587"
				local Button = {}
				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})
				local ButtonFrame = SetChildren(SetProps(MakeElement("CapsuleFrame", OrionLib.Themes[OrionLib.SelectedTheme].Button, 35), {
					Size = UDim2.new(1, 0, 0, 35),
					Parent = ItemParent,
					BackgroundTransparency = 0,
					BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Button
				}), {
					Create("TextLabel", {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Text = ButtonConfig.Name,
						TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text,
						TextSize = 15,
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						Name = "Content"
					}),
					
					SetProps(MakeElement("Image", ButtonConfig.Icon), {
						Size = UDim2.new(0, 20, 0, 20),
						Position = UDim2.new(1, -30, 0, 8),
						ImageColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Stroke
					}),
					
					MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1),
					Click
				})
				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
						BackgroundColor3 = Color3.fromRGB(255, 210, 230)
					}):Play()
				end)
				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
						BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Button
					}):Play()
				end)
				AddConnection(Click.MouseButton1Click, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
						BackgroundColor3 = Color3.fromRGB(255, 190, 210)
					}):Play()
					wait(0.1)
					TweenService:Create(ButtonFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
						BackgroundColor3 = Color3.fromRGB(255, 210, 230)
					}):Play()
					
					spawn(function()
						ButtonConfig.Callback()
					end)
				end)
				function Button:Set(ButtonText)
					ButtonFrame.Content.Text = ButtonText
				end	
				return Button
			end    
			function ElementFunction:AddToggle(ToggleConfig)
				ToggleConfig = ToggleConfig or {}
				ToggleConfig.Name = ToggleConfig.Name or "Toggle"
				ToggleConfig.Default = ToggleConfig.Default or false
				ToggleConfig.Callback = ToggleConfig.Callback or function() end
				ToggleConfig.Flag = ToggleConfig.Flag or nil
				ToggleConfig.Save = ToggleConfig.Save or false
				
				local Toggle = {Value = ToggleConfig.Default, Save = ToggleConfig.Save, Type = "Toggle"}
				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})
				local ToggleFrame = SetChildren(SetProps(MakeElement("CapsuleFrame", Color3.fromRGB(250, 240, 238), 38), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent,
					BackgroundTransparency = 0
				}), {
					Create("TextLabel", {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Text = ToggleConfig.Name,
						TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text,
						TextSize = 15,
						BackgroundTransparency = 1,
						Name = "Content"
					}),
					MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1),
					Click
				})
				local ToggleSwitch = SetChildren(SetProps(MakeElement("CapsuleFrame", OrionLib.Themes[OrionLib.SelectedTheme].Button, 24), {
					Size = UDim2.new(0, 50, 0, 24),
					Position = UDim2.new(1, -60, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 0
				}), {
					SetChildren(SetProps(MakeElement("CapsuleFrame", Color3.fromRGB(255, 255, 255), 20), {
						Size = UDim2.new(0, 20, 0, 20),
						Position = UDim2.new(0, 3, 0.5, 0),
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 0
					}), {
						MakeElement("Stroke", Color3.fromRGB(220, 220, 220), 1)
					})
				})
				ToggleSwitch.Parent = ToggleFrame
				function Toggle:Set(state)
					if state == nil then
						state = not self.Value
					end
					if self.Value == state then
						return
					end
					
					self.Value = state
					local circle = ToggleSwitch:FindFirstChildWhichIsA("Frame")
					if circle then
						TweenService:Create(circle, TweenInfo.new(0.2), {
							Position = UDim2.new(0, state and 27 or 3, 0.5, 0),
							BackgroundColor3 = state and OrionLib.Themes[OrionLib.SelectedTheme].Stroke or Color3.fromRGB(255, 255, 255)
						}):Play()
					end
					
					TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
						BackgroundColor3 = state and OrionLib.Themes[OrionLib.SelectedTheme].Stroke or OrionLib.Themes[OrionLib.SelectedTheme].Button
					}):Play()
					
					ToggleConfig.Callback(state)
					
					if ToggleConfig.Save then
						SaveCfg(game.GameId)
					end
				end
				Toggle:Set(Toggle.Value)
				AddConnection(Click.MouseButton1Click, function()
					Toggle:Set(not Toggle.Value)
					if ToggleConfig.Flag then
						OrionLib.Flags[ToggleConfig.Flag] = Toggle
					end
				end)
				if ToggleConfig.Flag then
					OrionLib.Flags[ToggleConfig.Flag] = Toggle
				end	
				return Toggle
			end  
			function ElementFunction:AddSlider(SliderConfig)
				SliderConfig = SliderConfig or {}
				SliderConfig.Name = SliderConfig.Name or "Slider"
				SliderConfig.Min = SliderConfig.Min or 0
				SliderConfig.Max = SliderConfig.Max or 100
				SliderConfig.Increment = SliderConfig.Increment or 1
				SliderConfig.Default = SliderConfig.Default or 50
				SliderConfig.Callback = SliderConfig.Callback or function() end
				SliderConfig.Flag = SliderConfig.Flag or nil
				SliderConfig.Save = SliderConfig.Save or false
				
				local Slider = {Value = SliderConfig.Default, Save = SliderConfig.Save, Type = "Slider"}
				local Dragging = false
				local SliderFrame = SetChildren(SetProps(MakeElement("CapsuleFrame", Color3.fromRGB(250, 240, 238), 65), {
					Size = UDim2.new(1, 0, 0, 65),
					Parent = ItemParent,
					BackgroundTransparency = 0
				}), {
					Create("TextLabel", {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 10),
						Font = Enum.Font.GothamBold,
						Text = SliderConfig.Name,
						TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text,
						TextSize = 15,
						BackgroundTransparency = 1,
						Name = "Content"
					}),
					MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1)
				})
				local SliderBar = SetChildren(SetProps(MakeElement("CapsuleFrame", Color3.fromRGB(230, 220, 218), 12), {
					Size = UDim2.new(0.8, 0, 0, 12),
					Position = UDim2.new(0.1, 0, 0, 40),
					BackgroundTransparency = 0
				}), {
					MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1)
				})
				SliderBar.Parent = SliderFrame
				local SliderFill = SetChildren(SetProps(MakeElement("CapsuleFrame", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 12), {
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 0,
					ClipsDescendants = true
				}), {})
				SliderFill.Parent = SliderBar
				local ValueLabel = SetChildren(SetProps(MakeElement("CapsuleFrame", OrionLib.Themes[OrionLib.SelectedTheme].Button, 28), {
					Size = UDim2.new(0, 44, 0, 28),
					Position = UDim2.new(0.85, 0, 0, 30),
					BackgroundTransparency = 0
				}), {
					Create("TextLabel", {
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.GothamBold,
						Text = tostring(SliderConfig.Default),
						TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text,
						TextSize = 14,
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Center
					}),
					MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 1)
				})
				ValueLabel.Parent = SliderFrame
				function Slider:Set(Value)
					self.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)
					local percent = (self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min)
					
					TweenService:Create(SliderFill, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(percent, 0, 1, 0)
					}):Play()
					
					ValueLabel:FindFirstChildWhichIsA("TextLabel").Text = tostring(self.Value)
					SliderConfig.Callback(self.Value)
					
					if SliderConfig.Save then
						SaveCfg(game.GameId)
					end
				end
				SliderBar.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = true
					end
				end)
				SliderBar.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = false
					end
				end)
				UserInputService.InputChanged:Connect(function(Input)
					if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
						local SizeScale = math.clamp((Input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
						Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale))
					end
				end)
				Slider:Set(Slider.Value)
				if SliderConfig.Flag then				
					OrionLib.Flags[SliderConfig.Flag] = Slider
				end
				return Slider
			end  
			return ElementFunction   
		end	
		local ElementFunction = {}
		function ElementFunction:AddSection(SectionConfig)
			SectionConfig.Name = SectionConfig.Name or "Section"
			local SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 0, 36),
				Parent = Container
			}), {
				Create("TextLabel", {
					Size = UDim2.new(1, -12, 0, 16),
					Position = UDim2.new(0, 0, 0, 3),
					Font = Enum.Font.GothamSemibold,
					Text = SectionConfig.Name,
					TextColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Stroke,
					TextSize = 14,
					BackgroundTransparency = 1
				}),
				SetChildren(SetProps(MakeElement("TFrame"), {
					AnchorPoint = Vector2.new(0, 0),
					Size = UDim2.new(1, 0, 1, -24),
					Position = UDim2.new(0, 0, 0, 23),
					Name = "Holder"
				}), {
					MakeElement("List", 0, 6)
				}),
			})
			AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
				SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y)
			end)
			local SectionFunction = {}
			for i, v in next, GetElements(SectionFrame.Holder) do
				SectionFunction[i] = v 
			end
			return SectionFunction
		end	
		for i, v in next, GetElements(Container) do
			ElementFunction[i] = v 
		end
		if TabConfig.PremiumOnly then
			for i, v in next, ElementFunction do
				ElementFunction[i] = function() end
			end    
			Container:FindFirstChild("UIListLayout"):Destroy()
			Container:FindFirstChild("UIPadding"):Destroy()
			SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 1, 0),
				Parent = Container
			}), {
				SetProps(MakeElement("Image", "rbxassetid://3610239960"), {
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(0, 15, 0, 15),
					ImageTransparency = 0.4,
					ImageColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Text
				}),
				SetProps(MakeElement("Label", "Unauthorised Access", 14, 0, OrionLib.Themes[OrionLib.SelectedTheme].Text), {
					Size = UDim2.new(1, -38, 0, 14),
					Position = UDim2.new(0, 38, 0, 18),
					TextTransparency = 0.4
				}),
				SetProps(MakeElement("Image", "rbxassetid://4483345875"), {
					Size = UDim2.new(0, 56, 0, 56),
					Position = UDim2.new(0, 84, 0, 110),
					ImageColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Stroke
				}),
				SetProps(MakeElement("Label", "Premium Features", 14, 0, OrionLib.Themes[OrionLib.SelectedTheme].Text), {
					Size = UDim2.new(1, -150, 0, 14),
					Position = UDim2.new(0, 150, 0, 112),
					Font = Enum.Font.GothamBold
				}),
				SetProps(MakeElement("Label", "This part of the script is locked to Sirius Premium users. Purchase Premium in the Discord server (discord.gg/sirius)", 12, 0, OrionLib.Themes[OrionLib.SelectedTheme].Text), {
					Size = UDim2.new(1, -200, 0, 14),
					Position = UDim2.new(0, 150, 0, 138),
					TextWrapped = true,
					TextTransparency = 0.4
				})
			})
		end
		return ElementFunction   
	end  
	return TabFunction
end   
function OrionLib:Destroy()
	Orion:Destroy()
end
return OrionLib