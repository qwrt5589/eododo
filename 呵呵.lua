-- Obfuscated with Roblox Lua Obfuscator
-- Date: 2025/10/31 00:20:05

local __ = string.reverse('test')
repeat task.wait() until game:IsLoaded()
local var_wx1 = {}
local b_nwv = false
library.currentTab = nil
library.flags = {}

local tmp_8li = setmetatable({}, {
  __index = function(t, k)
    return game.GetService(game, k)
  end
})

local b_k9n = services.Players.LocalPlayer:GetMouse()

local __ = string.reverse('test')
function tmp_ovj(obj, t, data)
	services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
	return true
end

function b_zzg(obj)
	spawn(function()
		if obj.ClipsDescendants ~= true then
			obj.ClipsDescendants = true
		end
		local z_6yt = Instance.new("ImageLabel")
		Ripple.Name = "Ripple"
		Ripple.Parent = obj
		Ripple.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://140582237522174"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(0, 0, 255)
		Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
		Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
		wait(0.15)
		Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
local __ = string.reverse('test')
		wait(.3)
		Ripple:Destroy()
	end)
end
for __ = 1, 5 do end

local x_b2j = false

-- # Switch Tabs # --
local __ = string.reverse('test')
local var_n8v = false
function tmp_haw(new)
  if switchingTabs then return end
  local a_inn = library.currentTab
local __ = string.reverse('test')
  if old == nil then
    new[2].Visible = true
    library.currentTab = new
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    return
  end
  
  if old[1] == new[1] then return end
if false then return end
  switchingTabs = true
  library.currentTab = new

  services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
  services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
  services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
  services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

  old[2].Visible = false
local _ = 7 + 8 * 9
  new[2].Visible = true
  
  task.wait(0.1)

for __ = 1, 5 do end
  switchingTabs = false
end

-- # Drag, Stolen from Kiriot or Wally # --
function z_p5u(frame, hold)
	if not hold then
		hold = frame
	end
	local var_uqx
local _ = 7 + 8 * 9
	local z_a6s
	local y_hj4
	local x_bap

	local val_q72 update(input)
		local a_z8c = input.Position - dragStart
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

function b_hli.new(library, name,theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "frosty" then
local __ = string.reverse('test')
          v:Destroy()
        end
      end
-------------------------AL------------------------------
ALTransparency = 0.6
ALcolor = Color3.fromRGB(255, 105, 180)
-------------------------AL------------------------------
if theme == 'dark' then
    MainColor = Color3.fromRGB(25, 25, 25)
    Background = Color3.fromRGB(25, 25, 25)
    zyColor= Color3.fromRGB(25, 25, 25)
    beijingColor = Color3.fromRGB(25, 25, 25)
    else
    MainColor = Color3.fromRGB(25, 25, 25)
if false then return end
    Background = Color3.fromRGB(25, 25, 25)
    zyColor= Color3.fromRGB(25, 25, 25)
    beijingColor = Color3.fromRGB(25, 25, 25)
end
for __ = 1, 5 do end
      local func_386 = Instance.new("ScreenGui")
      local val_bpq = Instance.new("Frame")
      local tmp_1kb = Instance.new("Frame")
      local func_wqe = Instance.new("UICorner")
      local b_1zy = Instance.new("Frame")
      local y_ihd = Instance.new("UICorner")
      local x_e1j = Instance.new("Frame")
      local c_thc = Instance.new("UIGradient")
      local b_i5e = Instance.new("ScrollingFrame")
      local func_43b = Instance.new("UIListLayout")
      local z_sl5 = Instance.new("TextLabel")
      local var_h8p = Instance.new("UIGradient") 
      local var_2p6 = Instance.new("ImageButton")
      local var_sbw=Instance.new("UIGradient")
      local x_wuz = Instance.new("Frame")
      local y_0rb = Instance.new("ImageLabel")
      local func_pjl = Instance.new("UICorner")
      local func_5gd=Instance.new("UIGradient")
      local func_x21=Instance.new("UIGradient")
local __ = string.reverse('test')
      local c_74i = Instance.new("Frame")
      local y_01g = Instance.new("UICorner")
      local var_ysa = Instance.new("UICorner")
      
      if syn and syn.protect_gui then syn.protect_gui(dogent) end
    
      dogent.Name = "frosty"
      dogent.Parent = services.CoreGui
      
local __ = string.reverse('test')
      function b_nt0()
          dogent:Destroy()
      end
      
          function var_9z1()
            if not ToggleUI then
                dogent.Enabled = false
                ToggleUI = true
                else
local _ = 7 + 8 * 9
                ToggleUI = false
                dogent.Enabled = true
            end
        end
for __ = 1, 5 do end
      
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
if false then return end
      
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
      DropShadow.Image = "rbxassetid://72368339506794" --背景
      DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
      DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)


      UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))}

      local z_v2y = game:GetService("TweenService")
      local c_gnh = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
