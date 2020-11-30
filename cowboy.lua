Cowboy = Object:extend()

function Cowboy:new()
    self.image = love.graphics.newImage("graphics/cowboy.png")

    self.direction = 1 -- 1 = right, 2 = left, 3 = up, 4 = down
    self.state = "idle"
    self.x = 960
    self.y = 540

    self.speed = 200
    self.walking = false

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.upButton = "up"
    self.rightButton = "right"
    self.downButton = "down"
    self.leftButton = "left"
    self.shootButton = "space"

    self.frame = 1
    self.walkFramesLeft = {}
    table.insert(self.walkFramesLeft, love.graphics.newImage("graphics/cowboy.png"))
    table.insert(self.walkFramesLeft, love.graphics.newImage("graphics/cowboy_walk_left_2.png"))

    self.walkFramesRight = {}
    table.insert(self.walkFramesRight, love.graphics.newImage("graphics/cowboy_walk_right_1.png"))
    table.insert(self.walkFramesRight, love.graphics.newImage("graphics/cowboy_walk_right_2.png"))

    self.walkFramesUp = {}
    table.insert(self.walkFramesUp, love.graphics.newImage("graphics/cowboy_walk_up_1.png"))
    table.insert(self.walkFramesUp, love.graphics.newImage("graphics/cowboy_walk_up_2.png"))
end

function Cowboy:update(dt)
    self.frame = self.frame + 1 * dt 
    if self.frame >= 3 then 
        self.frame = 1 
    end

    --controls
    if love.keyboard.isDown(self.rightButton) then          -- walk right
        self.direction = 1
        self.x = self.x + self.speed * dt
    elseif love.keyboard.isDown(self.leftButton) then       -- walk left
        self.direction = 2 
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown(self.upButton) then         -- walk up
        self.direction = 3
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown(self.downButton) then       -- walk down
        self.direction = 4 
        self.y = self.y + self.speed * dt
    else self.direction = 0
    end

    if love.keyboard.isDown(self.shootButton) then          -- shoot
        print("pew pew")
    end
end

function Cowboy:draw()
    if self.direction == 0 then
        love.graphics.draw(self.image, self.x - self.width / 2, self.y - self.height / 2)
    end

    if self.direction == 1 then
        love.graphics.draw(self.walkFramesRight[math.floor(self.frame)], self.x - self.width / 2, self.y - self.height / 2)
    end

    if self.direction == 2 then
        love.graphics.draw(self.walkFramesLeft[math.floor(self.frame)], self.x - self.width / 2, self.y - self.height / 2)
    end

    if self.direction == 3 then
        love.graphics.draw(self.walkFramesUp[math.floor(self.frame)], self.x - self.width / 2, self.y - self.height / 2)
    end

    if self.direction == 4 then
        love.graphics.draw(self.walkFramesLeft[math.floor(self.frame)], self.x - self.width / 2, self.y - self.height / 2)
    end
end