local n
n = 140455651
loadstring(
  game:HttpGet(
    "https://raw.githubusercontent.com/scriptpastebin/Blox-Fruits/refs/heads/main/core.luau"
  )
)()
local n2
n2 = 737086916
local v

v = loadstring(
  game:HttpGet(
    "https://raw.githubusercontent.com/bloxfruitsnokey/Redz-Hub/refs/heads/main/Gavz/ui.luau"
  )
)():MakeWindow({
  Title = "Gavz Hub : Blox Fruits",
  SubTitle = "discord.gg/pKS6qzcaqB",
  SaveFolder = "oknaiget.json",
})

v:NewMinimizer({ KeyCode = Enum.KeyCode.LeftControl }):CreateMobileMinimizer({
  Image = "rbxassetid://108267040590174",
  BackgroundColor3 = Color3.fromRGB(25, 25, 25),
})
local n3
n3 = 608388172
local tbl

-- [[ leaked by YzZ ]]

tbl = {
  Info = v:MakeTab({ Title = "Tab Info And Status", Icon = "Info" }),
  Main = v:MakeTab({ Title = "Tab Farming", Icon = "rbxassetid://7733960981" }),
  Settings = v:MakeTab({ Title = "Tab Setting", Icon = "rbxassetid://7734053495" }),
  Fish = v:MakeTab({ Title = "Tab Fishing", Icon = "rbxassetid://127664059821666" }),
  Quests = v:MakeTab({ Title = "Tab Quest And Item", Icon = "rbxassetid://13075622619" }),
  SeaEvent = v:MakeTab({ Title = "Tab Sea Event", Icon = "waves" }),
  Race = v:MakeTab({ Title = "Tab Mirage And Race", Icon = "rbxassetid://11162889532" }),
  Prehistoric = v:MakeTab({ Title = "Tab Volcano Event", Icon = "tent" }),
  Esp = v:MakeTab({ Title = "Tab Stats And Esp", Icon = "rbxassetid://7040410130" }),
  Raids = v:MakeTab({ Title = "Tab Fruit And Raid", Icon = "rbxassetid://11155986081" }),
  Combat = v:MakeTab({ Title = "Tab Local Player", Icon = "rbxassetid://13075651575" }),
  Travel = v:MakeTab({ Title = "Tab Teleport", Icon = "locate" }),
  Shop = v:MakeTab({ Title = "Tab Shopping", Icon = "rbxassetid://6031265976" }),
  Misc = v:MakeTab({ Title = "Tab Miscellaneous", Icon = "rbxassetid://10709783577" }),
}

tbl.Info:AddSection("Status Server")
local n4
n4 = 604487395
local n5

do
  local timeZoneParagraph = tbl.Info:AddParagraph("Time Zone", "")
  n5 = 95612715
  local gameTimeParagraph = tbl.Info:AddParagraph("Game Time", "")
  local n6 = nil
  local n7 = nil

  -- Helper routine (UpdateOS) — calls :GetService, :SetDesc
  UpdateOS = function()
    n6 = 962841611
    n7 = 409903086
    local dateStr = os.date("*t")
    local n8 = dateStr.hour % 24
    local flag = n8 < 12

    if flag then
      flag = "AM"
    end

    local formatted =
      string.format("%02i:%02i:%02i %s", (n8 - 1) % 12 + 1, dateStr.min, dateStr.sec, flag or "PM")
    local formatted2 = string.format("%02d/%02d/%04d", dateStr.day, dateStr.month, dateStr.year)
    -- Roblox service references
    local LocalizationService = game:GetService("LocalizationService")
    local localPlayer = game:GetService("Players").LocalPlayer
    local n9 = nil
    -- Bootstrap executor global environment and UI container
    local countryRegionCode

    if getgenv().countryRegionCode then
      countryRegionCode = getgenv().countryRegionCode
    else
      local v2, v3, ok

      ok, countryRegionCode = pcall(function()
        n9 = 1028702138
        return LocalizationService:GetCountryRegionForPlayerAsync(localPlayer)
      end)

      if ok then
        getgenv().countryRegionCode = countryRegionCode
      else
        getgenv().countryRegionCode = "Unknown"
      end
    end

    timeZoneParagraph:SetDesc(
      formatted2 .. " - " .. formatted .. " [ " .. countryRegionCode .. " ]"
    )
  end

  spawn(function()
    while true do
      UpdateOS()
      wait(1)
    end
  end)

  local n8 = nil

-- [[ leaked by YzZ ]]
  -- Helper routine (UpdateGameTime) — calls :SetDesc
  UpdateGameTime = function()
    n8 = 440584001
    local floor = math.floor(workspace.DistributedGameTime + 0.5)
    gameTimeParagraph:SetDesc(
      math.floor(floor / 3600) % 24
        .. " Hour (h) "
        .. math.floor(floor / 60) % 60
        .. " Minute (m) "
        .. math.floor(floor / 1) % 60
        .. " Second (s)"
    )
  end
end

spawn(function()
  while true do
    UpdateGameTime()
    wait(1)
  end
end)

do
  local mirageIslandParagraph = tbl.Info:AddParagraph("Mirage Island", "Status: ")
  local str = ""

  spawn(function()
    local n6 = nil
    local v2, v3, v4

    pcall(function()
      n6 = 74506917
      wait(1)
      local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") ~= nil

      if status then
        status = "✅"
      end

      while true do
        status = status or "❌"

        if status == str then
          wait(1)
          status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") ~= nil
          if status then
            status = "✅"
            continue
          end
          continue
        end

        break
      end

      while true do
        mirageIslandParagraph:SetDesc("Status: " .. status)
        str = status

        while true do
          wait(1)
          status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") ~= nil

          if status then
            status = "✅"
          end

          status = status or "❌"
          if status == str then
            continue
          end
          break
        end
      end
    end)
  end)
end

do
  local kitsuneIslandParagraph = tbl.Info:AddParagraph("Kitsune Island", "Status: ")
  local str = ""
  local n6 = nil
  local n7 = nil

  spawn(function()
    n6 = 922698428
    n7 = 811384937

    if task.wait(1) then
      repeat
        pcall(function()
          local kitsuneIsland = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland")

          if kitsuneIsland then
            kitsuneIsland = "✅"
          end

          kitsuneIsland = kitsuneIsland or "❌"

          if kitsuneIsland ~= str then
            kitsuneIslandParagraph:SetDesc("Status: " .. kitsuneIsland)
            str = kitsuneIsland
          end
        end)
      until not task.wait(1)
    end
  end)
end

do
  local prehistoricIslandParagraph = tbl.Info:AddParagraph("Prehistoric Island", "Status: ")
  local str = ""

  task.spawn(function()
    if task.wait(1) then
      repeat
        pcall(function()
          local prehistoricIsland =
            game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island")

          if prehistoricIsland then
            prehistoricIsland = "✅"
          end

          prehistoricIsland = prehistoricIsland or "❌"

          if prehistoricIsland ~= str then
            prehistoricIslandParagraph:SetDesc("Status: " .. prehistoricIsland)
            str = prehistoricIsland
          end
        end)
      until not task.wait(1)
    end
  end)
end

do
  local frozenDimensionParagraph = tbl.Info:AddParagraph("Frozen Dimension", "Status: ")
  local str = ""
  local n6 = nil
  local n7 = nil

  spawn(function()
    n6 = 353759688
    n7 = 895705536

    while wait(1) do
      pcall(function()
        local frozenDimension =
          game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension")

        if frozenDimension then
          frozenDimension = "✅"
        end

        frozenDimension = frozenDimension or "❌"

        if frozenDimension ~= str then
          frozenDimensionParagraph:SetDesc("Status: " .. frozenDimension)
          str = frozenDimension
        end
      end)
    end
  end)
end

do
  local cakePrinceParagraph = tbl.Info:AddParagraph("Cake Prince", "")
  local n6 = nil
  local n7 = nil

  spawn(function()
    n6 = 168425429
    n7 = 894392514

    if wait(1) then
      local exitTo = nil
      local v2, result, str

      while true do
        local ok

        ok, result = pcall(function()
          return game
            :GetService("ReplicatedStorage").Remotes.CommF_
            :InvokeServer("CakePrinceSpawner")
        end)

        str = "Cake Prince: ✅"
        if ok and type(result) == "string" then
          exitTo = 1
          break
        end
        cakePrinceParagraph:SetDesc(str)
        if wait(1) then
          continue
        end
        break
      end

      if exitTo == 1 then
        local exitTo2 = nil

        while true do
          if string.len(result) >= 86 then
            exitTo2 = 1
            break
          else
            local exitTo3 = nil

            while true do
              cakePrinceParagraph:SetDesc(str)

              if wait(1) then
                local ok

                ok, result = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("CakePrinceSpawner")
                end)

                if ok and type(result) == "string" then
                  exitTo3 = 1
                  break
                end
              else
                break
              end
            end

            if exitTo3 == 1 then
              continue
            end
            break
          end
        end

        if exitTo2 == 1 then
          while true do
            local str2 = "Killed: " .. string.sub(result, 39, 41)
            local exitTo4 = nil

            while true do
              cakePrinceParagraph:SetDesc(str2)

              if wait(1) then
                local ok

                ok, result = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("CakePrinceSpawner")
                end)

                str2 = "Cake Prince: ✅"
                if ok and type(result) == "string" and string.len(result) >= 86 then
                  exitTo4 = 1
                  break
                end
              else
                break
              end
            end

            if exitTo4 == 1 then
              continue
            end
            break
          end
        end
      end
    end
  end)
end

-- [[ leaked by YzZ ]]

do
  local ripIndraParagraph = tbl.Info:AddParagraph("Rip Indra", "Status: ")
  local str = ""
  local n6 = nil
  local n7 = nil

  spawn(function()
    n6 = 523463407
    n7 = 34355649
    local n8 = nil

    if wait(1) then
      repeat
        pcall(function()
          n8 = 724514294
          local status

          if game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") then
            status = "✅"
          else
            status = game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")

            if status then
              status = "✅"
            end

            status = status or "❌"
          end

          if status ~= str then
            ripIndraParagraph:SetDesc("Status: " .. status)
            str = status
          end
        end)
      until not wait(1)
    end
  end)
end

do
  local doughKingParagraph = tbl.Info:AddParagraph("Dough King", "Status: ")
  local str = ""

  spawn(function()
    local n6 = nil
    local v2, v3, v4, v5

    while wait(1) do
      pcall(function()
        n6 = 670121425
        local status

        if game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") then
          status = "✅"
        else
          status = game:GetService("Workspace").Enemies:FindFirstChild("Dough King")

          if status then
            status = "✅"
          end

          status = status or "❌"
        end

        if status ~= str then
          doughKingParagraph:SetDesc("Status: " .. status)
          str = status
        end
      end)
    end
  end)
end

local fullMoonParagraph = tbl.Info:AddParagraph("Full Moon", "")

task.spawn(function()
  if task.wait(1) then
    local v2, v3

    pcall(function()
      local moonTextureId = game:GetService("Lighting").Sky.MoonTextureId
      local str = "Moon: 0/5"

      if moonTextureId ~= "http://www.roblox.com/asset/?id=9709149431" then
        if moonTextureId ~= "http://www.roblox.com/asset/?id=9709149052" then
          if moonTextureId ~= "http://www.roblox.com/asset/?id=9709143733" then
            if moonTextureId ~= "http://www.roblox.com/asset/?id=9709150401" then
              if moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                str = "Moon: 1/5"
              end
            else
              str = "Moon: 2/5"
            end
          else
            str = "Moon: 3/5"
          end
        else
          str = "Moon: 4/5"
        end
      else
        str = "Moon: 5/5 (Full Moon) ✅"
      end

      fullMoonParagraph:SetDesc(str)
    end)

    while task.wait(1) do
      pcall(function()
        local moonTextureId = game:GetService("Lighting").Sky.MoonTextureId
        local str = "Moon: 0/5"

        if moonTextureId ~= "http://www.roblox.com/asset/?id=9709149431" then
          if moonTextureId ~= "http://www.roblox.com/asset/?id=9709149052" then
            if moonTextureId ~= "http://www.roblox.com/asset/?id=9709143733" then
              if moonTextureId ~= "http://www.roblox.com/asset/?id=9709150401" then
                if moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                  str = "Moon: 1/5"
                end
              else
                str = "Moon: 2/5"
              end
            else
              str = "Moon: 3/5"
            end
          else
            str = "Moon: 4/5"
          end
        else
          str = "Moon: 5/5 (Full Moon) ✅"
        end

        fullMoonParagraph:SetDesc(str)
      end)
    end
  end
end)

local legendarySwordParagraph = tbl.Info:AddParagraph("Legendary Sword", "Status: ")

spawn(function()
  local n6 = nil
  local n7 = nil

  if wait(5) then
    repeat
      pcall(function()
        n6 = 462927818
        n7 = 986923015
        local parts = {}
        local v2, v3, v4 = ipairs({ "Shizu", "Saishi", "Oroshi" })
        local iter_z_1 = (function(f, s, var)
          local co = coroutine.wrap(function()
            coroutine.yield()
            for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
              coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
            end
          end)
          co()
          return co
        end)(v3, v4)
        local packedValues = table.pack(iter_z_1())

        if packedValues[1] then
          local v6 = packedValues[3]
          local exitTo = nil

          while true do
            if GetWP(v6) then
              exitTo = 1
              break
            else
              local packedValues = table.pack(iter_z_1())
              if packedValues[1] then
                v6 = packedValues[3]
                continue
              end
              break
            end
          end

          if exitTo == 1 then
            while true do
              table.insert(parts, v6 .. " ✅")
              local exitTo2 = nil

              while true do
                local packedValues = table.pack(iter_z_1())

                if not packedValues[1] then
                  break
                else
                  v6 = packedValues[3]
                  if GetWP(v6) then
                    exitTo2 = 1
                    break
                  end
                end
              end

              if exitTo2 == 1 then
                continue
              end
              break
            end
          end
        end

        local legendarySwordParagraph2 = legendarySwordParagraph
        local setDesc = legendarySwordParagraph.SetDesc
        local str

        if #parts > 0 then
          str = table.concat(parts, ", ") or "Not Found"
        else
          str = "Not Found"
          setDesc(legendarySwordParagraph2, str)
          return
        end

        setDesc(legendarySwordParagraph2, str)
      end)
    until not wait(5)
  end
end)

do
  local boneParagraph = tbl.Info:AddParagraph("Bone", "")
  local n6 = nil
  local n7 = nil

  spawn(function()
    n6 = 556369206
    n7 = 878715967

    if wait(1) then
      repeat
        pcall(function()
          local response =
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
          boneParagraph:SetDesc("You Have: " .. tostring(response) .. " Bones")
        end)
      until not wait(1)
    end
  end)
end

WeaponDropdown = tbl.Main:AddDropdown({
  Name = "Select Weapon",
  Options = { "Melee", "Sword", "Blox Fruit", "Gun" },
  Default = "Melee",
  Callback = function(chooseWP)
    _G.ChooseWP = chooseWP
  end,
})

tbl.Main:AddDropdown({
  Name = "UI Scale",
  Options = { "Small", "Normal", "Big" },
  Default = "Normal",
  Callback = function(key)
    v:SetUIScale(({ Small = 0.8, Normal = 1, Big = 1.2 })[key])
  end,
})

tbl.Main:AddSection("Farming")

do
  local n6 = nil
  local n7 = nil

  FarmLevel = tbl.Main:AddToggle({
    Name = "Auto Farm Level",
    Description = "",
    Default = false,
    Callback = function(level)
      n6 = 611492828
      n7 = 508730066
      _G.Level = level

      if not level then
        alreadyTeleported = false
        teleporting = false
      end
    end,
  })
end

ClosetMons = tbl.Main:AddToggle({
  Name = "Auto Farm Nearest",
  Description = "",
  Default = false,
  Callback = function(autoFarmNear)
    _G.AutoFarmNear = autoFarmNear
  end,
})

FactoryRaids = tbl.Main:AddToggle({
  Name = "Auto Factory Raid",
  Description = "",
  Default = false,
  Callback = function(autoFactory)
    _G.AutoFactory = autoFactory
  end,
})

CastleRaids = tbl.Main:AddToggle({
  Name = "Auto Pirate Raid",
  Description = "",
  Default = false,
  Callback = function(autoRaidCastle)
    _G.AutoRaidCastle = autoRaidCastle
  end,
})

Ecto = tbl.Main:AddToggle({
  Name = "Auto Farm Ectoplasm",
  Description = "",
  Default = false,
  Callback = function(autoEctoplasm)
    _G.AutoEctoplasm = autoEctoplasm
  end,
})

tbl.Main:AddSection("Chest")
local n6 = nil

ChestTW = tbl.Main:AddToggle({
  Name = "Auto Farm Chest",
  Description = "",
  Default = false,
  Callback = function(autoFarmChest)
    n6 = 60850868
    _G.AutoFarmChest = autoFarmChest
  end,
})

local n7 = nil

ChestBP = tbl.Main:AddToggle({
  Name = "Auto Chest Bypass",
  Description = "",
  Default = false,
  Callback = function(autoChestBP)
    n7 = 329955782
    _G.AutoChestBP = autoChestBP
    local n8 = nil
    local n9 = nil
    local n10 = nil
    local n11 = nil

    if autoChestBP then
      local localPlayer = game:GetService("Players").LocalPlayer
      local flag = false
      local list = {}
      local flag2 = true

      -- Helper routine (fn) — calls :Wait, :WaitForChild
      local function fn()
        if not localPlayer.Character then
          localPlayer.CharacterAdded:Wait()
        end

        localPlayer.Character:WaitForChild("HumanoidRootPart")
        return localPlayer.Character
      end

      -- Helper routine (fn2) — calls :GetDescendants
      local function fn2()
        n9 = 895961618
        local iter_z_1

        if flag2 then
          flag2 = false
          local v2, v3, v4 = pairs(game:GetDescendants())
          iter_z_1 = (function(f, s, var)
            local co = coroutine.wrap(function()
              coroutine.yield()
              for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
                coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
              end
            end)
            co()
            return co
          end)(v3, v4)
          local exitTo = nil
          local v5

          while true do
            local packedValues = table.pack(iter_z_1())

            if not packedValues[1] then
              break
            else
              v5 = packedValues[3]
              if v5.Name:find("Chest") and v5.ClassName == "Part" then
                exitTo = 1
                break
              end
            end
          end

          if exitTo == 1 then
            while true do
              table.insert(list, v5)
              local exitTo2 = nil

              while true do
                local packedValues = table.pack(iter_z_1())

                if not packedValues[1] then
                  break
                else
                  v5 = packedValues[3]
                  if v5.Name:find("Chest") and v5.ClassName == "Part" then
                    exitTo2 = 1
                    break
                  end
                end
              end

              if exitTo2 == 1 then
                continue
              end
              break
            end
          end
        end

        local list2 = {}
        local v2, v3, v4 = pairs(list)
        iter_z_1 = (function(f, s, var)
          local co = coroutine.wrap(function()
            coroutine.yield()
            for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
              coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
            end
          end)
          co()
          return co
        end)(v3, v4)
        local lowerTorso, v5

        while true do
          local packedValues = table.pack(iter_z_1())

          if not packedValues[1] then
            break
          else
            local v7 = packedValues[3]

            if v7:FindFirstChild("TouchInterest") then
              while true do
                table.insert(list2, v7)
                local exitTo3 = nil

                while true do
                  local packedValues = table.pack(iter_z_1())

                  if not packedValues[1] then
                    break
                  else
                    v7 = packedValues[3]
                    if v7:FindFirstChild("TouchInterest") then
                      exitTo3 = 1
                      break
                    end
                  end
                end

                if exitTo3 == 1 then
                  continue
                end
                break
              end

              lowerTorso = fn().LowerTorso

              table.sort(list2, function(arg, arg2)
                return (lowerTorso.Position - arg.Position).Magnitude
                  < (lowerTorso.Position - arg2.Position).Magnitude
              end)

              return list2
            end
          end
        end

        lowerTorso = fn().LowerTorso

        table.sort(list2, function(arg, arg2)
          return (lowerTorso.Position - arg.Position).Magnitude
            < (lowerTorso.Position - arg2.Position).Magnitude
        end)

        return list2
      end

      local function fn3()
        n10 = 1043683424
        n11 = 156228063
        if flag then
          return
        end
        flag = true

        task.spawn(function()
          while _G.AutoChestBP do
            if localPlayer.Character and localPlayer.Character.Parent then
              local v2 = fn2()

              if #v2 > 0 then
                local humanoidRootPart = fn().HumanoidRootPart

                while true do
                  humanoidRootPart.CFrame = v2[1].CFrame
                  local exitTo = nil

                  while true do
                    task.wait(0.1)

                    if _G.AutoChestBP then
                      if localPlayer.Character and localPlayer.Character.Parent then
                        v2 = fn2()

                        if #v2 > 0 then
                          exitTo = 1
                          break
                        else
                          continue
                        end
                      end

                      break
                    else
                      break
                    end
                  end

                  if exitTo == 1 then
                    humanoidRootPart = fn().HumanoidRootPart
                    continue
                  end
                  break
                end

                flag = false
                return
              else
                task.wait(0.1)
                continue
              end
            end

            break
          end

          flag = false
        end)
      end

      -- Event listener: CharacterAdded:Connect
      localPlayer.CharacterAdded:Connect(function()
        n8 = 947579463
        fn()
        task.wait(0.5)

        if _G.AutoChestBP then
          fn3()
        end
      end)

      fn3()
    end
  end,
})

StopI = tbl.Main:AddToggle({
  Name = "Stop Items",
  Description = "",
  Default = true,
  Callback = function(stopWhenChalice)
    _G.StopWhenChalice = stopWhenChalice
  end,
})

tbl.Main:AddSection("Collect Berry")

do
  local n8 = nil
  local n9 = nil

  Berry = tbl.Main:AddToggle({
    Name = "Auto Farm Berry",
    Description = "",
    Default = false,
    Callback = function(autoBerry)
      n8 = 753131424
      n9 = 207512129
      _G.AutoBerry = autoBerry
    end,
  })
end

BerryH = tbl.Main:AddToggle({
  Name = "Auto Farm Berry + Hop",
  Description = "",
  Default = false,
  Callback = function(autoBerryH)
    _G.AutoBerryH = autoBerryH
  end,
})

tbl.Main:AddSection("Farm Mob")

do
  local n8 = nil
  local n9 = nil

  if World1 then
    tbl.Main:AddDropdown({
      Name = "Select Mob",
      Default = Bandit,
      Options = {
        "Bandit",
        "Monkey",
        "Gorilla",
        "Pirate",
        "Brute",
        "Desert Bandit",
        "Desert Officer",
        "Snow Bandit",
        "Snowman",
        "Chief Petty Officer",
        "Sky Bandit",
        "Dark Master",
        "Toga Warrior",
        "Gladiator",
        "Military Soldier",
        "Military Spy",
        "Fishman Warrior",
        "Fishman Commando",
        "God's Guard",
        "Shanda",
        "Royal Squad",
        "Royal Soldier",
        "Galley Pirate",
        "Galley Captain",
      },
      Callback = function(selectMob)
        n8 = 807550778
        n9 = 681975705
        getgenv().SelectMob = selectMob
      end,
    })
  end
end

do
  local n8 = nil
  local n9 = nil

  if World2 then
    tbl.Main:AddDropdown({
      Name = "Select Mob",
      Default = Raider,
      Options = {
        "Raider",
        "Mercenary",
        "Swan Pirate",
        "Factory Staff",
        "Marine Lieutenant",
        "Marine Captain",
        "Zombie",
        "Vampire",
        "Snow Trooper",
        "Winter Warrior",
        "Lab Subordinate",
        "Horned Warrior",
        "Magma Ninja",
        "Lava Pirate",
        "Ship Deckhand",
        "Ship Engineer",
        "Ship Steward",
        "Ship Officer",
        "Arctic Warrior",
        "Snow Lurker",
        "Sea Soldier",
        "Water Fighter",
      },
      Callback = function(selectMob)
        n8 = 585691261
        n9 = 398263946
        getgenv().SelectMob = selectMob
      end,
    })
  end
end

if World3 then
  tbl.Main:AddDropdown({
    Name = "Select Mob",
    Options = {
      "Pirate Millionaire",
      "Dragon Crew Warrior",
      "Dragon Crew Archer",
      "Female Islander",
      "Giant Islander",
      "Marine Commodore",
      "Marine Rear Admiral",
      "Fishman Raider",
      "Fishman Captain",
      "Forest Pirate",
      "Mythological Pirate",
      "Jungle Pirate",
      "Musketeer Pirate",
      "Reborn Skeleton",
      "Living Zombie",
      "Demonic Soul",
      "Posessed Mummy",
      "Peanut Scout",
      "Peanut President",
      "Ice Cream Chef",
      "Ice Cream Commander",
      "Cookie Crafter",
      "Cake Guard",
      "Baking Staff",
      "Head Baker",
      "Cocoa Warrior",
      "Chocolate Bar Battler",
      "Sweet Thief",
      "Candy Rebel",
      "Candy Pirate",
      "Snow Demon",
      "Isle Outlaw",
      "Island Boy",
      "Sun-kissed Warrior",
      "Isle Champion",
    },
    Callback = function(selectMob)
      getgenv().SelectMob = selectMob
    end,
  })
end

tbl.Main:AddToggle({
  Name = "Auto Kill Mob",
  Default = false,
  Callback = function(autoKillMob)
    _G.AutoKillMob = autoKillMob
  end,
})

tbl.Main:AddSection("Farm All Island")

local function fn()
  local list = {}
  local v2, v3, v4 = pairs(Core.Island or {})
  local iter_z_1 = (function(f, s, var)
    local co = coroutine.wrap(function()
      coroutine.yield()
      for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
        coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
      end
    end)
    co()
    return co
  end)(v3, v4)

  while true do
    local packedValues = table.pack(iter_z_1())

    if not packedValues[1] then
      break
    else
      table.insert(list, packedValues[2])
    end
  end

  table.sort(list)
  return list
end

tbl.Main:AddDropdown({
  Name = "Select Island",
  Options = fn(),
  Callback = function(selectIsland)
    _G.SelectIsland = selectIsland
  end,
})

tbl.Main:AddToggle({
  Name = "Auto Farm All Island",
  Default = false,
  Callback = function(autoFarmIsland)
    _G.AutoFarmIsland = autoFarmIsland
  end,
})

tbl.Main:AddSection("Farm Elite Hunter")
local elitesProcessParagraph = tbl.Main:AddParagraph("Elites Process", "")

