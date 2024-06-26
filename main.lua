--[[ Author - Clara Schons Theisen ]]--



Class = require 'class'
require 'Mao'
require 'Baralho'

require 'StateMachine'
require 'states/BaseState'
require 'states/CountDownState'
require 'states/MenuState'
require 'states/PlayState'
require 'states/PointState'

--[[
function Player()
    return{
        pontos = 
        numeroTopo = 
        naipeTopo = 
        monte =
        mao = 

    }
end


]]--


function love.load()

    -- random seed 
    math.randomseed(os.time())

    -- tamanho da tela
    WINDOW_HEIGHT = 620
    WINDOW_WIDTH = 620

    -- inicializaçao do som
    sounds = {
        [1] = love.audio.newSource('audio/1.wav', "static"),
        [2] = love.audio.newSource('audio/2.wav', "static"),
        [3] = love.audio.newSource('audio/3.wav', "static"),
        [4] = love.audio.newSource('audio/4.wav', "static"),
        [5] = love.audio.newSource('audio/5.wav', "static"),
        [6] = love.audio.newSource('audio/6.wav', "static"),
        [7] = love.audio.newSource('audio/7.wav', "static"),
        [8] = love.audio.newSource('audio/8.wav', "static"),
        [9] = love.audio.newSource('audio/9.wav', "static"),
        [10] = love.audio.newSource('audio/10.wav', "static"),
        [11] = love.audio.newSource('audio/11.wav', "static"),
        [12] = love.audio.newSource('audio/12.wav', "static"),
        [13] = love.audio.newSource('audio/13.wav', "static"),
        ['count'] = love.audio.newSource('audio/count.wav', "static"),
        ['go'] = love.audio.newSource('audio/go.wav', "static"),
    
    }
    
    -- inicializacao janela
    love.window.setTitle('Reflexo')
    
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- tamanho e posiçao das cartas
    cardWidth = 250
    cardHeight = 354
    cardX = WINDOW_WIDTH/2 - cardWidth/2
    cardY = WINDOW_HEIGHT/3 - cardHeight/2


    -- tamanho e posicao dos jogadores
    handsWidth = 70
    handsHeight = 100

    hand1X = WINDOW_WIDTH/4 - handsWidth/2
    hand1Y = WINDOW_HEIGHT - handsHeight - 30
    hand2X = WINDOW_WIDTH *3/4 - handsWidth/2
    hand2Y = WINDOW_HEIGHT - handsHeight - 30

    -- Define a rotação em graus
    rotationInDegrees = 30

    -- Converte a rotação para radianos
    rotation = math.rad(rotationInDegrees)
    
    mouseX, mouseY = love.mouse.getPosition()

 
    -- inicializaçao dos elementos
    -- JOGADOR 1
    jogador1 = Mao(1)
    pontosJogador1 = 0
    mensagem1 = nil
   -- monte do jogador 1

    -- JOGADOR 2
    jogador2 = Mao(2)
    pontosJogador2 = 0
    mensagem2 = nil
   -- monte do jogador 2

    -- BARALHO
    baralho = Baralho(cardX,cardY,1)
    monte1 = Baralho(200, WINDOW_HEIGHT - 40 - 120, 0)
    monte2 = Baralho(WINDOW_WIDTH - 200 - 81, WINDOW_HEIGHT - 40 - 120,0)

    -- GLOBAIS
    monte = 0
    count = 0
    contador = 0
    reiniciar = false
    primeiro = 1

    -- inicialização das fontes
    numFont = love.graphics.newFont('coolslim/Coolslim.otf', 100)
    -- cardNumFont = love.graphics.newFont('coolslim/Coolslim.otf', 70)
    -- smallFont = love.graphics.newFont('coolslim/Coolslim.otf', 20)
    titleFont = love.graphics.newFont('slim_chef/Slim Chef -personal use.ttf', 300)
    --flappyFont = love.graphics.newFont('flappy.ttf', 28)
    --hugeFont = love.graphics.newFont('flappy.ttf', 56)

    -- inicialização dos estados de jogo
    gStateMachine = StateMachine {
        ['menu'] = function() return MenuState() end,
        ['count'] = function() return CountDownState() end,
        ['play'] = function() return PlayState() end,
        ['teste'] = function() return TesteState() end,
        ['point'] = function() return PointState() end,
        ['end'] = function () return EndState() end
    }

    -- inicia no menu
    gStateMachine:change('menu')
    --gStateMachine:change('count')

    -- limpa teclas

        
    love.keyboard.keysPressed = {}

    keyQueue = {}

    
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
    -- se esta em partida e nenuma tecla foi diitada
    -- playstate
    -- loica primeiro e de mensaem//pontuaçao
    table.insert(keyQueue, key)

    if gStateMachine.name == 'play' then
        testa(key)
    end


