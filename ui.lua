local ui = {}

local font = love.graphics.getFont()
local utf8 = require("utf8")

function ui.load()

	lineTimer = 0

	mouseX, mouseY = love.mouse.getPosition()
	
	click = love.audio.newSource("Sounds/click.wav", "static")

	backgrounds = {} --template {page,backgroundType,background}
	buttonArray = {{}}
	printArray = {{}}

end

function ui.initForGame()

	ui.addPrint(love.graphics.getWidth()/2-500,100,7,7,0,255,255,"Graviton Galaxy 2",0)

	ui.addButton(170,290,220,60,255,255,255,"Play",0,0,0,"run")
	ui.addButton(170,400,220,60,255,255,255,"Options",0,0,0,1)
	ui.addButton(170,510,220,60,255,255,255,"Exit",0,0,0,"exit")

	ui.addButton(170,290,240,60,255,255,255,"Fullscreen",0,0,1,"fullscreen")
	ui.addButton(170,510,220,60,255,255,255,"Back",0,0,1,0)

	ui.addButton(480,100,220,60,255,255,255,"Resume",5,0,"gameMenu1","run")
	ui.addButton(450,300,280,60,255,255,255,"Back to menu",5,0,"gameMenu1",0)
	ui.addButton(480,500,220,60,255,255,255,"Exit",2,0,"gameMenu1","exit")

end

function ui.inGameMenu(key,inGameMenuPage)

	if inGame == true then
		if love.keyboard.isDown(key) == true then
			if canOpenMenu == true then
				inGameMenuOpen = not inGameMenuOpen
				canOpenMenu = false
			end
		elseif love.keyboard.isDown(key) == false then
			canOpenMenu = true
		end
		if inGameMenuOpen == true then
			menuPage = inGameMenuPage
		elseif inGameMenuOpen == false then
			menuPage = runPage
		end
		if menuPage == inGameMenuPage or menuPage == runPage then
			inGame = true
		else
			inGame = false
		end
	end

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

function rgb(r, g, b)

	return r/255, g/255, b/255

end

function drawButton()

	love.graphics.setFont(fontNasalization)
	for i=1,#buttonArray do
		if buttonArray[i][11] == menuPage then
			if mouseX > buttonArray[i][1] and mouseX < buttonArray[i][1]+buttonArray[i][3] and mouseY > buttonArray[i][2] and mouseY < buttonArray[i][2]+buttonArray[i][4] then
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
			    love.graphics.print(buttonArray[i][8], buttonArray[i][1]+buttonArray[i][3]/2-font:getWidth(buttonArray[i][8])*1.5-5+buttonArray[i][9], buttonArray[i][2]+buttonArray[i][4]/2-20+buttonArray[i][10], 0, 3, 3)
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
	    		if (love.mouse.isDown(1) == true and (mouseX < buttonArray[i][1] or mouseX > buttonArray[i][1]+buttonArray[i][3] or mouseY < buttonArray[i][2] or mouseY > buttonArray[i][2]+buttonArray[i][4])) or menuPage ~= buttonArray[i][11] then
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

function mousepressed()

	for i=1,#buttonArray do
		if buttonArray[i][11] == menuPage then
			if love.mouse.isDown(1) == true then
				if canClick == true then
					if mouseX > buttonArray[i][1] and mouseX < buttonArray[i][1]+buttonArray[i][3] and mouseY > buttonArray[i][2] and mouseY < buttonArray[i][2]+buttonArray[i][4] then
						if buttonArray[i][12] == "exit" then
				        	love.event.quit()
				        elseif buttonArray[i][12] == "run" then
				        	menuPage = runPage
				        elseif buttonArray[i][12] == "fullscreen" then
				        	if love.window.getFullscreen() == true then love.window.setFullscreen(false) elseif love.window.getFullscreen() == false then love.window.setFullscreen(true) end
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
				    end
				end
			elseif love.mouse.isDown(1) == false then
			    canClick = true
			end
		end
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
		for j=1,#backgrounds[i][1] do
			if menuPage == backgrounds[i][1][j] then
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

	if menuPage == runPage then
		inGame = true
		inGameMenuOpen = false
	elseif menuPage == 0 then
		inGame = false
		inGameMenuOpen = false
	end

end

function ui.draw()

	drawMenuBackgrounds()
	drawButton()
	drawInputText()
	drawPrintText()

end

return ui