

------------------------------------------------------------

-- SERVICES & VARIABLES
------------------------------------------------------------
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local Cam = workspace.CurrentCamera

-- Folder with runtime items (for item teleportation)
local runtimeItemsFolder = workspace:WaitForChild("RuntimeItems")
local playerGui = player:WaitForChild("PlayerGui")

------------------------------------------------------------
-- MAIN UI: Teleport Panel (Landscape) Setup
------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- Increase panel size to 500x500 to allow extra aimbot and fullbright settings
local teleportPanel = Instance.new("Frame")
teleportPanel.Name = "TeleportPanel"
teleportPanel.Size = UDim2.new(0, 500, 0, 500)
teleportPanel.AnchorPoint = Vector2.new(0.5, 0.5)
teleportPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
teleportPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
teleportPanel.BorderSizePixel = 0
teleportPanel.Parent = screenGui

------------------------------------------------------------
-- TOGGLE BUTTON: Show/Hide the Teleport Panel
------------------------------------------------------------
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60, 0, 30)
toggleButton.Position = UDim2.new(1, -70, 1, -40)  -- Bottom-right corner
toggleButton.AnchorPoint = Vector2.new(1, 1)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "Hide"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.TextScaled = true
toggleButton.Parent = screenGui

toggleButton.MouseButton1Click:Connect(function()
	teleportPanel.Visible = not teleportPanel.Visible
	toggleButton.Text = teleportPanel.Visible and "Hide" or "Show"
end)

------------------------------------------------------------
-- SPLIT THE PANEL INTO LEFT and RIGHT COLUMNS
------------------------------------------------------------
-- Left Column: Contains Item Teleportation and FullBright
local leftColumn = Instance.new("Frame")
leftColumn.Name = "LeftColumn"
leftColumn.Size = UDim2.new(0, 250, 1, 0)
leftColumn.Position = UDim2.new(0, 0, 0, 0)
leftColumn.BackgroundTransparency = 1
leftColumn.Parent = teleportPanel

-- Right Column: Split into two halves (Top: Player TP, Bottom: Aimbot Settings)
local rightColumn = Instance.new("Frame")
rightColumn.Name = "RightColumn"
rightColumn.Size = UDim2.new(0, 250, 1, 0)
rightColumn.Position = UDim2.new(0, 250, 0, 0)
rightColumn.BackgroundTransparency = 1
rightColumn.Parent = teleportPanel

------------------------------------------------------------
-- SECTION 1: ITEM TELEPORTATION (Left Column - Top Part)
------------------------------------------------------------
local itemsSection = Instance.new("Frame")
itemsSection.Name = "ItemsSection"
-- Increase height to accommodate the selected-items display
itemsSection.Size = UDim2.new(1, 0, 0, 225)
itemsSection.Position = UDim2.new(0, 0, 0, 0)
itemsSection.BackgroundTransparency = 1
itemsSection.Parent = leftColumn

local itemsLabel = Instance.new("TextLabel")
itemsLabel.Name = "ItemsLabel"
itemsLabel.Size = UDim2.new(0, 230, 0, 20)
itemsLabel.Position = UDim2.new(0, 10, 0, 5)
itemsLabel.BackgroundTransparency = 1
itemsLabel.Text = "Item Teleportation"
itemsLabel.TextColor3 = Color3.new(1, 1, 1)
itemsLabel.TextScaled = true
itemsLabel.Parent = itemsSection

local bringAllButton = Instance.new("TextButton")
bringAllButton.Name = "BringAllButton"
bringAllButton.Size = UDim2.new(0, 110, 0, 30)
bringAllButton.Position = UDim2.new(0, 10, 0, 30)
bringAllButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
bringAllButton.BorderSizePixel = 0
bringAllButton.Text = "Bring All Items"
bringAllButton.TextColor3 = Color3.new(1, 1, 1)
bringAllButton.TextScaled = true
bringAllButton.Parent = itemsSection

