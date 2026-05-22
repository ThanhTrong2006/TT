--[[ 
    PREMIUM CYBERPUNK KEY SYSTEM 2026 - CUSTOM EDITION
    Tích hợp: Auto Sync, Auto Save Key, Anti-Spam
]]

local Config_URL = "https://raw.githubusercontent.com/Bubu2k/config.txt/refs/heads/main/config.txt" 
local KeyFileName = "Beatsjx_PremiumKey.txt" -- Tên file lưu key cục bộ

---------------------------------------------------------
-- TẢI DỮ LIỆU TỪ CLOUD
---------------------------------------------------------
local HttpService = game:GetService("HttpService")
local fetchedLink = "https://funlink.io/Pu_s2wc" 
local fetchedKey = "vietnam76" 

local success, response = pcall(function()
    return game:HttpGet(Config_URL)
end)

if success and response then
    local lines = {}
    for line in string.gmatch(response, "[^\r\n]+") do
        table.insert(lines, line)
    end
    if lines[1] then fetchedLink = string.gsub(lines[1], "%s+", "") end
    if lines[2] then fetchedKey = string.gsub(lines[2], "%s+", "") end
end

---------------------------------------------------------
-- VẼ GIAO DIỆN (NATIVE UI)
---------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
local DropShadow = Instance.new("ImageLabel")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SubTitle = Instance.new("TextLabel") -- Watermark mới
local KeyInput = Instance.new("TextBox")
local CopyBtn = Instance.new("TextButton")
local SubmitBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "BeatsjxKeySystem"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

DropShadow.Parent = ScreenGui
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(0, 410, 0, 310)
DropShadow.BackgroundTransparency = 1
DropShadow.Image = "rbxassetid://6015897843"
DropShadow.ImageColor3 = Color3.fromRGB(0, 150, 255) -- Đổi sang tone màu Cyberpunk Blue
DropShadow.ImageTransparency = 0.45

MainFrame.Parent = DropShadow
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
MainFrame.BackgroundTransparency = 0.08
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 24)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local UIGradient = Instance.new("UIGradient", UIStroke)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 40, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
}

Title.Parent = MainFrame
Title.Text = "BEATSJX HUB"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1

SubTitle.Parent = MainFrame
SubTitle.Text = "v1.0.0 | Premium Access"
SubTitle.Font = Enum.Font.GothamSemibold
SubTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
SubTitle.TextSize = 12
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 40)
SubTitle.BackgroundTransparency = 1

KeyInput.Parent = MainFrame
KeyInput.PlaceholderText = "Nhập mã key truy cập..."
KeyInput.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
KeyInput.Position = UDim2.new(0.08, 0, 0.35, 0)
KeyInput.Size = UDim2.new(0.84, 0, 0, 45)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.GothamSemibold
KeyInput.TextSize = 14
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 12)
local InputStroke = Instance.new("UIStroke", KeyInput)
InputStroke.Thickness = 1.5
InputStroke.Color = Color3.fromRGB(0, 150, 255)

CopyBtn.Parent = MainFrame
CopyBtn.Text = "GET KEY LINK"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 12
CopyBtn.BackgroundColor3 = Color3.fromRGB(14, 18, 22)
CopyBtn.TextColor3 = Color3.fromRGB(80, 200, 255)
CopyBtn.Position = UDim2.new(0.08, 0, 0.60, 5)
CopyBtn.Size = UDim2.new(0.84, 0, 0, 32)
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 10)

SubmitBtn.Parent = MainFrame
SubmitBtn.Text = "ACTIVATE SCRIPT"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Position = UDim2.new(0.08, 0, 0.79, 10)
SubmitBtn.Size = UDim2.new(0.84, 0, 0, 40)
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 14)

---------------------------------------------------------
-- LOGIC & CHỨC NĂNG NÂNG CAO
---------------------------------------------------------
local TweenService = game:GetService("TweenService")
local wrongAttempts = 0
local isCooldown = false

local function AdvancedNotify(msg, color)
    local NotifyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Box = Instance.new("Frame", NotifyGui)
    local Text = Instance.new("TextLabel", Box)
    Box.Size = UDim2.new(0, 280, 0, 45)
    Box.Position = UDim2.new(0.5, -140, 0, -50)
    Box.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 12)
    local S = Instance.new("UIStroke", Box)
    S.Color = color
    S.Thickness = 2
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.BackgroundTransparency = 1
    Text.Text = msg
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 13
    TweenService:Create(Box, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -140, 0, 40)}):Play()
    task.wait(2.5)
    TweenService:Create(Box, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -140, 0, -50)}):Play()
    task.wait(0.4)
    NotifyGui:Destroy()
end

-- TÍNH NĂNG 1: Tự động tải Key cũ (Auto Load Key)
if isfile and isfile(KeyFileName) then
    local savedKey = readfile(KeyFileName)
    if savedKey and savedKey ~= "" then
        KeyInput.Text = savedKey
        AdvancedNotify("Đã tự động điền Key lưu trước đó!", Color3.fromRGB(0, 255, 255))
    end
end

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard(fetchedLink)
    CopyBtn.Text = "COPIED URL!"
    AdvancedNotify("Đã sao chép link lấy key mới nhất!", Color3.fromRGB(0, 255, 255))
    task.wait(2)
    CopyBtn.Text = "GET KEY LINK"
end)

SubmitBtn.MouseButton1Click:Connect(function()
    -- TÍNH NĂNG 2: Anti-Spam
    if isCooldown then
        AdvancedNotify("Đang bị khóa chống Spam! Vui lòng đợi.", Color3.fromRGB(255, 0, 0))
        return
    end

    local userKey = KeyInput.Text
    
    if userKey == fetchedKey then
        -- TÍNH NĂNG 1: Lưu key nếu đúng (Auto Save)
        if writefile then
            writefile(KeyFileName, userKey)
        end

        SubmitBtn.Text = "ACCESS GRANTED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 220, 110)
        
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        TweenService:Create(DropShadow, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
        task.wait(0.4)
        DropShadow:Destroy()
        
        -- Thực thi script Luarmor v4
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/1f179b0ee06c80b8ce8fdc93ccc55d16.lua"))()
        end)
        
        if not success then
            AdvancedNotify("Lỗi nạp mã nguồn chính!", Color3.fromRGB(255, 0, 40))
        end
    else
        wrongAttempts = wrongAttempts + 1
        SubmitBtn.Text = "ACCESS DENIED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 20)
        
        if wrongAttempts >= 3 then
            isCooldown = true
            AdvancedNotify("Nhập sai quá nhiều! Khóa 10 giây.", Color3.fromRGB(255, 0, 0))
            task.spawn(function()
                for i = 10, 1, -1 do
                    SubmitBtn.Text = "LOCKED (" .. i .. "s)"
                    task.wait(1)
                end
                wrongAttempts = 0
                isCooldown = false
                SubmitBtn.Text = "ACTIVATE SCRIPT"
                SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            end)
        else
            AdvancedNotify("Sai mã khóa! Thử lại.", Color3.fromRGB(255, 0, 0))
            task.wait(1.5)
            SubmitBtn.Text = "ACTIVATE SCRIPT"
            SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        end
    end
end)
