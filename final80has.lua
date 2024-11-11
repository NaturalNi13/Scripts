local checkEncrypted = loadstring(game:HttpGet("https://raw.githubusercontent.com/NaturalNi13/Scripts/refs/heads/main/encrypter.lua"))()
local owner = "natural idiot"
local result = checkEncrypted(owner)

if result then
    local canPlay = true

    while true do
        local currentMap = workspace.game.currentMap
        local children = currentMap:getChildren()

        -- Make sure currentMap has at least one child
        if #children > 0 then
            local firstChild = children[1]
            
            -- Check if the first child exists and is named "hide and seek"
            if firstChild and firstChild.Name == "hide and seek" then
                local ingameTimer = game:GetService("ReplicatedStorage").settingsDisplay:FindFirstChild("ingameTimer")
                
                -- Check if ingameTimer exists and its value is less than or equal to 80
                if ingameTimer and ingameTimer.Value <= 80 then
                    local SoundId = "rbxassetid://13733949175"  -- Replace with your actual sound ID
                    game:GetService("SoundService").mainSounds.current.SoundId = SoundId
                    game:GetService("SoundService").mainSounds.current.PlaybackSpeed = 1
                end
            end
        end

        task.wait(0.1)
    end
end
