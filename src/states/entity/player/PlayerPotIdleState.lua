--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerPotIdleState = Class{__includes = EntityIdleState}

function PlayerPotIdleState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
    self.entity:changeAnimation('pot-idle-' .. self.entity.direction)
end

function PlayerPotIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('pot-walk')
    end
end

function PlayerPotIdleState:render()
    local anim = self.entity.currentAnimation
    
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    
    love.graphics.draw(gTextures[self.entity.lifted.texture], gFrames[self.entity.lifted.texture][self.entity.lifted.states[self.entity.lifted.state].frame or self.entity.lifted.frame],
    math.floor(self.entity.x),  math.floor(self.entity.y-7))
end