------------------
---- PROGRAMS ----
-- ---------------

local menu = "pkill rofi || env LANG=en_US.UTF-8 rofi -show drun -show-icons"
local sleep = "pkill wlogout || wlogout"

local terminal = "ghostty"
local terminalSecond = "kitty"

local codeMain = "code"
local codeSecond = "ghostty -e nvim"
local nvimSearch = "~/.config/hypr/scripts/nvim-selector.sh"

local fileManager = "nautilus"
local textEditor = "gnome-text-editor"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local secondMod = "ALT"

-- Manu
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))

-- Menu Config
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("/home/developer/.config/rofi/scripts/menuPersonalizacion.sh"))

-- Kill Action
local closeWindowBind =  hl.bind(mainMod .. " + Backspace", hl.dsp.window.close())

-- WLOGOUT
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(sleep))

-- Terminals
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminalSecond))

-- IDE Code
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(codeMain))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(codeSecond))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(nvimSearch))

-- Browsers
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("chromium"))

-- Daily Apps
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(textEditor))

-- Magic Space
hl.bind(secondMod .. " + Space", hl.dsp.workspace.toggle_special("magic"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o $HOME/Imagens/Screens"))



----------------------
---- Window Rules ----
----------------------

-- Switch workspaces with mainMod + [0-9]
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end

for i = 1, 5 do 
  local targetWorkspace = i + 5
  hl.bind(secondMod .. " + " .. i,             hl.dsp.focus({ workspace = targetWorkspace }))
  hl.bind(secondMod .. " + SHIFT + " ..i,      hl.dsp.window.move({ workspace = targetWorkspace }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Navigate between windows active
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "m-1" }))

-- Focus Window
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Exchange/Replace Window Position
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Window Specials
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Backslash", hl.dsp.layout("togglesplit"))

-- Resize Window


----------------------
---- Custom Basic ----
----------------------

-- SSH Shorts
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("pkill waybar && sleep 2 && waybar &")) -- Reload Waybar

-- Multimedia Custom 
hl.bind(secondMod .. " + F11", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind(secondMod .. " + F12", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind(secondMod .. " + F9", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind(secondMod .. " + F10", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind(secondMod .. " + SHIFT + F9", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(secondMod .. " + SHIFT + F10", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))



--------------------
---- BY DEFAULT ----
--------------------

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia Default
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

