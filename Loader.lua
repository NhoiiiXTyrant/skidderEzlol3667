-- ==============================================================================
--  CHILLI HUB V5 - RONNEI OFFICIAL EDITION (100% TELEPORT LOCK & FAKE 85-120 FPS)
--  Integrated features:
--    1. OFFICIAL LINK: raw.githubusercontent.com/ronnei/hihi/refs/heads/main/chillihubv5.lua
--    2. ABSOLUTE VENYX BLOCK ON REJOIN: 100% locks queue_on_teleport,
--       blocks clearteleportqueue and disconnects OnTeleport from the original script.
--    3. CONTINUOUS GUARD — NEVER DROPS EARLY: Catches the full GUI and FPS bar
--       even when Rejoin loads slowly over 15-30 seconds.
--    4. HARD-LOCKED FAKE FPS (85 - 120 FPS): Overrides at every possible point.
-- ==============================================================================

local MY_CHILLI_URL  = "https://raw.githubusercontent.com/ronnei/hihi/refs/heads/main/chillihubv5.lua"
local AUTO_RUN_FILE  = "ChilliHubV5_AutoRun.lua"
local LANG_SAVE_FILE = "ChilliV5_Lang.txt"

local CHILLI_CORE_PAYLOAD = [===[
local NEW_TITLE = "NhoiiiX Hub"
local CHILLI_LOGO_ID = "rbxassetid://70895505430795"
local LOGO_BG_COLOR = Color3.fromRGB(5, 7, 15)
local ISLAND_BLACK_BG = Color3.fromRGB(0, 0, 0)

local MY_CHILLI_URL  = "https://raw.githubusercontent.com/ronnei/hihi/refs/heads/main/chillihubv5.lua"
local AUTO_RUN_FILE  = "ChilliHubV5_AutoRun.lua"
local LANG_SAVE_FILE = "ChilliV5_Lang.txt"

-- ==================== 1. ABSOLUTE TELEPORT BLOCKER (100% CHILLI HUB V5 ONLY) ====================
do
    local env = (getgenv and getgenv()) or _G
    local realQueue = env.__ChilliOrigQueue
        or env.queue_on_teleport
        or env.queueonteleport
        or (syn and syn.queue_on_teleport)
        or (fluxus and fluxus.queue_on_teleport)
        or (delta and delta.queue_on_teleport)

    -- Self-executing code on new server join: waits for game load then runs Chilli Hub V5
    local teleportBootstrap = string.format([[
        --CHILLI_V5_AUTHORIZED_TELEPORT--
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            local Players = game:GetService("Players")
            while not Players.LocalPlayer do
                task.wait(0.1)
            end
            task.wait(1.0)
            local executed = false
            if isfile and readfile and isfile("%s") then
                local ok, fn = pcall(function() return loadstring(readfile("%s")) end)
                if ok and type(fn) == "function" then
                    executed = true
                    task.spawn(fn)
                end
            end
            if not executed then
                pcall(function()
                    loadstring(game:HttpGet("%s"))()
                end)
            end
        end)
    ]], AUTO_RUN_FILE, AUTO_RUN_FILE, MY_CHILLI_URL)

    if realQueue then
        env.__ChilliOrigQueue = realQueue

        -- Any script (including encrypted Venyx) that calls queue_on_teleport is forced to run Chilli Hub V5!
        local function forceChilliQueue(scriptCode)
            local codeStr = tostring(scriptCode or "")
            if codeStr:find("CHILLI_V5_AUTHORIZED_TELEPORT", 1, true) then
                return realQueue(scriptCode)
            end
            return realQueue(teleportBootstrap)
        end

        -- 1. Override across the entire environment table
        env.queue_on_teleport = forceChilliQueue
        env.queueonteleport = forceChilliQueue
        pcall(function() getfenv(0).queue_on_teleport = forceChilliQueue end)
        pcall(function() getfenv(0).queueonteleport = forceChilliQueue end)
        if syn then pcall(function() syn.queue_on_teleport = forceChilliQueue end) end
        if fluxus then pcall(function() fluxus.queue_on_teleport = forceChilliQueue end) end
        if delta then pcall(function() delta.queue_on_teleport = forceChilliQueue end) end

        -- 2. Directly hook the C-Closure if the executor supports hookfunction
        if hookfunction and not env.__ChilliHookFuncDone then
            env.__ChilliHookFuncDone = true
            pcall(function()
                local oldHook
                oldHook = hookfunction(realQueue, function(code)
                    local s = tostring(code or "")
                    if s:find("CHILLI_V5_AUTHORIZED_TELEPORT", 1, true) then
                        return oldHook(code)
                    end
                    return oldHook(teleportBootstrap)
                end)
            end)
        end

        -- 3. Disable clearteleportqueue so Venyx cannot clear your queue
        local noop = function() end
        env.clearteleportqueue = noop
        env.clear_teleport_queue = noop
        if syn then pcall(function() syn.clear_teleport_queue = noop end) end
        if fluxus then pcall(function() fluxus.clear_teleport_queue = noop end) end

        -- 4. Queue Chilli Hub V5 into the teleport queue immediately
        pcall(function()
            realQueue(teleportBootstrap)
        end)

        -- 5. Disconnect Venyx's OnTeleport and force-reload Chilli Hub V5 the instant a server switch happens
        task.spawn(function()
            local Players = game:GetService("Players")
            local lp = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            if lp and lp.OnTeleport then
                lp.OnTeleport:Connect(function()
                    if getconnections then
                        pcall(function()
                            for _, conn in ipairs(getconnections(lp.OnTeleport)) do
                                if conn.Function and not isexecutorclosure(conn.Function) then
                                    conn:Disable()
                                end
                            end
                        end)
                    end
                    pcall(function()
                        realQueue(teleportBootstrap)
                    end)
                end)
            end
        end)
    end
end

-- Launch the VenyxHub base script in a separate thread
if not getgenv().__VenyxV5NewLoaded then
    getgenv().__VenyxV5NewLoaded = true
    task.spawn(function()
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"))()
        end)
    end)
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local scanRoots = {
    gethui and gethui(),
    CoreGui,
    LocalPlayer:WaitForChild("PlayerGui")
}

local IGNORED_GUI_NAMES = {
    ["RobloxGui"] = true, ["TopBarApp"] = true, ["TouchGui"] = true,
    ["Chat"] = true, ["BubbleChat"] = true, ["Freecam"] = true,
    ["BackpackGui"] = true, ["PlayerList"] = true, ["PurchasePrompt"] = true
}

-- List holding all Gradients to rotate together in a single thread (0% CPU overhead)
local ActiveGradients = {}

local COLOR_SEQ_RAINBOW = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 55, 55)),
    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 175, 40)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(255, 235, 50)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(50, 255, 130)),
    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(60, 185, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 55, 55))
})

if not getgenv().__ChilliV5RainbowLoop then
    getgenv().__ChilliV5RainbowLoop = true
    task.spawn(function()
        local rot = 0
        while true do
            rot = (rot + 4) % 360
            for i = #ActiveGradients, 1, -1 do
                local g = ActiveGradients[i]
                if g and g.Parent then
                    g.Rotation = rot
                else
                    table.remove(ActiveGradients, i)
                end
            end
            task.wait(0.03)
        end
    end)
end

-- ==================== 2. IMMORTAL FAKE FPS GENERATOR (85 - 120 FPS) ====================
local currentFakeFps = math.random(96, 112)
local lastFpsStepClock = 0
local TrackedFpsLabels = {}

local function getSmoothFakeFps()
    local now = os.clock()
    if now - lastFpsStepClock >= 0.65 then
        lastFpsStepClock = now
        local delta = math.random(-4, 4)
        currentFakeFps = math.clamp(currentFakeFps + delta, 85, 120)
    end
    return currentFakeFps
end

local function isFpsCounterText(str)
    if type(str) ~= "string" or str == "" then return false end
    return str:find("FPS", 1, true) ~= nil and str:find("ms", 1, true) ~= nil and str:find("%d+%s*FPS") ~= nil
end

local function forceUpdateFpsLabel(lbl)
    if not (lbl and lbl.Parent) then return end
    if lbl:GetAttribute("__UpdatingFps") then return end
    local raw = lbl.Text
    if not isFpsCounterText(raw) then return end

    local fakeVal = getSmoothFakeFps()
    local patched = raw:gsub("%d+%s*FPS", tostring(fakeVal) .. " FPS", 1)
    if raw ~= patched then
        lbl:SetAttribute("__UpdatingFps", true)
        lbl.Text = patched
        lbl:SetAttribute("__UpdatingFps", false)
    end
end

local function hookFakeFpsCounter(lbl)
    if not (lbl:IsA("TextLabel") or lbl:IsA("TextButton")) then return end
    TrackedFpsLabels[lbl] = true
    forceUpdateFpsLabel(lbl)

    if not lbl:GetAttribute("__FpsHooked") then
        lbl:SetAttribute("__FpsHooked", true)
        lbl:GetPropertyChangedSignal("Text"):Connect(function()
            if not lbl:GetAttribute("__UpdatingFps") then
                forceUpdateFpsLabel(lbl)
            end
        end)
    end
end

-- Loop that maintains fake 85-120 FPS for the entire play session
if not getgenv().__ChilliFpsDaemon then
    getgenv().__ChilliFpsDaemon = true
    task.spawn(function()
        while true do
            task.wait(0.5)
            getSmoothFakeFps()
            for lbl in pairs(TrackedFpsLabels) do
                if lbl and lbl.Parent then
                    forceUpdateFpsLabel(lbl)
                else
                    TrackedFpsLabels[lbl] = nil
                end
            end
        end
    end)
end

