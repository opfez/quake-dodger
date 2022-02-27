player = {
	pos = vector.new(1, 1),
	speed = 2,
	speeds = {2, 6},
	sprite = loadImage("player.png"),
	dodging = false,
	secsSinceDodge = 100,
	keysDown = {
		a = false,
		d = false,
		w = false,
		s = false,
	},
	update = function(self, dt)
		local effectiveSpeed = self.speed
		local dodgeSpeedMultiplier = 1.3
		local dodgeCooldown = 2
		local activeDodgeTime = 0.2

		-- Jesus Christ
		local a = false
		local d = false
		local w = false
		local s = false
		if self.dodging then
			a = self.keysDown.a
			d = self.keysDown.d
			w = self.keysDown.w
			s = self.keysDown.s

			effectiveSpeed = effectiveSpeed * dodgeSpeedMultiplier
		else
			a = love.keyboard.isDown("a")
			d = love.keyboard.isDown("d")
			w = love.keyboard.isDown("w")
			s = love.keyboard.isDown("s")

			self.keysDown.a = a
			self.keysDown.d = d
			self.keysDown.w = w
			self.keysDown.s = s
		end

		if (a and w) or (a and s) or (d and w) or (d and s) then
			effectiveSpeed = math.sin(math.pi / 4) * effectiveSpeed
		end

		if a then
			self.pos.x = self.pos.x - effectiveSpeed * dt
		end
		if d then
			self.pos.x = self.pos.x + effectiveSpeed * dt
		end
		if w then
			self.pos.y = self.pos.y - effectiveSpeed * dt
		end
		if s then
			self.pos.y = self.pos.y + effectiveSpeed * dt
		end

		self.secsSinceDodge = self.secsSinceDodge + dt
		if love.keyboard.isDown("space") and
			(a or d or w or s) and
			self.secsSinceDodge >= dodgeCooldown
		then
			self.secsSinceDodge = 0
			self.speed = self.speeds[2]
			self.dodging = true
		elseif self.secsSinceDodge >= activeDodgeTime then
			self.speed = self.speeds[1]
			self.dodging = false
		end
	end
}
