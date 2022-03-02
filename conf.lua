SCALE = 3
WIN_WIDTH = 640
WIN_HEIGHT = 640
WIDTH = WIN_WIDTH / SCALE
HEIGHT = WIN_HEIGHT / SCALE
DEF_SPRITE_HEIGHT = 32
DEF_SPRITE_WIDTH = 32

-- We may want these to be dynamic and change depending on what level we're at
MAP_COLUMNS = 6
MAP_ROWS = 8

-- DEBUG = true

require("lib/functional")
require("lib/util")
vector = require("lib/vector")

function love.conf(t)
	t.window.title = "Love jam 2022"
	t.window.width = WIN_WIDTH
	t.window.height = WIN_HEIGHT
end
