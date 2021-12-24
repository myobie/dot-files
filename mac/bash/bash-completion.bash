if [[ -n $(which brew) ]]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    # NOTE: there is some sort of error in this script provided by brew
    set +e
    . $(brew --prefix)/etc/bash_completion
    set -e
  fi
fi