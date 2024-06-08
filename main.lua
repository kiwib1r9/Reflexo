Class = require 'class'
require 'Mao'
require 'Baralho'

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
    jogador1 = Mao(hand1X,hand1Y,handsWidth,handsHeight,'blue')
    jogador2 = Mao(hand2X,hand2Y,handsWidth,handsHeight,'purple')
    baralho = Baralho(cardX,cardY,cardWidth,cardHeight,0,1)

    -- pontuaçao inicial e parametros zerada

    contador = 0
    dtotal = 0
    monte = 0
    pontosJogador1 = 0
    pontosJogador2 = 0

    love.keyboard.keysPressed = {}

    
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)

    jogador1:update(dt)
    dtotal = dtotal + dt
    if dtotal >= 2 then
        baralho:muda()
        dtotal = dtotal - 2
        contador = contador + 1
        monte = monte + 1
        if contador > 13 then
            contador = 1
        end
        sounds[contador]:play()
    end

    if love.keyboard.wasPressed('a') then
        -- animaçao de tapa
        jogador1:animar()
        if contador ~= baralho.numero then
            monte = monte + pontosJogador1
            pontosJogador1 = 0
            -- queimou!! perde todos os pontos para a mesa
            print("queimou")
        else 
            pontosJogador1 = pontosJogador1 + monte
            monte = 0
            print("attack")
            -- pontua o numero de cartas do monte
        end
    end
    love.keyboard.keysPressed = {}

 
end

function love.draw()
    love.graphics.clear(126/255, 161/255, 255/255, 1)
    baralho:render()
    jogador1:render()
    jogador2:render()
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(tostring(contador), WINDOW_WIDTH*2/3, WINDOW_HEIGHT/4)
    love.graphics.print(tostring(monte), WINDOW_WIDTH*2/3, WINDOW_HEIGHT*2/4)
    love.graphics.print(tostring(pontosJogador1), WINDOW_WIDTH*2/3, WINDOW_HEIGHT*3/4)
end