-- NhoiiiX SAE - Chilli Hub V7 with a separate show/hide logo button
-- Note: GUI discovery is heuristic because the remote hub owns its internal UI.

local SOURCE_URL = "https://raw.githubusercontent.com/kairobloc/stealanegg/refs/heads/main/chillihubv7.lua"
local HUB_NAME = "NhoiiiX Hub"
local HUB_LOGO = "rbxassetid://75850663384500"

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

local function getUiRoot()
    local root
    pcall(function()
        if type(gethui) == "function" then root = gethui() end
    end)
    if root then return root end
    if lp then
        local pg = lp:FindFirstChildOfClass("PlayerGui")
        if pg then return pg end
    end
    return CoreGui
end

local function getRoots()
    local roots = {}
    local seen = {}
    local function add(root)
        if root and not seen[root] then
            seen[root] = true
            table.insert(roots, root)
        end
    end
    pcall(function() if type(gethui) == "function" then add(gethui()) end end)
    add(CoreGui)
    if lp then add(lp:FindFirstChildOfClass("PlayerGui")) end
    return roots
end

local function normalizeText(value)
    return string.lower((tostring(value or ""):gsub("%s+", " "):match("^%s*(.-)%s*$") or ""))
end

local function patchBranding(root)
    if not root then return end
    local descendants = {}
    pcall(function() descendants = root:GetDescendants() end)
    for _, inst in ipairs(descendants) do
        pcall(function()
            if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                local text = inst.Text
                local lower = normalizeText(text)
                if lower:find("chilli", 1, true) or lower:find("venyx", 1, true) then
                    if lower:find("chilli hub", 1, true) then
                        inst.Text = text:gsub("[Cc][Hh][Ii][Ll][Ll][Ii] [Hh][Uu][Bb]", HUB_NAME)
                    else
                        inst.Text = HUB_NAME
                    end
                end
            elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
                local image = tostring(inst.Image or "")
                local name = normalizeText(inst.Name)
                local parentName = normalizeText(inst.Parent and inst.Parent.Name or "")
                if image:find("94434236999817", 1, true)
                    or image:find("75850663384500", 1, true)
                    or name:find("logo", 1, true)
                    or name:find("brand", 1, true)
                    or name:find("chilli", 1, true)
                    or name:find("venyx", 1, true)
                    or parentName:find("logo", 1, true)
                    or parentName:find("brand", 1, true) then
                    inst.Image = HUB_LOGO
                    inst.ImageTransparency = 0
                end
            end
        end)
    end
end

-- Capture existing ScreenGuis before the remote hub loads, so the toggle can
-- target the GUI(s) created by this hub rather than hiding the whole game UI.
local baseline = {}
local function recordExistingScreenGuis()
    for _, root in ipairs(getRoots()) do
        pcall(function()
            for _, inst in ipairs(root:GetDescendants()) do
                if inst:IsA("ScreenGui") then baseline[inst] = true end
            end
        end)
    end
end

local hubGuis = {}
local function discoverHubGuis()
    for _, root in ipairs(getRoots()) do
        pcall(function()
            for _, inst in ipairs(root:GetDescendants()) do
                if inst:IsA("ScreenGui") and not baseline[inst] then
                    local name = normalizeText(inst.Name)
                    -- Exclude this toggle's own ScreenGui and common Roblox system GUIs.
                    if name ~= "nhoiiixhubtoggle" and name ~= "robloxgui" then
                        hubGuis[inst] = true
                    end
                end
            end
        end)
    end
end

local function createToggle()
    local root = getUiRoot()
    if not root then warn("[NhoiiiX SAE] Cannot find a UI root for the toggle button.") return end

    local old = root:FindFirstChild("NhoiiiXHubToggle")
    if old then old:Destroy() end

    local screen = Instance.new("ScreenGui")
    screen.Name = "NhoiiiXHubToggle"
    screen.ResetOnSpawn = false
    screen.IgnoreGuiInset = true
    screen.DisplayOrder = 1000000
    pcall(function() screen.Parent = root end)
    if not screen.Parent then
        pcall(function() screen.Parent = lp:WaitForChild("PlayerGui") end)
    end

    local button = Instance.new("ImageButton")
    button.Name = "ToggleButton"
    button.Size = UDim2.fromOffset(54, 54)
    button.Position = UDim2.new(0, 18, 0.5, -27)
    button.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    button.BackgroundTransparency = 0.12
    button.BorderSizePixel = 0
    button.Image = HUB_LOGO
    button.ImageTransparency = 0
    button.ScaleType = Enum.ScaleType.Fit
    button.AutoButtonColor = true
    button.ZIndex = 10
    button.Parent = screen

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = button
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(160, 90, 255)
    stroke.Parent = button

    local dragging, dragStart, startPos
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local visible = true
    button.Activated:Connect(function()
        discoverHubGuis()
        local changed = false
        for gui in pairs(hubGuis) do
            if gui and gui.Parent then
                pcall(function()
                    gui.Enabled = not visible
                    changed = true
                end)
            else
                hubGuis[gui] = nil
            end
        end
        visible = not visible
        if not changed then
            warn("[NhoiiiX SAE] No hub ScreenGui found yet; wait for the hub to finish loading and tap again.")
        end
    end)
end

local function main()
    if not game:IsLoaded() then game.Loaded:Wait() end
    recordExistingScreenGuis()

    -- Create the independent toggle immediately, so it remains available while the hub loads.
    createToggle()

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

    task.spawn(function()
        while task.wait(0.75) do
            discoverHubGuis()
            for _, root in ipairs(getRoots()) do patchBranding(root) end
        end
    end)

    local runOk, runError = pcall(chunk)
    if not runOk then warn("[NhoiiiX SAE] Chilli V7 startup error: " .. tostring(runError)) end
    for _, delayTime in ipairs({1, 2, 4, 7}) do
        task.delay(delayTime, function()
            discoverHubGuis()
            for _, root in ipairs(getRoots()) do patchBranding(root) end
        end)
    end
end

task.spawn(main)
