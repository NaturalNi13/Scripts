local checkEncrypted = loadstring(game:HttpGet("https://raw.githubusercontent.com/NaturalNi13/Scripts/refs/heads/main/encrypter.lua"))()
local owner = "natural idiot"
local result = checkEncrypted(owner)

 if result then
local canPlay = true

while true do
   if workspace.game.currentMap:getChildren()[1] then
      -- Check if the current map is "hide and seek"
      if workspace.game.currentMap:getChildren()[1].Name == "hide and seek" then
        -- Play custom sound if ingameTimer is less than or equal to 80
          if game:GetService("ReplicatedStorage").settingsDisplay.ingameTimer then
            if game:GetService("ReplicatedStorage").settingsDisplay.ingameTimer.Value <= 80 then
                local SoundId = "rbxassetid://13733949175"  -- Replace with your actual ID
                    game:GetService("SoundService").mainSounds.current.SoundId = SoundId
                    game:GetService("SoundService").mainSounds.current.PlaybackSpeed = 1
                end
            end
         end
   end
   task.wait(0.1)
end
end
