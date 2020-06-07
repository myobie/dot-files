#!/usr/bin/env ruby

require_relative 'support'

require_relative 'install_bash'

run "chsh -s /bin/bash"

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

require_relative 'install_dots'
require_relative 'install_elixir'

# npm
if $upgrade
  npm.upgrade gather!("npm-list")
else
  npm.install gather!("npm-list")
end

# go things
run "GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt"

# ruby
rbenv.setup "2.7.x"

gem_list = gather!("gem-list")
if $upgrade
  gem.update gem_list
else
  gem.install gem_list
end

# rust
system "rustup-init -y --no-modify-path"

# services
brew.restart "postgresql"
brew.restart "redis"

# git lfs
run "git lfs install --system"

require_relative 'install_vim'
