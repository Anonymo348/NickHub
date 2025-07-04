-- do not skid bro --
--[[

Nick Hub UI con Fly stile Infinite Yield

- Barra superiore con titolo, minimizza (icona) e chiudi (X)
- Finestre spostabili
- Tabs: Credits, Universal, Universal V2, Cheating 3
- Funzioni reali: invisibile, fly, ESP, antilag, speed boost, jump boost
- Fly implementato come Infinite Yield (toggle bottone e tasto F)

]]

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NickHub"
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 400)
frame.Position = UDim2.new(0.5, -300, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Barra superiore
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
topBar.BorderSizePixel = 0
topBar.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Nick Hub"
titleLabel.Size = UDim2.new(0, 200, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Bottone X per chiudere
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 1, 0)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = topBar

-- Icona minimizza (nasconde la UI e crea bottone per riaprire)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 40, 1, 0)
minimizeBtn.Position = UDim2.new(1, -80, 0, 0)
minimizeBtn.Text = "_"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 24
minimizeBtn.Parent = topBar

-- Bottone per riaprire la UI (inizialmente invisibile)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 100, 0, 30)
openBtn.Position = UDim2.new(0, 10, 0, 10)
openBtn.Text = "Nick Hub"
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 20
openBtn.Visible = false
openBtn.Parent = screenGui

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

minimizeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	openBtn.Visible = false
end)

-- Funzione per spostare la finestra
local dragging = false
local dragInput, dragStart, startPos

topBar.InputBegan:Connect(function(input)
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

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Tabs
local tabs = {"Credits", "Universal", "Universal V2", "Cheating 3"}
local pages = {}

local tabButtonsFrame = Instance.new("Frame")
tabButtonsFrame.Size = UDim2.new(0, 120, 1, -30)
tabButtonsFrame.Position = UDim2.new(0, 0, 0, 30)
tabButtonsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tabButtonsFrame.Parent = frame

for i, tabName in ipairs(tabs) do
	local btn = Instance.new("TextButton")
	btn.Text = tabName
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, 5 + (i-1)*45)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Parent = tabButtonsFrame

	local page = Instance.new("Frame")
	page.Size = UDim2.new(1, -130, 1, -35)
	page.Position = UDim2.new(0, 120, 0, 35)
	page.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	page.Visible = false
	page.Parent = frame
	pages[tabName] = page

	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do p.Visible = false end
		page.Visible = true
	end)

	if i == 1 then
		page.Visible = true
	end
end

-- Crediti
do
	local p = pages["Credits"]
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -20, 1, -20)
	label.Position = UDim2.new(0, 10, 0, 10)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.Gotham
	label.TextSize = 18
	label.TextWrapped = true
	label.TextYAlignment = Enum.TextYAlignment.Top
	label.Text = "NickUI / NICKHUB\nMade by Nick"
	label.Parent = p
end

-- FUNZIONI CHEAT UTILI

local function setInvisible(state)
	local character = LocalPlayer.Character
	if not character then return end
	for _, part in pairs(character:GetChildren()) do
		if part:IsA("BasePart") or part:IsA("Decal") then
			part.Transparency = state and 1 or 0
		end
		if part:IsA("ParticleEmitter") or part:IsA("Trail") then
			part.Enabled = not state
		end
	end
end

local invisibleEnabled = false

-- ESP semplice: box verde sopra altri giocatori' heads
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "NickHubESP"
ESPFolder.Parent = screenGui

local function clearESP()
	for _, v in pairs(ESPFolder:GetChildren()) do
		v:Destroy()
	end
end

local espEnabled = false

local function toggleESP()
	espEnabled = not espEnabled
	if not espEnabled then
		clearESP()
		return
	end
	
	while espEnabled do
		clearESP()
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
				local head = player.Character.Head
				local billboard = Instance.new("BillboardGui")
				billboard.Name = "ESP"
				billboard.Adornee = head
				billboard.Size = UDim2.new(0, 100, 0, 40)
				billboard.AlwaysOnTop = true
				billboard.Parent = ESPFolder

				local box = Instance.new("Frame")
				box.Size = UDim2.new(1, 0, 1, 0)
				box.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
				box.BorderSizePixel = 1
				box.BorderColor3 = Color3.fromRGB(0, 100, 0)
				box.BackgroundTransparency = 0.7
				box.Parent = billboard
			end
		end
		wait(1)
	end
end

-- AntiLag semplice: disabilita luci e ombre
local antiLagEnabled = false

