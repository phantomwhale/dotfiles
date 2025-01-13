#!/usr/bin/ruby
require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV.fetch('HOME', nil)}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:USE_AUTOCOMPLETE] = false # readline disables this already
