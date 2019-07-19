local fonts = require "fonts"
local ui = require "ui"
local input = require "input"
local audio = require "audio"
local objects = require "objects"
local game = require "game"

function love.load()

	screen_width, screen_height = love.window.getDesktopDimensions(1)
	love.window.setMode(screen_width, screen_height, {borderless=true})

	math.randomseed(os.time())

	fonts.load()
	audio.load()
	input.load()
	ui.load()
	ui.initForGame()
	objects.load()
	game.load()

end

function love.update(dt)

	scale_X = love.graphics.getWidth()/screen_width
	scale_Y = love.graphics.getHeight()/screen_height

	input.update()
	audio.update()
	ui.update()
	ui.inGameMenu("escape",{"gameMenu1","gameMenu2","gameMenu3"})
	objects.update(dt)
	game.update(dt)

end

function love.draw()

	love.graphics.scale(scale_X,scale_Y)
	game.draw()
	ui.draw()

end