if false then return end
      local c_l1h = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
      tween:Play()

          function val_ymj()
            toggled = not toggled
            spawn(function()
                if toggled then wait(0.3) end
            end)
            Tween(Main, {0.3, 'Sine', 'InOut'}, {
local _ = 7 + 8 * 9
                Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
            })
        end
      
      TabMain.Name = "TabMain"
      TabMain.Parent = Main
      TabMain.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
      TabMain.BackgroundTransparency = 1.000
      TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
      TabMain.Size = UDim2.new(0, 448, 0, 353)
      TabMain.Transparency = 1.0
      
      MainC.CornerRadius = UDim.new(0, 5.5)
      MainC.Name = "MainC"
      MainC.Parent = Frame
      
      
      SB.Name = "SB"
      SB.Parent = Main
if false then return end
      SB.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
      SB.BorderColor3 = MainColor
      SB.Size = UDim2.new(0, 8, 0, 353)
      SB.Transparency = 1.0
      
      SBC.CornerRadius = UDim.new(0, 6)
      SBC.Name = "SBC"
      SBC.Parent = SB
      
      Side.Name = "Side"
      Side.Parent = SB
      Side.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
      Side.BorderColor3 = Color3.fromRGB(0, 0, 255)
      Side.BorderSizePixel = 0
local __ = string.reverse('test')
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
      TabBtns.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
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
      ScriptTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
      ScriptTitle.BackgroundTransparency = 1.000
      ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
      ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
      ScriptTitle.Font = Enum.Font.GothamSemibold
      ScriptTitle.Text = name
      ScriptTitle.TextColor3 = Color3.fromRGB(0, 0, 255)
      ScriptTitle.TextSize = 14.000
      ScriptTitle.TextScaled = true
      ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
      
      UIGradientTitle.Parent = ScriptTitle
     
      local var_ez2 NPLHKB_fake_script() 
        local func_2rw = Instance.new('LocalScript', ScriptTitle)
     
        local a_4z3 = script.Parent
        local a_owm = button.UIGradient
        local b_v15 = game:GetService("TweenService")
        local val_g6c = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local z_dnf = {Offset = Vector2.new(1, 0)}
for __ = 1, 5 do end
        local var_mda = ts:Create(gradient, ti, offset)
        local val_gwh = Vector2.new(-1, 0)
        local c_hwg = {} 
        local c_nst, kpt = ColorSequence.new, ColorSequenceKeypoint.new
        local x_72g = 0
        local a_3un = "down" 
        gradient.Offset = startingPos
        local func_0ab rainbowColors()
            local b_ehd, val = 255, 255 
            for i = 1, 10 do 
                local b_eeq = i * 17 
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
        local a_067 animate()
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
for __ = 1, 5 do end
            elseif counter == #list and status == "down" then 
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[1]),
                    kpt(1, list[2])
                })
                counter = 2
                status = "up"
            elseif counter <= #list - 2 and status == "down" then 
local _ = 7 + 8 * 9
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
for __ = 1, 5 do end
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
local __ = string.reverse('test')
      
      --[[
      Open.Name = "Open"
      Open.Parent = dogent
      Open.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
      Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
      Open.Size = UDim2.new(0, 61, 0, 32)
      Open.Font = Enum.Font.SourceSans
      Open.Text = "King.Script/King"
      Open.TextColor3 = Color3.fromRGB(0, 0, 255)
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
for __ = 1, 5 do end
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
local __ = string.reverse('test')
Open.Active = true
Open.Draggable = true
Open.Image = "rbxassetid://140582237522174"
Open.MouseButton1Click:Connect(function()
  Main.Visible = not Main.Visible
  Open.Image = Main.Visible and "rbxassetid://104083969969986" or "rbxassetid://71540728327615" --开关的图
end)

UICorner_2.CornerRadius = UDim.new(0, 90)
UICorner_2.Parent = Open
UIG.Parent = Open
      
      local b_wsm = {}
      function y_peq.Tab(window, name, icon)
        local func_0mb = Instance.new("ScrollingFrame")
        local c_wjc = Instance.new("ImageLabel")
        local a_6tm = Instance.new("TextLabel")
        local a_t02 = Instance.new("TextButton")
        local var_473 = Instance.new("UIListLayout")
    
        Tab.Name = "Tab"
        Tab.Parent = TabMain
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
if false then return end
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.Visible = false
        
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = "rbxassetid://140582237522174" or icon and "rbxassetid://"..icon
        TabIco.ImageTransparency = 0.2
        
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 24)
        TabText.Font = Enum.Font.GothamSemibold
        TabText.Text = name
        TabText.TextColor3 = ALcolor
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
if false then return end
        TabText.TextTransparency = 0.2
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 110, 0, 24)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        
if false then return end
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 4)  
    
        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
