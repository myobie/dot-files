Dir["{*,.*}"].each do |file|
  unless File.directory?(file) || file == __FILE__
    cmd = "ln -sf #{Dir.pwd}/#{file} #{File.expand_path("~")}/#{File.basename(file)}"
    puts cmd
    `#{cmd}`
  end
end
