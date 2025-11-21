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
		Ripple.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://113014107793531"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(245,245,245)
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
ALcolor = Color3.fromRGB(173,216,230)
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
      DropShadow.Image = "rbxassetid://92706630783425" --背景
      DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
      DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)


      UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(245,245,245)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(245,245,245)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))}

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
      TabMain.BackgroundColor3 = Color3.fromRGB(245,245,245)
      TabMain.BackgroundTransparency = 1.000
      TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
      TabMain.Size = UDim2.new(0, 448, 0, 353)
      TabMain.Transparency = 1.0
      
      MainC.CornerRadius = UDim.new(0, 5.5)
      MainC.Name = "MainC"
      MainC.Parent = Frame
      
      
      SB.Name = "SB"
      SB.Parent = Main
      SB.BackgroundColor3 = Color3.fromRGB(245,245,245)
      SB.BorderColor3 = MainColor
      SB.Size = UDim2.new(0, 8, 0, 353)
      SB.Transparency = 1.0
      
      SBC.CornerRadius = UDim.new(0, 6)
      SBC.Name = "SBC"
      SBC.Parent = SB
      
      Side.Name = "Side"
      Side.Parent = SB
      Side.BackgroundColor3 = Color3.fromRGB(245,245,245)
      Side.BorderColor3 = Color3.fromRGB(245,245,245)
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
      TabBtns.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
      ScriptTitle.BackgroundColor3 = Color3.fromRGB(245,245,245)
      ScriptTitle.BackgroundTransparency = 1.000
      ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
      ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
      ScriptTitle.Font = Enum.Font.GothamSemibold
      ScriptTitle.Text = name
      ScriptTitle.TextColor3 = Color3.fromRGB(245,245,245)
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
      Open.BackgroundColor3 = Color3.fromRGB(245,245,245)
      Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
      Open.Size = UDim2.new(0, 61, 0, 32)
      Open.Font = Enum.Font.SourceSans
      Open.Text = "King.Script/King"
      Open.TextColor3 = Color3.fromRGB(245,245,245)
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
Open.Image = "rbxassetid://113014107793531"
Open.MouseButton1Click:Connect(function()
  Main.Visible = not Main.Visible
  Open.Image = Main.Visible and "rbxassetid://131315997498301" or "rbxassetid://95299763997103" --开关的图
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
        Tab.BackgroundColor3 = Color3.fromRGB(245,245,245)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.Visible = false
        
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = "rbxassetid://113014107793531" or icon and "rbxassetid://"..icon
        TabIco.ImageTransparency = 0.2
        
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
        TabBtn.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
          SectionText.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
          SectionOpen.Image = "rbxassetid://113014107793531"
          
          SectionOpened.Name = "SectionOpened"
          SectionOpened.Parent = SectionOpen
          SectionOpened.BackgroundTransparency = 1.000
          SectionOpened.BorderSizePixel = 0
          SectionOpened.Size = UDim2.new(0, 26, 0, 26)
          SectionOpened.Image = "rbxassetid://113014107793531"
          SectionOpened.ImageTransparency = 1.000
    
          SectionToggle.Name = "SectionToggle"
          SectionToggle.Parent = SectionOpen
          SectionToggle.BackgroundTransparency = 1
          SectionToggle.BorderSizePixel = 0
          SectionToggle.Size = UDim2.new(0, 26, 0, 26)
          
          Objs.Name = "Objs"
          Objs.Parent = Section
          Objs.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            BtnModule.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
          LabelModule.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            ToggleModule.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
                services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0), BackgroundColor3 = (state and Color3.fromRGB(245,245,245) or beijingColor)}):Play()
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
            KeybindModule.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            KeybindValue.TextColor3 = Color3.fromRGB(245,245,245)
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
            TextboxModule.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            BoxBG.TextColor3 = Color3.fromRGB(245,245,245)
            BoxBG.TextSize = 14.000
            
            BoxBGC.CornerRadius = UDim.new(0, 6)
            BoxBGC.Name = "BoxBGC"
            BoxBGC.Parent = BoxBG
            
            TextBox.Parent = BoxBG
            TextBox.BackgroundColor3 = Color3.fromRGB(245,245,245)
            TextBox.BackgroundTransparency = 1.000
            TextBox.BorderSizePixel = 0
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = default
            TextBox.TextColor3 = Color3.fromRGB(245,245,245)
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
            SliderModule.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            SliderPart.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            SliderValBG.TextColor3 = Color3.fromRGB(245,245,245)
            SliderValBG.TextSize = 14.000
            
            SliderValBGC.CornerRadius = UDim.new(0, 6)
            SliderValBGC.Name = "SliderValBGC"
            SliderValBGC.Parent = SliderValBG
            
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = SliderValBG
            SliderValue.BackgroundColor3 = Color3.fromRGB(245,245,245)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.BorderSizePixel = 0
            SliderValue.Size = UDim2.new(1, 0, 1, 0)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = "1000"
            SliderValue.TextColor3 = Color3.fromRGB(245,245,245)
            SliderValue.TextSize = 14.000
            
            MinSlider.Name = "MinSlider"
            MinSlider.Parent = SliderModule
            MinSlider.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            AddSlider.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            DropdownModule.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            DropdownOpen.BackgroundColor3 = Color3.fromRGB(245,245,245)
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
            DropdownText.BackgroundColor3 = Color3.fromRGB(245,245,245)
            DropdownText.BackgroundTransparency = 1.000
            DropdownText.BorderSizePixel = 0
            DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
            DropdownText.Size = UDim2.new(0, 184, 0, 38)
            DropdownText.Font = Enum.Font.GothamSemibold
            DropdownText.PlaceholderColor3 = Color3.fromRGB(245,245,245)
            DropdownText.PlaceholderText = text
            DropdownText.Text = ""
            DropdownText.TextColor3 = Color3.fromRGB(245,245,245)
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

local window = library:new("光脚本")
local creds = window:Tab("信息",'6035145364')
local bin = creds:section("信息",true)
    bin:Label("你的注入器:"..identifyexecutor())
    bin:Label("光脚本")
    bin:Label("作者：小光")
    bin:Label("QQ群1028199013")
    bin:Label("QQ1693323219")
    
    -- 显示当前用户名
    bin:Label("用户名: "..game.Players.LocalPlayer.Name)
    
    -- 显示用户ID
    bin:Label("用户ID: "..game.Players.LocalPlayer.UserId)
    
    -- 显示账号年龄（注册天数）
    local accountAge = game.Players.LocalPlayer.AccountAge
    local years = math.floor(accountAge / 365)
    local months = math.floor((accountAge % 365) / 30)
    local days = accountAge % 30
    bin:Label("注册天数: "..accountAge.."天 ("..years.."年"..months.."月"..days.."天)")
    
    -- 显示当前服务器玩家数
    local visitedServers = #game:GetService("Players"):GetPlayers()
    bin:Label("当前服务器玩家数: "..visitedServers)

    -- 节日倒计时核心函数（仅计算天数）
    local function getDayCountdown(targetMonth, targetDay)
        local now = os.date("*t")
        local currentYear = now.year
        local targetDate = os.time({year = currentYear, month = targetMonth, day = targetDay, hour = 0, min = 0, sec = 0})
        local currentTime = os.time(now)
        
        -- 若今年节日已过，计算明年的
        if targetDate < currentTime then
            targetDate = os.time({year = currentYear + 1, month = targetMonth, day = targetDay, hour = 0, min = 0, sec = 0})
        end
        
        local diffSeconds = targetDate - currentTime
        local daysLeft = math.ceil(diffSeconds / 86400) -- 向上取整，确保当天也算1天
        return daysLeft
    end

    -- 常用节日倒计时（仅显示天数）
    bin:Label("=== 『节日倒计时』（剩余天数） ===")
    bin:Label("离元旦还有: "..getDayCountdown(1, 1).."天")
    bin:Label("离春节还有: "..getDayCountdown(2, 10).."天") -- 2025年公历日期
    bin:Label("离情人节还有: "..getDayCountdown(2, 14).."天")
    bin:Label("离清明节还有: "..getDayCountdown(4, 4).."天")
    bin:Label("离劳动节还有: "..getDayCountdown(5, 1).."天")
    bin:Label("离端午节还有: "..getDayCountdown(5, 31).."天") -- 2025年公历日期
    bin:Label("离中秋节还有: "..getDayCountdown(9, 17).."天") -- 2025年公历日期
    bin:Label("离国庆节还有: "..getDayCountdown(10, 1).."天")
    bin:Label("离圣诞节还有: "..getDayCountdown(12, 25).."天")
    
    -- 复制作者QQ
    bin:Button("复制作者QQ", function()
        if setclipboard then
            setclipboard("1693323219")
        end
    end)
    
    -- 复制QQ群
    bin:Button("复制QQ群", function()
        if setclipboard then
            setclipboard("1028199013")
        end
    end)
    
local creds = window:Tab("通用",'6035145364')

local tool = creds:section("通用",true)

tool:Button("祝福语",function()
    local message = "这边小光祝您：生活愉快，笑口常开 事业顺利，步步高升 游戏开心，把把胜利 财源滚滚，好运相伴 身体健康，幸福美满 梦想成真，万事如意"
    
    
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
        if sayMessage then
            sayMessage:FireServer(message, "All")
        end
    end
    
   
    local TextChatService = game:GetService("TextChatService")
    if TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel:SendAsync(message)
            end
        end
    end
    
    print("已发送消息: " .. message)
end)

tool:Slider("步行速度!", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 16, 400, false, function(Speed)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed end end)
end)

tool:Slider("跳跃高度!", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(Jump)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump end end)
end)

tool:Slider("跳跃高度!", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(Jump)
    spawn(function() 
        while task.wait() do 
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump 
        end 
    end)
end)

tool:Slider('设置重力', 'Sliderflag', 196.2, 196.2, 1000, false, function(Value)
    game.Workspace.Gravity = Value
end)

tool:Slider('血量上限', 'Sliderflag',  120, 120, 999999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = Value
end)

tool:Slider('玩家血量', 'Sliderflag',  120, 120, 999999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.Health = Value
end)

tool:Slider("广角", 'Sliderflag', 70, 0.1, 250, false, function(v)
    game.Workspace.CurrentCamera.FieldOfView = v
end)

tool:Toggle("夜视","Toggle",false,function(Value)
if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end
end)

tool:Toggle("无限跳","Toggle",false,function(Value)
        Jump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if Jump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end)
    
tool:Toggle("自动面向敌人","Toggle",false,function(Value)
    if Value then
        -- 开启自动面向敌人
        _G.AutoFaceEnemy = true
        
        -- 获取本地玩家
        local localPlayer = game:GetService("Players").LocalPlayer
        
        -- 检查队伍系统的函数
        local function isEnemy(player)
            -- 如果本地玩家没有队伍，把所有其他玩家都视为敌人
            if not localPlayer.Team then
                return true
            end
            
            -- 如果目标玩家没有队伍，视为敌人
            if not player.Team then
                return true
            end
            
            -- 如果队伍不同，就是敌人
            return localPlayer.Team ~= player.Team
        end
        
        -- 自动面向敌人的循环
        _G.FaceEnemyConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not _G.AutoFaceEnemy or not localPlayer.Character then
                return
            end
            
            local character = localPlayer.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if not humanoidRootPart then
                return
            end
            
            -- 寻找最近的敌对玩家（不同队伍）
            local closestEnemy = nil
            local closestDistance = math.huge
            
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= localPlayer and player.Character and isEnemy(player) then
                    local enemyRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    if enemyRoot then
                        local distance = (enemyRoot.Position - humanoidRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestEnemy = player
                        end
                    end
                end
            end
            
            -- 如果有找到敌人，就面向他
            if closestEnemy and closestEnemy.Character then
                local enemyRoot = closestEnemy.Character:FindFirstChild("HumanoidRootPart")
                if enemyRoot then
                    -- 计算朝向敌人的方向
                    local direction = (enemyRoot.Position - humanoidRootPart.Position).Unit
                    humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + Vector3.new(direction.X, 0, direction.Z))
                end
            end
        end)
        
    else
        -- 关闭自动面向敌人
        _G.AutoFaceEnemy = false
        if _G.FaceEnemyConnection then
            _G.FaceEnemyConnection:Disconnect()
            _G.FaceEnemyConnection = nil
        end
    end
end)

