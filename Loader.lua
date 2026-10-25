local GlobalEnv = (getgenv and getgenv()) or _G
if type(GlobalEnv.MosCuChillDe_Unload) == "function" then
	pcall(GlobalEnv.MosCuChillDe_Unload)
end
local Hub = { Unloaded = false, Conns = {} }
Hub.ThemeList = { "Dark", "Darker", "Light", "Aqua", "Amethyst", "Rose" }
function Hub.Track(conn)
	table.insert(Hub.Conns, conn)
	return conn
end
local fluentOk, Fluent = pcall(function()
	return loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end)
if not fluentOk or type(Fluent) ~= "table" then
	warn("[MosCuChillDe] Could not load the Fluent UI library: " .. tostring(Fluent))
	return
end
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local LogoAssetId = "88336270285979"
local ErrorLabel = nil
local AccentColor = Color3.fromRGB(0, 150, 255)
local function GetGuiParent()
	local guiParent
	pcall(function()
		if gethui then
			guiParent = gethui()
		end
	end)
	if not guiParent then
		pcall(function()
			guiParent = game:GetService("CoreGui")
		end)
	end
	if not guiParent then
		guiParent = LocalPlayer:WaitForChild("PlayerGui")
	end
	return guiParent
end
local LogoGui = Instance.new("ScreenGui")
LogoGui.Name = "MosCuChillDeLogoGui"
LogoGui.ResetOnSpawn = false
LogoGui.IgnoreGuiInset = true
LogoGui.DisplayOrder = 10000
LogoGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
	if syn and syn.protect_gui then
		syn.protect_gui(LogoGui)
	end
end)
pcall(function()
	LogoGui.Parent = GetGuiParent()
end)
if not LogoGui.Parent then
	LogoGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end
local LogoFrame = Instance.new("Frame")
LogoFrame.Name = "Logo"
LogoFrame.Size = UDim2.new(0, 52, 0, 52)
LogoFrame.Position = UDim2.new(0, 8, 0.5, -26)
LogoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LogoFrame.BorderSizePixel = 0
LogoFrame.Active = true
LogoFrame.Parent = LogoGui
Instance.new("UICorner", LogoFrame).CornerRadius = UDim.new(0.2, 0)
local LogoStroke = Instance.new("UIStroke", LogoFrame)
LogoStroke.Thickness = 1.8
LogoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local LogoGradient = Instance.new("UIGradient", LogoStroke)
function Hub.ApplyAccent(accentColor)
	pcall(function()
		local hue, sat = accentColor:ToHSV()
		local midColor = Color3.fromHSV(hue, math.max(sat - 0.45, 0), 1)
		LogoGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, accentColor),
			ColorSequenceKeypoint.new(0.5, midColor),
			ColorSequenceKeypoint.new(1, accentColor),
		})
	end)
end
Hub.ApplyAccent(AccentColor)
task.spawn(function()
	pcall(function()
		TweenService
			:Create(
				LogoGradient,
				TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
				{ Rotation = 180 }
			)
			:Play()
	end)
end)
local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "M"
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 30
LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoText.ZIndex = 1
LogoText.Parent = LogoFrame
local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.new(1, -6, 1, -6)
LogoImage.Position = UDim2.new(0, 3, 0, 3)
LogoImage.BackgroundTransparency = 1
LogoImage.ScaleType = Enum.ScaleType.Fit
LogoImage.ZIndex = 2
LogoImage.Parent = LogoFrame
Instance.new("UICorner", LogoImage).CornerRadius = UDim.new(0.2, 0)
task.spawn(function()
	local function waitForImageLoaded(timeout)
		local startClock = os.clock()
		while os.clock() - startClock < timeout do
			if LogoImage.IsLoaded then
				return true
			end
			task.wait(0.15)
		end
		return LogoImage.IsLoaded
	end
	local function hideFallbackText()
		LogoText.Visible = false
	end
	LogoImage.Image = "rbxthumb://type=Asset&id=" .. LogoAssetId .. "&w=150&h=150"
	if waitForImageLoaded(5) then
		return hideFallbackText()
	end
	local ok, assets = pcall(function()
		return game:GetObjects("rbxassetid://" .. LogoAssetId)
	end)
	if ok and type(assets) == "table" and assets[1] then
		local assetObj = assets[1]
		local resolvedImage
		if assetObj:IsA("Decal") or assetObj:IsA("Texture") then
			resolvedImage = assetObj.Texture
		elseif assetObj:IsA("ImageLabel") or assetObj:IsA("ImageButton") then
			resolvedImage = assetObj.Image
		end
		pcall(function()
			assetObj:Destroy()
		end)
		if type(resolvedImage) == "string" and resolvedImage ~= "" then
			LogoImage.Image = resolvedImage
			if waitForImageLoaded(5) then
				return hideFallbackText()
			end
		end
	end
	LogoImage.Image = "rbxassetid://" .. LogoAssetId
	if waitForImageLoaded(5) then
		return hideFallbackText()
	end
end)
local LogoButton = Instance.new("TextButton")
LogoButton.Size = UDim2.new(1, 0, 1, 0)
LogoButton.BackgroundTransparency = 1
LogoButton.Text = ""
LogoButton.ZIndex = 5
LogoButton.Parent = LogoFrame
do
	local isDragging, dragInputStart, frameStartPos = false, nil, nil
	Hub.Track(LogoButton.InputBegan:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			isDragging, dragInputStart, frameStartPos = true, input.Position, LogoFrame.AbsolutePosition
		end
	end))
	Hub.Track(UserInputService.InputChanged:Connect(function(input)
		if
			isDragging
			and (
				input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch
			)
		then
			local delta = input.Position - dragInputStart
			local cam = workspace.CurrentCamera
			local viewportSize = cam and cam.ViewportSize or Vector2.new(1280, 720)
			local frameSize = LogoFrame.AbsoluteSize
			local clampedX = math.clamp(frameStartPos.X + delta.X, 0, math.max(viewportSize.X - frameSize.X, 0))
			local clampedY = math.clamp(frameStartPos.Y + delta.Y, 0, math.max(viewportSize.Y - frameSize.Y, 0))
			LogoFrame.Position = UDim2.fromOffset(clampedX, clampedY)
		end
	end))
	Hub.Track(UserInputService.InputEnded:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			isDragging = false
		end
	end))
end
local Window
local MinimizeKey = Enum.KeyCode.LeftControl
local lastToggleTime = 0
local function toggleUI()
	local nowTick = tick()
	if nowTick - lastToggleTime < 0.3 then
		return
	end
	lastToggleTime = nowTick
	if Window then
		pcall(function()
			Window:Minimize()
		end)
	end
end
local dragStartPos = Vector2.new()
Hub.Track(LogoButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
	end
end))
Hub.Track(LogoButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local dragDist = (Vector2.new(input.Position.X, input.Position.Y) - dragStartPos).Magnitude
		if dragDist < 10 then
			toggleUI()
		end
	end
end))
local function ShowError(errMsg)
	warn("[MosCuChillDe] " .. tostring(errMsg))
	pcall(function()
		if not ErrorLabel then
			ErrorLabel = Instance.new("TextLabel")
			ErrorLabel.Name = "MosError"
			ErrorLabel.Size = UDim2.new(0, 360, 0, 120)
			ErrorLabel.Position = UDim2.new(0, 66, 0.5, -60)
			ErrorLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
			ErrorLabel.BackgroundTransparency = 0.1
			ErrorLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
			ErrorLabel.TextWrapped = true
			ErrorLabel.TextXAlignment = Enum.TextXAlignment.Left
			ErrorLabel.TextYAlignment = Enum.TextYAlignment.Top
			ErrorLabel.Font = Enum.Font.Code
			ErrorLabel.TextSize = 12
			ErrorLabel.Parent = LogoGui
			Instance.new("UICorner", ErrorLabel).CornerRadius = UDim.new(0, 8)
		end
		ErrorLabel.Text = "MosCuChillDe error:\n" .. tostring(errMsg)
	end)
end
local loadingStage = "starting"
local isLoaded = false
local function listenRemote(remoteName, callback)
	task.spawn(function()
		local remoteObj = ReplicatedStorage:WaitForChild("Events"):WaitForChild(remoteName, 15)
		if remoteObj and remoteObj:IsA("RemoteEvent") then
			remoteObj.OnClientEvent:Connect(callback)
		end
	end)
end
task.delay(20, function()
	if not isLoaded and not Hub.Unloaded then
		ShowError(
			"Still loading after 20s (stuck at: "
				.. loadingStage
				.. ").\nThe game may have changed - tell the dev this stage name."
		)
	end
end)
function Hub.Unload()
	if Hub.Unloaded then
		return
	end
	Hub.Unloaded = true
	pcall(function()
		if Hub.OnUnload then
			Hub.OnUnload()
		end
	end)
	for _, conn in ipairs(Hub.Conns) do
		pcall(function()
			conn:Disconnect()
		end)
	end
	table.clear(Hub.Conns)
	pcall(function()
		LogoGui:Destroy()
	end)
	pcall(function()
		Fluent:Destroy()
	end)
	if GlobalEnv.MosCuChillDe_Unload == Hub.Unload then
		GlobalEnv.MosCuChillDe_Unload = nil
	end
