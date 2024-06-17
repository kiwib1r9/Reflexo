InicioState = Class{__includes = BaseState}

function InicioState:update(dt)

    dtotal = dtotal + dt

    if count == 4 then
        sounds['go']:play()
        jogador1.free = true
        jogador2.free = true
        -- muda baralho
        baralho:muda()
        contador = 1
        monte=monte + 1
        sounds[1]:play()
        if baralho.numero == 1 then
            gStateMachine:change('point')
        else
            gStateMachine:change('teste')
        end
    elseif dtotal >= 1.5 then
        count = count + 1
        sounds['count']:play()
        dtotal = dtotal % 1.5
    end
end

function InicioState:render()
  love.graphics.print('inicio', 20, 64)
  love.graphics.print(tostring(count), 20, 100)
end