function love.load()
    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")
    sti = require 'libraries.sti'
    gameMap = sti('maps/OverWorldFinal.lua')
    camera = require('libraries.camera')
    cam = camera()
    wf = require('libraries.windfield')
    world = wf.newWorld(0, 0)


    -- Defining the player sprites
    player = {}
    player.collider = world:newBSGRectangleCollider(400, 200, 16, 25, 5)
    player.collider:setFixedRotation(true)
    player.x = 400
    player.y = 200
    player.speed = 300
    player.sprite = love.graphics.newImage('sprites/parrot.png')
    player.spriteSheet = love.graphics.newImage("sprites/character.png")
    player.grid = anim8.newGrid(16, 32, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    --Animations
    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.2)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 3), 0.2)
    player.animations.left = anim8.newAnimation(player.grid('1-4', 4), 0.2)
    player.animations.right = anim8.newAnimation(player.grid('1-4', 2), 0.2)

    player.anim = player.animations.down

    background = love.graphics.newImage("sprites/background.png")
    
    walls  = {}
    if gameMap.layers["Walls"] then
        for i, obj in pairs(gameMap.layers["Walls"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(walls, wall)
        end
    end
end

function love.update(dt)

   local isMoving = false

    -- represents velocity direction on the x and y axis
    local vx = 0
    local vy = 0 

    -- Player movement using the wsad keys
    if love.keyboard.isDown("d") then
        vx = player.speed * 1
        player.anim = player.animations.right
        isMoving = true
    elseif love.keyboard.isDown("a") then
        vx = player.speed * -1
        player.anim = player.animations.left
        isMoving = true
    elseif love.keyboard.isDown("w") then
        vy = player.speed * -1
        player.anim = player.animations.up
        isMoving = true
    elseif love.keyboard.isDown("s") then
        vy = player.speed * 1
        player.anim = player.animations.down
        isMoving = true
    end

    -- updates velocity with movement
   player.collider:setLinearVelocity(vx, vy)

    if isMoving == false then
        player.anim:gotoFrame(2)
    end

    player.anim:update(dt)

    --cam:lookAt(player.x, player.y)
    cam:lookAt(player.x, player.y) -- always make sure the camera and collision zones are synched together so they don't leave my sprite
    
    



    -- woindfield collisions
    -- ensures collision matches up with the sprite
    world:update(dt)
     player.x = player.collider:getX()
     player.y = player.collider:getY()

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    --left border
    if cam.x < w/2 then
        cam.x = w/2
    end
    -- right border
    if cam.y < h/2 then
        cam.y = h/2
    end

    -- width and height of background
    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight
    
    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end
    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end
end

function love.draw()
    -- Drawing the sprites, background on the screen
    cam:attach()
        -- gameMap:draw()  This conflicts with the camera attach and detach
        gameMap:drawLayer(gameMap.layers["Ground"])
        gameMap:drawLayer(gameMap.layers["Trees and Houses"])
        player.anim:draw(player.spriteSheet, player.x, player.y, nil, 1, nil, 6, 9)         -- set to half of whatever the pixel hight and width of the character is
       -- world:draw()  -- always make sure the camera:detach() is the final part of the function
    cam:detach()
    
end