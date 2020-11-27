Level = Object:extend()

function Level:new()
  
  self.level = {}
  
  table.insert(self.level, {1,1,5,1,1,1,1,1,1,1,1,1,6,1,1,1,1,1,1,1,1,1,1,1,1})
  table.insert(self.level, {1,1,1,1,1,1,1,1,1,1,1,1,6,1,1,1,1,1,1,1,1,1,1,1,1})
  table.insert(self.level, {1,1,1,1,1,1,1,1,1,1,1,1,6,1,1,5,1,1,1,1,1,1,1,1,1})
  table.insert(self.level, {1,1,1,1,1,1,1,1,1,1,1,6,6,6,1,1,1,1,1,1,1,1,1,1,1})
  table.insert(self.level, {2,2,2,2,2,2,2,2,2,2,4,6,6,6,3,2,2,2,2,2,2,2,2,2,2})
  table.insert(self.level, {2,2,2,2,2,2,2,2,2,2,4,6,6,6,3,2,2,2,2,2,2,2,2,2,2})
  table.insert(self.level, {1,1,1,1,1,1,1,1,1,1,1,6,6,6,1,1,1,1,1,1,1,1,1,1,1})
  table.insert(self.level, {1,1,1,1,1,1,1,1,1,1,1,1,6,1,1,1,1,1,1,1,1,1,1,1,1})
  table.insert(self.level, {1,1,1,1,1,1,5,1,1,1,1,1,6,1,1,1,1,1,1,5,1,1,1,1,1})
  table.insert(self.level, {1,1,1,1,1,1,1,1,1,1,1,1,6,1,1,1,1,1,1,1,1,1,1,1,1})
  
end

function Level:update()
end

function Level:draw()  
  for y, v in ipairs(self.level) do
    for x, j in ipairs(self.level[y]) do
      love.graphics.draw(floorTile, floorTileset[j], 100 * (x - 1), 100 * (y - 1), 0, 1,1, 50,50)
    end
  end
end