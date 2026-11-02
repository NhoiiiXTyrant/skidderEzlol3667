-- NhoiiiX | Heavyweight Fishing loader (v3)
-- Tai script goc tu link, doi ten -> NhoiiiX, doi logo -> 75850663384500, roi chay.

local LOADER_VERSION = "v3"
local SOURCE_URL   = "https://raw.githubusercontent.com/NoahTyrant/StarCrow/refs/heads/main/Heavyweigh%20Fishing"
local NEW_NAME     = "NhoiiiX"
local NEW_LOGO     = "75850663384500"
local NEW_LOGO_URL = "rbxassetid://" .. NEW_LOGO
local DEBUG        = false   -- in ra console cac dong da doi / dong nghi ngo

print("[NhoiiiX] Loader " .. LOADER_VERSION)

local CoreGui = game:GetService("CoreGui")

local function getGuiRoots()
    local roots = {}
    if gethui then
        local okH, h = pcall(gethui)
        if okH and h then
            roots[#roots + 1] = h
        end
    end
    roots[#roots + 1] = CoreGui
    return roots
end

-- chup lai GUI dang co (cua Roblox / executor) truoc khi chay script goc
local existingGuis = {}
for _, root in ipairs(getGuiRoots()) do
    for _, child in ipairs(root:GetChildren()) do
        existingGuis[child] = true
    end
end

local ok, src = pcall(function()
    return game:HttpGet(SOURCE_URL)
end)
if not ok or type(src) ~= "string" or #src < 100 then
    warn("[NhoiiiX] Khong tai duoc script goc: " .. tostring(src))
    return
end

-- thay chuoi thuong (khong dung pattern), tra ve (chuoi moi, so lan thay)
local function replacePlain(s, old, new)
    local out, count, i = {}, 0, 1
    while true do
        local a, b = string.find(s, old, i, true)
        if not a then
            break
        end
        out[#out + 1] = string.sub(s, i, a - 1)
        out[#out + 1] = new
        i = b + 1
        count = count + 1
    end
    out[#out + 1] = string.sub(s, i)
    return table.concat(out), count
end

-- 1) Doi ten (cum dai truoc, cum ngan sau)
local nameMap = {
    { "STARCROW HUB", string.upper(NEW_NAME) },
    { "StarCrow Hub", NEW_NAME },
    { "Starcrow Hub", NEW_NAME },
    { "StarCrowHub",  NEW_NAME },
    { "Star Crow",    NEW_NAME },
    { "STARCROW",     string.upper(NEW_NAME) },
    { "StarCrow",     NEW_NAME },
    { "Starcrow",     NEW_NAME },
}
local nameCount = 0
for _, pair in ipairs(nameMap) do
    local n
    src, n = replacePlain(src, pair[1], pair[2])
    nameCount = nameCount + n
end

-- 2) Doi logo trong ma nguon, theo tung dong
--    Doi moi tham chieu anh: rbxassetid://..., roblox.com/asset/?id=..., rbxthumb://...
--    Bo qua dong co Sound / Animation / so sanh (==, ~=) de khong lam hong script.
local lines = {}
for line in (src .. "\n"):gmatch("(.-)\n") do
    lines[#lines + 1] = line
end

local logoCount = 0
local changed, strong, weak = {}, {}, {}

local function short(i, line)
    return ("L%d: %s"):format(i, (line:gsub("^%s+", "")):sub(1, 110))
end

for i, line in ipairs(lines) do
    local lower = line:lower()
    local isSound = lower:find("sound", 1, true)
    local skip = isSound
        or lower:find("animation", 1, true)
        or line:find("==", 1, true)
        or line:find("~=", 1, true)
    local hit = false

    if not skip then
        local n1, n2, n3, n4 = 0, 0, 0, 0
        line, n1 = line:gsub("rbxassetid://%d+", NEW_LOGO_URL)
        line, n2 = line:gsub("(roblox%.com/asset/%?id=)%d+", "%1" .. NEW_LOGO)
        line, n3 = line:gsub("rbxthumb://[^\"'%s]+", NEW_LOGO_URL)
        if lower:find("logo", 1, true) then
            -- dong kieu: Logo = 123456789012,
            line, n4 = line:gsub("(=%s*)%d%d%d%d%d%d%d%d+(%s*[,;]?%s*)$", "%1" .. NEW_LOGO .. "%2")
        end
        hit = (n1 + n2 + n3 + n4) > 0
        if hit then
            lines[i] = line
        end
    end

    if hit then
        logoCount = logoCount + 1
        if #changed < 15 then
            changed[#changed + 1] = short(i, line)
        end
    elseif not isSound then
        if (lower:find("logo", 1, true) or lower:find("getcustomasset", 1, true)
            or lower:find("rbxasset", 1, true) or lower:find(".png", 1, true)
            or lower:find(".jpg", 1, true) or lower:find("writefile", 1, true))
            and #strong < 40 then
            strong[#strong + 1] = short(i, line)
        elseif (lower:find('instance.new("image', 1, true) or lower:find("image%s*="))
            and #weak < 20 then
            weak[#weak + 1] = short(i, line)
        end
    end
end

src = table.concat(lines, "\n")

print(("[NhoiiiX] Da doi ten: %d cho | Da doi logo trong ma nguon: %d dong | Tong so dong script: %d"):format(
    nameCount, logoCount, #lines))

if DEBUG then
    if #changed > 0 then
        print("[NhoiiiX] Cac dong logo da doi:")
        for _, l in ipairs(changed) do
            print("  " .. l)
        end
    end
end

-- Neu khong thay dong logo nao: copy cac dong nghi ngo vao clipboard de gui lai cho Claude
if logoCount == 0 then
    local report = { "== Dong nghi ngo lien quan toi logo/anh ==" }
    for _, l in ipairs(strong) do
        report[#report + 1] = l
    end
    for _, l in ipairs(weak) do
        report[#report + 1] = l
    end
    print("[NhoiiiX] Khong thay dong logo nao trong ma nguon.")
    local copied = false
    if setclipboard then
        copied = pcall(setclipboard, table.concat(report, "\n"))
    end
    if copied then
        print("[NhoiiiX] Da copy cac dong nghi ngo vao clipboard - dan vao chat gui cho Claude.")
    elseif DEBUG then
        for _, l in ipairs(report) do
            print("  " .. l)
        end
    end
end

-- 3) Du phong luc chay: doi cac anh "giong logo" trong GUI cua script
--    (anh vuong 24-160px, khong phai sprite icon / bong do / nen)
local printed = {}

local function isLogoLike(d)
    if not (d:IsA("ImageLabel") or d:IsA("ImageButton")) then
        return false
    end
    if d.Image == "" or d.Image == NEW_LOGO_URL then
        return false
    end
    if d.ImageRectSize.Magnitude > 0 then
        return false
    end
    if d.ScaleType == Enum.ScaleType.Slice or d.ScaleType == Enum.ScaleType.Tile then
        return false
    end
    if d.ImageTransparency > 0.9 then
        return false
    end
    local s = d.AbsoluteSize
    if s.X < 24 or s.X > 160 or s.Y < 24 or s.Y > 160 then
        return false
    end
    local ratio = s.X / s.Y
    return ratio > 0.7 and ratio < 1.43
end

local function patchLogoLikeImages()
    for _, root in ipairs(getGuiRoots()) do
        for _, gui in ipairs(root:GetChildren()) do
            if gui:IsA("ScreenGui") and not existingGuis[gui] then
                for _, d in ipairs(gui:GetDescendants()) do
                    local okL, like = pcall(isLogoLike, d)
                    if okL and like then
                        pcall(function()
                            d.Image = NEW_LOGO_URL
                        end)
                        if not printed[d] then
                            printed[d] = true
                            print("[NhoiiiX] (luc chay) da doi logo: " .. d:GetFullName())
                        end
                    end
                end
            end
        end
    end
end

task.spawn(function()
    for _ = 1, 40 do
        task.wait(1.5)
        pcall(patchLogoLikeImages)
    end
end)

-- 4) Chay script
local fn, err = loadstring(src)
if not fn then
    warn("[NhoiiiX] Loi bien dich: " .. tostring(err))
    return
end
return fn()
