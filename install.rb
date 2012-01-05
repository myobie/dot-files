def run_cmd(what)
  puts what
  `#{what}`
end

home = File.expand_path("~")

Dir["{*,.*}"].each do |file|
  unless File.directory?(file) || file == __FILE__
    cmd = "ln -si #{Dir.pwd}/#{file} #{home}/#{File.basename(file)}"
    run_cmd cmd
  end
end

vim_cmd = "ln -si #{Dir.pwd}/.vim #{home}/"
run_cmd vim_cmd
