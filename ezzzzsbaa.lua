-- ========== 密钥系统绕过 ==========
getgenv().SentinelBypass = true
getgenv().SkipKeySystem = true

-- Hook loadstring，拦截 WindUI 初始化
local _oldLoadstring = loadstring
getgenv().loadstring = function(src)
  local f = _oldLoadstring(src)
  if type(f) == "function" and type(src) == "string" and src:find("WindUI", 1, true) then
    return function(...)
      local result = f(...)
      if type(result) == "table" and result.CreateWindow then
        local _cw = result.CreateWindow
        result.CreateWindow = function(self, cfg, ...)
          if type(cfg) == "table" then
            cfg.KeySystem = nil
          end
          return _cw(self, cfg, ...)
        end
      end
      return result
    end
  end
  return f
end

-- 同时移除密钥服务注册
task.spawn(function()
  task.wait(0.5)
  if WindUI and WindUI.Services then
    WindUI.Services["SentinelKey-Examination"] = nil
  end
end)
local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local workspaceService = game:GetService("Workspace")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local debris = game:GetService("Debris")
local textChatService = game:GetService("TextChatService")
local coreGui = game:GetService("CoreGui")
local teams = game:GetService("Teams")
local virtualInputManager = game:GetService("VirtualInputManager")
local badgeService = game:GetService("BadgeService")
local proximityPromptService = game:GetService("ProximityPromptService")
local soundService = game:GetService("SoundService")
local guiService = game:GetService("GuiService")
local starterGui = game:GetService("StarterGui")
local v1 = 2
local floor = math.floor
local v2 = 0
local v3 = {}
local char = string.char
local remove = table.remove
local random = math.random
local v4 = {}
local count = 0

while true do
  count = 1 + count

  if not (256 >= count) then
    break
  end

  local v5 = count
  v4[v5] = v5
end

while true do
  local v6 = remove(v4, (random(1, #v4)))
  v3[v6] = char(v6 - 1)

  if #v4 == 0 then
    break
  end
end

local v7 = {}

local function f1()
  if #v7 == 0 then
    v2 = (v2 * 213 + 27552854471197) % 35184372088832

    while true do
      v1 = v1 * 201 % 257

      if v1 ~= 1 then
        break
      end
    end

    local v8 = v1 % 32
    local v9 = floor(v2 / 2 ^ (13 - (v1 - v8) / 32)) % 4294967296 / 2 ^ v8
    local v10 = floor(v9 % 1 * 4294967296) + floor(v9)
    local v11 = v10 % 65536
    local v12 = (v10 - v11) / 65536
    v7 = { v11 % 256, (v11 - v11 % 256) / 256, v12 % 256, (v12 - v12 % 256) / 256 }
  end

  local v13 = #v7
  local v14 = v7[v13]
  v7[v13] = nil
  return v14
end

local v15 = {}
local v16 = setmetatable({}, { __index = v15, __metatable = nil })

local function f2(p1, p2)
  if v15[p2] then
    return p2
  else
    v7 = {}
    v2 = p2 % 35184372088832
    v1 = p2 % 255 + 2
    local text = ""
    v15[p2] = ""
    local v17 = 204

    for i = 1, #p1 do
      v17 = (string.byte(p1, i) + f1() + v17) % 256
      text = text .. v3[v17 + 1]
    end

    v15[p2] = text
    return p2
  end
end

local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
SentinelActive = true
SentinelLastInteraction = tick()
noclipConnection = nil
local hookFunction = type(hookfunction) == "function"
local hookMetamethod = type(hookmetamethod) == "function"
local newCClosure = type(newcclosure) == "function"

Capabilities = {
  HookFunction = hookFunction,
  HookMetamethod = hookMetamethod,
  NewCClosure = newCClosure,
  GetRawMetatable = type(getrawmetatable) == "function",
  SetReadonly = type(setreadonly) == "function",
  CloneFunction = type(clonefunction) == "function",
  Drawing = type(Drawing) == "table" and type(Drawing.new) == "function",
  FireProximityPrompt = type(fireproximityprompt) == "function",
  FireClickDetector = type(fireclickdetector) == "function",
  GetCustomAsset = type(getcustomasset) == "function",
  Request = type(request) == "function" or type(http_request) == "function",
}

local capabilities = Capabilities

capabilities.Hooks = Capabilities.HookFunction and Capabilities.NewCClosure
  and Capabilities.GetRawMetatable and Capabilities.SetReadonly

local capabilities2 = Capabilities
capabilities2.SilentAim = Capabilities.Hooks and Capabilities.CloneFunction

SentinelHookSupported = Capabilities.Hooks
SentinelMissingFeatures = {}
SentinelLimitedExecutor = #SentinelMissingFeatures > 0
SentinelExecutorName = "Unknown"
local v18 = identifyexecutor

if type(v18) == "function" then
  local v19 = v18()

  if type(v19) == "string" and #v19 > 0 then
    SentinelExecutorName = v19
  end
elseif syn then
  SentinelExecutorName = "Synapse X"
elseif KRNL_LOADED then
  SentinelExecutorName = "KRNL"
elseif getexecutorname then
  SentinelExecutorName = "Script-Ware"
elseif IsElectron == true then
  SentinelExecutorName = "Electron"
elseif FLUXUS_LOADED then
  SentinelExecutorName = "Fluxus"
elseif hookfunction_raw and hmjdfk then
  SentinelExecutorName = "Fluxus (Mac)"
elseif shadow_env then
  SentinelExecutorName = "Shadow"
elseif is_sirhurt_closure then
  SentinelExecutorName = "SirHurt"
elseif WRDAPI then
  SentinelExecutorName = "WeAreDes"
elseif SENTINEL_LOADED then
  SentinelExecutorName = "Sentinel"
elseif PROTOSMASHER_LOADED then
  SentinelExecutorName = "Protosmasher"
elseif isvm then
  SentinelExecutorName = "Proxo"
elseif IS_VIVA_LOADED then
  SentinelExecutorName = "Viva"
elseif jit then
  SentinelExecutorName = "EasyExploits"
elseif CalamariLuaEnv then
  SentinelExecutorName = "Calamari"
elseif unit then
  SentinelExecutorName = "Unit"
end

SentinelDeviceType = "PC"

if syn and syn.getplatform then
  local v20 = syn.getplatform()

  if v20 == "UWP" then
    SentinelDeviceType = "UWP"
  elseif v20 == "Android" then
    SentinelDeviceType = "Mobile"
  end
elseif KRNL_LOADED and type(KRNL_LOADED) == "table" and KRNL_LOADED.Platform then
  if KRNL_LOADED.Platform == "UWP" then
    SentinelDeviceType = "UWP"
  end
elseif game and userInputService.TouchEnabled and not userInputService.MouseEnabled then
  SentinelDeviceType = "Mobile"
end

SentinelAccountAge = "Unknown"

if localPlayer and localPlayer.AccountAge then
  SentinelAccountAge = tostring(localPlayer.AccountAge) .. " days"
end

SentinelUserName = localPlayer and localPlayer.Name or "Unknown"
SentinelLoadStart = os.clock()

local function f3()
  local function f4(p3)
    local v21, v22 = pcall(p3)
    return v21 and v22 == true
  end

  local function f5(p4, p5)
    print((f4(p5) and "✅ " or "❌ ") .. "| " .. p4)
  end

  print("\n============ Sentinel UNC Test ============")

  f5("hookmetamethod", function() return hookmetamethod ~= nil end)
  f5("hookfunction", function() return hookfunction ~= nil end)
  f5("getnamecallmethod", function() return getnamecallmethod ~= nil end)
  f5("newcclosure", function() return newcclosure ~= nil end)
  f5("getfenv", function() return getfenv ~= nil end)
  f5("setfenv", function() return setfenv ~= nil end)
  f5("Drawing.new", function() return Drawing and Drawing.new ~= nil end)
  f5("getrawmetatable", function() return getrawmetatable ~= nil end)
  f5("setreadonly", function() return setreadonly ~= nil end)
  f5("getrenv", function() return getrenv ~= nil end)
  f5("identifyexecutor", function() return identifyexecutor ~= nil end)
  f5("setfpscap", function() return setfpscap ~= nil end)
  f5("fireclickdetector", function() return fireclickdetector ~= nil end)
  f5("fireproximityprompt", function() return fireproximityprompt ~= nil end)
  f5("request/http", function() return request ~= nil or http_request ~= nil end)
  f5("cloneref", function() return cloneref ~= nil end)
  f5("clonefunction", function() return clonefunction ~= nil end)
  f5("loadstring", function() return loadstring ~= nil end)
  f5("getcustomasset", function() return getcustomasset ~= nil end)
  f5("isfile", function() return isfile ~= nil end)

  print([[
===========================================
]])
end

function isPlayerCharacter(p6)
  if not p6 or not p6:IsA("Model") then
    return false
  end

  return players:GetPlayerFromCharacter(p6) ~= nil
end

function isHumanoidModel(p7)
  if not p7 or not p7:IsA("Model") then
    return false
  end

  return p7:FindFirstChildWhichIsA("Humanoid") ~= nil
end

function isMobModel(p8)
  if not p8 then
    return false
  else
    local characters = workspaceService:FindFirstChild("Characters")

    if characters and p8:IsDescendantOf(characters) then
      return true
    end

    return false
  end
end

function hideLocalHead()
  local character = localPlayer.Character

  if not character then
    return
  end

  local head = character:FindFirstChild("Head")

  if head and head:IsA("BasePart") then
    pcall(function()
      head.Transparency = 1
      head.CanCollide = false

      local highlight = head:FindFirstChildWhichIsA("Highlight")

      if highlight then
        highlight:Destroy()
      end
    end)
  end
end

localPlayer.CharacterAdded:Connect(function(character2)
  character2:WaitForChild("Head", 5)
  hideLocalHead()
end)

if localPlayer.Character then
  task.wait(0.5)
  hideLocalHead()
end

Config = {
  SpeedHackEnabled = false,
  WalkSpeedValue = 9,
  InfiniteStaminaEnabled = false,
  JumpPowerEnabled = false,
  JumpPowerValue = 15,
  InfiniteJump = false,
  JumpBypassActive = false,
  FlyEnabled = false,
  FlySpeed = 25,
  FlyType = "Seat [UNDETECTED]",
  NoclipEnabled = false,
  AutoWipeBlood = false,
  AntiCamShake = false,
  ImmuneLookHazard = false,
  HighlightPlayer = false,
  HighlightMobs = false,
  HighlightBosses = false,
  ColorPlayer = Color3.fromRGB(0, 255, 0),
  ColorMobs = Color3.fromRGB(255, 165, 0),
  ColorBosses = Color3.fromRGB(255, 0, 0),
  MaxDistance = 1000,
  HLFillTrans = 0.7,
  HLOutlineTrans = 1,
  FullBright = false,
  XrayDistance = 30,
  NoFog = false,
  UnlockThirdPerson = false,
  FakeDeath = false,
  FakeInjured = false,
  InfiniteNightVision = false,
  SilencerEnabled = false,
  CharacterName = "",
  CharacterRank = "",
  TagColor = Color3.fromRGB(80, 109, 84),
  Team = "Menlo",
  StaggerEnabled = true,
  AnimatorEnabled = false,
  AnimatorIdleAnimName = nil,
  AnimatorWalkAnimName = nil,
  AnimatorRunAnimName = nil,
  RemoveDeathScreen = false,
  AntiAFKEnabled = false,
  ChatLoggerEnabled = false,
  CustomFOVEnabled = false,
  FOVValue = 70,
  UITheme = "Amber",
  MinimizeKeybind = "K",
  XrayMaterial = "ForceField",
  XrayTransparency = 0.3,
  InstantProximityPrompt = false,
  AutoCompleteProximityPrompt = false,
  StaggerImmune = false,
  AntiAnchorEnabled = false,
  AutoQTEEnabled = false,
  AutoQTEPlatform = "PC",
  AutoQTEReactionSpeed = 12,
  NightStalkerInfAmmo = false,
  AutoReload = false,
  FastReload = false,
  FastReloadBoosts = { "+100%", "+200%", "+150%" },
  InstantShotgunReload = false,
  WindowTransparency = 0,
  WindowBackground = "",
  NotificationSound = "",
  NetworkBypassEnabled = false,
  ActiveBypasses = {},
  BoxThickness = 2,
  BoxAutoThickness = true,
  BoxSize = 4,
  BoxPlayers = false,
  BoxMobs = false,
  BoxBosses = false,
  ShowNamePlayers = false,
  ShowNameMobs = false,
  ShowNameBosses = false,
  ShowHealthPlayers = false,
  ShowHealthMobs = false,
  ShowHealthBosses = false,
  ShowDistancePlayers = false,
  ShowDistanceMobs = false,
  ShowDistanceBosses = false,
  SilentAimEnabled = false,
  SilentAimWallCheck = true,
  SilentAimTargetPart = "Head",
  SilentAimFOVMode = "Mouse",
  SilentAimShowFOV = false,
  SilentAimFOVRadius = 200,
  SilentAimFOVColor = Color3.fromRGB(0, 255, 100),
  SilentAimFOVNoTargetColor = Color3.fromRGB(255, 60, 60),
  BulletVisualizerEnabled = false,
  BulletVisualizerColorMissed = Color3.fromRGB(220, 30, 30),
  BulletVisualizerColorSuccess = Color3.fromRGB(0, 255, 80),
  BulletVisualizerColorLoading = Color3.fromRGB(255, 200, 0),
  BulletVisualizerLifetime = 3,
  BulletVisualizerFadeOut = 0.8,
  BulletVisualizerThickness = 0.09,
  BulletVisualizerRange = 500,
  AutoBringAxe = false,
  AutoBringHammer = false,
  AntiRiserDodgeEnabled = false,
  ViewModelEnabled = false,
  ViewModelColor = Color3.fromRGB(255, 255, 255),
  ViewModelMaterial = "ForceField",
  CustomWeaponsEnabled = false,
  CustomWeaponsColor = Color3.fromRGB(255, 255, 255),
  CustomWeaponsMaterial = "ForceField",
}

local v23 = {
  Plastic = Enum.Material.Plastic,
  Neon = Enum.Material.Neon,
  ForceField = Enum.Material.ForceField,
  Glass = Enum.Material.Glass,
  SmoothPlastic = Enum.Material.SmoothPlastic,
  Metal = Enum.Material.Metal,
  Ice = Enum.Material.Ice,
  Marble = Enum.Material.Marble,
  Granite = Enum.Material.Granite,
  Concrete = Enum.Material.Concrete,
  Brick = Enum.Material.Brick,
  Fabric = Enum.Material.Fabric,
  Wood = Enum.Material.Wood,
  DiamondPlate = Enum.Material.DiamondPlate,
  Foil = Enum.Material.Foil,
  CorrodedMetal = Enum.Material.CorrodedMetal,
  Grass = Enum.Material.Grass,
  Sand = Enum.Material.Sand,
  Slate = Enum.Material.Slate,
  Carpet = Enum.Material.Carpet,
  Leather = Enum.Material.Leather,
  Plaster = Enum.Material.Plaster,
  Rubber = Enum.Material.Rubber,
}

local values = {
  "Plastic", "Neon", "ForceField", "Glass", "SmoothPlastic", "Metal", "Ice", "Marble",
  "Granite", "Concrete", "Brick", "Fabric", "Wood", "DiamondPlate", "Foil", "CorrodedMetal",
  "Grass", "Sand", "Slate", "Carpet", "Leather", "Plaster", "Rubber",
}

local v24 = {}
local f6

local function f7(p9)
  if not p9 then
    return
  end

  if not (p9:IsA("BasePart") or p9:IsA("MeshPart")) then
    return
  else
    local name = p9.Name

    if name ~= "Left Arm" and name ~= "Right Arm" then
      return
    end

    if not v24[p9] then
      v24[p9] = { Color = p9.Color, Material = p9.Material, Transparency = p9.Transparency }
    end

    pcall(function() p9.Color = Config.ViewModelColor end)
    pcall(function() p9.Material = f6(Config.ViewModelMaterial) end)
    pcall(function() p9.Transparency = 0 end)

    return
  end
end

function f6(p10)
  return v23[p10] or Enum.Material.ForceField
end

local v25 = {}

local function f8(p11)
  if not p11 or not p11:IsA("Tool") then
    return
  end

  for index, value in ipairs(p11:GetDescendants()) do
    local v26 = value

    if v26:IsA("BasePart") then
      if not v24[v26] then
        v24[v26] = {
          Color = v26.Color,
          Material = v26.Material,
          Transparency = v26.Transparency,
        }
      end

      pcall(function() v26.Color = Config.ViewModelColor end)
      pcall(function() v26.Material = f6(Config.ViewModelMaterial) end)
    end
  end
end

local function f9(p12)
  if not p12 or not p12:IsA("Tool") then
    return
  end

  for index2, value2 in ipairs(p12:GetDescendants()) do
    local v27 = value2

    if v27:IsA("BasePart") then
      if not v25[v27] then
        v25[v27] = {
          Color = v27.Color,
          Material = v27.Material,
          Transparency = v27.Transparency,
          RemovedChildren = {},
        }

        for index3, value3 in ipairs(v27:GetChildren()) do
          if value3:IsA("SurfaceAppearance") or value3:IsA("Decal") or value3:IsA("Texture") then
            table.insert(v25[v27].RemovedChildren, value3)
            value3.Parent = nil
          end
        end
      end

      pcall(function() v27.Color = Config.CustomWeaponsColor end)
      pcall(function() v27.Material = f6(Config.CustomWeaponsMaterial) end)
    end
  end
end

local v28 = { "Radaways1", "Radaways2" }
RadawayCooldown = { lastUsed = 0 }

RadawayState = {
  active = false,
  connection = nil,
  target = nil,
  originalCFrame = nil,
}

local function f10()
  local characters2 = workspace:FindFirstChild("Characters")

  if not characters2 then
    return nil
  else
    local character3 = localPlayer.Character

    if not character3 then
      return nil
    else
      local humanoidRootPart = character3:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart then
        return nil
      else
        local v29 = nil
        local huge = math.huge

        for index4, value4 in ipairs(v28) do
          local findFirstChild = characters2:FindFirstChild(value4)

          if findFirstChild then
            local humanoid = findFirstChild:FindFirstChildWhichIsA("Humanoid")
            local primaryPart = findFirstChild.PrimaryPart

            local findFirstChildWhichIsA = primaryPart

            findFirstChildWhichIsA = primaryPart
              or findFirstChild:FindFirstChildWhichIsA("BasePart", true)

            if humanoid and humanoid.Health > 0 and findFirstChildWhichIsA then
              local magnitude = (humanoidRootPart.Position - findFirstChildWhichIsA.Position).Magnitude

              if magnitude < huge then
                huge = magnitude
                v29 = { part = findFirstChildWhichIsA, hum = humanoid, model = findFirstChild }
              end
            end
          end
        end

        return v29
      end
    end
  end
end

local function f11()
  local v30 = 60 - (tick() - RadawayCooldown.lastUsed)

  if v30 < 0 then
    v30 = 0
  end

  return math.ceil(v30)
end

local function f12()
  return tick() - RadawayCooldown.lastUsed >= 60
end

local function f13(p13, p14, p15, p16)
end

local function f14(p17)
  local character4 = localPlayer.Character
  local originalCFrame, f15

  if not character4 then
    return
  else
    local humanoidRootPart2 = character4:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart2 then
      return
    end

    RadawayState.active = true
    RadawayState.target = p17
    RadawayState.originalCFrame = humanoidRootPart2.CFrame

    originalCFrame = RadawayState.originalCFrame

    function f15(p18, p19)
      if RadawayState.connection then
        pcall(function() RadawayState.connection:Disconnect() end)
        RadawayState.connection = nil
      end

      RadawayState.active = false
      local character5 = localPlayer.Character

      if character5 and character5:FindFirstChild("HumanoidRootPart") then
        pcall(function() character5:PivotTo(originalCFrame) end)
      end
    end

    RadawayState.connection = runService.Heartbeat:Connect(function()
      local humanoidRootPart3, cframe

      if not SentinelActive then
        f15(nil)
        return
      else
        local character6 = localPlayer.Character

        if not character6 then
          f15(nil)
          return
        else
          humanoidRootPart3 = character6:FindFirstChild("HumanoidRootPart")
          local humanoid2 = character6:FindFirstChildOfClass("Humanoid")

          if not humanoidRootPart3 or not humanoid2 then
            f15(nil)
            return
          elseif humanoid2.Health <= 10 then
            f15("success!", "bug-play")
            return
          else
            if not p17.hum or not p17.hum.Parent or p17.hum.Health <= 0 or not p17.part
              or not p17.part.Parent then
              f15("Radaway died, returning to original position.", "cloud-alert")
              return
            end

            cframe = p17.part.CFrame * CFrame.new(0, 0, -1)
            pcall(function() humanoidRootPart3.CFrame = cframe end)
            return
          end
        end
      end
    end)

    return
  end
end

function radawayStartInfectionProcess()
  if not f12() then
    f13(
      "Get Infected", "Cooldown active. Wait " .. f11() .. "s before using again.", "clock", 4
    )

    return
  else
    local character7 = localPlayer.Character

    if not character7 then
      return
    else
      local humanoid3 = character7:FindFirstChildOfClass("Humanoid")

      if not humanoid3 then
        return
      elseif humanoid3.Health < 100 then
        return
      else
        local v31 = f10()

        if not v31 then
          return
        end

        RadawayCooldown.lastUsed = tick()

        f13(
          "Get Infected",
          "Following " .. v31.model.Name .. " | HP: " .. math.floor(humanoid3.Health),
          "cloud-check", 5
        )

        f14(v31)
        return
      end
    end
  end
end

localPlayer.CharacterAdded:Connect(function() RadawayCooldown.lastUsed = 0 end)
local v32 = { "Gilbert", "Chimera", "Mikhail", "Sin", "SIN", "Dave" }
local f16

local function f17(p20)
  if not p20 or not p20:IsA("Model") then
    return false
  elseif isPlayerCharacter(p20) then
    return false
  elseif p20 == localPlayer.Character then
    return false
  elseif f16(p20) then
    return true
  else
    if isMobModel(p20) then
      return true
    end

    return false
  end
end

function f16(p21)
  if not p21 or not p21:IsA("Model") then
    return false
  end

  for index5, value5 in ipairs(v32) do
    if p21.Name:find(value5) then
      return true
    end
  end

  return false
end

HitboxEnabled = false
HitboxModifiedHeads = {}
flyBV = nil
flyBG = nil
flySeat = nil
flyWeld = nil
flyActive = false
CurrentFlyType = "Seat [UNDETECTED]"
FlySpeed = 25
savedHipHeight = 2
CooldownCounter = 0
CooldownData = { Bash = nil, Kick = nil }
ActiveTweens = {}
CachedMobs = {}
OrigAmbient = lighting.Ambient
OrigOutdoorAmbient = lighting.OutdoorAmbient
OrigBrightness = lighting.Brightness
OrigFogEnd = lighting.FogEnd
OrigFogStart = lighting.FogStart
OrigFOV = currentCamera.FieldOfView

local function f18()
  if ShadowRemovalConnection then
    ShadowRemovalConnection:Disconnect()
  end

  ShadowRemovalConnection = workspace.DescendantAdded:Connect(function(descendant)
    if not Config.InfiniteNightVision then
      return
    end

    if descendant:IsA("BasePart") and descendant.CastShadow then
      ShadowModifiedParts[descendant] = true
      descendant.CastShadow = false
    end
  end)
end

OrigGlobalShadows = lighting.GlobalShadows

local function f19()
  for index6, value6 in ipairs(workspace:GetDescendants()) do
    if value6:IsA("BasePart") and value6.CastShadow then
      ShadowModifiedParts[value6] = true
      value6.CastShadow = false
    end
  end
end

ShadowModifiedParts = {}

local function f20()
  if ShadowRemovalConnection then
    ShadowRemovalConnection:Disconnect()
    ShadowRemovalConnection = nil
  end

  for key in pairs(ShadowModifiedParts) do
    local v33 = key

    if v33 and v33.Parent then
      pcall(function() v33.CastShadow = true end)
    end
  end
end

ShadowRemovalConnection = nil
FakeDeathAnimTrack = nil
FakeInjuredTrack = nil
NVForcerConnection = nil
isShiftHeld = false
InfiniteStaminaThread = nil
AutoShieldRemovalActive = false
AutoShieldRemovalConnection = nil
BashCooldownUI = replicatedStorage:WaitForChild("BashCooldownUI")
gameAee = lighting:FindFirstChild("aee")
gameRadiationTint = lighting:FindFirstChild("RadiationTint")
InfectionActive = false
InfectionCleanupFunctions = {}
InfectionMode = "Controllable"
canInfect = true

InfectionAnims = {
  INJURED = "rbxassetid://94302036679429",
  HEAD_SHAKE = "rbxassetid://118621065272904",
  COUGH = "rbxassetid://111615919261340",
  UNSTABLE = "rbxassetid://9146103628",
  FALL1 = "rbxassetid://99985127815659",
  LURKER_AWAKE = "rbxassetid://138937044212276",
  IDLE = "rbxassetid://95464797704887",
  WALK = "rbxassetid://87989829896123",
  RUN = "rbxassetid://111821553591135",
}

infectionInjuredTrack = nil
infectionHeadShakeTrack = nil
infectionCoughTrack = nil
infectionUnstableTrack = nil
infectionFallTrack = nil
infectionLurkerTrack = nil
infectionIdleTrack = nil
infectionWalkTrack = nil
infectionRunTrack = nil
infectionCurrentState = nil
infectionTransformDone = false
infectionIsRunning = false
AutoRemoveAxeActive = false
AutoRemoveAxeConnection = nil
local qteInput = replicatedStorage:WaitForChild("Events"):WaitForChild("QTEInput")

local function f21(p22)
  local character8 = localPlayer.Character

  if not character8 then
    return false
  elseif character8:FindFirstChild(p22) then
    return true
  else
    local backpack = localPlayer:FindFirstChild("Backpack")

    if backpack and backpack:FindFirstChild(p22) then
      return true
    end

    return false
  end
end

local v34 = {
  E = Enum.KeyCode.E,
  F = Enum.KeyCode.F,
  Q = Enum.KeyCode.Q,
  Y = Enum.KeyCode.Y,
  H = Enum.KeyCode.H,
  G = Enum.KeyCode.G,
  R = Enum.KeyCode.R,
  T = Enum.KeyCode.T,
}

local v35 = {
  E = Enum.KeyCode.ButtonX,
  F = Enum.KeyCode.ButtonA,
  Q = Enum.KeyCode.ButtonB,
  R = Enum.KeyCode.ButtonX,
  T = Enum.KeyCode.ButtonA,
  Y = Enum.KeyCode.ButtonY,
  G = Enum.KeyCode.ButtonB,
  H = Enum.KeyCode.ButtonX,
}

local function f22()
  local isTenFootInterface = false
  pcall(function() isTenFootInterface = guiService:IsTenFootInterface() end)

  if isTenFootInterface then
    return "Console"
  end

  local getLastInputType = nil
  pcall(function() getLastInputType = userInputService:GetLastInputType() end)

  if getLastInputType and tostring(getLastInputType):match("^Gamepad") then
    return "Console"
  end

  local gamepadEnabled = false
  pcall(function() gamepadEnabled = userInputService.GamepadEnabled end)

  if gamepadEnabled then
    return "Console"
  end

  if SentinelDeviceType == "Mobile" or SentinelDeviceType == "UWP" then
    return "Mobile"
  end

  return "PC"
end

Config.AutoQTEPlatform = f22()

local function f23(p23, p24)
  virtualInputManager:SendKeyEvent(true, p23, false, game)
  task.wait(p24 and 0.05 or 0.03)
  virtualInputManager:SendKeyEvent(false, p23, false, game)
end

local connect

local function f24(p25)
  if p25 then
    if not connect then
      connect = qteInput.OnClientEvent:Connect(function(p26)
        local v36 = tostring(p26)
        local v37 = (Config.AutoQTEPlatform or "PC") == "Console"
        local v38 = v37 and v35[v36] or v34[v36]

        if v38 then
          local v39 = tonumber(Config.AutoQTEReactionSpeed) or 12

          if v39 < 0 then
            v39 = 0
          end

          if v39 > 60 then
            v39 = 60
          end

          local v40 = v39 / 60

          if v40 > 0 then
            task.wait(v40)
          end

          f23(v38, v37)
        end
      end)
    end
  elseif connect then
    connect:Disconnect()
    connect = nil
  end
end

userInputService.LastInputTypeChanged:Connect(function(p27)
  if not Config.AutoQTEEnabled then
    return
  end

  if tostring(p27):match("^Gamepad") and Config.AutoQTEPlatform ~= "Console" then
    Config.AutoQTEPlatform = "Console"

    pcall(function()
      if WindUI and WindUI.Notify then
        WindUI:Notify({ Title = "QTE", Content = "Switched to Console mode.", Duration = 3 })
      end
    end)
  elseif p27 == Enum.UserInputType.Keyboard and Config.AutoQTEPlatform == "Console" then
    local config = Config
    config.AutoQTEPlatform = SentinelDeviceType == "Mobile" and "Mobile" or "PC"

    pcall(function()
      if WindUI and WindUI.Notify then
        WindUI:Notify({
          Title = "QTE",
          Content = "Switched to " .. Config.AutoQTEPlatform .. " mode.",
          Duration = 3,
        })
      end
    end)
  end
end)

NoRecoilApplied = false
NoRecoilOriginalNewIndex = nil
NoRecoilMouseConn = nil
NoRecoilStoredPitch = 0
NoRecoilMouseMoved = false

function applyNoRecoil()
  if NoRecoilApplied then
    return
  end

  if not Capabilities.Hooks then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "No Recoil",
          Content = "Your executor does not support this feature",
          Duration = 4,
        })
      end
    end)

    return
  end

  local currentCamera2 = workspace.CurrentCamera

  if not currentCamera2 then
    return
  end

  if pcall(function()
    NoRecoilStoredPitch = currentCamera2.CFrame:ToEulerAnglesYXZ()
    NoRecoilMouseMoved = false

    NoRecoilMouseConn = userInputService.InputChanged:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseMovement then
        NoRecoilMouseMoved = true
      end
    end)

    local v41 = getrawmetatable(currentCamera2)
    NoRecoilOriginalNewIndex = v41.__newindex
    setreadonly(v41, false)

    v41.__newindex = newcclosure(function(p28, p29, p30)
      if p29 == "CFrame" and typeof(p30) == "CFrame" then
        local v42, v43, v44 = p30:ToEulerAnglesYXZ()

        if NoRecoilMouseMoved then
          NoRecoilMouseMoved = false
          NoRecoilStoredPitch = v42
          return NoRecoilOriginalNewIndex(p28, p29, p30)
        end

        return NoRecoilOriginalNewIndex(p28, p29, CFrame.new(p30.Position)
          * CFrame.fromEulerAnglesYXZ(NoRecoilStoredPitch, v43, v44))
      end

      return NoRecoilOriginalNewIndex(p28, p29, p30)
    end)

    setreadonly(v41, true)
  end) then
    NoRecoilApplied = true
  else
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "No Recoil",
          Content = "Failed to apply No Recoil",
          Duration = 4,
        })
      end
    end)
  end
