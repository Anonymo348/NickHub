
-- NickHub UI completo by Nick
-- Toggle invisibility: I
-- Toggle fly: F
-- Toggle ESP: E
-- AntiLag attivo all'avvio

-- ESP Function
local function createESP()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("ESP") then
            local box = Instance.new("BillboardGui", v.Character)
            box.Name = "ESP"
            box.AlwaysOnTop = true
            box.Size = UDim2.new(0, 100, 0, 40)
            box.StudsOffset = Vector3.new(0, 3, 0)
            local txt = Instance.new("TextLabel", box)
            txt.Text = v.Name
            txt.BackgroundTransparency = 1
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.TextColor3 = Color3.new(1, 0, 0)
        end
    end
end

local function removeESP()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("ESP") then
            v.Character:FindFirstChild("ESP"):Destroy()
        end
    end
end

-- Toggle Fly
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local HRP = char:WaitForChild("HumanoidRootPart")
local flying = false
local flySpeed = 50
local flyConn

function startFly()
    flying = true
    local humanoid = char:FindFirstChildWhichIsA("Humanoid")
    humanoid.PlatformStand = true
    flyConn = RS.Heartbeat:Connect(function()
        local cam = workspace.CurrentCamera
        local direction = Vector3.new()
        if UIS:IsKeyDown(Enum.KeyCode.W) then direction += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then direction -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then direction -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then direction += cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then direction -= Vector3.new(0,1,0) end
        HRP.Velocity = direction.Unit * flySpeed
    end)
end

function stopFly()
    flying = false
    local humanoid = char:FindFirstChildWhichIsA("Humanoid")
    humanoid.PlatformStand = false
    HRP.Velocity = Vector3.new(0,0,0)
    if flyConn then flyConn:Disconnect() end
end

-- Toggle Invisible
local invisible = false
function toggleInvisible()
    local char = player.Character
    if not invisible then
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.Transparency = 1
            elseif p:IsA("Decal") then
                p.Transparency = 1
            end
        end
        invisible = true
    else
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.Transparency = 0
            elseif p:IsA("Decal") then
                p.Transparency = 0
            end
        end
        invisible = false
    end
end

-- Antilag
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("Texture") or v:IsA("Decal") then
        v:Destroy()
    end
end

-- Keybinds
local espEnabled = false
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        if flying then stopFly() else startFly() end
    elseif input.KeyCode == Enum.KeyCode.I then
        toggleInvisible()
    elseif input.KeyCode == Enum.KeyCode.E then
        if espEnabled then removeESP() else createESP() end
        espEnabled = not espEnabled
    end
end)

-- Notifica
game.StarterGui:SetCore("SendNotification", {
    Title = "NickHub",
    Text = "Loaded successfully!",
    Duration = 5
})
