web-build() {
  cd /nfs/alpha/website/main && bundle exec jekyll build && cd ~/
}
fzd() {
  cd "$(fd -t d | fzf)"
}

ts() {
  ~/.config/scripts/ts.sh
}

tvim() {
  ~/.config/scripts/tmux_ide_v2.sh
}
