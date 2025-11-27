--// GUI CREATION --------------------------------------------

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.Name = "AdminButtonGui"

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 110, 0, 50)
button.Position = UDim2.new(1, -175, 0.5, -90) -- right side
button.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
button.Text = "AP Spam"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = button

--// COMMAND EXECUTION ---------------------------------------

local function getOtherPlayer()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer then
            return plr
        end
    end
    return nil
end

local function runCommand(commandName)
    local target = getOtherPlayer()
    if not target then
        warn("No other player found in the game!")
        return
    end

    local args = {
        target,
        commandName
    }

    game:GetService("ReplicatedStorage")
        :WaitForChild("Packages")
        :WaitForChild("Net")
        :WaitForChild("RE/AdminPanelService/ExecuteCommand")
        :FireServer(unpack(args))
end

button.MouseButton1Click:Connect(function()
    -- run BOTH commands on the other player
    runCommand("tiny")
    runCommand("inverse")
    runCommand("jumpscare")
    runCommand("morph")
    runCommand("rocket")
    runCommand("balloon")
end)
