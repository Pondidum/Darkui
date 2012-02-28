local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

D.Tracker.CreateDisplay("Line", "Main", 
{
	["location"] = {"CENTER", UIParent, "CENTER", 0, -200},
	["size"] = {500, 32},
	["maxtime"] = 60,
	["readyalpha"] = 1,
	["combatalpha"] = 0.3,
	["outofcombatalpha"] = 0.1,
})

D.Tracker.CreateDisplay("Stack", "CooldownCenter",
{
	["location"] = {"CENTER", UIParent, "CENTER", 0, -100},
	["size"] = {32, 32},
	["state"] = "COMBATFADE",
	["readyalpha"] = 1,
	["combatalpha"] = 0.3,
	["outofcombatalpha"] = 0.1,
})

D.Tracker.CreateDisplay("Stack", "CooldownCenterLeft",
{
	["location"] = {"CENTER", UIParent, "CENTER", -50, -100},
	["size"] = {32, 32},
	["state"] = "COMBATFADE",
	["readyalpha"] = 1,
	["combatalpha"] = 0.3,
	["outofcombatalpha"] = 0.1,
})

D.Tracker.CreateDisplay("Stack", "CooldownCenterRight",
{
	["location"] = {"CENTER", UIParent, "CENTER", 50, -100},
	["size"] = {32, 32},
	["state"] = "COMBATFADE",
	["readyalpha"] = 1,
	["combatalpha"] = 0.3,
	["outofcombatalpha"] = 0.1,
})

D.Tracker.CreateDisplay("Stack", "CooldownLeft",
{
	["location"] = {"CENTER", UIParent, "CENTER", -100, -100},
	["size"] = {32, 32},
	["state"] = "COMBATFADE",
	["readyalpha"] = 1,
	["combatalpha"] = 0.3,
	["outofcombatalpha"] = 0.1,
})

D.Tracker.CreateDisplay("Stack", "CooldownRight",
{
	["location"] = {"CENTER", UIParent, "CENTER", 100, -100},
	["size"] = {32, 32},
	["state"] = "COMBATFADE",
	["readyalpha"] = 1,
	["combatalpha"] = 0.3,
	["outofcombatalpha"] = 0.1,
})
