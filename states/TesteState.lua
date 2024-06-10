TesteState = Class{__includes = BaseState}

function TesteState:update(dt)

    dtotal = dtotal + dt
    --ao passar 2s
    if dtotal >= 2 then

        -- muda baralho
        baralho:muda()

        -- atualiza contador e monte
        dtotal = dtotal % 2
        contador = contador + 1
        monte = monte + 1
        if contador > 13 then
            contador = 1
        end
        sounds[contador]:play()

        if baralho.numero == contador or topoJogador1 == contador or topoJogador2 == contador then
            gStateMachine:change('point')
        end
    end

    if inTable(keyQueue ,'a') then
            monte = monte + pontosJogador1
            pontosJogador1 = 0
            topoJogador1 = 0
    end
    if inTable(keyQueue ,'return') then
            monte = monte + pontosJogador2
            pontosJogador2 = 0
            topoJogador2 = 0
    end


end

function TesteState:render()
  love.graphics.print('inicio', 20, 64)
  love.graphics.print(tostring(count), 20, 100)
end
