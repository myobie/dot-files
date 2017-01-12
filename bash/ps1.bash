function parse_git_dirty {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]]; then
    echo " dirty"
  fi
}
function parse_git_needs_push {
  if [[ $(git status 2> /dev/null | grep 'Your branch is ahead') ]]; then
    echo " ahead"
  fi
}

function number_of_background_jobs {
  number_of_jobs=$(jobs | wc -l | tr -d ' ')
  if [[ $number_of_jobs != "0" ]]; then
    echo "bg($number_of_jobs) "
  fi
}

PS1='`fancy_directory` $(__git_ps1 "git(%s$(parse_git_dirty)$(parse_git_needs_push)) ")`number_of_background_jobs`\[\033[00;33m\]$\[\033[00m\] '; export PS1
