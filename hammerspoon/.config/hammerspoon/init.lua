--- Globals --------------------------------------------------------------------
hs.loadSpoon("SpoonInstall")
local Install = spoon.SpoonInstall

Install.repos = {
    default = {
      url = "https://github.com/Hammerspoon/Spoons",
      desc = "Main Hammerspoon Spoon repository",
      branch = "master",
    }
}

Install.use_syncinstall = true
-------------------------------------------------------------------------------
local lrhk = hs.loadSpoon("LeftRightHotkey"):start()
local mod = "lCtrl"
local home = os.getenv('HOME')
local disown = " &> /dev/null & disown"
local clipboard = hs.loadSpoon("TextClipboardHistory")
hs.dockIcon(false)
-- ActiveSpace = hs.loadSpoon("ActiveSpace")
-- ActiveSpace:start()
--- Reload config --------------------------------------------------------------
local function reloadConfig(files)
    local doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == '.lua' then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- global, to avoid garbage collection
myWatcher = hs.pathwatcher.new(home .. '/.config/hammerspoon/', reloadConfig):start()

--- Org-capture ----------------------------------------------------------------
-- org_capture_path = os.getenv("HOME").."/.hammerspoon/files/org-capture.lua"
-- script_file = io.open(org_capture_path, "w")
-- script_file:write([[local win = hs.window.frontmostWindow()
-- local o,s,t,r = hs.execute("~/.emacs.d/bin/org-capture", true)
-- if not s then
--   print("Error when running org-capture: "..o.."\n")
-- end
-- win:focus()
-- ]])
-- script_file:close()

-- hs.hotkey.bindSpec({hyper, "t"},
--   function ()
--     hs.task.new("/bin/bash", nil, { "-l", "-c", "/usr/local/bin/hs "..org_capture_path }):start()
--   end
-- )

--- Shortcuts ------------------------------------------------------------------
-- Yen to Backslash
hs.hotkey.bind({}, 0x5D, function() hs.eventtap.keyStroke({}, "\\") end)
hs.hotkey.bind({"ctrl"}, 0x5D, function() hs.eventtap.keyStroke({"ctrl"}, "\\") end)

hs.hotkey.bind({}, 'F1', function()
    hs.application.launchOrFocus("Emacs")
end)

hs.hotkey.bind({}, "F5", function()
    hs.application.launchOrFocus("Zen")
end)

local appList = {
    -- ["d"] = "Spotlight",
    ["m"] = "Microsoft Outlook",
    ["s"] = "Spotify",
    ["t"] = "Slack",
    ["return"] = "Kitty",
}

for key, app in pairs(appList) do
    lrhk:bind({mod}, key, function()
        hs.application.launchOrFocus(app)
    end)
end

clipboard.hist_size = 200

--- Window Management --------------------------------------------------------------
-- local wm = hs.loadSpoon("WindowManager")

-- local wmKeys = {
--     -- ["up"] = wm:move(wm.layout.top50),
--     -- ["down"] = wm:move(wm.layout.bottom50),
--     -- ["left"] = wm:move(wm.layout.left50),
--     -- ["right"] = wm:move(wm.layout.right50),
--     ["return"] = wm.maximixe,
--     ["f"] = wm.toggleFullScreen,
--     -- ["p"] = wm.screenPrev,
-- }

-- for key, fn in pairs(wmKeys) do
--     lrhk:bind({mod, "lshift"}, key, fn)
-- end

-- Close all visible notifications in Notification Center. (fn+n to show)
lrhk:bind({mod}, "escape", function()
  hs.task
    .new("/usr/bin/osascript", nil, {
      "-l",
      "JavaScript",
      os.getenv("HOME") .. "/.config/hammerspoon/close_notifs.js",
    })
    :start()
end)

-- Toggle night-light (requires `nightlight` to be installed)
lrhk:bind({mod, "lshift"}, "r", function()
    local output, status = hs.execute("/opt/homebrew/bin/nightlight toggle", true)
    if status then
        hs.alert.show("Night Shift toggled")
    else
        hs.alert.show("Failed to toggle Night Shift")
    end
end)

-- Mouse emulation (requires cliclick and permissions)
local mKeys = {
    -- ["k"] = '/opt/homebrew/bin/sendkeys -c "<m:0,40:0.5>"', -- "m:+0,-40" -e 5',
    -- ["j"] = '/opt/homebrew/bin/sendkeys "m:+0,+40" -e 5',
    -- ["l"] = '/opt/homebrew/bin/sendkeys "m:+40,+0" -e 5',
    -- ["h"] = '/opt/homebrew/bin/sendkeys "m:-40,+0" -e 5',
    -- ["p"] = '/opt/homebrew/bin/sendkeys -c "<s:0,-300:0.3>"',
    -- ["n"] = '/opt/homebrew/bin/sendkeys -c "<s:0,300:0.3>"',
    -- ["a"] = '/opt/homebrew/bin/sendkeys -c "<m:left>"',
    -- ["s"] = '/opt/homebrew/bin/sendkeys -c "<m:right>"',
    
    ["p"] = '/opt/homebrew/bin/sendkeys -c "<s:0,-400:0.2>"',
    ["n"] = '/opt/homebrew/bin/sendkeys -c "<s:0,400:0.2>"',
    ["f"] = '/run/current-system/sw/bin/yabai -m window --toggle zoom-fullscreen',
    ["space"] = '~/.nix-profile/bin/yabai -m window --toggle float',

    ["h"] = '~/.nix-profile/bin/yabai -m window --focus west || ~/.nix-profile/bin/yabai -m window --focus stack.prev || ~/.nix-profile/bin/yabai -m window --focus stack.last',
    ["j"] = '~/.nix-profile/bin/yabai -m window --focus south',
    ["k"] = '~/.nix-profile/bin/yabai -m window --focus north',
    ["l"] = '~/.nix-profile/bin/yabai -m window --focus east || ~/.nix-profile/bin/yabai -m window --focus stack.next || ~/.nix-profile/bin/yabai -m window --focus stack.first',
    ["x"] = '~/.nix-profile/bin/yabai -m window --toggle split',
}

