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
	player:update(dt)
end

function love.draw()
	love.graphics.setCanvas(canvas)

	love.graphics.clear()

	local x, y = getScaledMousePosition()
	local sel = toWorldspace(vector.new(x, y))

	-- Draw ground tiles
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

	-- TODO: Draw player behind or in front of above-ground sprites
	drawEntity(player)

	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, SCALE)

	-- Debug information
	if DEBUG then
		love.graphics.setColor(0.2, 0.2, 0.2)
		love.graphics.rectangle("fill", 0, 0, 200, 32)
		love.graphics.setColor(1,1,1)
		love.graphics.print(
			string.format("Seconds since dodge: %.1f\n"..
						  "Player position: (%.2f, %.2f)",
						  player.secsSinceDodge,
						  player.pos.x, player.pos.y)
		)
	end
end
