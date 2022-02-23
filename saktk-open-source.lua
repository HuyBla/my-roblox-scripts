firetouchinterest(game:GetService("Workspace").AREA51.RayGun["RayGun Giver"]["PUT THE WEAPON IN THIS BRICK"], game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0)
firetouchinterest(game:GetService("Workspace").AREA51.M14["M14 Giver"]["PUT THE WEAPON IN THIS BRICK"], game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0)

wait(0.75)
game:GetService("ReplicatedStorage")["Remote Functions"]["PAP Weapon"]:InvokeServer("RayGun")
game:GetService("ReplicatedStorage")["Remote Events"].PAPFinished:FireServer()
wait(0.15)
game:GetService("ReplicatedStorage")["Remote Functions"]["PAP Weapon"]:InvokeServer("M14")
game:GetService("ReplicatedStorage")["Remote Events"].PAPFinished:FireServer()
wait(0.75)

function CountTable(q)
	local r, s = 0
	repeat
		s = next(q, s)
		if s ~= nil then
			r = r + 1
		end
	until s == nil
	return r
end

for t, u in pairs(getgc()) do --i stole xd
	if type(u) == "function" and rawget(getfenv(u), "script") == game:GetService("Players").LocalPlayer.PlayerScripts.LocalManager then
		local w = debug.getconstants(u)
		if CountTable(w) == 5 then
			if table.find(w, "WalkSpeed") and table.find(w, "GetPropertyChangedSignal") and table.find(w, "Connect") then
				hookfunction(u, function() end)
			end
		end
	end
end

hookfunction(getconnections(game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"))[1].Function, function() end)
local Conn = game:GetService("RunService").Heartbeat:Connect(function()
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 30
end)

for i, v in pairs(getgc(true)) do --gun mods by c0n
    if type(v) == "table" and rawget(v, "ammo") then
        v.ammo = math.huge
        v.max_ammo = math.huge
        v.stored_ammo = math.huge
        v.max_stored = math.huge
        v.shoot_wait = 0
    end
end

local fireammo = { -- again i stole xd
    repeatamount = 50,
    inclusions = {
        "Missile Touch",
        "Fired"
    }
}

local function shoot(ac)
	for K, a7 in next, fireammo.inclusions do
		if ac.Name == a7 then
			return true
		end
	end
	return false
end

local old --change getrawmetatable to hookmetamethod
old = hookmetamethod(game, "__namecall", function(fired, ...)
    local call = getnamecallmethod()
    if call == "FireServer" and shoot(fired) then
        for K = 1, fireammo.repeatamount do
            old(fired, ...)
        end
    end
    return old(fired, ...)
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(ok)
    Conn:Disconnect()
    wait(0.75)
    hookfunction(getconnections(ok.Humanoid:GetPropertyChangedSignal("WalkSpeed"))[1].Function, function() end)
    game:GetService("RunService").Heartbeat:Connect(function()
        ok.Humanoid.WalkSpeed = 30
    end)
    firetouchinterest(game:GetService("Workspace").AREA51.RayGun["RayGun Giver"]["PUT THE WEAPON IN THIS BRICK"], ok.HumanoidRootPart, 0)
    firetouchinterest(game:GetService("Workspace").AREA51.M14["M14 Giver"]["PUT THE WEAPON IN THIS BRICK"], ok.HumanoidRootPart, 0)

    wait(0.75)
    game:GetService("ReplicatedStorage")["Remote Functions"]["PAP Weapon"]:InvokeServer("RayGun")
    game:GetService("ReplicatedStorage")["Remote Events"].PAPFinished:FireServer()
    wait(0.15)
    game:GetService("ReplicatedStorage")["Remote Functions"]["PAP Weapon"]:InvokeServer("M14")
    game:GetService("ReplicatedStorage")["Remote Events"].PAPFinished:FireServer()
    wait(0.75)

    for i, v in pairs(getgc(true)) do --gun mods by c0n
        if type(v) == "table" and rawget(v, "ammo") then
            v.ammo = math.huge
            v.max_ammo = math.huge
            v.stored_ammo = math.huge
            v.max_stored = math.huge
            v.shoot_wait = 0
        end
    end
end)
