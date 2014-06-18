--actor start--------------------------------------------------------------------------------
actor = {}
actor.__index = actor

function actor.new(x, y, img, w, h, framesPerSeq, totalAnimations, framesPerSec)
	q = actor.genQuads(totalAnimations, framesPerSeq, w, h)
	return setmetatable({
		x = x or 0,								--Starting x
		y = y or 0,								--Starting y
		img = love.graphics.newImage(img),		--Source Image file
		w = w or 0,								--Width of individual sprites
		h = h or 0,								--Height of individual sprites
		quads = q,								--Table of source img sprite locations
		frame = 0,								--Starting frame to display
		frameTotal = framesPerSeq,				--Table of the amount of frames per each animations sequence
		seq = 0,								--Starting sequence to display
		seqTotal = totalAnimations,				--Total number of sequences
		fps = framesPerSec						--The amount of frames to be displayed per second
		}, actor)
end

function actor.genQuads(totalAnimations, frameTotal, width, height)
	quadTable = {}
	for y=0, totalAnimations do
		for x=0, frameTotal[y+1] do
			quadTable[y..x] = love.graphics.newQuad(x*width, y*height, width, height, width*frameTotal[y+1], height*totalAnimations)
		end
	end
end

function actor:draw()
	love.graphics.draw(self.img, self.x, self.y)
	love.graphics.print(self.x..self.y..self.seqTotal..self.fps, 100, 100)
end
--actor end----------------------------------------------------------------------------------

--scout start--------------------------------------------------------------------------------
scout = {}
scout.__index = function (table, key)
	if scout[key] then
		return scout[key]
	else
		return actor[key]
	end
end

function scout.new(spd, x, y, img, w, h, framesPerSeq, totalAnimations, framesPerSec)
	q = actor.genQuads(totalAnimations, framesPerSeq, w, h)
	return setmetatable({
		speed = spd or 0,						--Movement speed
		x = x or 0,								--Starting x
		y = y or 0,								--Starting y
		img = love.graphics.newImage(img),		--Source Image file
		w = w or 0,								--Width of individual sprites
		h = h or 0,								--Height of individual sprites
		quads = q,								--Table of source img sprite locations
		frame = 1,								--Starting frame to display
		frameTotal = framesPerSeq,				--Table of the amount of frames per each animations sequence
		seq = 0,								--Starting sequence to display
		seqTotal = totalAnimations,				--Total number of sequences
		fps = framesPerSec						--The amount of frames to be displayed per second
		}, scout)
end
--scout end----------------------------------------------------------------------------------

--monster start------------------------------------------------------------------------------
monster = {}
monster.__index = function (table, key)
	if monster[key] then
		return monster[key]
	else
		return monster[key]
	end
end

function monster.new(spd, x, y, img, w, h, framesPerSeq, totalAnimations, framesPerSec)
	q = actor.genQuads(totalAnimations, framesPerSeq, w, h)
	return setmetatable({
		speed = spd or 0,						--Movement speed
		x = x or 0,								--Starting x
		y = y or 0,								--Starting y
		img = love.graphics.newImage(img),		--Source Image file
		w = w or 0,								--Width of individual sprites
		h = h or 0,								--Height of individual sprites
		quads = q,								--Table of source img sprite locations
		frame = 1,								--Starting frame to display
		frameTotal = framesPerSeq,				--Table of the amount of frames per each animations sequence
		seq = 0,								--Starting sequence to display
		seqTotal = totalAnimations,				--Total number of sequences
		fps = framesPerSec						--The amount of frames to be displayed per second
		}, monster)
end
--monster end--------------------------------------------------------------------------------

--main start---------------------------------------------------------------------------------
function love.load()
	bloc = scout.new(200, 50, 50, "scoutSmall.png", 16, 16, {1,1,1,1,1}, 5, 3)
end

function love.update(dt)
end

function love.keypressed(key)
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
end

function love.mousepressed(x, y, button)
end

function love.draw()
	if bloc then
		bloc:draw()
	end
end