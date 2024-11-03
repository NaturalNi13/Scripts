local OrionLib =
    loadstring(game:HttpGet(("https://raw.githubusercontent.com/NaturalNi13/Scripts/refs/heads/main/Orion.lua")))()

local Window = OrionLib:MakeWindow({Name = "DC Public Testing DOUBLE TROUBLE", HidePremium = false, SaveConfig = false, ConfigFolder = "rjjejrdhkrje"})

local Tab1 = Window:MakeTab({Name = "MAIN", Icon = nil, PremiumOnly = false})

Tab1:AddButton({
    Name = "Sonic.exe",
    Callback = function()
        local args = {
    [1] = "void"
}

game:GetService("ReplicatedStorage"):WaitForChild("remotes"):WaitForChild("morph"):FireServer(unpack(args))
    end
})
Tab1:AddButton({
    Name = "Chara",
    Callback = function()
        local args = {
    [1] = "chara"
}

game:GetService("ReplicatedStorage"):WaitForChild("remotes"):WaitForChild("morph"):FireServer(unpack(args))
    end
})
OrionLib:Init()