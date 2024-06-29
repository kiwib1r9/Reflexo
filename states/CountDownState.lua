CountDownState = Class{__includes = BaseState}

COUNTDOWN_TIME = 1.5

function CountDownState:init()
    self.dtotal = 0
    self.count = 3
    sounds['count']:play()
    jogador1:reset()
    jogador2:reset()
    jogador1.free = false
    jogador2.free = false
    reiniciar = false
end

function CountDownState:update(dt)

    self.dtotal = self.dtotal + dt

    if self.dtotal >= 1.5 then
        self.dtotal = self.dtotal % 1.5
        self.count = self.count -1
        if self.count > 0 then
            sounds['count']:play()
        elseif self.count == 0 then
            sounds['go']:play()
        else
            gStateMachine:change('play')
        end
    end


end

function CountDownState:render()
    love.graphics.setFont(numFont)
    if self.count > 0 then
        love.graphics.print(tostring(self.count), WINDOW_WIDTH/2 - 20 , WINDOW_HEIGHT/2 - 130)
    --else
        
        --love.graphics.print('VAI!', 40, 20)
    end
end