-- ==================== 3. THREE-LAYER TRANSLATION DICTIONARY SYSTEM (FULL LOCALIZATION) ====================
local currentLanguage = "VI"
pcall(function()
    if isfile and isfile(LANG_SAVE_FILE) then
        local saved = readfile(LANG_SAVE_FILE)
        if saved == "EN" or saved == "VI" then
            currentLanguage = saved
        end
    end
end)

local FastCache = {}
local TrackedTexts = {}
local GlobalRefreshIslandStatus = nil

local EXACT_MATCH_VI = {
    ["Idle"] = "Idle",
    ["Waiting"] = "Waiting",
    ["Nothing"] = "Nothing",
    ["No egg matches your targets"] = "No egg matches your targets",
    ["No eggs match your targets"] = "No egg matches your targets",
    ["No egg matches filter"] = "No eggs match filter",
    ["No eggs match filter"] = "No eggs match filter",
    ["No target egg found"] = "No target egg found",
    ["No matching eggs"] = "No matching eggs",
    ["No matching pets"] = "No matching pets",
    ["No valid targets"] = "No valid targets",
    ["No targets found"] = "No targets found",
    ["Bag is full"] = "Bag is full",
    ["Egg bag is full"] = "Egg bag is full",
    ["Pet bag is full"] = "Pet bag is full",
    ["Pen is full"] = "Pen is full",
    ["All pens are full"] = "All pens are full",
    ["Field is closed"] = "Field is closed",
    ["Waiting for field to open"] = "Waiting for field to open",
    ["Waiting for eggs to spawn"] = "Waiting for eggs to spawn",
    ["Waiting for next race"] = "Waiting for next race",
    ["Waiting for shooting star"] = "Waiting for shooting star",
    ["Waiting for butterfly bloom"] = "Waiting for butterfly bloom",
    ["Waiting in safe zone"] = "Waiting in safe zone",
    ["Returning to safe zone"] = "Returning to safe zone",
    ["Returning home"] = "Returning home",
    ["Going home"] = "Going home",
    ["Going to safe zone"] = "Returning to safe zone",
    ["Delivering egg"] = "Delivering egg",
    ["Dropping egg"] = "Dropping egg",
    ["Dropping eggs"] = "Dropping egg",
    ["Selling eggs"] = "Selling eggs",
    ["Selling pets"] = "Selling pets",
    ["Selling lab eggs"] = "Selling lab eggs",
    ["Hatching eggs"] = "Hatching eggs",
    ["Placing eggs"] = "Placing eggs",
    ["Mutating eggs"] = "Mutating eggs",
    ["Fusing pets"] = "Fusing pets",
    ["Hopping server"] = "Hopping server",
    ["Finding server"] = "Finding server",
    ["Rejoining"] = "Rejoining",
    ["Avoiding guard"] = "Avoiding guard",
    ["Evading guard"] = "Avoiding guard",
    ["Using treadmill"] = "Using treadmill",
    ["Upgrading treadmill"] = "Upgrading treadmill",
    ["Upgrading base"] = "Upgrading base",
    ["Claiming rewards"] = "Claiming rewards",
    ["Claiming offline cash"] = "Claiming offline cash",
    ["Catching shooting star"] = "Catching shooting star",
    ["Catching butterfly"] = "Catching butterfly",
    ["Joining race"] = "Joining race",
    ["Racing"] = "Racing",

    -- Home Page & New Dashboard
    ["Home"] = "Home",
    ["Dashboard"] = "Dashboard",
    ["Welcome back"] = "Welcome back",
    ["Venyx Discord"] = "Chilli Hub Discord",
    ["Updates, keys, support"] = "Updates, keys, support",
    ["Copy Invite"] = "Copy Invite",
    ["Discord"] = "Discord",
    ["MONEY /S"] = "MONEY /S",
    ["OPEN"] = "OPEN",
    ["Open"] = "Open",
    ["Close"] = "Close",
    ["Welcome to Venyx 1.0.0! Join our Discord for updates and support"] = "Welcome to Chilli Hub V5! Join our Discord for updates and support",
    ["Beta version"] = "Beta version",
    ["This is a test build. Features may change and bugs can happen."] = "This is a test build. Features may change and bugs can happen.",
    ["Rejoin"] = "Rejoin",
    ["Server hop"] = "Server hop",
    ["Copy Job ID"] = "Copy Job ID",
    ["Unload hub"] = "Unload hub",
    ["Save config"] = "Save config",
    ["Hide UI"] = "Hide UI",
    ["SESSION"] = "SESSION",
    ["STOLEN"] = "STOLEN",
    ["LAST EGG"] = "LAST EGG",
    ["PLACED"] = "PLACED",
    ["HATCHED"] = "HATCHED",
    ["NIGHT IN"] = "NIGHT IN",
    ["SESSION TIME"] = "SESSION TIME",
    ["BEST STEAL"] = "BEST STEAL",
    ["EGG BAG"] = "EGG BAG",
    ["PET BAG"] = "PET BAG",
    ["WHAT'S NEW"] = "WHAT'S NEW",
    ["NEW"] = "NEW",
    ["Event"] = "Event",
    ["Racing Event: ragdoll jump to the portal, races, leaves and claims"] = "Racing Event: ragdoll jump to the portal, races, leaves and claims",
    ["Shooting Star catcher with ragdoll jump and run fallback"] = "Shooting Star catcher with ragdoll jump and run fallback",
    ["Steal panel joins the game buttons and lists every egg"] = "Steal panel joins the game buttons and lists every egg",
    ["Search"] = "Search",
    ["Filter"] = "Filter",

    -- Steal & Egg Predictor
    ["Steal"] = "Steal",
    ["Auto Steal"] = "Auto Steal",
    ["AUTO STEAL"] = "AUTO STEAL",
    ["Auto steal"] = "Auto steal",
    ["Egg Predictor"] = "Egg Predictor",
    ["EGG PREDICTOR"] = "EGG PREDICTOR",
    ["Go to egg"] = "Go to egg",
    ["Teleport to egg"] = "Teleport to egg",
    ["Teleport zones"] = "Teleport zone",
    ["Teleport zone"] = "Teleport zone",
    ["Tween"] = "Tween",
    ["Walk"] = "Walk",
    ["Delivery method"] = "Delivery method",
    ["Fast tween speed"] = "Fast tween speed",
    ["Tween speed"] = "Tween speed",
    ["Steal missing index eggs"] = "Steal missing index eggs",
    ["Steal back from players"] = "Steal back from players",
    ["Steal from other players"] = "Steal from other players",
    ["Steal from players"] = "Steal from players",
    ["Anti guard"] = "Anti guard",
    ["Drop eggs at safe zone"] = "Drop eggs at safe zone",
    ["FILTER"] = "FILTER",
    ["Zones"] = "Zone",
    ["Zone"] = "Zone",
    ["None"] = "None",
    ["Steal first"] = "Steal first",
    ["Best value"] = "Best value",
    ["Lowest value"] = "Lowest value",
    ["Best rarity"] = "Highest rarity",
    ["Best mutation"] = "Best mutation",
    ["Biggest"] = "Biggest",
    ["Closest"] = "Closest",
    ["Mutations"] = "Mutations",
    ["Rarities"] = "Rarities",
    ["Only these eggs"] = "Only these eggs",
    ["Min value /s"] = "Min value /s",
    ["Max value /s"] = "Max value /s",
    ["Off"] = "Off",
    ["OFF"] = "OFF",
    ["On"] = "On",
    ["ON"] = "ON",
    ["Sell cheapest egg when bag is full"] = "Sell cheapest egg when bag is full",
    ["Keep lab eggs"] = "Keep lab eggs",
    ["AUTO HOP SERVER"] = "AUTO HOP SERVER",
    ["Auto hop server"] = "Auto hop server",
    ["Hop when no matching egg"] = "Hop when no matching egg",
    ["Hop when no egg matches"] = "Hop when no matching egg",
    ["Hop delay"] = "Hop delay",
    ["Only sell eggs below /s"] = "Only sell eggs below /s",
    ["EGG SHOWCASE"] = "EGG SHOWCASE",
    ["Sort eggs"] = "Sort eggs",
    ["Preview card"] = "Preview card",
    ["Pick one"] = "Pick one",
    ["Pick any"] = "Pick any",
    ["Value"] = "Value",
    ["Rarity"] = "Rarities",
    ["Time left"] = "Time left",
    ["Default"] = "Default",
    ["Clear"] = "Clear",
    ["Select all"] = "Select all",
    ["SIZE"] = "SIZE",
    ["WEIGHT"] = "WEIGHT",
    ["READY"] = "READY",
    ["IN BAG"] = "IN BAG",
    ["GROWING"] = "GROWING",
    ["Hatch now"] = "Hatch now",
    ["Hold egg"] = "Hold egg",
    ["Fly to egg"] = "Fly to egg",
    ["Steal egg"] = "Steal egg",

    -- Zones
    ["Enchanted Forest"] = "Enchanted Forest",
    ["Light Dark"] = "Light Dark",
    ["Titan Temple"] = "Titan Temple",
    ["Cherry Blossom"] = "Cherry Blossom",
    ["Prehistoric"] = "Prehistoric",
    ["Abyss Ocean"] = "Abyss Ocean",
    ["Volcano"] = "Volcano",
    ["Snow"] = "Snow",
    ["Jungle"] = "Jungle",
    ["Desert"] = "Desert",
    ["Lake"] = "Lake",
    ["Forest"] = "Forest",

    -- Mutations
    ["Silver"] = "Silver",
    ["Rainbow"] = "Rainbow",
    ["Golden"] = "Golden",
    ["Fractured"] = "Fractured",
    ["Scrambled"] = "Scrambled",
    ["Enchanted"] = "Enchanted",
    ["Nitro"] = "Nitro",
    ["SCRAMBLED"] = "SCRAMBLED",
    ["NITRO"] = "NITRO",
    ["FRACTURED"] = "FRACTURED",
    ["ENCHANTED"] = "ENCHANTED",

    -- Farm: Pen, Treadmill, Mutate, Sell, Fuse, Priority
    ["Farm"] = "Farm",
    ["Pen"] = "Pen",
    ["PEN"] = "PEN",
    ["Treadmill"] = "Treadmill",
    ["TREADMILL"] = "TREADMILL",
    ["Mutate"] = "Mutate",
    ["MUTATE"] = "MUTATE",
    ["Sell"] = "Sell",
    ["SELL"] = "SELL",
    ["Fuse"] = "Fuse",
    ["FUSE"] = "FUSE",
    ["Priority"] = "Priority",
    ["PRIORITY"] = "PRIORITY",
    ["AUTO PLACE"] = "AUTO PLACE",
    ["Auto place"] = "Auto place",
    ["Place when"] = "Place when",
    ["Always"] = "Always",
    ["Place first"] = "Place first",
    ["AUTO HATCH"] = "AUTO HATCH",
    ["Auto hatch"] = "Auto hatch",
    ["Equip best pets"] = "Equip best pets",
    ["READY NOW"] = "READY NOW",
    ["Auto treadmill"] = "Auto treadmill",
    ["Auto upgrade treadmill"] = "Auto upgrade treadmill",
    ["PROGRESS"] = "PROGRESS",
    ["Auto upgrade base"] = "Auto upgrade base",
    ["Auto buy trails"] = "Auto buy trails",
    ["Auto claim offline cash"] = "Auto claim offline cash",
    ["Auto claim index rewards"] = "Auto claim index rewards",
    ["AUTO MUTATE"] = "AUTO MUTATE",
    ["Auto mutate"] = "Auto mutate",
    ["MUTATE FILTER"] = "MUTATE FILTER",
    ["Use items"] = "Use items",
    ["Mutate first"] = "Mutate first",
    ["Auto buy Nitro"] = "Auto buy Nitro",
    ["PETS"] = "PETS",
    ["EGGS"] = "EGGS",
    ["Auto sell pets"] = "Auto sell pets",
    ["Auto sell eggs"] = "Auto sell eggs",
    ["Sell rarities"] = "Sell rarities",
    ["Never sell"] = "Never sell",
    ["Only mutations"] = "Only mutations",
    ["Only below /s"] = "Only below /s",
    ["Keep mutated"] = "Keep mutated",
    ["Sell matching pets now"] = "Sell matching pets now",
    ["Sell matching eggs now"] = "Sell matching eggs now",
    ["LAB EGGS"] = "LAB EGGS",
    ["FAVORITE"] = "FAVORITE",
    ["Auto favorite"] = "Auto favorite",
    ["Auto sell lab eggs"] = "Auto sell lab eggs",
    ["Sell matching lab eggs now"] = "Sell matching lab eggs now",
    ["Match"] = "Match",
    ["All picked rules"] = "All picked rules",
    ["Any picked rule"] = "Any picked rule",
    ["Always favorite"] = "Always favorite",
    ["Favorite equipped"] = "Favorite equipped",
    ["FUSE MACHINE"] = "FUSE MACHINE",
    ["No 3 matching pets"] = "No 3 matching pets",
    ["Auto fuse"] = "Auto fuse",
    ["Fuse first"] = "Fuse first",
    ["Lowest rarity"] = "Lowest rarity",
    ["Highest rarity"] = "Highest rarity",
    ["Use pets"] = "Use pets",
    ["Lowest value first"] = "Lowest value first",
    ["Highest value first"] = "Highest value first",
    ["Skip mutated"] = "Skip mutated",
    ["Eject odd pets"] = "Eject odd pets",
    ["FUSE FILTER"] = "FUSE FILTER",
    ["Only these pets"] = "Only these pets",
    ["Never fuse"] = "Never fuse",
    ["FUSE PREDICTOR"] = "FUSE PREDICTOR",
    ["SLOTS"] = "SLOTS",
    ["STATUS"] = "STATUS",
    ["Waiting for pets"] = "Waiting for pets",
    ["LIKELY SIZE"] = "LIKELY SIZE",
    ["CHANCE"] = "CHANCE",
    ["VALUE"] = "VALUE",
    ["BEST CASE"] = "BEST CASE",
    ["TASK ORDER"] = "TASK ORDER",
    ["Top goes first. A carried egg is always delivered first, and before the field opens every task waits in the safe zone."] = "Top goes first. A carried egg is always delivered first, and before the field opens every task waits in the safe zone.",
    ["DOING"] = "DOING",
    ["WAITING"] = "WAITING",
    ["Steal filter eggs"] = "Steal filter eggs",
    ["Shooting Star"] = "Shooting Star",
    ["Racing Event"] = "Racing Event",
    ["Butterfly"] = "Butterfly",
    ["Steal wisp eggs"] = "Steal wisp eggs",
    ["Wisp"] = "Wisp",
    ["Steal missing index"] = "Steal missing index eggs",
    ["Steal lab eggs"] = "Steal lab eggs",
    ["Place"] = "Place",
    ["Butterfly machine"] = "Butterfly machine",

    -- Events: Race, Star, Butterfly, Lab, AA
    ["Race"] = "Race",
    ["RACE"] = "RACE",
    ["Star"] = "Star",
    ["STAR"] = "STAR",
    ["BUTTERFLY"] = "BUTTERFLY",
    ["Lab"] = "Lab",
    ["LAB"] = "LAB",
    ["AA"] = "AA",
    ["RACING EVENT"] = "RACING EVENT",
    ["NEXT RACE"] = "NEXT RACE",
    ["WINS"] = "WINS",
    ["TROPHIES"] = "TROPHIES",
    ["Auto race"] = "Auto race",
    ["Race speed"] = "Race speed",
    ["Lower it if wins do not count"] = "Lower it if wins do not count",
    ["Use power-ups"] = "Use power-ups",
    ["REWARDS"] = "REWARDS",
    ["Auto claim rewards"] = "Auto claim rewards",
    ["Auto equip racer"] = "Auto equip racer",
    ["Racer"] = "Racer",
    ["Best owned"] = "Best owned",
    ["Auto buy shop"] = "Auto buy shop",
    ["Shop items"] = "Shop items",
    ["SHOOTING STAR"] = "SHOOTING STAR",
    ["LANDS IN"] = "LANDS IN",
    ["CATCH"] = "CATCH",
    ["A Shooting Star is rare and only you can catch yours. It lands in Cosmic, runs from you, and needs a 1.6 s hold."] = "A Shooting Star is rare and only you can catch yours. It lands in Cosmic, runs from you, and needs a 1.6 s hold.",
    ["CAUGHT"] = "CAUGHT",
    ["EXPIRES IN"] = "EXPIRES IN",
    ["SLIPPED"] = "SLIPPED",
    ["TRIES"] = "TRIES",
    ["DISTANCE"] = "DISTANCE",
    ["Auto catch shooting star"] = "Auto catch shooting star",
    ["BUTTERFLY BLOOM"] = "BUTTERFLY BLOOM",
    ["Auto butterfly bloom"] = "Auto butterfly bloom",
    ["EMERALD"] = "EMERALD",
    ["SAPPHIRE"] = "SAPPHIRE",
    ["AMETHYST"] = "AMETHYST",
    ["RADIANT"] = "RADIANT",
    ["ESSENCE"] = "ESSENCE",
    ["Catch mode"] = "Catch mode",
    ["Stand"] = "Stand",
    ["Chase"] = "Chase",
    ["BUTTERFLY MACHINE"] = "BUTTERFLY MACHINE",
    ["Auto trade up"] = "Auto trade up",
    ["Trade"] = "Trade",
    ["Smart trade for essence"] = "Smart trade for essence",
    ["Auto craft essence"] = "Auto craft essence",
    ["WISP COMPANION"] = "WISP COMPANION",
    ["Catch priority"] = "Catch priority",
    ["Rarest"] = "Rarest",
    ["Catch"] = "Catch",
    ["Radiant"] = "Radiant",
    ["Catch speed"] = "Catch speed",
    ["Auto wisp quest"] = "Auto wisp quest",
    ["Auto banjo cricket"] = "Auto banjo cricket",
    ["STAGE"] = "STAGE",
    ["LAB ODDS"] = "LAB ODDS",
    ["BANNER"] = "BANNER",
    ["ENDS IN"] = "ENDS IN",
    ["BANNER CHANCE"] = "BANNER CHANCE",
    ["NEXT"] = "NEXT",
    ["Experimental Pets"] = "Experimental Pets",
    ["Biohazard Pets"] = "Biohazard Pets",
    ["Lab banners"] = "Lab banners",
    ["Auto trade in"] = "Auto trade in",
    ["Auto reroll recipe"] = "Auto reroll recipe",
    ["Place lab reward eggs"] = "Place lab reward eggs",
    ["ADMIN ABUSE"] = "ADMIN ABUSE",
    ["No admin boost right now"] = "No admin boost right now",
    ["Instant steal (Admin Treadmill)"] = "Instant steal (Admin Treadmill)",
    ["Use admin treadmill"] = "Use admin treadmill",
    ["CAPTURE THE EGG"] = "CAPTURE THE EGG",
    ["Auto capture event egg"] = "Auto capture event egg",
    ["Take it from the holder"] = "Take it from the holder",
    ["Hold height"] = "Hold height",
    ["Keep away"] = "Keep away",
    ["MINIGAME EGGS"] = "MINIGAME EGGS",
    ["Waiting for Red Light Green Light or T-Rex Run"] = "Waiting for Red Light Green Light or T-Rex Run",
    ["Auto steal minigame egg"] = "Auto steal minigame egg",

    -- Player: ESP, Move, Combat
    ["Player"] = "Player",
    ["ESP"] = "ESP",
    ["Move"] = "Move",
    ["MOVE"] = "MOVE",
    ["Combat"] = "Combat",
    ["COMBAT"] = "COMBAT",
    ["FIELD EGGS"] = "FIELD EGGS",
    ["Egg ESP"] = "Egg ESP",
    ["Show"] = "Show",
    ["Name"] = "Name",
    ["Fixed size"] = "Fixed size",
    ["OTHERS"] = "OTHERS",
    ["Pen egg ESP"] = "Pen egg ESP",
    ["Other pens ESP"] = "Other pens ESP",
    ["Guard ESP"] = "Guard ESP",
    ["Player ESP"] = "Player ESP",
    ["ESP size"] = "ESP size",
    ["MOVEMENT"] = "MOVEMENT",
    ["Speed boost"] = "Speed boost",
    ["Boost speed"] = "Boost speed",
    ["Infinite jump"] = "Infinite jump",
    ["God mode"] = "God mode",
    ["PROTECTION"] = "PROTECTION",
    ["Anti ragdoll"] = "Anti ragdoll",
    ["Ignore traps"] = "Ignore traps",
    ["Instant prompts"] = "Instant prompts",
    ["Anti AFK"] = "Anti AFK",
    ["Invisible"] = "Invisible",
    ["AUTO HIT"] = "AUTO HIT",
    ["Auto hit"] = "Auto hit",
    ["Hit who"] = "Hit who",
    ["Nearest player"] = "Nearest player",
    ["Chosen player"] = "Chosen player",
    ["Chase speed"] = "Chase speed",
    ["HIT AURA"] = "HIT AURA",
    ["Hit aura"] = "Hit aura",
    ["Skip friends"] = "Skip friends",
    ["WEAPONS"] = "WEAPONS",
    ["Use weapons"] = "Use weapons",
    ["Hold each"] = "Hold each",

    -- System: Server, Webhook, Optimizer, Interface, Config
    ["System"] = "System",
    ["Server"] = "Server",
    ["SERVER"] = "SERVER",
    ["Webhook"] = "Webhook",
    ["WEBHOOK"] = "WEBHOOK",
    ["Optimizer"] = "Optimizer",
    ["OPTIMIZER"] = "OPTIMIZER",
    ["Interface"] = "Interface",
    ["INTERFACE"] = "INTERFACE",
    ["Config"] = "Config",
    ["CONFIG"] = "CONFIG",
    ["Hop to"] = "Hop to",
    ["Least players"] = "Least players",
    ["Most players"] = "Most players",
    ["Random"] = "Random",
    ["Hop server"] = "Hop server",
    ["Hop"] = "Hop",
    ["Rejoin this server"] = "Rejoin this server",
    ["Copy"] = "Copy",
    ["JOIN AND STAY"] = "JOIN AND STAY",
    ["Job ID"] = "Job ID",
    ["Paste a Job ID"] = "Paste a Job ID",
    ["Join that server"] = "Join that server",
    ["Join"] = "Join",
    ["Rejoin on kick"] = "Rejoin on kick",
    ["Auto load script"] = "Auto load script",
    ["DISCORD WEBHOOK"] = "DISCORD WEBHOOK",
    ["Webhook URL"] = "Webhook URL",
    ["Ping everyone"] = "Ping everyone",
    ["WHAT TO POST"] = "WHAT TO POST",
    ["Post stolen eggs"] = "Post stolen eggs",
    ["Post fused eggs"] = "Post fused eggs",
    ["POSTED"] = "POSTED",
    ["Send a test post"] = "Send a test post",
    ["Test"] = "Test",
    ["Post when bag is full"] = "Post when bag is full",
    ["GRAPHICS"] = "GRAPHICS",
    ["Low graphics"] = "Low graphics",
    ["Disable 3D Render"] = "Disable 3D Render",
    ["Background color"] = "Background color",
    ["Black"] = "Black",
    ["White"] = "White",
    ["Hide game UI"] = "Hide game UI",
    ["FRAME RATE"] = "FRAME RATE",
    ["FPS cap"] = "FPS cap",
    ["Show FPS and ping"] = "Show FPS and ping",
    ["BASES"] = "BASES",
    ["Hide other players' pets and eggs"] = "Hide other players' pets and eggs",
    ["Hide my pets and eggs"] = "Hide my pets and eggs",
    ["Theme"] = "Theme",
    ["Toggle key"] = "Toggle key",
    ["Quick bar"] = "Quick bar",
    ["QUICK BAR"] = "QUICK BAR",
    ["Auto save"] = "Auto save",
    ["Auto load"] = "Auto load",
    ["Load config"] = "Load config",
    ["Reset config"] = "Reset config",
    ["Delete config"] = "Delete config",

    -- Rarity tiers
    ["Common"] = "Common",
    ["Uncommon"] = "Uncommon",
    ["Rare"] = "Rare",
    ["Epic"] = "Epic",
    ["Legendary"] = "Legendary",
    ["Mythic"] = "Mythic",
    ["Cosmic"] = "Cosmic",
    ["Secret"] = "Secret",
    ["Divine"] = "Divine",
    ["Eternal"] = "Eternal",
    ["COMMON"] = "COMMON",
    ["UNCOMMON"] = "UNCOMMON",
    ["RARE"] = "RARE",
    ["EPIC"] = "EPIC",
    ["LEGENDARY"] = "LEGENDARY",
    ["MYTHIC"] = "MYTHIC",
    ["COSMIC"] = "COSMIC",
    ["SECRET"] = "SECRET",
    ["DIVINE"] = "DIVINE",
    ["ETERNAL"] = "ETERNAL"
}

