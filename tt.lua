--[[ 
    ALL-IN-ONE: PREMIUM KEY SYSTEM + COMBAT HUB
    Tác giả: Trọng (Beatsjx) - 2026
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- ==========================================
-- 1. CẤU HÌNH CLOUD ĐỒNG BỘ KEY
-- ==========================================
-- SỬA LẠI LINK NÀY THÀNH LINK config.txt CỦA BẠN:
local Config_URL = "https://raw.githubusercontent.com/ThanhTrong2006/TT/refs/heads/main/config.txt" 
local KeyFileName = "Beatsjx_PremiumKey.txt" 

local fetchedLink = "https://funlink.io/Pu_s2wc" 
local fetchedKey = "vietnam76" 

local success, response = pcall(function() return game:HttpGet(Config_URL) end)
if success and response then
    local lines = {}
    for line in string.gmatch(response, "[^\r\n]+") do table.insert(lines, line) end
    if lines[1] then fetchedLink = string.gsub(lines[1], "%s+", "") end
    if lines[2] then fetchedKey = string.gsub(lines[2], "%s+", "") end
end

-- ==========================================
-- 2. KHỞI TẠO HUB COMBAT (ẨN ĐI TRƯỚC)
-- ==========================================
getgenv().AutoFarm = false
getgenv().KillAura = false

local HubGui = Instance.new("ScreenGui", game.CoreGui)
HubGui.Name = "TrongCombatHub"

local HubFrame = Instance.new("Frame", HubGui)
HubFrame.Size = UDim2.new(0, 220, 0, 150)
HubFrame.Position = UDim2.new(0.5, -110, 0.5, -75)
HubFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
HubFrame.BorderSizePixel = 2
HubFrame.BorderColor3 = Color3.fromRGB(0, 150, 255)
HubFrame.Active = true
HubFrame.Draggable = true
HubFrame.Visible = false -- Ẩn đi, chờ nhập đúng Key mới hiện

local HubTitle = Instance.new("TextLabel", HubFrame)
HubTitle.Size = UDim2.new(1, 0, 0, 30)
HubTitle.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
HubTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
HubTitle.Font = Enum.Font.GothamBold
HubTitle.TextSize = 14
HubTitle.Text = "Trọng's Combat Hub"

local FarmBtn = Instance.new("TextButton", HubFrame)
FarmBtn.Size = UDim2.new(1, -20, 0, 40)
FarmBtn.Position = UDim2.new(0, 10, 0, 40)
FarmBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.Font = Enum.Font.GothamBold
FarmBtn.TextSize = 13
FarmBtn.Text = "Auto Farm: OFF"

local KillBtn = Instance.new("TextButton", HubFrame)
KillBtn.Size = UDim2.new(1, -20, 0, 40)
KillBtn.Position = UDim2.new(0, 10, 0, 90)
KillBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
KillBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KillBtn.Font = Enum.Font.GothamBold
KillBtn.TextSize = 13
KillBtn.Text = "Kill Aura: OFF"

FarmBtn.MouseButton1Click:Connect(function()
    getgenv().AutoFarm = not getgenv().AutoFarm
    FarmBtn.BackgroundColor3 = getgenv().AutoFarm and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(150, 40, 40)
    FarmBtn.Text = "Auto Farm: " .. (getgenv().AutoFarm and "ON" or "OFF")
end)

KillBtn.MouseButton1Click:Connect(function()
    getgenv().KillAura = not getgenv().KillAura
    KillBtn.BackgroundColor3 = getgenv().KillAura and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(150, 40, 40)
    KillBtn.Text = "Kill Aura: " .. (getgenv().KillAura and "ON" or "OFF")
end)

-- Vòng lặp tính năng
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().AutoFarm or getgenv().KillAura then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local titans = Workspace:FindFirstChild("Titans") or Workspace
                for _, obj in pairs(titans:GetChildren()) do
                    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
                        local root = obj:FindFirstChild("HumanoidRootPart")
                        if root and (char.HumanoidRootPart.Position - root.Position).Magnitude <= 60 then
                            if getgenv().AutoFarm then
                                char.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5, 5)
                            end
                            -- Gắn RemoteEvent chém vào đây
                        end
                    end
                end
            end
        end
    end
end)

