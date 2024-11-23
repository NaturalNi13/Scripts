-- LocalScript (Place this in StarterPlayerScripts or StarterCharacterScripts)
local mMusic
local fMusic
local player = game.Players.LocalPlayer
local character = player.Character
local sSpawns = {
    Vector3.new(0, 630, -150),
    Vector3.new(0, 630, -150),
    Vector3.new(0, 630, -150)
}
local exeSpawn = Vector3.new(0, 630, -150)
-- Cube management
local cubes = {}
local selectedCube

local function parseVector3(input)
    local parts = string.split(input, ",")
    if #parts == 3 then
        return Vector3.new(tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3]))
    end
    return nil
end

local function parseRotation(input)
    local parts = string.split(input, ",")
    if #parts == 3 then
        return Vector3.new(tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3]))
    end
    return nil
end

local function loadMap(gCode)
    -- Parse the incoming map data
    local mapCode = game:GetService("HttpService"):JSONDecode(gCode)

    -- Create or get the 'customMap' folder under 'Workspace.game.currentMap'
    local currentMap = Workspace.game
    if not currentMap then
        warn("currentMap folder is missing!")
        return
    end

    local customMapFolder = currentMap:FindFirstChild("customMap")
    if customMapFolder then
        customMapFolder:Destroy()
        customMapFolder = nil
    end
    if not customMapFolder then
        customMapFolder = Instance.new("Folder")
        customMapFolder.Name = "customMap"
        customMapFolder.Parent = currentMap
    end

    -- Handle music-related data
    if mapCode.mapMusic then
        mMusic = mapCode.mapMusic
        -- You can set the music to play here if necessary
        -- Example: game:GetService("SoundService"):Play(mMusic)
    end
    if mapCode.escapeMusic then
        fMusic = mapCode.escapeMusic
        -- Example: game:GetService("SoundService"):Play(fMusic)
    end

    -- Process each object in the map data
    for _, objectData in ipairs(mapCode.objects or {}) do
        local dataType = objectData.type or "cube"

        if dataType == "spring" then
            -- Recreate the spring model
            local springModel = workspace:FindFirstChild("spring")
            if springModel and springModel:IsA("Model") then
                local newSpring = springModel:Clone()
                local position = parseVector3(objectData.position) or Vector3.new(0, 0, 0)

                -- Add 450 to the Y value
                position = Vector3.new(position.X, position.Y + 450, position.Z)

                -- Calculate the offset between the spring's center and its parts
                local parts = newSpring:GetDescendants()
                local centerOffset = Vector3.new(0, 0, 0)
                local partCount = 0
                for _, part in ipairs(parts) do
                    if part:IsA("BasePart") then
                        centerOffset = centerOffset + part.Position
                        partCount = partCount + 1
                    end
                end
                if partCount > 0 then
                    centerOffset = centerOffset / partCount
                end

                -- Move the model to the correct position
                local positionOffset = position - centerOffset
                for _, part in ipairs(parts) do
                    if part:IsA("BasePart") then
                        part.Position = part.Position + positionOffset
                        part.Anchored = true
                    end
                end

                -- Find the "pad" part in the spring model
                local padPart = newSpring:FindFirstChild("pad")
                if padPart and padPart:IsA("BasePart") then
                    local lastUsed = 0  -- Store the timestamp when the spring was last used

                    -- Use a loop to constantly check the distance between the pad and any players
                    game:GetService("RunService").Heartbeat:Connect(function()
                        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                            local character = player.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                local humanoidRootPart = character.HumanoidRootPart
                                local distance = (humanoidRootPart.Position - padPart.Position).Magnitude

                                if distance <= 1.5 and tick() - lastUsed >= 5 then
                                    local humanoid = character:FindFirstChild("Humanoid")
                                    if humanoid then
                                        local bodyVelocity = Instance.new("BodyVelocity")
                                        bodyVelocity.MaxForce = Vector3.new(4000, 12500, 4000)
                                        bodyVelocity.Velocity = Vector3.new(0, 800, 0)
                                        bodyVelocity.Parent = humanoidRootPart

                                        game:GetService("Debris"):AddItem(bodyVelocity, 0.1)
                                        lastUsed = tick()
                                    end
                                end
                            end
                        end
                    end)
                else
                    warn("Pad part not found in the spring model!")
                end

                newSpring.Parent = customMapFolder
            else
                warn("Spring model not found in the workspace!")
            end

        elseif dataType == "ladder" then
            -- Recreate a ladder (truss part)
            local newTruss = Instance.new("TrussPart")
            newTruss.Size = parseVector3(objectData.size) or Vector3.new(4, 8, 4)

            local position = parseVector3(objectData.position) or Vector3.new(0, 5, 0)
            position = Vector3.new(position.X, position.Y + 450, position.Z)

            newTruss.Position = position
            newTruss.Anchored = true
            newTruss.Material = Enum.Material.Neon
            newTruss.Color = Color3.fromRGB(255, 0, 0)
            newTruss.Parent = customMapFolder

        elseif dataType == "cube" then
            -- Recreate a regular cube
            local newCube = Instance.new("Part")
            newCube.Size = parseVector3(objectData.size) or Vector3.new(4, 1, 4)

            local position = parseVector3(objectData.position) or Vector3.new(0, 5, 0)
            position = Vector3.new(position.X, position.Y + 450, position.Z)

            newCube.Position = position
            newCube.Orientation = parseVector3(objectData.rotation) or Vector3.new(0, 0, 0)
            newCube.Anchored = true

            -- Handle textures if present
            if objectData.hasTexture == "true" and objectData.texture and objectData.texture ~= "" then
                local textureSize = { U = 1, V = 1 }
                if objectData.textureSize and objectData.textureSize:match("^%d+,%d+$") then
                    local sizeParts = objectData.textureSize:split(",")
                    textureSize.U = tonumber(sizeParts[1]) or 1
                    textureSize.V = tonumber(sizeParts[2]) or 1
                end

                -- Apply textures to all faces
                for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
                    local texture = Instance.new("Texture")
                    texture.Texture = "rbxassetid://" .. objectData.texture
                    texture.Face = face
                    texture.StudsPerTileU = textureSize.U
                    texture.StudsPerTileV = textureSize.V
                    texture.Parent = newCube
                end
            end

            newCube.Parent = customMapFolder
        end
    end
