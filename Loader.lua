--[[
	KHUB - Blade Ball
	Ported from Kittylol full source into KHUB UI
	Tabs: Welcome | Combat | Spam | Detection | Visual | Misc | World | Unlock | Settings | Config
	Toggle: RightShift / RightCtrl / K
]]
repeat task.wait() until game:IsLoaded()

local Players           = game:GetService("Players")
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")
local Workspace         = game:GetService("Workspace")
local HttpService       = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats             = game:GetService("Stats")
local Debris            = game:GetService("Debris")
local Lighting          = game:GetService("Lighting")
local LocalPlayer       = Players.LocalPlayer or Players.PlayerAdded:Wait()
local player            = LocalPlayer

local LOGO_ID  = "rbxassetid://127230219966945"
local BG_ID    = "rbxassetid://127230219966945"
local DISCORD  = "https://discord.gg/EKPb7BRDH8"
local YOUTUBE  = "https://www.youtube.com/@kyielpambid"
local ConfigFolder = "KHUB_BladeBall_Configs"

print("[KHUB] Blade Ball starting...")

pcall(function()
	for _, parent in ipairs({CoreGui, player:FindFirstChild("PlayerGui")}) do
		if parent then
			for _, n in ipairs({"KHUB_BladeBall", "KHUB_BladeBall_Orb", "Kittylol_Notifications", "Kittylol_KeyboardUI", "Kittylol_CurveUI", "Kittylol_SpamUI", "Kittylol_TriggerUI"}) do
				local o = parent:FindFirstChild(n); if o then o:Destroy() end
			end
		end
	end
	if gethui then
		local h = gethui()
		if h then
			local o = h:FindFirstChild("KHUB_BladeBall"); if o then o:Destroy() end
		end
	end
end)

local function detectMobile()
	local touch = UserInputService.TouchEnabled
	local mouse = UserInputService.MouseEnabled
	local keyboard = UserInputService.KeyboardEnabled
	if touch and not keyboard then return true end
	if touch and not mouse then return true end
	return false
end

local function notify(msg)
	print("[KHUB Blade Ball]", msg)
end

local Alive = Workspace:FindFirstChild("Alive") or Workspace:WaitForChild("Alive", 15)
local Runtime = Workspace:FindFirstChild("Runtime") or Workspace:WaitForChild("Runtime", 15)

-- ===================== SYSTEM (Kittylol core) =====================
local System = {
	__properties = {
		__autoparry_enabled = false,
		__triggerbot_enabled = false,
		__manual_spam_enabled = false,
		__auto_spam_enabled = false,
		__play_animation = false,
		__accuracy = 50,
		__divisor_multiplier = 1.1,
		__parried = false,
		__training_parried = false,
		__spam_threshold = 1.5,
		__parries = 0,
		__grab_animation = nil,
		__tornado_time = tick(),
		__connections = {},
		__spam_rate = 340,
		__infinity_active = false,
		__deathslash_active = false,
		__timehole_active = false,
		__slashesoffury_active = false,
		__slashesoffury_count = 0,
		__is_mobile = detectMobile(),
		__randomized_accuracy_enabled = false,
	},
	__config = {
		__detections = {
			__infinity=false,__deathslash=false,
			__timehole=false,__slashesoffury=false,__phantom=false
		}
	},
	__triggerbot = {
		__enabled=false,__is_parrying=false,
		__parries=0,__max_parries=10000,__parry_delay=0.05
	}
}

local S = {
	CurveType = "Camera",
	AutoParryMode = "Remote",
	AutoSpamMode = "Remote",
	ManualSpamMode = "Remote",
	AutoAbility = false,
	AutoSpamAnimFix = true,
	ManualSpamAnimFix = true,
	FOV = 70, FOVEnabled = false,
	WalkSpeed = 36, EnableSpeed = false,
	JumpPower = 50, EnableJump = false,
	InfJump = false, Spin = false, SpinSpeed = 5,
	Gravity = 196.2, EnableGravity = false,
	HipHeight = 0, EnableHip = false,
	CharacterMod = false,
	NoRender = false,
	Emotes = false, AutoStopEmote = false, SelectedEmote = "",
	AbilityESP = false, BallStats = false,
	SkyEnabled = false, SkyPreset = "Sunset",
	Immortal = false, UnlockAll = false,
	ShowSpamBtn = false, ShowTriggerBtn = false, ShowCurveUI = false, ShowKeyboard = false,
	RandomCurve = false,
}

local function update_divisor()
	System.__properties.__divisor_multiplier = 0.7 + (System.__properties.__accuracy - 1) * (0.9/99)
end
update_divisor()

task.spawn(function()
	while task.wait(1) do
		if System.__properties.__randomized_accuracy_enabled then
			local ping = 0
			pcall(function()
				local ping_str = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
				ping = tonumber(ping_str:match("%d+")) or 0
			end)
			local new_accuracy
			if ping >= 90 then new_accuracy = 4
			elseif ping <= 50 then new_accuracy = math.random(70, 100)
			else new_accuracy = System.__properties.__accuracy end
			if new_accuracy then System.__properties.__accuracy = new_accuracy; update_divisor() end
		end
	end
end)

-- Token / remote capture for parry
local _token, _tokenFound = nil, false
pcall(function()
	for _, Function in getgc(true) do
		if type(Function) == "function" then
			local ok, src = pcall(function() return debug.info(Function, "s") end)
			if ok and type(src) == "string" and src:find("PRY", 1, true) then
				local ok2, ups = pcall(debug.getupvalues, Function)
				if ok2 and type(ups) == "table" then
					for _, value in pairs(ups) do
						if type(value) == "function" then
							_token = value; _tokenFound = true; break
						end
					end
				end
			end
		end
		if _tokenFound then break end
	end
end)
if not _tokenFound then
	notify("Parry token not found yet - rejoin or play a round then re-inject")
end

local function _tokenize(_remote_uid)
	if not _token then return "" end
	local time = tostring(math.floor(Workspace:GetServerTimeNow() * 100))
	local key = _token(_remote_uid, "TIME")
	if type(key) ~= "string" or #key == 0 then return "" end
	local characters = table.create(#time)
	for index = 1, #time do
		characters[index] = string.char(bit32.bxor(
			(string.byte(time, index) + index) % 256,
			string.byte(key, (index - 1) % #key + 1)
		))
	end
	return table.concat(characters)
end

local _reverted, _original = {}, {}
local _capturedRemote, _capturedArgs = nil, nil

local function _is_valid(args)
	return args and #args >= 8
end

local function _hook(remote)
	if not remote or _reverted[remote] then return end
	local meta = getrawmetatable(remote)
	if not meta or _original[meta] then return end
	_original[meta] = true
	pcall(function()
		setreadonly(meta, false)
		local _old = meta.__index
		meta.__index = function(self, key)
			if (key == "FireServer" and self:IsA("RemoteEvent"))
				or (key == "InvokeServer" and self:IsA("RemoteFunction")) then
				return function(_, ...)
					local _arguments = {...}
					if _is_valid(_arguments) then
						if not _reverted[self] then
							_reverted[self] = _arguments
							_capturedRemote = self
							_capturedArgs = _arguments
						end
					end
					return _old(self, key)(_, unpack(_arguments))
				end
			end
			return _old(self, key)
		end
		setreadonly(meta, true)
	end)
end

pcall(function()
	for _, _remote in pairs(ReplicatedStorage:GetDescendants()) do
		if _remote:IsA("RemoteEvent") or _remote:IsA("RemoteFunction") then
			_hook(_remote)
		end
	end
end)

task.spawn(function()
	task.wait(5)
	if _capturedRemote then notify("Anti-cheat bypass ready") end
end)

local CURVE_NAMES = {"Camera","Random","Accelerated","Backwards","Slow","High","Normal","Speed","Down","Left","Right"}

System.ball = {}
function System.ball.get()
	local balls = Workspace:FindFirstChild("Balls")
	if not balls then return nil end
	for _, ball in pairs(balls:GetChildren()) do
		if ball:GetAttribute("realBall") then
			pcall(function() ball.CanCollide = false end)
			return ball
		end
	end
	return nil
end
function System.ball.get_all()
	local t = {}
	local balls = Workspace:FindFirstChild("Balls")
	if not balls then return t end
	for _, ball in pairs(balls:GetChildren()) do
		if ball:GetAttribute("realBall") then
			pcall(function() ball.CanCollide = false end)
			table.insert(t, ball)
		end
	end
	return t
end

System.player = {}
local Closest_Entity, last_closest_check = nil, 0
function System.player.get_closest()
	local now = tick()
	if now - last_closest_check < 0.1 then return Closest_Entity end
	last_closest_check = now
	local max_distance, closest_entity = math.huge, nil
	if not Alive then return nil end
	for _, entity in pairs(Alive:GetChildren()) do
		if entity ~= LocalPlayer.Character and entity.PrimaryPart then
			local distance = LocalPlayer:DistanceFromCharacter(entity.PrimaryPart.Position)
			if distance < max_distance then max_distance = distance; closest_entity = entity end
		end
	end
	Closest_Entity = closest_entity
	return closest_entity
end

System.curve = {}
function System.curve.get_cframe()
	local Camera = Workspace.CurrentCamera
	local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local root_pos = root and root.Position or Camera.CFrame.Position
	local targetPart
	local bestDist = math.huge
	local mouseLoc = not System.__properties.__is_mobile and UserInputService:GetMouseLocation() or nil
	if Alive then
		for _, v in pairs(Alive:GetChildren()) do
			if v ~= LocalPlayer.Character and v.PrimaryPart then
				local screenPos, onScreen = Camera:WorldToScreenPoint(v.PrimaryPart.Position)
				if onScreen then
					local dist
					if mouseLoc then
						dist = (Vector2.new(screenPos.X, screenPos.Y) - mouseLoc).Magnitude
					else
						local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
						dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
					end
					if dist < bestDist then bestDist = dist; targetPart = v.PrimaryPart end
				end
			end
		end
	end
	local target_pos = targetPart and targetPart.Position or (root_pos + Camera.CFrame.LookVector * 100)
	local Parry_Type = S.CurveType
	local cf
	if Parry_Type == "Camera" then
		cf = Camera.CFrame
	elseif Parry_Type == "Random" then
		local direction = (target_pos - root_pos).Unit
		local random_offset
		local attempts = 0
		repeat
			random_offset = Vector3.new(math.random(-4000,4000), math.random(-4000,4000), math.random(-4000,4000))
			local curve_dir = (target_pos + random_offset - root_pos).Unit
			local dot = direction:Dot(curve_dir)
			attempts = attempts + 1
		until dot < 0.95 or attempts > 10
		cf = CFrame.new(root_pos, target_pos + random_offset)
	elseif Parry_Type == "Accelerated" then
		cf = CFrame.new(root_pos, target_pos + Vector3.new(0, 5, 0))
	elseif Parry_Type == "Backwards" then
		local direction = (root_pos - target_pos).Unit
		local backwards_pos = root_pos + direction * 10000 + Vector3.new(0, 1000, 0)
		cf = CFrame.new(Camera.CFrame.Position, backwards_pos)
	elseif Parry_Type == "Slow" then
		cf = CFrame.new(root_pos, target_pos + Vector3.new(0, -9e18, 0))
	elseif Parry_Type == "High" then
		cf = CFrame.new(root_pos, target_pos + Vector3.new(0, 9e18, 0))
	elseif Parry_Type == "Normal" then
		cf = CFrame.new(root_pos, root_pos + (root and root.CFrame.LookVector or Camera.CFrame.LookVector))
	elseif Parry_Type == "Speed" then
		cf = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.UpVector * 5)
	elseif Parry_Type == "Down" then
		cf = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.UpVector * -9e9)
	elseif Parry_Type == "Left" then
		cf = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position - Camera.CFrame.RightVector * 9e9)
	elseif Parry_Type == "Right" then
		cf = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.RightVector * 9e9)
	else
		cf = Camera.CFrame
	end
	return cf
