function directory_to_titlebar {
  printf "\033]0;%s\007" `fancy_directory`
}

function fancy_directory {
    local pwd_length=42  # The maximum length we want (seems to fit nicely
                         # in a default length Terminal title bar).

    # Get the current working directory.  We'll format it in $dir.
    local dir="$PWD"     

    # Substitute a leading path that's in $HOME for "~"
    if [[ "$HOME" == ${dir:0:${#HOME}} ]] ; then
        dir="~${dir:${#HOME}}"
    fi
    
    export WORK=/Volumes/Work
    # Substitute a leading path that's in $WORK for "w"
    if [[ "$WORK" == ${dir:0:${#WORK}} ]] ; then
        dir="w${dir:${#WORK}}"
    fi
    
    # Append a trailing slash if it's not there already.
    if [[ ${dir:${#dir}-1} != "/" ]] ; then 
        dir="$dir"
    fi

    # Truncate if we're too long.
    # We preserve the leading '/' or '~/', and substitute
    # ellipses for some directories in the middle.
    if [[ "$dir" =~ (~){0,1}/.*(.{${pwd_length}}) ]] ; then  
        local tilde=${BASH_REMATCH[1]}
        local directory=${BASH_REMATCH[2]}
        
        # At this point, $directory is the truncated end-section of the 
        # path.  We will now make it only contain full directory names
        # (e.g. "ibrary/Mail" -> "/Mail").
        if [[ "$directory" =~ [^/]*(.*) ]] ; then
            directory=${BASH_REMATCH[1]} 
        fi
        
        # Ellipsis
        dir="$tilde/...$directory"
    fi

    # Don't embed $dir directly in printf's first argument, because it's 
    # possible it could contain printf escape sequences.
    # printf "\033]0;%s\007" "$dir"
    # printf "➙ \033]0;%s\007" "$dir"
    echo "$dir"
}

if [[ "$TERM" == "xterm" || "$TERM" == "xterm-color" ]] ; then
export PROMPT_COMMAND="directory_to_titlebar"
fi

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
PS1='➙ `fancy_directory`\n\[\033[00;33m\]$\[\033[00m\] '; export PS1

# fix rubygems
# export GEM_HOME="/Library/Ruby/Gems/1.8"
# export GEM_PATH="/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/lib/ruby/gems/1.8"

# make cap1 work too
alias cap1="`which cap` _1.4.1_" 
alias gemserv="gem server -d /Library/Ruby/Gems/1.8"
alias flushdns="dscacheutil -flushcache"

# run specs for project
alias bac="e bacon spec/*_spec.rb spec/**/*_spec.rb"

# git stuff
alias gs="git status"
alias gall="git add . && git commit -a"

# source ~/.git-completion.sh
# complete -o default -o nospace -F _git gh


export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true


alias pg_hickey_start="pg_ctl -D /usr/local/var/hickey -l /usr/local/var/hickey/server.log start"
alias pg_hickey_start="pg_ctl -D /usr/local/var/hickey stop -s -m fast"

function r {
  if [ -a .bundle ]
  then
  bundle exec ruby $@
  else
  ruby $@
  fi
}

function e {
  if [ -a .bundle ]
  then
  bundle exec $@
  else
  $@
  fi
}

alias twd=new_terminal_working_directory
function new_terminal_working_directory() {
osascript <<END 
tell application "Terminal"
  tell application "System Events" to tell process "Terminal" to keystroke "t" using command down
  do script "cd \"$(pwd)\"" in first window
end tell
END
}

alias cf=copy_finder_window_path
function copy_finder_window_path() {
osascript <<END
tell application "Finder"
	set the_folder to (the target of the front window) as alias
	set the_path to (get POSIX path of the_folder)
	set the clipboard to the_path as text
end tell
END
}

alias gf="cf && cd \`pbpaste\` && clear && pwd"

export EDITOR="vico -w"

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
# You only want this if you are on Snow Leopard
export ARCHFLAGS='-arch x86_64'

# History: don't store duplicates
export HISTCONTROL=erasedups
# History: 10,000 entries
export HISTSIZE=10000

# REE for LivingSocial
export RUBY_HEAP_FREE_MIN=1024
export RUBY_HEAP_MIN_SLOTS=4000000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_GC_MALLOC_LIMIT=500000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1

# bash-completion

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# RVM
export CC=gcc-4.2
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

