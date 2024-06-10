Mao = Class{}

local MAO1_IMAGE = love.graphics.newImage('img/mao1.png')
local MAO2_IMAGE = love.graphics.newImage('img/mao2.png')


function Mao:init(x,y,mao)

    if mao == 1 then
        self.image = MAO1_IMAGE
        self.dx = 150/0.1
        self.dy=-260/0.1
        self.ataque = 'a'
        self.defesa = 'd'
        self.ataque_inimigo = 'e'
    else 
        self.image = MAO2_IMAGE
        self.dx = -150/0.1
        self.dy=-260/0.1
        self.ataque = 'return'
        self.defesa = 'rshift'
        self.ataque_inimigo = 'backspace'
    end
    
    self.x = x
    self.y = y
    self.largura = 70
    self.altura = 100



    self.tempo = 0
    self.inicialX = x 
    self.inicialY = y
    self.tapa = false
    self.bloqueio = false
    self.inimigo = false

    self.duracao = 0.1

    self.wait3s = false

    self.free = true

end

function Mao:reset(dt)
    -- reseta a posição da mão
    self.x = self.inicialX
    self.y = self.inicialY
    self.free = true

end


function Mao:update(dt)

    if self.tapa then
        self.tempo = self.tempo + dt
        self.y = self.y + self.dy * dt
        self.x = self.x + self.dx * dt
        if self.tempo >= self.duracao then
            self.wait3s = true
            self.tempo= 0
            self.tapa = false
        end
    end

    if self.inimigo then
        self.tempo = self.tempo + dt
        self.x = self.x + self.dx * dt
        if self.tempo >= self.duracao then
            self.wait3s = true
            self.tempo= 0
            self.inimigo = false
        end
    end

    if self.bloqueio then
        self.tempo = self.tempo + dt
        self.x = self.x + self.dx * dt
        if self.tempo >= self.duracao then
            self.wait3s = true
            self.tempo= 0
            self.bloqueio = false
        end
    end

    if self.wait3s then
        self.tempo = self.tempo + dt
        if self.tempo >= 1 then
            self.wait3s = false
            self:reset()
        end
    end

    ---------------- ANIMAÇÕES -----------------
    if self.free then 
        -- se a tecla ataque for pressionada
        if love.keyboard.wasPressed(self.ataque) then
            self.tapa = true
            self.free = false
            self.tempo = 0
        elseif love.keyboard.wasPressed(self.defesa) then
            self.bloqueio = true
            self.free = false
            self.tempo = 0
        elseif love.keyboard.wasPressed(self.ataque_inimigo) then
            self.inimigo = true
            self.free = false
            self.tempo = 0
        end
    end

end

function Mao:render()
    love.graphics.draw(self.image, self.x, self.y)
end
