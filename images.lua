local images = {}

function images.load()

	images.dirt = love.graphics.newImage("Images/dirt.png")
	images.block = love.graphics.newImage("Images/block.png")
	images.planet = love.graphics.newImage("Images/planet.png")
	images.player = love.graphics.newImage("Images/player.png")

end

return images