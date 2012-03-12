local D, S, E = unpack(select(2, ...))

if S.tracker.enable ~= true then return end

for name, content in pairs(S.tracker.displays) do
	D.Tracker.CreateDisplay(content.type, name, content.setup)	
end
