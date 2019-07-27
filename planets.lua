local Vector = require "vector"
local images = require "images"

local planets = {}

function planets.loadWorlds()
	numWorlds = 5
	for i=1,numWorlds do
		planets[i] = {gravity = 64*math.random(5,20), airResistance=1, sea={resistance=1,level=1000,waveSpeed=1}, bounds={start=-1000,stop=8000}}
	end
end

function planets.loadObjects()
	for i=1,#planets do
		objects.add({recolorUnderwater=true,worldNum=i,position=Vector(40,0),shape={type="polygon",vertices={0,0,400,0,300,100,50,50}},density=0.5,bodyType="dynamic",drawing={type="texture",texture=images.block}})
		objects.add({recolorUnderwater=true,worldNum=i,position=Vector(60,0),shape={type="circle",radius=100},density=0.2,bodyType="dynamic",drawing={type="image",image=images.planet}})

		for j=1,20 do
			objects.add({recolorUnderwater=true,worldNum=i,position=Vector(j*50,550),shape={type="rectangle",size=Vector(20,100)},density=0.5,bodyType="dynamic",drawing={type="image",image=images.block}}) --Blocks
		end

		local planetDepth = planets[currentWorld].sea.level

		local numSegments = 100
		local w,h = 500,50
		local x,y = -w*numSegments*0.5,800
		local r = 0
		for j=1,numSegments do
			local pr = r
			r = math.random(1,3)
			if r==2 then--Flat
				if pr==1 then y=y+h end
			elseif r==3 then--Up
				if pr~=1 then y=y-h end
				objects.add({worldNum=i,position=Vector(x,y),shape={type="polygon",vertices={0,h,w,0,w,h}},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}})
			else--Down
				if pr==1 then y=y+h end
				objects.add({worldNum=i,position=Vector(x,y),shape={type="polygon",vertices={0,h,0,0,w,h}},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}})
			end

			if r~=2 then
				objects.add({worldNum=i,position=Vector(x,y),shape={type="polygon",vertices={0,h,w,h,0,planetDepth,w,planetDepth}},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}})
			else
				objects.add({worldNum=i,position=Vector(x,y),shape={type="polygon",vertices={0,0,w,0,0,planetDepth,w,planetDepth}},density=0.5,bodyType="static",drawing={type="texture",texture=images.dirt}})
			end
			if j == 1 or j == numSegments then
				objects.add({worldNum=i,position=Vector(x+250,y+150),shape={type="rectangle",size=Vector(225,143)},density=0.5,bodyType="static",drawing={type="image",image=images.dangerOfDeath}})
			end
			x=x+w
		end
	end
end

function planets.changeWorld(worldNum)
	currentWorld = worldNum
	for i=1,#objects do
		local object = objects[i]
		if object.worldNum == worldNum then
			object.body:setActive(true)
		else
			object.body:setActive(false)
		end
	end
	world:setGravity(0,planets[worldNum].gravity)
end

function planets.update(dt)
	cameraPos = Vector(objects[1].body:getX()-screen_width/2,objects[1].body:getY()-screen_height/2)
end

function planets.draw()
	drawOcean(-50000,planets[currentWorld].sea.level,100000,1000,4)
end

function drawOcean(start,y,length,depth,detail)
	love.graphics.setColor(0,0,1)
	love.graphics.rectangle("fill",start,y-5,length,depth)
	love.graphics.setColor(1,1,1)
	drawSin(start,y-10,length,length*detail*0.01)
	love.graphics.setColor(0.2,0.2,1)
	drawSin(start,y,length,length*detail*0.01)
end

function drawSin(x,y,length,segments)
	local points = {}
	for i=1,segments do
		points[i*2-1] = i*(length/segments)+x
		points[i*2] = math.sin(i*(length/segments)*0.02+(timer*planets[currentWorld].sea.waveSpeed))*10+y
	end
	love.graphics.setLineWidth(10)
	love.graphics.line(points)
end

return planets