end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)

    gStateMachine:update(dt)

    jogador1:update(dt)
    jogador2:update(dt)


    love.keyboard.keysPressed = {}
    
end

function love.draw()

    --love.graphics.clear(126/255, 161/255, 255/255, 1)
    --love.graphics.clear(1,0,128/255,1)

    love.graphics.clear(0,0,0,1)

    monte1:render()
    monte2:render()
    --if monte > 0 then
    baralho:render()
    --end
    gStateMachine:render()
    -- if topoJogador1.num > 0 then
        -- render monte1
    -- if topoJogador2.num > 0 then
        -- render monte2

    -- fazer render em ordem de tecla pressionada
    -- se jogador 1 antes
    
    if primeiro == 1 then 
        jogador1:render()
        jogador2:render()
    else
        jogador2:render()
        jogador1:render()
    end


    love.graphics.setColor(1,1,1,1)

    -- mensagens

    --love.graphics.setFont(mediumFont)
    -- if mensagem1 ~= '' then
    --     love.graphics.print(mensagem1, 20, 600)
    -- end

    -- if mensagem2 ~= '' then
    --     love.graphics.print(mensagem2, 520, 600)
    -- end

    --love.graphics.setFont(numFont)
    --love.graphics.print(tostring(baralho.numero), WINDOW_WIDTH*2/3, WINDOW_HEIGHT/4)
    -- love.graphics.print(tostring(monte), WINDOW_WIDTH*2/3, WINDOW_HEIGHT*2/4)
    -- centralizar
    -- em que posição botar
    -- love.graphics.print(tostring(pontosJogador1) .. " vs " .. tostring(pontosJogador2), 20, 20)

    
end

----- AUXILIARES

function inTable(table, val)
    for i, v in ipairs(table) do
        if v == val then
            return true
        end
    end
    return false
end

-- Função para detectar se o mouse está sobre uma opção
function isMouseHovering(option)
    local mouseX, mouseY = love.mouse.getPosition()
    return mouseX > option.x and mouseX < option.x + option.width and
           mouseY > option.y and mouseY < option.y + option.height
end

-- Função para detectar clique do mouse
function love.mousepressed(x, y, button, istouch, presses)
    if gStateMachine.name == 'menu' then
        if button == 1 then -- 1 é o botão esquerdo do mouse
            for name, option in pairs(menu) do
                if isMouseHovering(option) then
                    if name == "jogar" then
                        gStateMachine:change('count')
                        
                    elseif name == 'tutorial' then
                        --gStateMachine:change('tutorial')
                    else 
                        love.event.quit()
                    end
                end
            end
        end
    end
end

