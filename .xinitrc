[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
sh ~/.fehbg
exec spectrwm
