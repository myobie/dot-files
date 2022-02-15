if [[ -n "$(which hub)" ]]; then
  eval "$(hub alias -s)"
fi

search-history() {
  git log --pretty=format:'%h was %an, %ar, message: %s' | grep $@ | less
}

clone() {
  org=$(echo $1 | awk -F/ '{ print $1 }')
  mkdir -p ~/src/github.com/$org
  path=~/src/github.com/$1
  hub clone $@ $path
  cd $path
}

src() {
  local dir

  if [[ "$@" == "" ]]; then
    dir=$(fd -t d -d 6 . ~/src 2>/dev/null | fzf +m)
  else
    dir=$(fd -t d -d 6 . ~/src 2>/dev/null | fzf +m -f "$@" | head -n 1)
  fi

  cd "$dir"
}
