local Vector = require "vector"
local objects = require "objects"
local images = require "images"

local planet = {}

function planet.load()

	objects.add({position=Vector(300,300),shape={type="rectangle",size=Vector(20,60)},density=1,bodyType="dynamic",drawing={type="image",image=images.player}})
	objects[1].body:setFixedRotation(true)

	local planetDepth = 1000

	local numSegments = 100
	local w,h = 500,50
	local x,y = -w*numSegments*0.5,800
	local r = 0
	for i=1,numSegments do
		local pr = r
		r = math.random(1,3)

		if r==2 then--Flat
			if pr==1 then y=y+h end
		elseif r==3 then--Up
			if pr~=1 then y=y-h end
			objects.add({position=Vector(x,y),shape={type="polygon",vertices={0,h,w,0,w,h}},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}})
		else--Down
			if pr==1 then y=y+h end
			objects.add({position=Vector(x,y),shape={type="polygon",vertices={0,h,0,0,w,h}},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}})
		end

		if r~=2 then
			objects.add({position=Vector(x,y),shape={type="polygon",vertices={0,h,w,h,0,planetDepth,w,planetDepth}},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}})
		else
			objects.add({position=Vector(x,y),shape={type="polygon",vertices={0,0,w,0,0,planetDepth,w,planetDepth}},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}})
		end
		x=x+w
	end

	objects[1].body:setY(objects[math.floor(#objects/2)].body:getY()) --Moves player to surface

	objects.add({position=Vector(40,0),shape={type="polygon",vertices={0,0,400,0,300,100,50,50}},density=0.5,bodyType="dynamic",drawing={type="texture",texture=images.block}})
	objects.add({position=Vector(60,0),shape={type="circle",radius=100},density=0.2,bodyType="dynamic",drawing={type="image",image=images.planet}})

	for i=1,20 do
		objects.add({position=Vector(i*50,550),shape={type="rectangle",size=Vector(20,100)},density=0.5,bodyType="dynamic",drawing={type="image",image=images.block}}) --Blocks
	end
end

function planet.update(dt)
	cameraPos = Vector(objects[1].body:getX()-screen_width/2,objects[1].body:getY()-screen_height/2)
end

function planet.draw()

end

return planet