spawn(function()
  local n8 = nil

  if wait(Sec) then
    local v2, v3, v4

    repeat
      pcall(function()
        n8 = 447457440
        elitesProcessParagraph:SetDesc(
          "Elite Progress : "
            .. tostring(replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") or 0)
        )
      end)
    until not wait(Sec)
  end
end)

local eliteSpawnParagraph = tbl.Main:AddParagraph("Elite Spawn", "Status: ")

spawn(function()
  local str = ""

  if wait(1) then
    local str2, v2, eliteSpawnParagraph2, v3, ok, result, tostringFn, ok2, str22, exitTo, ok3, result2, tostringFn9, ok4, exitTo3, urban, exitTo2, ok5, result3, tostringFn8, ok6, exitTo5, enemies, exitTo4, ok7, result4, tostringFn7, ok8, diablo, exitTo8, deandre, exitTo7, exitTo6, ok9, result5, tostringFn6, ok10, diablo2, Workspace, urban2, exitTo9, ok11, result6, tostringFn2, ok12, v10, setDesc, status, diablo3, diablo4

    if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
      str2 = "✅"

      ok, result = pcall(function()
        return game
          :GetService("ReplicatedStorage").Remotes.CommF_
          :InvokeServer("EliteHunter", "Progress")
      end)

      tostringFn = tostring
      ok2 = ok

      if ok2 then
        ok2 = result
      end

      ok2 = ok2 or 0
      local v11 = tostringFn(ok2)
      eliteSpawnParagraph:SetDesc("Status: " .. str2 .. " | Killed: " .. v11)
      str22 = str2
      exitTo = nil

      while wait(1) do
        local diablo5 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
          or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")

        if diablo5 then
          ok3, result2 = pcall(function()
            return game
              :GetService("ReplicatedStorage").Remotes.CommF_
              :InvokeServer("EliteHunter", "Progress")
          end)

          tostringFn9 = tostring
          ok4 = ok3

          if ok4 then
            ok4 = result2
          end

          ok4 = ok4 or 0
          tostringFn9(ok4)
        else
          exitTo = 1
          break
        end
      end

      if exitTo == 1 then
        exitTo3 = nil

        while true do
          urban = game:GetService("ReplicatedStorage"):FindFirstChild("Urban")
          exitTo2 = nil

          while true do
            if urban then
              ok5, result3 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn8 = tostring
              ok6 = ok5

              if ok6 then
                ok6 = result3
              end

              ok6 = ok6 or 0
              tostringFn8(ok6)

              if wait(1) then
                urban = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")

                if urban then
                  continue
                else
                  exitTo2 = 2
                  break
                end
              end

              break
            else
              exitTo2 = 1
              break
            end
          end

          if exitTo2 == 1 then
            exitTo3 = 1
            break
          elseif exitTo2 == 2 then
            continue
          end

          break
        end

        if exitTo3 == 1 then
          exitTo5 = nil

          while true do
            enemies = game:GetService("Workspace").Enemies

            if enemies:FindFirstChild("Diablo") then
              exitTo4 = nil

              while true do
                ok7, result4 = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("EliteHunter", "Progress")
                end)

                tostringFn7 = tostring
                ok8 = ok7

                if ok8 then
                  ok8 = result4
                end

                ok8 = ok8 or 0
                tostringFn7(ok8)

                if wait(1) then
                  diablo = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                  if diablo then
                    continue
                  else
                    exitTo4 = 1
                    break
                  end
                end

                break
              end

              if exitTo4 == 1 then
                continue
              end
              break
            else
              exitTo5 = 1
              break
            end
          end

          if exitTo5 == 1 then
            exitTo8 = nil

            while true do
              deandre = game:GetService("Workspace").Enemies:FindFirstChild("Deandre")
              exitTo7 = nil

              while true do
                if deandre then
                  exitTo6 = nil

                  while true do
                    ok9, result5 = pcall(function()
                      return game
                        :GetService("ReplicatedStorage").Remotes.CommF_
                        :InvokeServer("EliteHunter", "Progress")
                    end)

                    tostringFn6 = tostring
                    ok10 = ok9

                    if ok10 then
                      ok10 = result5
                    end

                    ok10 = ok10 or 0
                    tostringFn6(ok10)

                    if wait(1) then
                      diablo2 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                        or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                        or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                      if diablo2 then
                        continue
                      else
                        exitTo6 = 1
                        break
                      end
                    end

                    break
                  end

                  if exitTo6 == 1 then
                    deandre = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")

                    if deandre then
                      continue
                    else
                      exitTo7 = 2
                      break
                    end
                  end

                  break
                else
                  exitTo7 = 1
                  break
                end
              end

              if exitTo7 == 1 then
                exitTo8 = 1
                break
              elseif exitTo7 == 2 then
                continue
              end

              break
            end

            if exitTo8 == 1 then
              Workspace = game:GetService("Workspace")

              while true do
                urban2 = Workspace.Enemies:FindFirstChild("Urban")

                if urban2 then
                  urban2 = "✅"
                end

                urban2 = urban2 or "❌"
                exitTo9 = nil

                while true do
                  ok11, result6 = pcall(function()
                    return game
                      :GetService("ReplicatedStorage").Remotes.CommF_
                      :InvokeServer("EliteHunter", "Progress")
                  end)

                  tostringFn2 = tostring
                  ok12 = ok11

                  if ok12 then
                    ok12 = result6
                  end

                  ok12 = ok12 or 0
                  v10 = tostringFn2(ok12)

                  if urban2 ~= str22 then
                    eliteSpawnParagraph2 = eliteSpawnParagraph
                    setDesc = eliteSpawnParagraph.SetDesc
                    status = urban2 .. " | Killed: " .. v10
                    setDesc(eliteSpawnParagraph2, "Status: " .. status)
                    str22 = urban2
                  end

                  if wait(1) then
                    diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                    if diablo3 then
                      urban2 = "✅"
                      continue
                    else
                      diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                        or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

                      if diablo4 then
                        urban2 = "✅"
                        continue
                      else
                        exitTo9 = 1
                        break
                      end
                    end
                  end

                  break
                end

                if exitTo9 == 1 then
                  Workspace = game:GetService("Workspace")
                  continue
                end
                break
              end
            end
          end
        end
      end
    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
      str2 = "✅"

      ok, result = pcall(function()
        return game
          :GetService("ReplicatedStorage").Remotes.CommF_
          :InvokeServer("EliteHunter", "Progress")
      end)

      tostringFn = tostring
      ok2 = ok

      if ok2 then
        ok2 = result
      end

      eliteSpawnParagraph:SetDesc("Status: " .. str2 .. " | Killed: " .. tostringFn(ok2 or 0))
      str22 = str2
      exitTo = nil

      while wait(1) do
        if
          game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
          or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
        then
          ok3, result2 = pcall(function()
            return game
              :GetService("ReplicatedStorage").Remotes.CommF_
              :InvokeServer("EliteHunter", "Progress")
          end)

          tostringFn9 = tostring
          ok4 = ok3

          if ok4 then
            ok4 = result2
          end

          tostringFn9(ok4 or 0)
        else
          exitTo = 1
          break
        end
      end

      if exitTo == 1 then
        exitTo3 = nil

        while true do
          urban = game:GetService("ReplicatedStorage"):FindFirstChild("Urban")
          exitTo2 = nil

          while true do
            if urban then
              ok5, result3 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn8 = tostring
              ok6 = ok5

              if ok6 then
                ok6 = result3
              end

              ok6 = ok6 or 0
              tostringFn8(ok6)

              if wait(1) then
                urban = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")

                if urban then
                  continue
                else
                  exitTo2 = 2
                  break
                end
              end

              break
            else
              exitTo2 = 1
              break
            end
          end

          if exitTo2 == 1 then
            exitTo3 = 1
            break
          elseif exitTo2 == 2 then
            continue
          end

          break
        end

        if exitTo3 == 1 then
          exitTo5 = nil

          while true do
            enemies = game:GetService("Workspace").Enemies

            if enemies:FindFirstChild("Diablo") then
              exitTo4 = nil

              while true do
                ok7, result4 = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("EliteHunter", "Progress")
                end)

                tostringFn7 = tostring
                ok8 = ok7

                if ok8 then
                  ok8 = result4
                end

                ok8 = ok8 or 0
                tostringFn7(ok8)

                if wait(1) then
                  diablo = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                  if diablo then
                    continue
                  else
                    exitTo4 = 1
                    break
                  end
                end

                break
              end

              if exitTo4 == 1 then
                continue
              end
              break
            else
              exitTo5 = 1
              break
            end
          end

          if exitTo5 == 1 then
            exitTo8 = nil

            while true do
              deandre = game:GetService("Workspace").Enemies:FindFirstChild("Deandre")
              exitTo7 = nil

              while true do
                if deandre then
                  exitTo6 = nil

                  while true do
                    ok9, result5 = pcall(function()
                      return game
                        :GetService("ReplicatedStorage").Remotes.CommF_
                        :InvokeServer("EliteHunter", "Progress")
                    end)

                    tostringFn6 = tostring
                    ok10 = ok9

                    if ok10 then
                      ok10 = result5
                    end

                    ok10 = ok10 or 0
                    tostringFn6(ok10)

                    if wait(1) then
                      diablo2 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                        or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                        or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                      if diablo2 then
                        continue
                      else
                        exitTo6 = 1
                        break
                      end
                    end

                    break
                  end

                  if exitTo6 == 1 then
                    deandre = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")

                    if deandre then
                      continue
                    else
                      exitTo7 = 2
                      break
                    end
                  end

                  break
                else
                  exitTo7 = 1
                  break
                end
              end

              if exitTo7 == 1 then
                exitTo8 = 1
                break
              elseif exitTo7 == 2 then
                continue
              end

              break
            end

            if exitTo8 == 1 then
              Workspace = game:GetService("Workspace")

              while true do
                urban2 = Workspace.Enemies:FindFirstChild("Urban")

                if urban2 then
                  urban2 = "✅"
                end

                urban2 = urban2 or "❌"
                exitTo9 = nil

                while true do
                  ok11, result6 = pcall(function()
                    return game
                      :GetService("ReplicatedStorage").Remotes.CommF_
                      :InvokeServer("EliteHunter", "Progress")
                  end)

                  tostringFn2 = tostring
                  ok12 = ok11

                  if ok12 then
                    ok12 = result6
                  end

                  ok12 = ok12 or 0
                  v10 = tostringFn2(ok12)

                  if urban2 ~= str22 then
                    eliteSpawnParagraph2 = eliteSpawnParagraph
                    setDesc = eliteSpawnParagraph.SetDesc
                    status = urban2 .. " | Killed: " .. v10
                    setDesc(eliteSpawnParagraph2, "Status: " .. status)
                    str22 = urban2
                  end

                  if wait(1) then
                    diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                    if diablo3 then
                      urban2 = "✅"
                      continue
                    else
                      diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                        or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

                      if diablo4 then
                        urban2 = "✅"
                        continue
                      else
                        exitTo9 = 1
                        break
                      end
                    end
                  end

                  break
                end

                if exitTo9 == 1 then
                  Workspace = game:GetService("Workspace")
                  continue
                end
                break
              end
            end
          end
        end
      end
    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
      local str3 = "✅"

      local ok, result = pcall(function()
        return game
          :GetService("ReplicatedStorage").Remotes.CommF_
          :InvokeServer("EliteHunter", "Progress")
      end)

      local tostringFn3 = tostring
      local ok = ok

      if ok then
        ok = result
      end

      eliteSpawnParagraph:SetDesc("Status: " .. str3 .. " | Killed: " .. tostringFn3(ok or 0))
      str22 = str3
      local exitTo10 = nil

      while wait(1) do
        urban = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
          or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")

        if urban then
          if urban then
            ok5, result3 = pcall(function()
              return game
                :GetService("ReplicatedStorage").Remotes.CommF_
                :InvokeServer("EliteHunter", "Progress")
            end)

            tostringFn8 = tostring
            ok6 = ok5

            if ok6 then
              ok6 = result3
            end

            ok6 = ok6 or 0
            tostringFn8(ok6)
          else
            exitTo10 = 2
            break
          end
        else
          exitTo10 = 1
          break
        end
      end

      if exitTo10 == 1 then
        exitTo3 = nil

        while true do
          urban = game:GetService("ReplicatedStorage"):FindFirstChild("Urban")
          exitTo2 = nil

          while true do
            if urban then
              ok5, result3 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn8 = tostring
              ok6 = ok5

              if ok6 then
                ok6 = result3
              end

              ok6 = ok6 or 0
              tostringFn8(ok6)

              if wait(1) then
                urban = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")

                if urban then
                  continue
                else
                  exitTo2 = 2
                  break
                end
              end

              break
            else
              exitTo2 = 1
              break
            end
          end

          if exitTo2 == 1 then
            exitTo3 = 1
            break
          elseif exitTo2 == 2 then
            continue
          end

          break
        end

        if exitTo3 == 1 then
          exitTo5 = nil

          while true do
            enemies = game:GetService("Workspace").Enemies

            if enemies:FindFirstChild("Diablo") then
              exitTo4 = nil

              while true do
                ok7, result4 = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("EliteHunter", "Progress")
                end)

                tostringFn7 = tostring
                ok8 = ok7

                if ok8 then
                  ok8 = result4
                end

                ok8 = ok8 or 0
                tostringFn7(ok8)

                if wait(1) then
                  diablo = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                  if diablo then
                    continue
                  else
                    exitTo4 = 1
                    break
                  end
                end

                break
              end

              if exitTo4 == 1 then
                continue
              end
              break
            else
              exitTo5 = 1
              break
            end
          end

          if exitTo5 == 1 then
            exitTo8 = nil

            while true do
              deandre = game:GetService("Workspace").Enemies:FindFirstChild("Deandre")
              exitTo7 = nil

              while true do
                if deandre then
                  exitTo6 = nil

                  while true do
                    ok9, result5 = pcall(function()
                      return game
                        :GetService("ReplicatedStorage").Remotes.CommF_
                        :InvokeServer("EliteHunter", "Progress")
                    end)

                    tostringFn6 = tostring
                    ok10 = ok9

                    if ok10 then
                      ok10 = result5
                    end

                    ok10 = ok10 or 0
                    tostringFn6(ok10)

                    if wait(1) then
                      diablo2 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                        or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                        or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                      if diablo2 then
                        continue
                      else
                        exitTo6 = 1
                        break
                      end
                    end

                    break
                  end

                  if exitTo6 == 1 then
                    deandre = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")

                    if deandre then
                      continue
                    else
                      exitTo7 = 2
                      break
                    end
                  end

                  break
                else
                  exitTo7 = 1
                  break
                end
              end

              if exitTo7 == 1 then
                exitTo8 = 1
                break
              elseif exitTo7 == 2 then
                continue
              end

              break
            end

            if exitTo8 == 1 then
              Workspace = game:GetService("Workspace")

              while true do
                urban2 = Workspace.Enemies:FindFirstChild("Urban")

                if urban2 then
                  urban2 = "✅"
                end

                urban2 = urban2 or "❌"
                exitTo9 = nil

                while true do
                  ok11, result6 = pcall(function()
                    return game
                      :GetService("ReplicatedStorage").Remotes.CommF_
                      :InvokeServer("EliteHunter", "Progress")
                  end)

                  tostringFn2 = tostring
                  ok12 = ok11

                  if ok12 then
                    ok12 = result6
                  end

                  ok12 = ok12 or 0
                  v10 = tostringFn2(ok12)

                  if urban2 ~= str22 then
                    eliteSpawnParagraph2 = eliteSpawnParagraph
                    setDesc = eliteSpawnParagraph.SetDesc
                    status = urban2 .. " | Killed: " .. v10
                    setDesc(eliteSpawnParagraph2, "Status: " .. status)
                    str22 = urban2
                  end

                  if wait(1) then
                    diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                    if diablo3 then
                      urban2 = "✅"
                      continue
                    else
                      diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                        or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

                      if diablo4 then
                        urban2 = "✅"
                        continue
                      else
                        exitTo9 = 1
                        break
                      end
                    end
                  end

                  break
                end

                if exitTo9 == 1 then
                  Workspace = game:GetService("Workspace")
                  continue
                end
                break
              end
            end
          end
        end
      elseif exitTo10 == 2 then
        exitTo5 = nil

        while true do
          enemies = game:GetService("Workspace").Enemies

          if enemies:FindFirstChild("Diablo") then
            exitTo4 = nil

            while true do
              ok7, result4 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn7 = tostring
              ok8 = ok7

              if ok8 then
                ok8 = result4
              end

              ok8 = ok8 or 0
              tostringFn7(ok8)

              if wait(1) then
                diablo = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                if diablo then
                  continue
                else
                  exitTo4 = 1
                  break
                end
              end

              break
            end

            if exitTo4 == 1 then
              continue
            end
            break
          else
            exitTo5 = 1
            break
          end
        end

        if exitTo5 == 1 then
          exitTo8 = nil

          while true do
            deandre = game:GetService("Workspace").Enemies:FindFirstChild("Deandre")
            exitTo7 = nil

            while true do
              if deandre then
                exitTo6 = nil

                while true do
                  ok9, result5 = pcall(function()
                    return game
                      :GetService("ReplicatedStorage").Remotes.CommF_
                      :InvokeServer("EliteHunter", "Progress")
                  end)

                  tostringFn6 = tostring
                  ok10 = ok9

                  if ok10 then
                    ok10 = result5
                  end

                  ok10 = ok10 or 0
                  tostringFn6(ok10)

                  if wait(1) then
                    diablo2 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                    if diablo2 then
                      continue
                    else
                      exitTo6 = 1
                      break
                    end
                  end

                  break
                end

                if exitTo6 == 1 then
                  deandre = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")

                  if deandre then
                    continue
                  else
                    exitTo7 = 2
                    break
                  end
                end

                break
              else
                exitTo7 = 1
                break
              end
            end

            if exitTo7 == 1 then
              exitTo8 = 1
              break
            elseif exitTo7 == 2 then
              continue
            end

            break
          end

          if exitTo8 == 1 then
            Workspace = game:GetService("Workspace")

            while true do
              urban2 = Workspace.Enemies:FindFirstChild("Urban")

              if urban2 then
                urban2 = "✅"
              end

              urban2 = urban2 or "❌"
              exitTo9 = nil

              while true do
                ok11, result6 = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("EliteHunter", "Progress")
                end)

                tostringFn2 = tostring
                ok12 = ok11

                if ok12 then
                  ok12 = result6
                end

                ok12 = ok12 or 0
                v10 = tostringFn2(ok12)

                if urban2 ~= str22 then
                  eliteSpawnParagraph2 = eliteSpawnParagraph
                  setDesc = eliteSpawnParagraph.SetDesc
                  status = urban2 .. " | Killed: " .. v10
                  setDesc(eliteSpawnParagraph2, "Status: " .. status)
                  str22 = urban2
                end

                if wait(1) then
                  diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                  if diablo3 then
                    urban2 = "✅"
                    continue
                  else
                    diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                      or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

                    if diablo4 then
                      urban2 = "✅"
                      continue
                    else
                      exitTo9 = 1
                      break
                    end
                  end
                end

                break
              end

              if exitTo9 == 1 then
                Workspace = game:GetService("Workspace")
                continue
              end
              break
            end
          end
        end
      end
    elseif game:GetService("Workspace").Enemies:FindFirstChild("Diablo") then
      local str3 = "✅"

      local ok, result = pcall(function()
        return game
          :GetService("ReplicatedStorage").Remotes.CommF_
          :InvokeServer("EliteHunter", "Progress")
      end)

      local tostringFn4 = tostring
      local ok = ok

      if ok then
        ok = result
      end

      eliteSpawnParagraph:SetDesc("Status: " .. str3 .. " | Killed: " .. tostringFn4(ok or 0))
      str22 = str3
      local exitTo11 = nil

      while wait(1) do
        diablo = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
          or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
          or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

        if diablo then
          ok7, result4 = pcall(function()
            return game
              :GetService("ReplicatedStorage").Remotes.CommF_
              :InvokeServer("EliteHunter", "Progress")
          end)

          tostringFn7 = tostring
          ok8 = ok7

          if ok8 then
            ok8 = result4
          end

          ok8 = ok8 or 0
          tostringFn7(ok8)
        else
          exitTo11 = 1
          break
        end
      end

      if exitTo11 == 1 then
        exitTo5 = nil

        while true do
          if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") then
            exitTo4 = nil

            while true do
              ok7, result4 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn7 = tostring
              ok8 = ok7

              if ok8 then
                ok8 = result4
              end

              ok8 = ok8 or 0
              tostringFn7(ok8)

              if wait(1) then
                diablo = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                if diablo then
                  continue
                else
                  exitTo4 = 1
                  break
                end
              end

              break
            end

            if exitTo4 == 1 then
              continue
            end
            break
          else
            exitTo5 = 1
            break
          end
        end

        if exitTo5 == 1 then
          exitTo8 = nil

          while true do
            deandre = game:GetService("Workspace").Enemies:FindFirstChild("Deandre")
            exitTo7 = nil

            while true do
              if deandre then
                exitTo6 = nil

                while true do
                  ok9, result5 = pcall(function()
                    return game
                      :GetService("ReplicatedStorage").Remotes.CommF_
                      :InvokeServer("EliteHunter", "Progress")
                  end)

                  tostringFn6 = tostring
                  ok10 = ok9

                  if ok10 then
                    ok10 = result5
                  end

                  ok10 = ok10 or 0
                  tostringFn6(ok10)

                  if wait(1) then
                    diablo2 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                      or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                    if diablo2 then
                      continue
                    else
                      exitTo6 = 1
                      break
                    end
                  end

                  break
                end

                if exitTo6 == 1 then
                  deandre = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")

                  if deandre then
                    continue
                  else
                    exitTo7 = 2
                    break
                  end
                end

                break
              else
                exitTo7 = 1
                break
              end
            end

            if exitTo7 == 1 then
              exitTo8 = 1
              break
            elseif exitTo7 == 2 then
              continue
            end

            break
          end

          if exitTo8 == 1 then
            Workspace = game:GetService("Workspace")

            while true do
              urban2 = Workspace.Enemies:FindFirstChild("Urban")

              if urban2 then
                urban2 = "✅"
              end

              urban2 = urban2 or "❌"
              exitTo9 = nil

              while true do
                ok11, result6 = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("EliteHunter", "Progress")
                end)

                tostringFn2 = tostring
                ok12 = ok11

                if ok12 then
                  ok12 = result6
                end

                ok12 = ok12 or 0
                v10 = tostringFn2(ok12)

                if urban2 ~= str22 then
                  eliteSpawnParagraph2 = eliteSpawnParagraph
                  setDesc = eliteSpawnParagraph.SetDesc
                  status = urban2 .. " | Killed: " .. v10
                  setDesc(eliteSpawnParagraph2, "Status: " .. status)
                  str22 = urban2
                end

                if wait(1) then
                  diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                  if diablo3 then
                    urban2 = "✅"
                    continue
                  else
                    diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                      or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

                    if diablo4 then
                      urban2 = "✅"
                      continue
                    else
                      exitTo9 = 1
                      break
                    end
                  end
                end

                break
              end

              if exitTo9 == 1 then
                Workspace = game:GetService("Workspace")
                continue
              end
              break
            end
          end
        end
      end
    elseif game:GetService("Workspace").Enemies:FindFirstChild("Deandre") then
      local str3 = "✅"

      local ok, result = pcall(function()
        return game
          :GetService("ReplicatedStorage").Remotes.CommF_
          :InvokeServer("EliteHunter", "Progress")
      end)

      local tostringFn5 = tostring
      local ok = ok

      if ok then
        ok = result
      end

      eliteSpawnParagraph:SetDesc("Status: " .. str3 .. " | Killed: " .. tostringFn5(ok or 0))
      str22 = str3
      local exitTo12 = nil

      while wait(1) do
        diablo2 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
          or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
          or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

        if diablo2 then
          ok9, result5 = pcall(function()
            return game
              :GetService("ReplicatedStorage").Remotes.CommF_
              :InvokeServer("EliteHunter", "Progress")
          end)

          tostringFn6 = tostring
          ok10 = ok9

          if ok10 then
            ok10 = result5
          end

          ok10 = ok10 or 0
          tostringFn6(ok10)
        else
          deandre = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")

          if deandre then
            if deandre then
              ok9, result5 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn6 = tostring
              ok10 = ok9

              if ok10 then
                ok10 = result5
              end

              ok10 = ok10 or 0
              tostringFn6(ok10)
            else
              exitTo12 = 2
              break
            end
          else
            exitTo12 = 1
            break
          end
        end
      end

      if exitTo12 == 1 then
        exitTo8 = nil

        while true do
          deandre = game:GetService("Workspace").Enemies:FindFirstChild("Deandre")
          exitTo7 = nil

          while true do
            if deandre then
              exitTo6 = nil

              while true do
                ok9, result5 = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("EliteHunter", "Progress")
                end)

                tostringFn6 = tostring
                ok10 = ok9

                if ok10 then
                  ok10 = result5
                end

                ok10 = ok10 or 0
                tostringFn6(ok10)

                if wait(1) then
                  diablo2 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                    or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                  if diablo2 then
                    continue
                  else
                    exitTo6 = 1
                    break
                  end
                end

                break
              end

              if exitTo6 == 1 then
                deandre = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")

                if deandre then
                  continue
                else
                  exitTo7 = 2
                  break
                end
              end

              break
            else
              exitTo7 = 1
              break
            end
          end

          if exitTo7 == 1 then
            exitTo8 = 1
            break
          elseif exitTo7 == 2 then
            continue
          end

          break
        end

        if exitTo8 == 1 then
          Workspace = game:GetService("Workspace")

          while true do
            urban2 = Workspace.Enemies:FindFirstChild("Urban")

            if urban2 then
              urban2 = "✅"
            end

            urban2 = urban2 or "❌"
            exitTo9 = nil

            while true do
              ok11, result6 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn2 = tostring
              ok12 = ok11

              if ok12 then
                ok12 = result6
              end

              ok12 = ok12 or 0
              v10 = tostringFn2(ok12)

              if urban2 ~= str22 then
                eliteSpawnParagraph2 = eliteSpawnParagraph
                setDesc = eliteSpawnParagraph.SetDesc
                status = urban2 .. " | Killed: " .. v10
                setDesc(eliteSpawnParagraph2, "Status: " .. status)
                str22 = urban2
              end

              if wait(1) then
                diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                if diablo3 then
                  urban2 = "✅"
                  continue
                else
                  diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                    or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

                  if diablo4 then
                    urban2 = "✅"
                    continue
                  else
                    exitTo9 = 1
                    break
                  end
                end
              end

              break
            end

            if exitTo9 == 1 then
              Workspace = game:GetService("Workspace")
              continue
            end
            break
          end
        end
      elseif exitTo12 == 2 then
        Workspace = game:GetService("Workspace")

        while true do
          urban2 = Workspace.Enemies:FindFirstChild("Urban")

          if urban2 then
            urban2 = "✅"
          end

          urban2 = urban2 or "❌"
          exitTo9 = nil

          while true do
            ok11, result6 = pcall(function()
              return game
                :GetService("ReplicatedStorage").Remotes.CommF_
                :InvokeServer("EliteHunter", "Progress")
            end)

            tostringFn2 = tostring
            ok12 = ok11

            if ok12 then
              ok12 = result6
            end

            ok12 = ok12 or 0
            v10 = tostringFn2(ok12)

            if urban2 ~= str22 then
              eliteSpawnParagraph2 = eliteSpawnParagraph
              setDesc = eliteSpawnParagraph.SetDesc
              status = urban2 .. " | Killed: " .. v10
              setDesc(eliteSpawnParagraph2, "Status: " .. status)
              str22 = urban2
            end

            if wait(1) then
              diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

              if diablo3 then
                urban2 = "✅"
                continue
              else
                diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                  or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

                if diablo4 then
                  urban2 = "✅"
                  continue
                else
                  exitTo9 = 1
                  break
                end
              end
            end

            break
          end

          if exitTo9 == 1 then
            Workspace = game:GetService("Workspace")
            continue
          end
          break
        end
      end
    else
      urban2 = game:GetService("Workspace").Enemies:FindFirstChild("Urban")

      if urban2 then
        urban2 = "✅"
      end

      local exitTo14 = nil
      local v11

      while true do
        urban2 = urban2 or "❌"
        local exitTo13 = nil

        while true do
          local ok, result = pcall(function()
            return game
              :GetService("ReplicatedStorage").Remotes.CommF_
              :InvokeServer("EliteHunter", "Progress")
          end)

          local tostringFn = tostring
          local ok = ok

          if ok then
            ok = result
          end

          v11 = tostringFn(ok or 0)

          if urban2 == str then
            if wait(1) then
              if
                game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")
              then
                urban2 = "✅"
                continue
              elseif
                game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")
              then
                urban2 = "✅"
                continue
              else
                exitTo13 = 2
                break
              end
            end
          else
            exitTo13 = 1
            break
          end

          break
        end

        if exitTo13 == 1 then
          exitTo14 = 1
          break
        elseif exitTo13 == 2 then
          urban2 = game:GetService("Workspace").Enemies:FindFirstChild("Urban")
          if urban2 then
            urban2 = "✅"
            continue
          end
          continue
        end

        break
      end

      if exitTo14 == 1 then
        eliteSpawnParagraph2 = eliteSpawnParagraph
        setDesc = eliteSpawnParagraph.SetDesc
        status = urban2 .. " | Killed: " .. v11
        local exitTo16 = nil

        while true do
          setDesc(eliteSpawnParagraph2, "Status: " .. status)
          str22 = urban2
          local exitTo15 = nil

          while wait(1) do
            diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
              or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
              or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

            if diablo3 then
              urban2 = "✅"

              ok11, result6 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn2 = tostring
              ok12 = ok11

              if ok12 then
                ok12 = result6
              end

              ok12 = ok12 or 0
              v10 = tostringFn2(ok12)
              if urban2 ~= str22 then
                exitTo15 = 2
                break
              end
            else
              diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

              if diablo4 then
                urban2 = "✅"

                ok11, result6 = pcall(function()
                  return game
                    :GetService("ReplicatedStorage").Remotes.CommF_
                    :InvokeServer("EliteHunter", "Progress")
                end)

                tostringFn2 = tostring
                ok12 = ok11

                if ok12 then
                  ok12 = result6
                end

                ok12 = ok12 or 0
                v10 = tostringFn2(ok12)
                if urban2 ~= str22 then
                  exitTo15 = 2
                  break
                end
              else
                exitTo15 = 1
                break
              end
            end
          end

          if exitTo15 == 1 then
            exitTo16 = 1
            break
          elseif exitTo15 == 2 then
            eliteSpawnParagraph2 = eliteSpawnParagraph
            setDesc = eliteSpawnParagraph.SetDesc
            status = urban2 .. " | Killed: " .. v10
            continue
          end

          break
        end

        if exitTo16 == 1 then
          Workspace = game:GetService("Workspace")

          while true do
            urban2 = Workspace.Enemies:FindFirstChild("Urban")

            if urban2 then
              urban2 = "✅"
            end

            urban2 = urban2 or "❌"
            exitTo9 = nil

            while true do
              ok11, result6 = pcall(function()
                return game
                  :GetService("ReplicatedStorage").Remotes.CommF_
                  :InvokeServer("EliteHunter", "Progress")
              end)

              tostringFn2 = tostring
              ok12 = ok11

              if ok12 then
                ok12 = result6
              end

              ok12 = ok12 or 0
              v10 = tostringFn2(ok12)

              if urban2 ~= str22 then
                eliteSpawnParagraph2 = eliteSpawnParagraph
                setDesc = eliteSpawnParagraph.SetDesc
                status = urban2 .. " | Killed: " .. v10
                setDesc(eliteSpawnParagraph2, "Status: " .. status)
                str22 = urban2
              end

              if wait(1) then
                diablo3 = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre")
                  or game:GetService("ReplicatedStorage"):FindFirstChild("Urban")

                if diablo3 then
                  urban2 = "✅"
                  continue
                else
                  diablo4 = game:GetService("Workspace").Enemies:FindFirstChild("Diablo")
                    or game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

                  if diablo4 then
                    urban2 = "✅"
                    continue
                  else
                    exitTo9 = 1
                    break
                  end
                end
              end

              break
            end

            if exitTo9 == 1 then
              Workspace = game:GetService("Workspace")
              continue
            end
            break
          end
        end
      end
    end
  end
end)

do
  local n8 = nil
  local n9 = nil

  EliteQ = tbl.Main:AddToggle({
    Name = "Auto Farm Elite",
    Description = "",
    Default = false,
    Callback = function(farmEliteHunt)
      n8 = 835046712
      n9 = 411755947
      _G.FarmEliteHunt = farmEliteHunt
    end,
  })
end

local n8 = nil

EliteH = tbl.Main:AddToggle({
  Name = "Auto Farm Elite + Hop",
  Description = "",
  Default = false,
  Callback = function(farmEliteH)
    n8 = 165822274
    _G.FarmEliteH = farmEliteH
  end,
})

tbl.Main:AddSection("Farm Rip Indra")

tbl.Main:AddToggle({
  Name = "Auto Attack Rip Indra",
  Description = "",
  Default = false,
  Callback = function(autoRipIngay)
    _G.AutoRipIngay = autoRipIngay
  end,
})

tbl.Main:AddToggle({
  Name = "Auto Unlocked Haki",
  Description = "",
  Default = false,
  Callback = function(autoUnHaki)
    _G.AutoUnHaki = autoUnHaki
  end,
})

tbl.Main:AddSection("Farming Cake")
local cakePrincesParagraph = tbl.Main:AddParagraph("Cake Princes", "")

spawn(function()
  if wait(0.2) then
    repeat
      pcall(function()
        local match =
          string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")

        if match then
          cakePrincesParagraph:SetDesc("Killed : " .. 500 - tonumber(match))
        end
      end)
    until not wait(0.2)
  end
end)

Cake = tbl.Main:AddToggle({
  Name = "Auto Farm Cake Prince",
  Description = "",
  Default = false,
  Callback = function(autoCakePrince)
    _G.Auto_Cake_Prince = autoCakePrince
  end,
})

local n9 = nil