local bringSelectedButton = Instance.new("TextButton")
bringSelectedButton.Name = "BringSelectedButton"
bringSelectedButton.Size = UDim2.new(0, 110, 0, 30)
bringSelectedButton.Position = UDim2.new(0, 130, 0, 30)
bringSelectedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
bringSelectedButton.BorderSizePixel = 0
bringSelectedButton.Text = "Bring Selected"
bringSelectedButton.TextColor3 = Color3.new(1, 1, 1)
bringSelectedButton.TextScaled = true
bringSelectedButton.Parent = itemsSection

local storeSelectedButton = Instance.new("TextButton")
storeSelectedButton.Name = "StoreSelectedButton"
storeSelectedButton.Size = UDim2.new(0, 230, 0, 30)
storeSelectedButton.Position = UDim2.new(0, 10, 0, 65)
storeSelectedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
storeSelectedButton.BorderSizePixel = 0
storeSelectedButton.Text = "Store Selected"
storeSelectedButton.TextColor3 = Color3.new(1, 1, 1)
storeSelectedButton.TextScaled = true
storeSelectedButton.Parent = itemsSection

local itemsList = Instance.new("ScrollingFrame")
itemsList.Name = "ItemsList"
itemsList.Size = UDim2.new(0, 230, 0, 75)
itemsList.Position = UDim2.new(0, 10, 0, 100)
itemsList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
itemsList.BorderSizePixel = 0
itemsList.Parent = itemsSection

local itemsListLayout = Instance.new("UIListLayout")
itemsListLayout.Parent = itemsList
itemsListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- New: Label to display the names of selected items
local selectedItemsDisplayLabel = Instance.new("TextLabel")
selectedItemsDisplayLabel.Name = "SelectedItemsDisplayLabel"
selectedItemsDisplayLabel.Size = UDim2.new(0, 230, 0, 40)
selectedItemsDisplayLabel.Position = UDim2.new(0, 10, 0, 175)
selectedItemsDisplayLabel.BackgroundTransparency = 1
selectedItemsDisplayLabel.TextColor3 = Color3.new(1, 1, 1)
selectedItemsDisplayLabel.TextScaled = true
selectedItemsDisplayLabel.Text = "Selected Items: None"
selectedItemsDisplayLabel.Parent = itemsSection

-- Table to hold names of selected item groups (keys are item names)
local selectedItems = {}

local function updateSelectedItemsDisplayLabel()
    local selectedList = {}
    for key, _ in pairs(selectedItems) do
        table.insert(selectedList, key)
    end
    if #selectedList > 0 then
        selectedItemsDisplayLabel.Text = "Selected Items: " .. table.concat(selectedList, ", ")
    else
        selectedItemsDisplayLabel.Text = "Selected Items: None"
    end
end

