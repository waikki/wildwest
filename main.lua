function love.load()
    Object = require "classic"
    require "cowboy"

    love.graphics.setBackgroundColor(0.8, 0.7, 0.47)

    cowboy = Cowboy()
end

function love.update(dt)
    cowboy:update(dt)
end

function love.draw()
    cowboy:draw()
end