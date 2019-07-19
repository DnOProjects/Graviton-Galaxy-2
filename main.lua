local fonts = require "fonts"
local ui = require "ui"
local input = require "input"
local audio = require "audio"
local physics = require "physics"
local game = require "game"

function love.load()

	screen_width, screen_height = love.window.getDesktopDimensions(1)
	love.window.setMode(screen_width, screen_height, {borderless=true})

	math.randomseed(os.time())

	fonts.load()
	audio.load()
	input.load()
	ui.load()
	physics.load()

	ui.initForGame()
	game.load()

end

function love.update(dt)

	scale_X = love.graphics.getWidth()/screen_width
	scale_Y = love.graphics.getHeight()/screen_height

	input.update()
	audio.update()
	ui.update()
	physics.update(dt)

	ui.inGameMenu("escape",{"gameMenu1","gameMenu2","gameMenu3"})
	game.update(dt)

end

function love.draw()

	love.graphics.scale(scale_X,scale_Y)

	ui.draw()
	game.draw()

	-------------

	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
 
  	love.graphics.setColor(0.76, 0.18, 0.05) --set the drawing color to red for the ball
  	love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
 
  	love.graphics.setColor(0.20, 0.20, 0.20) -- set the drawing color to grey for the blocks
  	love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  	love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))

end