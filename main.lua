local fonts = require "fonts"
local ui = require "ui"
local input = require "input"
local audio = require "audio"

function love.load()

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

end

function love.draw()
	
	ui.draw()

end 