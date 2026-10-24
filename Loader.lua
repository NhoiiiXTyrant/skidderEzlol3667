-- NhoiiiX Hub - Chilli V7 branding loader
-- Keeps Chilli V7 as the UI source and applies the requested title/logo at runtime.

local SOURCE_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local HUB_NAME = "NhoiiiX Hub"
local HUB_LOGO = "rbxassetid://70895505430795"

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local BRAND_ATTR = "__NhoiiiXBrandPatched"

local function getRoots()
    local roots, seen = {}, {}
    local function add(root)
        if root and not seen[root] then
            seen[root] = true
            table.insert(roots, root)
        end
    end
    pcall(function()
        if type(gethui) == "function" then add(gethui()) end
    end)
    add(CoreGui)
    pcall(function()
        local player = Players.LocalPlayer
        if player then add(player:FindFirstChildOfClass("PlayerGui")) end
    end)
    return roots
end

local function safeText(inst)
    local ok, value = pcall(function() return inst.Text end)
    return ok and type(value) == "string" and value or nil
end

local function hasBrandText(root)
    local ok, descendants = pcall(function() return root:GetDescendants() end)
    if not ok then return false end
    for _, item in ipairs(descendants) do
        if item:IsA("TextLabel") or item:IsA("TextButton") then
            local value = safeText(item)
            if value then
                local lower = string.lower(value)
                if lower:find("chilli", 1, true) or lower:find("venyx", 1, true) then
                    return true
                end
            end
        end
    end
    return false
end

local function patchText(inst)
    local current = safeText(inst)
    if not current or current == "" then return end
    local lower = string.lower(current)
    local exact = {
        ["venyx"] = true,
        ["venyx hub"] = true,
        ["venyx sae"] = true,
        ["chilli"] = true,
        ["chilli hub"] = true,
        ["chilli hub v5"] = true,
        ["chilli hub v7"] = true,
        ["chilli hub v7 | sae"] = true,
        ["chilli sae"] = true,
    }
    if exact[lower] then
        pcall(function() inst.Text = HUB_NAME end)
    elseif lower:find("chilli hub", 1, true) then
        local replaced = current:gsub("[Cc][Hh][Ii][Ll][Ll][Ii] [Hh][Uu][Bb]", HUB_NAME)
        pcall(function() inst.Text = replaced end)
    elseif lower:find("venyx hub", 1, true) then
        local replaced = current:gsub("[Vv][Ee][Nn][Yy][Xx] [Hh][Uu][Bb]", HUB_NAME)
        pcall(function() inst.Text = replaced end)
    end
end

local function patchImage(inst, brandedRoot)
    local ok, imageId = pcall(function() return inst.Image end)
    if not ok or type(imageId) ~= "string" then return end
    local lowerName = string.lower(inst.Name or "")
    local oldLogo = imageId:find("75850663384500", 1, true)
        or imageId:find("94434236999817", 1, true)
    local namedLogo = lowerName:find("logo", 1, true)
        or lowerName:find("branding", 1, true)
        or lowerName == "brand"
    -- Avoid changing normal tab/action icons: only replace known old IDs or
    -- image objects explicitly named as a logo inside a Chilli/Venyx UI.
    if oldLogo or (brandedRoot and namedLogo) then
        if imageId ~= HUB_LOGO then
            pcall(function() inst.Image = HUB_LOGO end)
        end
    end
end

local function patchGui(root)
    if not root then return end
    local branded = hasBrandText(root)
    local function patch(inst)
        pcall(function()
            if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                patchText(inst)
            elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
                patchImage(inst, branded)
            end
        end)
    end
    patch(root)
    local ok, descendants = pcall(function() return root:GetDescendants() end)
    if ok then
        for _, inst in ipairs(descendants) do patch(inst) end
    end
end

local function startBrandingWatcher()
    task.spawn(function()
        while task.wait(0.5) do
            for _, root in ipairs(getRoots()) do patchGui(root) end
        end
    end)
end

local function main()
    if not game:IsLoaded() then game.Loaded:Wait() end

    if type(loadstring) ~= "function" then
        warn("[NhoiiiX Hub] Executor không hỗ trợ loadstring.")
        return
    end

    local ok, source = pcall(function()
        return game:HttpGet(SOURCE_URL)
    end)
    if not ok or type(source) ~= "string" or source == "" then
        warn("[NhoiiiX Hub] Không tải được Chilli V7. Hãy kiểm tra URL/kết nối.")
        return
    end

    local compileOk, chunk = pcall(function() return loadstring(source) end)
    if not compileOk or type(chunk) ~= "function" then
        warn("[NhoiiiX Hub] Không biên dịch được Chilli V7 trong executor này.")
        return
    end

    -- Watch before startup so UI elements created asynchronously are also patched.
    startBrandingWatcher()
    local runOk, runError = pcall(chunk)
    if not runOk then
        warn("[NhoiiiX Hub] Lỗi khi khởi chạy Chilli V7: " .. tostring(runError))
    end

    for delay = 0.25, 3, 0.25 do
        task.delay(delay, function()
            for _, root in ipairs(getRoots()) do patchGui(root) end
        end)
    end
end

task.spawn(main)
