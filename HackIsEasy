--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Red Vs Blue Plane Wars🔥",
   Icon = 0,
   LoadingTitle = "The Red Vs Blie Plane Wars Script",
   LoadingSubtitle = "By: Theurus_The_Creator",
   Theme = "Ocean",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "RedVsBluePlaneWars"
   },
   Discord = {
      Enabled = true,
      Invite = "85cMYuy4J",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Key System",
      Subtitle = "To Verify your not a bot, Please type: Key1109888",
      Note = "Key is required to continue!",
      FileName = "Keyforent1r11",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"Key1109888"}
   }
})

-- CREATE MAIN TAB
local MainTab = Window:CreateTab("Teleport", 4483362458)

-- Create parts

local p = Instance.new("Part")
p.Size = Vector3.new(15, 3, 15)
p.Position = Vector3.new(-2242, 457, -1774)
p.Anchored = true
p.CanCollide = true
p.Transparency = 0.3
p.Parent = workspace

local p1 = Instance.new("Part")
p1.Size = Vector3.new(15, 3, 15)
p1.Position = Vector3.new(2796, 243, -1741)
p1.Anchored = true
p1.CanCollide = true
p1.Transparency = 0.3
p1.Parent = workspace

local p2 = Instance.new("Part")
p2.Size = Vector3.new(15, 3, 15)
p2.Position = Vector3.new(1529, 377, -1726)
p2.Anchored = true
p2.CanCollide = true
p2.Transparency = 0.3
p2.Parent = workspace

local p3 = Instance.new("Part")
p3.Size = Vector3.new(15, 3, 15)
p3.Position = Vector3.new(-1010, 507, -1810)
p3.Anchored = true
p3.CanCollide = true
p3.Transparency = 0.3
p3.Parent = workspace

local p4 = Instance.new("Part")
p4.Size = Vector3.new(15, 3, 15)
p4.Position = Vector3.new(-1010, 507, -1810)
p4.Anchored = true
p4.CanCollide = true
p4.Transparency = 0.3
p4.Parent = workspace


-- 218, 3, -2895 red base
-- 250, 1, -642 blue base
-- 334, 288, -1795 middle island
-- 157, 3, -1804 weather machine
-- Create buttons
local Button = MainTab:CreateButton({
   Name = "Tp To Flag (island 1)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      character:PivotTo(CFrame.new(-2242, 460, -1774))
   end,
})

local Button = MainTab:CreateButton({
   Name = "Tp To Flag (island 2)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      character:PivotTo(CFrame.new(-1010, 510, -1810))
   end,
})

local Button = MainTab:CreateButton({
   Name = "Tp To Flag (island 3)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      character:PivotTo(CFrame.new(1529, 380, -1726))
   end,
})

local Button = MainTab:CreateButton({
   Name = "Tp To Flag (island 4)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      character:PivotTo(CFrame.new(2796, 246, -1741))
   end,
})

local MainSection = MainTab:CreateSection("Base")

local Button = MainTab:CreateButton({
   Name = "Tp to Blue Base",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      character:PivotTo(CFrame.new(218, 3, -2895))
   end,
})

local Button = MainTab:CreateButton({
   Name = "Tp to Red Base",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      character:PivotTo(CFrame.new(250, 1, -642))
   end,
})

local MainSection = MainTab:CreateSection("others")

local Button = MainTab:CreateButton({
   Name = "Tp to middle island",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      character:PivotTo(CFrame.new(334, 288, -1795))
   end,
})

local Button = MainTab:CreateButton({
   Name = "Tp to weather machine",
   Callback = function()
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      character:PivotTo(CFrame.new(157, 3, -1804))
   end,
})
