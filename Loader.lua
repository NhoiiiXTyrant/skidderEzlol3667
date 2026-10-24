-- NhoiiiX-SAE | Chilli Hub V7 loader
-- Loads the user's Chilli V7 source and repeatedly renames visible UI text
-- that contains "Chilli" to "NhoiiiX Hub".

local SOURCE_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local NEW_NAME = "NhoiiiX Hub"

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local function renameText(root)
    if not root then return end

    local function patch(obj)
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local ok, current = pcall(function() return obj.Text end)
            if ok and type(current) == "string" and current ~= "" then
                if string.find(string.lower(current), "chilli", 1, true) then
                    pcall(function() obj.Text = NEW_NAME end)
                end
            end
        end
    end

    pcall(patch, root)
    for _, obj in ipairs(root:GetDescendants()) do
        pcall(patch, obj)
    end
end

local function startRenameWatcher()
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                renameText(CoreGui)
                local player = Players.LocalPlayer
                if player then renameText(player:FindFirstChildOfClass("PlayerGui")) end
            end)
        end
    end)
end

local function startChilliV7()
    if not game:IsLoaded() then game.Loaded:Wait() end
    startRenameWatcher()

    local ok, source = pcall(function() return game:HttpGet(SOURCE_URL) end)
    if not ok or type(source) ~= "string" or source == "" then
        warn("[NhoiiiX-SAE] Could not download Chilli Hub V7. Check the URL or connection.")
        return
    end

    local compileOk, chunk = pcall(function() return loadstring(source) end)
    if not compileOk or type(chunk) ~= "function" then
        warn("[NhoiiiX-SAE] Chilli Hub V7 source could not be compiled by this executor.")
        return
    end

    local runOk, runErr = pcall(chunk)
    if not runOk then
        warn("[NhoiiiX-SAE] Chilli Hub V7 failed to start: " .. tostring(runErr))
    end
end

task.spawn(startChilliV7)
