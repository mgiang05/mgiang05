-- Tăng tầm đánh và tốc độ đánh
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Tăng tầm đánh và tốc độ đánh
local function enhanceAttackRange()
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        local handle = tool:FindFirstChild("Handle") or tool:FindFirstChild("Blade")
        if handle then
            handle.Size = Vector3.new(50, 50, 50) -- Tăng kích thước hitbox
            handle.Transparency = 0.5 -- Làm hitbox trong suốt
            handle.Massless = true
        end
    end
end

-- Tự động trang bị Haki
local function autoEquipHaki()
    if player.Backpack:FindFirstChild("Buso") then
        local haki = player.Backpack:FindFirstChild("Buso")
        character.Humanoid:EquipTool(haki)
        haki:Activate()
    end
end

-- Tự động đánh quái
local function autoFarm()
    for i, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame
            autoEquipHaki()
            wait(0.2)
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end
end

-- Tự động làm nhiệm vụ
local function autoQuest()
    for i, npc in pairs(game.Workspace.NPCs:GetChildren()) do
        if npc:FindFirstChild("Head") then
            character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
            wait(0.5)
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", npc.Name)
            break
        end
    end
end

-- Tự động nhặt rương
local function autoCollectChests()
    for i, chest in pairs(game.Workspace.Chests:GetChildren()) do
        if chest:IsA("Model") then
            character.HumanoidRootPart.CFrame = chest.CFrame
            wait(0.5)
        end
    end
end

-- Tự động đánh boss
local function autoBossFarm()
    for i, boss in pairs(game.Workspace.Enemies:GetChildren()) do
        if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and boss.HumanoidRootPart.Name == "BossRootPart" then
            character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame
            autoEquipHaki()
            wait(0.2)
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end
end

-- Tự động nhặt trái cây
local function autoCollectFruits()
    for i, fruit in pairs(game.Workspace:GetChildren()) do
        if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
            character.HumanoidRootPart.CFrame = fruit.Handle.CFrame
            wait(0.5)
            fireclickdetector(fruit.Handle.ClickDetector) -- Nếu có ClickDetector
        end
    end
end

-- Tự động hóa tất cả
while wait(1) do
    enhanceAttackRange()
    autoFarm()
    autoQuest()
    autoCollectChests()
    autoBossFarm()
    autoCollectFruits()
end