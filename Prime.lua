-- PRIME Hold v5.1 — Custom Background, ON/OFF Toggle, Distance & Time in Settings

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local enabled = false
local guiLocked = false
local settingsOpen = false
local HOLD_DIST = 7        -- default distance = 7
local SPEED = 24
local STICK_TIME = 1.5     -- default time

player.CharacterAdded:Connect(function(c)
    character = c
    humanoid  = c:WaitForChild("Humanoid")
    rootPart  = c:WaitForChild("HumanoidRootPart")
    if enabled then humanoid.WalkSpeed = SPEED end
end)

-- ===== GUI =====
local sg = Instance.new("ScreenGui")
sg.Name = "PRIMEHoldGui"
sg.ResetOnSpawn = false
sg.Parent = player.PlayerGui

-- ---- Main frame ----
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 240, 0, 110)
frame.Position = UDim2.new(0.5, -120, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
local fs = Instance.new("UIStroke", frame)
fs.Color = Color3.fromRGB(220, 0, 0)
fs.Thickness = 1.5

-- Background image for Main Frame (Using the uploaded portrait image ID)
local bg = Instance.new("ImageLabel", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundTransparency = 1
bg.ImageTransparency = 0.4
bg.ScaleType = Enum.ScaleType.Crop
bg.Image = "rbxassetid://108781512411906" -- تم ربط الصورة التي أرسلتها كخلفية
Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 12)

-- ---- Top bar ----
local top = Instance.new("Frame", frame)
top.Size = UDim2.new(1, 0, 0, 34)
top.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
top.BackgroundTransparency = 0.3
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)
local tf = Instance.new("Frame", top)
tf.Size = UDim2.new(1, 0, 0.5, 0)
tf.Position = UDim2.new(0, 0, 0.5, 0)
tf.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
tf.BackgroundTransparency = 0.3
tf.BorderSizePixel = 0

local lbl = Instance.new("TextLabel", top)
lbl.Size = UDim2.new(1, -90, 1, 0)
lbl.Position = UDim2.new(0, 10, 0, 0)
lbl.BackgroundTransparency = 1
lbl.TextColor3 = Color3.fromRGB(255, 100, 100)
lbl.Text = "⬥ PRIME HOLD"
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 13
lbl.TextXAlignment = Enum.TextXAlignment.Left

local settBtn = Instance.new("TextButton", top)
settBtn.Size = UDim2.new(0, 28, 0, 22)
settBtn.Position = UDim2.new(1, -62, 0.5, -11)
settBtn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
settBtn.TextColor3 = Color3.new(1, 1, 1)
settBtn.Text = "⚙"
settBtn.Font = Enum.Font.Gotham
settBtn.TextSize = 14
Instance.new("UICorner", settBtn).CornerRadius = UDim.new(0, 6)

local lockBtn = Instance.new("TextButton", top)
lockBtn.Size = UDim2.new(0, 28, 0, 22)
lockBtn.Position = UDim2.new(1, -32, 0.5, -11)
lockBtn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
lockBtn.TextColor3 = Color3.new(1, 1, 1)
lockBtn.Text = "🔓"
lockBtn.Font = Enum.Font.Gotham
lockBtn.TextSize = 12
Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0, 6)

-- ---- ON/OFF button ----
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.86, 0, 0, 52)
btn.Position = UDim2.new(0.07, 0, 0, 44)
btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Text = "OFF"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 20
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
local btnStroke = Instance.new("UIStroke", btn)
btnStroke.Color = Color3.fromRGB(255, 80, 80)
btnStroke.Thickness = 1.5

-- ===== Settings panel (Contains Distance & Time) =====
local settFrame = Instance.new("Frame", sg)
settFrame.Size = UDim2.new(0, 240, 0, 110)
settFrame.Position = UDim2.new(0.5, -120, 0.1, 120)
settFrame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
settFrame.BackgroundTransparency = 0.2
settFrame.BorderSizePixel = 0
settFrame.Visible = false
Instance.new("UICorner", settFrame).CornerRadius = UDim.new(0, 10)
local sf2 = Instance.new("UIStroke", settFrame)
sf2.Color = Color3.fromRGB(200, 0, 0)
sf2.Thickness = 1.5

-- Background image for Settings Frame
local settBg = Instance.new("ImageLabel", settFrame)
settBg.Size = UDim2.new(1, 0, 1, 0)
settBg.Position = UDim2.new(0, 0, 0, 0)
settBg.BackgroundTransparency = 1
settBg.ImageTransparency = 0.4
settBg.ScaleType = Enum.ScaleType.Crop
settBg.Image = "rbxassetid://108781512411906"
Instance.new("UICorner", settBg).CornerRadius = UDim.new(0, 10)

local settTitle = Instance.new("TextLabel", settFrame)
settTitle.Size = UDim2.new(1, 0, 0, 26)
settTitle.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
settTitle.BackgroundTransparency = 0.3
settTitle.BorderSizePixel = 0
settTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
settTitle.Text = "  إعدادات المسافة والوقت"
settTitle.Font = Enum.Font.GothamBold
settTitle.TextSize = 12
settTitle.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", settTitle).CornerRadius = UDim.new(0, 10)

