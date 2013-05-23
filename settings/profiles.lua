local D, S, E = unpack(select(2, ...))

S.unitframes.enable = false

if D.Player.name == "Sugimoto" then
	S.unitframes.layout = "healer"
end

if D.Player.name == "Ikeya" then
	S.unitframes.enable = false
	S.tracker.enable = false
end

if D.Player.name == "Söphie" then
	S.actionbars.enable = false
end

if D.Player.name == "Lightend" then
	
	
end


S.tracker.enable = false