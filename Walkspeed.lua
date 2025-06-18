local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

-- Clean up existing gui if already loaded
if player:FindFirstChild("PlayerGui"):FindFirstChild("CFrameGui") then
	player.PlayerGui.CFrameGui:Destroy()
end

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "CFrameGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 170, 0, 70)
frame.Position = UDim2.new(0.5, -85, 1, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Create Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 1, -20)
button.Position = UDim2.new(0, 10, 0, 10)
button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
button.Text = "Move: OFF"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = button

-- Movement logic
local moving = false
local connection

button.MouseButton1Click:Connect(function()
	moving = not moving

	if moving then
		button.Text = "Move: ON"
		button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)

		connection = runService.RenderStepped:Connect(function()
			local char = player.Character or player.CharacterAdded:Wait()
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				local moveDir = hrp.CFrame.LookVector
				local speed = 1.5
				hrp.CFrame = hrp.CFrame + moveDir * speed
			end
		end)
	else
		button.Text = "Move: OFF"
		button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

		if connection then
			connection:Disconnect()
		end
	end
end)
