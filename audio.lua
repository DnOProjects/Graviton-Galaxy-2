local audio = {}

function audio.load()

	tracks = {}

	fadeSpeed = 0.1

	testSources = {}
	testSources[1] = {
		love.audio.newSource("Sounds/test/drum1.ogg","static"),
		love.audio.newSource("Sounds/test/drum2.ogg","static"),
		love.audio.newSource("Sounds/test/drum3.ogg","static"),
	}
	testSources[2] = {
		love.audio.newSource("Sounds/test/melody1.ogg","static"),
		love.audio.newSource("Sounds/test/melody1.ogg","static"),
		love.audio.newSource("Sounds/test/melody3.ogg","static")
	}

	currentlyPlayingTest = {0,0} --0 = silence
	audio.startNewSegment()

end



function audio.update()

	fadeTracks()

	local segmentLength = 2

	--Fade out
	if currentlyPlayingTest[2]~=0 then
		testSources[2][currentlyPlayingTest[2]]:setVolume(1.7-(testSources[2][currentlyPlayingTest[2]]:tell("seconds")/segmentLength))
	end

	--Check if has ended
	if (currentlyPlayingTest[1]~=0 and (testSources[1][currentlyPlayingTest[1]]:tell("seconds")>segmentLength)) then
		audio.startNewSegment()
	end
	if
		(currentlyPlayingTest[2]~=0 and (testSources[2][currentlyPlayingTest[2]]:tell("seconds")>segmentLength))
	then
		audio.startNewSegment()
	end


end

function audio.startNewSegment()
	--Start new segment
	local done = false
	local oldA = currentlyPlayingTest[1]
	local a,b = 0,0
	while not done do
		a,b = math.random(0,3),math.random(0,3)
		if math.random(1,4)~=1 then a = oldA end
		if a~=0 or b~=0 then done = true end
	end	
	currentlyPlayingTest = {a,b}
	if a~=0 then
		testSources[1][a]:stop()
		testSources[1][a]:play()
	end
	if b~=0 then
		testSources[2][b]:stop()
		testSources[2][b]:play()
	end
end

function audio.newTrack(ID,track)

	tracks[ID] = {love.audio.newSource(track),"none"} --track,fade

end

function audio.play(ID)

	tracks[ID][1]:play()

end

function audio.stop(ID)

	tracks[ID][1]:rewind()
	tracks[ID][1]:stop()

end

function audio.volume(ID,volume)

	tracks[ID][1]:setVolume(volume)

end

function audio.fade(ID,way)

	tracks[ID][2] = way

end

function audio.loop(ID,isLooping)

	tracks[ID][1]:setLooping(isLooping)

end

function fadeTracks()

	if #tracks > 0 then

		for i=1,#tracks do

			if not(tracks[i][2] == "none") then

				if tracks[i][2] == "out" then
					tracks[i][1]:setVolume(round(tracks[i][1]:getVolume()-(0.1*fadeSpeed),3))
				end

				if tracks[i][2] == "in" then
					tracks[i][1]:setVolume(round(tracks[i][1]:getVolume()+(0.1*fadeSpeed),3))
				end

				if tracks[i][1]:getVolume() > 1 or tracks[i][1]:getVolume() < 0.00001 then tracks[i][2] = "none" end
			end
		end
	end
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

return audio