local function populateItemsList()
	-- Clear existing buttons
	for _, child in ipairs(itemsList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	-- Group items by name
	local groups = {}
	for _, item in ipairs(runtimeItemsFolder:GetChildren()) do
		local name = item.Name
		groups[name] = (groups[name] or 0) + 1
	end
	
	-- Create one button per group, showing "Name (count)"
	for name, count in pairs(groups) do
		local itemButton = Instance.new("TextButton")
		itemButton.Size = UDim2.new(1, 0, 0, 30)
		itemButton.Text = name .. " (" .. count .. ")"
		itemButton.BorderSizePixel = 0
		itemButton.TextScaled = true
		if selectedItems[name] then
			itemButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		else
			itemButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end
		itemButton.Parent = itemsList
		
		itemButton.MouseButton1Click:Connect(function()
			if selectedItems[name] then
				selectedItems[name] = nil
				itemButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			else
				selectedItems[name] = true
				itemButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
			end
			updateSelectedItemsDisplayLabel()
		end)
	end
	-- Update the CanvasSize so all groups can be scrolled into view
	itemsList.CanvasSize = UDim2.new(0, 0, 0, itemsListLayout.AbsoluteContentSize.Y)
	updateSelectedItemsDisplayLabel()
end

-- Auto-refresh the items list every 0.1 seconds
spawn(function()
	while true do
		wait(0.1)
		populateItemsList()
	end
end)

local function teleportItem(item)
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:FindFirstChild("HumanoidRootPart")
	if root then
		if item:IsA("Model") and item.PrimaryPart then
			item:SetPrimaryPartCFrame(root.CFrame)
		elseif item:IsA("BasePart") then
			item.CFrame = root.CFrame
		end
	end
end

bringAllButton.MouseButton1Click:Connect(function()
	for _, item in ipairs(runtimeItemsFolder:GetChildren()) do
		teleportItem(item)
	end
	-- Clear selection after action
	selectedItems = {}
	updateSelectedItemsDisplayLabel()
	populateItemsList()
end)

bringSelectedButton.MouseButton1Click:Connect(function()
	-- Iterate over all items and teleport those with matching names
	for groupName, _ in pairs(selectedItems) do
		for _, item in ipairs(runtimeItemsFolder:GetChildren()) do
			if item.Name == groupName then
				teleportItem(item)
			end
		end
	end
	-- Clear selection after action
	selectedItems = {}
	updateSelectedItemsDisplayLabel()
	populateItemsList()
end)

storeSelectedButton.MouseButton1Click:Connect(function()
	-- For each selected group, store all matching items
	for groupName, _ in pairs(selectedItems) do
		for _, item in ipairs(runtimeItemsFolder:GetChildren()) do
			if item.Name == groupName then
				local args = { [1] = item }
				ReplicatedStorage.Remotes.StoreItem:FireServer(unpack(args))
			end
		end
	end
	-- Clear selection after action
	selectedItems = {}
	updateSelectedItemsDisplayLabel()
	populateItemsList()
end)

------------------------------------------------------------
-- SECTION 2: FULLBRIGHT (Left Column - Bottom Part)
------------------------------------------------------------
local fullBrightSection = Instance.new("Frame")
fullBrightSection.Name = "FullBrightSection"
fullBrightSection.Size = UDim2.new(1, 0, 0, 75)
fullBrightSection.Position = UDim2.new(0, 0, 0, 225)
fullBrightSection.BackgroundTransparency = 1
fullBrightSection.Parent = leftColumn

local fullBrightButton = Instance.new("TextButton")
fullBrightButton.Name = "FullBrightButton"
fullBrightButton.Size = UDim2.new(0, 230, 0, 30)
fullBrightButton.Position = UDim2.new(0, 10, 0, 20)
fullBrightButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fullBrightButton.BorderSizePixel = 0
fullBrightButton.Text = "FullBright: OFF"
fullBrightButton.TextColor3 = Color3.new(1,1,1)
fullBrightButton.TextScaled = true
fullBrightButton.Parent = fullBrightSection

fullBrightButton.MouseButton1Click:Connect(function()
	-- Run the fullbright code only once
	if not _G.FullBrightExecuted then
		_G.FullBrightEnabled = false
		_G.NormalLightingSettings = {
			Brightness = Lighting.Brightness,
			ClockTime = Lighting.ClockTime,
			FogEnd = Lighting.FogEnd,
			GlobalShadows = Lighting.GlobalShadows,
			Ambient = Lighting.Ambient
		}
		Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
			if Lighting.Brightness ~= 1 and Lighting.Brightness ~= _G.NormalLightingSettings.Brightness then
				_G.NormalLightingSettings.Brightness = Lighting.Brightness
				if not _G.FullBrightEnabled then
					repeat wait() until _G.FullBrightEnabled
				end
				Lighting.Brightness = 1
			end
		end)
		Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
			if Lighting.ClockTime ~= 12 and Lighting.ClockTime ~= _G.NormalLightingSettings.ClockTime then
				_G.NormalLightingSettings.ClockTime = Lighting.ClockTime
				if not _G.FullBrightEnabled then
					repeat wait() until _G.FullBrightEnabled
				end
				Lighting.ClockTime = 12
			end
		end)
		Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
			if Lighting.FogEnd ~= 786543 and Lighting.FogEnd ~= _G.NormalLightingSettings.FogEnd then
				_G.NormalLightingSettings.FogEnd = Lighting.FogEnd
				if not _G.FullBrightEnabled then
					repeat wait() until _G.FullBrightEnabled
				end
				Lighting.FogEnd = 786543
			end
		end)
		Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
			if Lighting.GlobalShadows ~= false and Lighting.GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
				_G.NormalLightingSettings.GlobalShadows = Lighting.GlobalShadows
				if not _G.FullBrightEnabled then
					repeat wait() until _G.FullBrightEnabled
				end
				Lighting.GlobalShadows = false
			end
		end)
		Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
			if Lighting.Ambient ~= Color3.fromRGB(178,178,178) and Lighting.Ambient ~= _G.NormalLightingSettings.Ambient then
				_G.NormalLightingSettings.Ambient = Lighting.Ambient
				if not _G.FullBrightEnabled then
					repeat wait() until _G.FullBrightEnabled
				end
				Lighting.Ambient = Color3.fromRGB(178,178,178)
			end
		end)
		Lighting.Brightness = 1
		Lighting.ClockTime = 12
		Lighting.FogEnd = 786543
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.fromRGB(178,178,178)
		
		local LatestValue = true
		spawn(function()
			repeat wait() until _G.FullBrightEnabled
			while wait() do
				if _G.FullBrightEnabled ~= LatestValue then
					if not _G.FullBrightEnabled then
						Lighting.Brightness = _G.NormalLightingSettings.Brightness
						Lighting.ClockTime = _G.NormalLightingSettings.ClockTime
						Lighting.FogEnd = _G.NormalLightingSettings.FogEnd
						Lighting.GlobalShadows = _G.NormalLightingSettings.GlobalShadows
						Lighting.Ambient = _G.NormalLightingSettings.Ambient
					else
						Lighting.Brightness = 1
						Lighting.ClockTime = 12
						Lighting.FogEnd = 786543
						Lighting.GlobalShadows = false
						Lighting.Ambient = Color3.fromRGB(178,178,178)
					end
					LatestValue = not LatestValue
				end
			end
		end)
		_G.FullBrightExecuted = true
	end
	_G.FullBrightEnabled = not _G.FullBrightEnabled
	fullBrightButton.Text = "FullBright: " .. (_G.FullBrightEnabled and "ON" or "OFF")