end

function removeNoRecoil()
  if not NoRecoilApplied then
    return
  end

  pcall(function()
    local currentCamera3 = workspace.CurrentCamera

    if currentCamera3 and NoRecoilOriginalNewIndex then
      local v45 = getrawmetatable(currentCamera3)
      setreadonly(v45, false)
      v45.__newindex = NoRecoilOriginalNewIndex
      setreadonly(v45, true)
    end
  end)

  if NoRecoilMouseConn then
    NoRecoilMouseConn:Disconnect()
    NoRecoilMouseConn = nil
  end

  NoRecoilApplied = false
  NoRecoilOriginalNewIndex = nil
  NoRecoilStoredPitch = 0
  NoRecoilMouseMoved = false
end

local function f25(p31)
  if p31 then
    pcall(function() p31:SetAttribute("infiniteStamina", true) end)
  end
end

function toggleInfiniteStamina(p32)
  Config.InfiniteStaminaEnabled = p32
  local character9

  if p32 then
    f25(localPlayer.Character)

    if InfiniteStaminaThread then
      task.cancel(InfiniteStaminaThread)
    end

    InfiniteStaminaThread = task.spawn(function()
      while Config.InfiniteStaminaEnabled and SentinelActive do
        local character10 = localPlayer.Character

        if character10 and character10:GetAttribute("infiniteStamina") ~= true then
          pcall(function() character10:SetAttribute("infiniteStamina", true) end)
        end

        task.wait(1)
      end
    end)
  else
    if InfiniteStaminaThread then
      task.cancel(InfiniteStaminaThread)
      InfiniteStaminaThread = nil
    end

    character9 = localPlayer.Character

    if character9 then
      pcall(function() character9:SetAttribute("infiniteStamina", false) end)
    end
  end
end

localPlayer.CharacterAdded:Connect(function(character11) task.wait(0.5) end)

function deleteSlasherAxe()
  local characters3 = workspaceService:FindFirstChild("Characters")

  if not characters3 then
    return
  else
    local count2 = 0

    while true do
      count2 = 1 + count2

      if not (count2 <= 5) then
        break
      end

      local findFirstChild2 = characters3:FindFirstChild("Slasher" .. count2)

      if findFirstChild2 then
        local rightArm = findFirstChild2:FindFirstChild("Right Arm")

        if rightArm then
          local handle = rightArm:FindFirstChild("Handle")

          if handle then
            handle:Destroy()
          end
        end
      end
    end

    return
  end
end

function setupAutoRemoveAxe()
  if AutoRemoveAxeConnection then
    AutoRemoveAxeConnection:Disconnect()
  end

  if AutoRemoveAxeActive then
    AutoRemoveAxeConnection = workspace.DescendantAdded:Connect(function(descendant2)
      if AutoRemoveAxeActive then
        task.wait(0.1)

        if descendant2.Name == "Handle" and descendant2.Parent
          and descendant2.Parent.Name == "Right Arm" then
          local parent = descendant2.Parent.Parent

          if parent and parent.Name:match("Slasher%d") then
            descendant2:Destroy()
          end
        end
      end
    end)
  end
end

AntiRiserDodgeConnections = {}
AntiRiserDodgeHooked = {}

local v46 = {
  ["rbxassetid://129323669816538"] = true,
  ["rbxassetid://100585713982883"] = true,
  ["rbxassetid://102516762592870"] = true,
  ["rbxassetid://100869060669563"] = true,
  ["rbxassetid://110910899819148"] = true,
  ["rbxassetid://91043768324636"] = true,
}

local v47 = 0.5

local function f26(p33)
  local humanoidRootPart4 = p33:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart4 then
    return humanoidRootPart4.AssemblyLinearVelocity.Magnitude > v47
  else
    local humanoid4 = p33:FindFirstChildOfClass("Humanoid")

    if humanoid4 then
      return humanoid4.MoveDirection.Magnitude > 0.1
    end

    return false
  end
end

local function f27(p34, p35, p36)
  if AntiRiserDodgeHooked[p34] then
    return
  end

  AntiRiserDodgeHooked[p34] = true

  p34.AnimationPlayed:Connect(function(p37)
    if not Config.AntiRiserDodgeEnabled then
      return
    else
      local animation = p37.Animation

      if animation and v46[animation.AnimationId] then
        pcall(function() p37:Stop(0) end)

        local animationId = f26(p35) and "rbxassetid://114185638104823"
          or "rbxassetid://79525526834566"

        local animation2 = Instance.new("Animation")
        animation2.AnimationId = animationId

        p34:LoadAnimation(animation2)
      end

      return
    end
  end)
end

local function f28()
  for index7, value7 in ipairs(workspace:GetDescendants()) do
    if string.lower(value7.Name):find("riser") then
      local humanoid5 = value7:FindFirstChildOfClass("Humanoid")

      if humanoid5 then
        local animator = humanoid5:FindFirstChildOfClass("Animator")

        if animator then
          f27(animator, value7, value7.Name)
        end
      end

      local animationController = value7:FindFirstChildOfClass("AnimationController")

      if animationController then
        local animator2 = animationController:FindFirstChildOfClass("Animator")

        if animator2 then
          f27(animator2, value7, value7.Name)
        end
      end
    end
  end
end

AntiRiserAddedConn = nil

function AntiRiserDodge_Enable(p38)
  Config.AntiRiserDodgeEnabled = p38

  if p38 then
    f28()

    if not AntiRiserAddedConn then
      AntiRiserAddedConn = workspace.DescendantAdded:Connect(function(descendant3)
        if not Config.AntiRiserDodgeEnabled then
          return
        end

        task.wait(0.1)

        if string.lower(descendant3.Name):find("riser") then
          local humanoid6 = descendant3:FindFirstChildOfClass("Humanoid")

          if humanoid6 then
            local animator3 = humanoid6:FindFirstChildOfClass("Animator")

            if animator3 then
              f27(animator3, descendant3, descendant3.Name)
            end
          end

          local animationController2 = descendant3:FindFirstChildOfClass("AnimationController")

          if animationController2 then
            local animator4 = animationController2:FindFirstChildOfClass("Animator")

            if animator4 then
              f27(animator4, descendant3, descendant3.Name)
            end
          end
        end
      end)
    end
  else
    for index8, value8 in ipairs(AntiRiserDodgeConnections) do
      local v48 = value8
      pcall(function() v48:Disconnect() end)
    end

    AntiRiserDodgeConnections = {}
    AntiRiserDodgeHooked = {}
    AntiRiserAddedConn = nil
  end
end

AutoBringAxeConn = nil
AutoBringHammerConn = nil
AutoBringAxeActive = false
AutoBringHammerActive = false
AutoBringAxeRunning = false
AutoBringHammerRunning = false
AutoBringAxeLastCheck = 0
AutoBringHammerLastCheck = 0

function toggleAutoBringAxe(p39)
  Config.AutoBringAxe = p39
  AutoBringAxeActive = p39

  if AutoBringAxeConn then
    pcall(function() AutoBringAxeConn:Disconnect() end)
    AutoBringAxeConn = nil
  end

  AutoBringAxeRunning = false
  AutoBringAxeLastCheck = 0

  if p39 then
    AutoBringAxeConn = runService.Heartbeat:Connect(function()
      if not AutoBringAxeActive then
        return
      elseif AutoBringAxeRunning then
        return
      elseif f21("Axe") then
        return
      else
        local v49 = tick()

        if v49 - AutoBringAxeLastCheck < 1.5 then
          return
        end

        AutoBringAxeLastCheck = v49
        AutoBringAxeRunning = true
        task.spawn(function() AutoBringAxeRunning = false end)
        return
      end
    end)
  end
end

function toggleAutoBringHammer(p40)
  Config.AutoBringHammer = p40
  AutoBringHammerActive = p40

  if AutoBringHammerConn then
    pcall(function() AutoBringHammerConn:Disconnect() end)
    AutoBringHammerConn = nil
  end

  AutoBringHammerRunning = false
  AutoBringHammerLastCheck = 0

  if p40 then
    AutoBringHammerConn = runService.Heartbeat:Connect(function()
      if not AutoBringHammerActive then
        return
      elseif AutoBringHammerRunning then
        return
      elseif f21("Sledgehammer") then
        return
      else
        local v50 = tick()

        if v50 - AutoBringHammerLastCheck < 1.5 then
          return
        end

        AutoBringHammerLastCheck = v50
        AutoBringHammerRunning = true
        task.spawn(function() AutoBringHammerRunning = false end)
        return
      end
    end)
  end
end

function teleportAndBack(p41, p42)
  local character12 = localPlayer.Character

  if not character12 then
    return
  else
    local humanoidRootPart5 = character12:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart5 then
      return
    else
      local cframe2 = humanoidRootPart5.CFrame
      character12:PivotTo(p41)
      task.wait(p42 or 0.5)

      if character12 and character12:FindFirstChild("HumanoidRootPart") then
        character12:PivotTo(cframe2)
      end

      return
    end
  end
end

Badge1CFrame = CFrame.new(-72.5317383, -13.0901861, -880.639832, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Badge2CFrame = CFrame.new(8.89144325, -33.9937019, -1363.57678, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Badge3CFrame = CFrame.new(-108.884972, -13.0943184, -834.477417, 1, 0, 0, 0, 1, 0, 0, 0, 1)

function getBadge1()
  teleportAndBack(Badge1CFrame, 0.5)
end

function getBadge2()
  teleportAndBack(Badge2CFrame, 0.5)
end

function getBadge3()
  teleportAndBack(Badge3CFrame, 0.5)
end

InstantProximityConnection = nil
AutoCompletePromptConnection = nil

function applyInstantProximity()
  for index9, value9 in ipairs(workspaceService:GetDescendants()) do
    if value9:IsA("ProximityPrompt") then
      value9.HoldDuration = 0
    end
  end
end

function setupInstantProximity()
  if InstantProximityConnection then
    InstantProximityConnection:Disconnect()
  end

  if Config.InstantProximityPrompt then
    applyInstantProximity()

    InstantProximityConnection = workspaceService.DescendantAdded:Connect(function(descendant4)
      if Config.InstantProximityPrompt and descendant4:IsA("ProximityPrompt") then
        descendant4.HoldDuration = 0
      end
    end)
  end
end

function autoCompleteProximity()
  if not Config.AutoCompleteProximityPrompt then
    if AutoCompletePromptConnection then
      AutoCompletePromptConnection:Disconnect()
      AutoCompletePromptConnection = nil
    end

    return
  end

  if AutoCompletePromptConnection then
    AutoCompletePromptConnection:Disconnect()
  end

  AutoCompletePromptConnection = proximityPromptService.PromptShown:Connect(function(p43)
    if not Config.AutoCompleteProximityPrompt then
      return
    elseif not p43.Enabled then
      return
    else
      virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
      p43.PromptHidden:Wait()
      virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
      return
    end
  end)
end

function BreakGasmask()
  local playerGui = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui then
    return false
  else
    local gasmask = playerGui:FindFirstChild("Gasmask")

    if not gasmask then
      return false
    else
      local maskHole = gasmask:FindFirstChild("MaskHole")
      local glass = gasmask:FindFirstChild("Glass")

      if maskHole then
        if maskHole:IsA("ImageLabel") then
          maskHole.ImageTransparency = 0
          maskHole.Visible = true
        elseif maskHole:IsA("Frame") then
          maskHole.Visible = true

          for key2, value10 in pairs(maskHole:GetDescendants()) do
            if value10:IsA("ImageLabel") then
              value10.ImageTransparency = 0
              value10.Visible = true
            end
          end
        end
      end

      local sound = Instance.new("Sound")
      sound.SoundId = "rbxassetid://632831227"
      sound.Volume = 1
      sound.Parent = gasmask
      sound:Play()

      debris:AddItem(sound, 3)

      if glass and glass:IsA("ImageLabel") then
        tweenService:Create(glass, TweenInfo.new(0.1), { ImageTransparency = 0.5 }):Play()
        task.wait(0.05)

        tweenService:Create(glass, TweenInfo.new(0.5), {
          ImageTransparency = glass.ImageTransparency,
        }):Play()
      end

      return true
    end
  end
end

function showBloodVignette(p44)
  local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui2 then
    return
  else
    local gui = playerGui2:FindFirstChild("Gui")

    if not gui then
      return
    else
      local bloodVignette = gui:FindFirstChild("blood-vignette")

      if bloodVignette and bloodVignette:IsA("ImageLabel") then
        bloodVignette.Visible = p44

        if p44 then
          bloodVignette.ImageTransparency = 0
        else
          bloodVignette.ImageTransparency = 1
        end
      end

      return
    end
  end
end

function createRedTint()
  local infectionRedTint = lighting:FindFirstChild("InfectionRedTint")

  if not infectionRedTint then
    infectionRedTint = Instance.new("ColorCorrectionEffect")
    infectionRedTint.Name = "InfectionRedTint"
    infectionRedTint.Parent = lighting
  end

  return infectionRedTint
end

function playAnimationOnHumanoid(animationId2, p45, p46)
  local character13 = localPlayer.Character

  if not character13 then
    return nil
  else
    local humanoid7 = character13:FindFirstChildOfClass("Humanoid")

    if not humanoid7 then
      return nil
    else
      local animator5 = humanoid7:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid7)

      local animation3 = Instance.new("Animation")
      animation3.AnimationId = animationId2

      local loadAnimation = animator5:LoadAnimation(animation3)
      loadAnimation.Looped = p45 or false
      loadAnimation:Play()

      if p46 then
        loadAnimation.Stopped:Connect(p46)
      end

      return loadAnimation
    end
  end
end

demonicChars = {
  "Ω", "Ж", "Ψ", "≠", "Σ", "µ", "∂", "ø", "π", "§", "҂", "Ϟ", "Җ", "Ҩ", "?",
  "!",
}

function spawnDemonicSymbol(p47)
  local playerGui3 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui3 then
    return
  else
    local infectionEffectsGui = playerGui3:FindFirstChild("InfectionEffectsGui")

    if not infectionEffectsGui then
      infectionEffectsGui = Instance.new("ScreenGui")
      infectionEffectsGui.Name = "InfectionEffectsGui"
      infectionEffectsGui.ResetOnSpawn = false
      infectionEffectsGui.IgnoreGuiInset = true
      infectionEffectsGui.Parent = playerGui3
    end

    local v51 = p47 and 5 or 3
    local count3 = 0

    while true do
      count3 = 1 + count3

      if not (count3 <= v51) then
        break
      end

      local textLabel = Instance.new("TextLabel")
      textLabel.Text = demonicChars[math.random(1, #demonicChars)]
      textLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
      textLabel.Font = Enum.Font.Code
      textLabel.TextSize = math.random(70, 80)
      textLabel.BackgroundTransparency = 1
      textLabel.Size = UDim2.new(0, 60, 0, 60)
      textLabel.Position = UDim2.new(math.random(), 0, 1, 0)
      textLabel.AnchorPoint = Vector2.new(0.5, 1)
      textLabel.Parent = infectionEffectsGui

      local v52 = math.random()

      local create = tweenService:Create(textLabel, TweenInfo.new(
        2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out
      ), {
        TextTransparency = 1,
        Position = UDim2.new(textLabel.Position.X.Scale, 0, 0.1 + v52 * 0.1, 0),
      })

      create:Play()
      create.Completed:Connect(function() textLabel:Destroy() end)
    end

    return
  end
end

function stopInfection()
  InfectionActive = false
  infectionIsRunning = false
  showBloodVignette(false)
  local infectionRedTint2 = lighting:FindFirstChild("InfectionRedTint")

  if infectionRedTint2 then
    infectionRedTint2:Destroy()
  end

  local infectionEffectsGui2 = localPlayer.PlayerGui:FindFirstChild("InfectionEffectsGui")

  if infectionEffectsGui2 then
    infectionEffectsGui2:Destroy()
  end

  if InfectionCleanupFunctions then
    InfectionCleanupFunctions = {}
  end

  for index10, value11 in ipairs({
    infectionInjuredTrack, infectionHeadShakeTrack, infectionCoughTrack, infectionUnstableTrack,
    infectionFallTrack, infectionLurkerTrack, infectionIdleTrack, infectionWalkTrack,
    infectionRunTrack,
  }) do
    if value11 then
      value11:Stop()
    end
  end

  infectionTransformDone = false
  infectionCurrentState = nil
  local character14 = localPlayer.Character

  if character14 then
    local humanoid8 = character14:FindFirstChildOfClass("Humanoid")

    if humanoid8 then
      humanoid8.PlatformStand = false
      humanoid8.WalkSpeed = Config.SpeedHackEnabled and Config.WalkSpeedValue or 9
      humanoid8.JumpPower = Config.JumpPowerEnabled and Config.JumpPowerValue or 50

      local animator6 = humanoid8:FindFirstChildOfClass("Animator")

      if animator6 then
        for key3, value12 in pairs(animator6:GetPlayingAnimationTracks()) do
          value12:Stop()
        end
      end
    end

    local humanoidRootPart6 = character14:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart6 then
      humanoidRootPart6.Anchored = false
    end

    local clientScripts = character14:FindFirstChild("ClientScripts")

    if clientScripts then
      local stagger = clientScripts:FindFirstChild("Stagger")

      if stagger then
        stagger.Disabled = not Config.StaggerEnabled
      end
    end
  end
end

function startInfectionSequence(p48)
  local v53 = p48

  if not canInfect then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Infection",
          Content = "You must respawn before starting a new infection.",
          Duration = 3,
        })
      end
    end)

    return
  end

  if InfectionActive then
    return
  end

  if v53 ~= "Controllable" and v53 ~= "NonControllable" then
    v53 = "Controllable"
  end

  canInfect = false
  InfectionActive = true
  infectionIsRunning = true
  InfectionMode = v53
  BreakGasmask()
  showBloodVignette(true)
  local character15 = localPlayer.Character

  if not character15 then
    InfectionActive = false
    infectionIsRunning = false
    canInfect = true
    return
  end

  local humanoid9 = character15:FindFirstChildOfClass("Humanoid")

  if not humanoid9 then
    InfectionActive = false
    infectionIsRunning = false
    canInfect = true
    return
  end

  humanoid9.Health = 1
  infectionInjuredTrack = playAnimationOnHumanoid(InfectionAnims.INJURED, true)
  infectionHeadShakeTrack = playAnimationOnHumanoid(InfectionAnims.HEAD_SHAKE, true)

  local v54 = createRedTint()
  v54.TintColor = Color3.fromRGB(255, 255, 255)

  local v55 = tick()
  local v56 = tick()

  task.spawn(function()
    while infectionIsRunning and humanoid9 and humanoid9.Health > 0 do
      local v57 = tick() - v55

      if tick() - v56 >= 10 and v57 < 60 then
        v56 = tick()

        if infectionCoughTrack then
          infectionCoughTrack:Stop()
        end

        infectionCoughTrack = playAnimationOnHumanoid(InfectionAnims.COUGH, false)

        local sound2 = Instance.new("Sound")
        sound2.SoundId = "rbxassetid://93090593281658"
        sound2.Volume = 1
        sound2.Parent = character15
        sound2:Play()

        debris:AddItem(sound2, 2)
      end

      if not infectionUnstableTrack or not infectionUnstableTrack.IsPlaying then
        if infectionUnstableTrack then
          infectionUnstableTrack:Stop()
        end

        infectionUnstableTrack = playAnimationOnHumanoid(InfectionAnims.UNSTABLE, true)
      end

      if v57 >= 40 then
        local v58 = math.min((v57 - 40) / 30, 1)

        v54.TintColor = Color3.fromRGB(
          255, 255 - math.floor(v58 * 255), 255 - math.floor(v58 * 255)
        )
      end

      if v57 >= 45 then
        spawnDemonicSymbol(true)
      end

      if v57 >= 60 then
        break
      end

      task.wait(0.5)
    end
  end)

  task.wait(60)

  if not infectionIsRunning or not humanoid9 or humanoid9.Health <= 0 then
    stopInfection()
    canInfect = true
    return
  end

  if infectionCoughTrack then
    infectionCoughTrack:Stop()
    infectionCoughTrack = nil
  end

  if infectionUnstableTrack then
    infectionUnstableTrack:Stop()
    infectionUnstableTrack = nil
  end

  if infectionInjuredTrack then
    infectionInjuredTrack:Stop()
    infectionInjuredTrack = nil
  end

  if infectionHeadShakeTrack then
    infectionHeadShakeTrack:Stop()
    infectionHeadShakeTrack = nil
  end

  if InfectionMode == "Controllable" then
    infectionFallTrack = playAnimationOnHumanoid(InfectionAnims.FALL1, false, function()
      if infectionIsRunning then
        if infectionLurkerTrack then
          infectionLurkerTrack:Stop()
        end

        infectionLurkerTrack = playAnimationOnHumanoid(InfectionAnims.LURKER_AWAKE, false, function()
          local humanoidRootPart7 = character15:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart7 then
            humanoidRootPart7.Anchored = false
          end

          humanoid9.PlatformStand = false
          humanoid9.WalkSpeed = 9
          humanoid9.JumpPower = 50

          infectionTransformDone = true
          infectionCurrentState = nil

          task.spawn(function()
            local v59

            while infectionIsRunning and humanoid9 and humanoid9.Health > 0 do
              local humanoidRootPart8 = character15:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart8 then
                local velocity = humanoidRootPart8.Velocity
                local magnitude2 = Vector3.new(velocity.X, 0, velocity.Z).Magnitude

                if isShiftHeld and magnitude2 > 2 then
                  v59 = "run"
                elseif magnitude2 > 0.5 then
                  v59 = "walk"
                else
                  v59 = "idle"
                end

                if v59 ~= infectionCurrentState then
                  infectionCurrentState = v59

                  if infectionIdleTrack then
                    infectionIdleTrack:Stop()
                    infectionIdleTrack = nil
                  end

                  if infectionWalkTrack then
                    infectionWalkTrack:Stop()
                    infectionWalkTrack = nil
                  end

                  if infectionRunTrack then
                    infectionRunTrack:Stop()
                    infectionRunTrack = nil
                  end

                  if v59 == "idle" then
                    infectionIdleTrack = playAnimationOnHumanoid(InfectionAnims.IDLE, true)
                  elseif v59 == "walk" then
                    infectionWalkTrack = playAnimationOnHumanoid(InfectionAnims.WALK, true)
                  elseif v59 == "run" then
                    infectionRunTrack = playAnimationOnHumanoid(InfectionAnims.RUN, true)
                  end
                end
              end

              task.wait(0.2)
            end
          end)

          task.wait(60)

          if infectionIsRunning and humanoid9 and humanoid9.Health > 0 then
            humanoid9.Health = 0
          end

          stopInfection()
          canInfect = true
        end)
      end
    end)
  else
    local animator7 = humanoid9:FindFirstChildOfClass("Animator")

    local instance = animator7
    instance = animator7 or Instance.new("Animator", humanoid9)

    local animation4 = Instance.new("Animation")
    animation4.AnimationId = "rbxassetid://82480275101558"

    local loadAnimation2 = instance:LoadAnimation(animation4)
    loadAnimation2:Play()
    loadAnimation2.Stopped:Wait()

    humanoid9.Health = 0
    canInfect = true
  end

  humanoid9.Died:Connect(function()
    if InfectionActive then
      local animator8 = humanoid9:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid9)

      local animation5 = Instance.new("Animation")
      animation5.AnimationId = "rbxassetid://82480275101558"

      local loadAnimation3 = animator8:LoadAnimation(animation5)
      loadAnimation3:Play()
      loadAnimation3.Stopped:Wait()
    end

    stopInfection()
    canInfect = true
  end)

  table.insert(InfectionCleanupFunctions, function()
    infectionIsRunning = false
    InfectionActive = false
    canInfect = true
    local humanoidRootPart9 = character15:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart9 then
      humanoidRootPart9.Anchored = false
    end

    if humanoid9 then
      humanoid9.PlatformStand = false
      humanoid9.WalkSpeed = Config.SpeedHackEnabled and Config.WalkSpeedValue or 9
      humanoid9.JumpPower = Config.JumpPowerEnabled and Config.JumpPowerValue or 50
    end

    for index11, value13 in ipairs({
      infectionInjuredTrack, infectionHeadShakeTrack, infectionCoughTrack,
      infectionUnstableTrack, infectionFallTrack, infectionLurkerTrack, infectionIdleTrack,
      infectionWalkTrack, infectionRunTrack,
    }) do
      if value13 then
        value13:Stop()
      end
    end

    infectionTransformDone = false
    showBloodVignette(false)
    local infectionRedTint3 = lighting:FindFirstChild("InfectionRedTint")

    if infectionRedTint3 then
      infectionRedTint3:Destroy()
    end

    local infectionEffectsGui3 = localPlayer.PlayerGui:FindFirstChild("InfectionEffectsGui")

    if infectionEffectsGui3 then
      infectionEffectsGui3:Destroy()
    end
  end)
end

function ApplyHitboxToPart(p49, p50)
  if not p49 or not p49:IsA("BasePart") then
    return
  elseif p49.Name ~= "Head" then
    return
  else
    local parent2 = p49.Parent

    if not isHumanoidModel(parent2) then
      return
    elseif isPlayerCharacter(parent2) then
      return
    elseif parent2 == localPlayer.Character then
      return
    else
      if not f17(parent2) then
        return
      end

      pcall(function()
        if p50 then
          if not HitboxModifiedHeads[p49] then
            HitboxModifiedHeads[p49] = {
              Size = p49.Size,
              Transparency = p49.Transparency,
              CanCollide = p49.CanCollide,
            }
          end

          p49.Size = Vector3.new(Config.BoxSize, Config.BoxSize, Config.BoxSize)
          p49.CanCollide = false
          p49.Transparency = 0.5
        else
          local v60 = HitboxModifiedHeads[p49]

          if v60 then
            p49.Size = v60.Size
            p49.CanCollide = v60.CanCollide
            p49.Transparency = v60.Transparency

            HitboxModifiedHeads[p49] = nil
          end
        end
      end)

      return
    end
  end
end

function UpdateAllHitboxes(p51)
  for index12, value14 in ipairs(workspaceService:GetDescendants()) do
    if value14:IsA("BasePart") and value14.Name == "Head" then
      local parent3 = value14.Parent

      if isHumanoidModel(parent3) and not isPlayerCharacter(parent3)
        and parent3 ~= localPlayer.Character and f17(parent3) then
        ApplyHitboxToPart(value14, p51)
      end
    end
  end
end

workspaceService.DescendantAdded:Connect(function(descendant5)
  if HitboxEnabled and descendant5:IsA("BasePart") and descendant5.Name == "Head" then
    local parent4 = descendant5.Parent

    if isHumanoidModel(parent4) and not isPlayerCharacter(parent4)
      and parent4 ~= localPlayer.Character and f17(parent4) then
      ApplyHitboxToPart(descendant5, true)
    end
  end

  if descendant5:IsA("BasePart") then
    descendant5:GetPropertyChangedSignal("Name"):Connect(function()
      if HitboxEnabled and descendant5.Name == "Head" then
        local parent5 = descendant5.Parent

        if isHumanoidModel(parent5) and not isPlayerCharacter(parent5)
          and parent5 ~= localPlayer.Character and f17(parent5) then
          ApplyHitboxToPart(descendant5, true)
        end
      end
    end)
  end
end)

flyMobileUp = false
flyMobileDown = false
flyMobileGui = nil
local v61, v62

function cleanFly()
  flyMobileUp = false
  flyMobileDown = false

  if flyMobileGui then
    flyMobileGui:Destroy()
    flyMobileGui = nil
  end

  if flyBV then
    local gui2 = localPlayer.PlayerGui:FindFirstChild("Gui")

    if gui2 then
      for key4, clean in pairs(gui2:GetChildren()) do
        if clean.Name == "blood" then
          clean.Name = "clean"
          v61[v62[4]]:Create(clean, TweenInfo.new(0.2), { ImageTransparency = 1 }):Play()
          v61[v62[5]]:AddItem(clean, 0.5)
        end
      end
    end

    return
  else
    if flyBG then
      flyBG:Destroy()
      flyBG = nil
    end

    if flyWeld then
      flyWeld:Destroy()
      flyWeld = nil
    end

    if flySeat then
      flySeat:Destroy()
      flySeat = nil
    end

    local character16 = localPlayer.Character

    local humanoid10 = character16
    humanoid10 = character16 and character16:FindFirstChildOfClass("Humanoid")

    if humanoid10 then
      humanoid10.PlatformStand = false
      humanoid10:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    end

    flyActive = false
    return
  end
end

