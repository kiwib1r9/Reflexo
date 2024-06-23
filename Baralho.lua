Baralho = Class{}

local copas = love.graphics.newImage('img/copas.jpg')
local paus = love.graphics.newImage('img/paus.jpg')
local espadas = love.graphics.newImage('img/espadas.jpg')
local diamante = love.graphics.newImage('img/diamante.jpg')

function Baralho:init(x,y, numero)
    self.x = x
    self.y = y
    self.numero = numero

    self.naipe = 0

end

function Baralho:muda()
    self.numero = math.random(1,13)
    self.naipe = math.random(1,4)

end

function Baralho:render()

    --love.graphics.setColor(1,0,128/255,1)
    love.graphics.setFont(cardNumFont)
    if self.naipe == 1 then
        love.graphics.draw(copas,self.x,self.y)
    elseif self.naipe == 2 then
        love.graphics.draw(paus,self.x,self.y)
    elseif self.naipe == 3 then
        love.graphics.draw(espadas,self.x,self.y)
    else
        love.graphics.draw(diamante,self.x,self.y)
    end
    -- love.graphics.draw(self.image,self.x,self.y)
    --love.graphics.rectangle('fill', self.x, self.y, self.largura, self.altura)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(tostring(self.numero), self.x + 30, self.y +20)
 
    


end