local STATUS_ACTION_PATTERNS_VI = {
    { pat = "^[Nn]o eggs? match%(?e?s?%)? your (.+)$", rep = "No eggs matching %1" },
    { pat = "^[Nn]o eggs? match%(?e?s?%)? (.+)$", rep = "No eggs matching %1" },
    { pat = "^[Nn]o pets? match%(?e?s?%)? (.+)$", rep = "No pets matching %1" },
    { pat = "^[Nn]o (.+) found$", rep = "No %1 found" },
    { pat = "^[Nn]o (.+) available$", rep = "No %1 available" },
    { pat = "^[Nn]o (.+) to (.+)$", rep = "No %1 to %2" },
    { pat = "^[Cc]arrying (.+) to safe zone$", rep = "Carrying %1 to safe zone" },
    { pat = "^[Cc]arrying (.+) to base$", rep = "Carrying %1 to base" },
    { pat = "^[Cc]arrying (.+) to pen$", rep = "Carrying %1 to pen" },
    { pat = "^[Cc]arrying (.+) home$", rep = "Carrying %1 home" },
    { pat = "^[Cc]arrying (.+)$", rep = "Carrying %1" },
    { pat = "^[Dd]elivering (.+) to (.+)$", rep = "Delivering %1 to %2" },
    { pat = "^[Dd]elivering (.+) home$", rep = "Delivering %1 home" },
    { pat = "^[Dd]elivering (.+)$", rep = "Delivering %1" },
    { pat = "^[Bb]ringing (.+) home$", rep = "Carrying %1 home" },
    { pat = "^[Bb]ringing (.+)$", rep = "Bringing %1" },
    { pat = "^[Tt]aking (.+) from (.+)$", rep = "Taking %1 from %2" },
    { pat = "^[Tt]aking (.+) home$", rep = "Taking %1 home" },
    { pat = "^[Tt]aking (.+)$", rep = "Taking %1" },
    { pat = "^[Ss]tealing (.+) from (.+)$", rep = "Stealing %1 from %2" },
    { pat = "^[Ss]tealing (.+)$", rep = "Stealing %1" },
    { pat = "^[Gg]rabbing (.+)$", rep = "Grabbing %1" },
    { pat = "^[Pp]icking up (.+)$", rep = "Picking up %1" },
    { pat = "^[Cc]ollecting (.+)$", rep = "Collecting %1" },
    { pat = "^[Hh]olding (.+)$", rep = "Holding %1" },
    { pat = "^[Cc]apturing (.+)$", rep = "Capturing %1" },
    { pat = "^[Dd]ropping (.+) at (.+)$", rep = "Dropping %1 at %2" },
    { pat = "^[Dd]ropping (.+)$", rep = "Dropping %1" },
    { pat = "^[Tt]weening to (.+)$", rep = "Tweening to %1" },
    { pat = "^[Tt]eleporting to (.+)$", rep = "Teleporting to %1" },
    { pat = "^[Gg]oing to (.+)$", rep = "Going to %1" },
    { pat = "^[Mm]oving to (.+)$", rep = "Moving to %1" },
    { pat = "^[Ww]alking to (.+)$", rep = "Walking to %1" },
    { pat = "^[Rr]unning to (.+)$", rep = "Walking to %1" },
    { pat = "^[Ff]lying to (.+)$", rep = "Tweening to %1" },
    { pat = "^[Rr]eturning to (.+)$", rep = "Returning to %1" },
    { pat = "^[Hh]eading to (.+)$", rep = "Heading to %1" },
    { pat = "^[Pp]lacing (.+)$", rep = "Placing %1" },
    { pat = "^[Hh]atching (.+)$", rep = "Hatching %1" },
    { pat = "^[Mm]utating (.+)$", rep = "Mutating %1" },
    { pat = "^[Ss]elling (.+)$", rep = "Selling %1" },
    { pat = "^[Ff]using (.+)$", rep = "Fusing %1" },
    { pat = "^[Uu]pgrading (.+)$", rep = "Upgrading %1" },
    { pat = "^[Bb]uying (.+)$", rep = "Buying %1" },
    { pat = "^[Cc]laiming (.+)$", rep = "Claiming %1" },
    { pat = "^[Ee]quipping (.+)$", rep = "Equipping %1" },
    { pat = "^[Ff]avoriting (.+)$", rep = "Favoriting %1" },
    { pat = "^[Ee]jecting (.+)$", rep = "Ejecting %1" },
    { pat = "^[Cc]atching (.+)$", rep = "Catching %1" },
    { pat = "^[Cc]hasing (.+)$", rep = "Chasing %1" },
    { pat = "^[Aa]ttacking (.+)$", rep = "Attacking %1" },
    { pat = "^[Hh]itting (.+)$", rep = "Hitting %1" },
    { pat = "^[Kk]illing (.+)$", rep = "Killing %1" },
    { pat = "^[Tt]rading (.+) for (.+)$", rep = "Trading %1 for %2" },
    { pat = "^[Tt]rading in (.+)$", rep = "Trading in %1" },
    { pat = "^[Tt]rading (.+)$", rep = "Trading %1" },
    { pat = "^[Cc]rafting (.+)$", rep = "Crafting %1" },
    { pat = "^[Rr]erolling (.+)$", rep = "Rerolling %1" },
    { pat = "^[Aa]voiding (.+)$", rep = "Avoiding %1" },
    { pat = "^[Ee]vading (.+)$", rep = "Evading %1" },
    { pat = "^[Ww]aiting for (.+)$", rep = "Waiting for %1" },
    { pat = "^[Ww]aiting in (.+)$", rep = "Waiting in %1" },
    { pat = "^[Ww]aiting %((.+)%)$", rep = "Waiting (%1)" },
    { pat = "^[Ss]earching for (.+)$", rep = "Searching for %1" },
    { pat = "^[Ll]ooking for (.+)$", rep = "Searching for %1" },
    { pat = "^[Ff]arming (.+)$", rep = "Farming %1" },
    { pat = "^[Uu]sing (.+)$", rep = "Using %1" },
    { pat = "^[Jj]oining (.+)$", rep = "Joining %1" },
    { pat = "^[Hh]opping (.+)$", rep = "Trading in %1" }
}

