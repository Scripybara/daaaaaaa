--------------------------------------------------
-- RAYFIELD STYLE UI LIBRARY (BASE)
--------------------------------------------------

local Library = {}

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

--------------------------------------------------
-- CREATE WINDOW
--------------------------------------------------
function Library:CreateWindow(config)
    config = config or {}
    local Window = {}

    --------------------------------------------------
    -- UI ROOT
    --------------------------------------------------
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RayLikeUI"
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

    --------------------------------------------------
    -- CREATE TAB
    --------------------------------------------------
    function Window:CreateTab(tabName, icon)
        local Tab = {}
        tabName = tabName or "Tab"

        --------------------------------------------------
        -- BUTTON
        --------------------------------------------------
        function Tab:CreateButton(cfg)
            cfg = cfg or {}
            local Name = cfg.Name or "Button"
            local Callback = cfg.Callback or function() end

            print("Button Created:", Name)

            -- UI Button here
            -- Button.MouseButton1Click:Connect(Callback)
        end

        --------------------------------------------------
        -- TOGGLE
        --------------------------------------------------
        function Tab:CreateToggle(cfg)
            cfg = cfg or {}
            local Name = cfg.Name or "Toggle"
            local Default = cfg.CurrentValue or false
            local Callback = cfg.Callback or function() end

            print("Toggle Created:", Name, Default)
        end

        --------------------------------------------------
        -- SLIDER
        --------------------------------------------------
        function Tab:CreateSlider(cfg)
            cfg = cfg or {}
            print("Slider Created:", cfg.Name)
        end

        --------------------------------------------------
        -- DROPDOWN
        --------------------------------------------------
        function Tab:CreateDropdown(cfg)
            cfg = cfg or {}
            print("Dropdown Created:", cfg.Name)
        end

        return Tab
    end

    return Window
end

return Library
