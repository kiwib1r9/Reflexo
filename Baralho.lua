Baralho = Class{}

function Baralho:init(x,y,largura,altura,numero,naipe)
    self.x = x
    self.y = y
    self.largura = largura 
    self.altura = altura
    self.numero = numero
    self.naipe = naipe
    --self.dx=
    --self.dy=

end

function Baralho:reset()
    -- reseta a posição da mão
    --self.x =
    --self.y =
end

function Baralho:update(dt)
    self.numero = math.random(1,13)
end

function Baralho:render()

    love.graphics.setColor(1,0,128/255,1)
    love.graphics.rectangle('fill', self.x, self.y, self.largura, self.altura)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(tostring(self.numero), self.x + 20, self.y +20)
end