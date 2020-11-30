Inventory = Object:extend()

function Inventory:new()
    self.image = love.graphics.newImage("graphics/inventory.png")

    self.inventory = {}

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.borderWidth = 50
    self.borderHeight = 80
    self.slotSize = 80

    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2

    self.gridColumns = 3
    self.gridRows = 4
    self.gridSpacing = 10

    self.currentGridColumn = 1
    self.currentGridRow = 1
end

function Inventory:update()
    --
end

function Inventory:draw()
    if self.visible == true then
        love.graphics.draw(self.image, self.x, self.y)
        local rectangleX = self.x + self.borderWidth + (self.currentGridColumn - 1) * (self.slotSize + self.gridSpacing)
        local rectangleY = self.y + self.borderHeight + (self.currentGridRow - 1) * (self.slotSize + self.gridSpacing)
        love.graphics.rectangle("line", rectangleX, rectangleY, self.slotSize, self.slotSize)
    end
end

function Inventory:toggleVisibility()
    self.visible = not self.visible
end

function Inventory:isInsideGrid(x, y)
    --if self.currentGridColumn > 1 and 
    --self.currentGridColumn < self.gridColumns and 
    --self.currentGridRow > 1 and
    --self.currentGridRow < self.gridRows then
    --    return true
    --else return false
    --end
end

function Inventory:keypressed(key)
    if key == "left" and self.currentGridColumn > 1 then
        self.currentGridColumn = self.currentGridColumn - 1
    elseif key == "right" and self.currentGridColumn < self.gridColumns then     
        self.currentGridColumn = self.currentGridColumn + 1
    elseif key == "up" and self.currentGridRow > 1 then        
        self.currentGridRow = self.currentGridRow - 1
    elseif key == "down" and self.currentGridRow < self.gridRows then       
        self.currentGridRow = self.currentGridRow + 1
    end
end