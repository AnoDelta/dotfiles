# Don't delete this line. This thing checks if the shell is interactive. You have been warned.
if [[ $- != *i* ]] ; then
	return
fi

export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia

# if you want to use these aliases... I won't stop you... >:3
alias emacs='emacsclient -nw -a ""'
export EDITOR='emacsclient -c -a ""'
#alias vim=emacs
#alias vi=emacs


export PATH="$PATH:$HOME/.local/bin/"
export PATH="$HOME/.local/share/flatpak/exports/bin:$PATH"
export PATH="/var/lib/flatpak/exports/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# eval "$(starship init bash)"

export GPG_TTY=$(tty)

if [ -f "$HOME/Pictures/Art/anodeltabaseturnyuhbox.gif" ]; then
	chafa $HOME/Pictures/Art/anodeltabaseturnyuhbox.gif
fi
clear
fastfetch
