#!/usr/bin/env ruby

require_relative 'support'

symlink $pwd.join("bash", "profile"), $home.join(".bash_profile")
symlink $pwd.join("bash", "rc"), $home.join(".bashrc")
