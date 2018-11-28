require "pathname"
require "shellwords"
require "optparse"
require "fileutils"
require "open3"

OptionParser.new do |opts|
  opts.banner = "Usage: .install.rb [options]"

  opts.on("-t", "--test", "Prints commands, but doesn't run them") do |v|
    $test = !!v
  end

  opts.on("-u", "--upgrade", "Upgrade any out of date packages") do |v|
    $upgrade = !!v
  end

  opts.on("--[no]-skip-brew", "Skip all brew related activities") do |v|
    $skip_brew = !!v
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

def path(where); Pathname.new(where) end
def expand(where); File.expand_path(where) end

$pwd = Pathname.pwd
$home = path(expand("~"))

def run(command)
  if $test
    puts "$ #{command}"
  else
    puts "$ #{command}"
    system command
  end
end

def basename(what); File.basename(what) end
def exists?(what); File.exists?(what) end
def dirname(what); File.dirname(what) end
def dir?(where); File.directory?(where) end

def installed?(what); success? "which #{Shellwords::escape(what)}" end
def success?(what); run(what) && ($test || $?.success?) end

def mkdir(where)
  puts "mkdir: #{where}"

  unless $test
    FileUtils.mkdir_p(where)
  end
end

def symlink(from, to)
  puts "symlink: #{from} → #{to}"

  unless $test
    File.symlink(from, to) unless exists?(to)
  end
end

def gather(file)
  File.read(expand($pwd.join(file)))
    .strip
    .lines
    .map(&:strip)
    .group_by { |line| !!/\s/.match(line) }
    .values
end

def gather!(file)
  gather(file).flatten.join(" ")
end

module Git
  def self.clone(repo, where); success? "cd #{where} && git clone #{repo}" end
  def self.update(where); success? "cd #{where} && git reset --hard HEAD && git pull --rebase" end
end
def get; Git end

module Brew
  def self.install(what); success?("brew install #{what}") end
  def self.upgrade(what); success?("brew upgrade #{what}") end
  def self.restart(what); success?("brew services restart #{what}") end
end
def brew; Brew end

module Yarn
  def self.add(what); success? "yarn global add #{what}" end
  def self.upgrade(what); success? "yarn global upgrade #{what}" end
end
def yarn; Yarn end

module NPM
  def self.install(what); success? "npm install -g #{what}" end
  def self.upgrade(what); success? "npm upgrade -g #{what}" end
end
def npm; NPM end

module Rbenv
  def self.setup(version)
    versions = `ruby-build --definitions`
      .strip
      .lines
      .map(&:strip)

    version = Regexp.new(
      "^#{version.gsub(/\./, "\\.").gsub(/x/, "?.")}$"
    )

    latest_version = versions.grep(version).last

    [
      install(latest_version),
      global(latest_version)
    ].all?
  end

  def self.install(version); success? "rbenv install -s #{version}" end
  def self.global(version); success? "rbenv global #{version}" end
end
def rbenv; Rbenv end

module Gem
  def self.bin; `rbenv which gem`.chomp end
  def self.install(what); success? "#{bin} install #{what}" end
  def self.update(what); success? "#{bin} update #{what}" end
end
def gem; Gem end

module Plug
  def self.url
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  end

  def self.flags
    "#fLo"
  end

  def self.update_self
    success? "curl -#{flags} ~/.config/nvim/autoload/plug.vim --create-dirs #{url}"
  end

  def self.install; success? 'nvim +PlugInstall +qall' end
  def self.update; success? 'nvim +PlugUpdate +qall' end
end
def plug; Plug end