end)

------------------------------------------------------------
-- SECTION 3: PLAYER TELEPORTATION (Right Column - Top Half)
------------------------------------------------------------
local playerSection = Instance.new("Frame")
playerSection.Name = "PlayerSection"
playerSection.Size = UDim2.new(1, 0, 0.5, 0)  -- Top half of right column
playerSection.Position = UDim2.new(0, 0, 0, 0)
playerSection.BackgroundTransparency = 1
playerSection.Parent = rightColumn

local playerLabel = Instance.new("TextLabel")
playerLabel.Name = "PlayerLabel"
playerLabel.Size = UDim2.new(0, 230, 0, 20)
playerLabel.Position = UDim2.new(0, 10, 0, 5)
playerLabel.BackgroundTransparency = 1
playerLabel.Text = "Player Teleportation"
playerLabel.TextColor3 = Color3.new(1, 1, 1)
playerLabel.TextScaled = true
playerLabel.Parent = playerSection

local selectPlayerButton = Instance.new("TextButton")
selectPlayerButton.Name = "SelectPlayerButton"
selectPlayerButton.Size = UDim2.new(0, 230, 0, 30)
selectPlayerButton.Position = UDim2.new(0, 10, 0, 30)
selectPlayerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
selectPlayerButton.BorderSizePixel = 0
selectPlayerButton.Text = "Select Player"
selectPlayerButton.TextColor3 = Color3.new(1, 1, 1)
selectPlayerButton.TextScaled = true
selectPlayerButton.Parent = playerSection

