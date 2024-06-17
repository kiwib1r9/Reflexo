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

        if inTable(keyQueue ,'a') or inTable(keyQueue ,'e') or inTable(keyQueue ,'d') then
            monte = monte + pontosJogador1
            pontosJogador1 = 0
            topoJogador1 = 0
            --jogador1:reset()
        end

        if inTable(keyQueue ,'return') or inTable(keyQueue ,'rshift') or inTable(keyQueue ,'backspace') then
            monte = monte + pontosJogador2
            pontosJogador2 = 0
            topoJogador2 = 0
            --jogador2:reset()
        end

        keyQueue={}

    end

end

function TesteState:render()

end