tool:Toggle("穿墙", "NoClip", false, function(NC)
  local Workspace = game:GetService("Workspace") local Players = game:GetService("Players") if NC then Clipon = true else Clipon = false end Stepped = game:GetService("RunService").Stepped:Connect(function() if not Clipon == false then for a, b in pairs(Workspace:GetChildren()) do if b.Name == Players.LocalPlayer.Name then for i, v in pairs(Workspace[Players.LocalPlayer.Name]:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end end else Stepped:Disconnect() end end)
end)

local function createPlayerDropdown()
    local playerList = {}
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    
    tool:Dropdown("选择玩家", "", playerList, function(selectedPlayer)
        if selectedPlayer and selectedPlayer ~= "" then
            playernamedied = selectedPlayer
            print("已选择玩家: " .. selectedPlayer)
        end
    end)
end

createPlayerDropdown()

game:GetService("Players").PlayerAdded:Connect(function(player)
    wait(1)
    createPlayerDropdown()
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    createPlayerDropdown()
end)

tool:Button("传送到玩家旁边", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Notify("小光", "已经传送到玩家身边", "rbxassetid://", 5)
    else
        Notify("小光", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

tool:Button("把玩家传送过来", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        tp_player.Character.HumanoidRootPart.CFrame = HumRoot.CFrame + Vector3.new(0, 3, 0)
        Notify("小光", "已传送过来", "rbxassetid://", 5)
    else
        Notify("小光", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

tool:Toggle("查看玩家", 'Toggleflag', false, function(state)
    if state then
        game:GetService('Workspace').CurrentCamera.CameraSubject =
            game:GetService('Players'):FindFirstChild(playernamedied).Character.Humanoid
            Notify("小光", "已开启", "rbxassetid://", 5)
    else
        Notify("小光", "已关闭", "rbxassetid://", 5)
        local lp = game.Players.LocalPlayer
        game:GetService('Workspace').CurrentCamera.CameraSubject = lp.Character.Humanoid
    end
end)

tool:Button("玩家加入游戏提示",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
end)

tool:Button("刷新玩家列表", function()
    createPlayerDropdown()
end)

tool:Button("聊天绕过",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/BingusWR/Fechatbypassroblox/refs/heads/main/Fe%20Roblox%20ChatBypass"))()
end)

tool:Button("铁拳",function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)

tool:Button("锁定视角", function()
local ShiftlockStarterGui = Instance.new("ScreenGui")
    local ImageButton = Instance.new("ImageButton")
    ShiftlockStarterGui.Name = "Shiftlock (StarterGui)"
    ShiftlockStarterGui.Parent = game.CoreGui
    ShiftlockStarterGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ShiftlockStarterGui.ResetOnSpawn = false

    ImageButton.Parent = ShiftlockStarterGui
    ImageButton.Active = true
    ImageButton.Draggable = true
    ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageButton.BackgroundTransparency = 1.000
    ImageButton.Position = UDim2.new(0.921914339, 0, 0.552375436, 0)
    ImageButton.Size = UDim2.new(0.0636147112, 0, 0.0661305636, 0)
    ImageButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
    ImageButton.Image = "http://www.roblox.com/asset/?id=182223762"

    local function TLQOYN_fake_script()
        local script = Instance.new("LocalScript", ImageButton)
        local MobileCameraFramework = {}
        local Players = game.Players
        local runservice = game:GetService("RunService")
        local CAS = game:GetService("ContextActionService")
        local Player = Players.LocalPlayer
        local character = Player.Character or Player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local humanoid = character.Humanoid
        local camera = workspace.CurrentCamera
        local button = script.Parent
        uis = game:GetService("UserInputService")
        ismobile = uis.TouchEnabled
        button.Visible = ismobile

        local states = {
            OFF = "rbxasset://textures/ui/mouseLock_off@2x.png",
            ON = "rbxasset://textures/ui/mouseLock_on@2x.png"
        }

        local MAX_LENGTH = 900000
        local active = false
        local ENABLED_OFFSET = CFrame.new(1.7, 0, 0)
        local DISABLED_OFFSET = CFrame.new(-1.7, 0, 0)
        local rootPos = Vector3.new(0,0,0)

        local function UpdatePos()
            if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" and Player.Character:FindFirstChildOfClass"Humanoid".RootPart then
                rootPos = Player.Character:FindFirstChildOfClass"Humanoid".RootPart.Position
            end
        end

        local function UpdateImage(STATE)
            button.Image = states[STATE]
        end

        local function UpdateAutoRotate(BOOL)
            if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" then
                Player.Character:FindFirstChildOfClass"Humanoid".AutoRotate = BOOL
            end
        end

        local function GetUpdatedCameraCFrame()
            if game:GetService"Workspace".CurrentCamera then
                return CFrame.new(rootPos, Vector3.new(game:GetService"Workspace".CurrentCamera.CFrame.LookVector.X * MAX_LENGTH, rootPos.Y, game:GetService"Workspace".CurrentCamera.CFrame.LookVector.Z * MAX_LENGTH))
            end
        end

        local function EnableShiftlock()
            UpdatePos()
            UpdateAutoRotate(false)
            UpdateImage("ON")
            if Player.Character and Player.Character:FindFirstChildOfClass"Humanoid" and Player.Character:FindFirstChildOfClass"Humanoid".RootPart then
                Player.Character:FindFirstChildOfClass"Humanoid".RootPart.CFrame = GetUpdatedCameraCFrame()
            end
            if game:GetService"Workspace".CurrentCamera then
                game:GetService"Workspace".CurrentCamera.CFrame = camera.CFrame * ENABLED_OFFSET
            end
        end

        local function DisableShiftlock()
            UpdatePos()
            UpdateAutoRotate(true)
            UpdateImage("OFF")
            if game:GetService"Workspace".CurrentCamera then
                game:GetService"Workspace".CurrentCamera.CFrame = camera.CFrame * DISABLED_OFFSET
            end
            pcall(function()
                active:Disconnect()
                active = nil
            end)
        end

        UpdateImage("OFF")
        active = false

        function ShiftLock()
            if not active then
                active = runservice.RenderStepped:Connect(function()
                    EnableShiftlock()
                end)
            else
                DisableShiftlock()
            end
        end

        local ShiftLockButton = CAS:BindAction("ShiftLOCK", ShiftLock, false, "On")
        CAS:SetPosition("ShiftLOCK", UDim2.new(0.8, 0, 0.8, 0))

        button.MouseButton1Click:Connect(function()
            if not active then
                active = runservice.RenderStepped:Connect(function()
                    EnableShiftlock()
                end)
            else
                DisableShiftlock()
            end
        end)

        return MobileCameraFramework
    end

    coroutine.wrap(TLQOYN_fake_script)()

    local function OMQRQRC_fake_script()
        local script = Instance.new("LocalScript", ShiftlockStarterGui)
        local Players = game.Players
        local UserInputService = game:GetService("UserInputService")
        local Settings = UserSettings()
        local GameSettings = Settings.GameSettings
        local ShiftLockController = {}

        while not Players.LocalPlayer do
            wait()
        end

        local LocalPlayer = Players.LocalPlayer
        local Mouse = LocalPlayer:GetMouse()
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local ScreenGui, ShiftLockIcon, InputCn
        local IsShiftLockMode = true
        local IsShiftLocked = true
        local IsActionBound = false
        local IsInFirstPerson = false

        ShiftLockController.OnShiftLockToggled = Instance.new("BindableEvent")

        local function isShiftLockMode()
            return LocalPlayer.DevEnableMouseLock and GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
        end

        if not UserInputService.TouchEnabled then
            IsShiftLockMode = isShiftLockMode()
        end

        local function onShiftLockToggled()
            IsShiftLocked = not IsShiftLocked
            ShiftLockController.OnShiftLockToggled:Fire()
        end

        local initialize = function()
            print("enabled")
        end

        function ShiftLockController:IsShiftLocked()
            return IsShiftLockMode and IsShiftLocked
        end

        function ShiftLockController:SetIsInFirstPerson(isInFirstPerson)
            IsInFirstPerson = isInFirstPerson
        end

        local function mouseLockSwitchFunc(actionName, inputState, inputObject)
            if IsShiftLockMode then
                onShiftLockToggled()
            end
        end

        local function disableShiftLock()
            if ScreenGui then
                ScreenGui.Parent = nil
            end
            IsShiftLockMode = false
            Mouse.Icon = ""
            if InputCn then
                InputCn:disconnect()
                InputCn = nil
            end
            IsActionBound = false
            ShiftLockController.OnShiftLockToggled:Fire()
        end

        local onShiftInputBegan = function(inputObject, isProcessed)
            if isProcessed then
                return
            end
            if inputObject.UserInputType ~= Enum.UserInputType.Keyboard or inputObject.KeyCode == Enum.KeyCode.LeftShift or inputObject.KeyCode == Enum.KeyCode.RightShift then
            end
        end

        local function enableShiftLock()
            IsShiftLockMode = isShiftLockMode()
            if IsShiftLockMode then
                if ScreenGui then
                    ScreenGui.Parent = PlayerGui
                end
                if IsShiftLocked then
                    ShiftLockController.OnShiftLockToggled:Fire()
                end
                if not IsActionBound then
                    InputCn = UserInputService.InputBegan:connect(onShiftInputBegan)
                    IsActionBound = true
                end
            end
        end

        GameSettings.Changed:connect(function(property)
            if property == "ControlMode" then
                if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
                    enableShiftLock()
                else
                    disableShiftLock()
                end
            elseif property == "ComputerMovementMode" then
                if GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.Default then
                    enableShiftLock()
                else
                    disableShiftLock()
                end
            end
        end)

        LocalPlayer.Changed:connect(function(property)
            if property == "DevComputerMovementMode" then
                if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.KeyboardMouse then
                    enableShiftLock()
                else
                    disableShiftLock()
                end
            elseif property == "DevEnableMouseLock" then
                if LocalPlayer.DevEnableMouseLock then
                    enableShiftLock()
                else
                    disableShiftLock()
                end
            end
        end)

        if isShiftLockMode() then
            enableShiftLock()
        end
    end

    coroutine.wrap(OMQRQRC_fake_script)()
end)

tool:Button("修改数据",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)

-- 时间控制脚本
local Lighting = game:GetService("Lighting")

-- 时间控制
tool:Toggle("时间控制", 'TimeControl', false, function(state)
    if state then
        local currentTime = 12
        
        tool:Slider("时间 (小时)", "", 0, 24, 12, false, function(value)
            currentTime = value
            Lighting.ClockTime = value
        end)
        
        -- 时间循环（可选）
        coroutine.wrap(function()
            while wait(1) do
                if not state then break end
                currentTime = currentTime + 0.1
                if currentTime >= 24 then
                    currentTime = 0
                end
                Lighting.ClockTime = currentTime
            end
        end)()
        
    else
        Lighting.ClockTime = 12
    end
end)

tool:Button("点击传送工具",function()
mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "小光点击传送" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack
end)

tool:Button("坐下",function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not humanoidRootPart then return end
    
    -- 如果已经坐下，则起身
    if humanoid.Sit then
        humanoid.Sit = false
        humanoid.Jump = true
        return
    end
    
    -- 创建完全隐形的座椅
    local invisibleSeat = Instance.new("Seat")
    invisibleSeat.Name = "InvisibleSeat"
    invisibleSeat.Anchored = true
    invisibleSeat.CanCollide = false
    invisibleSeat.Transparency = 1  -- 完全透明
    invisibleSeat.Size = Vector3.new(1, 1, 1)
    
    -- 放置在角色当前位置
    invisibleSeat.CFrame = humanoidRootPart.CFrame * CFrame.new(0, -2.5, 0)
    invisibleSeat.Parent = workspace
    
    -- 强制坐下
    humanoid.Sit = true
    
    -- 将角色传送到隐形座椅
    wait(0.05)
    humanoidRootPart.CFrame = invisibleSeat.CFrame * CFrame.new(0, 1, 0)
    
    -- 起身功能
    local function standUp()
        humanoid.Sit = false
        if invisibleSeat and invisibleSeat.Parent then
            invisibleSeat:Destroy()
        end
    end
    
    -- 监听跳跃键
    local jumpConnection = humanoid.Jumping:Connect(standUp)
    
    -- 监听工具取消选择
    local unequipConnection = tool.Unequipped:Connect(function()
        standUp()
        jumpConnection:Disconnect()
        unequipConnection:Disconnect()
    end)
end)

tool:Button("无头断腿r15",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Permanent-Headless-And-korblox-Script-4140"))()      
end)

tool:Button("无头断腿r6",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/FIXED-Brainrot-Jumping-korblox-R6-a-headless-54182"))()
end)

tool:Button("玩家加入游戏提示",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
end)

tool:Button("吸取全部玩家",function()
    loadstring(game:HttpGet('https://pastebin.com/raw/hQSBGsw2'))()
end)

tool:Button("VR手",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty45.lua"))()
end)

tool:Button("控制玩家",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/wanjiakongzhi"))()
end)

tool:Button("自动弹钢琴",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Tac's-Piano-Stuff-Talentless-script-made-by-hellohellohell012321-44088"))()
end)

tool:Button("吃我一击吧",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/R15%E8%B5%A4%E5%A3%81%E6%88%96%E9%9B%86.txt"))()
end)

tool:Button("秒互动",function()
    game.ProximityPromptService.PromptButtonHoldBegan:Connect(function(v)
        v.HoldDuration = 0
    end)
end)

tool:Button("键盘脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

tool:Button("跟踪玩家",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/F9PNLcXk"))()
end)

tool:Button("换皮肤（需要别人id还需要加入群组Hell_$treet）",function()
  loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\73\110\118\111\111\107\101\114\49\49\47\79\117\116\102\105\116\47\109\97\105\110\47\79\117\116\102\105\116\67\111\112\105\101\114\46\108\117\97\34\44\32\116\114\117\101\41\41\40\41\10")()
end)

tool:Button("无限收益（copyid 输入别人名字获得id可搭配换皮肤使用）",function()
  loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

tool:Button("伪名说话",function()
    loadstring(game:HttpGet(('https://pastefy.ga/zCFEwaYq/raw'),true))()
end)

tool:Button("重新加入游戏", function()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    
    local player = Players.LocalPlayer
    local placeId = game.PlaceId
    local jobId = game.JobId
    
    print("正在重新加入游戏...")
    
    -- 方法1: 使用相同的服务器
    local success, errorMsg = pcall(function()
        TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
    end)
    
    if not success then
        print("重新加入失败:", errorMsg)
        -- 方法2: 重新加入新服务器
        local success2, errorMsg2 = pcall(function()
            TeleportService:Teleport(placeId, player)
        end)
        
        if not success2 then
            print("完全重新加入失败:", errorMsg2)
        end
    end
end)

tool:Button("隐身道具",function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/skid123skidlol/cd0d2dce51b3f20ad1aac941da06a1a1/raw/f58b98cce7d51e53ade94e7bb460e4f24fb7e0ff/%257BFE%257D%2520Invisible%2520Tool%2520(can%2520hold%2520tools)",true))()
end)

tool:Button("回满血",function()
      game.Players.LocalPlayer.Character.Humanoid.Health=10000
end)

tool:Button("无后坐力",function()
    -- 枪械0后坐力脚本（优化版，修复卡顿）
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    
    local player = Players.LocalPlayer
    
    -- 优化性能变量
    local lastCheck = 0
    local checkInterval = 1 -- 1秒检查一次
    local cachedObjects = {}
    local isRunning = true
    
    -- 强制设置后坐力为0（优化性能）
    local function ForceNoRecoil()
        -- 方法1: 轻量级拦截射击函数
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            
            -- 只拦截射击相关函数，减少性能消耗
            if method == "FireServer" then
                local weaponNames = {"Gun", "Weapon", "Rifle", "Pistol", "Shoot", "Fire", "Bullet"}
                local selfName = tostring(self):lower()
                for _, name in pairs(weaponNames) do
                    if selfName:find(name:lower()) then
                        -- 简化参数处理
                        local args = {...}
                        for i = 1, math.min(#args, 5) do -- 只检查前5个参数
                            if type(args[i]) == "number" and math.abs(args[i]) > 0.01 then
                                args[i] = 0
                            end
                        end
                        return oldNamecall(self, unpack(args))
                    end
                end
            end
            
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        
        -- 方法2: 优化后的持续监控（减少CPU使用）
        local recoilConnection
        local frameCount = 0
        recoilConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not isRunning then return end
            
            frameCount = frameCount + 1
            -- 每10帧执行一次，大幅减少性能消耗
            if frameCount % 10 ~= 0 then return end
            
            -- 轻量级重置相机（只在需要时）
            if workspace.CurrentCamera then
                local cameraCF = workspace.CurrentCamera.CFrame
                -- 只检查是否有明显旋转，避免不必要的设置
                local _, _, _, x, y, z = cameraCF:ToEulerAnglesXYZ()
                if math.abs(x) > 0.01 or math.abs(y) > 0.01 or math.abs(z) > 0.01 then
                    workspace.CurrentCamera.CFrame = CFrame.new(cameraCF.Position)
                end
            end
            
            -- 定期清理缓存（减少内存占用）
            lastCheck = lastCheck + deltaTime
            if lastCheck >= checkInterval then
                lastCheck = 0
                -- 只检查新对象，避免重复处理
                for _, obj in pairs(game:GetDescendants()) do
                    if not cachedObjects[obj] and (obj:IsA("NumberValue") or obj:IsA("Vector3Value")) then
                        local name = obj.Name:lower()
                        if name:find("recoil") or name:find("kick") or name:find("shake") then
                            if obj:IsA("NumberValue") then
                                obj.Value = 0
                            elseif obj:IsA("Vector3Value") then
                                obj.Value = Vector3.new(0, 0, 0)
                            end
                            cachedObjects[obj] = true
                        end
                    end
                end
                
                -- 清理无效的缓存对象
                for obj in pairs(cachedObjects) do
                    if not obj.Parent then
                        cachedObjects[obj] = nil
                    end
                end
            end
        end)
        
        -- 方法3: 事件驱动的后坐力消除（最高效）
        local inputConnection
        inputConnection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                -- 只在射击时处理，减少不必要的计算
                spawn(function()
                    -- 延迟处理，避免阻塞主线程
                    wait(0.01)
                    if player.Character then
                        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.CameraOffset = Vector3.new(0, 0, 0)
                        end
                    end
                end)
            end
        end)
        
        -- 方法4: 武器装备时预设置
        local function setupWeapon(tool)
            if tool and tool:IsA("Tool") then
                -- 一次性设置武器参数
                for _, descendant in pairs(tool:GetDescendants()) do
                    if descendant:IsA("NumberValue") then
                        local name = descendant.Name:lower()
                        if name:find("recoil") or name:find("spread") then
                            descendant.Value = 0
                        end
                    end
                end
            end
        end
        
        -- 监听武器装备
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    setupWeapon(tool)
                    tool.Equipped:Connect(function()
                        setupWeapon(tool)
                    end)
                end
            end
            
            backpack.ChildAdded:Connect(function(tool)
                if tool:IsA("Tool") then
                    wait(0.1) -- 等待工具加载完成
                    setupWeapon(tool)
                end
            end)
        end
        
        print("0后坐力模式已激活 - 优化性能，无卡顿")
        
        -- 返回断开连接的函数
        return function()
            isRunning = false
            if recoilConnection then
                recoilConnection:Disconnect()
            end
            if inputConnection then
                inputConnection:Disconnect()
            end
            -- 恢复原metatable
            setreadonly(mt, false)
            mt.__namecall = oldNamecall
            setreadonly(mt, true)
            cachedObjects = {}
            print("无后坐力功能已关闭")
        end
    end
    
    -- 执行无后坐力
    local disconnectFunction = ForceNoRecoil()
    
    -- 添加性能监控
    spawn(function()
        while task.wait(5) do
            if isRunning then
                print("无后坐力功能运行中 - 性能稳定")
            end
        end
    end)
end)

tool:Button("无限子弹",function()
    -- 无限子弹脚本（优化性能，修复卡顿）
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    local player = Players.LocalPlayer
    local isRunning = true
    
    -- 性能优化变量
    local lastCacheClean = 0
    local cacheCleanInterval = 5
    local cachedAmmoObjects = {}
    local frameCounter = 0
    local processedModules = {}
    
    -- 优化后的无限子弹功能
    local function OptimizedInfiniteAmmo()
        -- 方法1: 轻量级拦截弹药消耗（减少重复调用）
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            
            -- 只拦截明确的弹药消耗调用
            if method == "InvokeServer" or method == "FireServer" then
                local eventName = tostring(self):lower()
                local criticalAmmoKeywords = {"ammo", "bullet", "magazine", "clip", "reload"}
                
                for _, keyword in pairs(criticalAmmoKeywords) do
                    if eventName:find(keyword) then
                        -- 直接返回成功，不执行实际消耗
                        return true
                    end
                end
            end
            
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        
        -- 方法2: 智能弹药监控（大幅减少循环频率）
        local ammoConnection
        ammoConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not isRunning then return end
            
            frameCounter += 1
            -- 每60帧执行一次，大幅减少性能消耗
            if frameCounter % 60 ~= 0 then return end
            
            lastCacheClean += deltaTime
            
            -- 只处理新发现的弹药对象
            for _, obj in pairs(game:GetDescendants()) do
                if not cachedAmmoObjects[obj] then
                    local objName = tostring(obj):lower()
                    local parentName = obj.Parent and tostring(obj.Parent):lower() or ""
                    
                    -- 精确检测弹药相关对象
                    local isAmmoRelated = (objName:find("ammo") and not objName:find("camera")) or 
                                         (objName:find("bullet") and not objName:find("hole")) or
                                         objName:find("magazine") or 
                                         objName:find("clip") or
                                         (objName:find("capacity") and (parentName:find("gun") or parentName:find("weapon")))
                    
                    if isAmmoRelated then
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            if obj.Value < 10 then -- 只在弹药不足时设置
                                obj.Value = 999
                            end
                            cachedAmmoObjects[obj] = true
                        elseif obj:IsA("StringValue") and obj.Value:lower():find("empty") then
                            obj.Value = "Full"
                            cachedAmmoObjects[obj] = true
                        elseif obj:IsA("BoolValue") and obj.Name:find("Empty") then
                            obj.Value = false
                            cachedAmmoObjects[obj] = true
                        end
                    end
                end
            end
            
            -- 定期清理无效缓存（减少内存占用）
            if lastCacheClean >= cacheCleanInterval then
                lastCacheClean = 0
                for obj in pairs(cachedAmmoObjects) do
                    if not obj.Parent then
                        cachedAmmoObjects[obj] = nil
                    end
                end
            end
        end)
        
        -- 方法3: 事件驱动的武器设置（减少持续监控）
        local function setupWeapon(tool)
            if tool and tool:IsA("Tool") then
                spawn(function()
                    task.wait(0.1) -- 延迟处理避免卡顿
                    
                    -- 一次性设置武器所有弹药参数
                    for _, descendant in pairs(tool:GetDescendants()) do
                        if descendant:IsA("IntValue") or descendant:IsA("NumberValue") then
                            local name = descendant.Name:lower()
                            if name:find("ammo") or name:find("bullet") or name:find("capacity") then
                                descendant.Value = 999
                                cachedAmmoObjects[descendant] = true
                            end
                        elseif descendant:IsA("RemoteEvent") then
                            local eventName = descendant.Name:lower()
                            if eventName:find("reload") then
                                -- 轻量级重新装弹拦截
                                local oldFire = descendant.FireServer
                                descendant.FireServer = function(self, ...)
                                    return true
                                end
                            end
                        end
                    end
                end)
            end
        end
        
        -- 方法4: 分批处理现有武器（避免一次性卡顿）
        local function setupExistingWeapons()
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                local weapons = {}
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        table.insert(weapons, tool)
                    end
                end
                
                -- 分批处理武器，每批间隔0.1秒
                for i, weapon in ipairs(weapons) do
                    spawn(function()
                        task.wait(i * 0.1)
                        setupWeapon(weapon)
                    end)
                end
            end
        end
        
        -- 初始设置现有武器
        setupExistingWeapons()
        
        -- 监听新武器（延迟处理）
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            backpack.ChildAdded:Connect(function(tool)
                if tool:IsA("Tool") then
                    wait(0.3) -- 等待武器完全加载
                    setupWeapon(tool)
                end
            end)
        end
        
        -- 监听角色武器
        player.CharacterAdded:Connect(function(character)
            wait(1.5) -- 等待角色完全加载
            for _, tool in pairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    setupWeapon(tool)
                end
            end
        end)
        
        -- 方法5: 延迟模块处理（减少即时计算）
        spawn(function()
            task.wait(3) -- 延迟3秒后处理模块
            for _, module in pairs(game:GetDescendants()) do
                if module:IsA("ModuleScript") and not processedModules[module] then
                    processedModules[module] = true
                    pcall(function()
                        local mod = require(module)
                        if type(mod) == "table" then
                            for key, value in pairs(mod) do
                                if type(key) == "string" and type(value) == "number" then
                                    local keyLower = key:lower()
                                    if keyLower:find("ammo") or keyLower:find("capacity") then
                                        if value < 100 then
                                            mod[key] = 999
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(0.05) -- 模块间延迟
                end
            end
        end)
        
        print("优化无限子弹已激活 - 高性能无卡顿")
        
        -- 返回断开连接的函数
        return function()
            isRunning = false
            
            if ammoConnection then
                ammoConnection:Disconnect()
            end
            
            -- 恢复原metatable
            setreadonly(mt, false)
            mt.__namecall = oldNamecall
            setreadonly(mt, true)
            
            cachedAmmoObjects = {}
            processedModules = {}
            print("无限子弹功能已关闭")
        end
    end
    
    -- 执行优化后的无限子弹
    local disconnectFunction = OptimizedInfiniteAmmo()
    
    -- 轻量级状态监控
    spawn(function()
        while task.wait(15) and isRunning do
            print("无限子弹运行中 - 性能稳定")
        end
    end)
end)

tool:Button("快速射击",function()
    -- 极限快速射击脚本（优化性能，修复卡顿）
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    
    local player = Players.LocalPlayer
    local isRunning = true
    local fireRateMultiplier = 50 -- 降低倍率减少卡顿
    
    -- 性能优化变量
    local lastWeaponCheck = 0
    local weaponCheckInterval = 2
    local cachedWeapons = {}
    local frameCounter = 0
    
    -- 优化后的快速射击功能
    local function OptimizedFastFire()
        -- 方法1: 智能拦截射击函数（减少重复调用）
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall
        local activeWeapons = {}
        
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            -- 只处理射击相关调用，避免性能浪费
            if method == "FireServer" or method == "InvokeServer" then
                local selfName = tostring(self):lower()
                local weaponKeywords = {"fire", "shoot", "bullet", "gun", "weapon"}
                
                for _, keyword in pairs(weaponKeywords) do
                    if selfName:find(keyword) then
                        -- 限制同一武器的快速射击频率
                        if not activeWeapons[self] then
                            activeWeapons[self] = true
                            
                            -- 使用更温和的快速射击循环
                            spawn(function()
                                local shotCount = 0
                                while isRunning and activeWeapons[self] and shotCount < fireRateMultiplier do
                                    pcall(function()
                                        oldNamecall(self, unpack(args))
                                    end)
                                    shotCount += 1
                                    -- 增加延迟减少卡顿
                                    if shotCount % 10 == 0 then
                                        task.wait(0.01) -- 增加延迟时间
                                    end
                                end
                                activeWeapons[self] = nil
                            end)
                        end
                        return true
                    end
                end
            end
            
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
        
        -- 方法2: 优化武器参数修改（减少循环频率）
        local weaponConnection
        weaponConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if not isRunning then return end
            
            frameCounter += 1
            -- 每30帧执行一次，大幅减少CPU使用
            if frameCounter % 30 ~= 0 then return end
            
            lastWeaponCheck += deltaTime
            if lastWeaponCheck >= weaponCheckInterval then
                lastWeaponCheck = 0
                
                -- 只处理新发现的武器对象
                for _, obj in pairs(game:GetDescendants()) do
                    if not cachedWeapons[obj] and obj:IsA("NumberValue") then
                        local name = obj.Name:lower()
                        local timeKeywords = {"firerate", "firedelay", "cooldown"}
                        
                        for _, keyword in pairs(timeKeywords) do
                            if name:find(keyword) then
                                if obj.Value > 0.05 then -- 只修改较大的延迟值
                                    obj.Value = 0.05 -- 设置为合理的最小值
                                end
                                cachedWeapons[obj] = true
                                break
                            end
                        end
                    end
                end
                
                -- 清理无效缓存
                for obj in pairs(cachedWeapons) do
                    if not obj.Parent then
                        cachedWeapons[obj] = nil
                    end
                end
            end
        end)
        
        -- 方法3: 事件驱动的自动射击（减少持续计算）
        local autoFireConnection
        local isMouseDown = false
        local lastShotTime = 0
        local minShotInterval = 0.033 -- 约30FPS，避免过度射击
        
        autoFireConnection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isMouseDown = true
                
                -- 使用更温和的自动射击
                spawn(function()
                    while isMouseDown and isRunning do
                        local currentTime = tick()
                        if currentTime - lastShotTime >= minShotInterval then
                            pcall(function()
                                -- 只触发主要的射击事件，减少重复调用
                                for _, obj in pairs(game:GetDescendants()) do
                                    if obj:IsA("RemoteEvent") then
                                        local name = obj.Name:lower()
                                        if (name:find("fire") or name:find("shoot")) and not name:find("reload") then
                                            obj:FireServer()
                                            break -- 只触发一个主要事件
                                        end
                                    end
                                end
                            end)
                            lastShotTime = currentTime
                        end
                        task.wait(0.016) -- 约60FPS的延迟
                    end
                end)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isMouseDown = false
            end
        end)
        
        -- 方法4: 延迟加载模块修改（减少即时计算）
        local moduleConnection
        local modulesProcessed = {}
        
        moduleConnection = RunService.Heartbeat:Connect(function()
            if not isRunning then return end
            
            -- 每5秒检查一次新模块
            if tick() % 5 > 0.1 then return end
            
            for _, module in pairs(game:GetDescendants()) do
                if module:IsA("ModuleScript") and not modulesProcessed[module] then
                    modulesProcessed[module] = true
                    
                    -- 使用延迟处理避免卡顿
                    spawn(function()
                        task.wait(0.1) -- 延迟处理
                        pcall(function()
                            local mod = require(module)
                            if type(mod) == "table" then
                                for key, value in pairs(mod) do
                                    if type(key) == "string" and type(value) == "number" then
                                        local keyLower = key:lower()
                                        if (keyLower:find("firerate") or keyLower:find("cooldown")) and value > 0.1 then
                                            mod[key] = 0.05 -- 合理的最小值
                                        end
                                    end
                                end
                            end
                        end)
                    end)
                end
            end
        end)
        
        -- 方法5: 武器装备时批量优化（减少实时计算）
        local function optimizeWeapon(tool)
            if tool and tool:IsA("Tool") then
                spawn(function()
                    task.wait(0.05) -- 延迟处理
                    for _, descendant in pairs(tool:GetDescendants()) do
                        if descendant:IsA("NumberValue") then
                            local name = descendant.Name:lower()
                            if name:find("delay") or name:find("rate") or name:find("cooldown") then
                                if descendant.Value > 0.05 then
                                    descendant.Value = 0.05
                                end
                            end
                        end
                    end
                end)
            end
        end
        
        -- 设置现有武器（分批处理）
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            -- 分批处理现有武器
            for i, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    spawn(function()
                        task.wait(i * 0.1) -- 分批延迟处理
                        optimizeWeapon(tool)
                    end)
                end
            end
            
            
            backpack.ChildAdded:Connect(function(tool)
                if tool:IsA("Tool") then
                    wait(0.2)
                    optimizeWeapon(tool)
                end
            end)
        end
        
        print("小光yyds")
        
       
        return function()
            isRunning = false
            isMouseDown = false
            activeWeapons = {}
            
            if weaponConnection then
                weaponConnection:Disconnect()
            end
            if autoFireConnection then
                autoFireConnection:Disconnect()
            end
            if moduleConnection then
                moduleConnection:Disconnect()
            end
            
            setreadonly(mt, false)
            mt.__namecall = oldNamecall
            setreadonly(mt, true)
            
            print("🤫🤫🤫🤫")
        end
    end
    
 
    local disconnectFunction = OptimizedFastFire()
    
    
    spawn(function()
        while task.wait(10) and isRunning do
            print("小光快速射击")
        end
    end)
end)

tool:Button("驰甩飞",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/冬甩飞.lua"))()
end)

tool:Button("操b脚本", function()
  local SimpleSexGUI = Instance.new("ScreenGui") local FGUI = Instance.new("Frame") local btnNaked = Instance.new("TextButton") local btnSex = Instance.new("TextButton") local tbxVictim = Instance.new("TextBox") local lblFUCKEMALL = Instance.new("TextLabel") local ImageLabel = Instance.new("ImageLabel") local lbltitle = Instance.new("TextLabel") local TextLabel = Instance.new("TextLabel") SimpleSexGUI.Name = "SimpleSexGUI" SimpleSexGUI.Parent = game.CoreGui FGUI.Name = "FGUI" FGUI.Parent = SimpleSexGUI FGUI.BackgroundColor3 = Color3.new(255,255,255) FGUI.BorderSizePixel = 1 FGUI.Position = UDim2.new(0,0, 0.667, 0) FGUI.Size = UDim2.new(0,317, 0,271) FGUI.Draggable = true lbltitle.Name = "Title" lbltitle.Parent = FGUI lbltitle.BackgroundColor3 = Color3.new(255,255,255) lbltitle.BorderSizePixel = 1 lbltitle.Position = UDim2.new (0, 0,-0.122, 0) lbltitle.Size = UDim2.new (0, 317,0, 33) lbltitle.Visible = true lbltitle.Active = true lbltitle.Draggable = false lbltitle.Selectable = true lbltitle.Font = Enum.Font.SourceSansBold lbltitle.Text = "操到流液体" lbltitle.TextColor3 = Color3.new(0, 0, 0) lbltitle.TextSize = 20 btnSex.Name = "Sex" btnSex.Parent = FGUI btnSex.BackgroundColor3 = Color3.new(255,255,255) btnSex.BorderSizePixel = 1 btnSex.Position = UDim2.new (0.044, 0,0.229, 0) btnSex.Size = UDim2.new (0, 99,0, 31) btnSex.Visible = true btnSex.Active = true btnSex.Draggable = false btnSex.Selectable = true btnSex.Font = Enum.Font.SourceSansBold btnSex.Text = "小光银河射线" btnSex.TextColor3 = Color3.new(0, 0, 0) btnSex.TextSize = 20 tbxVictim.Name = "VictimTEXT" tbxVictim.Parent = FGUI tbxVictim.BackgroundColor3 = Color3.new(255,255,255) tbxVictim.BorderSizePixel = 1 tbxVictim.Position = UDim2.new (0.533, 0,0.229, 0) tbxVictim.Size = UDim2.new (0, 133,0, 27) tbxVictim.Visible = true tbxVictim.Active = true tbxVictim.Draggable = false tbxVictim.Selectable = true tbxVictim.Font = Enum.Font.SourceSansBold tbxVictim.Text = "女主" tbxVictim.TextColor3 = Color3.new(0, 0, 0) tbxVictim.TextSize = 20 lblFUCKEMALL.Name = "FUCKEMALL" lblFUCKEMALL.Parent = FGUI lblFUCKEMALL.BackgroundColor3 = Color3.new(255,255,255) lblFUCKEMALL.BorderSizePixel = 1 lblFUCKEMALL.Position = UDim2.new (0.025, 0,0.856, 0) lblFUCKEMALL.Size = UDim2.new (0, 301,0, 27) lblFUCKEMALL.Visible = true lblFUCKEMALL.Font = Enum.Font.SourceSansBold lblFUCKEMALL.Text = "操逼" lblFUCKEMALL.TextColor3 = Color3.new(0, 0, 0) lblFUCKEMALL.TextSize = 20 ImageLabel.Name = "ImageLabel" ImageLabel.Parent = FGUI ImageLabel.Image = "http://www.roblox.com/asset/?id=42837..." ImageLabel.BorderSizePixel = 1 ImageLabel.Position = UDim2.new (0.274, 0,0.358, 0) ImageLabel.Size = UDim2.new (0, 106,0, 121) btnSex.MouseButton1Click:Connect(function() local player = tbxVictim.Text local stupid = Instance.new('Animation') stupid.AnimationId = 'rbxassetid://148840371' hummy = game:GetService("Players").LocalPlayer.Character.Humanoid pcall(function() hummy.Parent.Pants:Destroy() end) pcall(function() hummy.Parent.Shirt:Destroy() end) local notfunny = hummy:LoadAnimation(stupid) notfunny:Play() notfunny:AdjustSpeed(10) while hummy.Parent.Parent ~= nil do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tbxVictim.Text].Character.HumanoidRootPart.CFrame end end)
end)

tool:Button("子弹追踪",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/1AJ69eRG"))()
end)

tool:Button("获取所有玩家道具",function()
  for i,v in pairs(game.Players:GetChildren()) do
    wait()
    for i,b in pairs(v.Backpack:GetChildren()) do
      b.Parent = game.Players.LocalPlayer.Backpack
    end
  end
end)

tool:Button("驰飞行",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E9%A9%B0%E9%A3%9E%E8%A1%8C.lua"))()
end)

tool:Button("FPS[变流畅]",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gclich/FPS-X-GUI/main/FPS_X.lua"))()
end)

tool:Button("解帧",function()
loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-FpsBoost-9260"))()
end)

tool:Button("fps显示",function()
loadstring(game:HttpGet("https://pastefy.app/d9j82YJr/raw",true))()
end)

tool:Button("情云同款自瞄可调", function()
  local fov = 100 local smoothness = 10 local crosshairDistance = 5 local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local Players = game:GetService("Players") local Cam = game.Workspace.CurrentCamera local FOVring = Drawing.new("Circle") FOVring.Visible = true FOVring.Thickness = 2 FOVring.Color = Color3.fromRGB(0, 255, 0) FOVring.Filled = false FOVring.Radius = fov FOVring.Position = Cam.ViewportSize / 2 local Player = Players.LocalPlayer local PlayerGui = Player:WaitForChild("PlayerGui") local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "FovAdjustGui" ScreenGui.Parent = PlayerGui local Frame = Instance.new("Frame") Frame.Name = "MainFrame" Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) Frame.BorderColor3 = Color3.fromRGB(128, 0, 128) Frame.BorderSizePixel = 2 Frame.Position = UDim2.new(0.3, 0, 0.3, 0) Frame.Size = UDim2.new(0.4, 0, 0.4, 0) Frame.Active = true Frame.Draggable = true Frame.Parent = ScreenGui local MinimizeButton = Instance.new("TextButton") MinimizeButton.Name = "MinimizeButton" MinimizeButton.Text = "-" MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255) MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) MinimizeButton.Position = UDim2.new(0.9, 0, 0, 0) MinimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0) MinimizeButton.Parent = Frame local isMinimized = false MinimizeButton.MouseButton1Click:Connect(function() isMinimized = not isMinimized if isMinimized then Frame:TweenSize(UDim2.new(0.1, 0, 0.1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true) MinimizeButton.Text = "+" else Frame:TweenSize(UDim2.new(0.4, 0, 0.4, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true) MinimizeButton.Text = "-" end end) local FovLabel = Instance.new("TextLabel") FovLabel.Name = "FovLabel" FovLabel.Text = "自瞄范围" FovLabel.TextColor3 = Color3.fromRGB(255, 255, 255) FovLabel.BackgroundTransparency = 1 FovLabel.Position = UDim2.new(0.1, 0, 0.1, 0) FovLabel.Size = UDim2.new(0.8, 0, 0.2, 0) FovLabel.Parent = Frame local FovSlider = Instance.new("TextBox") FovSlider.Name = "FovSlider" FovSlider.Text = tostring(fov) FovSlider.TextColor3 = Color3.fromRGB(255, 255, 255) FovSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) FovSlider.Position = UDim2.new(0.1, 0, 0.3, 0) FovSlider.Size = UDim2.new(0.8, 0, 0.2, 0) FovSlider.Parent = Frame local SmoothnessLabel = Instance.new("TextLabel") SmoothnessLabel.Name = "SmoothnessLabel" SmoothnessLabel.Text = "自瞄平滑度" SmoothnessLabel.TextColor3 = Color3.fromRGB(255, 255, 255) SmoothnessLabel.BackgroundTransparency = 1 SmoothnessLabel.Position = UDim2.new(0.1, 0, 0.5, 0) SmoothnessLabel.Size = UDim2.new(0.8, 0, 0.2, 0) SmoothnessLabel.Parent = Frame local SmoothnessSlider = Instance.new("TextBox") SmoothnessSlider.Name = "SmoothnessSlider" SmoothnessSlider.Text = tostring(smoothness) SmoothnessSlider.TextColor3 = Color3.fromRGB(255, 255, 255) SmoothnessSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) SmoothnessSlider.Position = UDim2.new(0.1, 0, 0.7, 0) SmoothnessSlider.Size = UDim2.new(0.8, 0, 0.2, 0) SmoothnessSlider.Parent = Frame local CrosshairDistanceLabel = Instance.new("TextLabel") CrosshairDistanceLabel.Name = "CrosshairDistanceLabel" CrosshairDistanceLabel.Text = "自瞄预判距离" CrosshairDistanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255) CrosshairDistanceLabel.BackgroundTransparency = 1 CrosshairDistanceLabel.Position = UDim2.new(0.1, 0, 0.9, 0) CrosshairDistanceLabel.Size = UDim2.new(0.8, 0, 0.2, 0) CrosshairDistanceLabel.Parent = Frame local CrosshairDistanceSlider = Instance.new("TextBox") CrosshairDistanceSlider.Name = "CrosshairDistanceSlider" CrosshairDistanceSlider.Text = tostring(crosshairDistance) CrosshairDistanceSlider.TextColor3 = Color3.fromRGB(255, 255, 255) CrosshairDistanceSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50) CrosshairDistanceSlider.Position = UDim2.new(0.1, 0, 1.1, 0) CrosshairDistanceSlider.Size = UDim2.new(0.8, 0, 0.2, 0) CrosshairDistanceSlider.Parent = Frame local targetCFrame = Cam.CFrame local function updateDrawings() local camViewportSize = Cam.ViewportSize FOVring.Position = camViewportSize / 2 FOVring.Radius = fov end local function onKeyDown(input) if input.KeyCode == Enum.KeyCode.Delete then RunService:UnbindFromRenderStep("FOVUpdate") FOVring:Remove() end end UserInputService.InputBegan:Connect(onKeyDown) local function getClosestPlayerInFOV(trg_part) local nearest = nil local last = math.huge local playerMousePos = Cam.ViewportSize / 2 for _, player in ipairs(Players:GetPlayers()) do if player ~= Players.LocalPlayer then local part = player.Character and player.Character:FindFirstChild(trg_part) if part then local ePos, isVisible = Cam:WorldToViewportPoint(part.Position) local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude if distance < last and isVisible and distance < fov then last = distance nearest = player end end end end return nearest end RunService.RenderStepped:Connect(function() updateDrawings() local closest = getClosestPlayerInFOV("Head") if closest and closest.Character:FindFirstChild("Head") then local targetCharacter = closest.Character local targetHead = targetCharacter.Head local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart") local isMoving = targetRootPart.Velocity.Magnitude > 0.1 local targetPosition if isMoving then targetPosition = targetHead.Position + (targetHead.CFrame.LookVector * crosshairDistance) else targetPosition = targetHead.Position end targetCFrame = CFrame.new(Cam.CFrame.Position, targetPosition) else targetCFrame = Cam.CFrame end Cam.CFrame = Cam.CFrame:Lerp(targetCFrame, 1 / smoothness) end) FovSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newFov = tonumber(FovSlider.Text) if newFov then fov = newFov else FovSlider.Text = tostring(fov) end end end) SmoothnessSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newSmoothness = tonumber(SmoothnessSlider.Text) if newSmoothness then smoothness = newSmoothness else SmoothnessSlider.Text = tostring(smoothness) end end end) CrosshairDistanceSlider.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss) if enterPressed then local newCrosshairDistance = tonumber(CrosshairDistanceSlider.Text) if newCrosshairDistance then crosshairDistance = newCrosshairDistance else CrosshairDistanceSlider.Text = tostring(crosshairDistance) end end end)
end)

