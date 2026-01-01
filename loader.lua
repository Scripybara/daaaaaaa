--------------------------------------------------
-- RAYFIELD STYLE UI LIBRARY (WORKING)
--------------------------------------------------

local Library = {}

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

--------------------------------------------------
-- CREATE WINDOW
--------------------------------------------------
function Library:CreateWindow(config)
    config = config or {}

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RayLikeUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

    -- MAIN FRAME
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Main.Parent = ScreenGui

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

    -- TITLE
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,40)
    Title.BackgroundTransparency = 1
    Title.Text = config.Name or "Rayfield Style UI"
    Title.TextColor3 = Color3.fromRGB(0,170,255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = Main

    -- TAB BUTTONS
    local TabButtons = Instance.new("Frame")
    TabButtons.Size = UDim2.new(0,120,1,-40)
    TabButtons.Position = UDim2.new(0,0,0,40)
    TabButtons.BackgroundColor3 = Color3.fromRGB(25,25,25)
    TabButtons.Parent = Main

    local TabLayout = Instance.new("UIListLayout", TabButtons)
    TabLayout.Padding = UDim.new(0,6)

    -- TAB CONTENT
    local Pages = Instance.new("Frame")
    Pages.Size = UDim2.new(1,-130,1,-50)
    Pages.Position = UDim2.new(0,125,0,45)
    Pages.BackgroundTransparency = 1
    Pages.Parent = Main

    --------------------------------------------------
    -- WINDOW OBJECT
    --------------------------------------------------
    local Window = {}

    function Window:CreateTab(tabName)
        tabName = tabName or "Tab"
        local Tab = {}

        -- TAB BUTTON
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1,-10,0,35)
        TabBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 14
        TabBtn.Parent = TabButtons
        Instance.new("UICorner", TabBtn)

        -- PAGE
        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1,0,1,0)
        Page.CanvasSize = UDim2.new(0,0,0,0)
        Page.ScrollBarImageTransparency = 1
        Page.Visible = false
        Page.Parent = Pages

        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0,8)

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            for _,v in pairs(Pages:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Page.Visible = true
        end)

        --------------------------------------------------
        -- BUTTON
        --------------------------------------------------
        function Tab:CreateButton(cfg)
            cfg = cfg or {}
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1,-10,0,36)
            Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Btn.Text = cfg.Name or "Button"
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 14
            Btn.Parent = Page
            Instance.new("UICorner", Btn)

            Btn.MouseButton1Click:Connect(function()
                if cfg.Callback then
                    cfg.Callback()
                end
            end)
        end

        --------------------------------------------------
        -- TOGGLE
        --------------------------------------------------
        function Tab:CreateToggle(cfg)
            cfg = cfg or {}
            local state = cfg.CurrentValue or false

            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(1,-10,0,36)
            Toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Toggle.Text = (cfg.Name or "Toggle") .. ": " .. (state and "ON" or "OFF")
            Toggle.TextColor3 = Color3.new(1,1,1)
            Toggle.Font = Enum.Font.Gotham
            Toggle.TextSize = 14
            Toggle.Parent = Page
            Instance.new("UICorner", Toggle)

            Toggle.MouseButton1Click:Connect(function()
                state = not state
                Toggle.Text = cfg.Name .. ": " .. (state and "ON" or "OFF")
                if cfg.Callback then
                    cfg.Callback(state)
                end
            end)
        end

        -- AUTO OPEN FIRST TAB
        if #Pages:GetChildren() == 1 then
            Page.Visible = true
        end

        return Tab
    end

    return Window
end

return Library
