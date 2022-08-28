local appfinder = hs.appfinder
local application = hs.application
local geometry = hs.geometry
local hotkey = hs.hotkey
local window = hs.window
hs.window.animationDuration = 0

local hyper = {"cmd", "alt", "ctrl", "shift"}
local meh = {"cmd", "shift", "ctrl"}
local spectacle = {"cmd", "ctrl"}
local move = { "cmd", "ctrl", "alt" }

--{{{ Utils
-- Focus the last used window.
local function focusLastFocused()
  local wf = hs.window.filter
  local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
  if #lastFocused > 0 then lastFocused[1]:focus() end
end

-- http://lua-users.org/wiki/FileInputOutput

-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end
--}}}

--{{{ Spoons
hs.loadSpoon("MicMute")
spoon.MicMute:bindHotkeys({ toggle = {meh, "m"} }, 0.75)

hs.loadSpoon("ClipboardTool")
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool.show_in_menubar = false
spoon.ClipboardTool.hist_size = 200
spoon.ClipboardTool:bindHotkeys({ toggle_clipboard = { meh, "c" } })
spoon.ClipboardTool:start()
--}}}

--{{{ Bookmarks chooser

hotkey.bind(meh, "\\", function()
  local choices = {}
  local file = os.getenv("HOME") .. '/.config/surfraw/bookmarks'
  local lines = lines_from(file)

  for k, v in pairs(lines) do
    local chunks = {}
    for substring in string.gmatch(v, "%S+") do
      table.insert(chunks, substring)
    end

    -- It's easier to search by separate words then by single word separated
    -- by '-' xxx-xx-xx
    local words = {}
    for subword in string.gmatch(chunks[1], "([^-]*)") do
      table.insert(words, subword)
    end

    table.insert(choices, {
      text=table.concat(words, " "),
      subText=chunks[2]
    })
  end
  local chooser = hs.chooser.new(function(choice)
    if choice then
      os.execute("open " ..choice["subText"])
    else
      focusLastFocused()
    end
  end)

  chooser:searchSubText(true)
  chooser:choices(choices)
  chooser:rows(8)
  chooser:bgDark(true)
  chooser:show()
end)

--}}}

--{{{ App launchers
local workApplications = {
  'Calendar',
  'Mail',
  'Docker',
  -- 'Discord',
  'Brave Browser',
  'Iterm',
  'Slack',
}

hotkey.bind(hyper, "1", function()
  for _, app in pairs(workApplications) do
    application.launchOrFocus(app)
  end
end)

local workApplicationsToKill = {
  'Docker',
  'Discord',
  'Slack',
}
hotkey.bind(hyper, "0", function()
  for _, appName in pairs(workApplicationsToKill) do
    local app = hs.application.find(appName)
    if (app) then
      app:kill()
    end
  end
end)

hotkey.bind(hyper, 'C', function() application.launchOrFocus('Calendar') end)
hotkey.bind(hyper, 'S', function() application.launchOrFocus('Slack') end)
hotkey.bind(hyper, 'D', function() application.launchOrFocus('Discord') end)
hotkey.bind(hyper, 'G', function() application.launchOrFocus('Brave Browser') end)
hotkey.bind(hyper, 'B', function() application.launchOrFocus('Brave Browser') end)
hotkey.bind(hyper, 'M', function() application.launchOrFocus('Mail') end)
hotkey.bind(hyper, 'I', function() application.launchOrFocus('Iterm') end)

hotkey.bind(hyper, "V", function()
  for k, v in pairs(hs.application.runningApplications()) do
    if v:name() == "mpv" then
      v:activate()
      -- local window = v:mainWindow()
      -- hs.eventtap.rightClick({
        -- x = window:frame().x + 30,
        -- y = window:frame().y + 30
      -- })
    end
  end
end)
--}}}

--{{{ Move mouse cursor to the bottom right corner of the screen ( - Dock height )
hotkey.bind(move, ".", function()
  local screen = hs.screen.mainScreen()
  hs.mouse.setAbsolutePosition({
    x = screen:frame().w,
    y = screen:frame().h
  })
end)
--}}}

