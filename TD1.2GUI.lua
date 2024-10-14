local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local usedKey = " "
local Window =
    Rayfield:CreateWindow(
    {
        Name = "TD1.2 GUI",
        LoadingTitle = "TD1.2 GUI",
        LoadingSubtitle = "by Natural Idiot",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = nil, -- Create a custom folder for your hub/game
            FileName = "Example Hub"
        },
        Discord = {
            Enabled = false,
            Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
            RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
        KeySystem = true, -- Set this to true to use our key system
        KeySettings = {
            Title = "Key | TD1.2 GUI",
            Subtitle = "Natural Idiot",
            Note = "DM Me on Discord for a key",
            FileName = "NatsTdGuiKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
            SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
            GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
            Key = {"natsgui_4483", " natsgui_7945"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings
        }
    }
)

local HomeTab = Window:CreateTab("Home", nil)
local HomeSection = HomeTab:CreateSection("Home")
local MainTab = Window:CreateTab("Mods", nil)
local WarpTab = Window:CreateTab("Warps", nil)
local lockTab = Window:CreateTab("Instalock", nil)
local DestroyButton =
    HomeTab:CreateButton(
    {
        Name = "Close",
        Callback = function()
            Rayfield:Destroy()
        end
    }
)

local MinimizeButton =
    HomeTab:CreateButton(
    {
        Name = "Minimize",
        Callback = function()
            Minimise()
        end
    }
)

Rayfield:Notify(
    {
        Title = "TD1.2 GUI",
        Content = "Have fun!",
        Duration = 5,
        Image = 13047715178,
        Actions = {
            -- Notification Buttons
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("The user tapped Okay!")
                end
            }
        }
    }
)
local user = " "
local cSound = false
local Input =
    MainTab:CreateInput(
    {
        Name = "Username",
        PlaceholderText = "Input Username",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            -- The function that takes place when the input is changed
            -- The variable (Text) is a string for the value in the text box
            user = Text
        end
    }
)
local Label = MainTab:CreateLabel("Input your username above first!")
local Button =
    MainTab:CreateButton(
    {
        Name = "Super Form! (No Work Rn)",
        Callback = function()
        end
    }
)
local doubleT = false
local Toggle =
    MainTab:CreateToggle(
    {
        Name = "Double Trouble",
        CurrentValue = false,
        Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            -- The function that takes place when the toggle is pressed
            -- The variable (Value) is a boolean on whether the toggle is true or false
            if Value then
                loadstring(game:HttpGet("https://pastebin.com/raw/cnvfhX6H"))()
                doubleT = true
            else
                --loadstring(game:HttpGet("https://pastebin.com/raw/rmEP0uZB"))()
                doubleT = false
            end
        end
    }
)
local noCD = false
local Toggle =
    MainTab:CreateToggle(
    {
        Name = "No Cooldown",
        CurrentValue = false,
        Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            -- The function that takes place when the toggle is pressed
            -- The variable (Value) is a boolean on whether the toggle is true or false
            noCD = Value
        end
    }
)
local Button =
    MainTab:CreateButton(
    {
        Name = "Perma Indicator (CANT TURN OFF)",
        Callback = function()
            -- The function that takes place when the button is pressed
            loadstring(game:HttpGet("https://pastebin.com/raw/LRMqt4rE"))()
        end
    }
)

local player = game.Players.LocalPlayer

local character = nil

local function updateCoords()
    if character then
        local x = math.floor(character.HumanoidRootPart.CFrame.Position.X)
        local z = math.floor(character.HumanoidRootPart.CFrame.Position.Z)
        local y = math.floor(character.HumanoidRootPart.CFrame.Position.Y)
        return x, y, z
    end
end
local cLock = "none"

local function onCharacterAdded(newCharacter)
    character = newCharacter

    -- Wait for the necessary parts to be added
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    -- Start the floating logic
    local isFloating = false
    local floatHeight = 5
    local floatSpeed = 1
    local currentY = humanoidRootPart.Position.Y

    local function startFloating()
        isFloating = true
        humanoid.PlatformStand = true
    end

    local function stopFloating()
        isFloating = false
        humanoid.PlatformStand = false
    end

    local function updateFloat()
        if isFloating then
            local targetY = math.min(currentY + floatSpeed, floatHeight)
            currentY = targetY
            humanoidRootPart.Velocity = Vector3.new(0, (targetY - humanoidRootPart.Position.Y), 0)
        end
    end

    -- Update position every frame
    game:GetService("RunService").Heartbeat:Connect(updateFloat)

    local updateTime = 0.01

    while true do
        local xpos, ypos, zpos = updateCoords()
        if ypos and ypos < -20 then
            startFloating()
        else
            stopFloating()
        end
        if ypos and ypos < 20 then
            local args = {
                [1] = cLock
            }

            game:GetService("ReplicatedStorage"):WaitForChild("remotes"):WaitForChild("morphs"):FireServer(unpack(args))
        end
        if noCD then
            if
                game.ReplicatedStorage.displayPlayers:FindFirstChild(game.Players.LocalPlayer.Name) and
                    game.ReplicatedStorage.displayPlayers[game.Players.LocalPlayer.Name]:FindFirstChild("cooldowns")
             then
                for _, child in ipairs(
                    game.ReplicatedStorage.displayPlayers[game.Players.LocalPlayer.Name].cooldowns:GetChildren()
                ) do
                    if child:IsA("NumberValue") then
                        child:Destroy()
                    end
                end
            else
                warn("Player not found.")
            end
        end
        wait(updateTime)
    end
end
local function teleportTo(player, x, y, z)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
end

local cWarp = "Lobby"
local Dropdown =
    WarpTab:CreateDropdown(
    {
        Name = "Warps",
        Options = {"Lobby", "Box"},
        CurrentOption = {"Lobby"},
        MultipleOptions = false,
        Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option)
            cWarp = Option[1]
        end
    }
)

local Button =
    WarpTab:CreateButton(
    {
        Name = "Warp",
        Callback = function()
            if cWarp == "Box" then
                teleportTo(player, 0, 10, -90)
            elseif cWarp == "Lobby" then
                teleportTo(player, 0, 10, 30)
            end
        end
    }
)

local Dropdown =
    lockTab:CreateDropdown(
    {
        Name = "Instalock Character",
        Options = {"none", "tails", " knuckles", "eggman", "amy", "cream", "sally", "shadow", "rouge", "metalsonic"},
        CurrentOption = {"none"},
        MultipleOptions = false,
        Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option)
            cLock = Option[1]
        end
    }
)

-- Connect the onCharacterAdded function to the CharacterAdded event
player.CharacterAdded:Connect(onCharacterAdded)

-- If the player already has a character, call onCharacterAdded
if player.Character then
    onCharacterAdded(player.Character)
end
