InicioState = Class{__includes = BaseState}
count = 0
function InicioState:update(dt)

    dtotal = dtotal + dt
    

    if dtotal >= 1.5 then
        count = count + 1
        dtotal = dtotal % 1.5
    end

    if count == 4 then
        -- muda baralho
        baralho:muda()
        contador = 1
        monte = 1
        sounds[1]:play()
        if baralho.numero == 1 then
            gStateMachine:change('point')
        else
            gStateMachine:change('teste')
        end
    end
end

function InicioState:render()
  love.graphics.print('inicio', 20, 64)
  love.graphics.print(tostring(count), 20, 100)
end