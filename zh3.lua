local function tr(s)
  if type(s) ~= "string" then return s end
  if _G.ZH[s] then return _G.ZH[s] end
  for e, c in pairs(_G.ZH) do
    if #e > 4 and s:find(e, 1, true) then
      return (s:gsub(e:gsub("%p", "%%%0"), c))
    end
  end
  return s
end

local function loc(r)
  if not r then return end
  pcall(function()
    if r:IsA("TextLabel") or r:IsA("TextButton") or r:IsA("TextBox") then
      if r.Text and r.Text ~= "" then r.Text = tr(r.Text) end
      if r.PlaceholderText and r.PlaceholderText ~= "" then r.PlaceholderText = tr(r.PlaceholderText) end
    end
    for _, c in ipairs(r:GetChildren()) do loc(c) end
  end)
end

local function scanAll()
  pcall(function()
    local pg = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    if pg then loc(pg) end
  end)
  pcall(function() loc(game:GetService("CoreGui")) end)
end

local function hookNotify()
  pcall(function()
    if WindUI and WindUI.Notify and not WindUI._zhHooked then
      local o = WindUI.Notify
      WindUI.Notify = function(self, cfg, ...)
        if type(cfg) == "table" then
          if cfg.Title then cfg.Title = tr(cfg.Title) end
          if cfg.Content then cfg.Content = tr(cfg.Content) end
          if cfg.Desc then cfg.Desc = tr(cfg.Desc) end
        end
        return o(self, cfg, ...)
      end
      WindUI._zhHooked = true
    end
  end)
end

task.spawn(function()
  task.wait(0.5)
  pcall(function()
    local pg = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    if pg then
      pg.DescendantAdded:Connect(function(d)
        task.wait(0.05)
        loc(d)
      end)
    end
  end)
end)

task.spawn(function()
  task.wait(1)
  while true do
    scanAll()
    hookNotify()
    task.wait(1)
  end
end)

print("[汉化补丁] 加载完成")
