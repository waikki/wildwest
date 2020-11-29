Inventory = Object:extend()

function Inventory:new()
    self.image = love.graphics.newImage("graphics/inventory.png")

    self.inventory = {}
    self.visible = false

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

end

function Inventory:update()
    --
end

function Inventory:draw()
    if self.visible == true then
        love.graphics.draw(self.image, love.graphics.getWidth() / 2 - self.width / 2, love.graphics.getHeight() / 2 - self.height / 2)
    end
end

function Inventory:show()
    self.visible = true
end

-- table.insert(inventory, item{})


--Create a table. 
--Let's say you call it "objectList". 
--Then store all objects that are on screen in this table. 
--Each object itself is a table again, holding data like the coordinates, 
--height, width and the image. In the draw-part you loop over all entries to draw them. 
--In the update-part you have to check for collision with the player. If so, remove the object from objectList.
