--Anti-DisplayName v5 by m0thra, fixed version by z O O r#1396
--My Discord: z O O r#1396
local Data = { -- [Essential Data] Don't edit this table unless you know what you're doing and want a functional script, please. ;) - mothwa
    Main = 'rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/App/ImageSet/ImageAtlas/img_set_1x_1.png',
    Friend = 'rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/App/ImageSet/ImageAtlas/img_set_1x_2.png',
    BlockedPos = '194, 485',
    PremiumPos = '243, 485',
    FriendPos = '486, 213'    
}

local Players, LP, PLM = nil, nil, nil

local function FindChildByOrder(parent, tbl, returnInstance)
    if parent and tbl and typeof(parent) == 'Instance' and type(tbl) == 'table' and #tbl > 0 then
        local Current = parent;
        for _, v in next, tbl do
            coroutine.wrap(function()
                if type(v) == 'string' and Current:FindFirstChild(v) then
                    Current = Current:FindFirstChild(v)
                else
                    return false
                end
            end)()
        end
        if not returnInstance then
            return true
        elseif returnInstance then
            return Current
        end
    end
end

local function GetPlayer(data)
    if type(data) == 'string' then
        for _, v in next, Players:GetPlayers() do
            if v.Name:lower():match('^'..data:lower()) or v.DisplayName:lower():match('^'..data:lower()) then
                return v
            end
        end
    elseif type(data) == 'number' then
        for _, v in next, Players:GetPlayers() do
            if v.UserId == data then
                return v
            end
        end
    end
end

local PLM = FindChildByOrder(game:GetService('CoreGui'), {'PlayerList', 'PlayerListMaster', 'OffsetFrame', 'PlayerScrollList', 'SizeOffsetFrame', 'ScrollingFrameContainer', 'ScrollingFrameClippingFrame', 'ScollingFrame', 'OffsetUndoFrame'}, true)
local function UpdateLeaderboardDisplayName(userId)
    if PLM then
        pcall(function()
            for I, PlayerNameInstance in next, PLM:GetChildren() do
                if PlayerNameInstance.Name:match(tostring(userId)..'$') then
                    local TP, NLabel, Status = GetPlayer(0 + PlayerNameInstance.Name:gsub('p_', '')), FindChildByOrder(PlayerNameInstance, {'ChildrenFrame', 'NameFrame', 'BGFrame', 'OverlayFrame', 'PlayerName', 'PlayerName'}, true), FindChildByOrder(PlayerNameInstance, {'ChildrenFrame', 'NameFrame', 'BGFrame', 'OverlayFrame', 'PlayerIcon'}, true)
                    if getgenv().ADv5LiveSettings.ApplyToLeaderboard and getgenv().ADv5LiveSettings.ApplyToLeaderboard == true and getgenv().ADv5LiveSettings.DisplayNameToName and getgenv().ADv5LiveSettings.DisplayNameToName == true then
                        NLabel.RichText = false
                        NLabel.Text = TP.Name
                    else
                        if tostring(Status.ImageRectOffset) == Data.FriendPos then --1
                            if getgenv().ADv5LiveSettings.ApplyToLeaderboard and getgenv().ADv5LiveSettings.ApplyToLeaderboard == true and getgenv().ADv5LiveSettings.IdentifyFriends then
                                NLabel.RichText = true
                                if getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name ~= TP.DisplayName then
                                    NLabel.Text = '<font color="#24EC00">'..TP.DisplayName..'\n(@'..TP.Name..')'..'</font>'
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name ~= TP.DisplayName then
                                    NLabel.Text = '<font color="#24EC00">'..TP.DisplayName..' (@'..TP.Name..')'..'</font>'
                                elseif table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name == TP.DisplayName then
                                    NLabel.Text = '<font color="#24EC00">'..TP.DisplayName..'</font>'
                                end
                            else
                                NLabel.RichText = false
                                NLabel.Text = TP.DisplayName
                            end
                        elseif tostring(Status.ImageRectOffset) == Data.BlockedPos then --2
                            if getgenv().ADv5LiveSettings.ApplyToLeaderboard and getgenv().ADv5LiveSettings.ApplyToLeaderboard == true and getgenv().ADv5LiveSettings.ShowBlockedInName then
                                NLabel.RichText = true
                                if getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name ~= TP.DisplayName then
                                    NLabel.Text = '<font color="#FC0000">'..TP.DisplayName..'\n(@'..TP.Name..')'..'</font>'
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name ~= TP.DisplayName then
                                    NLabel.Text = '<font color="#FC0000">'..TP.DisplayName..' (@'..TP.Name..')'..'</font>'
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name == TP.DisplayName then
                                    NLabel.Text = '<font color="#FC0000">'..TP.DisplayName..'</font>'
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name ~= TP.DisplayName then
                                    NLabel.Text = '<font color="#FC0000">'..TP.DisplayName..'</font>'
                                end
                            else
                                NLabel.RichText = false
                                NLabel.Text = TP.DisplayName
                            end
                        else --3
                            if getgenv().ADv5LiveSettings.ApplyToLeaderboard and getgenv().ADv5LiveSettings.ApplyToLeaderboard == true then
                                NLabel.RichText = true
                                if getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name ~= TP.DisplayName then
                                    NLabel.Text = TP.DisplayName..'\n(@'..TP.Name..')'
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name ~= TP.DisplayName then
                                    NLabel.Text = TP.DisplayName..' (@'..TP.Name..')'
                                elseif table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name == TP.DisplayName then
                                    NLabel.Text = TP.DisplayName
                                end
                            else
                                NLabel.RichText = false
                                NLabel.Text = TP.DisplayName
                            end
                        end
                    end
                end
            end
        end)
    end
