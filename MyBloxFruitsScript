-- ================= ART HUB V25 x FIATX2 (CLEAN EDITION) =================
local p = game.Players.LocalPlayer
local ts = game:GetService("TweenService")
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- [[ SETTINGS ]]
_G.AutoFarm = false
local selected_Tool = "Melee"
local TweenSpeed = 300
local HeadOffset = Vector3.new(0, 30, 0)
local NM = nil -- Next Mob Name

-- [[ UI DESIGN ]]
local m = Instance.new("Frame", sg)
m.Size, m.Position = UDim2.new(0, 300, 0, 240), UDim2.new(0.5, -150, 0.2, 0)
m.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
m.BackgroundTransparency = 0.2
m.Draggable, m.Active = true, true
Instance.new("UICorner", m).CornerRadius = UDim.new(0, 15)
local st = Instance.new("UIStroke", m)
st.Color, st.Thickness = Color3.fromRGB(255, 0, 0), 2

local img = Instance.new("ImageLabel", m)
img.Size, img.Position = UDim2.new(0, 60, 0, 60), UDim2.new(0.5, -30, 0, 10)
img.BackgroundTransparency = 1
img.Image = "rbxthumb://type=Asset&id=104345605656815&w=420&h=420" 
Instance.new("UICorner", img).CornerRadius = UDim.new(1, 0)

-- WEAPON BUTTON
local w_btn = Instance.new("TextButton", m)
w_btn.Size, w_btn.Position = UDim2.new(0.8, 0, 0, 30), UDim2.new(0.1, 0, 0, 75)
w_btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
w_btn.TextColor3, w_btn.Font, w_btn.TextSize = Color3.new(1, 1, 1), Enum.Font.GothamBold, 14
w_btn.Text = "WEAPON: " .. selected_Tool
Instance.new("UICorner", w_btn)

w_btn.MouseButton1Click:Connect(function()
    local tools = {"Melee", "Sword", "Blox Fruit", "Gun"}
    local currentIndex = table.find(tools, selected_Tool) or 1
    selected_Tool = tools[(currentIndex % #tools) + 1]
    w_btn.Text = "WEAPON: " .. selected_Tool
end)

-- FARM TOGGLE BUTTON
local f_btn = Instance.new("TextButton", m)
f_btn.Size, f_btn.Position = UDim2.new(0.8, 0, 0, 30), UDim2.new(0.1, 0, 0, 110)
f_btn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
f_btn.TextColor3, f_btn.Font, f_btn.TextSize = Color3.new(1, 1, 1), Enum.Font.GothamBold, 14
f_btn.Text = "AUTO FARM: OFF"
Instance.new("UICorner", f_btn)

f_btn.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    f_btn.Text = "AUTO FARM: " .. (_G.AutoFarm and "ON" or "OFF")
    f_btn.BackgroundColor3 = _G.AutoFarm and Color3.fromRGB(0, 60, 0) or Color3.fromRGB(40, 0, 0)
    if not _G.AutoFarm then 
        NM = nil 
        -- ลบตัวล็อคบินเมื่อปิดฟาร์ม
        pcall(function()
            p.Character.HumanoidRootPart:FindFirstChild("FlyVel"):Destroy()
            p.Character.HumanoidRootPart:FindFirstChild("FlyGyro"):Destroy()
        end)
    end
end)

local st_label = Instance.new("TextLabel", m)
st_label.Size, st_label.Position = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 150)
st_label.TextColor3, st_label.Font, st_label.TextSize = Color3.new(0.7, 0.7, 0.7), Enum.Font.Gotham, 14
st_label.Text, st_label.BackgroundTransparency = "STATUS: IDLE", 1

-- [[ QUEST & FARMING CORE ]]
local QuestData = require(rs:WaitForChild("Quests"))
local GuideModule = require(rs:WaitForChild("GuideModule"))

local function Action(args)
    return rs.Remotes.CommF_:InvokeServer(table.unpack(args))
end

local function HasQuest()
    return p.PlayerGui.Main.Quest.Visible
end

