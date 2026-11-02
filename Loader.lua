-- NhoiiiX | Heavyweight Fishing loader (v2)
-- Tai script goc tu link, doi ten -> NhoiiiX, doi logo -> 75850663384500, roi chay.

local SOURCE_URL = "https://raw.githubusercontent.com/NoahTyrant/StarCrow/refs/heads/main/Heavyweigh%20Fishing"
local NEW_NAME   = "NhoiiiX"
local NEW_LOGO   = "75850663384500"
local DEBUG      = true   -- in ra console (F9) cac dong da doi / dong nghi ngo

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

-- 2) Doi logo theo tung dong
--    Doi moi tham chieu anh: rbxassetid://..., roblox.com/asset/?id=..., rbxthumb://...
--    Bo qua dong co Sound / Animation / so sanh (==, ~=) de khong lam hong script.
local lines = {}
for line in (src .. "\n"):gmatch("(.-)\n") do
    lines[#lines + 1] = line
end

local logoCount = 0
local changed, candidates = {}, {}

for i, line in ipairs(lines) do
    local lower = line:lower()
    local skip = lower:find("sound", 1, true)
        or lower:find("animation", 1, true)
        or line:find("==", 1, true)
        or line:find("~=", 1, true)
    local hit = false

    if not skip then
        local n1, n2, n3, n4 = 0, 0, 0, 0
        line, n1 = line:gsub("rbxassetid://%d+", "rbxassetid://" .. NEW_LOGO)
        line, n2 = line:gsub("(roblox%.com/asset/%?id=)%d+", "%1" .. NEW_LOGO)
        line, n3 = line:gsub("rbxthumb://[^\"'%s]+", "rbxassetid://" .. NEW_LOGO)
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
            changed[#changed + 1] = ("  L%d: %s"):format(i, (line:gsub("^%s+", "")):sub(1, 90))
        end
    elseif #candidates < 25
        and (lower:find("logo", 1, true) or lower:find("image", 1, true)
            or lower:find("icon", 1, true) or lower:find("getcustomasset", 1, true)) then
        candidates[#candidates + 1] = ("  L%d: %s"):format(i, (line:gsub("^%s+", "")):sub(1, 90))
    end
end

src = table.concat(lines, "\n")

print(("[NhoiiiX] Da doi ten: %d cho | Da doi logo: %d dong"):format(nameCount, logoCount))
if DEBUG then
    if #changed > 0 then
        print("[NhoiiiX] Cac dong logo da doi:")
        for _, l in ipairs(changed) do
            print(l)
        end
    end
    if #candidates > 0 then
        print("[NhoiiiX] Cac dong con lien quan toi anh/logo (chua doi):")
        for _, l in ipairs(candidates) do
            print(l)
        end
    end
end

-- 3) Chay script
local fn, err = loadstring(src)
if not fn then
    warn("[NhoiiiX] Loi bien dich: " .. tostring(err))
    return
end
return fn()
