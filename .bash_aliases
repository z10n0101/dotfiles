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
