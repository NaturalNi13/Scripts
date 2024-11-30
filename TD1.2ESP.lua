local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local givenCharacter

-- Define character-to-color mapping
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

-- Keep track of all created Highlight instances
local activeHighlights = {}

-- Define the function
local function loopThroughDisplayPlayers()
    -- Check if displayPlayers exists
    local displayPlayersFolder = ReplicatedStorage:FindFirstChild("displayPlayers")
    if not displayPlayersFolder then
        warn("displayPlayers folder does not exist in ReplicatedStorage.")
        return
    end

    -- Loop through all children of displayPlayers
    for _, child in pairs(displayPlayersFolder:GetChildren()) do
        -- Get the character name from stats
        local stats = child:FindFirstChild("stats")
        if stats and stats:FindFirstChild("character") then
            givenCharacter = stats.character.Value:lower()

            -- Check if the character has a corresponding color
            local color = characterColors[givenCharacter]
            if color then
                -- Highlight the corresponding model in the Workspace
                local model = workspace:FindFirstChild(child.Name)
                if model and model:IsA("Model") and model.Name ~= player.Name then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = color
                    highlight.FillTransparency = 0.3
                    highlight.OutlineColor = color
                    highlight.OutlineTransparency = 0.2
                    highlight.Enabled = true
                    highlight.Adornee = model
                    highlight.Parent = workspace

                    -- Track the highlight instance
                    table.insert(activeHighlights, highlight)
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

    -- Check if the folder is empty, and if so, destroy all highlights
    if #displayPlayersFolder:GetChildren() == 0 then
        for _, highlight in pairs(activeHighlights) do
            highlight:Destroy()
        end
        -- Clear the activeHighlights table
        activeHighlights = {}
        print("All highlights destroyed as displayPlayers has no children.")
    end
end

-- Call the function
loopThroughDisplayPlayers()

-- Example: Monitor the folder for changes
ReplicatedStorage.displayPlayers.ChildRemoved:Connect(loopThroughDisplayPlayers)
ReplicatedStorage.displayPlayers.ChildAdded:Connect(loopThroughDisplayPlayers)
