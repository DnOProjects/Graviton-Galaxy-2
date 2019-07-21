local ui = {}

local objects = require("objects")
local font = love.graphics.getFont()
local utf8 = require("utf8")

function ui.load()

	lineTimer = 0

	mouseX, mouseY = love.mouse.getPosition()

	backgrounds = {} --template {page,backgroundType,background}
	inGameMenuArray = {{}}
	buttonArray = {{}}
	printArray = {{}}
	sliderArray = {{}}

end

function ui.initForGame()

	menuPage = 1
	runPage = "inGame"
	inGame = false
	inGameMenu = false

	-- Base Menu

	ui.setMenuBackground({page=1,colour={0,0,0}})

	ui.addPrint(love.graphics.getWidth()/2-560,100,1,1,0,255,255,"Graviton Galaxy 2",1)
	ui.addButton(170,290,240,60,255,255,255,"Play",0,0,1,4)
	ui.addButton(170,400,240,60,255,255,255,"Options",0,0,1,2)
	ui.addButton(170,510,240,60,255,255,255,"Exit",0,0,1,"exit")

	ui.addPrint(love.graphics.getWidth()/2-560,100,1,1,0,255,255,"Graviton Galaxy 2",2)
	ui.addPrint(170,190,0.8,0.8,0,150,255,"Options",2)
	ui.addButton(170,290,240,60,255,255,255,"Volume",0,0,2,3)
	ui.addButton(170,400,240,60,255,255,255,"Fullscreen",0,0,2,"fullscreen")
	ui.addButton(170,510,240,60,255,255,255,"Back",0,0,2,1)

	ui.addPrint(love.graphics.getWidth()/2-560,100,1,1,0,255,255,"Graviton Galaxy 2",3)
	ui.addPrint(170,190,0.8,0.8,0,150,255,"Options - Volume",3)
	ui.addSlider(170,290,240,80,255,255,255,"Master",2,0,3,volume.master,6,11)
	ui.addSlider(170,400,240,80,255,255,255,"Music",4,0,3,volume.music,6,11)
	ui.addButton(170,510,240,60,255,255,255,"Back",0,0,3,2)

	ui.addPrint(love.graphics.getWidth()/2-560,100,1,1,0,255,255,"Graviton Galaxy 2",4)
	ui.addPrint(170,190,0.8,0.8,0,150,255,"Play",4)
	ui.addButton(170,290,240,60,255,255,255,"New Game",0,0,4,"new")
	ui.addButton(170,400,240,60,255,255,255,"Load Game",0,0,4,"run")
	ui.addButton(170,510,240,60,255,255,255,"Back",0,0,4,1)

	-- In-game Menu

	ui.addInGameMenu("escape",{"gameMenu1","gameMenu2","gameMenu3"})
	--ui.updateInGameMenu("i",{"inventory"})

	ui.setMenuBackground({page="inGame",colour={0.41,0.53,0.97}})

	ui.addButton(love.graphics.getWidth()/2-152,330,280,60,255,255,255,"Resume",1,0,"gameMenu1","run")
	ui.addButton(love.graphics.getWidth()/2-152,430,280,60,255,255,255,"Options",1,0,"gameMenu1","gameMenu2")
	ui.addButton(love.graphics.getWidth()/2-152,530,280,60,255,255,255,"Back to menu",2,0,"gameMenu1",1)
	ui.addButton(love.graphics.getWidth()/2-152,630,280,60,255,255,255,"Exit",3,0,"gameMenu1","exit")

	ui.addButton(love.graphics.getWidth()/2-152,330,280,60,255,255,255,"Volume",1,0,"gameMenu2","gameMenu3")
	ui.addButton(love.graphics.getWidth()/2-152,430,280,60,255,255,255,"Fullscreen",1,0,"gameMenu2","fullscreen")
	ui.addButton(love.graphics.getWidth()/2-152,530,280,60,255,255,255,"Back",2,0,"gameMenu2","gameMenu1")

	ui.addSlider(love.graphics.getWidth()/2-152,330,280,80,255,255,255,"Master",1,0,"gameMenu3",volume.master,6,11)
	ui.addSlider(love.graphics.getWidth()/2-152,430,280,80,255,255,255,"Music",1,0,"gameMenu3",volume.music,6,11)
	ui.addButton(love.graphics.getWidth()/2-152,530,280,60,255,255,255,"Back",2,0,"gameMenu3","gameMenu2")

	-- Inventory

	ui.addButton(love.graphics.getWidth()/2-152,330,280,60,255,255,255,"Resume",1,0,"i","run")

end

