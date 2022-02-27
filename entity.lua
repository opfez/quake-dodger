function drawEntity(ent)
	-- All entities *should* have a sprite field
	local sprite = ent.sprite or resources.missingTexture

	local pos = toViewspace(ent.pos)
	love.graphics.draw(sprite, pos.x, pos.y)
end
