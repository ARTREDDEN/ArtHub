-- [[ ART HUB V12 - MERGED EDITION ]] --
if game.PlaceId ~= 11093153578 then 
    game:GetService("Players").LocalPlayer:Kick("Unauthorized Game: This script is exclusively for Barry's Prison Run.")
    return 
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local RightPanel = Instance.new("Frame")
local TabContainer = Instance.new("ScrollingFrame")
local PageContainer = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TitleImage = Instance.new("ImageLabel")
local ToggleButton = Instance.new("ImageButton")

local success, err = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not success then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(160, 32, 240)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

LeftPanel.Name = "LeftPanel"
LeftPanel.Parent = MainFrame
LeftPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
LeftPanel.Size = UDim2.new(0, 150, 1, 0)

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 12)
LeftCorner.Parent = LeftPanel

TitleImage.Parent = LeftPanel
TitleImage.BackgroundTransparency = 1
TitleImage.Position = UDim2.new(0, 8, 0, 12)
TitleImage.Size = UDim2.new(0, 26, 0, 26)
TitleImage.Image = "rbxthumb://type=Asset&id=133337806226605&w=420&h=420"

Title.Parent = LeftPanel
Title.Text = "ART HUB"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(160, 32, 240)
Title.TextSize = 22
Title.Position = UDim2.new(0, 38, 0, 0)
Title.Size = UDim2.new(1, -38, 0, 50)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

TabContainer.Parent = LeftPanel
TabContainer.Position = UDim2.new(0, 5, 0, 60)
TabContainer.Size = UDim2.new(1, -10, 1, -70)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 2
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 300)

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.Padding = UDim.new(0, 5)

RightPanel.Name = "RightPanel"
RightPanel.Parent = MainFrame
RightPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
RightPanel.Position = UDim2.new(0, 155, 0, 10)
RightPanel.Size = UDim2.new(1, -165, 1, -20)

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 8)
RightCorner.Parent = RightPanel

PageContainer.Parent = RightPanel
PageContainer.Size = UDim2.new(1, 0, 1, 0)
PageContainer.BackgroundTransparency = 1

ToggleButton.Parent = ScreenGui
ToggleButton.Position = UDim2.new(0, 15, 0, 15)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleButton.Image = "rbxthumb://type=Asset&id=133337806226605&w=420&h=420"

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(160, 32, 240)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleButton

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- =================================================================
-- [[ CORE LOGIC FUNCTIONS ]]
-- =================================================================
local Settings = {
    MasterLoop = false,
    ESP = false,
    InfJump = false,
    Noclip = false,
    WalkSpeed = 16
}

local lp = game:GetService("Players").LocalPlayer

