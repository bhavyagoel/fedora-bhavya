# User specific environment and startup programs

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep awesome || startx "~/.xinitrc"
fi

