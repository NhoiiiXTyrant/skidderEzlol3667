--[[
	redz Hub - Meme Sea (cleaned source)

	Rebuilt from the deobfuscated dump (redz.txt):
	  * removed the loader's "blacklist" self-destruct module and its disk flag
	  * removed the obfuscator's per-module singleton cache wrappers, so every
	    module is a plain lazily-created table with a readable name
	  * inlined the HTTP fetcher (the old code read
	    "memeSea/http-fetcher.luau" from the executor workspace and crashed if
	    the file was missing)
	  * fixed the "{Owner}" placeholder, so the UI library loads from
	    tlredz/Library again and the menu is built
	  * menu tabs, layout and every feature from the original are kept

	Executor requirements: HttpGet, loadstring, getgenv, getconnections,
	sethiddenproperty, setupvalue, cloneref. Optional: readfile/writefile/isfile
	(used only to cache the UI library between runs).
]]

local function lazy(factory)
	local value
	return function()
		if value == nil then
			value = factory()
		end
		return value
	end
end

local state,
	environment,
	discordInvite,
	settings,
	gameData,
	skipLoadingScreen,
	remotes,
	entities,
	inventory,
	combat,
	playerApi,
	playerData,
	quests,
	monsterData,
	farming,
	raids,
	requirements,
	raidFarm,
	bossFarm,
	weaponShop,
	raceFarm,
	gameSettings,
	shopItems,
	gamepasses,
	shop,
	oneClick,
	unlocks,
	tasks,
	oneClickTask,
	floppaSwordTask,
	memeBeastTask,
	lordSusTask,
	evilNoobTask,
	giantPumpkinTask,
	raceV2Task,
	ballerUnlockTask,
	weaponsUnlockTask,
	questLimitTask,
	gamepassesTask,
	levelFarmTask,
	raidFarmTask,
	selectedEnemyTask,
	nearestFarmTask,
	taskList,
	antiAfk,
	startupPatches,
	uiConfig,
	localeEN,
	localePT,
	localeES,
	localeFR,
	locale,
	ui,
	farmTab,
	itemsTab,
	codes,
	gacha,
	powersTab,
	statsTab,
	teleportTab,
	shopTab,
	pvpState,
	bounty,
	esp,
	pvpTab,
	oneClickTab,
	owner,
	miscTab,
	buildMenu,
	farmLoop


-- === state: shared runtime state (fetcher + UI library handles) ===
state = lazy(function()
	return { ["fetcher"] = nil, ["library"] = nil }
end)


-- === environment: services and executor globals ===
environment = lazy(function()
	local m3_L1, m3_r1, m3_r2, m3_r3, m3_r4
	m3_L1 = (game:GetService("Players"))
	m3_r1 = {
		localizationService = game:GetService("LocalizationService"),
		replicatedStorage = game:GetService("ReplicatedStorage"),
		teleportService = game:GetService("TeleportService"),
		virtualUser = game:GetService("VirtualUser"),
		httpService = game:GetService("HttpService"),
		runService = game:GetService("RunService"),
		coreGui = game:GetService("CoreGui"),
		virtualInputManager = game:GetService("VirtualInputManager"),
		players = m3_L1,
		localPlayer = m3_L1.LocalPlayer,
		insert = table.insert,
		spawn = task.spawn,
		wait = task.wait,
		huge = math.huge,
		newCFrame = CFrame.new,
		newCFrameAngles = CFrame.Angles,
		newVector3 = Vector3.new,
		environment = getgenv(),
	}
	m3_r2 = "setHiddenProperty"
	m3_r4 = sethiddenproperty
	m3_r3 = m3_r4
	if not m3_r4 then
		m3_r3 = function() end
	end
	m3_r1[m3_r2] = m3_r3
	return m3_r1
end)


-- === discordInvite: community invite shown on the Discord tab ===
discordInvite = lazy(function()
	return "https://discord.gg/aXWW8hytgX"
end)


-- === settings: persisted hub settings and their defaults ===
settings = lazy(function()
	local m8_L1, m8_L2, m8_r1, m8_r2, m8_r3, m8_r4
	m8_L1 = (environment())
	m8_r2 = m8_L1.environment.hubSettings
	m8_r1 = m8_r2
		or {
			statsPoints = 3,
			bringMobs = true,
			farmDistance = 9,
			viewHitbox = false,
			antiAfk = true,
			autoHaki = true,
			autoClick = true,
			toolFarm = "Fight",
			skillsSelected = {},
		}
	m8_L2 = m8_r1
	m8_r1 = m8_L2
	m8_r2 = "popcatClicksPerSecond"
	m8_r4 = m8_L2.popcatClicksPerSecond
	m8_r3 = m8_r4 or 10
	m8_r1[m8_r2] = m8_r3
	m8_r1 = m8_L2
	m8_r2 = "gachaAmount"
	m8_r4 = m8_L2.gachaAmount
	m8_r3 = m8_r4 or 1
	m8_r1[m8_r2] = m8_r3
	m8_r1 = m8_L2
	m8_r2 = "rerollPowerMethod"
	m8_r4 = m8_L2.rerollPowerMethod
	m8_r3 = m8_r4 or "Money"
	m8_r1[m8_r2] = m8_r3
	m8_r1 = m8_L2
	m8_r2 = "language"
	m8_r4 = m8_L2.language
	m8_r3 = m8_r4 or "auto"
	m8_r1[m8_r2] = m8_r3
	m8_r1 = m8_L2
	m8_r2 = "skillsSelected"
	m8_r4 = m8_L2.skillsSelected
	m8_r3 = m8_r4 or {}
	m8_r1[m8_r2] = m8_r3
	m8_L2.farmCFrame = (
		m8_L1.newCFrame(0, m8_L2.farmDistance, 0) * m8_L1.newCFrameAngles(math.rad(-90), 0, 0)
	)
	return m8_L2
end)


-- === gameData: game folders, modules and quest settings ===
gameData = lazy(function()
	local m9_L1, m9_L2, m9_L3, m9_L4, m9_L5, m9_L6, m9_L7, m9_r1, m9_r3
	m9_L1 = (environment())
	m9_L2 = m9_L1.replicatedStorage
	m9_L3 = m9_L1.localPlayer
	m9_L4 = (m9_L2:WaitForChild("ModuleScript"))
	m9_L5 = (workspace:WaitForChild("Location"))
	m9_L6 = (workspace:WaitForChild("NPCs"))
	m9_L7 = (m9_L3:WaitForChild("PlayerData"))
	m9_r1 = {
		monsters = {
			replicated = m9_L2:WaitForChild("MonsterSpawn"),
			inWorkspace = workspace:WaitForChild("Monster"),
		},
		gameModules = m9_L4,
		npcStorage = m9_L2:WaitForChild("NPC_Storage"),
		otherEvent = m9_L2:WaitForChild("OtherEvent"),
		characters = workspace:WaitForChild("Character"),
		location = m9_L5,
		region = workspace:WaitForChild("Region"),
		island = workspace:WaitForChild("Island"),
		raids = workspace:WaitForChild("Raids"),
		npcs = m9_L6,
		enemyLocation = m9_L5:WaitForChild("Enemy_Location"),
		questLocation = m9_L5:WaitForChild("QuestLocaion"),
		questNpcs = m9_L6:WaitForChild("Quests_Npc"),
		questFolder = m9_L3:WaitForChild("QuestFolder"),
		playerDataFolder = m9_L7,
		playerLevel = m9_L7:WaitForChild("Level"),
		abilityFolder = m9_L3:WaitForChild("Ability"),
		itemFolder = m9_L3:WaitForChild("Items"),
		gamepassFolder = m9_L3:WaitForChild("PlayerSpecial"),
		cooldownFolder = m9_L3:WaitForChild("Cooldown"),
	}
	m9_r3 = require(m9_L4:WaitForChild("Quest_Settings"))
	m9_r1.questSettings = m9_r3
	m9_r3 = require(m9_L4:WaitForChild("Setting"))
	m9_r1.gameSetting = m9_r3
	return m9_r1
end)


-- === skipLoadingScreen: skips the MemeSea loading screen ===
skipLoadingScreen = lazy(function()
	local m11_L1
	m11_L1 = (environment())
	do
		return function()
			xpcall(function()
				local m11_1_1_L1
				m11_1_1_L1 = m11_L1.localPlayer.PlayerGui.LoadingGui
				if m11_1_1_L1.Enabled then
					(getconnections(m11_1_1_L1.PlayBackground.Cheem.Select.Activated))[1].Function();
					(getconnections(m11_1_1_L1.PlayBackground.Play.Activated))[1].Function()
					m11_L1.wait(1)
				end
			end, function(...)
				print("!ERROR! Erro ao entrar no [ TIME ]: ", ...)
			end)
		end
	end
end)


-- === remotes: RemoteEvent / RemoteFunction access ===
remotes = lazy(function()
	local m12_L1, m12_L2, m12_L3, m12_L4
	m12_L1 = (gameData())
	m12_L2 = {
		modules = { "MainEvents", "Modules" },
		ability = { "MainEvents", "Ability" },
		code = { "MainEvents", "Code" },
		statsFunction = { "MainEvents", "StatsFunction" },
		startRaid = { "MiscEvents", "StartRaid" },
		updateInventory = { "ItemEvents", "UpdateInventory" },
		buyProduct = { "BuyEvents", "BuyProduct" },
		quest = { "QuestEvents", "Quest" },
		serverHitbox = { "SkillEvents", "Server_Hitbox" },
		serverSkills = { "SkillEvents", "Server_Skills" },
	}
	m12_L3 = {}
	m12_L4 = function(m12_1_L1)
		local m12_1_L2, m12_1_L3, m12_1_L4
		m12_1_L2 = m12_L1.otherEvent
		for m12_1_L3, m12_1_L4 in ipairs(m12_L2[m12_1_L1]) do
			m12_1_L2 = m12_1_L2[m12_1_L4]
		end
		return m12_1_L2
	end
	m12_L3.fire = function(m12_2_L1, ...)
		local m12_2_r1
		m12_2_r1 = { m12_L4(m12_2_L1):FireServer(...) }
		return unpack(m12_2_r1)
	end
	m12_L3.invoke = function(m12_3_L1, ...)
		local m12_3_r1
		m12_3_r1 = { m12_L4(m12_3_L1):InvokeServer(...) }
		return unpack(m12_3_r1)
	end
	return m12_L3
end)


-- === entities: entity helpers (alive checks, enemies, teleport) ===
entities = lazy(function()
	local m16_L1, m16_L2, m16_L3, m16_L4, m16_L5, m16_L6, m16_L7
	m16_L1 = (environment())
	m16_L2 = (gameData())
	m16_L3 = m16_L1.players
	m16_L4 = m16_L1.localPlayer
	m16_L5 = m16_L1.insert
	m16_L6 = m16_L2.monsters
	m16_L7 = {}
	m16_L7.isAlive = function(m16_1_L1)
		local m16_1_L2, m16_1_r1, m16_1_r2
		m16_1_r2 = m16_1_L1
		m16_1_r1 = m16_1_r2 and (m16_1_L1:FindFirstChild("Humanoid"))
		m16_1_L2 = m16_1_r1
		m16_1_r2 = m16_1_L2
		m16_1_r1 = m16_1_r2 and (m16_1_L2.Health > 0)
		return m16_1_r1
	end
	m16_L7.isSpawnedEnemy = function(m16_2_L1)
		local m16_2_r1, m16_2_r2
		m16_2_r2 = (m16_2_L1 ~= nil)
		m16_2_r1 = m16_2_r2
		if m16_2_r2 then
			m16_2_r2 = (m16_2_L1.Parent == m16_L6.inWorkspace)
			m16_2_r1 = m16_2_r2
			if m16_2_r2 then
				m16_2_r2 = (m16_2_L1.PrimaryPart ~= nil)
				m16_2_r1 = m16_2_r2 and (m16_L7.isAlive(m16_2_L1) == true)
				m16_2_r1 = m16_2_r1
			end
			m16_2_r1 = m16_2_r1
		end
		return m16_2_r1
	end
	m16_L7.getEnemy = function(m16_3_L1)
		local m16_3_L2, m16_3_L3, m16_3_r1, m16_3_r2, m16_3_r3
		for m16_3_L2, m16_3_L3 in ipairs(m16_L6.inWorkspace:GetChildren()) do
			m16_3_r3 = not m16_3_L1
			m16_3_r2 = m16_3_r3 or (m16_3_L3.Name == m16_3_L1)
			m16_3_r3 = m16_3_r2 and (m16_L7.isSpawnedEnemy(m16_3_L3))
			if m16_3_r3 then
				return m16_3_L3
			else
			end
		end
		return false
	end
	m16_L7.standUp = function(m16_4_L1)
		local m16_4_L2, m16_4_L3, m16_4_r1, m16_4_r2
		m16_4_r2 = m16_4_L1
		m16_4_r1 = m16_4_r2 or m16_L4.Character
		m16_4_L1 = m16_4_r1
		m16_4_r2 = m16_4_L1
		m16_4_r1 = m16_4_r2 and (m16_4_L1:FindFirstChild("Humanoid"))
		m16_4_L2 = m16_4_r1
		if not m16_4_L2 then
			return false
		else
			m16_4_r2 = m16_4_L2.Sit
			m16_4_r1 = m16_4_r2 or m16_4_L2.SeatPart
			if m16_4_r1 then
				m16_4_L2.Sit = false
				m16_4_L2:ChangeState(Enum.HumanoidStateType.GettingUp)
				m16_4_L3 = (os.clock() + 1)
				repeat
					m16_L1.runService.Heartbeat:Wait()
					m16_4_r2 = not m16_4_L2.SeatPart
					m16_4_r1 = m16_4_r2
					if not m16_4_r2 then
						m16_4_r2 = (os.clock() >= m16_4_L3)
						m16_4_r1 = m16_4_r2 or not m16_4_L1.Parent
						m16_4_r1 = m16_4_r1
					end
				until m16_4_r1
				m16_4_r2 = (m16_4_L1.Parent ~= nil)
				m16_4_r1 = m16_4_r2
				if m16_4_r2 then
					m16_4_r2 = not m16_4_L2.Sit
					m16_4_r1 = m16_4_r2 and (m16_4_L2.SeatPart == nil)
					m16_4_r1 = m16_4_r1
				end
				return m16_4_r1
			else
				return true
			end
		end
	end
	m16_L7.goTo = function(m16_5_L1, m16_5_L2)
		local m16_5_L3, m16_5_r1, m16_5_r2
		if not m16_5_L1 then
			return false
		else
			m16_5_L3 = m16_L4.Character
			if not m16_L7.isAlive(m16_5_L3) then
				return false
			else
				if m16_5_L2 then
					return m16_5_L3:MoveTo(m16_5_L1.Position)
				else
					if not m16_L7.standUp(m16_5_L3) then
						return false
					else
						m16_5_r2 = (m16_L4.Character ~= m16_5_L3)
						m16_5_r1 = m16_5_r2 or (not m16_L7.isAlive(m16_5_L3))
						if m16_5_r1 then
							return false
						else
							return m16_5_L3:PivotTo(m16_5_L1)
						end
					end
				end
			end
		end
	end
	m16_L7.getNearestList = function(m16_6_L1)
		local m16_6_L2, m16_6_L3, m16_6_L4, m16_6_L5, m16_6_L6, m16_6_r1, m16_6_r2, m16_6_r3
		m16_6_L2 = {}
		for m16_6_L3, m16_6_L4 in ipairs(m16_L3:GetPlayers()) do
			m16_6_L5 = m16_6_L4.Character
			m16_6_r3 = (m16_6_L4 ~= m16_L4)
			m16_6_r2 = m16_6_r3 and (m16_L7.isAlive(m16_6_L5))
			if m16_6_r2 then
				m16_6_L6 = m16_6_L5.PrimaryPart
				m16_6_r3 = m16_6_L6
				m16_6_r2 = m16_6_r3 and (m16_L4:DistanceFromCharacter(m16_6_L6.Position) <= m16_6_L1)
				if m16_6_r2 then
					m16_L5(m16_6_L2, m16_6_L5)
				else
				end
			end
		end
		return m16_6_L2
	end
	return m16_L7
end)


-- === inventory: inventory checks and equipment helpers ===
inventory = lazy(function()
	local m25_L1, m25_L2, m25_L3, m25_L4, m25_L5, m25_L6, m25_L7, m25_L8, m25_L9, m25_r1
	m25_L1 = (gameData())
	m25_L2 = (remotes())
	m25_L3 = m25_L1.itemFolder
	m25_L4 = m25_L1.abilityFolder
	m25_L5 = m25_L1.gamepassFolder
	m25_L6 = m25_L1.playerDataFolder
	m25_L7 = {}
	m25_L7.folders = {}
	m25_L7.accessories = {
		"Nah, I'd Win.",
		"Sus Pals",
		"Noob Friend",
		"Pumpkin Head",
		"Moai Face",
		"Egg Doge",
		"Floppa Hat",
	}
	m25_L7.swords = { "Purple Katana", "Yellow Blade", "Popcat", "Pumpkin", "Floppa", "Portal", "Katana" }
	for m25_L8, m25_L9 in ipairs(m25_L3:GetChildren()) do
		m25_L7.folders[m25_L9.Name] = m25_L9
	end
	m25_L7.getMaterial = function(m25_1_L1, m25_1_L2)
		local m25_1_L3, m25_1_r1, m25_1_r2
		m25_1_r2 = m25_1_L1.folders.ItemStorage
		m25_1_r1 = m25_1_r2 and (m25_1_L1.folders.ItemStorage:FindFirstChild(m25_1_L2))
		m25_1_L3 = m25_1_r1
		m25_1_r2 = m25_1_L3
		m25_1_r1 = m25_1_r2 and m25_1_L3.Value
		m25_1_r2 = m25_1_r1 or 0
		return m25_1_r2
	end
	m25_L7.verifySword = function(m25_2_L1, m25_2_L2)
		return (m25_2_L1.folders.Weapon[m25_2_L2].Value > 0)
	end
	m25_L7.verifyAccessory = function(m25_3_L1, m25_3_L2)
		return (m25_3_L1.folders.Accessory[m25_3_L2].Value > 0)
	end
	m25_L7.verifyFightStyle = function(m25_4_L1, m25_4_L2)
		return (m25_4_L1.folders.FightingStyle[m25_4_L2].Value == true)
	end
	m25_L7.verifyAbility = function(m25_5_L1, m25_5_L2)
		local m25_5_r1, m25_5_r2
		m25_5_r2 = m25_L4:FindFirstChild(m25_5_L2)
		m25_5_r1 = m25_5_r2 and m25_L4[m25_5_L2].Value
		return m25_5_r1
	end
	m25_L7.verifyGamepass = function(m25_6_L1, m25_6_L2)
		return m25_L5[m25_6_L2].Value
	end
	m25_L7.getUnlocked = function(m25_7_L1)
		local m25_7_L2, m25_7_L3, m25_7_L4, m25_7_L5, m25_7_L6, m25_7_r1
		m25_7_L2 = {}
		for m25_7_L3, m25_7_L4 in ipairs(m25_7_L1.folders.Weapon:GetChildren()) do
			m25_7_L2[m25_7_L4.Name] = (m25_7_L4.Value > 0)
		end
		for m25_7_L5, m25_7_L6 in ipairs(m25_7_L1.folders.Accessory:GetChildren()) do
			m25_7_L2[m25_7_L6.Name] = (m25_7_L6.Value > 0)
		end
		return m25_7_L2
	end
	m25_L7.canRerollAura = function(m25_8_L1)
		local m25_8_L2, m25_8_L3, m25_8_r1
		for m25_8_L2, m25_8_L3 in ipairs(m25_8_L1.folders.AuraColor:GetChildren()) do
			if not m25_8_L3.Value then
				return true
			else
			end
		end
		return false
	end
	m25_L7.canStorePower = function(m25_9_L1, m25_9_L2)
		local m25_9_L3, m25_9_r1, m25_9_r2
		m25_9_L3 = (m25_L3.Power:FindFirstChild(m25_9_L2))
		m25_9_r2 = m25_9_L3
		m25_9_r1 = m25_9_r2 and (m25_9_L3.Value < 99)
		return m25_9_r1
	end
	m25_L7.equipSword = function(m25_10_L1)
		local m25_10_L2, m25_10_L3
		for m25_10_L2, m25_10_L3 in ipairs(m25_10_L1.swords) do
			if m25_10_L1.folders.Weapon[m25_10_L3].Value > 0 then
				if m25_L6.SwordEquip.Value ~= m25_10_L3 then
					m25_L2.invoke("updateInventory", "Weapon", { SelectedItem = m25_10_L3 })
				end
				return
			else
			end
		end
	end
	m25_L7.equipAccessory = function(m25_11_L1)
		local m25_11_L2, m25_11_L3
		for m25_11_L2, m25_11_L3 in ipairs(m25_11_L1.accessories) do
			if m25_11_L1.folders.Accessory[m25_11_L3].Value > 0 then
				if m25_L6.AccessoryEquip.Value ~= m25_11_L3 then
					m25_L2.invoke("updateInventory", "Accessory", { SelectedItem = m25_11_L3 })
				end
				return
			else
			end
		end
	end
	return m25_L7
end)


