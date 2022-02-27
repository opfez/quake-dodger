SCALE = 3
WWIDTH = 640
WHEIGHT = 640
WIDTH = WWIDTH / SCALE
HEIGHT = WHEIGHT / SCALE

function love.conf(t)
    t.window.title = "Love jam 2022"
    t.window.width = WWIDTH
    t.window.height = WHEIGHT
end
