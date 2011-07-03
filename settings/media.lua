local D, S, E = unpack(select(2, ...))

S["textures"] = {
	["shadow"] = [[Interface\AddOns\Darkui\media\textures\glowTex]],
	["normal"] = [[Interface\AddOns\Darkui\media\textures\normTex]],
	["blank"] = [[Interface\AddOns\Darkui\media\textures\blank]],
	["raidicons"] = [[Interface\AddOns\Darkui\media\textures\raidicons.blp]],
	["buttonhover"] = [[Interface\AddOns\Darkui\medias\textures\button_hover]],
}

S["fonts"] = {
	["unitframe"] = [[Interface\AddOns\Darkui\media\fonts\BigNoodleTitling.ttf]],
	["normal"] = [[Interface\AddOns\Darkui\media\fonts\PT-Sans-Narrow.ttf]],
	["combat"] = [[Interface\AddOns\Darkui\media\fonts\Ultima_Campagnoli.ttf]],
	["default"] = {
		["size"] = 12,
		["style"] = "",
	},
}

S["sounds"] = {
	["warning"] = [[Interface\AddOns\Darkui\media\sounds\warning.mp3]],
	["whisper"] = [[Interface\AddOns\Darkui\media\sounds\whisper.mp3]],
}