tool:Button("控制npc",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau"))()
end)

tool:Button("自杀",function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

tool:Button("驰飞车",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E9%A9%B0%E9%A3%9E%E8%BD%A6.lua"))()
end)

tool:Button("获得管理员权限",function()
loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
end)

tool:Button("爬墙",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

tool:Toggle("自动互动", "Auto Interact", false, function(state)
    if state then
        autoInteract = true
        while autoInteract do
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    fireproximityprompt(descendant)
                end
            end
            task.wait(0.25) -- Adjust the wait time as needed
        end
    else
        autoInteract = false
    end
end)

local creds = window:Tab("FE",'6035145364')

local tool = creds:section("FE",true)

tool:Button("FE C00lgui", function()
    loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)

tool:Button("FE 1x1x1x1", function()
    loadstring(game:HttpGet(('https://pastebin.com/raw/JipYNCht'),true))()
end)

tool:Button("FE 蜘蛛侠", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E5%A4%B1%E8%B4%A5%E7%9A%84%E6%85%A2.txt"))()
end)

tool:Button("FE大长腿", function()
    loadstring(game:HttpGet('https://gist.githubusercontent.com/1BlueCat/7291747e9f093555573e027621f08d6e/raw/23b48f2463942befe19d81aa8a06e3222996242c/FE%2520Da%2520Feets'))()
end)

tool:Button("FE用头", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/BK4Q0DfU"))()
end)

tool:Button("复仇者", function()
    loadstring(game:HttpGet(('https://pastefy.ga/iGyVaTvs/raw'),true))()
end)

tool:Button("鼠标", function()
    loadstring(game:HttpGet(('https://pastefy.ga/V75mqzaz/raw'),true))()
end)

tool:Button("变怪物", function()
    loadstring(game:HttpGetAsync("https://pastebin.com/raw/jfryBKds"))()
end)

tool:Button("香蕉枪", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/BananaGunByNerd.lua"))()
end)

tool:Button("超长鸡巴", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ESWSFND7", true))()
end)

tool:Button("操人", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/AHAJAJAKAK/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A/A.LUA", true))()
end)

tool:Button("FE动画中心", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
end)

tool:Button("FE变玩家", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/XR4sGcgJ"))()
end)

tool:Button("FE猫娘R63", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua"))()
end)

tool:Button("FE", function()
    loadstring(game:HttpGet('https://pastefy.ga/a7RTi4un/raw'))()
end)

local creds = window:Tab("音乐",'6035145364')

local tool = creds:section("😏😏",true)

tool:Button("关闭音乐", function()
    for _, sound in pairs(game.Workspace:GetChildren()) do
        if sound:IsA("Sound") then
            sound:Stop()
            sound:Destroy()
        end
    end
end)

tool:Button("🇨🇳义勇军进行曲🇨🇳", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1845918434"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("牢大", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://99519218846428"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("挺燃的音乐", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://99409598156364"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("恐怖音乐", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://755443523226610"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("男娘专听", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6797864253"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("刀马", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://98337901681441"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("雨中女郎", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://168311083931"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("生活小妙招", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://121336636707861"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("阳光彩虹小白马", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://94625860335523"
    sound.Parent = game.Workspace
    sound:Play()
end)

tool:Button("植物大战僵尸",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://158260415" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("早安越南",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8295016126" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("愤怒芒西 Evade?",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://5029269312" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("梅西",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://7354576319" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("永春拳",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1845973140" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("带劲的音乐",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://18841891575" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("韩国国歌",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1837478300" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
      tool:Button("哥哥你女朋友不会吃醋吧?",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8715811379" 
     sound.Parent = game.Workspace 
     sound:Play()  
     end) 
      tool:Button("蜘蛛侠出场声音",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://9108472930" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
      tool:Button("消防车",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://317455930" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
      tool:Button("万圣节1🎃",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1837467198" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end)
     
   tool:Button("好听的",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1844125168" 
     sound.Parent = game.Workspace 
     sound:Play()
     end) 
 tool:Button("国外音乐脚本",function()          
 loadstring(game:HttpGet(('https://pastebin.com/raw/g97RafnE'),true))()                   
end) 
   tool:Button("国歌[Krx版]",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://1845918434" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("妈妈生的",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6689498326" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("Music Ball-CTT",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://9045415830" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("电音",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6911766512" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("梗合集",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://8161248815" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("Its been so long",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://6913550990" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end) 
   tool:Button("Baller",function() 
         local sound = Instance.new("Sound") 
     sound.SoundId = "rbxassetid://13530439660" 
     sound.Parent = game.Workspace 
     sound:Play() 
     end)

local creds = window:Tab("俄亥俄",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("查找放下来印钞机","", false, function(v)
czycj = v
if czycj then
while czycj and wait() do
local Players=game:GetService("Players")local localPlayer=Players.LocalPlayer local droppables=workspace.Game.Local.droppables if droppables and droppables:FindFirstChild("Money Printer")then local unusualMoneyPrinter=droppables:FindFirstChild("Money Printer")for _,child in pairs(unusualMoneyPrinter:GetChildren())do if child:IsA("MeshPart")then local humanoidRootPart=localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")if humanoidRootPart then humanoidRootPart.CFrame=CFrame.new(child.Position)end end end end
end
end
end)
tool:Toggle("自动拾取材料", "auto", false, function(v)
autocl = v
end)
tool:Toggle("自动拾取宝石", "auto", false, function(v)
autobs = v
if autobs then
while autobs and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Amethyst" or e.ObjectText == "Sapphire" or e.ObjectText == "Emerald"  or e.ObjectText == "Topaz"  or e.ObjectText == "Ruby"  or e.ObjectText == "Diamond Ring"  or e.ObjectText == "Diamond" or e.ObjectText == "Void Gem" or e.ObjectText == "Dark Matter Gem" or e.ObjectText == "Rollie" then
                                for _, obj in ipairs(workspace.BankRobbery.VaultDoor:GetDescendants()) do
                                if obj:IsA("ProximityPrompt") then
                                if (obj.Parent.Position - rootPart.Position).Magnitude > 35 then
                                obj.RequiresLineOfSight = false
                                obj.HoldDuration = 0
                                fireproximityprompt(obj)
                                end
                                end
                                end
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)

tool:Toggle("自动拾取气球", "auto", false, function(v)
autoqq = v
if autoqq then
while autoqq and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Bunny Balloon" or e.ObjectText == "Ghost Balloon" or e.ObjectText == "Clover Balloon" or e.ObjectText == "Bat Balloon" or e.ObjectText == "Gold Clover Balloon" or e.ObjectText == "Golden Rose" or e.ObjectText == "Black Rose" or e.ObjectText == "Heart Balloon" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)
tool:Toggle("自动拾取蓝色糖果棒", "auto", false, function(v)
autoblue = v
if autoblue then
while autoblue and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Blue Candy Cane" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)

tool:Toggle("自动拾取顶级物品", "auto", false, function(v)
autodj = v
if autodj then
while autodj and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Suitcase Nuke" or e.ObjectText == "Nuke Launcher" or e.ObjectText == "Easter Basket" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)
tool:Toggle("自动拾取金条", "auto", false, function(v)
autojt = v
if autojt then
while autojt and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" and e.ObjectText == "Gold Bar" then
                                for _, obj in ipairs(workspace.BankRobbery.VaultDoor:GetDescendants()) do
                                if obj:IsA("ProximityPrompt") then
                                if (obj.Parent.Position - rootPart.Position).Magnitude > 35 then
                                obj.RequiresLineOfSight = false
                                obj.HoldDuration = 0
                                fireproximityprompt(obj)
                                end
                                end
                                end
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)

tool:Toggle("自动拾取红卡", "auto", false, function(v)
autohk = v
if autohk then
while autohk and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Military Armory Keycard" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)
tool:Toggle("自动拾取印钞机", "auto", false, function(v)
automn = v
if automn then
while automn and wait() do
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if rootPart then
            for _, l in pairs(game:GetService("Workspace").Game.Entities.ItemPickup:GetChildren()) do
                for _, v in pairs(l:GetChildren()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                        for _, e in pairs(v:GetChildren()) do
                            if e.ClassName == "ProximityPrompt" then
                                if e.ObjectText == "Money Printer" then
                                local itemCFrame = v.CFrame
                                rootPart.CFrame = itemCFrame * CFrame.new(0, 2, 0)
                                e.RequiresLineOfSight = false
                                e.HoldDuration = 0
                                wait(0.1)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                fireproximityprompt(e)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end
end)

tool:Button("俄亥俄州1英",function()
loadstring(game:HttpGet("https://pastebin.com/raw/0MqfXpvY", true))()
end)

tool:Button("俄亥俄州",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
end)

tool:Button("俄亥俄州2英",function()
loadstring(game:HttpGet('https://pastebin.com/raw/MyfCUnGK'))()
end)

tool:Button("俄亥俄州3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rxn-xyz/Ohio./main/Ohio.lua",true))()
end)

tool:Button("俄亥俄州4",function()
loadstring(game:HttpGet("https://pastefy.app/QbXPfsgC/raw"))()
end)

tool:Button("俄亥俄州5",function()
loadstring(game:HttpGet("https://pastebin.com/raw/hkvHeHed",true))()
end)

tool:Button("指令",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/longshulol/long/main/longshu/Ohio"))()
end)



tool:Label("在聊天框输入")
tool:Label("透开—透关")
tool:Label("追踪开—追踪关")
tool:Label("收钱开—收钱关")
tool:Label("收物开—收物关")
tool:Label("抢取款机开—抢取款机关")
tool:Label("抢银行开—抢银行关")
tool:Label("穿墙开—穿墙关")

local creds = window:Tab("特效",'6035145364')

local tool = creds:section("特效",true)

tool:Button("金色吐息",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    -- 检查是否已经存在该道具
    local existingTool = backpack:FindFirstChild("吐息")
    if existingTool then
        existingTool:Destroy()
    end
    
    -- 创建工具
    local tool = Instance.new("Tool")
    tool.Name = "特效"
    tool.ToolTip = "点击右侧按钮释放特效"
    tool.CanBeDropped = false
    tool.Parent = backpack
    
    -- 创建手柄
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.Material = Enum.Material.Plastic
    handle.BrickColor = BrickColor.new("Bright blue")
    handle.Transparency = 0
    handle.CanCollide = false
    handle.Parent = tool
    
    -- 使用模型ID 1865599543
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshId = "rbxassetid://1865599543"
    mesh.TextureId = "rbxassetid://1865599544"
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = handle
    
    -- 存储所有攻击特效的表格
    local activeProjectiles = {}
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AttackButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "ReleaseButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.7, 0) -- 屏幕右侧
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- 蓝色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "释放"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local releaseButton = Instance.new("TextButton")
    releaseButton.Name = "ReleaseButton"
    releaseButton.Size = UDim2.new(1, 0, 1, 0)
    releaseButton.BackgroundTransparency = 1
    releaseButton.Text = ""
    releaseButton.Parent = buttonFrame
    
    -- 发射攻击特效的函数
    local function shootAttack()
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local camera = workspace.CurrentCamera
        
        -- 计算发射方向（使用相机朝向）
        local startPosition = humanoidRootPart.Position + Vector3.new(0, 1.5, 0) -- 从角色头部高度发射
        local direction = camera.CFrame.LookVector -- 使用相机朝向
        
        -- 创建黄色长方形攻击特效
        local attackProjectile = Instance.new("Part")
        attackProjectile.Name = "YellowAttack"
        attackProjectile.Size = Vector3.new(0.3, 0.3, 2) -- 长方形尺寸
        attackProjectile.BrickColor = BrickColor.new("Bright yellow")
        attackProjectile.Material = Enum.Material.Neon
        attackProjectile.Shape = Enum.PartType.Block
        attackProjectile.Anchored = false -- 不锚定，使用物理
        attackProjectile.CanCollide = true
        attackProjectile.CFrame = CFrame.lookAt(startPosition, startPosition + direction * 10)
        attackProjectile.Parent = workspace
        
        -- 添加发光效果
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 8
        pointLight.Range = 12
        pointLight.Color = Color3.new(1, 1, 0) -- 黄色
        pointLight.Parent = attackProjectile
        
        -- 添加粒子效果
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.5, 1)
        particleEmitter.Rate = 30
        particleEmitter.SpreadAngle = Vector2.new(10, 10)
        particleEmitter.Speed = NumberRange.new(2, 5)
        particleEmitter.Color = ColorSequence.new(Color3.new(1, 1, 0)) -- 黄色
        particleEmitter.Parent = attackProjectile
        
        -- 添加物理速度
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = direction * 80 -- 发射速度
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = attackProjectile
        
        -- 存储到活跃特效表
        table.insert(activeProjectiles, attackProjectile)
        
        -- 永不消失，但可以手动清理
        attackProjectile.Touched:Connect(function(hit)
            -- 碰到物体时产生特效但不消失
            createHitEffect(attackProjectile.Position)
        end)
        
        return attackProjectile
    end
    
    -- 创建击中效果函数
    local function createHitEffect(position)
        local explosion = Instance.new("Part")
        explosion.Size = Vector3.new(2, 2, 2)
        explosion.BrickColor = BrickColor.new("Bright yellow")
        explosion.Material = Enum.Material.Neon
        explosion.Anchored = true
        explosion.CanCollide = false
        explosion.Position = position
        explosion.Shape = Enum.PartType.Ball
        explosion.Parent = workspace
        
        local explosionLight = Instance.new("PointLight")
        explosionLight.Brightness = 15
        explosionLight.Range = 8
        explosionLight.Color = Color3.new(1, 1, 0)
        explosionLight.Parent = explosion
        
        -- 1秒后消失
        game:GetService("Debris"):AddItem(explosion, 1)
    end
    
    -- 持续发射控制
    local isShooting = false
    local shootConnection
    
    -- 开始持续发射
    local function startContinuousShooting()
        if isShooting then return end
        
        isShooting = true
        print("开始持续发射攻击特效")
        
        -- 按钮变为绿色表示激活
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        shootConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isShooting then return end
            
            -- 每次心跳发射一个特效
            shootAttack()
        end)
    end
    
    -- 停止持续发射
    local function stopContinuousShooting()
        isShooting = false
        if shootConnection then
            shootConnection:Disconnect()
            shootConnection = nil
        end
        -- 按钮恢复蓝色
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        print("停止发射攻击特效")
    end
    
    -- 清理所有特效
    local function clearAllProjectiles()
        for i, projectile in ipairs(activeProjectiles) do
            if projectile and projectile.Parent then
                projectile:Destroy()
            end
        end
        activeProjectiles = {}
        print("已清理所有攻击特效")
    end
    
    -- 圆形按钮点击事件
    releaseButton.MouseButton1Down:Connect(function()
        if backpack:FindFirstChild("道具") then
            startContinuousShooting()
        end
    end)
    
    -- 圆形按钮松开事件
    releaseButton.MouseButton1Up:Connect(function()
        stopContinuousShooting()
    end)
    
    -- 工具激活事件（手持时点击）
    tool.Activated:Connect(function()
        if tool.Parent == player.Character then
            startContinuousShooting()
        end
    end)
    
    -- 工具取消激活事件
    tool.Deactivated:Connect(function()
        stopContinuousShooting()
    end)
    
    -- 工具装备事件
    tool.Equipped:Connect(function()
        print("道具已装备在手上")
    end)
    
    -- 工具卸载事件
    tool.Unequipped:Connect(function()
        stopContinuousShooting()
        print("道具已放下")
    end)
    
    -- 添加清理按钮
    tool:Button("清理特效", function()
        clearAllProjectiles()
    end)
    
    -- 自动清理远离的特效（防止过多积累）
    game:GetService("RunService").Heartbeat:Connect(function()
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        for i = #activeProjectiles, 1, -1 do
            local projectile = activeProjectiles[i]
            if projectile and projectile.Parent then
                -- 如果特效距离玩家超过200米，自动清理
                local distance = (projectile.Position - humanoidRootPart.Position).Magnitude
                if distance > 200 then
                    projectile:Destroy()
                    table.remove(activeProjectiles, i)
                end
            else
                table.remove(activeProjectiles, i)
            end
        end
    end)
    
    print("攻击道具已添加！点击右侧圆形'释放'按钮即可发射特效")
    print("按住按钮持续发射，松开停止")
end)

tool:Button("火焰翅膀",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    -- 检查是否已经存在翅膀
    if _G.FireWings then
        _G.FireWings:Destroy()
        _G.FireWings = nil
    end
    
    -- 在屏幕右侧创建圆形开关按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WingsButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "WingsToggle"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.5, 0) -- 屏幕右侧中间
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- 蓝色（关闭状态）
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = ""
    toggleButton.Parent = buttonFrame
    
    -- 翅膀状态
    local wingsEnabled = false
    local fireWings = nil
    
    -- 创建火焰翅膀函数
    local function createFireWings()
        local character = player.Character
        if not character then return nil end
        
        -- 创建翅膀模型
        local wings = Instance.new("Model")
        wings.Name = "FireWings"
        
        -- 左翅膀（完全透明）
        local leftWing = Instance.new("Part")
        leftWing.Name = "LeftWing"
        leftWing.Size = Vector3.new(0.2, 3, 1.5)
        leftWing.BrickColor = BrickColor.new("Bright red")
        leftWing.Material = Enum.Material.Neon
        leftWing.Transparency = 1  -- 完全透明
        leftWing.Anchored = false
        leftWing.CanCollide = false
        leftWing.Parent = wings
        
        -- 右翅膀（完全透明）
        local rightWing = Instance.new("Part")
        rightWing.Name = "RightWing"
        rightWing.Size = Vector3.new(0.2, 3, 1.5)
        rightWing.BrickColor = BrickColor.new("Bright red")
        rightWing.Material = Enum.Material.Neon
        rightWing.Transparency = 1  -- 完全透明
        rightWing.Anchored = false
        rightWing.CanCollide = false
        rightWing.Parent = wings
        
        -- 连接到角色背部
        local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
        if torso then
            -- 左翅膀连接
            local leftWeld = Instance.new("Weld")
            leftWeld.Part0 = torso
            leftWeld.Part1 = leftWing
            leftWeld.C0 = CFrame.new(-1.5, 0.5, -0.5) * CFrame.Angles(0, math.rad(45), 0)
            leftWeld.Parent = leftWing
            
            -- 右翅膀连接
            local rightWeld = Instance.new("Weld")
            rightWeld.Part0 = torso
            rightWeld.Part1 = rightWing
            rightWeld.C0 = CFrame.new(1.5, 0.5, -0.5) * CFrame.Angles(0, math.rad(-45), 0)
            rightWeld.Parent = rightWing
        end
        
        -- 添加火焰特效到左翅膀
        local leftFire = Instance.new("Fire")
        leftFire.Size = 12  -- 增大火焰尺寸
        leftFire.Heat = 8   -- 增加热量
        leftFire.Color = Color3.new(1, 0.2, 0) -- 更深的橙色
        leftFire.SecondaryColor = Color3.new(1, 0.8, 0) -- 亮黄色
        leftFire.Parent = leftWing
        
        local leftPointLight = Instance.new("PointLight")
        leftPointLight.Brightness = 15  -- 增加亮度
        leftPointLight.Range = 12       -- 增加范围
        leftPointLight.Color = Color3.new(1, 0.4, 0)
        leftPointLight.Parent = leftWing
        
        -- 添加火焰特效到右翅膀
        local rightFire = Instance.new("Fire")
        rightFire.Size = 12  -- 增大火焰尺寸
        rightFire.Heat = 8   -- 增加热量
        rightFire.Color = Color3.new(1, 0.2, 0) -- 更深的橙色
        rightFire.SecondaryColor = Color3.new(1, 0.8, 0) -- 亮黄色
        rightFire.Parent = rightWing
        
        local rightPointLight = Instance.new("PointLight")
        rightPointLight.Brightness = 15  -- 增加亮度
        rightPointLight.Range = 12       -- 增加范围
        rightPointLight.Color = Color3.new(1, 0.4, 0)
        rightPointLight.Parent = rightWing
        
        -- 添加粒子效果
        local leftSmoke = Instance.new("Smoke")
        leftSmoke.Size = 0.8  -- 增大烟雾
        leftSmoke.Opacity = 0.4
        leftSmoke.RiseVelocity = 8
        leftSmoke.Color = Color3.new(0.4, 0.1, 0)
        leftSmoke.Parent = leftWing
        
        local rightSmoke = Instance.new("Smoke")
        rightSmoke.Size = 0.8  -- 增大烟雾
        rightSmoke.Opacity = 0.4
        rightSmoke.RiseVelocity = 8
        rightSmoke.Color = Color3.new(0.4, 0.1, 0)
        rightSmoke.Parent = rightWing
        
        -- 添加火花粒子
        local leftSparkles = Instance.new("Sparkles")
        leftSparkles.SparkleColor = Color3.new(1, 0.6, 0)
        leftSparkles.Parent = leftWing
        
        local rightSparkles = Instance.new("Sparkles")
        rightSparkles.SparkleColor = Color3.new(1, 0.6, 0)
        rightSparkles.Parent = rightWing
        
        -- 添加额外的火焰粒子发射器
        local leftParticleEmitter = Instance.new("ParticleEmitter")
        leftParticleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        leftParticleEmitter.Lifetime = NumberRange.new(0.5, 1.5)
        leftParticleEmitter.Rate = 50
        leftParticleEmitter.SpreadAngle = Vector2.new(30, 30)
        leftParticleEmitter.Speed = NumberRange.new(2, 8)
        leftParticleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 0.3, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.8, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(1, 0.2, 0))
        })
        leftParticleEmitter.Parent = leftWing
        
        local rightParticleEmitter = Instance.new("ParticleEmitter")
        rightParticleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        rightParticleEmitter.Lifetime = NumberRange.new(0.5, 1.5)
        rightParticleEmitter.Rate = 50
        rightParticleEmitter.SpreadAngle = Vector2.new(30, 30)
        rightParticleEmitter.Speed = NumberRange.new(2, 8)
        rightParticleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 0.3, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.8, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(1, 0.2, 0))
        })
        rightParticleEmitter.Parent = rightWing
        
        wings.Parent = character
        return wings
    end
    
    -- 翅膀动画效果
    local function animateWings()
        if not wingsEnabled or not fireWings then return end
        
        coroutine.wrap(function()
            while wingsEnabled and fireWings and fireWings.Parent do
                local leftWing = fireWings:FindFirstChild("LeftWing")
                local rightWing = fireWings:FindFirstChild("RightWing")
                
                if leftWing and rightWing then
                    -- 轻微的翅膀扇动动画
                    local leftWeld = leftWing:FindFirstChildOfClass("Weld")
                    local rightWeld = rightWing:FindFirstChildOfClass("Weld")
                    
                    if leftWeld and rightWeld then
                        -- 翅膀扇动
                        for i = 1, 10 do
                            if not wingsEnabled then break end
                            leftWeld.C0 = leftWeld.C0 * CFrame.Angles(0, math.rad(1), 0)
                            rightWeld.C0 = rightWeld.C0 * CFrame.Angles(0, math.rad(-1), 0)
                            wait(0.05)
                        end
                        
                        for i = 1, 10 do
                            if not wingsEnabled then break end
                            leftWeld.C0 = leftWeld.C0 * CFrame.Angles(0, math.rad(-1), 0)
                            rightWeld.C0 = rightWeld.C0 * CFrame.Angles(0, math.rad(1), 0)
                            wait(0.05)
                        end
                    end
                end
                wait(0.5)
            end
        end)()
    end
    
    -- 切换翅膀状态
    local function toggleWings()
        if wingsEnabled then
            -- 关闭翅膀
            wingsEnabled = false
            buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- 蓝色
            buttonText.Text = "开启"
            
            if fireWings then
                fireWings:Destroy()
                fireWings = nil
            end
            
            print("火焰翅膀已关闭")
        else
            -- 开启翅膀
            wingsEnabled = true
            buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- 绿色
            buttonText.Text = "关闭"
            
            fireWings = createFireWings()
            _G.FireWings = fireWings
            
            -- 开始翅膀动画
            animateWings()
            
            print("火焰翅膀已开启")
        end
    end
    
    -- 按钮点击事件
    toggleButton.MouseButton1Click:Connect(function()
        toggleWings()
    end)
    
    -- 角色重生时重新创建翅膀
    player.CharacterAdded:Connect(function(character)
        wait(2) -- 等待角色完全加载
        if wingsEnabled then
            fireWings = createFireWings()
            _G.FireWings = fireWings
            animateWings()
        end
    end)
    
    -- 添加删除翅膀的按钮
    tool:Button("移除翅膀", function()
        if _G.FireWings then
            _G.FireWings:Destroy()
            _G.FireWings = nil
        end
        wingsEnabled = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        buttonText.Text = "开启"
        screenGui:Destroy()
        print("火焰翅膀已移除")
    end)
    
    print("火焰翅膀已添加！点击右侧圆形按钮开启/关闭")
    print("翅膀底板已透明，只显示火焰特效")
end)

tool:Button("原子吐息",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlueFireButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "BlueFireButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.3, 0) -- 屏幕右侧上方
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- 蓝色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "按住"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255) -- 白色
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local fireButton = Instance.new("TextButton")
    fireButton.Name = "FireButton"
    fireButton.Size = UDim2.new(1, 0, 1, 0)
    fireButton.BackgroundTransparency = 1
    fireButton.Text = ""
    fireButton.Parent = buttonFrame
    
    -- 火焰发射状态
    local isFiring = false
    local fireConnection = nil
    
    -- 创建蓝色火焰特效函数
    local function createBlueFire()
        local character = player.Character
        if not character then return nil end
        
        local head = character:FindFirstChild("Head")
        if not head then return nil end
        
        -- 创建火焰发射器
        local fireEmitter = Instance.new("Part")
        fireEmitter.Name = "BlueFireEmitter"
        fireEmitter.Size = Vector3.new(0.1, 0.1, 0.1)
        fireEmitter.Transparency = 1  -- 完全透明
        fireEmitter.Anchored = false
        fireEmitter.CanCollide = false
        fireEmitter.Parent = character
        
        -- 连接到头部前方
        local weld = Instance.new("Weld")
        weld.Part0 = head
        weld.Part1 = fireEmitter
        weld.C0 = CFrame.new(0, 0, -1.5)  -- 头部前方
        weld.Parent = fireEmitter
        
        -- 添加蓝色火焰特效
        local blueFire = Instance.new("Fire")
        blueFire.Size = 15  -- 大尺寸火焰
        blueFire.Heat = 10  -- 高热量
        blueFire.Color = Color3.new(0.2, 0.4, 1)  -- 深蓝色
        blueFire.SecondaryColor = Color3.new(0.6, 0.8, 1)  -- 浅蓝色
        blueFire.Parent = fireEmitter
        
        -- 添加蓝色发光
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 20
        pointLight.Range = 15
        pointLight.Color = Color3.new(0.3, 0.5, 1)
        pointLight.Parent = fireEmitter
        
        -- 添加蓝色烟雾
        local blueSmoke = Instance.new("Smoke")
        blueSmoke.Size = 1.0
        blueSmoke.Opacity = 0.3
        blueSmoke.RiseVelocity = 10
        blueSmoke.Color = Color3.new(0.1, 0.2, 0.5)
        blueSmoke.Parent = fireEmitter
        
        -- 添加蓝色火花
        local blueSparkles = Instance.new("Sparkles")
        blueSparkles.SparkleColor = Color3.new(0.4, 0.6, 1)
        blueSparkles.Parent = fireEmitter
        
        -- 添加蓝色粒子发射器
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.3, 1.0)
        particleEmitter.Rate = 100  -- 高频率
        particleEmitter.SpreadAngle = Vector2.new(25, 25)
        particleEmitter.Speed = NumberRange.new(10, 20)  -- 高速发射
        particleEmitter.Rotation = NumberRange.new(0, 360)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.1, 0.3, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.4, 0.6, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.2, 0.8))
        })
        particleEmitter.Parent = fireEmitter
        
        return fireEmitter
    end
    
    -- 开始发射蓝色火焰
    local function startFiring()
        if isFiring then return end
        
        isFiring = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 255) -- 亮蓝色表示激活
        
        print("开始发射蓝色火焰")
        
        -- 创建火焰发射器
        local fireEmitter = createBlueFire()
        
        -- 持续发射效果
        fireConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isFiring or not fireEmitter or not fireEmitter.Parent then
                return
            end
            
            local character = player.Character
            if not character then return end
            
            local head = character:FindFirstChild("Head")
            if not head then return end
            
            -- 创建向前发射的蓝色火焰弹
            local fireProjectile = Instance.new("Part")
            fireProjectile.Name = "BlueFireProjectile"
            fireProjectile.Size = Vector3.new(0.5, 0.5, 2)
            fireProjectile.BrickColor = BrickColor.new("Bright blue")
            fireProjectile.Material = Enum.Material.Neon
            fireProjectile.Transparency = 0.3
            fireProjectile.Shape = Enum.PartType.Block
            fireProjectile.Anchored = false
            fireProjectile.CanCollide = false
            fireProjectile.CFrame = head.CFrame + head.CFrame.LookVector * 2
            fireProjectile.Parent = workspace
            
            -- 添加蓝色发光
            local projectileLight = Instance.new("PointLight")
            projectileLight.Brightness = 8
            projectileLight.Range = 10
            projectileLight.Color = Color3.new(0.3, 0.5, 1)
            projectileLight.Parent = fireProjectile
            
            -- 添加蓝色火焰效果
            local projectileFire = Instance.new("Fire")
            projectileFire.Size = 5
            projectileFire.Heat = 3
            projectileFire.Color = Color3.new(0.2, 0.4, 1)
            projectileFire.SecondaryColor = Color3.new(0.6, 0.8, 1)
            projectileFire.Parent = fireProjectile
            
            -- 添加蓝色粒子尾迹
            local trail = Instance.new("Trail")
            trail.Color = ColorSequence.new(Color3.new(0.2, 0.4, 1))
            trail.LightEmission = 0.8
            trail.Lifetime = 0.5
            trail.Transparency = NumberSequence.new(0.3, 0.8)
            trail.Parent = fireProjectile
            
            -- 设置发射速度（向前方）
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = head.CFrame.LookVector * 80  -- 高速向前
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Parent = fireProjectile
            
            -- 碰撞检测
            fireProjectile.Touched:Connect(function(hit)
                if hit and hit.Parent ~= character then
                    createBlueExplosion(fireProjectile.Position)
                    fireProjectile:Destroy()
                end
            end)
            
            -- 5秒后自动消失
            game:GetService("Debris"):AddItem(fireProjectile, 5)
        end)
    end
    
    -- 停止发射蓝色火焰
    local function stopFiring()
        isFiring = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- 恢复原色
        
        if fireConnection then
            fireConnection:Disconnect()
            fireConnection = nil
        end
        
        -- 移除火焰发射器
        local character = player.Character
        if character then
            local fireEmitter = character:FindFirstChild("BlueFireEmitter")
            if fireEmitter then
                fireEmitter:Destroy()
            end
        end
        
        print("停止发射蓝色火焰")
    end
    
    -- 创建蓝色爆炸效果
    local function createBlueExplosion(position)
        local explosion = Instance.new("Part")
        explosion.Size = Vector3.new(4, 4, 4)
        explosion.BrickColor = BrickColor.new("Bright blue")
        explosion.Material = Enum.Material.Neon
        explosion.Anchored = true
        explosion.CanCollide = false
        explosion.Position = position
        explosion.Shape = Enum.PartType.Ball
        explosion.Parent = workspace
        
        local explosionLight = Instance.new("PointLight")
        explosionLight.Brightness = 25
        explosionLight.Range = 12
        explosionLight.Color = Color3.new(0.3, 0.5, 1)
        explosionLight.Parent = explosion
        
        -- 爆炸粒子效果
        local explosionParticles = Instance.new("ParticleEmitter")
        explosionParticles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        explosionParticles.Lifetime = NumberRange.new(0.5, 1.5)
        explosionParticles.Rate = 200
        explosionParticles.SpreadAngle = Vector2.new(45, 45)
        explosionParticles.Speed = NumberRange.new(5, 15)
        explosionParticles.Color = ColorSequence.new(Color3.new(0.2, 0.4, 1))
        explosionParticles.Parent = explosion
        
        -- 2秒后消失
        game:GetService("Debris"):AddItem(explosion, 2)
    end
    
    -- 按钮按下事件
    fireButton.MouseButton1Down:Connect(function()
        startFiring()
    end)
    
    -- 按钮松开事件
    fireButton.MouseButton1Up:Connect(function()
        stopFiring()
    end)
    
    -- 角色重生时重置
    player.CharacterAdded:Connect(function(character)
        wait(1)
        stopFiring()
    end)
    
    -- 添加清理按钮
    tool:Button("移除火焰系统", function()
        stopFiring()
        screenGui:Destroy()
        print("蓝色火焰系统已移除")
    end)
    
    print("蓝色火焰发射器已添加！长按右侧'按住'按钮发射蓝色火焰")
