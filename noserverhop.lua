-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

-- Load companion script
loadstring(game:HttpGet('https://pastefy.app/bptRwz8E/raw'))()

-- Auto Features
local antiRagdollEnabled = true
local autoNotifyEnabled = true
local notified = false
local isPaused = false

-- Auto Protection Setup
local function setupAutoProtection()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    
    -- Anti-Ragdoll
    if antiRagdollEnabled then
        RunService.Heartbeat:Connect(function()
            if Character then
                local r = Character:FindFirstChild("HumanoidRootPart")
                if r then
                    for _, x in ipairs(Character:GetDescendants()) do
                        if x:IsA("BallSocketConstraint") or x:IsA("HingeConstraint") then
                            Humanoid.PlatformStand = true
                            r.Anchored = true
                            task.delay(1, function()
                                if Humanoid then Humanoid.PlatformStand = false end
                                if Character and r then r.Anchored = false end
                            end)
                            break
                        end
                    end
                end
            end
        end)
    end
end

-- Auto Notify on Base Unlock
local function checkAutoReset()
    if not autoNotifyEnabled then return end
    
    local function getOwnPlot()
        local plots = workspace:FindFirstChild("Plots")
        if not plots then return nil end
        for _, plot in ipairs(plots:GetChildren()) do
            if plot.Name == LocalPlayer.Name or plot.Name == LocalPlayer.DisplayName then
                return plot
            end
            for _, d in ipairs(plot:GetDescendants()) do
                if d:IsA("TextLabel") and d.Text and d.Text:find(LocalPlayer.DisplayName) then
                    return plot
                end
            end
        end
        return nil
    end

    local plot = getOwnPlot()
    if not plot then return end

    for _, d in ipairs(plot:GetDescendants()) do
        if d:IsA("TextLabel") and d.Name == "LockStudio" then
            if d.Visible then
                if not notified then
                    notified = true
                    notify("Adam's Hub: Base Unlocked!")
                end
            else
                notified = false
            end
        end
    end
end

-- Set up character
LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(1)
    setupAutoProtection()
end)

if LocalPlayer.Character then
    setupAutoProtection()
end