-- ==========================================
-- 3. HỆ THỐNG KEY SYSTEM CYBERPUNK
-- ==========================================
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
local DropShadow = Instance.new("ImageLabel", KeyGui)
local MainFrame = Instance.new("Frame", DropShadow)
local Title = Instance.new("TextLabel", MainFrame)
local SubTitle = Instance.new("TextLabel", MainFrame)
local KeyInput = Instance.new("TextBox", MainFrame)
local CopyBtn = Instance.new("TextButton", MainFrame)
local SubmitBtn = Instance.new("TextButton", MainFrame)

DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(0, 410, 0, 310)
DropShadow.BackgroundTransparency = 1
DropShadow.Image = "rbxassetid://6015897843"
DropShadow.ImageColor3 = Color3.fromRGB(0, 150, 255)
DropShadow.ImageTransparency = 0.45

MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
MainFrame.BackgroundTransparency = 0.08
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 24)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(0, 150, 255)

Title.Text = "BEATSJX HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1

SubTitle.Text = "v1.0.0 | Premium Access"
SubTitle.Font = Enum.Font.GothamSemibold
SubTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
SubTitle.TextSize = 12
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 40)
SubTitle.BackgroundTransparency = 1

KeyInput.PlaceholderText = "Nhập mã key truy cập..."
KeyInput.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
KeyInput.Position = UDim2.new(0.08, 0, 0.35, 0)
KeyInput.Size = UDim2.new(0.84, 0, 0, 45)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.GothamSemibold
KeyInput.TextSize = 14
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", KeyInput).Color = Color3.fromRGB(0, 150, 255)

CopyBtn.Text = "GET KEY LINK"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 12
CopyBtn.BackgroundColor3 = Color3.fromRGB(14, 18, 22)
CopyBtn.TextColor3 = Color3.fromRGB(80, 200, 255)
CopyBtn.Position = UDim2.new(0.08, 0, 0.60, 5)
CopyBtn.Size = UDim2.new(0.84, 0, 0, 32)
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 10)

SubmitBtn.Text = "ACTIVATE SCRIPT"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Position = UDim2.new(0.08, 0, 0.79, 10)
SubmitBtn.Size = UDim2.new(0.84, 0, 0, 40)
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 14)

local function AdvancedNotify(msg, color)
    local NotifyGui = Instance.new("ScreenGui", game.CoreGui)
    local Box = Instance.new("Frame", NotifyGui)
    Box.Size = UDim2.new(0, 280, 0, 45)
    Box.Position = UDim2.new(0.5, -140, 0, -50)
    Box.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 12)
    local S = Instance.new("UIStroke", Box)
    S.Color = color
    S.Thickness = 2
    local Text = Instance.new("TextLabel", Box)
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.BackgroundTransparency = 1
    Text.Text = msg
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 13
    TweenService:Create(Box, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -140, 0, 40)}):Play()
    task.wait(2.5)
    TweenService:Create(Box, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -140, 0, -50)}):Play()
    task.wait(0.4)
    NotifyGui:Destroy()
end

if isfile and isfile(KeyFileName) then
    local savedKey = readfile(KeyFileName)
    if savedKey and savedKey ~= "" then KeyInput.Text = savedKey end
end

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard(fetchedLink)
    AdvancedNotify("Đã copy link get key!", Color3.fromRGB(0, 255, 255))
end)

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == fetchedKey then
        if writefile then writefile(KeyFileName, KeyInput.Text) end
        SubmitBtn.Text = "ACCESS GRANTED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 220, 110)
        
        -- Làm mờ Key System
        TweenService:Create(MainFrame, TweenInfo.new(0.4), {Size = UDim2.new(0,0,0,0)}):Play()
        TweenService:Create(DropShadow, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
        task.wait(0.4)
        KeyGui:Destroy()
        
        -- MỞ HUB COMBAT LÊN
        HubFrame.Visible = true
        AdvancedNotify("Khởi chạy Beatsjx Hub thành công!", Color3.fromRGB(0, 255, 255))
    else
        SubmitBtn.Text = "ACCESS DENIED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 20)
        AdvancedNotify("Sai mã khóa, vui lòng thử lại!", Color3.fromRGB(255, 0, 0))
        task.wait(1.5)
        SubmitBtn.Text = "ACTIVATE SCRIPT"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)
