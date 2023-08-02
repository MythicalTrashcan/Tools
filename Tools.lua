local Players = game:GetService('Players')

local function getCharacter(LocalPlayer)
	local Character = LocalPlayer.Character
		
	if not Character then
		LocalPlayer.CharacterAdded:Wait()
		task.wait(0.3)
		Character = LocalPlayer.Character
	end
	
	return Character
		
end

local function getPlayerByName(name)
	for _, v in next, Players:GetPlayers() do
		if v.Name == name or v.DisplayName == name then
			return v
		end
		
		if string.find(v.Name, name) or string.find(v.DisplayName, name) then
			return v
		end
	end

	return nil
end

local Scripts = {
  ['SetLocalSpeed'] = function(Arguments: {Speed: number})
    local Character = getCharacter(Players.LocalPlayer)
		
	local Humanoid = Character:WaitForChild('Humanoid')
	Humanoid.WalkSpeed = Arguments[1]
	
	return Humanoid
  end,
  ['SetLocalJump'] = function(Arguments: {Jump: number})
    local Character = getCharacter(Players.LocalPlayer)
		
		local Humanoid = Character:WaitForChild('Humanoid')
		Humanoid.JumpPower = Arguments[1]
		
		return Humanoid
  end,
  ['TeleportToPlayer'] = function(Arguments: {PlayerName: string})
    local Character = getCharacter(Players.LocalPlayer)
		
	local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
	local PlayerRootPart = getPlayerByName(Arguments[1]).Character:WaitForChild('HumanoidRootPart')
	
	HumanoidRootPart.CFrame = PlayerRootPart.CFrame
	
	return { PlayerRootPart, HumanoidRootPart }
  end,
  ['GetLocalCharacter'] = function()
    local Character = getCharacter(Players.LocalPlayer)

    return Character
  end
}

local old;
old = hookmetamethod(game, '__namecall', function(self, ...)
	local Method = getnamecallmethod()
	local Arguments = { ... }
	
	if self ~= game then
		return old(self, ...)
	end

  if Scripts[Method] ~= nil then
    return Scripts[Method](Arguments)
  end
	
	if Method == 'GetLocalPlayer' then
		return Players.LocalPlayer
  end
	
	return old(self, ...)
end)