-- ---- Distance row inside Settings ----
local distRow = Instance.new("Frame", settFrame)
distRow.Size = UDim2.new(0.86, 0, 0, 32)
distRow.Position = UDim2.new(0.07, 0, 0, 34)
distRow.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
distRow.BackgroundTransparency = 0.4
distRow.BorderSizePixel = 0
Instance.new("UICorner", distRow).CornerRadius = UDim.new(0, 8)

local distLbl = Instance.new("TextLabel", distRow)
distLbl.Size = UDim2.new(0, 80, 1, 0)
distLbl.Position = UDim2.new(0, 8, 0, 0)
distLbl.BackgroundTransparency = 1
distLbl.TextColor3 = Color3.fromRGB(255, 180, 180)
distLbl.Text = "المسافة:"
distLbl.Font = Enum.Font.Gotham
distLbl.TextSize = 12
distLbl.TextXAlignment = Enum.TextXAlignment.Left

local distVal = Instance.new("TextLabel", distRow)
distVal.Size = UDim2.new(0, 28, 1, 0)
distVal.Position = UDim2.new(0.5, -14, 0, 0)
distVal.BackgroundTransparency = 1
distVal.TextColor3 = Color3.fromRGB(255, 100, 100)
distVal.Text = tostring(HOLD_DIST)
distVal.Font = Enum.Font.GothamBold
distVal.TextSize = 14

local distLeft = Instance.new("TextButton", distRow)
distLeft.Size = UDim2.new(0, 26, 0.8, 0)
distLeft.Position = UDim2.new(0.5, -42, 0.1, 0)
distLeft.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
distLeft.TextColor3 = Color3.new(1, 1, 1)
distLeft.Text = "◀"
distLeft.Font = Enum.Font.GothamBold
distLeft.TextSize = 12
Instance.new("UICorner", distLeft).CornerRadius = UDim.new(0, 5)

local distRight = Instance.new("TextButton", distRow)
distRight.Size = UDim2.new(0, 26, 0.8, 0)
distRight.Position = UDim2.new(0.5, 16, 0.1, 0)
distRight.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
distRight.TextColor3 = Color3.new(1, 1, 1)
distRight.Text = "▶"
distRight.Font = Enum.Font.GothamBold
distRight.TextSize = 12
Instance.new("UICorner", distRight).CornerRadius = UDim.new(0, 5)

-- ---- Time row inside Settings ----
local timeRow = Instance.new("Frame", settFrame)
timeRow.Size = UDim2.new(0.86, 0, 0, 32)
timeRow.Position = UDim2.new(0.07, 0, 0, 72)
timeRow.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
timeRow.BackgroundTransparency = 0.4
timeRow.BorderSizePixel = 0
Instance.new("UICorner", timeRow).CornerRadius = UDim.new(0, 8)

local timeLbl = Instance.new("TextLabel", timeRow)
timeLbl.Size = UDim2.new(0, 80, 1, 0)
timeLbl.Position = UDim2.new(0, 8, 0, 0)
timeLbl.BackgroundTransparency = 1
timeLbl.TextColor3 = Color3.fromRGB(255, 180, 180)
timeLbl.Text = "الوقت:"
timeLbl.Font = Enum.Font.Gotham
timeLbl.TextSize = 12
timeLbl.TextXAlignment = Enum.TextXAlignment.Left

local timeVal = Instance.new("TextLabel", timeRow)
timeVal.Size = UDim2.new(0, 36, 1, 0)
timeVal.Position = UDim2.new(0.5, -18, 0, 0)
timeVal.BackgroundTransparency = 1
timeVal.TextColor3 = Color3.fromRGB(255, 100, 100)
timeVal.Text = string.format("%.1f", STICK_TIME)
timeVal.Font = Enum.Font.GothamBold
timeVal.TextSize = 14

local timeLeft = Instance.new("TextButton", timeRow)
timeLeft.Size = UDim2.new(0, 26, 0.8, 0)
timeLeft.Position = UDim2.new(0.5, -46, 0.1, 0)
timeLeft.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
timeLeft.TextColor3 = Color3.new(1, 1, 1)
timeLeft.Text = "◀"
timeLeft.Font = Enum.Font.GothamBold
timeLeft.TextSize = 12
Instance.new("UICorner", timeLeft).CornerRadius = UDim.new(0, 5)

local timeRight = Instance.new("TextButton", timeRow)
timeRight.Size = UDim2.new(0, 26, 0.8, 0)
timeRight.Position = UDim2.new(0.5, 20, 0.1, 0)
timeRight.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
timeRight.TextColor3 = Color3.new(1, 1, 1)
timeRight.Text = "▶"
timeRight.Font = Enum.Font.GothamBold
timeRight.TextSize = 12
Instance.new("UICorner", timeRight).CornerRadius = UDim.new(0, 5)

-- ===== LOGIC =====
lockBtn.MouseButton1Click:Connect(function()
    guiLocked = not guiLocked
    frame.Draggable = not guiLocked
    lockBtn.Text = guiLocked and "🔒" or "🔓"
    lockBtn.BackgroundColor3 = guiLocked and Color3.fromRGB(160,0,0) or Color3.fromRGB(90,0,0)
end)