local function GetQuest()
    local best, lv, key, category = nil, -1, nil, nil
    for cat, quests in pairs(QuestData) do
        for qKey, info in pairs(quests) do
            if info.LevelReq and p.Data.Level.Value >= info.LevelReq then
                local mobName, count = next(info.Task or {})
                if not count or count < 2 then continue end
                if info.LevelReq > lv then
                    lv = info.LevelReq
                    best = info
                    key = qKey
                    category = cat
                end
            end
        end
    end
    if not best then return end
    local npc = GuideModule.GetNearestNPC(GuideModule, p.Character.HumanoidRootPart.Position, p.Data.Level.Value)
    return { Mob = next(best.Task), Key = key, Category = category, NPC = npc and npc[1] }
end

local function TweenTo(cf)
    if not _G.AutoFarm then return end
    local root = p.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local dist = (root.Position - cf.Position).Magnitude
        local tw = ts:Create(root, TweenInfo.new(dist / TweenSpeed, Enum.EasingStyle.Linear), {CFrame = cf})
        tw:Play()
        tw.Completed:Wait()
    end
end

local function equip_weapon()
    local char = p.Character
    if not char then return end
    for _, tool in ipairs(p.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == selected_Tool then
            char.Humanoid:EquipTool(tool)
        end
    end
end

-- [[ FAST ATTACK ]]
local regHit = debug.getupvalue(getrenv()._G.SendHitsToServer, 1)
local regAtk = rs.Modules.Net["RE/RegisterAttack"]

task.spawn(function()
    while task.wait() do
        if not _G.AutoFarm then continue end
        local hit = {}
        for _, mob in pairs(game:GetService("CollectionService"):GetTagged("BasicMob")) do
            if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 and (mob.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 100 then
                table.insert(hit, { mob, mob.HumanoidRootPart })
            end
        end
        if #hit > 0 then
            regAtk:FireServer(0/0)
            pcall(function() coroutine.resume(regHit, hit[1][2], { table.unpack(hit, 2) }) end)
        end
    end
end)

-- [[ MAIN LOOP ]]
task.spawn(function()
    while task.wait() do -- ปรับให้ไวขึ้นเพื่อล็อคตำแหน่ง
        if not _G.AutoFarm then continue end
        pcall(function()
            local char = p.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            -- ล็อคตัวละครกลางอากาศ (ป้องกันการตก)
            if not root:FindFirstChild("FlyVel") then
                local bv = Instance.new("BodyVelocity", root)
                bv.Name = "FlyVel"
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Velocity = Vector3.new(0, 0, 0)
                local bg = Instance.new("BodyGyro", root)
                bg.Name = "FlyGyro"
                bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.P = 10000
            end

            local quest = GetQuest()
            if not quest then return end
            NM = quest.Mob

            if not HasQuest() then
                st_label.Text = "STATUS: GETTING QUEST..."
                TweenTo(CFrame.new(quest.NPC))
                task.wait(0.3)
                Action({ "StartQuest", quest.Category, quest.Key })
            else
                local target = nil
                for _, mob in pairs(ws.Enemies:GetChildren()) do
                    if mob.Name == NM and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        target = mob; break
                    end
                end

                if target then
                    st_label.Text = "STATUS: ATTACKING " .. NM:upper()
                    equip_weapon()
                    root.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                else
                    st_label.Text = "STATUS: WAITING SPAWN"
                    local world = ws:FindFirstChild("_WorldOrigin")
                    local spawns = world and world:FindFirstChild("EnemySpawns")
                    if spawns then
                        for _, s in pairs(spawns:GetChildren()) do
                            if s.Name:find(NM) then TweenTo(s.CFrame * CFrame.new(0, 20, 0)); break end
                        end
                    end
                end
            end
        end)
    end
end)

-- [[ HAKI AUTO ]]
task.spawn(function()
    while task.wait(1) do
        if _G.AutoFarm then
            pcall(function()
                if not p.Character:FindFirstChild("HasBuso") then
                    Action({"Buso"})
                end
            end)
        end
    end
end)
