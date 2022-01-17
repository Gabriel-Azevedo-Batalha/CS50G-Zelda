--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(params)
    self.direction = params.direction
    self.x = params.x
    self.y = params.y
    self.width = params.width or 8
    self.height = params.height or 8
    self.initialX = self.x
    self.initialY = self.y
    self.range = params.range
    self.vel = params.vel
    self.texture = params.texture
    self.scale = params.scale or 1
    self.rotation = 0
    self.frame = params.frame
    self.inGame = true
end

function Projectile:update(dt)
    if self.direction == 'up'  then
        self.y = math.max(self.initialY-self.range, self.y-self.vel*dt)
        if self.y == self.initialY-self.range or self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height / 2 then
            self.inGame = false
            gSounds['break']:play()
        end
    elseif self.direction == 'down' then
        self.y = math.min(self.initialY+self.range, self.y+self.vel*dt)
        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
            + MAP_RENDER_OFFSET_Y - TILE_SIZE
        if self.y == self.initialY+self.range or self.y + self.height >= bottomEdge then
            self.inGame = false
            gSounds['break']:play()
        end
    elseif self.direction == 'left' then
        self.x = math.max(self.initialX-self.range, self.x-self.vel*dt)
        if self.x == self.initialX-self.range or self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE  then
            self.inGame = false
            gSounds['break']:play()
        end
    elseif self.direction == 'right' then
        self.x = math.min(self.initialX+self.range, self.x+self.vel*dt)
        if self.x == self.initialX+self.range or self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.inGame = false
            gSounds['break']:play()
        end
    end

    --self.rotation = (self.rotation + dt)
end

function Projectile:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
            self.x, self.y, self.rotation, self.scale, self.scale)
end