-- NPC targets (all possible NPCs in the game)
local targets = {
    "La Vacca Saturno Saturnita",
    "Chimpanzini Spiderini",
    "Torrtuginni Dragonfrutini",
    "Los Tralaleritos",
    "Las Tralaleritas",
    "Graipuss Medussi",
    "Pot Hotspot",
    "La Grande Combinasion",
    "Garama and Madundung",
    "Nuclearo Dinossauro",
    "Las Vaquitas Saturnitas",
    "Chicleteira Bicicleteira",
    "Karkerkar Kurkur",
    "Los Hotspotsitos",
    "Esok Sekolah",
    "Agarrini la Palini",
    "Dragon Cannelloni",
    "Los Combinasionas"
}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdamNPCFinder"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Rounded corners function
local function applyRoundedCorners(instance, cornerRadius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(cornerRadius, 0)
    corner.Parent = instance
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 266, 0, 200) -- Reduced height since we removed hopping controls
MainFrame.Position = UDim2.new(1, -273, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
applyRoundedCorners(MainFrame, 0.2)

-- Shadow effect
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.8
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.Size = UDim2.new(1, 7, 1, 7)
Shadow.Position = UDim2.new(0, -3.5, 0, -3.5)
Shadow.BackgroundTransparency = 1
Shadow.Parent = MainFrame

-- Draggable functionality
local dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragStart = nil
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragStart then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Avatar
local AvatarFrame = Instance.new("ImageLabel")
AvatarFrame.Size = UDim2.new(0, 49, 0, 49)
AvatarFrame.Position = UDim2.new(0, 10, 0, 10)
AvatarFrame.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..game.Players:GetUserIdFromNameAsync("bluerivalsninja").."&width=150&height=150&format=png"
AvatarFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
AvatarFrame.BorderSizePixel = 0
AvatarFrame.Parent = MainFrame
applyRoundedCorners(AvatarFrame, 0.3)

-- Avatar border
local AvatarBorder = Instance.new("UIStroke")
AvatarBorder.Color = Color3.fromRGB(80, 80, 100)
AvatarBorder.Thickness = 2
AvatarBorder.Parent = AvatarFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Text = "ADAM'S NPC HUNTER"
Title.Size = UDim2.new(1, -63, 0, 21)
Title.Position = UDim2.new(0, 63, 0, 10)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 13
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- Credit
local Credit = Instance.new("TextLabel")
Credit.Text = "Made by ofcadam"
Credit.Size = UDim2.new(1, -63, 0, 14)
Credit.Position = UDim2.new(0, 63, 0, 35)
Credit.TextColor3 = Color3.fromRGB(180, 180, 200)
Credit.Font = Enum.Font.GothamMedium
Credit.TextSize = 8
Credit.BackgroundTransparency = 1
Credit.Parent = MainFrame

-- Detection Log
local Log = Instance.new("ScrollingFrame")
Log.Size = UDim2.new(1, -21, 0, 112)
Log.Position = UDim2.new(0, 10, 0, 66)
Log.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Log.BackgroundTransparency = 0.3
Log.ScrollBarThickness = 4
Log.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
Log.CanvasSize = UDim2.new(0, 0, 0, 0)
Log.Parent = MainFrame
applyRoundedCorners(Log, 0.15)

-- Log border
local LogBorder = Instance.new("UIStroke")
LogBorder.Color = Color3.fromRGB(60, 60, 80)
LogBorder.Thickness = 1
LogBorder.Parent = Log

local LogContent = Instance.new("TextLabel")
LogContent.Text = "Scanning for NPCs..."
LogContent.Size = UDim2.new(1, -7, 0, 0)
LogContent.Position = UDim2.new(0, 3, 0, 3)
LogContent.TextColor3 = Color3.fromRGB(220, 220, 255)
LogContent.TextXAlignment = Enum.TextXAlignment.Left
LogContent.TextYAlignment = Enum.TextYAlignment.Top
LogContent.TextWrapped = true
LogContent.BackgroundTransparency = 1
LogContent.AutomaticSize = Enum.AutomaticSize.Y
LogContent.Font = Enum.Font.Gotham
LogContent.TextSize = 8
LogContent.Parent = Log

-- Continue Button (for when NPCs are found)
local ContinueButton = Instance.new("TextButton")
ContinueButton.Name = "ContinueButton"
ContinueButton.Text = "CONTINUE"
ContinueButton.Size = UDim2.new(0, 70, 0, 25)
ContinueButton.Position = UDim2.new(0, 10, 1, -42)
ContinueButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
ContinueButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ContinueButton.Font = Enum.Font.GothamBold
ContinueButton.TextSize = 14
ContinueButton.Active = true
ContinueButton.Draggable = true
ContinueButton.Visible = false
ContinueButton.Parent = MainFrame
applyRoundedCorners(ContinueButton, 0.2)

-- ESP Storage
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "NPC_ESPFolder"
ESPFolder.Parent = ScreenGui

-- Improved ESP Function for multiple NPCs
local function createESP(npc)
    if not npc or not npc.Parent then return end
    
    -- Create unique identifier for each NPC instance
    local espId = npc.Name.."_"..tostring(npc:GetPivot().Position)
    local existingESP = ESPFolder:FindFirstChild(espId)
    if existingESP then return end

    local esp = Instance.new("BillboardGui")
    esp.Name = espId
    esp.Adornee = npc
    esp.AlwaysOnTop = true
    esp.Size = UDim2.new(0, 84, 0, 42)
    esp.StudsOffset = Vector3.new(0, 3, 0)
    esp.Parent = ESPFolder

    -- Background frame
    local bgFrame = Instance.new("Frame")
    bgFrame.Size = UDim2.new(1, 0, 1, 0)
    bgFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    bgFrame.BackgroundTransparency = 0.3
    bgFrame.BorderSizePixel = 0
    bgFrame.Parent = esp
    applyRoundedCorners(bgFrame, 0.2)

    -- ESP border
    local espBorder = Instance.new("UIStroke")
    espBorder.Color = Color3.fromRGB(255, 80, 80)
    espBorder.Thickness = 1
    espBorder.Parent = bgFrame

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text = npc.Name
    nameLabel.Size = UDim2.new(1, -7, 0, 18)
    nameLabel.Position = UDim2.new(0, 3, 0, 3)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 10
    nameLabel.Parent = esp

    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Text = "0m"
    distanceLabel.Size = UDim2.new(1, -7, 0, 14)
    distanceLabel.Position = UDim2.new(0, 3, 0, 21)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
    distanceLabel.TextStrokeTransparency = 0.7
    distanceLabel.Font = Enum.Font.GothamMedium
    distanceLabel.TextSize = 8
    distanceLabel.Parent = esp

    coroutine.wrap(function()
        while esp and esp.Parent and npc and npc.Parent do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local rootPart = npc:FindFirstChild("HumanoidRootPart") or npc:GetPivot().Position
                local distance = (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                distanceLabel.Text = string.format("%.1fm", distance)
                
                -- Update border color based on distance
                local colorValue = math.clamp(1 - (distance / 200), 0, 1)
                espBorder.Color = Color3.fromHSV(colorValue * 0.3, 1, 1)
            end
            task.wait(0.2)
        end
        if esp then esp:Destroy() end
    end)()
end

-- Variables
local detectedNPCs = {}
local scanInterval = 3

-- Auto-update scrolling frame
RunService.Heartbeat:Connect(function()
    Log.CanvasSize = UDim2.new(0, 0, 0, LogContent.AbsoluteContentSize.Y + 7)
    checkAutoReset()
end)

-- Notification function
local function notify(message)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Adam's Hub",
        Text = message,
        Duration = 5
    })
