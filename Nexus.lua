local NexusLib = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Themes = {
    NightSky = {
        Background = Color3.fromRGB(18, 18, 22),
        TopBar = Color3.fromRGB(24, 24, 30),
        ButtonOff = Color3.fromRGB(30, 30, 38),
        ButtonHover = Color3.fromRGB(40, 40, 48),
        ButtonOn = Color3.fromRGB(114, 46, 209),
        TextLight = Color3.fromRGB(240, 240, 240),
        TextDark = Color3.fromRGB(150, 150, 150),
        Stroke = Color3.fromRGB(45, 45, 55),
        StrokeOn = Color3.fromRGB(156, 102, 255),
        CloseHover = Color3.fromRGB(220, 50, 50)
    },
    Rose = {
        Background = Color3.fromRGB(22, 18, 20),
        TopBar = Color3.fromRGB(30, 22, 26),
        ButtonOff = Color3.fromRGB(38, 28, 33),
        ButtonHover = Color3.fromRGB(48, 35, 42),
        ButtonOn = Color3.fromRGB(219, 68, 125),
        TextLight = Color3.fromRGB(245, 240, 242),
        TextDark = Color3.fromRGB(160, 140, 148),
        Stroke = Color3.fromRGB(55, 42, 48),
        StrokeOn = Color3.fromRGB(255, 105, 165),
        CloseHover = Color3.fromRGB(220, 50, 50)
    },
    Gold = {
        Background = Color3.fromRGB(20, 20, 18),
        TopBar = Color3.fromRGB(28, 28, 24),
        ButtonOff = Color3.fromRGB(36, 36, 30),
        ButtonHover = Color3.fromRGB(46, 46, 38),
        ButtonOn = Color3.fromRGB(212, 160, 23),
        TextLight = Color3.fromRGB(245, 245, 240),
        TextDark = Color3.fromRGB(150, 150, 130),
        Stroke = Color3.fromRGB(50, 50, 40),
        StrokeOn = Color3.fromRGB(255, 204, 51),
        CloseHover = Color3.fromRGB(220, 50, 50)
    },
    Crimson = {
        Background = Color3.fromRGB(22, 16, 16),
        TopBar = Color3.fromRGB(30, 20, 20),
        ButtonOff = Color3.fromRGB(38, 26, 26),
        ButtonHover = Color3.fromRGB(48, 34, 34),
        ButtonOn = Color3.fromRGB(204, 34, 34),
        TextLight = Color3.fromRGB(245, 240, 240),
        TextDark = Color3.fromRGB(160, 130, 130),
        Stroke = Color3.fromRGB(55, 40, 40),
        StrokeOn = Color3.fromRGB(255, 77, 77),
        CloseHover = Color3.fromRGB(220, 50, 50)
    },
    Light = {
        Background = Color3.fromRGB(240, 240, 245),
        TopBar = Color3.fromRGB(225, 225, 230),
        ButtonOff = Color3.fromRGB(210, 210, 218),
        ButtonHover = Color3.fromRGB(195, 195, 204),
        ButtonOn = Color3.fromRGB(74, 119, 255),
        TextLight = Color3.fromRGB(30, 30, 35),
        TextDark = Color3.fromRGB(100, 100, 110),
        Stroke = Color3.fromRGB(180, 180, 190),
        StrokeOn = Color3.fromRGB(74, 119, 255),
        CloseHover = Color3.fromRGB(220, 50, 50)
    },
    Black = {
        Background = Color3.fromRGB(10, 10, 10),
        TopBar = Color3.fromRGB(16, 16, 16),
        ButtonOff = Color3.fromRGB(22, 22, 22),
        ButtonHover = Color3.fromRGB(32, 32, 32),
        ButtonOn = Color3.fromRGB(80, 80, 80),
        TextLight = Color3.fromRGB(230, 230, 230),
        TextDark = Color3.fromRGB(120, 120, 120),
        Stroke = Color3.fromRGB(40, 40, 40),
        StrokeOn = Color3.fromRGB(150, 150, 150),
        CloseHover = Color3.fromRGB(200, 40, 40)
    },
    Planty = {
        Background = Color3.fromRGB(16, 22, 18),
        TopBar = Color3.fromRGB(22, 30, 24),
        ButtonOff = Color3.fromRGB(28, 38, 30),
        ButtonHover = Color3.fromRGB(36, 48, 38),
        ButtonOn = Color3.fromRGB(46, 160, 67),
        TextLight = Color3.fromRGB(240, 245, 240),
        TextDark = Color3.fromRGB(130, 150, 135),
        Stroke = Color3.fromRGB(40, 55, 42),
        StrokeOn = Color3.fromRGB(87, 212, 110),
        CloseHover = Color3.fromRGB(220, 50, 50)
    },
    BlueSky = {
        Background = Color3.fromRGB(16, 20, 26),
        TopBar = Color3.fromRGB(22, 28, 38),
        ButtonOff = Color3.fromRGB(28, 36, 48),
        ButtonHover = Color3.fromRGB(38, 48, 64),
        ButtonOn = Color3.fromRGB(33, 150, 243),
        TextLight = Color3.fromRGB(240, 245, 250),
        TextDark = Color3.fromRGB(130, 145, 165),
        Stroke = Color3.fromRGB(40, 52, 70),
        StrokeOn = Color3.fromRGB(64, 196, 255),
        CloseHover = Color3.fromRGB(220, 50, 50)
    },
    Rainbow = {
        Background = Color3.fromRGB(18, 18, 22),
        TopBar = Color3.fromRGB(24, 24, 30),
        ButtonOff = Color3.fromRGB(30, 30, 38),
        ButtonHover = Color3.fromRGB(40, 40, 48),
        ButtonOn = Color3.fromRGB(255, 50, 100),
        TextLight = Color3.fromRGB(240, 240, 240),
        TextDark = Color3.fromRGB(150, 150, 150),
        Stroke = Color3.fromRGB(45, 45, 55),
        StrokeOn = Color3.fromRGB(255, 200, 0),
        CloseHover = Color3.fromRGB(220, 50, 50)
    }
}

