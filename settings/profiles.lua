local D, S, E = unpack(select(2, ...))

if D.Player.name == "Darkend" then
	S.unitframes.layout = "hybrid"
end

if D.Player.name == "Lightend" then
	S.unitframes.layout = "healer"
end

if D.Player.name == "Sugimoto" then
	S.unitframes.layout = "hybrid"
end


--S.slackcheck.enable = false