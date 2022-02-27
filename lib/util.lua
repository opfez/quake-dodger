-- Wrappers for common operations

function loadImage(filename)
	local path = "resources/" .. filename

	local res = love.graphics.newImage(path)
	res:setFilter("nearest", "nearest")

	return res
end