end

local function fireParryRemote(curveCF)
	if not _capturedRemote or not _capturedArgs then return false end
	local cam = Workspace.CurrentCamera
	local is_mobile = System.__properties.__is_mobile
	local aim_target
	if is_mobile then
		local vp = cam.ViewportSize
		aim_target = {math.floor(vp.X / 2), math.floor(vp.Y / 2)}
	else
		local ok, mouse = pcall(function() return UserInputService:GetMouseLocation() end)
		if ok and mouse then
			aim_target = {math.floor(mouse.X), math.floor(mouse.Y)}
		else
			local vp = cam.ViewportSize
			aim_target = {math.floor(vp.X / 2), math.floor(vp.Y / 2)}
		end
	end
	local event_data = {}
	if Alive then
		for _, entity in pairs(Alive:GetChildren()) do
			if entity.PrimaryPart then
				local ok, sp = pcall(function() return cam:WorldToScreenPoint(entity.PrimaryPart.Position) end)
				if ok then event_data[entity.Name] = sp end
			end
		end
	end
	local packet = {
		_capturedArgs[1],
		_capturedArgs[2],
		_tokenize(_capturedArgs[2]),
		0.5,
		curveCF or cam.CFrame,
		event_data,
		aim_target,
		false
	}
	pcall(function()
		if _capturedRemote:IsA("RemoteEvent") then
			_capturedRemote:FireServer(unpack(packet))
		elseif _capturedRemote:IsA("RemoteFunction") then
			_capturedRemote:InvokeServer(unpack(packet))
		end
	end)
	return true
end

-- Animation grab parry
System.animation = {}
local SwordAPI, LastPlayedd, Sword_CP, Sword_Spped, Grab_Parry, AnimFix_Cache = nil, 0, false, 1, nil, {}
pcall(function()
	SwordAPI = ReplicatedStorage:WaitForChild("Shared", 5):WaitForChild("SwordAPI", 5)
end)

local function GetParryAnimation(swordName)
	if not SwordAPI then return nil end
	if not swordName or swordName == "" then
		return SwordAPI.Collection.Default and SwordAPI.Collection.Default:FindFirstChild("GrabParry")
	end
	if AnimFix_Cache[swordName] then return AnimFix_Cache[swordName] end
	local ok, swordData = pcall(function()
		return ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(swordName)
	end)
	if not ok or not swordData or type(swordData) ~= "table" or not swordData.AnimationType then
		AnimFix_Cache[swordName] = SwordAPI.Collection.Default and SwordAPI.Collection.Default:FindFirstChild("GrabParry")
		return AnimFix_Cache[swordName]
	end
	for _, obj in pairs(SwordAPI.Collection:GetChildren()) do
		if obj.Name == swordData.AnimationType then
			local anim = obj:FindFirstChild("GrabParry") or obj:FindFirstChild("Grab")
			if anim then AnimFix_Cache[swordName] = anim; return anim end
		end
	end
	AnimFix_Cache[swordName] = SwordAPI.Collection.Default and SwordAPI.Collection.Default:FindFirstChild("GrabParry")
	return AnimFix_Cache[swordName]
end

function System.animation.play_grab_parry()
	if not System.__properties.__play_animation then return end
	if not ((os.clock() - LastPlayedd) >= (Sword_Spped - 0.8) or Sword_CP) then return end
	LastPlayedd = os.clock(); Sword_CP = false
	local char = LocalPlayer.Character; if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid"); if not humanoid or not humanoid.Animator then return end
	local currentSword = char:GetAttribute("CurrentlyEquippedSword")
	if getgenv().skinChanger then
		currentSword = (getgenv().swordAnimations ~= "" and getgenv().swordAnimations)
			or (getgenv().swordModel ~= "" and getgenv().swordModel) or currentSword
	end
	local animation = GetParryAnimation(currentSword); if not animation then return end
	for _, track in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do
		if track.Name == "GrabParry" or track.Name == "Grab" or track.Name == "SuccessParry" or track.Name == "Success" then
			pcall(function() track:Stop(0.1) end)
		end
	end
	Grab_Parry = humanoid.Animator:LoadAnimation(animation)
	pcall(function()
		Grab_Parry:Play(Grab_Parry:GetAttribute("PlayFadeTime") or 0, Grab_Parry:GetAttribute("PlayWeight") or 1, Grab_Parry:GetAttribute("PlaySpeed") or 1)
	end)
end

pcall(function()
	ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function()
		Sword_CP = true
	end)
end)

System.parry = {}
function System.parry.execute()
	if System.__properties.__parries > 10000 or not LocalPlayer.Character then return end
	fireParryRemote(System.curve.get_cframe())
	System.__properties.__parries = System.__properties.__parries + 1
	task.delay(0.5, function()
		if System.__properties.__parries > 0 then System.__properties.__parries = System.__properties.__parries - 1 end
	end)
end
function System.parry.keypress()
	System.parry.execute()
end
function System.parry.execute_action()
	System.animation.play_grab_parry()
	System.parry.execute()
end

local function linear_predict(a,b,t) return a+(b-a)*t end
System.detection = {
	__ball_properties = {__aerodynamic_time=tick(),__last_warping=tick(),__lerp_radians=0,__curving=tick()}
}
function System.detection.is_curved()
	local props = System.detection.__ball_properties
	local ball = System.ball.get(); if not ball then return false end
	local zoomies = ball:FindFirstChild("zoomies"); if not zoomies then return false end
	local velocity = zoomies.VectorVelocity; local speed = velocity.Magnitude
	if speed < 1 then return false end
	local ball_dir = velocity.Unit
	local char = LocalPlayer.Character; if not char or not char.PrimaryPart then return false end
	local pos = char.PrimaryPart.Position
	local direction = (pos - ball.Position).Unit
	local dot = direction:Dot(ball_dir)
	local ping = 0
	pcall(function() ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/1000 end)
	local distance = (pos - ball.Position).Magnitude
	local reach_time = distance/speed - ping
	local dot_threshold = math.clamp(0.55-(ping*0.75), -1, 0.45)
	local speed_threshold = math.min(speed/100, 45)
	local ball_distance_threshold = 15 - math.min(distance/1000, 15) + speed_threshold
	local clamped_dot = math.clamp(dot, -1, 1)
	local radians = math.asin(clamped_dot)
	props.__lerp_radians = linear_predict(props.__lerp_radians, radians, 0.85)
	if props.__lerp_radians < 0.016 then props.__last_warping = tick() end
	if distance < (ball_distance_threshold*0.85) then return false end
	if (tick()-props.__last_warping) < (reach_time/1.4) then return true end
	if (tick()-props.__curving) < (reach_time/1.1) then return true end
	return dot < dot_threshold
end

-- Ability detections
pcall(function()
	ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(c,d)
		System.__properties.__deathslash_active = d or false
	end)
	ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(a,b)
		System.__properties.__infinity_active = b or false
	end)
end)
pcall(function()
	local net = ReplicatedStorage.Packages._Index["sleitnick_net@0.1.0"].net
	net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(...)
		local args = {...}; local p = args[1]
		if p == LocalPlayer or p == LocalPlayer.Name or (p and p.Name == LocalPlayer.Name) then
			System.__properties.__timehole_active = true
		end
	end)
	net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
		System.__properties.__timehole_active = false
	end)
	local maxParryCount, parryDelay = 36, 0.05
	net["RE/SlashesOfFuryActivate"].OnClientEvent:Connect(function(...)
		local args = {...}; local p = args[1]
		if p == LocalPlayer or p == LocalPlayer.Name or (p and p.Name == LocalPlayer.Name) then
			System.__properties.__slashesoffury_active = true
			System.__properties.__slashesoffury_count = 0
		end
	end)
	net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
		System.__properties.__slashesoffury_active = false
		System.__properties.__slashesoffury_count = 0
	end)
	net["RE/SlashesOfFuryParry"].OnClientEvent:Connect(function()
		System.__properties.__slashesoffury_count = System.__properties.__slashesoffury_count + 1
	end)
	net["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
		task.spawn(function()
			while System.__properties.__slashesoffury_active and System.__properties.__slashesoffury_count < maxParryCount do
				if System.__config.__detections.__slashesoffury then
					System.parry.execute(); task.wait(parryDelay)
				else break end
			end
		end)
	end)
end)

if Runtime then
	Runtime.ChildAdded:Connect(function(Object)
		if not System.__config.__detections.__phantom then return end
		if Object.Name == "maxTransmission" or Object.Name == "transmissionpart" then
			local Weld = Object:FindFirstChildWhichIsA("WeldConstraint")
			if Weld then
				local Character = LocalPlayer.Character
				if Character and Weld.Part1 == Character:FindFirstChild("HumanoidRootPart") then
					local CurrentBall = System.ball.get()
					Weld:Destroy()
					if CurrentBall then
						local FocusConnection
						FocusConnection = RunService.RenderStepped:Connect(function()
							local Highlighted = CurrentBall:GetAttribute("highlighted")
							if Highlighted == true then
								pcall(function() ReplicatedStorage.Remotes.AbilityButtonPress:Fire() end)
								System.__properties.__parried = true
								task.delay(1, function() System.__properties.__parried = false end)
							elseif Highlighted == false then
								FocusConnection:Disconnect()
							end
						end)
						task.delay(3, function() if FocusConnection and FocusConnection.Connected then FocusConnection:Disconnect() end end)
					end
				end
			end
		end
	end)
