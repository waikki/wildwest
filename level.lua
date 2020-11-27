Level = Object:extend()

function Level:new()
    love.graphics.setBackgroundColor(0.8, 0.7, 0.47)
    background = love.graphics.newImage("bg.png")
end

function Level:draw()  
    love.graphics.draw(background, 0, 0)
end