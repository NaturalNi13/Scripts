local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer  -- Get the local player
local shadowModel = game.Workspace.LocalPlayer -- Use local player's name

if shadowModel then
    local headModel = shadowModel:FindFirstChild("head")
    if headModel then
        local earsFolder = headModel:FindFirstChild("ears")
        if earsFolder then
            local ear1Mesh = earsFolder:FindFirstChild("ear1")
            if ear1Mesh and ear1Mesh:IsA("MeshPart") then
                ear1Mesh.BrickColor = BrickColor.new("New Yeller")
                ear1Mesh.Material = Enum.Material.Neon
            end
            local ear2Mesh = earsFolder:FindFirstChild("ear2")
            if ear2Mesh and ear2Mesh:IsA("MeshPart") then
                ear2Mesh.BrickColor = BrickColor.new("New Yeller")
                ear2Mesh.Material = Enum.Material.Neon
            end
        end
        local expressionsFolder = headModel:FindFirstChild("expressions")
        if expressionsFolder then
            local angryFolder = expressionsFolder:FindFirstChild("angry")
            if angryFolder then
                -- Loop through all MeshParts named "angry"
                for _, meshPart in pairs(angryFolder:GetChildren()) do
                    if meshPart:IsA("MeshPart") and meshPart.Name == "angry" then
                        meshPart.BrickColor = BrickColor.new("New Yeller")
                        meshPart.Material = Enum.Material.Neon	
                    end
                end
            end
        end
        local mouthsFolder = headModel:FindFirstChild("mouths")
        if mouthsFolder then
            local angryMouth = mouthsFolder:FindFirstChild("angryMouth")		
            if angryMouth and angryMouth:IsA("MeshPart") then				
                angryMouth.Transparency = 0
            end
            local mouth = mouthsFolder:FindFirstChild("mouth")
            if mouth and mouth:IsA("MeshPart") then
                mouth.Transparency = 1
            end		
        end		
        local spinesFolder = headModel:FindFirstChild("spines")
        if spinesFolder then
            local spine1Mesh = spinesFolder:FindFirstChild("spine1")
            if spine1Mesh and spine1Mesh:IsA("MeshPart") then
                spine1Mesh.BrickColor = BrickColor.new("New Yeller")
                spine1Mesh.Material = Enum.Material.Neon
            end
            local spine2Mesh = spinesFolder:FindFirstChild("spine2")
            if spine2Mesh and spine2Mesh:IsA("MeshPart") then
                spine2Mesh.BrickColor = BrickColor.new("New Yeller")
                spine2Mesh.Material = Enum.Material.Neon
            end
            local spine3Mesh = spinesFolder:FindFirstChild("spine3")
            if spine3Mesh and spine3Mesh:IsA("MeshPart") then
                spine3Mesh.BrickColor = BrickColor.new("New Yeller")
                spine3Mesh.Material = Enum.Material.Neon
            end
            local spine4Mesh = spinesFolder:FindFirstChild("spine4")
            if spine4Mesh and spine4Mesh:IsA("MeshPart") then
                spine4Mesh.BrickColor = BrickColor.new("New Yeller")
                spine4Mesh.Material = Enum.Material.Neon
            end
            local spine5Mesh = spinesFolder:FindFirstChild("spine5")
            if spine5Mesh and spine5Mesh:IsA("MeshPart") then
                spine5Mesh.BrickColor = BrickColor.new("New Yeller")
                spine5Mesh.Material = Enum.Material.Neon
            end
            local spine6Mesh = spinesFolder:FindFirstChild("spine6")
            if spine6Mesh and spine6Mesh:IsA("MeshPart") then
                spine6Mesh.BrickColor = BrickColor.new("New Yeller")
                spine6Mesh.Material = Enum.Material.Neon
            end
        end
        local headMesh = headModel:FindFirstChild("head")
        if headMesh then
            headMesh.BrickColor = BrickColor.new("New Yeller")
            headMesh.Material = Enum.Material.Neon
        end
    end
    local arm1Model = shadowModel:FindFirstChild("arm1")
    if arm1Model then
        local arm1Folder = arm1Model:FindFirstChild("arm")
        if arm1Folder then
            local arm1Mesh = arm1Folder:FindFirstChild("lowerAtt")
            if arm1Mesh and arm1Mesh:IsA("MeshPart") then
                arm1Mesh.BrickColor = BrickColor.new("New Yeller")
                arm1Mesh.Material = Enum.Material.Neon
            end
            local arm2Mesh = arm1Folder:FindFirstChild("mainAtt")
            if arm2Mesh and arm2Mesh:IsA("MeshPart") then
                arm2Mesh.BrickColor = BrickColor.new("New Yeller")
                arm2Mesh.Material = Enum.Material.Neon
            end
            local arm3Mesh = arm1Folder:FindFirstChild("middleAtt")
            if arm3Mesh and arm3Mesh:IsA("MeshPart") then
                arm3Mesh.BrickColor = BrickColor.new("New Yeller")
                arm3Mesh.Material = Enum.Material.Neon
            end
            local arm5Part = arm1Folder:FindFirstChild("lowerArm")
            if arm5Part and arm5Part:IsA("Part") then
                arm5Part.BrickColor = BrickColor.new("New Yeller")
                arm5Part.Material = Enum.Material.Neon
            end
            local arm6Part = arm1Folder:FindFirstChild("middleArm")
            if arm6Part and arm6Part:IsA("Part") then
                arm6Part.BrickColor = BrickColor.new("New Yeller")
                arm6Part.Material = Enum.Material.Neon
            end
            local arm7Part = arm1Folder:FindFirstChild("upperArm")
            if arm7Part and arm7Part:IsA("Part") then  -- Fixed: was arm6Part
                arm7Part.BrickColor = BrickColor.new("New Yeller")
                arm7Part.Material = Enum.Material.Neon
            end	
        end
    end
    local arm2Model = shadowModel:FindFirstChild("arm2")
    if arm2Model then
        local arm2Folder = arm2Model:FindFirstChild("arm")
        if arm2Folder then
            local arm2Mesh1 = arm2Folder:FindFirstChild("lowerAtt2")
            if arm2Mesh1 and arm2Mesh1:IsA("MeshPart") then
                arm2Mesh1.BrickColor = BrickColor.new("New Yeller")
                arm2Mesh1.Material = Enum.Material.Neon
            end
            local arm2Mesh2 = arm2Folder:FindFirstChild("mainAtt2")
            if arm2Mesh2 and arm2Mesh2:IsA("MeshPart") then
                arm2Mesh2.BrickColor = BrickColor.new("New Yeller")
                arm2Mesh2.Material = Enum.Material.Neon
            end
            local arm2Mesh3 = arm2Folder:FindFirstChild("middleAtt2")
            if arm2Mesh3 and arm2Mesh3:IsA("MeshPart") then
                arm2Mesh3.BrickColor = BrickColor.new("New Yeller")
                arm2Mesh3.Material = Enum.Material.Neon	
            end
            local arm2Part5 = arm2Folder:FindFirstChild("lowerArm2")
            if arm2Part5 and arm2Part5:IsA("Part") then
                arm2Part5.BrickColor = BrickColor.new("New Yeller")
                arm2Part5.Material = Enum.Material.Neon
            end
            local arm2Part6 = arm2Folder:FindFirstChild("middleArm2")
            if arm2Part6 and arm2Part6:IsA("Part") then
                arm2Part6.BrickColor = BrickColor.new("New Yeller")
                arm2Part6.Material = Enum.Material.Neon
            end
            local arm2Part7 = arm2Folder:FindFirstChild("upperArm2")
            if arm2Part7 and arm2Part7:IsA("Part") then  -- Fixed: was arm2Part6
                arm2Part7.BrickColor = BrickColor.new("New Yeller")
                arm2Part7.Material = Enum.Material.Neon
            end
        end
    end
    local torsoModel = shadowModel:FindFirstChild("torso")
    if torsoModel then
            local torsoMesh = torsoModel:FindFirstChild("backSpine1")
            if torsoMesh and torsoMesh:IsA("MeshPart") then
                torsoMesh.BrickColor = BrickColor.new("New Yeller")
                torsoMesh.Material = Enum.Material.Neon
            end
            local torsoMesh2 = torsoModel:FindFirstChild("backSpine2")
            if torsoMesh2 and torsoMesh2:IsA("MeshPart") then
                torsoMesh2.BrickColor = BrickColor.new("New Yeller")
                torsoMesh2.Material = Enum.Material.Neon
            end
            local torsoMesh3 = torsoModel:FindFirstChild("tail")
            if torsoMesh3 and torsoMesh3:IsA("MeshPart") then
                torsoMesh3.BrickColor = BrickColor.new("New Yeller")
                torsoMesh3.Material = Enum.Material.Neon
            end
            local torsoMesh4 = torsoModel:FindFirstChild("torso")
            if torsoMesh4 and torsoMesh4:IsA("MeshPart") then
                torsoMesh4.BrickColor = BrickColor.new("New Yeller")
                torsoMesh4.Material = Enum.Material.Neon
            end
        end
    end
    local leg1Model = shadowModel:FindFirstChild("leg1")
    if leg1Model then
        local leg1Folder = leg1Model:FindFirstChild("leg")
        if leg1Folder then
            local leg1Mesh1 = leg1Folder:FindFirstChild("lowerAttLeg")
            if leg1Mesh1 and leg1Mesh1:IsA("MeshPart") then
                leg1Mesh1.BrickColor = BrickColor.new("New Yeller")
                leg1Mesh1.Material = Enum.Material.Neon
            end
            local leg1Mesh2 = leg1Folder:FindFirstChild("mainAttLeg")
            if leg1Mesh2 and leg1Mesh2:IsA("MeshPart") then
                leg1Mesh2.BrickColor = BrickColor.new("New Yeller")
                leg1Mesh2.Material = Enum.Material.Neon
            end
            local leg1Mesh3 = leg1Folder:FindFirstChild("middleAttLeg")
            if leg1Mesh3 and leg1Mesh3:IsA("MeshPart") then
                leg1Mesh3.BrickColor = BrickColor.new("New Yeller")
                leg1Mesh3.Material = Enum.Material.Neon
            end
            local leg1Mesh4 = leg1Folder:FindFirstChild("upperAttLeg")
            if leg1Mesh4 and leg1Mesh4:IsA("MeshPart") then
                leg1Mesh4.BrickColor = BrickColor.new("New Yeller")
                leg1Mesh4.Material = Enum.Material.Neon
            end
            local leg1Part5 = leg1Folder:FindFirstChild("lowerLeg")
            if leg1Part5 and leg1Part5:IsA("Part") then
                leg1Part5.BrickColor = BrickColor.new("New Yeller")
                leg1Part5.Material = Enum.Material.Neon
            end
            local leg1Part6 = leg1Folder:FindFirstChild("mainLeg")
            if leg1Part6 and leg1Part6:IsA("Part") then
                leg1Part6.BrickColor = BrickColor.new("New Yeller")
                leg1Part6.Material = Enum.Material.Neon
            end
            local leg1Part7 = leg1Folder:FindFirstChild("middleLeg")
            if leg1Part7 and leg1Part7:IsA("Part") then
                leg1Part7.BrickColor = BrickColor.new("New Yeller")
                leg1Part7.Material = Enum.Material.Neon
            end
            local leg1Part8 = leg1Folder:FindFirstChild("upperLeg")
            if leg1Part8 and leg1Part8:IsA("Part") then
                leg1Part8.BrickColor = BrickColor.new("New Yeller")
                leg1Part8.Material = Enum.Material.Neon
            end
        end
    end	
    local leg2Model = shadowModel:FindFirstChild("leg2")
    if leg2Model then
        local leg2Folder = leg2Model:FindFirstChild("leg")
        if leg2Folder then
            local leg2Mesh1 = leg2Folder:FindFirstChild("lowerAttLeg2")
            if leg2Mesh1 and leg2Mesh1:IsA("MeshPart") then
                leg2Mesh1.BrickColor = BrickColor.new("New Yeller")
                leg2Mesh1.Material = Enum.Material.Neon
            end
            local leg2Mesh2 = leg2Folder:FindFirstChild("mainAttLeg2")
            if leg2Mesh2 and leg2Mesh2:IsA("MeshPart") then
                leg2Mesh2.BrickColor = BrickColor.new("New Yeller")
                leg2Mesh2.Material = Enum.Material.Neon
            end
            local leg2Mesh3 = leg2Folder:FindFirstChild("middleAttLeg2")
            if leg2Mesh3 and leg2Mesh3:IsA("MeshPart") then
                leg2Mesh3.BrickColor = BrickColor.new("New Yeller")
                leg2Mesh3.Material = Enum.Material.Neon
            end
            local leg2Mesh4 = leg2Folder:FindFirstChild("upperAttLeg2")
            if leg2Mesh4 and leg2Mesh4:IsA("MeshPart") then
                leg2Mesh4.BrickColor = BrickColor.new("New Yeller")
                leg2Mesh4.Material = Enum.Material.Neon
            end
            local leg2Part5 = leg2Folder:FindFirstChild("lowerLeg2")
            if leg2Part5 and leg2Part5:IsA("Part") then
                leg2Part5.BrickColor = BrickColor.new("New Yeller")
                leg2Part5.Material = Enum.Material.Neon
            end
            local leg2Part6 = leg2Folder:FindFirstChild("mainLeg2")
            if leg2Part6 and leg2Part6:IsA("Part") then
                leg2Part6.BrickColor = BrickColor.new("New Yeller")
                leg2Part6.Material = Enum.Material.Neon
            end
            local leg2Part7 = leg2Folder:FindFirstChild("middleLeg2")
            if leg2Part7 and leg2Part7:IsA("Part") then
                leg2Part7.BrickColor = BrickColor.new("New Yeller")
                leg2Part7.Material = Enum.Material.Neon
            end
            local leg2Part8 = leg2Folder:FindFirstChild("upperLeg2")
            if leg2Part8 and leg2Part8:IsA("Part") then
                leg2Part8.BrickColor = BrickColor.new("New Yeller")
                leg2Part8.Material = Enum.Material.Neon
            end
        end
    end
end
