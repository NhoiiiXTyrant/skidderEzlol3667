-- NhoiiiX SAE - Chilli Hub V7 compatibility loader
-- NhoiiiX branding patch for Chilli Hub V7.

local SOURCE_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local HUB_NAME = "NhoiiiX Hub"
local HUB_LOGO = "rbxassetid://75850663384500"
local HUB_LOGO_ID = "75850663384500"

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local function getRoots()
    local roots = {}
    pcall(function()
        if gethui then
            local ui = gethui()
            if ui then table.insert(roots, ui) end
        end
    end)
    table.insert(roots, CoreGui)

    local player = Players.LocalPlayer
    if player then
        local pg = player:FindFirstChildOfClass("PlayerGui")
        if pg then table.insert(roots, pg) end
    end
    return roots
end

local function normalizeText(value)
    return string.lower((tostring(value or ""):gsub("%s+", " "):match("^%s*(.-)%s*$") or ""))
end

local function isBrandText(value)
    local lower = normalizeText(value)
    return lower == "venyx"
        or lower == "chilli"
        or lower == "chilli hub"
        or lower == "chilli hub v7"
        or lower == "chilli sae"
        or lower == "venyx sae"
        or lower == "chilli hub v5"
        or lower == "chilli hub v7 | sae"
        or lower == "chilli hub v7 - sae"
        or lower == "chilli hub | sae"
        or lower:find("chilli hub", 1, true) ~= nil
        or lower:find("venyx", 1, true) ~= nil
end

-- Logo IDs we know belong to Chilli/Venyx builds
local KNOWN_LOGO_IDS = {
    ["94434236999817"] = true,
    ["75850663384500"] = true, -- ours
}

local function isLogoName(name)
    return name == "logo"
        or name == "brand"
        or name == "icon"
        or name == "image"
        or name:find("logo", 1, true) ~= nil
        or name:find("brand", 1, true) ~= nil
        or name:find("icon", 1, true) ~= nil
        or name:find("chilli", 1, true) ~= nil
        or name:find("venyx", 1, true) ~= nil
end

local function patchInstance(inst)
    if not inst then return end
    pcall(function()
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            local current = inst.Text
            if type(current) == "string" and current ~= "" and isBrandText(current) then
                local replacement = current
                if normalizeText(current):find("chilli hub", 1, true) then
                    replacement = current:gsub("[Cc][Hh][Ii][Ll][Ll][Ii] [Hh][Uu][Bb]", HUB_NAME)
                else
                    replacement = HUB_NAME
                end
                inst.Text = replacement
            end
        elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
            local imageId = inst.Image
            if type(imageId) ~= "string" then return end
            if imageId:find(HUB_LOGO_ID, 1, true) then return end

            -- Extract numeric asset id from rbxassetid://NNN
            local assetId = imageId:match("(%d+)")
            local knownOldLogo = assetId and KNOWN_LOGO_IDS[assetId] ~= nil

            local name = normalizeText(inst.Name)
            local parentName = ""
            if inst.Parent then parentName = normalizeText(inst.Parent.Name) end

            local nameHit = isLogoName(name) or isLogoName(parentName)

            if knownOldLogo or nameHit then
                inst.Image = HUB_LOGO
                inst.ImageTransparency = 0
                inst.Visible = true
            end
        end
    end)
end

local function patchGui(root)
    if not root then return end
    patchInstance(root)
    local ok, descendants = pcall(function() return root:GetDescendants() end)
    if ok then
        for _, inst in ipairs(descendants) do
            patchInstance(inst)
        end
    end
end

-- Hook Instance.new so rebuilt UI (close/reopen) gets patched on birth
local function startCreationHook()
    local oldNew = Instance.new
    Instance.new = function(className, parent)
        local inst = oldNew(className, parent)
        task.defer(function()
            patchInstance(inst)
            local ok, desc = pcall(function() return inst:GetDescendants() end)
            if ok then
                for _, d in ipairs(desc) do patchInstance(d) end
            end
        end)
        return inst
    end

    local function hookRoot(root)
        if not root then return end
        pcall(function()
            root.DescendantAdded:Connect(function(inst)
                task.defer(function()
                    patchInstance(inst)
                    local ok, desc = pcall(function() return inst:GetDescendants() end)
                    if ok then
                        for _, d in ipairs(desc) do patchInstance(d) end
                    end
                end)
            end)
        end)
    end

    for _, root in ipairs(getRoots()) do
        hookRoot(root)
    end
end

local function startBrandingWatcher()
    task.spawn(function()
        while task.wait(0.5) do
            for _, root in ipairs(getRoots()) do
                patchGui(root)
            end
        end
    end)
end

local function main()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    local ok, source = pcall(function()
        return game:HttpGet(SOURCE_URL)
    end)
    if not ok or type(source) ~= "string" or source == "" then
        warn("[NhoiiiX SAE] Could not download Chilli V7. Check the URL or connection.")
        return
    end

    local compileOk, chunk = pcall(loadstring, source)
    if not compileOk or type(chunk) ~= "function" then
        warn("[NhoiiiX SAE] Chilli V7 could not be compiled by this executor.")
        return
    end

    startCreationHook()
    startBrandingWatcher()

    local runOk, runError = pcall(chunk)
    if not runOk then
        warn("[NhoiiiX SAE] Chilli V7 startup error: " .. tostring(runError))
    end

    task.delay(1, function()
        for _, root in ipairs(getRoots()) do
            patchGui(root)
        end
    end)
end

task.spawn(main)