function testa(char)
------------------------------ SITUAÇÃO MONTE -------------------------------

    if #keyQueue == 1 then
        if baralho.numero == contador then
            -- se a primeira tecla for A
            if char == 'a' then
                -- jogador1 leva o monte
                pontosJogador1 = pontosJogador1 + monte
                -- muda topo
                monte1:set(baralho.numero,baralho.naipe)
                -- render mensagem
                mensagem1 = 'reflexo'
                monte = 0
                primeiro = 1
                reiniciar = true

            -- se a primeira tecla for RETURN
            elseif char == 'return' then           
                -- jogador2 leva o monte
                pontosJogador2 = pontosJogador2 + monte
                -- muda topo
                monte2:set(baralho.numero, baralho.naipe)

                -- render mensagem
                mensagem2 = 'reflexo'
                monte = 0
                primeiro = 2
                reiniciar = true
            end
        end
            
        ------------------------------ SITUAÇÃO DEFESA 1 -------------------------------
        if monte1.numero == contador then 
            -- se a primeira tecla for BACKSPACE
            if char == 'backspace' then
                
                -- jogador2 leva pontos do jogador1
                pontosJogador2 = pontosJogador2 + pontosJogador1
                pontosJogador1 = 0
                -- muda topo
                -- topoJogador2 = topoJogador1
                monte2:set(monte1.numero, monte1.naipe)
                -- topoJogador1 = Topo(0,0)
                monte1:set(0,0)
                -- print(topoJogador1.num)
                -- print(topoJogador1.naipe)
                -- print(topoJogador2.num)
                -- print(topoJogador2.naipe)
                -- render mensagem
                mensagem2 = 'ataque'
                primeiro = 2
                reiniciar = true

                -- se a primeira tecla for D
            elseif char == 'd' then
                
                -- render mensagem
                mensagem1 = 'defesa'
                primeiro = 1
            end
        end
        -- else 
        --     if char == 'backspace' then
                
        --         monte = monte + pontosJogador2
        --         pontosJogador2 = 0
        --         -- topoJogador2 = Topo(0,0)
        --         -- print(topoJogador2.num)
        --         -- print(topoJogador2.naipe)
        --         mensagem2 = 'queimou'
        --         primeiro = 2
                
        --     end
        -- end
        ------------------------------ SITUAÇÃO DEFESA 2 -------------------------------
        if monte2.numero == contador then 
            -- se a primeira tecla for E
            if char == 'e' then  
                -- jogador1 leva pontos do jogador2
                pontosJogador1 = pontosJogador1 + pontosJogador2
                pontosJogador2 = 0
                -- muda topo
                -- topoJogador1 = topoJogador2
                monte1:set(monte2.numero, monte2.naipe)
                -- topoJogador2 = Topo(0,0)
                monte2:set(0,0)
                -- render mensagem
                mensagem1 = 'ataque'
                primeiro = 1
                reiniciar = true

            -- se a primeira tecla for D
                        
            elseif char == 'rshift' then
                        
                -- render mensagem
                primeiro = 2
                mensagem2 = 'defesa'
            end
        end
        -- else 
        --     if char == 'e' then
                        
        --         monte = monte + pontosJogador1
        --         pontosJogador1 = 0
        --         -- topoJogador1 = Topo(0,0)
        --         primeiro = 1
        --         mensagem1 = 'queimou'
                        
        --     end
        -- end
    end
    ------------------------------ QUEIMADA ------------------------------- 
    if baralho.numero ~= contador then       
        if char == 'a' then
            monte = monte + pontosJogador1
            pontosJogador1 = 0
            --topoJogador1 = Topo(0,0)
            monte1:set(0,0)
            if #keyQueue == 1 then
                primeiro = 1
            end
            mensagem1 = 'queimou'
            
        end

        if char == 'return' then
            monte = monte + pontosJogador2
            pontosJogador2 = 0
            --topoJogador2 = Topo(0,0)
            monte2:set(0,0)
            if #keyQueue == 1 then
                primeiro = 2
            end
            -- render mensagem
            mensagem2 = 'queimou'     
        end
    end

    if monte1.numero ~= contador then 
        if char == 'd' then
            monte = monte + pontosJogador1
            pontosJogador1 = 0
            --topoJogador1 = Topo(0,0)
            monte1:set(0,0)
            if #keyQueue == 1 then
                primeiro = 1
            end
            mensagem1 = 'queimou'
            
        end

        if char == 'backspace' then
            monte = monte + pontosJogador2
            pontosJogador2 = 0
            --topoJogador2 = Topo(0,0)
            monte2:set(0,0)
            if #keyQueue == 1 then
                primeiro = 2
            end
            -- render mensagem
            mensagem2 = 'queimou'     
        end
    end
    if monte2.numero ~= contador then
        if char == 'e' then
            monte = monte + pontosJogador1
            pontosJogador1 = 0
            --topoJogador1 = Topo(0,0)
            monte1:set(0,0)
            if #keyQueue == 1 then
                primeiro = 1
            end
            mensagem1 = 'queimou'
            
        end

        if char == 'rshift' then
            monte = monte + pontosJogador2
            pontosJogador2 = 0
            --topoJogador2 = Topo(0,0)
            monte2:set(0,0)
            if #keyQueue == 1 then
                primeiro = 2
            end
            -- render mensagem
            mensagem2 = 'queimou'     
        end
    end

end