end)

tool:Button("开启双色火焰",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DualFireButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "DualFireButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.3, 0) -- 屏幕右侧上方
    buttonFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 200) -- 混合色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local fireButton = Instance.new("TextButton")
    fireButton.Name = "FireButton"
    fireButton.Size = UDim2.new(1, 0, 1, 0)
    fireButton.BackgroundTransparency = 1
    fireButton.Text = ""
    fireButton.Parent = buttonFrame
    
    -- 火焰状态
    local isFireActive = false
    local leftFireEmitter = nil
    local rightFireEmitter = nil
    
    -- 创建左手蓝色火焰特效
    local function createLeftBlueFire()
        local character = player.Character
        if not character then return nil end
        
        local leftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
        if not leftHand then return nil end
        
        -- 创建蓝色火焰发射器
        local fireEmitter = Instance.new("Part")
        fireEmitter.Name = "LeftBlueFireEmitter"
        fireEmitter.Size = Vector3.new(0.1, 0.1, 0.1)
        fireEmitter.Transparency = 1
        fireEmitter.Anchored = false
        fireEmitter.CanCollide = false
        fireEmitter.Parent = character
        
        -- 连接到左手
        local weld = Instance.new("Weld")
        weld.Part0 = leftHand
        weld.Part1 = fireEmitter
        weld.C0 = CFrame.new(0, 0, 0)
        weld.Parent = fireEmitter
        
        -- 蓝色火焰特效
        local blueFire = Instance.new("Fire")
        blueFire.Size = 8
        blueFire.Heat = 8
        blueFire.Color = Color3.new(0.1, 0.3, 1)  -- 深蓝色
        blueFire.SecondaryColor = Color3.new(0.4, 0.6, 1)  -- 浅蓝色
        blueFire.Parent = fireEmitter
        
        -- 蓝色发光
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 15
        pointLight.Range = 12
        pointLight.Color = Color3.new(0.2, 0.4, 1)
        pointLight.Parent = fireEmitter
        
        -- 蓝色粒子效果
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.5, 1.2)
        particleEmitter.Rate = 50
        particleEmitter.SpreadAngle = Vector2.new(30, 30)
        particleEmitter.Speed = NumberRange.new(2, 5)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.1, 0.3, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.3, 0.5, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.2, 0.8))
        })
        particleEmitter.Parent = fireEmitter
        
        return fireEmitter
    end
    
    -- 创建右手红色火焰特效
    local function createRightRedFire()
        local character = player.Character
        if not character then return nil end
        
        local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
        if not rightHand then return nil end
        
        -- 创建红色火焰发射器
        local fireEmitter = Instance.new("Part")
        fireEmitter.Name = "RightRedFireEmitter"
        fireEmitter.Size = Vector3.new(0.1, 0.1, 0.1)
        fireEmitter.Transparency = 1
        fireEmitter.Anchored = false
        fireEmitter.CanCollide = false
        fireEmitter.Parent = character
        
        -- 连接到右手
        local weld = Instance.new("Weld")
        weld.Part0 = rightHand
        weld.Part1 = fireEmitter
        weld.C0 = CFrame.new(0, 0, 0)
        weld.Parent = fireEmitter
        
        -- 红色火焰特效
        local redFire = Instance.new("Fire")
        redFire.Size = 8
        redFire.Heat = 8
        redFire.Color = Color3.new(1, 0.2, 0.1)  -- 深红色
        redFire.SecondaryColor = Color3.new(1, 0.6, 0.3)  -- 浅红色
        redFire.Parent = fireEmitter
        
        -- 红色发光
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 15
        pointLight.Range = 12
        pointLight.Color = Color3.new(1, 0.3, 0.1)
        pointLight.Parent = fireEmitter
        
        -- 红色粒子效果
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.5, 1.2)
        particleEmitter.Rate = 50
        particleEmitter.SpreadAngle = Vector2.new(30, 30)
        particleEmitter.Speed = NumberRange.new(2, 5)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(1, 0.2, 0.1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(1, 0.4, 0.2)),
            ColorSequenceKeypoint.new(1, Color3.new(0.8, 0.1, 0.1))
        })
        particleEmitter.Parent = fireEmitter
        
        return fireEmitter
    end
    
    -- 开启双色火焰
    local function startDualFire()
        if isFireActive then return end
        
        isFireActive = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(150, 50, 150) -- 激活状态颜色
        buttonText.Text = "开启中"
        
        print("开启双色火焰特效")
        
        -- 创建双手火焰
        leftFireEmitter = createLeftBlueFire()
        rightFireEmitter = createRightRedFire()
        
        -- 持续特效更新
        local fireConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isFireActive then
                fireConnection:Disconnect()
                return
            end
            
            -- 可以在这里添加持续的特效更新逻辑
            -- 比如根据角色移动调整火焰效果等
        end)
    end
    
    -- 关闭双色火焰
    local function stopDualFire()
        if not isFireActive then return end
        
        isFireActive = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 200) -- 恢复原色
        buttonText.Text = "开启"
        
        -- 移除左手蓝色火焰
        if leftFireEmitter then
            leftFireEmitter:Destroy()
            leftFireEmitter = nil
        end
        
        -- 移除右手红色火焰
        if rightFireEmitter then
            rightFireEmitter:Destroy()
            rightFireEmitter = nil
        end
        
        print("关闭双色火焰特效")
    end
    
    -- 按钮点击事件 - 切换开启/关闭
    fireButton.MouseButton1Click:Connect(function()
        if isFireActive then
            stopDualFire()
        else
            startDualFire()
        end
    end)
    
    -- 角色重生时自动关闭火焰
    player.CharacterAdded:Connect(function(character)
        wait(1)
        stopDualFire()
    end)
    
    -- 添加清理按钮
    tool:Button("移除火焰系统", function()
        stopDualFire()
        screenGui:Destroy()
        print("双色火焰系统已移除")
    end)
    
    print("双色火焰特效已添加！点击右侧'开启'按钮切换火焰特效")
end)

tool:Button("开启头部火焰",function()
    -- 获取本地玩家
    local player = game:GetService("Players").LocalPlayer
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HeadFireButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "HeadFireButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80) -- 圆形按钮大小
    buttonFrame.Position = UDim2.new(1, -100, 0.3, 0) -- 屏幕右侧上方
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- 蓝色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 完全圆形
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local fireButton = Instance.new("TextButton")
    fireButton.Name = "FireButton"
    fireButton.Size = UDim2.new(1, 0, 1, 0)
    fireButton.BackgroundTransparency = 1
    fireButton.Text = ""
    fireButton.Parent = buttonFrame
    
    -- 火焰状态
    local isFireActive = false
    local headFireEmitter = nil
    
    -- 创建头部蓝色火焰特效
    local function createHeadBlueFire()
        local character = player.Character
        if not character then return nil end
        
        local head = character:FindFirstChild("Head")
        if not head then return nil end
        
        -- 创建头部火焰发射器
        local fireEmitter = Instance.new("Part")
        fireEmitter.Name = "HeadBlueFireEmitter"
        fireEmitter.Size = Vector3.new(0.1, 0.1, 0.1)
        fireEmitter.Transparency = 1
        fireEmitter.Anchored = false
        fireEmitter.CanCollide = false
        fireEmitter.Parent = character
        
        -- 连接到头部上方
        local weld = Instance.new("Weld")
        weld.Part0 = head
        weld.Part1 = fireEmitter
        weld.C0 = CFrame.new(0, 0.8, 0) -- 头部上方
        weld.Parent = fireEmitter
        
        -- 小型蓝色火焰特效
        local blueFire = Instance.new("Fire")
        blueFire.Size = 4  -- 较小的尺寸
        blueFire.Heat = 5  -- 适中的热量
        blueFire.Color = Color3.new(0.1, 0.3, 1)  -- 深蓝色
        blueFire.SecondaryColor = Color3.new(0.4, 0.6, 1)  -- 浅蓝色
        blueFire.Parent = fireEmitter
        
        -- 蓝色发光（较小范围）
        local pointLight = Instance.new("PointLight")
        pointLight.Brightness = 8  -- 较低的亮度
        pointLight.Range = 8       -- 较小的范围
        pointLight.Color = Color3.new(0.2, 0.4, 1)
        pointLight.Parent = fireEmitter
        
        -- 小型蓝色粒子效果
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxasset://textures/particles/fire_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.3, 0.8)  -- 较短的生命周期
        particleEmitter.Rate = 30  -- 较少的粒子数量
        particleEmitter.SpreadAngle = Vector2.new(15, 15)  -- 较小的扩散角度
        particleEmitter.Speed = NumberRange.new(1, 3)  -- 较慢的速度
        particleEmitter.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.5),
            NumberSequenceKeypoint.new(1, 0.1)
        })
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0.1, 0.3, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.new(0.3, 0.5, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.2, 0.8))
        })
        particleEmitter.Parent = fireEmitter
        
        -- 添加小型蓝色火花效果
        local blueSparkles = Instance.new("Sparkles")
        blueSparkles.SparkleColor = Color3.new(0.3, 0.5, 1)
        blueSparkles.Parent = fireEmitter
        
        return fireEmitter
    end
    
    -- 开启头部火焰
    local function startHeadFire()
        if isFireActive then return end
        
        isFireActive = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 255) -- 激活状态亮蓝色
        buttonText.Text = "开启中"
        
        print("开启头部蓝色火焰特效")
        
        -- 创建头部火焰
        headFireEmitter = createHeadBlueFire()
        
        -- 持续特效更新
        local fireConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isFireActive then
                fireConnection:Disconnect()
                return
            end
            
            -- 可以在这里添加轻微的火焰波动效果
            if headFireEmitter and headFireEmitter.Parent then
                local fire = headFireEmitter:FindFirstChildOfClass("Fire")
                if fire then
                    -- 轻微的大小波动，让火焰更自然
                    fire.Size = 4 + math.sin(tick() * 5) * 0.5
                end
            end
        end)
    end
    
    -- 关闭头部火焰
    local function stopHeadFire()
        if not isFireActive then return end
        
        isFireActive = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200) -- 恢复原色
        buttonText.Text = "开启"
        
        -- 移除头部火焰
        if headFireEmitter then
            headFireEmitter:Destroy()
            headFireEmitter = nil
        end
        
        print("关闭头部蓝色火焰特效")
    end
    
    -- 按钮点击事件 - 切换开启/关闭
    fireButton.MouseButton1Click:Connect(function()
        if isFireActive then
            stopHeadFire()
        else
            startHeadFire()
        end
    end)
    
    -- 角色重生时自动关闭火焰
    player.CharacterAdded:Connect(function(character)
        wait(1)
        stopHeadFire()
    end)
    
    -- 添加清理按钮
    tool:Button("移除火焰系统", function()
        stopHeadFire()
        screenGui:Destroy()
        print("头部火焰系统已移除")
    end)
    
    print("头部蓝色火焰特效已添加！点击右侧'开启'按钮切换火焰特效")
end)

