--[[
Anti-DisplayName by m0thra, improved script by z O O r#1396
My Discord: z O O r#1396
]]

--[[
    -- Terms of Service
     - Credit me at all times, please: mothra#4150 or https://v3rmillion.net/member.php?action=profile&uid=2988.
     - Don't sell this script.
     - Don't steal credit for this script.
     - Don't remove his and me credit in script.
]]

task.spawn(function()
    task.wait(.5)
    if AntiDisplayNamev6_Connections then
        table.foreach(AntiDisplayNamev6_Connections, function(_, v)
            if typeof(v) == 'RBXScriptConnection' and v.Connected then
                v:Disconnect()
                
                table.remove(AntiDisplayNamev6_Connections, _)
            end
        end)
    else
        getgenv().AntiDisplayNamev6_Connections = {}
    end

    if not game:IsLoaded() or not game:GetService('Players')['LocalPlayer'] then
        game['Loaded']:Wait();
        game:WaitForChild(game:GetService('Players'));
        game:GetService('Players'):WaitForChild(game:GetService('Players').LocalPlayer.Name)
    end

    local LP, Players, ValidStatuses, PlayerInfoPrefetch = game:GetService('Players').LocalPlayer, game:GetService('Players'), {Enum.FriendStatus.NotFriend, Enum.FriendStatus.Friend}, {
        Friend = {Image = 'rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/App/ImageSet/ImageAtlas/img_set_1x_2.png', Offset = '486, 213'},
        Blocked = {Image = 'rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/App/ImageSet/ImageAtlas/img_set_1x_2.png', Offset = '194, 485'},
        Premium = {Image = 'rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/App/ImageSet/ImageAtlas/img_set_1x_2.png', Offset = '243, 485'},
        Developer = {Image = 'rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/App/ImageSet/ImageAtlas/img_set_1x_2.png', Offset = '486, 245'}
    }

    local RandomGamertags = {'Wholesome', 'Soul', 'Alley Frog I', 'Mbira', 'Bug Fire', 'ItsMeWhoKildU 7', 'Mad Irishman 5', 'Mini Mouse', 'Sentinel Torrential Cobra', 'Sgt. PurpleBunnySlippers', 'MeetWit', 'Smash D Trash 4', 'Buried Alive by Love', 'Harry Dotter IV', 'Tacklebox I', 'Tacklebox II', 'InstantxxPot', 'FenderBoyXXX', 'Mr. SpitFire', 'Monster Mania 9', 'The Mustard Cat', 'The Nickname Master', 'Duke RainbowPickle 69', 'DrGregHouse', 'Bonzai', 'CobraBite', 'Jack The Ripper', 'ExoticAlpha', 'I Play Farm Heroes', 'AssasinFaceOff', 'King SNSD4LYFE', 'Sentinel Punchy Punch', 'Sir GunplaGranny 69', 'Wolverine', 'MightyFellow 8', 'Titanium', 'WWF vs WCW', 'Sgt. Chill Dude', 'XUndertakerX', 'SixStringJim VII', 'Inferno', 'LittleTickle IV', 'Centurion Sherman', 'Broomspun Zero', 'UCantBeatIt', 'Monkey Lover', 'CobraBite', 'Pistol Hydro', 'Lord BadassStickBug Zero', 'Chupa alma', 'Alpha', 'xX Alpha', 'Paladin Impulsive Flower', 'Feral Mayhem 7', 'Sentinel Red Combat', 'Snake Eyes', 'Scary Pumpkin', 'Widow Curio', 'Global meltdown I', 'General HORSE LORD', 'Cool Whip 555', 'Prometheus', 'Station WMD', 'Bearded Angler', 'TecTonic', 'Fury', 'VampireHunter', 'TickleMeElmo', 'Thrasher', 'ScaryNinja', 'Unholy', 'Mr Sentai V', 'david.baszucki', 'Sandbox', 'Master Lowercase Guy', 'NightmareOcelot', 'Lowercase Guy', 'Mental 7', 'Sgt. MonkeyKing', 'TWitMeet', 'Torrential Cobra VI', 'Voluntary', 'General The Happy Jock', 'Collaterol Damage', 'LordOfFraud', 'Iced Tea Bandit', 'Yellow Menace', 'ElactixNova', 'Mr. TubbyCandyHoarder', 'Celtic Charger', 'looking4dave', 'Sir Spectral Werewolf', 'Rocky Highway', 'Smash D Trash 8', 'Natural Gold', 'Lord Of Fraud', 'EvilDevil', 'Kevlar', 'Goofyfoot', 'Digital Goddess', 'FifthHarmony'}

    local function Validate(Instance)
        if typeof(Instance) == 'Instance' and (Instance and Instance.Parent) then
            return true
        end
        
        return false
    end

    local function IsApplicable(Character)
        if typeof(Character) == 'Instance' and Character:IsA('Model') and Character:FindFirstChildWhichIsA('Humanoid') then
            return true
        end
        
        return false
    end

    local function Check(Preferences, Setting)
        if Setting and Preferences[Setting] then
            return Preferences[Setting]
        end
        
        return false
    end

    local function PlayerFromUserId(Id)
        if type(Id) == 'number' then
            for _, v in next, Players:GetPlayers() do
                if tostring(v.UserId) == tostring(Id) then
                    return v
                end
            end
        end
    end

   local function FindChildByOrder(parent, tbl, returnInstance)
        local Current, Result = parent
        if typeof(parent) == 'Instance' and type(tbl) == 'table' and #tbl > 0 then
            for _, v in next, tbl do
                task.spawn(function()
                    if type(v) == 'string' then
                        local Prefetch = pcall(game.FindService, v) or Current:FindFirstChild(v)
                        if Prefetch then
                            Current = Prefetch
                            Result = true
                        else
                            Result = false
                        end
                    end
                end)
            end
            
            if type(returnInstance) == 'boolean' and returnInstance == true then
                if Result == true and Current ~= parent then
                    return Current
                else
                    return nil
                end
            else
                return Result
            end
        end
    end
           
    local function GetUIPlayer(Player, Expect)
        local UI_Players = FindChildByOrder(game:GetService('CoreGui'), {'PlayerList', 'PlayerListMaster', 'OffsetFrame', 'PlayerScrollList', 'SizeOffsetFrame', 'ScrollingFrameContainer', 'ScrollingFrameClippingFrame', 'ScollingFrame', 'OffsetUndoFrame'}, true)
        if UI_Players then
            for _, v in next, UI_Players:GetChildren() do
                if v.Name:match('^p_[%d+]') and v.Name:match('%d+') == tostring(Player.UserId) then
                    local UI_Player = FindChildByOrder(v, {'ChildrenFrame', 'NameFrame', 'BGFrame', 'OverlayFrame', 'PlayerName', 'PlayerName'}, true)
                    
                    if UI_Player then
                        if type(Expect) == 'string' and Expect == 'First' and UI_Player.Parent and UI_Player.Parent.Parent then
                            return UI_Player.Parent.Parent
                        elseif type(Expect) == 'string' and Expect == 'Second' then
                            return UI_Player
                        end
                    end
                end
            end
        end
    end

    local function GetPlayerInfo(Player)
        local Overlay = GetUIPlayer(Player, 'First')
        
        if Overlay and Overlay:FindFirstChild('PlayerIcon') then
            local Icon = Overlay:FindFirstChild('PlayerIcon')
            
            if Player:GetFriendStatus(LP) == Enum.FriendStatus.Friend or (tostring(Icon.Image) == PlayerInfoPrefetch.Friend.Image and tostring(Icon.ImageRectOffset) == PlayerInfoPrefetch.Friend.Offset) then
                return 'IsFriend'
            elseif tostring(Icon.Image) == PlayerInfoPrefetch.Blocked.Image and tostring(Icon.ImageRectOffset) == PlayerInfoPrefetch.Blocked.Offset then
                return 'IsBlocked'
            elseif tostring(Icon.Image) == PlayerInfoPrefetch.Premium.Image and tostring(Icon.ImageRectOffset) == PlayerInfoPrefetch.Premium.Offset then
                return 'IsPremium'
            elseif tostring(Icon.Image) == PlayerInfoPrefetch.Developer.Image and tostring(Icon.ImageRectOffset) == PlayerInfoPrefetch.Developer.Offset then
                return 'IsDeveloper'
            end
        end 
    end

    local function UpdateLeaderboardName(Player, NewName)
        local UI_Player, Status = GetUIPlayer(Player, 'Second'), GetPlayerInfo(Player)
        
        if UI_Player then
            UI_Player.RichText = true
            
            if Status then
                if Status == 'IsFriend' and Check(Preferences, 'IdentifyFriends').Toggle == true then
                    UI_Player.Text = '<font color="#00FF1E">'..NewName..'</font>'
                elseif Check(Preferences, 'IdentifyFriends').Toggle == false then
                    UI_Player.Text = NewName
                end
                
                if Status == 'IsBlocked' and Check(Preferences, 'IdentifyBlocked').Toggle == true then
                    UI_Player.Text = '<font color="#FF0000">'..NewName..'</font>'
                elseif Check(Preferences, 'IdentifyBlocked').Toggle == false then
                    UI_Player.Text = NewName
                end

                if Status == 'IsDeveloper' and Check(Preferences, 'IdentifyDeveloper').Toggle == true then
                    UI_Player.Text = '<font color="#FFEA00">'..NewName..'</font>'
                elseif Check(Preferences, 'IdentifyDeveloper').Toggle == false then
                    UI_Player.Text = NewName
                end
                
                if Status == 'IsPremium' and Check(Preferences, 'IdentifyPremium').Toggle == true then
                    UI_Player.Text = '<font color="#00FFFB">'..NewName..'</font>'
                elseif Check(Preferences, 'IdentifyPremium').Toggle == false then
                    UI_Player.Text = NewName
                end
            else
                UI_Player.Text = NewName
            end
        end
    end

    local function AppendCharacterName(Character, NewName)
        if (Validate(Character) and IsApplicable(Character)) then
            Character:FindFirstChildWhichIsA('Humanoid').DisplayName = tostring(NewName)
        end
    end

    local function UpdateName(Player, Preferences)
        assert(typeof(Player) == 'Instance', 'bad argument #1; Instance expected, got '..tostring(typeof(Player)))
        assert(Player:IsA('Player') == true, 'bad argument #2; Object [Player] expected, got '..tostring(Player.Parent)..'.'..Player.ClassName)
        assert(type(Preferences) == 'table', 'bad argument #3; (Preferences [table] expected, got '..tostring(type(Preferences))..')')
        
        local RetroNaming = Check(Preferences, 'RetroNaming')
        local ShowOriginalName = Check(Preferences, 'ShowOriginalName')
        local ApplyToLeaderboard = Check(Preferences, 'ApplyToLeaderboard')
        local IdentifyFriends = Check(Preferences, 'IdentifyFriends')
        local IdentifyBlocked = Check(Preferences, 'IdentifyBlocked')
        local IdentifyPremium = Check(Preferences, 'IdentifyPremium')
        local IdentifyDeveloper = Check(Preferences, 'IdentifyDeveloper')
        local SpoofLocalPlayer = Check(Preferences, 'SpoofLocalPlayer')
        local Orientation = Check(Preferences, 'Orientation')
        
        if typeof(Player) == 'Instance' and Player:IsA('Player') then
            local Pl, TC = Player, Player.Character
            
        pcall(function()
            if RetroNaming == false then
                if Player ~= LP then
                    if IdentifyFriends.Toggle == true and GetPlayerInfo(Player) == 'IsFriend' then
                        if Orientation == 'Vertical' then
                            if ApplyToLeaderboard == true and Pl.Name ~= Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyFriends.Identifier).. "\n" .."(@"..Pl.Name..")")
                            elseif ApplyToLeaderboard == true and Pl.Name == Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyFriends.Identifier))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end

                            if Pl.Name ~= Pl.DisplayName then
                            	AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyFriends.Identifier).. "\n" .."(@"..Pl.Name..")")
                            else
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyFriends.Identifier))
                            end
                        elseif Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true and Pl.Name ~= Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName.." ".."(@"..Pl.Name..")".. '\n' ..tostring(IdentifyFriends.Identifier))
                            elseif ApplyToLeaderboard == true and Pl.Name == Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyFriends.Identifier))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end

                            if Pl.Name ~= Pl.DisplayName then
                                AppendCharacterName(TC, Pl.DisplayName.." ".."(@"..Pl.Name..")".. ' ' ..tostring(IdentifyFriends.Identifier))
                            else
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyFriends.Identifier))
                            end
                        end
                    elseif IdentifyFriends.Toggle == false then
                        if Orientation == 'Vertical' or Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true then
                                UpdateLeaderboardName(Player, ((ShowOriginalName == true and Pl.DisplayName) or (ShowOriginalName == false and Pl.Name)))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end
                            
                            AppendCharacterName(TC, ((ShowOriginalName == true and Pl.DisplayName) or (ShowOriginalName == false and Pl.Name)))
                        end
                    end
                    
                    if IdentifyBlocked.Toggle == true and GetPlayerInfo(Player) == 'IsBlocked' then
                        if Orientation == 'Vertical' then
                            if ApplyToLeaderboard == true and Pl.Name ~= Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyBlocked.Identifier).. "\n" .."(@"..Pl.Name..")")
                            elseif ApplyToLeaderboard == true and Pl.Name == Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyBlocked.Identifier))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end

                            if Pl.Name ~= Pl.DisplayName then
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyBlocked.Identifier).. "\n" ..("@"..Pl.Name))
                            else
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyBlocked.Identifier))
                            end                       
                        elseif Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true and Pl.Name ~= Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '.."(@"..Pl.Name..")"..'\n'..tostring(IdentifyBlocked.Identifier))
                            elseif ApplyToLeaderboard == true and Pl.Name == Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyBlocked.Identifier))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end
                            
                            if Pl.Name ~= Pl.DisplayName then
                                AppendCharacterName(TC, Pl.DisplayName..' '.."(@"..Pl.Name..")"..' '..tostring(IdentifyBlocked.Identifier))
                            else
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyBlocked.Identifier))
                            end
                        end
                    elseif IdentifyBlocked.Toggle == false then
                        if Orientation == 'Vertical' or Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true then
                                UpdateLeaderboardName(Player, ((ShowOriginalName == true and Pl.DisplayName) or (ShowOriginalName == false and Pl.Name)))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end
                            
                            AppendCharacterName(TC, ((ShowOriginalName == true and Pl.DisplayName) or (ShowOriginalName == false and Pl.Name)))
                        end
                    end
                    
                    if IdentifyPremium.Toggle == true and GetPlayerInfo(Player) == 'IsPremium' then
                        if Orientation == 'Vertical' then
                            if ApplyToLeaderboard == true and Pl.Name ~= Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyPremium.Identifier).."\n".."(@"..Pl.Name..")")
                            elseif ApplyToLeaderboard == true and Pl.Name == Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyPremium.Identifier))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end

                            if Pl.Name ~= Pl.DisplayName then
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyPremium.Identifier).."\n".."(@"..Pl.Name..")")
                            else
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyPremium.Identifier))
                            end
                        elseif Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true and Pl.Name ~= Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '.."(@"..Pl.Name..")"..'\n'..tostring(IdentifyPremium.Identifier))
                            elseif ApplyToLeaderboard == true and Pl.Name == Pl.DisplayName then
                                UpdateLeaderboardName(Player, Player.DisplayName..' '..tostring(IdentifyPremium.Identifier))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end
                            
                            if Pl.Name ~= Pl.DisplayName then
                                AppendCharacterName(TC, Pl.DisplayName..' '.."(@"..Pl.Name..")"..' '..tostring(IdentifyPremium.Identifier))
                            else
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyPremium.Identifier))
                            end
                        end
                    elseif IdentifyPremium.Toggle == false then
                        if Orientation == 'Vertical' or Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true then
                                UpdateLeaderboardName(Player, ((ShowOriginalName == true and Pl.DisplayName) or (ShowOriginalName == false and Pl.Name)))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end
                            
                            AppendCharacterName(TC, ((ShowOriginalName == true and Pl.DisplayName) or (ShowOriginalName == false and Pl.Name)))
                        end
                    end
                    
                    if IdentifyDeveloper.Toggle == true and GetPlayerInfo(Player) == 'IsDeveloper' then
                        if Orientation == 'Vertical' then
                            if ApplyToLeaderboard == true and Pl.Name ~= Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyDeveloper.Identifier).."\n".."(@"..Pl.Name..")")
                            elseif ApplyToLeaderboard == true and Pl.Name == Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyDeveloper.Identifier))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end

                            if Pl.Name ~= Pl.DisplayName then
                            	AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyDeveloper.Identifier).."\n".."(@"..Pl.Name..")")
                            else
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyDeveloper.Identifier))
                            end
                        elseif Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true and Pl.Name ~= Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '.."(@"..Pl.Name..")"..'\n'..tostring(IdentifyDeveloper.Identifier))
                            elseif ApplyToLeaderboard == true and Pl.Name == Pl.DisplayName then
                                UpdateLeaderboardName(Player, Pl.DisplayName..' '..tostring(IdentifyDeveloper.Identifier))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end

                            if Pl.Name ~= Pl.DisplayName then
                                AppendCharacterName(TC, Pl.DisplayName..' '.."(@"..Pl.Name..")"..' '..tostring(IdentifyDeveloper.Identifier))
                            else
                                AppendCharacterName(TC, Pl.DisplayName..' '..tostring(IdentifyDeveloper.Identifier))
                            end
                        end
                    elseif IdentifyDeveloper.Toggle == false then
                        if Orientation == 'Vertical' or Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true then
                                UpdateLeaderboardName(Player, ((ShowOriginalName == true and Pl.DisplayName) or (ShowOriginalName == false and Pl.Name)))
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end
                            
                            AppendCharacterName(TC, ((ShowOriginalName == true and Pl.DisplayName) or (ShowOriginalName == false and Pl.Name)))
                        end
                    end
                    
                    if not GetPlayerInfo(Player) and Player.Name ~= Player.DisplayName then
                        if Orientation == 'Vertical' then
                            if ApplyToLeaderboard == true then
                                UpdateLeaderboardName(Player, Player.DisplayName..'\n'.."(@"..Player.Name..")")
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end
                            
                            AppendCharacterName(TC, Player.DisplayName..'\n'.."(@"..Player.Name..")")
                        elseif Orientation == 'Horizontal' then
                            if ApplyToLeaderboard == true then
                                UpdateLeaderboardName(Player, Player.DisplayName..' '..'(@'..Player.Name..')')
                            else
                                UpdateLeaderboardName(Player, Player.DisplayName)
                            end
                            
                            AppendCharacterName(TC, Player.DisplayName..' '..'(@'..Player.Name..')')
                        end
                    elseif not GetPlayerInfo(Player) and Player.Name == Player.DisplayName then
                        if ApplyToLeaderboard == true then
                            UpdateLeaderboardName(Player, ''..Player.Name)
                        else
                            UpdateLeaderboardName(Player, Player.DisplayName)
                        end
                        
                        AppendCharacterName(TC, ''..Player.Name)
                    end
                elseif Player == LP then
                    if SpoofLocalPlayer.Toggle == true then
                        if SpoofLocalPlayer.UseRandomName == true then
                            UpdateLeaderboardName(LP, tostring(RandomGamertags[math.random(1, #RandomGamertags)]))
                        elseif SpoofLocalPlayer.UseRandomName == false then
                            UpdateLeaderboardName(LP, tostring(SpoofLocalPlayer.NewName))
                        end
                    else
                        UpdateLeaderboardName(Player, Player.DisplayName)
                    end
                end
            elseif RetroNaming == true then
                UpdateLeaderboardName(Player, Player.Name)
                AppendCharacterName(TC, Player.Name)
            end
        end)
    end
end
        

    local UI_Players = FindChildByOrder(game:GetService('CoreGui'), {'PlayerList', 'PlayerListMaster', 'OffsetFrame', 'PlayerScrollList', 'SizeOffsetFrame', 'ScrollingFrameContainer', 'ScrollingFrameClippingFrame', 'ScollingFrame', 'OffsetUndoFrame'}, true)
    if UI_Players then
        local ChildAdded = UI_Players.ChildAdded:Connect(function(Path)
            local TP = PlayerFromUserId(0 + Path.Name:gsub('p_', ''))
            task.wait()
            UpdateName(TP, Preferences)
        end)
    end
                        
                

    local PlayerAdded = Players.PlayerAdded:Connect(function(Player)
        task.wait(.2)
        UpdateName(Player, Preferences)
        local CharacterAdded = Player.CharacterAdded:Connect(function()
            task.wait(.2)
            UpdateName(Player, Preferences)
        end)
        
        table.insert(AntiDisplayNamev6_Connections, CharacterAdded)
    end)

    local FriendStatusChanged = LP.FriendStatusChanged:Connect(function(Player, Status)
        if table.find(ValidStatuses, Status) then
            task.wait(.2)
            UpdateName(Player, Preferences)
        end
    end)

    local PlayerBlocked = game:GetService('StarterGui'):GetCore('PlayerBlockedEvent').Event:Connect(function(Player)
        task.wait(.2)
        UpdateName(Player, Preferences)
    end)

    local PlayerUnblocked = game:GetService('StarterGui'):GetCore('PlayerUnblockedEvent').Event:Connect(function(Player)
        task.wait(.2)
        UpdateName(Player, Preferences)
    end)

    table.insert(AntiDisplayNamev6_Connections, ChildAdded)
    table.insert(AntiDisplayNamev6_Connections, PlayerAdded)
    table.insert(AntiDisplayNamev6_Connections, FriendStatusChanged)
    table.insert(AntiDisplayNamev6_Connections, PlayerBlocked)
    table.insert(AntiDisplayNamev6_Connections, PlayerUnblocked)

    for _, Player in next, Players:GetPlayers() do
        task.spawn(function()
            task.wait(.2)
            UpdateName(Player, Preferences)
                if Player ~= LP then
                    local CharacterAdded = Player.CharacterAdded:Connect(function()
                        task.wait(.2)
                        UpdateName(Player, Preferences)
                    end)
                table.insert(AntiDisplayNamev6_Connections, CharacterAdded)
                end
            end)
        end
    end)
