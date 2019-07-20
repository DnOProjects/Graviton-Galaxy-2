local Vector = require "vector"
local objects = require "objects"
local images = require "images"

local game = {}

function game.load()

	objects.add({position=Vector(325,800),shape={type="rectangle",size=Vector(2000,300)},density=0.5,bodyType="static",drawing={type="textured",texture=images.dirt}}) --Ground

	--let's create a ball
	objects.ball = {}
	objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	objects.ball.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Attach fixture to body and give it a density of 1.
	objects.ball.fixture:setRestitution(0.9) --let the ball bounce

	--let's create a couple blocks to play around with
	for i=1,20 do
		objects.add({position=Vector(i*50,550),shape={type="rectangle",size=Vector(20,100)},density=0.5,bodyType="dynamic",drawing={type="textured",texture=images.dirt}}) --Blocks
	end

end

function game.update(dt)

end

function game.draw()

	if inGame == true then
		love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to a nice blue

		love.graphics.setColor(0.76, 0.18, 0.05) --set the drawing color to red for the ball
		love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
	else
		love.graphics.setBackgroundColor(0, 0, 0)
	end
	
end

return game