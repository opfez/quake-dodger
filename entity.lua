function drawEntity(ent)
	local anim = ent.activeAnimation

	local spriteNum = math.floor(anim.currentTime / anim.duration * #anim.quads) + 1

	local pos = toViewspace(ent.pos, ent.width, ent.height)
	pos.x = pos.x - ent.width / 2
	pos.y = pos.y - ent.height

	if ent.state == "alive" then
		love.graphics.setColor(1,1,1)
	elseif ent.state == "drowning" then
		love.graphics.setColor(0,0,1)
	end

	if anim.transform then
		love.graphics.draw(anim.spriteSheet,
						   anim.quads[spriteNum],
						   pos.x, pos.y,
						   anim.transform.r,
						   anim.transform.sx, anim.transform.sy,
						   anim.transform.ox, anim.transform.oy,
						   anim.transform.kx, anim.transform.ky)
	else
		love.graphics.draw(anim.spriteSheet,
						   anim.quads[spriteNum],
						   pos.x, pos.y)
	end
end

function updateAnimations(ent, dt)
	local anim = ent.activeAnimation
	anim.currentTime = anim.currentTime + dt
	if anim.currentTime >= anim.duration then
		anim.currentTime = anim.currentTime - anim.duration
	end
end
