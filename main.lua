require("perspective")
require("player")
require("doggo")
require("entity")
require("map")

local canvas
local entities = {}

resources = {}

function love.load()
	math.randomseed(os.time())

	resources.tiles = loadTiles()
	resources.missingTexture = loadImage("missing.png")
	resources.playerWalkRight = loadImage("walkr.png")
	resources.playerDodgeRight = loadImage("rolling.png")
	resources.playerIdle = loadImage("idle.png")
	resources.doggo = loadImage("doggo.png")

	player = newPlayer()

	table.insert(entities, newDoggo())

	canvas = love.graphics.newCanvas(love.graphics.getDimensions())
	canvas:setFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(0,0.2,0.4)
end

function love.update(dt)
	player:update(dt)

	for i, ent in ipairs(entities) do
		ent:update(dt)
	end
end

function love.draw()
	love.graphics.setCanvas(canvas)

	love.graphics.clear()

	-- Draw ground tiles
	for i = 0, MAP_ROWS - 1 do
		for j = 0, MAP_COLUMNS - 1 do
			local idx = vector.new(j, i)
			local pos = toViewspace(idx)

			love.graphics.draw(resources.tiles[map[i+1][j+1]], pos.x, pos.y)
		end
	end

	local playerDrawn = false
	for i, ent in ipairs(entities) do
		if not playerDrawn and ent.pos.y > player.pos.y then
			playerDrawn = true
			drawEntity(player)
		end
		drawEntity(ent)
	end
	if not playerDrawn then
		playerDrawn = true
		drawEntity(player)
	end


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