local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function addStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

function NexusLib:CreateWindow(titleText, themeName)
    titleText = titleText or "NEXUS FARM"
    themeName = themeName or "NightSky"
    local Colors = Themes[themeName] or Themes["NightSky"]
    
    if getgenv().NexusLoadedUI then
        pcall(function()
            getgenv().NexusLoadedUI:Destroy()
        end)
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NexusLibraryUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    if gethui then ScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then syn.protect_gui(ScreenGui); ScreenGui.Parent = game:GetService("CoreGui")
    else ScreenGui.Parent = PlayerGui end

    getgenv().NexusLoadedUI = ScreenGui

    local currentSize = UDim2.new(0, 340, 0, 350)

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.AnchorPoint = Vector2.new(0, 0) 
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    addCorner(MainFrame, 12)
    addStroke(MainFrame, Colors.Stroke, 1.5)

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Colors.TopBar
    TopBar.BorderSizePixel = 0
    TopBar.ZIndex = 2
    TopBar.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = titleText
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBlack
    TitleLabel.Parent = TopBar

    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors.StrokeOn),
        ColorSequenceKeypoint.new(1, Colors.ButtonOn)
    })
    TitleGradient.Parent = TitleLabel

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 1)
    Line.Position = UDim2.new(0, 0, 1, 0)
    Line.BackgroundColor3 = Colors.Stroke
    Line.BorderSizePixel = 0
    Line.Parent = TopBar

    local function createTopButton(text, posOffset, size)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, size, 0, size)
        btn.Position = UDim2.new(1, -posOffset, 0.5, -size/2)
        btn.BackgroundColor3 = Colors.Background
        btn.Text = text
        btn.TextColor3 = Colors.TextLight
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBlack
        btn.ZIndex = 3
        btn.Parent = TopBar
        addCorner(btn, 6)
        addStroke(btn, Colors.Stroke)
        return btn
    end

    local CloseBtn = createTopButton("X", 36, 26)
    local MinBtn = createTopButton("-", 68, 26)

    local TabHeader = Instance.new("Frame")
    TabHeader.Size = UDim2.new(1, 0, 0, 32)
    TabHeader.Position = UDim2.new(0, 0, 0, 40)
    TabHeader.BackgroundColor3 = Colors.TopBar
    TabHeader.BorderSizePixel = 0
    TabHeader.ZIndex = 2
    TabHeader.Parent = MainFrame

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, 0, 1, -72)
    ContentContainer.Position = UDim2.new(0, 0, 0, 72)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local ResizeBtn = Instance.new("TextButton")
    ResizeBtn.Size = UDim2.new(0, 18, 0, 18)
    ResizeBtn.Position = UDim2.new(1, -18, 1, -18)
    ResizeBtn.BackgroundTransparency = 1
    ResizeBtn.Text = "◢"
    ResizeBtn.TextColor3 = Colors.TextDark
    ResizeBtn.TextSize = 14
    ResizeBtn.ZIndex = 10
    ResizeBtn.Parent = MainFrame

    ResizeBtn.MouseEnter:Connect(function() TweenService:Create(ResizeBtn, TweenInfo.new(0.2), {TextColor3 = Colors.TextLight}):Play() end)
    ResizeBtn.MouseLeave:Connect(function() TweenService:Create(ResizeBtn, TweenInfo.new(0.2), {TextColor3 = Colors.TextDark}):Play() end)

    local dragging, resizing = false, false
    local dragStart, startPos, startSize
    local isMinimized = false

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)

    ResizeBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true; dragStart = input.Position; startSize = MainFrame.AbsoluteSize
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then resizing = false end end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            elseif resizing and not isMinimized then
                local delta = input.Position - dragStart
                local newWidth = math.clamp(startSize.X + delta.X, 280, 500)
                local newHeight = math.clamp(startSize.Y + delta.Y, 200, 600)
                MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
                currentSize = MainFrame.Size
            end
        end
    end)

    MinBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        local targetSize = isMinimized and UDim2.new(0, MainFrame.Size.X.Offset, 0, 40) or currentSize
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, isMinimized and Enum.EasingDirection.In or Enum.EasingDirection.Out), {Size = targetSize}):Play()
    end)

    CloseBtn.MouseEnter:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.CloseHover}):Play() end)
    CloseBtn.MouseLeave:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Background}):Play() end)

    CloseBtn.MouseButton1Click:Connect(function()
        local targetPosX = MainFrame.Position.X.Offset + (MainFrame.Size.X.Offset / 2)
        local targetPosY = MainFrame.Position.Y.Offset + (MainFrame.Size.Y.Offset / 2)
        
        local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(MainFrame.Position.X.Scale, targetPosX, MainFrame.Position.Y.Scale, targetPosY)
        })
        closeTween:Play()
        closeTween.Completed:Wait()
        ScreenGui:Destroy()
        getgenv().NexusLoadedUI = nil
    end)

    TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = currentSize,
        Position = UDim2.new(0.5, -currentSize.X.Offset / 2, 0.5, -currentSize.Y.Offset / 2)
    }):Play()

    local Window = {}
    getgenv().NexusWindowRef = Window
    getgenv().NexusColorsRef = Colors
    getgenv().NexusContentContainerRef = ContentContainer
    getgenv().NexusTabHeaderRef = TabHeader

    return Window