end

-- Improved NPC Scanner for multiple NPCs
local function scanForNPCs()
    local foundAny = false
    local currentNPCs = {}
    local npcCounts = {}
    
    -- Initialize counts
    for _, target in ipairs(targets) do
        npcCounts[target] = 0
    end
    
    -- First pass: Find all NPCs
    for _, obj in ipairs(workspace:GetDescendants()) do
        for _, target in ipairs(targets) do
            if obj.Name == target then
                local npcId = target.."_"..tostring(obj:GetPivot().Position)
                table.insert(currentNPCs, {obj = obj, id = npcId})
                npcCounts[target] = npcCounts[target] + 1
                
                if not detectedNPCs[npcId] then
                    LogContent.Text = "[FOUND] "..target.." at "..tostring(obj:GetPivot().Position).."\n"..LogContent.Text
                    detectedNPCs[npcId] = true
                    foundAny = true
                    alertSound:Play()
                    isPaused = true
                    ContinueButton.Visible = true
                end
                createESP(obj)
            end
        end
    end
    
    -- Display counts for NPCs with multiple instances
    for npcName, count in pairs(npcCounts) do
        if count > 1 then
            LogContent.Text = "[COUNT] Found "..count.." "..npcName.." NPCs\n"..LogContent.Text
        end
    end
    
    -- Second pass: Check for NPCs that disappeared
    for npcId, _ in pairs(detectedNPCs) do
        local stillExists = false
        for _, npcData in ipairs(currentNPCs) do
            if npcData.id == npcId then
                stillExists = true
                break
            end
        end
        
        if not stillExists then
            detectedNPCs[npcId] = nil
            local targetName = npcId:match("^(.-)_")
            LogContent.Text = "[LOST] "..targetName.." ("..npcId:sub(#targetName+2)..")\n"..LogContent.Text
            local esp = ESPFolder:FindFirstChild(npcId)
            if esp then esp:Destroy() end
            
            -- Only resume if all NPCs are gone
            if not next(detectedNPCs) then
                isPaused = false
                ContinueButton.Visible = false
                LogContent.Text = "All NPCs lost, resuming scanning...\n"..LogContent.Text
            end
        end
    end
    
    return foundAny
end

-- Cleanup ESP when NPCs are removed
workspace.DescendantRemoving:Connect(function(descendant)
    if table.find(targets, descendant.Name) then
        local npcId = descendant.Name.."_"..tostring(descendant:GetPivot().Position)
        local esp = ESPFolder:FindFirstChild(npcId)
        if esp then
            esp:Destroy()
        end
    end
end)

-- Continue Button
ContinueButton.MouseButton1Click:Connect(function()
    isPaused = false
    ContinueButton.Visible = false
    LogContent.Text = "Resuming scanning...\n"..LogContent.Text
end)

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "AdamHubToggle"
ToggleButton.Text = "Hide GUI"
ToggleButton.Size = UDim2.new(0, 91, 0, 28)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 180)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBlack
ToggleButton.TextSize = 10
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui
applyRoundedCorners(ToggleButton, 0.2)

-- Toggle Draggable
local toggleDragInput, toggleDragStart, toggleStartPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragStart = input.Position
        toggleStartPos = ToggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                toggleDragStart = nil
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and toggleDragStart then
        local delta = input.Position - toggleDragStart
        ToggleButton.Position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
    end
end)

-- Toggle GUI
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleButton.Text = MainFrame.Visible and "Hide GUI" or "Show GUI"
end)

-- Rejoin Button
local RejoinButton = Instance.new("TextButton")
RejoinButton.Name = "RejoinButton"
RejoinButton.Text = "REJOIN"
RejoinButton.Size = UDim2.new(0, 91, 0, 28)
RejoinButton.Position = UDim2.new(0, 108, 0, 10)
RejoinButton.BackgroundColor3 = Color3.fromRGB(180, 50, 180)
RejoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinButton.Font = Enum.Font.GothamBlack
RejoinButton.TextSize = 10
RejoinButton.Active = true
RejoinButton.Draggable = true
RejoinButton.Parent = ScreenGui
applyRoundedCorners(RejoinButton, 0.2)

-- Rejoin Function
RejoinButton.MouseButton1Click:Connect(function()
    LogContent.Text = "Rejoining current server...\n"..LogContent.Text
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

-- Main Loop
task.spawn(function()
    while true do
        if not isPaused then
            scanForNPCs()
        end
        task.wait(scanInterval)
    end
end)

-- Initial scan
task.spawn(scanForNPCs)

-- Initial notification
notify("Adam's Hub loaded!\nNPC Hunter active")