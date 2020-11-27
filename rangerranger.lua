Ranger = Object:extend()

function Ranger:new(playerID)  
  
  self.playerID = playerID
  
  --graphics
  self.torsoImage = love.graphics.newImage("ranger_torso_anim.png")
  self.torsoFrames = {}
  createAnimation("full", self.torsoImage, self.torsoFrames, 5, 4, 100, 100)
  self.torsoFrame = 1
  
  self.headImage = love.graphics.newImage("ranger_head.png")
  self.headFrames = {}
  createAnimation("full", self.headImage, self.headFrames, 1, 4, 100, 100)
  
  self.rifleHandsImage = love.graphics.newImage("ranger_hands_rifle2.png")
  self.rifleHandsFrames = {}
  createAnimation("full", self.rifleHandsImage, self.rifleHandsFrames, 5, 5, 200, 140)
  self.rifleFrame = 1
  
  self.scale = 0.6
  
  -- gameplay variables
  self.direction = 1   -- 1 = up, 2 = right, 3 = down, 4 = left
  self.torsoDirection = 1 -- 1 = up, 2 = right, 3 = down, 4 = left
  self.state = "idle"
  self.posX = 1200
  self.posY = 450
  self.speed = 400 * self.scale
  self.health = 100
  
  self.shooting = false
  self.walking = false
  
  --these checks if player is moving left or right, and up or down
  self.walkCheckA = false
  self.walkCheckB = false
  
  --collider
  self.colliderWidth = 50
  self.colliderHeight = 50
  
  -- controls
  if self.playerID == 1 then -- do this better
    self.posX = 1200
    self.posY = 650
    self.upButton = "up"
    self.rightButton = "right"
    self.downButton = "down"
    self.leftButton = "left"
    self.shootButton = "rctrl"
  elseif self.playerID == 2 then
    self.posX = 1400
    self.posY = 650
    self.upButton = "w"
    self.rightButton = "d"
    self.downButton = "s"
    self.leftButton = "a"
    self.shootButton = "q"
  elseif self.playerID == 3 then
    self.posX = 1200
    self.posY = 400
    self.upButton = "u"
    self.rightButton = "k"
    self.downButton = "j"
    self.leftButton = "h"
    self.shootButton = "y"
  elseif self.playerID == 4 then
    self.posX = 1400
    self.posY = 400
    self.upButton = "kp8"
    self.rightButton = "kp6"
    self.downButton = "kp2"
    self.leftButton = "kp4"
    self.shootButton = "kpenter"
  end
  
  self.shotEffect = OneTimeEffect(self.posX, self.posY, self.direction)
  
  --audio
  shootAudio = love.audio.newSource("shootsound.wav", "static")
  
  --bullets
  self.bulletList = {}
  
  --debug
  print(self.playerID, self.upButton, self.rightButton,self.downButton, self.leftButton, self.shootButton)
  
end

