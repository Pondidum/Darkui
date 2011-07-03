local D, S, E = unpack(select(2, ...))

if D.Player.name == "Tilgi" then
	S.unitframes.layout = "healer"
end

if D.Player.name == "Youhan" then
	S.selfbuffs.enable = false
end