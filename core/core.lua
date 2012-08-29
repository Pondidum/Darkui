-- including system
local addon, engine = ...
engine[1] = {} -- D, functions, constants, variables
engine[2] = {} -- S, Settings
engine[3] = {} -- E, Events

DarkUI = engine -- Allow other addons to use Engine

local frame = CreateFrame("Frame", "DarkuiFrame", UIParent) --used for the events and layout
frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -20)
frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -20, 20)

engine[1].Frame = frame
---------------------------------------------------------------------------------
--	This should be at the top of every file inside of the Addon:	
--	local D, S = unpack(select(2, ...))

--	This is how another addon imports the Addon engine:	
--	local D, S = unpack(DarkUI)
---------------------------------------------------------------------------------