end

-- Triggerbot
local triggerbotCooldown = false
System.triggerbot = {}
function System.triggerbot.trigger(ball)
	if triggerbotCooldown or System.__triggerbot.__is_parrying then return end
	if System.__triggerbot.__parries > System.__triggerbot.__max_parries then return end
	if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and LocalPlayer.Character.PrimaryPart:FindFirstChild("SingularityCape") then return end
	triggerbotCooldown = true
	System.__triggerbot.__is_parrying = true
	System.__triggerbot.__parries = System.__triggerbot.__parries + 1
	System.parry.execute()
	if System.__properties.__play_animation then System.animation.play_grab_parry() end
	task.delay(0.2, function()
		triggerbotCooldown = false
		if System.__triggerbot.__parries > 0 then System.__triggerbot.__parries = System.__triggerbot.__parries - 1 end
	end)
	task.spawn(function()
		local start_time = tick()
		repeat RunService.Heartbeat:Wait() until (tick() - start_time >= 0.15 or not System.__triggerbot.__is_parrying)
		System.__triggerbot.__is_parrying = false
	end)
end
function System.triggerbot.loop()
	if not System.__triggerbot.__enabled then return end
	local balls = Workspace:FindFirstChild("Balls"); if not balls then return end
	for _, ball in pairs(balls:GetChildren()) do
		if ball:IsA("BasePart") and ball:GetAttribute("target") == LocalPlayer.Name then
			System.triggerbot.trigger(ball); break
		end
	end
end
function System.triggerbot.enable(enabled)
	System.__triggerbot.__enabled = enabled
	if enabled then
		if not System.__properties.__connections.__triggerbot then
			System.__properties.__connections.__triggerbot = RunService.Heartbeat:Connect(System.triggerbot.loop)
		end
	else
		if System.__properties.__connections.__triggerbot then
			System.__properties.__connections.__triggerbot:Disconnect()
			System.__properties.__connections.__triggerbot = nil
		end
		System.__triggerbot.__is_parrying = false
		System.__triggerbot.__parries = 0
		triggerbotCooldown = false
	end
end

-- Manual spam
System.manual_spam = {}
local macroSpamActive = false
function System.manual_spam.start()
	System.manual_spam.stop()
	System.__properties.__manual_spam_enabled = true
	macroSpamActive = true
end
function System.manual_spam.stop()
	System.__properties.__manual_spam_enabled = false
	macroSpamActive = false
end
RunService.Heartbeat:Connect(function()
	if macroSpamActive and _capturedRemote then
		pcall(function()
			fireParryRemote(System.curve.get_cframe())
			if S.ManualSpamAnimFix then System.animation.play_grab_parry() end
		end)
	end
end)

-- Auto spam
System.auto_spam = {}
function System.auto_spam:get_entity_properties()
	System.player.get_closest()
	if not Closest_Entity or not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart or not Closest_Entity.PrimaryPart then return false end
	return {
		Velocity = Closest_Entity.PrimaryPart.AssemblyLinearVelocity,
		Direction = (LocalPlayer.Character.PrimaryPart.Position - Closest_Entity.PrimaryPart.Position).Unit,
		Distance = (LocalPlayer.Character.PrimaryPart.Position - Closest_Entity.PrimaryPart.Position).Magnitude
	}
end
function System.auto_spam:get_ball_properties()
	local ball = System.ball.get()
	if not ball or not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return false end
	local ball_velocity = ball.AssemblyLinearVelocity
	local ball_direction = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Unit
	local ball_distance = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Magnitude
	local ball_dot = ball_velocity.Magnitude > 0 and ball_direction:Dot(ball_velocity.Unit) or 0
	return {Velocity = ball_velocity, Direction = ball_direction, Distance = ball_distance, Dot = ball_dot}
end
function System.auto_spam.spam_service(self)
	local ball = System.ball.get()
	local entity = System.player.get_closest()
	if not ball or not entity or not entity.PrimaryPart or not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return 0 end
	local velocity = ball.AssemblyLinearVelocity
	local speed = velocity.Magnitude
	local direction = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Unit
	local dot = speed > 0 and direction:Dot(velocity.Unit) or 0
	local target_distance = LocalPlayer:DistanceFromCharacter(entity.PrimaryPart.Position)
	local maximum_spam_distance = self.Ping + math.min(speed / 6, 255)
	if self.Entity_Properties.Distance > maximum_spam_distance or self.Ball_Properties.Distance > maximum_spam_distance or target_distance > maximum_spam_distance then return 0 end
	local maximum_speed = 5 - math.min(speed / 5, 5)
	local maximum_dot = math.clamp(dot, -1, 0) * maximum_speed
	return maximum_spam_distance - maximum_dot
end
function System.auto_spam.start()
	if System.__properties.__connections.__auto_spam then
		System.__properties.__connections.__auto_spam:Disconnect()
	end
	System.__properties.__auto_spam_enabled = true
	System.__properties.__connections.__auto_spam = RunService.PreSimulation:Connect(function()
		if not System.__properties.__auto_spam_enabled then return end
		local ball = System.ball.get()
		if not ball or System.__properties.__slashesoffury_active then return end
		local zoomies = ball:FindFirstChild("zoomies"); if not zoomies then return end
		System.player.get_closest()
		local ball_properties = System.auto_spam:get_ball_properties()
		local entity_properties = System.auto_spam:get_entity_properties()
		if not ball_properties or not entity_properties or not Closest_Entity or not Closest_Entity.PrimaryPart then return end
		local ping = 0
		pcall(function() ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end)
		local ping_threshold = math.clamp(ping / 10, 1, 16)
		local spam_accuracy = System.auto_spam.spam_service({
			Ball_Properties = ball_properties,
			Entity_Properties = entity_properties,
			Ping = ping_threshold
		})
		local target_distance = LocalPlayer:DistanceFromCharacter(Closest_Entity.PrimaryPart.Position)
		local distance = LocalPlayer:DistanceFromCharacter(ball.Position)
		local ball_target = ball:GetAttribute("target")
		if not ball_target or target_distance > spam_accuracy or distance > spam_accuracy then return end
		if LocalPlayer.Character:GetAttribute("Pulsed") then return end
		if ball_target == LocalPlayer.Name and target_distance > 30 and distance > 30 then return end
		if distance <= spam_accuracy and System.__properties.__parries > System.__properties.__spam_threshold then
			System.parry.execute()
			if S.AutoSpamAnimFix then System.animation.play_grab_parry() end
		end
	end)
end
function System.auto_spam.stop()
	System.__properties.__auto_spam_enabled = false
	if System.__properties.__connections.__auto_spam then
		System.__properties.__connections.__auto_spam:Disconnect()
		System.__properties.__connections.__auto_spam = nil
	end
end

-- Auto parry
System.autoparry = {}
function System.autoparry.start()
	if System.__properties.__connections.__autoparry then
		System.__properties.__connections.__autoparry:Disconnect()
	end
	System.__properties.__connections.__autoparry = RunService.PreSimulation:Connect(function()
		if not System.__properties.__autoparry_enabled or not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return end
		local balls = System.ball.get_all()
		local one_ball = System.ball.get()
		local training_ball = nil
		if Workspace:FindFirstChild("TrainingBalls") then
			for _, Instance in pairs(Workspace.TrainingBalls:GetChildren()) do
				if Instance:GetAttribute("realBall") then training_ball = Instance; break end
			end
		end
		for _, ball in pairs(balls) do
			if System.__triggerbot.__enabled then return end
			if not ball then continue end
			local zoomies = ball:FindFirstChild("zoomies"); if not zoomies then continue end
			pcall(function()
				ball:GetAttributeChangedSignal("target"):Once(function() System.__properties.__parried = false end)
			end)
			if System.__properties.__parried then continue end
			local ball_target = ball:GetAttribute("target")
			local velocity = zoomies.VectorVelocity
			local distance = (LocalPlayer.Character.PrimaryPart.Position - ball.Position).Magnitude
			local ping = 0
			pcall(function() ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/10 end)
			local ping_threshold = math.clamp(ping/10, 5, 17)
			local speed = velocity.Magnitude
			local capped_speed_diff = math.min(math.max(speed-9.5, 0), 650)
			local speed_divisor = (2.4 + capped_speed_diff * 0.002) * System.__properties.__divisor_multiplier
			local parry_accuracy = ping_threshold + math.max(speed / speed_divisor, 9.5)
			local curved = System.detection.is_curved()
			if ball:FindFirstChild("AeroDynamicSlashVFX") then
				ball.AeroDynamicSlashVFX:Destroy()
				System.__properties.__tornado_time = tick()
			end
			if Runtime and Runtime:FindFirstChild("Tornado") then
				if (tick() - System.__properties.__tornado_time) < (Runtime.Tornado:GetAttribute("TornadoTime") or 1) + 0.314159 then continue end
			end
			if one_ball and one_ball:GetAttribute("target") == LocalPlayer.Name and curved then continue end
			if ball:FindFirstChild("ComboCounter") then continue end
			if LocalPlayer.Character.PrimaryPart:FindFirstChild("SingularityCape") then continue end
			if System.__config.__detections.__infinity and System.__properties.__infinity_active then continue end
			if System.__config.__detections.__deathslash and System.__properties.__deathslash_active then continue end
			if System.__config.__detections.__timehole and System.__properties.__timehole_active then continue end
			if System.__config.__detections.__slashesoffury and System.__properties.__slashesoffury_active then continue end
			if ball_target == LocalPlayer.Name and distance <= parry_accuracy then
				if S.AutoAbility then
					pcall(function()
						local AbilityCD = LocalPlayer.PlayerGui.Hotbar.Ability.UIGradient
						if AbilityCD and AbilityCD.Offset.Y == 0.5 then
							System.__properties.__parried = true
							ReplicatedStorage.Remotes.AbilityButtonPress:Fire()
							task.wait(2.432)
							ReplicatedStorage.Remotes.DeathSlashShootActivation:FireServer(true)
						end
					end)
				end
			end
			if ball_target == LocalPlayer.Name and distance <= parry_accuracy then
				if S.AutoParryMode == "Keypress" then System.parry.keypress()
				else System.parry.execute_action() end
				System.__properties.__parried = true
				local last_parrys = tick()
				repeat RunService.Stepped:Wait() until (tick() - last_parrys) >= 1 or not System.__properties.__parried
				System.__properties.__parried = false
			end
		end
		if training_ball then
			local zoomies = training_ball:FindFirstChild("zoomies")
			if zoomies and not System.__properties.__training_parried then
				local ball_target = training_ball:GetAttribute("target")
				local velocity = zoomies.VectorVelocity
				local distance = LocalPlayer:DistanceFromCharacter(training_ball.Position)
				local speed = velocity.Magnitude
				local ping = 0
				pcall(function() ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/10 end)
				local ping_threshold = math.clamp(ping/10, 5, 17)
				local capped_speed_diff = math.min(math.max(speed-9.5, 0), 650)
				local speed_divisor = (2.4 + capped_speed_diff * 0.002) * System.__properties.__divisor_multiplier
				local parry_accuracy = ping_threshold + math.max(speed / speed_divisor, 9.5)
				if ball_target == LocalPlayer.Name and distance <= parry_accuracy then
					System.parry.execute_action()
					System.__properties.__training_parried = true
					task.delay(1, function() System.__properties.__training_parried = false end)
				end
			end
		end
	end)
