-- NhoiiiX | Heavyweight Fishing loader
-- Tai script goc tu link, doi ten -> NhoiiiX, doi logo -> 75850663384500, roi chay.

local SOURCE_URL = "https://raw.githubusercontent.com/NoahTyrant/StarCrow/refs/heads/main/Heavyweigh%20Fishing"
local NEW_NAME   = "NhoiiiX"
local NEW_LOGO   = "75850663384500"

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

-- 2) Doi logo: moi gan Image = "rbxassetid://..." / Icon = "rbxassetid://..."
local logoCount = 0
for _, key in ipairs({ "Image", "Icon" }) do
    local n
    src, n = src:gsub("(%f[%w]" .. key .. "%s*=%s*)([\"'])rbxassetid://%d+%2", "%1%2rbxassetid://" .. NEW_LOGO .. "%2")
    logoCount = logoCount + n
end

print(("[NhoiiiX] Da doi ten: %d cho | Da doi logo: %d cho"):format(nameCount, logoCount))

-- 3) Chay script
local fn, err = loadstring(src)
if not fn then
    warn("[NhoiiiX] Loi bien dich: " .. tostring(err))
    return
end
return fn()
