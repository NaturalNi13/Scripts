local Lighting = game:GetService("Lighting")
    local atmosphere = Lighting:FindFirstChild("CustomAtmosphere")

    if not atmosphere then
        atmosphere = Instance.new("Atmosphere")
        atmosphere.Name = "CustomAtmosphere"
        atmosphere.Parent = Lighting
    end
    -- Sound setup
    local SoundService = game:GetService("SoundService")
    local RunService = game:GetService("RunService")

    -- Custom sound setup
    local customSound = Instance.new("Sound")
    customSound.SoundId = "rbxassetid://9043365993"
    customSound.Looped = true
    customSound.Volume = 3
    customSound.Parent = SoundService

    -- Stop other sounds
    local function stopAllSounds()
        for _, sound in ipairs(SoundService:GetDescendants()) do
            if sound:IsA("Sound") and sound ~= customSound then
                sound:Stop()
                sound.Looped = false
            end
        end
    end

    -- Play custom sound and stop others
    customSound:Play()
    RunService.RenderStepped:Connect(stopAllSounds)
local function getRole()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = game.Players.LocalPlayer
    local playerUsername = player.Name

    local playerStats = ReplicatedStorage.displayPlayers:FindFirstChild(playerUsername)
    if playerStats and playerStats.health.Value < 1 and playerStats.blood.Value < 1 then
        return true
    else
        return false
    end
end

local function fog()
    

    if not getRole() then
        -- Custom fog properties
        Lighting.FogColor = Color3.fromRGB(0, 0, 0)
        Lighting.FogStart = 5
        Lighting.FogEnd = 50
        Lighting.Brightness = 0.2

        -- Atmosphere for dense, spooky feel
        atmosphere.Density = 0.85
        atmosphere.Color = Color3.fromRGB(0, 0, 0)
        atmosphere.Decay = Color3.fromRGB(0, 0, 0)
        atmosphere.Glare = 0
        atmosphere.Haze = 10
    else
        -- Reset to default
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.Brightness = 1

        -- Clear atmosphere without destroying
        atmosphere.Density = 0
        atmosphere.Color = Color3.fromRGB(255, 255, 255)
        atmosphere.Decay = Color3.fromRGB(255, 255, 255)
        atmosphere.Glare = 0
        atmosphere.Haze = 0
    end


end

-- Run fog setup when character is added
local player = game.Players.LocalPlayer
player.CharacterAdded:Connect(fog)

while true do
fog()
wait(1)
end
