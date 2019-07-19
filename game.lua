local Vector = require "vector"
local physics = require "physics"

local game = {}

function game.load()

	--let's create the ground
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.ground.shape = love.physics.newRectangleShape(2000, 50) --make a rectangle with a width of 650 and a height of 50
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body

	--let's create a ball
	objects.ball = {}
	objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	objects.ball.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Attach fixture to body and give it a density of 1.
	objects.ball.fixture:setRestitution(0.9) --let the ball bounce

	--let's create a couple blocks to play around with
	for i=1,20 do
		physics.addRectangularObject({position=Vector(i*50,550),size=Vector(20,100),density=0.5,bodyType="dynamic"})
	end

end

function game.update(dt)

end

function game.draw()

	if inGame == true then
		love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to a nice blue
		love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
		love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

		love.graphics.setColor(0.76, 0.18, 0.05) --set the drawing color to red for the ball
		love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

		love.graphics.setColor(0.20, 0.20, 0.20) -- set the drawing color to grey for the blocks
		for i=1,#objects do
			local object = objects[i]
			love.graphics.polygon("fill", object.body:getWorldPoints(object.shape:getPoints()))
		end

	else
		love.graphics.setBackgroundColor(0, 0, 0)
	end
	
end

return game