local SMART_PHRASE_FALLBACK_VI = {
    { "No egg matches your targets", "No egg matches your targets" },
    { "no egg matches your targets", "no egg matches your targets" },
    { "your targets", "your targets" },
    { "matches your", "matches your" },
    { "matches filter", "matches filter" },
    { "safe zone", "safe zone" },
    { "other players", "other players" },
    { "from players", "from players" },
    { "missing index", "missing index" },
    { "shooting star", "shooting star" },
    { "butterfly bloom", "butterfly bloom" },
    { "admin treadmill", "admin treadmill" },
    { "offline cash", "offline cash" },
    { "index rewards", "index rewards" },
    { "lab eggs", "lab eggs" },
    { "lab egg", "lab egg" },
    { "event egg", "event egg" },
    { "minigame egg", "minigame egg" },
    { "is full", "is full" },
    { "is closed", "is closed" },
    { "is open", "is open" },
    { "to open", "to open" },
    { "Carrying ", "Carrying " },
    { "Delivering ", "Delivering " },
    { "Stealing ", "Stealing " },
    { "Teleporting ", "Teleporting " },
    { "Tweening ", "Tweening " },
    { "Moving ", "Moving " },
    { "Walking ", "Walking " },
    { "Running ", "Running " },
    { "Placing ", "Placing " },
    { "Hatching ", "Hatching " },
    { "Mutating ", "Mutating " },
    { "Selling ", "Selling " },
    { "Fusing ", "Fusing " },
    { "Catching ", "Catching " },
    { "Chasing ", "Chasing " },
    { "Waiting ", "Waiting " },
    { "Searching ", "Searching " },
    { "Claiming ", "Claiming " },
    { "Upgrading ", "Upgrading " },
    { "Buying ", "Buying " },
    { "Trading ", "Trading " },
    { "Crafting ", "Crafting " },
    { "Collecting ", "Collecting " },
    { "Holding ", "Holding " },
    { "Dropping ", "Dropping " },
    { "Returning ", "Returning " },
    { "Avoiding ", "Avoiding " },
    { "Evading ", "Evading " },
    { "Attacking ", "Attacking " },
    { "Hitting ", "Hitting " },
    { "Finding ", "Finding " },
    { "Checking ", "Checking " },
    { "Skipping ", "Skipping " },
    { " home", " home" },
    { "targets", "targets" },
    { "target", "target" },
    { "guards", "guards" },
    { "guard", "guard" }
}