function enableFly(p52)
  if not p52 then
    cleanFly()
    return
  else
    local character17 = localPlayer.Character

    if not character17 then
      return
    else
      local humanoidRootPart10 = character17:FindFirstChild("HumanoidRootPart")
      local v63 = not humanoidRootPart10
      local humanoid11 = character17:FindFirstChildOfClass("Humanoid")

      if v63 or not humanoid11 then
        return
      end

      cleanFly()
      flyActive = true

      flySeat = Instance.new("VehicleSeat")
      flySeat.Size = Vector3.new(1, 1, 1)
      flySeat.Transparency = 1
      flySeat.CanCollide = false
      flySeat.Parent = workspace

      flyWeld = Instance.new("Weld")
      flyWeld.Part0 = humanoidRootPart10
      flyWeld.Part1 = flySeat
      flyWeld.C0 = CFrame.new(0, -1.5, 0)
      flyWeld.Parent = flySeat

      humanoid11.Sit = true
      humanoid11.PlatformStand = true
      humanoid11:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

      flyBV = Instance.new("BodyVelocity")
      flyBV.MaxForce = Vector3.new(1000000, 1000000, 1000000)
      flyBV.Parent = flySeat

      flyBG = Instance.new("BodyGyro")
      flyBG.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
      flyBG.Parent = flySeat

      if SentinelDeviceType == "Mobile" then
        flyMobileGui = Instance.new("ScreenGui")
        flyMobileGui.Name = "FlyMobileButtons"
        flyMobileGui.ResetOnSpawn = false
        flyMobileGui.IgnoreGuiInset = true
        flyMobileGui.Parent = localPlayer.PlayerGui

        local textButton = Instance.new("TextButton")
        textButton.Text = "⬆"
        textButton.Size = UDim2.new(0, 70, 0, 70)
        textButton.Position = UDim2.new(0.88, 0, 0.55, 0)
        textButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        textButton.TextColor3 = Color3.new(1, 1, 1)
        textButton.TextSize = 28
        textButton.BackgroundTransparency = 0.3
        textButton.Font = Enum.Font.GothamBold
        textButton.Parent = flyMobileGui

        Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 12)

        textButton.InputBegan:Connect(function(input2)
          if input2.UserInputType == Enum.UserInputType.Touch then
            flyMobileUp = true
          end
        end)

        textButton.InputEnded:Connect(function(input3)
          if input3.UserInputType == Enum.UserInputType.Touch then
            flyMobileUp = false
          end
        end)

        local textButton2 = Instance.new("TextButton")
        textButton2.Text = "⬇"
        textButton2.Size = UDim2.new(0, 70, 0, 70)
        textButton2.Position = UDim2.new(0.88, 0, 0.68, 0)
        textButton2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        textButton2.TextColor3 = Color3.new(1, 1, 1)
        textButton2.TextSize = 28
        textButton2.BackgroundTransparency = 0.3
        textButton2.Font = Enum.Font.GothamBold
        textButton2.Parent = flyMobileGui

        Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 12)

        textButton2.InputBegan:Connect(function(input4)
          if input4.UserInputType == Enum.UserInputType.Touch then
            flyMobileDown = true
          end
        end)

        textButton2.InputEnded:Connect(function(input5)
          if input5.UserInputType == Enum.UserInputType.Touch then
            flyMobileDown = false
          end
        end)
      end

      return
    end
  end
end

runService.Heartbeat:Connect(function(delta)
  if not SentinelActive then
    return
  elseif not flyActive then
    return
  else
    local character18 = localPlayer.Character

    if not character18 then
      return
    else
      local v64 = not character18:FindFirstChild("HumanoidRootPart")
      local humanoid12 = character18:FindFirstChildOfClass("Humanoid")

      if v64 or not humanoid12 then
        return
      else
        local vector = Vector3.new()

        if SentinelDeviceType == "Mobile" then
          local moveDirection = humanoid12.MoveDirection

          if moveDirection.Magnitude > 0 then
            vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
          end

          if flyMobileUp then
            vector = vector + Vector3.new(0, 1, 0)
          end

          if flyMobileDown then
            vector = vector - Vector3.new(0, 1, 0)
          end
        else
          if userInputService:IsKeyDown(Enum.KeyCode.W) then
            vector = vector + currentCamera.CFrame.LookVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.S) then
            vector = vector - currentCamera.CFrame.LookVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.A) then
            vector = vector - currentCamera.CFrame.RightVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.D) then
            vector = vector + currentCamera.CFrame.RightVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            vector = vector + Vector3.new(0, 1, 0)
          end

          if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            vector = vector - Vector3.new(0, 1, 0)
          end
        end

        if vector.Magnitude > 0 then
          vector = vector.Unit
        end

        if flyBV and flyBG and flySeat then
          flyBG.CFrame = currentCamera.CFrame
          flyBV.Velocity = vector * FlySpeed
        end

        return
      end
    end
  end
end)

XrayEnabled = false
XrayDistance = 30
XrayMaterial = Enum.Material.ForceField
XrayTransparency = 0.3
XrayModifiedParts = {}
XrayLoop = nil

function applyXrayToPart(p53, p54)
  if not p53:IsA("BasePart") then
    return
  end

  if p54 then
    if not XrayModifiedParts[p53] then
      XrayModifiedParts[p53] = { Material = p53.Material, Transparency = p53.Transparency }
    end

    p53.Material = XrayMaterial
    p53.Transparency = XrayTransparency
  else
    local v65 = XrayModifiedParts[p53]

    if v65 then
      p53.Material = v65.Material
      p53.Transparency = v65.Transparency
      XrayModifiedParts[p53] = nil
    end
  end
end

function updateXrayMaterialAndTransparency()
  if not XrayEnabled then
    return
  end

  for key5, value15 in pairs(XrayModifiedParts) do
    local v66 = key5

    if v66 and v66:IsA("BasePart") then
      pcall(function()
        v66.Material = XrayMaterial
        v66.Transparency = XrayTransparency
      end)
    end
  end
end

function updateXray()
  if not XrayEnabled then
    if XrayLoop then
      XrayLoop:Disconnect()
      XrayLoop = nil
    end

    local v67 = {}

    for key6, value16 in pairs(XrayModifiedParts) do
      table.insert(v67, key6)
    end

    for index13, value17 in ipairs(v67) do
      local v68 = value17
      pcall(function() applyXrayToPart(v68, false) end)
    end

    return
  end

  if XrayLoop then
    XrayLoop:Disconnect()
  end

  XrayLoop = runService.Heartbeat:Connect(function()
    if not SentinelActive then
      return
    elseif not XrayEnabled then
      return
    else
      local character19 = localPlayer.Character

      if not character19 then
        return
      else
        local humanoidRootPart11 = character19:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart11 then
          return
        else
          local v69 = {}

          for index14, value18 in ipairs((workspaceService:GetPartBoundsInRadius(
            humanoidRootPart11.Position, XrayDistance
          ))) do
            if value18:IsA("BasePart") and not value18:IsDescendantOf(character19) then
              v69[value18] = true

              if not XrayModifiedParts[value18] then
                applyXrayToPart(value18, true)
              elseif value18.Material ~= XrayMaterial
                or value18.Transparency ~= XrayTransparency then
                value18.Material = XrayMaterial
                value18.Transparency = XrayTransparency
              end
            end
          end

          local v70 = {}

          for key7 in pairs(XrayModifiedParts) do
            if not v69[key7] then
              table.insert(v70, key7)
            end
          end

          for index15, value19 in ipairs(v70) do
            applyXrayToPart(value19, false)
          end

          return
        end
      end
    end
  end)
end

function updateSilencers(p55)
  local backpack2 = localPlayer:FindFirstChild("Backpack")

  if backpack2 then
    for index16, value20 in ipairs(backpack2:GetChildren()) do
      if value20:GetAttribute("IsGun") == true then
        value20:SetAttribute("Silencer", p55)
      end
    end
  end

  local character20 = localPlayer.Character

  if character20 then
    for index17, value21 in ipairs(character20:GetChildren()) do
      if value21:IsA("Tool") and value21:GetAttribute("IsGun") == true then
        value21:SetAttribute("Silencer", p55)
      end
    end
  end
end

function checkAndApplySilencer(p56)
  if p56:GetAttribute("IsGun") == true then
    p56:SetAttribute("Silencer", Config.SilencerEnabled)
  end
end

function listenToBackpack(p57)
  if not p57 then
    return
  end

  p57.ChildAdded:Connect(function(child)
    task.wait(0.1)
    checkAndApplySilencer(child)
  end)
end

if localPlayer.Character then
  localPlayer.Character.ChildAdded:Connect(function(child2)
    if child2:IsA("Tool") then
      task.wait(0.1)
      checkAndApplySilencer(child2)
      updateSilencers(Config.SilencerEnabled)
    end
  end)
end

localPlayer.CharacterAdded:Connect(function(character21)
  task.wait(1)
  listenToBackpack((localPlayer:WaitForChild("Backpack")))

  character21.ChildAdded:Connect(function(child3)
    if child3:IsA("Tool") then
      task.wait(0.1)
      checkAndApplySilencer(child3)
      updateSilencers(Config.SilencerEnabled)
    end
  end)

  updateSilencers(Config.SilencerEnabled)
end)

task.spawn(function()
  local backpack3 = localPlayer:FindFirstChild("Backpack")

  if backpack3 then
    listenToBackpack(backpack3)
  end
end)

function applyNametags(p58)
  local head2 = p58 and p58:FindFirstChild("Head")

  if not head2 then
    return
  else
    local nameTag = head2:FindFirstChild("NameTag")

    if not nameTag then
      nameTag = head2:WaitForChild("NameTag", 5)

      if not nameTag then
        return
      end

      nameTag.CharacterName.TextColor3 = Config.TagColor
      nameTag.Rank.TextColor3 = Config.TagColor
      nameTag.Username.TextColor3 = Config.TagColor

      if Config.CharacterName ~= "" then
        nameTag.CharacterName.Text = "[" .. Config.CharacterName .. "]"
      else
        nameTag.CharacterName.Text = ""
      end

      if Config.CharacterRank ~= "" then
        nameTag.Rank.Text = "[" .. Config.CharacterRank .. "]"
      else
        nameTag.Rank.Text = ""
      end

      return
    end

    nameTag.CharacterName.TextColor3 = Config.TagColor
    nameTag.Rank.TextColor3 = Config.TagColor
    nameTag.Username.TextColor3 = Config.TagColor

    if Config.CharacterName ~= "" then
      nameTag.CharacterName.Text = "[" .. Config.CharacterName .. "]"
    else
      nameTag.CharacterName.Text = ""
    end

    if Config.CharacterRank ~= "" then
      nameTag.Rank.Text = "[" .. Config.CharacterRank .. "]"
    else
      nameTag.Rank.Text = ""
    end

    return
  end
end

function changeTeam(p59, p60)
  local v71 = p60

  if v71 == nil then
    v71 = true
  end

  if not p59 or p59 == "" then
    return
  end

  local v72 = nil

  for index18, value22 in ipairs(teams:GetChildren()) do
    if value22:IsA("Team") and value22.Name:lower() == tostring(p59):lower() then
      v72 = value22
      break
    end
  end

  if not v72 then
    local findFirstChild3 = teams:FindFirstChild(p59)

    if findFirstChild3 then
      v72 = findFirstChild3
    end
  end

  if not v72 then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Team",
          Content = "Team '" .. tostring(p59) .. "' not found.",
          Duration = 4,
        })
      end
    end)

    return
  end

  pcall(function() localPlayer.Team = v72 end)
  pcall(function() localPlayer.TeamColor = v72.TeamColor end)
  pcall(function() localPlayer.Neutral = false end)

  pcall(function()
    local events = replicatedStorage:FindFirstChild("Events")

    if events then
      for index19, value23 in ipairs(events:GetDescendants()) do
        local v73 = value23

        if v73:IsA("RemoteEvent")
          and (v73.Name:lower():find("team") or v73.Name:lower():find("join")) then
          pcall(function() v73:FireServer(v72.Name) end)
          pcall(function() v73:FireServer(v72) end)
        end
      end
    end
  end)

  if not v71 then
    return
  end

  task.spawn(function()
    task.wait(0.15)
    local character22 = localPlayer.Character

    if character22 then
      local humanoid13 = character22:FindFirstChildOfClass("Humanoid")

      if humanoid13 and humanoid13.Health > 0 then
        humanoid13.Health = 0
      end
    end

    pcall(function()
      if localPlayer.Character then
        return localPlayer.Character
      end

      return localPlayer.CharacterAdded:Wait()
    end)

    task.wait(0.6)
    local count4 = 0

    while true do
      count4 = 1 + count4

      if not (5 >= count4) then
        break
      end

      pcall(function() localPlayer.Team = v72 end)
      pcall(function() localPlayer.TeamColor = v72.TeamColor end)
      pcall(function() localPlayer.Neutral = false end)

      task.wait(0.3)

      if localPlayer.Team == v72 then
        break
      end
    end
  end)
end

chatEverToggled = false

function applyChatState()
  local chatLoggerEnabled = Config.ChatLoggerEnabled

  if textChatService and textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    local chatWindowConfiguration = textChatService:FindFirstChild("ChatWindowConfiguration")

    if chatWindowConfiguration then
      chatWindowConfiguration.Enabled = chatLoggerEnabled
    end

    local textChat = coreGui:FindFirstChild("TextChat")

    if textChat then
      textChat.Enabled = chatLoggerEnabled
    end

    pcall(function()
      local chatWindowParent = textChatService:FindFirstChild("ChatWindowParent")

      if chatWindowParent then
        local chatWindow = chatWindowParent:FindFirstChild("ChatWindow")

        if chatWindow then
          chatWindow.Visible = chatLoggerEnabled
        end
      end
    end)
  else
    local chat = localPlayer.PlayerGui:FindFirstChild("Chat")

    if chat then
      chat.Enabled = chatLoggerEnabled
    end

    local chat2 = coreGui:FindFirstChild("Chat")

    if chat2 then
      chat2.Enabled = chatLoggerEnabled
    end
  end
end

task.spawn(function()
  while SentinelActive do
    task.wait(0.25)
  end
end)

task.spawn(function()
  coreGui.ChildAdded:Connect(function(child4)
    if Config.ChatLoggerEnabled then
      if child4.Name == "TextChat" or child4.Name == "Chat" then
        task.wait(0.2)
        applyChatState()
      end
    end
  end)

  if textChatService then
    textChatService.ChildAdded:Connect(function(child5)
      if Config.ChatLoggerEnabled and child5.Name == "ChatWindowConfiguration" then
        task.wait(0.2)
        applyChatState()
      end
    end)
  end

  localPlayer.PlayerGui.ChildAdded:Connect(function(child6)
    if Config.ChatLoggerEnabled and child6.Name == "Chat" then
      task.wait(0.2)
      applyChatState()
    end
  end)
end)

localPlayer.CharacterAdded:Connect(function(character23)
  task.spawn(function() applyNametags(character23) end)
  task.wait(1)

  local clientScripts2 = character23:FindFirstChild("ClientScripts")

  if clientScripts2 then
    local stagger2 = clientScripts2:FindFirstChild("Stagger")

    if stagger2 then
      stagger2.Disabled = not Config.StaggerEnabled
    end
  end

  canInfect = true

  if Config.StaggerImmune then
    character23:SetAttribute("StaggerImmune", true)
  end

  if Config.FlyEnabled then
    task.wait(0.5)
    CurrentFlyType = "Seat [UNDETECTED]"
    FlySpeed = Config.FlySpeed
    enableFly(true)
  end

  if Config.ChatLoggerEnabled then
    task.wait(1)
    applyChatState()

    task.delay(2, function()
      if Config.ChatLoggerEnabled then
        applyChatState()
      end
    end)
  end
end)

if localPlayer.Character then
  applyNametags(localPlayer.Character)
  local clientScripts3 = localPlayer.Character:FindFirstChild("ClientScripts")

  if clientScripts3 then
    local stagger3 = clientScripts3:FindFirstChild("Stagger")

    if stagger3 then
      stagger3.Disabled = not Config.StaggerEnabled
    end
  end

  if Config.StaggerImmune then
    localPlayer.Character:SetAttribute("StaggerImmune", true)
  end
end

function toggleFakeInjured()
  if Config.FakeInjured then
    local character24 = localPlayer.Character

    if not character24 then
      return
    else
      local humanoid14 = character24:FindFirstChildOfClass("Humanoid")

      if not humanoid14 then
        return
      end

      if not FakeInjuredTrack then
        local animator9 = humanoid14:FindFirstChildOfClass("Animator")
          or Instance.new("Animator", humanoid14)

        local animation6 = Instance.new("Animation")
        animation6.AnimationId = "rbxassetid://94302036679429"

        FakeInjuredTrack = animator9:LoadAnimation(animation6)
        FakeInjuredTrack.Looped = true
      end

      return
    end
  else
    if FakeInjuredTrack then
      FakeInjuredTrack:Stop()
      FakeInjuredTrack = nil
    end

    return
  end
end

runService.Heartbeat:Connect(function()
  if not SentinelActive then
    return
  elseif not Config.FakeInjured then
    if FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
      FakeInjuredTrack:Stop()
    end

    return
  else
    local character25 = localPlayer.Character

    if not character25 then
      return
    else
      local humanoid15 = character25:FindFirstChildOfClass("Humanoid")

      if not humanoid15 or humanoid15.Health <= 0 then
        if FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
          FakeInjuredTrack:Stop()
        end

        return
      else
        local humanoidRootPart12 = character25:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart12 then
          if FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
            FakeInjuredTrack:Stop()
          end

          return
        else
          local velocity2 = humanoidRootPart12.Velocity

          if Vector3.new(velocity2.X, 0, velocity2.Z).Magnitude < 0.5
            and humanoid15:GetState() ~= Enum.HumanoidStateType.Jumping
            and humanoid15:GetState() ~= Enum.HumanoidStateType.Freefall then
            if FakeInjuredTrack and not FakeInjuredTrack.IsPlaying then
              FakeInjuredTrack:Play()
            end
          elseif FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
            FakeInjuredTrack:Stop()
          end

          return
        end
      end
    end
  end
end)

fakeDeathBV = nil
fakeDeathBP = nil

function toggleFakeDeath()
  local character26 = localPlayer.Character

  if not character26 then
    return
  else
    local humanoid16 = character26:FindFirstChildOfClass("Humanoid")

    if not humanoid16 then
      return
    end

    if Config.FakeDeath then
      if fakeDeathBV then
        fakeDeathBV:Destroy()
        fakeDeathBV = nil
      end

      if fakeDeathBP then
        fakeDeathBP:Destroy()
        fakeDeathBP = nil
      end

      local animator10 = humanoid16:FindFirstChildOfClass("Animator")

      local instance2 = animator10
      instance2 = animator10 or Instance.new("Animator", humanoid16)

      local animation7 = Instance.new("Animation")
      animation7.AnimationId = "rbxassetid://114023816208972"

      FakeDeathAnimTrack = instance2:LoadAnimation(animation7)
      FakeDeathAnimTrack.Looped = true
      FakeDeathAnimTrack:Play()

      humanoid16.PlatformStand = true
      humanoid16.WalkSpeed = 0
      humanoid16.JumpPower = 0

      local humanoidRootPart13 = character26:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart13 then
        fakeDeathBV = Instance.new("BodyVelocity")
        fakeDeathBV.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        fakeDeathBV.Velocity = Vector3.new(0, 0, 0)
        fakeDeathBV.Parent = humanoidRootPart13

        fakeDeathBP = Instance.new("BodyPosition")
        fakeDeathBP.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        fakeDeathBP.Position = humanoidRootPart13.Position + Vector3.new(0, 1, 0)
        fakeDeathBP.Parent = humanoidRootPart13
      end
    else
      if FakeDeathAnimTrack then
        FakeDeathAnimTrack:Stop()
        FakeDeathAnimTrack = nil
      end

      humanoid16.PlatformStand = false
      humanoid16.WalkSpeed = 9
      humanoid16.JumpPower = 50

      if fakeDeathBV then
        fakeDeathBV:Destroy()
        fakeDeathBV = nil
      end

      if fakeDeathBP then
        fakeDeathBP:Destroy()
        fakeDeathBP = nil
      end
    end

    return
  end
end

function suicideWithAnimation()
  local character27 = localPlayer.Character

  if not character27 then
    return
  else
    local humanoid17 = character27:FindFirstChildOfClass("Humanoid")

    if not humanoid17 then
      return
    else
      local animator11 = humanoid17:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid17)

      local animation8 = Instance.new("Animation")
      animation8.AnimationId = "rbxassetid://82480275101558"

      local loadAnimation4 = animator11:LoadAnimation(animation8)
      loadAnimation4:Play()
      loadAnimation4.Stopped:Wait()

      humanoid17.Health = 0
      return
    end
  end
end

function removeElephantFoot()
  local v74 = false

  for index20, value24 in ipairs(workspace:GetDescendants()) do
    if value24.Name == "LookAtMe" then
      value24:Destroy()
      v74 = true
    end
  end

  if v74 then
    pcall(function()
      if WindUI then
        WindUI:Notify({ Title = "Success", Content = "Elephant foot removed", Duration = 3 })
      end
    end)
  else
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Failed",
          Content = "Elephant foot already removed",
          Duration = 3,
        })
      end
    end)
  end
end

function removeArabicDud()
  local map = workspace:FindFirstChild("Map")
  local lobbySpawn = map and map:FindFirstChild("LobbySpawn")
  local arabic = lobbySpawn and lobbySpawn:FindFirstChild("Arabic")

  if arabic then
    arabic:Destroy()
  else
    pcall(function()
      if WindUI then
        WindUI:Notify({ Title = "Failed", Content = "Arabic dud not found", Duration = 5 })
      end
    end)
  end
end

function removeLobbyMusic()
  local count5 = 0

  for index21, value25 in ipairs(workspace:GetDescendants()) do
    if value25.Name == "Radio" then
      value25:Destroy()
      count5 = count5 + 1
    end
  end

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Success",
        Content = "Removed " .. count5 .. " Radio(s)",
        Duration = 3,
      })
    end
  end)
end

function deleteAllDoors()
  local gameDoors = workspace:FindFirstChild("GameDoors")
  local v75

  if not gameDoors then
    pcall(function()
      if WindUI then
        WindUI:Notify({ Title = "Error", Content = "GameDoors not found", Duration = 3 })
      end
    end)

    return
  else
    local getChildren = gameDoors.GetChildren
    v75 = 0

    for index22, value26 in ipairs(getChildren(gameDoors)) do
      if value26.Name:match("Generator%d") then
        local doorsToOpen = value26:FindFirstChild("DoorsToOpen")

        if doorsToOpen then
          doorsToOpen:Destroy()
          v75 = v75 + 1
        end
      end
    end

    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Success",
          Content = "Deleted " .. v75 .. " DoorsToOpen folder(s)",
          Duration = 3,
        })
      end
    end)

    return
  end
end

function deleteAllLandmines()
  local count6 = 0

  for index23, value27 in ipairs(workspace:GetDescendants()) do
    if value27.Name == "Landmine" and value27:IsA("Model") then
      value27:Destroy()
      count6 = count6 + 1
    end
  end

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Success",
        Content = "Deleted " .. count6 .. " landmines",
        Duration = 3,
      })
    end
  end)
end

teleportPoints = {
  ["Sector 1"] = {
    { "Spawn", Vector3.new(-55, -33, -1410) }, { "Generator 1", Vector3.new(135, -30, -1225) },
    { "Reactor 4", Vector3.new(-208, -32, -933) }, { "Mutant", Vector3.new(-281, -31, -671) },
    { "Valve", Vector3.new(-510, -43, -548) }, { "Generator 2", Vector3.new(-145, -30, -1149) },
  },
  ["Sector 2"] = {
    { "Sector entrance", Vector3.new(-110, -10, -825) },
    { "Russman's office", Vector3.new(38, -10, -917) },
    { "Armory", Vector3.new(-45, -10, -894) }, { "Keycard", Vector3.new(50, -10, -1054) },
    { "Steve Remington", Vector3.new(-30, 0, -1058) },
  },
  ["Sector 3"] = {
    { "Sector entrance", Vector3.new(208, -31, -1171) },
    { "Crates 1-3", Vector3.new(289, -31, -1216) }, { "Crate 4", Vector3.new(676, -31, -1342) },
    { "Crate 5", Vector3.new(597, -49, -1395) }, { "Crate 6", Vector3.new(471, -50, -1293) },
    { "C4 crate 1", Vector3.new(462, -31, -1004) },
    { "C4 crate 2", Vector3.new(349, -31, -817) },
    { "C4 crate 3", Vector3.new(636, -31, -754) },
    { "C4 crate 4", Vector3.new(843, -18, -1060) }, { "Keycard", Vector3.new(774, -31, -857) },
  },
}

function teleportTo(p61)
  local character28 = localPlayer.Character

  if character28 and character28:FindFirstChild("HumanoidRootPart") then
    character28:PivotTo(CFrame.new(p61))
  end
end

function teleportToCFrame(p62)
  local character29 = localPlayer.Character

  if character29 and character29:FindFirstChild("HumanoidRootPart") then
    character29:PivotTo(p62)
  end
end

RestrictedServerCFrame = CFrame.new(
  -80.9715881, -28.5348167, -1419.7843, 0.996191859, 0, 0.0871884301, 0, 1, 0, -0.0871884301, 0,
  0.996191859
)

toggleAnims = {
  ["Artur Novas's idle"] = "rbxassetid://105747901312742",
  ["Adam Dice (died)"] = "rbxassetid://114023816208972",
  ["Chimera's walk (old)"] = "rbxassetid://97147187591899",
  ["Chimera's run (old)"] = "rbxassetid://95054120636955",
  ["Sinitzyn's idle"] = "rbxassetid://110122744601596",
  ["Sinitzyn's stun"] = "rbxassetid://111159713841127",
  ["Kamikaze's walk"] = "rbxassetid://87989829896123",
  ["Kamikaze's run"] = "rbxassetid://78355773495995",
  ["Mikhail William's walk (old)"] = "rbxassetid://100407162198079",
  ["Mikhail William's run (old)"] = "rbxassetid://126189604062142",
  ["Mikhail William's walk"] = "rbxassetid://91584116987163",
  ["Mikhail William's run"] = "rbxassetid://88561714950741",
  ["Dave's walk"] = "rbxassetid://102796637818967",
  ["Dave's idle"] = "rbxassetid://114416822114803",
  ["Dave's run"] = "rbxassetid://117962541964796",
  ["Gilbert's idle"] = "rbxassetid://93686257760742",
  ["Gabriel Campos's idle"] = "rbxassetid://90243612758647",
  ["Elsher Tachyon's idle"] = "rbxassetid://77191557762002",
  ["Lurker's idle"] = "rbxassetid://86501473853720",
  ["Lurker's sleeping"] = "rbxassetid://115201807246648",
  ["Manhattan Ristretto's idle"] = "rbxassetid://137802244588968",
  Masterbait = "rbxassetid://72042024",
  ["Mikhail Willaim's idle (old)"] = "rbxassetid://88875709567990",
  ["Mikhail William's idle"] = "rbxassetid://87959458481723",
  ["Mutant crawler idle"] = "rbxassetid://81279098398635",
  ["Slasher's idle (old)"] = "rbxassetid://91056825760026",
  ["Slasher's idle"] = "rbxassetid://95464797704887",
  ["Slasher's walk"] = "rbxassetid://139858886667310",
  ["Slasher's stun"] = "rbxassetid://137568989278456",
  ["Slasher's run"] = "rbxassetid://94555617501510",
  ["Stan's idle"] = "rbxassetid://108552997989260",
  ["MGF scared"] = "rbxassetid://86398576306953",
  ["MGF patrol"] = "rbxassetid://131603010936163",
  ["MGF musician"] = "rbxassetid://138827413895574",
  ["MGF dying"] = "rbxassetid://128467654154071",
  ["MGF medic"] = "rbxassetid://129366509916255",
  ["MGF injured"] = "rbxassetid://94302036679429",
  ["MGF idle (1)"] = "rbxassetid://113537404842453",
  ["MGF idle (2)"] = "rbxassetid://102193570284695",
  ["Viral Executioner's idle"] = "rbxassetid://97492866706742",
  ["Viral Executioner's walk"] = "rbxassetid://103392791669526",
  ["Viral Commander's walk"] = "rbxassetid://17621267464",
  ["Viral Commander's run"] = "rbxassetid://111821553591135",
  ["Head shake"] = "rbxassetid://118621065272904",
  Unstable = "rbxassetid://9146103628",
  ["Josh Katzmann idle"] = "rbxassetid://131498119560497",
  ["Josh Katzmann healed idle"] = "rbxassetid://139426604018597",
}

buttonAnims = {
  ["Adam Dice's death"] = "rbxassetid://102514666836619",
  ["Chimera's victim (old)"] = "rbxassetid://83991914102646",
  ["Chimera's teleport (old)"] = "rbxassetid://126809285460597",
  ["Chimera's enrage (old)"] = "rbxassetid://75151963392982",
  ["Chimera's execution (old)"] = "rbxassetid://97305733594978",
  ["Chimera's death"] = "rbxassetid://72189339897414",
  ["Chimera's execution"] = "rbxassetid://128010889227844",
  ["Chimera's enrage"] = "rbxassetid://99134420474156",
  ["Chimera's teleport (1)"] = "rbxassetid://112732398453305",
  ["Chimera's teleport (2)"] = "rbxassetid://136368566634578",
  ["Chimera's teleport execution (1)"] = "rbxassetid://112634711476303",
  ["Chimera's teleport execution (2)"] = "rbxassetid://135404812014332",
  ["Chimera's last stand"] = "rbxassetid://110849469223486",
  ["Chimera's punch"] = "rbxassetid://84314656273153",
  ["Cultist's dropkick"] = "rbxassetid://103266367846238",
  ["Cultist's miss"] = "rbxassetid://120641479913190",
  ["Cloaker's run"] = "rbxassetid://131730874916280",
  ["Controllable infected's turn (old)"] = "rbxassetid://136775254837264",
  Cough = "rbxassetid://111615919261340",
  ["Gilbert's execution"] = "rbxassetid://125655523925085",
  ["Gilbert's victim"] = "rbxassetid://135138331651211",
  ["D-Zero's vent"] = "rbxassetid://116242805691656",
  ["D-Zero's execution"] = "rbxassetid://127050736497150",
  ["Sinitzyn's swing"] = "rbxassetid://109639053938974",
  ["Sinitzyn's kick"] = "rbxassetid://139352596916392",
  ["Sinitzyn's enrage"] = "rbxassetid://98239206283649",
  ["Sinitzyn's execution (RPD)"] = "rbxassetid://136147569002553",
  ["Sinitzyn's execution (melee)"] = "rbxassetid://81984907411347",
  ["Sinitzyn's explosion"] = "rbxassetid://99615889025883",
  ["Slasher's swing"] = "rbxassetid://103822882233361",
  ["Slasher's execution"] = "rbxassetid://132206439126644",
  ["Slasher's victim"] = "rbxassetid://133617679957232",
  ["Shielder's execution"] = "rbxassetid://90580282540451",
  ["Slit Neck"] = "rbxassetid://130568157355000",
  ["Infection fall (1)"] = "rbxassetid://99985127815659",
  ["Infection fall (2)"] = "rbxassetid://139465334169627",
  ["Iris's rage"] = "rbxassetid://102771532479094",
  Kick = "rbxassetid://86079982232120",
  Punch = "rbxassetid://83700864626681",
  Taunt = "rbxassetid://80378935722704",
  ["Josh Katzmann healed"] = "rbxassetid://85697630315285",
  ["Lurker awaking"] = "rbxassetid://138937044212276",
  ["Mutant stun"] = "rbxassetid://111539044506405",
  ["Elephant foot"] = "rbxassetid://139981313122152",
  ["Riser's resurrection"] = "rbxassetid://116866937096686",
  ["Riser's death"] = "rbxassetid://89976361144233",
  ["Hatred kill (1)"] = "rbxassetid://138691140561523",
  ["Hatred kill (2)"] = "rbxassetid://91463196236370",
  ["Hatred kill (3)"] = "rbxassetid://83632013221100",
  ["Hatred kill (4)"] = "rbxassetid://91849031357031",
  ["Viral runner's execution"] = "rbxassetid://84530831648572",
  ["Viral runner's victim"] = "rbxassetid://76887258783187",
  ["Viral runner's maul"] = "rbxassetid://135884501960780",
  ["Viral runner's maul victim"] = "rbxassetid://118194067755191",
  ["Viral leader's execution"] = "rbxassetid://84358691838862",
  ["Viral leader's victim"] = "rbxassetid://76887258783187",
  ["Viral slasher's execution"] = "rbxassetid://132206439126644",
  ["Viral slasher's victim"] = "rbxassetid://133617679957232",
  ["MGF's last stand"] = "rbxassetid://117105602056649",
}

