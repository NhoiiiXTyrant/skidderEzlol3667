--[[
	KHUB · +1 Stone Skipping
	Ouroboros feature logic · KHUB UI
	Main (Farm + Progress) · Player · Settings · Server · Welcome
	Toggle: RightShift / RightCtrl / K
]]
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local player = LocalPlayer

local LOGO_ID = "rbxassetid://116838166946511"
local BG_ID   = "rbxassetid://127230219966945"
local DISCORD = "https://discord.gg/EKPb7BRDH8"
local YOUTUBE = "https://www.youtube.com/@kyielpambid"
local CONFIG_FOLDER = "KHUB_StoneSkipping_Configs"

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Icons = {
	home = "rbxassetid://6031097226",
	welcome = "rbxassetid://6031097226",
	settings = "rbxassetid://6031280882",
	save = "rbxassetid://6031260796",
	config = "rbxassetid://6031260796",
	user = "rbxassetid://6034287594",
	info = "rbxassetid://6031071053",
	server = "rbxassetid://6034949389",
	main = "rbxassetid://6034509993",
	player = "rbxassetid://6034287594",
}


local function resolveIcon(name)
	if not name then return Icons.home end
	local key = string.lower(tostring(name))
	return Icons[key] or Icons.home or "rbxassetid://6031097226"
end

local Keybinds = {
	ToggleUI = Enum.KeyCode.RightShift,
}

local function keyName(kc)
	if not kc or kc == Enum.KeyCode.Unknown then return "None" end
	return tostring(kc):gsub("Enum.KeyCode.", "")
end

local function keyFromName(name)
	if not name or name == "" or name == "None" then return Enum.KeyCode.Unknown end
	local ok, kc = pcall(function() return Enum.KeyCode[name] end)
	return (ok and kc) or Enum.KeyCode.Unknown
end


--------------------------------------------------------------------
-- GAME BINDINGS (Ouroboros +1 Stone Skipping)
--------------------------------------------------------------------
local RS = typeof(cloneref) == "function" and cloneref(ReplicatedStorage) or ReplicatedStorage
local WS = typeof(cloneref) == "function" and cloneref(Workspace) or Workspace

local SkippingNetwork = RS:FindFirstChild("SkippingNetwork") or RS:WaitForChild("SkippingNetwork", 5)
local Request = SkippingNetwork and (SkippingNetwork:FindFirstChild("Request") or SkippingNetwork:WaitForChild("Request", 3))
local Event = SkippingNetwork and (SkippingNetwork:FindFirstChild("Event") or SkippingNetwork:WaitForChild("Event", 3))
if not SkippingNetwork or not Request or not Event then
	warn("[KHUB] SkippingNetwork remotes missing — features may not work. Join +1 Stone Skipping.")
end

local Shared = RS:FindFirstChild("Shared") or RS:WaitForChild("Shared", 5)
local GameBalance, LaunchZoneUtil, WorldMap, StatePacket = {}, nil, nil, nil
if Shared then
	pcall(function()
		local cfg = Shared:FindFirstChild("Config") or Shared:WaitForChild("Config", 3)
		local gb = cfg and (cfg:FindFirstChild("GameBalance") or cfg:WaitForChild("GameBalance", 3))
		if gb then GameBalance = require(gb) end
	end)
	pcall(function()
		local util = Shared:FindFirstChild("Util") or Shared:WaitForChild("Util", 3)
		local lz = util and (util:FindFirstChild("LaunchZone") or util:WaitForChild("LaunchZone", 2))
		if lz then LaunchZoneUtil = require(lz) end
	end)
	pcall(function()
		local util = Shared:FindFirstChild("Util")
		local wm = util and util:FindFirstChild("WorldMap")
		if wm then WorldMap = require(wm) end
	end)
	pcall(function()
		local util = Shared:FindFirstChild("Util")
		local sp = util and util:FindFirstChild("StatePacket")
		if sp then StatePacket = require(sp) end
	end)
else
	warn("[KHUB] Shared missing — using fallbacks")
end
GameBalance = type(GameBalance) == "table" and GameBalance or {}

local THROW_CD = tonumber(GameBalance.Throw and GameBalance.Throw.Cooldown) or 0.8
local MAX_REBIRTHS = tonumber(GameBalance.Rebirth and GameBalance.Rebirth.MaxRebirths) or 1e9

local ZONE_DEFS = {
	{ Id = "TrainingZone", Label = "Basic (1x)" },
	{ Id = "TrainingZone_RareJade", Label = "Rare Jade (4x)" },
	{ Id = "TrainingZone_EpicCrystal", Label = "Epic Crystal (10x)" },
	{ Id = "TrainingZone_LegendaryCelestial", Label = "Legendary Celestial (20x)" },
	{ Id = "TrainingZone_Golden", Label = "Golden (15x)" },
	{ Id = "TrainingZone_Hacker", Label = "Hacker (50x)" },
}
local ZoneLabels, LabelToId, IdToLabel = {}, {}, {}
for _, z in ipairs(ZONE_DEFS) do
	table.insert(ZoneLabels, z.Label)
	LabelToId[z.Label] = z.Id
	IdToLabel[z.Id] = z.Label
end

local Stones = {}
for _, v in ipairs(GameBalance.Stones or {}) do
	if type(v) == "table" and type(v.Id) == "string" then
		table.insert(Stones, {
			Id = v.Id,
			Name = v.Name or v.Id,
			Price = tonumber(v.Price) or 0,
			Multiplier = tonumber(v.Multiplier) or 1,
		})
	end
end
table.sort(Stones, function(a, b)
	if a.Multiplier == b.Multiplier then return a.Price < b.Price end
	return a.Multiplier < b.Multiplier
end)

local EggPrices, EggList = {}, {}
local function addEgg(id, price)
	if type(id) ~= "string" or id == "" or EggPrices[id] then return end
	EggPrices[id] = tonumber(price) or 0
	table.insert(EggList, id)
end

local worlds = WS:FindFirstChild("SkippingWorlds")
if worlds then
	for _, world in ipairs(worlds:GetChildren()) do
		local shop = world:FindFirstChild("EggShop")
		local displays = shop and shop:FindFirstChild("Displays")
		if displays then
			for _, d in ipairs(displays:GetChildren()) do
				local wins = d:GetAttribute("Wins")
				local cur = d:GetAttribute("Currency")
				if wins ~= nil and cur ~= "Robux" then
					addEgg(d.Name, wins)
				end
			end
		end
	end
end
if type(GameBalance.EggInventory) == "table" then
	for _, v in ipairs(GameBalance.EggInventory) do
		if type(v) == "table" and type(v.Id) == "string" then
			addEgg(v.Id, EggPrices[v.Id] or 0)
		end
	end
end
table.sort(EggList, function(a, b)
	local pa, pb = EggPrices[a] or 0, EggPrices[b] or 0
	if pa == pb then return a < b end
	return pa < pb
end)
if #EggList == 0 then
	EggPrices.Common = 50
	EggList = { "Common" }
end

--------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------
local Alive = true
local S = {
	Train = false,
	Throw = false,
	BuyStones = false,
	HatchEgg = false,
	Rebirth = false,
	EquipBestPet = false,
	TrainZoneId = "TrainingZone",
	HatchEggId = EggList[1],
	Player = nil,
	HatchRequestId = 0,
	LastThrowAt = 0,
	LastBuyAt = 0,
	PendingBuyId = nil,
	ThrowBusy = false,
	ThrowHandler = nil,
	Gens = {},
	WalkSpeedEnabled = false,
	WalkSpeed = 32,
	InfJump = false,
	NoClip = false,
	InstantPP = false,
	Fly = false,
	FlySpeed = 60,
	AntiAfk = true,
	NoGameplayPaused = true,
	AutoReconnect = true,
	Disable3D = false,
	FpsBoost = false,
}

local function stillOn(key)
	return Alive and S[key] == true
end

local function fireReq(action, data)
	if not Alive or not Request then return false end
	return pcall(function()
		Request:FireServer(action, data)
	end)
end

local function getHRP()
	local c = LocalPlayer.Character
	local h = c and c:FindFirstChild("HumanoidRootPart")
	return h and h:IsA("BasePart") and h or nil
end

local function getHum()
	local c = LocalPlayer.Character
	return c and c:FindFirstChildOfClass("Humanoid")
end

local function getActivity()
	local p = S.Player
	if p and type(p.Activity) == "string" then return p.Activity end
	local attr = LocalPlayer:GetAttribute("SkippingActivity")
	if type(attr) == "string" then return attr end
	return "Idle"
end

local function getWorldModel()
	if WorldMap and type(WorldMap.GetModel) == "function" then
		local ok, m = pcall(WorldMap.GetModel, LocalPlayer)
		if ok and m then return m end
	end
	local sw = WS:FindFirstChild("SkippingWorlds")
	return sw and sw:FindFirstChild("World1") or nil
end

local function getLaunchZone()
	local w = getWorldModel()
	local lz = w and w:FindFirstChild("LaunchZone")
	return lz and lz:IsA("BasePart") and lz or nil
end

local function getTrainStand(zoneId)
	local w = getWorldModel()
	if not w then return nil end
	local zones = w:FindFirstChild("TrainingZones")
	local z = zones and zones:FindFirstChild(zoneId)
	if not (z and z:IsA("Model")) then return nil end
	local stand = z:FindFirstChild("TrainingStand")
	return stand and stand:IsA("BasePart") and stand or nil
end

local function zoneAllowed(zoneId)
	local p = S.Player
	if not p then return false end
	local req = GameBalance.Practice and GameBalance.Practice.ZoneRequiredRebirths
	local need = type(req) == "table" and tonumber(req[zoneId]) or 0
	local rebirths = tonumber(p.Rebirths) or 0
	if rebirths < need then return false end
	if zoneId == "TrainingZone_Golden" or zoneId == "TrainingZone_Hacker" then
		local owned = p.OwnedTrainingZones
		return type(owned) == "table" and owned[zoneId] == true
	end
	return true
end

local function tpCF(cf)
	local hrp = getHRP()
	if not hrp then return false end
	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero
	hrp.CFrame = cf
	return true
end

local function stopPractice()
	if getActivity() == "Practice" then
		fireReq("StopPractice", nil)
	end
end

local function ensureTrainStand()
	local id = S.TrainZoneId
	if not zoneAllowed(id) then return end
	local stand = getTrainStand(id)
	if not stand then return end
	local hrp = getHRP()
	if not hrp then return end
	local target = stand.Position + Vector3.new(0, 3, 0)
	if (hrp.Position - target).Magnitude > 6 then
		tpCF(stand.CFrame + Vector3.new(0, 3, 0))
	end
end

-- Throw button / handler
local function findThrowButton()
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	local hud = pg and pg:FindFirstChild("SkippingHUD")
	local h = hud and hud:FindFirstChild("HUD")
	local bottom = h and h:FindFirstChild("Bottom")
	local prog = bottom and bottom:FindFirstChild("Progression")
	local throw = prog and prog:FindFirstChild("Throw")
	if throw and throw:IsA("GuiButton") then return throw end
	return nil
end

local function getThrowHandler()
	if type(S.ThrowHandler) == "function" then return S.ThrowHandler end
	if type(getconnections) ~= "function" then return nil end
	local btn = findThrowButton()
	if not btn then return nil end
	local ok, cons = pcall(getconnections, btn.InputBegan)
	if not ok or type(cons) ~= "table" then return nil end
	for _, c in ipairs(cons) do
		if type(c.Function) == "function" then
			S.ThrowHandler = c.Function
			return S.ThrowHandler
		end
	end
	return nil
end

local FakeThrowInput = {
	UserInputType = Enum.UserInputType.MouseButton1,
	UserInputState = Enum.UserInputState.Begin,
	KeyCode = Enum.KeyCode.Unknown,
}

local function doThrowOnce()
	local handler = getThrowHandler()
	if not handler then return false end
	return pcall(handler, FakeThrowInput)
end

local function waitThrowClear(timeout)
	local untilT = os.clock() + (timeout or 6)
	while Alive and S.Throw and os.clock() < untilT do
		if not S.ThrowBusy and getActivity() ~= "Throw" then break end
		task.wait(0.1)
	end
	S.ThrowBusy = false
	return true
end

--------------------------------------------------------------------
-- LOOPS (Ouroboros cadence)
--------------------------------------------------------------------
local function startLoop(key, delaySec, fn)
	S.Gens[key] = (S.Gens[key] or 0) + 1
	local gen = S.Gens[key]
	task.spawn(function()
		while Alive and S[key] and S.Gens[key] == gen do
			local ok, err = pcall(fn)
			if not ok then warn("[KHUB] " .. key .. ": " .. tostring(err)) end
			if not (Alive and S[key] and S.Gens[key] == gen) then break end
			task.wait(delaySec)
		end
	end)
end

local function throwTick()
	if S.Train then return end
	if S.ThrowBusy or getActivity() == "Throw" then
		waitThrowClear(6)
		return
	end
	if getActivity() == "Practice" then
		stopPractice()
		task.wait(0.45)
		if not stillOn("Throw") then return end
	end
	if getActivity() ~= "Idle" then return end
	if os.clock() - S.LastThrowAt < THROW_CD then return end
	local lz = getLaunchZone()
	if not lz then return end
	local hrp = getHRP()
	if not hrp then return end
	if not LaunchZoneUtil.Contains(LocalPlayer.Character) then
		tpCF(lz.CFrame + Vector3.new(0, 4, 0))
		task.wait(0.3)
		if not stillOn("Throw") then return end
		if not LaunchZoneUtil.Contains(LocalPlayer.Character) then return end
	end
	if getActivity() ~= "Idle" or S.ThrowBusy then return end
	S.LastThrowAt = os.clock()
	if not doThrowOnce() then
		S.ThrowHandler = nil
		return
	end
	local deadline = os.clock() + 1
	while Alive and S.Throw and os.clock() < deadline do
		if S.ThrowBusy or getActivity() == "Throw" then break end
		task.wait(0.05)
	end
	if not S.ThrowBusy and getActivity() ~= "Throw" then return end
	waitThrowClear(8)
	if stillOn("Throw") then task.wait(THROW_CD) end
end

local function buyTick()
	local p = S.Player
	if not p then return end
	if S.PendingBuyId then
		if os.clock() - S.LastBuyAt < 2 then return end
		S.PendingBuyId = nil
	end
	local wins = tonumber(p.Wins) or 0
	local owned = type(p.OwnedStones) == "table" and p.OwnedStones or {}
	local pick = nil
	for _, stone in ipairs(Stones) do
		if owned[stone.Id] ~= true and stone.Price > 0 and wins >= stone.Price then
			pick = stone
		end
	end
	if pick then
		S.PendingBuyId = pick.Id
		S.LastBuyAt = os.clock()
		fireReq("Buy", pick.Id)
		return
	end
	local bestOwned = nil
	for _, stone in ipairs(Stones) do
		if owned[stone.Id] == true then bestOwned = stone end
	end
	if bestOwned and p.EquippedStone ~= bestOwned.Id then
		fireReq("Equip", bestOwned.Id)
	end
