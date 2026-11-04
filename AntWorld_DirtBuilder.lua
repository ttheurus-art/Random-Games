local Zynz = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/ttheurus-art/Creator/refs/heads/main/Zynz.luau"
))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local Window = Zynz:CreateWindow({
    Name = "Ant World",
    MainTabTheme = "Modern"
})

local MainTab = Window:CreateTab({Name = "Main"})
local BuilderTab = Window:CreateTab({Name = "Dirt Builder"})
local EspTab = Window:CreateTab({Name = "Esp"})

local function getCharacterParts()
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    return character, root
end

local function getRemote(folderName)
    local character = LocalPlayer.Character
    local folder = character and character:FindFirstChild(folderName)
    return folder and folder:FindFirstChild("RemoteEvent")
end

-- MAIN: GET DIRT
local GetDirtEnabled = false
MainTab:CreateToggle({
    Name = "Get Dirt",
    CurrentValue = false,
    Callback = function(value)
        GetDirtEnabled = value
        if value then
            task.spawn(function()
                while GetDirtEnabled do
                    local _, root = getCharacterParts()
                    local remote = getRemote("Dig")
                    if root and remote then
                        remote:FireServer(root.Position)
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- MAIN: GET HATCH
local GetHatchEnabled = false
MainTab:CreateToggle({
    Name = "Get Hatch (Egg)",
    CurrentValue = false,
    Callback = function(value)
        GetHatchEnabled = value
        if value then
            task.spawn(function()
                while GetHatchEnabled do
                    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                    local larvaeUI = playerGui and playerGui:FindFirstChild("MainLarvaeui")
                    local frame = larvaeUI and larvaeUI:FindFirstChild("Frame")
                    local innerFrame = frame and frame:FindFirstChild("Frame")
                    local play = innerFrame and innerFrame:FindFirstChild("Play")
                    local remote = play and play:FindFirstChild("ForcePlay")
                    if remote then
                        remote:FireServer("FOODNOW!")
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- DIRT BUILDER SETTINGS
local BuildMode = "Straight"
local UpDown = 0
local LeftRight = 0
local FrontBack = 6
local BuildCount = 5
local PreviewEnabled = true
local IsPlacing = false
local PLACE_INTERVAL = 0.7
local PreviewParts = {}
local CurrentPositions = {}

local PreviewFolder = Instance.new("Folder")
PreviewFolder.Name = "AntWorld_DirtPreview"
PreviewFolder.Parent = workspace

local function clearPreview()
    for _, part in ipairs(PreviewParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    table.clear(PreviewParts)
end

local function getBaseCFrame()
    local _, root = getCharacterParts()
    return root and root.CFrame or nil
end

local function makeBuildPositions(base)
    local positions = {}
    local origin = base.Position
    local right = base.RightVector
    local forward = base.LookVector
    local up = Vector3.new(0, 1, 0)
    local offset = right * LeftRight + up * UpDown + forward * FrontBack
    local count = math.clamp(math.floor(BuildCount), 1, 25)
    local start = origin + offset

    if BuildMode == "Straight" then
        for i = 0, count - 1 do
            table.insert(positions, start + forward * (i * 4))
        end
    elseif BuildMode == "Straight Up" then
        for i = 0, count - 1 do
            table.insert(positions, start + up * (i * 4))
        end
    elseif BuildMode == "Straight Down" then
        for i = 0, count - 1 do
            table.insert(positions, start - up * (i * 4))
        end
    elseif BuildMode == "Vertical Up" then
        for i = 0, count - 1 do
            table.insert(positions, start + Vector3.new(0, i * 4, 0))
        end
    elseif BuildMode == "Vertical Down" then
        for i = 0, count - 1 do
            table.insert(positions, start - Vector3.new(0, i * 4, 0))
        end
    elseif BuildMode == "Square" then
        local side = math.max(1, math.ceil(math.sqrt(count)))
        for i = 0, count - 1 do
            local x = i % side
            local z = math.floor(i / side)
            table.insert(positions, start + right * (x * 4) + forward * (z * 4))
        end
    elseif BuildMode == "Circle" then
        local radius = math.max(4, count * 0.65)
        for i = 0, count - 1 do
            local angle = (math.pi * 2 * i) / count
            table.insert(positions, start + right * (math.cos(angle) * radius)
                + forward * (math.sin(angle) * radius))
        end
    end

    return positions
end

local function updatePreview()
    clearPreview()
    table.clear(CurrentPositions)

    if not PreviewEnabled then
        return
    end

    local base = getBaseCFrame()
    if not base then
        return
    end

    CurrentPositions = makeBuildPositions(base)

    for _, position in ipairs(CurrentPositions) do
        local marker = Instance.new("Part")
        marker.Name = "DirtPositionPreview"
        marker.Shape = Enum.PartType.Block
        marker.Size = Vector3.new(3.5, 0.35, 3.5)
        marker.Anchored = true
        marker.CanCollide = false
        marker.CanTouch = false
        marker.CanQuery = false
        marker.Material = Enum.Material.Neon
        marker.Color = Color3.fromRGB(70, 220, 120)
        marker.Transparency = 0.35
        marker.CFrame = CFrame.new(position)
        marker.Parent = PreviewFolder

        local highlight = Instance.new("Highlight")
        highlight.Name = "DirtPreviewHighlight"
        highlight.Adornee = marker
        highlight.FillColor = Color3.fromRGB(70, 220, 120)
        highlight.OutlineColor = Color3.fromRGB(220, 255, 230)
        highlight.FillTransparency = 0.65
        highlight.OutlineTransparency = 0
        highlight.Parent = marker

        table.insert(PreviewParts, marker)
    end
end

BuilderTab:CreateDropdown({
    Name = "Build Mode",
    Options = {
        "Straight",
        "Straight Up",
        "Straight Down",
        "Vertical Up",
        "Vertical Down",
        "Square",
        "Circle"
    },
    CurrentOption = "Straight",
    Callback = function(value)
        if type(value) == "table" then
            BuildMode = value[1] or "Straight"
        else
            BuildMode = value
        end
        updatePreview()
    end
})

BuilderTab:CreateInput({
    Name = "1. Up / Down",
    PlaceholderText = "0",
    Numeric = true,
    CurrentValue = "0",
    Callback = function(value)
        UpDown = tonumber(value) or 0
        updatePreview()
    end
})

BuilderTab:CreateInput({
    Name = "2. Left / Right",
    PlaceholderText = "0",
    Numeric = true,
    CurrentValue = "0",
    Callback = function(value)
        LeftRight = tonumber(value) or 0
        updatePreview()
    end
})

BuilderTab:CreateInput({
    Name = "3. Front / Back",
    PlaceholderText = "6",
    Numeric = true,
    CurrentValue = "6",
    Callback = function(value)
        FrontBack = tonumber(value) or 0
        updatePreview()
    end
})

BuilderTab:CreateInput({
    Name = "Dirt Count (1-25)",
    PlaceholderText = "5",
    Numeric = true,
    CurrentValue = "5",
    Callback = function(value)
        BuildCount = math.clamp(tonumber(value) or 5, 1, 25)
        updatePreview()
    end
})

BuilderTab:CreateToggle({
    Name = "Position Highlight",
    CurrentValue = true,
    Callback = function(value)
        PreviewEnabled = value
        updatePreview()
    end
})

BuilderTab:CreateButton({
    Name = "Refresh Preview",
    Callback = function()
        updatePreview()
    end
})

local function placeDirt()
    if IsPlacing then
        return false
    end

    local remote = getRemote("Build")
    if not remote then
        warn("Ant World: Build RemoteEvent not found")
        return false
    end

    -- Lock the full target list at the moment Place Dirt is clicked.
    -- Player movement during placement will not change these saved positions.
    local base = getBaseCFrame()
    if not base then
        warn("Ant World: character position not found")
        return false
    end
    local positions = table.clone(makeBuildPositions(base))

    if #positions == 0 then
        return false
    end

    IsPlacing = true
    task.spawn(function()
        for index, position in ipairs(positions) do
            if not remote or not remote.Parent then
                break
            end

            remote:FireServer(position)

            -- Place sequentially, with a 0.7-second gap between dirt placements.
            if index < #positions then
                task.wait(PLACE_INTERVAL)
            end
        end

        IsPlacing = false
        updatePreview()
    end)
    return true
end

BuilderTab:CreateButton({
    Name = "Place Dirt",
    Callback = function()
        placeDirt()
    end
})

-- Keep the preview following the player. Place Dirt takes its own fixed snapshot.
RunService.RenderStepped:Connect(function()
    if PreviewEnabled and not IsPlacing then
        updatePreview()
    end
end)

-- ESP
local EspSettings = {
    Green = {Enabled = false, Color = Color3.fromRGB(0, 255, 0)},
    Ghost = {Enabled = false, Color = Color3.fromRGB(220, 220, 220)},
    Gold = {Enabled = false, Color = Color3.fromRGB(255, 200, 0)},
    Purple = {Enabled = false, Color = Color3.fromRGB(170, 0, 255)},
    Copper = {Enabled = false, Color = Color3.fromRGB(184, 115, 51)}
}

for teamName, settings in pairs(EspSettings) do
    EspTab:CreateToggle({
        Name = "Esp " .. teamName .. " Team",
        CurrentValue = false,
        Callback = function(value)
            settings.Enabled = value
            if not value then
                for _, player in ipairs(Players:GetPlayers()) do
                    local character = player.Character
                    local old = character and character:FindFirstChild("AntWorld" .. teamName .. "ESP")
                    if old then old:Destroy() end
                end
            end
        end
    })
end

task.spawn(function()
    while task.wait(0.25) do
        for _, target in ipairs(Players:GetPlayers()) do
            if target ~= LocalPlayer and target.Team and target.Character then
                local team = string.lower(target.Team.Name)
                for teamName, settings in pairs(EspSettings) do
                    if settings.Enabled and string.find(team, string.lower(teamName), 1, true) then
                        local highlightName = "AntWorld" .. teamName .. "ESP"
                        local highlight = target.Character:FindFirstChild(highlightName)
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = highlightName
                            highlight.Parent = target.Character
                        end
                        highlight.FillColor = settings.Color
                        highlight.OutlineColor = settings.Color
                    end
                end
            end
        end
    end
end)

updatePreview()
