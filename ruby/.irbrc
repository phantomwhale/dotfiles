#!/usr/bin/ruby
require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{Dir.home}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:USE_AUTOCOMPLETE] = false # readline disables this already

begin
  $LOAD_PATH << '/Users/ben/.local/share/mise/installs/ruby/3.4.6/lib/ruby/gems/3.4.0/gems/awesome_print-1.9.2/lib/'
  require 'awesome_print'
  AwesomePrint.irb!
  puts "awesome_print enabled"
rescue LoadError => e
  puts "awesome_print not available"
end
