#!/usr/bin/env ruby

require_relative 'support'

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
