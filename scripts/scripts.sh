web-build() {
  cd /nfs/alpha/website/main && bundle exec jekyll build && cd ~/
}
fzd() {
  cd "$(fd -t d | fzf)"
}
