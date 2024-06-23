MenuState = Class{__includes = BaseState}


local title = love.graphics.newImage('img/title.jpg')
local play = love.graphics.newImage('img/playbtn.png')
local tutorial = love.graphics.newImage('img/tutorialbtn.png')
local sair = love.graphics.newImage('img/exitbtn1.png')

function MenuState:init()
    jogar = false
    self.title = title
    self.play = play
    self.tutorial = tutorial
    self.sair = sair

    -- Calcula a posição do texto para centralizá-lo
    self.titleWidth = (self.title):getWidth()
    self.playWidth = (self.play):getWidth()
    self.playHeight = (self.play):getHeight()
    self.tutorialWidth = (self.tutorial):getWidth()
    self.tutorialHeight = (self.tutorial):getHeight()
    self.sairWidth = (self.sair):getWidth()
    self.sairHeight = (self.sair):getHeight()


    self.titleX = WINDOW_WIDTH / 2 - self.titleWidth / 2
    self.titleY = 40

    self.playX = WINDOW_WIDTH / 2 - self.playWidth / 2
    self.playY = 350

    self.tutorialX = WINDOW_WIDTH / 2 - self.tutorialWidth / 2
    self.tutorialY = 415

    self.sairX = WINDOW_WIDTH / 2 - self.sairWidth / 2
    self.sairY = 520


    self.menu = {
        ["jogar"] = { x = self.playX, y = self.playY, width = self.playWidth, height = self.playHeight, image = self.play},
        ["tutorial"] = { x = self.tutorialX, y = self.tutorialY, width = self.tutorialWidth, height = self.tutorialHeight, image = self.tutorial},
        ["sair"] = { x = self.sairX, y = self.sairY, width = self.sairWidth, height = self.sairHeight, image = self.sair} 
    }
    menu = self.menu


end

function MenuState:update(dt)
    

    mouseX, mouseY = love.mouse.getPosition()

    -- Verifica se o mouse está sobre alguma opção e ajusta o tamanho da imagem
    for name, option in pairs(self.menu) do

        if isMouseHovering(option) then
            option.scale = 1.25 -- Aumenta o tamanho da imagem quando o mouse está sobre ela

            -- Verificação específica para a opção "jogar"
            if name == "jogar" and jogador1.y > (option.y - option.height / 2) then
                jogador1:tap(dt)


            elseif name == "tutorial" and jogador2.y > (option.y + 20 - option.height / 2) then
                jogador2:tap(dt)

            elseif name == "sair" then
                jogador2:wave(dt)

            end

        else
            option.scale = 1.0 -- Tamanho normal
            if name == "jogar" then
                jogador1:reset()
 
            elseif name == "tutorial" then
                jogador2:reset()
            end

        end

    end
end

function MenuState:render()
    love.graphics.setFont(titleFont)
    love.graphics.draw(self.title, self.titleX, self.titleY)

     -- Desenha cada opção do menu com o tamanho ajustado
     for _, option in pairs(self.menu) do
        local scale = option.scale or 1.0
        local width = option.width * scale
        local height = option.height * scale
        local x = option.x + (option.width - width) / 2
        local y = option.y + (option.height - height) / 2
        love.graphics.draw(option.image, x, y, 0, scale, scale)
    end

end

