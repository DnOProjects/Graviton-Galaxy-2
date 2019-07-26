local images = {}

function images.load()

	love.graphics.setDefaultFilter("nearest","nearest",0)

	images.dirt = love.graphics.newImage("Images/dirt.png")
	images.block = love.graphics.newImage("Images/block.png")
	images.planet = love.graphics.newImage("Images/planet.png")
	images.player = love.graphics.newImage("Images/player.png")
	images.dangerOfDeath = love.graphics.newImage("Images/dangerOfDeath.png")

end

return images