end
GlobalEnv.MosCuChillDe_Unload = Hub.Unload
local execOk, execErr = xpcall(function()
	local Events = ReplicatedStorage:WaitForChild("Events")
	local Info = ReplicatedStorage:WaitForChild("Info")
	local DataFolder = ReplicatedStorage:WaitForChild("Data")
	loadingStage = "waiting for player data"
	local PlayerData = DataFolder:WaitForChild(tostring(LocalPlayer.UserId))
	loadingStage = "player data ok"
	local ToggleHotbar = Events:WaitForChild("ToggleHotbar")
	local FishingEvent = Events:WaitForChild("Fishing")
	local UpdateFishProgression = Events:WaitForChild("UpdateFishProgression")
	local UseSkill = Events:WaitForChild("UseSkill")
	local SellFish = Events:WaitForChild("SellFish")
	local CraftBaitEvent = Events:WaitForChild("CraftBait")
	local CraftRodEvent = Events:WaitForChild("CraftRod")
	local RedeemCodeEvent = Events:WaitForChild("RedeemCode")
	local EquipBaitEvent = Events:WaitForChild("EquipBait", 5)
	local Config = {
		AutoCast = false,
		AutoCastMethod = "Instant",
		CastDelay = 1,
		AutoReel = false,
		AutoMiniGame = false,
		ReelDelay = 0.35,
		MiniGameDelay = 0.12,
		BossMode = "Normal",
		AutoBoss = false,
		AutoSecretBoss = false,
		AutoSkill = false,
		SkillOrder = { "Z", "X", "C", "V" },
		AutoSell = false,
		AutoSellMethod = "Delay",
		SellDelay = 1,
		SelectedBuyBait = "",
		BuyBaitAmount = 1,
		BuyBaitDelay = 1,
		AutoBuyBait = false,
		SelectedBait = "",
		BaitAmount = 1,
		AutoCraftBait = false,
		SelectedRod = "",
		AutoCraftRod = false,
		SelectedIsland = "",
		SelectedNPC = "",
		SelectedPlayer = "",
		ESPEnabled = false,
		AntiAFK = true,
		FullBright = false,
		NoFog = false,
		LoopSpeedEnabled = false,
		WalkSpeed = 30,
		NoclipEnabled = false,
		InfJumpEnabled = false,
		FlyEnabled = false,
		FlySpeed = 2,
		FlyKeybind = "F",
		FlyKeybindEnabled = true,
		NoclipKeybind = "J",
		NoclipKeybindEnabled = true,
		DisableAllKeybinds = false,
		SavedPos = false,
		AutoTPPos = false,
		AutoFarmIsland = false,
		SelectedFarmIsland = "Beginning Isle",
		AutoTicketQuest = false,
		TicketQuestMode = "Hard",
		AutoZengTianguoQuest = false,
		AutoEquipBestBait = false,
		AutoDaily = false,
		AutoSummon = false,
		SelectedBanner = "",
		SummonX10 = false,
		AutoBuyBestRod = false,
		AutoRedeem = false,
		FpsBoost = false,
		WalkOnWater = false,
		InstantInteract = false,
		HideNameAndID = false,
		HideNameText = "MosCuChillDe",
		AutoFilterZengQuest = false,
		AutoClaimDailyQuest = false,
		AutoGiveFish = false,
		AutoFavoriteBoss = false,
		AutoFavoriteBossTarget = {},
		FilterFishEnabled = false,
		FilterFishTarget = {},
		AutoHopWeather = false,
		SelectedWeather = "Thunderstorm",
		AutoHopSacredBeast = false,
		AutoExe = false,
		ThemeName = "Darker",
		AccentColor = { 0, 150, 255 },
	}
	local SaveFolder = "MosHub"
	local SaveFile = SaveFolder .. "/MosCuChillDe.json"
	local SaveFileLegacy = SaveFolder .. "/HeavyweighFishing.json"
	local function SaveConfig()
		pcall(function()
			if not isfolder(SaveFolder) then
				makefolder(SaveFolder)
			end
			writefile(SaveFile, HttpService:JSONEncode(Config))
		end)
	end
	local function LoadConfig()
		pcall(function()
			local configPath = nil
			if isfile(SaveFile) then
				configPath = SaveFile
			elseif isfile(SaveFileLegacy) then
				configPath = SaveFileLegacy
			end
			if configPath then
				local decodedConfig = HttpService:JSONDecode(readfile(configPath))
				for cfgKey, cfgVal in pairs(decodedConfig) do
					if Config[cfgKey] ~= nil then
						Config[cfgKey] = cfgVal
					end
				end
			end
		end)
	end
	LoadConfig()
	if type(Config.SkillOrder) ~= "table" then
		Config.SkillOrder = { "Z", "X", "C", "V" }
	else
		local validSkillKeys = { Z = true, X = true, C = true, V = true }
		local filteredSkills = {}
		for _, skillKey in ipairs(Config.SkillOrder) do
			if validSkillKeys[skillKey] and not table.find(filteredSkills, skillKey) then
				table.insert(filteredSkills, skillKey)
			end
		end
		Config.SkillOrder = filteredSkills
	end
	if Config.AutoSellMethod == "On Full" or Config.AutoSellMethod == "Sell When Full" then
		Config.AutoSellMethod = "Sell When Full Inventory"
	end
	for _, targetField in ipairs({ "FilterFishTarget", "AutoFavoriteBossTarget" }) do
		local fieldVal = Config[targetField]
		if type(fieldVal) == "string" then
			Config[targetField] = (fieldVal ~= "") and { fieldVal } or {}
		elseif type(fieldVal) ~= "table" then
			Config[targetField] = {}
		end
	end
	if type(Config.SelectedWeather) ~= "string" or Config.SelectedWeather == "" then
		Config.SelectedWeather = "Thunderstorm"
	end
	if type(Config.HideNameText) ~= "string" or string.match(Config.HideNameText, "^%s*(.-)%s*$") == "" then
		Config.HideNameText = "MosCuChillDe"
	end
	if not table.find(Hub.ThemeList, Config.ThemeName) then
		Config.ThemeName = "Darker"
	end
	if type(Config.AccentColor) ~= "table" or #Config.AccentColor < 3 then
		Config.AccentColor = { 0, 150, 255 }
	end
	pcall(function()
		AccentColor = Color3.fromRGB(
			math.clamp(tonumber(Config.AccentColor[1]) or 0, 0, 255),
			math.clamp(tonumber(Config.AccentColor[2]) or 150, 0, 255),
			math.clamp(tonumber(Config.AccentColor[3]) or 255, 0, 255)
		)
		Hub.ApplyAccent(AccentColor)
	end)
	local function GetSavedCFrame()
		if type(Config.SavedPos) == "table" and #Config.SavedPos >= 3 then
			local cfOk, savedCf = pcall(CFrame.new, unpack(Config.SavedPos))
			if cfOk and savedCf then
				return savedCf
			end
		end
		return nil
	end
	local IslandFarmPositions = {
		["Beginning Isle"] = CFrame.new(-297.48, 9.28, 58.78, 0.00, 0.00, 1.00, -0.00, 1.00, -0.00, -1.00, -0.00, 0.00),
		["Bamboo Isle"] = CFrame.new(-1310.04, 9.28, 29.79, -0.28, -0.00, 0.96, -0.00, 1.00, 0.00, -0.96, -0.00, -0.28),
		["Fallout Isle"] = CFrame.new(76.47, 9.28, 1265.92, -1.00, 0.00, 0.01, 0.00, 1.00, -0.00, -0.01, -0.00, -1.00),
		["Sovereign Isle"] = CFrame.new(
			-1254.18,
			9.28,
			1301.79,
			-1.00,
			0.00,
			-0.07,
			0.00,
			1.00,
			-0.00,
			0.07,
			-0.00,
			-1.00
		),
		["Perch Isle"] = CFrame.new(-38.55, 9.28, -1343.82, 0.99, -0.00, -0.12, 0.00, 1.00, 0.00, 0.12, -0.00, 0.99),
		["Frost Isle"] = CFrame.new(
			-1348.71,
			9.28,
			-1446.51,
			-1.00,
			-0.00,
			-0.03,
			-0.00,
			1.00,
			0.00,
			0.03,
			0.00,
			-1.00
		),
		["Coconut Isle"] = CFrame.new(
			1431.00,
			9.28,
			-1430.22,
			-0.17,
			0.00,
			0.98,
			-0.00,
			1.00,
			-0.00,
			-0.98,
			-0.00,
			-0.17
		),
		["Amber Isle"] = CFrame.new(1122.07, 9.28, 1414.54, 0.03, -0.00, 1.00, -0.00, 1.00, 0.00, -1.00, -0.00, 0.03),
		["Battlefield Isle"] = CFrame.new(
			1249.73,
			19.56,
			68.87,
			0.01,
			0.00,
			1.00,
			0.00,
			1.00,
			-0.00,
			-1.00,
			0.00,
			0.01
		),
		["Mistpeak Isle"] = CFrame.new(2549.02, 9.28, -80.77, -0.03, 0.00, 1.00, 0.00, 1.00, -0.00, -1.00, 0.00, -0.03),
		["World Angler Isle"] = CFrame.new(
			-2345.67,
			9.28,
			-203.65,
			-0.09,
			-0.00,
			-1.00,
			0.00,
			1.00,
			-0.00,
			1.00,
			-0.00,
			-0.09
		),
		["Weather Isle"] = CFrame.new(
			-2886.12,
			6.76,
			1199.79,
			-0.04,
			-0.00,
			-1.00,
			-0.00,
			1.00,
			-0.00,
			1.00,
			0.00,
			-0.04
		),
		["Mystic Reef Isle"] = CFrame.new(
			-2561.58,
			9.28,
			-1288.64,
			-0.07,
			-0.00,
			-1.00,
			0.00,
			1.00,
			-0.00,
			1.00,
			-0.00,
			-0.07
		),
	}
	local function GetIslandFarmCFrame(islandKey)
		local key = islandKey or Config.SelectedFarmIsland or ""
		if IslandFarmPositions[key] then
			return IslandFarmPositions[key]
		end
		local cleanName = tostring(key):gsub("%s*|%s*%d+", ""):gsub("^%s+", ""):gsub("%s+$", "")
		if IslandFarmPositions[cleanName] then
			return IslandFarmPositions[cleanName]
		end
		local lowerKey = string.lower(cleanName)
		for islandName, islandCf in pairs(IslandFarmPositions) do
			local lowerIsland = string.lower(islandName)
			if lowerKey == lowerIsland or string.find(lowerKey, lowerIsland, 1, true) or string.find(lowerIsland, lowerKey, 1, true) then
				return islandCf
			end
		end
		return nil
	end
	local ModuleCache = {}
	local function GetModuleData(modScript)
		if not modScript or not modScript:IsA("ModuleScript") then
			return nil
		end
		local cachedMod = ModuleCache[modScript]
		if cachedMod ~= nil then
			return cachedMod ~= false and cachedMod or nil
		end
		local reqOk, modData = pcall(require, modScript)
		if reqOk and type(modData) == "table" then
			ModuleCache[modScript] = modData
			return modData
		end
		ModuleCache[modScript] = false
		return nil
	end
	local lastAfkTick = os.clock()
	LocalPlayer.Idled:Connect(function()
		if not Config.AntiAFK then
			return
		end
		pcall(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new(0, 0))
		end)
	end)
	task.spawn(function()
		while true do
			task.wait(1)
			if Config.AntiAFK then
				local nowClock = os.clock()
				if nowClock - lastAfkTick >= 600 then
					lastAfkTick = nowClock
					pcall(function()
						VirtualUser:CaptureController()
						VirtualUser:ClickButton2(Vector2.new(0, 0))
					end)
				end
				pcall(function()
					local afkVal = PlayerData and PlayerData:FindFirstChild("AFK")
					if afkVal and afkVal.Value == true then
						local afkRemote = Events:FindFirstChild("AFK")
						if afkRemote then
							afkRemote:FireServer()
						end
					end
				end)
			else
				lastAfkTick = os.clock()
			end
		end
	end)
	if getconnections then
		for _, idleConn in pairs(getconnections(LocalPlayer.Idled)) do
			if idleConn.Disable then
				idleConn:Disable()
			elseif idleConn.Disconnect then
				idleConn:Disconnect()
			end
		end
	end
	local cachedChar = LocalPlayer.Character
	local cachedHum = cachedChar and cachedChar:FindFirstChildOfClass("Humanoid")
	local cachedHrp = cachedChar and cachedChar:FindFirstChild("HumanoidRootPart")
	local cachedSkillsFolder = cachedChar and cachedChar:FindFirstChild("Skills")
	local cachedStatsFolder = cachedChar and cachedChar:FindFirstChild("Stats")
	local FishesFolder = workspace:FindFirstChild("Fishes")
	loadingStage = "waiting for MainGui / Fishing UI"
	local MainGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")
	local FishingGui = MainGui:WaitForChild("Fishing")
	local BarFrame = FishingGui:WaitForChild("BarFrame")
	local FishingBar = BarFrame:WaitForChild("Bar")
	local SkillBtnFrame = FishingGui:WaitForChild("SkillButton"):WaitForChild("Frame")
	local RhythmGui = FishingGui:FindFirstChild("Rhythm")
	local BossFightBar = FishingGui:FindFirstChild("BossFightBar")
	local MobileGui = MainGui:FindFirstChild("Mobile")
	local MobileFishingBtn = MobileGui and MobileGui:FindFirstChild("Fishing")
	local RhythmHitEvent = Events:FindFirstChild("RhythmHit")
	loadingStage = "game UI ok"
	local function RefreshGuiCache()
		if not MainGui or not MainGui.Parent then
			local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
			MainGui = playerGui and playerGui:FindFirstChild("MainGui")
			FishingGui = MainGui and MainGui:FindFirstChild("Fishing")
			BarFrame = FishingGui and FishingGui:FindFirstChild("BarFrame")
			FishingBar = BarFrame and BarFrame:FindFirstChild("Bar")
			local skillBtnGui = FishingGui and FishingGui:FindFirstChild("SkillButton")
			SkillBtnFrame = skillBtnGui and skillBtnGui:FindFirstChild("Frame")
			RhythmGui = FishingGui and FishingGui:FindFirstChild("Rhythm")
			BossFightBar = FishingGui and FishingGui:FindFirstChild("BossFightBar")
			MobileGui = MainGui and MainGui:FindFirstChild("Mobile")
			MobileFishingBtn = MobileGui and MobileGui:FindFirstChild("Fishing")
		else
			if not RhythmGui or not RhythmGui.Parent then
				RhythmGui = FishingGui and FishingGui:FindFirstChild("Rhythm")
			end
			if not BossFightBar or not BossFightBar.Parent then
				BossFightBar = FishingGui and FishingGui:FindFirstChild("BossFightBar")
			end
			if not MobileFishingBtn or not MobileFishingBtn.Parent then
				MobileGui = MainGui and MainGui:FindFirstChild("Mobile")
				MobileFishingBtn = MobileGui and MobileGui:FindFirstChild("Fishing")
			end
		end
		if not RhythmHitEvent then
			RhythmHitEvent = Events:FindFirstChild("RhythmHit")
		end
		if not FishesFolder or not FishesFolder.Parent then
			FishesFolder = workspace:FindFirstChild("Fishes")
		end
	end
	local noclipThrottle = 0
	RunService.Stepped:Connect(function(stepTime, stepDelta)
		if not Config.NoclipEnabled and not Config.LoopSpeedEnabled then
			return
		end
		noclipThrottle = noclipThrottle + stepDelta
		if noclipThrottle < 0.08 then
			return
		end
		noclipThrottle = 0
		local char = cachedChar
		if not char or not char.Parent then
			return
		end
		if Config.NoclipEnabled then
			for _, part in ipairs(char:GetChildren()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
		end
		if Config.LoopSpeedEnabled and cachedHum and cachedHum.WalkSpeed ~= Config.WalkSpeed then
			cachedHum.WalkSpeed = Config.WalkSpeed
		end
	end)
	local lastInfJumpTick = 0
	local function IsInsideOceanWater(hrpPart)
		if not hrpPart then
			return false
		end
		local oceanFolder = workspace:FindFirstChild("Ocean")
		if not oceanFolder then
			return false
		end
		local hrpPos = hrpPart.Position
		for _, waterPart in ipairs(oceanFolder:GetChildren()) do
			if waterPart.Name == "Water" and waterPart:IsA("BasePart") then
				local halfSize = waterPart.Size * 0.5
				local offset = waterPart.Position - hrpPos
				if math.abs(offset.X) <= halfSize.X and math.abs(offset.Y) <= halfSize.Y and math.abs(offset.Z) <= halfSize.Z then
					return true
				end
			end
		end
		return false
	end
	UserInputService.JumpRequest:Connect(function()
		if not Config.InfJumpEnabled then
			return
		end
		local nowClock = os.clock()
		if nowClock - lastInfJumpTick < 0.18 then
			return
		end
		local char = cachedChar or LocalPlayer.Character
		local hum = cachedHum or (char and char:FindFirstChildOfClass("Humanoid"))
		local hrp = cachedHrp or (char and char:FindFirstChild("HumanoidRootPart"))
		if not char or not hum or not hrp or hum.Health <= 0 then
			return
		end
		if char:GetAttribute("Swimming") == true or hrp:FindFirstChildOfClass("BodyPosition") or IsInsideOceanWater(hrp) then
			return
		end
		lastInfJumpTick = nowClock
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end)
	local flyConnection = nil
	local jumpStateConnection = nil
	local function startFly()
		local char = LocalPlayer.Character
		if not char then
			return
		end
		local hrp = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hrp or not hum then
			return
		end
		hum.PlatformStand = true
		local bodyVel = Instance.new("BodyVelocity")
		bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		bodyVel.Velocity = Vector3.zero
		bodyVel.Parent = hrp
		local bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.P = 1e7
		bodyGyro.D = 12000
		bodyGyro.CFrame = hrp.CFrame
		bodyGyro.Parent = hrp
		jumpStateConnection = hum.StateChanged:Connect(function(oldState, newState)
			if newState == Enum.HumanoidStateType.Jumping or newState == Enum.HumanoidStateType.Freefall then
				hum.PlatformStand = true
			end
		end)
		flyConnection = RunService.RenderStepped:Connect(function()
			local cam = workspace.CurrentCamera
			local moveVec = Vector3.zero
			local moveDir = hum.MoveDirection
			if moveDir.Magnitude > 0 then
				local flatLook = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
				local flatRight = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
				if flatLook.Magnitude > 0.01 and flatRight.Magnitude > 0.01 then
					local forwardDot = moveDir:Dot(flatLook.Unit)
					local rightDot = moveDir:Dot(flatRight.Unit)
					moveVec += cam.CFrame.LookVector * forwardDot
					moveVec += cam.CFrame.RightVector * rightDot
				end
			end
			if moveVec.Magnitude > 0 then
				moveVec = moveVec.Unit
			end
			bodyVel.Velocity = moveVec * Config.FlySpeed * 50
			local camLook = cam.CFrame.LookVector
			bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + camLook, Vector3.new(0, 1, 0))
		end)
	end
	local function stopFly()
		local char = LocalPlayer.Character
		if not char then
			return
		end
		local hrp = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.PlatformStand = false
		end
		if jumpStateConnection then
			jumpStateConnection:Disconnect()
			jumpStateConnection = nil
		end
		if flyConnection then
			flyConnection:Disconnect()
			flyConnection = nil
		end
		if hrp then
			for _, inst in pairs(hrp:GetChildren()) do
				if inst:IsA("BodyVelocity") or inst:IsA("BodyGyro") then
					inst:Destroy()
				end
			end
		end
	end
	local function IsAutoActive()
		return Config.AutoSkill or Config.AutoMiniGame or Config.AutoBoss or Config.AutoSecretBoss or Config.AutoFarmIsland
	end
	local function CleanDebuffs(charTarget)
		if not IsAutoActive() then
			return
		end
		if charTarget then
			if charTarget:GetAttribute("Confused") == true then
				pcall(function()
					charTarget:SetAttribute("Confused", false)
				end)
			end
			if charTarget:GetAttribute("SkillLocked") == true then
				pcall(function()
					charTarget:SetAttribute("SkillLocked", false)
				end)
			end
		end
		if SkillBtnFrame then
			for _, skillBtn in ipairs(SkillBtnFrame:GetChildren()) do
				if skillBtn:IsA("TextButton") then
					local lockIcon = skillBtn:FindFirstChild("Lock")
					if lockIcon and lockIcon.Visible then
						lockIcon.Visible = false
					end
				end
			end
		end
		if FishingGui then
			local hpPlayer = FishingGui:FindFirstChild("HPPlayer")
			local debuffFrame = hpPlayer and hpPlayer:FindFirstChild("Debuff")
			local confusedUi = debuffFrame and debuffFrame:FindFirstChild("Confused")
			if confusedUi then
				pcall(function()
					confusedUi:Destroy()
				end)
			end
		end
	end
	local debuffConns = {}
	local function BindDebuffCleaner(targetChar)
		for _, conn in ipairs(debuffConns) do
			pcall(function()
				conn:Disconnect()
			end)
		end
		table.clear(debuffConns)
		if not targetChar then
			return
		end
		table.insert(
			debuffConns,
			targetChar:GetAttributeChangedSignal("Confused"):Connect(function()
				if IsAutoActive() and targetChar:GetAttribute("Confused") == true then
					CleanDebuffs(targetChar)
				end
			end)
		)
		table.insert(
			debuffConns,
			targetChar:GetAttributeChangedSignal("SkillLocked"):Connect(function()
				if IsAutoActive() and targetChar:GetAttribute("SkillLocked") == true then
					CleanDebuffs(targetChar)
				end
			end)
		)
		if IsAutoActive() then
			CleanDebuffs(targetChar)
		end
	end
	local function StepAutoTPPos(tpChar)
		if not Config.AutoTPPos then
			return
		end
		if Config.AutoBoss or Config.AutoSecretBoss then
			return
		end
		local savedCf = GetSavedCFrame()
		if not savedCf then
			return
		end
		local char = tpChar or cachedChar or LocalPlayer.Character
		local hrp = (char and char:FindFirstChild("HumanoidRootPart")) or cachedHrp
		if hrp and (hrp.Position - savedCf.Position).Magnitude > 5 then
			hrp.CFrame = savedCf
		end
	end
	local function StepAutoFarmIsland(farmChar)
		if not Config.AutoFarmIsland then
			return
		end
		if Config.AutoBoss or Config.AutoSecretBoss then
			return
		end
		local farmCf = GetIslandFarmCFrame()
		if not farmCf then
			return
		end
		local char = farmChar or cachedChar or LocalPlayer.Character
		local hrp = (char and char:FindFirstChild("HumanoidRootPart")) or cachedHrp
		if hrp and (hrp.Position - farmCf.Position).Magnitude > 5 then
			hrp.CFrame = farmCf
		end
	end
	if cachedChar then
		BindDebuffCleaner(cachedChar)
		task.spawn(function()
			StepAutoTPPos(cachedChar)
			StepAutoFarmIsland(cachedChar)
		end)
	end
	LocalPlayer.CharacterAdded:Connect(function(newChar)
		cachedChar = newChar
		cachedHum = newChar:WaitForChild("Humanoid", 5)
		cachedHrp = newChar:WaitForChild("HumanoidRootPart", 5)
		cachedSkillsFolder = newChar:WaitForChild("Skills", 5)
		cachedStatsFolder = newChar:WaitForChild("Stats", 5)
		BindDebuffCleaner(newChar)
		task.wait(0.3)
		StepAutoTPPos(newChar)
		StepAutoFarmIsland(newChar)
		if Config.FlyEnabled then
			startFly()
		end
	end)
	local minigameOpenTick = 0
	local wasMinigameVisible = false
	local bossPhase2SetupUntil = 0
	do
		local bp2Event = Events:FindFirstChild("BossPhase2Setup")
		if bp2Event and bp2Event:IsA("RemoteEvent") then
			bp2Event.OnClientEvent:Connect(function()
				bossPhase2SetupUntil = os.clock() + 5
			end)
		end
	end
	local function FindSkillNumberValue(char, skillKey)
		local skillsFolder = cachedSkillsFolder or (char and char:FindFirstChild("Skills"))
		if not skillsFolder then
			return nil, nil
		end
		for _, skillObj in ipairs(skillsFolder:GetChildren()) do
			if skillObj:IsA("NumberValue") then
				local keyAttr = skillObj:GetAttribute("Key") or skillObj.Name
				if tostring(keyAttr) == skillKey then
					return skillObj, skillsFolder
				end
			end
		end
		return nil, skillsFolder
	end
	local function FindSkillButton(skillKey)
		if not SkillBtnFrame then
			return nil
		end
		local directBtn = SkillBtnFrame:FindFirstChild(skillKey)
		if directBtn then
			return directBtn
		end
		for _, childGui in ipairs(SkillBtnFrame:GetChildren()) do
			if childGui:IsA("GuiObject") then
				if tostring(childGui:GetAttribute("Key") or "") == skillKey then
					return childGui
				end
				for _, descLabel in ipairs(childGui:GetDescendants()) do
					if descLabel:IsA("TextLabel") and descLabel.Name ~= "CD" and descLabel.Text == skillKey then
						return childGui
					end
				end
			end
		end
		return nil
	end
	local function IsGameAllowingSkill(char)
		if not FishingGui or not FishingGui.Visible then
			wasMinigameVisible = false
			return false
		end
		if not wasMinigameVisible then
			wasMinigameVisible = true
			minigameOpenTick = os.clock()
		end
		if (RhythmGui and RhythmGui.Visible) or (BossFightBar and BossFightBar.Visible) then
			return false
		end
		if char:GetAttribute("Phase2") == true then
			bossPhase2SetupUntil = 0
			return false
		end
		if bossPhase2SetupUntil > 0 and os.clock() < bossPhase2SetupUntil then
			return false
		end
		if not IsAutoActive() then
			if char:GetAttribute("SkillLocked") or char:GetAttribute("Confused") then
				return false
			end
		else
			CleanDebuffs(char)
		end
		local statsFolder = cachedStatsFolder or char:FindFirstChild("Stats")
		if statsFolder and statsFolder:FindFirstChild("Stun") and statsFolder.Stun.Value == true then
			return false
		end
		local fishId = LocalPlayer:GetAttribute("FishID")
		local fishObj = (fishId and FishesFolder) and FishesFolder:FindFirstChild(tostring(fishId)) or nil
		if fishObj then
			local readyVal = fishObj:FindFirstChild("Ready")
			if readyVal then
				if readyVal.Value ~= true then
					return false
				end
			elseif os.clock() - minigameOpenTick < 3.1 then
				return false
			end
			if fishObj:GetAttribute("FinalPhase") == true or fishObj:GetAttribute("PreFinalPhase") == true then
				return false
			end
		elseif os.clock() - minigameOpenTick < 3.1 then
			return false
		end
		local skillsFolder = cachedSkillsFolder or char:FindFirstChild("Skills")
		if skillsFolder then
			for _, skillVal in ipairs(skillsFolder:GetChildren()) do
				if skillVal:IsA("NumberValue") and (skillVal:GetAttribute("UsingSkill") or 0) > 0 then
					return false
				end
			end
		end
		return true
	end
	local function IsSkillSlotAvailable(char, skillKey)
		if PlayerData then
			local equippedRod = PlayerData:FindFirstChild("FishingRod")
			local rodInv = PlayerData:FindFirstChild("FishingRodInventory")
			local rodItem = (equippedRod and equippedRod.Value ~= "" and rodInv) and rodInv:FindFirstChild(equippedRod.Value) or nil
			local skillFolder = rodItem and rodItem:FindFirstChild("Skill")
			local slotVal = skillFolder and skillFolder:FindFirstChild(skillKey)
			if slotVal and slotVal:IsA("StringValue") then
				return slotVal.Value ~= ""
			end
		end
		local skillBtn = FindSkillButton(skillKey)
		if skillBtn then
			return skillBtn.Visible == true
		end
		local skillNumVal = FindSkillNumberValue(char, skillKey)
		return skillNumVal ~= nil
	end
	local function IsSkillOnCooldown(char, skillKey)
		local skillBtn = FindSkillButton(skillKey)
		if skillBtn then
			local cdLabel = skillBtn:FindFirstChild("CD")
			if cdLabel and cdLabel.Visible then
				local cdText = cdLabel.Text or ""
				local cdRemaining = tonumber(string.match(cdText, "%d+%.?%d*"))
				if cdRemaining and cdRemaining > 0 then
					return true
				end
			end
		end
		local skillNumVal = FindSkillNumberValue(char, skillKey)
		if skillNumVal and (skillNumVal.Value > 0 or (skillNumVal:GetAttribute("UsingSkill") or 0) > 0) then
			return true
		end
		return false
	end
	local function IsSkillConfirmedUsed(char, skillKey)
		return IsSkillOnCooldown(char, skillKey)
	end
	local function IsSkillKeyReady(char, skillKey)
		if not IsSkillSlotAvailable(char, skillKey) then
			return false
		end
		if IsSkillOnCooldown(char, skillKey) then
			return false
		end
		local skillBtn = FindSkillButton(skillKey)
		if skillBtn then
			if not skillBtn.Visible then
				return false
			end
			local lockOverlay = skillBtn:FindFirstChild("Lock")
			if lockOverlay and lockOverlay.Visible then
				if IsAutoActive() then
					lockOverlay.Visible = false
				else
					return false
				end
			end
		end
		local skillNumVal, skillsFolder = FindSkillNumberValue(char, skillKey)
		if skillNumVal then
			return true
		end
		if skillsFolder and #skillsFolder:GetChildren() > 0 then
			return false
		end
		return skillBtn ~= nil and skillBtn.Visible == true
	end
	local rhythmLanes = { "A", "S", "D" }
	local rhythmKeyMap = { A = Enum.KeyCode.A, S = Enum.KeyCode.S, D = Enum.KeyCode.D }
	local lastRhythmLaneHit = { A = 0, S = 0, D = 0 }
	local lastRhythmScan = 0
	local lastPhase2HitTick = 0
	local phase2BarHistory = {}
	local CENTER_BAR_POS = UDim2.new(0.5, 0, 0.5, 0)
	local isLockingBar = false
	local barPosConn = nil
	local boundBar = nil
	local function LockFishingBar()
		if isLockingBar then
			return
		end
		if not FishingGui or not FishingGui.Visible or not FishingBar then
			return
		end
		if
			not (Config.AutoReel or Config.AutoMiniGame or Config.AutoBoss or Config.AutoSecretBoss or Config.AutoFarmIsland)
		then
			return
		end
		isLockingBar = true
		local char = cachedChar
		if char and (tonumber(char:GetAttribute("GuildPower")) or 0) < 99999999 then
			pcall(function()
				char:SetAttribute("GuildPower", 99999999)
				local statsFolder = cachedStatsFolder or char:FindFirstChild("Stats")
				local rodPowerVal = statsFolder and statsFolder:FindFirstChild("RodPower")
				if rodPowerVal then
					local origPower = rodPowerVal.Value
					rodPowerVal.Value = origPower + 1
					rodPowerVal.Value = origPower
				end
			end)
		end
		pcall(function()
			FishingBar:TweenPosition(CENTER_BAR_POS, Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0, true)
			FishingBar.Position = CENTER_BAR_POS
		end)
		isLockingBar = false
	end
	local function BindFishingBarLock()
		if FishingBar and FishingBar ~= boundBar then
			if barPosConn then
				pcall(function()
					barPosConn:Disconnect()
				end)
				barPosConn = nil
			end
			boundBar = FishingBar
			barPosConn = FishingBar:GetPropertyChangedSignal("Position"):Connect(function()
				if not isLockingBar and FishingBar.Position.X.Scale ~= 0.5 then
					LockFishingBar()
				end
			end)
		end
	end
	BindFishingBarLock()
	local function TriggerGuiButton(targetBtn)
		if not targetBtn then
			return false
		end
		if not targetBtn:IsA("GuiButton") then
			targetBtn = targetBtn:FindFirstChildWhichIsA("GuiButton", true)
				or (targetBtn.Parent and targetBtn.Parent:IsA("GuiButton") and targetBtn.Parent)
				or nil
			if not targetBtn then
				return false
			end
		end
		local wasTriggered = false
		local signalNames = { "MouseButton1Click", "Activated", "MouseButton1Down", "MouseButton1Up" }
		if getconnections then
			for _, sigName in ipairs(signalNames) do
				local sigOk, sigObj = pcall(function()
					return targetBtn[sigName]
				end)
				if sigOk and sigObj then
					pcall(function()
						for _, conn in pairs(getconnections(sigObj)) do
							if conn.Function then
								task.spawn(conn.Function)
								wasTriggered = true
							elseif conn.Fire then
								conn:Fire()
								wasTriggered = true
							end
						end
					end)
				end
			end
		end
		if firesignal then
			for _, sigName in ipairs(signalNames) do
				pcall(function()
					firesignal(targetBtn[sigName])
					wasTriggered = true
				end)
			end
		end
		return wasTriggered
	end
	local safeGetUpvalue = (debug and debug.getupvalue) or getupvalue
	local function HandleBossFightBar()
		if not BossFightBar or not BossFightBar.Visible then
			if #phase2BarHistory > 0 then
				table.clear(phase2BarHistory)
			end
			return
		end
		local movingBar = BossFightBar:FindFirstChild("Bar")
		local hitbox = BossFightBar:FindFirstChild("Hitbox")
		if not movingBar or not hitbox then
			return
		end
		local barWidth = movingBar.Size.X.Scale
		local barCenter = movingBar.Position.X.Scale + barWidth * (0.5 - movingBar.AnchorPoint.X)
		local hitboxWidth = hitbox.Size.X.Scale
		local hitboxLeft = hitbox.Position.X.Scale - hitboxWidth * hitbox.AnchorPoint.X
		local nowClock = os.clock()
		table.insert(phase2BarHistory, { t = nowClock, x = barCenter })
		while #phase2BarHistory > 1 and (nowClock - phase2BarHistory[1].t) > 0.15 do
			table.remove(phase2BarHistory, 1)
		end
		local handledByUpvalue = false
		local hitHandlerFn = nil
		if getconnections and safeGetUpvalue and MobileFishingBtn then
			pcall(function()
				for _, conn in pairs(getconnections(MobileFishingBtn.MouseButton1Down)) do
					local upvalFn = conn.Function and safeGetUpvalue(conn.Function, 1)
					if type(upvalFn) == "function" then
						hitHandlerFn = upvalFn
						local isActive = safeGetUpvalue(upvalFn, 1)
						local lastHitTime = safeGetUpvalue(upvalFn, 2)
						local startTime = safeGetUpvalue(upvalFn, 3)
						local cyclePeriod = safeGetUpvalue(upvalFn, 4)
						local barSpeed = safeGetUpvalue(upvalFn, 5)
						local maxSpan = safeGetUpvalue(upvalFn, 6)
						local baseOffset = safeGetUpvalue(upvalFn, 7)
						local targetWidth = safeGetUpvalue(upvalFn, 8)
						local targetLeft = safeGetUpvalue(upvalFn, 9)
						if
							isActive == true
							and type(lastHitTime) == "number"
							and type(startTime) == "number"
							and type(cyclePeriod) == "number"
							and type(barSpeed) == "number"
							and type(maxSpan) == "number"
							and type(baseOffset) == "number"
							and type(targetWidth) == "number"
							and type(targetLeft) == "number"
						then
							if math.abs(targetWidth - hitboxWidth) < 0.005 and math.abs(targetLeft - hitboxLeft) < 0.005 then
								handledByUpvalue = true
								if
									nowClock - lastHitTime >= (Config.MiniGameDelay or 0.12)
									and nowClock - lastPhase2HitTick >= (Config.MiniGameDelay or 0.12)
								then
									local cycleOffset = (nowClock - 0.025 - startTime) % cyclePeriod * barSpeed
									if maxSpan < cycleOffset then
										cycleOffset = maxSpan * 2 - cycleOffset
									end
									local predictedPos = baseOffset + cycleOffset
									local tolerance = targetWidth * 0.3
									if predictedPos >= (targetLeft - tolerance * 0.8) and predictedPos <= (targetLeft + targetWidth + tolerance * 0.8) then
										lastPhase2HitTick = nowClock
										upvalFn(false)
									end
								end
							end
							break
						end
					end
				end
			end)
		end
		if handledByUpvalue then
			return
		end
		if nowClock - lastPhase2HitTick < (Config.MiniGameDelay or 0.12) then
			return
		end
		local sampledPos = barCenter
		local sampleTargetTime = nowClock - 0.041
		for histIdx = #phase2BarHistory, 1, -1 do
			if phase2BarHistory[histIdx].t <= sampleTargetTime then
				sampledPos = phase2BarHistory[histIdx].x
				break
			end
		end
		local margin = hitboxWidth * 0.2
		local badHitbox = BossFightBar:FindFirstChild("HitboxBad")
		if badHitbox and badHitbox.Visible then
			local badWidth = badHitbox.Size.X.Scale
			local badLeft = badHitbox.Position.X.Scale - badWidth * badHitbox.AnchorPoint.X
			if sampledPos >= (badLeft - 0.01) and sampledPos <= (badLeft + badWidth + 0.01) then
				return
			end
		end
		if sampledPos >= (hitboxLeft - margin) and sampledPos <= (hitboxLeft + hitboxWidth + margin) then
			lastPhase2HitTick = nowClock
			local didFire = false
			if hitHandlerFn then
				pcall(function()
					hitHandlerFn(false)
					didFire = true
				end)
			end
			if not didFire and MobileFishingBtn then
				if getconnections then
					pcall(function()
						for _, conn in pairs(getconnections(MobileFishingBtn.MouseButton1Down)) do
							if conn.Function then
								task.spawn(conn.Function)
								didFire = true
							elseif conn.Fire then
								conn:Fire()
								didFire = true
							end
						end
					end)
				end
				if not didFire and firesignal then
					pcall(function()
						firesignal(MobileFishingBtn.MouseButton1Down)
						didFire = true
					end)
				end
			end
			if not didFire then
				pcall(function()
					VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
					task.delay(0.01, function()
						VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
					end)
				end)
			end
		end
	end
	do
		local function isRedTrapColor(col)
			return col
				and col.R > 0.65
				and col.G < 0.45
				and col.B < 0.45
				and col.R > col.G * 1.8
				and col.R > col.B * 1.8
		end
		function Hub.IsTrapNote(noteObj)
			if not noteObj or not noteObj:IsA("GuiObject") then
				return false
			end
			if
				noteObj:GetAttribute("Trap") == true
				or noteObj:GetAttribute("trap") == true
				or noteObj:GetAttribute("IsTrap") == true
			then
				return true
			end
			if string.find(string.lower(noteObj.Name), "trap", 1, true) then
				return true
			end
			if isRedTrapColor(noteObj.BackgroundColor3) then
				return true
			end
			if (noteObj:IsA("ImageLabel") or noteObj:IsA("ImageButton")) and isRedTrapColor(noteObj.ImageColor3) then
				return true
			end
			for _, descGui in ipairs(noteObj:GetDescendants()) do
				if descGui:IsA("GuiObject") then
					if isRedTrapColor(descGui.BackgroundColor3) then
						return true
					end
					if (descGui:IsA("ImageLabel") or descGui:IsA("ImageButton")) and isRedTrapColor(descGui.ImageColor3) then
						return true
					end
				end
			end
			return false
		end
	end
	local function HandleRhythmMinigame()
		if not RhythmGui or not RhythmGui.Visible then
			return
		end
		local nowClock = os.clock()
		if nowClock - lastRhythmScan < math.max(0.025, (Config.MiniGameDelay or 0.12) / 2) then
			return
		end
		lastRhythmScan = nowClock
		for _, laneKey in ipairs(rhythmLanes) do
			if nowClock - (lastRhythmLaneHit[laneKey] or 0) >= math.max(0.05, Config.MiniGameDelay or 0.12) then
				local laneFrame = RhythmGui:FindFirstChild("Progression" .. laneKey)
				if laneFrame then
					local laneBarFrame = laneFrame:FindFirstChild("BarFrame")
					local targetY = laneBarFrame and laneBarFrame.Position.Y.Scale or 0.85
					local bestNote = nil
					local bestDist = 0.18
					for _, childObj in ipairs(laneFrame:GetChildren()) do
						if
							childObj.Name == "Note_FX"
							and childObj:IsA("GuiObject")
							and childObj.Visible
							and not Hub.IsTrapNote(childObj)
						then
							local noteDist = math.abs(childObj.Position.Y.Scale - targetY)
							if noteDist <= bestDist then
								bestDist = noteDist
								bestNote = childObj
							end
						end
					end
					if bestNote then
						lastRhythmLaneHit[laneKey] = nowClock
						local laneBtn = laneFrame:FindFirstChild("Button")
						if laneBtn then
							TriggerGuiButton(laneBtn)
						end
						if bestNote.Parent ~= nil then
							local keyCode = rhythmKeyMap[laneKey]
							if keyCode then
								pcall(function()
									VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
									task.delay(0.02, function()
										VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
									end)
								end)
							end
						end
						if bestNote.Parent ~= nil and bestDist <= 0.1 and RhythmHitEvent then
							pcall(function()
								bestNote:Destroy()
								RhythmHitEvent:FireServer("hit")
							end)
						end
					end
				end
			end
		end
	end
	RunService.RenderStepped:Connect(function()
		if not FishingGui or not FishingGui.Visible then
			return
		end
		BindFishingBarLock()
		LockFishingBar()
		if Config.AutoMiniGame then
			HandleBossFightBar()
		end
	end)
	RunService.Stepped:Connect(function()
		if not FishingGui or not FishingGui.Visible then
			return
		end
		BindFishingBarLock()
		LockFishingBar()
	end)
	RunService.Heartbeat:Connect(function()
		if not FishingGui or not FishingGui.Visible then
			return
		end
		BindFishingBarLock()
		LockFishingBar()
		if Config.AutoMiniGame then
			HandleBossFightBar()
			HandleRhythmMinigame()
		end
	end)
	local function GetModelPart(targetModel)
		if not targetModel then
			return nil
		end
		if targetModel:IsA("BasePart") then
			return targetModel
		end
		if targetModel:IsA("Model") then
			return targetModel:FindFirstChild("HumanoidRootPart")
				or targetModel:FindFirstChild("Head")
				or targetModel.PrimaryPart
				or targetModel:FindFirstChildWhichIsA("BasePart", true)
		end
		return targetModel:FindFirstChildWhichIsA("BasePart", true)
	end
	local function IsSecretOrBossTarget(bossCandidate)
		if not bossCandidate then
			return false
		end
		if bossCandidate:GetAttribute("Secret") == true or bossCandidate:GetAttribute("Rarity") == "Secret" then
			return true
		end
		local rawName = tostring(bossCandidate:GetAttribute("Name") or bossCandidate:GetAttribute("FishName") or bossCandidate.Name)
		local lowerName = string.lower(rawName)
		if
			string.find(lowerName, "secret")
			or string.find(lowerName, "long diaohai")
			or string.find(lowerName, "longdiaohai")
			or string.find(lowerName, "diaohai")
			or string.find(lowerName, "wuzhi")
		then
			return true
		end
		local invInfo = Info:FindFirstChild("Inventory")
		local fishMod = invInfo and invInfo:FindFirstChild(rawName)
		local fishData = GetModuleData(fishMod)
		if
			fishData
			and (
				fishData.Secret == true
				or fishData.Rarity == "Secret"
				or (fishData.Boss == true and (tonumber(fishData.Chance) or 100) <= 1)
			)
		then
			return true
		end
		return false
	end
	local function FindBossTarget(wantSecret)
		local npcFolder = workspace:FindFirstChild("NPC")
		local bossFolder = npcFolder and npcFolder:FindFirstChild("Boss")
		if bossFolder then
			for _, bossModel in ipairs(bossFolder:GetChildren()) do
				local bossPart = GetModelPart(bossModel)
				if bossPart then
					local isSecret = IsSecretOrBossTarget(bossModel)
					if wantSecret and isSecret then
						return bossModel, bossPart
					elseif not wantSecret and not isSecret then
						return bossModel, bossPart
					end
				end
			end
		end
		if not wantSecret then
			local fallbackBoss = workspace:FindFirstChild("Boss") or workspace:FindFirstChild("BossZone")
			if fallbackBoss then
				local fallbackPart = GetModelPart(fallbackBoss)
				if fallbackPart then
					return fallbackBoss, fallbackPart
				end
			end
		end
		return nil, nil
	end
	local BossTeleportCFrames = {
		Enzo = CFrame.new(-114.81, 9.28, 1356.67, 0.05, -0.00, -1.00, -0.00, 1.00, -0.00, 1.00, 0.00, 0.05),
		LongDiaoHai = CFrame.new(-2873.62, 32.17, 1337.38, -0.09, 0.00, -1.00, 0.00, 1.00, 0.00, 1.00, -0.00, -0.09),
	}
	local function GetBossCFrame(isSecretBoss)
		return isSecretBoss and BossTeleportCFrames.LongDiaoHai or BossTeleportCFrames.Enzo
	end
	local lastBossStepClock = 0
	local function extractGuiText(guiElem)
		if not guiElem then
			return ""
		end
		if guiElem:IsA("TextButton") or guiElem:IsA("TextLabel") then
			if guiElem.Text and guiElem.Text ~= "" then
				return guiElem.Text
			end
		end
		local titleLabel = guiElem:FindFirstChild("Title")
			or guiElem:FindFirstChild("TextLabel")
			or guiElem:FindFirstChildWhichIsA("TextLabel", true)
		if titleLabel and titleLabel.Text then
			return titleLabel.Text
		end
		return ""
	end
	local function clickGuiElement(targetBtn)
		if not targetBtn then
			return false
		end
		if not targetBtn:IsA("GuiButton") then
			targetBtn = targetBtn:FindFirstChildWhichIsA("GuiButton", true)
				or (targetBtn.Parent and targetBtn.Parent:IsA("GuiButton") and targetBtn.Parent)
				or nil
			if not targetBtn then
				return false
			end
		end
		local clicked = false
		pcall(function()
			if targetBtn.AbsolutePosition and targetBtn.AbsoluteSize then
				local centerPos = targetBtn.AbsolutePosition + (targetBtn.AbsoluteSize / 2)
				VirtualInputManager:SendMouseButtonEvent(centerPos.X, centerPos.Y, 0, true, game, 0)
				task.wait(0.02)
				VirtualInputManager:SendMouseButtonEvent(centerPos.X, centerPos.Y, 0, false, game, 0)
				clicked = true
			end
		end)
		local clickEvents = { "MouseButton1Click", "Activated", "MouseButton1Down", "MouseButton1Up" }
		if getconnections then
			for _, evtName in ipairs(clickEvents) do
				local evtOk, evtSignal = pcall(function()
					return targetBtn[evtName]
				end)
				if evtOk and evtSignal then
					pcall(function()
						for _, conn in pairs(getconnections(evtSignal)) do
							if conn.Function then
								task.spawn(conn.Function)
								clicked = true
							elseif conn.Fire then
								conn:Fire()
								clicked = true
							end
						end
					end)
				end
			end
		end
		if firesignal then
			for _, evtName in ipairs(clickEvents) do
				pcall(function()
					firesignal(targetBtn[evtName])
					clicked = true
				end)
			end
		end
		return clicked
	end
	local function GetBossMenuFrame()
		if not MainGui then
			return nil
		end
		local menuFolder = MainGui:FindFirstChild("Menu")
		if not menuFolder then
			return nil
		end
		for _, frameName in ipairs({ "BossFight", "Boss", "BossMenu", "Raid", "SecretBoss" }) do
			local foundFrame = menuFolder:FindFirstChild(frameName)
			if foundFrame and foundFrame:IsA("GuiObject") then
				return foundFrame
			end
		end
		for _, childFrame in ipairs(menuFolder:GetChildren()) do
			if childFrame:IsA("Frame") and childFrame.Name ~= "Info" and childFrame.Name ~= "Black" and childFrame.Name ~= "Dialogue" then
				local titleObj = childFrame:FindFirstChild("Title")
				if titleObj and titleObj:IsA("TextLabel") and string.find(string.lower(titleObj.Text), "boss") then
					return childFrame
				end
				if
					childFrame:FindFirstChild("Normal", true)
					and childFrame:FindFirstChild("Hard", true)
					and childFrame:FindFirstChild("Nightmare", true)
				then
					return childFrame
				end
			end
		end
		return nil
	end
	local function GetBossPowerWarnings(bossMenuGui, bossName)
		local warnings = {}
		local rodVal = PlayerData and PlayerData:FindFirstChild("FishingRod")
		local rodName = rodVal and rodVal.Value or ""
		if rodName == "" then
			table.insert(warnings, "No Fishing Rod equipped")
		end
		local char = LocalPlayer.Character
		local statsFolder = char and char:FindFirstChild("Stats")
		local invInfo = Info:FindFirstChild("Inventory")
		if invInfo and bossName then
			local bossMod = invInfo:FindFirstChild(bossName)
			local bossInfo = GetModuleData(bossMod)
			local rodMod = rodName ~= "" and invInfo:FindFirstChild(rodName) or nil
			local rodInfo = GetModuleData(rodMod)
			if bossInfo and tonumber(bossInfo.Power) and rodInfo and tonumber(rodInfo.Power) then
				local bonusRodPower = statsFolder and statsFolder:FindFirstChild("RodPower") and tonumber(statsFolder.RodPower.Value) or 0
				local bonusFishPower = statsFolder and statsFolder:FindFirstChild("FishPower") and tonumber(statsFolder.FishPower.Value) or 0
				local totalPower = tonumber(rodInfo.Power) + bonusRodPower
				local reqPower = math.max(1, tonumber(bossInfo.Power) - bonusFishPower + 4)
				if (totalPower / reqPower) <= 0.5 then
					table.insert(warnings, string.format("Low Power (%d/%d)", math.floor(totalPower), math.floor(reqPower)))
				end
			end
		end
		if bossMenuGui then
			for _, descLabel in ipairs(bossMenuGui:GetDescendants()) do
				if descLabel:IsA("TextLabel") and descLabel.Visible then
					local labelText = descLabel.Text or ""
					local curStr, reqStr = string.match(labelText, "^%s*(%d+)%s*/%s*(%d+)%s*$")
					if curStr and reqStr then
						local curNum = tonumber(curStr)
						local reqNum = tonumber(reqStr)
						if curNum and reqNum and curNum < reqNum then
							table.insert(warnings, curStr .. "/" .. reqStr)
						end
					end
				end
			end
		end
		return warnings
	end
	local isInBossFight = false
	local lastBossActiveClock = 0
	local function CloseBossDialogue(dialogueGui)
		if not dialogueGui or not dialogueGui.Visible then
			return
		end
		local wasClosed = false
		for _, btn in ipairs(dialogueGui:GetDescendants()) do
			if btn:IsA("GuiButton") and btn.Visible then
				local btnName = string.lower(btn.Name)
				local btnText = string.lower(extractGuiText(btn))
				local parentName = btn.Parent and string.lower(btn.Parent.Name) or ""
				if btnName == "close" or btnText == "x" or parentName == "close" then
					if clickGuiElement(btn) then
						wasClosed = true
						break
					end
				end
			end
		end
		if not wasClosed then
			pcall(function()
				dialogueGui.Visible = false
			end)
		end
	end
	local function StepAutoBossSpawn(isSecretBoss)
		isInBossFight = false
		lastBossActiveClock = 0
		local rodVal = PlayerData and PlayerData:FindFirstChild("FishingRod")
		if not rodVal or rodVal.Value == "" then
			return
		end
		local bossTarget = FindBossTarget(isSecretBoss)
		if not bossTarget then
			return
		end
		local hrp = cachedHrp or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
		local bossCf = GetBossCFrame(isSecretBoss)
		if hrp and bossCf then
			hrp.CFrame = bossCf
		end
		local char = cachedChar or LocalPlayer.Character
		if char and char:GetAttribute("Type") ~= "Fishing Rod" then
			pcall(function()
				ToggleHotbar:InvokeServer("1")
			end)
		end
	end
	local function TriggerClick(btnObj)
		if not btnObj then
			return false
		end
		if not btnObj:IsA("GuiButton") then
			btnObj = btnObj:FindFirstChildWhichIsA("GuiButton", true)
				or (btnObj.Parent and btnObj.Parent:IsA("GuiButton") and btnObj.Parent)
				or nil
			if not btnObj then
				return false
			end
		end
		local fired = false
		local clickSigs = { "MouseButton1Click", "Activated" }
		if firesignal then
			for _, sigName in ipairs(clickSigs) do
				pcall(function()
					firesignal(btnObj[sigName])
					fired = true
				end)
			end
		end
		if getconnections then
			for _, sigName in ipairs(clickSigs) do
				local sigOk, sigObj = pcall(function()
					return btnObj[sigName]
				end)
				if sigOk and sigObj then
					pcall(function()
						for _, conn in pairs(getconnections(sigObj)) do
							if conn.Function then
								task.spawn(conn.Function)
								fired = true
							elseif conn.Fire then
								conn:Fire()
								fired = true
							end
						end
					end)
				end
			end
		end
		return fired
	end
	local function HandleBossDialogueChoice(bossGui, bossName, modeName, isSecret)
		local targetMode = modeName or "Normal"
		local selectFrame = bossGui:FindFirstChild("Select", true)
		local btnContainer = (selectFrame and selectFrame:FindFirstChild("button")) or selectFrame or bossGui
		local modeBtn = nil
		if btnContainer then
			modeBtn = btnContainer:FindFirstChild(targetMode)
			if not modeBtn then
				for _, childBtn in ipairs(btnContainer:GetChildren()) do
					if childBtn:IsA("GuiButton") and string.lower(childBtn.Name) == string.lower(targetMode) then
						modeBtn = childBtn
						break
					end
				end
			end
		end
		if not modeBtn then
			for _, descBtn in ipairs(bossGui:GetDescendants()) do
				if descBtn:IsA("GuiButton") then
					local descName = string.lower(descBtn.Name)
					local descText = string.lower(extractGuiText(descBtn))
					if descName == string.lower(targetMode) or descText == string.lower(targetMode) then
						modeBtn = descBtn
						break
					end
				end
			end
		end
		if modeBtn then
			TriggerClick(modeBtn)
			task.wait(0.15)
		end
		local fightBtn = bossGui:FindFirstChild("Fight", true)
		if not fightBtn then
			for _, descBtn in ipairs(bossGui:GetDescendants()) do
				if descBtn:IsA("GuiButton") then
					local descName = string.lower(descBtn.Name)
					local descText = string.lower(extractGuiText(descBtn))
					if
						descName == "fight"
						or descText == "fight"
						or string.find(descName, "fight")
						or string.find(descText, "fight")
					then
						fightBtn = descBtn
						break
					end
				end
			end
		end
		if fightBtn then
			TriggerClick(fightBtn)
		end
		local remoteList = {}
		local function collectRemotes(folder)
			if not folder then
				return
			end
			for _, childRemote in ipairs(folder:GetChildren()) do
				if childRemote:IsA("RemoteEvent") or childRemote:IsA("RemoteFunction") then
					table.insert(remoteList, childRemote)
				end
			end
		end
		collectRemotes(Events)
		local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
		collectRemotes(remotesFolder)
		local bossRemoteNames = {
			["bossfight"] = true,
			["startbossfight"] = true,
			["startboss"] = true,
			["boss"] = true,
			["challengeboss"] = true,
			["fightboss"] = true,
			["choosedialogueoption"] = true,
		}
		for _, remoteObj in ipairs(remoteList) do
			local lowerRemoteName = string.lower(remoteObj.Name)
			if bossRemoteNames[lowerRemoteName] or string.find(lowerRemoteName, "boss") then
				pcall(function()
					if remoteObj:IsA("RemoteEvent") then
						remoteObj:FireServer(targetMode)
						if bossName then
							remoteObj:FireServer(bossName, targetMode)
							remoteObj:FireServer(targetMode, bossName)
						end
					elseif remoteObj:IsA("RemoteFunction") then
						remoteObj:InvokeServer(targetMode)
						if bossName then
							remoteObj:InvokeServer(bossName, targetMode)
							remoteObj:InvokeServer(targetMode, bossName)
						end
					end
				end)
			end
		end
		task.wait(0.25)
		if FishingGui and FishingGui.Visible then
			isInBossFight = true
			lastBossActiveClock = os.clock()
			if bossGui then
				CloseBossDialogue(bossGui)
			end
			return true
		end
		return false
	end
	local lastFishCaughtClock = 0
	local lastCaughtFishName = ""
	do
		local caughtEvent = Events:FindFirstChild("ReplicateFishCaught")
		if caughtEvent and caughtEvent:IsA("RemoteEvent") then
			caughtEvent.OnClientEvent:Connect(function(caughtChar, caughtName)
				if caughtChar == LocalPlayer.Character then
					lastFishCaughtClock = os.clock()
					lastCaughtFishName = tostring(caughtName or "")
					isInBossFight = false
					lastBossActiveClock = 0
				end
			end)
		end
	end
	local isMonitoringBoss = false
	local function startBossFightMonitor()
		if isMonitoringBoss then
			return
		end
		local fishId = LocalPlayer:GetAttribute("FishID")
		local fishesFolder = workspace:FindFirstChild("Fishes")
		local fishInst = (fishId and fishesFolder) and fishesFolder:FindFirstChild(tostring(fishId)) or nil
		if not fishInst then
			return
		end
		isMonitoringBoss = true
		task.spawn(function()
			local progBar = FishingGui and FishingGui:FindFirstChild("ProgressionBar")
			local fishNameLabel = progBar and progBar:FindFirstChild("FishName")
			local bossTitle = (fishNameLabel and fishNameLabel.Text ~= "" and fishNameLabel.Text) or "Boss"
			local playerHpVal = fishInst:FindFirstChild(LocalPlayer.UserId .. "_PlayerHealth")
			local maxHp = tonumber(fishInst:GetAttribute("MaxHealth")) or 100
			local barScaleX = 0.5
			local curPlayerHp = playerHpVal and playerHpVal.Value or 100
			local curProgress = fishInst:IsA("ValueBase") and fishInst.Value or 0
			local inFinalPhase = false
			local finalPhaseHp = 1
			while fishInst.Parent and (FishingGui and FishingGui.Visible) do
				lastBossActiveClock = os.clock()
				if playerHpVal then
					curPlayerHp = playerHpVal.Value
				end
				if fishInst:IsA("ValueBase") then
					curProgress = fishInst.Value
				end
				if fishInst:GetAttribute("FinalPhase") == true then
					inFinalPhase = true
				end
				if fishInst:GetAttribute("FinalPhaseHP") ~= nil then
					finalPhaseHp = tonumber(fishInst:GetAttribute("FinalPhaseHP")) or finalPhaseHp
				end
				if FishingBar then
					barScaleX = FishingBar.Position.X.Scale
				end
				task.wait(0.1)
			end
			task.wait(0.35)
			isInBossFight = false
			lastBossActiveClock = 0
			isMonitoringBoss = false
		end)
	end
	local function stepBossRoutine(char, isFishingUiOpen)
		if isFishingUiOpen then
			isInBossFight = true
			lastBossActiveClock = os.clock()
			startBossFightMonitor()
			return
		end
		local nowClock = os.clock()
		if nowClock - lastBossStepClock < 0.8 then
			return
		end
		lastBossStepClock = nowClock
		if isInBossFight and (nowClock - lastBossActiveClock > 45) then
			isInBossFight = false
		end
		local wantSecret = Config.AutoSecretBoss
		local rodVal = PlayerData and PlayerData:FindFirstChild("FishingRod")
		if not rodVal or rodVal.Value == "" then
			return
		end
		local bossModel, bossPart = FindBossTarget(wantSecret)
		local bossCf = GetBossCFrame(wantSecret)
		if not bossModel and not bossCf then
			return
		end
		local hrp = cachedHrp or (char and char:FindFirstChild("HumanoidRootPart"))
		local targetBossName = bossModel and (bossModel:GetAttribute("Name") or bossModel.Name) or (wantSecret and "Long DiaoHai" or "Enzo")
		if hrp then
			if bossCf then
				if (hrp.Position - bossCf.Position).Magnitude > 5 then
					hrp.CFrame = bossCf
				end
			elseif bossPart then
				local distToBoss = (hrp.Position - bossPart.Position).Magnitude
				if distToBoss > 12 then
					hrp.CFrame = bossPart.CFrame * CFrame.new(0, 3, -5)
				end
			end
		end
		if char and char:GetAttribute("Type") ~= "Fishing Rod" then
			pcall(function()
				ToggleHotbar:InvokeServer("1")
			end)
		end
		local bossMenu = GetBossMenuFrame()
		if not isInBossFight then
			if bossPart and hrp then
				local bossPrompt = bossModel and bossModel:FindFirstChildWhichIsA("ProximityPrompt", true)
				if not bossPrompt and bossPart then
					bossPrompt = bossPart:FindFirstChildWhichIsA("ProximityPrompt", true)
				end
				if bossPrompt and fireproximityprompt then
					pcall(function()
						fireproximityprompt(bossPrompt)
					end)
				end
			end
			if bossMenu and bossMenu.Visible then
				HandleBossDialogueChoice(bossMenu, targetBossName, Config.BossMode, wantSecret)
			end
			if MainGui and not isInBossFight then
				local menuGui = MainGui:FindFirstChild("Menu")
				local dialogueFrame = menuGui and menuGui:FindFirstChild("Dialogue")
				if dialogueFrame and dialogueFrame.Visible then
					local buttonFrame = dialogueFrame:FindFirstChild("ButtonFrame")
					if buttonFrame then
						local chosenOptionBtn = nil
						local desiredModeLower = string.lower(Config.BossMode or "Normal")
						for _, optBtn in ipairs(buttonFrame:GetChildren()) do
							if optBtn:IsA("TextButton") and optBtn.Name ~= "Template" and optBtn.Visible then
								local optTitle = optBtn:FindFirstChild("Title")
								local optText = optTitle and string.lower(optTitle.Text) or ""
								if string.find(optText, desiredModeLower) then
									chosenOptionBtn = optBtn
									break
								elseif
									not chosenOptionBtn
									and not string.find(optText, "close")
									and not string.find(optText, "cancel")
									and not string.find(optText, "nevermind")
									and not string.find(optText, "leave")
								then
									chosenOptionBtn = optBtn
								end
							end
						end
						if chosenOptionBtn then
							clickGuiElement(chosenOptionBtn)
						end
					end
				end
			end
		else
			if bossMenu and bossMenu.Visible then
				CloseBossDialogue(bossMenu)
			end
			if char and char:GetAttribute("Type") ~= "Fishing Rod" then
				pcall(function()
					ToggleHotbar:InvokeServer("1")
				end)
			end
		end
	end
	local lastMinigameEndClock = 0
	task.spawn(function()
		local lastCastClock = 0
		local lastReelClock = 0
		local lastSkillFireClock = 0
		local skillCycleIdx = 1
		local lastFiredSkill = nil
		local wasFishingVisible = false
		while task.wait(0.08) do
			local nowClock = os.clock()
			RefreshGuiCache()
			local isFishingVisible = FishingGui and FishingGui.Visible or false
			if wasFishingVisible and not isFishingVisible then
				lastMinigameEndClock = nowClock
			end
			wasFishingVisible = isFishingVisible
			local shouldReel = Config.AutoReel
				or Config.AutoMiniGame
				or Config.AutoBoss
				or Config.AutoSecretBoss
				or Config.AutoFarmIsland
			local shouldCast = Config.AutoCast or Config.AutoFarmIsland
			local shouldUseSkill = Config.AutoSkill or Config.AutoBoss or Config.AutoSecretBoss or Config.AutoFarmIsland
			if not isFishingVisible then
				skillCycleIdx = 1
				lastFiredSkill = nil
			end
			if shouldReel and isFishingVisible and (nowClock - lastReelClock >= (Config.ReelDelay or 0.35)) then
				lastReelClock = nowClock
				pcall(function()
					UpdateFishProgression:FireServer()
				end)
			end
			if shouldUseSkill and isFishingVisible then
				local char = cachedChar
				local skillOrder = Config.SkillOrder
				local skillCount = type(skillOrder) == "table" and #skillOrder or 0
				if char and skillCount > 0 then
					if skillCycleIdx < 1 or skillCycleIdx > skillCount then
						skillCycleIdx = 1
					end
					local readyIdx = nil
					for offsetIdx = 1, skillCount do
						local candidateIdx = ((skillCycleIdx - 1 + (offsetIdx - 1)) % skillCount) + 1
						local candidateKey = skillOrder[candidateIdx]
						if IsSkillKeyReady(char, candidateKey) then
							readyIdx = candidateIdx
							break
						end
					end
					if readyIdx then
						skillCycleIdx = readyIdx
						local activeSkillKey = skillOrder[skillCycleIdx]
						if IsGameAllowingSkill(char) and (nowClock - lastSkillFireClock >= 0.25) then
							lastSkillFireClock = os.clock()
							lastFiredSkill = activeSkillKey
							pcall(function()
								UseSkill:FireServer(activeSkillKey)
							end)
							skillCycleIdx = (skillCycleIdx % skillCount) + 1
						end
					else
						for scanIdx = 1, skillCount do
							local nextIdx = ((skillCycleIdx - 1 + (scanIdx - 1)) % skillCount) + 1
							if IsSkillSlotAvailable(char, skillOrder[nextIdx]) and not IsSkillOnCooldown(char, skillOrder[nextIdx]) then
								skillCycleIdx = nextIdx
								break
							end
						end
					end
				end
			end
			if Config.AutoBoss or Config.AutoSecretBoss then
				stepBossRoutine(cachedChar, isFishingVisible)
			else
				if not isFishingVisible then
					StepAutoTPPos(cachedChar)
					StepAutoFarmIsland(cachedChar)
				end
				if shouldCast and not isFishingVisible then
					local castCooldown = (Config.AutoCastMethod == "Instant") and 0.05
						or math.clamp(tonumber(Config.CastDelay) or 1, 0, 10)
					if (nowClock - lastMinigameEndClock >= castCooldown) and (nowClock - lastCastClock >= castCooldown) then
						local char = cachedChar
						if char then
							if char:GetAttribute("Type") ~= "Fishing Rod" then
								lastCastClock = nowClock
								pcall(function()
									ToggleHotbar:InvokeServer("1")
								end)
							elseif not char:GetAttribute("Fishing") then
								local hrp = cachedHrp or char:FindFirstChild("HumanoidRootPart")
								if hrp then
									lastCastClock = nowClock
									pcall(function()
										FishingEvent:FireServer(hrp.CFrame)
									end)
								end
							end
						end
					end
				end
			end
		end
	end)
	listenRemote("Slam", function(slamRemote)
		if
			(Config.AutoMiniGame or Config.AutoReel or Config.AutoBoss or Config.AutoSecretBoss or Config.AutoFarmIsland)
			and slamRemote
		then
			task.wait(0.05)
			local slamHandled = false
			pcall(function()
				local trashCanGui = FishingGui and FishingGui:FindFirstChild("TrashCan")
				local slamFrame = trashCanGui and trashCanGui:FindFirstChild("Slam")
				local slamBtn = slamFrame and slamFrame:FindFirstChild("Button")
				local slamLine = slamBtn and slamBtn:FindFirstChild("Line")
				if slamLine then
					slamLine.Size = UDim2.new(1, 0, 1, 0)
				end
				if slamBtn then
					clickGuiElement(slamBtn)
					if not slamFrame.Parent then
						slamHandled = true
					end
				end
				if not slamHandled then
					slamRemote:FireServer("Perfect")
					if slamFrame and slamFrame.Parent then
						slamFrame:Destroy()
					end
				end
			end)
		end
	end)
	listenRemote("Charge", function(chargeRemote)
		if
			(Config.AutoMiniGame or Config.AutoReel or Config.AutoBoss or Config.AutoSecretBoss or Config.AutoFarmIsland)
			and chargeRemote
		then
			task.wait(1.05)
			pcall(function()
				local trashCanGui = FishingGui and FishingGui:FindFirstChild("TrashCan")
				local chargeFrame = trashCanGui and trashCanGui:FindFirstChild("Charge")
				local chargeBtn = chargeFrame and chargeFrame:FindFirstChild("Button")
				if chargeBtn and chargeFrame.Parent then
					clickGuiElement(chargeBtn)
				end
				if chargeFrame and chargeFrame.Parent then
					chargeRemote:FireServer()
					chargeFrame:Destroy()
				end
			end)
		end
	end)
	local function ClearPlayerESP()
		for _, plr in ipairs(Players:GetPlayers()) do
			local plrChar = plr.Character
			if plrChar then
				local headPart = plrChar:FindFirstChild("Head")
				if headPart then
					local espGui = headPart:FindFirstChild("MosESP")
					if espGui then
						espGui:Destroy()
					end
				end
			end
		end
	end
	local function UpdatePlayerESP()
		if not Config.ESPEnabled then
			return
		end
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				local plrChar = plr.Character
				if plrChar then
					local headPart = plrChar:FindFirstChild("Head")
					local plrHum = plrChar:FindFirstChildOfClass("Humanoid")
					if headPart and plrHum then
						local espGui = headPart:FindFirstChild("MosESP")
						if plrHum.Health > 0 then
							if not espGui then
								espGui = Instance.new("BillboardGui")
								espGui.Name = "MosESP"
								espGui.Adornee = headPart
								espGui.Size = UDim2.new(0, 200, 0, 25)
								espGui.StudsOffset = Vector3.new(0, 2.5, 0)
								espGui.AlwaysOnTop = true
								espGui.MaxDistance = math.huge
								local nameLabel = Instance.new("TextLabel")
								nameLabel.Name = "NameText"
								nameLabel.Parent = espGui
								nameLabel.Size = UDim2.new(1, 0, 1, 0)
								nameLabel.BackgroundTransparency = 1
								nameLabel.TextScaled = false
								nameLabel.TextSize = 13
								nameLabel.Font = Enum.Font.GothamBold
								nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
								nameLabel.TextStrokeTransparency = 0
								nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
								nameLabel.TextXAlignment = Enum.TextXAlignment.Center
								espGui.Parent = headPart
							end
							espGui.NameText.Text = plr.DisplayName
						else
							if espGui then
								espGui:Destroy()
							end
						end
					end
				end
			end
		end
	end
	task.spawn(function()
		while task.wait(0.4) do
			if Config.ESPEnabled then
				UpdatePlayerESP()
			end
		end
	end)
	local lastAutoSellClock = 0
	local lastAutoBuyBaitClock = 0
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	local function findRemote(remoteName)
		return Events:FindFirstChild(remoteName) or (remotesFolder and remotesFolder:FindFirstChild(remoteName))
	end
	local function invokeOrFireRemote(remoteObj, ...)
		if not remoteObj then
			return false
		end
		local callArgs = { ... }
		local callOk = pcall(function()
			if remoteObj:IsA("RemoteEvent") then
				remoteObj:FireServer(unpack(callArgs))
			elseif remoteObj:IsA("RemoteFunction") then
				remoteObj:InvokeServer(unpack(callArgs))
			end
		end)
		return callOk
	end
	local function DoBuyBait(baitName, buyCount)
		if not baitName or baitName == "" then
			return
		end
		local clampedAmount = math.max(1, math.floor(tonumber(buyCount) or 1))
		local buyRemote = findRemote("BuyBait")
			or findRemote("Bait")
			or findRemote("PurchaseBait")
			or findRemote("BaitShop")
			or findRemote("BuyItem")
		if buyRemote then
			invokeOrFireRemote(buyRemote, baitName, clampedAmount)
		else
			pcall(function()
				CraftBaitEvent:FireServer(baitName, clampedAmount)
			end)
		end
	end
	task.spawn(function()
		while task.wait(0.8) do
			if Config.AutoSell then
				local nowClock = os.clock()
				local canSellNow = false
				if Config.AutoSellMethod == "Spam" then
					canSellNow = (nowClock - lastAutoSellClock >= 1)
				elseif Config.AutoSellMethod == "Sell When Full Inventory" then
					canSellNow = (nowClock - lastAutoSellClock >= 1.5) and (Hub.IsInventoryFull ~= nil) and Hub.IsInventoryFull()
				else
					canSellNow = (nowClock - lastAutoSellClock >= (math.clamp(tonumber(Config.SellDelay) or 1, 1, 10) * 60))
				end
				if canSellNow then
					lastAutoSellClock = nowClock
					pcall(function()
						SellFish:FireServer("All")
					end)
				end
			end
			if Config.AutoBuyBait and Config.SelectedBuyBait ~= "" then
				local buyIntervalSec = math.max(1, tonumber(Config.BuyBaitDelay) or 1) * 60
				local nowClock = os.clock()
				if nowClock - lastAutoBuyBaitClock >= buyIntervalSec then
					lastAutoBuyBaitClock = nowClock
					DoBuyBait(Config.SelectedBuyBait, Config.BuyBaitAmount)
				end
			end
			if Config.AutoCraftBait and Config.SelectedBait ~= "" then
				pcall(function()
					CraftBaitEvent:FireServer(Config.SelectedBait, math.max(1, math.floor(tonumber(Config.BaitAmount) or 1)))
				end)
			end
			if Config.AutoCraftRod and Config.SelectedRod ~= "" then
				pcall(function()
					CraftRodEvent:FireServer(Config.SelectedRod)
				end)
			end
		end
	end)
	local lastTicketActionTick = 0
	local ChooseDialogueOption = Events:WaitForChild("ChooseDialogueOption", 5)
	local function HideTicketDialogueUI()
		local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
		local mainGui = playerGui and playerGui:FindFirstChild("MainGui")
		local menuGui = mainGui and mainGui:FindFirstChild("Menu")
		local dialogueGui = menuGui and menuGui:FindFirstChild("Dialogue")
		if dialogueGui and dialogueGui.Visible then
			local titleObj = dialogueGui:FindFirstChild("Name", true)
				or dialogueGui:FindFirstChild("NPCName", true)
				or dialogueGui:FindFirstChild("Title", true)
			local speakerName = titleObj and tostring(titleObj.Text) or ""
			if speakerName == "" or string.find(speakerName, "Ticket", 1, true) or string.find(speakerName, "Giver", 1, true) then
				dialogueGui.Visible = false
			end
		end
	end
	local function GetTicketGiverObject()
		local npcFolder = workspace:FindFirstChild("NPC")
		local funcFolder = npcFolder and npcFolder:FindFirstChild("Function")
		local ticketGiver = funcFolder and funcFolder:FindFirstChild("Ticket Quest Giver")
		if ticketGiver then
			return ticketGiver
		end
		return nil
	end
	local function GetActiveTicketQuest()
		local pData = PlayerData
		if not pData then
			return nil
		end
		local questFolder = pData:FindFirstChild("Quest")
		local mainQuestFolder = questFolder and questFolder:FindFirstChild("Main")
		if mainQuestFolder then
			local ticketQuestObj = mainQuestFolder:FindFirstChild("Hard Ticket Quest")
				or mainQuestFolder:FindFirstChild("Easy Ticket Quest")
				or mainQuestFolder:FindFirstChild("Ticket Quest")
			if ticketQuestObj then
				return ticketQuestObj
			end
		end
		for _, childFolder in ipairs(pData:GetChildren()) do
			if
				childFolder:IsA("Folder")
				and (
					childFolder.Name == "Hard Ticket Quest"
					or childFolder.Name == "Easy Ticket Quest"
					or childFolder.Name == "Ticket Quest"
				)
			then
				return childFolder
			end
		end
		return nil
	end
	local function IsTicketQuestCompleted(questObj)
		if not questObj then
			return false
		end
		local mainQuestInfo = Info and Info:FindFirstChild("MainQuest")
		local questDef = nil
		if mainQuestInfo and mainQuestInfo:FindFirstChild(questObj.Name) then
			pcall(function()
				questDef = require(mainQuestInfo[questObj.Name])
			end)
		end
		local hasProgressValues = false
		for _, progVal in ipairs(questObj:GetChildren()) do
			if progVal:IsA("NumberValue") then
				hasProgressValues = true
				local targetGoal = nil
				if questDef and questDef[tonumber(progVal.Name)] then
					targetGoal = tonumber(questDef[tonumber(progVal.Name)][2])
				elseif questObj:FindFirstChild("Objective") then
					local objVal = questObj.Objective:FindFirstChild(progVal.Name)
					if objVal and objVal:IsA("StringValue") then
						local splitParts = string.split(objVal.Value, ",")
						targetGoal = tonumber(splitParts[2])
					end
				end
				if targetGoal and progVal.Value < targetGoal then
					return false
				end
			end
		end
		return hasProgressValues
	end
	local function GetTicketQuestStatus()
		local activeQuest = GetActiveTicketQuest()
		if not activeQuest then
			return "none"
		end
		if IsTicketQuestCompleted(activeQuest) then
			return "completed"
		else
			return "in_progress"
		end
	end
	local StepSmartTicketQuest
	do
		local ticketCooldownUntil = 0
		local lastTicketAcceptClock = 0
		local lastTicketTalkClock = 0
		local lastCooldownMsg = ""
		local isTicketLimitReached = false
		local lastLimitNotifyClock = 0
		function Hub.ResetTicketLimit()
			isTicketLimitReached = false
			lastLimitNotifyClock = 0
		end
		local function isDailyTicketLimitText(msgText)
			if not msgText or msgText == "" then
				return false
			end
			local lowerMsg = string.lower(msgText)
			return string.find(lowerMsg, "hit the daily limit of 20 ticket quests", 1, true) ~= nil
				and string.find(lowerMsg, "come back tomorrow", 1, true) ~= nil
		end
		local function handleTicketLimitReached()
			if isTicketLimitReached then
				return
			end
			isTicketLimitReached = true
			Config.AutoTicketQuest = false
			SaveConfig()
			if Hub.TicketToggle then
				pcall(function()
					Hub.TicketToggle:SetValue(false)
				end)
			end
			local nowClock = os.clock()
			if nowClock - lastLimitNotifyClock >= 5 then
				lastLimitNotifyClock = nowClock
				pcall(function()
					Fluent:Notify({
						Title = "Ticket Quest",
						Content = "Daily limit of 20 ticket quests reached",
						Duration = 4,
					})
				end)
			end
		end
		local function parseQuestCooldownSeconds(msgText)
			if not msgText or msgText == "" then
				return nil
			end
			local lowerMsg = string.lower(msgText)
			if string.find(lowerMsg, "another quest in") or string.find(lowerMsg, "take another quest in") then
				local minsStr, secsStr = string.match(lowerMsg, "(%d+)%s*:%s*(%d+)")
				if minsStr and secsStr then
					return (tonumber(minsStr) or 0) * 60 + (tonumber(secsStr) or 0)
				end
				local minMatch = string.match(lowerMsg, "(%d+)%s*m")
				local secMatch = string.match(lowerMsg, "(%d+)%s*s")
				if minMatch or secMatch then
					return (tonumber(minMatch) or 0) * 60 + (tonumber(secMatch) or 0)
				end
			end
			return nil
		end
		local function inspectTicketMessage(msgText)
			if not Config.AutoTicketQuest or not msgText or msgText == "" or isTicketLimitReached or #msgText > 300 then
				return
			end
			if isDailyTicketLimitText(msgText) then
				if Config.AutoTicketQuest then
					handleTicketLimitReached()
				end
				return
			end
			if msgText == lastCooldownMsg then
				return
			end
			local cooldownSec = parseQuestCooldownSeconds(msgText)
			if cooldownSec and cooldownSec > 0 and cooldownSec <= 3600 then
				lastCooldownMsg = msgText
				ticketCooldownUntil = os.clock() + cooldownSec
			end
		end
		local function requestTicketDialogue(giverNpc)
			local targetNpc = giverNpc or GetTicketGiverObject()
			if not targetNpc then
				return
			end
			local dialogueArgs = { [1] = "Ticket Quest Giver", [2] = 1, [3] = "Quest", [4] = { [1] = targetNpc } }
			pcall(function()
				if ChooseDialogueOption then
					ChooseDialogueOption:FireServer(unpack(dialogueArgs))
				end
			end)
			HideTicketDialogueUI()
			lastTicketTalkClock = os.clock()
		end
		local function acceptTicketQuest(giverNpc)
			local targetNpc = giverNpc or GetTicketGiverObject()
			if not targetNpc then
				return
			end
			local acceptAction = (Config.TicketQuestMode == "Easy") and "EasyAcceptQuest" or "HardAcceptQuest"
			local optionIndex = (Config.TicketQuestMode == "Easy") and 1 or 2
			local acceptArgs =
				{ [1] = "Ticket Quest Giver", [2] = optionIndex, [3] = acceptAction, [4] = { [1] = targetNpc, [2] = "Ticket Quest" } }
			pcall(function()
				if ChooseDialogueOption then
					ChooseDialogueOption:FireServer(unpack(acceptArgs))
				end
			end)
			HideTicketDialogueUI()
			lastTicketAcceptClock = os.clock()
		end
		function StepSmartTicketQuest()
			if isTicketLimitReached then
				return
			end
			local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
			local mainGui = playerGui and playerGui:FindFirstChild("MainGui")
			local menuGui = mainGui and mainGui:FindFirstChild("Menu")
			local dialogueGui = menuGui and menuGui:FindFirstChild("Dialogue")
			if dialogueGui and dialogueGui.Visible then
				for _, descLabel in ipairs(dialogueGui:GetDescendants()) do
					if descLabel:IsA("TextLabel") and isDailyTicketLimitText(descLabel.Text) then
						handleTicketLimitReached()
						HideTicketDialogueUI()
						return
					end
				end
			end
			local nowClock = os.clock()
			if nowClock < ticketCooldownUntil then
				return
			end
			local giverNpc = GetTicketGiverObject()
			if not giverNpc then
				return
			end
			local questStatus = GetTicketQuestStatus()
			if questStatus == "completed" then
				if nowClock - lastTicketTalkClock >= 1.5 then
					requestTicketDialogue(giverNpc)
					task.wait(0.5)
					acceptTicketQuest(giverNpc)
				end
			elseif questStatus == "in_progress" then
				return
			else
				if nowClock >= ticketCooldownUntil and (nowClock - lastTicketAcceptClock >= 2) then
					requestTicketDialogue(giverNpc)
					task.wait(0.4)
					acceptTicketQuest(giverNpc)
				end
			end
		end
		pcall(function()
			local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
			if playerGui then
				playerGui.DescendantAdded:Connect(function(descObj)
					if descObj:IsA("TextLabel") then
						inspectTicketMessage(descObj.Text)
						descObj:GetPropertyChangedSignal("Text"):Connect(function()
							inspectTicketMessage(descObj.Text)
						end)
					end
				end)
			end
		end)
		pcall(function()
			for _, remoteEvent in ipairs(Events:GetChildren()) do
				if remoteEvent:IsA("RemoteEvent") then
					remoteEvent.OnClientEvent:Connect(function(...)
						local eventArgs = { ... }
						for _, argVal in ipairs(eventArgs) do
							if type(argVal) == "string" then
								inspectTicketMessage(argVal)
							elseif type(argVal) == "table" then
								for _, subVal in pairs(argVal) do
									if type(subVal) == "string" then
										inspectTicketMessage(subVal)
									end
								end
							end
						end
					end)
				end
			end
		end)
		pcall(function()
			local startDialogueEvent = Events:FindFirstChild("StartDialogue")
			if startDialogueEvent and startDialogueEvent:IsA("RemoteEvent") then
				startDialogueEvent.OnClientEvent:Connect(function(npcName, npcObj, dialogueLines)
					if not Config.AutoTicketQuest or isTicketLimitReached then
						return
					end
					if tostring(npcName) == "Ticket Quest Giver" or (npcObj and npcObj.Name == "Ticket Quest Giver") then
						HideTicketDialogueUI()
						if type(dialogueLines) == "table" and type(dialogueLines[1]) == "string" then
							inspectTicketMessage(dialogueLines[1])
						end
					end
				end)
			end
		end)
	end
	local function GetZengTianguoPart()
		local npcFolder = workspace:FindFirstChild("NPC")
		local funcFolder = npcFolder and npcFolder:FindFirstChild("Function")
		local zengNpc = funcFolder and funcFolder:FindFirstChild("Zeng Tianguo")
		if zengNpc then
			return zengNpc
		end
		return nil
	end
	local function GetActiveZengTianguoQuest()
		local pData = PlayerData or (DataFolder and DataFolder:FindFirstChild(tostring(LocalPlayer.UserId)))
		if not pData then
			return nil
		end
		local questFolder = pData:FindFirstChild("Quest")
		local mainQuestFolder = questFolder and questFolder:FindFirstChild("Main")
		local searchContainers = { mainQuestFolder, questFolder, pData }
		for _, container in ipairs(searchContainers) do
			if container then
				for _, childObj in ipairs(container:GetChildren()) do
					if childObj:IsA("Folder") or childObj:IsA("Configuration") then
						local lowerName = string.lower(childObj.Name)
						if string.find(lowerName, "zeng", 1, true) and string.find(lowerName, "tianguo", 1, true) then
							return childObj
						end
					end
				end
			end
		end
		local mainGui = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainGui")
		local mainQuestUi = mainGui
			and mainGui:FindFirstChild("Menu")
			and mainGui.Menu:FindFirstChild("Quest")
			and mainGui.Menu.Quest:FindFirstChild("Menu")
			and mainGui.Menu.Quest.Menu:FindFirstChild("Main_Quest")
		if mainQuestUi then
			for _, questItemUi in ipairs(mainQuestUi:GetChildren()) do
				if questItemUi:IsA("GuiObject") and questItemUi.Visible and questItemUi.Name ~= "Template" then
					local lowerUiName = string.lower(questItemUi.Name)
					if string.find(lowerUiName, "zeng", 1, true) and string.find(lowerUiName, "tianguo", 1, true) then
						if mainQuestFolder then
							return mainQuestFolder:FindFirstChild(questItemUi.Name) or questItemUi
						end
						return questItemUi
					end
				end
			end
		end
		return nil
	end
	local function IsZengTianguoQuestCompleted(questObj)
		if not questObj then
			return false
		end
		local mainQuestInfo = Info and Info:FindFirstChild("MainQuest")
		local questDef = nil
		if mainQuestInfo then
			local questMod = mainQuestInfo:FindFirstChild(questObj.Name)
				or mainQuestInfo:FindFirstChild("Zeng Tianguo")
				or mainQuestInfo:FindFirstChild("Zeng Tianguo Quest")
			if questMod then
				pcall(function()
					questDef = require(questMod)
				end)
			end
		end
		local foundNumberVal = false
		for _, progVal in ipairs(questObj:GetChildren()) do
			if progVal:IsA("NumberValue") then
				foundNumberVal = true
				local targetGoal = nil
				if questDef and questDef[tonumber(progVal.Name)] then
					targetGoal = tonumber(questDef[tonumber(progVal.Name)][2])
				elseif questObj:FindFirstChild("Objective") then
					local objVal = questObj.Objective:FindFirstChild(progVal.Name)
					if objVal and objVal:IsA("StringValue") then
						local splitParts = string.split(objVal.Value, ",")
						targetGoal = tonumber(splitParts[2])
					end
				end
				if targetGoal and progVal.Value < targetGoal then
					return false
				end
			end
		end
		if not foundNumberVal then
			local mainGui = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainGui")
			local mainQuestUi = mainGui
				and mainGui:FindFirstChild("Menu")
				and mainGui.Menu:FindFirstChild("Quest")
				and mainGui.Menu.Quest:FindFirstChild("Menu")
				and mainGui.Menu.Quest.Menu:FindFirstChild("Main_Quest")
			local zengUiItem = mainQuestUi
				and (
					mainQuestUi:FindFirstChild(questObj.Name)
					or mainQuestUi:FindFirstChild("Zeng Tianguo")
					or mainQuestUi:FindFirstChild("Zeng Tianguo Quest")
				)
			if zengUiItem then
				local questListFrame = zengUiItem:FindFirstChild("Quest")
				if questListFrame then
					local allGreen = true
					local hasLabels = false
					for _, labelObj in ipairs(questListFrame:GetChildren()) do
						if labelObj:IsA("TextLabel") and labelObj.Name ~= "Title" and labelObj.Visible then
							hasLabels = true
							if labelObj.TextColor3 ~= Color3.fromRGB(144, 255, 110) then
								allGreen = false
								break
							end
						end
					end
					if hasLabels then
						return allGreen
					end
				end
			end
		end
		return foundNumberVal
	end
	local function HideZengTianguoDialogueUI()
		local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
		local mainGui = playerGui and playerGui:FindFirstChild("MainGui")
		local menuGui = mainGui and mainGui:FindFirstChild("Menu")
		local dialogueGui = menuGui and menuGui:FindFirstChild("Dialogue")
		if dialogueGui and dialogueGui.Visible then
			local titleObj = dialogueGui:FindFirstChild("Name", true)
				or dialogueGui:FindFirstChild("NPCName", true)
				or dialogueGui:FindFirstChild("Title", true)
			local speakerText = titleObj and tostring(titleObj.Text) or ""
			if speakerText == "" or string.find(speakerText, "Zeng", 1, true) or string.find(speakerText, "Tianguo", 1, true) then
				dialogueGui.Visible = false
			end
		end
	end
	local StepSmartZengTianguoQuest
	do
		local lastZengActionClock = 0
		local function isSkill100ZengQuest(questObj)
			local mainGui = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainGui")
			local menuGui = mainGui and mainGui:FindFirstChild("Menu")
			local questGui = menuGui and menuGui:FindFirstChild("Quest")
			local questSubMenu = questGui and questGui:FindFirstChild("Menu")
			local mainQuestList = questSubMenu and questSubMenu:FindFirstChild("Main_Quest")
			local questTargetName = questObj and questObj.Name or "Zeng Tianguo Quest"
			local questEntryUi = mainQuestList
				and (
					mainQuestList:FindFirstChild(questTargetName)
					or mainQuestList:FindFirstChild("Zeng Tianguo")
					or mainQuestList:FindFirstChild("Zeng Tianguo Quest")
				)
			if not questEntryUi and mainQuestList then
				for _, entryChild in ipairs(mainQuestList:GetChildren()) do
					if entryChild:IsA("GuiObject") and entryChild.Visible and entryChild.Name ~= "Template" then
						local lowerEntryName = string.lower(entryChild.Name)
						if string.find(lowerEntryName, "zeng", 1, true) and string.find(lowerEntryName, "tianguo", 1, true) then
							questEntryUi = entryChild
							break
						end
					end
				end
			end
			if questEntryUi then
				for _, descLabel in ipairs(questEntryUi:GetDescendants()) do
					if descLabel:IsA("TextLabel") and descLabel.Visible then
						local lowerText = string.lower(descLabel.Text)
						if
							string.find(lowerText, "use any skill", 1, true) or string.find(lowerText, "skill for 100", 1, true)
						then
							return true
						end
					end
				end
				return false
			end
			if not questObj then
				return false
			end
			local mainQuestInfo = Info and Info:FindFirstChild("MainQuest")
			local questModData = nil
			if mainQuestInfo then
				local questModScript = mainQuestInfo:FindFirstChild(questObj.Name)
					or mainQuestInfo:FindFirstChild("Zeng Tianguo")
					or mainQuestInfo:FindFirstChild("Zeng Tianguo Quest")
				if questModScript then
					pcall(function()
						questModData = require(questModScript)
					end)
				end
			end
			if questModData and type(questModData) == "table" then
				for _, entryData in pairs(questModData) do
					if type(entryData) == "table" then
						local joinedText = string.lower(table.concat(entryData, " "))
						if
							string.find(joinedText, "use any skill", 1, true) or string.find(joinedText, "skill for 100", 1, true)
						then
							return true
						end
					elseif type(entryData) == "string" then
						local lowerEntryStr = string.lower(entryData)
						if
							string.find(lowerEntryStr, "use any skill", 1, true) or string.find(lowerEntryStr, "skill for 100", 1, true)
						then
							return true
						end
					end
				end
			end
			local objFolder = questObj:FindFirstChild("Objective")
			if objFolder then
				for _, objChild in ipairs(objFolder:GetChildren()) do
					local combinedText = string.lower(tostring(objChild.Name) .. " " .. tostring(objChild.Value))
					if string.find(combinedText, "use any skill", 1, true) or string.find(combinedText, "skill for 100", 1, true) then
						return true
					end
				end
			end
			for _, questChild in ipairs(questObj:GetChildren()) do
				local lowerChildName = string.lower(tostring(questChild.Name))
				if string.find(lowerChildName, "use any skill", 1, true) or string.find(lowerChildName, "skill for 100", 1, true) then
					return true
				end
				if questChild:IsA("StringValue") then
					local lowerChildVal = string.lower(tostring(questChild.Value))
					if string.find(lowerChildVal, "use any skill", 1, true) or string.find(lowerChildVal, "skill for 100", 1, true) then
						return true
					end
				end
			end
			return false
		end
		local function cancelZengQuest(unusedQuestArg)
			pcall(function()
				local cancelRemote = Events:WaitForChild("CancelQuest", 3)
				if cancelRemote then
					cancelRemote:FireServer("Zeng Tianguo Quest")
				end
			end)
			local mainGui = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainGui")
			local menuGui = mainGui and mainGui:FindFirstChild("Menu")
			local questGui = menuGui and menuGui:FindFirstChild("Quest")
			local questSubMenu = questGui and questGui:FindFirstChild("Menu")
			local mainQuestList = questSubMenu and questSubMenu:FindFirstChild("Main_Quest")
			local uiCandidates = {
				mainQuestList and mainQuestList:FindFirstChild("Zeng Tianguo Quest"),
				mainQuestList and mainQuestList:FindFirstChild("Zeng Tianguo"),
				questSubMenu and questSubMenu:FindFirstChild("Zeng Tianguo Quest"),
				questSubMenu and questSubMenu:FindFirstChild("Zeng Tianguo"),
				questGui and questGui:FindFirstChild("Zeng Tianguo Quest"),
				questGui and questGui:FindFirstChild("Zeng Tianguo"),
			}
			for _, uiNode in ipairs(uiCandidates) do
				if uiNode then
					for _, descBtn in ipairs(uiNode:GetDescendants()) do
						if descBtn:IsA("TextButton") or descBtn:IsA("ImageButton") then
							local btnText = descBtn:IsA("TextButton") and string.lower(descBtn.Text) or ""
							local btnName = string.lower(descBtn.Name)
							if string.find(btnText, "cancel", 1, true) or string.find(btnName, "cancel", 1, true) then
								clickGuiElement(descBtn)
							end
						end
					end
				end
			end
		end
		local function talkAndAcceptZengQuest(zengNpc)
			local targetNpc = zengNpc or GetZengTianguoPart()
			if not targetNpc then
				return
			end
			local questTalkArgs = { [1] = "Zeng Tianguo", [2] = 1, [3] = "Quest", [4] = { [1] = targetNpc } }
			local acceptQuestArgs = {
				[1] = "Zeng Tianguo",
				[2] = 1,
				[3] = "AcceptQuest",
				[4] = { [1] = targetNpc, [2] = "Zeng Tianguo Quest" },
			}
			pcall(function()
				if ChooseDialogueOption then
					ChooseDialogueOption:FireServer(unpack(questTalkArgs))
				end
			end)
			task.wait(0.3)
			pcall(function()
				if ChooseDialogueOption then
					ChooseDialogueOption:FireServer(unpack(acceptQuestArgs))
				end
			end)
			HideZengTianguoDialogueUI()
			lastZengActionClock = os.clock()
		end
		function StepSmartZengTianguoQuest()
			local nowClock = os.clock()
			if nowClock - lastZengActionClock < 3 then
				return
			end
			local activeQuest = GetActiveZengTianguoQuest()
			if activeQuest then
				if Config.AutoFilterZengQuest and not isSkill100ZengQuest(activeQuest) then
					cancelZengQuest(activeQuest)
					lastZengActionClock = nowClock
					task.wait(0.3)
					local zengNpc = GetZengTianguoPart()
					if zengNpc then
						talkAndAcceptZengQuest(zengNpc)
					end
					return
				end
				if IsZengTianguoQuestCompleted(activeQuest) then
					local zengNpc = GetZengTianguoPart()
					if zengNpc then
						talkAndAcceptZengQuest(zengNpc)
					end
				end
				return
			end
			local zengNpc = GetZengTianguoPart()
			if zengNpc then
				talkAndAcceptZengQuest(zengNpc)
			end
		end
		pcall(function()
			local startDialogueEvent = Events:FindFirstChild("StartDialogue")
			if startDialogueEvent and startDialogueEvent:IsA("RemoteEvent") then
				startDialogueEvent.OnClientEvent:Connect(function(npcName, npcObj)
					if not (Config.AutoZengTianguoQuest or Config.AutoFilterZengQuest) then
						return
					end
					if tostring(npcName) == "Zeng Tianguo" or (npcObj and npcObj.Name == "Zeng Tianguo") then
						HideZengTianguoDialogueUI()
					end
				end)
			end
		end)
	end
	local StepAutoEquipBestBait
	do
		local function cleanBaitName(rawBaitName)
			if not rawBaitName or rawBaitName == "" then
				return ""
			end
			local basePart = string.split(rawBaitName, "|")[1] or rawBaitName
			return string.gsub(basePart, "^%s*(.-)%s*$", "%1")
		end
		local function getBaitItemCount(baitItem)
			if not baitItem then
				return 0
			end
			local itemCount = 0
			pcall(function()
				if baitItem:IsA("ValueBase") then
					itemCount = tonumber(baitItem.Value) or 0
				end
			end)
			if itemCount and itemCount > 0 then
				return itemCount
			end
			pcall(function()
				local qtyChild = baitItem:FindFirstChild("Quantity")
					or baitItem:FindFirstChild("Count")
					or baitItem:FindFirstChild("Value")
					or baitItem:FindFirstChild("Amount")
				if qtyChild and qtyChild:IsA("ValueBase") then
					itemCount = tonumber(qtyChild.Value) or 0
				end
			end)
			if itemCount and itemCount > 0 then
				return itemCount
			end
			pcall(function()
				local qtyAttr = baitItem:GetAttribute("Quantity")
					or baitItem:GetAttribute("Count")
					or baitItem:GetAttribute("Amount")
					or baitItem:GetAttribute("Value")
				if qtyAttr then
					itemCount = tonumber(qtyAttr) or 0
				end
			end)
			if itemCount and itemCount > 0 then
				return itemCount
			end
			pcall(function()
				if baitItem:IsA("BoolValue") and baitItem.Value == true then
					itemCount = 1
				end
			end)
			return itemCount or 0
		end
		local function getBaitLuck(baitName)
			local baitInfoFolder = Info and Info:FindFirstChild("Bait")
			if not baitInfoFolder or not baitName or baitName == "" then
				return 0
			end
			local baitMod = baitInfoFolder:FindFirstChild(baitName)
			if not baitMod or not baitMod:IsA("ModuleScript") then
				return 0
			end
			local luckVal = 0
			local reqOk, baitData = pcall(require, baitMod)
			if reqOk and type(baitData) == "table" and baitData.Luck ~= nil then
				local parsedLuck = tonumber(baitData.Luck)
				if not parsedLuck then
					local luckStr = tostring(baitData.Luck)
					local numMatch = string.match(luckStr, "%d+%.?%d*")
					parsedLuck = tonumber(numMatch)
				end
				luckVal = parsedLuck or 0
			end
			return luckVal
		end
		local function findBestOwnedBait()
			local pData = PlayerData
			if not pData then
				return nil
			end
			local baitInfoFolder = Info and Info:FindFirstChild("Bait")
			if not baitInfoFolder then
				return nil
			end
			local bestBaitName = nil
			local bestRawName = nil
			local bestLuck = -1
			local bestQty = 0
			local bestSource = nil
			local bestInst = nil
			local function evaluateBaitCandidate(rawName, qty, instObj, sourceName)
				local numQty = tonumber(qty) or 0
				if numQty > 0 then
					local cleanName = cleanBaitName(rawName)
					if baitInfoFolder:FindFirstChild(cleanName) then
						local luckScore = getBaitLuck(cleanName)
						if luckScore > bestLuck then
							bestLuck = luckScore
							bestBaitName = cleanName
							bestRawName = rawName
							bestQty = numQty
							bestSource = sourceName
							bestInst = instObj
						elseif not bestBaitName then
							bestBaitName = cleanName
							bestRawName = rawName
							bestQty = numQty
							bestSource = sourceName
							bestInst = instObj
						end
					end
				end
			end
			local baitFolder = pData:FindFirstChild("Bait")
			if baitFolder then
				for _, baitChild in ipairs(baitFolder:GetChildren()) do
					local childQty = getBaitItemCount(baitChild)
					if childQty > 0 then
						evaluateBaitCandidate(baitChild.Name, childQty, baitChild, "Bait")
					end
				end
			end
			local invFolder = pData:FindFirstChild("Inventory")
			if invFolder then
				for _, invChild in ipairs(invFolder:GetChildren()) do
					local cleanInvName = cleanBaitName(invChild.Name)
					if baitInfoFolder:FindFirstChild(cleanInvName) then
						local invQty = getBaitItemCount(invChild)
						if invQty <= 0 then
							invQty = 1
						end
						evaluateBaitCandidate(invChild.Name, invQty, invChild, "Inventory")
					end
				end
			end
			return bestBaitName, bestRawName, bestLuck, bestQty, bestSource, bestInst
		end
		local baitImageToNameMap = {}
		local function buildBaitImageMap()
			local baitInfoFolder = Info and Info:FindFirstChild("Bait")
			if not baitInfoFolder then
				return
			end
			for _, baitMod in ipairs(baitInfoFolder:GetChildren()) do
				if baitMod:IsA("ModuleScript") then
					local reqOk, baitData = pcall(require, baitMod)
					if reqOk and type(baitData) == "table" and baitData.Image then
						local imgStr = tostring(baitData.Image)
						baitImageToNameMap[imgStr] = baitMod.Name
						baitImageToNameMap[string.lower(imgStr)] = baitMod.Name
						local assetDigits = string.match(imgStr, "%d+")
						if assetDigits then
							baitImageToNameMap[assetDigits] = baitMod.Name
						end
					end
				end
			end
		end
		buildBaitImageMap()
		local function getEquippedBaitQuantity()
			local equippedQty = -1
			pcall(function()
				local mainGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainGui")
				local hotbarList = mainGui
					and mainGui:FindFirstChild("Main")
					and mainGui.Main:FindFirstChild("Hotbar")
					and mainGui.Main.Hotbar:FindFirstChild("List")
				local slot2Frame = hotbarList and hotbarList:FindFirstChild("2")
				if slot2Frame then
					local qtyLabel = slot2Frame:FindFirstChild("Quantity")
						or (slot2Frame:FindFirstChild("Quantity_BG") and slot2Frame.Quantity_BG:FindFirstChild("Quantity"))
						or (slot2Frame:FindFirstChild("Detail") and slot2Frame.Detail:FindFirstChild("Quantity"))
						or (slot2Frame:FindFirstChild("Inner") and slot2Frame.Inner:FindFirstChild("Quantity"))
					if qtyLabel and qtyLabel:IsA("TextLabel") then
						if not qtyLabel.Visible or qtyLabel.Text == "" then
							equippedQty = 0
						else
							local digitsStr = string.match(qtyLabel.Text, "%d+")
							equippedQty = tonumber(digitsStr) or 0
						end
					end
				end
			end)
			if equippedQty == -1 and PlayerData then
				pcall(function()
					local hotbarData = PlayerData:FindFirstChild("Hotbar")
					local slot2Data = hotbarData and hotbarData:FindFirstChild("2")
					if slot2Data then
						local qtyValObj = slot2Data:FindFirstChild("Quantity")
						if qtyValObj and qtyValObj:IsA("ValueBase") then
							equippedQty = tonumber(qtyValObj.Value) or 0
						end
					end
				end)
			end
			return math.max(0, equippedQty)
		end
		local function getEquippedBaitName()
			if not next(baitImageToNameMap) then
				buildBaitImageMap()
			end
			local equippedName = nil
			pcall(function()
				local mainGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("MainGui")
				local hotbarList = mainGui
					and mainGui:FindFirstChild("Main")
					and mainGui.Main:FindFirstChild("Hotbar")
					and mainGui.Main.Hotbar:FindFirstChild("List")
				local slot2Frame = hotbarList and hotbarList:FindFirstChild("2")
				if slot2Frame then
					local iconLabel = slot2Frame:FindFirstChild("Image")
						or (slot2Frame:FindFirstChild("Inner") and slot2Frame.Inner:FindFirstChild("Image"))
					if not iconLabel then
						iconLabel = slot2Frame:FindFirstChildWhichIsA("ImageLabel", true)
					end
					if iconLabel and iconLabel.Visible and iconLabel.Image ~= "" then
						local imgIdStr = tostring(iconLabel.Image)
						local imgDigits = string.match(imgIdStr, "%d+")
						if imgDigits and baitImageToNameMap[imgDigits] then
							equippedName = baitImageToNameMap[imgDigits]
						elseif baitImageToNameMap[imgIdStr] then
							equippedName = baitImageToNameMap[imgIdStr]
						elseif baitImageToNameMap[string.lower(imgIdStr)] then
							equippedName = baitImageToNameMap[string.lower(imgIdStr)]
						end
					end
					if not equippedName then
						for _, descObj in ipairs(slot2Frame:GetDescendants()) do
							if descObj:IsA("TextLabel") and descObj.Text ~= "" then
								local candidateText = cleanBaitName(descObj.Text)
								if Info and Info:FindFirstChild("Bait") and Info.Bait:FindFirstChild(candidateText) then
									equippedName = candidateText
									break
								end
							end
							local itemAttr = descObj:GetAttribute("ItemName") or descObj:GetAttribute("Bait")
							if itemAttr and tostring(itemAttr) ~= "" then
								local cleanAttr = cleanBaitName(tostring(itemAttr))
								if Info and Info:FindFirstChild("Bait") and Info.Bait:FindFirstChild(cleanAttr) then
									equippedName = cleanAttr
									break
								end
							end
						end
					end
					local qtyLabel = slot2Frame:FindFirstChild("Quantity")
						or (slot2Frame:FindFirstChild("Quantity_BG") and slot2Frame.Quantity_BG:FindFirstChild("Quantity"))
						or (slot2Frame:FindFirstChild("Detail") and slot2Frame.Detail:FindFirstChild("Quantity"))
						or (slot2Frame:FindFirstChild("Inner") and slot2Frame.Inner:FindFirstChild("Quantity"))
					if qtyLabel and qtyLabel:IsA("TextLabel") then
						if not qtyLabel.Visible or qtyLabel.Text == "" or qtyLabel.Text == "x0" or qtyLabel.Text == "0" then
							equippedName = nil
						end
					end
				end
			end)
			if not equippedName and PlayerData then
				pcall(function()
					local hotbarData = PlayerData:FindFirstChild("Hotbar")
					local slot2Data = hotbarData and hotbarData:FindFirstChild("2")
					if slot2Data then
						local valNameObj = slot2Data:FindFirstChild("ValueName")
						local qtyObj = slot2Data:FindFirstChild("Quantity")
						local slotQty = qtyObj and tonumber(qtyObj.Value) or 0
						if valNameObj and valNameObj.Value ~= "" and slotQty > 0 then
							local cleanValName = cleanBaitName(valNameObj.Value)
							if Info and Info:FindFirstChild("Bait") and Info.Bait:FindFirstChild(cleanValName) then
								equippedName = cleanValName
							end
						end
					end
					if not equippedName then
						local equippedBaitVal = PlayerData:FindFirstChild("EquippedBait") or PlayerData:FindFirstChild("CurrentBait")
						if equippedBaitVal and equippedBaitVal:IsA("StringValue") and equippedBaitVal.Value ~= "" then
							equippedName = cleanBaitName(equippedBaitVal.Value)
						end
					end
					if not equippedName then
						local equippedBaitAttr = PlayerData:GetAttribute("EquippedBait") or PlayerData:GetAttribute("Bait")
						if equippedBaitAttr and tostring(equippedBaitAttr) ~= "" then
							equippedName = cleanBaitName(tostring(equippedBaitAttr))
						end
					end
				end)
			end
			return equippedName
		end
		local lastEquipBaitClock = 0
		function StepAutoEquipBestBait(forceNotify)
			if not Config.AutoEquipBestBait and not forceNotify then
				return
			end
			local nowClock = os.clock()
			if not forceNotify and nowClock - lastEquipBaitClock < 2 then
				return
			end
			local bestBait, bestRawBait, bestBaitLuck, bestBaitCount = findBestOwnedBait()
			if not bestBait or bestBaitCount <= 0 then
				if forceNotify then
					pcall(function()
						Fluent:Notify({ Title = "Auto Equip Bait", Content = "No bait found in inventory", Duration = 3 })
					end)
				end
				return
			end
			local curBait = getEquippedBaitName()
			local curBaitQty = getEquippedBaitQuantity()
			if not forceNotify and curBait == bestBait and curBaitQty > 0 then
				return
			end
			lastEquipBaitClock = nowClock
			local equipRemote = EquipBaitEvent
				or (Events and Events:FindFirstChild("EquipBait"))
				or (Events and Events:WaitForChild("EquipBait", 3))
			if equipRemote then
				pcall(function()
					if equipRemote:IsA("RemoteFunction") then
						equipRemote:InvokeServer(bestBait)
					elseif equipRemote:IsA("RemoteEvent") then
						equipRemote:FireServer(bestBait)
					else
						equipRemote:InvokeServer(bestBait)
					end
				end)
				task.delay(0.3, function()
					local recheckBait = getEquippedBaitName()
					local recheckQty = getEquippedBaitQuantity()
					if recheckQty <= 0 and recheckBait ~= bestBait then
						pcall(function()
							if equipRemote:IsA("RemoteFunction") then
								equipRemote:InvokeServer(bestBait)
							elseif equipRemote:IsA("RemoteEvent") then
								equipRemote:FireServer(bestBait)
							else
								equipRemote:InvokeServer(bestBait)
							end
						end)
					end
				end)
			end
			pcall(function()
				Fluent:Notify({
					Title = "Auto Equip Bait",
					Content = "Equipped " .. bestBait .. " - Luck " .. bestBaitLuck .. "%",
					Duration = 3,
				})
			end)
		end
		LocalPlayer.CharacterAdded:Connect(function()
			lastEquipBaitClock = 0
		end)
	end
	task.spawn(function()
		while task.wait(1) do
			if Hub.Unloaded then
				break
			end
			if Config.AutoTicketQuest then
				pcall(StepSmartTicketQuest)
			end
			if Config.AutoZengTianguoQuest or Config.AutoFilterZengQuest then
				pcall(StepSmartZengTianguoQuest)
			end
			if Config.AutoEquipBestBait then
				pcall(StepAutoEquipBestBait)
			end
			if Config.AutoGiveFish and Hub.StepAutoGiveFish then
				pcall(Hub.StepAutoGiveFish)
			end
			if Config.AutoClaimDailyQuest and Hub.StepAutoClaimDailyQuest then
				pcall(Hub.StepAutoClaimDailyQuest)
				pcall(Hub.StepAutoClaimDailyReward)
			end
		end
	end)
	local function GetBuyableBaits()
		local buyableBaits = {}
		local seenBaits = {}
		local baitInfo = Info:FindFirstChild("Bait")
		if baitInfo then
			for _, baitMod in ipairs(baitInfo:GetChildren()) do
				local baitData = GetModuleData(baitMod)
				if baitData and not baitData.Ingredient then
					seenBaits[baitMod.Name] = true
					table.insert(buyableBaits, baitMod.Name)
				end
			end
		end
		local itemInfo = Info:FindFirstChild("Item")
		if itemInfo then
			for _, itemMod in ipairs(itemInfo:GetChildren()) do
				if not seenBaits[itemMod.Name] then
					local itemData = GetModuleData(itemMod)
					if itemData and itemData.Type == "Bait" and not itemData.Ingredient then
						seenBaits[itemMod.Name] = true
						table.insert(buyableBaits, itemMod.Name)
					end
				end
			end
		end
		table.sort(buyableBaits)
		return buyableBaits
	end
	local function GetCraftableBaits()
		local craftableBaits = {}
		local baitInfo = Info:FindFirstChild("Bait")
		if baitInfo then
			for _, baitMod in ipairs(baitInfo:GetChildren()) do
				local baitData = GetModuleData(baitMod)
				if baitData and baitData.Ingredient then
					table.insert(craftableBaits, baitMod.Name)
				end
			end
		end
		table.sort(craftableBaits)
		return craftableBaits
	end
	local function GetCraftableRods()
		local craftableRods = {}
		local invInfo = Info:FindFirstChild("Inventory")
		if invInfo then
			for _, rodMod in ipairs(invInfo:GetChildren()) do
				local rodData = GetModuleData(rodMod)
				if rodData and rodData.Ingredient and rodData.Type == "Fishing Rod" then
					table.insert(craftableRods, rodMod.Name)
				end
			end
		end
		table.sort(craftableRods)
		return craftableRods
	end
	local islandPartMap = {}
	local islandOrderWeights = {
		["Beginning Isle"] = 1,
		["Bamboo Isle"] = 2,
		["Fallout Isle"] = 3,
		["Sovereign Isle"] = 4,
		["Perch Isle"] = 5,
		["Frost Isle"] = 6,
		["Coconut Isle"] = 7,
		["Amber Isle"] = 8,
		["Battlefield Isle"] = 9,
		["Mistpeak Isle"] = 10,
		["World Angler Isle"] = 11,
		["Weather Isle"] = 12,
		["Mystic Reef Isle"] = 13,
	}
	local islandDefaultPowers = {
		["Beginning Isle"] = 1,
		["Bamboo Isle"] = 19,
		["Fallout Isle"] = 32,
		["Sovereign Isle"] = 39,
		["Perch Isle"] = 48,
		["Frost Isle"] = 55,
		["Coconut Isle"] = 65,
		["Amber Isle"] = 75,
		["Battlefield Isle"] = 90,
		["Mistpeak Isle"] = 100,
		["World Angler Isle"] = 100,
		["Weather Isle"] = 100,
		["Mystic Reef Isle"] = 100,
	}
	local function getIslandOrderWeight(islandName)
		if islandOrderWeights[islandName] then
			return islandOrderWeights[islandName]
		end
		local lowerName = string.lower(islandName)
		for knownIsland, orderIdx in pairs(islandOrderWeights) do
			local lowerKnown = string.lower(knownIsland)
			if lowerName == lowerKnown or string.find(lowerName, lowerKnown, 1, true) or string.find(lowerKnown, lowerName, 1, true) then
				return orderIdx
			end
		end
		return nil
	end
	local function getIslandDefaultPower(islandName)
		if islandDefaultPowers[islandName] then
			return islandDefaultPowers[islandName]
		end
		local lowerName = string.lower(islandName)
		for knownIsland, powerVal in pairs(islandDefaultPowers) do
			local lowerKnown = string.lower(knownIsland)
			if lowerName == lowerKnown or string.find(lowerName, lowerKnown, 1, true) or string.find(lowerKnown, lowerName, 1, true) then
				return powerVal
			end
		end
		return nil
	end
	local function GetIslandList()
		local islandEntries = {}
		local seenIslands = {}
		table.clear(islandPartMap)
		local spawnFolder = workspace:FindFirstChild("Spawnpoint")
		if not spawnFolder then
			return {}
		end
		local startIsle = spawnFolder:FindFirstChild("Beginning Isle")
		local originPos = startIsle and GetModelPart(startIsle) and GetModelPart(startIsle).Position or Vector3.zero
		local uiOrderMap = {}
		local uiPowerMap = {}
		if MainGui then
			local menuGui = MainGui:FindFirstChild("Menu")
			local compassGui = menuGui and menuGui:FindFirstChild("Compass")
			local areaListGui = compassGui and compassGui:FindFirstChild("AreaList")
			if areaListGui then
				for _, areaItem in ipairs(areaListGui:GetChildren()) do
					if areaItem:IsA("GuiObject") and areaItem:FindFirstChild("Track") then
						local parsedPower = nil
						for _, descLabel in ipairs(areaItem:GetDescendants()) do
							if descLabel:IsA("TextLabel") and descLabel.Text then
								local powerMatch = string.match(descLabel.Text, "Power:%s*(%d+)")
								if powerMatch then
									parsedPower = tonumber(powerMatch)
									break
								end
							end
						end
						if parsedPower then
							uiPowerMap[areaItem.Name] = parsedPower
						end
						local sortScore = (parsedPower or 999) * 1000 + (areaItem.LayoutOrder or 0)
						uiOrderMap[areaItem.Name] = sortScore
					end
				end
			end
		end
		for _, islandObj in ipairs(spawnFolder:GetChildren()) do
			local islandPart = GetModelPart(islandObj)
			if islandPart and not seenIslands[islandObj.Name] then
				seenIslands[islandObj.Name] = true
				local knownOrder = getIslandOrderWeight(islandObj.Name)
				local sortWeight
				if knownOrder then
					sortWeight = knownOrder
				elseif uiOrderMap[islandObj.Name] then
					sortWeight = 1000 + uiOrderMap[islandObj.Name]
				else
					sortWeight = 1e7 + (islandPart.Position - originPos).Magnitude
				end
				local islandPower = uiPowerMap[islandObj.Name] or getIslandDefaultPower(islandObj.Name)
				table.insert(islandEntries, { name = islandObj.Name, part = islandPart, weight = sortWeight, power = islandPower })
			end
		end
		table.sort(islandEntries, function(entryA, entryB)
			if entryA.weight ~= entryB.weight then
				return entryA.weight < entryB.weight
			end
			return entryA.name < entryB.name
		end)
		local displayList = {}
		for _, entry in ipairs(islandEntries) do
			local displayName = entry.power and (entry.name .. " | " .. tostring(entry.power)) or entry.name
			islandPartMap[displayName] = entry.part
			islandPartMap[entry.name] = entry.part
			table.insert(displayList, displayName)
		end
		return displayList
	end
	local function TeleportToIsland(islandSelection)
		if not islandSelection or islandSelection == "" then
			return
		end
		if not islandPartMap[islandSelection] then
			GetIslandList()
		end
		local targetPart = islandPartMap[islandSelection]
		local char = LocalPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hrp and targetPart then
			hrp.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
		end
	end
	local function TeleportUnderIsland(islandSelection)
		if not islandSelection or islandSelection == "" then
			return
		end
		if not islandPartMap[islandSelection] then
			GetIslandList()
		end
		local targetPart = islandPartMap[islandSelection]
		if not targetPart then
			return
		end
		local char = LocalPlayer.Character or cachedChar
		local hrp = (char and char:FindFirstChild("HumanoidRootPart")) or cachedHrp
		if not hrp then
			return
		end
		local underY = -25
		local oceanFolder = workspace:FindFirstChild("Ocean")
		if oceanFolder then
			for _, waterPart in ipairs(oceanFolder:GetChildren()) do
				if waterPart.Name == "Water" and waterPart:IsA("BasePart") then
					local waterSurfaceY = waterPart.Position.Y + (waterPart.Size.Y * 0.5)
					underY = waterSurfaceY - 12
					break
				end
			end
		end
		local targetPos = Vector3.new(targetPart.Position.X, math.min(underY, targetPart.Position.Y - 15), targetPart.Position.Z)
		hrp.CFrame = CFrame.new(targetPos)
	end
	local npcPartCache = {}
	local function GetNPCList()
		local npcNames = {}
		local seenNpcs = {}
		table.clear(npcPartCache)
		local function registerNpc(npcName, npcPart)
			if not npcName or npcName == "" then
				return
			end
			local normalizedKey = string.lower(string.gsub(npcName, "%s+", ""))
			if normalizedKey == "longdiaohai" then
				npcName = "Long DiaoHai"
			end
			if npcPart and npcPart:IsDescendantOf(workspace) then
				npcPartCache[npcName] = npcPart
				npcPartCache[normalizedKey] = npcPart
			end
			if not seenNpcs[normalizedKey] then
				seenNpcs[normalizedKey] = true
				table.insert(npcNames, npcName)
			end
		end
		for _, folderName in ipairs({ "Merchant", "NPCDialogue", "NPCPVP", "NPC", "BossSetUp" }) do
			local sourceFolder = workspace:FindFirstChild(folderName) or ReplicatedStorage:FindFirstChild(folderName)
			if sourceFolder then
				for _, childObj in ipairs(sourceFolder:GetChildren()) do
					local childName = tostring(childObj.Name)
					if childName ~= "" and childName ~= "Lamp" and childName ~= "Boss" and childName ~= "God" then
						local wsFolder = workspace:FindFirstChild(folderName)
						local wsNpc = wsFolder and wsFolder:FindFirstChild(childName)
						local wsPart = wsNpc and GetModelPart(wsNpc)
						registerNpc(childName, wsPart)
					elseif childName == "Boss" or childName == "God" then
						for _, subChild in ipairs(childObj:GetChildren()) do
							local subName = tostring(subChild.Name)
							if subName ~= "" and subName ~= "God" then
								local wsFolder = workspace:FindFirstChild(folderName)
								local wsGroup = wsFolder and wsFolder:FindFirstChild(childName)
								local wsSubNpc = wsGroup and wsGroup:FindFirstChild(subName)
								local wsSubPart = wsSubNpc and GetModelPart(wsSubNpc)
								registerNpc(subName, wsSubPart)
							end
						end
					end
				end
			end
		end
		local godFolder = workspace:FindFirstChild("God") or ReplicatedStorage:FindFirstChild("God")
		if godFolder then
			for _, godChild in ipairs(godFolder:GetChildren()) do
				local godName = tostring(godChild.Name)
				if godName ~= "" and godName ~= "Lamp" and godName ~= "God" then
					local wsGod = workspace:FindFirstChild("God") and workspace.God:FindFirstChild(godName)
					local wsGodPart = wsGod and GetModelPart(wsGod)
					registerNpc(godName, wsGodPart)
				end
			end
		end
		registerNpc("Long DiaoHai")
		local priorityNpcs = {
			"The Shadow",
			"TheShadow",
			"Shadow",
			"???",
			"Taoist",
			"Taosi",
			"Maoshan",
			"Maosan",
			"Long DiaoHai",
			"LongDiaoHai",
			"Longdiaohai",
			"Enzo",
			"Blue",
			"Green",
			"Yellow",
			"Nanjiang",
			"Zeng Tianguo",
		}
		local npcPriorityMap = {}
		for prioIdx, prioName in ipairs(priorityNpcs) do
			local normPrio = string.lower(string.gsub(prioName, "%s+", ""))
			if not npcPriorityMap[normPrio] then
				npcPriorityMap[normPrio] = prioIdx
			end
		end
		local function getNpcPriority(npcName)
			local normName = string.lower(string.gsub(tostring(npcName), "%s+", ""))
			return npcPriorityMap[normName] or 9999
		end
		table.sort(npcNames, function(nameA, nameB)
			local prioA = getNpcPriority(nameA)
			local prioB = getNpcPriority(nameB)
			if prioA ~= prioB then
				return prioA < prioB
			end
			return tostring(nameA):lower() < tostring(nameB):lower()
		end)
		return npcNames
	end
	local function TeleportToNPC(npcName)
		if not npcName or npcName == "" then
			return
		end
		local normTarget = string.lower(string.gsub(tostring(npcName), "%s+", ""))
		local targetPart = nil
		if normTarget == "blue" or normTarget == "green" or normTarget == "yellow" then
			local godFolder = workspace:FindFirstChild("God")
			if godFolder then
				for _, godChild in ipairs(godFolder:GetChildren()) do
					local normChild = string.lower(string.gsub(tostring(godChild.Name), "%s+", ""))
					if normChild == normTarget then
						targetPart = GetModelPart(godChild)
						if targetPart and targetPart:IsDescendantOf(workspace) then
							break
						end
					end
				end
			end
			if not targetPart then
				for _, wsChild in ipairs(workspace:GetChildren()) do
					local normWsChild = string.lower(string.gsub(tostring(wsChild.Name), "%s+", ""))
					if normWsChild == normTarget then
						local wsChildPart = GetModelPart(wsChild)
						if wsChildPart and wsChildPart:IsDescendantOf(workspace) then
							targetPart = wsChildPart
							break
						end
					end
				end
			end
		elseif string.find(normTarget, "longdiaohai") or normTarget == "enzo" then
			local bossModel, bossPart = FindBossTarget(string.find(normTarget, "longdiaohai") ~= nil)
			if bossPart and bossPart:IsDescendantOf(workspace) then
				targetPart = bossPart
			end
		end
		local matchedParts = {}
		if not targetPart then
			for _, folderName in ipairs({ "NPC", "Merchant", "NPCDialogue", "NPCPVP", "God", "BossSetUp" }) do
				local wsFolder = workspace:FindFirstChild(folderName)
				if wsFolder then
					for _, descObj in ipairs(wsFolder:GetDescendants()) do
						if
							(descObj:IsA("Model") or descObj:IsA("BasePart"))
							and not descObj:IsA("Folder")
							and (descObj.Name == npcName or descObj:GetAttribute("Name") == npcName)
							and descObj.Name ~= "God"
						then
							local descPart = GetModelPart(descObj)
							if descPart and descPart:IsDescendantOf(workspace) then
								table.insert(matchedParts, { folder = folderName, part = descPart })
							end
						end
					end
				end
			end
		end
		if not targetPart and #matchedParts == 0 then
			local directObj = workspace:FindFirstChild(npcName)
			if directObj then
				local directPart = GetModelPart(directObj)
				if directPart and directPart:IsDescendantOf(workspace) then
					targetPart = directPart
				end
			end
		end
		if #matchedParts > 0 then
			if (npcName == "Maoshan" or npcName == "Taoist") and #matchedParts > 1 then
				local daShixiong = workspace:FindFirstChild("Da Shixiong", true)
				local daShixiongPart = daShixiong and GetModelPart(daShixiong)
				for _, matchEntry in ipairs(matchedParts) do
					if matchEntry.folder == "NPC" then
						targetPart = matchEntry.part
						break
					end
					if daShixiongPart and (matchEntry.part.Position - daShixiongPart.Position).Magnitude > 15 then
						targetPart = matchEntry.part
						break
					end
				end
			end
			if not targetPart then
				targetPart = matchedParts[1].part
			end
		end
		if not targetPart or not targetPart:IsDescendantOf(workspace) then
			local cachedPart = npcPartCache[npcName] or npcPartCache[normTarget]
			if cachedPart and cachedPart:IsDescendantOf(workspace) then
				targetPart = cachedPart
			end
		end
		if not targetPart or not targetPart:IsDescendantOf(workspace) then
			pcall(function()
				Fluent:Notify({
					Title = "Teleport NPC",
					Content = npcName .. " has not spawned on the map yet!",
					Duration = 4,
				})
			end)
			return
		end
		local char = LocalPlayer.Character or cachedChar
		local hrp = (char and char:FindFirstChild("HumanoidRootPart")) or cachedHrp
		if hrp and targetPart then
			hrp.CFrame = targetPart.CFrame * CFrame.new(0, 3, -4)
		end
	end
	local function GetPlayerList()
		local playerNames = {}
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				table.insert(playerNames, plr.Name)
			end
		end
		table.sort(playerNames, function(nameA, nameB)
			return string.lower(nameA) < string.lower(nameB)
		end)
		return playerNames
	end
	local function TeleportToPlayer(targetPlayerName)
		if not targetPlayerName or targetPlayerName == "" then
			return
		end
		local targetPlayer = Players:FindFirstChild(targetPlayerName)
		if not targetPlayer then
			for _, plr in ipairs(Players:GetPlayers()) do
				if
					plr ~= LocalPlayer
					and (
						string.lower(plr.Name) == string.lower(targetPlayerName)
						or string.lower(plr.DisplayName) == string.lower(targetPlayerName)
					)
				then
					targetPlayer = plr
					break
				end
			end
		end
		if not targetPlayer then
			pcall(function()
				Fluent:Notify({
					Title = "Teleport Player",
					Content = "Player " .. tostring(targetPlayerName) .. " not found!",
					Duration = 3,
				})
			end)
			return
		end
		local targetChar = targetPlayer.Character
		local targetRoot = targetChar
			and (
				targetChar:FindFirstChild("HumanoidRootPart")
				or targetChar:FindFirstChild("Torso")
				or targetChar:FindFirstChild("UpperTorso")
			)
		if not targetRoot then
			pcall(function()
				Fluent:Notify({
					Title = "Teleport Player",
					Content = targetPlayer.Name .. " has no character spawned!",
					Duration = 3,
				})
			end)
			return
		end
		local localChar = LocalPlayer.Character or cachedChar
		local localHrp = (localChar and localChar:FindFirstChild("HumanoidRootPart")) or cachedHrp
		if localHrp then
			localHrp.CFrame = targetRoot.CFrame * CFrame.new(0, 2, 3)
		end
	end
	local knownCodes = {
		"HWF",
		"Welcome",
		"VermilionBird",
		"PVP",
		"AXO",
		"SeeYouSoon",
		"BUGTrait",
		"80KLikes",
		"65KLikes",
		"60KLikes",
		"50KLikes",
		"55MVisits",
		"41MVisits",
		"40MVisits",
		"39MVisits",
		"38MVisits",
		"37MVisits",
		"23KActives",
		"19KActives",
	}
	local function RedeemAllCodes()
		task.spawn(function()
			local codeSet = {}
			for _, codeStr in ipairs(knownCodes) do
				codeSet[codeStr] = true
			end
			local function collectCodesFrom(container)
				if not container then
					return
				end
				if container:IsA("ModuleScript") then
					local reqOk, codeTable = pcall(require, container)
					if reqOk and type(codeTable) == "table" then
						for k, v in pairs(codeTable) do
							if type(k) == "string" then
								codeSet[k] = true
							end
							if type(v) == "string" then
								codeSet[v] = true
							end
						end
					end
				end
				for _, childObj in ipairs(container:GetChildren()) do
					codeSet[childObj.Name] = true
					if childObj:IsA("StringValue") and childObj.Value ~= "" then
						codeSet[childObj.Value] = true
					end
				end
			end
			collectCodesFrom(Info:FindFirstChild("Code"))
			collectCodesFrom(Info:FindFirstChild("Codes"))
			collectCodesFrom(PlayerData:FindFirstChild("Code"))
			collectCodesFrom(PlayerData:FindFirstChild("Codes"))
			for codeToRedeem in pairs(codeSet) do
				pcall(function()
					RedeemCodeEvent:FireServer(codeToRedeem)
				end)
				task.wait(0.15)
			end
		end)
	end
	local function OpenMenuFrameRemotely(menuName)
		local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
		local mainGui = (playerGui and playerGui:FindFirstChild("MainGui")) or MainGui
		local menuFolder = mainGui and mainGui:FindFirstChild("Menu")
		if not menuFolder then
			return false
		end
		local targetFrame = menuFolder:FindFirstChild(menuName)
		if not targetFrame and (string.lower(menuName) == "trait" or string.find(string.lower(menuName), "trait")) then
			for _, childObj in pairs(menuFolder:GetChildren()) do
				local lowerChildName = string.lower(childObj.Name)
				if string.find(lowerChildName, "trait") or string.find(lowerChildName, "reroll") then
					targetFrame = childObj
					menuName = childObj.Name
					break
				end
			end
			if not targetFrame then
				for _, descObj in pairs(mainGui:GetDescendants()) do
					if descObj:IsA("Frame") then
						local lowerDescName = string.lower(descObj.Name)
						if string.find(lowerDescName, "trait") or string.find(lowerDescName, "reroll") then
							targetFrame = descObj
							break
						end
					end
				end
			end
		end
		if not targetFrame then
			return false
		end
		for _, siblingFrame in pairs(menuFolder:GetChildren()) do
			if siblingFrame:IsA("Frame") and siblingFrame.Name ~= "Info" and siblingFrame.Name ~= "Black" and siblingFrame.Name ~= "Dialogue" then
				if siblingFrame == targetFrame or siblingFrame.Name == menuName then
					siblingFrame.Visible = not siblingFrame.Visible
				else
					siblingFrame.Visible = false
				end
			end
		end
		if targetFrame.Parent ~= menuFolder then
			targetFrame.Visible = not targetFrame.Visible
		end
		return targetFrame.Visible
	end
	local origLighting = {
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		FogEnd = Lighting.FogEnd,
		FogStart = Lighting.FogStart,
		GlobalShadows = Lighting.GlobalShadows,
		Ambient = Lighting.Ambient,
		OutdoorAmbient = Lighting.OutdoorAmbient,
	}
	local origAtmospheres = {}
	for _, atmoObj in ipairs(Lighting:GetChildren()) do
		if atmoObj:IsA("Atmosphere") then
			origAtmospheres[atmoObj] = { Density = atmoObj.Density, Haze = atmoObj.Haze, Glare = atmoObj.Glare }
		end
	end
	local isApplyingLighting = false
	local function ApplyLightingSettings()
		if isApplyingLighting then
			return
		end
		isApplyingLighting = true
		pcall(function()
			if Config.FullBright then
				Lighting.Brightness = 2
				Lighting.ClockTime = 14
				Lighting.GlobalShadows = false
				Lighting.Ambient = Color3.fromRGB(255, 255, 255)
				Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
			end
			if Config.NoFog then
				Lighting.FogStart = 100000
				Lighting.FogEnd = 100000
				for _, atmoChild in ipairs(Lighting:GetChildren()) do
					if atmoChild:IsA("Atmosphere") then
						if not origAtmospheres[atmoChild] then
							origAtmospheres[atmoChild] = { Density = atmoChild.Density, Haze = atmoChild.Haze, Glare = atmoChild.Glare }
						end
						atmoChild.Density = 0
						atmoChild.Haze = 0
						atmoChild.Glare = 0
					end
				end
			end
		end)
		isApplyingLighting = false
	end
	local function RestoreFullBright()
		isApplyingLighting = true
		pcall(function()
			Lighting.Brightness = origLighting.Brightness
			Lighting.ClockTime = origLighting.ClockTime
			Lighting.GlobalShadows = origLighting.GlobalShadows
			Lighting.Ambient = origLighting.Ambient
			Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
		end)
		isApplyingLighting = false
	end
	local function RestoreNoFog()
		isApplyingLighting = true
		pcall(function()
			Lighting.FogStart = origLighting.FogStart
			Lighting.FogEnd = origLighting.FogEnd
			for atmoInst, savedAtmo in pairs(origAtmospheres) do
				if atmoInst and atmoInst.Parent then
					atmoInst.Density = savedAtmo.Density
					atmoInst.Haze = savedAtmo.Haze
					atmoInst.Glare = savedAtmo.Glare
				end
			end
		end)
		isApplyingLighting = false
	end
	Lighting.Changed:Connect(function()
		if Config.FullBright or Config.NoFog then
			ApplyLightingSettings()
		end
	end)
	ApplyLightingSettings()
	local function equipItemViaInventoryUi(itemName)
		if not MainGui or not itemName or itemName == "" then
			return false
		end
		local mainFrame = MainGui:FindFirstChild("Main")
		local fishingInv = mainFrame and mainFrame:FindFirstChild("Fishing_INV")
		local invMain = fishingInv and fishingInv:FindFirstChild("Main")
		if not invMain then
			return false
		end
		for _, descObj in ipairs(invMain:GetDescendants()) do
			if descObj.Name == itemName or descObj:GetAttribute("ItemName") == itemName then
				local actionBtn = (descObj:IsA("GuiButton") and descObj)
					or descObj:FindFirstChild("Equip", true)
					or descObj:FindFirstChild("Select", true)
					or descObj:FindFirstChild("Choose", true)
					or descObj:FindFirstChild("Button", true)
					or descObj:FindFirstChildWhichIsA("GuiButton", true)
				if actionBtn and clickGuiElement(actionBtn) then
					local confirmEquipBtn = invMain:FindFirstChild("Equip", true)
					if confirmEquipBtn and confirmEquipBtn:IsA("GuiButton") then
						clickGuiElement(confirmEquipBtn)
					end
					return true
				end
			end
		end
		return false
	end
	local function findBestOwnedRod()
		local rodInv = PlayerData:FindFirstChild("FishingRodInventory")
		local invInfo = Info:FindFirstChild("Inventory")
		if not rodInv or not invInfo then
			return nil
		end
		local bestRodName, bestRodPower = nil, -1
		for _, rodEntry in ipairs(rodInv:GetChildren()) do
			local ownedVal = rodEntry:FindFirstChild("Owned")
			if ownedVal and ownedVal.Value == true then
				local rodData = GetModuleData(invInfo:FindFirstChild(rodEntry.Name))
				if rodData then
					local rodPower = tonumber(rodData.Power) or 0
					if rodPower > bestRodPower then
						bestRodPower = rodPower
						bestRodName = rodEntry.Name
					end
				end
			end
		end
		return bestRodName
	end
	local function scoreEquipmentData(itemData)
		if type(itemData) ~= "table" then
			return 0
		end
		local score = (tonumber(itemData.Power) or 0) * 1000
			+ (tonumber(itemData.Boost) or 0) * 500
			+ (tonumber(itemData.Luck) or 0) * 200
			+ (tonumber(itemData.Price) or 0) * 0.01
		if itemData.Ingredient then
			score = score + 50000
		end
		if itemData.Rarity == "Secret" then
			score = score + 1000000
		elseif itemData.Rarity == "Mythical" then
			score = score + 500000
		elseif itemData.Rarity == "Legendary" then
			score = score + 100000
		end
		return score
	end
	local function isItemOwnedInFolder(folder, itemName)
		if not folder then
			return false
		end
		local itemEntry = folder:FindFirstChild(itemName)
		if not itemEntry then
			return false
		end
		if itemEntry:IsA("BoolValue") then
			return itemEntry.Value == true
		end
		if itemEntry:IsA("NumberValue") or itemEntry:IsA("IntValue") then
			return itemEntry.Value > 0
		end
		local ownedBool = itemEntry:FindFirstChild("Owned")
		if ownedBool and ownedBool:IsA("BoolValue") then
			return ownedBool.Value == true
		end
		local qtyVal = itemEntry:FindFirstChild("Quantity")
			or itemEntry:FindFirstChild("Amount")
			or itemEntry:FindFirstChild("Value")
		if qtyVal and (qtyVal:IsA("NumberValue") or qtyVal:IsA("IntValue")) then
			return qtyVal.Value > 0
		end
		return true
	end
	local function findBestOwnedEquipment(infoCategory, folderCandidates)
		local categoryInfo = Info:FindFirstChild(infoCategory)
		if not categoryInfo then
			return nil
		end
		local bestItemName, bestScore = nil, -1
		local ownedFolder
		for _, folderName in ipairs(folderCandidates) do
			ownedFolder = ownedFolder or PlayerData:FindFirstChild(folderName)
		end
		local invFolder = PlayerData:FindFirstChild("Inventory")
		for _, itemMod in ipairs(categoryInfo:GetChildren()) do
			if itemMod:IsA("ModuleScript") and (isItemOwnedInFolder(ownedFolder, itemMod.Name) or isItemOwnedInFolder(invFolder, itemMod.Name)) then
				local itemData = GetModuleData(itemMod)
				if itemData then
					local itemScore = scoreEquipmentData(itemData)
					if itemScore > bestScore then
						bestScore = itemScore
						bestItemName = itemMod.Name
					end
				end
			end
		end
		return bestItemName
	end
	local function EquipBestRod()
		local bestRod = findBestOwnedRod()
		if not bestRod then
			pcall(function()
				Fluent:Notify({ Title = "Equip Best Rod", Content = "No rod found", Duration = 3 })
			end)
			return
		end
		local curRodVal = PlayerData:FindFirstChild("FishingRod")
		if curRodVal and curRodVal.Value == bestRod then
			return
		end
		equipItemViaInventoryUi(bestRod)
		local equipRodRemote = findRemote("EquipFishingRod") or findRemote("EquipRod") or findRemote("ChangeRod") or findRemote("SelectRod")
		if equipRodRemote then
			invokeOrFireRemote(equipRodRemote, bestRod)
		end
		pcall(function()
			Fluent:Notify({ Title = "Equip Best Rod", Content = "Equipped " .. bestRod, Duration = 3 })
		end)
	end
	local function EquipBestOrb()
		local bestOrb = findBestOwnedEquipment("Orb", { "Orb", "OrbInventory", "Orbs" })
		if not bestOrb then
			pcall(function()
				Fluent:Notify({ Title = "Equip Best Orb", Content = "No orb found", Duration = 3 })
			end)
			return
		end
		equipItemViaInventoryUi(bestOrb)
		local equipOrbRemote = findRemote("EquipOrb") or findRemote("ChangeOrb") or findRemote("SelectOrb")
		if equipOrbRemote then
			invokeOrFireRemote(equipOrbRemote, bestOrb)
		end
		pcall(function()
			Fluent:Notify({ Title = "Equip Best Orb", Content = "Equipped " .. bestOrb, Duration = 3 })
		end)
	end
	local function AutoBuyBestRodLogic()
		local cashVal = PlayerData:FindFirstChild("Cash")
		local invInfo = Info:FindFirstChild("Inventory")
		local rodInv = PlayerData:FindFirstChild("FishingRodInventory")
		local buyRodEvent = Events:FindFirstChild("BuyFishingRod")
		if not cashVal or not invInfo or not buyRodEvent then
			return
		end
		local currentCash = tonumber(cashVal.Value) or 0
		local bestAffordableRod, bestPower = nil, -1
		for _, rodMod in ipairs(invInfo:GetChildren()) do
			local rodData = GetModuleData(rodMod)
			if
				rodData
				and rodData.Type == "Fishing Rod"
				and type(rodData.Cash) == "number"
				and rodData.Cash > 0
				and rodData.Cash <= currentCash
			then
				local rodEntry = rodInv and rodInv:FindFirstChild(rodMod.Name)
				local ownedVal = rodEntry and rodEntry:FindFirstChild("Owned")
				if not (ownedVal and ownedVal.Value == true) then
					local rodPower = tonumber(rodData.Power) or 0
					if rodPower > bestPower then
						bestPower = rodPower
						bestAffordableRod = rodMod.Name
					end
				end
			end
		end
		if bestAffordableRod then
			pcall(function()
				buyRodEvent:FireServer(bestAffordableRod)
			end)
			task.wait(0.3)
			local equipRodEvent = Events:FindFirstChild("EquipFishingRod")
			if equipRodEvent then
				pcall(function()
					if equipRodEvent:IsA("RemoteFunction") then
						equipRodEvent:InvokeServer(bestAffordableRod)
					else
						equipRodEvent:FireServer(bestAffordableRod)
					end
				end)
			end
		end
	end
	local function ClaimDailyRewards()
		local dailyRewardData = PlayerData:FindFirstChild("DailyReward")
		local dailyRewardEvent = Events:FindFirstChild("DailyReward")
		if not dailyRewardData or not dailyRewardEvent then
			return
		end
		for dayIdx = 1, 7 do
			local dayClaimedVal = dailyRewardData:FindFirstChild(tostring(dayIdx))
			if dayClaimedVal and dayClaimedVal:IsA("BoolValue") and dayClaimedVal.Value == false then
				pcall(function()
					dailyRewardEvent:FireServer(dayIdx)
				end)
				task.wait(0.15)
			end
		end
	end
	local function GetBannerList()
		local banners = {}
		local gachaInfo = Info:FindFirstChild("Gacha")
		if gachaInfo then
			for _, bannerObj in ipairs(gachaInfo:GetChildren()) do
				table.insert(banners, bannerObj.Name)
			end
			table.sort(banners)
		end
		if #banners == 0 then
			banners = { "Celestial Banner", "Egoless Banner" }
		end
		return banners
	end
	local function DoSummonGacha()
		local gachaEvent = Events:FindFirstChild("Gacha")
		if not gachaEvent or Config.SelectedBanner == "" then
			return
		end
		local crystalVal = PlayerData:FindFirstChild("Crystal")
		local requiredCrystals = Config.SummonX10 and 50 or 5
		if crystalVal and crystalVal.Value < requiredCrystals then
			return
		end
		pcall(function()
			gachaEvent:FireServer(Config.SummonX10, Config.SelectedBanner)
		end)
	end
	local function DoAutoRedeemCodes()
		local codeFolder = PlayerData:FindFirstChild("Code")
		if codeFolder then
			for _, codeEntry in ipairs(codeFolder:GetChildren()) do
				if codeEntry:IsA("BoolValue") and codeEntry.Value == false then
					pcall(function()
						RedeemCodeEvent:FireServer(codeEntry.Name)
					end)
					task.wait(0.2)
				end
			end
		end
	end
	task.spawn(function()
		local lastDailyClock, lastSummonClock, lastBuyRodClock, lastRedeemClock = 0, 0, 0, 0
		while task.wait(0.8) do
			local nowClock = os.clock()
			if Config.AutoDaily and nowClock - lastDailyClock >= 10 then
				lastDailyClock = nowClock
				pcall(ClaimDailyRewards)
			end
			if Config.AutoSummon and nowClock - lastSummonClock >= 1.5 then
				lastSummonClock = nowClock
				pcall(DoSummonGacha)
			end
			if Config.AutoBuyBestRod and nowClock - lastBuyRodClock >= 4 then
				lastBuyRodClock = nowClock
				pcall(AutoBuyBestRodLogic)
			end
			if Config.AutoRedeem and nowClock - lastRedeemClock >= 15 then
				lastRedeemClock = nowClock
				pcall(DoAutoRedeemCodes)
			end
		end
	end)
	local fpsSavedProps = setmetatable({}, { __mode = "k" })
	local fpsDescendantConn = nil
	local function overrideInstanceProp(inst, propName, newVal)
		local propMap = fpsSavedProps[inst]
		if not propMap then
			propMap = {}
			fpsSavedProps[inst] = propMap
		end
		if propMap[propName] == nil then
			local readOk, origVal = pcall(function()
				return inst[propName]
			end)
			if not readOk then
				return
			end
			propMap[propName] = origVal
		end
		pcall(function()
			inst[propName] = newVal
		end)
	end
	local function stripInstanceVisuals(inst)
		if inst:IsA("BasePart") then
			overrideInstanceProp(inst, "CastShadow", false)
		elseif inst:IsA("Decal") or inst:IsA("Texture") then
			overrideInstanceProp(inst, "Transparency", 1)
		elseif
			inst:IsA("ParticleEmitter")
			or inst:IsA("Trail")
			or inst:IsA("Beam")
			or inst:IsA("Smoke")
			or inst:IsA("Fire")
			or inst:IsA("Sparkles")
			or inst:IsA("PostEffect")
		then
			overrideInstanceProp(inst, "Enabled", false)
		end
	end
	local function ApplySuperFPSBoost(enableBoost)
		if fpsDescendantConn then
			fpsDescendantConn:Disconnect()
			fpsDescendantConn = nil
		end
		for inst, propMap in pairs(fpsSavedProps) do
			for propName, origVal in pairs(propMap) do
				pcall(function()
					inst[propName] = origVal
				end)
			end
		end
		table.clear(fpsSavedProps)
		if not enableBoost then
			return
		end
		for _, descInst in ipairs(workspace:GetDescendants()) do
			stripInstanceVisuals(descInst)
		end
		fpsDescendantConn = game.DescendantAdded:Connect(stripInstanceVisuals)
	end
	if Config.FpsBoost then
		task.defer(function()
			ApplySuperFPSBoost(true)
		end)
	end
	do
		local bossFishCatalog = {
			"Azure Carp",
			"Jiaolong Dragonfish",
			"Chainbound Shark",
			"Adult Jiaolong Dragonfish",
			"Elder Chainbound Shark",
			"Elder Jiaolong Dragonfish",
			"Trueform Jiaolongfish",
			"Trueform Perch",
			"Ascended Perch",
			"Primordial Kunfish",
			"Primordial Kunfish Overlord",
			"Warbringer Shark",
			"Dreadscale Grouper",
			"Mutated Koid Whale",
			"Radiant Goldfish",
			"Serpent Fish",
			"Dreadmare Eel",
			"Chromatic Koi",
			"Toxic Chromatic Koi",
			"Crimson Bream Sovereign",
			"Silver Bream Sovereign",
			"Golder Guardian Fish",
			"Colossal Tigerfish",
			"Mountain Fish",
			"Tiger Mirefish",
			"Octoparasitic Fish",
			"Dark kingfish",
			"Golden Shark",
			"Darkness Shark",
			"White Heaven Kunfish",
			"Crimson Bonefiend",
			"Dragonfish Devourer",
			"Yangfish Sovereign",
			"Yinfish Sovereign",
			"Demon Bladefish",
			"Apollo Swordfish",
			"Killer Sawshark",
			"Thunder Fish",
			"Wind Fish",
			"Intuitive Fish King",
			"Aquatic Fish",
			"Flame Fish",
			"Verdant Alligator Gar",
			"Verdant Grouper",
			"Verdant Bonefang",
			"Scarlet Fish",
			"Mountain Dragonwhale",
			"Flying Fish Emperor",
			"Crimson Bonefang",
			"Elder ScarletFish",
			"Colossal Bull Shark",
			"Flying Fish Empress",
			"Draconic Koi",
			"Tigerfang Whale",
			"Golden Dragonfish",
			"Crimson Electric Eel",
			"Reborn Puffer Beast",
			"Heavenpiercer Turtle",
			"Sanguine Fish",
			"Frost Kingfish",
			"Dark Lionfish",
			"Rainbow Dragonfish",
			"Mirage lanternfish",
			"Nameless Octoparasite",
			"Frost QueenFish",
			"Thunder Bull Shark",
			"Black Tortoise Bloodline",
			"Vermilion Birdblood",
		}
		local function copyBossFishList()
			local copiedList = {}
			for _, fishName in ipairs(bossFishCatalog) do
				table.insert(copiedList, fishName)
			end
			return copiedList
		end
		Hub.BossItems = copyBossFishList()
		local function trimString(rawStr)
			return (string.match(tostring(rawStr or ""), "^%s*(.-)%s*$"))
		end
		local function normalizeTargetSelection(selectionTable)
			local normalizedList = {}
			if type(selectionTable) == "table" then
				for k, v in pairs(selectionTable) do
					local chosenName
					if type(k) == "string" and v == true then
						chosenName = k
					elseif type(v) == "string" and v ~= "" then
						chosenName = v
					end
					if chosenName then
						local lowerTrimmed = string.lower(trimString(chosenName))
						if lowerTrimmed ~= "" and not table.find(normalizedList, lowerTrimmed) then
							table.insert(normalizedList, lowerTrimmed)
						end
					end
				end
			end
			return normalizedList
		end
		local function matchesTargetFish(fishName, targetList)
			local lowerFish = string.lower(trimString(fishName))
			for _, targetPattern in ipairs(targetList) do
				if lowerFish == targetPattern or string.find(lowerFish, targetPattern, 1, true) then
					return true
				end
			end
			return false
		end
		local function extractBaseFishName(invItemName)
			if not invItemName or invItemName == "" then
				return ""
			end
			local strippedName = string.split(invItemName, "| Favorite")[1]
			strippedName = trimString(strippedName)
			local clientModFolder = ReplicatedStorage:FindFirstChild("ClientModule")
			local gameServiceMod = clientModFolder and clientModFolder:FindFirstChild("GameService")
			if gameServiceMod then
				local parseOk, parsedFish = pcall(function()
					local gameService = require(gameServiceMod)
					return gameService and gameService.DestringFish and gameService.DestringFish(strippedName)
				end)
				if parseOk and parsedFish and parsedFish.FishName then
					return parsedFish.FishName
				end
			end
			local commaParts = string.split(strippedName, ",")
			if #commaParts >= 1 and commaParts[1] ~= "" then
				return commaParts[1]
			end
			return strippedName
		end
		local function tryFavoriteFishItem(itemName, targetList)
			if string.find(itemName, "| Favorite", 1, true) then
				return false
			end
			if matchesTargetFish(extractBaseFishName(itemName), targetList) then
				local favEvent = Events:FindFirstChild("FavoriteItem")
				if favEvent then
					pcall(function()
						favEvent:FireServer(itemName)
					end)
					return true
				end
			end
			return false
		end
		function Hub.ScanAndFavoriteBossFish()
			if not Config.AutoFavoriteBoss then
				return
			end
			local invFolder = PlayerData and PlayerData:FindFirstChild("Inventory")
			if not invFolder then
				return
			end
			local favTargets = normalizeTargetSelection(Config.AutoFavoriteBossTarget)
			if #favTargets == 0 then
				return
			end
			for _, invItem in ipairs(invFolder:GetChildren()) do
				if not Config.AutoFavoriteBoss then
					break
				end
				if tryFavoriteFishItem(invItem.Name, favTargets) then
					task.wait(0.15)
				end
			end
		end
		task.spawn(function()
			local invFolder = PlayerData and PlayerData:WaitForChild("Inventory", 10)
			if not invFolder then
				return
			end
			Hub.Track(invFolder.ChildAdded:Connect(function(newChild)
				if not Config.AutoFavoriteBoss then
					return
				end
				task.wait(0.2)
				if not newChild or not newChild.Parent then
					return
				end
				local favTargets = normalizeTargetSelection(Config.AutoFavoriteBossTarget)
				if #favTargets > 0 then
					tryFavoriteFishItem(newChild.Name, favTargets)
				end
			end))
		end)
		local function cancelCurrentFish(sessionToken)
			pcall(function()
				if sessionToken then
					Events.FishingMinigame:FireServer(false, sessionToken, "Unequip")
				end
			end)
			pcall(function()
				ToggleHotbar:InvokeServer("1")
			end)
		end
		listenRemote("FishingMinigame", function(fishInfoTable, minigameArg2, minigameToken)
			if not Config.FilterFishEnabled or type(fishInfoTable) ~= "table" then
				return
			end
			local hookedFishName = tostring(fishInfoTable.FishName or fishInfoTable.Name or fishInfoTable.Fish or "")
			if hookedFishName == "" then
				local progBar = FishingGui and FishingGui:FindFirstChild("ProgressionBar")
				local fishNameLabel = progBar and progBar:FindFirstChild("FishName")
				if fishNameLabel and fishNameLabel:IsA("TextLabel") and fishNameLabel.Text ~= "" then
					hookedFishName = fishNameLabel.Text
				end
			end
			if hookedFishName == "" then
				return
			end
			local filterTargets = normalizeTargetSelection(Config.FilterFishTarget)
			if #filterTargets == 0 then
				return
			end
			if not matchesTargetFish(hookedFishName, filterTargets) then
				task.spawn(function()
					task.wait(0.05)
					cancelCurrentFish(minigameToken)
				end)
			end
		end)
	end
	do
		local lastGiveFishClock = 0
		local function getDumbGuyNpc()
			local npcFolder = workspace:FindFirstChild("NPC")
			local funcFolder = npcFolder and npcFolder:FindFirstChild("Function")
			local dumbGuy = funcFolder and funcFolder:FindFirstChild("Dumb guy")
			if dumbGuy then
				return dumbGuy
			end
			local lookupOk, directNpc = pcall(function()
				return workspace.NPC.Function["Dumb guy"]
			end)
			if lookupOk and directNpc then
				return directNpc
			end
			return workspace:FindFirstChild("Dumb guy", true)
		end
		local function isGiveableFishItem(itemName)
			if not itemName or itemName == "" then
				return false
			end
			if string.find(itemName, "Favorite", 1, true) then
				return false
			end
			local rawPrefix = string.split(itemName, "|")[1] or itemName
			local cleanPrefix = string.gsub(rawPrefix, "^%s*(.-)%s*$", "%1")
			if cleanPrefix == "" or cleanPrefix == "Fishing rod" or string.find(cleanPrefix, "Bait", 1, true) then
				return false
			end
			local invInfo = Info and Info:FindFirstChild("Inventory")
			local itemMod = invInfo and invInfo:FindFirstChild(cleanPrefix)
			local itemData = GetModuleData(itemMod)
			if itemData and itemData.Type == "Fish" then
				return true
			end
			local clientModFolder = ReplicatedStorage:FindFirstChild("ClientModule")
			local gameServiceMod = clientModFolder and clientModFolder:FindFirstChild("GameService")
			if gameServiceMod then
				local parseOk, parsedFish = pcall(function()
					local gameService = require(gameServiceMod)
					return gameService and gameService.DestringFish and gameService.DestringFish(itemName)
				end)
				if parseOk and parsedFish and parsedFish.FishName then
					return true
				end
			end
			if string.find(itemName, "|", 1, true) then
				return true
			end
			return false
		end
		local function findAvailableHotbarSlot()
			local hotbarFolder = PlayerData and PlayerData:FindFirstChild("Hotbar")
			if not hotbarFolder then
				return "4"
			end
			for slotIdx = 4, 10 do
				local slotFolder = hotbarFolder:FindFirstChild(tostring(slotIdx))
				if slotFolder then
					local valNameObj = slotFolder:FindFirstChild("ValueName")
					local qtyObj = slotFolder:FindFirstChild("Quantity")
					if (not valNameObj or valNameObj.Value == "") or (qtyObj and qtyObj.Value <= 0) then
						return tostring(slotIdx)
					end
				end
			end
			return "4"
		end
		function Hub.StepAutoGiveFish()
			if not Config.AutoGiveFish then
				return
			end
			local nowClock = os.clock()
			if nowClock - lastGiveFishClock < 1.2 then
				return
			end
			local pData = PlayerData or (DataFolder and DataFolder:FindFirstChild(tostring(LocalPlayer.UserId)))
			if not pData then
				return
			end
			local dumbGuyNpc = getDumbGuyNpc()
			if not dumbGuyNpc then
				return
			end
			local targetSlotKey = nil
			local hotbarFolder = pData:FindFirstChild("Hotbar")
			if hotbarFolder then
				for slotIdx = 2, 10 do
					local slotFolder = hotbarFolder:FindFirstChild(tostring(slotIdx))
					local valNameObj = slotFolder and slotFolder:FindFirstChild("ValueName")
					local qtyObj = slotFolder and slotFolder:FindFirstChild("Quantity")
					if valNameObj and valNameObj.Value ~= "" and (not qtyObj or qtyObj.Value > 0) then
						if isGiveableFishItem(valNameObj.Value) then
							targetSlotKey = tostring(slotIdx)
							break
						end
					end
				end
			end
			if not targetSlotKey then
				local invFolder = pData:FindFirstChild("Inventory")
				if invFolder then
					local chosenFishItem = nil
					for _, invChild in ipairs(invFolder:GetChildren()) do
						if invChild.Name ~= "" and (not invChild:IsA("ValueBase") or invChild.Value > 0) then
							if isGiveableFishItem(invChild.Name) then
								chosenFishItem = invChild
								break
							end
						end
					end
					if chosenFishItem then
						local freeSlotKey = findAvailableHotbarSlot()
						local moveItemsEvent = Events and Events:FindFirstChild("MoveItems")
						if moveItemsEvent then
							pcall(function()
								moveItemsEvent:FireServer("Inventory", chosenFishItem.Name, freeSlotKey)
							end)
							task.wait(0.25)
						end
						targetSlotKey = freeSlotKey
					end
				end
			end
			if targetSlotKey then
				lastGiveFishClock = os.clock()
				pcall(function()
					ToggleHotbar:InvokeServer(targetSlotKey)
				end)
				task.wait(0.2)
				local giveFishArgs = { [1] = "Dumb guy", [2] = 1, [3] = "GiveFish", [4] = { [1] = dumbGuyNpc } }
				pcall(function()
					ChooseDialogueOption:FireServer(unpack(giveFishArgs))
				end)
			end
		end
	end
	do
		local lastDailyQuestClock = 0
		local lastDailyRewardClock = 0
		function Hub.StepAutoClaimDailyQuest()
			local nowClock = os.clock()
			if nowClock - lastDailyQuestClock < 2 then
				return
			end
			lastDailyQuestClock = nowClock
			pcall(function()
				local pData = PlayerData or (DataFolder and DataFolder:FindFirstChild(tostring(LocalPlayer.UserId)))
				local questFolder = pData and pData:FindFirstChild("Quest")
				local dailyFolder = questFolder and questFolder:FindFirstChild("Daily")
				if not dailyFolder then
					return
				end
				local questInfoMod = Info and Info:FindFirstChild("Quest")
				local questInfoTable = nil
				if questInfoMod then
					pcall(function()
						questInfoTable = require(questInfoMod)
					end)
				end
				local claimQuestEvent = Events and Events:FindFirstChild("ClaimQuest")
				if not claimQuestEvent then
					return
				end
				for _, dailyEntry in ipairs(dailyFolder:GetChildren()) do
					local claimVal = dailyEntry:FindFirstChild("Claim")
					local progVal = dailyEntry:FindFirstChild("Progression")
					local questTypeVal = dailyEntry:FindFirstChild("QuestType")
					if claimVal and progVal and questTypeVal and claimVal.Value == false and questTypeVal.Value ~= "" then
						local reqAmount = nil
						if questInfoTable and questInfoTable.Daily and tonumber(dailyEntry.Name) then
							local dailyDef = questInfoTable.Daily[tonumber(dailyEntry.Name)]
							if dailyDef and dailyDef[2] then
								reqAmount = dailyDef[2]
							end
						end
						if reqAmount then
							local curProg = progVal.Value
							if questTypeVal.Value == "PlayTime" then
								local reqMinutes = math.clamp(math.floor(reqAmount / 60), 1, 999)
								local curMinutes = math.clamp(math.floor(curProg / 60), 0, 999)
								if curMinutes >= reqMinutes then
									claimQuestEvent:FireServer(dailyEntry.Name)
								end
							else
								if curProg >= reqAmount then
									claimQuestEvent:FireServer(dailyEntry.Name)
								end
							end
						end
					end
				end
			end)
		end
		function Hub.StepAutoClaimDailyReward()
			local nowClock = os.clock()
			if nowClock - lastDailyRewardClock < 5 then
				return
			end
			lastDailyRewardClock = nowClock
			pcall(function()
				local pData = PlayerData or (DataFolder and DataFolder:FindFirstChild(tostring(LocalPlayer.UserId)))
				local dailyRewardFolder = pData and pData:FindFirstChild("DailyReward")
				if not dailyRewardFolder then
					return
				end
				local dayCycleVal = dailyRewardFolder:FindFirstChild("DayCycle")
				local dayCycleStr = dayCycleVal and dayCycleVal.Value
				if not dayCycleStr or dayCycleStr == "" then
					return
				end
				local currentDayIndex = math.floor(workspace:GetServerTimeNow() / 86400)
				local lastClaimedDay = tonumber(dayCycleStr)
				local canClaimToday = (lastClaimedDay == nil) or (lastClaimedDay < currentDayIndex)
				if not canClaimToday then
					return
				end
				local dailyRewardEvent = Events and Events:FindFirstChild("DailyReward")
				if not dailyRewardEvent then
					return
				end
				for dayNum = 1, 7 do
					local dayVal = dailyRewardFolder:FindFirstChild(tostring(dayNum))
					if dayVal and dayVal.Value == false then
						local isEligible = false
						if dayNum == 1 then
							isEligible = true
						else
							local prevDayVal = dailyRewardFolder:FindFirstChild(tostring(dayNum - 1))
							isEligible = prevDayVal and prevDayVal.Value == true
						end
						if isEligible then
							dailyRewardEvent:FireServer(dayNum)
							break
						end
					end
				end
			end)
		end
	end
	do
		local function findLocalScriptFile()
			local candidatePaths =
				{ "MosCuChillDe.lua", "MosCuChillDe.txt", "MosHub/MosCuChillDe.lua", "MosHub/MosCuChillDe.txt" }
			for _, filePath in ipairs(candidatePaths) do
				local checkOk, exists = pcall(function()
					return isfile and isfile(filePath)
				end)
				if checkOk and exists then
					return filePath
				end
			end
			return nil
		end
		local hasQueuedTeleport = false
		function Hub.QueueReExecute()
			if hasQueuedTeleport then
				return
			end
			if not (Config.AutoExe or Config.AutoHopSacredBeast or Config.AutoHopWeather) then
				return
			end
			local queueTeleportFn = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
			if not queueTeleportFn then
				return
			end
			local function quoteLuaString(rawStr)
				local escapedStr = string.gsub(rawStr, '[\\"\n\r]', function(ch)
					if ch == "\n" then
						return "\\n"
					end
					if ch == "\r" then
						return "\\r"
					end
					return "\\" .. ch
				end)
				return '"' .. escapedStr .. '"'
			end
			local loaderCode
			local scriptPath = findLocalScriptFile()
			if scriptPath then
				loaderCode = "loadstring(readfile(" .. quoteLuaString(scriptPath) .. "))()"
			elseif type(GlobalEnv.MosCuChillDe_URL) == "string" and GlobalEnv.MosCuChillDe_URL ~= "" then
				loaderCode = "loadstring(game:HttpGet(" .. quoteLuaString(GlobalEnv.MosCuChillDe_URL) .. "))()"
			end
			if not loaderCode then
				pcall(function()
					Fluent:Notify({
						Title = "Auto Execute",
						Content = "Save this script as MosCuChillDe.lua in your executor workspace folder to re-run after hopping.",
						Duration = 6,
					})
				end)
				return
			end
			hasQueuedTeleport = true
			pcall(function()
				queueTeleportFn(
					'repeat task.wait(0.5) until game:IsLoaded()\nrepeat task.wait(0.5) until game:GetService("Players").LocalPlayer\nrepeat task.wait(0.5) until workspace:FindFirstChild("Terrain") and (#workspace:GetChildren() > 10)\ntask.wait(2)\nlocal ok, err = pcall(function() '
						.. loaderCode
						.. ' end)\nif not ok then warn("[MosCuChillDe] auto execute failed: " .. tostring(err)) end\n'
				)
			end)
		end
		pcall(function()
			Hub.Track(LocalPlayer.OnTeleport:Connect(function()
				Hub.QueueReExecute()
			end))
		end)
		pcall(function()
			Hub.Track(TeleportService.TeleportInitFailed:Connect(function()
				hasQueuedTeleport = false
			end))
		end)
		function Hub.DoServerHop(hopMode)
			task.spawn(function()
				local placeId = game.PlaceId
				local currentJobId = game.JobId
				local httpRequestFn = (syn and syn.request)
					or (http and http.request)
					or http_request
					or (fluxus and fluxus.request)
					or request
				local chosenServer = nil
				local wantLowPlayers = (hopMode == "low")
				pcall(function()
					Fluent:Notify({
						Title = "Server Hop",
						Content = wantLowPlayers and "Searching for low player server..." or "Searching for a server...",
						Duration = 4,
					})
				end)
				local pageCursor = ""
				local pageAttempts = 0
				local sortOrder = wantLowPlayers and "Asc" or "Desc"
				while pageAttempts < 5 and not chosenServer do
					pageAttempts = pageAttempts + 1
					local apiUrl = "https://games.roblox.com/v1/games/"
						.. tostring(placeId)
						.. "/servers/Public?sortOrder="
						.. sortOrder
						.. "&limit=100"
					if pageCursor ~= "" then
						apiUrl = apiUrl .. "&cursor=" .. pageCursor
					end
					local responseBody = nil
					if httpRequestFn then
						local reqOk, httpResp = pcall(httpRequestFn, { Url = apiUrl, Method = "GET" })
						if reqOk and httpResp and httpResp.Body then
							responseBody = httpResp.Body
						end
					else
						local getOk, getBody = pcall(game.HttpGet, game, apiUrl)
						if getOk then
							responseBody = getBody
						end
					end
					if not responseBody then
						break
					end
					local decodedPage = nil
					pcall(function()
						decodedPage = HttpService:JSONDecode(responseBody)
					end)
					if not (decodedPage and decodedPage.data) then
						break
					end
					local validServers = {}
					for _, srvEntry in ipairs(decodedPage.data) do
						if type(srvEntry) == "table" and srvEntry.id and srvEntry.id ~= currentJobId then
							local playingCount = tonumber(srvEntry.playing) or 0
							local maxPlayers = tonumber(srvEntry.maxPlayers) or 1
							if playingCount < maxPlayers and playingCount > 0 then
								table.insert(validServers, srvEntry)
							end
						end
					end
					if #validServers > 0 then
						if wantLowPlayers then
							table.sort(validServers, function(srvA, srvB)
								return (tonumber(srvA.playing) or 0) < (tonumber(srvB.playing) or 0)
							end)
							chosenServer = validServers[1]
						else
							chosenServer = validServers[math.random(1, #validServers)]
						end
						break
					end
					if decodedPage.nextPageCursor and decodedPage.nextPageCursor ~= "" then
						pageCursor = decodedPage.nextPageCursor
					else
						break
					end
					task.wait(0.5)
				end
				Hub.QueueReExecute()
				if chosenServer and chosenServer.id then
					pcall(function()
						Fluent:Notify({
							Title = "Server Hop",
							Content = "Found server with " .. tostring(chosenServer.playing) .. " players! Teleporting...",
							Duration = 4,
						})
					end)
					task.wait(0.5)
					TeleportService:TeleportToPlaceInstance(placeId, chosenServer.id, LocalPlayer)
				else
					pcall(function()
						Fluent:Notify({ Title = "Server Hop", Content = "Teleporting to random server...", Duration = 4 })
					end)
					task.wait(0.5)
					TeleportService:Teleport(placeId, LocalPlayer)
				end
			end)
		end
		function Hub.GetWeatherList()
			local weatherNames = {}
			local clientMod = ReplicatedStorage:FindFirstChild("ClientModule")
			local weatherFolder = clientMod and clientMod:FindFirstChild("Weather")
			local weatherSubFolder = weatherFolder and weatherFolder:FindFirstChild("Weather")
			if weatherSubFolder then
				for _, weatherEntry in ipairs(weatherSubFolder:GetChildren()) do
					if weatherEntry:IsA("ModuleScript") or weatherEntry:IsA("Folder") then
						table.insert(weatherNames, weatherEntry.Name)
					end
				end
			end
			if #weatherNames == 0 then
				weatherNames = { "Clear", "Rain", "Thunderstorm", "Snow", "Fog", "Windy", "Cloudy", "Solar Eclipse" }
			else
				table.sort(weatherNames)
			end
			return weatherNames
		end
		local function findChuPrompt()
			local npcFolder = workspace:FindFirstChild("NPC")
			local funcFolder = npcFolder and npcFolder:FindFirstChild("Function")
			local chuNpc = funcFolder and funcFolder:FindFirstChild("Chu Tianjiao")
			if chuNpc then
				local chuPrompt = chuNpc:FindFirstChildWhichIsA("ProximityPrompt", true)
				if chuPrompt then
					return chuPrompt
				end
			end
			for _, descPrompt in ipairs(workspace:GetDescendants()) do
				if descPrompt:IsA("ProximityPrompt") then
					local objText = string.lower(tostring(descPrompt.ObjectText or (descPrompt.Parent and descPrompt.Parent.Name) or ""))
					local actionText = string.lower(tostring(descPrompt.ActionText or ""))
					if string.find(objText, "chu", 1, true) or string.find(actionText, "talk", 1, true) then
						return descPrompt
					end
				end
			end
			local fallbackChu = workspace:FindFirstChild("Chu Tianjiao", true)
			if fallbackChu then
				local fallbackPrompt = fallbackChu:FindFirstChildWhichIsA("ProximityPrompt", true)
				if fallbackPrompt then
					return fallbackPrompt
				end
			end
			return nil
		end
		local function triggerChuPrompt(promptObj)
			if not promptObj then
				return false
			end
			local didTrigger = false
			pcall(function()
				promptObj.RequiresLineOfSight = false
				promptObj.MaxActivationDistance = 9999
				promptObj.HoldDuration = 0
				if fireproximityprompt then
					fireproximityprompt(promptObj)
					didTrigger = true
				end
			end)
			return didTrigger
		end
		local function readChuDialogueText()
			local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
			local mainGui = playerGui and playerGui:FindFirstChild("MainGui")
			local menuGui = mainGui and mainGui:FindFirstChild("Menu")
			local dialogueGui = menuGui and menuGui:FindFirstChild("Dialogue")
			if dialogueGui and dialogueGui.Visible then
				for _, descLabel in ipairs(dialogueGui:GetDescendants()) do
					if descLabel:IsA("TextLabel") and descLabel.Visible then
						local cleanText = tostring(descLabel.Text or ""):gsub("^%s*(.-)%s*$", "%1")
						if
							#cleanText > 3
							and not string.find(cleanText, "Close")
							and not string.find(cleanText, "Main Quest")
							and cleanText ~= "???"
							and not string.find(cleanText, "Chu Tianjiao")
						then
							return cleanText
						end
					end
				end
			end
			return nil
		end
		local function interactWithChu(maxWaitSec)
			local char = LocalPlayer.Character or cachedChar
			local hrp = (char and char:FindFirstChild("HumanoidRootPart")) or cachedHrp
			if hrp then
				hrp.CFrame =
					CFrame.new(-2569.52, 15.70, -1405.43, 0.09, 0.00, 1.00, 0.00, 1.00, -0.00, -1.00, 0.00, 0.09)
			end
			task.wait(0.2)
			local startClock = os.clock()
			local timeoutSec = maxWaitSec or 3.0
			local capturedText = ""
			while (os.clock() - startClock) < timeoutSec do
				local promptObj = findChuPrompt()
				if promptObj then
					triggerChuPrompt(promptObj)
				end
				local dialogueText = readChuDialogueText()
				if dialogueText and dialogueText ~= "" then
					capturedText = dialogueText
					break
				end
				task.wait(0.1)
			end
			return (capturedText ~= ""), capturedText
		end
		local function checkSacredBeastDialogue(dialogueText)
			local lowerText = string.lower(dialogueText or "")
			if lowerText == "" then
				return false
			end
			if
				string.find(lowerText, "i can feel it", 1, true)
				or string.find(lowerText, "approaching", 1, true)
				or string.find(lowerText, "don't have any quests", 1, true)
				or string.find(lowerText, "maybe you'll find", 1, true)
			then
				return false
			end
			return string.find(lowerText, "hurry", 1, true) ~= nil
		end
		Hub.CheckChu = interactWithChu
		Hub.IsSacredBeastAppeared = checkSacredBeastDialogue
	end
	do
		local cachedInvLabel, lastInvUiScanClock = nil, 0
		local function parseCapacityFraction(labelText)
			local curStr, maxStr = string.match(labelText or "", "(%d+)%s*/%s*(%d+)")
			local curCount, maxCount = tonumber(curStr), tonumber(maxStr)
			if curCount and maxCount and maxCount >= 10 and curCount >= maxCount then
				return true
			end
			return false, (curCount ~= nil and maxCount ~= nil)
		end
		local function isInventoryRelatedLabel(labelObj)
			local ancestor = labelObj
			for depth = 1, 7 do
				if not ancestor or ancestor == game then
					break
				end
				local lowerAncestorName = string.lower(ancestor.Name)
				if
					string.find(lowerAncestorName, "inv", 1, true)
					or string.find(lowerAncestorName, "bag", 1, true)
					or string.find(lowerAncestorName, "capacity", 1, true)
					or string.find(lowerAncestorName, "storage", 1, true)
					or string.find(lowerAncestorName, "backpack", 1, true)
				then
					return true
				end
				ancestor = ancestor.Parent
			end
			return false
		end
		function Hub.IsInventoryFull()
			local pData = PlayerData or (DataFolder and DataFolder:FindFirstChild(tostring(LocalPlayer.UserId)))
			if pData then
				local invFolder = pData:FindFirstChild("Inventory")
				local limitValObj = pData:FindFirstChild("InventoryLimit")
					or pData:FindFirstChild("MaxInventory")
					or pData:FindFirstChild("BagLimit")
					or pData:FindFirstChild("MaxCapacity")
				local maxCapacity = (limitValObj and tonumber(limitValObj.Value))
					or tonumber(pData:GetAttribute("InventoryLimit"))
					or tonumber(pData:GetAttribute("MaxInventory"))
				if invFolder and maxCapacity and maxCapacity > 0 then
					return #invFolder:GetChildren() >= maxCapacity
				end
			end
			if cachedInvLabel and cachedInvLabel.Parent then
				local isFull, isValidFraction = parseCapacityFraction(cachedInvLabel.Text)
				if isValidFraction then
					return isFull
				end
			end
			local nowClock = os.clock()
			if nowClock - lastInvUiScanClock < 4 then
				return false
			end
			lastInvUiScanClock = nowClock
			local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
			local rootGui = playerGui
				and (
					playerGui:FindFirstChild("MainGui")
					or playerGui:FindFirstChild("ScreenGui")
					or playerGui:FindFirstChild("GameGui")
				)
			if rootGui then
				for _, descLabel in ipairs(rootGui:GetDescendants()) do
					if descLabel:IsA("TextLabel") and string.find(descLabel.Text, "/", 1, true) then
						local isFull, isValidFraction = parseCapacityFraction(descLabel.Text)
						if isValidFraction and isInventoryRelatedLabel(descLabel) then
							cachedInvLabel = descLabel
							return isFull
						end
					end
				end
			end
			return false
		end
	end
	do
		local origHoldDurations = setmetatable({}, { __mode = "k" })
		local function makePromptInstant(promptObj)
			if promptObj:IsA("ProximityPrompt") and promptObj.HoldDuration ~= 0 then
				if origHoldDurations[promptObj] == nil then
					origHoldDurations[promptObj] = promptObj.HoldDuration
				end
				promptObj.HoldDuration = 0
			end
		end
		function Hub.SetInstantInteract(enabled)
			pcall(function()
				if enabled then
					for _, descPrompt in ipairs(workspace:GetDescendants()) do
						if descPrompt:IsA("ProximityPrompt") then
							makePromptInstant(descPrompt)
						end
					end
				else
					for promptObj, origDuration in pairs(origHoldDurations) do
						if promptObj and promptObj.Parent then
							promptObj.HoldDuration = origDuration
						end
					end
					table.clear(origHoldDurations)
				end
			end)
		end
		pcall(function()
			Hub.Track(workspace.DescendantAdded:Connect(function(newDescendant)
				if Config.InstantInteract and newDescendant:IsA("ProximityPrompt") then
					task.wait()
					pcall(makePromptInstant, newDescendant)
				end
			end))
		end)
		pcall(function()
			Hub.Track(game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(heldPrompt)
				if Config.InstantInteract then
					pcall(makePromptInstant, heldPrompt)
					if fireproximityprompt then
						pcall(fireproximityprompt, heldPrompt)
					end
				end
			end))
		end)
		if Config.InstantInteract then
			task.delay(1, function()
				Hub.SetInstantInteract(true)
			end)
		end
		function Hub.SetWalkOnWater(enabled)
			local oceanFolder = workspace:FindFirstChild("Ocean")
			if not oceanFolder then
				return
			end
			for _, waterPart in ipairs(oceanFolder:GetChildren()) do
				if waterPart.Name == "Water" and waterPart:IsA("BasePart") then
					waterPart.CanCollide = enabled
				end
			end
		end
		task.spawn(function()
			local oceanFolder = workspace:WaitForChild("Ocean", 30)
			if not oceanFolder then
				return
			end
			Hub.Track(oceanFolder.ChildAdded:Connect(function(newChild)
				if Config.WalkOnWater and newChild.Name == "Water" and newChild:IsA("BasePart") then
					task.wait()
					newChild.CanCollide = true
				end
			end))
			if Config.WalkOnWater then
				Hub.SetWalkOnWater(true)
			end
		end)
	end
	do
		local isHideActive = false
		local maskedTextCache = setmetatable({}, { __mode = "k" })
		local originalTextCache = setmetatable({}, { __mode = "k" })
		local hookedLabels = setmetatable({}, { __mode = "k" })
		local textChangedConns = setmetatable({}, { __mode = "k" })
		local containerConns = {}
		local charAddedConn = nil
		local realUserName = LocalPlayer.Name
		local realDisplayName = LocalPlayer.DisplayName
		local realUserIdStr = tostring(LocalPlayer.UserId)
		local maskPlaceholder = "\001\002MOSHIDE\002\001"
		local sensitiveTokens = {}
		do
			local seenTokens = {}
			for _, tokenStr in ipairs({ realUserName, realDisplayName, realUserIdStr }) do
				if type(tokenStr) == "string" and #tokenStr >= 3 and not seenTokens[tokenStr] then
					seenTokens[tokenStr] = true
					table.insert(sensitiveTokens, tokenStr)
				end
			end
			table.sort(sensitiveTokens, function(tokA, tokB)
				return #tokA > #tokB
			end)
		end
		local function getReplacementName()
			local customName = string.match(tostring(Config.HideNameText or ""), "^%s*(.-)%s*$")
			if not customName or customName == "" then
				customName = "MosCuChillDe"
			end
			return string.sub(customName, 1, 40)
		end
		local function replacePlainSubstring(sourceStr, searchStr, replStr)
			local chunks, searchIdx, didReplace = {}, 1, false
			while true do
				local matchStart, matchEnd = string.find(sourceStr, searchStr, searchIdx, true)
				if not matchStart then
					break
				end
				table.insert(chunks, string.sub(sourceStr, searchIdx, matchStart - 1))
				table.insert(chunks, replStr)
				searchIdx = matchEnd + 1
				didReplace = true
			end
			if not didReplace then
				return sourceStr, false
			end
			table.insert(chunks, string.sub(sourceStr, searchIdx))
			return table.concat(chunks), true
		end
		local function scrubSensitiveText(inputText)
			if type(inputText) ~= "string" or inputText == "" then
				return inputText, false
			end
			local anyMatched = false
			for _, tokenStr in ipairs(sensitiveTokens) do
				local tokenReplaced
				inputText, tokenReplaced = replacePlainSubstring(inputText, tokenStr, maskPlaceholder)
				if tokenReplaced then
					anyMatched = true
				end
			end
			if not anyMatched then
				return inputText, false
			end
			inputText = replacePlainSubstring(inputText, maskPlaceholder, getReplacementName())
			return inputText, true
		end
		local function isHubGuiElement(guiObj)
			if guiObj:IsDescendantOf(LogoGui) then
				return true
			end
			local fluentGui = Fluent and Fluent.GUI
			if fluentGui and guiObj:IsDescendantOf(fluentGui) then
				return true
			end
			return false
		end
		local function hookTextObject(textObj)
			if not (textObj:IsA("TextLabel") or textObj:IsA("TextButton")) then
				return
			end
			if hookedLabels[textObj] or isHubGuiElement(textObj) then
				return
			end
			hookedLabels[textObj] = true
			local isUpdatingText = false
			local function applyMaskToLabel()
				if isUpdatingText or not isHideActive then
					return
				end
				local currentText = textObj.Text
				local maskedText, wasModified = scrubSensitiveText(currentText)
				if wasModified and maskedText ~= currentText then
					if originalTextCache[textObj] == nil then
						originalTextCache[textObj] = currentText
					end
					isUpdatingText = true
					maskedTextCache[textObj] = maskedText
					textObj.Text = maskedText
					isUpdatingText = false
				end
			end
			applyMaskToLabel()
			textChangedConns[textObj] = textObj:GetPropertyChangedSignal("Text"):Connect(applyMaskToLabel)
		end
		local function watchGuiContainer(container, onlyWorldGuis)
			pcall(function()
				for _, descObj in ipairs(container:GetDescendants()) do
					if not isHideActive then
						return
					end
					if descObj:IsA("TextLabel") or descObj:IsA("TextButton") then
						if
							not onlyWorldGuis
							or descObj:FindFirstAncestorWhichIsA("BillboardGui")
							or descObj:FindFirstAncestorWhichIsA("SurfaceGui")
						then
							hookTextObject(descObj)
						end
					end
				end
			end)
			pcall(function()
				table.insert(
					containerConns,
					container.DescendantAdded:Connect(function(addedObj)
						if not isHideActive then
							return
						end
						if addedObj:IsA("TextLabel") or addedObj:IsA("TextButton") then
							if
								not onlyWorldGuis
								or addedObj:FindFirstAncestorWhichIsA("BillboardGui")
								or addedObj:FindFirstAncestorWhichIsA("SurfaceGui")
							then
								hookTextObject(addedObj)
							end
						end
					end)
				)
			end)
		end
		local function updateCharacterDisplayName(char)
			if not char then
				return
			end
			pcall(function()
				local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 3)
				if hum then
					if isHideActive then
						hum.DisplayName = getReplacementName()
					else
						hum.DisplayName = (realDisplayName ~= "" and realDisplayName) or realUserName
					end
				end
			end)
		end
		local function cleanupHideHooks()
			for _, conn in ipairs(containerConns) do
				pcall(function()
					conn:Disconnect()
				end)
			end
			table.clear(containerConns)
			if charAddedConn then
				pcall(function()
					charAddedConn:Disconnect()
				end)
				charAddedConn = nil
			end
			for labelObj, conn in pairs(textChangedConns) do
				pcall(function()
					conn:Disconnect()
				end)
				textChangedConns[labelObj] = nil
			end
			table.clear(hookedLabels)
		end
		function Hub.ApplyHide(shouldHide)
			if shouldHide == isHideActive then
				return
			end
			isHideActive = shouldHide
			if shouldHide then
				task.spawn(function()
					local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)
					if playerGui and isHideActive then
						watchGuiContainer(playerGui, false)
					end
					if isHideActive then
						watchGuiContainer(workspace, true)
					end
					if isHideActive then
						pcall(function()
							watchGuiContainer(game:GetService("CoreGui"), false)
						end)
					end
				end)
				updateCharacterDisplayName(LocalPlayer.Character)
				charAddedConn = LocalPlayer.CharacterAdded:Connect(function(newChar)
					task.wait(0.5)
					if isHideActive then
						updateCharacterDisplayName(newChar)
					end
				end)
			else
				cleanupHideHooks()
				for labelObj, origText in pairs(originalTextCache) do
					pcall(function()
						if labelObj and labelObj.Parent and labelObj.Text == maskedTextCache[labelObj] then
							labelObj.Text = origText
						end
					end)
				end
				table.clear(originalTextCache)
				table.clear(maskedTextCache)
				updateCharacterDisplayName(LocalPlayer.Character)
			end
		end
		function Hub.SetHideName(newHideName)
			Config.HideNameText = tostring(newHideName or "")
			SaveConfig()
			if isHideActive then
				Hub.ApplyHide(false)
				Hub.ApplyHide(true)
			end
		end
		function Hub.IsHiding()
			return isHideActive
		end
		if Config.HideNameAndID then
			task.delay(1, function()
				Hub.ApplyHide(true)
			end)
		end
	end
	loadingStage = "creating window"
	Window = Fluent:CreateWindow({
		Title = "Mos Hub",
		SubTitle = "by noelnoathebest02 | Heavyweigh Fishing",
		TabWidth = 120,
		Size = UDim2.fromOffset(440, 330),
		Acrylic = false,
		Theme = (table.find(Hub.ThemeList, Config.ThemeName) and Config.ThemeName) or "Darker",
		MinimizeKey = Enum.KeyCode.LeftControl,
	})
	local Tabs = {
		Main = Window:AddTab({ Title = "Main", Icon = "home" }),
		Player = Window:AddTab({ Title = "Player", Icon = "user" }),
		Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
		Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
		ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
		Misc = Window:AddTab({ Title = "Misc", Icon = "layers" }),
		Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
	}
	local FlyToggleObj, NoclipToggleObj
	local lastFlyToggleTick = 0
	local function toggleFly()
		local nowTick = tick()
		if nowTick - lastFlyToggleTick < 0.25 then
			return
		end
		lastFlyToggleTick = nowTick
		if FlyToggleObj then
			FlyToggleObj:SetValue(not Config.FlyEnabled)
		else
			Config.FlyEnabled = not Config.FlyEnabled
			SaveConfig()
			if Config.FlyEnabled then
				startFly()
			else
				stopFly()
			end
		end
	end
	local lastNoclipToggleTick = 0
	local function toggleNoclip()
		local nowTick = tick()
		if nowTick - lastNoclipToggleTick < 0.25 then
			return
		end
		lastNoclipToggleTick = nowTick
		if NoclipToggleObj then
			NoclipToggleObj:SetValue(not Config.NoclipEnabled)
		else
			Config.NoclipEnabled = not Config.NoclipEnabled
			SaveConfig()
		end
	end
	Tabs.Main:AddSection("Auto Ticket Quest")
	Hub.TicketToggle = Tabs.Main:AddToggle("AutoTicketQuestToggle", {
		Title = "Auto Claim Quest Ticket",
		Default = Config.AutoTicketQuest,
		Callback = function(enabled)
			Config.AutoTicketQuest = enabled
			if not enabled then
				lastTicketActionTick = 0
			elseif Hub.ResetTicketLimit then
				Hub.ResetTicketLimit()
			end
			SaveConfig()
		end,
	})
	Tabs.Main:AddDropdown("TicketQuestModeDropdown", {
		Title = "Quest Mode",
		Values = { "Hard", "Easy" },
		Default = Config.TicketQuestMode or "Hard",
		Multi = false,
		Callback = function(selectedMode)
			Config.TicketQuestMode = selectedMode or "Hard"
			SaveConfig()
		end,
	})
	Tabs.Main:AddSection("Zeng Tianguo Quest")
	Tabs.Main:AddToggle("AutoZengTianguoQuestToggle", {
		Title = "Auto Claim Zeng Tianguo Quest",
		Default = Config.AutoZengTianguoQuest,
		Callback = function(enabled)
			Config.AutoZengTianguoQuest = enabled
			SaveConfig()
		end,
	})
	Tabs.Main:AddToggle("AutoFilterZengQuestToggle", {
		Title = "Auto Filter Quest",
		Default = Config.AutoFilterZengQuest,
		Callback = function(enabled)
			Config.AutoFilterZengQuest = enabled
			if enabled then
				pcall(function()
					Fluent:Notify({
						Title = "Auto Filter Quest",
						Content = "Filtering for: Use any skill for 100 times",
						Duration = 4,
					})
				end)
			end
			SaveConfig()
		end,
	})
	Tabs.Main:AddSection("Daily Quest")
	Tabs.Main:AddToggle("AutoClaimDailyQuestToggle", {
		Title = "Auto Claim Daily Quest",
		Default = Config.AutoClaimDailyQuest,
		Callback = function(enabled)
			Config.AutoClaimDailyQuest = enabled
			SaveConfig()
		end,
	})
	Tabs.Main:AddSection("Auto Farm Fish")
	do
		local islandOptions = GetIslandList()
		if (Config.SelectedFarmIsland == "" or not table.find(islandOptions, Config.SelectedFarmIsland)) and #islandOptions > 0 then
			Config.SelectedFarmIsland = islandOptions[1]
		end
		Tabs.Main:AddDropdown("SelectIslandFarmDropdown", {
			Title = "Select Island",
			Values = islandOptions,
			Default = Config.SelectedFarmIsland ~= "" and Config.SelectedFarmIsland or islandOptions[1],
			Multi = false,
			Callback = function(selectedIsland)
				Config.SelectedFarmIsland = selectedIsland or ""
				SaveConfig()
				if Config.AutoFarmIsland then
					StepAutoFarmIsland(LocalPlayer.Character)
				end
			end,
		})
	end
	Tabs.Main:AddToggle("AutoFarmIslandToggle", {
		Title = "Auto Farm",
		Default = Config.AutoFarmIsland,
		Callback = function(enabled)
			Config.AutoFarmIsland = enabled
			SaveConfig()
			if enabled then
				StepAutoFarmIsland(LocalPlayer.Character)
				if LocalPlayer.Character then
					CleanDebuffs(LocalPlayer.Character)
				end
			end
		end,
	})
	Tabs.Main:AddSection("Fishing")
	Tabs.Main:AddToggle("AutoCastToggle", {
		Title = "Auto Cast",
		Default = Config.AutoCast,
		Callback = function(enabled)
			Config.AutoCast = enabled
			SaveConfig()
		end,
	})
	Tabs.Main:AddDropdown("AutoCastMethodDropdown", {
		Title = "Cast Method",
		Values = { "Instant", "Delay" },
		Default = Config.AutoCastMethod or "Instant",
		Multi = false,
		Callback = function(selectedMethod)
			Config.AutoCastMethod = selectedMethod or "Instant"
			SaveConfig()
		end,
	})
	Tabs.Main:AddSlider("CastDelaySlider", {
		Title = "Cast Delay Sec",
		Default = Config.CastDelay or 1,
		Min = 1,
		Max = 10,
		Rounding = 1,
		Callback = function(delaySec)
			Config.CastDelay = delaySec
			SaveConfig()
		end,
	})
	Tabs.Main:AddToggle("AutoReelToggle", {
		Title = "Auto Reel",
		Default = Config.AutoReel,
		Callback = function(enabled)
			Config.AutoReel = enabled
			SaveConfig()
		end,
	})
	Tabs.Main:AddSlider("ReelDelaySlider", {
		Title = "Reel Delay Sec",
		Default = Config.ReelDelay or 0.35,
		Min = 0.05,
		Max = 2,
		Rounding = 2,
		Callback = function(delaySec)
			Config.ReelDelay = delaySec
			SaveConfig()
		end,
	})
	Tabs.Main:AddToggle("AutoEquipBestBaitToggle", {
		Title = "Auto Equip Best Bait",
		Default = Config.AutoEquipBestBait,
		Callback = function(enabled)
			Config.AutoEquipBestBait = enabled
			if enabled then
				task.spawn(function()
					StepAutoEquipBestBait(true)
				end)
			end
			SaveConfig()
		end,
	})
	Tabs.Main:AddSection("Equipment")
	Tabs.Main:AddButton({ Title = "Equip Best Rod", Callback = EquipBestRod })
	Tabs.Main:AddButton({
		Title = "Equip Best Bait",
		Callback = function()
			task.spawn(function()
				StepAutoEquipBestBait(true)
			end)
		end,
	})
	Tabs.Main:AddButton({ Title = "Equip Best Orb", Callback = EquipBestOrb })
	Tabs.Main:AddSection("Skill")
	Tabs.Main:AddToggle("AutoSkillToggle", {
		Title = "Auto Skill",
		Default = Config.AutoSkill,
		Callback = function(enabled)
			Config.AutoSkill = enabled
			if enabled and LocalPlayer.Character then
				CleanDebuffs(LocalPlayer.Character)
			end
			SaveConfig()
		end,
	})
	local allSkillKeys = { "Z", "X", "C", "V" }
	local defaultSkillMap = {}
	for _, skillKey in ipairs(Config.SkillOrder) do
		defaultSkillMap[skillKey] = true
	end
	local skillDropdown = Tabs.Main:AddDropdown(
		"SelectSkillDropdown",
		{ Title = "Select Skill", Values = allSkillKeys, Default = defaultSkillMap, Multi = true }
	)
	local origDisplayFn = skillDropdown.Display
	if origDisplayFn then
		skillDropdown.Display = function(dropdownSelf, ...)
			local origValues = dropdownSelf.Values
			dropdownSelf.Values = Config.SkillOrder
			local displayRes = origDisplayFn(dropdownSelf, ...)
			dropdownSelf.Values = origValues
			return displayRes
		end
	end
	skillDropdown:OnChanged(function(selectedMap)
		if type(selectedMap) ~= "table" then
			return
		end
		for idx = #Config.SkillOrder, 1, -1 do
			local existingKey = Config.SkillOrder[idx]
			if not selectedMap[existingKey] then
				table.remove(Config.SkillOrder, idx)
			end
		end
		for _, keyName in ipairs(allSkillKeys) do
			if selectedMap[keyName] and not table.find(Config.SkillOrder, keyName) then
				table.insert(Config.SkillOrder, keyName)
			end
		end
		if skillDropdown.Display then
			skillDropdown:Display()
		end
		SaveConfig()
	end)
	if skillDropdown.Display then
		skillDropdown:Display()
	end
	Tabs.Main:AddSection("Boss")
	do
		local bossModes = { "Normal", "Hard", "Nightmare" }
		if not table.find(bossModes, Config.BossMode) then
			Config.BossMode = "Normal"
		end
		Tabs.Main:AddDropdown("SelectBossModeDropdown", {
			Title = "Select Boss Mode",
			Values = bossModes,
			Default = Config.BossMode,
			Multi = false,
			Callback = function(selectedMode)
				Config.BossMode = selectedMode or "Normal"
				SaveConfig()
			end,
		})
	end
	Tabs.Main:AddToggle("AutoBossToggle", {
		Title = "Auto Enzo",
		Default = Config.AutoBoss,
		Callback = function(enabled)
			Config.AutoBoss = enabled
			SaveConfig()
			if enabled then
				task.spawn(function()
					StepAutoBossSpawn(false)
				end)
			end
		end,
	})
	Tabs.Main:AddToggle("AutoSecretBossToggle", {
		Title = "Auto Long DiaoHai",
		Default = Config.AutoSecretBoss,
		Callback = function(enabled)
			Config.AutoSecretBoss = enabled
			SaveConfig()
			if enabled then
				task.spawn(function()
					StepAutoBossSpawn(true)
				end)
			end
		end,
	})
	Tabs.Main:AddToggle("AutoMiniGameToggle", {
		Title = "Auto Mini Game",
		Default = Config.AutoMiniGame,
		Callback = function(enabled)
			Config.AutoMiniGame = enabled
			if enabled and LocalPlayer.Character then
				CleanDebuffs(LocalPlayer.Character)
			end
			SaveConfig()
		end,
	})
	Tabs.Main:AddSlider("MiniGameDelaySlider", {
		Title = "Mini Game Delay Sec",
		Default = Config.MiniGameDelay or 0.12,
		Min = 0.03,
		Max = 0.5,
		Rounding = 2,
		Callback = function(delaySec)
			Config.MiniGameDelay = delaySec
			SaveConfig()
		end,
	})
	Tabs.Main:AddSection("Filter Boss")
	Tabs.Main:AddToggle("FilterBossToggle", {
		Title = "Filter Boss",
		Default = Config.FilterFishEnabled,
		Callback = function(enabled)
			Config.FilterFishEnabled = enabled
			SaveConfig()
		end,
	})
	do
		local bossItemsList = Hub.BossItems or {}
		local function injectDropdownSearchBox()
			task.spawn(function()
				task.wait(0.3)
				pcall(function()
					local rootGui = Fluent.GUI or (LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("ScreenGui"))
					if not rootGui then
						return
					end
					for _, scrollFrame in ipairs(rootGui:GetDescendants()) do
						if
							scrollFrame:IsA("ScrollingFrame")
							and scrollFrame.Parent
							and scrollFrame.Parent:IsA("Frame")
							and scrollFrame.Parent.Parent
							and scrollFrame.Parent.Parent:IsA("Frame")
						then
							local dropdownHolder = scrollFrame.Parent
							local listLayout = scrollFrame:FindFirstChildOfClass("UIListLayout")
							if listLayout and not dropdownHolder:FindFirstChild("DropdownSearchBox") then
								local isBossDropdown = false
								for _, itemBtn in ipairs(scrollFrame:GetChildren()) do
									if itemBtn:IsA("TextButton") and itemBtn:FindFirstChild("ButtonLabel") then
										if table.find(bossItemsList, itemBtn.ButtonLabel.Text) then
											isBossDropdown = true
											break
										end
									end
								end
								if isBossDropdown then
									local searchBox = Instance.new("TextBox")
									searchBox.Name = "DropdownSearchBox"
									searchBox.Size = UDim2.new(1, -12, 0, 26)
									searchBox.Position = UDim2.new(0, 6, 0, 6)
									searchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
									searchBox.BackgroundTransparency = 0.6
									searchBox.Text = ""
									searchBox.TextColor3 = Color3.fromRGB(240, 240, 240)
									searchBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 170)
									searchBox.PlaceholderText = "Search boss..."
									searchBox.Font = Enum.Font.Gotham
									searchBox.TextSize = 12
									searchBox.TextXAlignment = Enum.TextXAlignment.Left
									searchBox.ClearTextOnFocus = false
									searchBox.Parent = dropdownHolder
									Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 5)
									local boxPadding = Instance.new("UIPadding", searchBox)
									boxPadding.PaddingLeft = UDim.new(0, 8)
									boxPadding.PaddingRight = UDim.new(0, 8)
									scrollFrame.Position = UDim2.new(0, 5, 0, 36)
									scrollFrame.Size = UDim2.new(1, -5, 1, -42)
									searchBox:GetPropertyChangedSignal("Text"):Connect(function()
										local searchQuery = string.lower(string.match(searchBox.Text, "^%s*(.-)%s*$") or "")
										for _, itemBtn in ipairs(scrollFrame:GetChildren()) do
											if itemBtn:IsA("TextButton") and itemBtn:FindFirstChild("ButtonLabel") then
												local itemText = string.lower(itemBtn.ButtonLabel.Text)
												itemBtn.Visible = (
													searchQuery == "" or string.find(itemText, searchQuery, 1, true) ~= nil
												)
											end
										end
										scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
									end)
								end
							end
						end
					end
				end)
			end)
		end
		local function sanitizeSavedBossList(rawTable)
			local validList = {}
			if type(rawTable) == "table" then
				for k, v in pairs(rawTable) do
					local fishName
					if type(k) == "string" and v == true then
						fishName = k
					elseif type(v) == "string" and v ~= "" then
						fishName = v
					end
					if fishName and table.find(bossItemsList, fishName) and not table.find(validList, fishName) then
						table.insert(validList, fishName)
					end
				end
			end
			return validList
		end
		local function extractSelectedBosses(dropdownState)
			local selectedList = {}
			if type(dropdownState) == "table" then
				for fishName, isSelected in pairs(dropdownState) do
					if isSelected and table.find(bossItemsList, fishName) and not table.find(selectedList, fishName) then
						table.insert(selectedList, fishName)
					end
				end
			end
			return selectedList
		end
		Config.FilterFishTarget = sanitizeSavedBossList(Config.FilterFishTarget)
		Tabs.Main:AddDropdown("FilterBossDropdown", {
			Title = "Select Boss",
			Values = bossItemsList,
			Default = Config.FilterFishTarget,
			Multi = true,
			Callback = function(selection)
				Config.FilterFishTarget = extractSelectedBosses(selection)
				SaveConfig()
			end,
		})
		injectDropdownSearchBox()
		Tabs.Main:AddSection("Auto Favorite Boss")
		Tabs.Main:AddToggle("AutoFavoriteBossToggle", {
			Title = "Auto Favorite Boss Fish",
			Default = Config.AutoFavoriteBoss,
			Callback = function(enabled)
				Config.AutoFavoriteBoss = enabled
				SaveConfig()
				if enabled then
					task.spawn(Hub.ScanAndFavoriteBossFish)
				end
			end,
		})
		Config.AutoFavoriteBossTarget = sanitizeSavedBossList(Config.AutoFavoriteBossTarget)
		Tabs.Main:AddDropdown("AutoFavoriteBossDropdown", {
			Title = "Select Boss Fish",
			Values = bossItemsList,
			Default = Config.AutoFavoriteBossTarget,
			Multi = true,
			Callback = function(selection)
				Config.AutoFavoriteBossTarget = extractSelectedBosses(selection)
				SaveConfig()
				if Config.AutoFavoriteBoss then
					task.spawn(Hub.ScanAndFavoriteBossFish)
				end
			end,
		})
		injectDropdownSearchBox()
	end
	Tabs.Main:AddSection("Sacred Beast Hop")
	do
		local sacredBeastToggle
		local function runSacredBeastCheck()
			local hasDialogue, chuText = Hub.CheckChu(3.5)
			if not Config.AutoHopSacredBeast then
				return
			end
			local beastAppeared = Hub.IsSacredBeastAppeared(chuText)
			pcall(function()
				local notifyMsg = (chuText and chuText ~= "") and chuText or "No dialogue"
				if not beastAppeared then
					notifyMsg = notifyMsg .. " (Hopping in 5s...)"
				end
				Fluent:Notify({ Title = "Sacred Beast Hop", Content = notifyMsg, Duration = 6 })
			end)
			if beastAppeared then
				Config.AutoHopSacredBeast = false
				SaveConfig()
				if sacredBeastToggle then
					pcall(function()
						sacredBeastToggle:SetValue(false)
					end)
				end
			else
				task.wait(5)
				if Config.AutoHopSacredBeast and not Hub.Unloaded then
					Hub.DoServerHop("normal")
				end
			end
		end
		sacredBeastToggle = Tabs.Main:AddToggle("AutoHopSacredBeastToggle", {
			Title = "Auto Hop Sacred Beast",
			Default = Config.AutoHopSacredBeast,
			Callback = function(enabled)
				Config.AutoHopSacredBeast = enabled
				SaveConfig()
				if enabled then
					task.spawn(runSacredBeastCheck)
				end
			end,
		})
		task.spawn(function()
			task.wait(2.5)
			if not Config.AutoHopSacredBeast then
				return
			end
			repeat
				task.wait(0.2)
			until (
					game:IsLoaded()
					and LocalPlayer.Character
					and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character:FindFirstChild("Head"))
				) or not Config.AutoHopSacredBeast
			if not Config.AutoHopSacredBeast then
				return
			end
			task.wait(1)
			runSacredBeastCheck()
		end)
	end
	Tabs.Main:AddSection("Position")
	Tabs.Main:AddButton({
		Title = "Save Position",
		Callback = function()
			local char = LocalPlayer.Character
			local hrp = (char and char:FindFirstChild("HumanoidRootPart")) or cachedHrp
			if hrp then
				Config.SavedPos = { hrp.CFrame:GetComponents() }
				SaveConfig()
				pcall(function()
					Fluent:Notify({ Title = "Position", Content = "Saved Position!", Duration = 3 })
				end)
			end
		end,
	})
	Tabs.Main:AddToggle("AutoTPPosToggle", {
		Title = "Auto TP Position",
		Default = Config.AutoTPPos,
		Callback = function(enabled)
			Config.AutoTPPos = enabled
			SaveConfig()
			if enabled then
				StepAutoTPPos(LocalPlayer.Character)
			end
		end,
	})
	Tabs.Main:AddButton({
		Title = "Delete Position",
		Callback = function()
			Config.SavedPos = false
			SaveConfig()
			pcall(function()
				Fluent:Notify({ Title = "Position", Content = "Deleted Position!", Duration = 3 })
			end)
		end,
	})
	Tabs.Player:AddSection("Movement")
	Tabs.Player:AddToggle("LoopSpeedToggle", {
		Title = "Walk Speed",
		Default = Config.LoopSpeedEnabled,
		Callback = function(enabled)
			Config.LoopSpeedEnabled = enabled
			SaveConfig()
		end,
	})
	Tabs.Player:AddSlider("WalkSpeedSlider", {
		Title = "Speed",
		Default = Config.WalkSpeed,
		Min = 16,
		Max = 250,
		Rounding = 0,
		Callback = function(speedVal)
			Config.WalkSpeed = speedVal
			SaveConfig()
		end,
	})
	FlyToggleObj = Tabs.Player:AddToggle("FlyToggle", {
		Title = "Fly",
		Default = Config.FlyEnabled,
		Callback = function(enabled)
			Config.FlyEnabled = enabled
			SaveConfig()
			if enabled then
				startFly()
			else
				stopFly()
			end
		end,
	})
	Tabs.Player:AddSlider("FlySpeedSlider", {
		Title = "Fly Speed",
		Default = Config.FlySpeed,
		Min = 1,
		Max = 20,
		Rounding = 1,
		Callback = function(flySpeedVal)
			Config.FlySpeed = flySpeedVal
			SaveConfig()
		end,
	})
	NoclipToggleObj = Tabs.Player:AddToggle("NoclipToggle", {
		Title = "Noclip",
		Default = Config.NoclipEnabled,
		Callback = function(enabled)
			Config.NoclipEnabled = enabled
			SaveConfig()
		end,
	})
	Tabs.Player:AddToggle("InfJumpToggle", {
		Title = "Infinite Jump",
		Default = Config.InfJumpEnabled,
		Callback = function(enabled)
			Config.InfJumpEnabled = enabled
			SaveConfig()
		end,
	})
	Tabs.Player:AddToggle("WalkOnWaterToggle", {
		Title = "Walk On Water",
		Default = Config.WalkOnWater,
		Callback = function(enabled)
			Config.WalkOnWater = enabled
			SaveConfig()
			pcall(Hub.SetWalkOnWater, enabled)
		end,
	})
	Tabs.Player:AddSection("Utility")
	Tabs.Player:AddToggle("InstantInteractToggle", {
		Title = "Instant Interact",
		Default = Config.InstantInteract,
		Callback = function(enabled)
			Config.InstantInteract = enabled
			SaveConfig()
			Hub.SetInstantInteract(enabled)
		end,
	})
	Tabs.Player:AddSection("Hide Name")
	Tabs.Player:AddToggle("HideNameAndIDToggle", {
		Title = "Hide Name & ID",
		Default = Config.HideNameAndID,
		Callback = function(enabled)
			Config.HideNameAndID = enabled
			SaveConfig()
			Hub.ApplyHide(enabled)
		end,
	})
	Tabs.Player:AddInput("HideNameInput", {
		Title = "Hide Name Custom",
		Default = Config.HideNameText,
		Placeholder = "Type any name...",
		Numeric = false,
		Finished = true,
		Callback = function(inputText)
			Hub.SetHideName(inputText)
			pcall(function()
				Fluent:Notify({
					Title = "Hide Name",
					Content = "Hidden name: " .. tostring(Config.HideNameText),
					Duration = 3,
				})
			end)
		end,
	})
	Tabs.Teleport:AddSection("Island")
	do
		local islandOptions = GetIslandList()
		if (Config.SelectedIsland == "" or not table.find(islandOptions, Config.SelectedIsland)) and #islandOptions > 0 then
			Config.SelectedIsland = islandOptions[1]
		end
		Tabs.Teleport:AddDropdown("SelectIslandDropdown", {
			Title = "Select Island",
			Values = islandOptions,
			Default = Config.SelectedIsland ~= "" and Config.SelectedIsland or islandOptions[1],
			Multi = false,
			Callback = function(selectedIsland)
				Config.SelectedIsland = selectedIsland or ""
				SaveConfig()
			end,
		})
	end
	Tabs.Teleport:AddButton({
		Title = "Teleport To Island",
		Callback = function()
			TeleportToIsland(Config.SelectedIsland)
		end,
	})
	Tabs.Teleport:AddSection("NPC")
	do
		local npcOptions = GetNPCList()
		if (Config.SelectedNPC == "" or not table.find(npcOptions, Config.SelectedNPC)) and #npcOptions > 0 then
			Config.SelectedNPC = npcOptions[1]
		end
		local npcDropdown = Tabs.Teleport:AddDropdown("SelectNPCDropdown", {
			Title = "Select NPC",
			Values = npcOptions,
			Default = Config.SelectedNPC ~= "" and Config.SelectedNPC or npcOptions[1],
			Multi = false,
			Callback = function(selectedNpc)
				Config.SelectedNPC = selectedNpc or ""
				SaveConfig()
			end,
		})
		Tabs.Teleport:AddButton({
			Title = "Teleport To NPC",
			Callback = function()
				local chosenNpc = (npcDropdown and npcDropdown.Value) or Config.SelectedNPC
				TeleportToNPC(chosenNpc)
			end,
		})
		Tabs.Teleport:AddButton({
			Title = "Refresh NPC List",
			Callback = function()
				local refreshedNpcs = GetNPCList()
				if #refreshedNpcs > 0 then
					pcall(function()
						npcDropdown:SetValues(refreshedNpcs)
					end)
					if not table.find(refreshedNpcs, Config.SelectedNPC) then
						Config.SelectedNPC = refreshedNpcs[1]
						pcall(function()
							npcDropdown:SetValue(refreshedNpcs[1])
						end)
						SaveConfig()
					end
				end
			end,
		})
	end
	Tabs.Teleport:AddSection("Player")
	do
		local playerOptions = GetPlayerList()
		if #playerOptions == 0 then
			playerOptions = { "None" }
		end
		if (Config.SelectedPlayer == "" or not table.find(playerOptions, Config.SelectedPlayer)) and #playerOptions > 0 then
			Config.SelectedPlayer = playerOptions[1]
		end
		local playerDropdown = Tabs.Teleport:AddDropdown("SelectPlayerDropdown", {
			Title = "Select Player",
			Values = playerOptions,
			Default = Config.SelectedPlayer ~= "" and Config.SelectedPlayer or playerOptions[1],
			Multi = false,
			Callback = function(selectedPlr)
				Config.SelectedPlayer = selectedPlr or ""
				SaveConfig()
			end,
		})
		local function refreshPlayerDropdown()
			local updatedPlayers = GetPlayerList()
			if #updatedPlayers == 0 then
				updatedPlayers = { "None" }
			end
			if playerDropdown and playerDropdown.SetValues then
				playerDropdown:SetValues(updatedPlayers)
				if not table.find(updatedPlayers, Config.SelectedPlayer) then
					playerDropdown:SetValue(updatedPlayers[1])
					Config.SelectedPlayer = updatedPlayers[1]
					SaveConfig()
				end
			end
		end
		Players.PlayerAdded:Connect(function()
			task.wait(0.5)
			refreshPlayerDropdown()
		end)
		Players.PlayerRemoving:Connect(function()
			task.wait(0.5)
			refreshPlayerDropdown()
		end)
		Tabs.Teleport:AddButton({
			Title = "Teleport To Player",
			Callback = function()
				local targetPlrName = (playerDropdown and playerDropdown.Value) or Config.SelectedPlayer
				if targetPlrName and targetPlrName ~= "None" then
					TeleportToPlayer(targetPlrName)
				end
			end,
		})
	end
	Tabs.Shop:AddSection("Selling")
	Tabs.Shop:AddToggle("AutoSellToggle", {
		Title = "Auto Sell All",
		Default = Config.AutoSell,
		Callback = function(enabled)
			Config.AutoSell = enabled
			if not enabled then
				lastAutoSellClock = 0
			end
			SaveConfig()
		end,
	})
	Tabs.Shop:AddDropdown("AutoSellMethodDropdown", {
		Title = "Sell Method",
		Values = { "Spam", "Delay", "Sell When Full Inventory" },
		Default = Config.AutoSellMethod or "Delay",
		Multi = false,
		Callback = function(selectedMethod)
			Config.AutoSellMethod = selectedMethod or "Delay"
			SaveConfig()
		end,
	})
	Tabs.Shop:AddSlider("AutoSellDelaySlider", {
		Title = "Sell Delay Min",
		Default = Config.SellDelay or 1,
		Min = 1,
		Max = 10,
		Rounding = 1,
		Callback = function(delayMins)
			Config.SellDelay = delayMins
			SaveConfig()
		end,
	})
	Tabs.Shop:AddButton({
		Title = "Sell All Fish",
		Callback = function()
			SellFish:FireServer("All")
		end,
	})
	Tabs.Shop:AddButton({
		Title = "Sell One Fish",
		Callback = function()
			SellFish:FireServer("One")
		end,
	})
	Tabs.Shop:AddSection("Buy Bait")
	do
		local buyableBaitOptions = GetBuyableBaits()
		if Config.SelectedBuyBait == "" and #buyableBaitOptions > 0 then
			Config.SelectedBuyBait = buyableBaitOptions[1]
		end
		Tabs.Shop:AddDropdown("SelectBuyBaitDropdown", {
			Title = "Select Bait",
			Values = buyableBaitOptions,
			Default = Config.SelectedBuyBait ~= "" and Config.SelectedBuyBait or buyableBaitOptions[1],
			Multi = false,
			Callback = function(selectedBait)
				Config.SelectedBuyBait = selectedBait or ""
				SaveConfig()
			end,
		})
	end
	Tabs.Shop:AddInput("BuyBaitAmountInput", {
		Title = "Buy Amount",
		Default = tostring(Config.BuyBaitAmount or 1),
		Numeric = true,
		Finished = false,
		Placeholder = "1",
		Callback = function(amountStr)
			Config.BuyBaitAmount = math.max(1, math.floor(tonumber(amountStr) or 1))
			SaveConfig()
		end,
	})
	Tabs.Shop:AddInput("BuyBaitDelayInput", {
		Title = "Buy Delay Min",
		Default = tostring(Config.BuyBaitDelay or 1),
		Numeric = true,
		Finished = false,
		Placeholder = "1",
		Callback = function(delayStr)
			Config.BuyBaitDelay = math.max(1, math.floor(tonumber(delayStr) or 1))
			SaveConfig()
		end,
	})
	Tabs.Shop:AddToggle("AutoBuyBaitToggle", {
		Title = "Auto Buy Bait",
		Default = Config.AutoBuyBait,
		Callback = function(enabled)
			Config.AutoBuyBait = enabled
			if not enabled then
				lastAutoBuyBaitClock = 0
			end
			SaveConfig()
		end,
	})
	Tabs.Shop:AddButton({
		Title = "Buy Bait",
		Callback = function()
			DoBuyBait(Config.SelectedBuyBait, Config.BuyBaitAmount)
		end,
	})
	Tabs.Shop:AddToggle("AutoBuyBestRodToggle", {
		Title = "Auto Buy Best Rod",
		Default = Config.AutoBuyBestRod,
		Callback = function(enabled)
			Config.AutoBuyBestRod = enabled
			SaveConfig()
		end,
	})
	Tabs.Shop:AddSection("Craft Bait")
	do
		local craftableBaitOptions = GetCraftableBaits()
		if Config.SelectedBait == "" and #craftableBaitOptions > 0 then
			Config.SelectedBait = craftableBaitOptions[1]
		end
		Tabs.Shop:AddDropdown("SelectBaitDropdown", {
			Title = "Select Bait",
			Values = craftableBaitOptions,
			Default = Config.SelectedBait ~= "" and Config.SelectedBait or craftableBaitOptions[1],
			Multi = false,
			Callback = function(selectedBait)
				Config.SelectedBait = selectedBait or ""
				SaveConfig()
			end,
		})
	end
	Tabs.Shop:AddInput("BaitAmountInput", {
		Title = "Craft Amount",
		Default = tostring(Config.BaitAmount or 1),
		Numeric = true,
		Finished = false,
		Placeholder = "1",
		Callback = function(amountStr)
			Config.BaitAmount = math.max(1, math.floor(tonumber(amountStr) or 1))
			SaveConfig()
		end,
	})
	Tabs.Shop:AddToggle("AutoCraftBaitToggle", {
		Title = "Auto Craft Bait",
		Default = Config.AutoCraftBait,
		Callback = function(enabled)
			Config.AutoCraftBait = enabled
			SaveConfig()
		end,
	})
	Tabs.Shop:AddButton({
		Title = "Craft Bait",
		Callback = function()
			if Config.SelectedBait ~= "" then
				CraftBaitEvent:FireServer(Config.SelectedBait, math.max(1, math.floor(tonumber(Config.BaitAmount) or 1)))
			end
		end,
	})
	Tabs.Shop:AddSection("Craft Rod")
	do
		local craftableRodOptions = GetCraftableRods()
		if Config.SelectedRod == "" and #craftableRodOptions > 0 then
			Config.SelectedRod = craftableRodOptions[1]
		end
		Tabs.Shop:AddDropdown("SelectRodDropdown", {
			Title = "Select Rod",
			Values = craftableRodOptions,
			Default = Config.SelectedRod ~= "" and Config.SelectedRod or craftableRodOptions[1],
			Multi = false,
			Callback = function(selectedRod)
				Config.SelectedRod = selectedRod or ""
				SaveConfig()
			end,
		})
	end
	Tabs.Shop:AddToggle("AutoCraftRodToggle", {
		Title = "Auto Craft Rod",
		Default = Config.AutoCraftRod,
		Callback = function(enabled)
			Config.AutoCraftRod = enabled
			SaveConfig()
		end,
	})
	Tabs.Shop:AddButton({
		Title = "Craft Rod",
		Callback = function()
			if Config.SelectedRod ~= "" then
				CraftRodEvent:FireServer(Config.SelectedRod)
			end
		end,
	})
	Tabs.ESP:AddToggle("ESPPlayers", {
		Title = "ESP Players",
		Default = Config.ESPEnabled,
		Callback = function(enabled)
			Config.ESPEnabled = enabled
			SaveConfig()
			if not enabled then
				ClearPlayerESP()
			end
		end,
	})
	Tabs.Misc:AddSection("Visual")
	Tabs.Misc:AddToggle("AntiAFKToggle", {
		Title = "Anti AFK",
		Default = Config.AntiAFK,
		Callback = function(enabled)
			Config.AntiAFK = enabled
			SaveConfig()
		end,
	})
	Tabs.Misc:AddToggle("FullBrightToggle", {
		Title = "FullBright",
		Default = Config.FullBright,
		Callback = function(enabled)
			Config.FullBright = enabled
			SaveConfig()
			if enabled then
				ApplyLightingSettings()
			else
				RestoreFullBright()
				if Config.NoFog then
					ApplyLightingSettings()
				end
			end
		end,
	})
	Tabs.Misc:AddToggle("NoFogToggle", {
		Title = "No Fog",
		Default = Config.NoFog,
		Callback = function(enabled)
			Config.NoFog = enabled
			SaveConfig()
			if enabled then
				ApplyLightingSettings()
			else
				RestoreNoFog()
				if Config.FullBright then
					ApplyLightingSettings()
				end
			end
		end,
	})
	Tabs.Misc:AddSection("Codes")
	Tabs.Misc:AddButton({
		Title = "Redeem All Codes",
		Callback = function()
			RedeemAllCodes()
		end,
	})
	Tabs.Misc:AddSection("Auto")
	Tabs.Misc:AddToggle("AutoDailyToggle", {
		Title = "Auto Claim Daily Reward",
		Default = Config.AutoDaily,
		Callback = function(enabled)
			Config.AutoDaily = enabled
			SaveConfig()
		end,
	})
	Tabs.Misc:AddToggle("AutoRedeemToggle", {
		Title = "Auto Redeem Codes",
		Default = Config.AutoRedeem,
		Callback = function(enabled)
			Config.AutoRedeem = enabled
			SaveConfig()
		end,
	})
	Tabs.Misc:AddToggle("FpsBoostToggle", {
		Title = "FPS Boost",
		Default = Config.FpsBoost,
		Callback = function(enabled)
			Config.FpsBoost = enabled
			SaveConfig()
			ApplySuperFPSBoost(enabled)
		end,
	})
	Tabs.Misc:AddSection("Summon")
	do
		local bannerOptions = GetBannerList()
		if Config.SelectedBanner == "" or not table.find(bannerOptions, Config.SelectedBanner) then
			Config.SelectedBanner = bannerOptions[1]
		end
		Tabs.Misc:AddDropdown("BannerDropdown", {
			Title = "Banner",
			Values = bannerOptions,
			Default = Config.SelectedBanner,
			Multi = false,
			Callback = function(selectedBanner)
				Config.SelectedBanner = selectedBanner or ""
				SaveConfig()
			end,
		})
	end
	Tabs.Misc:AddToggle("SummonX10Toggle", {
		Title = "x10 Summon",
		Default = Config.SummonX10,
		Callback = function(enabled)
			Config.SummonX10 = enabled
			SaveConfig()
		end,
	})
	Tabs.Misc:AddToggle("AutoSummonToggle", {
		Title = "Auto Summon",
		Default = Config.AutoSummon,
		Callback = function(enabled)
			Config.AutoSummon = enabled
			SaveConfig()
		end,
	})
	Tabs.Misc:AddSection("Remote Menus")
	Tabs.Misc:AddButton({
		Title = "Open Skill Upgrade",
		Callback = function()
			local isOpen = OpenMenuFrameRemotely("SkillUpgrade")
			Fluent:Notify({
				Title = "Remote UI",
				Content = isOpen and "Opened Skill Upgrade" or "Closed Skill Upgrade",
				Duration = 2,
			})
		end,
	})
	Tabs.Misc:AddButton({
		Title = "Open Learn Skill",
		Callback = function()
			local isOpen = OpenMenuFrameRemotely("LearnSkill")
			Fluent:Notify({
				Title = "Remote UI",
				Content = isOpen and "Opened Learn Skill" or "Closed Learn Skill",
				Duration = 2,
			})
		end,
	})
	Tabs.Misc:AddButton({
		Title = "Open Exchange UI",
		Callback = function()
			local isOpen = OpenMenuFrameRemotely("Exchange")
			Fluent:Notify({
				Title = "Remote UI",
				Content = isOpen and "Opened Item Exchange" or "Closed Item Exchange",
				Duration = 2,
			})
		end,
	})
	Tabs.Misc:AddButton({
		Title = "Open Trait",
		Callback = function()
			local isOpen = OpenMenuFrameRemotely("Trait")
			Fluent:Notify({ Title = "Remote UI", Content = isOpen and "Opened Trait" or "Closed Trait", Duration = 2 })
		end,
	})
	Tabs.Misc:AddButton({
		Title = "Open Guild",
		Callback = function()
			local isGuildOpen = false
			pcall(function()
				local guildFetchRemote = Events:FindFirstChild("GuildFetch")
				if guildFetchRemote and guildFetchRemote:IsA("RemoteFunction") then
					guildFetchRemote:InvokeServer()
				end
			end)
			pcall(function()
				local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
				local mainGui = (playerGui and playerGui:FindFirstChild("MainGui")) or MainGui
				if not mainGui then
					return
				end
				local guildMenuFrame = nil
				for _, descObj in ipairs(mainGui:GetDescendants()) do
					if descObj.Name == "MenuFrame" and descObj:FindFirstChild("InfoFrame") then
						guildMenuFrame = descObj
						break
					end
				end
				if not guildMenuFrame then
					for _, descObj in ipairs(mainGui:GetDescendants()) do
						if descObj.Name == "MenuFrame" then
							guildMenuFrame = descObj
							break
						end
					end
				end
				if guildMenuFrame then
					local isCurrentlyVisible = guildMenuFrame.Visible
						and guildMenuFrame.Parent
						and guildMenuFrame.Parent:IsA("GuiObject")
						and guildMenuFrame.Parent.Visible
					if isCurrentlyVisible then
						guildMenuFrame.Visible = false
						isGuildOpen = false
					else
						local currGui = guildMenuFrame
						while currGui and currGui:IsA("GuiObject") do
							currGui.Visible = true
							currGui = currGui.Parent
						end
						guildMenuFrame.Visible = true
						guildMenuFrame.Position = UDim2.new(0.5, -guildMenuFrame.AbsoluteSize.X / 2, 0.5, -guildMenuFrame.AbsoluteSize.Y / 2)
						isGuildOpen = true
					end
				end
			end)
			pcall(function()
				Fluent:Notify({ Title = "Remote UI", Content = isGuildOpen and "Opened Guild" or "Closed Guild", Duration = 2 })
			end)
		end,
	})
	Tabs.Misc:AddSection("Dumb Guy")
	Tabs.Misc:AddToggle("AutoGiveFishToggle", {
		Title = "Auto Give Fish",
		Default = Config.AutoGiveFish,
		Callback = function(enabled)
			Config.AutoGiveFish = enabled
			SaveConfig()
		end,
	})
	Tabs.Settings:AddKeybind("ToggleUIKeybind", {
		Title = "Minimize UI Keybind",
		Mode = "Toggle",
		Default = "LeftControl",
		ChangedCallback = function(keyInput)
			local resolvedKey = typeof(keyInput) == "EnumItem" and keyInput
				or Enum.KeyCode[tostring(keyInput)]
				or Enum.KeyCode.LeftControl
			MinimizeKey = resolvedKey
			Window.MinimizeKey = resolvedKey
		end,
	})
	Tabs.Settings:AddSection("Theme & Color")
	do
		local themeOptions = Hub.ThemeList
		pcall(function()
			if type(Fluent.Themes) == "table" and #Fluent.Themes > 0 then
				themeOptions = Fluent.Themes
			end
		end)
		if not table.find(themeOptions, Config.ThemeName) then
			Config.ThemeName = themeOptions[1]
		end
		Tabs.Settings:AddDropdown("ThemeDropdown", {
			Title = "UI Theme",
			Values = themeOptions,
			Default = Config.ThemeName,
			Multi = false,
			Callback = function(selectedTheme)
				if not selectedTheme then
					return
				end
				Config.ThemeName = selectedTheme
				SaveConfig()
				pcall(function()
					Fluent:SetTheme(selectedTheme)
				end)
			end,
		})
		Tabs.Settings:AddColorpicker("LogoAccentColor", {
			Title = "Logo / Accent Color",
			Default = AccentColor,
			Callback = function(newColor)
				if typeof(newColor) ~= "Color3" then
					return
				end
				AccentColor = newColor
				Config.AccentColor = {
					math.floor(newColor.R * 255 + 0.5),
					math.floor(newColor.G * 255 + 0.5),
					math.floor(newColor.B * 255 + 0.5),
				}
				SaveConfig()
				Hub.ApplyAccent(newColor)
			end,
		})
	end
	Tabs.Settings:AddSection("Auto Execute")
	Tabs.Settings:AddParagraph({
		Title = "Auto Execute",
		Content = "Re-runs Mos after server hop / rejoin. Save this script as MosCuChillDe.lua in your executor's workspace folder.",
	})
	Tabs.Settings:AddToggle("AutoExeToggle", {
		Title = "Auto Execute",
		Default = Config.AutoExe or false,
		Callback = function(enabled)
			Config.AutoExe = enabled
			SaveConfig()
		end,
	})
	Tabs.Settings:AddSection("Keybinds")
	Tabs.Settings:AddToggle("DisableAllKeybindsToggle", {
		Title = "Disable Keybinds",
		Default = Config.DisableAllKeybinds or false,
		Callback = function(enabled)
			Config.DisableAllKeybinds = enabled
			SaveConfig()
		end,
	})
	local function getFlyKeyCode()
		local rawKey = Config.FlyKeybind or "F"
		if typeof(rawKey) == "EnumItem" then
			return rawKey
		end
		local keyName = tostring(rawKey):gsub("Enum%.KeyCode%.", "")
		return Enum.KeyCode[keyName] or Enum.KeyCode.F
	end
	Tabs.Settings:AddKeybind("FlyKeybind", {
		Title = "Fly Keybind",
		Mode = "Toggle",
		Default = Config.FlyKeybind or "F",
		Callback = function()
			if not Config.DisableAllKeybinds and Config.FlyKeybindEnabled ~= false then
				toggleFly()
			end
		end,
		ChangedCallback = function(newKey)
			local keyEnum = typeof(newKey) == "EnumItem" and newKey
				or Enum.KeyCode[tostring(newKey):gsub("Enum%.KeyCode%.", "")]
			if keyEnum then
				Config.FlyKeybind = keyEnum.Name
				SaveConfig()
			end
		end,
	})
	local function getNoclipKeyCode()
		local rawKey = Config.NoclipKeybind or "J"
		if typeof(rawKey) == "EnumItem" then
			return rawKey
		end
		local keyName = tostring(rawKey):gsub("Enum%.KeyCode%.", "")
		return Enum.KeyCode[keyName] or Enum.KeyCode.J
	end
	Tabs.Settings:AddKeybind("NoclipKeybind", {
		Title = "Noclip Keybind",
		Mode = "Toggle",
		Default = Config.NoclipKeybind or "J",
		Callback = function()
			if not Config.DisableAllKeybinds and Config.NoclipKeybindEnabled ~= false then
				toggleNoclip()
			end
		end,
		ChangedCallback = function(newKey)
			local keyEnum = typeof(newKey) == "EnumItem" and newKey
				or Enum.KeyCode[tostring(newKey):gsub("Enum%.KeyCode%.", "")]
			if keyEnum then
				Config.NoclipKeybind = keyEnum.Name
				SaveConfig()
			end
		end,
	})
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if Hub.Unloaded then
			return
		end
		if Config.DisableAllKeybinds then
			return
		end
		if UserInputService:GetFocusedTextBox() then
			return
		end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if Config.FlyKeybindEnabled ~= false and input.KeyCode == getFlyKeyCode() then
				toggleFly()
			elseif Config.NoclipKeybindEnabled ~= false and input.KeyCode == getNoclipKeyCode() then
				toggleNoclip()
			end
		end
	end)
	do
		local function hopToLowPlayerServer()
			task.spawn(function()
				local placeId = game.PlaceId
				local currentJobId = game.JobId
				local httpRequestFn = (syn and syn.request)
					or (http and http.request)
					or http_request
					or (fluxus and fluxus.request)
					or request
				local targetServer = nil
				pcall(function()
					Fluent:Notify({ Title = "Server Hop", Content = "Searching for low player server...", Duration = 4 })
				end)
				local pageCursor = ""
				local attemptCount = 0
				while attemptCount < 5 and not targetServer do
					attemptCount = attemptCount + 1
					local requestUrl = "https://games.roblox.com/v1/games/"
						.. tostring(placeId)
						.. "/servers/Public?sortOrder=Asc&limit=100"
					if pageCursor ~= "" then
						requestUrl = requestUrl .. "&cursor=" .. pageCursor
					end
					local responseBody = nil
					if httpRequestFn then
						local httpResp = httpRequestFn({ Url = requestUrl, Method = "GET" })
						if httpResp and httpResp.Body then
							responseBody = httpResp.Body
						end
					else
						local getOk, getBody = pcall(game.HttpGet, game, requestUrl)
						if getOk then
							responseBody = getBody
						end
					end
					if responseBody then
						local decodedData = nil
						pcall(function()
							decodedData = HttpService:JSONDecode(responseBody)
						end)
						if decodedData and decodedData.data then
							local serverCandidates = {}
							for _, srvEntry in ipairs(decodedData.data) do
								if type(srvEntry) == "table" and srvEntry.id and srvEntry.id ~= currentJobId then
									local playingCount = tonumber(srvEntry.playing) or 0
									local maxPlayers = tonumber(srvEntry.maxPlayers) or 1
									if playingCount < maxPlayers and playingCount > 0 then
										table.insert(serverCandidates, srvEntry)
									end
								end
							end
							table.sort(serverCandidates, function(srvA, srvB)
								return (tonumber(srvA.playing) or 0) < (tonumber(srvB.playing) or 0)
							end)
							if #serverCandidates > 0 then
								targetServer = serverCandidates[1]
								break
							end
							if decodedData.nextPageCursor and decodedData.nextPageCursor ~= "" then
								pageCursor = decodedData.nextPageCursor
							else
								break
							end
						else
							break
						end
					else
						break
					end
					task.wait(0.5)
				end
				if targetServer and targetServer.id then
					pcall(function()
						Fluent:Notify({
							Title = "Server Hop",
							Content = "Found server with " .. tostring(targetServer.playing) .. " players! Teleporting...",
							Duration = 4,
						})
					end)
					task.wait(0.5)
					TeleportService:TeleportToPlaceInstance(placeId, targetServer.id, LocalPlayer)
				else
					pcall(function()
						Fluent:Notify({
							Title = "Server Hop",
							Content = "Couldn't find low player server. Teleporting to random server...",
							Duration = 4,
						})
					end)
					task.wait(0.5)
					TeleportService:Teleport(placeId, LocalPlayer)
				end
			end)
		end
		Tabs.Misc:AddSection("Server")
		Tabs.Misc:AddButton({
			Title = "Rejoin",
			Callback = function()
				pcall(function()
					Fluent:Notify({ Title = "Rejoin", Content = "Rejoining current server...", Duration = 3 })
				end)
				task.wait(0.3)
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
			end,
		})
		Tabs.Misc:AddButton({
			Title = "Server Hop Low Players",
			Callback = function()
				hopToLowPlayerServer()
			end,
		})
	end
	do
		Tabs.Misc:AddSection("Server Tools")
		local serverTimeParagraph = Tabs.Misc:AddParagraph({ Title = "Server Time : 00:00:00", Content = "" })
		task.spawn(function()
			while not Hub.Unloaded do
				local upTime = workspace.DistributedGameTime or time()
				local days = math.floor(upTime / 86400)
				local hours = math.floor((upTime % 86400) / 3600)
				local mins = math.floor((upTime % 3600) / 60)
				local secs = math.floor(upTime % 60)
				local formattedTime = (
					days > 0 and string.format("%dd %02d:%02d:%02d", days, hours, mins, secs)
					or string.format("%02d:%02d:%02d", hours, mins, secs)
				)
				pcall(function()
					serverTimeParagraph:SetTitle("Server Time : " .. formattedTime)
				end)
				task.wait(1)
			end
		end)
		Tabs.Misc:AddButton({
			Title = "Server Hop Random",
			Callback = function()
				Hub.DoServerHop("normal")
			end,
		})
		Tabs.Misc:AddSection("JobId")
		local targetJobId = ""
		Tabs.Misc:AddInput("JobIdInput", {
			Title = "JobId",
			Default = "",
			Placeholder = "Enter JobId...",
			Numeric = false,
			Finished = false,
			Callback = function(inputJobId)
				targetJobId = (tostring(inputJobId or ""):gsub("%s+", ""))
			end,
		})
		Tabs.Misc:AddButton({
			Title = "Join JobId",
			Callback = function()
				if targetJobId == "" then
					pcall(function()
						Fluent:Notify({ Title = "Join JobId", Content = "Please enter a valid JobId", Duration = 3 })
					end)
					return
				end
				Hub.QueueReExecute()
				pcall(function()
					Fluent:Notify({ Title = "Join JobId", Content = "Teleporting to " .. targetJobId .. "...", Duration = 3 })
				end)
				task.wait(0.3)
				TeleportService:TeleportToPlaceInstance(game.PlaceId, targetJobId, LocalPlayer)
			end,
		})
		Tabs.Misc:AddButton({
			Title = "Copy Current JobId",
			Callback = function()
				local currentJobId = tostring(game.JobId or "")
				local copiedOk = false
				pcall(function()
					if setclipboard then
						setclipboard(currentJobId)
						copiedOk = true
					elseif toclipboard then
						toclipboard(currentJobId)
						copiedOk = true
					elseif syn and syn.write_clipboard then
						syn.write_clipboard(currentJobId)
						copiedOk = true
					end
				end)
				pcall(function()
					Fluent:Notify({
						Title = "Copy JobId",
						Content = copiedOk and ("Copied: " .. currentJobId) or ("JobId: " .. currentJobId),
						Duration = 4,
					})
				end)
			end,
		})
		Tabs.Misc:AddSection("Weather Hop")
		local weatherHopToggle
		local function checkWeatherAndHop()
			local currentWeather = tostring(workspace:GetAttribute("Weather") or "")
			local targetWeather = tostring(Config.SelectedWeather or "")
			if currentWeather == "" then
				local waitStart = os.clock()
				while (os.clock() - waitStart) < 3 and currentWeather == "" do
					currentWeather = tostring(workspace:GetAttribute("Weather") or "")
					task.wait(0.1)
				end
			end
			if not Config.AutoHopWeather then
				return
			end
			if currentWeather ~= "" and string.lower(currentWeather) == string.lower(targetWeather) then
				Config.AutoHopWeather = false
				SaveConfig()
				if weatherHopToggle then
					pcall(function()
						weatherHopToggle:SetValue(false)
					end)
				end
				pcall(function()
					Fluent:Notify({
						Title = "Weather Hop",
						Content = "Found target weather: " .. currentWeather .. "! Auto Hop stopped.",
						Duration = 6,
					})
				end)
				return
			end
			pcall(function()
				Fluent:Notify({
					Title = "Weather Hop",
					Content = "Current: "
						.. (currentWeather ~= "" and currentWeather or "Unknown")
						.. ". Target: "
						.. targetWeather
						.. ". Hopping in 5s...",
					Duration = 5,
				})
			end)
			task.wait(5)
			if Config.AutoHopWeather and not Hub.Unloaded then
				Hub.DoServerHop("normal")
			end
		end
		weatherHopToggle = Tabs.Misc:AddToggle("AutoHopWeatherToggle", {
			Title = "Auto Hop Weather",
			Default = Config.AutoHopWeather,
			Callback = function(enabled)
				Config.AutoHopWeather = enabled
				SaveConfig()
				if enabled then
					task.spawn(checkWeatherAndHop)
				end
			end,
		})
		local weatherOptions = Hub.GetWeatherList()
		if not table.find(weatherOptions, Config.SelectedWeather) then
			table.insert(weatherOptions, Config.SelectedWeather)
		end
		Tabs.Misc:AddDropdown("SelectWeatherDropdown", {
			Title = "Select Weather",
			Values = weatherOptions,
			Default = Config.SelectedWeather,
			Multi = false,
			Callback = function(selectedWeather)
				Config.SelectedWeather = selectedWeather or "Thunderstorm"
				SaveConfig()
			end,
		})
		task.spawn(function()
			task.wait(2)
			if not Config.AutoHopWeather then
				return
			end
			local elapsedWait = 0
			repeat
				task.wait(0.2)
				elapsedWait = elapsedWait + 0.2
			until workspace:GetAttribute("Weather") or not Config.AutoHopWeather or elapsedWait > 15
			if not Config.AutoHopWeather then
				return
			end
			checkWeatherAndHop()
		end)
	end
	Tabs.Settings:AddSection("Hub")
	Hub.OnUnload = function()
		Config.AutoCast, Config.AutoReel, Config.AutoMiniGame = false, false, false
		Config.AutoBoss, Config.AutoSecretBoss, Config.AutoSkill = false, false, false
		Config.AutoFarmIsland, Config.AutoTPPos = false, false
		Config.AutoTicketQuest, Config.AutoZengTianguoQuest, Config.AutoFilterZengQuest = false, false, false
		Config.AutoDaily, Config.AutoSummon, Config.AutoBuyBestRod, Config.AutoRedeem = false, false, false, false
		Config.AutoClaimDailyQuest, Config.AutoGiveFish, Config.AutoFavoriteBoss = false, false, false
		Config.AutoHopWeather, Config.AutoHopSacredBeast, Config.FilterFishEnabled = false, false, false
		Config.FlyEnabled, Config.NoclipEnabled, Config.LoopSpeedEnabled = false, false, false
		Config.AutoSell, Config.AutoBuyBait, Config.AutoCraftBait, Config.AutoCraftRod = false, false, false, false
		pcall(stopFly)
		pcall(function()
			ApplySuperFPSBoost(false)
		end)
		pcall(ClearPlayerESP)
		Config.ESPEnabled = false
		pcall(function()
			Hub.ApplyHide(false)
		end)
		pcall(function()
			Hub.SetInstantInteract(false)
		end)
		pcall(function()
			Hub.SetWalkOnWater(false)
		end)
		Config.InstantInteract, Config.WalkOnWater = false, false
	end
	Tabs.Settings:AddButton({
		Title = "Unload Hub",
		Callback = function()
			Hub.Unload()
		end,
	})
	Window:SelectTab(1)
	Fluent:Notify({ Title = "Mos Hub", Content = "Loaded - by noelnoathebest02", Duration = 5 })
	isLoaded = true
end, function(errTrace)
	return debug.traceback(tostring(errTrace), 2)
end)
if not execOk then
	ShowError(execErr)
end
