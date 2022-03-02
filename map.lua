function loadTiles()
	return {
		loadImage("grass.png"),
		loadImage("rock.png"),
		loadImage("rockcrack.png"),
		loadImage("rockcrack2.png"),
		loadImage("rockcrackfinal.png"),
		loadImage("water"),
	}
end

-- 1: grass
-- 2: rock
-- 3: rock cracking
-- 4: second stage rock cracking
-- 5: rock with hole in the ground
-- 6: water

map = {
	{1,1,1,1,1,1},
	{1,2,2,2,2,1},
	{1,2,2,2,2,1},
	{1,2,2,2,2,1},
	{1,2,2,2,2,1},
	{1,2,2,2,2,1},
	{1,2,2,2,2,1},
	{1,1,1,1,1,1}
}
