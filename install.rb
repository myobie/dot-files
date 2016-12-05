require_relative 'support'

# brew
unless installed?("brew")
  run 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
end

if $upgrade
  list = gather("brew-list").flatten.map { |item| item.split(" ").first }
  brew.upgrade list
else
  easy, individual = gather("brew-list")

  brew.install easy.join(" ")

  individual.map { |item| brew.install item }
end

# bash
symlink $pwd.join("bash", "profile"), $home.join(".bash_profile")

# npm
if $upgrade
  npm.update
else
  npm.install gather!("npm-list")
end

# ruby
rbenv.setup "2.3.x"

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

# vim-plug
plug.update_self

if $upgrade
  plug.update
else
  plug.install
end

