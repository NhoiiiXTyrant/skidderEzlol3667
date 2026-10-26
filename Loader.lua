-- Chilli Hub V7 Supreme | Clean Multi-Line Edition (100% Luau Compatible, Zero Semicolons)
local NEW_TITLE = "NhoiiiX Hub"
local LOGO_ID = "rbxassetid://75850663384500"
local HEADER_BAR_IMG_ID = "rbxassetid://83726521558450"
local STEAL_TAB_ICON_ID = "rbxassetid://91536384271341"
local WALLPAPER_IMAGE_ID = "rbxassetid://90615151648668"
local c3, u2, u2s, v2, csk = Color3.fromRGB, UDim2.new, UDim2.fromScale, Vector2.new, ColorSequenceKeypoint.new
local LOGO_BG, BLACK_BG = c3(12, 12, 18), c3(8, 8, 12)
local MY_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local VENYX_URL = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"
local AUTO_FILE, LANG_FILE = "ChilliHubV5_AutoRun.lua", "ChilliV5_Lang.txt"
local PRESET_JSON = [=[{"venyx":1,"name":"hihi 2","data":{"System / Interface/Quick bars/Show quick bars":true,"Farm / Sell/Favorite/Auto favorite":false,"System / Interface/Quick bars/Quick bar layout":"{\"pins\":{\"Event / Butterfly/Butterfly bloom/Auto butterfly bloom\":2,\"Player / Combat/Hit aura/Hit aura\":1,\"Player / Combat/Auto hit/Chase speed\":1,\"Steal / Auto Steal/Auto hop server/Auto hop\":1,\"Player / Move/Movement/Boost speed\":1,\"Player / Combat/Auto hit/Auto hit\":1,\"Steal / Auto Steal/Auto steal/Auto steal\":1,\"Event / Race/Racing Event/Auto race\":2,\"Farm / Treadmill/Treadmill/Auto treadmill\":1,\"Player / Move/Movement/Speed boost\":1},\"keys\":[],\"at\":{\"1\":[766.9053955078125,21.74544906616211],\"2\":[624.3492431640625,21.080074310302736]},\"fold\":{\"1\":true,\"2\":true}}","System / Optimizer/Graphics/Disable 3D Render":false,"Farm / Pen/Auto place/Place first":"Best value","Steal / Auto Steal/Filter/Only below /s":0,"Farm / Pen/Auto hatch/Equip best pets":false,"Event / AA/Capture the egg/Auto capture event egg":true,"Farm / Mutate/Mutate filter/Only these eggs":[],"Farm / Treadmill/Treadmill/Auto upgrade treadmill":false,"Steal / Auto Steal/Auto steal/Drop eggs at safe zone":false,"Steal / Auto Steal/Auto hop server/Auto hop":false,"System / Interface/Interface/Dim the game":0,"Player / Combat/Hit aura/Skip friends":true,"Player / ESP/Others/Pen egg ESP":true,"System / Optimizer/Frame rate/FPS position":"0.5000,-550,0.0000,49","Event / Butterfly/Butterfly bloom/Auto butterfly bloom":true,"Farm / Pen/Auto hatch/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Steal / Auto Steal/Filter/Min value /s":2000000000,"Player / Combat/Hit aura/Hit aura":true,"Event / Star/Shooting Star/Auto catch shooting star":true,"Steal / Egg Predictor/Egg showcase/Calculate mutations":[],"Steal / Egg Predictor/Egg showcase/Sort eggs":"Value","Event / Halloween/Ghost Dog and fishing/Auto fishing":true,"System / Optimizer/Bases/Hide other players' pets and eggs":true,"Player / Combat/Auto hit/Auto hit":false,"Event / Halloween/Ghost Dog and fishing/Auto Ghost Dog quest":false,"Event / Butterfly/Butterfly bloom/Catch mode":"Chase","Event / Butterfly/Butterfly machine/Trade":[],"Event / Halloween/Halloween Dimension/Halloween eggs":["Bone Emperor","Voidseer Pumpkin","Zombified Bone Emperor","Ghost Reaper","Gorillastein","Phantom Dragon","Shelltide Voyager","Zombified Grave Cerberus","Zombified Phantom Dragon","BloodBloom","Grave Cerberus","Graveyard Brute","Werewolf","Zombified Night Fang","Zombified Pumpkin Fiend","Zombified Tombstone Bear"],"Farm / Pen/Auto place/Auto place":false,"Steal / Auto Steal/Filter/Rarities":["Divine","Eternal","Secret"],"System / Webhook/What to post/Post fused eggs":false,"Event / Halloween/Halloween Dimension/Auto Pumpkin Moon":true,"Farm / Sell/Pets/Sell rarities":["Rare","Uncommon","Common"],"Player / Move/Protection/Ignore traps":true,"Farm / Fuse/Fuse filter/Rarities":["Mythic","Legendary","Epic","Rare","Uncommon","Common"],"System / Webhook/Discord webhook/Ping role ID":"","Player / ESP/Others/Hide sleeping guards":true,"Event / Halloween/Halloween Dimension/Min value /s":1000000000,"System / Optimizer/Frame rate/Show FPS and ping":true,"Farm / Treadmill/Progress/Auto claim index rewards":false,"System / Interface/Quick bars/Keybinds":true,"Steal / Auto Steal/Auto steal/Instant steps":2,"Farm / Fuse/Fuse filter/Never fuse":[],"Farm / Pen/Auto hatch/Mutations":[],"System / Optimizer/Bases/Hide my pets and eggs":true,"Event / Halloween/Monsters/Monster order":"Most tokens","Steal / Auto Steal/Filter/Zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Event / Butterfly/Butterfly machine/Auto craft essence":true,"Farm / Mutate/Auto mutate/Auto mutate":false,"Player / ESP/Others/Other pens ESP":true,"Player / ESP/Field eggs/Egg ESP":false,"Farm / Pen/Keep eggs/Min value /s":0,"Steal / Auto Steal/Auto steal/Delivery method":"Instant steps","Farm / Treadmill/Progress/Auto buy trails":false,"Farm / Sell/Eggs/Sell rarities":["Rare","Uncommon","Common"],"System / Interface/Interface/Tone":100,"Event / AA/Admin abuse/Admin treadmill":false,"System / Webhook/What to post/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Farm / Pen/Auto place/Place when":"Always","Event / Halloween/Monsters/Monsters":["Candy Corn","Hollow Bat","Scarecrow","Chest Mimic","Pumpkin Golem","Soul Phantom"],"Event / Butterfly/Wisp companion/Auto banjo cricket":false,"Event / Halloween/Halloween Dimension/Auto buy Halloween Dimension Egg":false,"Event / Halloween/Halloween Dimension/Walk speed":1000,"Steal / Auto Steal/Auto steal/Delivery speed":4500,"Farm / Mutate/Auto mutate/Use items":["Fractured","Scrambled","Enchanted","Nitro","Spectral"],"Farm / Fuse/Fuse machine/Fuse first":"Lowest rarity","Steal / Auto Steal/Auto hop server/Rare from":"Cosmic","Player / Move/Movement/Boost speed":720,"System / Interface/Interface/Opacity":50,"Player / ESP/Others/Guard ESP":true,"Farm / Sell/Favorite/Always favorite":[],"Event / Halloween/Halloween Dimension/Steal speed":100,"Farm / Sell/Eggs/Auto sell eggs":false,"System / Webhook/What to post/Post stolen eggs":false,"Player / ESP/Others/ESP size":60,"Steal / Auto Steal/Filter/Steal first":"Best value","Farm / Sell/Pets/Only below /s":0,"Player / Move/Protection/Anti ragdoll":true,"Player / ESP/Field eggs/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic"],"Player / Move/Protection/Invisible":false,"Steal / Auto Steal/Auto hop server/Hop when":"After stealing a match","Event / AA/Cursed Island Wars/Auto play Cursed Island Wars":true,"Event / Butterfly/Butterfly bloom/Catch":["Radiant","Amethyst","Sapphire","Emerald"],"Farm / Treadmill/Treadmill/Auto treadmill":false,"System / Interface/Game HUD/Steal panel button on game HUD":true,"System / Server/Server/Hop to":"Least players","Farm / Mutate/Mutate filter/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / Move/Protection/Instant prompts":true,"System / Server/Join and stay/Rejoin on kick":true,"Farm / Sell/Favorite/Favorite equipped":false,"Event / Halloween/Phantom Express/Auto Phantom Express":true,"System / Optimizer/Frame rate/FPS cap":360,"Steal / Auto Steal/Auto steal/Steal missing index eggs":false,"Steal / Auto Steal/Filter/Only these eggs":["ArchAngel","Kitsune","Nightflame","Royal Skywhale","Unicorn","World Burner","Celestial Sunlion","Gorilla King","Pegasus","Skeleton Horse","Strawberry Elephant","67","Amethyst Runebear","Starry Fox"],"Farm / Sell/Favorite/Min value /s":0,"System / Server/Join and stay/Auto load script":false,"Farm / Mutate/Mutate filter/Skip eggs with":[],"System / Optimizer/Graphics/Low graphics":true,"Event / Halloween/Monsters/Walk speed":1000,"Event / AA/Minigame eggs/Auto steal minigame egg":true,"Farm / Pen/Auto place/Only these eggs":[],"Player / Combat/Auto hit/Hit who":"Nearest player","Farm / Sell/Eggs/Never sell":[],"Farm / Pen/Keep eggs/Eggs to keep":[],"Farm / Fuse/Fuse filter/Only below /s":0,"Event / Halloween/Monsters/Use weapons":["Enchanted Hammer","Racing Bat","Cricket's Banjo","Flyswatter"],"Farm / Fuse/Fuse machine/Skip mutated":true,"Farm / Sell/Pets/Never sell":[],"Farm / Sell/Favorite/Match":"All picked rules","Event / Halloween/Ghost Dog and fishing/Cast luck":"x1.5 Perfect","System / Optimizer/Graphics/Background color":"Black","Player / Move/Movement/God mode":true,"Farm / Pen/Auto place/Mutations":[],"Steal / Auto Steal/Auto steal/Anti guard":true,"Farm / Sell/Favorite/Unfavorite pets not matching":false,"System / Webhook/What to post/Min value /s":0,"Farm / Pen/Auto hatch/Auto hatch":false,"Farm / Sell/Pets/Only mutations":[],"Farm / Fuse/Fuse machine/Eject odd pets":true,"Event / Butterfly/Butterfly machine/Auto trade up":false,"Event / AA/Admin abuse/Instant steal":false,"System / Webhook/What to post/Post when bag is full":false,"Farm / Fuse/Fuse machine/Auto fuse":false,"Farm / Pen/Auto hatch/Only these eggs":[],"Event / Butterfly/Butterfly machine/Smart trade for essence":true,"Event / Halloween/Halloween Dimension/Auto steal Halloween eggs":true,"System / Interface/Quick bars/Bar size":85,"Player / Combat/Weapons/Use weapons":[],"Player / ESP/Others/Player ESP":true,"System / Webhook/Discord webhook/Ping everyone":false,"Farm / Fuse/Fuse machine/Use pets":"Lowest value first","Event / Halloween/Monsters/Auto farm monsters":true,"Farm / Mutate/Auto mutate/Mutate first":"Best value","Player / ESP/Field eggs/Min value /s":0,"Event / AA/Cursed Island Wars/Island Wars target":"Enemies and base","Player / Move/Movement/Infinite jump":true,"Farm / Pen/Auto place/Rarities":["Divine","Eternal","Secret","Cosmic","Mythic","Legendary","Epic","Rare","Uncommon","Common"],"Player / ESP/Field eggs/Mutations":[],"Event / Halloween/Phantom Express/Auto vacuum Ghouler boss":true,"Farm / Treadmill/Progress/Auto upgrade base":false,"Steal / Auto Steal/Auto steal/Auto steal":true,"Player / Combat/Auto hit/Chase speed":1000,"Player / ESP/Field eggs/Fixed size":false,"Event / Halloween/Halloween Dimension/Instant steal Halloween eggs":true,"Event / Halloween/Phantom Express/Walk speed":1000,"Event / Halloween/Phantom Express/Ghost target":"Rarest first","Farm / Sell/Eggs/Only below /s":0,"Farm / Sell/Favorite/Rarities":[],"Steal / Auto Steal/Auto hop server/First hop after":5,"Steal / Auto Steal/Auto steal/Tween speed":110,"Farm / Sell/Pets/Auto sell pets":false,"Event / Halloween/Phantom Express/Auto trade souls":true,"Farm / Sell/Pets/Keep mutated":true,"Steal / Auto Steal/Filter/Sell cheapest egg when bag is full":false,"Player / ESP/Field eggs/Show":[],"Steal / Auto Steal/Auto steal/Go to egg":"Teleport to egg","Player / Combat/Weapons/Hold each":0.2,"Event / AA/Capture the egg/Hold height":120,"Steal / Auto Steal/Filter/Mutations":[],"Event / AA/Capture the egg/Keep away":150,"Farm / Mutate/Mutate filter/Min value /s":0,"Steal / Auto Steal/Auto steal/Teleport zones":["Enchanted Forest","Light Dark","Titan Temple","Cherry Blossom"],"Farm / Pen/Auto hatch/Min value /s":0,"Player / Move/Movement/Speed boost":false,"System / Interface/Interface/UI scale":90,"Farm / Fuse/Fuse filter/Only these pets":[],"Steal / Egg Predictor/Egg showcase/Preview card":false,"Event / Butterfly/Butterfly bloom/Catch speed":600,"Player / Move/Protection/Anti AFK":true,"Event / Halloween/Halloween Dimension/Halloween rarities":[],"System / Interface/Interface/Show / hide UI":{"k":"LeftControl"},"Steal / Auto Steal/Auto steal/Steal from other players":true,"Farm / Pen/Auto place/Min value /s":0,"Event / Butterfly/Butterfly bloom/Catch priority":"Rarest","System / Webhook/Discord webhook/Ping user ID":"","Farm / Sell/Eggs/Only mutations":[],"Farm / Treadmill/Progress/Auto claim offline cash":false,"Farm / Sell/Favorite/Mutations":[],"Event / AA/Capture the egg/Take it from the holder":true,"System / Webhook/Discord webhook/Webhook URL":"","Farm / Priority/Task order/Task order":["Steal filter eggs","Shooting Star","Phantom Express","Pumpkin Moon","Butterfly","Steal wisp eggs","Wisp","Steal missing index","Place","Mutate","Butterfly machine","Ghost Dog quest","Halloween monsters","Halloween fishing","Treadmill"],"Farm / Sell/Eggs/Keep mutated":true,"Event / Butterfly/Wisp companion/Auto wisp quest":false,"System / Optimizer/Graphics/Hide game UI":false}}]=]
if writefile then
pcall(writefile, AUTO_FILE, ('pcall(function() loadstring(game:HttpGet("%s"))() end)'):format(MY_URL))
end
task.spawn(function()
pcall(function()
if setfpscap then pcall(setfpscap, 120) end
local lgt = game:GetService("Lighting")
lgt.GlobalShadows = false
lgt.FogEnd = 9e9
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)
pcall(function()
local cp = game:GetService("ContentProvider")
local pre = {}
for _, id in ipairs({ LOGO_ID, HEADER_BAR_IMG_ID, STEAL_TAB_ICON_ID, WALLPAPER_IMAGE_ID }) do
local im = Instance.new("ImageLabel")
im.Image = id
table.insert(pre, im)
end
cp:PreloadAsync(pre)
for _, im in ipairs(pre) do im:Destroy() end
end)
end)
local function safeHttpGet(url)
local ok1, res1 = pcall(function() return game:HttpGet(url) end)
if ok1 and type(res1) == "string" and #res1 > 10 then return res1 end
local ok2, res2 = pcall(function() return game:HttpGet(url, true) end)
if ok2 and type(res2) == "string" and #res2 > 10 then return res2 end
local req = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request)
if req then
local rOk, rRes = pcall(req, { Url = url, Method = "GET" })
if rOk and rRes and type(rRes.Body) == "string" and #rRes.Body > 10 then return rRes.Body end
end
return nil
end
local env = (getgenv and getgenv()) or _G
env.__ChilliV5State = env.__ChilliV5State or {
SessionId = 0, Language = "VI", ActiveGradients = {},
TrackedTexts = {}, TrackedFpsLabels = {}, NoticeShown = false, StartClock = os.clock()
}
local State = env.__ChilliV5State
State.SessionId = (State.SessionId or 0) + 1
State.CloseHideUntil = nil
State.StartClock = State.StartClock or os.clock()
local SID = State.SessionId
local function isAlive() return State.SessionId == SID end
pcall(function()
if isfile and isfile(LANG_FILE) then
local s = (readfile(LANG_FILE) or ""):match("^%s*(.-)%s*$")
if s == "EN" or s == "VI" then State.Language = s end
end
end)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local function getScanRoots()
local r, seen = {}, {}
local function addRoot(inst)
if inst and not seen[inst] then
seen[inst] = true
table.insert(r, inst)
end
end
if gethui then
pcall(function() addRoot(gethui()) end)
end
addRoot(CoreGui)
local pg = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
addRoot(pg)
return r
end
local IGNORED_GUIS = {
RobloxGui=true, TopBarApp=true, TouchGui=true, Chat=true, BubbleChat=true,
Freecam=true, BackpackGui=true, PlayerList=true, PurchasePrompt=true, ChilliV5_NoticeGui=true
}
local function isVenyxUiPresent()
for _, root in ipairs(getScanRoots()) do
for _, d in ipairs(root:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Name ~= "ChilliUltraTitleBadge" and d.Name ~= "ChilliIslandTitle" and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local sg = d:FindFirstAncestorOfClass("ScreenGui")
if sg and not IGNORED_GUIS[sg.Name] and sg.Enabled ~= false then
local t = d.Text
if (t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub Ultra" or t == "Chilli Hub V5" or t == "Chilli V5 |") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
local top = d
while top.Parent and top.Parent ~= sg do top = top.Parent end
if top and (top:GetAttribute("__SizeLockedV5Pro") or top:FindFirstChild("ChilliCircleDisc")) then
pcall(function() sg:Destroy() end)
else
return true
end
end
end
end
end
end
return false
end
local function setupSafeTeleportHook()
local rq = env.__ChilliOrigQueue or env.queue_on_teleport or env.queueonteleport or queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or (delta and delta.queue_on_teleport)
if not rq then return end
env.__ChilliOrigQueue = rq
local clearQ = env.clearteleportqueue or env.clear_teleport_queue or clearteleportqueue or clear_teleport_queue or (syn and syn.clear_teleport_queue) or (fluxus and fluxus.clear_teleport_queue) or (delta and delta.clear_teleport_queue)
local boot = ('--[[CHILLI_V7_AUTHORIZED_TELEPORT]] task.spawn(function() if not game:IsLoaded() then game.Loaded:Wait() end local P=game:GetService("Players") while not P.LocalPlayer do task.wait(0.1) end task.wait(0.4) pcall(function() loadstring(game:HttpGet("%s"))() end) end)'):format(MY_URL)
local safeLock = function(c)
pcall(function()
if tostring(c or ""):find("CHILLI_V7_AUTHORIZED_TELEPORT", 1, true) then
rq(c)
else
if clearQ then pcall(clearQ) end
if env.__ChilliBootQueuedSession ~= SID then
env.__ChilliBootQueuedSession = SID
rq(boot)
end
end
end)
end
pcall(function()
if clearQ then pcall(clearQ) end
env.queue_on_teleport = safeLock
env.queueonteleport = safeLock
_G.queue_on_teleport = safeLock
_G.queueonteleport = safeLock
if env.__ChilliBootQueuedSession ~= SID then
env.__ChilliBootQueuedSession = SID
pcall(rq, boot)
end
if not env.__ChilliOnTpHooked and LocalPlayer then
env.__ChilliOnTpHooked = true
LocalPlayer.OnTeleport:Connect(function()
pcall(function()
if clearQ then pcall(clearQ) end
pcall(rq, boot)
end)
end)
end
end)
end
local function launchVenyxBase()
if isVenyxUiPresent() then return end
if env.__VenyxLaunchingNow and (os.clock() - (env.__VenyxLaunchClock or 0) < 6) then return end
env.__VenyxLaunchingNow = true
env.__VenyxLaunchClock = os.clock()
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local rawCode = safeHttpGet(VENYX_URL)
if rawCode then
local fn = loadstring(rawCode)
if type(fn) == "function" then pcall(fn) end
end
env.__VenyxLaunchingNow = false
pcall(setupSafeTeleportHook)
end)
end
launchVenyxBase()
local function mk(cls, props, parent)
local inst = Instance.new(cls)
for k, v in pairs(props) do inst[k] = v end
if parent then inst.Parent = parent end
return inst
end
local function addGrad(g)
if g and not g:GetAttribute("__GradTracked") then
g:SetAttribute("__GradTracked", true)
table.insert(State.ActiveGradients, g)
end
return g
end
local RAINBOW = ColorSequence.new({
csk(0.00, c3(255, 45, 85)), csk(0.17, c3(255, 155, 35)), csk(0.33, c3(255, 235, 45)),
csk(0.50, c3(45, 255, 145)), csk(0.67, c3(45, 195, 255)), csk(0.83, c3(185, 85, 255)), csk(1.00, c3(255, 45, 85))
})
local ULTRA_TEXT_GRAD = ColorSequence.new({
csk(0.00, c3(255, 255, 255)), csk(0.20, c3(125, 225, 255)), csk(0.45, c3(255, 95, 215)),
csk(0.72, c3(175, 115, 255)), csk(1.00, c3(255, 215, 85))
})
local ULTRA_CARD_GRAD = ColorSequence.new({
csk(0.00, c3(70, 210, 255)), csk(0.50, c3(170, 95, 255)), csk(1.00, c3(255, 75, 195))
})
local LIQUID_TEXT_GRAD = ColorSequence.new({
csk(0.00, c3(250, 253, 255)), csk(0.35, c3(185, 232, 255)),
csk(0.70, c3(225, 215, 255)), csk(1.00, c3(250, 253, 255))
})
local LIQUID_GLASS_COLOR = ColorSequence.new({
csk(0.00, c3(145, 190, 235)), csk(0.20, c3(22, 30, 48)),
csk(0.78, c3(12, 16, 28)), csk(1.00, c3(48, 82, 132))
})
local LIQUID_GLASS_TRANS = NumberSequence.new({
NumberSequenceKeypoint.new(0.00, 0.18),
NumberSequenceKeypoint.new(0.22, 0.28),
NumberSequenceKeypoint.new(0.78, 0.26),
NumberSequenceKeypoint.new(1.00, 0.20)
})
local fakeFps, lastFpsT = math.random(96, 138), 0
local function getFakeFps()
local now = os.clock()
if now - lastFpsT > 1.1 then
lastFpsT = now
fakeFps = math.clamp(fakeFps + math.random(-9, 11), 80, 150)
end
return fakeFps
end
local function getLivePing()
local ping = 48
pcall(function()
ping = math.clamp(math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()), 12, 999)
end)
return ping
end
local function isFpsTxt(t) return type(t) == "string" and t:find("FPS", 1, true) ~= nil and t:find("ms", 1, true) ~= nil and #t < 42 end
local function hookFps(lbl)
if not lbl or lbl.Name == "ChilliFakeFpsOverlay" or lbl:GetAttribute("__FpsHookSession") == SID then return end
lbl:SetAttribute("__FpsHookSession", SID)
pcall(function()
local p = lbl.Parent
if p and p:IsA("GuiObject") then
p.Visible = true
lbl.TextTransparency = 1
local ov = p:FindFirstChild("ChilliFakeFpsOverlay")
if not ov then
ov = mk("TextLabel", {
Name = "ChilliFakeFpsOverlay",
Size = u2s(1, 1),
Position = u2s(0, 0),
BackgroundTransparency = 1,
Font = lbl.Font,
TextSize = lbl.TextSize,
TextColor3 = lbl.TextColor3,
TextXAlignment = lbl.TextXAlignment,
TextYAlignment = lbl.TextYAlignment,
ZIndex = lbl.ZIndex + 2,
Active = false,
Text = string.format("%d FPS  -  %d ms", getFakeFps(), getLivePing())
}, p)
end
table.insert(State.TrackedFpsLabels, ov)
end
end)
end
task.spawn(function()
local rot, tickCount = 0, 0
while isAlive() do
rot = (rot + 8) % 360
tickCount = tickCount + 1
local winVis = (State.ActiveMainWin == nil) or (State.ActiveMainWin.Parent ~= nil and State.ActiveMainWin.Visible)
local g = State.ActiveGradients
for i = #g, 1, -1 do
local item = g[i]
if item and item.Parent then
if winVis or not (State.ActiveMainWin and item:IsDescendantOf(State.ActiveMainWin)) then
item.Rotation = rot
end
else
table.remove(g, i)
end
end
if tickCount % 12 == 0 then
local f = getFakeFps()
local pMs = getLivePing()
local fl = State.TrackedFpsLabels
for i = #fl, 1, -1 do
local l = fl[i]
if l and l.Parent then
l.Text = string.format("%d FPS  -  %d ms", f, pMs)
else
table.remove(fl, i)
end
end
if winVis and State.TelemetryUpdateFn then pcall(State.TelemetryUpdateFn, f) end
end
if tickCount % 5 == 0 then
if State.SyncWindowFn then pcall(State.SyncWindowFn) end
if State.ActiveStatusLbl and State.ActiveStatusLbl.Parent then
if State.ActiveStatusLbl.TextColor3 ~= Color3.new(1, 1, 1) then
State.ActiveStatusLbl.TextColor3 = Color3.new(1, 1, 1)
end
if State.ActiveStatusLbl.TextTransparency ~= 0 then
State.ActiveStatusLbl.TextTransparency = 0
end
end
end
task.wait(0.10)
end
end)
local FastCache = {}
local function hasVi(s)
return type(s) == "string" and s ~= "" and s:find("[\194-\244][\128-\191]") ~= nil and not s:find("^[%w%s%p·•●🌶️🇻🇳🌐⚡⏳✅⚠️🚀✨▲▼▾👑🏠🥚🌾👤⚙️]+$")
end
local EXACT_VI = {
["Going into the Halloween Dimension"]="Đang vào Không gian Halloween", ["Going into Halloween Dimension"]="Đang vào Không gian Halloween",
["Leaving Halloween Dimension"]="Đang rời Không gian Halloween", ["Entering Halloween Dimension"]="Đang vào Không gian Halloween",
["v1.2.9: New optimizer modes: Balanced, Strong (way much higher FPS, ultra-low GPU), no lag spike when you turn it on"]="v1.2.9: Chế độ tối ưu mới: Cân bằng, Mạnh (tăng FPS cực cao, siêu nhẹ GPU), không bị khựng lag khi bật",
["v1.2.8: Inventory values, see how much every pet and every egg in your backpack is worth"]="v1.2.8: Giá trị túi đồ, xem giá trị của từng pet và từng quả trứng trong ba lô",
["v1.2.7: Auto race The Hollow"]="v1.2.7: Tự động đua sự kiện The Hollow",
["v1.2.7: Auto race Hollow"]="v1.2.7: Tự động đua sự kiện Hollow", ["Auto race Hollow"]="Tự động đua sự kiện Hollow",
["Balanced"]="Cân bằng", ["Strong"]="Mạnh",
["v1.2.6: Mutate eggs you choose with multiple mutations, much shorter delay between tasks and instant take back when someone grabs your egg"]="v1.2.6: Đột biến trứng tự chọn với nhiều đột biến, giảm độ trễ giữa các tác vụ và giật lại tức thì khi bị cướp",
["v1.2.5: Teleport to egg"]="v1.2.5: Dịch chuyển tới trứng",
["Riding the Phantom Express"]="Đang đi Tàu Bóng Ma", ["Fighting Small monster"]="Đang đánh quái vật nhỏ", ["Fighting Medium monster"]="Đang đánh quái vật vừa", ["Fighting Large monster"]="Đang đánh quái vật lớn",
["UI scale"]="Kích cỡ Menu", ["Show / hide UI"]="Phím ẩn / hiện Menu", ["Opacity"]="Độ trong suốt", ["Tone"]="Tông màu", ["Dim the game"]="Làm tối nền game",
["QUICK BARS"]="THANH PHÍM TẮT NHANH", ["Quick bars"]="Thanh phím tắt nhanh", ["Show quick bars"]="Hiện thanh phím tắt nhanh", ["Keybinds"]="Phím tắt", ["Bar size"]="Kích cỡ thanh nhanh",
["PINS AND KEYBINDS"]="GHIM & PHÍM TẮT", ["Find option"]="Tìm tùy chọn", ["All"]="Tất cả", ["Pinned"]="Đã ghim", ["Clear all quick bars"]="Xóa hết thanh nhanh", ["Clear all keybinds"]="Xóa hết phím tắt",
["DEFAULTS"]="MẶC ĐỊNH", ["Reset to defaults"]="Khôi phục mặc định", ["Reset"]="Đặt lại", ["Turn off all toggles"]="Tắt toàn bộ công tắc", ["Turn off"]="Tắt hết",
["Steal An Egg"]="Cướp Trứng", ["CANDY CORN"]="KẸO NGÔ", ["Candy Corn"]="Kẹo Ngô", ["Calculate mutations"]="Tính thử đột biến",
["Cards show the value with these mutations added"]="Thẻ trứng sẽ hiển thị giá trị sau khi cộng thêm các đột biến này",
["Delivery speed"]="Tốc độ mang trứng về", ["Change if steal fails"]="Hãy chỉnh giảm xuống nếu cướp trứng bị lỗi",
["Auto farm monsters"]="Tự động cày quái vật", ["Auto kill monsters"]="Tự động đánh quái vật", ["Bat"]="Gậy Dơi (Bat)",
["Instant steal"]="Cướp tức thì", ["Admin treadmill"]="Máy tập Admin", ["CURSED ISLAND WARS"]="ĐẠI CHIẾN ĐẢO NGUYỀN RỦA",
["Cursed Island Wars"]="Đại Chiến Đảo Nguyền Rủa", ["Waiting for Cursed Island Wars"]="Đang chờ Đại Chiến Đảo Nguyền Rủa",
["Auto play Cursed Island Wars"]="Tự động chơi Đại Chiến Đảo Nguyền Rủa", ["Island Wars target"]="Mục tiêu Đảo Nguyền Rủa",
["Enemies and base"]="Kẻ địch và Căn cứ", ["Walls and crystal"]="Tường chắn và Pha lê", ["Catching a pumpkin"]="Đang nhặt bí ngô",
["Carrying a pumpkin to the altar"]="Đang mang bí ngô tới bệ thờ", ["Delivering a pumpkin to the altar"]="Đang giao bí ngô tới bệ thờ",
["FIX"]="SỬA LỖI", ["Most tokens"]="Nhiều kẹo/xu nhất",
["Admin abuse works like Chilli: admin treadmill, Capture the egg, minigame eggs and Instant steal"]="Lạm dụng Admin hoạt động chuẩn: Máy tập Admin, Cướp trứng sự kiện, trứng Minigame và Cướp tức thì",
["Fixed lag back with the Tween delivery method"]="Đã sửa lỗi giật lùi (lag back) khi mang trứng về bằng chế độ Bay (Tween)",
["Welcome to Venyx 1.0.4! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V7! Tham gia Discord để cập nhật và nhận hỗ trợ",
["v1.1.0: Halloween tasks follow Task order, Walk speed for monsters, pumpkins and ghosts, Use weapons picks every weapon, Lab and Race shop removed"]="v1.1.0: Nhiệm vụ Halloween tuân theo Thứ tự tác vụ, thêm Tốc độ chạy khi săn quái, bí ngô và ma, Sử dụng vũ khí tự chọn mọi loại vũ khí, đã gỡ bỏ Phòng Lab và Shop Đua Xe",
["Halloween: Dimension eggs, monsters, Ghost Dog quest, fishing, Phantom Express and Cursed Island Wars"]="Sự kiện Halloween: Trứng Không gian Halloween, đánh quái, nhiệm vụ Chó Ma, câu cá, Tàu Ma Phantom Express và Đại Chiến Đảo Nguyền Rủa",
["Idle"]="Đang rảnh", ["Waiting"]="Đang chờ", ["Nothing"]="Không có gì", ["None"]="Không có", ["Off"]="Tắt", ["OFF"]="TẮT", ["On"]="Bật", ["ON"]="BẬT",
["No egg matches your targets"]="Không có trứng nào khớp mục tiêu", ["No eggs match your targets"]="Không có trứng nào khớp mục tiêu",
["No egg matches filter"]="Không có trứng khớp bộ lọc", ["No eggs match filter"]="Không có trứng khớp bộ lọc",
["No target egg found"]="Không tìm thấy trứng mục tiêu", ["No matching eggs"]="Không có trứng nào khớp", ["No valid targets"]="Không có mục tiêu hợp lệ",
["Bag is full"]="Túi đã đầy", ["Egg bag is full"]="Túi trứng đã đầy", ["Pet bag is full"]="Túi pet đã đầy", ["Pen is full"]="Chuồng ấp đã đầy",
["Field is closed"]="Sân trứng đang đóng", ["Waiting for field to open"]="Đang chờ sân trứng mở", ["Waiting for eggs to spawn"]="Đang chờ trứng xuất hiện",
["Waiting in safe zone"]="Đợi ở vùng an toàn", ["Returning to safe zone"]="Đang về vùng an toàn", ["Returning home"]="Đang quay về nhà",
["Delivering egg"]="Đang giao trứng về chuồng", ["Dropping egg"]="Đang thả trứng", ["Selling eggs"]="Đang bán trứng", ["Selling pets"]="Đang bán pet",
["Hatching eggs"]="Đang ấp trứng", ["Placing eggs"]="Đang đặt trứng", ["Mutating eggs"]="Đang đột biến trứng", ["Fusing pets"]="Đang dung hợp pet",
["Hopping server"]="Đang đổi máy chủ", ["Rejoining"]="Đang vào lại phòng", ["Avoiding guard"]="Đang né vệ sĩ",
["Using treadmill"]="Đang chạy máy tập", ["Upgrading treadmill"]="Đang nâng cấp máy tập", ["Upgrading base"]="Đang nâng cấp căn cứ",
["Claiming rewards"]="Đang nhận thưởng", ["Claiming offline cash"]="Đang nhận tiền ngoại tuyến", ["Joining race"]="Đang vào đường đua", ["Racing"]="Đang đua xe",
["Home"]="Bảng Điều Khiển", ["Dashboard"]="Bảng Điều Khiển", ["Welcome back"]="Chào mừng trở lại", ["Venyx Discord"]="Chilli Hub Discord",
["Updates, keys, support"]="Cập nhật, nhận key, hỗ trợ", ["Copy Invite"]="Chép Link Mời", ["Copy invite"]="Chép Link Mời", ["Copy link"]="Chép Link Mời", ["Discord"]="Chilli Hub", ["MONEY /S"]="TIỀN /GIÂY", ["CASH / S"]="TIỀN / GIÂY",
["OPEN"]="MỞ", ["Open"]="Mở", ["Close"]="Đóng", ["Welcome to Venyx 1.0.0! Join our Discord for updates and support"]="Chào mừng tới Chilli Hub V7! Tham gia Discord để cập nhật và nhận hỗ trợ",
["Beta version"]="Phiên bản Beta", ["This is a test build. Features may change and bugs can happen."]="Đây là bản thử nghiệm. Tính năng có thể thay đổi và phát sinh lỗi.",
["Rejoin"]="Vào lại", ["Server hop"]="Đổi server", ["Copy Job ID"]="Chép Job ID", ["Unload hub"]="Tắt Hub", ["Unload"]="Tắt Hub", ["Save config"]="Lưu cấu hình", ["Hide UI"]="Ẩn Menu",
["SESSION"]="PHIÊN CHƠI", ["STOLEN"]="ĐÃ CƯỚP", ["LAST EGG"]="TRỨNG CUỐI", ["PLACED"]="ĐÃ ĐẶT", ["HATCHED"]="ĐÃ ẤP", ["NIGHT IN"]="ĐÊM SAU", ["NEXT NIGHT"]="ĐÊM SAU",
["SESSION TIME"]="THỜI GIAN", ["TIME"]="THỜI GIAN", ["BEST STEAL"]="CƯỚP TỐT NHẤT", ["EGG BAG"]="TÚI TRỨNG", ["PET BAG"]="TÚI PET", ["WHAT'S NEW"]="CÓ GÌ MỚI", ["NEW"]="MỚI",
["Event"]="Sự Kiện", ["Search"]="Tìm kiếm", ["Filter"]="Lọc tìm", ["Steal"]="Cướp Trứng", ["Auto Steal"]="Tự Động Cướp", ["AUTO STEAL"]="TỰ ĐỘNG CƯỚP",
["Auto steal"]="Tự động cướp", ["Egg Predictor"]="Dự Đoán Trứng", ["Go to egg"]="Di chuyển tới trứng", ["Teleport to egg"]="Dịch chuyển tới trứng",
["Walk to egg"]="Đi bộ tới trứng", ["Tween to egg"]="Bay mượt tới trứng",
["Teleport zones"]="Khu vực dịch chuyển", ["Tween"]="Bay (Tween)", ["Walk"]="Đi bộ", ["Delivery method"]="Cách mang về", ["Instant steps"]="Tức thì từng bước", ["Instant"]="Tức thì", ["Teleport"]="Dịch chuyển",
["Fast tween speed"]="Tốc độ bay nhanh", ["Tween speed"]="Tốc độ bay", ["Steal missing index eggs"]="Cướp trứng thiếu trong Chỉ mục", ["Steal back from players"]="Cướp lại từ người chơi",
["Steal from other players"]="Cướp từ người chơi khác", ["Anti guard"]="Chống vệ sĩ", ["Drop eggs at safe zone"]="Thả trứng ở vùng an toàn", ["FILTER"]="BỘ LỌC",
["Zones"]="Khu vực", ["Steal first"]="Ưu tiên cướp", ["Best value"]="Giá trị cao nhất", ["Lowest value"]="Giá trị thấp nhất", ["Best rarity"]="Độ hiếm cao nhất",
["Best mutation"]="Đột biến tốt nhất", ["Biggest"]="Kích thước to nhất", ["Closest"]="Khoảng cách gần nhất", ["Nearest"]="Gần nhất", ["Mutations"]="Đột biến", ["Rarities"]="Độ hiếm",
["Only these eggs"]="Chỉ những trứng này", ["Min value /s"]="Giá trị tối thiểu /s", ["Max value /s"]="Giá trị tối đa /s",
["Sell cheapest egg when bag is full"]="Bán trứng rẻ nhất khi đầy túi", ["Keep lab eggs"]="Giữ lại trứng Lab", ["AUTO HOP SERVER"]="TỰ ĐỔI MÁY CHỦ",
["Auto hop server"]="Tự đổi máy chủ", ["Auto hop"]="Tự động đổi server", ["Hop now"]="Đổi server ngay", ["First hop after"]="Đổi lần đầu sau", ["Hop when"]="Đổi khi",
["After stealing a match"]="Sau khi cướp đủ trứng lọc", ["No matching egg"]="Không có trứng phù hợp", ["Rare from"]="Độ hiếm từ",
["Hop delay"]="Độ trễ đổi server", ["Only sell eggs below /s"]="Chỉ bán trứng dưới mức /s",
["EGG SHOWCASE"]="TRƯNG BÀY TRỨNG", ["Sort eggs"]="Sắp xếp trứng", ["Preview card"]="Thẻ xem trước", ["Pick one"]="Chọn một mục", ["Pick any"]="Chọn bất kỳ",
["Value"]="Giá trị", ["Rarity"]="Độ hiếm", ["Time left"]="Thời gian còn lại", ["Default"]="Mặc định", ["Clear"]="Xóa chọn", ["Select all"]="Chọn tất cả",
["SIZE"]="KÍCH CỠ", ["WEIGHT"]="CÂN NẶNG", ["READY"]="SẴN SÀNG", ["IN BAG"]="TRONG TÚI", ["GROWING"]="ĐANG LỚN", ["Hatch now"]="Ấp ngay", ["Hold egg"]="Cầm trứng",
["Fly to egg"]="Bay tới trứng", ["Steal egg"]="Cướp trứng", ["Enchanted Forest"]="Rừng Phù Phép", ["Light Dark"]="Sáng Tối", ["Titan Temple"]="Đền Titan",
["Cherry Blossom"]="Hoa Anh Đào", ["Prehistoric"]="Tiền Sử", ["Abyss Ocean"]="Đáy Đại Dương", ["Volcano"]="Núi Lửa", ["Snow"]="Tuyết", ["Jungle"]="Rừng Rậm",
["Desert"]="Sa Mạc", ["Lake"]="Hồ Nước", ["Forest"]="Khu Rừng", ["Silver"]="Bạc", ["Rainbow"]="Cầu Vồng", ["Golden"]="Vàng", ["Fractured"]="Rạn Nứt",
["Scrambled"]="Hỗn Loạn", ["Enchanted"]="Phù Phép", ["Nitro"]="Nitro", ["SCRAMBLED"]="HỖN LOẠN", ["NITRO"]="NITRO", ["FRACTURED"]="RẠN NỨT", ["ENCHANTED"]="PHÙ PHÉP",
["Farm"]="Cày Cuốc", ["Pen"]="Chuồng Ấp", ["PEN"]="CHUỒNG ẤP", ["Treadmill"]="Máy Tập", ["TREADMILL"]="MÁY TẬP CHẠY", ["Mutate"]="Đột Biến",
["Sell"]="Bán", ["SELL"]="BÁN TỰ ĐỘNG", ["Fuse"]="Dung Hợp", ["FUSE"]="DUNG HỢP", ["Priority"]="Ưu Tiên", ["PRIORITY"]="THỨ TỰ ƯU TIÊN",
["AUTO PLACE"]="TỰ ĐỘNG ĐẶT TRỨNG", ["Auto place"]="Tự động đặt trứng", ["Place when"]="Đặt khi", ["Always"]="Luôn luôn", ["Place first"]="Ưu tiên đặt",
["KEEP EGGS"]="GIỮ LẠI TRỨNG", ["Eggs to keep"]="Trứng cần giữ",
["AUTO HATCH"]="TỰ ĐỘNG ẤP TRỨNG", ["Auto hatch"]="Tự động ấp trứng", ["Equip best pets"]="Trang bị pet mạnh nhất", ["READY NOW"]="SẴN SÀNG ẤP",
["Auto treadmill"]="Tự chạy máy tập", ["Auto upgrade treadmill"]="Tự nâng cấp máy tập", ["PROGRESS"]="TIẾN TRÌNH", ["Auto upgrade base"]="Tự nâng cấp căn cứ",
["Auto buy trails"]="Tự mua vệt sáng", ["Auto claim offline cash"]="Tự nhận tiền ngoại tuyến", ["Auto claim index rewards"]="Tự nhận thưởng Chỉ mục",
["AUTO MUTATE"]="TỰ ĐỘNG ĐỘT BIẾN", ["Auto mutate"]="Tự động đột biến", ["MUTATE FILTER"]="BỘ LỌC ĐỘT BIẾN", ["Use items"]="Dùng vật phẩm",
["Mutate first"]="Ưu tiên đột biến", ["Skip eggs with"]="Bỏ qua trứng đã có", ["Auto buy Nitro"]="Tự mua Nitro", ["PETS"]="THÚ CƯNG (PETS)", ["EGGS"]="TRỨNG (EGGS)", ["Auto sell pets"]="Tự động bán pet",
["Auto sell eggs"]="Tự động bán trứng", ["Sell all eggs now"]="Bán hết trứng ngay", ["Sell all pets now"]="Bán hết Pet ngay",
["Sell rarities"]="Độ hiếm bán", ["Never sell"]="Không bao giờ bán", ["Only mutations"]="Chỉ bán đột biến",
["Only below /s"]="Chỉ dưới mức /s", ["Keep mutated"]="Giữ lại đồ đột biến", ["LAB EGGS"]="TRỨNG PHÒNG LAB", ["FAVORITE"]="YÊU THÍCH (KHÓA)",
["Auto favorite"]="Tự động khóa bảo vệ", ["Favorite matching now"]="Khóa đồ khớp lọc ngay", ["Unfavorite pets not matching"]="Bỏ thích Pet không khớp", ["Always favorite"]="Luôn khóa Yêu thích",
["Auto sell lab eggs"]="Tự động bán trứng Lab", ["Match"]="Điều kiện khớp", ["All picked rules"]="Khớp tất cả quy tắc",
["Any picked rule"]="Khớp bất kỳ quy tắc", ["Favorite equipped"]="Khóa pet đang trang bị", ["FUSE MACHINE"]="MÁY DUNG HỢP",
["No 3 matching pets"]="Chưa đủ 3 pet cùng loại", ["Auto fuse"]="Tự động dung hợp", ["Fuse first"]="Ưu tiên dung hợp", ["Lowest rarity"]="Độ hiếm thấp nhất",
["Highest rarity"]="Độ hiếm cao nhất", ["Use pets"]="Sử dụng pet", ["Lowest value first"]="Giá trị thấp nhất trước", ["Highest value first"]="Giá trị cao nhất trước",
["Skip mutated"]="Bỏ qua pet đột biến", ["Eject odd pets"]="Đẩy pet lẻ ra ngoài", ["FUSE FILTER"]="BỘ LỌC DUNG HỢP", ["Only these pets"]="Chỉ những pet này",
["Never fuse"]="Không bao giờ dung hợp", ["FUSE PREDICTOR"]="DỰ ĐOÁN DUNG HỢP", ["SLOTS"]="Ô CHỨA", ["STATUS"]="TRẠNG THÁI", ["LIKELY SIZE"]="KÍCH CỠ DỰ KIẾN",
["CHANCE"]="TỶ LỆ", ["VALUE"]="GIÁ TRỊ", ["BEST CASE"]="TỐT NHẤT CÓ THỂ", ["TASK ORDER"]="THỨ TỰ TÁC VỤ", ["Task order"]="Thứ tự tác vụ", ["Reset order"]="Đặt lại thứ tự", ["DOING"]="ĐANG LÀM", ["WAITING"]="ĐANG CHỜ",
["Steal filter eggs"]="Cướp trứng theo bộ lọc", ["Shooting Star"]="Bắt Sao Băng", ["Racing Event"]="Sự Kiện Đua Xe", ["Butterfly"]="Bắt Bướm",
["Steal wisp eggs"]="Cướp trứng Wisp", ["Wisp"]="Nhặt Wisp", ["Steal missing index"]="Cướp trứng thiếu trong Chỉ mục", ["Steal lab eggs"]="Cướp trứng phòng Lab",
["Place"]="Đặt trứng vào chuồng", ["Butterfly machine"]="Máy đổi Bướm", ["Race"]="Đua Xe", ["RACE"]="ĐUA XE", ["Star"]="Sao Băng", ["STAR"]="SAO BĂNG",
["BUTTERFLY"]="BẮT BƯỚM", ["Lab"]="Phòng Lab", ["LAB"]="PHÒNG LAB", ["AA"]="Admin (AA)", ["Halloween"]="Halloween", ["HALLOWEEN"]="HALLOWEEN",
["HALLOWEEN DIMENSION"]="KHÔNG GIAN HALLOWEEN", ["Auto steal Halloween eggs"]="Tự động cướp trứng Halloween", ["Instant steal Halloween eggs"]="Cướp tức thì trứng Halloween",
["Steal speed"]="Tốc độ cướp", ["Halloween eggs"]="Trứng Halloween", ["Halloween rarities"]="Độ hiếm Halloween", ["Auto Pumpkin Moon"]="Tự làm sự kiện Trăng Bí Ngô",
["Auto buy Halloween Dimension Egg"]="Tự mua trứng Không gian Halloween", ["Walk speed"]="Tốc độ chạy bộ", ["GHOST DOG AND FISHING"]="CHÓ MA VÀ CÂU CÁ",
["QUEST"]="NHIỆM VỤ", ["Done"]="Đã xong", ["FISH CAUGHT"]="CÁ ĐÃ CÂU", ["Auto Ghost Dog quest"]="Tự làm nhiệm vụ Chó Ma", ["Auto fishing"]="Tự động câu cá",
["Cast luck"]="Tỷ lệ câu may mắn", ["Perfect"]="Hoàn hảo (Perfect)", ["MONSTERS"]="QUÁI VẬT", ["Monsters"]="Tên quái vật", ["Monster order"]="Thứ tự đánh quái",
["Rarest first"]="Hiếm nhất trước", ["PHANTOM EXPRESS"]="TÀU MA PHANTOM EXPRESS", ["TRAIN"]="CHUYẾN TÀU", ["Not here"]="Chưa đến", ["SOULS"]="LINH HỒN",
["Auto Phantom Express"]="Tự động cướp Tàu Ma", ["Auto vacuum Ghouler boss"]="Tự hút linh hồn Boss Ghouler", ["Ghost target"]="Mục tiêu ma",
["Auto trade souls"]="Tự động đổi linh hồn", ["RACING EVENT"]="SỰ KIỆN ĐUA XE", ["NEXT RACE"]="ĐUA TIẾP THEO", ["WINS"]="THẮNG", ["TROPHIES"]="CÚP",
["Auto race"]="Tự động đua xe", ["Race speed"]="Tốc độ đua", ["Use power-ups"]="Tự dùng vật phẩm tăng tốc", ["REWARDS"]="PHẦN THƯỞNG",
["Auto claim rewards"]="Tự nhận phần thưởng", ["Auto equip racer"]="Tự trang bị xe đua", ["Racer"]="Xe đua", ["Best owned"]="Tốt nhất đang có",
["Auto buy shop"]="Tự mua vật phẩm Shop", ["Shop items"]="Vật phẩm Shop", ["SHOOTING STAR"]="SAO BĂNG RƠI", ["LANDS IN"]="RƠI SAU", ["CATCH"]="BẮT SAO BĂNG",
["CAUGHT"]="ĐÃ BẮT", ["EXPIRES IN"]="BIẾN MẤT SAU", ["SLIPPED"]="TUỘT MẤT", ["TRIES"]="SỐ LẦN THỬ", ["DISTANCE"]="KHOẢNG CÁCH",
["Auto catch shooting star"]="Tự động bắt sao băng", ["BUTTERFLY BLOOM"]="MÙA BƯỚM NỞ", ["Auto butterfly bloom"]="Tự động bắt bướm", ["EMERALD"]="LỤC BẢO",
["SAPPHIRE"]="LAM NGỌC", ["AMETHYST"]="THẠCH ANH TÍM", ["RADIANT"]="RỰC RỠ", ["ESSENCE"]="TINH CHẤT", ["Catch mode"]="Chế độ bắt", ["Stand"]="Đứng yên",
["Chase"]="Đuổi theo", ["BUTTERFLY MACHINE"]="MÁY ĐỔI BƯỚM", ["Auto trade up"]="Tự nâng cấp bậc bướm", ["Trade"]="Giao dịch đổi",
["Smart trade for essence"]="Đổi bướm lấy tinh chất thông minh", ["Auto craft essence"]="Tự chế tạo tinh chất", ["WISP COMPANION"]="ĐỒNG HÀNH WISP",
["Catch priority"]="Ưu tiên bắt", ["Rarest"]="Hiếm nhất", ["Catch"]="Loại bướm bắt", ["Catch speed"]="Tốc độ bắt", ["Auto wisp quest"]="Tự làm nhiệm vụ Wisp",
["Auto banjo cricket"]="Tự bắt dế Banjo", ["STAGE"]="GIAI ĐOẠN", ["LAB ODDS"]="TỶ LỆ PHÒNG LAB", ["BANNER"]="BĂNG RÔN", ["ENDS IN"]="KẾT THÚC SAU",
["BANNER CHANCE"]="TỶ LỆ BĂNG RÔN", ["NEXT"]="TIẾP THEO", ["Experimental Pets"]="Pet Thí Nghiệm", ["Biohazard Pets"]="Pet Sinh Học",
["Lab banners"]="Băng rôn phòng Lab", ["Auto trade in"]="Tự động đổi trứng Lab", ["Auto reroll recipe"]="Tự đổi lại công thức",
["Place lab reward eggs"]="Đặt trứng thưởng từ Lab", ["ADMIN ABUSE"]="LẠM DỤNG ADMIN (ABUSE)", ["No admin boost right now"]="Hiện không có buff Admin nào",
["Instant steal (Admin Treadmill)"]="Cướp tức thì (Máy tập Admin)", ["Use admin treadmill"]="Tự dùng máy tập Admin", ["CAPTURE THE EGG"]="CƯỚP TRỨNG SỰ KIỆN",
["Auto capture event egg"]="Tự bắt trứng sự kiện", ["Take it from the holder"]="Giật trứng từ người đang cầm", ["Hold height"]="Độ cao giữ trứng",
["Keep away"]="Khoảng cách né tránh", ["MINIGAME EGGS"]="TRỨNG MINIGAME", ["Auto steal minigame egg"]="Tự cướp trứng Minigame", ["Player"]="Người Chơi",
["ESP"]="Định Vị (ESP)", ["Move"]="Di Chuyển", ["MOVE"]="DI CHUYỂN", ["Combat"]="Chiến Đấu", ["COMBAT"]="CHIẾN ĐẤU", ["FIELD EGGS"]="TRỨNG NGOÀI SÂN",
["Egg ESP"]="ESP Trứng", ["Show"]="Hiển thị", ["Name"]="Tên", ["Fixed size"]="Cố định kích cỡ", ["OTHERS"]="MỤC KHÁC", ["Pen egg ESP"]="ESP trứng trong chuồng",
["Other pens ESP"]="ESP chuồng người khác", ["Guard ESP"]="ESP Vệ sĩ", ["Hide sleeping guards"]="Ẩn vệ sĩ đang ngủ", ["Player ESP"]="ESP Người chơi", ["ESP size"]="Kích cỡ ESP",
["MOVEMENT"]="TỐC ĐỘ & DI CHUYỂN", ["Speed boost"]="Tăng tốc chạy", ["Boost speed"]="Tốc độ tăng thêm", ["Infinite jump"]="Nhảy vô hạn",
["God mode"]="Bất tử (God mode)", ["PROTECTION"]="BẢO VỆ NHÂN VẬT", ["Anti ragdoll"]="Chống ngã (Anti Ragdoll)", ["Ignore traps"]="Bỏ qua bẫy",
["Instant prompts"]="Tương tác nhấn giữ tức thì", ["Anti AFK"]="Chống treo máy (Anti AFK)", ["Invisible"]="Tàng hình", ["AUTO HIT"]="TỰ ĐỘNG ĐÁNH",
["Auto hit"]="Tự động đánh", ["Hit who"]="Mục tiêu đánh", ["Nearest player"]="Người chơi gần nhất", ["Chosen player"]="Người chơi chỉ định", ["Egg carrier"]="Người đang ôm trứng",
["Chase speed"]="Tốc độ đuổi theo", ["HIT AURA"]="VÒNG ĐÁNH TỰ ĐỘNG", ["Hit aura"]="Vòng đánh tự động (Hit Aura)", ["Skip friends"]="Bỏ qua bạn bè",
["WEAPONS"]="VŨ KHÍ", ["Use weapons"]="Sử dụng vũ khí", ["Hold each"]="Thời gian cầm mỗi món", ["System"]="Hệ Thống", ["Server"]="Máy Chủ", ["SERVER"]="MÁY CHỦ",
["Webhook"]="Webhook", ["WEBHOOK"]="WEBHOOK", ["Optimizer"]="Tối Ưu Hóa", ["OPTIMIZER"]="TỐI ƯU HÓA", ["Interface"]="Giao Diện", ["INTERFACE"]="GIAO DIỆN",
["GAME HUD"]="TRÊN MÀN HÌNH GAME", ["Steal panel button on game HUD"]="Hiện nút Bảng Cướp trên màn hình",
["Config"]="Cấu Hình", ["CONFIG"]="CẤU HÌNH", ["CONFIGS"]="QUẢN LÝ CẤU HÌNH", ["Configs"]="Danh sách cấu hình", ["ACTIVE"]="ĐANG DÙNG", ["SAVED CONFIGS"]="ĐÃ LƯU",
["Set as active config"]="Đặt làm cấu hình chính", ["Set active"]="Kích hoạt", ["Save changes"]="Lưu thay đổi", ["Save"]="Lưu", ["Overwrite"]="Lưu đè",
["PROFILES"]="HỒ SƠ CẤU HÌNH", ["New config name"]="Tên cấu hình mới", ["Config name"]="Tên cấu hình", ["Auto if empty"]="Tự đặt nếu trống",
["Create config"]="Tạo cấu hình mới", ["Create"]="Tạo mới", ["Pick to delete"]="Chọn mục cần xóa",
["Delete picked"]="Xóa mục đã chọn", ["Delete"]="Xóa", ["Restore deleted"]="Khôi phục mục đã xóa", ["Export config"]="Xuất mã cấu hình", ["Export to clipboard"]="Chép mã cấu hình",
["Import text"]="Dán mã cấu hình", ["Paste config text"]="Dán mã JSON vào đây", ["Paste config JSON here"]="Dán mã JSON vào đây",
["Import config"]="Nhập cấu hình", ["Import"]="Nhập",
["Config imported"]="Đã nhập cấu hình", ["Config loaded"]="Đã nạp cấu hình", ["Later"]="Để sau", ["Apply now"]="Áp dụng ngay", ["Hop to"]="Chuyển tới server",
["Least players"]="Ít người chơi nhất", ["Most players"]="Đông người chơi nhất", ["Random"]="Ngẫu nhiên", ["Hop server"]="Đổi máy chủ", ["Hop"]="Đổi ngay",
["Rejoin this server"]="Vào lại máy chủ này", ["Copy"]="Sao chép", ["JOIN AND STAY"]="VÀO PHÒNG & DUY TRÌ", ["Job ID"]="Mã phòng (Job ID)",
["Paste a Job ID"]="Dán mã Job ID vào đây", ["Join that server"]="Vào máy chủ đó", ["Join"]="Vào ngay", ["Rejoin on kick"]="Tự vào lại khi bị văng/kick",
["Auto load script"]="Tự chạy lại script khi chuyển server", ["DISCORD WEBHOOK"]="WEBHOOK DISCORD", ["Webhook URL"]="Đường dẫn Webhook",
["Ping role ID"]="ID Vai trò (Role ID)", ["Ping user ID"]="ID Người dùng (User ID)",
["Ping everyone"]="Tag @everyone", ["WHAT TO POST"]="NỘI DUNG GỬI BÁO CÁO", ["Post stolen eggs"]="Báo cáo trứng cướp được",
["Post fused eggs"]="Báo cáo trứng dung hợp", ["POSTED"]="ĐÃ GỬI", ["Send a test post"]="Gửi tin nhắn thử nghiệm", ["Test"]="Thử nghiệm",
["Post when bag is full"]="Gửi thông báo khi đầy túi", ["GRAPHICS"]="ĐỒ HỌA", ["Low graphics"]="Đồ họa thấp (Tăng FPS)",
["Disable 3D Render"]="Tắt kết xuất 3D (Treo máy)", ["Background color"]="Màu nền màn hình", ["Black"]="Màu Đen", ["White"]="Màu Trắng",
["Hide game UI"]="Ẩn giao diện gốc của Game", ["FRAME RATE"]="TỐC ĐỘ KHUNG HÌNH (FPS)", ["FPS cap"]="Giới hạn FPS", ["FPS position"]="Vị trí thanh FPS",
["Show FPS and ping"]="Hiện chỉ số FPS và Ping", ["BASES"]="CĂN CỨ (BASES)", ["Hide other players' pets and eggs"]="Ẩn pet và trứng của người chơi khác",
["Hide my pets and eggs"]="Ẩn pet và trứng của bản thân", ["Theme"]="Chủ đề màu", ["Toggle key"]="Phím đóng/mở Menu", ["Quick bar"]="Thanh phím tắt nhanh",
["QUICK BAR"]="THANH PHÍM TẮT NHANH", ["Auto save"]="Tự động lưu cấu hình", ["Auto load"]="Tự động nạp cấu hình", ["Auto load on join"]="Tự động nạp khi vào game",
["Load config"]="Nạp cấu hình", ["Load"]="Nạp cấu hình",
["Reset config"]="Đặt lại mặc định", ["Delete config"]="Xóa cấu hình", ["Common"]="Phổ Thông", ["Uncommon"]="Thường", ["Rare"]="Hiếm", ["Epic"]="Sử Thi",
["Legendary"]="Huyền Thoại", ["Mythic"]="Thần Thoại", ["Cosmic"]="Vũ Trụ", ["Secret"]="Bí Ẩn", ["Divine"]="Thánh Thần", ["Eternal"]="Vĩnh Cửu",
["COMMON"]="PHỔ THÔNG", ["UNCOMMON"]="THƯỜNG", ["RARE"]="HIẾM", ["EPIC"]="SỬ THI", ["LEGENDARY"]="HUYỀN THOẠI", ["MYTHIC"]="THẦN THOẠI",
["COSMIC"]="VŨ TRỤ", ["SECRET"]="BÍ ẨN", ["DIVINE"]="THÁNH THẦN", ["ETERNAL"]="VĨNH CỬU",
["Radiant"]="Rực Rỡ", ["Amethyst"]="Thạch Anh Tím", ["Sapphire"]="Lam Ngọc", ["Emerald"]="Ngọc Lục Bảo"
}
local LOWER_VI = {}
for k, v in pairs(EXACT_VI) do
local lk = k:lower()
if not LOWER_VI[lk] or k:upper() ~= k then
LOWER_VI[lk] = v
end
end
local GRAMMAR_VI = {
{ pat="^[Gg]oing%s+into%s+(.+)$", rep="Đang vào %1" },
{ pat="^[Ll]eaving%s+(.+)$", rep="Đang rời %1" },
{ pat="^[Ee]ntering%s+(.+)$", rep="Đang vào %1" },
{ pat="^[Vv]acuuming%s+ghosts%s*(.*)$", rep="Đang hút bóng ma %1" },
{ pat="^[Rr]iding%s+(.+)$", rep="Đang đi %1" },
{ pat="^[Ff]ighting%s+[Ss]mall%s+monster$", rep="Đang đánh quái vật nhỏ" },
{ pat="^[Ff]ighting%s+[Mm]edium%s+monster$", rep="Đang đánh quái vật vừa" },
{ pat="^[Ff]ighting%s+[Ll]arge%s+monster$", rep="Đang đánh quái vật lớn" },
{ pat="^[Aa]uto play (.+)$", rep="Tự động chơi %1" }, { pat="^[Aa]uto farm (.+)$", rep="Tự động cày %1" },
{ pat="^[Aa]uto kill (.+)$", rep="Tự động tiêu diệt %1" }, { pat="^[Aa]uto catch (.+)$", rep="Tự động bắt %1" },
{ pat="^[Aa]uto collect (.+)$", rep="Tự động thu thập %1" }, { pat="^[Aa]uto buy (.+)$", rep="Tự động mua %1" },
{ pat="^[Aa]uto sell (.+)$", rep="Tự động bán %1" }, { pat="^[Aa]uto claim (.+)$", rep="Tự động nhận %1" },
{ pat="^[Aa]uto upgrade (.+)$", rep="Tự động nâng cấp %1" }, { pat="^[Aa]uto craft (.+)$", rep="Tự động chế tạo %1" },
{ pat="^[Aa]uto trade (.+)$", rep="Tự động trao đổi %1" }, { pat="^[Aa]uto equip (.+)$", rep="Tự động trang bị %1" },
{ pat="^[Aa]uto steal (.+)$", rep="Tự động cướp %1" }, { pat="^[Ii]nstant steal (.+)$", rep="Cướp tức thì %1" },
{ pat="^[Aa]uto (.+) quest$", rep="Tự làm nhiệm vụ %1" }, { pat="^[Aa]uto (.+)$", rep="Tự động %1" },
{ pat="^[Cc]alculate (.+)$", rep="Tính thử %1" }, { pat="^[Cc]hange if (.+) fails$", rep="Chỉnh lại nếu %1 bị lỗi" },
{ pat="^(.+) speed$", rep="Tốc độ %1" }, { pat="^(.+) target$", rep="Mục tiêu %1" },
{ pat="^(.+) order$", rep="Thứ tự %1" }, { pat="^(.+) priority$", rep="Ưu tiên %1" },
{ pat="^(.+) mode$", rep="Chế độ %1" }, { pat="^(.+) filter$", rep="Bộ lọc %1" },
{ pat="^[Hh]alloween: carrying (.+) to safety$", rep="Halloween: đang mang %1 đến nơi an toàn" },
{ pat="^[Hh]alloween: (.+)$", rep="Halloween: %1" },
{ pat="^[Nn]o eggs? match%w* your (.+)$", rep="Không có trứng nào khớp %1" },
{ pat="^[Nn]o eggs? match%w* (.+)$", rep="Không có trứng nào khớp %1" },
{ pat="^[Nn]o pets? match%w* (.+)$", rep="Không có pet nào khớp %1" },
{ pat="^[Nn]o (.+) found(.*)$", rep="Không tìm thấy %1%2" },
{ pat="^[Cc]arrying (.+) to safe zone(.*)$", rep="Đang mang %1 về vùng an toàn%2" },
{ pat="^[Cc]arrying (.+) to base(.*)$", rep="Đang mang %1 về căn cứ%2" },
{ pat="^[Cc]arrying (.+) to pen(.*)$", rep="Đang mang %1 về chuồng%2" },
{ pat="^[Cc]arrying (.+) to (.+)$", rep="Đang mang %1 tới %2" },
{ pat="^[Cc]arrying (.+) home(.*)$", rep="Đang mang %1 về nhà%2" },
{ pat="^[Cc]arrying (.+)$", rep="Đang mang %1" },
{ pat="^[Dd]elivering (.+) to (.+)$", rep="Đang giao %1 tới %2" },
{ pat="^[Dd]elivering (.+) home(.*)$", rep="Đang giao %1 về nhà%2" },
{ pat="^[Dd]elivering (.+)$", rep="Đang giao %1" },
{ pat="^[Bb]ringing (.+) to (.+)$", rep="Đang đem %1 tới %2" },
{ pat="^[Tt]aking (.+) from (.+)$", rep="Đang giật %1 từ %2" },
{ pat="^[Ss]tealing (.+) from (.+)$", rep="Đang cướp %1 từ %2" },
{ pat="^[Ss]tealing (.+)$", rep="Đang cướp %1" },
{ pat="^[Gg]rabbing (.+)$", rep="Đang nhặt %1" }, { pat="^[Pp]icking up (.+)$", rep="Đang nhặt %1" },
{ pat="^[Cc]ollecting (.+)$", rep="Đang thu thập %1" }, { pat="^[Dd]ropping (.+) at (.+)$", rep="Đang thả %1 tại %2" },
{ pat="^[Tt]weening to (.+)$", rep="Đang bay tới %1" }, { pat="^[Tt]eleporting to (.+)$", rep="Đang dịch chuyển tới %1" },
{ pat="^[Gg]oing to (.+)$", rep="Đang đi tới %1" }, { pat="^[Mm]oving to (.+)$", rep="Đang di chuyển tới %1" },
{ pat="^[Ww]alking to (.+)$", rep="Đang chạy tới %1" }, { pat="^[Rr]unning to (.+)$", rep="Đang chạy tới %1" },
{ pat="^[Ff]lying to (.+)$", rep="Đang bay tới %1" }, { pat="^[Rr]eturning to (.+)$", rep="Đang quay về %1" },
{ pat="^[Pp]lacing (.+)$", rep="Đang đặt %1" }, { pat="^[Hh]atching (.+)$", rep="Đang ấp %1" },
{ pat="^[Mm]utating (.+)$", rep="Đang đột biến %1" }, { pat="^[Ss]elling (.+)$", rep="Đang bán %1" },
{ pat="^[Ff]using (.+)$", rep="Đang dung hợp %1" }, { pat="^[Uu]pgrading (.+)$", rep="Đang nâng cấp %1" },
{ pat="^[Bb]uying (.+)$", rep="Đang mua %1" }, { pat="^[Cc]laiming (.+)$", rep="Đang nhận %1" },
{ pat="^[Ee]quipping (.+)$", rep="Đang trang bị %1" }, { pat="^[Cc]atching (.+)$", rep="Đang bắt %1" },
{ pat="^[Cc]hasing (.+)$", rep="Đang đuổi theo %1" }, { pat="^[Aa]ttacking (.+)$", rep="Đang tấn công %1" },
{ pat="^[Hh]itting (.+)$", rep="Đang đánh %1" }, { pat="^[Kk]illing (.+)$", rep="Đang tiêu diệt %1" },
{ pat="^[Tt]rading in (.+)$", rep="Đang đổi %1" }, { pat="^[Cc]rafting (.+)$", rep="Đang chế tạo %1" },
{ pat="^[Aa]voiding (.+)$", rep="Đang né %1" }, { pat="^[Ww]aiting for (.+)$", rep="Đang chờ %1" },
{ pat="^[Ww]aiting in (.+)$", rep="Đang đợi ở %1" }, { pat="^[Ww]aiting %((.+)%)$", rep="Đang chờ (%1)" },
{ pat="^[Ss]earching for (.+)$", rep="Đang tìm %1" }, { pat="^[Ff]arming (.+)$", rep="Đang cày %1" },
{ pat="^[Uu]sing (.+)$", rep="Đang dùng %1" }, { pat="^[Jj]oining (.+)$", rep="Đang tham gia %1" },
{ pat="^[Hh]opping (.+)$", rep="Đang đổi %1" }
}
local PHRASES_VI = {
{"cursed island wars","Đại Chiến Đảo Nguyền Rủa"}, {"island wars","Đảo Nguyền Rủa"}, {"phantom express","Tàu Ma Phantom Express"},
{"pumpkin moon","Trăng Bí Ngô"}, {"halloween dimension","Không gian Halloween"}, {"ghost dog","Chó Ma"},
{"enemies and base","Kẻ địch và Căn cứ"}, {"walls and crystal","Tường chắn và Pha lê"}, {"candy corn","Kẹo Ngô"},
{"admin treadmill","máy tập Admin"}, {"instant steal","cướp tức thì"}, {"capture the egg","Cướp trứng sự kiện"},
{"no egg matches your targets","Không có trứng nào khớp mục tiêu"}, {"no eggs match filter","Không có trứng khớp bộ lọc"},
{"waiting for field to open","Đang chờ sân trứng mở"}, {"waiting for eggs to spawn","Đang chờ trứng xuất hiện"},
{"waiting in safe zone","Đợi ở vùng an toàn"}, {"returning to safe zone","Đang về vùng an toàn"},
{"to the altar","tới bệ thờ"}, {"to altar","tới bệ thờ"}, {"the altar","bệ thờ"}, {"a pumpkin","bí ngô"},
{"egg bag is full","Túi trứng đã đầy"}, {"pet bag is full","Túi pet đã đầy"}, {"bag is full","Túi đã đầy"},
{"pen is full","Chuồng đã đầy"}, {"field is closed","Sân trứng đang đóng"}, {"safe zone","vùng an toàn"},
{"other players","người chơi khác"}, {"missing index","thiếu trong Chỉ mục"}, {"shooting star","sao băng"},
{"butterfly bloom","mùa bướm nở"}, {"racing event","sự kiện đua xe"}, {"offline cash","tiền ngoại tuyến"},
{"index rewards","thưởng Chỉ mục"}, {"lab eggs","trứng Lab"}, {"event egg","trứng sự kiện"},
{"minigame eggs","trứng Minigame"}, {"minigame egg","trứng Minigame"}, {"wisp eggs","trứng Wisp"},
{"to safe zone","về vùng an toàn"}, {"to safety","đến nơi an toàn"}, {"to base","về căn cứ"}, {"to pen","vào chuồng"},
{"was added to your configs","đã được thêm vào danh sách cấu hình"}
}
local WORDS_VI = {
leaving="Đang rời", entering="Đang vào", vacuuming="Đang hút", riding="Đang đi", choose="chọn", multiple="nhiều", shorter="ngắn hơn", delay="độ trễ", between="giữa", tasks="tác vụ", grabs="cướp",
idle="Đang rảnh", carrying="Đang mang", delivering="Đang giao", stealing="Đang cướp", grabbing="Đang nhặt",
picking="Đang nhặt", collecting="Đang thu thập", holding="Đang giữ", capturing="Đang bắt giữ", dropping="Đang thả",
tweening="Đang bay", teleporting="Đang dịch chuyển", going="Đang đi", moving="Đang di chuyển", walking="Đang đi bộ",
running="Đang chạy", flying="Đang bay", returning="Đang quay về", placing="Đang đặt", hatching="Đang ấp",
mutating="Đang đột biến", selling="Đang bán", fusing="Đang dung hợp", upgrading="Đang nâng cấp", buying="Đang mua",
claiming="Đang nhận", equipping="Đang trang bị", catching="Đang nhặt", chasing="Đang đuổi theo", attacking="Đang tấn công",
hitting="Đang đánh", killing="Đang tiêu diệt", trading="Đang đổi", crafting="Đang chế tạo", avoiding="Đang né",
waiting="Đang chờ", searching="Đang tìm", scanning="Đang quét", farming="Đang cày", using="Đang dùng",
joining="Đang vào", hopping="Đang đổi", rejoining="Đang vào lại", finding="Đang tìm", racing="Đang đua",
ready="Sẵn sàng", nothing="Không có gì", none="Không có", no="Không có", pumpkin="bí ngô", pumpkins="bí ngô",
altar="bệ thờ", monster="quái vật", monsters="quái vật", ghost="ma", ghosts="ma", soul="linh hồn", souls="linh hồn",
train="chuyến tàu", boss="Boss", cursed="nguyền rủa", island="đảo", wars="đại chiến", enemies="kẻ địch",
walls="tường chắn", crystal="pha lê", candy="kẹo", corn="ngô", fishing="câu cá", fish="cá", quest="nhiệm vụ",
dimension="không gian", delivery="mang về", calculate="tính thử", mutation="đột biến", mutations="đột biến",
weapon="vũ khí", weapons="vũ khí", removed="đã gỡ bỏ", added="đã thêm", fixed="đã sửa", egg="trứng", eggs="trứng",
pet="pet", pets="pet", matches="khớp", match="khớp", matching="khớp", your="của bạn", target="mục tiêu",
targets="mục tiêu", filter="bộ lọc", home="về nhà", base="căn cứ", pen="chuồng", pens="chuồng", field="sân trứng",
zone="khu vực", zones="khu vực", bag="túi", full="đầy", empty="trống", closed="đóng", open="mở", guard="vệ sĩ",
guards="vệ sĩ", player="người chơi", players="người chơi", server="máy chủ", treadmill="máy tập", race="đua xe",
star="sao băng", butterfly="bướm", portal="cổng", rewards="thưởng", reward="thưởng", cash="tiền", found="tìm thấy",
speed="tốc độ", instant="tức thì", steal="cướp", auto="tự động", to="tới", from="từ", ["in"]="trong", at="tại",
["for"]="cho", with="với", ["and"]="và", ["or"]="hoặc"
}
local DYN_VI = {
{ pat="^QUICK BAR (%d+)$", rep="THANH NHANH %1" },
{ pat="^(.+) Egg$", rep="Trứng %1" },
{ pat="^(%d+) hours? ago$", rep="%1 giờ trước" },
{ pat="^(%d+) days? ago$", rep="%1 ngày trước" },
{ pat="^(%d+) minutes? ago$", rep="%1 phút trước" },
{ pat="^(.+) was added to your configs%. Apply it now%??$", rep="Đã thêm '%1' vào danh sách cấu hình. Áp dụng ngay?" },
{ pat="^(.+) was added to your configs$", rep="Đã thêm '%1' vào danh sách cấu hình" },
{ pat="Welcome to Venyx ([%d%.]+)! Join our Discord for updates and support", rep="Chào mừng tới Chilli Hub V7 (%1)! Tham gia Discord để cập nhật và nhận hỗ trợ" },
{ pat="Venyx(.-)(%d+) hours? ago", rep="Chilli Hub%1%2 giờ trước" },
{ pat="Venyx(.-)(%d+) minutes? ago", rep="Chilli Hub%1%2 phút trước" },
{ pat="Venyx(.-)(%d+) days? ago", rep="Chilli Hub%1%2 ngày trước" },
{ pat="^ALL (%d+)$", rep="TẤT CẢ %1" }, { pat="^READY (%d+)$", rep="SẴN SÀNG %1" },
{ pat="^GROWING (%d+)$", rep="ĐANG LỚN %1" }, { pat="^IN BAG (%d+)$", rep="TRONG TÚI %1" },
{ pat="Pen (%d+/%d+) · (%d+) egg%(s%) ready to place", rep="Chuồng %1 · %2 trứng sẵn sàng đặt" },
{ pat="(%d+) egg%(s%) can be mutated", rep="%1 trứng có thể đột biến" },
{ pat="(%d+) pet%(s%) match", rep="%1 pet khớp bộ lọc" }, { pat="(%d+) egg%(s%) match", rep="%1 trứng khớp bộ lọc" },
{ pat="(%d+) lab egg%(s%) match", rep="%1 trứng Lab khớp bộ lọc" }, { pat="^(%d+) pets$", rep="%1 thú cưng" },
{ pat="(%d+ / %d+) players · (.+)", rep="%1 người chơi · %2" },
{ pat="Experimental Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep="Pet Thí Nghiệm · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4" },
{ pat="Biohazard Pets · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep="Pet Sinh Học · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4" },
{ pat="Unstable DNA · needs (.-) · pity (%d+/%d+) · rerolls (%d+) · (.+)", rep="DNA Bất Ổn · cần %1 · bảo hiểm %2 · lượt đổi %3 · %4" },
{ pat="^Mythic · 1 in ([%d%.]+)$", rep="Thần Thoại · 1 trên %1" },
{ pat="^Cosmic · 1 in ([%d%.]+)$", rep="Vũ Trụ · 1 trên %1" },
{ pat="^Secret · 1 in ([%d%.]+)$", rep="Bí Ẩn · 1 trên %1" },
{ pat="^Divine · 1 in ([%d%.]+)$", rep="Thánh Thần · 1 trên %1" },
{ pat="^Eternal · 1 in ([%d%.]+)$", rep="Vĩnh Cửu · 1 trên %1" },
{ pat="^First hop after (%d+)s$", rep="Đổi lần đầu sau %1 giây" },
{ pat="^Hold each ([%d%.]+)s$", rep="Cầm mỗi món %1 giây" },
{ pat="^(%d+) selected$", rep="Đã chọn %1 mục" },
{ pat="^(%d+)%s*/%s*(%d+) selected$", rep="Đã chọn %1/%2" }
}
local function stripArt(s)
return ((" " .. s .. " "):gsub("%s+[Aa]%s+", " "):gsub("%s+[Aa]n%s+", " "):gsub("%s+[Tt]he%s+", " "):match("^%s*(.-)%s*$") or s)
end
local function applyPhrases(s)
local out = s
for i = 1, #PHRASES_VI do
local p = PHRASES_VI[i]
local a, b = out:lower():find(p[1], 1, true)
if a then out = out:sub(1, a - 1) .. p[2] .. out:sub(b + 1) end
end
return out
end
local function applyWords(s)
return (stripArt(s):gsub("([\128-\255%a']+)", function(w)
if w:find("[\128-\255]") then return w end
local l = w:lower()
return WORDS_VI[l] or LOWER_VI[l] or w
end))
end
local function translateStatus(en)
if not en or en == "" then return State.Language == "EN" and "Idle" or "Đang rảnh" end
local t = (en:match("^%s*(.-)%s*$") or en):gsub("%.+$", "")
if State.Language == "EN" then return t == "Đang rảnh" and "Idle" or t end
if t:lower() == "idle" or t == "Đang rảnh" then return "Đang rảnh" end
local ck = "ST|" .. t
if FastCache[ck] then return FastCache[ck] end
if EXACT_VI[t] or LOWER_VI[t:lower()] then
local r = EXACT_VI[t] or LOWER_VI[t:lower()]
FastCache[ck] = r
return r
end
local out = stripArt(t)
for i = 1, #GRAMMAR_VI do
if out:find(GRAMMAR_VI[i].pat) then
out = out:gsub(GRAMMAR_VI[i].pat, GRAMMAR_VI[i].rep)
break
end
end
out = applyWords(applyPhrases(out)):gsub("%s+", " "):match("^%s*(.-)%s*$") or out
FastCache[ck] = out
return out
end
local function translateText(raw)
if not raw or raw == "" then return raw end
local ck = State.Language .. "|" .. raw
if FastCache[ck] then return FastCache[ck] end
if raw:find("Venyx SAE", 1, true) then
raw = raw:gsub("Venyx SAE", "Chilli SAE")
elseif raw == "VENYX" or raw == "Chilli Hub V5" or raw == "Chilli V5 |" then
raw = NEW_TITLE
end
if State.Language == "EN" then
FastCache[ck] = raw
return raw
end
local norm = (raw:match("^%s*(.-)%s*$") or raw):gsub("%s+", " ")
if norm:match("^[%$%+%-%d%.%,%/%%sxhm]+$") or (norm:match("^v%d+%.%d+") and #norm < 10) then
FastCache[ck] = raw
return raw
end
if EXACT_VI[norm] or LOWER_VI[norm:lower()] then
local r = EXACT_VI[norm] or LOWER_VI[norm:lower()]
FastCache[ck] = r
return r
end
local dots = norm:match("^(.+)%.%.%.$")
if dots then
dots = dots:match("^%s*(.-)%s*$") or dots
local m = EXACT_VI[dots] or LOWER_VI[dots:lower()]
if m then
FastCache[ck] = m .. "..."
return FastCache[ck]
end
end
local pfx, wp = norm:match("^([^%w%s]+%s*)(.+)$")
if pfx and wp and (EXACT_VI[wp] or LOWER_VI[wp:lower()]) then
FastCache[ck] = pfx .. (EXACT_VI[wp] or LOWER_VI[wp:lower()])
return FastCache[ck]
end
for i = 1, #DYN_VI do
if norm:find(DYN_VI[i].pat) then
FastCache[ck] = norm:gsub(DYN_VI[i].pat, DYN_VI[i].rep)
return FastCache[ck]
end
end
local res, hit = norm, false
local caps = (norm:upper() == norm and norm:find("%a") ~= nil)
for i = 1, #GRAMMAR_VI do
if res:find(GRAMMAR_VI[i].pat) then
res = res:gsub(GRAMMAR_VI[i].pat, GRAMMAR_VI[i].rep)
hit = true
break
end
end
local phr = applyPhrases(res)
if hit or phr ~= res or res:find("%s") then
local fin = applyWords(phr):gsub("Venyx", "Chilli Hub"):gsub("%s+", " "):match("^%s*(.-)%s*$") or res
if caps and fin ~= norm then fin = fin:upper() end
FastCache[ck] = fin
return fin
end
FastCache[ck] = raw
return raw
end
local function applyTrans(inst)
if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
if inst:GetAttribute("__IslandDone") or inst:GetAttribute("__FpsHookSession") or inst:GetAttribute("__HiddenVxLogo")
or inst.Name == "IslandExpandHint" or inst.Name == "ChilliUltraTitleBadge" or inst.Name == "ChilliIslandTitle" or inst.Name == "BadgeTxt"
or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliHeaderOverlay") or inst:FindFirstAncestor("ChilliSenaBottomBar")
or inst:GetAttribute("__IsTranslating") then return end
if inst:IsA("TextBox") then
local ph = inst:GetAttribute("OrigPlaceholder") or inst:GetAttribute("OrigPh")
if not ph and inst.PlaceholderText ~= "" and not hasVi(inst.PlaceholderText) then
ph = inst.PlaceholderText
inst:SetAttribute("OrigPlaceholder", ph)
inst:SetAttribute("OrigPh", ph)
end
if ph then inst.PlaceholderText = translateText(ph) end
if not inst:IsFocused() then
local bt = inst.Text
if bt == "Off" or bt == "Tắt" or bt == "None" or bt == "Không có" then
local ob = inst:GetAttribute("OrigBoxText") or ((bt == "Tắt") and "Off" or ((bt == "Không có") and "None" or bt))
inst:SetAttribute("OrigBoxText", ob)
local mb = translateText(ob)
if inst.Text ~= mb then
inst:SetAttribute("__IsTranslating", true)
pcall(function() inst.Text = mb end)
inst:SetAttribute("__IsTranslating", false)
end
end
end
return
end
local rt = inst.Text
if isFpsTxt(rt) then
hookFps(inst)
return
end
local orig = inst:GetAttribute("OrigRawText")
if not orig then
if not hasVi(rt) then
orig = rt
inst:SetAttribute("OrigRawText", orig)
else
return
end
end
local mapped = translateText(orig)
inst:SetAttribute("__LastTranslated", mapped)
if inst.Text ~= mapped then
inst:SetAttribute("__IsTranslating", true)
pcall(function() inst.Text = mapped end)
inst:SetAttribute("__IsTranslating", false)
end
end
local function hookTrans(inst)
if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
if inst.Name == "ChilliFakeFpsOverlay" or inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") or inst.Name == "IslandExpandHint"
or inst.Name == "ChilliUltraTitleBadge" or inst.Name == "ChilliIslandTitle" or inst.Name == "BadgeTxt"
or inst:FindFirstAncestor("ChilliV5_ExpandedIsland") or inst:FindFirstAncestor("ChilliHeaderOverlay") or inst:FindFirstAncestor("ChilliSenaBottomBar") then return end
if not inst:IsA("TextBox") and isFpsTxt(inst.Text) then
hookFps(inst)
return
end
applyTrans(inst)
if inst:GetAttribute("__TransHookSession") == SID then return end
inst:SetAttribute("__TransHookSession", SID)
table.insert(State.TrackedTexts, inst)
local inScroll = inst:FindFirstAncestorOfClass("ScrollingFrame") ~= nil
if inScroll and inst:IsA("TextLabel") and inst.Text ~= "" and not inst.Text:find("%d") then
return
end
inst:GetPropertyChangedSignal("Text"):Connect(function()
if not isAlive() or inst:GetAttribute("__IsTranslating") or inst:GetAttribute("__IslandDone") or inst:GetAttribute("__HiddenVxLogo") then return end
local cur = inst.Text
if cur == "" or cur == inst:GetAttribute("__LastTranslated") then return end
if not inst:IsA("TextBox") and isFpsTxt(cur) then
hookFps(inst)
return
end
if cur:match("^[%$%+%-%d%.%,%/%%sxhm%s:]+$") then return end
if inst:IsA("TextBox") then
applyTrans(inst)
return
end
if not hasVi(cur) then
inst:SetAttribute("OrigRawText", cur)
applyTrans(inst)
end
end)
end
local function refreshAllTexts()
task.spawn(function()
table.clear(FastCache)
if State.RefreshIslandCallback then pcall(State.RefreshIslandCallback) end
local list = State.TrackedTexts
for i = #list, 1, -1 do
if not isAlive() then return end
local el = list[i]
if el and el.Parent then applyTrans(el) else table.remove(list, i) end
if i % 80 == 0 then task.wait() end
end
end)
end
-- 5. NẠP CONFIG CHUẨN V5 (DÁN JSON VÀ BẤM NÚT NHẬP / IMPORT CHÍNH XÁC 100%)
local function fireBtn(btn)
if not btn then return false end
local fired = false
local clickable = (btn:IsA("TextButton") or btn:IsA("ImageButton")) and btn
or btn:FindFirstAncestorWhichIsA("TextButton") or btn:FindFirstAncestorWhichIsA("ImageButton")
or (btn.Parent and (btn.Parent:FindFirstChildWhichIsA("TextButton") or btn.Parent:FindFirstChildWhichIsA("ImageButton")))
or btn
local targets = {}
local seenT = {}
for _, tObj in ipairs({ clickable, btn, btn.Parent, btn.Parent and btn.Parent.Parent }) do
if tObj and tObj:IsA("GuiObject") and not seenT[tObj] then
seenT[tObj] = true
table.insert(targets, tObj)
end
end
if getconnections then
for _, targetObj in ipairs(targets) do
for _, sigName in ipairs({"MouseButton1Click", "Activated", "MouseButton1Down", "MouseButton1Up"}) do
pcall(function()
local sig = targetObj[sigName]
if sig then
for _, conn in ipairs(getconnections(sig)) do
if conn.Function then
task.spawn(conn.Function)
fired = true
end
end
end
end)
end
pcall(function()
local pos3 = Vector3.new(targetObj.AbsolutePosition.X + targetObj.AbsoluteSize.X * 0.5, targetObj.AbsolutePosition.Y + targetObj.AbsoluteSize.Y * 0.5, 0)
for _, uType in ipairs({ Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch }) do
local fakeBegin = { UserInputType = uType, UserInputState = Enum.UserInputState.Begin, Position = pos3, Delta = Vector3.zero, KeyCode = Enum.KeyCode.Unknown }
local fakeEnd = { UserInputType = uType, UserInputState = Enum.UserInputState.End, Position = pos3, Delta = Vector3.zero, KeyCode = Enum.KeyCode.Unknown }
for _, conn in ipairs(getconnections(targetObj.InputBegan)) do
if conn.Function then
task.spawn(conn.Function, fakeBegin, false)
fired = true
end
end
for _, conn in ipairs(getconnections(targetObj.InputEnded)) do
if conn.Function then
task.spawn(conn.Function, fakeEnd, false)
fired = true
end
end
end
end)
end
end
if firesignal then
for _, targetObj in ipairs(targets) do
if targetObj:IsA("TextButton") or targetObj:IsA("ImageButton") then
pcall(function()
firesignal(targetObj.MouseButton1Click)
fired = true
end)
pcall(function()
firesignal(targetObj.Activated)
fired = true
end)
end
end
end
return fired
end
local function isControlVisibleOnTab(el, rootGui)
if not (el and el.Parent) then return false end
local curr = el
while curr and curr ~= rootGui and not curr:IsA("ScreenGui") do
if curr:IsA("GuiObject") and not curr.Visible then return false end
curr = curr.Parent
end
return el.AbsoluteSize.X > 8 and el.AbsoluteSize.Y > 6
end
local function findSystemTabBtn(gui)
if State.SystemTabBtn and State.SystemTabBtn.Parent and State.SystemTabBtn:IsDescendantOf(gui) then
return State.SystemTabBtn
end
local candidates = {}
for _, d in ipairs(gui:GetDescendants()) do
if d:IsA("GuiObject") and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
local children = {}
for _, ch in ipairs(d:GetChildren()) do
if ch:IsA("GuiObject") and ch.AbsoluteSize.X >= 18 and ch.AbsoluteSize.X <= 70 and ch.AbsoluteSize.Y >= 18 and ch.AbsoluteSize.Y <= 70 then
table.insert(children, ch)
end
end
if #children >= 5 and #children <= 8 then
table.sort(children, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)
State.SystemTabBtn = children[6] or children[#children]
return State.SystemTabBtn
end
end
end
return State.SystemTabBtn
end
local function runAutoFarmMacro(venyxGui, btnLbl)
if State.MacroBusy then return end
State.MacroBusy = true
task.spawn(function()
local okMacro, _ = pcall(function()
if State.ActiveVenyxGui and State.ActiveVenyxGui.Parent then
venyxGui = State.ActiveVenyxGui
end
if btnLbl then btnLbl.Text = "⏳ ĐANG NẠP CONFIG..." end
if State.ActiveMainWin and State.ActiveMainWin.Parent and not State.ActiveMainWin.Visible then
State.ActiveMainWin.Visible = true
if State.SyncWindowFn then pcall(State.SyncWindowFn) end
task.wait(0.10)
end
local function findImportControls(requireVisible)
local box, btn
for _, d in ipairs(venyxGui:GetDescendants()) do
if not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestor("ChilliHeaderOverlay") then
if d:IsA("TextBox") then
local ph = (d:GetAttribute("OrigPlaceholder") or d:GetAttribute("OrigPh") or d.PlaceholderText or ""):lower()
if ph:find("paste config", 1, true) or ph:find("dán mã", 1, true) then
if not requireVisible or isControlVisibleOnTab(d, venyxGui) then
box = d
end
end
elseif d:IsA("TextButton") or d:IsA("TextLabel") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
local ct = (d.Text or ""):match("^%s*(.-)%s*$")
if ot == "Import" or ct == "Nhập" then
if not requireVisible or isControlVisibleOnTab(d, venyxGui) then
btn = d
end
end
end
end
end
return box, btn
end
local importBox, importBtn = findImportControls(true)
if not importBox or not importBtn then
local sysBtn = findSystemTabBtn(venyxGui)
if sysBtn then
fireBtn(sysBtn)
task.wait(0.20)
end
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestorOfClass("ScrollingFrame") and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
local ct = (d.Text or ""):match("^%s*(.-)%s*$")
if ot == "Config" or ct == "Cấu Hình" then
fireBtn(d)
break
end
end
end
task.wait(0.26)
importBox, importBtn = findImportControls(true)
if not importBox or not importBtn then
importBox, importBtn = findImportControls(false)
end
end
if not importBox then
if btnLbl then
btnLbl.Text = "⚠️ MỞ MỤC CẤU HÌNH TRƯỚC!"
task.wait(2)
btnLbl.Text = "⚡ CONFIG SETTING AUTO FARM"
end
return
end
local sf = importBox:FindFirstAncestorOfClass("ScrollingFrame")
if sf then
pcall(function()
sf.CanvasPosition = v2(0, math.max(320, sf.AbsoluteCanvasSize.Y))
end)
task.wait(0.06)
end
local hasHihi2 = (State.ImportRunCount or 0) > 0
if not hasHihi2 then
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local t = (d.Text or ""):lower()
if t:find("hihi 2", 1, true) then
hasHihi2 = true
break
end
end
end
end
State.ImportRunCount = (State.ImportRunCount or 0) + 1
local payloadJson = PRESET_JSON
if hasHihi2 then
local freshName = "hihi 2 #" .. tostring(math.random(10, 99))
payloadJson = PRESET_JSON:gsub('"name":"hihi 2"', '"name":"' .. freshName .. '"', 1)
end
importBox:SetAttribute("__IsTranslating", true)
pcall(function() importBox.ClearTextOnFocus = false end)
importBox.Text = ""
task.wait(0.08)
importBox.Text = payloadJson
task.wait(0.10)
if getconnections then
pcall(function()
for _, conn in ipairs(getconnections(importBox:GetPropertyChangedSignal("Text"))) do
if conn.Function then task.spawn(conn.Function) end
end
end)
end
if firesignal then
pcall(function() firesignal(importBox.FocusLost, true) end)
end
if getconnections then
pcall(function()
for _, conn in ipairs(getconnections(importBox.FocusLost)) do
if conn.Function then task.spawn(conn.Function, true) end
end
end)
end
importBox:SetAttribute("__IsTranslating", false)
if btnLbl then btnLbl.Text = "⏳ ĐANG BẤM NHẬP CONFIG..." end
task.wait(0.45)
local _, freshImportBtn = findImportControls(true)
importBtn = freshImportBtn or importBtn
if importBtn then fireBtn(importBtn) end
task.wait(0.38)
local hasApplyPrompt = false
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
local cur = (d.Text or ""):match("^%s*(.-)%s*$")
if (ot == "Apply now" or cur == "Áp dụng ngay" or ot == "Overwrite" or cur == "Lưu đè") and isControlVisibleOnTab(d, venyxGui) then
hasApplyPrompt = true
break
end
end
end
if not hasApplyPrompt and importBtn then
fireBtn(importBtn)
task.wait(0.35)
end
for pass = 1, 2 do
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
local cur = (d.Text or ""):match("^%s*(.-)%s*$")
if ot == "Apply now" or cur == "Áp dụng ngay" or ot == "Overwrite" or cur == "Lưu đè" then
if isControlVisibleOnTab(d, venyxGui) then
fireBtn(d)
end
end
end
end
task.wait(0.14)
end
for _, d in ipairs(venyxGui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("TextLabel")) and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
local cur = (d.Text or ""):match("^%s*(.-)%s*$")
if ot == "Set active" or cur == "Kích hoạt" then
if isControlVisibleOnTab(d, venyxGui) then
fireBtn(d)
break
end
end
end
end
if State.RefreshIslandCallback then pcall(State.RefreshIslandCallback) end
if btnLbl then
btnLbl.Text = "✅ ĐÃ NẠP & ÁP DỤNG CONFIG!"
task.wait(1.8)
btnLbl.Text = "⚡ CONFIG SETTING AUTO FARM"
end
end)
State.MacroBusy = false
end)
end
-- DYNAMIC ISLAND V7 (KHÔNG GẮN HUY HIỆU Ở DYNAMIC ISLAND, CHỈ DÙNG NÚT MŨI TÊN GỌN GÀNG "▾")
local function setupIsland(statusLbl, venyxGui)
local pill = statusLbl.Parent
if not (pill and pill:IsA("GuiObject")) then return end
if isFpsTxt(statusLbl.Text) then return end
statusLbl:SetAttribute("__IslandDone", true)
State.ActiveStatusLbl = statusLbl
for _, ch in ipairs(pill:GetChildren()) do
if (ch:IsA("UIGradient") and ch.Name ~= "LiquidGlassSheen") or ch.Name == "IslandClickHitbox" then
ch:Destroy()
elseif ch:IsA("Frame") and ch.Name ~= "IslandLogoBadge" and ch.AbsoluteSize.X <= 16 and ch.AbsoluteSize.Y <= 16 then
ch.Visible = false
end
end
pill.BackgroundColor3 = Color3.new(1, 1, 1)
pill.BackgroundTransparency = 0
pill.Size = u2(0, 0, 0, 38)
pill.AutomaticSize = Enum.AutomaticSize.X
local glassGrad = pill:FindFirstChild("LiquidGlassSheen") or mk("UIGradient", {
Name = "LiquidGlassSheen",
Rotation = 90,
Color = LIQUID_GLASS_COLOR,
Transparency = LIQUID_GLASS_TRANS
}, pill)
glassGrad.Rotation = 90
glassGrad.Color = LIQUID_GLASS_COLOR
glassGrad.Transparency = LIQUID_GLASS_TRANS
if pill:GetAttribute("__LockedIslandBg") ~= SID then
pill:SetAttribute("__LockedIslandBg", SID)
pill:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
if isAlive() and pill.BackgroundColor3 ~= Color3.new(1, 1, 1) then
pill.BackgroundColor3 = Color3.new(1, 1, 1)
end
end)
pill:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
if isAlive() and pill.BackgroundTransparency ~= 0 then
pill.BackgroundTransparency = 0
end
end)
pill:GetPropertyChangedSignal("Size"):Connect(function()
if isAlive() and pill.Size.Y.Offset < 36 then
pill.Size = u2(0, 0, 0, 38)
end
end)
pill:GetPropertyChangedSignal("Position"):Connect(function()
if isAlive() and not State.DraggingIsland and pill.Position.Y.Offset > 14 then
pill.Position = State.IslandUserPos or u2(0.5, 0, 0, 6)
end
end)
end
local pad = pill:FindFirstChildOfClass("UIPadding") or mk("UIPadding", {}, pill)
pad.PaddingLeft = UDim.new(0, 10)
pad.PaddingRight = UDim.new(0, 10)
pad.PaddingTop = UDim.new(0, 2)
pad.PaddingBottom = UDim.new(0, 2)
local leftBadge = pill:FindFirstChild("IslandLogoBadge")
if not leftBadge then
leftBadge = mk("Frame", { Name = "IslandLogoBadge", Size = u2(0, 28, 0, 28), BackgroundColor3 = c3(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = -10, Active = false, ZIndex = 10000 }, pill)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, leftBadge)
local lbImg = mk("ImageLabel", { Name = "LogoImg", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(1, 1), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Crop, Active = false, ZIndex = 10001 }, leftBadge)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, lbImg)
local lbStroke = mk("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, lbImg)
addGrad(mk("UIGradient", { Color = RAINBOW }, lbStroke))
else
leftBadge.Size = u2(0, 28, 0, 28)
leftBadge.BackgroundColor3 = c3(0, 0, 0)
local lbImg = leftBadge:FindFirstChildOfClass("ImageLabel")
if lbImg then
lbImg.Image = LOGO_ID
lbImg.Size = u2s(1, 1)
lbImg.ScaleType = Enum.ScaleType.Crop
if not lbImg:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, lbImg) end
end
end
local hint = pill:FindFirstChild("IslandExpandHint")
if not hint then
hint = mk("TextLabel", { Name = "IslandExpandHint", Size = u2(0, 24, 0, 22), BackgroundColor3 = c3(22, 30, 48), BackgroundTransparency = 0.28, BorderSizePixel = 0, Text = "▼", Font = Enum.Font.GothamBlack, TextSize = 10, TextColor3 = c3(205, 235, 255), LayoutOrder = 99, Active = true, ZIndex = 10000 }, pill)
else
hint.Size = u2(0, 24, 0, 22)
hint.BackgroundColor3 = c3(22, 30, 48)
hint.BackgroundTransparency = 0.28
hint.Text = "▼"
hint.Font = Enum.Font.GothamBlack
hint.TextSize = 10
hint.TextColor3 = c3(205, 235, 255)
end
if not hint:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hint) end
local hStroke = hint:FindFirstChildOfClass("UIStroke") or mk("UIStroke", { Thickness = 1.1, Color = c3(160, 215, 255), Transparency = 0.35 }, hint)
hStroke.Color = c3(160, 215, 255)
hStroke.Transparency = 0.35
local expTaskLbl = nil
local function syncStatus(fromSaved)
if statusLbl:GetAttribute("__Updating") then return end
statusLbl:SetAttribute("__Updating", true)
local cur = statusLbl.Text:gsub("●",""):gsub("•",""):gsub("✨%s*rainbow",""):match("^%s*(.-)%s*$") or ""
local en = statusLbl:GetAttribute("OrigStatusEn") or statusLbl:GetAttribute("OrigRawText")
if not fromSaved and cur ~= "" and cur ~= statusLbl:GetAttribute("__LastTranslatedStatus") and not hasVi(cur) then
en = cur
statusLbl:SetAttribute("OrigStatusEn", en)
end
local out = translateStatus(en or cur)
statusLbl:SetAttribute("__LastTranslatedStatus", out)
statusLbl.RichText = false
statusLbl.Font = Enum.Font.GothamBold
statusLbl.TextSize = 13
statusLbl.TextColor3 = Color3.new(1, 1, 1)
statusLbl.TextTransparency = 0
statusLbl.Text = out
if expTaskLbl and expTaskLbl.Parent then expTaskLbl.Text = "⚡ " .. out end
statusLbl:SetAttribute("__Updating", false)
end
State.RefreshIslandCallback = function() syncStatus(true) end
syncStatus(false)
if statusLbl:GetAttribute("__LockedStatusColor") ~= SID then
statusLbl:SetAttribute("__LockedStatusColor", SID)
statusLbl:GetPropertyChangedSignal("TextColor3"):Connect(function()
if isAlive() and statusLbl.TextColor3 ~= Color3.new(1, 1, 1) then
statusLbl.TextColor3 = Color3.new(1, 1, 1)
end
end)
statusLbl:GetPropertyChangedSignal("TextTransparency"):Connect(function()
if isAlive() and statusLbl.TextTransparency ~= 0 then
statusLbl.TextTransparency = 0
end
end)
end
local stStroke = statusLbl:FindFirstChildOfClass("UIStroke") or mk("UIStroke", { Thickness = 1.15, Color = c3(8, 12, 22), Transparency = 0.22 }, statusLbl)
stStroke.Thickness = 1.15
stStroke.Color = c3(8, 12, 22)
stStroke.Transparency = 0.22
local tg = statusLbl:FindFirstChild("TextRainbow") or mk("UIGradient", { Name = "TextRainbow", Color = LIQUID_TEXT_GRAD }, statusLbl)
tg.Color = LIQUID_TEXT_GRAD
local exp = venyxGui:FindFirstChild("ChilliV5_ExpandedIsland")
if statusLbl:GetAttribute("__IslandSession") == SID and exp then return end
statusLbl:SetAttribute("__IslandSession", SID)
for _, r in ipairs(getScanRoots()) do
for _, d in ipairs(r:GetDescendants()) do
if d.Name == "ChilliV5_ExpandedIsland" then
pcall(d.Destroy, d)
end
end
end
pill.Parent = venyxGui
pill.AnchorPoint = v2(0.5, 0)
pill.ZIndex = 9999
pill.Active = true
statusLbl.Active = true
hint.Active = true
pill.Position = State.IslandUserPos or u2(0.5, 0, 0, 6)
if not pill:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, pill) end
local ps = pill:FindFirstChild("IslandStroke") or mk("UIStroke", { Name = "IslandStroke", Thickness = 1.6, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.new(1, 1, 1), Transparency = 0.14 }, pill)
addGrad(ps:FindFirstChildOfClass("UIGradient") or mk("UIGradient", { Color = RAINBOW }, ps))
exp = mk("Frame", { Name = "ChilliV5_ExpandedIsland", AnchorPoint = v2(0.5, 0), Position = pill.Position, Size = u2(0, 308, 0, 180), BackgroundColor3 = c3(10, 12, 20), BorderSizePixel = 0, Visible = false, Active = true, ClipsDescendants = true, ZIndex = 10000 }, venyxGui)
mk("UICorner", { CornerRadius = UDim.new(0, 18) }, exp)
local es = mk("UIStroke", { Thickness = 2.0, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, exp)
addGrad(mk("UIGradient", { Color = RAINBOW }, es))
mk("ImageLabel", { Name = "IslandCosmicBg", Position = u2(0, 0, 0, 0), Size = u2(1, 0, 0, 42), BackgroundTransparency = 1, Image = HEADER_BAR_IMG_ID, ImageRectOffset = v2(15, 60), ImageRectSize = v2(650, 170), ScaleType = Enum.ScaleType.Stretch, ImageTransparency = 0.22, Active = false, ZIndex = 10000 }, exp)
local expLogo = mk("Frame", { Position = u2(0, 10, 0, 7), Size = u2(0, 24, 0, 24), BackgroundColor3 = c3(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Active = false, ZIndex = 10002 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, expLogo)
local elStroke = mk("UIStroke", { Thickness = 1.4, Color = Color3.new(1, 1, 1) }, expLogo)
addGrad(mk("UIGradient", { Color = RAINBOW }, elStroke))
local expLogoImg = mk("ImageLabel", { AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(1, 1), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Crop, Active = false, ZIndex = 10003 }, expLogo)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, expLogoImg)
local expTitle = mk("TextLabel", { Name = "ChilliIslandTitle", Size = u2(0, 150, 0, 24), Position = u2(0, 40, 0, 7), BackgroundTransparency = 1, Text = "Chilli Hub V7", Font = Enum.Font.GothamBlack, TextSize = 13.5, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10002 }, exp)
mk("UIStroke", { Thickness = 1.2, Color = c3(12, 8, 22), Transparency = 0.2 }, expTitle)
addGrad(mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, expTitle))
local colBtn = mk("TextButton", { Size = u2(0, 26, 0, 22), Position = u2(1, -34, 0, 8), BackgroundColor3 = c3(22, 24, 36), BorderSizePixel = 0, Text = "▲", Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = c3(160, 205, 255), ZIndex = 10003 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, colBtn)
local taskBox = mk("Frame", { Size = u2(1, -20, 0, 24), Position = u2(0, 10, 0, 36), BackgroundColor3 = c3(16, 18, 28), BackgroundTransparency = 0.15, BorderSizePixel = 0, ZIndex = 10001 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, taskBox)
mk("UIStroke", { Thickness = 1, Color = c3(45, 52, 78), Transparency = 0.35 }, taskBox)
expTaskLbl = mk("TextLabel", { Size = u2(1, -16, 1, 0), Position = u2(0, 8, 0, 0), BackgroundTransparency = 1, Text = "⚡ " .. (statusLbl.Text or "Đang rảnh"), Font = Enum.Font.GothamBold, TextSize = 10.5, TextColor3 = Color3.new(1, 1, 1), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 10002 }, taskBox)
addGrad(mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, expTaskLbl))
local cap = mk("Frame", { Size = u2(1, -20, 0, 32), Position = u2(0, 10, 0, 65), BackgroundColor3 = c3(18, 20, 30), BorderSizePixel = 0, ZIndex = 10001 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, cap)
local sld = mk("Frame", { Size = u2(0.5, -4, 1, -4), Position = (State.Language == "VI" and u2(0, 2, 0, 2) or u2(0.5, 2, 0, 2)), BackgroundColor3 = c3(95, 110, 235), BorderSizePixel = 0, ZIndex = 10002 }, cap)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, sld)
local bVI = mk("TextButton", { Size = u2(0.5, 0, 1, 0), BackgroundTransparency = 1, Text = "🇻🇳 TIẾNG VIỆT", Font = Enum.Font.GothamBold, TextSize = 10.5, TextColor3 = (State.Language == "VI" and Color3.new(1, 1, 1) or c3(150, 165, 190)), ZIndex = 10003 }, cap)
local bEN = mk("TextButton", { Size = u2(0.5, 0, 1, 0), Position = u2(0.5, 0, 0, 0), BackgroundTransparency = 1, Text = "🌐 ENGLISH", Font = Enum.Font.GothamBold, TextSize = 10.5, TextColor3 = (State.Language == "EN" and Color3.new(1, 1, 1) or c3(150, 165, 190)), ZIndex = 10003 }, cap)
local cfgBtn = mk("TextButton", { Name = "AutoFarmConfigBtn", Size = u2(1, -20, 0, 34), Position = u2(0, 10, 0, 102), BackgroundColor3 = c3(22, 25, 40), BorderSizePixel = 0, Text = "⚡ CONFIG SETTING AUTO FARM", Font = Enum.Font.GothamBlack, TextSize = 10.5, TextColor3 = Color3.new(1, 1, 1), ZIndex = 10003 }, exp)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, cfgBtn)
addGrad(mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, cfgBtn))
local cs = mk("UIStroke", { Thickness = 1.4, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, cfgBtn)
addGrad(mk("UIGradient", { Color = RAINBOW }, cs))
cfgBtn.MouseButton1Click:Connect(function() runAutoFarmMacro(venyxGui, cfgBtn) end)
local qRow = mk("Frame", { Name = "QuickActionsDock", Size = u2(1, -20, 0, 30), Position = u2(0, 10, 0, 142), BackgroundTransparency = 1, ZIndex = 10002 }, exp)
local btnFps = mk("TextButton", { Size = u2(0.32, 0, 1, 0), Position = u2(0, 0, 0, 0), BackgroundColor3 = c3(20, 24, 38), BorderSizePixel = 0, Text = "🚀 SIÊU MƯỢT", Font = Enum.Font.GothamBold, TextSize = 9.5, TextColor3 = c3(135, 235, 255), ZIndex = 10003 }, qRow)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, btnFps)
mk("UIStroke", { Thickness = 1, Color = c3(60, 165, 255), Transparency = 0.3 }, btnFps)
local btnHop = mk("TextButton", { Size = u2(0.32, 0, 1, 0), Position = u2(0.34, 0, 0, 0), BackgroundColor3 = c3(20, 24, 38), BorderSizePixel = 0, Text = "🔄 ĐỔI SERVER", Font = Enum.Font.GothamBold, TextSize = 9.5, TextColor3 = c3(255, 215, 95), ZIndex = 10003 }, qRow)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, btnHop)
mk("UIStroke", { Thickness = 1, Color = c3(255, 185, 55), Transparency = 0.3 }, btnHop)
local btnAfk = mk("TextButton", { Size = u2(0.32, 0, 1, 0), Position = u2(0.68, 0, 0, 0), BackgroundColor3 = c3(18, 36, 28), BorderSizePixel = 0, Text = "🛡️ ANTI-AFK: BẬT", Font = Enum.Font.GothamBold, TextSize = 9.5, TextColor3 = c3(95, 255, 165), ZIndex = 10003 }, qRow)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, btnAfk)
mk("UIStroke", { Thickness = 1, Color = c3(55, 225, 135), Transparency = 0.25 }, btnAfk)
btnFps.MouseButton1Click:Connect(function()
btnFps.Text = "⏳ ĐANG TỐI ƯU..."
task.spawn(function()
pcall(function()
local lgt = game:GetService("Lighting")
lgt.GlobalShadows = false
lgt.FogEnd = 9e9
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
local desc = workspace:GetDescendants()
for idx = 1, #desc do
local v = desc[idx]
if v and v.Parent then
if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Sparkles") or v:IsA("Smoke") or v:IsA("Fire") then
v.Enabled = false
elseif v:IsA("Decal") or v:IsA("Texture") then
v.Transparency = 1
end
end
if idx % 250 == 0 then task.wait() end
end
end)
btnFps.Text = "✅ FPS CỰC ĐẠI!"
task.wait(1.8)
btnFps.Text = "🚀 SIÊU MƯỢT"
end)
end)
btnHop.MouseButton1Click:Connect(function()
btnHop.Text = "⏳ ĐANG ĐỔI..."
task.spawn(function()
local hopped = false
for _, d in ipairs(venyxGui:GetDescendants()) do
if d:IsA("TextButton") or d:IsA("TextLabel") then
local ot = (d:GetAttribute("OrigRawText") or d.Text or ""):match("^%s*(.-)%s*$")
if ot == "Hop" or ot == "Server hop" or d.Text == "Đổi ngay" or d.Text == "Đổi server" then
hopped = fireBtn(d)
if hopped then break end
end
end
end
if not hopped then
pcall(function()
game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)
end
task.wait(1.8)
btnHop.Text = "🔄 ĐỔI SERVER"
end)
end)
State.AntiAfkEnabled = true
if not State.AntiAfkHooked then
State.AntiAfkHooked = true
pcall(function()
LocalPlayer.Idled:Connect(function()
if State.AntiAfkEnabled then
pcall(function()
local vu = game:GetService("VirtualUser")
vu:CaptureController()
vu:ClickButton2(v2(0, 0))
end)
end
end)
end)
end
btnAfk.MouseButton1Click:Connect(function()
State.AntiAfkEnabled = not State.AntiAfkEnabled
if State.AntiAfkEnabled then
btnAfk.Text = "🛡️ ANTI-AFK: BẬT"
btnAfk.TextColor3 = c3(95, 255, 165)
btnAfk.BackgroundColor3 = c3(18, 36, 28)
else
btnAfk.Text = "🛡️ ANTI-AFK: TẮT"
btnAfk.TextColor3 = c3(160, 170, 190)
btnAfk.BackgroundColor3 = c3(22, 24, 36)
end
end)
local function setLang(l)
if State.Language == l then return end
State.Language = l
if writefile then pcall(writefile, LANG_FILE, l) end
TweenService:Create(sld, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = (l == "VI" and u2(0, 2, 0, 2) or u2(0.5, 2, 0, 2)) }):Play()
bVI.TextColor3 = l == "VI" and Color3.new(1, 1, 1) or c3(150, 165, 190)
bEN.TextColor3 = l == "EN" and Color3.new(1, 1, 1) or c3(150, 165, 190)
refreshAllTexts()
end
bVI.MouseButton1Click:Connect(function() setLang("VI") end)
bEN.MouseButton1Click:Connect(function() setLang("EN") end)
local open, lastToggleClock = false, 0
local function toggle()
if os.clock() - lastToggleClock < 0.18 then return end
lastToggleClock = os.clock()
open = not open
if open then
for _, r in ipairs(getScanRoots()) do
for _, d in ipairs(r:GetDescendants()) do
if d.Name == "ChilliV5_ExpandedIsland" and d ~= exp then
pcall(d.Destroy, d)
end
end
end
exp.Position = pill.Position
exp.Size = u2(0, 210, 0, 32)
exp.Visible = true
pill.Visible = false
TweenService:Create(exp, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = u2(0, 308, 0, 180) }):Play()
else
local tw = TweenService:Create(exp, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = u2(0, 210, 0, 32) })
tw:Play()
tw.Completed:Connect(function()
if not open then
exp.Visible = false
pill.Visible = true
end
end)
end
end
colBtn.MouseButton1Click:Connect(toggle)
local dStart, dMoved, activeInput = nil, false, nil
local function onIn(i)
if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and activeInput ~= i then
activeInput = i
dStart, dMoved = i.Position, false
State.DraggingIsland = true
local c1, c2
c1 = i.Changed:Connect(function()
if i.UserInputState == Enum.UserInputState.End then
State.DraggingIsland = false
activeInput = nil
if c1 then c1:Disconnect() end
if c2 then c2:Disconnect() end
if dMoved then
State.IslandUserPos = pill.Position
else
toggle()
end
end
end)
c2 = pill.InputChanged:Connect(function(m)
if (m.UserInputType == Enum.UserInputType.MouseMovement or m.UserInputType == Enum.UserInputType.Touch) and dStart and (m.Position - dStart).Magnitude > 8 then
dMoved = true
end
end)
end
end
if pill:GetAttribute("__IslandInputHooked") ~= SID then
pill:SetAttribute("__IslandInputHooked", SID)
pill.InputBegan:Connect(onIn)
statusLbl.InputBegan:Connect(onIn)
hint.InputBegan:Connect(onIn)
end
statusLbl:GetPropertyChangedSignal("Text"):Connect(function() if isAlive() then syncStatus(false) end end)
end
-- NÚT NỔI TRÒN ĐEN TUYỀN #000000 + PHÓNG XA LOGO 0.58x (KHÔNG CHE HOẠ TIẾT TINH THỂ)
local function cleanupStrayLogos(gui, win)
for _, ch in ipairs(gui:GetChildren()) do
if ch:IsA("GuiObject") and ch ~= win and ch.Name ~= "ChilliV5_ExpandedIsland" and not ch:FindFirstChild("IslandExpandHint") then
local s, p = ch.AbsoluteSize, ch.AbsolutePosition
if s.X >= 22 and s.X <= 110 and s.Y >= 22 and s.Y <= 110 and p.X > 260 then
ch.Visible = false
end
end
end
end
local function setupCircleLogo(obj, win)
local top = obj
while top.Parent and top.Parent:IsA("GuiObject") and not top.Parent:IsA("ScreenGui") do top = top.Parent end
if not top or not win or top == win or top:IsDescendantOf(win) then return end
if top.Name == "ChilliV5_ExpandedIsland" or top:FindFirstChild("IslandExpandHint") then return end
if top.Size.X.Offset > 105 or top.Size.Y.Offset > 105 or top.Size.X.Scale > 0.25 or top.Size.Y.Scale > 0.25 then return end
local descList = top:GetDescendants()
if #descList > 18 then return end
for _, ch in ipairs(descList) do
if ch:IsA("TextLabel") or ch:IsA("TextButton") then
local t = (ch.Text or ""):match("^%s*(.-)%s*$")
if t == "V" or t == "x" or t == "Vx" or t == "VX" or ch:GetAttribute("__HiddenVxLogo") then
ch:SetAttribute("__HiddenVxLogo", true)
ch.TextTransparency = 1
elseif t ~= "" then
return
end
end
end
local sz, pos = top.AbsoluteSize, top.AbsolutePosition
if sz.X > 105 or sz.Y > 105 or sz.X < 24 or math.abs(sz.X - sz.Y) > 25 or pos.X > 260 then return end
for _, ch in ipairs(top:GetChildren()) do
if ch.Name == "ChilliV5CoverLogo" or ch.Name == "RainbowBorder" or ch.Name == "ChilliInnerRing" or ch.Name == "ChilliCosmicAura" or ch:IsA("UIStroke") then
pcall(ch.Destroy, ch)
elseif ch:IsA("UICorner") then
ch.CornerRadius = UDim.new(1, 0)
end
end
local discExisting = top:FindFirstChild("ChilliCircleDisc")
for _, ch in ipairs(top:GetDescendants()) do
if not (discExisting and ch:IsDescendantOf(discExisting)) and ch ~= discExisting then
if (ch:IsA("UIPadding") or ch:IsA("UIAspectRatioConstraint") or ch:IsA("UISizeConstraint")) and ch.Name ~= "PerfectCircleAspect" then
pcall(ch.Destroy, ch)
elseif ch:IsA("UIStroke") then
ch.Transparency = 1
ch.Enabled = false
elseif ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
ch.ImageTransparency = 1
ch.BackgroundTransparency = 1
elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
ch:SetAttribute("__HiddenVxLogo", true)
ch.TextTransparency = 1
ch.BackgroundTransparency = 1
elseif ch:IsA("Frame") then
ch.BackgroundTransparency = 1
end
end
end
if top:IsA("ImageLabel") or top:IsA("ImageButton") then
top.ImageTransparency = 1
elseif top:IsA("TextLabel") or top:IsA("TextButton") then
top:SetAttribute("__HiddenVxLogo", true)
top.TextTransparency = 1
end
top.Size = u2(0, 70, 0, 70)
if not top:GetAttribute("__SafePosAdjusted") then
top:SetAttribute("__SafePosAdjusted", true)
if pos.Y > 125 and pos.Y < 260 then top.Position = u2(0, 16, 0, 56) end
end
top.BackgroundTransparency = 1
top.BorderSizePixel = 0
top.ClipsDescendants = false
if not top:FindFirstChild("PerfectCircleAspect") then
mk("UIAspectRatioConstraint", { Name = "PerfectCircleAspect", AspectRatio = 1 }, top)
end
if not top:GetAttribute("__SizeLockedV5Pro") then
top:SetAttribute("__SizeLockedV5Pro", true)
top:GetPropertyChangedSignal("Size"):Connect(function()
if top.Size ~= u2(0, 70, 0, 70) then top.Size = u2(0, 70, 0, 70) end
end)
end
local disc = top:FindFirstChild("ChilliCircleDisc") or mk("Frame", {
Name = "ChilliCircleDisc", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5),
Size = u2(0, 66, 0, 66), BackgroundColor3 = c3(0, 0, 0), BackgroundTransparency = 0,
BorderSizePixel = 0, Active = false, ClipsDescendants = false, ZIndex = top.ZIndex + 8
}, top)
disc.BackgroundColor3 = c3(0, 0, 0)
disc.BackgroundTransparency = 0
disc.Size = u2(0, 66, 0, 66)
disc.ClipsDescendants = false
disc.ZIndex = top.ZIndex + 8
local discCorner = disc:FindFirstChildOfClass("UICorner") or mk("UICorner", { CornerRadius = UDim.new(1, 0) }, disc)
discCorner.CornerRadius = UDim.new(1, 0)
local cov = disc:FindFirstChild("ChilliV5CoverLogo") or mk("ImageLabel", {
Name = "ChilliV5CoverLogo", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5),
Size = u2s(1, 1), BackgroundColor3 = c3(0, 0, 0), BackgroundTransparency = 0, Image = LOGO_ID,
ScaleType = Enum.ScaleType.Crop, Active = false, ZIndex = disc.ZIndex + 2
}, disc)
cov.Image = LOGO_ID
cov.Size = u2s(1, 1)
cov.Position = u2s(0.5, 0.5)
cov.AnchorPoint = v2(0.5, 0.5)
cov.BackgroundColor3 = c3(0, 0, 0)
cov.BackgroundTransparency = 0
cov.ScaleType = Enum.ScaleType.Crop
cov.ZIndex = disc.ZIndex + 2
local covCorner = cov:FindFirstChildOfClass("UICorner") or mk("UICorner", { CornerRadius = UDim.new(1, 0) }, cov)
covCorner.CornerRadius = UDim.new(1, 0)
local covStroke = cov:FindFirstChild("RainbowBorder") or mk("UIStroke", {
Name = "RainbowBorder", Thickness = 2.2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
Color = Color3.new(1, 1, 1), Transparency = 0.02
}, cov)
addGrad(covStroke:FindFirstChildOfClass("UIGradient") or mk("UIGradient", { Color = RAINBOW }, covStroke))
if not top:GetAttribute("__SyncClickHooked") then
top:SetAttribute("__SyncClickHooked", true)
pcall(function()
local gs = game:GetService("GuiService")
gs.MenuOpened:Connect(function()
if isAlive() and top and top.Parent then top.Visible = false end
end)
gs.MenuClosed:Connect(function()
if isAlive() and top and top.Parent then top.Visible = true end
end)
end)
top.InputBegan:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
TweenService:Create(disc, TweenInfo.new(0.08, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = u2(0, 58, 0, 58) }):Play()
end
end)
top.InputEnded:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
State.CloseHideUntil = 0
TweenService:Create(disc, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = u2(0, 68, 0, 68) }):Play()
task.defer(function()
task.wait(0.03)
if State.SyncWindowFn then pcall(State.SyncWindowFn) end
end)
end
end)
end
end
-- KIẾN TRÚC MENU CHILLI HUB V7 SUPREME (HUY HIỆU TRÊN THANH MENU + NỀN 90615151648668 + CYBER NEON CARDS)
local SIDEBAR_PALETTE = { c3(37, 99, 235), c3(239, 68, 68), c3(245, 158, 11), c3(168, 85, 247), c3(236, 72, 153), c3(16, 185, 129) }
local function applySenaV7Architecture(win, titleLbl)
if not win or not titleLbl then return end
local hy, tx = titleLbl.AbsolutePosition.Y, titleLbl.AbsolutePosition.X
local winX, winY = win.AbsolutePosition.X, win.AbsolutePosition.Y
local bgFrames = {}
if win.BackgroundTransparency < 0.98 then table.insert(bgFrames, win) end
for _, d in ipairs(win:GetDescendants()) do
if d:IsA("GuiObject") and not d.Name:find("^Chilli") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
if d.AbsoluteSize.X >= win.AbsoluteSize.X * 0.55 and d.AbsoluteSize.Y >= win.AbsoluteSize.Y * 0.55 then
if d.BackgroundTransparency < 0.98 then table.insert(bgFrames, d) end
for _, st in ipairs(d:GetChildren()) do
if st:IsA("UIStroke") and st.Name ~= "ChilliProWindowStroke" then
st.Transparency = 1
st.Enabled = false
end
end
end
end
end
for _, st in ipairs(win:GetChildren()) do
if st:IsA("UIStroke") and st.Name ~= "ChilliProWindowStroke" then
st.Transparency = 1
st.Enabled = false
end
end
local mainBg = bgFrames[1] or win
pcall(function()
for _, bf in ipairs(bgFrames) do bf.BackgroundColor3 = c3(8, 10, 18) end
win.ClipsDescendants = true
end)
local strokeTarget = mainBg or win
local winStroke = strokeTarget:FindFirstChild("ChilliProWindowStroke") or win:FindFirstChild("ChilliProWindowStroke")
if not winStroke then
winStroke = mk("UIStroke", { Name = "ChilliProWindowStroke", Thickness = 2.4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.new(1, 1, 1), Transparency = 0.02 }, strokeTarget)
addGrad(mk("UIGradient", { Color = RAINBOW }, winStroke))
end
local wpParent = mainBg or win
local wp = wpParent:FindFirstChild("ChilliSenaWallpaper") or win:FindFirstChild("ChilliSenaWallpaper")
if not wp then
wp = mk("ImageLabel", {
Name = "ChilliSenaWallpaper", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5),
Size = u2s(1, 1), BackgroundColor3 = c3(6, 8, 14), BackgroundTransparency = 0.06,
Image = WALLPAPER_IMAGE_ID, ImageColor3 = Color3.new(1, 1, 1), ImageTransparency = 0.03,
ResampleMode = Enum.ResamplerMode.Default, ScaleType = Enum.ScaleType.Crop,
Active = false, Selectable = false, ZIndex = 0
}, wpParent)
mk("UICorner", { CornerRadius = UDim.new(0, 10) }, wp)
else
wp.Image = WALLPAPER_IMAGE_ID
wp.ImageColor3 = Color3.new(1, 1, 1)
wp.ImageTransparency = 0.03
wp.BackgroundColor3 = c3(6, 8, 14)
wp.BackgroundTransparency = 0.06
wp.ZIndex = 0
end
local pageWallpapers = { wp }
local sectionCards = {}
local curBaseOpacity = (mainBg.BackgroundTransparency < 0.95) and mainBg.BackgroundTransparency or 0.15
local function styleMenuInterior()
if not win or not win.Parent then return end
local cardT = 0.58
for _, d in ipairs(win:GetDescendants()) do
if not d:GetAttribute("__ChilliElemStyled") then
if d:IsA("ScrollingFrame") and (not d:FindFirstAncestorOfClass("ScrollingFrame")) and (d.AbsolutePosition.X - winX) > 35 and (d.AbsoluteSize.X >= win.AbsoluteSize.X * 0.50) and (d.AbsoluteSize.Y >= win.AbsoluteSize.Y * 0.40) then
d:SetAttribute("__ChilliElemStyled", true)
d.BackgroundTransparency = 1
d.ScrollingEnabled = true
if d.ZIndex < 3 then d.ZIndex = 3 end
local p = d.Parent
while p and p ~= win and p ~= mainBg do
if p:IsA("GuiObject") and p.AbsoluteSize.X >= win.AbsoluteSize.X * 0.42 and (p.AbsolutePosition.X - winX) > 28 then
p.BackgroundTransparency = 1
end
p = p.Parent
end
elseif d:IsA("Frame") and not d.Name:find("^Chilli") and not d:FindFirstAncestorOfClass("ScrollingFrame") and d ~= win and d ~= mainBg then
if d.AbsoluteSize.X >= win.AbsoluteSize.X * 0.48 and d.AbsoluteSize.Y >= win.AbsoluteSize.Y * 0.38 and (d.AbsolutePosition.X - winX) > 28 then
d:SetAttribute("__ChilliElemStyled", true)
d.BackgroundTransparency = 1
end
elseif d:IsA("Frame") and not d.Name:find("^Chilli") and d:FindFirstAncestorOfClass("ScrollingFrame") ~= nil and d.AbsoluteSize.X >= 145 and d.AbsoluteSize.Y >= 38 and d.BackgroundTransparency < 0.94 and d:FindFirstChildOfClass("UICorner") ~= nil then
d:SetAttribute("__IsChilliCard", true)
d:SetAttribute("__ChilliElemStyled", true)
d.BackgroundColor3 = c3(10, 12, 22)
d.BackgroundTransparency = cardT
table.insert(sectionCards, d)
end
end
end
end
local syncingOpacity = false
local function syncWallpaperAndOldBg(changedFrame)
if syncingOpacity or not wp or not wp.Parent then return end
syncingOpacity = true
local curT = curBaseOpacity
if changedFrame and changedFrame.Parent and changedFrame.BackgroundTransparency < 0.98 then
curT = changedFrame.BackgroundTransparency
elseif mainBg and mainBg.Parent and mainBg.BackgroundTransparency < 0.98 then
curT = mainBg.BackgroundTransparency
end
curBaseOpacity = curT
if mainBg and mainBg.Parent and mainBg.BackgroundTransparency < 0.98 then
mainBg.BackgroundTransparency = math.clamp(curT + 0.72, 0.88, 0.98)
end
for i = 2, #bgFrames do
local bf = bgFrames[i]
if bf and bf.Parent and bf ~= mainBg then
bf.BackgroundTransparency = 1
end
end
wp.ImageTransparency = math.clamp(0.03 + curT * 0.35, 0.02, 0.65)
wp.BackgroundTransparency = math.clamp(0.05 + curT * 0.40, 0.04, 0.70)
local cardT = math.clamp(0.54 + curT * 0.30, 0.50, 0.85)
for i = #sectionCards, 1, -1 do
local card = sectionCards[i]
if card and card.Parent then
card.BackgroundTransparency = cardT
else
table.remove(sectionCards, i)
end
end
syncingOpacity = false
end
pcall(styleMenuInterior)
for _, bf in ipairs(bgFrames) do
if not bf:GetAttribute("__WpSyncHooked") then
bf:SetAttribute("__WpSyncHooked", true)
bf:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function() syncWallpaperAndOldBg(bf) end)
end
end
pcall(syncWallpaperAndOldBg, nil)
-- GẮN HUY HIỆU 👑 ULTRA + ⚡ SUPREME + TELEMETRY TRỰC TIẾP TRÊN THANH MENU SCRIPT
pcall(function()
local oldCosmicHolder = win:FindFirstChild("ChilliCosmicHolder")
if oldCosmicHolder then oldCosmicHolder:Destroy() end
if not win:GetAttribute("__InteriorDescHooked") then
win:SetAttribute("__InteriorDescHooked", true)
local interiorPending = false
win.DescendantAdded:Connect(function(nd)
if not isAlive() or interiorPending or nd.Name:find("^Chilli") then return end
interiorPending = true
task.delay(0.35, function()
interiorPending = false
if isAlive() and win and win.Parent and win.Visible then
pcall(styleMenuInterior)
end
end)
end)
end
for _, desc in ipairs(win:GetDescendants()) do
if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and desc ~= titleLbl and not desc:IsDescendantOf(titleLbl) then
if math.abs(desc.AbsolutePosition.Y - hy) < 28 then
local dt = (desc.Text or ""):match("^%s*(.-)%s*$")
if dt:match("^v%d+%.%d+") or dt == "/" or dt:lower():find("steal an egg", 1, true) or dt:lower():find("cướp trứng", 1, true) then
desc.TextTransparency = 1
desc.BackgroundTransparency = 1
if desc.Parent and desc.Parent:IsA("Frame") and desc.Parent.AbsoluteSize.X < 90 and desc.Parent.AbsoluteSize.Y < 32 then
desc.Parent.BackgroundTransparency = 1
local st = desc.Parent:FindFirstChildOfClass("UIStroke")
if st then st.Transparency = 1 end
end
end
end
end
end
titleLbl.TextTransparency = 0
titleLbl.TextColor3 = Color3.new(1, 1, 1)
titleLbl.Font = Enum.Font.GothamBlack
if not titleLbl:FindFirstChild("TitleUltraGrad") then
addGrad(mk("UIGradient", { Name = "TitleUltraGrad", Color = ULTRA_TEXT_GRAD }, titleLbl))
end
if not titleLbl:FindFirstChildOfClass("UIStroke") then
mk("UIStroke", { Thickness = 1.3, Color = c3(10, 8, 20), Transparency = 0.2 }, titleLbl)
end
local hdrOverlay = wpParent:FindFirstChild("ChilliHeaderOverlay") or mk("Frame", {
Name = "ChilliHeaderOverlay", Position = u2(0, 0, 0, 0), Size = u2(1, 0, 0, 38),
BackgroundTransparency = 1, BorderSizePixel = 0, Active = false, ZIndex = 50
}, wpParent)
hdrOverlay.ZIndex = 50
if not hdrOverlay:FindFirstChild("ChilliHeaderRainbowLine") then
local hdrLine = mk("Frame", {
Name = "ChilliHeaderRainbowLine", AnchorPoint = v2(0.5, 1), Position = u2(0.5, 0, 1, 0),
Size = u2(1, 0, 0, 1.8), BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Active = false, ZIndex = 51
}, hdrOverlay)
addGrad(mk("UIGradient", { Color = RAINBOW }, hdrLine))
end
local oldBotBar = wpParent:FindFirstChild("ChilliSenaBottomBar") or win:FindFirstChild("ChilliSenaBottomBar")
if oldBotBar then oldBotBar:Destroy() end
local oldTele = hdrOverlay:FindFirstChild("ChilliSenaTopTelemetry")
if oldTele then oldTele:Destroy() end
local oldVip = hdrOverlay:FindFirstChild("ChilliVipBadgePill")
if oldVip then oldVip:Destroy() end
local function calcBadgeScaleX()
local hW = hdrOverlay.AbsoluteSize.X
local relScale = 0.252
if hW > 200 then
local rightPx = (titleLbl.AbsolutePosition.X - hdrOverlay.AbsolutePosition.X) + math.max(titleLbl.AbsoluteSize.X, titleLbl.TextBounds.X)
local calc = (rightPx / hW) + 0.018
if calc >= 0.248 and calc <= 0.42 then
relScale = calc
end
end
return relScale
end
local badgeScaleX = calcBadgeScaleX()
local ultraBadge = hdrOverlay:FindFirstChild("ChilliUltraBadgePill")
if not ultraBadge then
ultraBadge = mk("Frame", {
Name = "ChilliUltraBadgePill", AnchorPoint = v2(0, 0.5), Position = u2(badgeScaleX, 0, 0.5, 0),
Size = u2(0, 62, 0, 20), BackgroundColor3 = c3(22, 16, 38), BackgroundTransparency = 0.04,
BorderSizePixel = 0, Active = false, ZIndex = 55
}, hdrOverlay)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, ultraBadge)
local bStroke = mk("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Transparency = 0.05 }, ultraBadge)
addGrad(mk("UIGradient", { Color = RAINBOW }, bStroke))
mk("TextLabel", {
Name = "BadgeTxt", Size = u2s(1, 1), BackgroundTransparency = 1,
Font = Enum.Font.GothamBlack, TextSize = 9.5, TextColor3 = c3(255, 225, 85),
Text = "👑 ULTRA", Active = false, ZIndex = 56
}, ultraBadge)
else
ultraBadge.Position = u2(badgeScaleX, 0, 0.5, 0)
end
local telePill = hdrOverlay:FindFirstChild("ChilliCyberTelemetry")
if not telePill then
telePill = mk("Frame", {
Name = "ChilliCyberTelemetry", AnchorPoint = v2(0, 0.5), Position = u2(badgeScaleX + 0.105, 0, 0.5, 0),
Size = u2(0, 148, 0, 20), BackgroundColor3 = c3(14, 18, 32), BackgroundTransparency = 0.08,
BorderSizePixel = 0, Active = false, ZIndex = 55
}, hdrOverlay)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, telePill)
local tpStroke = mk("UIStroke", { Thickness = 1.2, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Transparency = 0.18 }, telePill)
addGrad(mk("UIGradient", { Color = ULTRA_CARD_GRAD }, tpStroke))
local teleLbl = mk("TextLabel", {
Name = "TeleTxt", Size = u2s(1, 1), BackgroundTransparency = 1,
Font = Enum.Font.GothamBold, TextSize = 9.0, TextColor3 = Color3.new(1, 1, 1),
Text = "⚡ 112 FPS • 📶 45ms • ⏱️ 00:00", Active = false, ZIndex = 56
}, telePill)
addGrad(mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, teleLbl))
end
State.TelemetryUpdateFn = function(fpsVal)
if telePill and telePill.Parent then
local tLbl = telePill:FindFirstChild("TeleTxt")
if tLbl then
local ping = 42
pcall(function()
ping = math.clamp(math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()), 12, 999)
end)
local el = math.max(0, math.floor(os.clock() - (State.StartClock or os.clock())))
local mm = math.floor(el / 60)
local ss = el % 60
tLbl.Text = string.format("⚡ %d FPS • 📶 %dms • ⏱️ %02d:%02d", fpsVal or getFakeFps(), ping, mm, ss)
end
end
end
pcall(State.TelemetryUpdateFn, getFakeFps())
if not titleLbl:GetAttribute("__BadgePosHooked") then
titleLbl:SetAttribute("__BadgePosHooked", true)
local function syncBadgePos()
local sx = calcBadgeScaleX()
if ultraBadge and ultraBadge.Parent then
ultraBadge.Position = u2(sx, 0, 0.5, 0)
end
if telePill and telePill.Parent then
telePill.Position = u2(sx + 0.105, 0, 0.5, 0)
end
end
titleLbl:GetPropertyChangedSignal("TextBounds"):Connect(syncBadgePos)
titleLbl:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncBadgePos)
task.delay(0.15, syncBadgePos)
end
end)
local function syncWindowVisibilityInstant()
if not win or not win.Parent then return end
local isOffscreen = (win.AbsolutePosition.X < -500 or win.AbsolutePosition.Y < -500)
local isSizeZero = (win.AbsoluteSize.X < 80 or win.AbsoluteSize.Y < 60)
local isForceClosing = (State.CloseHideUntil ~= nil) and (os.clock() < State.CloseHideUntil)
local isOpen = not ((not win.Visible) or isOffscreen or isSizeZero or isForceClosing)
if winStroke then
winStroke.Enabled = isOpen
winStroke.Transparency = isOpen and 0.02 or 1
end
local hOv = wpParent:FindFirstChild("ChilliHeaderOverlay")
if hOv then hOv.Visible = isOpen end
local bBar = wpParent:FindFirstChild("ChilliSenaBottomBar") or win:FindFirstChild("ChilliSenaBottomBar")
if bBar then bBar.Visible = isOpen end
for _, pw in ipairs(pageWallpapers) do if pw and pw.Parent then pw.Visible = isOpen end end
if titleLbl and titleLbl.Parent then titleLbl.TextTransparency = 0 end
end
State.SyncWindowFn = syncWindowVisibilityInstant
syncWindowVisibilityInstant()
if not win:GetAttribute("__InstantHideHooked") then
win:SetAttribute("__InstantHideHooked", true)
win:GetPropertyChangedSignal("Visible"):Connect(syncWindowVisibilityInstant)
win:GetPropertyChangedSignal("Size"):Connect(syncWindowVisibilityInstant)
win:GetPropertyChangedSignal("Position"):Connect(syncWindowVisibilityInstant)
for _, d in ipairs(win:GetDescendants()) do
if d:IsA("GuiObject") and math.abs(d.AbsolutePosition.Y - hy) < 30 then
local isTxtClose = (d:IsA("TextButton") or d:IsA("TextLabel")) and (d.Text == "-" or d.Text == "—")
local isRightEdgeBtn = (d:IsA("TextButton") or d:IsA("ImageButton")) and (d.AbsolutePosition.X > win.AbsolutePosition.X + win.AbsoluteSize.X - 45)
if isTxtClose or isRightEdgeBtn then
local btn = (d:IsA("TextButton") or d:IsA("ImageButton")) and d or d.Parent
if btn and (btn:IsA("TextButton") or btn:IsA("ImageButton")) and not btn:GetAttribute("__CloseSyncHooked") then
btn:SetAttribute("__CloseSyncHooked", true)
btn.MouseButton1Down:Connect(function()
State.CloseHideUntil = os.clock() + 0.42
if winStroke then winStroke.Enabled = false end
local hOv = wpParent:FindFirstChild("ChilliHeaderOverlay")
if hOv then hOv.Visible = false end
local bBar = wpParent:FindFirstChild("ChilliSenaBottomBar") or win:FindFirstChild("ChilliSenaBottomBar")
if bBar then bBar.Visible = false end
for _, pw in ipairs(pageWallpapers) do if pw and pw.Parent then pw.Visible = false end end
end)
end
end
end
end
end
pcall(function()
local navButtons = {}
for _, d in ipairs(win:GetDescendants()) do
if d:IsA("GuiObject") and (d.AbsolutePosition.X - winX) < 75 and d.AbsolutePosition.Y > hy + 15 then
local children = {}
for _, ch in ipairs(d:GetChildren()) do
if ch:IsA("GuiObject") and ch.AbsoluteSize.X >= 22 and ch.AbsoluteSize.X <= 65 and ch.AbsoluteSize.Y >= 22 and ch.AbsoluteSize.Y <= 65 then
ch.Visible = true
table.insert(children, ch)
end
end
if #children >= 5 and #children <= 8 then
if d.ZIndex < 15 then d.ZIndex = 15 end
for _, nb in ipairs(children) do
if nb.ZIndex < 16 then nb.ZIndex = 16 end
end
navButtons = children
break
end
end
end
if #navButtons >= 2 then
table.sort(navButtons, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)
State.SystemTabBtn = navButtons[6] or navButtons[#navButtons]
local TAB_NAMES = {
[1] = { title = "BẢNG ĐIỀU KHIỂN", icon = "🏠", sub = "HOME DASHBOARD" },
[2] = { title = "CƯỚP TRỨNG", icon = "🥚", sub = "AUTO STEAL & SNIPER" },
[3] = { title = "CÀY CUỐC & PET", icon = "🌾", sub = "AUTO FARM & PETS" },
[4] = { title = "SỰ KIỆN", icon = "✨", sub = "HALLOWEEN & EVENTS" },
[5] = { title = "NGƯỜI CHƠI", icon = "👤", sub = "PLAYER & ESP" },
[6] = { title = "HỆ THỐNG", icon = "⚙️", sub = "SYSTEM & CONFIG" }
}
local function showTabToast(idx, badgeColor)
local tabInfo = TAB_NAMES[idx] or { title = "TAB " .. tostring(idx), icon = "⚡", sub = "CHILLI HUB V7" }
local oldToast = win:FindFirstChild("ChilliTabToast")
if oldToast then oldToast:Destroy() end
local toast = mk("Frame", { Name = "ChilliTabToast", AnchorPoint = v2(0.5, 0), Position = u2(0.5, 20, 0, -32), Size = u2(0, 256, 0, 30), BackgroundColor3 = c3(14, 16, 28), BackgroundTransparency = 0.08, BorderSizePixel = 0, ClipsDescendants = true, Active = false, ZIndex = 1005 }, win)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, toast)
local tStroke = mk("UIStroke", { Thickness = 1.5, Color = badgeColor, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, toast)
addGrad(mk("UIGradient", { Color = RAINBOW }, tStroke))
local tLbl = mk("TextLabel", { Size = u2(1, 0, 1, 0), BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, TextSize = 11, TextColor3 = Color3.new(1, 1, 1), Text = tabInfo.icon .. "  " .. tabInfo.title .. "  •  " .. tabInfo.sub, Active = false, ZIndex = 1006 }, toast)
addGrad(mk("UIGradient", { Color = ULTRA_TEXT_GRAD }, tLbl))
TweenService:Create(toast, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = u2(0.5, 20, 0, 8) }):Play()
task.delay(1.3, function()
if toast and toast.Parent then
local outTween = TweenService:Create(toast, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = u2(0.5, 20, 0, -32), BackgroundTransparency = 1 })
TweenService:Create(tLbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
TweenService:Create(tStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 1 }):Play()
outTween:Play()
outTween.Completed:Connect(function() toast:Destroy() end)
end
end)
end
for idx, btn in ipairs(navButtons) do
local badgeColor = SIDEBAR_PALETTE[((idx - 1) % #SIDEBAR_PALETTE) + 1]
local squircle = btn:FindFirstChild("ChilliSenaSquircle")
if not squircle then
squircle = mk("Frame", { Name = "ChilliSenaSquircle", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2(0, 30, 0, 30), BackgroundColor3 = badgeColor, BackgroundTransparency = 0.12, BorderSizePixel = 0, Active = false, ZIndex = btn.ZIndex + 1 }, btn)
mk("UICorner", { CornerRadius = UDim.new(0, 8) }, squircle)
mk("UIStroke", { Thickness = 1, Color = Color3.new(1, 1, 1), Transparency = 0.55 }, squircle)
for _, ch in ipairs(btn:GetDescendants()) do
if ch ~= squircle and ch.Name ~= "ChilliStealTabIcon" then
if ch:IsA("ImageLabel") or ch:IsA("ImageButton") then
ch.ZIndex = squircle.ZIndex + 2
ch.ImageColor3 = Color3.new(1, 1, 1)
elseif ch:IsA("TextLabel") or ch:IsA("TextButton") then
ch.ZIndex = squircle.ZIndex + 2
ch.TextColor3 = Color3.new(1, 1, 1)
end
end
end
end
if idx == 2 then
for _, desc in ipairs(btn:GetDescendants()) do
if desc ~= squircle and desc.Name ~= "ChilliStealTabIcon" and not desc:IsA("UICorner") and not desc:IsA("UIStroke") then
if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
desc.ImageTransparency = 1
elseif desc:IsA("TextLabel") or desc:IsA("TextButton") then
desc:SetAttribute("__HiddenVxLogo", true)
desc.TextTransparency = 1
elseif desc:IsA("Frame") then
desc.BackgroundTransparency = 1
end
end
end
local stealIcon = btn:FindFirstChild("ChilliStealTabIcon") or mk("ImageLabel", { Name = "ChilliStealTabIcon", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(0.84, 0.84), BackgroundTransparency = 1, Image = STEAL_TAB_ICON_ID, ScaleType = Enum.ScaleType.Fit, Active = false, Selectable = false, ZIndex = squircle.ZIndex + 3 }, btn)
stealIcon.Image = STEAL_TAB_ICON_ID
stealIcon.Size = u2s(0.84, 0.84)
end
if not btn:GetAttribute("__TabEffectHooked") then
btn:SetAttribute("__TabEffectHooked", true)
local lastTabTrigger = 0
local function onTabTriggered()
local now = os.clock()
if now - lastTabTrigger < 0.15 then return end
lastTabTrigger = now
TweenService:Create(squircle, TweenInfo.new(0.07, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = u2(0, 25, 0, 25) }):Play()
task.delay(0.07, function()
TweenService:Create(squircle, TweenInfo.new(0.20, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = u2(0, 31, 0, 31) }):Play()
end)
task.delay(0.14, function()
if isAlive() and win and win.Visible then pcall(styleMenuInterior) end
end)
showTabToast(idx, badgeColor)
end
btn.InputBegan:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
onTabTriggered()
end
end)
end
end
end
end)
pcall(function()
for _, it in ipairs(win:GetDescendants()) do
if it ~= titleLbl and it:IsA("GuiObject") and not it.Name:find("^Chilli") and not it:IsDescendantOf(titleLbl) then
local p, s = it.AbsolutePosition, it.AbsoluteSize
if math.abs(p.Y - hy) < 28 and p.X < tx and (tx - p.X) < 55 and s.X >= 12 and s.X <= 42 and s.Y >= 12 and s.Y <= 42 then
local holder = (it:IsA("ImageLabel") or it:IsA("ImageButton")) and it or it.Parent
if it:IsA("TextLabel") or it:IsA("TextButton") then
it:SetAttribute("__HiddenVxLogo", true)
it.TextTransparency = 1
elseif it:IsA("ImageLabel") or it:IsA("ImageButton") then
it.ImageTransparency = 1
end
if holder and holder:IsA("GuiObject") then
holder.BackgroundTransparency = 1
local hBadge = holder:FindFirstChild("ChilliHeaderLogo")
if not hBadge then
hBadge = mk("Frame", { Name = "ChilliHeaderLogo", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2(0, 28, 0, 28), BackgroundColor3 = c3(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Active = false, ZIndex = 60 }, holder)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hBadge)
local hStroke = mk("UIStroke", { Thickness = 1.5, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, hBadge)
addGrad(mk("UIGradient", { Color = RAINBOW }, hStroke))
local hImg = mk("ImageLabel", { Name = "LogoImg", AnchorPoint = v2(0.5, 0.5), Position = u2s(0.5, 0.5), Size = u2s(1, 1), BackgroundTransparency = 1, Image = LOGO_ID, ScaleType = Enum.ScaleType.Crop, Active = false, ZIndex = 61 }, hBadge)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hImg)
else
hBadge.Size = u2(0, 28, 0, 28)
hBadge.BackgroundColor3 = c3(0, 0, 0)
local hImg = hBadge:FindFirstChildOfClass("ImageLabel")
if hImg then
hImg.Image = LOGO_ID
hImg.Size = u2s(1, 1)
hImg.ScaleType = Enum.ScaleType.Crop
if not hImg:FindFirstChildOfClass("UICorner") then mk("UICorner", { CornerRadius = UDim.new(1, 0) }, hImg) end
end
end
end
break
end
end
end
end)
end
local venyxGuiLocked = nil
local function patchVenyxGui(gui, titleLbl)
pcall(function() gui.Enabled = true end)
pcall(setupSafeTeleportHook)
if titleLbl.Text ~= NEW_TITLE then
titleLbl:SetAttribute("__IsTranslating", true)
titleLbl.Text = NEW_TITLE
titleLbl.AutomaticSize = Enum.AutomaticSize.X
titleLbl:SetAttribute("__IsTranslating", false)
end
local win, curr = nil, titleLbl
local cam = workspace.CurrentCamera
local vpX, vpY = (cam and cam.ViewportSize.X) or 1920, (cam and cam.ViewportSize.Y) or 1080
while curr.Parent and curr.Parent ~= gui do
curr = curr.Parent
if curr:IsA("GuiObject") and curr.AbsoluteSize.X >= 260 and curr.AbsoluteSize.Y >= 165 then
if curr.AbsoluteSize.X < vpX * 0.96 or curr.AbsoluteSize.Y < vpY * 0.96 then win = curr end
end
end
local hy = titleLbl.AbsolutePosition.Y
State.ActiveVenyxGui = gui
if win then
State.ActiveMainWin = win
pcall(cleanupStrayLogos, gui, win)
if win:GetAttribute("__ChilliV7ArchSession") ~= SID or not State.SystemTabBtn then
win:SetAttribute("__ChilliV7ArchSession", SID)
pcall(applySenaV7Architecture, win, titleLbl)
end
for _, tc in ipairs(gui:GetChildren()) do
if tc:IsA("GuiObject") and tc ~= win and tc.Name ~= "ChilliV5_ExpandedIsland" and not tc:FindFirstChild("IslandExpandHint") then
pcall(setupCircleLogo, tc, win)
end
end
end
pcall(function()
for _, ch in ipairs(gui:GetChildren()) do
if ch:FindFirstChild("IslandLogoBadge") and ch:FindFirstChildOfClass("TextBox") then
local tb = ch:FindFirstChildOfClass("TextBox")
tb:SetAttribute("__IslandDone", nil)
tb:SetAttribute("__IslandSession", nil)
tb.Text = ""
for _, sub in ipairs(ch:GetChildren()) do
if sub.Name == "IslandLogoBadge" or sub.Name == "IslandExpandHint" or sub.Name == "IslandStroke" then
sub:Destroy()
end
end
local hdrBar = titleLbl.Parent
if hdrBar and hdrBar:IsA("GuiObject") then
ch.Parent = hdrBar
ch.AnchorPoint = v2(1, 0.5)
ch.Position = u2(1, -42, 0.5, 0)
ch.Size = u2(0, 115, 0, 24)
ch.AutomaticSize = Enum.AutomaticSize.None
end
gui:SetAttribute("__IslandLocked", nil)
end
end
end)
local queue = {}
for _, d in ipairs(gui:GetDescendants()) do
if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
local txt = d.Text or ""
local hasDot = false
if d:IsA("TextLabel") and d.Parent and d.Parent:IsA("GuiObject") and d.Parent.AbsoluteSize.X < 320 and not d.Parent:FindFirstChildOfClass("TextBox") then
for _, sb in ipairs(d.Parent:GetChildren()) do
if sb:IsA("Frame") and sb.AbsoluteSize.X <= 14 and sb.AbsoluteSize.Y <= 14 then
hasDot = true
break
end
end
end
local isStatus = d:IsA("TextLabel") and (not isFpsTxt(txt)) and (not gui:GetAttribute("__IslandLocked")) and (not d:FindFirstAncestorOfClass("ScrollingFrame")) and d.Parent and (not d.Parent:FindFirstChildOfClass("TextBox")) and (not titleLbl:IsDescendantOf(d.Parent)) and math.abs(d.AbsolutePosition.Y - hy) < 35 and d.AbsolutePosition.X > titleLbl.AbsolutePosition.X + 60 and (hasDot or txt:lower():find("idle", 1, true) or txt == "Đang rảnh") and not txt:find("v1.", 1, true)
if isFpsTxt(txt) then
pcall(hookFps, d)
elseif isStatus or (d:IsA("TextLabel") and d:GetAttribute("__IslandDone")) then
gui:SetAttribute("__IslandLocked", true)
pcall(setupIsland, d, gui)
elseif d:GetAttribute("__TransHookSession") ~= SID then
queue[#queue + 1] = d
end
end
end
if #queue > 0 and not gui:GetAttribute("__BatchTranslating") then
gui:SetAttribute("__BatchTranslating", true)
task.spawn(function()
for i = 1, #queue do
if not isAlive() then break end
if queue[i] and queue[i].Parent then pcall(hookTrans, queue[i]) end
if i % 80 == 0 then task.wait() end
end
gui:SetAttribute("__BatchTranslating", false)
end)
end
return (win ~= nil and gui:GetAttribute("__IslandLocked") == true and State.SystemTabBtn ~= nil)
end
local function bindGuiEvents(gui)
if not gui:IsA("ScreenGui") or IGNORED_GUIS[gui.Name] or gui:GetAttribute("__ListenerSession") == SID then return end
gui:SetAttribute("__ListenerSession", SID)
gui.DescendantAdded:Connect(function(nd)
if not isAlive() then return end
if nd:IsA("TextLabel") or nd:IsA("TextButton") or nd:IsA("TextBox") then
if not nd:IsA("TextBox") then
local rawT = (nd.Text or ""):match("^%s*(.-)%s*$")
if rawT == "Vx" or rawT == "VX" then
nd:SetAttribute("__HiddenVxLogo", true)
nd.TextTransparency = 1
return
elseif rawT == "VENYX" and not nd:FindFirstAncestorOfClass("ScrollingFrame") then
nd:SetAttribute("__IsTranslating", true)
nd.Text = NEW_TITLE
nd:SetAttribute("__IsTranslating", false)
end
end
task.defer(function()
if not isAlive() or not nd or not nd.Parent then return end
if not nd:IsA("TextBox") and isFpsTxt(nd.Text) then pcall(hookFps, nd) else pcall(hookTrans, nd) end
end)
end
end)
end
local function scanOnce(forcePass)
if not isAlive() then return false end
if not forcePass and venyxGuiLocked and venyxGuiLocked.Parent and venyxGuiLocked:GetAttribute("__ChilliV7Patched") == SID then
return true
end
for _, root in ipairs(getScanRoots()) do
local guis = {}
for _, ch in ipairs(root:GetChildren()) do
if ch:IsA("ScreenGui") then
table.insert(guis, ch)
elseif ch:IsA("Folder") or ch:IsA("Configuration") then
for _, sub in ipairs(ch:GetChildren()) do
if sub:IsA("ScreenGui") then table.insert(guis, sub) end
end
end
end
for _, gui in ipairs(guis) do
if not IGNORED_GUIS[gui.Name] then
local titleLbl = nil
for _, d in ipairs(gui:GetDescendants()) do
if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Name ~= "ChilliUltraTitleBadge" and d.Name ~= "ChilliIslandTitle" and not d:FindFirstAncestor("ChilliV5_ExpandedIsland") and not d:FindFirstAncestor("ChilliHeaderOverlay") then
local t = (d.Text or ""):match("^%s*(.-)%s*$")
if t == "Vx" or t == "VX" then
d:SetAttribute("__HiddenVxLogo", true)
d.TextTransparency = 1
elseif isFpsTxt(t) then
pcall(hookFps, d)
elseif (t == "VENYX" or t == NEW_TITLE or t == "Chilli Hub Ultra" or t == "Chilli Hub V5" or t == "Chilli V5 |") and not d:FindFirstAncestorOfClass("ScrollingFrame") then
titleLbl = d
end
end
end
if titleLbl then
bindGuiEvents(gui)
local okDone, fullyPatched = pcall(patchVenyxGui, gui, titleLbl)
if okDone and fullyPatched then
venyxGuiLocked = gui
gui:SetAttribute("__ChilliV7Patched", SID)
end
break
end
end
end
if venyxGuiLocked then break end
end
return venyxGuiLocked ~= nil
end
for _, root in ipairs(getScanRoots()) do
root.DescendantAdded:Connect(function(ch)
if isAlive() and ch:IsA("ScreenGui") and not IGNORED_GUIS[ch.Name] then
bindGuiEvents(ch)
task.wait(0.15)
if isAlive() then pcall(scanOnce, true) end
end
end)
end
pcall(scanOnce)
task.spawn(function()
local t = 0
while isAlive() and not venyxGuiLocked and t < 60 do
task.wait(0.18)
t = t + 0.18
pcall(scanOnce, true)
end
if isAlive() then
task.wait(0.50)
pcall(scanOnce, true)
task.wait(1.00)
pcall(scanOnce, true)
end
end)
