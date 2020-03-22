# myobie’s .dot-files

## `./install.rb`

This is what I use when I setup a new computer. There are some nice ruby functions in `support.rb` to do common tasks so it’s worth a look.

It basically:

1. symlinks important files
2. Installs ruby, elixir, redis, etc
3. creates `.vim/backup` to store `.swp` files
4. runs `vim-plug`’s install function

## `vim` 8

I use `vim-plug` to manage my vim plugins.

### `.vimrc`

The plugins I use the most are:

* `fzf` - very easy to install and use. I set an ENV var to for it to use `ag` for filename searches so it respects `.gitignore` and stuff like that.
* `vim-surround` - without this I would lose my mind. I love being able to swap quotes or wrap in parens, etc.
* `vim-ragtag` - when working with html I like to be able to type `h1C-x<Enter>` and it will make `h1` tags on new lines with an indented line in-between.
* `vim-polyglot` - becuase I am not too lazy to go find all the different plugins I need for every language

#### Other highlights

* I’m using the `default` color scheme. I know this is crazy, but I find it easier to read.
* Map leader + t to `:FZF`
* Map control + l to insert `=>` - this is something I still use because of using TextMate for so long
* Gotta add all the ruby files without extensions to appear as ruby files
* Setting `.json` files to `javascript` is really helpful
* `set backspace=indent,eol,start` so one can backspace in a sane way

#### Related

* I use SF Mono as my typeface. There still is no better programmer font and it’s already installed. (It’s important to me that the * is in the middle and not superscript.)

## bash

I use `bash`. Sorry, but I just don’t think `zsh` is that much better and `bash` is installed everywhere.

I currently have three files for `bash` related things:

### `fancy_directory.sh`

I copied and modified this from someone online years ago, but I’ve now forgotten exactly where it came from. Basically it will make sure each terminal tab includes the `pwd`, but in a more fancy way: use `~` for home and use `...` in the middle if the path is long. Putting the `...` in the middle is a critical feature. I also use this function in my `PS1`.

### `ps1.sh`

I’m not using crazy colors or anything, but I do want to know the name of the current git branch, if it’s dirty, if there are un-pushed commits, and if there are any background processes (like with `fg` and stuff).

I’ve made three functions to parse if the current branch is dirty and output some unicode char that looks like a snowflake, to parse if the current branch has un-pushed commits and output some unicode arrows pointing up to the git’s in the sky, and one to parse the number of background jobs. The functions are good to output nothing if their conditions are false.

I also prefer to type next to dollar sign and I also like that dollar sign to be yellow.

### `profile`

I am still trying to organize this file and I may pull it further apart into more files. But for now, it has sections for:

* `EDITOR` (which is, of course, vim)
* aliases (the best is `git=hub`)
* `env` vars
* `PATH`
* go related vars
* haskell related vars
* node related vars
* terminal color vars
* functions for gripping and killing processes easier (`p` and `pkill` being the most used)
* `bash` completion using `brew`
* a function to search through git’s history easier
* loading `.bash_extras` so I can put local-only config stuff in on each device
* disabling control + s, which is annoying

### `.bash_extras`

This file is in `.gitignore` because this is where you put `env` vars or other functions that shouldn’t be public. Like your AWS credentials or what have you. This has worked out great and has kept me from accidentally sharing my credentials for all my stuffs.

## `git`

### `.gitconfig`

Has my name and email (which match what’s on GitHub so my commits are linked to my account), that I want to use colors, that I want to use the OS X keychain to store any credentials, what my github username is (for `hub`), that I want to use my personal heroku account by default (it’s possible to have multiple accounts), and that I like [simple pushes](https://www.youtube.com/watch?v=cMBh8P1m9Wo).

### `.gitignore`

Ignore `.bash_extras`, `.DS_Store` crap files :shakingfist:, and leiningen stuff.

## `ruby`

### `.irbrc`

Turns on completion, which is amazing. Also changes the prompt to the simple version, which is way better. Stores a history in a file, uses deadline, and uses auto indent (which means in blocks it’s indented which is cool). It also uses a constant to know if it’s been loaded before so it only ever runs once, which I had never thought of until I saw this online somewhere years ago (sorry, I forgot where).

## `tmux`

### `.tmux.conf`

I like to split horizontally with `|` and vertically with `-`. It makes more sense to me. I also added `vim`-like bindings for moving between windows (hjkl). And I finally got the mouse scrolling to work, so I can enable scroll mode and actually go back in time to find something.

## No automated yet (GPG)

```
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent
```