-- === combat: basic attack / skill helpers ===
combat = lazy(function()
	local m26_L1, m26_L2, m26_L3, m26_L4, m26_L5, m26_L6, m26_L7, m26_L8, m26_L9, m26_L10, m26_L11, m26_L12, m26_L13
	m26_L1 = (environment())
	m26_L2 = (gameData())
	m26_L3 = (entities())
	m26_L4 = (remotes())
	m26_L5 = m26_L1.localPlayer
	m26_L6 = m26_L2.monsters.inWorkspace
	m26_L7 = {}
	m26_L8 = {
		Popcat = "Z",
		Baller = "V",
		["Paw Power"] = "X",
		["Snow Power"] = "V",
		["Sand Power"] = "Z",
		["Water Power"] = "X",
	}
	m26_L9 = 50
	m26_L10 = -9000000000
	m26_L11 = m26_L10
	m26_L12 = nil
	m26_L13 = function()
		local m26_1_L1, m26_1_r1, m26_1_r2
		m26_1_L1 = (os.clock())
		m26_1_r2 = not m26_L12
		m26_1_r1 = m26_1_r2 or ((m26_1_L1 - m26_L12) > 60)
		if m26_1_r1 then
			m26_L12 = m26_1_L1
			m26_L11 = m26_L10
		end
		m26_L11 = (m26_L11 + 1)
		return m26_L11
	end
	m26_L7.attack = function(m26_2_L1)
		local m26_2_L2, m26_2_L3, m26_2_L4, m26_2_L5, m26_2_L6, m26_2_L7, m26_2_L8, m26_2_L9, m26_2_L10, m26_2_L11, m26_2_r1, m26_2_r2, m26_2_r3
		m26_2_r2 = not m26_L1.environment.infiniteDamage
		m26_2_r1 = m26_2_r2 or (not m26_L3.isSpawnedEnemy(m26_2_L1))
		if m26_2_r1 then
			return false
		else
			m26_2_L2 = m26_L5.Character
			if not m26_L3.isAlive(m26_2_L2) then
				return false
			else
				m26_2_r2 = m26_2_L2:FindFirstChild("HumanoidRootPart")
				m26_2_r1 = m26_2_r2 or m26_2_L2.PrimaryPart
				m26_2_L3 = m26_2_r1
				m26_2_L4 = (m26_2_L2:FindFirstChildOfClass("Tool"))
				m26_2_r2 = m26_2_L4
				m26_2_r1 = m26_2_r2 and m26_L8[m26_2_L4.Name]
				m26_2_L5 = m26_2_r1
				m26_2_r2 = not m26_2_L3
				m26_2_r1 = m26_2_r2 or not m26_2_L5
				if m26_2_r1 then
					return false
				else
					m26_2_L6 = m26_2_L1.PrimaryPart.Position
					m26_2_L7 = { m26_2_L1 }
					m26_2_r1 = { ipairs(m26_L6:GetChildren()) }
					for m26_2_L8, m26_2_L9 in ipairs(m26_L6:GetChildren()) do
						m26_2_r3 = (m26_2_L9 ~= m26_2_L1)
						m26_2_r2 = m26_2_r3
						if m26_2_r3 then
							m26_2_r3 = m26_L3.isSpawnedEnemy(m26_2_L9)
							m26_2_r2 = m26_2_r3
								and (((m26_2_L9.PrimaryPart.Position - m26_2_L6)).Magnitude <= m26_L9)
							m26_2_r2 = m26_2_r2
						end
						if m26_2_r2 then
							m26_2_L7[(#m26_2_L7 + 1)] = m26_2_L9
						end
					end
					m26_L4.fire(
						"serverSkills",
						m26_2_L2,
						m26_2_L4.Name,
						m26_2_L5,
						"Hold",
						{ Mouse_Position = m26_2_L6 }
					)
					for m26_2_L10, m26_2_L11 in ipairs(m26_2_L7) do
						m26_L4.fire(
							"serverHitbox",
							m26_2_L11,
							m26_2_L4.Name,
							m26_2_L5,
							{
								Skill_Type = "Enemy_Effect",
								Loop = m26_L13(),
								Mouse_Position = m26_2_L11.PrimaryPart.Position,
								Moving_Speed = 250,
								Weapon_Effect = true,
								RootPart_Position = m26_2_L3.Position,
							}
						)
					end
					m26_L4.fire("serverSkills", m26_2_L2, m26_2_L4.Name, m26_2_L5, "Release")
					return true
				end
			end
		end
	end
	return m26_L7
end)


-- === playerApi: player actions: click, equip, bring mobs, skills, aimbot, kill ===
playerApi = lazy(function()
	local m28_L1, m28_L2, m28_L3, m28_L4, m28_L5, m28_L6, m28_L7, m28_L8, m28_L9, m28_L10, m28_L11, m28_L12, m28_L13, m28_L14, m28_L15, m28_L16, m28_L17, m28_L18, m28_L19, m28_L20
	local m28_L21, m28_L22, m28_L23, m28_L24, m28_L25, m28_L26, m28_L27, m28_L28
	m28_L1 = (environment())
	m28_L2 = (gameData())
	m28_L3 = (settings())
	m28_L4 = (remotes())
	m28_L5 = (entities())
	m28_L6 = (inventory())
	m28_L7 = (combat())
	m28_L8 = m28_L1.localPlayer
	m28_L9 = m28_L1.virtualInputManager
	m28_L10 = m28_L1.environment
	m28_L11 = m28_L1.spawn
	m28_L12 = m28_L1.wait
	m28_L13 = m28_L1.huge
	m28_L14 = m28_L1.insert
	m28_L15 = m28_L1.newVector3
	m28_L16 = m28_L2.monsters
	m28_L17 = m28_L2.cooldownFolder
	m28_L18 = m28_L2.enemyLocation
	m28_L19 = {}
	m28_L20 = {}
	m28_L21 = {}
	m28_L22 = {}
	m28_L23 = 500
	m28_L24 = 25
	m28_L25 = (Instance.new("Attachment"))
	m28_L26 = (Instance.new("AlignPosition"))
	m28_L26.Mode = Enum.PositionAlignmentMode.OneAttachment
	m28_L26.Position = (m28_L15(0, 20, 0))
	m28_L26.Responsiveness = 200
	m28_L26.MaxForce = m28_L13
	m28_L26.Attachment0 = m28_L25
	m28_L26.Parent = m28_L25
	m28_L19.playerClick = function()
		local m28_1_L1, m28_1_L2, m28_1_r1, m28_1_r2
		m28_1_L1 = m28_L8.Character
		if not m28_1_L1 then
			return
		else
			m28_1_r2 = m28_L3.autoHaki
			m28_1_r1 = m28_1_r2
			if m28_1_r2 then
				m28_1_r2 = (not m28_1_L1:GetAttribute("Using_Aura"))
				m28_1_r1 = m28_1_r2 and (m28_L6:verifyAbility("Aura"))
				m28_1_r1 = m28_1_r1
			end
			if m28_1_r1 then
				m28_L4.invoke("ability", "Aura")
			end
			m28_1_L2 = (m28_1_L1:FindFirstChildOfClass("Tool"))
			if m28_1_L2 then
				m28_1_L2.Enabled = true
				m28_1_L2:Activate()
			end
		end
	end
	m28_L19.equipWeapon = function()
		local m28_2_L1, m28_2_L2, m28_2_L3, m28_2_L4, m28_2_L5, m28_2_r1, m28_2_r2, m28_2_r3
		m28_2_L1 = m28_L8.Character
		m28_2_L2 = m28_L3.toolFarm
		m28_2_r2 = m28_2_L2
		m28_2_r1 = m28_2_r2 and (m28_L5.isAlive(m28_2_L1))
		if not m28_2_r1 then
			return
		else
			m28_2_L3 = (m28_2_L1:FindFirstChildOfClass("Tool"))
			m28_2_r2 = m28_2_L3
			m28_2_r1 = m28_2_r2 and (m28_2_L3.ToolTip:find(m28_2_L2))
			if m28_2_r1 then
				return
			else
				m28_2_r1 = { ipairs(m28_L8.Backpack:GetChildren()) }
				for m28_2_L4, m28_2_L5 in ipairs(m28_L8.Backpack:GetChildren()) do
					m28_2_r3 = m28_2_L5:IsA("Tool")
					m28_2_r2 = m28_2_r3 and (m28_2_L5.ToolTip:find(m28_2_L2))
					if m28_2_r2 then
						m28_L10.equippedTool = m28_2_L5
						return m28_2_L1.Humanoid:EquipTool(m28_2_L5)
					else
					end
				end
			end
		end
	end
	m28_L27 = function(m28_3_L1, m28_3_L2)
		local m28_3_L3, m28_3_r1, m28_3_r2
		m28_3_L3 = m28_L21[m28_3_L1]
		m28_3_r2 = not m28_3_L3
		m28_3_r1 = m28_3_r2 or (((m28_3_L2.Position - m28_3_L3.Position)).Magnitude > m28_L24)
		if m28_3_r1 then
			m28_L21[m28_3_L1] = m28_3_L2
		end
	end
	m28_L28 = function(m28_4_L1, m28_4_L2)
		local m28_4_L3, m28_4_L4, m28_4_L5, m28_4_L6, m28_4_r1, m28_4_r2
		m28_4_L3 = m28_4_L1.PrimaryPart
		m28_4_L4 = (m28_L25:Clone())
		m28_4_L5 = m28_4_L4.AlignPosition
		m28_4_L4.Parent = m28_4_L3
		while true do
			m28_4_r2 = m28_L3.bringMobs
			m28_4_r1 = m28_4_r2
			if m28_4_r2 then
				m28_4_r2 = (m28_4_L1.Parent == m28_L16.inWorkspace)
				m28_4_r1 = m28_4_r2
				if m28_4_r2 then
					m28_4_r2 = m28_L5.isAlive(m28_4_L1)
					m28_4_r1 = m28_4_r2 and (m28_4_L3.Parent == m28_4_L1)
					m28_4_r1 = m28_4_r1
				end
				m28_4_r1 = m28_4_r1
			end
			if not m28_4_r1 then
				break
			end
			m28_4_L6 = m28_L21[m28_4_L2]
			if ((m28_4_L6.Position - m28_4_L3.Position)).Magnitude > m28_L23 then
				break
			end
			if m28_4_L5.Position ~= m28_4_L6.Position then
				m28_4_L5.Position = m28_4_L6.Position
			end
			m28_L12()
		end
		m28_L22[m28_4_L1] = nil
		m28_4_L4:Destroy()
	end
	m28_L19.bringMobsTo = function(m28_5_L1, m28_5_L2, m28_5_L3)
		local m28_5_L4, m28_5_L5, m28_5_L6, m28_5_L7, m28_5_L8, m28_5_L9, m28_5_L10, m28_5_L11, m28_5_r1, m28_5_r2, m28_5_r3
		m28_5_L4 = m28_L8.Character
		m28_5_r2 = m28_5_L3
		m28_5_r1 = m28_5_r2 and "ALL_MOBS"
		m28_5_r2 = m28_5_r1 or m28_5_L1
		m28_5_L5 = m28_5_r2
		m28_L27(m28_5_L5, m28_5_L2)
		m28_5_r2 = m28_5_L4
		m28_5_r1 = m28_5_r2 and (m28_5_L4:GetPivot()).Position
		m28_5_L6 = m28_5_r1
		if m28_5_L6 then
			m28_5_r1 = { ipairs(m28_L16.inWorkspace:GetChildren()) }
			for m28_5_L7, m28_5_L8 in ipairs(m28_L16.inWorkspace:GetChildren()) do
				m28_5_r3 = m28_5_L3
				m28_5_r2 = m28_5_r3 or (m28_5_L8.Name == m28_5_L1)
				m28_5_r3 = m28_5_r2 and (m28_L5.isAlive(m28_5_L8))
				if m28_5_r3 then
					m28_5_L9 = m28_5_L8.PrimaryPart
					m28_5_L10 = m28_5_L8.Humanoid
					m28_5_r3 = m28_5_L9
					m28_5_r2 = m28_5_r3 and (((m28_5_L9.Position - m28_5_L6)).Magnitude < m28_L23)
					if m28_5_r2 then
						m28_5_L10.WalkSpeed = 0
						m28_5_L10:ChangeState(14)
						m28_5_L9.CanCollide = false
						m28_5_L9.Size = (m28_L15(40, 40, 40))
						m28_5_L11 = m28_L21[m28_5_L5]
						m28_5_r3 = not m28_L22[m28_5_L8]
						m28_5_r2 = m28_5_r3
							and (((m28_5_L9.Position - m28_5_L11.Position)).Magnitude < m28_L23)
						if m28_5_r2 then
							m28_L22[m28_5_L8] = true
							m28_L11(m28_L28, m28_5_L8, m28_5_L5)
						else
						end
					else
					end
				end
			end
		end
		return pcall(m28_L1.setHiddenProperty, m28_L8, "SimulationRadius", m28_L13)
	end
	m28_L19.getBringCFrame = function(m28_6_L1, m28_6_L2)
		local m28_6_L3, m28_6_L4, m28_6_L5, m28_6_L6, m28_6_L7, m28_6_L8, m28_6_r1, m28_6_r2, m28_6_r3
		m28_6_L3 = {}
		for m28_6_L4, m28_6_L5 in ipairs(m28_L18:GetChildren()) do
			m28_6_r3 = (m28_6_L5.Name == m28_6_L1)
			m28_6_r2 = m28_6_r3
			if m28_6_r3 then
				m28_6_r3 = m28_6_L5:IsA("BasePart")
				m28_6_r2 = m28_6_r3 or (m28_6_L5:IsA("Attachment"))
				m28_6_r2 = m28_6_r2
			end
			if m28_6_r2 then
				m28_L14(m28_6_L3, m28_6_L5.CFrame.Position)
			end
		end
		if #m28_6_L3 < 2 then
			return m28_6_L2
		else
			m28_6_L6 = Vector3.zero
			for m28_6_L7, m28_6_L8 in ipairs(m28_6_L3) do
				m28_6_L6 = (m28_6_L6 + m28_6_L8)
			end
			return CFrame.new((m28_6_L6 / #m28_6_L3))
		end
	end
	m28_L19.canUseSkill = function(m28_7_L1)
		local m28_7_L2, m28_7_L3, m28_7_r1
		for m28_7_L2, m28_7_L3 in ipairs(m28_L17:GetChildren()) do
			if m28_7_L3.Name:find(("_" .. m28_7_L1)) then
				return false
			else
			end
		end
		return true
	end
	m28_L19.useSkills = function()
		local m28_8_L1, m28_8_L2, m28_8_r1, m28_8_r2, m28_8_r3
		if not m28_L10.autoSkill then
			return
		else
			m28_8_r1 = pairs
			m28_8_r3 = m28_L3.skillsSelected
			m28_8_r2 = m28_8_r3 or {}
			for m28_8_L1, m28_8_L2 in m28_8_r1(m28_8_r2) do
				m28_8_r3 = m28_8_L2
				m28_8_r2 = m28_8_r3
				if m28_8_r3 then
					m28_8_r3 = not m28_L20[m28_8_L1]
					m28_8_r2 = m28_8_r3 and (m28_L19.canUseSkill(m28_8_L1))
					m28_8_r2 = m28_8_r2
				end
				if m28_8_r2 then
					m28_L9:SendKeyEvent(true, m28_8_L1, false, game)
					m28_L9:SendKeyEvent(false, m28_8_L1, false, game)
					m28_L11(function()
						m28_L20[m28_8_L1] = true
						m28_L12(0.5)
						m28_L20[m28_8_L1] = false
					end)
				end
			end
		end
	end
	m28_L19.infiniteDamage = function(m28_9_L1)
		return m28_L7.attack(m28_9_L1)
	end
	m28_L19.killEnemy = function(m28_10_L1, m28_10_L2)
		local m28_10_L3, m28_10_L4, m28_10_r1, m28_10_r2
		m28_10_L3 = m28_10_L1
		if type(m28_10_L1) == "string" then
			m28_10_L3 = (m28_L5.getEnemy(m28_10_L1))
		end
		m28_10_r2 = m28_10_L3
		m28_10_r1 = m28_10_r2 and m28_10_L3.PrimaryPart
		m28_10_L4 = m28_10_r1
		m28_10_r2 = not m28_10_L4
		m28_10_r1 = m28_10_r2 or (not m28_L5.isSpawnedEnemy(m28_10_L3))
		if m28_10_r1 then
			return false
		else
			if m28_L5.goTo((m28_10_L4.CFrame * m28_L3.farmCFrame)) == false then
				return false
			else
				m28_L19.equipWeapon()
				m28_L19.infiniteDamage(m28_10_L3)
				m28_L19.useSkills()
				if not m28_10_L3:FindFirstChild("Reverse_Mark") then
					m28_L19.playerClick()
				end
				if m28_L3.bringMobs then
					m28_L19.bringMobsTo(
						m28_10_L3.Name,
						m28_L19.getBringCFrame(m28_10_L3.Name, m28_10_L4.CFrame),
						m28_10_L2
					)
				end
				return true
			end
		end
	end
	m28_L19.aimBot = function(m28_11_L1, m28_11_L2, ...)
		local m28_11_L3, m28_11_L4, m28_11_L5, m28_11_L6, m28_11_L7, m28_11_L8, m28_11_L9, m28_11_L10, m28_11_L11, m28_11_L12, m28_11_L13, m28_11_r1, m28_11_r2, m28_11_r3
		m28_11_r1 = { ... }
		m28_11_L3 = m28_11_r1[1]
		m28_11_L4 = m28_11_r1[2]
		m28_11_L5 = m28_11_r1[3]
		m28_11_L6 = m28_11_r1[4]
		m28_11_L7 = m28_11_r1[5]
		m28_11_r2 = (m28_11_L3 == m28_L8.Character)
		m28_11_r1 = m28_11_r2
		if m28_11_r2 then
			m28_11_r2 = (m28_11_L6 == "Release")
			m28_11_r1 = m28_11_r2 and m28_11_L7
			m28_11_r1 = m28_11_r1
		end
		if m28_11_r1 then
			if m28_L10.nearestPlayer then
				m28_11_L8 = m28_L10.nearestPlayer.Position
				if rawget(m28_11_L7, "Hit_Position") then
					m28_11_L7.Hit_Position = m28_11_L8
				end
				if rawget(m28_11_L7, "Mouse_Position") then
					m28_11_L7.Mouse_Position = m28_11_L8
				else
				end
			end
			m28_11_L1(m28_11_L2, ...)
			m28_11_L9 = m28_L8.Character.PrimaryPart.Position
			if m28_L10.aimBotEnemy then
				m28_11_r1 = { ipairs(m28_L16.inWorkspace:GetChildren()) }
				for m28_11_L10, m28_11_L11 in ipairs(m28_L16.inWorkspace:GetChildren()) do
					m28_11_r3 = m28_L5.isAlive(m28_11_L11)
					m28_11_r2 = m28_11_r3 and m28_11_L11.PrimaryPart
					if m28_11_r2 then
						m28_L4.fire(
							"serverHitbox",
							m28_11_L11,
							m28_11_L4,
							m28_11_L5,
							{
								RootPart_Position = m28_11_L9,
								Mouse_Position = m28_11_L11.PrimaryPart.Position,
							}
						)
					end
				end
			end
			if m28_L10.aimBotPlayers then
				m28_11_r1 = { ipairs(m28_L5.getNearestList(1200)) }
				for m28_11_L12, m28_11_L13 in ipairs(m28_L5.getNearestList(1200)) do
					m28_L4.fire(
						"serverHitbox",
						m28_11_L13,
						m28_11_L4,
						m28_11_L5,
						{ RootPart_Position = m28_11_L9, Mouse_Position = m28_11_L13.PrimaryPart.Position }
					)
				end
			end
			return nil
		else
			return m28_11_L1(m28_11_L2, ...)
		end
	end
	return m28_L19
end)


-- === playerData: per-player level and stat access ===
playerData = lazy(function()
	local Q = gameData()
	local k = {}
	k["getPlayerLevel"] = function()
		return Q["playerLevel"]["Value"] or 1
	end
	k["getData"] = function(U)
		local k = (Q["playerDataFolder"]):FindFirstChild(U)
		return k and k["Value"] or 0
	end
	return k
end)


-- === quests: quest list and quest automation ===
quests = lazy(function()
	local m39_L1, m39_L2, m39_L3, m39_L4, m39_L5, m39_L6, m39_L7, m39_L8, m39_L9, m39_L10, m39_L11, m39_L12, m39_L13, m39_L14, m39_L15, m39_L16
	m39_L1 = (environment())
	m39_L2 = (gameData())
	m39_L3 = (entities())
	m39_L4 = (remotes())
	m39_L5 = (playerData())
	m39_L6 = m39_L1.insert
	m39_L7 = m39_L1.wait
	m39_L8 = m39_L1.localPlayer
	m39_L9 = m39_L2.npcStorage
	m39_L10 = m39_L2.questLocation
	m39_L11 = m39_L2.enemyLocation
	m39_L12 = m39_L2.questFolder
	m39_L13 = m39_L2.questNpcs
	m39_L14 = {}
	m39_L14.questsList = {}
	m39_L14.npcByEnemy = {}
	m39_L14.enemyList = {}
	m39_L14.updateQuestsList = function(m39_1_L1)
		local m39_1_L2, m39_1_L3, m39_1_L4, m39_1_L5, m39_1_r2, m39_1_r3, m39_1_r4, m39_1_r5, m39_1_r6, m39_1_r7
		table.clear(m39_1_L1.questsList)
		table.clear(m39_1_L1.npcByEnemy)
		table.clear(m39_1_L1.enemyList)
		for m39_1_L2, m39_1_L3 in pairs(m39_L2.questSettings) do
			if m39_L10:FindFirstChild(m39_1_L2) then
				m39_1_r2 = m39_L6
				m39_1_r3 = m39_1_L1.questsList
				m39_1_r4 = {}
				m39_1_r5 = "enemyPos"
				m39_1_r7 = m39_L11:FindFirstChild(m39_1_L3.Target)
				m39_1_r6 = m39_1_r7 and m39_L11[m39_1_L3.Target].CFrame
				m39_1_r4[m39_1_r5] = m39_1_r6
				m39_1_r4.questPos = m39_L10[m39_1_L2].CFrame
				m39_1_r4.specialQuest = m39_1_L3.Special_Quest
				m39_1_r4.raidBoss = m39_1_L3.Raid_Boss
				m39_1_r4.level = m39_1_L3.LevelNeed
				m39_1_r4.enemy = m39_1_L3.Target
				m39_1_r4.npcName = m39_1_L2
				m39_1_r2(m39_1_r3, m39_1_r4)
			end
		end
		table.sort(m39_1_L1.questsList, function(m39_1_1_L1, m39_1_1_L2)
			return (m39_1_1_L1.level > m39_1_1_L2.level)
		end)
		for m39_1_L4, m39_1_L5 in ipairs(m39_1_L1.questsList) do
			if not m39_1_L1.npcByEnemy[m39_1_L5.enemy] then
				m39_L6(m39_1_L1.enemyList, m39_1_L5.enemy)
			end
			m39_1_L1.npcByEnemy[m39_1_L5.enemy] = m39_1_L5.npcName
		end
	end
	m39_L14.getActive = function(m39_2_L1)
		local m39_2_L2, m39_2_L3, m39_2_r1
		for m39_2_L2, m39_2_L3 in ipairs(m39_L12:GetChildren()) do
			if m39_2_L3.Target.Value ~= "None" then
				return m39_2_L3
			else
			end
		end
		return false
	end
	m39_L14.verify = function(m39_3_L1, m39_3_L2)
		local m39_3_L3, m39_3_L4, m39_3_r1, m39_3_r2, m39_3_r3
		for m39_3_L3, m39_3_L4 in ipairs(m39_L12:GetChildren()) do
			m39_3_r3 = (m39_3_L4.Target.Value ~= "None")
			m39_3_r2 = m39_3_r3 and (m39_3_L4.QuestGiver.Value == m39_3_L2)
			if m39_3_r2 then
				return true
			else
			end
		end
		return false
	end
	m39_L14.take = function(m39_4_L1, m39_4_L2, m39_4_L3, m39_4_L4)
		local m39_4_L5, m39_4_L6, m39_4_L7, m39_4_L8, m39_4_r1, m39_4_r2, m39_4_r3
		assert(m39_4_L2, "missing quest name")
		m39_4_r2 = m39_L13:FindFirstChild(m39_4_L2)
		m39_4_r1 = m39_4_r2 or (m39_L9:FindFirstChild(m39_4_L2))
		m39_4_L5 = m39_4_r1
		if not m39_4_L5 then
			return false
		else
			if m39_4_L5.Parent ~= m39_L13 then
				m39_4_L5.Parent = m39_L13
			end
			if m39_L8:DistanceFromCharacter((m39_4_L5:GetPivot()).Position) > 5 then
				m39_4_L6 = (m39_L10:FindFirstChild(m39_4_L2))
				m39_4_r2 = m39_4_L3
				m39_4_r1 = m39_4_r2
				if not m39_4_r2 then
					m39_4_r2 = m39_4_L6
					m39_4_r1 = m39_4_r2 and m39_4_L6.CFrame
					m39_4_r2 = m39_4_r1 or (m39_4_L5:GetPivot())
					m39_4_r1 = m39_4_r2
				end
				m39_4_L7 = m39_4_r1
				m39_4_r2 = not m39_4_L7
				m39_4_r1 = m39_4_r2 or (m39_L8:DistanceFromCharacter(m39_4_L7.Position) < 5)
				if m39_4_r1 then
					return false
				else
					return (m39_L3.goTo(m39_4_L7) ~= false)
				end
			else
				m39_4_L8 = (m39_4_L5:FindFirstChild("QuestPrompt", true))
				if not m39_4_L8 then
					return false
				else
					if not pcall(fireproximityprompt, m39_4_L8) then
						warn("this executor may not support 'fireproximityprompt'")
						return false
					else
						m39_4_r1 = m39_L7
						m39_4_r3 = m39_4_L4
						m39_4_r2 = m39_4_r3 or 0.1
						m39_4_r1(m39_4_r2)
						return true
					end
				end
			end
		end
	end
	m39_L14.clear = function(m39_5_L1, m39_5_L2)
		local m39_5_L3, m39_5_L4, m39_5_r1, m39_5_r2, m39_5_r3
		for m39_5_L3, m39_5_L4 in ipairs(m39_L12:GetChildren()) do
			m39_5_r3 = (m39_5_L4.QuestGiver.Value ~= m39_5_L2)
			m39_5_r2 = m39_5_r3 and (m39_5_L4.Target.Value ~= "None")
			if m39_5_r2 then
				m39_L4.fire("quest", "Abandon_Quest", { QuestSlot = m39_5_L4.Name })
			end
		end
	end
	m39_L15 = (m39_L5.getPlayerLevel())
	m39_L16 = nil
	m39_L14.getCurrent = function(m39_6_L1)
		local m39_6_L2, m39_6_L3, m39_6_L4, m39_6_r1, m39_6_r2, m39_6_r3
		m39_6_L2 = (m39_L5.getPlayerLevel())
		m39_6_r2 = (m39_6_L2 == m39_L15)
		m39_6_r1 = m39_6_r2 and m39_L16
		if m39_6_r1 then
			return m39_L16
		else
			for m39_6_L3, m39_6_L4 in ipairs(m39_6_L1.questsList) do
				m39_6_r3 = (m39_6_L4.level <= m39_6_L2)
				m39_6_r2 = m39_6_r3
				if m39_6_r3 then
					m39_6_r3 = not m39_6_L4.raidBoss
					m39_6_r2 = m39_6_r3 and not m39_6_L4.specialQuest
					m39_6_r2 = m39_6_r2
				end
				if m39_6_r2 then
					m39_L15 = m39_6_L2
					m39_L16 = m39_6_L4
					return m39_6_L4
				else
				end
			end
		end
	end
	return m39_L14
end)


-- === monsterData: monster / boss / drop data ===
monsterData = lazy(function()
	local m40_L1
	m40_L1 = (environment()).newCFrame
	return {
		spawnBoss = {
			["Lord Sus"] = {
				quest = "Floppa Quest 32",
				summonPos = m40_L1(6644, -95, 4811),
				material = "Sussy Orb",
				amount = 1,
				island = "ForgottenIsland",
				summon = "Summon3",
			},
			["Evil Noob"] = {
				quest = "Floppa Quest 29",
				summonPos = m40_L1(-2356, -81, 3180),
				material = "Noob Head",
				amount = 1,
				island = "MoaiIsland",
				summon = "Summon2",
			},
			["Giant Pumpkin"] = {
				quest = "Floppa Quest 23",
				summonPos = m40_L1(-1180, -93, 1462),
				material = "Flame Orb",
				amount = 1,
				island = "PumpkinIsland",
				summon = "Summon1",
			},
		},
		materials = {
			["Cat Food"] = "Gorilla King",
			["Flame Orb"] = "Scary Skull",
			["Money Bag"] = "MrBeast",
			["Sussy Orb"] = "Red Sus",
			["Nugget Man"] = "Giant Pumpkin",
			["Noob Head"] = "Moai",
			["Meme Cube"] = "Meme Beast",
			Ball = "Baller",
		},
		awakenPos = m40_L1(146, -37, -670),
	}
end)


-- === farming: farming routines (materials, enemies, level) ===
farming = lazy(function()
	local m41_L1, m41_L2, m41_L3, m41_L4, m41_L5, m41_L6, m41_L7, m41_L8
	m41_L1 = (environment())
	m41_L2 = (gameData())
	m41_L3 = (playerApi())
	m41_L4 = (entities())
	m41_L5 = (quests())
	m41_L6 = m41_L1.newCFrame
	m41_L7 = m41_L2.enemyLocation
	m41_L8 = m41_L2.island
	do
		return function(m41_1_L1)
			m41_1_L1.farmMaterial = function(m41_1_1_L1, m41_1_1_L2)
				local m41_1_1_L3
				m41_1_1_L3 = m41_1_1_L1.materials[m41_1_1_L2]
				if not m41_1_1_L3 then
					return false
				else
					if m41_1_1_L1.spawnBoss[m41_1_1_L3] then
						return m41_1_1_L1:farmRaidBoss(m41_1_1_L3, true)
					else
						return m41_1_1_L1:farmEnemy(m41_1_1_L3, true)
					end
				end
			end
			m41_1_L1.farmEnemy = function(m41_1_2_L1, m41_1_2_L2, m41_1_2_L3)
				local m41_1_2_L4, m41_1_2_L5, m41_1_2_r1, m41_1_2_r2
				if not m41_1_2_L2 then
					return false
				else
					m41_1_2_L4 = m41_L5.npcByEnemy[m41_1_2_L2]
					m41_1_2_r2 = m41_1_2_L4
					m41_1_2_r1 = m41_1_2_r2
					if m41_1_2_r2 then
						m41_1_2_r2 = m41_1_2_L3
						m41_1_2_r1 = m41_1_2_r2 and (not m41_L5:verify(m41_1_2_L4))
						m41_1_2_r1 = m41_1_2_r1
					end
					if m41_1_2_r1 then
						m41_L5:clear(m41_1_2_L4)
						if m41_L5:take(m41_1_2_L4) then
							return true
						else
						end
					end
					if m41_L3.killEnemy(m41_1_2_L2) then
						return true
					else
						m41_1_2_L5 = (m41_L7:FindFirstChild(m41_1_2_L2))
						if m41_1_2_L5 then
							return (m41_L4.goTo(m41_1_2_L5.CFrame) ~= false)
						else
							return false
						end
					end
				end
			end
			m41_1_L1.getFloppaSword = function(m41_1_3_L1)
				local m41_1_3_L2, m41_1_3_L3, m41_1_3_L4, m41_1_3_L5, m41_1_3_L6, m41_1_3_r1, m41_1_3_r2
				if not m41_L5:verify("Cool Floppa Quest") then
					m41_L5:clear("Cool Floppa Quest")
					return m41_L5:take("Cool Floppa Quest", m41_L6(758, -31, -424))
				else
					m41_1_3_L2 = (m41_L6(794, -31, -440))
					if m41_L1.localPlayer:DistanceFromCharacter(m41_1_3_L2.Position) >= 5 then
						return (m41_L4.goTo(m41_1_3_L2) ~= false)
					else
						m41_1_3_L3 = (m41_L8:FindFirstChild("FloppaIsland"))
						m41_1_3_r2 = m41_1_3_L3
						m41_1_3_r1 = m41_1_3_r2 and (m41_1_3_L3:FindFirstChild("Lava Floppa"))
						m41_1_3_L4 = m41_1_3_r1
						m41_1_3_r2 = m41_1_3_L4
						m41_1_3_r1 = m41_1_3_r2 and (m41_1_3_L4:FindFirstChild("ClickPart"))
						m41_1_3_L5 = m41_1_3_r1
						m41_1_3_r2 = m41_1_3_L5
						m41_1_3_r1 = m41_1_3_r2 and (m41_1_3_L5:FindFirstChild("ProximityPrompt"))
						m41_1_3_L6 = m41_1_3_r1
						if not m41_1_3_L6 then
							return false
						else
							fireproximityprompt(m41_1_3_L6)
							return true
						end
					end
				end
			end
			m41_1_L1.farmLevel = function(m41_1_4_L1)
				local m41_1_4_L2
				m41_1_4_L2 = (m41_L5:getCurrent())
				if not m41_1_4_L2 then
					return false
				else
					if not m41_L5:verify(m41_1_4_L2.npcName) then
						m41_L5:clear(m41_1_4_L2.npcName)
						return m41_L5:take(m41_1_4_L2.npcName)
					else
						return m41_1_4_L1:farmEnemy(m41_1_4_L2.enemy)
					end
				end
			end
		end
	end
end)


-- === raids: raid map and raid enemy lookup ===
raids = lazy(function()
	local m48_L1, m48_L2, m48_L3, m48_L4, m48_L5, m48_L6, m48_L7
	m48_L1 = (environment())
	m48_L2 = (gameData())
	m48_L3 = (entities())
	m48_L4 = m48_L1.localPlayer
	m48_L5 = m48_L2.monsters
	m48_L6 = m48_L2.raids
	m48_L7 = {}
	m48_L7.getRaidEnemy = function()
		local m48_1_L1, m48_1_L2, m48_1_r1, m48_1_r2, m48_1_r3
		for m48_1_L1, m48_1_L2 in ipairs(m48_L5.inWorkspace:GetChildren()) do
			m48_1_r3 = m48_1_L2:GetAttribute("Raid_Enemy")
			m48_1_r2 = m48_1_r3 and (m48_L3.isAlive(m48_1_L2))
			if m48_1_r2 then
				return m48_1_L2
			else
			end
		end
	end
	m48_L7.getRaidMap = function()
		local m48_2_L1, m48_2_L2, m48_2_r1
		for m48_2_L1, m48_2_L2 in ipairs(m48_L6:GetChildren()) do
			if m48_2_L2.Joiners:FindFirstChild(m48_L4.Name) then
				return m48_2_L2
			else
			end
		end
	end
	return m48_L7
end)


-- === requirements: level and unlock requirements ===
requirements = lazy(function()
	return {
		["level"] = {
			["codes"] = 25,
			["bossQuest"] = 300,
			["memeBeast"] = 400,
			["raceV2Orb"] = 500,
			["raid"] = 1000,
			["gamepasses"] = 2000,
		},
		["bossLevel"] = { ["Lord Sus"] = 1550, ["Evil Noob"] = 1400, ["Giant Pumpkin"] = 1100 },
		["maxQuest"] = 2,
	}
end)


-- === raidFarm: raid farming and Meme Beast ===
raidFarm = lazy(function()
	local m49_L1, m49_L2, m49_L3, m49_L4, m49_L5, m49_L6, m49_L7, m49_L8, m49_L9, m49_L10, m49_L11
	m49_L1 = (environment())
	m49_L2 = (gameData())
	m49_L3 = (playerApi())
	m49_L4 = (remotes())
	m49_L5 = (entities())
	m49_L6 = (raids())
	m49_L7 = (playerData())
	m49_L8 = (requirements())
	m49_L9 = m49_L1.wait
	m49_L10 = m49_L1.newCFrame
	m49_L11 = m49_L2.region
	do
		return function(m49_1_L1)
			m49_1_L1.farmRaid = function(m49_1_1_L1)
				local m49_1_1_L2, m49_1_1_L3, m49_1_1_L4, m49_1_1_L5, m49_1_1_L6, m49_1_1_r1, m49_1_1_r2
				if m49_L7.getPlayerLevel() < m49_L8.level.raid then
					return false
				else
					m49_1_1_L2 = (m49_L6.getRaidMap())
					if m49_1_1_L2 then
						m49_1_1_L3 = (m49_1_1_L2:GetAttribute("Starting"))
						m49_1_1_r2 = (type(m49_1_1_L3) == "number")
						m49_1_1_r1 = m49_1_1_r2 and (m49_1_1_L3 ~= 0)
						if m49_1_1_r1 then
							m49_L4.fire("startRaid", "Start")
							m49_L9(1)
							return true
						else
							m49_1_1_L4 = (m49_L6.getRaidEnemy())
							if m49_1_1_L4 then
								return m49_L3.killEnemy(m49_1_1_L4, true)
							else
								m49_1_1_L5 = (m49_1_1_L2:FindFirstChild("Spawn_Location"))
								if m49_1_1_L5 then
									return (m49_L5.goTo(m49_1_1_L5.CFrame) ~= false)
								else
								end
							end
						end
					else
						m49_1_1_L6 = (m49_L11:FindFirstChild("RaidArea"))
						if m49_1_1_L6 then
							m49_1_1_r1 = m49_L5.goTo(m49_L10(m49_1_1_L6.Position))
							return (m49_1_1_r1 ~= false)
						else
						end
					end
					return false
				end
			end
			m49_1_L1.killMemeBeast = function(m49_1_2_L1)
				local m49_1_2_L2, m49_1_2_r1
				m49_1_2_L2 = (m49_L5.getEnemy("Meme Beast"))
				if m49_1_2_L2 then
					m49_1_2_r1 = m49_L5.goTo(m49_1_2_L2:GetPivot())
					if m49_1_2_r1 == false then
						return false
					else
						m49_L3.equipWeapon()
						m49_L3.infiniteDamage(m49_1_2_L2)
						m49_L3.playerClick()
						m49_L3.useSkills()
						return true
					end
				else
					return false
				end
			end
		end
	end
end)


-- === bossFarm: raid boss and quest boss farming ===
bossFarm = lazy(function()
	local m50_L1, m50_L2, m50_L3, m50_L4, m50_L5, m50_L6, m50_L7, m50_L8, m50_L9, m50_L10, m50_L11, m50_L12
	m50_L1 = (environment())
	m50_L2 = (gameData())
	m50_L3 = (playerApi())
	m50_L4 = (entities())
	m50_L5 = (quests())
	m50_L6 = (inventory())
	m50_L7 = (playerData())
	m50_L8 = (requirements())
	m50_L9 = m50_L1.localPlayer
	m50_L10 = m50_L2.island
	m50_L11 = m50_L7.getPlayerLevel
	m50_L12 = function(m50_1_L1)
		local m50_1_L2, m50_1_L3, m50_1_L4, m50_1_L5, m50_1_r1, m50_1_r2
		if m50_L9:DistanceFromCharacter(m50_1_L1.summonPos.Position) >= 5 then
			return (m50_L4.goTo(m50_1_L1.summonPos) ~= false)
		else
			m50_1_L2 = (m50_L10:FindFirstChild(m50_1_L1.island))
			m50_1_r2 = m50_1_L2
			m50_1_r1 = m50_1_r2 and (m50_1_L2:FindFirstChild(m50_1_L1.summon))
			m50_1_L3 = m50_1_r1
			m50_1_r2 = m50_1_L3
			m50_1_r1 = m50_1_r2 and (m50_1_L3:FindFirstChild("Summon"))
			m50_1_L4 = m50_1_r1
			m50_1_r2 = m50_1_L4
			m50_1_r1 = m50_1_r2 and (m50_1_L4:FindFirstChild("SummonPrompt"))
			m50_1_L5 = m50_1_r1
			if not m50_1_L5 then
				return false
			else
				fireproximityprompt(m50_1_L5)
				return true
			end
		end
	end
	do
		return function(m50_2_L1)
			m50_2_L1.farmRaidBoss = function(m50_2_1_L1, m50_2_1_L2, m50_2_1_L3)
				local m50_2_1_L4, m50_2_1_L5, m50_2_1_r1, m50_2_1_r2
				m50_2_1_L4 = m50_2_1_L1.spawnBoss[m50_2_1_L2]
				m50_2_1_r2 = not m50_2_1_L4
				m50_2_1_r1 = m50_2_1_r2 or (not m50_L4.isAlive(m50_L9.Character))
				if m50_2_1_r1 then
					return false
				else
					m50_2_1_L5 = (m50_L4.getEnemy(m50_2_1_L2))
					if m50_2_1_L5 then
						m50_2_1_r2 = (not m50_L5:verify(m50_2_1_L4.quest))
						m50_2_1_r1 = m50_2_1_r2 and (m50_L11() >= m50_L8.bossLevel[m50_2_1_L2])
						if m50_2_1_r1 then
							m50_L5:clear(m50_2_1_L4.quest)
							if m50_L5:take(m50_2_1_L4.quest, nil, 1) then
								return true
							else
							end
						end
						return m50_L3.killEnemy(m50_2_1_L5)
					else
						if m50_L6:getMaterial(m50_2_1_L4.material) >= m50_2_1_L4.amount then
							return m50_L12(m50_2_1_L4)
						else
							if m50_2_1_L3 then
								return m50_2_1_L1:farmMaterial(m50_2_1_L4.material)
							else
								return false
							end
						end
					end
				end
			end
			m50_2_L1.killQuest = function(m50_2_2_L1, m50_2_2_L2)
				local m50_2_2_r1, m50_2_2_r2
				m50_2_2_r2 = not m50_L8.bossLevel[m50_2_2_L2]
				m50_2_2_r1 = m50_2_2_r2 or (m50_L11() < m50_L8.bossLevel[m50_2_2_L2])
				if m50_2_2_r1 then
					return false
				else
					return m50_2_2_L1:farmRaidBoss(m50_2_2_L2)
				end
			end
		end
	end
end)


-- === weaponShop: weapon shop stock ===
weaponShop = lazy(function()
	return {
		sections = {
			{
				name = "Weapons",
				items = {
					{ name = "Katana", description = "$5.000 Money", remote = { "Weapon_Seller", "Doge" } },
					{
						name = "Hanger",
						description = "$25.000 Money",
						remote = { "Weapon_Seller", "Hanger" },
					},
					{
						name = "Flame Katana",
						description = "1x Cheems Cola and $50.000",
						remote = { "Weapon_Seller", "Cheems" },
					},
					{
						name = "Banana",
						description = "1x Cat Food and $350.000",
						remote = { "Weapon_Seller", "Smiling Cat" },
					},
					{
						name = "Bonk",
						description = "5x Money Bags and $1.000.000",
						remote = { "Weapon_Seller", "Meme Man" },
					},
					{
						name = "Pumpkin",
						description = "1x Nugget Man and $3.500.000",
						remote = { "Weapon_Seller", "Gravestone" },
					},
					{
						name = "Popcat",
						description = "10.000 Pops Clicker",
						remote = { "Weapon_Seller", "Ohio Popcat" },
					},
				},
			},
			{
				name = "Ability",
				items = {
					{
						name = "Flash Step",
						description = "$100.000 Money",
						remote = { "Ability_Teacher", "Giga Chad" },
					},
					{
						name = "Instinct",
						description = "$2.500.000 Money",
						remote = { "Ability_Teacher", "Nugget Man" },
					},
					{
						name = "Aura",
						description = "1x Meme Cube and $10.000.000",
						remote = { "Ability_Teacher", "Aura Master" },
					},
				},
			},
			{
				name = "Fighting Style",
				items = {
					{
						name = "Combat",
						description = "$0 Money",
						remote = { "FightingStyle_Teacher", "Maxwell" },
					},
					{
						name = "Baller",
						description = "10x Balls and $10.000.000",
						remote = { "FightingStyle_Teacher", "Baller" },
					},
				},
			},
		},
		itemPrices = {
			["Quest Scroll"] = { Money = 1000000 },
			Aura = { Material = { ["Meme Cube"] = 1 }, Money = 10000000 },
			Instinct = { Money = 2500000 },
			FlashStep = { Money = 100000 },
			Katana = { Money = 5000 },
			Hanger = { Money = 25000 },
			["Flame Katana"] = { Material = { ["Cheems Cola"] = 1 }, Money = 50000 },
			Banana = { Material = { ["Cat Food"] = 1 }, Money = 350000 },
			Bonk = { Material = { ["Money Bag"] = 5 }, Money = 1000000 },
			Pumpkin = { Material = { ["Nugget Man"] = 1 }, Money = 3500000 },
			Baller = { Material = { Ball = 10 }, Money = 10000000 },
			Popcat = { Pop = 10000 },
		},
		actionPrices = { rerollRace = { Gem = 250 }, rerollAura = { Gem = 10 } },
	}
end)


-- === raceFarm: race orb, race V2 and quest limit farming ===
raceFarm = lazy(function()
	local m54_L1, m54_L2, m54_L3, m54_L4, m54_L5, m54_L6, m54_L7, m54_L8, m54_L9, m54_L10, m54_L11, m54_L12, m54_L13, m54_L14, m54_L15, m54_L16, m54_L17, m54_L18, m54_L19
	m54_L1 = (environment())
	m54_L2 = (monsterData())
	m54_L3 = (remotes())
	m54_L4 = (entities())
	m54_L5 = (quests())
	m54_L6 = (inventory())
	m54_L7 = (playerData())
	m54_L8 = (weaponShop())
	m54_L9 = (requirements())
	m54_L10 = m54_L1.localPlayer
	m54_L11 = m54_L1.wait
	m54_L12 = m54_L2.awakenPos
	m54_L13 = m54_L7.getData
	m54_L14 = 0
	m54_L15 = {}
	m54_L16 = 0
	m54_L17 = function(m54_1_L1)
		local m54_1_L2, m54_1_r1, m54_1_r2
		m54_1_L2 = m54_L10.Character
		m54_1_r2 = m54_1_L2
		m54_1_r1 = m54_1_r2 and (m54_1_L2:FindFirstChild(m54_1_L1))
		m54_1_r2 = m54_1_r1 or (m54_L10.Backpack:FindFirstChild(m54_1_L1))
		return m54_1_r2
	end
	m54_L18 = function(m54_2_L1)
		local m54_2_r1, m54_2_r2
		m54_2_r2 = (m54_L17(m54_2_L1) ~= nil)
		m54_2_r1 = m54_2_r2 or (m54_L6:getMaterial(m54_2_L1) >= 1)
		return m54_2_r1
	end
	m54_L19 = function(m54_3_L1, m54_3_L2)
		local m54_3_L3, m54_3_L4, m54_3_r1, m54_3_r2, m54_3_r3
		m54_3_L3 = m54_L10.Character
		m54_3_r2 = (not m54_L4.isAlive(m54_3_L3))
		m54_3_r1 = m54_3_r2
		if not m54_3_r2 then
			m54_3_r1 = os.clock()
			m54_3_r3 = m54_L15[m54_3_L1]
			m54_3_r2 = m54_3_r3 or 0
			m54_3_r1 = (m54_3_r1 < m54_3_r2)
			m54_3_r1 = m54_3_r1
		end
		if m54_3_r1 then
			return false
		else
			m54_3_L4 = (m54_L17(m54_3_L1))
			m54_3_r2 = (m54_L4.goTo(m54_L12) == false)
			m54_3_r1 = m54_3_r2 or (m54_L10.Character ~= m54_3_L3)
			if m54_3_r1 then
				return false
			else
				m54_L15[m54_3_L1] = (os.clock() + 3)
				if m54_3_L4 then
					if m54_3_L4.Parent ~= m54_3_L3 then
						m54_3_L3.Humanoid:EquipTool(m54_3_L4)
					end
					m54_L3.fire("modules", m54_3_L2, { Action = "Use", Tool = m54_3_L4 })
				else
					m54_L3.invoke(
						"updateInventory",
						"Item",
						{ Action = "Unstore", SelectedItem = m54_3_L1 }
					)
				end
				m54_L11(1)
				return true
			end
		end
	end
	do
		return function(m54_4_L1)
			m54_4_L1.farmRaceOrb = function(m54_4_1_L1)
				local m54_4_1_r1
				m54_4_1_r1 = "Dancing Banana Quest"
				if m54_L5:verify(m54_4_1_r1) then
					return m54_4_1_L1:farmEnemy("Sogga")
				else
					m54_L5:clear(m54_4_1_r1)
					m54_4_1_r1 = { m54_4_1_r1, m54_L1.newCFrame(-2620, -80, -2001) }
					m54_4_1_r1 = { m54_L5:take(m54_4_1_r1[1], m54_4_1_r1[2]) }
					return unpack(m54_4_1_r1)
				end
			end
			m54_4_L1.evolveRaceV2 = function(m54_4_2_L1, m54_4_2_L2)
				local m54_4_2_L3, m54_4_2_r1, m54_4_2_r2
				if m54_4_2_L2 < m54_L9.level.raceV2Orb then
					return false
				else
					m54_4_2_L3 = (m54_L13("Race"))
					if m54_4_2_L3 ~= "Human" then
						if m54_L6:verifyAbility((m54_4_2_L3 .. "Awaken")) then
							return false
						else
							if m54_L18("Awakening Orb") then
								return m54_L19("Awakening Orb", "Awakening_Orb")
							else
								return m54_4_2_L1:farmRaceOrb()
							end
						end
					else
						m54_4_2_r2 = (m54_L13("Gem") >= m54_L8.actionPrices.rerollRace.Gem)
						m54_4_2_r1 = m54_4_2_r2 and (os.clock() >= m54_L16)
						if m54_4_2_r1 then
							m54_L16 = (os.clock() + 3)
							m54_L3.fire("modules", "Reroll_Race", "Watermelon Man")
							m54_L11(1)
							return true
						else
							return false
						end
					end
				end
			end
			m54_4_L1.upgradeQuestLimit = function(m54_4_3_L1)
				local m54_4_3_r1, m54_4_3_r2
				if not m54_L4.isAlive(m54_L10.Character) then
					return false
				else
					if m54_L13("MaxQuest") >= m54_L9.maxQuest then
						return false
					else
						if m54_L18("Quest Scroll") then
							return m54_L19("Quest Scroll", "Quest_Scroll")
						else
							m54_4_3_r2 = (m54_L13("Money") < m54_L8.itemPrices["Quest Scroll"].Money)
							m54_4_3_r1 = m54_4_3_r2 or (os.clock() < m54_L14)
							if m54_4_3_r1 then
								return false
							else
								if m54_L4.goTo(m54_L12) == false then
									return false
								else
									m54_L14 = (os.clock() + 3)
									m54_L3.fire("modules", "Upgrade_Quest", "Popcat")
									m54_L11(1)
									return true
								end
							end
						end
					end
				end
			end
		end
	end
end)


-- === gameSettings: game settings exposed by the game modules ===
gameSettings = lazy(function()
	local Q = gameData()
	local k = Q["gameSetting"]["Setting"]
	return {
		["maxLevel"] = k["MaxLevel"],
		["ignoredSpawns"] = k["IgnoreSpawnPoints"],
		["toolTypes"] = { "Fight", "Power", "Weapon" },
	}
end)


-- === shopItems: shop inventory ===
shopItems = lazy(function()
	return weaponShop()
end)


-- === gamepasses: gamepass names, prices and ids ===
gamepasses = lazy(function()
	local Q = gameData()
	return {
		["names"] = { "DoubleGem", "DoubleMoney", "DoubleExp", "Lucky" },
		["prices"] = Q["gameSetting"]["Setting"]["Gamepasses_Cost"],
		["ids"] = {},
	}
end)


-- === shop: shop purchases ===
shop = lazy(function()
	local m56_L1, m56_L2, m56_L3, m56_L4, m56_L5, m56_L6, m56_L7, m56_L8, m56_L9, m56_L10
	m56_L1 = (environment())
	m56_L2 = (remotes())
	m56_L3 = (shopItems())
	m56_L4 = (gamepasses())
	m56_L5 = (inventory())
	m56_L6 = (playerData())
	m56_L7 = m56_L1.wait
	m56_L8 = m56_L6.getData
	m56_L9 = {}
	m56_L10 = {
		Instinct = { "Ability_Teacher", "Nugget Man" },
		FlashStep = { "Ability_Teacher", "Giga Chad" },
		Aura = { "Ability_Teacher", "Aura Master" },
	}
	m56_L9.specialChecks = {
		Material = function(m56_1_L1)
			local m56_1_L2, m56_1_L3
			for m56_1_L2, m56_1_L3 in pairs(m56_1_L1) do
				if m56_L5:getMaterial(m56_1_L2) < m56_1_L3 then
					return true
				else
				end
			end
			return false
		end,
	}
	m56_L9.canBuy = function(m56_2_L1, m56_2_L2)
		local m56_2_L3, m56_2_L4, m56_2_L5, m56_2_L6
		m56_2_L3 = m56_L3.itemPrices[m56_2_L2]
		if type(m56_2_L3) ~= "table" then
			return false
		else
			for m56_2_L4, m56_2_L5 in pairs(m56_2_L3) do
				m56_2_L6 = m56_2_L1.specialChecks[m56_2_L4]
				if m56_2_L6 then
					if m56_2_L6(m56_2_L5) then
						return false
					else
					end
				else
					if m56_L8(m56_2_L4) < m56_2_L5 then
						return false
					else
					end
				end
			end
			return true
		end
	end
	m56_L9.getMissingMaterials = function(m56_3_L1, m56_3_L2)
		local m56_3_L3, m56_3_L4, m56_3_L5, m56_3_L6, m56_3_L7, m56_3_r1, m56_3_r2, m56_3_r3
		m56_3_L3 = {}
		m56_3_L4 = m56_L3.itemPrices[m56_3_L2]
		m56_3_r1 = pairs
		m56_3_r3 = m56_3_L4
		m56_3_r2 = m56_3_r3 and m56_3_L4.Material
		m56_3_r3 = m56_3_r2 or {}
		for m56_3_L5, m56_3_L6 in m56_3_r1(m56_3_r3) do
			m56_3_L7 = (m56_L5:getMaterial(m56_3_L5))
			if m56_3_L7 < m56_3_L6 then
				m56_3_L3[m56_3_L5] = (m56_3_L6 - m56_3_L7)
			end
		end
		return m56_3_L3
	end
	m56_L9.buyAllAbilities = function(m56_4_L1)
		local m56_4_L2, m56_4_L3, m56_4_r2, m56_4_r3
		for m56_4_L2, m56_4_L3 in pairs(m56_L10) do
			m56_4_r3 = (not m56_L5:verifyAbility(m56_4_L2))
			m56_4_r2 = m56_4_r3 and (m56_4_L1:canBuy(m56_4_L2))
			if m56_4_r2 then
				m56_L2.fire("modules", unpack(m56_4_L3))
				m56_L7(1)
			end
		end
	end
	m56_L9.buyMissingWeapon = function(m56_5_L1)
		local m56_5_L2, m56_5_L3, m56_5_L4, m56_5_r2, m56_5_r3
		m56_5_L2 = (m56_L5:getUnlocked())
		for m56_5_L3, m56_5_L4 in ipairs(m56_L3.sections[1].items) do
			m56_5_r3 = not m56_5_L2[m56_5_L4.name]
			m56_5_r2 = m56_5_r3 and (m56_5_L1:canBuy(m56_5_L4.name))
			if m56_5_r2 then
				m56_L2.fire("modules", unpack(m56_5_L4.remote))
				m56_L7(1)
				return true
			else
			end
		end
		return false
	end
	m56_L9.buyBaller = function(m56_6_L1)
		if m56_L5:verifyFightStyle("Baller") then
			return true
		else
			if not m56_6_L1:canBuy("Baller") then
				return false
			else
				m56_L2.fire("modules", "FightingStyle_Teacher", "Baller")
				m56_L7(1)
				return (m56_L5:verifyFightStyle("Baller") == true)
			end
		end
	end
	m56_L9.buyGamepasses = function(m56_7_L1)
		local m56_7_L2, m56_7_L3, m56_7_L4, m56_7_L5, m56_7_r2, m56_7_r3
		for m56_7_L2, m56_7_L3 in ipairs(m56_L4.names) do
			if not m56_L5:verifyGamepass(m56_7_L3) then
				m56_7_L4 = m56_L4.prices[m56_7_L3]
				m56_7_L5 = m56_L4.ids[m56_7_L3]
				m56_7_r3 = (type(m56_7_L4) ~= "number")
				m56_7_r2 = m56_7_r3
				if not m56_7_r3 then
					m56_7_r3 = not m56_7_L5
					m56_7_r2 = m56_7_r3 or (m56_L8("Gem") < m56_7_L4)
					m56_7_r2 = m56_7_r2
				end
				if m56_7_r2 then
					return false
				else
					m56_L2.fire("buyProduct", { Action = "Buy_Gamepass", GamepassId = m56_7_L5 })
					m56_L7(1)
					if not m56_L5:verifyGamepass(m56_7_L3) then
						return false
					else
					end
				end
			end
		end
		return true
	end
	return m56_L9
end)


-- === oneClick: one-click progression ===
oneClick = lazy(function()
	local m61_L1, m61_L2, m61_L3, m61_L4, m61_L5, m61_L6, m61_L7, m61_L8
	m61_L1 = (environment())
	m61_L2 = (gameSettings())
	m61_L3 = (shop())
	m61_L4 = (inventory())
	m61_L5 = (playerData())
	m61_L6 = (requirements())
	m61_L7 = m61_L1.environment
	m61_L8 = m61_L5.getPlayerLevel
	do
		return function(m61_1_L1)
			m61_1_L1.oneClick = function(m61_1_1_L1)
				local m61_1_1_L2, m61_1_1_L3, m61_1_1_L4, m61_1_1_L5, m61_1_1_L6, m61_1_1_r1, m61_1_1_r2
				m61_1_1_r2 = m61_L7.oneClickSettings
				m61_1_1_r1 = m61_1_1_r2 or {}
				m61_1_1_L2 = m61_1_1_r1
				m61_1_1_L3 = (m61_L4:getUnlocked())
				m61_1_1_L4 = (m61_L8())
				m61_1_1_r2 = m61_1_1_L2.awakenV2
				m61_1_1_r1 = m61_1_1_r2 and (m61_1_1_L1:evolveRaceV2(m61_1_1_L4))
				if m61_1_1_r1 then
					return true
				else
					m61_1_1_r2 = m61_1_1_L2.questLimit
					m61_1_1_r1 = m61_1_1_r2 and (m61_1_1_L1:unlockQuestLimit())
					if m61_1_1_r1 then
						return true
					else
						m61_1_1_r2 = not m61_1_1_L3.Floppa
						m61_1_1_r1 = m61_1_1_r2 and (m61_1_1_L1:getFloppaSword())
						if m61_1_1_r1 then
							return true
						else
							m61_1_1_r2 = (m61_1_1_L4 >= m61_L6.level.memeBeast)
							m61_1_1_r1 = m61_1_1_r2 and (m61_1_1_L1:killMemeBeast())
							if m61_1_1_r1 then
								return true
							else
								if m61_1_1_L4 >= m61_L6.level.bossQuest then
									for m61_1_1_L5, m61_1_1_L6 in ipairs({
										"Lord Sus",
										"Evil Noob",
										"Giant Pumpkin",
									}) do
										if m61_1_1_L1:killQuest(m61_1_1_L6) then
											return true
										else
										end
									end
								end
								m61_1_1_r2 = m61_1_1_L2.getGamepasses
								m61_1_1_r1 = m61_1_1_r2
								if m61_1_1_r2 then
									m61_1_1_r2 = (m61_1_1_L4 >= m61_L6.level.gamepasses)
									m61_1_1_r1 = m61_1_1_r2 and (not m61_L3:buyGamepasses())
									m61_1_1_r1 = m61_1_1_r1
								end
								if m61_1_1_r1 then
									if m61_1_1_L1:farmRaid() then
										return true
									else
									end
								end
								if m61_1_1_L4 < m61_L2.maxLevel then
									return m61_1_1_L1:farmLevel()
								else
									return m61_1_1_L1:oneClickEndGame(m61_1_1_L3, m61_1_1_L2)
								end
							end
						end
					end
				end
			end
			m61_1_L1.oneClickEndGame = function(m61_1_2_L1, m61_1_2_L2, m61_1_2_L3)
				local m61_1_2_L4, m61_1_2_L5, m61_1_2_r1, m61_1_2_r2
				if m61_1_2_L1:unlockBaller() then
					return true
				else
					m61_1_2_r2 = not m61_1_2_L2.Pumpkin
					m61_1_2_r1 = m61_1_2_r2 or not m61_1_2_L2["Pumpkin Head"]
					m61_1_2_r2 = m61_1_2_r1 and (m61_1_2_L1:farmRaidBoss("Giant Pumpkin", true))
					if m61_1_2_r2 then
						return true
					else
						m61_1_2_r2 = not m61_1_2_L2["Yellow Blade"]
						m61_1_2_r1 = m61_1_2_r2 or not m61_1_2_L2["Noob Friend"]
						m61_1_2_r2 = m61_1_2_r1 and (m61_1_2_L1:farmRaidBoss("Evil Noob", true))
						if m61_1_2_r2 then
							return true
						else
							m61_1_2_r2 = not m61_1_2_L2["Purple Katana"]
							m61_1_2_r1 = m61_1_2_r2 or not m61_1_2_L2["Sus Pals"]
							m61_1_2_r2 = m61_1_2_r1 and (m61_1_2_L1:farmRaidBoss("Lord Sus", true))
							if m61_1_2_r2 then
								return true
							else
								m61_1_2_r2 = not m61_1_2_L2.Card
								m61_1_2_r1 = m61_1_2_r2 or not m61_1_2_L2["Popcat Pet"]
								m61_1_2_r2 = m61_1_2_r1 and (m61_1_2_L1:farmRaid())
								if m61_1_2_r2 then
									return true
								else
									m61_1_2_r2 = not m61_1_2_L2.Bonk
									m61_1_2_r1 = m61_1_2_r2 or not m61_1_2_L2.MrBeast
									m61_1_2_r2 = m61_1_2_r1 and (m61_1_2_L1:farmEnemy("MrBeast"))
									if m61_1_2_r2 then
										return true
									else
										m61_1_2_r2 = not m61_1_2_L2["Pixel Sword"]
										m61_1_2_r1 = m61_1_2_r2 or not m61_1_2_L2.Obamid
										m61_1_2_r2 = m61_1_2_r1 and (m61_1_2_L1:farmEnemy("Obamid"))
										if m61_1_2_r2 then
											return true
										else
											m61_1_2_r2 = not m61_1_2_L2["Giant Banana"]
											m61_1_2_r1 = m61_1_2_r2 or not m61_1_2_L2.Banana
											m61_1_2_r2 = m61_1_2_r1
												and (m61_1_2_L1:farmEnemy("Gorilla King"))
											if m61_1_2_r2 then
												return true
											else
												m61_1_2_r2 = not m61_1_2_L2["Moai Face"]
												m61_1_2_r1 = m61_1_2_r2 and (m61_1_2_L1:farmEnemy("Moai"))
												if m61_1_2_r1 then
													return true
												else
													m61_1_2_r2 = not m61_1_2_L2["Pink Hammer"]
													m61_1_2_r1 = m61_1_2_r2
														and (m61_1_2_L1:farmEnemy("Pink Absorber"))
													if m61_1_2_r1 then
														return true
													else
														m61_1_2_L4 = m61_1_2_L3.endGame
														if m61_1_2_L4 == "Farm Raid" then
															return m61_1_2_L1:farmRaid()
														else
															m61_1_2_r2 = (m61_1_2_L4 == "Farm Evil Noob")
															m61_1_2_r1 = m61_1_2_r2 and "Evil Noob"
															m61_1_2_r2 = m61_1_2_r1 or "Lord Sus"
															m61_1_2_L5 = m61_1_2_r2
															if
																m61_1_2_L1:farmRaidBoss(m61_1_2_L5, true)
															then
																return true
															else
																return m61_1_2_L1:farmRaid()
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)


-- === unlocks: bulk unlocks (Baller, weapons, quest limit, gamepasses) ===
unlocks = lazy(function()
	local m72_L1, m72_L2, m72_L3, m72_L4, m72_L5, m72_L6, m72_L7
	m72_L1 = (shopItems())
	m72_L2 = (shop())
	m72_L3 = (inventory())
	m72_L4 = (playerData())
	m72_L5 = (requirements())
	m72_L6 = m72_L4.getData
	m72_L7 = m72_L4.getPlayerLevel
	do
		return function(m72_1_L1)
			m72_1_L1.unlockBaller = function(m72_1_1_L1)
				local m72_1_1_L2, m72_1_1_L3, m72_1_1_r1
				if m72_L3:verifyFightStyle("Baller") then
					return false
				else
					m72_1_1_L2 = m72_L1.itemPrices.Baller
					m72_1_1_r1 = { next(m72_L2:getMissingMaterials("Baller")) }
					m72_1_1_L3 = m72_1_1_r1[1]
					if m72_1_1_L3 then
						return m72_1_1_L1:farmMaterial(m72_1_1_L3)
					else
						if m72_L6("Money") >= m72_1_1_L2.Money then
							return m72_L2:buyBaller()
						else
							return false
						end
					end
				end
			end
			m72_1_L1.unlockWeapons = function(m72_1_2_L1)
				local m72_1_2_L2, m72_1_2_L3, m72_1_2_L4, m72_1_2_L5, m72_1_2_L6, m72_1_2_L7, m72_1_2_L8, m72_1_2_r2, m72_1_2_r3, m72_1_2_r4
				m72_1_2_L2 = (m72_L3:getUnlocked())
				for m72_1_2_L3, m72_1_2_L4 in ipairs(m72_L1.sections[1].items) do
					if not m72_1_2_L2[m72_1_2_L4.name] then
						if m72_L2:canBuy(m72_1_2_L4.name) then
							return m72_L2:buyMissingWeapon()
						else
							m72_1_2_L5 = m72_L1.itemPrices[m72_1_2_L4.name]
							m72_1_2_L6 = (m72_L2:getMissingMaterials(m72_1_2_L4.name))
							if next(m72_1_2_L6) then
								m72_1_2_L7 = nil
								for m72_1_2_L8 in pairs(m72_1_2_L6) do
									if m72_1_2_L1.materials[m72_1_2_L8] then
										m72_1_2_L7 = m72_1_2_L8
										break
									else
									end
								end
								m72_1_2_r3 = m72_1_2_L7
								m72_1_2_r2 = m72_1_2_r3 and (m72_1_2_L1:farmMaterial(m72_1_2_L7))
								if m72_1_2_r2 then
									return true
								else
								end
							else
								m72_1_2_r2 = m72_L6("Money")
								m72_1_2_r4 = m72_1_2_L5.Money
								m72_1_2_r3 = m72_1_2_r4 or 0
								if m72_1_2_r2 < m72_1_2_r3 then
									return false
								else
								end
							end
						end
					end
				end
				return false
			end
			m72_1_L1.unlockQuestLimit = function(m72_1_3_L1)
				if m72_L6("MaxQuest") >= m72_L5.maxQuest then
					return false
				else
					return m72_1_3_L1:upgradeQuestLimit()
				end
			end
			m72_1_L1.unlockGamepasses = function(m72_1_4_L1)
				if m72_L7() < m72_L5.level.gamepasses then
					return false
				else
					if m72_L2:buyGamepasses() then
						return false
					else
						return m72_1_4_L1:farmRaid()
					end
				end
			end
		end
	end
end)


-- === tasks: priority task registry used by the farm loop ===
tasks = lazy(function()
	local Q = monsterData()
	local k = {}
	k["spawnBoss"] = Q["spawnBoss"]
	k["materials"] = Q["materials"];
	((farming()))(k);
	((raidFarm()))(k);
	((bossFarm()))(k);
	((raceFarm()))(k);
	((oneClick()))(k);
	((unlocks()))(k)
	return k
end)


-- === oneClickTask: priority: one-click ===
oneClickTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "oneClick",
		["run"] = function()
			return (Q):oneClick()
		end,
	}
end)


-- === floppaSwordTask: priority: Floppa sword ===
floppaSwordTask = lazy(function()
	local Q = tasks()
	local k = inventory()
	return {
		["flag"] = "floppaSword",
		["run"] = function()
			if not (k):verifySword("Floppa") then
				return (Q):getFloppaSword()
			end
		end,
	}
end)


-- === memeBeastTask: priority: Meme Beast ===
memeBeastTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "memeBeast",
		["run"] = function()
			return (Q):killMemeBeast()
		end,
	}
end)


