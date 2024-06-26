Mao = Class{}

local MAO1 = love.graphics.newImage('img/mao11.png')
local MAO2 = love.graphics.newImage('img/mao22(2).png')

local waveAmplitude = 20
local waveFrequency = 20
local rotationAmplitude = math.rad(20)


function Mao:init(player)

    if player == 1 then
        self.image = MAO1
        self.width = (self.image):getWidth()
        self.height = (self.image):getHeight()
        self.x = WINDOW_WIDTH / 4 - self.width/2
        self.y = WINDOW_HEIGHT - 150
        self.fator = 1

        self.ataque = 'a'
        self.defesa = 'd'
        self.ataque_inimigo = 'e'

    else 
        self.image = MAO2
        self.width = (self.image):getWidth()
        self.height = (self.image):getHeight()
        self.x = WINDOW_WIDTH *3/ 4 - self.width/2
        self.y = WINDOW_HEIGHT - 130
        self.fator = -1

        self.ataque = 'return'
        self.defesa = 'rshift'
        self.ataque_inimigo = 'backspace'

    end

    self.tempo = 0
    self.rotation = math.rad(self.fator * 30)
    self.inicialX = self.x 
    self.inicialY = self.y
    self.dy = - 800
    self.dx=  self.fator * 400
    self.originX = 0
    self.originY = 0

    self.waveTime = 0

    self.tapa = false
    self.bloqueio = false
    self.inimigo = false

    self.duracao = 0.1


    self.free = false

end

function Mao:reset(dt)
    -- reseta a posição da mão
    self.x = self.inicialX
    self.y = self.inicialY
    self.originX = 0
    self.originY = 0
    self.rotation = math.rad(self.fator*30)
    
    --self.free = true

end

function Mao:tap(dt)
    self.y = self.y + self.dy * dt
    self.x = self.x + self.dx * dt
end

function Mao:wave(dt)

    self.waveTime = self.waveTime + dt

    self.x = self.x + math.sin(self.waveTime * waveFrequency) * waveAmplitude + 85

    self.y = self.y  + 60

    self.rotation = math.sin(self.waveTime * waveFrequency) * rotationAmplitude 

    self.originX = 45
    self.originY = self.height / 5


end


function Mao:update(dt)

    if self.tapa then
        self.tempo = self.tempo + dt
        self.y = self.y - 1500 * dt
        self.x = self.x + self.fator * 1800 * dt
        if self.tempo >= self.duracao then
            self.tapa = false
        end
    end

    if self.inimigo then
        self.tempo = self.tempo + dt
        self.x = self.x + self.fator * 2100 * dt
        if self.tempo >= self.duracao then
            self.inimigo = false
        end
    end

    if self.bloqueio then
        self.tempo = self.tempo + dt
        self.x = self.x + self.fator * 1100 * dt
        if self.tempo >= self.duracao then
            self.bloqueio = false
        end
    end

    -- ---------------- ANIMAÇÕES -----------------
    if self.free then 
        -- se a tecla ataque for pressionada
        if love.keyboard.wasPressed(self.ataque) then
            self.free = false
            self.tapa = true
            self.tempo = 0
        elseif love.keyboard.wasPressed(self.defesa) then
            self.free = false
            self.bloqueio = true
            self.tempo = 0
        elseif love.keyboard.wasPressed(self.ataque_inimigo) then
            self.free = false
            self.inimigo = true
            self.tempo = 0
        end
    end

end

function Mao:render()

    -- Adiciona o movimento de aceno para a mão 2 e rotação oscilante


    love.graphics.draw(self.image, self.x, self.y, self.rotation, 1,1,self.originX, self.originY)


end
