local Vector = require "vector"
local objects = require "objects"
local images = require "images"

local player = {}

function player.load()

	objects.add({position=Vector(300,200),shape={type="rectangle",size=Vector(20,60)},density=1,bodyType="dynamic",drawing={type="image",image=images.player}})

end

function player.update(dt)

	if love.keyboard.isDown("d") then --press the d key to push to the right
        objects[1].body:applyForce(400, 0)
    elseif love.keyboard.isDown("a") then --press the a key to push to the left
        objects[1].body:applyForce(-400, 0)
    elseif love.keyboard.isDown("w") or love.keyboard.isDown("space") then
        objects[1].body:applyForce(0, -200)
    elseif love.keyboard.isDown("s") then
        objects[1].body:applyForce(0, 400)
    elseif love.keyboard.isDown("return") then --press the enter key to set in the air
        objects[1].body:setPosition(650/2, 650/2)
        objects[1].body:setLinearVelocity(0, 0) --we must set the velocity to zero to prevent a potentially large velocity generated by the change in position
    end

end

return player