-- === lordSusTask: priority: Lord Sus ===
lordSusTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "lordSus",
		["run"] = function()
			return (Q):farmRaidBoss("Lord Sus", true)
		end,
	}
end)


-- === evilNoobTask: priority: Evil Noob ===
evilNoobTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "evilNoob",
		["run"] = function()
			return (Q):farmRaidBoss("Evil Noob", true)
		end,
	}
end)


-- === giantPumpkinTask: priority: Giant Pumpkin ===
giantPumpkinTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "giantPumpkin",
		["run"] = function()
			return (Q):farmRaidBoss("Giant Pumpkin", true)
		end,
	}
end)


-- === raceV2Task: priority: race V2 orb ===
raceV2Task = lazy(function()
	local Q = tasks()
	local k = playerData()
	local b = requirements()
	local T = k["getPlayerLevel"]
	return {
		["flag"] = "raceV2Orb",
		["run"] = function()
			if T() >= b["level"]["raceV2Orb"] then
				return (Q):farmRaceOrb()
			end
		end,
	}
end)


-- === ballerUnlockTask: priority: Baller unlock ===
ballerUnlockTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "unlockBaller",
		["run"] = function()
			return (Q):unlockBaller()
		end,
	}
end)


-- === weaponsUnlockTask: priority: weapons unlock ===
weaponsUnlockTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "unlockWeapons",
		["run"] = function()
			return (Q):unlockWeapons()
		end,
	}
