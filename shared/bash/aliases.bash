alias cls='printf "\033c"'
alias ll='ls -lah'
alias flush_deno_file_cache='rm -rf $HOME/Library/Caches/deno/gen/file'

alias zj='zellij'
alias zja='zellij attach'

if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ssh='kitten ssh'
fi
