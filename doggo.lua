function newDoggo()
	local doggo = {
		state = "alive",
		pos = vector.new(math.random(MAP_COLUMNS - 1),
						 math.random(MAP_ROWS - 1)),
		width = 15,
		height = 13,
		activeAnimation = newAnimation(resources.doggo, 15, 13, 1),
		update = function(self, dt)
			updateAnimations(self, dt)
		end
	}

	return doggo
end
