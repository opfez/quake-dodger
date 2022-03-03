-- Wrappers for common operations

function loadImage(filename)
	local path = "resources/" .. filename

	local res = love.graphics.newImage(path)
	res:setFilter("nearest", "nearest")

	return res
end

function newAnimation(image, width, height, duration, transform)
	local animation = {
		spriteSheet = image,
		quads = {},
		transform = transform,
		duration = duration or 1,
		currentTime = 0
	}

	for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
	end

	return animation
end

function round(n)
	local m = n - math.floor(n)
	if m < 0.5 then
		return math.floor(n)
	else
		return math.ceil(n)
	end
end
