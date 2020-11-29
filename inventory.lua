Inventory = Object:extend()

function Inventory:new()
    self.image = love.graphics.newImage("graphics/inventory.png")

    self.inventory = {}
    self.visible = false

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
    self.currentDridRow = 1

    self.rectangleX = self.x + self.borderWidth
    self.rectangleY = self.y + self.borderHeight
end

function Inventory:update()
    --
end

function Inventory:draw()
    if self.visible == true then
        love.graphics.draw(self.image, self.x, self.y)
        love.graphics.rectangle("line", self.rectangleX, self.rectangleY, self.slotSize, self.slotSize)
    end
end

function Inventory:toggleVisibility()
    self.visible = not self.visible
end

function Inventory:isInsideGrid(x, y)
    --
end

function Inventory:keypressed(key)
    if key == "left" then      
        self.currentGridColumn = self.currentGridColumn - 1
        self.rectangleX = self.rectangleX - self.slotSize - self.gridSpacing
    elseif key == "right" then     
        self.currentGridColumn = self.currentGridColumn + 1
        self.rectangleX = self.rectangleX + self.slotSize + self.gridSpacing
    elseif key == "up" then        
        self.currentDridRow = self.currentDridRow - 1
        self.rectangleY = self.rectangleY - self.slotSize - self.gridSpacing
    elseif key == "down" then       
        self.currentDridRow = self.currentDridRow + 1
        self.rectangleY = self.rectangleY + self.slotSize + self.gridSpacing
    end
end

-- table.insert(inventory, item{})


--Create a table. 
--Let's say you call it "objectList". 
--Then store all objects that are on screen in this table. 
--Each object itself is a table again, holding data like the coordinates, 
--height, width and the image. In the draw-part you loop over all entries to draw them. 
--In the update-part you have to check for collision with the player. If so, remove the object from objectList.