end

local function hatchTick()
	local p = S.Player
	if not p then return end
	local act = getActivity()
	if act ~= "Idle" and act ~= "Practice" then return end
	local eggId = S.HatchEggId
	if type(eggId) ~= "string" or eggId == "" then return end
	local price = EggPrices[eggId] or 0
	local wins = tonumber(p.Wins) or 0
	if price > 0 and wins < price then return end
	S.HatchRequestId += 1
	fireReq("HatchEgg", { EggId = eggId, Count = 1, RequestId = S.HatchRequestId })
end

local function rebirthTick()
	local p = S.Player
	if not p then return end
	local rebirths = tonumber(p.Rebirths) or 0
	if rebirths >= MAX_REBIRTHS then return end
	local level = tonumber(p.Level) or 0
	local nextLvl = tonumber(p.NextRebirthLevel) or 0
	if nextLvl <= 0 or level < nextLvl then return end
	local act = getActivity()
	if act ~= "Idle" and act ~= "Practice" then return end
	fireReq("Rebirth", rebirths)
end

local function equipPetTick()
	if getActivity() == "Throw" then return end
	fireReq("PetEquipment", { Kind = "Best" })
end

-- Enable helpers matching Ouroboros om/setters
local function setFeature(key, on, delaySec, tickFn)
	S[key] = on and true or false
	if S[key] then
		startLoop(key, delaySec, tickFn)
	else
		S.Gens[key] = (S.Gens[key] or 0) + 1
		if key == "Train" then stopPractice() end
		if key == "Throw" then
			S.ThrowBusy = false
			S.ThrowHandler = nil
		end
		if key == "BuyStones" then S.PendingBuyId = nil end
	end
end

Event.OnClientEvent:Connect(function(kind, payload)
	if kind == "State" then
		if type(payload) == "table" then
			local ok = pcall(StatePacket.Merge, S.Player, payload)
			if not ok then
				fireReq("Sync", nil)
				return
			end
			S.Player = payload
			if S.PendingBuyId and type(S.Player.OwnedStones) == "table" then
				if S.Player.OwnedStones[S.PendingBuyId] == true then
					S.PendingBuyId = nil
				end
			end
		end
	elseif kind == "ThrowStarted" then
		if type(payload) == "table" and payload.UserId == LocalPlayer.UserId then
			S.ThrowBusy = true
		end
	elseif kind == "ThrowCancelled" or kind == "ThrowFinished" or kind == "ThrowRejected" then
		if type(payload) == "table" then
			if payload.UserId == nil or payload.UserId == LocalPlayer.UserId then
				S.ThrowBusy = false
			end
		else
			S.ThrowBusy = false
		end
	end
end)

fireReq("Sync", nil)

--------------------------------------------------------------------
-- PLAYER MODS
--------------------------------------------------------------------
local WalkSnap, NoClipSnap, InstantSnap = {}, {}, {}
local InfJumpConn, NoClipConn, FlyConn, InstantConn
local FlySnap

local function applyWalk(hum)
	if not hum then return end
	if WalkSnap[hum] == nil then WalkSnap[hum] = hum.WalkSpeed end
	hum.WalkSpeed = S.WalkSpeed
end

local function setWalkEnabled(on)
	S.WalkSpeedEnabled = on and true or false
	local hum = getHum()
	if not hum then return end
	if S.WalkSpeedEnabled then
		applyWalk(hum)
	elseif WalkSnap[hum] ~= nil then
		hum.WalkSpeed = WalkSnap[hum]
	end
end

local function setInfJump(on)
	S.InfJump = on and true or false
	if InfJumpConn then InfJumpConn:Disconnect(); InfJumpConn = nil end
	if not S.InfJump then return end
	InfJumpConn = UserInputService.JumpRequest:Connect(function()
		if not Alive or not S.InfJump then return end
		local hum = getHum()
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end)
end

local function setNoClip(on)
	S.NoClip = on and true or false
	if NoClipConn then NoClipConn:Disconnect(); NoClipConn = nil end
	local function restore()
		for part, val in pairs(NoClipSnap) do
			if part and part.Parent then part.CanCollide = val end
		end
		table.clear(NoClipSnap)
	end
	if not S.NoClip then restore(); return end
	local function apply(char)
		if not char then return end
		for _, d in ipairs(char:GetDescendants()) do
			if d:IsA("BasePart") then
				if NoClipSnap[d] == nil then NoClipSnap[d] = d.CanCollide end
				d.CanCollide = false
			end
		end
	end
	apply(LocalPlayer.Character)
	NoClipConn = RunService.Stepped:Connect(function()
		if not Alive or not S.NoClip then return end
		apply(LocalPlayer.Character)
	end)
end

local function setFly(on)
	S.Fly = on and true or false
	if FlyConn then FlyConn:Disconnect(); FlyConn = nil end
	local hum = getHum()
	local hrp = getHRP()
	if not S.Fly then
		if FlySnap and hum then hum.PlatformStand = FlySnap.PlatformStand end
		FlySnap = nil
		if hrp then hrp.AssemblyLinearVelocity = Vector3.zero end
		return
	end
	if hum then
		FlySnap = { PlatformStand = hum.PlatformStand }
		hum.PlatformStand = true
	end
	FlyConn = RunService.RenderStepped:Connect(function()
		if not Alive or not S.Fly then return end
		if UserInputService:GetFocusedTextBox() then return end
		local h = getHRP()
		local cam = WS.CurrentCamera
		if not (h and cam) then return end
		local dir = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
		if dir.Magnitude > 0 then
			h.AssemblyLinearVelocity = dir.Unit * S.FlySpeed
		else
			h.AssemblyLinearVelocity = Vector3.zero
		end
		h.CFrame = CFrame.new(h.Position, h.Position + cam.CFrame.LookVector)
	end)
end

local function setInstantPP(on)
	S.InstantPP = on and true or false
	if InstantConn then InstantConn:Disconnect(); InstantConn = nil end
	local function restore()
		for prompt, snap in pairs(InstantSnap) do
			if prompt and prompt.Parent then
				prompt.HoldDuration = snap.HoldDuration
				prompt.MaxActivationDistance = snap.MaxActivationDistance
				prompt.RequiresLineOfSight = snap.RequiresLineOfSight
			end
		end
		table.clear(InstantSnap)
	end
	if not S.InstantPP then restore(); return end
	local function hook(obj)
		if not obj:IsA("ProximityPrompt") then return end
		if InstantSnap[obj] == nil then
			InstantSnap[obj] = {
				HoldDuration = obj.HoldDuration,
				MaxActivationDistance = obj.MaxActivationDistance,
				RequiresLineOfSight = obj.RequiresLineOfSight,
			}
		end
		obj.HoldDuration = 0
		obj.MaxActivationDistance = 50
		obj.RequiresLineOfSight = false
	end
	for _, d in ipairs(WS:GetDescendants()) do hook(d) end
	InstantConn = WS.DescendantAdded:Connect(function(d)
		if S.InstantPP then hook(d) end
	end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
	task.defer(function()
		if not Alive then return end
		local hum = char:WaitForChild("Humanoid", 10)
		if not hum then return end
		if S.WalkSpeedEnabled then applyWalk(hum) end
		if S.NoClip then setNoClip(true) end
		if S.Fly then setFly(true) end
	end)
end)

--------------------------------------------------------------------
-- ANTI AFK / FPS / RECONNECT
--------------------------------------------------------------------
local AfkConn, AfkTask, FpsConn, ReconnectConns
local FpsSnap = {}
local AfkCount = 0

local function pokeAfk()
	if type(VirtualUser.CaptureController) ~= "function" then return false end
	local ok = pcall(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
	if ok then AfkCount += 1 end
	return ok
end

local function setAntiAfk(on)
	S.AntiAfk = on and true or false
	if AfkConn then AfkConn:Disconnect(); AfkConn = nil end
	if AfkTask then pcall(task.cancel, AfkTask); AfkTask = nil end
	if not S.AntiAfk then return end
	AfkConn = LocalPlayer.Idled:Connect(function()
		if Alive and S.AntiAfk then pokeAfk() end
	end)
	AfkTask = task.spawn(function()
		local last = os.clock()
		while Alive and S.AntiAfk do
			task.wait(1)
			if not (Alive and S.AntiAfk) then break end
			if os.clock() - last >= 60 then
				last = os.clock()
				pokeAfk()
			end
		end
	end)
end

local function setAutoReconnect(on)
	S.AutoReconnect = on and true or false
	for _, c in ipairs(ReconnectConns or {}) do c:Disconnect() end
	ReconnectConns = {}
	if not S.AutoReconnect then return end
	table.insert(ReconnectConns, TeleportService.TeleportInitFailed:Connect(function()
		if not Alive or not S.AutoReconnect then return end
		task.wait(1)
		if Alive and S.AutoReconnect then
			pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
		end
	end))
end

local function setDisable3D(on)
	S.Disable3D = on and true or false
	pcall(function() RunService:Set3dRenderingEnabled(not S.Disable3D) end)
end

local function setFpsBoost(on)
	S.FpsBoost = on and true or false
	if FpsConn then FpsConn:Disconnect(); FpsConn = nil end
	local function restore()
		for obj, snap in pairs(FpsSnap) do
			if obj and obj.Parent then
				for k, v in pairs(snap) do pcall(function() obj[k] = v end) end
			end
		end
		table.clear(FpsSnap)
	end
	if not S.FpsBoost then restore(); return end
	local function hook(obj)
		if FpsSnap[obj] then return end
		if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")
			or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
			FpsSnap[obj] = { Enabled = obj.Enabled }
			obj.Enabled = false
		end
	end
	for _, d in ipairs(WS:GetDescendants()) do hook(d) end
	if FpsSnap[Lighting] == nil then
		FpsSnap[Lighting] = { GlobalShadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd }
		Lighting.GlobalShadows = false
	end
	FpsConn = WS.DescendantAdded:Connect(function(d)
		if S.FpsBoost then hook(d) end
	end)
end

setAntiAfk(true)

print("[KHUB] +1 Stone Skipping engine ready")

local THEME = {
	bg      = Color3.fromRGB(4, 3, 8),
	title   = Color3.fromRGB(10, 8, 16),
	sidebar = Color3.fromRGB(6, 5, 12),
	card    = Color3.fromRGB(18, 16, 32),
	element = Color3.fromRGB(24, 20, 42),
	accent  = Color3.fromRGB(80, 230, 255),
	accent2 = Color3.fromRGB(185, 110, 255),
	neonPink= Color3.fromRGB(255, 65, 180),
	green   = Color3.fromRGB(65, 255, 145),
	gold    = Color3.fromRGB(255, 220, 130),
	text    = Color3.fromRGB(245, 247, 255),
	dim     = Color3.fromRGB(150, 160, 195),
	tabOn   = Color3.fromRGB(34, 28, 64),
	tabOff  = Color3.fromRGB(14, 12, 28),
	red     = Color3.fromRGB(255, 85, 115),
	blue    = Color3.fromRGB(90, 170, 255),
	purple  = Color3.fromRGB(160, 100, 255),
}

local function corner(o, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = o
	return c
end

local function stroke(o, col, th, tr)
	local s = Instance.new("UIStroke")
	s.Color = col or THEME.accent
	s.Thickness = th or 1
	s.Transparency = tr or 0.2
	s.Parent = o
	return s
end

local function createRipple(btn)
	btn.ClipsDescendants = true
	local circle = Instance.new("Frame")
	circle.AnchorPoint = Vector2.new(0.5, 0.5)
	circle.Position = UDim2.new(0.5, 0, 0.5, 0)
	circle.Size = UDim2.new(0, 0, 0, 0)
	circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	circle.BackgroundTransparency = 0.65
	circle.BorderSizePixel = 0
	circle.ZIndex = (btn.ZIndex or 10) + 1
	circle.Parent = btn
	corner(circle, 999)
	local maxDim = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 2.2
	if maxDim < 50 then maxDim = 120 end
	TweenService:Create(circle, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, maxDim, 0, maxDim),
		BackgroundTransparency = 1,
	}):Play()
	task.delay(0.45, function() circle:Destroy() end)
end

-- ============================================================
-- DIAMOND RAIN / WIND PARTICLE EFFECT
-- ============================================================
local function attachDiamondRain(host, isOrb)
	-- Floating diamonds that drift around like wind / falling leaves
	local diamondContainer = Instance.new("Frame")
	diamondContainer.Name = "DiamondRain"
	diamondContainer.Size = UDim2.new(2, 0, 2, 0)
	diamondContainer.Position = UDim2.new(-0.5, 0, -0.5, 0)
	diamondContainer.BackgroundTransparency = 1
	diamondContainer.ZIndex = (host.ZIndex or 10) + 3
	diamondContainer.Parent = host

	task.spawn(function()
		local diamonds = {}
		local MAX_DIAMONDS = isOrb and 20 or 12

		local function createDiamond()
			if #diamonds >= MAX_DIAMONDS then
				local old = table.remove(diamonds, 1)
				pcall(function() old:Destroy() end)
			end
			local d = Instance.new("Frame")
			local size = math.random(3, 7)
			d.Size = UDim2.new(0, size, 0, size)
			d.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			d.BorderSizePixel = 0
			d.ZIndex = diamondContainer.ZIndex

			-- Diamond shape via rotation + gradient
			d.Rotation = 45
			local grad = Instance.new("UIGradient")
			grad.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0.0, THEME.accent),
				ColorSequenceKeypoint.new(0.5, THEME.neonPink),
				ColorSequenceKeypoint.new(1.0, THEME.accent2),
			})
			grad.Parent = d

			local c = Instance.new("UICorner")
			c.CornerRadius = UDim.new(0, math.random(1, 3))
			c.Parent = d

			-- Random start position around host
			local angle = math.random() * math.pi * 2
			local radius = math.random(20, isOrb and 80 or 60)
			local cx, cy = 0.5, 0.5
			local x = cx + math.cos(angle) * (radius / 200)
			local y = cy + math.sin(angle) * (radius / 200)
			d.AnchorPoint = Vector2.new(0.5, 0.5)
			d.Position = UDim2.new(x, 0, y, 0)

			-- Random transparency
			d.BackgroundTransparency = math.random(20, 60) / 100

			d.Parent = diamondContainer
			table.insert(diamonds, d)

			-- Float animation: drift outward + fade
			local driftAngle = angle + (math.random() - 0.5) * 1.5
			local driftRadius = radius + math.random(40, 80)
			local targetX = cx + math.cos(driftAngle) * (driftRadius / 200)
			local targetY = cy + math.sin(driftAngle) * (driftRadius / 200) - 0.1
			local dur = 1.5 + math.random() * 2.0

			TweenService:Create(d, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(targetX, 0, targetY, 0),
				BackgroundTransparency = 1,
				Size = UDim2.new(0, size * 0.3, 0, size * 0.3),
				Rotation = d.Rotation + math.random(-90, 90),
			}):Play()

			task.delay(dur, function()
				pcall(function() d:Destroy() end)
				for i, v in ipairs(diamonds) do
					if v == d then table.remove(diamonds, i) break end
				end
			end)
		end

		-- Spawn loop
		local t0 = os.clock()
		while host.Parent do
			local elapsed = os.clock() - t0
			local spawnRate = isOrb and 0.15 or 0.25
			if math.sin(elapsed * 3) > 0.8 then
				createDiamond()
				task.wait(spawnRate)
			end
			task.wait(0.05)
		end
	end)