activeAnimTrack = nil

function playToggleAnim(animationId3, p63)
  local character30 = localPlayer.Character

  if not character30 then
    return
  else
    local humanoid18 = character30:FindFirstChildOfClass("Humanoid")

    if not humanoid18 then
      return
    else
      local animator12 = humanoid18:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid18)

      if p63 then
        if activeAnimTrack then
          activeAnimTrack:Stop()
        end

        local animation9 = Instance.new("Animation")
        animation9.AnimationId = animationId3

        activeAnimTrack = animator12:LoadAnimation(animation9)
        activeAnimTrack.Looped = true
        activeAnimTrack:Play()
      elseif activeAnimTrack then
        activeAnimTrack:Stop()
        activeAnimTrack = nil
      end

      return
    end
  end
end

function playButtonAnim(animationId4)
  local character31 = localPlayer.Character

  if not character31 then
    return
  else
    local humanoid19 = character31:FindFirstChildOfClass("Humanoid")

    if not humanoid19 then
      while true do
        task[localPlayer[v16(" \207EE", 27857936757420)]](1)

        if Config[localPlayer[v16("\162\r\246\128\245\162\30\183\28y", 207951151200)]]
          and SentinelActive then
          local v76 = f2[localPlayer[v16("\243&8Iadq\191s", 9538560004441)]]

          if v76 then
            v61[v62[4]](v76)
          end
        else
          break
        end
      end

      return
    else
      local animator13 = humanoid19:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid19)

      local animation10 = Instance.new("Animation")
      animation10.AnimationId = animationId4

      animator13:LoadAnimation(animation10):Play()
      return
    end
  end
end

function getCooldownContainer()
  local playerGui4 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui4 then
    return nil
  else
    local character32 = localPlayer.Character
    local tool = character32 and character32:FindFirstChildOfClass("Tool")

    if not tool then
      return nil
    else
      local findFirstChild4 = playerGui4:FindFirstChild(tool.Name)

      return findFirstChild4 and findFirstChild4:FindFirstChild("Data")
        and findFirstChild4.Data:FindFirstChild("Cooldowns")
    end
  end
end

function setCooldownVisibility(p64, visible)
  local v77 = getCooldownContainer()

  if not v77 then
    return
  else
    local findFirstChild5 = v77:FindFirstChild(p64)

    if findFirstChild5 then
      findFirstChild5.Visible = visible
    end

    v77.Visible = (v77:FindFirstChild("Bash") and v77.Bash.Visible
          or v77:FindFirstChild("Kick") and v77.Kick.Visible)
        and true
      or false

    return
  end
end

function resetFade(p65)
  for index24, value28 in ipairs(p65:GetDescendants()) do
    if value28:IsA("Frame") and value28:GetAttribute("_cd_BackgroundTransparency") then
      value28.BackgroundTransparency = value28:GetAttribute("_cd_BackgroundTransparency")
    elseif value28:IsA("ImageLabel") or value28:IsA("ImageButton") then
      if value28:GetAttribute("_cd_ImageTransparency") then
        value28.ImageTransparency = value28:GetAttribute("_cd_ImageTransparency")
      end

      if value28:GetAttribute("_cd_BackgroundTransparency") then
        value28.BackgroundTransparency = value28:GetAttribute("_cd_BackgroundTransparency")
      end
    elseif value28:IsA("TextLabel") or value28:IsA("TextButton") or value28:IsA("TextBox") then
      if value28:GetAttribute("_cd_TextTransparency") then
        value28.TextTransparency = value28:GetAttribute("_cd_TextTransparency")
      end

      if value28:GetAttribute("_cd_BackgroundTransparency") then
        value28.BackgroundTransparency = value28:GetAttribute("_cd_BackgroundTransparency")
      end
    elseif value28:IsA("UIStroke") and value28:GetAttribute("_cd_Transparency") then
      value28.Transparency = value28:GetAttribute("_cd_Transparency")
    end
  end
end

function fadeOut(p66, p67)
  local tweenInfo = TweenInfo.new(p67, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

  for index25, value29 in ipairs(p66:GetDescendants()) do
    if value29:IsA("Frame") then
      if not value29:GetAttribute("_cd_BackgroundTransparency") then
        value29:SetAttribute("_cd_BackgroundTransparency", value29.BackgroundTransparency)
      end

      tweenService:Create(value29, tweenInfo, { BackgroundTransparency = 1 }):Play()
    elseif value29:IsA("ImageLabel") or value29:IsA("ImageButton") then
      if not value29:GetAttribute("_cd_ImageTransparency") then
        value29:SetAttribute("_cd_ImageTransparency", value29.ImageTransparency)
      end

      if not value29:GetAttribute("_cd_BackgroundTransparency") then
        value29:SetAttribute("_cd_BackgroundTransparency", value29.BackgroundTransparency)
      end

      tweenService:Create(value29, tweenInfo, {
        ImageTransparency = 1,
        BackgroundTransparency = 1,
      }):Play()
    elseif value29:IsA("TextLabel") or value29:IsA("TextButton") or value29:IsA("TextBox") then
      if not value29:GetAttribute("_cd_TextTransparency") then
        value29:SetAttribute("_cd_TextTransparency", value29.TextTransparency)
      end

      if not value29:GetAttribute("_cd_BackgroundTransparency") then
        value29:SetAttribute("_cd_BackgroundTransparency", value29.BackgroundTransparency)
      end

      tweenService:Create(value29, tweenInfo, {
        TextTransparency = 1,
        BackgroundTransparency = 1,
      }):Play()
    elseif value29:IsA("UIStroke") then
      if not value29:GetAttribute("_cd_Transparency") then
        value29:SetAttribute("_cd_Transparency", value29.Transparency)
      end

      tweenService:Create(value29, tweenInfo, { Transparency = 1 }):Play()
    end
  end
end

function getCooldownBar(p68)
  local playerGui5 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui5 then
    return nil
  else
    local character33 = localPlayer.Character
    local tool2 = character33 and character33:FindFirstChildOfClass("Tool")

    if not tool2 then
      return nil
    else
      local findFirstChild6 = playerGui5:FindFirstChild(tool2.Name)

      if findFirstChild6 and findFirstChild6:FindFirstChild("Data")
        and findFirstChild6.Data:FindFirstChild("Cooldowns")
        and findFirstChild6.Data.Cooldowns:FindFirstChild(p68) then
        return findFirstChild6.Data.Cooldowns[p68]:FindFirstChild("Bar")
      end

      return nil
    end
  end
end

function playCooldown(p69, p70, p71)
  local cooldownCounter = CooldownCounter
  local v78 = getCooldownBar(p69)
  local v79, create2

  if not v78 then
    return
  else
    v79 = getCooldownContainer()
    local findFirstChild7 = v79 and v79:FindFirstChild(p69)

    if findFirstChild7 then
      resetFade(findFirstChild7)
    end

    if ActiveTweens[p69] then
      ActiveTweens[p69]:Cancel()
      ActiveTweens[p69] = nil
    end

    v78.AnchorPoint = Vector2.new(0, 1)
    v78.Position = UDim2.new(0, 0, 1, 0)
    v78.Size = UDim2.new(1, 0, math.clamp(p71 or 0, 0, 1), 0)
    v78.Visible = true

    create2 = tweenService:Create(v78, TweenInfo.new(
      p70, Enum.EasingStyle.Linear, Enum.EasingDirection.Out
    ), { Size = UDim2.new(1, 0, 1, 0) })

    ActiveTweens[p69] = create2

    if v79 then
      setCooldownVisibility(p69, true)
    end

    create2:Play()

    create2.Completed:Connect(function()
      if cooldownCounter ~= CooldownCounter or ActiveTweens[p69] ~= create2 then
        return
      end

      ActiveTweens[p69] = nil
      CooldownData[p69] = nil

      if findFirstChild7 then
        fadeOut(findFirstChild7, 0.2)
      end

      task.delay(0.2, function()
        if cooldownCounter ~= CooldownCounter then
          return
        end

        v78.Visible = false

        if v79 then
          setCooldownVisibility(p69, false)
        end

        if findFirstChild7 then
          resetFade(findFirstChild7)
        end
      end)
    end)

    return
  end
end

function renderCooldown(p72)
  local v80 = CooldownData[p72]

  if not v80 then
    if getCooldownContainer() then
      setCooldownVisibility(p72, false)
    end

    return
  else
    local v81 = tick()
    local v82 = v80.finish - v81

    if v82 <= 0 then
      CooldownData[p72] = nil

      if getCooldownContainer() then
        setCooldownVisibility(p72, false)
      end

      return
    end

    playCooldown(
      p72, v82, v80.duration > 0 and math.clamp((v81 - v80.start) / v80.duration, 0, 1) or 0
    )

    return
  end
end

function renderAllCooldowns()
  CooldownCounter = CooldownCounter + 1

  for key8, value30 in pairs(ActiveTweens) do
    if value30 then
      value30:Cancel()
    end

    ActiveTweens[key8] = nil
  end

  renderCooldown("Bash")
  renderCooldown("Kick")
end

if BashCooldownUI then
  BashCooldownUI.OnClientEvent:Connect(function(p73, p74)
    local v83 = p73

    if v83 == "bash" then
      v83 = "Bash"
    end

    if v83 == "kick" then
      v83 = "Kick"
    end

    local v84 = tick()
    CooldownData[v83] = { start = v84, duration = p74, finish = v84 + p74 }
    renderAllCooldowns()
  end)
end

userInputService.InputBegan:Connect(function(input6, p75)
  SentinelLastInteraction = tick()

  if p75 then
    return
  end

  if input6.KeyCode == Enum.KeyCode.LeftShift or input6.KeyCode == Enum.KeyCode.RightShift then
    isShiftHeld = true
  end
end)

userInputService.InputChanged:Connect(function() SentinelLastInteraction = tick() end)

userInputService.InputEnded:Connect(function(input7)
  if input7.KeyCode == Enum.KeyCode.LeftShift or input7.KeyCode == Enum.KeyCode.RightShift then
    isShiftHeld = false
    local character34 = localPlayer.Character

    if character34 then
      local humanoid20 = character34:FindFirstChildOfClass("Humanoid")

      if humanoid20 and Config.SpeedHackEnabled then
        humanoid20.WalkSpeed = Config.WalkSpeedValue
      end
    end
  end
end)

task.spawn(function()
  while SentinelActive do
    task.wait(0.2)

    if Config.AutoWipeBlood then
      pcall(function()
        local gui3 = localPlayer.PlayerGui:FindFirstChild("Gui")

        if gui3 then
          for key9, clean2 in pairs(gui3:GetChildren()) do
            if clean2.Name == "blood" then
              clean2.Name = "clean"
              tweenService:Create(clean2, TweenInfo.new(0.2), { ImageTransparency = 1 }):Play()
              debris:AddItem(clean2, 0.5)
            end
          end
        end
      end)
    end
  end
end)

function hookToolSwap(p76)
  p76.ChildAdded:Connect(function(child7)
    if child7:IsA("Tool") then
      task.defer(renderAllCooldowns)
    end
  end)

  p76.ChildRemoved:Connect(function(child8)
    if child8:IsA("Tool") then
      task.defer(renderAllCooldowns)
    end
  end)
end

if localPlayer.Character then
  hookToolSwap(localPlayer.Character)
  task.defer(renderAllCooldowns)
end

localPlayer.CharacterAdded:Connect(function(character35)
  hookToolSwap(character35)
  task.defer(renderAllCooldowns)
  local waitForChild = character35:WaitForChild("Humanoid", 5)

  if waitForChild then
    savedHipHeight = waitForChild.HipHeight
  end

  if Config.FakeDeath then
    task.wait(0.5)
    toggleFakeDeath()
  end

  if Config.FakeInjured then
    task.wait(0.5)
    toggleFakeInjured()
  end

  canInfect = true

  if Config.StaggerImmune then
    character35:SetAttribute("StaggerImmune", true)
  end

  if Config.FlyEnabled then
    task.wait(0.5)
    CurrentFlyType = "Seat [UNDETECTED]"
    FlySpeed = Config.FlySpeed
    enableFly(true)
  end

  if Config.ChatLoggerEnabled then
    task.wait(1)
    applyChatState()

    task.delay(2, function()
      if Config.ChatLoggerEnabled then
        applyChatState()
      end
    end)
  end

  if Config.NightStalkerInfAmmo then
    task.wait(0.5)
  end
end)

ClientEvents = replicatedStorage:FindFirstChild("Events")

if ClientEvents and ClientEvents:FindFirstChild("client")
  and ClientEvents.client:FindFirstChild("Event") then
  pcall(function()
    ClientEvents.client.Event:Connect(function(p77, ...)
      if Config.AntiCamShake and (p77 == "camspring" or p77 == "recoil" or p77 == "shake") then
        return
      end
    end)
  end)
end

function checkMob(p78)
  local characters4 = workspace:FindFirstChild("Characters")

  if characters4 and not p78:IsDescendantOf(characters4) then
    return
  end

  if p78:IsA("Model") and p78:FindFirstChild("HumanoidRootPart")
    and p78:FindFirstChildOfClass("Humanoid") then
    if p78 ~= localPlayer.Character and p78.Name ~= localPlayer.Name
      and not players:GetPlayerFromCharacter(p78) and not table.find(CachedMobs, p78) then
      table.insert(CachedMobs, p78)
      p78.AncestryChanged:Connect(function(p79, p80) end)
    end
  end
end

task.spawn(function()
  local characters5 = workspace:FindFirstChild("Characters")

  for index26, value31 in ipairs(characters5 and characters5:GetDescendants()
    or workspace:GetDescendants()) do
    checkMob(value31)

    if index26 % 200 == 0 then
      task.wait()
    end
  end
end)

workspace.DescendantAdded:Connect(function(descendant6)
  if descendant6:IsA("Model") then
    task.wait(0.3)
    checkMob(descendant6)
  end
end)

local jumpRequest = userInputService.JumpRequest

local function f29(p81, p82, color, thickness)
  if not p81 or not p82 then
    return
  else
    local humanoidRootPart14 = p82:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart14 then
      for index27, value32 in ipairs(p81) do
        value32.Visible = false
      end

      return
    else
      local humanoid21 = p82:FindFirstChildOfClass("Humanoid")

      if not humanoid21 or humanoid21.Health <= 0 then
        for index28, value33 in ipairs(p81) do
          value33.Visible = false
        end

        return
      else
        local position = humanoidRootPart14.Position
        local position2 = currentCamera.CFrame.Position
        local cframe3 = CFrame.lookAt(position, position + (position - position2).Unit)
        local x = humanoidRootPart14.Size.X
        local v85 = humanoidRootPart14.Size.Y * 1.5
        local cframe4 = CFrame.new(-x, v85, 0)
        local cframe5 = CFrame.new(x, v85, 0)
        local cframe6 = CFrame.new(-x, -v85, 0)
        local cframe7 = CFrame.new(x, -v85, 0)
        local v86, v87 = currentCamera:WorldToViewportPoint((cframe3 * cframe4).p)
        local v88, v89 = currentCamera:WorldToViewportPoint((cframe3 * cframe5).p)
        local v90, v91 = currentCamera:WorldToViewportPoint((cframe3 * cframe6).p)
        local v92, v93 = currentCamera:WorldToViewportPoint((cframe3 * cframe7).p)

        if not v87 then
          for index29, value34 in ipairs(p81) do
            value34.Visible = false
          end

          return
        else
          local magnitude3 = (position - position2).Magnitude
          local v94 = math.clamp(1 / magnitude3 * 750, 2, 300)

          p81[1].From = Vector2.new(v86.X, v86.Y)
          p81[1].To = Vector2.new(v86.X + v94, v86.Y)
          p81[2].From = Vector2.new(v86.X, v86.Y)
          p81[2].To = Vector2.new(v86.X, v86.Y + v94)
          p81[3].From = Vector2.new(v88.X, v88.Y)
          p81[3].To = Vector2.new(v88.X - v94, v88.Y)
          p81[4].From = Vector2.new(v88.X, v88.Y)
          p81[4].To = Vector2.new(v88.X, v88.Y + v94)
          p81[5].From = Vector2.new(v90.X, v90.Y)
          p81[5].To = Vector2.new(v90.X + v94, v90.Y)
          p81[6].From = Vector2.new(v90.X, v90.Y)
          p81[6].To = Vector2.new(v90.X, v90.Y - v94)
          p81[7].From = Vector2.new(v92.X, v92.Y)
          p81[7].To = Vector2.new(v92.X - v94, v92.Y)
          p81[8].From = Vector2.new(v92.X, v92.Y)
          p81[8].To = Vector2.new(v92.X, v92.Y - v94)

          for index30, value35 in ipairs(p81) do
            value35.Color = color

            if Config.BoxAutoThickness then
              value35.Thickness = math.clamp(1 / magnitude3 * 100, 1, 4)
            else
              value35.Thickness = thickness
            end

            value35.Visible = true
            value35.Transparency = 1
          end

          return
        end
      end
    end
  end
end

local function f30(p83)
  if not p83 then
    return
  end

  for index31, value36 in ipairs(p83) do
    local v95 = value36
    pcall(function() v95:Remove() end)
  end
end

jumpRequest:Connect(function()
  local character36 = localPlayer.Character
  local humanoid22 = character36 and character36:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart15 = character36 and character36:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart15 or not humanoid22 then
    return
  else
    local jumpPowerValue = Config.JumpPowerEnabled and Config.JumpPowerValue or 50

    if Config.InfiniteJump then
      humanoidRootPart15.Velocity = Vector3.new(
        humanoidRootPart15.Velocity.X, jumpPowerValue, humanoidRootPart15.Velocity.Z
      )

      humanoid22:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    if Config.JumpBypassActive and not Config.InfiniteJump then
      if humanoid22.FloorMaterial ~= Enum.Material.Air then
        humanoidRootPart15.Velocity = Vector3.new(
          humanoidRootPart15.Velocity.X, jumpPowerValue, humanoidRootPart15.Velocity.Z
        )
      end
    end

    return
  end
end)

local v96 = {}

local function f31(p84, p85)
  if not p84 then
    return
  else
    local findFirstChild8 = p84:FindFirstChild(p85)

    if findFirstChild8 then
      findFirstChild8:Destroy()
    end

    if v96[p84] then
      v96[p84] = nil
    end

    return
  end
end

local v97 = {}

local function f32(color2, thickness2)
  local v98 = {}

  if not Capabilities.Drawing then
    return v98
  end

  for j = 1, 8 do
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color2
    line.Thickness = thickness2
    line.Transparency = 1

    v98[j] = line
  end

  return v98
end

local function f33(p86)
  if not p86 then
    return nil
  else
    local humanoidRootPart16 = p86:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart16 then
      return nil
    else
      local sentinelInfoBBG = humanoidRootPart16:FindFirstChild("SentinelInfoBBG")

      if not sentinelInfoBBG then
        sentinelInfoBBG = Instance.new("BillboardGui")
        sentinelInfoBBG.Name = "SentinelInfoBBG"
        sentinelInfoBBG.Size = UDim2.new(0, 200, 0, 60)
        sentinelInfoBBG.AlwaysOnTop = true
        sentinelInfoBBG.StudsOffset = Vector3.new(0, 3.5, 0)
        sentinelInfoBBG.Adornee = humanoidRootPart16
        sentinelInfoBBG.Parent = humanoidRootPart16

        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.Parent = sentinelInfoBBG

        local name2 = Instance.new("TextLabel")
        name2.Name = "Name"
        name2.Size = UDim2.new(1, 0, 0, 16)
        name2.BackgroundTransparency = 1
        name2.TextStrokeTransparency = 0.5
        name2.Font = Enum.Font.SourceSansBold
        name2.TextSize = 14
        name2.Visible = false
        name2.Parent = sentinelInfoBBG

        local health = Instance.new("TextLabel")
        health.Name = "Health"
        health.Size = UDim2.new(1, 0, 0, 14)
        health.BackgroundTransparency = 1
        health.TextStrokeTransparency = 0.5
        health.Font = Enum.Font.SourceSans
        health.TextSize = 12
        health.Visible = false
        health.Parent = sentinelInfoBBG

        local distance = Instance.new("TextLabel")
        distance.Name = "Distance"
        distance.Size = UDim2.new(1, 0, 0, 14)
        distance.BackgroundTransparency = 1
        distance.TextStrokeTransparency = 0.5
        distance.TextColor3 = Color3.fromRGB(200, 200, 200)
        distance.Font = Enum.Font.SourceSans
        distance.TextSize = 12
        distance.Visible = false
        distance.Parent = sentinelInfoBBG
      end

      return sentinelInfoBBG
    end
  end
end

local function f34(p87)
  if not p87 then
    return
  end

  for index32, value37 in ipairs(p87) do
    value37.Visible = false
  end
end

local function f35(p88, p89, p90, p91, p92)
  if not p88 then
    return
  else
    local findFirstChild9 = p88:FindFirstChild(p89)
    local v99 = v96[p88]

    if not findFirstChild9 then
      local highlight2 = Instance.new("Highlight")
      highlight2.Name = p89
      highlight2.FillColor = p90
      highlight2.FillTransparency = p91
      highlight2.OutlineTransparency = p92
      highlight2.Parent = p88

      v96[p88] = {
        hl = highlight2,
        fill = p90,
        fillTrans = p91,
        outlineTrans = p92,
      }

      return
    end

    if not v99 or v99.hl ~= findFirstChild9 then
      v99 = {
        hl = findFirstChild9,
        fill = nil,
        fillTrans = nil,
        outlineTrans = nil,
      }

      v96[p88] = v99
    end

    if v99.fill ~= p90 then
      findFirstChild9.FillColor = p90
      v99.fill = p90
    end

    if v99.fillTrans ~= p91 then
      findFirstChild9.FillTransparency = p91
      v99.fillTrans = p91
    end

    if v99.outlineTrans ~= p92 then
      findFirstChild9.OutlineTransparency = p92
      v99.outlineTrans = p92
    end

    return
  end
end

local function f36(p93, textColor3, p94, p95, p96, p97)
  if not p93 then
    return
  else
    local v100 = f33(p93)

    if not v100 then
      return
    else
      local name3 = v100:FindFirstChild("Name")
      local health2 = v100:FindFirstChild("Health")
      local distance2 = v100:FindFirstChild("Distance")

      if name3 then
        name3.Visible = p94

        if p94 then
          local getPlayerFromCharacter = players:GetPlayerFromCharacter(p93)
          name3.Text = getPlayerFromCharacter and getPlayerFromCharacter.Name or p93.Name
          name3.TextColor3 = textColor3
        end
      end

      if health2 then
        health2.Visible = p95

        if p95 then
          local humanoid23 = p93:FindFirstChildOfClass("Humanoid")

          if humanoid23 then
            health2.Text = math.round(humanoid23.Health) .. " HP"
            health2.TextColor3 = textColor3
          end
        end
      end

      if distance2 then
        distance2.Visible = p96

        if p96 and p97 then
          distance2.Text = string.format("%.1f m", p97)
          distance2.TextColor3 = textColor3
        end
      end

      return
    end
  end
end

local function f37(p98)
  if not p98 then
    return
  else
    local humanoidRootPart17 = p98:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart17 then
      local sentinelInfoBBG2 = humanoidRootPart17:FindFirstChild("SentinelInfoBBG")

      if sentinelInfoBBG2 then
        sentinelInfoBBG2:Destroy()
      end
    end

    return
  end
end

runService.RenderStepped:Connect(function(delta2)
  local humanoid24, tool3, tool4, character37, maxDistance

  if not SentinelActive then
    return
  else
    local character38 = localPlayer.Character

    if not character38 then
      return
    end

    humanoid24 = character38:FindFirstChildOfClass("Humanoid")

    if not humanoid24 or humanoid24.Health <= 0 then
      return
    else
      if Config.SpeedHackEnabled then
        humanoid24.WalkSpeed = Config.WalkSpeedValue
      end

      if Config.JumpPowerEnabled then
        pcall(function()
          humanoid24.UseJumpPower = true
          humanoid24.JumpPower = Config.JumpPowerValue
        end)
      end

      if Config.InfiniteStaminaEnabled then
        local playerGui6 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui6 then
          local gui4 = playerGui6:FindFirstChild("Gui")

          if gui4 then
            local heartbeat = gui4:FindFirstChild("heartbeat")

            if heartbeat then
              if heartbeat:IsA("Sound") then
                heartbeat:Stop()
              end

              heartbeat:Destroy()
            end

            local heartbeat2 = gui4:FindFirstChild("heartbeat2")

            if heartbeat2 then
              if heartbeat2:IsA("Sound") then
                heartbeat2:Stop()
              end

              heartbeat2:Destroy()
            end

            local vignette = gui4:FindFirstChild("vignette")

            if vignette then
              vignette.Visible = false
            end

            local statusFrame = gui4:FindFirstChild("statusFrame")

            if statusFrame then
              local stamina = statusFrame:FindFirstChild("stamina")

              if stamina then
                local bar = stamina:FindFirstChild("bar")

                if bar then
                  bar.Size = UDim2.new(1, 0, 1, 0)
                end

                local overlay = stamina:FindFirstChild("overlay")

                if overlay then
                  overlay.Visible = false
                end
              end
            end
          end
        end
      end

      if Config.FullBright then
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        lighting.Brightness = 2
      end

      if Config.NoFog then
        lighting.FogEnd = 999999999
        lighting.FogStart = 999999999
      else
        lighting.FogEnd = OrigFogEnd
        lighting.FogStart = OrigFogStart
      end

      if Config.ImmuneLookHazard then
        if gameAee then
          gameAee.Contrast = 0
        end

        if gameRadiationTint then
          gameRadiationTint.Contrast = 0
        end
      end

      if Config.CustomFOVEnabled then
        if currentCamera.FieldOfView ~= Config.FOVValue then
          tweenService:Create(
            currentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { FieldOfView = Config.FOVValue }
          ):Play()
        end
      elseif currentCamera.FieldOfView ~= OrigFOV then
        tweenService:Create(
          currentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
          { FieldOfView = OrigFOV }
        ):Play()
      end

      if Config.UnlockThirdPerson then
        if localPlayer.CameraMode ~= Enum.CameraMode.Classic then
          localPlayer.CameraMode = Enum.CameraMode.Classic
        end

        if localPlayer.CameraMaxZoomDistance < 999 then
          localPlayer.CameraMaxZoomDistance = 999
        end
      else
        if localPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
          localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        end

        if localPlayer.CameraMaxZoomDistance > 50 then
          localPlayer.CameraMaxZoomDistance = 50
        end
      end

      if Config.AntiAnchorEnabled then
        local character39 = localPlayer.Character

        if character39 then
          local humanoidRootPart18 = character39:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart18 and humanoidRootPart18.Anchored then
            humanoidRootPart18.Anchored = false
          end
        end
      end

      if Config.ViewModelEnabled then
        tool3 = character38:FindFirstChildWhichIsA("Tool")

        if tool3 then
          pcall(function() f8(tool3) end)
        end
      end

      if Config.CustomWeaponsEnabled then
        tool4 = character38:FindFirstChildWhichIsA("Tool")

        if tool4 then
          pcall(function() f9(tool4) end)
        end
      end

      character37 = localPlayer.Character
      local humanoidRootPart19 = character37 and character37:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart19 then
        return
      else
        maxDistance = Config.MaxDistance

        if type(maxDistance) ~= "number" then
          maxDistance = 1000
          Config.MaxDistance = 1000
        end

        local v101 = {}

        for key10, value38 in pairs(v97) do
          if not key10 or not key10.Parent then
            table.insert(v101, key10)
          end
        end

        for index33, value39 in ipairs(v101) do
          if v97[value39] then
            f30(v97[value39])
            v97[value39] = nil
          end

          f37(value39)

          if v96[value39] then
            v96[value39] = nil
          end
        end

        pcall(function()
          for key11, value40 in pairs(players:GetPlayers()) do
            if value40 ~= localPlayer then
              local character40 = value40.Character

              local humanoidRootPart20 = character40

              humanoidRootPart20 = character40
                and character40:FindFirstChild("HumanoidRootPart")

              local humanoid25 = character40
              humanoid25 = character40 and character40:FindFirstChildOfClass("Humanoid")

              if humanoidRootPart20 and humanoid25 then
                local magnitude4 = (humanoidRootPart19.Position - humanoidRootPart20.Position).Magnitude

                if magnitude4 <= maxDistance and humanoid25.Health > 0 then
                  if Config.HighlightPlayer then
                    f35(
                      character40, "SentinelHL", Config.ColorPlayer, Config.HLFillTrans,
                      Config.HLOutlineTrans
                    )
                  else
                    f31(character40, "SentinelHL")
                  end

                  if Config.BoxPlayers then
                    if not v97[character40] then
                      v97[character40] = f32(Config.ColorPlayer, Config.BoxThickness)
                    end

                    f29(v97[character40], character40, Config.ColorPlayer, Config.BoxThickness)
                  elseif v97[character40] then
                    f34(v97[character40])
                  end

                  f36(
                    character40, Config.ColorPlayer, Config.ShowNamePlayers,
                    Config.ShowHealthPlayers, Config.ShowDistancePlayers, magnitude4
                  )
                else
                  if v97[character40] then
                    f34(v97[character40])
                  end

                  f31(character40, "SentinelHL")
                  f37(character40)
                end
              elseif character40 then
                if v97[character40] then
                  f30(v97[character40])
                  v97[character40] = nil
                end

                f31(character40, "SentinelHL")
                f37(character40)
              end
            end
          end
        end)

        pcall(function()
          local v102 = #CachedMobs - -1

          local colorBosses, highlightBosses, boxBosses, showNameBosses, showHealthBosses,
            showDistanceBosses

          while true do
            v102 = -1 + v102

            if not (1 <= v102 or false) then
              break
            end

            local v103 = v102
            local v104 = CachedMobs[v103]

            if v104 and v104.Parent then
              if v104 == character37 or v104 == localPlayer.Character
                or v104.Name == localPlayer.Name or players:GetPlayerFromCharacter(v104) then
                if v97[v104] then
                  f30(v97[v104])
                  v97[v104] = nil
                end

                f31(v104, "SentinelMobHL")
                f37(v104)
                table.remove(CachedMobs, v103)
              else
                local humanoidRootPart21 = v104:FindFirstChild("HumanoidRootPart")
                local humanoid26 = v104:FindFirstChildOfClass("Humanoid")

                if humanoidRootPart21 and humanoid26 then
                  local magnitude5 = (humanoidRootPart19.Position - humanoidRootPart21.Position).Magnitude

                  if f16(v104) then
                    colorBosses = Config.ColorBosses
                    highlightBosses = Config.HighlightBosses
                    boxBosses = Config.BoxBosses
                    showNameBosses = Config.ShowNameBosses
                    showHealthBosses = Config.ShowHealthBosses
                    showDistanceBosses = Config.ShowDistanceBosses
                  else
                    colorBosses = Config.ColorMobs
                    highlightBosses = Config.HighlightMobs
                    boxBosses = Config.BoxMobs
                    showNameBosses = Config.ShowNameMobs
                    showHealthBosses = Config.ShowHealthMobs
                    showDistanceBosses = Config.ShowDistanceMobs
                  end

                  if magnitude5 <= maxDistance and humanoid26.Health > 0 then
                    if highlightBosses then
                      f35(
                        v104, "SentinelMobHL", colorBosses, Config.HLFillTrans,
                        Config.HLOutlineTrans
                      )
                    else
                      f31(v104, "SentinelMobHL")
                    end

                    if boxBosses then
                      if not v97[v104] then
                        v97[v104] = f32(colorBosses, Config.BoxThickness)
                      end

                      f29(v97[v104], v104, colorBosses, Config.BoxThickness)
                    elseif v97[v104] then
                      f34(v97[v104])
                    end

                    f36(
                      v104, colorBosses, showNameBosses, showHealthBosses, showDistanceBosses,
                      magnitude5
                    )
                  else
                    if v97[v104] then
                      f34(v97[v104])
                    end

                    f31(v104, "SentinelMobHL")
                    f37(v104)
                  end
                end
              end
            else
              if v97[v104] then
                f30(v97[v104])
                v97[v104] = nil
              end

              f37(v104)

              if v96[v104] then
                v96[v104] = nil
              end

              table.remove(CachedMobs, v103)
            end
          end
        end)

        return
      end
    end
  end
end)

task.spawn(function()
  while SentinelActive do
    if Config.AntiAFKEnabled then
      pcall(function()
        virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Unknown, false, game)
        task.wait(1)
        virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Unknown, false, game)
      end)
    end

    task.wait(60)
  end
