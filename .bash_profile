. ~/.fancy_directory.sh
. ~/.ps1.sh

export EDITOR="vim"
alias flushdns="dscacheutil -flushcache"
alias git=hub
alias code="cd ~/Dropbox/Code"
alias W="cd ~/W/"

# random env stuff
export FAKE_POSTS=true
export JEKYLL_ENV=development
export ANDROID_HOME=/usr/local/opt/android-sdk
# History: don't store duplicates
export HISTCONTROL=erasedups
# History: 10,000 entries
export HISTSIZE=10000

# PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:~/bin:/Applications/Xcode.app/Contents/Developer/usr/bin:/usr/local/share/npm/bin:$PATH"

# basic ls
if [ `uname` = 'Darwin' ]; then
  alias ls='ls -FG'
  alias mv='mv -nv'
else
  alias ls='ls -p --color'
  alias mv='mv -v'
fi
alias ll='ls -lah'

# go
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=~/.gocode

# haskell
export PATH=$PATH:~/.cabal/bin:/Users/myobie/Library/Haskell/bin/

# ruby

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

# node
export NODE_PATH="/usr/local/lib/node_modules"

# colors
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

# via mojombo http://gist.github.com/180587
function psg {
  ps wwwaux | egrep "($1|%CPU)" | grep -v grep
}

# sweetness from tim pease
p() {
  if [ -n "$1" ]; then
    ps -O ppid -U $USER | grep -i "$1" | grep -v grep
  else
    ps -O ppid -U $USER
  fi
}

pkill() {
  if [ -z "$1" ]; then
    echo "Usage: pkill [process name]"
    return 1
  fi

  local pid
  pid=$(p $1 | awk '{ print $1 }')

  if [ -n "$pid" ]; then
    echo -n "Killing \"$1\" (process $pid)..."
    kill -9 $pid
    echo "done."
  else
    echo "Process \"$1\" not found."
  fi
}

# bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# xcode stuff
alias iphone='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'

# git-completion
# if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash  ]; then
#   . `brew --prefix`/etc/bash_completion.d/git-completion.bash
# fi

# git shortcuts
function search-history {
  git log --pretty=format:'%h was %an, %ar, message: %s' | grep $@ | less
}

# extras that shouldn't be in the repo?
if [ -f ~/.bash_extras  ]; then
  . ~/.bash_extras
fi

# disable control s
stty stop ''

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
