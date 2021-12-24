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

if [[ "$TERM" == "xterm" || "$TERM" == "xterm-color" || "$TERM" == "xterm-256color" ]] ; then
export PROMPT_COMMAND="directory_to_titlebar"
fi

export fancy_directory

if [[ "$0" == "$BASH_SOURCE" ]]; then
  fancy_directory
fi
