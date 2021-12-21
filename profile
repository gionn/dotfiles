# ~/.profile: executed by the command interpreter for login shells.
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ $GDMSESSION == 'i3' ]]; then
  if xrandr | grep 'connected 3840' > /dev/null; then
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    xrdb -merge ~/.Xresources.hidpi
    xrandr --output eDP1 --off
    #xrandr --output eDP-1 --off
  else
    unset GDK_SCALE
    unset GDK_DPI_SCALE
  fi
fi

# VLC & intel BUG - crash at startup
export MESA_LOADER_DRIVER_OVERRIDE=i965

# environment customization
export LESS="-R"
export EDITOR="vim"

# aliases
alias yay='sudo apt-get -q update && sudo apt -q dist-upgrade -y && sudo apt -qq autoremove -y && sudo apt -qq clean && sudo snap refresh'