local DYNAMIC_PATTERNS_VI = {
    { pat = "^QUICK BAR (%d+)$", rep = "QUICK BAR %1" },
    { pat = "Venyx(.-)(%d+) hours? ago", rep = "Chilli Hub%1%2 hours ago" },
    { pat = "Venyx(.-)(%d+) minutes? ago", rep = "Chilli Hub%1%2 minutes ago" },
    { pat = "Venyx(.-)(%d+) days? ago", rep = "Chilli Hub%1%2 days ago" },
    { pat = "^ALL (%d+)$", rep = "ALL %1" },
    { pat = "^READY (%d+)$", rep = "READY %1" },
    { pat = "^GROWING (%d+)$", rep = "GROWING %1" },
    { pat = "^IN BAG (%d+)$", rep = "IN BAG %1" },
    { pat = "Pen (%d+/%d+) · (%d+) egg%(s%) ready to place", rep = "Pen %1 · %2 egg(s) ready to place" },
    { pat = "(%d+) egg%(s%) can be mutated", rep = "%1 egg(s) can be mutated" },
    { pat = "(%d+) pet%(s%) match", rep = "%1 pet(s) match" },
    { pat = "(%d+) egg%(s%) match", rep = "%1 egg(s) match" },
    { pat = "(%d+) lab egg%(s%) match", rep = "%1 lab egg(s) match" },
    { pat = "^(%d+) pets$", rep = "%1 pets" },
    { pat = "(%d+ / %d+) players · (.+)", rep = "%1 players · %2" },
    { pat = "Experimental Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep = "Experimental Pets · needs %1 · pity %2 · rerolls %3 · %4" },
    { pat = "Biohazard Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep = "Biohazard Pets · needs %1 · pity %2 · rerolls %3 · %4" },
    { pat = "Unstable DNA · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep = "Unstable DNA · needs %1 · pity %2 · rerolls %3 · %4" },
    { pat = "^Mythic · 1 in ([%d%.]+)$", rep = "Mythic · 1 in %1" },
    { pat = "^Cosmic · 1 in ([%d%.]+)$", rep = "Cosmic · 1 in %1" },
    { pat = "^Secret · 1 in ([%d%.]+)$", rep = "Secret · 1 in %1" },
    { pat = "^Divine · 1 in ([%d%.]+)$", rep = "Divine · 1 in %1" },
    { pat = "^Eternal · 1 in ([%d%.]+)$", rep = "Eternal · 1 in %1" }
}

local function applySmartPhraseFallback(str)
    local out = str
    for _, pair in ipairs(SMART_PHRASE_FALLBACK_VI) do
        local en, vi = pair[1], pair[2]
        if out:find(en, 1, true) then
            out = out:gsub(en:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"), vi)
        end
    end
    return out
end

local function translateStatusAction(cleanEn)
    if not cleanEn or cleanEn == "" then return "Idle" end
    if currentLanguage == "EN" then
        if cleanEn == "Idle" then return "Idle" end
        return cleanEn
    end

    local trimmed = (cleanEn:match("^%s*(.-)%s*$") or cleanEn):gsub("%s+", " ")
    if trimmed:lower() == "idle" or trimmed == "Idle" then
        return "Idle"
    end

    local cacheKey = "STATUS_VI|" .. trimmed
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if EXACT_MATCH_VI[trimmed] then
        FastCache[cacheKey] = EXACT_MATCH_VI[trimmed]
        return EXACT_MATCH_VI[trimmed]
    end

    for _, item in ipairs(STATUS_ACTION_PATTERNS_VI) do
        if trimmed:find(item.pat) then
            local out = trimmed:gsub(item.pat, item.rep)
            out = applySmartPhraseFallback(out)
            FastCache[cacheKey] = out
            return out
        end
    end

    local fallbackOut = applySmartPhraseFallback(trimmed)
    FastCache[cacheKey] = fallbackOut
    return fallbackOut
end

local function translateVenyxText(raw)
    if not raw or raw == "" then return raw end
    local cacheKey = currentLanguage .. "|" .. raw
    if FastCache[cacheKey] then return FastCache[cacheKey] end

    if raw:find("Venyx SAE", 1, true) then
        raw = raw:gsub("Venyx SAE", "Chilli SAE")
    elseif raw == "VENYX" then
        raw = NEW_TITLE
    end

    if currentLanguage == "EN" then
        FastCache[cacheKey] = raw
        return raw
    end

    local normalized = (raw:match("^%s*(.-)%s*$") or raw):gsub("%s+", " ")

    if EXACT_MATCH_VI[normalized] then
        local out = EXACT_MATCH_VI[normalized]
        FastCache[cacheKey] = out
        return out
    end

    local baseBeforeDots = normalized:match("^(.+)%.%.%.$")
    if baseBeforeDots then
        baseBeforeDots = baseBeforeDots:match("^%s*(.-)%s*$") or baseBeforeDots
        if EXACT_MATCH_VI[baseBeforeDots] then
            local out = EXACT_MATCH_VI[baseBeforeDots] .. "..."
            FastCache[cacheKey] = out
            return out
        end
    end

    local prefix, wordPart = normalized:match("^([^%w%s]+%s*)(.+)$")
    if prefix and wordPart and EXACT_MATCH_VI[wordPart] then
        local out = prefix .. EXACT_MATCH_VI[wordPart]
        FastCache[cacheKey] = out
        return out
    end

    local result = normalized
    for _, item in ipairs(DYNAMIC_PATTERNS_VI) do
        if result:find(item.pat) then
            result = result:gsub(item.pat, item.rep)
            FastCache[cacheKey] = result
            return result
        end
    end

    for _, item in ipairs(STATUS_ACTION_PATTERNS_VI) do
        if result:find(item.pat) then
            result = result:gsub(item.pat, item.rep)
            result = applySmartPhraseFallback(result)
            FastCache[cacheKey] = result
            return result
        end
    end

    FastCache[cacheKey] = raw
    return raw
end

local function applyElementTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__FpsHooked") or inst:GetAttribute("__HiddenVxLogo") or inst.Name == "IslandExpandHint" or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") then return end
    if inst:GetAttribute("__IsTranslating") then return end

    if inst:IsA("TextBox") then
        local origPh = inst:GetAttribute("OrigPlaceholder")
        if not origPh and inst.PlaceholderText ~= "" then
            origPh = inst.PlaceholderText
            inst:SetAttribute("OrigPlaceholder", origPh)
        end
        if origPh then
            inst.PlaceholderText = translateVenyxText(origPh)
        end

        if not inst:IsFocused() then
            local boxTxt = inst.Text
            if boxTxt == "Off" or boxTxt == "Off" or boxTxt == "None" or boxTxt == "None" then
                local origBox = inst:GetAttribute("OrigBoxText")
                if not origBox or (boxTxt == "Off" or boxTxt == "None") then
                    origBox = (boxTxt == "Off") and "Off" or ((boxTxt == "None") and "None" or boxTxt)
                    inst:SetAttribute("OrigBoxText", origBox)
                end
                local mappedBox = translateVenyxText(origBox)
                if inst.Text ~= mappedBox then
                    inst:SetAttribute("__IsTranslating", true)
                    pcall(function() inst.Text = mappedBox end)
                    inst:SetAttribute("__IsTranslating", false)
                end
            end
        end
        return
    end

    local rawText = inst.Text
    if isFpsCounterText(rawText) then
        hookFakeFpsCounter(inst)
        return
    end

    local original = inst:GetAttribute("OrigRawText")
    if not original then
        original = rawText
        inst:SetAttribute("OrigRawText", original)
    end

    local mapped = translateVenyxText(original)
    if inst.Text ~= mapped then
        inst:SetAttribute("__IsTranslating", true)
        inst:SetAttribute("__LastTranslated", mapped)
        pcall(function() inst.Text = mapped end)
        inst:SetAttribute("__IsTranslating", false)
    end
end

local function hookTextForTranslation(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") or inst.Name == "IslandExpandHint" or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") then return end

    if not inst:IsA("TextBox") and isFpsCounterText(inst.Text) then
        hookFakeFpsCounter(inst)
        return
    end

    applyElementTranslation(inst)

    if inst:GetAttribute("__TransHooked") then return end
    inst:SetAttribute("__TransHooked", true)
    table.insert(TrackedTexts, inst)

    inst:GetPropertyChangedSignal("Text"):Connect(function()
        if inst:GetAttribute("__IsTranslating") or inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") then return end
        if not inst:IsA("TextBox") and isFpsCounterText(inst.Text) then
            hookFakeFpsCounter(inst)
            return
        end
        if inst:IsA("TextBox") then
            applyElementTranslation(inst)
            return
        end
        if inst.Text ~= inst:GetAttribute("__LastTranslated") then
            inst:SetAttribute("OrigRawText", inst.Text)
            applyElementTranslation(inst)
        end
    end)
end

local function refreshAllTranslations()
    task.spawn(function()
        if GlobalRefreshIslandStatus then
            GlobalRefreshIslandStatus()
        end
        local count = 0
        for i = #TrackedTexts, 1, -1 do
            local el = TrackedTexts[i]
            if el and el.Parent then
                applyElementTranslation(el)
                count = count + 1
                if count % 50 == 0 then
                    task.wait()
                end
            else
                table.remove(TrackedTexts, i)
            end
        end
    end)
end

-- ==================== 4. BLACK-BACKGROUND DYNAMIC ISLAND (PRESERVED 100%) ====================
local function setupDynamicIslandFromStatus(statusLbl, venyxGui)
    local pill = statusLbl.Parent
    if not (pill and pill:IsA("GuiObject")) then return end

    local badHitbox = pill:FindFirstChild("IslandClickHitbox")
    if badHitbox then
        badHitbox:Destroy()
    end

    for _, child in ipairs(pill:GetChildren()) do
        if child:IsA("UIGradient") then
            child:Destroy()
        end
    end

    pill.BackgroundColor3 = ISLAND_BLACK_BG
    pill.BackgroundTransparency = 0
    pill.Size = UDim2.new(0, 0, 0, 28)
    pill.AutomaticSize = Enum.AutomaticSize.X

    if not pill:GetAttribute("__BlackBgLocked") then
        pill:SetAttribute("__BlackBgLocked", true)
        pill:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
            if pill.BackgroundColor3 ~= ISLAND_BLACK_BG then
                pill.BackgroundColor3 = ISLAND_BLACK_BG
            end
        end)
        pill:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
            if pill.BackgroundTransparency ~= 0 then
                pill.BackgroundTransparency = 0
            end
        end)
    end

    local expandHint = pill:FindFirstChild("IslandExpandHint")
    if not expandHint then
        expandHint = Instance.new("TextLabel")
        expandHint.Name = "IslandExpandHint"
        expandHint.Size = UDim2.new(0, 18, 0, 18)
        expandHint.BackgroundColor3 = Color3.fromRGB(28, 32, 48)
        expandHint.BorderSizePixel = 0
        expandHint.Text = "▼"
        expandHint.Font = Enum.Font.GothamBold
        expandHint.TextSize = 9
        expandHint.TextColor3 = Color3.fromRGB(165, 210, 255)
        expandHint.LayoutOrder = 99
        expandHint.ZIndex = 10000
        expandHint.Parent = pill

        local hintCorner = Instance.new("UICorner")
        hintCorner.CornerRadius = UDim.new(1, 0)
        hintCorner.Parent = expandHint

        local hintStroke = Instance.new("UIStroke")
        hintStroke.Thickness = 1
        hintStroke.Color = Color3.fromRGB(90, 130, 200)
        hintStroke.Parent = expandHint
    end

    local function updateStatusText(forceFromSavedOrig)
        if statusLbl:GetAttribute("__Updating") then return end
        statusLbl:SetAttribute("__Updating", true)

        local cleanEn
        if forceFromSavedOrig and statusLbl:GetAttribute("OrigStatusEn") then
            cleanEn = statusLbl:GetAttribute("OrigStatusEn")
        else
            local currentRaw = statusLbl.Text:gsub("●", ""):gsub("•", ""):gsub("✨%s*rainbow", ""):match("^%s*(.-)%s*$") or ""
            if currentRaw ~= "" and currentRaw ~= statusLbl:GetAttribute("__LastTranslatedStatus") then
                cleanEn = currentRaw
                statusLbl:SetAttribute("OrigStatusEn", cleanEn)
            else
                cleanEn = statusLbl:GetAttribute("OrigStatusEn") or currentRaw or "Idle"
            end
        end

        local translatedStatus = translateStatusAction(cleanEn)
        statusLbl:SetAttribute("__LastTranslatedStatus", translatedStatus)

        statusLbl.Text = translatedStatus
        statusLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLbl.TextTransparency = 0
        statusLbl.Size = UDim2.new(0, 0, 1, 0)
        statusLbl.AutomaticSize = Enum.AutomaticSize.X

        statusLbl:SetAttribute("__Updating", false)
    end

    GlobalRefreshIslandStatus = function()
        updateStatusText(true)
    end

    if statusLbl:GetAttribute("__IslandDone") and venyxGui:FindFirstChild("ChilliV5_ExpandedIsland") then
        updateStatusText(false)
        return
    end
    statusLbl:SetAttribute("__IslandDone", true)

    updateStatusText(false)

    local txtGrad = statusLbl:FindFirstChild("TextRainbow") or Instance.new("UIGradient")
    txtGrad.Name = "TextRainbow"
    txtGrad.Color = COLOR_SEQ_RAINBOW
    txtGrad.Parent = statusLbl
    table.insert(ActiveGradients, txtGrad)

    pill.Parent = venyxGui
    pill.AnchorPoint = Vector2.new(0.5, 0)
    pill.Position = UDim2.new(0.5, 0, 0, 10)
    pill.ZIndex = 9999
    pill.Active = true
    statusLbl.Active = true
    expandHint.Active = true

    local pillCorner = pill:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    pillCorner.CornerRadius = UDim.new(1, 0)
    pillCorner.Parent = pill

    local pillStroke = pill:FindFirstChild("IslandStroke") or Instance.new("UIStroke")
    pillStroke.Name = "IslandStroke"
    pillStroke.Thickness = 1.6
    pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    pillStroke.Color = Color3.fromRGB(255, 255, 255)
    pillStroke.Parent = pill

    local strokeGrad = pillStroke:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
    strokeGrad.Color = COLOR_SEQ_RAINBOW
    strokeGrad.Parent = pillStroke
    table.insert(ActiveGradients, strokeGrad)

    local oldExp = venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
    if oldExp then oldExp:Destroy() end

    local ExpandedIsland = Instance.new("Frame")
    ExpandedIsland.Name = "ChilliV5_ExpandedIsland"
    ExpandedIsland.AnchorPoint = Vector2.new(0.5, 0)
    ExpandedIsland.Position = pill.Position
    ExpandedIsland.Size = UDim2.new(0, 260, 0, 78)
    ExpandedIsland.BackgroundColor3 = ISLAND_BLACK_BG
    ExpandedIsland.BackgroundTransparency = 0
    ExpandedIsland.BorderSizePixel = 0
    ExpandedIsland.Visible = false
    ExpandedIsland.Active = true
    ExpandedIsland.ZIndex = 10000
    ExpandedIsland.Parent = venyxGui

    local ExpCorner = Instance.new("UICorner")
    ExpCorner.CornerRadius = UDim.new(0, 16)
    ExpCorner.Parent = ExpandedIsland

    local ExpStroke = Instance.new("UIStroke")
    ExpStroke.Thickness = 1.6
    ExpStroke.Color = Color3.fromRGB(255, 255, 255)
    ExpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ExpStroke.Parent = ExpandedIsland

    local ExpStrokeGrad = Instance.new("UIGradient")
    ExpStrokeGrad.Color = COLOR_SEQ_RAINBOW
    ExpStrokeGrad.Parent = ExpStroke
    table.insert(ActiveGradients, ExpStrokeGrad)

    local ExpTitle = Instance.new("TextLabel")
    ExpTitle.Size = UDim2.new(1, -44, 0, 28)
    ExpTitle.Position = UDim2.new(0, 14, 0, 4)
    ExpTitle.BackgroundTransparency = 1
    ExpTitle.Text = "🌶️ Chilli Hub V5"
    ExpTitle.Font = Enum.Font.GothamBold
    ExpTitle.TextSize = 11.5
    ExpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExpTitle.TextXAlignment = Enum.TextXAlignment.Left
    ExpTitle.ZIndex = 10001
    ExpTitle.Parent = ExpandedIsland

    local CollapseBtn = Instance.new("TextButton")
    CollapseBtn.Size = UDim2.new(0, 24, 0, 22)
    CollapseBtn.Position = UDim2.new(1, -32, 0, 7)
    CollapseBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 34)
    CollapseBtn.BorderSizePixel = 0
    CollapseBtn.Text = "▲"
    CollapseBtn.Font = Enum.Font.GothamBold
    CollapseBtn.TextSize = 10
    CollapseBtn.TextColor3 = Color3.fromRGB(160, 205, 255)
    CollapseBtn.ZIndex = 10002
    CollapseBtn.Parent = ExpandedIsland

    local CollapseCorner = Instance.new("UICorner")
    CollapseCorner.CornerRadius = UDim.new(1, 0)
    CollapseCorner.Parent = CollapseBtn

    local LangCapsule = Instance.new("Frame")
    LangCapsule.Size = UDim2.new(1, -20, 0, 34)
    LangCapsule.Position = UDim2.new(0, 10, 0, 36)
    LangCapsule.BackgroundColor3 = Color3.fromRGB(18, 20, 30)
    LangCapsule.BorderSizePixel = 0
    LangCapsule.ZIndex = 10001
    LangCapsule.Parent = ExpandedIsland

    local LangCorner = Instance.new("UICorner")
    LangCorner.CornerRadius = UDim.new(1, 0)
    LangCorner.Parent = LangCapsule

    local LangSlider = Instance.new("Frame")
    LangSlider.Size = UDim2.new(0.5, -4, 1, -4)
    LangSlider.Position = (currentLanguage == "VI") and UDim2.new(0, 2, 0, 2) or UDim2.new(0.5, 2, 0, 2)
    LangSlider.BackgroundColor3 = Color3.fromRGB(95, 110, 235)
    LangSlider.BorderSizePixel = 0
    LangSlider.ZIndex = 10002
    LangSlider.Parent = LangCapsule

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = LangSlider

    local BtnVI = Instance.new("TextButton")
    BtnVI.Size = UDim2.new(0.5, 0, 1, 0)
    BtnVI.Position = UDim2.new(0, 0, 0, 0)
    BtnVI.BackgroundTransparency = 1
    BtnVI.Text = "🇻🇳 VIETNAMESE"
    BtnVI.Font = Enum.Font.GothamBold
    BtnVI.TextSize = 10.5
    BtnVI.TextColor3 = (currentLanguage == "VI") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 165, 190)
    BtnVI.ZIndex = 10003
    BtnVI.Parent = LangCapsule

    local BtnEN = Instance.new("TextButton")
    BtnEN.Size = UDim2.new(0.5, 0, 1, 0)
    BtnEN.Position = UDim2.new(0.5, 0, 0, 0)
    BtnEN.BackgroundTransparency = 1
    BtnEN.Text = "🌐 ENGLISH"
    BtnEN.Font = Enum.Font.GothamBold
    BtnEN.TextSize = 10.5
    BtnEN.TextColor3 = (currentLanguage == "EN") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 165, 190)
    BtnEN.ZIndex = 10003
    BtnEN.Parent = LangCapsule

    local function setLanguage(lang)
        if currentLanguage == lang then return end
        currentLanguage = lang
        pcall(function()
            if writefile then writefile(LANG_SAVE_FILE, lang) end
        end)

        if lang == "VI" then
            TweenService:Create(LangSlider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 2, 0, 2)
            }):Play()
            BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnEN.TextColor3 = Color3.fromRGB(150, 165, 190)
        else
            TweenService:Create(LangSlider, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 2, 0, 2)
            }):Play()
            BtnEN.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnVI.TextColor3 = Color3.fromRGB(150, 165, 190)
        end

        refreshAllTranslations()
    end

    BtnVI.MouseButton1Click:Connect(function() setLanguage("VI") end)
    BtnEN.MouseButton1Click:Connect(function() setLanguage("EN") end)

    local function toggleIsland(expand)
        if expand then
            ExpandedIsland.Position = pill.Position
            pill.Visible = false
            ExpandedIsland.Size = UDim2.new(0, 150, 0, 28)
            ExpandedIsland.Visible = true
            TweenService:Create(ExpandedIsland, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 260, 0, 78)
            }):Play()
        else
            pill.Position = ExpandedIsland.Position
            ExpandedIsland.Visible = false
            pill.Visible = true
        end
    end

    CollapseBtn.MouseButton1Click:Connect(function()
        toggleIsland(false)
    end)

    local function attachDragAndClick(triggerObj, moveFrame, onTapCallback)
        if triggerObj:GetAttribute("__DragBound") then return end
        triggerObj:SetAttribute("__DragBound", true)

        local dragging, dragStart, startPos, moved = false, nil, nil, false

        triggerObj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                moved = false
                dragStart = input.Position
                startPos = moveFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        if dragging and not moved and onTapCallback then
                            onTapCallback()
                        end
                        dragging = false
                    end
                end)
            end
        end)

        triggerObj.InputChanged:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
                local delta = input.Position - dragStart
                if delta.Magnitude > 6 then
                    moved = true
                end
                local cam = workspace.CurrentCamera
                local maxX = cam and cam.ViewportSize.X - 140 or 800
                local maxY = cam and cam.ViewportSize.Y - 50 or 600
                local newX = math.clamp(startPos.X.Offset + delta.X, -maxX / 2, maxX / 2)
                local newY = math.clamp(startPos.Y.Offset + delta.Y, 4, maxY)
                local newPos = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
                pill.Position = newPos
                ExpandedIsland.Position = newPos
            end
        end)
    end

    local openCallback = function() toggleIsland(true) end
    attachDragAndClick(pill, pill, openCallback)
    attachDragAndClick(statusLbl, pill, openCallback)
    attachDragAndClick(expandHint, pill, openCallback)
    attachDragAndClick(ExpandedIsland, ExpandedIsland, nil)

    statusLbl:GetPropertyChangedSignal("Text"):Connect(function()
        if not statusLbl:GetAttribute("__Updating") and statusLbl.Text ~= statusLbl:GetAttribute("__LastTranslatedStatus") then
            updateStatusText(false)
        end
    end)
