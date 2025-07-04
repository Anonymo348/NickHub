
-- NickHub UI by Nick (Offuscato)
local a=game:GetService("UserInputService")
local b=game:GetService("RunService")
local c=game:GetService("Players")
local p=c.LocalPlayer
local h=p.Character or p.CharacterAdded:Wait()
local hum=h:WaitForChild("Humanoid")
local r=h:WaitForChild("HumanoidRootPart")

local f,e,i,s,j,g,d,u,v,w,z,t={},false,50,nil,false,false,false,false,false,false

f.start=function()
    if e then return end
    e=true
    hum.PlatformStand=true
    d=b.Heartbeat:Connect(function()
        local cf=workspace.CurrentCamera.CFrame
        local dir=Vector3.new()
        if a:IsKeyDown(Enum.KeyCode.W) then dir=dir+cf.LookVector end
        if a:IsKeyDown(Enum.KeyCode.S) then dir=dir-cf.LookVector end
        if a:IsKeyDown(Enum.KeyCode.A) then dir=dir-cf.RightVector end
        if a:IsKeyDown(Enum.KeyCode.D) then dir=dir+cf.RightVector end
        if a:IsKeyDown(Enum.KeyCode.Space) then dir=dir+Vector3.new(0,1,0) end
        if a:IsKeyDown(Enum.KeyCode.LeftControl) then dir=dir-Vector3.new(0,1,0) end
        if dir.Magnitude>0 then
            r.Velocity=dir.Unit*s
        else
            r.Velocity=Vector3.new()
        end
    end)
end

f.stop=function()
    if not e then return end
    e=false
    hum.PlatformStand=false
    r.Velocity=Vector3.new()
    if d then d:Disconnect() end
end

a.InputBegan:Connect(function(inp,gp)
    if gp then return end
    if inp.KeyCode==Enum.KeyCode.F then
        if e then f.stop() else f.start() end
    end
end)

print("NickHub Loaded (Fly toggle with F)")
