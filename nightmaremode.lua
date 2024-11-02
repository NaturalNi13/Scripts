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
    customSound.SoundId = "rbxassetid://6101411994"
    customSound.Looped = true
    customSound.Volume = 1
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
    
-- Create a ScreenGui for the vignette effect
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VignetteEffect"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create an ImageLabel for the vignette image
local vignetteImage = Instance.new("ImageLabel")
vignetteImage.Name = "Vignette"
vignetteImage.Image = "rbxassetid://95212900084536"  -- Replace with your asset ID
vignetteImage.Size = UDim2.new(1, 0, 1, 0)  -- Full screen size
vignetteImage.Position = UDim2.new(0, 0, 0, 0)
vignetteImage.BackgroundTransparency = 1  -- Make sure there's no background
vignetteImage.ImageTransparency = 0.3  -- Adjust for desired effect (0 = fully visible, 1 = invisible)
vignetteImage.ImageColor3 = Color3.new(0, 0, 0)  -- Black tint for a horror effect
vignetteImage.Parent = screenGui

-- Add a UIAspectRatioConstraint to maintain aspect ratio
local aspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
aspectRatioConstraint.AspectRatio = 16 / 9  -- Adjust this to match your original image's aspect ratio
aspectRatioConstraint.Parent = vignetteImage
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

-- Function to enable first-person mode
local function setFirstPerson()
    -- Lock the player's camera to first-person
    player.CameraMode = Enum.CameraMode.LockFirstPerson
    -- Disable mouse zooming to prevent the player from switching views
    player.CameraMinZoomDistance = 0.5
    player.CameraMaxZoomDistance = 0.5

    -- Make sure the camera follows the player's head position
    camera.CameraSubject = player.Character:WaitForChild("Humanoid")
end
setFirstPerson()
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
