local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

D.Tracker.CreateDisplay("Line", "Main", 
{
	["location"] = {"CENTER", UIParent, "CENTER", 0, -200},
	["size"] = {500, 32},
	["maxtime"] = 60,
})