end
function System.autoparry.stop()
	if System.__properties.__connections.__autoparry then
		System.__properties.__connections.__autoparry:Disconnect()
		System.__properties.__connections.__autoparry = nil
	end
end

print("[KHUB] Blade Ball combat core loaded")

-- ===================== CHARACTER / MISC BACKENDS =====================
getgenv().AutoParryMode = "Remote"
getgenv().AutoSpamMode = "Remote"
getgenv().ManualSpamMode = "Remote"
getgenv().AutoAbility = false
getgenv().skinChanger = getgenv().skinChanger or false
getgenv().swordModel = getgenv().swordModel or ""
getgenv().swordAnimations = getgenv().swordAnimations or ""
getgenv().swordFX = getgenv().swordFX or ""
getgenv().explosionChanger = getgenv().explosionChanger or false
getgenv().explosionFX = getgenv().explosionFX or ""

local OriginalValues = nil
local spinAngle = 0
local function CharacterApply()
	if not S.CharacterMod then return end
	local char = LocalPlayer.Character; if not char then return end
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	if humanoid then
		if not OriginalValues or OriginalValues.Character ~= char then
			OriginalValues = {
				Character = char, WalkSpeed = humanoid.WalkSpeed, JumpPower = humanoid.JumpPower,
				JumpHeight = humanoid.JumpHeight, HipHeight = humanoid.HipHeight, AutoRotate = humanoid.AutoRotate
			}
		end
		if S.EnableSpeed then humanoid.WalkSpeed = S.WalkSpeed end
		if S.EnableJump then
			if humanoid.UseJumpPower then humanoid.JumpPower = S.JumpPower
			else humanoid.JumpHeight = S.JumpPower * 0.144 end
		end
		if S.EnableHip then humanoid.HipHeight = S.HipHeight end
		if S.Spin and root then
			humanoid.AutoRotate = false
			spinAngle = (spinAngle + S.SpinSpeed) % 360
			root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(spinAngle), 0)
		elseif OriginalValues and OriginalValues.AutoRotate ~= nil then
			humanoid.AutoRotate = OriginalValues.AutoRotate
		end
	end
	if S.EnableGravity then Workspace.Gravity = S.Gravity end
end

UserInputService.JumpRequest:Connect(function()
	if S.CharacterMod and S.InfJump then
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

RunService.Heartbeat:Connect(function()
	pcall(CharacterApply)
	if S.FOVEnabled then
		local cam = Workspace.CurrentCamera
		if cam then cam.FieldOfView = S.FOV end
	end
end)

-- Random curve
RunService.PreSimulation:Connect(function()
	if S.RandomCurve then
		S.CurveType = CURVE_NAMES[math.random(1, #CURVE_NAMES)]
	end
end)

-- No Render
local noRenderConn = nil
local function setNoRender(on)
	S.NoRender = on
	pcall(function()
		local ps = LocalPlayer:FindFirstChild("PlayerScripts")
		local es = ps and ps:FindFirstChild("EffectScripts")
		local fx = es and es:FindFirstChild("ClientFX")
		if fx then fx.Disabled = on end
	end)
	if noRenderConn then noRenderConn:Disconnect(); noRenderConn = nil end
	if on and Runtime then
		noRenderConn = Runtime.ChildAdded:Connect(function(v) Debris:AddItem(v, 0) end)
	end
end

-- Emotes
local animation_system = { storage = {}, current = nil, track = nil }
pcall(function()
	local emotes_folder = ReplicatedStorage.Misc.Emotes
	for _, animation in pairs(emotes_folder:GetChildren()) do
		if animation:IsA("Animation") and animation:GetAttribute("EmoteName") then
			animation_system.storage[animation:GetAttribute("EmoteName")] = animation
		end
	end
end)
local function getEmotesList()
	local t = {}
	for n in pairs(animation_system.storage) do table.insert(t, n) end
	table.sort(t)
	return t
end
local emotes_data = getEmotesList()
function animation_system.play(name)
	local data = animation_system.storage[name]
	if not data or not LocalPlayer.Character then return end
	local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local animator = hum and hum:FindFirstChildOfClass("Animator")
	if not animator then return end
	if animation_system.track then pcall(function() animation_system.track:Stop(); animation_system.track:Destroy() end) end
	animation_system.track = animator:LoadAnimation(data)
	animation_system.track:Play()
	animation_system.current = name
end
function animation_system.stop()
	if animation_system.track then pcall(function() animation_system.track:Stop(); animation_system.track:Destroy() end) end
	animation_system.track = nil; animation_system.current = nil
end
RunService.Heartbeat:Connect(function()
	if not S.Emotes or not S.AutoStopEmote then return end
	if not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return end
	local speed = LocalPlayer.Character.PrimaryPart.AssemblyLinearVelocity.Magnitude
	if speed > 30 and animation_system.track and animation_system.track.IsPlaying then
		animation_system.track:Stop()
	elseif animation_system.current and (not animation_system.track or not animation_system.track.IsPlaying) then
		animation_system.play(animation_system.current)
	end
end)

-- World presets
local WorldPresets = {
	{Name="Sunset", Sky={"rbxassetid://323494035","rbxassetid://323494368","rbxassetid://323494130","rbxassetid://323494252","rbxassetid://323494067","rbxassetid://323493360"},
		Time=17.2,Brightness=2.2,Exposure=0.15,Ambient=Color3.fromRGB(255,180,150),Outdoor=Color3.fromRGB(255,200,170),Fog=Color3.fromRGB(255,185,155),FogEnd=1800},
	{Name="Blue Sky", Sky={"rbxassetid://135483466","rbxassetid://135483484","rbxassetid://135483461","rbxassetid://135483495","rbxassetid://135483499","rbxassetid://135483475"},
		Time=13.5,Brightness=2.5,Exposure=0.2,Ambient=Color3.fromRGB(175,205,255),Outdoor=Color3.fromRGB(200,220,255),Fog=Color3.fromRGB(175,210,255),FogEnd=2500},
	{Name="Galaxy", Sky={"rbxassetid://159454299","rbxassetid://159454296","rbxassetid://159454293","rbxassetid://159454286","rbxassetid://159454300","rbxassetid://159454288"},
		Time=12,Brightness=1.5,Exposure=0.2,Ambient=Color3.fromRGB(85,75,145),Outdoor=Color3.fromRGB(105,95,175),Fog=Color3.fromRGB(75,70,145),FogEnd=1800},
}
local function ClearWorld()
	for _,o in ipairs(Lighting:GetChildren()) do
		if o.Name=="KHUB_Sky" or o.Name=="KHUB_Atmosphere" or o.Name=="KHUB_CC" or o.Name=="KHUB_Bloom" then o:Destroy() end
	end
end
local function ApplyWorld(preset)
	if not preset then return end
	ClearWorld()
	local sky = Instance.new("Sky"); sky.Name="KHUB_Sky"
	sky.SkyboxBk=preset.Sky[1]; sky.SkyboxDn=preset.Sky[2]; sky.SkyboxFt=preset.Sky[3]
	sky.SkyboxLf=preset.Sky[4]; sky.SkyboxRt=preset.Sky[5]; sky.SkyboxUp=preset.Sky[6]
	sky.Parent = Lighting
	Lighting.ClockTime=preset.Time; Lighting.Brightness=preset.Brightness
	Lighting.ExposureCompensation=preset.Exposure; Lighting.Ambient=preset.Ambient
	Lighting.OutdoorAmbient=preset.Outdoor; Lighting.FogColor=preset.Fog; Lighting.FogEnd=preset.FogEnd
end

-- Immortal orbit
local orbitEnabled, orbitHRP = false, nil
local orbitConn = nil
local function startImmortal()
	orbitEnabled = true
	if LocalPlayer.Character then orbitHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") end
	LocalPlayer.CharacterAdded:Connect(function(c)
		orbitHRP = c:WaitForChild("HumanoidRootPart", 5)
	end)
	if orbitConn then orbitConn:Disconnect() end
	local Desync = {}
	orbitConn = RunService.Heartbeat:Connect(function()
		if not orbitEnabled or not orbitHRP or not orbitHRP.Parent then return end
		Desync[1] = orbitHRP.CFrame
		Desync[2] = orbitHRP.AssemblyLinearVelocity
		local r, a = 20, tick() * math.pi * 2 * 4
		orbitHRP.CFrame = Desync[1] + Vector3.new(math.cos(a)*r, 0, math.sin(a)*r)
		orbitHRP.AssemblyLinearVelocity = Vector3.zero
		RunService.RenderStepped:Wait()
		if orbitEnabled and orbitHRP then
			orbitHRP.CFrame = Desync[1]
			orbitHRP.AssemblyLinearVelocity = Desync[2]
		end
	end)
end
local function stopImmortal()
	orbitEnabled = false
	if orbitConn then orbitConn:Disconnect(); orbitConn = nil end
end

-- Ability ESP (simplified)
local Visual_Data = {}
local function stopAbilityESP()
	S.AbilityESP = false
	for _, data in pairs(Visual_Data) do
		pcall(function() if data.bill then data.bill:Destroy() end end)
	end
	Visual_Data = {}
end
local function startAbilityESP()
	S.AbilityESP = true
	task.spawn(function()
		while S.AbilityESP do
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
					if not Visual_Data[plr] then
						local bill = Instance.new("BillboardGui")
						bill.Size = UDim2.fromOffset(100, 40); bill.StudsOffset = Vector3.new(0, 3, 0)
						bill.AlwaysOnTop = true; bill.Adornee = plr.Character.Head
						bill.Parent = CoreGui
						local lbl = Instance.new("TextLabel")
						lbl.Size = UDim2.new(1,0,1,0); lbl.BackgroundTransparency = 1
						lbl.TextColor3 = Color3.new(1,1,1); lbl.TextSize = 12; lbl.Font = Enum.Font.GothamBold
						lbl.TextStrokeTransparency = 0.3; lbl.Parent = bill
						Visual_Data[plr] = {bill=bill, label=lbl}
					end
					local ab = plr:GetAttribute("CurrentlyEquippedAbility") or plr:GetAttribute("EquippedAbility") or plr.DisplayName
					if Visual_Data[plr] and Visual_Data[plr].label then
						Visual_Data[plr].label.Text = tostring(ab)
						if Visual_Data[plr].bill then Visual_Data[plr].bill.Adornee = plr.Character:FindFirstChild("Head") end
					end
				end
			end
			task.wait(0.5)
		end
	end)
end

-- Ball stats GUI
local BallStatsGui = nil
local function destroyBallStats()
	if BallStatsGui then BallStatsGui:Destroy(); BallStatsGui = nil end
end
local function createBallStats()
	destroyBallStats()
	local gui = Instance.new("ScreenGui"); gui.Name = "KHUB_BallStats"; gui.ResetOnSpawn = false; gui.Parent = CoreGui
	BallStatsGui = gui
	local panel = Instance.new("Frame")
	panel.Size = UDim2.fromOffset(160, 70); panel.Position = UDim2.new(0, 20, 0.5, -35)
	panel.BackgroundColor3 = Color3.fromRGB(20, 20, 28); panel.BorderSizePixel = 0; panel.Parent = gui
	Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)
	local speedL = Instance.new("TextLabel"); speedL.Size = UDim2.new(1,-16,0,24); speedL.Position = UDim2.fromOffset(8,8)
	speedL.BackgroundTransparency = 1; speedL.Text = "Speed: 0"; speedL.TextColor3 = Color3.new(1,1,1)
	speedL.Font = Enum.Font.GothamBold; speedL.TextSize = 14; speedL.TextXAlignment = Enum.TextXAlignment.Left; speedL.Parent = panel
	local peakL = Instance.new("TextLabel"); peakL.Size = UDim2.new(1,-16,0,24); peakL.Position = UDim2.fromOffset(8,36)
	peakL.BackgroundTransparency = 1; peakL.Text = "Peak: 0"; peakL.TextColor3 = Color3.fromRGB(180,180,200)
	peakL.Font = Enum.Font.Gotham; peakL.TextSize = 13; peakL.TextXAlignment = Enum.TextXAlignment.Left; peakL.Parent = panel
	local peak = 0
	task.spawn(function()
		while BallStatsGui and BallStatsGui.Parent do
			local ball = System.ball.get()
			local sp = 0
			if ball then sp = (ball.AssemblyLinearVelocity or Vector3.zero).Magnitude end
			if sp > peak then peak = sp end
			speedL.Text = string.format("Speed: %.1f", sp)
			peakL.Text = string.format("Peak: %.1f", peak)
			task.wait(0.05)
		end
	end)
end

-- Floating action buttons (Spam / Trigger)
local function makeFloatBtn(name, text, pos, onClick)
	local gui = Instance.new("ScreenGui"); gui.Name = name; gui.ResetOnSpawn = false; gui.Parent = CoreGui
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.fromOffset(100, 44); btn.Position = pos
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55); btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1); btn.Font = Enum.Font.GothamBold; btn.TextSize = 14
	btn.BorderSizePixel = 0; btn.Parent = gui
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	btn.MouseButton1Click:Connect(onClick)
	-- drag
	local dragging, d0, p0
	btn.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true; d0 = i.Position; p0 = btn.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - d0
			btn.Position = UDim2.new(p0.X.Scale, p0.X.Offset + d.X, p0.Y.Scale, p0.Y.Offset + d.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
	return gui
end

-- ===================== KHUB UI =====================
local THEME = {
	bg=Color3.fromRGB(5,7,18), panel=Color3.fromRGB(10,14,32), card=Color3.fromRGB(17,23,48),
	inner=Color3.fromRGB(10,14,30), accent=Color3.fromRGB(70,225,255), accent2=Color3.fromRGB(175,110,255),
	gold=Color3.fromRGB(255,216,140), text=Color3.fromRGB(238,242,255), dim=Color3.fromRGB(150,160,205),
	mute=Color3.fromRGB(100,112,158), stroke=Color3.fromRGB(80,120,210), green=Color3.fromRGB(80,220,140),
	red=Color3.fromRGB(255,90,110), off=Color3.fromRGB(45,50,75), white=Color3.fromRGB(255,255,255),
}
local function corner(o,r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 10); c.Parent=o end
local function mkstroke(o,col,th,tr)
	local s=Instance.new("UIStroke"); s.Color=col or THEME.stroke; s.Thickness=th or 1; s.Transparency=tr or 0.4; s.Parent=o; return s
end
local function GetUIParent()
	local ok,res=pcall(function() if gethui then return gethui() end end)
	if ok and res then return res end
	return CoreGui
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KHUB_BladeBall"; ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.Parent = GetUIParent()

local Splash = Instance.new("Frame")
Splash.Size = UDim2.new(1,0,1,0); Splash.BackgroundColor3 = THEME.bg; Splash.BorderSizePixel = 0
Splash.ZIndex = 200; Splash.Parent = ScreenGui
local SpTitle = Instance.new("TextLabel")
SpTitle.Size = UDim2.new(1,0,0,40); SpTitle.Position = UDim2.new(0,0,0.42,0)
SpTitle.BackgroundTransparency = 1; SpTitle.Text = "KHUB"; SpTitle.Font = Enum.Font.GothamBlack
SpTitle.TextSize = 42; SpTitle.TextColor3 = THEME.accent; SpTitle.ZIndex = 201; SpTitle.Parent = Splash
local SpSub = Instance.new("TextLabel")
SpSub.Size = UDim2.new(1,0,0,24); SpSub.Position = UDim2.new(0,0,0.42,44)
SpSub.BackgroundTransparency = 1; SpSub.Text = "BLADE BALL"; SpSub.Font = Enum.Font.GothamBold
SpSub.TextSize = 16; SpSub.TextColor3 = THEME.gold; SpSub.ZIndex = 201; SpSub.Parent = Splash
task.spawn(function()
	task.wait(1.4)
	TweenService:Create(Splash, TweenInfo.new(0.45), {BackgroundTransparency=1}):Play()
	task.wait(0.5); pcall(function() Splash:Destroy() end)
end)

local BASE_W, BASE_H = 640, 440
local Scale = Instance.new("UIScale"); Scale.Parent = ScreenGui
local function updateScale()
	local cam = Workspace.CurrentCamera; if not cam then return end
	local vs = cam.ViewportSize
	Scale.Scale = math.clamp(math.min(vs.X/900, vs.Y/600), 0.55, 1.15)
end
updateScale()
pcall(function() Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale) end)

