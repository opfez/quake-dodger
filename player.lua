function newPlayer()
	local function isPossibleToMove(x, y)
		local tile = map[math.floor(y)+1][math.floor(x)+1]
		return not (tile == TILE_WATER)
	end

	local spriteW = 32
	local spriteH = 32

	local player = {
		state = "alive",
		health = 3,
		pos = vector.new(1, 3),
		speed = 2,
		speeds = {2, 6}, -- Walk/Dodging
		width = spriteW,
		height = spriteH,
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
		aliveUpdate = function(self, dt)
			local walkSpeed = self.speed
			local dodgeSpeed = walkSpeed * 1.1
			local dodgeCooldown = 1
			local activeDodgeTime = 0.3

			local effectiveSpeed = walkSpeed
			if self.dodging then effectiveSpeed = dodgeSpeed end

			-- Death check
			if not self.dodging then
				local i = math.floor(player.pos.y) + 1
				local j = math.floor(player.pos.x) + 1
				local tile = map[i][j]

				if tile == TILE_ROCK_HOLE then
					self.state = "falling"
					self.update = self.fallingUpdate
					return
				end
			end

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

				local newX = self.pos.x - effectiveSpeed * dt
				if isPossibleToMove(newX, self.pos.y) then
					self.pos.x = self.pos.x - effectiveSpeed * dt
				end
			end
			if d then
				self.lastDirection = "right"

				local newX = self.pos.x + effectiveSpeed * dt
				if isPossibleToMove(newX, self.pos.y) then
					self.pos.x = self.pos.x + effectiveSpeed * dt
				end
			end
			if w then
				local newY = self.pos.y - effectiveSpeed * dt
				if isPossibleToMove(self.pos.x, newY) then
					self.pos.y = self.pos.y - effectiveSpeed * dt
				end
			end
			if s then
				local newY = self.pos.y + effectiveSpeed * dt
				if isPossibleToMove(self.pos.x, newY) then
					self.pos.y = self.pos.y + effectiveSpeed * dt
				end
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
		end,
		fallingUpdate = function(self, dt)
			return
		end
	}

	player.update = player.aliveUpdate
	player.activeAnimation = player.animations.walk_right

	return player
end
