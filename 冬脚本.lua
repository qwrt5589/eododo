repeat task.wait() until game:IsLoaded()
local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
  __index = function(t, k)
    return game.GetService(game, k)
  end
})

local mouse = services.Players.LocalPlayer:GetMouse()

function Tween(obj, t, data)
	services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
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
		Ripple.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://89073140684086"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(139, 0, 255)
		Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
		Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
		wait(0.15)
		Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
		wait(.3)
		Ripple:Destroy()
	end)
end

local toggled = false

-- # Switch Tabs # --
local switchingTabs = false
function switchTab(new)
  if switchingTabs then return end
  local old = library.currentTab
  if old == nil then
    new[2].Visible = true
    library.currentTab = new
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    return
  end
  
  if old[1] == new[1] then return end
  switchingTabs = true
  library.currentTab = new

  services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
  services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
  services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
  services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

  old[2].Visible = false
  new[2].Visible = true
  
  task.wait(0.1)

  switchingTabs = false
end

-- # Drag, Stolen from Kiriot or Wally # --
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
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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

function library.new(library, name,theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
          v:Destroy()
        end
      end
-------------------------AL------------------------------
ALTransparency = 0.6
ALcolor = Color3.fromRGB(0,255,127)
-------------------------AL------------------------------
if theme == 'dark' then
    MainColor = Color3.fromRGB(25, 25, 25)
    Background = Color3.fromRGB(25, 25, 25)
    zyColor= Color3.fromRGB(25, 25, 25)
    beijingColor = Color3.fromRGB(25, 25, 25)
    else
    MainColor = Color3.fromRGB(25, 25, 25)
    Background = Color3.fromRGB(25, 25, 25)
    zyColor= Color3.fromRGB(25, 25, 25)
    beijingColor = Color3.fromRGB(25, 25, 25)
end
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
      local Open = Instance.new("ImageButton")
      local UIG=Instance.new("UIGradient")
      local DropShadowHolder = Instance.new("Frame")
      local DropShadow = Instance.new("ImageLabel")
      local UICornerMain = Instance.new("UICorner")
      local UIGradient=Instance.new("UIGradient")
      local UIGradientTitle=Instance.new("UIGradient")
      local Frame = Instance.new("Frame")
      local UICorner = Instance.new("UICorner")
      local UICorner_2 = Instance.new("UICorner")
      
      if syn and syn.protect_gui then syn.protect_gui(dogent) end
    
      dogent.Name = "frosty"
      dogent.Parent = services.CoreGui
      
      function UiDestroy()
          dogent:Destroy()
      end
      
          function ToggleUILib()
            if not ToggleUI then
                dogent.Enabled = false
                ToggleUI = true
                else
                ToggleUI = false
                dogent.Enabled = true
            end
        end
      
      Main.Name = "Main"
      Main.Parent = dogent
      Main.AnchorPoint = Vector2.new(0.5, 0.5)
      Main.BackgroundColor3 = Background
      Main.BorderColor3 = MainColor
      Main.Position = UDim2.new(0.5, 0, 0.5, 0)
      Main.Size = UDim2.new(0, 572, 0, 353)
      Main.ZIndex = 1
      Main.Active = true
      Main.Draggable = true
      Main.Transparency = 1.0
      services.UserInputService.InputEnded:Connect(function(input)
      if input.KeyCode == Enum.KeyCode.LeftControl then
      if Main.Visible == true then
      Main.Visible = false else
      Main.Visible = true
      end
      end
      end)
      drag(Main)
      
      UICornerMain.Parent = Main
      UICornerMain.CornerRadius = UDim.new(0,3)
      
      DropShadowHolder.Name = "DropShadowHolder"
      DropShadowHolder.Parent = Main
      DropShadowHolder.BackgroundTransparency = 1.000
      DropShadowHolder.BorderSizePixel = 0
      DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
      DropShadowHolder.BorderColor3 = Color3.fromRGB(255,255,255)
      DropShadowHolder.ZIndex = 0

      DropShadow.Name = "DropShadow"
      DropShadow.Parent = DropShadowHolder
      DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
      DropShadow.BackgroundTransparency = 1.000
      DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
      DropShadow.Size = UDim2.new(1, 10, 1, 10)
      DropShadow.Image = "rbxassetid://89735503086112" --背景
      DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
      DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)


      UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))}

      local TweenService = game:GetService("TweenService")
      local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
      local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
      tween:Play()

          function toggleui()
            toggled = not toggled
            spawn(function()
                if toggled then wait(0.3) end
            end)
            Tween(Main, {0.3, 'Sine', 'InOut'}, {
                Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
            })
        end
      
      TabMain.Name = "TabMain"
      TabMain.Parent = Main
      TabMain.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
      TabMain.BackgroundTransparency = 1.000
      TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
      TabMain.Size = UDim2.new(0, 448, 0, 353)
      TabMain.Transparency = 1.0
      
      MainC.CornerRadius = UDim.new(0, 5.5)
      MainC.Name = "MainC"
      MainC.Parent = Frame
      
      
      SB.Name = "SB"
      SB.Parent = Main
      SB.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
      SB.BorderColor3 = MainColor
      SB.Size = UDim2.new(0, 8, 0, 353)
      SB.Transparency = 1.0
      
      SBC.CornerRadius = UDim.new(0, 6)
      SBC.Name = "SBC"
      SBC.Parent = SB
      
      Side.Name = "Side"
      Side.Parent = SB
      Side.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
      Side.BorderColor3 = Color3.fromRGB(139, 0, 255)
      Side.BorderSizePixel = 0
      Side.ClipsDescendants = true
      Side.Position = UDim2.new(1, 0, 0, 0)
      Side.Size = UDim2.new(0, 110, 0, 353)
      Side.Transparency = 1.0
      
      SideG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SideG.Rotation = 90
      SideG.Name = "SideG"
      SideG.Parent = Side
      
      TabBtns.Name = "TabBtns"
      TabBtns.Parent = Side
      TabBtns.Active = true
      TabBtns.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
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
      ScriptTitle.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
      ScriptTitle.BackgroundTransparency = 1.000
      ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
      ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
      ScriptTitle.Font = Enum.Font.GothamSemibold
      ScriptTitle.Text = name
      ScriptTitle.TextColor3 = Color3.fromRGB(139, 0, 255)
      ScriptTitle.TextSize = 14.000
      ScriptTitle.TextScaled = true
      ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
      
      UIGradientTitle.Parent = ScriptTitle
     
      local function NPLHKB_fake_script() 
        local script = Instance.new('LocalScript', ScriptTitle)
     
        local button = script.Parent
        local gradient = button.UIGradient
        local ts = game:GetService("TweenService")
        local ti = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local offset = {Offset = Vector2.new(1, 0)}
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
        gradient.Color = s({
            kpt(0, list[#list]),
            kpt(0.5, list[#list - 1]),
            kpt(1, list[#list - 2])
        })
        counter = #list
        local function animate()
            create:Play()
            create.Completed:Wait() 
            gradient.Offset = startingPos 
            gradient.Rotation = 180
            if counter == #list - 1 and status == "down" then
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[#list]), 
                    kpt(1, list[1]) 
                })
                counter = 1
                status = "up" 
            elseif counter == #list and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[1]),
                    kpt(1, list[2])
                })
                counter = 2
                status = "up"
            elseif counter <= #list - 2 and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[counter + 1]), 
                    kpt(1, list[counter + 2])
                })
                counter = counter + 2
                status = "up"
            end
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 0 
            if counter == #list - 1 and status == "up" then
                gradient.Color = s({ 
     
                    kpt(0, list[1]), 
                    kpt(0.5, list[#list]), 
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 1
                status = "down"
            elseif counter == #list and status == "up" then
                gradient.Color = s({
                    kpt(0, list[2]),
                    kpt(0.5, list[1]), 
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 2
                status = "down"
            elseif counter <= #list - 2 and status == "up" then
                gradient.Color = s({
                    kpt(0, list[counter + 2]), 
                    kpt(0.5, list[counter + 1]), 
                    kpt(1, gradient.Color.Keypoints[3].Value) 	
                })
                counter = counter + 2
                status = "down"
            end
            animate()
        end
        animate()
     
    end
    coroutine.wrap(NPLHKB_fake_script)()
      
      SBG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
      SBG.Rotation = 90
      SBG.Name = "SBG"
      SBG.Parent = SB
    
      TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
      end)
      
      --[[
      Open.Name = "Open"
      Open.Parent = dogent
      Open.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
      Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
      Open.Size = UDim2.new(0, 61, 0, 32)
      Open.Font = Enum.Font.SourceSans
      Open.Text = "King.Script/King"
      Open.TextColor3 = Color3.fromRGB(139, 0, 255)
      Open.TextSize = 15.000
      Open.Active = true
      Open.Draggable = true
      Open.MouseButton1Click:Connect(function()
          Main.Visible = not Main.Visible
          Open.Text=Main.Visible and "King.Script隐藏" or "King打开"
      end)
]]


-- Properties:

Frame.Parent = dogent
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
Frame.Size = UDim2.new(0, 50, 0, 50)
Frame.BackgroundTransparency = 1.000

UICorner.CornerRadius = UDim.new(0, 90)
UICorner.Parent = Frame

Open.Parent = Frame
Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Open.BorderColor3 = Color3.fromRGB(0, 0, 0)
Open.BorderSizePixel = 0
Open.Size = UDim2.new(0, 50, 0, 50)
Open.Active = true
Open.Draggable = true
Open.Image = "rbxassetid://89073140684086"
Open.MouseButton1Click:Connect(function()
  Main.Visible = not Main.Visible
  Open.Image = Main.Visible and "rbxassetid://89073140684086" or "rbxassetid://89073140684086" --开关的图
end)

UICorner_2.CornerRadius = UDim.new(0, 90)
UICorner_2.Parent = Open
UIG.Parent = Open
      
      local window = {}
      function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")
    
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.Visible = false
        
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = "rbxassetid://88044056525825" or icon and "rbxassetid://88044056525825"..icon
        TabIco.ImageTransparency = 0.2
        
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 24)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = name
        TabText.TextColor3 = ALcolor
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
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
          switchTab({TabIco, Tab})
        end)
    
        if library.currentTab == nil then switchTab({TabIco, Tab}) end
    
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)
------------------------------------------------------AL.King音乐-------------------------------------------------------
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6797864253" --音乐id
    sound.Parent = game.Workspace
    sound:Play()
---------------分割线-------------------------------分割线-------------------------------分割线----------------
        local tab = {}
        function tab.section(tab, name, TabVal)
          local Section = Instance.new("Frame")
          local SectionC = Instance.new("UICorner")
          local SectionText = Instance.new("TextLabel")
          local SectionOpen = Instance.new("ImageLabel")
          local SectionOpened = Instance.new("ImageLabel")
          local SectionToggle = Instance.new("ImageButton")
          local Objs = Instance.new("Frame")
          local ObjsL = Instance.new("UIListLayout")
    
          Section.Name = "Section"
          Section.Parent = Tab
          Section.BackgroundColor3 = zyColor
          Section.BackgroundTransparency = 1.000
          Section.BorderSizePixel = 0
          Section.ClipsDescendants = true
          Section.Size = UDim2.new(0.981000006, 0, 0, 36)
          
          SectionC.CornerRadius = UDim.new(0, 6)
          SectionC.Name = "SectionC"
          SectionC.Parent = Section
          
          SectionText.Name = "SectionText"
          SectionText.Parent = Section
          SectionText.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
          SectionText.BackgroundTransparency = 1.000
          SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
          SectionText.Size = UDim2.new(0, 401, 0, 36)
          SectionText.Font = Enum.Font.GothamSemibold
          SectionText.Text = name
          SectionText.TextColor3 = ALcolor
          SectionText.TextSize = 16.000
          SectionText.TextXAlignment = Enum.TextXAlignment.Left
          
          SectionOpen.Name = "SectionOpen"
          SectionOpen.Parent = SectionText
          SectionOpen.BackgroundTransparency = 1
          SectionOpen.BorderSizePixel = 0
          SectionOpen.Position = UDim2.new(0, -33, 0, 5)
          SectionOpen.Size = UDim2.new(0, 26, 0, 26)
          SectionOpen.Image = "rbxassetid://88044056525825"
          
          SectionOpened.Name = "SectionOpened"
          SectionOpened.Parent = SectionOpen
          SectionOpened.BackgroundTransparency = 1.000
          SectionOpened.BorderSizePixel = 0
          SectionOpened.Size = UDim2.new(0, 26, 0, 26)
          SectionOpened.Image = "rbxassetid://88044056525825"
          SectionOpened.ImageTransparency = 1.000
    
          SectionToggle.Name = "SectionToggle"
          SectionToggle.Parent = SectionOpen
          SectionToggle.BackgroundTransparency = 1
          SectionToggle.BorderSizePixel = 0
          SectionToggle.Size = UDim2.new(0, 26, 0, 26)
          
          Objs.Name = "Objs"
          Objs.Parent = Section
          Objs.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
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
            if not open then return end
            Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
          end)
    
          local section = {}
          function section.Button(section, text, callback)
            local callback = callback or function() end
    
            local BtnModule = Instance.new("Frame")
            local Btn = Instance.new("TextButton")
            local BtnC = Instance.new("UICorner")    
            
            BtnModule.Name = "BtnModule"
            BtnModule.Parent = Objs
            BtnModule.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            BtnModule.BackgroundTransparency = 1.000
            BtnModule.BorderSizePixel = 0
            BtnModule.Position = UDim2.new(0, 0, 0, 0)
            BtnModule.Size = UDim2.new(0, 428, 0, 38)
            BtnModule.Transparency = 0.75
            
            Btn.Name = "Btn"
            Btn.Parent = BtnModule
            Btn.BackgroundColor3 = zyColor
            Btn.BorderSizePixel = 0
            Btn.Size = UDim2.new(0, 428, 0, 38)
            Btn.AutoButtonColor = false
            Btn.Font = Enum.Font.GothamSemibold
            Btn.Text = "   " .. text
            Btn.TextColor3 = ALcolor
            Btn.TextSize = 16.000
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.BackgroundTransparency = ALTransparency
            
            BtnC.CornerRadius = UDim.new(0, 6)
            BtnC.Name = "BtnC"
            BtnC.Parent = Btn
    
            Btn.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(Btn)
                end)
                    spawn(callback)
                end)
            end
    
        function section:Label(text)
          local LabelModule = Instance.new("Frame")
          local TextLabel = Instance.new("TextLabel")
          local LabelC = Instance.new("UICorner")
          
          LabelModule.Name = "LabelModule"
          LabelModule.Parent = Objs
          LabelModule.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
          LabelModule.BackgroundTransparency = 1.000
          LabelModule.BorderSizePixel = 0
          LabelModule.Position = UDim2.new(0, 0, NAN, 0)
          LabelModule.Size = UDim2.new(0, 428, 0, 19)
          TextLabel.Parent = LabelModule
          TextLabel.BackgroundColor3 = zyColor
          TextLabel.Size = UDim2.new(0, 428, 0, 22)
          TextLabel.Font = Enum.Font.GothamSemibold
          TextLabel.Text = text
          TextLabel.TextColor3 = ALcolor
          TextLabel.BackgroundTransparency = ALTransparency
          TextLabel.TextSize = 14.000
    
          LabelC.CornerRadius = UDim.new(0, 6)
          LabelC.Name = "LabelC"
          LabelC.Parent = TextLabel
          return TextLabel
        end
    
          function section.Toggle(section, text, flag, enabled, callback)
            local callback = callback or function() end
            local enabled = enabled or false
            assert(text, "No text provided")
            assert(flag, "No flag provided")
    
            library.flags[flag] = enabled
    
            local ToggleModule = Instance.new("Frame")
            local ToggleBtn = Instance.new("TextButton")
            local ToggleBtnC = Instance.new("UICorner")
            local ToggleDisable = Instance.new("Frame")
            local ToggleSwitch = Instance.new("Frame")
            local ToggleSwitchC = Instance.new("UICorner")
            local ToggleDisableC = Instance.new("UICorner")
            
            ToggleModule.Name = "ToggleModule"
            ToggleModule.Parent = Objs
            ToggleModule.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            ToggleModule.BackgroundTransparency = 1.000
            ToggleModule.BorderSizePixel = 0
            ToggleModule.Position = UDim2.new(0, 0, 0, 0)
            ToggleModule.Size = UDim2.new(0, 428, 0, 38)
            
            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Parent = ToggleModule
            ToggleBtn.BackgroundColor3 = zyColor
            ToggleBtn.BackgroundTransparency = ALTransparency
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
            ToggleBtn.AutoButtonColor = false
            ToggleBtn.Font = Enum.Font.GothamSemibold
            ToggleBtn.Text = "   " .. text
            ToggleBtn.TextColor3 = ALcolor
            ToggleBtn.TextSize = 16.000
            ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleBtnC.CornerRadius = UDim.new(0, 6)
            ToggleBtnC.Name = "ToggleBtnC"
            ToggleBtnC.Parent = ToggleBtn
            
            ToggleDisable.Name = "ToggleDisable"
            ToggleDisable.Parent = ToggleBtn
            ToggleDisable.BackgroundColor3 = Background
            ToggleDisable.BackgroundTransparency = 0.5
            ToggleDisable.BorderSizePixel = 0
            ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
            ToggleDisable.Size = UDim2.new(0, 36, 0, 22)
            
            ToggleSwitch.Name = "ToggleSwitch"
            ToggleSwitch.Parent = ToggleDisable
            ToggleSwitch.BackgroundColor3 = beijingColor
            ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)
            
            ToggleSwitchC.CornerRadius = UDim.new(0, 6)
            ToggleSwitchC.Name = "ToggleSwitchC"
            ToggleSwitchC.Parent = ToggleSwitch
            
            ToggleDisableC.CornerRadius = UDim.new(0, 6)
            ToggleDisableC.Name = "ToggleDisableC"
            ToggleDisableC.Parent = ToggleDisable        
    
            local funcs = {
              SetState = function(self, state)
                if state == nil then state = not library.flags[flag] end
                if library.flags[flag] == state then return end
                services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0), BackgroundColor3 = (state and Color3.fromRGB(139, 0, 255) or beijingColor)}):Play()
                library.flags[flag] = state
                callback(state)
              end,
              Module = ToggleModule
            }
            
            if enabled ~= false then
                funcs:SetState(flag,true)
            end
    
            ToggleBtn.MouseButton1Click:Connect(function()
              funcs:SetState()
            end)
            return funcs
          end
    
          function section.Keybind(section, text, default, callback)
            local callback = callback or function() end
            assert(text, "No text provided")
            assert(default, "No default key provided")
    
            local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
            local banned = {
              Return = true;
              Space = true;
              Tab = true;
              Backquote = true;
              CapsLock = true;
              Escape = true;
              Unknown = true;
            }
            local shortNames = {
              RightControl = 'Right Ctrl',
              LeftControl = 'Left Ctrl',
              LeftShift = 'Left Shift',
              RightShift = 'Right Shift',
              Semicolon = ";",
              Quote = '"',
              LeftBracket = '[',
              RightBracket = ']',
              Equals = '=',
              Minus = '-',
              RightAlt = 'Right Alt',
              LeftAlt = 'Left Alt'
            }
    
            local bindKey = default
            local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")
    
            local KeybindModule = Instance.new("Frame")
            local KeybindBtn = Instance.new("TextButton")
            local KeybindBtnC = Instance.new("UICorner")
            local KeybindValue = Instance.new("TextButton")
            local KeybindValueC = Instance.new("UICorner")
            local KeybindL = Instance.new("UIListLayout")
            local UIPadding = Instance.new("UIPadding")
    
            KeybindModule.Name = "KeybindModule"
            KeybindModule.Parent = Objs
            KeybindModule.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            KeybindModule.BackgroundTransparency = 1.000
            KeybindModule.BorderSizePixel = 0
            KeybindModule.Position = UDim2.new(0, 0, 0, 0)
            KeybindModule.Size = UDim2.new(0, 428, 0, 38)
            
            KeybindBtn.Name = "KeybindBtn"
            KeybindBtn.Parent = KeybindModule
            KeybindBtn.BackgroundColor3 = zyColor
            KeybindBtn.BorderSizePixel = 0
            KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
            KeybindBtn.AutoButtonColor = false
            KeybindBtn.Font = Enum.Font.GothamSemibold
            KeybindBtn.Text = "   " .. text
            KeybindBtn.TextColor3 = ALcolor
            KeybindBtn.TextSize = 16.000
            KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            KeybindBtnC.CornerRadius = UDim.new(0, 6)
            KeybindBtnC.Name = "KeybindBtnC"
            KeybindBtnC.Parent = KeybindBtn
            
            KeybindValue.Name = "KeybindValue"
            KeybindValue.Parent = KeybindBtn
            KeybindValue.BackgroundColor3 = Background
            KeybindValue.BorderSizePixel = 0
            KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
            KeybindValue.Size = UDim2.new(0, 100, 0, 28)
            KeybindValue.AutoButtonColor = false
            KeybindValue.Font = Enum.Font.Gotham
            KeybindValue.Text = keyTxt
            KeybindValue.TextColor3 = Color3.fromRGB(139, 0, 255)
            KeybindValue.TextSize = 14.000
            
            KeybindValueC.CornerRadius = UDim.new(0, 6)
            KeybindValueC.Name = "KeybindValueC"
            KeybindValueC.Parent = KeybindValue
            
            KeybindL.Name = "KeybindL"
            KeybindL.Parent = KeybindBtn
            KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
            KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
            KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center
            
            UIPadding.Parent = KeybindBtn
            UIPadding.PaddingRight = UDim.new(0, 6)   
            
            services.UserInputService.InputBegan:Connect(function(inp, gpe)
              if gpe then return end
              if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
              if inp.KeyCode ~= bindKey then return end
              callback(bindKey.Name)
            end)
            
            KeybindValue.MouseButton1Click:Connect(function()
              KeybindValue.Text = "..."
              wait()
              local key, uwu = services.UserInputService.InputEnded:Wait()
              local keyName = tostring(key.KeyCode.Name)
              if key.UserInputType ~= Enum.UserInputType.Keyboard then
                KeybindValue.Text = keyTxt
                return
              end
              if banned[keyName] then
                KeybindValue.Text = keyTxt
                return
              end
              wait()
              bindKey = Enum.KeyCode[keyName]
              KeybindValue.Text = shortNames[keyName] or keyName
            end)
    
            KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
              KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
            end)
            KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
          end
    
          function section.Textbox(section, text, flag, default, callback)
            local callback = callback or function() end
            assert(text, "No text provided")
            assert(flag, "No flag provided")
            assert(default, "No default text provided")
    
            library.flags[flag] = default
    
            local TextboxModule = Instance.new("Frame")
            local TextboxBack = Instance.new("TextButton")
            local TextboxBackC = Instance.new("UICorner")
            local BoxBG = Instance.new("TextButton")
            local BoxBGC = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")
            local TextboxBackL = Instance.new("UIListLayout")
            local TextboxBackP = Instance.new("UIPadding")  
    
            TextboxModule.Name = "TextboxModule"
            TextboxModule.Parent = Objs
            TextboxModule.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            TextboxModule.BackgroundTransparency = 1.000
            TextboxModule.BorderSizePixel = 0
            TextboxModule.Position = UDim2.new(0, 0, 0, 0)
            TextboxModule.Size = UDim2.new(0, 428, 0, 38)
            
            TextboxBack.Name = "TextboxBack"
            TextboxBack.Parent = TextboxModule
            TextboxBack.BackgroundColor3 = zyColor
            TextboxBack.BackgroundTransparency = ALTransparency
            TextboxBack.BorderSizePixel = 0
            TextboxBack.Size = UDim2.new(0, 428, 0, 38)
            TextboxBack.AutoButtonColor = false
            TextboxBack.Font = Enum.Font.GothamSemibold
            TextboxBack.Text = "   " .. text
            TextboxBack.TextColor3 = ALcolor
            TextboxBack.TextSize = 16.000
            TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
            
            TextboxBackC.CornerRadius = UDim.new(0, 6)
            TextboxBackC.Name = "TextboxBackC"
            TextboxBackC.Parent = TextboxBack
            
            BoxBG.Name = "BoxBG"
            BoxBG.Parent = TextboxBack
            BoxBG.BackgroundColor3 = Background
            BoxBG.BorderSizePixel = 0
            BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
            BoxBG.Size = UDim2.new(0, 100, 0, 28)
            BoxBG.AutoButtonColor = false
            BoxBG.Font = Enum.Font.Gotham
            BoxBG.Text = ""
            BoxBG.TextColor3 = Color3.fromRGB(139, 0, 255)
            BoxBG.TextSize = 14.000
            
            BoxBGC.CornerRadius = UDim.new(0, 6)
            BoxBGC.Name = "BoxBGC"
            BoxBGC.Parent = BoxBG
            
            TextBox.Parent = BoxBG
            TextBox.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.BorderSizePixel = 0
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = default
            TextBox.TextColor3 = Color3.fromRGB(139, 0, 255)
            TextBox.TextSize = 14.000
            
            TextboxBackL.Name = "TextboxBackL"
            TextboxBackL.Parent = TextboxBack
            TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
            TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
            TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center
            
            TextboxBackP.Name = "TextboxBackP"
            TextboxBackP.Parent = TextboxBack
            TextboxBackP.PaddingRight = UDim.new(0, 6)
    
            TextBox.FocusLost:Connect(function()
              if TextBox.Text == "" then
                TextBox.Text = default
              end
              library.flags[flag] = TextBox.Text
              callback(TextBox.Text)
            end)
    
            TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
              BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
            end)
            BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
          end
    
          function section.Slider(section, text, flag, default, min, max, precise, callback)
            local callback = callback or function() end
            local min = min or 1
            local max = max or 10
            local default = default or min
            local precise = precise or false
    
            library.flags[flag] = default
    
            assert(text, "No text provided")
            assert(flag, "No flag provided")
            assert(default, "No default value provided")
            
            local SliderModule = Instance.new("Frame")
            local SliderBack = Instance.new("TextButton")
            local SliderBackC = Instance.new("UICorner")
            local SliderBar = Instance.new("Frame")
            local SliderBarC = Instance.new("UICorner")
            local SliderPart = Instance.new("Frame")
            local SliderPartC = Instance.new("UICorner")
            local SliderValBG = Instance.new("TextButton")
            local SliderValBGC = Instance.new("UICorner")
            local SliderValue = Instance.new("TextBox")
            local MinSlider = Instance.new("TextButton")
            local AddSlider = Instance.new("TextButton")   
            
            SliderModule.Name = "SliderModule"
            SliderModule.Parent = Objs
            SliderModule.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            SliderModule.BackgroundTransparency = 1.000
            SliderModule.BorderSizePixel = 0
            SliderModule.Position = UDim2.new(0, 0, 0, 0)
            SliderModule.Size = UDim2.new(0, 428, 0, 38)
            
            SliderBack.Name = "SliderBack"
            SliderBack.Parent = SliderModule
            SliderBack.BackgroundColor3 = zyColor
            SliderBack.BackgroundTransparency = ALTransparency
            SliderBack.BorderSizePixel = 0
            SliderBack.Size = UDim2.new(0, 428, 0, 38)
            SliderBack.AutoButtonColor = false
            SliderBack.Font = Enum.Font.GothamSemibold
            SliderBack.Text = "   " .. text
            SliderBack.TextColor3 = ALcolor
            SliderBack.TextSize = 16.000
            SliderBack.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderBackC.CornerRadius = UDim.new(0, 6)
            SliderBackC.Name = "SliderBackC"
            SliderBackC.Parent = SliderBack
            
            SliderBar.Name = "SliderBar"
            SliderBar.Parent = SliderBack
            SliderBar.AnchorPoint = Vector2.new(0, 0.5)
            SliderBar.BackgroundColor3 = Background
            SliderBar.BackgroundTransparency = ALTransparency
            SliderBar.BorderSizePixel = 0
            SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
            SliderBar.Size = UDim2.new(0, 140, 0, 12)
            
            SliderBarC.CornerRadius = UDim.new(0, 4)
            SliderBarC.Name = "SliderBarC"
            SliderBarC.Parent = SliderBar
            
            SliderPart.Name = "SliderPart"
            SliderPart.Parent = SliderBar
            SliderPart.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            SliderPart.BorderSizePixel = 0
            SliderPart.Size = UDim2.new(0, 54, 0, 13)
            
            SliderPartC.CornerRadius = UDim.new(0, 4)
            SliderPartC.Name = "SliderPartC"
            SliderPartC.Parent = SliderPart
            
            SliderValBG.Name = "SliderValBG"
            SliderValBG.Parent = SliderBack
            SliderValBG.BackgroundColor3 = Background
            SliderValBG.BackgroundTransparency = ALTransparency
            SliderValBG.BorderSizePixel = 0
            SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
            SliderValBG.Size = UDim2.new(0, 44, 0, 28)
            SliderValBG.AutoButtonColor = false
            SliderValBG.Font = Enum.Font.Gotham
            SliderValBG.Text = ""
            SliderValBG.TextColor3 = Color3.fromRGB(139, 0, 255)
            SliderValBG.TextSize = 14.000
            
            SliderValBGC.CornerRadius = UDim.new(0, 6)
            SliderValBGC.Name = "SliderValBGC"
            SliderValBGC.Parent = SliderValBG
            
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderValBG
            SliderValue.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.BorderSizePixel = 0
            SliderValue.Size = UDim2.new(1, 0, 1, 0)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = "1000"
            SliderValue.TextColor3 = Color3.fromRGB(139, 0, 255)
            SliderValue.TextSize = 14.000
            
            MinSlider.Name = "MinSlider"
            MinSlider.Parent = SliderModule
            MinSlider.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            MinSlider.BackgroundTransparency = 1.000
            MinSlider.BorderSizePixel = 0
            MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
            MinSlider.Size = UDim2.new(0, 20, 0, 20)
            MinSlider.Font = Enum.Font.Gotham
            MinSlider.Text = "-"
            MinSlider.TextColor3 = ALcolor
            MinSlider.TextSize = 24.000
            MinSlider.TextWrapped = true
            
            AddSlider.Name = "AddSlider"
            AddSlider.Parent = SliderModule
            AddSlider.AnchorPoint = Vector2.new(0, 0.5)
            AddSlider.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            AddSlider.BackgroundTransparency = 1.000
            AddSlider.BorderSizePixel = 0
            AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
            AddSlider.Size = UDim2.new(0, 20, 0, 20)
            AddSlider.Font = Enum.Font.Gotham
            AddSlider.Text = "+"
            AddSlider.TextColor3 = ALcolor
            AddSlider.TextSize = 24.000
            AddSlider.TextWrapped = true
            
            local funcs = {
              SetValue = function(self, value)
                local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                if value then
                  percent = (value - min) / (max - min)
                end
                percent = math.clamp(percent, 0, 1)
                if precise then
                  value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
                else
                  value = value or math.floor(min + (max - min) * percent)
                end
                library.flags[flag] = tonumber(value)
                SliderValue.Text = tostring(value)
                SliderPart.Size = UDim2.new(percent, 0, 1, 0)
                callback(tonumber(value))
              end
            }
    
            MinSlider.MouseButton1Click:Connect(function()
              local currentValue = library.flags[flag]
              currentValue = math.clamp(currentValue - 1, min, max)
              funcs:SetValue(currentValue)
            end)
    
            AddSlider.MouseButton1Click:Connect(function()
              local currentValue = library.flags[flag]
              currentValue = math.clamp(currentValue + 1, min, max)
              funcs:SetValue(currentValue)
            end)
            
            funcs:SetValue(default)
    
            local dragging, boxFocused, allowed = false, false, {
              [""] = true,
              ["-"] = true
            }
    
            SliderBar.InputBegan:Connect(function(input)
              if input.UserInputType == Enum.UserInputType.MouseButton1 then
                funcs:SetValue()
                dragging = true
              end
            end)
    
            services.UserInputService.InputEnded:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
              end
            end)
    
            services.UserInputService.InputChanged:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                funcs:SetValue()
              end
            end)

            SliderBar.InputBegan:Connect(function(input)
              if input.UserInputType == Enum.UserInputType.Touch then
                funcs:SetValue()
                dragging = true
              end
            end)
    
            services.UserInputService.InputEnded:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
              end
            end)
    
            services.UserInputService.InputChanged:Connect(function(input)
              if dragging and input.UserInputType == Enum.UserInputType.Touch then
                funcs:SetValue()
              end
            end)
    
            SliderValue.Focused:Connect(function()
              boxFocused = true
            end)
    
            SliderValue.FocusLost:Connect(function()
              boxFocused = false
              if SliderValue.Text == "" then
                funcs:SetValue(default)
              end
            end)
    
            SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
              if not boxFocused then return end
              SliderValue.Text = SliderValue.Text:gsub("%D+", "")
              
              local text = SliderValue.Text
              
              if not tonumber(text) then
                SliderValue.Text = SliderValue.Text:gsub('%D+', '')
              elseif not allowed[text] then
                if tonumber(text) > max then
                  text = max
                  SliderValue.Text = tostring(max)
                end
                funcs:SetValue(tonumber(text))
              end
            end)
    
            return funcs
          end
          function section.Dropdown(section, text, flag, options, callback)
            local callback = callback or function() end
            local options = options or {}
            assert(text, "No text provided")
            assert(flag, "No flag provided")
    
            library.flags[flag] = nil
            
            local DropdownModule = Instance.new("Frame")
            local DropdownTop = Instance.new("TextButton")
            local DropdownTopC = Instance.new("UICorner")
            local DropdownOpen = Instance.new("TextButton")
            local DropdownText = Instance.new("TextBox")
            local DropdownModuleL = Instance.new("UIListLayout")
            local Option = Instance.new("TextButton")
            local OptionC = Instance.new("UICorner")        
    
            DropdownModule.Name = "DropdownModule"
            DropdownModule.Parent = Objs
            DropdownModule.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            DropdownModule.BackgroundTransparency = 1.000
            DropdownModule.BorderSizePixel = 0
            DropdownModule.ClipsDescendants = true
            DropdownModule.Position = UDim2.new(0, 0, 0, 0)
            DropdownModule.Size = UDim2.new(0, 428, 0, 38)
            
            DropdownTop.Name = "DropdownTop"
            DropdownTop.Parent = DropdownModule
            DropdownTop.BackgroundColor3 = zyColor
            DropdownTop.BackgroundTransparency = ALTransparency
            DropdownTop.BorderSizePixel = 0
            DropdownTop.Size = UDim2.new(0, 428, 0, 38)
            DropdownTop.AutoButtonColor = false
            DropdownTop.Font = Enum.Font.GothamSemibold
            DropdownTop.Text = ""
            DropdownTop.TextColor3 = ALcolor
            DropdownTop.TextSize = 16.000
            DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownTopC.CornerRadius = UDim.new(0, 6)
            DropdownTopC.Name = "DropdownTopC"
            DropdownTopC.Parent = DropdownTop
            
            DropdownOpen.Name = "DropdownOpen"
            DropdownOpen.Parent = DropdownTop
            DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
            DropdownOpen.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            DropdownOpen.BackgroundTransparency = 1.000
            DropdownOpen.BorderSizePixel = 0
            DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
            DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
            DropdownOpen.Font = Enum.Font.Gotham
            DropdownOpen.Text = "+"
            DropdownOpen.TextColor3 = ALcolor
            DropdownOpen.TextSize = 24.000
            DropdownOpen.TextWrapped = true
            
            DropdownText.Name = "DropdownText"
            DropdownText.Parent = DropdownTop
            DropdownText.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
            DropdownText.BackgroundTransparency = 1.000
            DropdownText.BorderSizePixel = 0
            DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
            DropdownText.Size = UDim2.new(0, 184, 0, 38)
            DropdownText.Font = Enum.Font.GothamSemibold
            DropdownText.PlaceholderColor3 = Color3.fromRGB(139, 0, 255)
            DropdownText.PlaceholderText = text
            DropdownText.Text = ""
            DropdownText.TextColor3 = Color3.fromRGB(139, 0, 255)
            DropdownText.TextSize = 16.000
            DropdownText.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownModuleL.Name = "DropdownModuleL"
            DropdownModuleL.Parent = DropdownModule
            DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownModuleL.Padding = UDim.new(0, 4)
    
            local setAllVisible = function()
              local options = DropdownModule:GetChildren() 
              for i=1, #options do
                local option = options[i]
                if option:IsA("TextButton") and option.Name:match("Option_") then
                  option.Visible = true
                end
              end
            end
    
            local searchDropdown = function(text)
              local options = DropdownModule:GetChildren()
              for i=1, #options do
                local option = options[i]
                if text == "" then
                  setAllVisible()
                else
                  if option:IsA("TextButton") and option.Name:match("Option_") then
                    if option.Text:lower():match(text:lower()) then
                      option.Visible = true
                    else
                      option.Visible = false
                    end
                  end
                end
              end
            end
    
            local open = false
            local ToggleDropVis = function()
              open = not open
              if open then setAllVisible() end
              DropdownOpen.Text = (open and "-" or "+")
              DropdownModule.Size = UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
            end
    
            DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
            DropdownText.Focused:Connect(function()
              if open then return end
              ToggleDropVis()
            end)
    
            DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
              if not open then return end
              searchDropdown(DropdownText.Text)
            end)
    
            DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
              if not open then return end
              DropdownModule.Size = UDim2.new(0, 428, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
            end)
            
            local funcs = {}
            funcs.AddOption = function(self, option)
              local Option = Instance.new("TextButton")
              local OptionC = Instance.new("UICorner")     
    
              Option.Name = "Option_" .. option
              Option.Parent = DropdownModule
              Option.BackgroundColor3 = zyColor
              Option.BorderSizePixel = 0
              Option.Position = UDim2.new(0, 0, 0.328125, 0)
              Option.Size = UDim2.new(0, 428, 0, 26)
              Option.AutoButtonColor = false
              Option.Font = Enum.Font.Gotham
              Option.Text = option
              Option.TextColor3 = ALcolor
              Option.TextSize = 14.000
              
              OptionC.CornerRadius = UDim.new(0, 6)
              OptionC.Name = "OptionC"
              OptionC.Parent = Option
    
              Option.MouseButton1Click:Connect(function()
                ToggleDropVis()
                callback(Option.Text)
                DropdownText.Text = Option.Text
                library.flags[flag] = Option.Text
              end)
            end
    
            funcs.RemoveOption = function(self, option)
              local option = DropdownModule:FindFirstChild("Option_" .. option)
              if option then option:Destroy() end
            end
    
            funcs.SetOptions = function(self, options)
              for _, v in next, DropdownModule:GetChildren() do
                if v.Name:match("Option_") then
                  v:Destroy()
                end
              end
              for _,v in next, options do
                funcs:AddOption(v)
              end
            end
    
            funcs:SetOptions(options)
    
            return funcs
          end
          return section
        end
        return tab
      end
      return window
    end
    local window = library:new("冬脚本")