end)


-- === questLimitTask: priority: quest limit ===
questLimitTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "unlockQuestLimit",
		["run"] = function()
			return (Q):unlockQuestLimit()
		end,
	}
end)


-- === gamepassesTask: priority: gamepasses ===
gamepassesTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "unlockGamepasses",
		["run"] = function()
			return (Q):unlockGamepasses()
		end,
	}
end)


-- === levelFarmTask: priority: level farm ===
levelFarmTask = lazy(function()
	local Q = tasks()
	return {
		["flag"] = "levelFarm",
		["run"] = function()
			return (Q):farmLevel()
		end,
	}
end)


-- === raidFarmTask: priority: raid farm ===
raidFarmTask = lazy(function()
	local Q = tasks()
	local k = playerData()
	local b = requirements()
	local T = k["getPlayerLevel"]
	return {
		["flag"] = "raidFarm",
		["run"] = function()
			if T() >= b["level"]["raid"] then
				return (Q):farmRaid()
			end
		end,
	}
end)


-- === selectedEnemyTask: priority: selected enemy / quest ===
selectedEnemyTask = lazy(function()
	local Q = environment()
	local k = tasks()
	local b = Q["environment"]
	return {
		["flag"] = "farmSelectedEnemy",
		["run"] = function()
			return (k):farmEnemy(b["selectedEnemy"], b["takeSelectedQuest"])
		end,
	}
end)


-- === nearestFarmTask: priority: nearest enemy ===
nearestFarmTask = lazy(function()
	local Q = playerApi()
	local k = entities()
	return {
		["flag"] = "nearestFarm",
		["run"] = function()
			return Q["killEnemy"](k["getEnemy"]())
		end,
	}
end)


-- === taskList: ordered priority list for the farm loop ===
taskList = lazy(function()
	return {
		oneClickTask(),
		floppaSwordTask(),
		memeBeastTask(),
		lordSusTask(),
		evilNoobTask(),
		giantPumpkinTask(),
		raceV2Task(),
		ballerUnlockTask(),
		weaponsUnlockTask(),
		questLimitTask(),
		gamepassesTask(),
		levelFarmTask(),
		raidFarmTask(),
		selectedEnemyTask(),
		nearestFarmTask(),
	}
end)


-- === antiAfk: anti-AFK loop ===
antiAfk = lazy(function()
	local m82_L1, m82_L2
	m82_L1 = (environment())
	m82_L2 = (settings())
	do
		return function()
			if m82_L1.environment.loadedAntiAfk then
				return
			else
				m82_L1.environment.loadedAntiAfk = true
				m82_L1.spawn(function()
					local m82_1_1_r1
					while true do
						if not (m82_L1.wait(600)) then
							break
						end
						if m82_L2.antiAfk then
							m82_L1.virtualUser:CaptureController()
							m82_1_1_r1 = m82_L1.virtualUser:ClickButton2(Vector2.new())
						end
					end
				end)
			end
		end
	end
end)


-- === startupPatches: startup patches (gamepass ids, name tag, aimbot hook, no-stun) ===
startupPatches = lazy(function()
	local m85_L1, m85_L2, m85_L3, m85_L4, m85_L5, m85_L6, m85_L7, m85_L8, m85_L9
	m85_L1 = (environment())
	m85_L2 = (gameData())
	m85_L3 = (gameSettings())
	m85_L4 = (gamepasses())
	m85_L5 =
		'local environment = ...\n\nlocal oldNamecall\noldNamecall = hookmetamethod(game, "__namecall", function(self, ...)\n\tif getnamecallmethod():lower() == "fireserver" and self.Name == "Server_Skills" then\n\t\tlocal latestAttack = environment.latestAttack\n\t\tif latestAttack and latestAttack.aimBot then\n\t\t\treturn latestAttack.aimBot(oldNamecall, self, ...)\n\t\tend\n\tend\n\treturn oldNamecall(self, ...)\nend)\n'
	m85_L6 = m85_L1.localPlayer
	m85_L7 = m85_L1.runService
	m85_L8 = m85_L1.environment
	m85_L9 = m85_L1.spawn
	do
		return function()
			m85_L9(function()
				local m85_1_1_L1, m85_1_1_L2, m85_1_1_r1
				for m85_1_1_L1, m85_1_1_L2 in ipairs(require(m85_L2.gameModules.Gamepass_Assets)) do
					m85_L4.ids[m85_1_1_L2.Asset_Name] = m85_1_1_L2.GamepassId
				end
			end)
			m85_L9(function()
				local m85_1_2_L1, m85_1_2_L2
				if m85_L8.loadedAnonymousName then
					return
				else
					m85_L8.loadedAnonymousName = true
					m85_1_2_L1 = m85_L6.PlayerGui.MainGui.PlayerName
					m85_1_2_L2 = function()
						local m85_1_2_1_L1, m85_1_2_1_L2, m85_1_2_1_r1, m85_1_2_1_r2, m85_1_2_1_r3, m85_1_2_1_r4, m85_1_2_1_r5, m85_1_2_1_r6, m85_1_2_1_r7
						m85_1_2_1_L1 = m85_L2.playerLevel.Value
						m85_1_2_1_L2 = (m85_1_2_1_L1 >= m85_L3.maxLevel)
						m85_1_2_1_r1 = m85_1_2_L1
						m85_1_2_1_r2 = "Text"
						m85_1_2_1_r3 = ("%s  Lv. %i%s")["format"]
						m85_1_2_1_r4 = "Anonymous"
						m85_1_2_1_r5 = m85_1_2_1_L1
						m85_1_2_1_r7 = m85_1_2_1_L2
						m85_1_2_1_r6 = m85_1_2_1_r7 and " (Max)"
						m85_1_2_1_r7 = m85_1_2_1_r6 or ""
						m85_1_2_1_r1[m85_1_2_1_r2] = (
							m85_1_2_1_r3(m85_1_2_1_r4, m85_1_2_1_r5, m85_1_2_1_r7)
						)
					end
					m85_1_2_L1:GetPropertyChangedSignal("Text"):Connect(m85_1_2_L2)
					m85_1_2_L2()
				end
			end)
			m85_L9(function()
				if m85_L8.loadedAimBot then
					return
				else
					xpcall(function()
						local m85_1_3_1_L1, m85_1_3_1_L2, m85_1_3_1_r1
						m85_1_3_1_r1 = { loadstring(m85_L5, "=AimBotHook") }
						m85_1_3_1_L1 = m85_1_3_1_r1[1]
						m85_1_3_1_L2 = m85_1_3_1_r1[2]
						assert(m85_1_3_1_L1, m85_1_3_1_L2)
						m85_1_3_1_L1(m85_L8)
						m85_L8.loadedAimBot = true
					end, function(...)
						print("!ERROR! Erro ao carregar o hook do AimBot: ", ...)
					end)
				end
			end)
			m85_L9(function()
				if m85_L8.loadedNearestPlayer then
					return
				else
					m85_L8.loadedNearestPlayer = true
					m85_L7.Stepped:Connect(function()
						local m85_1_4_1_L1, m85_1_4_1_L2, m85_1_4_1_L3, m85_1_4_1_L4, m85_1_4_1_L5, m85_1_4_1_L6, m85_1_4_1_r1, m85_1_4_1_r2, m85_1_4_1_r3
						m85_1_4_1_L1 = 1000
						m85_1_4_1_L2 = false
						if m85_L8.aimBotPlayers then
							for m85_1_4_1_L3, m85_1_4_1_L4 in ipairs(m85_L2.characters:GetChildren()) do
								m85_1_4_1_L5 = m85_1_4_1_L4.PrimaryPart
								m85_1_4_1_r3 = (m85_1_4_1_L4 ~= m85_L6.Character)
								m85_1_4_1_r2 = m85_1_4_1_r3 and m85_1_4_1_L5
								if m85_1_4_1_r2 then
									m85_1_4_1_L6 = (m85_L6:DistanceFromCharacter(m85_1_4_1_L5.Position))
									if m85_1_4_1_L6 < m85_1_4_1_L1 then
										m85_1_4_1_L1 = m85_1_4_1_L6
										m85_1_4_1_L2 = m85_1_4_1_L5
									else
									end
								end
							end
						end
						m85_L8.nearestPlayer = m85_1_4_1_L2
					end)
				end
			end)
			m85_L9(function()
				local m85_1_5_L1
				if m85_L8.loadedNoStun then
					return
				else
					m85_L8.loadedNoStun = true
					m85_1_5_L1 = function(m85_1_5_1_L1)
						local m85_1_5_1_L2
						m85_1_5_1_L2 = (m85_1_5_1_L1:WaitForChild("Stun"))
						m85_1_5_1_L2:GetPropertyChangedSignal("Value"):Connect(function()
							if m85_L8.noStun then
								m85_1_5_1_L2.Value = 0
							end
						end)
					end
					m85_L6.CharacterAdded:Connect(m85_1_5_L1)
					if m85_L6.Character then
						m85_1_5_L1(m85_L6.Character)
					end
				end
			end)
		end
	end
end)


-- === uiConfig: window, tab and Discord configuration ===
uiConfig = lazy(function()
	local m89_L1
	m89_L1 = (discordInvite())
	return {
		window = {
			title = "NhoiiiX : Meme Sea",
			subtitle = "by NhoiiiX",
			scriptFolder = "redzHub-MemeSea.json",
		},
		minimizeLogo = "rbxassetid://75850663384500",
		discord = {
			title = "NhoiiiX | Community",
			description = "Join our discord community to receive information about the next update",
			logo = "rbxassetid://75850663384500",
			invite = m89_L1,
		},
		tabs = {
			discord = { title = "Discord", icon = "Info" },
			mainFarm = { title = "Farm", icon = "Home" },
			items = { title = "Items", icon = "Swords" },
			powers = { title = "Powers", icon = "Apple" },
			stats = { title = "Stats", icon = "Signal" },
			teleport = { title = "Teleport", icon = "Locate" },
			shop = { title = "Shop", icon = "ShoppingCart" },
			pvp = { title = "PvP", icon = "User" },
			oneClick = { title = "One-Click", icon = "mouse-pointer-click" },
			misc = { title = "Misc", icon = "Settings" },
		},
	}
end)


-- === localeEN: English strings ===
localeEN = lazy(function()
	return {
		Discord = "Discord",
		Farm = "Farm",
		Items = "Items",
		Powers = "Powers",
		Stats = "Stats",
		Teleport = "Teleport",
		Shop = "Shop",
		PvP = "PvP",
		["One-Click"] = "One-Click",
		Misc = "Misc",
		["Farm Tool"] = "Farm Tool",
		["UI Scale"] = "UI Scale",
		Small = "Small",
		Medium = "Medium",
		Large = "Large",
		Fight = "Fight",
		Power = "Power",
		Weapon = "Weapon",
		["Auto Farm Level"] = "Auto Farm Level",
		["MaxLevel: %i"] = "MaxLevel: %i",
		["Auto Farm Nearest"] = "Auto Farm Nearest",
		Enemies = "Enemies",
		["Select Enemie"] = "Select Enemie",
		["Auto Farm Selected"] = "Auto Farm Selected",
		["Take Quest [ Enemie Selected ]"] = "Take Quest [ Enemie Selected ]",
		["Sea Event"] = "Sea Event",
		["Auto Meme Beast [ Spawns every 30 Minutes ]"] = "Auto Meme Beast [ Spawns every 30 Minutes ]",
		["Drops: Portal ( <25% ), Meme Cube ( <50% )"] = "Drops: Portal ( <25% ), Meme Cube ( <50% )",
		Raid = "Raid",
		["Auto Farm Raid"] = "Auto Farm Raid",
		["Req: Level %i"] = "Req: Level %i",
		Skills = "Skills",
		["Select Skills"] = "Select Skills",
		["Auto Use Skills"] = "Auto Use Skills",
		Bosses = "Bosses",
		["Auto Giant Pumpkin"] = "Auto Giant Pumpkin",
		["Drops: Pumpkin Head ( <10% ), Nugget Man ( <25% )"] = "Drops: Pumpkin Head ( <10% ), Nugget Man ( <25% )",
		["Auto Evil Noob"] = "Auto Evil Noob",
		["Drops: Yellow Blade ( <5% ), Noob Friend ( <10% )"] = "Drops: Yellow Blade ( <5% ), Noob Friend ( <10% )",
		["Auto Lord Sus"] = "Auto Lord Sus",
		["Drops: Purple Katana ( <5% ), Sus Pals ( <10% )"] = "Drops: Purple Katana ( <5% ), Sus Pals ( <10% )",
		Race = "Race",
		["Auto Awakening Orb"] = "Auto Awakening Orb",
		Floppa = "Floppa",
		["Auto Floppa [ Exclusive Weapon ]"] = "Auto Floppa [ Exclusive Weapon ]",
		Popcat = "Popcat",
		["Clicks per Second"] = "Clicks per Second",
		["Auto Popcat"] = "Auto Popcat",
		Unlock = "Unlock",
		["Auto Baller"] = "Auto Baller",
		["Farms 10 balls and buys Baller"] = "Farms 10 balls and buys Baller",
		["Auto Weapons"] = "Auto Weapons",
		["Farms the materials and unlocks the Weapons section"] = "Farms the materials and unlocks the Weapons section",
		["Auto Quest Limit"] = "Auto Quest Limit",
		["Uses the Quest Scroll (or buys it)"] = "Uses the Quest Scroll (or buys it)",
		["Auto Gamepasses"] = "Auto Gamepasses",
		["From level %i: farms gems and buys all gamepasses"] = "From level %i: farms gems and buys all gamepasses",
		Drops = "Drops",
		["Collect all drops"] = "Collect all drops",
		["Drop all powers"] = "Drop all powers",
		Store = "Store",
		["Auto Store Powers"] = "Auto Store Powers",
		Unstore = "Unstore",
		["Select Power"] = "Select Power",
		["Unstore Amount"] = "Unstore Amount",
		["Number: 1-99"] = "Number: 1-99",
		["Unstore Power"] = "Unstore Power",
		["Power Gacha"] = "Power Gacha",
		["Gacha Type"] = "Gacha Type",
		Money = "Money",
		Gem = "Gem",
		["Gacha Amount"] = "Gacha Amount",
		["Roll Powers"] = "Roll Powers",
		["Auto Reroll Power"] = "Auto Reroll Power",
		["Aura Color"] = "Aura Color",
		["Auto Reroll Aura"] = "Auto Reroll Aura",
		Others = "Others",
		["Remove Gacha Animation"] = "Remove Gacha Animation",
		["Destroy stored Powers"] = "Destroy stored Powers",
		["Points Amount"] = "Points Amount",
		["Auto Stats"] = "Auto Stats",
		["Select Stats"] = "Select Stats",
		Health = "Health",
		Melee = "Melee",
		Locations = "Locations",
		Islands = "Islands",
		Quests = "Quests",
		["Bounty/Fame"] = "Bounty/Fame",
		["Teleport to random player"] = "Teleport to random player",
		AimBot = "AimBot",
		["AimBot Players"] = "AimBot Players",
		["AimBot Monsters"] = "AimBot Monsters",
		Esp = "Esp",
		["Esp Players"] = "Esp Players",
		["Esp Islands"] = "Esp Islands",
		["Safe Zone"] = "Safe Zone",
		["PvP On"] = "PvP On",
		["PvP Off"] = "PvP Off",
		["Auto Buy"] = "Auto Buy",
		["Auto Buy Abilities"] = "Auto Buy Abilities",
		["Aura, Instinct & Flash Step"] = "Aura, Instinct & Flash Step",
		Weapons = "Weapons",
		Ability = "Ability",
		["Fighting Style"] = "Fighting Style",
		["Buy %s"] = "Buy %s",
		["Start One Click [ BETA ]"] = "Start One Click [ BETA ]",
		Settings = "Settings",
		["Buy all gamepass"] = "Buy all gamepass",
		["farm gems and buy all gamepass"] = "farm gems and buy all gamepass",
		["Awaken Race V2"] = "Awaken Race V2",
		["get race V2 if you don't have"] = "get race V2 if you don't have",
		["Upgrade quest limit"] = "Upgrade quest limit",
		["buy quest scroll and use"] = "buy quest scroll and use",
		["Get all aura Colors"] = "Get all aura Colors",
		["get all aura colors after purchasing the aura"] = "get all aura colors after purchasing the aura",
		["End-Game"] = "End-Game",
		["Farm Lord Sus"] = "Farm Lord Sus",
		["Farm Evil Noob"] = "Farm Evil Noob",
		["Farm Raid"] = "Farm Raid",
		["Redeem All Codes"] = "Redeem All Codes",
		["Job id"] = "Job id",
		["Input Job Id"] = "Input Job Id",
		["Join From Clipboard"] = "Join From Clipboard",
		["Farm Distance"] = "Farm Distance",
		["Auto Aura"] = "Auto Aura",
		["Auto Attack"] = "Auto Attack",
		["Bring Mobs"] = "Bring Mobs",
		["Anti AFK"] = "Anti AFK",
		["Auto Equip"] = "Auto Equip",
		["Sword & accessory"] = "Sword & accessory",
		Team = "Team",
		["Join Cheems Team"] = "Join Cheems Team",
		["Join Floppa Team"] = "Join Floppa Team",
		["Remove Notifications"] = "Remove Notifications",
		["No Stun"] = "No Stun",
		["Inf sky jump"] = "Inf sky jump",
		Language = "Language",
		["Language changes apply on next run."] = "Language changes apply on next run.",
		auto = "auto",
		["Infinite Damage"] = "Infinite Damage",
		["Works with: Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power."] = "Works with: Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power.",
	}
end)