game:GetService("RunService").Stepped:Connect(function()
    if Settings.Noclip and lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then 
                v.CanCollide = false 
            end
        end
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if Settings.Noclip and lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then 
                v.CanCollide = false 
            end
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        if lp.Character.Humanoid.WalkSpeed ~= Settings.WalkSpeed then
            lp.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if Settings.InfJump and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

local function CreateESP(plr)
    task.spawn(function()
        while task.wait(0.5) do
            if plr == lp then break end
            local char = plr.Character
            
            if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                local highlight = char:FindFirstChild("ArtHub_BlueBox") or Instance.new("Highlight", char)
                highlight.Name = "ArtHub_BlueBox"
                highlight.Enabled = Settings.ESP
                highlight.FillTransparency = 1 
                highlight.OutlineColor = Color3.fromRGB(0, 120, 255) 
                highlight.OutlineTransparency = 0 
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                local head = char:FindFirstChild("Head")
                if head then
                    local bbg = head:FindFirstChild("ArtHub_NameUI") or Instance.new("BillboardGui", head)
                    bbg.Name = "ArtHub_NameUI"
                    bbg.Adornee = head
                    bbg.Size = UDim2.new(0, 200, 0, 30)
                    bbg.StudsOffset = Vector3.new(0, 2.5, 0)
                    bbg.AlwaysOnTop = true
                    bbg.Enabled = Settings.ESP

                    local textLabel = bbg:FindFirstChild("PlayerName") or Instance.new("TextLabel", bbg)
                    textLabel.Name = "PlayerName"
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Text = plr.Name
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
                    textLabel.TextSize = 18
                    textLabel.TextStrokeTransparency = 0 
                    textLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                end
            end

            if not Settings.ESP and plr.Character then
                if plr.Character:FindFirstChild("ArtHub_BlueBox") then
                    plr.Character.ArtHub_BlueBox.Enabled = false
                end
                if plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("ArtHub_NameUI") then
                    plr.Character.Head.ArtHub_NameUI.Enabled = false
                end
            end
        end
    end)
end

for _, player in pairs(game:GetService("Players"):GetPlayers()) do CreateESP(player) end
game:GetService("Players").PlayerAdded:Connect(CreateESP)

---------------------------------------------------------
-- [[ TAB SYSTEM ]]
---------------------------------------------------------
local FirstPage = nil

local function CreateTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Parent = TabContainer
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabButton.Text = tabName
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 16
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 6)
    TCorner.Parent = TabButton
    
    local Page = Instance.new("ScrollingFrame")
    Page.Parent = PageContainer
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 4
    Page.CanvasSize = UDim2.new(0, 0, 0, 450)
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    if not FirstPage then
        FirstPage = Page
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    TabButton.MouseButton1Click:Connect(function()
        for _, p in pairs(PageContainer:GetChildren()) do
            if p:IsA("ScrollingFrame") then p.Visible = false end
        end
        for _, btn in pairs(TabContainer:GetChildren()) do
            if btn:IsA("TextButton") then 
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40) 
                btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    local ElementFunctions = {}
    
    function ElementFunctions:AddButton(btnText, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = Page
        Button.Size = UDim2.new(1, -10, 0, 35)
        Button.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        Button.Text = btnText
        Button.Font = Enum.Font.SourceSansBold
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 16
        
        local BCorner = Instance.new("UICorner")
        BCorner.CornerRadius = UDim.new(0, 6)
        BCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(function()
            if callback then pcall(callback) end
        end)
    end
    
    function ElementFunctions:AddToggle(toggleText, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Parent = Page
        ToggleFrame.Size = UDim2.new(1, -10, 0, 35)
        ToggleFrame.BackgroundTransparency = 1
        
        local Txt = Instance.new("TextLabel")
        Txt.Parent = ToggleFrame
        Txt.Size = UDim2.new(0, 250, 1, 0)
        Txt.BackgroundTransparency = 1
        Txt.Text = toggleText
        Txt.Font = Enum.Font.SourceSansBold
        Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        Txt.TextSize = 16
        Txt.TextXAlignment = Enum.TextXAlignment.Left
        
        local Btn = Instance.new("TextButton")
        Btn.Parent = ToggleFrame
        Btn.Position = UDim2.new(1, -45, 0, 5)
        Btn.Size = UDim2.new(0, 40, 0, 25)
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Btn.Text = ""
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 4)
        BtnCorner.Parent = Btn
        
        local toggled = false
        Btn.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                Btn.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
            else
                Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
            if callback then pcall(callback, toggled) end
        end)
    end

    function ElementFunctions:AddSlider(sliderText, min, max, default, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Parent = Page
        SliderFrame.Size = UDim2.new(1, -10, 0, 50)
        SliderFrame.BackgroundTransparency = 1

        local Txt = Instance.new("TextLabel")
        Txt.Parent = SliderFrame
        Txt.Size = UDim2.new(0, 180, 0, 20)
        Txt.BackgroundTransparency = 1
        Txt.Text = sliderText
        Txt.Font = Enum.Font.SourceSansBold
        Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        Txt.TextSize = 15
        Txt.TextXAlignment = Enum.TextXAlignment.Left

        local ValTxt = Instance.new("TextLabel")
        ValTxt.Parent = SliderFrame
        ValTxt.Position = UDim2.new(1, -70, 0, 0)
        ValTxt.Size = UDim2.new(0, 60, 0, 20)
        ValTxt.BackgroundTransparency = 1
        ValTxt.Text = tostring(default)
        ValTxt.Font = Enum.Font.SourceSansBold
        ValTxt.TextColor3 = Color3.fromRGB(160, 32, 240)
        ValTxt.TextSize = 15
        ValTxt.TextXAlignment = Enum.TextXAlignment.Right

        local MainBar = Instance.new("TextButton")
        MainBar.Parent = SliderFrame
        MainBar.Position = UDim2.new(0, 0, 0, 25)
        MainBar.Size = UDim2.new(1, 0, 0, 10)
        MainBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        MainBar.Text = ""

        local BarCorner = Instance.new("UICorner")
        BarCorner.CornerRadius = UDim.new(0, 4)
        BarCorner.Parent = MainBar

        local FillBar = Instance.new("Frame")
        FillBar.Parent = MainBar
        FillBar.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
        FillBar.BackgroundColor3 = Color3.fromRGB(160, 32, 240)

        local FillCorner = Instance.new("UICorner")
        FillCorner.CornerRadius = UDim.new(0, 4)
        FillCorner.Parent = FillBar

        local function UpdateSlider()
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local percentage = math.clamp((mouse.X - MainBar.AbsolutePosition.X) / MainBar.AbsoluteSize.X, 0, 1)
            FillBar.Size = UDim2.new(percentage, 0, 1, 0)
            local value = math.round(min + (max - min) * percentage)
            ValTxt.Text = tostring(value)
            if callback then pcall(callback, value) end
        end

        local isSliding = false
        MainBar.MouseButton1Down:Connect(function()
            isSliding = true
            UpdateSlider()
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                UpdateSlider()
            end
        end)

        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isSliding = false
            end
        end)
    end
    
    return ElementFunctions
