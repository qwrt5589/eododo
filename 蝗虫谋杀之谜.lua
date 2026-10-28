local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local player = Players.LocalPlayer
if not player then return end
local startedAt = os.clock()
local playerGui = player:WaitForChild("PlayerGui")
for _,previous in ipairs(playerGui:GetChildren())do
    if previous.Name=="139club" then previous:Destroy() end
end

local VERSION = "1.2"
local OPTION_FONT = Font.new("rbxassetid://12187375422",Enum.FontWeight.SemiBold,Enum.FontStyle.Normal)
local ICON_TRANSPARENCY, BACKGROUND_TRANSPARENCY = .85, .83
local VFX_RATE = 60

local ICON_URI="rbxassetid://137323332616254"
local BG_URI="rbxassetid://81352344014769"
local HERO_BG_URI="rbxassetid://115688095025841"
local CONTROL_WIDTH = 380

local C = {
    base=Color3.fromRGB(10,10,15), panel=Color3.fromRGB(16,15,23),
    black=Color3.fromRGB(8,8,12), steel=Color3.fromRGB(71,68,85),
    silver=Color3.fromRGB(217,219,233), white=Color3.fromRGB(245,244,251),
    muted=Color3.fromRGB(184,181,201), line=Color3.fromRGB(66,59,85),
    violet=Color3.fromRGB(255,182,200),
    light=Color3.fromRGB(255,210,225),
    deep=Color3.fromRGB(180,100,140),
    green=Color3.fromRGB(132,225,179),
    ice=Color3.fromRGB(255,220,235),
    rose=Color3.fromRGB(230,160,190),
    chrome=Color3.fromRGB(235,237,247),
    pink=Color3.fromRGB(255,182,200),
    orchid=Color3.fromRGB(220,150,180),
    cyan=Color3.fromRGB(255,200,220),
}
local state = {alive=true, target="open", page="主页", paneOpen=true,
    lastSecond=-1, phase=0, budget=0, burst=0, finishAt=0, launcherMoved=false}
local UI, connections, threads, tweens = {}, {}, {}, {}
local scopes, alphaEntries, alphaLookup = {}, {}, {}
local factors = {window=0, pane=0, page=0, launcher=0, notification=0, disaster=0, fixed=1}

local function connect(signal, callback)
    local c = signal:Connect(function(...) if state.alive then callback(...) end end)
    connections[#connections+1] = c
    return c
end
local function spawn(callback)
    local thread
    thread = task.defer(function() callback(); threads[thread]=nil end)
    threads[thread] = true
end
local function registerAlpha(o, property, base, scope)
    local entry={object=o, property=property, base=base, scope=scope}
    alphaEntries[#alphaEntries+1]=entry
    alphaLookup[o]=alphaLookup[o] or {}; alphaLookup[o][property]=entry
    o[property]=1-(1-base)*(factors[scope] or 1)
end
local function alpha(o, property, base)
    local entry=alphaLookup[o] and alphaLookup[o][property]
    if entry then
        entry.base=base; o[property]=1-(1-base)*(factors[entry.scope] or 1)
    else o[property]=base end
end
local function refreshAlpha()
    factors.window=UI.windowFade.Value
    factors.pane=factors.window*UI.paneProgress.Value
    factors.page=factors.pane*UI.pageFade.Value
    factors.launcher=UI.launcherFade.Value
    factors.notification=UI.toastProgress and UI.toastProgress.Value or 0
    factors.disaster=UI.disasterProgress and UI.disasterProgress.Value or 0
    for _,entry in ipairs(alphaEntries) do
        entry.object[entry.property]=1-(1-entry.base)*(factors[entry.scope] or 1)
    end
end
local function make(class, parent, props, scope)
    local o=Instance.new(class)
    for k,v in pairs(props or {}) do o[k]=v end
    if o:IsA("GuiObject") then o.BorderSizePixel=0; o.AutoLocalize=false end
    scopes[o]=scope or scopes[parent] or "fixed"
    o.Parent=parent
    if o:IsA("GuiObject") then
        registerAlpha(o,"BackgroundTransparency",o.BackgroundTransparency,scopes[o])
        if o:IsA("TextLabel") or o:IsA("TextButton") then
            o.TextStrokeTransparency=1
            registerAlpha(o,"TextTransparency",o.TextTransparency,scopes[o])
        end
        if o:IsA("ImageLabel") or o:IsA("ImageButton") then
            registerAlpha(o,"ImageTransparency",o.ImageTransparency,scopes[o])
        end
        if o:IsA("ScrollingFrame") then registerAlpha(o,"ScrollBarImageTransparency",o.ScrollBarImageTransparency,scopes[o]) end
    elseif o:IsA("UIStroke") then registerAlpha(o,"Transparency",o.Transparency,scopes[o]) end
    return o
end
local function tween(o, seconds, props)
    if not state.alive then return end
    if tweens[o] then tweens[o]:Cancel() end
    local t=TweenService:Create(o,TweenInfo.new(seconds,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),props)
    tweens[o]=t; t:Play()
end
local function corner(o,r) return make("UICorner",o,{CornerRadius=UDim.new(0,r or 12)}) end
local function stroke(o,color,opacity,width)
    return make("UIStroke",o,{Color=color or C.line,Transparency=opacity or 0,Thickness=width or 1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border})
end
local function gradient(o,colors,rotation)
    local keys={}
    for i,color in ipairs(colors) do keys[i]=ColorSequenceKeypoint.new((i-1)/(#colors-1),color) end
    return make("UIGradient",o,{Color=ColorSequence.new(keys),Rotation=rotation or 90})
end
local function fadeGradient(g)
    g.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.48,.08),NumberSequenceKeypoint.new(.52,.08),NumberSequenceKeypoint.new(1,1)})
end
local function frame(parent,name,pos,size,color,transparency,scope)
    return make("Frame",parent,{Name=name,Position=pos,Size=size,BackgroundColor3=color or C.panel,BackgroundTransparency=transparency or 0},scope)
end
local function label(parent,name,text,pos,size,pixels,color,font)
    local o=make("TextLabel",parent,{Name=name,Text=text,Position=pos,Size=size,BackgroundTransparency=1,
        TextColor3=color or C.white,TextSize=pixels or 14,Font=font~=OPTION_FONT and font or Enum.Font.GothamMedium,
        TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,TextTruncate=Enum.TextTruncate.AtEnd})
    if font==OPTION_FONT then o.FontFace=OPTION_FONT end
    return o
end
local function imageLabel(parent,name,pos,size)
    return make("ImageLabel",parent,{Name=name,Image="",Position=pos,Size=size,BackgroundTransparency=1,ScaleType=Enum.ScaleType.Fit})
end

local paths={
    crown={{{3,7},{6,17},{18,17},{21,7},{16,11},{12,3},{8,11},{3,7}},{{6,21},{18,21}}},
    home={{{3,11},{12,3},{21,11}},{{6,9},{6,21},{10,21},{10,15},{14,15},{14,21},{18,21},{18,9}}},
    cube={{{12,2},{22,7},{22,18},{12,23},{2,18},{2,7},{12,2}},{{2,7},{12,12},{22,7}},{{12,12},{12,23}}},
    spark={{{12,2},{15,9},{22,12},{15,15},{12,22},{9,15},{2,12},{9,9},{12,2}}},
    code={{{8,6},{2,12},{8,18}},{{16,6},{22,12},{16,18}},{{14,3},{10,21}}},
    settings={{{4,6},{20,6}},{{4,12},{20,12}},{{4,18},{20,18}},{{9,3},{9,9}},{{16,9},{16,15}},{{8,15},{8,21}}},
    arrow={{{4,12},{20,12}},{{14,6},{20,12},{14,18}}},
    close={{{6,6},{18,18}},{{18,6},{6,18}}},
    minimize={{{5,16},{19,16}}}, fold={{{14,5},{7,12},{14,19}}},
}
local artworkImages={IconHome={},IconMain={},IconVisuals={},IconScripts={},IconSettings={},Background={},HeroBackground={},Emblem={}}
local iconSprites={}
local iconAssets={home="IconHome",cube="IconMain",spark="IconVisuals",code="IconScripts",settings="IconSettings"}
local function icon(parent,kind,pos,size,color)
    local host=frame(parent,"Icon_"..kind,pos,UDim2.fromOffset(size,size),nil,1)
    local fallback={}
    for _,path in ipairs(paths[kind]) do
        for i=1,#path-1 do
            local a,b=path[i],path[i+1]; local dx,dy=(b[1]-a[1])*size/24,(b[2]-a[2])*size/24
            local line=frame(host,"Line",UDim2.fromOffset((a[1]+b[1])*size/48,(a[2]+b[2])*size/48),UDim2.fromOffset(math.sqrt(dx*dx+dy*dy),1.7),color or C.silver)
            line.AnchorPoint=Vector2.new(.5,.5); line.Rotation=math.deg(math.atan2(dy,dx)); corner(line,2)
            fallback[#fallback+1]=line
        end
    end
    local asset=iconAssets[kind]
    if asset then
        local artwork=imageLabel(host,"OptionArtwork",UDim2.fromScale(.5,.5),UDim2.fromScale(1.42,1.42))
        artwork.AnchorPoint=Vector2.new(.5,.5);artwork.Active=false
        alpha(artwork,"ImageTransparency",ICON_TRANSPARENCY)
        artworkImages[asset][#artworkImages[asset]+1]=artwork
        iconSprites[#iconSprites+1]={image=artwork,fallback=fallback,key=asset}
    end
    return host
end
local function tintIcon(host,color)
    for _,line in ipairs(host:GetChildren()) do if line:IsA("Frame") then line.BackgroundColor3=color end end
end
local metallicColors={Color3.fromRGB(39,37,49),Color3.fromRGB(23,22,32),C.black,Color3.fromRGB(25,20,36)}
local VFX={images={},buttons={},reflections={items={},nextAt=5,serial=0}}

local NeonFlow={};NeonFlow.__index=NeonFlow
function NeonFlow.new(parent,name,radius,seed,edge)
    local fill=frame(parent,name,UDim2.fromOffset(1,1),UDim2.new(1,-2,1,-2),Color3.new(1,1,1),1)
    fill.Active=false;fill.ZIndex=3;corner(fill,radius)
    local wash=gradient(fill,{C.deep,C.violet,C.cyan,C.ice,C.deep},26)
    wash.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),
        NumberSequenceKeypoint.new(.2,.75),NumberSequenceKeypoint.new(.48,.04),
        NumberSequenceKeypoint.new(.70,.52),NumberSequenceKeypoint.new(1,1)})
    return setmetatable({fill=fill,wash=wash,edge=edge,seed=seed},NeonFlow)
end
function NeonFlow:update(time,strength)
    local phase=time*.48+self.seed
    self.wash.Offset=Vector2.new(math.sin(phase)*.42,math.cos(phase*.67)*.07)
    self.wash.Rotation=26+math.sin(phase*.73)*8
    if self.edge then
        self.edge.Offset=Vector2.new(math.sin(phase+.8)*.28,0)
        self.edge.Rotation=24+math.sin(phase*.61)*15
    end
    alpha(self.fill,"BackgroundTransparency",1-strength)
end

local function shown(object)
    while object and object~=UI.gui do
        if object:IsA("GuiObject") and not object.Visible then return false end
        object=object.Parent
    end
    return object~=nil
end
local function addReflection(object,light,strength)
    local item={object=object,light=light,strength=strength or .1}
    VFX.reflections.items[#VFX.reflections.items+1]=item
    alpha(object,"BackgroundTransparency",1)
    return item
end
function VFX.reflections:request(item)
    if not item or not shown(item.object) then return end
    if self.active then alpha(self.active.object,"BackgroundTransparency",1) end
    self.active=item;self.elapsed=0;self.nextAt=state.phase+6.5
end
function VFX.reflections:update(dt)
    local item=self.active
    if item then
        self.elapsed+=dt
        local t=math.min(1,self.elapsed/.95)
        if not shown(item.object) or t>=1 then
            alpha(item.object,"BackgroundTransparency",1);self.active=nil
        else
            item.light.Offset=Vector2.new(-1.15+2.3*t,0)
            alpha(item.object,"BackgroundTransparency",1-math.sin(t*math.pi)^2*item.strength)
        end
    elseif state.phase>=self.nextAt and state.target=="open" then
        self.nextAt=state.phase+7.5
        for _=1,#self.items do
            self.serial=self.serial%#self.items+1
            local candidate=self.items[self.serial]
            if shown(candidate.object) then self:request(candidate);break end
        end
    end
end

local buttons=VFX.buttons
local function updateButtonLight(record)
    local selected=record.selection.Value
    local energy=record.energy.Value
    alpha(record.selectionWash,"BackgroundTransparency",1-selected*.17)
    alpha(record.edge,"Transparency",.58-selected*.32-energy*.18)
    alpha(record.lip,"BackgroundTransparency",.84-selected*.19-energy*.18)
end
local function button(parent,name,pos,size)
    local b=make("TextButton",parent,{Name=name,Text="",Position=pos,Size=size,BackgroundTransparency=1,AutoButtonColor=false,Selectable=true})
    local face=frame(b,"MetalFace",UDim2.fromScale(.5,.5),UDim2.fromScale(1,1),Color3.new(1,1,1))
    face.AnchorPoint=Vector2.new(.5,.5);corner(face,10)
    local scale=make("UIScale",face,{Name="PressScale",Scale=1})
    local wash=gradient(face,metallicColors,108)
    local selectedWash=frame(face,"SelectionWash",UDim2.fromScale(0,0),UDim2.fromScale(1,1),Color3.new(1,1,1),1)
    corner(selectedWash,10);local selectedGradient=gradient(selectedWash,{C.cyan,C.deep,C.violet},110)
    local edge=stroke(face,Color3.new(1,1,1),.58,1)
    local edgeGradient=gradient(edge,{C.steel,C.cyan,C.silver,C.deep,C.violet},34)
    local neon=NeonFlow.new(face,"OptionNeon",9,#buttons*1.17,edgeGradient)
    neon.fill.ZIndex=1
    local lip=frame(face,"MetalLip",UDim2.fromOffset(11,1),UDim2.new(1,-22,0,1),C.chrome,.84)
    local lipGradient=gradient(lip,{C.violet,C.cyan,C.chrome},0);fadeGradient(lipGradient)
    local sheen=frame(face,"Sheen",UDim2.fromOffset(2,2),UDim2.new(1,-4,1,-4),C.white,1)
    corner(sheen,9); local light=gradient(sheen,{C.cyan,C.white,C.light},25); fadeGradient(light)
    lip.ZIndex=2;sheen.ZIndex=2
    local record={button=b,face=face,scale=scale,edge=edge,wash=wash,sheen=sheen,light=light,lip=lip,
        selectionWash=selectedWash,selectedGradient=selectedGradient,neon=neon,hover=false,selected=false,pressed=false,
        energy=make("NumberValue",b,{Name="InteractionLight",Value=0}),
        selection=make("NumberValue",b,{Name="SelectionBlend",Value=0})}
    record.reflection=addReflection(sheen,light,.13)
    buttons[#buttons+1]=record
    connect(record.energy.Changed,function() updateButtonLight(record) end)
    connect(record.selection.Changed,function() updateButtonLight(record) end)
    connect(b.MouseEnter,function() record.hover=true;tween(record.energy,.2,{Value=.65});VFX.reflections:request(record.reflection) end)
    connect(b.MouseLeave,function() record.hover=false;if not record.pressed then tween(record.energy,.28,{Value=0}) end end)
    connect(b.InputBegan,function(input)
        if record.pressed then return end
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            record.pressed=true;record.pointer=input
            tween(scale,.09,{Scale=.977});tween(record.energy,.12,{Value=1})
            VFX.reflections:request(record.reflection)
        end
    end)
    connect(b.Activated,function() VFX.reflections:request(record.reflection) end)
    return b,record
end
local function releaseButtons(input,force)
    for _,record in ipairs(buttons) do
        if record.pressed and (force or input==record.pointer or
            (record.pointer.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseButton1)) then
            record.pressed=false;record.pointer=nil
            tween(record.scale,.22,{Scale=1});tween(record.energy,.28,{Value=force and 0 or (record.hover and .65 or 0)})
        end
    end
end
connect(Input.InputEnded,function(input) releaseButtons(input,false) end)
connect(Input.WindowFocusReleased,function() releaseButtons(nil,true) end)

local function brandText(parent,name,pos,size,pixels)
    local text=label(parent,name,"139club",pos,size,pixels,C.white,Enum.Font.GrenzeGotisch)
    text.TextColor3=Color3.new(1,1,1)
    text.TextTruncate=Enum.TextTruncate.None
    local metal=make("UIGradient",text,{Rotation=90,Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,C.chrome),ColorSequenceKeypoint.new(.30,C.white),
        ColorSequenceKeypoint.new(.50,C.muted),ColorSequenceKeypoint.new(.57,C.chrome),
        ColorSequenceKeypoint.new(1,C.light)})})
    local outline=make("UIStroke",text,{Color=C.black,Transparency=.28,Thickness=.8,ApplyStrokeMode=Enum.ApplyStrokeMode.Contextual})
    return text,metal,outline
end


local Club = {}
Club.__index = Club
local windowObj, tabObjects, pageMap = nil, {}, {}


local PAGE_NAMES = {"主页","功能","视角"}
local PAGE_ICONS = {home="home",cube="cube",spark="spark",code="code",settings="settings"}



UI.gui=make("ScreenGui",playerGui,{Name="139club",ResetOnSpawn=false,DisplayOrder=50,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=false})
pcall(function() UI.gui.ScreenInsets=Enum.ScreenInsets.CoreUISafeInsets end)
UI.gui:SetAttribute("Version",VERSION)
UI.gui:SetAttribute("ScriptStatus","Active")
UI.gui:SetAttribute("VFXRate",VFX_RATE)

local function cleanup()
    if not state.alive then return end
    state.alive=false; state.drag=nil
    for _,c in ipairs(connections) do c:Disconnect() end
    for _,t in pairs(tweens) do t:Cancel() end
    for thread in pairs(threads) do if coroutine.status(thread)~="dead" then pcall(task.cancel,thread) end end
    table.clear(connections);table.clear(threads);table.clear(tweens)
end
connections[#connections+1]=UI.gui.Destroying:Connect(cleanup)
UI.windowFade=make("NumberValue",UI.gui,{Name="WindowOpacity",Value=0})
UI.launcherFade=make("NumberValue",UI.gui,{Name="LauncherOpacity",Value=0})
UI.paneProgress=make("NumberValue",UI.gui,{Name="PaneProgress",Value=1})
UI.pageFade=make("NumberValue",UI.gui,{Name="PageOpacity",Value=1})
UI.zoom=make("NumberValue",UI.gui,{Name="WindowZoom",Value=.985})
UI.screen=frame(UI.gui,"SafeArea",UDim2.fromScale(0,0),UDim2.fromScale(1,1),nil,1)
UI.screen.ClipsDescendants=false
UI.window=frame(UI.screen,"Window",UDim2.fromOffset(100,100),UDim2.fromOffset(880,420),nil,1,"window")
UI.window.ClipsDescendants=false
UI.scale=make("UIScale",UI.window,{Scale=.985})

local function makePinkFlow(target, thickness, speed)
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 255, 255)
    s.Thickness = thickness or 2
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = target
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.000, Color3.fromRGB(53, 53, 53)),
        ColorSequenceKeypoint.new(0.152, Color3.fromRGB(50, 50, 50)),
        ColorSequenceKeypoint.new(0.472, Color3.fromRGB(255, 182, 200)),
        ColorSequenceKeypoint.new(0.757, Color3.fromRGB(50, 50, 50)),
        ColorSequenceKeypoint.new(1.000, Color3.fromRGB(48, 48, 48)),
    }
    g.Rotation = 180
    g.Parent = s
    local tw = TweenService:Create(g, TweenInfo.new(speed or 10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, math.huge, false), { Rotation = -180 })
    tw:Play()
    registerAlpha(s,"Transparency",s.Transparency,scopes[target] or "window")
    return s, g, tw
