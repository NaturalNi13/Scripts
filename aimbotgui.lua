local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
local Window =
    OrionLib:MakeWindow(
    {
        Name = "Aimbot GUI",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "Aimbotgui",
        IntroEnabled = false,
        IntroText = "Aimbot GUI - Natural Idiot"
    }
)
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = nil,
	PremiumOnly = false
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local displayPlayers = ReplicatedStorage:WaitForChild("displayPlayers")

-- Function to check if a player in the displayPlayers folder has 0 health
local function isPlayerHealthZero(playerName)
    local player = displayPlayers:FindFirstChild(playerName)
    if player then
        local health = player:FindFirstChild("health")
        if health and health.Value == 0 then
            return true
        end
    end
    return false
end

local targetPlayer = nil
local nearPlayerDistance = 1000
local aimBot = false  -- Make sure this is true to activate the aimbot

-- Define the base offset
local baseRightOffset = 0.05 -- Base right offset that will scale with distance
local baseDownOffset = 0.06 -- Base down offset that will scale with distance

local function isVisible(player)
    -- Add your visibility logic here (for now we assume all players are visible)
    return true
end

-- Function to find the nearest player with 0 health
local function findNearestTargetWithZeroHealth()
    local nearestDistance = math.huge
    local nearestPlayer = nil
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        -- Ensure the player isn't the local player, has a character, and a HumanoidRootPart
        if player ~= game:GetService("Players").LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Only target players whose health is 0
            if isPlayerHealthZero(player.Name) then
                local distance = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
                -- Now, distance check comes *only* for players with 0 health
                if distance <= nearPlayerDistance and distance < nearestDistance and isVisible(player) then
                    nearestDistance = distance
                    nearestPlayer = player
                end
            end
        end
    end
    return nearestPlayer
end

-- Function to smoothly rotate the camera to face the nearest player with 0 health
local function camlock()
    if aimBot then
        -- Update the target player
        targetPlayer = findNearestTargetWithZeroHealth()

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local camera = workspace.CurrentCamera
            local targetHumanoidRootPart = targetPlayer.Character.HumanoidRootPart

            -- Get the target's position
            local targetPosition = targetHumanoidRootPart.Position

            -- Get the camera's current position and look at the target, keeping the camera in its current position
            local cameraPosition = camera.CFrame.Position

            -- Multiply the base offsets by the distance to scale dynamically
            local distanceToTarget = (targetPosition - cameraPosition).magnitude
            local rightOffset = baseRightOffset * distanceToTarget
            local downOffset = baseDownOffset * distanceToTarget

            -- Offset based on camera's orientation, now scaled by distance
            local rightVector = camera.CFrame.RightVector
            local downVector = -camera.CFrame.UpVector
            local offset = (rightVector * rightOffset) + (downVector * downOffset)

            -- Smoothly rotate the camera towards the target, without changing the camera's position
            local newCFrame = CFrame.new(cameraPosition, targetPosition + offset)
            camera.CFrame = camera.CFrame:Lerp(newCFrame, 0.1) -- Smooth camera transition
        end
    end
end

-- Connect the camlock function to the RenderStepped event for continuous aiming
game:GetService("RunService").RenderStepped:Connect(camlock)

-- GUI Elements for toggling aimbot and adjusting offsets
Tab:AddToggle({
	Name = "Aimbot",
	Default = false,
	Callback = function(Value)
		aimBot = Value
	end    
})

Tab:AddTextbox({
	Name = "Horizontal",
	Default = "0.05",
	TextDisappear = false,
	Callback = function(Value)
		baseRightOffset = tonumber(Value)
	end	  
})

Tab:AddTextbox({
	Name = "Vertical",
	Default = "0.06",
	TextDisappear = false,
	Callback = function(Value)
		baseDownOffset = tonumber(Value)
	end	  
})