tool:Button("开启雷电光环",function()
    -- 获取服务
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    
    local player = Players.LocalPlayer
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ThunderAuraButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "ThunderAuraButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80)
    buttonFrame.Position = UDim2.new(1, -100, 0.5, 0)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(106, 27, 154) -- 紫色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local auraButton = Instance.new("TextButton")
    auraButton.Name = "AuraButton"
    auraButton.Size = UDim2.new(1, 0, 1, 0)
    auraButton.BackgroundTransparency = 1
    auraButton.Text = ""
    auraButton.Parent = buttonFrame
    
    -- 雷电光环状态
    local isAuraActive = false
    local thunderConnection = nil
    local thunderParts = {}
    
    -- 创建紫色雷电特效（其他玩家可见）
    local function createThunderEffect(position, targetPosition)
        local thunder = Instance.new("Part")
        thunder.Name = "PurpleThunder"
        thunder.Size = Vector3.new(0.2, (position - targetPosition).Magnitude, 0.2)
        thunder.Position = (position + targetPosition) / 2
        thunder.Anchored = true
        thunder.CanCollide = false
        thunder.Material = EnumMaterial.Neon
        thunder.BrickColor = BrickColor.new("Royal purple")
        thunder.Parent = workspace
        
        -- 设置雷电方向
        thunder.CFrame = CFrame.lookAt(thunder.Position, targetPosition) * CFrame.Angles(math.pi/2, 0, 0)
        
        -- 紫色发光效果
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(17245,245,245)
        pointLight.Brightness = 10
        pointLight.Range = 8
        pointLight.Parent = thunder
        
        -- 闪电光束效果
        local beam = Instance.new("Beam")
        beam.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(17245,245,245)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 50, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 200))
        })
        beam.Width0 = 0.3
        beam.Width1 = 0.3
        beam.Brightness = 5
        beam.Parent = thunder
        
        -- 创建附着点
        local attachment0 = Instance.new("Attachment")
        attachment0.Parent = thunder
        attachment0.Position = Vector3.new(0, thunder.Size.Y/2, 0)
        
        local attachment1 = Instance.new("Attachment")
        attachment1.Parent = thunder
        attachment1.Position = Vector3.new(0, -thunder.Size.Y/2, 0)
        
        beam.Attachment0 = attachment0
        beam.Attachment1 = attachment1
        
        table.insert(thunderParts, thunder)
        
        -- 自动清理
        game:GetService("Debris"):AddItem(thunder, 0.3)
        
        return thunder
    end
    
    -- 在玩家周围创建雷电光环
    local function createThunderAura()
        local character = player.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        local auraRadius = 8  -- 光环半径
        local thunderCount = 6  -- 同时存在的雷电数量
        
        for i = 1, thunderCount do
            local angle = (i / thunderCount) * math.pi * 2 + tick()
            local x = math.cos(angle) * auraRadius
            local z = math.sin(angle) * auraRadius
            
            local startPos = rootPart.Position + Vector3.new(x, 5, z)
            local endPos = rootPart.Position + Vector3.new(x, 0, z)
            
            createThunderEffect(startPos, endPos)
        end
        
        -- 随机地面雷电
        if math.random(1, 3) == 1 then
            local randomAngle = math.random() * math.pi * 2
            local randomDist = math.random(3, auraRadius)
            local groundX = math.cos(randomAngle) * randomDist
            local groundZ = math.sin(randomAngle) * randomDist
            
            local groundStart = rootPart.Position + Vector3.new(groundX, 3, groundZ)
            local groundEnd = rootPart.Position + Vector3.new(groundX, 0, groundZ)
            
            createThunderEffect(groundStart, groundEnd)
        end
    end
    
    -- 创建环绕玩家的雷电粒子
    local function createAuraParticles()
        local character = player.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        -- 创建雷电粒子发射器
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Name = "ThunderAuraParticles"
        particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particleEmitter.Lifetime = NumberRange.new(0.5, 1.2)
        particleEmitter.Rate = 20
        particleEmitter.SpreadAngle = Vector2.new(45, 45)
        particleEmitter.Speed = NumberRange.new(2, 5)
        particleEmitter.Rotation = NumberRange.new(0, 360)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(17245,245,245)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 50, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 0, 200))
        })
        particleEmitter.LightEmission = 0.8
        particleEmitter.Parent = rootPart
        
        -- 创建环绕光效
        local auraLight = Instance.new("PointLight")
        auraLight.Name = "AuraLight"
        auraLight.Color = Color3.fromRGB(17245,245,245)
        auraLight.Brightness = 3
        auraLight.Range = 12
        auraLight.Parent = rootPart
        
        return {particleEmitter, auraLight}
    end
    
    -- 开启雷电光环
    local function startThunderAura()
        if isAuraActive then return end
        
        isAuraActive = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(142, 36, 170)
        buttonText.Text = "开启中"
        
        print("开启紫色雷电光环特效")
        
        -- 创建持续粒子效果
        local auraEffects = createAuraParticles()
        
        -- 持续生成雷电效果
        thunderConnection = RunService.Heartbeat:Connect(function()
            if not isAuraActive then return end
            
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                return
            end
            
            -- 生成雷电
            createThunderAura()
            
            -- 随机音效（可选）
            if math.random(1, 10) == 1 then
                -- 可以在这里添加雷电音效
            end
        end)
        
        -- 存储特效引用以便清理
        auraEffects.connection = thunderConnection
        return auraEffects
    end
    
    -- 关闭雷电光环
    local function stopThunderAura()
        if not isAuraActive then return end
        
        isAuraActive = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(106, 27, 154)
        buttonText.Text = "开启"
        
        -- 断开连接
        if thunderConnection then
            thunderConnection:Disconnect()
            thunderConnection = nil
        end
        
        -- 清理所有雷电部件
        for _, part in ipairs(thunderParts) do
            if part and part.Parent then
                part:Destroy()
            end
        end
        thunderParts = {}
        
        -- 清理角色身上的特效
        local character = player.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local particles = rootPart:FindFirstChild("ThunderAuraParticles")
                local light = rootPart:FindFirstChild("AuraLight")
                
                if particles then particles:Destroy() end
                if light then light:Destroy() end
            end
        end
        
        print("关闭紫色雷电光环特效")
    end
    
    -- 按钮点击事件
    auraButton.MouseButton1Click:Connect(function()
        if isAuraActive then
            stopThunderAura()
        else
            startThunderAura()
        end
    end)
    
    -- 角色重生时自动关闭特效
    player.CharacterAdded:Connect(function(character)
        wait(1)
        stopThunderAura()
    end)
    
    -- 添加清理按钮
    tool:Button("移除雷电系统", function()
        stopThunderAura()
        screenGui:Destroy()
        print("雷电光环系统已移除")
    end)
    
    print("紫色雷电光环特效已添加！点击右侧'开启'按钮切换特效")
end)

tool:Button("开启雷电光环",function()
    -- 获取服务
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    
    local player = Players.LocalPlayer
    
    -- 在屏幕右侧创建圆形按钮
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ThunderAuraButtonGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- 圆形按钮框架
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "ThunderAuraButton"
    buttonFrame.Size = UDim2.new(0, 80, 0, 80)
    buttonFrame.Position = UDim2.new(1, -100, 0.5, 0)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 255) -- 蓝色
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = screenGui
    
    -- 圆形效果
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = buttonFrame
    
    -- 按钮文字
    local buttonText = Instance.new("TextLabel")
    buttonText.Name = "ButtonText"
    buttonText.Size = UDim2.new(1, 0, 1, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = "开启"
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.Parent = buttonFrame
    
    -- 实际点击按钮
    local auraButton = Instance.new("TextButton")
    auraButton.Name = "AuraButton"
    auraButton.Size = UDim2.new(1, 0, 1, 0)
    auraButton.BackgroundTransparency = 1
    auraButton.Text = ""
    auraButton.Parent = buttonFrame
    
    -- 雷电光环状态
    local isAuraActive = false
    local auraConnection = nil
    local fireballParts = {}
    
    -- 创建蓝色火焰球特效（其他玩家可见）
    local function createBlueFireball(character)
        if not character then return nil end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return nil end
        
        -- 创建巨大的火焰球
        local fireball = Instance.new("Part")
        fireball.Name = "BlueFireballAura"
        fireball.Size = Vector3.new(15, 15, 15) -- 巨大的球体
        fireball.Position = rootPart.Position
        fireball.Anchored = false
        fireball.CanCollide = false
        fireball.Material = EnumMaterial.Neon
        fireball.BrickColor = BrickColor.new("Bright blue")
        fireball.Transparency = 0.3
        fireball.Parent = workspace
        
        -- 球形碰撞体
        local sphere = Instance.new("SphereHandleAdornment")
        sphere.Name = "FireballSphere"
        sphere.Adornee = fireball
        sphere.AlwaysOnTop = true
        sphere.ZIndex = 1
        sphere.Radius = 7.5
        sphere.Color3 = Color3.fromRGB(0, 150, 255)
        sphere.Parent = fireball
        
        -- 蓝色火焰特效
        local fire = Instance.new("Fire")
        fire.Name = "BlueFire"
        fire.Color = Color3.new(0, 0.5, 1) -- 蓝色
        fire.SecondaryColor = Color3.new(0, 1, 1) -- 青色
        fire.Size = 25 -- 巨大的火焰
        fire.Heat = 5
        fire.Parent = fireball
        
        -- 蓝色点光源
        local pointLight = Instance.new("PointLight")
        pointLight.Name = "BlueLight"
        pointLight.Color = Color3.fromRGB(0, 150, 255)
        pointLight.Brightness = 15
        pointLight.Range = 25
        pointLight.Parent = fireball
        
        -- 烟雾特效（蓝色调）
        local smoke = Instance.new("Smoke")
        smoke.Name = "BlueSmoke"
        smoke.Color = Color3.new(0, 0.3, 0.6)
        smoke.Size = 10
        smoke.Opacity = 0.4
        smoke.RiseVelocity = 5
        smoke.Parent = fireball
        
        -- 粒子发射器
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Name = "BlueParticles"
        particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        particleEmitter.Lifetime = NumberRange.new(1, 3)
        particleEmitter.Rate = 50
        particleEmitter.SpreadAngle = Vector2.new(45, 45)
        particleEmitter.Speed = NumberRange.new(2, 8)
        particleEmitter.VelocitySpread = 50
        particleEmitter.Rotation = NumberRange.new(0, 360)
        particleEmitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
        })
        particleEmitter.LightEmission = 0.9
        particleEmitter.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.5),
            NumberSequenceKeypoint.new(0.5, 1),
            NumberSequenceKeypoint.new(1, 0)
        })
        particleEmitter.Parent = fireball
        
        -- 将火焰球连接到角色
        local weld = Instance.new("Weld")
        weld.Part0 = rootPart
        weld.Part1 = fireball
        weld.C0 = CFrame.new(0, 0, 0) -- 在角色中心
        weld.Parent = fireball
        
        table.insert(fireballParts, fireball)
        
        return fireball
    end
    
    -- 创建环绕火焰球的额外特效
    local function createOrbitingEffects(character)
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        -- 创建环绕的闪电效果
        for i = 1, 4 do
            local angle = (i / 4) * math.pi * 2
            local orbitPart = Instance.new("Part")
            orbitPart.Name = "OrbitLightning"
            orbitPart.Size = Vector3.new(1, 1, 8)
            orbitPart.Anchored = false
            orbitPart.CanCollide = false
            orbitPart.Material = EnumMaterial.Neon
            orbitPart.BrickColor = BrickColor.new("Bright blue")
            orbitPart.Transparency = 0.2
            orbitPart.Parent = workspace
            
            -- 光束效果
            local beam = Instance.new("Beam")
            beam.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
            })
            beam.Width0 = 0.5
            beam.Width1 = 0.5
            beam.Brightness = 3
            beam.Parent = orbitPart
            
            local attachment0 = Instance.new("Attachment")
            attachment0.Parent = orbitPart
            local attachment1 = Instance.new("Attachment")
            attachment1.Parent = orbitPart
            
            beam.Attachment0 = attachment0
            beam.Attachment1 = attachment1
            
            -- 连接到角色并设置环绕
            local weld = Instance.new("Weld")
            weld.Part0 = rootPart
            weld.Part1 = orbitPart
            weld.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(0, angle, 0) * CFrame.new(10, 0, 0)
            weld.Parent = orbitPart
            
            table.insert(fireballParts, orbitPart)
        end
    end
    
    -- 开启蓝色火焰球光环
    local function startBlueFireballAura()
        if isAuraActive then return end
        
        isAuraActive = true
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        buttonText.Text = "开启中"
        
        print("开启巨大蓝色火焰球特效")
        
        local character = player.Character
        if not character then return end
        
        -- 创建主火焰球
        local mainFireball = createBlueFireball(character)
        
        -- 创建环绕特效
        createOrbitingEffects(character)
        
        -- 更新特效位置
        auraConnection = RunService.Heartbeat:Connect(function()
            if not isAuraActive then return end
            
            local currentCharacter = player.Character
            if not currentCharacter then
                stopBlueFireballAura()
                return
            end
        end)
    end
    
    -- 关闭蓝色火焰球光环
    local function stopBlueFireballAura()
        if not isAuraActive then return end
        
        isAuraActive = false
        buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        buttonText.Text = "开启"
        
        -- 断开连接
        if auraConnection then
            auraConnection:Disconnect()
            auraConnection = nil
        end
        
        -- 清理所有火焰球部件
        for _, part in ipairs(fireballParts) do
            if part and part.Parent then
                part:Destroy()
            end
        end
        fireballParts = {}
        
        print("关闭蓝色火焰球特效")
    end
    
    -- 按钮点击事件
    auraButton.MouseButton1Click:Connect(function()
        if isAuraActive then
            stopBlueFireballAura()
        else
            startBlueFireballAura()
        end
    end)
    
    -- 角色重生时自动关闭特效
    player.CharacterAdded:Connect(function(character)
        wait(1) -- 等待角色完全加载
        if isAuraActive then
            stopBlueFireballAura()
            wait(0.5)
            startBlueFireballAura()
        end
    end)
    
    -- 添加清理按钮
    tool:Button("移除火焰球系统", function()
        stopBlueFireballAura()
        screenGui:Destroy()
        print("蓝色火焰球系统已移除")
    end)
    
    print("巨大蓝色火焰球特效已添加！点击右侧'开启'按钮切换特效")
end)

local creds = window:Tab("免费robux",'6035145364')

local tool = creds:section("全是免费",true)

tool:Button("获得30robux", function()
    -- 第一个通知：正在获取
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Robux获取中",
        Text = "正在获取30 Robux...",
        Duration = 5,
        Icon = "rbxassetid://112945417541386"
    })
    
    -- 等待8-9秒
    wait(math.random(8, 9))
    
    -- 第二个通知：已获取
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "获取成功！",
        Text = "已成功获取30 Robux！",
        Duration = 5,
        Icon = "rbxassetid://112945417541386"
    })
    
    print("恶搞完成：显示虚假Robux获取通知")
end)

-- 恶搞脚本：虚假奖励
local function CreatePrankGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- 创建全屏图片（更大尺寸）
    local image = Instance.new("ImageLabel")
    image.Size = UDim2.new(1.2, 0, 1.2, 0) -- 放大图片
    image.Position = UDim2.new(-0.1, 0, -0.1, 0) -- 调整位置使其居中显示
    image.Image = "http://www.roblox.com/asset/?id=101930816916083"
    image.BackgroundColor3 = Color3.new(0, 0, 0)
    image.Parent = screenGui

    -- 播放两个大声音频
    local sound1 = Instance.new("Sound")
    sound1.SoundId = "rbxassetid://313948389"
    sound1.Volume = 10
    sound1.Parent = game.Workspace
    sound1:Play()

    local sound2 = Instance.new("Sound")
    sound2.SoundId = "rbxassetid://8315677038"
    sound2.Volume = 10
    sound2.Parent = game.Workspace
    sound2:Play()

    -- 创建胶囊型道歉按钮
    local apologyButton = Instance.new("TextButton")
    apologyButton.Size = UDim2.new(0, 200, 0, 60)
    apologyButton.Position = UDim2.new(0.5, -100, 0.8, 0)
    apologyButton.Text = "爸爸我错了"
    apologyButton.BackgroundColor3 = Color3.fromRGB(173, 216, 230) -- 淡蓝色
    apologyButton.TextColor3 = Color3.new(0, 0, 0)
    apologyButton.Font = Enum.Font.SourceSansBold
    apologyButton.TextSize = 20
    
    -- 设置胶囊形状（圆角）
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- 设置为胶囊形状
    corner.Parent = apologyButton
    
    apologyButton.Parent = screenGui

    apologyButton.MouseButton1Click:Connect(function()
        -- 立即消失图片和按钮
        image:Destroy()
        apologyButton:Destroy()
        
        local message = "爸爸我错了"
        
        -- 在聊天框显示消息
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        
        -- 尝试通过默认聊天系统发送消息
        local success, err = pcall(function()
            Players:Chat(message)
        end)
        
        -- 如果默认方法失败，尝试其他方法
        if not success then
            -- 尝试使用SayMessageRequest
            pcall(function()
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message)
            end)
        end

        -- 修改天空盒
        local lighting = game:GetService("Lighting")
        local sky = lighting:FindFirstChildOfClass("Sky")
        if sky then
            sky:Destroy()
        end
        
        local newSky = Instance.new("Sky")
        newSky.Parent = lighting
        
        -- 设置天空盒所有面为同一图片
        local textureId = "http://www.roblox.com/asset/?id=101930816916083"
        newSky.SkyboxBk = textureId
        newSky.SkyboxDn = textureId
        newSky.SkyboxFt = textureId
        newSky.SkyboxLf = textureId
        newSky.SkyboxRt = textureId
        newSky.SkyboxUp = textureId

        -- 修改所有模型的贴图
        local function changeTextures(obj)
            if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                -- 创建新的贴图
                local texture = Instance.new("Texture")
                texture.Texture = textureId
                texture.Face = "Top"
                texture.Parent = obj
                
                local texture2 = Instance.new("Texture")
                texture2.Texture = textureId
                texture2.Face = "Bottom"
                texture2.Parent = obj
                
                local texture3 = Instance.new("Texture")
                texture3.Texture = textureId
                texture3.Face = "Left"
                texture3.Parent = obj
                
                local texture4 = Instance.new("Texture")
                texture4.Texture = textureId
                texture4.Face = "Right"
                texture4.Parent = obj
                
                local texture5 = Instance.new("Texture")
                texture5.Texture = textureId
                texture5.Face = "Front"
                texture5.Parent = obj
                
                local texture6 = Instance.new("Texture")
                texture6.Texture = textureId
                texture6.Face = "Back"
                texture6.Parent = obj
            end
            
            -- 递归处理所有子对象
            for _, child in ipairs(obj:GetChildren()) do
                changeTextures(child)
            end
        end

        -- 从Workspace开始修改所有模型
        changeTextures(game.Workspace)

        -- 给所有玩家添加长条拖尾特效
        local function addTrailToPlayer(player)
            if player.Character then
                local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    -- 创建拖尾特效
                    local trail = Instance.new("Trail")
                    trail.Attachment0 = Instance.new("Attachment")
                    trail.Attachment0.Parent = humanoidRootPart
                    trail.Attachment0.Position = Vector3.new(-1, 0, 0)
                    
                    trail.Attachment1 = Instance.new("Attachment")
                    trail.Attachment1.Parent = humanoidRootPart
                    trail.Attachment1.Position = Vector3.new(1, 0, 0)
                    
                    trail.Texture = "http://www.roblox.com/asset/?id=101930816916083"
                    trail.TextureMode = Enum.TextureMode.Wrap
                    trail.Lifetime = 2
                    trail.MaxLength = 100
                    trail.Color = ColorSequence.new(Color3.new(1, 1, 1))
                    trail.Parent = humanoidRootPart
                end
            end
        end

        -- 给现有玩家添加拖尾
        for _, player in ipairs(Players:GetPlayers()) do
            addTrailToPlayer(player)
        end

        -- 给新加入的玩家也添加拖尾
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                wait(1) -- 等待角色加载完成
                addTrailToPlayer(player)
            end)
        end)

        local apologySound = Instance.new("Sound")
        apologySound.SoundId = "rbxassetid://128326043560149"
        apologySound.Volume = 10
        apologySound.Parent = game.Workspace
        apologySound:Play()

        apologySound.Ended:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

-- 创建多个单独的奖励按钮
local rewardAmounts = {80, 160, 240, 320, 400, 480, 560, 640, 720, 800}

for i, amount in ipairs(rewardAmounts) do
    tool:Button("免费获得" .. amount .. "r", function()
        CreatePrankGUI()
    end)
end

tool:Button("获得5600robux", function()
    -- 第一个通知：正在获取
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Robux获取中",
        Text = "正在获取5600 Robux...",
        Duration = 6,
        Icon = "rbxassetid://112945417541386"
    })
    
    -- 等待10-12秒，让用户更期待
    wait(math.random(10, 12))
    
    -- 第二个通知：已获取
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "获取成功！",
        Text = "已成功获取5600 Robux！",
        Duration = 8,
        Icon = "rbxassetid://112945417541386"
    })
    
    print(" Robux获取通知")
end)

local creds = window:Tab("黄色功能",'6035145364')

local tool = creds:section("功能",true)

tool:Button("点击约炮",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/79632dbbd97f3c4359fa068566c282ca13db30c0/%E7%82%B9%E5%87%BB%E5%B2%B3%E7%96%B1"))()
end)

tool:Button("爸爸快点拿大黑吊操我",function()
    local message = "爸爸快点拿大黒眺懆我"
    
    
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
        if sayMessage then
            sayMessage:FireServer(message, "All")
        end
    end
    
   
    local TextChatService = game:GetService("TextChatService")
    if TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel:SendAsync(message)
            end
        end
    end
    
    print("已发送消息: " .. message)
end)

tool:Button("好想吃大黑屌",function()
     local message = "好向迟大嘿调"
    
    
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
        if sayMessage then
            sayMessage:FireServer(message, "All")
        end
    end
    
   
    local TextChatService = game:GetService("TextChatService")
    if TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel:SendAsync(message)
            end
        end
    end
    
    print("已发送消息: " .. message)
end)

tool:Button("我是个骚逼",function()
    local message = "我是个嫂避"
    
    
    local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvents then
        local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
        if sayMessage then
            sayMessage:FireServer(message, "All")
        end
    end
    
   
    local TextChatService = game:GetService("TextChatService")
    if TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel:SendAsync(message)
            end
        end
    end
    
    print("已发送消息: " .. message)
end)

local creds = window:Tab("doors",'6035145364')

local tool = creds:section("功能",true)

tool:Button("可以清除东西的枪",function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/K0t1n/Public/main/Laser%20Gun"))()
end)
      
             
tool:Button("十字架",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/FCSyG6Th"))();
end)  
      
tool:Button("夜视仪",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/4Vsv1Xwn"))()
end)  
      
tool:Button("神圣炸弹",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/u5B1UjGv"))()
end)  
      
tool:Button("吸铁石",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/xHxGDp51"))()
end)    
      
tool:Button("剪刀",function()
      loadstring(game:HttpGet("https://pastebin.com/raw/v2yEJYmu"))()
end)  

tool:Button("开启不可能模式",function()
      	loadstring(game:HttpGet('https://raw.githubusercontent.com/Ukazix/impossible-mode/main/Protected_79.lua.txt'))() 
end)

tool:Button("每15秒一只screech",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        while true do -- Will run the script forever
          coroutine.wrap(function() require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech)(Data) end)() -- Coroutines prevent the script from yielding.
        task.wait(15) -- Waits somewhere around a millisecond before executing again. This is necessary so that the script won't crash your game. You can also add a time as such: task.wait(1) or task.wait(0.5)
        end
end)

tool:Button("每15秒一只halt",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        while true do -- Will run the script forever
          coroutine.wrap(function() require(game.ReplicatedStorage.ClientModules.EntityModules.Glitch).stuff(Data, workspace.CurrentRooms[tostring(game.ReplicatedStorage.GameData.LatestRoom.Value)])          end)() -- Coroutines prevent the script from yielding.
        task.wait(15) -- Waits somewhere around a millisecond before executing again. This is necessary so that the script won't crash your game. You can also add a time as such: task.wait(1) or task.wait(0.5)
        end
end)

tool:Button("每15秒一只glitch",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        while true do -- Will run the script forever
          coroutine.wrap(function() require(game.ReplicatedStorage.ClientModules.EntityModules.Glitch).stuff(Data, workspace.CurrentRooms[tostring(game.ReplicatedStorage.GameData.LatestRoom.Value)]) end)() -- Coroutines prevent the script from yielding.
        task.wait(15) -- Waits somewhere around a millisecond before executing again. This is necessary so that the script won't crash your game. You can also add a time as such: task.wait(1) or task.wait(0.5)
        end
end)

tool:Button("每15秒一次心跳小游戏",function()
        local Data = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        while true do -- Will run the script forever
          coroutine.wrap(function() firesignal(game.ReplicatedStorage.Bricks.ClutchHeartbeat.OnClientEvent)  end)() -- Coroutines prevent the script from yielding.
        task.wait(15) -- Waits somewhere around a millisecond before executing again. This is necessary so that the script won't crash your game. You can also add a time as such: task.wait(1) or task.wait(0.5)
        end
end)

