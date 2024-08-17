-- https://www.hammerspoon.org/Spoons/SpoonInstall.html
hs.loadSpoon("SpoonInstall")
-- spoon.SpoonInstall:installSpoonFromZipURL("https://github.com/scottwhudson/Lunette/blob/master/Spoons/Lunette.spoon.zip?raw=true")
-- hs.loadSpoon("Lunette")
-- spoon.Lunette:bindHotkeys()

spoon.SpoonInstall:andUse("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local function changeVolume(diff)
	return function()
		local current = hs.audiodevice.defaultOutputDevice():volume()
		local new = math.min(100, math.max(0, math.floor(current + diff)))
		if new > 0 then
			hs.audiodevice.defaultOutputDevice():setMuted(false)
		end
		if new % 5 ~= 0 then
			new = math.min(100, (new // 5 + 1) * 5)
		end
		hs.alert.closeAll(0.0)
		hs.alert.show("Volume " .. new .. "%", {}, 0.5)
		hs.audiodevice.defaultOutputDevice():setVolume(new)
	end
end

local function changeBrightness(diff)
	return function()
		local current = hs.screen.mainScreen():getBrightness() * 100
		local new = current + diff
		if new < 5 then
			new = 5
		end
		if new > 80 then
			new = 80
		end
		hs.alert.closeAll(0.0)
		hs.alert.show("Brightness " .. math.ceil(new) .. "%", {}, 0.5)
		hs.screen.mainScreen():setBrightness(new / 100)
	end
end

local function startApp(name)
	return function()
		hs.application.launchOrFocus(name)
	end
end

local function toggleFocusedWin(spacex, spacey)
	return function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local screen = win:screen()
		local max = screen:frame()

		if f.w ~= max.w then
			win:maximize(0)
		else
			f.x = max.x + max.w * spacex
			f.y = max.y + max.h * spacey
			f.w = max.w * (1 - spacex * 2)
			f.h = max.h * (1 - spacey * 2)
			win:setFrame(f)
		end
	end
end

local function showDateTime()
	return function()
		hs.alert.closeAll(0.0)
		hs.alert.show(os.date("%x") .. "\n" .. os.date("%X"), { textSize = 64 })
	end
end

local function goWeb(url)
	return function()
		hs.urlevent.openURL(url)
	end
end

hs.hotkey.bind({ "ctrl", "option", "cmd" }, "j", changeVolume(-5))
hs.hotkey.bind({ "ctrl", "option", "cmd" }, "k", changeVolume(5))
hs.hotkey.bind({ "ctrl", "option", "cmd" }, "h", changeBrightness(-5))
hs.hotkey.bind({ "ctrl", "option", "cmd" }, "l", changeBrightness(5))
hs.hotkey.bind({ "cmd", "shift" }, "c", toggleFocusedWin(0.1, 0))
hs.hotkey.bind({ "cmd", "shift" }, "v", toggleFocusedWin(0.2, 0.1))
hs.hotkey.bind({ "cmd", "shift" }, "space", showDateTime())
hs.hotkey.bind({ "cmd", "shift" }, "J", startApp("Google Chrome"))
hs.hotkey.bind({ "cmd", "shift" }, "K", startApp("Alacritty"))
hs.hotkey.bind({ "cmd", "shift" }, "M", startApp("Messages"))
hs.hotkey.bind({ "cmd", "shift" }, "W", startApp("Wechat"))
hs.hotkey.bind({ "cmd", "shift" }, "G", startApp("Mail"))
hs.hotkey.bind({ "cmd", "shift" }, "Y", goWeb("https://www.youtube.com"))
hs.hotkey.bind({ "cmd", "shift" }, "A", goWeb("https://www.amazon.com"))

hs.hotkey.bind({ "ctrl", "shift" }, "escape", startApp("Activity Monitor"))
hs.alert.show("Config Reloaded")