local Win = Instance.new("Frame")
Win.Name = "Win"; Win.Size = UDim2.new(0,BASE_W,0,BASE_H)
Win.Position = UDim2.new(0.5,-BASE_W/2,0.5,-BASE_H/2)
Win.BackgroundColor3 = THEME.bg; Win.BorderSizePixel = 0; Win.ClipsDescendants = true
Win.Visible = true; Win.Parent = ScreenGui; corner(Win, 20); mkstroke(Win, THEME.accent2, 2, 0.3)
local WinBG = Instance.new("ImageLabel")
WinBG.Size = UDim2.new(1,0,1,0); WinBG.BackgroundTransparency = 1; WinBG.Image = BG_ID
WinBG.ScaleType = Enum.ScaleType.Crop; WinBG.ImageTransparency = 0.35; WinBG.ZIndex = 0; WinBG.Parent = Win

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,52); Header.BackgroundColor3 = THEME.panel
Header.BackgroundTransparency = 0.55; Header.BorderSizePixel = 0; Header.ZIndex = 5; Header.Parent = Win
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0,36,0,36); Logo.Position = UDim2.new(0,12,0.5,-18)
Logo.BackgroundTransparency = 1; Logo.Image = LOGO_ID; Logo.ZIndex = 6; Logo.Parent = Header
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0,380,1,0); Title.Position = UDim2.new(0,56,0,0)
Title.BackgroundTransparency = 1; Title.Text = "KHUB - Blade Ball"; Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18; Title.TextColor3 = Color3.new(1,1,1); Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 6; Title.Parent = Header
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0,32,0,32); MinBtn.Position = UDim2.new(1,-76,0.5,-16)
MinBtn.BackgroundColor3 = THEME.inner; MinBtn.Text = "-"; MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18; MinBtn.TextColor3 = THEME.text; MinBtn.ZIndex = 7; MinBtn.Parent = Header; corner(MinBtn, 8)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,32,0,32); CloseBtn.Position = UDim2.new(1,-40,0.5,-16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(66,22,36); CloseBtn.Text = "X"; CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14; CloseBtn.TextColor3 = THEME.text; CloseBtn.ZIndex = 7; CloseBtn.Parent = Header; corner(CloseBtn, 8)

do
	local dragging, dragStart, startPos
	Header.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = i.Position; startPos = Win.Position
			i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - dragStart
			Win.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
		end
	end)
end

local Rail = Instance.new("ScrollingFrame")
Rail.Size = UDim2.new(0,72,1,-52); Rail.Position = UDim2.new(0,0,0,52)
Rail.BackgroundColor3 = THEME.panel; Rail.BackgroundTransparency = 0.35; Rail.BorderSizePixel = 0
Rail.ScrollBarThickness = 2; Rail.CanvasSize = UDim2.new(0,0,0,0); Rail.AutomaticCanvasSize = Enum.AutomaticSize.Y
Rail.ZIndex = 5; Rail.Parent = Win
local RailList = Instance.new("UIListLayout"); RailList.Padding = UDim.new(0,6)
RailList.HorizontalAlignment = Enum.HorizontalAlignment.Center; RailList.Parent = Rail
local RailPad = Instance.new("UIPadding"); RailPad.PaddingTop = UDim.new(0,8); RailPad.Parent = Rail

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-84,1,-96); Content.Position = UDim2.new(0,78,0,56)
Content.BackgroundTransparency = 1; Content.ZIndex = 5; Content.Parent = Win
local PageTitle = Instance.new("TextLabel")
PageTitle.Size = UDim2.new(1,0,0,22); PageTitle.BackgroundTransparency = 1
PageTitle.Text = "Welcome"; PageTitle.Font = Enum.Font.GothamBold; PageTitle.TextSize = 16
PageTitle.TextColor3 = THEME.text; PageTitle.TextXAlignment = Enum.TextXAlignment.Left; PageTitle.ZIndex = 6; PageTitle.Parent = Content
local PageSub = Instance.new("TextLabel")
PageSub.Size = UDim2.new(1,0,0,16); PageSub.Position = UDim2.new(0,0,0,20)
PageSub.BackgroundTransparency = 1; PageSub.Text = "KHUB Blade Ball"; PageSub.Font = Enum.Font.Gotham
PageSub.TextSize = 12; PageSub.TextColor3 = THEME.dim; PageSub.TextXAlignment = Enum.TextXAlignment.Left; PageSub.ZIndex = 6; PageSub.Parent = Content
local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1,0,1,-44); Pages.Position = UDim2.new(0,0,0,42)
Pages.BackgroundTransparency = 1; Pages.ZIndex = 5; Pages.Parent = Content