end
local function updateCoords()
    if character then
        local x = math.floor(character.HumanoidRootPart.CFrame.Position.X)
        local z = math.floor(character.HumanoidRootPart.CFrame.Position.Z)
        local y = math.floor(character.HumanoidRootPart.CFrame.Position.Y)
        return x, y, z
    end
end
local displayPlayers = game:GetService("ReplicatedStorage").displayPlayers
local xpos, ypos, zpos = updateCoords()
local isInMap = false
local doing80 = false
while true do
    xpos, ypos, zpos = updateCoords()
    while ypos < 80 do
        xpos, ypos, zpos = updateCoords()
        wait(0.01)
        isInMap = false
    end
    if not isInMap then
    local mapList = workspace.game.currentMap:getChildren()
    local cMap
    if #mapList > 0 then
        cMap = workspace.game.currentMap:getChildren()[1]
    end

    if cMap then
        cMap:Destroy()
    end
    print("ok)")
    loadMap('{"objects":[{"rotation":"0, 0, 0","type":"cube","textureSize":"1,1","position":"0, 100, -150","texture":"","hasTexture":"false","size":"800, 5, 800"},{"rotation":"0, 0, 0","type":"cube","textureSize":"1,1","position":"0, 108, -150","texture":"","hasTexture":"false","size":"30, 15, 30"},{"rotation":"0, 0, 0","type":"cube","textureSize":"1,1","position":"0, 116, -150","texture":"","hasTexture":"false","size":"30, 2, 30"},{"rotation":"0, 0, 0","type":"cube","textureSize":"1,1","position":"0, 100, -1509","texture":"","hasTexture":"false","size":"1, 1, 1"},{"type":"ladder","position":"-2, 110, -164.5","size":"2, 15, 2"},{"rotation":"0, 0, 0","type":"cube","textureSize":"1,1","position":"2, 110, -164","texture":"","hasTexture":"false","size":"1, 1, 1"},{"rotation":"0, 0, 0","type":"cube","textureSize":"1,1","position":"-2, 110, -1600","texture":"","hasTexture":"false","size":"2, 15, 2"},{"type":"ladder","position":"2, 110, -164.5","size":"2, 15, 2"},{"type":"ladder","position":"0, 110, -164.5","size":"2, 15, 2"},{"type":"ladder","position":"2, 110, -164","size":"2, 2, 2"},{"rotation":"0, 30, 15","type":"cube","textureSize":"1,1","position":"30, 121, -160","texture":"","hasTexture":"false","size":"45, 2, 10"},{"rotation":"0, -60, 0","type":"cube","textureSize":"1,1","position":"60, 108, -180","texture":"","hasTexture":"false","size":"30, 39.5, 30"},{"type":"ladder","position":"78, 108, -178","size":"2, 41, 2"},{"type":"ladder","position":"77, 108, -179","size":"2, 41, 2"},{"rotation":"-45, 0, 0","type":"spring","position":"-18, 104, -150"}],"escapeMusic":"6257627378","mapMusic":"114805617662705"}')
        if displayPlayers:findFirstChild(player.Name).health.Value > 0 then
        
            math.randomseed(os.time()) -- Set the seed
            local randomNumber = math.random(1, 3)
            local usedSpawn = sSpawns[randomNumber]
            character.HumanoidRootPart.CFrame = CFrame.new(usedSpawn)
        else
            character.HumanoidRootPart.CFrame = CFrame.new(exeSpawn)
        end
       while ypos > 90 do
    -- Check if the current map is "hide and seek"
    xpos, ypos, zpos = updateCoords()
        -- Play custom sound if ingameTimer is less than or equal to 80
        if game:GetService("ReplicatedStorage").settingsDisplay.ingameTimer.Value <= 80 then
        if not doing80 then
        doing80 = true
            local SoundId = "rbxassetid://" .. fMusic -- Replace with your actual ID
                game:GetService("SoundService").mainSounds.current.SoundId = SoundId
                game:GetService("SoundService").mainSounds.current.PlaybackSpeed = 1
                game:GetService("SoundService").mainSounds.current.TimePosition = 0
                end
        else
        local SoundId = "rbxassetid://" .. mMusic  -- Replace with your actual ID
                game:GetService("SoundService").mainSounds.current.SoundId = SoundId
                game:GetService("SoundService").mainSounds.current.PlaybackSpeed = 1
        end
    task.wait(0.1)
end 
    end
    isInMap = true
    
    wait(0.01)
end