end

-- ============================================================
-- ULTIMATE LOGO AURA + SHOCKWAVE + DIAMONDS
-- ============================================================
local function attachMegaLogoAura(host, imageObj, isCircle)
	host.ClipsDescendants = false

	-- Shockwave pulse ring
	local wave = Instance.new("Frame")
	wave.AnchorPoint = Vector2.new(0.5, 0.5)
	wave.Position = UDim2.new(0.5, 0, 0.5, 0)
	wave.Size = UDim2.new(1, 0, 1, 0)
	wave.BackgroundTransparency = 1
	wave.ZIndex = math.max(1, (host.ZIndex or 10) - 2)
	wave.Parent = host
	corner(wave, isCircle and 999 or 12)

	local waveStroke = Instance.new("UIStroke")
	waveStroke.Thickness = 2
	waveStroke.Color = THEME.accent
	waveStroke.Transparency = 1
	waveStroke.Parent = wave

	-- Rotating Neon Glow Rim
	local ring = Instance.new("Frame")
	ring.AnchorPoint = Vector2.new(0.5, 0.5)
	ring.Position = UDim2.new(0.5, 0, 0.5, 0)
	ring.Size = UDim2.new(1, 8, 1, 8)
	ring.BackgroundTransparency = 1
	ring.ZIndex = math.max(1, (host.ZIndex or 10) - 1)
	ring.Parent = host
	corner(ring, isCircle and 999 or 12)

	local ringStroke = Instance.new("UIStroke")
	ringStroke.Thickness = 2
	ringStroke.Transparency = 0.2
	ringStroke.Color = Color3.fromRGB(255, 255, 255)
	ringStroke.Parent = ring

	local ringGrad = Instance.new("UIGradient")
	ringGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.0, THEME.neonPink),
		ColorSequenceKeypoint.new(0.35, THEME.accent),
		ColorSequenceKeypoint.new(0.7, THEME.accent2),
		ColorSequenceKeypoint.new(1.0, THEME.neonPink),
	})
	ringGrad.Parent = ringStroke

	-- Inner Shimmer Core
	local coreShimmer = Instance.new("Frame")
	coreShimmer.AnchorPoint = Vector2.new(0.5, 0.5)
	coreShimmer.Position = UDim2.new(0.5, 0, 0.5, 0)
	coreShimmer.Size = UDim2.new(1, 0, 1, 0)
	coreShimmer.BackgroundTransparency = 0.85
	coreShimmer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	coreShimmer.BorderSizePixel = 0
	coreShimmer.ZIndex = (host.ZIndex or 10) + 1
	coreShimmer.Parent = host
	corner(coreShimmer, isCircle and 999 or 8)

	local coreGrad = Instance.new("UIGradient")
	coreGrad.Rotation = 45
	coreGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, THEME.accent),
		ColorSequenceKeypoint.new(1.0, THEME.neonPink),
	})
	coreGrad.Parent = coreShimmer

	-- Sparkle burst particles
	local sparkleContainer = Instance.new("Frame")
	sparkleContainer.Size = UDim2.new(2, 0, 2, 0)
	sparkleContainer.Position = UDim2.new(-0.5, 0, -0.5, 0)
	sparkleContainer.BackgroundTransparency = 1
	sparkleContainer.ZIndex = (host.ZIndex or 10) + 4
	sparkleContainer.Parent = host

	local function burstSparkles(count, color)
		for i = 1, count or 8 do
			local s = Instance.new("Frame")
			local sz = math.random(2, 5)
			s.Size = UDim2.new(0, sz, 0, sz)
			s.AnchorPoint = Vector2.new(0.5, 0.5)
			s.Position = UDim2.new(0.5, 0, 0.5, 0)
			s.BackgroundColor3 = color or THEME.gold
			s.BorderSizePixel = 0
			s.Rotation = math.random(0, 360)
			s.ZIndex = sparkleContainer.ZIndex
			s.Parent = sparkleContainer
			local c = Instance.new("UICorner")
			c.CornerRadius = UDim.new(0, sz)
			c.Parent = s

			local a = math.random() * math.pi * 2
			local r = math.random(20, 60)
			TweenService:Create(s, TweenInfo.new(0.6 + math.random() * 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5 + math.cos(a) * r / 200, 0, 0.5 + math.sin(a) * r / 200, 0),
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 0, 0, 0),
			}):Play()
			task.delay(1, function() pcall(function() s:Destroy() end) end)
		end
	end

	-- Attach diamond rain
	attachDiamondRain(host, isCircle)

	-- Live Animation Thread
	task.spawn(function()
		local t0 = os.clock()
		local nextWave = t0 + 1.2
		local nextSparkle = t0 + 0.8

		while host.Parent do
			local elapsed = os.clock() - t0
			local sine = (math.sin(elapsed * 4.2) + 1) * 0.5

			ringGrad.Rotation = (elapsed * 90) % 360
			coreGrad.Rotation = (elapsed * 120) % 360

			ringStroke.Thickness = 1.6 + sine * 1.4
			ringStroke.Transparency = 0.15 + sine * 0.4
			coreShimmer.BackgroundTransparency = 0.78 + sine * 0.18

			if os.clock() >= nextWave then
				nextWave = os.clock() + 2.0
				wave.Size = UDim2.new(1, 0, 1, 0)
				waveStroke.Transparency = 0.2
				waveStroke.Color = math.random() > 0.5 and THEME.accent or THEME.neonPink
				TweenService:Create(wave, TweenInfo.new(1.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Size = UDim2.new(2.2, 0, 2.2, 0),
				}):Play()
				TweenService:Create(waveStroke, TweenInfo.new(1.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Transparency = 1,
					Thickness = 0.5,
				}):Play()
				burstSparkles(6, THEME.accent)
			end

			if os.clock() >= nextSparkle then
				nextSparkle = os.clock() + 1.5 + math.random() * 0.5
				burstSparkles(3, Color3.fromRGB(255, 255, 255))
			end

			task.wait(0.03)
		end
	end)
end

local function getParent()
	local ok, r = pcall(function() if gethui then return gethui() end end)
	if ok and r then return r end
	return CoreGui
end

pcall(function()
	for _, n in ipairs({"KHUB_UI_Only", "HussValley", "StealFromTheRich_UI", "KHUB_UI_Modern", "KHUB_UI_Ultimate"}) do
		local g = CoreGui:FindFirstChild(n) or (player.PlayerGui and player.PlayerGui:FindFirstChild(n))
		if g then g:Destroy() end
	end
end)

-- VIEWPORT ADAPTIVE SIZING
local camera = Workspace.CurrentCamera
local vpSize = camera and camera.ViewportSize or Vector2.new(1280, 720)

local WIN_W = math.clamp(vpSize.X * 0.75, 420, 560)
local WIN_H = math.clamp(vpSize.Y * 0.75, 320, 420)
local SIDE_W = isMobile and 100 or 124

if isMobile and vpSize.X < 500 then
	WIN_W = vpSize.X - 24
	WIN_H = vpSize.Y - 40
	SIDE_W = 95
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KHUB_UI_Ultimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.IgnoreGuiInset = true
pcall(function() ScreenGui.ClipToDeviceSafeArea = false end)
ScreenGui.Parent = getParent()

-- TOAST NOTIFICATIONS
local ToastHost = Instance.new("Frame")
ToastHost.Size = UDim2.new(0, 270, 0, 420)
ToastHost.Position = UDim2.new(1, -290, 0, 50)
ToastHost.BackgroundTransparency = 1
ToastHost.ZIndex = 200
ToastHost.Parent = ScreenGui
local toastLay = Instance.new("UIListLayout")
toastLay.SortOrder = Enum.SortOrder.LayoutOrder
toastLay.Padding = UDim.new(0, 8)
toastLay.Parent = ToastHost

local function notify(title, desc, ok)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 52)
	card.BackgroundColor3 = Color3.fromRGB(15, 14, 26)
	card.BackgroundTransparency = 0.1
	card.BorderSizePixel = 0
	card.ZIndex = 201
	card.Parent = ToastHost
	corner(card, 10)
	stroke(card, ok and THEME.green or THEME.neonPink, 1.4, 0.25)
	local icon = Instance.new("TextLabel")
	icon.Size = UDim2.new(0, 28, 0, 28)
	icon.Position = UDim2.new(0, 10, 0.5, -14)
	icon.BackgroundTransparency = 1
	icon.Text = ok and "✓" or "✦"
	icon.TextColor3 = ok and THEME.green or THEME.accent
	icon.Font = Enum.Font.GothamBold
	icon.TextSize = 18
	icon.ZIndex = 202
	icon.Parent = card
	local t = Instance.new("TextLabel")
	t.Size = UDim2.new(1, -48, 0, 20)
	t.Position = UDim2.new(0, 42, 0, 6)
	t.BackgroundTransparency = 1
	t.Text = tostring(title)
	t.Font = Enum.Font.GothamBold
	t.TextSize = 13
	t.TextColor3 = THEME.text
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.ZIndex = 202
	t.Parent = card
	local d = Instance.new("TextLabel")
	d.Size = UDim2.new(1, -48, 0, 16)
	d.Position = UDim2.new(0, 42, 0, 28)
	d.BackgroundTransparency = 1
	d.Text = tostring(desc or "")
	d.Font = Enum.Font.Gotham
	d.TextSize = 11
	d.TextColor3 = THEME.dim
	d.TextXAlignment = Enum.TextXAlignment.Left
	d.ZIndex = 202
	d.Parent = card
	card.Position = UDim2.new(1, 30, 0, 0)
	TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, 0, 0, 0),
	}):Play()
	task.delay(2.8, function()
		local tw = TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 30, 0, 0),
			BackgroundTransparency = 1,
		})
		tw:Play()
		tw.Completed:Wait()
		card:Destroy()
	end)
end

-- MAIN CONTAINER
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, WIN_W, 0, WIN_H)
Main.Position = UDim2.new(0.5, -WIN_W / 2, 0.5, -WIN_H / 2)
Main.BackgroundColor3 = THEME.bg
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = false
Main.Parent = ScreenGui

-- Floating dots (monochrome-style sparkles on UI background)
do
	local dotsHost = Instance.new("Frame")
	dotsHost.Name = "MonoDots"
	dotsHost.Size = UDim2.new(1, 0, 1, 0)
	dotsHost.BackgroundTransparency = 1
	dotsHost.ZIndex = (Main.ZIndex or 5) + 1
	dotsHost.ClipsDescendants = true
	dotsHost.Parent = Main

	local function spawnDot()
		local d = Instance.new("Frame")
		local sz = math.random(2, 5)
		d.Size = UDim2.new(0, sz, 0, sz)
		d.AnchorPoint = Vector2.new(0.5, 0.5)
		d.Position = UDim2.new(math.random(), 0, math.random(), 0)
		d.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		d.BackgroundTransparency = math.random(35, 70) / 100
		d.BorderSizePixel = 0
		d.ZIndex = dotsHost.ZIndex
		d.Parent = dotsHost
		corner(d, sz)
		local dur = 1.8 + math.random() * 2.2
		local tx = d.Position.X.Scale + (math.random() - 0.5) * 0.15
		local ty = d.Position.Y.Scale - (0.05 + math.random() * 0.12)
		TweenService:Create(d, TweenInfo.new(dur, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Position = UDim2.new(math.clamp(tx, 0, 1), 0, math.clamp(ty, 0, 1), 0),
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 1, 0, 1),
		}):Play()
		task.delay(dur + 0.05, function() pcall(function() d:Destroy() end) end)
	end

	task.spawn(function()
		while dotsHost.Parent do
			if Main.Visible then
				for _ = 1, math.random(1, 3) do
					spawnDot()
				end
			end
			task.wait(0.35 + math.random() * 0.45)
		end
	end)
end

corner(Main, 12)

-- Animated RGB Outer Stroke for Main Frame
local mainStroke = stroke(Main, THEME.accent2, 1.6, 0.2)
local mainGrad = Instance.new("UIGradient")
mainGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0.0, THEME.neonPink),
	ColorSequenceKeypoint.new(0.33, THEME.accent),
	ColorSequenceKeypoint.new(0.66, THEME.accent2),
	ColorSequenceKeypoint.new(1.0, THEME.neonPink),
})
mainGrad.Parent = mainStroke

task.spawn(function()
	while Main.Parent do
		mainGrad.Rotation = (tick() * 55) % 360
		task.wait(0.03)
	end
end)

local BgImg = Instance.new("ImageLabel")
BgImg.Size = UDim2.new(1, 0, 1, 0)
BgImg.BackgroundTransparency = 1
BgImg.Image = BG_ID
BgImg.ImageTransparency = 0.88
BgImg.ScaleType = Enum.ScaleType.Crop
BgImg.ZIndex = 1
BgImg.Parent = Main

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 68)
TitleBar.BackgroundColor3 = THEME.title
TitleBar.BackgroundTransparency = 0.25
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 10
TitleBar.Parent = Main

local LogoWrap = Instance.new("Frame")
LogoWrap.Size = UDim2.new(0, 38, 0, 38)
LogoWrap.Position = UDim2.new(0, 12, 0.5, -19)
LogoWrap.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
LogoWrap.BorderSizePixel = 0
LogoWrap.ClipsDescendants = false
LogoWrap.ZIndex = 12
LogoWrap.Parent = TitleBar
corner(LogoWrap, 9)

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Image = LOGO_ID
Logo.ScaleType = Enum.ScaleType.Fit
Logo.ZIndex = 14
Logo.Parent = LogoWrap
corner(Logo, 9)
attachMegaLogoAura(LogoWrap, Logo, false)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(1, -130, 0, 22)
TitleLbl.Position = UDim2.new(0, 58, 0, 13)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "+1 STONE SKIPPING"
TitleLbl.TextColor3 = Color3.new(1, 1, 1)
TitleLbl.Font = Enum.Font.GothamBlack
TitleLbl.TextSize = 16
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.ZIndex = 11
TitleLbl.Parent = TitleBar

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0.0, THEME.accent),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1.0, THEME.neonPink),
})
TitleGrad.Parent = TitleLbl

