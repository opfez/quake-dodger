function newPlayer()
	local spriteW = 32
	local spriteH = 32

	local player = {
		health = 3,
		pos = vector.new(0, 1),
		speed = 2,
		speeds = {2, 6}, -- Walk/Dodging
		animations = {
			idleRight = newAnimation(resources.playerIdle, spriteW, spriteH),
			idleLeft = newAnimation(resources.playerIdle, spriteW, spriteH, 1,
									{sx = -1, sy = 1, ox = spriteW}),
			walkRight =
				newAnimation(resources.playerWalkRight,
							 spriteW, spriteH, 0.5),
			walkLeft =
				newAnimation(resources.playerWalkRight,
							 spriteW, spriteH, 0.5,
							 {sx = -1, sy = 1, ox = spriteW}),
			dodgeRight =
				newAnimation(resources.playerDodgeRight,
							 spriteW, spriteH, 0.3),
			dodgeLeft =
				newAnimation(resources.playerDodgeRight,
							 spriteW, spriteH, 0.3,
							 {sx = -1, sy = 1, ox = spriteW}),
		},
		activeAnimation = nil,
		lastDirection = "right",
		dodging = false,
		secsSinceDodge = 100,
		keysDown = {
			a = false,
			d = false,
			w = false,
			s = false,
		},
		update = function(self, dt)
			local walkSpeed = self.speed
			local dodgeSpeed = walkSpeed * 1.1
			local dodgeCooldown = 1
			local activeDodgeTime = 0.3

			local effectiveSpeed = walkSpeed
			if self.dodging then effectiveSpeed = dodgeSpeed end

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
				self.lastDirection = "left"
				self.pos.x = self.pos.x - effectiveSpeed * dt
			end
			if d then
				self.lastDirection = "right"
				self.pos.x = self.pos.x + effectiveSpeed * dt
			end
			if w then
				self.pos.y = self.pos.y - effectiveSpeed * dt
			end
			if s then
				self.pos.y = self.pos.y + effectiveSpeed * dt
			end

			if self.lastDirection == "right" then
				if not (a or d or w or s) then
					self.activeAnimation = self.animations.idleRight
				elseif self.dodging then
					self.activeAnimation = self.animations.dodgeRight
				else
					self.activeAnimation = self.animations.walkRight
				end
			elseif self.lastDirection == "left" then
				if not (a or d or w or s) then
					self.activeAnimation = self.animations.idleLeft
				elseif self.dodging then
					self.activeAnimation = self.animations.dodgeLeft
				else
					self.activeAnimation = self.animations.walkLeft
				end
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

			updateAnimations(self, dt)
		end
	}

	player.activeAnimation = player.animations.walk_right

	return player
end