end

-- ==================== 5. 1:1 FLOATING CIRCULAR BUTTON & HEADER LOGO (PRESERVED) ====================
local function setupUnclippedCircularLogo(targetObj)
    local topPanel = targetObj
    while topPanel.Parent and topPanel.Parent:IsA("GuiObject") and not topPanel.Parent:IsA("ScreenGui") do
        topPanel = topPanel.Parent
    end

    if topPanel:GetAttribute("__FloatingLogoV5Perfect") then return end

    local sz = topPanel.AbsoluteSize
    local pos = topPanel.AbsolutePosition
    if sz.X > 105 or sz.Y > 105 or sz.X < 28 or math.abs(sz.X - sz.Y) > 25 or pos.X > 350 then
        return
    end

    topPanel:SetAttribute("__FloatingLogoV5Perfect", true)
    local container = topPanel

    for _, child in ipairs(container:GetDescendants()) do
        if child:IsA("UIPadding") or child:IsA("UIAspectRatioConstraint") or child:IsA("UISizeConstraint") then
            if child.Name ~= "PerfectCircleAspect" then
                pcall(function() child:Destroy() end)
            end
        end
        if (child:IsA("ImageLabel") or child:IsA("ImageButton")) and child.Name ~= "ChilliV5CoverLogo" then
            child.ImageTransparency = 1
            child.BackgroundTransparency = 1
        elseif child:IsA("TextLabel") or child:IsA("TextButton") then
            child:SetAttribute("__HiddenVxLogo", true)
            child.TextTransparency = 1
            child.BackgroundTransparency = 1
        end
    end

    if container:IsA("ImageLabel") or container:IsA("ImageButton") then
        container.ImageTransparency = 1
    elseif container:IsA("TextLabel") or container:IsA("TextButton") then
        container:SetAttribute("__HiddenVxLogo", true)
        container.TextTransparency = 1
    end

    container.Size = UDim2.new(0, 60, 0, 60)
    container.BackgroundColor3 = LOGO_BG_COLOR
    container.BackgroundTransparency = 0
    container.BorderSizePixel = 0
    container.ClipsDescendants = true

    local aspect = container:FindFirstChild("PerfectCircleAspect") or Instance.new("UIAspectRatioConstraint")
    aspect.Name = "PerfectCircleAspect"
    aspect.AspectRatio = 1
    aspect.Parent = container

    local cCorner = container:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = container

    if not container:GetAttribute("__SizeLocked") then
        container:SetAttribute("__SizeLocked", true)
        container:GetPropertyChangedSignal("Size"):Connect(function()
            if container.Size ~= UDim2.new(0, 60, 0, 60) then
                container.Size = UDim2.new(0, 60, 0, 60)
            end
        end)
    end

    local stroke = container:FindFirstChild("RainbowBorder") or Instance.new("UIStroke")
    stroke.Name = "RainbowBorder"
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Parent = container

    local strokeGrad = stroke:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
    strokeGrad.Color = COLOR_SEQ_RAINBOW
    strokeGrad.Parent = stroke
    table.insert(ActiveGradients, strokeGrad)

    local coverLogo = container:FindFirstChild("ChilliV5CoverLogo") or Instance.new("ImageLabel")
    coverLogo.Name = "ChilliV5CoverLogo"
    coverLogo.Size = UDim2.new(1, 0, 1, 0)
    coverLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
    coverLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    coverLogo.BackgroundTransparency = 1
    coverLogo.Image = CHILLI_LOGO_ID
    coverLogo.ImageTransparency = 0
    coverLogo.ScaleType = Enum.ScaleType.Fit
    coverLogo.Active = false
    coverLogo.ZIndex = container.ZIndex + 5
    coverLogo.Parent = container

    local logoCorner = coverLogo:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(1, 0)
    logoCorner.Parent = coverLogo
