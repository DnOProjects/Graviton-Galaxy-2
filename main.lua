local fonts = require "fonts"
local ui = require "ui"
local input = require "input"
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
	input.load()
	ui.load()
	ui.initForGame()
	objects.load()

	timer = 0

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
		planets.update(dt)
	end

	timer = timer + dt

end

function love.draw()

	love.graphics.scale(scale_X,scale_Y)

	love.graphics.push()
	love.graphics.translate(-cameraPos[1],-cameraPos[2])
	drawOcean(-50000,1000,100000,1000,4)
	objects.draw()
	love.graphics.pop()

	ui.draw()

	love.graphics.setFont(fontNasalization)
	love.graphics.setColor(1,1,1,1)

	love.graphics.print("FPS: "..love.timer:getFPS())
	if inGame == true then
		love.graphics.print("X: "..round(objects[1].body:getX()),1700,0)
		love.graphics.print("Y: "..round(objects[1].body:getY()),1700,40)
		love.graphics.print("World: "..currentWorld,1700,80)
		love.graphics.print("#objs: "..#objects,0,40)
	end
end

function drawOcean(start,y,length,depth,detail)
	love.graphics.setColor(0,0,1)
	love.graphics.rectangle("fill",start,y-5,length,depth)
	love.graphics.setColor(1,1,1)
	drawSin(start,y-10,length,length*detail*0.01)
	love.graphics.setColor(0,0,1)
	drawSin(start,y,length,length*detail*0.01)
end

function drawSin(x,y,length,segments)
	local points = {}
	for i=1,segments do
		points[i*2-1] = i*(length/segments)+x
		points[i*2] = math.sin(i*(length/segments)*0.02+timer)*10+y
	end
	love.graphics.setLineWidth(10)
	love.graphics.line(points)
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