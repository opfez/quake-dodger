require("perspective")
require("player")
require("entity")

local canvas

resources = {}

function love.load()
	resources.tile = loadImage("tile.png")
	resources.missingTexture = loadImage("missing.png")

	canvas = love.graphics.newCanvas(love.graphics.getDimensions())
	canvas:setFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(0,0.2,0.4)
end

function love.update(dt)
	local effectiveSpeed = player.speed

	local a = love.keyboard.isDown("a")
	local d = love.keyboard.isDown("d")
	local w = love.keyboard.isDown("w")
	local s = love.keyboard.isDown("s")

	if (a and w) or (a and s) or (d and w) or (d and s) then
		effectiveSpeed = math.sin(math.pi / 4) * effectiveSpeed
	end

	if a then
		player.pos.x = player.pos.x - effectiveSpeed * dt
	end
	if d then
		player.pos.x = player.pos.x + effectiveSpeed * dt
	end
	if w then
		player.pos.y = player.pos.y - effectiveSpeed * dt
	end
	if s then
		player.pos.y = player.pos.y + effectiveSpeed * dt
	end
end

function love.draw()
	love.graphics.setCanvas(canvas)

	love.graphics.clear()

	local x, y = getScaledMousePosition()
	local sel = toWorldspace(vector.new(x, y))

	for i = 0, MAP_ROWS - 1 do
		for j = 0, MAP_COLUMNS - 1 do
			local idx = vector.new(j, i)
			local pos = toViewspace(idx)

			if idx == sel then
				love.graphics.setColor(0,1,0)
			end

			love.graphics.draw(resources.tile, pos.x, pos.y)
			love.graphics.setColor(1,1,1)
		end
	end

	drawEntity(player)

	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, SCALE)
end
