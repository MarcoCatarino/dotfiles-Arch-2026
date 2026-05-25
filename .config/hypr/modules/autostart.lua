-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
   hl.exec_cmd("sleep 2 && hyprctl reload")
   hl.exec_cmd("waybar")
   hl.exec_cmd("swaync")
   hl.exec_cmd("awww-daemon")
   hl.exec_cmd("hypridle")
end)
