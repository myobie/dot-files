# myobie’s .dot-files

## `install.rb`

This is what I use when I setup a new computer. There are some nice ruby functions in there to do common tasks so it’s worth a look.

It basically:

1. symlinks every file beginning with `.` into `~` if it doesn’t already exist
2. creates `.vim/bundle` and `.vim/backup`
3. runs `vundle`’s install function
4. if “command-t” is present in `ARGV`, it will try to setup `command-t` correctly. This can only be done after `rbenv` is installed.

## `vim`

I use `vundle` to manage my vim plugins, so you won’t see any plugins in my dot-files repo. I really really love this.

### `.vimrc`

My vimrc file is very unorganized. It’s kinda like my `.bash_profile` and I am just now starting to organize it better.

I get everything setup for `vundle` and list all the plugins I use. [tpope](https://github.com/tpope) really makes `vim` usable for me, I use a ton of his plugins. Thanks so much for being awesome.

The plugins I use the most are:

* `command-t` - still the best fuzzy finder ever made. I know `cntl-p` is the new hotness, but it just doesn’t jive with me. This plugin is notoriously hard to install and make a special section of my install script just for it.
* `vim-surround` - without this I would lose my mind. I love being able to swap quote or wrap in parens, etc.
* `paredit.vim` - changed my life for working in clojure.
* `vim-ragtag` - when working with html I like to be able to type `h1C-x<Enter>` and it will make `h1` tags on new lines with an indented line in-between.

I’ve commented my `.vimrc` pretty well and here are some highlights:

* I’m using the `default` color scheme. I know this is crazy, but I find it easier to read.
* I use Menlo as my typeface. There still is no better programmer font and it’s already installed. (It’s important to me that the * is in the middle and not superscript.)
* `set backupdir=~/.vim/backup` so there aren’t those `.swp` files everywhere. (Also do `set directory=~/.vim/backup`)
* Map leader + t to `:CommandT`
* Map control + l to insert `=>` - this is something I still use because of using TextMate for so long.
* The `setupMarkup` function for editing markdown files is pretty good
* Gotta add all the ruby files without extensions to appear as ruby files
* Setting `.json` files to `javascript` is really helpful
* `set backspace=indent,eol,start` so one can backspace in a sane way
* The `rspec` mappings are super useful, but I need to find a way to have them work for `minitest` as well.

### `.gvimrc`

I don’t use `MacVim` anymore, but I keep this around just in case.

## bash

I use `bash`. Sorry, but I just don’t think `zsh` is that much better and `bash` is installed everywhere. Even at work, where most everyone uses `zsh`, we use the `bash` shebang for all of our shell scripts.

I currently have three files for `bash` related things:

### `.fancy_directory.sh`

I copied and modified this from someone online years ago, but I’ve now forgotten exactly where it came from. Basically it will make sure each terminal tab includes the `pwd`, but in a more fancy way: use `~` for home and use `...` in the middle if the path is long. Putting the `...` in the middle is a critical feature. I also use this function in my `PS1`.

### `.ps1.sh`

I’m not using crazy colors or anything, but I do want to know the name of the current git branch, if it’s dirty, if there are un-pushed commits, and if there are any background processes (like with `fg` and stuff).

I’ve made three functions to parse if the current branch is dirty and output some unicode char that looks like a snowflake, to parse if the current branch has un-pushed commits and output some unicode arrows pointing up to the git’s in the sky, and one to parse the number of background jobs. The functions are good to output nothing if their conditions are false.

I also prefer to type near a dollar sign, but I also like that dollar sign to be yellow. So I used the color codes stuff to make it yellow in the `PS1`.

### `.bash_profile`

I am still trying to organize this file and I may pull it further apart into more files. But for now, it has sections for:

* `EDITOR` (which is, of course, vim)
* aliases (the best is `git=hub`)
* `env` vars
* `PATH`
* go related vars
* haskell related vars
* ruby related vars
* node related vars
* terminal color vars
* functions for gripping and killing processes easier (`p` and `pkill` being the most used)
* `bash` completion using `brew`
* a function to search through git’s history easier
* loading `.bash_extras`
* disabling control + s, which is annoying
* setting up `rbenv` the [neckbeard way](https://github.com/sstephenson/rbenv/commit/590b19a1b170c890d0e2c2934dcde06fe154613d)

### `.bash_extras`

This file is in `.gitignore` because this is where you put `env` vars or other functions that shouldn’t be public. Like your AWS credentials or what have you. This has worked out great and has kept me from accidentally sharing my credentials for all my stuffs.

## `git`

### `.gitconfig`

Has my name and email (which match what’s on GitHub so my commits are linked to my account), that I want to use colors, that I want to use the OS X keychain to store any credentials, what my github username is (for `hub`), that I want to use my personal heroku account by default (it’s possible to have multiple accounts), and that I like [simple pushes](https://www.youtube.com/watch?v=cMBh8P1m9Wo).

### `.giti	gnore`

Ignore `.bash_extras`, `.DS_Store` crap files :shakingfist:, and leiningen stuff.

## `ruby`

### `.irbrc`

Turns on completion, which is amazing. Also changes the prompt to the simple version, which is way better. Stores a history in a file, uses deadline, and uses auto indent (which means in blocks it’s indented which is cool). It also uses a constant to know if it’s been loaded before so it only ever runs once, which I had never thought of until I saw this online somewhere years ago (sorry, I forgot where).

## Leiningen

### `.lein/profiles.clj`

Enables a plugin to provide the `nrepl` so `vim-fireplace` can connect to it.

## `nginx`

### `.nginx/pow.conf`

If you want SSL with `pow` or to use both `pow` and `nginx`, then this will proxy all `.dev` domains over to the `pow` port.

### `com.myobie.nginx.firewall.plist`

This will setup a firewall rule to proxy 80 -> 8080 and 443 -> 8443 so `nginx` can run without `sudo`. This file can be added to `launchd` with `launchctl load ~/com.myobie.nginx.firewall.plist`. I don’t use it anymore (I just use `pow`), but I keep it around just in case.

## `tmux`

### `.tmux.conf`

I like to split horizontally with `|` and vertically with `-`. It makes more sense to me. I also added `vim`-like bindings for moving between windows (hjkl). And I finally got the mouse scrolling to work, so I can enable scroll mode and actually go back in time to find something.

## `ack`

### `.ackrc`

For colors, setting up some file types, etc.

## TODO

* Install `brew` and `rbenv` in `install.rb`
* Find a way to list out what `brew` packages need to be installed and then install them in `install.rb`
* Install common gems or npm libraries that I use a lot in `install.rb`