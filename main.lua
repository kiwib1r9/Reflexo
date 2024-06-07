Class = require 'class'
require 'Mao'
require 'Baralho'

function love.load()

    -- random seed 
    math.randomseed(os.time())

    WINDOW_HEIGHT = 620
    WINDOW_WIDTH = 620

    cardWidth = 100
    cardHeight = 150
    cardX = WINDOW_WIDTH/2 - cardWidth/2
    cardY = WINDOW_HEIGHT/3 - cardHeight/2
    
    
    love.window.setTitle('Reflexo')
    
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    
    handWidth = 70
    handHeight = 100
    handX = WINDOW_WIDTH/2 - handWidth/2
    handY = WINDOW_HEIGHT - cardHeight - 30
    

    jogador1 = Mao(handX,handY,handWidth,handHeight)
    cartasJogador1 = 0

    
    baralho = Baralho(cardX,cardY,cardWidth,cardHeight,0,1)

    love.keyboard.keysPressed = {}


    contador = 1
    dtotal = 0
    monte = 0
    pontosJogador1 = 0

    
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

    dtotal = dtotal + dt
    if dtotal >= 2 then
        baralho:update(dt)
        dtotal = dtotal - 2
        contador = contador + 1
        monte = monte + 1
        if contador > 13 then
            contador = 1
        end
    end

    if love.keyboard.wasPressed('a') then
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
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(tostring(contador), WINDOW_WIDTH*2/3, WINDOW_HEIGHT/4)
    love.graphics.print(tostring(monte), WINDOW_WIDTH*2/3, WINDOW_HEIGHT*2/4)
    love.graphics.print(tostring(pontosJogador1), WINDOW_WIDTH*2/3, WINDOW_HEIGHT*3/4)
end