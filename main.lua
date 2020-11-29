function love.load()
    Object = require "classic"
    require "cowboy"
    require "level"
    require "inventory"

    cowboy = Cowboy()
    level = Level()
    inventory = Inventory()

    screenWidth = love.graphics.getWidth()
    screenHeigth = love.graphics.getHeight()
end

function love.update(dt)
    cowboy:update(dt)
end

function love.draw()
    -- camera follows player
    love.graphics.push()
    love.graphics.translate(-cowboy.x + screenWidth / 2, -cowboy.y + screenHeigth / 2)
    level:draw()
    cowboy:draw()
    love.graphics.pop()
    -- draw gui here

    inventory:draw()
end

function love.keypressed(key)
    if key == "x" then
        print("This is a nice tree")
    end

    if key == "i" then
        inventory:show()
    end
end