task.spawn(function()
	while TitleLbl.Parent do
		TitleGrad.Offset = Vector2.new(math.sin(tick() * 1.4) * 0.5, 0)
		task.wait(0.03)
	end
end)

local SubLbl = Instance.new("TextLabel")
SubLbl.Size = UDim2.new(1, -130, 0, 16)
SubLbl.Position = UDim2.new(0, 58, 0, 37)
SubLbl.BackgroundTransparency = 1
SubLbl.Text = "KHUB · by Kyiel Pambid"
SubLbl.TextColor3 = THEME.dim
SubLbl.Font = Enum.Font.Gotham
SubLbl.TextSize = 11
SubLbl.TextXAlignment = Enum.TextXAlignment.Left
SubLbl.ZIndex = 11
SubLbl.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 19)
CloseBtn.BackgroundColor3 = Color3.fromRGB(46, 18, 30)
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = THEME.red
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 12
CloseBtn.Parent = TitleBar
corner(CloseBtn, 7)
stroke(CloseBtn, THEME.red, 1, 0.4)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -74, 0, 19)
MinBtn.BackgroundColor3 = Color3.fromRGB(24, 26, 48)
MinBtn.BackgroundTransparency = 0.2
MinBtn.Text = "—"
MinBtn.TextColor3 = THEME.text
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.ZIndex = 12
MinBtn.Parent = TitleBar
corner(MinBtn, 7)
stroke(MinBtn, THEME.blue, 1, 0.4)

-- DRAGGABLE TITLEBAR
do
	local dragging, dragStart, startPos = false, nil, nil
	TitleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- BODY & SIDEBAR
local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, 0, 1, -96)
Body.Position = UDim2.new(0, 0, 0, 68)
Body.BackgroundTransparency = 1
Body.ZIndex = 5
Body.Parent = Main

local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(0, SIDE_W, 0, 28)
Footer.Position = UDim2.new(0, 0, 1, -28)
Footer.BackgroundColor3 = Color3.fromRGB(8, 10, 18)
Footer.BackgroundTransparency = 0.2
Footer.BorderSizePixel = 0
Footer.ZIndex = 20
Footer.Parent = Main
corner(Footer, 6)
stroke(Footer, THEME.green, 1.2, 0.3)

local FootLabel = Instance.new("TextLabel")
FootLabel.Size = UDim2.new(1, -6, 1, 0)
FootLabel.Position = UDim2.new(0, 3, 0, 0)
FootLabel.BackgroundTransparency = 1
FootLabel.Text = "kyiel pambid · active"
FootLabel.Font = Enum.Font.GothamBold
FootLabel.TextSize = 10
FootLabel.TextColor3 = THEME.green
FootLabel.TextXAlignment = Enum.TextXAlignment.Center
FootLabel.ZIndex = 21
FootLabel.Parent = Footer

local FootGrad = Instance.new("UIGradient")
FootGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, THEME.green),
	ColorSequenceKeypoint.new(0.50, THEME.accent),
	ColorSequenceKeypoint.new(1.00, THEME.neonPink),
})
FootGrad.Parent = FootLabel

task.spawn(function()
	while FootLabel.Parent do
		FootGrad.Offset = Vector2.new(math.sin(tick() * 1.5) * 0.6, 0)
		task.wait(0.03)
	end
end)

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, SIDE_W, 1, 0)
Sidebar.BackgroundColor3 = THEME.sidebar
Sidebar.BackgroundTransparency = 0.35
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 3
Sidebar.ScrollBarImageColor3 = THEME.accent
Sidebar.ScrollingEnabled = true
Sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.ClipsDescendants = true
Sidebar.ZIndex = 6
Sidebar.Parent = Body

local sideLay = Instance.new("UIListLayout")
sideLay.SortOrder = Enum.SortOrder.LayoutOrder
sideLay.Padding = UDim.new(0, 5)
sideLay.Parent = Sidebar
local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 6)
sidePad.PaddingLeft = UDim.new(0, 6)
sidePad.PaddingRight = UDim.new(0, 6)
sidePad.PaddingBottom = UDim.new(0, 10)
sidePad.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -SIDE_W, 1, 0)
Content.Position = UDim2.new(0, SIDE_W, 0, 0)
Content.BackgroundTransparency = 1
Content.ZIndex = 6
Content.Parent = Body

local pages, tabButtons = {}, {}

local function switchTab(id)
	for name, pg in pairs(pages) do
		if name == id then
			pg.Visible = true
			pg.Position = UDim2.new(0, 18, 0, 0)
			TweenService:Create(pg, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, 0, 0, 0),
			}):Play()
		else
			pg.Visible = false
		end
	end
	for name, btn in pairs(tabButtons) do
		local active = (name == id)
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundColor3 = active and THEME.tabOn or THEME.tabOff,
			BackgroundTransparency = active and 0.25 or 0.55,
		}):Play()
		local ind = btn:FindFirstChild("ActiveBar")
		if ind then ind.Visible = active end
		local ic = btn:FindFirstChild("TabIcon")
		if ic then
			TweenService:Create(ic, TweenInfo.new(0.2), {
				ImageColor3 = active and THEME.accent or THEME.dim,
			}):Play()
		end
	end
end

local function createTab(id, label, order, iconName)
	local btn = Instance.new("TextButton")
	btn.Name = id
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.BackgroundColor3 = THEME.tabOff
	btn.BackgroundTransparency = 0.55
	btn.Text = ""
	btn.LayoutOrder = order
	btn.ZIndex = 8
	btn.Parent = Sidebar
	corner(btn, 7)
	local bar = Instance.new("Frame")
	bar.Name = "ActiveBar"
	bar.Size = UDim2.new(0, 3, 0.65, 0)
	bar.Position = UDim2.new(0, 2, 0.18, 0)
	bar.BackgroundColor3 = THEME.green
	bar.BorderSizePixel = 0
	bar.Visible = false
	bar.ZIndex = 9
	bar.Parent = btn
	corner(bar, 2)
	local iconImg = Instance.new("ImageLabel")
	iconImg.Name = "TabIcon"
	iconImg.Size = UDim2.new(0, 15, 0, 15)
	iconImg.Position = UDim2.new(0, 8, 0.5, -8)
	iconImg.BackgroundTransparency = 1
	iconImg.Image = resolveIcon(iconName)
	iconImg.ImageColor3 = THEME.dim
	iconImg.ZIndex = 9
	iconImg.Parent = btn
	local txt = Instance.new("TextLabel")
	txt.Size = UDim2.new(1, -28, 1, 0)
	txt.Position = UDim2.new(0, 26, 0, 0)
	txt.BackgroundTransparency = 1
	txt.Text = label
	txt.TextColor3 = THEME.text
	txt.Font = Enum.Font.GothamMedium
	txt.TextSize = 12
	txt.TextXAlignment = Enum.TextXAlignment.Left
	txt.ZIndex = 9
	txt.Parent = btn
	tabButtons[id] = btn
	local page = Instance.new("ScrollingFrame")
	page.Name = id
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = THEME.accent
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.ScrollingEnabled = true
	page.Visible = false
	page.ZIndex = 7
	page.Parent = Content
	local lay = Instance.new("UIListLayout")
	lay.SortOrder = Enum.SortOrder.LayoutOrder
	lay.Padding = UDim.new(0, 8)
	lay.Parent = page
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 8)
	pad.PaddingLeft = UDim.new(0, 10)
	pad.PaddingRight = UDim.new(0, 10)
	pad.PaddingBottom = UDim.new(0, 14)
	pad.Parent = page
	pages[id] = page
	btn.MouseButton1Click:Connect(function()
		createRipple(btn)
		switchTab(id)
	end)
	return page
end

local function tabMessages(parent, lines)
	if not lines or #lines == 0 then return end
	local box = Instance.new("Frame")
	box.Size = UDim2.new(1, 0, 0, 0)
	box.AutomaticSize = Enum.AutomaticSize.Y
	box.BackgroundColor3 = Color3.fromRGB(10, 12, 22)
	box.BackgroundTransparency = 0.25
	box.BorderSizePixel = 0
	box.ZIndex = 9
	box.Parent = parent
	corner(box, 8)
	stroke(box, THEME.green, 1.2, 0.4)
	local lay = Instance.new("UIListLayout")
	lay.SortOrder = Enum.SortOrder.LayoutOrder
	lay.Padding = UDim.new(0, 4)
	lay.Parent = box
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 8)
	pad.PaddingBottom = UDim.new(0, 8)
	pad.PaddingLeft = UDim.new(0, 10)
	pad.PaddingRight = UDim.new(0, 10)
	pad.Parent = box
	for i, raw in ipairs(lines) do
		local col, msg = THEME.green, raw
		if string.sub(raw, 1, 2) == "<>" then
			col = THEME.green; msg = string.gsub(string.sub(raw, 3), "^%s+", "")
		elseif string.sub(raw, 1, 1) == "$" then
			col = THEME.neonPink; msg = string.gsub(string.sub(raw, 2), "^%s+", "")
		elseif string.sub(raw, 1, 1) == ">" then
			col = THEME.blue; msg = string.gsub(string.sub(raw, 2), "^%s+", "")
		end
		local l = Instance.new("TextLabel")
		l.Size = UDim2.new(1, 0, 0, 0)
		l.AutomaticSize = Enum.AutomaticSize.Y
		l.BackgroundTransparency = 1
		l.Text = msg
		l.TextColor3 = col
		l.Font = Enum.Font.GothamMedium
		l.TextSize = 11
		l.TextWrapped = true
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.LayoutOrder = i
		l.ZIndex = 10
		l.Parent = box
	end
	return box
end

local function section(parent, title)
	local f = Instance.new("Frame")
	f.Size = UDim2.new(1, 0, 0, 0)
	f.AutomaticSize = Enum.AutomaticSize.Y
	f.BackgroundColor3 = THEME.card
	f.BackgroundTransparency = 0.35
	f.BorderSizePixel = 0
	f.ZIndex = 8
	f.Parent = parent
	corner(f, 8)
	stroke(f, THEME.accent2, 1, 0.55)
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 8)
	pad.PaddingBottom = UDim.new(0, 8)
	pad.PaddingLeft = UDim.new(0, 10)
	pad.PaddingRight = UDim.new(0, 10)
	pad.Parent = f
	local lay = Instance.new("UIListLayout")
	lay.Padding = UDim.new(0, 6)
	lay.Parent = f
	local h = Instance.new("TextLabel")
	h.Size = UDim2.new(1, 0, 0, 16)
	h.BackgroundTransparency = 1
	h.Text = title
	h.TextColor3 = THEME.accent
	h.Font = Enum.Font.GothamBold
	h.TextSize = 12
	h.TextXAlignment = Enum.TextXAlignment.Left
	h.ZIndex = 9
	h.Parent = f
	return f
end

local function addToggle(parent, text, default, callback)
	local on = default == true
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 32)
	row.BackgroundColor3 = THEME.element
	row.BackgroundTransparency = 0.35
	row.BorderSizePixel = 0
	row.ZIndex = 9
	row.Parent = parent
	corner(row, 6)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -54, 1, 0)
	lbl.Position = UDim2.new(0, 8, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = THEME.text
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 10
	lbl.Parent = row
	local outer = Instance.new("Frame")
	outer.Size = UDim2.new(0, 38, 0, 18)
	outer.Position = UDim2.new(1, -44, 0.5, -9)
	outer.BackgroundColor3 = Color3.fromRGB(45, 48, 68)
	outer.ZIndex = 10
	outer.Parent = row
	corner(outer, 9)
	local kn = Instance.new("Frame")
	kn.Size = UDim2.new(0, 14, 0, 14)
	kn.Position = UDim2.new(0, 2, 0.5, -7)
	kn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	kn.ZIndex = 11
	kn.Parent = outer
	corner(kn, 7)
	local function paint()
		TweenService:Create(outer, TweenInfo.new(0.2), {
			BackgroundColor3 = on and THEME.green or Color3.fromRGB(45, 48, 68),
		}):Play()
		TweenService:Create(kn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = on and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
		}):Play()
	end
	paint()
	local hit = Instance.new("TextButton")
	hit.Size = UDim2.new(1, 0, 1, 0)
	hit.BackgroundTransparency = 1
	hit.Text = ""
	hit.ZIndex = 12
	hit.Parent = row
	hit.MouseButton1Click:Connect(function()
		createRipple(hit)
		on = not on
		paint()
		notify(text, on and "Enabled" or "Disabled", on)
		if callback then callback(on) end
	end)
	return row
end

local function addSlider(parent, text, min, max, default, callback)
	local value = default or min
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 50)
	row.BackgroundColor3 = THEME.element
	row.BackgroundTransparency = 0.35
	row.BorderSizePixel = 0
	row.ZIndex = 9
	row.Parent = parent
	corner(row, 6)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -12, 0, 18)
	lbl.Position = UDim2.new(0, 8, 0, 4)
	lbl.BackgroundTransparency = 1
	lbl.Text = text .. ": " .. tostring(value)
	lbl.TextColor3 = THEME.text
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 10
	lbl.Parent = row
	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(1, -16, 0, 8)
	bar.Position = UDim2.new(0, 8, 0, 32)
	bar.BackgroundColor3 = Color3.fromRGB(40, 42, 60)
	bar.BorderSizePixel = 0
	bar.ZIndex = 10
	bar.Parent = row
	corner(bar, 4)
	local fill = Instance.new("Frame")
	local ratio = (value - min) / math.max(1, (max - min))
	fill.Size = UDim2.new(ratio, 0, 1, 0)
	fill.BackgroundColor3 = THEME.accent
	fill.BorderSizePixel = 0
	fill.ZIndex = 11
	fill.Parent = bar
	corner(fill, 4)
	local fillGrad = Instance.new("UIGradient")
	fillGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.0, THEME.neonPink),
		ColorSequenceKeypoint.new(1.0, THEME.accent),
	})
	fillGrad.Parent = fill
	local dragging = false
	local function setFromX(x)
		local rel = math.clamp((x - bar.AbsolutePosition.X) / math.max(1, bar.AbsoluteSize.X), 0, 1)
		value = math.floor(min + rel * (max - min) + 0.5)
		fill.Size = UDim2.new(rel, 0, 1, 0)
		lbl.Text = text .. ": " .. tostring(value)
		if callback then callback(value) end
	end
	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; setFromX(input.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			setFromX(input.Position.X)
		end
	end)
	return row
end