CakeQ = tbl.Main:AddToggle({
  Name = "Accept Quests",
  Description = "",
  Default = false,
  Callback = function(acceptQuestC)
    n9 = 893253937
    _G.AcceptQuestC = acceptQuestC
  end,
})

CakeSM = tbl.Main:AddToggle({
  Name = "Auto Summon Cake Prince",
  Description = "",
  Default = false,
  Callback = function(autoSpawnCP)
    _G.AutoSpawnCP = autoSpawnCP
  end,
})

tbl.Main:AddToggle({
  Name = "Auto Dough King [Fully]",
  Default = false,
  Callback = function(autoDoughKing)
    _G.AutoDoughKing = autoDoughKing
  end,
})

tbl.Main:AddToggle({
  Name = "Auto Farm Dough King",
  Default = false,
  Callback = function(autoAttackDoughKing)
    _G.AutoAttackDoughKing = autoAttackDoughKing
  end,
})

local n10 = nil

tbl.Main:AddToggle({
  Name = "Auto Farm Dough King + Hop",
  Default = false,
  Callback = function(autoHopDough)
    n10 = 575117960
    _G.AutoHop_Dough = autoHopDough
  end,
})

tbl.Main:AddSection("Farming Bone")
local bonesParagraph = tbl.Main:AddParagraph("Bones", "")

spawn(function()
  local n11 = nil

  if wait(1) then
    repeat
      pcall(function()
        n11 = 527032599
        local response =
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
        bonesParagraph:SetDesc("Bones : " .. tostring(response))
      end)
    until not wait(1)
  end
end)

tbl.Main:AddToggle({
  Name = "Auto Farm Bone",
  Description = "",
  Default = false,
  Callback = function(autoFarmBone)
    _G.AutoFarm_Bone = autoFarmBone
  end,
})

do
  local n11 = nil
  local n12 = nil

  BoneQ = tbl.Main:AddToggle({
    Name = "Accept Quests",
    Description = "",
    Default = false,
    Callback = function(acceptQuestB)
      n11 = 1033257055
      n12 = 506341273
      _G.AcceptQuestB = acceptQuestB
    end,
  })
end

tbl.Main:AddToggle({
  Name = "Auto Soul Reaper",
  Description = "",
  Default = false,
  Callback = function(autoHytHallow)
    _G.AutoHytHallow = autoHytHallow
  end,
})

local n11 = nil

RanBone = tbl.Main:AddToggle({
  Name = "Auto Random Bones",
  Description = "",
  Default = false,
  Callback = function(autoRandomBone)
    n11 = 753361169
    _G.Auto_Random_Bone = autoRandomBone
  end,
})

Lucky = tbl.Main:AddToggle({
  Name = "Auto Try Luck Gravestone",
  Description = "",
  Default = false,
  Callback = function(tryLucky)
    _G.TryLucky = tryLucky
  end,
})

Pray = tbl.Main:AddToggle({
  Name = "Auto Pray Gravestone",
  Description = "",
  Default = false,
  Callback = function(praying)
    _G.Praying = praying
  end,
})

tbl.Main:AddSection("Tyrant of the Skies")

do
  local bossSpawnParagraph = tbl.Main:AddParagraph("Boss Spawn", "")
  local n12 = nil

  spawn(function()
    n12 = 360075839
    local n13 = nil
    local n14 = nil

    pcall(function()
      n13 = 525892065
      n14 = 1061946163

      if wait(1) then
        local exitTo2, enemies

        if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
          local exitTo = nil

          while true do
            bossSpawnParagraph:SetDesc("✅")

            if wait(1) then
              if not workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                exitTo = 1
                break
              end
            else
              break
            end
          end

          if exitTo == 1 then
            while true do
              bossSpawnParagraph:SetDesc("❌")
              exitTo2 = nil

              while wait(1) do
                enemies = workspace.Enemies

                if enemies:FindFirstChild("Tyrant of the Skies") then
                  bossSpawnParagraph:SetDesc("✅")
                else
                  exitTo2 = 1
                  break
                end
              end

              if exitTo2 == 1 then
                continue
              end
              break
            end
          end
        else
          local exitTo3 = nil

          while true do
            bossSpawnParagraph:SetDesc("❌")

            if wait(1) then
              if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                exitTo3 = 1
                break
              end
            else
              break
            end
          end

          if exitTo3 == 1 then
            local exitTo4 = nil

            while true do
              bossSpawnParagraph:SetDesc("✅")

              if wait(1) then
                enemies = workspace.Enemies

                if enemies:FindFirstChild("Tyrant of the Skies") then
                  continue
                else
                  exitTo4 = 1
                  break
                end
              end

              break
            end

            if exitTo4 == 1 then
              while true do
                bossSpawnParagraph:SetDesc("❌")
                exitTo2 = nil

                while wait(1) do
                  enemies = workspace.Enemies

                  if enemies:FindFirstChild("Tyrant of the Skies") then
                    bossSpawnParagraph:SetDesc("✅")
                  else
                    exitTo2 = 1
                    break
                  end
                end

                if exitTo2 == 1 then
                  continue
                end
                break
              end
            end
          end
        end
      end
    end)
  end)
end

do
  local checkStatusEyesParagraph = tbl.Main:AddParagraph("Check Status Eyes", "")
  local n12 = nil
  local n13 = nil

  task.spawn(function()
    n12 = 684401847
    n13 = 488885059

    if task.wait(1) then
      local exitTo = nil
      local result, result2

      while true do
        local ok
        ok, result, result2 = pcall(Check_Eye)

        if ok then
          exitTo = 1
          break
        elseif not task.wait(1) then
          break
        end
      end

      if exitTo == 1 then
        local exitTo2 = nil

        while true do
          checkStatusEyesParagraph:SetDesc("Eyes: " .. result .. "/4")

          if result2 then
            exitTo2 = 1
            break
          else
            local exitTo3 = nil

            while task.wait(1) do
              local ok
              ok, result, result2 = pcall(Check_Eye)
              if ok then
                exitTo3 = 1
                break
              end
            end

            if exitTo3 == 1 then
              continue
            end
            break
          end
        end

        if exitTo2 == 1 then
          while true do
            local flag = true
            local exitTo4 = nil

            while task.wait(1) do
              local ok, ok13, result = pcall(Check_Eye)

              if ok then
                checkStatusEyesParagraph:SetDesc("Eyes: " .. ok13 .. "/4")

                if result then
                  if flag then
                    if result then
                      continue
                    end
                    flag = false
                  else
                    exitTo4 = 1
                    break
                  end
                elseif not result then
                  flag = false
                end
              end
            end

            if exitTo4 == 1 then
              continue
            end
            break
          end
        end
      end
    end
  end)
end

do
  local n12 = nil
  local n13 = nil

  FarmTyrant = tbl.Main:AddToggle({
    Name = "Auto Farm Boss TOTS",
    Description = "",
    Default = false,
    Callback = function(farmTyrant)
      n12 = 117038148
      n13 = 998549409
      _G.FarmTyrant = farmTyrant
    end,
  })
end

FarmPhaBinh = tbl.Main:AddToggle({
  Name = "Auto Summon Boss",
  Description = "",
  Default = false,
  Callback = function(farmPhaBinh)
    _G.FarmPhaBinh = farmPhaBinh
  end,
})

tbl.Main:AddSection("Farm Material")
local n12 = nil

Test = tbl.Main:AddDropdown({
  Name = "Choose Material",
  Description = "",
  Options = MaterialList,
  Callback = function(selectMaterial)
    n12 = 300003701
    getgenv().SelectMaterial = selectMaterial
  end,
})

Toggle = tbl.Main:AddToggle({
  Name = "Auto Farm Materials",
  Description = "",
  Default = false,
  Callback = function(autoMaterial)
    getgenv().AutoMaterial = autoMaterial
  end,
})

tbl.Main:AddSection("Farm Boss")

do
  local n13 = nil
  local n14 = nil

  BossDropdown = tbl.Main:AddDropdown({
    Name = "Select Boss",
    Description = "",
    Options = BossList,
    Callback = function(findBoss)
      n13 = 143412392
      n14 = 408768452
      _G.FindBoss = findBoss
    end,
  })
end

FarmBoss = tbl.Main:AddToggle({
  Name = "Auto Farm Boss",
  Description = "",
  Default = false,
  Callback = function(farmBoss)
    _G.FarmBoss = farmBoss
  end,
})

do
  local n13 = nil
  local n14 = nil

  BossQ = tbl.Main:AddToggle({
    Name = "Accept Quests",
    Description = "",
    Default = true,
    Callback = function(acceptQuestBoss)
      n13 = 617275046
      n14 = 893811601
      _G.AcceptQuestBoss = acceptQuestBoss
    end,
  })
end

local n13 = nil

FarmAllBoss = tbl.Main:AddToggle({
  Name = "Auto Farm All Boss",
  Default = false,
  Callback = function(autoFarmAllBoss)
    n13 = 589905519
    _G.AutoFarmAllBoss = autoFarmAllBoss
  end,
})

tbl.Main:AddSection("Farming Mastery")

do
  local n14 = nil
  local n15 = nil

  tbl.Main:AddDropdown({
    Name = "Choose Island",
    Description = "",
    Options = { "Cake", "Bone" },
    Default = Bone,
    Callback = function(arg)
      n14 = 48651533
      n15 = 711763559
      SelectIsland = arg
    end,
  })
end

do
  local n14 = nil
  local n15 = nil

  tbl.Main:AddSlider({
    Title = "NPC Health % Switch to Weapon",
    Description = "Switches to mastery weapon moves when NPC HP drops below this percent",
    Min = 10,
    Max = 95,
    Default = 70,
    Callback = function(masteryHealthPct)
      n14 = 913565413
      n15 = 114794156
      _G.MasteryHealthPct = masteryHealthPct
    end,
  })
end

do
  local n14 = nil
  local n15 = nil

  tbl.Main:AddDropdown({
    Name = "Select Skills to Use",
    Description = "Select which skills to spam (locked skills are auto-skipped)",
    Options = { "Z", "X", "C", "V", "F", "Y" },
    Default = { "Z", "X", "C", "V", "F" },
    MultiSelect = true,
    Callback = function(selectedMasterySkills)
      n14 = 642997887
      n15 = 697086408
      _G.SelectedMasterySkills = selectedMasterySkills
    end,
  })
end

tbl.Main:AddToggle({
  Name = "Auto Mastery Fruits",
  Description = "",
  Default = false,
  Callback = function(farmMasteryDev)
    _G.FarmMastery_Dev = farmMasteryDev
  end,
})

tbl.Main:AddToggle({
  Name = "Auto Mastery Gun",
  Description = "",
  Default = false,
  Callback = function(farmMasteryG)
    _G.FarmMastery_G = farmMasteryG
  end,
})

tbl.Main:AddToggle({
  Name = "Auto Mastery All Sword",
  Description = "",
  Default = false,
  Callback = function(farmMasteryS)
    _G.FarmMastery_S = farmMasteryS
  end,
})

require(game.ReplicatedStorage.EventConfig.MagnetEvent26)
tbl.Main:AddSection("Update 30 / Magnet Token")

do
  local magnetEventStatusParagraph = tbl.Main:AddParagraph("Magnet Event Status", "Loading...")
  local statusParagraph = tbl.Main:AddParagraph("Status", "Status : Idle")

  SetMagnetStatus = function(status)
    local n14 = nil
    local n15 = nil

    if statusParagraph and statusParagraph.SetDesc then
      local v2, v3

      pcall(function()
        n14 = 671250623
        n15 = 311781512
        statusParagraph:SetDesc("Status : " .. status)
      end)
    end
  end

  local n14 = nil
  local n15 = nil

  task.spawn(function()
    n14 = 832487746
    n15 = 475031797

    if task.wait(1) then
      repeat
        pcall(function()
          local now = os.time()
          local dateStr = os.date("*t", now)
          local min = dateStr.min
          local sec = dateStr.sec
          local flag = min >= 0

          if flag then
            flag = min < 10
          end

          local v2, v3, v4 = pairs(workspace.Enemies:GetChildren())
          local iter_z_1 = (function(f, s, var)
            local co = coroutine.wrap(function()
              coroutine.yield()
              for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
                coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
              end
            end)
            co()
            return co
          end)(v3, v4)
          local exitTo = nil
          local v5

          while true do
            local packedValues = table.pack(iter_z_1())

            if not packedValues[1] then
              exitTo = 1
              break
            else
              v5 = packedValues[3]
              if not v5:IsA("Model") then
                continue
              end
              break
            end
          end

          local str, str2, n16, formatted, n17

          if exitTo == 1 then
            str = "🔴"

            if flag then
              str2 = "🟢"
              n16 = (10 - min) * 60 - sec

              if n16 < 0 then
                n16 = 0
              end

              formatted = string.format(
                "%s ACTIVE - Time Left: %02d:%02d",
                str2,
                math.floor(n16 / 60),
                n16 % 60
              )
            else
              n17 = (60 - min) * 60 - sec

              if n17 <= 0 then
                n17 = 0
              end

              formatted = string.format(
                "%s INACTIVE - Next Event: %02d:%02d",
                str,
                math.floor(n17 / 60),
                n17 % 60
              )
            end
          else
            local attribute = v5:GetAttribute("MagnetEnemy")
            local exitTo3 = nil

            while attribute ~= true do
              if not string.find(string.lower(v5.Name), "magnetized") then
                local exitTo2 = nil

                while true do
                  local packedValues = table.pack(iter_z_1())

                  if not packedValues[1] then
                    exitTo2 = 1
                    break
                  else
                    v5 = packedValues[3]
                    if not v5:IsA("Model") then
                      continue
                    end
                    break
                  end
                end

                if exitTo2 == 1 then
                  exitTo3 = 1
                  break
                else
                  attribute = v5:GetAttribute("MagnetEnemy")
                  continue
                end
              end

              break
            end

            if exitTo3 == 1 then
              str = "🔴"

              if flag then
                str2 = "🟢"
                n16 = (10 - min) * 60 - sec

                if n16 < 0 then
                  n16 = 0
                end

                formatted = string.format(
                  "%s ACTIVE - Time Left: %02d:%02d",
                  str2,
                  math.floor(n16 / 60),
                  n16 % 60
                )
              else
                n17 = (60 - min) * 60 - sec

                if n17 <= 0 then
                  n17 = 0
                end

                formatted = string.format(
                  "%s INACTIVE - Next Event: %02d:%02d",
                  str,
                  math.floor(n17 / 60),
                  n17 % 60
                )
              end
            else
              local str4 = "🟢"
              local n18 = (10 - min) * 60 - sec

              if n18 < 0 then
                n18 = 0
              end

              formatted = string.format(
                "%s ACTIVE - Time Left: %02d:%02d (✅ Enemies Found)",
                str4,
                math.floor(n18 / 60),
                n18 % 60
              )
            end
          end

          magnetEventStatusParagraph:SetDesc(formatted)
        end)
      until not task.wait(1)
    end
  end)
end

_G.MagnetEventSpawnIndex = _G.MagnetEventSpawnIndex or 1

do
  local n14 = nil
  local n15 = nil

  tbl.Main:AddToggle({
    Name = "Auto Farm Magnet Token",
    Default = false,
    Callback = function(autoMagnetToken)
      n14 = 52190155
      n15 = 1039095665
      _G.AutoMagnetToken = autoMagnetToken
      local v2 = SetMagnetStatus
      local autoMagnetToken2 = autoMagnetToken

      if autoMagnetToken2 then
        autoMagnetToken2 = "Starting..."
      end

      v2(autoMagnetToken2 or "Idle")

      if not autoMagnetToken then
        _G.MagnetEventSpawnIndex = 1
      end
    end,
  })
end

tbl.Settings:AddSection("Settings / Configure")
local n14 = nil

-- This Source Was Generated by discord.gg/c3xVMnUUBv
Initialize = tbl.Settings:AddToggle({
  Name = "Fast Attack",
  Description = "",
  Default = true,
  Callback = function(seriality)
    n14 = 667966716
    _G.Seriality = seriality
  end,
})

Bringmob = tbl.Settings:AddToggle({
  Name = "Bring Mobs",
  Description = "",
  Default = true,
  Callback = function(arg)
    _B = arg
  end,
})

tbl.Settings:AddToggle({
  Name = "Auto Hop Server with time",
  Default = false,
  Callback = function(autoHopServer)
    _G.AutoHopServer = autoHopServer

    if not autoHopServer then
      _G.HopTimer = nil
    end
  end,
})

tbl.Settings:AddSlider({
  Name = "Hop Delay (Minutes)",
  Min = 5,
  Max = 120,
  Default = 30,
  Increment = 1,
  Callback = function(hopDelay)
    _G.HopDelay = hopDelay * 60
  end,
})

local n15 = nil

tbl.Settings:AddToggle({
  Name = "Auto Set Spawn Point",
  Default = false,
  Callback = function(set)
    n15 = 927703734
    getgenv().Set = set
    local n16 = nil

    if set then
      local v2, v3

      pcall(function()
        n16 = 869469746
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
      end)
    end
  end,
})

BusuAura = tbl.Settings:AddToggle({
  Name = "Auto Turn on Buso",
  Description = "",
  Default = true,
  Callback = function(arg)
    Boud = arg
  end,
})

tbl.Settings:AddToggle({
  Name = "Auto Haki Observation",
  Default = false,
  Callback = function(observation)
    getgenv().Observation = observation
  end,
})

local n16 = nil

RaceV3Aura = tbl.Settings:AddToggle({
  Name = "Auto Turn on Race V3",
  Description = "",
  Default = false,
  Flag = "AutoTurnonRaceV3",
  Callback = function(raceClickAutov3)
    n16 = 624714633
    _G.RaceClickAutov3 = raceClickAutov3
  end,
})

do
  local n17 = nil
  local n18 = nil

  RaceV4Aura = tbl.Settings:AddToggle({
    Name = "Auto Turn on Race V4",
    Description = "",
    Default = false,
    Callback = function(raceClickAutov4)
      n17 = 353210241
      n18 = 283295182
      _G.RaceClickAutov4 = raceClickAutov4
    end,
  })
end

RandomAround = tbl.Settings:AddToggle({
  Name = "Auto Turn on Spin  xyz",
  Description = "",
  Default = false,
  Callback = function(arg)
    RandomCFrame = arg
  end,
})

SafeModes = tbl.Settings:AddToggle({
  Name = "Safe Mode",
  Description = "",
  Default = false,
  Callback = function(safemode)
    _G.Safemode = safemode
  end,
})

DisableHitVFX = tbl.Settings:AddToggle({
  Name = "Remove Hit VFX",
  Description = "Removes slash and sword visual effects for better visibility",
  Default = false,
  Callback = function(destroyHit)
    _G.DestroyHit = destroyHit
  end,
})

RmvVFX = tbl.Settings:AddToggle({
  Name = "Remove Death & Respawned VFX",
  Description = "",
  Default = false,
  Callback = function(arg)
    RDeath = arg
  end,
})

DisblesNotify = tbl.Settings:AddToggle({
  Name = "Disable Notify",
  Description = "",
  Default = false,
  Callback = function(arg)
    RemoveDamage = arg
  end,
})

local n17 = nil

tbl.Settings:AddToggle({
  Name = "Anti AFK",
  Default = true,
  Callback = function(arg)
    n17 = 148937531
    local n18 = nil
    local n19 = nil

    if arg then
      local VirtualUser = game:GetService("VirtualUser")

      repeat
        wait()
      until game:IsLoaded()

      local v2, v3

      -- Event listener: Idled:Connect
      game:GetService("Players").LocalPlayer.Idled:Connect(function()
        n18 = 808230803
        n19 = 186919014
        local cFrame = workspace.CurrentCamera.CFrame
        cFrame:Button2Down(Vector2.new(0, 0), cFrame)
        wait(1)
        local cFrame2 = workspace.CurrentCamera.CFrame
        cFrame:Button2Up(Vector2.new(0, 0), cFrame2)
      end)
    end
  end,
})

tbl.Settings:AddToggle({
  Name = "Auto Anti - Admin Join Server",
  Description = "",
  Default = true,
  Callback = function(hopServerAdmin)
    getgenv().HopServerAdmin = hopServerAdmin
  end,
})

tbl.Settings:AddToggle({
  Name = "No Clip",
  Default = false,
  Callback = function(noClip)
    getgenv().NoClip = noClip
  end,
})

tbl.Esp:AddSection("Stats Upgrade")

do
  local n18 = nil
  local n19 = nil

  StatusSelect = tbl.Esp:AddSlider({
    Name = "Stats Value",
    Description = "",
    Default = 10,
    Min = 0,
    Max = 1000,
    Rounding = 1,
    Callback = function(arg)
      n18 = 845700654
      n19 = 50993120
      pSats = arg
    end,
  })
end

StatsUpg = tbl.Esp:AddToggle({
  Name = "Auto Melee",
  Description = "",
  Default = false,
  Callback = function(autoMelee)
    _G.Auto_Melee = autoMelee
  end,
})

StatsUpg = tbl.Esp:AddToggle({
  Name = "Auto Swords",
  Description = "",
  Default = false,
  Callback = function(autoSword)
    _G.Auto_Sword = autoSword
  end,
})

do
  local n18 = nil
  local n19 = nil

  StatsUpg = tbl.Esp:AddToggle({
    Name = "Auto Gun",
    Description = "",
    Default = false,
    Callback = function(autoGun)
      n18 = 918607324
      n19 = 124019470
      _G.Auto_Gun = autoGun
    end,
  })
end

StatsUpg = tbl.Esp:AddToggle({
  Name = "Auto Blox Fruit",
  Description = "",
  Default = false,
  Callback = function(autoDevilFruit)
    _G.Auto_DevilFruit = autoDevilFruit
  end,
})

StatsUpg = tbl.Esp:AddToggle({
  Name = "Auto Defense",
  Description = "",
  Default = false,
  Callback = function(autoDefense)
    _G.Auto_Defense = autoDefense
  end,
})

tbl.Fish:AddSection("Fishing")
local n18 = nil

tbl.Fish:AddDropdown({
  Name = "Select Fishing Rod",
  Description = "",
  Options = { "Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod" },
  Default = "Fishing Rod",
  Callback = function(selectedRod)
    n18 = 24985459
    _G.SelectedRod = selectedRod
  end,
})

local n19 = nil

BaitDropdown = tbl.Fish:AddDropdown({
  Name = "Select Bait",
  Description = "",
  Options = {
    "Basic Bait",
    "Kelp Bait",
    "Good Bait",
    "Abyssal Bait",
    "Frozen Bait",
    "Epic Bait",
    "Carnivore Bait",
  },
  Default = "Basic Bait",
  Callback = function(selectedBait)
    n19 = 352254215
    _G.SelectedBait = selectedBait
    local n20 = nil
    local n21 = nil

    if _G.AutoBuyBait then
      local v2, v3, v4

      pcall(function()
        n20 = 66490399
        n21 = 376631805
        Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
      end)
    end
  end,
})

do
  local n20 = nil
  local n21 = nil

  BuyBaitToggle = tbl.Fish:AddToggle({
    Name = "Auto Buy Bait",
    Description = "",
    Default = false,
    Callback = function(autoBuyBait)
      n20 = 387005600
      n21 = 273934639
      _G.AutoBuyBait = autoBuyBait
      local n22 = nil
      local n23 = nil

      if autoBuyBait then
        pcall(function()
          n22 = 906862072
          n23 = 190674523
          Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
        end)
      end
    end,
  })
end

FishingToggle = tbl.Fish:AddToggle({
  Name = "Auto Fishing",
  Description = "",
  Default = false,
  Callback = function(autoFishing)
    _G.AutoFishing = autoFishing
  end,
})

local n20 = nil

FishingQ = tbl.Fish:AddToggle({
  Name = "Auto Quest Fishing",
  Description = "",
  Default = false,
  Callback = function(autoFishingQuest)
    n20 = 203194267
    _G.AutoFishingQuest = autoFishingQuest
  end,
})

QuestToggle = tbl.Fish:AddToggle({
  Name = "Auto Complete Quest",
  Description = "",
  Default = false,
  Callback = function(autoQuestComplete)
    _G.AutoQuestComplete = autoQuestComplete

    if autoQuestComplete then
      local v2, v3, v4, v5

      pcall(function()
        Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
      end)
    end
  end,
})

SellFishToggle = tbl.Fish:AddToggle({
  Name = "Auto Sell Fish",
  Description = "",
  Default = false,
  Callback = function(autoSellFish)
    _G.AutoSellFish = autoSellFish

    if autoSellFish then
      local v2, v3, v4, v5

      pcall(function()
        Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
      end)
    end
  end,
})

SpamSkillZ = tbl.Fish:AddToggle({
  Name = "Auto Spam Skill Z",
  Description = "",
  Default = false,
  Callback = function(autoSkillZ)
    _G.AutoSkillZ = autoSkillZ
  end,
})

do
  local n21 = nil
  local n22 = nil

  TravelDress = tbl.Quests:AddToggle({
    Name = "Auto Quest Sea 2",
    Description = "",
    Default = false,
    Callback = function(travelDres)
      n21 = 231652075
      n22 = 1011797974
      _G.TravelDres = travelDres
    end,
  })
end

Zou = tbl.Quests:AddToggle({
  Name = "Auto Quest Sea 3",
  Description = "",
  Default = false,
  Callback = function(autoZou)
    _G.AutoZou = autoZou
  end,
})

tbl.Quests:AddSection("Tushita + Yama")
local n21 = nil

Q = tbl.Quests:AddToggle({
  Name = "Auto Tushita Sword",
  Description = "",
  Default = false,
  Callback = function(autoTushita)
    n21 = 587300030
    _G.Auto_Tushita = autoTushita
  end,
})

local n22 = nil

Q = tbl.Quests:AddToggle({
  Name = "Auto Yama Sword",
  Description = "",
  Default = false,
  Callback = function(autoYama)
    n22 = 194751762
    _G.Auto_Yama = autoYama
  end,
})

tbl.Quests:AddSection("Skull Guitars / Misc")

do
  local skullGuitarQuestsParagraph = tbl.Quests:AddParagraph("Skull Guitar Quests", "")
  local n23 = nil
  local n24 = nil

  spawn(function()
    n23 = 381298345
    n24 = 358770775
    local n25 = nil

    if wait(0.2) then
      repeat
        pcall(function()
          n25 = 279256361

          if Quest1 ~= true then
            if Quest2 ~= true then
              if Quest3 ~= true then
                if Quest4 ~= true then
                  if GetWP("Skull Guitar") then
                    skullGuitarQuestsParagraph:SetDesc("Quest Number : Collect!!")
                  else
                    skullGuitarQuestsParagraph:SetDesc("Quest Number : No Quest!!")
                  end
                else
                  skullGuitarQuestsParagraph:SetDesc("Quest Number : Quest4")
                end
              else
                skullGuitarQuestsParagraph:SetDesc("Quest Number : Quest3")
              end
            else
              skullGuitarQuestsParagraph:SetDesc("Quest Number : Quest2")
            end
          else
            skullGuitarQuestsParagraph:SetDesc("Quest Number : Quest1")
          end
        end)
      until not wait(0.2)
    end
  end)
end

tbl.Quests:AddToggle({
  Name = "Auto Skull Guitar",
  Description = "",
  Default = false,
  Callback = function(autoSoulGuitar)
    _G.Auto_Soul_Guitar = autoSoulGuitar
  end,
})

tbl.Quests:AddToggle({
  Name = "Auto Farm Material Skull Guitar",
  Description = "",
  Default = false,
  Callback = function(autoMatSoul)
    _G.AutoMatSoul = autoMatSoul
  end,
})

tbl.Quests:AddSection("Cursed Dual Katana")
local paragraph = tbl.Quests:AddParagraph("Number Cursed dual katana quests", "Quest Numbers :")

