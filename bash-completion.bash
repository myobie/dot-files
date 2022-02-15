if [[ -n $(which brew) ]]; then
  if [ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]; then
    . $(brew --prefix)/etc/profile.d/bash_completion.sh
  fi
fi