end

local function patchHeaderLogoLeftOfTitle(headerContainer, titleLbl)
    if not headerContainer or not titleLbl then return end
    local headerY = titleLbl.AbsolutePosition.Y
    local titleX = titleLbl.AbsolutePosition.X

    for _, item in ipairs(headerContainer:GetDescendants()) do
        if item ~= titleLbl and item:IsA("GuiObject") and item.Name ~= "ChilliHeaderLogo" then
            local pos = item.AbsolutePosition
            local sz = item.AbsoluteSize
            if math.abs(pos.Y - headerY) < 35 and pos.X < titleX and sz.X >= 10 and sz.X <= 45 then
                if item:IsA("ImageLabel") or item:IsA("ImageButton") then
                    item.Image = CHILLI_LOGO_ID
                    item.ImageTransparency = 0
                    item.BackgroundTransparency = 1
                    item.ScaleType = Enum.ScaleType.Fit
                elseif item:IsA("TextLabel") or item:IsA("TextButton") then
                    item:SetAttribute("__HiddenVxLogo", true)
                    item.TextTransparency = 1
                    local holder = item.Parent
                    if holder and not holder:FindFirstChild("ChilliHeaderLogo") then
                        local hLogo = Instance.new("ImageLabel")
                        hLogo.Name = "ChilliHeaderLogo"
                        hLogo.Size = UDim2.new(0, 24, 0, 24)
                        hLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
                        hLogo.AnchorPoint = Vector2.new(0.5, 0.5)
                        hLogo.BackgroundTransparency = 1
                        hLogo.Image = CHILLI_LOGO_ID
                        hLogo.ScaleType = Enum.ScaleType.Fit
                        hLogo.ZIndex = item.ZIndex + 2
                        hLogo.Parent = holder
                    end
                end
            end
        end
    end
