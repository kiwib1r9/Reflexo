PlayState = Class{__includes = BaseState}
local ATAQUE = love.graphics.newImage('img/ataque.jpg')
local REFLEXO = love.graphics.newImage('img/reflexo.jpg')
local DEFESA = love.graphics.newImage('img/defesa.jpg')
local QUEIMOU = love.graphics.newImage('img/queimou.jpg')

PLAY_TIME = 2

function PlayState:init()
    self.ataque = ATAQUE
    self.reflexo = REFLEXO
    self.defesa = DEFESA
    self.queimou = QUEIMOU

    self.dtotal = 0

    baralho:muda()
    contador = 1
    sounds[contador]:play()
    monte = monte + 1

    keyQueue = {}
    jogador1.free = true
    jogador2.free = true

    reiniciar = false

end

function PlayState:update(dt)

    self.dtotal = self.dtotal + dt

    -- ao passar tempo da rodada

    if self.dtotal >= PLAY_TIME then
        mensagem1 = nil
        mensagem2 = nil

        jogador1.free = false
        jogador2.free = false

        --reiniciar = false

        -- se houve tecla
        if #keyQueue > 0 then

            --  ------------------------------ SITUAÇÃO MONTE -------------------------------
            --  if baralho.numero == contador then
            --     -- se a primeira tecla for A
            --     if keyQueue[1] == 'a' then
            --         -- jogador1 leva o monte
            --         pontosJogador1 = pontosJogador1 + monte
            --         -- muda topo
            --         topoJogador1 = baralho.numero
            --         -- render mensagem
            --         mensagem1 = self.reflexo
            --         monte = 0
            --         self.reiniciar = true

            --     -- se a primeira tecla for RETURN
            --     elseif keyQueue[1] == 'return' then
                    
            --         -- jogador2 leva o monte
            --         pontosJogador2 = pontosJogador2 + monte
            --         -- muda topo
            --         topoJogador2 = baralho.numero
            --         -- render mensagem
            --         mensagem2 = self.reflexo
            --         monte = 0
            --         self.reiniciar = true
            --     end
            -- else
            --     ------------------------------ QUEIMADA -------------------------------        
            --     if inTable(keyQueue ,'a') or inTable(keyQueue ,'e') or inTable(keyQueue ,'d') then
            --         monte = monte + pontosJogador1
            --         pontosJogador1 = 0
            --         topoJogador1 = 0
            --         mensagem1 = self.queimou
                    
            --     end
        
            --     if inTable(keyQueue ,'return') or inTable(keyQueue ,'rshift') or inTable(keyQueue ,'backspace') then
            --         monte = monte + pontosJogador2
            --         pontosJogador2 = 0
            --         topoJogador2 = 0

            --         -- render mensagem
            --         mensagem2 = self.queimou
                    
            --     end
            -- end
            -- ------------------------------ SITUAÇÃO DEFESA 1 -------------------------------
            -- if topoJogador1 == contador then 
            --     -- se a primeira tecla for BACKSPACE
            --     if keyQueue[1] == 'backspace' then
                    
            --         -- jogador2 leva pontos do jogador1
            --         pontosJogador2 = pontosJogador2 + pontosJogador1
            --         pontosJogador1 = 0
            --         -- muda topo
            --         topoJogador2 = topoJogador1
            --         topoJogador1 = 0
            --         -- render mensagem
            --         mensagem2 = self.ataque
            --         self.reiniciar = true

            --         -- se a primeira tecla for D
            --     elseif keyQueue[1] == 'd' then
                    
            --      -- render mensagem
            --         mensagem1 = self.defesa
            --     end
            -- else 
            --     if keyQueue[1] == 'backspace' then
                    
            --         monte = monte + pontosJogador2
            --         pontosJogador2 = 0
            --         topoJogador2 = 0
            --         mensagem2 = self.queimou
                    
            --     end
            -- end

            -- ------------------------------ SITUAÇÃO DEFESA 2 -------------------------------
            -- if topoJogador2 == contador then 
            --     -- se a primeira tecla for E
            --     if keyQueue[1] == 'e' then
                    
            --         -- jogador1 leva pontos do jogador2
            --         pontosJogador1 = pontosJogador1 + pontosJogador2
            --         pontosJogador2 = 0
            --         -- muda topo
            --         topoJogador1 = topoJogador2
            --         topoJogador2 = 0
            --         -- render mensagem
            --         mensagem1 = self.ataque
            --         self.reiniciar = true
            --         -- se a primeira tecla for D
                    
            --     elseif keyQueue[1] == 'shift' then
                    
            --     -- render mensagem
            --         mensagem2 = self.defesa
            --     end
            -- else 
            --     if keyQueue[1] == 'e' then
                    
            --         monte = monte + pontosJogador1
            --         pontosJogador1 = 0
            --         topoJogador1 = 0
            --         mensagem1 = self.queimou
                    
            --     end
            -- end

            monte1:atualiza()
            monte2:atualiza()
            jogador1:reset()
            jogador2:reset()
            
        end
        

        if reiniciar then
            gStateMachine:change('count')
        else

            -- atualiza tempo corrido 
            self.dtotal = self.dtotal % 2

            -- atualiza contadores 
            contador = (contador %13) + 1
            baralho:muda()
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
    monte1:render()
    monte2:render()
    
    baralho:render()
    -- render monte
    --love.graphics.rectangle('fill',  200, WINDOW_HEIGHT - 40 - 120, 81, 120)
    --love.graphics.rectangle('fill', WINDOW_WIDTH - 200 - 81, WINDOW_HEIGHT - 40 - 120, 81, 120)
    -- love.graphics.setFont(cardNumFont)
    -- love.graphics.print(pontosJogador1, 20, 300)
    -- love.graphics.print(pontosJogador2, 420, 300)
    if mensagem1 == 'queimou' then
        love.graphics.draw(QUEIMOU, 20, 300)
    elseif mensagem1 == 'ataque' then
        love.graphics.draw(ATAQUE, 20, 300)
    elseif mensagem1 == 'reflexo' then
        love.graphics.draw(REFLEXO, 20, 300)
    elseif mensagem1 == 'defesa' then
        love.graphics.draw(DEFESA, 20, 300)
    end

    if mensagem2 == 'queimou' then
        love.graphics.draw(QUEIMOU, 450, 300)
    elseif mensagem2 == 'ataque' then
        love.graphics.draw(ATAQUE, 450, 300)
    elseif mensagem2 == 'reflexo' then
        love.graphics.draw(REFLEXO, 450, 300)
    elseif mensagem2 == 'defesa' then
        love.graphics.draw(DEFESA, 450, 300)
    end

end