local function addButton(parent, text, cb, col)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, 0, 0, 34)
	b.BackgroundColor3 = col or Color3.fromRGB(30, 36, 62)
	b.BackgroundTransparency = 0.25
	b.Text = text
	b.TextColor3 = THEME.text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 12
	b.ZIndex = 9
	b.Parent = parent
	corner(b, 7)
	stroke(b, col or THEME.accent, 1, 0.45)
	b.MouseButton1Click:Connect(function()
		createRipple(b)
		notify(text, "Triggered", true)
		if cb then cb() end
	end)
	return b
end

local function addLabel(parent, text, size, col)
	local l = Instance.new("TextLabel")
	l.Size = UDim2.new(1, 0, 0, 0)
	l.AutomaticSize = Enum.AutomaticSize.Y
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = col or THEME.dim
	l.Font = Enum.Font.Gotham
	l.TextSize = size or 11
	l.TextWrapped = true
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.ZIndex = 9
	l.Parent = parent
	return l
end

local function addTextbox(parent, text, placeholder, callback)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 54)
	row.BackgroundTransparency = 1
	row.ZIndex = 9
	row.Parent = parent
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 16)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = THEME.text
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 10
	lbl.Parent = row
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, 0, 0, 30)
	box.Position = UDim2.new(0, 0, 0, 22)
	box.BackgroundColor3 = THEME.element
	box.BackgroundTransparency = 0.25
	box.PlaceholderText = placeholder or ""
	box.Text = ""
	box.TextColor3 = THEME.text
	box.Font = Enum.Font.Gotham
	box.TextSize = 12
	box.ClearTextOnFocus = false
	box.ZIndex = 10
	box.Parent = row
	corner(box, 6)
	stroke(box, THEME.accent2, 1, 0.5)
	box.FocusLost:Connect(function() pcall(callback, box.Text) end)
	return box
end


local function addDropdown(parent, text, options, multi, callback)
	options = options or {}
	local selected, open = {}, false
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 36)
	row.BackgroundTransparency = 1
	row.ZIndex = 9
	row.Parent = parent
	row.ClipsDescendants = false
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = THEME.element
	btn.BackgroundTransparency = 0.25
	btn.Text = text .. ": (none)"
	btn.TextColor3 = THEME.text
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 12
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.ZIndex = 10
	btn.Parent = row
	corner(btn, 6)
	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 10)
	pad.Parent = btn
	local list = Instance.new("ScrollingFrame")
	list.Size = UDim2.new(1, 0, 0, 0)
	list.Position = UDim2.new(0, 0, 0, 34)
	list.BackgroundColor3 = THEME.card
	list.BackgroundTransparency = 0.1
	list.BorderSizePixel = 0
	list.Visible = false
	list.ZIndex = 30
	list.ScrollBarThickness = 3
	list.AutomaticCanvasSize = Enum.AutomaticSize.Y
	list.CanvasSize = UDim2.new(0, 0, 0, 0)
	list.Parent = row
	corner(list, 6)
	local lay = Instance.new("UIListLayout")
	lay.SortOrder = Enum.SortOrder.LayoutOrder
	lay.Parent = list
	local function refreshLabel()
		local names = {}
		for k, v in pairs(selected) do if v then table.insert(names, tostring(k)) end end
		table.sort(names)
		if #names == 0 then btn.Text = text .. ": (none)"
		elseif not multi then btn.Text = text .. ": " .. (names[1] or "none")
		elseif #names <= 2 then btn.Text = text .. ": " .. table.concat(names, ", ")
		else btn.Text = text .. ": " .. #names .. " selected" end
	end
	local function rebuild()
		for _, ch in ipairs(list:GetChildren()) do
			if ch:IsA("TextButton") then ch:Destroy() end
		end
		for i, opt in ipairs(options) do
			local o = Instance.new("TextButton")
			o.Size = UDim2.new(1, 0, 0, 26)
			o.BackgroundColor3 = selected[opt] and Color3.fromRGB(40, 90, 60) or THEME.element
			o.BackgroundTransparency = 0.3
			o.Text = (selected[opt] and "✓ " or "  ") .. opt
			o.TextColor3 = selected[opt] and THEME.green or THEME.text
			o.Font = Enum.Font.Gotham
			o.TextSize = 11
			o.TextXAlignment = Enum.TextXAlignment.Left
			o.LayoutOrder = i
			o.ZIndex = 31
			o.Parent = list
			corner(o, 4)
			local op = Instance.new("UIPadding")
			op.PaddingLeft = UDim.new(0, 8)
			op.Parent = o
			o.MouseButton1Click:Connect(function()
				if multi then
					selected[opt] = not selected[opt]
				else
					table.clear(selected)
					selected[opt] = true
					open = false
					list.Visible = false
					row.Size = UDim2.new(1, 0, 0, 36)
				end
				rebuild()
				refreshLabel()
				if callback then
					if multi then callback(selected) else callback(opt) end
				end
			end)
		end
		list.Size = UDim2.new(1, 0, 0, math.min(26 * math.max(#options, 1) + 4, 140))
	end
	btn.MouseButton1Click:Connect(function()
		open = not open
		list.Visible = open
		row.Size = UDim2.new(1, 0, 0, open and (36 + math.min(26 * math.max(#options, 1) + 4, 140)) or 36)
		if open then rebuild() end
	end)
	rebuild()
	refreshLabel()
	return {
		SetOptions = function(_, opts) options = opts or {}; rebuild(); refreshLabel() end,
		SetValue = function(_, val)
			table.clear(selected)
			if multi and type(val) == "table" then
				for _, v in ipairs(val) do selected[v] = true end
			elseif val then
				selected[val] = true
			end
			rebuild(); refreshLabel()
		end,
	}
end

local function collapsibleSection(parent, title)
	local wrap = Instance.new("Frame")
	wrap.Size = UDim2.new(1, 0, 0, 0)
	wrap.AutomaticSize = Enum.AutomaticSize.Y
	wrap.BackgroundTransparency = 1
	wrap.ZIndex = 8
	wrap.Parent = parent

	local header = Instance.new("TextButton")
	header.Size = UDim2.new(1, 0, 0, 28)
	header.BackgroundColor3 = THEME.card
	header.BackgroundTransparency = 0.25
	header.Text = ""
	header.ZIndex = 9
	header.Parent = wrap
	corner(header, 6)
	stroke(header, THEME.accent2, 1, 0.55)

	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size = UDim2.new(1, -40, 1, 0)
	titleLbl.Position = UDim2.new(0, 10, 0, 0)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text = title
	titleLbl.TextColor3 = THEME.gold
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.TextSize = 12
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.ZIndex = 10
	titleLbl.Parent = header

	local chev = Instance.new("TextLabel")
	chev.Size = UDim2.new(0, 28, 1, 0)
	chev.Position = UDim2.new(1, -30, 0, 0)
	chev.BackgroundTransparency = 1
	chev.Text = "↓"
	chev.TextColor3 = THEME.accent
	chev.Font = Enum.Font.GothamBold
	chev.TextSize = 14
	chev.ZIndex = 10
	chev.Parent = header

	local body = Instance.new("Frame")
	body.Size = UDim2.new(1, 0, 0, 0)
	body.AutomaticSize = Enum.AutomaticSize.Y
	body.Position = UDim2.new(0, 0, 0, 30)
	body.BackgroundTransparency = 1
	body.ZIndex = 9
	body.Visible = true
	body.Parent = wrap

	local blay = Instance.new("UIListLayout")
	blay.SortOrder = Enum.SortOrder.LayoutOrder
	blay.Padding = UDim.new(0, 6)
	blay.Parent = body
	local bpad = Instance.new("UIPadding")
	bpad.PaddingTop = UDim.new(0, 4)
	bpad.PaddingBottom = UDim.new(0, 6)
	bpad.PaddingLeft = UDim.new(0, 2)
	bpad.PaddingRight = UDim.new(0, 2)
	bpad.Parent = body

	local expanded = true
	header.MouseButton1Click:Connect(function()
		expanded = not expanded
		body.Visible = expanded
		chev.Text = expanded and "↓" or "↑"
	end)
	return body
end

-- ============================================================
-- TABS DEFINITION
-- ============================================================
local PageWelcome  = createTab("Welcome",  "Welcome",  1, "welcome")
local PageMain     = createTab("Main",     "Main",     2, "main")
local PagePlayer   = createTab("Player",   "Player",   3, "player")
local PageSettings = createTab("Settings", "Settings", 4, "settings")
local PageServer   = createTab("Server",   "Server",   5, "server")

-- WELCOME PAGE
do
	local Hero = Instance.new("Frame")
	Hero.Size = UDim2.new(1, 0, 0, 134)
	Hero.BackgroundColor3 = THEME.card
	Hero.BackgroundTransparency = 0.35
	Hero.BorderSizePixel = 0
	Hero.ZIndex = 8
	Hero.Parent = PageWelcome
	corner(Hero, 10)
	stroke(Hero, THEME.neonPink, 1.2, 0.4)

	local HeroText = Instance.new("TextLabel")
	HeroText.Size = UDim2.new(1, -24, 0, 52)
	HeroText.Position = UDim2.fromOffset(14, 12)
	HeroText.BackgroundTransparency = 1
	HeroText.Text = "KHUB"
	HeroText.Font = Enum.Font.GothamBlack
	HeroText.TextSize = 48
	HeroText.TextColor3 = Color3.new(1, 1, 1)
	HeroText.TextXAlignment = Enum.TextXAlignment.Left
	HeroText.ZIndex = 10
	HeroText.Parent = Hero
	local HeroGrad = Instance.new("UIGradient")
	HeroGrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, THEME.accent),
		ColorSequenceKeypoint.new(0.35, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(0.65, THEME.neonPink),
		ColorSequenceKeypoint.new(1.00, THEME.gold),
	})
	HeroGrad.Offset = Vector2.new(-1.4, 0)
	HeroGrad.Parent = HeroText
	task.spawn(function()
		while HeroText.Parent do
			local t = (tick() % 3) / 3
			HeroGrad.Offset = Vector2.new(-1.4 + t * 2.8, 0)
			task.wait(0.03)
		end
	end)

	local HeroBy = Instance.new("TextLabel")
	HeroBy.Size = UDim2.new(1, -24, 0, 18)
	HeroBy.Position = UDim2.fromOffset(16, 68)
	HeroBy.BackgroundTransparency = 1
	HeroBy.Text = "by Kyiel Pambid"
	HeroBy.Font = Enum.Font.GothamBold
	HeroBy.TextSize = 13
	HeroBy.TextColor3 = THEME.gold
	HeroBy.TextXAlignment = Enum.TextXAlignment.Left
	HeroBy.ZIndex = 10
	HeroBy.Parent = Hero

	local HeroType = Instance.new("TextLabel")
	HeroType.Size = UDim2.new(1, -24, 0, 16)
	HeroType.Position = UDim2.fromOffset(16, 92)
	HeroType.BackgroundTransparency = 1
	HeroType.Text = ""
	HeroType.Font = Enum.Font.Code
	HeroType.TextSize = 11
	HeroType.TextColor3 = THEME.dim
	HeroType.TextXAlignment = Enum.TextXAlignment.Left
	HeroType.ZIndex = 10
	HeroType.Parent = Hero

	task.spawn(function()
		local phrases = {
			"PC & Mobile Cross-Platform Ready",
			"Join Discord for updates & scripts",
			"Subscribe to YouTube: @kyielpambid",
			"Toggle Key: RightShift / Mobile Orb",
			"KHUB Ultimate Edition ✦",
		}
		while HeroType.Parent do
			for _, phrase in ipairs(phrases) do
				if not HeroType.Parent then break end
				HeroType.Text = ""
				for i = 1, #phrase do
					if not HeroType.Parent then break end
					HeroType.Text = string.sub(phrase, 1, i)
					task.wait(0.026)
				end
				task.wait(1.8)
				for i = #phrase, 1, -1 do
					if not HeroType.Parent then break end
					HeroType.Text = string.sub(phrase, 1, i)
					task.wait(0.012)
				end
				task.wait(0.2)
			end
		end
	end)

	local c = section(PageWelcome, "USER PROFILE")
	local PF = Instance.new("Frame")
	PF.Size = UDim2.new(1, 0, 0, 80)
	PF.BackgroundColor3 = THEME.element
	PF.BackgroundTransparency = 0.35
	PF.BorderSizePixel = 0
	PF.ZIndex = 9
	PF.Parent = c
	corner(PF, 8)

	local Avatar = Instance.new("ImageLabel")
	Avatar.Size = UDim2.fromOffset(56, 56)
	Avatar.Position = UDim2.new(0, 10, 0.5, -28)
	Avatar.BackgroundColor3 = Color3.fromRGB(30, 36, 68)
	Avatar.ZIndex = 10
	Avatar.Parent = PF
	corner(Avatar, 28)
	stroke(Avatar, THEME.accent, 1.4, 0.3)
	pcall(function()
		local content, isReady = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		if isReady then Avatar.Image = content end
	end)

	local name = Instance.new("TextLabel")
	name.Size = UDim2.new(1, -80, 0, 20)
	name.Position = UDim2.new(0, 76, 0, 12)
	name.BackgroundTransparency = 1
	name.Text = "Welcome, " .. (player.DisplayName or player.Name) .. "!"
	name.TextColor3 = THEME.gold
	name.Font = Enum.Font.GothamBold
	name.TextSize = 13
	name.TextXAlignment = Enum.TextXAlignment.Left
	name.ZIndex = 10
	name.Parent = PF

	local uname = Instance.new("TextLabel")
	uname.Size = UDim2.new(1, -80, 0, 16)
	uname.Position = UDim2.new(0, 76, 0, 34)
	uname.BackgroundTransparency = 1
	uname.Text = "@" .. player.Name
	uname.TextColor3 = THEME.dim
	uname.Font = Enum.Font.Gotham
	uname.TextSize = 11
	uname.TextXAlignment = Enum.TextXAlignment.Left
	uname.ZIndex = 10
	uname.Parent = PF

	local uid = Instance.new("TextLabel")
	uid.Size = UDim2.new(1, -80, 0, 14)
	uid.Position = UDim2.new(0, 76, 0, 54)
	uid.BackgroundTransparency = 1
	uid.Text = "Device: " .. (isMobile and "Mobile Touch" or "PC Keyboard") .. " · ID: " .. tostring(player.UserId)
	uid.TextColor3 = THEME.dim
	uid.Font = Enum.Font.Code
	uid.TextSize = 10
	uid.TextXAlignment = Enum.TextXAlignment.Left
	uid.ZIndex = 10
	uid.Parent = PF

	local links = section(PageWelcome, "COMMUNITY")
	addButton(links, "JOIN DISCORD FOR MORE SCRIPTS", function()
		pcall(function() if setclipboard then setclipboard(DISCORD) end end)
	end, Color3.fromRGB(48, 68, 160))
	addButton(links, "SUBSCRIBE ON YOUTUBE", function()
		pcall(function() if setclipboard then setclipboard(YOUTUBE) end end)
	end, Color3.fromRGB(160, 42, 54))
end



-- MAIN PAGE (Ouroboros layout)
do
	tabMessages(PageMain, {
		"<> Script made by KHUB · Kyiel Pambid",
		"<> Same Ouroboros farm logic: Auto Train + Train Zone, Auto Throw.",
		"$ Progress: buy stones, hatch egg, rebirth, equip best pet.",
		"> Use ↑↓ on section headers to collapse groups.",
	})
	local farm = collapsibleSection(PageMain, "FARM")
	addToggle(farm, "Auto Train", false, function(v)
		setFeature("Train", v, 0.75, function()
			ensureTrainStand()
		end)
		notify("Auto Train", v and "ON" or "OFF", true)
	end)
	addDropdown(farm, "Train Zone", ZoneLabels, false, function(label)
		local id = LabelToId[label]
		if type(id) == "string" then
			S.TrainZoneId = id
		end
		notify("Train Zone", tostring(label), true)
	end)
	addToggle(farm, "Auto Throw", false, function(v)
		setFeature("Throw", v, 0.2, throwTick)
		notify("Auto Throw", v and "ON" or "OFF", true)
	end)

	local prog = collapsibleSection(PageMain, "PROGRESS")
	addToggle(prog, "Auto Buy Affordable Stones", false, function(v)
		setFeature("BuyStones", v, 1.5, buyTick)
		notify("Auto Buy Stones", v and "ON" or "OFF", true)
	end)
	addToggle(prog, "Auto Hatch Selected Egg", false, function(v)
		setFeature("HatchEgg", v, 1.25, hatchTick)
		notify("Auto Hatch", v and "ON" or "OFF", true)
	end)
	addDropdown(prog, "Egg", EggList, false, function(id)
		if type(id) == "string" and id ~= "" then
			S.HatchEggId = id
		end
		notify("Egg", tostring(id), true)
	end)
	addToggle(prog, "Auto Rebirth", false, function(v)
		setFeature("Rebirth", v, 2, rebirthTick)
		notify("Auto Rebirth", v and "ON" or "OFF", true)
	end)
	addToggle(prog, "Auto Equip Best Pet", false, function(v)
		setFeature("EquipBestPet", v, 3, equipPetTick)
		notify("Equip Best Pet", v and "ON" or "OFF", true)
	end)
end

-- PLAYER PAGE
do
	tabMessages(PagePlayer, {
		"<> Script made by KHUB · Kyiel Pambid",
		"<> WalkSpeed + amount slider, Infinite Jump, NoClip, Instant Prompt.",
		"$ Fly + Fly Speed slider (WASD / Space / LeftCtrl).",
		"> Same Player layout as Ouroboros.",
	})
	local mov = collapsibleSection(PagePlayer, "MOVEMENT")
	addToggle(mov, "WalkSpeed", false, function(v)
		setWalkEnabled(v)
		notify("WalkSpeed", v and "ON" or "OFF", true)
	end)
	addSlider(mov, "WalkSpeed Amount", 16, 250, 32, function(v)
		S.WalkSpeed = v
		if S.WalkSpeedEnabled then
			local hum = getHum()
			if hum then hum.WalkSpeed = v end
		end
	end)
	addToggle(mov, "Infinite Jump", false, function(v)
		setInfJump(v)
		notify("Inf Jump", v and "ON" or "OFF", true)
	end)
	addToggle(mov, "NoClip", false, function(v)
		setNoClip(v)
		notify("NoClip", v and "ON" or "OFF", true)
	end)
	addToggle(mov, "Instant ProximityPrompt", false, function(v)
		setInstantPP(v)
		notify("Instant Prompt", v and "ON" or "OFF", true)
	end)

	local fly = collapsibleSection(PagePlayer, "FLY")
	addToggle(fly, "Fly", false, function(v)
		setFly(v)
		notify("Fly", v and "ON" or "OFF", true)
	end)
	addSlider(fly, "Fly Speed", 10, 400, 60, function(v)
		S.FlySpeed = v
	end)
end

-- SETTINGS PAGE
do
	tabMessages(PageSettings, {
		"<> Script made by KHUB · Kyiel Pambid",
		"<> UI-only shell for +1 Stone Skipping.",
		"$ Tap floating Orb or press RightShift to toggle anytime.",
		"> Config save keeps keybinds for later feature wiring.",
	})
	local cfgName = "default"
	
	local util = collapsibleSection(PageSettings, "UTILITIES")
	addToggle(util, "Anti-AFK", true, function(v) setAntiAfk(v) end)
	addToggle(util, "No Gameplay Paused", true, function(v) S.NoGameplayPaused = v end)
	addToggle(util, "Auto Reconnect on Kick", false, function(v) setAutoReconnect(v) end)
	addToggle(util, "Disable 3D Rendering", false, function(v) setDisable3D(v) end)
	addToggle(util, "FPS Boost", false, function(v) setFpsBoost(v) end)

	local cfg = section(PageSettings, "CONFIG MANAGER")
	addTextbox(cfg, "Config Name", "default", function(t)
		cfgName = (t and t:gsub("%s+", "") ~= "") and t:gsub("%s+", "") or "default"
	end)
	addButton(cfg, "Save Config", function()
		pcall(function()
			if isfolder and not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
			if writefile then
				writefile(CONFIG_FOLDER .. "/" .. cfgName .. ".json", HttpService:JSONEncode({
					Keybinds = { ToggleUI = keyName(Keybinds.ToggleUI) },
					savedAt = os.date("%c"),
				}))
			end
		end)
		notify("Config Saved", cfgName .. ".json stored", true)
	end, Color3.fromRGB(30, 80, 55))
	addButton(cfg, "Load Config", function()
		local ok, raw = pcall(function() return readfile(CONFIG_FOLDER .. "/" .. cfgName .. ".json") end)
		if ok and raw then
			local ok2, d = pcall(function() return HttpService:JSONDecode(raw) end)
			if ok2 and type(d) == "table" and type(d.Keybinds) == "table" then
				if d.Keybinds.ToggleUI then Keybinds.ToggleUI = keyFromName(d.Keybinds.ToggleUI) end
				notify("Config Loaded", cfgName .. ".json", true)
			else notify("Config Error", "Invalid data format", false) end
		else notify("Config Error", "File not found", false) end
	end)
	addButton(cfg, "Delete Config", function()
		pcall(function() delfile(CONFIG_FOLDER .. "/" .. cfgName .. ".json") end)
		notify("Config", "Deleted: " .. cfgName, true)
	end)

	local listeningBind = nil
	local bindLabels = {}
	local function addKeybindRow(parent, label, bindKey)
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, 0, 0, 34)
		row.BackgroundColor3 = THEME.element
		row.BackgroundTransparency = 0.35
		row.BorderSizePixel = 0
		row.ZIndex = 9
		row.Parent = parent
		corner(row, 6)
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1, -114, 1, 0)
		lbl.Position = UDim2.new(0, 8, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text = label
		lbl.TextColor3 = THEME.text
		lbl.Font = Enum.Font.GothamMedium
		lbl.TextSize = 12
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.ZIndex = 10
		lbl.Parent = row
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 98, 0, 24)
		btn.Position = UDim2.new(1, -104, 0.5, -12)
		btn.BackgroundColor3 = Color3.fromRGB(30, 36, 62)
		btn.BackgroundTransparency = 0.15
		btn.Text = keyName(Keybinds[bindKey])
		btn.TextColor3 = THEME.accent
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 11
		btn.ZIndex = 11
		btn.Parent = row
		corner(btn, 5)
		stroke(btn, THEME.accent2, 1, 0.5)
		bindLabels[bindKey] = btn
		btn.MouseButton1Click:Connect(function()
			createRipple(btn)
			if listeningBind then return end
			listeningBind = bindKey
			btn.Text = "..."
			btn.TextColor3 = THEME.gold
			notify("Keybind", "Press key (Esc to clear)", true)
			local conn
			conn = UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
				local kc = input.KeyCode
				if kc == Enum.KeyCode.Escape then
					Keybinds[bindKey] = Enum.KeyCode.Unknown
					btn.Text = "None"
					btn.TextColor3 = THEME.dim
					notify("Keybind", label .. " cleared", false)
				else
					Keybinds[bindKey] = kc
					btn.Text = keyName(kc)
					btn.TextColor3 = THEME.accent
					notify("Keybind", label .. " → " .. keyName(kc), true)
				end
				listeningBind = nil
				if conn then conn:Disconnect() end
			end)
		end)
		return row
	end
	local kb = section(PageSettings, "CONTROLS & KEYBINDS")
	addLabel(kb, "PC: Click button then press key. Esc clears keybind.", 11, THEME.dim)
	addKeybindRow(kb, "Toggle UI", "ToggleUI")
	addButton(kb, "Reset Keybinds to Default", function()
		Keybinds.ToggleUI = Enum.KeyCode.RightShift
		for k, btn in pairs(bindLabels) do
			btn.Text = keyName(Keybinds[k])
			btn.TextColor3 = Keybinds[k] == Enum.KeyCode.Unknown and THEME.dim or THEME.accent
		end
		notify("Keybinds", "Reset to RightShift", true)
	end, Color3.fromRGB(55, 42, 32))
end


-- SERVER PAGE (classic links)
do
	tabMessages(PageServer, {
		"<> Script made by KHUB · Kyiel Pambid",
		"<> Community links and session tools.",
		"$ Copy Discord / YouTube anytime.",
		"> Rejoin if the server lags.",
	})
	local links = collapsibleSection(PageServer, "LINKS")
	addButton(links, "Copy Discord Invite", function()
		pcall(function() if setclipboard then setclipboard(DISCORD) end end)
		notify("Copied", "Discord", true)
	end, Color3.fromRGB(48, 68, 160))
	addButton(links, "Copy YouTube Channel", function()
		pcall(function() if setclipboard then setclipboard(YOUTUBE) end end)
		notify("Copied", "YouTube", true)
	end, Color3.fromRGB(160, 42, 54))

	local session = collapsibleSection(PageServer, "SESSION")
	local playersLbl = addLabel(session, "Players · 0/0", 12, THEME.dim)
	local jobLbl = addLabel(session, "Job · ...", 11, THEME.dim)
	task.spawn(function()
		while playersLbl.Parent do
			pcall(function()
				playersLbl.Text = string.format("Players · %d/%d", #Players:GetPlayers(), Players.MaxPlayers)
				jobLbl.Text = "Job · " .. string.sub(tostring(game.JobId), 1, 20)
			end)
			task.wait(1.5)
		end
	end)
	addButton(session, "Rejoin Place", function()
		pcall(function() TeleportService:Teleport(game.PlaceId, player) end)
	end)
	addButton(session, "Copy Job ID", function()
		pcall(function() if setclipboard then setclipboard(tostring(game.JobId)) end end)
		notify("Copied", "Job ID", true)
	end)
end


-- FLOATING ORB (MOBILE & MINIMIZE TOGGLE)
local OrbWrap = Instance.new("Frame")
OrbWrap.Size = UDim2.new(0, 52, 0, 52)
OrbWrap.Position = UDim2.new(0, 16, 0.5, -26)
OrbWrap.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
OrbWrap.BorderSizePixel = 0
OrbWrap.ClipsDescendants = false
OrbWrap.Visible = false
OrbWrap.ZIndex = 50
OrbWrap.Parent = ScreenGui
corner(OrbWrap, 26)

local Orb = Instance.new("ImageButton")
Orb.Size = UDim2.new(1, 0, 1, 0)
Orb.BackgroundTransparency = 1
Orb.Image = LOGO_ID
Orb.ScaleType = Enum.ScaleType.Fit
Orb.ZIndex = 52
Orb.Parent = OrbWrap
corner(Orb, 26)
attachMegaLogoAura(OrbWrap, Orb, true)

-- SMOOTH SPRING OPEN / CLOSE ANIMATIONS
local isOpening = false
local function setVisible(on)
	if isOpening then return end
	isOpening = true
	if on then
		Main.Visible = true
		Main.Size = UDim2.new(0, WIN_W * 0.85, 0, WIN_H * 0.85)
		Main.Position = UDim2.new(0.5, -WIN_W * 0.425, 0.5, -WIN_H * 0.425)
		TweenService:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, WIN_W, 0, WIN_H),
			Position = UDim2.new(0.5, -WIN_W / 2, 0.5, -WIN_H / 2),
		}):Play()
		OrbWrap.Visible = false
	else
		local tw = TweenService:Create(Main, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(0, WIN_W * 0.8, 0, WIN_H * 0.8),
			Position = UDim2.new(0.5, -WIN_W * 0.4, 0.5, -WIN_H * 0.4),
		})
		tw:Play()
		tw.Completed:Wait()
		Main.Visible = false
		OrbWrap.Visible = true
	end
	isOpening = false
