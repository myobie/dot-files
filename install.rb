require 'pathname'

def run_cmd(what)
  puts what
  `#{what}`
end

# typing sucks
def force?; ARGV.include?("force"); end

def path(where); Pathname.new(where).realpath; end
def mkdir(where); run_cmd "mkdir -p #{where}"; end
def git(repo, where = nil); run_cmd("cd #{where || pwd} && git clone #{repo}"); end
def update(where); run_cmd("cd #{where} && git reset --hard HEAD && git pull --rebase"); end
def symlink(from, to)
  opts = if force? then "sf" else "si" end
  cmd = "ln -#{opts} #{from} #{to}"
  run_cmd cmd
end

# paths
this_file = Pathname.new(__FILE__)
pwd = Pathname.pwd
home = path(File.expand_path("~"))
dot_vim = home.join(".vim")
vundle = dot_vim.join("bundle/vundle")

# symlink files
Dir["{*,.*}"].each do |file|
  file = path(file)
  unless file.directory? || file == this_file
    symlink pwd.join(file), home.join(File.basename(file))
  end
end

# .vim
mkdir dot_vim.join("backup")
mkdir dot_vim.join("bundle")

unless vundle.exist?
  git "git://github.com/gmarik/vundle.git", vundle
end

update vundle

symlink pwd.join(".vim"), dot_vim