local creds = window:Tab("信息",'6035145364')

local bin = creds:section("信息",true)

    bin:Label("你的用户名："..game.Players.LocalPlayer.Character.Humanoid.Name)
    bin:Label("你的注入器:"..identifyexecutor())

local creds = window:Tab("通用",'6035145364')

local tool = creds:section("通用",true)

tool:Button("速度更改",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Zuw5T7DP",true))()
end)

tool:Button("工具",function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
end)

tool:Button("无敌少侠",function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
end)

tool:Button("防摔",function()
        loadstring(game:HttpGet("http://rawscripts.net/raw/Universal-Script-Touch-fling-script-22447"))()
end)

tool:Button("人物无敌",function()
        loadstring(game:HttpGet('https://pastebin.com/raw/H3RLCWWZ'))()
end)

tool:Button("无头断腿",function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Permanent-Headless-And-korblox-Script-4140"))()
end)

tool:Button("玩家进入提示",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
end)

tool:Button("撸78",function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

tool:Button("穿墙",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/OtherScript/main/Noclip"))() 
end)

tool:Button("踏空行动",function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)

tool:Button("隐身道具",function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/skid123skidlol/cd0d2dce51b3f20ad1aac941da06a1a1/raw/f58b98cce7d51e53ade94e7bb460e4f24fb7e0ff/%257BFE%257D%2520Invisible%2520Tool%2520(can%2520hold%2520tools)",true))()
end)

tool:Button("范围",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/jiNwDbCN"))()
end)

tool:Button("最强透视",function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/cool83birdcarfly02six/UNIVERSALESPLTX/main/README.md'))()
end)
    
tool:Button("位置获取",function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/NortherScripts/8d954211b286d051c416cc5f88b3dc5f/raw/"))()
end)

tool:Button("无限连跳",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
end)

tool:Button("甩飞",function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Auto%20Fling%20Player'))()
end)

tool:Button("控制",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()
end)

tool:Button("免费动画",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Zj4NnKs6"))()
end)

tool:Button("不雅动作",function()
        loadstring(game:HttpGet(('https://pastebin.com/raw/ZfaM6tNg'),true))()
end)

tool:Button("按键（任意选择按键",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/KeyBinds/main/KeyBinds-Source.lua"))()
end)

local creds = window:Tab("变身",'6035145364')

local tool = creds:section("有一些是FE",true)

tool:Button("僵尸",function()
        loadstring(game:HttpGet('https://gist.githubusercontent.com/1BlueCat/7668ee0c4e1b352d8ac51efd6ed6f3fc/raw/d6421d586bf9b5d2e3fc0ebf14203c849494ec5f/FE%2520Zombie'))()
end)

tool:Button("超人",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/5yLUa0Dd"))(); 
end)

tool:Button("狒狒",function()
        loadstring(game:HttpGet(('https://pastefy.ga/osEThPw1/raw'),true))()
end)

tool:Button("激光",function()
        loadstring(game:HttpGet(('https://pastefy.ga/Gjlleuea/raw'),true))()
end)

local creds = window:Tab("DOORS",'6035145364')

local tool = creds:section("功能",true)

tool:Button("脚本1",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TheHunterSolo1/Scripts/refs/heads/main/Protected_2809220311826785.lua.txt"))()
end)

tool:Button("穿墙",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/OtherScript/main/Noclip"))() 
end)

tool:Button("控制",function(Value)
		if Value then
		    game.Lighting.Ambient = Color3.new(1, 1, 1)
		else
		    game.Lighting.Ambient = Color3.new(0, 0, 0)
		end
end)

tool:Button("手电筒",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Normal%20Flashlight"))()
end)

tool:Button("神圣炸弹",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/HolyGrenadeByNerd.lua"))()
end)

tool:Button("十字架封印一切按q使用",function()
        _G.Uses = 10000
_G.Range = 999
_G.OnAnything = true
_G.Fail = false
loadstring(game:HttpGet('https://raw.githubusercontent.com/PenguinManiack/Crucifix/main/Crucifix.lua'))()
end)

tool:Button("A-3000",function()
        	      		      		
_G.OnShop = true

loadstring(game:HttpGet('https://raw.githubusercontent.com/DeividComSono/Scripts/main/Scanner.lua'))()
end)

tool:Button("A-3000备用",function()
        _G.UpdateStars = false -- stars disappear after picking up a book/breaker pole | false: a little lag

    loadstring(game:HttpGet('https://raw.githubusercontent.com/DeividComSono/Scripts/main/Scanner.lua'))()
end)

tool:Button("微山2.3.2",function()
        --微山doors 2.3.2(愚人节快乐)
loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\117\72\72\112\56\102\122\83"))()
end)

tool:Button("飞行",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/gqv7PXAa"))()
end)

tool:Button("键盘",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

tool:Button("吸铁石",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/MagnetByNerd.lua"))()
end)

tool:Button("剪刀",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/shears_done.lua"))()
end)

tool:Button("激光枪",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Laser%20Gun"))()
end)

tool:Button("紫色手电筒买东西时使用",function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Purple%20Flashlight"))()
end)

local creds = window:Tab("自然灾害",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("单一物体漂浮",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/6669178/main/单一物体飞行载自己最终优化版"))()
end)

tool:Button("全局物体漂浮",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/6669178/main/全局物体漂浮最终优化版"))()
end)

tool:Button("球形黑洞",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/Soul-Ring/main/%E5%8F%AC%E5%94%A4%E9%AD%82%E7%8E%AF"))()
end)

tool:Button("零件破坏者v2",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cytj777i/-/main/零件破坏者v2"))()
end)

tool:Button("自然灾害1",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/scripts/LoadstringUjHI6RQpz2o8", true))()
end)

tool:Button("自然灾害2",function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/MrWitzbold/Natural-disaster-survival-GUI/main/main.lua'),true))()
end)

local creds = window:Tab("监狱人生",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("监狱人生1",function()
        loadstring(game:HttpGetAsync("https://pastebin.com/raw/fYMnAEeJ"))()
end)

tool:Button("监狱人生2",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/PRISONWARE_v1.3.txt"))();
end)

tool:Button("监狱人生3",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Gae7YC84"))();
end)

tool:Button("监狱人生4",function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/LiverMods/xRawnder/main/HubMoblie'))()
end)

local creds = window:Tab("一路向西",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("神枪",function()
        loadstring(game:GetObjects("rbxassetid://10040701935")[1].Source)()
end)

tool:Button("快速抢劫",function()
        loadstring(game:GetObjects("rbxassetid://10041726588")[1].Source)()
end)

tool:Button("一路向西1",function()
        loadstring(game:HttpGet(("https://raw.githubusercontent.com/Drifter0507/scripts/main/westbound"),true))()
end)

tool:Button("范围",function()
        loadstring(game:GetObjects("rbxassetid://10040722920")[1].Source)()
end)

local creds = window:Tab("俄亥俄州",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("秒开保险柜",function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ClasiniZukov/e7547e7b48fa90d10eb7f85bd3569147/raw/f95cd3561a3bb3ac6172a14eb74233625b52e757/gistfile1.txt"))()
end)

tool:Button("剑客的🤔",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/ehaiezhou"))()
end)

local creds = window:Tab("最强战场",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("很强的脚本",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/louismich4el/Zygarde/refs/heads/main/ZygardeV1.txt"))()
end)

tool:Button("老外的",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/GoldenPakiFusion/refs/heads/main/Script"))()
end)

tool:Button("五条悟",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
end)

local creds = window:Tab("鲨口求生",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("傻够救盛",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/YYVLbzVg", true))()
end)

local creds = window:Tab("51区",'6035145364')

local tool = creds:section("保持富态",true)

tool:Button("51区1",function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Ghostmode65/STK-Bo2/master/STK-Menus/v7/STv7-Engine.txt'))()
end)

local creds = window:Tab("河北唐县",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("刷钱",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/ok/T%20ang%20County"))() 
end)

local creds = window:Tab("兵工厂",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("汉化脚本",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/Tbao.lua"))()
end)

local creds = window:Tab("战争大亨",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("汉化脚本",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%88%98%E4%BA%89%E5%A4%A7%E4%BA%A8.txt"))()
end)

local creds = window:Tab("内脏与黑火药",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("无需多言",function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\102\121\46\97\112\112\47\65\51\78\113\122\52\78\112\47\114\97\119"))()
end)

local creds = window:Tab("被遗弃",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("依旧汉化",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/%E8%A2%AB%E9%81%97%E5%BC%83"))()
end)

local creds = window:Tab("99夜",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("还是汉化",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/99%E5%A4%9C%E8%99%9A%E7%A9%BA.txt"))()
end)

local creds = window:Tab("墨水游戏",'6035145364')

local tool = creds:section("有些我没用过",true)

tool:Button("汉化",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/TexRBLlX"))()
end)

local creds = window:Tab("脚本",'6035145364')

local tool = creds:section("脚本",true)

tool:Button("皮脚本",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

tool:Button("苏脚本",function()
        loadstring(game:HttpGet("https://github.com/kukunb/lol/raw/main/load"))()
end)

tool:Button("叶脚本",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-YE-SCRIPT-XIAOYE.lua"))()
end)

tool:Button("Rb脚本",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/Rb-Hub"))()
end)

local creds = window:Tab("灭霸模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Button("出生/复活的地方",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,153,-20)
end)

tool:Button("刷碎片/铸造的地方",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(20,115,-695)
end)

tool:Button("商店/升级的地方",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-28,1061,1590)
end)

tool:Button("时间宝石的位置",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(444.5,117,443.5)
end)

tool:Button("空间宝石的位置",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-412,73,-444)
end)

tool:Button("现实宝石位置",function()
       loadstring(game:HttpGet('https://pastebin.com/raw/H3RLCWWZ'))()
end)

tool:Button("能量宝石怪位置",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(433,55,-326)
end)

tool:Button("快速自杀",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99999,-4985,99999)
end)

local fps = fps:section("fps ping",true)

fps:Button("ping",function()
            repeat wait() until game:IsLoaded() wait(2)
local ScreenGui = Instance.new("ScreenGui")
local Ping = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Ping.Name = "Ping"
Ping.Parent = ScreenGui
Ping.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
Ping.BackgroundTransparency = 1.000
Ping.BorderColor3 = Color3.fromRGB(0, 0, 128)
Ping.Position = UDim2.new(0.700000048, 0, 0, 0)
Ping.Size = UDim2.new(0, 125, 0, 25)
Ping.Font = Enum.Font.SourceSans
Ping.TextColor3 = Color3.fromRGB(0, 0, 255)
Ping.TextScaled = true
Ping.TextSize = 14.000
Ping.TextWrapped = true

local script = Instance.new('LocalScript', Ping)
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function(ping) 
script.Parent.Text = ("Ping: " ..game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(math.round(2/ping))) -- your ping
end)
end)

bin:Button("fps",function()
        repeat wait() until game:IsLoaded() wait(2)
local ScreenGui = Instance.new("ScreenGui")
local Fps = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Fps.Name = "Fps"
Fps.Parent = ScreenGui
Fps.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
Fps.BackgroundTransparency = 1.000
Fps.Position = UDim2.new(0.786138654, 0, 0, 0)
Fps.Size = UDim2.new(0, 125, 0, 25)
Fps.Font = Enum.Font.SourceSans
Fps.TextColor3 = Color3.fromRGB(0, 0, 255)
Fps.TextScaled = true
Fps.TextSize = 14.000
Fps.TextWrapped = true

local script = Instance.new('LocalScript', Fps)
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function(frame)
script.Parent.Text = ("FPS: "..math.round(1/frame)) 
end)
end)

local creds = window:Tab("afk",'6035145364')

local tool = creds:section("afk",true)

credits:Toggle("afk", "", false, function(state)
        print("Anti Afk On")
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
end)