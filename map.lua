function loadTiles()
	return {
		loadImage("grass.png"),
		loadImage("rock.png"),
		loadImage("rockcrack.png"),
		loadImage("rockcrack2.png"),
		loadImage("rockcrackfinal.png"),
		loadImage("water.png"),
	}
end

-- 1: grass
TILE_GRASS = 1
-- 2: rock
TILE_ROCK = 2
-- 3 and 4: rock cracking
TILE_CRACK1 = 3
TILE_CRACK2 = 4
-- 5: rock with hole in the ground
TILE_HOLE = 5
-- 6: water
TILE_WATER = 6

map = {
	{1,1,1,1,1,1},
	{1,2,2,2,2,1},
	{1,2,6,2,2,1},
	{1,2,6,2,2,1},
	{1,2,2,2,2,1},
	{1,2,2,2,2,1},
	{1,2,2,2,2,1},
	{1,1,1,1,1,1}
}

mapTimes = {}
for i = 1, MAP_ROWS do
	mapTimes[i] = {}
	for j = 1, MAP_COLUMNS do
		mapTimes[i][j] = 0
	end
end
