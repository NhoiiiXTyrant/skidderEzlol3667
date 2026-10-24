-- NhoiiiX SAE - Chilli Hub V7 loader with a standalone logo toggle
-- The logo button is created independently so it can still appear if Chilli V7
-- uses a different internal logo/UI structure.

local SOURCE_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local HUB_NAME = "NhoiiiX Hub"
local HUB_LOGO = "rbxassetid://70895505430795"

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local function getUiParent()
    local parent
    pcall(function()
        if gethui then parent = gethui() end
    end)
    if parent then return parent end
    if CoreGui then return CoreGui end
    local playerGui = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
    return playerGui
end

local function getRoots()
    local roots = {}
    local parent = getUiParent()
    if parent then table.insert(roots, parent) end
    if CoreGui and parent ~= CoreGui then table.insert(roots, CoreGui) end
    local playerGui = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if playerGui and playerGui ~= parent then table.insert(roots, playerGui) end
    return roots
end

local function patchGui(root)
    if not root then return end
    local function patch(inst)
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            local ok, current = pcall(function() return inst.Text end)
            if ok and type(current) == "string" and current ~= "" then
                local lower = string.lower(current)
                if lower == "venyx" or lower == "chilli" or lower == "chilli hub"
                    or lower == "chilli hub v7" or lower == "chilli sae" or lower == "venyx sae"
                    or lower == "chilli hub v5" or lower == "chilli hub v7 | sae" then
                    pcall(function() inst.Text = HUB_NAME end)
                elseif lower:find("chilli hub", 1, true) then
                    pcall(function()
                        inst.Text = current:gsub("[Cc][Hh][Ii][Ll][Ll][Ii] [Hh][Uu][Bb]", HUB_NAME)
                    end)
                end
            end
        elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
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
        for _, inst in ipairs(descendants) do pcall(patch, inst) end
    end
end

-- Track ScreenGuis created by the hub so the logo can hide/show the hub UI.
local knownGuis = {}
local hubGuis = {}
local function scanGuis(ownGui)
    for _, root in ipairs(getRoots()) do
        local ok, descendants = pcall(function() return root:GetDescendants() end)
        if ok then
            for _, inst in ipairs(descendants) do
                if inst:IsA("ScreenGui") and inst ~= ownGui then
                    if not knownGuis[inst] then
                        knownGuis[inst] = true
                        local name = string.lower(inst.Name)
                        if name:find("chilli", 1, true) or name:find("venyx", 1, true)
                            or name:find("hub", 1, true) or name:find("sae", 1, true) then
                            hubGuis[inst] = true
                        end
                    end
                end
            end
        end
    end
end

local function createLogoButton()
    local parent = getUiParent()
    if not parent then
        warn("[NhoiiiX SAE] Cannot create logo button: no GUI parent is available.")
        return nil
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "NhoiiiXHubLogoToggle"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999999
    pcall(function() gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling end)

    local button = Instance.new("ImageButton")
    button.Name = "NhoiiiXHubLogo"
    button.Size = UDim2.fromOffset(54, 54)
    button.Position = UDim2.new(0, 16, 0.5, -27)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.Image = HUB_LOGO
    button.ScaleType = Enum.ScaleType.Fit
    button.AutoButtonColor = true
    button.Visible = true
    button.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Transparency = 0.15
    stroke.Parent = button

    gui.Parent = parent

    button.Activated:Connect(function()
        scanGuis(gui)
        local hasTargets = false
        for target in pairs(hubGuis) do
            if target and target.Parent then
                hasTargets = true
                pcall(function() target.Enabled = not target.Enabled end)
            else
                hubGuis[target] = nil
            end
        end
        if not hasTargets then
            warn("[NhoiiiX SAE] Hub UI was not detected yet. Wait until Chilli V7 finishes loading, then tap the logo again.")
        end
    end)

    return gui
end

local function main()
    if not game:IsLoaded() then game.Loaded:Wait() end

    -- Remember existing ScreenGuis before loading the hub.
    for _, root in ipairs(getRoots()) do
        local ok, descendants = pcall(function() return root:GetDescendants() end)
        if ok then
            for _, inst in ipairs(descendants) do
                if inst:IsA("ScreenGui") then knownGuis[inst] = true end
            end
        end
    end

    local logoGui = createLogoButton()

    task.spawn(function()
        while task.wait(0.75) do
            for _, root in ipairs(getRoots()) do patchGui(root) end
            scanGuis(logoGui)
        end
    end)

    local ok, source = pcall(function() return game:HttpGet(SOURCE_URL) end)
    if not ok or type(source) ~= "string" or source == "" then
        warn("[NhoiiiX SAE] Could not download Chilli V7. Check the URL or connection.")
        return
    end

    local compileOk, chunk = pcall(loadstring, source)
    if not compileOk or type(chunk) ~= "function" then
        warn("[NhoiiiX SAE] Chilli V7 could not be compiled by this executor.")
        return
    end

    local runOk, runError = pcall(chunk)
    if not runOk then warn("[NhoiiiX SAE] Chilli V7 startup error: " .. tostring(runError)) end

    task.delay(2, function()
        scanGuis(logoGui)
        for _, root in ipairs(getRoots()) do patchGui(root) end
    end)
end

task.spawn(main)
