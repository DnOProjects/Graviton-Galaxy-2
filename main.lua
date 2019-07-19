local fonts = require "fonts"
local ui = require "ui"
local input = require "input"
local audio = require "audio"

function love.load()

	screen_width, screen_height = love.window.getDesktopDimensions(1)

	love.window.setMode(screen_width, screen_height, {borderless=true})

	math.randomseed(os.time())

	fonts.load()
	audio.load()
	input.load()
	ui.load()
	ui.initForGame()

end

function love.update(dt)

	input.update()
	audio.update()
	ui.update()
	ui.inGameMenu("escape",{"gameMenu1","gameMenu2","gameMenu3"})

end

function love.draw()

	love.graphics.scale(love.graphics.getWidth()/screen_width,love.graphics.getHeight()/screen_height)
	ui.draw()

end