function ui.updateSliders()

	for i=1,#sliderArray do
		if sliderArray[i][11] == menuPage then
			if sliderArray[i][8] == "Master" then
				volume.master = sliderArray[i][12]
			elseif sliderArray[i][8] == "Music" then
				volume.music = sliderArray[i][12]
			end
		else
			if sliderArray[i][8] == "Master" then
				sliderArray[i][12] = volume.master
			elseif sliderArray[i][8] == "Music" then
				sliderArray[i][12] = volume.music
			end
		end
	end

end

function ui.updateInGameMenus()

	for i=1,#inGameMenuArray do
		if inGame == true then
			if love.keyboard.isDown(inGameMenuArray[i].key) == true then
				if canOpenMenu == true then
					inGameMenuArray[i].open = not inGameMenuArray[i].open
					canOpenMenu = false
				end
				if inGameMenuArray[i].open == true then
					menuPage = inGameMenuArray[i].pages[1]
				elseif inGameMenuArray[i].open == false then
					menuPage = runPage
				end
			elseif love.keyboard.isDown(inGameMenuArray[i].key) == false then
				canOpenMenu = true
			end
		end
	end

end

function ui.addInGameMenu(key,pages)

	inGameMenuArray[#inGameMenuArray]={key=key,pages=pages,open=false}

end

function ui.addButton(x,y,xsize,ysize,r,g,b,text,textx,texty,page,action)

	if action == "inputText" then
		buttonArray[#buttonArray+1]={x,y,xsize,ysize,r,g,b,text,textx,texty,page,action,""}
	else
		buttonArray[#buttonArray+1]={x,y,xsize,ysize,r,g,b,text,textx,texty,page,action}
	end

end

function ui.addPrint(x,y,xsize,ysize,r,g,b,text,page,action)

	printArray[#printArray+1]={x,y,xsize,ysize,r,g,b,text,page,action}

end

function ui.addSlider(x,y,xsize,ysize,r,g,b,text,textx,texty,page,sliderValue,sliderWidth,sliderHeight)

	-- sliderWidth must be even as it is halved
	-- sliderHeight must be odd as the 3 from the slider line is odd

	sliderArray[#sliderArray+1]={x,y,xsize,ysize,r,g,b,text,textx,texty,page,sliderValue,sliderWidth,sliderHeight}

end

function rgb(r, g, b)

	return r/255, g/255, b/255

end

function drawButton()

	love.graphics.setFont(fontNasalization)
	for i=1,#buttonArray do
		if buttonArray[i][11] == menuPage then
			if mouseX > scale_X*buttonArray[i][1] and mouseX < scale_X*(buttonArray[i][1]+buttonArray[i][3]) and mouseY > scale_Y*buttonArray[i][2] and mouseY < scale_Y*(buttonArray[i][2]+buttonArray[i][4]) then
		    	love.graphics.setColor(rgb(buttonArray[i][5]-150, buttonArray[i][6]-150, buttonArray[i][7]-150))
		    else
		        love.graphics.setColor(rgb(buttonArray[i][5], buttonArray[i][6], buttonArray[i][7]))
		    end
		    love.graphics.rectangle("fill", buttonArray[i][1], buttonArray[i][2], buttonArray[i][3], buttonArray[i][4])
		    love.graphics.setColor(rgb(0, 0, 0))
		    love.graphics.rectangle("line", buttonArray[i][1], buttonArray[i][2], buttonArray[i][3], buttonArray[i][4])
		    if buttonArray[i][12] == "inputText" or buttonArray[i][12] == "typing" then
		    	love.graphics.print(buttonArray[i][8], buttonArray[i][1]+buttonArray[i][9]+10, buttonArray[i][2]+buttonArray[i][10]+10, 0, 3, 3)
		    	love.graphics.setColor(rgb(255, 255, 255))
		    	love.graphics.rectangle("fill", buttonArray[i][1]+font:getWidth(buttonArray[i][8])*3+10, buttonArray[i][2]+5, -font:getWidth(buttonArray[i][8])*3-10+buttonArray[i][3]-5, buttonArray[i][4]-10)
		    else
			    --NOTE : Text centralisation doesn't work amazingly so use textx and texty to get it right vv
			    love.graphics.print(buttonArray[i][8], buttonArray[i][1]+buttonArray[i][3]/2-font:getWidth(buttonArray[i][8])*1.5-5+buttonArray[i][9], buttonArray[i][2]+buttonArray[i][4]/2-20+buttonArray[i][10])
			end
		end
	end

end

function drawInputText()

	love.graphics.setFont(fontNasalization)
	for i=1,#buttonArray do
		if buttonArray[i][11] == menuPage then
			love.graphics.setColor(rgb(0, 0, 0))
	    	if buttonArray[i][12] == "typing" then
	    		if (love.mouse.isDown(1) == true and (mouseX < scale_X*buttonArray[i][1] or mouseX > scale_X*(buttonArray[i][1]+buttonArray[i][3]) or mouseY < scale_Y*buttonArray[i][2] or mouseY > scale_Y*(buttonArray[i][2]+buttonArray[i][4]))) or menuPage ~= buttonArray[i][11] then
					buttonArray[i][12] = "inputText" 
					lineTimer = 1
				end
	    		lineTimer = lineTimer - 0.05
	    		if lineTimer <= 0 then
	    			if buttonArray[i][13] == "" then
						love.graphics.print("|",buttonArray[i][1]+string.len(buttonArray[i][8])*22+font:getWidth(buttonArray[i][13])*3+string.len(buttonArray[i][13])*5-4,buttonArray[i][2]+1, 0, 3.6, 3.63)
					else
						love.graphics.print("|",buttonArray[i][1]+string.len(buttonArray[i][8])*22+font:getWidth(buttonArray[i][13])*3+string.len(buttonArray[i][13])*5-10,buttonArray[i][2]+1, 0, 3.6, 3.63)
					end
				end
				if lineTimer <= -1 then
					lineTimer = 1
				end
			end
			if buttonArray[i][12] == "inputText" or buttonArray[i][12] == "typing" then
				love.graphics.print(buttonArray[i][13],buttonArray[i][1]+font:getWidth(buttonArray[i][8])*3+10,buttonArray[i][2]+10, 0, 3.6, 3.63)
			end
		end
	end

end

function drawPrintText()

	love.graphics.setFont(fontStarCruiser)
	for i=1,#printArray do
		if printArray[i][9] == menuPage then
			love.graphics.setColor(rgb(printArray[i][5], printArray[i][6], printArray[i][7]))
			love.graphics.print(printArray[i][8],printArray[i][1],printArray[i][2],0,printArray[i][3],printArray[i][4])
		end
	end

end

function drawSlider()

	love.graphics.setFont(fontNasalization)
	for i=1,#sliderArray do
		if sliderArray[i][11] == menuPage then
		    love.graphics.setColor(rgb(sliderArray[i][5], sliderArray[i][6], sliderArray[i][7]))
		    love.graphics.rectangle("fill", sliderArray[i][1], sliderArray[i][2], sliderArray[i][3], sliderArray[i][4])
		    love.graphics.setColor(rgb(0, 0, 0))
		    love.graphics.rectangle("line", sliderArray[i][1], sliderArray[i][2], sliderArray[i][3], sliderArray[i][4])
			--NOTE : Text centralisation doesn't work amazingly so use textx and texty to get it right vv
			love.graphics.print(sliderArray[i][8]..": "..sliderArray[i][12], sliderArray[i][1]+sliderArray[i][3]/2-font:getWidth(sliderArray[i][8]..": "..sliderArray[i][12])*1.5-5+sliderArray[i][9], sliderArray[i][2]+10+sliderArray[i][10])
			love.graphics.rectangle("line", sliderArray[i][1]+20, sliderArray[i][2]+sliderArray[i][4]-20, sliderArray[i][3]-40, 3)
			love.graphics.rectangle("fill", sliderArray[i][1]+20+((sliderArray[i][3]-40)/100)*sliderArray[i][12]-sliderArray[i][13]/2, sliderArray[i][2]+sliderArray[i][4]-(((sliderArray[i][14]-3)/2)+20), sliderArray[i][13], sliderArray[i][14])
		end
	end

end

function mousepressed()

	for i=1,#buttonArray do
		if buttonArray[i][11] == menuPage then
			if love.mouse.isDown(1) == true then
				if canClick == true then
					if mouseX > scale_X*buttonArray[i][1] and mouseX < scale_X*(buttonArray[i][1]+buttonArray[i][3]) and mouseY > scale_Y*buttonArray[i][2] and mouseY < scale_Y*(buttonArray[i][2]+buttonArray[i][4]) then
						if buttonArray[i][12] == "exit" then
				        	love.event.quit()
				        elseif buttonArray[i][12] == "run" then
				        	menuPage = runPage
				        	for i=1,#inGameMenuArray do
								inGameMenuArray[i].open = false
							end
				        elseif buttonArray[i][12] == "new" then
				        	menuPage = runPage
				        	objects.load()
				        	newGame()
				        elseif buttonArray[i][12] == "fullscreen" then
				        	local unusedWidth, unusedHeight, flags = love.window.getMode()
				        	if flags.borderless == true then love.window.setMode(1500, 900, {resizable=true,minwidth=800,minheight=600}) elseif flags.borderless == false then love.window.setMode(screen_width, screen_height, {borderless=true}) end
				        	canClick = false
				        elseif buttonArray[i][12] == "inputText" then
				        	buttonArray[i][12] = "typing"
				        	lineTimer = 0
				        elseif buttonArray[i][12] ~= "typing" then
				        	menuPage = buttonArray[i][12]
				            canClick = false
				        end
				        click:stop()
				        click:play()
				        canSlide = false
				    end
				end
			end
		end
	end

	for i=1,#sliderArray do
		if sliderArray[i][11] == menuPage then
			if love.mouse.isDown(1) == true then
				if canSlide == true then
					if mouseX > scale_X*(sliderArray[i][1]+10) and mouseX < scale_X*(sliderArray[i][1]+sliderArray[i][3]-10) and mouseY > scale_Y*((sliderArray[i][2]+sliderArray[i][4]-(((sliderArray[i][14]-3)/2)+20))-10) and mouseY < scale_Y*(((sliderArray[i][2]+sliderArray[i][4]-(((sliderArray[i][14]-3)/2)+20))+sliderArray[i][14])+10) then
						sliderArray[i][12] = round((mouseX-(sliderArray[i][1]+20))/((sliderArray[i][3]-40)/100))
						if sliderArray[i][12] < 0 then
							sliderArray[i][12] = 0
						elseif sliderArray[i][12] > 100 then
							sliderArray[i][12] = 100
						end
					end
				end
			end
		end
	end

	if love.mouse.isDown(1) == true then
		canClick = false
	else
		canClick = true
		canSlide = true
	end

end

function love.textinput(text)

	for i=1,#buttonArray do
		if buttonArray[i][12] == "typing" and buttonArray[i][1]+string.len(buttonArray[i][8])*22+font:getWidth(buttonArray[i][13])*3+string.len(buttonArray[i][13])*5-4 < buttonArray[i][1]+font:getWidth(buttonArray[i][8])*3+10-font:getWidth(buttonArray[i][8])*3-10+buttonArray[i][3]-5 then
			buttonArray[i][13] = buttonArray[i][13] .. text
		end
	end

end

function love.keypressed(key)

	for i=1,#buttonArray do
		if buttonArray[i][12] == "typing" then
		    if key == "backspace" then
		        local byteoffset = utf8.offset(buttonArray[i][13], -1)
		        if byteoffset then
		            buttonArray[i][13] = string.sub(buttonArray[i][13], 1, byteoffset - 1)
		        end
		    end
		end
	end

end

function drawMenuBackgrounds() --Image or colour

	for i=1,#backgrounds do
		if menuPage == backgrounds[i][1] then
			if backgrounds[i][2] == "colour" then
				love.graphics.setBackgroundColor(backgrounds[i][3][1], backgrounds[i][3][2], backgrounds[i][3][3])
			elseif backgrounds[i][2] == "image" then
				background = love.graphics.newImage(backgrounds[i][3])
				love.graphics.setColor(rgb(255,255,255))
				love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth()/background:getWidth(), love.graphics.getHeight()/background:getHeight())
			end
		end
	end

end

function ui.setMenuBackground(args)

	bType = "nil"
	bData = "nil"
	if args.image then 
		bType = "image"
		bData = args.image
	end

	if args.colour then 
		bType = "colour"
		bData = args.colour 
	end

	backgrounds[#backgrounds+1] = {args.page,bType,bData}

end

function ui.setPage(page)
	menuPage = page
end

function ui.getPage()
	return menuPage
end

function ui.getInputButtonText(ID)
	if buttonArray[ID+1][13] ~= nil then
		return buttonArray[ID+1][13]
	else
		return nil
	end
end

function ui.update()

	mouseX, mouseY = love.mouse.getPosition()
	mousepressed()

	ui.updateSliders()
	ui.updateInGameMenus()

	inGame = false

	if menuPage == runPage then
		inGame = true
		inGameMenu = false
	elseif menuPage == 1 then
		inGame = false
		for i=1,#inGameMenuArray do
			inGameMenuArray[i].open = false
		end
	end

	inGameMenu = false

	for i=1,#inGameMenuArray do
		if inGameMenuArray[i].open == true then
			inGameMenu = true
		end
		for j=1,#inGameMenuArray[i].pages do
			if menuPage == inGameMenuArray[i].pages[j] then
				inGame = true
			end
		end
	end

end

function ui.draw()

	drawMenuBackgrounds()
	drawButton()
	drawInputText()
	drawPrintText()
	drawSlider() 

end

function round(x)
	return (x + 0.5 - (x + 0.5) % 1)
end

return ui