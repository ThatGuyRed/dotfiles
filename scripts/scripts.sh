web-build() {
  cd /nfs/alpha/website/main && bundle exec jekyll build && cd ~/
}
fzd() {
  cd "$(fd -t d | fzf)"
}

ts() {
  ~/.config/scripts/ts.sh $1
}

tvim() {
  ~/.config/scripts/tmux_ide_v2.sh $1
}

paclean() {
  ~/.config/scripts/pacclean.sh
}

neofetch() {
  fastfetch
}

calcurse() {
  calcurse -D ~/Documents/calcurse
}

calcurse_dedupe() { 
  ~/.config/scripts/post_import_dedupe
}

matlab() {
  sudo docker run -v matlab:/home/matlab/Documents -it --rm -p 8888:8888 --shm-size=512M mathworks/matlab:latest -browser
}

reboot() {
  loginctl reboot
}

shutdown() {
  loginctl poweroff
}

ltspice() {
  wine ~/.wine/drive_c/Program\ Files/LTC/LTspiceXVII/XVIIx64.exe & disown
}
