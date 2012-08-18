local D, S, E = unpack(select(2, ...))

local ctor = {}
D.UnitFrames.Constructor = ctor

ctor.LayoutSegments = function(parent, partWidth, segments)

	--Hack:
	--What i would like to do is to anchor each frame to the previous, anchor 1 to parent left, and N to parent right.
	--But you dont seem to be able to do that :(
	local spacing = 4
	local totalSpacing = (#segments - 1) * spacing 

	local segmentHeight = 8
	local segmentWidth = (partWidth  - totalSpacing) / #segments
	
	-- note we dont attach the first one to anything
	for i = 1, #segments do
		
		segments[i]:SetHeight(segmentHeight)
		segments[i]:SetWidth(segmentWidth)
		
		if i > 1 then
			segments[i]:SetPoint("LEFT", segments[i-1], "RIGHT", spacing, 0)
		end
		
	end
	
end

ctor.CreateSegments = function(parent, partWidth, number)

	local segments = {}
	
	for i = 1, number do
	
		segments[i] = CreateFrame("Frame", nil, parent)

		D.CreateBackground(segments[i])
		D.CreateShadow(segments[i])
	
		segments[i].bg:SetBackdropColor(0.65, 0.63, 0.35, 0.6)
	
	end
	
	ctor.LayoutSegments(parent, partWidth, segments)
	
	return segments
	
end