-- === localePT: Portuguese strings ===
localePT = lazy(function()
	return {
		Discord = "Discord",
		Farm = "Farm",
		Items = "Itens",
		Powers = "Poderes",
		Stats = "Atributos",
		Teleport = "Teleporte",
		Shop = "Loja",
		PvP = "PvP",
		["One-Click"] = "Um clique",
		Misc = "Diversos",
		["Farm Tool"] = "Ferramenta de farm",
		["UI Scale"] = "Escala da interface",
		Small = "Pequena",
		Medium = "Média",
		Large = "Grande",
		Fight = "Luta",
		Power = "Poder",
		Weapon = "Arma",
		["Auto Farm Level"] = "Farm automático de nível",
		["MaxLevel: %i"] = "Nível máximo: %i",
		["Auto Farm Nearest"] = "Farm do inimigo mais próximo",
		Enemies = "Inimigos",
		["Select Enemie"] = "Selecionar inimigo",
		["Auto Farm Selected"] = "Farm do inimigo selecionado",
		["Take Quest [ Enemie Selected ]"] = "Aceitar missão [inimigo selecionado]",
		["Sea Event"] = "Evento do mar",
		["Auto Meme Beast [ Spawns every 30 Minutes ]"] = "Meme Beast automático [aparece a cada 30 minutos]",
		["Drops: Portal ( <25% ), Meme Cube ( <50% )"] = "Drops: Portal (<25%), Meme Cube (<50%)",
		Raid = "Raid",
		["Auto Farm Raid"] = "Farm automático de raid",
		["Req: Level %i"] = "Requer nível %i",
		Skills = "Habilidades",
		["Select Skills"] = "Selecionar habilidades",
		["Auto Use Skills"] = "Usar habilidades automaticamente",
		Bosses = "Chefes",
		["Auto Giant Pumpkin"] = "Giant Pumpkin automático",
		["Drops: Pumpkin Head ( <10% ), Nugget Man ( <25% )"] = "Drops: Pumpkin Head (<10%), Nugget Man (<25%)",
		["Auto Evil Noob"] = "Evil Noob automático",
		["Drops: Yellow Blade ( <5% ), Noob Friend ( <10% )"] = "Drops: Yellow Blade (<5%), Noob Friend (<10%)",
		["Auto Lord Sus"] = "Lord Sus automático",
		["Drops: Purple Katana ( <5% ), Sus Pals ( <10% )"] = "Drops: Purple Katana (<5%), Sus Pals (<10%)",
		Race = "Raça",
		["Auto Awakening Orb"] = "Orbe do despertar automático",
		Floppa = "Floppa",
		["Auto Floppa [ Exclusive Weapon ]"] = "Floppa automático [arma exclusiva]",
		Popcat = "Popcat",
		["Clicks per Second"] = "Cliques por segundo",
		["Auto Popcat"] = "Popcat automático",
		Unlock = "Desbloquear",
		["Auto Baller"] = "Baller automático",
		["Farms 10 balls and buys Baller"] = "Coleta 10 bolas e compra Baller",
		["Auto Weapons"] = "Armas automáticas",
		["Farms the materials and unlocks the Weapons section"] = "Coleta materiais e desbloqueia as armas",
		["Auto Quest Limit"] = "Limite de missões automático",
		["Uses the Quest Scroll (or buys it)"] = "Usa o Quest Scroll (ou compra)",
		["Auto Gamepasses"] = "Gamepasses automáticos",
		["From level %i: farms gems and buys all gamepasses"] = "A partir do nível %i: coleta gemas e compra todos os gamepasses",
		Drops = "Drops",
		["Collect all drops"] = "Coletar todos os drops",
		["Drop all powers"] = "Soltar todos os poderes",
		Store = "Armazenar",
		["Auto Store Powers"] = "Armazenar poderes automaticamente",
		Unstore = "Retirar do armazenamento",
		["Select Power"] = "Selecionar poder",
		["Unstore Amount"] = "Quantidade para retirar",
		["Number: 1-99"] = "Número: 1-99",
		["Unstore Power"] = "Retirar poder",
		["Power Gacha"] = "Gacha de poderes",
		["Gacha Type"] = "Tipo de gacha",
		Money = "Dinheiro",
		Gem = "Gemas",
		["Gacha Amount"] = "Quantidade de gachas",
		["Roll Powers"] = "Girar poderes",
		["Auto Reroll Power"] = "Girar poderes automaticamente",
		["Aura Color"] = "Cor da aura",
		["Auto Reroll Aura"] = "Girar aura automaticamente",
		Others = "Outros",
		["Remove Gacha Animation"] = "Remover animação do gacha",
		["Destroy stored Powers"] = "Destruir poderes com estoque cheio",
		["Points Amount"] = "Quantidade de pontos",
		["Auto Stats"] = "Atributos automáticos",
		["Select Stats"] = "Selecionar atributos",
		Health = "Vida",
		Melee = "Corpo a corpo",
		Locations = "Locais",
		Islands = "Ilhas",
		Quests = "Missões",
		["Bounty/Fame"] = "Recompensa/Fama",
		["Teleport to random player"] = "Teleportar para um jogador aleatório",
		AimBot = "AimBot",
		["AimBot Players"] = "AimBot em jogadores",
		["AimBot Monsters"] = "AimBot em monstros",
		Esp = "ESP",
		["Esp Players"] = "ESP de jogadores",
		["Esp Islands"] = "ESP de ilhas",
		["Safe Zone"] = "Zona segura",
		["PvP On"] = "PvP ativo",
		["PvP Off"] = "PvP desativado",
		["Auto Buy"] = "Compra automática",
		["Auto Buy Abilities"] = "Comprar habilidades automaticamente",
		["Aura, Instinct & Flash Step"] = "Aura, Instinct e Flash Step",
		Weapons = "Armas",
		Ability = "Habilidades",
		["Fighting Style"] = "Estilo de luta",
		["Buy %s"] = "Comprar %s",
		["Start One Click [ BETA ]"] = "Iniciar um clique [BETA]",
		Settings = "Configurações",
		["Buy all gamepass"] = "Comprar todos os gamepasses",
		["farm gems and buy all gamepass"] = "Coleta gemas e compra todos os gamepasses",
		["Awaken Race V2"] = "Despertar raça V2",
		["get race V2 if you don't have"] = "Obtém a raça V2 se ainda não tiver",
		["Upgrade quest limit"] = "Aumentar limite de missões",
		["buy quest scroll and use"] = "Compra e usa o Quest Scroll",
		["Get all aura Colors"] = "Obter todas as cores de aura",
		["get all aura colors after purchasing the aura"] = "Obtém todas as cores após comprar a aura",
		["End-Game"] = "Objetivo final",
		["Farm Lord Sus"] = "Farm de Lord Sus",
		["Farm Evil Noob"] = "Farm de Evil Noob",
		["Farm Raid"] = "Farm de raid",
		["Redeem All Codes"] = "Resgatar todos os códigos",
		["Job id"] = "ID do servidor",
		["Input Job Id"] = "Inserir ID do servidor",
		["Join From Clipboard"] = "Entrar usando área de transferência",
		["Farm Distance"] = "Distância de farm",
		["Auto Aura"] = "Aura automática",
		["Auto Attack"] = "Ataque automático",
		["Bring Mobs"] = "Agrupar inimigos",
		["Anti AFK"] = "Anti AFK",
		["Auto Equip"] = "Equipar automaticamente",
		["Sword & accessory"] = "Espada e acessório",
		Team = "Time",
		["Join Cheems Team"] = "Entrar no time Cheems",
		["Join Floppa Team"] = "Entrar no time Floppa",
		["Remove Notifications"] = "Remover notificações",
		["No Stun"] = "Sem atordoamento",
		["Inf sky jump"] = "Saltos aéreos infinitos",
		Language = "Idioma",
		["Language changes apply on next run."] = "A mudança de idioma vale na próxima execução.",
		auto = "Automático",
		["Infinite Damage"] = "Dano infinito",
		["Works with: Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power."] = "Funciona com: Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power.",
	}
end)


-- === localeES: Spanish strings ===
localeES = lazy(function()
	return {
		Discord = "Discord",
		Farm = "Farmeo",
		Items = "Objetos",
		Powers = "Poderes",
		Stats = "Estadísticas",
		Teleport = "Teletransporte",
		Shop = "Tienda",
		PvP = "PvP",
		["One-Click"] = "Un clic",
		Misc = "Varios",
		["Farm Tool"] = "Herramienta de farmeo",
		["UI Scale"] = "Escala de interfaz",
		Small = "Pequeña",
		Medium = "Mediana",
		Large = "Grande",
		Fight = "Lucha",
		Power = "Poder",
		Weapon = "Arma",
		["Auto Farm Level"] = "Subir nivel automáticamente",
		["MaxLevel: %i"] = "Nivel máximo: %i",
		["Auto Farm Nearest"] = "Farmear enemigo más cercano",
		Enemies = "Enemigos",
		["Select Enemie"] = "Seleccionar enemigo",
		["Auto Farm Selected"] = "Farmear enemigo seleccionado",
		["Take Quest [ Enemie Selected ]"] = "Aceptar misión [enemigo seleccionado]",
		["Sea Event"] = "Evento del mar",
		["Auto Meme Beast [ Spawns every 30 Minutes ]"] = "Meme Beast automático [aparece cada 30 minutos]",
		["Drops: Portal ( <25% ), Meme Cube ( <50% )"] = "Botín: Portal (<25%), Meme Cube (<50%)",
		Raid = "Incursión",
		["Auto Farm Raid"] = "Farmear incursiones",
		["Req: Level %i"] = "Requiere nivel %i",
		Skills = "Habilidades",
		["Select Skills"] = "Seleccionar habilidades",
		["Auto Use Skills"] = "Usar habilidades automáticamente",
		Bosses = "Jefes",
		["Auto Giant Pumpkin"] = "Giant Pumpkin automático",
		["Drops: Pumpkin Head ( <10% ), Nugget Man ( <25% )"] = "Botín: Pumpkin Head (<10%), Nugget Man (<25%)",
		["Auto Evil Noob"] = "Evil Noob automático",
		["Drops: Yellow Blade ( <5% ), Noob Friend ( <10% )"] = "Botín: Yellow Blade (<5%), Noob Friend (<10%)",
		["Auto Lord Sus"] = "Lord Sus automático",
		["Drops: Purple Katana ( <5% ), Sus Pals ( <10% )"] = "Botín: Purple Katana (<5%), Sus Pals (<10%)",
		Race = "Raza",
		["Auto Awakening Orb"] = "Orbe de despertar automático",
		Floppa = "Floppa",
		["Auto Floppa [ Exclusive Weapon ]"] = "Floppa automático [arma exclusiva]",
		Popcat = "Popcat",
		["Clicks per Second"] = "Clics por segundo",
		["Auto Popcat"] = "Popcat automático",
		Unlock = "Desbloquear",
		["Auto Baller"] = "Baller automático",
		["Farms 10 balls and buys Baller"] = "Consigue 10 bolas y compra Baller",
		["Auto Weapons"] = "Armas automáticas",
		["Farms the materials and unlocks the Weapons section"] = "Consigue materiales y desbloquea las armas",
		["Auto Quest Limit"] = "Límite de misiones automático",
		["Uses the Quest Scroll (or buys it)"] = "Usa el Quest Scroll (o lo compra)",
		["Auto Gamepasses"] = "Pases automáticos",
		["From level %i: farms gems and buys all gamepasses"] = "Desde el nivel %i: consigue gemas y compra todos los pases",
		Drops = "Botín",
		["Collect all drops"] = "Recoger todo el botín",
		["Drop all powers"] = "Soltar todos los poderes",
		Store = "Guardar",
		["Auto Store Powers"] = "Guardar poderes automáticamente",
		Unstore = "Retirar del almacén",
		["Select Power"] = "Seleccionar poder",
		["Unstore Amount"] = "Cantidad a retirar",
		["Number: 1-99"] = "Número: 1-99",
		["Unstore Power"] = "Retirar poder",
		["Power Gacha"] = "Gacha de poderes",
		["Gacha Type"] = "Tipo de gacha",
		Money = "Dinero",
		Gem = "Gemas",
		["Gacha Amount"] = "Cantidad de gachas",
		["Roll Powers"] = "Girar poderes",
		["Auto Reroll Power"] = "Girar poderes automáticamente",
		["Aura Color"] = "Color del aura",
		["Auto Reroll Aura"] = "Girar aura automáticamente",
		Others = "Otros",
		["Remove Gacha Animation"] = "Quitar animación del gacha",
		["Destroy stored Powers"] = "Destruir poderes con almacén lleno",
		["Points Amount"] = "Cantidad de puntos",
		["Auto Stats"] = "Estadísticas automáticas",
		["Select Stats"] = "Seleccionar estadísticas",
		Health = "Salud",
		Melee = "Cuerpo a cuerpo",
		Locations = "Lugares",
		Islands = "Islas",
		Quests = "Misiones",
		["Bounty/Fame"] = "Recompensa/Fama",
		["Teleport to random player"] = "Teletransportarse a un jugador aleatorio",
		AimBot = "AimBot",
		["AimBot Players"] = "AimBot para jugadores",
		["AimBot Monsters"] = "AimBot para monstruos",
		Esp = "ESP",
		["Esp Players"] = "ESP de jugadores",
		["Esp Islands"] = "ESP de islas",
		["Safe Zone"] = "Zona segura",
		["PvP On"] = "PvP activo",
		["PvP Off"] = "PvP desactivado",
		["Auto Buy"] = "Compra automática",
		["Auto Buy Abilities"] = "Comprar habilidades automáticamente",
		["Aura, Instinct & Flash Step"] = "Aura, Instinct y Flash Step",
		Weapons = "Armas",
		Ability = "Habilidades",
		["Fighting Style"] = "Estilo de lucha",
		["Buy %s"] = "Comprar %s",
		["Start One Click [ BETA ]"] = "Iniciar un clic [BETA]",
		Settings = "Ajustes",
		["Buy all gamepass"] = "Comprar todos los pases",
		["farm gems and buy all gamepass"] = "Consigue gemas y compra todos los pases",
		["Awaken Race V2"] = "Despertar raza V2",
		["get race V2 if you don't have"] = "Obtiene la raza V2 si aún no la tienes",
		["Upgrade quest limit"] = "Aumentar límite de misiones",
		["buy quest scroll and use"] = "Compra y usa el Quest Scroll",
		["Get all aura Colors"] = "Obtener todos los colores de aura",
		["get all aura colors after purchasing the aura"] = "Obtiene todos los colores tras comprar el aura",
		["End-Game"] = "Objetivo final",
		["Farm Lord Sus"] = "Farmear Lord Sus",
		["Farm Evil Noob"] = "Farmear Evil Noob",
		["Farm Raid"] = "Farmear incursiones",
		["Redeem All Codes"] = "Canjear todos los códigos",
		["Job id"] = "ID del servidor",
		["Input Job Id"] = "Introducir ID del servidor",
		["Join From Clipboard"] = "Entrar desde el portapapeles",
		["Farm Distance"] = "Distancia de farmeo",
		["Auto Aura"] = "Aura automática",
		["Auto Attack"] = "Ataque automático",
		["Bring Mobs"] = "Agrupar enemigos",
		["Anti AFK"] = "Anti AFK",
		["Auto Equip"] = "Equipar automáticamente",
		["Sword & accessory"] = "Espada y accesorio",
		Team = "Equipo",
		["Join Cheems Team"] = "Unirse al equipo Cheems",
		["Join Floppa Team"] = "Unirse al equipo Floppa",
		["Remove Notifications"] = "Quitar notificaciones",
		["No Stun"] = "Sin aturdimiento",
		["Inf sky jump"] = "Saltos aéreos infinitos",
		Language = "Idioma",
		["Language changes apply on next run."] = "El cambio de idioma se aplica en la próxima ejecución.",
		auto = "Automático",
		["Infinite Damage"] = "Daño infinito",
		["Works with: Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power."] = "Funciona con: Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power.",
	}
end)


-- === localeFR: French strings ===
localeFR = lazy(function()
	return {
		Discord = "Discord",
		Farm = "Farm",
		Items = "Objets",
		Powers = "Pouvoirs",
		Stats = "Statistiques",
		Teleport = "Téléportation",
		Shop = "Boutique",
		PvP = "JcJ",
		["One-Click"] = "Un clic",
		Misc = "Divers",
		["Farm Tool"] = "Outil de farm",
		["UI Scale"] = "Échelle de l'interface",
		Small = "Petite",
		Medium = "Moyenne",
		Large = "Grande",
		Fight = "Combat",
		Power = "Pouvoir",
		Weapon = "Arme",
		["Auto Farm Level"] = "Monter de niveau automatiquement",
		["MaxLevel: %i"] = "Niveau maximum : %i",
		["Auto Farm Nearest"] = "Farmer l'ennemi le plus proche",
		Enemies = "Ennemis",
		["Select Enemie"] = "Choisir un ennemi",
		["Auto Farm Selected"] = "Farmer l'ennemi choisi",
		["Take Quest [ Enemie Selected ]"] = "Accepter la quête [ennemi choisi]",
		["Sea Event"] = "Événement marin",
		["Auto Meme Beast [ Spawns every 30 Minutes ]"] = "Meme Beast automatique [toutes les 30 minutes]",
		["Drops: Portal ( <25% ), Meme Cube ( <50% )"] = "Butin : Portal (<25 %), Meme Cube (<50 %)",
		Raid = "Raid",
		["Auto Farm Raid"] = "Farmer les raids",
		["Req: Level %i"] = "Niveau requis : %i",
		Skills = "Compétences",
		["Select Skills"] = "Choisir les compétences",
		["Auto Use Skills"] = "Utiliser les compétences automatiquement",
		Bosses = "Boss",
		["Auto Giant Pumpkin"] = "Giant Pumpkin automatique",
		["Drops: Pumpkin Head ( <10% ), Nugget Man ( <25% )"] = "Butin : Pumpkin Head (<10 %), Nugget Man (<25 %)",
		["Auto Evil Noob"] = "Evil Noob automatique",
		["Drops: Yellow Blade ( <5% ), Noob Friend ( <10% )"] = "Butin : Yellow Blade (<5 %), Noob Friend (<10 %)",
		["Auto Lord Sus"] = "Lord Sus automatique",
		["Drops: Purple Katana ( <5% ), Sus Pals ( <10% )"] = "Butin : Purple Katana (<5 %), Sus Pals (<10 %)",
		Race = "Race",
		["Auto Awakening Orb"] = "Orbe d'éveil automatique",
		Floppa = "Floppa",
		["Auto Floppa [ Exclusive Weapon ]"] = "Floppa automatique [arme exclusive]",
		Popcat = "Popcat",
		["Clicks per Second"] = "Clics par seconde",
		["Auto Popcat"] = "Popcat automatique",
		Unlock = "Débloquer",
		["Auto Baller"] = "Baller automatique",
		["Farms 10 balls and buys Baller"] = "Récolte 10 balles et achète Baller",
		["Auto Weapons"] = "Armes automatiques",
		["Farms the materials and unlocks the Weapons section"] = "Récolte les matériaux et débloque les armes",
		["Auto Quest Limit"] = "Limite de quêtes automatique",
		["Uses the Quest Scroll (or buys it)"] = "Utilise le Quest Scroll (ou l'achète)",
		["Auto Gamepasses"] = "Passes automatiques",
		["From level %i: farms gems and buys all gamepasses"] = "Dès le niveau %i : récolte des gemmes et achète tous les passes",
		Drops = "Butin",
		["Collect all drops"] = "Ramasser tout le butin",
		["Drop all powers"] = "Jeter tous les pouvoirs",
		Store = "Stocker",
		["Auto Store Powers"] = "Stocker les pouvoirs automatiquement",
		Unstore = "Retirer du stockage",
		["Select Power"] = "Choisir un pouvoir",
		["Unstore Amount"] = "Quantité à retirer",
		["Number: 1-99"] = "Nombre : 1-99",
		["Unstore Power"] = "Retirer le pouvoir",
		["Power Gacha"] = "Gacha de pouvoirs",
		["Gacha Type"] = "Type de gacha",
		Money = "Argent",
		Gem = "Gemmes",
		["Gacha Amount"] = "Nombre de gachas",
		["Roll Powers"] = "Tirer des pouvoirs",
		["Auto Reroll Power"] = "Tirer des pouvoirs automatiquement",
		["Aura Color"] = "Couleur de l'aura",
		["Auto Reroll Aura"] = "Changer l'aura automatiquement",
		Others = "Autres",
		["Remove Gacha Animation"] = "Supprimer l'animation du gacha",
		["Destroy stored Powers"] = "Détruire les pouvoirs quand le stockage est plein",
		["Points Amount"] = "Nombre de points",
		["Auto Stats"] = "Statistiques automatiques",
		["Select Stats"] = "Choisir les statistiques",
		Health = "Santé",
		Melee = "Corps à corps",
		Locations = "Lieux",
		Islands = "Îles",
		Quests = "Quêtes",
		["Bounty/Fame"] = "Prime/Renommée",
		["Teleport to random player"] = "Se téléporter vers un joueur aléatoire",
		AimBot = "AimBot",
		["AimBot Players"] = "AimBot sur les joueurs",
		["AimBot Monsters"] = "AimBot sur les monstres",
		Esp = "ESP",
		["Esp Players"] = "ESP des joueurs",
		["Esp Islands"] = "ESP des îles",
		["Safe Zone"] = "Zone sûre",
		["PvP On"] = "JcJ actif",
		["PvP Off"] = "JcJ désactivé",
		["Auto Buy"] = "Achat automatique",
		["Auto Buy Abilities"] = "Acheter les compétences automatiquement",
		["Aura, Instinct & Flash Step"] = "Aura, Instinct et Flash Step",
		Weapons = "Armes",
		Ability = "Compétences",
		["Fighting Style"] = "Style de combat",
		["Buy %s"] = "Acheter %s",
		["Start One Click [ BETA ]"] = "Démarrer un clic [BÊTA]",
		Settings = "Paramètres",
		["Buy all gamepass"] = "Acheter tous les passes",
		["farm gems and buy all gamepass"] = "Récolte des gemmes et achète tous les passes",
		["Awaken Race V2"] = "Éveiller la race V2",
		["get race V2 if you don't have"] = "Obtient la race V2 si nécessaire",
		["Upgrade quest limit"] = "Augmenter la limite de quêtes",
		["buy quest scroll and use"] = "Achète et utilise le Quest Scroll",
		["Get all aura Colors"] = "Obtenir toutes les couleurs d'aura",
		["get all aura colors after purchasing the aura"] = "Obtient toutes les couleurs après l'achat de l'aura",
		["End-Game"] = "Objectif final",
		["Farm Lord Sus"] = "Farmer Lord Sus",
		["Farm Evil Noob"] = "Farmer Evil Noob",
		["Farm Raid"] = "Farmer les raids",
		["Redeem All Codes"] = "Utiliser tous les codes",
		["Job id"] = "ID du serveur",
		["Input Job Id"] = "Saisir l'ID du serveur",
		["Join From Clipboard"] = "Rejoindre depuis le presse-papiers",
		["Farm Distance"] = "Distance de farm",
		["Auto Aura"] = "Aura automatique",
		["Auto Attack"] = "Attaque automatique",
		["Bring Mobs"] = "Regrouper les ennemis",
		["Anti AFK"] = "Anti AFK",
		["Auto Equip"] = "Équiper automatiquement",
		["Sword & accessory"] = "Épée et accessoire",
		Team = "Équipe",
		["Join Cheems Team"] = "Rejoindre l'équipe Cheems",
		["Join Floppa Team"] = "Rejoindre l'équipe Floppa",
		["Remove Notifications"] = "Supprimer les notifications",
		["No Stun"] = "Sans étourdissement",
		["Inf sky jump"] = "Sauts aériens infinis",
		Language = "Langue",
		["Language changes apply on next run."] = "Le changement de langue s'applique au prochain lancement.",
		auto = "Automatique",
		["Infinite Damage"] = "Dégâts infinis",
		["Works with: Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power."] = "Fonctionne avec : Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power.",
	}
end)


-- === locale: localisation and text formatting ===
locale = lazy(function()
	local m94_L1, m94_L2, m94_L3, m94_L4, m94_L5
	m94_L1 = (environment())
	m94_L2 = (settings())
	m94_L3 = { en = localeEN(), pt = localePT(), es = localeES(), fr = localeFR() }
	m94_L4 = {}
	m94_L5 = m94_L3.en
	m94_L4.load = function(m94_1_L1)
		local m94_1_L2, m94_1_L3, m94_1_r1, m94_1_r2, m94_1_r3, m94_1_r4
		m94_1_r2 = m94_1_L1
		m94_1_r1 = m94_1_r2 or m94_L2.language
		m94_1_L2 = m94_1_r1
		m94_1_r2 = not m94_1_L2
		m94_1_r1 = m94_1_r2 or (m94_1_L2 == "auto")
		if m94_1_r1 then
			m94_1_L2 = m94_L1.localPlayer.LocaleId
			m94_1_r2 = not m94_1_L2
			m94_1_r1 = m94_1_r2 or (m94_1_L2 == "")
			if m94_1_r1 then
				m94_1_L2 = m94_L1.localizationService.RobloxLocaleId
			else
			end
		end
		m94_1_r2 = (type(m94_1_L2) == "string")
		m94_1_r1 = m94_1_r2 and (m94_1_L2:lower():match("^%a%a"))
		m94_1_r2 = m94_1_r1 or "en"
		m94_1_L3 = m94_1_r2
		m94_1_r1 = m94_L4
		m94_1_r2 = "language"
		m94_1_r4 = m94_L3[m94_1_L3]
		m94_1_r3 = m94_1_r4 and m94_1_L3
		m94_1_r4 = m94_1_r3 or "en"
		m94_1_r1[m94_1_r2] = m94_1_r4
		m94_L5 = m94_L3[m94_L4.language]
	end
	m94_L4.get = function(m94_2_L1)
		local m94_2_L2, m94_2_r1, m94_2_r2
		m94_2_r2 = m94_2_L1
		m94_2_r1 = m94_2_r2
		if m94_2_r2 then
			m94_2_r2 = m94_L5[m94_2_L1]
			m94_2_r1 = m94_2_r2 or m94_L3.en[m94_2_L1]
			m94_2_r1 = m94_2_r1
		end
		m94_2_L2 = m94_2_r1
		if type(m94_2_L2) == "string" then
			return m94_2_L2, nil
		else
			if type(m94_2_L2) == "table" then
				m94_2_r2 = m94_2_L2[1]
				m94_2_r1 = m94_2_r2 or m94_2_L1
				return m94_2_r1, m94_2_L2[2]
			else
				m94_2_r2 = (type(m94_2_L1) == "string")
				m94_2_r1 = m94_2_r2 and (m94_2_L1:sub(1, 4) == "Buy ")
				if m94_2_r1 then
					m94_2_r2 = m94_L5["Buy %s"]
					m94_2_r1 = m94_2_r2 or "Buy %s"
					m94_2_r1 = m94_2_r1["format"]
					m94_2_r1 = m94_2_r1(m94_2_L1:sub(5))
					return m94_2_r1, nil
				else
					return m94_2_L1, nil
				end
			end
		end
	end
	m94_L4.format = function(m94_3_L1, ...)
		return string.format(m94_L4.get(m94_3_L1), ...)
	end
	return m94_L4
end)


