-- NhoiiiX SAE - Chilli Hub V7 compatibility loader
-- Based on the uploaded NhoiiiX-SAE file, adapted for the user's Chilli V7 URL.
-- V5/Venyx-specific patching and teleport-queue hooks are not used because
-- they are tied to the old UI and may break Chilli V7.

local SOURCE_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local HUB_NAME = "NhoiiiX Hub"
local HUB_LOGO = "rbxassetid://70895505430795"

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

local function patchGui(root)
    if not root then return end

    local function patch(inst)
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            local ok, current = pcall(function() return inst.Text end)
            if ok and type(current) == "string" and current ~= "" then
                local lower = string.lower(current)
                -- Only rename likely hub branding; do not alter normal feature labels.
                if lower == "venyx"
                    or lower == "chilli"
                    or lower == "chilli hub"
                    or lower == "chilli hub v7"
                    or lower == "chilli sae"
                    or lower == "venyx sae"
                    or lower == "chilli hub v5"
                    or lower == "chilli hub v7 | sae" then
                    pcall(function() inst.Text = HUB_NAME end)
                elseif lower:find("chilli hub", 1, true) then
                    pcall(function()
                        inst.Text = current:gsub("[Cc][Hh][Ii][Ll][Ll][Ii] [Hh][Uu][Bb]", HUB_NAME)
                    end)
                end
            end
        elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
            -- Replace only images whose asset id matches the old logo used by the uploaded file.
            local ok, imageId = pcall(function() return inst.Image end)
            if ok and type(imageId) == "string"
                and (imageId:find("75850663384500", 1, true)
                or imageId:find("94434236999817", 1, true)) then
                pcall(function() inst.Image = HUB_LOGO end)
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
