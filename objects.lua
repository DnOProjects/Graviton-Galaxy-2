local Class = require "class"
local Vector = require "vector"

local Object = Class:derive("Object")

--[[DOCUMENTATION:
	
	Drawing types:
		Solid - draw a filled solid color
		Image - takes a similarly shaped image to the collision shape
		Texture - takes any image and matches it to the collision shape using repeating

]]

local drawHitboxes = false

function Object:new(args)
	self.worldNum = args.worldNum
	self.drawing = args.drawing
	self.body = love.physics.newBody(world,args.position[1],args.position[2],args.bodyType)
	self.body:setActive(false)
	self.shapeType = args.shape.type
	if args.shape.type == "rectangle" then
		self.shape = love.physics.newRectangleShape(args.shape.size[1],args.shape.size[2])
		self.size = args.shape.size --width and height
		self.position = args.position:take(Vector(self.size[1]/2,self.size[2]/2))--top left hand corner
	end
	if args.shape.type == "circle" then
		self.shape = love.physics.newCircleShape(args.shape.radius)
	end
	if args.shape.type == "polygon" then
		self.shape = love.physics.newPolygonShape(args.shape.vertices)
	end
	self.fixture = love.physics.newFixture(self.body,self.shape,args.density)
	if args.drawing.type == "texture" then
		self:generateImageCanvas()
	end
	self.toRemove = false
end

function Object:generateImageCanvas()
	--Generate mesh from shape
	local verticesA = {self.shape:getPoints()}
	local verticesB = {}

	local minX,minY = 0,0
	local maxX,maxY = 0,0
	
	for i=1,#verticesA/2 do
		local x,y = verticesA[i*2-1],verticesA[i*2]
		verticesB[i]={x,y,x/self.drawing.texture:getWidth(),y/self.drawing.texture:getHeight(),1,1,1}
		if x<minX then minX = x end
		if y<minY then minY = y end
		if x>maxX then maxX = x end
		if y>maxY then maxY = y end
	end

	local mesh = love.graphics.newMesh(verticesB,"fan","dynamic")
	--Applying texture
	self.drawing.texture:setWrap("repeat","repeat","repeat")
	mesh:setTexture(self.drawing.texture)
	--Creating blank canvas
	local canvas = love.graphics.newCanvas(maxX-minX,maxY-minY)
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setBlendMode("alpha","premultiplied")
    love.graphics.setColor(1,1,1,1)
    --Rendering the mesh to the canvas
    love.graphics.draw(mesh,-minX,-minY) --Such that the top left corner is at 0,0
    love.graphics.setCanvas()
    love.graphics.setBlendMode("alpha")
    self.drawing.image = canvas
end

function Object:draw()
	if self.drawing.type == "image" or self.drawing.type == "texture"then
		love.graphics.setColor(1,1,1)
		if self.shapeType == "rectangle" or self.shapeType == "circle" then --Physics describes origin as middle
			love.graphics.draw(self.drawing.image,self.body:getX(),self.body:getY(),self.body:getAngle(),1,1,self.drawing.image:getWidth()/2,self.drawing.image:getHeight()/2)
		elseif self.shapeType == "polygon" then --Physics describes origin as first vertex
			love.graphics.draw(self.drawing.image,self.body:getX(),self.body:getY(),self.body:getAngle())
		elseif self.shapeType == "circle" then
			error("Circles cannot be textured: use a polygon or rectangle instead")
		end
	elseif self.drawing.type == "solid" then
		love.graphics.setColor(0.20, 0.20, 0.20)
		if self.shapeType == "rectangle" or self.shapeType == "polygon" then
			love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
		elseif self.shapeType == "circle" then
			love.graphics.circle("fill",self.body:getX(),self.body:getY(),self.shape:getRadius())
		end
	end
end

function Object:drawHitbox()
	love.graphics.setColor(1,1,1)
	if self.shapeType~="circle" then
		love.graphics.polygon("line",self.body:getWorldPoints(self.shape:getPoints()))
	else
		love.graphics.circle("line",self.body:getX(),self.body:getY(),self.shape:getRadius())
	end
end

function Object:remove()
	self.toRemove = true
end

----------------------

local objects = {}

function objects.load()
    love.physics.setMeter(64) --the length of a meter our worlds will be 64px
    world = love.physics.newWorld(0, 10*64, true)
end

function objects.add(args)
	objects[#objects+1] = Object(args)
end

function objects.update(dt)
    
    world:update(dt)
    
    objects.cleanup()

end

function objects.draw()
	if inGame == true then
		for i=1,#objects do
			if objects[i].worldNum == currentWorld then
				objects[i]:draw()
			end
		end
		if drawHitboxes then
			for i=1,#objects do
				if objects[i].worldNum == currentWorld then
					objects[i]:drawHitbox()
				end
			end
		end
	end
end

function objects.cleanup()
	for i=#objects,1,-1 do
		if objects[i].toRemove then
			table.remove(objects,i)
		end
	end
end

function objects.purge()
	for i=1,#objects do
		objects[i]:remove()
	end
	objects.cleanup()
end

function objects.getObjectsByWorld(worldNum)
	local toReturn = {}
	for i=1,#objects do
		if objects[i].worldNum == worldNum then
			toReturn[#toReturn+1] = objects[i]
		end
	end
	return toReturn
end

return objects