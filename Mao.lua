Mao = Class{}

function Mao:init(x,y,largura,altura,color)
    self.x = x
    self.y = y
    self.largura = largura 
    self.altura = altura
    self.color = color

    self.dy=-1000
    self.tempo = 0
    self.inicialX = x 
    self.inicialY = y
    self.tapa = false
    self.duracao = 0.3

end

function Mao:reset()
    -- reseta a posição da mão
    self.x = self.inicialX
    self.y = self.inicialY
    self.tapa = false
end

function Mao:animar()
    self.tempo = 0
    self.tapa = true
end

function Mao:update(dt)
    if self.tapa then
        self.tempo = self.tempo + dt
        self.y = self.y + self.dy * dt
        if self.tempo >= self.duracao then
            self:reset()
        end
    end
end

function Mao:render()
    if self.color == 'blue' then
        love.graphics.setColor(151/255, 231/255, 1, 1)
    else 
        love.graphics.setColor(51/255, 47/255, 208/255, 1)
    end
    love.graphics.rectangle('fill', self.x, self.y, self.largura, self.altura)
end
