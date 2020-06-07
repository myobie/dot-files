#!/usr/bin/env ruby

require_relative 'support'

mkdir $home.join(".vim").join("backup")

# vim-plug
plug.update_self

if $upgrade
  plug.update
else
  plug.install
end

# spelling related stuff
run %q[vim "+set spell" +spelldump +2,2d "+sav! /tmp/spelldump.txt" +qall]
run %q[sed -i '' -e $'1s;^;/encoding=utf-8\\\\\n;' /tmp/spelldump.txt]

spell_dir = $home.join(".vim").join("spell")
spell_file = spell_dir.join("en.utf-8.add")

mkdir spell_dir
run %Q[cat /tmp/spelldump.txt | sed "s/'/’/g" > #{spell_file}]
run %Q[vim "+mkspell! #{spell_file}" +qall]

run "rm /tmp/spelldump.txt"

# configure vim-rhubarb
netrc = Pathname.new("~/.netrc").expand_path
run "touch #{netrc}"
netrc_contents = netrc.read

if netrc.each_line.grep("api.github.com").empty?
  hub_config_path = Pathname.new("~/.config/hub").expand_path

  unless File.exist?(hub_config_path)
    puts "Please authenticate hub"
    system "hub api user"
  end

  hub_config = read_yaml(hub_config_path)
  token = hub_config["github.com"].find { |i| i["user"] == "myobie" }["oauth_token"]

  prepend_file(netrc, <<~EOF)
                 machine api.github.com
                   login myobie
                   password #{token}
               EOF
end
