function love.load()
  
    -- libraries
    Object = require "classic"
    require "ranger"
    require "OneTimeEffect"
    require "bullet"
    require "level"
    require "hiss_ranger"
    
    level1 = Level()
    
    music = love.audio.newSource("music.wav", "static")
    music:setLooping(true)
    music:play()
    --love.audio.play(music)
    
    screenWidth = love.graphics.getWidth() / 2
    screenHeigth = love.graphics.getHeight() / 2
    
    screenCanvas = love.graphics.newCanvas(screenWidth,screenHeigth)
    
    -- object tables
    rangers = {}
    table.insert(rangers, Ranger(1))
    table.insert(rangers, Ranger(2))
    table.insert(rangers, Ranger(3))
    table.insert(rangers, Ranger(4))
    
    enemies = {}
    
    spawnTimer = 10
    spawnAmount = 5
    
    gameState = "intro" --intro, game
    
    introGraphic = love.graphics.newImage("ranger_danger_logo.png")
    introTimer = 20
  
    -- level graphics
    floorTile = love.graphics.newImage("floortile_basic.png")
    floorTileset = {}
    createAnimation("full", floorTile, floorTileset, 2,3, 100,100)
    
    controls = {
      player1 = {
        upButton = "up",
        rightButton = "right",
        downButton = "down",
        leftButton = "left",
        shootButton = "shoot"
      },
       player2 = {
        upButton = "w",
        rightButton = "d",
        downButton = "s",
        leftButton = "a",
        shootButton = "q"
      },
       player3 = {
        upButton = "u",
        rightButton = "k",
        downButton = "j",
        leftButton = "h",
        shootButton = "o"
        }
      }
    
  end
  
  function love.update(dt)
    if gameState == "intro" then
      intro(dt)
    elseif gameState == "game" then
      game(dt)
    end
  end
  
  function intro(dt)
    if(introTimer > 0) then
      introTimer = introTimer - 5 * dt
    elseif(introTimer <= 0) then
      gameState = "game"
    end
  end
  
  function game(dt)
    
    -- object updates
    for i, v in ipairs(rangers) do
      v:update(dt)
      if v.health <= 0 then
        table.remove(rangers, i)
      end
    end
    
     for i, v in ipairs(enemies) do
      v:update(dt)
      if v.health <= 0 then
        table.remove(enemies, i)
      end
    end
    
    --new enemies
    if(spawnTimer > 0 and #enemies == 0) then
      spawnTimer = spawnTimer - 2 * dt
    elseif(spawnTimer <= 0 and #enemies == 0) then
      spawnTimer = 10
      spawnAmount = spawnAmount + 2
      for i = 1, spawnAmount do
        table.insert(enemies, HissRanger(love.math.random(0, 2400),love.math.random(0,900), 3))
      end
    end
  end
  
  function love.draw()
    
    if(gameState == "intro") then
      if(introTimer > 5 and introTimer < 18) then
        love.graphics.draw(introGraphic, screenWidth, screenHeigth, 0,2,2,256/2, 256/2)
      end
    elseif(gameState == "game") then
      if(rangers[1] ~= nil) then
        love.graphics.setCanvas(screenCanvas)
          love.graphics.clear()
          drawGame(1)
        love.graphics.setCanvas()
        love.graphics.draw(screenCanvas)
      end
      
      if(rangers[2] ~= nil) then
        love.graphics.setCanvas(screenCanvas)
          love.graphics.clear()
          drawGame(2)
        love.graphics.setCanvas()
        love.graphics.draw(screenCanvas, screenWidth + 5)
      end
      
      if(rangers[3] ~= nil) then
        love.graphics.setCanvas(screenCanvas)
          love.graphics.clear()
          drawGame(3)
        love.graphics.setCanvas()
        love.graphics.draw(screenCanvas,0, screenHeigth +5)
      end
      
      if(rangers[4] ~= nil) then
        love.graphics.setCanvas(screenCanvas)
          love.graphics.clear()
          drawGame(4)
        love.graphics.setCanvas()
        love.graphics.draw(screenCanvas, screenWidth + 5, screenHeigth +5)
      end
    end
  end
  
  function drawGame(focus)
    love.graphics.push()
      love.graphics.translate(-rangers[focus].posX + screenWidth / 2, -rangers[focus].posY + screenHeigth / 2)
      level1:draw()
      
      for i, v in ipairs(rangers) do
        v:draw()
      end
      
      if(#enemies > 0) then
        for i, v in ipairs(enemies) do
          v:draw()
        end
      end
      
    love.graphics.pop()
  end
  
  -- tools
  
  function createAnimation(style, image, frameTable, framesX, framesY, frameSizeX, frameSizeY, row) --style = full or row, image = spritesheet, frameTable = list where we save frames, framesX = how many frames on row in tilestheet, FramesY = how many rows in tilesheet, FrameSizeX and FrameSizeY = grid size, row = optional; if using "row"-style, tell which row we want to animate
    if(style == "full") then
      for y = 0, framesY -1 do
        for x = 0, framesX -1 do
          -- x position, y position, frame width, frame height, full image width, full image height 
          table.insert(frameTable, love.graphics.newQuad(x * frameSizeX, y * frameSizeY, image:getWidth() / framesX, image:getHeight() / framesY, image:getWidth(), image:getHeight()))
        end
      end
    elseif(style == "row") then
     y = row
      for x = 0, framesX -1 do
        -- x position, y position, frame width, frame height, full image width, full image height 
        table.insert(frameTable, love.graphics.newQuad(x * frameSizeX, y * frameSizeY, image:getWidth() / framesX, image:getHeight() / framesY, image:getWidth(), image:getHeight()))
      end
    end
  end