#!/usr/bin/env ruby

require_relative 'support'

run "echo /bin/bash | sudo tee -a /etc/shells"
run "echo /usr/local/bin/bash | sudo tee -a /etc/shells"
run "echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells"

if exists?("/usr/local/bin/bash")
  run "chsh -s /usr/local/bin/bash"
if exists?("/opt/homebrew/bin/bash")
  run "chsh -s /opt/homebrew/bin/bash"
else
  run "chsh -s /bin/bash"
end

puts "**"
puts "** Be sure to use the shebang #!/usr/bin/env bash"
puts "**"

symlink $pwd.join("bash", "profile"), $home.join(".bash_profile")
symlink $pwd.join("bash", "rc"), $home.join(".bashrc")