spawn(function()
  if wait(0.2) then
    local exitTo = nil

    while true do
      if QuestYama_1 ~= true then
        if QuestYama_2 ~= true then
          exitTo = 1
          break
        end
        paragraph:SetDesc("Quest Numbers : yama quest 2")
      else
        paragraph:SetDesc("Quest Numbers : yama quest 1")
      end

      if wait(0.2) then
        continue
      end
      break
    end

    if exitTo == 1 then
      local paragraph2, setDesc, str, exitTo6, exitTo8, exitTo7, paragraph3, setDesc2, exitTo9, paragraph4, setDesc3, exitTo12, exitTo14, exitTo13, paragraph5, setDesc4, exitTo15, exitTo17, exitTo16, exitTo19, exitTo18, paragraph6, setDesc5, exitTo26, exitTo27, exitTo28

      if QuestYama_3 ~= true then
        local exitTo11, exitTo10, exitTo21, exitTo20, exitTo23, exitTo22

        if QuestTushita_1 ~= true then
          local exitTo2 = nil

          while true do
            if QuestTushita_2 ~= true then
              exitTo2 = 1
              break
            else
              paragraph:SetDesc("Quest Numbers : tushita quest 2")
              local exitTo3 = nil

              while wait(0.2) do
                if QuestYama_1 ~= true then
                  if QuestYama_2 ~= true then
                    exitTo3 = 1
                    break
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 2")
                  end
                else
                  paragraph:SetDesc("Quest Numbers : yama quest 1")
                end
              end

              if exitTo3 == 1 then
                if QuestYama_3 ~= true then
                  if QuestTushita_1 ~= true then
                    continue
                  else
                    exitTo2 = 3
                    break
                  end
                else
                  exitTo2 = 2
                  break
                end
              end

              break
            end
          end

          if exitTo2 == 1 then
            local exitTo5 = nil

            while true do
              if GetWP("Cursed Dual Katana") then
                paragraph:SetDesc("Quest Numbers : CDK done!!")
              end

              local exitTo4 = nil

              while wait(0.2) do
                if QuestYama_1 ~= true then
                  if QuestYama_2 ~= true then
                    if QuestYama_3 ~= true then
                      if QuestTushita_1 ~= true then
                        if QuestTushita_2 ~= true then
                          exitTo4 = 3
                          break
                        else
                          paragraph:SetDesc("Quest Numbers : tushita quest 2")
                        end
                      else
                        exitTo4 = 2
                        break
                      end
                    else
                      exitTo4 = 1
                      break
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 2")
                  end
                else
                  paragraph:SetDesc("Quest Numbers : yama quest 1")
                end
              end

              if exitTo4 == 1 then
                exitTo5 = 1
                break
              elseif exitTo4 == 2 then
                exitTo5 = 2
                break
              elseif exitTo4 == 3 then
                continue
              end

              break
            end

            if exitTo5 == 1 then
              paragraph2 = paragraph
              setDesc = paragraph.SetDesc
              str = "Quest Numbers : yama quest 3"

              while true do
                setDesc(paragraph2, str)
                exitTo6 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            if GetWP("Cursed Dual Katana") then
                              paragraph:SetDesc("Quest Numbers : CDK done!!")
                              continue
                            end
                            continue
                          end

                          paragraph:SetDesc("Quest Numbers : tushita quest 2")
                        else
                          exitTo6 = 2
                          break
                        end
                      else
                        exitTo6 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo6 == 1 then
                  paragraph2 = paragraph
                  setDesc = paragraph.SetDesc
                  continue
                end

                break
              end

              if exitTo6 == 2 then
                exitTo8 = nil

                while true do
                  paragraph:SetDesc("Quest Numbers : tushita quest 1")
                  exitTo7 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          else
                            exitTo7 = 2
                            break
                          end
                        else
                          exitTo7 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo7 == 1 then
                    exitTo8 = 1
                    break
                  elseif exitTo7 == 2 then
                    continue
                  end

                  break
                end

                if exitTo8 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            elseif exitTo5 == 2 then
              exitTo11 = nil

              while true do
                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                exitTo10 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            if GetWP("Cursed Dual Katana") then
                              paragraph:SetDesc("Quest Numbers : CDK done!!")
                              continue
                            end
                            continue
                          end

                          paragraph:SetDesc("Quest Numbers : tushita quest 2")
                        else
                          exitTo10 = 2
                          break
                        end
                      else
                        exitTo10 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo10 == 1 then
                  exitTo11 = 1
                  break
                elseif exitTo10 == 2 then
                  continue
                end

                break
              end

              if exitTo11 == 1 then
                paragraph3 = paragraph
                setDesc2 = paragraph.SetDesc
                str = "Quest Numbers : yama quest 3"

                while true do
                  setDesc2(paragraph3, str)
                  exitTo9 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            continue
                          end

                          paragraph:SetDesc("Quest Numbers : tushita quest 1")
                        else
                          exitTo9 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo9 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc
                    continue
                  end

                  break
                end
              end
            end
          elseif exitTo2 == 2 then
            paragraph4 = paragraph
            setDesc3 = paragraph.SetDesc
            str = "Quest Numbers : yama quest 3"

            while true do
              setDesc3(paragraph4, str)
              exitTo12 = nil

              while wait(0.2) do
                if QuestYama_1 ~= true then
                  if QuestYama_2 ~= true then
                    if QuestYama_3 ~= true then
                      if QuestTushita_1 ~= true then
                        if QuestTushita_2 ~= true then
                          exitTo12 = 3
                          break
                        else
                          paragraph:SetDesc("Quest Numbers : tushita quest 2")
                        end
                      else
                        exitTo12 = 2
                        break
                      end
                    else
                      exitTo12 = 1
                      break
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 2")
                  end
                else
                  paragraph:SetDesc("Quest Numbers : yama quest 1")
                end
              end

              if exitTo12 == 1 then
                paragraph4 = paragraph
                setDesc3 = paragraph.SetDesc
                continue
              end

              break
            end

            if exitTo12 == 2 then
              exitTo14 = nil

              while true do
                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                exitTo13 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo13 = 3
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          exitTo13 = 2
                          break
                        end
                      else
                        exitTo13 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo13 == 1 then
                  exitTo14 = 1
                  break
                elseif exitTo13 == 2 then
                  continue
                end

                break
              end

              if exitTo14 == 1 then
                paragraph5 = paragraph
                setDesc4 = paragraph.SetDesc

                while true do
                  setDesc4(paragraph5, str)
                  exitTo15 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo15 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo15 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo15 == 1 then
                    paragraph5 = paragraph
                    setDesc4 = paragraph.SetDesc
                    continue
                  end

                  break
                end

                if exitTo15 == 2 then
                  exitTo17 = nil

                  while true do
                    if GetWP("Cursed Dual Katana") then
                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                    end

                    exitTo16 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo16 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo16 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo16 == 1 then
                      exitTo17 = 1
                      break
                    elseif exitTo16 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo17 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil
                      
-- [[ leaked by YzZ ]]

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              elseif exitTo13 == 3 then
                exitTo17 = nil

                while true do
                  if GetWP("Cursed Dual Katana") then
                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                  end

                  exitTo16 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo16 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo16 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo16 == 1 then
                    exitTo17 = 1
                    break
                  elseif exitTo16 == 2 then
                    continue
                  end

                  break
                end

                if exitTo17 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            elseif exitTo12 == 3 then
              exitTo19 = nil

              while true do
                if GetWP("Cursed Dual Katana") then
                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                end

                exitTo18 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo18 = 3
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          exitTo18 = 2
                          break
                        end
                      else
                        exitTo18 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo18 == 1 then
                  exitTo19 = 1
                  break
                elseif exitTo18 == 2 then
                  exitTo19 = 2
                  break
                elseif exitTo18 == 3 then
                  continue
                end

                break
              end

              if exitTo19 == 1 then
                paragraph2 = paragraph
                setDesc = paragraph.SetDesc

                while true do
                  setDesc(paragraph2, str)
                  exitTo6 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          else
                            exitTo6 = 2
                            break
                          end
                        else
                          exitTo6 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo6 == 1 then
                    paragraph2 = paragraph
                    setDesc = paragraph.SetDesc
                    continue
                  end

                  break
                end

                if exitTo6 == 2 then
                  exitTo8 = nil

                  while true do
                    paragraph:SetDesc("Quest Numbers : tushita quest 1")
                    exitTo7 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            else
                              exitTo7 = 2
                              break
                            end
                          else
                            exitTo7 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo7 == 1 then
                      exitTo8 = 1
                      break
                    elseif exitTo7 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo8 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              elseif exitTo19 == 2 then
                exitTo8 = nil

                while true do
                  paragraph:SetDesc("Quest Numbers : tushita quest 1")
                  exitTo7 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          else
                            exitTo7 = 2
                            break
                          end
                        else
                          exitTo7 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo7 == 1 then
                    exitTo8 = 1
                    break
                  elseif exitTo7 == 2 then
                    continue
                  end

                  break
                end

                if exitTo8 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            end
          elseif exitTo2 == 3 then
            exitTo21 = nil

            while true do
              paragraph:SetDesc("Quest Numbers : tushita quest 1")
              exitTo20 = nil

              while wait(0.2) do
                if QuestYama_1 ~= true then
                  if QuestYama_2 ~= true then
                    if QuestYama_3 ~= true then
                      if QuestTushita_1 ~= true then
                        if QuestTushita_2 ~= true then
                          exitTo20 = 3
                          break
                        else
                          paragraph:SetDesc("Quest Numbers : tushita quest 2")
                        end
                      else
                        exitTo20 = 2
                        break
                      end
                    else
                      exitTo20 = 1
                      break
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 2")
                  end
                else
                  paragraph:SetDesc("Quest Numbers : yama quest 1")
                end
              end

              if exitTo20 == 1 then
                exitTo21 = 1
                break
              elseif exitTo20 == 2 then
                continue
              end

              break
            end

            if exitTo21 == 1 then
              paragraph5 = paragraph
              setDesc4 = paragraph.SetDesc
              str = "Quest Numbers : yama quest 3"

              while true do
                setDesc4(paragraph5, str)
                exitTo15 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo15 = 2
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : tushita quest 1")
                        end
                      else
                        exitTo15 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo15 == 1 then
                  paragraph5 = paragraph
                  setDesc4 = paragraph.SetDesc
                  continue
                end

                break
              end

              if exitTo15 == 2 then
                exitTo17 = nil

                while true do
                  if GetWP("Cursed Dual Katana") then
                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                  end

                  exitTo16 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo16 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo16 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo16 == 1 then
                    exitTo17 = 1
                    break
                  elseif exitTo16 == 2 then
                    continue
                  end

                  break
                end

                if exitTo17 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            elseif exitTo20 == 3 then
              exitTo23 = nil

              while true do
                if GetWP("Cursed Dual Katana") then
                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                end

                exitTo22 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo22 = 3
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          exitTo22 = 2
                          break
                        end
                      else
                        exitTo22 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo22 == 1 then
                  exitTo23 = 1
                  break
                elseif exitTo22 == 2 then
                  exitTo23 = 2
                  break
                elseif exitTo22 == 3 then
                  continue
                end

                break
              end

              if exitTo23 == 1 then
                paragraph3 = paragraph
                setDesc2 = paragraph.SetDesc
                str = "Quest Numbers : yama quest 3"

                while true do
                  setDesc2(paragraph3, str)
                  exitTo9 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            continue
                          end

                          paragraph:SetDesc("Quest Numbers : tushita quest 1")
                        else
                          exitTo9 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo9 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc
                    continue
                  end

                  break
                end
              elseif exitTo23 == 2 then
                exitTo11 = nil

                while true do
                  paragraph:SetDesc("Quest Numbers : tushita quest 1")
                  exitTo10 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          else
                            exitTo10 = 2
                            break
                          end
                        else
                          exitTo10 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo10 == 1 then
                    exitTo11 = 1
                    break
                  elseif exitTo10 == 2 then
                    continue
                  end

                  break
                end

                if exitTo11 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc
                  str = "Quest Numbers : yama quest 3"

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            end
          end
        else
          local exitTo25 = nil

          while true do
            paragraph:SetDesc("Quest Numbers : tushita quest 1")
            local exitTo24 = nil

            while wait(0.2) do
              if QuestYama_1 ~= true then
                if QuestYama_2 ~= true then
                  exitTo24 = 1
                  break
                else
                  paragraph:SetDesc("Quest Numbers : yama quest 2")
                end
              else
                paragraph:SetDesc("Quest Numbers : yama quest 1")
              end
            end

            if exitTo24 == 1 then
              if QuestYama_3 ~= true then
                if QuestTushita_1 ~= true then
                  exitTo25 = 2
                  break
                else
                  continue
                end
              else
                exitTo25 = 1
                break
              end
            end

            break
          end

          if exitTo25 == 1 then
            paragraph6 = paragraph
            setDesc5 = paragraph.SetDesc
            str = "Quest Numbers : yama quest 3"

            while true do
              setDesc5(paragraph6, str)
              exitTo26 = nil

              while wait(0.2) do
                if QuestYama_1 ~= true then
                  if QuestYama_2 ~= true then
                    if QuestYama_3 ~= true then
                      if QuestTushita_1 ~= true then
                        exitTo26 = 2
                        break
                      else
                        paragraph:SetDesc("Quest Numbers : tushita quest 1")
                      end
                    else
                      exitTo26 = 1
                      break
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 2")
                  end
                else
                  paragraph:SetDesc("Quest Numbers : yama quest 1")
                end
              end

              if exitTo26 == 1 then
                paragraph6 = paragraph
                setDesc5 = paragraph.SetDesc
                continue
              end

              break
            end

            if exitTo26 == 2 then
              exitTo27 = nil

              while true do
                if QuestTushita_2 ~= true then
                  exitTo27 = 1
                  break
                else
                  paragraph:SetDesc("Quest Numbers : tushita quest 2")
                  exitTo28 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            exitTo28 = 2
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo28 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo28 == 1 then
                    exitTo27 = 2
                    break
                  elseif exitTo28 == 2 then
                    continue
                  end

                  break
                end
              end

              if exitTo27 == 1 then
                exitTo17 = nil

                while true do
                  if GetWP("Cursed Dual Katana") then
                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                  end

                  exitTo16 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo16 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo16 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo16 == 1 then
                    exitTo17 = 1
                    break
                  elseif exitTo16 == 2 then
                    continue
                  end

                  break
                end

                if exitTo17 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              elseif exitTo27 == 2 then
                paragraph5 = paragraph
                setDesc4 = paragraph.SetDesc

                while true do
                  setDesc4(paragraph5, str)
                  exitTo15 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo15 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo15 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo15 == 1 then
                    paragraph5 = paragraph
                    setDesc4 = paragraph.SetDesc
                    continue
                  end

                  break
                end

                if exitTo15 == 2 then
                  exitTo17 = nil

                  while true do
                    if GetWP("Cursed Dual Katana") then
                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                    end

                    exitTo16 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo16 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo16 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo16 == 1 then
                      exitTo17 = 1
                      break
                    elseif exitTo16 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo17 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              end
            end
          elseif exitTo25 == 2 then
            local exitTo29 = nil

            while true do
              if QuestTushita_2 ~= true then
                exitTo29 = 1
                break
              else
                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                local exitTo30 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      exitTo30 = 1
                      break
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo30 == 1 then
                  if QuestYama_3 ~= true then
                    if QuestTushita_1 ~= true then
                      continue
                    else
                      exitTo29 = 3
                      break
                    end
                  else
                    exitTo29 = 2
                    break
                  end
                end

                break
              end
            end

            if exitTo29 == 1 then
              exitTo23 = nil

              while true do
                if GetWP("Cursed Dual Katana") then
                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                end

                exitTo22 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo22 = 3
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          exitTo22 = 2
                          break
                        end
                      else
                        exitTo22 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo22 == 1 then
                  exitTo23 = 1
                  break
                elseif exitTo22 == 2 then
                  exitTo23 = 2
                  break
                elseif exitTo22 == 3 then
                  continue
                end

                break
              end

              if exitTo23 == 1 then
                paragraph3 = paragraph
                setDesc2 = paragraph.SetDesc
                str = "Quest Numbers : yama quest 3"

                while true do
                  setDesc2(paragraph3, str)
                  exitTo9 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            continue
                          end

                          paragraph:SetDesc("Quest Numbers : tushita quest 1")
                        else
                          exitTo9 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo9 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc
                    continue
                  end

                  break
                end
              elseif exitTo23 == 2 then
                exitTo11 = nil

                while true do
                  paragraph:SetDesc("Quest Numbers : tushita quest 1")
                  exitTo10 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          else
                            exitTo10 = 2
                            break
                          end
                        else
                          exitTo10 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo10 == 1 then
                    exitTo11 = 1
                    break
                  elseif exitTo10 == 2 then
                    continue
                  end

                  break
                end

                if exitTo11 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc
                  str = "Quest Numbers : yama quest 3"

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            elseif exitTo29 == 2 then
              paragraph5 = paragraph
              setDesc4 = paragraph.SetDesc
              str = "Quest Numbers : yama quest 3"

              while true do
                setDesc4(paragraph5, str)
                exitTo15 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo15 = 2
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : tushita quest 1")
                        end
                      else
                        exitTo15 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo15 == 1 then
                  paragraph5 = paragraph
                  setDesc4 = paragraph.SetDesc
                  continue
                end

                break
              end

              if exitTo15 == 2 then
                exitTo17 = nil

                while true do
                  if GetWP("Cursed Dual Katana") then
                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                  end

                  exitTo16 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo16 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo16 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo16 == 1 then
                    exitTo17 = 1
                    break
                  elseif exitTo16 == 2 then
                    continue
                  end

                  break
                end

                if exitTo17 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            elseif exitTo29 == 3 then
              exitTo21 = nil

              while true do
                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                exitTo20 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo20 = 3
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          exitTo20 = 2
                          break
                        end
                      else
                        exitTo20 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo20 == 1 then
                  exitTo21 = 1
                  break
                elseif exitTo20 == 2 then
                  continue
                end

                break
              end

              if exitTo21 == 1 then
                paragraph5 = paragraph
                setDesc4 = paragraph.SetDesc
                str = "Quest Numbers : yama quest 3"

                while true do
                  setDesc4(paragraph5, str)
                  exitTo15 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo15 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo15 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo15 == 1 then
                    paragraph5 = paragraph
                    setDesc4 = paragraph.SetDesc
                    continue
                  end

                  break
                end

                if exitTo15 == 2 then
                  exitTo17 = nil

                  while true do
                    if GetWP("Cursed Dual Katana") then
                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                    end

                    exitTo16 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo16 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo16 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo16 == 1 then
                      exitTo17 = 1
                      break
                    elseif exitTo16 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo17 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              elseif exitTo20 == 3 then
                exitTo23 = nil

                while true do
                  if GetWP("Cursed Dual Katana") then
                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                  end

                  exitTo22 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo22 = 3
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            exitTo22 = 2
                            break
                          end
                        else
                          exitTo22 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo22 == 1 then
                    exitTo23 = 1
                    break
                  elseif exitTo22 == 2 then
                    exitTo23 = 2
                    break
                  elseif exitTo22 == 3 then
                    continue
                  end

                  break
                end

                if exitTo23 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc
                  str = "Quest Numbers : yama quest 3"

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                elseif exitTo23 == 2 then
                  exitTo11 = nil

                  while true do
                    paragraph:SetDesc("Quest Numbers : tushita quest 1")
                    exitTo10 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            else
                              exitTo10 = 2
                              break
                            end
                          else
                            exitTo10 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo10 == 1 then
                      exitTo11 = 1
                      break
                    elseif exitTo10 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo11 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc
                    str = "Quest Numbers : yama quest 3"

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              end
            end
          end
        end
      else
        local paragraph7 = paragraph
        local setDesc6 = paragraph.SetDesc
        str = "Quest Numbers : yama quest 3"
        local exitTo32 = nil

        while true do
          setDesc6(paragraph7, str)
          local exitTo31 = nil

          while wait(0.2) do
            if QuestYama_1 ~= true then
              if QuestYama_2 ~= true then
                exitTo31 = 1
                break
              else
                paragraph:SetDesc("Quest Numbers : yama quest 2")
              end
            else
              paragraph:SetDesc("Quest Numbers : yama quest 1")
            end
          end

          if exitTo31 == 1 then
            if QuestYama_3 ~= true then
              exitTo32 = 1
              break
            else
              paragraph7 = paragraph
              setDesc6 = paragraph.SetDesc
              continue
            end
          end

          break
        end

        if exitTo32 == 1 then
          if QuestTushita_1 ~= true then
            local exitTo33 = nil

            while true do
              if QuestTushita_2 ~= true then
                exitTo33 = 1
                break
              else
                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                local exitTo34 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      exitTo34 = 1
                      break
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo34 == 1 then
                  if QuestYama_3 ~= true then
                    if QuestTushita_1 ~= true then
                      continue
                    else
                      exitTo33 = 3
                      break
                    end
                  else
                    exitTo33 = 2
                    break
                  end
                end

                break
              end
            end

            if exitTo33 == 1 then
              exitTo19 = nil

              while true do
                if GetWP("Cursed Dual Katana") then
                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                end

                exitTo18 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo18 = 3
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          exitTo18 = 2
                          break
                        end
                      else
                        exitTo18 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo18 == 1 then
                  exitTo19 = 1
                  break
                elseif exitTo18 == 2 then
                  exitTo19 = 2
                  break
                elseif exitTo18 == 3 then
                  continue
                end

                break
              end

              if exitTo19 == 1 then
                paragraph2 = paragraph
                setDesc = paragraph.SetDesc

                while true do
                  setDesc(paragraph2, str)
                  exitTo6 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          else
                            exitTo6 = 2
                            break
                          end
                        else
                          exitTo6 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo6 == 1 then
                    paragraph2 = paragraph
                    setDesc = paragraph.SetDesc
                    continue
                  end

                  break
                end

                if exitTo6 == 2 then
                  exitTo8 = nil

                  while true do
                    paragraph:SetDesc("Quest Numbers : tushita quest 1")
                    exitTo7 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            else
                              exitTo7 = 2
                              break
                            end
                          else
                            exitTo7 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo7 == 1 then
                      exitTo8 = 1
                      break
                    elseif exitTo7 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo8 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              elseif exitTo19 == 2 then
                exitTo8 = nil

                while true do
                  paragraph:SetDesc("Quest Numbers : tushita quest 1")
                  exitTo7 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              if GetWP("Cursed Dual Katana") then
                                paragraph:SetDesc("Quest Numbers : CDK done!!")
                                continue
                              end
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          else
                            exitTo7 = 2
                            break
                          end
                        else
                          exitTo7 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo7 == 1 then
                    exitTo8 = 1
                    break
                  elseif exitTo7 == 2 then
                    continue
                  end

                  break
                end

                if exitTo8 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            elseif exitTo33 == 2 then
              paragraph4 = paragraph
              setDesc3 = paragraph.SetDesc

              while true do
                setDesc3(paragraph4, str)
                exitTo12 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo12 = 3
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          exitTo12 = 2
                          break
                        end
                      else
                        exitTo12 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo12 == 1 then
                  paragraph4 = paragraph
                  setDesc3 = paragraph.SetDesc
                  continue
                end

                break
              end

              if exitTo12 == 2 then
                exitTo14 = nil

                while true do
                  paragraph:SetDesc("Quest Numbers : tushita quest 1")
                  exitTo13 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo13 = 3
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            exitTo13 = 2
                            break
                          end
                        else
                          exitTo13 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo13 == 1 then
                    exitTo14 = 1
                    break
                  elseif exitTo13 == 2 then
                    continue
                  end

                  break
                end

                if exitTo14 == 1 then
                  paragraph5 = paragraph
                  setDesc4 = paragraph.SetDesc

                  while true do
                    setDesc4(paragraph5, str)
                    exitTo15 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo15 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo15 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo15 == 1 then
                      paragraph5 = paragraph
                      setDesc4 = paragraph.SetDesc
                      continue
                    end

                    break
                  end

                  if exitTo15 == 2 then
                    exitTo17 = nil

                    while true do
                      if GetWP("Cursed Dual Katana") then
                        paragraph:SetDesc("Quest Numbers : CDK done!!")
                      end

                      exitTo16 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  exitTo16 = 2
                                  break
                                else
                                  paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                end
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                              end
                            else
                              exitTo16 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo16 == 1 then
                        exitTo17 = 1
                        break
                      elseif exitTo16 == 2 then
                        continue
                      end

                      break
                    end

                    if exitTo17 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc

                      while true do
                        setDesc2(paragraph3, str)
                        exitTo9 = nil

                        while wait(0.2) do
                          if QuestYama_1 ~= true then
                            if QuestYama_2 ~= true then
                              if QuestYama_3 ~= true then
                                if QuestTushita_1 ~= true then
                                  if QuestTushita_2 ~= true then
                                    if GetWP("Cursed Dual Katana") then
                                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                                      continue
                                    end
                                    continue
                                  end

                                  paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                              else
                                exitTo9 = 1
                                break
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : yama quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 1")
                          end
                        end

                        if exitTo9 == 1 then
                          paragraph3 = paragraph
                          setDesc2 = paragraph.SetDesc
                          continue
                        end

                        break
                      end
                    end
                  end
                elseif exitTo13 == 3 then
                  exitTo17 = nil

                  while true do
                    if GetWP("Cursed Dual Katana") then
                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                    end

                    exitTo16 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo16 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo16 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo16 == 1 then
                      exitTo17 = 1
                      break
                    elseif exitTo16 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo17 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              elseif exitTo12 == 3 then
                exitTo19 = nil

                while true do
                  if GetWP("Cursed Dual Katana") then
                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                  end

                  exitTo18 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo18 = 3
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            exitTo18 = 2
                            break
                          end
                        else
                          exitTo18 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo18 == 1 then
                    exitTo19 = 1
                    break
                  elseif exitTo18 == 2 then
                    exitTo19 = 2
                    break
                  elseif exitTo18 == 3 then
                    continue
                  end

                  break
                end

                if exitTo19 == 1 then
                  paragraph2 = paragraph
                  setDesc = paragraph.SetDesc

                  while true do
                    setDesc(paragraph2, str)
                    exitTo6 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            else
                              exitTo6 = 2
                              break
                            end
                          else
                            exitTo6 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo6 == 1 then
                      paragraph2 = paragraph
                      setDesc = paragraph.SetDesc
                      continue
                    end

                    break
                  end

                  if exitTo6 == 2 then
                    exitTo8 = nil

                    while true do
                      paragraph:SetDesc("Quest Numbers : tushita quest 1")
                      exitTo7 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              else
                                exitTo7 = 2
                                break
                              end
                            else
                              exitTo7 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo7 == 1 then
                        exitTo8 = 1
                        break
                      elseif exitTo7 == 2 then
                        continue
                      end

                      break
                    end

                    if exitTo8 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc

                      while true do
                        setDesc2(paragraph3, str)
                        exitTo9 = nil

                        while wait(0.2) do
                          if QuestYama_1 ~= true then
                            if QuestYama_2 ~= true then
                              if QuestYama_3 ~= true then
                                if QuestTushita_1 ~= true then
                                  if QuestTushita_2 ~= true then
                                    if GetWP("Cursed Dual Katana") then
                                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                                      continue
                                    end
                                    continue
                                  end

                                  paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                              else
                                exitTo9 = 1
                                break
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : yama quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 1")
                          end
                        end

                        if exitTo9 == 1 then
                          paragraph3 = paragraph
                          setDesc2 = paragraph.SetDesc
                          continue
                        end

                        break
                      end
                    end
                  end
                elseif exitTo19 == 2 then
                  exitTo8 = nil

                  while true do
                    paragraph:SetDesc("Quest Numbers : tushita quest 1")
                    exitTo7 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            else
                              exitTo7 = 2
                              break
                            end
                          else
                            exitTo7 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo7 == 1 then
                      exitTo8 = 1
                      break
                    elseif exitTo7 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo8 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              end
            elseif exitTo33 == 3 then
              exitTo14 = nil

              while true do
                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                exitTo13 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          if QuestTushita_2 ~= true then
                            exitTo13 = 3
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 2")
                          end
                        else
                          exitTo13 = 2
                          break
                        end
                      else
                        exitTo13 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo13 == 1 then
                  exitTo14 = 1
                  break
                elseif exitTo13 == 2 then
                  continue
                end

                break
              end

              if exitTo14 == 1 then
                paragraph5 = paragraph
                setDesc4 = paragraph.SetDesc

                while true do
                  setDesc4(paragraph5, str)
                  exitTo15 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo15 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo15 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo15 == 1 then
                    paragraph5 = paragraph
                    setDesc4 = paragraph.SetDesc
                    continue
                  end

                  break
                end

                if exitTo15 == 2 then
                  exitTo17 = nil

                  while true do
                    if GetWP("Cursed Dual Katana") then
                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                    end

                    exitTo16 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo16 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo16 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo16 == 1 then
                      exitTo17 = 1
                      break
                    elseif exitTo16 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo17 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              elseif exitTo13 == 3 then
                exitTo17 = nil

                while true do
                  if GetWP("Cursed Dual Katana") then
                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                  end

                  exitTo16 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo16 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo16 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo16 == 1 then
                    exitTo17 = 1
                    break
                  elseif exitTo16 == 2 then
                    continue
                  end

                  break
                end

                if exitTo17 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              end
            end
          else
            local exitTo36 = nil

            while true do
              paragraph:SetDesc("Quest Numbers : tushita quest 1")
              local exitTo35 = nil

              while wait(0.2) do
                if QuestYama_1 ~= true then
                  if QuestYama_2 ~= true then
                    exitTo35 = 1
                    break
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 2")
                  end
                else
                  paragraph:SetDesc("Quest Numbers : yama quest 1")
                end
              end

              if exitTo35 == 1 then
                if QuestYama_3 ~= true then
                  if QuestTushita_1 ~= true then
                    exitTo36 = 2
                    break
                  else
                    continue
                  end
                else
                  exitTo36 = 1
                  break
                end
              end

              break
            end

            if exitTo36 == 1 then
              paragraph6 = paragraph
              setDesc5 = paragraph.SetDesc

              while true do
                setDesc5(paragraph6, str)
                exitTo26 = nil

                while wait(0.2) do
                  if QuestYama_1 ~= true then
                    if QuestYama_2 ~= true then
                      if QuestYama_3 ~= true then
                        if QuestTushita_1 ~= true then
                          exitTo26 = 2
                          break
                        else
                          paragraph:SetDesc("Quest Numbers : tushita quest 1")
                        end
                      else
                        exitTo26 = 1
                        break
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 2")
                    end
                  else
                    paragraph:SetDesc("Quest Numbers : yama quest 1")
                  end
                end

                if exitTo26 == 1 then
                  paragraph6 = paragraph
                  setDesc5 = paragraph.SetDesc
                  continue
                end

                break
              end

              if exitTo26 == 2 then
                exitTo27 = nil

                while true do
                  if QuestTushita_2 ~= true then
                    exitTo27 = 1
                    break
                  else
                    paragraph:SetDesc("Quest Numbers : tushita quest 2")
                    exitTo28 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              exitTo28 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo28 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo28 == 1 then
                      exitTo27 = 2
                      break
                    elseif exitTo28 == 2 then
                      continue
                    end

                    break
                  end
                end

                if exitTo27 == 1 then
                  exitTo17 = nil

                  while true do
                    if GetWP("Cursed Dual Katana") then
                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                    end

                    exitTo16 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo16 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo16 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo16 == 1 then
                      exitTo17 = 1
                      break
                    elseif exitTo16 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo17 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                elseif exitTo27 == 2 then
                  paragraph5 = paragraph
                  setDesc4 = paragraph.SetDesc

                  while true do
                    setDesc4(paragraph5, str)
                    exitTo15 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo15 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo15 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo15 == 1 then
                      paragraph5 = paragraph
                      setDesc4 = paragraph.SetDesc
                      continue
                    end

                    break
                  end

                  if exitTo15 == 2 then
                    exitTo17 = nil

                    while true do
                      if GetWP("Cursed Dual Katana") then
                        paragraph:SetDesc("Quest Numbers : CDK done!!")
                      end

                      exitTo16 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  exitTo16 = 2
                                  break
                                else
                                  paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                end
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                              end
                            else
                              exitTo16 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo16 == 1 then
                        exitTo17 = 1
                        break
                      elseif exitTo16 == 2 then
                        continue
                      end

                      break
                    end

                    if exitTo17 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc

                      while true do
                        setDesc2(paragraph3, str)
                        exitTo9 = nil

                        while wait(0.2) do
                          if QuestYama_1 ~= true then
                            if QuestYama_2 ~= true then
                              if QuestYama_3 ~= true then
                                if QuestTushita_1 ~= true then
                                  if QuestTushita_2 ~= true then
                                    if GetWP("Cursed Dual Katana") then
                                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                                      continue
                                    end
                                    continue
                                  end

                                  paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 1")
                              else
                                exitTo9 = 1
                                break
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : yama quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 1")
                          end
                        end

                        if exitTo9 == 1 then
                          paragraph3 = paragraph
                          setDesc2 = paragraph.SetDesc
                          continue
                        end

                        break
                      end
                    end
                  end
                end
              end
            elseif exitTo36 == 2 then
              exitTo27 = nil

              while true do
                if QuestTushita_2 ~= true then
                  exitTo27 = 1
                  break
                else
                  paragraph:SetDesc("Quest Numbers : tushita quest 2")
                  exitTo28 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            exitTo28 = 2
                            break
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo28 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo28 == 1 then
                    exitTo27 = 2
                    break
                  elseif exitTo28 == 2 then
                    continue
                  end

                  break
                end
              end

              if exitTo27 == 1 then
                exitTo17 = nil

                while true do
                  if GetWP("Cursed Dual Katana") then
                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                  end

                  exitTo16 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo16 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo16 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo16 == 1 then
                    exitTo17 = 1
                    break
                  elseif exitTo16 == 2 then
                    continue
                  end

                  break
                end

                if exitTo17 == 1 then
                  paragraph3 = paragraph
                  setDesc2 = paragraph.SetDesc

                  while true do
                    setDesc2(paragraph3, str)
                    exitTo9 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                if GetWP("Cursed Dual Katana") then
                                  paragraph:SetDesc("Quest Numbers : CDK done!!")
                                  continue
                                end
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              continue
                            end

                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          else
                            exitTo9 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo9 == 1 then
                      paragraph3 = paragraph
                      setDesc2 = paragraph.SetDesc
                      continue
                    end

                    break
                  end
                end
              elseif exitTo27 == 2 then
                paragraph5 = paragraph
                setDesc4 = paragraph.SetDesc

                while true do
                  setDesc4(paragraph5, str)
                  exitTo15 = nil

                  while wait(0.2) do
                    if QuestYama_1 ~= true then
                      if QuestYama_2 ~= true then
                        if QuestYama_3 ~= true then
                          if QuestTushita_1 ~= true then
                            if QuestTushita_2 ~= true then
                              exitTo15 = 2
                              break
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 2")
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : tushita quest 1")
                          end
                        else
                          exitTo15 = 1
                          break
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 2")
                      end
                    else
                      paragraph:SetDesc("Quest Numbers : yama quest 1")
                    end
                  end

                  if exitTo15 == 1 then
                    paragraph5 = paragraph
                    setDesc4 = paragraph.SetDesc
                    continue
                  end

                  break
                end

                if exitTo15 == 2 then
                  exitTo17 = nil

                  while true do
                    if GetWP("Cursed Dual Katana") then
                      paragraph:SetDesc("Quest Numbers : CDK done!!")
                    end

                    exitTo16 = nil

                    while wait(0.2) do
                      if QuestYama_1 ~= true then
                        if QuestYama_2 ~= true then
                          if QuestYama_3 ~= true then
                            if QuestTushita_1 ~= true then
                              if QuestTushita_2 ~= true then
                                exitTo16 = 2
                                break
                              else
                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                              end
                            else
                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            end
                          else
                            exitTo16 = 1
                            break
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 2")
                        end
                      else
                        paragraph:SetDesc("Quest Numbers : yama quest 1")
                      end
                    end

                    if exitTo16 == 1 then
                      exitTo17 = 1
                      break
                    elseif exitTo16 == 2 then
                      continue
                    end

                    break
                  end

                  if exitTo17 == 1 then
                    paragraph3 = paragraph
                    setDesc2 = paragraph.SetDesc

                    while true do
                      setDesc2(paragraph3, str)
                      exitTo9 = nil

                      while wait(0.2) do
                        if QuestYama_1 ~= true then
                          if QuestYama_2 ~= true then
                            if QuestYama_3 ~= true then
                              if QuestTushita_1 ~= true then
                                if QuestTushita_2 ~= true then
                                  if GetWP("Cursed Dual Katana") then
                                    paragraph:SetDesc("Quest Numbers : CDK done!!")
                                    continue
                                  end
                                  continue
                                end

                                paragraph:SetDesc("Quest Numbers : tushita quest 2")
                                continue
                              end

                              paragraph:SetDesc("Quest Numbers : tushita quest 1")
                            else
                              exitTo9 = 1
                              break
                            end
                          else
                            paragraph:SetDesc("Quest Numbers : yama quest 2")
                          end
                        else
                          paragraph:SetDesc("Quest Numbers : yama quest 1")
                        end
                      end

                      if exitTo9 == 1 then
                        paragraph3 = paragraph
                        setDesc2 = paragraph.SetDesc
                        continue
                      end

                      break
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end)

