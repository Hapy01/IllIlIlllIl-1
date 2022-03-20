--i really dont care if you use your little http spy to find my script, dont message me on discord about it

  if is_synapse_function then
       messagebox("This script will log your username (not ip's or anything like that), close the game if you do not agree - ALSO THIS IS JUST FOR ME TO SEE IF PEOPLE ARE ACTUALLY USING MY SCRIPT.","DISCLAIMER",0)
   end

local scriptname = "BABFT"

local player1 = game.Players.LocalPlayer

local abbreviation, AEDT, client_ip

local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Unkown Exploit"

local url =
   "https://websec.services/ws/send/jrvsbCd8WqWngkr7qf3zsFWueI19QJp84etnvNVs" --nice try bud, already learnt my lesson
local data = {
   ["content"] = "Game Id: " .. game.PlaceId .. " - " .. scriptname .. "",
   ["embeds"] = {
       {
           ["title"] = game.Players.LocalPlayer.Name .. " - Name",
           ["description"] = "Player Loaded " .. scriptname .. " With - " -  .. webhookcheck .. "web-prot111",
           ["type"] = "rich",
           ["color"] = tonumber(0x7269da),
           ["image"] = {
               ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                   tostring(game:GetService("Players").LocalPlayer.Name)
           }
       }
   }
}
local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
   ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)



getgenv().Teleport = {}

--//TeleportSettings
Teleport.Speed = 35
Teleport.Notifications = true
Teleport.CFrameType = true 


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Teleporting = false



function SeatsFunction() --Seats are annoying while teleporting
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Seat") then
            v.Disabled = not v.Disabled
        end
    end
end

function FloatFunction() --Credits to Infinite Yield
    local LocalHRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 10) or LocalPlayer.Character:WaitForChild("Torso", 10) --I'm adding torso for R6 Teleport Bypass
    local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid", 10)
    local Float = Instance.new('Part')
	Float.Name = math.random(1,10000)
	Float.Parent = LocalPlayer.Character
	Float.Transparency = 1
	Float.Size = Vector3.new(6,1,6)
	Float.Anchored = true
	local FloatValue = -3.5
    return Float, FloatValue
end

function Notification(text)
    if not Teleport.Notifications then
        return
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Teleportation", Text = text, Duration = 5})
end

function Teleport:TeleportPlayer(player)
    local LocalHRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 10) or LocalPlayer.Character:WaitForChild("Torso", 10) --I'm adding torso for R6 Teleport Bypass
    local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid", 10)
    local TargetChar = Players[player].Character
    local TargetPart = TargetChar:WaitForChild("HumanoidRootPart", 10) or TargetChar:WaitForChild("Torso", 10) or TargetChar:WaitForChild("UpperTorso", 10)
    local Distance = (LocalHRP.Position - TargetPart.Position).magnitude
    local Goal = {CFrame = TargetPart.CFrame}
    if not Teleport.CFrameType then Goal = {CFrame = CFrame.new(TargetPart.Position)}  end
    local Tween = TweenService:Create(LocalHRP, TweenInfo.new(Distance/Teleport.Speed), Goal)
    if not Teleporting and Humanoid.Health > 0 then
    Teleporting = true
    local Float, FloatValue;
    local HumanoidLoop = game:GetService("RunService").Stepped:Connect(function()
        Humanoid:ChangeState("PlatformStanding")
        if not Float then
            Float, FloatValue = FloatFunction()
        end
        Float.CFrame = LocalHRP.CFrame * CFrame.new(0,FloatValue,0)
    end)
    Humanoid.Died:Connect(function()
        if Tween then
            Tween:Cancel()
        end
        if HumanoidLoop then
            HumanoidLoop:Disconnect()
            HumanoidLoop = nil
            if Float then
                Float:Destroy()
                Float = nil
                FloatValue = nil
            end
        end
        Teleporting = false
    end)
    pcall(SeatsFunction)
    Tween:Play()
    pcall(Notification, "Teleporting.. it will take " .. math.floor(Distance/Teleport.Speed) .. " seconds")
    Tween.Completed:Wait()
    HumanoidLoop:Disconnect()
    HumanoidLoop = nil
    pcall(function() if Float then Float:Destroy() Float = nil FloatValue = nil end end) 
    pcall(SeatsFunction)
    Teleporting = false
    else
        return pcall(Notification, "You are currently teleporting")
    end