tool:Toggle("刷新时通知", "TZ", false, function(TZ)
     _G.IE = (TZ and true or false) LatestRoom.Changed:Connect(function() if _G.IE == true then local n = ChaseStart.Value - LatestRoom.Value if 0 < n and n < 4 then Notification:Notify("请注意", "事件可能刷新于" .. tostring(n) .. " 房间","rbxassetid://17360377302",3) end end end) workspace.ChildAdded:Connect(function(inst) if inst.Name == "RushMoving" and _G.IE == true then Notify("请注意", "Rush 已刷新","rbxassetid://17360377302",3) elseif inst.Name == "AmbushMoving" and _G.IE == true then Notify("请注意", "Ambush 已刷新","rbxassetid://17360377302",3) end end)
end)
tool:Toggle("自动躲避Rush/Ambush", "ADB", false, function(ADB)
    _G.Avoid = (ADB and true or false) workspace.ChildAdded:Connect(function(inst) if inst.Name == "RushMoving" and _G.Avoid == true then Notify("请注意!", "正在躲避 Rush.","rbxassetid://17360377302",3) local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position local con = game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0)) end) inst.Destroying:Wait() con:Disconnect() game.Players.LocalPlayer.Character:MoveTo(OldPos) elseif inst.Name == "AmbushMoving" and _G.Avoid == true then Notify("注意!", "正在躲避 Ambush.","rbxassetid://17360377302",3) local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position local con = game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0)) end) inst.Destroying:Wait() con:Disconnect() game.Players.LocalPlayer.Character:MoveTo(OldPos) end end)
end)
tool:Toggle("无 Screech", "NCH", false, function(NCH)
    _G.NS = (NCH and true or false) workspace.CurrentCamera.ChildAdded:Connect(function(child) if child.Name == "Screech" and _G.NS == true then child:Destroy() end end)
end)

local creds = window:Tab("范围",'6035145364')

local tool = creds:section("功能",true)

tool:Textbox("自定义范围", "HitBox", "请输入文本", function(Value)
   _G.HeadSize = Value
    _G.Disabled = true 
   game:GetService('RunService').RenderStepped:connect(function()
    if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
    pcall(function()
    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) 
   v.Character.HumanoidRootPart.Transparency = 0.7 
   v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
    v.Character.HumanoidRootPart.Material = "Neon"
    v.Character.HumanoidRootPart.CanCollide = false
    end)
    end 
   end 
   end
    end)
end)

tool:Button("范围100", function()
    _G.HeadSize = 100 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Button("范围150", function()
    _G.HeadSize = 150 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Button("范围200", function()
    _G.HeadSize = 200 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Button("范围250", function()
    _G.HeadSize = 250 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

tool:Button("范围300", function()
    _G.HeadSize = 300 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.HumanoidRootPart.Transparency = 0.7 v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue") v.Character.HumanoidRootPart.Material = "Neon" v.Character.HumanoidRootPart.CanCollide = false end) end end end end)
end)

local creds = window:Tab("力量传奇",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("自动比赛开关", "AR", false, function(AR)
  while AR do wait() wait(2) game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl") end
end)
tool:Toggle("自动举哑铃", "ATYL", false, function(ATYL)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATYL do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Weight" then v.Parent = game.Players.LocalPlayer.Character end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end
end)
tool:Toggle("自动俯卧撑", "ATFWC", false, function(ATFWC)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATFWC do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Pushups" then v.Parent = game.Players.LocalPlayer.Character end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end
end)
tool:Toggle("自动仰卧起坐", "ATYWQZ", false, function(ATYWQZ)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATYWQZ do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Situps" then v.Parent = game.Players.LocalPlayer.Character end end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end)
tool:Toggle("自动倒立身体", "ATDL", false, function(ATDL)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true local rs = game:GetService("RunService").RenderStepped while ATDL do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Handstands" then v.Parent = game.Players.LocalPlayer.Character end end end game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
end)
tool:Toggle("自动锻炼", "ATAAA", false, function(ATAAA)
  local part = Instance.new('Part', workspace) part.Size = Vector3.new(500, 20, 530.1) part.Position = Vector3.new(0, 100000, 133.15) part.CanCollide = true part.Anchored = true while ATAAA do wait() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0) for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v.ClassName == "Tool" and v.Name == "Handstands" or v.Name == "Situps" or v.Name == "Pushups" or v.Name == "Weight" then v:FindFirstChildOfClass("NumberValue").Value = 0 repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep") end end end
end)

tool:Toggle("自动重生", "ATRE", false, function(ATRE)
  while ATRE do wait() game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest") end
end)
tool:Button("收集宝石", function()
  jk = {} for _, v in pairs(game:GetService("ReplicatedStorage").chestRewards:GetDescendants()) do if v.Name ~= "Light Karma Chest" or v.Name ~= "Evil Karma Chest" then table.insert(jk, v.Name) end end for i = 1, #jk do wait(2) game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(jk[i]) end
end)

tool:Toggle("沙滩跑步机10", "PPJ10", false, function(PPJ10)
    getgenv().PPJ10 = PPJ10 while getgenv().PPJ10 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end if not getgenv().PPJ10 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
tool:Toggle("健身房跑步机2000", "PPJ2000", false, function(PPJ2000)
    if game.Players.LocalPlayer.Agility.Value >= 2000 then getgenv().PPJ2000 = PPJ2000 while getgenv().PPJ2000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-3005.37866, 14.3221855, -464.697876, -0.015773816, -1.38508964e-08, 0.999875605, -5.13225586e-08, 1, 1.30429667e-08, -0.999875605, -5.11104332e-08, -0.015773816) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().PPJ2000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
tool:Toggle("神话健身房跑步机2000", "SHPPJ2000", false, function(SHPPJ2000)
    if game.Players.LocalPlayer.Agility.Value >= 2000 then getgenv().SHPPJ2000 = SHPPJ2000 while getgenv().SHPPJ2000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2571.23706, 15.6896839, 898.650391, 0.999968231, 2.23868635e-09, -0.00797206629, -1.73198844e-09, 1, 6.35660768e-08, 0.00797206629, -6.3550246e-08, 0.999968231) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().SHPPJ2000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
tool:Toggle("永恒健身房跑步机3500", "YHPPJ3500", false, function(YHPPJ3500)
    if game.Players.LocalPlayer.Agility.Value >= 3500 then getgenv().YHPPJ3500 = YHPPJ3500 while getgenv().YHPPJ3500 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7077.79102, 29.6702118, -1457.59961, -0.0322036594, -3.31122768e-10, 0.99948132, -6.44344267e-09, 1, 1.23684493e-10, -0.99948132, -6.43611742e-09, -0.0322036594) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().YHPPJ3500 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)
tool:Toggle("传奇健身房跑步机3000", "CQPPJ3000", false, function(CQPPJ3000)
    if game.Players.LocalPlayer.Agility.Value >= 3000 then getgenv().CQPPJ3000 = CQPPJ3000 while getgenv().CQPPJ3000 do wait() game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 10 game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4370.82812, 999.358704, -3621.42773, -0.960604727, -8.41949266e-09, -0.27791819, -6.12478646e-09, 1, -9.12496567e-09, 0.27791819, -7.06329528e-09, -0.960604727) local oldpos = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:WaitForChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end end if not getgenv().CQPPJ3000 then local RunService = game:GetService("RunService") local Players = game:GetService("Players") local localPlayer = Players.LocalPlayer RunService:UnbindFromRenderStep("move", Enum.RenderPriority.Character.Value + 1, function() if localPlayer.Character then local humanoid = localPlayer.Character:FindFirstChild("Humanoid") if humanoid then humanoid:Move(Vector3.new(10000, 0, -1), true) end end end) end
end)

tool:Toggle("石头0", "RK0", false, function(RK0)
    getgenv().RK0 = RK0 while getgenv().RK0 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(7.60643005, 4.02632904, 2104.54004, -0.23040159, -8.53662385e-08, -0.973095655, -4.68743764e-08, 1, -7.66279342e-08, 0.973095655, 2.79580536e-08, -0.23040159) end if not getgenv().RK0 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end
end)
tool:Toggle("石头10", "RK10", false, function(RK10)
    if game.Players.LocalPlayer.Durability.Value >= 10 then getgenv().RK10 = RK10 while getgenv().RK10 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-157.680908, 3.72453046, 434.871185, 0.923298299, -1.81774684e-09, -0.384083599, 3.45247031e-09, 1, 3.56670582e-09, 0.384083599, -4.61917082e-09, 0.923298299) end if not getgenv().RK10 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头100", "RK100", false, function(RK100)
    if game.Players.LocalPlayer.Durability.Value >= 100 then getgenv().RK100 = RK100 while getgenv().RK100 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(162.233673, 3.66615629, -164.686783, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928) end if not getgenv().RK100 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头5000", "RK5000", false, function(RK5000)
    if game.Players.LocalPlayer.Durability.Value >= 5000 then getgenv().RK5000 = RK5000 while getgenv().RK5000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(329.831482, 3.66450214, -618.48407, -0.806075394, -8.67358096e-08, 0.591812849, -1.05715522e-07, 1, 2.57029176e-09, -0.591812849, -6.04919563e-08, -0.806075394) end if not getgenv().RK5000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头150000", "RK150000", false, function(RK150000)
    if game.Players.LocalPlayer.Durability.Value >= 150000 then getgenv().RK150000 = RK150000 while getgenv().RK150000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2566.78076, 3.97019577, -277.503235, -0.923934579, -4.11600105e-08, -0.382550538, -3.38838042e-08, 1, -2.57576183e-08, 0.382550538, -1.08360858e-08, -0.923934579) end if not getgenv().RK150000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头400000", "RK400000", false, function(RK400000)
    if game.Players.LocalPlayer.Durability.Value >= 400000 then getgenv().RK400000 = RK400000 while getgenv().RK400000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2155.61743, 3.79830337, 1227.06482, -0.551303148, -9.16796949e-09, -0.834304988, -5.61318245e-08, 1, 2.61027839e-08, 0.834304988, 6.12216127e-08, -0.551303148) end if not getgenv().RK400000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头750000", "RK750000", false, function(RK750000)
    if game.Players.LocalPlayer.Durability.Value >= 750000 then getgenv().RK750000 = RK750000 while getgenv().RK750000 do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-7285.6499, 3.66624784, -1228.27417, 0.857643783, -1.58175091e-08, -0.514244199, -1.22581563e-08, 1, -5.12025977e-08, 0.514244199, 5.02172774e-08, 0.857643783) end if not getgenv().RK750000 then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头100万", "RK1M", false, function(RK1M)
    if game.Players.LocalPlayer.Durability.Value >= 1000000 then getgenv().RK1M = RK1M while getgenv().RK1M do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4160.87109, 987.829102, -4136.64502, -0.893115997, 1.25481356e-05, 0.44982639, 5.02490684e-06, 1, -1.79187136e-05, -0.44982639, -1.37431543e-05, -0.893115997) end if not getgenv().RK1M then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)
tool:Toggle("石头500万", "RK5M", false, function(RK5M)
    if game.Players.LocalPlayer.Durability.Value >= 5000000 then getgenv().RK5M = RK5M while getgenv().RK5M do wait() for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") and v.Name == "Punch" then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v) end end for i,h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "Punch" then h:Activate() end end game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8957.54395, 5.53625107, -6126.90186, -0.803919137, 6.6065212e-08, 0.594738603, -8.93136143e-09, 1, -1.23155459e-07, -0.594738603, -1.04318865e-07, -0.803919137) end if not getgenv().RK5M then game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools() end end
end)

tool:Button("传送到出生点",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108)
end)

tool:Button("传送到安全岛",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, 10, 1838)
end)

tool:Button("传送到幸运抽奖区域",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2606, -2, 5753)
end)

tool:Button("传送到肌肉之王健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642)
end)

tool:Button("传送到传说健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915)
end)

tool:Button("传送到永恒健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284)
end)

tool:Button("传送到神话健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070)
end)

tool:Button("传送到冰霜健身房",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410)
end)

tool:Button("力量传奇改力量",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/jynzl/main/main/Musclas%20Legenos.lua'))()
end)

local creds = window:Tab("一次普通的露营故事",'6035145364')

local tool = creds:section("功能",true)   

tool:Button("透视怪物",function()
     loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()
end)

tool:Button("透视其他玩家",function()
     loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()
end)

local creds = window:Tab("超级大力士",'6035145364')

local tool = creds:section("功能",true)

tool:Button("传送到开始区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(85.86943817138672, 11.751949310302734, -198.07127380371094)
end)

tool:Button("传送到健身区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(93.60747528076172, 11.751947402954102, -10.266206741333008)
end)

tool:Button("传送到食物区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(78.86384582519531, 11.751947402954102, 228.9690399169922)
end)

tool:Button("传送到街机区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(88.99887084960938, 11.751949310302734, 502.90997314453125)
end)

tool:Button("传送到农场区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(85.6707763671875, 11.751947402954102, 788.5997314453125)
end)

tool:Button("传送到城堡区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(84.87281036376953, 11.84177017211914, 1139.7509765625)
end)

tool:Button("传送到蒸汽朋克区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(92.63227081298828, 11.841767311096191, 1692.7890625)
end)

tool:Button("传送到迪斯科区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(98.69613647460938, 16.015085220336914, 2505.213134765625)
end)

tool:Button("传送到太空区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(88.42948150634766, 11.841769218444824, 3425.941650390625)
end)

tool:Button("传送到糖果区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(63.55805969238281, 11.841663360595703, 4340.69921875)
end)

tool:Button("送到实验室区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(78.00920867919922, 11.841663360595703, 5226.60205078125)
end)

tool:Button("传送到热带区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80.26090240478516, 12.0902681350708, 6016.16552734375)
end)

tool:Button("传送到恐龙区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(38.4753303527832, 25.801530838012695, 6937.779296875)
end)

tool:Button("传送到复古区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(99.81867218017578, 12.89099407196045, 7901.74755859375)
end)

tool:Button("传送到冬季区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(63.47243881225586, 11.841662406921387, 8983.810546875)
end)

tool:Button("传送到深海区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(105.36250305175781, 26.44820213317871, 9970.0849609375)
end)

tool:Button("传送到狂野西部区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.69414520263672, 15.108586311340332, 10938.654296875)
end)

tool:Button("传送到豪华公寓区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.75145721435547, 11.313281059265137, 12130.349609375)
end)

tool:Button("传送到宝剑战斗区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(111.25597381591797, 11.408829689025879, 12945.57421875)
end)

tool:Button("传送到童话区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(121.14932250976562, 11.313281059265137, 14034.50390625)
end)

tool:Button("传送到桃花区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108.2142333984375, 11.813281059265137, 15131.861328125)
end)

tool:Button("传送到厨房区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.78338623046875, 21.76291847229004, 16204.9755859375)
end)

tool:Button("传送到下水道区域", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(47.36086654663086, 12.25178050994873, 17656.04296875)
end)

local creds = window:Tab("刀刃球",'6035145364')

local tool = creds:section("功能",true)

tool:Button("刀刃1",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/daorenqiu"))()
end)

tool:Button("刀刃2",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/main/RedCircleBlock"))()
end)

tool:Button("刀刃自动格挡",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3ABlade%20Ball%20Parry%20V4.0.0",true))()
end)

local creds = window:Tab("格林维尔",'6035145364')

local tool = creds:section("功能",true)

tool:Button("格林维尔",function()
loadstring(game:HttpGet("https://github.com/root-jiege/new/raw/refs/heads/main/KO"))()
end)

tool:Button("格林维尔2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8643/test/main/green"))()
end)

local creds = window:Tab("超级足球联赛",'6035145364')

local tool = creds:section("功能",true)

tool:Button("超级足球联赛1",function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/xtrey10x/xtrey10x-hub/main/neo")()
end)

tool:Button("超级足球联赛2",function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/8fdf7c482d3b3d108ccdb282a7fc35e2.lua"))()
end)

local creds = window:Tab("河北唐县",'6035145364')

local tool = creds:section("功能",true)
tool:Label("需要先成为送货司机，才能自动刷钱")
local function autoFarm()
    while _G.autoFarm do
        local clickDetector = game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector
        if clickDetector then
            local success, errorMsg = pcall(function()
                fireclickdetector(clickDetector)
            end)
            if not success then
                warn("Failed to fire ClickDetector: " .. errorMsg)
            end
        else
            warn("ClickDetector not found!")
        end
        
        task.wait(2.2)

        local deliveryPoints = game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()
        local delivered = false
        for _, point in ipairs(deliveryPoints) do
            if point:FindFirstChild("Locate") and point.Locate.Locate.Enabled then
                local hrp = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = point.CFrame
                    delivered = true
                    break
                end
            end
        end
        
        if not delivered then
            warn("No delivery point found!")
        end

        task.wait(0)
    end
end

tool:Toggle("自动刷钱", "AL", false, function(AM)
    _G.autoFarm = AM
    
    if AM then
        if not _G.autoFarmThread or not _G.autoFarmThread.Running then
            _G.autoFarmThread = coroutine.create(autoFarm)
            coroutine.resume(_G.autoFarmThread)
        end
    else
        if _G.autoFarmThread and _G.autoFarmThread.Running then
            coroutine.close(_G.autoFarmThread)
        end
    end
end)

tool:Toggle("自动刷钱", "AM", false, function(AM)
    local virtualUser = game:GetService('VirtualUser') virtualUser:CaptureController() function teleportTo(CFrame) game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame end _G.autoFarm = false function autoFarm() while _G.autoFarm do fireclickdetector(game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector) task.wait(2.2) for _,point in pairs(game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()) do if point.Locate.Locate.Enabled then teleportTo(point.CFrame) end end task.wait(0) end end
end)
tool:Label("变身功能")
local function autoFarm()
    while _G.autoFarm do
        local clickDetector = game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector
        if clickDetector then
            local success, errorMsg = pcall(function()
                fireclickdetector(clickDetector)
            end)
            if not success then
                warn("Failed to fire ClickDetector: " .. errorMsg)
            end
        else
            warn("ClickDetector not found!")
        end
        
        task.wait(2.2)

        local deliveryPoints = game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()
        local delivered = false
        for _, point in ipairs(deliveryPoints) do
            if point:FindFirstChild("Locate") and point.Locate.Locate.Enabled then
                local hrp = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = point.CFrame
                    delivered = true
                    break
                end
            end
        end
        
        if not delivered then
            warn("No delivery point found!")
        end

        task.wait(0)
    end
end

tool:Button("变成警察(需要先购买警察通行证)", function()
    local args = {
    [1] = "Police"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成平民", function()
    local args = {
    [1] = "Civilian"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成混合冰淇淋", function()
    local args = {
    [1] = "Mixue Ice Cream"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成咖啡师", function()
    local args = {
    [1] = "Teawen Barista"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成送货司机", function()
    local args = {
    [1] = "Delivery Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)


tool:Button("变成出租车司机", function()
    local args = {
    [1] = "Taxi Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)


tool:Button("变成线上计程车", function()
    local args = {
    [1] = "Ole Online Taxi Sharing"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成卡车司机", function()
    local args = {
    [1] = "Trucker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成超市收银员", function()
    local args = {
    [1] = "Grocery Cashier"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成罪犯", function()
    local args = {
    [1] = "Criminal"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成学生", function()
    local args = {
    [1] = "Student"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成老师", function()
    local args = {
    [1] = "Teacher"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成商店员工", function()
    local args = {
    [1] = "Store Worker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成变pao商店工人", function()
    local args = {
    [1] = "Pao Store Worker"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成救援人员", function()
    local args = {
    [1] = "Paramedic"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Button("变成巴车司机", function()
    local args = {
    [1] = "Bus Driver"
}

game:GetService("ReplicatedStorage").TeamSwitch:FireServer(unpack(args))

end)

tool:Label("传送")
local function autoFarm()
    while _G.autoFarm do
        local clickDetector = game:GetService("Workspace").DeliverySys.Misc["Package Pile"].ClickDetector
        if clickDetector then
            local success, errorMsg = pcall(function()
                fireclickdetector(clickDetector)
            end)
            if not success then
                warn("Failed to fire ClickDetector: " .. errorMsg)
            end
        else
            warn("ClickDetector not found!")
        end
        
        task.wait(2.2)

        local deliveryPoints = game:GetService("Workspace").DeliverySys.DeliveryPoints:GetChildren()
        local delivered = false
        for _, point in ipairs(deliveryPoints) do
            if point:FindFirstChild("Locate") and point.Locate.Locate.Enabled then
                local hrp = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = point.CFrame
                    delivered = true
                    break
                end
            end
        end
        
        if not delivered then
            warn("No delivery point found!")
        end

        task.wait(0)
    end
end

tool:Button("警察局", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5513.97412109375, 8.656171798706055, 4964.291015625)
end)
tool:Button("出生点", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3338.31982421875, 10.048742294311523, 3741.84033203125)
end)
tool:Button("医院", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5471.482421875, 14.149418830871582, 4259.75341796875)
end)
tool:Button("手机店", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6789.2041015625, 11.197686195373535, 1762.687255859375)
end)
tool:Button("火锅店", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5912.84765625, 12.217276573181152, 1058.29443359375)
end)

tool:Button("蜜雪冰城",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6984.87158203125, 9.332854270935059, 1734.770751953125)
end)

tool:Button("小区",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2187.541259765625, 22.092992782592773, -636.7048950195312)
end)

tool:Button("洗车店",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2578.51025390625, 23.332923889160156, -588.5584716796875)
end)

tool:Button("卡车召唤地",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10559.13671875, 39.31748580932617, 3236.519287109375)
end)

tool:Button("庆都山山顶",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15042.9033203125, 325.29852294921875, 22355.177734375)
end)

tool:Button("庆都山山底",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-15580.1357421875, 8.09992790222168, 21171.939453125)
end)

tool:Button("小学",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13888.138671875, 10.943490982055664, 11059.0458984375)
end)

tool:Button("签挂美食",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10332.763671875, 10.43997859954834, 7114.16064453125)
end)

tool:Button("驾校",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8912.12109375, 9.963741302490234, 7302.568359375)
end)

local creds = window:Tab("造船寻宝",'6035145364')

local tool = creds:section("功能",true)

    tool:Toggle(
    "自动刷金币",
    "text",
    false,
    function(FARM)
        _G.FARMs = FARM
        while _G.FARMs do
            wait()
            pcall(
                function()
                    game.Workspace.Gravity = 0
                    wait(0.5)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -51.05019,
                                43.5682182,
                                702.193481,
                                -0.999886811,
                                -0.000135422233,
                                0.0150433034,
                                8.65181704e-09,
                                0.999959469,
                                0.00900237076,
                                -0.0150439134,
                                0.00900135189,
                                -0.999846339
                            )
                        }
                    ):Play()
                    wait(1)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(30, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -50.4467354,
                                34.108551,
                                8676.95117,
                                -0.999937415,
                                -0.000405743311,
                                0.0111814411,
                                -6.1212857e-09,
                                0.999342263,
                                0.0362627953,
                                -0.0111888004,
                                0.0362605266,
                                -0.999279737
                            )
                        }
                    ):Play()
                    wait(30)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -54.1517258,
                                -359.077667,
                                9497.03418,
                                -0.99982208,
                                0.00359633542,
                                -0.0185163822,
                                -7.16419102e-09,
                                0.981655717,
                                0.190661997,
                                0.0188623965,
                                0.190628082,
                                -0.981481075
                            )
                        }
                    ):Play()
                    wait(5)
                    game.Workspace.Gravity = 200
                    wait(20)
                end
            )
        end
    end
)
tool:Toggle(
    "自动刷金币快速版",
    "text",
    false,
    function(FARM2)
        _G.FARM2s = FARM2
        while _G.FARM2s do
            wait()
            pcall(
                function()
                    game.Workspace.Gravity = 0
                    wait(0.5)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -51.05019,
                                43.5682182,
                                702.193481,
                                -0.999886811,
                                -0.000135422233,
                                0.0150433034,
                                8.65181704e-09,
                                0.999959469,
                                0.00900237076,
                                -0.0150439134,
                                0.00900135189,
                                -0.999846339
                            )
                        }
                    ):Play()
                    wait(1)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -50.4467354,
                                34.108551,
                                8676.95117,
                                -0.999937415,
                                -0.000405743311,
                                0.0111814411,
                                -6.1212857e-09,
                                0.999342263,
                                0.0362627953,
                                -0.0111888004,
                                0.0362605266,
                                -0.999279737
                            )
                        }
                    ):Play()
                    wait(5)
                    local TweenService = game:GetService("TweenService")
                    local Tw =
                        TweenService:Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            CFrame = CFrame.new(
                                -51.05019,
                                43.5682182,
                                702.193481,
                                -0.999886811,
                                -0.000135422233,
                                0.0150433034,
                                8.65181704e-09,
                                0.999959469,
                                0.00900237076,
                                -0.0150439134,
                                0.00900135189,
                                -0.999846339
                            )
                        }
                    ):Play()
                    wait(5)
                    local Event = game:GetService("Workspace").ClaimRiverResultsGold
                    Event:FireServer()
                    wait(0.1)
                    game.Players.LocalPlayer.Character.Humanoid.Health = -1000
                    wait(0.1)
                    game.Workspace.Gravity = 200
                    wait(7)
                end
            )
        end
    end
)
tool:Toggle(
    "自动索赔金币",
    "text",
    false,
    function(GlaimGold)
        _G.ClaimGolds = ClaimGold
        while _G.ClaimGolds do
            wait()
            pcall(
                function()
                    local Event = game:GetService("Workspace").ClaimRiverResultsGold
                    Event:FireServer()
                end
            )
        end

        MainSection:Button(
            "ClearAllBoatParts",
            function()
                local Event = game:GetService("Workspace").ClearAllPlayersBoatParts
                Event:FireServer()
            end
        )

        wait(0.5)
        local ba = Instance.new("ScreenGui")
        local ca = Instance.new("TextLabel")
        local da = Instance.new("Frame")
        local _b = Instance.new("TextLabel")
        local ab = Instance.new("TextLabel")
        ba.Parent = game.CoreGui
        ba.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ca.Parent = ba
        ca.Active = true
        ca.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
        ca.Draggable = true
        ca.Position = UDim2.new(0.698610067, 0, 0.098096624, 0)
        ca.Size = UDim2.new(0, 370, 0, 52)
        ca.Font = Enum.Font.SourceSansSemibold
        ca.Text = "Anti AFK Script"
        ca.TextColor3 = Color3.new(0, 1, 1)
        ca.TextSize = 22
        da.Parent = ca
        da.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
        da.Position = UDim2.new(0, 0, 1.0192306, 0)
        da.Size = UDim2.new(0, 370, 0, 107)
        _b.Parent = da
        _b.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
        _b.Position = UDim2.new(0, 0, 0.800455689, 0)
        _b.Size = UDim2.new(0, 370, 0, 21)
        _b.Font = Enum.Font.Arial
        _b.Text = "made by simon"
        _b.TextColor3 = Color3.new(0, 1, 1)
        _b.TextSize = 20
        ab.Parent = da
        ab.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
        ab.Position = UDim2.new(0, 0, 0.158377, 0)
        ab.Size = UDim2.new(0, 370, 0, 44)
        ab.Font = Enum.Font.ArialBold
        ab.Text = "Status: Active"
        ab.TextColor3 = Color3.new(0, 1, 1)
        ab.TextSize = 20

        local bb = game:service "VirtualUser"
        game:service "Players".LocalPlayer.Idled:connect(
            function()
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
                ab.Text = "机器人想踢你，但我踢了他"
                wait(2)
                ab.Text = "状态：Active"
            end
        )
    end
)