end

---------------------------------------------------------
-- [[ UI TABS & FEATURES ]]
---------------------------------------------------------

-- ==== Main Features ====
local MainTab = CreateTab("Main Features")

MainTab:AddButton("🚁 Teleport to Helicopter", function()
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Model") and (v.Name:lower():find("heli") or v.Name:lower():find("chopper")) then
            local p = v:FindFirstChildWhichIsA("BasePart", true)
            if p then
                hrp.Velocity = Vector3.new(0,0,0)
                hrp.CFrame = p.CFrame * CFrame.new(0, 5, 0)
                break
            end
        end
    end
end)

MainTab:AddToggle("⛓️ Auto Farm Cash", function(state)
    Settings.MasterLoop = state
    if Settings.MasterLoop then
        task.spawn(function()
            while Settings.MasterLoop do
                pcall(function()
                    local char = lp.Character
                    local tool = char:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                    
                    if tool and char:FindFirstChild("HumanoidRootPart") then
                        if tool.Parent ~= char then tool.Parent = char end
                        
                        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                            if not Settings.MasterLoop then break end
                            if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHRP = player.Character.HumanoidRootPart
                                local targetHum = player.Character:FindFirstChild("Humanoid")
                                
                                if targetHum and targetHum.Health > 0 then
                                    char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                                    char.HumanoidRootPart.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 0.2)
                                    
                                    for _, r in pairs(tool:GetDescendants()) do
                                        if r:IsA("RemoteEvent") then r:FireServer(targetHum) end
                                    end
                                    
                                    task.wait(2.5)
                                    
                                    local radius = 8
                                    for i = 1, 10 do
                                        if not Settings.MasterLoop then break end
                                        local angle = i * (math.pi * 2 / 10)
                                        char.HumanoidRootPart.CFrame = targetHRP.CFrame * CFrame.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                                        task.wait(0.03)
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    end
end)

-- ==== Player Settings ====
local PlayerTab = CreateTab("Player Settings")

PlayerTab:AddToggle("🧱 Noclip", function(state)
    Settings.Noclip = state
end)

PlayerTab:AddToggle("🦘 Infinite Jump", function(state)
    Settings.InfJump = state
end)

PlayerTab:AddSlider("⚡ WalkSpeed", 16, 500, 16, function(value)
    Settings.WalkSpeed = value
end)

-- ==== Visuals ====
local VisualTab = CreateTab("Visuals / ESP")

VisualTab:AddToggle("👁️ Enable ESP (Chams + Name)", function(state)
    Settings.ESP = state
end)

-- ==== Credits ====
local CreditTab = CreateTab("Credits")
CreditTab:AddButton("ART HUB - Loaded successfully!", function()
    print("Script initialized successfully!")
end)
