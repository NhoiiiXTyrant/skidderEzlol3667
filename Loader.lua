-- NhoiiiX-SAE | Chilli Hub V7 loader
-- Uses the Chilli V7 source supplied by the user.
-- Old V5-specific Venyx hooks, fake-FPS patches, and teleport-queue overrides
-- are intentionally not carried over because they can break V7 compatibility.

local SOURCE_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"

local function startChilliV7()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    local ok, source = pcall(function()
        return game:HttpGet(SOURCE_URL)
    end)

    if not ok or type(source) ~= "string" or source == "" then
        warn("[NhoiiiX-SAE] Could not download Chilli Hub V7. Check the URL or connection.")
        return
    end

    local compileOk, chunk = pcall(function()
        return loadstring(source)
    end)

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