end

getgenv().NexusLib = NexusLib
local NexusLib = getgenv().NexusLib
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

getgenv().NexusTabBuilders = getgenv().NexusTabBuilders or {}

table.insert(getgenv().NexusTabBuilders, function(TabObj, Scroll, Colors, addCorner, addStroke, UserInputService, TweenService)
    function TabObj:AddLabel(text)
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(0.92, 0, 0, 26)
        Container.BackgroundTransparency = 1
        Container.Parent = Scroll

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Colors.TextDark
        Label.TextSize = 12
        Label.Font = Enum.Font.GothamBold
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Container

        local LabelObj = {}
        function LabelObj:Set(newText)
            Label.Text = newText
        end
        return LabelObj
    end

    function TabObj:AddButton(text, callback)
        callback = callback or function() end
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(0.92, 0, 0, 38)
        Container.BackgroundTransparency = 1
        Container.Parent = Scroll

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 1, 0)
        Button.BackgroundColor3 = Colors.ButtonOff
        Button.Text = text
        Button.TextColor3 = Colors.TextLight
        Button.TextSize = 13
        Button.Font = Enum.Font.GothamBold
        Button.AutoButtonColor = false
        Button.Parent = Container
        
        addCorner(Button, 6)
        local BtnStroke = addStroke(Button, Colors.Stroke)

        local tweenFast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        Button.MouseEnter:Connect(function()
            TweenService:Create(Button, tweenFast, {BackgroundColor3 = Colors.ButtonHover}):Play()
            TweenService:Create(BtnStroke, tweenFast, {Color = Colors.StrokeOn}):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            TweenService:Create(Button, tweenFast, {BackgroundColor3 = Colors.ButtonOff}):Play()
            TweenService:Create(BtnStroke, tweenFast, {Color = Colors.Stroke}):Play()
        end)
        
        Button.MouseButton1Click:Connect(function()
            local pressTween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Colors.ButtonOn})
            pressTween:Play()
            pressTween.Completed:Wait()
            TweenService:Create(Button, tweenFast, {BackgroundColor3 = Colors.ButtonHover}):Play()
            
            pcall(callback)
        end)
    end

    function TabObj:AddProgressBar(text, min, max)
        min = min or 0
        max = max or 100

        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(0.92, 0, 0, 46)
        Container.BackgroundColor3 = Colors.ButtonOff
        Container.Parent = Scroll
        addCorner(Container, 6)
        addStroke(Container, Colors.Stroke)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -16, 0, 20)
        Label.Position = UDim2.new(0, 8, 0, 4)
        Label.BackgroundTransparency = 1
        Label.Text = text .. " (0%)"
        Label.TextColor3 = Colors.TextLight
        Label.TextSize = 12
        Label.Font = Enum.Font.GothamBold
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Container

        local BarBg = Instance.new("Frame")
        BarBg.Size = UDim2.new(1, -16, 0, 5)
        BarBg.Position = UDim2.new(0, 8, 0, 30)
        BarBg.BackgroundColor3 = Colors.Background
        BarBg.BorderSizePixel = 0
        BarBg.Parent = Container
        addCorner(BarBg, 2)

        local BarFill = Instance.new("Frame")
        BarFill.Size = UDim2.new(0, 0, 1, 0)
        BarFill.BackgroundColor3 = Colors.ButtonOn
        BarFill.BorderSizePixel = 0
        BarFill.Parent = BarBg
        addCorner(BarFill, 2)

        local BarObj = {}
        function BarObj:Set(value)
            value = math.clamp(value, min, max)
            local percent = math.floor(((value - min) / (max - min)) * 100)
            TweenService:Create(BarFill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            }):Play()
            Label.Text = text .. " (" .. percent .. "%)"
        end
        return BarObj
    end
    
    function TabObj:AddToggle(text, callback)
        callback = callback or function() end
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(0.92, 0, 0, 38)
        Container.BackgroundTransparency = 1
        Container.Parent = Scroll

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 1, 0)
        Button.BackgroundColor3 = Colors.ButtonOff
        Button.Text = text
        Button.TextColor3 = Colors.TextDark
        Button.TextSize = 13
        Button.Font = Enum.Font.GothamBold
        Button.AutoButtonColor = false
        Button.Parent = Container
        
        addCorner(Button, 6)
        local BtnStroke = addStroke(Button, Colors.Stroke)

        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 8, 0, 8)
        Indicator.Position = UDim2.new(1, -16, 0.5, -4)
        Indicator.BackgroundColor3 = Colors.TextDark
        Indicator.Parent = Button
        addCorner(Indicator, 8)

        local enabled = false
        local tweenFast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        Button.MouseEnter:Connect(function() if not enabled then TweenService:Create(Button, tweenFast, {BackgroundColor3 = Colors.ButtonHover}):Play() end end)
        Button.MouseLeave:Connect(function() if not enabled then TweenService:Create(Button, tweenFast, {BackgroundColor3 = Colors.ButtonOff}):Play() end end)
        
        Button.MouseButton1Click:Connect(function()
            enabled = not enabled
            if enabled then
                TweenService:Create(Button, tweenFast, {BackgroundColor3 = Colors.ButtonOn, TextColor3 = Colors.TextLight}):Play()
                TweenService:Create(BtnStroke, tweenFast, {Color = Colors.StrokeOn}):Play()
                TweenService:Create(Indicator, tweenFast, {BackgroundColor3 = Color3.fromRGB(0, 255, 170)}):Play()
            else
                TweenService:Create(Button, tweenFast, {BackgroundColor3 = Colors.ButtonHover, TextColor3 = Colors.TextDark}):Play()
                TweenService:Create(BtnStroke, tweenFast, {Color = Colors.Stroke}):Play()
                TweenService:Create(Indicator, tweenFast, {BackgroundColor3 = Colors.TextDark}):Play()
            end
            pcall(callback, enabled)
        end)
    end