tool:Button(
    "无限方块（假）",
    function()
        spawn(
            function()
                local guiinf =
                    game:GetService("Players").LocalPlayer.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame
                _G.Blocks = false
                while game:GetService("RunService").RenderStepped:wait() do
                    if _G.Blocks then
                        return
                    end
                    for i, v in pairs(guiinf:GetDescendants()) do
                        if v.Name == "AmountText" then
                            v.Text = math.huge
                        end
                    end
                end
            end
        )
    end
)

local creds = window:Tab("战争大亨",'6035145364')

local tool = creds:section("功能",true)

tool:Button("一枪秒人",function()
    loadstring(game:HttpGet('https://pastebin.com/raw/6b4XEjQF'))()
end)

tool:Button("战争大亨1",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaguya11/KaguHubRework/refs/heads/main/Scripts/Loader.lua", true))("t.me/rbxscript_robot")
end)

tool:Button("战争大亨2",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/megamoeus/UI-Engine-V2/main/OWTPublic"))()
end)

local creds = window:Tab("画质",'6035145364')

local tool = creds:section("功能",true)

tool:Button("光影", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

tool:Button("光影滤镜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

tool:Button("超高画质",function()
loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

tool:Button("光影V4",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

tool:Button("RTX高仿",function()
loadstring(game:HttpGet('https://pastebin.com/raw/Bkf0BJb3'))()
end)

tool:Toggle("画质增强","GraphicsToggle",false,function(Value)
    -- 画质增强脚本（提升饱和度和画质，优化性能）
    local Lighting = game:GetService("Lighting")
    local RunService = game:GetService("RunService")
    
    local isRunning = Value
    local originalSettings = {}
    
    -- 保存原始设置
    local function saveOriginalSettings()
        originalSettings = {
            Brightness = Lighting.Brightness,
            GlobalShadows = Lighting.GlobalShadows,
            Ambient = Lighting.Ambient,
            OutdoorAmbient = Lighting.OutdoorAmbient,
            ColorShift_Bottom = Lighting.ColorShift_Bottom,
            ColorShift_Top = Lighting.ColorShift_Top,
            EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
            EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
            FogColor = Lighting.FogColor,
            FogEnd = Lighting.FogEnd,
            FogStart = Lighting.FogStart,
            ExposureCompensation = Lighting.ExposureCompensation,
            ShadowSoftness = Lighting.ShadowSoftness,
            Technology = Lighting.Technology,
            ClockTime = Lighting.ClockTime
        }
    end

    -- 应用画质增强设置
    local function applyEnhancedGraphics()
        -- 光照设置
        Lighting.Brightness = 2.5  -- 提高亮度
        Lighting.GlobalShadows = true  -- 启用全局阴影
        Lighting.Ambient = Color3.fromRGB(80, 80, 80)  -- 环境光
        Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)  -- 室外环境光
        
        -- 颜色增强（提高饱和度）
        Lighting.ColorShift_Bottom = Color3.fromRGB(10, 5, 0)  -- 暖色调
        Lighting.ColorShift_Top = Color3.fromRGB(5, 10, 15)  -- 冷色调
        
        -- 环境反射
        Lighting.EnvironmentDiffuseScale = 1.2  -- 提高漫反射
        Lighting.EnvironmentSpecularScale = 1.3  -- 提高镜面反射
        
        -- 雾效设置（增强深度感）
        Lighting.FogColor = Color3.fromRGB(150, 180, 210)
        Lighting.FogEnd = 1500
        Lighting.FogStart = 100
        
        -- 曝光补偿
        Lighting.ExposureCompensation = 0.3  -- 稍微提高曝光
        
        -- 阴影质量
        Lighting.ShadowSoftness = 0.8  -- 柔和阴影
        
        -- 使用最高质量渲染技术
        if Lighting.Technology == Enum.Technology.Voxel or Lighting.Technology == Enum.Technology.ShadowMap then
            Lighting.Technology = Enum.Technology.Future  -- 未来技术
        end
        
        -- 设置最佳时间（正午，光线最好）
        Lighting.ClockTime = 14  -- 下午2点
    end
    
    -- 应用后期处理效果
    local function applyPostProcessing()
        -- 创建颜色校正效果
        local colorCorrection = Instance.new("ColorCorrectionEffect")
        colorCorrection.Name = "EnhancedColorCorrection"
        colorCorrection.Brightness = 0.05
        colorCorrection.Contrast = 0.1
        colorCorrection.Saturation = 0.3  -- 提高饱和度
        colorCorrection.TintColor = Color3.fromRGB(255, 250, 245)  -- 暖色调
        colorCorrection.Parent = Lighting
        
        -- 创建Bloom效果（光晕）
        local bloom = Instance.new("BloomEffect")
        bloom.Name = "EnhancedBloom"
        bloom.Intensity = 0.4
        bloom.Size = 24
        bloom.Threshold = 0.9
        bloom.Parent = Lighting
        
        -- 创建景深效果（可选）
        local depthOfField = Instance.new("DepthOfFieldEffect")
        depthOfField.Name = "EnhancedDepthOfField"
        depthOfField.FarIntensity = 0.1
        depthOfField.NearIntensity = 0.3
        depthOfField.FocusDistance = 0.05
        depthOfField.InFocusRadius = 10
        depthOfField.Parent = Lighting
        
        -- 太阳光线效果
        local sunRays = Instance.new("SunRaysEffect")
        sunRays.Name = "EnhancedSunRays"
        sunRays.Intensity = 0.3
        sunRays.Spread = 1
        sunRays.Parent = Lighting
    end
    
    -- 优化天空盒
    local function enhanceSkybox()
        -- 设置高质量天空盒
        Lighting.Sky.MoonAngularSize = 11
        Lighting.Sky.SunAngularSize = 21
        
        -- 提高星星亮度
        if Lighting:FindFirstChild("StarCount") then
            Lighting.StarCount = 5000  -- 更多星星
        end
    end
    
    -- 性能优化监控
    local function setupPerformanceMonitor()
        local frameCount = 0
        local lastCheck = tick()
        
        local monitorConnection
        monitorConnection = RunService.Heartbeat:Connect(function()
            if not isRunning then
                monitorConnection:Disconnect()
                return
            end
            
            frameCount = frameCount + 1
            
            -- 每5秒检查一次性能
            if tick() - lastCheck >= 5 then
                lastCheck = tick()
                
                -- 如果帧率过低，自动降低一些效果
                local fps = frameCount / 5
                frameCount = 0
                
                if fps < 30 then
                    -- 自动调整效果保持性能
                    local bloom = Lighting:FindFirstChild("EnhancedBloom")
                    if bloom then
                        bloom.Intensity = math.min(bloom.Intensity, 0.2)
                    end
                end
            end
        end)
        
        return monitorConnection
    end
    
    -- 恢复原始设置
    local function restoreOriginalSettings()
        for setting, value in pairs(originalSettings) do
            pcall(function()
                Lighting[setting] = value
            end)
        end
        
        -- 移除后期处理效果
        local effects = {
            "EnhancedColorCorrection",
            "EnhancedBloom", 
            "EnhancedDepthOfField",
            "EnhancedSunRays"
        }
        
        for _, effectName in ipairs(effects) do
            local effect = Lighting:FindFirstChild(effectName)
            if effect then
                effect:Destroy()
            end
        end
    end
    
    -- 主执行函数
    if Value then
        -- 开启画质增强
        saveOriginalSettings()
        applyEnhancedGraphics()
        applyPostProcessing()
        enhanceSkybox()
        local monitorConnection = setupPerformanceMonitor()
        
        print("画质增强已激活 - 饱和度和视觉效果提升")
        
        -- 返回关闭函数
        return function()
            isRunning = false
            if monitorConnection then
                monitorConnection:Disconnect()
            end
            restoreOriginalSettings()
            print("画质增强已关闭")
        end
        
    else
        -- 关闭画质增强
        restoreOriginalSettings()
        print("画质增强已关闭")
    end
end)

tool:Button("光影深", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

tool:Button("光影浅", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

local creds = window:Tab("透视",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("Circle ESP", "ESP", false, function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end)

tool:Button("透视1",function()
loadstring(game:HttpGet('https://pastebin.com/raw/MA8jhPWT'))()
end)

tool:Button("透视2",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
end)

local creds = window:Tab("飞行功能",'6035145364')

local tool = creds:section("功能",true)

tool:Button("飞行",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/gqv7PXAa"))()
end)

tool:Button("驰飞行",function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/%E9%A9%B0%E9%A3%9E%E8%A1%8C.lua"))()
end)

tool:Button("飞行v1",function()
       loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\90\66\122\99\84\109\49\102\34\41\41\40\41\10")()
end)

tool:Button("飞行V3",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/nkhg0q5K"))()
end)

local creds = window:Tab("内脏与黑火药",'6035145364')

local tool = creds:section("功能",true)

tool:Button("内脏与黑火药1",function()
        loadstring(game:HttpGet(("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\110\66\56\109\114\54\107\117"),true))()
end)

tool:Button("内脏与黑火药2",function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\102\121\46\97\112\112\47\65\51\78\113\122\52\78\112\47\114\97\119"))()
end)

local creds = window:Tab("自然灾害",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("地图投票用户界面", "Map Voting UI", false, function(bool)
if bool == false then do game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = false
    end
end
if bool == true then do game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = true
    end
end
end)

tool:Toggle("在水上行走", "ToggleInfo", false, function(bool)
 if bool == false then do game.Workspace.WaterLevel.CanCollide = false
                            game.Workspace.WaterLevel.Size = Vector3.new(10, 1, 10)
                        end
                    end
                    if bool == true then do game.Workspace.WaterLevel.CanCollide = true
                            game.Workspace.WaterLevel.Size = Vector3.new(5000, 1, 5000)
                        end
                    end
end)

tool:Toggle("游戏岛悬崖碰撞", "Togglelnfo", false, function(bool)
for i, v in pairs (game.workspace:GetDescendants())do
                                if v.Name == 'LowerRocks' then
                                    v.CanCollide = bool
                                end
                            end
end)

tool:Toggle("禁用坠落损坏",function()
local FallDamageScript = (game.Players.LocalPlayer.Character ~= nil) and game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") or nil
                                if FallDamageScript then
                                FallDamageScript:Destroy()
                                end
end)

tool:Toggle("自动禁用坠落伤害", "Toggleelnfo", false, function(bool)
_G.NoFallDamage = bool;
                            while wait(0.5) do
                                    if _G.NoFallDamage == true then
                            local FallDamageScript = (game.Players.LocalPlayer.Character ~= nil) and game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") or nil
                            if FallDamageScript then
                            FallDamageScript:Destroy()
                            end end end
end)

tool:Button("打印下一次灾难(/console)",function()
warn(game.Players.LocalPlayer.Character.SurvivalTag.Value)
end)

tool:Button("移除灾难界面(暴风雪和沙尘暴)",function()
game.Players.LocalPlayer.PlayerGui.BlizzardGui:destroy()
                game.Players.LocalPlayer.PlayerGui.SandStormGui:destroy()
end)

tool:Button("传送到地图",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-115.828506, 65.4863434, 18.8461514, 0.00697017973, 0.0789371505, -0.996855199, -3.13589936e-07, 0.996879458, 0.0789390653, 0.999975681, -0.000549906865, 0.00694845384)
end)

tool:Button("游戏岛",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-83.5, 38.5, -27.5, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

tool:Button("产卵塔",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-280, 170, 341, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)

local creds = window:Tab("监狱人生",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("删除门","text",false,function(state)
if state then
        print("Toggle On")
        for i,v in pairs(workspace.Doors:GetChildren()) do
             v.Parent = game:service"ReplicatedStorage".nikodoors

        end
    else
        print("Toggle Off")
        for i,v in pairs(game:service"ReplicatedStorage".nikodoors:GetChildren()) do
            v.Parent = workspace.Doors
        end
    end
end)
tool:Toggle("逮捕所有罪犯", function()
    wait(0.1)
        Player = game.Players.LocalPlayer
        Pcf = Player.Character.HumanoidRootPart.CFrame
        for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
                if v.Name ~= Player.Name then
                        local i = 10
                        repeat
                                wait()
                                i = i-1
                                game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
                                Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                        until i == 0
                end
        end
end)

tool:Button("变成警察", function()
workspace.Remote.TeamEvent:FireServer("Bright blue");
end)

tool:Button("变成囚犯", function()
workspace.Remote.TeamEvent:FireServer("Bright orange");
end)

local MT = getrawmetatable(game)
local __namecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FindPartOnRay" and not checkcaller() and tostring(getfenv(0).script) == "GunInterface" then
        local Character = ClosestChar()
        if Character then
            return Character.Torso, Character.Torso.Position
        end
    end

    return __namecall(self, ...)
end)
setreadonly(MT, true)
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
tool:Button("无敌模式",function()
        loadstring(game:HttpGet("https://pastebin.com/raw/LdTVujTA"))()
end)
tool:Button(
    "杀死所有人",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/kXjfpFPh"))()
    end
)
tool:Button(
    "无敌神器（拿上范围秒杀）",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/mSLiAZHk"))()
    end
)
tool:Button(
    "变钢铁侠",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/7prijqYH"))()
    end
)
tool:Button(
    "变死神",
    function()
        loadstring(game:HttpGet("https://pastebin.com/ewv9bbRp"))()
    end
)
tool:Button(
    "变车模型",
    function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zLe3e4BS"))()
    end
)


tool:Button(
    "PRISONWARE V1.3",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/PRISONWARE_v1.3.txt"))()
    end
)

tool:Button(
    "警卫室",
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)
    end
)
tool:Button(
    "监狱室内",
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)
    end
)
tool:Button(
    "罪犯复活点",
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)
    end
)
tool:Button(
    "监狱室外",
    function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
    end
)

local creds = window:Tab("感染性微笑",'6035145364')

local tool = creds:section("功能",true)

tool:Button("防止微笑感染",function()
    for _,v in pairs(game.workspace:GetDescendants()) do
        if string.find(v.Name,"Infector") then
            v:Destroy()
        end
    end
end)

tool:Button("取消门",function()
    for _,v in pairs(game.workspace:GetDescendants()) do
        if string.find(v.Name,"AntiSmiler") then
            v:Destroy()
        end
    end
end)

tool:Button("开启反外挂",function()
    workspace.Map.AntiHack:Destroy() 
    game.Players.LocalPlayer.Character.AntiFly:Destroy()
end)

tool:Toggle("速度-微笑感染","text",false,function(s)
    getgenv().SlowDownSpeed = getgenv().SlowDownSpeed or 16
    getgenv().NoSlowDown = s
    if getgenv().NoSlowDown then
        SteppedConnection = game:GetService("RunService").Stepped:Connect(function()
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().SlowDownSpeed
            end)
        end)
    else
        if SteppedConnection then
            SteppedConnection:Disconnect()
            SteppedConnection = nil
        end
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

tool:Toggle("打击微笑感染","text",false,function(s)
    getgenv().InfectAura = s
    if getgenv().InfectAura then
        getgenv().InfectAuraConnection = game:GetService("RunService").Stepped:Connect(function()
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Infected.InfectEvent:FireServer()
            end)
        end)
    else
        if getgenv().InfectAuraConnection then
            getgenv().InfectAuraConnection:Disconnect()
            getgenv().InfectAuraConnection = nil
        end
    end
end)

tool:Toggle("Bat打击","text",false,function(s)
    getgenv().HitAura = s
    if getgenv().HitAura then
        getgenv().HitAuraConnection = game:GetService("RunService").Stepped:Connect(function()
            pcall(function()
                local character = game:GetService("Players").LocalPlayer.Character
                if character then
                    local bat = character:FindFirstChildOfClass("Tool")
                    if bat and bat.Name == "Bat" and bat:FindFirstChild("SwingEvent") then
                        bat.SwingEvent:FireServer()
                    end
                    local packedice = character:FindFirstChild("Packed Ice")
                    if packedice and packedice.Name == "Packed Ice" and packedice:FindFirstChild("SwingEvent") then
                        packedice.SwingEvent:FireServer()
                    end
                end
            end)
        end)
    else
        if getgenv().HitAuraConnection then
            getgenv().HitAuraConnection:Disconnect()
            getgenv().HitAuraConnection = nil
        end
    end
end)

tool:Toggle("瓶子打击","text",false,function(s)
    getgenv().HitAura = s
    if getgenv().HitAura then
        getgenv().HitAuraConnection = game:GetService("RunService").Stepped:Connect(function()
            pcall(function()
                local character = game:GetService("Players").LocalPlayer.Character
                if character then
                    local bottle = character:FindFirstChildOfClass("Tool")
                    if bottle and bottle.Name == "Bottle" and bottle:FindFirstChild("SwingEvent") then
                        bottle.SwingEvent:FireServer()
                    end
                    local packedice = character:FindFirstChild("Packed Ice")
                    if packedice and packedice.Name == "Packed Ice" and packedice:FindFirstChild("SwingEvent") then
                        packedice.SwingEvent:FireServer()
                    end
                end
            end)
        end)
    else
        if getgenv().HitAuraConnection then
            getgenv().HitAuraConnection:Disconnect()
            getgenv().HitAuraConnection = nil
        end
    end
end)

local creds = window:Tab("奇怪严格的爸爸",'6035145364')

local tool = creds:section("功能",true)

tool:Button("奇怪严格的爸爸",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/yBloodz/Free-scripts/main/Weird%20Strict%20Dad"))()
end)

local creds = window:Tab("破坏模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Button("破坏模拟器",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/AquaModz/DestructionSIMModded/main/DestructionSimAqua.lua'))()
end)

tool:Button("无限射击",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/AquaModz/DestructionSIMModded/main/DestructionSimAqua.lua'))()
end)

local creds = window:Tab("奎尔湖",'6035145364')

local tool = creds:section("功能",true)

tool:Button("奎尔湖",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Solx69/Shit-Boy-Hub-Main/main/Master.lua'))()
end)

tool:Toggle("无敌模式","", false, function(Value)
        game.ReplicatedStorage.DamageHumanoid:FireServer(-2e9)
    end)
    
    tool:Button("无限金钱", function()
    local money = {
       [1] = -9999,
       [2] = "Buy"
    }
    
    game:GetService("ReplicatedStorage").Pay:FireServer(unpack(money))
    end)
    
    tool:Button("无限金币", function()
    local gold = {
       [1] = game:GetService("Players").LocalPlayer.GoldCoins,
       [2] = 99999
    }
    
    game:GetService("ReplicatedStorage").ChangeValue:FireServer(unpack(gold))
    end)
    
    tool:Button("给所有物品", function()
    game.ReplicatedStorage.GiveTool:FireServer("SeaScooter")
    game.ReplicatedStorage.GiveTool:FireServer("Lantern")
    game.ReplicatedStorage.GiveTool:FireServer("Compass")
    game.ReplicatedStorage.GiveTool:FireServer("ItemFinder")
    game.ReplicatedStorage.GiveTool:FireServer("Aquabreather")
    end)
    
    tool:Button("红色套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("FireSuit")
    end)
    
    tool:Button("黄色套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("HazmatSuit")
    end)
    
    tool:Button("海盗套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("PirateCostume")
    end)
    
    tool:Button("动力套装", function()
    game.ReplicatedStorage.ChangeOutfits:FireServer("SuperScuba")
    end)

local creds = window:Tab("钓鱼模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("跳跃","text",false,function(s)
shared.toggle = State
     if shared.toggle then
    fuckMonster = RunService.Stepped:Connect(function()
     for i, v in pairs(game.Workspace:GetChildren()) do
     if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then


                    for i, getTools in pairs(player.Character:GetChildren()) do
                        if getTools:IsA("Tool") and  getTools:FindFirstChild("GripC1") then
                            plrTools = getTools.Name
                        end
                    end

                    teleport(v.HumanoidRootPart.CFrame + Vector3.new(0, 30, 0))
                    wait(1)
                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.MonsterHit:FireServer(workspace[v.Name], tostring(plrTools), true)
                    break
                elseif not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    EquipTool()
               break
            end
        end
     end
     end)
    else
         fuckMonster:Disconnect()
          teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))
        end
end)
tool:Toggle("自动杀鲨鱼","text",false,function(State)
 shared.toggle = State
     if shared.toggle then
    fuckMonster = RunService.Stepped:Connect(function()
     for i, v in pairs(game.Workspace:GetChildren()) do
     if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then


                    for i, getTools in pairs(player.Character:GetChildren()) do
                        if getTools:IsA("Tool") and  getTools:FindFirstChild("GripC1") then
                            plrTools = getTools.Name
                        end
                    end

                    teleport(v.HumanoidRootPart.CFrame + Vector3.new(0, 30, 0))
                    wait(1)
                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.MonsterHit:FireServer(workspace[v.Name], tostring(plrTools), true)
                    break
                elseif not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    EquipTool()
               break
            end
        end
     end
     end)
    else
         fuckMonster:Disconnect()
          teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))
        end
end)
tool:Toggle("自动钓鱼","text",false,function(bool)
 if bool then
            local rodName = false
            while not rodName do
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:FindFirstChild("FishingRodScript") then
                        rodName = v.Name
                        break
                    end
                end
                wait()
            end

            bBobber = game.Players.LocalPlayer.Character:WaitForChild(rodName).Bobbers.Bobber.Fish.Changed:Connect(
                function(fishVal)
                    if fishVal ~= nil then
                        --if not legendToggle then
                            game.Workspace:WaitForChild(tostring(fishVal))
                            wait()
                            game.ReplicatedStorage.CloudClientResources.Communication.Events.FishedDone:FireServer()
                            wait()
                            game.ReplicatedStorage.CloudClientResources.Communication.Events.ResetFishingRod:FireServer()
                            wait()
                        --[[else
                            if game.Workspace:WaitForChild(tostring(fishVal)).RarityLevel.Value >= 5 then
                                game.ReplicatedStorage.CloudClientResources.Communication.Events.FishedDone:FireServer()
                                wait()
                                game.ReplicatedStorage.CloudClientResources.Communication.Events.ResetFishingRod:FireServer()
                                wait()
                            end                                                                                                 
                        end                                                                                                        --]]
					end
					if game.Players.LocalPlayer.Character:WaitForChild(rodName).Bobbers.Bobber:FindFirstChild("FishWeld") then
						for p, q in pairs(game.Players.LocalPlayer.Character:WaitForChild(rodName).Bobbers.Bobber:GetChildren()) do
							if q.Name == "FishWeld" then
								q:Destroy()
							end
						end
					end
                end
            )
        else 
            bBobber:Disconnect()
        end
end)
tool:Toggle("自动杀boss","text",false,function(State)
 shared.toggle = State
     if shared.toggle then
    fuckMobby = RunService.Stepped:Connect(function()
     for i, v in pairs(game.Workspace:GetChildren()) do
     if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") and v.Name == "MobbyWood" then
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then


                    for i, getTools in pairs(player.Character:GetChildren()) do
                        if getTools:IsA("Tool") and  getTools:FindFirstChild("GripC1") then
                            plrTools = getTools.Name
                        end
                    end

                    teleport(v.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0))
                    wait(1)
                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.MonsterHit:FireServer(workspace[v.Name], tostring(plrTools), true)
                    break
                elseif not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    EquipTool()
               break
            end
        end
     end
     end)
    else
         fuckMobby:Disconnect()
          teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))
        end
