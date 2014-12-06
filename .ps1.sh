function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo " ⨳"
}
function parse_git_needs_push {
  [[ $(git status 2> /dev/null | grep 'Your branch is ahead') ]] && echo " ↗↗"
}

function number_of_background_jobs {
  NUMBER_OF_JOBS=$(jobs | wc -l | tr -d ' ')
  [[ $NUMBER_OF_JOBS != "0" ]] && echo " $NUMBER_OF_JOBS ↺ "
}

PS1='➙ `fancy_directory` $(__git_ps1 "⎇ %s$(parse_git_dirty)$(parse_git_needs_push) ")`number_of_background_jobs`\[\033[00;33m\]$\[\033[00m\] '; export PS1
