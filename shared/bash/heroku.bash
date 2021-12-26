if [[ -n $(which brew) ]]; then
  export PATH="${PATH}:$(brew --prefix)/heroku/bin"
fi
