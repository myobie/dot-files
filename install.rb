require 'pathname'
require 'shellwords'

def run(command)
  puts "$ #{command}"
  system command
end

# typing sucks
def expand(where); File.expand_path(where) end
def path(where); Pathname.new(where) end
def mkdir(where); run "mkdir -p #{where}" end
def git(repo, where); run "cd #{where} && git clone #{repo}" end
def update(where); run "cd #{where} && git reset --hard HEAD && git pull --rebase" end
def dir?(where); File.directory?(where) end
def symlink(from, to); run "ln -si #{from} #{to}" unless dir?(to) end
def installed?(what); success?("which #{Shellwords::escape(what)}") end
def success?(what); run(what)&& $?.success? end

# paths
pwd = Pathname.pwd
home = path(expand("~"))

# test
def check?(check); [path("README.md"), path(".git"), path("."), path(".."), path(__FILE__)].any? {|t| t==check} end

# brew
unless installed?("brew")
  run 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
end

# install hub and git
unless success?("brew doctor") || ARGV.include?("skip-brew-doctor")
  exit 1
end

run "brew update"
run "brew install tidy-html5 bash-completion hub git rbenv ruby-build node tree wget watch tmux"
run "npm install -g standard"

# symlink files
Dir["{*,.*}"].each do |file|
  file = path(file)
  current = pwd.join(file)
  basename = File.basename(file)
  result = home.join(basename)

  unless check?(file)
    symlink current, result
  end
end

# .vim
dot_vim = home.join(".vim")
bundle  = dot_vim.join("bundle")
backup  = dot_vim.join("backup")

mkdir bundle
mkdir backup

# vundle
run "vim +PluginInstall +qall"

# command-t
if ARGV.include?("command-t")
  run "
    cd ~/.vim/bundle/command-t/ruby/command-t
    rbenv local system
    brew uninstall macvim
    brew install macvim --override-system-vim
    ruby extconf.rb
    make clean
    make
  "
end

# ruby 2
run "rbenv install 2.3.3"
run "rbenv global 2.3.3"