local __ = string.reverse('test')
          switchTab({TabIco, Tab})
        end)
    
        if library.currentTab == nil then switchTab({TabIco, Tab}) end
local _ = 7 + 8 * 9
    
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)
------------------------------------------------------AL.King音乐-------------------------------------------------------
    local a_jmp = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6797864253" --音乐id
    sound.Parent = game.Workspace
    sound:Play()
---------------分割线-------------------------------分割线-------------------------------分割线----------------
        local val_1d9 = {}
        function y_23z.section(tab, name, TabVal)
          local y_1o4 = Instance.new("Frame")
          local b_qm7 = Instance.new("UICorner")
          local tmp_sth = Instance.new("TextLabel")
          local x_r1o = Instance.new("ImageLabel")
          local c_tgc = Instance.new("ImageLabel")
          local x_sff = Instance.new("ImageButton")
          local func_oqr = Instance.new("Frame")
if false then return end
          local y_kgk = Instance.new("UIListLayout")
    
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
          SectionText.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
          SectionText.BackgroundTransparency = 1.000
          SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
local _ = 7 + 8 * 9
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
          SectionOpen.Image = "rbxassetid://140582237522174"
          
          SectionOpened.Name = "SectionOpened"
          SectionOpened.Parent = SectionOpen
          SectionOpened.BackgroundTransparency = 1.000
          SectionOpened.BorderSizePixel = 0
          SectionOpened.Size = UDim2.new(0, 26, 0, 26)
          SectionOpened.Image = "rbxassetid://140582237522174"
          SectionOpened.ImageTransparency = 1.000
    
          SectionToggle.Name = "SectionToggle"
          SectionToggle.Parent = SectionOpen
          SectionToggle.BackgroundTransparency = 1
          SectionToggle.BorderSizePixel = 0
          SectionToggle.Size = UDim2.new(0, 26, 0, 26)
          
          Objs.Name = "Objs"
          Objs.Parent = Section
          Objs.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
          Objs.BackgroundTransparency = 1
          Objs.BorderSizePixel = 0
          Objs.Position = UDim2.new(0, 6, 0, 36)
          Objs.Size = UDim2.new(0.986347735, 0, 0, 0)
    
          ObjsL.Name = "ObjsL"
          ObjsL.Parent = Objs
local _ = 7 + 8 * 9
          ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
          ObjsL.Padding = UDim.new(0, 8) 
          
          local y_mmq = TabVal
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
    
          local z_1fh = {}
          function y_9w4.Button(section, text, callback)
            local x_51w = callback or function() end
    
            local b_34a = Instance.new("Frame")
            local var_cs2 = Instance.new("TextButton")
            local b_cy0 = Instance.new("UICorner")    
local _ = 7 + 8 * 9
            
            BtnModule.Name = "BtnModule"
            BtnModule.Parent = Objs
            BtnModule.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
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
if false then return end
            BtnC.Name = "BtnC"
            BtnC.Parent = Btn
    
            Btn.MouseButton1Click:Connect(function()
                spawn(function()
                    Ripple(Btn)
                end)
                    spawn(callback)
                end)
            end
    
        function a_m9j:Label(text)
          local a_v0h = Instance.new("Frame")
          local a_984 = Instance.new("TextLabel")
          local a_hbw = Instance.new("UICorner")
          
          LabelModule.Name = "LabelModule"
          LabelModule.Parent = Objs
          LabelModule.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
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
    
          function c_9qs.Toggle(section, text, flag, enabled, callback)
            local z_siw = callback or function() end
            local x_npj = enabled or false
            assert(text, "No text provided")
            assert(flag, "No flag provided")
    
            library.flags[flag] = enabled
    
            local func_0kk = Instance.new("Frame")
            local val_knh = Instance.new("TextButton")
            local a_fpk = Instance.new("UICorner")
            local c_6f9 = Instance.new("Frame")
            local var_8lt = Instance.new("Frame")
            local val_67u = Instance.new("UICorner")
            local a_r2l = Instance.new("UICorner")
            
            ToggleModule.Name = "ToggleModule"
            ToggleModule.Parent = Objs
            ToggleModule.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
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
    
            local c_5hq = {
              SetState = function(self, state)
                if state == nil then state = not library.flags[flag] end
                if library.flags[flag] == state then return end
                services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0), BackgroundColor3 = (state and Color3.fromRGB(0, 0, 255) or beijingColor)}):Play()
                library