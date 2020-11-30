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

    gameMode = "game"
end

function love.update(dt)
    if gameMode == "game" then
        cowboy:update(dt)
    end
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
    if gameMode == "inventory" then
        inventory:keypressed(key)
    end

    if key == "x" then
        print("This is a nice tree")
    end

    if key == "i" then
        if gameMode == "inventory" then
            gameMode = "game"
            inventory:toggleVisibility()
        elseif gameMode == "game" then
            gameMode = "inventory"
            inventory:toggleVisibility()
        end
    end

    if key == "a" and gameMode == "game" then
        inventory:add()
    end

end