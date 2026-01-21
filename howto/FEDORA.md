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

Adjust Monitor Positions: Use the swaymsg command to set the position of each monitor. For example, to place DP-3 to the right of eDP-1, you would use:

swaymsg output DP-3 pos 2560 0

or to put eDP-1 to the right 

swaymsg output DP-3 pos 0 0
swaymsg output eDP-1 pos 2560 240

Toggle Monitors On/Off: If you need to toggle a monitor on or off, you can use:
swaymsg output DP-3 toggle

Persistent Configuration: To make these changes persistent, add the configuration to your Sway config file (~/.config/sway/config). For example:
output eDP-1 {
    pos 0 0
    mode 2560x1440
}

output DP-3 {
    pos 2560 0
    mode 1920x1080
}

Scaling Considerations: If you are using scaling, ensure the positions are adjusted accordingly. For example, if eDP-1 has a scale of 2, the position of HDMI-A-2 should be divided by the same factor:

swaymsg output DP-3 pos 1280 0


# Video


ERROR: Codec not supported: VLC could not decode the format "hevc" (MPEG-H Part2/HEVC (H.265)) 

    https://rpmfusion.org/Configuration

    Command Line Setup using rpm

    To enable access to both the free and the nonfree repository use the following command:

        Fedora with dnf:

        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

        On Fedora, we default to use the openh264 library, so you need the repository to be explicitly enabled.

            On Fedora 41 and later:

            sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

sudo dnf-3 groupinstall multimedia
sudo dnf-3 groupupdate multimedia


Fix datetime after reboot:
sudo timedatectl set-timezone Europe/Belgrade


# Batery life

# install Dell tool
sudo dnf install smbios-utils

# Primer: Počni punjenje tek kad padne ispod 50%, i stani na 80%
sudo smbios-battery-ctl --set-custom-charge-interval 50 80


# TLP i Thermald (Obavezno) Instaliraj ova dva servisa:

    TLP: Automatski gasi nepotrebne uređaje kad si na bateriji (bluetooth, audio power save...).

    Thermald: Intelov demon koji sprečava pregrevanje pre nego što hardware throttle-uje.
sudo apt install tlp thermald
sudo systemctl enable --now tlp
sudo systemctl enable --now thermald

D) Auto-cpufreq (Modernija alternativa TLP-u) Mnogi korisnici XPS-a se kunu u alat koji se zove auto-cpufreq. On aktivno menja frekvenciju procesora i "governor" (način rada) u zavisnosti od toga da li si na bateriji ili punjaču. Često daje bolje rezultate nego običan TLP.



# TODO istrazi opcije za tlp auto-cpufreq ( jedno ili drugo, ne oba da koristis u isto vreme) i thermald (ovo ide automatski)