end

-- ==================== 6. IMMORTAL SCANNER (ANTI-DELAY ON REJOIN & 100% FAKE FPS CAPTURE) ====================
local function patchVenyxScreenGui(gui, titleLbl)
    if titleLbl.Text ~= NEW_TITLE then
        titleLbl.Text = NEW_TITLE
        titleLbl.AutomaticSize = Enum.AutomaticSize.X
    end

    local mainWindow = nil
    local curr = titleLbl
    while curr.Parent and curr.Parent ~= gui do
        curr = curr.Parent
        if curr:IsA("GuiObject") and curr.AbsoluteSize.X >= 350 and curr.AbsoluteSize.Y >= 220 then
            mainWindow = curr
        end
    end

    local headerY = titleLbl.AbsolutePosition.Y

    if mainWindow then
        patchHeaderLogoLeftOfTitle(mainWindow, titleLbl)
    end

    for _, topChild in ipairs(gui:GetChildren()) do
        if topChild:IsA("GuiObject")
        and topChild ~= mainWindow
        and topChild.Name ~= "ChilliV5_ExpandedIsland"
        and not topChild:FindFirstChild("IslandExpandHint") then
            setupUnclippedCircularLogo(topChild)
        end
    end

    local allDescendants = gui:GetDescendants()
    local pendingTextQueue = {}

    for i = 1, #allDescendants do
        local desc = allDescendants[i]
        if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            local txt = desc.Text or ""
            local origTxt = desc:GetAttribute("OrigRawText") or ""
            local isAlreadyMovedIdle = desc:GetAttribute("__IslandDone")

            local isStatusKeyword = txt:lower():find("idle", 1, true)
                or origTxt:lower():find("idle", 1, true)
                or txt == "Idle"

            local isHeaderIdle = (not gui:GetAttribute("__IslandLocked"))
                and (not desc:FindFirstAncestorOfClass("ScrollingFrame"))
                and desc.Parent
                and (not titleLbl:IsDescendantOf(desc.Parent))
                and math.abs(desc.AbsolutePosition.Y - headerY) < 35
                and desc.AbsolutePosition.X > titleLbl.AbsolutePosition.X + 60
                and isStatusKeyword

            if isHeaderIdle or isAlreadyMovedIdle then
                gui:SetAttribute("__IslandLocked", true)
                setupDynamicIslandFromStatus(desc, gui)
            elseif isFpsCounterText(txt) then
                hookFakeFpsCounter(desc)
            elseif not desc:GetAttribute("__TransHooked") then
                pendingTextQueue[#pendingTextQueue + 1] = desc
            end

        elseif (desc:IsA("ImageLabel") or desc:IsA("ImageButton"))
        and desc.Name ~= "ChilliV5CoverLogo"
        and desc.Name ~= "ChilliHeaderLogo"
        and desc.Name ~= "InnerChilliLogo" then
            if not desc:FindFirstAncestorOfClass("ScrollingFrame") then
                if mainWindow and not desc:IsDescendantOf(mainWindow) then
                    setupUnclippedCircularLogo(desc)
                end
            end
        end
    end

    if #pendingTextQueue > 0 and not gui:GetAttribute("__BatchTranslating") then
        gui:SetAttribute("__BatchTranslating", true)
        task.spawn(function()
            for idx = 1, #pendingTextQueue do
                local item = pendingTextQueue[idx]
                if item and item.Parent then
                    hookTextForTranslation(item)
                end
                if idx % 45 == 0 then
                    task.wait()
                end
            end
            gui:SetAttribute("__BatchTranslating", false)
        end)
    end
end

local venyxMainPatched = false

local function attachScreenGuiListeners(gui)
    if not gui:IsA("ScreenGui") or IGNORED_GUI_NAMES[gui.Name] then return end
    if gui:GetAttribute("__GlobalTextListener") then return end
    gui:SetAttribute("__GlobalTextListener", true)

    gui.DescendantAdded:Connect(function(newDesc)
        if newDesc:IsA("TextLabel") or newDesc:IsA("TextButton") or newDesc:IsA("TextBox") then
            task.defer(function()
                if not newDesc:IsA("TextBox") and isFpsCounterText(newDesc.Text) then
                    hookFakeFpsCounter(newDesc)
                else
                    hookTextForTranslation(newDesc)
                end
            end)
        end
    end)
end

local function tryPatchVenyx()
    for _, root in ipairs(scanRoots) do
        if root then
            for _, gui in ipairs(root:GetChildren()) do
                if gui:IsA("ScreenGui") and not IGNORED_GUI_NAMES[gui.Name] then
                    attachScreenGuiListeners(gui)

                    local titleLbl = nil
                    local descendants = gui:GetDescendants()

                    for i = 1, #descendants do
                        local d = descendants[i]
                        if d:IsA("TextLabel") or d:IsA("TextButton") then
                            local t = d.Text
                            if isFpsCounterText(t) then
                                hookFakeFpsCounter(d)
                            elseif (t == "VENYX" or t == NEW_TITLE) and not d:FindFirstAncestorOfClass("ScrollingFrame") then
                                titleLbl = d
                            end
                        end
                    end

                    if titleLbl then
                        venyxMainPatched = true
                        patchVenyxScreenGui(gui, titleLbl)
                    end
                end
            end
        end
    end
end

-- Listen for any new ScreenGui created at any point (including slow-loading Rejoin)
for _, root in ipairs(scanRoots) do
    if root then
        root.ChildAdded:Connect(function(child)
            if child:IsA("ScreenGui") and not IGNORED_GUI_NAMES[child.Name] then
                attachScreenGuiListeners(child)
                task.wait(0.15)
                pcall(tryPatchVenyx)
            end
        end)
    end
end

-- Continuously scan until Venyx is caught (up to 60 s for slow-network Rejoin cases)
-- Once Venyx is captured, run a lightweight check every 1.5 s so fake FPS never drops
pcall(tryPatchVenyx)
task.spawn(function()
    local elapsed = 0
    while not venyxMainPatched and elapsed < 60 do
        task.wait(0.35)
        elapsed = elapsed + 0.35
        pcall(tryPatchVenyx)
    end
    while true do
        task.wait(1.5)
        pcall(tryPatchVenyx)
    end
end)
]===]

-- SAVE THE LATEST BUILD TO DISK IMMEDIATELY SO REJOIN ALWAYS RUNS THE LATEST VERSION
if writefile then
    pcall(function()
        local selfReplicatingWrapper = "local CHILLI_CORE_PAYLOAD = [===[" .. CHILLI_CORE_PAYLOAD .. "]===]\n" .. [[
if writefile then
    pcall(function()
        writefile("ChilliHubV5_AutoRun.lua", "local CHILLI_CORE_PAYLOAD = [===[" .. CHILLI_CORE_PAYLOAD .. "]===]\nloadstring(CHILLI_CORE_PAYLOAD)()")
    end)
end
loadstring(CHILLI_CORE_PAYLOAD)()
]]
        writefile(AUTO_RUN_FILE, selfReplicatingWrapper)
    end)
end

loadstring(CHILLI_CORE_PAYLOAD)()