local function toggleAntiLag()
	antiLagEnabled = not antiLagEnabled
	if antiLagEnabled then
		for _, light in pairs(workspace:GetDescendants()) do
			if light:IsA("Light") then
				light.Enabled = false
			end
		end
		game.Lighting.GlobalShadows = false
	else
		for _, light in pairs(workspace:GetDescendants()) do
			if light:IsA("Light") then
				light.Enabled = true
			end
		end
		game.Lighting.GlobalShadows = true
	end
end

-- Speed boost e Jump boost
local normalSpeed = 16
local speedBoost = 30

local normalJump = 50
local jumpBoost = 100

local speedEnabled = false
local jumpEnabled = false

local function toggleSpeed()
	speedEnabled = not speedEnabled
	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if speedEnabled then
		humanoid.WalkSpeed = speedBoost
	else
		humanoid.WalkSpeed = normalSpeed
	end
end

local function toggleJump()
	jumpEnabled = not jumpEnabled
	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	if jumpEnabled then
		humanoid.JumpPower = jumpBoost
	else
		humanoid.JumpPower = normalJump
	end
end

-- Invisible toggle
local function toggleInvisible()
	invisibleEnabled = not invisibleEnabled
	setInvisible(invisibleEnabled)
end

-- === FLY INFINITE YIELD STYLE ===

local flying = false
local flySpeed = 50

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flyVelocity = Vector3.new()
local flyDirection = Vector3.new()

local flyConnection

local function startFly()
	if flying then return end
	flying = true
	humanoid.PlatformStand = true

	flyConnection = RunService.RenderStepped:Connect(function()
		if not flying then
			flyConnection:Disconnect()
			humanoid.PlatformStand = false
			return
		end

		local camCF = workspace.CurrentCamera.CFrame
		flyDirection = Vector3.new(0,0,0)

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			flyDirection = flyDirection + camCF.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			flyDirection = flyDirection - camCF.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			flyDirection = flyDirection - camCF.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			flyDirection = flyDirection + camCF.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			flyDirection = flyDirection + Vector3.new(0,1,0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			flyDirection = flyDirection - Vector3.new(0,1,0)
		end

		if flyDirection.Magnitude > 0 then
			flyDirection = flyDirection.Unit
			flyVelocity = flyDirection * flySpeed
		else
			flyVelocity = Vector3.new(0,0,0)
		end

		rootPart.Velocity = flyVelocity
	end)
end

local function stopFly()
	if not flying then return end
	flying = false
	humanoid.PlatformStand = false
	rootPart.Velocity = Vector3.new(0,0,0)
	if flyConnection then
		flyConnection:Disconnect()
	end
end

local function toggleFly()
	if flying then
		stopFly()
	else
		startFly()
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F then
		toggleFly()
	end
end)

-- UI ELEMENTS per le opzioni in Universal V2 tab (esempio)

local universalV2Page = pages["Universal V2"]

local function createToggle(name, position, callback)
	local toggleBtn = Instance.new("TextButton")
	toggleBtn.Size = UDim2.new(0, 150, 0, 35)
	toggleBtn.Position = position
	toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggleBtn.Font = Enum.Font.GothamBold
	toggleBtn.TextSize = 16
	toggleBtn.Text = name.." OFF"
	toggleBtn.Parent = universalV2Page

	local toggled = false

	toggleBtn.MouseButton1Click:Connect(function()
		toggled = not toggled
		toggleBtn.Text = name .. (toggled and " ON" or " OFF")
		callback(toggled)
	end)
end

-- Creiamo i toggle reali con callback

createToggle("Invisible", UDim2.new(0, 10, 0, 10), toggleInvisible)
createToggle("ESP", UDim2.new(0, 10, 0, 60), toggleESP)
createToggle("AntiLag", UDim2.new(0, 10, 0, 110), toggleAntiLag)
createToggle("Speed Boost", UDim2.new(0, 10, 0, 160), toggleSpeed)
createToggle("Jump Boost", UDim2.new(0, 10, 0, 210), toggleJump)

-- Fly toggle con bottone UI

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 150, 0, 35)
flyBtn.Position = UDim2.new(0, 10, 0, 260)
flyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 16
flyBtn.Text = "Fly OFF"
flyBtn.Parent = universalV2Page

local flyToggle = false

flyBtn.MouseButton1Click:Connect(function()
	flyToggle = not flyToggle
	flyBtn.Text = "Fly " .. (flyToggle and "ON" or "OFF")
	toggleFly()
end)

