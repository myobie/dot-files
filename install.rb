#!/usr/bin/env ruby

require_relative 'support'

# brew
unless installed?("brew")
  run 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
end

if $upgrade
  list = gather("brew-list").flatten.map { |item| item.split(" ").first }
  brew.upgrade list.join(" ")
else
  easy, individual = gather("brew-list")

  brew.install easy.join(" ")

  if individual
    individual.map { |item| brew.install item }
  end
end

# elixir
if $upgrade
  run "mix local.hex --force"
else
  run "mix local.hex --if-missing"
end

# bash
symlink $pwd.join("bash", "profile"), $home.join(".bash_profile")
symlink $pwd.join("bash", "rc"), $home.join(".bashrc")

# npm
if $upgrade
  npm.upgrade gather!("npm-list")
else
  npm.install gather!("npm-list")
end

# ruby
rbenv.setup "2.5.x"

gem_list = gather!("gem-list")
if $upgrade
  gem.update gem_list
else
  gem.install gem_list
end

# symlink ~ files
Dir["dots/*"].each do |file|
  from = $pwd.join(file)
  to = $home.join(".#{basename(file)}")

  symlink from, to
end

mkdir $home.join(".ssh")
symlink $pwd.join("ssh/config"), $home.join(".ssh/config")

# symlink ~/.config files
cpath = expand("~/.config")
mkdir path(cpath).join("nvim", "backup")

Dir["config/*/**"].each do |file|
  next if dir? file

  from = $pwd.join(file)
  to = $home.join(".#{file}")

  mkdir dirname(to)
  symlink from, to
end

# services
brew.restart "postgresql"
brew.restart "redis"

# git lfs
run "git lfs install"

# vim-plug
plug.update_self

if $upgrade
  plug.update
else
  plug.install
end

# neovim needs python support
run "pip3 install --upgrade pip"
run "pip3 install neovim"
run "pip2 install --upgrade pip"
run "pip2 install neovim"