end

local function UpdateCharacterDisplayName(Char)
    local TP, H = Players:GetPlayerFromCharacter(Char), Char:FindFirstChildWhichIsA('Humanoid')
    if PLM and TP and H then
        pcall(function()
            for I, PlayerNameInstance in next, PLM:GetChildren() do
                if PlayerNameInstance.Name:match(tostring(TP.UserId)..'$') then
                local Status = FindChildByOrder(PlayerNameInstance, {'ChildrenFrame', 'NameFrame', 'BGFrame', 'OverlayFrame', 'PlayerIcon'}, true)
                    if getgenv().ADv5LiveSettings.DisplayNameToName == false then
                        if tostring(Status.ImageRectOffset) == Data.FriendPos then --1
                            if getgenv().ADv5LiveSettings.IdentifyFriends == true then
                                if getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name ~= TP.DisplayName then
                                    H.DisplayName = TP.DisplayName..'\n(@'..TP.Name..')'..getgenv().ADv5LiveSettings.FriendIdentifier
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name ~= TP.DisplayName then
                                    H.DisplayName = TP.DisplayName..' (@'..TP.Name..')'..getgenv().ADv5LiveSettings.FriendIdentifier
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name == TP.DisplayName then
                                    H.DisplayName = TP.DisplayName..'\n'..getgenv().ADv5LiveSettings.FriendIdentifier
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name == TP.DisplayName then
                                    H.DisplayName = TP.DisplayName..getgenv().ADv5LiveSettings.FriendIdentifier
                                end
                            elseif not getgenv().ADv5LiveSettings.ShowBlockedInName then
                                H.DisplayName = TP.DisplayName
                            end
                        elseif tostring(Status.ImageRectOffset) == Data.BlockedPos then --2
                            if getgenv().ADv5LiveSettings.ShowBlockedInName then
                                if getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name ~= TP.DisplayName then
                                    H.DisplayName = TP.DisplayName..'\n(@'..TP.Name..')'..getgenv().ADv5LiveSettings.BlockedIdentifier
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name ~= TP.DisplayName then
                                    H.DisplayName = TP.DisplayName..' (@'..TP.Name..')'..getgenv().ADv5LiveSettings.BlockedIdentifier
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name == TP.DisplayName then
                                    H.DisplayName = TP.DisplayName..'\n'..getgenv().ADv5LiveSettings.BlockedIdentifier
                                elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name == TP.DisplayName then
                                    H.DisplayName = TP.DisplayName..getgenv().ADv5LiveSettings.BlockedIdentifier
                                end
                            elseif not getgenv().ADv5LiveSettings.ShowBlockedInName then
                                    H.DisplayName = TP.DisplayName
                                end
                            else --3
                            if getgenv().ADv5LiveSettings.Orientation == 'Vertical' or not table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name ~= TP.DisplayName then
                                H.DisplayName = TP.DisplayName..'\n(@'..TP.Name..')'
                            elseif getgenv().ADv5LiveSettings.Orientation == 'Horizontal' and TP.Name ~= TP.DisplayName then
                                H.DisplayName = TP.DisplayName..' (@'..TP.Name..')'
                            elseif table.find({'Vertical', 'Horizontal'}, getgenv().ADv5LiveSettings.Orientation) and TP.Name == TP.DisplayName then
                                H.DisplayName = TP.DisplayName
                            end
                        end
                    else
                        if getgenv().ADv5LiveSettings.ApplyToLeaderboard == true then
                            UpdateLeaderboardDisplayName(TP.UserId)
                            H.DisplayName = TP.Name
                        else
                            H.DisplayName = TP.Name
                        end
                    end
                end
            end
        end)
    end
end
    
if not game:IsLoaded() or not game:GetService('Players')['LocalPlayer'] then
    game['Loaded']:Wait();
    game:WaitForChild(game:GetService('Players'));
    game:GetService('Players'):WaitForChild(game:GetService('Players').LocalPlayer.Name)
end

Players, LP, PLM = game:GetService('Players'), game:GetService('Players').LocalPlayer, FindChildByOrder(game:GetService('CoreGui'), {'PlayerList', 'PlayerListMaster', 'OffsetFrame', 'PlayerScrollList', 'SizeOffsetFrame', 'ScrollingFrameContainer', 'ScrollingFrameClippingFrame', 'ScollingFrame', 'OffsetUndoFrame'}, true)
if PLM and not getgenv().ADv5LiveSettings then
    PLM.ChildAdded:Connect(function(PlayerNameInstance)
        local UID = 0 + PlayerNameInstance.Name:match('%d+')
        if type(UID) == 'number' then
            UpdateLeaderboardDisplayName(UID)
        end
    end)
end

getgenv().ADv5LiveSettings = Settings
while wait(.2) do
    pcall(function()
        for _, v in next, Players:GetPlayers() do
            task.spawn(function()
                if v ~= LP then
                    if v['Character'] then
                        UpdateCharacterDisplayName(v.Character)
                    end
                    UpdateLeaderboardDisplayName(v.UserId)
                end
            end)
        end
    end)
end
if not getgenv().ADv5LiveSettings then
    Players.PlayerAdded:Connect(function(Player)
        if Player['Character'] then
            UpdateCharacterDisplayName(Player.Character)
        end
        Player.CharacterAdded:Connect(function(Char)
            wait()
            UpdateCharacterDisplayName(Char)
        end)
        UpdateLeaderboardDisplayName(Player.UserId)
    end)
end