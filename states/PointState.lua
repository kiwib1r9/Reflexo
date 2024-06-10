PointState = Class{__includes = BaseState}

function PointState:update(dt)

    dtotal = dtotal + dt
    --ao passar 2s
    if dtotal >= 2 then
        -- se houver tecla
        if #keyQueue > 0 then
            ------------------------------ SITUAÇÃO MONTE -------------------------------
            if baralho.numero == contador then
                -- se a primeira tecla for A
                if keyQueue[1] == 'a' then
                    -- jogador1 leva o monte
                    pontosJogador1 = pontosJogador1 + monte
                    -- muda topo
                    topoJogador1 = baralho.numero
                    -- render mensagem
                    mensagem1 = "Ataque!"

                -- se a primeira tecla for RETURN
                elseif keyQueue[1] == 'return' then
                    -- jogador2 leva o monte
                    pontosJogador2 = pontosJogador2 + monte
                    -- muda topo
                    topoJogador2 = baralho.numero
                    -- render mensagem
                    mensagem2 = "Ataque!"
                end
            end

            ------------------------------ SITUAÇÃO DEFESA 1 -------------------------------
            if topoJogador1 == contador then 
                -- se a primeira tecla for BACKSPACE
                if keyQueue[1] == 'backspace' then
                    -- jogador2 leva pontos do jogador1
                    pontosJogador2 = pontosJogador2 + pontosJogador1
                    pontosJogador1 = 0
                    -- muda topo
                    topoJogador2 = topoJogador1
                    topoJogador1 = 0
                    -- render mensagem
                    mensagem2 = "Ataque surpresa!"
                    -- se a primeira tecla for D
                elseif keyQueue[1] == 'd' then
                 -- render mensagem
                    mensagem1 = "Defesa!"
                end
            else 
                if keyQueue[1] == 'backspace' then
                    monte = monte + pontosJogador2
                    pontosJogador2 = 0
                    topoJogador2 = 0
                end
            end
        end
        ------------------------------ SITUAÇÃO DEFESA 2 -------------------------------
        if topoJogador2 == contador then 
            -- se a primeira tecla for E
            if keyQueue[1] == 'e' then
                -- jogador1 leva pontos do jogador2
                pontosJogador1 = pontosJogador1 + pontosJogador2
                pontosJogador2 = 0
                -- muda topo
                topoJogador1 = topoJogador2
                topoJogador2 = 0
                -- render mensagem
                mensagem1 = "Ataque surpresa!"
                -- se a primeira tecla for D
            elseif keyQueue[1] == 'shift' then
             -- render mensagem
                mensagem2 = "Defesa!"
            end
        else 
            if keyQueue[1] == 'e' then
                monte = monte + pontosJogador1
                pontosJogador1 = 0
                topoJogador1 = 0
            end
        end
        gStateMachine:change('inicio')
    end
        
end

function PointState:render()

  love.graphics.print('inicio', 20, 64)
  love.graphics.print(tostring(count), 20, 100)
end