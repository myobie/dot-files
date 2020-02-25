# Inspired by https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
function count_git_ahead_behind {
  local count
  local commits

  if commits="$(git rev-list --left-right @{upstream}...HEAD 2>/dev/null)"
  then
    local commit behind=0 ahead=0
    for commit in $commits
    do
      case "${commit}" in
        "<"*) ((behind++)) ;;
        *)    ((ahead++))  ;;
      esac
    done
    count="${behind}	${ahead}"
  else
    count=""
  fi

  case "$count" in
  "") # no upstream
    echo -n "" ;;
  "0	0") # equal to upstream
    echo -n "" ;;
  "0	"*) # ahead of upstream
    echo -n " ${count#0	}↑" ;;
  *"	0") # behind upstream
    echo -n " ${count%	0}↓" ;;
  *)	    # diverged from upstream
    echo -n " ${count#*	}↓ ${count%	*}↑" ;;
  esac
}

function number_of_background_jobs {
  number_of_jobs=$(jobs | wc -l | tr -d ' ')
  if [[ $number_of_jobs != "0" ]]; then
    echo "bg($number_of_jobs) "
  fi
}

export GIT_PS1_SHOWDIRTYSTATE=true

PS1='`fancy_directory` $(__git_ps1 "git(%s$(count_git_ahead_behind)) ")`number_of_background_jobs`\[\033[00;33m\]$\[\033[00m\] '; export PS1