-- === ui: UI library adapter (window, tabs, widgets) ===
ui = lazy(function()
	local m98_L1, m98_L2, m98_L3, m98_L4, m98_L5, m98_L6, m98_L7, m98_L8, m98_L9, m98_L10, m98_L11, m98_L12
	m98_L1 = (environment())
	m98_L2 = (locale())
	m98_L3 = m98_L1.environment
	m98_L4 = {}
	m98_L5 = function(m98_1_L1)
		if type(m98_1_L1) == "number" then
			return m98_1_L1
		else
			if type(m98_1_L1) == "string" then
				return tonumber(m98_1_L1)
			else
				return nil
			end
		end
	end
	m98_L6 = function(m98_2_L1)
		if typeof(m98_2_L1) == "Instance" then
			return m98_2_L1.Name
		else
			return tostring(m98_2_L1)
		end
	end
	m98_L7 = function(m98_3_L1)
		local m98_3_L2, m98_3_L3, m98_3_r1, m98_3_r2, m98_3_r3
		m98_3_r1 = { m98_L2.get(m98_3_L1[1]) }
		m98_3_L2 = m98_3_r1[1]
		m98_3_L3 = m98_3_r1[2]
		m98_3_r1 = m98_3_L2
		m98_3_r3 = m98_3_L3
		m98_3_r2 = m98_3_r3 or (m98_L2.get(m98_3_L1.description))
		return m98_3_r1, m98_3_r2
	end
	m98_L8 = function(m98_4_L1, m98_4_L2)
		local m98_4_L3, m98_4_L4, m98_4_r1, m98_4_r2
		m98_4_L3 = m98_4_L2
		if type(m98_4_L1) == "function" then
			m98_4_r2 = m98_4_L3
			m98_4_r1 = m98_4_r2 or m98_4_L1
			m98_4_L3 = m98_4_r1
		end
		m98_4_L4 = nil
		m98_4_r2 = (type(m98_4_L1) == "table")
		m98_4_r1 = m98_4_r2
		if m98_4_r2 then
			m98_4_r2 = (m98_4_L1[1] ~= nil)
			m98_4_r1 = m98_4_r2 and (m98_4_L1[2] ~= nil)
			m98_4_r1 = m98_4_r1
		end
		if m98_4_r1 then
			m98_4_L4 = m98_4_L1
		end
		return m98_4_L3, m98_4_L4
	end
	m98_L9 = function(m98_5_L1)
		local m98_5_L2, m98_5_r1, m98_5_r2
		if not m98_5_L1 then
			return nil
		else
			m98_5_L2 = m98_5_L1[1][m98_5_L1[2]]
			m98_5_r2 = (type(m98_5_L2) == "table")
			m98_5_r1 = m98_5_r2 and (next(m98_5_L2) == nil)
			if m98_5_r1 then
				return nil
			else
				return m98_5_L2
			end
		end
	end
	m98_L10 = function(m98_6_L1, m98_6_L2)
		local m98_6_L3, m98_6_r1, m98_6_r2
		m98_6_L3 = (m98_L9(m98_6_L1))
		if m98_6_L3 ~= nil then
			return m98_6_L3
		else
			m98_6_r2 = m98_6_L1
			m98_6_r1 = m98_6_r2 and (m98_6_L2 ~= nil)
			if m98_6_r1 then
				m98_6_L1[1][m98_6_L1[2]] = m98_6_L2
			end
			return m98_6_L2
		end
	end
	m98_L11 = {}
	m98_L11.__index = m98_L11
	m98_L12 = function(m98_7_L1)
		do
			return setmetatable({}, {
				__index = function(m98_7_1_L1, m98_7_1_L2)
					local m98_7_1_L3
					m98_7_1_L3 = m98_7_L1[m98_7_1_L2]
					if type(m98_7_1_L3) == "function" then
						do
							return function(m98_7_1_1_L1, ...)
								return m98_7_1_L3(m98_7_L1, ...)
							end
						end
					else
						return m98_7_1_L3
					end
				end,
				__newindex = function(m98_7_2_L1, m98_7_2_L2, m98_7_2_L3)
					if m98_7_2_L2 == "OnChanging" then
						m98_7_L1:SetTextFilter(function(m98_7_2_1_L1)
							local m98_7_2_1_L2
							m98_7_2_1_L2 = (m98_7_2_L3(m98_7_2_1_L1))
							if m98_7_2_1_L2 == nil then
								return nil
							else
								return tostring(m98_7_2_1_L2)
							end
						end)
					else
						m98_7_L1[m98_7_2_L2] = m98_7_2_L3
					end
				end,
			})
		end
	end
	m98_L11.addToggle = function(m98_8_L1, m98_8_L2)
		local m98_8_L3, m98_8_L4, m98_8_L5, m98_8_L6, m98_8_L7, m98_8_L8, m98_8_r2, m98_8_r3, m98_8_r4, m98_8_r5
		m98_8_r1 = { m98_L7(m98_8_L2) }
		m98_8_L3 = m98_8_r1[1]
		m98_8_L4 = m98_8_r1[2]
		m98_8_L5 = m98_8_L2[2]
		if type(m98_8_L5) == "string" then
			m98_8_r2 = m98_8_L4
			m98_8_r1 = m98_8_r2 or (m98_L2.get(m98_8_L5))
			m98_8_r1 = { m98_8_r1, nil }
			m98_8_L4 = m98_8_r1[1]
			m98_8_L5 = m98_8_r1[2]
		end
		m98_8_r1 = { m98_L8(m98_8_L2[3], m98_8_L2.callback) }
		m98_8_L6 = m98_8_r1[1]
		m98_8_L7 = m98_8_r1[2]
		m98_8_r1 = m98_L10
		m98_8_r2 = m98_8_L7
		m98_8_r4 = m98_8_L5
		m98_8_r3 = m98_8_r4 or false
		m98_8_L8 = (m98_8_r1(m98_8_r2, m98_8_r3) == true)

		m98_8_r2 = { Name = m98_8_L3, Description = m98_8_L4, Default = m98_8_L8 }
		m98_8_r3 = "Flag"
		m98_8_r5 = m98_8_L2.flag
		m98_8_r4 = m98_8_r5 or m98_8_L2[4]
		m98_8_r2[m98_8_r3] = m98_8_r4
		m98_8_r2.Callback = function(m98_8_1_L1)
			if m98_8_1_L1 == nil then
				return
			else
				if m98_8_L7 then
					m98_8_L7[1][m98_8_L7[2]] = m98_8_1_L1
				end
				if m98_8_L6 then
					m98_8_L6(m98_8_1_L1)
				end
			end
		end
		m98_8_L1.raw:AddToggle(m98_8_r2)
	end
	m98_L11.addDropdown = function(m98_9_L1, m98_9_L2)
		local m98_9_L3, m98_9_L4, m98_9_L5, m98_9_L6, m98_9_L7, m98_9_L8, m98_9_L9, m98_9_L10, m98_9_L11, m98_9_L12, m98_9_L13, m98_9_L14, m98_9_L15, m98_9_L16, m98_9_L17, m98_9_L18, m98_9_L19, m98_9_L20, m98_9_L21, m98_9_L22
		local m98_9_r2, m98_9_r3, m98_9_r4, m98_9_r5
		m98_9_r1 = { m98_L7(m98_9_L2) }
		m98_9_L3 = m98_9_r1[1]
		m98_9_L4 = m98_9_r1[2]
		m98_9_L5 = (m98_9_L2.multiSelect == true)
		m98_9_r1 = { m98_L8(m98_9_L2[4], m98_9_L2.callback) }
		m98_9_L6 = m98_9_r1[1]
		m98_9_L7 = m98_9_r1[2]
		m98_9_L8 = {}
		m98_9_L9 = {}
		m98_9_r1 = ipairs
		m98_9_r3 = m98_9_L2[2]
		m98_9_r2 = m98_9_r3 or {}
		for m98_9_L10, m98_9_L11 in m98_9_r1(m98_9_r2) do
			m98_9_r2 = { m98_L2.get(m98_L6(m98_9_L11)) }
			m98_9_L12 = m98_9_r2[1]
			m98_9_L8[(#m98_9_L8 + 1)] = m98_9_L12
			m98_9_L9[m98_9_L12] = m98_9_L11
		end
		m98_9_L13 = nil
		if m98_9_L5 then
			m98_9_L14 = (m98_L9(m98_9_L7))
			if m98_9_L14 == nil then
				m98_9_L14 = {}
				for m98_9_L15, m98_9_L16 in ipairs(m98_9_L8) do
					m98_9_L14[m98_L6(m98_9_L9[m98_9_L16])] = false
				end
				m98_9_r1 = ipairs
				m98_9_r3 = m98_9_L2[3]
				m98_9_r2 = m98_9_r3 or {}
				for m98_9_L17, m98_9_L18 in m98_9_r1(m98_9_r2) do
					m98_9_L14[m98_L6(m98_9_L18)] = true
				end
				if m98_9_L7 then
					m98_9_L7[1][m98_9_L7[2]] = m98_9_L14
				else
				end
			end
			m98_9_L13 = {}
			for m98_9_L19, m98_9_L20 in ipairs(m98_9_L8) do
				if m98_9_L14[m98_L6(m98_9_L9[m98_9_L20])] then
					m98_9_L13[(#m98_9_L13 + 1)] = m98_9_L20
				end
			end
		else
			m98_9_L21 = (m98_L10(m98_9_L7, m98_9_L2[3]))
			m98_9_r2 = (m98_9_L21 ~= nil)
			m98_9_r1 = m98_9_r2
			if m98_9_r2 then
				m98_9_r2 = (type(m98_9_L21) ~= "table")
				m98_9_r1 = m98_9_r2 and (m98_9_L21 ~= "")
				m98_9_r1 = m98_9_r1
			end
			if m98_9_r1 then
				m98_9_r1 = { m98_L2.get(m98_L6(m98_9_L21)) }
				m98_9_L13 = m98_9_r1[1]
			else
			end
		end
		m98_9_L22 = function(m98_9_1_L1)
			local m98_9_1_L2, m98_9_1_L3, m98_9_1_L4, m98_9_1_L5, m98_9_1_L6, m98_9_1_L7, m98_9_1_L8, m98_9_1_L9, m98_9_1_L10, m98_9_1_r1, m98_9_1_r2
			if m98_9_L5 then
				if type(m98_9_1_L1) ~= "table" then
					return
				else
					m98_9_1_L2 = m98_9_1_L1
					m98_9_1_L3 = {}
					m98_9_1_L4 = {}
					for m98_9_1_L5, m98_9_1_L6 in ipairs(m98_9_L8) do
						m98_9_1_L3[m98_L6(m98_9_L9[m98_9_1_L6])] = false
					end
					for m98_9_1_L7, m98_9_1_L8 in ipairs(m98_9_1_L2) do
						if m98_9_L9[m98_9_1_L8] ~= nil then
							m98_9_1_L3[m98_L6(m98_9_L9[m98_9_1_L8])] = true
							m98_9_1_L4[(#m98_9_1_L4 + 1)] = m98_9_L9[m98_9_1_L8]
						end
					end
					if m98_9_L7 then
						m98_9_L7[1][m98_9_L7[2]] = m98_9_1_L3
					end
					if m98_9_L6 then
						m98_9_L6(m98_9_1_L4)
					end
				end
			else
				m98_9_1_r2 = (type(m98_9_1_L1) == "table")
				m98_9_1_r1 = m98_9_1_r2 and m98_9_1_L1[1]
				m98_9_1_r2 = m98_9_1_r1 or m98_9_1_L1
				m98_9_1_L9 = m98_9_1_r2
				m98_9_1_L10 = m98_9_L9[m98_9_1_L9]
				if m98_9_1_L10 == nil then
					return
				else
					if m98_9_L7 then
						m98_9_L7[1][m98_9_L7[2]] = m98_9_1_L10
					end
					if m98_9_L6 then
						m98_9_L6(m98_9_1_L10)
					end
				end
			end
		end

		m98_9_r2 = {
			Name = m98_9_L3,
			Description = m98_9_L4,
			Options = m98_9_L8,
			Default = m98_9_L13,
			MultiSelect = m98_9_L5,
		}
		m98_9_r3 = "Flag"
		m98_9_r5 = m98_9_L2.flag
		m98_9_r4 = m98_9_r5 or m98_9_L2[5]
		m98_9_r2[m98_9_r3] = m98_9_r4
		m98_9_r2.Callback = m98_9_L22
		m98_9_L1.raw:AddDropdown(m98_9_r2)
	end
	m98_L11.addSlider = function(m98_10_L1, m98_10_L2)
		local m98_10_L3, m98_10_L4, m98_10_L5, m98_10_L6, m98_10_L7, m98_10_L8, m98_10_L9, m98_10_r2, m98_10_r3, m98_10_r4, m98_10_r5
		m98_10_r1 = { m98_L7(m98_10_L2) }
		m98_10_L3 = m98_10_r1[1]
		m98_10_L4 = m98_10_r1[2]
		m98_10_r1 = { m98_10_L2[2], m98_10_L2[3] }
		m98_10_L5 = m98_10_r1[1]
		m98_10_L6 = m98_10_r1[2]
		m98_10_r1 = { m98_L8(m98_10_L2[6], m98_10_L2.callback) }
		m98_10_L7 = m98_10_r1[1]
		m98_10_L8 = m98_10_r1[2]
		m98_10_r2 = m98_L5(m98_L10(m98_10_L8, m98_10_L2[5]))
		m98_10_r1 = m98_10_r2 or m98_10_L5
		m98_10_L9 = m98_10_r1

		m98_10_r2 = { Name = m98_10_L3, Description = m98_10_L4, Min = m98_10_L5, Max = m98_10_L6 }
		m98_10_r3 = "Increment"
		m98_10_r5 = m98_10_L2[4]
		m98_10_r4 = m98_10_r5 or 1
		m98_10_r2[m98_10_r3] = m98_10_r4
		m98_10_r2.Default = math.clamp(m98_10_L9, m98_10_L5, m98_10_L6)
		m98_10_r3 = "Flag"
		m98_10_r5 = m98_10_L2.flag
		m98_10_r4 = m98_10_r5 or m98_10_L2[7]
		m98_10_r2[m98_10_r3] = m98_10_r4
		m98_10_r2.Callback = function(m98_10_1_L1)
			if m98_10_1_L1 == nil then
				return
			else
				if m98_10_L8 then
					m98_10_L8[1][m98_10_L8[2]] = m98_10_1_L1
				end
				if m98_10_L7 then
					m98_10_L7(m98_10_1_L1)
				end
			end
		end
		m98_10_L1.raw:AddSlider(m98_10_r2)
	end
	m98_L11.addButton = function(m98_11_L1, m98_11_L2)
		local m98_11_L3, m98_11_L4, m98_11_r2, m98_11_r3, m98_11_r4, m98_11_r5
		m98_11_r1 = { m98_L7(m98_11_L2) }
		m98_11_L3 = m98_11_r1[1]
		m98_11_L4 = m98_11_r1[2]

		m98_11_r2 = { Name = m98_11_L3 }
		m98_11_r3 = "Description"
		m98_11_r5 = m98_11_L4
		m98_11_r4 = m98_11_r5 or (m98_L2.get(m98_11_L2[3]))
		m98_11_r2[m98_11_r3] = m98_11_r4
		m98_11_r2.Debounce = m98_11_L2.debounce
		m98_11_r3 = "Callback"
		m98_11_r5 = m98_11_L2[2]
		m98_11_r4 = m98_11_r5
		if not m98_11_r5 then
			m98_11_r5 = m98_11_L2.callback
			m98_11_r4 = m98_11_r5
			if not m98_11_r5 then
				m98_11_r4 = function() end
			end
			m98_11_r4 = m98_11_r4
		end
		m98_11_r2[m98_11_r3] = m98_11_r4
		m98_11_L1.raw:AddButton(m98_11_r2)
	end
	m98_L11.addTextBox = function(m98_12_L1, m98_12_L2)
		local m98_12_L3, m98_12_L4, m98_12_L5, m98_12_L6, m98_12_L7, m98_12_L8, m98_12_r2, m98_12_r3, m98_12_r4, m98_12_r5, m98_12_r6
		m98_12_r1 = { m98_L7(m98_12_L2) }
		m98_12_L3 = m98_12_r1[1]
		m98_12_L4 = m98_12_r1[2]
		m98_12_r1 = { m98_L8(m98_12_L2[4], m98_12_L2.callback) }
		m98_12_L5 = m98_12_r1[1]
		m98_12_L6 = m98_12_r1[2]
		m98_12_r1 = m98_L10
		m98_12_r2 = m98_12_L6
		m98_12_r4 = m98_L5(m98_12_L2[2])
		m98_12_r3 = m98_12_r4 or m98_12_L2[2]
		m98_12_L7 = (m98_12_r1(m98_12_r2, m98_12_r3))

		m98_12_r2 = { Name = m98_12_L3, Description = m98_12_L4 }
		m98_12_r3 = "Default"
		m98_12_r5 = (m98_12_L7 ~= nil)
		m98_12_r4 = m98_12_r5 and (tostring(m98_12_L7))
		m98_12_r5 = m98_12_r4 or nil
		m98_12_r2[m98_12_r3] = m98_12_r5
		m98_12_r2.ClearOnFocus = (m98_12_L2[3] == true)
		m98_12_r3 = "Placeholder"
		m98_12_r4 = m98_L2.get
		m98_12_r6 = m98_12_L2[5]
		m98_12_r5 = m98_12_r6 or m98_12_L2.placeholder
		m98_12_r2[m98_12_r3] = m98_12_r4(m98_12_r5)
		m98_12_r2.Flag = m98_12_L2.flag
		m98_12_r2.Callback = function(m98_12_1_L1)
			local m98_12_1_r1, m98_12_1_r2, m98_12_1_r3, m98_12_1_r4
			if m98_12_1_L1 == nil then
				return
			else
				if m98_12_L6 then
					m98_12_1_r1 = m98_12_L6[1]
					m98_12_1_r2 = m98_12_L6[2]
					m98_12_1_r4 = m98_L5(m98_12_1_L1)
					m98_12_1_r3 = m98_12_1_r4 or m98_12_1_L1
					m98_12_1_r1[m98_12_1_r2] = m98_12_1_r3
				end
				if m98_12_L5 then
					m98_12_L5(m98_12_1_L1)
				end
			end
		end
		m98_12_L8 = (m98_12_L1.raw:AddTextBox(m98_12_r2))
		return m98_L12(m98_12_L8)
	end
	m98_L11.addSection = function(m98_13_L1, m98_13_L2)
		return m98_13_L1.raw:AddSection(m98_L2.get(m98_13_L2))
	end
	m98_L11.addDiscordInvite = function(m98_14_L1, m98_14_L2)
		local m98_14_r2, m98_14_r3, m98_14_r4, m98_14_r5

		m98_14_r2 = {}
		m98_14_r3 = "Title"
		m98_14_r5 = m98_14_L2.title
		m98_14_r4 = m98_14_r5 or m98_14_L2.name
		m98_14_r2[m98_14_r3] = m98_14_r4
		m98_14_r2.Description = m98_14_L2.description
		m98_14_r3 = "Banner"
		m98_14_r5 = m98_14_L2.banner
		m98_14_r4 = m98_14_r5 or m98_14_L2.logo
		m98_14_r2[m98_14_r3] = m98_14_r4
		m98_14_r2.Logo = m98_14_L2.logo
		m98_14_r2.Invite = m98_14_L2.invite
		m98_14_r2.Members = m98_14_L2.members
		m98_14_r2.Online = m98_14_L2.online
		return m98_14_L1.raw:AddDiscordInvite(m98_14_r2)
	end
	m98_L11.select = function(m98_15_L1)
		m98_15_L1.raw:Select()
	end
	m98_L4.makeWindow = function(m98_16_L1, m98_16_L2)
		return 
			m98_16_L1:MakeWindow({
				Title = m98_16_L2.title,
				SubTitle = m98_16_L2.subtitle,
				ScriptFolder = m98_16_L2.scriptFolder,
			})
		
	end
	m98_L4.makeTab = function(m98_17_L1, m98_17_L2)
		local m98_17_L3
		m98_17_L3 = (m98_L2.get(m98_17_L2.title))
		return 
			setmetatable({ raw = m98_17_L1:MakeTab({ Title = m98_17_L3, Icon = m98_17_L2.icon }) }, m98_L11)
		
	end
	m98_L4.addMinimizeButton = function(m98_18_L1, m98_18_L2)
		local m98_18_L3, m98_18_L4, m98_18_L5, m98_18_L6, m98_18_L7, m98_18_r2, m98_18_r3
		m98_18_L3 = (m98_18_L1:NewMinimizer({ KeyCode = Enum.KeyCode.LeftControl }))
		m98_18_r3 = m98_18_L2.button
		m98_18_r2 = m98_18_r3 or {}
		m98_18_L4 = (m98_18_L3:CreateMobileMinimizer(m98_18_r2))
		if m98_18_L2.corner then
			m98_18_L5 = (Instance.new("UICorner"))
			for m98_18_L6, m98_18_L7 in pairs(m98_18_L2.corner) do
				m98_18_L5[m98_18_L6] = m98_18_L7
			end
			m98_18_L5.Parent = m98_18_L4
		end
		return m98_18_L3
	end
	m98_L4.toggle = function(m98_19_L1, m98_19_L2, m98_19_L3, m98_19_L4)
		local m98_19_r1, m98_19_r2, m98_19_r3, m98_19_r4
		m98_19_r1 = m98_19_L2
		m98_19_r2 = "flag"
		m98_19_r4 = m98_19_L2.flag
		m98_19_r3 = m98_19_r4 or m98_19_L3
		m98_19_r1[m98_19_r2] = m98_19_r3
		m98_19_r1 = m98_19_L2
		m98_19_r2 = "callback"
		m98_19_r4 = m98_19_L4
		m98_19_r3 = m98_19_r4
		if not m98_19_r4 then
			m98_19_r3 = function(m98_19_1_L1)
				m98_L3[m98_19_L2.flag] = m98_19_1_L1
			end
		end
		m98_19_r1[m98_19_r2] = m98_19_r3
		m98_19_L1:addToggle(m98_19_L2)
	end
	m98_L4.section = function(m98_20_L1, m98_20_L2)
		m98_20_L1:addSection(m98_20_L2)
	end
	return m98_L4
end)


-- === farmTab: Farm tab ===
farmTab = lazy(function()
	local e = locale()
	local D = environment()
	local I = settings()
	local B = state()
	local E = gameSettings()
	local b = requirements()
	local t = quests()
	local h = D["environment"]
	return function(_, W, i)
		local uiScaleValues = { ["Large"] = 1, ["Medium"] = 0.75, ["Small"] = 0.6 }
		local h = { "Z", "X", "C", "V", "F" }
		local v = { "Z", "X" }
		local F = function(_)
			((B)["library"]):SetUIScale(uiScaleValues[_] or 1)
		end
		(_):addDropdown({ "Farm Tool", (E)["toolTypes"], (I)["toolFarm"], { I, "toolFarm" }, "toolFarm" });
		(_):addDropdown({ "UI Scale", { "Small", "Medium", "Large" }, "Large", F, "uiScale" })
		W(
			_,
			{
				"Infinite Damage",
				"Works with: Popcat, Baller, Paw Power, Snow Power, Sand Power, Water Power.",
			},
			"infiniteDamage"
		)
		i(_, "Farm")
		W(_, { "Auto Farm Level", (e)["format"]("MaxLevel: %i", (E)["maxLevel"]) }, "levelFarm")
		W(_, { "Auto Farm Nearest" }, "nearestFarm")
		i(_, "Enemies");
		(_):addDropdown({
			"Select Enemie",
			(t)["enemyList"],
			(t)["enemyList"][1],
			{ h, "selectedEnemy" },
			"selectedEnemy",
		})
		W(_, { "Auto Farm Selected" }, "farmSelectedEnemy")
		W(_, { "Take Quest [ Enemie Selected ]", true }, "takeSelectedQuest")
		i(_, "Sea Event")
		W(
			_,
			{ "Auto Meme Beast [ Spawns every 30 Minutes ]", "Drops: Portal ( <25% ), Meme Cube ( <50% )" },
			"memeBeast"
		)
		i(_, "Raid")
		W(_, { "Auto Farm Raid", (e)["format"]("Req: Level %i", (b)["level"]["raid"]) }, "raidFarm")
		i(_, "Skills");
		(_):addDropdown({ "Select Skills", h, v, { I, "skillsSelected" }, "skillsSelected", ["multiSelect"] = true })
		W(_, { "Auto Use Skills" }, "autoSkill")
	end
end)


-- === itemsTab: Items tab (bosses, race, unlocks) ===
itemsTab = lazy(function()
	local m118_L1, m118_L2, m118_L3, m118_L4, m118_L5, m118_L6, m118_L7, m118_L8, m118_L9
	m118_L1 = (locale())
	m118_L2 = (environment())
	m118_L3 = (gameData())
	m118_L4 = (entities())
	m118_L5 = (requirements())
	m118_L6 = (settings())
	m118_L7 = m118_L2.environment
	m118_L8 = m118_L2.runService
	m118_L9 = m118_L2.newCFrame
	do
		return function(m118_1_L1, m118_1_L2, m118_1_L3)
			local m118_1_L4, m118_1_L5, m118_1_L6
			if m118_L7.popcatConnection then
				m118_L7.popcatConnection:Disconnect()
			end
			m118_1_L4 = nil
			m118_1_L5 = 0
			m118_1_L6 = function(m118_1_1_L1)
				local m118_1_1_L2, m118_1_1_L3, m118_1_1_L4, m118_1_1_r1, m118_1_1_r2
				m118_1_L5 = (m118_1_L5 + 1)
				m118_1_1_L2 = m118_1_L5
				m118_L7.clickPopcat = m118_1_1_L1
				if m118_1_L4 then
					m118_1_L4:Disconnect()
					m118_1_L4 = nil
				end
				m118_L7.popcatConnection = nil
				if not m118_1_1_L1 then
					return
				else
					m118_1_1_L3 = m118_L3.island.FloppaIsland.Popcat_Clickable.Part.ClickDetector
					m118_1_1_r1 = m118_L4.goTo(m118_L9(400, -37, -588))
					if m118_1_1_r1 == false then
						m118_L7.clickPopcat = false
						return
					else
						m118_1_1_r2 = (m118_1_1_L2 ~= m118_1_L5)
						m118_1_1_r1 = m118_1_1_r2 or not m118_L7.clickPopcat
						if m118_1_1_r1 then
							return
						else
							m118_1_1_L4 = 0
							m118_1_L4 = (
								m118_L8.Heartbeat:Connect(function(m118_1_1_1_L1)
									local m118_1_1_1_L2, m118_1_1_1_L3, m118_1_1_1_L4, m118_1_1_1_r1, m118_1_1_1_r2, m118_1_1_1_r3, m118_1_1_1_r4
									m118_1_1_1_r2 = not m118_L7.clickPopcat
									m118_1_1_1_r1 = m118_1_1_1_r2 or not m118_1_1_L3.Parent
									if m118_1_1_1_r1 then
										m118_1_L4:Disconnect()
										m118_1_L4 = nil
										m118_L7.popcatConnection = nil
										return
									else
										m118_1_1_1_r1 = math.floor
										m118_1_1_1_r2 = math.clamp
										m118_1_1_1_r4 = tonumber(m118_L6.popcatClicksPerSecond)
										m118_1_1_1_r3 = m118_1_1_1_r4 or 10
										m118_1_1_1_r1 =
											{ m118_1_1_1_r1(m118_1_1_1_r2(m118_1_1_1_r3, 1, 100)) }
										m118_1_1_1_L2 = m118_1_1_1_r1[1]
										m118_1_1_L4 = (math.min((m118_1_1_L4 + m118_1_1_1_L1), 1))
										m118_1_1_1_L3 = (
											math.floor(((m118_1_1_L4 * m118_1_1_1_L2) + 1e-09))
										)
										m118_1_1_L4 = (
											math.max(0, (m118_1_1_L4 - (m118_1_1_1_L3 / m118_1_1_1_L2)))
										)
										for m118_1_1_1_L4 = 1, m118_1_1_1_L3, 1 do
											fireclickdetector(m118_1_1_L3)
										end
									end
								end)
							)
							m118_L7.popcatConnection = m118_1_L4
						end
					end
				end
			end
			m118_1_L3(m118_1_L1, "Bosses")
			m118_1_L2(
				m118_1_L1,
				{ "Auto Giant Pumpkin", "Drops: Pumpkin Head ( <10% ), Nugget Man ( <25% )" },
				"giantPumpkin"
			)
			m118_1_L2(
				m118_1_L1,
				{ "Auto Evil Noob", "Drops: Yellow Blade ( <5% ), Noob Friend ( <10% )" },
				"evilNoob"
			)
			m118_1_L2(
				m118_1_L1,
				{ "Auto Lord Sus", "Drops: Purple Katana ( <5% ), Sus Pals ( <10% )" },
				"lordSus"
			)
			m118_1_L3(m118_1_L1, "Race")
			m118_1_L2(
				m118_1_L1,
				{ "Auto Awakening Orb", m118_L1.format("Req: Level %i", m118_L5.level.raceV2Orb) },
				"raceV2Orb"
			)
			m118_1_L3(m118_1_L1, "Floppa")
			m118_1_L2(m118_1_L1, { "Auto Floppa [ Exclusive Weapon ]" }, "floppaSword")
			m118_1_L3(m118_1_L1, "Popcat")
			m118_1_L1:addSlider({
				"Clicks per Second",
				1,
				100,
				1,
				m118_L6.popcatClicksPerSecond,
				{ m118_L6, "popcatClicksPerSecond" },
				"popcatClicksPerSecond",
			})
			m118_1_L2(m118_1_L1, { "Auto Popcat" }, "clickPopcat", m118_1_L6)
			m118_1_L3(m118_1_L1, "Unlock")
			m118_1_L2(m118_1_L1, { "Auto Baller", "Farms 10 balls and buys Baller" }, "unlockBaller")
			m118_1_L2(
				m118_1_L1,
				{ "Auto Weapons", "Farms the materials and unlocks the Weapons section" },
				"unlockWeapons"
			)
			m118_1_L2(
				m118_1_L1,
				{ "Auto Quest Limit", "Uses the Quest Scroll (or buys it)" },
				"unlockQuestLimit"
			)
			m118_1_L2(
				m118_1_L1,
				{
					"Auto Gamepasses",
					m118_L1.format(
						"From level %i: farms gems and buys all gamepasses",
						m118_L5.level.gamepasses
					),
				},
				"unlockGamepasses"
			)
		end
	end
end)


-- === codes: code redemption and aura reroll ===
codes = lazy(function()
	local m122_L1, m122_L2, m122_L3, m122_L4, m122_L5, m122_L6
	m122_L1 = (gameData())
	m122_L2 = (remotes())
	m122_L3 = (inventory())
	m122_L4 = (playerData())
	m122_L5 = (weaponShop())
	m122_L6 = {}
	m122_L6.redeemCodes = function()
		do
			return pcall(function()
				local m122_1_1_L1, m122_1_1_L2, m122_1_1_r1, m122_1_1_r2, m122_1_1_r3
				for m122_1_1_L1, m122_1_1_L2 in pairs(require(m122_L1.gameModules.CodeList)) do
					m122_1_1_r3 = (type(m122_1_1_L1) == "string")
					m122_1_1_r2 = m122_1_1_r3
					if m122_1_1_r3 then
						m122_1_1_r3 = (type(m122_1_1_L2) == "table")
						m122_1_1_r2 = m122_1_1_r3 and m122_1_1_L2.Status
						m122_1_1_r2 = m122_1_1_r2
					end
					if m122_1_1_r2 then
						m122_L2.invoke("code", m122_1_1_L1)
					end
				end
			end)
		end
	end
	m122_L6.randomAura = function()
		if m122_L4.getData("Gem") >= m122_L5.actionPrices.rerollAura.Gem then
			if m122_L3:canRerollAura() then
				m122_L2.fire("modules", "Reroll_Color", "Halfed Sorcerer")
			else
				return true
			end
		end
	end
	m122_L6.joinTeam = {
		cheems = function()
			m122_L2.fire("modules", "Change_Team", "Cheems Recruiter")
		end,
		floppa = function()
			m122_L2.fire("modules", "Change_Team", "Floppa Recruiter")
		end,
	}
	return m122_L6
end)


-- === gacha: power gacha ===
gacha = lazy(function()
	local m124_L1, m124_L2, m124_L3, m124_L4
	m124_L1 = (environment())
	m124_L2 = (remotes())
	m124_L3 = {}
	m124_L4 = false
	m124_L3.normalizeAmount = function(m124_1_L1)
		local m124_1_L2, m124_1_r1, m124_1_r2
		m124_1_L2 = (tonumber(m124_1_L1))
		m124_1_r2 = not m124_1_L2
		m124_1_r1 = m124_1_r2 or (m124_1_L2 ~= m124_1_L2)
		if m124_1_r1 then
			return 1
		else
			m124_1_r1 = { math.floor(math.clamp(m124_1_L2, 1, 500)) }
			return unpack(m124_1_r1)
		end
	end
	m124_L3.roll = function(m124_2_L1, m124_2_L2, m124_2_L3)
		local m124_2_L4, m124_2_L5, m124_2_L6, m124_2_L7, m124_2_L8, m124_2_r1, m124_2_r2
		if m124_L4 then
			return false
		else
			m124_L4 = true
			m124_2_L4 = (m124_L3.normalizeAmount(m124_2_L1))
			m124_2_L5 = m124_2_L4
			m124_2_L6 = false
			m124_2_r2 = (m124_2_L2 == "Gem")
			m124_2_r1 = m124_2_r2 and "Doge Gacha"
			m124_2_r2 = m124_2_r1 or "Floppa Gacha"
			m124_2_L7 = m124_2_r2
			for m124_2_L8 = 1, m124_2_L4, 1 do
				m124_L1.spawn(function()
					local m124_2_1_L1, m124_2_1_L2, m124_2_1_r1, m124_2_1_r2, m124_2_1_r3, m124_2_1_r4, m124_2_1_r5, m124_2_1_r6, m124_2_1_r7, m124_2_1_r8
					m124_2_1_r2 = not m124_2_L3
					m124_2_1_r1 = m124_2_1_r2 or (m124_2_L3())
					if m124_2_1_r1 then
						m124_2_1_r1 = pcall
						m124_2_1_r2 = m124_L2.fire
						m124_2_1_r3 = "modules"
						m124_2_1_r4 = "Random_Power"
						m124_2_1_r5 = { Type = "Once", NPCName = m124_2_L7 }
						m124_2_1_r6 = "GachaType"
						m124_2_1_r8 = (m124_2_L2 == "Gem")
						m124_2_1_r7 = m124_2_1_r8 and "Gem"
						m124_2_1_r8 = m124_2_1_r7 or "Money"
						m124_2_1_r5[m124_2_1_r6] = m124_2_1_r8
						m124_2_1_r1 = { m124_2_1_r1(m124_2_1_r2, m124_2_1_r3, m124_2_1_r4, m124_2_1_r5) }
						m124_2_1_L1 = m124_2_1_r1[1]
						m124_2_1_L2 = m124_2_1_r1[2]
						if not m124_2_1_L1 then
							if not m124_2_L6 then
								warn(("Gacha: " .. tostring(m124_2_1_L2)))
							end
							m124_2_L6 = true
						else
						end
					end
					m124_2_L5 = (m124_2_L5 - 1)
				end)
			end
			while true do
				if not (m124_2_L5 > 0) then
					break
				end
				m124_L1.wait()
			end
			m124_L4 = false
			return not m124_2_L6
		end
	end
	return m124_L3
end)


-- === powersTab: Powers tab ===
powersTab = lazy(function()
	local F = environment()
	local l = gameData()
	local A = settings()
	local j = remotes()
	local e = inventory()
	local v = codes()
	local f = gacha()
	local K = F["environment"]
	local x = F["wait"]
	local O = F["spawn"]
	local R = F["localPlayer"]
	local k = l["itemFolder"]
	return function(n)
		local X = { "Money", "Gem" }
		local E = function(a)
			return (a):IsA("Tool") and (a["ToolTip"] == "Power" and (a):GetAttribute("Using") == nil)
		end
		local N = false
		local i = function(m127_L1)
			local m127_L2, m127_r1, m127_r2
			K.autoRerollPower = m127_L1
			m127_r2 = not m127_L1
			m127_r1 = m127_r2 or N
			if m127_r1 then
				return
			else
				N = true
				while true do
					if not (K).autoRerollPower then
						break
					end
					m127_L2 = (
						(f).roll((A).gachaAmount, (A).rerollPowerMethod, function()
							return (K).autoRerollPower
						end)
					)
					if not m127_L2 then
						F.wait(0.5)
					end
					x(0.1)
				end
				N = false
			end
		end
		local m = function()
			(f)["roll"]((A)["gachaAmount"], (A)["rerollPowerMethod"])
		end
		local T = function(m128_L1)
			local m128_L2, m128_L3, m128_r1
			K.autoStorePowers = m128_L1
			while true do
				if not (K).autoStorePowers then
					break
				end
				F(0.1)
				for m128_L2, m128_L3 in ipairs((R).Backpack:GetChildren()) do
					if (e)(m128_L3) then
						if (f):canStorePower(m128_L3.Name) then
							m128_L3.Parent = (R).Character
							E.fire("modules", "Eatable_Power", { Action = "Store", Tool = m128_L3 })
						else
							if (A).destroyMaxCap then
								m128_L3:Destroy()
							else
							end
						end
					end
				end
			end
		end
		local e = function()
			local m130_L1, m130_L2, m130_r1, m130_r2, m130_r3
			for m130_L1, m130_L2 in ipairs(workspace.Dropped_Items:GetChildren()) do
				m130_r3 = m130_L2:FindFirstChild("Handle")
				m130_r2 = m130_r3 and (m130_L2.Handle:FindFirstChild("TouchInterest"))
				if m130_r2 then
					firetouchinterest(m130_L2.Handle, (j).Character.PrimaryPart, 0)
				end
			end
		end
		local q = function()
			for l, O in ipairs(((R)["Backpack"]):GetChildren()) do
				if E(O) then
					O["Parent"] = (R)["Character"](j)
						["fire"]("modules", "Eatable_Power", { ["Action"] = "Drop", ["Tool"] = O })
				end
			end
		end
		local U = function(a)
			local O = tonumber(a)
			return O and math["clamp"](O, 1, 99) or 1
		end
		local M = function(n)
			(A)["unstorePower"] = n and n["Name"]
		end
		local c = function()
			for n = 1, (A)["unstoreAmount"] or 1, 1 do
				(O)(function()
					(j)["invoke"](
						"updateInventory",
						"Power",
						{ ["Action"] = "Unstore", ["SelectedItem"] = (A)["unstorePower"] }
					)
				end)
			end
		end
		local x = function(n)
			(K)["autoRerollAura"] = n
			while (K)["autoRerollAura"] do
				(x)()
				if (v)["randomAura"]() then
					break
				end
			end
		end
		local P = function(n)
			(R)["PlayerGui"]["GachaGui"]["GachaFrame"]["Visible"] = not n
		end
		(n):addSection("Drops");
		(n):addButton({ "Collect all drops", e });
		(n):addButton({ "Drop all powers", q });
		(n):addSection("Store");
		(n):addToggle({ "Auto Store Powers", false, T, "autoStore" });
		(n):addSection("Unstore");
		(n):addDropdown({ "Select Power", ((k)["Power"]):GetChildren(), "", M, "unstorePower" });
		((n):addTextBox({ "Unstore Amount", "1", false, { A, "unstoreAmount" }, "Number: 1-99" }))["OnChanging"] =
			U;
		(n):addButton({ "Unstore Power", c });
		(n):addSection("Power Gacha");
		(n):addDropdown({ "Gacha Type", X, "Money", { A, "rerollPowerMethod" }, "rerollPowerMethod" });
		((n):addTextBox({
			"Gacha Amount",
			tostring((A)["gachaAmount"]),
			false,
			function(n)
				(A)["gachaAmount"] = (f)["normalizeAmount"](n)
			end,
			"1-500",
			["flag"] = "gachaAmount",
		}))["OnChanging"] = (
			f
		)["normalizeAmount"];
		(n):addButton({ "Roll Powers", m });
		(n):addToggle({ "Auto Reroll Power", false, i, "autoRerollPower" });
		(n):addSection("Aura Color");
		(n):addToggle({ "Auto Reroll Aura", false, x, "autoRerollAura" });
		(n):addSection("Others");
		(n):addToggle({ "Remove Gacha Animation", false, P, "gachaAnimation" });
		(n):addToggle({ "Destroy stored Powers", false, { A, "destroyMaxCap" }, "destroyStored" })
	end
end)


-- === statsTab: Stats tab ===
statsTab = lazy(function()
	local m133_L1, m133_L2, m133_L3, m133_L4, m133_L5, m133_L6, m133_L7, m133_L8
	m133_L1 = (environment())
	m133_L2 = (settings())
	m133_L3 = (remotes())
	m133_L4 = (gameSettings())
	m133_L5 = (playerData())
	m133_L6 = m133_L1.environment
	m133_L7 = m133_L1.wait
	m133_L8 = m133_L5.getData
	do
		return function(m133_1_L1)
			local m133_1_L2, m133_1_L3, m133_1_L4, m133_1_L5, m133_1_L6, m133_1_L7
			m133_1_L2 = {}
			m133_1_L3 = { "Power", "Health", "Weapon", "Melee" }
			m133_1_L4 = {
				Power = "MemePowerLevel",
				Health = "DefenseLevel",
				Weapon = "SwordLevel",
				Melee = "MeleeLevel",
			}
			m133_1_L5 = function(m133_1_1_L1)
				local m133_1_1_L2, m133_1_1_L3, m133_1_1_L4, m133_1_1_L5, m133_1_1_L6, m133_1_1_L7, m133_1_1_r2, m133_1_1_r3, m133_1_1_r4, m133_1_1_r5
				m133_L6.autoStats = m133_1_1_L1
				while true do
					if not m133_L6.autoStats then
						break
					end
					m133_L7()
					m133_1_1_L2 = (m133_L8("SkillPoint"))
					if m133_1_1_L2 >= 1 then
						for m133_1_1_L3, m133_1_1_L4 in pairs(m133_1_L2) do
							m133_1_1_L5 = m133_1_L4[m133_1_1_L3]
							m133_1_1_L6 = (m133_L4.maxLevel - m133_L8(m133_1_1_L5))
							m133_1_1_r3 = m133_1_1_L4
							m133_1_1_r2 = m133_1_1_r3 and (m133_1_1_L6 > 0)
							if m133_1_1_r2 then
								m133_1_1_r2 = math.clamp
								m133_1_1_r3 = math.min
								m133_1_1_r5 = m133_L2.statsPoints
								m133_1_1_r4 = m133_1_1_r5 or 3
								m133_1_1_L7 = (
									m133_1_1_r2(m133_1_1_r3(m133_1_1_r4, m133_1_1_L2), 1, m133_1_1_L6)
								)
								m133_L3.invoke(
									"statsFunction",
									{ Target = m133_1_1_L5, Action = "UpgradeStats", Amount = m133_1_1_L7 }
								)
							end
						end
					end
				end
			end
			m133_1_L1:addSlider({
				"Points Amount",
				1,
				100,
				1,
				m133_L2.statsPoints,
				{ m133_L2, "statsPoints" },
				"statsPoints",
			})
			m133_1_L1:addToggle({ "Auto Stats", false, m133_1_L5, "autoStats" })
			m133_1_L1:addSection("Select Stats")
			for m133_1_L6, m133_1_L7 in ipairs(m133_1_L3) do
				m133_1_L1:addToggle({ m133_1_L7, false, { m133_1_L2, m133_1_L7 }, ("select" .. m133_1_L7) })
			end
		end
	end
end)


-- === teleportTab: Teleport tab ===
teleportTab = lazy(function()
	local m134_L1, m134_L2, m134_L3, m134_L4, m134_L5
	m134_L1 = (environment())
	m134_L2 = (gameData())
	m134_L3 = (gameSettings())
	m134_L4 = (entities())
	m134_L5 = m134_L1.insert
	do
		return function(m134_1_L1)
			local m134_1_L2, m134_1_L3, m134_1_L4, m134_1_L5, m134_1_r1
			m134_1_L2 = {}
			for m134_1_L3, m134_1_L4 in ipairs(m134_L2.location:WaitForChild("SpawnLocations"):GetChildren()) do
				if not table.find(m134_L3.ignoredSpawns, m134_1_L4.Name) then
					m134_L5(m134_1_L2, m134_1_L4)
				end
			end
			m134_1_L5 = function(m134_1_1_L1)
				local m134_1_1_L2, m134_1_1_r1, m134_1_1_r2
				if typeof(m134_1_1_L1) ~= "Instance" then
					return
				else
					m134_1_1_r2 = m134_1_1_L1:IsA("BasePart")
					m134_1_1_r1 = m134_1_1_r2 and m134_1_1_L1.CFrame
					m134_1_1_r2 = m134_1_1_r1 or (m134_1_1_L1:GetPivot())
					m134_1_1_L2 = m134_1_1_r2
					return m134_L4.goTo(m134_1_1_L2)
				end
			end
			m134_1_L1:addSection("Locations")
			m134_1_L1:addDropdown({ "Islands", m134_1_L2, {}, m134_1_L5 })
			m134_1_L1:addDropdown({ "Quests", m134_L2.questLocation:GetChildren(), {}, m134_1_L5 })
		end
	end
end)


-- === shopTab: Shop tab ===
shopTab = lazy(function()
	local I = environment()
	local v = remotes()
	local o = shopItems()
	local n = shop()
	local C = I["environment"]
	local Z = I["wait"]
	return function(M)
		local _ = function(M)
			(C)["autoBuyAbility"] = M
			while (C)["autoBuyAbility"] do
				(Z)();
				(n):buyAllAbilities()
			end
		end
		(M):addSection("Auto Buy");
		(M):addToggle({
			"Auto Buy Abilities",
			false,
			_,
			"autoBuyAbility",
			["description"] = "Aura, Instinct & Flash Step",
		})
		for _, a in ipairs((o)["sections"]) do
			(M):addSection(a["name"])
			for _, a in ipairs(a["items"]) do
				local l = a["remote"];
				(M):addButton({
					"Buy " .. a["name"],
					function()
						(v)["fire"]("modules", unpack(l))
					end,
					["description"] = a["description"],
				})
			end
		end
	end
end)


-- === pvpState: PvP state helpers ===
pvpState = lazy(function()
	local m138_L1, m138_L2, m138_L3
	m138_L1 = (environment())
	m138_L2 = (entities())
	m138_L3 = {}
	m138_L3.isInSafeZone = function(m138_1_L1)
		local m138_1_L2, m138_1_r1, m138_1_r2
		m138_1_r2 = m138_1_L1
		m138_1_r1 = m138_1_r2 and m138_1_L1.Character
		m138_1_L2 = m138_1_r1
		m138_1_r2 = (m138_1_L2 ~= nil)
		m138_1_r1 = m138_1_r2 and (m138_1_L2:GetAttribute("Safezone") == true)
		return m138_1_r1
	end
	m138_L3.isRaiding = function(m138_2_L1)
		local m138_2_r1, m138_2_r2
		m138_2_r2 = (m138_2_L1 ~= nil)
		m138_2_r1 = m138_2_r2 and (m138_2_L1:GetAttribute("Raiding") == true)
		return m138_2_r1
	end
	m138_L3.isPvpOn = function(m138_3_L1)
		local m138_3_L2, m138_3_L3, m138_3_r1, m138_3_r2
		m138_3_r2 = m138_3_L1
		m138_3_r1 = m138_3_r2 and m138_3_L1.Character
		m138_3_L2 = m138_3_r1
		m138_3_r2 = (not m138_L2.isAlive(m138_3_L2))
		m138_3_r1 = m138_3_r2
		if not m138_3_r2 then
			m138_3_r2 = m138_L3.isInSafeZone(m138_3_L1)
			m138_3_r1 = m138_3_r2 or (m138_L3.isRaiding(m138_3_L1))
			m138_3_r1 = m138_3_r1
		end
		if m138_3_r1 then
			return false
		else
			m138_3_L3 = (m138_3_L2:GetAttribute("PvpDisabled"))
			if m138_3_L3 == true then
				return false
			else
				m138_3_r2 = (type(m138_3_L3) == "number")
				m138_3_r1 = m138_3_r2 and ((tick() - m138_3_L3) < 600)
				if m138_3_r1 then
					return false
				else
					return true
				end
			end
		end
	end
	m138_L3.getTeamColor = function(m138_4_L1)
		local m138_4_r1, m138_4_r2
		m138_4_r2 = m138_4_L1
		m138_4_r1 = m138_4_r2
		if m138_4_r2 then
			m138_4_r2 = m138_4_L1.Team
			m138_4_r1 = m138_4_r2 and not m138_4_L1.Neutral
			m138_4_r1 = m138_4_r1
		end
		if m138_4_r1 then
			return m138_4_L1.TeamColor.Color
		else
			return Color3.fromRGB(220, 220, 220)
		end
	end
	m138_L3.isOpponent = function(m138_5_L1)
		local m138_5_L2, m138_5_r1, m138_5_r2
		m138_5_L2 = m138_L1.localPlayer
		m138_5_r2 = not m138_5_L1
		m138_5_r1 = m138_5_r2 or (m138_5_L1 == m138_5_L2)
		if m138_5_r1 then
			return false
		else
			m138_5_r2 = m138_5_L1.Neutral
			m138_5_r1 = m138_5_r2
			if not m138_5_r2 then
				m138_5_r2 = m138_5_L2.Neutral
				m138_5_r1 = m138_5_r2
				if not m138_5_r2 then
					m138_5_r2 = not m138_5_L1.Team
					m138_5_r1 = m138_5_r2 or not m138_5_L2.Team
					m138_5_r1 = m138_5_r1
				end
				m138_5_r1 = m138_5_r1
			end
			if m138_5_r1 then
				return true
			else
				m138_5_r2 = (m138_5_L1.Team.Name == "Floppa")
				m138_5_r1 = m138_5_r2 or (m138_5_L1.Team ~= m138_5_L2.Team)
				return m138_5_r1
			end
		end
	end
	m138_L3.canAttack = function(m138_6_L1)
		local m138_6_r1, m138_6_r2
		m138_6_r2 = m138_L3.isOpponent(m138_6_L1)
		m138_6_r1 = m138_6_r2 and (m138_L3.isPvpOn(m138_6_L1))
		return m138_6_r1
	end
	return m138_L3
end)


-- === bounty: bounty / random player teleport ===
bounty = lazy(function()
	local m139_L1, m139_L2, m139_L3, m139_L4, m139_L5, m139_L6, m139_L7, m139_L8, m139_L9, m139_L10, m139_L11, m139_L12, m139_L13, m139_L14, m139_L15
	m139_L1 = (environment())
	m139_L2 = (gameData())
	m139_L3 = (settings())
	m139_L4 = (playerApi())
	m139_L5 = (pvpState())
	m139_L6 = m139_L1.players
	m139_L7 = m139_L1.localPlayer
	m139_L8 = m139_L1.environment
	m139_L9 = m139_L1.wait
	m139_L10 = m139_L1.huge
	m139_L11 = m139_L1.newCFrame
	m139_L12 = m139_L1.newVector3
	m139_L13 = m139_L2.characters
	m139_L14 = function()
		local m139_1_L1, m139_1_L2, m139_1_L3, m139_1_L4, m139_1_L5, m139_1_L6, m139_1_L7, m139_1_L8, m139_1_r1, m139_1_r2, m139_1_r3
		m139_1_L1 = m139_L10
		m139_1_L2 = nil
		for m139_1_L3, m139_1_L4 in ipairs(m139_L6:GetPlayers()) do
			m139_1_L5 = m139_1_L4.Character
			m139_1_r3 = m139_L5.canAttack(m139_1_L4)
			m139_1_r2 = m139_1_r3 and (m139_1_L5.Parent == m139_L13)
			if m139_1_r2 then
				m139_1_L6 = (m139_1_L4:FindFirstChild("PlayerData"))
				m139_1_r3 = m139_1_L6
				m139_1_r2 = m139_1_r3 and (m139_1_L6:FindFirstChild("Level"))
				m139_1_L7 = m139_1_r2
				m139_1_r3 = m139_1_L7
				m139_1_r2 = m139_1_r3 and m139_1_L7.Value
				m139_1_L8 = m139_1_r2
				m139_1_r3 = m139_1_L8
				m139_1_r2 = m139_1_r3 and (m139_1_L8 < m139_1_L1)
				if m139_1_r2 then
					m139_1_L1 = m139_1_L8
					m139_1_L2 = m139_1_L5
				else
				end
			end
		end
		return m139_1_L2
	end
	m139_L15 = function(m139_2_L1)
		local m139_2_L2, m139_2_r1, m139_2_r2
		m139_2_r2 = m139_2_L1
		m139_2_r1 = m139_2_r2 and (m139_L6:GetPlayerFromCharacter(m139_2_L1))
		m139_2_L2 = m139_2_r1
		m139_2_r2 = m139_L5.canAttack(m139_2_L2)
		m139_2_r1 = m139_2_r2 and (m139_2_L1.Parent == m139_L13)
		return m139_2_r1
	end
	do
		return function()
			local m139_3_L1
			m139_3_L1 = {}
			m139_3_L1.goToRandom = function(m139_3_1_L1)
				local m139_3_1_L2, m139_3_1_L3, m139_3_1_r1, m139_3_1_r2
				m139_L8.randomBounty = m139_3_1_L1
				m139_3_1_L2 = (m139_L14())
				while true do
					if not m139_L8.randomBounty then
						break
					end
					m139_L9()
					if m139_L15(m139_3_1_L2) then
						m139_3_1_L3 = m139_3_1_L2.PrimaryPart
						m139_3_1_r2 = m139_3_1_L3
						m139_3_1_r1 = m139_3_1_r2
							and (m139_L7:DistanceFromCharacter(m139_3_1_L3.Position) >= 350)
						if m139_3_1_r1 then
							characterSystem.goTo((m139_3_1_L3.CFrame * m139_L11(0, 0, 30)))
						else
						end
					else
						m139_3_1_L2 = (m139_L14())
					end
				end
			end
			m139_3_L1.autoBounty = function(m139_3_2_L1)
				local m139_3_2_L2, m139_3_2_L3
				m139_L8.autoBounty = m139_3_2_L1
				m139_3_2_L2 = (m139_L14())
				while true do
					if not m139_L8.autoBounty then
						break
					end
					m139_L9()
					if m139_L15(m139_3_2_L2) then
						m139_3_2_L3 = m139_3_2_L2.PrimaryPart
						if m139_3_2_L3 then
							if m139_3_2_L2:FindFirstChild("Reverse_Mark") then
								characterSystem.goTo((m139_3_2_L3.CFrame + m139_L12(0, 400, 0)))
							else
								characterSystem.goTo((m139_3_2_L3.CFrame * m139_L3.farmCFrame))
								m139_L4.playerClick()
								m139_L4.useSkills()
								m139_L4.equipWeapon()
							end
						else
						end
					else
						m139_3_2_L2 = (m139_L14())
					end
				end
			end
			return m139_3_L1
		end
	end
end)


-- === esp: ESP ===
esp = lazy(function()
	local m141_L1, m141_L2, m141_L3, m141_L4, m141_L5, m141_L6, m141_L7, m141_L8, m141_L9, m141_L10, m141_L11, m141_L12, m141_L13
	m141_L1 = (environment())
	m141_L2 = (gameData())
	m141_L3 = (gameSettings())
	m141_L4 = (pvpState())
	m141_L5 = (locale())
	m141_L6 = m141_L1.players
	m141_L7 = m141_L1.localPlayer
	m141_L8 = m141_L1.coreGui
	m141_L9 = m141_L1.runService
	m141_L10 = m141_L1.environment
	m141_L11 = m141_L1.wait
	m141_L12 = m141_L1.newVector3
	m141_L13 = function(m141_1_L1)
		return tostring(m141_1_L1)
			:gsub("&", "&amp;")
			:gsub("<", "&lt;")
			:gsub(">", "&gt;")
			:gsub('"', "&quot;")
	end
	do
		return function()
			local m141_2_L1, m141_2_L2, m141_2_L3, m141_2_L4, m141_2_L5, m141_2_L6, m141_2_L7, m141_2_L8, m141_2_L9, m141_2_L10, m141_2_r1, m141_2_r2, m141_2_r3
			m141_2_r1 = pairs
			m141_2_r3 = m141_L10.espConnections
			m141_2_r2 = m141_2_r3 or {}
			for m141_2_L1, m141_2_L2 in m141_2_r1(m141_2_r2) do
				m141_2_L2:Disconnect()
			end
			m141_2_L3 = {}
			m141_L10.espConnections = m141_2_L3
			m141_2_L4 = (Instance.new("Folder"))
			m141_2_L4.Name = "rz_Esp"
			m141_2_L5 = (m141_L8:FindFirstChild(m141_2_L4.Name))
			if m141_2_L5 then
				m141_2_L5:Destroy()
			end
			m141_2_L6 = function(m141_2_1_L1)
				local m141_2_1_L2
				m141_2_1_L2 = (Instance.new("Folder"))
				m141_2_1_L2.Name = m141_2_1_L1
				m141_2_1_L2.Parent = m141_2_L4
				return m141_2_1_L2
			end
			m141_2_L7 = { players = m141_2_L6("Players"), islands = m141_2_L6("Islands") }
			m141_2_L4.Parent = m141_L8
			m141_2_L8 = {}
			m141_2_L9 = function(m141_2_2_L1, m141_2_2_L2, m141_2_2_L3, m141_2_2_L4)
				local m141_2_2_L5, m141_2_2_L6, m141_2_2_L7, m141_2_2_L8, m141_2_2_L9, m141_2_2_L10, m141_2_2_r1, m141_2_2_r2, m141_2_2_r3, m141_2_2_r4
				m141_2_2_r2 = not m141_2_2_L2.Parent
				m141_2_2_r1 = m141_2_2_r2 or m141_2_L8[m141_2_2_L2]
				if m141_2_2_r1 then
					return
				else
					m141_2_2_r2 = m141_2_2_L2:IsA("Model")
					m141_2_2_r1 = m141_2_2_r2 and m141_2_2_L2.PrimaryPart
					m141_2_2_r2 = m141_2_2_r1 or m141_2_2_L2
					m141_2_2_L5 = m141_2_2_r2
					if not m141_2_2_L5 then
						return
					else
						m141_2_L8[m141_2_2_L2] = true
						m141_2_2_L6 = (Instance.new("BoxHandleAdornment"))
						m141_2_2_L6.Adornee = m141_2_2_L5
						m141_2_2_L6.Size = (m141_L12(1, 0, 1))
						m141_2_2_L6.Name = m141_2_2_L2.Name
						m141_2_2_L6.AlwaysOnTop = true
						m141_2_2_L6.ZIndex = 10
						m141_2_2_L6.Transparency = 0
						m141_2_2_L7 = (Instance.new("BillboardGui"))
						m141_2_2_L7.Adornee = m141_2_2_L5
						m141_2_2_L7.Size = (UDim2.new(0, 100, 0, 150))
						m141_2_2_L7.StudsOffset = (m141_L12(0, 1, 0))
						m141_2_2_L7.AlwaysOnTop = true
						m141_2_2_L8 = (Instance.new("TextLabel"))
						m141_2_2_L8.BackgroundTransparency = 1
						m141_2_2_L8.Position = (UDim2.new(0, 0, 0, -50))
						m141_2_2_L8.Size = (UDim2.new(0, 100, 0, 100))
						m141_2_2_L8.TextSize = 10
						m141_2_2_r1 = m141_2_2_L8
						m141_2_2_r2 = "TextColor3"
						m141_2_2_r4 = m141_2_2_L3
						m141_2_2_r3 = m141_2_2_r4 or (Color3.new(1, 1, 1))
						m141_2_2_r1[m141_2_2_r2] = m141_2_2_r3
						m141_2_2_L8.TextStrokeTransparency = 0
						m141_2_2_L8.TextYAlignment = Enum.TextYAlignment.Bottom
						m141_2_2_L8.Text = "..."
						m141_2_2_L8.ZIndex = 15
						m141_2_2_L8.RichText = true
						m141_2_2_L8.Parent = m141_2_2_L7
						m141_2_2_L7.Parent = m141_2_2_L6
						m141_2_2_L6.Parent = m141_2_2_L1
						m141_2_2_L9 = ("esp" .. m141_2_2_L1.Name)
						m141_2_2_L10 = nil
						m141_2_2_L10 = (
							m141_L9.Stepped:Connect(function()
								local m141_2_2_1_L1, m141_2_2_1_L2, m141_2_2_1_L3, m141_2_2_1_L4, m141_2_2_1_L5, m141_2_2_1_L6, m141_2_2_1_L7, m141_2_2_1_L8, m141_2_2_1_r1, m141_2_2_1_r2, m141_2_2_1_r3
								m141_2_2_1_r2 = not m141_L10[m141_2_2_L9]
								m141_2_2_1_r1 = m141_2_2_1_r2
								if not m141_2_2_1_r2 then
									m141_2_2_1_r2 = not m141_2_2_L2.Parent
									m141_2_2_1_r1 = m141_2_2_1_r2
									if not m141_2_2_1_r2 then
										m141_2_2_1_r2 = not m141_2_2_L5.Parent
										m141_2_2_1_r1 = m141_2_2_1_r2 or not m141_2_2_L6.Parent
										m141_2_2_1_r1 = m141_2_2_1_r1
									end
									m141_2_2_1_r1 = m141_2_2_1_r1
								end
								if m141_2_2_1_r1 then
									m141_2_L8[m141_2_2_L2] = nil
									m141_2_L3[m141_2_2_L2] = nil
									m141_2_2_L10:Disconnect()
									m141_2_2_L6:Destroy()
									return
								else
									m141_2_2_1_r1 =
										{ math.floor(m141_L7:DistanceFromCharacter(m141_2_2_L5.Position)) }
									m141_2_2_1_L1 = m141_2_2_1_r1[1]
									m141_2_2_1_L2 = (m141_2_2_L2:FindFirstChild("Humanoid"))
									if m141_2_2_1_L2 then
										m141_2_2_1_L3 = (
											("[ %i/%i ] "):format(
												math.floor(m141_2_2_1_L2.Health),
												math.floor(m141_2_2_1_L2.MaxHealth)
											)
										)
										m141_2_2_1_L4 = (m141_L13(m141_2_2_L2.Name))
										m141_2_2_1_L5 = ""
										if m141_2_2_L4 then
											m141_2_2_1_L6 = (m141_L4.getTeamColor(m141_2_2_L4))
											m141_2_2_1_L4 = (
												("<font color='#%s'>%s</font>"):format(
													m141_2_2_1_L6:ToHex(),
													m141_2_2_1_L4
												)
											)
											m141_2_2_1_L7 = (m141_L4.isPvpOn(m141_2_2_L4))
											m141_2_2_1_r1 = m141_L5.get
											m141_2_2_1_r3 = m141_2_2_1_L7
											m141_2_2_1_r2 = m141_2_2_1_r3 and "PvP On"
											m141_2_2_1_r3 = m141_2_2_1_r2 or "PvP Off"
											m141_2_2_1_L8 = (m141_2_2_1_r1(m141_2_2_1_r3))
											if m141_L4.isInSafeZone(m141_2_2_L4) then
												m141_2_2_1_L8 = (
													m141_2_2_1_L8 .. (" · " .. m141_L5.get("Safe Zone"))
												)
											end
											m141_2_2_1_r1 = ("\n<font color='%s'>%s</font>")["format"]
											m141_2_2_1_r2 = m141_2_2_1_L7
											m141_2_2_1_r3 = m141_2_2_1_r2 and "#19F019"
											m141_2_2_1_r2 = m141_2_2_1_r3 or "#F0A019"
											m141_2_2_1_L5 = (
												m141_2_2_1_r1(m141_2_2_1_r2, m141_L13(m141_2_2_1_L8))
											)
										end
										m141_2_2_L8.Text = (
											m141_2_2_1_L4
											.. (
												"<font color='rgb(160, 160, 160)'> [ "
												.. (
													m141_2_2_1_L1
													.. (
														"m ]</font>\n"
														.. (
															"<font color='rgb(25, 240, 25)'>"
															.. (
																m141_2_2_1_L3 .. (
																	"</font>" .. m141_2_2_1_L5
																)
															)
														)
													)
												)
											)
										)
									else
										m141_2_2_L8.Text = (
											("%s [ %i ]"):format(m141_2_2_L2.Name, m141_2_2_1_L1)
										)
									end
								end
							end)
						)
						m141_2_L3[m141_2_2_L2] = m141_2_2_L10
					end
				end
			end
			m141_2_L10 = {}
			m141_2_L10.players = function(m141_2_3_L1)
				local m141_2_3_L2, m141_2_3_L3, m141_2_3_r1, m141_2_3_r2, m141_2_3_r3
				m141_L10.espPlayers = m141_2_3_L1
				while true do
					if not m141_L10.espPlayers then
						break
					end
					for m141_2_3_L2, m141_2_3_L3 in ipairs(m141_L6:GetPlayers()) do
						m141_2_3_r3 = (m141_2_3_L3 ~= m141_L7)
						m141_2_3_r2 = m141_2_3_r3 and m141_2_3_L3.Character
						if m141_2_3_r2 then
							m141_2_L9(
								m141_2_L7.players,
								m141_2_3_L3.Character,
								Color3.fromRGB(220, 220, 220),
								m141_2_3_L3
							)
						end
					end
					m141_L11(0.5)
				end
			end
			m141_2_L10.islands = function(m141_2_4_L1)
				local m141_2_4_L2, m141_2_4_L3, m141_2_4_r1
				m141_L10.espIslands = m141_2_4_L1
				if not m141_2_4_L1 then
					return
				else
					for m141_2_4_L2, m141_2_4_L3 in ipairs(m141_L2.location:WaitForChild("SpawnLocations"):GetChildren()) do
						if not table.find(m141_L3.ignoredSpawns, m141_2_4_L3.Name) then
							m141_2_L9(m141_2_L7.islands, m141_2_4_L3, Color3.fromRGB(0, 255, 255))
						end
					end
				end
			end
			return m141_2_L10
		end
	end
end)


-- === pvpTab: PvP tab ===
pvpTab = lazy(function()
	local m143_L1, m143_L2, m143_L3
	m143_L1 = (environment()).environment
	m143_L2 = (bounty())
	m143_L3 = (esp())
	do
		return function(m143_1_L1)
			local m143_1_L2, m143_1_L3
			m143_1_L2 = (m143_L2())
			m143_1_L3 = (m143_L3())
			m143_1_L1:addSection("Bounty/Fame")
			m143_1_L1:addToggle({ "Teleport to random player", false, m143_1_L2.goToRandom })
			m143_1_L1:addSection("AimBot")
			m143_1_L1:addToggle({ "AimBot Players", false, { m143_L1, "aimBotPlayers" }, "aimBotPlayers" })
			m143_1_L1:addToggle({ "AimBot Monsters", false, { m143_L1, "aimBotEnemy" }, "aimBotEnemy" })
			m143_1_L1:addSection("Esp")
			m143_1_L1:addToggle({ "Esp Players", false, m143_1_L3.players })
			m143_1_L1:addToggle({ "Esp Islands", false, m143_1_L3.islands })
		end
	end
end)


-- === oneClickTab: One-Click tab ===
oneClickTab = lazy(function()
	local l = environment()
	local m = shop()
	local b = inventory()
	local f = codes()
	local j = playerData()
	local X = requirements()
	local H = l["environment"]
	local M = l["wait"]
	local J = l["spawn"]
	local k = j["getPlayerLevel"]
	return function(x)
		local R = { "Farm Lord Sus", "Farm Evil Noob", "Farm Raid" }
		local G = {
			{ "Buy all gamepass", "farm gems and buy all gamepass", "getGamepasses", true },
			{ "Awaken Race V2", "get race V2 if you don't have", "awakenV2", true },
			{ "Upgrade quest limit", "buy quest scroll and use", "questLimit", true },
			{ "Get all aura Colors", "get all aura colors after purchasing the aura", "allAuraColors", true },
		}
		local O = function(m146_L1)
			local m146_L2, m146_L3, m146_r1, m146_r2, m146_r3, m146_r4
			H.oneClick = m146_L1
			m146_r1 = H
			m146_r2 = "oneClickRunId"
			m146_r4 = (H).oneClickRunId
			m146_r3 = m146_r4 or 0
			m146_r1[m146_r2] = (m146_r3 + 1)
			m146_L2 = (H).oneClickRunId
			if not m146_L1 then
				return
			else
				m146_L3 = function()
					local m146_1_r1, m146_1_r2
					m146_1_r2 = (H).oneClick
					m146_1_r1 = m146_1_r2 and ((H).oneClickRunId == m146_L2)
					return m146_1_r1
				end
				J(function()
					local m146_2_L1, m146_2_L2, m146_2_L3, m146_2_L4, m146_2_r1, m146_2_r2
					m146_2_L1 = false
					m146_2_L2 = nil
					while true do
						if not (m146_L3()) then
							break
						end
						M(0.2)
						if not m146_L3() then
							break
						end
						m146_2_r1 = {
							pcall(function()
								local m146_2_1_L1, m146_2_1_r1, m146_2_1_r2
								m146_2_1_L1 = (H).oneClickSettings
								b:equipAccessory()
								b:equipSword()
								m:buyMissingWeapon()
								if not m146_L3() then
									return
								else
									if not (H).autoBuyAbility then
										m:buyAllAbilities()
									end
									if not m146_L3() then
										return
									else
										m146_2_1_r2 = not m146_2_L1
										m146_2_1_r1 = m146_2_1_r2 and ((k)() >= (X).level.codes)
										if m146_2_1_r1 then
											m146_2_L1 = ((f).redeemCodes() == true)
										end
										if not m146_L3() then
											return
										else
											m:buyBaller()
											if not m146_L3() then
												return
											else
												m146_2_1_r2 = m146_2_1_L1.allAuraColors
												m146_2_1_r1 = m146_2_1_r2 and ((b):verifyAbility("Aura"))
												if m146_2_1_r1 then
													f.randomAura()
												end
											end
										end
									end
								end
							end),
						}
						m146_2_L3 = m146_2_r1[1]
						m146_2_L4 = m146_2_r1[2]
						m146_2_r2 = not m146_2_L3
						m146_2_r1 = m146_2_r2 and (m146_2_L4 ~= m146_2_L2)
						if m146_2_r1 then
							warn(("[One Click] " .. tostring(m146_2_L4)))
						end
						m146_2_r2 = not m146_2_L3
						m146_2_r1 = m146_2_r2 and m146_2_L4
						m146_2_r2 = m146_2_r1 or nil
						m146_2_L2 = m146_2_r2
					end
				end)
			end
		end
		(x):addToggle({ "Start One Click [ BETA ]", false, O, "oneClick" });
		(x):addSection("Settings")
		for R, G in ipairs(G) do
			(x):addToggle({ G[1], G[4], { (H)["oneClickSettings"], G[3] }, G[3], ["description"] = G[2] })
		end
		(x):addDropdown({ "End-Game", R, "Farm Lord Sus", { (H)["oneClickSettings"], "endGame" }, "endGame" })
	end
end)


-- === owner: owner check ===
owner = lazy(function()
	local Q = environment()
	return { ["isOwner"] = Q["localPlayer"]["UserId"] == 2764978820 }
end)


-- === miscTab: Misc tab ===
miscTab = lazy(function()
	local k = environment()
	local Z = gameData()
	local s = settings()
	local U = owner()
	local T = codes()
	local d = inventory()
	local O = entities()
	local F = k["environment"]
	local _ = k["localPlayer"]
	local w = k["wait"]
	local V = k["teleportService"]
	local q = k["huge"]
	local r = k["newCFrame"]
	local g = k["newCFrameAngles"]
	return function(i)
		local S = 15
		local M = function(i)
			(_)["PlayerGui"]["AnnounceGui"]["Enabled"] = not i
		end
		local D = function(i)
			(s)["farmDistance"] = i or 8
			(s)["farmCFrame"] = (r)(0, (s)["farmDistance"], 0) * (g)(math["rad"](-90), 0, 0)
		end
		local h = function(i)
			local M = getsenv((_)["Character"]["Abilities"]["Movement"])
			local D = i and q or S
			setupvalue(M["JumpActive"], 5, D)
			setupvalue(M["JumpActive"], 6, D);
			((require((Z)["gameModules"]["Setting"])))["Setting"]["MaxJump"] = D
		end
		local H = function(i)
			(F)["autoEquip"] = i
			while (F)["autoEquip"] do
				(d):equipAccessory();
				(d):equipSword()(w)(1)
			end
		end
		local I = function(x)
			return ((x):gsub("`", ""))
		end
		local _ = function(i)
			if (O)["standUp"]() then
				(V):TeleportToPlaceInstance(game["PlaceId"], i, _)
			end
		end
		local W = function()
			local i = getclipboard or fromclipboard
			if i then
				_(I(i()))
			end
		end
		(i):addButton({ "Redeem All Codes", (T)["redeemCodes"] })
		if (U)["isOwner"] then
			(i):addSection("Job id");
			((i):addTextBox({ "Input Job Id", "null", false, _, "Job ID" }))["OnChanging"] = I;
			(i):addButton({ "Join From Clipboard", W })
		end
		(i):addSection("Settings");
		(i):addDropdown({
			"Language",
			{ "auto", "en", "pt", "es", "fr" },
			(s)["language"],
			{ s, "language" },
			"language",
			["description"] = "Language changes apply on next run.",
		});
		(i):addSlider({ "Farm Distance", 5, 15, 1, 8, D, "farmDistance" });
		(i):addToggle({ "Auto Aura", (s)["autoHaki"], { s, "autoHaki" }, "autoHaki" });
		(i):addToggle({ "Auto Attack", (s)["autoClick"], { s, "autoClick" }, "autoClick" });
		(i):addToggle({ "Bring Mobs", (s)["bringMobs"], { s, "bringMobs" }, "bringMobs" });
		(i):addToggle({ "Anti AFK", (s)["antiAfk"], { s, "antiAfk" }, "antiAfk" });
		(i):addToggle({ "Auto Equip", false, H, "autoEquip", ["description"] = "Sword & accessory" });
		(i):addSection("Team");
		(i):addButton({ "Join Cheems Team", (T)["joinTeam"]["cheems"] });
		(i):addButton({ "Join Floppa Team", (T)["joinTeam"]["floppa"] });
		(i):addSection("Others");
		(i):addToggle({ "Remove Notifications", false, M, "removeNotifications" });
		(i):addToggle({ "No Stun", true, { F, "noStun" }, "noStun" });
		(i):addToggle({ "Inf sky jump", true, h, "infJump" })
	end
end)


-- === buildMenu: builds the whole menu ===
buildMenu = lazy(function()
	local m152_L1, m152_L2, m152_L3, m152_L4
	m152_L1 = (state())
	m152_L2 = (uiConfig())
	m152_L3 = (locale())
	m152_L4 = (ui())
	do
		return function()
			local m152_1_L1, m152_1_L2, m152_1_L3, m152_1_L4, m152_1_L5
			m152_1_L1 = m152_L1.library
			m152_L3.load()
			m152_1_L2 = (m152_L4.makeWindow(m152_1_L1, m152_L2.window))
			m152_1_L3 = {
				discord = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.discord),
				mainFarm = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.mainFarm),
				items = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.items),
				powers = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.powers),
				stats = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.stats),
				teleport = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.teleport),
				shop = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.shop),
				pvp = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.pvp),
				oneClick = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.oneClick),
				misc = m152_L4.makeTab(m152_1_L2, m152_L2.tabs.misc),
			}
			m152_1_L3.mainFarm:select()
			m152_L4.addMinimizeButton(
				m152_1_L2,
				{
					button = { Image = m152_L2.minimizeLogo, BackgroundTransparency = 0 },
					corner = { CornerRadius = UDim.new(0, 6) },
				}
			)
			m152_1_L3.discord:addDiscordInvite({
				name = m152_L2.discord.title,
				description = m152_L2.discord.description,
				logo = m152_L2.discord.logo,
				invite = m152_L2.discord.invite,
			})
			m152_1_L4 = m152_L4.toggle
			m152_1_L5 = m152_L4.section
			farmTab()(m152_1_L3.mainFarm, m152_1_L4, m152_1_L5)
			itemsTab()(m152_1_L3.items, m152_1_L4, m152_1_L5)
			powersTab()(m152_1_L3.powers)
			statsTab()(m152_1_L3.stats)
			teleportTab()(m152_1_L3.teleport)
			shopTab()(m152_1_L3.shop)
			pvpTab()(m152_1_L3.pvp)
			oneClickTab()(m152_1_L3.oneClick)
			miscTab()(m152_1_L3.misc)
		end
	end