Q = tbl.Quests:AddToggle({
  Name = "Auto Get CDK [ Last Quest ]",
  Description = "",
  Default = false,
  Callback = function(cdk)
    _G.CDK = cdk
  end,
})

do
  local n23 = nil
  local n24 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Yama CDK",
    Description = "",
    Default = false,
    Callback = function(cdkYm)
      n23 = 143161327
      n24 = 91789391
      _G.CDK_YM = cdkYm
    end,
  })
end

Q = tbl.Quests:AddToggle({
  Name = "Auto Tushita CDK",
  Description = "",
  Default = false,
  Callback = function(cdkTs)
    _G.CDK_TS = cdkTs
  end,
})

tbl.Quests:AddSection("True Triple Katana Sword")
local n23 = nil

tbl.Quests:AddButton({
  Name = "Buy Legendary Sword",
  Description = "",
  Callback = function()
    n23 = 343759994
    replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")
    replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
    replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")
  end,
})

tbl.Quests:AddButton({
  Name = "Buy True Triple Katana Sword",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("MysteriousMan", "2")
  end,
})

Q = tbl.Quests:AddToggle({
  Name = "Tween to Legendary Sword Dealer",
  Description = "",
  Default = false,
  Callback = function(tpLgS)
    _G.Tp_LgS = tpLgS
  end,
})

tbl.Quests:AddSection("Pole / God Enal's")

do
  local n24 = nil
  local n25 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Pole V1",
    Description = "",
    Default = false,
    Callback = function(autoPole)
      n24 = 518763879
      n25 = 899140058
      _G.AutoPole = autoPole
    end,
  })
end

Q = tbl.Quests:AddToggle({
  Name = "Auto Pole V2 [Beta]",
  Description = "",
  Default = false,
  Callback = function(autoPoleV2)
    _G.AutoPoleV2 = autoPoleV2
  end,
})

tbl.Quests:AddToggle({
  Name = "Auto Saw Sword",
  Description = "",
  Default = false,
  Callback = function(autoSaw)
    _G.AutoSaw = autoSaw
  end,
})

Q = tbl.Quests:AddToggle({
  Name = "Auto Saber Sword",
  Description = "",
  Default = false,
  Callback = function(autoSaber)
    _G.AutoSaber = autoSaber
  end,
})

do
  local n24 = nil
  local n25 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Cybrog",
    Description = "",
    Default = false,
    Callback = function(autoColShad)
      n24 = 572522368
      n25 = 123936271
      _G.AutoColShad = autoColShad
    end,
  })
end

Q = tbl.Quests:AddToggle({
  Name = "Auto Usoap's Hat",
  Description = "",
  Default = false,
  Callback = function(autoGetUsoap)
    _G.AutoGetUsoap = autoGetUsoap
  end,
})

Q = tbl.Quests:AddToggle({
  Name = "Auto Bisento V2",
  Description = "",
  Default = false,
  Callback = function(greybeard)
    _G.Greybeard = greybeard
  end,
})

do
  local n24 = nil
  local n25 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Warden Sword",
    Description = "",
    Default = false,
    Callback = function(wardenBoss)
      n24 = 854853774
      n25 = 180317805
      _G.WardenBoss = wardenBoss
    end,
  })
end

Q = tbl.Quests:AddToggle({
  Name = "Auto Marine Coat",
  Description = "",
  Default = false,
  Callback = function(marinesCoat)
    _G.MarinesCoat = marinesCoat
  end,
})

local n24 = nil

Q = tbl.Quests:AddToggle({
  Name = "Auto Swan Coat",
  Description = "",
  Default = false,
  Callback = function(swanCoat)
    n24 = 210348888
    _G.SwanCoat = swanCoat
  end,
})

tbl.Quests:AddSection("Rengoku Sword")

Q = tbl.Quests:AddToggle({
  Name = "Auto Rengoku Sword",
  Description = "",
  Default = false,
  Callback = function(iceBossRen)
    _G.IceBossRen = iceBossRen
  end,
})

Q = tbl.Quests:AddToggle({
  Name = "Auto Key Rengoku",
  Description = "",
  Default = false,
  Callback = function(keysRen)
    _G.KeysRen = keysRen
  end,
})

Q = tbl.Quests:AddToggle({
  Name = "Auto Dragon Trident",
  Description = "",
  Default = false,
  Callback = function(autoTridentW2)
    _G.AutoTridentW2 = autoTridentW2
  end,
})

local n25 = nil

Q = tbl.Quests:AddToggle({
  Name = "Auto Long Sword",
  Description = "",
  Default = false,
  Callback = function(longsWord)
    n25 = 494440262
    _G.LongsWord = longsWord
  end,
})

do
  local n26 = nil
  local n27 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Black Spikey",
    Description = "",
    Default = false,
    Callback = function(blackSpikey)
      n26 = 494312787
      n27 = 302639079
      _G.BlackSpikey = blackSpikey
    end,
  })
end

Q = tbl.Quests:AddToggle({
  Name = "Auto Dark Blade V3",
  Description = "",
  Default = false,
  Callback = function(darkBladev3)
    _G.DarkBladev3 = darkBladev3
  end,
})

do
  local n26 = nil
  local n27 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Midnight Blade",
    Description = "",
    Default = false,
    Callback = function(autoEcBoss)
      n26 = 243262003
      n27 = 815179469
      _G.AutoEcBoss = autoEcBoss
    end,
  })
end

do
  local n26 = nil
  local n27 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Darkbeard",
    Description = "",
    Default = false,
    Callback = function(autoDefDarkCoat)
      n26 = 339454072
      n27 = 740611486
      _G.Auto_Def_DarkCoat = autoDefDarkCoat
    end,
  })
end

do
  local n26 = nil
  local n27 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Unlocked DonSwan",
    Description = "",
    Default = false,
    Callback = function(autoDonAcces)
      n26 = 547968898
      n27 = 221499729
      _G.Auto_DonAcces = autoDonAcces
    end,
  })
end

Q = tbl.Quests:AddToggle({
  Name = "Auto Swan Glasses",
  Description = "",
  Default = false,
  Callback = function(autoSwanGG)
    _G.Auto_SwanGG = autoSwanGG
  end,
})

tbl.Quests:AddSection("Cavender + Twin Hooks + Bigmom")

do
  local n26 = nil
  local n27 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Bigmom",
    Description = "",
    Default = false,
    Callback = function(autoBigmom)
      n26 = 775857844
      n27 = 781029094
      _G.AutoBigmom = autoBigmom
    end,
  })
end

Q = tbl.Quests:AddToggle({
  Name = "Auto Canvendish Sword",
  Description = "",
  Default = false,
  Callback = function(autoCavender)
    _G.Auto_Cavender = autoCavender
  end,
})

Q = tbl.Quests:AddToggle({
  Name = "Auto Twin Hooks",
  Description = "",
  Default = false,
  Callback = function(twinHook)
    _G.TwinHook = twinHook
  end,
})

Q = tbl.Quests:AddToggle({
  Name = "Auto Serpent Bow",
  Description = "",
  Default = false,
  Callback = function(autoSerpentBow)
    _G.AutoSerpentBow = autoSerpentBow
  end,
})

do
  local n26 = nil
  local n27 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Lei Accessory",
    Description = "",
    Default = false,
    Callback = function(autoKilo)
      n26 = 467614460
      n27 = 441689955
      _G.AutoKilo = autoKilo
    end,
  })
end

tbl.Quests:AddSection("Buso/Aura Colours")

Q = tbl.Quests:AddToggle({
  Name = "Auto Teleport Barista Cousin",
  Description = "",
  Default = false,
  Callback = function(tpMasterA)
    _G.Tp_MasterA = tpMasterA
  end,
})

local n26 = nil

tbl.Quests:AddButton({
  Name = "Buy Buso Colors",
  Description = "",
  Callback = function()
    n26 = 700989614
    replicated.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
  end,
})

do
  local n27 = nil
  local n28 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Rainbow Colors",
    Description = "",
    Default = false,
    Callback = function(autoRainbowHaki)
      n27 = 1060425011
      n28 = 960757799
      _G.Auto_Rainbow_Haki = autoRainbowHaki
    end,
  })
end

local n27 = nil

Q = tbl.Quests:AddToggle({
  Name = "Accept Rainbow Quest Faster",
  Description = "",
  Default = false,
  Callback = function(getQFast)
    n27 = 883354946
    _G.GetQFast = getQFast
  end,
})

tbl.Quests:AddSection("Instinct / Observation")

do
  local n28 = nil
  local n29 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Farm Observation",
    Description = "",
    Default = false,
    Callback = function(obsFarm)
      n28 = 718728732
      n29 = 537539272
      _G.obsFarm = obsFarm
    end,
  })
end

do
  local n28 = nil
  local n29 = nil

  Q = tbl.Quests:AddToggle({
    Name = "Auto Observation V2",
    Description = "",
    Default = false,
    Callback = function(autoKenVTWO)
      n28 = 383422226
      n29 = 278487306
      _G.AutoKenVTWO = autoKenVTWO
    end,
  })
end

do
  local n28 = nil
  local n29 = nil

  Bartilo = tbl.Quests:AddToggle({
    Name = "Auto Done Bartilo Quest",
    Description = "",
    Default = false,
    Callback = function(bartiloQuest)
      n28 = 651443665
      n29 = 667672167
      _G.Bartilo_Quest = bartiloQuest
    end,
  })
end

CitizenQ = tbl.Quests:AddToggle({
  Name = "Auto Done Citizen Quest",
  Description = "",
  Default = false,
  Callback = function(citizenQuest)
    _G.CitizenQuest = citizenQuest
  end,
})

Q = tbl.Quests:AddToggle({
  Name = "Auto Training Dummy",
  Description = "",
  Default = false,
  Callback = function(dummyMan)
    _G.DummyMan = dummyMan
  end,
})

tbl.Quests:AddSection("Fighting Melee Styles")

SuperHuman = tbl.Quests:AddToggle({
  Name = "Auto Superhuman",
  Description = "",
  Default = false,
  Callback = function(autoSuperHuman)
    _G.Auto_SuperHuman = autoSuperHuman
  end,
})

DeathStep = tbl.Quests:AddToggle({
  Name = "Auto DeathStep",
  Description = "",
  Default = false,
  Callback = function(autoDeathStep)
    _G.AutoDeathStep = autoDeathStep
  end,
})

SharkManV2 = tbl.Quests:AddToggle({
  Name = "Auto Sharkman Karate",
  Description = "",
  Default = false,
  Callback = function(autoSharkManKarate)
    _G.Auto_SharkMan_Karate = autoSharkManKarate
  end,
})

ElectricClaw = tbl.Quests:AddToggle({
  Name = "Auto ElectricClaw",
  Description = "",
  Default = false,
  Callback = function(autoElectricClaw)
    _G.Auto_Electric_Claw = autoElectricClaw
  end,
})

local n28 = nil

DragonTalon = tbl.Quests:AddToggle({
  Name = "Auto DragonTalon",
  Description = "",
  Default = false,
  Callback = function(autoDragonTalon)
    n28 = 173168126
    _G.AutoDragonTalon = autoDragonTalon
  end,
})

Godhuman = tbl.Quests:AddToggle({
  Name = "Auto Godhuman",
  Description = "",
  Default = false,
  Callback = function(autoGodHuman)
    _G.Auto_God_Human = autoGodHuman
  end,
})

SanguineArt = tbl.Quests:AddToggle({
  Name = "Auto SanguineArt",
  Description = "",
  Default = false,
  Callback = function(snaguine)
    _G.Snaguine = snaguine
  end,
})

tbl.Race:AddSection("Mystic Island / Full Moon")

do
  local fullMoonStatusParagraph = tbl.Race:AddParagraph("FullMoon Status", "")
  local mirageIslandStatusParagraph = tbl.Race:AddParagraph("Mirage Island Status", "")
  local n29 = nil
  local n30 = nil

  spawn(function()
    n29 = 641748994
    n30 = 920253683

    if wait(0.2) then
      local exitTo2, map

      if workspace.Map:FindFirstChild("MysticIsland") then
        local exitTo = nil

        while true do
          mirageIslandStatusParagraph:SetDesc("Mirage Island : True")

          if wait(0.2) then
            if not workspace.Map:FindFirstChild("MysticIsland") then
              exitTo = 1
              break
            end
          else
            break
          end
        end

        if exitTo == 1 then
          while true do
            local locations = workspace._WorldOrigin.Locations

            if locations:FindFirstChild("Mirage Island") then
              exitTo2 = nil

              while true do
                mirageIslandStatusParagraph:SetDesc("Mirage Island : True")

                if wait(0.2) then
                  map = workspace.Map

                  if map:FindFirstChild("MysticIsland") then
                    continue
                  else
                    exitTo2 = 1
                    break
                  end
                end

                break
              end

              if exitTo2 == 1 then
                continue
              end
              break
            else
              mirageIslandStatusParagraph:SetDesc("Mirage Island : False")

              if wait(0.2) then
                map = workspace.Map

                if map:FindFirstChild("MysticIsland") then
                  exitTo2 = nil

                  while true do
                    mirageIslandStatusParagraph:SetDesc("Mirage Island : True")

                    if wait(0.2) then
                      map = workspace.Map

                      if map:FindFirstChild("MysticIsland") then
                        continue
                      else
                        exitTo2 = 1
                        break
                      end
                    end

                    break
                  end

                  if exitTo2 == 1 then
                    continue
                  end
                else
                  continue
                end
              end

              break
            end
          end
        end
      else
        local exitTo3 = nil

        while true do
          if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
            exitTo3 = 1
            break
          else
            mirageIslandStatusParagraph:SetDesc("Mirage Island : False")

            if wait(0.2) then
              if workspace.Map:FindFirstChild("MysticIsland") then
                exitTo3 = 1
                break
              else
                continue
              end
            end

            break
          end
        end

        if exitTo3 == 1 then
          local exitTo4 = nil

          while true do
            mirageIslandStatusParagraph:SetDesc("Mirage Island : True")

            if wait(0.2) then
              map = workspace.Map

              if map:FindFirstChild("MysticIsland") then
                continue
              else
                exitTo4 = 1
                break
              end
            end

            break
          end

          if exitTo4 == 1 then
            while true do
              if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
                exitTo2 = nil

                while true do
                  mirageIslandStatusParagraph:SetDesc("Mirage Island : True")

                  if wait(0.2) then
                    map = workspace.Map

                    if map:FindFirstChild("MysticIsland") then
                      continue
                    else
                      exitTo2 = 1
                      break
                    end
                  end

                  break
                end

                if exitTo2 == 1 then
                  continue
                end
                break
              else
                mirageIslandStatusParagraph:SetDesc("Mirage Island : False")

                if wait(0.2) then
                  map = workspace.Map

                  if map:FindFirstChild("MysticIsland") then
                    exitTo2 = nil

                    while true do
                      mirageIslandStatusParagraph:SetDesc("Mirage Island : True")

                      if wait(0.2) then
                        map = workspace.Map

                        if map:FindFirstChild("MysticIsland") then
                          continue
                        else
                          exitTo2 = 1
                          break
                        end
                      end

                      break
                    end

                    if exitTo2 == 1 then
                      continue
                    end
                  else
                    continue
                  end
                end

                break
              end
            end
          end
        end
      end
    end
  end)

  local n31 = nil
  local n32 = nil

  spawn(function()
    n31 = 533102104
    n32 = 520867806

    if wait(0.2) then
      repeat
        pcall(function()
          local v2 = Getmoon()

          if v2 ~= "http://www.roblox.com/asset/?id=9709135895" then
            if v2 ~= "http://www.roblox.com/asset/?id=9709139597" then
              if v2 ~= "http://www.roblox.com/asset/?id=9709143733" then
                if v2 ~= "http://www.roblox.com/asset/?id=9709149052" then
                  if v2 ~= "http://www.roblox.com/asset/?id=9709149431" then
                    if v2 ~= "http://www.roblox.com/asset/?id=9709149680" then
                      if v2 ~= "http://www.roblox.com/asset/?id=9709150086" then
                        if v2 == "http://www.roblox.com/asset/?id=9709150401" then
                          fullMoonStatusParagraph:SetDesc("Moon : 7 / 8")
                        end
                      else
                        fullMoonStatusParagraph:SetDesc("Moon : 6 / 8")
                      end
                    else
                      fullMoonStatusParagraph:SetDesc("Moon : 5 / 8 [ Last Night ]")
                    end
                  else
                    fullMoonStatusParagraph:SetDesc("Moon : 4 / 8 [ Full Moon ]")
                  end
                else
                  fullMoonStatusParagraph:SetDesc("Moon : 3 / 8 [ Next Night ]")
                end
              else
                fullMoonStatusParagraph:SetDesc("Moon : 2 / 8")
              end
            else
              fullMoonStatusParagraph:SetDesc("Moon : 1 / 8")
            end
          else
            fullMoonStatusParagraph:SetDesc("Moon : 0 / 8")
          end
        end)
      until not wait(0.2)
    end
  end)
end

local n29 = nil

tbl.Race:AddToggle({
  Name = "Auto Find Mirage Island",
  Description = "",
  Default = false,
  Callback = function(findMirage)
    n29 = 85557401
    _G.FindMirage = findMirage
  end,
})

tbl.Race:AddToggle({
  Name = "Esp Mirage Island",
  Description = "",
  Value = false,
  Callback = function(arg)
    MirageIslandESP = arg

    if MirageIslandESP then
      local v2, v3

      task.spawn(function()
        while MirageIslandESP do
          if UpdateIslandMirageESP then
            UpdateIslandMirageESP()
          end

          task.wait(1)
        end
      end)
    elseif UpdateIslandMirageESP then
      UpdateIslandMirageESP()
    end
  end,
})

tbl.Race:AddToggle({
  Name = "Auto Tween To Mirage Island",
  Description = "",
  Default = false,
  Callback = function(autoMysticIsland)
    _G.AutoMysticIsland = autoMysticIsland
  end,
})

tbl.Race:AddToggle({
  Name = "Auto Tween To Highest Point",
  Description = "",
  Default = false,
  Callback = function(highestMirage)
    _G.HighestMirage = highestMirage
  end,
})

tbl.Race:AddToggle({
  Name = "Auto Collect Gear",
  Description = "",
  Default = false,
  Callback = function(tpgear)
    _G.TPGEAR = tpgear
  end,
})

tbl.Race:AddToggle({
  Name = "Change Transparency can see",
  Description = "",
  Default = false,
  Callback = function(can)
    _G.can = can
  end,
})

local n30 = nil

tbl.Race:AddToggle({
  Name = "Auto Tween Advanced Fruit Dealer",
  Description = "",
  Default = false,
  Callback = function(addealer)
    n30 = 873991738
    _G.Addealer = addealer
  end,
})

tbl.Race:AddToggle({
  Name = "Auto Collect Mirage Chest",
  Description = "",
  Default = false,
  Callback = function(farmChestM)
    _G.FarmChestM = farmChestM
  end,
})

tbl.Race:AddButton({
  Name = "Talk With Stone",
  Description = "",
  Callback = function()
    replicated
      :WaitForChild("Remotes")
      :WaitForChild("CommF_")
      :InvokeServer("RaceV4Progress", "Begin")
    replicated
      :WaitForChild("Remotes")
      :WaitForChild("CommF_")
      :InvokeServer("RaceV4Progress", "Check")
    replicated
      :WaitForChild("Remotes")
      :WaitForChild("CommF_")
      :InvokeServer("RaceV4Progress", "Teleport")
    replicated
      :WaitForChild("Remotes")
      :WaitForChild("CommF_")
      :InvokeServer("RaceV4Progress", "Continue")
  end,
})

tbl.Race:AddToggle({
  Name = "Auto Look At Moon",
  Description = "",
  Default = false,
  Callback = function(arg)
    LookM = arg
  end,
})

tbl.Race:AddToggle({
  Name = "Look Moon + Auto V3",
  Description = "",
  Default = false,
  Callback = function(arg)
    LookMV3 = arg
  end,
})

tbl.Race:AddSection("Upgrade Races V2 And V3")
local n31 = nil

RaceMink = tbl.Race:AddToggle({
  Name = "Auto Upgrade Mink",
  Description = "",
  Default = false,
  Callback = function(autoMink)
    n31 = 38028260
    _G.Auto_Mink = autoMink
  end,
})

RaceHuman = tbl.Race:AddToggle({
  Name = "Auto Upgrade Human",
  Description = "",
  Default = false,
  Callback = function(autoHuman)
    _G.Auto_Human = autoHuman
  end,
})

RaceSky = tbl.Race:AddToggle({
  Name = "Auto Upgrade Angel",
  Description = "",
  Default = false,
  Callback = function(autoSkypiea)
    _G.Auto_Skypiea = autoSkypiea
  end,
})

RaceFish = tbl.Race:AddToggle({
  Name = "Auto Upgrade FishMan",
  Description = "",
  Default = false,
  Callback = function(autoFish)
    _G.Auto_Fish = autoFish
  end,
})

tbl.Race:AddSection("Trials Quest V4")
local tiersV4StatusParagraph = tbl.Race:AddParagraph("Tiers V4 Status", "")

spawn(function()
  local n32 = nil

  pcall(function()
    n32 = 192101871

    if wait(0.2) then
      local tiersV4StatusParagraph2 = tiersV4StatusParagraph
      local setDesc = tiersV4StatusParagraph.SetDesc
      local str = " " .. plr.Data.Race.C.Value

      while true do
        setDesc(tiersV4StatusParagraph2, "Tiers - V4 : " .. str)

        if wait(0.2) then
          tiersV4StatusParagraph2 = tiersV4StatusParagraph
          setDesc = tiersV4StatusParagraph.SetDesc
          str = " " .. plr.Data.Race.C.Value
        else
          break
        end
      end
    end
  end)
end)

PullLv = tbl.Race:AddToggle({
  Name = "Auto Pull Lever",
  Description = "",
  Default = false,
  Callback = function(lver)
    _G.Lver = lver
  end,
})

local n32 = nil

Train = tbl.Race:AddToggle({
  Name = "Auto Train V4",
  Description = "",
  Default = false,
  Callback = function(acientOne)
    n32 = 617148653
    _G.AcientOne = acientOne
  end,
})

do
  local n33 = nil
  local n34 = nil

  tbl.Race:AddButton({
    Name = "Teleport to Temple of Time",
    Description = "",
    Callback = function()
      n33 = 390815948
      n34 = 160105193
      local localPlayer = game:GetService("Players").LocalPlayer
      local character = localPlayer.Character

      if character then
        character = localPlayer.Character:FindFirstChild("HumanoidRootPart")
      end

      if character then
        character.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
      end

      if not game:GetService("Workspace").Map:FindFirstChild("Temple of Time") and World3 then
        local mapStash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")

        if mapStash and mapStash:FindFirstChild("Temple of Time") then
          mapStash["Temple of Time"].Parent = workspace.Map
        end
      end
    end,
  })
end

tbl.Race:AddButton({
  Name = "Teleport to Ancient One",
  Description = "",
  Callback = function()
    local localPlayer = game:GetService("Players").LocalPlayer

    if localPlayer.Character then
      local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
      end
    end

    if not game:GetService("Workspace").Map:FindFirstChild("Temple of Time") and World3 then
      local mapStash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")

      if mapStash and mapStash:FindFirstChild("Temple of Time") then
        mapStash["Temple of Time"].Parent = workspace.Map
      end
    end

    task.wait(2)
    tween(CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375))
  end,
})

tbl.Race:AddButton({
  Name = "Teleport to Ancient Clock",
  Description = "",
  Callback = function()
    local localPlayer = game:GetService("Players").LocalPlayer
    local character = localPlayer.Character

    if character then
      character = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    end

    local cframe = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
    local cframe2 = CFrame.new(29549, 15069, -88)

    if character then
      character.CFrame = cframe
    end

    local n33 = nil
    local n34 = nil
    local v2, v3

    task.delay(2, function()
      n33 = 73256290
      n34 = 435775731
      _tp(cframe2)
    end)

    if not workspace.Map:FindFirstChild("Temple of Time") and World3 then
      local mapStash = game:GetService("ReplicatedStorage"):FindFirstChild("MapStash")

      if mapStash and mapStash:FindFirstChild("Temple of Time") then
        mapStash["Temple of Time"].Parent = workspace.Map
      end
    end
  end,
})

do
  local n33 = nil
  local n34 = nil

  Doors = tbl.Race:AddToggle({
    Name = "Auto Teleport to Race Doors",
    Description = "",
    Default = false,
    Callback = function(tpDoor)
      n33 = 1058545742
      n34 = 9277180
      _G.TPDoor = tpDoor
    end,
  })
end

do
  local n33 = nil
  local n34 = nil

  Trials = tbl.Race:AddToggle({
    Name = "Auto Complete Trial Race",
    Description = "",
    Default = false,
    Callback = function(completeTrials)
      n33 = 198970564
      n34 = 200465144
      _G.Complete_Trials = completeTrials
    end,
  })
end

AutoKill = tbl.Race:AddToggle({
  Name = "Auto Kill Player After Trial",
  Description = "",
  Default = false,
  Callback = function(defeating)
    _G.Defeating = defeating
  end,
})

tbl.Prehistoric:AddSection("Dojo Quest")

tbl.Prehistoric:AddButton({
  Title = "Teleport To Dragon Dojo",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
      "requestEntrance",
      Vector3.new(5661.5322265625, 1013.0907592773438, -334.9649963378906)
    )
    _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
  end,
})

DojoQ = tbl.Prehistoric:AddToggle({
  Name = "Auto Dojo Trainer",
  Description = "",
  Default = false,
  Callback = function(dojoo)
    _G.Dojoo = dojoo
  end,
})

BlazeEM = tbl.Prehistoric:AddToggle({
  Name = "Auto Dragon Hunter",
  Description = "",
  Default = false,
  Callback = function(farmBlazeEM)
    _G.FarmBlazeEM = farmBlazeEM
  end,
})

tbl.Prehistoric:AddSection("Drago Trial")
local n33 = nil

Toggle = tbl.Prehistoric:AddToggle({
  Name = "Tween To Upgrade Droco Trial",
  Description = "",
  Default = false,
  Callback = function(upgDrago)
    n33 = 723809490
    _G.UPGDrago = upgDrago
  end,
})

