function parse_git_dirty {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]]; then
    echo " ⌁"
  fi
}
function parse_git_needs_push {
  if [[ $(git status 2> /dev/null | grep 'Your branch is ahead') ]]; then
    echo " ↗"
  fi
}

function number_of_background_jobs {
  number_of_jobs=$(jobs | wc -l | tr -d ' ')
  if [[ $number_of_jobs != "0" ]]; then
    echo "⎌ $number_of_jobs "
  fi
}

PS1='→ `fancy_directory` $(__git_ps1 "⎇ %s$(parse_git_dirty)$(parse_git_needs_push) ")`number_of_background_jobs`\[\033[00;33m\]$\[\033[00m\] '; export PS1