end)

animatorIdleTrack = nil
animatorWalkTrack = nil
animatorRunTrack = nil
animatorLastState = nil

function filterAnimNames(p99)
  local v105 = {}

  for key12, value41 in pairs(toggleAnims) do
    local lower = key12:lower()

    for index34, value42 in ipairs(p99) do
      if lower:sub(-#value42) == value42 then
        table.insert(v105, key12)
        break
      end
    end
  end

  return v105
end

local function f38()
  if AutoReloadToolConn then
    AutoReloadToolConn:Disconnect()
    AutoReloadToolConn = nil
  end

  AutoReloadWatching = false
end

idleAnimNames = filterAnimNames({ "idle", "idle (old)" })
walkAnimNames = filterAnimNames({ "walk", "walk (old)" })
runAnimNames = filterAnimNames({ "run", "run (old)" })

function stopAllAnimatorTracks()
  if animatorIdleTrack then
    animatorIdleTrack:Stop()
    animatorIdleTrack = nil
  end

  if animatorWalkTrack then
    animatorWalkTrack:Stop()
    animatorWalkTrack = nil
  end

  if animatorRunTrack then
    animatorRunTrack:Stop()
    animatorRunTrack = nil
  end
end
function applyAnimatorState()
  local v106

  if Config.FakeDeath then
    stopAllAnimatorTracks()
    return
  elseif not Config.AnimatorEnabled then
    stopAllAnimatorTracks()
    return
  else
    local character41 = localPlayer.Character

    if not character41 then
      return
    else
      local humanoid27 = character41:FindFirstChildOfClass("Humanoid")

      if not humanoid27 or humanoid27.Health <= 0 then
        return
      else
        local humanoidRootPart22 = character41:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart22 then
          return
        else
          local magnitude6 = Vector3.new(
            humanoidRootPart22.Velocity.X, 0, humanoidRootPart22.Velocity.Z
          ).Magnitude

          if isShiftHeld and magnitude6 > 2 then
            v106 = "run"
          elseif magnitude6 > 0.5 then
            v106 = "walk"
          else
            v106 = "idle"
          end

          if v106 ~= animatorLastState then
            animatorLastState = v106
            stopAllAnimatorTracks()

            if v106 == "idle" and Config.AnimatorIdleAnimName then
              animatorIdleTrack = playAnimationOnHumanoid(
                toggleAnims[Config.AnimatorIdleAnimName], true
              )
            elseif v106 == "walk" and Config.AnimatorWalkAnimName then
              animatorWalkTrack = playAnimationOnHumanoid(
                toggleAnims[Config.AnimatorWalkAnimName], true
              )
            elseif v106 == "run" and Config.AnimatorRunAnimName then
              animatorRunTrack = playAnimationOnHumanoid(
                toggleAnims[Config.AnimatorRunAnimName], true
              )
            end
          end

          return
        end
      end
    end
  end
end

local v107 = false

local function f39()
  local playerGui7 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui7 then
    return nil
  else
    local findFirstChild10 = playerGui7:FindFirstChild("MobileControls", true)

    if not findFirstChild10 then
      return nil
    end

    return findFirstChild10:FindFirstChild("Reload", true)
  end
end

local function f40()
  while v107 and SentinelActive do
    local backpack4 = localPlayer:FindFirstChild("Backpack")

    if backpack4 then
      for key13, value43 in pairs(backpack4:GetChildren()) do
        local v108 = value43

        if v108:IsA("Tool") and v108:GetAttribute("ClipCurrent") then
          if v108:GetAttribute("ClipCurrent") < 1e+24 then
            pcall(function()
              v108:SetAttribute("ClipSize", 1e+24)
              v108:SetAttribute("ClipCurrent", 1e+24)
              v108:SetAttribute("MaxAmmo", 1e+24)
            end)
          end
        end
      end
    end

    task.wait(0.1)
  end
end

local v109

function toggleNightStalkerInfAmmo(p100)
  Config.NightStalkerInfAmmo = p100

  if p100 then
    if not v107 then
      v107 = true

      if v109 then
        task.cancel(v109)
      end

      v109 = task.spawn(f40)
    end
  else
    v107 = false

    if v109 then
      task.cancel(v109)
      v109 = nil
    end
  end
end

AutoReloadWatching = false
AutoReloadToolConn = nil
local f41

local function f42(p101)
  local clipCurrent = p101:GetAttribute("ClipCurrent")
  local maxAmmo = p101:GetAttribute("MaxAmmo")
  local reloading = p101:GetAttribute("Reloading")

  if clipCurrent == 0 and (maxAmmo or 0) > 0 and not reloading and not AutoReloadWatching then
    AutoReloadWatching = true

    task.delay(1.5, function()
      f41()
      task.delay(0.5, function() AutoReloadWatching = false end)
    end)
  end
end

function f41()
  if keypress and keyrelease then
    pcall(function()
      keypress(82)
      task.delay(0.08, function() keyrelease(82) end)
    end)
  else
    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)

    task.delay(0.08, function()
      virtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
    end)
  end

  local v110 = f39()
  local activated

  if v110 then
    activated = v110.Activated

    if activated then
      pcall(function() activated:Fire() end)
    end
  end
end

local f43

local function f44(p102)
  f38()

  p102.ChildAdded:Connect(function(child9)
    if child9:IsA("Tool") then
      f43(child9)
    end
  end)

  p102.ChildRemoved:Connect(function(child10)
    if child10:IsA("Tool") then
      f38()
    end
  end)

  local tool5 = p102:FindFirstChildOfClass("Tool")

  if tool5 then
    f43(tool5)
  end
end

function f43(p103)
  f38()

  if not p103:GetAttribute("IsGun") then
    return
  end

  task.delay(1.5, function() f42(p103) end)

  AutoReloadToolConn = p103:GetAttributeChangedSignal("ClipCurrent"):Connect(function()
    f42(p103)
  end)
end

AutoReloadCharacterConn = nil

function toggleAutoReload(p104)
  Config.AutoReload = p104

  if p104 then
    if localPlayer.Character then
      f44(localPlayer.Character)
    end

    if AutoReloadCharacterConn then
      AutoReloadCharacterConn:Disconnect()
    end

    AutoReloadCharacterConn = localPlayer.CharacterAdded:Connect(f44)
  else
    f38()

    if AutoReloadCharacterConn then
      AutoReloadCharacterConn:Disconnect()
      AutoReloadCharacterConn = nil
    end
  end
end

local v111 = {
  ["+100%"] = { attr = "FelsiReloadSpeedMult", val = 1 },
  ["+200%"] = { attr = "SquadReloadSpeedMultiplier", val = 2 },
  ["+150%"] = { attr = "AdminstalSpeedMult", val = 1.5 },
}

local v112 = { "FelsiReloadSpeedMult", "SquadReloadSpeedMultiplier", "AdminstalSpeedMult" }

local function f45(p105)
  if not p105 then
    return
  end

  for index35, value44 in ipairs(v112) do
    p105:SetAttribute(value44, 1)
  end

  for index36, value45 in ipairs(Config.FastReloadBoosts) do
    local v113 = v111[value45]

    if v113 then
      p105:SetAttribute(v113.attr, v113.val)
    end
  end
end

local function f46(p106)
  if not p106 then
    return
  end

  for index37, value46 in ipairs(v112) do
    p106:SetAttribute(value46, 1)
  end
end

local connect2, v114

function toggleFastReload(p107)
  Config.FastReload = p107

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if v114 then
    task.cancel(v114)
    v114 = nil
  end

  if p107 then
    if localPlayer.Character then
      f45(localPlayer.Character)
    end

    connect2 = localPlayer.CharacterAdded:Connect(function(character42)
      character42:WaitForChild("Humanoid")
      task.wait(0.5)
      f45(character42)

      task.delay(2, function()
        if Config.FastReload and character42.Parent then
          f45(character42)
        end
      end)
    end)

    v114 = task.spawn(function()
      while Config.FastReload and SentinelActive do
        local character43 = localPlayer.Character

        if character43 then
          f45(character43)
        end

        task.wait(1)
      end
    end)
  elseif localPlayer.Character then
    f46(localPlayer.Character)
  end
end

local function f47(p108)
  local v115 = {}

  if type(p108) == "table" then
    for index38, value47 in ipairs(p108) do
      local title = value47

      if type(value47) == "table" then
        title = value47.Title or value47.Value
      end

      if v111[title] then
        table.insert(v115, title)
      end
    end
  elseif type(p108) == "string" and v111[p108] then
    v115 = { p108 }
  end

  Config.FastReloadBoosts = v115

  if Config.FastReload and localPlayer.Character then
    pcall(f45, localPlayer.Character)
  end
end

InstantShotgunConnection = nil
local v116 = { ["SRS-58"] = true, ["PMS-12T 'Hammer'"] = true }

local v117 = {
  ["rbxassetid://83290487541789"] = true,
  ["rbxassetid://116823220427411"] = true,
  ["rbxassetid://126710614165281"] = true,
  ["rbxassetid://115903749552317"] = true,
}

local function f48(p109)
  if InstantShotgunConnection then
    InstantShotgunConnection:Disconnect()
    InstantShotgunConnection = nil
  end

  if not p109 then
    return
  elseif not Config.InstantShotgunReload then
    return
  else
    InstantShotgunConnection = p109:WaitForChild("Humanoid"):WaitForChild("Animator").AnimationPlayed:Connect(function(p110)
      if not Config.InstantShotgunReload then
        return
      end

      if not (p110.Animation and v117[p110.Animation.AnimationId]) then
        return
      else
        local tool6 = p109:FindFirstChildOfClass("Tool")

        if not tool6 or not v116[tool6.Name] then
          return
        end

        pcall(function() p110:AdjustSpeed(100) end)

        task.delay(0.05, function()
          if p110.IsPlaying then
            pcall(function() p110:AdjustSpeed(100) end)
          end
        end)

        return
      end
    end)

    return
  end
end

function setupInstantShotgunReload(p111)
  if InstantShotgunConnection then
    InstantShotgunConnection:Disconnect()
    InstantShotgunConnection = nil
  end

  Config.InstantShotgunReload = p111

  if p111 then
    if localPlayer.Character then
      f48(localPlayer.Character)
    end
  end
end

localPlayer.CharacterAdded:Connect(function(character44)
  if Config.InstantShotgunReload then
    task.wait(1)
    f48(character44)
  end
end)

local v118 = { fovCircle = nil, hooked = false, originalNew = nil }
local v119 = cloneref or function(p112) return p112 end
local v120 = clonefunction or function(p113) return p113 end
local v121 = newcclosure or v120
local v122 = v119(players)
local v123 = v119(runService)
local v124 = v119(userInputService)
local v125 = v119(replicatedStorage)

if Capabilities.Drawing then
  v118.fovCircle = Drawing.new("Circle")
  v118.fovCircle.Thickness = 1.5
  v118.fovCircle.NumSides = 128
  v118.fovCircle.Filled = false
  v118.fovCircle.Transparency = 1
  v118.fovCircle.Radius = Config.SilentAimFOVRadius
  v118.fovCircle.Color = Config.SilentAimFOVNoTargetColor
  v118.fovCircle.Visible = false
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local f49

local function f50(p114, p115, p116)
  local character45 = v122.LocalPlayer.Character

  if not (character45 and p114) then
    return false, nil, nil
  else
    local v126 = { character45, workspace.CurrentCamera, workspace.Terrain }
    local characters6 = workspace:FindFirstChild("Characters")

    if characters6 then
      for index39, value48 in ipairs(characters6:GetChildren()) do
        if value48 ~= p116 then
          table.insert(v126, value48)
        end
      end
    end

    for index40, value49 in ipairs(f49()) do
      if value49 ~= p116 then
        table.insert(v126, value49)
      end
    end

    raycastParams.FilterDescendantsInstances = v126

    local position3 = p115
      or workspace.CurrentCamera and workspace.CurrentCamera.CFrame
        and workspace.CurrentCamera.CFrame.Position
      or Vector3.zero

    local raycast = workspace:Raycast(position3, p114.Position - position3, raycastParams)

    if not raycast then
      return true, p114, p114.Position
    else
      local parent6 = p116 or p114.Parent

      if parent6 and raycast.Instance:IsDescendantOf(parent6) then
        return true, p116 and p116:FindFirstChild("Right Arm")
            and p116["Right Arm"]:FindFirstChild("Shield") and p116:FindFirstChild("Head")
          or raycast.Instance, raycast.Position
      end

      return false, raycast.Instance, raycast.Position
    end
  end
end

local function f51(p117)
  return p117:FindFirstChild("HumanoidRootPart") or p117:FindFirstChild("Torso")
    or p117:FindFirstChild("UpperTorso") or p117:FindFirstChild("LowerTorso")
    or p117.PrimaryPart or p117:FindFirstChildWhichIsA("BasePart")
end

function f49()
  local v127 = {}

  for index41, value50 in ipairs(v122:GetPlayers()) do
    if value50.Character then
      table.insert(v127, value50.Character)
    end
  end

  return v127
end

local function f52(p118)
  local head3 = p118:FindFirstChild("Head")

  if head3 and head3:IsA("BasePart") then
    return head3
  else
    local collisions = p118:FindFirstChild("Collisions")

    if collisions then
      local headCollision = collisions:FindFirstChild("Head Collision")
        or collisions:FindFirstChild("Head")

      if headCollision and headCollision:IsA("BasePart") then
        return headCollision
      end

      for index42, value51 in ipairs(p118:GetChildren()) do
        if value51:IsA("BasePart") and value51.Name:lower():find("head") then
          return value51
        end
      end

      return nil
    end

    for index43, value52 in ipairs(p118:GetChildren()) do
      if value52:IsA("BasePart") and value52.Name:lower():find("head") then
        return value52
      end
    end

    return nil
  end
end

local f53

local function f54()
  local v128

  if v118.hooked then
    return
  elseif not Capabilities.SilentAim then
    return
  else
    local v129, v130 = pcall(require, v125.Assets.Modules.Raycast.ActiveCast)

    if v129 and v130 then
      v128 = nil

      v128 = v120(hookfunction(rawget(v130, "new"), v121(function(p119, p120, p121, p122, ...)
        local v131, v132 = f53(p120)

        if v131 and v132 and p120 then
          local v133 = v132 - p120

          if typeof(v133) == "Vector3" and v133.Magnitude > 0 then
            local magnitude7 = 1000

            if typeof(p122) == "Vector3" and p122.Magnitude > 0 then
              magnitude7 = p122.Magnitude
            end

            local v134 = v133.Unit
            return v128(p119, p120, v134, v134 * magnitude7, ...)
          end

          return v128(p119, p120, p121, p122, ...)
        end

        return v128(p119, p120, p121, p122, ...)
      end)))

      v118.hooked = true
      v118.originalNew = v128
    end

    return
  end
end

function f53(p123)
  if not Config.SilentAimEnabled then
    return nil, nil
  else
    local v135 = nil
    local v136 = nil
    local silentAimFOVRadius = Config.SilentAimFOVRadius or 150

    if type(silentAimFOVRadius) ~= "number" then
      silentAimFOVRadius = 150
    end

    local currentCamera4 = workspace.CurrentCamera
    local viewportSize = currentCamera4 and currentCamera4.ViewportSize

    local vector2 = viewportSize
    vector2 = viewportSize or Vector2.new(800, 600)

    local getMouseLocation = Config.SilentAimFOVMode == "Mouse" and v124:GetMouseLocation()

    local vector3 = getMouseLocation
    vector3 = getMouseLocation or Vector2.new((vector2.X or 800) / 2, (vector2.Y or 600) / 2)

    local characters7 = workspace:FindFirstChild("Characters")

    if not characters7 then
      return nil, nil
    end

    for index44, value53 in ipairs(characters7:GetChildren()) do
      local model = value53:IsA("Model")

      local humanoid28 = model
      humanoid28 = model and value53:FindFirstChildOfClass("Humanoid")

      if humanoid28 and humanoid28.Health > 0
        and not value53:FindFirstChildOfClass("ForceField")
        and (value53:FindFirstChild("AI") or not v122:GetPlayerFromCharacter(value53)) then
        local headCollision2 = nil

        if Config.SilentAimTargetPart == "Head" then
          headCollision2 = f52(value53)
        end

        if not headCollision2 then
          headCollision2 = f51(value53)
        end

        if not headCollision2 then
          local collisions2 = value53:FindFirstChild("Collisions")

          if collisions2 then
            headCollision2 = collisions2:FindFirstChild("Head Collision")
              or collisions2:FindFirstChild("Left Arm Collision")
              or collisions2:FindFirstChild("Right Arm Collision")
              or collisions2:FindFirstChildWhichIsA("BasePart")
          end
        end

        if headCollision2 then
          local position4 = headCollision2.Position
          local v137, v138 = currentCamera4:WorldToViewportPoint(position4)

          if v138 then
            local v139 = true

            if Config.SilentAimWallCheck then
              local v140, v141, v142 = f50(headCollision2, p123, value53)

              if not v140 then
                local v143 = f51(value53)

                if v143 then
                  v140, v141, v142 = f50(v143, p123, value53)
                end
              end

              if not v140 then
                v139 = false
              elseif v141 and v142 then
                headCollision2 = v141
                position4 = v142
              end
            end

            if v139 then
              local magnitude8 = (Vector2.new(v137.X, v137.Y) - vector3).Magnitude

              if magnitude8 < silentAimFOVRadius then
                v135 = headCollision2
                v136 = position4
                silentAimFOVRadius = magnitude8
              end
            end
          end
        end
      end
    end

    return v135, v136
  end
end

function SilentAim_Enable(p124)
  Config.SilentAimEnabled = p124

  if v118.fovCircle then
    v118.fovCircle.Radius = Config.SilentAimFOVRadius
    local fovCircle = v118.fovCircle
    fovCircle.Visible = p124 and Config.SilentAimShowFOV or false
  end

  if p124 then
    f54()
  end
end

function SilentAim_UpdateFOVVisual()
  if not v118.fovCircle then
    return
  else
    v118.fovCircle.Radius = Config.SilentAimFOVRadius

    local fovCircle2 = v118.fovCircle
    fovCircle2.Visible = Config.SilentAimEnabled and Config.SilentAimShowFOV

    return
  end
end

function SilentAim_Cleanup()
  Config.SilentAimEnabled = false
  Config.SilentAimShowFOV = false

  if v118.fovCircle then
    v118.fovCircle.Visible = false
  end
end

v123.RenderStepped:Connect(function()
  if not SentinelActive then
    return
  else
    local fovCircle3 = v118.fovCircle

    if not fovCircle3 then
      return
    end

    if Config.SilentAimShowFOV and Config.SilentAimEnabled then
      fovCircle3.Visible = true
      local currentCamera5 = workspace.CurrentCamera

      local viewportSize2 = currentCamera5 and currentCamera5.ViewportSize
        or Vector2.new(800, 600)

      fovCircle3.Position = Config.SilentAimFOVMode == "Mouse" and v124:GetMouseLocation() or Vector2.new(
        (viewportSize2.X or 800) / 2, (viewportSize2.Y or 600) / 2
      )

      local silentAimFOVRadius2 = Config.SilentAimFOVRadius

      if type(silentAimFOVRadius2) ~= "number" then
        silentAimFOVRadius2 = 150
      end

      fovCircle3.Radius = silentAimFOVRadius2

      if f53(currentCamera5 and currentCamera5.CFrame and currentCamera5.CFrame.Position
        or Vector3.zero) then
        fovCircle3.Color = Config.SilentAimFOVColor
      else
        fovCircle3.Color = Config.SilentAimFOVNoTargetColor
      end
    else
      fovCircle3.Visible = false
    end

    return
  end
end)

local function f55(p125)
  if not p125 then
    return false
  else
    local model2 = p125:FindFirstAncestorOfClass("Model")

    if not model2 then
      return false
    elseif model2 == localPlayer.Character then
      return false
    else
      local humanoid29 = model2:FindFirstChildWhichIsA("Humanoid")
      return humanoid29 ~= nil and humanoid29.Health > 0
    end
  end
end

local function f56()
  local character46 = localPlayer.Character

  if not character46 then
    return nil
  end

  for index45, value54 in ipairs(character46:GetChildren()) do
    if value54:IsA("Tool") then
      for index46, value55 in ipairs(value54:GetDescendants()) do
        if value55:IsA("Attachment") and value55.Name == "FirePoint" then
          return value55.WorldPosition
        end
      end
    end
  end

  return nil
end

BulletVisualizerState = { activeTrails = {} }

local function f57()
  for index47, value56 in ipairs(localPlayer.PlayerGui:GetChildren()) do
    local data = value56:FindFirstChild("Data")

    if data then
      local clip = data:FindFirstChild("clip")

      if clip and clip:IsA("TextLabel") then
        local v144 = tonumber(clip.Text)

        if v144 ~= nil then
          return v144 > 0
        end
      end
    end
  end

  return true
end

local f58

local function f59()
  if not Config.BulletVisualizerEnabled then
    return
  else
    local v145 = f57()
    local v146 = f56()

    if not v146 then
      return
    else
      local getMouse = localPlayer:GetMouse()

      if not getMouse then
        return
      else
        local screenPointToRay = currentCamera:ScreenPointToRay(getMouse.X, getMouse.Y)
        local character47 = localPlayer.Character

        local raycastParams2 = RaycastParams.new()
        raycastParams2.FilterDescendantsInstances = { character47 or {} }
        raycastParams2.FilterType = Enum.RaycastFilterType.Exclude

        local bulletVisualizerRange = Config.BulletVisualizerRange or 500

        if type(bulletVisualizerRange) ~= "number" then
          bulletVisualizerRange = 500
        end

        local raycast2 = workspace:Raycast(
          screenPointToRay.Origin, screenPointToRay.Direction * bulletVisualizerRange,
          raycastParams2
        )

        f58(v146, raycast2 and raycast2.Position
          or screenPointToRay.Origin + screenPointToRay.Direction * bulletVisualizerRange, raycast2 and raycast2.Instance or nil, not v145)

        return
      end
    end
  end
end

function f58(p126, p127, p128, p129)
  local magnitude9 = (p127 - p126).Magnitude
  local bulletVisualizerFadeOut, bulletTrail

  if magnitude9 < 0.1 then
    return
  else
    local v147 = (p126 + p127) / 2
    local v148 = (p127 - p126).Unit
    local bulletVisualizerThickness = Config.BulletVisualizerThickness or 0.09
    local bulletVisualizerLifetime = Config.BulletVisualizerLifetime or 3
    bulletVisualizerFadeOut = Config.BulletVisualizerFadeOut or 0.8

    if type(bulletVisualizerThickness) ~= "number" then
      bulletVisualizerThickness = 0.09
    end

    if type(bulletVisualizerLifetime) ~= "number" then
      bulletVisualizerLifetime = 3
    end

    if type(bulletVisualizerFadeOut) ~= "number" then
      bulletVisualizerFadeOut = 0.8
    end

    bulletTrail = Instance.new("Part")
    bulletTrail.Name = "BulletTrail"
    bulletTrail.Anchored = true
    bulletTrail.CanCollide = false
    bulletTrail.CanQuery = false
    bulletTrail.CanTouch = false
    bulletTrail.CastShadow = false

    bulletTrail.Size = Vector3.new(
      bulletVisualizerThickness, bulletVisualizerThickness, magnitude9
    )

    bulletTrail.CFrame = CFrame.new(v147, v147 + v148)
    bulletTrail.Material = Enum.Material.Neon
    bulletTrail.Parent = workspace

    if p129 then
      bulletTrail.Color = Config.BulletVisualizerColorLoading or Color3.fromRGB(255, 200, 0)
      bulletTrail.Transparency = 0.5
    else
      if f55(p128) then
        bulletTrail.Color = Config.BulletVisualizerColorSuccess or Color3.fromRGB(0, 255, 80)
      else
        bulletTrail.Color = Config.BulletVisualizerColorMissed or Color3.fromRGB(220, 30, 30)
      end

      bulletTrail.Transparency = 0.45
    end

    local v149 = math.max(bulletVisualizerLifetime - bulletVisualizerFadeOut, 0)

    task.delay(v149, function()
      if not bulletTrail or not bulletTrail.Parent then
        return
      end

      local total = 0
      local transparency = bulletTrail.Transparency

      local connect3 = nil

      connect3 = runService.Heartbeat:Connect(function(delta3)
        if not bulletTrail or not bulletTrail.Parent then
          if connect3 then
            connect3:Disconnect()
          end

          return
        else
          total = total + delta3
          local v150 = math.clamp(total / bulletVisualizerFadeOut, 0, 1)
          bulletTrail.Transparency = transparency + (1 - transparency) * v150

          if v150 >= 1 then
            connect3:Disconnect()
            bulletTrail:Destroy()
          end

          return
        end
      end)
    end)

    debris:AddItem(bulletTrail, bulletVisualizerLifetime + 0.5)
    table.insert(BulletVisualizerState.activeTrails, bulletTrail)
    return
  end
end

local clipCurrent2 = 0
local v151, connect4

local function f60(p130)
  if not p130 or not p130:IsA("Tool") then
    return
  elseif v151 == p130 then
    return
  else
    v151 = p130

    if connect4 then
      connect4:Disconnect()
    end

    clipCurrent2 = p130:GetAttribute("ClipCurrent") or 0

    connect4 = p130:GetAttributeChangedSignal("ClipCurrent"):Connect(function()
      local clipCurrent3 = p130:GetAttribute("ClipCurrent") or 0

      if Config.BulletVisualizerEnabled and clipCurrent3 < clipCurrent2 then
        f59()
      end

      clipCurrent2 = clipCurrent3
    end)

    return
  end
end

local connect5

function BulletVisualizer_Enable(p131)
  Config.BulletVisualizerEnabled = p131

  if p131 then
    if connect5 then
      connect5:Disconnect()
    end

    local character48 = localPlayer.Character

    if character48 then
      f60(character48:FindFirstChildOfClass("Tool"))

      connect5 = character48.ChildAdded:Connect(function(child11)
        if child11:IsA("Tool") then
          task.wait(0.1)
          f60(child11)
        end
      end)
    end
  else
    if connect4 then
      connect4:Disconnect()
      connect4 = nil
    end

    if connect5 then
      connect5:Disconnect()
      connect5 = nil
    end

    v151 = nil
  end
end

