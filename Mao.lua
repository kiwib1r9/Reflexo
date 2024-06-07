Mao = Class{}

function Mao:init(x,y,largura,altura,color)
    self.x = x
    self.y = y
    self.largura = largura 
    self.altura = altura
    self.color = color

    --self.dx=
    self.dy=-300

end

function Mao:reset()
    -- reseta a posição da mão
    --self.x =
    --self.y =
end


function Mao:update(dt)
    self.y = self.y + self.dy*dt
end

function Mao:render()
    if self.color == 'blue' then
        love.graphics.setColor(151/255, 231/255, 1, 1)
    else 
        love.graphics.setColor(51/255, 47/255, 208/255, 1)
    end
    love.graphics.rectangle('fill', self.x, self.y, self.largura, self.altura)
end