Toggle = tbl.Prehistoric:AddToggle({
  Name = "Auto Drago (V1)",
  Description = "",
  Default = false,
  Callback = function(dragoV1)
    _G.DragoV1 = dragoV1
  end,
})

local n34 = nil

fireflower = tbl.Prehistoric:AddToggle({
  Name = "Auto Drago (V2)",
  Description = "",
  Default = false,
  Callback = function(autoFireFlowers)
    n34 = 514249207
    _G.AutoFireFlowers = autoFireFlowers
  end,
})

Toggle = tbl.Prehistoric:AddToggle({
  Name = "Auto Drago (V3)",
  Description = "",
  Default = false,
  Callback = function(dragoV3)
    _G.DragoV3 = dragoV3
  end,
})

do
  local n35 = nil
  local n36 = nil

  Toggle = tbl.Prehistoric:AddToggle({
    Name = "Auto Relic Drago Trial [Beta]",
    Description = "",
    Default = false,
    Callback = function(relic123)
      n35 = 219756131
      n36 = 1067843138
      _G.Relic123 = relic123
    end,
  })
end

Toggle = tbl.Prehistoric:AddToggle({
  Name = "Auto Train Drago v4",
  Description = "",
  Default = false,
  Callback = function(trainDrago)
    _G.TrainDrago = trainDrago
  end,
})

dragoTpVolcano = tbl.Prehistoric:AddToggle({
  Name = "Tween to Drago Trials",
  Description = "",
  Default = false,
  Callback = function(tpDragoPrehis)
    _G.TpDrago_Prehis = tpDragoPrehis
  end,
})

bdrago = tbl.Prehistoric:AddToggle({
  Name = "Swap Drago Race",
  Description = "",
  Default = false,
  Callback = function(buyDrago)
    _G.BuyDrago = buyDrago
  end,
})

local n35 = nil

UpTalon = tbl.Prehistoric:AddToggle({
  Name = "Upgrade Dragon Talon With Uzoth",
  Description = "",
  Default = false,
  Callback = function(dtUzoth)
    n35 = 556765331
    _G.DT_Uzoth = dtUzoth
  end,
})

tbl.Prehistoric:AddSection("Volcanic Crafting")

tbl.Prehistoric:AddButton({
  Name = "Craft Dragonheart",
  Description = "",
  Callback = function()
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "Dragonheart" }))
  end,
})

local n36 = nil

tbl.Prehistoric:AddButton({
  Name = "Craft Dragonstorm",
  Description = "",
  Callback = function()
    n36 = 549158270
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "Dragonstorm" }))
  end,
})

local n37 = nil

tbl.Prehistoric:AddButton({
  Name = "Craft Dino Hood",
  Callback = function()
    n37 = 371338808
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "DinoHood" }))
  end,
})

do
  local n38 = nil
  local n39 = nil

  tbl.Prehistoric:AddButton({
    Name = "Craft T-Rex Skull",
    Callback = function()
      n38 = 304729826
      n39 = 732993717
      game
        :GetService("ReplicatedStorage").Remotes.CommF_
        :InvokeServer(unpack({ "CraftItem", "Craft", "TRexSkull" }))
    end,
  })
end

tbl.Prehistoric:AddSection("Prehistoric Island")

do
  local prehistoricIslandStatusParagraph =
    tbl.Prehistoric:AddParagraph("Prehistoric Island Status", "")
  local n38 = nil

  spawn(function()
    n38 = 759512807

    if wait(0.2) then
      local exitTo = nil

      while true do
        if workspace.Map:FindFirstChild("PrehistoricIsland") then
          prehistoricIslandStatusParagraph:SetDesc("Prehistoric Island : True")
          if wait(0.2) then
            continue
          end
          break
        else
          exitTo = 1
          break
        end
      end

      if exitTo == 1 then
        while true do
          local map

          if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
            prehistoricIslandStatusParagraph:SetDesc("Prehistoric Island : False")
            if not wait(0.2) then
              break
            end
            map = workspace.Map
            if not map:FindFirstChild("PrehistoricIsland") then
              continue
            end
          end

          local exitTo2 = nil

          while true do
            prehistoricIslandStatusParagraph:SetDesc("Prehistoric Island : True")

            if wait(0.2) then
              map = workspace.Map

              if map:FindFirstChild("PrehistoricIsland") then
                continue
              else
                exitTo2 = 1
                break
              end
            end

            break
          end

          if exitTo2 == 1 then
            continue
          end
          break
        end
      end
    end
  end)
end

tbl.Prehistoric:AddButton({
  Name = "Craft Volcanic Magnet",
  Callback = function()
    game
      :GetService("ReplicatedStorage").Modules.Net["RF/Craft"]
      :InvokeServer("PossibleHardcode", "Volcanic Magnet")
  end,
})

do
  local n38 = nil
  local n39 = nil

  tbl.Prehistoric:AddToggle({
    Name = "Craft Volcanic Magnet",
    Default = false,
    Callback = function(autoCraftVolcanic)
      n38 = 709086280
      n39 = 674131807
      getgenv().AutoCraftVolcanic = autoCraftVolcanic
    end,
  })
end

tbl.Prehistoric:AddToggle({
  Name = "Auto Find Prehistoric Island",
  Description = "",
  Default = false,
  Callback = function(prehisFind)
    _G.Prehis_Find = prehisFind
    PrehisUser.Find = prehisFind
  end,
})

local n38 = nil

tbl.Prehistoric:AddToggle({
  Name = "Auto Start Prehistoric Event",
  Default = false,
  Callback = function(autoStartPrehistoric)
    n38 = 820516957
    _G.AutoStartPrehistoric = autoStartPrehistoric
  end,
})

do
  local n39 = nil
  local n40 = nil

  tbl.Prehistoric:AddToggle({
    Name = "Auto Patch Prehistoric Event",
    Description = "",
    Default = false,
    Callback = function(prehisSkills)
      n39 = 291915262
      n40 = 879200296
      _G.Prehis_Skills = prehisSkills
      PrehisUser.Skills = prehisSkills
    end,
  })
end

Kaura = tbl.Prehistoric:AddToggle({
  Name = "Kill Aura",
  Description = "",
  Default = false,
  Callback = function(killAuraFull)
    _G.KillAuraFull = killAuraFull
  end,
})

Vocan = tbl.Prehistoric:AddToggle({
  Name = "Auto Collect Dino Bones",
  Description = "",
  Default = false,
  Callback = function(prehisDb)
    _G.Prehis_DB = prehisDb
  end,
})

local n39 = nil

Vocan = tbl.Prehistoric:AddToggle({
  Name = "Auto Collect Dragon Eggs",
  Description = "",
  Default = false,
  Callback = function(prehisDe)
    n39 = 663531001
    _G.Prehis_DE = prehisDe
    PrehisUser.DE = prehisDe
  end,
})

local n40 = nil

Toggle = tbl.Prehistoric:AddToggle({
  Name = "Auto Reset When Complete Volcano",
  Description = "",
  Default = false,
  Callback = function(resetPH)
    n40 = 289674073
    _G.ResetPH = resetPH
  end,
})

tbl.SeaEvent:AddSection("Sea Event / Setting Sail")

tbl.SeaEvent:AddButton({
  Name = "Remove Lighting Effect",
  Callback = function()
    game:GetService("Lighting").BaseAtmosphere:Destroy()
  end,
})

tbl.SeaEvent:AddToggle({
  Name = "Ship Speed Modifier",
  Default = false,
  Callback = function(speedBoat)
    getgenv().SpeedBoat = speedBoat
  end,
})

local n41 = nil

-- Event listener: RenderStepped:Connect
game:GetService("RunService").RenderStepped:Connect(function()
  n41 = 455525191

  if getgenv().SpeedBoat then
    local localPlayer = game:GetService("Players").LocalPlayer

    if
      localPlayer.Character
      and localPlayer.Character:FindFirstChild("Humanoid")
      and localPlayer.Character.Humanoid.Sit
    then
      local v2, v3, v4 = pairs(game:GetService("Workspace").Boats:GetChildren())
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(v3, v4)

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local vehicleSeat = (packedValues[3]):FindFirstChildWhichIsA("VehicleSeat")

          if vehicleSeat then
            vehicleSeat.MaxSpeed = SetSpeedBoat
          end
        end
      end
    end
  end
end)

local n42 = nil

tbl.SeaEvent:AddSlider({
  Name = "Ship Speed",
  Min = 0,
  Max = 1000,
  Increment = 1,
  Default = 300,
  Callback = function(arg)
    n42 = 964619642
    SetSpeedBoat = arg
  end,
})

do
  local n43 = nil
  local n44 = nil

  tbl.SeaEvent:AddToggle({
    Name = "Auto Press W",
    Default = false,
    Callback = function(autoPressW)
      n43 = 335137055
      n44 = 685937935
      getgenv().AutoPressW = autoPressW
    end,
  })
end

tbl.SeaEvent:AddToggle({
  Name = "No Clip Ship",
  Default = false,
  Callback = function(noClipShip)
    getgenv().NoClipShip = noClipShip
  end,
})

tbl.SeaEvent:AddSection("Crafting Items")

tbl.SeaEvent:AddButton({
  Name = "Craft SharkTooth",
  Description = "",
  Callback = function()
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "SharkTooth" }))
  end,
})

do
  local n43 = nil
  local n44 = nil

  tbl.SeaEvent:AddButton({
    Name = "Craft TerrorJaw",
    Description = "",
    Callback = function()
      n43 = 583478173
      n44 = 1059511027
      game
        :GetService("ReplicatedStorage").Remotes.CommF_
        :InvokeServer(unpack({ "CraftItem", "Craft", "TerrorJaw" }))
    end,
  })
end

local n43 = nil

tbl.SeaEvent:AddButton({
  Name = "Craft SharkAnchor",
  Description = "",
  Callback = function()
    n43 = 17359483
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "SharkAnchor" }))
  end,
})

tbl.SeaEvent:AddButton({
  Name = "Craft LeviathanCrown",
  Description = "",
  Callback = function()
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "LeviathanCrown" }))
  end,
})

tbl.SeaEvent:AddButton({
  Name = "Craft LeviathanShield",
  Description = "",
  Callback = function()
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "LeviathanShield" }))
  end,
})

do
  local n44 = nil
  local n45 = nil

  tbl.SeaEvent:AddButton({
    Name = "Craft LeviathanBoat",
    Description = "",
    Callback = function()
      n44 = 111244305
      n45 = 366017107
      game
        :GetService("ReplicatedStorage").Remotes.CommF_
        :InvokeServer(unpack({ "CraftItem", "Craft", "LeviathanBoat" }))
    end,
  })
end

tbl.SeaEvent:AddButton({
  Name = "Craft LegendaryScroll",
  Description = "",
  Callback = function()
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "LegendaryScroll" }))
  end,
})

tbl.SeaEvent:AddButton({
  Name = "Craft MythicalScroll",
  Description = "",
  Callback = function()
    game
      :GetService("ReplicatedStorage").Remotes.CommF_
      :InvokeServer(unpack({ "CraftItem", "Craft", "MythicalScroll" }))
  end,
})

tbl.SeaEvent:AddSection("Choose Sea Event")

Q = tbl.SeaEvent:AddDropdown({
  Name = "Select Boats",
  Options = ListSeaBoat,
  Callback = function(selectedBoat)
    _G.SelectedBoat = selectedBoat
  end,
})

do
  local n44 = nil
  local n45 = nil

  tbl.SeaEvent:AddButton({
    Name = "Buy Boats",
    Description = "",
    Callback = function()
      n44 = 275654704
      n45 = 557400365
      replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
    end,
  })
end

do
  local n44 = nil
  local n45 = nil

  Q = tbl.SeaEvent:AddDropdown({
    Name = "Select Sea Level",
    Options = ListSeaZone,
    Callback = function(dangerSc)
      n44 = 690181949
      n45 = 1043216362
      _G.DangerSc = dangerSc
    end,
  })
end

Q = tbl.SeaEvent:AddToggle({
  Name = "Auto Sail Boat",
  Description = "",
  Default = false,
  Callback = function(sailBoats)
    _G.SailBoats = sailBoats
  end,
})

tbl.SeaEvent:AddSection("Entity Sea Event")

do
  local n44 = nil
  local n45 = nil

  tbl.SeaEvent:AddToggle({
    Name = "Auto Shark",
    Description = "",
    Default = false,
    Callback = function(shark)
      n44 = 694874167
      n45 = 558302413
      _G.Shark = shark
    end,
  })
end

do
  local n44 = nil
  local n45 = nil

  tbl.SeaEvent:AddToggle({
    Name = "Auto Piranha",
    Description = "",
    Default = false,
    Callback = function(piranha)
      n44 = 341221554
      n45 = 490297682
      _G.Piranha = piranha
    end,
  })
end

tbl.SeaEvent:AddToggle({
  Name = "Auto Terror Shark",
  Description = "",
  Default = false,
  Callback = function(terrorShark)
    _G.TerrorShark = terrorShark
  end,
})

tbl.SeaEvent:AddToggle({
  Name = "Auto Fish Crew Member",
  Description = "",
  Default = false,
  Callback = function(mobCrew)
    _G.MobCrew = mobCrew
  end,
})

local n44 = nil

tbl.SeaEvent:AddToggle({
  Name = "Auto Haunted Crew Member",
  Description = "",
  Default = false,
  Callback = function(hcm)
    n44 = 81775093
    _G.HCM = hcm
  end,
})

local n45 = nil

tbl.SeaEvent:AddToggle({
  Name = "Auto Attack PirateGrandBrigade",
  Description = "",
  Default = false,
  Callback = function(pgb)
    n45 = 180001069
    _G.PGB = pgb
  end,
})

tbl.SeaEvent:AddToggle({
  Name = "Auto Attack Fish Boat",
  Description = "",
  Default = false,
  Callback = function(fishBoat)
    _G.FishBoat = fishBoat
  end,
})

local n46 = nil

tbl.SeaEvent:AddToggle({
  Name = "Auto Attack Sea Beast",
  Description = "",
  Default = false,
  Callback = function(seaBeast1)
    n46 = 162098875
    _G.SeaBeast1 = seaBeast1
  end,
})

tbl.SeaEvent:AddSection("Kitsune Island / Event")
local kitsuneIslandStatusParagraph = tbl.SeaEvent:AddParagraph("Kitsune Island Status", "")

spawn(function()
  if wait(0.2) then
    local exitTo = nil

    while true do
      if workspace.Map:FindFirstChild("KitsuneIsland") then
        kitsuneIslandStatusParagraph:SetDesc("Kitsune Island : True")
        if wait(0.2) then
          continue
        end
        break
      else
        exitTo = 1
        break
      end
    end

    if exitTo == 1 then
      local locations = workspace._WorldOrigin.Locations

      while true do
        local map

        if not locations:FindFirstChild("Kitsune Island") then
          kitsuneIslandStatusParagraph:SetDesc("Kitsune Island : False")
          if not wait(0.2) then
            break
          end
          map = workspace.Map
          if not map:FindFirstChild("KitsuneIsland") then
            locations = workspace._WorldOrigin.Locations
            continue
          end
        end

        local exitTo2 = nil

        while true do
          kitsuneIslandStatusParagraph:SetDesc("Kitsune Island : True")

          if wait(0.2) then
            map = workspace.Map

            if map:FindFirstChild("KitsuneIsland") then
              continue
            else
              exitTo2 = 1
              break
            end
          end

          break
        end

        if exitTo2 == 1 then
          locations = workspace._WorldOrigin.Locations
          continue
        end
        break
      end
    end
  end
end)

do
  local n47 = nil
  local n48 = nil

  tbl.SeaEvent:AddToggle({
    Name = "Auto Find Kitsune Island",
    Description = "",
    Default = false,
    Callback = function(autofindKitIs)
      n47 = 740917077
      n48 = 961380742
      _G.AutofindKitIs = autofindKitIs
    end,
  })
end

local n47 = nil

tbl.SeaEvent:AddToggle({
  Name = "Auto Teleport to Shrine Actived",
  Description = "",
  Default = false,
  Callback = function(tweenShrine)
    n47 = 589263070
    _G.tweenShrine = tweenShrine
  end,
})

tbl.SeaEvent:AddToggle({
  Name = "Auto Collect Azure Ember",
  Description = "",
  Default = false,
  Callback = function(collectEmber)
    _G.Collect_Ember = collectEmber
  end,
})

tbl.SeaEvent:AddToggle({
  Name = "Auto Trade Azure Ember",
  Description = "",
  Default = false,
  Callback = function(tradeEmber)
    _G.Trade_Ember = tradeEmber
  end,
})

tbl.SeaEvent:AddButton({
  Name = "Trade Items Azure",
  Description = "",
  Callback = function()
    replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
  end,
})

tbl.SeaEvent:AddButton({
  Name = "Talk with kitsune statue",
  Description = "",
  Callback = function()
    replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
  end,
})

tbl.SeaEvent:AddSection("Frozen Dimension Event")

do
  local frozenDimensionStatusParagraph = tbl.SeaEvent:AddParagraph("FrozenDimension Status", "")
  local n48 = nil

  spawn(function()
    n48 = 910912658

    pcall(function()
      if wait(0.2) then
        local locations = workspace._WorldOrigin.Locations
        local locations2 = locations
        local findFirstChild = locations.FindFirstChild
        local str = "Frozen Dimension"
        local exitTo = nil

        while true do
          if findFirstChild(locations2, str) then
            exitTo = 1
            break
          else
            frozenDimensionStatusParagraph:SetDesc("Frozen Dimension : False")

            if wait(0.2) then
              local locations3 = workspace._WorldOrigin.Locations
              locations2 = locations3
              findFirstChild = locations3.FindFirstChild
              continue
            end

            break
          end
        end

        if exitTo == 1 then
          while true do
            frozenDimensionStatusParagraph:SetDesc("Frozen Dimension : True")
            local exitTo2 = nil

            while wait(0.2) do
              if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
                exitTo2 = 1
                break
              else
                frozenDimensionStatusParagraph:SetDesc("Frozen Dimension : False")
              end
            end

            if exitTo2 == 1 then
              continue
            end
            break
          end
        end
      end
    end)
  end)
end

do
  local spyStatusParagraph = tbl.SeaEvent:AddParagraph("Spy Status", "")
  local n48 = nil

  spawn(function()
    n48 = 164515640

    if wait(0.2) then
      repeat
        pcall(function()
          local match =
            string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")

          if match then
            spyStatusParagraph:SetDesc("Spy Leviathan : " .. tostring(match))

            if tonumber(match) == 5 then
              spyStatusParagraph:SetDesc("Spy Leviathan : Already Done!!")
            end
          end
        end)
      until not wait(0.2)
    end
  end)
end

tbl.SeaEvent:AddButton({
  Name = "Buy Spy",
  Callback = function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
  end,
})

local n48 = nil

tbl.SeaEvent:AddToggle({
  Name = "Auto Teleport Frozen Dimension",
  Description = "",
  Default = false,
  Callback = function(frozenTP)
    n48 = 783598477
    _G.FrozenTP = frozenTP
  end,
})

tbl.SeaEvent:AddToggle({
  Name = "Auto Drive To Hydra Island",
  Description = "",
  Default = false,
  Callback = function(sailBoatHydra)
    _G.SailBoat_Hydra = sailBoatHydra
  end,
})

local n49 = nil

tbl.SeaEvent:AddToggle({
  Name = "Auto Attack Leviathan",
  Description = "",
  Default = false,
  Callback = function(leviathan1)
    n49 = 668626538
    _G.Leviathan1 = leviathan1
  end,
})

tbl.Esp:AddSection("Esp")

tbl.Esp:AddToggle({
  Name = "Esp Berry",
  Description = "",
  Default = false,
  Callback = function(arg)
    BerryEsp = arg

    if arg then
      local v2, v3, v4

      task.spawn(function()
        while BerryEsp do
          berriesEsp()
          task.wait()
        end
      end)
    else
      local v2, v3, v4 = ipairs(workspace:GetChildren())
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(v3, v4)

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local v6 = packedValues[3]

          if v6:IsA("Part") and v6.Name:match("BerryEspPart_.*") then
            v6:Destroy()
          end
        end
      end
    end
  end,
})

local n50 = nil

tbl.Esp:AddToggle({
  Name = "Esp Player",
  Description = "",
  Default = false,
  Callback = function(arg)
    n50 = 960938136
    PlayerEsp = arg
    local n51 = nil
    local n52 = nil
    local n53 = nil
    local v2, v3, v4

    if arg then
      task.spawn(function()
        n51 = 981333573
        n52 = 918321055

        while PlayerEsp do
          EspPly()
          task.wait()
        end
      end)
    else
      local children
      children, v4 = game.Players:GetChildren()
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(children, v4)

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local v6 = packedValues[3]

          pcall(function()
            n53 = 272643386

            if
              not isnil(v6.Character)
              and not isnil(v6.Character.Head)
              and v6.Character.Head:FindFirstChild("NameEsp" .. Number)
            then
              v6.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
            end
          end)
        end
      end
    end
  end,
})

tbl.Esp:AddToggle({
  Name = "Esp Chest",
  Description = "",
  Default = false,
  Callback = function(arg)
    ChestESP = arg
    local n51 = nil
    local v2

    if arg then
      local v3, v4

      task.spawn(function()
        n51 = 36542958

        while ChestESP do
          ChestEsp()
          task.wait()
        end
      end)
    else
      local v3, v4
      v3, v4, v2 = ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged"))
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(v4, v2)

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local chestEspAttachment = (packedValues[3]):FindFirstChild("ChestEspAttachment")

          if chestEspAttachment then
            chestEspAttachment:Destroy()
          end
        end
      end
    end
  end,
})

tbl.Esp:AddToggle({
  Name = "Esp Fruit",
  Description = "",
  Default = false,
  Callback = function(arg)
    DevilFruitESP = arg
    local n51 = nil
    local n52 = nil
    local v2, v3, v4, v5

    if arg then
      task.spawn(function()
        if DevilFruitESP then
          DevEsp()
          task.wait()

          while DevilFruitESP do
            DevEsp()
            task.wait()
          end
        end
      end)
    else
      local children
      children, v5 = workspace:GetChildren()
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v6, v32, v42, v52, v62, v7, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v6, v32, v42, v52, v62, v7, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(children, v5)
      local packedValues = table.pack(iter_z_1())

      if packedValues[1] then
        local v7 = packedValues[3]

        while true do
          pcall(function()
            n51 = 224251596
            n52 = 109579123

            if v7:FindFirstChild("Handle") and v7.Handle:FindFirstChild("NameEsp" .. Number) then
              v7.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
          end)

          local packedValues = table.pack(iter_z_1())

          if not packedValues[1] then
            break
          else
            v7 = packedValues[3]
          end
        end
      end
    end
  end,
})

do
  local n51 = nil
  local n52 = nil

  tbl.Esp:AddToggle({
    Name = "Esp Island",
    Description = "",
    Default = false,
    Callback = function(arg)
      n51 = 256130135
      n52 = 937608034
      IslandESP = arg
      local n53 = nil
      local v2, v3

      if arg then
        task.spawn(function()
          while IslandESP do
            LocationEsp()
            task.wait()
          end
        end)
      else
        local children, v4 = workspace._WorldOrigin.Locations:GetChildren()
        local iter_z_1 = (function(f, s, var)
          local co = coroutine.wrap(function()
            coroutine.yield()
            for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
              coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
            end
          end)
          co()
          return co
        end)(children, v4)

        while true do
          local packedValues = table.pack(iter_z_1())

          if not packedValues[1] then
            break
          else
            local v6 = packedValues[3]

            pcall(function()
              n53 = 30321953

              if v6:FindFirstChild("NameEsp") then
                v6:FindFirstChild("NameEsp"):Destroy()
              end
            end)
          end
        end
      end
    end,
  })
end

tbl.Esp:AddToggle({
  Name = "Esp Flower",
  Description = "",
  Default = false,
  Callback = function(arg)
    FlowerESP = arg
    local n51 = nil
    local n52 = nil
    local v2, v3, v4, v5

    if arg then
      task.spawn(function()
        while FlowerESP do
          flowerEsp()
          task.wait()
        end
      end)
    else
      local v6, v7, v8 = pairs(workspace:GetChildren())
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v9, v32, v42, v52, v62, v72, v82, v92, v10 in f, s, var do
            coroutine.yield(true, k, v9, v32, v42, v52, v62, v72, v82, v92, v10)
          end
        end)
        co()
        return co
      end)(v7, v8)

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local v10 = packedValues[3]

          pcall(function()
            n51 = 131353217
            n52 = 713385975

            if v10.Name == "Flower2" then
              if v10:FindFirstChild("NameEsp" .. Number) then
                local nameEsp = v10:FindFirstChild("NameEsp" .. Number)
                nameEsp:Destroy()
              end
            elseif v10.Name == "Flower1" and v10:FindFirstChild("NameEsp" .. Number) then
              v10:FindFirstChild("NameEsp" .. Number):Destroy()
            end
          end)
        end
      end
    end
  end,
})

tbl.Esp:AddToggle({
  Name = "Esp Legendary Sword",
  Description = "",
  Default = false,
  Callback = function(arg)
    LegenS = arg

    if arg then
      local v2, v3, v4

      task.spawn(function()
        while LegenS do
          LegenSword()
          task.wait()
        end
      end)
    elseif workspace:FindFirstChild("Lgd") then
      workspace:FindFirstChild("Lgd"):Destroy()
    end
  end,
})

local n51 = nil

tbl.Esp:AddToggle({
  Name = "Esp Haki Color",
  Description = "",
  Default = false,
  Callback = function(arg)
    n51 = 937665072
    ColorEsp = arg
    local n52 = nil

    if arg then
      local v2, v3

      task.spawn(function()
        n52 = 433063051

        while ColorEsp do
          HakiClorEsp()
          task.wait()
        end
      end)
    elseif workspace:FindFirstChild("Gay") then
      workspace:FindFirstChild("Gay"):Destroy()
    end
  end,
})

local n52 = nil

tbl.Esp:AddToggle({
  Name = "Esp Gear",
  Description = "",
  Default = false,
  Callback = function(arg)
    n52 = 182989401
    ESPGear = arg
    local n53 = nil
    local n54 = nil
    local v2, mysticIsland

    if arg then
      task.spawn(function()
        n53 = 325399986
        n54 = 957326650

        while ESPGear do
          gearEsp()
          task.wait()
        end
      end)
    else
      local mysticIsland2 = workspace.Map:FindFirstChild("MysticIsland")
      local pairsFn = pairs
      mysticIsland = mysticIsland2

      if mysticIsland then
        mysticIsland = mysticIsland2:GetDescendants()
      end

      local v4, v5, v6 = pairsFn(mysticIsland or {})
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v7, v32, v42, v52, v62, v72, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v7, v32, v42, v52, v62, v72, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(v5, v6)

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local v8 = packedValues[3]

          pcall(function()
            if v8:FindFirstChild("NameEsp") then
              v8:FindFirstChild("NameEsp"):Destroy()
            end
          end)
        end
      end
    end
  end,
})

tbl.Esp:AddToggle({
  Name = "Esp SeaEvent Island",
  Description = "",
  Default = false,
  Callback = function(arg)
    EspEventIsland = arg
    local n53 = nil
    local v2, v3

    if arg then
      task.spawn(function()
        while EspEventIsland do
          EventIslandEsp()
          task.wait()
        end
      end)
    else
      local v4, v5, v6 = pairs(workspace._WorldOrigin.Locations:GetChildren())
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v7, v32, v42, v52, v62, v72, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v7, v32, v42, v52, v62, v72, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(v5, v6)

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local v8 = packedValues[3]

          pcall(function()
            n53 = 1026082811

            if v8:FindFirstChild("NameEsp") then
              v8:FindFirstChild("NameEsp"):Destroy()
            end
          end)
        end
      end
    end
  end,
})

tbl.Esp:AddToggle({
  Name = "Esp Advanced Dealer",
  Description = "",
  Default = false,
  Callback = function(arg)
    advanEsp = arg

    if arg then
      local v2, v3

      task.spawn(function()
        while advanEsp do
          AdvanFruitEsp()
          task.wait()
        end
      end)
    elseif workspace:FindFirstChild("Adv") then
      workspace:FindFirstChild("Adv"):Destroy()
    end
  end,
})

tbl.Raids:AddSection("Fruits Options")

do
  local stockFruitParagraph = tbl.Raids:AddParagraph("Stock Fruit", "Loading...")

  task.spawn(function()
    local v2, v3, v4

    while task.wait(60) do
      pcall(function()
        stockFruitParagraph:SetDesc(getFruitStock())
      end)
    end
  end)

  local n53 = nil
  local n54 = nil

  pcall(function()
    n53 = 388071331
    n54 = 897874573
    stockFruitParagraph:SetDesc(getFruitStock())
  end)
end

RandomFF = tbl.Raids:AddToggle({
  Name = "Auto Random Fruit",
  Description = "",
  Default = false,
  Callback = function(randomAuto)
    _G.Random_Auto = randomAuto
    _G.RandomFruitCooldown = nil
  end,
})

DropF = tbl.Raids:AddToggle({
  Name = "Auto Drop Fruit",
  Description = "",
  Default = false,
  Callback = function(dropFruit)
    _G.DropFruit = dropFruit
  end,
})

StoredF = tbl.Raids:AddToggle({
  Name = "Auto Store Fruit",
  Description = "",
  Default = false,
  Callback = function(storeF)
    _G.StoreF = storeF
  end,
})

do
  local n53 = nil
  local n54 = nil

  TwF = tbl.Raids:AddToggle({
    Name = "Auto Tween to Fruit",
    Description = "",
    Default = false,
    Callback = function(twFruits)
      n53 = 225819709
      n54 = 192659979
      _G.TwFruits = twFruits
    end,
  })
end

do
  local n53 = nil
  local n54 = nil

  BringF = tbl.Raids:AddToggle({
    Name = "Auto Collect Fruit",
    Description = "",
    Default = false,
    Callback = function(instanceF)
      n53 = 169839588
      n54 = 783034416
      _G.InstanceF = instanceF
    end,
  })
end

local n53 = nil

