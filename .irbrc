unless defined? ETC_IRBRC_LOADED
  require 'irb/completion'

  IRB.conf[:PROMPT_MODE] = :SIMPLE if IRB.conf[:PROMPT_MODE] == :DEFAULT

  require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

  IRB.conf[:USE_READLINE] = true
  IRB.conf[:AUTO_INDENT] = true

  ETC_IRBRC_LOADED = true
end
