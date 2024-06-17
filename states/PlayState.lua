PlayState = Class{__includes = BaseState}

PLAY_TIME = 2

function PlayState:init()
    self.dtotal = 0

    baralho:muda()
    contador = 1
    sounds[contador]:play()
    monte = monte + 1

    keyQueue = {}
    jogador1.free = true
    jogador2.free = true

    self.reiniciar = false

end

function PlayState:update(dt)

    self.dtotal = self.dtotal + dt

    -- ao passar tempo da rodada

    if self.dtotal >= PLAY_TIME then
        mensagem1 = ''
        mensagem2 = ''

        jogador1.free = false
        jogador2.free = false

        self.reiniciar = false

        -- se houve tecla
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
                    monte = 0
                    self.reiniciar = true

                -- se a primeira tecla for RETURN
                elseif keyQueue[1] == 'return' then
                    
                    -- jogador2 leva o monte
                    pontosJogador2 = pontosJogador2 + monte
                    -- muda topo
                    topoJogador2 = baralho.numero
                    -- render mensagem
                    mensagem2 = "Ataque!"
                    monte = 0
                    self.reiniciar = true
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
                    self.reiniciar = true

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
                    mensagem2 = "Queimou!"
                    
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
                    self.reiniciar = true
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
                    mensagem1 = "Queimou!"
                    
                end
            end

            ------------------------------ QUEIMADA -------------------------------
            
            if inTable(keyQueue ,'a') or inTable(keyQueue ,'e') or inTable(keyQueue ,'d') then
                monte = monte + pontosJogador1
                pontosJogador1 = 0
                topoJogador1 = 0
                mensagem1 = "Queimou!"
                
            end
    
            if inTable(keyQueue ,'return') or inTable(keyQueue ,'rshift') or inTable(keyQueue ,'backspace') then
                monte = monte + pontosJogador2
                pontosJogador2 = 0
                topoJogador2 = 0

                -- render mensagem
                mensagem2 = "Queimou!"
                
            end
            jogador1:reset()
            jogador2:reset()
            
        end

        if self.reiniciar then
            gStateMachine:change('count')
        else
            -- atualiza tempo corrido 
            self.dtotal = self.dtotal % 2

            -- atualiza contadores 
            baralho:muda()
            contador = (contador %13) + 1
            monte = monte + 1
            sounds[contador]:play()

            -- habilita movimentos
            jogador1.free = true
            jogador2.free = true
        end

        keyQueue = {}

    end
end

function PlayState:render()

end