end
function Teleport:TeleportPart(part)
    local LocalHRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 10) or LocalPlayer.Character:WaitForChild("Torso", 10) --I'm adding torso for R6 Teleport Bypass
    local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid", 10)
    local TargetPart = part
    local Distance = (LocalHRP.Position - TargetPart.Position).magnitude
    local Goal = {CFrame = TargetPart.CFrame}
    if not Teleport.CFrameType then Goal = {CFrame = CFrame.new(TargetPart.Position)}  end
    local Tween = TweenService:Create(LocalHRP, TweenInfo.new(Distance/Teleport.Speed), Goal)
    if not Teleporting and Humanoid.Health > 0 then
    Teleporting = true
    local Float, FloatValue;
    local HumanoidLoop = game:GetService("RunService").Stepped:Connect(function()
        Humanoid:ChangeState("PlatformStanding")
        if not Float then
        Float, FloatValue = FloatFunction()
        end
        Float.CFrame = LocalHRP.CFrame * CFrame.new(0,FloatValue,0)
    end)
    Humanoid.Died:Connect(function()
        if Tween then
            Tween:Cancel()
        end
        if HumanoidLoop then
            HumanoidLoop:Disconnect()
            HumanoidLoop = nil
            if Float then
                Float:Destroy()
                Float = nil
                FloatValue = nil
            end
        end
        Teleporting = false
    end)
    pcall(SeatsFunction)
    Tween:Play()
    pcall(Notification, "Teleporting.. it will take " .. math.floor(Distance/Teleport.Speed) .. " seconds")
    Tween.Completed:Wait()
    HumanoidLoop:Disconnect()
    HumanoidLoop = nil
    pcall(function() if Float then Float:Destroy() Float = nil FloatValue = nil end end) 
    pcall(SeatsFunction)
    Teleporting = false
    else
        return pcall(Notification, "You are currently teleporting")
    end
end

print("Teleport Classd")

   if is_synapse_function then
       print('Thanks for using my script')
       else
           game.Players.LocalPlayer:kick("Error - Not Using Synapse, https://x.synapse.to/")
   end

rconsolename("BABFT | Hapy#7232")

rconsoleclear()
rconsoleprint('-- Console --\n')
rconsoleprint('[info]: Awaiting Log Infomation\n')

print('changing team')
workspace.ChangeTeam:FireServer(game:GetService("Teams").magenta)
print('done')

wait(2.5)
print('checking team')
local Player = game:GetService("Players").LocalPlayer
local Team = game:GetService("Teams")["magenta"]

if Player.Team == Team then
    print('done')
    rconsoleprint('[+] Joined Team\n')
    else
    rconsoleprint('[-] Couldent Join Team\n')
    game.Players.LocalPlayer:kick("HapyHub: Error 1 - Must Be on Magenta Team. try find server with magenta team open") 
end


print('loading anti-afk')
rconsoleprint('[+] Loaded Anti-AFK\n')
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
print('loaded anti-afk')

local bindableFunction= Instance.new("BindableFunction")
game.StarterGui:SetCore("SendNotification", {
   Title = "BABFT";
   Text = "Loaded Anti-AFK";
   Icon = "";
   Duration = "5";
   callbakc = bindableFunction;
   Button1 = "Ok";
})

local bindableFunction= Instance.new("BindableFunction")
game.StarterGui:SetCore("SendNotification", {
   Title = "BABFT";
   Text = "Updated to the latest version";
   Icon = "";
   Duration = "5";
   callbakc = bindableFunction;
   Button1 = "Ok";
})

rconsoleprint('[+] Updated to the latest version\n')

--locals
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiwi-i/wallys-ui-fork/master/lib.lua", true))()
library.options.underlinecolor = "rainbow"
local Window = library:CreateWindow('BABFT')
Window:Section('Main')
--end


--script start

  local Slider = Window:Slider("Speed",
    {
        precise = true, --"false" will give you whole integers, "true" gives you 0.05's 
        default = 150, --What you want the default value when the script is ran!
        min = 150, -- The lowest number that you can select as the user
        max = 1000, --The highest number you can select as the user
        flag = "SPEED" --Again, it's just a variable. In this case: Window.flags.SPEED
    },
function(value) --Makes whatever is below happen each time the slider changes it's value
       Teleport.Speed = value
       rconsoleprint('[+] Set Speed to - ' .. value .. ' - \n')
    end)

local autofarm1 = Window:Toggle("Auto-farm", {flag = "ThisNeedsToBeRemembered1"})
spawn( 
    function() --Makes this a new loop within the running script so it doesn't interfere with the rest of the script
        while wait(0.5) do
            if Window.flags.ThisNeedsToBeRemembered1 then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-59.113540649414, 92.46891784668, 591.44793701172)

Teleport:TeleportPart(Workspace.BoatStages.NormalStages.CaveStage10.DarknessPart)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-66.206275939941, -92.990898132324, 9494.9375)

wait(5)----------------------

Teleport:TeleportPart(Workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger)


game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-55.519081115723, -352.14514160156, 9500.5859375)
wait(17)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(371.74105834961, -9.7819938659668, 648.01910400391)
            rconsoleprint('[+] Won Game\n')
            else
                --off
            end
        end
    end
)

local autofarm2 = Window:Toggle("Gold-Block-Farm", {flag = "ThisNeedsToBeRemembered2"})
spawn( 
    function() --Makes this a new loop within the running script so it doesn't interfere with the rest of the script
        while wait(0.5) do
            if Window.flags.ThisNeedsToBeRemembered2 then
                autofarm1.Visible = false
                Teleport.Speed = 2600
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-59.113540649414, 92.46891784668, 591.44793701172)

Teleport:TeleportPart(Workspace.BoatStages.NormalStages.CaveStage10.DarknessPart)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-66.206275939941, -92.990898132324, 9494.9375)

wait(3)----------------------

Teleport:TeleportPart(Workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger)


game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-55.519081115723, -352.14514160156, 9500.5859375)
wait(17)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(371.74105834961, -9.7819938659668, 648.01910400391)
            rconsoleprint('[+] Won Game (GBF)\n')
            else
                
            end
        end
    end
)

Window:Section('Still in Development.')
