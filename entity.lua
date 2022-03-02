function drawEntity(ent)
	local anim = ent.activeAnimation

	local spriteNum = math.floor(anim.currentTime / anim.duration * #anim.quads) + 1

	local pos = toViewspace(ent.pos)
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
