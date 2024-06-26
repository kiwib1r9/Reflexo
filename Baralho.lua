Baralho = Class{}

local copas = love.graphics.newImage('img/copas.jpg')
local paus = love.graphics.newImage('img/paus.jpg')
local espadas = love.graphics.newImage('img/espadas.jpg')
local diamante = love.graphics.newImage('img/diamante.jpg')

local copassmall = love.graphics.newImage('img/copassmall.jpg')
local paussmall = love.graphics.newImage('img/paussmall.jpg')
local espadassmall = love.graphics.newImage('img/espadassmall.jpg')
local diamantesmall = love.graphics.newImage('img/diamantesmall.jpg')

local smallFont = love.graphics.newFont('coolslim/Coolslim.otf', 20)
local cardNumFont = love.graphics.newFont('coolslim/Coolslim.otf', 70)

function Baralho:init(x,y,tipo)
    self.numero = 0
    self.naipe = 0
    self.tipo = tipo
    self.x = x
    self.y = y

    if tipo == 1 then
        self.copas = copas
        self.paus = paus
        self.espadas = espadas
        self.diamante = diamante
        self.textX = self.x + 30
        self.textY = self.y + 20
        --love.graphics.setFont(cardNumFont)
        self.fonte = cardNumFont
    else
        self.copas = copassmall
        self.paus = paussmall
        self.espadas = espadassmall
        self.diamante = diamantesmall   
        self.textX = self.x + 9
        self.textY = self.y + 6  
        --love.graphics.setFont(smallFont)
        self.fonte = smallFont
    end





end

function Baralho:set(x,y)
    self.numero = x
    self.naipe = y
end

function Baralho:muda()
    self.numero = math.random(1,13)
    self.naipe = math.random(1,4)

end

function Baralho:render()

    --love.graphics.setColor(1,0,128/255,1)
    if self.naipe == 1 then
        love.graphics.draw(self.copas,self.x,self.y)
    elseif self.naipe == 2 then
        love.graphics.draw(self.paus,self.x,self.y)
    elseif self.naipe == 3 then
        love.graphics.draw(self.espadas,self.x,self.y)
    elseif self.naipe == 4 then
        love.graphics.draw(self.diamante,self.x,self.y)
    end
    -- love.graphics.draw(self.image,self.x,self.y)
    --love.graphics.rectangle('fill', self.x, self.y, self.largura, self.altura)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(self.fonte)
    if self.numero ~= 0 then

        love.graphics.print(tostring(self.numero), self.textX, self.textY)
    end
 
    


end