end

local InwardLight={};InwardLight.__index=InwardLight
function InwardLight.new(parent,seed)
    local self=setmetatable({fields={},seed=seed},InwardLight)
    local clip=frame(parent,"InwardLight",UDim2.fromOffset(2,2),UDim2.new(1,-4,1,-4),nil,1)
    clip.ZIndex=3;clip.ClipsDescendants=true;clip.Active=false
    for side=1,4 do
        local field=frame(clip,"InwardGlow",UDim2.fromScale(0,0),UDim2.fromScale(1,1),nil,1)
        field.Active=false
        local horizontal=side%2==1
        field.Size=horizontal and UDim2.new(.58,0,0,26) or UDim2.new(0,24,.58,0)
        local strips={}
        for i=1,9 do
            local strip=frame(field,"GlowFeather",horizontal and UDim2.fromScale((i-1)/9,0) or UDim2.fromScale(0,(i-1)/9),
                horizontal and UDim2.fromScale(1/9,1) or UDim2.fromScale(1,1/9),Color3.new(1,1,1),1)
            strip.Active=false
            local wash=gradient(strip,side%2==1 and {C.cyan,C.violet,C.deep} or {C.deep,C.violet,C.cyan},horizontal and 90 or 0)
            local reverse=side==2 or side==3
            wash.Transparency=NumberSequence.new({
                NumberSequenceKeypoint.new(0,reverse and 1 or 0),
                NumberSequenceKeypoint.new(.25,reverse and .96 or .55),
                NumberSequenceKeypoint.new(.75,reverse and .55 or .96),
                NumberSequenceKeypoint.new(1,reverse and 0 or 1)})
            strips[i]={node=strip,weight=math.sin((i-.5)/9*math.pi)^2}
        end
        self.fields[side]={node=field,strips=strips}
    end
    return self
end
function InwardLight:update(time,burst)
    for side,item in ipairs(self.fields) do
        local travel=.21+.19*math.sin(time*.24+self.seed+side*1.7)
        local node=item.node
        if side==1 then node.Position=UDim2.new(travel,0,0,0)
        elseif side==2 then node.Position=UDim2.new(1,-24,travel,0)
        elseif side==3 then node.Position=UDim2.new(travel,0,1,-26)
        else node.Position=UDim2.new(0,0,travel,0) end
        local strength=.21+.06*math.sin(time*.7+self.seed+side)^2+burst*.025
        for _,strip in ipairs(item.strips) do alpha(strip.node,"BackgroundTransparency",1-strength*strip.weight) end
    end
