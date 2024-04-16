search-history() {
  git log --pretty=format:'%h was %an, %ar, message: %s' | grep $@ | less
}

# Inspried by: https://gist.github.com/jordan-brough/48e2803c0ffa6dc2e0bd
recent-branch() {
  branch=$(git reflog |
    egrep -io "moving from ([^[:space:]]+)" |
    awk '{ print $3 }' | # extract 3rd column
    awk ' !x[$0]++' | # Removes duplicates.  See http://stackoverflow.com/questions/11532157
    egrep -v '^[a-f0-9]{40}$' | # remove hash results
    fzf +m
  )

  git switch $branch
}

clone() {
  org=$(echo $1 | awk -F/ '{ print $1 }')
  mkdir -p ~/src/github.com/$org
  path=~/src/github.com/$1
  git clone https://github.com/$@.git $path
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
