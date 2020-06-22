#!/usr/bin/env ruby

require_relative 'support'

run "echo /usr/local/bin/bash | sudo tee -a /etc/shells"
run "chsh -s /usr/local/bin/bash"

puts "**"
puts "** Be sure to use the shebang #!/usr/bin/env bash"
puts "**"

symlink $pwd.join("bash", "profile"), $home.join(".bash_profile")
symlink $pwd.join("bash", "rc"), $home.join(".bashrc")
