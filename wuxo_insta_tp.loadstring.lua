-- Ready-to-run loadstring for WUXO HUB — paste this into your executor
loadstring([==[
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Get Humanoid and Character
local function getHumanoid()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid"), char
end

local Humanoid, Character = getHumanoid()
LocalPlayer.CharacterAdded:Connect(function(char)
    Humanoid = char:WaitForChild("Humanoid")
    Character = char
end)

-- === STARTUP TEXT FUNCTION ===
local function showStartupText()
    local startupGui = Instance.new("ScreenGui")
    startupGui.Name = "WUXOStartup"
    startupGui.Parent = CoreGui

    local startupLabel = Instance.new("TextLabel", startupGui)
    startupLabel.Size = UDim2.new(1,0,0,150)
    startupLabel.Position = UDim2.new(0.5,0,0.2,0)
    startupLabel.BackgroundTransparency = 1
    startupLabel.Text = "WUXO HUB\nhttps://discord.gg/H2apgRQBfp"
    startupLabel.TextColor3 = Color3.fromRGB(54,69,79)
    startupLabel.Font = Enum.Font.FredokaOne
    startupLabel.TextSize = 24
    startupLabel.TextScaled = true
    startupLabel.TextWrapped = true
    startupLabel.TextStrokeTransparency = 0.5
    startupLabel.TextStrokeColor3 = Color3.fromRGB(255,255,255)
    startupLabel.TextTransparency = 0

    local gradient = Instance.new("UIGradient", startupLabel)
    gradient.Rotation = 45
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(120,130,140)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(54,69,79)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150,160,170)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(54,69,79)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100,110,120))
    })

    local offset = 0
    RunService.RenderStepped:Connect(function(dt)
        offset = offset + dt * 2.5
        startupLabel.Position = UDim2.new(0.5, math.sin(offset)*15, 0.15, math.cos(offset)*5)
        startupLabel.AnchorPoint = Vector2.new(0.5,0.5)
    end)

    task.wait(5)
    startupGui:Destroy()
end

task.spawn(function()
    showStartupText()
end)

task.delay(5.1, function()
    -- === MAIN WUXO HUB GUI ===
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WUXOHUB"
    ScreenGui.Parent = CoreGui

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 400, 0, 320)
    Main.Position = UDim2.new(0.5, -200, 0.5, -160)
    Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.ClipsDescendants = true
    Main.Draggable = true
    local mainCorner = Instance.new("UICorner", Main)
    mainCorner.CornerRadius = UDim.new(0,20)
    local mainBorder = Instance.new("UIStroke", Main)
    mainBorder.Color = Color3.fromRGB(255,255,255)
    mainBorder.Thickness = 2

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1,0,0,50)
    Title.BackgroundTransparency = 1
    Title.Text = "WUXO HUB INSTA TP"
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.FredokaOne
    Title.TextSize = 36

    -- TP Variables
    local tpPoint = nil
    local tpMarker = nil

    -- Set TP Point Button
    local SetTPBtn = Instance.new("TextButton", Main)
    SetTPBtn.Size = UDim2.new(0, 320, 0, 55)
    SetTPBtn.Position = UDim2.new(0.5, -160, 0, 100)
    SetTPBtn.Text = "SET TP POINT"
    SetTPBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    SetTPBtn.TextColor3 = Color3.fromRGB(255,255,255)
    SetTPBtn.Font = Enum.Font.FredokaOne
    SetTPBtn.TextSize = 28
    SetTPBtn.AutoButtonColor = false
    Instance.new("UICorner", SetTPBtn).CornerRadius = UDim.new(0,25)
    local tpStroke = Instance.new("UIStroke", SetTPBtn)
    tpStroke.Color = Color3.fromRGB(255,255,255)

    SetTPBtn.MouseButton1Click:Connect(function()
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            tpPoint = Character.HumanoidRootPart.Position

            if tpMarker then tpMarker:Destroy() end
            tpMarker = Instance.new("Part")
            tpMarker.Size = Vector3.new(2,0.5,2)
            tpMarker.Anchored = true
            tpMarker.CanCollide = false
            tpMarker.Position = tpPoint + Vector3.new(0,1,0)
            tpMarker.Material = Enum.Material.Neon
            tpMarker.Color = Color3.fromRGB(255,255,255)
            tpMarker.Parent = Workspace

            local billboard = Instance.new("BillboardGui", tpMarker)
            billboard.Size = UDim2.new(0,100,0,50)
            billboard.StudsOffset = Vector3.new(0,2,0)
            billboard.AlwaysOnTop = true

            local textLabel = Instance.new("TextLabel", billboard)
            textLabel.Size = UDim2.new(1,0,1,0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = "TP POINT"
            textLabel.TextColor3 = Color3.fromRGB(255,255,255)
            textLabel.Font = Enum.Font.FredokaOne
            textLabel.TextScaled = true
        end
    end)

    -- Start Insta TP Button
    local StartBtn = Instance.new("TextButton", Main)
    StartBtn.Size = UDim2.new(0, 320, 0, 55)
    StartBtn.Position = UDim2.new(0.5,-160,0,160)
    StartBtn.Text = "START INSTA TP"
    StartBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    StartBtn.TextColor3 = Color3.fromRGB(255,255,255)
    StartBtn.Font = Enum.Font.FredokaOne
    StartBtn.TextSize = 28
    StartBtn.AutoButtonColor = false
    Instance.new("UICorner", StartBtn).CornerRadius = UDim.new(0,25)
    local startStroke = Instance.new("UIStroke", StartBtn)
    startStroke.Color = Color3.fromRGB(255,255,255)

    StartBtn.MouseButton1Click:Connect(function()
        if tpPoint then
            Character.HumanoidRootPart.CFrame = CFrame.new(tpPoint)
            StartBtn.Text = "Teleported!"
            task.delay(5, function()
                StartBtn.Text = "START INSTA TP"
            end)
        else
            StartBtn.Text = "No TP point set!"
        end
    end)

    -- Desync Button
    local DesyncBtn = Instance.new("TextButton", Main)
    DesyncBtn.Size = UDim2.new(0, 320, 0, 55)
    DesyncBtn.Position = UDim2.new(0.5, -160, 0, 220)
    DesyncBtn.Text = "DESYNC"
    DesyncBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    DesyncBtn.TextColor3 = Color3.fromRGB(255,255,255)
    DesyncBtn.Font = Enum.Font.FredokaOne
    DesyncBtn.TextSize = 28
    DesyncBtn.AutoButtonColor = false
    Instance.new("UICorner", DesyncBtn).CornerRadius = UDim.new(0,25)
    local desyncStroke = Instance.new("UIStroke", DesyncBtn)
    desyncStroke.Color = Color3.fromRGB(255,255,255)

    local desyncActive = false
    DesyncBtn.MouseButton1Click:Connect(function()
        desyncActive = not desyncActive
        print("DESYNC active:", desyncActive)
    end)

    -- Close Button
    local Close = Instance.new("TextButton", Main)
    Close.Size = UDim2.new(0,35,0,35)
    Close.Position = UDim2.new(1,-45,0,10)
    Close.Text = "X"
    Close.BackgroundColor3 = Color3.fromRGB(150,0,0)
    Close.TextColor3 = Color3.fromRGB(255,255,255)
    Close.Font = Enum.Font.FredokaOne
    Close.TextSize = 20
    Instance.new("UICorner", Close).CornerRadius = UDim.new(0,10)
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end)

]==])()
