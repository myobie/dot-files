#!/usr/bin/env ruby

require_relative 'support'

if $upgrade
  run "echo 'Y' | mix local.hex --force"
else
  run "echo 'Y' | mix local.hex --if-missing"
end

