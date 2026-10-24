-- NhoiiiX SAE - Chilli Hub V7 compatibility loader
-- NhoiiiX branding patch for Chilli Hub V7.
-- V5/Venyx-specific patching and teleport-queue hooks are not used because
-- they are tied to the old UI and may break Chilli V7.

local SOURCE_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local HUB_NAME = "NhoiiiX Hub"
local HUB_LOGO = "rbxassetid://75850663384500"

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

local function patchGui(root)
    if not root then return end

    local function patch(inst)
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            local ok, current = pcall(function() return inst.Text end)
            if ok and type(current) == "string" and current ~= "" and isBrandText(current) then
                local replacement = current
                if normalizeText(current):find("chilli hub", 1, true) then
                    replacement = current:gsub("[Cc][Hh][Ii][Ll][Ll][Ii] [Hh][Uu][Bb]", HUB_NAME)
                else
                    replacement = HUB_NAME
                end
                pcall(function() inst.Text = replacement end)
            end
        elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
            local ok, imageId = pcall(function() return inst.Image end)
            local name = normalizeText(inst.Name)
            local parentName = ""
            local ancestorNames = name
            pcall(function()
                local parent = inst.Parent
                if parent then
                    parentName = normalizeText(parent.Name)
                    ancestorNames = ancestorNames .. " " .. parentName
                    local ancestor = parent.Parent
                    local depth = 0
                    while ancestor and depth < 5 do
                        ancestorNames = ancestorNames .. " " .. normalizeText(ancestor.Name)
                        ancestor = ancestor.Parent
                        depth = depth + 1
                    end
                end
            end)

            -- Keep exit/close controls untouched.
            local controlName = ancestorNames
            local isExitControl = controlName:find("exit", 1, true)
                or controlName:find("close", 1, true)
                or controlName:find("leave", 1, true)
                or controlName:find("quit", 1, true)
                or controlName:find("disconnect", 1, true)
                or controlName:find("shutdown", 1, true)

            -- Hide the large centered NhoiiiX Studio watermark, without
            -- applying a broad size-only rule to ordinary feature images.
            local isWatermark = controlName:find("watermark", 1, true)
                or controlName:find("studio", 1, true)
                or controlName:find("nhoiiix", 1, true)
                or controlName:find("nhoiii", 1, true)

            -- Some versions name the central brand image generically. Detect
            -- only large, near-center images; avoid tiny icons and exit controls.
            local isLargeCenteredImage = false
            pcall(function()
                local size = inst.AbsoluteSize
                local pos = inst.AbsolutePosition
                local camera = workspace.CurrentCamera
                if camera and size and pos and camera.ViewportSize.X > 0 and camera.ViewportSize.Y > 0 then
                    local viewport = camera.ViewportSize
                    local centerX = pos.X + size.X / 2
                    local centerY = pos.Y + size.Y / 2
                    local centered = math.abs(centerX - viewport.X / 2) < viewport.X * 0.22
                        and math.abs(centerY - viewport.Y / 2) < viewport.Y * 0.22
                    local large = size.X > viewport.X * 0.18 and size.Y > viewport.Y * 0.12
                    isLargeCenteredImage = centered and large
                end
            end)

            if not isExitControl and (isWatermark or isLargeCenteredImage) then
                pcall(function()
                    inst.ImageTransparency = 1
                    inst.Visible = false
                end)
            else
                -- Replace only known branding/logo elements; do not touch
                -- unrelated images or exit controls.
                local knownOldLogo = ok and type(imageId) == "string" and (
                    imageId:find("75850663384500", 1, true)
                    or imageId:find("94434236999817", 1, true)
                )
                local namedLogo = name:find("logo", 1, true)
                    or name:find("brand", 1, true)
                    or name:find("chilli", 1, true)
                    or name:find("venyx", 1, true)
                    or parentName:find("logo", 1, true)
                    or parentName:find("brand", 1, true)

                if not isExitControl and (knownOldLogo or namedLogo) then
                    pcall(function()
                        inst.Image = HUB_LOGO
                        inst.ImageTransparency = 0
                        inst.Visible = true
                    end)
                end
            end
        end
    end

    pcall(patch, root)
    local ok, descendants = pcall(function() return root:GetDescendants() end)
    if ok then
        for _, inst in ipairs(descendants) do
            pcall(patch, inst)
        end
    end
end

local function startBrandingWatcher()
    task.spawn(function()
        while task.wait(0.75) do
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

    -- Start watching before the UI is created so late-created elements are patched too.
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
