-----------------------------------------------
-- Set up
-----------------------------------------------

local hyper = {"alt", "cmd"}
local grid = require "hs.grid"
grid.GRIDWIDTH=2
grid.GRIDHEIGHT=2
grid.MARGINX = 0
grid.MARGINY = 0
hs.window.animationDuration = 0
hs.hints.style = 'vimperator'

local gridcache = {};

------
-- Maximumise current window in next screen or toggle back to previous position
------
function toggleAltScreen()
    local win = hs.window.focusedWindow()
    local cPos = grid.get(win)
    local screens = hs.screen.allScreens()
    local winScreen = win:screen()
    local targetScreen = winScreen:next() or winScreen:previous();
    if cPos.h ~= grid.GRIDHEIGHT or cPos.w ~= grid.GRIDWIDTH then
        gridcache[win:id()] = grid.get(win);
        grid.set(win, {x = 0, y = 0, h = grid.GRIDHEIGHT, w = grid.GRIDWIDTH}, targetScreen);
    else
        local tPos = gridcache[win:id()] or cPos;
        grid.set(win, tPos, targetScreen);
    end
end

function moveCurrentGrid(pos)
    local win = hs.window.focusedWindow()
    if win then
        local screen = win:screen()
        grid.set(win, pos, screen)
    else
        hs.alert.show("No active window")
    end
end

function leftHalf()
    moveCurrentGrid({x=0, y=0, h=2, w=1})
end

function rightHalf()
    moveCurrentGrid({x=1, y=0, h=2, w=1})
end

function fullScreen()
    moveCurrentGrid({w = grid.GRIDWIDTH, h = grid.GRIDHEIGHT, x = 0, y = 0})
end

function topRight()
    moveCurrentGrid({x=1, y=0, h=1, w=1})
end

function bottomRight()
    moveCurrentGrid({x=1, y=1, h=1, w=1})
end

function bottomLeft()
    moveCurrentGrid({x=0, y=1, h=1, w=1})
end

function topLeft()
    moveCurrentGrid({x=0, y=0, h=1, w=1})
end


hs.hotkey.bind(hyper, '[', leftHalf)
hs.hotkey.bind(hyper, ']', rightHalf)
hs.hotkey.bind(hyper, 'f', fullScreen)
hs.hotkey.bind(hyper, 'p', topRight)
hs.hotkey.bind(hyper, 'l', bottomRight)
hs.hotkey.bind(hyper, 'o', topLeft)
hs.hotkey.bind(hyper, 'k', bottomLeft)
hs.hotkey.bind(hyper, "m", toggleAltScreen);

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Hammerspoon\nConfig loaded")

-----------------------------------------------
-- Hyper i to show window hints
-----------------------------------------------

hs.hotkey.bind(hyper, 'i', function()
    hs.hints.windowHints()
end)

-----------------------------------------------
-- switch window focus
-----------------------------------------------
--
-- hs.hotkey.bind(hyper, 'Up', function()
--     if hs.window.focusedWindow() then
--         hs.window.focusedWindow():focusWindowNorth()
--     else
--         hs.alert.show("No active window")
--     end
-- end)
--
--
--

-- -- Manual grid function
-- function lefthalf()
--     if hs.window.focusedWindow() then
--         local win = hs.window.focusedWindow()
--         local f = win:frame()
--         local screen = win:screen()
--         local max = screen:frame()
--         f.x = max.x
--         f.y = max.y
--         f.w = max.w / 2
--         f.h = max.h
--         win:setFrame(f)
--     else
--         hs.alert.show("No active window")
--     end
-- end