end)

task.spawn(function()
    local startTime = tick()
    while not getgenv().NexusWindowRef and (tick() - startTime < 5) do
        task.wait(0.05)
    end
    
    local Window = getgenv().NexusWindowRef
    local Colors = getgenv().NexusColorsRef
    local ContentContainer = getgenv().NexusContentContainerRef
    local TabHeader = getgenv().NexusTabHeaderRef

    if not Window then return end

    local function addCorner(parent, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = parent
        return corner
    end

    local function addStroke(parent, color, thickness)
        local stroke = Instance.new("UIStroke")
        stroke.Color = color
        stroke.Thickness = thickness or 1
        stroke.Parent = parent
        return stroke
    end

    local tabsCount = 0
    local tabButtonsList = {}

    function Window:CreateTab(tabName)
        tabsCount = tabsCount + 1
        local currentTabName = tabName

        local Scroll = Instance.new("ScrollingFrame")
        Scroll.Name = currentTabName .. "Scroll"
        Scroll.Size = UDim2.new(1, 0, 1, -10)
        Scroll.Position = UDim2.new(0, 0, 0, 10)
        Scroll.BackgroundTransparency = 1
        Scroll.ScrollBarThickness = 4
        Scroll.ScrollBarImageColor3 = Colors.StrokeOn
        Scroll.BorderSizePixel = 0
        Scroll.Visible = false
        Scroll.Parent = ContentContainer

        local Layout = Instance.new("UIListLayout")
        Layout.Padding = UDim.new(0, 8)
        Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Parent = Scroll

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 16)
        end)

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 0, 1, 0)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = currentTabName
        TabBtn.TextColor3 = Colors.TextDark
        TabBtn.TextSize = 12
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.Parent = TabHeader

        tabButtonsList[currentTabName] = {Button = TabBtn, Scroll = Scroll}

        local count = 0
        for _ in pairs(tabButtonsList) do count = count + 1 end
        local index = 0
        for name, data in pairs(tabButtonsList) do
            data.Button.Size = UDim2.new(1 / count, 0, 1, 0)
            data.Button.Position = UDim2.new(index / count, 0, 0, 0)
            index = index + 1
        end

        if tabsCount == 1 then
            Scroll.Visible = true
            TabBtn.TextColor3 = Colors.TextLight
        end

        TabBtn.MouseButton1Click:Connect(function()
            for name, data in pairs(tabButtonsList) do
                data.Scroll.Visible = (name == currentTabName)
                TweenService:Create(data.Button, TweenInfo.new(0.2), {
                    TextColor3 = (name == currentTabName) and Colors.TextLight or Colors.TextDark
                }):Play()
            end
        end)

        local TabObj = {}

        if getgenv().NexusTabBuilders then
            for _, builder in ipairs(getgenv().NexusTabBuilders) do
                builder(TabObj, Scroll, Colors, addCorner, addStroke, UserInputService, TweenService)
            end
        end

        return TabObj
    end