--{{{ Move mouse

local function getCurrentScreenCenter()
  local screen = hs.mouse.getCurrentScreen()
  local rect = screen:frame()
  return hs.geometry.rectMidPoint(rect)
end

hotkey.bind(move, "C", function()
  local currentPosition = hs.mouse.getAbsolutePosition();
  hs.eventtap.leftClick(currentPosition);
end)

-- Put mouse cursor the the center of the screen
hotkey.bind(move, "0", function()
  hs.mouse.setAbsolutePosition(getCurrentScreenCenter())
end)

hotkey.bind(move, "Y", function()
  local x = getCurrentScreenCenter()._x / 2
  local y = getCurrentScreenCenter()._y / 2
  hs.mouse.setAbsolutePosition({ x = x, y = y })
end)

hotkey.bind(move, "N", function()
  local x = getCurrentScreenCenter()._x / 2
  local y = getCurrentScreenCenter()._y / 2 + getCurrentScreenCenter()._y
  hs.mouse.setAbsolutePosition({ x = x, y = y })
end)

hotkey.bind(move, "M", function()
  local x = getCurrentScreenCenter()._x / 2 + getCurrentScreenCenter()._x
  local y = getCurrentScreenCenter()._y / 2 + getCurrentScreenCenter()._y
  hs.mouse.setAbsolutePosition({ x = x, y = y })
end)

hotkey.bind(move, "U", function()
  local x = getCurrentScreenCenter()._x / 2 + getCurrentScreenCenter()._x
  local y = getCurrentScreenCenter()._y / 2
  hs.mouse.setAbsolutePosition({ x = x, y = y })
end)

hs.hotkey.bind(move, 'tab', function()
  local screen = hs.mouse.getCurrentScreen()
  local nextScreen = screen:next()
  local rect = nextScreen:fullFrame()
  local center = hs.geometry.rectMidPoint(rect)
  hs.mouse.setAbsolutePosition(center)
end)

local mouseMoveOffset = 20
hotkey.bind(move, "J", function()
  local currentPosition = hs.mouse.getAbsolutePosition();
  hs.mouse.setAbsolutePosition({
    x = currentPosition.x,
    y = currentPosition.y + mouseMoveOffset
  })
end)

hotkey.bind(move, "K", function()
  local currentPosition = hs.mouse.getAbsolutePosition();
  hs.mouse.setAbsolutePosition({
    x = currentPosition.x,
    y = currentPosition.y - mouseMoveOffset
  })
end)

hotkey.bind(move, "H", function()
  local currentPosition = hs.mouse.getAbsolutePosition();
  hs.mouse.setAbsolutePosition({
    x = currentPosition.x - mouseMoveOffset,
    y = currentPosition.y
  })
end)

hotkey.bind(move, "L", function()
  local currentPosition = hs.mouse.getAbsolutePosition();
  hs.mouse.setAbsolutePosition({
    x = currentPosition.x + mouseMoveOffset,
    y = currentPosition.y
  })
end)
--}}}

--{{{ Window manipulation
function moveTo(win, x, y, h, w)
  local rect = geometry.rect(x, y, h, w)
  hs.window.focusedWindow():moveToUnit(rect)
  -- win:moveToUnit(rect)
end

hotkey.bind(move, "right", function()
  hs.window.focusedWindow():moveOneScreenEast()
end)

hotkey.bind(move, "left", function()
  hs.window.focusedWindow():moveOneScreenWest()
end)

hotkey.bind(spectacle, "H", function()
  moveTo(window.focusedWindow(), 0, 0, 0.5, 1)
end)

hotkey.bind(spectacle, "J", function()
  moveTo(window.focusedWindow(), 0, 0.5, 1, 0.5)
end)

hotkey.bind(spectacle, "K", function()
  moveTo(window.focusedWindow(), 0, 0, 1, 0.5)
end)

hotkey.bind(spectacle, "L", function()
  moveTo(window.focusedWindow(), 0.5, 0, 0.5, 1)
end)

hotkey.bind(spectacle, "7", function()
  moveTo(window.focusedWindow(), 0.15, 0.15, 0.75, 0.75)
end)

hotkey.bind(spectacle, "8", function()
  moveTo(window.focusedWindow(), 0.1, 0.1, 0.85, 0.85)
end)

hotkey.bind(spectacle, "9", function()
  moveTo(window.focusedWindow(), 0.05, 0.05, 0.95, 0.95)
end)

-- Full screen.
hotkey.bind(spectacle, "F", function()
  local win = window.focusedWindow():maximize()
end)
--}}}

--{{{ Increase/Decrease volume
hotkey.bind(meh, "up", function()
  local device = hs.audiodevice.defaultOutputDevice()
  local volume = math.floor(device:volume())
  local nextVolume = volume + 5
  device:setVolume(nextVolume)
  if nextVolume >= 100 then
    return hs.alert.show("Max volume")
  end
  hs.alert.show("The volume is " .. nextVolume)
end)

hotkey.bind(meh, "down", function()
  local device = hs.audiodevice.defaultOutputDevice()
  local volume = math.floor(device:volume())
  local nextVolume = volume - 5
  device:setVolume(nextVolume)
  if nextVolume <= 0 then
    return hs.alert.show("Muted")
  end
  hs.alert.show("The volume is " .. nextVolume)
end)
--}}}

