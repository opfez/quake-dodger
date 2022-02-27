-- TODO: Add moving camera support

function toViewspace(coord, spriteW, spriteH)
	local spriteW = spriteW or DEF_SPRITE_WIDTH
	local spriteH = spriteH or DEF_SPRITE_HEIGHT

	return vector.new(
		coord.x * spriteW,
		coord.y * spriteH / 2
	)
end

function toWorldspace(coord, spriteW, spriteH)
	local spriteW = spriteW or DEF_SPRITE_WIDTH
	local spriteH = spriteH or DEF_SPRITE_HEIGHT

	return vector.new(
		math.floor(coord.x / spriteW),
		math.floor(coord.y / spriteH * 2)
	)
end

-- Probably unnecessary for this project?
function getScaledMousePosition()
	local x, y = love.mouse.getPosition()
	return math.floor(x / SCALE), math.floor(y / SCALE)
end
