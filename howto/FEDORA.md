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
