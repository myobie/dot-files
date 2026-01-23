# Inspired by https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh

# Capture exit code before anything else runs
PROMPT_COMMAND='__last_exit=$?'

function last_exit_code {
  if [[ $__last_exit != 0 ]]; then
    echo -n "[$__last_exit] "
  fi
}

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

PS1='\[\033[00;31m\]$(last_exit_code)\[\033[00m\]'
PS1+='$(number_of_background_jobs)'
PS1+='\[\033[00;33m\]$\[\033[00m\] '

if [[ "$(type -t __git_ps1)" == "function" ]]; then
  PS1="\$(__git_ps1 \"git(%s\$(count_git_ahead_behind)) \")${PS1}"
fi

PS1="\$(pwd) ${PS1}"

export PS1
