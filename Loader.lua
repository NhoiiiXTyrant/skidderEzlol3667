-- deobf by catspooky
getgenv().MV_OMIT = function(arg, arg2)
end
getgenv().MV_OMIT_CFF = function(arg, arg2)
end
getgenv().MV_OMIT_VM = function(arg, arg2)
end
getgenv().MV_CFF = function(arg, arg2)
end
getgenv().MV_VM = function(arg, arg2)
end
getgenv().MV_COMPRESS = function(arg, arg2)
end
getgenv().MV_ENC_FUNC = function(arg3, arg4)
end
getgenv().MV_ENC_STR = function(arg5, arg6)
end
getgenv().MV_INLINE = function(arg, arg2)
end
getgenv().MV_INDEX_TO_NUM = function(arg, arg2)
end
getgenv().MV_CRASH = function(arg7, arg8)
end
task.spawn(function(...)
	local StarterGui = game:GetService("StarterGui")
	getgenv().Fn_Running = true
	getgenv().fn_running = true
	StarterGui:SetCore("SendNotification", { Text = "Loading Script...", Title = "Foxname ss2", Duration = 6 })
	local response = game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")
	local result = loadstring(response)()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Lighting = game:GetService("Lighting")
	local UserInputService = game:GetService("UserInputService")
	local HttpService = game:GetService("HttpService")
	local ProximityPromptService = game:GetService("ProximityPromptService")
	local ContentProvider = game:GetService("ContentProvider")
	task.spawn(function(...)
		makefolder("Assets")
		makefolder("Assets/Data")
		readfile("Assets/Data/afkar_icon.jpg")
		http_request({
	Method = "GET",
	Url = "https://raw.githubusercontent.com/afkar-gg/bot-proxy/refs/heads/main/IMG-20250523-WA0002.jpg?v=1792891600"
})
		task.wait(0.25)
		http_request({
	Method = "GET",
	Url = "https://raw.githubusercontent.com/afkar-gg/bot-proxy/refs/heads/main/IMG-20250523-WA0002.jpg?v=1792891600"
})
		task.wait(0.25)
	end)
	local result2 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FFD194"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FF5F6D"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#FF7E5F"), Transparency = 0 }
}, { Rotation = 45 })
	local result3 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FFF3E0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FFD194"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#FFE0B2"), Transparency = 0 }
}, { Rotation = 45 })
	local result4 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FF8C42"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FF6A88"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#FF7E5F"), Transparency = 0 }
}, { Rotation = 45 })
	local result5 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#6B4226"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#A0522D"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#8B4513"), Transparency = 0 }
}, { Rotation = 45 })
	local result6 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#D9B08C"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#B5651D"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#C68642"), Transparency = 0 }
}, { Rotation = 45 })
	local result7 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FFE5B4"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FFAA5C"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#FFC87C"), Transparency = 0 }
}, { Rotation = 45 })
	local result8 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FFAA5C"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FF5F6D"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#FF7E5F"), Transparency = 0 }
}, { Rotation = 45 })
	local result9 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FF7F50"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FF5F6D"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#FF6A88"), Transparency = 0 }
}, { Rotation = 45 })
	result:AddTheme({
	Name = "Mid Summer",
	Text = result5,
	Accent = result2,
	Background = result7,
	Button = result8,
	Dialog = result3,
	Icon = result9,
	Outline = result4,
	Placeholder = result6
})
	local result10 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#232526"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#E0E0E0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#636363"), Transparency = 0 }
}, { Rotation = 90 })
	local result11 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#1C1C1C"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#636363"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#3A3A3A"), Transparency = 0 }
}, { Rotation = 90 })
	local result12 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#B0B0B0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#E0E0E0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#C0C0C0"), Transparency = 0 }
}, { Rotation = 90 })
	local result13 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FFFFFF"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#BFBFBF"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#D9D9D9"), Transparency = 0 }
}, { Rotation = 90 })
	local result14 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#A0A0A0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#C0C0C0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#B0B0B0"), Transparency = 0 }
}, { Rotation = 90 })
	local result15 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#101010"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#636363"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#3A3A3A"), Transparency = 0 }
}, { Rotation = 90 })
	local result16 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#3A3A3A"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#A2A2A2"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#636363"), Transparency = 0 }
}, { Rotation = 90 })
	local result17 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#C0C0C0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FFFFFF"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#E0E0E0"), Transparency = 0 }
}, { Rotation = 90 })
	result:AddTheme({
	Name = "Lunar Moon",
	Text = result13,
	Accent = result10,
	Background = result15,
	Button = result16,
	Dialog = result11,
	Icon = result17,
	Outline = result12,
	Placeholder = result14
})
	local result18 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#D0E8F2"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#70C0F2"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#A0D4F2"), Transparency = 0 }
}, { Rotation = 45 })
	local result19 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#E0F7FF"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#80E7FF"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#B0EFFF"), Transparency = 0 }
}, { Rotation = 45 })
	local result20 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#70C0F2"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#30A0D0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#50B0E0"), Transparency = 0 }
}, { Rotation = 45 })
	local result21 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#0D3B66"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#1E81B0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#145DA0"), Transparency = 0 }
}, { Rotation = 45 })
	local result22 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#7FB3D5"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#3F91B5"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#5FA2C5"), Transparency = 0 }
}, { Rotation = 45 })
	local result23 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#E6F0FA"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#B4D1F0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#CDE0F5"), Transparency = 0 }
}, { Rotation = 45 })
	local result24 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#50B0E0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#108FC0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#30A0D0"), Transparency = 0 }
}, { Rotation = 45 })
	local result25 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#30A0D0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#0D81B0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#108FC0"), Transparency = 0 }
}, { Rotation = 45 })
	result:AddTheme({
	Name = "Winter Frost",
	Text = result21,
	Accent = result18,
	Background = result23,
	Button = result24,
	Dialog = result19,
	Icon = result25,
	Outline = result20,
	Placeholder = result22
})
	local result26 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#3B0D5C"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#9C27B0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#6A1B9A"), Transparency = 0 }
}, { Rotation = 45 })
	local result27 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#1A001A"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#6A006A"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#3D003D"), Transparency = 0 }
}, { Rotation = 45 })
	local result28 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#9C27B0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#6A1B9A"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#7B1FA2"), Transparency = 0 }
}, { Rotation = 45 })
	local result29 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FFFFFF"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#C0C0C0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#E0E0E0"), Transparency = 0 }
}, { Rotation = 45 })
	local result30 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#B0A0B5"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#7B6F8C"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#9C8FA0"), Transparency = 0 }
}, { Rotation = 45 })
	local result31 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#10001A"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#30004D"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#1A0033"), Transparency = 0 }
}, { Rotation = 45 })
	local result32 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#6A1B9A"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#B55BC5"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#9C27B0"), Transparency = 0 }
}, { Rotation = 45 })
	local result33 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#9C27B0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#D084E0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#B55BC5"), Transparency = 0 }
}, { Rotation = 45 })
	result:AddTheme({
	Name = "Elegant Night",
	Text = result29,
	Accent = result26,
	Background = result31,
	Button = result32,
	Dialog = result27,
	Icon = result33,
	Outline = result28,
	Placeholder = result30
})
	local result34 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#0D0D1A"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#2E2E5C"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#1A1A33"), Transparency = 0 }
}, { Rotation = 90 })
	local result35 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#101026"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#333366"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#1A1A3D"), Transparency = 0 }
}, { Rotation = 90 })
	local result36 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#2E2E5C"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#5050A0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#404080"), Transparency = 0 }
}, { Rotation = 90 })
	local result37 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#A0A0FF"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#E0E0FF"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#C0C0FF"), Transparency = 0 }
}, { Rotation = 90 })
	local result38 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#6060A0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#A0A0E0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#8080C0"), Transparency = 0 }
}, { Rotation = 90 })
	local result39 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#0A0A1A"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#2E2E5C"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#1A1A33"), Transparency = 0 }
}, { Rotation = 90 })
	local result40 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#404080"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#6060C0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#5050A0"), Transparency = 0 }
}, { Rotation = 90 })
	local result41 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#6060C0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#A0A0FF"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#8080E0"), Transparency = 0 }
}, { Rotation = 90 })
	result:AddTheme({
	Name = "Lunar Abyss",
	Text = result37,
	Accent = result34,
	Background = result39,
	Button = result40,
	Dialog = result35,
	Icon = result41,
	Outline = result36,
	Placeholder = result38
})
	local result42 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#33001A"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#99004D"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#660033"), Transparency = 0 }
}, { Rotation = 45 })
	local result43 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#1A0014"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#66003F"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#330028"), Transparency = 0 }
}, { Rotation = 45 })
	local result44 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#99004D"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FF6699"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#CC3366"), Transparency = 0 }
}, { Rotation = 45 })
	local result45 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#FFE6F0"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FF80A0"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#FFB3CC"), Transparency = 0 }
}, { Rotation = 45 })
	local result46 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#CC6699"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FFB3D9"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#FF99CC"), Transparency = 0 }
}, { Rotation = 45 })
	local result47 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#1A0014"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#66003F"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#330028"), Transparency = 0 }
}, { Rotation = 45 })
	local result48 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#66003F"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#CC3366"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#99004D"), Transparency = 0 }
}, { Rotation = 45 })
	local result49 = result:Gradient({
	["0"] = { Color = Color3.fromHex("#99004D"), Transparency = 0 },
	["100"] = { Color = Color3.fromHex("#FF6699"), Transparency = 0 },
	["50"] = { Color = Color3.fromHex("#CC3366"), Transparency = 0 }
}, { Rotation = 45 })
	result:AddTheme({
	Name = "Lunar Eclipse",
	Text = result45,
	Accent = result42,
	Background = result47,
	Button = result48,
	Dialog = result43,
	Icon = result49,
	Outline = result44,
	Placeholder = result46
})
	makefolder("WindUI")
	makefolder("WindUI/99NightsInTheForest")
	makefolder("Foxname_99Nights")
	result:GetThemes()
	result:SetTheme("Elegant Night")
	local Window = result:CreateWindow({
	Title = "<font color=\"rgb(0,128,255)\">F</font><font color=\"rgb(15,128,239)\">o</font><font color=\"rgb(31,129,223)\">x</font><font color=\"rgb(47,130,207)\">n</font><font color=\"rgb(63,131,191)\">a</font><font color=\"rgb(79,131,175)\">m</font><font color=\"rgb(95,132,159)\">e</font><font color=\"rgb(111,133,143)\"> </font><font color=\"rgb(127,134,127)\">-</font><font color=\"rgb(143,134,111)\"> </font><font color=\"rgb(159,135,95)\">9</font><font color=\"rgb(175,136,79)\">9</font><font color=\"rgb(191,137,63)\"> </font><font color=\"rgb(207,137,47)\">N</font><font color=\"rgb(223,138,31)\">I</font><font color=\"rgb(239,139,15)\">T</font><font color=\"rgb(255,140,0)\">F</font>",
	Author = "foxname.top",
	Background = "rbxassetid://133610205520685",
	BackgroundImageTransparency = 0.6,
	Folder = "99NightsInTheForest",
	Icon = "rbxassetid://82225829203828",
	ScrollBarEnabled = true,
	SideBarWidth = 180,
	Size = UDim2.fromOffset(580, 350),
	Theme = "Elegant Night"
})
	Window:Tag({ Title = "Keyless", Color = Color3.fromHex("#176BE8"), Radius = 8 })
	Window.IsPC = false
	Window:SetUIScale(0.9)
	Window:SetToggleKey(Enum.KeyCode.RightShift)
	Window:EditOpenButton({
	Title = "Open skibidi",
	Color = ColorSequence.new(Color3.fromRGB(0, 191, 255), Color3.fromRGB(255, 105, 180)),
	CornerRadius = UDim.new(0, 16),
	Draggable = true,
	Enabled = true,
	Icon = "rbxassetid://86146615808159",
	StrokeThickness = 2
})
	local Section = Window:Section({ Title = "Home", Icon = "star", Opened = true })
	task.wait(0.02)
	Section:Tab({ Title = "Discord", Icon = "messages-square" })
	task.wait(0.02)
	Section:Tab({ Title = "New Update", Icon = "zap" })
	task.wait(0.02)
	Section:Tab({ Title = "Donate", Icon = "money" })
	task.wait(0.02)
	Window:Divider()
	local Section2 = Window:Section({ Title = "Features", Icon = "box", Opened = true })
	task.wait(0.02)
	local Tab = Section2:Tab({ Title = "Main", Icon = "terminal" })
	task.wait(0.02)
	local Tab2 = Section2:Tab({ Title = "Bring", Icon = "package-open" })
	task.wait(0.02)
	local Tab3 = Section2:Tab({ Title = "Teleport", Icon = "map-pin" })
	task.wait(0.02)
	Section2:Tab({ Title = "Local Player", Icon = "user" })
	task.wait(0.02)
	Section2:Tab({ Title = "Misc", Icon = "sparkles" })
	task.wait(0.02)
	local Tab4 = Section2:Tab({ Title = "Tree", Icon = "tree-pine" })
	task.wait(0.02)
	Window:Divider()
	Window:Tab({ Title = "Settings", Icon = "settings" })
	task.wait(0.02)
	Window.PendingFlags = Window.PendingFlags
	Window.ConfigManager:CreateConfig("__autosave")
	workspace:WaitForChild("Items", 5)
	local themes = result:GetThemes()
	for k, v in pairs(themes) do
	end
	game.ReplicatedStorage:WaitForChild("RemoteEvents", 5)
	local Inventory = game.Players.LocalPlayer:WaitForChild("Inventory", 5)
	local Characters = workspace:WaitForChild("Characters", 5)
	_G.KillAura = false
	_G.KillAuraRange = 100
	_G.GunAura = false
	_G.GunAuraRange = 150
	_G.ChopAura = false
	_G.ChopAuraRange = 100
	_G.ChopTreeType = {}
	Tab:Space()
	local Section3 = Tab:Section({
	Title = "Combat Aura",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Kill Aura",
	Icon = "swords",
	Opened = true
})
	OverlapParams.new().FilterType = Enum.RaycastFilterType.Include
	OverlapParams.new().FilterDescendantsInstances = { Characters }
	OverlapParams.new().MaxParts = 0
	local Client = game.Players.LocalPlayer.PlayerScripts:WaitForChild("Client")
	require(Client)
	_G.KillAura = false
	getgenv().__FN99KillAuraRunId = 2
	Section3:Toggle({
	Title = "Kill Aura",
	Default = false,
	Callback = function(state, arg10)
			if state then
				_G.KillAura = state
				getgenv().__FN99KillAuraRunId = 1
				task.spawn(function(...)
					game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					local children = game.Players.LocalPlayer.Character:GetChildren()
					for i, v2 in ipairs(children) do
						v2:GetAttribute("WeaponDamage")
						v2:GetAttribute("WeaponDamage")
						local children2 = Inventory:GetChildren()
						for i2, v3 in ipairs(children2) do
							v3:GetAttribute("WeaponDamage")
						end
						task.wait(0.12)
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
						local children3 = game.Players.LocalPlayer.Character:GetChildren()
						for i3, v4 in ipairs(children3) do
							v4:GetAttribute("WeaponDamage")
							v4:GetAttribute("WeaponDamage")
							local children4 = Inventory:GetChildren()
							for i4, v5 in ipairs(children4) do
								v5:GetAttribute("WeaponDamage")
							end
						end
						task.wait(0.12)
					end
				end)
			end
		end
})
	_G.KillAuraRange = nil
	Section3:Slider({
	Title = "Kill Aura Range",
	Step = 1,
	Value = { Default = 100, Max = 150, Min = 0 },
	Callback = function(state, arg12)
		end
})
	getgenv().__FN99LiveGunAuraVersion = 1
	getgenv().__FN99GunReloadFixVersion = 1
	local Client2 = game.Players.LocalPlayer.PlayerScripts:WaitForChild("Client")
	require(Client2)
	OverlapParams.new().FilterType = Enum.RaycastFilterType.Include
	OverlapParams.new().FilterDescendantsInstances = { Characters }
	OverlapParams.new().MaxParts = 0
	_G.__FN99GunAuraLoopVersion = 2
	_G.GunAura = false
	Section3:Toggle({
	Title = "Gun Aura",
	Default = false,
	Callback = function(state, arg14)
			if state then
				_G.GunAura = state
				_G.__FN99GunAuraLoopVersion = 1
				task.spawn(function(...)
					game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					task.wait(0.1)
					game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					task.wait(0.1)
				end)
			end
		end
})
	Section3:Slider({
	Title = "Gun Aura Range",
	Step = 1,
	Value = { Default = 150, Max = 500, Min = 10 },
	Callback = function(state, arg16)
		end
})
	RunService.Heartbeat:Wait()
	local Section4 = Tab:Section({ Title = "Tree Aura", Box = true, BoxBorder = true, Icon = "axe", Opened = true })
	_G.ChopAuraRange = nil
	Section4:Slider({
	Title = "Chop Aura Range",
	Step = 1,
	Value = { Default = 100, Max = 150, Min = 50 },
	Callback = function(state, arg18)
		end
})
	local Map = workspace:FindFirstChild("Map")
	local Foliage = Map:FindFirstChild("Foliage")
	Foliage:GetAttribute("Resource")
	local descendants = Foliage:GetDescendants()
	for i7, v8 in ipairs(descendants) do
		v8:GetAttribute("Resource")
	end
	local Landmarks = Map:FindFirstChild("Landmarks")
	Landmarks:GetAttribute("Resource")
	local descendants2 = Landmarks:GetDescendants()
	for i8, v9 in ipairs(descendants2) do
		v9:GetAttribute("Resource")
	end
	_G.ChopTreeType = false
	Section4:Dropdown({
	Title = "Tree Type",
	Flag = "Main_TreeAura_Dropdown_Tree_Type_v2",
	Multi = true,
	Value = { "Select All" },
	Values = {},
	Callback = function(state, arg20)
		end
})
	getgenv().__FN99TreeCatalogConnections = {}
	local Foliage2 = Map:FindFirstChild("Foliage")
	Foliage2.DescendantAdded:Connect(function(descendant)
		task.defer(function(...)
		end)
	end)
	local Landmarks2 = Map:FindFirstChild("Landmarks")
	Landmarks2.DescendantAdded:Connect(function(descendant2)
		task.defer(function(...)
		end)
	end)
	OverlapParams.new().FilterType = Enum.RaycastFilterType.Include
	OverlapParams.new().MaxParts = 0
	_G.ChopAura = false
	getgenv().__FN99ChopAuraRunId = 2
	Section4:Toggle({
	Title = "Tree Aura",
	Default = false,
	Callback = function(state, arg22)
			if state then
				_G.ChopAura = state
				getgenv().__FN99ChopAuraRunId = 1
				task.spawn(function(...)
					game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					local Inventory2 = game.Players.LocalPlayer:FindFirstChild("Inventory")
					local Map2 = workspace:FindFirstChild("Map")
					Map2:FindFirstChild("Foliage")
					Map2:FindFirstChild("Landmarks")
					local children5 = game.Players.LocalPlayer.Character:GetChildren()
					for i9, v10 in ipairs(children5) do
						v10:GetAttribute("WeaponResourceDamage")
						v10:GetAttribute("WeaponResourceDamage")
						local children6 = Inventory2:GetChildren()
						for i10, v11 in ipairs(children6) do
							v11:GetAttribute("WeaponResourceDamage")
						end
						task.wait(0.3)
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
						local Inventory3 = game.Players.LocalPlayer:FindFirstChild("Inventory")
						local Map3 = workspace:FindFirstChild("Map")
						Map3:FindFirstChild("Foliage")
						Map3:FindFirstChild("Landmarks")
						local children7 = game.Players.LocalPlayer.Character:GetChildren()
						for i11, v12 in ipairs(children7) do
							v12:GetAttribute("WeaponResourceDamage")
							v12:GetAttribute("WeaponResourceDamage")
							local children8 = Inventory3:GetChildren()
							for i12, v13 in ipairs(children8) do
								v13:GetAttribute("WeaponResourceDamage")
							end
						end
						task.wait(0.3)
					end
				end)
			end
		end
})
	Tab:Space()
	local Section5 = Tab:Section({
	Title = "Creature Control",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Stun",
	Icon = "zap",
	Opened = true
})
	_G.AutoStunDeer = false
	Section5:Toggle({
	Title = "Auto Stun Deer",
	Default = false,
	Callback = function(state, arg24)
			if state then
				_G.AutoStunDeer = state
				task.spawn(function(...)
					local MonsterHitByTorch = ReplicatedStorage.RemoteEvents:WaitForChild("MonsterHitByTorch")
					local Characters2 = workspace:WaitForChild("Characters")
					task.wait(0.1)
					local Deer = Characters2:FindFirstChild("Deer")
					MonsterHitByTorch:InvokeServer(Deer)
					task.wait(0.1)
					local Deer2 = Characters2:FindFirstChild("Deer")
					MonsterHitByTorch:InvokeServer(Deer2)
					task.wait(0.1)
				end)
			end
		end
})
	_G.AutoStunOwl = false
	Section5:Toggle({
	Title = "Auto Stun Owl",
	Default = false,
	Callback = function(state, arg26)
			if state then
				_G.AutoStunOwl = state
				task.spawn(function(...)
					local MonsterHitByTorch2 = ReplicatedStorage.RemoteEvents:WaitForChild("MonsterHitByTorch")
					local Characters3 = workspace:WaitForChild("Characters")
					task.wait(0.1)
					local Owl = Characters3:FindFirstChild("Owl")
					MonsterHitByTorch2:InvokeServer(Owl)
					task.wait(0.1)
					local Owl2 = Characters3:FindFirstChild("Owl")
					MonsterHitByTorch2:InvokeServer(Owl2)
					task.wait(0.1)
				end)
			end
		end
})
	_G.AutoStunRam = false
	Section5:Toggle({
	Title = "Auto Stun Ram",
	Default = false,
	Callback = function(state, arg28)
			if state then
				_G.AutoStunRam = state
				task.spawn(function(...)
					local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
					RemoteEvents:WaitForChild("MonsterHitByTorch")
					local Characters4 = workspace:WaitForChild("Characters")
					task.wait(0.1)
					local children9 = Characters4:GetChildren()
					for i15, v16 in ipairs(children9) do
					end
					task.wait(0.1)
					local children10 = Characters4:GetChildren()
					for i16, v17 in ipairs(children10) do
					end
					task.wait(0.1)
				end)
			end
		end
})
	_G.AutoStunCat = false
	Section5:Toggle({
	Title = "Auto Stun Cat",
	Default = false,
	Callback = function(state, arg30)
			if state then
				_G.AutoStunCat = state
				task.spawn(function(...)
					local MonsterHitByTorch3 = ReplicatedStorage.RemoteEvents:WaitForChild("MonsterHitByTorch")
					local Characters5 = workspace:WaitForChild("Characters")
					task.wait(0.1)
					local Cat = Characters5:FindFirstChild("Cat")
					MonsterHitByTorch3:InvokeServer(Cat)
					task.wait(0.1)
					local Cat2 = Characters5:FindFirstChild("Cat")
					MonsterHitByTorch3:InvokeServer(Cat2)
					task.wait(0.1)
				end)
			end
		end
})
	RunService.Heartbeat:Wait()
	Tab:Space()
	local Section6 = Tab:Section({
	Title = "Survival",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Godmode",
	Icon = "shield",
	Opened = true
})
	Section6:Button({
	Title = "Godmode",
	Callback = function(state, arg32)
			if state then
				Window:Dialog({
		Title = "Survival",
		Content = "Godmode was patched, please use anti hit (you can still get damaged by hunger)",
		Buttons = {
			{
				Title = "OK",
				Icon = "check",
				Variant = "Primary",
				Callback = function(state, arg34)
							end
			}
		},
		Icon = "shield-alert"
	})
			else
				Window:Dialog({
		Title = "Survival",
		Content = "Godmode was patched, please use anti hit (you can still get damaged by hunger)",
		Buttons = {
			{
				Title = "OK",
				Icon = "check",
				Variant = "Primary",
				Callback = function(state, arg36)
							end
			}
		},
		Icon = "shield-alert"
	})
			end
		end
})
	Section6:Toggle({
	Title = "Anti Hit",
	Default = false,
	Callback = function(state, arg38)
			if state then
				local RemoteEvent = Instance.new("RemoteEvent")
				hookfunction(RemoteEvent.FireServer, function(arg39, arg40)
					string.lower(tostring(arg39.Name)):find("lightningdamage", 1, true)
				end)
				Instance.new("RemoteFunction")
				hookfunction(MonsterHitByTorch.InvokeServer, function(arg41, arg42)
					string.lower(tostring(arg41.Name)):find("lightningdamage", 1, true)
				end)
				hookmetamethod(game, "__namecall", function(arg43, arg44)
					string.lower(tostring(arg43.Name)):find("lightningdamage", 1, true)
				end)
			end
		end
})
	RunService.Heartbeat:Wait()
	Tab:Space()
	local Section7 = Tab:Section({
	Title = "General Automation",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Auto",
	Icon = "bot",
	Opened = true
})
	_G.TypeAuto = false
	Section7:Dropdown({
	Title = "Select Auto",
	Multi = true,
	Value = { "" },
	Values = {
		"Collect Coins",
		"Collect Flowers",
		"Plants Seed Box",
		"Collect Ammo",
		"Collect Diamond",
		"Plants Tree",
		"Auto Day"
	},
	Callback = function(state, arg46)
			if state then
				_G.TypeAuto = state
			end
		end
})
	workspace:FindFirstChild("Items")
	ReplicatedStorage:FindFirstChild("RemoteEvents")
	ReplicatedStorage.RemoteEvents:FindFirstChild("RequestConsumeItem")
	local CollectionService = game:GetService("CollectionService")
	ReplicatedStorage:FindFirstChild("RemoteEvents")
	ReplicatedStorage.RemoteEvents:FindFirstChild("RequestPickFlower")
	local VirtualInputManager = game:GetService("VirtualInputManager")
	local GuiService = game:GetService("GuiService")
	Players.LocalPlayer:WaitForChild("PlayerGui")
	local RemoteEvents2 = ReplicatedStorage:WaitForChild("RemoteEvents")
	RemoteEvents2:FindFirstChild("CraftItem")
	RemoteEvents2:FindFirstChild("RequestStartDraggingItem")
	RemoteEvents2:FindFirstChild("StopDraggingItem")
	RemoteEvents2:FindFirstChild("RequestBagStoreItem")
	RemoteEvents2:FindFirstChild("EquipItemHandle")
	_G.AutoDayMoveItem = function(arg47, arg48)
	end
	RemoteEvents2:FindFirstChild("RequestHotbarItem")
	_G.AutoDayRun = function(arg49, arg50)
		Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart", 5)
		_G.AutoDayStatus = "Starting Auto Day..."
	end
	_G.AutoFlowerWorkerSerial = 2
	_G.AutoStart = false
	local Toggle = Section7:Toggle({
	Title = "Auto",
	Default = false,
	Callback = function(state, arg52)
			if state then
				_G.AutoStart = state
				_G.AutoDayStatus = ""
				_G.AutoFlowerWorkerSerial = 1
				task.spawn(function(...)
					task.wait(0.5)
					task.wait(0.5)
				end)
				task.spawn(function(...)
					task.wait(1.5)
					task.wait(1.5)
				end)
			end
		end
})
	_G.AutoToggleRef = Toggle
	getgenv().AutoRevive = false
	Section7:Toggle({
	Title = "Auto Revive Team(bandage)",
	Default = false,
	Callback = function(state, arg54)
			if state then
				getgenv().AutoRevive = state
				local Characters6 = workspace:WaitForChild("Characters", 9000000000)
				task.spawn(function(...)
					task.wait(1)
					local Inventory4 = Players.LocalPlayer:FindFirstChild("Inventory")
					Inventory4:FindFirstChild("Bandage")
					local children11 = Characters6:GetChildren()
					for k2, v19 in pairs(children11) do
						v19:FindFirstChild("HumanoidRootPart")
						local ProximityAttachment = v19.HumanoidRootPart:FindFirstChild("ProximityAttachment")
						ProximityAttachment:FindFirstChild("ProximityInteraction")
						fireproximityprompt(ProximityAttachment.ProximityInteraction)
						task.wait(0.5)
					end
					task.wait(1)
					local Inventory5 = Players.LocalPlayer:FindFirstChild("Inventory")
					Inventory5:FindFirstChild("Bandage")
					local children12 = Characters6:GetChildren()
					for k3, v20 in pairs(children12) do
						v20:FindFirstChild("HumanoidRootPart")
						local ProximityAttachment2 = v20.HumanoidRootPart:FindFirstChild("ProximityAttachment")
						ProximityAttachment2:FindFirstChild("ProximityInteraction")
						fireproximityprompt(ProximityAttachment2.ProximityInteraction)
						task.wait(0.5)
					end
					task.wait(1)
				end)
			end
		end
})
	Section7:Space()
	_G.AutoGrabChildren = false
	getgenv().__FN99GrabChildrenRunId = 2
	Section7:Toggle({
	Title = "Auto Grab Children",
	Default = false,
	Callback = function(state, arg56)
			if state then
				_G.AutoGrabChildren = state
				getgenv().__FN99GrabChildrenRunId = 1
				task.spawn(function(...)
					ReplicatedStorage:WaitForChild("TempStorage")
					local RemoteEvents3 = ReplicatedStorage:WaitForChild("RemoteEvents")
					RemoteEvents3:WaitForChild("RequestBagStoreItem")
					Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					workspace:FindFirstChild("Characters")
					local Inventory6 = Players.LocalPlayer:FindFirstChild("Inventory")
					local children13 = Inventory6:GetChildren()
					for i18, v22 in ipairs(children13) do
						v22:HasTag("ItemBag")
						v22:GetAttribute("Capacity")
						local ItemBag = Players.LocalPlayer:FindFirstChild("ItemBag")
						ItemBag:GetChildren()
						v22:GetAttribute("NumberItems")
					end
				end)
			end
		end
})
	Section7:Space()
	Tab:Space()
	local Section8 = Tab:Section({
	Title = "Resource Processing",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Auto",
	Icon = "factory",
	Opened = true
})
	local RemoteEvents4 = ReplicatedStorage:WaitForChild("RemoteEvents")
	local Items = workspace:WaitForChild("Items")
	_G.AutoFuelB = { "Log", "Coal", "Oil Barrel", "Fuel Canister", "Biofuel" }
	_G.AutoFuel = false
	_G.AutoFuelB = false
	Section8:Dropdown({
	Title = "Choose Fuel",
	AllowNone = true,
	Multi = true,
	Value = { "Log", "Coal", "Oil Barrel", "Fuel Canister", "Biofuel" },
	Values = { "Log", "Coal", "Oil Barrel", "Fuel Canister", "Biofuel" },
	Callback = function(state, arg58)
		end
})
	_G.AutoFuel = false
	Section8:Toggle({
	Title = "Auto Fuel",
	Default = false,
	Callback = function(state, arg60)
			if state then
				_G.AutoFuel = state
				task.spawn(function(...)
				end)
			end
		end
})
	Section8:Space()
	_G.AutoFood = false
	_G.AutoFood = false
	Section8:Toggle({
	Title = "Auto Cook",
	Default = false,
	Callback = function(state, arg62)
			if state then
				task.spawn(function(...)
					_G.AutoFood = state
					RemoteEvents4:FindFirstChild("RequestStartDraggingItem")
					local children14 = Items:GetChildren()
					for i19, v23 in ipairs(children14) do
					end
					task.wait(0.5)
					RemoteEvents4:FindFirstChild("RequestStartDraggingItem")
					local children15 = Items:GetChildren()
					for i20, v24 in ipairs(children15) do
					end
					task.wait(0.5)
				end)
			end
		end
})
	Section8:Space()
	_G.AutoScrapperH = false
	_G.AutoScrapper = {
	"Chair",
	"Broken Fan",
	"Sheet Metal",
	"Bolt",
	"Metal Chair",
	"Broken Microwave",
	"Old Car Engine",
	"Old Radio",
	"Washing Machine",
	"Cultist Gem",
	"Tyre",
	"UFO Junk",
	"UFO Component"
}
	_G.AutoScrapper = false
	Section8:Dropdown({
	Title = "Choose Scrapper",
	AllowNone = true,
	Multi = true,
	Value = {
		"Chair",
		"Broken Fan",
		"Sheet Metal",
		"Bolt",
		"Metal Chair",
		"Broken Microwave",
		"Old Car Engine",
		"Old Radio",
		"Washing Machine",
		"Cultist Gem",
		"Tyre",
		"UFO Junk",
		"UFO Component"
	},
	Values = {
		"Log",
		"Chair",
		"Broken Fan",
		"Sheet Metal",
		"Bolt",
		"Metal Chair",
		"Broken Microwave",
		"Old Car Engine",
		"Old Radio",
		"Washing Machine",
		"Cultist Gem",
		"Tyre",
		"UFO Junk",
		"UFO Component"
	},
	Callback = function(state, arg64)
		end
})
	_G.AutoScrapperH = false
	Section8:Toggle({
	Title = "Auto Scrapper",
	Default = false,
	Callback = function(state, arg66)
			if state then
				task.spawn(function(...)
					_G.AutoScrapperH = state
					local Scrapper = workspace.Map.Campground:FindFirstChild("Scrapper")
					Scrapper:FindFirstChildWhichIsA("BasePart")
				end)
			end
		end
})
	Section8:Space()
	_G.AutoSacrifice = false
	Section8:Toggle({
	Title = "Auto Sacrifice",
	Default = false,
	Callback = function(state, arg68)
			if state then
				_G.AutoSacrifice = state
				task.spawn(function(...)
					local Map4 = workspace:WaitForChild("Map")
					local Landmarks3 = Map4:WaitForChild("Landmarks")
					local Volcano = Landmarks3:WaitForChild("Volcano")
					local Functional = Volcano:WaitForChild("Functional")
					Functional:WaitForChild("Ground")
					RemoteEvents4:FindFirstChild("RequestStartDraggingItem")
					local children16 = Items:GetChildren()
					for i22, v26 in ipairs(children16) do
					end
					task.wait(0.8)
					RemoteEvents4:FindFirstChild("RequestStartDraggingItem")
					local children17 = Items:GetChildren()
					for i23, v27 in ipairs(children17) do
					end
					task.wait(0.8)
				end)
			end
		end
})
	Tab:Space()
	local Section9 = Tab:Section({
	Title = "Hunger",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Auto",
	Icon = "utensils",
	Opened = true
})
	_G.TypeFoodToFill = "Carrot"
	_G.TypeFoodToFill = false
	Section9:Dropdown({
	Title = "Select Food to Fill Hunger",
	Value = "Carrot",
	Values = { "Carrot", "Berry", "Cooked Morsel", "Cooked Steak" },
	Callback = function(state, arg70)
		end
})
	Section9:Slider({
	Title = "Hunger Threshold",
	Step = 1,
	Value = { Default = 100, Max = 200, Min = 1 },
	Callback = function(state, arg72)
		end
})
	_G.AutoEat = false
	_G.AutoEat = false
	Section9:Toggle({
	Title = "Auto Eat",
	Default = false,
	Callback = function(state, arg74)
			if state then
				task.spawn(function(...)
					_G.AutoEat = state
					Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					local attribute = Players.LocalPlayer:GetAttribute("Hunger")
					task.wait(0.3)
					local attribute2 = Players.LocalPlayer:GetAttribute("Hunger")
					task.wait(0.3)
				end)
			end
		end
})
	Section9:Space()
	local Section10 = Tab:Section({
	Title = "Minigames",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Other",
	Icon = "ellipsis",
	Opened = true
})
	Section10:Space()
	getgenv().__FN99InstantFishingConnection = nil
	Section10:Toggle({
	Title = "Instant Catch Fish",
	Default = false,
	Flag = "Main_Other_Toggle_100_Catch_fish",
	Callback = function(state, arg76)
			if state then
				_G.AutoCatchFishing = state
				local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
				local Interface = PlayerGui:WaitForChild("Interface")
				local FishingCatchFrame = Interface:WaitForChild("FishingCatchFrame")
				getgenv().__FN99InstantFishingRunId = 1
				local changedSignal = FishingCatchFrame:GetPropertyChangedSignal("Visible")
				local connection = changedSignal:Connect(function(arg77)
				end)
				getgenv().__FN99InstantFishingConnection = connection
				task.spawn(function(...)
					local TimingBar = FishingCatchFrame:FindFirstChild("TimingBar")
					local SuccessArea = TimingBar:FindFirstChild("SuccessArea")
					SuccessArea.Size = UDim2.new(1, 0, 1, 0)
					SuccessArea.Position = UDim2.new(0, 0, 0, 0)
					RunService.RenderStepped:Wait()
					task.wait()
				end)
			else
				_G.AutoCatchFishing = false
				connection:Disconnect()
			end
		end
})
	getgenv().TamingConnection = nil
	Section10:Toggle({
	Title = "Instant Taming Minigame",
	Default = false,
	Flag = "Main_Other_Toggle_100_Successful_Taming_Flute",
	Callback = function(state, arg79)
			if state then
				_G.AutoTamingFlute = state
				local PlayerGui2 = Players.LocalPlayer:WaitForChild("PlayerGui")
				local Interface2 = PlayerGui2:WaitForChild("Interface")
				local TamingFluteFrame = Interface2:WaitForChild("TamingFluteFrame")
				getgenv().__FN99InstantTamingRunId = 1
				local changedSignal2 = TamingFluteFrame:GetPropertyChangedSignal("Visible")
				local connection2 = changedSignal2:Connect(function(arg80)
				end)
				getgenv().TamingConnection = connection2
				task.spawn(function(...)
					task.wait()
					task.wait()
				end)
			else
				_G.AutoTamingFlute = false
				connection2:Disconnect()
			end
		end
})
	Section10:Button({
	Title = "Instant Complete 3 Minigame Maze",
	Locked = false,
	Callback = function(state, arg82)
			ReplicatedStorage:FindFirstChild("RemoteEvents")
			if state then
				local CarnivalCompleteBasketballGallery = ReplicatedStorage.RemoteEvents:FindFirstChild("CarnivalCompleteBasketballGallery")
				workspace:FindFirstChild("Map")
				local Landmarks4 = workspace.Map:FindFirstChild("Landmarks")
				local HalloweenCarnival = Landmarks4:FindFirstChild("Halloween Carnival")
				local Games = HalloweenCarnival:FindFirstChild("Games")
				local BasketballHoop = Games:FindFirstChild("Basketball Hoop")
				CarnivalCompleteBasketballGallery:FireServer(BasketballHoop)
				task.wait(0.2)
				local RingToss = Games:FindFirstChild("Ring Toss")
				CarnivalCompleteBasketballGallery:FireServer(RingToss)
				task.wait(0.2)
				local ShootingGallery = Games:FindFirstChild("Shooting Gallery")
				CarnivalCompleteBasketballGallery:FireServer(ShootingGallery)
				task.wait(0.2)
				local MazeEntrance = Games:FindFirstChild("Maze Entrance")
				CarnivalCompleteBasketballGallery:FireServer(MazeEntrance)
			else
				local CarnivalCompleteBasketballGallery2 = ReplicatedStorage.RemoteEvents:FindFirstChild("CarnivalCompleteBasketballGallery")
				workspace:FindFirstChild("Map")
				local Landmarks5 = workspace.Map:FindFirstChild("Landmarks")
				local HalloweenCarnival2 = Landmarks5:FindFirstChild("Halloween Carnival")
				local Games2 = HalloweenCarnival2:FindFirstChild("Games")
				local BasketballHoop2 = Games2:FindFirstChild("Basketball Hoop")
				CarnivalCompleteBasketballGallery2:FireServer(BasketballHoop2)
				task.wait(0.2)
				local RingToss2 = Games2:FindFirstChild("Ring Toss")
				CarnivalCompleteBasketballGallery2:FireServer(RingToss2)
				task.wait(0.2)
				local ShootingGallery2 = Games2:FindFirstChild("Shooting Gallery")
				CarnivalCompleteBasketballGallery2:FireServer(ShootingGallery2)
				task.wait(0.2)
				local MazeEntrance2 = Games2:FindFirstChild("Maze Entrance")
				CarnivalCompleteBasketballGallery2:FireServer(MazeEntrance2)
			end
			task.wait(0.2)
		end
})
	RunService.Heartbeat:Wait()
	Tab:Space()
	local Section11 = Tab:Section({
	Title = "Chest Tools",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Chest",
	Icon = "lock",
	Opened = true
})
	_G.AutoOpenAllChests = false
	task.spawn(function(...)
	end)
	_G.ChestV = false
	local Dropdown = Section11:Dropdown({
	Title = "Choose Chest To Teleport",
	AllowNone = true,
	Multi = false,
	Value = "None",
	Values = {},
	Callback = function(state, arg84)
			if state then
				_G.ChestV = state
			end
		end
})
	Section11:Button({
	Title = "Reset Chest List",
	Callback = function(state, arg86)
			if state then
				local Items2 = workspace:FindFirstChild("Items")
				local children18 = Items2:GetChildren()
				for i25, v29 in ipairs(children18) do
					v29.Name:find("Chest")
					local descendants3 = v29:GetDescendants()
					for k5, v30 in pairs(descendants3) do
					end
					Dropdown:Refresh({ v29.Name .. " (1)" })
					Dropdown:Select(v29.Name .. " (1)")
				end
			else
				local Items3 = workspace:FindFirstChild("Items")
				local children19 = Items3:GetChildren()
				for i26, v31 in ipairs(children19) do
					v31.Name:find("Chest")
					local descendants4 = v31:GetDescendants()
					for k6, v32 in pairs(descendants4) do
					end
					Dropdown:Refresh({ v31.Name .. " (1)" })
					Dropdown:Select(v31.Name .. " (1)")
				end
			end
		end
})
	Section11:Button({
	Title = "Teleport To Chest",
	Callback = function(state, arg88)
		end
})
	Section11:Button({
	Title = "Open All Chests",
	Callback = function(state, arg90)
			if state then
				local children20 = workspace.Items:GetChildren()
				for k7, v33 in pairs(children20) do
					local descendants5 = v33:GetDescendants()
					for k8, v34 in pairs(descendants5) do
					end
				end
				v34.HoldDuration = 0
				fireproximityprompt(v34, 1)
			else
				local children21 = workspace.Items:GetChildren()
				for k9, v35 in pairs(children21) do
					local descendants6 = v35:GetDescendants()
					for k10, v36 in pairs(descendants6) do
					end
				end
				v36.HoldDuration = 0
				fireproximityprompt(v36, 1)
			end
			chestLooted()
			task.wait(0.05)
		end
})
	Section11:Toggle({
	Title = "Auto Open All Chests",
	Default = false,
	Callback = function(arg91, arg92)
			_G.AutoOpenAllChests = arg91
			local children22 = workspace.Items:GetChildren()
			for k11, v37 in pairs(children22) do
				local descendants7 = v37:GetDescendants()
				for k12, v38 in pairs(descendants7) do
					v38.HoldDuration = 0
					fireproximityprompt(v38, 1)
					chestLooted()
					task.wait(0.05)
				end
			end
			task.wait(3)
			local children23 = workspace.Items:GetChildren()
			for k13, v39 in pairs(children23) do
				local descendants8 = v39:GetDescendants()
				for k14, v40 in pairs(descendants8) do
					v40.HoldDuration = 0
					fireproximityprompt(v40, 1)
					chestLooted()
					task.wait(0.05)
				end
			end
			task.wait(3)
		end
})
	Tab:Space()
	getgenv().TypeSelect = {
	Food = {
		"Morsel",
		"Cooked Morsel",
		"Steak",
		"Cooked Steak",
		"Berry",
		"Carrot",
		"Cake",
		"Chilli",
		"Stew",
		"Meat? Sandwich",
		"Corn",
		"Pumpkin"
	},
	Fuel = { "Coal", "Oil Barrel", "Fuel Canister", "Biofuel" },
	Gun = {
		"Revolver",
		"Revolver Ammo",
		"Rifle",
		"Rifle Ammo",
		"Tactical Shotgun",
		"Raygun",
		"Laser Canon",
		"Crossbow",
		"Infernal Crossbow",
		"Leather Body",
		"Iron Body",
		"Alien Amour"
	},
	Metal = {
		"Broken Fan",
		"Sheet Metal",
		"Bolt",
		"Metal Chair",
		"Broken Microwave",
		"Old Car Engine",
		"Old Radio",
		"WashingMachine",
		"Cultist Gem",
		"Tyre",
		"Gem of the Forest Fragment",
		"UFO Junk",
		"UFO Component"
	},
	Other = {
		"Halloween Candle",
		"Meteor Shard",
		"Gold Shard",
		"Raw Obsidiron Ore",
		"Scalding Obsidiron Ingot",
		"Obsidiron Ingot",
		"Anvil Front",
		"Anvil Base",
		"Anvil Back",
		"Sacrifice Totem",
		"Bunny Foot",
		"Wolf Pelt",
		"Alpha Wolf Pelt",
		"Bear Pelt",
		"Wolf Corpse",
		"Alpha Wolf Corpse",
		"Bear Corpse",
		"Polar Bear Pelt",
		"Coin Stack",
		"Arctic Wolf Pelt",
		"Mammoth Tusk",
		"Cultist King Antler",
		"Scorpion Shell"
	},
	Resources = { "Log", "Chair", "Sapling", "Diamond", "Cultist", "Crossbow Cultist", "Alien", "Hologram Emitter" },
	Tool = {
		"Old Flashlight",
		"Strong Flashlight",
		"Good Axe",
		"Strong Axe",
		"Chainsaw",
		"Good Sack",
		"Giant Sack",
		"Kunai",
		"Morningstar",
		"Wildfire",
		"Infernal Sack",
		"Defense Blueprint",
		"Bear Trap Blueprint",
		"Lava Mine Blueprint",
		"MedKit",
		"Bandage",
		"Spear",
		"Poison Spear",
		"Thorn Body",
		"Obsidiron Body",
		"Obsidiron Hammer",
		"Obsidiron Boots",
		"Cultist King Mace"
	}
}
	RunService.Heartbeat:Wait()
	Tab2:Space()
	_G.ItemToPos = "Player"
	local Section12 = Tab2:Section({
	Title = "Bring Settings",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Settings",
	Icon = "settings",
	Opened = true
})
	_G.ItemToPos = false
	Section12:Dropdown({
	Title = "Drop Item To",
	Value = "Player",
	Values = { "Player", "Campfire", "Scrapper" },
	Callback = function(state, arg94)
		end
})
	_G.BringWithoutTPMode = "Normal"
	_G.BringWithoutTPMode = false
	Section12:Dropdown({
	Title = "Bring Mode",
	Value = "Normal",
	Values = { "Normal", "Fast" },
	Callback = function(state, arg96)
		end
})
	Section12:Toggle({
	Title = "Admin Only Items",
	Desc = "Include items from admin folder in database",
	Type = "Checkbox",
	Value = false,
	Callback = function(state, arg98)
			if state then
				task.spawn(function(...)
					local children24 = Items:GetChildren()
					for i27, v43 in ipairs(children24) do
					end
					local ForyxeAdmin_V3 = ReplicatedStorage:FindFirstChild("ForyxeAdmin_V3")
					local EnumHandler = ForyxeAdmin_V3:FindFirstChild("EnumHandler")
					local Enums = EnumHandler:FindFirstChild("Enums")
					local itemnames = Enums:FindFirstChild("itemnames")
					itemnames:GetAttribute("EnumValues")
				end)
			else
				task.spawn(function(...)
					local children25 = Items:GetChildren()
					for i28, v44 in ipairs(children25) do
					end
				end)
			end
		end
})
	Section12:Button({
	Title = "Refresh Item Database",
	Icon = "refresh-cw",
	Callback = function(state, arg100)
			if state then
				task.spawn(function(...)
					local children26 = Items:GetChildren()
					for i29, v45 in ipairs(children26) do
					end
				end)
			else
				task.spawn(function(...)
					local children27 = Items:GetChildren()
					for i30, v46 in ipairs(children27) do
					end
				end)
			end
			result:Notify({
	Title = "Bring database refreshed",
	Content = "Loaded the complete replicated item catalog.",
	Duration = 3
})
		end
})
	Tab2:Space()
	Tab2:Space()
	local Section13 = Tab2:Section({
	Title = "Fuel",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Fuel Section",
	Icon = "flame",
	Opened = true
})
	Section13:Dropdown({
	Title = "Select Fuel",
	AllowNone = true,
	Multi = true,
	Value = {},
	Values = { "Biofuel", "Coal", "Fuel Canister", "Oil Barrel" },
	Callback = function(state, arg102)
		end
})
	Section13:Button({
	Title = "Bring Fuel",
	Desc = "Bring selected Fuel items",
	Callback = function(arg103, arg104)
		end
})
	Tab2:Space()
	local Section14 = Tab2:Section({
	Title = "Resources",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Resources Section",
	Icon = "logs",
	Opened = true
})
	Section14:Dropdown({
	Title = "Select Resources",
	AllowNone = true,
	Multi = true,
	Value = {},
	Values = { "Alien", "Chair", "Crossbow Cultist", "Cultist", "Diamond", "Hologram Emitter", "Log", "Sapling" },
	Callback = function(state, arg106)
		end
})
	Section14:Button({
	Title = "Bring Resources",
	Desc = "Bring selected Resources items",
	Callback = function(arg107, arg108)
		end
})
	RunService.Heartbeat:Wait()
	Tab2:Space()
	local Section15 = Tab2:Section({
	Title = "Metal",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Metal Section",
	Icon = "wrench",
	Opened = true
})
	Section15:Dropdown({
	Title = "Select Metal",
	AllowNone = true,
	Multi = true,
	Value = {},
	Values = {
		"Bolt",
		"Broken Fan",
		"Broken Microwave",
		"Cultist Gem",
		"Gem of the Forest Fragment",
		"Metal Chair",
		"Old Car Engine",
		"Old Radio",
		"Sheet Metal",
		"Tyre",
		"UFO Component",
		"UFO Junk",
		"WashingMachine"
	},
	Callback = function(state, arg110)
		end
})
	Section15:Button({
	Title = "Bring Metal",
	Desc = "Bring selected Metal items",
	Callback = function(arg111, arg112)
		end
})
	Tab2:Space()
	local Section16 = Tab2:Section({
	Title = "Food",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Food Section",
	Icon = "beef",
	Opened = true
})
	Section16:Dropdown({
	Title = "Select Food",
	AllowNone = true,
	Multi = true,
	Value = {},
	Values = {
		"Berry",
		"Cake",
		"Carrot",
		"Chilli",
		"Cooked Morsel",
		"Cooked Steak",
		"Corn",
		"Meat? Sandwich",
		"Morsel",
		"Pumpkin",
		"Steak",
		"Stew"
	},
	Callback = function(state, arg114)
		end
})
	Section16:Button({
	Title = "Bring Food",
	Desc = "Bring selected Food items",
	Callback = function(arg115, arg116)
		end
})
	RunService.Heartbeat:Wait()
	Tab2:Space()
	local Section17 = Tab2:Section({
	Title = "Tool",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Tool Section",
	Icon = "hammer",
	Opened = true
})
	Section17:Dropdown({
	Title = "Select Tool",
	AllowNone = true,
	Multi = true,
	Value = {},
	Values = {
		"Bandage",
		"Bear Trap Blueprint",
		"Chainsaw",
		"Cultist King Mace",
		"Defense Blueprint",
		"Giant Sack",
		"Good Axe",
		"Good Sack",
		"Infernal Sack",
		"Kunai",
		"Lava Mine Blueprint",
		"MedKit",
		"Morningstar",
		"Obsidiron Body",
		"Obsidiron Boots",
		"Obsidiron Hammer",
		"Old Flashlight",
		"Poison Spear",
		"Spear",
		"Strong Axe",
		"Strong Flashlight",
		"Thorn Body",
		"Wildfire"
	},
	Callback = function(state, arg118)
		end
})
	Section17:Button({
	Title = "Bring Tool",
	Desc = "Bring selected Tool items",
	Callback = function(arg119, arg120)
		end
})
	Tab2:Space()
	local Section18 = Tab2:Section({
	Title = "Gun",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Gun Section",
	Icon = "crosshair",
	Opened = true
})
	Section18:Dropdown({
	Title = "Select Gun",
	AllowNone = true,
	Multi = true,
	Value = {},
	Values = {
		"Alien Amour",
		"Crossbow",
		"Infernal Crossbow",
		"Iron Body",
		"Laser Canon",
		"Leather Body",
		"Raygun",
		"Revolver",
		"Revolver Ammo",
		"Rifle",
		"Rifle Ammo",
		"Tactical Shotgun"
	},
	Callback = function(state, arg122)
		end
})
	Section18:Button({
	Title = "Bring Gun",
	Desc = "Bring selected Gun items",
	Callback = function(arg123, arg124)
		end
})
	RunService.Heartbeat:Wait()
	Tab2:Space()
	local Section19 = Tab2:Section({
	Title = "Other",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Other Section",
	Icon = "package",
	Opened = true
})
	Section19:Dropdown({
	Title = "Select Other",
	AllowNone = true,
	Multi = true,
	Value = {},
	Values = {
		"Alpha Wolf Corpse",
		"Alpha Wolf Pelt",
		"Anvil Back",
		"Anvil Base",
		"Anvil Front",
		"Arctic Wolf Pelt",
		"Bear Corpse",
		"Bear Pelt",
		"Bunny Foot",
		"Coin Stack",
		"Cultist King Antler",
		"Gold Shard",
		"Halloween Candle",
		"Mammoth Tusk",
		"Meteor Shard",
		"Obsidiron Ingot",
		"Polar Bear Pelt",
		"Raw Obsidiron Ore",
		"Sacrifice Totem",
		"Scalding Obsidiron Ingot",
		"Scorpion Shell",
		"Wolf Corpse",
		"Wolf Pelt"
	},
	Callback = function(state, arg126)
		end
})
	Section19:Button({
	Title = "Bring Other",
	Desc = "Bring selected Other items",
	Callback = function(arg127, arg128)
		end
})
	task.spawn(function(...)
		result:Notify({
	Title = "Getting Item Data..",
	Content = "Script is getting item data in background...",
	Duration = 3,
	Icon = "database"
})
		task.wait(1.5)
		result:Notify({
	Title = "Item Data Loaded",
	Content = "Bring item database is ready to use.",
	Duration = 3,
	Icon = "check-circle"
})
	end)
	local connection3 = Items.ChildAdded:Connect(function(child)
	end)
	getgenv().__FN99BringItemConnection = connection3
	RunService.Heartbeat:Wait()
	local Section20 = Tab3:Section({
	Title = "Locations",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Teleport",
	Icon = "map-pin",
	Opened = true
})
	Section20:Button({
	Title = "Tp to Campfire",
	Locked = false,
	Callback = function(state, arg130)
			Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			Players.LocalPlayer.Character:PivotTo(CFrame.new(0, 9, 0))
		end
})
	Section20:Button({
	Title = "Tp to Fish",
	Locked = false,
	Callback = function(state, arg132)
			if state then
				local HumanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				workspace:FindFirstChild("Map")
				workspace.Map:FindFirstChild("Landmarks")
				local FishingHut = workspace.Map.Landmarks:FindFirstChild("Fishing Hut")
				FishingHut:GetPivot()
				local pivot = FishingHut:GetPivot()
				HumanoidRootPart.CFrame = CFrame.new(pivot.Position)
			else
				local HumanoidRootPart2 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				workspace:FindFirstChild("Map")
				workspace.Map:FindFirstChild("Landmarks")
				local FishingHut2 = workspace.Map.Landmarks:FindFirstChild("Fishing Hut")
				FishingHut2:GetPivot()
				local pivot2 = FishingHut2:GetPivot()
				HumanoidRootPart2.CFrame = CFrame.new(pivot2.Position)
			end
		end
})
	Section20:Button({
	Title = "Tp to Skills Building",
	Locked = false,
	Callback = function(state, arg134)
			if state then
				local HumanoidRootPart3 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map5 = workspace:FindFirstChild("Map")
				Map5:FindFirstChild("Landmarks")
				local SkillsBuilding = Map5.Landmarks:FindFirstChild("Skills Building")
				HumanoidRootPart3.CFrame = SkillsBuilding.PrimaryPart.CFrame
			else
				local HumanoidRootPart4 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map6 = workspace:FindFirstChild("Map")
				Map6:FindFirstChild("Landmarks")
				local SkillsBuilding2 = Map6.Landmarks:FindFirstChild("Skills Building")
				HumanoidRootPart4.CFrame = SkillsBuilding2.PrimaryPart.CFrame
			end
		end
})
	Section20:Button({
	Title = "Tp to Stronghold",
	Locked = false,
	Callback = function(state, arg136)
			if state then
				local HumanoidRootPart5 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map7 = workspace:FindFirstChild("Map")
				Map7:FindFirstChild("Landmarks")
				local Stronghold = Map7.Landmarks:FindFirstChild("Stronghold")
				HumanoidRootPart5.CFrame = Stronghold.PrimaryPart.CFrame
			else
				local HumanoidRootPart6 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map8 = workspace:FindFirstChild("Map")
				Map8:FindFirstChild("Landmarks")
				local Stronghold2 = Map8.Landmarks:FindFirstChild("Stronghold")
				HumanoidRootPart6.CFrame = Stronghold2.PrimaryPart.CFrame
			end
		end
})
	Section20:Button({
	Title = "Tp to ToolWorkshop",
	Locked = false,
	Callback = function(state, arg138)
			if state then
				local HumanoidRootPart7 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map9 = workspace:FindFirstChild("Map")
				Map9:FindFirstChild("Landmarks")
				local ToolWorkshop = Map9.Landmarks:FindFirstChild("ToolWorkshop")
				HumanoidRootPart7.CFrame = ToolWorkshop.PrimaryPart.CFrame
			else
				local HumanoidRootPart8 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map10 = workspace:FindFirstChild("Map")
				Map10:FindFirstChild("Landmarks")
				local ToolWorkshop2 = Map10.Landmarks:FindFirstChild("ToolWorkshop")
				HumanoidRootPart8.CFrame = ToolWorkshop2.PrimaryPart.CFrame
			end
		end
})
	Section20:Button({
	Title = "Tp to Sacrifice area",
	Locked = false,
	Callback = function(state, arg140)
			if state then
				local HumanoidRootPart9 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map11 = workspace:FindFirstChild("Map")
				local Landmarks6 = Map11:FindFirstChild("Landmarks")
				local Volcano2 = Landmarks6:FindFirstChild("Volcano")
				local Functional2 = Volcano2:FindFirstChild("Functional")
				local Sacrifice = Functional2:FindFirstChild("Sacrifice")
				HumanoidRootPart9.CFrame = (Sacrifice.CFrame + Vector3.new(0, 5, 0))
			else
				local HumanoidRootPart10 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map12 = workspace:FindFirstChild("Map")
				local Landmarks7 = Map12:FindFirstChild("Landmarks")
				local Volcano3 = Landmarks7:FindFirstChild("Volcano")
				local Functional3 = Volcano3:FindFirstChild("Functional")
				local Sacrifice2 = Functional3:FindFirstChild("Sacrifice")
				HumanoidRootPart10.CFrame = (Sacrifice2.CFrame + Vector3.new(0, 5, 0))
			end
		end
})
	Section20:Button({
	Title = "Tp to Ice Temple",
	Locked = false,
	Callback = function(state, arg142)
			if state then
				local HumanoidRootPart11 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map13 = workspace:FindFirstChild("Map")
				Map13:FindFirstChild("Landmarks")
				local IceTemple = Map13.Landmarks:FindFirstChild("Ice Temple")
				HumanoidRootPart11.CFrame = IceTemple.PrimaryPart.CFrame
			else
				local HumanoidRootPart12 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map14 = workspace:FindFirstChild("Map")
				Map14:FindFirstChild("Landmarks")
				local IceTemple2 = Map14.Landmarks:FindFirstChild("Ice Temple")
				HumanoidRootPart12.CFrame = IceTemple2.PrimaryPart.CFrame
			end
		end
})
	Section20:Button({
	Title = "Tp to Snow Clothing Shop",
	Locked = false,
	Callback = function(state, arg144)
			if state then
				local HumanoidRootPart13 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map15 = workspace:FindFirstChild("Map")
				Map15:FindFirstChild("Landmarks")
				local SnowClothingShop = Map15.Landmarks:FindFirstChild("Snow Clothing Shop")
				HumanoidRootPart13.CFrame = SnowClothingShop.PrimaryPart.CFrame
			else
				local HumanoidRootPart14 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map16 = workspace:FindFirstChild("Map")
				Map16:FindFirstChild("Landmarks")
				local SnowClothingShop2 = Map16.Landmarks:FindFirstChild("Snow Clothing Shop")
				HumanoidRootPart14.CFrame = SnowClothingShop2.PrimaryPart.CFrame
			end
		end
})
	Section20:Button({
	Title = "Tp to Research Facility",
	Locked = false,
	Callback = function(state, arg146)
			if state then
				local HumanoidRootPart15 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map17 = workspace:FindFirstChild("Map")
				Map17:FindFirstChild("Landmarks")
				local ResearchFacility = Map17.Landmarks:FindFirstChild("Research Facility")
				HumanoidRootPart15.CFrame = ResearchFacility.PrimaryPart.CFrame
			else
				local HumanoidRootPart16 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map18 = workspace:FindFirstChild("Map")
				Map18:FindFirstChild("Landmarks")
				local ResearchFacility2 = Map18.Landmarks:FindFirstChild("Research Facility")
				HumanoidRootPart16.CFrame = ResearchFacility2.PrimaryPart.CFrame
			end
		end
})
	Section20:Button({
	Title = "Tp to Research Outpost",
	Locked = false,
	Callback = function(state, arg148)
			if state then
				local HumanoidRootPart17 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map19 = workspace:FindFirstChild("Map")
				Map19:FindFirstChild("Landmarks")
				local ResearchOutpost = Map19.Landmarks:FindFirstChild("Research Outpost")
				HumanoidRootPart17.CFrame = ResearchOutpost.PrimaryPart.CFrame
			else
				local HumanoidRootPart18 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				local Map20 = workspace:FindFirstChild("Map")
				Map20:FindFirstChild("Landmarks")
				local ResearchOutpost2 = Map20.Landmarks:FindFirstChild("Research Outpost")
				HumanoidRootPart18.CFrame = ResearchOutpost2.PrimaryPart.CFrame
			end
		end
})
	Tab3:Space()
	local Section21 = Tab3:Section({
	Title = "Player Teleport",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Player",
	Icon = "users",
	Opened = true
})
	local players = Players:GetPlayers()
	for i31, v47 in ipairs(players) do
	end
	Players.PlayerAdded:Connect(function(player)
		local players2 = Players:GetPlayers()
		for i37, v53 in ipairs(players2) do
		end
		Dropdown2:Refresh({ v53.Name })
	end)
	Players.PlayerRemoving:Connect(function(player2)
		local players3 = Players:GetPlayers()
		for i38, v54 in ipairs(players3) do
		end
		Dropdown2:Refresh({ v54.Name })
	end)
	_G.SelectedTpPlayer = false
	local Dropdown2 = Section21:Dropdown({
	Title = "Select Player",
	Value = "None",
	Values = { v47.Name },
	Callback = function(state, arg150)
			if state then
				_G.SelectedTpPlayer = state
			end
		end
})
	Section21:Button({
	Title = "Tp to Selected Player",
	Callback = function(state, arg152)
			Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			result:Notify({
	Title = "Teleport",
	Content = "Invalid player or no character",
	Background = "rbxassetid://78131090774816",
	Duration = 2,
	Icon = "warning"
})
		end
})
	local Section22 = Tab3:Section({
	Title = "NPC Teleport",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "NPC",
	Icon = "bot",
	Opened = true
})
	local Characters7 = workspace:FindFirstChild("Characters")
	local children28 = Characters7:GetChildren()
	for i32, v48 in ipairs(children28) do
	end
	_G.SelectedTpNpc = false
	local Dropdown3 = Section22:Dropdown({
	Title = "Select NPC",
	Value = "None",
	Values = { v48.Name },
	Callback = function(state, arg154)
			if state then
				_G.SelectedTpNpc = state
			end
		end
})
	Section22:Button({
	Title = "Tp to NPC",
	Callback = function(state, arg156)
			result:Notify({
	Title = "Tp to NPC",
	Content = "No NPC selected",
	Background = "rbxassetid://78131090774816",
	Duration = 2,
	Icon = "warning"
})
		end
})
	Section22:Button({
	Title = "Refresh NPC List",
	Callback = function(state, arg158)
			if state then
				local Characters8 = workspace:FindFirstChild("Characters")
				local children29 = Characters8:GetChildren()
				for i33, v49 in ipairs(children29) do
				end
				Dropdown3:Refresh({ v49.Name })
			else
				local Characters9 = workspace:FindFirstChild("Characters")
				local children30 = Characters9:GetChildren()
				for i34, v50 in ipairs(children30) do
				end
				Dropdown3:Refresh({ v50.Name })
			end
			result:Notify({
	Title = "Tp to NPC",
	Content = "NPC list refreshed",
	Background = "rbxassetid://78131090774816",
	Duration = 1.5,
	Icon = "info"
})
		end
})
	getgenv().TreeShapes = {
	Circle = function(arg159, arg160)
		end,
	Cross = function(arg161, arg162)
		end,
	Diamond = function(arg163, arg164)
		end,
	Heart = function(arg165, arg166)
		end,
	Pentagon = function(arg167, arg168)
		end,
	Spiral = function(arg169, arg170)
		end,
	Square = function(arg171, arg172)
		end,
	Star = function(arg173, arg174)
		end,
	Triangle = function(arg175, arg176)
		end
}
	Tab4:Space()
	local Section23 = Tab4:Section({
	Title = "Tree Visuals",
	Box = true,
	BoxBorder = true,
	ConfigFlagKey = "Visuals",
	Icon = "eye",
	Opened = true
})
	Section23:Toggle({
	Title = "Tree Health Bar",
	Default = true,
	Value = true,
	Callback = function(arg177, arg178)
			local Map21 = workspace:FindFirstChild("Map")
			local Foliage3 = Map21:FindFirstChild("Foliage")
			local children31 = Foliage3:GetChildren()
			for i35, v51 in ipairs(children31) do
				v51:GetAttribute("Resource")
				local Trunk = v51:FindFirstChild("Trunk")
				local Assets = ReplicatedStorage:FindFirstChild("Assets")
				local Interface3 = Assets:FindFirstChild("Interface")
				local HealthBars = Interface3:FindFirstChild("HealthBars")
				local HealthBar = HealthBars:FindFirstChild("HealthBar")
				local clone = HealthBar:Clone()
				clone.Name = "TreeCustomHealthBar"
				clone.Adornee = Trunk
				clone.StudsOffset = Vector3.new(0, ((Trunk.Size.Y / 2) + 1), 0)
				clone.Enabled = false
				clone.Parent = Trunk
				v51:GetAttribute("Health")
				v51:GetAttribute("MaxHealth")
			end
		end
})
	clone:Destroy()
	local Map22 = workspace:FindFirstChild("Map")
	local Foliage4 = Map22:FindFirstChild("Foliage")
	local children32 = Foliage4:GetChildren()
	for i36, v52 in ipairs(children32) do
		v52:GetAttribute("Resource")
		local Trunk2 = v52:FindFirstChild("Trunk")
		local Assets2 = ReplicatedStorage:FindFirstChild("Assets")
		local Interface4 = Assets2:FindFirstChild("Interface")
		local HealthBars2 = Interface4:FindFirstChild("HealthBars")
		local HealthBar2 = HealthBars2:FindFirstChild("HealthBar")
		local clone2 = HealthBar2:Clone()
		clone2.Name = "TreeCustomHealthBar"
		clone2.Adornee = Trunk2
		clone2.StudsOffset = Vector3.new(0, ((Trunk2.Size.Y / 2) + 1), 0)
		clone2.Enabled = false
		clone2.Parent = Trunk2
		v52:GetAttribute("Health")
		v52:GetAttribute("MaxHealth")
	end
end)
