local fonts = require "fonts"
local ui = require "ui"
local input = require "input"
local audio = require "audio"
local objects = require "objects"
local planet = require "planet"
local images = require "images"
local Vector = require "vector"
local player = require "player"

function love.load()

	screen_width, screen_height = love.window.getDesktopDimensions(1)
	love.window.setMode(screen_width, screen_height, {borderless=true})
	cameraPos = Vector(0,0)

	math.randomseed(os.time())

	fonts.load()
	images.load()
	audio.load()
	input.load()
	ui.load()
	ui.initForGame()
	objects.load()

end

function love.update(dt)

	scale_X = love.graphics.getWidth()/screen_width
	scale_Y = love.graphics.getHeight()/screen_height

	input.update()
	audio.update()
	ui.update()

	if inGame == true and inGameMenu == false then
		objects.update(dt)
		player.update(dt)
		planet.update(dt)
	end

end

function love.draw()

	love.graphics.scale(scale_X,scale_Y)

	love.graphics.push()
	love.graphics.translate(-cameraPos[1],-cameraPos[2])
	objects.draw()
	love.graphics.pop()

	ui.draw()

	love.graphics.setFont(fontNasalization)
	love.graphics.setColor(1,1,1,1)

	love.graphics.print("FPS: "..love.timer:getFPS())
	if inGame == true then
		love.graphics.print("X: "..round(objects[1].body:getX()),1700,0)
		love.graphics.print("Y: "..round(objects[1].body:getY()),1700,40)
	end

end

function newGame()

	gameExists = true
	objects.purge()
	player.load()
	planet.load()

end