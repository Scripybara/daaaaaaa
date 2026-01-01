--------------------------------------------------
-- SIMPLE ROBLOX UI LIBRARY (BASE)
-- Author: You
--------------------------------------------------

local UILib = {}
UILib.__index = UILib

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--------------------------------------------------
-- CREATE WINDOW
--------------------------------------------------
function UILib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "UILibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 420, 0, 320)
    Main.Position = UDim2.new(0.5, -210, 0.5, -160)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    local Corner = Instance.new("UICorner", Main)
    Corner.CornerRadius = UDim.new(0, 12)

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = title or "UI Library"
    Title.TextColor3 = Color3.fromRGB(0, 170, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = Main

    -- Container
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -20, 1, -60)
    Container.Position = UDim2.new(0, 10, 0, 50)
    Container.BackgroundTransparency = 1
    Container.Parent = Main

    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0, 8)

    local Window = {}
    Window.Container = Container

    --------------------------------------------------
    -- BUTTON
    --------------------------------------------------
    function Window:CreateButton(text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 36)
        Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Btn.Text = text
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.Parent = Container

        Instance.new("UICorner", Btn)

        Btn.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)
    end

    --------------------------------------------------
    -- TOGGLE
    --------------------------------------------------
    function Window:CreateToggle(text, default, callback)
        local toggled = default or false

        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(1, 0, 0, 36)
        Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Toggle.Text = text .. " : OFF"
        Toggle.TextColor3 = Color3.new(1,1,1)
        Toggle.Font = Enum.Font.Gotham
        Toggle.TextSize = 14
        Toggle.Parent = Container

        Instance.new("UICorner", Toggle)

        local function refresh()
            if toggled then
                Toggle.Text = text .. " : ON"
                Toggle.TextColor3 = Color3.fromRGB(0, 255, 120)
            else
                Toggle.Text = text .. " : OFF"
                Toggle.TextColor3 = Color3.new(1,1,1)
            end
        end

        refresh()

        Toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            refresh()
            if callback then
                callback(toggled)
            end
        end)
    end

    --------------------------------------------------
    -- SLIDER
    --------------------------------------------------
    function Window:CreateSlider(text, min, max, default, callback)
        local value = default or min

        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 50)
        Frame.BackgroundTransparency = 1
        Frame.Parent = Container

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 20)
        Label.BackgroundTransparency = 1
        Label.Text = text .. " : " .. value
        Label.TextColor3 = Color3.new(1,1,1)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.Parent = Frame

        local Bar = Instance.new("Frame")
        Bar.Size = UDim2.new(1, 0, 0, 10)
        Bar.Position = UDim2.new(0, 0, 0, 30)
        Bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
        Bar.Parent = Frame

        Instance.new("UICorner", Bar)

        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new((value-min)/(max-min),0,1,0)
        Fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
        Fill.Parent = Bar

        Instance.new("UICorner", Fill)

        Bar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local move
                move = game:GetService("UserInputService").InputChanged:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseMovement then
                        local percent = math.clamp(
                            (i.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X,
                            0,1
                        )
                        value = math.floor(min + (max-min)*percent)
                        Fill.Size = UDim2.new(percent,0,1,0)
                        Label.Text = text .. " : " .. value
                        if callback then callback(value) end
                    end
                end)
                game:GetService("UserInputService").InputEnded:Once(function()
                    if move then move:Disconnect() end
                end)
            end
        end)
    end

    return Window
end

--------------------------------------------------
-- RETURN LIB
--------------------------------------------------
return UILib
