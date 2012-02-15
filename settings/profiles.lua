local D, S, E = unpack(select(2, ...))

--if D.Player.name == "Darkend" or D.Player.name == "Lightend" then
	S.tracker.enable = true
--end

if D.Player.name == "Youhan" then
	S.selfbuffs.enable = false
end

	--S.slackcheck.enable = false