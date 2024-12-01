local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local characterColors = {
    tails = Color3.fromRGB(255, 165, 0),        -- Orange
    knuckles = Color3.fromRGB(255, 0, 0),      -- Bright Red
    eggman = Color3.fromRGB(255, 255, 0),      -- Yellow
    amy = Color3.fromRGB(255, 105, 180),       -- Pink
    cream = Color3.fromRGB(255, 218, 185),     -- Peach
    sally = Color3.fromRGB(210, 180, 140),     -- Light Brown
    shadow = Color3.fromRGB(0, 0, 0),          -- Black
    rouge = Color3.fromRGB(255, 255, 255),     -- White
    blaze = Color3.fromRGB(128, 0, 128),       -- Purple
    silver = Color3.fromRGB(192, 192, 192),    -- Gray
    metalsonic = Color3.fromRGB(0, 0, 255),    -- Blue
    kolossos = Color3.fromRGB(139, 0, 0),      -- Dark Red
    sonicexe = Color3.fromRGB(139, 0, 0),      -- Dark Red
}

local highlightMap = {}

local function loopThroughDisplayPlayers()
    local displayPlayersFolder = ReplicatedStorage:FindFirstChild("displayPlayers")
    if not displayPlayersFolder then
        warn("displayPlayers folder does not exist in ReplicatedStorage.")
        return
    end

    for modelName, highlight in pairs(highlightMap) do
        if not displayPlayersFolder:FindFirstChild(modelName) then
            highlight:Destroy()
            highlightMap[modelName] = nil
        end
    end

    for _, child in pairs(displayPlayersFolder:GetChildren()) do
        local stats = child:FindFirstChild("stats")
        if stats and stats:FindFirstChild("character") then
            local givenCharacter = stats.character.Value:lower()
            local color = characterColors[givenCharacter]

            if color then
                local model = workspace:FindFirstChild(child.Name)
                if model and model:IsA("Model") and model.Name ~= player.Name then
                    if not highlightMap[model.Name] then
                        local highlight = Instance.new("Highlight")
                        highlight.FillColor = color
                        highlight.FillTransparency = 0.3
                        highlight.OutlineColor = color
                        highlight.OutlineTransparency = 0.2
                        highlight.Enabled = true
                        highlight.Adornee = model
                        highlight.Parent = workspace
                        highlightMap[model.Name] = highlight
                    else
                        local highlight = highlightMap[model.Name]
                        highlight.FillColor = color
                        highlight.OutlineColor = color
                    end
                else
                    warn("Model for", child.Name, "not found in Workspace.")
                end
            else
                warn("No color defined for character:", givenCharacter)
            end
        else
            warn("Invalid stats or character value for", child.Name)
        end
    end
end

local displayPlayersFolder = ReplicatedStorage:WaitForChild("displayPlayers")
displayPlayersFolder.ChildRemoved:Connect(loopThroughDisplayPlayers)
displayPlayersFolder.ChildAdded:Connect(loopThroughDisplayPlayers)

while true do
    loopThroughDisplayPlayers()
    wait(1)
end
