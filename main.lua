local ui = require "ui"
local input = require "input"
local audio = require "audio"

function love.load()

	math.randomseed(os.time())
	
	menuPage = 0
	runPage = "inGame"
	inGame = false
	inGameMenuOpen = false

	audio.load()
	input.load()
	ui.load()

	ui.addButton(170,180,220,60,255,255,255,"Play",0,0,0,"run")
	ui.addButton(170,290,220,60,255,255,255,"Options",0,0,0,1)
	ui.addButton(170,510,220,60,255,255,255,"Exit",0,0,0,"exit")

	ui.addButton(170,180,240,60,255,255,255,"Volume:100",0,0,1,1)
	ui.addButton(170,290,240,60,255,255,255,"Fullscreen",0,0,1,"fullscreen")
	ui.addButton(170,400,220,60,255,255,255,"Back",0,0,1,0)

	ui.addButton(480,100,220,60,255,255,255,"Resume",5,0,"gameMenu1","run")
	ui.addButton(450,300,280,60,255,255,255,"Back to menu",5,0,"gameMenu1",0)
	ui.addButton(480,500,220,60,255,255,255,"Exit",2,0,"gameMenu1","exit")

end

function love.update(dt)
	
	input.update()
	audio.update()
	ui.update()

end

function love.draw()
	
	ui.draw()

end