local D, S, E = unpack(select(2, ...))

_G.CHAT_BATTLEGROUND_GET = "|Hchannel:Battleground|h[BG]|h %s:\32"
_G.CHAT_BATTLEGROUND_LEADER_GET = "|Hchannel:Battleground|h[BG]|h %s:\32"
_G.CHAT_BN_WHISPER_GET = "From %s:\32"
_G.CHAT_GUILD_GET = "|Hchannel:Guild|h[G]|h %s:\32"
_G.CHAT_OFFICER_GET = "|Hchannel:o|h[O]|h %s:\32"
_G.CHAT_PARTY_GET = "|Hchannel:Party|h[P]|h %s:\32"
_G.CHAT_PARTY_GUIDE_GET = "|Hchannel:party|h[PL]|h %s:\32"
_G.CHAT_PARTY_LEADER_GET = "|Hchannel:party|h[PL]|h %s:\32"
_G.CHAT_RAID_GET = "|Hchannel:raid|h[R]|h %s:\32"
_G.CHAT_RAID_LEADER_GET = "|Hchannel:raid|h[RL]|h %s:\32"
_G.CHAT_RAID_WARNING_GET = "[RW] %s:\32"
_G.CHAT_SAY_GET = "%s:\32"
_G.CHAT_WHISPER_GET = "From %s:\32"
_G.CHAT_YELL_GET = "%s:\32"
 
_G.CHAT_FLAG_AFK = "|cffFF0000[AFK]|r "
_G.CHAT_FLAG_DND = "|cffE7E716[DND]|r "
_G.CHAT_FLAG_GM = "|cff4154F5[GM]|r "
 
_G.ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h is now |cff298F00online|r!"
_G.ERR_FRIEND_OFFLINE_S = "%s is now |cffff0000offline|r!"


local originals = {}

local function DarkAddMessage(frame, text, ...)
  if not text then
    return
  end
  
  return originals[frame](frame, text, ...)
  
end


for i = 1, NUM_CHAT_WINDOWS do

	local frame = _G[format("ChatFrame%s", i)]
	
	if frame ~= COMBATLOG then
		originals[frame] = frame.AddMessage
		frame.AddMessage = DarkAddMessage
	end
end
      
      