local Tabs, ActiveId = {}, nil
local TAB_ICONS = {
	Welcome = "rbxassetid://10723407389",
	Combat = "rbxassetid://10734975692",
	Spam = "rbxassetid://10734920149",
	Detection = "rbxassetid://10723346959",
	Visual = "rbxassetid://10734941499",
	Misc = "rbxassetid://10709818534",
	World = "rbxassetid://10734950309",
	Unlock = "rbxassetid://6034503373",
	Settings = "rbxassetid://6031280882",
	Config = "rbxassetid://6031229361",
}

local function createPage(id)
	local sc = Instance.new("ScrollingFrame")
	sc.Name = id; sc.Size = UDim2.new(1,0,1,0); sc.BackgroundTransparency = 1
	sc.BorderSizePixel = 0; sc.ScrollBarThickness = 3; sc.ScrollBarImageColor3 = THEME.accent2
	sc.CanvasSize = UDim2.new(0,0,0,0); sc.AutomaticCanvasSize = Enum.AutomaticSize.Y
	sc.Visible = false; sc.ZIndex = 6; sc.Parent = Pages
	local lay = Instance.new("UIListLayout"); lay.Padding = UDim.new(0,8); lay.SortOrder = Enum.SortOrder.LayoutOrder; lay.Parent = sc
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0,4); pad.PaddingBottom = UDim.new(0,12)
	pad.PaddingLeft = UDim.new(0,4); pad.PaddingRight = UDim.new(0,8); pad.Parent = sc
	return sc
end

local function switchPage(id, title, subtitle)
	ActiveId = id
	PageTitle.Text = title or id
	PageSub.Text = subtitle or ""
	for _, pg in ipairs(Pages:GetChildren()) do
		if pg:IsA("ScrollingFrame") then pg.Visible = (pg.Name == id) end
	end
	for tid, btnRef in pairs(Tabs) do
		if typeof(btnRef) == "Instance" then
			local bar = btnRef:FindFirstChild("ActiveBar")
			local iconF = btnRef:FindFirstChild("IconFrame")
			local isActive = (tid == id)
			if bar then
				bar.BackgroundTransparency = isActive and 0 or 1
				bar.Size = isActive and UDim2.new(0,3,0.6,0) or UDim2.new(0,3,0.3,0)
			end
			if iconF then
				iconF.BackgroundColor3 = isActive and THEME.accent2 or Color3.fromRGB(24,30,60)
				local stroke = iconF:FindFirstChildOfClass("UIStroke")
				if stroke then stroke.Transparency = isActive and 0.1 or 0.5 end
			end
		end
	end
end

local function createTabButton(id, label, order, pageTitle, pageSub)
	local b = Instance.new("TextButton")
	b.Name = id; b.Size = UDim2.new(0,58,0,54); b.BackgroundTransparency = 1
	b.Text = ""; b.LayoutOrder = order; b.ZIndex = 8; b.Parent = Rail
	local iconFrame = Instance.new("Frame")
	iconFrame.Name = "IconFrame"; iconFrame.Size = UDim2.new(0,40,0,40)
	iconFrame.Position = UDim2.new(0.5,-20,0,4)
	iconFrame.BackgroundColor3 = Color3.fromRGB(24,30,60); iconFrame.BackgroundTransparency = 0.15
	iconFrame.ZIndex = 9; iconFrame.Parent = b; corner(iconFrame, 10); mkstroke(iconFrame, THEME.accent2, 1.2, 0.5)
	local icon = Instance.new("ImageLabel")
	icon.Size = UDim2.new(0,24,0,24); icon.Position = UDim2.new(0.5,-12,0.5,-12)
	icon.BackgroundTransparency = 1; icon.Image = TAB_ICONS[id] or TAB_ICONS.Welcome
	icon.ImageColor3 = Color3.new(1,1,1); icon.ScaleType = Enum.ScaleType.Fit; icon.ZIndex = 10; icon.Parent = iconFrame
	local activeBar = Instance.new("Frame")
	activeBar.Name = "ActiveBar"; activeBar.Size = UDim2.new(0,3,0.3,0)
	activeBar.Position = UDim2.new(1,-3,0.2,0); activeBar.BackgroundColor3 = THEME.white
	activeBar.BackgroundTransparency = 1; activeBar.BorderSizePixel = 0; activeBar.ZIndex = 11; activeBar.Parent = b
	corner(activeBar, 2)
	b.MouseButton1Click:Connect(function()
		TweenService:Create(iconFrame, TweenInfo.new(0.12, Enum.EasingStyle.Back), {Size=UDim2.new(0,44,0,44)}):Play()
		task.delay(0.12, function() TweenService:Create(iconFrame, TweenInfo.new(0.15), {Size=UDim2.new(0,40,0,40)}):Play() end)
		switchPage(id, pageTitle or label, pageSub or "")
	end)
	Tabs[id] = b
	return b
end

local function card(parent, title)
	local f = Instance.new("Frame")
	f.Size = UDim2.new(1,-4,0,0); f.AutomaticSize = Enum.AutomaticSize.Y
	f.BackgroundColor3 = THEME.card; f.BackgroundTransparency = 0.25; f.BorderSizePixel = 0; f.ZIndex = 7; f.Parent = parent
	corner(f, 12); mkstroke(f, THEME.stroke, 1, 0.5)
	local lay = Instance.new("UIListLayout"); lay.Padding = UDim.new(0,6); lay.SortOrder = Enum.SortOrder.LayoutOrder; lay.Parent = f
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0,10); pad.PaddingBottom = UDim.new(0,10)
	pad.PaddingLeft = UDim.new(0,10); pad.PaddingRight = UDim.new(0,10); pad.Parent = f
	if title then
		local t = Instance.new("TextLabel")
		t.Size = UDim2.new(1,0,0,18); t.BackgroundTransparency = 1; t.Text = title
		t.Font = Enum.Font.GothamBold; t.TextSize = 13; t.TextColor3 = THEME.gold
		t.TextXAlignment = Enum.TextXAlignment.Left; t.ZIndex = 8; t.Parent = f
	end
	return f
end

local function toggle(parent, text, get, set)
	local row = Instance.new("TextButton")
	row.Size = UDim2.new(1,0,0,30); row.BackgroundTransparency = 1; row.Text = ""; row.ZIndex = 8; row.Parent = parent
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,-54,1,0); lbl.BackgroundTransparency = 1; lbl.Text = text
	lbl.Font = Enum.Font.Gotham; lbl.TextSize = 13; lbl.TextColor3 = THEME.text
	lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 9; lbl.Parent = row
	local sw = Instance.new("Frame")
	sw.Size = UDim2.new(0,42,0,22); sw.Position = UDim2.new(1,-42,0.5,-11)
	sw.BackgroundColor3 = get() and THEME.green or THEME.off; sw.BorderSizePixel = 0; sw.ZIndex = 9; sw.Parent = row
	corner(sw, 11)
	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0,18,0,18); knob.Position = get() and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)
	knob.BackgroundColor3 = THEME.white; knob.ZIndex = 10; knob.Parent = sw; corner(knob, 9)
	row.MouseButton1Click:Connect(function()
		local v = not get(); set(v)
		sw.BackgroundColor3 = v and THEME.green or THEME.off
		TweenService:Create(knob, TweenInfo.new(0.15), {Position = v and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)}):Play()
	end)
end

local function btn(parent, text, callback, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,0,0,32); b.BackgroundColor3 = color or THEME.inner
	b.Text = text; b.Font = Enum.Font.GothamBold; b.TextSize = 13; b.TextColor3 = THEME.text
	b.BorderSizePixel = 0; b.ZIndex = 8; b.Parent = parent; corner(b, 8)
	b.MouseButton1Click:Connect(function() pcall(callback) end)
	return b
end

