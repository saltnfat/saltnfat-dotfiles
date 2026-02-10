#!/bin/bash

PROJECT_DIR=~/jwy-gh0stzk-dotfiles
XDG_CONFIG_HOME=~/.config
LOCAL_DIR=~/.local

THEME_FILES=(
  # dots/config/alacritty/rice-colors.toml
  # dots/config/bspwm/.rice
  # dots/config/bspwm/dunstrc
  # dots/config/bspwm/jgmenurc
  # dots/config/bspwm/picom.conf
  # dots/config/bspwm/scripts/Launcher.rasi
  # dots/config/bspwm/scripts/NetManagerDM.rasi
  # dots/config/bspwm/scripts/system.ini
  # dots/config/bspwm/scripts/WallSelect.rasi
  # dots/config/eww/colors.scss
  # dots/config/mpd/state
)

# Non intrusive way of adding custom styling to kitty conf without overwriting
# existing conf
addGlobalIncludesToKittyConf() {

  if [ ! -d $XDG_CONFIG_HOME/kitty ]; then
    mkdir -p $XDG_CONFIG_HOME/kitty
  fi
  if [ ! -f $XDG_CONFIG_HOME/kitty/kitty.conf ]; then
    touch $XDG_CONFIG_HOME/kitty/kitty.conf
  fi
  if ! grep -Fxq "globinclude kitty.d/**/*.conf" $XDG_CONFIG_HOME/kitty/kitty.conf; then
    bash -c "echo globinclude kitty.d/**/*.conf >> $XDG_CONFIG_HOME/kitty/kitty.conf"
  fi
}
