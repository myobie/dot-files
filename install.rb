require 'pathname'

def run_cmd(what)
  puts what
  `#{what}`
end

# typing sucks
def path(where); Pathname.new(where); end
def mkdir(where); run_cmd "mkdir -p #{where}"; end
def git(repo, where); run_cmd("cd #{where} && git clone #{repo}"); end
def update(where); run_cmd("cd #{where} && git reset --hard HEAD && git pull --rebase"); end
def symlink(from, to); run_cmd "ln -si #{from} #{to}"; end

# paths
this_file = Pathname.new(__FILE__)
pwd = Pathname.pwd
home = path(File.expand_path("~"))

# symlink files
Dir["{*,.*}"].each do |file|
  file = path(file)
  unless file.directory? || file == this_file
    symlink pwd.join(file), home.join(File.basename(file))
  end
end

# .vim
dot_vim = home.join(".vim")
bundle = dot_vim.join("bundle")
backup = dot_vim.join("backup")
vundle = bundle.join("vundle")

mkdir bundle
mkdir backup

# vundle
system "vim +PluginInstall +qall"

# command-t
if ARGV.include?("command-t")
  run_cmd "
    cd ~/.vim/bundle/command-t/ruby/command-t
    rbenv local system
    brew uninstall macvim
    brew install macvim --override-system-vim
    ruby extconf.rb
    make clean
    make
  "
  exit
end

