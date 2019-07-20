local Vector = require "vector"
local objects = require "objects"
local images = require "images"

local game = {}

function game.load()

	objects.add({position=Vector(300,300),shape={type="circle",radius=20},density=1,bodyType="dynamic",drawing={type="solid"}})

	for i=1,10 do
		objects.add({position=Vector(300*i-300,800),shape={type="rectangle",size=Vector(800,300)},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}}) --Ground
		objects[i].body:setAngle(math.random(-10,10)/10)
	end

	objects.add({position=Vector(300,800),shape={type="rectangle",size=Vector(800,300)},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}}) --Ground
	objects.add({position=Vector(40,0),shape={type="polygon",vertices={0,0,400,0,300,100,50,50}},density=0.5,bodyType="dynamic",drawing={type="texture",texture=images.block}})
	objects.add({position=Vector(60,0),shape={type="circle",radius=100},density=0.2,bodyType="dynamic",drawing={type="image",image=images.planet}})

	for i=1,20 do
		objects.add({position=Vector(i*50,550),shape={type="rectangle",size=Vector(20,100)},density=0.5,bodyType="dynamic",drawing={type="image",image=images.block}}) --Blocks
	end
end

function game.update(dt)
	cameraPos = Vector(objects[1].body:getX()-screen_width/2,objects[1].body:getY()-screen_height/2)
end

function game.draw()

end

return game