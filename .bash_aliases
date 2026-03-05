alias myscrot='scrot ~/Pictures/Screenshots/%b%d::%H%M%S.png'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

drmi() {
	docker rmi $(docker images --format '{{.Repository}}:{{.Tag}}' | grep '$1')
}

asdf() {
	echo "DP-3 0 0 & eDP-1 2560 240"
	swaymsg output DP-3 pos 0 0
	swaymsg output eDP-1 pos 2560 240
}

alias nvidia-run="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"

# --- DIAGNOSTIC ALIASES (Dell XPS Optimization) ---

# 1. Brzi pregled stanja (Temperatura, Takt, RAM)
sys-check() {
    echo -e "\n\033[1;33m--- CPU TEMPERATURA ---\033[0m"
    sensors | grep "Package id 0"

    echo -e "\n\033[1;36m--- CPU FREKVENCIJA (Min - Max) ---\033[0m"
    grep "cpu MHz" /proc/cpuinfo | awk '{print $4}' | sort -n | sed -n '1p;$p' | xargs echo "MHz"

    echo -e "\n\033[1;32m--- NVIDIA STATUS ---\033[0m"
    if command -v nvidia-smi &> /dev/null; then
        nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,memory.used --format=csv,noheader | awk -F, '{print "Load: "$1", Temp: "$2", Mem: "$3}'
    else
        echo "Nvidia drajver nije aktivan ili je kartica isključena."
    fi

    echo -e "\n\033[1;35m--- MEMORIJA ---\033[0m"
    free -h | grep "Mem:" | awk '{print "Used: "$3 " / "$2}'
    echo ""
}

# 2. Monitoring Intel Grafike (Video dekodiranje) - Zahteva sudo password
alias mon-intel='echo "Gledaj kolonu VIDEO..." && sudo intel_gpu_top'

# 3. Monitoring Nvidia Grafike (Live watch)
alias mon-nvidia='watch -n 1 "nvidia-smi"'

# 4. Monitoring CPU-a (Stari dobri btop)
alias mon-cpu='btop'

# 5. Provera da li browser koristi GPU (FFmpeg/VAAPI)
alias check-codecs='vainfo'