local playerDropdown = Instance.new("ScrollingFrame")
playerDropdown.Name = "PlayerDropdown"
playerDropdown.Size = UDim2.new(0, 230, 0, 150)
playerDropdown.Position = UDim2.new(0, 10, 0, 65)
playerDropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerDropdown.BorderSizePixel = 0
playerDropdown.Visible = false
playerDropdown.Parent = playerSection

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Parent = playerDropdown
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local selectedPlayer = nil

local function populatePlayerDropdown()
	-- Clear existing player buttons
	for _, child in ipairs(playerDropdown:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			local playerButton = Instance.new("TextButton")
			playerButton.Size = UDim2.new(1, 0, 0, 30)
			playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			playerButton.BorderSizePixel = 0
			playerButton.Text = p.Name
			playerButton.TextScaled = true
			playerButton.Parent = playerDropdown
			
			playerButton.MouseButton1Click:Connect(function()
				selectedPlayer = p
				selectPlayerButton.Text = "Player: " .. p.Name
				playerDropdown.Visible = false
			end)
		end
	end
	-- Update CanvasSize to display all players
	playerDropdown.CanvasSize = UDim2.new(0, 0, 0, playerListLayout.AbsoluteContentSize.Y)
end

selectPlayerButton.MouseButton1Click:Connect(function()
	playerDropdown.Visible = not playerDropdown.Visible
	-- On opening, refresh the list immediately.
	if playerDropdown.Visible then
		populatePlayerDropdown()
	end
end)

-- Auto-refresh the player dropdown every 0.75 seconds if visible.
spawn(function()
	while true do
		wait(0.75)
		if playerDropdown.Visible then
			populatePlayerDropdown()
		end
	end
end)

local teleportToPlayerButton = Instance.new("TextButton")
teleportToPlayerButton.Name = "TeleportToPlayerButton"
teleportToPlayerButton.Size = UDim2.new(0, 230, 0, 30)
teleportToPlayerButton.Position = UDim2.new(0, 10, 0, 220)
teleportToPlayerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
teleportToPlayerButton.BorderSizePixel = 0
teleportToPlayerButton.Text = "Teleport To Player"
teleportToPlayerButton.TextColor3 = Color3.new(1, 1, 1)
teleportToPlayerButton.TextScaled = true
teleportToPlayerButton.Parent = playerSection

teleportToPlayerButton.MouseButton1Click:Connect(function()
	if selectedPlayer then
		local targetCharacter = selectedPlayer.Character
		if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
			local targetCFrame = targetCharacter.HumanoidRootPart.CFrame
			local character = player.Character or player.CharacterAdded:Wait()
			local root = character:FindFirstChild("HumanoidRootPart")
			if root then
				root.CFrame = targetCFrame
			else
				warn("Local player's HumanoidRootPart not found.")
			end
		else
			warn("Selected player's character or HumanoidRootPart not available.")
		end
	else
		warn("No player selected.")
	end
end)

------------------------------------------------------------
-- SECTION 4: AIMBOT SETTINGS (Right Column - Bottom Half)
------------------------------------------------------------
local aimbotSection = Instance.new("Frame")
aimbotSection.Name = "AimbotSection"
aimbotSection.Size = UDim2.new(1, 0, 0.5, 0)  -- Bottom half of right column
aimbotSection.Position = UDim2.new(0, 0, 0.5, 0)
aimbotSection.BackgroundTransparency = 1
aimbotSection.Parent = rightColumn

local aimbotLabel = Instance.new("TextLabel")
aimbotLabel.Name = "AimbotLabel"
aimbotLabel.Size = UDim2.new(0, 230, 0, 20)
aimbotLabel.Position = UDim2.new(0, 10, 0, 5)
aimbotLabel.BackgroundTransparency = 1
aimbotLabel.Text = "Aimbot Settings"
aimbotLabel.TextColor3 = Color3.new(1, 1, 1)
aimbotLabel.TextScaled = true
aimbotLabel.Parent = aimbotSection

local aimbotToggleButton = Instance.new("TextButton")
aimbotToggleButton.Name = "AimbotToggleButton"
aimbotToggleButton.Size = UDim2.new(0, 230, 0, 30)
aimbotToggleButton.Position = UDim2.new(0, 10, 0, 30)
aimbotToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
aimbotToggleButton.Text = "AIMBOT: OFF"
aimbotToggleButton.TextColor3 = Color3.fromRGB(255, 50, 50)
aimbotToggleButton.TextScaled = true
aimbotToggleButton.Parent = aimbotSection

local fovTextBox = Instance.new("TextBox")
fovTextBox.Name = "FOVTextBox"
fovTextBox.Size = UDim2.new(0, 230, 0, 30)
fovTextBox.Position = UDim2.new(0, 10, 0, 70)
fovTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
fovTextBox.BorderSizePixel = 0
fovTextBox.Text = "136"  -- Default FOV value
fovTextBox.TextColor3 = Color3.new(1, 1, 1)
fovTextBox.TextScaled = true
fovTextBox.ClearTextOnFocus = true
fovTextBox.Parent = aimbotSection

------------------------------------------------------------
-- AIMBOT CODE & DRAWING SETUP
------------------------------------------------------------
local fov = 136
local isAiming = false

-- Create a Drawing circle for the FOV indicator
local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 2
FOVring.Color = Color3.fromRGB(128, 0, 128)
FOVring.Filled = false
FOVring.Radius = fov
FOVring.Position = Cam.ViewportSize / 2

local function isNPC(obj)
    return obj:IsA("Model") 
        and obj:FindFirstChild("Humanoid")
        and obj.Humanoid.Health > 0
        and obj:FindFirstChild("Head")
        and obj:FindFirstChild("HumanoidRootPart")
        and not Players:GetPlayerFromCharacter(obj)
end

local validNPCs = {}
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

local function updateNPCs()
    local tempTable = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if isNPC(obj) then
            tempTable[obj] = true
        end
    end
    for i = #validNPCs, 1, -1 do
        if not tempTable[validNPCs[i]] then
            table.remove(validNPCs, i)
        end
    end
    for obj in pairs(tempTable) do
        if not table.find(validNPCs, obj) then
            table.insert(validNPCs, obj)
        end
    end
end

local function predictPos(target)
    local rootPart = target:FindFirstChild("HumanoidRootPart")
    local head = target:FindFirstChild("Head")
    if not rootPart or not head then
        return head and head.Position or rootPart and rootPart.Position
    end
    local velocity = rootPart.Velocity
    local predictionTime = 0.02
    local basePosition = rootPart.Position + velocity * predictionTime
    local headOffset = head.Position - rootPart.Position
    return basePosition + headOffset
end

local function getTarget()
    local nearest = nil
    local minDistance = math.huge
    local viewportCenter = Cam.ViewportSize / 2
    raycastParams.FilterDescendantsInstances = {player.Character}
    for _, npc in ipairs(validNPCs) do
        local predictedPos = predictPos(npc)
        local screenPos, visible = Cam:WorldToViewportPoint(predictedPos)
        if visible and screenPos.Z > 0 then
            local ray = workspace:Raycast(
                Cam.CFrame.Position,
                (predictedPos - Cam.CFrame.Position).Unit * 1000,
                raycastParams
            )
            if ray and ray.Instance:IsDescendantOf(npc) then
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - viewportCenter).Magnitude
                if distance < minDistance and distance < fov then
                    minDistance = distance
                    nearest = npc
                end
            end
        end
    end
    return nearest
