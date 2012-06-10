local D, S, E = unpack(select(2, ...))

D.LayoutEngine = {}

local L = D.LayoutEngine

L.Engines = {
	["HORIZONTAL"] = function(self) 
		
		local x = self.MarginLeft
		local y = self.MarginTop
		local currentRowHeight = 0
		
		for i = 1, #self.frames do
			
			local current = self.frames[i]
			
			if self.Wrap and x + current:GetWidth() > self:GetWidth() then
				x = self.MarginLeft
				y = y + currentRowHeight + self.MarginTop
				currentRowHeight = current:GetHeight()
			end
			
			current:SetPoint(self.Origin, self, self.Origin, x, -y)
			
			x = x + current:GetWidth() + self.MarginRight
			
			if current:GetHeight() > currentRowHeight then
				currentRowHeight = current:GetHeight()
			end
			
		end
		
	end,
	["VERTICAL"] = function(self) 
		
		local x = self.MarginLeft
		local y = self.MarginTop
		local currentColWidth = 0
		
		for i = 1, #self.frames do
			
			local current = self.frames[i]
			
			if self.Wrap and y + current:GetHeight() > self:GetHeight() then
				y = self.MarginTop
				x = x + currentColWidth + self.MarginLeft
				currentColWidth = currentColWidth:GetWidth()
			end
			
			current:SetPoint(self.Origin, self, self.Origin, x, y)
			
			y = y + current:GetHeight() + self.MarginBottom
			
			if current:GetWidth() > currentColWidth then
				currentColWidth = current:GetWidth()
			end
			
		end
		
	end,
}

L.Init = function(self, other)
	
	other.Origin = "TOPLEFT" 
	other.Direction = "HORIZONTAL"
	other.Wrap = false
	
	other.DefaultSize = {32, 32}
	other.MarginLeft = 4
	other.MarginRight = 4
	other.MarginTop = 4
	other.MarginBottom = 4
	
	other.frames = {}
	other.Engines = self.Engines
	
	other.Add = function(self, item)
		
		if item == nil then 
			return 
		end
		
		if item:GetWidth() <= 0 then 
			item:SetWidth(self.DefaultSize[1])
		end
		
		if item:GetHeight() <= 0 then 
			item:SetHeight(self.DefaultSize[2]) 
		end
		
		table.insert(self.frames, item)
		
		self:PerformLayout()
		
		return item

	end
	
	other.Clear = function(self)
		self.frames = {}
		self:PerformLayout()
	end
	
	other.PerformLayout = function(self)
		
		local engine = self.Engines[self.Direction]
		
		if engine then
			engine(self)
		end
		
	end
end