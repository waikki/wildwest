InventoryItem = Object:extend()

function InventoryItem:new()
    self.image = love.graphics.newImage("")
    self.x = 0
    self.y = 0
    self.picked = false
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function InventoryItem:update()
    --
end

function InventoryItem:draw()
    --
end

--- list of all possible items? true and false based on if they're picked or not