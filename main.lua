require("perspective")

local canvas

resources = {}

function love.load()
	resources.tile = love.graphics.newImage("resources/tile.png")
	resources.tile:setFilter("nearest", "nearest")

	canvas = love.graphics.newCanvas(love.graphics.getDimensions())
	canvas:setFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(0,0.2,0.4)
end

function love.update(dt)
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

	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, SCALE)
end
