--[[ Author - Clara Schons Theisen ]]--



Class = require 'class'
require 'Mao'
require 'Baralho'

require 'StateMachine'
require 'states/BaseState'
require 'states/CountDownState'
require 'states/MenuState'
require 'states/TesteState'
require 'states/PointState'

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
    topoJogador1 = 0
    mensagem1 = ''
   -- monte do jogador 1

    -- JOGADOR 2
    jogador2 = Mao(2)
    pontosJogador2 = 0
    topoJogador2 = 0
    mensagem2 = ''
   -- monte do jogador 2

    -- BARALHO
    baralho = Baralho(cardX,cardY,cardWidth,cardHeight,0,1)

    -- GLOBAIS
    monte = 0
    count = 0
    contador = 0

    primeiro = 1

    -- inicialização das fontes
    numFont = love.graphics.newFont('coolslim/Coolslim.otf', 100)
    mediumFont = love.graphics.newFont('slim_chef/Slim Chef -personal use.ttf', 14)
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
    if #keyQueue == 0 then
        if key == 'a' or key == 'd' or key == 'e' then
            primeiro = 1
        else
            primeiro = 2
        end
    end
    table.insert(keyQueue, key)

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

    if monte > 0 then
        baralho:render()
    end
    gStateMachine:render()
    -- if topoJogador1 > 0 then
        -- render monte1
    -- if topoJogador2 > 0 then
        -- render monte2

    -- fazer render em ordem de tecla pressionada
    -- se jogador 1 antes
    
    -- if primeiro == 1 then 
         jogador1:render()
         jogador2:render()
    -- else
    --     jogador2:render()
    --     jogador1:render()
    -- end


    love.graphics.setColor(1,1,1,1)

    -- mensagens

    love.graphics.setFont(mediumFont)
    if mensagem1 ~= '' then
        love.graphics.print(mensagem1, 20, 600)
    end

    if mensagem2 ~= '' then
        love.graphics.print(mensagem2, 520, 600)
    end

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