Class = require 'class'
require 'Mao'
require 'Baralho'

require 'StateMachine'
require 'states/BaseState'
require 'states/InicioState'
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
    
    }
    
    -- inicializacao janela
    love.window.setTitle('Reflexo')
    
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- tamanho e posiçao das cartas
    cardWidth = 100
    cardHeight = 150
    cardX = WINDOW_WIDTH/2 - cardWidth/2
    cardY = WINDOW_HEIGHT/3 - cardHeight/2


    -- tamanho e posicao 
    handsWidth = 70
    handsHeight = 100

    hand1X = WINDOW_WIDTH/4 - handsWidth/2
    hand1Y = WINDOW_HEIGHT - handsHeight - 30
    hand2X = WINDOW_WIDTH *3/4 - handsWidth/2
    hand2Y = WINDOW_HEIGHT - handsHeight - 30
    
    -- inicializaçao dos elementos
    jogador1 = Mao(hand1X,hand1Y,1)
    jogador2 = Mao(hand2X,hand2Y,2)
    baralho = Baralho(cardX,cardY,cardWidth,cardHeight,0,1)

    -- pontuaçao inicial e parametros zerada
    contador = 0
    dtotal = 0
    monte = 0
    pontosJogador1 = 0
    pontosJogador2 = 0
    topoJogador1 = 0
    topoJogador2 = 0
    mensagem1 = ''
    mensagem2 = ''

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['inicio'] = function() return InicioState() end,
        ['teste'] = function() return TesteState() end,
        ['point'] = function() return PointState() end,
        ['end'] = function () return EndState() end
    }
    gStateMachine:change('inicio')

    love.keyboard.keysPressed = {}
    keyQueue = {}

    
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
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

    love.graphics.clear(126/255, 161/255, 255/255, 1)
    baralho:render()
    -- fazer render em ordem de tecla pressionada


    -- se jogador 1 antes
    jogador1:render()
    jogador2:render()
    -- else
        jogador2:render()
        jogador1:render()

    love.graphics.setColor(1,1,1,1)
    love.graphics.print(tostring(contador), WINDOW_WIDTH*2/3, WINDOW_HEIGHT/4)
    love.graphics.print(tostring(monte), WINDOW_WIDTH*2/3, WINDOW_HEIGHT*2/4)
    love.graphics.print(tostring(pontosJogador1) .. " vs " .. tostring(pontosJogador2), WINDOW_WIDTH*2/3, WINDOW_HEIGHT*3/4)
    gStateMachine:render()
end


function inTable(table, val)
    for i, v in ipairs(table) do
        if v == val then
            return true
        end
    end
    return false
end