def run_cmd(what)
  puts what
  `#{what}`
end

home = File.expand_path("~")

Dir["{*,.*}"].each do |file|
  unless File.directory?(file) || file == __FILE__
    cmd = "ln -sf #{Dir.pwd}/#{file} #{home}/#{File.basename(file)}"
    run_cmd cmd
  end
end

vim_cmd = "ln -sf #{Dir.pwd}/.vim #{home}/.vim"
run_cmd vim_cmd
