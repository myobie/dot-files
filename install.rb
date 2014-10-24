require 'pathname'

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

# paths
pwd = Pathname.pwd
home = path(expand("~"))

# test
def check?(check); [path(".git"), path("."), path(".."), path(__FILE__)].any? {|t| t==check} end

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
vundle  = bundle.join("vundle")

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