end)


-- === farmLoop: main farm loop ===
farmLoop = lazy(function()
	local m155_L1, m155_L2, m155_L3, m155_L4, m155_L5, m155_L6, m155_L7, m155_L8, m155_L9, m155_L10, m155_L11, m155_L12
	m155_L1 = (environment())
	m155_L2 = m155_L1.environment
	m155_L3 = m155_L1.spawn
	m155_L4 = m155_L1.wait
	m155_L5 = m155_L1.localPlayer
	m155_L6 = nil
	m155_L7 = nil
	m155_L8 = function()
		if m155_L7 then
			m155_L7:Destroy()
			m155_L7 = nil
		end
	end
	m155_L9 = function(m155_2_L1)
		local m155_2_L2, m155_2_L3, m155_2_L4, m155_2_r1, m155_2_r2
		m155_2_r2 = m155_2_L1
		m155_2_r1 = m155_2_r2
		if m155_2_r2 then
			m155_2_r2 = m155_L2[m155_2_L1]
			m155_2_r1 = m155_2_r2 and m155_2_L1
			m155_2_r1 = m155_2_r1
		end
		m155_2_r2 = m155_2_r1 or nil
		m155_L6 = m155_2_r2
		m155_2_L2 = m155_L5.Character
		m155_2_r2 = m155_2_L2
		m155_2_r1 = m155_2_r2 and (m155_2_L2:FindFirstChild("Humanoid"))
		m155_2_L3 = m155_2_r1
		m155_2_r2 = m155_2_L2
		m155_2_r1 = m155_2_r2 and (m155_2_L2:FindFirstChild("HumanoidRootPart"))
		m155_2_L4 = m155_2_r1
		m155_2_r2 = not m155_L6
		m155_2_r1 = m155_2_r2
		if not m155_2_r2 then
			m155_2_r2 = not m155_2_L2.Parent
			m155_2_r1 = m155_2_r2
			if not m155_2_r2 then
				m155_2_r2 = not m155_2_L3
				m155_2_r1 = m155_2_r2
				if not m155_2_r2 then
					m155_2_r2 = (m155_2_L3.Health <= 0)
					m155_2_r1 = m155_2_r2 or not m155_2_L4
					m155_2_r1 = m155_2_r1
				end
				m155_2_r1 = m155_2_r1
			end
			m155_2_r1 = m155_2_r1
		end
		if m155_2_r1 then
			m155_L8()
			return
		else
			m155_2_r2 = m155_L7
			m155_2_r1 = m155_2_r2 and (m155_L7.Parent ~= m155_2_L4)
			if m155_2_r1 then
				m155_L8()
			end
			if not m155_L7 then
				m155_L7 = (Instance.new("BodyVelocity"))
				m155_L7.Name = "MemeSea_FarmVelocity"
				m155_L7.MaxForce = (Vector3.new(math.huge, math.huge, math.huge))
				m155_L7.Velocity = Vector3.zero
				m155_L7.Parent = m155_2_L4
			end
		end
	end
	m155_L10 = {}
	m155_L11 = function(m155_3_L1, m155_3_L2)
		local m155_3_r1
		if m155_L10[m155_3_L1] == m155_3_L2 then
			return
		else
			m155_L10[m155_3_L1] = m155_3_L2
			m155_3_r1 = warn(("[prioridade %s] %s"):format(m155_3_L1, tostring(m155_3_L2)))
		end
	end
	m155_L12 = function()
		local m155_4_L1, m155_4_L2, m155_4_L3, m155_4_L4, m155_4_r1, m155_4_r2, m155_4_r3
		m155_4_r1 = ipairs
		m155_4_r3 = m155_L2.priorities
		m155_4_r2 = m155_4_r3 or {}
		for m155_4_L1, m155_4_L2 in m155_4_r1(m155_4_r2) do
			if m155_L2[m155_4_L2.flag] then
				m155_L9(m155_4_L2.flag)
				m155_4_r2 = { pcall(m155_4_L2.run) }
				m155_4_L3 = m155_4_r2[1]
				m155_4_L4 = m155_4_r2[2]
				if m155_4_L3 then
					m155_L10[m155_4_L2.flag] = nil
					m155_4_r3 = (m155_4_L4 == true)
					m155_4_r2 = m155_4_r3 and m155_L2[m155_4_L2.flag]
					if m155_4_r2 then
						return m155_4_L2.flag
					else
					end
				else
					m155_L11(m155_4_L2.flag, m155_4_L4)
				end
			end
		end
	end
	do
		return function()
			local m155_5_L1
			if m155_L2.loadedFarmLoop then
				return
			else
				m155_L2.loadedFarmLoop = true
				m155_5_L1 = (
					m155_L1.runService.Heartbeat:Connect(function()
						m155_L9(m155_L6)
					end)
				)
				m155_L3(function()
					local m155_5_2_r1
					while true do
						if not (m155_L4()) then
							break
						end
						m155_5_2_r1 = m155_L9(m155_L12())
					end
					m155_L9(nil)
					m155_5_L1:Disconnect()
					m155_L2.loadedFarmLoop = false
				end)
			end
		end
	end
end)


