-----------------------------------------------
-- Set up
-----------------------------------------------

local hyper = {"alt", "cmd"}
local grid = require "hs.grid"
grid.GRIDWIDTH=2
grid.GRIDHEIGHT=2
grid.MARGINX = 0
grid.MARGINY = 0
grid.fullScreen  = {x=0, y=0, w=grid.GRIDWIDTH, h=grid.GRIDHEIGHT};
grid.leftHalf    = {x=0, y=0, h=2, w=1};
grid.rightHalf   = {x=1, y=0, h=2, w=1};
grid.topRight    = {x=1, y=0, h=1, w=1};
grid.bottomRight = {x=1, y=1, h=1, w=1};
grid.bottomLeft  = {x=0, y=1, h=1, w=1};
grid.topLeft     = {x=0, y=0, h=1, w=1};
hs.window.animationDuration = 0
local gridcache = {};

-----------------------------------------------
-- Reload config on write
-----------------------------------------------
function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Hammerspoon\nConfig loaded")

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

-- move current window to grid positions
function moveCurrentGrid(pos)
    local win = hs.window.focusedWindow()
    if win then
        local screen = win:screen()
        grid.set(win, pos, screen)
    else
        hs.alert.show("No active window")
    end
end

function focus(app)
    return function()
        hs.application.launchOrFocus(app);
    end
end

function moveGrid(g)
    return function()
        moveCurrentGrid(g);
    end
end

function setupMode()
    local modalKey = hs.hotkey.modal.new({"cmd", "shift"}, "j")
    modalKey.entered = function()
        local msg = [[   Mode
            T    Terminal 
            V    MacVim
            B    Chrome
        ]]
        hs.alert.show(msg)
    end
    modalKey.exited = function()  hs.alert.show('Exited modal')  end
    modalKey:bind({}, 'escape', function() modalKey:exit() end)
    return modalKey;
end

-- return a function that wull call f and then exit the mode
function exitModeWith(mode, f)
    return function()
        mode:exit();
        f();
    end
end

-- bind key to combo+key and to mode-key
function binder(key, combo, mode, f)
    if combo then
        hs.hotkey.bind(combo, key, f)
    end
    if mode then
        mode:bind({}, key, exitModeWith(mode, f));
    end
end

local modalKey = setupMode();


binder('t', hyper, modalKey, focus('terminal'));
binder('v', nil,   modalKey, focus('MacVim'));
binder('b', hyper, modalKey, focus('Google Chrome'));
binder('[', hyper, modalKey, moveGrid(grid.leftHalf));
binder(']', hyper, modalKey, moveGrid(grid.rightHalf));
binder('f', hyper, modalKey, moveGrid(grid.fullScreen));
binder('p', hyper, modalKey, moveGrid(grid.topRight));
binder('l', hyper, modalKey, moveGrid(grid.bottomRight));
binder('o', hyper, modalKey, moveGrid(grid.topLeft));
binder('k', hyper, modalKey, moveGrid(grid.bottomLeft));
binder("m", hyper, modalKey, toggleAltScreen);
binder('i', hyper, modalKey, hs.hints.windowHints);


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

