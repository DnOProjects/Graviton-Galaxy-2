local game = {}

function game.load()

	love.physics.setMeter(64) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	objects = {} -- table to hold all our physical objects

	--let's create the ground
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	objects.ground.shape = love.physics.newRectangleShape(650, 50) --make a rectangle with a width of 650 and a height of 50
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body

	--let's create a ball
	objects.ball = {}
	objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	objects.ball.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Attach fixture to body and give it a density of 1.
	objects.ball.fixture:setRestitution(0.9) --let the ball bounce

	--let's create a couple blocks to play around with
	objects.block1 = {}
	objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
	objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
	objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

	objects.block2 = {}
	objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
	objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
	objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)


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
		love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
		love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
	else
		love.graphics.setBackgroundColor(0, 0, 0)
	end
	
end

return game