local moveWin = {
    -- Use toggle float twice to unstack
    -- ["i"] = '~/.nix-profile/bin/yabai -m window --insert stack',
    ["a"] = '~/.nix-profile/bin/yabai -m window west --insert stack; ~/.nix-profile/bin/yabai -m window --warp west',
    ["s"] = '~/.nix-profile/bin/yabai -m window south --insert stack; ~/.nix-profile/bin/yabai -m window --warp south',
    ["d"] = '~/.nix-profile/bin/yabai -m window north --insert stack; ~/.nix-profile/bin/yabai -m window --warp north',
    ["f"] = '~/.nix-profile/bin/yabai -m window east --insert stack; ~/.nix-profile/bin/yabai -m window --warp east',

    ["h"] = '~/.nix-profile/bin/yabai -m window --swap west',
    ["j"] = '~/.nix-profile/bin/yabai -m window --swap south',
    ["k"] = '~/.nix-profile/bin/yabai -m window --swap north',
    ["l"] = '~/.nix-profile/bin/yabai -m window --swap east',
}

for key, fn in pairs(mKeys) do
    lrhk:bind({mod}, key, function()
        hs.execute(fn, false)
    end)
end
for key, fn in pairs(moveWin) do
    lrhk:bind({mod, "lshift"}, key, function()
        hs.execute(fn, false)
    end)
end

-- Sends "escape" if "caps lock" is held for less than .2 seconds, and no other keys are pressed. (FIXME)
local send_escape = false
local last_mods = {}
local control_key_timer = hs.timer.delayed.new(0.2, function()
    send_escape = false
end)

hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(evt)
    local new_mods = evt:getFlags()
    if last_mods["ctrl"] == new_mods["ctrl"] then
        return false
    end
    if not last_mods["ctrl"] then
        last_mods = new_mods
        send_escape = true
        control_key_timer:start()
    else
        if send_escape then
            hs.eventtap.keyStroke({}, "escape")
        end
        last_mods = new_mods
        control_key_timer:stop()
    end
    return false
end):start()

hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
    send_escape = false
    return false
end):start()

-- Preview jk shortcuts (FIXME)
local previewBindings = {}
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Preview.app") then
            -- enable your custom bindings here
            previewBindings[#previewBindings + 1] = hs.hotkey.bind({}, "j", function()
                hs.eventtap.keyStroke({}, "down")  -- Next page/item
            end)
            
            previewBindings[#previewBindings + 1] = hs.hotkey.bind({}, "k", function()
                hs.eventtap.keyStroke({}, "up")    -- Previous page/item
            end)
        end
    end
    if (eventType == hs.application.watcher.deactivated) then
        if (appName == "Preview") then
            -- disable your custom bindings here
            for i, binding in ipairs(previewBindings) do
                binding:delete()
            end
            previewBindings = {}
        end
    end
end
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- Set up the logger
local log = hs.logger.new('WindowMover', 'info')

-- Function to get spaceId by space name
function getSpaceIdByName(spaceName)
    local spaceNames = hs.spaces.missionControlSpaceNames()
    for uuid, desktops in pairs(spaceNames) do
        log.i("UUID: " .. uuid) -- Log the UUID
        for index, name in pairs(desktops) do
            log.i("Index: " .. index .. ", Name: " .. tostring(name)) -- Log the index and name
            if name == spaceName then
                log.i("Found spaceId for " .. spaceName .. ": " .. index)
                return index
            end
        end
    end
    log.w("Space not found: " .. spaceName)
    return nil
end

-- Function to move focused window to a specific space
function moveFocusedWindowToSpace(spaceNumber)
    local spaceName = "Desktop " .. spaceNumber
    log.i("Attempting to move window to " .. spaceName)
    local spaceId = getSpaceIdByName(spaceName)
    if spaceId then
        local focusedWindow = hs.window.focusedWindow()
        if focusedWindow then
            log.i("Moving window " .. focusedWindow:title() .. " to spaceId " .. spaceId)
            hs.spaces.moveWindowToSpace(focusedWindow:id(), spaceId)
        else
            log.w("No focused window")
            hs.alert.show("No focused window")
        end
    else
        log.w("Space not found: " .. spaceName)
        hs.alert.show("Space not found: " .. spaceName)
    end
end

-- Bind keys cmd + shift + 1-6
-- Ref: 
lrhk:bind({mod, "lshift"}, "p", function() require("./window"):move_window_to_previous_desktop() end)
lrhk:bind({mod, "lshift"}, "n", function() require("./window"):move_window_to_next_desktop() end)

for i = 1, 6 do
    lrhk:bind({mod, "lshift"}, tostring(i), function()
        log.i("Hotkey pressed: cmd + shift + " .. i)
        moveFocusedWindowToSpace(i)
    end)
end