tbl.Raids:AddDropdown({
  Name = "Select Fruit Shop",
  Options = {
    "Rocket-Rocket",
    "Spin-Spin",
    "Blade-Blade",
    "Spring-Spring",
    "Bomb-Bomb",
    "Smoke-Smoke",
    "Spike-Spike",
    "Flame-Flame",
    "Ice-Ice",
    "Sand-Sand",
    "Dark-Dark",
    "Eagle-Eagle",
    "Diamond-Diamond",
    "Light-Light",
    "Rubber-Rubber",
    "Ghost-Ghost",
    "Magma-Magma",
    "Quake-Quake",
    "Buddha-Buddha",
    "Love-Love",
    "Creation-Creation",
    "Spider-Spider",
    "Sound-Sound",
    "Phoenix-Phoenix",
    "Portal-Portal",
    "Lightning-Lightning",
    "Pain-Pain",
    "Blizzard-Blizzard",
    "Gravity-Gravity",
    "T-Rex-T-Rex",
    "Mammoth-Mammoth",
    "Dough-Dough",
    "Shadow-Shadow",
    "Venom-Venom",
    "Gas-Gas",
    "Control-Control",
    "Spirit-Spirit",
    "Leopard-Leopard",
    "Yeti-Yeti",
    "Kitsune-Kitsune",
    "Dragon-Dragon",
  },
  Callback = function(selectFruit)
    n53 = 266066510
    getgenv().SelectFruit = selectFruit
  end,
})

local n54 = nil

tbl.Raids:AddToggle({
  Name = "Auto Buy Fruit Shop",
  Default = false,
  Callback = function(autoBuyFruitSniper)
    n54 = 351782506
    getgenv().AutoBuyFruitSniper = autoBuyFruitSniper
  end,
})

tbl.Raids:AddSection("Dungeon Event / Raiding")

DungeonTables = {
  "Flame",
  "Ice",
  "Quake",
  "Light",
  "Dark",
  "String",
  "Rumble",
  "Magma",
  "Human: Buddha",
  "Sand",
  "Bird: Phoenix",
  "Dough",
}

Q = tbl.Raids:AddDropdown({
  Name = "Select Chip",
  Description = "",
  Options = DungeonTables,
  Callback = function(selectChip)
    _G.SelectChip = selectChip
  end,
})

local n55 = nil

Q = tbl.Raids:AddToggle({
  Name = "Auto Select Dungeon Chip",
  Description = "",
  Default = false,
  Callback = function(autoSelectDungeon)
    n55 = 96858186
    _G.AutoSelectDungeon = autoSelectDungeon
  end,
})

do
  local n56 = nil
  local n57 = nil

  tbl.Raids:AddToggle({
    Name = "Get Fruit In Inventory Below 1M",
    Default = false,
    Callback = function(autoGetFruit)
      n56 = 1068927663
      n57 = 988673409
      getgenv().AutoGetFruit = autoGetFruit
    end,
  })
end

tbl.Raids:AddButton({
  Name = "Buy Dungeon Chips [Beli]",
  Description = "",
  Callback = function()
    if not GetBP("Special Microchip") then
      replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
    end
  end,
})

local n56 = nil

tbl.Raids:AddButton({
  Name = "Buy Dungeon Chips [Devil Fruit]",
  Description = "",
  Callback = function()
    n56 = 716520050
    if GetBP("Special Microchip") then
      return
    end
    local names = {}
    local response, v2 = replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits")
    local iter_z_1 = (function(f, s, var)
      local co = coroutine.wrap(function()
        coroutine.yield()
        for k, v3, v32, v4, v5, v6, v7, v8, v9, v10 in f, s, var do
          coroutine.yield(true, k, v3, v32, v4, v5, v6, v7, v8, v9, v10)
        end
      end)
      co()
      return co
    end)(response, v2)

    while true do
      local packedValues = table.pack(iter_z_1())

      if not packedValues[1] then
        break
      else
        local v4 = packedValues[3]

        if v4.Price <= 490000 then
          table.insert(names, v4.Name)
        end
      end
    end

    local v3, v4, v5 = pairs(names)
    iter_z_1 = (function(f, s, var)
      local co = coroutine.wrap(function()
        coroutine.yield()
        for k, v6, v32, v42, v52, v62, v7, v8, v9, v10 in f, s, var do
          coroutine.yield(true, k, v6, v32, v42, v52, v62, v7, v8, v9, v10)
        end
      end)
      co()
      return co
    end)(v4, v5)

    while true do
      local packedValues = table.pack(iter_z_1())

      if not packedValues[1] then
        break
      else
        local v7 = packedValues[3]
        local v8, v9, v10 = pairs(DungeonTables)
        local iter_z_2 = (function(f, s, var)
          local co = coroutine.wrap(function()
            coroutine.yield()
            for k, v11, v32, v42, v52, v62, v72, v82, v92, v102 in f, s, var do
              coroutine.yield(true, k, v11, v32, v42, v52, v62, v72, v82, v92, v102)
            end
          end)
          co()
          return co
        end)(v9, v10)
        local exitTo = nil

        while true do
          local packedValues = table.pack(iter_z_2())

          if not packedValues[1] then
            break
          elseif not GetBP("Special Microchip") then
            exitTo = 1
            break
          end
        end

        if exitTo == 1 then
          replicated.Remotes.CommF_:InvokeServer("LoadFruit", tostring(v7))

          while true do
            replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
            local exitTo2 = nil

            while true do
              local packedValues = table.pack(iter_z_2())

              if not packedValues[1] then
                local packedValues = table.pack(iter_z_1())

                if packedValues[1] then
                  v7 = packedValues[3]
                  local v13, v14, v15 = pairs(DungeonTables)
                  iter_z_2 = (function(f, s, var)
                    local co = coroutine.wrap(function()
                      coroutine.yield()
                      for k, v16, v32, v42, v52, v62, v72, v82, v92, v102 in f, s, var do
                        coroutine.yield(true, k, v16, v32, v42, v52, v62, v72, v82, v92, v102)
                      end
                    end)
                    co()
                    return co
                  end)(v14, v15)
                  continue
                end

                break
              elseif not GetBP("Special Microchip") then
                exitTo2 = 1
                break
              end
            end

            if exitTo2 == 1 then
              replicated.Remotes.CommF_:InvokeServer("LoadFruit", tostring(v7))
              continue
            end
            break
          end

          return
        end
      end
    end
  end,
})

AutoChipBeli = tbl.Raids:AddToggle({
  Name = "Auto Buy Chip [Beli]",
  Description = "",
  Default = false,
  Callback = function(autoChipBeli)
    _G.AutoChipBeli = autoChipBeli
  end,
})

do
  local n57 = nil
  local n58 = nil

  AutoChipFruit = tbl.Raids:AddToggle({
    Name = "Auto Buy Chip [Devil Fruit]",
    Description = "",
    Default = false,
    Callback = function(autoChipFruit)
      n57 = 292579603
      n58 = 945437456
      _G.AutoChipFruit = autoChipFruit
    end,
  })
end

StartR = tbl.Raids:AddToggle({
  Name = "Auto Start Raid",
  Description = "",
  Default = false,
  Callback = function(autoStartRaid)
    _G.Auto_StartRaid = autoStartRaid
  end,
})

Raiding = tbl.Raids:AddToggle({
  Name = "Auto Raid + Next Island",
  Description = "",
  Default = false,
  Callback = function(raiding)
    _G.Raiding = raiding
  end,
})

local n57 = nil

KillAuraRaid = tbl.Raids:AddToggle({
  Name = "Kill Aura (Island 4 & 5)",
  Description = "",
  Default = false,
  Callback = function(killAuraRaid)
    n57 = 311779206
    _G.KillAuraRaid = killAuraRaid
  end,
})

tbl.Raids:AddToggle({
  Name = "Auto Awakening",
  Description = "",
  Default = false,
  Callback = function(autoAwakener)
    _G.Auto_Awakener = autoAwakener
  end,
})

local n58 = nil

tbl.Raids:AddToggle({
  Name = "Auto Teleport To Lab",
  Default = false,
  Callback = function(tpLab)
    n58 = 911033741
    _G.TpLab = tpLab
    local exitTo10

    while _G.TpLab do
      wait()

      if _G.TpLab then
        local exitTo3, exitTo4, v2, cFrameNew, v3, cFrameNew2, exitTo5, v4, cFrameNew3, exitTo6, exitTo7, v5, cFrameNew4, exitTo9, exitTo8, exitTo12, exitTo11

        if World2 then
          if _G.TpLab then
            local v6 = _tp
            local cFrameNew5 = CFrame.new
            local exitTo2 = nil

            while true do
              v6(cFrameNew5(-6438.73535, 250.645355, -4501.50684))
              local exitTo = nil

              while _G.TpLab do
                wait()
                if _G.TpLab then
                  exitTo = 1
                  break
                end
              end

              if exitTo == 1 then
                if World2 then
                  if _G.TpLab then
                    v6 = _tp
                    cFrameNew5 = CFrame.new
                    continue
                  else
                    exitTo2 = 1
                    break
                  end
                else
                  exitTo2 = 1
                  break
                end
              end

              break
            end

            if exitTo2 == 1 then
              exitTo3 = nil

              while true do
                if World3 and _G.TpLab then
                  exitTo3 = 1
                  break
                end
                exitTo4 = nil

                while _G.TpLab do
                  wait()

                  if _G.TpLab then
                    if World2 then
                      if _G.TpLab then
                        v2 = _tp
                        cFrameNew = CFrame.new
                        v2(cFrameNew(-6438.73535, 250.645355, -4501.50684))
                      else
                        exitTo4 = 1
                        break
                      end
                    else
                      exitTo4 = 1
                      break
                    end
                  end
                end

                if exitTo4 == 1 then
                  continue
                end
                break
              end

              if exitTo3 == 1 then
                v3 = _tp
                cFrameNew2 = CFrame.new

                while true do
                  v3(cFrameNew2(-5046, 314, -2960))
                  exitTo5 = nil

                  while _G.TpLab do
                    wait()

                    if _G.TpLab then
                      if World2 then
                        if _G.TpLab then
                          v4 = _tp
                          cFrameNew3 = CFrame.new
                          v4(cFrameNew3(-6438.73535, 250.645355, -4501.50684))
                        elseif World3 and _G.TpLab then
                          exitTo5 = 1
                          break
                        end
                      elseif World3 and _G.TpLab then
                        exitTo5 = 1
                        break
                      end
                    end
                  end

                  if exitTo5 == 1 then
                    v3 = _tp
                    cFrameNew2 = CFrame.new
                    continue
                  end

                  break
                end
              end
            end
          else
            exitTo6 = nil

            while true do
              if World3 and _G.TpLab then
                exitTo6 = 1
                break
              end
              exitTo7 = nil

              while _G.TpLab do
                wait()
                if _G.TpLab then
                  exitTo7 = 1
                  break
                end
              end

              if exitTo7 == 1 then
                if World2 then
                  if _G.TpLab then
                    exitTo6 = 2
                    break
                  else
                    continue
                  end
                else
                  continue
                end
              end

              break
            end

            if exitTo6 == 1 then
              v5 = _tp
              cFrameNew4 = CFrame.new
              exitTo9 = nil

              while true do
                v5(cFrameNew4(-5046, 314, -2960))
                exitTo8 = nil

                while _G.TpLab do
                  wait()

                  if _G.TpLab then
                    if World2 then
                      if _G.TpLab then
                        exitTo8 = 1
                        break
                      elseif World3 and _G.TpLab then
                        exitTo8 = 2
                        break
                      end
                    elseif World3 and _G.TpLab then
                      exitTo8 = 2
                      break
                    end
                  end
                end

                if exitTo8 == 1 then
                  exitTo9 = 1
                  break
                elseif exitTo8 == 2 then
                  v5 = _tp
                  cFrameNew4 = CFrame.new
                  continue
                end

                break
              end

              if exitTo9 == 1 then
                v4 = _tp
                cFrameNew3 = CFrame.new

                while true do
                  v4(cFrameNew3(-6438.73535, 250.645355, -4501.50684))
                  exitTo10 = nil

                  while _G.TpLab do
                    wait()

                    if _G.TpLab then
                      if World2 then
                        if _G.TpLab then
                          exitTo10 = 1
                          break
                        elseif World3 and _G.TpLab then
                          exitTo10 = 2
                          break
                        end
                      elseif World3 and _G.TpLab then
                        exitTo10 = 2
                        break
                      end
                    end
                  end

                  if exitTo10 == 1 then
                    v4 = _tp
                    cFrameNew3 = CFrame.new
                    continue
                  end

                  break
                end

                if exitTo10 == 2 then
                  v3 = _tp
                  cFrameNew2 = CFrame.new

                  while true do
                    v3(cFrameNew2(-5046, 314, -2960))
                    exitTo5 = nil

                    while _G.TpLab do
                      wait()

                      if _G.TpLab then
                        if World2 then
                          if _G.TpLab then
                            v4 = _tp
                            cFrameNew3 = CFrame.new
                            v4(cFrameNew3(-6438.73535, 250.645355, -4501.50684))
                          elseif World3 and _G.TpLab then
                            exitTo5 = 1
                            break
                          end
                        elseif World3 and _G.TpLab then
                          exitTo5 = 1
                          break
                        end
                      end
                    end

                    if exitTo5 == 1 then
                      v3 = _tp
                      cFrameNew2 = CFrame.new
                      continue
                    end

                    break
                  end
                end
              end
            elseif exitTo6 == 2 then
              v2 = _tp
              cFrameNew = CFrame.new
              exitTo12 = nil

              while true do
                v2(cFrameNew(-6438.73535, 250.645355, -4501.50684))
                exitTo11 = nil

                while _G.TpLab do
                  wait()
                  if _G.TpLab then
                    exitTo11 = 1
                    break
                  end
                end

                if exitTo11 == 1 then
                  if World2 then
                    if _G.TpLab then
                      v2 = _tp
                      cFrameNew = CFrame.new
                      continue
                    else
                      exitTo12 = 1
                      break
                    end
                  else
                    exitTo12 = 1
                    break
                  end
                end

                break
              end

              if exitTo12 == 1 then
                exitTo3 = nil

                while true do
                  if World3 and _G.TpLab then
                    exitTo3 = 1
                    break
                  end
                  exitTo4 = nil

                  while _G.TpLab do
                    wait()

                    if _G.TpLab then
                      if World2 then
                        if _G.TpLab then
                          v2 = _tp
                          cFrameNew = CFrame.new
                          v2(cFrameNew(-6438.73535, 250.645355, -4501.50684))
                        else
                          exitTo4 = 1
                          break
                        end
                      else
                        exitTo4 = 1
                        break
                      end
                    end
                  end

                  if exitTo4 == 1 then
                    continue
                  end
                  break
                end

                if exitTo3 == 1 then
                  v3 = _tp
                  cFrameNew2 = CFrame.new

                  while true do
                    v3(cFrameNew2(-5046, 314, -2960))
                    exitTo5 = nil

                    while _G.TpLab do
                      wait()

                      if _G.TpLab then
                        if World2 then
                          if _G.TpLab then
                            v4 = _tp
                            cFrameNew3 = CFrame.new
                            v4(cFrameNew3(-6438.73535, 250.645355, -4501.50684))
                          elseif World3 and _G.TpLab then
                            exitTo5 = 1
                            break
                          end
                        elseif World3 and _G.TpLab then
                          exitTo5 = 1
                          break
                        end
                      end
                    end

                    if exitTo5 == 1 then
                      v3 = _tp
                      cFrameNew2 = CFrame.new
                      continue
                    end

                    break
                  end
                end
              end
            end
          end
        else
          exitTo6 = nil

          while true do
            if World3 and _G.TpLab then
              exitTo6 = 1
              break
            end
            exitTo7 = nil

            while _G.TpLab do
              wait()
              if _G.TpLab then
                exitTo7 = 1
                break
              end
            end

            if exitTo7 == 1 then
              if World2 then
                if _G.TpLab then
                  exitTo6 = 2
                  break
                else
                  continue
                end
              else
                continue
              end
            end

            break
          end

          if exitTo6 == 1 then
            v5 = _tp
            cFrameNew4 = CFrame.new
            exitTo9 = nil

            while true do
              v5(cFrameNew4(-5046, 314, -2960))
              exitTo8 = nil

              while _G.TpLab do
                wait()

                if _G.TpLab then
                  if World2 then
                    if _G.TpLab then
                      exitTo8 = 1
                      break
                    elseif World3 and _G.TpLab then
                      exitTo8 = 2
                      break
                    end
                  elseif World3 and _G.TpLab then
                    exitTo8 = 2
                    break
                  end
                end
              end

              if exitTo8 == 1 then
                exitTo9 = 1
                break
              elseif exitTo8 == 2 then
                v5 = _tp
                cFrameNew4 = CFrame.new
                continue
              end

              break
            end

            if exitTo9 == 1 then
              v4 = _tp
              cFrameNew3 = CFrame.new

              while true do
                v4(cFrameNew3(-6438.73535, 250.645355, -4501.50684))
                exitTo10 = nil

                while _G.TpLab do
                  wait()

                  if _G.TpLab then
                    if World2 then
                      if _G.TpLab then
                        exitTo10 = 1
                        break
                      elseif World3 and _G.TpLab then
                        exitTo10 = 2
                        break
                      end
                    elseif World3 and _G.TpLab then
                      exitTo10 = 2
                      break
                    end
                  end
                end

                if exitTo10 == 1 then
                  v4 = _tp
                  cFrameNew3 = CFrame.new
                  continue
                end

                break
              end

              if exitTo10 == 2 then
                v3 = _tp
                cFrameNew2 = CFrame.new

                while true do
                  v3(cFrameNew2(-5046, 314, -2960))
                  exitTo5 = nil

                  while _G.TpLab do
                    wait()

                    if _G.TpLab then
                      if World2 then
                        if _G.TpLab then
                          v4 = _tp
                          cFrameNew3 = CFrame.new
                          v4(cFrameNew3(-6438.73535, 250.645355, -4501.50684))
                        elseif World3 and _G.TpLab then
                          exitTo5 = 1
                          break
                        end
                      elseif World3 and _G.TpLab then
                        exitTo5 = 1
                        break
                      end
                    end
                  end

                  if exitTo5 == 1 then
                    v3 = _tp
                    cFrameNew2 = CFrame.new
                    continue
                  end

                  break
                end
              end
            end
          elseif exitTo6 == 2 then
            v2 = _tp
            cFrameNew = CFrame.new
            exitTo12 = nil

            while true do
              v2(cFrameNew(-6438.73535, 250.645355, -4501.50684))
              exitTo11 = nil

              while _G.TpLab do
                wait()
                if _G.TpLab then
                  exitTo11 = 1
                  break
                end
              end

              if exitTo11 == 1 then
                if World2 then
                  if _G.TpLab then
                    v2 = _tp
                    cFrameNew = CFrame.new
                    continue
                  else
                    exitTo12 = 1
                    break
                  end
                else
                  exitTo12 = 1
                  break
                end
              end

              break
            end

            if exitTo12 == 1 then
              exitTo3 = nil

              while true do
                if World3 and _G.TpLab then
                  exitTo3 = 1
                  break
                end
                exitTo4 = nil

                while _G.TpLab do
                  wait()

                  if _G.TpLab then
                    if World2 then
                      if _G.TpLab then
                        v2 = _tp
                        cFrameNew = CFrame.new
                        v2(cFrameNew(-6438.73535, 250.645355, -4501.50684))
                      else
                        exitTo4 = 1
                        break
                      end
                    else
                      exitTo4 = 1
                      break
                    end
                  end
                end

                if exitTo4 == 1 then
                  continue
                end
                break
              end

              if exitTo3 == 1 then
                v3 = _tp
                cFrameNew2 = CFrame.new

                while true do
                  v3(cFrameNew2(-5046, 314, -2960))
                  exitTo5 = nil

                  while _G.TpLab do
                    wait()

                    if _G.TpLab then
                      if World2 then
                        if _G.TpLab then
                          v4 = _tp
                          cFrameNew3 = CFrame.new
                          v4(cFrameNew3(-6438.73535, 250.645355, -4501.50684))
                        elseif World3 and _G.TpLab then
                          exitTo5 = 1
                          break
                        end
                      elseif World3 and _G.TpLab then
                        exitTo5 = 1
                        break
                      end
                    end
                  end

                  if exitTo5 == 1 then
                    v3 = _tp
                    cFrameNew2 = CFrame.new
                    continue
                  end

                  break
                end
              end
            end
          end
        end

        return
      end
    end
  end,
})

tbl.Raids:AddSection("Items Law/Order Sword")

tbl.Raids:AddButton({
  Name = "Buy Microchip Law",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
  end,
})

tbl.Raids:AddButton({
  Name = "Start Law Raids",
  Description = "",
  Callback = function()
    fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
  end,
})

do
  local n59 = nil
  local n60 = nil

  tbl.Raids:AddToggle({
    Name = "Auto Buy Microchip Law",
    Description = "",
    Default = false,
    Callback = function(autoBuyMicrochipLaw)
      n59 = 111732086
      n60 = 366170588
      getgenv().AutoBuyMicrochipLaw = autoBuyMicrochipLaw
    end,
  })
end

do
  local n59 = nil
  local n60 = nil

  tbl.Raids:AddToggle({
    Name = "Auto Start Law Raids",
    Description = "",
    Default = false,
    Callback = function(autoStartLawRaids)
      n59 = 206642345
      n60 = 891454801
      getgenv().AutoStartLawRaids = autoStartLawRaids
    end,
  })
end

do
  local n59 = nil
  local n60 = nil

  tbl.Raids:AddToggle({
    Name = "Auto Kill Law",
    Description = "",
    Default = false,
    Callback = function(autoLawKak)
      n59 = 577945051
      n60 = 312090061
      _G.AutoLawKak = autoLawKak
    end,
  })
end

tbl.Raids:AddSection("Raids Dungeons")

tbl.Raids:AddToggle({
  Name = "Auto Farm Dungeon",
  Description = "",
  Default = false,
  Callback = function(autoFarmDungeon)
    _G.AutoFarmDungeon = autoFarmDungeon
  end,
})

tbl.Raids:AddToggle({
  Name = "TP Exit (1)",
  Default = false,
  Callback = function(tpFloor1)
    _G.TPFloor1 = tpFloor1
  end,
})

do
  local n59 = nil
  local n60 = nil

  tbl.Raids:AddToggle({
    Name = "TP Exit (2)",
    Default = false,
    Callback = function(tpFloor2)
      n59 = 690924872
      n60 = 495030611
      _G.TPFloor2 = tpFloor2
    end,
  })
end

do
  local n59 = nil
  local n60 = nil

  tbl.Raids:AddToggle({
    Name = "TP Exit (3)",
    Default = false,
    Callback = function(tpFloor3)
      n59 = 608076177
      n60 = 701049793
      _G.TPFloor3 = tpFloor3
    end,
  })
end

local n59 = nil

tbl.Raids:AddToggle({
  Name = "TP Exit (4)",
  Default = false,
  Callback = function(tpFloor4)
    n59 = 153030796
    _G.TPFloor4 = tpFloor4
  end,
})

tbl.Combat:AddSection("Combat / AimBot")
local allPlayersOnServerParagraph = tbl.Combat:AddParagraph("All Players On Server", "")

spawn(function()
  local v2, v3

  while wait(Sec) do
    pcall(function()
      local n60 = #game:GetService("Players"):GetPlayers()

      if n60 ~= 12 then
        allPlayersOnServerParagraph:SetDesc("All Players : " .. n60 .. " / 12")
      else
        allPlayersOnServerParagraph:SetDesc("All Players : " .. n60 .. " / 12 [Max]")
      end
    end)
  end
end)

do
  local aimbotStatusParagraph = tbl.Combat:AddParagraph("Aimbot Status", "")

  Checking_AimStatus = function()
    if _G.AimCam then
      return "Aimbot Camera"
    end

    if _G.AimbotGun then
      return "Aimbot Guns"
    end
    return ""
  end

  local n60 = nil

  spawn(function()
    n60 = 345692894

    if wait(0.2) then
      local v2, v3

      repeat
        pcall(function()
          if _G.AimMethod then
            if _G.AimCam then
              aimbotStatusParagraph:SetDesc("Aimbot - " .. Checking_AimStatus() .. " : True")
            elseif _G.AimbotGun then
              aimbotStatusParagraph:SetDesc("Aimbot - " .. Checking_AimStatus() .. " : True")
              return
            else
              aimbotStatusParagraph:SetDesc("Aimbot - Skills : True")
            end
          else
            aimbotStatusParagraph:SetDesc("Aimbot - Skills : False")
          end
        end)
      until not wait(0.2)
    end
  end)
end

tbl.Combat:AddDropdown({
  Name = "Select Players",
  Description = "",
  Options = PlrList,
  Callback = function(playersList)
    _G.PlayersList = playersList
  end,
})

tbl.Combat:AddToggle({
  Name = "Teleport To Select Players",
  Description = "",
  Default = false,
  Callback = function(tpPly)
    _G.TpPly = tpPly
  end,
})

do
  local n60 = nil
  local n61 = nil

  tbl.Combat:AddToggle({
    Name = "Spectate Select Players",
    Description = "",
    Default = false,
    Callback = function(arg)
      n60 = 47606393
      n61 = 450667358
      SpectatePlys = arg
    end,
  })
end

do
  local n60 = nil
  local n61 = nil

  tbl.Combat:AddDropdown({
    Name = "Select Aim Method",
    Description = "",
    Options = { "Aim Player", "Nearest Aim" },
    Callback = function(arg)
      n60 = 450289839
      n61 = 836758616
      ABmethod = arg
    end,
  })
end

do
  local n60 = nil
  local n61 = nil

  tbl.Combat:AddToggle({
    Name = "Aimbot Method Skills",
    Description = "",
    Default = false,
    Callback = function(aimMethod)
      n60 = 192766560
      n61 = 349885454
      _G.AimMethod = aimMethod
    end,
  })
end

tbl.Combat:AddToggle({
  Name = "Aimbot Camera Closet Players",
  Description = "",
  Default = false,
  Callback = function(aimCam)
    _G.AimCam = aimCam
  end,
})

tbl.Combat:AddSection("Quests Players")

do
  local n60 = nil
  local n61 = nil

  tbl.Combat:AddButton({
    Name = "Get player quests",
    Description = "",
    Callback = function()
      n60 = 892305827
      n61 = 681696453
      local n62 = nil
      local v2, v3

      pcall(function()
        n62 = 750312018
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
      end)
    end,
  })
end

tbl.Combat:AddToggle({
  Name = "Auto Get PlayerQuest",
  Description = "",
  Default = false,
  Callback = function(autoReceivePlayerQuest)
    _G.AutoReceivePlayerQuest = autoReceivePlayerQuest
  end,
})

tbl.Combat:AddToggle({
  Name = "Auto Kill Player Quest",
  Default = false,
  Callback = function(autoPlayerHunter)
    _G.AutoPlayerHunter = autoPlayerHunter

    if not autoPlayerHunter then
      Useskill = false
    end
  end,
})

tbl.Combat:AddToggle({
  Name = "Auto Enable PvP",
  Description = "",
  Default = false,
  Callback = function(autoPvP)
    _G.AutoPvP = autoPvP
  end,
})

do
  local n60 = nil
  local n61 = nil

  tbl.Combat:AddToggle({
    Name = "Auto Safe Mode",
    Default = false,
    Callback = function(safeMode)
      n60 = 995052408
      n61 = 624771675
      _G.SafeMode = safeMode
    end,
  })
end

tbl.Combat:AddSection("LocalPlayer Settings")

tbl.Combat:AddToggle({
  Name = "Enable Fly",
  Default = false,
  Callback = function(arg)
    toggleFly(arg)
  end,
})

tbl.Combat:AddSlider({
  Name = "Speed Fly Mode",
  Min = 10,
  Max = 200,
  Default = 50,
  Callback = function(arg)
    updateFlySpeed(arg)
  end,
})

tbl.Combat:AddToggle({
  Name = "Dash No Cooldown",
  Default = false,
  Callback = function(dodgeNoCD)
    getgenv().DodgeNoCD = dodgeNoCD
  end,
})

tbl.Combat:AddToggle({
  Name = "Instance Mink V3 [ INF ]",
  Description = "",
  Default = false,
  Callback = function(arg)
    InfAblities = arg
  end,
})

local n60 = nil

tbl.Combat:AddToggle({
  Name = "Instance Energy [ INF ]",
  Description = "",
  Default = false,
  Callback = function(arg)
    n60 = 683870474
    infEnergy = arg

    if arg then
      getInfinity_Ability("Energy", infEnergy)
    end
  end,
})

local n61 = nil

tbl.Combat:AddToggle({
  Name = "Instance Soru [ INF ]",
  Description = "",
  Default = false,
  Callback = function(infSoru)
    n61 = 744809026
    _G.InfSoru = infSoru

    if infSoru then
      getInfinity_Ability("Soru", _G.InfSoru)
    end
  end,
})

tbl.Combat:AddToggle({
  Name = "Instance Observation Range [ INF ]",
  Description = "",
  Default = false,
  Callback = function(infiniteObRange)
    _G.InfiniteObRange = infiniteObRange

    if infiniteObRange then
      getInfinity_Ability("Observation", _G.InfiniteObRange)
    end
  end,
})

tbl.Combat:AddToggle({
  Name = "Ignore Same Teams",
  Description = "",
  Default = false,
  Callback = function(noAimTeam)
    _G.NoAimTeam = noAimTeam
  end,
})

do
  local n62 = nil
  local n63 = nil

  tbl.Combat:AddToggle({
    Name = "Accept Allies",
    Description = "",
    Default = false,
    Callback = function(acceptAlly)
      n62 = 502399689
      n63 = 972754773
      _G.AcceptAlly = acceptAlly
    end,
  })
end

tbl.Travel:AddSection("Travel - Worlds")

do
  local n62 = nil
  local n63 = nil

  tbl.Travel:AddButton({
    Name = "Travel East Blue (World 1)",
    Description = "",
    Callback = function()
      n62 = 405528124
      n63 = 754856788
      replicated.Remotes.CommF_:InvokeServer("TravelMain")
    end,
  })
end

local n62 = nil

tbl.Travel:AddButton({
  Name = "Travel Dressrosa (World 2)",
  Description = "",
  Callback = function()
    n62 = 550664574
    replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
  end,
})

do
  local n63 = nil
  local n64 = nil

  tbl.Travel:AddButton({
    Name = "Travel Zou (World 3)",
    Description = "",
    Callback = function()
      n63 = 175624796
      n64 = 135981250
      replicated.Remotes.CommF_:InvokeServer("TravelZou")
    end,
  })