end
local function background(parent,radius,bucket)
    local image=imageLabel(parent,"InterfaceBackground",UDim2.fromOffset(1,1),UDim2.new(1,-2,1,-2))
    image.ZIndex=2;image.ScaleType=Enum.ScaleType.Crop;image.Active=false
    image.ImageColor3=Color3.new(1,1,1);corner(image,radius)
    alpha(image,"ImageTransparency",BACKGROUND_TRANSPARENCY)
    local list = bucket or artworkImages.Background
    list[#list+1]=image
    return image
end
local EmblemNeon={};EmblemNeon.__index=EmblemNeon
function EmblemNeon.new(host)
    local self=setmetatable({layers={}},EmblemNeon)
    for i,data in ipairs({{"EmblemBloomWide",16,.40,0},{"EmblemBloomNear",6,.48,.5},{"EmblemSweep",0,.68,0}}) do
        local image=imageLabel(host,data[1],UDim2.fromOffset(-data[2]/2,-data[2]/2),UDim2.new(1,data[2],1,data[2]))
        image.ZIndex=i==3 and 4 or i;image.Active=false
        local wash=gradient(image,{C.pink,C.light,C.violet,C.rose},0)
        if i==3 then
            wash.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.26,1),
                NumberSequenceKeypoint.new(.46,.08),NumberSequenceKeypoint.new(.54,.08),NumberSequenceKeypoint.new(.74,1),NumberSequenceKeypoint.new(1,1)})
        end
        alpha(image,"ImageTransparency",1)
        artworkImages.Emblem[#artworkImages.Emblem+1]=image
        self.layers[i]={image=image,wash=wash,strength=data[3],phase=data[4]}
    end
    return self
end
function EmblemNeon:update(time,burst)
    local tint=C.pink:Lerp(C.orchid,.5+.5*math.sin(time*.8))
    for _,layer in ipairs(self.layers) do
        local progress=(time/4.8+layer.phase)%1
        local envelope=math.sin(progress*math.pi)^2
        layer.wash.Offset=Vector2.new(-.9+1.8*progress,0)
        layer.image.ImageColor3=tint
        alpha(layer.image,"ImageTransparency",1-envelope*(layer.strength+burst*.04))
    end
end

local function surface(parent,name,pos,size,scope)
    local o=frame(parent,name,pos,size,Color3.new(1,1,1),0,scope);corner(o,16)
    gradient(o,{C.panel,C.base,C.black},100)
    background(o,15)
    local inward=InwardLight.new(o,name=="Dock" and .7 or 2.3)
    local edge=stroke(o,Color3.new(1,1,1),.36,1)
    local metal=gradient(edge,{C.steel,C.cyan,C.silver,C.violet,C.black,C.cyan},24)
    local neon=NeonFlow.new(o,"SurfaceNeon",15,name=="Dock" and .45 or 2.8,metal)
    local inner=frame(o,"InnerRim",UDim2.fromOffset(2,2),UDim2.new(1,-4,1,-4),nil,1)
    corner(inner,14);stroke(inner,C.silver,.94,1)
    local beam=frame(o,"EdgeLight",UDim2.fromOffset(16,0),UDim2.new(1,-32,0,1),C.white,.65)
    local beamGradient=gradient(beam,{C.violet,C.cyan,C.silver},0);fadeGradient(beamGradient)
    local sheen=frame(o,"SurfaceReflection",UDim2.fromOffset(3,3),UDim2.new(1,-6,1,-6),C.chrome,1)
    corner(sheen,14);local sweep=gradient(sheen,{C.chrome,C.ice},28);fadeGradient(sweep)
    inner.ZIndex=3;beam.ZIndex=3;sheen.ZIndex=3
    addReflection(sheen,sweep,.035)
    return o,{edge=edge,metal=metal,beam=beam,beamGradient=beamGradient,inward=inward,neon=neon}
end
UI.dock,UI.dockFx=surface(UI.window,"Dock",UDim2.fromOffset(0,0),UDim2.fromOffset(170,420))
UI.dock.ZIndex=2
local dockFlowStroke = makePinkFlow(UI.dock, 1.8, 9)

UI.dockCrown=icon(UI.dock,"crown",UDim2.fromOffset(17,20),24,C.light)
UI.brand=brandText(UI.dock,"BrandText",UDim2.fromOffset(46,8),UDim2.fromOffset(116,44),25)
UI.dragArea=frame(UI.dock,"DragArea",UDim2.fromOffset(0,0),UDim2.new(1,0,0,60),nil,1)
UI.dragArea.Active=true;UI.dragArea.ZIndex=5
UI.dockDivider=frame(UI.dock,"Divider",UDim2.fromOffset(14,62),UDim2.new(1,-28,0,1),C.line,.25)
gradient(UI.dockDivider,{C.black,C.violet,C.black},0)
UI.nav=make("ScrollingFrame",UI.dock,{Name="Navigation",Position=UDim2.fromOffset(9,76),Size=UDim2.new(1,-18,1,-138),
    BackgroundTransparency=1,CanvasSize=UDim2.fromOffset(0,240),CanvasPosition=Vector2.zero,ScrollBarThickness=2,
    ScrollBarImageColor3=C.violet,ScrollBarImageTransparency=.65,Active=true,ScrollingEnabled=true,
    ClipsDescendants=true,ScrollingDirection=Enum.ScrollingDirection.Y,AutomaticCanvasSize=Enum.AutomaticSize.None})
local navigation={}
local optionFont=OPTION_FONT
for i,data in ipairs({{"主页","home"},{"功能","cube"},{"视角","spark"}}) do
    local b,fx=button(UI.nav,"Tab_"..data[1],UDim2.fromOffset(0,(i-1)*48),UDim2.new(1,-3,0,42))
    local glyph=icon(b,data[2],UDim2.fromOffset(12,10),22,C.muted)
    local caption=label(b,"Caption",data[1],UDim2.fromOffset(45,0),UDim2.new(1,-51,1,0),19,C.muted,optionFont)
    navigation[data[1]]={button=b,fx=fx,icon=glyph,caption=caption,index=i}
end
UI.selectionLight=frame(UI.nav,"SelectionLight",UDim2.fromOffset(0,12),UDim2.fromOffset(2,18),Color3.new(1,1,1),0)
gradient(UI.selectionLight,{C.violet,C.cyan,C.chrome},90)
UI.selectionLight.ZIndex=4;corner(UI.selectionLight,2)
UI.controls=frame(UI.dock,"WindowControls",UDim2.new(0,12,1,-50),UDim2.new(1,-24,0,36),nil,1)
local controlArtwork={}

local minimizeData = {"Minimize","minimize"}
local b=make("ImageButton",UI.controls,{Name=minimizeData[1],Image="",BackgroundTransparency=1,
    Position=UDim2.new(.5,-20,0,0),Size=UDim2.fromOffset(40,36),AutoButtonColor=false,Active=true,Selectable=true})
local fallback=frame(b,"ControlFallback",UDim2.fromScale(0,0),UDim2.fromScale(1,1),Color3.new(1,1,1))
corner(fallback,10);gradient(fallback,metallicColors,105);stroke(fallback,C.silver,.6)
local glyph=icon(fallback,minimizeData[2],UDim2.fromOffset(9,7),22,C.silver)
UI.foldIcon=glyph
local glow=imageLabel(b,"ControlGlow",UDim2.fromScale(.5,.5),UDim2.new(1,8,1,6))
glow.AnchorPoint=Vector2.new(.5,.5);glow.ImageColor3=C.ice;alpha(glow,"ImageTransparency",.95)
local art=imageLabel(b,"ControlArtwork",UDim2.fromScale(.5,.5),UDim2.new(1,4,1,0))
art.AnchorPoint=Vector2.new(.5,.5)
local artCorner = Instance.new("UICorner");artCorner.CornerRadius = UDim.new(0, 8);artCorner.Parent = art
local artScale=make("UIScale",art,{Scale=1})
local record={image=art,glow=glow,fallback=fallback,glyph=glyph,scale=artScale,pressed=false,hover=false}
controlArtwork["Minimize"]=record
local controlSheen=frame(b,"ControlReflection",UDim2.fromOffset(2,8),UDim2.new(1,-4,0,20),C.chrome,1)
corner(controlSheen,8);local controlSweep=gradient(controlSheen,{C.white,C.ice},25);fadeGradient(controlSweep)
record.reflection=addReflection(controlSheen,controlSweep,.17)
connect(b.MouseEnter,function() record.hover=true;alpha(glow,"ImageTransparency",.82);VFX.reflections:request(record.reflection);if not record.pressed then tween(artScale,.18,{Scale=1.025}) end end)
connect(b.MouseLeave,function() record.hover=false;alpha(glow,"ImageTransparency",.95);if not record.pressed then tween(artScale,.18,{Scale=1}) end end)
connect(b.InputBegan,function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        if record.pressed then return end
        record.pressed=true;record.pointer=input;tween(artScale,.09,{Scale=.97});alpha(glow,"ImageTransparency",.74);VFX.reflections:request(record.reflection)
    end
end)
connect(Input.InputEnded,function(input)
    if record.pressed and (input==record.pointer or (record.pointer.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseButton1)) then
        record.pressed=false;record.pointer=nil;tween(artScale,.22,{Scale=record.hover and 1.025 or 1});alpha(glow,"ImageTransparency",record.hover and .82 or .95)
    end
end)
connect(Input.WindowFocusReleased,function() record.pressed=false;record.pointer=nil;tween(artScale,.16,{Scale=1}) end)
UI["Minimize"]=b

UI.reveal=frame(UI.window,"PanelReveal",UDim2.fromOffset(180,0),UDim2.fromOffset(700,420),nil,1,"pane")
UI.reveal.ZIndex=2
UI.reveal.ClipsDescendants=true
UI.panel,UI.panelFx=surface(UI.reveal,"Panel",UDim2.fromOffset(4,4),UDim2.fromOffset(692,412))
VFX.surfaces={UI.dockFx,UI.panelFx}
local panelFlowStroke = makePinkFlow(UI.panel, 2, 11)

UI.header=frame(UI.panel,"Header",UDim2.fromOffset(20,8),UDim2.new(1,-40,0,58),nil,1)
UI.pageTitle=label(UI.header,"PageTitle","主页",UDim2.fromOffset(0,0),UDim2.fromOffset(130,54),23,C.white,optionFont)
UI.avatarPlate=frame(UI.header,"AvatarPlate",UDim2.fromOffset(190,11),UDim2.fromOffset(32,32),C.panel)
corner(UI.avatarPlate,100);stroke(UI.avatarPlate,C.light,.18)
UI.avatarFallback=label(UI.avatarPlate,"AvatarFallback",string.upper(string.sub(player.Name,1,1)),UDim2.fromScale(0,0),UDim2.fromScale(1,1),14)
UI.avatarFallback.TextXAlignment=Enum.TextXAlignment.Center
UI.avatar=imageLabel(UI.avatarPlate,"Avatar",UDim2.fromOffset(2,2),UDim2.new(1,-4,1,-4))
UI.avatar.ScaleType=Enum.ScaleType.Crop;corner(UI.avatar,100)
UI.userID=label(UI.header,"UserID","ID  "..tostring(player.UserId),UDim2.fromOffset(232,0),UDim2.fromOffset(170,54),12,C.muted)
UI.sessionDot=frame(UI.header,"SessionDot",UDim2.fromOffset(422,24),UDim2.fromOffset(5,5),C.violet)
corner(UI.sessionDot,5)
UI.session=label(UI.header,"SessionTime","00:00:00",UDim2.fromOffset(436,0),UDim2.fromOffset(94,54),12,C.silver,Enum.Font.RobotoMono)
UI.panelDrag=frame(UI.panel,"PanelDragArea",UDim2.fromOffset(0,0),UDim2.new(1,0,0,68),nil,1)
UI.panelDrag.Active=true;UI.panelDrag.ZIndex=5
UI.headerLine=frame(UI.panel,"HeaderLine",UDim2.fromOffset(18,67),UDim2.new(1,-36,0,1),C.line,.2)
gradient(UI.headerLine,{C.steel,C.deep,C.silver},0)
UI.content=frame(UI.panel,"Content",UDim2.fromOffset(16,80),UDim2.new(1,-32,1,-116),nil,1)
UI.content.ClipsDescendants=true
UI.credit=label(UI.panel,"Credit","Made By 139club",UDim2.new(0,20,1,-30),UDim2.new(1,-40,0,22),11,C.muted)
UI.credit.TextXAlignment=Enum.TextXAlignment.Right
local pages={}
for _,name in ipairs(PAGE_NAMES) do
    local page=make("ScrollingFrame",UI.content,{Name="Page_"..name,Position=UDim2.fromOffset(0,0),Size=UDim2.fromScale(1,1),
        BackgroundTransparency=1,CanvasSize=UDim2.fromOffset(0,0),CanvasPosition=Vector2.zero,ScrollBarThickness=3,
        ScrollBarImageColor3=C.violet,ScrollBarImageTransparency=.5,Active=true,ScrollingEnabled=true,
        ClipsDescendants=true,ScrollingDirection=Enum.ScrollingDirection.Y,AutomaticCanvasSize=Enum.AutomaticSize.None,Visible=name=="主页"},"page")
    pages[name]=page
    pageMap[name]=page
end
UI.hero=frame(pages["主页"],"Hero",UDim2.fromOffset(1,1),UDim2.new(1,-8,0,240),Color3.new(1,1,1))
corner(UI.hero,13)
local heroEdge=stroke(UI.hero,Color3.new(1,1,1),.52)
local heroMetal=gradient(heroEdge,{C.violet,C.cyan,C.silver,C.deep},28)
gradient(UI.hero,{Color3.fromRGB(28,22,40),C.black,Color3.fromRGB(26,17,39)},32)
local heroSheen=frame(UI.hero,"HeroReflection",UDim2.fromOffset(2,2),UDim2.new(1,-4,1,-4),C.chrome,1)
corner(heroSheen,12);local heroSweep=gradient(heroSheen,{C.chrome,C.light},28);fadeGradient(heroSweep)
addReflection(heroSheen,heroSweep,.05)
UI.heroTitle=brandText(UI.hero,"HeroTitle",UDim2.fromOffset(20,10),UDim2.fromOffset(268,100),48)
UI.heroTitle.ZIndex=4
UI.heroBackground=background(UI.hero,12,artworkImages.HeroBackground)
UI.heroNeon=NeonFlow.new(UI.hero,"HeroNeon",12,4.6,heroMetal)
heroSheen.ZIndex=3
UI.status=frame(UI.hero,"ScriptInfo",UDim2.fromOffset(22,116),UDim2.fromOffset(240,106),nil,1)
UI.status.ZIndex=4
UI.statusLabel=label(UI.status,"StatusLabel","状态",UDim2.fromOffset(0,0),UDim2.fromOffset(62,24),16,C.muted,optionFont)
UI.statusDot=frame(UI.status,"StatusDot",UDim2.fromOffset(71,9),UDim2.fromOffset(4,4),C.pink,.08)
corner(UI.statusDot,4)
UI.statusValue=label(UI.status,"StatusValue","已激活",UDim2.fromOffset(82,0),UDim2.new(1,-82,0,24),16,C.white,optionFont)
UI.versionLabel=label(UI.status,"VersionLabel","版本",UDim2.fromOffset(0,26),UDim2.fromOffset(62,22),15,C.muted,optionFont)
UI.versionValue=label(UI.status,"VersionValue",VERSION,UDim2.fromOffset(71,26),UDim2.new(1,-71,0,22),15,C.light,Enum.Font.RobotoMono)
UI.authorLabel=label(UI.status,"AuthorLabel","作者",UDim2.fromOffset(0,52),UDim2.fromOffset(62,22),15,C.muted,optionFont)
UI.authorValue=label(UI.status,"AuthorValue","139club",UDim2.fromOffset(71,52),UDim2.new(1,-71,0,22),15,C.violet,optionFont)
UI.qqLabel=label(UI.status,"QQLabel","QQ",UDim2.fromOffset(0,78),UDim2.fromOffset(62,22),15,C.muted,optionFont)
UI.qqValue=label(UI.status,"QQValue","1693323219",UDim2.fromOffset(71,78),UDim2.new(1,-71,0,22),15,C.violet,Enum.Font.RobotoMono)
UI.emblemHost=frame(UI.hero,"EmblemHost",UDim2.new(1,-224,0,2),UDim2.fromOffset(220,196),nil,1)
UI.emblemHost.ZIndex=4
UI.emblemNeon=EmblemNeon.new(UI.emblemHost)
UI.xFallback=label(UI.emblemHost,"XFallback","X",UDim2.fromScale(0,0),UDim2.fromScale(1,1),92,C.light,Enum.Font.GothamBold)
UI.xFallback.ZIndex=3;UI.xFallback.TextXAlignment=Enum.TextXAlignment.Center
UI.xImage=imageLabel(UI.emblemHost,"EmblemX",UDim2.fromScale(0,0),UDim2.fromScale(1,1))
UI.xImage.ZIndex=3;artworkImages.Emblem[#artworkImages.Emblem+1]=UI.xImage
for _,object in ipairs({UI.dockCrown,UI.brand,UI.dockDivider,UI.nav,UI.controls,
    UI.header,UI.headerLine,UI.content,UI.credit}) do object.ZIndex=4 end


UI.launcher=make("ImageButton",UI.screen,{Name="Launcher",Image="",BackgroundColor3=C.panel,
    Size=UDim2.fromOffset(64,64),Position=UDim2.fromOffset(20,150),
    AutoButtonColor=false,Visible=false,Selectable=true},"launcher")
corner(UI.launcher,16)
stroke(UI.launcher,C.violet,.35,1.5)
UI.launcherScale=make("UIScale",UI.launcher,{Scale=.92})
UI.launcherArt=frame(UI.launcher,"LauncherArtwork",UDim2.fromScale(.5,.5),UDim2.fromScale(1,1),nil,1)
UI.launcherArt.AnchorPoint=Vector2.new(.5,.5);UI.launcherArt.ZIndex=2;UI.launcherArt.Active=false
UI.launcherPress=make("UIScale",UI.launcherArt,{Name="LauncherPressScale",Scale=1})
UI.rFallback=label(UI.launcherArt,"RFallback","R",UDim2.fromScale(0,0),UDim2.fromScale(1,1),28,C.white,Enum.Font.GothamBold)
UI.rFallback.TextXAlignment=Enum.TextXAlignment.Center
UI.launcherImage=imageLabel(UI.launcherArt,"LauncherR",UDim2.fromScale(0,0),UDim2.fromScale(1,1))
UI.launcherImage.ZIndex=2;UI.rFallback.ZIndex=2
local launcherImgCorner = Instance.new("UICorner");launcherImgCorner.CornerRadius = UDim.new(0, 8);launcherImgCorner.Parent = UI.launcherImage
UI.launcherShine=imageLabel(UI.launcherArt,"LauncherShine",UDim2.fromScale(0,0),UDim2.fromScale(1,1))
UI.launcherShine.ZIndex=3;UI.launcherShine.Active=false
local launcherShineCorner = Instance.new("UICorner");launcherShineCorner.CornerRadius = UDim.new(0, 8);launcherShineCorner.Parent = UI.launcherShine
alpha(UI.launcherShine,"ImageTransparency",1)
UI.launcherSweep=gradient(UI.launcherShine,{C.ice,C.chrome,C.light},-24)
fadeGradient(UI.launcherSweep)
UI.recovery=make("ImageButton",UI.screen,{Name="Recover",Image="",BackgroundColor3=C.panel,Size=UDim2.fromOffset(40,40),Position=UDim2.new(0,8,.5,-20),AutoButtonColor=false,Visible=false})
corner(UI.recovery,10);stroke(UI.recovery,C.light,.3)
UI.recoveryFallback=label(UI.recovery,"RecoveryFallback","R",UDim2.fromScale(0,0),UDim2.fromScale(1,1),22,C.white,Enum.Font.GothamBold)
UI.recoveryFallback.TextXAlignment=Enum.TextXAlignment.Center
UI.recoveryImage=imageLabel(UI.recovery,"RecoveryR",UDim2.fromScale(0,0),UDim2.fromScale(1,1))
local recoveryImgCorner = Instance.new("UICorner");recoveryImgCorner.CornerRadius = UDim.new(0, 8);recoveryImgCorner.Parent = UI.recoveryImage



local LoadToast={};LoadToast.__index=LoadToast
function LoadToast.new()
    UI.toastProgress=make("NumberValue",UI.gui,{Name="ToastProgress",Value=0})
    local host=frame(UI.screen,"LoadNotification",UDim2.fromOffset(0,0),UDim2.fromOffset(330,90),nil,1,"notification")
    host.AnchorPoint=Vector2.new(1,1);host.ZIndex=12;host.Active=false;host.ClipsDescendants=false
    local face=frame(host,"NotificationFace",UDim2.fromScale(0,0),UDim2.fromScale(1,1),Color3.new(1,1,1),0)
    face.ZIndex=2;face.Active=false;corner(face,14)
    gradient(face,{Color3.fromRGB(19,30,42),C.black,Color3.fromRGB(25,17,34)},26)
    local edge=stroke(face,Color3.new(1,1,1),.40,1)
    local edgeLight=gradient(edge,{C.deep,C.orchid,C.cyan,C.chrome,C.pink},18)
    local neon=NeonFlow.new(face,"NotificationNeon",13,1.9,edgeLight)
    local badge=frame(face,"SuccessBadge",UDim2.fromOffset(15,27),UDim2.fromOffset(34,34),Color3.new(1,1,1))
    badge.Active=false;badge.ZIndex=4;corner(badge,11)
    gradient(badge,{Color3.fromRGB(29,48,62),Color3.fromRGB(17,16,30)},45)
    local badgeEdge=stroke(badge,C.cyan,.46,1)
    gradient(badgeEdge,{C.violet,C.cyan,C.chrome},35)
    local badgeScale=make("UIScale",badge,{Scale=.94})
    for _,line in ipairs({{12,20,7.1,45},{19.5,17.5,15.6,-50}}) do
        local mark=frame(badge,"SuccessCheck",UDim2.fromOffset(line[1],line[2]),UDim2.fromOffset(line[3],2),C.cyan,0)
        mark.AnchorPoint=Vector2.new(.5,.5);mark.Rotation=line[4];mark.Active=false;corner(mark,2)
    end
    local title=label(face,"NotificationBrand","139club",UDim2.fromOffset(61,11),UDim2.new(1,-78,0,24),19,C.white,Enum.Font.GrenzeGotisch)
    title.Active=false;title.ZIndex=4
    local message=label(face,"NotificationMessage","脚本已成功加载\n祝你使用愉快 :))",UDim2.fromOffset(61,35),UDim2.new(1,-78,0,43),18,C.silver,OPTION_FONT)
    message.TextWrapped=true;message.TextTruncate=Enum.TextTruncate.None;message.Active=false;message.ZIndex=4
    local glint=frame(face,"NotificationEdgeLight",UDim2.new(.1,0,0,0),UDim2.new(.48,0,0,1),Color3.new(1,1,1),.32)
    glint.Active=false;glint.ZIndex=3
    local glintWash=gradient(glint,{C.violet,C.cyan,C.chrome},0);fadeGradient(glintWash)
    local self=setmetatable({host=host,phase="prepared",progress=UI.toastProgress},LoadToast)
    self.neon=neon;self.badgeScale=badgeScale;self.badgeEdge=badgeEdge;self.glint=glint
    self.connection=connect(self.progress.Changed,function() self:position();refreshAlpha() end)
    self:resize()
    return self
end
function LoadToast:start()
    self.started=os.clock();self.phase="entering"
    UI.gui:SetAttribute("LoadNotification","entering")
    tween(self.progress,.48,{Value=1})
end
function LoadToast:position()
    if self.phase=="done" then return end
    self.host.Position=UDim2.new(1,-16+(self.width+78)*(1-self.progress.Value),1,-26)
    self.badgeScale.Scale=.94+.06*self.progress.Value
end
function LoadToast:resize()
    if self.phase=="done" then return end
    self.width=math.min(330,math.max(200,UI.screen.AbsoluteSize.X-32))
    self.host.Size=UDim2.fromOffset(self.width,90)
    self:position()
end
function LoadToast:destroy()
    if self.phase=="done" then return end
    self.phase="done";self.connection:Disconnect()
    local removed={[self.host]=true,[self.progress]=true}
    for _,o in ipairs(self.host:GetDescendants()) do removed[o]=true end
    for i=#alphaEntries,1,-1 do
        if removed[alphaEntries[i].object] then table.remove(alphaEntries,i) end
    end
    for i=#VFX.images,1,-1 do if removed[VFX.images[i]] then table.remove(VFX.images,i) end end
    for o in pairs(removed) do
        alphaLookup[o]=nil;scopes[o]=nil
        if tweens[o] then tweens[o]:Cancel();tweens[o]=nil end
    end
    self.host:Destroy();self.progress:Destroy();UI.toastProgress=nil
    self.neon=nil;self.badgeScale=nil;self.badgeEdge=nil;self.glint=nil;self.host=nil;self.progress=nil
    UI.gui:SetAttribute("LoadNotification","done")
end
function LoadToast:dismiss(seconds)
    if self.phase=="done" then return end
    self.phase="exiting";self.endsAt=os.clock()+seconds
    UI.gui:SetAttribute("LoadNotification","exiting")
    tween(self.progress,seconds,{Value=0})
end
function LoadToast:update(now,time)
    if self.phase=="done" then return end
    local elapsed=now-self.started
    if self.endsAt and now>=self.endsAt then self:destroy();return end
    if elapsed>=4.48 and self.phase~="exiting" then
        self:dismiss(.42)
    elseif elapsed>=.48 and self.phase=="entering" then
        self.phase="holding";UI.gui:SetAttribute("LoadNotification","holding")
    end
    self.neon:update(time,.17)
    self.glint.Position=UDim2.new(.23+.20*math.sin(time*.65),0,0,0)
    alpha(self.badgeEdge,"Transparency",.42+.08*math.sin(time*1.2)^2)
end
UI.loadToast=LoadToast.new()

for _,record in ipairs(buttons) do
    for _,child in ipairs(record.button:GetChildren()) do
        if child:IsA("GuiObject") and child~=record.face then child.Parent=record.face;child.ZIndex=4 end
    end
end




local layout={}
local function applyPane()
    if not layout.width then return end
    local p=UI.paneProgress.Value
    UI.reveal.Size=UDim2.fromOffset(layout.panelWidth*p,layout.height)
    UI.reveal.Visible=p>.001
    UI.window.Size=UDim2.fromOffset(layout.dockWidth+(layout.gap+layout.panelWidth)*p,layout.height)
    UI.panel.Position=UDim2.fromOffset(4-12*(1-p),4)
    UI.foldIcon.Rotation=180*(1-p)
    UI.selectionLight.Visible=state.paneOpen
    refreshAlpha()
end
local function applyPage()
    pages[state.page].Position=UDim2.fromOffset(-8*(1-UI.pageFade.Value),0)
    refreshAlpha()
end
local function recenter()
    local v=UI.screen.AbsoluteSize
    UI.window.Position=UDim2.fromOffset(math.floor((v.X-UI.window.Size.X.Offset)/2),math.floor((v.Y-layout.height)/2))
    UI.launcher.Position=UDim2.fromOffset(18,math.max(12,math.floor(v.Y*.5-34)))
end
local function resize(initial)
    local v=UI.screen.AbsoluteSize
    if v.X<1 or v.Y<1 then return end
    UI.loadToast:resize()
    layout.width=math.min(880,math.floor(v.X*(v.X<600 and .94 or .86)))
    layout.height=math.min(420,math.floor(v.Y*.82))
    layout.dockWidth=v.X<320 and 110 or (v.X<600 and 126 or 170)
    layout.gap=8;layout.panelWidth=math.max(150,layout.width-layout.dockWidth-layout.gap)
    local dw,h=layout.dockWidth,layout.height
    UI.dock.Size=UDim2.fromOffset(dw,h)
    UI.dockCrown.Visible=dw>=150
    UI.brand.Position=UDim2.fromOffset(dw>=150 and 46 or 8,8)
    UI.brand.Size=UDim2.fromOffset(dw-(dw>=150 and 52 or 16),44)
    UI.brand.TextSize=dw>=150 and 25 or (dw<120 and 22 or 24)
    local top=h<320 and 58 or 76
    UI.dockDivider.Position=UDim2.fromOffset(14,top-12)
    UI.dragArea.Size=UDim2.new(1,0,0,top-12)
    UI.nav.Position=UDim2.fromOffset(9,top)
    local available=h-top-60
    local step=math.clamp(math.floor(available/5),30,50)
    UI.nav.Size=UDim2.new(1,-18,0,available)
    UI.nav.CanvasSize=UDim2.fromOffset(0,5*step)
    layout.navStep=step
    for _,n in pairs(navigation) do
        n.button.Position=UDim2.fromOffset(0,(n.index-1)*step)
        n.button.Size=UDim2.new(1,-3,0,step-5)
        n.icon.Position=UDim2.fromOffset(dw>=150 and 12 or 8,(step-5-20)/2)
        n.icon.Visible=dw>=120
        n.caption.Position=UDim2.fromOffset(dw>=150 and 45 or (dw<120 and 12 or 36),0)
        n.caption.Size=UDim2.new(1,dw>=150 and -51 or (dw<120 and -20 or -39),1,0)
        n.caption.TextSize=dw>=150 and 19 or 17
    end
    UI.selectionLight.Position=UDim2.fromOffset(0,(navigation[state.page].index-1)*step+(step-23)/2)
    UI.controls.Size=UDim2.fromOffset(dw-24,36)
    UI.Minimize.Position=UDim2.new(.5,-20,0,0)
    UI.Minimize.Size=UDim2.fromOffset(40,36)
    controlArtwork.Minimize.glyph.Position=UDim2.fromOffset(9,7)
    UI.reveal.Position=UDim2.fromOffset(dw+layout.gap,0)
    local pw=layout.panelWidth-8
    UI.panel.Size=UDim2.fromOffset(pw,h-8)
    local wide=pw>=440
    local headerH=wide and 66 or (pw>=310 and 92 or 114)
    UI.header.Size=UDim2.new(1,-32,0,headerH)
    UI.header.Position=UDim2.fromOffset(16,0)
    UI.pageTitle.Position=UDim2.fromOffset(0,wide and 6 or 4)
    UI.pageTitle.Size=UDim2.fromOffset(wide and (pw>=570 and 116 or 80) or pw-32,wide and 54 or 36)
    local profileY=wide and 17 or 44
    local profileX=wide and (pw>=570 and 132 or 96) or 0
    UI.avatarPlate.Position=UDim2.fromOffset(profileX,profileY)
    UI.avatarPlate.Visible=pw>=160
    UI.userID.Position=UDim2.fromOffset(profileX+41,profileY)
    UI.userID.Size=UDim2.fromOffset(wide and pw-32-profileX-41-110 or math.max(84,pw-78),32)
    UI.sessionDot.Position=UDim2.fromOffset(wide and pw-136 or (pw>=310 and pw-136 or 4),wide and 30 or (pw>=310 and 57 or 89))
    UI.session.Position=UDim2.fromOffset(wide and pw-122 or (pw>=310 and pw-122 or 17),wide and 17 or (pw>=310 and 44 or 76))
    UI.session.Size=UDim2.fromOffset(94,32)
    if not wide and pw>=310 then UI.userID.Size=UDim2.fromOffset(pw-196,32) end
    if pw<160 then UI.userID.Position=UDim2.fromOffset(0,profileY);UI.userID.Size=UDim2.fromOffset(pw-32,32) end
    UI.panelDrag.Size=UDim2.new(1,0,0,headerH)
    UI.headerLine.Position=UDim2.fromOffset(16,headerH)
    UI.content.Position=UDim2.fromOffset(12,headerH+12)
    UI.content.Size=UDim2.new(1,-24,1,-headerH-48)
    local cw=pw-24
    local narrow=cw<360
    local heroHeight=narrow and 280 or math.min(300,math.max(200,h-8-headerH-54))
    UI.hero.Size=UDim2.new(1,-8,0,heroHeight)
    UI.heroTitle.TextSize=narrow and math.min(36,math.floor((cw-28)/3)) or math.min(50,math.floor(cw*.46/3))
    UI.heroTitle.Position=UDim2.fromOffset(narrow and 14 or 22,narrow and 4 or 12)
    UI.heroTitle.Size=UDim2.fromOffset(narrow and cw-36 or math.min(268,cw*.48),narrow and 50 or math.min(96,heroHeight-92))
    UI.emblemHost.Size=UDim2.fromOffset(narrow and math.min(cw-38,152) or math.min(cw*.43,232),narrow and 104 or heroHeight-24)
    UI.emblemHost.Position=narrow and UDim2.new(.5,-UI.emblemHost.Size.X.Offset/2,0,54) or UDim2.new(1,-UI.emblemHost.Size.X.Offset-14,0,12)
    UI.status.Position=UDim2.fromOffset(narrow and 14 or 22,narrow and 172 or heroHeight-134)
    UI.status.Size=UDim2.fromOffset(narrow and cw-28 or math.min(240,cw*.55),106)
    local compact=narrow and cw<185
    UI.statusLabel.Size=UDim2.fromOffset(compact and 46 or 62,24)
    UI.versionLabel.Size=UDim2.fromOffset(compact and 46 or 62,22)
    UI.authorLabel.Size=UDim2.fromOffset(compact and 46 or 62,22)
    UI.qqLabel.Size=UDim2.fromOffset(compact and 46 or 62,22)
    UI.statusLabel.TextSize=compact and 14 or 16;UI.versionLabel.TextSize=compact and 14 or 15
    UI.authorLabel.TextSize=compact and 14 or 15;UI.qqLabel.TextSize=compact and 14 or 15
    UI.statusDot.Visible=not compact
    UI.statusValue.Position=UDim2.fromOffset(compact and 52 or 82,0)
    UI.statusValue.Size=UDim2.new(1,compact and -52 or -82,0,24)
    UI.statusValue.TextSize=compact and 14 or 16
    UI.versionValue.Position=UDim2.fromOffset(compact and 52 or 71,26)
    UI.versionValue.Size=UDim2.new(1,compact and -52 or -71,0,22)
    UI.authorValue.Position=UDim2.fromOffset(compact and 52 or 71,52)
    UI.authorValue.Size=UDim2.new(1,compact and -52 or -71,0,22)
    UI.qqValue.Position=UDim2.fromOffset(compact and 52 or 71,78)
    UI.qqValue.Size=UDim2.new(1,compact and -52 or -71,0,22)
    pages["主页"].CanvasSize=UDim2.fromOffset(0,heroHeight+10)
    UI.gui:SetAttribute("NavigationStep",step)
    applyPane();applyPage()
    if initial then recenter() end
end
local function setPane(open)
    if state.target=="closed" then return end
    state.paneOpen=open;UI.gui:SetAttribute("PanelOpen",open)
    tween(UI.paneProgress,.32,{Value=open and 1 or 0})
    UI.selectionLight.Visible=open
end
local function selectPage(name,toggle)
    if state.target=="closed" then return end
    if toggle and name==state.page and state.paneOpen then setPane(false);return end
    local changed=state.page~=name
    state.page=name;UI.gui:SetAttribute("Page",name)
    for other,page in pairs(pages) do page.Visible=other==name end
    local page=pages[name];page.CanvasPosition=Vector2.zero
    pcall(function() page:ResetScrollVelocity() end)
    UI.pageTitle.Text=name
    UI.pageTitle.FontFace=optionFont
    for other,n in pairs(navigation) do
        local selected=other==name
        n.fx.selected=selected
        tween(n.fx.selection,.24,{Value=selected and 1 or 0})
        tween(n.caption,.22,{TextColor3=selected and C.white or C.muted})
        tintIcon(n.icon,selected and C.light or C.silver)
    end
    tween(UI.selectionLight,.22,{Position=UDim2.fromOffset(0,(navigation[name].index-1)*layout.navStep+(layout.navStep-23)/2)})
    if changed then UI.pageFade.Value=0;tween(UI.pageFade,.24,{Value=1}) end
    setPane(true)
end
for name,n in pairs(navigation) do connect(n.button.Activated,function() selectPage(name,true) end) end
connect(UI.paneProgress.Changed,applyPane)
connect(UI.pageFade.Changed,applyPage)
connect(UI.windowFade.Changed,refreshAlpha)
connect(UI.launcherFade.Changed,function()
    UI.launcherScale.Scale=.94+.06*UI.launcherFade.Value;refreshAlpha()
end)
connect(UI.zoom.Changed,function() UI.scale.Scale=UI.zoom.Value end)
connect(UI.screen:GetPropertyChangedSignal("AbsoluteSize"),function() resize(false) end)
local function offscreen(object)
    local p,s=object.AbsolutePosition,object.AbsoluteSize;local v=UI.screen.AbsoluteSize
    return p.X+s.X<8 or p.Y+s.Y<8 or p.X>v.X-8 or p.Y>v.Y-8
end

local uiHidden = false
local function hideAll()
    if not state.alive or state.target=="closed" or uiHidden then return end
    uiHidden = true
    UI.gui:SetAttribute("Minimized", true)
    state.target = "minimized"
    UI.launcher.Visible = true
    local winTween = TweenService:Create(UI.windowFade, TweenInfo.new(.26, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = 0})
    local launchTween = TweenService:Create(UI.launcherFade, TweenInfo.new(.26, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = 1})
    winTween:Play(); launchTween:Play()
    winTween.Completed:Connect(function()
        if uiHidden then UI.window.Visible = false end
    end)
end
local function showAll()
    if not state.alive or state.target=="closed" or not uiHidden then return end
    uiHidden = false
    UI.gui:SetAttribute("Minimized", false)
    state.target = "open"
    if offscreen(UI.window) then recenter() end
    UI.window.Visible = true
    local winTween = TweenService:Create(UI.windowFade, TweenInfo.new(.26, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = 1})
    local launchTween = TweenService:Create(UI.launcherFade, TweenInfo.new(.26, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = 0})
    winTween:Play(); launchTween:Play()
    winTween.Completed:Connect(function()
        if not uiHidden then UI.launcher.Visible = false end
    end)
end
connect(UI.Minimize.Activated,function()
    if state.target=="closed" then return end
    if uiHidden then showAll() else hideAll() end
end)
connect(UI.launcher.Activated,function()
    if state.suppressLauncherUntil and os.clock()<state.suppressLauncherUntil then return end
    if uiHidden then showAll() else hideAll() end
end)
connect(UI.recovery.Activated,function() recenter();showAll() end)
local function beginDrag(target,input)
    if state.target=="closed" or state.drag then return end
    local kind=input.UserInputType
    if kind~=Enum.UserInputType.MouseButton1 and kind~=Enum.UserInputType.Touch then return end
    if target==UI.launcher then state.suppressLauncherUntil=nil end
    state.drag={target=target,input=input,touch=kind==Enum.UserInputType.Touch,start=input.Position,position=target.Position,moved=false}
end
connect(UI.dragArea.InputBegan,function(input) beginDrag(UI.window,input) end)
connect(UI.panelDrag.InputBegan,function(input) beginDrag(UI.window,input) end)
connect(UI.launcher.InputBegan,function(input)
    beginDrag(UI.launcher,input)
    if state.drag and state.drag.target==UI.launcher and state.drag.input==input then
        tween(UI.launcherPress,.12,{Scale=.965})
    end
end)
connect(Input.InputChanged,function(input)
    local drag=state.drag
    if not drag then return end
    if drag.touch and input~=drag.input then return end
    if not drag.touch and input.UserInputType~=Enum.UserInputType.MouseMovement then return end
    local delta=input.Position-drag.start
    if not drag.moved and delta.Magnitude<5 then return end
    drag.moved=true
    drag.target.Position=UDim2.new(drag.position.X.Scale,drag.position.X.Offset+delta.X,drag.position.Y.Scale,drag.position.Y.Offset+delta.Y)
    if drag.target==UI.launcher then state.launcherMoved=true end
end)
local function endDrag(input,force)
    local drag=state.drag
    if not drag then return end
    if not force and ((drag.touch and input~=drag.input) or (not drag.touch and input.UserInputType~=Enum.UserInputType.MouseButton1)) then return end
    if drag.target==UI.launcher then
        tween(UI.launcherPress,.2,{Scale=1})
        if drag.moved then state.suppressLauncherUntil=os.clock()+.4 end
    end
    state.drag=nil
end
connect(Input.InputEnded,function(input) endDrag(input,false) end)
connect(Input.WindowFocusReleased,function() endDrag(nil,true) end)
connect(Input.InputBegan,function(input,processed)
    if processed or Input:GetFocusedTextBox() then return end
    if input.KeyCode==Enum.KeyCode.RightShift then
        if uiHidden then showAll() else hideAll() end
    end
end)




local function decorateControl(row, radius)
    local scale = make("UIScale", row, {Scale = 1})
    local edge = stroke(row, Color3.new(1,1,1), .58, 1)
    local edgeGradient = gradient(edge,{C.steel,C.cyan,C.silver,C.deep,C.violet},34)
    local neon = NeonFlow.new(row,"ControlNeon",radius or 11,#buttons*1.17,edgeGradient)
    neon.fill.ZIndex = 1
    local lip = frame(row,"ControlLip",UDim2.fromOffset(11,1),UDim2.new(1,-22,0,1),C.chrome,.84)
    local lipGradient = gradient(lip,{C.violet,C.cyan,C.chrome},0); fadeGradient(lipGradient)
    local sheen = frame(row,"ControlSheen",UDim2.fromOffset(2,2),UDim2.new(1,-4,1,-4),C.white,1)
    corner(sheen,9)
    local light = gradient(sheen,{C.cyan,C.white,C.light},25); fadeGradient(light)
    lip.ZIndex = 2; sheen.ZIndex = 2
    local record = {button=row, face=row, scale=scale, edge=edge, sheen=sheen, light=light, lip=lip,
        selectedGradient=nil, neon=neon, hover=false, selected=false, pressed=false,
        energy=make("NumberValue",row,{Name="ControlEnergy",Value=0}),
        selection=make("NumberValue",row,{Name="ControlSelection",Value=0})}
    record.reflection = addReflection(sheen, light, .13)
    buttons[#buttons+1] = record
    connect(record.energy.Changed,function() updateButtonLight(record) end)
    connect(record.selection.Changed,function() updateButtonLight(record) end)
    connect(row.MouseEnter,function() record.hover=true; tween(record.energy,.2,{Value=.65}); VFX.reflections:request(record.reflection) end)
    connect(row.MouseLeave,function() record.hover=false; if not record.pressed then tween(record.energy,.28,{Value=0}) end end)
    return record
end

local function AddToggle(parent, name, title, default, callback)
    local row = frame(parent, name, UDim2.fromOffset(5, 10), UDim2.fromOffset(CONTROL_WIDTH, 56), C.card)
    corner(row, 12)
    stroke(row, C.line, .45, 1)
    local lbl = label(row, "Label", title, UDim2.fromOffset(16, 0), UDim2.new(1, -90, 1, 0), 18, C.white, OPTION_FONT)
    local val = default or false
    local track = frame(row, "Track", UDim2.new(1, -66, .5, -10), UDim2.fromOffset(52, 20), C.black)
    track.AnchorPoint = Vector2.new(1, .5); corner(track, 10)
    local trackStroke = stroke(track, C.steel, .6, 1)
    local knob = frame(track, "Knob", UDim2.fromOffset(val and 32 or 3, 3), UDim2.fromOffset(14, 14), C.white)
    corner(knob, 7)
    local btn = make("TextButton", row, {Name = "Click", Text = "", BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 0), Size = UDim2.fromScale(1, 1), AutoButtonColor = false})
    local function paint()
        tween(knob, .2, {Position = UDim2.fromOffset(val and 32 or 3, 3), BackgroundColor3 = val and C.violet or C.white})
        tween(trackStroke, .2, {Color = val and C.violet or C.steel, Transparency = val and .15 or .6})
        tween(lbl, .2, {TextColor3 = val and C.violet or C.white})
    end
    paint()
    btn.MouseButton1Click:Connect(function()
        val = not val
        paint()
        if callback then callback(val) end
    end)
    decorateControl(row, 12)
    return row
end

local function AddSlider(parent, name, title, min, max, default, callback)
    local row = frame(parent, name, UDim2.fromOffset(5, 10), UDim2.fromOffset(CONTROL_WIDTH, 66), C.card)
    corner(row, 12)
    stroke(row, C.line, .45, 1)
    local lbl = label(row, "Label", title, UDim2.fromOffset(16, 4), UDim2.new(1, -100, 0, 24), 16, C.white, OPTION_FONT)
    local valLbl = label(row, "Value", tostring(default), UDim2.new(1, -80, 0, 4), UDim2.fromOffset(64, 24), 16, C.violet, OPTION_FONT)
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    local track = frame(row, "Track", UDim2.fromOffset(16, 38), UDim2.new(1, -32, 0, 10), C.black)
    corner(track, 5)
    local fill = frame(track, "Fill", UDim2.fromOffset(0, 0), UDim2.new((default-min)/(max-min), 0, 1, 0), C.violet)
    corner(fill, 5)
    local dragBtn = make("TextButton", row, {Name = "DragArea", Text = "", BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 28), Size = UDim2.new(1, 0, 0, 32), AutoButtonColor = false})
    local currentValue = default
    local function updateFromX(x)
        local trackAbs = track.AbsolutePosition
        local trackW = track.AbsoluteSize.X
        local ratio = math.clamp((x - trackAbs.X) / math.max(1, trackW), 0, 1)
        currentValue = math.floor(min + (max - min) * ratio + .5)
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        valLbl.Text = tostring(currentValue)
        if callback then callback(currentValue) end
    end
    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateFromX(input.Position.X)
            local moveC
            moveC = Input.InputChanged:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                    updateFromX(inp.Position.X)
                end
            end)
            local endC
            endC = Input.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    if moveC then moveC:Disconnect(); moveC = nil end
                    if endC then endC:Disconnect(); endC = nil end
                end
            end)
        end
    end)
    decorateControl(row, 12)
    return row