end)

return NexusLib
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

getgenv().NexusTabBuilders = getgenv().NexusTabBuilders or {}

table.insert(getgenv().NexusTabBuilders, function(TabObj, Scroll, Colors, addCorner, addStroke, UserInputService, TweenService)
    function TabObj:AddSlider(text, min, max, default, callback)
        min = min or 0
        max = max or 100
        default = default or 50
        callback = callback or function() end

        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(0.92, 0, 0, 46)
        Container.BackgroundColor3 = Colors.ButtonOff
        Container.Parent = Scroll
        addCorner(Container, 6)
        addStroke(Container, Colors.Stroke)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -16, 0, 20)
        Label.Position = UDim2.new(0, 8, 0, 4)
        Label.BackgroundTransparency = 1
        Label.Text = text .. ": " .. default
        Label.TextColor3 = Colors.TextLight
        Label.TextSize = 12
        Label.Font = Enum.Font.GothamBold
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Container

        local SliderBg = Instance.new("Frame")
        SliderBg.Size = UDim2.new(1, -16, 0, 5)
        SliderBg.Position = UDim2.new(0, 8, 0, 30)
        SliderBg.BackgroundColor3 = Colors.Background
        SliderBg.BorderSizePixel = 0
        SliderBg.Parent = Container
        addCorner(SliderBg, 2)

        local SliderFill = Instance.new("Frame")
        SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        SliderFill.BackgroundColor3 = Colors.ButtonOn
        SliderFill.BorderSizePixel = 0
        SliderFill.Parent = SliderBg
        addCorner(SliderFill, 2)

        local draggingSlider = false
        SliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = true
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
                SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                local val = math.floor(min + (max - min) * pos)
                Label.Text = text .. ": " .. val
                pcall(callback, val)
            end
        end)
    end

    function TabObj:AddTextBox(placeholderText, callback)
        callback = callback or function() end
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(0.92, 0, 0, 38)
        Container.BackgroundTransparency = 1
        Container.Parent = Scroll

        local TextBox = Instance.new("TextBox")
        TextBox.Size = UDim2.new(1, 0, 1, 0)
        TextBox.BackgroundColor3 = Colors.ButtonOff
        TextBox.Text = ""
        TextBox.PlaceholderText = placeholderText or "Enter text here"
        TextBox.PlaceholderColor3 = Colors.TextDark
        TextBox.TextColor3 = Colors.TextLight
        TextBox.TextSize = 13
        TextBox.Font = Enum.Font.GothamBold
        TextBox.ClearTextOnFocus = false
        TextBox.TextXAlignment = Enum.TextXAlignment.Left
        TextBox.Parent = Container

        local Padding = Instance.new("UIPadding")
        Padding.PaddingLeft = UDim.new(0, 12)
        Padding.PaddingRight = UDim.new(0, 12)
        Padding.Parent = TextBox

        addCorner(TextBox, 6) 
        local TxtStroke = addStroke(TextBox, Colors.Stroke)

        TextBox.Focused:Connect(function()
            TweenService:Create(TxtStroke, TweenInfo.new(0.2), {Color = Colors.StrokeOn}):Play()
        end)
        
        TextBox.FocusLost:Connect(function(enterPressed)
            TweenService:Create(TxtStroke, TweenInfo.new(0.2), {Color = Colors.Stroke}):Play()
            pcall(callback, TextBox.Text, enterPressed)
        end)
    end

    function TabObj:AddDropdown(text, options, callback)
        options = options or {}
        callback = callback or function() end
        local selectedOption = options[1] or "Выберите..."
        local isOpen = false

        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(0.92, 0, 0, 38)
        Container.BackgroundTransparency = 1
        Container.ClipsDescendants = false
        Container.Parent = Scroll
        Container.ZIndex = 5

        local MainButton = Instance.new("TextButton")
        MainButton.Size = UDim2.new(1, 0, 0, 38)
        MainButton.BackgroundColor3 = Colors.ButtonOff
        MainButton.Text = "  " .. text .. ": " .. tostring(selectedOption)
        MainButton.TextColor3 = Colors.TextLight
        MainButton.TextSize = 13
        MainButton.Font = Enum.Font.GothamBold
        MainButton.TextXAlignment = Enum.TextXAlignment.Left
        MainButton.AutoButtonColor = false
        MainButton.ZIndex = 5
        MainButton.Parent = Container
        addCorner(MainButton, 6)
        local BtnStroke = addStroke(MainButton, Colors.Stroke)

        local Arrow = Instance.new("TextLabel")
        Arrow.Size = UDim2.new(0, 20, 1, 0)
        Arrow.Position = UDim2.new(1, -25, 0, 0)
        Arrow.BackgroundTransparency = 1
        Arrow.Text = "▼"
        Arrow.TextColor3 = Colors.TextDark
        Arrow.TextSize = 12
        Arrow.Font = Enum.Font.GothamBold
        Arrow.ZIndex = 6
        Arrow.Parent = MainButton

        local DropListFrame = Instance.new("ScrollingFrame")
        DropListFrame.Size = UDim2.new(1, 0, 0, 0)
        DropListFrame.Position = UDim2.new(0, 0, 0, 42)
        DropListFrame.BackgroundColor3 = Colors.Background
        DropListFrame.BorderSizePixel = 0
        DropListFrame.Visible = false
        DropListFrame.ZIndex = 10
        DropListFrame.ScrollBarThickness = 3
        DropListFrame.ScrollBarImageColor3 = Colors.StrokeOn
        DropListFrame.Parent = Container
        addCorner(DropListFrame, 6)
        addStroke(DropListFrame, Colors.Stroke)

        local ListLayout = Instance.new("UIListLayout")
        ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ListLayout.Parent = DropListFrame

        local function updateList(newOptions)
            options = newOptions or {}
            for _, child in ipairs(DropListFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end

            local totalHeight = 0
            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 30)
                OptBtn.BackgroundColor3 = Colors.ButtonOff
                OptBtn.Text = "  " .. tostring(opt)
                OptBtn.TextColor3 = Colors.TextDark
                OptBtn.TextSize = 12
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                OptBtn.AutoButtonColor = false
                OptBtn.ZIndex = 11
                OptBtn.Parent = DropListFrame

                OptBtn.MouseEnter:Connect(function()
                    TweenService:Create(OptBtn, TweenInfo.new(0.15), {BackgroundColor3 = Colors.ButtonHover, TextColor3 = Colors.TextLight}):Play()
                end)
                OptBtn.MouseLeave:Connect(function()
                    TweenService:Create(OptBtn, TweenInfo.new(0.15), {BackgroundColor3 = Colors.ButtonOff, TextColor3 = Colors.TextDark}):Play()
                end)

                OptBtn.MouseButton1Click:Connect(function()
                    selectedOption = opt
                    MainButton.Text = "  " .. text .. ": " .. tostring(selectedOption)
                    isOpen = false
                    TweenService:Create(Container, TweenInfo.new(0.2), {Size = UDim2.new(0.92, 0, 0, 38)}):Play()
                    TweenService:Create(DropListFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                    Arrow.Text = "▼"
                    task.wait(0.2)
                    DropListFrame.Visible = false
                    pcall(callback, selectedOption)
                end)

                totalHeight = totalHeight + 30
            end

            DropListFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
        end

        updateList(options)

        MainButton.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                DropListFrame.Visible = true
                local targetHeight = math.clamp(#options * 30, 0, 120)
                TweenService:Create(Container, TweenInfo.new(0.2), {Size = UDim2.new(0.92, 0, 0, 38 + targetHeight + 6)}):Play()
                TweenService:Create(DropListFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
                Arrow.Text = "▲"
            else
                TweenService:Create(Container, TweenInfo.new(0.2), {Size = UDim2.new(0.92, 0, 0, 38)}):Play()
                TweenService:Create(DropListFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                Arrow.Text = "▼"
                task.wait(0.2)
                DropListFrame.Visible = false
            end
        end)

        local DropObj = {}
        function DropObj:Refresh(newOptions)
            updateList(newOptions)
        end
        return DropObj
    end
end)