end

local function aim(targetPosition)
    local currentCF = Cam.CFrame
    local targetDirection = (targetPosition - currentCF.Position).Unit
    local smoothFactor = 0.581
    local newLookVector = currentCF.LookVector:Lerp(targetDirection, smoothFactor)
    Cam.CFrame = CFrame.new(currentCF.Position, currentCF.Position + newLookVector)
end

local heartbeat = RunService.Heartbeat
local lastUpdate = 0
local UPDATE_INTERVAL = 0.4

heartbeat:Connect(function(dt)
    FOVring.Position = Cam.ViewportSize / 2
    FOVring.Radius = fov * (Cam.ViewportSize.Y / 1080)
    lastUpdate = lastUpdate + dt
    if lastUpdate >= UPDATE_INTERVAL then
        updateNPCs()
        lastUpdate = 0
    end
    if isAiming then
        local target = getTarget()
        if target then
            local predictedPosition = predictPos(target)
            aim(predictedPosition)
        end
    end
end)

fovTextBox.FocusLost:Connect(function(enterPressed)
    local newFov = tonumber(fovTextBox.Text)
    if newFov then
        fov = newFov
    else
        fovTextBox.Text = tostring(fov)
    end
end)

aimbotToggleButton.MouseButton1Click:Connect(function()
    isAiming = not isAiming
    FOVring.Visible = isAiming
    aimbotToggleButton.Text = "AIMBOT: " .. (isAiming and "ON" or "OFF")
    aimbotToggleButton.TextColor3 = isAiming and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
end)

