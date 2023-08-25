local minCheckpoint = 1
local maxCheckpoint = 61
local secondsBetweenTps = 0.1
local rebirthRemote = game:GetService("ReplicatedStorage").Remotes.Rebirth
local Rebirths = game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value

function teleportToCheckpoint(checkpointNumber)
    local checkpointName = tostring(checkpointNumber)
    local checkpoint = game.Workspace.Checkpoints:FindFirstChild(checkpointName)

    if checkpoint then
        local character = game.Players.LocalPlayer.Character
        local partCFrame = checkpoint.CFrame
        local newPosition = partCFrame.Position + Vector3.new(0, 1, 0)
        character:SetPrimaryPartCFrame(CFrame.new(newPosition))
        print("[AutoFarm]: Checkpoint " .. checkpointName .. " Teleported!")
    else
        print("[AutoFarm]: Checkpoint " .. checkpointName .. " Not Found!")
    end
end

while true do
    for i = minCheckpoint, maxCheckpoint do
        teleportToCheckpoint(i)
        wait(secondsBetweenTps)
    end
    rebirthRemote:FireServer()
    print("[AutoFarm]: Rebirthed! Current Rebirths: "..Rebirths)
    queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/Nexiss5/Scripts/main/AutoFarm.lua"))()')
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    wait(1)
end
