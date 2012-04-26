local D, S, E = unpack(select(2, ...))

D.LayoutEngine = {}

local L = D.LayoutEngine

L.Engines = {
	["HORIZONTAL"] = function(self) 
		
		local x = self.Margin
		local y = self.Margin
		local currentRowHeight = 0
		
		for i = 1, #self.frames do
			
			local current = self.frames[i]
			
			if self.Wrap and x + current:GetWidth() > self:GetWidth() then
				x = self.Margin
				y = y + currentRowHeight + self.Margin
				currentRowHeight = current:GetHeight()
			end
			
			current:SetPoint(self.Origin, self, self.Origin, x, -y)
			
			x = x + current:GetWidth() + self.Margin
			
			if current:GetHeight() > currentRowHeight then
				currentRowHeight = current:GetHeight()
			end
			
		end
		
	end,
	["VERTICAL"] = function(self) 
		
		local x = self.Margin
		local y = self.Margin
		local currentColWidth = 0
		
		for i = 1, #self.frames do
			
			local current = self.frames[i]
			
			if self.Wrap and y + current:GetHeight() > self:GetHeight() then
				y = self.Margin
				x = x + currentColWidth + self.Margin
				currentColWidth = currentColWidth:GetWidth()
			end
			
			current:SetPoint(self.Origin, self, self.Origin, x, y)
			
			y = y + current:GetHeight() + self.Margin
			
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
	other.Margin = 4
	
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