--{{{ Mute/Unmute volume
hotkey.bind(meh, "V", function()
  local device = hs.audiodevice.defaultOutputDevice()
  local isMuted = device:muted()
  local toggler = not isMuted
  device:setMuted(toggler)
  if toggler then
    hs.alert.show("Volume muted")
  else
    hs.alert.show("Volume unmuted")
  end
end)
--}}}

--{{{ Running application chooser
hotkey.bind(meh, "P", function()
  local choices = {}
  for k, v in pairs(hs.application.runningApplications()) do
    if v:kind() == 1 then

      local window = v:mainWindow()
      local title = window and window:title() or v:name()
      table.insert(choices, {
        text=title,
        pid=v:pid(),
      })
    end
  end

  local chooser = hs.chooser.new(function(choice)
    if choice then
      local app = hs.application.get(choice["pid"])
      app:activate()
    else
      focusLastFocused()
    end
  end)

  chooser:searchSubText(true)
  chooser:choices(choices)
  chooser:rows(8)
  chooser:bgDark(true)
  chooser:show()
end)
--}}}

--{{{ Mpv Pasteboard watcher
local mpvPBWatcher = hs.pasteboard.watcher.new(function(v)
  if (string.find(v, "twitch") or string.find(v, "youtube") or string.find(v, "youtu.be")) then
    -- os.execute("open -a mpv " ..v)

    local task = hs.task.new("/usr/local/bin/streamlink", function(exitCode, stdOut, stdErr)
      print(exitCode, stdOut, stdErr)
      if (exitCode == 1) then
        os.execute("open -a mpv " ..v)
      end
    end, function(task, stdOut, stdErr)
    print(task, stdOut, stdErr)
    return false
  end, { "--player=/usr/local/bin/mpv", v })
  task:start()
  hs.alert.show("Playing " ..v)

  end
  -- local command = "ts mpv-custom " ..v
  -- print(command)
  -- local handle = io.popen("ts mpv-custom " ..v)
  -- local result = handle:read("*a")
  -- local result = os.execute('/usr/local/bin/mpv ' ..v)
  -- local result = os.execute('/usr/local/bin/mpv https://www.twitch.tv/asmongold &', true)
  -- local result = os.execute(string.format("/usr/local/bin/mpv %s > /dev/null &", "https://www.twitch.tv/asmongold"))
  -- local result = os.execute(string.format("open %s > /dev/null &", v))
  -- print(v, result)
  -- handle:close()
end)

mpvPBWatcher:stop()

local mpvPBWatcherMenubar = hs.menubar.new()
local function setMpvPBWatcherDisplay(state)
  if mpvPBWatcher:running() then
    mpvPBWatcherMenubar:setTitle("W")
  else
    mpvPBWatcherMenubar:setTitle("!W")
  end
end

local function togglePBWatcher()
  if (mpvPBWatcher:running()) then
    mpvPBWatcher:stop()
  else
    mpvPBWatcher:start()
  end
  setMpvPBWatcherDisplay()
end

if mpvPBWatcherMenubar then
  mpvPBWatcherMenubar:setClickCallback(togglePBWatcher)
  setMpvPBWatcherDisplay()
end

hotkey.bind(meh, "W", function()
  togglePBWatcher()
end)
--}}}

--{{{ An example of `hs.task`
-- hotkey.bind(meh, "V", function()
  -- local task = hs.task.new("/usr/local/bin/mpv", function(exitCode, stdOut, stdErr)
    -- print("here")
    -- print(exitCode, stdOut, stdErr)
  -- end, function(task, stdOut, stdErr)
    -- print("there")
    -- print(task, stdOut, stdErr)
  -- return false
-- end, { "https://www.youtube.com/watch?v=fpvN3BUMXCE" })
-- task:start()
-- end)

-- hotkey.bind(meh, "V", function()
  -- local task = hs.task.new("/usr/local/bin/streamlink", function(exitCode, stdOut, stdErr)
    -- print(exitCode, stdOut, stdErr)
  -- end, function(task, stdOut, stdErr)
    -- print(task, stdOut, stdErr)
  -- return false
-- end, { "--player=/usr/local/bin/mpv", "twitch.tv/shroud" })
-- task:start()
-- end)
--}}}

--{{{ Smart config reload
-- Reload config if any lua file was changed
-- https://www.hammerspoon.org/go/#fancyreload
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
--}}}
