-- ================= ART HUB V25 (THAI LANGUAGE) =================
local p = game.Players.LocalPlayer
local ts = game:GetService("TweenService")
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local m = Instance.new("Frame", sg)
m.Size, m.Position = UDim2.new(0, 300, 0, 180), UDim2.new(0.5, -150, 0.2, 0)
m.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
m.BackgroundTransparency = 0.2
m.Draggable, m.Active = true, true
Instance.new("UICorner", m).CornerRadius = UDim.new(0, 15)
local st = Instance.new("UIStroke", m)
st.Color, st.Thickness = Color3.fromRGB(255, 0, 0), 2

-- ================= IMAGE & LOGO =================
local img = Instance.new("ImageLabel", m)
img.Size, img.Position = UDim2.new(0, 70, 0, 70), UDim2.new(0.5, -35, 0, 10)
img.BackgroundTransparency = 1
img.Image = "rbxthumb://type=Asset&id=104345605656815&w=420&h=420" 
Instance.new("UICorner", img).CornerRadius = UDim.new(1, 0)

-- ================= TEXT LABELS (THAI) =================
local bt = Instance.new("TextLabel", m)
bt.Size, bt.Position = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 85)
bt.TextColor3, bt.Font, bt.TextScaled = Color3.new(1, 0.8, 0), Enum.Font.GothamBold, true
bt.Text, bt.BackgroundTransparency = "เงิน: 0", 1

local SuccessText = Instance.new("TextLabel", m)
SuccessText.Size = UDim2.new(1, 0, 0, 25)
SuccessText.Position = UDim2.new(0, 0, 0, 110)
SuccessText.BackgroundTransparency = 1
SuccessText.TextColor3 = Color3.fromRGB(0, 255, 100)
SuccessText.TextSize = 18
SuccessText.Text = "" 
SuccessText.Font = Enum.Font.GothamBold

local st_label = Instance.new("TextLabel", m)
st_label.Size, st_label.Position = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 140)
st_label.TextColor3, st_label.Font, st_label.TextSize = Color3.new(0.7, 0.7, 0.7), Enum.Font.Gotham, 14
st_label.Text, st_label.BackgroundTransparency = "สถานะ: กำลังค้นหาหีบสมบัติใหม่", 1

-- ================= FUNCTIONS =================
function lockHeight()
    local char = p.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        if not root:FindFirstChild("AntiFall") then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "AntiFall"
            bv.Parent = root
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

function tweenTo(targetCFrame)
    local char = p.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        lockHeight() 
        local dist = (targetCFrame.Position - char.HumanoidRootPart.Position).Magnitude
        local info = TweenInfo.new(dist / 100, Enum.EasingStyle.Linear)
        local tween = ts:Create(char.HumanoidRootPart, info, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- ================= LOOPS =================
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local stats = p:FindFirstChild("Data") or p:FindFirstChild("leaderstats")
            local b = stats and (stats:FindFirstChild("Beli") or stats:FindFirstChild("Money"))
            if b then bt.Text = "เงิน: "..tostring(b.Value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "") end
        end)
    end
end)

task.spawn(function()
    while task.wait(1) do
        local chests = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name:find("Chest") and v:IsA("BasePart") and v.Parent then
                table.insert(chests, v)
            end
        end

        for i, v in pairs(chests) do
            if v.Parent and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                st_label.Text = "สถานะ: กำลังเคลื่อนที่ไปที่หีบ #" .. i
                local tw = tweenTo(v.CFrame * CFrame.new(0, 3, 0))
                if tw then
                    tw.Completed:Wait()
                    SuccessText.Text = "เปิดกล่องสำเร็จ!"
                    task.wait(0.5)
                    SuccessText.Text = "" 
                end
            end
        end
        st_label.Text = "สถานะ: กำลังค้นหาหีบสมบัติใหม่"
    end
end)
