# myobie’s .dot-files

## `./install.sh`

This is what I use when I setup a new computer.

It basically:

1. symlinks important files
2. Installs elixir, postgres, etc

## `hx`

I use helix now instead of `vim` and I couldn't be happier. I used to have a huge `vim` setup and now I have a very slim `hx` setup.

#### Related

* I use SF Mono as my typeface. There still is no better programmer font and it’s already installed. (It’s important to me that the * is in the middle and not superscript.)

## bash

I use `bash`. Sorry, but I just don’t think `zsh` is that much better and `bash` is installed everywhere.

### `.bash_extras`

This file is in `.gitignore` because this is where you put `env` vars or other functions that shouldn’t be public. Like your AWS credentials or what have you. This has worked out great and has kept me from accidentally sharing my credentials for all my stuffs.

## `git`

### `.gitconfig`

Has my name and email (which match what’s on GitHub so my commits are linked to my account), that I want to use colors, that I want to use the OS X keychain to store any credentials, what my github username is (for `hub`), that I want to use my personal heroku account by default (it’s possible to have multiple accounts), and that I like [simple pushes](https://www.youtube.com/watch?v=cMBh8P1m9Wo).

### `.gitignore`

Ignore `.bash_extras`, `.DS_Store` crap files :shakingfist:, etc.
