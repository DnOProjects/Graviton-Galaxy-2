local fonts = require "fonts"
local ui = require "ui"
local input = require "input"
local audio = require "audio"

function love.load()
	
	menuPage = 0
	runPage = "inGame"
	inGame = false
	inGameMenuOpen = false

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

end

function love.draw()
	
	ui.draw()

end 