end)
tool:Toggle("减少延迟","text",false,function(State)
 toggle = State
     if toggle then
        while toggle do 
            wait(30)
            for i, v in pairs(game.Workspace.DroppedItems:GetChildren()) do
                if v:IsA("Model") then
                    v:Destroy()
                end
            end
        end
      end
end)
tool:Toggle("自动锁定稀有物品","text",false,function(State)
 toggle = State
     if toggle then
        while toggle do 
            wait(.1)
for i, v in pairs(game.Players.LocalPlayer.PlayerGui.Interface.Inventory.Inventory.Frame.Backpack.List.Container:GetChildren()) do
        if string.match(v.Name, "key") then
            for i, model in pairs(v:GetDescendants()) do
                if model:IsA("Tool") then
                    if model.RarityLevel.Value >= 5 then

                        if v.DraggableComponent.Contents.LockIcon.Visible == false then
                            print(v.Name, model.Name, model.RarityLevel.Value)
                        local args = {
                            [1] = "Tools",
                            [2] = v.Name,
                            [3] = true
                        }
                        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.SetInventoryItemLock:InvokeServer(unpack(args))

                        end
                    end
                end
            end
        end
end

        end
      end
end)
tool:Toggle("自动抓捕","text",false,function(State)
 toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.FishCaught:FireServer()
    end
end)
tool:Toggle("自动售卖","text",false,function(State)
 toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.processGameItemSold:InvokeServer("SellEverything")
    end
end)
tool:Toggle("每日宝箱","text",false,function(State)
 toggle = State
        while toggle do
                for i, v in pairs(game.Workspace.Islands:GetDescendants()) do
                    if v:IsA("Model") and string.match(v.Name, "Chest") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        wait(1)
                        fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
                    end
                end            
        end
end)
tool:Toggle("随机宝箱","text",false,function(State)
 toggle = State
        while toggle do
                for i, v in pairs(game.Workspace.RandomChests:GetDescendants()) do
                    if v:IsA("Model") and string.match(v.Name, "Chest") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        wait(1)
                        fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
                    end
                end            
        end
end)
local wood_types = {"选择", "Earth Egg","Alien Egg","Dominus Egg","Ice Egg","Lava Egg","Heavens Egg","Toy Egg","Mine Egg"}
if not game.workspace:FindFirstChild("PFA") then 
    local part = Instance.new("Part") 
    part.Name = "PFA" 
    part.Parent = game.workspace 
    part.CFrame = CFrame.new(-1087, -40, 1670) 
    part.Size = Vector3.new(50, 0, 50) 
    part.Anchored = true 
    part.Reflectance = 1 
end

function C() 
    spawn(function () 
        while getgenv().C do
            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
                TPCFrame(CFrame.new(-1087, -35, 1670))
                if v.ToolTip == "Weight" then 
                    v.Parent = game.Players.LocalPlayer.Character 
                end
                if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then 
                    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate() 
                end
            end 
            wait()
        end
    end)
end

function U() 
    spawn(function () 
        while getgenv().U do
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Damage_Multiplier"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Health_Multiplier"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Jump_Power"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Walk_Speed"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Pet_Space"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            local args = {[1] = "S_Controller_Upgrades_Upgrade",[2] = {[1] = "Pet_Inventory"}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            wait()
        end
    end)
end

function R() 
    spawn(function () 
        while getgenv().R do
            local args = {[1] = "S_Controller_Rebirth_Rebirth",[2] = {}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteEvent:FireServer(unpack(args))
            wait()
        end
    end)
end

function H(E) 
    spawn(function () 
        while getgenv().H do
            local args = {[1] = "S_Controller_Eggs_Buy",[2] = {[1] = E}}
            game:GetService("ReplicatedStorage").Shared.Services:FindFirstChild("3 | Network").RemoteFunction:InvokeServer(unpack(args))
            wait()
        end
    end)
end

local creds = window:Tab("火箭发射模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("自动收集燃料", "ARL", false, function(ARL)
    isFuelScoopEnabled = ARL while true do wait() if isFuelScoopEnabled then for i, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if h:IsA("Tool") and h.Name == "FuelScoop" then h:Activate() end end end end
end)
tool:Button("登上火箭", function()
    game:GetService("ReplicatedStorage"):WaitForChild("BoardRocket"):FireServer()
end)
tool:Button("将玩家从所有者座位移除", function()
    game:GetService("ReplicatedStorage"):WaitForChild("RemovePlayer"):FireServer()
end)

tool:Button("发射台岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-123.15931701660156, 2.7371432781219482, 3.491959810256958)
end)
tool:Button("白云岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-76.13252258300781, 170.55825805664062, -60.4516716003418)
end)
tool:Button("浮漂岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-66.51714324951172, 720.4866333007812, -5.391753196716309)
end)
tool:Button("卫星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-34.2462043762207, 1429.4990234375, 1.3739361763000488)
end)
tool:Button("蜜蜂迷宫岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6.5361199378967285, 3131.249267578125, -29.759048461914062)
end)
tool:Button("月球人救援", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7.212917804718018, 5016.341796875, -19.815933227539062)
end)
tool:Button("暗物质岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(68.43186950683594, 6851.94091796875, 7.890637397766113)
end)
tool:Button("太空岩石岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(49.92888641357422, 8942.955078125, 8.674375534057617)
end)
tool:Button("零号火星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(54.44503402709961, 11270.0927734375, -1.273137092590332)
end)
tool:Button("太空水晶小行星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11.579089164733887, 15295.6318359375, -27.54974365234375)
end)
tool:Button("月球浆果岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-14.601255416870117, 18410.9609375, 0.9418511986732483)
end)
tool:Button("铺路石岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3.272758960723877, 22539.494140625, 63.283935546875)
end)
tool:Button("流星岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-45.515689849853516, 27961.560546875, -7.358333110809326)
end)
tool:Button("升级岛", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2.7595248222351074, 33959.98828125, 53.93095397949219)
end)

tool:Button("火箭发射模拟器1",function()
loadstring(game:HttpGet("https://ayangwp.cn/api/v3/file/get/9245/%E7%8C%AB%E9%80%9A%E7%94%A8.txt?sign=hrWROZdVfK2mtJcIFa3Tvbl-TojP1C86_Zd3q03qttc%3D%3A0"))()
end)

tool:Button("火箭发射模拟器2",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/dizyhvh/rbx_scripts/main/321_blast_off_simulator')))()
end)

tool:Button("火箭发射模拟器3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/odhdshhe/jm-/refs/heads/main/jm%E7%81%AB%E7%AE%AD%E5%8F%91%E5%B0%84%E9%87%8D%E5%81%9A(1).lua"))()
end)

local creds = window:Tab("巴掌大作战",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("无CD","Toggle" ,false, function(Value)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local tool = character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
    
    bazhangmnq = Value
    
    while bazhangmnq do
    local localscript = tool:FindFirstChildOfClass("LocalScript")
    local localscriptclone = localscript:Clone()
    localscriptclone = localscript:Clone()
    localscriptclone:Clone()
    localscript:Destroy()
    localscriptclone.Parent = tool
    wait(0.1)
    end
    end)
    
    tool:Button("获取计数器手套", function()
    fireclickdetector(game.Workspace.CounterLever.ClickDetector)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,100,0)
    wait(0.2)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    wait(121)
    for i,v in pairs(workspace.Maze:GetDescendants()) do
    if v:IsA("ClickDetector") then
    fireclickdetector(v)
    end
    end
    end)
    
    tool:Toggle("地牢亮度","Toggle" ,false, function(Value)
     Light = Value
        if not Light then
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end)
    
    tool:Dropdown("传送","Dropdown",{"安全区","竞技场","埃及岛","果实岛","盘子","锦标赛","默认竞技场"},function(Value)
    if Value == "安全区" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Spot.CFrame * CFrame.new(0,40,0)
    elseif Value == "竞技场" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,-5,0)
    elseif Value == "埃及岛" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(215, -15.5, 0.5)
    elseif Value == "果实岛" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Arena.island5.Union.CFrame * CFrame.new(0,3.25,0)
    elseif Value == "盘子" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Arena.Plate.CFrame * CFrame.new(0,2,0)
    elseif Value == "锦标赛" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Battlearena.Arena.CFrame * CFrame.new(0,10,0)
    elseif Value == "默认竞技场" then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(120,360,-3)
    end
    end)
    
    tool:Toggle("复古技能","Toggle" ,false, function(Value)
    RetroSpam = Value
    while RetroSpam do
    game:GetService("ReplicatedStorage").RetroAbility:FireServer(RetroAbility)
    task.wait()
    end
    end)
    
    tool:Dropdown("复古技能选择","Dropdown",{"Rocket Launcher","Ban Hammer","Bomb"}, function(Value)
    RetroAbility = Value
    end)
    
    tool:Toggle("自动捡糖果","Toggle",false, function(Value)
    CandyCornFarm = Value
    while CandyCornFarm do
    for i, v in pairs(workspace.CandyCorns:GetChildren()) do
                    if v:FindFirstChildWhichIsA("TouchTransmitter") then
    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
    task.wait()
    end
    end)
    
    tool:Toggle("获取炼金术师材料","Toggle", false, function(Value)
    AlchemistIngredients = Value
    if game.Players.LocalPlayer.leaderstats.Glove.Value == "Alchemist" then
    while AlchemistIngredients do
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Mushroom")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Glowing Mushroom")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Fire Flower")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Winter Rose")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Dark Root")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Dire Flower")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Autumn Sprout")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Elder Wood")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Hazel Lily")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Wild Vine")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Jade Stone")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Lamp Grass")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Plane Flower")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Blood Rose")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Red Crystal")
    game.ReplicatedStorage.AlchemistEvent:FireServer("AddItem","Blue Crystal")
    task.wait()
    end
    end
    end)
    
    tool:Toggle("自动加入竞技场","Toggle", false, function(Value)
    AutoEnterArena = Value
    while AutoEnterArena do
    if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
        end
    task.wait()
    end
    end)
    
    tool:Toggle("自动光波球","Toggle", false, function(Value)
    if Person == nil then
    Person = game.Players.LocalPlayer.Name
    end
    _G.RojoSpam = Value
    while _G.RojoSpam do
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players[Person].Character.HumanoidRootPart.CFrame})
    task.wait()
    end
    end)
    
    tool:Button("Rojo技能", function(Value)
    _G.RojoSpam = Value
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Charge")
    wait(6)
    game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame})
    task.wait()
    end)
    
    tool:Toggle("音符技能","Toggle", false, function(Value)
    _G.RhythmSpam = Value
    while _G.RhythmSpam do
    game:GetService("ReplicatedStorage").rhythmevent:FireServer("AoeExplosion",0)
    task.wait()
    end
    end)
    
    tool:Toggle("Null技能","Toggle", false, function(Value)
    NullSpam = Value
    while NullSpam do
    game:GetService("ReplicatedStorage").NullAbility:FireServer()
    task.wait()
    end
    end)
    
    tool:Toggle("自动拾取黄金果实","Toggle", false, function(Value)
    SlappleFarm = Value
    while SlappleFarm do
    for i, v in ipairs(workspace.Arena.island5.Slapples:GetDescendants()) do
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Name == "Glove" and v:FindFirstChildWhichIsA("TouchTransmitter") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                    end
                end
    task.wait()
    end
    end)
    
    tool:Toggle("自动捡飞行宝珠","Toggle", false, function(Value)
    Jetfarm = Value
    while Jetfarm do
    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "JetOrb" and v:FindFirstChild("TouchInterest") then
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 0)
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 1)
                        end
                    end
    task.wait()
    end
    end)
    
    tool:Toggle("自动捡相位球","Toggle", false, function(Value)
    Phasefarm = Value
    while Phasefarm do
    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "PhaseOrb" and v:FindFirstChild("TouchInterest") then
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 0)
    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 1)
                        end
                    end
    task.wait()
    end
    end)
    
    tool:Toggle("自动刷bob","Toggle", false, function(Value)
    ReplicaFarm = Value
    while ReplicaFarm do
    for i, v in pairs(workspace:GetChildren()) do
                    if v.Name:match(game.Players.LocalPlayer.Name) and v:FindFirstChild("HumanoidRootPart") then
    game.ReplicatedStorage.b:FireServer(v:WaitForChild("HumanoidRootPart"))
                    end
                end
    task.wait()
    game:GetService("ReplicatedStorage").Duplicate:FireServer()
    task.wait(7)
    end
    end)
    
    tool:Toggle("无限反转","Toggle", false, function(Value)
    _G.InfReverse = Value
    while _G.InfReverse do
    game:GetService("ReplicatedStorage").ReverseAbility:FireServer()
    wait(6)
    end
    end)
    
    tool:Toggle("彩虹角色(装备黄金手套)","Toggle", false, function(Value)
    _G.Rainbow = Value
    while _G.Rainbow do
    for i = 0,1,0.001*25 do
    game:GetService("ReplicatedStorage").Goldify:FireServer(false, BrickColor.new(Color3.fromHSV(i,1,1)))
    task.wait()
    end
    end
    end)
    
    tool:Toggle("防击飞","Toggle", false, function(Value)
    AntiRagdoll = Value
    if AntiRagdoll then
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
    game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Changed:Connect(function()
    if game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == true and AntiRagdoll then
    repeat task.wait() game.Players.LocalPlayer.Character.Torso.Anchored = true
    until game.Players.LocalPlayer.Character:WaitForChild("Ragdolled").Value == false
    game.Players.LocalPlayer.Character.Torso.Anchored = false
    end
    end)
    end)
    end
    end)
    
    tool:Toggle("反虚空(锦标赛也有效果)","Toggle", false, function(Value)
    game.Workspace.dedBarrier.CanCollide = Value
    game.Workspace.TAntiVoid.CanCollide = Value
    end)

tool:Toggle("防死亡屏障","Toggle", false, function(Value)
    if Value == true then
    for i,v in pairs(game.Workspace.DEATHBARRIER:GetChildren()) do
                        if v.ClassName == "Part" and v.Name == "BLOCK" then
                            v.CanTouch = false
                        end
                    end
    workspace.DEATHBARRIER.CanTouch = false
    workspace.DEATHBARRIER2.CanTouch = false
    workspace.dedBarrier.CanTouch = false
    workspace.ArenaBarrier.CanTouch = false
    workspace.AntiDefaultArena.CanTouch = false
    else
    for i,v in pairs(game.Workspace.DEATHBARRIER:GetChildren()) do
                        if v.ClassName == "Part" and v.Name == "BLOCK" then
                            v.CanTouch = true
                        end
                    end
    workspace.DEATHBARRIER.CanTouch = true
    workspace.DEATHBARRIER2.CanTouch = true
    workspace.dedBarrier.CanTouch = true
    workspace.ArenaBarrier.CanTouch = true
    workspace.AntiDefaultArena.CanTouch = true
    end
    end)
    
    tool:Toggle("反巴西","Toggle", false, function(Value)
    if Value == true then
    for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
                            v.CanTouch = false
                    end
    else
    for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
                            v.CanTouch = true
                    end
    end
    end)
    
    tool:Toggle("反死亡方块","Toggle", false, function(Value)
    if Value == true then
            workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = false
            else
                    workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = true
            end
    end)
    
    tool:Toggle("反上帝技能","Toggle", false, function(Value)
    AntiTimestop = Value
    while AntiTimestop do
                    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v.ClassName == "Part" then
                            v.Anchored = false
                        end
                    end
    task.wait()
    end
    end)
    
    tool:Toggle("反鱿鱼","Toggle", false, function(Value)
    AntiSquid = Value
    if AntiSquid == false then
            game.Players.LocalPlayer.PlayerGui.SquidInk.Enabled = true
            end
    while AntiSquid do
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("SquidInk") then
            game.Players.LocalPlayer.PlayerGui.SquidInk.Enabled = false
    end
    task.wait()
    end
    end)
    
    tool:Toggle("反神圣杰克","Toggle", false, function(Value)
    game.Players.LocalPlayer.PlayerScripts.HallowJackAbilities.Disabled = Value
    end)
    
    tool:Toggle("反传送带","Toggle", false, function(Value)
    game.Players.LocalPlayer.PlayerScripts.ConveyorVictimized.Disabled = Value
    end)
    
    tool:Toggle("反板砖","Toggle", false, function(Value)
    AntiBrick = Value
    while AntiBrick do
    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "Union" then
                            v.CanTouch = false
                        end
                    end
    task.wait()
    end
    end)
    
    tool:Toggle("反Null","Toggle", false, function(Value)
    AntiNull = Value
    while AntiNull do
    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "Imp" and v:FindFirstChild("Body") then
    shared.gloveHits[game.Players.LocalPlayer.leaderstats.Glove.Value]:FireServer(v.Body,true)
    end
    end
    task.wait()
    end
    end)
    
tool:Button("自动刷巴掌",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Slap%20Farm'))()
end)

tool:Button("巴掌模拟器1",function()
loadstring(game:HttpGet("https://lkhub.net/s/loader.lua"))()
end)

tool:Button("巴掌模拟器2",function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Slap%20Battles")))()
end)

tool:Button("巴掌模拟器3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dizyhvh/slap_battles_gui/main/0.lua"))()
end)

local creds = window:Tab("越狱",'6035145364')

local tool = creds:section("功能",true)

tool:Button("越狱破解版",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Introvert1337/Releases/master/JailbreakGrabber.lua"))()
end)

tool:Button("自动抢劫",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/wawsdasdacx/ohascriptnrrewading/main/jbsaxcriptidk1"))();
end)

local creds = window:Tab("国王遗产",'6035145364')

local tool = creds:section("功能",true)

tool:Button("国王遗产1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/sannin9000/scripts/main/kinglegacy.lua"))()
end)

tool:Button("国王遗产2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/master/legacy"))()
end)

tool:Button("国王遗产3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/hajibeza/RIPPER-HUB/main/King%20Leagacy"))()
end)

tool:Button("国王遗产4",function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/xDepressionx/Free-Script/main/KingLegacy.lua")()
end)

tool:Button("国王遗产5",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/xOne2/King-Legacy/main/README.md"))()
end)

local creds = window:Tab("餐厅大亨",'6035145364')

local tool = creds:section("功能",true)

tool:Button("餐厅大亨1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/toosiwhip/snake-hub/main/restaurant-tycoon-2.lua"))()
end)

tool:Button("餐厅大亨2",function()
loadstring(game:HttpGet("https://pastefy.app/Ppqt0Gib/raw"))()
end)

local creds = window:Tab("旗帜战争",'6035145364')

local tool = creds:section("功能",true)

tool:Button("旗帜战争1",function()
loadstring(game:HttpGet("https://pastefy.app/otEg6PJV/raw"))()
end)

tool:Button("旗帜战争2",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Infinity2346/Tect-Menu/main/Flag%20Wars.txt'))()
end)

local creds = window:Tab("驾驶帝国",'6035145364')

local tool = creds:section("功能",true)

tool:Button("驾驶帝国1",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/zeuise0002/SSSWWW222/main/README.md'),true))()
end)

tool:Button("驾驶帝国2",function()
loadstring(game:HttpGet("https://soggyhubv2.vercel.app"))()
end)

tool:Button("驾驶帝国3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/main/drivingempire", true))()
end)

tool:Button("驾驶帝国NEO",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/cool83birdcarfly02six/Lightux/main/README.md'),true))()
end)

local creds = window:Tab("战斗勇士",'6035145364')

local tool = creds:section("功能",true)

tool:Button("战斗勇士1",function()
loadstring(game:HttpGet("https://paste.gg/p/anonymous/697fc3cad5f743508318cb7399e89432/files/b5923e52edab4e5c91e46b74563d0ae8/raw"))()
end)

tool:Button("战斗勇士2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/frkfx/Combat-Warriors/main/Script"))()
end)

local creds = window:Tab("刀刃球",'6035145364')

local tool = creds:section("功能",true)

tool:Button("飞行",function()
loadstring(game:HttpGet("https://pastefy.app/J9x7RnEZ/raw"))()
end)

tool:Button("刀刃球自动格挡",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/MC%3ABlade%20Ball%20Parry%20V4.0.0",true))()
end)

tool:Button("刀刃球1",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Unknownkellymc1/Unknownscripts/main/slap-battles')))()
end)

tool:Button("刀刃球2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BladeBall/main/redz9999"))()
end)

tool:Button("刀刃球3",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Neoncat765/Neon.C-Hub-X/main/UnknownVersion"))()
end)

local creds = window:Tab("短信模拟器",'6035145364')

local tool = creds:section("功能",true)

tool:Button("短信模拟器1",function()
loadstring(game:HttpGet(('https://pastebin.com/raw/9hxkxUZ5'),true))()
end)

local creds = window:Tab("彩虹朋友",'6035145364')

local tool = creds:section("功能",true)

tool:Button("彩虹朋友1",function()
loadstring(game:HttpGet("https://pastefy.app/XoNv04vR/raw"))()
end)

tool:Button("彩虹朋友2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/JNHHGaming/Rainbow-Friends/main/Rainbow%20Friends"))()
end)

local creds = window:Tab("BF",'6035145364')

local tool = creds:section("功能",true)

tool:Button("BF 汉化",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/Xiao-Yun-UWU/main/%E6%B5%B7%E8%B4%BC%E7%8E%8Bbf.lua", true))()
end)

tool:Button("最强",function()
_G.HohoVersion = "v4"
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
end)

tool:Button("最强",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AkiraNus/UniquehubKak/main/FreeCr.Xenonhub"))()
end)

tool:Button("刷怪",function()
loadstring(game:HttpGet('https://rawscripts.net/raw/UPDATE-16-Blox-Fruits-Nub-V1-Hub-4583'))()
end)

tool:Button("自动升级",function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/xDepressionx/Free-Script/main/AllScript.lua")()
end)

tool:Button("自动箱子",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"))()
end)

tool:Button("找的",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/RobloxScriptsExploit/Blox-Fruits/main/Ripper%20M"))()
end)

tool:Button("超强",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Augustzyzx/UraniumMobile/main/UraniumKak.lua"))()
end)

tool:Button("HOHO脚本1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HohoV2/Free/BloxFruitFreeV3.lua"))()
end)

tool:Button("HOHO脚本2",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()
end)

local creds = window:Tab("克隆大亨",'6035145364')

local tool = creds:section("功能",true)

tool:Button("克隆大亨1",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/HELLLO1073/RobloxStuff/main/CT-Destroyer"))()
end)

local creds = window:Tab("铲雪",'6035145364')

local tool = creds:section("功能",true)

tool:Toggle("自动收集雪","", false, function(Value)
        toggle = Value
    while toggle do wait()
    local args = {
        [1] = workspace:WaitForChild("HitParts"):WaitForChild("Snow1"),
        [2] = "Snow1",
        [3] = "MagicWand"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("e8eGb8RgRXFcug8q"):FireServer(unpack(args))
        end
    end)

    tool:Toggle("自动出售雪（要传送到指定地方）",   "",false, function(Value)
    toggle = Value
    while toggle do wait()
    local args = {
        [1] = "SellSnow",
        [2] = "Frosty"
    }

    game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        end
    end)

tool:Button("传送出售雪的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(481.4659423828125, 15.846257209777832, -66.55204010009766)
    end)

tool:Button("传送买车的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(90.10160064697266, 16.051794052124023, -141.703125)
    end)

tool:Button("传送买工具的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(131.7429962158203, 16.39700698852539, -12.935890197753906)
    end)

tool:Button("传送买背包的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(348.6633605957031, 17.03822898864746, -16.793842315673828)
    end)

tool:Button("传送买假日礼物的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(154.57424926757812, 16.215335845947266, 147.10423278808594)
    end)

tool:Button("传送买宠物的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(138.49563598632812, 17.887277603149414, 278.3686218261719)
    end)

tool:Button("传送超大铲雪的地方", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-391.4309997558594, 15.84949016571045, 150.15187072753906)
    end)

local creds = window:Tab("其他脚本",'6035145364')

local tool = creds:section("功能",true)

tool:Button("皮脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

tool:Button("叶脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))()
end)

tool:Button("混脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Twbtx/tiamxiabuwu/main/txbw666"))()
end)

tool:Button("XK脚本中心",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BINjiaobzx6/BINjiao/main/XK.TXT"))()
end)

tool:Button("空云脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoSB33/M416/refs/heads/main/Wind%2Fsb%2F%E7%A9%BA%E4%BA%91%E8%84%9A%E6%9C%AC.LUA"))()
end)

tool:Button("沙脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/114514lzkill/ShaHUB/refs/heads/main/ShaHUB.lua"))()
end)

tool:Button("江脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaoSB33/M416/refs/heads/main/%E6%B1%9FtdNB%2FV3.LUA"))()
end)

tool:Button("复制江卡密",function()
    setclipboard("江ScriptNB")
    print("卡密已复制到剪贴板: 江ScriptNB")
end)

tool:Button("BS脚本",function()
    loadstring(game:HttpGet("https://gitlab.com/ajduoxcz/bs-center-of-the-black-hole/-/raw/main/BS%20Center%20of%20the%20black%20hole"))()
end)

tool:Button("暗红脚本V3",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wdwvwfw/wos/refs/heads/main/%E6%B5%8B%E8%AF%95%E5%8D%B7.lua"))()
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
Ping.BackgroundColor3 = Color3.fromRGB(245,245,245)
Ping.BackgroundTransparency = 1.000
Ping.BorderColor3 = Color3.fromRGB(0, 0, 128)
Ping.Position = UDim2.new(0.700000048, 0, 0, 0)
Ping.Size = UDim2.new(0, 125, 0, 25)
Ping.Font = Enum.Font.SourceSans
Ping.TextColor3 = Color3.fromRGB(245,245,245)
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
Fps.TextColor3 = Color3.fromRGB(245,245,245)
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