Players.PlayerRemoving:Connect(function()
    FOVring:Remove()
end)

------------------------------------------------------------
-- DRAGGABLE UI (for the TeleportPanel)
------------------------------------------------------------
local dragging, dragStart, startPos

teleportPanel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = teleportPanel.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

teleportPanel.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        teleportPanel.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

------------------------------------------------------------
-- (Optional) CREDIT LABEL
------------------------------------------------------------
local creditLabel = Instance.new("TextLabel")
creditLabel.Name = "CreditLabel"
creditLabel.Size = UDim2.new(0, 200, 0, 20)
creditLabel.Position = UDim2.new(1, -10, 1, -10)
creditLabel.AnchorPoint = Vector2.new(1, 1)
creditLabel.BackgroundTransparency = 1
creditLabel.TextColor3 = Color3.new(1, 1, 1)
creditLabel.Text = "Made by TN Roblox"
creditLabel.TextScaled = true
creditLabel.Parent = teleportPanel
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
  if input.KeyCode == Enum.KeyCode.Z and not gameProcessedEvent then
   for _, item in ipairs(runtimeItemsFolder:GetChildren()) do
		teleportItem(item)
	end
	-- Clear selection after action
	selectedItems = {}
	updateSelectedItemsDisplayLabel()
	populateItemsList()
  end
end)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
  if input.KeyCode == Enum.KeyCode.X and not gameProcessedEvent then
    for groupName, _ in pairs(selectedItems) do
		for _, item in ipairs(runtimeItemsFolder:GetChildren()) do
			if item.Name == groupName then
				teleportItem(item)
			end
		end
	end
	-- Clear selection after action
	selectedItems = {}
	updateSelectedItemsDisplayLabel()
	populateItemsList()
  end
end)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
  if input.KeyCode == Enum.KeyCode.C and not gameProcessedEvent then
    for groupName, _ in pairs(selectedItems) do
		for _, item in ipairs(runtimeItemsFolder:GetChildren()) do
			if item.Name == groupName then
				local args = { [1] = item }
				ReplicatedStorage.Remotes.StoreItem:FireServer(unpack(args))
			end
		end
	end
	-- Clear selection after action
	selectedItems = {}
	updateSelectedItemsDisplayLabel()
	populateItemsList()
  end
end)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
  if input.KeyCode == Enum.KeyCode.K and not gameProcessedEvent then
    teleportPanel.Visible = not teleportPanel.Visible
	toggleButton.Text = teleportPanel.Visible and "Hide" or "Show"
  end
end)