function Ranger:update(dt)
  
  --controls
  if love.keyboard.isDown(self.rightButton) and self.posX < 2400 then
    self.walkRight(dt)
    self.walkCheckA = true
  elseif love.keyboard.isDown(self.leftButton) and self.posX > 0 then
    self.walkLeft(dt)
    self.walkCheckA = true
  else
    self.walkCheckA = false
  end
  
  if love.keyboard.isDown(self.upButton) and self.posY > 0 then
    self.walkUp(dt)
    self.walkCheckB = true
  elseif love.keyboard.isDown(self.downButton) and self.posY < 900 then
    self.walkDown(dt)
    self.walkCheckB = true
  else
    self.walkCheckB = false
  end
  
  if love.keyboard.isDown(self.shootButton) then
    self.shooting = true
    
    if self.shotEffect.alive == false then
      self.RunShotEffect()
    end
  else
    self.shooting = false
  end
  
  --movement
  function self.walkUp(dt)
    if self.shooting == false then self.direction = 1 end
    self.torsoDirection = 1
    self.posY = self.posY - self.speed * dt
  end 
  
  function self.walkRight(dt)
    if self.shooting == false then self.direction = 2 end
    self.torsoDirection = 2
    self.posX = self.posX + self.speed * dt
  end 
  
  function self.walkDown(dt)
    if self.shooting == false then self.direction = 3 end
    self.torsoDirection = 3
    self.posY = self.posY + self.speed * dt
  end 
  
  function self.walkLeft(dt)
    if self.shooting == false then self.direction = 4 end
    self.torsoDirection = 4
    self.posX = self.posX - self.speed * dt
  end 
  
  
  --shooting
  function self.RunShotEffect()
    if self.direction == 1 then
      
      local xSpot = self.posX + 45 * self.scale
      local ySpot = self.posY - 190 * self.scale
      
      self.shotEffect.posX = xSpot
      self.shotEffect.posY = ySpot
      table.insert(self.bulletList, Bullet(self.direction,xSpot, ySpot))
    elseif self.direction == 2 then
      
      local xSpot = self.posX + 78 * self.scale
      local ySpot = self.posY - 20 * self.scale
      
      self.shotEffect.posX = xSpot
      self.shotEffect.posY =ySpot
      table.insert(self.bulletList, Bullet(self.direction,xSpot, ySpot))
    elseif self.direction == 3 then
      
      local xSpot = self.posX - 30 * self.scale
      local ySpot = self.posY + 90 * self.scale
      
      self.shotEffect.posX = xSpot
      self.shotEffect.posY = ySpot
      table.insert(self.bulletList, Bullet(self.direction,xSpot, ySpot))
    elseif self.direction == 4 then
      
      local xSpot = self.posX - 120 * self.scale
      local ySpot = self.posY - 20 * self.scale
      
      self.shotEffect.posX = xSpot
      self.shotEffect.posY = ySpot
      table.insert(self.bulletList, Bullet(self.direction,xSpot, ySpot))
    end
    
    shootAudio:play()
    self.shotEffect.direction = self.direction 
    self.shotEffect.currentFrame = 1
    self.shotEffect.alive = true
    
    print("player ", self.playerID, " is shooting")
    
  end
  
  --updates
  self.shotEffect:update(dt)
  
  if(#self.bulletList > 0) then
    for i, v in ipairs(self.bulletList) do
      v:update(dt)
      
      for j, k in ipairs(enemies) do
        v:checkCollision(k)
      end
      
      for j, k in ipairs(rangers) do
        v:checkCollision(k)
      end
      
      if(v.posX < 0 or v.posX > love.graphics.getWidth() or v.posY < 0 or v.posY > love.graphics.getHeight()) then
        table.remove(self.bulletList[i])
      end
      
      if(v.dead == true) then
        table.remove(self.bulletList,i)
      end
   end
  end
  
  --animations
  if(self.shooting == false) then --rifle
    if(self.direction == 1) then
      self.rifleFrame = 1
    elseif(self.direction == 2) then
      self.rifleFrame = 6
    elseif(self.direction == 3) then
      self.rifleFrame = 11
    elseif(self.direction == 4) then
      self.rifleFrame = 16
    end
  elseif(self.shooting) then
    self.rifleFrame = self.rifleFrame + 15 * dt
    
    if(self.direction == 1 and self.rifleFrame >= 5) then
      self.rifleFrame = 1
    elseif(self.direction == 2 and self.rifleFrame >= 10) then
      self.rifleFrame = 6
    elseif(self.direction == 3 and self.rifleFrame >= 15) then
      self.rifleFrame = 11
    elseif(self.direction == 4 and self.rifleFrame >= 20) then
      self.rifleFrame = 16
    end
    
  end
  
  --checks if walking
  if(self.walkCheckA or self.walkCheckB) then
    self.walking = true
  elseif(self.walkCheckA and self.walkCheckB) then
    self.walking = true
  else
    self.walking = false
  end
  
  if(self.walking == false) then
    if(self.direction == 1) then
      self.torsoFrame = 1
    elseif(self.direction == 2) then
      self.torsoFrame = 6
    elseif(self.direction == 3) then
      self.torsoFrame = 11
    elseif(self.direction == 4) then
      self.torsoFrame = 16
    end
  elseif(self.walking) then
    self.torsoFrame = self.torsoFrame + 10 * dt
    
    --animation loop
    if(self.torsoDirection == 1 and self.torsoFrame >= 5) then
      self.torsoFrame = 1
    elseif(self.torsoDirection == 2 and self.torsoFrame >= 10) then
      self.torsoFrame = 6
    elseif(self.torsoDirection == 3 and self.torsoFrame >= 15) then
      self.torsoFrame = 11
    elseif(self.torsoDirection == 4 and self.torsoFrame >= 20) then
      self.torsoFrame = 16
    end
    
    --turning frame correction
    if(self.torsoDirection == 1 and self.torsoFrame > 5) then 
      self.torsoFrame = 1
    elseif(self.torsoDirection == 2 and (self.torsoFrame < 6 or self.torsoFrame > 10)) then 
      self.torsoFrame = 6
    elseif(self.torsoDirection == 3 and (self.torsoFrame < 11 or self.torsoFrame > 15)) then 
      self.torsoFrame = 11
    elseif(self.torsoDirection == 4 and (self.torsoFrame < 16 or self.torsoFrame > 20)) then 
      self.torsoFrame = 16
    end
  end
end

function Ranger:draw()
  
  --draw updates
  if self.shotEffect.alive then self.shotEffect:draw() end
  
  for i, v in ipairs(self.bulletList) do
    v:draw()
  end
  
  --player HUD
  --love.graphics.print(self.playerID, self.posX, self.posY - 100)
  love.graphics.rectangle("line", self.posX - 50, self.posY - 75, 100, 5)
  if(self.health > 0) then love.graphics.rectangle("fill", self.posX - 50, self.posY - 75, self.health, 5) end
  
  --love.graphics.rectangle("line", self.posX - self.colliderWidth / 2, self.posY - self.colliderHeight / 2, self.colliderWidth, self.colliderHeight)
  
  --love.graphics.print("x: ", self.posX - 60, self.posY - 100)
  --love.graphics.print(self.posX, self.posX- 50, self.posY - 100)
  
  --love.graphics.print("y: ", self.posX - 60, self.posY - 120)
  --love.graphics.print(self.posY, self.posX- 50, self.posY - 120)
  
  -- draw things in correct order depeding of direction
  if self.direction == 1 then -- up = hands, torso, head
    if self.state == "idle" then
      love.graphics.draw(self.rifleHandsImage, self.rifleHandsFrames[math.floor(self.rifleFrame)], self.posX - (30 * self.scale), self.posY + (-65 * self.scale), 0, self.scale, self.scale, 70,70)
      love.graphics.draw(self.torsoImage, self.torsoFrames[math.floor(self.torsoFrame)], self.posX, self.posY, 0, self.scale, self.scale, 50,50)
      love.graphics.draw(self.headImage, self.headFrames[self.direction], self.posX, self.posY - (55 * self.scale), 0, self.scale, self.scale, 50,50)
    end
  elseif self.direction == 2 then -- right = torso, head, hands
    if self.state == "idle" then
      love.graphics.draw(self.torsoImage, self.torsoFrames[math.floor(self.torsoFrame)], self.posX, self.posY, 0, self.scale, self.scale, 50,50)
      love.graphics.draw(self.headImage, self.headFrames[self.direction], self.posX + (10 * self.scale), self.posY - (70 * self.scale), 0, self.scale, self.scale, 50,50)
      love.graphics.draw(self.rifleHandsImage, self.rifleHandsFrames[math.floor(self.rifleFrame)], self.posX - (10 * self.scale), self.posY - (30 * self.scale), 0, self.scale, self.scale, 70,70)
    end
  elseif self.direction == 3 then  -- down = torso, hands, head
    if self.state == "idle" then
      love.graphics.draw(self.torsoImage, self.torsoFrames[math.floor(self.torsoFrame)], self.posX, self.posY, 0, self.scale, self.scale, 50,50)
      love.graphics.draw(self.rifleHandsImage, self.rifleHandsFrames[math.floor(self.rifleFrame)], self.posX - (30 * self.scale), self.posY + (30 * self.scale), 0, self.scale, self.scale, 70,70)
      love.graphics.draw(self.headImage, self.headFrames[self.direction], self.posX, self.posY - (55 * self.scale), 0, self.scale, self.scale, 50,50)
    end
  elseif self.direction == 4 then -- left = hands, torso, head, side hand
    if self.state == "idle" then
      love.graphics.draw(self.rifleHandsImage, self.rifleHandsFrames[math.floor(self.rifleFrame)], self.posX - (90 * self.scale), self.posY + (-20 * self.scale), 0, self.scale, self.scale, 70,70)
      love.graphics.draw(self.torsoImage, self.torsoFrames[math.floor(self.torsoFrame)], self.posX, self.posY, 0, self.scale, self.scale, 50,50)
      love.graphics.draw(self.headImage, self.headFrames[self.direction], self.posX - (15 * self.scale), self.posY - (65 * self.scale), 0, self.scale, self.scale, 50,50)
      love.graphics.draw(self.rifleHandsImage, self.rifleHandsFrames[21], self.posX - (30 * self.scale), self.posY - (5 * self.scale), 0, self.scale, self.scale, 70,70) -- offhand extra
    end
  end
end