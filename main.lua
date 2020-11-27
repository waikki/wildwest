function love.load()
    Object = require "classic"
    require "cowboy"
    require "level"

    cowboy = Cowboy()
    level = Level()

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

end