end

CloseBtn.MouseButton1Click:Connect(function()
	createRipple(CloseBtn)
	setVisible(false)
end)
MinBtn.MouseButton1Click:Connect(function()
	createRipple(MinBtn)
	setVisible(false)
end)
Orb.MouseButton1Click:Connect(function()
	createRipple(Orb)
	setVisible(true)
end)

-- DRAGGABLE ORB
do
	local dragging, dragStart, startPos = false, nil, nil
	Orb.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = OrbWrap.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			OrbWrap.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- KEYBOARD TOGGLE
UserInputService.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.UserInputType ~= Enum.UserInputType.Keyboard then return end
	local kc = i.KeyCode
	if (Keybinds.ToggleUI ~= Enum.KeyCode.Unknown and kc == Keybinds.ToggleUI)
		or kc == Enum.KeyCode.RightControl
		or kc == Enum.KeyCode.K then
		setVisible(not Main.Visible)
	end
end)

local function playKHUBIntro()
	local _I,_U,_C,_TI,_Us,_tw,_ts,_UD,_mc,_mf,_ma,_mh,_mx,_mn,_ti,_tr,_EGB,_ESQ,_ESB,_EDO,_EDI,_BgT,_BgC,_BSP,_TC3,_ZI,_TSz=Instance.new,UDim2.new,Color3.fromRGB,TweenInfo.new,UDim2.fromScale,task.wait,task.spawn,UDim.new,math.clamp,math.floor,math.abs,math.huge,math.max,math.min,table.insert,table.remove,Enum.Font.GothamBold,Enum.EasingStyle.Quad,Enum.EasingStyle.Back,Enum.EasingDirection.Out,Enum.EasingDirection.InOut,"BackgroundTransparency","BackgroundColor3","BorderSizePixel","TextColor3","ZIndex","TextSize"

	local Players=game:GetService("Players")
	local TweenService=game:GetService("TweenService")
	local Lighting=game:GetService("Lighting")
	local RunService=game:GetService("RunService")
	local TextService=game:GetService("TextService")
	local UserInputService=game:GetService("UserInputService")

	local player=Players.LocalPlayer
	local playerGui=player:WaitForChild("PlayerGui")

	pcall(function()
		local old=playerGui:FindFirstChild("KHUBIntro")
		if old then old:Destroy() end
	end)

	local screenGui=_I("ScreenGui")
	screenGui.Name="KHUBIntro"
	screenGui.IgnoreGuiInset=true
	screenGui.ResetOnSpawn=false
	screenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder=2000
	screenGui.Parent=playerGui

	local introSound=nil
	local blur=nil
	local skipped=false
	local skipConn=nil
	local finished=false

	local SOUND_ID=(_G and _G.__KHUBIntroSoundId and tonumber(_G.__KHUBIntroSoundId)) or 120267378058133
	local SKIP_SECONDS=10

	local MAIN_COLOR=_C(157,78,221)
	local GLOW_COLOR=_C(110,40,180)
	local LIGHT_COLOR=_C(210,140,255)
	local ACCENT_COLOR=_C(247,215,148)
	local WHITE=_C(255,255,255)
	local BLACK=_C(0,0,0)

	local function cleanupAll()
		if finished then return end
		finished=true
		skipped=true
		pcall(function()
			if introSound then introSound:Stop(); introSound:Destroy(); introSound=nil end
		end)
		pcall(function()
			if blur then blur:Destroy(); blur=nil end
		end)
		pcall(function()
			if screenGui then screenGui:Destroy(); screenGui=nil end
		end)
		pcall(function()
			if skipConn then skipConn:Disconnect(); skipConn=nil end
		end)
		-- kill any leftover KHUBIntro
		pcall(function()
			local pg=player:FindFirstChild("PlayerGui")
			if pg then
				local o=pg:FindFirstChild("KHUBIntro")
				if o then o:Destroy() end
			end
		end)
	end

	local function requestSkip()
		if skipped then return end
		skipped=true
		cleanupAll()
	end

	local function waitOrSkip(sec)
		local t0=os.clock()
		while not skipped and (os.clock()-t0)<sec do
			task.wait(0.03)
		end
		return skipped
	end

	-- hard safety: never let intro hang more than 18s
	task.delay(10, function()
		if not finished then
			warn("[KHUB] Intro timeout 10s — force cleanup")
			cleanupAll()
		end
	end)

	-- SKIP BUTTON
	do
		local skipBtn=_I("TextButton")
		skipBtn.Name="SkipBtn"
		skipBtn.Size=_U(0,100,0,36)
		skipBtn.Position=_U(1,-118,0,20)
		skipBtn.BackgroundColor3=_C(20,16,32)
		skipBtn.BackgroundTransparency=0.1
		skipBtn.BorderSizePixel=0
		skipBtn.Text="SKIP  ›"
		skipBtn.Font=Enum.Font.GothamBold
		skipBtn.TextSize=14
		skipBtn.TextColor3=_C(245,247,255)
		skipBtn.ZIndex=100
		skipBtn.Parent=screenGui
		local sc=_I("UICorner")
		sc.CornerRadius=_UD(0,8)
		sc.Parent=skipBtn
		local ss=_I("UIStroke")
		ss.Color=MAIN_COLOR
		ss.Thickness=1.5
		ss.Transparency=0.2
		ss.Parent=skipBtn
		skipBtn.MouseButton1Click:Connect(function()
			requestSkip()
		end)
		skipConn=UserInputService.InputBegan:Connect(function(input,gp)
			if gp then return end
			if input.KeyCode==Enum.KeyCode.Space or input.KeyCode==Enum.KeyCode.Return then
				requestSkip()
			end
		end)
	end

	blur=_I("BlurEffect")
	blur.Size=0
	blur.Parent=Lighting

	local overlay=_I("Frame")
	overlay.Size=_Us(1,1)
	overlay[_BgC]=_C(0,0,0)
	overlay[_BgT]=0.3
	overlay[_BSP]=0
	overlay[_ZI]=1
	overlay.Parent=screenGui

	local darkOverlay=_I("Frame")
	darkOverlay.Size=_Us(1,1)
	darkOverlay[_BgC]=_C(8,3,18)
	darkOverlay[_BgT]=0.5
	darkOverlay[_BSP]=0
	darkOverlay[_ZI]=1
	darkOverlay.Parent=screenGui

	local vignette=_I("ImageLabel")
	vignette.Size=_Us(1,1)
	vignette[_BgT]=1
	vignette.Image="rbxassetid://195611797"
	vignette.ImageColor3=BLACK
	vignette.ImageTransparency=0.35
	vignette[_ZI]=2
	vignette.Parent=screenGui

	local container=_I("Frame")
	container.Size=_U(0,900,0,200)
	container.AnchorPoint=Vector2.new(0.5,0.5)
	container.Position=_U(0.5,0,0.5,0)
	container[_BgT]=1
	container[_BSP]=0
	container.ClipsDescendants=false
	container[_ZI]=5
	container.Parent=screenGui

	local particleContainer=_I("Frame")
	particleContainer.Size=_Us(1,1)
	particleContainer[_BgT]=1
	particleContainer[_ZI]=8
	particleContainer.Parent=screenGui

	local function createParticle()
		if skipped or not screenGui then return end
		local p=_I("Frame")
		p.Size=_U(0,math.random(3,6),0,math.random(3,6))
		p.Position=_U(0.5+math.random(-30,30)/100,0,0.5+math.random(-20,20)/100,0)
		p[_BgC]=math.random()<0.5 and MAIN_COLOR or LIGHT_COLOR
		p[_BgT]=0
		p[_BSP]=0
		p[_ZI]=8
		p.Parent=particleContainer
		local _corner=_I("UICorner")
		_corner.CornerRadius=_UD(1,0)
		_corner.Parent=p
		local floatDur=1.5+math.random()*1.5
		local tween=TweenService:Create(p,_TI(floatDur,Enum.EasingStyle.Sine,Enum.EasingDirection.Out),{
			Position=_U(0.5+math.random(-40,40)/100,0,0.5+math.random(-40,20)/100,0),
			BackgroundTransparency=1,
			Size=_U(0,0,0,0)
		})
		tween:Play()
		tween.Completed:Connect(function() p:Destroy() end)
	end

	local leftLabel=_I("TextLabel")
	leftLabel.Size=_U(0,550,1,0)
	leftLabel.AnchorPoint=Vector2.new(1,0.5)
	leftLabel.Position=_U(0.5,-12,0.5,0)
	leftLabel[_BgT]=1
	leftLabel.Text="KHUB"
	leftLabel[_TC3]=WHITE
	leftLabel.TextStrokeColor3=BLACK
	leftLabel.TextStrokeTransparency=0
	leftLabel.Font=Enum.Font.GothamBlack
	leftLabel[_TSz]=92
	leftLabel.TextXAlignment=Enum.TextXAlignment.Right
	leftLabel.TextTransparency=1
	leftLabel[_ZI]=5
	leftLabel.Visible=true
	leftLabel.Parent=container

	local rightLabel=_I("TextLabel")
	rightLabel.Size=_U(0,450,1,0)
	rightLabel.AnchorPoint=Vector2.new(0,0.5)
	rightLabel.Position=_U(0.5,-12,0.5,0)
	rightLabel[_BgT]=1
	rightLabel.Text="PANEL"
	rightLabel[_TC3]=MAIN_COLOR
	rightLabel.TextStrokeColor3=BLACK
	rightLabel.TextStrokeTransparency=0
	rightLabel.Font=Enum.Font.GothamBlack
	rightLabel[_TSz]=92
	rightLabel.TextXAlignment=Enum.TextXAlignment.Left
	rightLabel.TextTransparency=1
	rightLabel[_ZI]=5
	rightLabel.Visible=true
	rightLabel.Parent=container

	local mainLabel=_I("TextLabel")
	mainLabel.Size=_U(1,0,1,0)
	mainLabel.AnchorPoint=Vector2.new(0.5,0.5)
	mainLabel.Position=_U(0.5,0,0.5,0)
	mainLabel[_BgT]=1
	mainLabel.Text="KHUB PANEL"
	mainLabel[_TC3]=WHITE
	mainLabel.TextStrokeColor3=BLACK
	mainLabel.TextStrokeTransparency=0
	mainLabel.Font=Enum.Font.GothamBlack
	mainLabel[_TSz]=88
	mainLabel.TextXAlignment=Enum.TextXAlignment.Center
	mainLabel.TextTransparency=1
	mainLabel[_ZI]=5
	mainLabel.Parent=container

	local lightBeam=_I("Frame")
	lightBeam.Size=_U(0,0,1.1,0)
	lightBeam.AnchorPoint=Vector2.new(0,0.5)
	lightBeam.Position=_U(0,-20,0.5,0)
	lightBeam[_BgC]=MAIN_COLOR
	lightBeam[_BgT]=0.5
	lightBeam[_BSP]=0
	lightBeam[_ZI]=6
	lightBeam.Parent=container

	local beamGlow=_I("Frame")
	beamGlow.Size=_U(0,0,1.3,0)
	beamGlow.AnchorPoint=Vector2.new(0,0.5)
	beamGlow.Position=_U(0,-20,0.5,0)
	beamGlow[_BgC]=GLOW_COLOR
	beamGlow[_BgT]=0.7
	beamGlow[_BSP]=0
	beamGlow[_ZI]=5
	beamGlow.Parent=container

	local beamSparkles=_I("Frame")
	beamSparkles.Size=_U(0,0,1,0)
	beamSparkles.AnchorPoint=Vector2.new(0,0.5)
	beamSparkles.Position=_U(0,-20,0.5,0)
	beamSparkles[_BgC]=WHITE
	beamSparkles[_BgT]=0.8
	beamSparkles[_BSP]=0
	beamSparkles[_ZI]=7
	beamSparkles.Parent=container

	local subLabel=_I("TextLabel")
	subLabel.Size=_U(1,0,0,45)
	subLabel.AnchorPoint=Vector2.new(0.5,0)
	subLabel.Position=_U(0.5,0,0.5,85)
	subLabel[_BgT]=1
	subLabel.Text="SCRIPT HUB"
	subLabel[_TC3]=MAIN_COLOR
	subLabel.Font=Enum.Font.GothamBold
	subLabel[_TSz]=16
	subLabel.TextXAlignment=Enum.TextXAlignment.Center
	subLabel.TextTransparency=1
	subLabel[_ZI]=5
	subLabel.Parent=screenGui

	local subLabel2=_I("TextLabel")
	subLabel2.Size=_U(1,0,0,28)
	subLabel2.AnchorPoint=Vector2.new(0.5,0)
	subLabel2.Position=_U(0.5,0,0.5,120)
	subLabel2[_BgT]=1
	subLabel2.Text="BY KYIEL PAMBID"
	subLabel2[_TC3]=ACCENT_COLOR
	subLabel2.Font=Enum.Font.GothamBold
	subLabel2[_TSz]=13
	subLabel2.TextXAlignment=Enum.TextXAlignment.Center
	subLabel2.TextTransparency=1
	subLabel2[_ZI]=5
	subLabel2.Parent=screenGui

	local accentBar=_I("Frame")
	accentBar.Size=_U(0,0,0,3)
	accentBar.AnchorPoint=Vector2.new(0.5,0)
	accentBar.Position=_U(0.5,0,0.5,78)
	accentBar[_BgC]=MAIN_COLOR
	accentBar[_BgT]=0
	accentBar[_BSP]=0
	accentBar[_ZI]=5
	accentBar.Parent=screenGui
	local _accentCorner=_I("UICorner")
	_accentCorner.CornerRadius=_UD(0,3)
	_accentCorner.Parent=accentBar

	local flashFrame=_I("Frame")
	flashFrame.Size=_Us(1,1)
	flashFrame[_BgC]=WHITE
	flashFrame[_BgT]=1
	flashFrame[_BSP]=0
	flashFrame[_ZI]=10
	flashFrame.Parent=screenGui

	local glitchContainer=_I("Frame")
	glitchContainer.Size=_U(1,0,1,0)
	glitchContainer[_BgT]=1
	glitchContainer[_ZI]=6
	glitchContainer.Parent=screenGui

	local dripContainer=_I("Frame")
	dripContainer.Size=_U(1,0,1,0)
	dripContainer[_BgT]=1
	dripContainer[_ZI]=7
	dripContainer.Parent=screenGui

	local function doFlash(color,alpha,duration)
		if skipped or not screenGui then return end
		flashFrame[_BgC]=color or WHITE
		flashFrame[_BgT]=1-(alpha or 0.85)
		task.delay(duration or 0.06,function()
			if skipped or not screenGui then return end
			pcall(function()
				TweenService:Create(flashFrame,_TI(0.1,_ESQ),{BackgroundTransparency=1}):Play()
			end)
		end)
	end

	local function runLightBeam()
		if skipped or not screenGui then return end
		lightBeam.Size=_U(0,50,1.1,0)
		beamGlow.Size=_U(0,75,1.3,0)
		beamSparkles.Size=_U(0,50,1,0)
		lightBeam[_BgT]=0.35
		beamGlow[_BgT]=0.55
		beamSparkles[_BgT]=0.75
		local beamTween=TweenService:Create(lightBeam,_TI(0.8,_ESQ,_EDI),{Position=_U(1,20,0.5,0)})
		beamTween:Play()
		TweenService:Create(beamGlow,_TI(0.8,_ESQ,_EDI),{Position=_U(1,20,0.5,0)}):Play()
		TweenService:Create(beamSparkles,_TI(0.8,_ESQ,_EDI),{Position=_U(1,20,0.5,0)}):Play()
		local pulseCount=0
		local pulseConnection
		pulseConnection=RunService.Heartbeat:Connect(function()
			if skipped then
				if pulseConnection then pulseConnection:Disconnect() end
				return
			end
			pulseCount=pulseCount+1
			if pulseCount%3==0 then
				local p=0.3+math.sin(pulseCount*0.5)*0.15
				lightBeam[_BgT]=0.3-(p*0.2)
				beamGlow[_BgT]=0.5-(p*0.1)
				beamSparkles[_BgT]=0.7-(p*0.15)
			end
		end)
		-- don't block forever
		local t0=os.clock()
		while beamTween.PlaybackState==Enum.PlaybackState.Playing and not skipped and (os.clock()-t0)<1.2 do
			task.wait(0.03)
		end
		if pulseConnection then pulseConnection:Disconnect() end
		if skipped or not screenGui then return end
		pcall(function()
			TweenService:Create(lightBeam,_TI(0.25),{BackgroundTransparency=1,Size=_U(0,0,1.1,0)}):Play()
			TweenService:Create(beamGlow,_TI(0.25),{BackgroundTransparency=1,Size=_U(0,0,1.3,0)}):Play()
			TweenService:Create(beamSparkles,_TI(0.25),{BackgroundTransparency=1,Size=_U(0,0,1,0)}):Play()
		end)
	end

	local glitchChars={"!","#","%","/","[","]","░","▒","▓","—","=","*","^","~","¦","¤"}

	local function glitchText(lbl,original)
		if skipped or not screenGui then return end
		for i=1,4 do
			if skipped then return end
			local s=""
			for c in original:gmatch(".") do
				s=s..(math.random()<0.35 and glitchChars[math.random(#glitchChars)] or c)
			end
			lbl.Text=s
			_tw(0.03)
		end
		if not skipped then lbl.Text=original end
	end

	local function addGlitchBar()
		if skipped or not screenGui then return end
		local bar=_I("Frame")
		bar.Size=_U(1,0,0,math.random(2,12))
		bar.Position=_U(0,0,math.random(10,90)/100,0)
		bar[_BgC]=MAIN_COLOR
		bar[_BgT]=math.random(45,70)/100
		bar[_BSP]=0
		bar[_ZI]=6
		bar.Parent=glitchContainer
		task.delay(0.1,function()
			if bar and bar.Parent then
				TweenService:Create(bar,_TI(0.1),{BackgroundTransparency=1}):Play()
				task.delay(0.1,function() bar:Destroy() end)
			end
		end)
	end

	local function shakeScreen(intensity,duration)
		if skipped or not screenGui then return end
		local startTime=tick()
		local steps=math.ceil(duration/0.05)
		for _=1,steps do
			if skipped then return end
			local elapsed=tick()-startTime
			local cur=intensity*(1-(elapsed/duration))
			if cur<1 then cur=1 end
			local ox=math.random(-_mf(cur),_mf(cur))
			local oy=math.random(-_mf(cur*0.5),_mf(cur*0.5))
			leftLabel.Position=_U(0.5,-12+ox,0.5,oy)
			rightLabel.Position=_U(0.5,12+ox,0.5,oy)
			_tw(0.05)
		end
		if skipped or not screenGui then return end
		pcall(function()
			TweenService:Create(leftLabel,_TI(0.05),{Position=_U(0.5,-12,0.5,0)}):Play()
			TweenService:Create(rightLabel,_TI(0.05),{Position=_U(0.5,12,0.5,0)}):Play()
		end)
	end

	local function setupAudio()
		introSound=_I("Sound")
		introSound.SoundId="rbxassetid://"..SOUND_ID
		introSound.Volume=0.7
		introSound.PlayOnRemove=false
		introSound.Looped=false
		introSound.Parent=screenGui
		-- don't block forever on Loaded
		local loaded=false
		pcall(function()
			if introSound.IsLoaded then
				loaded=true
			else
				local conn
				conn=introSound.Loaded:Connect(function()
					loaded=true
					if conn then conn:Disconnect() end
				end)
				local t0=os.clock()
				while not loaded and not skipped and (os.clock()-t0)<3 do
					task.wait(0.05)
				end
				if conn then pcall(function() conn:Disconnect() end) end
			end
		end)
		if skipped then return end
		pcall(function()
			introSound:Play()
			introSound.TimePosition=SKIP_SECONDS
		end)
		return introSound
	end

	local function fadeOutAudio(duration)
		if not introSound then return end
		local startVolume=introSound.Volume
		local steps=10
		for i=1,steps do
			if skipped or not introSound then break end
			introSound.Volume=startVolume*(1-(i/steps))
			_tw(duration/steps)
		end
		if introSound then
			introSound.Volume=0
			pcall(function() introSound:Stop() end)
		end
	end

	local function stopAudio()
		if introSound then
			pcall(function() introSound:Stop() end)
			pcall(function() introSound:Destroy() end)
			introSound=nil
		end
	end

	local activeDrips=0

	local function createDrip(startX,startY,width,height,duration,delay)
		if skipped then return end
		_tw(delay)
		if skipped or not screenGui then return end
		activeDrips=activeDrips+1
		local drip=_I("Frame")
		drip.Size=_U(0,width,0,height)
		drip.Position=_U(0.5,startX,0.5,startY)
		drip[_BgC]=MAIN_COLOR
		drip[_BgT]=0.25
		drip[_BSP]=0
		drip[_ZI]=7
		drip.Parent=dripContainer
		local _dripCorner=_I("UICorner")
		_dripCorner.CornerRadius=_UD(0,4)
		_dripCorner.Parent=drip
		local stretch=TweenService:Create(drip,_TI(duration*0.35),{Size=_U(0,width,0,height+22),BackgroundTransparency=0.1})
		stretch:Play()
		_tw(duration*0.35)
		if skipped then
			pcall(function() drip:Destroy() end)
			activeDrips=math.max(0,activeDrips-1)
			return
		end
		local fall=TweenService:Create(drip,_TI(duration*0.65,_ESQ,Enum.EasingDirection.In),{
			Position=_U(0.5,startX+math.random(-3,3),0.5,startY+90),
			BackgroundTransparency=1
		})
		fall:Play()
		fall.Completed:Connect(function()
			drip:Destroy()
			activeDrips=math.max(0,activeDrips-1)
		end)
	end

	local function startDripping()
		if skipped or not screenGui then return end
		local fullText="KHUB"
		local font=Enum.Font.GothamBlack
		local textSize=92
		local textBoundsFull=TextService:GetTextSize(fullText,textSize,font,Vector2.new(_mh,_mh))
		local textHeight=textBoundsFull.Y
		local delayCounter=0
		local drips={}
		for i=1,#fullText do
			local char=fullText:sub(i,i)
			local charBounds=TextService:GetTextSize(char,textSize,font,Vector2.new(_mh,_mh))
			local charWidth=charBounds.X
			local precedingWidth=0
			if i>1 then
				precedingWidth=TextService:GetTextSize(fullText:sub(1,i-1),textSize,font,Vector2.new(_mh,_mh)).X
			end
			local totalTextWidth=textBoundsFull.X
			local charCenterX=-totalTextWidth/2+precedingWidth+charWidth/2
			local startY=textHeight/2+3
			local dripWidth=_mc(_mf(charWidth*0.35),3,7)
			local dripHeight=math.random(4,7)
			local dur=0.5+math.random()*0.2
			local del=delayCounter*0.07
			_ti(drips,{
				startX=charCenterX+math.random(-2,2),
				startY=startY+math.random(0,4),
				width=dripWidth,
				height=dripHeight,
				duration=dur,
				delay=del
			})
			delayCounter=delayCounter+1
		end
		for _,d in ipairs(drips) do
			if skipped then break end
			createDrip(d.startX,d.startY,d.width,d.height,d.duration,d.delay)
		end
	end

	-- MAIN SEQUENCE
	setupAudio()
	if skipped then cleanupAll(); return end

	leftLabel.Position=_U(-0.9,0,-0.6,0)
	rightLabel.Position=_U(1.9,0,1.6,0)
	leftLabel.Rotation=-30
	rightLabel.Rotation=30

	pcall(function()
		TweenService:Create(blur,_TI(0.7),{Size=18}):Play()
		TweenService:Create(overlay,_TI(0.7),{BackgroundTransparency=0.2}):Play()
		TweenService:Create(darkOverlay,_TI(0.7),{BackgroundTransparency=0.4}):Play()
	end)

	if waitOrSkip(0.35) then cleanupAll(); return end

	TweenService:Create(leftLabel,_TI(0.45),{TextTransparency=0}):Play()
	TweenService:Create(rightLabel,_TI(0.45),{TextTransparency=0}):Play()
	TweenService:Create(leftLabel,_TI(0.55,Enum.EasingStyle.Elastic,_EDO),{Position=_U(0.5,-240,0.5,-80),Rotation=-15}):Play()
	TweenService:Create(rightLabel,_TI(0.55,Enum.EasingStyle.Elastic,_EDO),{Position=_U(0.5,140,0.5,80),Rotation=15}):Play()

	if waitOrSkip(0.45) then cleanupAll(); return end

	local smooth=_TI(0.4,_ESQ,_EDO)
	TweenService:Create(leftLabel,smooth,{Position=_U(0.5,-180,0.5,-50),Rotation=-8}):Play()
	TweenService:Create(rightLabel,smooth,{Position=_U(0.5,90,0.5,50),Rotation=8}):Play()

	if waitOrSkip(0.35) then cleanupAll(); return end

	TweenService:Create(leftLabel,smooth,{Position=_U(0.5,-120,0.5,-25),Rotation=-4}):Play()
	TweenService:Create(rightLabel,smooth,{Position=_U(0.5,40,0.5,25),Rotation=4}):Play()

	if waitOrSkip(0.3) then cleanupAll(); return end

	TweenService:Create(leftLabel,smooth,{Position=_U(0.5,-60,0.5,-10),Rotation=-2}):Play()
	TweenService:Create(rightLabel,smooth,{Position=_U(0.5,-10,0.5,10),Rotation=2}):Play()

	if waitOrSkip(0.25) then cleanupAll(); return end

	_ts(function()
		for i=1,30 do
			if skipped then break end
			createParticle()
			_tw(0.05)
		end
	end)

	local glitchEnd=tick()+1.1
	while tick()<glitchEnd do
		if skipped then cleanupAll(); return end
		local ox=math.random(-20,20)
		local oy=math.random(-10,10)
		leftLabel.Position=_U(0.5,-60+ox,0.5,-10+oy)
		rightLabel.Position=_U(0.5,-10+ox,0.5,10+oy)
		if math.random()<0.35 then _ts(glitchText,leftLabel,"KHUB") end
		if math.random()<0.35 then _ts(glitchText,rightLabel,"PANEL") end
		if math.random()<0.4 then addGlitchBar() end
		if math.random()<0.1 then doFlash(MAIN_COLOR,0.2,0.03) end
		_tw(0.045)
	end

	if skipped then cleanupAll(); return end

	leftLabel.Visible=false
	rightLabel.Visible=false
	mainLabel.TextTransparency=0

	doFlash(MAIN_COLOR,0.5,0.05)
	if waitOrSkip(0.08) then cleanupAll(); return end

	TweenService:Create(mainLabel,_TI(0.15,_ESB,Enum.EasingDirection.In),{TextSize=92}):Play()
	if waitOrSkip(0.15) then cleanupAll(); return end

	TweenService:Create(mainLabel,_TI(0.1),{TextSize=88}):Play()
	doFlash(WHITE,0.95,0.05)
	if waitOrSkip(0.02) then cleanupAll(); return end
	doFlash(MAIN_COLOR,0.65,0.08)

	_ts(shakeScreen,10,0.25)
	_ts(runLightBeam)

	TweenService:Create(mainLabel,_TI(0.4,_ESQ),{TextColor3=MAIN_COLOR}):Play()
	TweenService:Create(accentBar,_TI(0.5,Enum.EasingStyle.Elastic,_EDO),{Size=_U(0,420,0,3)}):Play()

	if waitOrSkip(0.2) then cleanupAll(); return end

	TweenService:Create(subLabel,_TI(0.4),{TextTransparency=0.05}):Play()
	TweenService:Create(subLabel2,_TI(0.4),{TextTransparency=0.15}):Play()
	if waitOrSkip(0.1) then cleanupAll(); return end

	doFlash(WHITE,0.3,0.04)
	TweenService:Create(subLabel,_TI(0.2),{TextSize=17}):Play()
	if waitOrSkip(0.2) then cleanupAll(); return end
	TweenService:Create(subLabel,_TI(0.2),{TextSize=16}):Play()

	_ts(function()
		for i=1,40 do
			if skipped then break end
			createParticle()
			_tw(0.08)
		end
	end)

	if waitOrSkip(0.9) then cleanupAll(); return end

	startDripping()
	-- max 2s for drips so it never sticks
	local dripT0=os.clock()
	while activeDrips>0 and not skipped and (os.clock()-dripT0)<2 do
		_tw(0.1)
	end

	if waitOrSkip(0.45) then cleanupAll(); return end
	fadeOutAudio(1.0)

	if skipped then cleanupAll(); return end

	local fadeInfo=_TI(0.85,_ESQ,Enum.EasingDirection.In)
	pcall(function()
		TweenService:Create(mainLabel,fadeInfo,{TextTransparency=1}):Play()
		TweenService:Create(subLabel,fadeInfo,{TextTransparency=1}):Play()
		TweenService:Create(subLabel2,fadeInfo,{TextTransparency=1}):Play()
		TweenService:Create(accentBar,fadeInfo,{BackgroundTransparency=1}):Play()
		TweenService:Create(overlay,fadeInfo,{BackgroundTransparency=1}):Play()
		TweenService:Create(darkOverlay,fadeInfo,{BackgroundTransparency=1}):Play()
		if blur then TweenService:Create(blur,_TI(0.85),{Size=0}):Play() end
		TweenService:Create(dripContainer,fadeInfo,{BackgroundTransparency=1}):Play()
	end)

	if waitOrSkip(0.9) then cleanupAll(); return end
	stopAudio()
	cleanupAll()
end


-- ============================================================
-- START
-- ============================================================
-- Open UI immediately so script never looks "stuck"
switchTab("Welcome")
setVisible(true)
pcall(function() setAntiAfk(S.AntiAfk) end)
pcall(function() setAutoReconnect(S.AutoReconnect) end)
print("[KHUB] +1 Stone Skipping UI ready")

-- Intro runs after UI is already open (can skip anytime)
task.spawn(function()
	-- hide main briefly while intro plays
	pcall(function() Main.Visible = false end)
	local ok, err = pcall(playKHUBIntro)
	if not ok then
		warn("[KHUB UI] Intro error: ", err)
	end
	-- force kill leftover intro gui + audio
	pcall(function()
		local pg = player:FindFirstChild("PlayerGui")
		if pg then
			local oldIntro = pg:FindFirstChild("KHUBIntro")
			if oldIntro then oldIntro:Destroy() end
		end
	end)
	pcall(function()
		for _, s in ipairs(game:GetService("SoundService"):GetDescendants()) do
			if s:IsA("Sound") and tostring(s.SoundId):find("120267378058133") then
				s:Stop()
				s:Destroy()
			end
		end
	end)
	setVisible(true)
	print("[KHUB] +1 Stone Skipping loaded · Toggle: RightShift / RightCtrl / K")
end)

-- absolute safety: if intro still exists after 12s, destroy it
task.delay(12, function()
	pcall(function()
		local pg = player:FindFirstChild("PlayerGui")
		if pg then
			local oldIntro = pg:FindFirstChild("KHUBIntro")
			if oldIntro then
				oldIntro:Destroy()
				warn("[KHUB] Intro force-removed after 12s")
			end
		end
	end)
	pcall(function() setVisible(true) end)
end)