end

tbl.Travel:AddSection("Travel - Island")
Location = {}
local iter_z_1

do
  local v2, v3, v4 = pairs(workspace._WorldOrigin.Locations:GetChildren())
  iter_z_1 = (function(f, s, var)
    local co = coroutine.wrap(function()
      coroutine.yield()
      for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
        coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
      end
    end)
    co()
    return co
  end)(v3, v4)
end

while true do
  local packedValues = table.pack(iter_z_1())

  if not packedValues[1] then
    break
  else
    table.insert(Location, (packedValues[3]).Name)
  end
end

do
  local n63 = nil
  local n64 = nil

  Travelllll = tbl.Travel:AddDropdown({
    Name = "Select Travelling",
    Description = "",
    Options = Location,
    Callback = function(island)
      n63 = 85117405
      n64 = 457689084
      _G.Island = island
    end,
  })
end

GoIsland = tbl.Travel:AddToggle({
  Name = "Auto Travel",
  Description = "",
  Default = false,
  Callback = function(teleport)
    _G.Teleport = teleport

    if teleport then
      local v2, v3, v4 = pairs(workspace._WorldOrigin.Locations:GetChildren())
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(v3, v4)
      local exitTo = nil
      local v5

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          v5 = packedValues[3]
          if v5.Name == _G.Island then
            exitTo = 1
            break
          end
        end
      end

      if exitTo == 1 then
        wait()
        local v6 = _tp
        local cFrame = v5.CFrame
        local cFrameNew = CFrame.new
        local n63 = 0
        local exitTo2 = nil

        while true do
          v6(cFrame * cFrameNew(n63, 30, 0))

          if _G.Teleport then
            exitTo2 = 1
            break
          else
            local exitTo3 = nil

            while true do
              local packedValues = table.pack(iter_z_1())

              if not packedValues[1] then
                break
              else
                v5 = packedValues[3]
                if v5.Name == _G.Island then
                  exitTo3 = 1
                  break
                end
              end
            end

            if exitTo3 == 1 then
              wait()
              v6 = _tp
              cFrame = v5.CFrame
              cFrameNew = CFrame.new
              continue
            end

            break
          end
        end

        if exitTo2 == 1 then
          while true do
            if Root.CFrame ~= v5.CFrame then
              wait()
              _tp(v5.CFrame * CFrame.new(0, 30, 0))
              if _G.Teleport then
                continue
              end
            end

            local exitTo4 = nil

            while true do
              local packedValues = table.pack(iter_z_1())

              if not packedValues[1] then
                break
              else
                v5 = packedValues[3]

                if v5.Name == _G.Island then
                  wait()
                  _tp(v5.CFrame * CFrame.new(0, 30, 0))
                  if _G.Teleport then
                    exitTo4 = 1
                    break
                  end
                end
              end
            end

            if exitTo4 == 1 then
              continue
            end
            break
          end
        end
      end
    end
  end,
})

tbl.Travel:AddSection("Travel - Portal")

if World1 then
  Location_Portal = { "Sky", "UnderWater" }
elseif World2 then
  Location_Portal = { "SwanRoom", "Cursed Ship" }
elseif World3 then
  Location_Portal =
    { "Castle On The Sea", "Mansion Cafe", "Hydra Teleport", "Canvendish Room", "Temple of Time" }
end

PortalTP = tbl.Travel:AddDropdown({
  Name = "Select Portal",
  Options = Location_Portal,
  Callback = function(islandPt)
    _G.Island_PT = islandPt
  end,
})

tbl.Travel:AddButton({
  Name = "requestEntrance",
  Description = "",
  Callback = function()
    if _G.Island_PT ~= "Sky" then
      if _G.Island_PT ~= "UnderWater" then
        if _G.Island_PT ~= "SwanRoom" then
          if _G.Island_PT ~= "Cursed Ship" then
            if _G.Island_PT ~= "Castle On The Sea" then
              if _G.Island_PT ~= "Mansion Cafe" then
                if _G.Island_PT ~= "Hydra Teleport" then
                  if _G.Island_PT ~= "Canvendish Room" then
                    if _G.Island_PT == "Temple of Time" then
                      replicated.Remotes.CommF_:InvokeServer(
                        "requestEntrance",
                        Vector3.new(
                          28310.0234,
                          14895.1123,
                          109.456741,
                          -0.469690144,
                          -2.85620132E-8,
                          -0.882831335,
                          -3.23509219E-8,
                          1,
                          -1.5141173599999997E-8,
                          0.882831335,
                          2.14487486e-08,
                          -0.469690144
                        )
                      )
                    end
                  else
                    replicated.Remotes.CommF_:InvokeServer(
                      "requestEntrance",
                      Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969)
                    )
                  end
                else
                  replicated.Remotes.CommF_:InvokeServer(
                    "requestEntrance",
                    Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625)
                  )
                end
              else
                replicated.Remotes.CommF_:InvokeServer(
                  "requestEntrance",
                  Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375)
                )
              end
            else
              replicated.Remotes.CommF_:InvokeServer(
                "requestEntrance",
                Vector3.new(
                  -5097.93164,
                  316.447021,
                  -3142.66602,
                  -0.405007899,
                  -4.31682743E-8,
                  0.914313197,
                  -1.9094333199999998E-8,
                  1,
                  3.8755779e-08,
                  -0.914313197,
                  -1.76180437E-9,
                  -0.405007899
                )
              )
            end
          else
            replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923, 126, 32852))
          end
        else
          replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2285, 15, 905))
        end
      else
        replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163, 11, 1819))
      end
    else
      replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894, 5547, -380))
    end
  end,
})

tbl.Travel:AddSection("Travel - NPCs")

do
  local v2, v3, v4 = pairs(replicated.NPCs:GetChildren())
  iter_z_1 = (function(f, s, var)
    local co = coroutine.wrap(function()
      coroutine.yield()
      for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
        coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
      end
    end)
    co()
    return co
  end)(v3, v4)
end

while true do
  local packedValues = table.pack(iter_z_1())

  if not packedValues[1] then
    break
  else
    table.insert(NPCList, (packedValues[3]).Name)
  end
end

local n63 = nil

NPCsPos = tbl.Travel:AddDropdown({
  Name = "Select NPCs",
  Options = NPCList,
  Callback = function(arg)
    n63 = 1051675978
    NPClist = arg
  end,
})

local n64
n64 = nil
local n65
n65 = nil

GoNPCs = tbl.Travel:AddToggle({
  Name = "Auto Tween to NPC",
  Description = "",
  Default = false,
  Callback = function(tpNpc)
    n64 = 82226874
    n65 = 565471458
    _G.TPNpc = tpNpc
  end,
})

tbl.Shop:AddSection("Shop Options")

tbl.Shop:AddButton({
  Name = "Buy Buso",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
  end,
})

do
  local n66 = nil
  local n67 = nil

  tbl.Shop:AddButton({
    Name = "Buy Geppo",
    Description = "",
    Callback = function()
      n66 = 738709861
      n67 = 909547372
      replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
    end,
  })
end

local n66 = nil

tbl.Shop:AddButton({
  Name = "Buy Soru",
  Description = "",
  Callback = function()
    n66 = 457283242
    replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Ken",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
  end,
})

tbl.Shop:AddSection("Fighting - Style")
local n67 = nil

tbl.Shop:AddButton({
  Name = "Buy Black Leg",
  Description = "",
  Callback = function()
    n67 = 345102573
    replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Electro",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyElectro")
  end,
})

local n68 = nil

tbl.Shop:AddButton({
  Name = "Buy Fishman Karate",
  Description = "",
  Callback = function()
    n68 = 1065088353
    replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
  end,
})

local n69 = nil

tbl.Shop:AddButton({
  Name = "Buy DragonClaw",
  Description = "",
  Callback = function()
    n69 = 355983673
    replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Superhuman",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Death Step",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
  end,
})

do
  local n70 = nil
  local n71 = nil

  tbl.Shop:AddButton({
    Name = "Buy Sharkman Karate",
    Description = "",
    Callback = function()
      n70 = 572595073
      n71 = 1056466037
      replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end,
  })
end

tbl.Shop:AddButton({
  Name = "Buy ElectricClaw",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
  end,
})

local n70 = nil

tbl.Shop:AddButton({
  Name = "Buy DragonTalon",
  Description = "",
  Callback = function()
    n70 = 594192680
    replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Godhuman",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
  end,
})

do
  local n71 = nil
  local n72 = nil

  tbl.Shop:AddButton({
    Name = "Buy SanguineArt",
    Description = "",
    Callback = function()
      n71 = 59169610
      n72 = 233609015
      replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
    end,
  })
end

tbl.Shop:AddSection("Accessory")

tbl.Shop:AddButton({
  Name = "Buy Tomoe Ring",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Black Cape",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Black Cape")
  end,
})

local n71 = nil

tbl.Shop:AddButton({
  Name = "Buy Swordsman Hat",
  Description = "",
  Callback = function()
    n71 = 798772095
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Bizarre Rifle",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
  end,
})

local n72 = nil

tbl.Shop:AddButton({
  Name = "Buy Ghoul Mask",
  Description = "",
  Callback = function()
    n72 = 1049673534
    replicated.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 2)
  end,
})

tbl.Shop:AddSection("Weapon World1")

tbl.Shop:AddButton({
  Name = "Buy Cutlass",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
  end,
})

do
  local n73 = nil
  local n74 = nil

  tbl.Shop:AddButton({
    Name = "Buy Katana",
    Description = "",
    Callback = function()
      n73 = 672226701
      n74 = 287148114
      replicated.Remotes.CommF_:InvokeServer("BuyItem", "Katana")
    end,
  })
end

local n73 = nil

tbl.Shop:AddButton({
  Name = "Buy Iron Mace",
  Description = "",
  Callback = function()
    n73 = 755221571
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
  end,
})

local n74 = nil

tbl.Shop:AddButton({
  Name = "Buy Duel Katana",
  Description = "",
  Callback = function()
    n74 = 89842277
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Triple Katana",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
  end,
})

local n75 = nil

tbl.Shop:AddButton({
  Name = "Buy Pipe",
  Description = "",
  Callback = function()
    n75 = 654272556
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Dual-Headed Blade",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Bisento",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Soul Cane",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
  end,
})

local n76 = nil

tbl.Shop:AddButton({
  Name = "Buy Slingshot",
  Description = "",
  Callback = function()
    n76 = 1064081424
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Musket",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Musket")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Dual Flintlock",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
  end,
})

do
  local n77 = nil
  local n78 = nil

  tbl.Shop:AddButton({
    Name = "Buy Flintlock",
    Description = "",
    Callback = function()
      n77 = 456814190
      n78 = 149575426
      replicated.Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")
    end,
  })
end

tbl.Shop:AddButton({
  Name = "Buy Refined Flintlock",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")
  end,
})

local n77 = nil

tbl.Shop:AddButton({
  Name = "Buy Cannon",
  Description = "",
  Callback = function()
    n77 = 661524211
    replicated.Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Kabucha",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
  end,
})

tbl.Shop:AddSection("Fragments shop")

tbl.Shop:AddButton({
  Name = "Buy Refund Stats",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
  end,
})

do
  local n78 = nil
  local n79 = nil

  tbl.Shop:AddButton({
    Name = "Buy Reroll Race",
    Description = "",
    Callback = function()
      n78 = 9949170
      n79 = 850065121
      replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
    end,
  })
end

local n78
n78 = nil
local n79 = nil

tbl.Shop:AddButton({
  Name = "Buy Ghoul Race",
  Description = "",
  Callback = function()
    n78 = 774906485
    n79 = 21633180
    replicated.Remotes.CommF_:InvokeServer("Ectoplasm", " Change", 4)
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Cyborg Race (2.5k)",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("CyborgTrainer", " Buy")
  end,
})

tbl.Shop:AddButton({
  Name = "Buy Draco Race",
  Callback = function()
    _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
    local vector = Vector3.new(5814.42724609375, 1208.3267822265625, 884.57855224609375)
    local character = player.Character or player.CharacterAdded:Wait()

    repeat
      wait()
    until (character.HumanoidRootPart.Position - vector).Magnitude < 1

    game
      :GetService("ReplicatedStorage").Modules.Net
      :FindFirstChild("RF/InteractDragonQuest")
      :InvokeServer(unpack({ { NPC = "Dragon Wizard", Command = "DragonRace" } }))
  end,
})

tbl.Misc:AddSection("Server - Function")
local n80 = nil

tbl.Misc:AddButton({
  Name = "Redeem All Codes",
  Description = "",
  Callback = function()
    n80 = 639402064

    -- Static configuration/preset table: nameList (50 lines)
    local nameList = {
      "LIGHTNINGABUSE",
      "1LOSTADMIN",
      "ADMINFIGHT",
      "GIFTING_HOURS",
      "NOMOREHACK",
      "BANEXPLOIT",
      "WildDares",
      "BossBuild",
      "GetPranked",
      "EARN_FRUITS",
      "SUB2GAMERROBOT_RESET1",
      "KITT_RESET",
      "Bignews",
      "CHANDLER",
      "Fudd10",
      "fudd10_v2",
      "Sub2UncleKizaru",
      "FIGHT4FRUIT",
      "kittgaming",
      "TRIPLEABUSE",
      "Sub2CaptainMaui",
      "Sub2Fer999",
      "Enyu_is_Pro",
      "Magicbus",
      "JCWK",
      "Starcodeheo",
      "Bluxxy",
      "SUB2GAMERROBOT_EXP1",
      "Sub2NoobMaster123",
      "Sub2Daigrock",
      "Axiore",
      "TantaiGaming",
      "StrawHatMaine",
      "Sub2OfficialNoobie",
      "TheGreatAce",
      "JULYUPDATE_RESET",
      "ADMINHACKED",
      "SEATROLLING",
      "24NOADMIN",
      "ADMIN_TROLL",
      "NEWTROLL",
      "SECRET_ADMIN",
      "staffbattle",
      "NOEXPLOIT",
      "NOOB2ADMIN",
      "CODESLIDE",
      "fruitconcepts",
      "krazydares",
    }

    local redeem =
      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("Redeem")

    if redeem then
      local n81 = nil
      local n82 = nil
      local v2, v3, v4 = ipairs(nameList)
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(v3, v4)
      local v5, v6, v7

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local v9 = packedValues[3]
          task.wait(0)

          pcall(function()
            n81 = 592362480
            n82 = 295405002

            if redeem.InvokeServer then
              redeem:InvokeServer(v9)
            else
              redeem:FireServer(v9)
            end
          end)
        end
      end
    end
  end,
})

tbl.Misc:AddButton({
  Name = "Rejoin Server",
  Description = "",
  Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
  end,
})

local n81 = nil

tbl.Misc:AddButton({
  Name = "Hop Server",
  Description = "",
  Callback = function()
    n81 = 772945254
    local n82 = nil
    local n83 = nil

    task.spawn(function()
      n82 = 321063495
      n83 = 775667422
      local HttpService = game:GetService("HttpService")
      local TeleportService = game:GetService("TeleportService")
      local placeId = game.PlaceId
      local Players = game:GetService("Players")
      local v2, ok, v3, v4, id, result

      ok, result = pcall(function()
        local response = game:HttpGet(
          "https://games.roblox.com/v1/games/"
            .. placeId
            .. "/servers/Public?sortOrder=Asc&limit=100"
        )
        return HttpService:JSONDecode(response).data
      end)

      if ok and result then
        id = nil
        local v5, v6
        v5, v4, v6 = pairs(result)
        local iter_z_1 = (function(f, s, var)
          local co = coroutine.wrap(function()
            coroutine.yield()
            for k, v7, v32, v42, v52, v62, v72, v8, v9, v10 in f, s, var do
              coroutine.yield(true, k, v7, v32, v42, v52, v62, v72, v8, v9, v10)
            end
          end)
          co()
          return co
        end)(v4, v6)

        while true do
          local packedValues = table.pack(iter_z_1())

          if not packedValues[1] then
            break
          else
            local v8 = packedValues[3]

            if v8.playing < v8.maxPlayers then
              id = v8.id
            end
          end
        end

        if id then
          pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, id, Players.LocalPlayer)
          end)
        end
      end
    end)
  end,
})

tbl.Misc:AddButton({
  Name = "Hop to Lowest Players",
  Description = "",
  Callback = function()
    game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local placeId = game.PlaceId
    local nextPageCursor = nil
    local v2

    repeat
      local v3 = ListServers(nextPageCursor)
      v2 = v3.data[1]
      nextPageCursor = v3.nextPageCursor
    until v2

    TeleportService:TeleportToPlaceInstance(placeId, v2.id, plr)
  end,
})

local n82 = nil

tbl.Misc:AddButton({
  Name = "Hop to Lowest Pings Server",
  Description = "",
  Callback = function()
    n82 = 567473711
    game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local Stats = game:GetService("Stats")
    local placeId = game.PlaceId
    local v2 = fetchServersData(placeId, 100)

    if v2 then
      local v3 = v2[1]
      local v4, v5, v6 = pairs(v2)
      local iter_z_1 = (function(f, s, var)
        local co = coroutine.wrap(function()
          coroutine.yield()
          for k, v7, v32, v42, v52, v62, v72, v8, v9, v10 in f, s, var do
            coroutine.yield(true, k, v7, v32, v42, v52, v62, v72, v8, v9, v10)
          end
        end)
        co()
        return co
      end)(v5, v6)

      while true do
        local packedValues = table.pack(iter_z_1())

        if not packedValues[1] then
          break
        else
          local v8 = packedValues[3]

          if v8.ping < v3.ping and v8.playing < v8.maxPlayers then
            v3 = v8
          end
        end
      end

      task.wait(0.5)

      if
        tonumber(Stats.Network.ServerStatsItem["Data Ping"]:GetValueString():match("(%d+)")) >= 100
      then
        TeleportService:TeleportToPlaceInstance(placeId, v3.id)
      end
    end
  end,
})

do
  local n83 = nil
  local n84 = nil

  tbl.Misc:AddTextBox({
    Name = "Input Job Id",
    Placeholder = "Job ID",
    ClearOnFocus = true,
    Callback = function(job)
      n83 = 212007157
      n84 = 757624657
      getgenv().Job = job
    end,
  })
end

tbl.Misc:AddButton({
  Name = "Teleport [Job ID]",
  Callback = function()
    if getgenv().Job and getgenv().Job ~= "" then
      local localPlayer = game.Players.LocalPlayer
      game
        :GetService("TeleportService")
        :TeleportToPlaceInstance(game.PlaceId, getgenv().Job, localPlayer)
    end
  end,
})

tbl.Misc:AddButton({
  Name = "Copy JobID",
  Description = "",
  Callback = function()
    setclipboard(tostring(game.JobId))
  end,
})

tbl.Misc:AddSection("Player Gui / Others")

tbl.Misc:AddButton({
  Name = "Open Awakenings Expert",
  Description = "",
  Callback = function()
    plr.PlayerGui.Main.AwakeningToggler.Visible = true
  end,
})

tbl.Misc:AddButton({
  Name = "Open Title Selection",
  Description = "",
  Callback = function()
    replicated.Remotes.CommF_:InvokeServer("getTitles", true)
    plr.PlayerGui.Main.Titles.Visible = true
  end,
})

local n83
n83 = nil
local n84 = nil

DisbleChat = tbl.Misc:AddToggle({
  Name = "Disable Chat GUI",
  Description = "",
  Default = false,
  Callback = function(rechat)
    n83 = 834835690
    n84 = 850505124
    _G.Rechat = rechat

    if _G.Rechat ~= true then
      if _G.chat == false then
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
      end
    else
      game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
    end
  end,
})

DisbleLeaderB = tbl.Misc:AddToggle({
  Name = "Disable Leader Board GUI",
  Description = "",
  Default = false,
  Callback = function(arg)
    ReLeader = arg

    if ReLeader ~= true then
      if ReLeader == false then
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
      end
    else
      game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
    end
  end,
})

local n85 = nil

tbl.Misc:AddButton({
  Name = "Set Pirate Team",
  Description = "",
  Callback = function()
    n85 = 1025483282
    Pirates()
  end,
})

local n86 = nil

tbl.Misc:AddButton({
  Name = "Set Marine Team",
  Description = "",
  Callback = function()
    n86 = 518519970
    Marines()
  end,
})

UnPortal = tbl.Misc:AddToggle({
  Name = "Unlock All Portals",
  Description = "",
  Default = false,
  Callback = function(portalUnLock)
    _G.PortalUnLock = portalUnLock
  end,
})

tbl.Misc:AddSection("Graphics / Haki Stats")
HakiSt = { "State 0", "State 1", "State 2", "State 3", "State 4", "State 5" }

HakiStat = tbl.Misc:AddDropdown({
  Name = "Select Haki States",
  Options = HakiSt,
  Callback = function(selectStateHaki)
    _G.SelectStateHaki = selectStateHaki
  end,
})

tbl.Misc:AddButton({
  Name = "ChangeBusoStage",
  Description = "",
  Callback = function()
    if _G.SelectStateHaki ~= "State 0" then
      if _G.SelectStateHaki ~= "State 1" then
        if _G.SelectStateHaki ~= "State 2" then
          if _G.SelectStateHaki ~= "State 3" then
            if _G.SelectStateHaki ~= "State 4" then
              if _G.SelectStateHaki == "State 5" then
                replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 5)
              end
            else
              replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 4)
            end
          else
            replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 3)
          end
        else
          replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 2)
        end
      else
        replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 1)
      end
    else
      replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 0)
    end
  end,
})

rtxM = tbl.Misc:AddToggle({
  Name = "Turn on RTX Mode",
  Description = "",
  Default = false,
  Callback = function(rtxMode)
    _G.RTXMode = rtxMode
    local lighting = game.Lighting
    local colorCorrectionEffect = Instance.new("ColorCorrectionEffect", lighting)
    local colorCorrectionEffect2 = Instance.new("ColorCorrectionEffect", lighting)
    OldAmbient = lighting.Ambient
    OldBrightness = lighting.Brightness
    OldColorShift_Top = lighting.ColorShift_Top
    OldBrightnessc = colorCorrectionEffect.Brightness
    OldContrastc = colorCorrectionEffect.Contrast
    OldTintColorc = colorCorrectionEffect.TintColor
    OldTintColore = colorCorrectionEffect2.TintColor

    if _G.RTXMode then
      while _G.RTXMode do
        wait()
        lighting.Ambient = Color3.fromRGB(33, 33, 33)
        lighting.Brightness = 0.3
        colorCorrectionEffect.Brightness = 0.176
        colorCorrectionEffect.Contrast = 0.39
        colorCorrectionEffect.TintColor = Color3.fromRGB(217, 145, 57)
        game.Lighting.FogEnd = 999

        if not plr.Character.HumanoidRootPart:FindFirstChild("PointLight") then
          local pointLight = Instance.new("PointLight")
          pointLight.Parent = plr.Character.HumanoidRootPart
          pointLight.Range = 15
          pointLight.Color = Color3.fromRGB(217, 145, 57)
        end

        if not _G.RTXMode then
          lighting.Ambient = OldAmbient
          lighting.Brightness = OldBrightness
          lighting.ColorShift_Top = OldColorShift_Top
          colorCorrectionEffect.Contrast = OldContrastc
          colorCorrectionEffect.Brightness = OldBrightnessc
          colorCorrectionEffect.TintColor = OldTintColorc
          colorCorrectionEffect2.TintColor = OldTintColore
          game.Lighting.FogEnd = 2500
          plr.Character.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
        end
      end
    end
  end,
})

tbl.Misc:AddButton({
  Name = "Turn on Fast Mode",
  Description = "",
  Callback = function()
    local descendants, v2 = workspace:GetDescendants()
    local iter_z_1 = (function(f, s, var)
      local co = coroutine.wrap(function()
        coroutine.yield()
        for k, v3, v32, v4, v5, v6, v7, v8, v9, v10 in f, s, var do
          coroutine.yield(true, k, v3, v32, v4, v5, v6, v7, v8, v9, v10)
        end
      end)
      co()
      return co
    end)(descendants, v2)

    while true do
      local packedValues = table.pack(iter_z_1())

      if not packedValues[1] then
        break
      else
        local v4 = packedValues[3]

        if table.find(Past, v4.ClassName) then
          v4.Material = "Plastic"
        end
      end
    end
  end,
})

do
  local n87 = nil
  local n88 = nil

  tbl.Misc:AddButton({
    Name = "Turn on Low CPU",
    Description = "",
    Callback = function()
      n87 = 852477412
      n88 = 814277590
      LowCpu()
    end,
  })
end

local n87 = nil

tbl.Misc:AddButton({
  Name = "Turn on increase Boats",
  Description = "",
  Callback = function()
    n87 = 597127335
    local v2, v3, v4 = pairs(workspace.Boats:GetDescendants())
    local iter_z_1 = (function(f, s, var)
      local co = coroutine.wrap(function()
        coroutine.yield()
        for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
          coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
        end
      end)
      co()
      return co
    end)(v3, v4)
    local packedValues = table.pack(iter_z_1())

    if packedValues[1] then
      local v6 = packedValues[3]
      local tableFind = table.find
      local v7 = ListSeaBoat

      while true do
        if tableFind(v7, v6.Name) and tostring(v6.Owner.Value) == tostring(plr.Name) then
          v6.VehicleSeat.MaxSpeed = 350
          v6.VehicleSeat.Torque = 0.2
          v6.VehicleSeat.TurnSpeed = 5
          v6.VehicleSeat.HeadsUpDisplay = true
        end

        local packedValues = table.pack(iter_z_1())

        if packedValues[1] then
          v6 = packedValues[3]
          tableFind = table.find
          v7 = ListSeaBoat
          continue
        end

        break
      end
    end
  end,
})

do
  local n88 = nil
  local n89 = nil

  tbl.Misc:AddButton({
    Name = "Remove Sky Fog",
    Description = "",
    Callback = function()
      n88 = 340111625
      n89 = 1012991894

      if Lighting:FindFirstChild("LightingLayers") then
        Lighting.LightingLayers:Destroy()
      end

      if Lighting:FindFirstChild("SeaTerrorCC") then
        Lighting.SeaTerrorCC:Destroy()
      end

      if Lighting:FindFirstChild("FantasySky") then
        Lighting.FantasySky:Destroy()
      end
    end,
  })
end

tbl.Misc:AddSection("Configure - God")

tbl.Misc:AddButton({
  Name = "Rain Fruits (Client)",
  Description = "",
  Callback = function()
    local n88 = nil
    local n89 = nil
    local v2, v3, v4 = pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren())
    local iter_z_1 = (function(f, s, var)
      local co = coroutine.wrap(function()
        coroutine.yield()
        for k, v5, v32, v42, v52, v6, v7, v8, v9, v10 in f, s, var do
          coroutine.yield(true, k, v5, v32, v42, v52, v6, v7, v8, v9, v10)
        end
      end)
      co()
      return co
    end)(v3, v4)

    while true do
      local packedValues = table.pack(iter_z_1())

      if not packedValues[1] then
        break
      else
        local v6 = packedValues[3]
        v6.Parent = game.Workspace.Map
        local random = math.random
        v6:MoveTo(
          plr.Character.PrimaryPart.Position
            + Vector3.new(math.random(-50, 50), 100, random(-50, 50))
        )

        if v6.Fruit:FindFirstChild("AnimationController") then
          while true do
            local fruit = v6.Fruit
            v6.Fruit
              :FindFirstChild("AnimationController")
              :LoadAnimation(fruit:FindFirstChild("Idle"))
              :Play()
            local exitTo = nil

            while true do
              -- Event listener: Touched:Connect
              v6.Handle.Touched:Connect(function(hit)
                n88 = 631667604
                n89 = 521000969

                if hit.Parent == plr.Character then
                  v6.Parent = plr.Backpack
                  plr.Character.Humanoid:EquipTool(v6)
                end
              end)

              local packedValues = table.pack(iter_z_1())

              if not packedValues[1] then
                break
              else
                v6 = packedValues[3]
                v6.Parent = game.Workspace.Map
                local random2 = math.random
                v6:MoveTo(
                  plr.Character.PrimaryPart.Position
                    + Vector3.new(math.random(-50, 50), 100, random2(-50, 50))
                )
                if v6.Fruit:FindFirstChild("AnimationController") then
                  exitTo = 1
                  break
                end
              end
            end

            if exitTo == 1 then
              continue
            end
            break
          end

          return
        else
          -- Event listener: Touched:Connect
          v6.Handle.Touched:Connect(function(hit)
            n88 = 631667604
            n89 = 521000969

            if hit.Parent == plr.Character then
              v6.Parent = plr.Backpack
              plr.Character.Humanoid:EquipTool(v6)
            end
          end)
        end
      end
    end
  end,
})

do
  local n88 = nil
  local n89 = nil

  briggt1 = tbl.Misc:AddToggle({
    Name = "Turn on Full Bright",
    Description = "",
    Default = false,
    Callback = function(enabled)
      n88 = 325975154
      n89 = 891762181
      bright = enabled

      if enabled ~= true then
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        Lighting.ColorShift_Top = Color3.new(0, 0, 0)
      else
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
      end
    end,
  })
end

DayN = tbl.Misc:AddDropdown({
  Name = "Select Time",
  Description = "",
  Options = { "Day", "Night" },
  Default = Day,
  Callback = function(selectDN)
    _G.SelectDN = selectDN
  end,
})

dayornight = tbl.Misc:AddToggle({
  Name = "Turn on Time",
  Description = "",
  Default = false,
  Callback = function(daylightN)
    _G.daylightN = daylightN
  end,
})

walkWater = tbl.Misc:AddToggle({
  Name = "Turn on Walk on Water",
  Description = "",
  Default = true,
  Callback = function(walkWaterPart)
    _G.WalkWater_Part = walkWaterPart

    if _G.WalkWater_Part then
      game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
    else
      game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
    end
  end,
})

-- [[ leaked by YzZ ]]

do
  local n88 = nil
  local n89 = nil

  iceWalk = tbl.Misc:AddToggle({
    Name = "Turn on Ice Walk",
    Description = "",
    Default = false,
    Callback = function(walkWater_)
      n88 = 626286440
      n89 = 134137993
      _G.WalkWater = walkWater_
    end,
  })
end

v:Notify({
  Title = "Gavz Hub",
  Content = "leaked by YzZ",
  Image = "rbxassetid://108267040590174",
  Duration = 5,
})
-- [[ leaked by YzZ ]]
