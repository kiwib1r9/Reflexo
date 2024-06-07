Mao = Class{}

function Mao:init(x,y,largura,altura)
    self.x = x
    self.y = y
    self.largura = largura 
    self.altura = altura

    --self.dx=
    --self.dy=

end

function Mao:reset()
    -- reseta a posição da mão
    --self.x =
    --self.y =
end

function Mao:update(dt)
end

function Mao:render()
    love.graphics.setColor(1,0,128/255,1)
    love.graphics.rectangle('fill', self.x, self.y, self.largura, self.altura)
end
