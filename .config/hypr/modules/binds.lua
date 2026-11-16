------------------
---- PROGRAMS ----
-- ---------------

local menu = "pkill rofi || env LANG=en_US.UTF-8 rofi -show drun -show-icons"
local sleep = "pkill wlogout || wlogout"

local terminal = "ghostty"
local terminalSecond = "kitty"

local codeMain = "code"
local codeSecond = "ghostty -e nvim"
local fileManager = "nautilus"
local textEditor = "gnome-text-editor"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local secondMod = "ALT"
local thirdMod = "CTRL"

-- Manu
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))

-- Menu Config
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("/home/developer/.config/rofi/scripts/menuPersonalizacion.sh"))

-- Magic Space
hl.bind(secondMod .. " + Space", hl.dsp.workspace.toggle_special("magic"))

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

-- Browsers
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("chromium"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("microsoft-edge-stable"))

-- Daily Apps
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(textEditor))

-- Custom Apps (media)
hl.bind(thirdMod .. " + SHIFT + 1", hl.dsp.exec_cmd("chromium --app=https://www.youtube.com/"))
hl.bind(thirdMod .. " + SHIFT + 2", hl.dsp.exec_cmd("spotify"))
hl.bind(thirdMod .. " + SHIFT + 3", hl.dsp.exec_cmd("chromium --app=https://web.whatsapp.com/"))
hl.bind(thirdMod .. " + SHIFT + 4", hl.dsp.exec_cmd("chromium --app=https://gmail.com/"))
hl.bind(thirdMod .. " + SHIFT + 5", hl.dsp.exec_cmd("discord"))

-- Code Apps (coder) [CTRL + N#]
hl.bind(thirdMod .. " + 1", hl.dsp.exec_cmd("chromium --app=https://github.com/MarcoCatarino?tab=repositories"))
hl.bind(thirdMod .. " + 2", hl.dsp.exec_cmd("dbeaver"))
hl.bind(thirdMod .. " + 3", hl.dsp.exec_cmd("chromium --app=https://hub.docker.com/repositories/marcod3002"))
hl.bind(thirdMod .. " + 4", hl.dsp.exec_cmd("chromium --app=https://console.cloud.google.com/welcome?hl=es-419&organizationId=0"))
hl.bind(thirdMod .. " + 5", hl.dsp.exec_cmd("chromium --app=https://cloud.mongodb.com/v2#/org/65f1b83fa448983fb46da6fb/projects"))
hl.bind(thirdMod .. " + 6", hl.dsp.exec_cmd("postman"))
hl.bind(thirdMod .. " + 7", hl.dsp.exec_cmd("chromium --app=https://figma.com"))

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("firefox --new-window https://github.com/MarcoCatarino?tab=repositories"))

-- Custom AI (ai apps) [ALT + SHIFT + N#]
hl.bind(secondMod .. " + SHIFT + F1", hl.dsp.exec_cmd("chromium --app=https://claude.ai/new"))
hl.bind(secondMod .. " + SHIFT + F2", hl.dsp.exec_cmd("chromium --app=https://gemini.google.com/app?hl=es"))
hl.bind(secondMod .. " + SHIFT + F3", hl.dsp.exec_cmd("chromium --app=https://chatgpt.com/"))
hl.bind(secondMod .. " + SHIFT + F4", hl.dsp.exec_cmd("chromium --app=https://copilot.com/"))
hl.bind(secondMod .. " + SHIFT + F5", hl.dsp.exec_cmd("chromium --app=https://cursor.com/agents"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o $HOME/Imagens/Screens"))

-- Keyboard custom + Emojis
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd("rofimoji --action copy"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd("/home/developer/.config/hypr/scripts/keyboardToggle.sh"))

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

-- Navigate between windows
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
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Backslash", hl.dsp.layout("togglesplit"))


-- Window Resize
hl.bind(mainMod .. " + bracketleft",  hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + bracketright", hl.dsp.window.resize({ x = 100,  y = 0, relative = true }))

hl.bind(mainMod .. " + SHIFT + bracketleft",  hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.resize({ x = 0, y = 100,  relative = true }))

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

