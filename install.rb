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
  run "echo 'Y' | mix local.hex --force"
else
  run "echo 'Y' | mix local.hex --if-missing"
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

# go things
run "GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt"

# ruby
rbenv.setup "2.6.x"

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

# gpg config
Dir["gnupg/*"].each do |file|
  next if dir? file

  from = $pwd.join(file)
  to = $home.join(".#{file}")

  mkdir dirname(to)
  symlink from, to
end

# symlink ~/.config files
cpath = expand("~/.config")

Dir["config/*/**"].each do |file|
  next if dir? file

  from = $pwd.join(file)
  to = $home.join(".#{file}")

  mkdir dirname(to)
  symlink from, to
end

# vim
mkdir $home.join(".vim").join("backup")

# services
brew.restart "postgresql"
brew.restart "redis"

# git lfs
run "git lfs install --system"

# vim-plug
plug.update_self

if $upgrade
  plug.update
else
  plug.install
end

# configure vim-rhubarb
netrc = Pathname.new("~/.netrc").expand_path
netrc_contents = netrc.read

if netrc.each_line.grep("api.github.com").empty?
  hub_config_path = Pathname.new("~/.config/hub").expand_path

  unless File.exist?(hub_config_path)
    puts "Please authenticate hub"
    system "hub api user"
  end

  hub_config = read_yaml(hub_config_path)
  token = hub_config["github.com"].find { |i| i["user"] == "myobie" }["oauth_token"]

  prepend_file(netrc, <<~EOF)
                 machine api.github.com
                   login myobie
                   password #{token}
               EOF
end
