local NexusLib = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Colors = {
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

function NexusLib:CreateWindow(titleText)
    titleText = titleText or "NEXUS FARM"
    
    -- Автоматическое удаление старого окна при повторном запуске
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
        ColorSequenceKeypoint.new(0, Color3.fromRGB(156, 102, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 229, 255))
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

        -- Добавление тегов / меток (текст)
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

        -- Добавление прогресс-бара (0-100%)
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
            Padding.Paddi