end

local function AddDropdown(parent, name, title, options, default, callback)
    local container = frame(parent, name, UDim2.fromOffset(5, 10), UDim2.fromOffset(CONTROL_WIDTH, 56), C.card)
    corner(container, 12)
    stroke(container, C.line, .45, 1)
    local lbl = label(container, "Label", title, UDim2.fromOffset(16, 0), UDim2.new(1, -170, 0, 56), 18, C.white, OPTION_FONT)
    local selected = default or options[1]
    local header = make("TextButton", container, {Name = "Header", Text = "  " .. selected,
        Position = UDim2.new(1, -160, 0, 17), Size = UDim2.fromOffset(144, 22),
        BackgroundColor3 = C.bg, AutoButtonColor = false, TextColor3 = C.white,
        Font = Enum.Font.Gotham, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left})
    corner(header, 8)
    stroke(header, C.violet, .3, 1)
    local list = frame(container, "List", UDim2.fromOffset(0, 56), UDim2.fromOffset(CONTROL_WIDTH, 0), C.panel)
    corner(list, 10)
    list.ClipsDescendants = true
    local layoutList = Instance.new("UIListLayout", list)
    layoutList.Padding = UDim.new(0, 2)
    local open = false
    local function shiftSiblings(delta)
        local page = container.Parent
        if not page or not page:IsA("ScrollingFrame") then return end
        local myY = container.Position.Y.Offset
        for _,child in ipairs(page:GetChildren()) do
            if child:IsA("GuiObject") and child ~= container then
                if child.Position.Y.Offset > myY then
                    child.Position = UDim2.new(child.Position.X.Scale, child.Position.X.Offset, 0, child.Position.Y.Offset + delta)
                end
            end
        end
        page.CanvasSize = UDim2.fromOffset(page.CanvasSize.X.Offset, math.max(0, page.CanvasSize.Y.Offset + delta))
    end
    for _, opt in ipairs(options) do
        local optBtn = make("TextButton", list, {Name = "Opt", Text = "  " .. opt,
            Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = C.panel, AutoButtonColor = false,
            TextColor3 = C.white, Font = Enum.Font.Gotham, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left})
        optBtn.BorderSizePixel = 0
        optBtn.MouseEnter:Connect(function() optBtn.BackgroundColor3 = C.card end)
        optBtn.MouseLeave:Connect(function() optBtn.BackgroundColor3 = C.panel end)
        optBtn.MouseButton1Click:Connect(function()
            selected = opt
            header.Text = "  " .. selected
            open = false
            local h = list.Size.Y.Offset + 4
            shiftSiblings(-h)
            tween(list, .25, {Size = UDim2.fromOffset(CONTROL_WIDTH, 0)})
            tween(container, .25, {Size = UDim2.fromOffset(CONTROL_WIDTH, 56)})
            if callback then callback(selected) end
        end)
    end
    header.MouseButton1Click:Connect(function()
        open = not open
        if open then
            local h = math.min(#options * 34 + 4, 200)
            shiftSiblings(h + 4)
            tween(list, .25, {Size = UDim2.fromOffset(CONTROL_WIDTH, h)})
            tween(container, .25, {Size = UDim2.fromOffset(CONTROL_WIDTH, 56 + h + 4)})
        else
            local h = list.Size.Y.Offset + 4
            shiftSiblings(-h)
            tween(list, .25, {Size = UDim2.fromOffset(CONTROL_WIDTH, 0)})
            tween(container, .25, {Size = UDim2.fromOffset(CONTROL_WIDTH, 56)})
        end
    end)
    decorateControl(container, 12)
    return container
end

local function AddTextbox(parent, name, title, default, callback)
    local row = frame(parent, name, UDim2.fromOffset(5, 10), UDim2.fromOffset(CONTROL_WIDTH, 56), C.card)
    corner(row, 12)
    stroke(row, C.line, .45, 1)
    local lbl = label(row, "Label", title, UDim2.fromOffset(16, 0), UDim2.new(0.4, -16, 1, 0), 18, C.white, OPTION_FONT)
    local box = frame(row, "Box", UDim2.new(0.6, -20, 0, 24), UDim2.fromOffset(0, 24), C.bg)
    box.Position = UDim2.new(0.4, 4, 0.5, -12)
    box.Size = UDim2.new(0.6, -20, 0, 24)
    corner(box, 8)
    stroke(box, C.violet, .35, 1)
    local input = make("TextBox", box, {Name = "Input", Text = default or "",
        Size = UDim2.new(1, -12, 1, 0), Position = UDim2.fromOffset(6, 0),
        BackgroundTransparency = 1, TextColor3 = C.white, Font = Enum.Font.Gotham,
        TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center, ClearTextOnFocus = false})
    input.FocusLost:Connect(function()
        if callback then callback(input.Text) end
    end)
    decorateControl(row, 12)
    return row
end






local function wrapControl(control, page)
    control.SetPosition = function(self, x, y)
        self.Position = UDim2.fromOffset(x, y)
        
        local bottom = y + self.Size.Y.Offset + 10
        if bottom > page.CanvasSize.Y.Offset then
            page.CanvasSize = UDim2.fromOffset(0, bottom)
        end
        return self
    end
    return control
end


local Tab = {}
Tab.__index = Tab
local pageYOffset = {["主页"]=10,["功能"]=10,["视角"]=10}

local function ensureCanvas(pageName)
    if pageYOffset[pageName] then
        local page = pageMap[pageName]
        if page then
            local need = pageYOffset[pageName] + 20
            if page.CanvasSize.Y.Offset < need then
                page.CanvasSize = UDim2.fromOffset(0, need)
            end
        end
    end
end

function Tab:Button(text, callback)
    local pageName = self._page
    local y = pageYOffset[pageName]
    local btn, fx = button(pageMap[pageName], "Btn_"..text..y, UDim2.fromOffset(5, y), UDim2.fromOffset(CONTROL_WIDTH, 56))
    btn.Active = true
    label(btn, "Cap", text, UDim2.fromOffset(16, 0), UDim2.new(1, -32, 1, 0), 18, C.white, OPTION_FONT)
    btn.Activated:Connect(function()
        if callback then callback() end
    end)
    pageYOffset[pageName] = y + 64
    pageMap[pageName].CanvasSize = UDim2.fromOffset(0, pageYOffset[pageName] + 20)
    return btn
end

function Tab:Toggle(text, default, callback)
    local pageName = self._page
    local y = pageYOffset[pageName]
    local row = AddToggle(pageMap[pageName], "Tg_"..text..y, text, default, callback)
    row.Position = UDim2.fromOffset(5, y)
    pageYOffset[pageName] = y + 64
    pageMap[pageName].CanvasSize = UDim2.fromOffset(0, pageYOffset[pageName] + 20)
    return row
end

function Tab:Slider(text, min, max, default, callback)
    local pageName = self._page
    local y = pageYOffset[pageName]
    local row = AddSlider(pageMap[pageName], "Sl_"..text..y, text, min, max, default, callback)
    row.Position = UDim2.fromOffset(5, y)
    pageYOffset[pageName] = y + 74
    pageMap[pageName].CanvasSize = UDim2.fromOffset(0, pageYOffset[pageName] + 20)
    return row
end

function Tab:Dropdown(text, options, default, callback)
    local pageName = self._page
    local y = pageYOffset[pageName]
    local row = AddDropdown(pageMap[pageName], "Dd_"..text..y, text, options, default, callback)
    row.Position = UDim2.fromOffset(5, y)
    pageYOffset[pageName] = y + 64
    pageMap[pageName].CanvasSize = UDim2.fromOffset(0, pageYOffset[pageName] + 20)
    return row
end

function Tab:Textbox(text, default, callback)
    local pageName = self._page
    local y = pageYOffset[pageName]
    local row = AddTextbox(pageMap[pageName], "Tb_"..text..y, text, default, callback)
    row.Position = UDim2.fromOffset(5, y)
    pageYOffset[pageName] = y + 64
    pageMap[pageName].CanvasSize = UDim2.fromOffset(0, pageYOffset[pageName] + 20)
    return row
end

function Tab:Label(text)
    local pageName = self._page
    local y = pageYOffset[pageName]
    local lbl = label(pageMap[pageName], "Lbl_"..text..y, text, UDim2.fromOffset(8, y), UDim2.fromOffset(CONTROL_WIDTH, 24), 14, C.muted, OPTION_FONT)
    pageYOffset[pageName] = y + 32
    pageMap[pageName].CanvasSize = UDim2.fromOffset(0, pageYOffset[pageName] + 20)
    return lbl
end

function Tab:Divider()
    local pageName = self._page
    local y = pageYOffset[pageName]
    local div = frame(pageMap[pageName], "Div_"..y, UDim2.fromOffset(8, y+4), UDim2.fromOffset(CONTROL_WIDTH-16, 1), C.line, 0.5)
    pageYOffset[pageName] = y + 16
    pageMap[pageName].CanvasSize = UDim2.fromOffset(0, pageYOffset[pageName] + 20)
    return div
end


local Window = {}
Window.__index = Window

function Window:Tab(name)
    
    if not pageMap[name] then
        warn("[139club] 页面不存在:", name, "可用页面: 主页/功能/视角")
        return nil
    end
    local tabObj = setmetatable({_page = name}, Tab)
    return tabObj
end

function Window:SelectPage(name)
    selectPage(name, false)
end


function Club:Window(title)
    
    local winObj = setmetatable({_title = title}, Window)
    windowObj = winObj
    return winObj
end




local ASSETS={
    IconHome={url=ICON_URI,file="139club-icon-home-v1.png",bytes=0,images=artworkImages.IconHome},
    IconMain={url=ICON_URI,file="139club-icon-main-v1.png",bytes=0,images=artworkImages.IconMain},
    IconVisuals={url=ICON_URI,file="139club-icon-visuals-v1.png",bytes=0,images=artworkImages.IconVisuals},
    IconScripts={url=ICON_URI,file="139club-icon-scripts-v1.png",bytes=0,images=artworkImages.IconScripts},
    IconSettings={url=ICON_URI,file="139club-icon-settings-v1.png",bytes=0,images=artworkImages.IconSettings},
    Background={url=BG_URI,file="139club-background-v3.png",bytes=0,images=artworkImages.Background},
    HeroBackground={url=HERO_BG_URI,file="139club-hero-bg-v1.png",bytes=0,images=artworkImages.HeroBackground},
    R={url=ICON_URI,file="139club-launcher-r-v1.png",bytes=0,images={UI.launcherImage,UI.recoveryImage,UI.launcherShine}},
    X={url=ICON_URI,file="139club-emblem-x-v1.png",bytes=0,images=artworkImages.Emblem},
    Minimize={url=ICON_URI,file="139club-minimize-v1.png",bytes=0,images={controlArtwork.Minimize.image,controlArtwork.Minimize.glow}},
}
local function loadAsset(key,asset)
    if asset.url:match("^rbxassetid://") then
        for _,o in ipairs(asset.images) do
            if asset.rect then o.ImageRectOffset=asset.rect[1];o.ImageRectSize=asset.rect[2] end
            o.Image=asset.url
        end
        UI.gui:SetAttribute("Asset"..key,"assigned")
        pcall(function() ContentProvider:PreloadAsync(asset.images) end)
    end
end
for key,asset in pairs(ASSETS) do spawn(function() loadAsset(key,asset) end) end
spawn(function()
    local ok,uri=pcall(function() return Players:GetUserThumbnailAsync(player.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150) end)
    if state.alive and ok and type(uri)=="string" and uri~="" then UI.avatar.Image=uri end
end)

local function updateClock()
    local seconds=math.max(0,math.floor(os.clock()-startedAt))
    if seconds~=state.lastSecond then
        state.lastSecond=seconds;UI.gui:SetAttribute("ElapsedSeconds",seconds)
        UI.session.Text=string.format("%02d:%02d:%02d",math.floor(seconds/3600),math.floor(seconds/60)%60,seconds%60)
    end
end

resize(true)
selectPage("主页",false)
UI.gui:SetAttribute("PanelOpen",true)
UI.gui:SetAttribute("Minimized",false)
updateClock();refreshAlpha();UI.loadToast:start()

UI.windowFade.Value = 1
UI.launcherFade.Value = 0
UI.launcher.Visible = false

connect(RunService.Heartbeat,function(dt)
    updateClock()
    state.budget+=dt
    state.effectElapsed=(state.effectElapsed or 0)+dt
    local interval=1/VFX_RATE
    if state.budget<interval then return end
    local elapsed=state.effectElapsed;state.effectElapsed=0
    state.budget=state.budget%interval;state.phase+=elapsed
    state.burst=math.max(0,state.burst-elapsed*3)
    local p=state.phase
    UI.loadToast:update(os.clock(),p)
    local pulse=.5+.5*math.sin(p*1.8)
    UI.recovery.Visible=state.target~="closed" and offscreen(state.target=="minimized" and UI.launcher or UI.window)
    if p>=(state.assetPoll or 0) then
        state.assetPoll=p+.2
        UI.avatarFallback.Visible=UI.avatar.Image=="" or not UI.avatar.IsLoaded
        UI.rFallback.Visible=UI.launcherImage.Image=="" or not UI.launcherImage.IsLoaded
        UI.recoveryFallback.Visible=UI.recoveryImage.Image=="" or not UI.recoveryImage.IsLoaded
        UI.xFallback.Visible=UI.xImage.Image=="" or not UI.xImage.IsLoaded
        for name,control in pairs(controlArtwork) do
            control.fallback.Visible=control.image.Image=="" or not control.image.IsLoaded
        end
        for _,sprite in ipairs(iconSprites) do
            local ready=sprite.image.Image~="" and sprite.image.IsLoaded
            for _,line in ipairs(sprite.fallback) do line.Visible=not ready end
        end
    end
    local visibleTarget=uiHidden and UI.launcher or UI.window
    if offscreen(visibleTarget) then return end
    if UI.launcher.Visible and uiHidden then
        local cycle=p%5.1
        local sweep=math.min(1,cycle/1.25)
        UI.launcherSweep.Offset=Vector2.new(-1+2*sweep,0)
        alpha(UI.launcherShine,"ImageTransparency",1-math.sin(sweep*math.pi)^2*.24)
    end
    VFX.reflections:update(elapsed)
    if uiHidden then return end
    for i,fx in ipairs(VFX.surfaces) do
        fx.inward:update(p,state.burst)
        fx.neon:update(p,.105+.015*math.sin(p*.7+i)^2)
        local breath=.5+.5*math.sin(p*.65+i*1.7)
        alpha(fx.beam,"BackgroundTransparency",.72-.12*breath-.12*state.burst)
        fx.beamGradient.Offset=Vector2.new(math.sin(p*.18+i)*.34,0)
    end
    for _,record in ipairs(buttons) do
        record.neon:update(p,.085+record.selection.Value*.11+record.energy.Value*.04)
        if record.selectedGradient then record.selectedGradient.Offset=record.neon.wash.Offset end
    end
    if state.page=="主页" and state.paneOpen then
        UI.heroNeon:update(p,.085)
        UI.emblemNeon:update(p,state.burst)
        alpha(UI.statusDot,"BackgroundTransparency",.08+.12*pulse)
    end
end)






local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local events = ReplicatedStorage:WaitForChild("events")
local Guess     = events:WaitForChild("Guess")
local SlapQueue = events:WaitForChild("SlapQueue")
local SendSlap  = events:WaitForChild("SendSlap")
local Dodge     = events:WaitForChild("Dodge")




local SLAP_POWER = 0.99927914142609
local GUESS_DELAY = 0.10
local SLAP_DELAY  = 0.01
local QUEUE_DELAY = 1
local DODGE_DELAY = 0.10

local DETECTION_DELAY = 0.10
local MAX_DISTANCE    = 12
local MAX_BEHIND_DOT  = -0.35

local FREECAM_SPEED       = 1.5
local FREECAM_FAST_SPEED  = 4
local FREECAM_SENSITIVITY = 0.20

local LagWalkDelay = 2
local LagJumpDelay = 2




local state = {
    autoSlap        = false,
    slapSpam        = false,
    autoGuess       = false,
    autoQueue       = false,
    autoDodge       = false,
    freeCam         = false,
    lagWalk         = false,
    lagJump         = false,
}
local AutoGuessTarget = nil
local LastGuessNames = {}
local LastGuessTime = 0


local FreeCamConnection = nil
local Camera = workspace.CurrentCamera
local FreeCamPosition = nil
local FreeCamRotation = Vector2.new(0, 0)
local Looking = false
local LastLookPosition = nil
local Touches = {}
local FreeCamMove = {W=false,A=false,S=false,D=false,Q=false,E=false,Shift=false}


local LagWalkConnection, LagJumpConnection
local LagWalkBuffer, LagJumpQueue = {}, {}




local function GetRoot(player)
    local c = player.Character
    if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart")
end

local function FindBestBehindPlayer()
    local MyRoot = GetRoot(LocalPlayer)
    if not MyRoot then return nil end
    local Best, BestScore = nil, math.huge
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            local TargetRoot = GetRoot(Player)
            if TargetRoot then
                local Offset = TargetRoot.Position - MyRoot.Position
                local Distance = Offset.Magnitude
                if Distance > 0 and Distance <= MAX_DISTANCE then
                    local BehindDot = MyRoot.CFrame.LookVector:Dot(Offset.Unit)
                    if BehindDot <= MAX_BEHIND_DOT then
                        local Score = Distance - math.abs(BehindDot) * 4
                        if Score < BestScore then
                            BestScore = Score
                            Best = Player
                        end
                    end
                end
            end
        end
    end
    return Best
end




local function StartAutoGuess()
    if state.autoGuess then return end
    state.autoGuess = true
    task.spawn(function()
        while state.autoGuess do
            AutoGuessTarget = FindBestBehindPlayer()
            if AutoGuessTarget and AutoGuessTarget.Parent == Players then
                Guess:FireServer(AutoGuessTarget.Name)
            end
            task.wait(GUESS_DELAY)
        end
    end)
end
local function StopAutoGuess()
    state.autoGuess = false
    AutoGuessTarget = nil
end

local function StartAutoQueue()
    if state.autoQueue then return end
    state.autoQueue = true
    task.spawn(function()
        while state.autoQueue do
            SlapQueue:FireServer("Join")
            task.wait(QUEUE_DELAY)
        end
    end)
end
local function StopAutoQueue() state.autoQueue = false end

local function StartSlapSpam()
    if state.slapSpam then return end
    state.slapSpam = true
    task.spawn(function()
        while state.slapSpam do
            SendSlap:FireServer(SLAP_POWER)
            task.wait(SLAP_DELAY)
        end
    end)
end
local function StopSlapSpam() state.slapSpam = false end

local function StartAutoSlap()
    if state.autoSlap then return end
    state.autoSlap = true
    task.spawn(function()
        while state.autoSlap do
            SendSlap:FireServer(SLAP_POWER)
            task.wait(SLAP_DELAY)
        end
    end)
end
local function StopAutoSlap() state.autoSlap = false end

local function StartAutoDodge()
    if state.autoDodge then return end
    state.autoDodge = true
    task.spawn(function()
        while state.autoDodge do
            Dodge:FireServer(true)
            task.wait(DODGE_DELAY)
        end
    end)
end
local function StopAutoDodge()
    state.autoDodge = false
    pcall(function() Dodge:FireServer(false) end)
end


local function StartFreeCam()
    if state.freeCam then return end
    state.freeCam = true
    Camera = workspace.CurrentCamera
    FreeCamPosition = Camera.CFrame.Position
    local LookVector = Camera.CFrame.LookVector
    FreeCamRotation = Vector2.new(
        math.asin(LookVector.Y),
        math.atan2(-LookVector.X, -LookVector.Z)
    )
    Camera.CameraType = Enum.CameraType.Scriptable
    FreeCamConnection = RunService.RenderStepped:Connect(function()
        if not state.freeCam then return end
        local Speed = FreeCamMove.Shift and FREECAM_FAST_SPEED or FREECAM_SPEED
        local Rotation = CFrame.Angles(FreeCamRotation.X, FreeCamRotation.Y, 0)
        local Move = Vector3.zero
        if FreeCamMove.W then Move += Rotation.LookVector end
        if FreeCamMove.S then Move -= Rotation.LookVector end
        if FreeCamMove.A then Move -= Rotation.RightVector end
        if FreeCamMove.D then Move += Rotation.RightVector end
        if FreeCamMove.Q then Move -= Vector3.yAxis end
        if FreeCamMove.E then Move += Vector3.yAxis end
        if Move.Magnitude > 0 then
            FreeCamPosition += Move.Unit * Speed
        end
        Camera.CFrame = CFrame.new(FreeCamPosition) * Rotation
    end)
end
local function StopFreeCam()
    state.freeCam = false
    if FreeCamConnection then
        FreeCamConnection:Disconnect()
        FreeCamConnection = nil
    end
    Camera = workspace.CurrentCamera
    Camera.CameraType = Enum.CameraType.Custom
end


local function StartLagWalk()
    if state.lagWalk then return end
    state.lagWalk = true
    table.clear(LagWalkBuffer)
    LagWalkConnection = RunService.Heartbeat:Connect(function()
        if not state.lagWalk then return end
        local c = LocalPlayer.Character
        local root = c and c:FindFirstChild("HumanoidRootPart")
        if not root then return end
        table.insert(LagWalkBuffer, {Time=os.clock(), CFrame=root.CFrame})
        local Target = os.clock() - LagWalkDelay
        local Oldest = nil
        for i = #LagWalkBuffer, 1, -1 do
            if LagWalkBuffer[i].Time <= Target then
                Oldest = LagWalkBuffer[i]; break
            end
        end
        if Oldest then
            if not state.freeCam then root.CFrame = Oldest.CFrame end
            while #LagWalkBuffer > 0 and LagWalkBuffer[1].Time <= Target do
                table.remove(LagWalkBuffer, 1)
            end
        end
    end)
end
local function StopLagWalk()
    state.lagWalk = false
    if LagWalkConnection then LagWalkConnection:Disconnect(); LagWalkConnection = nil end
    table.clear(LagWalkBuffer)
end


local function StartLagJump()
    if state.lagJump then return end
    state.lagJump = true
    table.clear(LagJumpQueue)
    LagJumpConnection = RunService.Heartbeat:Connect(function()
        if not state.lagJump then return end
        local c = LocalPlayer.Character
        local hum = c and c:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        if hum:GetState() == Enum.HumanoidStateType.Jumping then
            table.insert(LagJumpQueue, os.clock())
        end
        local Now = os.clock()
        for i = #LagJumpQueue, 1, -1 do
            if Now - LagJumpQueue[i] >= LagJumpDelay then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                table.remove(LagJumpQueue, i)
            end
        end
    end)
end
local function StopLagJump()
    state.lagJump = false
    if LagJumpConnection then LagJumpConnection:Disconnect(); LagJumpConnection = nil end
    table.clear(LagJumpQueue)
end




Guess.OnClientEvent:Connect(function(data)
    LastGuessNames = {}
    if typeof(data) == "table" then
        for _, v in ipairs(data) do
            if typeof(v) == "Instance" and v:IsA("Player") and v ~= LocalPlayer then
                table.insert(LastGuessNames, v.Name)
            end
        end
    end
    LastGuessTime = os.clock()
end)


LocalPlayer.CharacterAdded:Connect(function()
    AutoGuessTarget = nil
    table.clear(LagWalkBuffer)
    table.clear(LagJumpQueue)
    if state.freeCam then StopFreeCam() end
end)

local function BuildUI(Club, win)
    local funcTab = win:Tab("功能")
    local visTab  = win:Tab("视角")

    funcTab:Label("扇耳光 · 战斗功能")
    funcTab:Divider()

    
    funcTab:Toggle("自动扇耳光 (T)", false, function(v)
        if v then StartAutoSlap() else StopAutoSlap() end
    end)

    
    funcTab:Toggle("扇耳光刷屏 (H)", false, function(v)
        if v then StartSlapSpam() else StopSlapSpam() end
    end)

    
    funcTab:Toggle("自动猜身后玩家 (G)", false, function(v)
        if v then StartAutoGuess() else StopAutoGuess() end
    end)

    
    funcTab:Toggle("自动排队 (Q)", false, function(v)
        if v then StartAutoQueue() else StopAutoQueue() end
    end)

    
    funcTab:Toggle("自动躲避 (D)", false, function(v)
        if v then StartAutoDodge() else StopAutoDodge() end
    end)

    funcTab:Divider()
    funcTab:Label("高级功能")

    
    funcTab:Toggle("假走路延迟 (L)", false, function(v)
        if v then StartLagWalk() else StopLagWalk() end
    end)

    funcTab:Toggle("假跳跃延迟 (J)", false, function(v)
        if v then StartLagJump() else StopLagJump() end
    end)

    
    funcTab:Button("一键开启全部功能", function()
        if not state.autoSlap  then StartAutoSlap()  end
        if not state.slapSpam  then StartSlapSpam()  end
        if not state.autoQueue then StartAutoQueue() end
        if not state.autoDodge then StartAutoDodge() end
    end)

    funcTab:Button("一键关闭全部功能", function()
        StopAutoSlap(); StopSlapSpam(); StopAutoQueue(); StopAutoDodge()
        StopAutoGuess(); StopLagWalk(); StopLagJump(); StopFreeCam()
    end)

    
    visTab:Label("自由视角")
    visTab:Toggle("自由视角 (F)", false, function(v)
        if v then StartFreeCam() else StopFreeCam() end
    end)

    visTab:Label("WASD 移动 · QE 升降 · Shift 加速 · 左键拖拽视角")
    visTab:Button("重置相机", function()
        Camera = workspace.CurrentCamera
        Camera.CameraType = Enum.CameraType.Custom
    end)
end




local KEY = {
    AutoSlap = Enum.KeyCode.T,
    SlapSpam = Enum.KeyCode.H,
    AutoGuess = Enum.KeyCode.G,
    AutoQueue = Enum.KeyCode.Q,
    AutoDodge = Enum.KeyCode.D,
    FreeCam  = Enum.KeyCode.F,
    LagWalk  = Enum.KeyCode.L,
    LagJump  = Enum.KeyCode.J,
}

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    local k = input.KeyCode

    
    if k == Enum.KeyCode.W then FreeCamMove.W = true
    elseif k == Enum.KeyCode.A then FreeCamMove.A = true
    elseif k == Enum.KeyCode.S then FreeCamMove.S = true
    elseif k == Enum.KeyCode.D then FreeCamMove.D = true
    elseif k == Enum.KeyCode.Q then FreeCamMove.Q = true
    elseif k == Enum.KeyCode.E then FreeCamMove.E = true
    elseif k == Enum.KeyCode.LeftShift then FreeCamMove.Shift = true
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Looking = true
        LastLookPosition = input.Position
    end

    
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if k == KEY.AutoSlap then
            if state.autoSlap then StopAutoSlap() else StartAutoSlap() end
        elseif k == KEY.SlapSpam then
            if state.slapSpam then StopSlapSpam() else StartSlapSpam() end
        elseif k == KEY.AutoGuess then
            if state.autoGuess then StopAutoGuess() else StartAutoGuess() end
        elseif k == KEY.AutoQueue then
            if state.autoQueue then StopAutoQueue() else StartAutoQueue() end
        elseif k == KEY.AutoDodge then
            if state.autoDodge then StopAutoDodge() else StartAutoDodge() end
        elseif k == KEY.FreeCam then
            if state.freeCam then StopFreeCam() else StartFreeCam() end
        elseif k == KEY.LagWalk then
            if state.lagWalk then StopLagWalk() else StartLagWalk() end
        elseif k == KEY.LagJump then
            if state.lagJump then StopLagJump() else StartLagJump() end
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not state.freeCam then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement and Looking and LastLookPosition then
        local Delta = input.Position - LastLookPosition
        LastLookPosition = input.Position
        FreeCamRotation = Vector2.new(
            math.clamp(FreeCamRotation.X - Delta.Y * FREECAM_SENSITIVITY * 0.01, -math.rad(89), math.rad(89)),
            FreeCamRotation.Y - Delta.X * FREECAM_SENSITIVITY * 0.01
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    local k = input.KeyCode
    if k == Enum.KeyCode.W then FreeCamMove.W = false
    elseif k == Enum.KeyCode.A then FreeCamMove.A = false
    elseif k == Enum.KeyCode.S then FreeCamMove.S = false
    elseif k == Enum.KeyCode.D then FreeCamMove.D = false
    elseif k == Enum.KeyCode.Q then FreeCamMove.Q = false
    elseif k == Enum.KeyCode.E then FreeCamMove.E = false
    elseif k == Enum.KeyCode.LeftShift then FreeCamMove.Shift = false
    end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Looking = false
        LastLookPosition = nil
    end
end)


UserInputService.TouchStarted:Connect(function(touch)
    Touches[touch] = true
    if state.freeCam and not LastLookPosition then
        LastLookPosition = touch.Position
    end
end)
UserInputService.TouchMoved:Connect(function(touch)
    if not state.freeCam then return end
    if LastLookPosition then
        local Delta = touch.Position - LastLookPosition
        LastLookPosition = touch.Position
        FreeCamRotation = Vector2.new(
            math.clamp(FreeCamRotation.X - Delta.Y * FREECAM_SENSITIVITY * 0.01, -math.rad(89), math.rad(89)),
            FreeCamRotation.Y - Delta.X * FREECAM_SENSITIVITY * 0.01
        )
    end
end)
UserInputService.TouchEnded:Connect(function(touch)
    Touches[touch] = nil
    if next(Touches) == nil then LastLookPosition = nil end
end)




local win = Club:Window("139club · 扇耳光")
BuildUI(Club, win)
