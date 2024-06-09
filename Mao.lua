Mao = Class{}

local MAO1_IMAGE = love.graphics.newImage('img/mao1.png')
local MAO2_IMAGE = love.graphics.newImage('img/mao2.png')


function Mao:init(x,y,mao)

    if mao == 1 then
        self.image = MAO1_IMAGE
        self.dx = 150/0.1
        self.dy=-260/0.1
    else 
        self.image = MAO2_IMAGE
        self.dx = -150/0.1
        self.dy=-260/0.1
    end
    
    self.x = x
    self.y = y
    self.largura = 70
    self.altura = 100



    self.tempo = 0
    self.inicialX = x 
    self.inicialY = y
    self.tapa = false
    self.duracao = 0.1
    self.wait3s = false

end

function Mao:reset(dt)
    -- reseta a posição da mão
    self.x = self.inicialX
    self.y = self.inicialY

end

function Mao:animar()
    self.tempo = 0
    self.tapa = true
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

    if self.wait3s then
        self.tempo = self.tempo + dt
        if self.tempo >= 1 then
            self.wait3s = false
            self:reset()
        end
    end


end

function Mao:render()
    love.graphics.draw(self.image, self.x, self.y)
end
