#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:USE_AUTOCOMPLETE] = false # readline disables this already