local function slider(parent, text, min, max, get, set)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1,0,0,44); row.BackgroundTransparency = 1; row.ZIndex = 8; row.Parent = parent
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,0,0,16); lbl.BackgroundTransparency = 1
	lbl.Text = text .. ": " .. tostring(get()); lbl.Font = Enum.Font.Gotham; lbl.TextSize = 12
	lbl.TextColor3 = THEME.dim; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 9; lbl.Parent = row
	local track = Instance.new("Frame")
	track.Size = UDim2.new(1,0,0,8); track.Position = UDim2.new(0,0,0,24)
	track.BackgroundColor3 = THEME.off; track.BorderSizePixel = 0; track.ZIndex = 9; track.Parent = row; corner(track, 4)
	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(math.clamp((get()-min)/(max-min),0,1),0,1,0)
	fill.BackgroundColor3 = THEME.accent; fill.BorderSizePixel = 0; fill.ZIndex = 10; fill.Parent = track; corner(fill, 4)
	local dragging = false
	local function apply(x)
		local rel = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
		local val = math.floor(min + (max - min) * rel + 0.5)
		set(val); lbl.Text = text .. ": " .. tostring(val)
		fill.Size = UDim2.new(rel, 0, 1, 0)
	end
	track.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true; apply(i.Position.X)
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			apply(i.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
end

-- Dropdown: click to open options, hide list when closed
local function dropdown(parent, title, options, get, set)
	local wrap = Instance.new("Frame")
	wrap.Size = UDim2.new(1,0,0,0); wrap.AutomaticSize = Enum.AutomaticSize.Y
	wrap.BackgroundTransparency = 1; wrap.ZIndex = 8; wrap.Parent = parent
	local lay = Instance.new("UIListLayout"); lay.Padding = UDim.new(0,4); lay.Parent = wrap
	local openBtn = Instance.new("TextButton")
	openBtn.Size = UDim2.new(1,0,0,30); openBtn.BackgroundColor3 = THEME.inner
	openBtn.Text = title .. ": " .. tostring(get()); openBtn.Font = Enum.Font.GothamBold
	openBtn.TextSize = 12; openBtn.TextColor3 = THEME.text; openBtn.BorderSizePixel = 0
	openBtn.ZIndex = 9; openBtn.Parent = wrap; corner(openBtn, 8)
	local list = Instance.new("Frame")
	list.Size = UDim2.new(1,0,0,0); list.AutomaticSize = Enum.AutomaticSize.Y
	list.BackgroundColor3 = THEME.panel; list.BorderSizePixel = 0; list.Visible = false
	list.ZIndex = 12; list.Parent = wrap; corner(list, 8)
	local listLay = Instance.new("UIListLayout"); listLay.Padding = UDim.new(0,2); listLay.Parent = list
	local listPad = Instance.new("UIPadding"); listPad.PaddingTop = UDim.new(0,4); listPad.PaddingBottom = UDim.new(0,4); listPad.Parent = list
	for _, opt in ipairs(options) do
		local ob = Instance.new("TextButton")
		ob.Size = UDim2.new(1,-8,0,26); ob.BackgroundColor3 = THEME.inner
		ob.Text = tostring(opt); ob.Font = Enum.Font.Gotham; ob.TextSize = 12
		ob.TextColor3 = THEME.text; ob.BorderSizePixel = 0; ob.ZIndex = 13; ob.Parent = list; corner(ob, 6)
		ob.MouseButton1Click:Connect(function()
			set(opt)
			openBtn.Text = title .. ": " .. tostring(opt)
			list.Visible = false
		end)
	end
	openBtn.MouseButton1Click:Connect(function()
		list.Visible = not list.Visible
	end)
end

-- Pages
local pWelcome = createPage("Welcome")
createTabButton("Welcome", "Welcome", 1, "Welcome", "KHUB Blade Ball")
do
	local c = card(pWelcome, "PROFILE")
	local nameL = Instance.new("TextLabel")
	nameL.Size = UDim2.new(1,0,0,20); nameL.BackgroundTransparency = 1
	nameL.Text = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")"
	nameL.Font = Enum.Font.GothamBold; nameL.TextSize = 14; nameL.TextColor3 = THEME.text
	nameL.TextXAlignment = Enum.TextXAlignment.Left; nameL.ZIndex = 8; nameL.Parent = c
	local c2 = card(pWelcome, "KHUB")
	local big = Instance.new("TextLabel")
	big.Size = UDim2.new(1,0,0,36); big.BackgroundTransparency = 1; big.Text = "KHUB"
	big.Font = Enum.Font.GothamBlack; big.TextSize = 32; big.TextColor3 = THEME.accent; big.ZIndex = 8; big.Parent = c2
	local moveTxt = Instance.new("TextLabel")
	moveTxt.Size = UDim2.new(1,0,0,18); moveTxt.BackgroundTransparency = 1
	moveTxt.Text = "Join Discord - Subscribe"; moveTxt.Font = Enum.Font.Gotham; moveTxt.TextSize = 12
	moveTxt.TextColor3 = THEME.dim; moveTxt.ZIndex = 8; moveTxt.Parent = c2
	local msgs = {"Join Discord", "Subscribe on my channel", "KHUB - Blade Ball", "Toggle: RightShift / K", "Auto Parry ready"}
	local mi = 1
	task.spawn(function()
		while moveTxt.Parent do moveTxt.Text = msgs[mi]; mi = mi % #msgs + 1; task.wait(2.5) end
	end)
	btn(c2, "Copy Discord", function() if setclipboard then setclipboard(DISCORD) end end, Color3.fromRGB(88,101,242))
	btn(c2, "Copy YouTube", function() if setclipboard then setclipboard(YOUTUBE) end end, Color3.fromRGB(200,40,40))
end

local pCombat = createPage("Combat")
createTabButton("Combat", "Combat", 2, "Combat", "Auto Parry - Curve - Trigger")
do
	local c = card(pCombat, "AUTO PARRY")
	toggle(c, "Auto Parry", function() return System.__properties.__autoparry_enabled end, function(v)
		System.__properties.__autoparry_enabled = v
		System.__properties.__play_animation = v
		if v then System.autoparry.start() else System.autoparry.stop() end
	end)
	dropdown(c, "Parry Mode", {"Remote", "Keypress"}, function() return S.AutoParryMode end, function(v)
		S.AutoParryMode = v; getgenv().AutoParryMode = v
	end)
	slider(c, "Accuracy", 1, 100, function() return System.__properties.__accuracy end, function(v)
		System.__properties.__accuracy = v; update_divisor()
	end)
	toggle(c, "Randomize Accuracy", function() return System.__properties.__randomized_accuracy_enabled end, function(v)
		System.__properties.__randomized_accuracy_enabled = v
	end)
	toggle(c, "Auto Ability", function() return S.AutoAbility end, function(v)
		S.AutoAbility = v; getgenv().AutoAbility = v
	end)
	local c2 = card(pCombat, "CURVE")
	dropdown(c2, "Curve Type", CURVE_NAMES, function() return S.CurveType end, function(v) S.CurveType = v end)
	toggle(c2, "Random Curve (cycle)", function() return S.RandomCurve end, function(v) S.RandomCurve = v end)
	local c3 = card(pCombat, "TRIGGERBOT")
	toggle(c3, "Triggerbot", function() return System.__triggerbot.__enabled end, function(v)
		System.triggerbot.enable(v)
	end)
	toggle(c3, "Show Trigger Button", function() return S.ShowTriggerBtn end, function(v)
		S.ShowTriggerBtn = v
		if v then
			if not ScreenGui:FindFirstChild("KHUB_TriggerBtn") then
				local g = makeFloatBtn("KHUB_TriggerBtn", "TRIGGER", UDim2.new(0.5, -50, 0.7, 0), function()
					local state = not System.__triggerbot.__enabled
					System.triggerbot.enable(state)
					notify("Trigger " .. (state and "ON" or "OFF"))
				end)
				g.Name = "KHUB_TriggerBtn"; g.Parent = ScreenGui
			end
		else
			local g = ScreenGui:FindFirstChild("KHUB_TriggerBtn"); if g then g:Destroy() end
		end
	end)
end

local pSpam = createPage("Spam")
createTabButton("Spam", "Spam", 3, "Spam", "Auto - Manual")
do
	local c = card(pSpam, "AUTO SPAM")
	toggle(c, "Auto Spam", function() return System.__properties.__auto_spam_enabled end, function(v)
		if v then System.auto_spam.start() else System.auto_spam.stop() end
	end)
	dropdown(c, "Spam Mode", {"Remote", "Keypress"}, function() return S.AutoSpamMode end, function(v)
		S.AutoSpamMode = v; getgenv().AutoSpamMode = v
	end)
	toggle(c, "Animation Fix", function() return S.AutoSpamAnimFix end, function(v) S.AutoSpamAnimFix = v end)
	local c2 = card(pSpam, "MANUAL SPAM")
	toggle(c2, "Manual Spam", function() return System.__properties.__manual_spam_enabled end, function(v)
		if v then System.manual_spam.start() else System.manual_spam.stop() end
	end)
	dropdown(c2, "Manual Mode", {"Remote", "Keypress"}, function() return S.ManualSpamMode end, function(v)
		S.ManualSpamMode = v; getgenv().ManualSpamMode = v
	end)
	toggle(c2, "Show Spam Button", function() return S.ShowSpamBtn end, function(v)
		S.ShowSpamBtn = v
		if v then
			if not ScreenGui:FindFirstChild("KHUB_SpamBtn") then
				local g = makeFloatBtn("KHUB_SpamBtn", "SPAM", UDim2.new(0.5, -50, 0.8, 0), function()
					local state = not System.__properties.__manual_spam_enabled
					if state then System.manual_spam.start() else System.manual_spam.stop() end
					notify("Manual Spam " .. (state and "ON" or "OFF"))
				end)
				g.Name = "KHUB_SpamBtn"; g.Parent = ScreenGui
			end
		else
			local g = ScreenGui:FindFirstChild("KHUB_SpamBtn"); if g then g:Destroy() end
			System.manual_spam.stop()
		end
	end)
end

local pDet = createPage("Detection")
createTabButton("Detection", "Detection", 4, "Detection", "Ability skips")
do
	local c = card(pDet, "ABILITY DETECTION")
	toggle(c, "Infinity", function() return System.__config.__detections.__infinity end, function(v) System.__config.__detections.__infinity = v end)
	toggle(c, "Death Slash", function() return System.__config.__detections.__deathslash end, function(v) System.__config.__detections.__deathslash = v end)
	toggle(c, "Time Hole", function() return System.__config.__detections.__timehole end, function(v) System.__config.__detections.__timehole = v end)
	toggle(c, "Slashes Of Fury", function() return System.__config.__detections.__slashesoffury end, function(v) System.__config.__detections.__slashesoffury = v end)
	toggle(c, "Phantom", function() return System.__config.__detections.__phantom end, function(v) System.__config.__detections.__phantom = v end)
end

local pVis = createPage("Visual")
createTabButton("Visual", "Visual", 5, "Visual", "ESP - Ball stats")
do
	local c = card(pVis, "ESP")
	toggle(c, "Ability ESP", function() return S.AbilityESP end, function(v)
		if v then startAbilityESP() else stopAbilityESP() end
	end)
	local c2 = card(pVis, "BALL")
	toggle(c2, "Ball Statistic", function() return S.BallStats end, function(v)
		S.BallStats = v
		if v then createBallStats() else destroyBallStats() end
	end)
end

local pMisc = createPage("Misc")
createTabButton("Misc", "Misc", 6, "Misc", "Character - FOV - Emotes")
do
	local c = card(pMisc, "NO RENDER")
	toggle(c, "No Render", function() return S.NoRender end, function(v) setNoRender(v) end)
	local c2 = card(pMisc, "FOV")
	toggle(c2, "Custom FOV", function() return S.FOVEnabled end, function(v)
		S.FOVEnabled = v
		if not v and Workspace.CurrentCamera then Workspace.CurrentCamera.FieldOfView = 70 end
	end)
	slider(c2, "FOV Value", 50, 120, function() return S.FOV end, function(v) S.FOV = v end)
	local c3 = card(pMisc, "CHARACTER")
	toggle(c3, "Character Mods", function() return S.CharacterMod end, function(v) S.CharacterMod = v end)
	toggle(c3, "Walk Speed", function() return S.EnableSpeed end, function(v) S.EnableSpeed = v end)
	slider(c3, "Walk Speed Value", 16, 200, function() return S.WalkSpeed end, function(v) S.WalkSpeed = v end)
	toggle(c3, "Jump Power", function() return S.EnableJump end, function(v) S.EnableJump = v end)
	slider(c3, "Jump Power Value", 50, 200, function() return S.JumpPower end, function(v) S.JumpPower = v end)
	toggle(c3, "Infinite Jump", function() return S.InfJump end, function(v) S.InfJump = v end)
	toggle(c3, "Spin", function() return S.Spin end, function(v) S.Spin = v end)
	slider(c3, "Spin Speed", 1, 50, function() return S.SpinSpeed end, function(v) S.SpinSpeed = v end)
	toggle(c3, "Gravity", function() return S.EnableGravity end, function(v)
		S.EnableGravity = v; if not v then Workspace.Gravity = 196.2 end
	end)
	slider(c3, "Gravity Value", 0, 400, function() return math.floor(S.Gravity) end, function(v) S.Gravity = v end)
	toggle(c3, "Hip Height", function() return S.EnableHip end, function(v) S.EnableHip = v end)
	slider(c3, "Hip Height Value", -5, 20, function() return S.HipHeight end, function(v) S.HipHeight = v end)
	local c4 = card(pMisc, "EMOTES")
	toggle(c4, "Emotes", function() return S.Emotes end, function(v)
		S.Emotes = v
		if v and S.SelectedEmote ~= "" then animation_system.play(S.SelectedEmote)
		elseif not v then animation_system.stop() end
	end)
	toggle(c4, "Auto Stop when moving", function() return S.AutoStopEmote end, function(v) S.AutoStopEmote = v end)
	if #emotes_data > 0 then
		dropdown(c4, "Emote", emotes_data, function() return S.SelectedEmote ~= "" and S.SelectedEmote or emotes_data[1] end, function(v)
			S.SelectedEmote = v
			if S.Emotes then animation_system.play(v) end
		end)
		S.SelectedEmote = emotes_data[1]
	end
end

local pWorld = createPage("World")
createTabButton("World", "World", 7, "World", "Sky presets")
do
	local c = card(pWorld, "SKY CHANGER")
	local names = {}
	for _, p in ipairs(WorldPresets) do table.insert(names, p.Name) end
	toggle(c, "Sky Changer", function() return S.SkyEnabled end, function(v)
		S.SkyEnabled = v
		if v then
			for _, p in ipairs(WorldPresets) do
				if p.Name == S.SkyPreset then ApplyWorld(p); break end
			end
		else ClearWorld() end
	end)
	dropdown(c, "Preset", names, function() return S.SkyPreset end, function(v)
		S.SkyPreset = v
		if S.SkyEnabled then
			for _, p in ipairs(WorldPresets) do if p.Name == v then ApplyWorld(p); break end end
		end
	end)
	local c2 = card(pWorld, "IMMORTAL")
	toggle(c2, "Immortal (Orbit Desync)", function() return S.Immortal end, function(v)
		S.Immortal = v
		if v then startImmortal() else stopImmortal() end
	end)
end

local pUnlock = createPage("Unlock")
createTabButton("Unlock", "Unlock", 8, "Unlock", "Skins - names")
do
	local c = card(pUnlock, "SKIN CHANGER")
	local swordBox = Instance.new("TextBox")
	swordBox.Size = UDim2.new(1,0,0,30); swordBox.BackgroundColor3 = THEME.inner
	swordBox.PlaceholderText = "Sword name..."; swordBox.Text = tostring(getgenv().swordModel or "")
	swordBox.Font = Enum.Font.Gotham; swordBox.TextSize = 13; swordBox.TextColor3 = THEME.text
	swordBox.ClearTextOnFocus = false; swordBox.BorderSizePixel = 0; swordBox.ZIndex = 8; swordBox.Parent = c; corner(swordBox, 8)
	toggle(c, "Enable Skin Changer", function() return getgenv().skinChanger == true end, function(v)
		getgenv().skinChanger = v
		if v and swordBox.Text ~= "" then
			getgenv().swordModel = swordBox.Text
			getgenv().swordAnimations = swordBox.Text
			getgenv().swordFX = swordBox.Text
		end
	end)
	btn(c, "Apply Sword Name", function()
		local t = swordBox.Text
		getgenv().swordModel = t; getgenv().swordAnimations = t; getgenv().swordFX = t
		getgenv().skinChanger = true
		notify("Sword set: " .. t)
	end, THEME.green)
	local expBox = Instance.new("TextBox")
	expBox.Size = UDim2.new(1,0,0,30); expBox.BackgroundColor3 = THEME.inner
	expBox.PlaceholderText = "Explosion name..."; expBox.Text = tostring(getgenv().explosionFX or "")
	expBox.Font = Enum.Font.Gotham; expBox.TextSize = 13; expBox.TextColor3 = THEME.text
	expBox.ClearTextOnFocus = false; expBox.BorderSizePixel = 0; expBox.ZIndex = 8; expBox.Parent = c; corner(expBox, 8)
	btn(c, "Apply Explosion", function()
		getgenv().explosionFX = expBox.Text; getgenv().explosionChanger = true
		notify("Explosion set: " .. expBox.Text)
	end, THEME.accent)
	local c2 = card(pUnlock, "NOTE")
	local note = Instance.new("TextLabel")
	note.Size = UDim2.new(1,0,0,48); note.BackgroundTransparency = 1
	note.Text = "Full shop unlock / emote wheel from Kittylol needs their unlock backend. Skin names still apply via getgenv."
	note.Font = Enum.Font.Gotham; note.TextSize = 11; note.TextColor3 = THEME.dim
	note.TextWrapped = true; note.TextXAlignment = Enum.TextXAlignment.Left; note.ZIndex = 8; note.Parent = c2
end

local pSettings = createPage("Settings")
createTabButton("Settings", "Settings", 9, "Settings", "Keybinds")
do
	local c = card(pSettings, "KEYBINDS")
	local info = Instance.new("TextLabel")
	info.Size = UDim2.new(1,0,0,60); info.BackgroundTransparency = 1
	info.Text = "UI Toggle: RightShift / RightCtrl / K\nAuto Parry: enable in Combat tab\nManual Spam: floating SPAM button or toggle"
	info.Font = Enum.Font.Gotham; info.TextSize = 12; info.TextColor3 = THEME.dim
	info.TextXAlignment = Enum.TextXAlignment.Left; info.TextYAlignment = Enum.TextYAlignment.Top
	info.TextWrapped = true; info.ZIndex = 8; info.Parent = c
end

local pConfig = createPage("Config")
createTabButton("Config", "Config", 99, "Save Config", "Create - Load")
do
	local c = card(pConfig, "CONFIG")
	local nameBox = Instance.new("TextBox")
	nameBox.Size = UDim2.new(1,0,0,30); nameBox.BackgroundColor3 = THEME.inner
	nameBox.PlaceholderText = "Config name..."; nameBox.Text = "default"
	nameBox.Font = Enum.Font.Gotham; nameBox.TextSize = 13; nameBox.TextColor3 = THEME.text
	nameBox.ClearTextOnFocus = false; nameBox.BorderSizePixel = 0; nameBox.ZIndex = 8; nameBox.Parent = c; corner(nameBox, 8)
	local function collect()
		return {
			accuracy = System.__properties.__accuracy,
			curve = S.CurveType,
			parryMode = S.AutoParryMode,
			fov = S.FOV,
			walk = S.WalkSpeed,
			jump = S.JumpPower,
		}
	end
	local function apply(data)
		if type(data) ~= "table" then return end
		if data.accuracy then System.__properties.__accuracy = data.accuracy; update_divisor() end
		if data.curve then S.CurveType = data.curve end
		if data.parryMode then S.AutoParryMode = data.parryMode end
		if data.fov then S.FOV = data.fov end
		if data.walk then S.WalkSpeed = data.walk end
		if data.jump then S.JumpPower = data.jump end
	end
	btn(c, "Save Config", function()
		local name = nameBox.Text ~= "" and nameBox.Text or "default"
		pcall(function()
			if not isfolder then return end
			if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end
			writefile(ConfigFolder .. "/" .. name .. ".json", HttpService:JSONEncode(collect()))
			notify("Saved " .. name)
		end)
	end, THEME.green)
	btn(c, "Load Config", function()
		local name = nameBox.Text ~= "" and nameBox.Text or "default"
		pcall(function()
			local path = ConfigFolder .. "/" .. name .. ".json"
			if isfile and isfile(path) then
				apply(HttpService:JSONDecode(readfile(path)))
				notify("Loaded " .. name)
			else notify("Config not found") end
		end)
	end, THEME.accent)
end

-- Orb
local OrbRoot = Instance.new("Frame")
OrbRoot.Size = UDim2.new(0,64,0,64); OrbRoot.Position = UDim2.new(0, 16, 0.5, -32)
OrbRoot.BackgroundTransparency = 1; OrbRoot.Visible = false; OrbRoot.ZIndex = 50; OrbRoot.Parent = ScreenGui
local Orb = Instance.new("ImageButton")
Orb.Size = UDim2.new(1,0,1,0); Orb.BackgroundColor3 = THEME.panel; Orb.Image = LOGO_ID
Orb.BorderSizePixel = 0; Orb.ZIndex = 51; Orb.Parent = OrbRoot; corner(Orb, 32)
mkstroke(Orb, THEME.accent, 2, 0.2)
do
	local draggingOrb, dragStartOrb, startPosOrb
	Orb.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingOrb = true; dragStartOrb = input.Position; startPosOrb = OrbRoot.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then draggingOrb = false end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if draggingOrb and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStartOrb
			OrbRoot.Position = UDim2.new(startPosOrb.X.Scale, startPosOrb.X.Offset+delta.X, startPosOrb.Y.Scale, startPosOrb.Y.Offset+delta.Y)
		end
	end)
end

local function setVisible(on)
	if on then
		Win.Visible = true; OrbRoot.Visible = false
		Win.Position = UDim2.new(0.5, -BASE_W/2, 0.5, -BASE_H/2)
		TweenService:Create(Win, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, BASE_W, 0, BASE_H),
		}):Play()
	else
		Win.Visible = false; OrbRoot.Visible = true
	end
end
MinBtn.MouseButton1Click:Connect(function() setVisible(false) end)
CloseBtn.MouseButton1Click:Connect(function() setVisible(false) end)
Orb.MouseButton1Click:Connect(function() setVisible(true) end)

UserInputService.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.RightShift or i.KeyCode == Enum.KeyCode.RightControl or i.KeyCode == Enum.KeyCode.K then
		setVisible(not Win.Visible)
	end
end)

task.delay(1.7, function() switchPage("Welcome", "Welcome", "KHUB - Blade Ball") end)
print("[KHUB] Blade Ball loaded - Kittylol systems + KHUB UI")
print("[KHUB] Toggle: RightShift / RightCtrl / K")
