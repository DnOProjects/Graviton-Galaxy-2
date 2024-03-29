logic = require "logic"
local fonts = require "fonts"
local ui = require "ui"
local audio = require "audio"
objects = require "objects"
planets = require "planets"
local images = require "images"
local Vector = require "vector"
local player = require "player"

function love.load()

	currentWorld = 1

	screen_width, screen_height = love.window.getDesktopDimensions(1)
	love.window.setMode(screen_width, screen_height, {borderless=true})
	cameraPos = Vector(0,0)

	math.randomseed(os.time())

	fonts.load()
	images.load()
	audio.load()
	ui.load()
	ui.initForGame()
	objects.load()

	timer = 0

end

function love.update(dt)

	scale_X = love.graphics.getWidth()/screen_width
	scale_Y = love.graphics.getHeight()/screen_height

	audio.update()
	ui.update()

	if inGame == true and inGameMenu == false then
		objects.update(dt)
		player.update(dt)
		planets.update(dt)
		timer = timer + dt
	end

end

function love.draw()

	love.graphics.scale(scale_X,scale_Y)

	love.graphics.setFont(fontNasalization)
	love.graphics.setColor(1,1,1,1)

	if inGame == true then
		love.graphics.push()
		love.graphics.translate(-cameraPos[1],-cameraPos[2])
		planets.draw()
		objects.draw()
		love.graphics.pop()
	end

	ui.draw()

end

function newGame()

	gameExists = true
	objects.purge()

	planets.loadWorlds()
	player.load()
	planets.loadObjects()
	planets.changeWorld(1)
	player.land()

end