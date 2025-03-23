# Add callable to Rofi menu:
e.g.:

    IntelliJ: 
        Untar binaries to /opt/...


Add desktop entry to $HOME/.local/share/applications/*.desktop:

```
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA
Icon=/opt/idea/idea-IC-243.24978.46/bin/idea.png
Exec="/opt/idea/idea-IC-243.24978.46/bin/idea" %f
iComment=IntelliJ IDEA Integrated Development Environment
Categories=Development;IDE;
Terminal=false
```


# Keyboard layout

.config/sway/config

input "type:keyboard" {
    xkb_layout "us,rs,rs"
    xkb_variant ",latin,"
    xkb_options "grp:ctrl_shift_toggle"
}

# Monitor orientation

Identify Monitor Names: First, identify the names of your monitors using the command:
swaymsg -t get_outputs

Adjust Monitor Positions: Use the swaymsg command to set the position of each monitor. For example, to place HDMI-A-2 to the right of eDP-1, you would use:

swaymsg output HDMI-A-2 pos 2560 0

Toggle Monitors On/Off: If you need to toggle a monitor on or off, you can use:
swaymsg output HDMI-A-2 toggle

Persistent Configuration: To make these changes persistent, add the configuration to your Sway config file (~/.config/sway/config). For example:
output eDP-1 {
    pos 0 0
    mode 2560x1440
}

output HDMI-A-2 {
    pos 2560 0
    mode 1920x1080
}

Scaling Considerations: If you are using scaling, ensure the positions are adjusted accordingly. For example, if eDP-1 has a scale of 2, the position of HDMI-A-2 should be divided by the same factor:

swaymsg output HDMI-A-2 pos 1280 0

