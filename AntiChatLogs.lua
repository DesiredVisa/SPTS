local LP = game:GetService('Players').LocalPlayer
local PlayerScripts = LP ~= nil and LP:FindFirstChild('PlayerScripts') or nil
local ChatScript = PlayerScripts ~= nil and PlayerScripts:FindFirstChild('ChatScript') or nil
local ChatMain = ChatScript ~= nil and ChatScript:FindFirstChild('ChatMain') or nil

if LP and ChatMain ~= nil then
 local Old, Chatted, OldChatted = nil, Instance.new('BindableEvent'), LP.Chatted; Chatted.Name = LP.Name..'_Chatted_Event'
 Old = hookmetamethod(game, '__index', newcclosure(function(self, Index)
       if checkcaller() and self == LP and Index == 'Chatted' then
         return Chatted.Event
      elseif not checkcaller() and self == LP and Index == 'Chatted' then
        return OldChatted
       end

       return Old(self, Index)
 end))

local Old2, MessagePosted = nil, require(ChatMain).MessagePosted
if MessagePosted then
    Old2 = hookfunction(MessagePosted.fire, function(self, ...)
        if not checkcaller() then
            return Chatted:Fire(...)
        end
    end)
end
end