-- === fetcher: downloads (and caches) the redz UI library ===
local LIBRARY_OWNER = "tlredz"
local LIBRARY_PATH = LIBRARY_OWNER .. "/Library/refs/heads/main/redz-V5-remake/main.luau"
local LIBRARY_FALLBACK = LIBRARY_OWNER .. "/Library/refs/heads/main/V5/Source.lua"
local CACHE_FOLDER = "redzHub/memeSea"
local CACHE_FILE = CACHE_FOLDER .. "/library.luau"

local function readCachedLibrary()
	if type(isfile) ~= "function" or type(readfile) ~= "function" then
		return nil
	end
	local hasFile, exists = pcall(isfile, CACHE_FILE)
	if not hasFile or not exists then
		return nil
	end
	local ok, data = pcall(readfile, CACHE_FILE)
	if ok and type(data) == "string" and #data > 0 then
		if loadstring(data) then
			return data
		end
	end
	return nil
end

local function cacheLibrary(source)
	if type(writefile) ~= "function" or type(makefolder) ~= "function" then
		return
	end
	pcall(makefolder, CACHE_FOLDER)
	pcall(writefile, CACHE_FILE, source)
end

local function download(path)
	assert(type(game.HttpGet) == "function", "redz: this executor does not support game:HttpGet")
	return game:HttpGet("https://raw.githubusercontent.com/" .. path)
end

local function fetchSource(path)
	if path == LIBRARY_PATH then
		local cached = readCachedLibrary()
		if cached then
			return cached
		end
	end
	local ok, source = pcall(download, path)
	if ok and type(source) == "string" and #source > 0 then
		return source
	end
	if path == LIBRARY_PATH then
		local fallbackOk, fallback = pcall(download, LIBRARY_FALLBACK)
		if fallbackOk and type(fallback) == "string" and #fallback > 0 then
			return fallback
		end
	end
	error("redz: could not download the UI library (" .. path .. ")", 0)
end

local function createFetcher()
	local compiled = {}
	return {
		load = function(path)
			if compiled[path] then
				return compiled[path]
			end
			local source = fetchSource(path)
			if path == LIBRARY_PATH then
				cacheLibrary(source)
			end
			local chunk, err = loadstring(source, "@" .. path)
			if not chunk then
				error("redz: failed to compile " .. path .. ": " .. tostring(err), 0)
			end
			compiled[path] = chunk
			return chunk
		end,
		get = function(path)
			return fetchSource(path)
		end,
	}
end

-- === entry point ===
local fetcher = createFetcher()
state().fetcher = fetcher

environment()
local hubSettings = settings()
gameData()
skipLoadingScreen()()
local player = playerApi()
local questApi = quests()
local priorities = taskList()
startupPatches()()

state().library = fetcher.load(LIBRARY_PATH)()

local env = environment().environment
env.hubSettings = hubSettings
env.latestAttack = player
env.oneClickSettings = env.oneClickSettings or {}

questApi:updateQuestsList()
buildMenu()()

env.priorities = priorities
farmLoop()()