settBtn.MouseButton1Click:Connect(function()
    settingsOpen = not settingsOpen
    settFrame.Visible = settingsOpen
    settBtn.BackgroundColor3 = settingsOpen and Color3.fromRGB(160,0,0) or Color3.fromRGB(90,0,0)
end)

-- Distance arrows
distLeft.MouseButton1Click:Connect(function()
    HOLD_DIST = math.max(1, HOLD_DIST - 1)
    distVal.Text = tostring(HOLD_DIST)
end)
distRight.MouseButton1Click:Connect(function()
    HOLD_DIST = math.min(15, HOLD_DIST + 1)
    distVal.Text = tostring(HOLD_DIST)
end)

-- Time arrows
timeLeft.MouseButton1Click:Connect(function()
    STICK_TIME = math.max(1.0, math.floor((STICK_TIME - 0.1) * 10 + 0.5) / 10)
    timeVal.Text = string.format("%.1f", STICK_TIME)
end)
timeRight.MouseButton1Click:Connect(function()
    STICK_TIME = math.min(9.9, math.floor((STICK_TIME + 0.1) * 10 + 0.5) / 10)
    timeVal.Text = string.format("%.1f", STICK_TIME)
end)

-- ON/OFF Button Logic
local function setEnabled(v)
    enabled = v
    if v then
        btn.Text = "ON"
        btn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
        btnStroke.Color = Color3.fromRGB(80, 255, 80)
        humanoid.WalkSpeed = SPEED
    else
        btn.Text = "OFF"
        btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        btnStroke.Color = Color3.fromRGB(255, 80, 80)
        humanoid.WalkSpeed = 16
        humanoid:MoveTo(rootPart.Position)
    end
end

btn.MouseButton1Click:Connect(function() setEnabled(not enabled) end)

-- ===== HELPERS =====
local function hasBomb()
    if not character then return false end
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            local name = tool.Name:lower()
            if name:find("bomb") or name:find("time") then return true end
        end
    end
    for _, tool in pairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local name = tool.Name:lower()
            if name:find("bomb") or name:find("time") then return true end
        end
    end
    return false
end

local function getBombTime()
    for _, p in pairs(Players:GetPlayers()) do
        if not p.Character then continue end
        for _, obj in pairs(p.Character:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextBox") then
                local num = tonumber(obj.Text:match("(%d+%.?%d*)"))
                if num and num <= 60 then return num end
            end
        end
    end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextBox") then
            local num = tonumber(obj.Text:match("(%d+%.?%d*)"))
            if num and num <= 60 then return num end
        end
    end
    return nil
end

local function getNearestEnemy()
    local nearRoot, nearDist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p == player or not p.Character then continue end
        local r = p.Character:FindFirstChild("HumanoidRootPart")
        local h = p.Character:FindFirstChild("Humanoid")
        if not r or not h or h.Health <= 0 then continue end
        if player.Team and p.Team and p.Team == player.Team then continue end
        local d = (rootPart.Position - r.Position).Magnitude
        if d < nearDist then nearDist = d; nearRoot = r end
    end
    return nearRoot
end

local sideOffset = 1
local lastSideSwitch = 0

-- ===== LOOP =====
RunService.Heartbeat:Connect(function()
    if not enabled then return end
    if not hasBomb() then humanoid:MoveTo(rootPart.Position); return end

    local nearRoot = getNearestEnemy()
    if not nearRoot then return end

    local bombTime = getBombTime()
    local shouldStick = bombTime and bombTime <= STICK_TIME

    local toEnemy = Vector3.new(
        nearRoot.Position.X - rootPart.Position.X, 0,
        nearRoot.Position.Z - rootPart.Position.Z
    )
    local dist = toEnemy.Magnitude

    if shouldStick then
        humanoid.WalkSpeed = 18
        local toEnemyUnit = dist > 0.01 and toEnemy.Unit or Vector3.new(1,0,0)
        local angle = math.rad(-40)
        local facingDir = Vector3.new(
            toEnemyUnit.X * math.cos(angle) - toEnemyUnit.Z * math.sin(angle), 0,
            toEnemyUnit.X * math.sin(angle) + toEnemyUnit.Z * math.cos(angle)
        )
        rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + facingDir)
        humanoid:MoveTo(nearRoot.Position)
    else
        humanoid.WalkSpeed = 16
        if dist > HOLD_DIST + 0.5 then
            humanoid:MoveTo(nearRoot.Position)
        elseif dist < HOLD_DIST - 0.5 then
            humanoid:MoveTo(rootPart.Position + (-toEnemy.Unit) * 5)
        else
            humanoid:MoveTo(rootPart.Position + Vector3.new(0.1, 0, 0))
        end
        if toEnemy.Magnitude > 0.1 then
            local away = rootPart.Position - toEnemy.Unit * 5
            rootPart.CFrame = CFrame.new(rootPart.Position, Vector3.new(away.X, rootPart.Position.Y, away.Z))
        end
    end
end)
