--vector start--
local vector = {}
vector.__index = vector

function round(x)
  if x%2 ~= 0.5 then
    return math.floor(x+0.5)
  end
  return x-0.5
end

function vector.new(x,y)
	return setmetatable({x = x or 0, y = y or 0},vector)
end

function vector:length()
	return math.sqrt((self.x*self.x) + (self.y*self.y))
end

function vector:dist(other)
	return math.sqrt((self.x-other.x)*(self.x-other.x) + (self.y-other.y)*(self.y-other.y))
end

function vector:norm()
	return vector.new(self.x/self:length(), self.y/self:length())
end
--vector end--
--actor start--
local actor = {}
actor.__index = actor

function actor.new(x, y, spd, imgsrc, w, h, frameRate, fpa, seqTotal)
	return setmetatable({
		pos = vector.new(x,y),
		destination = vector.new(x, y),
		speed = spd or 100,
		vel = 1,
		img = love.graphics.newImage(imgsrc),
		width = w,
		height = h,
		fps = frameRate,
		timeLapse = 0,
		frame = 0,
		frameCount = fpa,
		seq = 0,
		seqCount = seqTotal,
		quads = {}}, actor)
end

function actor:genQuads()
	for y=0, self.seqCount-1 do
		for x=0, self.frameCount[y+1] do
			self.quads[y..x] = love.graphics.newQuad(x*self.width, y*self.height, self.width, self.height, self.frameCount[1]*self.width, self.seqCount*self.height)
		end
	end
end

function actor:update(dt)
	self.timeLapse = self.timeLapse + dt
	if self.timeLapse >= 1/self.fps then
		self.frame = self.frame + 1
		self.timeLapse = 0
		if self.frame >= self.frameCount[self.seq+1] then
			self.frame = 0
			self.seq = 0
		end
	end

	if love.mouse.isDown('r') then
		self.destination.x = love.mouse.getX()
		self.destination.y = love.mouse.getY()
	end
	print(self.pos.x, self.pos.y, self.destination.x, self.destination.y)
	if round(self.pos.x) ~= self.destination.x  or round(self.pos.y) ~= self.destination.y then
		local dir = vector.new(self.destination.x - self.pos.x, self.destination.y - self.pos.y):norm()
		if math.abs(dir.x) > math.abs(dir.y) then
			if dir.x > 0 then
				self.seq = 4
			else
				self.seq = 3
			end
		elseif math.abs(dir.x) < math.abs(dir.y) then
			if dir.y > 0 then
				self.seq = 2
			else
				self.seq = 1
			end
		end
		if self.pos:dist(self.destination) < 30 then
			self.pos.x = self.pos.x + self.pos:dist(self.destination)*10*dt*dir.x
			self.pos.y = self.pos.y + self.pos:dist(self.destination)*10*dt*dir.y
		else
			self.pos.x = self.pos.x + self.speed*dt*dir.x
			self.pos.y = self.pos.y + self.speed*dt*dir.y
		end
	else
		self.seq = 0
	end
end

function actor:keypressed(key)
end

function actor:keyreleased(key)
end

function actor:mousepressed(x, y, button)
end

function actor:mousereleased(x, y, button)
end

function actor:draw()
	love.graphics.draw(self.img, self.quads[self.seq..self.frame], self.pos.x - self.width/2, self.pos.y - self.height/2)
end

function actor:idle()
end

function actor:engage()
end
--actor end--

--sub actor start--

--sub actor end--

function love.load()
	sapo = actor.new(150, 150, 300, "sapo.png", 32, 52, 3, {2, 2, 2, 2, 2, 2}, 5)
  	sapo:genQuads()
end

function love.update(dt)
	sapo:update(dt)
end

function love.keypressed(key)
	sapo:keypressed(key)
end

function love.keyreleased(key)
	sapo:keyreleased(key)
end

function love.mousepressed(x, y, button)
	sapo:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	sapo:mousepressed(x, y, button)
end

function love.draw()
	sapo:draw()
end