function BulletVisualizer_Cleanup()
  Config.BulletVisualizerEnabled = false

  for index48, value57 in ipairs(BulletVisualizerState.activeTrails) do
    local v152 = value57

    pcall(function()
      if v152 and v152.Parent then
        v152:Destroy()
      end
    end)
  end

  BulletVisualizerState.activeTrails = {}

  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end

  if connect5 then
    connect5:Disconnect()
    connect5 = nil
  end
end

localPlayer.CharacterAdded:Connect(function(character49)
  if not Config.BulletVisualizerEnabled then
    return
  else
    character49:WaitForChild("HumanoidRootPart", 10)
    task.wait(0.5)

    if connect5 then
      connect5:Disconnect()
      connect5 = nil
    end

    if connect4 then
      connect4:Disconnect()
      connect4 = nil
    end

    v151 = nil
    local character50 = localPlayer.Character

    if character50 then
      f60(character50:FindFirstChildOfClass("Tool"))

      connect5 = character50.ChildAdded:Connect(function(child12)
        if child12:IsA("Tool") then
          task.wait(0.1)
          f60(child12)
        end
      end)
    end

    return
  end
end)

local function f61(p132, p133)
  if not p132 or not p132:IsA("ClickDetector") then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Free Tools",
          Content = p133 .. " detector not found",
          Duration = 3,
        })
      end
    end)

    return
  end

  pcall(function() fireclickdetector(p132) end)

  pcall(function()
    if WindUI then
      WindUI:Notify({ Title = "Free Tools", Content = "Fired " .. p133, Duration = 2 })
    end
  end)
end

BypassState = { Movement = false }
MovementBypassHooks = {}

function applyMovementBypass(p134)
  BypassState.Movement = p134
  local humanoid30

  if p134 then
    if not Capabilities.Hooks then
      pcall(function()
        if WindUI then
          WindUI:Notify({
            Title = "Movement Bypass",
            Content = "Not supported by your executor.",
            Icon = "alert-triangle",
            Duration = 5,
          })
        end
      end)

      return
    end

    local character51 = localPlayer.Character

    if character51 then
      humanoid30 = character51:FindFirstChildOfClass("Humanoid")

      if humanoid30 then
        pcall(function()
          local v153 = getrawmetatable(humanoid30)
          local v154 = v153 and not MovementBypassHooks.Humanoid
          local newindex

          if v154 then
            newindex = v153.__newindex
            setreadonly(v153, false)

            v153.__newindex = newcclosure(function(p135, p136, p137)
              local v155 = p137

              if p136 == "WalkSpeed" or p136 == "JumpPower" then
                if typeof(v155) == "number" then
                  if p136 == "WalkSpeed" and v155 > 100 then
                    v155 = 100
                  end

                  if p136 == "JumpPower" and v155 > 200 then
                    v155 = 200
                  end
                end
              end

              return newindex(p135, p136, v155)
            end)

            setreadonly(v153, true)
            MovementBypassHooks.Humanoid = true
          end
        end)
      end
    end

    return
  end
end

function applyAllBypasses()
  if not Config.NetworkBypassEnabled then
    applyMovementBypass(false)
    return
  else
    local v156 = {}

    for index49, value58 in ipairs(Config.ActiveBypasses) do
      v156[value58] = true
    end

    applyMovementBypass(v156["Movement Bypass"] == true)
    return
  end
end

function collectAllDocuments()
  task.spawn(function()
    local character52 = localPlayer.Character
    local currentCamera6, v157

    if not character52 then
      return
    else
      local humanoidRootPart23 = character52:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart23 then
        return
      else
        local documents = workspace:FindFirstChild("Documents")

        if not documents then
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Documents",
                Content = "Dossier 'Documents' introuvable.",
                Duration = 3,
              })
            end
          end)

          return
        else
          currentCamera6 = workspace.CurrentCamera
          local getChildren2 = documents.GetChildren
          v157 = {}

          for index50, value59 in ipairs(getChildren2(documents)) do
            local findFirstChildWhichIsA2 = value59:FindFirstChildWhichIsA(
              "ProximityPrompt", true
            )

            if findFirstChildWhichIsA2 then
              local parent7 = nil

              if findFirstChildWhichIsA2.Parent:IsA("Attachment") then
                parent7 = findFirstChildWhichIsA2.Parent.Parent
              elseif findFirstChildWhichIsA2.Parent:IsA("BasePart") then
                parent7 = findFirstChildWhichIsA2.Parent
              end

              if parent7 then
                table.insert(v157, {
                  pp = findFirstChildWhichIsA2,
                  part = parent7,
                  name = value59.Name,
                })
              end
            end
          end

          if #v157 == 0 then
            pcall(function()
              if WindUI then
                WindUI:Notify({
                  Title = "Documents",
                  Content = "Aucun document trouvé.",
                  Duration = 3,
                })
              end
            end)

            return
          else
            pcall(function()
              if WindUI then
                WindUI:Notify({
                  Title = "Documents",
                  Content = #v157 .. " document(s) trouvé(s), collecte en cours...",
                  Duration = 3,
                })
              end
            end)

            for index51, value60 in ipairs(v157) do
              value60.pp.HoldDuration = 0
              value60.pp.MaxActivationDistance = 9999
              value60.pp.Enabled = true
            end

            local cframe8 = humanoidRootPart23.CFrame
            local cameraType = currentCamera6.CameraType
            currentCamera6.CameraType = Enum.CameraType.Scriptable

            local function f62(p138, p139)
              currentCamera6.CFrame = CFrame.new(p138, p138 + (p139 - p138).Unit)
            end

            for index52, value61 in ipairs(v157) do
              local v158 = index52
              local v159 = value61

              if not v159.pp or not v159.pp.Parent then
              else
                local position5 = v159.part.Position
                local vector4 = Vector3.new(0, 0, 3)
                humanoidRootPart23.CFrame = CFrame.new(position5 + vector4, position5)
                task.wait(0.05)
                f62(humanoidRootPart23.CFrame.Position + Vector3.new(0, 1.5, 0), position5)
                task.wait(0.1)
                pcall(function() fireproximityprompt(v159.pp) end)
                task.wait(0.35)

                pcall(function()
                  if WindUI then
                    WindUI:Notify({
                      Title = "Doc [" .. v158 .. "/" .. #v157 .. "]",
                      Content = "Picked Up : " .. v159.name,
                      Duration = 1,
                    })
                  end
                end)
              end
            end

            currentCamera6.CameraType = cameraType
            humanoidRootPart23.CFrame = cframe8

            pcall(function()
              if WindUI then
                WindUI:Notify({
                  Title = "Documents",
                  Content = "All Documents have been Picked Up.",
                  Duration = 4,
                })
              end
            end)

            return
          end
        end
      end
    end
  end)
end

function completeManhattanQuests()
  local userId = localPlayer.UserId
  local v160 = false
  local v161 = false

  local v162, v163 = pcall(function()
    return badgeService:UserHasBadgeAsync(userId, 2147991835)
  end)

  if v162 and v163 then
    v160 = true
  end

  local v164, v165 = pcall(function()
    return badgeService:UserHasBadgeAsync(userId, 282806616820550)
  end)

  if v164 and v165 then
    v161 = true
  end

  if v161 then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Manhattan Quest",
          Content = "You already finished the manhattan quest.",
          Duration = 4,
        })
      end
    end)

    return
  end

  if not v160 then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Manhattan Quest",
          Content = 'You need to have the ["THE_POINTMAN"] badge.',
          Duration = 5,
        })
      end
    end)

    return
  end

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Manhattan Quest",
        Content = "Go talk to manhattan and ask her for work.",
        Duration = 4,
      })
    end
  end)

  task.spawn(function()
    local currentCamera7 = workspace.CurrentCamera
    local manhattanRadiationQuest = workspace:FindFirstChild("ManhattanRadiationQuest")

    if not manhattanRadiationQuest then
      pcall(function()
        if WindUI then
          WindUI:Notify({
            Title = "Error",
            Content = "ManhattanRadiationQuest not found",
            Duration = 3,
          })
        end
      end)

      return
    else
      local activeItems = manhattanRadiationQuest:FindFirstChild("ActiveItems")

      if not activeItems then
        pcall(function()
          if WindUI then
            WindUI:Notify({ Title = "Error", Content = "ActiveItems not found", Duration = 3 })
          end
        end)

        return
      else
        local character53 = localPlayer.Character

        if not character53 then
          return
        else
          local humanoidRootPart24 = character53:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart24 then
            return
          else
            local cframe9 = humanoidRootPart24.CFrame
            local getChildren3 = activeItems:GetChildren()

            if #getChildren3 == 0 then
              pcall(function()
                if WindUI then
                  WindUI:Notify({
                    Title = "Info",
                    Content = "No active items found",
                    Duration = 3,
                  })
                end
              end)

              return
            end

            for index53, value62 in ipairs(getChildren3) do
              if value62:IsA("BasePart") or value62:IsA("Model") then
                local position6 = value62:GetPivot().Position
                humanoidRootPart24.CFrame = CFrame.new(position6 + Vector3.new(0, 2, 0))
                task.wait(0.3)
                currentCamera7.CFrame = CFrame.new(currentCamera7.CFrame.Position, position6)

                humanoidRootPart24.CFrame = CFrame.new(humanoidRootPart24.Position, Vector3.new(
                  position6.X, humanoidRootPart24.Position.Y, position6.Z
                ))

                task.wait(0.2)
                virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                task.wait(3)
                virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait(1)
              end
            end

            humanoidRootPart24.CFrame = cframe9
            return
          end
        end
      end
    end
  end)
end

function getUnderequippedBadge()
  local character54 = localPlayer.Character
  local cframe10, vector5, vector6, walkSpeed, connect6

  if not character54 then
    return
  else
    local humanoidRootPart25 = character54:FindFirstChild("HumanoidRootPart")
    local v166 = not humanoidRootPart25
    local humanoid31 = character54:FindFirstChildOfClass("Humanoid")

    if v166 or not humanoid31 then
      return
    end

    cframe10 = humanoidRootPart25.CFrame
    vector5 = Vector3.new(241, -31, -1172)
    vector6 = Vector3.new(267, -31, -1172)
    walkSpeed = humanoid31.WalkSpeed
    humanoidRootPart25.CFrame = CFrame.lookAt(vector5, vector6)
    humanoid31.WalkSpeed = 9
    task.wait(0.1)

    connect6 = nil

    connect6 = runService.Heartbeat:Connect(function()
      if not SentinelActive then
        if connect6 then
          connect6:Disconnect()
        end

        return
      else
        local character55 = localPlayer.Character

        if not character55 then
          if connect6 then
            connect6:Disconnect()
          end

          return
        else
          local humanoidRootPart26 = character55:FindFirstChild("HumanoidRootPart")
          local v167 = not humanoidRootPart26
          local humanoid32 = character55:FindFirstChildOfClass("Humanoid")

          if v167 or not humanoid32 then
            if connect6 then
              connect6:Disconnect()
            end

            return
          else
            local position7 = humanoidRootPart26.Position

            if (Vector3.new(vector6.X, position7.Y, vector6.Z) - position7).Magnitude <= 1 then
              humanoid32.WalkSpeed = walkSpeed
              connect6:Disconnect()
              task.wait(0.5)
              local character56 = localPlayer.Character

              if character56 and character56:FindFirstChild("HumanoidRootPart") then
                character56:PivotTo(cframe10)
              end

              return
            else
              local v168 = (vector6 - position7) * Vector3.new(1, 0, 1)

              if v168.Magnitude > 0 then
                local v169 = v168.Unit * 0.15

                humanoidRootPart26.CFrame = CFrame.lookAt(position7 + v169, position7 + v169
                  + (vector6 - vector5).Unit)
              end

              return
            end
          end
        end
      end
    end)

    return
  end
end

function CleanupAllFeatures()
  if Config.FlyEnabled then
    Config.FlyEnabled = false
    pcall(function() enableFly(false) end)
  end

  if Config.NoclipEnabled then
    Config.NoclipEnabled = false

    if noclipConnection then
      pcall(function() task.cancel(noclipConnection) end)
      noclipConnection = nil
    end

    local character57 = localPlayer.Character

    if character57 then
      for key14, value63 in pairs(character57:GetDescendants()) do
        if value63:IsA("BasePart") then
          value63.CanCollide = true
        end
      end
    end
  end

  Config.SpeedHackEnabled = false

  if Config.InfiniteStaminaEnabled then
    pcall(function() toggleInfiniteStamina(false) end)
  end

  Config.InfiniteStaminaEnabled = false
  Config.JumpPowerEnabled = false
  Config.InfiniteJump = false
  Config.JumpBypassActive = false

  local character58 = localPlayer.Character
  local humanoid33 = character58 and character58:FindFirstChildOfClass("Humanoid")

  if humanoid33 then
    humanoid33.WalkSpeed = 9
    humanoid33.JumpPower = 50
  end

  if Config.FakeDeath then
    Config.FakeDeath = false
  end

  if Config.FakeInjured then
    Config.FakeInjured = false
  end

  for index54, value64 in ipairs({
    "HighlightPlayer", "HighlightMobs", "HighlightBosses", "BoxPlayers", "BoxMobs", "BoxBosses",
    "ShowNamePlayers", "ShowNameMobs", "ShowNameBosses", "ShowHealthPlayers", "ShowHealthMobs",
    "ShowHealthBosses", "ShowDistancePlayers", "ShowDistanceMobs", "ShowDistanceBosses",
  }) do
    Config[value64] = false
  end

  pcall(function()
    for key15, value65 in pairs(players:GetPlayers()) do
      if value65 ~= localPlayer and value65.Character then
        local sentinelHL = value65.Character:FindFirstChild("SentinelHL")

        if sentinelHL then
          sentinelHL:Destroy()
        end
      end
    end

    for index55, value66 in ipairs(workspace:GetDescendants()) do
      local sentinelMobHL = value66:FindFirstChild("SentinelMobHL")

      if sentinelMobHL then
        sentinelMobHL:Destroy()
      end

      local sentinelInfoBBG3 = value66:FindFirstChild("SentinelInfoBBG")

      if sentinelInfoBBG3 then
        sentinelInfoBBG3:Destroy()
      end
    end
  end)

  v96 = {}

  if XrayEnabled then
    XrayEnabled = false
  end

  Config.FullBright = false
  Config.NoFog = false

  pcall(function()
    lighting.Ambient = OrigAmbient
    lighting.OutdoorAmbient = OrigOutdoorAmbient
    lighting.Brightness = OrigBrightness
    lighting.FogEnd = OrigFogEnd
    lighting.FogStart = OrigFogStart
    lighting.GlobalShadows = OrigGlobalShadows
  end)

  Config.CustomFOVEnabled = false

  pcall(function()
    if currentCamera then
      currentCamera.FieldOfView = OrigFOV
    end
  end)

  Config.UnlockThirdPerson = false

  pcall(function()
    localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    localPlayer.CameraMaxZoomDistance = 50
  end)

  Config.AnimatorEnabled = false
  animatorLastState = nil

  if activeAnimTrack then
    pcall(function() activeAnimTrack:Stop() end)
    activeAnimTrack = nil
  end

  if HitboxEnabled then
    HitboxEnabled = false
  end

  Config.AntiAnchorEnabled = false
  Config.StaggerEnabled = true
  Config.StaggerImmune = false

  if character58 then
    local clientScripts4 = character58:FindFirstChild("ClientScripts")

    local stagger4 = clientScripts4
    stagger4 = clientScripts4 and clientScripts4:FindFirstChild("Stagger")

    if stagger4 then
      stagger4.Disabled = false
    end

    pcall(function() character58:SetAttribute("StaggerImmune", false) end)
  end

  Config.SilencerEnabled = false
  pcall(function() updateSilencers(false) end)

  if Config.AutoReload then
    Config.AutoReload = false
    pcall(function() toggleAutoReload(false) end)
  end

  if Config.FastReload then
    Config.FastReload = false
    pcall(function() toggleFastReload(false) end)
  end

  if Config.NightStalkerInfAmmo then
    pcall(function() toggleNightStalkerInfAmmo(false) end)
  end

  if Config.AutoQTEEnabled then
    Config.AutoQTEEnabled = false
    pcall(function() f24(false) end)
  end

  Config.AntiAFKEnabled = false
  Config.InstantProximityPrompt = false

  if InstantProximityConnection then
    pcall(function() InstantProximityConnection:Disconnect() end)
    InstantProximityConnection = nil
  end

  Config.AutoCompleteProximityPrompt = false

  if AutoCompletePromptConnection then
    pcall(function() AutoCompletePromptConnection:Disconnect() end)
    AutoCompletePromptConnection = nil
  end

  AutoShieldRemovalActive = false

  if AutoShieldRemovalConnection then
    pcall(function() AutoShieldRemovalConnection:Disconnect() end)
    AutoShieldRemovalConnection = nil
  end

  AutoRemoveAxeActive = false

  if AutoRemoveAxeConnection then
    pcall(function() AutoRemoveAxeConnection:Disconnect() end)
    AutoRemoveAxeConnection = nil
  end

  Config.AutoWipeBlood = false
  Config.AntiCamShake = false
  Config.ImmuneLookHazard = false

  if Config.InfiniteNightVision then
    Config.InfiniteNightVision = false

    if NVForcerConnection then
      pcall(function() NVForcerConnection:Disconnect() end)
      NVForcerConnection = nil
    end

    local nvgEffect = lighting:FindFirstChild("__NVG_Effect")

    if nvgEffect then
      nvgEffect:Destroy()
    end

    local nvgBloom = lighting:FindFirstChild("__NVG_Bloom")

    if nvgBloom then
      nvgBloom:Destroy()
    end

    pcall(f20)
  end

  Config.RemoveDeathScreen = false

  if removeDeathConnection then
    pcall(function() removeDeathConnection:Disconnect() end)
    removeDeathConnection = nil
  end

  if InstantShotgunConnection then
    pcall(function() InstantShotgunConnection:Disconnect() end)
    InstantShotgunConnection = nil
  end

  Config.FlySpeed = 25
  Config.MaxDistance = 1000
  Config.HLFillTrans = 0.7
  Config.HLOutlineTrans = 1
  Config.XrayDistance = 30
  Config.XrayTransparency = 0.3
  Config.AutoBringAxe = false
  Config.AutoBringHammer = false

  AutoBringAxeActive = false
  AutoBringHammerActive = false
  AutoBringAxeRunning = false
  AutoBringHammerRunning = false

  if AutoBringAxeConn then
    pcall(function() AutoBringAxeConn:Disconnect() end)
    AutoBringAxeConn = nil
  end

  if AutoBringHammerConn then
    pcall(function() AutoBringHammerConn:Disconnect() end)
    AutoBringHammerConn = nil
  end

  Config.AntiRiserDodgeEnabled = false

  for index56, value67 in ipairs(AntiRiserDodgeConnections) do
    local v170 = value67
    pcall(function() v170:Disconnect() end)
  end

  AntiRiserDodgeConnections = {}
  AntiRiserDodgeHooked = {}
  AntiRiserAddedConn = nil

  if Config.ViewModelEnabled then
    Config.ViewModelEnabled = false
  end

  if Config.CustomWeaponsEnabled then
    Config.CustomWeaponsEnabled = false
  end

  RadawayState.active = false

  if RadawayState.connection then
    pcall(function() RadawayState.connection:Disconnect() end)
    RadawayState.connection = nil
  end
end

function FullScriptCleanup()
  SentinelActive = false
  pcall(f20)

  if NVForcerConnection then
    pcall(function() NVForcerConnection:Disconnect() end)
  end

  if connect then
    pcall(function() connect:Disconnect() end)
  end

  if AutoReloadToolConn then
    pcall(function() AutoReloadToolConn:Disconnect() end)
  end

  if AutoReloadCharacterConn then
    pcall(function() AutoReloadCharacterConn:Disconnect() end)
  end

  if connect2 then
    pcall(function() connect2:Disconnect() end)
  end

  if v114 then
    pcall(function() task.cancel(v114) end)
    v114 = nil
  end

  if AutoShieldRemovalConnection then
    pcall(function() AutoShieldRemovalConnection:Disconnect() end)
  end

  if AutoRemoveAxeConnection then
    pcall(function() AutoRemoveAxeConnection:Disconnect() end)
  end

  if InstantProximityConnection then
    pcall(function() InstantProximityConnection:Disconnect() end)
  end

  if AutoCompletePromptConnection then
    pcall(function() AutoCompletePromptConnection:Disconnect() end)
  end

  if HeadAccessoryConnection then
    pcall(function() HeadAccessoryConnection:Disconnect() end)
  end

  if CharacterAccessoryConnection then
    pcall(function() CharacterAccessoryConnection:Disconnect() end)
  end

  if XrayLoop then
    pcall(function() XrayLoop:Disconnect() end)
  end

  if v109 then
    pcall(function() task.cancel(v109) end)
  end

  if noclipConnection then
    pcall(function() task.cancel(noclipConnection) end)
  end

  if InfiniteStaminaThread then
    pcall(function() task.cancel(InfiniteStaminaThread) end)
    InfiniteStaminaThread = nil
  end

  if InstantShotgunConnection then
    pcall(function() InstantShotgunConnection:Disconnect() end)
  end

  if connect4 then
    pcall(function() connect4:Disconnect() end)
  end

  if connect5 then
    pcall(function() connect5:Disconnect() end)
  end

  if AutoBringAxeConn then
    pcall(function() AutoBringAxeConn:Disconnect() end)
  end

  if AutoBringHammerConn then
    pcall(function() AutoBringHammerConn:Disconnect() end)
  end

  for index57, value68 in ipairs(AntiRiserDodgeConnections) do
    local v171 = value68
    pcall(function() v171:Disconnect() end)
  end

  AntiRiserDodgeConnections = {}

  if vmFolderConnection then
    pcall(function() vmFolderConnection:Disconnect() end)
  end

  if vmIgnoreConn then
    pcall(function() vmIgnoreConn:Disconnect() end)
  end

  function v9773()
    for key16, value69 in pairs(v97) do
    end

    table.clear(v97)
  end

  function v9731()
    lighting.Ambient = OrigAmbient
    lighting.OutdoorAmbient = OrigOutdoorAmbient
    lighting.Brightness = OrigBrightness
    lighting.FogEnd = OrigFogEnd
    lighting.FogStart = OrigFogStart
    lighting.GlobalShadows = OrigGlobalShadows
  end

  pcall(function()
    for key17, value70 in pairs(players:GetPlayers()) do
      if value70.Character then
        local sentinelHL2 = value70.Character:FindFirstChild("SentinelHL")

        if sentinelHL2 then
          sentinelHL2:Destroy()
        end
      end
    end

    for index58, value71 in ipairs(workspace:GetDescendants()) do
      local sentinelMobHL2 = value71:FindFirstChild("SentinelMobHL")

      if sentinelMobHL2 then
        sentinelMobHL2:Destroy()
      end

      local sentinelInfoBBG4 = value71:FindFirstChild("SentinelInfoBBG")

      if sentinelInfoBBG4 then
        sentinelInfoBBG4:Destroy()
      end
    end
  end)

  v96 = {}

  pcall(function()
    local infectionRedTint4 = lighting:FindFirstChild("InfectionRedTint")

    if infectionRedTint4 then
      infectionRedTint4:Destroy()
    end

    local nvgEffect2 = lighting:FindFirstChild("__NVG_Effect")

    if nvgEffect2 then
      nvgEffect2:Destroy()
    end

    local nvgBloom2 = lighting:FindFirstChild("__NVG_Bloom")

    if nvgBloom2 then
      nvgBloom2:Destroy()
    end
  end)

  pcall(function()
    if mainWindow then
      mainWindow:Destroy()
    end
  end)

  pcall(function()
    if v118 and v118.fovCircle then
      v118.fovCircle:Remove()
    end
  end)
end

WindUI = nil

loadSuccess = pcall(function()
  WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not loadSuccess or not WindUI then
  starterGui:SetCore("SendNotification", {
    Title = "WindUI Error",
    Text = "Failed to load WindUI.",
    Duration = 15,
  })

  return
end

local f63, f64, notify, sentinelExaminationWindow, sentinelStatusParagraph, v172, f65, f66,
  connect7, f67

if not WindUI.Creator or not WindUI.CreateWindow or not WindUI.SetTheme or not WindUI.Notify then
  starterGui:SetCore("SendNotification", {
    Title = "WindUI Error",
    Text = "WindUI missing methods.",
    Duration = 15,
  })

  return
else
  notify = WindUI.Notify

  function WindUI.Notify(...)
    return (notify(...))
  end

  pcall(function() WindUI.Creator.AddThemes({ "Light", "Dark", "Rose" }) end)

  WindUI.Services["SentinelKey-Examination"] = {
    Name = "Sentinel Key System",
    Icon = "key-round",
    Args = { "Link", "ButtonName", "ButtonDesc" },
    New = function(p140, p141, p142)
      return {
        Name = p141 or "Copy",
        Desc = p142 or "Click to copy.",
        Verify = function(p143)
          if not p143 or p143 == "" then
            return false, "Please enter a key."
          end

          if tostring(p143) == "Sentinel.Examination.Uv29b" then
            return true, "Key valid! Welcome to Sentinel."
          end

          return false, "Invalid key. Check your key and try again."
        end,
        Copy = function()
          if setclipboard then
            pcall(setclipboard, p140)
          end

          return p140
        end,
      }
    end,
  }

  sentinelExaminationWindow = nil
  sentinelStatusParagraph = nil

  function ApplyInfiniteNightVision(p144)
    Config.InfiniteNightVision = p144
    local nvgEffect3, nvgBloom3

    if p144 then
      nvgEffect3 = lighting:FindFirstChild("__NVG_Effect")

      if not nvgEffect3 then
        nvgEffect3 = Instance.new("ColorCorrectionEffect")
        nvgEffect3.Name = "__NVG_Effect"
        nvgEffect3.Brightness = 0.2
        nvgEffect3.Contrast = 0.1
        nvgEffect3.Saturation = -0.2
        nvgEffect3.TintColor = Color3.fromRGB(255, 255, 255)
        nvgEffect3.Parent = lighting
      end

      nvgBloom3 = lighting:FindFirstChild("__NVG_Bloom")

      if not nvgBloom3 then
        nvgBloom3 = Instance.new("BloomEffect")
        nvgBloom3.Name = "__NVG_Bloom"
        nvgBloom3.Intensity = 2
        nvgBloom3.Size = 32
        nvgBloom3.Threshold = 0.4
        nvgBloom3.Parent = lighting
      end

      lighting.GlobalShadows = false
      lighting.FogEnd = 999999999
      lighting.FogStart = 999999999
      lighting.Ambient = Color3.fromRGB(67, 67, 67)
      lighting.OutdoorAmbient = Color3.fromRGB(67, 67, 67)

      nvgEffect3.Enabled = true
      nvgBloom3.Enabled = true
      f19()
      f18()

      if NVForcerConnection then
        NVForcerConnection:Disconnect()
      end

      NVForcerConnection = runService.RenderStepped:Connect(function()
        if not SentinelActive then
          return
        elseif not Config.InfiniteNightVision then
          return
        else
          if nvgEffect3 and nvgEffect3.Parent and not nvgEffect3.Enabled then
            nvgEffect3.Enabled = true
          end

          if nvgBloom3 and nvgBloom3.Parent and not nvgBloom3.Enabled then
            nvgBloom3.Enabled = true
          end

          if lighting.GlobalShadows then
            lighting.GlobalShadows = false
          end

          if lighting.FogEnd ~= 999999999 then
            lighting.FogEnd = 999999999
            lighting.FogStart = 999999999
          end

          return
        end
      end)
    else
      if NVForcerConnection then
        NVForcerConnection:Disconnect()
        NVForcerConnection = nil
      end

      local nvgEffect4 = lighting:FindFirstChild("__NVG_Effect")

      if nvgEffect4 then
        nvgEffect4:Destroy()
      end

      local nvgBloom4 = lighting:FindFirstChild("__NVG_Bloom")

      if nvgBloom4 then
        nvgBloom4:Destroy()
      end

      lighting.FogEnd = OrigFogEnd
      lighting.FogStart = OrigFogStart
      lighting.Ambient = OrigAmbient
      lighting.OutdoorAmbient = OrigOutdoorAmbient
      lighting.GlobalShadows = OrigGlobalShadows

      f20()
    end
  end

  function BuildUI()
    local locked = not Capabilities.Drawing
    local locked2 = not Capabilities.Hooks
    local locked3 = not Capabilities.SilentAim
    local locked4 = not Capabilities.FireProximityPrompt
    local locked5 = not Capabilities.FireClickDetector

    local tab = sentinelExaminationWindow:Tab({
      Title = "AntiCheat & Bypass",
      Icon = "shield-alert",
    })

    sentinelExaminationWindow:Divider()
    local mainTab = sentinelExaminationWindow:Tab({ Title = "Main", Icon = "house" })
    local playerTab = sentinelExaminationWindow:Tab({ Title = "Player", Icon = "user" })
    sentinelExaminationWindow:Divider()
    local combatTab = sentinelExaminationWindow:Tab({ Title = "Combat", Icon = "swords" })
    local gunModsTab = sentinelExaminationWindow:Tab({ Title = "Gun Mods", Icon = "crosshair" })
    local infectedTab = sentinelExaminationWindow:Tab({ Title = "Infected", Icon = "brain" })
    sentinelExaminationWindow:Divider()
    local espTab = sentinelExaminationWindow:Tab({ Title = "ESP", Icon = "eye" })
    local visualsTab = sentinelExaminationWindow:Tab({ Title = "Visuals", Icon = "sun" })
    local worldTab = sentinelExaminationWindow:Tab({ Title = "World", Icon = "earth" })
    sentinelExaminationWindow:Divider()

    local animationsTab = sentinelExaminationWindow:Tab({
      Title = "Animations",
      Icon = "clapperboard",
    })

    local questsTab = sentinelExaminationWindow:Tab({ Title = "Quests", Icon = "scroll" })
    local utilitiesTab = sentinelExaminationWindow:Tab({ Title = "Utilities", Icon = "wrench" })
    sentinelExaminationWindow:Divider()

    Tabs = {
      AntiCheat = tab,
      Main = mainTab,
      Player = playerTab,
      Combat = combatTab,
      GunMods = gunModsTab,
      Infected = infectedTab,
      ESP = espTab,
      Visuals = visualsTab,
      World = worldTab,
      Animations = animationsTab,
      Quests = questsTab,
      Utilities = utilitiesTab,
      Settings = sentinelExaminationWindow:Tab({ Title = "Settings", Icon = "settings" }),
    }

    local antiCheat = Tabs.AntiCheat

    antiCheat:Section({ Title = "Warning", Opened = true, Icon = "triangle-alert" }):Paragraph({
      Title = "Read before using!",
      Desc = "Using third-party scripts in this game violates the Terms of Service and carries severe risks.\n\nPotential consequences include:\n• Permanent account termination\n• Hardware ID (HWID) bans\n• Account flagging by the anti-cheat system\n• Loss of all progress, items, and purchases\n\nSentinel is provided for educational purposes only. We are not responsible for any bans, account loss, or other damages resulting from its use.\n\nBy proceeding, you acknowledge that you use this software entirely at your own risk. It is strongly recommended to test on an alternate account.",
      Image = "message-circle-warning",
      ImageSize = 24,
    })

    local compatibilitySection = antiCheat:Section({
      Title = "Compatibility",
      Opened = true,
      Icon = "cpu",
    })

    compatibilitySection:Paragraph({
      Title = "Executor",
      Desc = SentinelExecutorName,
      Image = "terminal",
      ImageSize = 20,
    })

    compatibilitySection:Paragraph({
      Title = "Device",
      Desc = SentinelDeviceType,
      Image = "smartphone",
      ImageSize = 20,
    })

    compatibilitySection:Paragraph({
      Title = "Hook Support",
      Desc = SentinelHookSupported and "Supported (Silent Aim OK)"
        or "NOT supported (Silent Aim may fail)",
      Image = SentinelHookSupported and "check" or "x",
      ImageSize = 20,
    })

    compatibilitySection:Paragraph({
      Title = "Account",
      Desc = SentinelUserName .. " | Age: " .. SentinelAccountAge,
      Image = "user",
      ImageSize = 20,
    })

    local networkBypassSection = antiCheat:Section({
      Title = "Network Bypass",
      Opened = true,
      Icon = "shield",
    })

    networkBypassSection:Toggle({
      Title = "Apply Network Bypass",
      Desc = "Enable this to make the selected features undetected. Does NOT activate them.",
      Default = false,
      Flag = "NetworkBypassEnabled",
      Callback = function(value72)
        Config.NetworkBypassEnabled = value72
        applyAllBypasses()
      end,
    })

    networkBypassSection:Divider()

    networkBypassSection:Dropdown({
      Title = "Bypass",
      Desc = "Select which features should be made undetected when used.",
      Values = { "Movement Bypass" },
      Multi = true,
      Value = {},
      Flag = "ActiveBypasses",
      Callback = function(value73)
        if type(value73) == "table" then
          Config.ActiveBypasses = value73
        else
          Config.ActiveBypasses = {}
        end

        if Config.NetworkBypassEnabled then
          applyAllBypasses()
        end
      end,
    })

    local main = Tabs.Main

    local characterHealthSection = main:Section({
      Title = "Character Health",
      Opened = true,
      Icon = "heart",
    })

    local suicideButton

    suicideButton = characterHealthSection:Button({
      Title = "Suicide",
      Callback = function()
        suicideButton:Highlight()
        local character59 = localPlayer.Character
        local humanoid34 = character59 and character59:FindFirstChildOfClass("Humanoid")

        if humanoid34 then
          humanoid34.Health = 0
        end
      end,
    })

    local button

    button = characterHealthSection:Button({
      Title = "Suicide with Animation",
      Callback = function()
        button:Highlight()
        suicideWithAnimation()
      end,
    })

    characterHealthSection:Divider()

    characterHealthSection:Toggle({
      Title = "Fake Death",
      Default = false,
      Flag = "FakeDeath",
      Callback = function(value74)
        Config.FakeDeath = value74
        toggleFakeDeath()
      end,
    })

    characterHealthSection:Toggle({
      Title = "Fake Injured (idle)",
      Default = false,
      Flag = "FakeInjured",
      Callback = function(value75)
        Config.FakeInjured = value75
        toggleFakeInjured()
      end,
    })

    local animatorSection = main:Section({ Title = "Animator", Opened = true, Icon = "user" })

    animatorSection:Toggle({
      Title = "Apply Animator Config",
      Default = false,
      Flag = "AnimatorEnabled",
      Callback = function(value76)
        Config.AnimatorEnabled = value76

        if not value76 then
          stopAllAnimatorTracks()
          animatorLastState = nil
        end
      end,
    })

    animatorSection:Divider()

    animatorSection:Dropdown({
      Title = "Idle Animation",
      Values = idleAnimNames,
      Default = nil,
      Flag = "AnimatorIdleAnimName",
      Callback = function(value77) Config.AnimatorIdleAnimName = value77 end,
    })

    animatorSection:Dropdown({
      Title = "Walk Animation",
      Values = walkAnimNames,
      Default = nil,
      Flag = "AnimatorWalkAnimName",
      Callback = function(value78) Config.AnimatorWalkAnimName = value78 end,
    })

    animatorSection:Dropdown({
      Title = "Run Animation",
      Values = runAnimNames,
      Default = nil,
      Flag = "AnimatorRunAnimName",
      Callback = function(value79) Config.AnimatorRunAnimName = value79 end,
    })

    local customizationSection = main:Section({
      Title = "Customization",
      Opened = true,
      Icon = "palette",
    })

    customizationSection:Input({
      Title = "Character Name",
      Default = "",
      Placeholder = "Enter name",
      Flag = "CharacterName",
      Callback = function(value80)
        Config.CharacterName = value80
        applyNametags(localPlayer.Character)
      end,
    })

    customizationSection:Input({
      Title = "Rank",
      Default = "",
      Placeholder = "Enter rank",
      Flag = "CharacterRank",
      Callback = function(value81)
        Config.CharacterRank = value81
        applyNametags(localPlayer.Character)
      end,
    })

    customizationSection:Colorpicker({
      Title = "Nametag Color",
      Default = Config.TagColor,
      Flag = "TagColor",
      Callback = function(value82)
        Config.TagColor = value82
        applyNametags(localPlayer.Character)
      end,
    })

    customizationSection:Dropdown({
      Title = "Team",
      Values = { "Menlo", "RAID", "RSU" },
      Default = "Menlo",
      Flag = "Team",
      Callback = function(value83)
        Config.Team = value83
        changeTeam(value83, true)
      end,
    })

    local player = Tabs.Player

    local walkspeedSettingsSection = player:Section({
      Title = "Walkspeed Settings",
      Opened = true,
      Icon = "sport-shoe",
    })

    walkspeedSettingsSection:Toggle({
      Title = "Enable Speed Modifiers",
      Default = false,
      Flag = "SpeedHackEnabled",
      Callback = function(value84) Config.SpeedHackEnabled = value84 end,
    })

    walkspeedSettingsSection:Slider({
      Title = "WalkSpeed",
      Value = { Min = 1, Max = 30, Default = 9 },
      Rounding = 0,
      Enabled = true,
      Flag = "WalkSpeedValue",
      Callback = function(value85) Config.WalkSpeedValue = value85 end,
    })

    walkspeedSettingsSection:Divider()

    walkspeedSettingsSection:Toggle({
      Title = "Infinite Stamina",
      Default = false,
      Flag = "InfiniteStaminaEnabled",
      Callback = function(value86) toggleInfiniteStamina(value86) end,
    })

    local jumpSettingsSection = player:Section({
      Title = "Jump Settings",
      Opened = true,
      Icon = "plane-landing",
    })

    jumpSettingsSection:Toggle({
      Title = "Enable JumpPower",
      Default = false,
      Flag = "JumpPowerEnabled",
      Callback = function(value87) Config.JumpPowerEnabled = value87 end,
    })

    jumpSettingsSection:Slider({
      Title = "JumpPower",
      Value = { Min = 5, Max = 30, Default = 15 },
      Rounding = 0,
      Enabled = true,
      Flag = "JumpPowerValue",
      Callback = function(value88) Config.JumpPowerValue = value88 end,
    })

    jumpSettingsSection:Divider()

    jumpSettingsSection:Toggle({
      Title = "Infinite Jump",
      Default = false,
      Flag = "InfiniteJump",
      Callback = function(value89) Config.InfiniteJump = value89 end,
    })

    local button2

    button2 = jumpSettingsSection:Button({
      Title = "Bypass Jump AC",
      Callback = function()
        button2:Highlight()
        Config.JumpBypassActive = not Config.JumpBypassActive
      end,
    })

    local flySection = player:Section({ Title = "Fly", Opened = true, Icon = "plane" })

    flySection:Toggle({
      Title = "Enable Fly",
      Default = false,
      Flag = "FlyEnabled",
      Callback = function(value90)
        Config.FlyEnabled = value90

        if value90 then
          CurrentFlyType = "Seat [UNDETECTED]"
          FlySpeed = Config.FlySpeed
          enableFly(true)
        else
          enableFly(false)
        end
      end,
    })

    flySection:Dropdown({
      Title = "Fly Method",
      Values = { "Seat [UNDETECTED]" },
      Value = "Seat [UNDETECTED]",
      Locked = true,
      LockedTitle = "Locked For Security Reason...",
      Flag = "FlyType",
      Callback = function(value91) Config.FlyType = "Seat [UNDETECTED]" end,
    }):Lock()

    flySection:Slider({
      Title = "Fly Speed",
      Value = { Min = 1, Max = 50, Default = 25 },
      Rounding = 0,
      Enabled = true,
      Flag = "FlySpeed",
      Callback = function(value92)
        Config.FlySpeed = value92
        FlySpeed = value92
      end,
    })

    player:Section({ Title = "Noclip", Opened = true, Icon = "ghost" }):Toggle({
      Title = "Enable Noclip",
      Default = false,
      Flag = "NoclipEnabled",
      Callback = function(value93)
        Config.NoclipEnabled = value93

        if value93 then
          if not noclipConnection then
            noclipConnection = task.spawn(function()
              while Config.NoclipEnabled and SentinelActive do
                local character60 = localPlayer.Character

                if character60 then
                  local torso = character60:FindFirstChild("Torso")
                    or character60:FindFirstChild("UpperTorso")
                    or character60:FindFirstChild("LowerTorso")

                  if torso and torso:IsA("BasePart") then
                    torso.CanCollide = false
                  end
                end

                task.wait(0.01)
              end
            end)
          end
        else
          if noclipConnection then
            task.cancel(noclipConnection)
            noclipConnection = nil
          end

          local character61 = localPlayer.Character

          if character61 then
            local torso2 = character61:FindFirstChild("Torso")
              or character61:FindFirstChild("UpperTorso")
              or character61:FindFirstChild("LowerTorso")

            if torso2 and torso2:IsA("BasePart") then
              torso2.CanCollide = true
            end
          end
        end
      end,
    })

    local patchSection = player:Section({ Title = "Patch", Opened = true, Icon = "wind" })

    patchSection:Toggle({
      Title = "Disable Stagger",
      Default = false,
      Flag = "StaggerEnabled",
      Callback = function(value94)
        Config.StaggerEnabled = not value94
        local character62 = localPlayer.Character

        if character62 then
          local clientScripts5 = character62:FindFirstChild("ClientScripts")

          if clientScripts5 then
            local stagger5 = clientScripts5:FindFirstChild("Stagger")

            if stagger5 then
              stagger5.Disabled = Config.StaggerEnabled
            end
          end
        end

        replicatedStorage:SetAttribute("StaggerEnabled", Config.StaggerEnabled)
      end,
    })

    patchSection:Toggle({
      Title = "Anti-Anchor",
      Desc = "Allow you to move while executing / getting executed",
      Default = false,
      Flag = "AntiAnchorEnabled",
      Callback = function(value95) Config.AntiAnchorEnabled = value95 end,
    })

    local combat = Tabs.Combat

    local button3

    button3 = combat:Section({ Title = "Free Tools", Opened = true, Icon = "toolbox" }):Button({
      Title = "Get FlashLight",
      Locked = locked5,
      LockedTitle = "Not supported by your executor",
      Callback = function()
        button3:Highlight()
        local map2 = workspace:FindFirstChild("Map")
        local lobbySpawn2 = map2 and map2:FindFirstChild("LobbySpawn")
        local handTorch = lobbySpawn2 and lobbySpawn2:FindFirstChild("HandTorch")
        f61(handTorch and handTorch:FindFirstChild("ClickDetector"), "Flashlight")
      end,
    })

    local bringWeaponsSection = combat:Section({
      Title = "Bring Weapons",
      Opened = true,
      Icon = "unplug",
    })

    bringWeaponsSection:Toggle({
      Title = "Auto Bring Axe",
      Default = false,
      Flag = "AutoBringAxe",
      Callback = function(value96) toggleAutoBringAxe(value96) end,
    })

    bringWeaponsSection:Toggle({
      Title = "Auto Bring Hammer",
      Default = false,
      Flag = "AutoBringHammer",
      Callback = function(value97) toggleAutoBringHammer(value97) end,
    })

    local section = combat:Section({
      Title = "Delete Mobs Protections",
      Opened = true,
      Icon = "shield-x",
    })

    local button4

    button4 = section:Button({
      Title = "Delete All Shields",
      Callback = function()
        button4:Highlight()

        for index59, value98 in ipairs(workspace:GetDescendants()) do
          if value98.Name == "Shield" then
            value98:Destroy()
          end
        end
      end,
    })

    section:Toggle({
      Title = "Auto-Remove Shields",
      Default = false,
      Flag = "AutoRemoveShields",
      Callback = function(value99)
        AutoShieldRemovalActive = value99

        if value99 then
          for index60, value100 in ipairs(workspace:GetDescendants()) do
            if value100.Name == "Shield" then
              value100:Destroy()
            end
          end

          if not AutoShieldRemovalConnection then
            AutoShieldRemovalConnection = workspace.DescendantAdded:Connect(function(descendant7)
              if AutoShieldRemovalActive then
                task.wait(0.1)

                if descendant7.Name == "Shield" then
                  descendant7:Destroy()
                end

                for index61, value101 in ipairs(descendant7:GetDescendants()) do
                  if value101.Name == "Shield" then
                    value101:Destroy()
                  end
                end
              end
            end)
          end
        elseif AutoShieldRemovalConnection then
          AutoShieldRemovalConnection:Disconnect()
          AutoShieldRemovalConnection = nil
        end
      end,
    })

    section:Divider()

    local button5

    button5 = section:Button({
      Title = "Delete Slasher Axe",
      Callback = function()
        button5:Highlight()
        deleteSlasherAxe()
      end,
    })

    section:Toggle({
      Title = "Auto-Remove Axe",
      Default = false,
      Flag = "AutoRemoveAxe",
      Callback = function(value102)
        AutoRemoveAxeActive = value102

        if value102 then
          deleteSlasherAxe()
          setupAutoRemoveAxe()
        elseif AutoRemoveAxeConnection then
          AutoRemoveAxeConnection:Disconnect()
          AutoRemoveAxeConnection = nil
        end
      end,
    })

    section:Divider()

    section:Toggle({
      Title = "Anti Riser Dodge",
      Desc = "Prevents risers from dodging",
      Default = false,
      Flag = "AntiRiserDodgeEnabled",
      Callback = function(value103) AntiRiserDodge_Enable(value103) end,
    })

    local viewModelSection = combat:Section({
      Title = "View Model",
      Opened = true,
      Icon = "person-standing",
    })

    viewModelSection:Toggle({
      Title = "Enable VM customizations",
      Default = false,
      Flag = "ViewModelEnabled",
      Callback = function(value104) Config.ViewModelEnabled = value104 end,
    })

    viewModelSection:Divider()

    viewModelSection:Colorpicker({
      Title = "VM Color",
      Default = Config.ViewModelColor,
      Flag = "ViewModelColor",
      Callback = function(value105) Config.ViewModelColor = value105 end,
    })

    viewModelSection:Dropdown({
      Title = "VM Material",
      Values = values,
      Value = Config.ViewModelMaterial,
      Flag = "ViewModelMaterial",
      Callback = function(value106) Config.ViewModelMaterial = value106 end,
    })

    local section2 = combat:Section({
      Title = "Custom Weapons Appearance",
      Opened = true,
      Icon = "sword",
    })

    section2:Toggle({
      Title = "Enable custom Weapons Appearance",
      Default = false,
      Flag = "CustomWeaponsEnabled",
      Callback = function(value107)
        Config.CustomWeaponsEnabled = value107
        local tool7

        if value107 then
          local character63 = localPlayer.Character

          if character63 then
            tool7 = character63:FindFirstChildWhichIsA("Tool")

            if tool7 then
              pcall(function() f9(tool7) end)
            end
          end
        end
      end,
    })

    section2:Divider()

    section2:Colorpicker({
      Title = "Weapons Color",
      Default = Config.CustomWeaponsColor,
      Flag = "CustomWeaponsColor",
      Callback = function(value108) Config.CustomWeaponsColor = value108 end,
    })

    section2:Dropdown({
      Title = "Weapons Material",
      Values = values,
      Value = Config.CustomWeaponsMaterial,
      Flag = "CustomWeaponsMaterial",
      Callback = function(value109) Config.CustomWeaponsMaterial = value109 end,
    })

    local gunMods = Tabs.GunMods

    local silentAimSection = gunMods:Section({
      Title = "Silent Aim",
      Opened = true,
      Icon = "wifi-cog",
    })

    silentAimSection:Toggle({
      Title = "Enable Silent Aim",
      Default = false,
      Locked = locked3,
      LockedTitle = "Not supported by your executor",
      Flag = "SilentAimEnabled",
      Callback = function(value110) SilentAim_Enable(value110) end,
    })

    silentAimSection:Toggle({
      Title = "Enable Wall Check",
      Default = true,
      Flag = "SilentAimWallCheck",
      Callback = function(value111) Config.SilentAimWallCheck = value111 end,
    })

    silentAimSection:Divider()

    silentAimSection:Dropdown({
      Title = "Target Part",
      Values = { "Head", "Torso" },
      Value = "Head",
      Flag = "SilentAimTargetPart",
      Callback = function(value112) Config.SilentAimTargetPart = value112 end,
    })

    silentAimSection:Divider()

    silentAimSection:Toggle({
      Title = "Show FOV Circle",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "SilentAimShowFOV",
      Callback = function(value113)
        Config.SilentAimShowFOV = value113
        SilentAim_UpdateFOVVisual()
      end,
    })

    silentAimSection:Slider({
      Title = "FOV Circle Radius",
      Value = { Min = 50, Max = 500, Default = Config.SilentAimFOVRadius },
      Rounding = 0,
      Enabled = true,
      Flag = "SilentAimFOVRadius",
      Callback = function(value114)
        Config.SilentAimFOVRadius = value114
        SilentAim_UpdateFOVVisual()
      end,
    })

    silentAimSection:Dropdown({
      Title = "FOV Circle Mode",
      Values = { "Center", "Mouse" },
      Value = "Mouse",
      Flag = "SilentAimFOVMode",
      Callback = function(value115) Config.SilentAimFOVMode = value115 end,
    })

    local reloadSection = gunMods:Section({
      Title = "Reload",
      Opened = true,
      Icon = "refresh-cw",
    })

    reloadSection:Dropdown({
      Title = "Fast Reload Boosts",
      Values = { "+100%", "+200%", "+150%" },
      Multi = true,
      Value = Config.FastReloadBoosts,
      Flag = "FastReloadBoosts",
      Callback = f47,
    })

    reloadSection:Toggle({
      Title = "Fast Reload",
      Default = false,
      Flag = "FastReload",
      Callback = function(value116) toggleFastReload(value116) end,
    })

    reloadSection:Divider()

    reloadSection:Toggle({
      Title = "Auto Reload",
      Default = false,
      Flag = "AutoReload",
      Callback = function(value117) toggleAutoReload(value117) end,
    })

    reloadSection:Divider()

    reloadSection:Toggle({
      Title = "Instant Shotgun Reload",
      Default = false,
      Flag = "InstantShotgunReload",
      Callback = function(value118) setupInstantShotgunReload(value118) end,
    })

    local bulletVisualizerSection = gunMods:Section({
      Title = "Bullet Visualizer",
      Opened = true,
      Icon = "crosshair",
    })

    bulletVisualizerSection:Colorpicker({
      Title = "Is missed",
      Default = Config.BulletVisualizerColorMissed,
      Flag = "BulletVisualizerColorMissed",
      Callback = function(value119) Config.BulletVisualizerColorMissed = value119 end,
    })

    bulletVisualizerSection:Colorpicker({
      Title = "Is Succes",
      Default = Config.BulletVisualizerColorSuccess,
      Flag = "BulletVisualizerColorSuccess",
      Callback = function(value120) Config.BulletVisualizerColorSuccess = value120 end,
    })

    bulletVisualizerSection:Colorpicker({
      Title = "Loading",
      Default = Config.BulletVisualizerColorLoading,
      Flag = "BulletVisualizerColorLoading",
      Callback = function(value121) Config.BulletVisualizerColorLoading = value121 end,
    })

    bulletVisualizerSection:Divider()

    bulletVisualizerSection:Slider({
      Title = "Visualizer Lifetime (s)",
      Value = { Min = 1, Max = 5, Default = 3 },
      Rounding = 1,
      Enabled = true,
      Flag = "BulletVisualizerLifetime",
      Callback = function(value122) Config.BulletVisualizerLifetime = value122 end,
    })

    bulletVisualizerSection:Slider({
      Title = "Visualizer Fade-out Time (s)",
      Value = { Min = 0.1, Max = 1, Default = 0.8 },
      Rounding = 2,
      Enabled = true,
      Flag = "BulletVisualizerFadeOut",
      Callback = function(value123) Config.BulletVisualizerFadeOut = value123 end,
    })

    bulletVisualizerSection:Divider()

    bulletVisualizerSection:Toggle({
      Title = "Enable Bullet Visualizer",
      Default = false,
      Flag = "BulletVisualizerEnabled",
      Callback = function(value124) BulletVisualizer_Enable(value124) end,
    })

    local hitboxSection = gunMods:Section({ Title = "Hitbox", Opened = true, Icon = "box" })

    hitboxSection:Slider({
      Title = "Box Size",
      Value = { Min = 1, Max = 5, Default = 4 },
      Rounding = 0,
      Enabled = true,
      Flag = "BoxSize",
      Callback = function(value125)
        Config.BoxSize = value125

        if HitboxEnabled then
          UpdateAllHitboxes(true)
        end
      end,
    })

    hitboxSection:Toggle({
      Title = "Enable Hitbox Expander",
      Default = false,
      Flag = "HitboxEnabled",
      Callback = function(value126)
        HitboxEnabled = value126
        UpdateAllHitboxes(value126)
      end,
    })

    local randomModsSection = gunMods:Section({
      Title = "Random Mods",
      Opened = true,
      Icon = "settings",
    })

    randomModsSection:Toggle({
      Title = "No Recoil",
      Default = false,
      Locked = locked2,
      LockedTitle = "Not supported by your executor",
      Flag = "AntiCamShake",
      Callback = function(value127)
        Config.AntiCamShake = value127

        if value127 then
          applyNoRecoil()
        else
          removeNoRecoil()
        end
      end,
    })

    randomModsSection:Toggle({
      Title = "Silencer",
      Default = false,
      Flag = "SilencerEnabled",
      Callback = function(value128)
        Config.SilencerEnabled = value128
        updateSilencers(value128)
      end,
    })

    randomModsSection:Divider()

    randomModsSection:Toggle({
      Title = "Infinite Ammo",
      Desc = "Only work for Night Stalker Quest.",
      Default = false,
      Flag = "NightStalkerInfAmmo",
      Callback = function(value129) toggleNightStalkerInfAmmo(value129) end,
    })

    local infected = Tabs.Infected

    local playerInfectionSection = infected:Section({
      Title = "Player Infection",
      Opened = true,
      Icon = "biohazard",
    })

    local button6

    button6 = playerInfectionSection:Button({
      Title = "Fake Controllable Infected",
      Callback = function()
        button6:Highlight()

        if not canInfect then
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Infection",
                Content = "You must respawn before starting a new infection.",
                Duration = 3,
              })
            end
          end)

          return
        end

        if InfectionActive then
          pcall(function()
            if WindUI then
              WindUI:Notify({ Title = "Infection", Content = "Already active!", Duration = 2 })
            end
          end)

          return
        end

        startInfectionSequence("Controllable")
      end,
    })

    local divider = playerInfectionSection.Divider

    local button7

    button7 = playerInfectionSection:Button({
      Title = "Fake Non-Controllable Infected",
      Callback = function()
        button7:Highlight()

        if not canInfect then
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Infection",
                Content = "You must respawn before starting a new infection.",
                Duration = 3,
              })
            end
          end)

          return
        end

        if InfectionActive then
          pcall(function()
            if WindUI then
              WindUI:Notify({ Title = "Infection", Content = "Already active!", Duration = 2 })
            end
          end)

          return
        end

        startInfectionSequence("NonControllable")
      end,
    })

    divider(playerInfectionSection)

    local button8

    button8 = playerInfectionSection:Button({
      Title = "Get Infected [BETA]",
      Desc = "Getting hit by any entities might broke the process. Also, don't heal you until ~20hp, otherwise ur not going to be infected.",
      Callback = function()
        button8:Highlight()
        radawayStartInfectionProcess()
      end,
    })

    local section3 = infected:Section({
      Title = "CI Fight Mods",
      Opened = true,
      Icon = "biohazard",
    })

    section3:Toggle({
      Title = "Auto Complete QTE",
      Default = false,
      Flag = "AutoQTEEnabled",
      Callback = function(value130)
        Config.AutoQTEEnabled = value130
        f24(value130)
      end,
    })

    section3:Dropdown({
      Title = "Auto QTE Platform",
      Desc = "Auto-detected. Change if keys aren't registering.",
      Values = { "PC", "Mobile", "Console" },
      Default = Config.AutoQTEPlatform or "PC",
      Flag = "AutoQTEPlatform",
      Callback = function(value131) Config.AutoQTEPlatform = value131 end,
    })

    section3:Slider({
      Title = "QTE Trigger Speed",
      Value = { Min = 0, Max = 60, Default = 12 },
      Rounding = 0,
      Enabled = true,
      Flag = "AutoQTEReactionSpeed",
      Callback = function(value132) Config.AutoQTEReactionSpeed = value132 end,
    })

    local esp = Tabs.ESP

    local section4 = esp:Section({ Title = "Global ESP Settings", Opened = true, Icon = "globe" })

    section4:Slider({
      Title = "Outline Transparency",
      Value = { Min = 0, Max = 1, Default = Config.HLOutlineTrans },
      Rounding = 2,
      Enabled = true,
      Flag = "HLOutlineTrans",
      Callback = function(value133) Config.HLOutlineTrans = value133 end,
    })

    section4:Slider({
      Title = "Highlight Transparency",
      Value = { Min = 0, Max = 1, Default = Config.HLFillTrans },
      Rounding = 2,
      Enabled = true,
      Flag = "HLFillTrans",
      Callback = function(value134) Config.HLFillTrans = value134 end,
    })

    section4:Slider({
      Title = "Max Distance",
      Value = { Min = 50, Max = 1000, Default = 250 },
      Rounding = 0,
      Enabled = true,
      Flag = "MaxDistance",
      Callback = function(value135) Config.MaxDistance = value135 end,
    })

    section4:Divider()

    section4:Slider({
      Title = "Box Thickness",
      Value = { Min = 1, Max = 10, Default = Config.BoxThickness },
      Rounding = 0,
      Enabled = true,
      Flag = "BoxThickness",
      Callback = function(value136) Config.BoxThickness = value136 end,
    })

    section4:Toggle({
      Title = "Auto Thickness (distance based)",
      Default = Config.BoxAutoThickness,
      Flag = "BoxAutoThickness",
      Callback = function(value137) Config.BoxAutoThickness = value137 end,
    })

    local section5 = esp:Section({
      Title = "Players ESP Settings",
      Opened = true,
      Icon = "user-round-plus",
    })

    section5:Colorpicker({
      Title = "Players Color",
      Default = Config.ColorPlayer,
      Flag = "ColorPlayer",
      Callback = function(value138) Config.ColorPlayer = value138 end,
    })

    section5:Divider()

    section5:Toggle({
      Title = "Highlight Players",
      Default = false,
      Flag = "HighlightPlayer",
      Callback = function(value139) Config.HighlightPlayer = value139 end,
    })

    section5:Toggle({
      Title = "Box Players",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "BoxPlayers",
      Callback = function(value140) Config.BoxPlayers = value140 end,
    })

    section5:Divider()

    section5:Toggle({
      Title = "Show Players Name",
      Default = false,
      Flag = "ShowNamePlayers",
      Callback = function(value141) Config.ShowNamePlayers = value141 end,
    })

    section5:Toggle({
      Title = "Show Players Health",
      Default = false,
      Flag = "ShowHealthPlayers",
      Callback = function(value142) Config.ShowHealthPlayers = value142 end,
    })

    section5:Toggle({
      Title = "Show Players Distance",
      Default = false,
      Flag = "ShowDistancePlayers",
      Callback = function(value143) Config.ShowDistancePlayers = value143 end,
    })

    local section6 = esp:Section({ Title = "Mobs ESP Settings", Opened = true, Icon = "syringe" })

    section6:Colorpicker({
      Title = "Mobs Color",
      Default = Config.ColorMobs,
      Flag = "ColorMobs",
      Callback = function(value144) Config.ColorMobs = value144 end,
    })

    section6:Divider()

    section6:Toggle({
      Title = "Highlight Mobs",
      Default = false,
      Flag = "HighlightMobs",
      Callback = function(value145) Config.HighlightMobs = value145 end,
    })

    section6:Toggle({
      Title = "Box Mobs",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "BoxMobs",
      Callback = function(value146) Config.BoxMobs = value146 end,
    })

    section6:Divider()

    section6:Toggle({
      Title = "Show Mobs Name",
      Default = false,
      Flag = "ShowNameMobs",
      Callback = function(value147) Config.ShowNameMobs = value147 end,
    })

    section6:Toggle({
      Title = "Show Mobs Health",
      Default = false,
      Flag = "ShowHealthMobs",
      Callback = function(value148) Config.ShowHealthMobs = value148 end,
    })

    section6:Toggle({
      Title = "Show Mobs Distance",
      Default = false,
      Flag = "ShowDistanceMobs",
      Callback = function(value149) Config.ShowDistanceMobs = value149 end,
    })

    local section7 = esp:Section({ Title = "Boss ESP Settings", Opened = true, Icon = "skull" })

    section7:Colorpicker({
      Title = "Boss Color",
      Default = Config.ColorBosses,
      Flag = "ColorBosses",
      Callback = function(value150) Config.ColorBosses = value150 end,
    })

    section7:Divider()

    section7:Toggle({
      Title = "Highlight Bosses",
      Default = false,
      Flag = "HighlightBosses",
      Callback = function(value151) Config.HighlightBosses = value151 end,
    })

    section7:Toggle({
      Title = "Box Bosses",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "BoxBosses",
      Callback = function(value152) Config.BoxBosses = value152 end,
    })

    section7:Divider()

    section7:Toggle({
      Title = "Show Bosses Name",
      Default = false,
      Flag = "ShowNameBosses",
      Callback = function(value153) Config.ShowNameBosses = value153 end,
    })

    section7:Toggle({
      Title = "Show Bosses Health",
      Default = false,
      Flag = "ShowHealthBosses",
      Callback = function(value154) Config.ShowHealthBosses = value154 end,
    })

    section7:Toggle({
      Title = "Show Bosses Distance",
      Default = false,
      Flag = "ShowDistanceBosses",
      Callback = function(value155) Config.ShowDistanceBosses = value155 end,
    })

    local visuals = Tabs.Visuals

    local cameraSettingsSection = visuals:Section({
      Title = "Camera Settings",
      Opened = true,
      Icon = "camera",
    })

    cameraSettingsSection:Toggle({
      Title = "Unlock Third Person",
      Default = false,
      Flag = "UnlockThirdPerson",
      Callback = function(value156) Config.UnlockThirdPerson = value156 end,
    })

    cameraSettingsSection:Divider()

    cameraSettingsSection:Toggle({
      Title = "Custom FOV",
      Default = false,
      Flag = "CustomFOVEnabled",
      Callback = function(value157) Config.CustomFOVEnabled = value157 end,
    })

    cameraSettingsSection:Slider({
      Title = "Field of View",
      Value = { Min = 1, Max = 120, Default = 70 },
      Rounding = 0,
      Enabled = true,
      Flag = "FOVValue",
      Callback = function(value158) Config.FOVValue = value158 end,
    })

    local atmosphereSection = visuals:Section({
      Title = "Atmosphere",
      Opened = true,
      Icon = "cloud-sun",
    })

    atmosphereSection:Toggle({
      Title = "Full Bright",
      Default = false,
      Flag = "FullBright",
      Callback = function(value159)
        Config.FullBright = value159

        if value159 then
          lighting.Ambient = Color3.fromRGB(255, 255, 255)
          lighting.Brightness = 2
        else
          lighting.Ambient = OrigAmbient
          lighting.Brightness = OrigBrightness
        end
      end,
    })

    atmosphereSection:Toggle({
      Title = "No Fog",
      Default = false,
      Flag = "NoFog",
      Callback = function(value160)
        Config.NoFog = value160

        if value160 then
          lighting.FogEnd = 999999999
          lighting.FogStart = 999999999
        else
          lighting.FogEnd = OrigFogEnd
          lighting.FogStart = OrigFogStart
        end
      end,
    })

    local xraySettingsSection = visuals:Section({
      Title = "Xray Settings",
      Opened = true,
      Icon = "brick-wall",
    })

    xraySettingsSection:Toggle({
      Title = "Enable X-Ray",
      Default = false,
      Flag = "Xray",
      Callback = function(value161)
        XrayEnabled = value161
        updateXray()
      end,
    })

    xraySettingsSection:Divider()

    xraySettingsSection:Slider({
      Title = "Distance",
      Value = { Min = 1, Max = 1000, Default = 30 },
      Rounding = 0,
      Enabled = true,
      Flag = "XrayDistance",
      Callback = function(value162)
        XrayDistance = value162

        if XrayEnabled then
          updateXray()
        end
      end,
    })

    xraySettingsSection:Slider({
      Title = "Transparency",
      Value = { Min = 0, Max = 100, Default = 30 },
      Rounding = 0,
      Enabled = true,
      Flag = "XrayTransparency",
      Callback = function(value163)
        XrayTransparency = value163 / 100
        updateXrayMaterialAndTransparency()

        if XrayEnabled then
          updateXray()
        end
      end,
    })

    xraySettingsSection:Dropdown({
      Title = "Material",
      Values = { "Plastic", "Neon", "ForceField", "Glass", "SmoothPlastic" },
      Value = "ForceField",
      Flag = "XrayMaterial",
      Callback = function(value164)
        Config.XrayMaterial = value164

        XrayMaterial = ({
          Plastic = Enum.Material.Plastic,
          Neon = Enum.Material.Neon,
          ForceField = Enum.Material.ForceField,
          Glass = Enum.Material.Glass,
          SmoothPlastic = Enum.Material.SmoothPlastic,
        })[value164] or Enum.Material.ForceField

        updateXrayMaterialAndTransparency()

        if XrayEnabled then
          updateXray()
        end
      end,
    })

    local screenCustomizationSection = visuals:Section({
      Title = "Screen Customization",
      Opened = true,
      Icon = "brush",
    })

    screenCustomizationSection:Toggle({
      Title = "Auto-Wipe Screen Blood",
      Default = false,
      Flag = "AutoWipeBlood",
      Callback = function(value165) Config.AutoWipeBlood = value165 end,
    })

    local cleanScreenButton

    cleanScreenButton = screenCustomizationSection:Button({
      Title = "Clean Screen",
      Callback = function()
        cleanScreenButton:Highlight()
        local gui5 = localPlayer.PlayerGui:FindFirstChild("Gui")

        if gui5 then
          for key18, clean3 in pairs(gui5:GetChildren()) do
            if clean3.Name == "blood" then
              clean3.Name = "clean"
              tweenService:Create(clean3, TweenInfo.new(0.2), { ImageTransparency = 1 }):Play()
              debris:AddItem(clean3, 0.5)
            end
          end
        end
      end,
    })

    local section8 = visuals:Section({
      Title = "Night Vision & Gasmask",
      Opened = true,
      Icon = "moon",
    })

    local deleteGasmaskButton

    deleteGasmaskButton = section8:Button({
      Title = "Delete Gasmask",
      Callback = function()
        deleteGasmaskButton:Highlight()
        local playerGui8 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui8 then
          local gasmask2 = playerGui8:FindFirstChild("Gasmask")

          if gasmask2 then
            gasmask2:Destroy()
          end
        end
      end,
    })

    local breakGasmaskButton

    breakGasmaskButton = section8:Button({
      Title = "Break Gasmask",
      Callback = function()
        breakGasmaskButton:Highlight()
        BreakGasmask()
      end,
    })

    section8:Toggle({
      Title = "Infinite Night Vision",
      Default = false,
      Flag = "InfiniteNightVision",
      Callback = function(value166) ApplyInfiniteNightVision(value166) end,
    })

    local world = Tabs.World
    local teleportSection = world:Section({ Title = "Teleport", Opened = true, Icon = "globe" })

    for key19, value167 in pairs(teleportPoints) do
      local v173 = {}
      local v174 = {}

      for index62, value168 in ipairs(value167) do
        local v175, v176 = unpack(value168)
        table.insert(v173, v175)
        v174[v175] = v176
      end

      teleportSection:Dropdown({
        Title = key19,
        Values = v173,
        Default = v173[1],
        Flag = "TP_" .. key19,
        Callback = function(value169)
          local v177 = v174[value169]

          if v177 then
            teleportTo(v177)
          end
        end,
      })
    end

    local button9

    button9 = world:Section({ Title = "LandMines", Opened = true, Icon = "bolt" }):Button({
      Title = "Delete All Landmines",
      Callback = function()
        button9:Highlight()
        deleteAllLandmines()
      end,
    })

    local radiationsSection = world:Section({
      Title = "Radiations",
      Opened = true,
      Icon = "radiation",
    })

    radiationsSection:Toggle({
      Title = "Anti-Radiation Effect",
      Default = false,
      Flag = "ImmuneLookHazard",
      Callback = function(value170) Config.ImmuneLookHazard = value170 end,
    })

    local button10

    button10 = radiationsSection:Button({
      Title = "Remove Elephant Foot",
      Callback = function()
        button10:Highlight()
        removeElephantFoot()
      end,
    })

    local terrorUISection = world:Section({ Title = "Terror UI", Opened = true, Icon = "skull" })

    local button11

    button11 = terrorUISection:Button({
      Title = "Disable ChimeraRad",
      Callback = function()
        button11:Highlight()
        local playerGui9 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui9 then
          local chimeraRad = playerGui9:FindFirstChild("ChimeraRad")

          if chimeraRad then
            local chimeraTerror = chimeraRad:FindFirstChild("ChimeraTerror")

            if chimeraTerror then
              chimeraTerror:Destroy()
            end
          end
        end

        local currentCamera8 = workspace.CurrentCamera

        if currentCamera8 then
          for index63, value171 in ipairs(currentCamera8:GetChildren()) do
            if value171:IsA("ColorCorrectionEffect")
              and value171.Name == "RadiationColorCorrection" then
              value171:Destroy()
            end
          end
        end
      end,
    })

    local button12

    button12 = terrorUISection:Button({
      Title = "Disable GilbertRad",
      Callback = function()
        button12:Highlight()
        local playerGui10 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui10 then
          local gilbertRad = playerGui10:FindFirstChild("GilbertRad")

          if gilbertRad then
            local localHandler = gilbertRad:FindFirstChild("LocalHandler")

            if localHandler then
              localHandler:Destroy()
            end
          end

          local glitchedScreen = playerGui10:FindFirstChild("GlitchedScreen")

          if glitchedScreen then
            glitchedScreen:Destroy()
          end
        end
      end,
    })

    local mapRemoverSection = world:Section({
      Title = "Map Remover",
      Opened = true,
      Icon = "trash",
    })

    local button13

    button13 = mapRemoverSection:Button({
      Title = "Remove Arabic dud",
      Callback = function()
        button13:Highlight()
        removeArabicDud()
      end,
    })

    local button14

    button14 = mapRemoverSection:Button({
      Title = "Remove Lobby Music",
      Callback = function()
        button14:Highlight()
        removeLobbyMusic()
      end,
    })

    local button15

    button15 = mapRemoverSection:Button({
      Title = "Delete ALL doors",
      Callback = function()
        button15:Highlight()
        deleteAllDoors()
      end,
    })

    local animations = Tabs.Animations

    local toggleAnimationsSection = animations:Section({
      Title = "Toggle Animations",
      Opened = false,
      Icon = "toggle-right",
    })

    for key20, value172 in pairs(toggleAnims) do
      local v178 = value172

      toggleAnimationsSection:Toggle({
        Title = key20,
        Default = false,
        Flag = "Anim_" .. key20:gsub("[^%w]", "_"),
        Callback = function(value173) playToggleAnim(v178, value173) end,
      })
    end

    local buttonAnimationsSection = animations:Section({
      Title = "Button Animations",
      Opened = false,
      Icon = "play",
    })

    for key21, value174 in pairs(buttonAnims) do
      local v179 = value174
      local button16

      button16 = buttonAnimationsSection:Button({
        Title = key21,
        Callback = function()
          button16:Highlight()
          playButtonAnim(v179)
        end,
      })
    end

    local quests = Tabs.Quests

    local questCompletionSection = quests:Section({
      Title = "Quest Completion",
      Opened = true,
      Icon = "scroll",
    })

    local button17

    button17 = questCompletionSection:Button({
      Title = "Complete Manhattan Radiation Quest",
      Callback = function()
        button17:Highlight()
        completeManhattanQuests()
      end,
    })

    questCompletionSection:Divider()

    local button18

    button18 = questCompletionSection:Button({
      Title = "Collect All Documents",
      Locked = locked4,
      LockedTitle = "Not supported by your executor",
      Callback = function()
        button18:Highlight()
        collectAllDocuments()
      end,
    })

    local getBadgesSection = quests:Section({
      Title = "Get Badges",
      Opened = true,
      Icon = "award",
    })

    local button19

    button19 = getBadgesSection:Button({
      Title = "Get Underequipped Badge",
      Desc = "This will give you three badges : 'ONE-MANE-ARMY', 'VETERAN-OF-PURGATORY' and 'UNDEREQUIPPED'",
      Callback = function()
        button19:Highlight()
        getUnderequippedBadge()
      end,
    })

    getBadgesSection:Divider()

    local button20

    button20 = getBadgesSection:Button({
      Title = "Get 'Unfortunate' Badge",
      Callback = function()
        button20:Highlight()
        getBadge1()
      end,
    })

    local button21

    button21 = getBadgesSection:Button({
      Title = "Get 'NECROTIC-CONTROL' Badge",
      Callback = function()
        button21:Highlight()
        getBadge2()
      end,
    })

    local button22

    button22 = getBadgesSection:Button({
      Title = "Get 'SECTOR-SWEEP' Badge",
      Callback = function()
        button22:Highlight()
        getBadge3()
      end,
    })

    local utilities = Tabs.Utilities

    local mainStuffSection = utilities:Section({
      Title = "Main Stuff",
      Opened = true,
      Icon = "settings-2",
    })

    local button23

    button23 = mainStuffSection:Button({
      Title = "Go to Restricted Server",
      Callback = function()
        button23:Highlight()
        teleportToCFrame(RestrictedServerCFrame)
      end,
    })

    mainStuffSection:Toggle({
      Title = "Anti-AFK",
      Default = false,
      Flag = "AntiAFKEnabled",
      Callback = function(value175) Config.AntiAFKEnabled = value175 end,
    })

    mainStuffSection:Divider()

    mainStuffSection:Toggle({
      Title = "Auto Remove Death Screen",
      Default = false,
      Flag = "RemoveDeathScreen",
      Callback = function(value176)
        Config.RemoveDeathScreen = value176

        if value176 then
          local playerGui11 = localPlayer:FindFirstChild("PlayerGui")

          if playerGui11 then
            local death = playerGui11:FindFirstChild("Death")

            if death then
              death:Destroy()
            end

            if not removeDeathConnection then
              removeDeathConnection = playerGui11.ChildAdded:Connect(function(child13)
                if child13.Name == "Death" and Config.RemoveDeathScreen then
                  child13:Destroy()
                end
              end)
            end
          end
        elseif removeDeathConnection then
          removeDeathConnection:Disconnect()
          removeDeathConnection = nil
        end
      end,
    })

    mainStuffSection:Toggle({
      Title = "Show Native Chat (CoreGui)",
      Default = false,
      Flag = "ChatLoggerEnabled",
      Callback = function(value177)
        chatEverToggled = true
        Config.ChatLoggerEnabled = value177
        applyChatState()
      end,
    })

    local proximityPromptSection = utilities:Section({
      Title = "Proximity Prompt",
      Opened = true,
      Icon = "hand",
    })

    proximityPromptSection:Toggle({
      Title = "Instant proximity prompt",
      Default = false,
      Locked = locked4,
      LockedTitle = "Not supported by your executor",
      Flag = "InstantProximityPrompt",
      Callback = function(value178)
        Config.InstantProximityPrompt = value178

        if value178 then
          setupInstantProximity()
        elseif InstantProximityConnection then
          InstantProximityConnection:Disconnect()
          InstantProximityConnection = nil
        end
      end,
    })

    proximityPromptSection:Toggle({
      Title = "Auto Proximity Prompt",
      Default = false,
      Locked = locked4,
      LockedTitle = "Not supported by your executor",
      Flag = "AutoCompleteProximityPrompt",
      Callback = function(value179)
        Config.AutoCompleteProximityPrompt = value179

        if value179 then
          autoCompleteProximity()
        elseif AutoCompletePromptConnection then
          AutoCompletePromptConnection:Disconnect()
          AutoCompletePromptConnection = nil
        end
      end,
    })

    local v180 = Tabs.Settings

    local deleteScriptButton

    deleteScriptButton = v180:Section({
      Title = "Danger Zone",
      Opened = true,
      Icon = "triangle-alert",
    }):Button({
      Title = "Delete Script",
      Icon = "trash",
      Color = Color3.fromHex("#EF4F1D"),
      Locked = true,
      LockedTitle = "Working On...",
      Callback = function()
        deleteScriptButton:Highlight()
        task.spawn(function() FullScriptCleanup() end)
      end,
    })

    local interfaceSection = v180:Section({
      Title = "Interface",
      Opened = true,
      Icon = "settings",
    })

    interfaceSection:Dropdown({
      Title = "UI Theme",
      Values = {
        "Amber", "CottonCandy", "Crimson", "Dark", "Emerald", "Indigo", "Light", "Mellowsi",
        "Midnight", "MonokaiPro",
      },
      Value = "Amber",
      Flag = "UITheme",
      Callback = function(value180)
        Config.UITheme = value180
        pcall(function() WindUI:SetTheme(value180) end)
      end,
    })

    interfaceSection:Dropdown({
      Title = "Minimize Keybind",
      Values = {
        "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",
        "S", "T", "U", "V", "W", "X", "Y", "Z", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8",
        "F9", "F10", "F11", "F12", "Zero", "One", "Two", "Three", "Four", "Five", "Six",
        "Seven", "Eight", "Nine",
      },
      Value = "K",
      Flag = "MinimizeKeybind",
      Callback = function(value181)
        Config.MinimizeKeybind = value181

        if sentinelExaminationWindow then
          pcall(function() sentinelExaminationWindow:SetToggleKey(Enum.KeyCode[value181]) end)
        end
      end,
    })

    interfaceSection:Divider()

    sentinelStatusParagraph = interfaceSection:Paragraph({
      Title = "Sentinel Status",
      Desc = [[
Status: Active
FPS: 0
Ping: 0 ms]],
      Image = "bookmark",
      ImageSize = 24,
    })

    task.spawn(function()
      local v181 = 0
      local v182 = 0
      local v183 = tick()

      runService.RenderStepped:Connect(function()
        if not SentinelActive then
          return
        else
          v182 = v182 + 1
          local v184 = tick()

          if v184 - v183 >= 1 then
            v181 = v182
            v182 = 0
            v183 = v184
          end

          return
        end
      end)

      while SentinelActive do
        task.wait(0.5)
        local v185 = tick() - SentinelLastInteraction >= 10 and "AFK" or "Active"
        local getNetworkPing = localPlayer:GetNetworkPing()

        local v186 = "Status: " .. v185 .. "\nFPS: " .. v181 .. "\nPing: "
          .. math.floor(getNetworkPing * 1000) .. " ms"

        if sentinelStatusParagraph then
          if not pcall(function() sentinelStatusParagraph:SetDesc(v186) end) then
            pcall(function()
              sentinelStatusParagraph:Set({
                Title = "Sentinel Status",
                Desc = v186,
                Image = "bookmark",
                ImageSize = 24,
              })
            end)
          end
        end
      end
    end)
  end

  function initializeUI()
    if sentinelExaminationWindow then
      return
    end

    sentinelExaminationWindow = WindUI:CreateWindow({
      Title = "Sentinel - Examination",
      Author = "x4tmq",
      Icon = "door-open",
      ScrollBarEnabled = true,
      Size = UDim2.fromOffset(250, 150),
      ToggleKey = Enum.KeyCode.K,
      Theme = "Dark",
      HideSearchBar = false,
      Background = "0",
      Resizable = true,
      Transparent = true,
      BackgroundImageTransparency = 0.5,
      KeySystem = {
        Note = [[
Enter your key to access Sentinel.
Get it from the Discord or the website below.]],
        SaveKey = false,
        API = {
          {
            Title = "Discord",
            Desc = "Click to copy the Discord invite link.",
            Icon = "message-circle",
            Type = "SentinelKey-Examination",
            Link = "",
            ButtonName = "Discord",
            ButtonDesc = "Click to copy the Discord invite link.",
          },
          {
            Title = "Website",
            Desc = "Click to copy the website link.",
            Icon = "globe",
            Type = "SentinelKey-Examination",
            Link = "https://x4tmqq.github.io/Sentinel-Script/",
            ButtonName = "Website",
            ButtonDesc = "Click to copy the website link.",
          },
        },
      },
      User = { Enabled = false },
    })

    pcall(function()
      sentinelExaminationWindow:Tag({
        Title = "v16.50.00",
        Icon = "shield-check",
        Color = Color3.fromHex("#30ff6a"),
        Radius = 13,
      })
    end)

    pcall(function()
      sentinelExaminationWindow:Tag({
        Title = "Beta",
        Icon = "github",
        Color = Color3.fromHex("#000000"),
        Radius = 13,
      })
    end)

    sentinelExaminationWindow:EditOpenButton({
      Title = "Sentinel - Examination",
      Icon = "door-open",
      CornerRadius = UDim.new(0, 24),
      StrokeThickness = 2,
      Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
      OnlyMobile = false,
      Enabled = true,
      Draggable = true,
    })

    if Config.WindowBackground ~= "" then
      pcall(function() sentinelExaminationWindow:SetBackgroundImage(Config.WindowBackground) end)
    end

    BuildUI()
  end

  WindUI:SetTheme("Dark")

  if not sentinelExaminationWindow then
    initializeUI()
  end

  if SentinelLimitedExecutor then
    task.wait(1.2)

    pcall(function()
      WindUI:Notify({
        Title = "Executor Compatibility",
        Content = SentinelExecutorName .. [[
 isn't fully friendly with the script.Some features have been locked for security reason.
Recommended executors : Real (free, key) / Potassium (Paid)]],
        Icon = "app-window",
        Duration = 15,
      })
    end)
  end

  if sentinelExaminationWindow then
    sentinelExaminationWindow.Visible = true
  end

  pcall(function()
    if sentinelExaminationWindow then
      sentinelExaminationWindow:GetPropertyChangedSignal("Visible"):Connect(function() end)
    end
  end)

  firstHide = true

  userInputService.InputBegan:Connect(function(input8, p145)
    if p145 then
      return
    end

    if input8.KeyCode == Enum.KeyCode[Config.MinimizeKeybind] and sentinelExaminationWindow then
      if not sentinelExaminationWindow.Visible and firstHide then
        firstHide = false
      end
    end
  end)

  runService.Heartbeat:Connect(function(delta4)
    if not SentinelActive then
      return
    end

    applyAnimatorState()
  end)

  localPlayer.CharacterAdded:Connect(function()
    if InfectionActive then
      stopInfection()
    end

    InfectionActive = false
    infectionIsRunning = false
    canInfect = true

    if Config.RemoveDeathScreen and not removeDeathConnection then
      local playerGui12 = localPlayer:FindFirstChild("PlayerGui")

      if playerGui12 then
        removeDeathConnection = playerGui12.ChildAdded:Connect(function(child14)
          if child14.Name == "Death" and Config.RemoveDeathScreen then
            child14:Destroy()
          end
        end)
      end
    end

    if Config.StaggerImmune then
      local character64 = localPlayer.Character

      if character64 then
        character64:SetAttribute("StaggerImmune", true)
      end
    end

    if Config.NetworkBypassEnabled then
      task.wait(1)
    end

    local v187

    if Config.Team and Config.Team ~= "" then
      task.wait(0.8)
      v187 = nil

      for index64, value182 in ipairs(teams:GetChildren()) do
        if value182:IsA("Team") and value182.Name:lower() == tostring(Config.Team):lower() then
          v187 = value182
          break
        end
      end

      if v187 and localPlayer.Team ~= v187 then
        pcall(function() localPlayer.Team = v187 end)
        pcall(function() localPlayer.TeamColor = v187.TeamColor end)
      end
    end
  end)

  function f63(p146)
    local v188 = {}

    if not p146 then
      return v188
    else
      local head4 = p146:FindFirstChild("Head")

      if head4 then
        for index65, value183 in ipairs(head4:GetChildren()) do
          if value183:IsA("Accessory") or value183:IsA("Hat") then
            table.insert(v188, value183)
          end
        end
      end

      for index66, value184 in ipairs(p146:GetChildren()) do
        if value184:IsA("Accessory") or value184:IsA("Hat") then
          table.insert(v188, value184)
        end
      end

      return v188
    end
  end

  runService.RenderStepped:Connect(function()
    if not SentinelActive then
      return
    end

    if Config.UnlockThirdPerson then
      if localPlayer.CameraMode ~= Enum.CameraMode.Classic then
        localPlayer.CameraMode = Enum.CameraMode.Classic
      end

      if localPlayer.CameraMaxZoomDistance < 999 then
        localPlayer.CameraMaxZoomDistance = 999
      end
    else
      if localPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
        localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
      end

      if localPlayer.CameraMaxZoomDistance > 50 then
        localPlayer.CameraMaxZoomDistance = 50
      end
    end
  end)

  HeadAccessoryConnection = nil
  CharacterAccessoryConnection = nil
  v172 = nil

  function f65(p147, p148)
    if not p147 then
      return
    end

    for index67, value185 in ipairs(p147:GetDescendants()) do
      local v189 = value185

      if v189:IsA("BasePart") then
        pcall(function() v189.LocalTransparencyModifier = p148 end)
      elseif v189:IsA("Decal") then
        pcall(function() v189.Transparency = p148 end)
      end
    end

    if p147:IsA("BasePart") then
      pcall(function() p147.LocalTransparencyModifier = p148 end)
    end
  end

  function f64(p149)
    if HeadAccessoryConnection then
      HeadAccessoryConnection:Disconnect()
      HeadAccessoryConnection = nil
    end

    if CharacterAccessoryConnection then
      CharacterAccessoryConnection:Disconnect()
      CharacterAccessoryConnection = nil
    end

    if v172 ~= nil then
      f66(p149, v172 and 1 or 0)
    end

    local head5 = p149:FindFirstChild("Head")

    if head5 then
      HeadAccessoryConnection = head5.ChildAdded:Connect(function(child15)
        if child15:IsA("Accessory") or child15:IsA("Hat") then
          task.defer(function()
            if child15 and child15.Parent then
              f65(child15, v172 and 1 or 0)
            end
          end)
        end
      end)
    end

    CharacterAccessoryConnection = p149.ChildAdded:Connect(function(child16)
      if child16:IsA("Accessory") or child16:IsA("Hat") then
        task.defer(function()
          if child16 and child16.Parent then
            f65(child16, v172 and 1 or 0)
          end
        end)
      end
    end)
  end

  function f66(p150, p151)
    for index68, value186 in ipairs(f63(p150)) do
      f65(value186, p151)
    end
  end

  runService.RenderStepped:Connect(function()
    if not SentinelActive then
      return
    else
      local character65 = localPlayer.Character

      if not character65 then
        return
      else
        local head6 = character65:FindFirstChild("Head")

        if not head6 then
          return
        else
          local v190 = (currentCamera.CFrame.Position - head6.Position).Magnitude < 1.5

          if v190 ~= v172 then
            v172 = v190

            if v190 then
              f66(character65, 1)
            else
              f66(character65, 0)
            end
          elseif v190 then
            f66(character65, 1)
          end

          return
        end
      end
    end
  end)

  if currentCamera then
    currentCamera:GetPropertyChangedSignal("CFrame"):Connect(function()
      if not SentinelActive then
        return
      else
        local character66 = localPlayer.Character

        if not character66 then
          return
        else
          local head7 = character66:FindFirstChild("Head")

          if not head7 then
            return
          else
            local v191 = (currentCamera.CFrame.Position - head7.Position).Magnitude < 3

            if v191 ~= v172 then
              v172 = v191
              f66(character66, v191 and 1 or 0)
            elseif v191 then
              f66(character66, 1)
            end

            return
          end
        end
      end
    end)
  end

  if localPlayer.Character then
    localPlayer.Character:WaitForChild("Head", 5)
    f64(localPlayer.Character)
  end

  localPlayer.CharacterAdded:Connect(function(character67)
    character67:WaitForChild("Head", 5)
    f64(character67)
  end)

  connect7 = nil

  function f67()
    if connect7 then
      connect7:Disconnect()
      connect7 = nil
    end

    local ignore = workspace.Terrain:FindFirstChild("Ignore")

    if not ignore then
      return
    end

    connect7 = ignore.ChildAdded:Connect(function(child17)
      if not Config.ViewModelEnabled then
        return
      end

      if child17.Name == localPlayer.Name .. "viewmodel" then
        task.wait(0.1)

        for index69, value187 in ipairs(child17:GetChildren()) do
          f7(value187)
        end
      end
    end)
  end

  workspace.Terrain.ChildAdded:Connect(function(child18)
    if child18.Name == "Ignore" then
      task.wait(0.1)
      f67()
    end
  end)

  f67()

  task.spawn(function()
    while SentinelActive do
      task.wait(1)

      if Config.ViewModelEnabled then
        local ignore2 = workspace.Terrain:FindFirstChild("Ignore")

        if ignore2 then
          if ignore2:FindFirstChild(localPlayer.Name .. "viewmodel") and not connect7 then
            f67()
          end
        end
      end
    end
  end)

  local v192 = os.clock()

  print("\n============ Sentinel Account & Info ============")
  print("User         : " .. SentinelUserName)
  print("Account Age  : " .. SentinelAccountAge)
  print("Device       : " .. SentinelDeviceType)
  print("\n============ Sentinel Script & Executor ============")
  print("Load Time    : " .. string.format("%.3f", v192 - SentinelLoadStart) .. "s")
  print("Executor     : " .. SentinelExecutorName)
  print("Full Script Support : " .. (SentinelHookSupported and "✅" or "❌"))

  f3()

  if not SentinelHookSupported then
    pcall(function()
      if WindUI and WindUI.Notify then
        WindUI:Notify({
          Title = "Compatibility Warning",
          Content = "Hooks are not supported. Silent Aim may not work.",
          Icon = "webhook",
          Duration = 15,
        })
      end
    end)
  end

  if sentinelExaminationWindow and WindUI then
    pcall(function()
      WindUI:Notify({
        Title = "Sentinel v16.50.00",
        Content = [[
Script Loaded successfully,
Welcome, ]] .. SentinelUserName .. [[
.
Executor: ]] .. SentinelExecutorName,
        Icon = "shield-check",
        Duration = 5,
      })
    end)

    pcall(function()
      WindUI:Notify({
        Title = "News",
        Content = "New Get Infected system implemented (60s cooldown).",
        Icon = "newspaper",
        Duration = 5,
      })
    end)
  end

  return
end
